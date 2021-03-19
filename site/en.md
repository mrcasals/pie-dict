---
layout: home
---

<h1 id="letter-index">English</h1>

{% assign definition_groups = site.pie_lemmas | list_definitions %}

<div class="grid grid-cols-2">
{% for definition in definition_groups %}
<div>{{definition}}</div>
{% endfor %}
</div>

