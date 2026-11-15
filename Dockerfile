FROM mcr.microsoft.com/dotnet/sdk:10.0-alpine as build
WORKDIR /app
COPY . .
RUN dotnet restore DotNetApiExample/DotNetApiExample.csproj
RUN dotnet publish DotNetApiExample/DotNetApiExample.csproj --no-restore -c Release -o /app/published-app

FROM mcr.microsoft.com/dotnet/aspnet:10.0-alpine as runtime
WORKDIR /app
COPY --from=build /app/published-app /app

ENV ASPNETCORE_ENVIRONMENT=production
ENV ASPNETCORE_HTTP_PORTS=80
EXPOSE 80

ENTRYPOINT [ "dotnet", "/app/DotNetApiExample.dll" ]