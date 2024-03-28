# README

Features added to the app:

* Api Documentation
  - swagger DSL written
  - serving swagger-ui whithin the app
* Docker
* Annotate gem


* pre-requisites:
  - Ruby (v3.2.2)
  - Rails (v7.0.4)
  - Install Docker and Docker-compose on the system
  - Bundler (v2.4.10)

* Running
  - Build the container and start the container to start the application
      sudo docker-compose up -build

  - Create the database of api in docker
     sudo docker-compose exec rails db:create

  - Run Pending Migration
     sudo docker-compose exec rails db:migrate

  - Once Done Now can access the Swagger API Docs to check All the APIs From this Url
      http://localhost:3000/docs
    - Login with user credentials and get the Bearer token from headers and paste into the Authorization popup to access all the api endpoints


# ayanitech_api
