/*============================================================================
  @file GyroTap.h

  @brief
  GyroTap class definition.

  Copyright (c) 2014 Qualcomm Technologies, Inc.  All Rights Reserved.
  Qualcomm Technologies Proprietary and Confidential.
============================================================================*/
#ifndef ANDROID_GYRO_TAP_SENSOR_H
#define ANDROID_GYRO_TAP_SENSOR_H

#include "SAMSensor.h"
#include "sns_sam_gyro_tap2_v01.h"

/*============================================================================
 * Class GyroTap
=============================================================================*/

class GyroTap : public SAMSensor {

public:
    GyroTap(int handle);
    ~GyroTap();
    int enable(int en);
/*===========================================================================
  FUNCTION:  processResp
    Process the response to the sensor1 SENSOR1_MSG_TYPE_RESP
    Parameters
        @msg_hdr : sensor1 message header
        @msg_ptr : sensor1 message data
===========================================================================*/
    void processResp(sensor1_msg_header_s *msg_hdr, void *msg_ptr);
/*===========================================================================
  FUNCTION:  processInd
    Process the response to the sensor1 SENSOR1_MSG_TYPE_IND
    Parameters
        @msg_hdr : sensor1 message header
        @msg_ptr : sensor1 message data
===========================================================================*/
    void processInd(sensor1_msg_header_s *msg_hdr, void *msg_ptr);
};

#endif
