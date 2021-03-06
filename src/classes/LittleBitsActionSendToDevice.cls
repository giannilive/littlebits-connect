/**
 * Copyright (c), Andrew Fawcett, inc
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, 
 *   are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice, 
 *      this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice, 
 *      this list of conditions and the following disclaimer in the documentation 
 *      and/or other materials provided with the distribution.
 * - Neither the name of the Andrew Fawcett, inc nor the names of its contributors 
 *      may be used to endorse or promote products derived from this software without 
 *      specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
 *  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
 *  THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 *  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 *  OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**/

/**
 * Class exposing the send to device action
 **/
global with sharing class LittleBitsActionSendToDevice {

	global class SendParameters {
		@InvocableVariable(Label='Access Token' Description='Optional, if set via Custom Setting' Required=False)
		global String AccessToken;
		@InvocableVariable(Label='Device Id' Description='Optional, if set via Custom Setting' Required=False)
        global String DeviceId;
		@InvocableVariable(Label='Percent' Description='Percent of voltage sent to device' Required=True)
        global Decimal Percent;
		@InvocableVariable(Label='Duration in Milliseconds' Description='Duration of voltage sent to device' Required=True)
        global Integer DurationMs;
	}
	
    /**
     * Send percentages and durations to LittleBits cloud enabled devices
     **/
    @InvocableMethod(Label='Send to LittleBits Device' Description='Sends the given percentage for the given duration to a LittleBits Cloud Device.')
    global static void send(List<SendParameters> sendParameters) {
    	// TODO: Maximum HTTP callouts is 100 currently, this code may need to split requests over several jobs
    	OutputToDevicesJob lbtJob = new OutputToDevicesJob();
    	for(SendParameters sendParms : sendParameters)
	    	lbtJob.addOutput(sendParms.AccessToken, sendParms.DeviceId, Integer.valueOf(sendParms.Percent), sendParms.DurationMs);
    	System.enqueueJob(lbtJob);
	}	
}