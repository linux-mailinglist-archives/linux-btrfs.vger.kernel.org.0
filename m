Return-Path: <linux-btrfs+bounces-9802-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7098F9D46EB
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2024 05:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B13B21CCF
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2024 04:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D0813D638;
	Thu, 21 Nov 2024 04:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="osNVbc9U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GRefd5cI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE531CA84;
	Thu, 21 Nov 2024 04:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732164196; cv=fail; b=Q4I4E2mmnZVvb5Fn/kZksJKTb90xDzNGgZSY9v19T0PkJ8lqgfxlkY/xCpAnJiID7KhGCJMh7eje1M5qtTjMjnzKEvSUJ2mMkbUjH2K+1UEZmPT2sODFgjGS2WyHb8mwaMUrmE/LaaTxSxDjv0ZH+I56egFnCHMvHcl0v1ZD/vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732164196; c=relaxed/simple;
	bh=IhhN8DljAd3C3iBRrWRmA5qu8vnf8kJlLF7XWAWvnzc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a8UBBuh6RIKlFnpO+qRmMVs2mFdrTroz/Wspj2bShryFO8X/NORoVEOBHY5PzUSCG714mpUPnxsnCahJrfTWEiw/TZ8BEwHS7BtKHGvrvRAwl5rQGR2Wug1Lmm+VHAnYn9pF8wih5pqB/2KKEDHAWZfjrmQnKKunuJzrVvuVlV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=osNVbc9U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GRefd5cI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL1fbj3001040;
	Thu, 21 Nov 2024 04:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wF+3Ws/eyz5l78JfZ2NRJ64tlNMmd2IlC5Qu8MoNCA8=; b=
	osNVbc9UG0kPg/ehU+Gj6uhjStDjszF7lAfrzlUlCa88JyHE5JsZUDC6rdQteZR8
	Cd6YkNsNFRp8NVrZf5emABdRVA0h5JmsNbgAc6e60sYGe/KfnL4p64huDt2a1GQi
	usx+eZUGy2ilN+UxUYfDYVDWxnMBSlgZN5+FbCePrpDIttzQ9Z0xt4XH+14q7Cpc
	2/6Ex0+KktRIdKPOxZaY7+fM1x3Ew/dl0C4qeunoLSNNXa/PXeE8+ZOzSnz/GrKV
	/uPekExwslHW/F82/bVhM7Y1D+sGFPIe4uv52yUtPWr+EhfamlRzMDVqHj1tij0f
	TO1mcBjrc2NO8Wyv1IK5DQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 430xv4ud98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 04:43:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL353p4039224;
	Thu, 21 Nov 2024 04:43:07 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhub07w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 04:43:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aglG/6CUxq+/ASR1Le7TrdZjQcm88jCqfB3LdHZM7cGSv3gegXPQK/YeZgIeRLERJO3PyDe8bovaICALQW3J6ymachez0Ra/jVS+JF99vj68uqOEHM0fu4Lzq494sHJnsVG5Z7nFyL3jW2cHkdxSK0UvGq4Hm1YleD42u79qOKXl4896JKS11Znup3b6m4El2zX9CZ7c7blCjFo8n/8UpdOj4XDy0i2NPQiG2cFjfJ+4paALRNq0oolIHG+d/ZKO+irZ6Yx6LXmPfdGFHQFNUgrcuyH3hU9zup8uFWvM7llPMWLvbc3jvfAbTNRnXNjrg5ZX1Tti/6lDRvFAu775zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wF+3Ws/eyz5l78JfZ2NRJ64tlNMmd2IlC5Qu8MoNCA8=;
 b=IXQZ9jftk2aIwdzqg00CEep+eTPwp5kPLa9ZQ4Wj/kMWVdybSYZrUexQ5daQX6vQmhZ10Ic0vpuWgR5QMQV8p7RMQ3FGgpPhMxgULUwHE1f2VeP/8GAYOwcf52Dbp4i1n8LY0g26ZCHtMhTag07+8klBHY5tmOyaE6bQLS1L1Ta2tQbVmgk82+jxNEAm0+CTUsz1Mt9Ggc5ITSesN8qKY3HhMA6JaOrWEjZRfJQJQQ6nUzsftOsOzcMyhN0sXJ2HXO6RCS9CzLohksOjFMw7pLmmKC4dcZK9/BrQWFtj8P/2c8k78twYjGF7m/1X3o673iP/+voP3nrxOsbK1UiRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wF+3Ws/eyz5l78JfZ2NRJ64tlNMmd2IlC5Qu8MoNCA8=;
 b=GRefd5cI9VC+/Ry5oNNqYokxwv+VKL9eaJbcW0Q2wgWA1x9LsGeDhFl3IK27+NOaoF232HnF/LuTdtwtUs+dp1oDghNdLjD0MBYnxHYm3Z/jh8pl1rRnX9wgsDkXs7Ld2OFon89SOPIfMPXq/dK6KGqam9ib4s5XgMCM6Tx0fTM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH4PR10MB8124.namprd10.prod.outlook.com (2603:10b6:610:23a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Thu, 21 Nov
 2024 04:43:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 04:43:04 +0000
Message-ID: <a49ecc5f-2706-4e25-ac99-59adf5232d05@oracle.com>
Date: Thu, 21 Nov 2024 12:43:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add test for encoded reads
To: Mark Harmstone <maharmstone@meta.com>, Zorro Lang <zlang@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "zlang@kernel.org" <zlang@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <20241111145547.3214398-1-maharmstone@fb.com>
 <bf3e4e63-6496-46f9-972c-c0b5c7c4de39@wdc.com>
 <28c2834b-3223-4191-bb10-81ce53c010a1@meta.com>
 <20241114050631.x3urk2ti4ukgtaai@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <bbeea4ec-2f77-47fd-ab5c-6319d4248496@meta.com>
 <aef2abd7-8cda-4e5c-981d-3ac6da04335b@wdc.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <aef2abd7-8cda-4e5c-981d-3ac6da04335b@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0084.apcprd02.prod.outlook.com
 (2603:1096:4:90::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH4PR10MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3d4feb-2315-434d-fcd1-08dd09e6fcb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnVlejA4SHJNVjJDeVJkUTd6dXEva2VJbTdyVkMvZXlkcmZFTlJvZVBqcWJW?=
 =?utf-8?B?RWk3TmlXZlRCQ25DUW1ibXRtSFN0U2dIdW84U00vMExFbFZ2OU1vT1hRU0w5?=
 =?utf-8?B?OEtUVWdkS0tQeHhOelFjazlhUTVEdDUxbWJ3YnVzSElqOExScFE2aFZ0cDE4?=
 =?utf-8?B?NVJCWnd2bXlaeThlTno1Z1hselhoYzBCSjFVY3FONmo3cDZTMytvc1gwMGRN?=
 =?utf-8?B?RWVpcXNIL1B1a2kxeFJaNXhNNVdqNjRDc0dMR2hkd0ZYOFAyVEVMSGtlQWpY?=
 =?utf-8?B?RENiVGtpOGxYMXRuOFczaHZVM3B4a1VXLzNWcFVGUE9lTnF0STFUSEEzQldi?=
 =?utf-8?B?TzdCeGliZGJxS3RDRU55RTNndUpySU1hbjBCY3krUytGTjVqWHpKMEZkZTZG?=
 =?utf-8?B?T2hUY1VTKzRlM1VPUTFTUytwNHpuOTdQZis1QjlhMmttQ0ZOc3p6NGFhN0Fq?=
 =?utf-8?B?TWhXSCtsZHBBUWtOekFTcW85MjF2WElzOEVFSElnMExyYmZQRHJxSFlySEwy?=
 =?utf-8?B?V0ZxVWl5bmJBdllrR1hvczBYaU52bUJBcitJSkpGemcwZGk1elVLS0p4NUhH?=
 =?utf-8?B?WTFITVJybTc1M3Axb3hFSVJZSXJ0a2NickYzS3pQa01IQjMxaVYrSzQzajhk?=
 =?utf-8?B?YUNmbXZYMEs4dkR4SVJmT2o1THNxeHVyaFZZZHBhQWtITXNGYjlCZUNwMEEv?=
 =?utf-8?B?R2orU1EvRE1KcG9ENjFaOVUxZmU5MUNBQy9haHEySlMrR2pQcS81Wnp1eDJI?=
 =?utf-8?B?c1cwYUFvRVVJcW5LVlBXMnpIc3V4QkRFZE1kcEt2UW1DUVF6R2dTZjNYcnAz?=
 =?utf-8?B?YzhtcWp4eWhNUU9ZcGx5MHdleS81RTRJY0dZWUUxVlFNK1RuQnZjVkNnbXd6?=
 =?utf-8?B?YXRPTWlrMnkzYnhhaWN6dUM1T1Bibkg2bTJDVWkxRmNuV1h3Rmt3ZzlKaXpy?=
 =?utf-8?B?U2lhOEQ1ZllxTXdVTEJ6Z29VNTdkWXJUK3crRVJsYWZrSUVMeDAzVmVMMEVo?=
 =?utf-8?B?UVZwUVNXWllHMUh4TDdxQUM3T0lOaEVzeDN1MWk2V2k0Z3VseENJWWk0RlJN?=
 =?utf-8?B?dXQ0d0VuMFRURWJ0UFQyazk2di9Qb2R6amlNdm9qUEljNlR1dHcxM2FrZWVW?=
 =?utf-8?B?NTB6bkh1a0hpQ1pmVVJ5QVYyOEJiZDI2cG1jVzBZbTJGQ2ZQQnFZM3MyZ09a?=
 =?utf-8?B?K1JKNGF2UmxuRVdJRGQ5VHg3RGtBeWR2ZTFRaTlwc1UwT0lwUEZkbVFJNVlH?=
 =?utf-8?B?QmpJQndYUk5iZ0NVZDgzSEJkc3JFWitHQU8vRmkxdU9obHBDcTJyTXNVWSsw?=
 =?utf-8?B?Yy90SVE5ZWFnOExBR1dYWk1KVlNpMXp5NGxpMXRGQitIU0VlN2tXSll6VFZj?=
 =?utf-8?B?Y0pNQjgvckpTb3pVcGlyd2RXNTU4eDNjMGp0VWdHOURWSTMyYTZzYkhKUVZ2?=
 =?utf-8?B?eXBlWmV5OG9HVXBtRmVnRktlM3F5L1Zjb0RrL2NCMzgxUCtBSXJKajhjcHFJ?=
 =?utf-8?B?U1NrSllvdTliVnhVMzlTZzhSYjNFSlowS2xzNXRoaW8rd2EyZTRkVllVL2ZO?=
 =?utf-8?B?OEN3Q0Rod0ZXZDlKVTVvNTRtYU9QeGE0QWIyV3VUQ1BoeitOMlVFdFo3TlRj?=
 =?utf-8?B?MndlTWdqRnA1dXp1VlVpRlRuc2tMRU1Qc2I2U2drbSt2alVLUnplSm04ZXVV?=
 =?utf-8?B?ektDVU1wNTM1VXYwN3E0QjdHbFUrajVvWVRTaFB4MG5OTFFFTnZGZ3JyUk9V?=
 =?utf-8?Q?NE9/TBW2T0mAhx3clyCKoH2yB5nLSPs/AZvFWC2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTU1c2hUa3F1NUxuWXJiZUh0TnZSdkVWVTM1eTF1b05CZkRva2d3VGFQRlJm?=
 =?utf-8?B?Sit6bzIyN0x6UzRmS1RSMnRrZ3F3SGFvbWF3VHN2YTRTY3VtVCtIQVBMdlF5?=
 =?utf-8?B?Qk1WYUhkZytXZERlRFU3R3Q0bU5kdVVXUnBDU3p5N1ZDUDZNMU9Wc1BVMUhC?=
 =?utf-8?B?MzZ2MU1qMXJqdENOaTlTcnY4aHBFbG9yY1p4dUJiK2RKb3FWMlI2SllXWStj?=
 =?utf-8?B?cFFqSmFCOGZLdWRXYjVaRmUvMkNDbmkvdjIwWEdXUDVUVWtCTnVnU0NEZXZt?=
 =?utf-8?B?Myt2Wi9GUHovRUM4cVhrMkVnWW9MZm1jeVBhT0YvRi9xc2JuRWM5NkVHbkpZ?=
 =?utf-8?B?QWNmeW9IMzAzRzFhWHJ5OVZFUGFlRUd5YUxpOGgxNmkzdkttUEgwZTNJanUr?=
 =?utf-8?B?Q2xRTndpZ1QzaThOTzJ5SlFHSFVybVRwejgxOXVvenB0V1RoOGVYcUFXRFM4?=
 =?utf-8?B?cnZYaVM3QVlXZWZyZTRySS9vNlZtYlZSNVhxY2g1ZVJpazJpMWtocCtHb1lq?=
 =?utf-8?B?MDdnTmpoeDVHc051UEp2bzluSDdMV1ZCQ05MZGZZMGMxOUhneiszaWtuK0ZF?=
 =?utf-8?B?UVJSN3hUREh0QklUeFlwYWxiSU1NUDVrWEd0SzZndmlqclFPTTZYVG9jSHhz?=
 =?utf-8?B?UDRPNlQweEI3MkRUcnJIME40NUhLRlpyMnhlUHJGWHBwUHQ0b3pncUZFNVZk?=
 =?utf-8?B?UE5yOEQ5NldBYlpocmovTWpKR2xQam9zZHN1Z29EVXhzSU9UNjhiRzhvSmRP?=
 =?utf-8?B?Y0UyMnZJblhwMktzRmduNEcvT1l2aUtNTVR1bXBxMnQzUS9rQkM1ak9XbEJQ?=
 =?utf-8?B?YkpzV1RaYlc1SWNwRFRldUhMckgrTEZ1MDJ2SHVJMWFqOVNadzBzVGdVY0Vy?=
 =?utf-8?B?ZUdqd3BTS05LZDFKSUJGczhQTXcyRDJNMktVbXNkNWphRDREVkhEc2ltYXFq?=
 =?utf-8?B?dCttNWdSU2dBODJzSXEvTCtRSEg2VDh2OWNRY2RzanRBbVV5c0xBL0NiWEZi?=
 =?utf-8?B?dHJ4YSs1UGVqSVJIRktVdFc1VDRuL3FlS3UwczlFcnBWUGJCWGhKZUdLNzJT?=
 =?utf-8?B?WitNVzhUQTA4MHFZSzY2YlcwRTVPa2ZWTEROcUkxbk02Q2dCNjBZUkRBMndv?=
 =?utf-8?B?R3V2SzZ4eU11Z0dmZXprY09nZ1AwaDZMaC9KbkY4YnpiMEVnc1Yyb1FxclNp?=
 =?utf-8?B?NE9qVlQwSzY4eEQ4UVpEanlhRnpzZ2M5UUlBZzVwZkJhc0RjZWhVK1lRMmVl?=
 =?utf-8?B?U0RjS2xldXhITkJoSys2NDRxUTNPWVlPdVYrdnh0bjNjSm1TNjJlSFVsbUZ0?=
 =?utf-8?B?VzhkSU5wNlVRYjRhSFo0WW9xT3U2YVFISVVGNnFnV3hhT1plVmNodi84cklF?=
 =?utf-8?B?RlBQTzY1VVRLZFQyamtUNnkwSTUyeVVJZDJuM2E0SDlQNkRubk5WMDltTVc2?=
 =?utf-8?B?K01INDIvTmFpeVdaQjRyNm9YTmQyTS9HQ1RFYkFHTzFLNjBkRHhML2RmcXlj?=
 =?utf-8?B?alZqTVdoR05ZTWlGM1lxNVNRck1RN2cwUy81bTY3NUtnQVp6bGRMQ2ZYYjZS?=
 =?utf-8?B?V1ROV29wZ1Y3RC9kV0tId0VaT0gvNVdheTdxZUJGa2F6VTlIcDlRZ0syRklV?=
 =?utf-8?B?N1Zqb1UrdzIrVm1rUUhiV00xMTBiUEdjcVZ6YlZzSGRVRFpTR3cya3EwbVF2?=
 =?utf-8?B?MHZoTDZFQjFMWlJoRXJXNVo3aUZRZE5qT043Nk55cmNpM2tVM0Z6ZHJDckdP?=
 =?utf-8?B?V0lyYlBSaE5LVHlMMHJ5Mnk3NWttODlkYWFVbW96bC80VG53QjJqL0xySXFQ?=
 =?utf-8?B?UjlOU1Jid284elhBYmpwOWRKeDJ3Nno3Tm9tc2RsazZnNVIzTzBmeGc1YnFT?=
 =?utf-8?B?QkU1NUZncEZvN0tDb2JUODRpKzhjMWhUYzRUM0JVTDVTR201S2tQc2Z0WHpx?=
 =?utf-8?B?YkwrdlVGU2t4SEZGa0NyNzBJclpydlZ2Z3owdzN3UUoreVBoWFZZbmFsRjB5?=
 =?utf-8?B?Uk1rUTBLbTNoQVRDN2ZveVA3ZmtMdmtZVWJjUHBxRkFSd2pwbUlVQXJocE9x?=
 =?utf-8?B?aEYrMFdNcm83WkZXSElkK1JoZElKclYyQjBReVBjeWtlNCtWT0oyMitzOEVC?=
 =?utf-8?B?RElwVEc5WU13R2xoRUZRdktjTUVxZ3hjNCtnRmJuYlk1cThkVCtVMEw0UUlT?=
 =?utf-8?Q?1JzzAMru6BAwMZUIYY36hzQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7FtiU7sdeRN6XlDzi50HBogPJmZj23Wxp/mVdv2puD4Xe/WQxYFMnj3BAhl0EM/PtsRIZQtucaGlJvHpw0X7wQ+aFV+ob4CbhKlkZPkxTovlBssOY3WVbBZU65/Oq2a0nyVOpRajZI1Aqij2To0SNgPSwCf21efAGk0amLblQIZVLE0WJ1KpK0MTvFv7Jf6Tz19Z4IF7+57MGUKji8K4qAzbsDK8jpkKjYAsjRVvqRzb/VpZvQ+o6qu6iDzz/+e94v5TFD148YGCBvWAofVPAGjVXomA+Gru6k+BxYIEZZIedXAMfb8P73NxBay5gpMRdv6dGxgzUsgQlMVbtVs/EUwPe7LGOcJxriBH9jrjLxKoA+PnGwx/o4Avsx2z2hWzF3BCKzWiNpZTv+YJMX6mPaCVmohtWjS0Ukcub2Xvoivlwt9oHKB/911syjFoNcjRFgkCttB0jhkrul8a/6VgA3j9v3FC6ZSOPtATpQrWxz8h2ulTZrEb+bW+qtm2dpJH7ewquDc295oySV62afgUriZiSLJwx+h+AhYObEqDJob2ClYEpI6AX0Fw3B39AMY2/frrB7jvUoM+Me3MEjmfS/jp4YTNs7wJHkfmyUY0COo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3d4feb-2315-434d-fcd1-08dd09e6fcb6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 04:43:04.6493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCROKqXUEQnuvCU3BlgR8KD7cTCysicrmAzowTO96prRxKJ97AE79wdZwI2O3FFuiEEs/n7uMcYDqt6kicweKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_02,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411210034
X-Proofpoint-GUID: bylDRtaMJvb6zjlM9aNHJPNo7QjaedLU
X-Proofpoint-ORIG-GUID: bylDRtaMJvb6zjlM9aNHJPNo7QjaedLU

On 21/11/24 00:31, Johannes Thumshirn wrote:
> On 20.11.24 17:14, Mark Harmstone wrote:
>> On 14/11/24 05:06, Zorro Lang wrote:
>> ...
>>
>>>> It looks like IORING_OP_URING_CMD was added to liburing with version
>>>> 2.2, which came out in June 2022. I don't know whether that's old enough
>>>> that we can just declare it as our minimum version, whether we should be
>>>> probing for the liburing version, whether we should be working round
>>>> this somehow, or what.
>>>>
>>>> Zorro, what do you think?
>>>
>>> 2022 was just 2 years ago, some downstream distributions might use old version.
>>> I think that might be too early to leave a "2 years ago" system out of the using of
>>> latest xfstests :)
>>>
>>> Thanks,
>>> Zorro
>>
>> Okay, no worries. I can change it so that it uses the raw syscalls
>> rather than the liburing helpers. It'll be a lot uglier, but at least
>> it'll work.
>>
>> Johannes, what distro and version are you on? I'll make sure it works on
>> that.
> 
> I'm on openSUSE 15.6 atm.
> 


Sorry for the delayed comment. Systems without the latest headers files
(missing `BTRFS_IOC_ENCODED_READ`) will fail to compile, e.g., OL9 with 
UEK7.

    27 |         struct btrfs_ioctl_encoded_io_args enc;
btrfs_encoded_read.c:27:44: error: storage size of 'enc' isn't known


btrfs_encoded_read.c:43:25: error: 'BTRFS_IOC_ENCODED_READ' undeclared 
(first use in this function); did you mean 'BTRFS_IOC_DEVICES_READY'?
    43 |         ret = ioctl(fd, BTRFS_IOC_ENCODED_READ, &enc);


fstests ./configure may need to manage feature enable?.


Thanks, Anand


> Thanks,
> 	Johannes


