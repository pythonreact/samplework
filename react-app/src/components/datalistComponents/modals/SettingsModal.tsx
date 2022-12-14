import { Fragment } from 'react';
import PortalReactDOM from 'react-dom';
import { useReduxSelector } from '../../../store/ReduxTypes';
import { useModalThunks } from '../../../logics/datalistLogics/thunks/ModalThunks';
import { useTableThunks } from '../../../logics/datalistLogics/thunks/TableThunks';




const portalElement = document.getElementById('modals')!;




export const SettingsModal = () => {
    const { hideModalHandler } = useModalThunks();
    const { makeFetchXHRHandler } = useTableThunks();

    const isModalEffect = useReduxSelector(state => state.effect.isModalEffect);
    const fetchXHR = useReduxSelector(state => state.table.fetchXHR);

    return (
        <Fragment>
            {PortalReactDOM.createPortal(
                <div className="modal fade" id="refSettingsModal" tabIndex={-1} >
                    <div className="modal-dialog modal-dialog-centered">

                        <div className={isModalEffect ? 'modal-content modal-content-color'
                            : 'modal-content modal-content-notanimated'}>
                            <div className="modal-header">
                                <h5 className="modal-title">Settings</h5>
                                <button type="button" className="btn-close btn-outline-custom btn-modal"
                                    onClick={() => hideModalHandler('refSettingsModal')}>
                                </button>
                            </div>

                            <div className="modal-body">
                                <div className="d-flex flex-row justify-content-start">
                                    <div className="p-2 w-100 bd-highlight">

                                        <div className="rasterstyle">
                                            <span className='inline-width'>
                                                Fetch vs XMLHttp</span>

                                            <div className="form-check form-check-inline ms-2">
                                                <input className="mobile-input form-check-input" type="radio" id="FetchOn"
                                                    checked={fetchXHR === 'Fetch'} onChange={() => makeFetchXHRHandler('Fetch')} />
                                                <label className="custom-control-label" htmlFor="Fetch">Fetch</label>
                                            </div>

                                            <div className="form-check form-check-inline">
                                                <input className="mobile-input form-check-input" type="radio" id="FetchOff"
                                                    checked={fetchXHR === 'axios'} onChange={() => makeFetchXHRHandler('axios')} />
                                                <label className="custom-control-label" htmlFor="FetchOff">XMLHttp</label>
                                            </div>

                                            <div className="form-check form-check-inline ms-2">
                                                <input className="mobile-input form-check-input" type="radio" id="FetchAuto"
                                                    checked={fetchXHR === 'auto'} onChange={() => makeFetchXHRHandler('auto')} />
                                                <label className="custom-control-label" htmlFor="FetchAuto">Auto</label>
                                            </div>

                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                , portalElement)}
        </Fragment>
    )
}
