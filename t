---properties

spring.application.name=library

spring.datasource.url=jdbc:h2:file:./data/studentDb spring.datasource.driver-class-name=org.h2.Driver

spring.datasource.username=sa

spring.jpa.database-platform=org.hibernate.dialect.H2Dialect

spring.h2.console.enabled=true

spring.jpa.hibernate.ddl-auto=update


------------------------------------------

package com.rvn14.flight.controller;

import com.rvn14.flight.model.Flight;
import com.rvn14.flight.model.Passenger;
import com.rvn14.flight.service.FlightService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/flight")
public class FlightController {

    @Autowired
    private FlightService flightService;

    @GetMapping
    public List<Flight> getAllFlight(){
        return flightService.getAllFlights();
    }

    @GetMapping("/{id}")
    public Flight getFlightById(@PathVariable int id){
        return flightService.getFlightById(id);
    }

    @PostMapping("/add")
    public void addFlight(@RequestBody Flight flight){
        flightService.addFlight(flight);
    }

    @DeleteMapping("{id}")
    public void deleteFight(@PathVariable int id){
        flightService.deleteFlight(id);
    }

    @PutMapping("/update")
    public void updateFlight(@RequestBody Flight flight){
        flightService.updateFLight(flight.getFlightId(), flight);
    }

    @GetMapping("/passengers/{id}")
    public List<Passenger> getPassengersByFlightId(@PathVariable int id){
        return flightService.getPassengersByFlightId(id);
    }

    @PutMapping("{flightId}/{passengerId}")
    public void addPassengerToFlight(@PathVariable int flightId, @PathVariable int passengerId){
        flightService.addPassengerToFLight(flightId, passengerId);
    }


}

-----------------------------------------------------

package com.rvn14.flight.service;

import com.rvn14.flight.model.Flight;
import com.rvn14.flight.model.FlightStatus;
import com.rvn14.flight.model.Passenger;
import com.rvn14.flight.repository.FlightRepository;
import com.rvn14.flight.repository.PassengerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FlightService {
    @Autowired
    private FlightRepository flightRepository;
    @Autowired
    private PassengerRepository passengerRepository;

    public List<Flight> getAllFlights() {
        return flightRepository.findAll();
    }

    public Flight getFlightById(int id){
        return flightRepository.findById(id).orElse(null);
    }

    public void addFlight(Flight flight){flightRepository.save(flight);}

    public void deleteFlight(int id){
        flightRepository.deleteById(id);
    }

    public void updateFLight(int id , Flight updatedFlight){
        flightRepository.save(updatedFlight);
    }

    public List<Passenger> getPassengersByFlightId(int id){
        Flight flight = flightRepository.findById(id).orElse(null);
        if (flight != null){
            return flight.getPassengers();
        }else {
            return null;
        }
    }

    public void addPassengerToFLight(int flightId, int passengerId){
        Flight flight = flightRepository.findById(flightId).orElse(null);
        if (flight != null) {
            // Assuming you have a method to find a passenger by ID
            Passenger passenger = passengerRepository.findById(passengerId).orElse(null);
            if (passenger != null) {
                flight.getPassengers().add(passenger);
                flightRepository.save(flight);
            }
        }
    }

    public void removePassengerFromFlight(int flightId, int passengerId){
        Flight flight = flightRepository.findById(flightId).orElse(null);
        if (flight != null){
            List<Passenger> passengers = flight.getPassengers();
            passengers.removeIf(passenger -> passenger.getPassengerId() == passengerId);
            flight.setPassengers(passengers);
            flightRepository.save(flight);
        }
    }

    public void updateFlightStatus(int flightId, FlightStatus status){
        Flight flight = flightRepository.findById(flightId).orElse(null);

        if (flight != null) {
            flight.setStatus(status);
            flightRepository.save(flight);
        }
    }

}

-------------------------------------------------------

package com.rvn14.flight.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.GeneratedColumn;

import java.time.LocalDateTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Flight {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int flightId;

    @NotNull
    private String flightNumber;

    @ManyToOne
    @JoinColumn(name = "originId", nullable = false)
    @JsonBackReference
    private Airport origin;

    @Enumerated(EnumType.STRING)
    private FlightStatus status;

    @ManyToOne
    @JoinColumn(name = "destinationId", nullable = false)
    @JsonBackReference
    private Airport destination;
    private LocalDateTime departureTime;
    private LocalDateTime arrivalTime;

    @OneToMany(mappedBy = "flight")
    @JsonManagedReference
    private List<Passenger> passengers;
}

----------------------------------------------------

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Long> {
    Optional<Customer> findByEmail(String email);
    List<Customer> findByFirstNameContainingIgnoreCaseOrLastNameContainingIgnoreCase(String firstName, String lastName);
    List<Customer> findByRegistrationDateBetween(LocalDate start, LocalDate end);

    // Custom JPQL query: Find customers registered after a certain date
    @Query("SELECT c FROM customers c WHERE c.registrationDate > :date")
    List<Customer> findCustomersRegisteredAfter(@Param("date") LocalDate date);

    List<Customer> findByAddress_CityIgnoreCase(String city);

    //Query to find Customers count by City
    @Query("SELECT a.city, COUNT(c) FROM customers c JOIN c.address a GROUP BY a.city")
    List<Object[]> CustomerCountPerCity();
}

---------------------------------------------
