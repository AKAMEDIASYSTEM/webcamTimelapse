// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } 
  else {
    // If it's not a directory
    return null;
  }
}

// This function returns all the files in a directory as an array of File objects
// This is useful if you want more info about the file
File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } 
  else {
    // If it's not a directory
    return null;
  }
}

// Function to get a list ofall files in a directory and all subdirectories
ArrayList listFilesRecursive(String dir) {
  ArrayList fileList = new ArrayList(); 
  recurseDir(fileList,dir);
  return fileList;
}

// Recursive function to traverse subdirectories
void recurseDir(ArrayList a, String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    // If you want to include directories in the list
    a.add(file);  
    File[] subfiles = file.listFiles();
    for (int i = 0; i < subfiles.length; i++) {
      // Call this function on all files in this directory
      recurseDir(a,subfiles[i].getAbsolutePath());
    }
  } 
  else {
    a.add(file);
  }
}


/*
String[] filterByExtension(String[] folderNames, String extension) {
  String[] returnThis = null;
  String[] tempStr = null;
  for(int j=0; j<folderNames.length;j++) {
    String[] ext = split(folderNames[j],".");  // split the string into substrings separated by periods
    String currentExt = ext[ext.length-1];   // pick the last string in the array to get the extension
    if(currentExt.equals(extension)) {          // if the filename's extension matches our type, add it to the returned array
      returnThis = append(returnThis, folderNames[j]);
    }
  }
  return returnThis;
}
*/

// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir, java.io.FilenameFilter extension) {
  println("dir is "+dir);
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list(extension);
    return names;
  } else {
    // If it's not a directory
    println("it's not a tumor");
    return null;
  }
}