import { useEffect, useCallback, useRef } from 'react';
import { useAPI } from './UseAPI';
import { Modal } from 'bootstrap';

import { useReduxSelector, useReduxDispatch } from '../../store/ReduxTypes';
import { dataActions } from '../../store/datalistSlices/DataSlice';
import { modalActions } from '../../store/datalistSlices/ModalSlice';
import { sortingActions } from '../../store/datalistSlices/SortingSlice';
import { filteringActions } from '../../store/datalistSlices/FilteringSlice';
import { tableActions } from '../../store/datalistSlices/TableSlice';

import { useModalThunks } from './thunks/ModalThunks';
import { useTableThunks } from './thunks/TableThunks';
import { sortedDataField, filteredDataField } from './Logics';

import type { Covids } from '../../store/datalistSlices/DataSlice';



export const useDatalist = () => {
    const dispatch = useReduxDispatch();
    const { showModalHandler } = useModalThunks();
    const { dataMap } = useTableThunks();
    const { FileAPI } = useAPI();

    const isMounted = useRef(false);

    // Data const
    const covids = useReduxSelector(state => state.data.covids);
    const covidsWithoutFilter = useReduxSelector(state => state.data.covidsWithoutFilter);
    // Modal const
    const modalId = useReduxSelector(state => state.modal.modalId);
    const isOpenModal = useReduxSelector(state => state.modal.isOpenModal);
    const isCloseModal = useReduxSelector(state => state.modal.isCloseModal);
    const isRefreshModal = useReduxSelector(state => state.modal.isRefreshModal);
    // Sorting const
    const isSorting = useReduxSelector(state => state.sorting.isSorting);
    const sorts = useReduxSelector(state => state.sorting.sorts);
    // Filtering const
    const isFiltering = useReduxSelector(state => state.filtering.isFiltering);
    const filters = useReduxSelector(state => state.filtering.filters);
    // Table const
    const isRefresh = useReduxSelector(state => state.table.isRefresh);
    const fetchXHR = useReduxSelector(state => state.table.fetchXHR);



    const sorted = useCallback((array: Covids[], isInitial: boolean) => {
        return sortedDataField(array, isInitial, sorts);
    }, [sorts]);


    const filtered = useCallback((array: Covids[]) => {
        return filteredDataField(array, filters);
    }, [filters]);


    const dataMapped = useCallback((data: Covids[]) => {
        return dataMap(data);
    }, [dataMap]);


    // Loading from API
    const loadData = useCallback(() => {
        const envAPIURL = process.env.REACT_APP_API_URL;
        const response = FileAPI(fetchXHR, envAPIURL + 'datalist', 'GET', 'json');
        return response
    }, [fetchXHR, FileAPI]);


    // Load useEffect
    useEffect(() => {
        if (isRefresh === true) {
            //let mounted = true;
            isMounted.current = true;
            loadData().then(data => {
                if (isMounted.current) {
                    //if (mounted) {
                    dispatch(dataActions.setCovids(filtered(sorted(data, false))));
                    dispatch(dataActions.setCovidsWithoutFilter(sorted(data, false)));
                    dataMapped(data);
                    dispatch(tableActions.setIsRefresh(false));
                }
            })
                .catch(error => {
                    dispatch(modalActions.setNote(`Failed! ${error}`));
                    showModalHandler('refNoteModal');
                    dispatch(tableActions.setIsRefresh(false));
                });
            return () => {
                isMounted.current = false
            };
            // mounted = false;
        }
    }, [isRefresh, loadData, dispatch, showModalHandler, sorted, filtered, dataMapped]);


    // Sorting useEffect
    useEffect(() => {
        if (isSorting) {
            dispatch(dataActions.setCovids(sorted(covids, false)));
            dispatch(dataActions.setCovidsWithoutFilter(sorted(covidsWithoutFilter, false)));
            dispatch(sortingActions.setIsSorting(false));
        }
    }, [isSorting, covids, covidsWithoutFilter, dispatch, sorted]);


    // Filtering useEffect
    useEffect(() => {
        if (isFiltering) {
            dispatch(dataActions.setCovids(filtered(covidsWithoutFilter)));
            dispatch(filteringActions.setIsFiltering(false));
        }
    }, [isFiltering, covidsWithoutFilter, dispatch, filtered]);


    // Modal useEffect
    useEffect(() => {
        if (isRefreshModal) {
            const modal = Modal.getInstance(document.getElementById(modalId)!)!;
            modal.show();
            dispatch(modalActions.setIsRefreshModal(false));
        }
        else if (isOpenModal) {
            const modal = new Modal(document.getElementById(modalId)!, { backdrop: 'static', keyboard: false });
            modal.show();
            dispatch(modalActions.setIsOpenModal(false));
        }
        else if (isCloseModal) {
            const modal = Modal.getInstance(document.getElementById(modalId)!)!;
            modal.hide();
            dispatch(modalActions.setIsCloseModal(false));
        }
    }, [isOpenModal, isCloseModal, modalId, isRefreshModal, dispatch]);



};

