import { createSlice, PayloadAction } from '@reduxjs/toolkit';





export interface ItemsFilters {
    id: string;
    min: string;
    max: string;
    fieldname: string;
    type: string;
    listtype: string;
    notequal: boolean;
};

export const envFilterElements: ItemsFilters[] = JSON.parse(process.env.REACT_APP_FILTER_ELEMENTS as string);


interface FilteringSate {
    isFiltering: boolean;
    filters: ItemsFilters[];
    filterActive: number;
    filtersCopy: ItemsFilters[];
    isOnlySelected: boolean;
}


const initialState: FilteringSate = {
    isFiltering: false,
    filters: envFilterElements,
    filterActive: 0,
    filtersCopy: envFilterElements,
    isOnlySelected: false
};


const filteringSlice = createSlice({
    name: 'filtering',
    initialState,
    reducers: {
        setIsFiltering(state, action: PayloadAction<boolean>) {
            state.isFiltering = action.payload;
        },
        setFilters(state, action: PayloadAction<ItemsFilters[]>) {
            state.filters = action.payload;
        },
        setFilterActive(state, action: PayloadAction<number>) {
            state.filterActive = action.payload;
        },
        setFiltersCopy(state, action: PayloadAction<ItemsFilters[]>) {
            state.filtersCopy = action.payload;
        },
        setIsOnlySelected(state, action: PayloadAction<boolean>) {
            state.isOnlySelected = action.payload;
        }
    }
});



export const filteringActions = filteringSlice.actions;
export default filteringSlice.reducer;
