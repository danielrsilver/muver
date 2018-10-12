class ProposalsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def new
    @proposal = Proposal.new
  end

  def create
    @proposal = Proposal.new(proposal_params)
    @proposal.save
    redirect_to request.referrer
  end

  def update
    @proposal = Proposal.find(params[:id])
    @proposal.update(approved: params[:proposal][:approved]) if params[:proposal][:approved]
    @proposal.save!

  end

  private

  def proposal_params
    params.require(:proposal).permit(:message, :user_id, :listing_id, :approved)
  end
end
