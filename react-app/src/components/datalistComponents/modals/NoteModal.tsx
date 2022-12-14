import { Fragment } from 'react';
import PortalReactDOM from 'react-dom';
import { useReduxSelector } from '../../../store/ReduxTypes';
import { useModalThunks } from '../../../logics/datalistLogics/thunks/ModalThunks';


const portalElement = document.getElementById('modals')!;


export const NoteModal = () => {
    const { hideModalHandler } = useModalThunks();
    const isModalEffect = useReduxSelector(state => state.effect.isModalEffect);
    const note = useReduxSelector(state => state.modal.note);

    return (
        <Fragment>
            {PortalReactDOM.createPortal(
                <div className="modal fade" id="refNoteModal" tabIndex={-1} >
                    <div className="modal-dialog modal-sm modal-dialog-centered">
                        <div className={isModalEffect ? 'modal-content modal-content-color'
                            : 'modal-content modal-content-notanimated'}>
                            <div className="modal-header">
                                <button type="button" className="btn-close btn-outline-custom btn-modal"
                                    onClick={() => hideModalHandler('refNoteModal')}>
                                </button>
                            </div>
                            <div className="modal-body d-flex flex-row justify-content-center">
                                {note}
                            </div>
                        </div>
                    </div>
                </div>
                , portalElement)}
        </Fragment>
    );
}


