import { useEffect, useMemo, useRef, Fragment, useState, useCallback } from 'react';
import { useReduxDispatch } from '../../store/ReduxTypes';
import songDataList from '../../music/02Sid.mp3';
import song1 from "../../music/01Sid.mp3";
import { useLocation } from 'react-router-dom';
import { appActions } from '../../store/appSlices/AppSlice';




export const useAudio = () => {
    const dispatch = useReduxDispatch();
    const location = useLocation();
    const [theNewSource, setTheNewSource] = useState(location.pathname !== '/datalist' ? song1 : songDataList);
    const isPlaying = useRef(true);
    const audio: HTMLAudioElement = useMemo(() => new Audio(theNewSource), [theNewSource]);



    const stopAudio = (prop: HTMLAudioElement) => {
        prop.pause();
        prop.currentTime = 0;
    }


    useEffect(() => {
        if (location.pathname !== '/datalist') {
            dispatch(appActions.setIsDatalistPath(false));
            dispatch(appActions.setIsRasterShown(true));
            setTheNewSource(song1);
            if (audio) {
                stopAudio(audio);
                audio.setAttribute('src', song1);
                audio.load();
                isPlaying.current = true;
            };
        } else {
            dispatch(appActions.setIsDatalistPath(true));
            dispatch(appActions.setIsRasterShown(false));
            setTheNewSource(songDataList);
            if (audio) {
                stopAudio(audio);
                audio.setAttribute('src', songDataList);
                audio.load();
                isPlaying.current = true;
            };
        }
    }, [location.pathname, audio, dispatch]);


    const music = useCallback((prop: boolean) => {
        isPlaying.current = prop;
        if (prop) { audio.play() }
        else {
            stopAudio(audio);
            audio.setAttribute('src', theNewSource);
            audio.load();
            isPlaying.current = true;
        }
    }, [audio, theNewSource]);


    const togglePlay = useCallback(() => {
        audio.play();
        isPlaying.current = true;
    }, [audio]);


    const togglePause = useCallback(() => {
        audio.pause();
        isPlaying.current = false;
    }, [audio]);


    const toggleStop = useCallback(() => {
        isPlaying.current = false;
        audio.pause();
        audio.currentTime = 0;
    }, [audio]);


    useEffect(() => {
        isPlaying.current ? audio.play() : audio.pause();
    }, [audio]);


    useEffect(() => {
        audio.addEventListener('ended', () => isPlaying.current = false);
        return () => {
            audio.removeEventListener('ended', () => isPlaying.current = false);
        };
    }, [audio]);



    const ShowFooter = () => {
        return (
            <Fragment>
                <div className='footer'>
                    <span>music by C64, Matt Gray </span>
                    <button onClick={togglePlay}><span className='class="bi bi-play'></span></button>
                    <button onClick={togglePause}><span className='class="bi bi-pause'></span></button>
                    <button onClick={toggleStop}><span className='class="bi bi-stop'></span></button>
                </div>
            </Fragment>
        );
    };

    return { isPlaying, togglePlay, togglePause, toggleStop, music, audio, ShowFooter };
};



