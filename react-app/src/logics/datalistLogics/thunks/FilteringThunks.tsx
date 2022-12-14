import { useReduxDispatch, useReduxSelector } from '../../../store/ReduxTypes';
import { dataActions } from '../../../store/datalistSlices/DataSlice';
import { modalActions } from '../../../store/datalistSlices/ModalSlice';
import { filteringActions } from '../../../store/datalistSlices/FilteringSlice';
import { useModalThunks } from './ModalThunks';
import { setYear, setMonth, setDay } from '../Logics';
import { envFilterElements } from '../../../store/datalistSlices/FilteringSlice';
import type { Covids } from '../../../store/datalistSlices/DataSlice';
import type { ItemsFilters } from '../../../store/datalistSlices/FilteringSlice';



export const useFilteringThunks = () => {
    const dispatch = useReduxDispatch();
    const { hideModalHandler, showModalHandler } = useModalThunks();

    const covids = useReduxSelector(state => state.data.covids);
    const covidsWithoutFilter = useReduxSelector(state => state.data.covidsWithoutFilter);
    const isOnlySelected = useReduxSelector(state => state.filtering.isOnlySelected);
    const selectedData = useReduxSelector(state => state.table.selectedData);
    const filters = useReduxSelector(state => state.filtering.filters);
    const filtersCopy = useReduxSelector(state => state.filtering.filtersCopy);
    const filterActive = useReduxSelector(state => state.filtering.filterActive);


    // Copy filters to filtersCopy array when close filters modal
    const deleteFiltersCopy = () => {
        let filtered = filters.map(item => {
            return { ...item }
        })
        dispatch(filteringActions.setFiltersCopy(filtered));
    };


    // Submit Filter button click
    const submitFiltersHandler = () => {
        let count = 0;
        dispatch(filteringActions.setFilters(filtersCopy.map(item => {
            if (item.min || item.max) count += 1;
            return { ...item }
        }))
        );
        dispatch(filteringActions.setFilterActive(count));
        dispatch(filteringActions.setIsFiltering(true));
        hideModalHandler('refModalFiltering');
    };


    // Delete All Filters button click
    const deleteAllFiltersHandler = (isFromModal: boolean) => {
        if (filterActive !== 0 || isOnlySelected) {
            let array = envFilterElements;
            dispatch(filteringActions.setFiltersCopy(array));
            if (isFromModal) { dispatch(modalActions.setIsRefreshModal(true)) }
            else {
                dispatch(filteringActions.setIsOnlySelected(false));
                dispatch(filteringActions.setFilters(array));
                dispatch(filteringActions.setIsFiltering(true));
            }
        } else {
            dispatch(modalActions.setNote("Filter is not selected!"));
            showModalHandler('refNoteModal');
        }
    };


    // Filter Only Selected button click
    const onlySelectedHandler = (eTarget: EventTarget & HTMLInputElement) => {
        if (eTarget.checked && selectedData.length === 0 && !isOnlySelected) {
            dispatch(filteringActions.setIsOnlySelected(false));
            dispatch(modalActions.setNote("Data is not selected!"));
            showModalHandler('refNoteModal');
        }
        else {
            dispatch(filteringActions.setIsOnlySelected(!isOnlySelected));
            if (eTarget.checked) {
                let newarray: Covids[] = [];
                selectedData.map((item) => {
                    newarray = newarray.concat(covids.filter(dataItem => dataItem.id === item));
                    return newarray
                })
                dispatch(dataActions.setCovids(newarray));
            } else {
                if (filterActive) {
                    dispatch(filteringActions.setIsFiltering(true));
                }
                else { dispatch(dataActions.setCovids(covidsWithoutFilter)); }
            }
        }
    };


    // Set input field in filters array
    const Item = (filterField: keyof ItemsFilters, index: string, fieldType: string, eTargetValue?: string) => {
        let newarray = filtersCopy.map((item) => {
            if (item.id === index) {
                return {
                    ...item, [filterField]:
                        fieldType === "year" ? setYear(item[filterField] as string, eTargetValue as string)
                            : (fieldType === "month" ? setMonth(item[filterField] as string, eTargetValue as string)
                                : (fieldType === "day" ? setDay(item[filterField] as string, eTargetValue as string)
                                    : (fieldType === "select" || fieldType === "input" ? eTargetValue?.toString()
                                        : (fieldType === "delete" ? ""
                                            : null)
                                    )
                                )
                            )
                };
            } else { return item; }

        });
        dispatch(filteringActions.setFiltersCopy(newarray));
    };


    // Set filter type: input, select, dateselect and notequal switch in filters array
    const itemListType = (listtype: string, value: string | boolean, index: string) => {
        let newarray = filtersCopy.map((item) => {
            if (item.id === index) {
                return { ...item, [listtype]: value };
            } else {
                return item;
            }
        });
        dispatch(filteringActions.setFiltersCopy(newarray));
    };

    return { deleteFiltersCopy, submitFiltersHandler, deleteAllFiltersHandler, onlySelectedHandler, Item, itemListType };

};




