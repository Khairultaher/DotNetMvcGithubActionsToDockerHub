# Define base image
FROM microsoft/dotnet:3.1 AS build
# Copy project files
WORKDIR /src
COPY . .
# Restore
RUN dotnet restore "weatherforecast/weatherforecast.csproj"
WORKDIR "/src/weatherforecast"
RUN dotnet build "weatherforecast.csproj" -c Release -o /app
# Publish
FROM build AS publish
WORKDIR "/src/weatherforecast"
RUN dotnet publish "weatherforecast.csproj" -c Release -o /app

# Runtime
FROM microsoft/dotnet:3.1-aspnetcore-runtime
WORKDIR /app
EXPOSE 80
EXPOSE 443
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "weatherforecast.dll"]
#ENTRYPOINT ["dotnet", "BuySellApi.dll", "--server.urls", "http://0.0.0.0:5000"]