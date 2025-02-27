import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Localization {
  Localization(this.locale);

  final Locale locale;

  static Localization of(BuildContext context) =>
      Localizations.of<Localization>(context, Localization)!;

  static List<String> languages() => ['en', 'ar'];

  String get languageCode => locale.toString();

  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;

  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'en',
    'ar',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class AppLocalizationDelegate extends LocalizationsDelegate<Localization> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<Localization> load(Locale locale) =>
      SynchronousFuture<Localization>(Localization(locale));

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return Localization.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // loginPage
  {
    'welcome back': {
      'en': 'Welcome back',
      'ar': 'أهلاً بعودتك',
    },
    'Login message': {
      'en': 'Login to access your account below.',
      'ar': 'قم إدخال بيانات حسابك أدناه.',
    },
    'phone number': {
      'en': 'Phone Number',
      'ar': 'رقم الهاتف',
    },
    'enter phone': {
      'en': 'Enter your Phone Number...',
      'ar': 'أدخل رقم الهاتف الخاص بك ...',
    },
    'password': {
      'en': 'Password',
      'ar': 'كلمة المرور',
    },
    'enter password': {
      'en': 'Enter your password...',
      'ar': 'ادخل رقمك السري...',
    },
    'sign up': {
      'en': 'SignUp',
      'ar': 'تسجيل حساب',
    },
    'log in': {
      'en': 'Login',
      'ar': 'تسجيل الدخول',
    },
    'help': {
      'en': 'Need Help?',
      'ar': 'بحاجة مساعدة؟',
    },
    'contact us': {
      'en': 'Contact Us',
      'ar': 'تواصل معنا',
    },
    'login error title':{
      'en': 'Somthing went wrong',
      'ar': 'هناك خطأ ما'
    },
    'login error content':{
      'en':'Phone number or Password is incorrect.',
      'ar':'رقم الهاتف أو كلمة المرور غير صحيحة.'
    },
    'user inactive title':{
      'en':'Account activation needed',
      'ar':'حسابك بحاجة للتفعيل'
    },
    'user inactive content':{
      'en':'Contact us to activate your account.\n\nPhone: +962795632595\nE-mail: \npos-owner@gmail.com',
      'ar' :'تواصل معنا لتفعيل حسابك.\n\n رقم الهاتف: +962795632595\n البريد الإلكتروني: \npos-owner@gmail.com'
    },
    'wrong password':{
      'en':'Wrong Password',
      'ar':'كلمة المرور خاطئة'
    },
    'wrong phone':{
      'en':'Wrong Phone Number',
      'ar':'رقم الهاتف خاطئ'
    },
    'contact dialog':{
      'en':'Phone: \n+962795632595\nE-mail: \npos-owner@gmail.com',
      'ar':' رقم الهاتف: \n+962795632595\n البريد الإلكتروني: \npos-owner@gmail.com'
    },
    'signup error content':{
      'en':'Phone number could be used before.',
      'ar':'رقم الهاتف قد يكون مستخدم.'
    },
    'complete account':{
      'en':'Complete Account',
      'ar':'أكمل إنشاء الحساب'
    },
    'shop name':{
      'en':'Shop Name',
      'ar':'إسم المتجر'
    },
    'amount cash':{
      'en':'Amount of cash',
      'ar':'السيولة النقدية'
    },

    

  },
  //Side Menu
  {
    'theme mode':{
      'en':'Dark Mode',
      'ar':'الوضع الليلي'
    },
    'language':{
      'en':'Arabic',
      'ar':'إنجليزي'
    },
    'log out':{
      'en':'Log Out',
      'ar':'تسجيل الخروج'
    }
  },
  //Pages
  {
    'Home':{
      'en':'Home',
      'ar':'الرئيسية'
    },
    'Edit':{
      'en':'Edit',
      'ar':'تعديل'
    },
    'Sales':{
      'en':'Sales',
      'ar':'المبيعات'
    },
    'Info':{
      'en':'Info',
      'ar':'معلومات'
    },
    'Bills':{
      'en':'Bills',
      'ar':'الفواتير'
    }
  },
  //main page
  {
    'cash':{
      'en':'Cash:',
      'ar':'النقد:'
    },
    'categories':{
      'en':'Categories',
      'ar':'الفئات'
    },
    'products':{
      'en':'Products',
      'ar':'المنتجات'
    },
    'cart':{
      'en':'Cart',
      'ar':'السلة'
    },
    'scan':{
      'en':'Scan',
      'ar':'مسح'
    },
    'search product':{
      'en':'Search Product...',
      'ar':'البحث عن منتج...'
    },
    'jod':{
      'en':'JOD',
      'ar':'د.أ'
    },
    'discount hint':{
      'en':'Default is 0',
      'ar':'الخصم الافتراضي هو 0'
    },
    'no result':{
      'en':'No results found.',
      'ar':'لا يوجد منتجات لعرضها.'
    },

  },
  //Sales Page
  {
    'cash':{
      'en':'Cash:',
      'ar':'النقد:'
    },
    'sales':{
      'en':'Today\'sSales:',
      'ar':'مبيعات اليوم:'
    },
    'total':{
      'en':'Total :',
      'ar':'المجموع :'
    },
    'date':{
      'en':'Date :',
      'ar':'التاريخ :'
    },
    'sale details':{
      'en':'Sale Details :',
      'ar':'تفاصيل الفاتورة :'
    },
    'discount':{
      'en':'Discount :',
      'ar':'الخصم :'
    },
    'price':{
      'en':'Price :',
      'ar':'السعر :'
    },
    'product name':{
      'en':'Product Name :',
      'ar':'اسم المنتج :'
    },
    'complete sale':{
      'en':'Complete Sale',
      'ar':'أكمل البيع'
    },
    
  },
  //terms
  {
    'terms1':{
      'en' : 'Thank you for using "POS" the terms-and-conditions and the privacy policy are intended to make you aware of your legal rights and responsibilities with the respect to your access to and use of the "POS" app.\nPlease understand that your use of this application and it is services automatically enters you in agreement with our terms conditions and privacy policy:',
      'ar' : 'نشكرك على استخدام "POS"، تهدف الشروط والأحكام وسياسة الخصوصية إلى إعلامك بحقوقك ومسؤولياتك القانونية فيما يتعلق بالوصول إلى تطبيق "POS" واستخدامه.\nيرجى فهم أن استخدامك لهذا التطبيق وخدماته يدخلك تلقائيًا في موافقة على الشروط والأحكام وسياسة الخصوصية الخاصة بنا:'
    },
    'terms2':{
      'en' : '-Your privacy is very important to us. It is our policy to respect your privacy regarding any information. We may collect or we save in our databases.\n\n-The information you provide or stored in the application or databases is not To be viewed by any third parties may have interest in that information.\n\n-Neither, we nor any third parties provide any warranty or guarantee as to the accuracy timeliness performance completeness or stability of the application.\n\n-The service provided by this app is temporarily and can be discontinued at any time.\n\n-Any unauthorized use of this application may give rise to a claim for damages and / or be a criminal offense.',
      'ar' : '- خصوصيتك مهمة جدًا بالنسبة لنا. من سياستنا احترام خصوصيتك فيما يتعلق بأي معلومات. يجوز لنا جمعها أو حفظها في قواعد بياناتنا.\n\n- المعلومات التي تقدمها أو تخزنها في التطبيق أو قواعد البيانات ليست للعرض من قبل أي طرف ثالث قد يكون له مصلحة في تلك المعلومات.\n\n- لا نقدم نحن ولا أي طرف ثالث أي ضمان أو كفالة فيما يتعلق بدقة أو توقيت أو أداء أو اكتمال أو استقرار التطبيق.\n\n- الخدمة التي يقدمها هذا التطبيق مؤقتة ويمكن إيقافها في أي وقت.\n\n- أي استخدام غير مصرح به لهذا التطبيق قد يؤدي إلى مطالبة بالتعويض و / أو يشكل جريمة جنائية.'
    },
    'terms3':{
      'en' : 'For any other information please feel free to contact us at\nPhone: +962795632595\nE-mail: \nmohsoboh2014@gmail.com',
      'ar' : 'لأي معلومات أخرى لا تتردد في الاتصال بنا على الهاتف: +962795632595 البريد الإلكتروني: \nmohsoboh2014@gmail.com',
    },
  },
  //edit page
  {
    'product price': {
      'en':'Product Price',
      'ar':'سعر المنتج'
    },
    'description':{
      'en':'Decription',
      'ar':'التفاصيل'
    },
    'add pic':{
      'en':'Add Product Picture',
      'ar':'أضف صورة المنتج'
    },
    'add barcode':{
      'en':'Add Product Barcode',
      'ar':'أضف رمز المنتج'
    },
    'category':{
      'en':'Category',
      'ar':'الفئة'
    },
    'save':{
      'en': 'Save',
      'ar':'حفظ'
    },
    'cancel':{
      'en':'Cancel',
      'ar':'إلغاء'
    },
    'confirm':{
      'en':'Confirm',
      'ar':'تأكيد'
    },
    'delete msg':{
      'en':'Are you sure you want to delete this product ?',
      'ar':'هل أنت متأكد من حذف المنتج ؟'
    },
    'delete':{
      'en':'Delete',
      'ar':'حذف'
    },
    'delete category msg':{
      'en':'Are you sure you want to delete this category ?',
      'ar':'هل ,أنت متأكد من حذف هذه الفئة ؟'
    },
    'new category':{
      'en':'New Category',
      'ar':'فئة جديدة'
    },
    'category name':{
      'en':'Category Name',
      'ar':'أسم الفئة'
    },
    'category hint':{
      'en':'Ex: Smartphones',
      'ar':'مثل: هواتف'
    },
    'bills':{
      'en':'Bills',
      'ar':'الفواتير'
    },
    'new bill':{
      'en':'New Bill',
      'ar':'فاتورة جديدة'
    },
    'bill description':{
      'en':'Bill Description',
      'ar':'تفاصيل الفاتورة'
    },
    'bill description hint':{
      'en':'Ex: For new stock of Chargers',
      'ar':'مثال: فاتورة بضاعة شواحن جديدة'
    },
    'bill total':{
      'en':'Bill Total',
      'ar':'مجموع الفاتورة'
    },
    'bill details':{
      'en':'Bill Details :',
      'ar':'تفاصيل الفاتورة :'
    }
  }

].reduce((a, b) => a..addAll(b));
