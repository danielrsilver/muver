class ListingsController < ApplicationController
  before_action :store_user_location!, if: :storable_location?

  def index
    @listings = current_user.listings
  end

  def new
    authenticate_user!
    @listing = Listing.new
  end

  def show
    @proposal = Proposal.new
    @proposals = Listing.find(params[:id]).proposals
    @listing = Listing.find(params[:id])
    respond_to do |format|
      format.html
      format.json do
        render json: {
          proposal:        @proposal,
          proposals:       @proposals,
          listing:         @listing
        }
      end
    end
  end

  def create
    @listing = current_user.listings.new(listing_params)
    if @listing.save
      redirect_to listings_path,
        notice: 'Listing was successfully created.'
    else
      redirect_to listings_path,
        alert: "Could not save listing: #{@listing.errors.full_messages.join(', ')}"
    end
  end

  def update
    @listing = Listing.find(params[:id]).update(listing_params)
    flash.notice = 'Listing was successfully updated.'
    redirect_to listings_path
  end

  def edit
    @listing = Listing.find(params[:id])
  end


  private

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
      # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

  def listing_params
    params.require(:listing).permit(:description, :starting_address, :ending_address, :price, :difficulty, :date, :time, :contact, :stairs, :max_people, :street, :city, :state)
  end
end
