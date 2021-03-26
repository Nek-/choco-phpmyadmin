# PhpMyAdmin Package for Chocolatey


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
