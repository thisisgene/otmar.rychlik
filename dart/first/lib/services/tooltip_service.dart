import 'dart:async';

import 'package:angular2/core.dart';

import 'package:first/models/tooltip.dart';
import 'all_tooltips.dart';


@Injectable()
class TooltipService {
  Future<List<Tooltip>> getTooltips() async => allTooltips;
}