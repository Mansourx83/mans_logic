# Flutter UI & Logic Showcase

This project is a complete Flutter demonstration that includes multiple UI patterns and logical implementations used in most mobile applications.  
It is designed to help developers understand real-life techniques such as image uploading, file selection, video playback, form validation, pagination, infinite scrolling, selections, and list filtering.

---

## ⭐ Features Demonstrated

The project includes:

### 📂 Attachments & Media Handling
- Pick and upload **single images**
- Pick **multiple images**
- Pick and play **videos** with proper container fitting
- Pick and open **files** (PDF, DOCX, JPG, etc.)

### 📝 Form Validation
- Live form validation  
- Email & password validation with custom rules  
- Dynamic buttons (enabled/disabled based on input)

### 🔍 Search & Filter
- Real-time search
- Category filter buttons
- Sort alphabetically / by price

### 📦 Pagination & Infinite Scroll
- Load more data while scrolling  
- Display loading indicators  
- Stop when there is no more data  
- Smooth user experience with lazy loading

### ✔️ Selection Logic
- Single item selection  
- Multiple item selection  
- Toggle selection  
- Image selection logic

Each screen is well-commented to ensure understanding of how the logic works step-by-step.

---

## 📦 Required Dependencies

Add the following packages in your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  image_picker: ^0.8.0
  video_player: ^2.5.0
  file_picker: ^5.0.0
  syncfusion_flutter_pdfviewer: ^20.1.59
  flutter_svg: ^1.1.0
