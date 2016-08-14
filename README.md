# GAE/Go Boilerplate

Using to GAE/Go easy!

## Getting Started

### Install Golang

```
$ brew install go
```

### Install App Engine Go SDK

#### For amd64

```
$ brew install app-engine-go-64
```

#### For i386

```
$ brew install app-engine-go-32
```

### Checkout GAE/Go Boilerplate

```
$ ghq get osamingo/gae-bp
```

### Init install

```
# Change directory to osamingo/gae-bp
$ make init-install
```

## Constitution

```
./
├── src     # Original source codes
├── static  # Static files
└── vendor
    └── src # Vendoring packages
```

## Control commands

see [Makefile](https://github.com/osamingo/gae-bp/blob/master/Makefile).

## Lisence

Released under the [MIT License](https://github.com/osamingo/gae-bp/blob/master/LICENSE).
