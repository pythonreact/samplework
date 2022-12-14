import { Fragment, ReactElement, useRef } from "react";
import { useReduxSelector } from '../../store/ReduxTypes';
import { useCanvas } from '../../logics/appLogics/UseCanvas';




export const Logo = () => {
    const canvasRef = useRef<HTMLCanvasElement | null>(null);
    const isRasterShown = useReduxSelector(state => state.app.isRasterShown);
    //const isCanvasDrawn = useReduxSelector(state => state.app.isCanvasDrawn);
    const { canvasAnimate, ShowPixelSize } = useCanvas(canvasRef);


    const RasterField: Function = (): ReactElement[] => {
        return Array.from(Array(15), (x, i) => {
            return (
                <Fragment key={i}>
                    <div><p className='raster-span'></p></div>
                </Fragment>
            )
        });
    };

    return (
        <Fragment>
            {/* Raster Stripes */}
            <div className='backdrop'>
                {/* <div className={`raster ${isRasterShown && isCanvasDrawn ? 'displayBlock' : 'displayNone'}`} */}
                <div className="raster"
                    style={{ visibility: isRasterShown ? 'visible' : 'hidden' }}>
                    <RasterField />
                </div>
                <canvas id='canvasRaster' ref={canvasRef}
                    //style={{ visibility: isCanvasDrawn ? 'visible' : 'hidden' }}
                    onClick={() => canvasAnimate()}>
                </canvas>
            </div>
            <ShowPixelSize />
        </Fragment>
    );

};



