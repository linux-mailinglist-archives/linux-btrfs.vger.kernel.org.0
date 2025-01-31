Return-Path: <linux-btrfs+bounces-11194-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5684AA23994
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2025 07:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530CE3A6EF5
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2025 06:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6C11494AD;
	Fri, 31 Jan 2025 06:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y5vWXTnM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wFnyV0oQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A954D1F94A;
	Fri, 31 Jan 2025 06:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738305806; cv=fail; b=Rje4Nsjtyz/GOJ3hOW1J6OgOL6NYwlckD1UG4Lc4ol+yPxjnmAwHVgp3N1HfZy8qKUwURF1VuR7YG6h2q4hT+AWKjPPgWlKm7Igw4W9pKcF4JZnyWEGj8fTMV0Usp57dLJEo6AIMUuhGOZNdFB64R29harS+S6YWBBRVey0eTGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738305806; c=relaxed/simple;
	bh=GSbc+k19n0eIpTmBgGPbDAurHkYU/LOvQS4ZU/r3hrI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EAtROgl9mcSmB44PxMqDhZYW2Kl7vxbxI0KRsdB3GmViy7F63B2e58cOD7/xBCS0Ln0zfsitayNknij1LUSA36kgKoGPspDf0lAppY1GStQubUlQFPoMW0EKq2dzSGeBX/CL4Zc7HLiqRu7qV+Cge2ATH9Ww7Q8nF9gT/41BlKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y5vWXTnM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wFnyV0oQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V6bka7014448;
	Fri, 31 Jan 2025 06:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=NOuGV8jrLJKE+Hjja3J7kfyZ9zkqlzGEk4+hvYLIZUM=; b=
	Y5vWXTnM1q66lCya+A/rtG0DByUP6+KwXnYH1Hv8IDIP1MLSnbOdtelR8G30qRlQ
	75fKiZBQMO//LR2IM25RuPaYJxcpiacdoKMXAA4/geTmagmrgxA0B3jbUFX60GGq
	RrRaC0rJtuYTOvbHtEMtUiH2RtQT4CG5M+48szeg4Kc9x7oDTLXqbqw4QDOqbTko
	H1cSgft0Mf4vVkRyJiDotdU25tI5swf6xEieftcRSgrYy8By+7YOrmtJVmEsVcQV
	8EYkSzV9qhg1rlEbDocf05pp9XI/boFdCSvso3xOypZQrlx4Iz2jNcBQp3J7w987
	puJisg40y4AVfZGpyJaTvA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44gsdb8052-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 06:43:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50V5VXxl016732;
	Fri, 31 Jan 2025 06:43:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44ggvjy2kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 06:43:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMt7rCqcbOoALMmlPU1VgRrwvM0zzseILncfSw5nWrdJOqntv68ayg8u3xaxro6asenNwXS5kX6wYpHRuh/T39a3kFD8q9IYLWhtFv52iqbdfGV+nYS2jCBvPVFb/8VVZ89Aa9T6BGKRzZHxrRb+1Dbkcgtl/zfRvyuNenhpgan/MtjUC6+FXPG6x9al936ciUAQvmat1RpL5HalxC5hc5abS/CoWSFNSBQDZIkkcgXRHxjkRacAf7BuiKxBJUqMOw//3wmfLkNFFcRwh0t6KABMiBOhROb437hPnCEPm7waAh7V1H8JNCEdd2KQRjG/dUNRczdnC5R4wY+7ahHOFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOuGV8jrLJKE+Hjja3J7kfyZ9zkqlzGEk4+hvYLIZUM=;
 b=hNXQASGGMcCOktBIPHlrWTjLMiHIsVi7+ayk1UCP0byayu/CHtbl1iAM3CuoqyGFsV8Qk8At0Er+35Ou5XH+18yWbooJ/KVGZZbiAwOLGfi61igzIcK/APhc00mQN+N50RwTqXL4mbXIfYQ/I1jK2rQwVcbu0bCKUwPOp1aiLF+l1M2D7WE+AfXik1z18f9n20Sch5amFZed5docIPAiOezM3sPOgnlYGuC0JUvioF/7j8V/iwEfL7rpD+BzCNvqQ6ONlMA/auPWx0MLx6kfOPiLViOMpVzGkXNpUeNR91JM3k2HdZ6pkDZI8XZUGah3fDbTJxJxngmsM/LO8SJxcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOuGV8jrLJKE+Hjja3J7kfyZ9zkqlzGEk4+hvYLIZUM=;
 b=wFnyV0oQNbb0VeCcTvt78j7ZvBotFJmQBEky/P8hTjsiYkjE4MniJuG82XRRytVfogyQX2MpPAs5WV62w/6fhn3sBh8CprAApcG9n1MhD8Mte5c1748klcf/MrCu0TIBuzTCzkrItfjWEwoJhKGaTAxNsbMQGoh3GkFAsSEhVzs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH8PR10MB6289.namprd10.prod.outlook.com (2603:10b6:510:1bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Fri, 31 Jan
 2025 06:43:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%3]) with mapi id 15.20.8398.017; Fri, 31 Jan 2025
 06:43:07 +0000
Message-ID: <fa76f7ed-06e3-4f16-a762-fa444226bcdf@oracle.com>
Date: Fri, 31 Jan 2025 14:43:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] fstests: btrfs: testcase for sysfs policy syntax
 verification
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1738161075.git.anand.jain@oracle.com>
 <3aecf19197d07ff18ed1c0dda9e63fcaa49b69d1.1738161075.git.anand.jain@oracle.com>
 <Z5vmAzAEtzK_EuXO@dread.disaster.area>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <Z5vmAzAEtzK_EuXO@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH8PR10MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: f658109b-0781-41cf-fab2-08dd41c284f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUN0aWs1MVhhUGhpdmljQmVNVmx0V2hMWFYraVo3SGk2WnA4emhWdW9ORUZh?=
 =?utf-8?B?WHhTNmN1NGdFSWZEWUtKQk9BTnZ0UkFtRWVFbVpLNFVpZlBucWNtd2VGSlhh?=
 =?utf-8?B?MjhxbHE4RU43SUthdlJMRXprSERTZ2tyWE95M09uTXpTNlpXMWhhbHZjZDdp?=
 =?utf-8?B?bytTcFBDbUdIcEJOcUFoZ0lmMEN6NlF3bzVJWUNmQXN1djVJMlVraWlRRmw1?=
 =?utf-8?B?NVIxVCtTYmJlUU1neGNTcmV5TXpLditqQUovdVNXbVhlOGpsb2dJdmpUZ2xj?=
 =?utf-8?B?SXJSM0tPTFpmM0VaRklzZFlmclVub2Y2Y3dJOEFOYTBsTHFGeDlvREYyTG5S?=
 =?utf-8?B?RWxaSUlsTUhuVHVyT0lEM1V5VmM5bzhvekU5cEVMQS9NRG82VEpZK1JOcVNk?=
 =?utf-8?B?dkFLQS9KdjdnWTY5MDhIM2pBYTF2bkF0L2l4M3BtUUx0dEpmeEdQaVdXckFR?=
 =?utf-8?B?aEFRVGN6d2RKQ0NIQ0hZOFFvNUY2QytyQUZ4VDdPWjZraUZTNmwwT2gwZm1u?=
 =?utf-8?B?N1RKQVFZMzRsRTVWM2N0QU1ycFdkdDJ6SkxQdTVaK21UdFR2cUJwandHQ2RH?=
 =?utf-8?B?bW1DWWR4eDZGVi9sNnhQOEQxRTBqeEI5VHJLejJmdGpmS3pHNjhMNE9meGJm?=
 =?utf-8?B?QnBpMWczYWxnL0FDdkV0NDlQdHRDVUo1bTVVcklHWXJzaXRKTVFMWkVDK3lX?=
 =?utf-8?B?L0t5b1lwMStoM1JvaWVrREhBbXE2L2ZVT1hKM2IxTW4rVTN0bHZVSXdaMlZ5?=
 =?utf-8?B?dmZ0L2huSEwwQnRkRE5DQ2FHcmZrRlUzRXBtVzZrdXFNeGVuRWV0cjhKWXhT?=
 =?utf-8?B?cGJubGZFdjdLbFdwL0JXcTY5VkNIRnlNZUZVcmFJMzd4VmJWN3ZBbzBLRFl4?=
 =?utf-8?B?TmRONUhLVzM2MzdINHlxRml1WGtsM3ZWZWZURS8yT0ZLak54cXErcTliV214?=
 =?utf-8?B?Y3RnNnlWdUR6UDgxSlhqdHAzWmxGUVp4WHg2dWh5aG1RS2x0anIzZE1ZRGhM?=
 =?utf-8?B?dG0xcFBhMVM0VUMyM3BOeVE2bWErQTJuSzYwNnpwRXY1aVl0ZnZyclpXSk5q?=
 =?utf-8?B?NmJGV1hHYlVxYWtqbkw3VS85OXZkUUJyZ2lPd3htOHhIczhKbXpaaHBFNm5W?=
 =?utf-8?B?RE9GWnRNMTFLZkMrS2pRcExvNkQ2akszSHNzT05jRWFSbEoyUHErTzFPL0p3?=
 =?utf-8?B?cFF1RUtiMmhSRE1YQ1FrUGY2RWlrK1l1M2pycGo4aW9TSmttT2dxZ0RaWnlU?=
 =?utf-8?B?bHhWazVDVXkxbkJsQ1ZZNFJNNXRULzZ3MFN6V04zUnhRYjAvVWlmeDFJajcv?=
 =?utf-8?B?S1FGWWtPSWVRTk9xbnVPdTN2N1ZuM243T1lQcjBQYmZJLy95WE9DSW1YcVNT?=
 =?utf-8?B?YWNMOXFrbzBPYVRsZTBheWhOQTN0WDdnbDRxZ0RqWFFrdFJmOC93dXZ0N051?=
 =?utf-8?B?RU9hRjRDSXZwajlXY24yT0hhR2JlMGJKeG1EUWdzQms1VzF5c2NSTVZ5UWlK?=
 =?utf-8?B?c0pFVzZ6NG1oWG1ocjRUMnFwWGJ2TDIwUUo2U2MxQWEzUkdMeUhkZTdoWm4v?=
 =?utf-8?B?eTBSRFdVTmRuRi84ejUyamZ5UU5MUEFwWnBtVG4yQWVaandrM0QrUk1HNVk4?=
 =?utf-8?B?UFY5T29mcVBzN1VEOFRxNEFQTTZWU28zbE8wMjBXL2lDYTdQc0d6b2xTTXk4?=
 =?utf-8?B?bjN4V2VONHI0MExhTU5OK3MxTEoxRlNxNlR3MUNCT1RqOXNQU0ZPYStlVzFE?=
 =?utf-8?B?Slg1RkhGRUlGU2p0TmRtc09YTEdOZVREdkRVWDZhKzFxL29hWWhObzd2VkFs?=
 =?utf-8?B?SldnYlpza1dDdWtnQVByaEJReVVOakQvSGNHbGhvTjJpamhlbFBucjg4QlFE?=
 =?utf-8?Q?EhvG+YfK/5vvq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDIycWJJUHRSa2JJdFkzeGVuK3pyUksxYWtLM3h3WDJBNldKdGZlNlVjOCtT?=
 =?utf-8?B?NkthaEpheFQvbnNveExxNm9lZG9XellneERBRjFwZFpvbUZUN2ltUzFLbjZO?=
 =?utf-8?B?Rk4yWTBvNHVuOHQ0VFlocUg2SCtiOTFVcFVZWEhuYitBVnpISFFhdU1MOVFE?=
 =?utf-8?B?ZXBYeUMzclJIQ1Z6dnFtRU1yTnBXdHpFMkdESnR2T2JCZE9oR3M5STh1ajNV?=
 =?utf-8?B?dnJtZEJ5K0FVdmY4Y1M4c2hxWlYzNUN1WUxzTE9xbmtocTc5bWZaU3VuWjNT?=
 =?utf-8?B?Z2NWa2JBMjZ4c3FJUE1OOUltTlJyeW4yeS9GV3FyV2drVkFuQVFqVVc3V2Fm?=
 =?utf-8?B?Si9YcGJEei81Z0I5NCtuSzBicitMOE0wRmxHYVptUmFjRnllNkllOVM1a3pj?=
 =?utf-8?B?M3lKRFV6SW1WdkZjU0ZIcU1sMXhXa0ZIOTM5VUl0TkF6QkM2YkloTnV5UmU4?=
 =?utf-8?B?dFFUS1NIaW1WUmtYRldmUHhsTmttQnlhTVRKS2RkQ1BIK1FOZ2xJbVhqNTYv?=
 =?utf-8?B?Y2tiN0phd3pybytxa3Z0Wk9LRXd0dUN6akVxTXNvblNLNmI1dTA2cXYxT1N4?=
 =?utf-8?B?Ny9Ld2JwbXJCMWkvLzNHMnhsWmdLMjhYaU1WZ0dZb0JTalBQZGRNWFNzRHYv?=
 =?utf-8?B?Y2xXR0lYTm16TEJnN3VHSEhEWkNmYTZ6NGJoY0V4b04rVFlLQUs2N09QazBy?=
 =?utf-8?B?SmxrbU9TZjNXNE9qd1M2UTk3NTBsUndTWSt2cHRxY0NqOUIwMmtRcVU3Z0xM?=
 =?utf-8?B?UUF1ZmIwMVlRNjB6NjVTUEQrT3V3eEVYRzljeXNZamtyd3YvNy8wVnZTalFG?=
 =?utf-8?B?SVU0MHkrbEdCMEV2cWRZN0dhS0d5Z090Rm9iejE0aTBzK1ZjaXZVejNoa3lz?=
 =?utf-8?B?Q2E2QUllVDcrUkFYUFdGb0t1RURMSXBIc1hRU3VEWTkzb3JLL2FhL2J6VGNC?=
 =?utf-8?B?S28zdTQwWnFpeXhJQklicWJqSStocnZsOFpOcXZFZmZocmlCNHAzZk5Nd1FM?=
 =?utf-8?B?VzdFMjdJeGozd29TVDNjUjJ2U1hFUUZEVmoxdW1MZWhrRUdPbUVJWS9qVXF6?=
 =?utf-8?B?dW9yR3pvQU4waHd3QU5KU2g0ZnlMRldnSnh2cFFuVHNIVFlFc0NIOTlSTXBS?=
 =?utf-8?B?RHFvbHFsYnNPd3puMFdwKzR5Ty95bW9vMUJsRkdmVEk3TElOWk1XSmx3d29a?=
 =?utf-8?B?RmdlSWdnZi8rb0NZTWNGemJBUVdzWnJqYnRKdkIrUlBob2xLMjZaYzhmM015?=
 =?utf-8?B?T0NIdmJuUEZVT1A3YmgxMjJBYmVhaDdjNE9ZczQwdkhQVVlmSGh0R0Q1S1Bn?=
 =?utf-8?B?bXJpcW9za1NNYTJqbFlaNGdzTENkRmphWldvNVpiQXlzdm1SV0hzSFB4TU1n?=
 =?utf-8?B?cXQyU0JJdEdkNjlzUFI5STcwbzZqRVhUVkFuUkRtK3FyS3c5WE1JWG9uMU4w?=
 =?utf-8?B?dGM0UDM5d2tONWNWdDVaTi9VNjZsRSttV3cvdnM5RXRoNlRGZTNZa1FpR0Rv?=
 =?utf-8?B?UktuNXFJZzFqaml4cldtc0FmOWZaRWFnbjNYV1JVR1FsOGIrVkRDaHRzaENR?=
 =?utf-8?B?S2FiWFRxTWZ1OUdZODBwUitHQytZc1R0SGxDR1NXaTBXV0lVSWRvbUlIc0JQ?=
 =?utf-8?B?MmNqSlRSOW94RGFlcC83eitlLzVpZ0hjRitlVXRZcmE2MU4rSkV1V01RbE9k?=
 =?utf-8?B?TnlwMnhWUHVoVGZUK1BXQllzTWdpWUhVdWplWStaanU1dVVxTi9JRTdmL0R2?=
 =?utf-8?B?TVp1QUZYUnhzUlI4a1dZNUhlM0lvR0JFVlk0NHdkZ0l6azN6VFROVlVYTjNs?=
 =?utf-8?B?VXIrWkRacVZ1T25HMjhScENVZUpWY2JuUllzZURvKy9ESHZBTUpvSnZJd3hl?=
 =?utf-8?B?bVRkNzR1NnhESGVoVjcvcmVCNTFBTXFDTWk1NDVUNFlidC9PNVRqb2FDZGdm?=
 =?utf-8?B?KzNQL3E3YUtmeURXM1pJOG9Mc2hyNHJZL3MvTFR5bjQxMkF4QjJWMDZOdzJM?=
 =?utf-8?B?QUNRRURNT2djaWpLaDVTZXpkQW9FTG54WVNGVzdwQ0VpcW1SeVNQMlpUV0hq?=
 =?utf-8?B?bkhLMmN0ZlZGNjBjd0k5MkV0ZXRaN0E1aCtlUzcyaTBrUEp0eEJoUUx2S29p?=
 =?utf-8?Q?o7XhoBQlW/rANOkGEFYUD7IkO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SCuxxwxMS+R//NJAFDlaWG3b3mvnKFRthGes2pHhu8ITXEAtcYLwQXu8ui5pX6qmMrAz/haKRo6+xKHpvO7J+9IIq8Vl7TPmE20xW69hq1zipRd1ALH6wbaxkH0sZsx4FML3g0sUUe5vpfI7HZNlq3/2/QatLx9OwwjDipL5I2hBS9DR6PdxHf39T1aGvYfLTooxzyQixDM2Qh5E2KtW80hgdfVrFY+7rAJnEYQibstMQCDL7ES+NO9dmWFTTB98GKMHObMhObTdSoYozxJ21htgk3O2qKuuH4qudD/OeK5gv0ZdLOnkT8tTeYfp4MwTUIZweq3274bveF81S0dS5U563wDFLnHOI+mfoalyf+gyzyH2foKUe+xnrT8pDPP+U4tUUtnC3bNSZ+IXD8lFwq+663jJ7UHo89nzoEzpnR3UA/GNFL4yVBkxdX4506JYayfU+0AnMbTMZcXpA/Jna350fIkVHLbW21rkupACQnaN/tGKdrNLbzAfI2DpxHCBWaPGBhDlCXXcp9OkVlz/1vR3mItF7ysNA1lkPzru2AUNb1uSoNd8xJCvf/HUDWe8hB9RJ01XoYH68JvTCDxcYdhpb04PG4CFLlEzSGYrJfQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f658109b-0781-41cf-fab2-08dd41c284f1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 06:43:06.9396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXsKQqXnQ1IKXfDzYssbiah29hzcnSB/lkTbUP2M/dyxhPGLxquAbdZc1XXUtvNM6Pmla9FEGXs9Oaxs0FpClg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6289
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_02,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2501310049
X-Proofpoint-GUID: GJ3Wy-1VATv_UUiOLhpFI9rq1WDEIG0_
X-Proofpoint-ORIG-GUID: GJ3Wy-1VATv_UUiOLhpFI9rq1WDEIG0_


>> +set_sysfs_policy_must_fail()
>> +{
>> +	local attr=$1
>> +	shift
>> +	local policy=$@
>> +
>> +	_set_fs_sysfs_attr $SCRATCH_DEV $attr ${policy} | _filter_sysfs_error \
>> +			| _expect_error_invalid_argument | tee -a $seqres.full
> 
> This "catch an exact error or output a different error then use
> golden image match failure on secondary error to mark the test as
> failed" semantic is .... overly complex.
> 
> The output on failure of _filter_sysfs_error will be "Invalid
> input". If there's some other failure or it succeeds, the output
> will indicate the failure that occurred (i.e. missing line means no
> error, different error will output directly by the filter). The
> golden image matching will still fail the test.
> 
> IOWs, _expect_error_invalid_argument and the output to seqres.full
> can go away if the test.out file has a matching error for each
> call to set_sysfs_policy_must_fail(). i.e it looks like:
> 
> QA output created by 329
> Invalid input
> Invalid input
> Invalid input
> Invalid input
> Invalid input
> Invalid input
> .....
> Invalid input

Thanks for the review.

This test case verifies the sysfs interface syntax in general.
Relying on golden output can cause false negatives on older
kernels lacking support for newer sysfs policies.
Creating individual test cases for each sysfs interface is
unnecessary overhead.

With this approach, when needed, we use:

if _has_fs_sysfs_attr $dev <sysfs-interface>; then
     verify_sysfs_syntax <sysfs-interface> <value>
fi

- Anand



