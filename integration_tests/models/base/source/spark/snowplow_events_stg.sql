{#
Copyright (c) 2021-present Snowplow Analytics Ltd. All rights reserved.
This program is licensed to you under the Snowplow Personal and Academic License Version 1.0,
and you may not use this file except in compliance with the Snowplow Personal and Academic License Version 1.0.
You may obtain a copy of the Snowplow Personal and Academic License Version 1.0 at https://docs.snowplow.io/personal-and-academic-license-1.0/
#}
{{
    config(
        tags=['base_macro']
    )
}}

-- page view context is given as json string in csv. Parse json
with prep as (
        select
        app_id,
        platform,
        etl_tstamp,
        collector_tstamp,
        dvce_created_tstamp,
        event,
        event_id,
        txn_id,
        name_tracker,
        v_tracker,
        v_collector,
        v_etl,
        user_id,
        user_ipaddress,
        user_fingerprint,
        domain_userid,
        domain_sessionidx,
        network_userid,
        geo_country,
        geo_region,
        geo_city,
        geo_zipcode,
        geo_latitude,
        geo_longitude,
        geo_region_name,
        ip_isp,
        ip_organization,
        ip_domain,
        ip_netspeed,
        page_url,
        page_title,
        page_referrer,
        page_urlscheme,
        page_urlhost,
        page_urlport,
        page_urlpath,
        page_urlquery,
        page_urlfragment,
        refr_urlscheme,
        refr_urlhost,
        refr_urlport,
        refr_urlpath,
        refr_urlquery,
        refr_urlfragment,
        refr_medium,
        refr_source,
        refr_term,
        mkt_medium,
        mkt_source,
        mkt_term,
        mkt_content,
        mkt_campaign,
        se_category,
        se_action,
        se_label,
        se_property,
        se_value,
        tr_orderid,
        tr_affiliation,
        tr_total,
        tr_tax,
        tr_shipping,
        tr_city,
        tr_state,
        tr_country,
        ti_orderid,
        ti_sku,
        ti_name,
        ti_category,
        ti_price,
        ti_quantity,
        pp_xoffset_min,
        pp_xoffset_max,
        pp_yoffset_min,
        pp_yoffset_max,
        useragent,
        br_name,
        br_family,
        br_version,
        br_type,
        br_renderengine,
        br_lang,
        br_features_pdf,
        br_features_flash,
        br_features_java,
        br_features_director,
        br_features_quicktime,
        br_features_realplayer,
        br_features_windowsmedia,
        br_features_gears,
        br_features_silverlight,
        br_cookies,
        br_colordepth,
        br_viewwidth,
        br_viewheight,
        os_name,
        os_family,
        os_manufacturer,
        os_timezone,
        dvce_type,
        dvce_ismobile,
        dvce_screenwidth,
        dvce_screenheight,
        doc_charset,
        doc_width,
        doc_height,
        tr_currency,
        tr_total_base,
        tr_tax_base,
        tr_shipping_base,
        ti_currency,
        ti_price_base,
        base_currency,
        geo_timezone,
        mkt_clickid,
        mkt_network,
        etl_tags,
        dvce_sent_tstamp,
        refr_domain_userid,
        refr_dvce_tstamp,
        domain_sessionid,
        derived_tstamp,
        event_vendor,
        event_name,
        event_format,
        event_version,
        event_fingerprint,
        true_tstamp,
        load_tstamp,
        from_json(contexts_com_snowplowanalytics_snowplow_web_page_1_0_0, 'array<struct<id:string>>') as contexts_com_snowplowanalytics_snowplow_web_page_1,
        from_json(unstruct_event_com_snowplowanalytics_snowplow_consent_preferences_1_0_0, 'array<struct<basis_for_processing:string, consent_scopes:array<string>, consent_url:string, consent_version:string, domains_applied:array<string>, event_type:string, gdpr_applies:string>>') as unstruct_event_com_snowplowanalytics_snowplow_consent_preferences_1,
        from_json(unstruct_event_com_snowplowanalytics_snowplow_cmp_visible_1_0_0, 'array<struct<elapsed_time:string>>') as unstruct_event_com_snowplowanalytics_snowplow_cmp_visible_1,
        from_json(contexts_com_iab_snowplow_spiders_and_robots_1_0_0, 'array<struct<category:string,primaryImpact:string,reason:string,spiderOrRobot:boolean>>') as contexts_com_iab_snowplow_spiders_and_robots_1,
        from_json(contexts_nl_basjes_yauaa_context_1_0_0, 'array<struct<agentClass:string,agentInformationEmail:string,agentName:string,agentNameVersion:string,agentNameVersionMajor:string,agentVersion:string,agentVersionMajor:string,deviceBrand:string,deviceClass:string,deviceCpu:string,deviceCpuBits:string,deviceName:string,deviceVersion:string,layoutEngineClass:string,layoutEngineName:string,layoutEngineNameVersion:string,layoutEngineNameVersionMajor:string,layoutEngineVersion:string,layoutEngineVersionMajor:string,networkType:string,operatingSystemClass:string,operatingSystemName:string,operatingSystemNameVersion:string,operatingSystemNameVersionMajor:string,operatingSystemVersion:string,operatingSystemVersionBuild:string,operatingSystemVersionMajor:string,webviewAppName:string,webviewAppNameVersionMajor:string,webviewAppVersion:string,webviewAppVersionMajor:string>>') as contexts_nl_basjes_yauaa_context_1,
        from_json(contexts_com_snowplowanalytics_user_identifier_1_0_0, 'array<struct<user_id:string>>') as contexts_com_snowplowanalytics_user_identifier_1,
        from_json(contexts_com_snowplowanalytics_user_identifier_2_0_0, 'array<struct<user_id:string>>') as contexts_com_snowplowanalytics_user_identifier_2,
        from_json(contexts_com_snowplowanalytics_session_identifier_1_0_0, 'array<struct<session_id:string>>') as contexts_com_snowplowanalytics_session_identifier_1,
        from_json(contexts_com_snowplowanalytics_session_identifier_2_0_0, 'array<struct<session_identifier:string>>') as contexts_com_snowplowanalytics_session_identifier_2,
        from_json(contexts_com_snowplowanalytics_custom_entity_1_0_0, 'array<struct<contents:string>>') as contexts_com_snowplowanalytics_custom_entity_1
    from
        {{ ref('snowplow_events') }}
)

select
    app_id,
    platform,
    etl_tstamp,
    collector_tstamp,
    dvce_created_tstamp,
    event,
    event_id,
    txn_id,
    name_tracker,
    v_tracker,
    v_collector,
    v_etl,
    user_id,
    user_ipaddress,
    user_fingerprint,
    domain_userid,
    domain_sessionidx,
    network_userid,
    geo_country,
    geo_region,
    geo_city,
    geo_zipcode,
    geo_latitude,
    geo_longitude,
    geo_region_name,
    ip_isp,
    ip_organization,
    ip_domain,
    ip_netspeed,
    page_url,
    page_title,
    page_referrer,
    page_urlscheme,
    page_urlhost,
    page_urlport,
    page_urlpath,
    page_urlquery,
    page_urlfragment,
    refr_urlscheme,
    refr_urlhost,
    refr_urlport,
    refr_urlpath,
    refr_urlquery,
    refr_urlfragment,
    refr_medium,
    refr_source,
    refr_term,
    mkt_medium,
    mkt_source,
    mkt_term,
    mkt_content,
    mkt_campaign,
    se_category,
    se_action,
    se_label,
    se_property,
    se_value,
    tr_orderid,
    tr_affiliation,
    tr_total,
    tr_tax,
    tr_shipping,
    tr_city,
    tr_state,
    tr_country,
    ti_orderid,
    ti_sku,
    ti_name,
    ti_category,
    ti_price,
    ti_quantity,
    pp_xoffset_min,
    pp_xoffset_max,
    pp_yoffset_min,
    pp_yoffset_max,
    useragent,
    br_name,
    br_family,
    br_version,
    br_type,
    br_renderengine,
    br_lang,
    br_features_pdf,
    br_features_flash,
    br_features_java,
    br_features_director,
    br_features_quicktime,
    br_features_realplayer,
    br_features_windowsmedia,
    br_features_gears,
    br_features_silverlight,
    br_cookies,
    br_colordepth,
    br_viewwidth,
    br_viewheight,
    os_name,
    os_family,
    os_manufacturer,
    os_timezone,
    dvce_type,
    dvce_ismobile,
    dvce_screenwidth,
    dvce_screenheight,
    doc_charset,
    doc_width,
    doc_height,
    tr_currency,
    tr_total_base,
    tr_tax_base,
    tr_shipping_base,
    ti_currency,
    ti_price_base,
    base_currency,
    geo_timezone,
    mkt_clickid,
    mkt_network,
    etl_tags,
    dvce_sent_tstamp,
    refr_domain_userid,
    refr_dvce_tstamp,
    domain_sessionid,
    derived_tstamp,
    event_vendor,
    event_name,
    event_format,
    event_version,
    event_fingerprint,
    true_tstamp,
    load_tstamp,
    contexts_com_snowplowanalytics_snowplow_web_page_1,
    struct(
        unstruct_event_com_snowplowanalytics_snowplow_consent_preferences_1[0].basis_for_processing AS basis_for_processing,
        unstruct_event_com_snowplowanalytics_snowplow_consent_preferences_1[0].consent_scopes AS consent_scopes,
        unstruct_event_com_snowplowanalytics_snowplow_consent_preferences_1[0].consent_url AS consent_url,
        unstruct_event_com_snowplowanalytics_snowplow_consent_preferences_1[0].consent_version AS consent_version,
        unstruct_event_com_snowplowanalytics_snowplow_consent_preferences_1[0].domains_applied AS domains_applied,
        unstruct_event_com_snowplowanalytics_snowplow_consent_preferences_1[0].event_type AS event_type,
        CAST(unstruct_event_com_snowplowanalytics_snowplow_consent_preferences_1[0].gdpr_applies AS BOOLEAN) AS gdpr_applies
    ) AS unstruct_event_com_snowplowanalytics_snowplow_consent_preferences_1,
    struct(CAST(unstruct_event_com_snowplowanalytics_snowplow_cmp_visible_1[0].elapsed_time AS FLOAT) as elapsed_time) as unstruct_event_com_snowplowanalytics_snowplow_cmp_visible_1,
    array(struct(contexts_com_iab_snowplow_spiders_and_robots_1[0].category as category,
        contexts_com_iab_snowplow_spiders_and_robots_1[0].primaryImpact as primary_impact,
        contexts_com_iab_snowplow_spiders_and_robots_1[0].reason as reason,
        contexts_com_iab_snowplow_spiders_and_robots_1[0].spiderOrRobot as spider_or_robot)) as contexts_com_iab_snowplow_spiders_and_robots_1,
     array(struct(contexts_nl_basjes_yauaa_context_1[0].agentClass as agent_class,
        contexts_nl_basjes_yauaa_context_1[0].agentInformationEmail as agent_information_email,
        contexts_nl_basjes_yauaa_context_1[0].agentName as agent_name,
        contexts_nl_basjes_yauaa_context_1[0].agentNameVersion as agent_name_version,
        contexts_nl_basjes_yauaa_context_1[0].agentNameVersionMajor as agent_name_version_major,
        contexts_nl_basjes_yauaa_context_1[0].agentVersion as agent_version,
        contexts_nl_basjes_yauaa_context_1[0].agentVersionMajor as agent_version_major,
        contexts_nl_basjes_yauaa_context_1[0].deviceBrand as device_brand,
        contexts_nl_basjes_yauaa_context_1[0].deviceClass as device_class,
        contexts_nl_basjes_yauaa_context_1[0].deviceCpu as device_cpu,
        contexts_nl_basjes_yauaa_context_1[0].deviceCpuBits as device_cpu_bits,
        contexts_nl_basjes_yauaa_context_1[0].deviceName as device_name,
        contexts_nl_basjes_yauaa_context_1[0].deviceVersion as device_version,
        contexts_nl_basjes_yauaa_context_1[0].layoutEngineClass as layout_engine_class,
        contexts_nl_basjes_yauaa_context_1[0].layoutEngineName as layout_engine_name,
        contexts_nl_basjes_yauaa_context_1[0].layoutEngineNameVersion as layout_engine_name_version,
        contexts_nl_basjes_yauaa_context_1[0].layoutEngineNameVersionMajor as layout_engine_name_version_major,
        contexts_nl_basjes_yauaa_context_1[0].layoutEngineVersion as layout_engine_version,
        contexts_nl_basjes_yauaa_context_1[0].layoutEngineVersionMajor as layout_engine_version_major,
        contexts_nl_basjes_yauaa_context_1[0].networkType as network_type,
        contexts_nl_basjes_yauaa_context_1[0].operatingSystemClass as operating_system_class,
        contexts_nl_basjes_yauaa_context_1[0].operatingSystemName as operating_system_name,
        contexts_nl_basjes_yauaa_context_1[0].operatingSystemNameVersion as operating_system_name_version,
        contexts_nl_basjes_yauaa_context_1[0].operatingSystemNameVersionMajor as operating_system_name_version_major,
        contexts_nl_basjes_yauaa_context_1[0].operatingSystemVersion as operating_system_version,
        contexts_nl_basjes_yauaa_context_1[0].operatingSystemVersionBuild as operating_system_version_build,
        contexts_nl_basjes_yauaa_context_1[0].operatingSystemVersionMajor as operating_system_version_major,
        contexts_nl_basjes_yauaa_context_1[0].webviewAppName as webview_app_name,
        contexts_nl_basjes_yauaa_context_1[0].webviewAppNameVersionMajor as webview_app_name_version_major,
        contexts_nl_basjes_yauaa_context_1[0].webviewAppVersion as webview_app_version,
        contexts_nl_basjes_yauaa_context_1[0].webviewAppVersionMajor as webview_app_version_major)) as contexts_nl_basjes_yauaa_context_1,
    array(struct(contexts_com_snowplowanalytics_user_identifier_1[0].user_id as user_id)) as contexts_com_snowplowanalytics_user_identifier_1,
    array(struct(contexts_com_snowplowanalytics_user_identifier_2[0].user_id as user_id)) as contexts_com_snowplowanalytics_user_identifier_2,
    array(struct(contexts_com_snowplowanalytics_session_identifier_1[0].session_id as session_id)) as contexts_com_snowplowanalytics_session_identifier_1,
    array(struct(contexts_com_snowplowanalytics_session_identifier_2[0].session_identifier as session_identifier)) as contexts_com_snowplowanalytics_session_identifier_2,

    {% if var("snowplow__custom_test", false) %}
        array(struct(contexts_com_snowplowanalytics_custom_entity_1[0].contents as contents)) AS contexts_com_snowplowanalytics_custom_entity_1
    {% else %}
        cast(null as array<struct<contents:string>>) as contexts_com_snowplowanalytics_custom_entity_1
    {% endif %}
from
    prep