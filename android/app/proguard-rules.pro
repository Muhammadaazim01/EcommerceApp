# Stripe SDK keep rules
-keep class com.stripe.** { *; }
-dontwarn com.stripe.**

-keep class com.reactnativestripesdk.** { *; }
-dontwarn com.reactnativestripesdk.**

-keep class kotlin.** { *; }
-keep class kotlinx.** { *; }

-keepclassmembers class * {
    public <init>(...);
}
