import { Fragment } from 'react';
import { useReduxSelector } from '../../store/ReduxTypes';
import { useModalThunks } from '../../logics/datalistLogics/thunks/ModalThunks';
import { addColorButtonSorts, addRankButton } from '../../logics/datalistLogics/Logics';
import { envTableHeaderSortElements } from '../../logics/datalistLogics/thunks/SortingThunks';




// Filter buttons html
export const FilterHeaderButtons = () => {
    const { showModalHandler } = useModalThunks();

    const isLoading = useReduxSelector(state => state.table.isLoading);
    const filters = useReduxSelector(state => state.filtering.filters);

    return (
        <Fragment>
            {filters.map((item) => {
                return (
                    <th key={item.id} >
                        <button type="button"
                            className={`btn btnStyle btn-outline-filter btn-sm m-1 rounded 
                        ${item.id === "1" ?
                                    item.min || item.max ? 'buttonFilter-Id1MinMax' : 'buttonFilter-Id1'
                                    : item.min || item.max ? 'buttonFilter-MinMax' : null}`}
                            disabled={isLoading}
                            onClick={() => showModalHandler('refModalFiltering')}>
                            {!item.min && !item.max ?
                                <div>
                                    <span> {item.fieldname.charAt(0).toUpperCase() + item.fieldname.slice(1)}</span><br />
                                    <span> Filter </span>
                                </div>
                                :
                                <div> {item.notequal === true ? <span>Not Equal<br /></span> : null}
                                    {item.min ? <span>{item.type === "date" || item.type === "time" ?
                                        item.min
                                        : parseInt(item.min, 10).toLocaleString('en')}</span>
                                        : <span>...</span>}
                                    <br />
                                    {item.max ? <span>{item.type === "date" || item.type === "time" ?
                                        item.max
                                        : parseInt(item.max, 10).toLocaleString('en')}</span>
                                        : <span>...</span>}
                                </div>
                            }
                        </button>
                    </th>
                )
            })}
        </Fragment>
    )
};



// Sort icons html
export const SortHeaderButtons = () => {
    const { showModalHandler } = useModalThunks();
    const sorts = useReduxSelector(state => state.sorting.sorts);


    return (
        <Fragment>
            {envTableHeaderSortElements.map((item) => {
                return (
                    <th key={item.id}>
                        <div className="sorting d-flex flex-row">
                            <button type="button" className="btn btnStyle btn-light btn-sm rounded buttonSort"
                                style={addColorButtonSorts(item.colorprop1, sorts)}
                                onClick={() => {
                                    showModalHandler('refModalSorting');
                                }}>
                                <span className="bi bi-arrow-down-circle-fill btn-sm"> {addRankButton(item.colorprop1, sorts)}</span>
                            </button>

                            <button type="button" className="btn btnStyle btn-light btn-sm rounded buttonSort"
                                style={addColorButtonSorts(item.colorprop2, sorts)}
                                onClick={() => {
                                    showModalHandler('refModalSorting');
                                }}>
                                <span className="bi bi-arrow-up-circle-fill btn-sm"> {addRankButton(item.colorprop2, sorts)}</span>

                            </button>
                        </div>
                    </th>
                )
            })}
        </Fragment>
    )
};

