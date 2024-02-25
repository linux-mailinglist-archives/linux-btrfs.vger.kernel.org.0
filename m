Return-Path: <linux-btrfs+bounces-2728-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6964B862965
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 07:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A04282292
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 06:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F91D268;
	Sun, 25 Feb 2024 06:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cLh8bTqx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RfzyxEAJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C452346AB
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708842818; cv=fail; b=W9NtyBDbaMkzo2Beo/pZdqlp6rjjDeFxhL7URBZCQX49jyDQvbqJ3Aou40tEzN7KwB84AXvgkJT4ab+9Xz1qbaEJdP0iYOz9rWRvblKMvVmDFgxpkvIq6TF1gQCNd3I+t6Y2lStjiwRkSTNxQ9vDXchMBd5v+0PUF2sCqPCI2zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708842818; c=relaxed/simple;
	bh=AufhiaCoB+wxaUDdAYmvCbCO8rZmJTdU61uvK1Xq3IY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kQrreadd91zwtzU8+zc4M4oCdvSoNXekh0D5qxBwMyw+k4RR3Fu4s7a7IBCxZvOKXANFH0SuT2zLAGWGLDGCvn01BIVsJq75GaCc49sPaDQF7S9WG0bRijeQ8rjw5zk+mgwf7k/Hf+ffjDUi4rVZRhbHZbJqokQ9nKAgVjKdxeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cLh8bTqx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RfzyxEAJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41P5RqGO031328;
	Sun, 25 Feb 2024 06:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=4OCfcaqEXzu0gf8hs+eHV6AjyO+nhxwsomBUMWxIJa4=;
 b=cLh8bTqxOoECpG+WJ7/5HIwL14J40eNazCMcSAW+QvxNu8bPFTRxkwSkLPeDqeWSt/ED
 /xjYJr6McQ+m/tmVFfKqOFp256tWOMtp5RwUEDVv0QVFL/+7DNHQBCMm8HZHhG32LuNI
 uV7cX4IMSh88Eq5qIjdcNk891AVcooET5CfDhcnEoPneKpCQDdrjlr+fVTmfHfAqEhOC
 Ou6ApSqWkBtcKlHqNbUphWJqrfMkUEWES73d0baqAeZXitNf2p21YEaHNSlP3q5P+2Yl
 C/hTcBZStyrz+uVht0epmwtAgmFuiH5gIv228Vx2ygi3TNk+ZZ6cpFbnSl/UDNOIGbOL iw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf784aesr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Feb 2024 06:33:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41P4u8h8039286;
	Sun, 25 Feb 2024 06:33:32 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w47se1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Feb 2024 06:33:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJ6Y+6iB+oZFnAt94oL5sX6w+r5XMXaN35s2OTVNQwZnW1D5yga0pfGhzuRe6R/w9Ys5lPIk8POt3KsfSyTwhvdFM54A0AtBOPwmOS5W03olysVbOlyh71s56DnSNUYJdHrfjZkgtqcXrJP3eShJQKfPXtYBx0na1G99otpX97XYbMGK1m3Z+gNFiDM2M5JnxeMJDow1Uli1ZNdjldAB+jO0e0A66oZRiqsBeU4H1G6F8+NCL+Zg5kkLd+G2rP1rxus2fkchr5T3MDcmy9t2YEyxF6W1bjx9mcpKGVpDvILE/HgxKelLzux1mGPaHzE8dEcCHPgYyyU6iu5UygYolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OCfcaqEXzu0gf8hs+eHV6AjyO+nhxwsomBUMWxIJa4=;
 b=aED7fMGmVrkcb17MwKNNDu3LFvAa7AADNN2uv5xfyx20HicCpaZn5KMMh4gwLM13cCRgPYBG2eFwKonzHug+E/EbIjFa04W/eCSOTORsnBtq7KQ/snmLLya2ybY1Z5fHS65Eo90kkepKActg/l6jtJ8juI9m+1WUQKucNzMkGYi+sMSAksfJY4MI9q8J+P5ql0bduQnymJDM8+55t+aJ1TTg+PvM8KbBEQThi544jaTrFLVmOvgPM/q33xyUPI4yiGVFan9VAfVnv6qW0bgYlmSR60UPnk7YqQz3AtZeilzgs88iN5UyOC1+HUkgoypZHkO2JMb5ZuP1rlNFqwyj3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OCfcaqEXzu0gf8hs+eHV6AjyO+nhxwsomBUMWxIJa4=;
 b=RfzyxEAJ65KKufuhC/tbq6LNfUGqfUBCZITyI9ZMk6SL3lu+UCpxBvmcXPVVrb81nsDQ/qudiyt2ZWnpVUxIs7e8wmXEiyaaBBkKRr0C2CDQDPdXk43EJVG8RQhtEqq1FgWm9+FW7AdiDzI1hd1VLXdqWCKkdGO77FtkRAKe0lc=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by BLAPR10MB5107.namprd10.prod.outlook.com (2603:10b6:208:324::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Sun, 25 Feb
 2024 06:33:29 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85%3]) with mapi id 15.20.7292.036; Sun, 25 Feb 2024
 06:33:28 +0000
Message-ID: <a8ded855-c4a0-4357-aeaf-70c6f137ae16@oracle.com>
Date: Sun, 25 Feb 2024 12:03:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: include device major and minor numbers in the
 device scan notice
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <9b8ddccde70488086ea466b33b9cc1e52d0dee3e.1708687432.git.anand.jain@oracle.com>
 <7f2d1ad7-3c5c-41e9-a797-895e2ec76ed6@gmx.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <7f2d1ad7-3c5c-41e9-a797-895e2ec76ed6@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::30) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|BLAPR10MB5107:EE_
X-MS-Office365-Filtering-Correlation-Id: be3fe59d-702e-4efc-3a36-08dc35cbad43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nrUZLnVedTGKQb9qsAOQ1Y0QyTMS1WKorLwimoXR9tc2S5termS6GokE+eBZJ9oKVSp8W7w+Cs/6jPkzXhQr7/YkQjXCakBgIW3T4RIbfd1peeLZTb3rMtIiXCz9t3IyWg2oa/5RP9IC+rOckYkSwgY2GsvAL4/g8ZRX8JtwwWcvll/z82ERkApAZX/FUWBBEm1NHX24KODMq/S0cRt8LzDXfklln2V7XFdsuqJ9XzPMef8JfcCt5JD/LSZoBmbVF3bezBYcsqDrxMW2kMhG6o97O23zJrsJn6650/VBB3NY4beR9oYq4pyEztDzQCNiN6xifp9OGpmF4Byg67TvP7lvW0UTTn1vStkW96ENOPSJBosNRbUtZ2eW9OcU8gXCaQz+jiN28PTqiUlT07YshCpnS/y51kQnaaPM6NMIorrr3c+kpbO8TlP7CXnu6z+mw9nyji6Yxtwbs6BUWN7NCFllsu/zAKuLrw4erk8mce2VZqxsO3UWdvPpvTr/eBXg/JOi98agPf0ZeOXJ2yXMagyXr4i7G+WD1lutjImbfrY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UmxtdTBQTWRZWjFsYWtpM2V4VnorTHNOSGNzN0dVOWZGSDVpNDVTbHIwMmIw?=
 =?utf-8?B?cUdlSjdNVVZqVTNxcnZtU3dEbExsRHZjYnVZMXJoMmh6Mm00MXlXa3ZYbWJD?=
 =?utf-8?B?VlBIMW9QSkkrWi90S3NlUEpLblBFM2t3TVNmbXkrcjIzZklsM2d1YWV3YmJ5?=
 =?utf-8?B?a2p1U0pObU5RdG5hWVZ6ZjBqbk93ZXE4aDhWcDhMai9nQTM3bW44ZW1yc3Bj?=
 =?utf-8?B?L3ZOUkVJVWVHNUJJaDVWd3JuN2JiZTVCSkIxSVluU3dZdGNMSHVqbWRrTXhn?=
 =?utf-8?B?cEpqUDgyWk00RktzRmRGUHJud1J3V2VPNENUQVZobnhnY3NTUXdRMHlPMWZP?=
 =?utf-8?B?MWVvcExZRTZhd0g4MFhDWjNXaDVsdkliY01NUkZwNVZmbU5BazNoNXBFQkxl?=
 =?utf-8?B?T1JVS0s4ZFVMaTBaZkE1Ylh4aVpGRWNwdTEwd2ZPM09kVGw5YUFiMnNCRGcw?=
 =?utf-8?B?ZXZHL2xORHFYWEM4S052ZjhpeDFSSGI0UHZzSjJocHVtaTVUMGdtNit4MGlM?=
 =?utf-8?B?TFBvVnk0TnhhZlJGN0ttZjVMajljM0FFWTlwa241Rm9YN1E2RFFnYTVvWTdV?=
 =?utf-8?B?R3RFN0w4Y21uR0FLM0NSbnRsUjNVd1RHeFV0cDE0aVU5R05ZdVh1VjBDekY1?=
 =?utf-8?B?OFgxZVlWSXBJdFdFeUI3SiszbGxzY0lEVlptR0lwWCtzdmRJVG5EM2kvNlY2?=
 =?utf-8?B?S01HWHlGMDZZUFFEckU2SG40T3hwa001ZTNMWjE5ZnN1eGhHd09RZEpXd1FX?=
 =?utf-8?B?MnVkVVNkTjhGWXRGVy9NbGF4Zkw4VXRpUTF5ZFFVQWJRQ2ZabzRlamxuRjZq?=
 =?utf-8?B?ZlVwV05zVmRSWUthSDZsa0lRV0xOaG4zelNHa1NaZWk5UVp6T1lkdlVmMkJB?=
 =?utf-8?B?UXhlZVU3NVRsNUJDVDc4d3VhTVZlS0dNRVFvTUIrWG0rZ3cwOGpGcFFjVjhy?=
 =?utf-8?B?MlNhdXd2V2Nna1ZTZllkOXlzNnZpNlY4UlVTalVuRFVHd2t0amFEN0EyamJu?=
 =?utf-8?B?VTdPTjFQTU1vRElIUTVrM0taSWEzOUhTRHBkbmt4bFA5ckNQNjd3MUZUUmpI?=
 =?utf-8?B?R0d3SEpQVEplRWFwNGJnVDhQcFE5ODA3OXl4Y2pqSzB2WXZ3V1JwVTZrb0dq?=
 =?utf-8?B?N09jbHdIL2pqck1oSGFHV2hhUkVFZW1WRlJuVW1wMzdqa1U1cUUxWitYZ09J?=
 =?utf-8?B?YXF3V0t2VWJsRTJIODRjclM5SVBzbFh5YTI2d2cwdkV5TUxDaENJZW02eENQ?=
 =?utf-8?B?bEkzazUyM0JYemNCSTlhWG5TY1dWcloxU21FdytONWRaNjNWTWtvVkNUZFpN?=
 =?utf-8?B?Ym9UenRabXBUbHh4VEpMMEc5Nm1xNTNrMk90MVFYYytOaFZSY1ZCM0xVbFBh?=
 =?utf-8?B?L252Q3BZVFB1NkNLa2labzVVSGwxTjVlellzeHZMcUdRYnI4TUZkNll1NGJz?=
 =?utf-8?B?dkl6N2tHYUZvdEJrRVdPV21pNnBJUmMyU0Q2bXpZQ3l2NlBvNTZlYjJLSFor?=
 =?utf-8?B?QXBDOGFKa2dGVUk0cU1aZ3lwUGR1TDhXdGljcEVZOU5RKzMyQitkSWJoV1Y3?=
 =?utf-8?B?RlBpT2grU3Z3ZVBnbVVyYU11QVBrenNrTGt6K1VxdVhLMUZYSFhISU9Ia0Ft?=
 =?utf-8?B?YnlzTHoyRDdEWldaMkRwOFVXb2NEQVcwRHpTejMrMkR2UkF4MWdFRTBNcGlN?=
 =?utf-8?B?cU5XemJUaDQ2cjIyQ3VaNVp3RHBvNGZCcE5yUWR2NUxPUVRvU3YwUC93UFYr?=
 =?utf-8?B?dFByeWF4THVtOWNEUk1qUUhqVjlsSjkwc0twaTBPZTBVMkd6dWZKZkV2TlB2?=
 =?utf-8?B?N29hdzNkYjdZeFp1QXBhWDBUVWVSaWx6bjEyNitXNzBBWEEvM2ptckpsKzZ4?=
 =?utf-8?B?Qyt4TUN1Ry8xN1REK1BmTFpDYkJ3MFZEWmRWYkg5TEM0QmxYcEp1ZDBqT3BE?=
 =?utf-8?B?dDIvTzhIdncrYkhRb2NpMHNZVVlONlNYNUtaVkpwTXcvRTdTUnhqVDVqSEI1?=
 =?utf-8?B?NmxLcHRianBLTU1vL3dKNno1UHZKVi9wVC9mdVB0cERjbDdXQ3JVSjFtWUNn?=
 =?utf-8?B?WWFZcDJnNmt5cTB3eW1EdFQzU0l3bUhpSFphSkp1dFl1V3NVcHN6NFZoWU5R?=
 =?utf-8?Q?D6kCw5YCHRLZwqIVnMniXkO3M?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6A/g5AmKMAuZm0wGpiN3VdQFfBpEN9sSL+eF+R7oSzYiP9/HKzCwEcVDoNs6Et+v/uJW2BwRRCK+t2gxs+orGnebkT3tOTE+kv0/RwEI4CLB+likdh0jKT2o978Rm0CxXwI9BSIp3L8SFo6ZPwRtGn9i8ALjYERX0T+jLE/Rp5Wges6/w7cbiGbbDvFNjsJaaqz0QuqIY19ztwCWMUpTWbi+Fh0Rvch7thDPAu3f+/EkEYXmzZVFHZjpecwiHA0oS8Y9IVYXhEFz13/ClmBzicA6+qyu6upQMBnc1J4zvCUBDNqMbZHrMz62tqFby5tYPXQFMSGAuEG7XIyWQxpMvSqmdO42i89pLMqGhluh9S/FJoBWtRpEFhkGCUvWerqIeKMrg6Vqs8Ij523ns/Jy3Uf5Lo7JcgKCZIbkg2nUIGmWl0dpKuZjSpIh0qe0UTCO4TharWNRzlrk2TsrQ6IYvBO1/0U3GqX0Hxgz9q+k5/386MGTymAJGVWxoHaGs31PITNizysWe2hRtEvHNhjwrM6XVxuuzwf+3ci1HKA/9NSGR98JCBPn977y+UXoGqo7fUPebpzpyNekDrMWBZAj17AXPjgriDDHeS1GmMcZpD8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3fe59d-702e-4efc-3a36-08dc35cbad43
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2024 06:33:28.5026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YtkCoYZ/aV9y8ebK2/alc4c1AjnsCgjtxDrFGFAVcdhBpnHmV+Md8I2EofF2u3OsEAFRphBGxxKv/JfVdcuOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5107
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-25_05,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402250051
X-Proofpoint-GUID: _bdFqdzjkraiHiarNFw-Pe4-QQWyhoD1
X-Proofpoint-ORIG-GUID: _bdFqdzjkraiHiarNFw-Pe4-QQWyhoD1

On 2/24/24 01:27, Qu Wenruo wrote:
> 
> 
> 在 2024/2/23 21:56, Anand Jain 写道:
>> To better debug issues surrounding device scans, include the device's
>> major and minor numbers in the device scan notice for btrfs.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Maybe you want to expand the device number to all other device name output?
> 
> Especially considering the recent device name problem, device
> major/minor looks a much better supplement.

  Yeah.. added to all scan related messages.

Thanks, Anand

> 
> Thanks,
> Qu
>> ---
>>   fs/btrfs/volumes.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 32312f0de2bb..6db37615a3e5 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -824,13 +824,15 @@ static noinline struct btrfs_device 
>> *device_list_add(const char *path,
>>
>>           if (disk_super->label[0])
>>               pr_info(
>> -    "BTRFS: device label %s devid %llu transid %llu %s scanned by %s 
>> (%d)\n",
>> +"BTRFS: device label %s devid %llu transid %llu %s(%d:%d) scanned by 
>> %s (%d)\n",
>>                   disk_super->label, devid, found_transid, path,
>> +                MAJOR(path_devt), MINOR(path_devt),
>>                   current->comm, task_pid_nr(current));
>>           else
>>               pr_info(
>> -    "BTRFS: device fsid %pU devid %llu transid %llu %s scanned by %s 
>> (%d)\n",
>> +"BTRFS: device fsid %pU devid %llu transid %llu %s(%d:%d) scanned by 
>> %s (%d)\n",
>>                   disk_super->fsid, devid, found_transid, path,
>> +                MAJOR(path_devt), MINOR(path_devt),
>>                   current->comm, task_pid_nr(current));
>>
>>       } else if (!device->name || strcmp(device->name->str, path)) {


