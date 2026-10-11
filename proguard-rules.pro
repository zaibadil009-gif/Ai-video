# ProGuard rules for AI Video Studio (minify is off by default; kept for release builds)
-keepattributes *Annotation*
-keep class com.shahzaib.aivideostudio.data.db.entity.** { *; }
-keep class androidx.room.** { *; }
-dontwarn org.jetbrains.annotations.**
