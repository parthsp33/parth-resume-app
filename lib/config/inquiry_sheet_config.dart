class InquirySheetConfig {
  /// Your Google Sheet (same file as in Drive). Used for documentation only —
  /// the app cannot write using this ID alone; you must deploy Apps Script and set [webhookUrl].
  ///
  /// Sheet: https://docs.google.com/spreadsheets/d/1QL1gvSoKZ1Z_JJmifFTP9cFERZLeBrj8BxbaM4pRjlk/edit
  static const String spreadsheetId = '1QL1gvSoKZ1Z_JJmifFTP9cFERZLeBrj8BxbaM4pRjlk';

  /// Google Apps Script **Web App** URL (ends with `/exec`), NOT the sheet edit URL.
  ///
  /// Create it from your sheet: Extensions → Apps Script → deploy as Web app → copy URL.
  /// See [INQUIRY_SHEET_SETUP.md].
  ///
  /// Example:
  /// `https://script.google.com/macros/s/XXXXX/exec`
  static const String? webhookUrl = null;
}
