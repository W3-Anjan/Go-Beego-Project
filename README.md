# beego-assignment-prodipto
> Beego assignment Prodipto

## Used tools
- Beego
- Golang
- HTML, CSS, jQuery and JavaScript

## Installation process of necessary tools:
### Go installation process:
- Go to this website and follow the instructions according to your OS: https://go.dev/doc/install

### Beego installation:
- Edit the .profile file by running the following command:

```bash
- sudo nano ~/.profile
```

- Add the following paths at the end of .profile file.

```bash
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/diptoprodipto/go/bin

export GOPATH="/home/diptoprodipto/go/"
export GOBIN="/home/diptoprodipto/go/bin"
```

- Run the following commands on your terminal:

``` bash
- go get -u github.com/beego/beego/v2
- go get -u github.com/beego/bee/v2
```

- Reboot your machine.
- Resource: https://enlear.academy/how-to-install-beego-in-ubuntu-500136665843

### For running the project:
- Go to the project directory and run the following command:

``` bash
- bee run
```
- In case of "missing go.sum entry" error run:

```bash
- go mod tidy
- More on this error: https://stackoverflow.com/questions/67203641/missing-go-sum-entry-for-module-providing-package-package-name
```

- Hit this URL in your browser: http://localhost:8080/front

## Project overview
- Select your preferred option and cat images will be shown.

![Screenshot from 2022-01-28 18-43-14](https://user-images.githubusercontent.com/56860950/151549175-5fa4ff99-4dd8-4339-8ccf-b768da25b0d3.png)

- You can sort the images in ascending/descending order and access them all in pagination mode.

![Screenshot from 2022-01-28 18-50-35](https://user-images.githubusercontent.com/56860950/151550027-defa95da-2479-4269-9509-d43d3cb23a91.png)
