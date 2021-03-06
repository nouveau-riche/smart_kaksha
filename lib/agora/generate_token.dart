//std::string appID  = "970Cxxxxxxxxxxxxxxxxxxxxxxx1b33";
//// Fill in your App Certificate
//std::string  appCertificate = "5CFdxxxxxxxxxxxxxxxxxxxxxxx5d3b";
//// Fill in the channel name
//std::string channelName= "7d72xxxxxxxxxxxxxxxxxxxxxxbdda";
//// Fill in the user ID. 0 means that the server does not authenticate user IDs.
//uint32_t uid = 2882341273;
//// The timestamp for the token to expire
//uint32_t expirationTimeInSeconds = 3600;
//uint32_t currentTimeStamp = time(NULL);
//uint32_t privilegeExpiredTs = currentTimeStamp + expirationTimeInSeconds;
//std::string result;
//
//result = RtcTokenBuilder::buildTokenWithUid(
//appID, appCertificate, channelName, uid, UserRole::Role_Publisher,
//privilegeExpiredTs);
//std::cout << "Token With Int Uid:" << result << std::endl;