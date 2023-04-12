---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
---
test
{% assign items = site.languages %}
{% for item in items %}
[{{ item.title }}]({{ item.url }})
{% endfor %}