# Build stage using .NET 7 SDK
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# Copy csproj and restore
COPY *.csproj ./
RUN dotnet restore

# Copy rest of the files and publish
COPY . ./
RUN dotnet publish -c Release -o out

# Runtime stage using .NET 7 Runtime
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app/out ./
ENTRYPOINT ["dotnet", "MyPortfolio.dll"]
