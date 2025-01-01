Return-Path: <linux-btrfs+bounces-10660-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934129FF3A6
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 10:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6E01618C2
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 09:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928115674E;
	Wed,  1 Jan 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E4HUlCyr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bYDIq5QT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40D41854
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Jan 2025 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735725002; cv=fail; b=VmOAQEYHD1HO/QJN+ZCrCtHg58C4tL6672OutxLAqYD+qSnz9gMpWvtWjrCfcWSAWlVM3GrpF48MFRSNTPv7K409wRAwOIVFda4CQ50baHvSPuJnPHo1fNrzq5P8k/oQdhd8aBXQRnf5aqwgbV/kZAyZA2CkYNtGCU4eoo+gvD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735725002; c=relaxed/simple;
	bh=/9ECbL5trytAfkeOI/FjsqgqTcj6jV+In1gQURtVGQ4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SF4C+tnfO0Ozc7Zgbzynr49Xdk0TN+eu7LnrvWjwwsDafcQY8sAggQnSUcTGEuD3k+jmf9GMB3N5X7Gl1enktaJF4Z3OQnkDvxUPHHLqM3ZsRhhbk2TAMnnGwjIk7iA+QPN20OeavaRGV7YH7+CQheNVvxHWmb9InPh1Wg36KgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E4HUlCyr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bYDIq5QT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5015PFoe026743;
	Wed, 1 Jan 2025 09:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/9ECbL5trytAfkeOI/FjsqgqTcj6jV+In1gQURtVGQ4=; b=
	E4HUlCyrAoZY8F4QxMz3K/3WLaqSmnxmvkC9hfpPbqJd2flTs7wBTaJCn+OsNGWk
	rzUxn0kEg9sJsbqGUonQ7rYTPJNSMLmfvNbDDUpeY/glwRTkXuqq2RZidOruoALa
	67TPFn5bRWpDAabPsl1w13nmKy1F2iitGeVjZ1wALGDjQhGAesCH6XZDMSYbtceH
	BfaXXCY0/LUXPmsVG/+mGAjidLh2u+2EdgXkdivF7/s70KfOvCFQNQUpJhsSWL2Y
	au/FZi9/LdK/+g8kaOtIhi8iiEHi/jxOV3LO9YDIxnBBOlSK9n5HdyL2skWCmsq7
	rBtg9dS55vtfWmS+u4hWvg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t978m2j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 09:49:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50159Ltg012914;
	Wed, 1 Jan 2025 09:49:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s7qn2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 09:49:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThskU7JQH9ZUOSn9rdPNQtIHWGLeggQO53xzGmwrvd8xo9W0a+cMz7ASRNcvT71lQMnYSreXpuojjdoZIf11qtBMTu3KPBythBa0br2BLjts0kXaBIOb7S4hh3Fnjbx/pF2DFIDPkyO/0VKiViKRzZ7suMY6usIFq/zMfsReOAc9E1jtJAy29ziFwsTjtrrkftRBU+7FekdWnO/4Baw0kVZbkRg8r6YAr2yd+o/VfwiFmyuiZoYJZ2bC1C9bgGGzQGdcL1pBMkFC3OcyakLOiNvXB5BgjKbYWrPGQBUiTQYYOUJOJHq+GHaPCH11Myop1NX9ZOG/JtFrKroBzGCRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9ECbL5trytAfkeOI/FjsqgqTcj6jV+In1gQURtVGQ4=;
 b=p7BOFtH7LZ8K18g+b+8X/QuVbuw4hJTaFR0iZFD/bqfgcH/r4nVgOOp1LOrfAFlBucplcYlSY4aehnnOO0toa2jnSNDjEy6mcmLcHtL41PLIXTrE7k21Gv4OozlQr7T1RgevdCEMEQs+dZUMe40mR4k2MqnVyj+A8rbl2cVE+ut83XSEr1iCeDCvaAlpIe5kI9Z4pGNUMGLoilTvwaYGDAILyN+St0ixN7O6HWi5ux71C3wmiy2i4EXziqXYAIx8ZCvrOzYPpkGBhC/uZxRTR9sD6KKvhksDiyuCYtRNwC2oQiBTAhURbv4Kb/6X/9U4qIoYhTtdYZEGM3B0uLirew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9ECbL5trytAfkeOI/FjsqgqTcj6jV+In1gQURtVGQ4=;
 b=bYDIq5QTFX2msYEqOFly22IJA6Si0/hcELzCZMjV/ifXMjiUF3J6XdeQIf48wa31/vO3NX+hi0LMlG4GN8/GQqAGzhByE6nWJamPXfERUb+XKJuiESHhNEgwp+Hvfa5iMKldMy0Jcogc1ktHJbPrf4onku0iYCN7lcqck6KcK3s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ2PR10MB7600.namprd10.prod.outlook.com (2603:10b6:a03:543::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Wed, 1 Jan
 2025 09:49:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8293.000; Wed, 1 Jan 2025
 09:49:41 +0000
Message-ID: <fd96b082-9cd6-41d4-9fa1-1ed6b31532b0@oracle.com>
Date: Wed, 1 Jan 2025 15:19:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] btrfs: add btrfs_read_policy_to_enum helper and
 refactor read policy store
From: Anand Jain <anand.jain@oracle.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>, WenRuo Qu <wqu@suse.com>,
        "hrx@bupt.moe" <hrx@bupt.moe>,
        "waxhead@dirtcellar.net" <waxhead@dirtcellar.net>
References: <cover.1734370092.git.anand.jain@oracle.com>
 <9fcc9f01bdab846db231b427f98fbb3e9df7c7a5.1734370092.git.anand.jain@oracle.com>
 <n4wm5d2p4ghpmxs2okidq3iz6obrtrke4ia42zws3dk6j3suvq@gbit366pij6s>
 <bee14a7b-1ecd-4dd4-9bc5-2c71a1e314e9@oracle.com>
Content-Language: en-US
In-Reply-To: <bee14a7b-1ecd-4dd4-9bc5-2c71a1e314e9@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ2PR10MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 965df79d-80e8-4719-fa8a-08dd2a499cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEdBT2Q3NTVveVA3SnA2WmlOWTN6b0w1YTY1d1FndE8vQWNQOHhiZnE1MTFE?=
 =?utf-8?B?dWRoeUl3Q0U3Zmppd3V6Z00yOEdiS0lrUzJ6MEpFSXAzU05iUkFxMG94ckYx?=
 =?utf-8?B?dWxhYVhENnF2bExKRlpRMVRkaUR2WjAxNDRtSHF1Y2pPZHlPV0U3dEpoTlRw?=
 =?utf-8?B?R0R0Q1NFSXJ6NFZOVFU5UTZOdlNWa1lBTSsxVVJBMUhPd0MwZ3F2WTdYZDkr?=
 =?utf-8?B?WEJTT1ZyN0NRTExRam9FL2V5cC8wS1lkbjNsaVp6b3huNkRyVG9Nb2o0d3lY?=
 =?utf-8?B?MnRhamo3a01XdXdjd2p4d2RGcWoybGJ6aERlb0pvY0NTRVVRRHRIeDVNUHZ4?=
 =?utf-8?B?K2l0OHVBWnNNemtldE5rYWFnWlE3R3hLaVdSZGs2eDdrcXJDMlQwbXAvQWU4?=
 =?utf-8?B?bE42MEVrNFhQRmZWTDU5MmpEdWFsQUFRbXNDQWpodHJlM2wraGNwaHNqZEIx?=
 =?utf-8?B?alZ6bHorNVVQTEQ0c1NhNFFBSVJrZ1RDL0lTWmlpR0hwbG5BVmt1UGt0T2NJ?=
 =?utf-8?B?M2dSVEFDRHZxbmpxS2xIa0ZVL2RPa0svZXk3Vlo4SE5Qb01EcTB1SmxJcnp4?=
 =?utf-8?B?QThJWHNPOGtYUHgvSmpmdE5YaVM2QWZveWdxQWRNK3Z2WVlKL3dVOUdPYlJt?=
 =?utf-8?B?eEI1Mi9mM0svWE5LTUhyMGw1aEVvcGVJeTRIMXVvclhXSnRJRVFmRVlzczJT?=
 =?utf-8?B?dnE3WDNPM3I3d3dKMjdXYk93bjcwOXlab3FWeXFtNTRvcFJsaWZhN0k5Qk1N?=
 =?utf-8?B?NVNyMmlnTzJkS0I5RGtjc3RlbkNyWWVCWXA3eXQ1TkZGT1VnK0pDU0JYOFBo?=
 =?utf-8?B?Zm1CcGp6U2lUNjdSM1g0SXJsV1Y0b3hFZGVWVlFCb2RpOXVmZFNXR09STmtO?=
 =?utf-8?B?VWVqTWpma1F6MmdPWE81TzJWRWE4MkUvM3VuQ1JPVmptSE9HNTh0RkY4d2xC?=
 =?utf-8?B?UlNxaW9JWFNxZDV0OXVNQ21aeXVsS0hrK01OOU90bUU3bkVxeEZGZ2lPM3Ri?=
 =?utf-8?B?NHdXVXRwNlhSNGt0VFp1MlpIdHBqSGJNLzhEekdLWldIT05SK2Y1UGZ1Qytu?=
 =?utf-8?B?Wko1Qk02TXUvdnNmVzdLd3FTcjhmVnRUc0s1Z04wL1JuOG1EbGZzOEp4aW1G?=
 =?utf-8?B?YlhJak41bk1iV2x5S2FpMVdTbDNVd0hyK2cvNjN0THR3a1dyVWd2am5EaVZV?=
 =?utf-8?B?am1HaWFJbWFqcUk4Q2lxNVh5SnZQM3M1b1VUakhPUGljQ1JQeE9YOWQ2a3Nk?=
 =?utf-8?B?eVlnZkIyNVJsVTFvNGgrR1liK2ZKaEdyaFM0NjExbjI1MDhsSStOQTdYU1pH?=
 =?utf-8?B?ejZLNFZ3SFRqQ2VxbzlZNk9TS1ZMajNCQkJzeDJyU2VkR0xvWUVEVzlzTTlX?=
 =?utf-8?B?VVBsU2lscm92cjlYSEh6MTluQmREcVpTSzRxajlkeW5Da0NYbGhmb015ZEFV?=
 =?utf-8?B?N3dBcUkwVFdHYjJFOXpEdnRjRVYyRVllRWhDOHdtdEpEZldERHh1ZTFleTVm?=
 =?utf-8?B?QVYrUy9QeWJSUW8vU29aYUZHK3M4RHg0N0hYay9FemZhK2RCR05JZjBTVWVo?=
 =?utf-8?B?NVkxWERIMjVrWWpYbnVwU2sybjhaY01nNVVrazZhZnVnZkRrZ1ZuZ1V2aXNB?=
 =?utf-8?B?WjJVb0sxZFlGMmFneWsrU2g3ZXFkNmhyVVVkQ3ZKeWZFVVVuRzliWEltK1E4?=
 =?utf-8?B?VXU0bThJemFWUFZFckM1bTNoVHVnamRYT0NRMUNVMVJZZHQ1d25pRFFXKzZQ?=
 =?utf-8?B?cmNlQ2lsemlNWWF1TVFSRDcyZU5TM3dFc0tuL1hiODdGaUx1TjhGdWhwVmFP?=
 =?utf-8?B?MjNWMExpaFAvaFVoaWpRcFcrL1hIUTlnUXhvZlVvdk80WjZIK0lwaHVVcnY3?=
 =?utf-8?Q?T7kEgivFg6Z9D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFpXeGl0d0wrNGgrTnJ2ZzBDNkdJV1Q4RXFvMndLbVcxOTQ1M3lFU2hNdjJJ?=
 =?utf-8?B?UllkakdmYVJpbXpEUlZrbHlIZGloRVVkTm95U01RblgrU1V1N3Z3WFVDVFJO?=
 =?utf-8?B?RUZlVG5lU2ZDNzJXMzhVZHFJc1hNeDB2RnRkZXEvZUc5M3pqVkIyWkdVY0ZW?=
 =?utf-8?B?WHVibFhTRmt0VGdLU01ERDJYUHovTUI5azVEaDZOWEhtczh6dGlFUG5kQmli?=
 =?utf-8?B?VlNENi9qVnRTaS9iMUpwWGRPZThGTmdkblV5Y28rbEh4cW01Zlo3Z0JrODYy?=
 =?utf-8?B?c1VvTTBiN3VuWUI1UnhHY0E0bUE0Umg3T01hRVNGbVdmNC9KYkF4TFRtMlhC?=
 =?utf-8?B?d0VWWlZJL3phbCtOWmIxT3FHNndYcFZkMXl2ZkJsL0x0N1NJQUVRNzJ4Ylc5?=
 =?utf-8?B?NldFYzRrc3BVcmVuZ2g5NE5iNWRGVGt5MkVtcnRZTUp5ZmlBb1pxTllEUlF5?=
 =?utf-8?B?MTE3bmZ4OUdOM0h1Qm9NTkVMSGZ4anUzeW81bTVKWnhhdmlZejExSFkrVzJT?=
 =?utf-8?B?K25IdnVteG5jeStUWDN6aVJpbWZUeU01MG9XczBVVk5TdWJtMDFKTE5YRzFx?=
 =?utf-8?B?TWZId2JqeXlVV2toN0FrOUdKa3QzTWJRcm5MV2ZFY0xiY1QyQ3VyRDh4alpI?=
 =?utf-8?B?dEdKeCsrVTBEajFpUTJyZHNXUnlZTVBmaGFkNUlTVzZqa1EyazEzK29vWTFE?=
 =?utf-8?B?Ym5XSTgvanRQK1BMWkovWUxpTUJYSGs0Nk4xd2JTcU9WbzA5am5HOTJ1M0c1?=
 =?utf-8?B?cHhxRk0yUHJNSlhhZkxrVHhVR1NOUjVVWndNT2dXTmM2dmJCeERZL2lvdGtQ?=
 =?utf-8?B?VTM4b3BQSzdidisydHVBTnBpdks1aGJjNDViREJDck1aWC9jRzQ3SUNMMG9z?=
 =?utf-8?B?cGkxY1FDYm5CbHZ2RUQ3THpPZ2dnQnMxRExSYUV1YUlLaHdPQlBVeVhrQlRY?=
 =?utf-8?B?T2pqeGNJVXVIN3Y4UngvWEZ1Rnd3RmdEdkRsRHFoazBxYUpOVW1mVWxJamsv?=
 =?utf-8?B?Z3M5eVBrUkF2djNXb1dKVVRybVd0cU9mUjZGeld5aTdMNEMwMzVZdG9WcjdJ?=
 =?utf-8?B?VXdJUy9ha0FzWlJNcjhmQ1RKOW5RQ25wN1A2OGZ0QnlHdEZseEN6aElSbkxB?=
 =?utf-8?B?UWxSYjE4Snp3LzN3RHhZTWpCY2RWWGZXT21mMXZRV01JL1QrQWcxT3YwbTBO?=
 =?utf-8?B?a1JVZzlQejFWVnUrNjducjk4MmlwbGZwV05adW1ULzFKQmhqVFk1TThJbUJB?=
 =?utf-8?B?L0M2MFg5N3RMYTQrVGpiVXVITEdPNGdUaTk1QkFSRjczV0p3RWJWMkI2cDZn?=
 =?utf-8?B?aE13ZmJsUVphSFhlRVBOTE9HWWpDY3RERjdaTWpOdDBmRE5sUXF1T3N4OGJT?=
 =?utf-8?B?YmlGUkwyTmdJQnNCeXIwWlB1THEvYXBWRGxOUGViQTFqK3U1M1hZWG9ueFF3?=
 =?utf-8?B?VjdQTGkrUU0zYUMwQndTZUY2VC9Fa25ldG42QWhqV0JDeTZSMmprRE81Rmxz?=
 =?utf-8?B?WVJyaEVoMlF3WkxRT2F6eGw1eTBxV0hTMk9XamVVQm9yWlpDOHNyd2Q2Qm5u?=
 =?utf-8?B?dEdJZG0vNjRHNmw5WUJHK25DTTBkeXdtZWpjcllHNU8zUXFFZEJVZmdqeERq?=
 =?utf-8?B?QU1zM3JrUU5uQVVqaU84SFIvQkFkNWFiaTNobmk4TGtORVRXMW9ySEpmYmVN?=
 =?utf-8?B?OXdNaHFaVmN3YWRVT3h0Ly9VdXJzb3I2MU5aOWRqaVZFL3BzOElZSUNHOUJF?=
 =?utf-8?B?dzhEdjQ4eUM0ais5RDREUGtwdjR6cTF5aUNKczlqc0o4RktVQXdOOTF2Qk9M?=
 =?utf-8?B?R0JtZDRBWFQ3TTVUUFRDNXJUc09PL0pDdVN6bmhIclZla3pyOERIQmpobmFl?=
 =?utf-8?B?UnJBV3QwR0NFa1NKZjlsOHZ4V3l5b0p0elJSQ3NsSlVzaVdYcllMck5uS0V2?=
 =?utf-8?B?dS8zSGJiOWlhd3lXYUxmTllUV1grbTgwN2VTckhIMXBLZUZnYTdGREdXRk5S?=
 =?utf-8?B?T3RTNnVMODNoVHNTMHEzb2VJTEQ0MXBpODFFKzEvWWFTWDZFVzNJeUxwWFd4?=
 =?utf-8?B?RmRxTEI1cUVINTJ3UHV1Q1hucjRYMXJKSnJKK0REbHd6Vml2WVIxclNQRm1s?=
 =?utf-8?B?Y2xtNWlkaVZ3WjJVM0FZYnBkcnRGUEZoQU90RXFNUENRcGNic2lvRC90WFBj?=
 =?utf-8?Q?miOWV+mR7a8RIv+QsNbs3QorXYAOovczNNfZ33XPzpqv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	erXR4CJoxGghIMqs5GsAx/GmUVwuGAMjSqLhM0cuxM0B48w2MekNwzOZCvbGjFgbPAZhp0ZmnijFlvqFtzcyWbOI61jrtLlgItjarhoaBt63T5I/ak+ACzA7V7U1l71a9JC4RCqezJlcxaXT9/nsAlSDqq+TloPR0M3WzQHQbqKK0OzAmzQawTTv0uJG/B3QppOvZj03/IIJjxXT/1eDVvcKEVsq59eU+aqChmzb58JMlwSnYn3MBQzP4b65nvXlZe8Cpy+l/FDOgx8oTJZuwE6n+EF8dygAln26kSQSBUu6EGRrhaoIviq0lAgT7HKylcbhguGl2lxRa76F2/4cJP5uieksuxj91vWwL/silkoci3TGcHAaqAOtT9cT57tQ3b+MVgMdZAdAzY4k7ttqK+qhy06q4RetSIdVZTbNlDKxnwjchw6peY899AnPyctbCZIZSPVTVmf1q+XsFu3ufit6bEKGtKwBb0cfQWJ4NGzOHW2s2vBoVFQhTTj2ZpaO8xznMEbLvUfhsYx7YVglG7JZOIRY9PkM/ZB7AijGVHAP9UsdUbtRRewo8uvV4+ri4bEMsMv3U3YLNOlKRHkjnfsY4HHR2+TwPThaMY6D0ow=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965df79d-80e8-4719-fa8a-08dd2a499cfe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2025 09:49:41.6579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvNUQdMjo/SjFOdGkuZkbD25IV3+11/z4GqjzwWk6Rgsqd4sjl8w173VG661JV3ZIzBlyhJPEly2aYQ3dKGt9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-01_04,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501010084
X-Proofpoint-ORIG-GUID: gfnVqpOFT_GjmFjl355dcDoTI1pQKMOt
X-Proofpoint-GUID: gfnVqpOFT_GjmFjl355dcDoTI1pQKMOt


>>> +    for (index = 0; index < BTRFS_NR_READ_POLICY; index++) {
>>> +        if (sysfs_streq(param, btrfs_read_policy_name[index])) {
>>> +            found = true;
>>> +            break;
>>> +        }
>>> +    }
>>> +
>>> +    if (found)
>>> +        return index;
>>> +
>>> +    return -EINVAL;
>>
>> We can replace the logic with sysfs_match_string().

This has been fixed as well, in the local ws.


Thanks, Anand

