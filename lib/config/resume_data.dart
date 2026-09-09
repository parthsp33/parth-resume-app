import '../models/project_model.dart';

class ResumeData {
  static const String name = "Parth Prajapati";
  static const String role =
      "Software Engineer | React Native, Flutter & Swift";
  static const String experienceSummary =
      "Software Engineer with 4.5+ years of professional experience in mobile application development, with strong hands-on expertise in React Native, TypeScript, JavaScript, Expo, Flutter, Dart, and iOS Swift.";

  static const List<String> summaryPoints = [
    "Experienced in developing robust, scalable, and user-centric Android and iOS applications, including production applications and end-to-end ownership from development through deployment.",
    "Strong knowledge of modern React Native development using React Hooks, functional components, React Navigation, Zustand, TanStack Query, Axios, Expo Dev Client, and Metro Bundler.",
    "Experienced with application architecture and state management including BLoC/Cubit, GetX, MVVM, MVC, Clean Architecture, and Dependency Injection.",
    "Skilled in REST API integration, JSON serialization/deserialization, API error handling and interceptors, Firebase services, local data handling, analytics, crash monitoring, debugging, QA, CI/CD, and app-store releases.",
    "Comfortable working directly with clients, backend teams, QA teams, and stakeholders, with a focus on clean code, reusable components, performance, maintainability, and delivery quality.",
  ];

  static const String mobile = "7383493845";
  static const String email = "bantiprajapati33@gmail.com";
  static const String linkedin = "https://www.linkedin.com/in/parth-prajapati-7174b2144";
  static const String github = "https://github.com/parthsp33";
  static const String website = "https://parth-prajapati-resume.web.app/";

  static const List<Map<String, dynamic>> experience = [
    {
      "company": "E2Logy",
      "role": "Software Engineer",
      "period": "May 2026 - Present",
      "location": "Ahmedabad, Gujarat",
      "responsibilities": [
        "Developing and enhancing the Cinch POS App and Cinch Subscription App using React Native and Expo.",
        "Building cross-platform Android and iOS features with TypeScript, JavaScript, React Hooks, and functional components.",
        "Implementing application state management with Zustand and server-state management, caching, queries, and mutations with TanStack Query.",
        "Building navigation flows with React Navigation and integrating REST APIs using Axios.",
        "Working with Expo Dev Client and Metro Bundler while developing reusable and maintainable mobile components.",
        "Contributing to application debugging, testing, API integration, issue resolution, and release workflows.",
        "Working on retail/POS workflows where the retail solution provides devices to customers and the POS application serves as the sales-end application."
      ]
    },
    {
      "company": "Yudiz Solution LTD",
      "role": "Sr. Mobile Application Developer",
      "period": "Dec. 2021 - Apr. 2026",
      "location": "Ahmedabad, Gujarat",
      "responsibilities": [
        "Participated in the development and maintenance of production-grade mobile applications.",
        "Developed and maintained applications using Flutter and iOS Swift, focusing on clean architecture, performance, stability, and maintainability.",
        "Integrated REST APIs and third-party services while collaborating closely with backend teams.",
        "Implemented application features, UI flows, local data handling, API communication, and production fixes.",
        "Improved application stability and performance through code optimization and development best practices.",
        "Reduced bugs and crashes by following QA processes, debugging practices, and release-quality checks.",
        "Used Git versioning and CI/CD practices, including Dev/QA/Prod build flavors and store deployment workflows.",
        "Worked directly with clients and stakeholders to understand requirements, provide updates, and deliver features.",
        "Handled end-to-end application ownership across design, development, testing, debugging, and deployment.",
        "Worked as a solo developer on multiple production applications."
      ]
    }
  ];

  static const List<Map<String, dynamic>> education = [
    {
      "institution": "GEC Modasa",
      "degree": "Bachelor of IT(Information Technology)",
      "period": "2013-2016",
      "location": "Modasa, Gujarat",
      "grade": "7.5 CGPA"
    }
  ];

  static const List<Map<String, dynamic>> achievements = [
    {
      "title": "First Prize, Online Charging Station Hackathon (2022 OCT)",
      "description": "Developed and presented a winning solution for an online charging station, showcasing innovation and problem-solving skills. Implemented features to enable users to find and book available charging slots efficiently."
    },
    {
      "title": "Runner-Up, AI-Thon Treasure Hunt (Jan 2024)",
      "description": "Successfully participated in an AI-themed treasure hunt, showcasing teamwork, analytical skills, and adaptability. Demonstrated an aptitude for problem-solving within a competitive environment."
    }
  ];

  static const Map<String, List<String>> skills = {
    "React Native": [
      "TypeScript & JavaScript",
      "Expo & Expo Dev Client, Metro Bundler",
      "React Hooks & Functional Components",
      "State Management with Zustand",
      "Server State, Caching & Mutations with TanStack Query",
      "React Navigation",
      "REST API Integration with Axios"
    ],
    "Flutter": [
      "Dart",
      "State Management (Bloc/Cubit, Getx)",
      "MVVM / MVC, Dependency Injection, Clean Architecture",
      "Firebase (Authentication, Firestore, FCM, Analytics, Crashlytics)",
      "Rest Api & JSON, Interceptors, Error Handling",
      "Android & Apple Store Deployment",
      "Git Versioning & CI-CD (Build Flavors)"
    ],
    "Swift": [
      "UIKit",
      "SwiftUI",
      "CoreData",
      "Xcode IDE",
      "Cocoa Touch Framework",
      "RESTful APIs"
    ],
    "AI & Developer Productivity Tools": [
      "ChatGPT (GPT)",
      "Cursor",
      "Codex",
      "Claude",
      "Antigravity"
    ],
  };

  static const Map<String, double> proficiency = {
    "React Native": 0.50,
    "Flutter": 0.95,
    "Dart": 0.90,
    "Swift": 0.75,
    "Firebase": 0.85,
    "CI/CD": 0.80,
  };

  // Stats
  static const String totalExperience = "4.5+";
  static const String totalProjects = "12+";

  static final List<ProjectModel> projects = [
    ProjectModel(
      name: "Cinch Retail & POS App",
      shortDescription:
          "A retail technology solution focused on providing retail devices to customers and supporting the POS application as the sales end. The mobile solution includes customer-facing and sales-oriented workflows and is developed for Android and iOS.",
      status: "In Progress",
      tools:
          "React Native, Expo, TypeScript, JavaScript, React Hooks, Functional Components, Zustand, TanStack Query, React Navigation, Axios, Expo Dev Client, Metro Bundler",
      keyFeatures: [
        "Retail device/customer workflow support",
        "POS sales-end application functionality",
        "Cross-platform Android and iOS development",
        "Application state management with Zustand",
        "Server-state caching, queries and mutations with TanStack Query",
        "REST API integration using Axios",
        "Reusable mobile components and navigation flows"
      ],
      teamSize: 1,
      appStoreLink: "https://apps.apple.com/sg/app/cinch-tech/id6786142725",
    ),
    ProjectModel(
      name: "Cinch Subscription App",
      shortDescription:
          "A subscription-focused mobile application developed alongside the Cinch POS solution using React Native and Expo.",
      status: "In Progress",
      tools:
          "React Native, Expo, TypeScript, JavaScript, Zustand, TanStack Query, React Navigation, Axios",
      keyFeatures: [
        "Subscription-related mobile workflows",
        "Cross-platform Android and iOS features",
        "API integration and server-state management",
        "Reusable React Native components"
      ],
      teamSize: 1,
    ),
    ProjectModel(
      name: "BASMA",
      shortDescription: "Simple property booking platform with two apps: one for tenants and one for landlords.",
      status: "Complete",
      tools: "Flutter 3.35, Android Studio, Xcode",
      keyFeatures: [
        "Landlord: Add properties, manage photos, receive booking requests",
        "Tenant: Search with filters (location, price), send rental requests",
        "Separate apps for Landlords and Tenants with seamless interaction"
      ],
      teamSize: 1,
    ),
    ProjectModel(
      name: "MASHLife",
      shortDescription: "Dance event booking platform for searching and exploring events worldwide via interactive maps.",
      status: "Complete",
      tools: "Flutter 3.35, Android Studio, Xcode",
      keyFeatures: [
        "Global event exploration with interactive map views",
        "Event promotion and hosting for organizers",
        "Vendor section for listing products in a shop environment"
      ],
      teamSize: 1,
      appStoreLink: "https://apps.apple.com/app/id1591731993",
      playStoreLink: "https://play.google.com/store/apps/details?id=com.mashlife.app&hl=en_IN",
    ),
    ProjectModel(
      name: "Greyy8",
      shortDescription: "Two-app platform (Vendor/User) connecting businesses with users via deals, coins, and cashback rewards.",
      status: "Complete",
      tools: "Flutter 3.16.5, Android Studio, Xcode",
      keyFeatures: [
        "Vendor app: Create deals, manage promotions, analytics dashboard",
        "User app: Discover offers, earn coins/cashback, transfer to bank account",
        "Push notifications and detailed user engagement tracking"
      ],
      teamSize: 1,
      playStoreLink: "https://play.google.com/store/apps/details?id=com.amar.shopme",
    ),
    ProjectModel(
      name: "Reseda Church",
      shortDescription: "Management app for church services, facility rentals, Bible reading, and donations.",
      status: "Complete",
      tools: "Flutter 3.16.5, Android Studio, Xcode",
      keyFeatures: [
        "Prayer services and facility rental bookings",
        "Bible reading and funeral arrangement services",
        "Secure donation integration"
      ],
      teamSize: 1,
    ),
    ProjectModel(
      name: "Stacked Up",
      shortDescription: "All-in-one social media platform for marketers to plan, schedule, and analyze content directly.",
      status: "Complete",
      tools: "Flutter 2.8, Android Studio, Xcode",
      keyFeatures: [
        "Direct image and content sharing to social media pages",
        "Comprehensive social media analytics for marketers"
      ],
      teamSize: 1,
    ),
    ProjectModel(
      name: "Q-Club",
      shortDescription: "Golf-focused app for team selection and live scoreboard management.",
      status: "Complete",
      tools: "Flutter 3.0, Android Studio, Xcode",
      keyFeatures: [
        "Team selection and management",
        "Live score entry and scoreboard displays"
      ],
      teamSize: 1,
    ),
    ProjectModel(
      name: "Pick Up My Things",
      shortDescription: "E-commerce platform for ordering groceries, fresh produce, and drinks with same-day delivery.",
      status: "Complete",
      tools: "Flutter 2.5, Android Studio, Xcode",
      keyFeatures: [
        "Online shopping for fresh produce, drinks, and alcohol",
        "Same-day delivery or pickup options",
        "Two apps: Store app and Delivery app for end-to-end logistics"
      ],
      teamSize: 1,
      appStoreLink: "https://apps.apple.com/us/app/pick-up-my-things/id1563413994",
    ),
    ProjectModel(
      name: "Shop & Me",
      shortDescription: "Hyperlocal grocery application for fast food and vegetable delivery.",
      status: "Complete",
      tools: "Flutter 2.5, Android Studio, Xcode",
      keyFeatures: [
        "Hyperlocal product search and discovery",
        "Fast delivery boy application for timely orders",
        "Order tracking and location management"
      ],
      teamSize: 3,
      playStoreLink: "https://play.google.com/store/apps/details?id=com.amar.shopme",
    ),
  ];
}
