import { useMemo, useCallback, useEffect } from 'react';
import { useReduxDispatch, useReduxSelector } from '../../../store/ReduxTypes';
import { chartActions } from '../../../store/datalistSlices/ChartSlice';
import { useModalThunks } from './ModalThunks';
import type { Covids } from '../../../store/datalistSlices/DataSlice';




export const useChartThunks = () => {
    const dispatch = useReduxDispatch();
    const { makeRefreshModal } = useModalThunks();

    const covids = useReduxSelector(state => state.data.covids);
    const covidsWithoutFilter = useReduxSelector(state => state.data.covidsWithoutFilter);
    const filterActive = useReduxSelector(state => state.filtering.filterActive);
    const isOnlySelected = useReduxSelector(state => state.filtering.isOnlySelected);


    const dataLabel = useReduxSelector(state => state.chart.dataLabel);
    const dataValue = useReduxSelector(state => state.chart.dataValue);
    const dataSource = useReduxSelector(state => state.chart.dataSource);
    const dataChart = useReduxSelector(state => state.chart.dataChart);
    const timeMin = useReduxSelector(state => state.chart.timeMin);
    const timeMax = useReduxSelector(state => state.chart.timeMax);


    // Sort data by date and time
    const sortData = useCallback((data: Covids[]) => {
        return data.sort(function (a, b) {
            return a.date.localeCompare(b.date) || a.time.localeCompare(b.time);
        });
    }, []);

    const cloneCovids = useMemo(() => sortData([...covids]), [sortData, covids]);
    const dataAll = useMemo(() => sortData([...covidsWithoutFilter]), [sortData, covidsWithoutFilter]);

    // Set DataSource
    const selectDataSourceHandler = useCallback((source: string, prop: number) => {
        let arraySource = [...dataSource];
        arraySource[prop] = source;
        dispatch(chartActions.setDataSource(arraySource));

        let arrayLabel = [...dataLabel];
        arrayLabel = dataChart.map((item) => item.date);
        console.log('arrayLabel', arrayLabel);
        dispatch(chartActions.setDataLabel(arrayLabel));

        let arrayValue = [...dataValue];
        arrayValue[prop] = dataChart.map((item) => item[source as keyof Covids] as number);
        console.log('arrayValue', prop, ':', arrayValue[prop]);
        dispatch(chartActions.setDataValue(arrayValue));
    }, [dataSource, dataLabel, dataValue, dataChart, dispatch]);


    // Set Init Chart Data Source
    useEffect(() => {
        dispatch(chartActions.setDataSource(['activeInfected', 'recovered', 'infected']));
        dispatch(chartActions.setDataLabel(cloneCovids.map((item) => item.date)));
        dispatch(chartActions.setDataValue([
            cloneCovids.map((item) => item['activeInfected']),
            cloneCovids.map((item) => item['recovered']),
            cloneCovids.map((item) => item['infected'])
        ]
        ));
        dispatch(chartActions.setDataChart([...cloneCovids]));
        dispatch(chartActions.setIsDataFromDatalist(filterActive === 0 && !isOnlySelected ? false : true));

        if (cloneCovids.length > 0) {
            dispatch(chartActions.setTimeMin(cloneCovids[0].date));
            dispatch(chartActions.setTimeMax(cloneCovids[cloneCovids.length - 1].date));
        };
    }, [cloneCovids, filterActive, isOnlySelected, dispatch]);


    // Set Time Scale
    useEffect(() => {
        let array = dataChart.filter(prop => {
            let filterPass = true;
            const newdatefilter = new Date(prop.date);
            filterPass = filterPass && (new Date(timeMin) <= newdatefilter);
            filterPass = filterPass && (new Date(timeMax) >= newdatefilter);
            return filterPass;
        });
        dispatch(chartActions.setDataLabel(array.map((item) => item.date)));
        dispatch(chartActions.setDataValue([
            array.map((item) => item[dataSource[0] as keyof Covids] as number),
            array.map((item) => item[dataSource[1] as keyof Covids] as number),
            array.map((item) => item[dataSource[2] as keyof Covids] as number)
        ]
        ));
    }, [timeMin, timeMax, dataChart, dataSource, dispatch]);


    // Delete Data Source Hide Chart Modal
    const deleteSourceDataHandler = () => {
        dispatch(chartActions.setDataLabel(['']));
        dispatch(chartActions.setDataValue([[], [], []]));
        dispatch(chartActions.setDataSource(['', '', '']));
        dispatch(chartActions.setChartType('line'));
        dispatch(chartActions.setIsDataFromDatalist(filterActive === 0 && !isOnlySelected ? false : true));
        dispatch(chartActions.setTimeMin(cloneCovids[0].date));
        dispatch(chartActions.setTimeMax(cloneCovids[cloneCovids.length - 1].date));
    };


    // Set Chart Type
    const selectChartTypeHandler = (type: string) => {
        dispatch(chartActions.setChartType(type));
        if (type !== 'pie' && type !== 'doughnut' && type !== 'polarArea') {
            dispatch(chartActions.setChartLabel(true));
        } else { dispatch(chartActions.setChartLabel(false)) };
    };


    // Set Unique DataSource list 
    const uniqueListDataSource = (field: string) => {
        let sortSelected = false;
        dataSource.forEach(item => {
            if (item === field) sortSelected = true
        });
        return sortSelected;
    }


    const setDataMinHandler = (prop: string) => {
        dispatch(chartActions.setTimeMin(prop));
    }


    const setDataMaxHandler = (prop: string) => {
        dispatch(chartActions.setTimeMax(prop));
    }

    // Set Data From DataList or All Data
    const dataCloneHandler = (prop: string) => {
        dispatch(chartActions.setIsDataFromDatalist(prop === 'true' ? true : false));

        if (prop === 'true') {
            dispatch(chartActions.setDataChart([...cloneCovids]));
            dispatch(chartActions.setTimeMin(cloneCovids[0].date));
            dispatch(chartActions.setTimeMax(cloneCovids[cloneCovids.length - 1].date));
        }

        else {
            dispatch(chartActions.setDataChart([...dataAll]));
            dispatch(chartActions.setTimeMin(dataAll[0].date));
            dispatch(chartActions.setTimeMax(dataAll[dataAll.length - 1].date));
        };
        makeRefreshModal(true);
    }


    // Create unique Data from Date field
    const uniqueListData = (prop: Covids[], field: string, min: string, max: string) => {
        const mapped = prop.map((item, index) => item[field as keyof Covids] ? item[field as keyof Covids] : null);
        const filtered = mapped.filter((field, index) => mapped.indexOf(field) === index);

        if (min) {
            let array = filtered.filter(item => {
                let filterPass = true;
                const newdatefilter = new Date(item as string);
                filterPass = filterPass && (new Date(min) <= newdatefilter);
                return filterPass;
            });
            return array;

        } else {
            let array = filtered.filter(item => {
                let filterPass = true;
                const newdatefilter = new Date(item as string);
                filterPass = filterPass && (new Date(max) >= newdatefilter);
                return filterPass;
            });
            return array;
        }
    }

    return {
        selectDataSourceHandler, deleteSourceDataHandler, selectChartTypeHandler, uniqueListDataSource,
        setDataMinHandler, setDataMaxHandler, dataCloneHandler, uniqueListData
    };

};

