class Facility
  attr_reader :name, :address, :phone, :services, :registered_vehicles, :collected_fees

  def initialize(facility_details)
    @name = name_finder(facility_details)
    @address = address_finder(facility_details)
    @phone = phone_finder(facility_details)
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
  end

  def register_vehicle(vehicle)
    if @services.include?("Vehicle Registration")
      vehicle.register_now
      issue_plate_fees(vehicle)
      @registered_vehicles << vehicle
    end
  end

  def add_service(service)
    @services << service
  end

  def administer_written_test(person)
    if @services.include?("Written Test") && person.permit && person.age >= 16
      person.pass_test(:written)
      true
    else
      false
    end
  end

  def administer_road_test(person)
    if @services.include?("Road Test") && person.license_data[:written]
      person.pass_test(:license)
      true
    else
      false
    end
  end

  def renew_drivers_license(person)
    if @services.include?("Renew License") && person.license_data[:license]
      person.pass_test(:renewed)
      true
    else
      false
    end
  end
      
  #tested
  def issue_plate_fees(vehicle)
    if vehicle.antique?
      vehicle.issue_plate(:antique)
      @collected_fees += 25
    elsif vehicle.electric_vehicle?
      vehicle.issue_plate(:ev)
      @collected_fees += 200
    else
      vehicle.issue_plate(:regular)
      @collected_fees += 100
    end
  end

  def name_finder(facility_details)
    if facility_details[:name]
      facility_details[:name]
    elsif facility_details[:dmv_office]
      facility_details[:dmv_office]
    elsif facility_details[:office_name]
      facility_details[:office_name]
    end
  end

  def address_finder(facility_details)
    if facility_details[:address]
      facility_details[:address]
    elsif facility_details[:address_li]
      co_address_formatter(facility_details)
    elsif facility_details[:street_address_line_1]
      ny_address_formatter(facility_details)
    elsif facility_details[:address1]
      mo_address_formatter(facility_details)
    end
  end

  def phone_finder(facility_details)
    if facility_details[:phone]
      facility_details[:phone]
    elsif facility_details[:public_phone_number]
      ny_number_formatter(facility_details)
    end
  end

  def co_address_formatter(facility_details)
    string = ""
    if facility_details[:address__1]
      string << facility_details[:address_li] << " " 
      string << facility_details[:address__1] << " " 
      string << facility_details[:city] << " " 
      string << facility_details[:state] << " "               
      string << facility_details[:zip]
    else
      string << facility_details[:address_li] << " "
      string << facility_details[:city] << " " 
      string << facility_details[:state] << " "               
      string << facility_details[:zip]
    end
  end

  def ny_address_formatter(facility_details)
    string = ""
    if facility_details[:street_address_line_2]
      string << facility_details[:street_address_line_1] << " " 
      string << facility_details[:street_address_line_2] << " " 
      string << facility_details[:city] << " " 
      string << facility_details[:state] << " "               
      string << facility_details[:zip_code]
    else
      string << facility_details[:street_address_line_1] << " " 
      string << facility_details[:city] << " " 
      string << facility_details[:state] << " "               
      string << facility_details[:zip_code]
    end
  end

  def mo_address_formatter(facility_details)
    string = ""
    string << facility_details[:address1] << " " 
    string << facility_details[:city] << " " 
    string << facility_details[:state] << " "               
    string << facility_details[:zipcode]
  end

  def ny_number_formatter(facility_details)
    facility_details[:public_phone_number].insert(6, "-").insert(3, ") ").insert(0, "(")
  end
end
