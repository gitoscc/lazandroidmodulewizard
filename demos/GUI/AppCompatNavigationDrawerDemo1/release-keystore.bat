set JAVA_HOME=C:\Program Files (x86)\Java\jdk1.8.0_101
set PATH=%JAVA_HOME%\bin;%PATH%
set JAVA_TOOL_OPTIONS=-Duser.language=en
cd C:\Users\jmpessoa\workspace\AppCompatNavigationDrawerDemo1
keytool -genkey -v -keystore AppCompatNavigationDrawerDemo1-release.keystore -alias appcompatnavigationdrawerdemo1aliaskey -keyalg RSA -keysize 2048 -validity 10000 < C:\Users\jmpessoa\workspace\AppCompatNavigationDrawerDemo1\keytool_input.txt
