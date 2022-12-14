import { useEffect, useState } from 'react';
import Chart, { Plugin } from "chart.js/auto";
import 'chartjs-adapter-moment';
import { ChartConfiguration, ChartTypeRegistry } from 'chart.js';
import type { ChartState } from '../../store/datalistSlices/ChartSlice';




export const useChart = (refChart: HTMLCanvasElement, props: Partial<ChartState>) => {
    const [chartWidth, setChartWidth] = useState<number>(0);
    const [chartHeight, setChartHeight] = useState<number>(0);
    const envChartColor: string[] = JSON.parse(process.env.REACT_APP_CHART_COLOR as string);


    useEffect(() => {
        if (typeof props.dataSource !== 'undefined' && typeof props.dataValue !== 'undefined' && refChart) {


            const chartplugin: Plugin = {
                id: "chartarea",
                afterDraw: (chart) => {
                    setChartWidth(parseInt(chart.chartArea.width.toString()));
                    setChartHeight(parseInt(chart.chartArea.height.toString()));
                }
            };

            Chart.register(chartplugin);

            const config: ChartConfiguration = {
                type: props.chartType as keyof ChartTypeRegistry,
                data: {
                    labels: props.dataLabel ? props.dataLabel : [''],
                    datasets: [
                        {
                            label: props.dataSource[0] ? props.dataSource[0] : '',
                            data: props.dataValue[0],
                            // ? props.dataValue[0] : null,
                            backgroundColor: 'black',
                            borderColor: envChartColor[0],
                            hoverBackgroundColor: 'white',
                            hoverBorderColor: 'white',
                            borderWidth: 5,
                            fill: 'origin',
                        },
                        {
                            label: props.dataSource[1] ? props.dataSource[1] : '',
                            data: props.dataValue[1],
                            //  ? props.dataValue[1] : null,
                            backgroundColor: 'black',
                            borderColor: envChartColor[1],
                            hoverBackgroundColor: 'white',
                            hoverBorderColor: 'white',
                            borderWidth: 5,
                            fill: 'origin',
                        },
                        {
                            label: props.dataSource[2] ? props.dataSource[2] : '',
                            data: props.dataValue[2],
                            //  ? props.dataValue[2] : null,
                            backgroundColor: 'black',
                            borderColor: envChartColor[2],
                            hoverBackgroundColor: 'white',
                            hoverBorderColor: 'white',
                            borderWidth: 5,
                            fill: 'origin',
                        }
                    ]
                },
                options: {
                    plugins: {
                        tooltip: {
                            enabled: true,
                        },
                        legend: {
                            display: (props.chartType !== 'pie' && props.chartType !== 'doughnut' && props.chartType !== 'polarArea') ? true : false,
                            labels: { color: 'red' },
                        },
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                display: (props.dataSource[0] || props.dataSource[1] || props.dataSource[2]) ? true : false,
                                color: 'black',
                                callback: (value) => {
                                    if (Math.floor(parseInt(value as string)) === value) { return value }
                                },
                                font: {
                                    size: 14,
                                },
                            },
                            grid: { display: false }
                        },
                        x: {
                            display: (props.dataSource[0] || props.dataSource[1] || props.dataSource[2]) ? true : false,
                            position: 'bottom',
                            type: 'timeseries',
                            ticks: {
                                color: 'black',
                                autoSkip: true,
                                maxTicksLimit: chartWidth < 600 ? 7 : 10,
                                minRotation: 45,
                                font: {
                                    size: 14,
                                }
                            },
                            grid: { display: false },
                            time: {
                                displayFormats: {
                                    year: 'YYYY MMM DD',
                                    month: 'YYYY MMM DD',
                                    day: 'YYYY MMM DD',
                                    hour: 'MMM DD',
                                    minute: 'MMM DD',
                                    second: 'MMM DD',
                                    millisecond: 'MMM DD'
                                }
                            }
                        }
                    },
                    responsive: true,
                    maintainAspectRatio: true,
                    elements: {
                        point: { radius: 0 }
                    },
                }
            };

            const newChart = new Chart(refChart, config);

            return () => newChart.destroy();
        };
    }, [refChart, props, chartWidth, envChartColor]);

    return { chartWidth, chartHeight };
};


