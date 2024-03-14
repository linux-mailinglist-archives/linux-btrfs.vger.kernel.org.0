Return-Path: <linux-btrfs+bounces-3287-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D616887BD42
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 14:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433981F26063
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39C35A4C2;
	Thu, 14 Mar 2024 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nbeKi6gW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DwucONTu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358695A11A
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421598; cv=fail; b=Aa13NTQmHXD/BvF0W/tNzwYWuTnYRw8omuHaEx4MAnv0TbH0QGR79C7s/Ft2zXh54nJAxw61M2MjY1yjeYbwpD3kihEJ0mNx2/yqdJ3OFkP7IXsqauSRFlfaI2y/lEzWTCrnqt2fWhSCvi+6+l9A6s6i1PvxH/06NqFQ4icABCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421598; c=relaxed/simple;
	bh=JjNoFRXywTx3rXv2Q0lgl+Vp3JK0TKkEuu5tMO8jTPA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P7x0xAu16BJc1b0ppj6Sqkj1rLQ/3tsRHIEhbTf1fM8d5goOv8hXjGVN3ij3+O7cqAbn0mIgIpYbW53GAUwmmySQ5v0X/dWDwDVuW6fYS9Kc5FNLAOd5LlyxAxelZuF2rtDqmepn50CKbakTTY7HdmtIW0k1H5MawouzqT38VpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nbeKi6gW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DwucONTu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ECML7P028829;
	Thu, 14 Mar 2024 13:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=E6E8RsNyr7KTdam+cahjCSGVD05QGAc35hH6q5X9p+U=;
 b=nbeKi6gWw30/0SIhFaMw+AJICZHKKHS78deNTz2Hn5q3uzespRejOxluzwTH44era6A/
 ITzp1a3O+KR9u5cqudu07ziOfxSsIrCQHYsbG1S8WxVEVfJL+m9FOm51QEwtcJyN4188
 vSvjCHxFV/4Q2DqlflokLeXwaUASr13ZJ+drUO+cEgQmoI4lyIYBkUrizzY1hFJvZdGW
 MMCY2YbKh/s+gH6zv7LcnQkM3XYAOqL67WI4HPBnvMzT/vcKY5Ky2e+Tj6haoDO8Ixzj
 lvULmzK0jkcmz0ZiwcrHeDZg3xvQh7xplSuD6+0WAK0yB/X2x7EQa5A3wLgMGHY4VPl+ Pg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wv0acg67d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 13:06:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42EBZKKi033735;
	Thu, 14 Mar 2024 13:06:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7a3bxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 13:06:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePFIb7mUWtrZERiAaSY9gv3QARxzVEjWftBGbMnimnTcoN9XoOlR5wZygwEe3GYL8jB29qioyaHACqs+HCQ7spSGM/5x1n4/by2bgvdO2gfkerAwhBUX5VpjvOGZ7J+4prFQBjsJacADcQrt5QKUmOqL1Ogmw2OmdNaLR4GnX0k5xtxGDKNNcePD1ZmDz64CSRork8/39rTfw65bwbI9DZMovgIqKU1uK3TVtgs+N2d45T1SBUrCDOZ3h+VUZaOHZBl+3xl5cBKLQRAGbE8qUzyUUDtqmua8g/nhSi57/ln6ho5pUQVyhNHzhs1y9mYBP+3oqCRzsufzmRAQm+SlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6E8RsNyr7KTdam+cahjCSGVD05QGAc35hH6q5X9p+U=;
 b=Ei0F+u+lLZ4aOCvAKYuNCpeHcICJrtLr7Tdc41hy4TVNyXIT/Lmsn6v/TaKXGWyNG+SNWB5xzKergywJmEpzdsEhFGW2+YtSbC0BroOw1QlwOIlAVsF0wD6ACvX8CLpflXTvNvIi9S5gCAwgVrjD2KaIyFKkiTWPc6WoZLQpfWzu68UqdKeS+c/GdJX2RTx3rHinRlcClzbmzc1W8oW5lURxKctGFi30a42VPSKtfJbrmM+V1avmjZuLAAWiCnOdzC3VBLoVmZxkoaQ4BQuBdpIwXtEsfYciIpK5R/iWPbAq8hI7rDg7HvVdKlVflDHfZvARekRPGGi9pUCGZVvavA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6E8RsNyr7KTdam+cahjCSGVD05QGAc35hH6q5X9p+U=;
 b=DwucONTuxd8yJ6wOz6LgrfP/Gc2LL7ZlSqjhz73HDYgOfb01FNESgtGu/jk860oKcbyCfkpA44Lh+cA99eUCd3r0hpDiPrgo44RALCeXnVPaWVV+zQwE8BNvwghGR/NLCwGfSXJPowmUQpNVGBzIjrtn2X5bT5JDJ0vUvevIPis=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6783.namprd10.prod.outlook.com (2603:10b6:208:429::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 13:06:29 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 13:06:29 +0000
Message-ID: <a2d7256a-1046-431a-b251-6027e04b185f@oracle.com>
Date: Thu, 14 Mar 2024 18:36:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] btrfs: some minor fixes around extent maps
Content-Language: en-US
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1710335452.git.fdmanana@suse.com>
 <cover.1710350741.git.fdmanana@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1710350741.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ab1efb-4ead-4d90-6676-08dc4427900f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	o5H49P5WffsV50PKxOU2163Nev5AmfdIrJLFfodNrDpEccek0PLz+wZ0uNfBwXfyIJs0L6qv8AYj8Me+aGWdk8G0o1i6MEXzwMKd8z0xY5zslgCwKrFMpn9t+4t+GEsR2+3sKYbZoBYAcc7eWQXQGCHCNHDiIq9yGBi9wqgDl61GfqPkzMgP3s4iKIaH7zqNMVfQEatsIrp3GvNv/QJb+LeycUJLVcvahLa2RXW3Jue2q2nQNVv8EOJKuOpwM+APuXMWLAAomYVEBVfpZepuYAadtotEaUz5825Uq/lTxnBwOsHAmor/5NpBiNrtsnRMjiogNOf+0i+7V8KbKAclq9DYCw7Q+8ESqMk9qyuvYLvmE0GmNVx9PN5vfIleAO1OZf2j3MS1pqW1c3ZPox8z8iCZduruJM4AUQbZnJe7pYkDgsT6K/xLk5UEfDowd6x/dZAOTkuhG1VDZJTvcpqAPfSMoa4ytWeQOptn2T6Xp8e79G6g/Y1IafRU4GJvaNn5zLCeEpBfyAtehvf5JLVmH5H5/z9Lo06aohfErMbZ4e4YBJpUw5OSjA2stBF5bmlcI10KvfoaWj7vM4qCQTON1yLZD114S46LIPesuVngq0+aBTf+Jh7KPDoYwjTD1FGRTrYYb82wGDt9RP3QDAww7bvI+JFkltG32HP1E09BqHM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VEduTGQyMTVKd25MRXlXUXFWOGFYdGdPRm92UUpzbk9td2FURXpJWnZMc0E2?=
 =?utf-8?B?c0pudGdqWWdrcndkMjc5K0VDZEVCZjFwaGZhTzlZUk9ybllVUHdFQlFjLzMw?=
 =?utf-8?B?L0QyN0l6ZUZOU25ZQitCRXhoNnpxK2hzbHZpM1pvOVVVY2NzVHg1R1JGQ3B3?=
 =?utf-8?B?L0w2cDhaTlJQd29GeXB1bWhyZk5ieGlrK09WbGlPczZIZGp4cTdGU3VlMVl3?=
 =?utf-8?B?WVkrR2NtWVNaM0IzMnRGUlVsZmdXc3FzZmJSNWJxRlVQQzN0YXJpb0t2NzFB?=
 =?utf-8?B?RTllS3dWb0Zkd084dzJSNjcvOU4rU3hHTlhUQ2RLcEJOaUdJRytEekJncFAv?=
 =?utf-8?B?R2l2UWdJeXFXQ2NHcjJtaUx4NU5OVmZBQXVocU1TRmJia0lmcHdLZEFyeGNu?=
 =?utf-8?B?R1dVaXZlc0l4VTF0cEtGNkw0S1BQekV2c1J4aFpXc1hnbmw0NGUwMStkMG10?=
 =?utf-8?B?N0puNXMrY0tpUXBGY0pKNDZ3bHd5Qzc0L0VkUjJULzhZUG0wejdkQjhkNFYr?=
 =?utf-8?B?T0RhOTJGemV4NzVmU3QrRE8ybzYvM3FBK3JtQlNXUFNscnI1VmxweVUzL3hP?=
 =?utf-8?B?RDVpR0NoanFyV1ovM0xpZWdpN2FLR2lQN09laHlZQkZ5UEpzNW1HZHZGdXEy?=
 =?utf-8?B?dTgyU2dMdHJNOVl6R0VlajVXSlBKNG5LTnhyVVprenBIcVhsMmE0TnFhcCtj?=
 =?utf-8?B?VGFPZGU2SCt4N2o4aStwVlZiZXRkV1R3VDNRcml2blR3Zlg2RWpqcW0yYWZt?=
 =?utf-8?B?R2dhcUlPZ20zck5DWmd2YXUyS1pvOWprdWM5d1RmaG5sV043T2prSThSWU5s?=
 =?utf-8?B?dGVCSmp2eWxkdjBranNkVHIvTWdYQjdlbEJhVTFnT0pMVTJTZmVUMm9LS0VD?=
 =?utf-8?B?R1hjNFRBa3V2TnJxTklsTEtqKzBCRFlINGx4UzdGTnRFdEpjd3Z1UEZQeHVO?=
 =?utf-8?B?dElhcStlU1NTZFRiOWlDLytsbEdMWS9FbERGSGN3dTd1V1UzdHlXRG5KeFFQ?=
 =?utf-8?B?aHA3aTY4QW9PNGhPQ1RRWlk2aHhzT0xtZ2pHTDlPa1MzUHdEMW9oYkF4RGwr?=
 =?utf-8?B?cnlybG00aFoyekQ1djZLUUZvV3lFSVltcURRMWI2TVFFMGVNdWh6bEFzWGhU?=
 =?utf-8?B?R3EvU2RaTnhaZVlodGN2d2MzeVc0ZVJlR2NSOGtqYmIxSlNuT3J1S0ViS1hx?=
 =?utf-8?B?T3BCVWdBbGRmb1dhK0dmc3kvQ3kvKzNSd0RDcFgrZTZFUS8rc09Zbkw2OENl?=
 =?utf-8?B?eG9SMXlGeVZTM1JCYkFwRDVjOWJkckNxalhuM1ptWlJLNGd3ZDRVMy96dHoy?=
 =?utf-8?B?eDNkT0V5K3I5UzIzMTBDaWdoNXlNK082ek04ZlNLSnVMSkFxajNob1g1NGxL?=
 =?utf-8?B?MWRhWXdkdGh0bjB5UjZxV2FCMDEzYXJVdllaK2ZmeDJ0azV3eTFxTzhsM0RZ?=
 =?utf-8?B?WXN0dVN5L0FjYktSdDdueldoL2I4UjZKMFoxeDFwVHJnaFRjc29vK1VnMXVm?=
 =?utf-8?B?bjR0Nmg5TmxnZzBpMFNoZEZYYURCYy9TRnhPUGJRdGZDUDA4Sm9GY0dIWEtC?=
 =?utf-8?B?NC9jRUlOTkRVbTdQa1hSSjlRREtST3RpS3dsTFlTYkdjZlRiQ1cvNlk0UEo5?=
 =?utf-8?B?NFhreVlpTi9WaGRQSFZHTnNDaGpwR01FR3RvaWdnNjNiRGgrVGZzNUhSd1pN?=
 =?utf-8?B?VWJWR1V2WE5BREZVdXpwVmJGSWp5ekJicHZNWUdpVERRaFR1UWNVajNEMjYx?=
 =?utf-8?B?TEFoN2VjYzdkMis4SmttSVFlREI0SithMTVpWThZbS9JbVlpSU1lTXJ2RVNC?=
 =?utf-8?B?cis4L3JwU3dwM1RSeHVEWUxwMkpGdWRxWGpOdlRlMTBDekdOc1VzNktkT2pY?=
 =?utf-8?B?NWdSbGRobS93Y0pJRWNZS0l3eEpGbUdMRnRINjB5Y3NKZlc1Rm04WU5FTWNM?=
 =?utf-8?B?dHVjaGRIQkJJMkRwMlJtYk5qaFRXMzFmQ1dRSFB3d09kVkVDWFQ3aTR5ZjUy?=
 =?utf-8?B?Z2tXek5KVmJzZnQ2dXNjc1dBN3RZY0dTWmRLbzhZbnFIZFREZTRMYlNOSVJK?=
 =?utf-8?B?Nys0U0FtbjA2cDEyb1ozSXZCS1k1ZTJ5cTZORVFuSjVrQkpJY0JIZXM2ZnUy?=
 =?utf-8?Q?xxMLNbsHGHc5aPdTI2D7XLkZX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QfVU0H4Tg6lEi7Q+yZK8eir8E9pFGUMBhZeAdzu8MW6YDLLRGojzhWGzHyJXV+bSdbDku06sOdTy0/USlbDQJM8/pBTx+U9teP+V08VAG2DEwtPZvG30O1Bd1Zm11g9Wt/dur5g+DB5eQFHCYSLdkBeUlk9OBF8PS2w4QI7RtKW2QFJNy+Jf54G2BjdCv4bwqVDQGmbZ+mzSVhTcmN6MrjC2U+E7wZLcluVvkWtlcqAzr/ygEDvpprHs8YkI1m3IODQ7fb+s1UYONRs/zqZgWrZvCr4ZEiEcczgVcKrj3yyPwzSyHgT24CskpvMtFWIwOjQUOFVgw2r6R9szdoglyxMt1caXPn38e/kDx7T7bDMI3VwhXSdvuOh3OZ+NcA7lZEOi0LsHbJ3WevqUkaacgKk3mx1s2Ir75XO/jgxHmQiD0YboXezreIZJDs1awVlJWGDgwATcHelXqPZMRfXRwXKStxn3gy/1Wyf4Xio7CiNyqI5sQpEZJ8OqWD4iydnVd/kASj5gScGfX97Blxn2y3ZGBC24dNNDwppiB0Zb47kChUXTRC4+Y1nThcpM1rRf0Mz+JNzBqF5LDv342AqA7I7mSeS7biWtrzqmX0HpwRw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ab1efb-4ead-4d90-6676-08dc4427900f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 13:06:29.6017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjDvSko8Wdk+TcV9rb/dS4TUQ6ewaSWhkC4oJeVYQlI3GzeBafBsRN7R+NrTQeNMKLao3w4VIBW0whnu0E4THw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_11,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140095
X-Proofpoint-GUID: SwhACBDTgL-thpd4VC2jo3rIpVPjJFOj
X-Proofpoint-ORIG-GUID: SwhACBDTgL-thpd4VC2jo3rIpVPjJFOj

On 3/13/24 22:58, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some minor fixes around extent maps for unexpected error cases.
> More details in the change logs.
> 
> V2: Added patch 4/4.
> 
> Filipe Manana (4):
>    btrfs: fix extent map leak in unexpected scenario at unpin_extent_cache() >    btrfs: fix warning messages not printing interval at 
unpin_extent_range()
>    btrfs: fix message not properly printing interval when adding extent map
>    btrfs: use btrfs_warn() to log message at btrfs_add_extent_mapping()

For all.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> 
>   fs/btrfs/extent_map.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 



