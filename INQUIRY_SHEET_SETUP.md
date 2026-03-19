## Save Inquiry Form submissions to your Google Sheet

Your inquiry sheet (add a header row in row 1 if empty):

- **Open sheet:** [Inquire Sheet](https://docs.google.com/spreadsheets/d/1QL1gvSoKZ1Z_JJmifFTP9cFERZLeBrj8BxbaM4pRjlk/edit?gid=0#gid=0)
- **Spreadsheet ID:** `1QL1gvSoKZ1Z_JJmifFTP9cFERZLeBrj8BxbaM4pRjlk` (also in `lib/config/inquiry_sheet_config.dart`)

This app **always** saves copies to **Firebase Realtime Database** at `inquiries/`.

To also append each row to the sheet above, use **Google Apps Script** and paste the **Web App URL** into Flutter (not the sheet link).

---

### 1) Header row (row 1)

Suggested columns:

| A | B | C | D | E | F | G |
|---|---|---|---|---|---|---|
| createdAt | firstName | lastName | email | projectType | budgetRange | message |

---

### 2) Apps Script (bound to this sheet)

1. Open the sheet link above.
2. **Extensions → Apps Script**
3. Replace `Code.gs` with:

```javascript
function doPost(e) {
  // Uses the spreadsheet this script is attached to:
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var sheet = ss.getSheets()[0];

  var data = {};
  try {
    data = JSON.parse(e.postData.contents || "{}");
  } catch (err) {
    data = {};
  }

  sheet.appendRow([
    new Date(),
    data.firstName || "",
    data.lastName || "",
    data.email || "",
    data.projectType || "",
    data.budgetRange || "",
    data.message || ""
  ]);

  return ContentService
    .createTextOutput(JSON.stringify({ ok: true }))
    .setMimeType(ContentService.MimeType.JSON);
}
```

**Optional:** If the script is in a **standalone** Apps Script project (not opened from the sheet), open that sheet by ID:

```javascript
var ss = SpreadsheetApp.openById('1QL1gvSoKZ1Z_JJmifFTP9cFERZLeBrj8BxbaM4pRjlk');
var sheet = ss.getSheets()[0];
```

4. **Deploy → New deployment**
5. Type: **Web app**
6. Execute as: **Me**
7. Who has access: **Anyone** (required for the public resume site to POST)
8. **Deploy** and copy the URL — it must end with **`/exec`**

---

### 3) Put the Web App URL in Flutter

Edit `lib/config/inquiry_sheet_config.dart`:

```dart
static const String? webhookUrl = 'https://script.google.com/macros/s/YOUR_DEPLOYMENT_ID/exec';
```

Rebuild and deploy your site.

---

### 4) Flutter Web + CORS

Some browsers block `POST` from your domain to `script.google.com` (**CORS**). If the sheet never gets rows but Firebase `inquiries/` does:

- Test from **Android/iOS** build (no CORS), or  
- Add a small **Firebase Cloud Function** (or other backend) that receives the inquiry and calls the Sheet API / forwards to Apps Script.

---

### 5) Rebuild + deploy

```bash
flutter build web --release
firebase deploy
```
