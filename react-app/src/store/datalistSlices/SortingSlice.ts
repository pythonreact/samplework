import { createSlice, PayloadAction } from '@reduxjs/toolkit';








export interface ItemsSorts {
    id: string;
    sortfield: string;
    sorttype: string;
    colorprop: string;
};

export const envSortsElements: ItemsSorts[] = JSON.parse(process.env.REACT_APP_SORTS_ELEMENTS as string);


interface SortingState {
    isSorting: boolean;
    sorts: ItemsSorts[];
    sortsCopy: ItemsSorts[];
    sortActive: number;
}


const initialState: SortingState = {
    isSorting: false,
    sorts: envSortsElements,
    sortsCopy: envSortsElements,
    sortActive: 1
};


const sortingSlice = createSlice({
    name: 'sorting',
    initialState,
    reducers: {
        setIsSorting(state, action: PayloadAction<boolean>) {
            state.isSorting = action.payload;
        },
        setSorts(state, action: PayloadAction<ItemsSorts[]>) {
            state.sorts = action.payload;
        },
        setSortsCopy(state, action: PayloadAction<ItemsSorts[]>) {
            state.sortsCopy = action.payload;
        },
        setSortActive(state, action: PayloadAction<number>) {
            state.sortActive = action.payload;
        }
    }
});

export const sortingActions = sortingSlice.actions;
export default sortingSlice.reducer;


