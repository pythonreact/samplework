import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import type { Covids } from './DataSlice';




export interface ChartState {
    dataLabel: string[];
    dataValue: number[][];
    dataSource: string[];
    chartType: string;
    dataChart: Covids[];
    chartLabel: boolean;
    timeMin: string;
    timeMax: string;
    isDataFromDatalist: boolean;
}


const initialState: ChartState = {
    dataLabel: [],
    dataValue: [[]],
    dataSource: [],
    chartType: 'line',
    dataChart: [],
    chartLabel: true,
    timeMin: '',
    timeMax: '',
    isDataFromDatalist: false
};

const chartSlice = createSlice({
    name: 'chart',
    initialState,
    reducers: {
        setDataLabel(state, action: PayloadAction<string[]>) {
            state.dataLabel = action.payload;
        },
        setDataValue(state, action: PayloadAction<number[][]>) {
            state.dataValue = action.payload;
        },
        setDataSource(state, action: PayloadAction<string[]>) {
            state.dataSource = action.payload;
        },
        setChartType(state, action: PayloadAction<string>) {
            state.chartType = action.payload;
        },
        setDataChart(state, action: PayloadAction<Covids[]>) {
            state.dataChart = action.payload;
        },
        setChartLabel(state, action: PayloadAction<boolean>) {
            state.chartLabel = action.payload;
        },
        setTimeMin(state, action: PayloadAction<string>) {
            state.timeMin = action.payload;
        },
        setTimeMax(state, action: PayloadAction<string>) {
            state.timeMax = action.payload;
        },
        setIsDataFromDatalist(state, action: PayloadAction<boolean>) {
            state.isDataFromDatalist = action.payload;
        }
    }
});

export const chartActions = chartSlice.actions;
export default chartSlice.reducer;




