import 'package:get/get.dart';

import 'AstrozyipTranslations.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en':{
      ...loginTranslations.en
    },
    'ta':{
      ...loginTranslations.ta
    }
  };
}
