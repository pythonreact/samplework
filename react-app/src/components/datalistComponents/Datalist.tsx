import { AddEditModal } from './modals/AddEditModal';
import { ConfirmModal } from './modals/ConfirmModal';
import { FilteringModal } from './modals/FilteringModal';
import { NoteModal } from './modals/NoteModal';
import { SettingsModal } from './modals/SettingsModal';
import { SortingModal } from './modals/SortingModal';
import { SpinModal } from './modals/SpinModal';
import { StyleModal } from './modals/StyleModal';
import { MapModal } from './modals/MapModal';
import { ChartModal } from './modals/ChartModal';
import { AuthModal, UserModal } from './modals/AuthModal';

import { CubeEffect, EarthEffect, RasterEffect, ScrollEffect, SwingEffect, SwingLinesEffect } from './Effects';

import { TableMenu1, TableMenu2 } from './Menu';
import { TableMain } from './Table';
import { useDatalist } from '../../logics/datalistLogics/UseDatalist';


import '../../scss/datalistScss/Datalist.scss';
import '../../scss/datalistScss/ScrollEffect.scss';
import '../../scss/datalistScss/EarthEffect.scss';
import '../../scss/datalistScss/SwingEffect.scss';
import '../../scss/datalistScss/CubeEffect.scss';
import '../../scss/datalistScss/RasterEffect.scss';



export const Datalist = () => {
    useDatalist();

    return (
        <div className="container">
            <TableMenu1 />
            <TableMenu2 />
            <ScrollEffect />
            <EarthEffect />
            <SwingEffect />
            <CubeEffect />
            <SwingLinesEffect />
            <RasterEffect />
            <TableMain />

            <AddEditModal />
            <SpinModal />
            <NoteModal />
            <ConfirmModal />
            <FilteringModal />
            <SortingModal />
            <StyleModal />
            <SettingsModal />
            <MapModal />
            <ChartModal />
            <AuthModal />
            <UserModal />
        </div>
    );
}
export default Datalist;