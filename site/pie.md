---
layout: home
---

<h1>PIE lemmas</h1>

{% assign groups = site.pie_lemmas | group_by_initial %}

<div class="grid grid-cols-8">
{% for group in groups %}
<div><a href="#letter-{{ group[0] | downcase }}">{{ group[0] }}</a></div>
{% endfor %}
</div>

{% for group in groups %}
  <h2 id="letter-{{ group[0] | downcase }}">{{ group[0] }}</h2>
  <ul class="grid grid-cols-4">
  {% for lemma in group[1] %}
    <li><a href="{{ lemma.url }}">{{ lemma.title }}</a></li>
  {% endfor %}
  </ul>
{% endfor %}
