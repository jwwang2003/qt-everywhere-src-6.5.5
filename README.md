# qt-everywhere-src-6.5.5

This project was meant to help build QT 6.5.5 (an older version of QT) on new MacOS, especially for Apple silicon. This is because some software is currently dependent on this version of QT and does not work with newer QT versions.

QT6.5 was originally developed using MacOS SDK14, we will have to install another version of Xcode (documented in the steps below).

Consult:
- https://developer.apple.com/support/xcode/
  - We will be installing a version of Xcode 15.0.x (contains MacOS SDK14)
  - Solution was inspried by this [stackoverflow post](https://stackoverflow.com/questions/65952224/qtcreator-fails-on-macos-sdk-11-1/66497078#66497078), through the exact steps did not work for us.
- This project must be built using MacOS SDK14, otherwise will run into compilation errors near the end. (Has been tested to compile successfully with an install of Xcode 15.0 (15A240d), and using up-to-date Xcode causes unavoidable compile errors)

Later in the future, this solution may or may not work.

> Tested on Apple M1 Max (MacOS 15.0.1) on March 6, 2025.

**NOTE:**

If building from nothing is too long of a process, or worried about running into other issues,
you can try downloading and extracting the pre-compiled binaries. If these binaries don't work then you need to build manually.

## Steps to build

1. You can choose to directly [download](https://download.qt.io/archive/qt/6.5/6.5.5/src/single/) the source code for 6.5.5 for clone the submodules: `git submodule update --init --recursive --progress --depth 20` (if directly downloading, please extract the contents of the compressed file into a folder named `qt5` at this root)
2. Apply a patch (for MacOS, maybe Windows?):
    ```shell
    cp patch.diff qt5/qtwebengine/src/3rdparty/chromium && \
      cd qt5/qtwebengine/src/3rdparty/chromium && \
      git apply patch.diff && cd ../../../../../
    ```
3. Install the correct version of Xcode:
    - First install [Xcodes](https://www.xcodes.app/)
    - Launch Xcodes, head to settings, and change Active/Select to `Always rename to Xcode.app`
    ![](./assets/xcodes_2.png)
    - Then, delete (or backup) your current install ox Xcode and install Xcode 15.0 (15A240d)
     ![](./assets/xcodes_1.png)
    - Make sure to set as **Active**
    - After this is complete, we can begin to build QT 6.5.5
4. Continue following compilation process [here](./qt5/README.md) (est. time ~20mins)
5. After a successful build, you can delete the current Xcode.app from you applciations folder or uninstall it using Xcodes. Then move your old install of Xcode.app back (if you backed up).

## Extracting the binaries

```bash
chmod +x script.sh
./script.sh ./qt5/qtbase binaries
# compress binaries...
```

> If any issues are encountered, please put up an issue or make a PR with the proposed fix/solution