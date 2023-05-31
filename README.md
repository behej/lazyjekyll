# Theme specific configuration

Simplistic jekyll portfolio-style theme for writers.

# Prerequisites
To run this project and generate HTML pages, you will need jekyll installed and therefore ruby
```sh
sudo apt install ruby-full build-essential zlib1g-dev
gem install bundler jekyll jekyll-feed
```

## Installation on Github Pages

Add this line to your site's `_config.yml`:

```yaml
remote_theme: samarsault/plainwhite-jekyll
```

## Installation

Add this line to your Jekyll site's `Gemfile`:

```ruby
gem "plainwhite"
```

And add this line to your Jekyll site's `_config.yml`:

```yaml
theme: plainwhite
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install plainwhite

## Usage

There are several keys available in \_config.yml that can be used to customize the theme data.

```yaml
name: My site name
tagline: Site tag line
date_format: "%b %-d, %Y"

social_links:
  twitter: twitter id
  github: github id
  linkedIn: in/linkedin_id
```

**Updating Placeholder Image**

The placeholder portfolio image can be replaced by the desired image by placing it as `assets/portfolio.png` in your jekyll website, or by changing the following line in `_config.yaml`

```yaml
portfolio_image:  "assets/portfolio.png" # the path from the base directory of the site to the image to display (no / at the start)
```

To use a different image for dark mode, e.g. with different colors that work better in dark mode, add a `portfolio_image_dark` entry in addition to the `portfolio_image`.

```yaml
portfolio_image:      "assets/portfolio.png"
portfolio_image_dark: "assets/portfolio_dark.png"
```

**Google Analytics**

It can be enabled by specifying your analytics id in `_config.yml`

```yaml
analytics_id: "< YOUR ID >"
```

**Excerpts**

Excerpts can be enabled by adding the following line to your `_config.yml`

```yaml
show_excerpts: true
```

**Layouts**

- Home
- Page
- Post

**Dark mode**

Dark mode can be enabled by setting the `dark_mode` flag in your `_config.yml`

The website will check the OS preferred color scheme and set the theme accordingly, the preference will then be saved in a cookie

```yaml
dark_mode: true
```

**Multiline tagline**

Tagline can be multiline in this way

```yaml
tagline: |
First Line. 

Second Line. 

Third Line.
```

**Search-bar**

Search-bar can be enabled by adding the following line to `config.yml`

```yaml
search: true
```

Search is powered by [Simple-Jekyll-Search](https://github.com/christian-fei/Simple-Jekyll-Search) Jekyll plugin. A `search.json` containing post meta and contents will be generated in site root folder. Plugin JavaScript will then match for posts based on user input. More info and `search.json` customization documentation can be found in plugin repository.

**Base URL**

You can specify a custom base URL (eg. example.com/blog/) by adding the following line to `_config.yaml`. Note that there is no trailing slash on the URL.

```yaml
baseurl: "/blog"
```

**Language**

You can set the `lang` attribute of the `<html>` tag on your pages by changing the following line in `_config.yml`:

```yaml
html_lang: "en"
```
> Defaults to English if not specified.

[See here for a full list of available language codes](https://www.w3schools.com/tags/ref_country_codes.asp)

## Development

To set up your environment to develop this theme, run `bundle install`.

Your theme is setup just like a normal Jekyll site! To test your theme, run `bundle exec jekyll serve -l` and open your browser at `http://localhost:4000`. This starts a Jekyll server using your theme. Add pages, documents, data, etc. like normal to test your theme's contents. As you make modifications to your theme and to your content, your site will regenerate and you should see the changes in the browser after a refresh, just like normal.

When your theme is released, only the files in `_layouts`, `_includes`, `_sass` and `assets` tracked with Git will be bundled.
To add a custom directory to your theme-gem, please edit the regexp in `plainwhite.gemspec` accordingly.

## Donation
If this project help you reduce time to develop, you can give a cup of coffee to the original author :) 

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://paypal.me/thelehhman)

## License

This theme is hugely derived from original theme **plainwhite** which is available under the terms of the [MIT License](https://opensource.org/licenses/MIT).
So it goes for this theme too.