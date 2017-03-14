// Copyright (c) 2016, thisisgene. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'package:angular2/core.dart';
import 'package:angular2/platform/browser.dart';
import 'package:angular2/router.dart';

import 'package:angular2/platform/common.dart';


import 'package:first/views/main_app/main_app.dart';
import 'package:http/browser_client.dart';
//import 'package:first/in_memory_data_service.dart';
import 'package:http/http.dart';

main() {
  bootstrap(MainApp,
      [provide(Client, useFactory: () => new BrowserClient(), deps: []),

        ROUTER_PROVIDERS,
        provide(LocationStrategy, useClass: HashLocationStrategy)
      ]

  );
}
