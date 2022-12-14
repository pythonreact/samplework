import { Fragment } from 'react';
import PortalReactDOM from 'react-dom';
import { useReduxSelector } from '../../../store/ReduxTypes';
import { useModalThunks } from '../../../logics/datalistLogics/thunks/ModalThunks';
import { useFilteringThunks } from '../../../logics/datalistLogics/thunks/FilteringThunks';
import { getYear, uniqueList, getMonth, getDay } from '../../../logics/datalistLogics/Logics';



const portalElement = document.getElementById('modals')!;




export const FilteringModal = () => {
    const { hideModalHandler, makeRefreshModal } = useModalThunks();
    const { deleteFiltersCopy, itemListType, Item, deleteAllFiltersHandler, submitFiltersHandler } = useFilteringThunks();

    const isModalEffect = useReduxSelector(state => state.effect.isModalEffect);
    const filtersCopy = useReduxSelector(state => state.filtering.filtersCopy);
    const covidsWithoutFilter = useReduxSelector(state => state.data.covidsWithoutFilter);
    const envMonths: string[] = JSON.parse(process.env.REACT_APP_MONTHS as string);
    const envDays: string[] = JSON.parse(process.env.REACT_APP_DAYS as string);

    return (
        <Fragment>
            {PortalReactDOM.createPortal(
                <div className="modal fade" id="refModalFiltering" tabIndex={-1} >
                    <div className="modal-dialog modal-lg modal-dialog-centered">

                        <div className={isModalEffect ? 'modal-content modal-content-color'
                            : 'modal-content modal-content-notanimated'}>
                            <div className="modal-header">
                                <h5 className="modal-title">Set Filtering Range</h5>
                                <button type="button" className="btn-close btn-outline-custom btn-modal"
                                    onClick={() => {
                                        deleteFiltersCopy();
                                        hideModalHandler('refModalFiltering');
                                    }}>
                                </button>
                            </div>

                            <div className="modal-body">
                                <div className="d-flex flex-row bd-highlight mb-3">
                                    <div className="p-2 w-100 bd-highlight">

                                        {filtersCopy.map((item) =>
                                            <div key={item.id}>
                                                <div className="d-flex flex-row">
                                                    <div className="btn-group me-auto">
                                                        {item.type === "date" ?
                                                            <div className="form-check form-check-inline float-start">
                                                                <input className="custom-control-input form-check-input" type="radio" id="dateselect"
                                                                    checked={item.listtype === 'dateselect'} onChange={() => {
                                                                        itemListType("listtype", "dateselect", item.id);
                                                                        makeRefreshModal(true);
                                                                    }} />
                                                                <label className="custom-control-label" htmlFor="dateselect">Date</label>
                                                            </div>
                                                            : null}

                                                        <div className="form-check form-check-inline float-start">
                                                            <input className="custom-control-input form-check-input" type="radio" id="select"
                                                                checked={item.listtype === 'select'} onChange={() => {
                                                                    itemListType("listtype", "select", item.id);
                                                                    makeRefreshModal(true);
                                                                }} />
                                                            <label className="custom-control-label" htmlFor="select">Select</label>
                                                        </div>

                                                        <div className="form-check form-check-inline float-start">
                                                            <input className="custom-control-input form-check-input" type="radio" id="input"
                                                                checked={item.listtype === 'input'} onChange={() => {
                                                                    itemListType("listtype", "input", item.id);
                                                                    makeRefreshModal(true);
                                                                }} />
                                                            <label className="custom-control-label" htmlFor="input">Input</label>
                                                        </div>
                                                    </div>
                                                    <div className="btn-group ms-auto">
                                                        <div className="form-switch form-check float-end">
                                                            <input className="custom-control-input form-check-input" type="checkbox" id="notequal"
                                                                checked={item.notequal} onChange={() => {
                                                                    itemListType("notequal", !item.notequal, item.id);
                                                                    makeRefreshModal(true);
                                                                }} />
                                                            <label className="custom-control-label" htmlFor="notequal">Not Equal</label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div className="responsiveSmall-Filter input-group-text mb-1">
                                                    {item.fieldname.charAt(0).toUpperCase() + item.fieldname.slice(1)} Range
                                                </div>

                                                <div className="input-group mb-3">
                                                    <span className="responsiveLarge-Filter input-group-text">
                                                        {item.fieldname.charAt(0).toUpperCase() + item.fieldname.slice(1)} Range
                                                    </span>

                                                    {item.listtype === "dateselect" ?
                                                        <>
                                                            {/* Dateselect min year */}
                                                            <select className="form-control input-sm" value={getYear(item.min)}
                                                                // type={item.type}
                                                                onChange={(e) => {
                                                                    Item("min", item.id, "year", e.target.value);
                                                                    makeRefreshModal(true);
                                                                }}>

                                                                <option value='' disabled hidden>Year...</option>
                                                                {uniqueList(covidsWithoutFilter, "date", "dateselect").map((year, index) =>
                                                                    <option key={year} value={year as string}>
                                                                        {year}
                                                                    </option>)}
                                                            </select>

                                                            {/* Dateselect min month */}
                                                            <select className="form-control input-sm" value={getMonth(item.min)}
                                                                // type={item.type}
                                                                onChange={(e) => {
                                                                    Item("min", item.id, "month", e.target.value);
                                                                    makeRefreshModal(true);
                                                                }}>

                                                                <option value='' disabled hidden>Month...</option>
                                                                {envMonths.map((month, index) =>
                                                                    <option key={month} value={month}>
                                                                        {month}
                                                                    </option>)}
                                                            </select>

                                                            {/* Dateselect min day */}
                                                            <select className="form-control input-sm" value={getDay(item.min)}
                                                                // type={item.type}
                                                                onChange={(e) => {
                                                                    Item("min", item.id, "day", e.target.value);
                                                                    makeRefreshModal(true);
                                                                }}>

                                                                <option value='' disabled hidden>Day...</option>
                                                                {envDays.map((day, index) =>
                                                                    <option key={day} value={day}>
                                                                        {day}
                                                                    </option>)}
                                                            </select>
                                                        </>

                                                        : (item.listtype === "select" ?
                                                            // Select min
                                                            <select className="form-select" value={item.min}
                                                                // type={item.type}
                                                                onChange={(e) => {
                                                                    Item("min", item.id, "select", e.target.value);
                                                                    makeRefreshModal(true);
                                                                }}>

                                                                <option value='' disabled hidden>Choose...</option>
                                                                {uniqueList(covidsWithoutFilter, item.fieldname, "select").map((data, index) =>
                                                                    <option key={data} value={data as string}>
                                                                        {data}
                                                                    </option>)}
                                                            </select>

                                                            : (item.listtype === "input" ?
                                                                < input type={item.type} className="form-control"
                                                                    value={item.min} name={item.fieldname} placeholder="Min..."
                                                                    onChange={(e) => {
                                                                        Item("min", item.id, "input", e.target.value);
                                                                        makeRefreshModal(true);
                                                                    }} />
                                                                : null
                                                            )
                                                        )
                                                    }

                                                    {/* Delete filter min button */}
                                                    <button type="button" className="btn btnStyle btn-link btn-sm"
                                                        onClick={() => {
                                                            Item("min", item.id, "delete");
                                                            makeRefreshModal(true);
                                                        }}>
                                                        <span className="bi bi-trash"></span>
                                                    </button>


                                                    {item.listtype === "dateselect" ?
                                                        <>
                                                            {/* Dateselect max year */}
                                                            <select className="form-control input-sm" value={getYear(item.max)}
                                                                // type={item.type}
                                                                onChange={(e) => {
                                                                    Item("max", item.id, "year", e.target.value);
                                                                    makeRefreshModal(true);
                                                                }}>

                                                                <option value='' disabled hidden>Year...</option>
                                                                {uniqueList(covidsWithoutFilter, "date", "dateselect").map((year, index) =>
                                                                    <option key={index} value={year as string}>
                                                                        {year}
                                                                    </option>)}
                                                            </select>

                                                            {/* Dateselect max month */}
                                                            <select className="form-control input-sm" value={getMonth(item.max)}
                                                                // type={item.type}
                                                                onChange={(e) => {
                                                                    Item("max", item.id, "month", e.target.value);
                                                                    makeRefreshModal(true);
                                                                }}>

                                                                <option value='' disabled hidden>Month...</option>
                                                                {envMonths.map((month, index) =>
                                                                    <option key={index} value={month}>
                                                                        {month}
                                                                    </option>)}
                                                            </select>

                                                            {/* Dateselect max day */}
                                                            <select className="form-control input-sm" value={getDay(item.max)}
                                                                // type={item.type}
                                                                onChange={(e) => {
                                                                    Item("max", item.id, "day", e.target.value);
                                                                    makeRefreshModal(true);
                                                                }}>

                                                                <option value='' disabled hidden>Day...</option>
                                                                {envDays.map((day, index) =>
                                                                    <option key={index} value={day}>
                                                                        {day}
                                                                    </option>)}
                                                            </select>
                                                        </>

                                                        : (item.listtype === "select" ?
                                                            // Select max
                                                            <select className="form-select" value={item.max}
                                                                // type={item.type}
                                                                onChange={(e) => {
                                                                    Item("max", item.id, "select", e.target.value);
                                                                    makeRefreshModal(true);
                                                                }}>

                                                                <option value='' disabled hidden>Choose...</option>
                                                                {uniqueList(covidsWithoutFilter, item.fieldname, "select").map((data, index) =>
                                                                    <option key={data} value={data as string}>
                                                                        {data}
                                                                    </option>)}
                                                            </select>

                                                            : (item.listtype === "input" ?
                                                                <input type={item.type} className="form-control"
                                                                    value={item.max} name={item.fieldname} placeholder="Max..."
                                                                    onChange={(e) => {
                                                                        Item("max", item.id, "input", e.target.value);
                                                                        makeRefreshModal(true);
                                                                    }} />
                                                                : null
                                                            )
                                                        )
                                                    }

                                                    {/* Delete filter max button */}
                                                    <button type="button" className="btn btnStyle btn-link btn-sm"
                                                        onClick={() => {
                                                            Item("max", item.id, "delete");
                                                            makeRefreshModal(true);
                                                        }}>
                                                        <span className="bi bi-trash"></span>
                                                    </button>
                                                </div>
                                            </div>
                                        )}

                                        <div className="btn-group">
                                            <button type="button" className="btn btnStyle btn-outline-custom btn-sm m-3 rounded"
                                                onClick={() => deleteAllFiltersHandler(true)}>
                                                Delete all filters
                                                <span className="bi bi-trash btn-lg"></span>
                                            </button>

                                            <button type="button" className="btn btnStyle btn-outline-custom btn-sm m-3 rounded"
                                                onClick={() => submitFiltersHandler()}>
                                                Submit Filters
                                            </button>
                                        </div>

                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                , portalElement)}
        </Fragment>
    );
}

