import { Fragment } from 'react';
import moment from 'moment';
import { useReduxSelector } from '../../store/ReduxTypes';
import { useModalThunks } from '../../logics/datalistLogics/thunks/ModalThunks';
import { useFilteringThunks } from '../../logics/datalistLogics/thunks/FilteringThunks';
import { useDataThunks } from '../../logics/datalistLogics/thunks/DataThunks';
import { useTableThunks } from '../../logics/datalistLogics/thunks/TableThunks';
import { FilterHeaderButtons, SortHeaderButtons } from './FilterSortButtons';




export const TableMain = () => {
    const { deleteSelectedHandler, deleteHandler } = useModalThunks();
    const { deleteAllFiltersHandler, onlySelectedHandler } = useFilteringThunks();
    const { editHandler } = useDataThunks();
    const { selectedHandler, deSelectHandler } = useTableThunks();


    const covids = useReduxSelector(state => state.data.covids);
    const tableStyle = useReduxSelector(state => state.table.tableStyle);
    const isLoading = useReduxSelector(state => state.table.isLoading);
    const isOnlySelected = useReduxSelector(state => state.filtering.isOnlySelected);
    const filterActive = useReduxSelector(state => state.filtering.filterActive);
    const selectedData = useReduxSelector(state => state.table.selectedData);
    const activeFilters = isOnlySelected ? filterActive + 1 : filterActive;


    return (
        < Fragment >
            <div className={tableStyle}>
                <table className="table table-striped table-sm table-responsive">
                    <thead className="tableheader">
                        <tr>
                            <th>
                                <div className="btn-group" role="group">
                                    {/* Delete Filters button */}
                                    <button type="button" className="btn btnStyle btn-outline-custom btn-sm m-1 rounded buttonFilter-Delete"
                                        disabled={isLoading} onClick={() => deleteAllFiltersHandler(false)}>
                                        <span>Delete</span><br />
                                        <span>{activeFilters !== 0 ? activeFilters : null}Filter</span>
                                    </button>

                                    {/* Filter Selected button */}
                                    <input className="btn-check" type="checkbox" id="btn-check"
                                        disabled={isLoading} checked={isOnlySelected}
                                        onChange={(e) => { onlySelectedHandler(e.target); }} />
                                    <label className={`btn btnStyle btn-outline-filter btn-sm m-1 rounded
                                        ${isOnlySelected ? 'buttonFilter-IsOnlySelected' : 'buttonFilter-Selected'}`}
                                        htmlFor="btn-check">
                                        <span>Filter {selectedData.length !== 0 ? selectedData.length : null}</span><br />
                                        <span>Selected</span>
                                    </label>
                                </div>
                            </th>
                            <FilterHeaderButtons />
                            <th>
                            </th>
                            <th>
                            </th>
                        </tr>

                        <tr>
                            <th>
                                <div className="btn-group" role="group">
                                    {/* Deselect button */}
                                    <button type="button" className="btn btnStyle btn-outline-custom btn-sm m-1 rounded buttonFilter-DeSelect"
                                        disabled={isLoading} onClick={() => deSelectHandler()}>
                                        <span>De-</span><br /> <span>select</span>
                                    </button>

                                    {/* Delete Selected button */}
                                    <button type="button" className="btn btnStyle btn-outline-custom btn-sm m-1 rounded buttonFilter-Selected"
                                        disabled={isLoading} onClick={() => deleteSelectedHandler()}>
                                        <span>Delete {selectedData.length !== 0 ? selectedData.length : null}</span><br />
                                        <span>Selected</span>
                                    </button>
                                </div>
                            </th>
                            <SortHeaderButtons />
                            <th>
                            </th>
                            <th>
                            </th>
                        </tr>

                        <tr className="tableHeaderColumn">
                            <th>Select</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Infected</th>
                            <th>Active Infected</th>
                            <th>Deceased</th>
                            <th>Recovered</th>
                            <th>Quarantined</th>
                            <th>Tested</th>
                            <th className="width270">Source Web</th>
                            <th>Options</th>
                        </tr>
                    </thead>

                    <tbody>
                        {covids.map(dataItem =>
                            <tr key={dataItem.id}>
                                {/* Select button */}
                                <td td-title='Select'><input className="custom-selected-input form-check-input" type="checkbox"
                                    id="selected" checked={selectedData.includes(dataItem.id)}
                                    onChange={(e) => { selectedHandler(e.target, dataItem.id); }} />
                                </td>

                                <td td-title='Date'>{dataItem.date}</td>
                                <td td-title='Time'>{moment(dataItem.time, 'HH:mm:ss').format('HH:mm')}</td>
                                <td td-title='Infected'>{dataItem.infected.toLocaleString('en')}</td>
                                <td td-title='ActiveInfected'>{dataItem.activeInfected.toLocaleString('en')}</td>
                                <td td-title='Deceases'>{dataItem.deceased.toLocaleString('en')}</td>
                                <td td-title='Recovered'>{dataItem.recovered.toLocaleString('en')}</td>
                                <td td-title='Quarantined'>{dataItem.quarantined.toLocaleString('en')}</td>
                                <td td-title='Tested'>{dataItem.tested.toLocaleString('en')}</td>
                                <td td-title='SourceWeb' className={`${tableStyle === 'table-scroll' ? 'noWrap' : null}`}>
                                    {dataItem.sourceWeb}</td>

                                <td> {/* Edit icon button in list*/}
                                    <div className="btn-group" role="group">
                                        <button type="button" className="btn btnStyle btn-light mr-1 marginRight10"
                                            disabled={isLoading}
                                            onClick={() => editHandler(dataItem)}>
                                            <span className="bi bi-pencil-square edit"></span>
                                        </button>

                                        {/* Delete icon button in list*/}
                                        <button type="button" className="btn btnStyle btn-light mr-1"
                                            disabled={isLoading}
                                            onClick={() => deleteHandler(dataItem.id)}>
                                            <span className="bi bi-trash-fill delete"></span>
                                        </button>
                                    </div>
                                </td>
                                <td></td>
                            </tr>
                        )}
                    </tbody>
                </table>
            </div>
        </Fragment >
    )
}








