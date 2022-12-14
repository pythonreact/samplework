import { Fragment } from 'react';
import PortalReactDOM from 'react-dom';
import { useReduxSelector } from '../../../store/ReduxTypes';
import { useModalThunks } from '../../../logics/datalistLogics/thunks/ModalThunks';


const portalElement = document.getElementById('modals')!;


export const SpinModal = () => {
    const { hideModalHandler } = useModalThunks();
    const isModalEffect = useReduxSelector(state => state.effect.isModalEffect);




    return (
        <Fragment>
            {PortalReactDOM.createPortal(
                <div className="modal fade" id="refSpinModal" tabIndex={-1}>
                    <div className="modal-dialog modal-sm modal-dialog-centered">
                        <div className={isModalEffect ? 'modal-content modal-content-color'
                            : 'modal-content modal-content-notanimated'}>
                            <div className="modal-header">
                                <button type="button" className="btn-close btn-outline-custom btn-modal"
                                    onClick={() => hideModalHandler('refSpinModal')}>
                                </button>
                            </div>
                            <div className="modal-body">
                                <div className="spinner" id="spinner">
                                    <div className="loading-icon spinner-border d-flex" id="loadingicon">
                                    </div>
                                    <span id="loadingtext"><br />&nbsp;</span>
                                </div>
                                <div id="status">&nbsp;</div>
                                <h1 id="progress">&nbsp;</h1>
                            </div>
                        </div>
                    </div>
                </div>
                , portalElement)}
        </Fragment>
    );
}


