---
layout: home
---

<h1 id="letter-index">English</h1>

{% assign groups = site.pie_lemmas | list_definitions | sort | group_by_initial %}

<div class="grid grid-cols-8">
{% for group in groups %}
<div><a href="#letter-{{ group[0] | downcase }}">{{ group[0] }}</a></div>
{% endfor %}
</div>

{% for group in groups %}
  <h2 id="letter-{{ group[0] | downcase }}" class="group">
    <a href="#letter-{{ group[0] | downcase }}" class="absolute opacity-0 group-hover:opacity-100" style="text-decoration: none;margin-left:-1em;padding-right:0.5em;box-shadow:none;color:#a1a1aa">#</a>
    <span>{{ group[0] }}</span>
    <a href="#letter-index" class="opacity-0 group-hover:opacity-100" style="text-decoration: none"><small>↑</small></a>
  </h2>
  <ul class="grid grid-cols-2 md:grid-cols-2">
  {% for definition in group[1] %}
    <li>{{definition}}</li>
  {% endfor %}
  </ul>
{% endfor %}

