import '../models/project_model.dart';

class ResumeData {
  static const String name = "Parth Prajapati";
  static const String role = "Mobile Application Developer | Flutter & Swift";
  static const String experienceSummary =
      "Experienced Flutter Developer with 4 years of expertise in building robust, scalable, and user-centric mobile applications. Proficient in advanced architecture components such as BLoC and GetX, with a strong focus on clean project structures and maintainable code. Skilled in implementing local databases, LiveData, Data Binding, and seamlessly integrating third-party APIs (e.g., Google Maps, payment gateways, and more). Recently expanded my skill set to include iOS development with Swift, further enhancing my ability to deliver cross-platform solutions. Known for delivering high-performance applications that prioritize user experience and scalability, I consistently meet project deadlines while maintaining a sharp focus on quality.";

  static const String mobile = "7383493845";
  static const String email = "bantiprajapati33@gmail.com";
  static const String linkedin = "https://www.linkedin.com/in/parth-prajapati-7174b2144";
  static const String github = "https://github.com/parthsp33";
  static const String website = "https://parth-prajapati-resume.web.app/";

  static const List<Map<String, dynamic>> experience = [
    {
      "company": "Yudiz Solution LTD",
      "role": "Sr Mobile Application Developer",
      "period": "12/2021 - Present",
      "location": "Ahmedabad",
      "responsibilities": [
        "Participating in the development and maintenance of mobile applications.",
        "Staying updated with the latest trends and technologies in mobile app development.",
        "Proficient in Git versioning, ensuring effective collaboration and version control.",
        "Advancing expertise in Flutter and iOS Swift through continuous learning and skill development.",
        "Improved app stability and performance through code optimization.",
        "Collaborated with backend teams to ensure seamless API integration.",
        "Reduced bugs and crashes by following best practices and QA processes.",
        "Dedicated communication with clients to understand requirements and provide updates on project progress.",
        "End-to-end app ownership (design → development → deployment).",
        "Solo developer on multiple production apps.",
        "Experience working directly with clients and stakeholders."
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
      "Antigravity"
    ],
  };

  static const Map<String, double> proficiency = {
    "Flutter": 0.95,
    "Dart": 0.90,
    "Swift": 0.75,
    "Firebase": 0.85,
    "CI/CD": 0.80,
  };

  // Stats
  static const String totalExperience = "4+";
  static const String totalProjects = "12+";

  static final List<ProjectModel> projects = [
    ProjectModel(
      name: "BASMA",
      shortDescription: "Simple property booking platform with two apps: one for tenants and one for landlords.",
      status: "In Progress",
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
      status: "In Progress",
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
      status: "In Progress",
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
      status: "In Progress",
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
