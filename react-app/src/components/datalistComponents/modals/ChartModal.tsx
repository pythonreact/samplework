import { Fragment, MutableRefObject, useRef } from 'react';
import '../../../scss/datalistScss/Datalist.scss';
import { useChart } from '../../../logics/datalistLogics/UseChart';
import '../../../scss/datalistScss/ChartModal.scss';
import PortalReactDOM from 'react-dom';
import styled, { keyframes } from 'styled-components';
import { useReduxSelector } from '../../../store/ReduxTypes';
import { useModalThunks } from '../../../logics/datalistLogics/thunks/ModalThunks';
import { useEffectThunks } from '../../../logics/datalistLogics/thunks/EffectThunks';
import { useChartThunks } from '../../../logics/datalistLogics/thunks/ChartThunks';
import { envFilterElements } from '../../../store/datalistSlices/FilteringSlice';
import type { ItemsFilters } from '../../../store/datalistSlices/FilteringSlice';


interface StyledProps {
    cHeight: string;
    cWidth: string;
    cSpeed: string;
    cLabel: string;
};


const downAnimation = (props: StyledProps) => keyframes`
        0% {top: ${props.cLabel}px;}
        50% {top: ${props.cHeight}px;}
        100% {top: ${props.cLabel}px;}
    `;

const upAnimation = (props: StyledProps) => keyframes`
        0% {top: ${props.cHeight}px;}
        50% {top: ${props.cLabel}px;}
        100% {top: ${props.cHeight}px;}
    `;

const RasterDown = styled.div.attrs((props) => props) <StyledProps>`
        margin: 0;
        background: linear-gradient(to bottom, #873b31 0%, #000000 2%, #873b31 2%, #873b31 4%, #873b31 4%, #873b31 6%, #ba7369 6%, #ba7369 8%, #873b31 8%, #873b31 10%, #ba7369 10%, #ba7369 12%, #ba7369 12%, #ba7369 14%, #dce78c 14%, #dce78c 16%, #ba7369 16%, #ba7369 18%, #dce78c 18%, #dce78c 20%, #dce78c 20%, #dce78c 22%, #ffffff 22%, #ffffff 24%, #dce78c 24%, #dce78c 26%, #ffffff 26%, #ffffff 28%, #ffffff 28%, #ffffff 30%, #dce78c 30%, #dce78c 32%, #ffffff 32%, #ffffff 34%, #dce78c 34%, #dce78c 36%, #dce78c 36%, #dce78c 38%, #ba7369 38%, #ba7369 40%, #dce78c 40%, #dce78c 42%, #ba7369 42%, #ba7369 44%, #ba7369 44%, #ba7369 46%, #873b31 46%, #873b31 48%, #ba7369 48%, #ba7369 50%, #873b31 50%, #873b31 52%, #873b31 52%, #873b31 54%, #000000 54%, #000000 56%, #873b31 56%, #873b31 58%, rgba(0, 0, 0, 0) 58%, rgba(0, 0, 0, 0) 100%);
        height: 10vh;
        --width: ${(props) => props.cWidth}px;
        width: var(--width);
        left: calc(100% - var(--width));
        position: absolute;
        animation: ${downAnimation} ${(props) => props.cSpeed}s linear infinite;
        animation-delay: 1s;
    `;

const RasterUp = styled.div.attrs((props) => props) <StyledProps>`
        margin: 0;
        background: linear-gradient(to bottom, #873b31 0%, #000000 2%, #873b31 2%, #873b31 4%, #873b31 4%, #873b31 6%, #ba7369 6%, #ba7369 8%, #873b31 8%, #873b31 10%, #ba7369 10%, #ba7369 12%, #ba7369 12%, #ba7369 14%, #dce78c 14%, #dce78c 16%, #ba7369 16%, #ba7369 18%, #dce78c 18%, #dce78c 20%, #dce78c 20%, #dce78c 22%, #ffffff 22%, #ffffff 24%, #dce78c 24%, #dce78c 26%, #ffffff 26%, #ffffff 28%, #ffffff 28%, #ffffff 30%, #dce78c 30%, #dce78c 32%, #ffffff 32%, #ffffff 34%, #dce78c 34%, #dce78c 36%, #dce78c 36%, #dce78c 38%, #ba7369 38%, #ba7369 40%, #dce78c 40%, #dce78c 42%, #ba7369 42%, #ba7369 44%, #ba7369 44%, #ba7369 46%, #873b31 46%, #873b31 48%, #ba7369 48%, #ba7369 50%, #873b31 50%, #873b31 52%, #873b31 52%, #873b31 54%, #000000 54%, #000000 56%, #873b31 56%, #873b31 58%, rgba(0, 0, 0, 0) 58%, rgba(0, 0, 0, 0) 100%);
        height: 10vh;
        --width: ${(props) => props.cWidth}px;
        width: var(--width);
        left: calc(100% - var(--width));
        position: absolute;
        animation: ${upAnimation} ${(props) => props.cSpeed}s linear infinite;
        animation-delay: 1s;
    `;

const portalElement = document.getElementById('modals')!;



export const ChartModal = () => {
    const { hideModalHandler } = useModalThunks();
    const { makeChartEffectHandler } = useEffectThunks();

    const { selectDataSourceHandler, deleteSourceDataHandler, selectChartTypeHandler, uniqueListDataSource,
        setDataMinHandler, setDataMaxHandler, dataCloneHandler, uniqueListData } = useChartThunks();

    const filterActive = useReduxSelector(state => state.filtering.filterActive);
    const isOnlySelected = useReduxSelector(state => state.filtering.isOnlySelected);
    const isChartEffect = useReduxSelector(state => state.effect.isChartEffect);
    const dataLabel = useReduxSelector(state => state.chart.dataLabel);
    const dataValue = useReduxSelector(state => state.chart.dataValue);
    const dataSource = useReduxSelector(state => state.chart.dataSource);
    const chartType = useReduxSelector(state => state.chart.chartType);
    const dataChart = useReduxSelector(state => state.chart.dataChart);
    const chartLabel = useReduxSelector(state => state.chart.chartLabel);
    const timeMin = useReduxSelector(state => state.chart.timeMin);
    const timeMax = useReduxSelector(state => state.chart.timeMax);

    const canvasRef = useRef() as MutableRefObject<HTMLCanvasElement>;
    //const canvasRef = useRef<HTMLCanvasElement | null>(null);
    const isDataFromDatalist = useReduxSelector(state => state.chart.isDataFromDatalist);

    const envChartColor: string[] = JSON.parse(process.env.REACT_APP_CHART_COLOR as string);
    const envChartTypes: string[] = JSON.parse(process.env.REACT_APP_CHART_TYPES as string);


    //Chart Hook
    const { chartWidth, chartHeight } = useChart(canvasRef.current, { chartType, dataLabel, dataSource, dataValue });
    //const { chartWidth, chartHeight } = useChart(canvasRef, { chartType, dataLabel, dataSource, dataValue });

    // Set Data Source
    const DataSourceHtml = (prop: number) =>
        <Fragment>
            <select className="form-select select" style={{ color: envChartColor[prop] }}
                value={dataSource[prop]} onChange={(e) => {
                    selectDataSourceHandler(e.target.value, prop);
                }}>
                <option value=''>Choose...</option>

                {envFilterElements.map((item: ItemsFilters) =>
                    item.fieldname !== 'date' && item.fieldname !== 'time' ?
                        <option key={item.id} value={item.fieldname}
                            disabled={uniqueListDataSource(item.fieldname)}>
                            {item.fieldname}
                        </option>
                        : null
                )}
            </select >
        </Fragment >

    return (
        <Fragment>
            {PortalReactDOM.createPortal(
                <div className="modal fade-color" id="refChartModal" tabIndex={-1}>
                    <div className="modal-dialog modal-xl modal-fullscreen-lg-down">

                        <div className='modal-content modal-content-notanimated-chart'>
                            <div className="modal-header">
                                <h5 className="modal-title marginRight5">
                                    Chart
                                </h5>

                                {/* Time Scale */}
                                <div className="input-group mb3">
                                    <span className="responsiveLarge-Filter input-group-text"> Time Scale: </span>

                                    {/* Select min value Time scale*/}
                                    <select className="form-select select"
                                        //style={{ dropupAuto: 'false' }}
                                        value={timeMin}
                                        onChange={(e) => { setDataMinHandler(e.target.value) }}>

                                        <option value='' disabled hidden>Choose...</option>
                                        {uniqueListData(dataChart, 'date', '', timeMax).map((data, index) =>
                                            <option key={data} value={data as string}>
                                                {data}
                                            </option>)}
                                    </select>

                                    {/* Select max value Time scale*/}
                                    <select className="form-select select"
                                        value={timeMax}
                                        onChange={(e) => { setDataMaxHandler(e.target.value); }}>

                                        <option value='' disabled hidden>Choose...</option>
                                        {uniqueListData(dataChart, 'date', timeMin, '').map((data, index) =>
                                            <option key={data} value={data as string}>
                                                {data}
                                            </option>)}
                                    </select>
                                </div>

                                {/* Chart Effect */}
                                <div className="input-group mb3">
                                    <button className='btn-outline-custom marginLeft5'
                                        onClick={() => makeChartEffectHandler(!isChartEffect)}>
                                        <span> Effect {isChartEffect ? 'Off' : 'On'} </span>
                                    </button>
                                </div>

                                <button type="button" className="btn-close btn-outline-custom btn-modal marginLeft15"
                                    onClick={() => {
                                        hideModalHandler('refChartModal');
                                        deleteSourceDataHandler();
                                    }}>
                                </button>
                            </div>

                            {/* Select Data */}
                            <div className='input-group mb-3'>
                                <span className="responsiveLarge-Filter input-group-text">
                                    DataList
                                </span>
                                <select className="form-select select"
                                    value={isDataFromDatalist.toString()} onChange={(e) => {
                                        dataCloneHandler(e.target.value);
                                    }}>
                                    <option value={'true'} disabled={filterActive === 0 && !isOnlySelected}> {filterActive !== 0 || isOnlySelected ? 'Filtered' : 'Set Filter in DataList'}</option>
                                    <option value={'false'}> All Data</option>
                                </select>

                                <span className="responsiveLarge-Filter input-group-text">
                                    Chart Type
                                </span>
                                <select className="form-select select"
                                    value={chartType} onChange={(e) => {
                                        selectChartTypeHandler(e.target.value);
                                    }}>
                                    <option value='' disabled hidden>Choose...</option>
                                    {envChartTypes.map((item: string) =>
                                        <option key={item} value={item}>
                                            {item}
                                        </option>
                                    )}
                                </select>

                                <span className="responsiveLarge-Filter input-group-text">
                                    Data Source
                                </span>
                                {DataSourceHtml(0)}
                                {DataSourceHtml(1)}
                                {DataSourceHtml(2)}
                            </div>

                            <div className="modal-body wrap">
                                <div className={`${isChartEffect && (dataSource[0] || dataSource[1] || dataSource[2]) ?
                                    'displayBlock' : 'displayNone'}`}>
                                    <RasterDown cWidth={chartWidth.toString()} cHeight={chartHeight.toString()} cLabel={chartLabel ? '20' : '0'} cSpeed={chartLabel ? '5' : '10'}>
                                        <p />
                                    </RasterDown>
                                    <RasterUp cWidth={chartWidth.toString()} cHeight={chartHeight.toString()} cLabel={chartLabel ? '20' : '0'} cSpeed={chartLabel ? '5' : '10'}>
                                        <p />
                                    </RasterUp>
                                </div>
                                <canvas className='canvas' id="ChartId" ref={canvasRef} />

                                <div className={isChartEffect ? 'overlay' : 'overlay-notanimated'}></div>
                            </div>

                        </div>

                    </div>
                </div>
                , portalElement)}
        </Fragment >
    );
};



