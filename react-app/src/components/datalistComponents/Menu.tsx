import { Fragment, useState } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { useReduxSelector } from '../../store/ReduxTypes';
import { useModalThunks } from '../../logics/datalistLogics/thunks/ModalThunks';
import { useFilteringThunks } from '../../logics/datalistLogics/thunks/FilteringThunks';
import { useDataThunks } from '../../logics/datalistLogics/thunks/DataThunks';
import { useTableThunks } from '../../logics/datalistLogics/thunks/TableThunks';
import { useAuthThunks } from '../../logics/datalistLogics/thunks/AuthThunks';



export const TableMenu1 = () => {
    const { makeTableStyleHandler } = useTableThunks();
    const { showModalHandler, loadDataHandler, deleteAllDataHandler } = useModalThunks();
    const { addHandler } = useDataThunks();
    const { LoginHandler, LogoutHandler, UserProfileHandler } = useAuthThunks();



    const tableStyle = useReduxSelector(state => state.table.tableStyle);
    const isLoading = useReduxSelector(state => state.table.isLoading);
    const isFlip = useReduxSelector(state => state.effect.isFlip);
    const location = useLocation();
    const navigate = useNavigate();
    const [isDatalistPath] = useState(location.pathname === '/datalist' ? true : false);
    const isUserLoggedIn = useReduxSelector(state => state.auth.isUserLoggedIn);


    return (
        <Fragment>
            {/* Table Menu 1st row */}
            <div className="display-flex flex-row mb-2">
                <div className="datalist-menu-scroll btn-group" role="group">

                    {/* Menu button */}
                    <div className="btn-group dropdown menu-wide" >
                        <button className={`btn btn-outline-customflip ${tableStyle === 'table-scroll' ? 'btnStyle' : 'btnStyle-Menu'}`} type="button"
                            data-bs-toggle="dropdown" disabled={isLoading}>
                            <div className={`d-flex flex-row justify-content-center buttonMenu ${isFlip ? 'flipButton1' : 'flipButton'}`}>
                                <span>M</span><span>e</span><span>n</span><span>u</span>
                            </div>
                        </button>
                        <ul className="dropdown-menu">
                            <li>
                                <button className={`btn m-1  float-start buttonMenu  ${isDatalistPath ? 'btn-outline-customflip-checked'
                                    : 'btnStyle btn-outline-customflip'}`} type="button"
                                    onClick={() => { navigate('/datalist'); }}>
                                    Datalist
                                </button>
                            </li>
                            <li>
                                <button className="btn btnStyle btn-outline-customflip m-1  float-start buttonMenu " type="button"
                                    onClick={() => { navigate('//localhost:8000/admin'); }}>
                                    Admin Django
                                </button>
                            </li>
                            <li>
                                <button className={`btn btnStyle btn-outline-customflip m-1 float-start buttonMenu ${isUserLoggedIn ? 'displayNone' : ' displayBlock'}`}
                                    type="button" onClick={() => LoginHandler()}>
                                    Login
                                </button>
                                <button className={`btn btnStyle btn-outline-customflip m-1 float-start buttonMenu ${isUserLoggedIn ? 'displayBlock' : ' displayNone'}`}
                                    type="button" onClick={() => LogoutHandler()}>
                                    Logout
                                </button>

                                <button className={`btn btnStyle btn-outline-customflip m-1 float-start buttonMenu ${isUserLoggedIn ? 'displayBlock' : ' displayNone'}`}
                                    type="button" onClick={() => UserProfileHandler()}>
                                    User Profile
                                </button>

                            </li>
                            <li>
                                <button className="btn btnStyle btn-outline-customflip m-1 float-start buttonMenu" type="button"
                                    onClick={() => showModalHandler('refSettingsModal')}>
                                    Settings
                                </button>
                            </li>
                        </ul>
                    </div>

                    {/* Styles button*/}
                    <button className={`btn btn-outline-customflip menu-wide ${tableStyle === 'table-scroll' ? 'btnStyle' : 'btnStyle-Menu'}`} type="button"
                        disabled={isLoading} onClick={() => showModalHandler('refStyleModal')}>
                        <div className={`d-flex flex-row justify-content-center buttonMenu ${isFlip ? 'flipButton2' : 'flipButton'}`}>
                            <span>S</span><span>t</span><span>y</span><span>l</span><span>e</span><span>s</span>
                        </div>
                    </button>

                    {/* Table button */}
                    <div className="btn-group dropdown menu-wide" >
                        <button className={`btn btn-outline-customflip`} type="button"
                            // ${tableStyle === 'table-scroll' ? 'boxshadow5px' : 'boxshadow-5px'}
                            data-bs-toggle="dropdown" disabled={isLoading} id='TableButton'
                            style={tableStyle === 'table-scroll' ? { boxShadow: '5px 5px 0 rgb(114, 110, 110)' }
                                : { boxShadow: '5px -5px 0 rgb(114, 110, 110)' }} >
                            <div className={`d-flex flex-row justify-content-center buttonMenu ${isFlip ? 'flipButton6' : 'flipButton'}`}>
                                <span>T</span><span>a</span><span>b</span><span>l</span><span>e</span>
                            </div>
                        </button>

                        <ul className="dropdown-menu dropdown-menu-end">
                            <li>
                                <button className={`btn m-1 float-start buttonMenu ${tableStyle === 'table-scroll' ? 'btn-outline-customflip-checked'
                                    : 'btnStyle btn-outline-customflip'}`}
                                    type="button" onClick={() => makeTableStyleHandler('table-scroll')}
                                ><span>Scroll - Big screen</span>
                                </button>
                            </li>
                            <li>
                                <button className={`btn m-1 float-start buttonMenu ${tableStyle === 'table-standard' ? 'btn-outline-customflip-checked'
                                    : 'btnStyle btn-outline-customflip'}`}
                                    type="button" onClick={() => makeTableStyleHandler('table-standard')}
                                ><span>Standard - Small screen</span>
                                </button>
                            </li>
                        </ul>
                    </div>


                    {/* Datalist menu button */}
                    <div className="btn-group dropdown menu-wide" >
                        <button className={`btn btn-outline-customflip ${tableStyle === 'table-scroll' ? 'btnStyle' : 'btnStyle-Menu'}`} type="button"
                            data-bs-toggle="dropdown" disabled={isLoading}>
                            <div className={`d-flex flex-row justify-content-center buttonMenu ${isFlip ? 'flipButton7' : 'flipButton'}`}>
                                <span>D</span><span>a</span><span>t</span><span>a</span><span>l</span><span>i</span><span>s</span><span>t</span>
                                <span className="bi bi-list"></span>
                            </div>
                        </button>

                        <ul className="dropdown-menu dropdown-menu-end">
                            {/* Delete All Data button*/}
                            <li>
                                <button type="button" className="btn btnStyle btn-outline-customflip m-1  float-end buttonMenu"
                                    disabled={isLoading} onClick={() => deleteAllDataHandler()}>
                                    <span>Delete All Data</span>
                                </button>
                            </li>

                            {/* Load Data from JSON url button*/}
                            <li>
                                <button type="button" className="btn btnStyle btn-outline-customflip m-1  float-end buttonMenu noWrap"
                                    disabled={isLoading} onClick={() => loadDataHandler()}>
                                    <span>Load Data from url</span>
                                </button>
                            </li>

                            {/* Add Data button */}
                            <li>
                                <button type="button" className="btn btnStyle btn-outline-customflip m-1  float-end buttonMenu"
                                    disabled={isLoading} onClick={() => addHandler()}>
                                    <span>Add Data</span>
                                </button>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </Fragment>
    )
}



export const TableMenu2 = () => {
    const { showModalHandler, deleteSelectedHandler } = useModalThunks();
    const { onlySelectedHandler } = useFilteringThunks();
    const { deSelectHandler } = useTableThunks();

    const tableStyle = useReduxSelector(state => state.table.tableStyle);
    const isLoading = useReduxSelector(state => state.table.isLoading);
    const isFlip = useReduxSelector(state => state.effect.isFlip);
    const isOnlySelected = useReduxSelector(state => state.filtering.isOnlySelected);
    const selectedData = useReduxSelector(state => state.table.selectedData);
    const sortActive = useReduxSelector(state => state.sorting.sortActive);
    const filterActive = useReduxSelector(state => state.filtering.filterActive);

    return (
        <Fragment>
            {/* Table standard menu buttons */}
            <div className={`display-flex flex-row mb-2 
                ${tableStyle === "table-scroll" ? 'displayNone' : 'displayBlock'}`}>
                <div className="datalist-menu-standard btn-group" role="group">

                    {/* Selected menu button */}
                    <button className="btn btnStyle btn-outline-customflip menu-wide" type="button"
                        data-bs-toggle="dropdown" disabled={isLoading}>
                        <div className={`d-flex flex-row justify-content-center buttonMenu ${isFlip ? 'flipButton8' : 'flipButton'}`}>
                            <span>S</span><span>e</span><span>l</span><span>e</span><span>c</span><span>t</span><span>e</span><span>d</span>
                        </div>
                    </button>

                    <ul className="dropdown-menu dropdown-menu-start">
                        <li>
                            {/* Filter Selected button */}
                            <input className="btn-check" type="checkbox" id="btn-check"
                                disabled={isLoading} checked={isOnlySelected}
                                onChange={(e) => { onlySelectedHandler(e.target); }} />
                            <label className={`btn  m-1 buttonMenu ${isOnlySelected ? 'btn-outline-customflip-checked'
                                : 'btnStyle btn-outline-customflip'}`}
                                htmlFor="btn-check">
                                <span>Filter {selectedData.length !== 0 ? selectedData.length : null}</span>
                                <span> Selected</span>
                            </label>
                        </li>

                        <li>
                            {/* Deselect button */}
                            <button type="button" className="btn btnStyle btn-outline-customflip  m-1 buttonMenu "
                                disabled={isLoading} onClick={() => deSelectHandler()}>
                                <span>De-Select</span>
                            </button>
                        </li>

                        <li>
                            {/* Delete Selected button */}
                            <button type="button" className="btn btnStyle btn-outline-customflip  m-1 buttonMenu"
                                disabled={isLoading} onClick={() => deleteSelectedHandler()}>
                                <span>Delete {selectedData.length !== 0 ? selectedData.length : null}</span>
                                <span> Selected</span>
                            </button>
                        </li>
                    </ul>

                    {/* Filters button */}
                    <button className={`btn btnStyle btn-outline-customflip menu-wide
                        ${tableStyle === "table-scroll" ? 'displayNone' : 'displayBlock'}`}
                        type="button" disabled={isLoading}
                        onClick={() => showModalHandler('refModalFiltering')}>
                        {filterActive === 0 ?
                            <div className={`d-flex flex-row justify-content-center buttonMenu ${isFlip ? 'flipButton3' : 'flipButton'}`}>
                                <span>F</span><span>i</span><span>l</span><span>t</span><span>e</span><span>r</span><span>s</span>
                            </div>
                            :
                            <div>
                                {filterActive === 1 ?
                                    <div className={`d-flex flex-row justify-content-center buttonMenu ${isFlip ? 'flipButton4' : 'flipButton'}`}>
                                        <span>{filterActive} </span><span></span><span>F</span><span>i</span><span>l</span><span>t</span><span>e</span><span>r</span>
                                    </div>
                                    :
                                    <div className={`d-flex flex-row justify-content-center buttonMenu ${isFlip ? 'flipButton5' : 'flipButton'}`}>
                                        <span>{filterActive} </span><span></span><span>F</span><span>i</span><span>l</span><span>t</span><span>e</span><span>r</span><span>s</span>
                                    </div>
                                }
                            </div>}
                    </button>

                    {/* Sort button */}
                    <button className={`btn btnStyle btn-outline-customflip menu-wide
                        ${tableStyle === "table-scroll" ? 'displayNone' : 'displayBlock'}`}
                        type="button" disabled={isLoading}
                        onClick={() => showModalHandler('refModalSorting')}>
                        {sortActive === 1 ?
                            <div className={`d-flex flex-row justify-content-center buttonMenu ${isFlip ? 'flipButton9' : 'flipButton'}`}>
                                <span>{sortActive} </span><span>S</span><span>o</span><span>r</span><span>t</span>
                            </div>
                            :
                            <div className={`d-flex flex-row justify-content-center buttonMenu ${isFlip ? 'flipButton10' : 'flipButton'}`}>
                                <span>{sortActive} </span><span>S</span><span>o</span><span>r</span><span>t</span><span>s</span>
                            </div>
                        }
                    </button>
                </div>
            </div>
        </Fragment>
    )
}


