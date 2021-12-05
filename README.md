![mary-poppins](https://user-images.githubusercontent.com/584077/144762520-4c38268f-6cb9-436e-9437-ea281e6ac5fa.png)

Mary Poppins is a general-purpose package manager and dependency manager.  It comes installed by default with [Jazz](https://github.com/jazzdotdev/torchbear), using [mp-installer](https://github.com/jazzdotdev/mp-installer).

## Usage
```bash
$ mp
usage: mp unpack
usage: mp upgrade
usage: mp refresh
usage: mp install <package-name>
usage: mp search <package-name>
usage: mp uninstall <package-name>
usage: mp [help]
```

To install an app first you will have to refresh/download the 
repository. Use `mp refresh` to refresh it.

To install:
```bash
$ mp install <app-name>
```
To uninstall:
```bash
$ mp uninstall <app-name>
```

To download the dependencies of any manually cloned torchbear app:
```bash
$ mp unpack
```

To update the dependencies:
```bash
$ mp upgrade .
```
or
```bash
$ mp upgrade <package-name>
```

## Creating app store
To install apps `mp` looks into a scl file which has the
available apps, the default one is [FPS app-store](https://github.com/foundpatterns/app-store).

To create your own, you will have to create a repository with 
`packages.scl` file and edit the url in 
[config.lua](https://github.com/foundpatterns/machu-picchu/blob/master/configs/config.lua#L14)

Then, `mp refresh` and your new repository is ready.
