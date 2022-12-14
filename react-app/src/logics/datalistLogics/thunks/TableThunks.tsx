import { useReduxDispatch, useReduxSelector } from '../../../store/ReduxTypes';
import { Covids, dataActions } from '../../../store/datalistSlices/DataSlice';
import { filteringActions } from '../../../store/datalistSlices/FilteringSlice';
import { effectActions } from '../../../store/datalistSlices/EffectSlice';
import { tableActions } from '../../../store/datalistSlices/TableSlice';
import { modalActions } from '../../../store/datalistSlices/ModalSlice';
import { useModalThunks } from '../../datalistLogics/thunks/ModalThunks';
import { sortedDataField } from '../Logics';



export const useTableThunks = () => {
    const dispatch = useReduxDispatch();
    const { showModalHandler } = useModalThunks();
    const covidsWithoutFilter = useReduxSelector(state => state.data.covidsWithoutFilter);
    const isEffects = useReduxSelector(state => state.effect.isEffects);
    const selectedData = useReduxSelector(state => state.table.selectedData);
    const isOnlySelected = useReduxSelector(state => state.filtering.isOnlySelected);
    const filterActive = useReduxSelector(state => state.filtering.filterActive);
    const sorts = useReduxSelector(state => state.sorting.sorts);


    // Set Map Data
    const dataMap = (prop: Covids[]) => {
        const mapCovidData = sortedDataField(prop, true, sorts);
        const array = ([...mapCovidData][0]);
        dispatch(tableActions.setMapData(array));
    };


    const makeTableStyleHandler = (prop: string) => {
        dispatch(tableActions.setTableStyle(prop));
        if (prop === 'table-standard' && isEffects === true) {
            dispatch(effectActions.setIsEffects(false));
        } else if (prop === 'table-scroll') {
            dispatch(effectActions.setIsEffects(true));
        }
    };


    const makeFetchXHRHandler = (prop: string) => {
        dispatch(tableActions.setFetchXHR(prop));
    };


    const selectedHandler = (eTarget: EventTarget & HTMLInputElement, index: string) => {
        if (eTarget.checked) {
            let array = [...(selectedData), index];
            dispatch(tableActions.setSelectedData(array));
        } else {
            let filtered = (selectedData).filter(item => item !== index);
            let array = filtered;
            dispatch(tableActions.setSelectedData(array));
        }
    };


    // Deselect button click
    const deSelectHandler = () => {
        if (selectedData.length !== 0) {
            dispatch(tableActions.setSelectedData([]));
            if (isOnlySelected) {
                dispatch(filteringActions.setIsOnlySelected(false));
                if (filterActive) {
                    dispatch(filteringActions.setIsFiltering(true));
                }
                else { dispatch(dataActions.setCovids(covidsWithoutFilter)); }
            }
        } else {
            dispatch(modalActions.setNote("Data is not selected!"));
            showModalHandler('refNoteModal');
        }
    };


    return { dataMap, makeTableStyleHandler, makeFetchXHRHandler, selectedHandler, deSelectHandler };

};

