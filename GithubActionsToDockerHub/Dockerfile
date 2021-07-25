FROM mcr.microsoft.com/dotnet/sdk:6.0 AS base
WORKDIR /app
#EXPOSE 5000
#ENV ASPNETCORE_URLS=http://+:5000

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore "GithubActionsToDockerHub/GithubActionsToDockerHub.csproj"
WORKDIR "/src/GithubActionsToDockerHub"
RUN dotnet build "GithubActionsToDockerHub.csproj" -c Release -o /app

FROM build AS publish
WORKDIR "/src/GithubActionsToDockerHub"
RUN dotnet publish "GithubActionsToDockerHub.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
EXPOSE 80
EXPOSE 443
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "GithubActionsToDockerHub.dll"]
#ENTRYPOINT ["dotnet", "BuySellApi.dll", "--server.urls", "http://0.0.0.0:5000"]