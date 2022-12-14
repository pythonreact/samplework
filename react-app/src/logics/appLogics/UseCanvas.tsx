import { useEffect, useState, useCallback, Fragment, useRef } from "react";
import { useReduxSelector, useReduxDispatch } from "../../store/ReduxTypes";
import { appActions } from "../../store/appSlices/AppSlice";



export const useCanvas = (canvasRef: React.RefObject<HTMLCanvasElement>) => {
    interface Pixels { x: number, y: number, color: string, originX: number, originY: number, distanceX: number, distanceY: number, distance: number, vx: number, vy: number, gravity: number, angle: number };
    // interface Pixels<T> { [Key: string | number]: T; };
    const dispatch = useReduxDispatch();
    const isShowHeader = useReduxSelector(state => state.app.isShowHeader);
    const isTitle = useReduxSelector(state => state.app.isTitle);
    const isCanvasDrawn = useReduxSelector(state => state.app.isCanvasDrawn);

    // Canvas
    const [canvasWidth, setCanvasWidth] = useState(window.innerWidth);
    const [canvasHeight, setCanvasHeight] = useState(window.innerHeight);
    const [canvas, setCanvas] = useState<HTMLCanvasElement>();
    const [ctx, setCtx] = useState<CanvasRenderingContext2D | null>(null);

    // Booleans
    const [isMovingPixel, setIsMovingPixel] = useState(false);
    const [isConverted, setIsConverted] = useState(false);
    const [isCanvasEffect, setIsCanvasEffect] = useState(false);
    const [isInit, setIsInit] = useState(true);

    // Animation
    const requestAnimationRef = useRef<number | null>(null);
    const targetValueRef = useRef(1);
    const timeValueRef = useRef(Date.now());
    const animationMax = 60;
    const animationSpeed = 0.009;

    // Pixels
    // const [pixels, setPixels] = useState<Pixels<string | number>[]>([]);
    const [pixelSize, setPixelSize] = useState<number>(3);
    const pixelsRef = useRef<Pixels[]>([]);
    const minXRef = useRef<number>(0);
    const maxXRef = useRef<number>(0);
    const minYRef = useRef<number>(0);
    const maxYRef = useRef<number>(0);
    const text = isTitle ? 'REACT' : 'DJANGO';

    const changeTitle = useCallback(() => {
        dispatch(appActions.setIsTitle(!isTitle));
        if (!isShowHeader) {
            dispatch(appActions.setIsShowHeader(true));
        };
        dispatch(appActions.setIsRasterShown(true));
        setIsInit(true);
    }, [isShowHeader, isTitle, dispatch]);



    const convertToPixels = useCallback((ctx: CanvasRenderingContext2D) => {
        pixelsRef.current = [];
        const landscapeMobile = window.innerHeight > window.innerWidth && window.innerWidth < 500
        let minX = landscapeMobile ? window.innerHeight : window.innerWidth;
        let maxX = 0;
        let minY = landscapeMobile ? window.innerWidth : window.innerHeight;
        let maxY = 0;
        const imageData = ctx.getImageData(0, 0, canvasWidth, canvasHeight).data;
        for (let y = 0; y < canvasHeight; y += pixelSize) {
            for (let x = 0; x < canvasWidth; x += pixelSize) {
                const index = (y * canvasWidth + x) * 4;
                const opacity = imageData[index + 3];
                if (opacity > 1) {
                    const red = imageData[index];
                    const green = imageData[index + 1];
                    const blue = imageData[index + 2];
                    const rgb = 'rgb(' + red + ',' + green + ',' + blue + ')';
                    const newPixel = {
                        x: x,
                        y: y,
                        color: rgb,
                        originX: x,
                        originY: y,
                        distanceX: 0,
                        distanceY: 0,
                        distance: 0,
                        vx: 0,
                        vy: 0,
                        gravity: 0,
                        angle: 0,
                    };
                    pixelsRef.current.push(newPixel);

                    if (minX > x) minX = x;
                    if (maxX < x) maxX = x;
                    if (minY > y) minY = y;
                    if (maxY < y) maxY = y;
                };
            };
        };
        minXRef.current = minX;
        maxXRef.current = maxX;
        minYRef.current = minY;
        maxYRef.current = maxY;

    }, [pixelSize, canvasWidth, canvasHeight]);



    const canvasAnimate = () => {
        if (!isConverted) {
            const ctx = canvas!.getContext('2d')!;
            convertToPixels(ctx);
            ctx.clearRect(0, 0, canvasWidth, canvasHeight);
            ctx.fillStyle = 'black'
            pixelsRef.current.map(pixel => {
                return ctx.fillRect(pixel.x, pixel.y, pixelSize, pixelSize);
                //setPixels(pixels => [...pixels, pixel]);
            });
            setIsConverted(true);
            setIsMovingPixel(true);
            setIsCanvasEffect(true);
            dispatch(appActions.setIsRasterShown(false));
        };
        setIsMovingPixel(true);
    };



    const initCanvas = useCallback(() => {
        const canvas = canvasRef.current!;
        const ctx = canvas.getContext('2d')!;

        canvas.style.position = 'absolute';
        canvas.style.fontFamily = 'Verdana';
        canvas.style.fontWeight = '900';
        canvas.style.color = 'black';
        canvas.style.background = '#fff';

        let width = window.innerWidth;
        let height = window.innerHeight;
        const landscapeMobile = height > width && width < 500
        let textposition = { width: width / 2, height: height / 3.5 }

        if (landscapeMobile) {
            canvas.style.fontSize = 0.20 * height + 'px';
            canvas.width = height;
            canvas.height = width;
            setCanvasWidth(height);
            setCanvasHeight(width);
            textposition = { width: height / 2 - text.length * height * 0.075, height: width / 3.5 + 50 };
            //ctx.translate(-text.length * height * 0.075, 50);
        } else {
            canvas.width = width;
            canvas.height = height;
            canvas.style.fontSize = 0.20 * width + 'px';
            setCanvasWidth(width);
            setCanvasHeight(height);
            ctx.textAlign = 'center';
            ctx.textBaseline = 'middle';
        };

        setCanvas(canvas);
        ctx.font = canvas.style.font;
        ctx.fillStyle = 'black';
        ctx.lineWidth = pixelSize;

        setCtx(ctx);

        ctx!.fillText(text, textposition.width, textposition.height);
        if (!isCanvasDrawn) dispatch(appActions.setIsCanvasDrawn(true));
    }, [canvasRef, isCanvasDrawn, pixelSize, text, dispatch]);



    // Init and drawing canvas
    useEffect(() => {
        const canvas = canvasRef.current;
        if (canvas && isInit) {
            initCanvas();
            setIsInit(false);
        };
        window.addEventListener('resize', initCanvas);
        return () => {
            window.removeEventListener('resize', initCanvas);
        };
    }, [canvasRef, isInit, initCanvas]);


    const updatePixels = useCallback((ctx: CanvasRenderingContext2D) => {
        const landscapeMobile = window.innerHeight > window.innerWidth && window.innerWidth < 500
        const radius = window.innerWidth * window.innerHeight;
        const cX = !landscapeMobile ? (minXRef.current + maxXRef.current) / 2
            : (minXRef.current + maxXRef.current) / 2 + text.length * window.innerHeight * 0.075;
        const cY = !landscapeMobile ? (minYRef.current + maxYRef.current) / 2
            : (minYRef.current + maxYRef.current) / 2 - 50;

        const accelerating = Math.random() * 0.6 + 0.15;
        const slowing = Math.random() * 0.1 + 0.05;

        pixelsRef.current.forEach(pixel => {
            let dx = cX - pixel.x;
            let dy = cY - pixel.y;
            let distance = dx * dx + dy * dy;
            let gravity = radius / distance;

            if (distance < radius) {
                let angle = Math.atan2(dy, dx);
                let vx = pixel.vx + gravity * Math.cos(angle);
                let vy = pixel.vy + gravity * Math.sin(angle);
                let x = pixel.x + (vx * accelerating) + (pixel.originX - pixel.x) * slowing;
                let y = pixel.y + (vy * accelerating) + (pixel.originY - pixel.y) * slowing;

                ctx.fillStyle = 'black';
                ctx.fillRect(x, y, pixelSize, pixelSize);
                pixel.vx = vx;
                pixel.vy = vy;
                pixel.x = x;
                pixel.y = y;
            };
        });
    }, [pixelSize, text.length]);


    const renderFrame = useCallback(() => {
        ctx!.clearRect(0, 0, canvasWidth, canvasHeight);
        updatePixels(ctx!);
    }, [ctx, updatePixels, canvasWidth, canvasHeight]);



    const animate = useCallback(() => {
        if (!canvas) return;
        const time = Date.now() - timeValueRef.current;
        const nextValue = time * animationSpeed;

        // Animation stop
        if (nextValue > (animationMax + 1)) {
            cancelAnimationFrame(requestAnimationRef.current!);
            requestAnimationRef.current = null;
            targetValueRef.current = 1;
            ctx!.clearRect(0, 0, canvasWidth, canvasHeight);
            setIsMovingPixel(false);
            setIsConverted(false);
            setIsCanvasEffect(false);
            changeTitle();
            return
        };

        // Animation
        if (nextValue > targetValueRef.current) {
            targetValueRef.current += 1;
            renderFrame();
        };
        requestAnimationRef.current = requestAnimationFrame(animate);

    }, [canvas, ctx, canvasHeight, canvasWidth, animationMax, renderFrame, changeTitle]);


    // Animate Canvas
    useEffect(() => {
        if (isMovingPixel) {
            timeValueRef.current = Date.now();
            requestAnimationRef.current = requestAnimationFrame(animate);
        };
        return () => {
            cancelAnimationFrame(requestAnimationRef.current!);
        };
    }, [isMovingPixel, animate]);



    const changeResolution = (e: any) => {
        setPixelSize(parseInt(e.target.value));
    }

    const ShowPixelSize = () => {
        return (
            <Fragment>
                <div className='showPixelSize' style={{ visibility: isCanvasEffect ? 'hidden' : 'visible' }}>
                    <label htmlFor='pixelSize' id='pixelSizeLabel '>Resolution: {pixelSize} px</label>
                    < input type='range' min='1' max='20' defaultValue={pixelSize}
                        onMouseUp={changeResolution}
                    />
                </div>
            </Fragment>
        );
    };
    return { canvasAnimate, ShowPixelSize };

};





