Return-Path: <linux-btrfs+bounces-14528-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 535F1AD0142
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 13:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB843AFF5D
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 11:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8787287514;
	Fri,  6 Jun 2025 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ECNi+H79";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UqJFn/Id"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D64520330
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749209744; cv=fail; b=e9P0qhpo6yUrrgHou2cIPoip+kHJ80diBx0DS+q6Ftpu1aI0rKJweSTSQlB7mAFrBRuJ5OIiOhyBNrGGtW3UODxDFgFIV9NEuZFUChZVm45H++ncHasAzcczGJK6B+858/16FcPIHg/4SijesFndIJ0Vy9x1fCaoAsBY0bt0iXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749209744; c=relaxed/simple;
	bh=xr+cVp71s29UdIuDLV7+sNprKERqKa39hqSVTSO1zNE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N7Hc5840PGROS+Z8MABF/wDmk7cIG+tuL6qof3KJ5gzfNN/Dv6vUhGqvAFDorb832rQyY7WU7imLXeUCUtOVpKXFQ/rY6MueBfSntRD47zOUVq4SROVEJpasgroS7m/mdYSvv90EBV+RduwpCkLGVG0P5IqWeiXJztXa6w8hpRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ECNi+H79; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UqJFn/Id; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5565NDHO032742;
	Fri, 6 Jun 2025 11:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gjLp8xY6XcUC0fR75Vpa/MkR7K6thNbzduUkTlsDPWc=; b=
	ECNi+H79XnhOVMy5b968Hbh8SGmUjV6Tt6KyMkRiXxdgjqMNhCA83NBt12RWZ5tA
	Pj68CBNjxzmTcgVnoSbl4ZOMogCtyB00MKJ/FFsw7uKKcFeRmUfjpTH2SBL1Y93L
	A8HEd1E+grz9gvk3kTJdr/IIk68B1TTdpIz5pzpTVS1niNWmdoRLg/tsQ75x3ktx
	fQS3HoXefxL/Bp/Y2hvC4KrcnCfaQAvzuPX9Grwo19v32jUioOyw/I/n//naNF9c
	2haR2/XprkIKrAJ5nlgpa+VkPSBULe8bxAyjtumk+6+hfpCzmUtXRguW5eveL2Db
	rqQMFLgAUO0IHcxGx+OfjQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8cyujq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Jun 2025 11:35:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55693smF034871;
	Fri, 6 Jun 2025 11:35:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7deg2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Jun 2025 11:35:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OoAuihrE4gSIwJruzSF28qCy905XQ2gsWzTCRqYcn+BnIXyilAB0h3547bIYVI0L1TLdwEfE+rEd/akb/Wc2Y63u4f1HlTu+IgkBnCm/TWRczudzjA96TzdMnQAKihuWvLwvt0gJAsdEQM0xXDIFabBVK97C3IhfYPMmKsyFZmp+3VgcJ69zhnyfTiYSLd6K2R7l9xkitAboC9im1UaODxNEyBSBR7F3N5vlKby2iqRTUVu2Wy5+9XOyXLB11OQ2W13IjGbytbhDWy7BwBOuDjIiGcbMGQI9byzFKks+CxE6E6a/aCZ4bV16K1vCBU8Ue1xPoq97S7v0wO7jXHvDew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjLp8xY6XcUC0fR75Vpa/MkR7K6thNbzduUkTlsDPWc=;
 b=jqMdHBGv5sMnsxU3K1f119AuNBBVdm7h5EWGGm1jN0NNORZ8vTVcUUeaBdukYMQAEGKl3Dfud60mo3MVG2zyAMdLf5gkm4siA+q/vkTAO++vu1B9RaDnqf8Ru3UCXBJEO1wkbp9dpdEIocEAyShnyl5TGb29dNLD2gILVlO65xQiRYCwmbE9DWd3kOloy1+rGQBeiTfHOT+QDdafPI3cKCu4aS64bYcEKSjRy2PehWeuxWxStKJU6uKHnY/mGrlWvKqe3XrTbZf7XDsPQPVFSAh5YnKIt29zEfG+xYC56K/1BIW07N5H+SHK+8hKF97ehnyFfWCOB+B4pDVFz6Q9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjLp8xY6XcUC0fR75Vpa/MkR7K6thNbzduUkTlsDPWc=;
 b=UqJFn/IdPzSHmLAQxJeGfwT3LRshrL9YVIqSP4DBy6ZNy1F83tpgzEACICQ2l0+MxxYa/CINYi4J3RaikCqi0b019F7DqYkh239+qPYkhJXtAn1v/2W2JnBAqMPcXz4+FE1Hu8gcmOL82SFDCPORI/Ct8wiRMgk18moIzTDaoFU=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by PH7PR10MB5855.namprd10.prod.outlook.com (2603:10b6:510:13f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Fri, 6 Jun
 2025 11:35:37 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8813.018; Fri, 6 Jun 2025
 11:35:37 +0000
Message-ID: <e9caaa0b-cf98-406a-83f5-b74ddc86d120@oracle.com>
Date: Fri, 6 Jun 2025 19:35:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] Return variable name unifications
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1748621715.git.dsterba@suse.com>
Content-Language: en-GB
From: anand jain <anand.jain@oracle.com>
In-Reply-To: <cover.1748621715.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:3:18::20) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|PH7PR10MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: ce72368f-669e-4174-5929-08dda4ee41ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0h0MmRGTXRFMWd4K1EwL25HVDJwVGlUWFlhSFJjQ0dLK3RqeHlaSGtMUXBP?=
 =?utf-8?B?UVlFZGRNOVBwZWt6Z0JVSnhWbjVxV2E4MXhERFdjZjRaYXdoV1VsQXJrUkVi?=
 =?utf-8?B?L09BUzlQeGdWNndPVXZYQitRdE9tMXlaMExXN1lLeDMyU0JIRk9iYzYwL29j?=
 =?utf-8?B?NWxtcysvL0dUK2d4M1pLck53OENOU3NvdXZTSFd3bjRYMkdwNWdZNWY5bGNx?=
 =?utf-8?B?N0g0dTVNMkVQZTA3WmQybjFHVStMV2VpVkNLVTBhdDU1TEF2QzgwRmhPRHN0?=
 =?utf-8?B?QkQ4YTBFWU5XbDVxMC83WWxiLy9wcGg1WlJUUmxWN3BDbkNEaHJCemRwR2tq?=
 =?utf-8?B?Y3hZN0liTW9qb0RpN1E4RlFZbWx3K1d3UDg4TmJPNFNrQzVkWEYrMjQrMmQy?=
 =?utf-8?B?MGxqck5SUjIzUGFzTlBRYk9DaXUwQW80QUdIT3Z0ZXBFZSttSXJMdkxBb2No?=
 =?utf-8?B?MjBjWkI3NEw2OEdYTTlOclg0OEdXcWtyVFNISjNjYzBJNDRiS3JJbmJ5aHVT?=
 =?utf-8?B?Y2s3L2lCMkllaldBa0RYVElyYWlkSmRmSzB5MnNhRXV5Q3lSSjdwQXFoUU4y?=
 =?utf-8?B?SFJpaXhMNi9KVTVnQ0doUWFQa2ZLb0FpVkFDOVd6a3E3WnQ2NXQ5TlJ2UVVZ?=
 =?utf-8?B?OXlPRGJNSktsd2hmdHNMOXc3OGljN0dsT2lHdnMxdDB1TUJDVWhTOWQxaDZR?=
 =?utf-8?B?WEZpQjhFSXp0SURLQ0pYL2syZk12ZG5ieVZZV0xMb3VsanJWOW9nTS9scGFE?=
 =?utf-8?B?dVZPdlpUWDdhcUQ5SlJjWDloZ01QZHNoZGNWWjJmc2tCWjgvei9KbjBWdllP?=
 =?utf-8?B?Y216RmpuNlFBUlhQc3AyeVFQLzZISWxTWE1jWC8vUFc4YmlDR2xBUGdmVVl1?=
 =?utf-8?B?c2x2eUR1R2IzWDJRVU41aXMrbEJxWW51WW1va2E0UWRVRFZNQnU5Rk5jWVBm?=
 =?utf-8?B?eVVDcFZPRkpqbjFwVjJ2YlQ2UlRjaW1sR0JOWnorNkwwK2JuZmcxNUNGTUVr?=
 =?utf-8?B?Yi9pUzZJclFOS1EzR1lqK21FelZSMkUzanl0Q0lFQllMUmN5Rzh2N25pZy8r?=
 =?utf-8?B?djg2djliQjk5Qk9UeTJ2RU82ZmVvc004RDN1TDZlU0JHUmFPRXlWZXRhOVhp?=
 =?utf-8?B?M3A0SXJjQkhjWW5BOHBNWXNUNGhJQWVWV3FGS0JpWVRsUm9VeG9EbW4xN20v?=
 =?utf-8?B?bUgxZFVwU2JIajhtTzhtWFNSWDd0TDVVblBVTW5EcXlJbmNvc0lxZmxWdFhV?=
 =?utf-8?B?ZU1URWdVVUdvTGRPcXRSL2RTcFF2NW5nOEJxbzB3eWI3Y214SXZWc3hNU3Mv?=
 =?utf-8?B?T2dCZ1NxRnJzMXFDME1XbXYzWHFDV2lTNUdmVHN1dUQzY1VOT2VVZGVqdUZo?=
 =?utf-8?B?clNhRkxEMXFBWDBSSGNvTTY2RitIZW52UmR4K0czL0szdjRxSFhXTzBFMFlW?=
 =?utf-8?B?NldQd3NUT01UUU13RGtKd0VkbHBraUZjVHczNXdVRElPc1A4dmtKNi9zak0v?=
 =?utf-8?B?MVdaSjRGcU5obC90NzRZYklFWFhRSHg4czU5SjNMaEFIcGFMTnNHdUVEb0lT?=
 =?utf-8?B?emZhVGJuY0NNRmRQTEs1cTY0cW9zMFN1L1hDMGJqM2lsalZYSTVSTlZBN2hG?=
 =?utf-8?B?ZFlNeGpad05MRlhxV3FYRXZTemNnQytEVE9TNkg4TGN3ZWJsM3ZJR0VOQTE5?=
 =?utf-8?B?a3NtOGd2MmZlSWkwNml5V1RRWno2ZXZ1MktNYkhZSjN0ZDJoZXdRU1g1OUw4?=
 =?utf-8?B?S28rSVo1NU9RVmxZS1c1TEt4V0t3WjkvdDMrRGlKY3h2TFRHZTBwYUxRM0x5?=
 =?utf-8?B?M1RBMENtWmI2UzhneWMyaC82N09VSjFzQ3ZLRFZldWdEZGhjWHdyQllxdlZP?=
 =?utf-8?B?ZzhTQjVvNzlUNnd1WEsyM1Z4MlJPVmpMY0xCOXJUL0drbVFFSVROT1FXUVNw?=
 =?utf-8?Q?XBU7UUj3pn0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czdaTitjaXA1ZGJWTVAwYmw3d0Z3MnZRcXdTYVlPWnJRZnd1bkdNSW8wcWxX?=
 =?utf-8?B?NlBNVEg3T2dleHVWck5qeHZVa2RnblJmcU9zb3RwZXJJNDV5YlhUMWttd3Yz?=
 =?utf-8?B?RHZzVXo0OUxDN1ZkWGtuNGdYOVB5azkwNWpVQlZ3YVUyZS9XM1ptc3hjTmhj?=
 =?utf-8?B?eEowUnFmSVpoOFR4RjZkWkpKclVsTmh1RHNORFViVnJvT2xYMWdqdFZobkV3?=
 =?utf-8?B?UEJ5dHFtOGZnQzVFUXR5cEZBTjMvb0hFcUYxUFMxbXVNRVhqOUlnVHFWZDlS?=
 =?utf-8?B?a29jMWQySjZ0MWFtUGhIZVlqNWpXTXJVVEkwZ0I1Y3MydHR6Y0FTT1V1ZkY2?=
 =?utf-8?B?akdqSTdKeDVpbytkYStiYzN2RVNScVJNQUsvbFVrL3RuWGJ1ZUhMR1RhcHdZ?=
 =?utf-8?B?bHpVWk9nWk5XVHN5YTJYUlFkR0E4eksrMnBuREFSUUdqbUM4WnV2OUc2TEEr?=
 =?utf-8?B?VHFMRnAwaFZFMms2ckNPR2t6WFo3OGZ1REwwRlEvNmFUVVNxcVU4ejAvZXIw?=
 =?utf-8?B?UUg0ZHBsMm91Qkl2enEvelc4TS9nSTRxNTdITjBReEdhWk0xazB1a1FySUJs?=
 =?utf-8?B?ekpyc2M2ZUxqcWQwaTZXV3FtZDJlOW9CcXcwbkZ1S3BBRnJZVWF5NlFYc0ti?=
 =?utf-8?B?QWw4Unp4YWEyZnZmMUJOb3I5MnhCT09IWDR5OVlJRkdVVm5KNWFvbnp2cUdI?=
 =?utf-8?B?L25pcXZqNHl0d0w4UnJKSzR5cDJyOFR1U3A4STIwaDVvUHdHcUcrUUdOL2hr?=
 =?utf-8?B?OVkxaVJtUjJIMSs4N09mQmhscHpNRTJGUTVvd1R6SnVvY2pDSkFMdk1MOFpt?=
 =?utf-8?B?bmhyVGtPd1Vmek1XVkx5VEY3RXJRT2RzcFdtbzEzMFVKeWFXeCttcXcxNEtv?=
 =?utf-8?B?M2hOTStQOXNUZ1dFVEY3YzNnK25tbm83dUFoaElNeGNMZzdkT1BxRXR0UzdB?=
 =?utf-8?B?S1kyeUU3M2FjM2FBbkNrK0NSNDYvZkpHa3E1VmhpMURkeGZtQ3lMWWd1Wmln?=
 =?utf-8?B?OTVES2lNTjU0aDZET3crT3N2eG1NM29yc2JsNTJIVDRlNzVTcmt4MEtVdHZq?=
 =?utf-8?B?am8wblladWdud3Q1YWFPS3UrMjEvbVVUUUlndW5JaU96a1g4a1hzdjl1SXFF?=
 =?utf-8?B?TTUwa1pyeDZyWmYrN0NyWTQ2S0dhZDZzQW00VmVnejNYYmE3UTQ2YlB5N2Jp?=
 =?utf-8?B?R3BRV0s4WEhGRTBhelpBUCtpQ05OVGtueC9pTm1tS1hGYlhZMU1vNVd3VWE5?=
 =?utf-8?B?UDNzQVg2bk9rWXBNTEJKWHVZR1U3VXI1dWFnZ1FDQnN4emwwWUlNK3F3ZDJH?=
 =?utf-8?B?TVlZbzJRK3hCbmE5SUJmYno0WjNaZHdDUE54SE5WcVRXMmNDQjJ3STdXdXl0?=
 =?utf-8?B?YWVrR1NnWFVrNnVLdXRIak5YelU0enBRSUR1Tkswb2E3dC9ZWVBJM2pzeUY0?=
 =?utf-8?B?L1RVYmhxS05zejB1OVhzWmhHcUhVQktmMHkweUZETkpTaEpnWUVER0hBQmQw?=
 =?utf-8?B?eWhUaUI3cm54ekd1b2h5cHQ0YmV2cUJVNlBGdDR6L000WkdmOVlidTBZWDYv?=
 =?utf-8?B?WDN3eHF4bDFtTDc3allwcDI4aXQvOUlZQVVYN0g1NXE2UXBiRXhKMzI5NWJs?=
 =?utf-8?B?cEJBVlpWVjJNNy9UeW15UHhLYzRZRFFRbnZOYmJucHpNU09JTDdVOXRDeXcv?=
 =?utf-8?B?cXY2bXlSck5iUkdjUjVvTXRNSnVrQjh5YktMMWM0cTBndUlWaTh4WG1jN0Fy?=
 =?utf-8?B?QndhM1hBVnNIbmdmZXJwMENWeVJrc1FIMUV4d2NkY0FZOThFdjVhby8yUkJw?=
 =?utf-8?B?TWk1QU9GNHpDdnFocU43dWVmdWVRVnk4VFJwRjZIejh0S2tZS05wbjlSY3pU?=
 =?utf-8?B?K01kVjBxZUhEaFluVmNtYjdxd1J2RUtwUGZYaXZuR1hzYjVXVFBSWWJ3aUZN?=
 =?utf-8?B?dWpiQytqNVJ6cWZ2N25TQjBqK3Jnb1p2TjJSNVJScGFpMUlodjFINTR6YVov?=
 =?utf-8?B?c0l4U2t6ZzhhZEpZTjdnaU12dURmTmluVnF3akRRc0dSSnp3WVlIVG1PNVBj?=
 =?utf-8?B?aEpaUnN6dy91Ti9QeWhLVEVjNzZ1MmlvUkpRQ2EvTy9uNEEzdVhtV3R2NVhx?=
 =?utf-8?B?UTlNRlNuRXNEcWdZQ2dsamRBQXRVSWZQdEVyQmhLYnhQMHFpNDZLMmRqaEgy?=
 =?utf-8?B?MGlWdU12T09hM0dRNDJaY3RnZk1RdUNKOHRsV21ZTzNDdFdLSU9iNDRkZGpF?=
 =?utf-8?B?cmNFbHBkdWdaaHVXUzhZdHd4OFNBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h9oO6IxTjDAg3hJDLvMKSU+S51uIqhjYXnNYM0I31GX+NjfqcEikvgsK+aRn7T+6qCtrWioMpL4YbreEFoCECmvAsAbuAsgTjN0OYyv9CsshhvxovYek/9wriIJC7FwyPcwNs4p1ZoyuDItPdMR+y/Vgm0bOxRLU19gMIMMeuSEyvCOkKpz2iO5+E5Wwtl7xYLeCEbEKNGKESVXS9GX1toaevGG7p894dI0NLiVzSi95H9TBwWJ7xD/dVdqkvLJDFMYpydTzaHuC7Ig+YNwnVFdl7ON0Ku+eGrIoa/gS+uxRHPaYluictrNZr9ApZxpGUwLCkoHu1DWPp0sAolXa7sLVYNOHQRL8nGxxDTNo4WCkfdZA769+5LMLrg2XdIiyxMwo5LMEjwkWBFNhr7RcuvnFXWALuJDAIaRij0xZhX+eK7rYc9SEk9cr4KK/8OdsUXc8pm9S5Nm5x+TmC3D/HuZp6bvDNzlgMkn20Y3do4eXaRH5+XrNipdbjyvVfPyPTZIqFPP8Je6DXSbHkd1s90XfOCvEqkK8qPyLqoNadyZ+//x1A/Ndz/nEixj/10uyJXwDFazp6mahodR4jngRTHaNA5RSTVkT/6Uy7Redtxc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce72368f-669e-4174-5929-08dda4ee41ac
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 11:35:37.1562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7E1X5Tg75gMpGz3Ob9tGZAEnZU+Vm5+EsUYUK0IKxPPuQP3s2uIRDu4uYccTs7OkqvmCU/14HNujwqApSJogg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5855
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506060104
X-Proofpoint-GUID: ZdCehjrzoHF5aN6EJLau1fsGPSL_3_FF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDEwNCBTYWx0ZWRfX5tf4sYbhK6v7 ANkWw1J+p9GTCs5u+XYFa31pgXP0I8zLz5Ut1wTcaX/nBdbEI2li1EJYU2oxxvM8YeSMlq+ATfQ 48pNw5d+1ZZFhg71MiiumT91yKc8Aw5Gf6swBS/nYO+rctSDfXfuuW+mAx6M9m/JxA4SXNJ1TcI
 yK4aylAkMTcaUuK7LZ30bwC7hRQ0bvD9+rQpy0mzfqngfKKXOgGt+JEr4+eXeyy/fAMkh9KjYBY 1Zt0sR3FPRr2M/duHaZow3Z/F4/Av18cglE3c5oEeg2XL4NE0sK2cdNRRNKRBFUgSNo+OtbtbKD Meb/0/+bSor26QiVRlarCnXUEPNAyYk/tcQLldQwhpXbin4cjN5O69LraO143aX0OOjEC1A00K8
 QT9NdgNh1c9k9Ep4NfBdVXklIz7U7zd1s/cYzrVuux2D6tnjd0fctKdPIRMQrPdUKP++r63x
X-Authority-Analysis: v=2.4 cv=KaTSsRYD c=1 sm=1 tr=0 ts=6842d28c b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Gr9rV1SeKoAkpdPwk1IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZdCehjrzoHF5aN6EJLau1fsGPSL_3_FF

On 31/5/25 12:16 am, David Sterba wrote:
> Simple conversions, 'ret' from 'err, or the secondary return value ret2.
> 
> David Sterba (22):
>    btrfs: rename err to ret2 in resolve_indirect_refs()
>    btrfs: rename err to ret2 in read_block_for_search()
>    btrfs: rename err to ret2 in search_leaf()
>    btrfs: rename err to ret2 in btrfs_search_slot()
>    btrfs: rename err to ret2 in btrfs_search_old_slot()
>    btrfs: rename err to ret2 in btrfs_setsize()
>    btrfs: rename err to ret2 in btrfs_add_link()
>    btrfs: rename err to ret2 in btrfs_truncate_inode_items()
>    btrfs: rename err to ret in btrfs_try_lock_extent_bits()
>    btrfs: rename err to ret in btrfs_lock_extent_bits()
>    btrfs: rename err to ret in btrfs_alloc_from_bitmap()
>    btrfs: rename err to ret in btrfs_init_inode_security()
>    btrfs: rename err to ret in btrfs_setattr()
>    btrfs: rename err to ret in btrfs_link()
>    btrfs: rename err to ret in btrfs_symlink()
>    btrfs: rename err to ret in calc_pct_ratio()
>    btrfs: rename err to ret in btrfs_fill_super()
>    btrfs: rename err to ret in quota_override_store()
>    btrfs: rename err to ret in btrfs_wait_extents()
>    btrfs: rename err to ret in btrfs_wait_tree_log_extents()
>    btrfs: rename err to ret in btrfs_create_common()
>    btrfs: rename err to ret in scrub_submit_extent_sector_read()
> 

  Sorry for the late rvb.
  I vaguely remember sending patches for similar changes.
  Anyway, no need to dig into that, the current patchset looks good.


Reviewed-by: Anand Jain <anand.jain@oracle.com>


