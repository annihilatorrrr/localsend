import 'package:localsend_app/util/native/content_uri_helper.dart';
import 'package:test/test.dart';

void main() {
  group('getFolderPathFromContentUri', () {
    test('should return the root folder path from the content uri', () {
      expect(
        ContentUriHelper.getFolderPathFromContentUri('content://com.android.externalstorage.documents/tree/primary%3ADocuments'),
        'primary:Documents',
      );
    });

    test('should return the folder path from the content uri', () {
      expect(
        ContentUriHelper.getFolderPathFromContentUri('content://com.android.externalstorage.documents/tree/primary%3ADocuments%2FOffice%20Lens'),
        'primary:Documents/Office Lens',
      );
    });

    test('should return folder path from content uri in SD card', () {
      expect(
        ContentUriHelper.getFolderPathFromContentUri('content://com.android.externalstorage.documents/tree/1234-5678:Documents'),
        '1234-5678:Documents',
      );
    });
  });

  group('getEntityNameFromPath', () {
    test('should return the entity name from the path', () {
      expect(
        ContentUriHelper.getEntityNameFromPath('primary:Documents'),
        'Documents',
      );
    });

    test('should return the entity name from the path with a folder', () {
      expect(
        ContentUriHelper.getEntityNameFromPath('primary:Documents/Office Lens'),
        'Office Lens',
      );
    });

    test('should return the entity name from the path with a folder in SD card', () {
      expect(
        ContentUriHelper.getEntityNameFromPath('1234-5678:Documents/Office Lens'),
        'Office Lens',
      );
    });
  });

  group('guessRelativePathFromPickedFileContentUri', () {
    test('should return the relative path from the picked file content uri', () {
      expect(
        ContentUriHelper.guessRelativePathFromPickedFileContentUri(
          folderContentUri: 'content://com.android.externalstorage.documents/tree/primary%3ADocuments%2FOffice%20Lens',
          basePath: 'primary:Documents/Office Lens',
          folderName: 'Office Lens',
          uri:
              'content://com.android.externalstorage.documents/tree/primary%3ADocuments%2FOffice%20Lens/document/primary%3ADocuments%2FOffice%20Lens%2FTest.pdf',
        ),
        'Office Lens/Test.pdf',
      );
    });

    test('should return the relative path from the picked file content uri without the folder', () {
      expect(
        ContentUriHelper.guessRelativePathFromPickedFileContentUri(
          folderContentUri: 'content://com.android.externalstorage.documents/tree/primary%3ADocuments',
          basePath: 'primary:Documents',
          folderName: 'Documents',
          uri: 'content://com.android.externalstorage.documents/tree/primary%3ADocuments/document/primary%3ADocuments%2FTest.pdf',
        ),
        'Documents/Test.pdf',
      );
    });

    test('should return the relative path from the picked file content uri in SD card', () {
      expect(
        ContentUriHelper.guessRelativePathFromPickedFileContentUri(
          folderContentUri: 'content://com.android.externalstorage.documents/tree/1234-5678:Documents',
          basePath: '1234-5678:Documents',
          folderName: 'Documents',
          uri: 'content://com.android.externalstorage.documents/tree/1234-5678:Documents/document/1234-5678:Documents%2FTest.pdf',
        ),
        'Documents/Test.pdf',
      );
    });
  });
}
