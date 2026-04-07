# Base runtime
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 10000

# Build stage
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY . .

RUN dotnet restore
RUN dotnet publish -c Release -o /app/publish

# Final stage
FROM base
WORKDIR /app
COPY --from=build /app/publish .

CMD ["dotnet", "ElectronicMedRecord.dll"]
