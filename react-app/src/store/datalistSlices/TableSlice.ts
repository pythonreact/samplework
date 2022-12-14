import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import type { Covids } from './DataSlice';




interface TableState {
    isRefresh: boolean;
    isLoading: boolean;
    tableStyle: string;
    selectedData: string[],
    mapData: Covids,
    fetchXHR: string;
}

const initialState: TableState = {
    isRefresh: true,
    isLoading: false,
    tableStyle: 'table-scroll',
    selectedData: [],
    mapData: [][0],
    fetchXHR: 'auto'
};


const tableSlice = createSlice({
    name: 'other',
    initialState,
    reducers: {
        setIsRefresh(state, action: PayloadAction<boolean>) {
            state.isRefresh = action.payload;
        },
        setIsLoading(state, action: PayloadAction<boolean>) {
            state.isLoading = action.payload;
        },
        setTableStyle(state, action: PayloadAction<string>) {
            state.tableStyle = action.payload;
        },
        setSelectedData(state, action: PayloadAction<string[]>) {
            state.selectedData = action.payload;
        },
        setMapData(state, action: PayloadAction<Covids>) {
            state.mapData = action.payload;
        },
        setFetchXHR(state, action: PayloadAction<string>) {
            state.fetchXHR = action.payload;
        },

        // selectedHandler(state, action) {
        //     const { checked, index } = action.payload;
        //     if (checked) {
        //         state.selectedData = [...state.selectedData, index];
        //     } else {
        //         let filtered = state.selectedData.filter(item => item !== index);
        //         state.selectedData = filtered;
        //     }
        // },
    }
});


// export const deSelectHandler = () => {
//     return (dispatch, getState) => {
//         const state = getState();
//         dispatch(tableActions.setSelectedData([]));
//         if (state.isOnlySelected) {
//             dispatch(filteringActions.setIsOnlySelected(false));
//             if (state.filterActive) {
//                 dispatch(filteringActions.setIsFiltering(true));
//             }
//             else { dispatch(dataActions.setCovids(state.covidsWithoutFilter)); }
//         }
//     }
// };


export const tableActions = tableSlice.actions;
export default tableSlice.reducer;
