# David’s dotfiles

Just my personal dotfiles for macOS.

## How to use

Run the following command to install everything:

```bash
git clone https://github.com/davidprichard/dotfiles.git && cd dotfiles && source setup.sh
```

Several scripts can be run on their own:

`install.sh` loads the programs, utilities, programming languages, etc. that I find useful.

```bash
curl https://raw.githubusercontent.com/davidprichard/dotfiles/install.sh && source install.sh
```

`security.sh` changes system (and some application) settings to try to improve security and privacy.
```bash
curl https://raw.githubusercontent.com/davidprichard/dotfiles/security.sh && source security.sh
```

`preferences.sh` changes system settings to my personal preferences. (this is called .macos/.osx in other dotfiles).
```bash
curl https://raw.githubusercontent.com/davidprichard/dotfiles/preferences.sh && source preferences.sh
```

## Limitations

* Not all useful system settings can be altered by script, so it is very much worth it to go through every section of System Preferences to change everything to how you like it.
* The biggest security wins would probably be installing privacy- and security-minded add-ons to the browsers; unfortunately, this can't be done by script. I strongly recommend installing the EFF's [HTTPS Everywhere](https://www.eff.org/https-everywhere) extension on Chrome and Firefox, and further installing [NoScript](https://noscript.net/) on Firefox for general browsing.


## Other resources, references, thanks

My dotfiles is forked from [Mathias Bynens'](https://mathiasbynens.be/) macOS [dotfiles](https://github.com/mathiasbynens/dotfiles), incorporating bits and bobs from
* Paul Miller's [dotfiles](https://github.com/paulmillr/dotfiles)
* Paul Irish's [dotfiles](https://github.com/paulirish/dotfiles)
* Ben Alman's [dotfiles](https://github.com/cowboy/dotfiles)
* Kevin Suttle's [OS X default values command reference](https://github.com/kevinSuttle/OSXDefaults/blob/master/REFERENCE.md)
* Haralan Dobrev's [dotfiles](https://github.com/hkdobrev/dotfiles/)
* Matijs Brinkhuis' [dotfiles](https://github.com/matijs/dotfiles)
* Dr. Duh's [security guide](https://github.com/drduh/OS-X-Security-and-Privacy-Guide)
