import { useReduxDispatch, useReduxSelector } from '../../../store/ReduxTypes';
import { ItemsSorts, sortingActions } from '../../../store/datalistSlices/SortingSlice';
import { useModalThunks } from './ModalThunks';






export interface SortElements {
    id: string;
    colorprop1: string;
    sortfield1: string;
    sorttype1: string;
    colorprop2: string;
    sortfield2: string;
    sorttype2: string;
};

export const envTableHeaderSortElements: SortElements[] = JSON.parse(process.env.REACT_APP_TABLEHEADER_SORT_ELEMENTS as string);


export const useSortingThunks = () => {
    const dispatch = useReduxDispatch();
    const { hideModalHandler } = useModalThunks();

    const sorts = useReduxSelector(state => state.sorting.sorts);
    const sortsCopy = useReduxSelector(state => state.sorting.sortsCopy);


    // Copy sorts to sortsCopy array when close sorting modal
    const deleteSortsCopy = () => {
        let array = [...sorts];
        dispatch(sortingActions.setSortsCopy(array));
    };


    // Submit Sorting button click
    const submitSortingHandler = () => {
        let count = 0;
        let array = sortsCopy.map(item => {
            if (item.sortfield && item.sorttype) {
                count += 1;
                const filter1 = envTableHeaderSortElements.filter((data) => {
                    return data['sortfield1'] === item.sortfield && data['sorttype1'] === item.sorttype;
                });
                const filter2 = envTableHeaderSortElements.filter((data) => {
                    return data['sortfield2'] === item.sortfield && data['sorttype2'] === item.sorttype;
                });
                const colorprop = filter1.length !== 0 ? filter1[0].colorprop1 : filter2[0].colorprop2;

                return { ...item, "colorprop": colorprop }

            } else {
                return {
                    ...item,
                    "colorprop": '',
                    "sortfield": '',
                    "sorttype": ''
                };
            }
        });
        dispatch(sortingActions.setSortActive(count));
        dispatch(sortingActions.setSortsCopy(array));
        dispatch(sortingActions.setSorts(array));
        dispatch(sortingActions.setIsSorting(true));
        hideModalHandler('refModalSorting');
    };


    // Set sort fields in sorts array
    const itemSorts = (index: string, fieldType: string, sortField?: keyof ItemsSorts, eTargetValue?: string) => {
        let array = sortsCopy.map((item) => {
            if (item.id === index) {
                if (fieldType === "select") {
                    return {
                        ...item,
                        [sortField as keyof ItemsSorts]: eTargetValue?.toString()
                    }
                } else {
                    return {
                        ...item,
                        "sortfield": "",
                        "sorttype": "",
                        "colorprop": ""
                    };
                }
            } else { return item; }
        });
        dispatch(sortingActions.setSortsCopy(array));
    };



    return { deleteSortsCopy, submitSortingHandler, itemSorts };

};
