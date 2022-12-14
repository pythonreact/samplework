FROM node:14-alpine as build

WORKDIR /frontend
ENV PATH /frontend/node_modules/.bin:$PATH
ADD ./react-app/package.json /frontend
ADD ./react-app/package-lock.json /frontend
RUN npm ci --silent
ADD ./react-app /frontend
RUN npm run build
EXPOSE 3000
CMD ["npm", "start"]

FROM nginx:1.22-alpine
RUN rm /etc/nginx/conf.d/default.conf
#COPY ./docker/nginx/default.conf /etc/nginx/conf.d/default.
#Copy React static files
COPY --from=build /frontend/build /usr/share/nginx/html


#Copy React folders
COPY --from=build /frontend/public /frontend/public
COPY --from=build /frontend/src /frontend/src
COPY --from=build /frontend/package*.json /frontend
COPY --from=build /frontend/README.md /frontend

#Create Log folder for Nginx and Django
RUN mkdir -p /logs

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
