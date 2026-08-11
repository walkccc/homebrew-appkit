# homebrew-appkit

The Homebrew tap for [appkit](https://github.com/walkccc/appkit) — one installed
program that ships one product on iOS and Android.

```sh
brew tap walkccc/appkit
brew install --HEAD appkit
```

The code lives in [walkccc/appkit](https://github.com/walkccc/appkit); this repo
holds only the formula. It is a separate repo because Homebrew resolves the tap
name `walkccc/appkit` to `walkccc/homebrew-appkit` and nowhere else — a formula
kept beside the code can only be tapped by passing its URL.
