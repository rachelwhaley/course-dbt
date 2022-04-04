{% macro tally_column_values(table, column) %}
    {% set query_sql %}
    select distinct {{column}} from {{table}}
    {% endset %}

    {% if execute %}
        {% set column_values =  run_query(query_sql).columns[0].values()%}

        {% for column_value in column_values %}
            sum(case when {{column}} = '{{column_value}}' then 1 else 0 end) > 0 as count_{{column_value}}
            {% if not loop.last %},{% endif %}
        {% endfor %}
    {% else %}

    {% endif %}


{% endmacro %}