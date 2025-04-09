Return-Path: <linux-btrfs+bounces-12905-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DA6A81EAA
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 09:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A114643F0
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 07:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E44425A345;
	Wed,  9 Apr 2025 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="InONl0Ic";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z1/njE59"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB21259C;
	Wed,  9 Apr 2025 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744185148; cv=fail; b=cEIDHt/iRLeSGFmsc/tdK7FW4DjGqYq6lDgD9K+3qOKFGmaJQd4zWllVXMXjLxkLt1eHepc8plBOkvEmxwHhcEk1oVFDW+isE4KSVmxHps674HDz2ULWjHyP6UDHdV4JTJ224ZJpN02XJdKpUgGsFBNVUihvIdHtwegNIi/77/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744185148; c=relaxed/simple;
	bh=H+lq3JT6RY6U2XLWu7ZCIbxt/BWiHLUtPNLEh6INnco=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=deBGkQdB30PBZ3zKRzIlVuyHc13ul6h7fFFg3io6F0GO4MQ7mtX0Lu7ZWY9Ge/K9/HWmt5cBC7U5zR9eLu2tZQzlBDXPnOE8e0wqhqqwzfPRh0OR59PbllMhy2bz93dToy3LVeaYVeT9ljcdZPBAWZ7OMpm0a67KCjZkgIj10FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=InONl0Ic; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z1/njE59; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538L9xLs023896;
	Wed, 9 Apr 2025 07:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qbmuW7yAxdtP7dAdHKv3rBa+EQiYTY+99XIIfBeKuYg=; b=
	InONl0IcLRGgY+5Wk/RhCQ2fEgxGAelzv2lEeZOV2wlMFkOvOSnXIdaj0wBdc/Sn
	XpwW/1DOZTjLS1jWOvkdrCpBjf1oaxfi1uH8+70uv2OCrv6lSdpBLjd3IV5QEpjJ
	cG7jS5K7SAnjWlSRJjq4vaPp6fhU02R8xNy6K2hCu2wNm8fZBv/r6rOF7BCo4UBG
	3W3tKh2URnHKsCYQef5aMj5W4eila4Oil1mZaRgSzTKufP5DMqtUwLJMtKKPbsdo
	vqlaLlmaR5VuF5MSGwDtS1hISSBIgB2NQfo9B8nL1DezuMl76miC8A9hmAN3ojUV
	onR6Au8fe/UKIUEWgh2G4w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tv4sxgmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 07:52:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5397ijMv013788;
	Wed, 9 Apr 2025 07:52:22 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013075.outbound.protection.outlook.com [40.93.1.75])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttygs3dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 07:52:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSzH6bNahctNpBiNVOR8ZjmVCBMVQNtt/3Dd+RaK29e9lekkJCfDHHt+p0XlRdDMPBmHO9HT5FmYZ6vtEg3OmBDmHRhJaYewvZ3DWaIfzMA+spKXpQTEWgeRtOt7CQh9g/Q2lH7wei/cq2irtp1/IpBy/XyIyxJVPkn45qj7I8UfgxaJXDPgkdqPlBCMEqbuQdR6p9u0vN/hRZZPKAtRgCOaR88BB7uDmgVNy7GSbjVxdjsWcX1Tu7KDRqfcOEOAW5gG3gCBVs/V0BMfOMd9BX5oUW1tHCA94FH886xthMEUFE8lX3GAgYYiSLL9FH8de0CTli9RQzAaFBk51ZWRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbmuW7yAxdtP7dAdHKv3rBa+EQiYTY+99XIIfBeKuYg=;
 b=NlEYxUh3rO2pe5ulGVxA5pysfgqjNWcNZ72Pb7Ftp+uBtO5UdlxjQ6qo+rQ9xJCOLDhgSixKrVn0FgW4kcvtFnghH+IL2L7mTp35vr/4ZYNCkOiC2JM71qqTBXapwlvPHRjVmrLBTwDVGn58hPI3qABfHY7D0jUkk6YwZP4P384QURTM5mk2qNYhx5bPo+uSa66zwgxIpfRJ6HFvugEwlcr6I7u9ecRys5XpQ/GqvZ0chyGUDVxVirKbMskdtSY1uxcL2wFDup2tbiRGsDylbnqWjhDDIt8DSOj9D5ECwj7udwyWJYNzdO0nSDCDkZ3QxBpkR59PULlh9vHA0QErIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbmuW7yAxdtP7dAdHKv3rBa+EQiYTY+99XIIfBeKuYg=;
 b=Z1/njE598mZ5fo/99GkU5h0hoNDK61YPGFP2RG+Qm3weZQnYTllQrihIOjr3D47YLwnLdXu7r5hnsLZso+m9gd2GPo//5l+mb9lSwxRzc+XCdT5InytWysiBbS2xX5qxIxpluGohM4Xx6aUhWLsigHASaCaGI6XDpL/XEnuj0eA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB7641.namprd10.prod.outlook.com (2603:10b6:208:484::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 07:52:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 07:52:20 +0000
Message-ID: <76fc21a2-045a-4f72-94c6-5f03932415aa@oracle.com>
Date: Wed, 9 Apr 2025 15:52:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: add btrfs standard configuration
To: fstests@vger.kernel.org, Zorro Lang <zlang@redhat.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cfb8c19533ac3c764edc1fe62b7fde75e76579a4.1743137470.git.anand.jain@oracle.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cfb8c19533ac3c764edc1fe62b7fde75e76579a4.1743137470.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: b9cfcb8e-1f8f-40ef-8bab-08dd773b7487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUQya1pZdW9RNC96YlFMMy9WdGtFT3lsV3VRT0NjclNGVWRRQURaSDQ5L2Nw?=
 =?utf-8?B?UjRaNW5pMEtHRExWZkx3dzF2OUh0azVrVW9RSnEwQ2pVL3dTTng0UkdEcnBm?=
 =?utf-8?B?TFhJeG5ESkFWcm4rWDFUMmRid1l2MEF1YmR0cjBKNUM4ZGsxYjNtSWtIcGp5?=
 =?utf-8?B?TW9aT1FCMDg5aFNOOUg1WExwbGJHdVFRVjRZM2J0aUFXQ2hDL2VwMWozVzB0?=
 =?utf-8?B?dFhtbUozQ29QVUFxQWMvclhHdk92TWdKZVlxOU1teFFKVnBjVXBidThBcVpK?=
 =?utf-8?B?L28vazhuVXBnSVdyVnk0Q2pFeXVBWjhoREFqdTBxa0Y1Zzhkd3puS0FtcnNs?=
 =?utf-8?B?c1R0dTBCNlgyS3VCclZHeUxPOHMyeDMrY0d1eHB2UkRJcTlqeEJUOW16OTdu?=
 =?utf-8?B?VTJaL2xPdGNUWC9nNjBiSk9ReUFacmY0cktWL0dKdm1QNFVmYzArYjNxT1Fq?=
 =?utf-8?B?Z2dGdkwwV1NYeSszVUVXaFdDcko5eTFVSUt0MksyeG41MHZoS3lmUlErcVRD?=
 =?utf-8?B?TDdjLzdUTktNM2RPQXhXNkp1L3lBcGFSVUl5dVJnbzUwZGhuUUM4US9IanlM?=
 =?utf-8?B?UkJnclk1ekNHSDM0UEJjanhUSE5QenVHVGUwTDY5cTZWSG9hUXloTWdVc2RY?=
 =?utf-8?B?WkdsamVvWSs4eGhLdVFqdWhibkRnNnJVakl1M0g0M1FTOFN0b2I5ZEN3RXc2?=
 =?utf-8?B?MGZZeWF2MWJ5UmlFOXFVTFpxR0x3ZDBtRFRzUEFRVUxzYTBmY3NKNmpUNlpo?=
 =?utf-8?B?TGZrY2NVclgxNXd6VU1HbUZGZTR6S09HRldvcXR3ZnZJM2xSc2lUWFdqRGRn?=
 =?utf-8?B?Vm1jSmh0dWxKMXJLT2kvN3oxV0FNanhKeDdoLzNxR1U5c2hpQVhJVFpYVUdv?=
 =?utf-8?B?eVdsNmxZcmc3THpQK2hxSmZFa1VkS3hqejRsNlpicGFqQjl4QVdDNHNCYjVG?=
 =?utf-8?B?MHllNWVwM1RuRDRpSUlyczlYMmZUT0p2L0d1L2I5dTBJbFppSS9oWTM5ZjJq?=
 =?utf-8?B?ZWFNamd0Rmp0aXNsUmF0UlYveFJMV1Jub2FobVZSMkUxRXVuaUFxenMvenpO?=
 =?utf-8?B?bW92cGVHMENpNlFWZlFrQ2x2UmhYN3BLNjFyd05Qa2pCVm96NERoTHU4OXQ2?=
 =?utf-8?B?ekEvWjRtL21Bem93TDlWMjZQUjh2M2hxc29EamFxVzdoV3BjemlZeENaMUp3?=
 =?utf-8?B?ZUIzVkdSVnFXYXZDK2d1T1ROMUtNR1lPL2NoNG5BVzFWWElIR3pCSDMvcUg3?=
 =?utf-8?B?U0dKQnFoUUwvd1FKUVRxeHFvbWhpL2NHdEk1b3AwNWVEMVpFL2JNeWJtL3Jx?=
 =?utf-8?B?T3JaMXhYZ0JTZVN5NjVFR2U5MW5hSmI0SnpXM1VhU1pXVm1IM1NFTWpGdnlu?=
 =?utf-8?B?S1o0dXptK1ZtQ2NKVE9BUWxwRW4wOG5DczR0N0hYN3YyWXlTRzBxTUVhdElv?=
 =?utf-8?B?ekJEWWtSanA1djR5ZGY3b2crMEF2MTZjR3NXa2Fvd3BhbTNWZGdoa1BLalRt?=
 =?utf-8?B?Sno0NG1rbnFxbnR2SVo0enBidWkvRXc0cXRjeGlSS2JuRUpDNit2V0hYYy95?=
 =?utf-8?B?emZCUUsxYWdqR2Q4Y0pWWWhOUWdhckFqdHNRY0lDVDFScnE5aXFpR2h0b1hS?=
 =?utf-8?B?YVB5Mjl5ODdDR3dHMUlncW5sZnk4cERvMS9nRkgxc2FuMUZLWFlOV0JzMnkx?=
 =?utf-8?B?d3hBNG5Oa3d5cjBjZ1ZsaktIelhQcHo2Q3hCWWg1Zk5MWllkR0FkcU94clM4?=
 =?utf-8?B?R0NFOElDa3VIbmRRb2U3YVFPVnA4c3lvUWc0MXJ6c2J1M0t6VlRlWFU1SnBj?=
 =?utf-8?B?UmFnV1E0YlRDS2V6dHZSNE1qVjY3c2FRWWppUUQxSkZWM0VTOThnVnBzWXFG?=
 =?utf-8?Q?w12t9dkflu4h/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0R5SjNKbEIrVldRdkYwOHk3L3gxM0kvSE5oUWIva2Q0aEI1cXNFbFZ0Vjlr?=
 =?utf-8?B?N1crQURWQkVBa05UWHhjaUNCTEtVS0RFNmZCVFFXMFhMMHN1U2Q1WWxRMDEz?=
 =?utf-8?B?bEhPNzIrVmpiVzBHZ2ZiMUxQazlhOHhseWdzWHIxaDM0N0VDK09RYlhoYStW?=
 =?utf-8?B?bzJsSGE4RGxmSzVLN01ZN1hqc3Q1OGJzQmF1KzZ6VzJBNTRFUGhFZTVPSkUz?=
 =?utf-8?B?QXlRVG1jOWw5MFBzWDBpNUI0SXBQL2ZOZ2FLdE5kd2pxcDdKcFd2dU5DYzJy?=
 =?utf-8?B?R3d6WVA5R0lRcDFqbFBEeElhL2Q1azVWNHFOWlVzazROSjZZbTZra1pBdG43?=
 =?utf-8?B?WUJ6UVdoZGh5T3hFdTdHd2huWnkvVDdVZFlSY1dpYSs2VnVIR2hxcUMvQWhy?=
 =?utf-8?B?RktJbmlIZzZyYkpaYUVoU1YwVi9lZE1kRnlyK3FtcktFL3Zhd1lKS3BzTEgx?=
 =?utf-8?B?Wm1tMHpXMVRRTUVNeWROMUZGVmtROXREbzh6aXZoWEFKMktpb0pTb0hXdzZT?=
 =?utf-8?B?c2lRd1RqRzg5eWxmRnZNa05la2hRdGNqbEdiK0w4WXppQmVsdE5WL0ZWelRo?=
 =?utf-8?B?L2s0WEt6RXNZQjA2NnRuMkU1Uy9UZnJvU3VoL2NYSTYxcXpac08vWXJCNVBn?=
 =?utf-8?B?dmtmOEdtckxXZ3RzYjJ5RmtPUWlUb3VOM080UXRRTDdRS05keE43eDhPbVZl?=
 =?utf-8?B?QXptSDhvRm1qUjl3bzVRSjFSNVNROGtuRTcrMTRPZDFoTGZaWVc4ZWtjdkl1?=
 =?utf-8?B?cEZQVDFoUWJtU2d2dFZsY0d1YjBFN2NIYTR2ZmpUM0hhSHAyZUZvc0ZtZzBy?=
 =?utf-8?B?MjdSd3F6MmxyNVlYMkF2VkpOR3ZnZnZKc1ZGY0N6QlpTVW42S3Z3VlI4Z3RB?=
 =?utf-8?B?bnQ4dzlieWcyWWxFUllxSWUzTjNtcStwdXhYWUhlYnVTRlpyMVBQYy9CcVYy?=
 =?utf-8?B?ZDhFNGtpVnZIaXczd1dhTVZ3d2R2ZXgzanZtbElsQ1V5eW9sQjVIMDBybDFt?=
 =?utf-8?B?eWhsdlRoSklwTGxXZEZJcnpWWERJUkRZRUVSbkhsQldtd1hRMWhLUWFwQUQz?=
 =?utf-8?B?elNVdk8yZm0rSCs2cjIrTzUwU2Z4OTM1eDF1UmM0Q2lUSFQwakg1WU1jUkZR?=
 =?utf-8?B?cUQ1bVB2NGc2alVoUE85YStJNWtNblhScTBLQmhlQU0vUllpOGNlMnFjekJp?=
 =?utf-8?B?cm1pQ3FYV2lFeExlWit3VDY2c29BQ0RkTCtVRHZVVTR3MUdCVHJBRGpWL1Fy?=
 =?utf-8?B?eE5iT29aNjh6TUZOeFlIMTJ1NHQwME41QlpzT3czSUtGV1pTd25aZ2xGVCth?=
 =?utf-8?B?bFdnQVFPdzVBdVpnZzVZUmdkcWhkNWg5Z3hPamhmQkthSDczS3YrT3MwV2JP?=
 =?utf-8?B?eWdpbjgxMjFjeFB6dTBpZnJjQ21QZGIwMlp2ZUxTckRBYjdSWEpNL09GSi82?=
 =?utf-8?B?cWNtNSt6NFJKd2VIOGJwYmhTSnRJMjRhNzJTak5qcmZpTXo1eFFLaWEvMFc5?=
 =?utf-8?B?MkUxZjBVWTZDMG8xcUlnNmg0ekRtS0tBaUNHNWV1c2hDY0JKd2VzTnBpZFZG?=
 =?utf-8?B?aEFYN2t6NmtnZ3NEdDhaZVljNnFWV044NC9BQjZNQ0Z1Yy9YcWdLbG52eEtL?=
 =?utf-8?B?T3dPRlRoU1dENHNib0NseFBnc0FFZEViV1NUb0JZblozSVhPaDZLRzRjQjVV?=
 =?utf-8?B?UmNEY0Rmd2VxUVZva0M1dkVKRVh0YUdnVE13ZU8vUDJycHZ0Mm4wZlNGTFIr?=
 =?utf-8?B?YnJSQWhyaVl6Yjg4bzU0akY5OXE0NW5menArK2hUb1FsbVgyWHNIMVJHRUxi?=
 =?utf-8?B?MjkydFltRVVSdERGc3lxSTdBaGZEKzJpS1h2NVpCdW84TTM1Qjkzazl5SGQ1?=
 =?utf-8?B?NHc4ZDVUYmdKM2FNemV4akZmVzY4NDF4SElBOWZuMWhkZXNURFdqOVlLTTY4?=
 =?utf-8?B?Qy9WQWJDaGxpMEtLWWZJVVJvS0R1Si9ZSk5lTHEvMmtRNDZuVHAyZUFPMUow?=
 =?utf-8?B?bHRHVjdPMWZzbTVWV1Y0QkcyQ3p4WVpmb0lqUWNoaXh5aU9zTzNYMmVmazBE?=
 =?utf-8?B?bTY5a2U5QmZPSk1JMnBZK1o4RUw2YWNrMU9WbHpjbVRSWit3cGNoTDVsZEx2?=
 =?utf-8?Q?N49YsASUSt9VB4rhwmn0GB2uy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	grjVYioN7jtbj0oMKBHEt4QCAL4EVe1QE/SMu3v/8Px/Gg9asoZ41LBuTMEV1chus1xHk8lX371BuntMDMeoXVcWYZMC+Zz9jRpVh2FxKscyiZ1xYGaZ6uXlCpRaJ4oK/9WEpZyTa0j4xzhOan/giKZ0tPBITQf2HYx5DJ30Z0bhR8l2t9R1IGrcRB7qTVwF6MJKrjaQXqi62sPS9tVgdxO/pITkPXAMBQuYGoWtNnajSiC13da7A5q0vkMKwzI7dc0hiSlUo0K2F03/51oiYsaU2w31uXPHVbZ3NYSz+soyFJgUSQzJL8Iq+sMYXsQEHb6BVFyXon/nydp+AxXCqtM6BL65u92Bpj0F33VilnPPKjJ4aIeJbuD6hB6Gkd0O3g332VpobsUQQ0hw07Xlx8MPG0LT0bcPJFtjHiLkZLZU5D4u7ZSGIksF1iwWdHO+wguNEcfT/tpCraSv0asDU9P28jc4+OhXX7t0WfjsgjYDi79V16Egzdo4u7SXsw/bnKTy88p34fWbc1Vp3JGrtI5tLMHjZufBEYLQCswuZvb8Nbe6X7ieUNUl50ZAUfJQWYYwyK5Wi452oGKFY88Ghsuyh87XXacTbYiG0Armny4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cfcb8e-1f8f-40ef-8bab-08dd773b7487
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:52:20.1503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoOYKvp8tedbq20C9YWuORaiBFj6EpvOAsff0figa9LcY0zSwx8wwiQOvOFqize1/jSb7Xey+rVjBlZ72XpoRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7641
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504090036
X-Proofpoint-ORIG-GUID: BKORgTmcnW0PmwE3779f4PiBFZqYtRUQ
X-Proofpoint-GUID: BKORgTmcnW0PmwE3779f4PiBFZqYtRUQ


Gentle ping for the review and rvb.

Thanks! Anand

On 28/3/25 12:51, Anand Jain wrote:
> Here's a standard configuration for quick, regular checks, commonly used
> during development to verify Btrfs.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2:
> - Renamed config file to `configs/btrfs-devel.config`
> - global section renamed to `generic-config`
> - Section names now use hyphens
> - Added `RECREATE_TEST_DEV=true`
> - Removed `MKFS_OPTIONS="--nodiscard"` from `generic-config`
> 
>   .gitignore                 |  2 ++
>   configs/btrfs-devel.config | 40 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 42 insertions(+)
>   create mode 100644 configs/btrfs-devel.config
> 
> diff --git a/.gitignore b/.gitignore
> index 4fd817243dca..9a9351644278 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -44,6 +44,8 @@ tags
>   
>   # custom config files
>   /configs/*.config
> +# Do not ignore the btrfs devel config for testing
> +!/configs/btrfs-devel.config
>   
>   # ltp/ binaries
>   /ltp/aio-stress
> diff --git a/configs/btrfs-devel.config b/configs/btrfs-devel.config
> new file mode 100644
> index 000000000000..3a07b731abd9
> --- /dev/null
> +++ b/configs/btrfs-devel.config
> @@ -0,0 +1,40 @@
> +# Modify as required
> +[generic-config]
> +TEST_DIR=/mnt/test
> +TEST_DEV=/dev/sda
> +SCRATCH_MNT=/mnt/scratch
> +SCRATCH_DEV_POOL="/dev/sdb /dev/sdc /dev/sdd /dev/sde"
> +LOGWRITES_DEV=/dev/sdf
> +RECREATE_TEST_DEV=true
> +
> +[btrfs-compress]
> +MKFS_OPTIONS="--nodiscard"
> +MOUNT_OPTIONS="-o compress"
> +
> +[btrfs-holes-spacecache]
> +MKFS_OPTIONS="--nodiscard -O ^no-holes,^free-space-tree"
> +MOUNT_OPTIONS=" "
> +
> +[btrfs-holes-spacecache-compress]
> +MKFS_OPTIONS="--nodiscard -O ^no-holes,^free-space-tree"
> +MOUNT_OPTIONS="-o compress"
> +
> +[btrfs-block-group-tree]
> +MKFS_OPTIONS="--nodiscard -O block-group-tree"
> +MOUNT_OPTIONS=" "
> +
> +[btrfs-raid-stripe-tree]
> +MKFS_OPTIONS="--nodiscard -O raid-stripe-tree"
> +MOUNT_OPTIONS=" "
> +
> +[btrfs-squota]
> +MKFS_OPTIONS="--nodiscard -O squota"
> +MOUNT_OPTIONS=" "
> +
> +[btrfs-subpage-normal]
> +MKFS_OPTIONS="--nodiscard --nodesize 4k --sectorsize 4k"
> +MOUNT_OPTIONS=" "
> +
> +[btrfs-subpage-compress]
> +MKFS_OPTIONS="--nodiscard --nodesize 4k --sectorsize 4k"
> +MOUNT_OPTIONS="-o compress"


