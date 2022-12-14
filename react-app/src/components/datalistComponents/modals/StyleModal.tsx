import { Fragment } from 'react';
import PortalReactDOM from 'react-dom';
import { useReduxSelector } from '../../../store/ReduxTypes';
import { useModalThunks } from '../../../logics/datalistLogics/thunks/ModalThunks';
import { useEffectThunks } from '../../../logics/datalistLogics/thunks/EffectThunks';




const portalElement = document.getElementById('modals')!;




export const StyleModal = () => {
    const { hideModalHandler } = useModalThunks();
    const { makeChartEffectHandler, makeCubeEffectHandler, makeEarthEffectHandler, makeFlipEffectHandler, makeModalEffectHandler,
        makeRasterEffectHandler, makeScrollEffectHandler, makeSwingEffectHandler } = useEffectThunks();

    const isModalEffect = useReduxSelector(state => state.effect.isModalEffect);
    const isRaster = useReduxSelector(state => state.effect.isRaster);
    const isScroll = useReduxSelector(state => state.effect.isScroll);
    const isSwing = useReduxSelector(state => state.effect.isSwing);
    const isFlip = useReduxSelector(state => state.effect.isFlip);
    const isEarthEffect = useReduxSelector(state => state.effect.isEarthEffect);
    const isCubeEffect = useReduxSelector(state => state.effect.isCubeEffect);
    const isChartEffect = useReduxSelector(state => state.effect.isChartEffect);

    return (
        <Fragment>
            {PortalReactDOM.createPortal(
                <div className="modal fade" id="refStyleModal" tabIndex={-1} >
                    <div className="modal-dialog modal-dialog-centered">

                        <div className={isModalEffect ? 'modal-content modal-content-color'
                            : 'modal-content modal-content-notanimated'}>
                            <div className="modal-header">
                                <h5 className="modal-title">Set Style Effects</h5>
                                <button type="button" className="btn-close btn-outline-custom btn-modal"
                                    onClick={() => hideModalHandler('refStyleModal')}>
                                </button>
                            </div>

                            <div className="modal-body">
                                <div className="d-flex flex-row justify-content-start">
                                    <div className="p-2 w-100 bd-highlight">

                                        <div className="rasterstyle">
                                            <span className='inline-width'>
                                                Raster Effect:</span>

                                            <div className="form-check form-check-inline ms-2">
                                                <input className="mobile-input form-check-input" type="radio" id="rasterOn"
                                                    checked={isRaster === true} onChange={() => makeRasterEffectHandler(true)} />
                                                <label className="custom-control-label" htmlFor="rasterOn">On</label>
                                            </div>

                                            <div className="form-check form-check-inline">
                                                <input className="mobile-input form-check-input" type="radio" id="rasterOff"
                                                    checked={isRaster === false} onChange={() => makeRasterEffectHandler(false)} />
                                                <label className="custom-control-label" htmlFor="rasterOff">Off</label>
                                            </div>
                                        </div>

                                        <div className="scrollstyle">
                                            <span className='inline-width'>
                                                Scroll Effect:</span>

                                            <div className="form-check form-check-inline ms-2">
                                                <input className="mobile-input form-check-input" type="radio" id="scrollOn"
                                                    checked={isScroll === true} onChange={() => makeScrollEffectHandler(true)} />
                                                <label className="custom-control-label" htmlFor="scrollOn">On</label>
                                            </div>

                                            <div className="form-check form-check-inline">
                                                <input className="mobile-input form-check-input" type="radio" id="scrollOff"
                                                    checked={isScroll === false} onChange={() => makeScrollEffectHandler(false)} />
                                                <label className="custom-control-label" htmlFor="scrollOff">Off</label>
                                            </div>
                                        </div>

                                        <div className="swingheaderstyle">
                                            <span className='inline-width'>
                                                Swing Effect:</span>

                                            <div className="form-check form-check-inline ms-2">
                                                <input className="mobile-input form-check-input" type="radio" id="swingOn"
                                                    checked={isSwing === true} onChange={() => makeSwingEffectHandler(true)} />
                                                <label className="custom-control-label" htmlFor="swingOn">On</label>
                                            </div>

                                            <div className="form-check form-check-inline">
                                                <input className="mobile-input form-check-input" type="radio" id="swingOff"
                                                    checked={isSwing === false} onChange={() => makeSwingEffectHandler(false)} />
                                                <label className="custom-control-label" htmlFor="swingOff">Off</label>
                                            </div>
                                        </div>

                                        <div className="flipstyle">
                                            <span className='inline-width'>
                                                Menu Flip Effect:</span>

                                            <div className="form-check form-check-inline ms-2">
                                                <input className="mobile-input form-check-input" type="radio" id="flipOn"
                                                    checked={isFlip === true} onChange={() => makeFlipEffectHandler(true)} />
                                                <label className="custom-control-label" htmlFor="flipOn">On</label>
                                            </div>

                                            <div className="form-check form-check-inline">
                                                <input className="mobile-input form-check-input" type="radio" id="flipOff"
                                                    checked={isFlip === false} onChange={() => makeFlipEffectHandler(false)} />
                                                <label className="custom-control-label" htmlFor="flipOff">Off</label>
                                            </div>
                                        </div>


                                        <div className="modalEffectstyle">
                                            <span className='inline-width'>
                                                Modal Color Effect:</span>

                                            <div className="form-check form-check-inline ms-2">
                                                <input className="mobile-input form-check-input" type="radio" id="modalEffectOn"
                                                    checked={isModalEffect === true} onChange={() => makeModalEffectHandler(true)} />
                                                <label className="custom-control-label" htmlFor="modalEffectOn">On</label>
                                            </div>

                                            <div className="form-check form-check-inline">
                                                <input className="mobile-input form-check-input" type="radio" id="modalEffectOff"
                                                    checked={isModalEffect === false} onChange={() => makeModalEffectHandler(false)} />
                                                <label className="custom-control-label" htmlFor="modalEffectOff">Off</label>
                                            </div>

                                            <div className="earthEffectstyle">
                                                <span className='inline-width'>
                                                    Earth Rotate Effect:</span>

                                                <div className="form-check form-check-inline ms-2">
                                                    <input className="mobile-input form-check-input" type="radio" id="earthEffectOn"
                                                        checked={isEarthEffect === true} onChange={() => makeEarthEffectHandler(true)} />
                                                    <label className="custom-control-label" htmlFor="earthEffectOn">On</label>
                                                </div>

                                                <div className="form-check form-check-inline">
                                                    <input className="mobile-input form-check-input" type="radio" id="earthEffectOff"
                                                        checked={isEarthEffect === false} onChange={() => makeEarthEffectHandler(false)} />
                                                    <label className="custom-control-label" htmlFor="earthEffectOff">Off</label>
                                                </div>
                                            </div>

                                            <div className="cubeEffectstyle">
                                                <span className='inline-width'>
                                                    Cube 3D Effect:</span>

                                                <div className="form-check form-check-inline ms-2">
                                                    <input className="mobile-input form-check-input" type="radio" id="cubeEffectOn"
                                                        checked={isCubeEffect === true} onChange={() => makeCubeEffectHandler(true)} />
                                                    <label className="custom-control-label" htmlFor="cubeEffectOn">On</label>
                                                </div>

                                                <div className="form-check form-check-inline">
                                                    <input className="mobile-input form-check-input" type="radio" id="cubeEffectOff"
                                                        checked={isCubeEffect === false} onChange={() => makeCubeEffectHandler(false)} />
                                                    <label className="custom-control-label" htmlFor="cubeEffectOff">Off</label>
                                                </div>
                                            </div>

                                            <div className="chartEffectstyle">
                                                <span className='inline-width'>
                                                    Chart Effect:</span>

                                                <div className="form-check form-check-inline ms-2">
                                                    <input className="mobile-input form-check-input" type="radio" id="chartEffectOn"
                                                        checked={isChartEffect === true} onChange={() => makeChartEffectHandler(true)} />
                                                    <label className="custom-control-label" htmlFor="chartEffectOn">On</label>
                                                </div>

                                                <div className="form-check form-check-inline">
                                                    <input className="mobile-input form-check-input" type="radio" id="chartEffectOff"
                                                        checked={isChartEffect === false} onChange={() => makeChartEffectHandler(false)} />
                                                    <label className="custom-control-label" htmlFor="chartEffectOff">Off</label>
                                                </div>
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

