Return-Path: <linux-btrfs+bounces-9089-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AB79AC28F
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 11:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 903D2B23BFB
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 09:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDA51925A8;
	Wed, 23 Oct 2024 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VWkkAxQC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jn9Aw9G2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BECF1581F2;
	Wed, 23 Oct 2024 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674025; cv=fail; b=Fs7btO1n5NUmk/H5kJP8uzhntF0x2+OFjTfdBb16dOgMRkHwEk42u2txKJn3/g1BFQ600AKTTWTITNsZBTdobH1AizlxS1XUz3rI3vMH+1kuPtbrDthzmlPKxVoxyPtueVryQl/iKmGFIjktwc7aBBEdiXljPfA9CdMwxwtKAVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674025; c=relaxed/simple;
	bh=LcdgquuFjWC5GTYdl8OWC2rakvQZpxsX7CdsrHXxzgQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fin9bn7Yc6stkLZU0ZdKBQZzGqTF2bpu8zcqCEi71F85OBAa4vuntnqTXuM/cRSxiJ/MiRb/Wdwopg+qBf3fq2R7pEp/tWqiWy+tuIOQJIIhxa6zOv7NhRxGKlahTB8UqTBvZVggl+mqP+9eA8/zTIQpOhRDU4yKWFQ569843Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VWkkAxQC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jn9Aw9G2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N7th4T000590;
	Wed, 23 Oct 2024 09:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9QCxY6F0A/w0wZlV7v+OR4lt9lp4jTKqGehnNy7/oxk=; b=
	VWkkAxQC7CKxhXSxXOiaBTiMkLW2OSRRfg4bPm65MMsC7SN4n+EWHj5TiUMIVHLE
	61pbqibC87Kvcrtk3XtJ4zODtBbtrFA/X+R2AY041PPPR23yi2zQnmhe/MiCeMtW
	xutRsWYI22Tgb3Bf03kGS95S7OqqQgrCIDkRbIqwmu6+4lv1Qvx9+3MwkxmVWlNz
	2ZnL4HlMgKOKRl47mEMLoHJuEMjKou+LbQ9ZeZWylo8kXMvpognywWQKLJ0sJyvy
	Z4VOmGb/uylcxXCQHhL4oqqL+pb8KgdM/EGo5NwniyekyF11ztLIBocduyH7fui5
	Ap7rSFncM/q4goREbx15JQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55efh5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 09:00:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49N8f5g1018663;
	Wed, 23 Oct 2024 09:00:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhj90gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 09:00:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OL/SrObf5DK+gh4wp+SPt9eZGZxYeVMl9M4bewlZSWBycZaqzBeuDKRMC5IV2fEAVNNHRqMiLm/RxmTgM1VGZiBtl4xfy4e9jQlAxc31tPaDViR6vSBJd12jBgJbSz2Icoa+akXP4CdLNS/J6Ceink8y0VkXIaS1FB0W4Zv3QaJNNDV3TY5OOOjgh4GDvlVFkh8VImdk7KYHYKvxzpg3mE4sAfsZguZyTV3T2Tx9ZQwfXiJqZnkKdAPhHDoiwrt3itP+F20SeUxXOLhZFEYrgOEKfmXFMlzIBPfUq1FczGVYYiZL5z6pvFC/tVc7wUz9hswDkhvMdN76/tnhE8c9/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QCxY6F0A/w0wZlV7v+OR4lt9lp4jTKqGehnNy7/oxk=;
 b=tvD15UW2LKhvdmTGgZIH4/gyWl+7vmmuL/cxBFaFsvGW7hTjs2KBFA0vaWJjiQYR8P8eBV7PEQC9Icrn+aZgAWLZ+TFTjW9ffsoz8X/foKvTGr4PEgPINvCvKhMvCjERvAoY/tmJ3WbzAJqVkFpLywVPH4KOOqs2h0OGiQ1rj0NGSYQhU/LcsUd6z6FuIXnGt7mF2mQ0wbETo4L06Y2VAKrzRTxk8HnkUMsVEugUcSFbHQ8FRWAZh3Fb1Lwm/IhPM03ErWKObh3eOzrlDPBdOQaXHEXB9dmVfdfTs3aJBaWiZN96Xzgy5hzpN0SHI5BiXLBXtYxxGLPifA3kLGylsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QCxY6F0A/w0wZlV7v+OR4lt9lp4jTKqGehnNy7/oxk=;
 b=Jn9Aw9G2GHMTm6DYnM2LHQsmVaL7RzhbSSWe5KUe3OPKfgFs99VhKq+YKdxzW8Xm4ylb6e/lf3B0fc4PyPX/px0scX6+QRMylxFiAmko0DkZzNl3ck2+EyCvjFFf6g1i93TeuvtwnFVoImihr+UAqqdOYoK88BT3ZtVd0x9cv8U=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB5887.namprd10.prod.outlook.com (2603:10b6:806:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 09:00:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 09:00:12 +0000
Message-ID: <1a2e7839-09c3-4584-be31-c783f940c41f@oracle.com>
Date: Wed, 23 Oct 2024 17:00:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/012: fix false alerts when SELinux is enabled
To: Zorro Lang <zlang@redhat.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Long An <lan@suse.com>
References: <5538c72ca7c1bf2eb0ff3dbaa73903869ba47e95.1729209889.git.wqu@suse.com>
 <96e09109-1b9c-4f15-a07d-26501ed891a3@oracle.com>
 <8f1acfa5-37f9-4deb-af9e-d2f7576e0c26@gmx.com>
 <20241023041228.d3rkmmci5vnw5ict@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20241023041228.d3rkmmci5vnw5ict@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: c56ed5e8-5101-43fc-6831-08dcf3411a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VldEWGtxOU1JeEpWYWZtekNYeVAxZFZ1cTdhbnRPTFlrcWxSYlFHRVFVTng3?=
 =?utf-8?B?VjJKclZsaG1VQzNsRUF3ZlhWRkZvY1VacTFtY2d3b3NxTWpTTmxUeWdHMTQx?=
 =?utf-8?B?OGluM2xtRmpVNUlST0Y0NEdRUEdGQ3BNd21PWUp1NUZBWVdWeHYzSE56K0Rh?=
 =?utf-8?B?ZldKT3lXT0JHQ2hXUlVTeU56SG5sdnJQSTdRMWVjTWxNVjRibEVBeDltcDlj?=
 =?utf-8?B?SEYrMW5YcCtMcnFwQm02ZVRTRG8wSnpIeFZnTml1SzNvTFJJd0JXREVxNm43?=
 =?utf-8?B?Wlp2Yjd2b0RtaGRFbERGSFFydHVRMlR6bXhpbU5qRk9VNTQ4WVl2NHpMU3k1?=
 =?utf-8?B?Zks2WkRCNlhmOEpmM1JoK1dyWWJXSCs3Yk1ucndVb1R6M2ZRUW01U3dkaE5J?=
 =?utf-8?B?UjlGSTJKQ2JIQXhqaSt0QWtNZ0pBYnNuVlAvODdWMFd3U2dKaFdCWmtDMURG?=
 =?utf-8?B?NU5EZDM2dzMreWhseDlQdXlNZll4YjFuT0s2TzVRbjRSLzAwMTJ1WE9ENEI5?=
 =?utf-8?B?RlFmbzZWY0IvdjR2WU1MUklpR2lpTEdvRm8zS1h0R1NoNllMNE5vYWVMN2NV?=
 =?utf-8?B?amVEVERkcnlsWjVTL0dyU3VNMDhQcXN4bEVNNHRoQ3Rzb01Fc0o2alY2ekJo?=
 =?utf-8?B?VklRR1NpTEdMSFFCN05Va0w3akUvZ0w2dmxlWVRZT1duaEtOTVRwMjNEV2ly?=
 =?utf-8?B?OUg4cThCeC9UeC9QcnFEbmkvZndRVFdHT2ZnaG9paXE1ckd0cUZyOFB2YVRq?=
 =?utf-8?B?MmU2MFNhVFBUbkVPOHFKUlRhWlFpWm9ORWlKZFdRU3pXOC94MDYzcmRpWDRE?=
 =?utf-8?B?QW9TK2lWUC84UzJValFqdjZFKzRaWWhOa2lGcGZOMHNzNHc2eDhkdWNnUUZ6?=
 =?utf-8?B?Vm4rN2k4NlQyTEV1Z0cySHEyU01ISjMvVHVFcmI1LzNuOW8wU0REWVZuK2kv?=
 =?utf-8?B?QU1DL3M4WTdFR2puNnI5eHd1NWRGam4zMkFOUzVURkNrdTBHdG0zajhzcUo1?=
 =?utf-8?B?QmpIcU5ycmRoZ3BEUVBKZjNGelE2dXRraC9YOG9OZ3NzT01tL3ZheFVpUEVh?=
 =?utf-8?B?dDg3YzBWWXBiY1RDMUVpQ201TTBIL2IzdDFCYzZsTHVHUlJNU3NpS2JBdjFP?=
 =?utf-8?B?VkJIOWlrVElUM3JrVHdHM3BUOXp0ejdvMm9STkg2TlNKbDBxbFdYMzNYbE9o?=
 =?utf-8?B?dnkxbFVsb0MybUdaS3E2bXNTK3NFRDVGcjRwTm9RMEY0RmJ4Mlk0UVN3TzZO?=
 =?utf-8?B?RFZXaWExNStQMXBMWG5HaVZaeVB1aEI2ZlNVb0d0cE1oYVR0YUFRaEcrU2hr?=
 =?utf-8?B?ODhqdk1SVm1kRU1uSEZFYVh6b0ZiVFM4MWxPMkVvc0pETVhDQzI2UWJGa1dp?=
 =?utf-8?B?WVEzcWVua0RKRFNXVGZicnRzeFFRZEwvL2RUdVBZZVpackZyRUZlb3dkeExF?=
 =?utf-8?B?RWdjOFUvQ2l0VytLSFNFMmFsMU9xU0t5Y3crU3dNY0JmOWw1dzRYWlBhcXpP?=
 =?utf-8?B?U2pPQU11Qmg3YUQ3emNrMTI5bE1xYngrMG5FWWdmbnFGUWVkTUsydWpxVGUr?=
 =?utf-8?B?MENiTDJ5VU1yUVJDMy9GK0N6dUZLT3NGdG5XN1JOTG5CTFphandMMXpRYTJX?=
 =?utf-8?B?WFljNS9iazJMYlBoR001VWdtejl2dmRrS041bGk0clpobDBKN01oRTVoYThk?=
 =?utf-8?B?TlMrUVdtdisxZWNqckYrUStRbnNGeDZ4RFhNTHBGRkk4RmdpVXFTdTZJbE01?=
 =?utf-8?Q?i99HgThDMBxeITpNpdcoA3P0QbLFrexuyuZkMTf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFdjRnlaNFd2VDFsR0JYUFFvZk4rM0Y4Mjd1ZmxjamhQb2l0ZDR4Rzg5aHNQ?=
 =?utf-8?B?WXFQVitQaDVNOEI5bWhQdTRackZNMTFzSFlHWmR4L0dJTks5OWNESHdyUWU2?=
 =?utf-8?B?RktYczdnMDBiZno2YnExZWRvMmh1QmZhNUtXU050OTBDamJSZGlYQS9iMlEx?=
 =?utf-8?B?V0pGVEliYXpVMm1FelFDTmY3TUhFa0pkUE9LRWcrdERIaHJhajZOV3JxZWh5?=
 =?utf-8?B?TnNUcjM5U1Z6UjFoMXFqL2g0VjNYb1gyRDNuR1N0cW00TFY3MjB4eFZMY003?=
 =?utf-8?B?amNHYnRFaVpyQm1Fem1yaDlJVk5TaXA1NkVwc1dJNm5oWkdwOGY5UXhnRzg0?=
 =?utf-8?B?NWFianJCa2VKZytXL0xnSURKbHZERURMcHR4dmkxbDZOaEJ0UzJDZlJJL2kv?=
 =?utf-8?B?NUdNTWw1cmxJTStqVDBxNlJ5amF5RWg3N3dwbnJGeXcxRzVwazkrS21DN0ha?=
 =?utf-8?B?QzhLRkFqQXBZOFBGMmNyK21zSkY2Qk5KSTNqRkE4ekdRN2hrR3NXbys5V3E5?=
 =?utf-8?B?R08reDVqYmlmMFZSemh1WFJ2bjVwZjJ5SUVTMGFjYUNHVFRONmdBc2RPSDBE?=
 =?utf-8?B?ZXB1M2hDSWg3N1NyV0hibFdKVkl3OE12YUpmbWJkZ2FvZ1FpYkpNM2h1Nnd4?=
 =?utf-8?B?a0xEV2FzTmg0TEZzckhIaGsvWERsMmU3V01hYzlhWnYyU09JU1lPcm85UGZV?=
 =?utf-8?B?elRnSmtjYWU3S2RoUU1uaGtWdS9UV0NuNzZld2pVYmxLK3RiOHJwbVoyV0Vv?=
 =?utf-8?B?a3VYQkFIMCtIYkR5L0J6QzdSLzcreU8wUlQyZGR5U1VsbEh4NWdVVHJpNzVD?=
 =?utf-8?B?TmhJSmFybU9uY1U1MDZJUnpCcmcvWXRvanhrYjlVSDhrUmVBYXFNM2pBbjV6?=
 =?utf-8?B?aDdJU2NIOHRSeWZoaXI3YmRWMWlENHdVMU1TWnBCK21BRktUUGVxQy9QRU52?=
 =?utf-8?B?akpvdDd1d1JTZUNlQkMyalE5TXFheHpRbHZsVFpVVTRBNHdlTHdhb2dKdk56?=
 =?utf-8?B?UmpCTTlzQ016azFEbmtXY0xuM2VwWnFnOVU0MHdDVEpKcGhyRE9nYjVmTjJ6?=
 =?utf-8?B?NHF1aDN0bEh4WlorM0QzV0JtbDE1S05RLzR2QXJ3OE83ZFprRHUyVVRKVzRZ?=
 =?utf-8?B?Mmw2czBCV3IxWVhCUmVCU0lsM2J5VnA5RDQvamRkT01VRGNtaU5QQ1ZrZVNC?=
 =?utf-8?B?ckVzd0VtWDZiM2FCbitCdnd4MUwvZU9LOTg1bG05MHdESE13OGNLaTA1QlM0?=
 =?utf-8?B?aVlwdUcyVFc1c24wL1BUcUM0c2dWamdxUG9hK2RIOFh2cjdLMWlSYThXM0hJ?=
 =?utf-8?B?alFRcmR2dHpyaVNLeDN5M1BCdFUxUTAxbFRhbGtQQ2N4Z0dMVTQ3WEtaUm5x?=
 =?utf-8?B?OHI3Mnhhb05wcnN4c1FHdHJMOFlLazk2aVA2ak5nWk1BS01aM1VTMUZGWEQw?=
 =?utf-8?B?VHUxaDVLWmVvRXg1WjM3eDdWTG56N2w4QVlMS1dzTElmeFJBMEwxV1RXbEMv?=
 =?utf-8?B?ZVBhcXczUVU2UmFYd0g2VnQvQkRLTVBxTVhXRElrTVNoNXd5d0tQakZGUy9F?=
 =?utf-8?B?OEdzQWFkOHNkaW44RXdpZEpzeHRiSHZ1K01vMEpDRVFnQURnemVDVnZEMDJw?=
 =?utf-8?B?TVhkY2FaLzFMVUwxaHFtT1NrZkhtK0h2REJiVTNvYzRQejlLdUUzU0RCY1Vq?=
 =?utf-8?B?UUk5eFhPWG1hU3BQM201dWdlcUI4YkM4eHhYZGhrREthZkhyd25pMnBiVlQw?=
 =?utf-8?B?dXpSaDNKY3RIQ3J0TmxRUWpVeEI2MkxEYjUzK05rOURoQkdxcmVEWXN3d0ZM?=
 =?utf-8?B?RmV6cmtILysrYW9TQTQzdDVNM0djemlPZ0xKN2wvdXNNRTM2emVlSzJXT2lO?=
 =?utf-8?B?c2crbmw1Q2UvWnE2T1F4elkwQVBPSEtzTDhrVzVSWXN5QXdjQnVSMmhORnFm?=
 =?utf-8?B?cnhxZU5iZ3dRb1UxbGg5eDQyU08zLzBPYzNvZ0FVSmh1Q2JjNVN5NFd5UWhp?=
 =?utf-8?B?RkpyOU9JTWcrQ0k4QmJ4OUg4dnBMaGdma2tlM2lpci9DL3pPZW54QnlpdmhQ?=
 =?utf-8?B?OTJKTHo4TmhlczRwcWFmU3BTVDRubVp4UUp0OXNTZzAyL3dHYkdHRkZkWFJD?=
 =?utf-8?Q?nJog0/cLcg2VCvouvppnCYNG1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cgR/WkSk9gbQHIHLcte2mYIJHq7krwLBbNDiuIXaMy362gt+2cX6UoanCt/+donqh6P5wdn0DWZX39dV7L3s2+bs0BIuVl7lOQePgq9s8L9+YhDwUiUnL4SrtfuCbujSEVtFkKfk65DICvxMQHziAtY9PqoOZ2/tYYeRcqr9CAIo2U5gQHdCir9FGA82N0EAG675CX2z416wYfIf7sIyTMEaV2qovfo4hIXeFMW+1sfSYOnyMncZnjDpiUhI0De+aqiKZQmitq+LuhWmvyJ0o1NDbzEr5eNvughUeReq628gUV1+VufrXCBcZ7zGOnoaorGuj3N2LoSyjfzcKnsFaCOoKQq4dbaQAzmFX8VvxOqk/hudhE4PlfEJ4ROpI/gVIXAvk8vkZezdj5T/1B6H8adFAx7WUya+8kY3YmprUUcwgPK9tLaMliyQV8WF3khlgUQyPI/mSoEHzSklWnxnbQVOuQftzhAc3zRtoXxfG84ZmHclI5pYSwOYe5pRasTJHsx9bsT5OU8c+EFMCOzyQ9V3FPs1CShSV7v00nJHeJt10WWJgpA05fN08JkOYAPobycrVtt+qltqXutBYzS9yK19Luc6ADuVHVl5k3kbyE4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56ed5e8-5101-43fc-6831-08dcf3411a9f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 09:00:12.8030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IosZWwlJ520+hkNitmG2xez1YDXvYC3Jlq7TbMZvhr/L9haJY66ZBp/cIKROir24tqihyNFl0g5cleyIf7Gpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5887
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_08,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230055
X-Proofpoint-ORIG-GUID: 6Hlot-XwCgDeot9exgnDqxgYvBuCh8sN
X-Proofpoint-GUID: 6Hlot-XwCgDeot9exgnDqxgYvBuCh8sN



On 23/10/24 12:12, Zorro Lang wrote:
> On Tue, Oct 22, 2024 at 01:12:15PM +1030, Qu Wenruo wrote:
>>
>>
>> 在 2024/10/19 08:45, Anand Jain 写道:
>>> On 18/10/24 08:04, Qu Wenruo wrote:
>>>> [FALSE FAILURE]
>>>> If SELinux is enabled, the test btrfs/012 will fail due to metadata
>>>> mismatch:
>>>>
>>>> FSTYP         -- btrfs
>>>> PLATFORM      -- Linux/x86_64 localhost 6.4.0-150600.23.25-default #1
>>>> SMP PREEMPT_DYNAMIC Tue Oct  1 10:54:01 UTC 2024 (ea7c56d)
>>>> MKFS_OPTIONS  -- /dev/loop1
>>>> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /
>>>> mnt/scratch
>>>>
>>>> btrfs/012       - output mismatch (see /home/adam/xfstests-dev/
>>>> results//btrfs/012.out.bad)
>>>>       --- tests/btrfs/012.out    2024-10-18 10:15:29.132894338 +1030
>>>>       +++ /home/adam/xfstests-dev/results//btrfs/012.out.bad
>>>> 2024-10-18 10:25:51.834819708 +1030
>>>>       @@ -1,6 +1,1390 @@
>>>>        QA output created by 012
>>>>        Checking converted btrfs against the original one:
>>>>       -OK
>>>>       +metadata mismatch in /p0/d2/f4
>>>>       +metadata mismatch in /p0/d2/f5
>>>>       +metadata and data mismatch in /p0/d2/
>>>>       +metadata and data mismatch in /p0/
>>>>       ...
>>>>
>>>> [CAUSE]
>>>> All the mismatch happens in the metadata, to be more especific, it's the
>>>> security xattrs.
>>>>
>>>> Although btrfs-convert properly convert all xattrs including the
>>>> security ones, at mount time we will get new SELinux labels, causing the
>>>> mismatch between the converted and original fs.
>>>>
>>>> [FIX]
>>>> Override SELINUX_MOUNT_OPTIONS so that we will not touch the security
>>>> xattrs, and that should fix the false alert.
>>>>
>>>> Reported-by: Long An <lan@suse.com>
>>>> Link: https://bugzilla.suse.com/show_bug.cgi?id=1231524
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    tests/btrfs/012 | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/tests/btrfs/012 b/tests/btrfs/012
>>>> index b23e039f4c9f..5811b3b339cb 100755
>>>> --- a/tests/btrfs/012
>>>> +++ b/tests/btrfs/012
>>>> @@ -32,6 +32,11 @@ _require_extra_fs ext4
>>>>    BASENAME="stressdir"
>>>>    BLOCK_SIZE=`_get_block_size $TEST_DIR`
>>>> +# Override the SELinux mount options, or it will lead to unexpected
>>>> +# different security.selinux between the original and converted fs,
>>>> +# causing false metadata mismatch during fssum.
>>>> +export SELINUX_MOUNT_OPTIONS=""
>>>> +
>>>
>>> SELINUX_MOUNT_OPTIONS is set only when SELinux is enabled on the system,
>>> so disabling SELinux will suffice.
>>
>> Are you suggesting to disable SELinux just to pass the test case?
>>
>> Then it doesn't sound correct to me at all.
>>
>> It should be the test case to adapt to all kinds of systems, not the
>> other way.
> 
> Hi Anand, I think Qu is right, it's not worth disable the whole SELinux
> (at the beginning of fstests running), just for a single test case.
> I just hope to make sure btrfs forks agree this's a failure which should
> be fixed in test side, but not change the selinux config for btrfs-progs.
> If you're sure about it, I'll merge this patch :)
> 

Yes, I realized that a bit later.

Reviewed-by: Anand Jain <anand.jain@oracle.com>



Even if we create _require_selinux() and _reset_selinux_mount_options(), 
there are only a few consumers, such as btrfs/075 and generic/700 for 
the former, and btrfs/008, btrfs/019, and generic/700 for the latter.
Do you think it is better?

Thx, Anand


> Thanks,
> Zorro
> 
>>
>> Thanks,
>> Qu
>>
>>>
>>> -------
>>> fstests/common/config:
>>> if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
>>>           : ${SELINUX_MOUNT_OPTIONS:="-o context=$(stat -c %C /)"}
>>>           export SELINUX_MOUNT_OPTIONS
>>> fi
>>> ----------
>>>
>>> Thanks, Anand
>>>
>>>>    # Create & populate an ext4 filesystem
>>>>    $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
>>>>        _notrun "Could not create ext4 filesystem"
>>>
>>>
>>
>>
> 


