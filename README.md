# 📱 Rick and Morty Explorer – iOS Native App

Una app iOS construida con **SwiftUI** que consume la API de *Rick and Morty*, aplicando arquitectura limpia, testing, CoreData, MapKit y buenas prácticas de desarrollo profesional.

---

## 🚀 Features

### 🧑‍🚀 Personajes
- Lista de personajes con paginación infinita
- Búsqueda por nombre en tiempo real
- Filtros por:
  - Estado (Alive / Dead / Unknown)
  - Especie (Human / Alien)
- Pull to refresh
- Estados de UI:
  - Loading
  - Empty state
  - Error handling

---

### 📄 Detalle del personaje
- Imagen en alta calidad
- Información completa:
  - Nombre
  - Estado
  - Especie
  - Género
- Lista de episodios donde aparece
- Marcar episodios como vistos
- Sistema de favoritos (CoreData)
- Navegación a mapa

---

### ❤️ Favoritos
- Persistencia local con CoreData
- Agregar / eliminar personajes
- Estado sincronizado en toda la app

---

### 🗺️ Mapa
- Visualización con MapKit
- Ubicación simulada del personaje
- Marcadores personalizados

---

## 🧪 Testing

### Unit Tests
- ViewModels
- Repositories
- UseCases
- Uso de Mocks para desacoplar API

### UI Tests
Flujo completo automatizado:

---

## 🧹 Calidad de Código

- SwiftLint integrado
- Reglas automáticas de estilo
- Validación en cada build

---

## 🏗️ Arquitectura

Presentation (SwiftUI)
↓
ViewModels
↓
UseCases
↓
Repositories
↓
API Layer

✔ Clean Architecture  
✔ MVVM  
✔ Separación de responsabilidades  

---

## 📦 Dependency Injection

Se utiliza un **DI Container** para centralizar dependencias:

- APIClient
- Repositories
- UseCases

### Beneficios:
- Código desacoplado
- Fácil testing con mocks
- Escalable

---

## 🧰 Tech Stack

- Swift 5
- SwiftUI
- Combine
- CoreData
- MapKit
- XCTest
- SwiftLint

---

## ⚙️ Instalación

```bash
git clone https://github.com/samficher047/ios_App_Rick_And_Morty.git
cd MortyApp
open MortyApp.xcodeproj


📱 Requisitos
iOS 16+
Xcode 15+
Swift 5.9+
👨‍💻 Autor

Desarrollado por angel rodrigo 🚀
