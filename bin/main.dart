import 'dart:async';
import 'dart:io';

main() async {
  getAllFileNames(taranacakKlasor);
}

// hangi klasörün taranacağını belirleyin
final taranacakKlasor = Directory("lib");

// dosya çıktısının nereye oluşturulacağını belirleyin.
String writePath = "bin/file_names";

getAllFileNames(Directory systemTempDir) async {
  List<String> allEntities = [];
  Stream<FileSystemEntity> entityList = systemTempDir.list(recursive: true, followLinks: false);
  await for (FileSystemEntity entity in entityList) {
    allEntities.add(entity.path);
  }
  allEntities.toSet();
  writeFiles(allEntities);
}

writeFiles(List entities) async {
  print(entities);
  File file = File("$writePath.dart");
  for (String entity in entities) {
    if (entity.endsWith("dart")) {
      await file.writeAsString("export '$entity' ;\n", mode: FileMode.append);
    }
  }
}
