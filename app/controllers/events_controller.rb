class EventsController < ApplicationController
     before_action :find_event, only: [:show, :edit, :update, :destroy, :confirmation_creation]

     def index
       @events = Event.all
     end

    def show
    end

     def new
       @event= Event.new
     end

     def create
       @event = Event.new(event_params)
       @event.user = current_user
       if @event.save
         redirect_to confirmation_creation_path(id: @event.id)
       else
         render :new
       end
     end

     def edit
     end

     def update
       if (@event.user == current_user) && @event.update(event_params)
           #attention le update ci-dessus est le update de active record, pas la méthode update du controleur
         redirect_to confirmation_creation_path(id: @event.id)
       else
         render :edit
       end
     end

     def destroy
       if @event.user == current_user
         @event.destroy
         redirect_to events_path(user_id: current_user.id)
       else
         flash[:alert] = "You can't delete this product"
       end
     end

     def confirmation_creation
     end

     def research
      if params[:event]
         @events = event.select{|event| (event.brand.downcase == params[:event][:brand].downcase)}
       else
         @events =[]
       end
     end

     private
     def event_params
       params.require(:event).permit(:name, :date, :address, :description)
     end

     def find_event
       @event = Event.find(params[:id].to_i)
     end

end
