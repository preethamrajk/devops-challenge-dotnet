FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env

COPY . /app
WORKDIR /app

RUN ["dotnet", "restore"]
RUN ["dotnet", "publish", "--configuration", "Release", "--output", "outdir"]

FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app

EXPOSE 80/tcp
COPY --from=build-env /app/outdir .

ENTRYPOINT ["dotnet", "DevOpsChallenge.SalesApi.dll"]
