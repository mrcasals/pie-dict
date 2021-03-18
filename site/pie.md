---
layout: home
---

<h1>PIE index</h1>

{% assign groups = site.pie_lemmas | group_by_initial %}
{% for group in groups %}
  <h2>{{ group[0] }}</h2>
  <ul>
  <ul class="grid grid-cols-4">
  {% for lemma in group[1] %}
    <li><a href="{{lemma.url}}">{{lemma.title}}</a></li>
  {% endfor %}
  </ul>
{% endfor %}
