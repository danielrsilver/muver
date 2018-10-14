import React from 'react';
import ListingsModal from './ListingsModal'
import axios from 'axios';

class Proposal extends React.Component{
  state = {
    approved: this.props.proposal.approved,
    modal: false
  }

  componentDidMount(){
    console.log("hello everyone")
    if (this.props.notification) {
      if (this.props.notification.read_status === "reading"){
        this.toggle()
      }
    }
  }

  approveProposal = (listing, proposal) => {
    axios.put(`/listings/${listing}/proposals/${proposal.id}.html`, {approved: !proposal.approved})
     this.toggle()
     this.setState({ approved: !proposal.approved })
  }

  toggle = () => {
    this.setState({
      modal: !this.state.modal
    });
  }

  readStatusTrue = (notification) => {
    if (notification){
      axios.put(`/notifications/${notification.id}`, {read_status: "true"})
    }
    this.toggle()
  }

  render(){
    const { approved, modal } = this.state;
    if (!approved){
      return (
        <div className="user-wants-to-help">
          {`${this.props.user.first_name} wants to help!`}
          <ListingsModal
            user              = {this.props.user}
            listing           = {this.props.listing.id}
            proposal          = {this.props.proposal}
            approveProposal   = {this.approveProposal}
            modal             = {modal}
            toggle            = {this.toggle}
            readStatusTrue    = {this.readStatusTrue}
            notification      = {this.props.notification}
            />
        </div>
      )
    }
    else {
      return (
        <div>
          <div className='approval-status'>{`${this.props.user.first_name} has been Approved!`}</div>
          <div className='btn btn-primary approval-toggle' onClick={ () => this.approveProposal(this.props.listing.id, this.props.proposal)}>Approve/Decline</div>
        </div>
      )
    }
  }
}

export default Proposal;
