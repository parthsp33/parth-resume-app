# Parth Prajapati Resume Site

This is my personal resume and portfolio website. It is built with Flutter for the web and hosted on Firebase Hosting.

Live site: https://parth-prajapati-resume.web.app/

## Tech stack

- Flutter (web), Dart SDK 3.6 or newer
- Firebase Hosting for the site
- Firebase Analytics for page and click events
- Firebase Realtime Database for the visitor counter
- `shared_preferences` to remember the theme choice and the last visit day in the browser
- `fl_chart` for the skills chart, `flutter_animate` for the section animations

## Where the content lives

All resume text is in one file: `lib/config/resume_data.dart`. This includes the name, role, summary, contact links, experience, education, achievements, skills and projects. To change what the site shows, edit this file.

Experience, education, achievements and projects use small typed models in `lib/models/`.

The text inside the `<noscript>` block and the meta tags in `web/index.html` are a separate copy for search engines. If you change your role, years of experience or contact details, please update `web/index.html` too.

## Resume PDF

The "Download CV" button opens `/Parth_Prajapati_Resume.pdf`. Put your PDF file here before you build:

```
web/Parth_Prajapati_Resume.pdf
```

Flutter copies everything in `web/` into the build output. If the file is missing, the button will open the home page instead of the PDF.

## Run locally

```
flutter pub get
flutter run -d chrome
```

## Check and test

```
flutter analyze
flutter test
```

## Build and deploy

```
flutter build web --release
firebase deploy --only hosting
```

Cache rules for the hosted files are in `firebase.json`. The page itself, the Flutter bootstrap files and the PDF are served with `no-cache`, so a new deploy shows up at once.

## Section links

You can link straight to a section, for example:

```
https://parth-prajapati-resume.web.app/#/?section=projects
```

The section names are the nav labels in lower case: `about`, `experience`, `education`, `achievements`, `projects`, `skills`, `contact`. When a visitor clicks a nav item, the address bar updates to this kind of link.
