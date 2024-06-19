# Rick and Morty iOS App

![rickandmorty](images/rickandmorty.png)

> **Wubba lubba dub dub! Да я роботов по приколу изобретаю!**

Проект по сериалу «Рик и Морти». 

### Описание проекта

Проект представляет собой приложение для отображения данных из [API Rick and Morty](https://rickandmortyapi.com/): API предоставляет информацию о персонажах, локациях и эпизодах шоу.

### Статистика из API

- Персонажи: 826
- Локации: 126
- Эпизоды: 51

Приложение использует архитектуру MVP (Model-View-Presenter) и включает следующие экраны:
- Экран с персонажами.
- Экран с локациями.
- Экран с эпизодами.
- У каждого из них есть экран с детальной информацией о персонаже, локации и эпизоде.

Приложение загружает данные из API, сохраняет их в базу данных Realm. Приложение поддерживает поиск по всем экранам.

### Структура проекта

- **App:** Входные точки приложения.
- **Constants:** Константы, используемые в приложении.
- **Utils:** Вспомогательные утилиты и расширения.
- **Model:** Модели данных и Realm-объекты.
- **Service:** Сервисы для работы с API и Realm.
- **View:** Основные экраны приложения.
- **Assembly:** Сборщики для создания модулей.
- **Presenter:** Логика представления данных.
- **Resources:** Ресурсы приложения.

### Используемый стек

- `UIKit`
- `URLSession`
- `Realm`

### Вид приложения 

![image]()

## The English version

<details>
<summary>Description</summary>

# Rick and Morty iOS App

> **Wubba lubba dub dub! Yeah, I invent robots for fun!**

A project based on the «Rick and Morty» TV show.

### Project Description

The project is an application for displaying data from the [Rick and Morty API](https://rickandmortyapi.com/): the API provides information about characters, locations, and episodes of the show.

### API Statistics

- Characters: 826
- Locations: 126
- Episodes: 51

The app uses the MVP (Model-View-Presenter) architecture and includes the following screens:

- Characters screen.
- Locations screen.
- Episodes screen.
- Each of these screens has a detailed information screen about the character, location, or episode.

The app loads data from the API and saves it to a Realm database. The app supports search functionality across all screens.

### Project Structure

- **App:** Entry points of the application.
- **Constants:** Constants used in the application.
- **Utils:** Utility functions and extensions.
- **Model:** Data models and Realm objects.
- **Service:** Services for working with the API and Realm.
- **View:** Main screens of the application.
- **Assembly:** Assemblers for creating modules.
- **Presenter:** Data presentation logic.
- **Resources:*** Application resources.

### Tech Stack

- `UIKit`
- `URLSession`
- `Realm`

### App Preview


</details>
