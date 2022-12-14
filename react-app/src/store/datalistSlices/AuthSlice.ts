import { createSlice, PayloadAction } from '@reduxjs/toolkit';





interface AuthState {
    isUserLoggedIn: boolean;
    isLoginButton: boolean;
    token: string | null;
    refreshToken: string | null;
    user?: {
        id?: string;
        email?: string;
        is_active?: boolean;
        is_superuser?: boolean;
    };
};


const initialState: AuthState = {
    isUserLoggedIn: false,
    isLoginButton: false,
    token: null,
    refreshToken: null,
    user: {
        id: '',
        email: '',
        is_active: false,
        is_superuser: false,
    }
};


const authSlice = createSlice({
    name: 'auth',
    initialState,
    reducers: {
        setIsLoggedIn(state, action: PayloadAction<boolean>) {
            state.isUserLoggedIn = action.payload;
        },
        setIsLoginButton(state, action: PayloadAction<boolean>) {
            state.isLoginButton = action.payload;
        },
        setAuthTokens(state, action: PayloadAction<{ token: string, refreshToken: string }>) {
            state.token = action.payload.token;
            state.refreshToken = action.payload.refreshToken;
        },
        setUserId(state, action: PayloadAction<string>) {
            state.user!.id = action.payload;
        },
        setUserEmail(state, action: PayloadAction<string>) {
            state.user!.email = action.payload;
        },
        setUserIsActive(state, action: PayloadAction<boolean>) {
            state.user!.is_active = action.payload;
        },
        setUserIsSuperuser(state, action: PayloadAction<boolean>) {
            state.user!.is_superuser = action.payload;
        },
        logout() {
            return initialState;
        }
    }
});


export const authActions = authSlice.actions;
export default authSlice.reducer;

