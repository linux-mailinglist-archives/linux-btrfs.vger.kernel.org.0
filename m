Return-Path: <linux-btrfs+bounces-7536-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0653D95FE0A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 02:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079C01C21C89
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 00:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0C0749A;
	Tue, 27 Aug 2024 00:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dLOYmpzk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sHCcXVel"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E8E4C76;
	Tue, 27 Aug 2024 00:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724719487; cv=fail; b=YHlkPaTmQcz2eLfy2Yv/n/hDhj0r3OcSiIwqbXBBFiXbXta364oUNpHaslpc+TbWclt7rtReU6/CmeMMEYZ4Omyu6eI4mmNxEqjQqETkHOFqWf6hz/HNiMqdAefKZjN9HQRxChg7FBEGaswDXH8R2DyS/DsLMBg8SZAW0o1HF98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724719487; c=relaxed/simple;
	bh=J1ERHMEn59S7fqD2D+CIpz6WULUK0jOFmXi6z2rQAvY=;
	h=Message-ID:Date:From:Subject:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M2CipySpVsTHmMdmiBC9sHeZjSP3nVu2ExIu/MIT6h49Zy56TU4DwboMLTpuQIOS9vUWZ/aPLEHTvZfplIl5aKy33PjW4E4WE6sk0ilQ6JuMxeNoteoFm7I9tkJMY/u5Wuy8TX74lGCt4c/6YhE750zxgVc2Se4kYV/rjo0rkZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dLOYmpzk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sHCcXVel; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QKtTQb002152;
	Tue, 27 Aug 2024 00:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:from:subject:to:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=vAO0i4TdMhsEYsq12qh9Lbn/0aAKqI0aP5MYWBXPMig=; b=
	dLOYmpzk2btNVsyaucXC3zFMDp+ziuWXP07FFJkmzBsMmpnuoZUUqOOtUSPhu1hj
	pd2YQAkXE504s2sWeTyiVdl4ct7P1umrws11kH7F1+MDK0+JceGixroVMHgvPnW1
	OcNiD5qypAgcUwdqSuilmH/dsnACy5XNgAfzUhs7fqZvS/N81hG8iNL5b6j8jhlf
	lIQzgj+TREpjcO4RNsiRdlT7ZDJnVqejb8fDyj965wzmiPODMjd9t+FhkrvPLiEO
	5lOjAtLF5wRNOdP7LpVA27WkTNDjmsVY892WGgw443JRShCen20D6HIfYRl4rRDV
	vBjGrPttqUa0kI1sfqw9nQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177n44cpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 00:44:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47R06jsN020347;
	Tue, 27 Aug 2024 00:44:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8kyxf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 00:44:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5S30pH/Q78EeSYwRlCXsdJLjnRE41JWQ3EsOffAnTFF44MrFlrV/eosAAQApRctCxLAg5R0y2DkwxOGQklRSU5cs5CDBieXXoC+jTeCyvLDrZSTUhZAcPBXz5qaIF0PyeIU8nVRvU07rznING2rHdcZq/b9qQCxfRTsJyB7/k/nEaWu0u996TF6x8SSzdHc5UKSi7ni4GYgkf3nDNvDNbL1qWKJoM1khp8Aqs3Lc53U3Z21bak+7rMtjg5TzRIDyakuzOu5DnCe1neZIpJtWFTR6ipHLD8uFz7hTankKXaoPpg0fouBLjViVtK45l/zqQgP0DOtKrIQbKTUL1ihYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAO0i4TdMhsEYsq12qh9Lbn/0aAKqI0aP5MYWBXPMig=;
 b=QJjeEsBXWb0AUQMOZRTlq21v0cfPvfoUlpiVd9xbsAE4eJKbnbuzn8zjFPa1iLX4U80+cX1a+Dm8NBZLzyC5PA39NOCzyLMpSmZ6fDk7P6p9QRHNrqEWgmj74o0n7jUTYJUAlS2jbuYfDbl2rVDzGftzT+pEIIudMT6K9NyN4krfePa0j2vK8EZRz8NasXBKMI4yEFzilwGKL5Aymt8UaRinAjN91pGs2RY10mcscBbTy/WvsVGoM1bOhry/K9ltb5CH5636MQAsfWQIKa9XA+AIxcaWw2JBdeRd748h/u/mWVtnzcUaHHqgUdl0MaWWkOENZYs9vJ62eZqK4lUpUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAO0i4TdMhsEYsq12qh9Lbn/0aAKqI0aP5MYWBXPMig=;
 b=sHCcXVelPTu7o7HhJ4c/gN0r0oWfh3HIFk2AA1mNSDDLX1mhs3+bWRMIDVhpAjSeeEDTY0sosZKZG+YcHTari3EwNijm7VQI3Qzxc3WrGo/9EsiOPbk6ig2vPRuGuLVp6u5ZUWLNJJfVsBABbYi5KJkV+FZtAwaId5jCiDaUe44=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BL3PR10MB6137.namprd10.prod.outlook.com (2603:10b6:208:3b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Tue, 27 Aug
 2024 00:44:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.7918.012; Tue, 27 Aug 2024
 00:44:38 +0000
Message-ID: <d5f74472-d5ee-4e16-a99e-219301234339@oracle.com>
Date: Tue, 27 Aug 2024 08:44:31 +0800
User-Agent: Mozilla Thunderbird
From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v3] fstests: btrfs: test reading data with a corrupted
 checksum tree leaf
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <1b0c008b1b05a9fd24b751e174da37bd769637ff.1724717443.git.wqu@suse.com>
Content-Language: en-US
In-Reply-To: <1b0c008b1b05a9fd24b751e174da37bd769637ff.1724717443.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0206.apcprd04.prod.outlook.com
 (2603:1096:4:187::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BL3PR10MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c557a9-56bc-4219-486d-08dcc6316e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0J2TGkwS3pzalozbTlyV1kwQVEzOUJPNXMxb3poZTBRU0JwYnpBN1EzMmpu?=
 =?utf-8?B?RWdabjhIV2FUMlpja29tNkN2cVZ1WDdZZlI2RUo1bHVCWXRsSEFCajNIMDdE?=
 =?utf-8?B?TmJmd3FpNTZaNzdwMnEwSDlzUTFsUDZSVVVKbzRWM05yVWh5RGJYS2psblQ0?=
 =?utf-8?B?dklUdlpJTXdGTFJvYnJIcUU4V3ZEbXZzWEtOYWNvR0VMTi9naXhvUitlUEto?=
 =?utf-8?B?M3FocXJ3QUNBVzR1a012eDJtNlJ2eS9RTHpvRnVpZFlJd0liTC9SNXRwTVhJ?=
 =?utf-8?B?NzVITC96bUdLNThBVUdUTks0MVhrTUVCVGxwSWZlOHpIOGpmRUhJRW1yQzFH?=
 =?utf-8?B?Qm5YNjVzWXVYVEhnWWQvV1dTRUgrYVF0THlBM25rdmUzZVNtZUlMNDFOd1kv?=
 =?utf-8?B?T21jbWNkc0g2YWprNmcrRkdVSlhjN2EyaDJ4RGQ0eCt4cWNBSUV1amxOQVpx?=
 =?utf-8?B?ckZrWFMyd2ptUEpheExmM1Q3MWZsbnVlOXhvNlpObElCQUtnR28xTE5zRWJZ?=
 =?utf-8?B?disvV3IrQWtKMHdWdi9HVlpOc3VkbHhtbHMyVTBRY0xLdERaRW5TbEkzQ1FQ?=
 =?utf-8?B?cGMwNGJ4Vk9wQTJQZ3hFYUxBakM4OW05SzZrUTZsWU45elF4QUQ2NEtvMXlh?=
 =?utf-8?B?NVRwUUpxbHRSWnNRckhoaGk2Snk2dW9RdkxDOTQzMWYzZzZEWUN3WnpNUlZL?=
 =?utf-8?B?a2lxTlR1M1g3dytFVzhkTzJNSk8yditxRStRQkxOQkxBY0JuR0o2dFJHRzFE?=
 =?utf-8?B?SGRLOHlPeFdXNUZEdlJtWDdMaEd1NWtLTlRlQ0ZaYWIwUXNKMWYydldBN2My?=
 =?utf-8?B?eHpBMTVJNzNCbm96NDVGd1V3Z2lQckU4VHNGY0lYYUR0Sm4xVDRjWmx5UVll?=
 =?utf-8?B?Wnd6dVpUN1lOTHdqalVkNDlBL3dEbXF2MjJsSGkzQ2F1dWYvamJWRUZCL1lM?=
 =?utf-8?B?K1lZUkQvS3RQVW92dmUzK2hQd0U2MGZ5eEo3c2R4UW9JVHI2eUxPajM5WFR1?=
 =?utf-8?B?RDF2MnlMUXZGVFVldE9mUFlQWDJHcExURzhxUVRmTHNBV3VoRjNjVHJiQytx?=
 =?utf-8?B?OVBJVlBHelpxcFdRcVRxbjVOTW5HYUJlNmlBRHA2MllENGR6UDJ0QVY4UHN1?=
 =?utf-8?B?UGNmeVlvRE04YUVKc1pranltaEJFN3lEbk9SM09ZQm1sU0hRZ0I2WUFzdWdC?=
 =?utf-8?B?T25rM1p6RDNDdU40dkhCM3BnVkttZHlHRC9NNHNnR1lQRnc1REFPRER6UjZv?=
 =?utf-8?B?T09KUzRkVk9CL1N1MnFMZ0htb1hzdDcwNEJOWXF5anFuN21ybDBGeS9oTEJY?=
 =?utf-8?B?VFZTR0tIRlJjdnZvQklPOFdhVVE5OU5FYTdQNzRqSGlVTHprazN0azVzeW1Z?=
 =?utf-8?B?ZWVGT2syZEk1blh0NGFFekw4TjlsSm5qRUlGYVlsQ0Z3d29uU09ENmoxNEVp?=
 =?utf-8?B?enVBVXBrYlY4WXdkVEEwOFhNK0xyOERpQm9oREJmUWl5VFVCb0RqbWhNMUFX?=
 =?utf-8?B?R1phcFg1SEZSakd1VEwzSTVyNFpYUWhXSVBudWNtS3NMTXlwRTFlQjJpS3ox?=
 =?utf-8?B?eUZQcXZmMnlpY1IrTFNzY3NNMlJQZHVCT245VVdYbzM4UlhwWlloNlRzdUlR?=
 =?utf-8?B?cGZSVUpqZEx5SmdoMjZDZ2wrUkRRUmZ3UCtOVXU2YmJCbnIzbTFZRFFhZ1hN?=
 =?utf-8?B?RGFRd2JJT3JEdCtiRUUxM1JLR0luU0pqSGdaUkdDd1JoZ3prOU5uWmFoWVdr?=
 =?utf-8?B?dVBFUzZUUzdkelZVam1oTTk1RkNsNHBNZUxUald4YitMaDR2L1B2VVp6cmpS?=
 =?utf-8?B?MHp6eUJvSjd6UmpQTnIwQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cStrS2JiT2FXZmxDTlM5L0s0OUYzUUFIZHFjeGtZRXExM3BGMGpUdGE0T2I2?=
 =?utf-8?B?K3pFTDlnMW1pYXpOWkdZbzhlNndIaTl1LzJleXlHSHpoQ2RqaVpHcFdLZEVj?=
 =?utf-8?B?VTVHMzFyb1Nod2QwMWVHdkhFemZwc3VLV1NxZHgyak4wMW9WWm1laFpabEU4?=
 =?utf-8?B?bU1NRUdneFNzKzljeE9jOTR2K3c4QWRGZjlOYm9zTk5MOXFFbEdOekFEZWtu?=
 =?utf-8?B?WE5BcnhuNXA0SzZaZkNMV0w4N2UzMlpGcFQ0TWQxY1NLWFpjT05QR3ZUOHBB?=
 =?utf-8?B?TkxIU1RwalNZUytDZzU1VEE0cVM2L3YvdjBkdkJvV0FNSDFKZDN6N2JXM3pn?=
 =?utf-8?B?emhvakt5QkhKRGUxZkkzUGZXOWo0WVlaU0V4RUszNEVYUXFWMkJaK2xCb1dh?=
 =?utf-8?B?Q0ZCVU1raGFzb1pkQWdGVEsyTlo1QWNIckZCMksyQ3ZtWVhwQkNxVEMyaEhF?=
 =?utf-8?B?akhRNUpKMWo3eTB6czEwRC81SUlnUHIxYnd4aDFNKzhvcjdZbTZLZjhnMjFE?=
 =?utf-8?B?cTBDSk1PSGdqV01kSW5VcFV2ek96ck1tcTJRY0x4UUdJY0p0cG9lMG9RbXYy?=
 =?utf-8?B?T1k2Z0hwQXRGTXVJM0ZkWEU5YXI4M3VsZ2h6dmtKeFlFNlR1TWxKZGwxQlZT?=
 =?utf-8?B?TVhXa21SSlAxdGl6YTViSWNoenFHN3luWHJqMlBhL1BaV0gvelhKYzl0Ulc1?=
 =?utf-8?B?d01UTVB0WVN0d3NYeXdVUEMvSG4rWk5tQURBTUFWTGRId3Nwam1lT2ozcW1u?=
 =?utf-8?B?N3ZtcGhySnZydXB3ZXpGalh1Q2ZLTVNobXNFbnRRYk44S1FVNXdyTVU2VjVN?=
 =?utf-8?B?ZkZhN1FOTml1TWR4MHppcGJObGZDWlVlMWVqdVc5NDVCNlJSRWM4ZDBYellU?=
 =?utf-8?B?cXdCVllHREs5WTc5ejIwSjdPSVBlbjZnN3JOUlkyRWdOaW9tdlhYWWlvdUtk?=
 =?utf-8?B?Zzd0Ymg4V0duTkU0djNyYnljeWcwam1KNEFzQVJyY1dYQW1LL3JXZjQxUm5L?=
 =?utf-8?B?U1pmTitnMDlUdWZudW5jbmFLakZodVEzMWhjZUxUT1NQVUNzMjFramNqMUtM?=
 =?utf-8?B?WmNNU1dqRG9wN0hkMlpoclBud3VJRnY1cUlYaU5GUzBwbThTZk5mc1l5OTJF?=
 =?utf-8?B?aEtZM1o0RjhvVnAwYWsrL3V0UjlyTUpobDVZV2ZLZ2NvL2N5dllNWnJSNjA1?=
 =?utf-8?B?OUJOVG9URi9UUGc2bWFQRjJLQktLb2RKUEZZK3dzck1SM2NtbERpd3g2NHp1?=
 =?utf-8?B?T0U2VkNjSEVRVXFoRmcvb3k0eStEbGg5NmRYaG83RDVHdVVLb3BKR0ZiU0hs?=
 =?utf-8?B?RHIyL3V6R05VYk5HNkVCbEIvNkpEOFJqeVV4ZkdqV2IxNEsvNkFDRkVjMm1J?=
 =?utf-8?B?QXpYa1lJM1llZ0p1UldURVF0Zk5CRGRFOFQ0UStScEM4eVFGNVIzZ0I0ZnYv?=
 =?utf-8?B?UlZaYXVReFQ2ZmsycTloMmg1MkFvWUt4QWR4YVN6clpRa0hiTzg3MllNUW1E?=
 =?utf-8?B?bHRtUk11VnhFV2NBSjRQRkJmSktYSHNEdnBZVmU2TTVqWDhPYmtYc3Y2MWMv?=
 =?utf-8?B?Rk1GNHVHRTllU3cxZ1hvcHJlcnNhOVZGcGh1RmVBU0ZLQjBsL2YrMi9BaTl4?=
 =?utf-8?B?b3gyTWpHQUUreVVDTFQ0eUF3R0dDZWlNYmljN0FqQ09Td0lIVmdSM1I0cWFt?=
 =?utf-8?B?VnBlbTBBUXVVZXdQamlCaGVRdlFzaGpPN01uY3lFalA1Nmg3UXhILytQYXgw?=
 =?utf-8?B?NU52NEU2a0FtVFNnSlhrcHd2QjdQek42RkVqcmVKUExSMHF0YnpXdTNpQVVm?=
 =?utf-8?B?dkl5Z1ZMVnNvRVRSU0d1SElHRXZCZnN1SWpDZnRkMFZXUWhodHBTNXB4Q290?=
 =?utf-8?B?ZHAyOFo1VVRFVGVueXB1UllDejVwd1ljSlpsWGlSS3ljY250N3Jkb2tnUUw0?=
 =?utf-8?B?VnZQR2Q1ZGJtYzNFYTRETklvcnZhYWRnNk9EZ1R3N21GTHZ6Ym4yZ1JLeWZm?=
 =?utf-8?B?YmxhN2FZS2ZSZ0JDTmRMWDRsam4zbmxvRTl6djRMbFlwK0g2RysxR3RtNkNH?=
 =?utf-8?B?SUNZU2Y3dUxYTVBRNU9KSkNzRUIzTCtPekg2ZUQ3QjVvWmtoWjRTYWxDK0hz?=
 =?utf-8?B?SWd1bXIzZVo2SmNkb2dsU0VZejNHNko3ejhWN0N2bWY3Wk84VXZJZHdPbXJq?=
 =?utf-8?Q?OZEThlP2GElwfZF4ctW76VA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n+QhkkCPFIMBsWS3VdaIE9Nyjy9OEkXwRzmYp3TqUN8PYfze18+SFEJgKPH2jcIsd3sdfwqKh1U0CXGIqzsLbHKEgiID9GkFmH+LwfbYj1yIj6QSievoYtAv1CgGRWbFXnmDFI27a+CyEV+8vqwHbODE9CFaCb35c4RAQ4txRkoZoerHpTe3wVHJ4TuNIB4BEp2nrQPmXiCu5mQ8vd8MRPP0+Arht+UXYLMRqe8nOZEHijJPx/OiSr5whD4ddw3b1cKR1vr9E0WHB8R9BICtvxUCUWnD7PdwTsOGoKmYUFGoUJy5xcqFdddEjKYkYZtsMYSE6e6V1VJwx6pM2fbiEQmOvUKea632imSKaC33iGQJOh/0cPE9uustixhRrPpB9PjFmEpHKGwajfPdkcmYVPqfPPSFJE1ukwk5cO1TRm2aMLnp/w7h7SealitG9jQC/u9dEGUNes46WYaXZJ9sPFXi77M8TmN2WtfXyBSuAKjnH7JzyVXEVysCB/j2lacOvuPR5f3BswQ62PvT96H0YHq6sY9mluuxPERXod88zFrMnTBUrt+wDtsP4O9th2HU0ieR0ZBBTNJ0yr3tchiM+8ktnQlwBnjbWD0CpjZ+ENw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c557a9-56bc-4219-486d-08dcc6316e26
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 00:44:38.6567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YD662MYO/YWozGStaVeU0CqZMlc0m81JWVRAzjbSS2WP4NmR4UAdAXymeM5kiFhaXLm/JFgIltvoE885RHnDkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_18,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408270003
X-Proofpoint-GUID: mmbFnWI_h-1P4BVOYSwUCVfbwTd4G1pi
X-Proofpoint-ORIG-GUID: mmbFnWI_h-1P4BVOYSwUCVfbwTd4G1pi

On 27/8/24 8:13 am, Qu Wenruo wrote:
> [BUG]
> There is a bug report that, KASAN get triggered when:
> 
> - A read bio needs to be split
>    This can happen for profiles with stripes, including
>    RAID0/RAID10/RAID5/RAID6.
> 
> - An error happens before submitting the new split bio
>    This includes:
>    * chunk map lookup failure
>    * data csum lookup failure
> 
> Then during the error path of btrfs_submit_chunk(), the original bio is
> fully freed before submitted range has a chance to call its endio
> function, resulting a use-after-free bug.
> 
> [NEW TEST CASE]
> Introduce a new test case to verify the specific behavior by:
> 
> - Create a btrfs with enough csum leaves with data RAID0 profile
>    To bump the csum tree level, use the minimal nodesize possible (4K).
>    Writing 32M data which needs at least 8 leaves for data checksum
> 
>    RAID0 profile ensures the data read bios will get split.
> 
> - Find the last csum tree leave and corrupt it
> 
> - Read the data many times until we trigger the bug or exit gracefully
>    With an x86_64 VM with KASAN enabled, it can trigger the KASAN report in
>    just 4 iterations (the default iteration number is 32).
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v3:
> - Remove the unrelated btrfs/125 references
>    There is nothing specific to RAID56, it's just a coincident that
>    btrfs/125 leads us to the bug.
>    Since we have a more comprehensive understanding of the bug, there is
>    no need to mention it at all.
> 
> - More grammar fixes
> - Use proper _check_btrfs_raid_type() to verify raid0 support
> - Update the title to be more specific about the test case
> - Renumber to btrfs/321 to avoid conflicts with an new test case
> - Remove unnecessary 'sync' which is followed by unmount
> - Use full subcommand name "inspect-internal"
> - Explain why we want to fail early if hitting the bug
> - Remove unnecessary `_require_scratch` which is duplicated to
>    `_require_scratch_nocheck`
> 

looks good

Reviewed-by: Anand Jain <anand.jain@oracle.com>


Thx. Anand

