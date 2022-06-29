DROP TABLE IF EXISTS wikimedia_recentchange CASCADE;

create table wikimedia_recentchange (
    id bigserial,
    wiki_event_data Text,
    CONSTRAINT wikimedia_recentchange_pk PRIMARY KEY (id)
);
