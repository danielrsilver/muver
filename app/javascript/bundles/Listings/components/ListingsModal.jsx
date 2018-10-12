import React from 'react';
import { Button, Modal, ModalHeader, ModalBody, ModalFooter } from 'reactstrap';
import MiniProfile from './MiniProfile'
import axios from 'axios';

const ListingsModal = props => {
  return (
   <div>
     <Button color="primary" onClick={props.toggle} className="view-profile-btn">View Profile</Button>
     <Modal isOpen={props.modal} toggle={props.toggle} className={props.className}>
       <ModalHeader toggle={props.toggle}>Request</ModalHeader>
       <ModalBody>
         <MiniProfile
           user={props.user}
           />
       </ModalBody>
       <ModalFooter>
         <Button color="primary" onClick={() => props.approveProposal(props.listing, props.proposal)}>Approve</Button>
         <Button color="danger" onClick={props.toggle}>Decline</Button>
       </ModalFooter>
     </Modal>
   </div>
 );
}


export default ListingsModal;
