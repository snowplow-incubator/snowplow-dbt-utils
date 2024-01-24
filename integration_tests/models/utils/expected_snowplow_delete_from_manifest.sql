{#
Copyright (c) 2021-present Snowplow Analytics Ltd. All rights reserved.
This program is licensed to you under the Snowplow Personal and Academic License Version 1.0,
and you may not use this file except in compliance with the Snowplow Personal and Academic License Version 1.0.
You may obtain a copy of the Snowplow Personal and Academic License Version 1.0 at https://docs.snowplow.io/personal-and-academic-license-1.0/
#}
{{ config(tags=["requires_script"]) }}

select *

from {{ ref('data_snowplow_delete_from_manifest') }}
where model not in ({% for model in var("models_to_delete",[]) %} '{{ model }}' {% if not loop.last %}, {% endif %} {% endfor %})
