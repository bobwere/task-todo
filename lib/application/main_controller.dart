import 'package:activity/activity.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class MainController extends ActiveController {
  MainController();
  @override
  Iterable<ActiveType> get activities => [];
}
