---
layout: home
---

<h1>PIE index</h1>

{% assign groups = site.pie_lemmas | group_by_initial %}
{% for group in groups %}
  <h2>{{ group[0] }}</h2>
  <ul>
  {% for lemma in group[1] %}
    <li><a href="{{lemma.url}}">{{lemma.slug}}</a></li>
  {% endfor %}
  </ul>
{% endfor %}
