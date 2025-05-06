#!/bin/bash

# Script to update Android configuration for Firebase integration

echo "Updating Android configuration for Firebase..."

# Check if android directory exists
if [ ! -d "android" ]; then
  echo "Error: android directory not found. Make sure you're in the Flutter project root."
  exit 1
fi

# Update android/build.gradle to include Google Services plugin
if ! grep -q "classpath 'com.google.gms:google-services'" android/build.gradle; then
  echo "Adding Google Services plugin to android/build.gradle..."
  
  # Create a temporary file with the updated content
  awk '
  /dependencies {/ {
    print $0
    print "        classpath \"com.google.gms:google-services:4.3.15\""
    next
  }
  { print }
  ' android/build.gradle > android/build.gradle.tmp
  
  # Replace the original file
  mv android/build.gradle.tmp android/build.gradle
  
  echo "Google Services plugin added to android/build.gradle"
else
  echo "Google Services plugin already exists in android/build.gradle"
fi

# Update android/app/build.gradle to apply Google Services plugin
if ! grep -q "apply plugin: 'com.google.gms.google-services'" android/app/build.gradle; then
  echo "Adding Google Services plugin application to android/app/build.gradle..."
  
  # Create a temporary file with the updated content
  awk '
  /apply plugin: "kotlin-android"/ {
    print $0
    print "apply plugin: \"com.google.gms.google-services\""
    next
  }
  { print }
  ' android/app/build.gradle > android/app/build.gradle.tmp
  
  # Replace the original file
  mv android/app/build.gradle.tmp android/app/build.gradle
  
  echo "Google Services plugin application added to android/app/build.gradle"
else
  echo "Google Services plugin application already exists in android/app/build.gradle"
fi

# Update dependencies in android/app/build.gradle
if ! grep -q "implementation platform('com.google.firebase:firebase-bom:" android/app/build.gradle; then
  echo "Adding Firebase BOM to android/app/build.gradle..."
  
  # Create a temporary file with the updated content
  awk '
  /dependencies {/ {
    print $0
    print "    implementation platform(\"com.google.firebase:firebase-bom:32.3.1\")"
    print "    implementation \"com.google.firebase:firebase-analytics\""
    print "    implementation \"com.google.firebase:firebase-auth\""
    print "    implementation \"com.google.firebase:firebase-firestore\""
    next
  }
  { print }
  ' android/app/build.gradle > android/app/build.gradle.tmp
  
  # Replace the original file
  mv android/app/build.gradle.tmp android/app/build.gradle
  
  echo "Firebase BOM added to android/app/build.gradle"
else
  echo "Firebase BOM already exists in android/app/build.gradle"
fi

# Update minSdkVersion if necessary (Firebase requires at least 19)
sed -i.bak 's/minSdkVersion [0-9]\+/minSdkVersion 21/g' android/app/build.gradle
rm -f android/app/build.gradle.bak

echo "Android configuration for Firebase updated successfully!"
echo "Make sure to add google-services.json file to android/app/ directory"
