# Pottery App 🏺

An elegant and simple Flutter mobile application designed to showcase, browse, and interact with traditional handmade pottery products from our local village.

## 🌟 Features

- 🏠 **Home Page**: Displays a list of unique pottery products with name, price, and image.
- 🛒 **Shopping Cart**: Allows users to add or remove items from their cart and view them easily.
- ❤️ **Favorites**: Save favorite items for later access.
- 💬 **Contact Us**: Simple screen to contact the seller via WhatsApp.
- 🌙 **Dark Mode**: Easily toggle between dark and light themes (with persistent saving).
- 🎬 **Animations**:
  - Smooth entrance animation on the **Welcome Screen** using `FadeTransition`, `SlideTransition`, and `ScaleTransition`.
  - Interactive button animations for enhanced user experience.
- 📦 **Persistent Storage**: All cart and favorites are saved using `shared_preferences`.

## 🧱 Built With

- [Flutter](https://flutter.dev/)
- `shared_preferences` for local data saving
- `url_launcher` to open WhatsApp
- Flutter built-in animation widgets (`AnimationController`, `FadeTransition`, `SlideTransition`, etc.)
