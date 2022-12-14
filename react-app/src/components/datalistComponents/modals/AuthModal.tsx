import { Fragment, useRef } from 'react';
import PortalReactDOM from 'react-dom';
import { useReduxSelector } from '../../../store/ReduxTypes';
import { useModalThunks } from '../../../logics/datalistLogics/thunks/ModalThunks';
import { useAuthThunks } from '../../../logics/datalistLogics/thunks/AuthThunks';





const portalElement = document.getElementById('modals')!;


export const AuthModal = () => {
    const { hideModalHandler } = useModalThunks();
    const { LoginSubmitHandler } = useAuthThunks();
    const isModalEffect = useReduxSelector(state => state.effect.isModalEffect);
    const isLoginButton = useReduxSelector(state => state.auth.isLoginButton);
    const emailInputRef = useRef<HTMLInputElement | null>(null);
    const passwordInputRef = useRef<HTMLInputElement | null>(null);


    return (
        <Fragment>
            {PortalReactDOM.createPortal(
                <div className="modal fade" id="refAuthModal" tabIndex={-1} >
                    <div className="modal-dialog modal modal-dialog-centered">
                        <div className={isModalEffect ? 'modal-content modal-content-color'
                            : 'modal-content modal-content-notanimated'}>

                            <div className="modal-header">
                                <h5 className="modal-title">
                                    {isLoginButton ? <span>Login</span>
                                        : <span>Please Login first to do this!</span>}
                                </h5>
                                <button type="button" className="btn-close btn-outline-custom btn-modal"
                                    onClick={() => hideModalHandler('refAuthModal')}>
                                </button>
                            </div>

                            <div className="modal-body">
                                <div className="d-flex flex-row bd-highlight mb-3">
                                    <div className="p-1 w-100 bd-highlight">

                                        {/* input field "email" */}
                                        <div className="input-group mb-3">
                                            <span className="input-group-text">Enter your Email</span>
                                            <input type="email" className="form-control" name="userEmail"
                                                required ref={emailInputRef} defaultValue='superuser@superuser.superuser'
                                            />
                                        </div>

                                        {/* input field "password" */}
                                        <div className="input-group mb-3">
                                            <span className="input-group-text">Enter your Password</span>
                                            <input type="password" className="form-control" name="userPassword"
                                                required ref={passwordInputRef} defaultValue='superuser'
                                            />
                                        </div>
                                    </div>
                                </div>

                                {/* Submit Handler */}
                                <button type="button" className="btn btnStyle btn-light btn-outline-custom float-start"
                                    onClick={(e) => {
                                        if (!emailInputRef.current || !passwordInputRef.current) {
                                            alert('Please enter email and password');
                                        } else {
                                            LoginSubmitHandler(e, emailInputRef.current.value, passwordInputRef.current.value);
                                            hideModalHandler('refAuthModal');
                                        }
                                    }}>
                                    <span>Login</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                , portalElement)}
        </Fragment>
    );
};


export const UserModal = () => {
    const { hideModalHandler } = useModalThunks();
    const isModalEffect = useReduxSelector(state => state.effect.isModalEffect);
    const id = useReduxSelector(state => state.auth.user?.id);
    const email = useReduxSelector(state => state.auth.user?.email);
    const is_Active = useReduxSelector(state => state.auth.user?.is_active);
    const is_Superuser = useReduxSelector(state => state.auth.user?.is_superuser);


    return (
        <Fragment>
            {PortalReactDOM.createPortal(
                <div className="modal fade" id="refUserModal" tabIndex={-1} >
                    <div className="modal-dialog modal modal-dialog-centered">
                        <div className={isModalEffect ? 'modal-content modal-content-color'
                            : 'modal-content modal-content-notanimated'}>
                            <div className="modal-header">
                                <h5 className="modal-title">
                                    User Profile
                                </h5>
                                <button type="button" className="btn-close btn-outline-custom btn-modal"
                                    onClick={() => hideModalHandler('refUserModal')}>
                                </button>
                            </div>

                            <div className="modal-body">
                                <div className="d-flex flex-row bd-highlight mb-3">
                                    <div className="p-1 w-100 bd-highlight">
                                        <span>Id: {id}<br /></span>
                                        <span>Email: {email}<br /></span>
                                        {/* <span>Is_Active: {is_Active}<br /></span>
                                        <span>Is_Superuser: {is_Superuser}<br /></span> */}
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                , portalElement)}
        </Fragment>
    );
};

