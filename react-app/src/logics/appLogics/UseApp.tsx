import { useEffect } from 'react';
import { useReduxDispatch, useReduxSelector } from '../../store/ReduxTypes';
import { appActions } from '../../store/appSlices/AppSlice';
import { useAudio } from './UseAudio'



export const useApp = () => {
    const dispatch = useReduxDispatch();

    const { music, ShowFooter } = useAudio();



    const datalistClickHandler = () => {
        dispatch(appActions.setIsRasterShown(false));
        dispatch(appActions.setIsDatalistPath(true));
        dispatch(appActions.setSong('songDataList'));
        music(false);
    }

    const Footer = () => {
        useEffect(() => {
            const timer = setTimeout(() => {
                dispatch(appActions.setIsFooterShown(true));
            }, 0); //5000
            return () => clearTimeout(timer);
        }, []);

        return useReduxSelector(state => state.app.isFooterShown) ? ShowFooter() : null;
    }


    return { datalistClickHandler, Footer };
};
