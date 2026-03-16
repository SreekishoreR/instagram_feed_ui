# Flutter UI/UX Challenge – Instagram Pixel-Perfect Feed

A Flutter implementation of the Instagram Home Feed designed to closely mirror the real Instagram interface while maintaining clean architecture and smooth UI interactions.

This project focuses on visual fidelity, smooth scrolling performance, and modular architecture.

---

# Demo

The demo video demonstrates:

• Shimmer loading state  
• Infinite scrolling pagination  
• Pinch-to-Zoom interaction on images  
• Like and Save state toggling  

GDrive link -> https://drive.google.com/file/d/1N-Lz0086jj4cQQT30-yHIvcPeA0lUdbf/view?usp=sharing

---

# Features

### Pixel-Accurate UI
- Instagram-style AppBar with Billabong font
- Stories row with gradient borders
- Carousel posts with synchronized dot indicator
- Correct spacing and icon scaling

### Advanced Image Handling
- Multi-image carousel using `PageView`
- Smooth horizontal scrolling
- Pinch-to-Zoom interaction using `InteractiveViewer`
- Images return to original position when released

### Stateful Interactions
- Double-tap to like animation
- Like and Save toggle stored locally
- Comment and Share buttons trigger Snackbars

### Loading Experience
- Simulated network latency
- Shimmer loading state while fetching posts

### Infinite Feed
- Lazy pagination when user scrolls near bottom
- New posts appended seamlessly

### Image Performance
- `cached_network_image` used for memory and disk caching

### Edge Case Handling
- Graceful fallback when images fail to load

---

# Architecture

The project follows a **clean separation of concerns**.

**models/**
Defines the data structure for posts.

**services/**
Handles the mock data layer and simulates API calls.

**providers/**
Manages application state using Provider.

**widgets/**
Reusable UI components used across the feed.

**screens/**
High-level UI composition of the feed page.

---

# State Management

This project uses **Provider** for state management.

Provider was chosen because:

- It keeps UI reactive
- It separates business logic from UI
- It is lightweight and easy to scale

The `PostProvider` handles:

• Fetching posts  
• Pagination logic  
• Like toggling  
• Save toggling  

---

# Mock Data Layer

Posts are fetched through a repository pattern.

```

PostRepository.fetchPosts(page)

```

This simulates a backend API call and returns a list of posts.

A **2-second delay** is introduced to simulate network latency and display the loading state.

---

# Pagination

Lazy loading is triggered when the user scrolls close to the bottom of the feed.

```

if (_scrollController.position.pixels >=
_scrollController.position.maxScrollExtent - 300)

```

This loads the next batch of posts and appends them to the existing list.

---

# Image Loading Strategy

Images are fetched from public image URLs and cached using:

```

cached_network_image

```

Benefits:

• Reduced network calls  
• Improved scrolling performance  
• Automatic disk caching

---

# Edge Case Handling

If an image fails to load, a placeholder container with a broken image icon is shown instead of crashing the UI.

---

# Steps to Run

1. Clone the repository

```

git clone <repo-link>

```

2. Navigate to project directory

```

cd instagram_home_feed

```

3. Install dependencies

```

flutter pub get

```

4. Run the application

```

flutter run

```

# Evaluation Considerations

This implementation focuses on the criteria mentioned in the challenge:

### Visual Fidelity
Carefully matched spacing, icon scale, and layout.

### Performance
Smooth scrolling and cached image loading.

### Architecture
Clean separation between UI, state management, and data layer.

### Edge Cases
Graceful handling of image loading failures.

---

# Notes

Priority was given to polishing the core feed interactions (carousel scrolling, pinch-to-zoom, and spacing) rather than implementing multiple screens, as recommended in the challenge instructions.

Quality and UI refinement were prioritized over feature quantity.

---

# Author
R.Sreekishore

---