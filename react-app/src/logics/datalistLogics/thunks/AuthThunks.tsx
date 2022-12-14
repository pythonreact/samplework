import React from 'react';
import { useReduxSelector, useReduxDispatch } from '../../../store/ReduxTypes';
import { useModalThunks } from '../../datalistLogics/thunks/ModalThunks';
import { authActions } from '../../../store/datalistSlices/AuthSlice';
import { modalActions } from '../../../store/datalistSlices/ModalSlice';
import axios from 'axios';



export const useAuthThunks = () => {
    const dispatch = useReduxDispatch();
    const { showModalHandler } = useModalThunks();


    const envAPIURL = process.env.REACT_APP_API_URL as string;
    const fetchXHR = useReduxSelector(state => state.table.fetchXHR);
    const refreshToken = useReduxSelector(state => state.auth.refreshToken);
    const token = useReduxSelector(state => state.auth.token);

    const UserProfileHandler = () => {
        showModalHandler('refUserModal');
    };


    const FETCHCHECK = (
        typeof fetch === "undefined" ? false : true
    );


    const LoginHandler = () => {
        dispatch(authActions.setIsLoginButton(true));
        showModalHandler('refAuthModal');
    };


    const LogoutHandler = () => {
        dispatch(authActions.setIsLoggedIn(false));
        dispatch(authActions.logout());
    };



    const LoginSubmitHandler = async (event: React.MouseEvent, enteredEmail: string, enteredPassword: string) => {
        event.preventDefault();

        if ((fetchXHR === 'auto' && FETCHCHECK) || fetchXHR === 'Fetch') {
            const response = await fetch(envAPIURL + 'datalist/auth/login/', {
                method: "POST",
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                },
                body:
                    JSON.stringify({
                        email: enteredEmail,
                        password: enteredPassword
                    })
            });

            if (response.ok) {
                const data = await response.json();
                dispatch(authActions.setAuthTokens({
                    token: data.access,
                    refreshToken: data.refresh,
                }));
                dispatch(authActions.setUserId(data.user.id));
                dispatch(authActions.setUserEmail(data.user.email));
                dispatch(authActions.setIsLoggedIn(true));
                dispatch(modalActions.setNote('Login successfull'));
                showModalHandler('refNoteModal');
            } else {
                dispatch(modalActions.setNote(` ${response.statusText}`));
                showModalHandler('refNoteModal');
            }

        } else {
            try {
                const response = await axios
                    .post(envAPIURL + 'datalist/auth/login/', {
                        email: enteredEmail,
                        password: enteredPassword,
                    },
                        {
                            headers: {
                                'Content-Type': "application/json",
                                'Accept': 'application/json',
                                'Authorization': 'Bearer' + token
                            },
                        }
                    );
                const data = await response.data;
                dispatch(authActions.setAuthTokens({
                    token: data.access,
                    refreshToken: data.refresh,
                }));
                dispatch(authActions.setUserId(data.user.id));
                dispatch(authActions.setUserEmail(data.user.email));
                dispatch(modalActions.setNote('Login successfull'));
                showModalHandler('refNoteModal');
                dispatch(authActions.setIsLoggedIn(true));
            } catch (error) {
                dispatch(modalActions.setNote(`Failed! ${error}`));
                showModalHandler('refNoteModal');
            };
        };
    };


    const RefreshTokenFetch = async () => {
        const response = await fetch(envAPIURL + 'datalist/auth/refresh/', {
            method: "POST",
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
            },
            body:
                JSON.stringify({
                    refresh: refreshToken,
                })
        });
        if (response.ok) {
            const data = await response.json();
            dispatch(authActions.setAuthTokens({
                token: data.access,
                refreshToken: data.refresh,
            }));
            console.log('Token refreshed succesfully');
        } else {
            throw new Error('Error in refreshing token');
        };
    };


    const RefreshTokenAxios = async () => {
        try {
            const response = await axios({
                method: 'post',
                url: envAPIURL + 'datalist/auth/refresh/',
                data: JSON.stringify({
                    refresh: refreshToken,
                }),
                headers: {
                    "Content-Type": "application/json",
                },
            });
            const data = await response.data;
            dispatch(authActions.setAuthTokens({
                token: data.access,
                refreshToken: data.refresh,
            }));
            console.log('Token refreshed successfully');
        } catch (error) {
            throw new Error('Error in refreshing token');
        };
    };

    return { LoginHandler, LogoutHandler, LoginSubmitHandler, UserProfileHandler, RefreshTokenFetch, RefreshTokenAxios };
};
