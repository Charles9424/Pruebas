#COPY PROJECT FILES
COPY ./* .csproj ./
RUN dotnet restore

#COPY EVERYHIMG ESE
COPY . . 
RUN dotnet publish -c Release -o out 

# Crear una imagen final más pequeña
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /webapp
COPY --from=build-env /webapp/out .
ENTRYPOINT ["dotnet", "Hola_Mundo.dll"]