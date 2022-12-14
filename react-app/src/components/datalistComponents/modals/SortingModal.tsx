import { Fragment } from 'react';
import PortalReactDOM from 'react-dom';
import { useReduxSelector } from '../../../store/ReduxTypes';
import { useModalThunks } from '../../../logics/datalistLogics/thunks/ModalThunks';
import { useSortingThunks } from '../../../logics/datalistLogics/thunks/SortingThunks';
import { uniqueListSort } from '../../../logics/datalistLogics/Logics';
import { envTableHeaderSortElements } from '../../../logics/datalistLogics/thunks/SortingThunks';


const portalElement = document.getElementById('modals')!;




export const SortingModal = () => {
    const { hideModalHandler, makeRefreshModal } = useModalThunks();
    const { deleteSortsCopy, itemSorts, submitSortingHandler } = useSortingThunks();

    const isModalEffect = useReduxSelector(state => state.effect.isModalEffect);
    const sortsCopy = useReduxSelector(state => state.sorting.sortsCopy);

    return (
        <Fragment>
            {PortalReactDOM.createPortal(
                <div className="modal fade" id="refModalSorting" tabIndex={-1} >
                    <div className="modal-dialog modal-lg modal-dialog-centered">

                        <div className={isModalEffect ? 'modal-content modal-content-color'
                            : 'modal-content modal-content-notanimated'}>
                            <div className="modal-header">
                                <h5 className="modal-title">Set Sorting</h5>
                                <button type="button" className="btn-close btn-outline-custom btn-modal"
                                    onClick={() => {
                                        deleteSortsCopy();
                                        hideModalHandler('refModalSorting');
                                    }}>
                                </button>
                            </div>

                            <div className="modal-body">
                                <div className="d-flex flex-row bd-highlight mb-3">
                                    <div className="p-2 w-100 bd-highlight">


                                        {sortsCopy.map((item, index) =>
                                            <div key={item.id}>
                                                <div className="d-flex flex-row">
                                                    <div className="btn-group me-auto w-100" style={index === 0 ? { display: "flex", flexDirection: "row" }
                                                        : (sortsCopy[index - 1].sortfield === '' || sortsCopy[index - 1].sorttype === '') ? { display: "none" } : { display: "flex", flexDirection: "row" }}>

                                                        <span>{item.id}. </span>
                                                        <select className="form-select select-sorting mb-2" value={item.sortfield}
                                                            onChange={(e) => {
                                                                itemSorts(item.id, "select", "sortfield", e.target.value);
                                                                makeRefreshModal(true);
                                                            }}>

                                                            <option value='' disabled hidden>Choose...</option>
                                                            {envTableHeaderSortElements.map((item, index) =>
                                                                <option key={index} value={item.sortfield1}
                                                                    disabled={uniqueListSort(item.sortfield1, sortsCopy)}>
                                                                    {item.sortfield1}
                                                                </option>)}
                                                        </select>


                                                        <select className="form-select select-sorting mb-2" value={item.sorttype}
                                                            onChange={(e) => {
                                                                itemSorts(item.id, "select", "sorttype", e.target.value);
                                                                makeRefreshModal(true);
                                                            }}>
                                                            <option value='' disabled hidden>Choose...</option>
                                                            <option value="desc">descending</option>
                                                            <option value="asc">ascending</option>
                                                        </select>

                                                        {/* Delete sorttype button */}
                                                        <button type="button" className="btn btnStyle btn-link btn-sm"
                                                            style={index === 0 ? { display: "none" }
                                                                : index !== sortsCopy.length - 1 ?
                                                                    (sortsCopy[index + 1].sortfield === '' && sortsCopy[index + 1].sorttype === '' ?
                                                                        { display: "flex" }
                                                                        : { display: 'none' }
                                                                    )
                                                                    : { display: 'flex' }
                                                            }
                                                            onClick={() => {
                                                                itemSorts(item.id, "delete");
                                                                makeRefreshModal(true);
                                                            }}>
                                                            <span className="bi bi-trash"></span>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        )}

                                        <button type="button" className="btn btnStyle btn-outline-custom btn-sm m-3 rounded"
                                            onClick={() => submitSortingHandler()}>
                                            Submit Sorting
                                        </button>
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


