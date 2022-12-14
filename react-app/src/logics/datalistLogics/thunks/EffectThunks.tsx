import { useReduxDispatch } from '../../../store/ReduxTypes';
import { effectActions } from '../../../store/datalistSlices/EffectSlice';







export const useEffectThunks = () => {
    const dispatch = useReduxDispatch();


    const makeRasterEffectHandler = (prop: boolean) => {
        dispatch(effectActions.setIsRaster(prop));
    };


    const makeScrollEffectHandler = (prop: boolean) => {
        dispatch(effectActions.setIsScroll(prop));
    };


    const makeSwingEffectHandler = (prop: boolean) => {
        dispatch(effectActions.setIsSwing(prop));
    };


    const makeFlipEffectHandler = (prop: boolean) => {
        dispatch(effectActions.setIsFlip(prop));
    };


    const makeModalEffectHandler = (prop: boolean) => {
        dispatch(effectActions.setIsModalEffect(prop));
    };


    const makeEarthEffectHandler = (prop: boolean) => {
        dispatch(effectActions.setIsEarthEffect(prop));
    };


    const makeCubeEffectHandler = (prop: boolean) => {
        dispatch(effectActions.setIsCubeEffect(prop));
    };


    const makeChartEffectHandler = (prop: boolean) => {
        dispatch(effectActions.setIsChartEffect(prop));
    };


    return {
        makeChartEffectHandler, makeCubeEffectHandler, makeEarthEffectHandler, makeFlipEffectHandler, makeModalEffectHandler,
        makeRasterEffectHandler, makeScrollEffectHandler, makeSwingEffectHandler
    };

};

