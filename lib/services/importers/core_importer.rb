class CoreImporter 

  def initialize(retrieved_accommodations:)
    @retrieved_accommodations ||= retrieved_accommodations
  end

  def import
    @retrieved_accommodations.inject([]) do |accommodations, retrieved_accommodation|
      accommodations << create_or_update_accommodation(retrieved_accommodation: retrieved_accommodation)
    end
  end

  def create_or_update_accommodation(retrieved_accommodation:)
    accommodation = Accommodation.where(id: retrieved_accommodation.id).first
    unless accommodation
      accommodation = Accommodation.create(retrieved_accommodation.attributes)
    else
      accommodation.update(retrieved_accommodation.attributes)
    end
    create_or_update_children(
      retrieved_accommodation:  retrieved_accommodation, 
      accommodation:            accommodation
    )
    accommodation
  end

  def create_or_update_children(retrieved_accommodation:, accommodation:)
    facilities = create_or_update_facilities(
      retrieved_accommodation:  retrieved_accommodation, 
      accommodation:            accommodation
    )
    images = create_or_update_images(
      retrieved_accommodation:  retrieved_accommodation, 
      accommodation:            accommodation
    )
    booking_conditions = create_or_update_booking_conditions(
      retrieved_accommodation:  retrieved_accommodation, 
      accommodation:            accommodation
    )
    return { facilities: facilities, images: images, booking_conditions: booking_conditions }
  end

  def create_or_update_facilities(retrieved_accommodation:, accommodation:)
    retrieved_accommodation.facilities.inject([]) do |facilities, retrieved_facility|
      facilities << create_or_update_facility(
        retrieved_facility: retrieved_facility, 
        accommodation:      accommodation
      )
    end
  end

  def create_or_update_facility(retrieved_facility:, accommodation:)
    facility = accommodation.facilities.where(
      name: retrieved_facility.name.strip.capitalize
    ).first
    unless facility
      facility = accommodation.facilities.create(retrieved_facility.attributes)
    end
    facility
  end

  def create_or_update_images(retrieved_accommodation:, accommodation:)
    retrieved_accommodation.images.inject([]) do |images, retrieved_image|
      images << create_or_update_image(
        retrieved_image: retrieved_image, 
        accommodation:   accommodation
      )
    end
  end

  def create_or_update_image(retrieved_image:, accommodation:)
    image = accommodation.images.where(
      url: retrieved_image.url
    ).first
    unless image
      image = accommodation.images.create(retrieved_image.attributes)
    end
    image
  end

  def create_or_update_booking_conditions(retrieved_accommodation:, accommodation:)
    retrieved_accommodation.booking_conditions.inject([]) do |booking_conditions, retrieved_booking_condition|
      booking_conditions << create_or_update_booking_condition(
        retrieved_booking_condition:  retrieved_booking_condition, 
        accommodation:                accommodation
      )
    end
  end

  def create_or_update_booking_condition(retrieved_booking_condition:, accommodation:)
    booking_condition = accommodation.booking_conditions.where(
      condition: retrieved_booking_condition
    ).first
    unless booking_condition
      booking_condition = accommodation.booking_conditions.create(condition: retrieved_booking_condition)
    end
    booking_condition
  end

  private
  attr_reader :retrieved_accommodations

end