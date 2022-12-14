import { useReduxDispatch, useReduxSelector } from '../../../store/ReduxTypes';
import { dataActions } from '../../../store/datalistSlices/DataSlice';
import { modalActions } from '../../../store/datalistSlices/ModalSlice';
import { filteringActions } from '../../../store/datalistSlices/FilteringSlice';
import { effectActions } from '../../../store/datalistSlices/EffectSlice';
import { authActions } from '../../../store/datalistSlices/AuthSlice';




export const useModalThunks = () => {
    const dispatch = useReduxDispatch();
    const isOnlySelected = useReduxSelector(state => state.filtering.isOnlySelected);
    const filterActive = useReduxSelector(state => state.filtering.filterActive);
    const covidsWithoutFilter = useReduxSelector(state => state.data.covidsWithoutFilter);
    const selectedData = useReduxSelector(state => state.table.selectedData);
    const isUserLoggedIn = useReduxSelector(state => state.auth.isUserLoggedIn);


    //Show active modal
    const showModalHandler = (getModalId: string) => {
        dispatch(effectActions.setIsEffects(false));
        if (getModalId === 'refModalFiltering' && isOnlySelected) {
            dispatch(filteringActions.setIsOnlySelected(false));
            if (filterActive) { dispatch(filteringActions.setIsFiltering(true)); }
            else { dispatch(dataActions.setCovids(covidsWithoutFilter)); }
        }

        dispatch(modalActions.setModalId(getModalId));
        dispatch(modalActions.setIsOpenModal(true));
    };


    // Hide active modal
    const hideModalHandler = (getModalId: string) => {
        dispatch(effectActions.setIsEffects(true));
        dispatch(modalActions.setModalId(getModalId));
        dispatch(modalActions.setIsCloseModal(true));
    };


    //Load data from Json url using Django
    const loadDataHandler = () => {
        if (isUserLoggedIn) {
            dispatch(modalActions.setConfirmText('Are you sure? It will take 1 minute...'));
            dispatch(modalActions.setConfFunction('load'));
            showModalHandler('refConfirmModal');
        } else {
            dispatch(authActions.setIsLoginButton(false));
            showModalHandler('refAuthModal');
        }
    };


    //Delete all data using Django
    const deleteAllDataHandler = () => {
        if (isUserLoggedIn) {
            dispatch(modalActions.setConfirmText('Are you sure want to delete all data?'));
            dispatch(modalActions.setConfFunction('deleteall'));
            showModalHandler('refConfirmModal');
        } else {
            dispatch(authActions.setIsLoginButton(false));
            showModalHandler('refAuthModal');
        };
    };


    //"Delete" icon click in list, one row from database
    const deleteHandler = (getId: string) => {
        if (isUserLoggedIn) {
            dispatch(modalActions.setConfirmText('Are you sure want to delete this row?'));
            dispatch(modalActions.setConfFunction('deleteid'));
            dispatch(modalActions.setConfId(getId));
            showModalHandler('refConfirmModal');
        } else {
            dispatch(authActions.setIsLoginButton(false));
            showModalHandler('refAuthModal');
        };
    };


    const deleteSelectedHandler = () => {
        if (selectedData.length !== 0) {
            if (isUserLoggedIn) {
                dispatch(modalActions.setConfirmText(`Are you sure want to delete ${selectedData.length} selected data?`));
                dispatch(modalActions.setConfFunction('deleteselected'));
                showModalHandler('refConfirmModal');
            } else {
                dispatch(authActions.setIsLoginButton(false));
                showModalHandler('refAuthModal');
            };
        } else {
            dispatch(modalActions.setNote("Data is not selected!"));
            showModalHandler('refNoteModal');
        };
    };


    const makeRefreshModal = (prop: boolean) => {
        dispatch(modalActions.setIsRefreshModal(prop));
    }


    return { showModalHandler, hideModalHandler, loadDataHandler, deleteAllDataHandler, deleteHandler, deleteSelectedHandler, makeRefreshModal };

};

