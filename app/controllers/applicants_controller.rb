class ApplicantsController < ApplicationController
  before_action :set_applicant, only: %i[show edit update destroy]

  def index
    if current_user.admin
      @applicants = Applicant.all
    else
      @applicant = current_user.applicant
    end
  end

  def show
  end

  def new
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new(applicant_params)
    @applicant.user_id = current_user.id

    respond_to do |format|
      if @applicant.save
        format.html { redirect_to applicants_url, notice: 'Applicant was successfully created.' }
        format.json { render :show, status: :created, location: @applicant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @applicant.destroy
        format.html { redirect_to applicants_url, notice: 'Applicant was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to applicants_url, status: :unprocessable_entity }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @applicant.update(applicant_params)
        format.html { redirect_to applicants_url, notice: 'Applicant was successfully updated.' }
        format.json { render :show, status: :updated, location: @applicant }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_applicant
    @applicant = Applicant.find(params[:id])
  end

  def applicant_params
    params.require(:applicant).permit(:id, :first_name, :last_name, :job_type, :start_date, :agree_tc, :status)
  end
end
