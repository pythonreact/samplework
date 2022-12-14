import { configureStore } from '@reduxjs/toolkit';






import dataReducer from './datalistSlices/DataSlice';
import modalReducer from './datalistSlices/ModalSlice';
import sortingReducer from './datalistSlices/SortingSlice';
import filteringReducer from './datalistSlices/FilteringSlice';
import effectReducer from './datalistSlices/EffectSlice';
import tableReducer from './datalistSlices/TableSlice';
import chartReducer from './datalistSlices/ChartSlice';
import authReducer from './datalistSlices/AuthSlice';
import appReducer from './appSlices/AppSlice';



export const store = configureStore({
    reducer: {
        data: dataReducer, modal: modalReducer, sorting: sortingReducer,
        filtering: filteringReducer, effect: effectReducer, table: tableReducer, chart: chartReducer, auth: authReducer,
        app: appReducer
    }
});



export type RootState = ReturnType<typeof store.getState>
export type AppDispatch = typeof store.dispatch



