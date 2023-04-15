---
layout: default
---
# Web

{% for colec in site.collections %}
{% if colec.label == page.collection %}
{% for item in colec.docs %}
{% if item.url contains 'index.html' %}
{% else %}
[{{item.title}}]({{ item.url }})
{% endif %}
{% endfor %}
{% endif%}
{% endfor %}
