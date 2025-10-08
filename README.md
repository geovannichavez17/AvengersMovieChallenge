# AvengersMovieChallenge

Cliente iOS que lista y detalla películas (búsqueda “Avengers”), permite marcar favoritas con Core Data y muestra un detalle con imagen de fondo y promedio de votos. Construido con **SwiftUI, Combine, URLSession y Core Data** siguiendo un enfoque **MVVM con inyección de dependencias por protocolo.**

## Contenido
- Arquitectura
- Decisiones técnicas
- Estructura del proyecto
- Testing

## Arquitectura
- **MVVM** para separar UI, estado y lógica.
- **Protocol-oriented DI**: cada ViewModel recibe un `*DependenciesType` con servicios concretos
- **Combine** para networking reactivo y binding con la UI
- **Core Data** para persistir favoritos de forma local
- **SwiftUI** para vistas y navegación

## Decisiones técnicas

- **MVVM + DI por protocolos:** facilita testeo al inyectar `MoviesServiceType` y repositorios mock falsos para pruebas.

- **Core Data** en vez de Realm/UserDefaults para favoritos: Buen rendimiento en listas y con contextos en background para escrituras. Framework nativo de Apple. 

- **SwiftUI:** Puro, sin dependencias externas.

## Testing

- XCTest + Combine:
  - `MoviesServiceTests` validan paginación (`PagedResponse<Movie>`) y detalle de película (`MovieDetail`).
  - `MockNetworkClient` responde con JSON de prueba.
  - `JsonLoader` carga archivos mock de respuesta (.json) desde el bundle de tests.
