Return-Path: <linux-btrfs+bounces-13477-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42223A9FE13
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 02:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9881B60174
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 00:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A4D4C76;
	Tue, 29 Apr 2025 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b="moTxbj7o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-007b0c01.pphosted.com (mx0a-007b0c01.pphosted.com [205.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6328BEAF6;
	Tue, 29 Apr 2025 00:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745885087; cv=fail; b=oHWGITKLWIBs+PQp/Hf4Wy050bhyqDD7UglEOOjTn/DeXFc3L5uWTC//1PykwolNXwUYyTEy5VuG2MrqUNkb1yWGfEqsdB0codfochuhj1hffhOx2PVkPjsmxfcX9RB1Hu0GPy6gYa3hYg9v27RLpeh1cu6J57bKJihJtFAP6hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745885087; c=relaxed/simple;
	bh=DkBLOxc0W9rt+ZI9SnFhbHKPjJe/NOAs29/3FgGtfIw=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=sZKN4V1nAusH4sZhG56SYTvbk7TsbqW5XGbDQxF+3gu9cZwuQouF8FeOZQaEL8MtOlTBaahtnnbzv08sH2mtgZB/nzaLV5owMhH5Y333nFogeh4cCmrtHrtpYVmu4UMSXHYDfmThhBKlis6VU+kJMObxbASHFH6jJwL+mtjuGOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu; spf=pass smtp.mailfrom=cs.wisc.edu; dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b=moTxbj7o; arc=fail smtp.client-ip=205.220.165.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.wisc.edu
Received: from pps.filterd (m0316040.ppops.net [127.0.0.1])
	by mx0a-007b0c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SInIl6008448;
	Mon, 28 Apr 2025 18:24:15 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by mx0a-007b0c01.pphosted.com (PPS) with ESMTPS id 469jb4xdmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 18:24:15 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5hMAAyR699zWyWnxd3PBQ79IdyMCm6atRQ9jW68iHnkk2hnuEoEdAPl7SCHsHY9/fv2F00L1kJviA0dcZ9P8GBsfkMYTZB7Q3OY3mOBKqggO23oFnuthJQCDpiAvw0pqcOYHcVF/PHS4Ni13lkkDwUpCvidL1PNoRVTq8Aj3Kyh9IOzdp8ZmatE4K8xABgbDW4aPjlEjTzCX3XzIIkG57NhPSB2xO/uk1JamkFtdc2rw9kSN6rq3Z4qeHD6Urudi+MRql82+bXVuD+LiqjP5CJlo7GSpAz5svcZiAA9VgZRne4Lln///hc2CobB0/bHt79EYXmiJPZDZGI5zpgX5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1QJBBWmbw70K3+kXLSxSAQWdWUDhl9QG+Hd9OiZivU=;
 b=L88rzRjAvnzGe7s9/dm8+bFU+G0u0AxEm98e1tgKgTLP13013B+inr1TDv1w3mDk0iVwh7WN0i7MqfUUg62XxRJEJMowKUjLj6/3WgcoeIW8eYDTx4YwWzeZhhc7+SuUVxXLNhPv/L+etxzj/4DqLtT99VQu4XPcREoDsZ42SZzJOhmtH2Ccc/43sj0MxUrw2pKvN5uC2RoYESoGiFpaiLPhVS6UsYs80UzyPR3vmnW/wD7kxsjW74WkEujs/urMoPxaj5hgQ3AsibIJ2LnLpk9t0Q66QpQk/ltmGjmEZFam1mgzQH5NMjTM4q8WERDyeh1qYX+L38YcJVkWLw8Apw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.wisc.edu; dmarc=pass action=none header.from=cs.wisc.edu;
 dkim=pass header.d=cs.wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1QJBBWmbw70K3+kXLSxSAQWdWUDhl9QG+Hd9OiZivU=;
 b=moTxbj7oJMzQqjNZC8lfXoeaqzqQ2I8Lpqc+pAHDK85GFRMU2IgQZK6hGJOanpnYnWUyWPrx1uvNkSc7gMgRhoAs/KTAdWJ8Z/QPWMlGGyGnZfIeC12Yy/xyIhsiMfPZV6uJHI2KXFJG5AdN3/lsfq9dfct67XM1KwuFciS9/aX7rFz8VQSxJEDGpcuq0wIWM3EpWZh/TVrSdNciopVll0MWd5rvq/pkDmWe6Xv2Vleunm8MNAWFsEv7l1KxRt/02dd1hqb+Of+iRy0hYZ1wntiRI3nn5X7l/Zk1X+yadjg5FC0MzubAQr6YfdeSLpDk+kRA74JWC07HkPsP3VWsJQ==
Received: from DS7PR06MB6808.namprd06.prod.outlook.com (2603:10b6:5:2d2::10)
 by DM8PR06MB7766.namprd06.prod.outlook.com (2603:10b6:8:3e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.32; Mon, 28 Apr
 2025 23:23:41 +0000
Received: from DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c]) by DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 23:23:41 +0000
Message-ID: <5ee9b1d7-4772-4404-b972-93b01ed1e033@cs.wisc.edu>
Date: Mon, 28 Apr 2025 18:23:39 -0500
User-Agent: Mozilla Thunderbird
From: Junxuan Liao <ljx@cs.wisc.edu>
Content-Language: en-US
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: btrfs thread_pool_size logic out of sync with workqueue
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:208:530::18) To DS7PR06MB6808.namprd06.prod.outlook.com
 (2603:10b6:5:2d2::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR06MB6808:EE_|DM8PR06MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: f1cac411-35ca-472b-39d9-08dd86abb60b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|41320700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFhrL09QazR5K01FTThzbFFiUWFNWEF6cDhhQ0ZzVmtPUWEvTVJwc1AyMnhx?=
 =?utf-8?B?UmRQd0d6empPL0dyNUdRdHFRRUh4ZHdmUy9QVTROdWNRY0hwRXJNRnhLOFBj?=
 =?utf-8?B?OUF3NWdEM09ZdVNTQi9nVkhhMzQxSk5Vd0FKVW9VOFFZMm5PUlBqSjFNWEhq?=
 =?utf-8?B?YVhaejFDRW85WFA5RE9OaDk1dWMvL2VNT0JNSXVpNGYyaU5yVnlpQ3lMaXpK?=
 =?utf-8?B?OW56K0NNTkNzYzNsMkpMaXlzczY3YmRNQ1dNRjBDT2ZJU0xiMU5CN3VPTlhp?=
 =?utf-8?B?dmtSNUpqVmZqUXE0U2FPL09meWIxWUJxWWllcHNmdGpiMWJISk1nTXh3amo2?=
 =?utf-8?B?ZW56cVRzdGxxZWcxdm9saVJLNHREUzZLTDVGcGE2Z1F0dFBXUGFaSmNBZDht?=
 =?utf-8?B?bFZnT2lraVVmVHByQ0dsbHM0ZkZsb1B0UTdrQTJ6Q0hjUmJyTXBYNElVajJL?=
 =?utf-8?B?WWg5OVp3ZkFXeFhQaXFuZjhHZ2NORGxDVEczbGxxVWlyU3RrSm9IaWpGWEJD?=
 =?utf-8?B?SGFqOHZzU3d6ckdMRHVjMHVVM2JiSEY5TllrQVpIbVRMeGNtTmRJTUlwT2hJ?=
 =?utf-8?B?U24xai90WmsvUU9Xd08yd1RWeFBhTFpqUUFHOGpUa1Y1NVBTZU4rcjJ3Sm42?=
 =?utf-8?B?WHQ4NDBDTG5qYmc1aXFIMXJUMmJXNkxsdkI4TVB3TWhxWkQwaGxVRjhkbFd3?=
 =?utf-8?B?YTdPTysrZ1BJbU1NMFRxMUdZckw4cit6VjNQL0I0b2xNcHE4UXZ1ZDNlV3dD?=
 =?utf-8?B?ODdISGdLczJXRlRCOGRmUjFtcUhSUFBwd3pTaXRYanJGekNEU0tQT2RPeUNY?=
 =?utf-8?B?M2xKZUZVdThaZW05dEZQYTJ4Y3VEeHdIRVAzK2NJbnZmYWN5UjdEc1pUcHI1?=
 =?utf-8?B?S003Q0pBaDZyTkhobnJRZlFTQUM0a0Z4K2U4cDNneHoxUEwzK04zRnBDbWVG?=
 =?utf-8?B?RkRMczBHdlUxVlZudWFJNTlHYzRRNXUzZS8zNXlRMXBDck0vaHd4aXBKRG1L?=
 =?utf-8?B?a0lIWm50NjFjdUZqUjI2bHNsTURHVDQ5Q2VUcnQ1UHZpZ0lHMHIrSFNmSUJF?=
 =?utf-8?B?c1kwRU0wbXBhd2xoYlEzOUgwU0FGMGh4KzNOWTcrRHA4cExHTmpyTWZUMUFJ?=
 =?utf-8?B?NmdpUW9TMk10Z3hyUC9WMGdOMGtjeTVSRVNXMDNtSzRKWnpyUFJHd2RuVnZH?=
 =?utf-8?B?UjJ3SXVPWVdlT0dkMStjVkY1SUpEYXgrZ0lGdlQ5N0VIUGZUYXJHYkJaaDhY?=
 =?utf-8?B?K2dOejM0cTlFa1h6NU5LdG81dVpCejZvSGxZbUp1elR5QUpGZmRkQTZNbm1a?=
 =?utf-8?B?T1JVYnE0aTY4UnorOTVad2oyTTdFZ0twdHR0WnlMVi82bkVCTForQUJtTXZM?=
 =?utf-8?B?bUpIZ1o0eW1mN3pOOTRRdU9RN1lrN1lKYU1wUHMzQjRQbUNML09CZmttVDhG?=
 =?utf-8?B?SjZ0UDQzRHlZakREZFF0M1ZTSld3Y0FYdGRGNDVPNlRmNDFrTUhGNGpnUW1J?=
 =?utf-8?B?UGlST0hYTE9mdXpQbmVKS2xUS2dNMVBwMkluZGI5L25TN3ZIU3VKczRsTFdS?=
 =?utf-8?B?Z1hWamVPUERHemN0RGx0aXNScmYyaE9DM3ZsNy82alp6ZXVSWkh0UHo1RUl6?=
 =?utf-8?B?amhGeTNXdHJ5NXlrTWJ3OUkxeUFZVXNxWE8xcVRrK3oySnMzMXNVLzBCaVlN?=
 =?utf-8?B?amovSEZoOW1tTysyUFdXMnFPMHZtOExBMkthRkhBQ3R6aE45NlB6R2JteStp?=
 =?utf-8?B?Y0k5ZHN3Y0JoZ0lqTzk4Mzlna0V3Mk51NmM1Wm1kV2tKSDdneDF4LytTNHBo?=
 =?utf-8?B?dEo2L3hLTmRyY0hoalhGSi9ETWlBWnozcTRpY0J3VFd1RFFHazZuT3pxYVl3?=
 =?utf-8?B?VDNiSjh0c1BRb0VkOUhRNzFtYzNaYy9adUFPbDNWVXBnZTJnMWduM3NyOWNH?=
 =?utf-8?Q?6wn0Vmrb7KM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR06MB6808.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(41320700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEpFS1NoTjJWSTJqTTdTWHdPcWkxQTFPQk5hdXZ2V01TbG96cGRheHVLQWll?=
 =?utf-8?B?RWNlUHlTUVQyZjY3N0t1a1Z1RFdLNkwwYTA3TWVveVBjanZCeXVZZk5MTlFt?=
 =?utf-8?B?RHY3ZFh5WmYyYlFjMERybmtaeU1VcHNJbDZSN1k3bXU5MUZtaVc0S2tGdjUw?=
 =?utf-8?B?b3pLRnAwc1V6M1lzL0JDRnU4Znlwa2kzM0NkaGltNjd4WDZlSzR0MjllaWFT?=
 =?utf-8?B?dVNEWGVyakdRK3drREFvbWNyMEZtenZSN2xsYWhhTkpyczZuZlRNUmJCeUtO?=
 =?utf-8?B?dnMxMDROUnhzU3A2T0JhODltMWEzM0F6MFl0dGE5bVpiT2hZOWNIMVg0ampD?=
 =?utf-8?B?YnFWeUUyTkpvejJSZGlFTFEvbGd5RW1oUmNVS2VoWTJHSjQ1K1UwUFpiSXE0?=
 =?utf-8?B?UGNwWUY2NmI2SGk5ekxoVDA5VkZ0ajhzdEl0UTJ6VXpEZ3hZSmlGM2ZGQU41?=
 =?utf-8?B?YkdreWZZQXVDZk9nSGkyaGRyNmoySkl0WjNqOS8vd2Zkc1Z4ZGc3Yytra3lB?=
 =?utf-8?B?RWY1R3g0VHNHTktlalNMbjJGZU5mWFU1dVBZZndpUi9DcE9jbk1BdGpFVlhK?=
 =?utf-8?B?d1NWdk8rQXVBOWdRVHYxZWJkT3ppdFdKSGg3N0RmZkNaYXgxbnU5OWFwbTJp?=
 =?utf-8?B?aE13Mm8xdGRjTmFXdUVHTGNmeE45eG0vK3BmNjltcklXWGx5UnJmVG14dkR4?=
 =?utf-8?B?NVhjLzVYWHh3Q2RpRFQ5ZXRCeGpaYkJySkRZcXZaU0ErcDQydDYvNlh2d0NG?=
 =?utf-8?B?bGg4bDB2RE16OUZqSE9LbjEzSkh6RnpGd3M4YUV0alp3aDdZaXp4SjBpbExM?=
 =?utf-8?B?bjEzR0hMWVUwR3MwZlpSWGVWZmVXdmJUd1A2OW5ldkR4cFp3cGV6dVNvOUF4?=
 =?utf-8?B?N1NGWGFVZ1JMV1VFeXNmZEJmSkt5T3ZhNm5IL0ozSlBKeDZ3bmxLcWRjNWFn?=
 =?utf-8?B?WVNTT3RlTFdVSndzMmpFRW44NTgrWjZjT1lCSUZTY2JBNzloWXBmNUJrM2RG?=
 =?utf-8?B?TkI1K2FDVldIMzVMcmdxZlkwb25jcGJZTWlKaXZ6N2hsOU1xdzlQOFdadGhm?=
 =?utf-8?B?MUdsQ1ZUMGpwL3IvQXRaTkRJdkhBSzcwNmJSRGdGeUNmN251Q2dLa1NrRlkz?=
 =?utf-8?B?N1AzRWJXVWFqLzl6QjNXYzB0WEN6ekN6NmNsbWtxMERqK1VHMG9ucFFsaE0w?=
 =?utf-8?B?a3BSVEhVZk9NYmx6am1MN3AxOG5EdDdlZ0UvZmhLOFR2bytrS2VPSDFvR3NE?=
 =?utf-8?B?S3o4aWtuTktYVm1yaWZTazJGNytLVTdxRC8xS3V5Q3BmNCsrV3M1Ym10cjBJ?=
 =?utf-8?B?YmVwYkk1SDlyS2JkK3V1L0hUeU1CYXdzc0liZmxTbmhuMnNWK056cHAwQ0dK?=
 =?utf-8?B?ZnY1bEhDbmVLM2t4bFhJbjRTRkFLWVc0SkcvVzVKRWZtWTY5emMvTTArbzZO?=
 =?utf-8?B?MEJsNXdST09GSk9tVWNLbnZ0SUNEa1dMcWdpUCtnMnBiSEFYTDB1YUtZc1V2?=
 =?utf-8?B?VkxRdEVHTVFNWjkwUnRBME1SaXpMOHhFNlVXWWpVdlZDYmlnOUFiUHE0cEc0?=
 =?utf-8?B?TElKbjkyejN5RTVKNVV0TGw0b2lhbnNXRDF5QlFaWXBHcVo4OWhiN09tcDA5?=
 =?utf-8?B?aWpMSHZNSmUxcEZ4T2lKU3IwbEs2SlVNeHVJdWYwSTFaKzQ4ZEs3WUNRRkdM?=
 =?utf-8?B?bUhaUUYyMVpKYmJEeGs2eTEzUWZ0NnBKeE5wdUFZRkIrOFk1UHBrUFFKd3U4?=
 =?utf-8?B?d05jRXlYS2d5UTJmNm1kNllVWThGcTJzaldMU0xISHdvZlhLb0VkRXFvazBi?=
 =?utf-8?B?UWJiaVpKZ081L0cxcDQweGJKK2tjZWxwblB4UUZjcERPbHV1OVlQVXUzMjFp?=
 =?utf-8?B?YndnQ202YXJ6dEJoQkRZd1RiK0o3M0xSaExuVU1LNzZidThyektab2VKN1ZQ?=
 =?utf-8?B?bHlNbzJyb2QvRzlvOTVBRy9nMEl4aGtGSmNQYjZRTVIyK2h0U3FaMHNVUGdi?=
 =?utf-8?B?bEVzMVlwcVBOVzIwMnZkRTdnZjFTeDlhalNwekNzWnRPL1FvV2xSNnNFZXNN?=
 =?utf-8?B?dDJRWkpqQjdyaU8zWURqTi9kellQc0VQOStGUjRmd1hSYXIyWmpRa3hxMnFU?=
 =?utf-8?Q?H0uE=3D?=
X-OriginatorOrg: cs.wisc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f1cac411-35ca-472b-39d9-08dd86abb60b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR06MB6808.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 23:23:41.0814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYGS1iKc3OWaMk//fyqc7vjlDMC+wzTynFkO/0SVandEooRZUl/a0vh2r4l1oGae5AjdmaaKHR85FBrEFa2EDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR06MB7766
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDE4NyBTYWx0ZWRfXyPc9AKVbMLUP bTQUNIkLMJiEO5k/lUs87pif3HNl0+ERZsQ6U0JVbrD4bzHzAbHUE0wB5xWVlSNsZK7wu/kWDJh tnyfcQRLKCJTUAry8Ia+eSW1RokAWPBUi7grE96eze14CUaJ2KP5z/yT3Pjmko+ZnwYAo6fsbDo
 C+0yRSmeqlApLIC6vbAr4DTci8EXLq3jkQIqcSTeacZy4bvUXpe1E/6hfwK21hMtIIemTUmUaTW HdyqaRzItX6LBqSpwQcAigim8hBZQpNZ3BMN3BSzcHgkk5bw8CBBJRwhHtJLSMnrns3kc1dl7iQ mgkVAPdbhWxMHoQeZNhcZYU8Pt0tU57Wxv1uTfGVLQy9s4vg8lRwOdN7jPnke3N2FDRzeJejvKW
 RjbACWYdGGaXPrlz/6fytAwH1anUeKtIQGVUSgYdvTeZisJOGwsoVYhN/SKHGZQVrMs46aDY
X-Proofpoint-ORIG-GUID: SxztMadwmnriWnd0hGy80h2VFsoRQj5c
X-Proofpoint-GUID: SxztMadwmnriWnd0hGy80h2VFsoRQj5c
X-Authority-Analysis: v=2.4 cv=LpiSymdc c=1 sm=1 tr=0 ts=68100e1f cx=c_pps a=H8RDR50mQ1szzU+C1Tr1+Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=3-xYBkHg-QkA:10 a=YumDR-uA2YnmjVm-HtoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 impostorscore=0 clxscore=1011 spamscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280187

Hi all,

Commit 636b927eba5bc63375 (workqueue: Make unbound workqueues to use
per-cpu pool_workqueues) makes max_active per CPU for unbounded
workqueues as well, but thread_pool_size in btrfs_fs_info and the mount
option thread_pool still assume the limit is global.

e.g. The default value of 8 allows a total of 64 workers on an 8-CPU
machine.

As far as I know, this means that on the Btrfs side we can no longer
control the concurrency level at the same granularity as before. We
should rewrite the auto-scaling logic, change the default
thread_pool_size value, and update the documentation. 

Am I missing something?

-- 
Thanks,
Junxuan

