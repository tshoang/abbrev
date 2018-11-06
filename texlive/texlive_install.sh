#!/usr/bin/env sh

# Originally from https://github.com/latex3/latex3

# This script is used for testing using Travis
# It is intended to work on their VM set up: Ubuntu 12.04 LTS
# A minimal current TL is installed adding only the packages that are
# required

# See if there is a cached version of TL available
export PATH=/tmp/texlive/bin/x86_64-linux:$PATH
if ! command -v texlua > /dev/null; then
  # Obtain TeX Live
  wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
  tar -xzf install-tl-unx.tar.gz
  cd install-tl-20*

  # Find directory this file is in, to find the texlive.profile file.
  BASEDIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

  # Install a minimal system
  ./install-tl --profile="$BASEDIR"/texlive.profile

  cd ..
fi

# Just including texlua so the cache check above works
# Needed for any use of texlua even if not testing LuaTeX
tlmgr install luatex

# Needed for TeX Live 2017
tlmgr install xkeyval

# A kind of minimum set of packages needed
tlmgr install collection-latex

# Install babel languages
tlmgr install collection-langeuropean

# Common fonts with hard to debug errors if not found
tlmgr install collection-fontsrecommended

# An index of packages: http://ctan.mirrors.hoobly.com/systems/texlive/tlnet/archive/
# Or better, check https://www.ctan.org/pkg/some-package to see in which TeX Live package it is contained

# Other contrib packages: done as a block to avoid multiple calls to tlmgr
# One package per line in texive_packages
# We need to change the working directory before including a file
cd "$(dirname "${BASH_SOURCE[0]}")"
tlmgr install $(cat texlive_packages)

# Keep no backups (not required, simply makes cache bigger)
tlmgr option -- autobackup 0

# Update the TL install but add nothing new
tlmgr update --self --all --no-auto-install