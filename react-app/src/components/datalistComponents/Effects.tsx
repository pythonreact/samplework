import React, { Fragment } from 'react';
import { useReduxSelector } from '../../store/ReduxTypes';
import { useModalThunks } from '../../logics/datalistLogics/thunks/ModalThunks';






// Scroll text
export const ScrollEffect = () => {
    const isScroll = useReduxSelector(state => state.effect.isScroll);
    const isEffects = useReduxSelector(state => state.effect.isEffects);
    const tableStyle = useReduxSelector(state => state.table.tableStyle);
    const covids = useReduxSelector(state => state.data.covids);
    const covidsWithoutFilter = useReduxSelector(state => state.data.covidsWithoutFilter);

    return (
        <Fragment>
            <div className={`d-flex flex-row ${isScroll && isEffects ? 'scrollText ' : 'scrollNotAnimated'}`}
                style={tableStyle === 'table-standard' ? { '--topHeight': '40px' } as React.CSSProperties : { '--topHeight': '0px' } as React.CSSProperties}>
                {covidsWithoutFilter.length} data are in database. {covids.length} are shown.
            </div>
        </Fragment>
    )
}


// Earth rotating 
export const EarthEffect = () => {
    const { showModalHandler } = useModalThunks();
    const isEffects = useReduxSelector(state => state.effect.isEffects);
    const isEarthEffect = useReduxSelector(state => state.effect.isEarthEffect);
    const tableStyle = useReduxSelector(state => state.table.tableStyle);

    return (
        <Fragment>
            <div className={isEffects && isEarthEffect ? "EarthAnimate" : "Earth"}
                style={tableStyle === 'table-scroll' ? { '--Height': '70px' } as React.CSSProperties : { '--Height': '110px' } as React.CSSProperties}
                onClick={() => showModalHandler('refMapModal')}>
                <span>MAP</span>
            </div>
        </Fragment>
    )
}


// Swing effect 
export const SwingEffect = () => {
    const isEffects = useReduxSelector(state => state.effect.isEffects);
    const isSwing = useReduxSelector(state => state.effect.isSwing);
    const tableStyle = useReduxSelector(state => state.table.tableStyle);

    return (
        <Fragment>
            <div className="swingerFont"
                style={tableStyle === 'table-standard' ? { '--topHeight': '40px' } as React.CSSProperties : { '--topHeight': '0px' } as React.CSSProperties}>
                <div className={isEffects && isSwing ? 'headerAnimate1' : 'header1'}>Data List</div>
                <div className={isEffects && isSwing ? 'headerAnimate2' : 'header2'}>Data List</div>
            </div>
        </Fragment>
    )
}



// Cube 3D 
export const CubeEffect = () => {
    const { showModalHandler } = useModalThunks();
    const isEffects = useReduxSelector(state => state.effect.isEffects);
    const isCubeEffect = useReduxSelector(state => state.effect.isCubeEffect);
    const tableStyle = useReduxSelector(state => state.table.tableStyle);


    return (
        <Fragment>
            <div className="wrapD3Cube">
                <div className={isEffects && isCubeEffect ? "D3Cube-Animate" : "D3Cube"}
                    style={tableStyle === 'table-scroll' ? { '--t': '0px' } as React.CSSProperties : { '--t': '40px' } as React.CSSProperties}
                    onClick={() => showModalHandler('refChartModal')}>
                    <div id="top">Chart</div>
                    <div id="left">Chart</div>
                    <div id="front">Chart</div>
                    <div id="right">Chart</div>
                    <div id="back">Chart</div>
                    <div id="bottom">Chart</div>
                </div>
            </div>
        </Fragment>
    )
}

// Empty lines Header 
export const SwingLinesEffect = () => {
    const tableStyle = useReduxSelector(state => state.table.tableStyle);

    return (
        <Fragment>
            <p className='swingHeight'
                style={tableStyle === 'table-standard' ? { '--topHeight': '40px' } as React.CSSProperties : { '--topHeight': '0px' } as React.CSSProperties}>
            </p>
        </Fragment>
    )
}


// Raster Stripes effect
export const RasterEffect = () => {
    const isEffects = useReduxSelector(state => state.effect.isEffects);
    const isRaster = useReduxSelector(state => state.effect.isRaster);
    const tableStyle = useReduxSelector(state => state.table.tableStyle);

    return (
        <Fragment>
            <div className="rasterStripes">
                <p className={isRaster && isEffects ? 'rasterp' : ''}
                    style={tableStyle === 'table-standard' ? { '--width': '100%' } as React.CSSProperties : { '--width': '100%' } as React.CSSProperties}>
                </p>
            </div>
        </Fragment>
    )
}


