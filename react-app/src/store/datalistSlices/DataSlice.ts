import { createSlice, PayloadAction } from '@reduxjs/toolkit';




export interface Covids {
    id: string;
    date: string;
    time: string;
    infected: number;
    deceased: number;
    recovered: number;
    quarantined: number;
    tested: number;
    activeInfected: number;
    sourceWeb: string;
};


interface DataState extends Covids {
    covids: Covids[];
    covidsWithoutFilter: Covids[];
};



const initialState: DataState = {
    covids: [],
    covidsWithoutFilter: [],
    id: '',
    date: '',
    time: '',
    infected: 0,
    deceased: 0,
    recovered: 0,
    quarantined: 0,
    tested: 0,
    activeInfected: 0,
    sourceWeb: 'https://apify.com/tugkan/covid-hu'
};


const dataSlice = createSlice({
    name: 'data',
    initialState,
    reducers: {
        setCovids(state, action: PayloadAction<Covids[]>) {
            state.covids = action.payload;
        },
        setCovidsWithoutFilter(state, action: PayloadAction<Covids[]>) {
            state.covidsWithoutFilter = action.payload;
        },
        setId(state, action: PayloadAction<string>) {
            state.id = action.payload;
        },
        setDate(state, action: PayloadAction<string>) {
            state.date = action.payload;
        },
        setTime(state, action: PayloadAction<string>) {
            state.time = action.payload;
        },
        setInfected(state, action: PayloadAction<number>) {
            state.infected = action.payload;
        },
        setDeceased(state, action: PayloadAction<number>) {
            state.deceased = action.payload;
        },
        setRecovered(state, action: PayloadAction<number>) {
            state.recovered = action.payload;
        },
        setQuarantined(state, action: PayloadAction<number>) {
            state.quarantined = action.payload;
        },
        setTested(state, action: PayloadAction<number>) {
            state.tested = action.payload;
        },
        setActiveInfected(state, action: PayloadAction<number>) {
            state.activeInfected = action.payload;
        },
        setSourceWeb(state, action: PayloadAction<string>) {
            state.sourceWeb = action.payload;
        },
    }
});


export const dataActions = dataSlice.actions;
export default dataSlice.reducer;


