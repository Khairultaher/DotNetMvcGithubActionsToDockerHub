FROM mcr.microsoft.com/dotnet/sdk:3.1 AS base
WORKDIR /app
#EXPOSE 5000
#ENV ASPNETCORE_URLS=http://+:5000

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY . .
RUN dotnet restore "weatherforecast/weatherforecast.csproj"
WORKDIR "/src/weatherforecast"
RUN dotnet build "weatherforecast.csproj" -c Release -o /app

FROM build AS publish
WORKDIR "/src/weatherforecast"
RUN dotnet publish "weatherforecast.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
EXPOSE 80
EXPOSE 443
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "weatherforecast.dll"]
#ENTRYPOINT ["dotnet", "BuySellApi.dll", "--server.urls", "http://0.0.0.0:5000"]