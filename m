Return-Path: <linux-btrfs+bounces-2716-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0FD862613
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 17:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51913B215B9
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 16:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666CF4B5A6;
	Sat, 24 Feb 2024 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="efS06Xmo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i0UrogiD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2659D48CC7;
	Sat, 24 Feb 2024 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708793054; cv=fail; b=HqXV3A83u+lssRLQANyDagT8nLKjUzbvuArosuKmVOnXZlBEne4M4oZ+D1QZkC+tjb8jhhL9NUrqLmXojcnvqbTuh/ue4oOfLNT1hwA02rP3NFEByQrjJtPnLoamNJMi+yNGHAzbJSncWK4z3ChTY3p9QkAblADUbEXxnRhgSS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708793054; c=relaxed/simple;
	bh=soyN4wH/QdIOBa4b4bDug54tIcNULG7hAoR3QaB/0BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NxClAVVyRS5i0NbwMOQSQO9dYuRfaysogxlOBxeQ7gVaqgDA2nvztzfWiYqDiaCqjQb/UuUEYs6vkpl0WsAPeLT2jw88sCowjV5XZtmTbfDYDywuIXmdMQ5z8iy34+5Gur7MvzeE+bWWOZjYbtOMIMrtitUaWTknhu3Ft+R7+cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=efS06Xmo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i0UrogiD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41OFT6ie020714;
	Sat, 24 Feb 2024 16:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=2n0gBnZfJdb5UBXuwfE4KpwsEmdUxhms2SD1B8AXos8=;
 b=efS06XmoWH+WQ7C+vrHyGJaVtQ0aCzI4yPIPm3aNT2fVyTIVnF3+nOf7Bdf7kl2w1RF6
 pevUrCBVsQ6NA9qGaRcv5FfAx8+CQq6Ek/3CrBdRlUSRoGTx8BBVGEBSC1sDPJwlsKDb
 zRTCn8Ff95HjbujVYxiArmfNwGi+Jk0Uv2BImbh9/xFx0+CoELQ99tjJuHHstR0LegqD
 aND2WmiFxP4ATjrmPiONHkdBQPbJp8gqBPV+6NgQGda1EhycLCrMrFqsLgALY7kQu281
 m2WrJvvhYy5JN39vf6gfqEGhfEJ1uVxetNxutXJcsC5wCr17GqTaqhYTb6ZBaVAl3sTO +A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90v1101-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 16:44:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41OG1FYN017326;
	Sat, 24 Feb 2024 16:44:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wa9h6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 16:44:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rfp+9xsty4wzzFWuPaT059CjsCNsn/+ku2/Sp5kGgEtA5C6ORpthsgQF6TqYeG+AxgL88yhqZrrsmLde0Sa8MMUwp/4klRwHcZtcewgbcmND5NQg7t6OvbwBoh4jB08efYbkfD7/E0bvZ/hamxSa0vo+plcuLIxF6qy0SrSy/MjTU5FJSt0fhWZCWpqgE72rXCvwYzp0RPfLhhrOgQfhZhWrKxs5f7K+3T6MnzbAqvS7kkMiD2lOZ8sE6zIT91KbtmKJh07vG6Pw/veB7Kq+S8mMqVUaEKsVZZYnSDFObmnS1PWrchW0hvFbet28w1ImFz5ZwW433X9RDzcPkF9yhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2n0gBnZfJdb5UBXuwfE4KpwsEmdUxhms2SD1B8AXos8=;
 b=LPLJGt/Kgg0tZJJT2dCDD5AxzLmvRW58+VJZP3GQE+ZuR8Q2Byk12WaVxqDJHHMm38W3WEIpAnhLS4LBtiD4lGIBw0pilg71ICT2q4Op5sBzCbZ9XUKq6zVT899xG0LqbC705NfPh/wwdJ/ij2v3SvXCsKBJFyuoRd5gabX79YdrSQuMf5RJ1oOx8ZIL0LH46cpnP3xtH30aHorFOAUohIFWweK7aRQzqVseRLEBW4pLwwF4TJbJY5aZ/lzudKjPwOsNK9nlpGFHeIZ+ssRTgqkWch2FRLwhF09CKk8HR57gGtwm4c7tG2Xan0Y5PL6+iPaEON+A5516BQGwmXWZGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2n0gBnZfJdb5UBXuwfE4KpwsEmdUxhms2SD1B8AXos8=;
 b=i0UrogiD0PcGG2mg7qD72JTmIns4jkAHTMq56iiizds0Rilil8HglMWcxuppd0cki6hYUucAZO67sbyJyHrW1CEJyQ5PrcZgVGFeo0YDZp6CcFfJsUurvDZwt7hSCYl1by0GlhbrW2ELVMXY5bzFXM2VGFlSKclWk/Ul0KgDI1E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB5750.namprd10.prod.outlook.com (2603:10b6:303:18e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.32; Sat, 24 Feb
 2024 16:44:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Sat, 24 Feb 2024
 16:44:07 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v3 06/10] btrfs: test case prerequisite _require_btrfs_mkfs_uuid_option
Date: Sat, 24 Feb 2024 22:13:07 +0530
Message-ID: <8d6db7e4b981bf39cd8ceaf0db732c413f0fb093.1708772619.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1708772619.git.anand.jain@oracle.com>
References: <cover.1708772619.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: d84ad001-cff5-4cb4-1815-08dc3557d1bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ospjPd4E1CDRO6pdE7t5rCJ5LHfyEaixkbdBk6Po1zK6jWFK90WFMwFAGoUyhpocdY8UeldVOEahvGxa4PJB7sRPgEJwrahhSk0YwqPCnwHKApZUozb6sqHiqc+OcJ43DNzLW2zafpkdo6YohaaHdR8sU8zLj0UnjpAGuiV1Cor6OzK3slw/eaJw9gvi5ZZzA4/j0ZFA3q8MGIoMP9LjEDUmOjPRKr46FRxguFdbyTshnbDU7Q4t9MExu7DDGqkBH0+OTtJdWNb5aqIdP/ZJZRlTZUJjVgg9xTQOU+mw7rx9UrRrKjif+MgwGlgjGGcsOGkuDTVk3wkNS0p04RLql9uvFD3EzSUhqSNqRqXJdxxULUK4glX2JNp4uqbJillBnKFGRR7DcHZCeqj4D6JhSaokk9gPzchlzMzhGx9dpvAMyma3oWr7wmU6QzmsMjFf4A+29EbJzespKGe4vVkPV1MMW/Hq4O5KqGvOeGG985G3ZImCeIGYf4MAzGJpvYViSpvcVhxaR62PqiN7yk6VeKqQ+CIBwzEyfrp5sH4FmKk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ukiDOWjnme+y1E0wh0ziq/T6wo+ChZU61+MZGs5flyLDwHbCTkQGKn5/zvHz?=
 =?us-ascii?Q?ei/4gBzj49p1Xm8wOJf61M3zW5yI0X3Zq3kgAAEb2sgPm8zSRMAswKa8caNF?=
 =?us-ascii?Q?Xorlrazk37RDXM3vWUAwpnvBxS5VP0gdf6RR00xwlRwIx5kuTMAT+2qZjDLN?=
 =?us-ascii?Q?tLgHr7Ni1siZGtSMIc56KKFrAh/CkKwEJVCXM4tk6HQ+s5Fl7QAaOWwLZnFY?=
 =?us-ascii?Q?ZlFxVucD5FIyfd2jeIxkyr8rLa598ezU074XZHa8v+1KrI+mcOqut4i4AAP5?=
 =?us-ascii?Q?jiWedbvq9gAbWCPuolcEtosXL6W4KGmj9ecFH7Dk/ziGWbz7eyYerXOo7sZ8?=
 =?us-ascii?Q?aHWWqt/NzljfetXGSMo5V5LAgz7dYEj1rOuEOMi4ZHd1op54IpW+dM0NKbFQ?=
 =?us-ascii?Q?TztUY34NCd5l6sQPEI/4yYveR/ffovU/qsU5k7i3VnYG7CraRkHQ+9yJ5STr?=
 =?us-ascii?Q?JWeecn3f6d80FQU0ERWcUimxXY9sJ1sCr1+rZ3zg+OM7sXtjx1L/Yka3N2oC?=
 =?us-ascii?Q?OqrCvDyVfwV7V6Y6pzmn3HxYWCXB/9jJNnnfzUYl4T4TkC2VYGrmWXOqIp4M?=
 =?us-ascii?Q?gGOiIZelNWgdWQoxfElQOl5oZz5RmUanWYOhTh5FwR8kZseLLrXQtieQC8AD?=
 =?us-ascii?Q?ZBRPtgDNos4CBixW7L8Nsf6QlV9CvXMfiZMmZMiXoUh9J/DjCMP5PiDvwGdw?=
 =?us-ascii?Q?beaZNKk+yT/ag1E6qkIPJtK3Oj8LiGnDuekcNtzN3HFJhBcU2vvlZHnUKFGs?=
 =?us-ascii?Q?ZcbVwaK0ZM+FLvLLs7oS2W+pq++C6XlsEenFl4tgoSjHe1C+WrC2vg4nUjwi?=
 =?us-ascii?Q?SBnfWNNyV87r9RuJIUMRw1Tl2ywiPxdtK2VX5tzHoQbUlk7uk1EOpoP2QXNn?=
 =?us-ascii?Q?T3i+gRJBWhpOmgfxRjhZ7n1oU0iT9hy7zhgcHmpPQC0ZYnYjhma66EUKB1nT?=
 =?us-ascii?Q?Krvry6kkHGIaBke2SO4s4UfFCXZie/AUhYA2Tm+m4zbURK/iLr8seiSrUznX?=
 =?us-ascii?Q?fnNuxPXbZ62nBzxbaEop6UCSsLpleLVdZgEB9RBZyVRXT26XkfNs39bsLsBf?=
 =?us-ascii?Q?s/Ip7g/Ud0e6KqARte3SOCgm9XSzo/KjFIdPifK1MxP+Zic95zSujY/nA39/?=
 =?us-ascii?Q?7gD3sXBBWhXUsjHMmaGZLz7QruGnFkShy3nYHMoLqrmD4BtQIHbOxy4zATIC?=
 =?us-ascii?Q?/qdbL0jaKkxKvo27Nybr+k3/E6oy4BM5QbQzB4SiuN+M4XDX3b93R9ydr1VZ?=
 =?us-ascii?Q?vWydj/ho+6IcTX/q7C3303AxEqXd5r0ORBuapFAL6RZTCj4LLwcYrpe7n83i?=
 =?us-ascii?Q?wEFxc5RpPJ0J71qh8Hdex0E2Nie7NckJ9gfyYURALuAy6BF3ZGeUwwam7Y1/?=
 =?us-ascii?Q?lA+AWmI5bhfkV4J8H1Ltpdu6LQ5bsfFK3CTx8jtmQIOgZuk4+aBip6bsDLeg?=
 =?us-ascii?Q?rwqc0RMWElD2pPRqZ+HFHIUIHXOGkjpgJvUuh/Rid8TjXy5LnJz1SrIOUHYN?=
 =?us-ascii?Q?1XIrdYl3shxI18ZXyBbxoXufCoX7s+Z1gjNZ74TmoO7ORDgBmXuE9Kr9J6Mu?=
 =?us-ascii?Q?sEJ4w1cBm/f+D+0rx2ZFbFiKKyKiz5SShesR4egT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EAJVrM7SIuPu1iikTnSHsd0YfKznBVoUdBV23QEABIX7AxXQi5pvoh73dtXShe4qrrxYbQY0eV5akcPzWG/AZ9L8WlVWxU1cugF0l9ce2FJrNkbyk1QK6Uswz7UK9H9APCHl7T3/NXwxrSDMySzDwUP8+Yter4kfrFrIVwv/S4voZFjJMC3ETzLasZn6DL3wFSM91IZczQ306Cav7ZdGRTBKJ1IKlKvUx1Z9Klw1dx946PerR1ipvXNibSU3DfmK19+22+kHJAccfR0uyHjVP35ENBngLyuyKgqb1VqpEnaV+rJgw2fZQ2KhMmGljhlenSmTkzGrrij2s23nj+ZenwkX2OhqWV6rgfHh0Sv00xAwXhwgkftfDGZ+iTC4lpv3KOt2Co3TJilBrQI2Ur+daix05mEctqWY1YIu8XiL1anrQDW6I7Hb1lzfxxMEToEBhAkxvjzaigHguHfYsNGYcT6mPHvIpUpvQrIluKpgy+pgiBi+YJmMi9NR/3UTHvDP1qy2EapkeRIYVObTFJdin7gU8y2oDjFAcEswzQpoXdZrmOGpTGKsQNKOv2oqWTRO1MTpkna+XFnAq4x01DqDNAyIkSgTqFi0gifaAxj6Tx8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84ad001-cff5-4cb4-1815-08dc3557d1bb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 16:44:07.8422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKyAumVDs8MEy/ulgYgRyVsokcKn86ilMI1+QIegZtHu5ZZoXMiDrzEFYjstFsI3T56Cs5uxZK4UpIkZh0s/8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_12,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402240140
X-Proofpoint-GUID: DZsNAZ5QVp4e76LTUGVUu0KRsFi-5VYR
X-Proofpoint-ORIG-GUID: DZsNAZ5QVp4e76LTUGVUu0KRsFi-5VYR

For easier and more effective testing of btrfs tempfsid, newer versions
of mkfs.btrfs contain options such as --device-uuid. Check if the
currently running mkfs.btrfs contains this option.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
v3:
 add rb
v2:
 Fix coding style, add space before grep
 Fix typp option -> options

 common/btrfs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 406be9574e32..55847733b20e 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -88,6 +88,17 @@ _require_btrfs_mkfs_feature()
 		_notrun "Feature $feat not supported in the available version of mkfs.btrfs"
 }
 
+_require_btrfs_mkfs_uuid_option()
+{
+	local cnt
+
+	cnt=$($MKFS_BTRFS_PROG --help 2>&1 | \
+				grep -E --count "\-\-uuid|\-\-device-uuid")
+	if [ $cnt != 2 ]; then
+		_notrun "Require $MKFS_BTRFS_PROG with --uuid and --device-uuid options"
+	fi
+}
+
 _require_btrfs_fs_feature()
 {
 	if [ -z $1 ]; then
-- 
2.39.3


