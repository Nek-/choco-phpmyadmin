[![](https://ci.appveyor.com/api/projects/status/github/Nek-/chocolatey-packages?svg=true)](https://ci.appveyor.com/project/Nek-/chocolatey-packages)
[Update status](https://gist.github.com/Nek-/YOUR_GIST_ID_HERE)
[![](http://transparent-favicon.info/favicon.ico)](#)
[chocolatey/Nek](https://chocolatey.org/profiles/Nek)

# PhpMyAdmin package for Chocolatey


PHP Configuration
-----------------

You may get the following error while launching phpmyadmin:

```
Composer detected issues in your platform: Your Composer dependencies require the following PHP extensions to be installed: mysqli, openssl
```

Edit your php.ini and uncomment the 2 following lines:

```
extension=mysqli
extension=openssl
```


Running phpmyadmin
------------------

You can configure an apache or nginx server, but phpmyadmin can run only with PHP as well.

Run the following to start it:

```
phpmyadmin
```

Contribute to the package
-------------------------

### Setup locally

How to build & install locally :

```
choco pack .\phpmyadmin.nuspec
choco install phpmyadmin -d -v -s . (as Administrator)
choco uninstall phpmyadmin (as Administrator)
```
