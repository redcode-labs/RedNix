{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    afflib
    dcfldd
    ddrescue
    ddrescueview
    dislocker
    python39Packages.distorm3
    exiv2
    ext4magic
    extundelete
    foremost
    gzrt
    hivex
    ntfs3g
    ntfsprogs
    nwipe
    recoverjpeg
    safecopy
    sleuthkit
    srm
    stegseek
    testdisk
    wipe
    xorex
    capstone
    pdf-parser         
  ];
}
