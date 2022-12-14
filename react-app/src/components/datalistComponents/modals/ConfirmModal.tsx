import { Fragment } from 'react';
import PortalReactDOM from 'react-dom';
import { useReduxSelector } from '../../../store/ReduxTypes';
import { useModalThunks } from '../../../logics/datalistLogics/thunks/ModalThunks';
import { useDataThunks } from '../../../logics/datalistLogics/thunks/DataThunks';




const portalElement = document.getElementById('modals')!;


export const ConfirmModal = () => {

    const { hideModalHandler } = useModalThunks();
    const { confirmHandler } = useDataThunks();

    const isModalEffect = useReduxSelector(state => state.effect.isModalEffect);
    const confirmText = useReduxSelector(state => state.modal.confirmText);
    const confFunction = useReduxSelector(state => state.modal.confFunction);
    const confId = useReduxSelector(state => state.modal.confId);

    return (
        <Fragment>
            {PortalReactDOM.createPortal(
                <div className="modal fade" id="refConfirmModal" tabIndex={-1} >
                    <div className="modal-dialog modal-sm modal-dialog-centered">
                        <div className={isModalEffect ? 'modal-content modal-content-color'
                            : 'modal-content modal-content-notanimated'}>
                            <div className="modal-header">
                                <button type="button" className="btn-close btn-outline-custom btn-modal"
                                    onClick={() => hideModalHandler('refConfirmModal')}>
                                    {/* data-bs-dismiss="modal" */}
                                </button>
                            </div>
                            <div className="modal-body d-flex flex-row justify-content-center">
                                {confirmText}
                            </div>
                            <button type="button" className="btn btnStyle btn-light btn-outline-custom m-2 float-end"
                                data-bs-dismiss="modal"
                                onClick={() => confirmHandler(true, confFunction, confId)}>
                                Yes
                            </button>
                            <button type="button" className="btn btnStyle btn-light btn-outline-custom m-2 float-end"
                                onClick={() => {
                                    hideModalHandler('refConfirmModal');
                                    confirmHandler(false, confFunction, confId);
                                }}>
                                No
                            </button>
                        </div>
                    </div>
                </div>
                , portalElement)}
        </Fragment>
    );
}

