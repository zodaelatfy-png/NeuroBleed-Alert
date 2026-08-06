# NeuroBleed Alert Enterprise Edition

## حالة المشروع (Phase 1 to 5: Architecture, DB, UI, Auth, AI, Admin & Maps)

تم استلام المتطلبات بنجاح، وشرعنا في بناء النظام ليوافق المعايير العالمية (Enterprise Grade) باستخدام Clean Architecture.

### ما تم إنجازه (Phase 1 to 4):
- **الباك إند**: Clean Architecture, Auth (JWT), Roles, AI Service Prediction.
- **الفرونت إند**: Design System (`NeuroColors`), التوجيه المخفي (`app_router`), لوحة تحكم الطبيب (`doctor_dashboard`).

### ما تم إنجازه الآن (Phase 5):
1. **لوحة الإدارة المخفية (Super Admin Dashboard)**:
   - تم بناء `admin_dashboard.dart` بتصميم يعكس مستويات الأمان العالية (High Security Clearance) والتشفير.
   - اللوحة لا تحتوي على أي مسار مرئي، وتعمل فقط عند تسجيل الدخول بحساب `SUPER_ADMIN`.
   - تعرض اللوحة ملخصاً حياً للأنظمة: المستخدمين، أجهزة البلوتوث النشطة (Sensors)، وعمليات الذكاء الاصطناعي التي تمت.

2. **خرائط الطوارئ (Emergency Hospital Maps)**:
   - تم بناء `hospital_map_screen.dart` باستخدام `flutter_map` وخرائط `OpenStreetMap` كما طلبت في الـ Master Prompt لتجنب الاعتماد الكلي على Google Maps.
   - تم إضافة ويدجت طوارئ سفلي (SOS) يسمح بحساب الـ ETA واقتراح أقرب مستشفى متخصص في جراحة المخ والأعصاب بناءً على الخوارزمية، مع زر لاستدعاء الإسعاف.

3. **ربط الشاشات (Router Integration)**:
   - تم تجميع كافة الشاشات (Login, Doctor, Admin, Maps) داخل ملف التوجيه المركزي `app_router.dart`.

---

### ⚠️ تنبيه هام (تذكير بمشكلة المساحة في جهازك):
لا تزال مشكلة مساحة القرص `(C:)` لديك قائمة. ومع ذلك، بفضل النشر السحابي، لن تحتاج إلى تشغيل الخادم محلياً.

### ما تم إنجازه أخيراً (Phase 6 - Deployment):
تم رفع ونشر النظام بالكامل على السحابة بنجاح عبر منصة **Railway**، وتعمل الآن الواجهة الأمامية والباك إند بشكل متصل وحي:
- 🌍 **رابط تطبيق الويب (Frontend):** https://frontend-production-d9fb.up.railway.app
- 🔗 **رابط الباك إند (API/Backend):** https://neurobleed-alert-production.up.railway.app/api/docs

> يمكنك الآن مشاركة روابط النظام ليتم اختباره واستخدامه من قبل أي شخص على أي جهاز!
