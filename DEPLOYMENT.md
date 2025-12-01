# Firebase Deployment Guide for Union Shop

## Prerequisites
- Node.js and npm installed
- Firebase CLI installed: `npm install -g firebase-tools`
- Firebase project created at [Firebase Console](https://console.firebase.google.com)
- Flutter SDK installed

## Required Files in Project Root

Create these files in your project root directory (same level as `pubspec.yaml`):

1. `.firebaserc`
2. `firebase.json`
3. `firestore.rules`
4. `firestore.indexes.json`

## Step-by-Step Deployment

### 1. Install Firebase CLI
```bash
npm install -g firebase-tools
```

### 2. Login to Firebase
```bash
firebase login
```

### 3. Create Configuration Files

Create all the required files in your project root (see separate artifacts for content).

### 4. Update .firebaserc
Replace `your-project-id` with your actual Firebase project ID (found in Firebase Console > Project Settings).

### 5. Build Flutter Web App
```bash
flutter clean
flutter pub get
flutter build web --release
```

### 6. Initialize Firebase (First Time Only)
If you haven't already initialized:
```bash
firebase init
```
Select:
- Firestore
- Hosting

Configuration:
- Public directory: `build/web`
- Configure as single-page app: `Yes`
- Set up automatic builds with GitHub: `No` (optional)
- Overwrite index.html: `No`

### 7. Deploy Everything
```bash
# Deploy both hosting and Firestore rules
firebase deploy

# Or deploy separately:
firebase deploy --only hosting
firebase deploy --only firestore:rules
firebase deploy --only firestore:indexes
```

### 8. Verify Deployment
Open the provided URL: `https://your-project-id.web.app`

## Subsequent Deployments

For updates after initial deployment:

```bash
flutter build web --release
firebase deploy --only hosting
```

## CI/CD Integration (Optional)

### GitHub Actions Example
Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to Firebase Hosting

on:
  push:
    branches:
      - main

jobs:
  build_and_deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter build web --release
      - uses: FirebaseExtended/action-hosting-deploy@v0
        with:
          repoToken: '${{ secrets.GITHUB_TOKEN }}'
          firebaseServiceAccount: '${{ secrets.FIREBASE_SERVICE_ACCOUNT }}'
          channelId: live
          projectId: your-project-id
```

## Support Resources

- [Firebase Documentation](https://firebase.google.com/docs)
- [Flutter Web Deployment](https://docs.flutter.dev/deployment/web)
- [Firebase Hosting Guide](https://firebase.google.com/docs/hosting)

---

**Note**: Replace `your-project-id` with your actual Firebase project ID throughout all configuration files.