Return-Path: <linux-btrfs+bounces-8830-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2581399991D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 03:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1D0285A49
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 01:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9D68F5E;
	Fri, 11 Oct 2024 01:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cRxgF/Cf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UqiZKcHu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB40D2FB
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 01:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728609675; cv=fail; b=s0vV6Dhswewxbdt0FexBhJanQcOmwmnQqznNdTdMfN+t4gj78uRWAhJ60tOBxY+vdU627W7boVuJEAXcadb4meQkFzTmxYhe9nE9meO1wYsAUqkml6IfOQoEA7KLPBdC8jtEmoWvxxzhVSUcId3v7UOPDBSXCdLyDEBD1v5hngs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728609675; c=relaxed/simple;
	bh=OtNe8Wx3FI13dyQsN8oTeHh4wHCGwPxuYFYGwYugEz4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nyjX0M7Kn12EKW9GBINZQJZbRAEkOFxLp1TQq3dA2SgYJ8/8gOPE0gSnDp/mbABeYSONbjmCr+U60zA0N1yAjrW3nP356MgRVXD2aX0RqzHrxIH3XWJe9CZcvp8KwlY0U8Af+dxIJQcRcjVjGztPkoHHr1+23IdKKAuzADhIeQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cRxgF/Cf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UqiZKcHu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AJtagK018029;
	Fri, 11 Oct 2024 01:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=fMhZyevspU4TOKO4ThlCR1j+zqQJXNpg5RxYTG1Olr0=; b=
	cRxgF/CfhpeMnMQZ/Nt+EiByflXLX+MFsD5CsPfaSEBvMcOtdhXMrvLsSNRjICAw
	8lUg3I6sB8uBe9z5M0o0lKkujoubVUh6QaMwjxxe9NtPJvesCIgahp9INHY1pVs1
	/qcjGEBJ/OH1F/VO5/+6Li19Y5ZPbnUjUsMCw2zomILyh2iy8nliLqPRSPr794Gt
	u4NgogVqSNEl1+M50sz8526EO2Nm9jgWb6okpbwUDErCjsEfyGMuMrztP5GdxiYh
	Wb0uGNOHid7QqZzwd3i53e9K7qcK8nKsAXOEwXbxYoh/QDujunHQkM3kXpYzV/qJ
	XjCeiWBsAjQdIfiE79F10Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyvc1t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 01:21:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49ANgbmO027715;
	Fri, 11 Oct 2024 01:21:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwat617-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 01:21:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfm7FM4VmzaYU1Y+r/pnZAq1upsm6Hgu0Tfca4kqbAYch2fp4+ko4RjILycez6IwSJQTrC+fRici5L4d2rqEreDjyGkDQ3wMigMKT848YQu0oC2Ymuauf2iH+nq7z44ocVNMhMy3DxKU4oRGtM8yq3ZNeihO8CudJs63oTyIfHc8G+JonncNZInx3Oj7qmSkdWvpwJ4QKWDxcm4plaoa48CDDRvIvLQU+y8sU/eF0lyMXyyK3TNq1cvZxgk+/GsSPsTAbLlM5bIdGyIQLzce2TjmMC3kgG8b18oBRx3Rd6U61khFEZ0kbqz0ZPv0zVbpn7TrpHbl2ZbEovfSjAWeAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMhZyevspU4TOKO4ThlCR1j+zqQJXNpg5RxYTG1Olr0=;
 b=HKhvDnHi5A4lSdXBc1VWxwdu1AWxJ3W4OANUVjoCfz0MZjS7VDGTi4d3VZlwwNpPTbJ3/H5d+BlchPXTbd/ZFo2nH+UgTtrp81Cs4OWE9Uy2TD3SEic1cGzTm4aD3VH9G1KKFTYyr716UwXfHNOdPFGgyOlaVlYj2n0FDREolt+5Yg44GtPcFlR+JCG9pHOc/EGgiDJ5D5Vlj2RH01CBy60BVQbtIty4XGqjcPJQqbabCOcWdEFgPkORQNqnmVNpr6gdjN4hWZR62v3e56DSfmj+LDZP++Yj2pJfeffG8+jFEEqtfJVOa+r9kGhV2cknIQw6M7VeDLrD82WL2IJpJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMhZyevspU4TOKO4ThlCR1j+zqQJXNpg5RxYTG1Olr0=;
 b=UqiZKcHuIUn0ppm54JRrfC7W6a4A3GwKGJlc4coGkbZMA8ZyvO4HgNg3CppOMdcds5BzEfuOvz7Ab8al6v4ZMz6G1kHQQZ0Xpw5ivvQmluoX3Yu4PE6P1DU7qcKxANUSBn0EoZytM65tWQQv/XL0Nb7TejKHd0VlEgmTlA8ugJY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 01:21:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 01:20:59 +0000
Message-ID: <2174a40e-9301-42c8-a935-d83716c827ab@oracle.com>
Date: Fri, 11 Oct 2024 09:20:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] raid1 balancing methods
To: Yuwei Han <hrx@bupt.moe>, linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, waxhead@dirtcellar.net
References: <cover.1727368214.git.anand.jain@oracle.com>
 <FB5E0995611C933C+e5e8b5f1-cf92-402d-bcfa-7cea30339427@bupt.moe>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <FB5E0995611C933C+e5e8b5f1-cf92-402d-bcfa-7cea30339427@bupt.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: 2125a65b-4497-4194-c7fb-08dce992f6d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUtsUUhpWk1WQmtoWnRETThhN3FuMXJMM1JqZHdxbXllN2hYRWZ2SzBRaytO?=
 =?utf-8?B?VnVtb2E5Q0xwbUMzdVlRam9hZ0xaVU5vYkxxUkNZLzNrL1hRSTV6NjZBaGh3?=
 =?utf-8?B?Qlk0RU5MZm9uNHFlT0ZJdG9mUHUyWlp2RkI4V01xT1B3bUkyRlFidFhzTDkv?=
 =?utf-8?B?WS9PNzZnblF4Z0NaQjV4bVk1b1FQQ1JEdk85djhpYXIzeWR2OEdlWlBjbHNt?=
 =?utf-8?B?VURCMVljSHhDTWpJUGw2cWdWOXZqNXpqUXUwYXZJdXpQZkF6NWIyU1JXcFB6?=
 =?utf-8?B?WnBLelROUjlxaUhiM3Nici83ZEcvcDA0LzZKMXQrWjlQUlczbzRoT2taRndW?=
 =?utf-8?B?WWZmbFdwWUVtVUlVdDF0TTdoQWxXU0hDdTQ1L2hFRnZ4M0VSQ1pYYXdsN2E5?=
 =?utf-8?B?Tjl6dHB5bm9XdGx4VGVPaDBDL2pLcFJHbVhzZzBnTzV1eVhZWFFQamFIbVFD?=
 =?utf-8?B?Z0I3clJmbFRiM3BSTGtlZS91d2VZRHluZVd3bnVGeVNXQjVGbjhVdTJ2bmZC?=
 =?utf-8?B?R245dmN5b3VmVURZdHVRU0xySDFUb0t1Ym1Ra3dKZ2xhTUhrTEpJVFZWTnJK?=
 =?utf-8?B?VVRXTUtEUGg2aDE0ckhUeXg3anR4emxVKzBQSlB0OStvdis3OGZCTk5pQmJq?=
 =?utf-8?B?Q1Q3WnhzQ1A0ZDlTazNSWlM1b25KVS9YekY1VHhtQnNienZKM2FwZmRKbHQy?=
 =?utf-8?B?a00rcmRjNXd5MjdDZEU4OXQyeHg5UStrSHJhZjhNTTBaSUhVaEo3eEdScDJE?=
 =?utf-8?B?b0xPdDVlRE5lamliNVRvQ29zTjArZ3F2Z0Frd1NIYXZJZ0tPcm5ac1lCZ3ZT?=
 =?utf-8?B?Ulo4MG83NGFmNW5ORTA5dnFyQ1RJMEZjRVpHSzBzU0hEWnBLVUdMbGwvUUg0?=
 =?utf-8?B?cURidDc2Q20xUUxyR3hONkJOOWNUTTZUUnRCUVBaOU1IUGR1bjhXdHJxNS9C?=
 =?utf-8?B?Y3pZeGFwQnFxeUZTVHRaZmU0VkJpMW9FRmxUQVBEZWczWiswVS9zUmh4anlq?=
 =?utf-8?B?NTc2QWNZZ2dBSDFHTmxtYWpnVk81S3pSNHZjZndsTitrdmp2eTZYR3pFcWFD?=
 =?utf-8?B?bHVkM1UwVE5OYngxYVZXcUd6MDkvSjVQM1k4aTNWS3oyUHBlaDNBMGp3TERi?=
 =?utf-8?B?dlRQWm5UM2RoM2VrOXZhamRqOS93Z2RJcGdTMHVZOWFTTllEZ0pQa0MrWnNV?=
 =?utf-8?B?TUZ4RGp3eWRiKyszd0lRWkpZV3dZbjlhL2pXTlFFR3RkQ3F6N2NONzZhcklK?=
 =?utf-8?B?R0tQUTNERWZXOXdEeko5MzJpTXp2TmlHMGRCUi85N250NGNNcjRCc1dEd1BE?=
 =?utf-8?B?c01Bbk53VU4zNWkxYldjT29lTFFZR3ZhS3RLd0dGVUo3T0FDdkZTT2V4cVBK?=
 =?utf-8?B?Vnd4WEJoSjZyUEtCWGRIM1R1UjFsUUtyVW5aOGdMQVRwYjExa2R2dXpnMmRR?=
 =?utf-8?B?aTNkd1lPTXRxeEtKNFc2Y2FxY20zQzlwNjc3dWdvMkM0SjRaZVEvbFZuTklk?=
 =?utf-8?B?dGhEM1lsSTZiaDNBMGtPOXk4K28wL2l2MitERWdBc1VTQzEwQVpEN054VUF2?=
 =?utf-8?B?K1JyOSttaWlrNWdLMHVYT21ocXM3VGxkT3JxUWdMeDJFRFBWbkYzRUxQRXBv?=
 =?utf-8?B?VWxnME5HUFZJdjBPS0NIQ09senlsMU1jMmhDTnJMdlJnYWdGR20yc0Y5NmxI?=
 =?utf-8?B?MTZ1NDRGUFd0akpnUkZ6K3l3ZGxhS0RlcVZMaUpwMGFNSy9SbmFETmVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXAyaHVKeG9VdXhQK3BBNlhXR3BpS0M1OTVMWGhUVGJlak5iSXVCZytoZ29y?=
 =?utf-8?B?SHpEQ1ZQdmJLMTkvd1FIbW5KeDRMNG5kcko0OTR6b2JaLy9FMmZtL0p2L1E0?=
 =?utf-8?B?SWtCbFNpL3ZQSkRwNmRhQ0FqU2JpMFgrTWdjT09GRzZqQVYxNjFWY0tZZjBu?=
 =?utf-8?B?MHo3RTdlbWVRYjd1NGtzYmlqcmh2RlZFck4zQ1lnNHBrUmx0LzRDMm15N1hO?=
 =?utf-8?B?UFVBWmJoQWthVi9yOTFtZldOTWtvSXgvV0krL0lpbVNKdkxIbk44bUFyQzJn?=
 =?utf-8?B?SW9iOVoyS1U4b0Y4WlpwSkU5OHlKMnY5RVNYSzQyR2NMdEFjU0FlRlNVVjA5?=
 =?utf-8?B?N29wbkZ4NlJvUWtmQUJJNEhud3RFMGdtNFp0L0F5SS9HTUVVZDRXOFVSQ2I3?=
 =?utf-8?B?cTJ4NjU3M0VTc1dDbGNPYUNQS0VCMzBXdUhaRTc0dUpoWjNjcFFDSCtDUWd1?=
 =?utf-8?B?bmJVanBxUU5lVlNjVS9SdEt6cDlROHBTdjJmMTRtbEVQNnhYaE1walBXM3dP?=
 =?utf-8?B?eC9uamFJYThwUW54VDA0ckRxb1A1dVplS3l3RW1EZHpaSWVUczVNeFJ6Zld1?=
 =?utf-8?B?N1lYbDJHTE51cEFWaUhDQlBMd0ZMYU5CNVJlY2psaWV3NTBCenBhMFBtSk9w?=
 =?utf-8?B?Vnk2UjV3QVE2cEJweVVPRVpBMnNHbUNYbFFuRjNHampLenhCUEsyN1N4N3U3?=
 =?utf-8?B?OWVkUVlRd3haQ2c1T2FDbzd2Y1ZjUG5WcXlBTTEzV1JtNXorNEphWGphT09Q?=
 =?utf-8?B?SEtySEtLcFlBYU95eDFBSERlM1QvNWgvVXFMQzJWb0lKNWJwK0kyL0lKWXlH?=
 =?utf-8?B?RE1LQkVBMnZmTzMwWnBmeE9SWEdUMjBFbzRCRHdxVUFseWFRcGVEWGt3ZFZR?=
 =?utf-8?B?UFRHblNRcHcwM05rd3A3b1F4cXZrUmE4NUZZMnJDaE90aFdWSEg4RnltRDRm?=
 =?utf-8?B?WVFlaWE3L2hUVlJleXdvTGFEOStYdGNMTXNlajE3MzgxKzJPbkFTZEhKRVU1?=
 =?utf-8?B?T2VYMFFJY29jOElJRHZKY2xCQ2lxOUJ1bUVPdjRjMDRmMWZnYURGeGJaS2tm?=
 =?utf-8?B?OEt6WHI3M1dVM01rSG9wWnNWb2JNcGc4eVk1eUVrSzJ6a1NMdUpYNHNUNGla?=
 =?utf-8?B?UU15K3dabzByNkxsaE9mTUYyMHQ4a2ZQL2RQMmlmMzRwcjc2Wjd2NXRTNUhq?=
 =?utf-8?B?UldnWWQ2dXluNDcraHNDekhnNGlBb3JVWHRjeEJrazBReVhPSVNxNXJ2aGhL?=
 =?utf-8?B?N0REdEJuZlFXY0FTcms4NSt3ZThPSFN1VjJMNzRBZUM3ZnhJdG8yQ2hiV2RR?=
 =?utf-8?B?MmtPTVUzc0RpN1BMQmhleWt5VW82b2N5bE5QellSWVZKanMyUWZjZUZpMDdN?=
 =?utf-8?B?VDUxWkhBRE5HR2RmSkovajdWUzRlLzhXOEVSVU00WDdBaFZDbDZDRnBzU0RE?=
 =?utf-8?B?MHJpZ0lGb2lCUE05QldIOVdLU3JUcmxlNkJBei9MY1hScWJ0OXhhSWMwTDE3?=
 =?utf-8?B?RGNKazB3UUg5bkhlRGdadjh0UWxySUxoZDJMU2VSTFRUcXphQ3k2SlRKV3pp?=
 =?utf-8?B?ZmphbTZuU0V2SDBacmdNbTd0MkROdyttRVlGTDQyZEpYazVLZTd3elQxbm85?=
 =?utf-8?B?cm5EMG1aWVlOdVNVeWNURDVnVE5yVFc3SmJjNHBlOGJQQmxEcTF5WjdtbEx6?=
 =?utf-8?B?UXpZVEI5N0tqem9sWlF0R1hFV0VyNVJDZUtqVEhWOG1ScFRzckw3ZTJXakdO?=
 =?utf-8?B?eUVJSVVmb3J6d3hZaVdjSWFWK0s3NVNQYUMybTIwUE4yRDFmbE9Xa3JkUktC?=
 =?utf-8?B?cERlTURmR3hHcDM0UFpEMkJxL0EvVUo3c0k2MXQ4V0NHM3g5VU55dDBkMjU5?=
 =?utf-8?B?TjFUMVRQY3RXdjZ6N0tsV1NwenZnbDJsS3lGYlMwajZFMzd4T2taZDNBa0ZU?=
 =?utf-8?B?UnJlWWRLN2dNZUJYRCtqUDRJTmtXN2VhbjFhSUR6SHRjWmFabVRabHVobXdN?=
 =?utf-8?B?Q2NiZ2F3cUwxM2xLbzIybmFOYXovU1NDNHh0eDU4VmhKckJCWFVMcjZnOFdZ?=
 =?utf-8?B?UkFCVGxyZ1JmV1N6S0Z4VVc0aU5qNXpyemg3cWdKODZHRVI5bG9zaWlsbHFN?=
 =?utf-8?Q?6mKka/ONCf3yFrq4yIe+Ofvx1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tikrkjdS0HLrEz3YAXOb6OYxnP2a+vB8Xiol7pnDUnLl4FTA9OzQ/DZPcD+c5/OpSvN+Vs6p1x8G/tuuiRevQmqfs6CuOuBTjWR4CXStQ2OMIJPPGN+lskPYjDFQmnxmB58PfkPnau6Kd2CS2NMyxIwLRAFcZH9sr1joO9kz2tlL2aFeynR1Tt5V8KijUEEUHqcxqOCPRJvqvusXqxFGfKVDtGQ78HLUu7fJlPMu/zkzp+k6LDUWwN1SNxk2tF77Dvl1BMw5LUdlFU3R2qQPKCuIr3CB1aozTmI8U+1gY5eMFfFuOhPJLKt5U1usr17VwDiL1j85qL5JbKsqehDtRUmBYyOedhdXiT6DVcTr/jWbE4BCwN6ahyDNDkZvwRvtgHg+Ik0x1f2hoVG7Y4fJ3vIYtNu0Kbzk8QF5G3blOdhUiKCRPo7dYJXxyQ9KIHi/nv/rGFgmBsL7GNfKqePyTPwaFsdXMkK5WHXCYVE2PVC5anvqx2RwiuEObWA84by5gwjR1jG1EsG3NMQhk6EfEeijBu0KztCjo7F2LwtZqrd8Uae4xxfp4Pyx7BAeWx9mkMHlkPNPmG7Ha/yc4ojqLF6V64QxlLxaSoxF3vrEPfc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2125a65b-4497-4194-c7fb-08dce992f6d1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 01:20:59.8100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7R0Ytl7tEcXHWrvI38NjiAgG5FJyTno79feVS9kPRRCHLauy+m0dMoy4hHv374/IqSYihkTWCttnjUdczteNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_19,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110007
X-Proofpoint-GUID: 8iC0iNsiAMiDeyxB5vgj7awqEuvNS3E-
X-Proofpoint-ORIG-GUID: 8iC0iNsiAMiDeyxB5vgj7awqEuvNS3E-

On 4/10/24 4:14 pm, Yuwei Han wrote:
> 
> 在 2024/9/27 17:55, Anand Jain 写道:
>> The RAID1-balancing methods helps distribute read I/O across devices, and
>> this patch introduces three balancing methods: rotation, latency, and
>> devid. These methods are enabled under the `CONFIG_BTRFS_DEBUG` config
>> option and are on top of the previously added
>> `/sys/fs/btrfs/<UUID>/read_policy` interface to configure the desired
>> RAID1 read balancing method.
> I am currently testing this on 6.12-rc1 with policy rotation, seems good 
> for now.

Thanks for testing and reviewing.

> Would be better if policy can be set in mount options.

I think it is a good idea. However, we should also consolidate our
sysfs knobs, mount options, and btrfs properties all together
where applicable and make it easy to use.

V2 is in the ML.

Thanks,
-Anand

> 
> HAN Yuwei
>>
>> I've tested these patches using fio and filesystem defragmentation
>> workloads on a two-device RAID1 setup (with both data and metadata
>> mirrored across identical devices). I tracked device read counts by
>> extracting stats from `/sys/devices/<..>/stat` for each device. Below is
>> a summary of the results, with each result the average of three
>> iterations.
>>
>> A typical generic random rw workload:
>>
>> $ fio --filename=/btrfs/foo --size=10Gi --direct=1 --rw=randrw --bs=4k \
>>    --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 -- 
>> time_based \
>>    --group_reporting --name=iops-test-job --eta-newline=1
>>
>> |         |            |            | Read I/O count  |
>> |         | Read       | Write      | devid1 | devid2 |
>> |---------|------------|------------|--------|--------|
>> | pid     | 29.4MiB/s  | 29.5MiB/s  | 456548 | 447975 |
>> | rotation| 29.3MiB/s  | 29.3MiB/s  | 450105 | 450055 |
>> | latency | 21.9MiB/s  | 21.9MiB/s  | 672387 | 0      |
>> | devid:1 | 22.0MiB/s  | 22.0MiB/s  | 674788 | 0      |
>>
>> Defragmentation with compression workload:
>>
>> $ xfs_io -f -d -c 'pwrite -S 0xab 0 1G' /btrfs/foo
>> $ sync
>> $ echo 3 > /proc/sys/vm/drop_caches
>> $ btrfs filesystem defrag -f -c /btrfs/foo
>>
>> |         | Time  | Read I/O Count  |
>> |         | Real  | devid1 | devid2 |
>> |---------|-------|--------|--------|
>> | pid     | 21.61s| 3810   | 0      |
>> | rotation| 11.55s| 1905   | 1905   |
>> | latency | 20.99s| 0      | 3810   |
>> | devid:2 | 21.41s| 0      | 3810   |
>>
>> . The PID-based balancing method works well for the generic random rw fio
>>    workload.
>> . The rotation method is ideal when you want to keep both devices active,
>>    and it boosts performance in sequential defragmentation scenarios.
>> . The latency-based method work well when we have mixed device types or
>>    when one device experiences intermittent I/O failures the latency
>>    increases and it automatically picks the other device for further Read
>>    IOs.
>> . The devid method is a more hands-on approach, useful for diagnosing and
>>    testing RAID1 mirror synchronizations.
>>
>> Anand Jain (3):
>>    btrfs: introduce RAID1 round-robin read balancing
>>    btrfs: use the path with the lowest latency for RAID1 reads
>>    btrfs: add RAID1 preferred read device feature
>>
>>   fs/btrfs/sysfs.c   |  94 ++++++++++++++++++++++++++++++-------
>>   fs/btrfs/volumes.c | 113 +++++++++++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/volumes.h |  14 ++++++
>>   3 files changed, 205 insertions(+), 16 deletions(-)
>>
> 


