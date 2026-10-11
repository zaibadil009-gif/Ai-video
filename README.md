# AI Video Studio — Android ایپ (مکمل سورس کوڈ)

## یہ ایپ کیا کرتی ہے؟

**AI Video Studio** ایک مکمل native Android ایپ ہے جو آپ کے لیے پوری ویڈیو خودکار بناتی ہے:

1. **ٹاپک یا اسکرپٹ دیں** — آپ صرف موضوع لکھیں (مثلاً "The fall of the Ottoman Empire") یا اپنا مکمل انگلش اسکرپٹ paste کریں۔
2. **AI اسکرپٹ توڑتی ہے** — اسکرپٹ سینز (scenes) میں تقسیم ہوتی ہے؛ ہر سین کے لیے image prompt اور narration الگ ہوتی ہے۔
3. **AI امیجز بنتی ہیں** — ہر سین کے لیے مفت Pollinations.ai سے تصویر بنتی ہے (کوئی key نہیں چاہیے)۔ چاہیں تو گیلری سے اپنی تصویر بھی لگا سکتے ہیں۔
4. **آٹو وائس اوور** — ہر سین کی narration آپ کے فون کے built-in Text-to-Speech سے بولی جاتی ہے اور WAV فائل میں save ہوتی ہے۔ **مکمل مفت، کوئی API key نہیں، آف لائن بھی چلتا ہے۔**
5. **CapCut جیسی ٹائم لائن** — کلپس کو آگے پیچھے کریں، narration بدلیں، امیج دوبارہ بنوائیں، motion (zoom/pan) چنیں، وائس سن کر چیک کریں۔
6. **ایکسپورٹ** — ایک کلک پر پوری MP4 ویڈیو بنتی ہے: امیجز پر Ken Burns motion، وائس اوور muxed، اور انگلش **subtitles ویڈیو میں burned**۔
7. **آٹو تھمبنیل** — ایکسپورٹ کے بعد درمیان والا فریم خودکار PNG تھمبنیل بنتا ہے؛ ایک ٹیپ پر AI تھمبنیل بھی بنوایا جا سکتا ہے۔
8. **SEO پیکج** — ٹائٹل، ڈسکرپشن، tags، hashtags — سب copy بٹن کے ساتھ۔
9. **Voiceover only ایکسپورٹ** — صرف narration کی ایک merged آڈیو فائل share sheet سے بھیجی جا سکتی ہے (CapCut میں لگانے کے لیے)۔
10. **ہسٹری** — سارے projects save رہتے ہیں؛ دوبارہ کھولیں، ایڈٹ کریں، ڈیلیٹ کریں۔

## ٹیکنیکل خلاصہ

- Kotlin + Jetpack Compose (Material3، ڈارک تھیم)، MVVM
- minSdk 26، targetSdk 34، AGP 8.5.2، Gradle 8.7، JVM 17
- Room (project history)، DataStore (settings)، Navigation Compose، Coil، OkHttp
- ExoPlayer **صرف** preview کے لیے؛ فائنل ایکسپورٹ manual **MediaCodec (H.264) + MediaMuxer** pipeline سے
- Foreground Service میں ایکسپورٹ (progress notification کے ساتھ)

## Android Studio میں کیسے کھولیں؟

1. **Android Studio** انسٹال کریں (Ladybug یا نیا ورژن) — https://developer.android.com/studio
2. Android Studio کھولیں → **Open** → یہ `ai-video-studio` فولڈر منتخب کریں۔
3. پہلی بار Gradle sync ہوگا (انٹرنیٹ چاہیے) — چند منٹ لگ سکتے ہیں۔

## فون / ایمولیٹر پر کیسے چلائیں؟

- **ایمولیٹر:** اوپر ٹول بار میں device منتخب کریں (مثلاً Pixel 8، API 34) → سبز **Run ▶** بٹن دبائیں۔
- **اصل فون:** فون میں Developer Options آن کر کے **USB debugging** آن کریں، کیبل سے لگائیں، پھر Run دبائیں۔

> نوٹ: وائس اوور کے لیے فون/ایمولیٹر میں Google Text-to-Speech engine ہونا چاہیے (زیادہ تر ڈیوائسز میں پہلے سے ہوتا ہے)۔

## Debug APK کیسے بنائیں؟ (ٹیسٹنگ کے لیے)

Android Studio میں: **Build → Build App Bundle(s) / APK(s) → Build APK(s)**

تیار APK یہاں ملے گی:

```
app/build/outputs/apk/debug/app-debug.apk
```

اسے فون میں کاپی کر کے انسٹال کر لیں۔

## Signed Release APK / AAB کیسے بنائیں؟ (Play Store کے لیے)

1. **Build → Generate Signed App Bundle / APK**
2. **Android App Bundle** منتخب کریں (Play Store کے لیے AAB ہی چاہیے) → Next
3. **Create new…** سے نیا keystore بنائیں (فائل + پاس ورڈ **محفوظ جگہ** لکھ لیں — کھو گیا تو اپڈیٹ نہیں دے سکیں گے!)
4. **release** variant → Finish
5. تیار AAB یہاں ملے گی: `app/build/outputs/bundle/release/app-release.aab`

## Play Store پر ڈالنے کے لیے

- **Google Play Console** اکاؤنٹ چاہیے: ایک بار **$25** فیس (https://play.google.com/console)
- Play Console میں نئی app بنائیں → AAB اپ لوڈ کریں → store listing (نام، ڈسکرپشن، اسکرین شاٹس، آئیکن) مکمل کریں → review کے لیے بھیجیں۔
- پہلی release کے لیے **کم از کم 12 testers کے ساتھ 14 دن closed testing** درکار ہوتی ہے (نئے ڈویلپر اکاؤنٹس کے لیے)۔
- Privacy Policy کا URL دینا لازمی ہے (ایپ انٹرنیٹ استعمال کرتی ہے)۔

## LLM Key کہاں ڈالیں؟ (اختیاری)

ایپ میں: **Settings → AI script writer** میں:

- **Base URL:** مثلاً `https://api.openai.com/v1` یا `https://openrouter.ai/api/v1`
- **API key:** آپ کی key
- **Model:** مثلاً `gpt-4o-mini`

Key ہو تو اسکرپٹ اور SEO زیادہ smart بنتے ہیں۔ **نہ ہو تو بھی ایپ مکمل چلتی ہے** — built-in writer استعمال ہوتا ہے۔

## لاگت (Cost) — صاف حساب

| چیز | لاگت |
|---|---|
| AI امیجز (Pollinations.ai) | **مفت**، کوئی key نہیں |
| وائس اوور (فون کا TTS) | **مفت**، آف لائن |
| اسکرپٹ/SEO (built-in) | **مفت** |
| اسکرپٹ/SEO (اپنی LLM key) | آپ کی key کا خرچہ (آپ کی مرضی) |
| Play Console اکاؤنٹ | ایک بار $25 |

یعنی **بغیر ایک روپے خرچے** ایپ چلتی ہے؛ key صرف چاہیں تو ڈالیں۔

## معلوم حدود (Known limitations) — ایمانداری سے

1. **ایکسپورٹ سپیڈ:** ویڈیو CPU پر frame-by-frame بنتی ہے (~5-12 fps @720p)۔ 2 منٹ کی ویڈیو میں چند منٹ لگ سکتے ہیں — یہ foreground service میں background میں ہوتی ہے۔
2. **AI ویڈیو کلپس نہیں:** "اصل" AI-generated ویڈیو کلپس کے لیے paid APIs (Runway وغیرہ) چاہئیں — اس ورژن میں امیجز پر cinematic motion (Ken Burns) ہے۔
3. **وائس کوالٹی:** فون کے TTS engine پر منحصر ہے؛ چاہیں تو Settings میں دوسری voice چن لیں۔
4. **Pollinations امیجز** کے لیے انٹرنیٹ ضروری ہے۔
5. پہلی Gradle sync اور build کے لیے اچھا انٹرنیٹ اور کم از کم 8GB RAM والا کمپیوٹر بہتر ہے۔

## پراجیکٹ کا ڈھانچہ

```
ai-video-studio/
├── README.md
├── settings.gradle.kts / build.gradle.kts / gradle.properties
├── gradle/wrapper/            # Gradle 8.7 wrapper
├── gradlew / gradlew.bat
└── app/
    ├── build.gradle.kts
    └── src/main/
        ├── AndroidManifest.xml
        ├── java/com/shahzaib/aivideostudio/
        │   ├── MainActivity.kt / AiVideoStudioApp.kt
        │   ├── data/   (Room entities, DAO, DataStore settings, repository)
        │   ├── network/ (PollinationsClient, LlmClient)
        │   ├── script/  (ScriptEngine — LLM + offline template)
        │   ├── tts/     (TtsManager — on-device voiceover)
        │   ├── audio/   (WavUtils — WAV parse/concat)
        │   ├── render/  (VideoRenderer — MediaCodec+MediaMuxer, KenBurns, YUV)
        │   ├── export/  (ExportService — foreground service)
        │   ├── seo/     (SeoGenerator)
        │   ├── share/ / util/
        │   └── ui/      (theme, nav, 7 screens, 3 ViewModels)
        └── res/         (adaptive launcher icon — XML only)
```

## GitHub سے مفت APK بنانا (سب سے آسان طریقہ — کچھ انسٹال نہیں کرنا)

1. github.com پر فری اکاؤنٹ بنائیں (ای میل verify کرنا نہ بھولیں)۔
2. نیا repository بنائیں (نام مثلاً ai-video-studio) → **"uploading an existing file"** پر کلک کریں۔
3. اس ZIP کو unzip کریں، پھر unzipped `ai-video-studio` فولڈر کے **اندر کی تمام چیزیں** (فولڈرز سمیت) drag کر کے upload area میں ڈال دیں — ZIP فائل خود اپ لوڈ نہ کریں، اور باہر والا `ai-video-studio` فولڈر بھی نہ ڈالیں۔ (Chrome میں فولڈرز drag-drop سے structure برقرار رہتی ہے؛ یہ پراجیکٹ 100 فائلز سے کم ہے، ایک ہی بار میں اپ لوڈ ہو جائے گا۔)
4. نیچے commit message لکھ کر **Commit changes** دبائیں۔
5. اوپر **Actions** ٹیب کھولیں — اگر GitHub workflows enable کرنے کو کہے تو **"I understand my workflows, go ahead and enable them"** دبائیں۔ "Build APK" workflow خود بخود چل پڑے گا (تقریباً 5-10 منٹ)۔
6. مکمل ہونے پر اس run کو کھولیں، نیچے **Artifacts** سیکشن میں `ai-video-studio-apk` ڈاؤن لوڈ کریں — یہی آپ کی APK فائل ہے، فون میں انسٹال کر کے چلا سکتے ہیں۔

نوٹ: یہ debug APK ہے (ٹیسٹنگ کے لیے)۔ Play Store پر ڈالنے کے لیے signed release build چاہیے ہوگی — وہ Android Studio سے بنتی ہے (اوپر طریقہ درج ہے)۔
