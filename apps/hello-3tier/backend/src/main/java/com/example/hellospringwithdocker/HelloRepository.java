package com.example.hellospringwithdocker;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface HelloRepository extends JpaRepository<Greeting, Long> {

    Greeting getByLangCode(String lang);
}
