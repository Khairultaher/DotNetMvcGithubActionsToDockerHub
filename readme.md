### .Net MVC Github Actions To Docker Hub
## Create and Build Project
```
dotnet new sln --name GithubActionsToDockerHub
dotnet new mvc -o GithubActionsToDockerHub
dotnet sln add ./GithubActionsToDockerHub/GithubActionsToDockerHub.csproj
dotnet restore
dotnet build GithubActionsToDockerHub.sln
```
