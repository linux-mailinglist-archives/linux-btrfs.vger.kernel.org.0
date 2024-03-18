Return-Path: <linux-btrfs+bounces-3358-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB8F87EB8E
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 16:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903491F21D9C
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 15:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D424EB4C;
	Mon, 18 Mar 2024 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SGNmh30p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nHSjVeV6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C6E433D2
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774068; cv=fail; b=cacG1pJ2UfGCbnH9bjkeHTtoNSpME3cEAMT+XtNK1k9JMq+TDlSrJ0nAOmQbMF34JzPtNIkNpatIFeCAgW6lhVOdqBU+3rQ93hzZPbi6O5D4HiwbkZxNVhFwPYCop93hg4ZHXLeafo/mqd9axPO0TYrxtTjvHssVYWi9VXrM2a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774068; c=relaxed/simple;
	bh=bh5dY/cORrvJIwoGB6MhhPhyAJ8jF5A8kieVosNTDQw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IhFuPtzwl9wZ56gPuYUxT6mqppd0eoHNIdkwMbS+TAdrmNNnL1xMPBYDow9FuwcqY0d1nFhC+mE0wcJnE/QwDJ+CoSDvLNnhjJG3YtUdcUJwYCY9GqWAc7U8LGNCZw1YFpK5iMnQx9TXCgQWz7uyPn/ZI6vWTY38YZJwbLjTDQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SGNmh30p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nHSjVeV6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42IDNxhI010424;
	Mon, 18 Mar 2024 15:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=kfTco9EdZahi5T/oFGmP2mNhp35Uq8eLOv6n99ftqXQ=;
 b=SGNmh30pgPle74TBirqNI41N+g6IRmOz2zyXbnNlzWQRiXrIyqwPOJ+lxniwX7z5Rj1M
 BAg8SWhqOmpz9tmtQSksxGpJ3us1FoA53ZFcmAKEbQ/iY3zzne7+eglwR8ch6PL3u39s
 orCzgq/n0Pl5rucNR/6596BMnY70kwPrZZkr4T7uP0E4WvvWd+oWc0rSiiasuQ/IN4X0
 gk/ZFMn6U6n+PLl/C2iRpB6rh5DihU3x7Ze+Dkgs87+nkgXJSpwIa/R5osWE+iJKXl0F
 bINny7ILKqi0Wifp7oGCtk2dhshyR12zv4Bx068wGyzHbDA6kFiH+e4JAWfJ1Hrpkasl iQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww1udb8u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 15:01:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42IDkiBU007503;
	Mon, 18 Mar 2024 15:00:59 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v4yhnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 15:00:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZf/e7SUa74N1P/HYulplmwsDYoalX1z/Yo6LS0YL3WgzDJIQ3LuRiLaIndFi94vJ9W/98zCwuo5INEjIEyQDzokt1AWo0GAU93op9LU1hPU3CtwlMN6vz/rEbmGkIN3hwewfaonC5zrhG4zskEfKtxQnGn5/TmR78NolOnNdSo1Q3i87c9s5qiuJiVj3qYO3H5afZWJkGxNLk088E807lh3as/CaAXHGmVz2Si67CRNn0d/ggCXnoff2GCCv08XfqQ8Uh+Qbq05pJQGW3wNXD79dmnUJyyNuOm/8YS4hTaouJ4K2gMy9/bzaSzZf/06aQu7onpqmrozvp/O1SU7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfTco9EdZahi5T/oFGmP2mNhp35Uq8eLOv6n99ftqXQ=;
 b=ZJBu/IabAdBTaZMzOUhsGH+IEPhDOXg4gD7RsGUEoGgN8Ajx/xk8/WA+5h8ecdcWem0TPwllzeHxavWl4aRNtGQTfnFjkA+fHuh4ynpUbeHbUfQU8WgyCuD2eE4W6yWdx1JaYZgywkWCC7540SuqX/iwdcA1qRE7OXYxPKaMqDlQjJZCmYTPTG9ZKrLvUzxjYRMdcoVEv+F2CWbm7TAeN1QAS3ZWNLTgfTKjk8Z6TBedVfNbYu0AS4zzX9td9Xqcc3IK45UT/oyH4skSlBNz4VJyqRQ+YVpi+cwqQTUd+8mYAxFQ44kz8R8oMld5I2x4RXcA1sefIQtpdMxR+5eSEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfTco9EdZahi5T/oFGmP2mNhp35Uq8eLOv6n99ftqXQ=;
 b=nHSjVeV6Zo3wXBeqHAESAJe/kP8AtUaefxYtzenI1qoKOEzZd+FBOtYw42wrhaNcv/legaepJ5zzAkpY47H8mY8hWXEHPdjeyjhg1qn293Zv7Tn0PP+0olIGPd/3iAAw0Tek+MnxjMgJN3aRi/OP3S9rmvl8ZtmVGIPv+YBhG9k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB6429.namprd10.prod.outlook.com (2603:10b6:a03:486::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 15:00:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 15:00:57 +0000
Message-ID: <2f0c4a6c-f95c-4610-ab58-0cf4d3a00352@oracle.com>
Date: Mon, 18 Mar 2024 20:30:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: remove a couple pointless callback wrappers
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1710763611.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1710763611.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a89c191-2294-4dcd-3eac-08dc475c36ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	De7mI9RnVENHhWbKcImqFymzN0L8NBFdLrinUnRU0bLjtfjPWxqo1Dj/9TenLEWmZ60hwqwTMtkRWcejjIInco8EQVt13NWwm2RB764T5GKyL5LrqIcfBL3He5J5a0mSfSGU3TiDWhhSUCQ+qLpyqmH9c797Jhw848m11Q63LHoVk/j+kXP/1J4UK4+cd4gCGqIgMru6d3FbQDghq4OWcDbJFeo/kkkglfBy0Xnt2zGmWZwq6XXixZld4Ji3ItcV+H6CrbF1zurhlv7M2GFZhYeROERYMkZywgJaEulLxjzpnp3MEF44cplR8kXhLoq2kQszsh5ZRryksQKiBU63XwJ0rQrfcuowAtr0TxSb3YQwmDL7JN+fKnEP6g3VJEmf487kFHOG5c1ahwOrIHw+nWAJVNs1gMHOimJCwirfEktysYIM8Gais3W9SXk+0c+GEjKifVeIFauRFqyl4pf9OAJz0FLRfcvjNzd+jeenFnmSxcBcaWcDFQrY/cLJRdFzYNAu/PiRGeoYfhUyMRQnfnmgVXaKyvOcld4QrSfC3wOQ/Lk90/Hs9XLzdCJa/Otll0fzSWeGygYTpfY1Y56bAtYGjFqdw00UkZLex6/mmixlmw0aX4WmXGGFlnrYETDvVMgjxSyERXjI+YlhQSHj4oMedsUk3ZqLtt3LoHIjHEQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SXdvOGQ2b1JFL0ViM2RNa0w1aWRTNGJnT1BDeVFuY0xFMzZtSXBxRXRueEpy?=
 =?utf-8?B?V1hYVjEyckEzU3ZHZzIyYmxJOUc5SVdhOWJ2TzFzTjhyeS9DdHh1alZsRHp3?=
 =?utf-8?B?Sm9pcGRhZnZGUVRmaDBjT1h4Ym40Z2hRYk5maUl6cTgvcVduZUp5aVppMTJI?=
 =?utf-8?B?dWk2SXNIclIvc2NlNHFwbjdFZWhnR2lvNkVXRFZUK1pIU0RHalJGa3JBTEJt?=
 =?utf-8?B?N0FESGpaRmpnOTQ0VHVHZ2JjVUFDeTQ5UEhreHFybVB3V20yOXpoN296YzFD?=
 =?utf-8?B?VnltSjdkRW1VOVJXK2NvWGJ2aHMwdnF2VzVPYkwrYWU2Z0R0bTdGTlpkS2F1?=
 =?utf-8?B?MGJwZXpqRkFXV3djelpiV1A1dUVFRlliUmNja1FWTzI1T3JNcWFMOFc2S1lI?=
 =?utf-8?B?V1JFTER0MFUzdFNKWXczbzJIaHo0UVZ0cDZNS3FJdW9CU0R2eUw5b3l1K3FM?=
 =?utf-8?B?OUxzOVRTR3ZFM1NOdTBGQUpsV3VzMFBNVFZ6bVRCVDJSVFlYZEtnZ3I5MEdB?=
 =?utf-8?B?UnNHYjk4QVlrY2dScVBSbFFwbEI3amVSOUdYTFRqeG4zcFZndE5UOFVoSTFC?=
 =?utf-8?B?N0N6NEpKWHhaa0pEOW52MlRvc0V4ZVUxNWJib2FYQkdtZmdPZU56WVFFc0Z5?=
 =?utf-8?B?SVcyVHhvUytpQ2RxaEZxZXFVOFd6NnVVaVpPL1lGaTd5RkJqWWhWakp3TzVr?=
 =?utf-8?B?UTdVVFE1WEF3WTJHc1lLQWhBdGREWENFNVRKdGdSdEhHQ3RRbE92dDVWWFNF?=
 =?utf-8?B?alM1RkpiakVJSHVrR294NURLTnlFeTYrUzdqeWVKRWhkUXNwb1hOTW1TbUht?=
 =?utf-8?B?SldtZ1IvN0VOTWJBYnFiUVN4eVZaNitFaFY5eDI4TkZhdkF2TkE2eG1TWVpJ?=
 =?utf-8?B?MnFCZHl1MzdLaURYRXE2WmN0REhrL2RhSVhJeWEzaXVaMnRmUFhWSzlFc1Z1?=
 =?utf-8?B?L3hPdnVvT1Btd1FScHVmUkp1dS8zYTM3YisxUmRUTEtSZE5jTVRqN01WU0xq?=
 =?utf-8?B?WEl6eFpJV3ZRY1l5RlRvNDFkdHVUOUdoR2JFeEVSTnhpbWRFWjBJQWdBNUhO?=
 =?utf-8?B?ZG53MzFzTER6QS93a1RzdGdFTHVUZlhibHdXN2tYdjZQQmxGa3hWTUp4MFVZ?=
 =?utf-8?B?czl0L0dtQUlVMk5JVXVnS2ZoSk1SOGpxVEZha1k4TFFaS0NJOS8xdy9Zc0Jq?=
 =?utf-8?B?TFBvUXNIdExNY0F1eTJ0TDhkbXpQdVVSa0ZlaVU1bWhiTkdMaXRwYTVFcDM1?=
 =?utf-8?B?L2VySHJKKzRCK3lhMFMzb25uYUE3aUhEOEFMNEl3Tyt1WVdrYUNoenUvajEr?=
 =?utf-8?B?MUVyRW94RzRremN5VUh4dmhhdnI0Skwxbll0YmlRVmNPUmE0V0NCQUpuZktO?=
 =?utf-8?B?MjhPY0oydXBOd3dpL1paWkFIbUphdmcwZXNIZ1cyaTM5NGZvYkVyUVF3L2JE?=
 =?utf-8?B?Z3lST0tVMHE2Um8za05lZmpXYThuS3lzVW1YYkVDbkozajVHZUxXakxqd0JS?=
 =?utf-8?B?SUlkN0VUazFwTzFrSnpxRjJienBoVnZyZU9PcmdBcGxGekJMNkRzdHN0QTBJ?=
 =?utf-8?B?RDB1L1FOdDZDdjZtcEFsaTBRYUhyWWwzc3dYbFlXeFVjM05tb0Fidnl3aVRm?=
 =?utf-8?B?aWtLbmNjZHZ6TUhVSHQ4U1g5cnQ3OHBxV2R6cmZDQlZJYXNTOGpYclhvTHZE?=
 =?utf-8?B?SGV0YUFuOSt6bS81TlhUNFAvcEF2czYwQm4reGNZUXNEaTlQSDQ1bFJBTzR0?=
 =?utf-8?B?WXpGdWRTUU5RN08yakNGWEZOWGhpUC9tRXRWRVAwcHQ5RVRIMzN5SGhiR1Zm?=
 =?utf-8?B?Zk5OTWxQVzFIRTJ3bkZUMVZ2eDBpWFpQRVFPT1UvM0xpVTg2N21zSXFnTjlM?=
 =?utf-8?B?TmVkM09NSTlIaTN4bHR4SVhsMk84Q25GVDlLOFF0THphdEF6ZFpSSzZORVUv?=
 =?utf-8?B?Vi9QN1dWNWtITXpLUHF0NmQvOExackNKcUwxVGJ2eHNVaEdDY0VMQlpRSFVM?=
 =?utf-8?B?N2s4R1YvL0N6QUdUNXl6cTh3Sm5EVCtjdTlyYllrV3ZxZVlmS0w1VXlVQ09Y?=
 =?utf-8?B?Rm1rNkVGZUEvdHJaV1N2SXpZTDc0clA1REIwMjV0MTgvZmorQldGWFhZU3JV?=
 =?utf-8?Q?gDparwXuxuZmyKkSNC5xpTVBm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	duBpgXCz/f1PqmBy5OL6+WAfy9Yrd6s9HB9pAdTaHOWct4lrtJ8smeNSCfKy2/0cPExWniwZzaWUZw3XVfHxyLT5mXYUd9GLUTH0LrOhNhGSZ0dughNsUd2pR6MZih0gXZS6UFlQscGRDwFYVD/+vMiiy84/mLO2fYZHpJ81/w9BtIrqgk6r/oajbut5JCH4jMJARZvoYVVM/GkumHEFpI3WYGwjgk99YP/htz189fhmi+NOZJDobKbo6qMlWhNkw5TfFmrsa1vcEGyCrHUEO7d/gZHlFKLtgFiTYVfNhlJCfpT7LgfrAY2uDm29aogphBb14NYAmwzfbwUkvyarBuf8ZDyyGjXnVQBMk9V4KOVtMuQQ1HFzcygk0+WSuE7zuKf0LOtCyu4RxoSGjp4os9wNFJTO1hnGO46L/nq1iEM3hw5Q4GpIgezqXT5w/jMq52gnyHpZUBdn7VTB4XXtT+YlNfuZCoxQ9JTVPKbrmYzPysBsPznqiAPUfiEFfma/knGmILOBN1x6kY9TwdLvYMxMU8/Td8PP5gsy13aZyhxj2RzCPYvxtX6rT5DrE1WhLvTkv6K8oHPKxx8Bwcriw9E0LPWJjyZ0PrlsBaG9o7w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a89c191-2294-4dcd-3eac-08dc475c36ec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 15:00:56.9261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0J6D+cBK3hM0qza1el8n2gLVYbYWdOroDrxKtwz5jgGknvpul5BpGEI+lOFbEZKJX/07SpqeUvO/MrB+VNVfcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6429
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_06,2024-03-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180111
X-Proofpoint-GUID: GxIboUqkZJQGY5uKkfbND55YmmP-DB_H
X-Proofpoint-ORIG-GUID: GxIboUqkZJQGY5uKkfbND55YmmP-DB_H

On 3/18/24 17:44, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Trivial stuff, details in the change logs.
> 
> Filipe Manana (2):


>    btrfs: remove pointless readahead callback wrapper
>    btrfs: remove pointless writepages callback wrapper

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.

>   fs/btrfs/extent_io.c |  5 ++---
>   fs/btrfs/extent_io.h |  5 ++---
>   fs/btrfs/inode.c     | 11 -----------
>   3 files changed, 4 insertions(+), 17 deletions(-)
> 


