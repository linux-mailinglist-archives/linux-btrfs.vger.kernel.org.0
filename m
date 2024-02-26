Return-Path: <linux-btrfs+bounces-2766-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3392A866A23
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 07:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47D33B21729
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 06:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BBD1BF27;
	Mon, 26 Feb 2024 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CtigOxWC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NIFzdVOL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82721BDE7;
	Mon, 26 Feb 2024 06:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708929383; cv=fail; b=K5FCq7MgylMkEs/CAC8gQ9d9c4WBxPeHjlVEvPS/tRrRWi6aWheHAHk+MhCG+q40G1iW09qiVtkQRVHVbHv9MrwMlWDik3WsX8AqcQ63ozPrZ6lcTFVJ8aSNW5+eNpFTkInPdG2IbsrVZjp+yC34X6W8gjJM8lUqFPXmUYNI62Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708929383; c=relaxed/simple;
	bh=wa8jh7RuphnMtHceFGo5UXOek4TdR70oJPpuG+QHW24=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SJsybAnUQ7iJ9e9BsFRm/nY7jTnkL4evTW4nU8YEJ7A3ErAwziB4nDIVQWX3hKXwqecX8SSisEkrqkek+73+ceXeT2on6wid3qXGvLnRJXX1duT1CpKITwO6CK+OdkST7puedY7c1HGDBvt1F1zBOiy3ZSW4uvESd3KF8Qw6/bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CtigOxWC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NIFzdVOL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41PLPoYE023296;
	Mon, 26 Feb 2024 06:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=cf8km+QXILkiHj5wQE5L0w5cHLVJsW1gpa9AIu4Chzw=;
 b=CtigOxWCD2C61X5l7x5MuFUDETw695qjpxmH2H0FmQDt4XfnLzEIk1b20o3Z+ubOR/Zr
 xIACNEU/0wdSnjLwbBwzuC5cD4k9XBlkIvwsswnMS5FLP7h6dXlzKD8+s/PINNyNdCiE
 AB5lHxbhj3ObUOBy76U/KTyB17HuuduN6I1qjt2lVBDr6gwJx4BwPqfzxthJo1bAF0xU
 w6FMbosFok55w1+77oh6D8w1t9gcFmzG7/L/5lhwHggl3bJSQP0D6Cgm1s6sa/PPJsum
 swUD37fqULG2Div2W1c/96xouahbSdHx6awzGDg7hnBNqZ0mjSfejxjccQDUbRx+z1J9 iw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7ccbr53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 06:36:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41Q5GcYZ012720;
	Mon, 26 Feb 2024 06:36:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w53cgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 06:36:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOJnUFU4CasZZazYfHSBzTuzbd0jUj5diJmC2HK0JnpbpF7WvtGrI/ZtdxqSoWpc7VZ0vsemRUmVLtagXP3ivm/l7ZPteiV7uEgaLfnjOPEKzPQtfvssh52WX1iHgQvBgYWxCaQ8BG2OO1XElUkQDm/aDWjVP0+lIRkJTw7E09KALCt8f8vziisoPSL9muptWY8nDvPvIKZyWYzkSgtNaSuR/Wp5pXZbx9lP2FrP2LRTRasoUrFFe4jHTkgiXzQP5WLKR6EAhhFZVQw92WvNK7mr4QbvfJBO7jLFyo6M7iIe8g8Zsvayr7QoXxMoku+121qWeeNL2/WWuMXDnQJM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cf8km+QXILkiHj5wQE5L0w5cHLVJsW1gpa9AIu4Chzw=;
 b=fj/iX9XADI+VNkDT3BN6rYZEvg/174HW4lwZOd/Onjxqi/Peyt0FumS0zHvhv0DydDhOTzmU1rMZVLD9hnVyLDxseWUFrmn4ZlrIWgGBSosYuiJ4DQx8JB5f5xnmBaL37WBvlNsld4EQeq0QeqTMQwSGImAM3lEI6davofySC1wXXZ3+Bg7D6dy+EtjUYmHvYsNsik3jLnFpaBZvfS8gQXYfkUTzKJ+wzJ7bvpuqDmyHdvgyeOnorpfAl1UFdqhtKdLgMlEbVK7KRjjHSC0gDGH0X0/7nQmQ8z9YhCiOvQtgCmrukNGEP1lT8oFBdQGBn36Tf7jLDc62eL0fdPSlDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cf8km+QXILkiHj5wQE5L0w5cHLVJsW1gpa9AIu4Chzw=;
 b=NIFzdVOLAhfS0biR/OrezAZvJDDt877S5/+579KwwgYx1NYZhWL0uZMF1whlxY9cmOtNAwJ3GdDoh3fuk63e2ueGS1rd1ZCmdLdGaOyOVzA99W0vgjz3csz/3tre1nptpjI6soUB4uqjdEquhDZtI8rL5cZpoB0cTB3MU2rc0uE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB7497.namprd10.prod.outlook.com (2603:10b6:610:18b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 06:36:16 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 06:36:16 +0000
Message-ID: <9ee33bad-717c-4d6c-9fb2-0ae579bc2370@oracle.com>
Date: Mon, 26 Feb 2024 12:06:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs: detect regular qgroup for older kernels
 correctly
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20240220040134.81084-1-wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240220040134.81084-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0023.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d04d453-91b4-440e-cb91-08dc36953bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ThilGVzfIemHI9cyu7DyXAo1mzF1ZJp/qN1FhOStWYQBeAVI8yUym0FKTbAQT7Il0RL9JACcp5ivBeQODo+bCh5bZivxg5C4ZoDZYWeSaWEJctg+CL2p1GAy3MkHlDJNN8JoSWxpHEJvMR+mWWEtV8UtnUDchneU8UEv2YQpUechxtkq0isLhVOuaNuMn4m4T3OQ6d/wRs6SvxwvEMaOUJmjORGREDfLL8yEyQWv/6MwrhOkB5OW7yULLvaqo4SqiiI08w5mBmDiIH1bgGL5tJDV5wnUASNZdkXgaeGhA1fYQSZUV+7uIsBChdZW2/KHd4a4OJQ4/P1Q3E+CTQbvCed2N7fljrzvmnIrlQQ+Ga9P700oaGGbO1C2SqSMVdfAtzNJUXSVxYwHPFhp7FWP4C16vvXhgYDg7h3rtqjinzhqSFnyQKNH7cjuDIHyRaJy6bIJrdmHo2ihypbx+qPssLrmZuL3xaVPTVT6TGcVwiqNdbVgPXVt2RAKIoID1l12EDfsQA0KxO6MTToKD7xmDi2yzFZnmMAt1eS3joWyIEIOQHVkfaOWtyo3jNQWThy421oysH1B8EW7TQlcWShjTFbgUBwkMvNh3e9gPnfUgU9EtkNE/yMuRlE9gHCDDW7mcI2I3auulYIyxTglVBNsBQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bzEwQ1QwOVUxNXNlMW9iLzR5TmpwZmJhN0NUUlFOcE1DbFlTMHRxVmlHbS90?=
 =?utf-8?B?VWVob3BXc1k2T3llNWJoemNDWWJYQ1N5bjY1Y0xVdjQyWG5zTGlSYUpJOXFu?=
 =?utf-8?B?UXhwZnN2WW1wWDVlcld2eU8rUnhsZ2xncDVPd01EWDJpa0lmU1RaZ2V2TGt1?=
 =?utf-8?B?eVZ3enR0bmFPSGhtUGR5QmNNeW9vRVZGUXNwQ1VuUzZLWitMY1d0dlNjQlVy?=
 =?utf-8?B?VXhXaGd5UWxBR2NYWTlhbVZpVVNiUWJzWk5qWldvK291b2tsWHZCVk9yUEY0?=
 =?utf-8?B?QkJpOVFGYzNQMGJLOVF2aXJCMlduMG8waEEvclhiaFRRV2tMRXdva0hzaUg1?=
 =?utf-8?B?K2RIL1ZZd2doZlNuUXZESmFlVHI1U1NPVnVRayt3Z3FUNkpJR3pkeVdoelNw?=
 =?utf-8?B?dGphYXcrQVFFRTlLQzJFWkxLZVVqajFtRGNXK1hwU0REc3BtUk9MQWhuK0pt?=
 =?utf-8?B?REUrNnpTNXF0WlVKdEh2WVg2cXRjS3lIQWN6SEFjZWg4VTZFYjZqSnZtYnBz?=
 =?utf-8?B?L3Y5MmEyTnlPS1VPQlgrYmVLWkV1Uy9LZVR2YS9zam5vT3YyNmpMRDB5TFpp?=
 =?utf-8?B?YjZTanM2WUEvNFVnWlFLMTluN2FDenVUd3g3VTBvRHgxdVdQdStHWXhMelVn?=
 =?utf-8?B?eXQ2QmVvamk5cVBQTjRXLzVCdXMxL3Znc1A4Q0h5TFlPeUF6SnlQQlhBNUgr?=
 =?utf-8?B?VXlUOVhJSVZFcjdrK1J2SEtFUFlXTDRaY0s1NURRRHA0eVNWMnpNUVlhYWd6?=
 =?utf-8?B?aEt6dnBUSXgwOWtnTWNqZ01lN2cxVjUzVkZiNlRQeU5tbnBYUXFDS1pBVjRW?=
 =?utf-8?B?S3owVVhHeThLb1Job0FvWGdtWkpocldHUDc4U0pHMDRXY2RzdGtjTmR2L0p2?=
 =?utf-8?B?TlRYOURKSzE1Y0c4MlBOczBpY0RkWnVVMVhOMk54ZGZRajBKQzJHKy90ck5m?=
 =?utf-8?B?WU05ZHczSzRtbDlzbmt2U3o3emtLdW1pOVkyc3U1NHBjeEdlclMxS2ZSR01T?=
 =?utf-8?B?bFZQcFp1dUU2b3gyZlNoQlNaNEM5aURCa1d6SmYzcUJDVmVNSWFPZFgwYTEy?=
 =?utf-8?B?WGg4TGt6R0ozWlRPZkNmUXZRQVZLZGMzek5uZVB2dm9rTjNBa3FVWXdMZGlv?=
 =?utf-8?B?S1lRWjlhOWtrbGNyZ1ZxZExpMVVCdW9iZTE1akZaUlJsV3dURWZUdWNNMXU2?=
 =?utf-8?B?RnpBQWx5UXlwU0l3UENiU2EzR0d4UENDcjE4bHBVam1GYWtST1FKZllOTjlW?=
 =?utf-8?B?dWs5M0FvOTh0NHJSN0pLa0ZoZ0lsem16TDdXZ3V3b290NFNUTWRXTkk0Rm0r?=
 =?utf-8?B?cjZmNXRWVWZaSzZXQVlYUHVIcm9UaEpjVlhyMWtXMEw5eEJuMTk5UVVFMHI2?=
 =?utf-8?B?T3pJV1M2SkRCd0s4TVZRbEVZMXM5YjVSYXZ0SlR3SXdHbEhQNFhtNlVEdmJL?=
 =?utf-8?B?NTdlUHFxY1h1VjVXTU1iTVQ2RjJ6WG9rbzFuRHZoUG83Ky9WVUFPOEdIVkpU?=
 =?utf-8?B?VlhCdUJ0UTNISi9RdWRITW5UMml5dUhCMTBXR0UxZEJrUUwreEFtdktzQ3F3?=
 =?utf-8?B?cHZISk0xNEZsSUdiWmxaaXlHZXVpRjlXNW9KQ054aTB2Tzgwd3YxWXdBU1Z3?=
 =?utf-8?B?R2xEdnJKVzNyT1g4b2dHM1c1L2N2ZFJpbGtRSGlmek1CSVNUdmIzM2x4cFNi?=
 =?utf-8?B?RmVMMThEMGJvTnhOck9KdDA3NnhVQ25xRHhBRWt2WnYyRlZIRTJqc0w3bUxJ?=
 =?utf-8?B?UmZiMGs2NDNHTXRKK05NUFZZWnJQZ3pueEczR3dVWDc1Z0MrSE1HQ045alN1?=
 =?utf-8?B?cEhyMmVXYURuTEt0ZEZoZGczSjZPbk5aS1piRXB3TUowd3lIcEZ4QzNQUnNi?=
 =?utf-8?B?dTN4U2g0QzdqN0FzWDExQkU2QkFhaVpMcFRycVlvaEtHcnZLK3J0endCMnpq?=
 =?utf-8?B?NGJnMjVFZG43WFptekJpVHF1WitxcWFqR01POEh3d1lRK0xPRVpESGtxeklX?=
 =?utf-8?B?dkhZSUI3TVA0Wml0WmgrN0FoMktmN0x3aXh6QkptZldWZTROYWcxQ3Z4ZUdN?=
 =?utf-8?B?VWNiczFWREgwcHlaSFBaU3ZEM0dLQjNUNklYNHc2eDhlVE1vZjNReWwrWE0r?=
 =?utf-8?Q?PZgXm9syUt0eICT9fU+eMyXBv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6w1JKzlpO72QQzQYpORq2Px3lG+oKHvpbFMJAhNxwIMUwFvzcWqxAoL56tbHHcHBSB6lD5FDiVvZeQef9AcOqb+xboApRIZjfu8h+UBlEzynTA7sKTWjBkGoHKlIhZUOcb+aEMCb5Jr3WzmCdNNkKHeUFAcA1MKzwnQVTAQtO/ki4d+o33W6gjIRBcmB8QRogbjc7Rfsr1gySBEvy4M7N5vDOG0JOElXCO0+ufXJ9be3Or4nR+Y50RSs4OPHO+Y2M0dNwOKK03fYYf3ZyarLnnrLkXUbz+BQPpeTL7AybD76Jsaf+/MntghwghrBKDlYD1hjCEm4gEK5tfcAFhRirBwMkIQbDigFNr8ooQbYY5P9NjQONTruH7Liy89HHjUz8YNI/je++Wl2TWEjDlDujzbAcBJSoxEJNSrt7AfBUHh+AeS5MWWgxSV9C0WqAHTEvdqLBWqB0CR9FA+hIEaaDDH9BTulK8AZtcFMY9cLSJMpY2A7K5sxe4/PNFcFqMlcK/G5BadTJs22eQQY5VRdbFEw46781144omkbAneQSfGDTg5FZ54k7L0SzV8Kw6o8TmpvzWFzGz5YhnCDfyl9e0jwdo4i2V2J8IVldr5R0Hk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d04d453-91b4-440e-cb91-08dc36953bcd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 06:36:16.4295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tN8lQbV27WMwpD1w3e5bdC20Rzx/1oRpnFxBGTZs3YDmnPhAXbCCyw1Ec6p9k6Rs6MOSdsHmkiOq2i+IBQ03qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7497
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260048
X-Proofpoint-ORIG-GUID: V0yP-eYM_1-sd5G1aFyRLAtsf7Bdoa9d
X-Proofpoint-GUID: V0yP-eYM_1-sd5G1aFyRLAtsf7Bdoa9d

On 2/20/24 09:31, Qu Wenruo wrote:
> [BUG]
> When running an older (vendoer v6.4) kernel, some qgroup test cases
> would be skipped:
> 
>    btrfs/017 1s ... [not run] not running normal qgroups
> 
> [CAUSE]
> With the introduce of simple quota mode, there is a new sysfs interface,
> /sys/fs/btrfs/<uuid>/qgroups/mode to indicate the currently running
> qgroup modes.
> 
> And _qgroup_mode() from `common/btrfs` is using that new interface to
> detect the mode.
> 
> Unfortuantely for older kernels without simple quota support,
> _qgroup_mode() would return "disabled" directly, causing those test case
> to be skipped.
> 
> [FIX]
> Fallback to regular qgroup if that sysfs interface is not accessible, as
> qgroup is introduced from the very beginning of btrfs, thus the regular
> qgroup is always supported.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>

Sorry for missing this patch. Now, applied and staged for the next PR.

Thanks.

> ---
>   common/btrfs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index e1b29c61..0a3f0f0b 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -728,7 +728,7 @@ _qgroup_mode()
>   	if _has_fs_sysfs_attr $dev /qgroups/mode; then
>   		_get_fs_sysfs_attr $dev qgroups/mode
>   	else
> -		echo "disabled"
> +		echo "qgroup"
>   	fi
>   }
>   


