import { createSlice, PayloadAction } from '@reduxjs/toolkit';



interface EffectState {
    isRaster: boolean;
    isScroll: boolean;
    isSwing: boolean;
    isFlip: boolean;
    isModalEffect: boolean;
    isEarthEffect: boolean;
    isCubeEffect: boolean;
    isChartEffect: boolean;
    isEffects: boolean;
}



const initialState: EffectState = {
    isRaster: true,
    isScroll: true,
    isSwing: true,
    isFlip: true,
    isModalEffect: true,
    isEarthEffect: true,
    isCubeEffect: true,
    isChartEffect: true,
    isEffects: true,
};



const effectSlice = createSlice({
    name: 'effect',
    initialState,
    reducers: {
        setIsRaster(state, action: PayloadAction<boolean>) {
            state.isRaster = action.payload;
        },
        setIsScroll(state, action: PayloadAction<boolean>) {
            state.isScroll = action.payload;
        },
        setIsSwing(state, action: PayloadAction<boolean>) {
            state.isSwing = action.payload;
        },
        setIsFlip(state, action: PayloadAction<boolean>) {
            state.isFlip = action.payload;
        },
        setIsModalEffect(state, action: PayloadAction<boolean>) {
            state.isModalEffect = action.payload;
        },
        setIsEarthEffect(state, action: PayloadAction<boolean>) {
            state.isEarthEffect = action.payload;
        },
        setIsCubeEffect(state, action: PayloadAction<boolean>) {
            state.isCubeEffect = action.payload;
        },
        setIsChartEffect(state, action: PayloadAction<boolean>) {
            state.isChartEffect = action.payload;
        },
        setIsEffects(state, action: PayloadAction<boolean>) {
            state.isEffects = action.payload;
        }
    }
});

export const effectActions = effectSlice.actions;
export default effectSlice.reducer;