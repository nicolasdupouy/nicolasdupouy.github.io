# How to
## Installation
> install `rbenv` on Debian

    sudo apt-get install rbenv
    rbenv install 2.7.1
    rbenv global 2.7.1

> install necessary gems

    rbenv shell 2.7.1
    bundle install

## Serve the site locally
Build the site and make it available on a local server (http://localhost:4000):

    bundle exec jekyll serve

Pass the `--port` option to specify another port

    bundle exec jekyll serve --port 4002

Pass the `--livereload` option to automatically refresh the page with each change you make to the source files:

    bundle exec jekyll serve --livereload

[Jekyll quickstart]: https://jekyllrb.com/docs/
