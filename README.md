# David’s dotfiles

Just my personal dotfiles. Nothing special, but feel free to use if you want. The only significant difference from the dotfiles listed below is in
* the utilites/programs installed
* the security.sh script, which attempts to improve the default security settings. Inspired by [Dr. Duh's security guide](https://github.com/drduh/OS-X-Security-and-Privacy-Guide).

## How to use

Run the following command to install everything:

```bash
git clone https://github.com/davidprichard/dotfiles.git && cd dotfiles && source setup.sh
```

Several scripts can be run on their own:

`install.sh` loads the programs, utilities, programming languages, etc. that I find useful.
```curl https://raw.githubusercontent.com/davidprichard/dotfiles/install.sh && source install.sh```

`security.sh` changes system (and some application) settings to try to improve security and privacy.
```curl https://raw.githubusercontent.com/davidprichard/dotfiles/security.sh && source security.sh```

`preferences.sh` changes system settings to my personal preferences. (this is called .macos/.osx in other dotfiles).
```curl https://raw.githubusercontent.com/davidprichard/dotfiles/preferences.sh && source preferences.sh```

## Other resources, references, thanks

My dotfiles is forked from [Mathis Bynens'](https://mathiasbynens.be/) macOS [dotfiles](https://github.com/mathiasbynens/dotfiles), incorporating bits and bobs from
* Paul Miller's [dotfiles](https://github.com/paulmillr/dotfiles)
* Paul Irish's [dotfiles](https://github.com/paulirish/dotfiles)
* Ben Alman's [dotfiles](https://github.com/cowboy/dotfiles)
* Kevin Suttle's [OS X default values command reference](https://github.com/kevinSuttle/OSXDefaults/blob/master/REFERENCE.md)
* Haralan Dobrev's [dotfiles](https://github.com/hkdobrev/dotfiles/)
* Matijs Brinkhuis' [dotfiles](https://github.com/matijs/dotfiles)
