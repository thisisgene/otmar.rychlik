import 'package:first/models/project.dart';
final List<Project> mockProjects = [
  new Project('0001', 'Persönlich', false, null, null, true, ['12345', '67890'], 1, 'Das ist ein Text', 'Das ist ein Text', true, false),
  new Project('0002', 'Kunsthistoriker', false, null, null, true, ['1234b', '6789b'], 2, 'Das ist ein Text', 'Das ist ein Text', true, false),
  new Project('0003', 'Kunstler', false, null, null, false, null, 2, 'Das ist ein Text', 'Das ist ein Text', true, false),

  new Project('12345', 'Tagebuch', true, '0001', 'Persönlich', false, null, 1, 'Das ist ein Text', 'Das ist ein Text', true, false),
  new Project('1234b', 'Sache', true, '0002', 'Kunsthistoriker', true, ['abcd'], 1, 'Das ist ein Text', 'Das ist ein Text', true, false),

  new Project('abcd', 'Dings', true, '1234b', 'Kunsthistoriker', false, null, 1, 'Das ist ein Text', 'Das ist ein Text', true, false)

];