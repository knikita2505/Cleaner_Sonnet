# [SCREEN] permissions_flow

## Назначение
Единый онбординг-флоу, который последовательно запрашивает у пользователя системные разрешения, нужные для работы ключевых модулей:

1. Доступ к Фото — необходим для анализа дубликатов, похожих фото, видео, Live Photos.
2. Доступ к Контактам — необходим для работы модуля "Secret Contacts" и функции очистки дублей контактов.
3. Разрешение на Уведомления — для напоминаний об очистке устройства и подсказок по устройству.

Каждое разрешение сопровождается объясняющим экраном (pre-prompt) перед системным диалогом iOS.

---

# Общая структура flow

Flow состоит из трёх шагов:

1. **Photo Access**  
2. **Contacts Access**  
3. **Notifications (optional step)**

Между шагами пользователь нажимает кнопку `Continue`.

---

# Шаг 1 — Доступ к Фото

## UI

### Заголовок:
**Allow access to your Photos**

### Подзаголовок:
We need this to detect duplicates, similar photos, live photos, screenshots and large videos to free up your storage space.

### Safety note:
**Your photos are analyzed only on your device. We never upload your media anywhere.**

### Кнопки:
- Primary: **Continue**
- Secondary (small): Skip for now → но всё равно блокируем доступ к функционалу медиачистки.

После Continue → системный диалог iOS:

**NSPhotoLibraryUsageDescription** должен соответствовать объяснению:
> “We need access to your photos to detect duplicates, similar photos, large videos and help you free up storage space.”

---

# Шаг 2 — Доступ к Контактам (Новый блок)

## UI

### Заголовок:
**Allow access to your Contacts**

### Подзаголовок:
We use contacts access to:
- find and merge duplicate contacts,
- clean empty or outdated entries,
- enable the “Secret Contacts” feature.

### Safety note:
**We never upload your contacts. All processing happens locally on your device.**

### Кнопки:
- Primary: **Allow Contacts Access**
- Secondary (small): Skip for now  
  → в этом случае:
  - скрываем “Secret Contacts” модуль,
  - отключаем функцию очистки контактов.

После Continue → системный диалог iOS:

**NSContactsUsageDescription** должен звучать:
> “We need access to your contacts to help merge duplicates, remove empty entries, and store private contacts securely.”

---

# Шаг 3 — Разрешение на Уведомления (опционально)

## UI

### Заголовок:
**Stay informed about your device health**

### Подзаголовок:
We send occasional reminders about cleaning your storage and helpful device tips.  
You can change notification settings anytime.

### Кнопки:
- Primary: **Enable Notifications**
- Secondary: **Not now**

Системный диалог iOS:
> “We use notifications for cleaning reminders and device health suggestions.”

---

# Итоговый экран (при необходимости)
Если разрешения успешно даны:
- Показываем небольшой финальный экран:  
  **“You’re all set!”**  
  CTA: **Continue → main_dashboard**

Если пользователь что-то пропустил — пропускаем этот экран.

---

# Поведение и логика

### 1. Flow показывается:
- при первом запуске приложения;
- если флаг `hasCompletedPermissionsFlow = false`;
- если принудительно вызван через `feature_flags`.

### 2. Требования Apple:
- Нельзя показывать системный диалог без объясняющего экрана.
- Текст pre-prompt должен соответствовать NSUsageDescription в Info.plist.

### 3. Если пользователь отказал доступ:
- Фото → блокируем все модули Photo/Video, показываем блокирующий экран с CTA:
  - “Allow Photos Access in Settings”
- Контакты → скрываем весь модуль “Contacts Cleaner” и “Secret Contacts”
- Уведомления → продолжаем работу, без блокировок.

### 4. Если пользователь принудительно скрыл системный диалог:
- Помечаем состояние как “denied”.

### 5. Логи:
- `perm_flow_start`
- `perm_photos_pre_prompt_shown`
- `perm_photos_granted` / `perm_photos_denied`
- `perm_contacts_pre_prompt_shown`
- `perm_contacts_granted` / `perm_contacts_denied`
- `perm_push_pre_prompt_shown`
- `perm_push_granted` / `perm_push_denied`
- `perm_flow_completed`

---

# Edge Cases

### Пользователь дал доступ к фото, но не дал доступ к контактам
- фото-модули работают,
- модуль контактов выключен.

### Пользователь дал доступ только к конкретным альбомам (iOS 14+)
- показываем экран-подсказку:  
  **“To clean all duplicates, allow access to all photos.”**

### Пользователь дал частичный доступ к контактам (редко, но возможно)
- используем только доступные записи.

---

