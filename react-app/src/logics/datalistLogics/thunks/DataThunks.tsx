import { v4 as uuidv4 } from 'uuid';
import { Modal } from 'bootstrap';
import { useReduxDispatch, useReduxSelector } from '../../../store/ReduxTypes';
import { dataActions } from '../../../store/datalistSlices/DataSlice';
import { modalActions } from '../../../store/datalistSlices/ModalSlice';
import { filteringActions } from '../../../store/datalistSlices/FilteringSlice';
import { effectActions } from '../../../store/datalistSlices/EffectSlice';
import { tableActions } from '../../../store/datalistSlices/TableSlice';
import { useAPI } from '../UseAPI';
import { useModalThunks } from './ModalThunks';
import { useTableThunks } from './TableThunks';
import { Covids } from '../../../store/datalistSlices/DataSlice';
import { authActions } from '../../../store/datalistSlices/AuthSlice';




export const useDataThunks = () => {
    const dispatch = useReduxDispatch();
    const { showModalHandler } = useModalThunks();
    const { dataMap } = useTableThunks();
    const { FileAPI, LoadFetchXHR } = useAPI();

    const covids = useReduxSelector(state => state.data.covids);
    const covidsWithoutFilter = useReduxSelector(state => state.data.covidsWithoutFilter);
    const id = useReduxSelector(state => state.data.id);
    const date = useReduxSelector(state => state.data.date);
    const time = useReduxSelector(state => state.data.time);
    const infected = useReduxSelector(state => state.data.infected);
    const activeInfected = useReduxSelector(state => state.data.activeInfected);
    const deceased = useReduxSelector(state => state.data.deceased);
    const recovered = useReduxSelector(state => state.data.recovered);
    const quarantined = useReduxSelector(state => state.data.quarantined);
    const tested = useReduxSelector(state => state.data.tested);
    const sourceWeb = useReduxSelector(state => state.data.sourceWeb);
    const selectedData = useReduxSelector(state => state.table.selectedData);
    const fetchXHR = useReduxSelector(state => state.table.fetchXHR);
    const isUserLoggedIn = useReduxSelector(state => state.auth.isUserLoggedIn);

    const envAPIURL = process.env.REACT_APP_API_URL as string;


    const loadConfirm = () => {
        dispatch(tableActions.setIsLoading(true));
        showModalHandler('refSpinModal');

        LoadFetchXHR(fetchXHR).then(data => {
            FileAPI(fetchXHR, envAPIURL + 'loaddata', 'POST', 'text', data as string)
                .then((text) => {
                    dispatch(tableActions.setIsLoading(false));
                    dispatch(modalActions.setNote(text));
                    Modal.getInstance(document.getElementById('refSpinModal')!)!.hide();
                    dispatch(effectActions.setIsEffects(true));
                    showModalHandler('refNoteModal');
                    dispatch(tableActions.setIsRefresh(true));
                })
                .catch(error => {
                    Modal.getInstance(document.getElementById('refSpinModal')!)!.hide();
                    dispatch(effectActions.setIsEffects(true));
                    dispatch(tableActions.setIsLoading(false));
                    dispatch(modalActions.setNote(`Failed! ${error}`));
                    showModalHandler('refNoteModal');
                });
        })
            .catch(error => {
                dispatch(modalActions.setNote(`Failed! ${error}`));
                showModalHandler('refNoteModal');
            });
    };


    //Delete all data using Django, after confirm Yes
    const deleteAllDataConfirm = () => {
        FileAPI(fetchXHR, envAPIURL + 'deletealldata', 'DELETE', 'text')
            .then((text) => {
                dispatch(modalActions.setNote(text));
                showModalHandler('refNoteModal');
                dispatch(tableActions.setIsRefresh(true));
            })
            .catch(error => {
                dispatch(modalActions.setNote(`Failed! ${error}`));
                showModalHandler('refNoteModal');
            });
    };


    //"Add Data" button click
    const addHandler = () => {
        if (isUserLoggedIn) {
            dispatch(modalActions.setIsAdd(true));
            dispatch(dataActions.setId(uuidv4()));    //create new uuid4
            dispatch(dataActions.setDate(""));
            dispatch(dataActions.setTime(""));
            dispatch(dataActions.setInfected(0));
            dispatch(dataActions.setDeceased(0));
            dispatch(dataActions.setRecovered(0));
            dispatch(dataActions.setQuarantined(0));
            dispatch(dataActions.setTested(0));
            dispatch(dataActions.setActiveInfected(0));
            dispatch(dataActions.setSourceWeb("https://apify.com/tugkan/covid-hu"));
            showModalHandler('refAddEditModal');
        } else {
            dispatch(authActions.setIsLoginButton(false));
            showModalHandler('refAuthModal');
        };
    };


    //"Edit" icon click in list
    const editHandler = (data: Covids) => {
        if (isUserLoggedIn) {
            dispatch(modalActions.setIsAdd(false));
            dispatch(dataActions.setId(data.id));
            dispatch(dataActions.setDate(data.date));
            dispatch(dataActions.setTime(data.time));
            dispatch(dataActions.setInfected(data.infected));
            dispatch(dataActions.setActiveInfected(data.activeInfected));
            dispatch(dataActions.setDeceased(data.deceased));
            dispatch(dataActions.setRecovered(data.recovered));
            dispatch(dataActions.setQuarantined(data.quarantined));
            dispatch(dataActions.setTested(data.tested));
            dispatch(dataActions.setSourceWeb(data.sourceWeb));
            showModalHandler('refAddEditModal');
        } else {
            dispatch(authActions.setIsLoginButton(false));
            showModalHandler('refAuthModal');
        };
    };


    //"Create" button click in Modal Add
    const createHandler = () => {
        FileAPI(fetchXHR, envAPIURL + 'datalist', 'POST', 'json',
            JSON.stringify({
                id: id,
                date: date,
                time: time,
                infected: infected,
                activeInfected: activeInfected,
                deceased: deceased,
                recovered: recovered,
                quarantined: quarantined,
                tested: tested,
                sourceWeb: sourceWeb
            }),
        )
            .then((result) => {
                Modal.getInstance(document.getElementById('refAddEditModal')!)!.hide();
                dispatch(effectActions.setIsEffects(true));
                dispatch(modalActions.setNote(result));
                showModalHandler('refNoteModal');
                dispatch(tableActions.setIsRefresh(true));
            }, (error) => {
                Modal.getInstance(document.getElementById('refAddEditModal')!)!.hide();
                dispatch(effectActions.setIsEffects(true));
                dispatch(modalActions.setNote(`Failed! ${error}`));
                showModalHandler('refNoteModal');
            });
    };


    //"Update" button click in Modal Edit 
    const updateHandler = () => {
        FileAPI(fetchXHR, envAPIURL + 'datalist', 'PATCH', 'json',
            JSON.stringify({
                id: id,
                date: date,
                time: time,
                infected: infected,
                activeInfected: activeInfected,
                deceased: deceased,
                recovered: recovered,
                quarantined: quarantined,
                tested: tested,
                sourceWeb: sourceWeb
            }),
        )
            .then((result) => {
                Modal.getInstance(document.getElementById('refAddEditModal')!)!.hide();
                dispatch(effectActions.setIsEffects(true));
                dispatch(modalActions.setNote(result));
                showModalHandler('refNoteModal');
                dispatch(tableActions.setIsRefresh(true));
            }, (error) => {
                Modal.getInstance(document.getElementById('refAddEditModal')!)!.hide();
                dispatch(effectActions.setIsEffects(true));
                dispatch(modalActions.setNote(`Failed! ${error}`));
                showModalHandler('refNoteModal');
            });
    };

    //"Delete" icon click in list, one row from database, after confirm Yes
    const deleteIdConfirm = (id: string) => {
        FileAPI(fetchXHR, envAPIURL + 'datalist/' + id, 'DELETE', 'json')
            .then((result) => {
                dispatch(modalActions.setNote(result));
                showModalHandler('refNoteModal');
                dispatch(dataActions.setCovids(covids.filter(dataItem => dataItem.id !== id)));
                dispatch(dataActions.setCovidsWithoutFilter(covidsWithoutFilter.filter(dataItem => dataItem.id !== id)));
                dataMap(covidsWithoutFilter.filter(dataItem => dataItem.id !== id));
                dispatch(filteringActions.setIsFiltering(true));
            }, (error) => {
                dispatch(modalActions.setNote(`Failed! ${error}`));
                showModalHandler('refNoteModal');
            });
    };


    const deleteSelectedConfirm = () => {
        FileAPI(fetchXHR, envAPIURL + 'deleteselected', 'POST', 'text', JSON.stringify(selectedData))
            .then((result) => {
                dispatch(modalActions.setNote(result));
                showModalHandler('refNoteModal');
                dispatch(tableActions.setSelectedData([]));
                dispatch(tableActions.setIsRefresh(true));
                dispatch(filteringActions.setIsFiltering(true));
            }, (error) => {
                dispatch(modalActions.setNote(`Failed! ${error}`));
                showModalHandler('refNoteModal');
            });
    };

    //Input field click in Add Edit Modal
    const changeFieldHandler = (eTarget: EventTarget & HTMLInputElement) => {
        switch (eTarget.name) {
            case 'date': dispatch(dataActions.setDate(eTarget.value)); break;
            case 'time': dispatch(dataActions.setTime(eTarget.value)); break;
            case 'infected': dispatch(dataActions.setInfected(parseInt(eTarget.value))); break;
            case 'deceased': dispatch(dataActions.setDeceased(parseInt(eTarget.value))); break;
            case 'recovered': dispatch(dataActions.setRecovered(parseInt(eTarget.value))); break;
            case 'quarantined': dispatch(dataActions.setQuarantined(parseInt(eTarget.value))); break;
            case 'tested': dispatch(dataActions.setTested(parseInt(eTarget.value))); break;
            case 'activeInfected': dispatch(dataActions.setActiveInfected(parseInt(eTarget.value))); break;
            case 'sourceWeb': dispatch(dataActions.setSourceWeb(eTarget.value)); break;
            default: break;
        }
    };



    //From ConfirmModal function selector
    const confirmHandler = (isConf: boolean, confFunc: string, confId: string) => {
        if (confFunc === 'load' && isConf === true) { loadConfirm() }
        else if (confFunc === 'deleteall' && isConf === true) { deleteAllDataConfirm() }
        else if (confFunc === 'deleteid' && isConf === true) { deleteIdConfirm(confId) }
        else if (confFunc === 'deleteselected' && isConf === true) { deleteSelectedConfirm() }
    };


    return {
        loadConfirm, deleteAllDataConfirm, addHandler, editHandler, createHandler, updateHandler, deleteIdConfirm,
        deleteSelectedConfirm, changeFieldHandler, confirmHandler
    };

};



