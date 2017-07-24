// Copyright (c) 2017, Thaniyarasu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'package:angular2/core.dart';
import 'package:angular2/angular2.dart';
import 'package:angular2/platform/browser.dart';
import 'package:http/http.dart';
import 'package:http/browser_client.dart';
import 'package:angular2/platform/browser.dart';

//import 'package:thani_ui/app_component.dart';
import 'package:thani_ui/components/app.dart';

void main() {
  bootstrap(AppComponent,[
    provide(BrowserClient, useFactory: () => new BrowserClient(), deps: [])
  ]);
}
