class CharactersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_character, only: %i[show edit update destroy]

  # GET /characters
  def index
    @characters = current_user.characters.active.all
  end

  # GET /characters/1
  def show
  end

  # GET /characters/new
  def new
    @character = current_user.characters.new
  end

  # GET /characters/1/edit
  def edit
  end

  # POST /characters
  def create
    @character = current_user.characters.new(character_params)

    if @character.save
      redirect_to @character, notice: 'Character was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /characters/1
  def update
    if @character.update(character_params)
      redirect_to @character, notice: 'Character was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /characters/1
  def destroy
    @character.archive!
    redirect_to characters_url, notice: 'Character was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character
      @character = current_user.characters.active.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def character_params
      params.require(:character).permit(:name, :race_id)
    end
end
