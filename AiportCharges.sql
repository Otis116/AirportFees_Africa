--SELECT *
--FROM AirportCharges..LandingFees
--Order By 2

--SELECT *
--FROM AirportCharges..PassengerTaxes
--Order By 2


--Here we explore the passenger service tax across the main airports in Africa

--Average Departure Tax

SELECT AVG(Departure) AS AverageDepartureTaxes
FROM AirportCharges..PassengerTaxes


--Airports where the departure passenger tax is US$100 and above

SELECT Airport, City, MAX(Departure) AS HighestDepartureTax 
FROM AirportCharges..LandingFees AS LAF
 JOIN AirportCharges..PassengerTaxes AS PAT
  ON LAF.AirportCode = PAT.[AirportCode]
WHERE Departure >= 100
GROUP BY City, Airport
ORDER BY HighestDepartureTax DESC


--Airports where passenger tax is charged on Departure, Transfer and Arrival

SELECT Airport, City, Departure, Transfer, Arrival
FROM AirportCharges..LandingFees AS LAF
 JOIN AirportCharges..PassengerTaxes AS PAT
  ON LAF.AirportCode = PAT.[AirportCode]
WHERE (Departure > 0 AND Transfer > 0 AND Arrival > 0)
ORDER BY 3 DESC


--Airports where the departure passenger tax is US$30 and less

SELECT Airport, City, MIN(Departure) AS LowestDepartureTax
FROM AirportCharges..LandingFees AS LAF
 JOIN AirportCharges..PassengerTaxes AS PAT
  ON LAF.AirportCode = PAT.[AirportCode]
WHERE Departure <= 30
GROUP BY City, Airport
ORDER BY LowestDepartureTax



--Let's look at the landing fee charges across the continent

--Average Day Landing Fees and Parking in Africa

SELECT AVG(DayLanding) AS AverageLandingFees
FROM AirportCharges..LandingFees AS LAF
 JOIN AirportCharges..PassengerTaxes AS PAT
  ON LAF.AirportCode = PAT.[AirportCode] 


--Airports that charge above the contient's average landing fees of US$560

SELECT Airport, City, MAX(DayLanding) AS HighestDayLandingFees, NightLanding, NightTakeOff
FROM AirportCharges..LandingFees AS LAF
 JOIN AirportCharges..PassengerTaxes AS PAT
  ON LAF.AirportCode = PAT.[AirportCode]
WHERE DayLanding >= 560
GROUP BY City, Airport, NightTakeOff, NightLanding
ORDER BY HighestDayLandingFees DESC


--Airports with the Lowest Day Landing fees of US$300 and less (Top 10)

SELECT Airport, City, MIN(DayLanding) AS LowestDayLandingFees, NightLanding, NightTakeOff
FROM AirportCharges..LandingFees AS LAF
 JOIN AirportCharges..PassengerTaxes AS PAT
  ON LAF.AirportCode = PAT.[AirportCode]
WHERE DayLanding <= 500
GROUP BY City, Airport, NightLanding, NightTakeOff
ORDER BY LowestDayLandingFees


--Airports Parking fees from the highest

SELECT Airport, City, MAX(Parking) AS HighestParkingFees
FROM AirportCharges..LandingFees AS LAF
 JOIN AirportCharges..PassengerTaxes AS PAT
  ON LAF.AirportCode = PAT.[AirportCode]
GROUP BY City, Airport
ORDER BY HighestParkingFees DESC


--Airports Boarding Bridges where data is provided

SELECT Airport, City, BoardingBridge
FROM AirportCharges..LandingFees AS LAF
 JOIN AirportCharges..PassengerTaxes AS PAT
  ON LAF.AirportCode = PAT.[AirportCode]
WHERE BoardingBridge IS NOT NULL
ORDER BY 3 DESC



SELECT Airport, City, LAF.Country, DayLanding, NightLanding, NightTakeOff, Parking, Departure AS DepartureTax, Transfer AS TransferTax, Arrival AS ArrivalTax
FROM AirportCharges..LandingFees AS LAF
 JOIN AirportCharges..PassengerTaxes AS PAT
  ON LAF.AirportCode = PAT.[AirportCode]
--WHERE DayLanding >= 560
ORDER BY 1,2



With LandingFees (Airport, City,Landing, Departure)
As
(
SELECT Airport, City, MAX(DayLanding) AS HighestDayLandingFees,Departure
FROM AirportCharges..LandingFees AS LAF
 JOIN AirportCharges..PassengerTaxes AS PAT
  ON LAF.AirportCode = PAT.[AirportCode]
WHERE DayLanding >= 500
GROUP BY City, Airport, Departure
--ORDER BY HighestDayLandingFees DESC
)

Select *
FROM LandingFees


