import { Fragment } from 'react';
import '../../../scss/datalistScss/Datalist.scss';
import PortalReactDOM from 'react-dom';
import L, { LatLngExpression } from 'leaflet';
import '../../../scss/datalistScss/MapModal.scss';
import { MapContainer, Marker, TileLayer, Tooltip, useMap } from 'react-leaflet';
import { useReduxSelector } from '../../../store/ReduxTypes';
import { useModalThunks } from '../../../logics/datalistLogics/thunks/ModalThunks';

const portalElement = document.getElementById('modals')!;




export const MapModal = () => {
    const { hideModalHandler } = useModalThunks();


    const isModalEffect = useReduxSelector(state => state.effect.isModalEffect);
    const mapData = useReduxSelector(state => state.table.mapData);
    const position: LatLngExpression = [47.49, 19];
    const zoom = 5;
    const maxZoom = 15;


    const icon = L.icon({
        iconSize: [25, 41],
        iconAnchor: [10, 41],
        popupAnchor: [2, -40],
        iconUrl: "https://unpkg.com/leaflet@1.8.0/dist/images/marker-icon.png",
        shadowUrl: "https://unpkg.com/leaflet@1.8.0/dist/images/marker-shadow.png"
    });


    const ResizeMap = () => {
        const map = useMap();
        map.invalidateSize();
        map.setView(position, zoom);
        return null;
    };


    return (
        <Fragment>
            {PortalReactDOM.createPortal(
                <div className="modal fade-color" id="refMapModal" tabIndex={-1}>
                    <div className="modal-dialog modal-xl modal-dialog-centered">

                        <div className={isModalEffect ? 'modal-content modal-content-color'
                            : 'modal-content modal-content-notanimated'}>
                            <div className="modal-header">
                                <h5 className="modal-title">Map</h5>
                                <button type="button" className="btn-close btn-outline-custom btn-modal"
                                    onClick={() => hideModalHandler('refMapModal')}>
                                </button>
                            </div>

                            <div className="modal-body">
                                <div className="">
                                    <div className="">
                                        <div>
                                            <MapContainer
                                                style={{ height: '100vh', width: '100wh' }}
                                                center={position}
                                                zoom={zoom}
                                                maxZoom={maxZoom}
                                                doubleClickZoom={true}
                                                scrollWheelZoom={false}
                                            >
                                                <ResizeMap />
                                                <TileLayer
                                                    attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
                                                    url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />
                                                {
                                                    <Marker
                                                        position={position}
                                                        icon={icon}>
                                                        <Tooltip direction='bottom' opacity={1} permanent>
                                                            <h5> Hungarian Covid Data</h5>
                                                            <h6> on {mapData ? mapData.date : null}</h6>
                                                            <h6> Active Infected: {mapData ? mapData.activeInfected : null}</h6>
                                                            <h6> Quarantined: {mapData ? mapData.quarantined : null}</h6>
                                                        </Tooltip>
                                                    </Marker>
                                                }
                                            </MapContainer>

                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                , portalElement)}

        </Fragment>
    )
}

