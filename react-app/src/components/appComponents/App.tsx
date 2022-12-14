import '../../scss/appScss/App.scss';
import { Datalist } from '../datalistComponents/Datalist';
import { Route, Routes, useNavigate } from 'react-router-dom';
import React from 'react';
import "bootstrap/js/dist/dropdown.js";
import { useApp } from '../../logics/appLogics/UseApp';
import { useReduxSelector } from '../../store/ReduxTypes';
import { Logo } from './Logo';


const App: React.FC = () => {
  const navigate = useNavigate();
  const { datalistClickHandler, Footer } = useApp();

  const isDatalistPath = useReduxSelector(state => state.app.isDatalistPath);
  const isShowHeader = useReduxSelector(state => state.app.isShowHeader);



  return (
    <div className="App container">
      <div className={`responsive ${isDatalistPath ? 'displayNone' : null}`}>

        <div className={`menu ${isShowHeader ? 'displayBlock' : 'displayNone'}`}>
          <div className="btn-group" role="group">
            <button className="btn btn-outline-customapp buttonSize" type="button"
              onClick={() => {
                datalistClickHandler();
                navigate('/datalist');
              }}>
              <span> Datalist </span>
            </button>

            <button className="btn btn-outline-customapp buttonSize" type="button"
              onClick={() => {
                navigate('//localhost:8000/admin');
              }}>
              <span> Admin </span>
            </button>
          </div>
        </div>

        <Logo />
        <Footer />

      </div>

      <div className={`footer-datalist ${isDatalistPath ? 'displayBlock' : 'displayNone'}`}>
        <Footer />
      </div>

      <Routes>
        <Route path='/datalist' element={<Datalist />} />
      </Routes>
    </div>
  );
}
export default App;
