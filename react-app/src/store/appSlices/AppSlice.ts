import { createSlice, PayloadAction } from '@reduxjs/toolkit';



interface AppState {
    isTitle: boolean;
    isShowHeader: boolean;
    isRasterShown: boolean;
    isDatalistPath: boolean;
    isFooterShown: boolean;
    song: string;
    isCanvasDrawn: boolean;
}

const initialState: AppState = {
    isTitle: true,
    isShowHeader: false,
    isRasterShown: true,
    isDatalistPath: false,
    isFooterShown: false,
    song: '',
    isCanvasDrawn: false
};


const appSlice = createSlice({
    name: 'data',
    initialState,
    reducers: {
        setIsTitle(state, action: PayloadAction<boolean>) {
            state.isTitle = action.payload;
        },
        setIsShowHeader(state, action: PayloadAction<boolean>) {
            state.isShowHeader = action.payload;
        },

        setIsRasterShown(state, action: PayloadAction<boolean>) {
            state.isRasterShown = action.payload;
        },
        setIsDatalistPath(state, action: PayloadAction<boolean>) {
            state.isDatalistPath = action.payload;
        },
        setIsFooterShown(state, action: PayloadAction<boolean>) {
            state.isFooterShown = action.payload;
        },
        setSong(state, action: PayloadAction<string>) {
            state.song = action.payload;
        },
        setIsCanvasDrawn(state, action: PayloadAction<boolean>) {
            state.isCanvasDrawn = action.payload;
        }
    }
});


export const appActions = appSlice.actions;
export default appSlice.reducer;


