FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["Hola_Mundo/Hola_Mundo.csproj", "Hola_Mundo/"]
RUN dotnet restore "Hola_Mundo/Hola_Mundo.csproj"
COPY . .
WORKDIR "/src/Hola_Mundo"
RUN dotnet build "Hola_Mundo.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Hola_Mundo.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Hola_Mundo.dll"]