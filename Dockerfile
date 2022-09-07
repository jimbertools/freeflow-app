# Build stage
FROM node:lts-alpine as build-stage

COPY frontend ./frontend
WORKDIR frontend
RUN yarn install --frozen-lockfile && yarn build

# Production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /frontend/dist /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
