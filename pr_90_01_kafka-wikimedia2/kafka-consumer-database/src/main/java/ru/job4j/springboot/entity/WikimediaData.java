package ru.job4j.springboot.entity;

import lombok.Data;
import javax.persistence.*;

@Entity
@Table(name = "wikimedia_recentchange")
@Data
public class WikimediaData {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    //@Lob
    @Column(name = "wiki_event_data")
    private String wikiEventData;
}
