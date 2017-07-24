import 'package:angular2/core.dart';
import 'package:angular2/router.dart';


import 'package:thani_ui/components/posts/index/index.dart';
import 'package:thani_ui/services/post.dart';
import 'package:thani_ui/components/dashboard.dart';
import 'package:thani_ui/components/posts/show/show.dart';

@Component(
    selector: 'my-app',
    templateUrl: 'app.html',
    styleUrls: const ['app.css'],
    directives: const [ROUTER_DIRECTIVES],
    providers: const [PostService, ROUTER_PROVIDERS])
@RouteConfig(const [
  const Route(
      path: '/dashboard',
      name: 'Dashboard',
      component: DashboardComponent,
      useAsDefault: true),
  const Route(
      path: '/detail/:id', name: 'PostDetail', component: PostDetailComponent),
  const Route(path: '/posts', name: 'Posts', component: PostsComponent)
])
class AppComponent {
  String title = 'CRUD of Posts';
}
