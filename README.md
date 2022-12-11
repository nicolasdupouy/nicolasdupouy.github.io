# How to
## Installation
### 1) Ruby with `rbenv`
#### [Debian]

    $ sudo apt-get install rbenv
    $ rbenv install 2.7.1
    $ rbenv global 2.7.1

Load rbenv automatically by appending the following to the shell configuration file (ex: ~/.profile):

    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"

#### [Apple M1 Macbook]
    $ brew install rbenv ruby-build
    $ rbenv install 3.0.0
    $ rbenv global 3.0.0
    $ rbenv rehash
    $ echo 'eval "$(rbenv init - zsh)"' >> ~/.profile

#### Nota Bene: General commands
- List installed Ruby versions: `rbenv versions`
- list latest stable versions: `rbenv install -l`
- Get a RubyGems Environment overview: `gem env`





### 2) Install the gems:
    $ gem install --user-install bundler jekyll
    $ echo 'export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"' >> ~/.profile

### 3) Initialize the project (in the project directory)
#### [Debian]
    $ bundle install

#### [Apple M1 Macbook]
For M1 Mac, we may need to do a few extra steps - update bundler, add webrick, and rebuild everything.

    $ bundle update --bundler
    $ bundle add webrick
    $ bundle install --redownload


## Serve the site locally
Build the site and make it available on a local server (http://localhost:4000):

    > JEKYLL_ENV=local bundle exec jekyll serve

Pass the `--port` option to specify another port

    > JEKYLL_ENV=local bundle exec jekyll serve --port 4002

Pass the `--livereload` option to automatically refresh the page with each change you make to the source files:

    > JEKYLL_ENV=local bundle exec jekyll serve --livereload

[Jekyll quickstart]: https://jekyllrb.com/docs/

## Language Highlighting

### Get the list

To find the available language highlighting, use the `rougify` command embedded with Jekyll:

    > rougify list

### Insert the code in the posts:

```
{% highlight cpp %}
#include <iostream>
using namespace std;

int main() 
{    
    cout << "Size of char: " << sizeof(char) << " byte" << endl;
    cout << "Size of int: " << sizeof(int) << " bytes" << endl;
    cout << "Size of float: " << sizeof(float) << " bytes" << endl;
    cout << "Size of double: " << sizeof(double) << " bytes" << endl;

    return 0;
}
{% endhighlight %}
```

### Expected result:

![C++ Program to Find Size of int, float, double and char in Your System](/assets/exemple-cpp-code-for-README.png)


## Difference between {%- do-someting -%} and {% do-someting %} ?
https://stackoverflow.com/questions/59487863/jeykyll-what-is-the-difference-between-do-someting-and-do-someting
https://shopify.github.io/liquid/basics/whitespace/


[What Are The Supported Language Highlighters In Jekyll]: https://simpleit.rocks/ruby/jekyll/what-are-the-supported-language-highlighters-in-jekyll/
