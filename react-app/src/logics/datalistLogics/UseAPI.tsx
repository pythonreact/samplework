import { useReduxSelector } from '../../store/ReduxTypes';
import { useAuthThunks } from '../datalistLogics/thunks/AuthThunks';
import { useRef } from 'react';
import axios, { AxiosError } from 'axios';



export const useAPI = () => {
    const { RefreshTokenFetch, RefreshTokenAxios } = useAuthThunks();
    const FETCHCHECK = (typeof fetch === "undefined" ? false : true);
    const token = useReduxSelector(state => state.auth.token);
    const isError = useRef(false);
    const envAPIURL = process.env.REACT_APP_API_URL;




    // if browser does not compatibile with Fetch use XMLHttpRequest
    const FileAPI = async (fetchXHR: string, url: string, method: string, type: string, body?: string): Promise<any> => {

        // Fetch
        if ((fetchXHR === 'auto' && FETCHCHECK) || fetchXHR === 'Fetch') {

            const response = await fetch(url, {
                method: method,
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer' + token
                },
                body: body ? body : null
            });
            if (response.ok) {
                const data = type === 'json' ? await response.json() : await response.text();
                isError.current = false;
                return data;
            } else {
                if (response.status === 401 && isError.current === false) {
                    isError.current = true;
                    try {
                        await RefreshTokenFetch();
                        return FileAPI(fetchXHR, url, method, type, body)
                    } catch (error) {
                        return 'Fetch error';
                    };
                } else {
                    isError.current = false;
                    return (`Fetch Failed! ${response.statusText}`);
                };
            };
        }

        // Axios
        else {
            try {
                const response = await axios({
                    method: method,
                    url: url,
                    data: body ? body : null,
                    headers: {
                        'Accept': 'application/json',
                        "Content-Type": "application/json",
                        'Authorization': 'Bearer' + token
                    },
                });
                const data = await response.data;
                isError.current = false;
                return data;
            } catch (error) {
                const err = error as AxiosError;
                if (err.response?.status === 401 && isError.current === false) {
                    isError.current = true;
                    try {
                        await RefreshTokenAxios();
                        return FileAPI(fetchXHR, envAPIURL + 'deleteselected', 'POST', 'text', body)
                    } catch (error) {
                        return 'Axios error';
                    };
                } else {
                    isError.current = false;
                    return (`Axios Failed! ${err.response?.statusText}`);
                };
            };
        };
    };



    // Load Data from Url with Fetch or with XMLHttpRequest
    const LoadFetchXHR = (fetchXHR: string) => {
        const envImportUrl = process.env.REACT_APP_IMPORT_URL as string;
        const FETCHCHECK = (typeof fetch === "undefined" ? false : true);

        const makeLoadingIcon = (show: boolean) => {
            show ? document.getElementById('loadingicon')!.style.visibility = "visible"
                : document.getElementById('loadingicon')!.style.visibility = "hidden";
        }

        const makeLoadingText = (text: string) => {
            document.getElementById('loadingtext')!.innerHTML = text;
        }

        const makeStatus = (text: string) => {
            document.getElementById('status')!.innerHTML = text;
        }

        const makeProgress = (loaded: number, total: number) => {
            isNaN(loaded / total) ? document.getElementById('progress')!.innerHTML = "&nbsp;"
                : document.getElementById('progress')!.innerHTML = Math.round(loaded / total * 100) + '%';
        }

        makeStatus('');
        makeProgress(0, 0);
        makeLoadingIcon(true);
        makeLoadingText('Loading...');

        if ((fetchXHR === 'auto' && FETCHCHECK) || fetchXHR === 'Fetch') return LoadFetch()
        else return LoadXHR();

        async function LoadFetch() {
            const response = await fetch(envImportUrl, {
                method: 'GET',
                headers: {
                    //  'Accept': 'application/json',
                    //  'Content-Type': 'application/json'
                }
            });
            let contentLength = response.headers.get('content-length') ?
                parseInt(response.headers.get('content-length')!, 10) : null;
            let loaded = 0;
            let chunks = [];
            if (!contentLength) makeStatus('Slow remote server...');


            const responseBody = response.body as ReadableStream<Uint8Array>
            const reader = responseBody.getReader();

            while (true) {
                const { done, value } = await reader.read();
                if (done) break;
                chunks.push(value);
                loaded += value.byteLength;
                makeStatus(`Received ${loaded} bytes`);
                let total = contentLength ? contentLength : loaded;
                makeProgress(loaded, total)
            };
            let chunksAll = new Uint8Array(loaded);
            let position = 0;
            for (let chunk of chunks) {
                chunksAll.set(chunk, position);
                position += chunk.length;
            }
            let data = new TextDecoder("utf-8").decode(chunksAll);
            makeLoadingText('Loading completed');
            makeLoadingIcon(false);
            return data;
        }


        async function LoadXHR() {
            return new Promise(function (resolve, reject) {
                let url = envImportUrl;
                let xhr = new XMLHttpRequest();
                let loaded = 0;
                let total = null;
                xhr.open("GET", url);
                xhr.onloadstart = (e) => {
                    if (!e.lengthComputable) { makeStatus('Slow remote server...') };
                };
                xhr.onload = (e) => {
                    if (xhr.status !== 200) {
                        console.error(`Error ${xhr.status}: ${xhr.statusText}`);
                        reject(Error('Request failed! ' + xhr.responseText));
                    } else {
                        makeLoadingText('Loading completed');
                        makeLoadingIcon(false);
                        resolve(xhr.responseText);
                    }
                };
                xhr.onprogress = (e) => {
                    loaded = parseInt(e.loaded.toString(), 10);
                    makeStatus(`Received ${loaded} bytes`);
                    total = e.lengthComputable ? parseInt(e.lengthComputable.toString(), 10) : loaded;
                    makeProgress(loaded, total);
                };
                xhr.onerror = () => {
                    console.error(`Error ${xhr.status}: ${xhr.statusText}`);
                    reject(Error('Can not connect to server'));
                };
                xhr.send(null);
            });
        }
    };

    return { FileAPI, LoadFetchXHR }
};
