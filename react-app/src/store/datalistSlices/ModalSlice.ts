import { createSlice, PayloadAction } from '@reduxjs/toolkit';



interface ModalState {
    note: string;
    confirmText: string;
    confFunction: string;
    confId: string;
    isAdd: boolean;
    modalId: string;
    isOpenModal: boolean;
    isCloseModal: boolean;
    isRefreshModal: boolean;

}


const initialState: ModalState = {
    note: '',
    confirmText: '',
    confFunction: '',
    confId: '',
    isAdd: true,
    modalId: '',
    isOpenModal: false,
    isCloseModal: false,
    isRefreshModal: false
};


const modalSlice = createSlice({
    name: 'modal',
    initialState,
    reducers: {
        setNote(state, action: PayloadAction<string>) {
            state.note = action.payload;
        },
        setConfirmText(state, action: PayloadAction<string>) {
            state.confirmText = action.payload;
        },
        setConfFunction(state, action: PayloadAction<string>) {
            state.confFunction = action.payload;
        },
        setConfId(state, action: PayloadAction<string>) {
            state.confId = action.payload;
        },
        setIsAdd(state, action: PayloadAction<boolean>) {
            state.isAdd = action.payload;
        },
        setModalId(state, action: PayloadAction<string>) {
            state.modalId = action.payload;
        },
        setIsOpenModal(state, action: PayloadAction<boolean>) {
            state.isOpenModal = action.payload;
        },
        setIsCloseModal(state, action: PayloadAction<boolean>) {
            state.isCloseModal = action.payload;
        },
        setIsRefreshModal(state, action: PayloadAction<boolean>) {
            state.isRefreshModal = action.payload;
        }
    }
});

export const modalActions = modalSlice.actions;
export default modalSlice.reducer;
