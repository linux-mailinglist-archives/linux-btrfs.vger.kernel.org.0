Return-Path: <linux-btrfs+bounces-13983-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777B8AB600F
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 02:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F5FA7AA55B
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 00:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A999F4400;
	Wed, 14 May 2025 00:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="baKTXPGg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XrnSqh6x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC6C1C27
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 00:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747181408; cv=fail; b=sL9NiEAvNuXYHskz8oJ+y0yWL0u39M9fsSE72uryYVxdRHIqkrs7g/FRbfLEI6acDrwHu4Q7XG6d2Qj7QZP8M1kRQIt7zEz5dkaXcDW7EFRbosZwmu2L8L3rfv1YBZ3al8ZX3HP7HN8p1rxSTcYHCj5+idf6yhrSMlMp9wSTx20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747181408; c=relaxed/simple;
	bh=dGJnJo9HlZbPGAh1aeO+mm6UB9yFzKq0oGoB/wsiUOk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g1WueFgHwPbdb+9n8OwrXdxuFvHV8Lucj1Vn5KxKT0iK8uMlaH9xQEbXT9qlJBmnDseveToDuZ2TtKEfsFgo9cmE/vKXUHQ5ED/K2Tc5FrIZEx0bQN+Z36XDLlDv3aCbWFJ6q4jAoqOUD3nStRobwTswCx+/rioFRon7GhdNCF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=baKTXPGg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XrnSqh6x; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DL1Ls3028045;
	Wed, 14 May 2025 00:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dGJnJo9HlZbPGAh1aeO+mm6UB9yFzKq0oGoB/wsiUOk=; b=
	baKTXPGgrOFI6oWSTxAbOSYDKjUokVGWG+kRsT4xQhsbI0I4KfKP1CWuzHQnzNgL
	deyNvbTmbXXt1jARFhLJTNIFN2ZS57SuGb+5iLrHFIhUi6kjKG/AXkbTstJuJ+16
	3wXC1SDc5pbHAQmCQYr2MZOcx0xPhIaEura9REtmgbFfBD3mRPj1TWAA6GFMynEV
	j538vmNGq4tHB2FfJnOoeigbpYbwFd8Jiv8BBT3+vaLXvxlz/Z6rlGif6ThSL6IT
	tmbmioKr9oBLYMpLMjGHw6VZPsALcYgBuGmF+igKbQO50htg92eejy7HewtGVJdV
	bkK5wkd2bbVpUwhD8NWe1A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcm0fac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 00:10:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54DNnWum017326;
	Wed, 14 May 2025 00:10:03 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012054.outbound.protection.outlook.com [40.93.20.54])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mc5f0db5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 00:10:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llMWEitLsy7isM5mfRwVIAgY7Jtnd6qZEss2qIof6BNl0R7n1ufidHPt2UwtuXabqEIAaBepy7q4FqeVSt91KpeeAL0wpvlGE0zFelev8GDSX1niPpDHodH5I+x8BEmfdcfhZdjPhRAVgre1LNsg3L7WpHT33CC8CO4A+T4v++zeGIPftnb1USqHx0fk605e5vnG+aAFH2nUmg1txpmeCFfY0a7MbcXQ1sRTBAbjK5YcgRdRdiRJF3qM7kbVFPCWBVhCc6UfB66bvUCQ2oYao94lf4KfnEhTW44ITYxeWawDgIwrq+mLahjPOseHZoFS+cexRR6V2LHWBmFl0SS1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGJnJo9HlZbPGAh1aeO+mm6UB9yFzKq0oGoB/wsiUOk=;
 b=wLQwS8WMOFlgQq4U7Q4WnSfj6zIJHJ3wldD1Qiq82rco6EwkU/ujIre0FJc+A3HwvV8LzVHyFrekvTuyvkanqUzlZgcCv806snx5PnPCr7IXazTYW/sMUZSgeCBWYATbxjY/XX9wR3DQvKDZpXm6DUoA3/pcy9FpH7/+OiZwC7MYiguXw0FekrhjkJPU1VBKRhaaQUYqygEivp291et01rWNFLxX8qQ36R7/iDjC4Q0KCpvxRL/71AQ8Yl9SsE675RfwpglmdZB84xOe1EGv2BNasp4rpq/5Vsa2EtgCHUdVahMvbXxvp2mu8VueIV8KpPl2/KGDOS17JlAphmvmcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGJnJo9HlZbPGAh1aeO+mm6UB9yFzKq0oGoB/wsiUOk=;
 b=XrnSqh6xwKmYKKbJD/Cuqcvxbpj7ICG3a9sj6BhgsXM34bwdJIhs1JOKhaYzwYP3seKHK9vezKFIguYSdc9i4tRXJiAeTuM89ICrpHOmjR1dcfk0AQV/+sacF+LJjBvMCJzCT3vuGqRR8UuOVOqHTZGkkuZjyTUlkTYxQzS3w+s=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by BL3PR10MB6185.namprd10.prod.outlook.com (2603:10b6:208:3bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 14 May
 2025 00:10:00 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 00:10:00 +0000
Message-ID: <5c90b6f7-c51d-4c4a-b20b-c4aa169285c4@oracle.com>
Date: Wed, 14 May 2025 08:09:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: replace: fix an unexpected new line when
 replace failed
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <76f6e03df7209fd09af92c36a572489e2009abc5.1747178054.git.wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <76f6e03df7209fd09af92c36a572489e2009abc5.1747178054.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0084.apcprd02.prod.outlook.com
 (2603:1096:4:90::24) To SJ5PPF97E574FF7.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7bb)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|BL3PR10MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 26efb059-5d7b-40fe-d3b0-08dd927ba9b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWpLU3k0cHloeUQ4TjU0QTdTUVNwd1ZIbVpXazdJaFlxdmo3STdKYVlLVVJy?=
 =?utf-8?B?dU1OTW5pVXBjK2pibGN4ZEkvMHdkWU9NR0ViWjVMVzBPWk14eXFtZHVrVVJF?=
 =?utf-8?B?b1Y3S3NPeFBvbWVYL1o0Tmd3eStHU29YSFBvNTJwLy9zMldNRk9ablJpckVh?=
 =?utf-8?B?TnBUY0tSRThuWnM0UFphZkNMUFFQSW1RTE13emdWZ1ByWFNVODkyZWZOak9h?=
 =?utf-8?B?SVNBYkhxbDV1QW5Ld2RJUE9KK2V2cmpjSnZTSDlMMnVGZmNnRm9yMnMwQ1lX?=
 =?utf-8?B?RkdBZkNEL1A2TWRHSy9HM3hSbnFyaDF5RVllR3djeE1NMTMvVEs4N29Oa2xG?=
 =?utf-8?B?RjZPZXUyVm9ZcVU2TjBPRU5BbVJ0Z0dEanFZS3JTMXFwS2pQM3RjUFNsN1J3?=
 =?utf-8?B?ZVhtR2xBQTNuQWNuRFk4Q29zeTN6am9rQTJDWTZKOE9BZ1RLYWU3MnN3RzRM?=
 =?utf-8?B?Z1BIcmk3MGp4QWtKNXhKMGh4ei9WalJEVFlIZGlreUpidm9xM3Z3VkthWWFm?=
 =?utf-8?B?TXdnUHRIRDRXK2dHTDBFVCsvckpvakRUcjdoempxZ05CZlpsMDNUVkJ4Qkht?=
 =?utf-8?B?bFJsMUhuRDNSSGtRdWRZRFAycFBrMjhENEJTYUs4QlhVdVNwNHg1VnMrRmZY?=
 =?utf-8?B?Y3F1QVNoSldxOElWVi8rbmJGNWJCRjhOV3V2dm0rczNPamNxWkp4ejlQS0lz?=
 =?utf-8?B?aWQ5cW11N3FEMkJrM2xXM3dNV2dEQUJzczkyck1jdEFmdVVmRnNiZmw2bU01?=
 =?utf-8?B?S3hkTGJJY1d3VWRnWjJPUi9JUFJGWUpXUnJUK0lVZnhHZGEydXJkMDVyR2E0?=
 =?utf-8?B?K05kbkdNbDV2cDZLbE5PWkN4SEVnMTdSWUo3Q0JtK1UxZi83aFBzNnRidlV0?=
 =?utf-8?B?MXJLUUtEUE5hRmoyNWl4QzFUYWsrMHJRQWZQd21TeGJQQ1ZLcThqc0xlclBI?=
 =?utf-8?B?eHFOQ24wQU5zbGR3M3BuWTFhdk94SVp4YzhaZnArQlgrdXl1Qy8zMVFkRGI4?=
 =?utf-8?B?TEJDQVc2Rm5OTmswcFNWWVdTNFRnV0dDa0dvVHRNVXBmNXZ3T3R3ckllbXFm?=
 =?utf-8?B?V1lDeC9pc0w3V2RzOHdJUE4wQ2YvZjVvdkhBN0laTGNTcElxc3dqRGQ2UzVQ?=
 =?utf-8?B?ZE9UQ2lONlpaRVFYVkdKWDdtL2p1bk1CSlRueE5QWm5XeldFT2J6UTNxY1VC?=
 =?utf-8?B?RmJlWjBGY3NiTmVBREUyQklpSHFheDBmM0tiNTZQQVUwV2FSaFJPOVc1UU51?=
 =?utf-8?B?UWJvRnJPNHZUMjRYYTBtbXhWaWhDL05sa3ptQU1YbXhwdUJoU1pqUTA4ejU5?=
 =?utf-8?B?UWdwc2hkLzhwVUttbitJMFR6R01YbkFqZnk5amwxVXJOTVUwaHFJa2pic2l0?=
 =?utf-8?B?blRwcE1lVFRiaVZVVG9aU1NuVVdVdVh1ZjJ2N083bGRiU1RDT1lzNmlDK09v?=
 =?utf-8?B?QzRFNjE2R2R4cE84RlFoYmlXSzh2Wm91emNpYk04QjBjbHBjeUVRSGJDVi9Q?=
 =?utf-8?B?dDdxV2xLeWZwak5QOVUxRld0MEx1dGpJWDZLRFNxOFJwNlJzbWZYNmJKdGdq?=
 =?utf-8?B?M3NucDhoVFpnVDZoNEZ4SFMvTHUrUFZjNlJhVjJ4eDIwak5Sd1NOaGVlakdv?=
 =?utf-8?B?bzlvQ0lGMDQrY2E3MG9lV3htR05LbkE3RWJ0cTlWMXJZS3dtcWRNcXN4aHpC?=
 =?utf-8?B?RzhKVDY5THhuL2dXampwbnREREZwUXhEVHg4REtSR3ZyRVAyQTJucW9ldGFt?=
 =?utf-8?B?Szh6TStsRERvTjNsOGc1MVVidnJyV1NFWElDeC82VDQza0x1SGgzZGRzVmtT?=
 =?utf-8?B?S2ZRTENRL2JjeGRvVXk1UFROYis1VjEwWXpnMmNXd0tab3hCK1R6VEhKL21K?=
 =?utf-8?B?bEg1VFY0OFdhdG1kb3I2ekJYdWZCWVlWQmJlRVpCR0xLM3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVpsd0RMczJZQkxON1lYL0dMVE9tOFdFUWsxaE1jcmFlUmVML1pvb2FBZjNQ?=
 =?utf-8?B?VjNZamp4RStHdHhyeVIzQW9GV2c1eDhBT1d6OEZyRkJEY1RDUHpaR0JRVHI0?=
 =?utf-8?B?Q1dVV0lCZkM1Ni9IRXRRKzZtOE9kejJYTHl0V3pwOVBKdDhUQjdhOGRCQ0wx?=
 =?utf-8?B?bHlvOVFuMlRCNHBvazZic0NtMTZhWFdRbktIYjlrVGVrK1JmeGJ1Y2c0UTd5?=
 =?utf-8?B?MVRmQkNTWWt3YkZrdXJBcFUxOFhpV25pRGVFUDRDZmFtUVRGQndOZjhtdjRD?=
 =?utf-8?B?K3pndkhPU2gyRmpCWTM5YmI1ZFNCOGU5cEVVcjh2aGN1R3NPQzhKY1NvMEF3?=
 =?utf-8?B?RVZxcFoyeW1EVlJWUmRNSURocHZhaGR5d1NDZS9memFVOW9xd0xCcUJzUlJX?=
 =?utf-8?B?UTZrcWpxeXRtdkVJbmIySDFRc2psNnl6ZVBxaTc5citGaDY4dXhlQkRUdFJB?=
 =?utf-8?B?V00xNnJNZGJ5emdoeHlJRm9nUUJuSTUvRzN0V1c5dm9XK2dHaHM2cmtKbFFu?=
 =?utf-8?B?anBBR1oreU1NU3FQQi9ZODBnK1hZTUpSRU1OeWlBUmIxVk5zSk9vZVN3bzlH?=
 =?utf-8?B?T0o3b3ljMVIwbG8wTXJFdDhRdS9HODJTYWd4dUJrS0tGaE9NaUROZHRQaVhV?=
 =?utf-8?B?aTFnYjErQ2NOdU1wZ05rN3BqQlVhb3Zqekd6cXNUZHVqbTYzbnFVL2ZQQ01R?=
 =?utf-8?B?Q2pXM3dxTFBCM1VobEVwQ2FhSWZUd0w5V1lZMlZCODFiVU9nNkFicS9RMjdu?=
 =?utf-8?B?Y2p1Tk9ES1IwNm5CY1phUUlGenplT09NcWNHREhnekNTTHRwd0RzNGQvcS9K?=
 =?utf-8?B?YXE0anNRdTkzd296NnZxZFF1bzFjdkt2TlpraTZlVVhqdWEzS0h3dExxYzFC?=
 =?utf-8?B?Z1JTcURMNkg5cndEZjIxY2xyRDhrSUtkMDIrMmxnSS81MWxPWGh3NGJLeitO?=
 =?utf-8?B?bWpNTG1PbFRtYmZEZnlHQ2RUcjhhU0dLN3hEcXVxM3V6aHB4dXJYRDRaRmZu?=
 =?utf-8?B?dmdJMm9pRk9YOFVsbXlNTTU1SjdYc3kxQkJYN1dHUzY0L21hclk3OWt2YThT?=
 =?utf-8?B?NEpJUU8wbUVzOGFGWDhLZm9pd0RIb2FGdTZMQ0Z1aWQwS1MxL1NHVmZXZ0hp?=
 =?utf-8?B?dzYyMS9PN3JIMDBtY2tqNEpTMEt0RE1wemdXS3hYUmNOSXQyZlQrVWZmQnJ2?=
 =?utf-8?B?MUt2RWhBcytsWlpHS0IxcmRNQTVQcTlTdHhPZmgwS1VBNWRyQUtsbXlZNFhH?=
 =?utf-8?B?YzNrSmRmMDZLamhXcWt6aVg2c3hURHhQeXlTT0cwWmZwT3RhdXB5YXJ5bmVi?=
 =?utf-8?B?U21tR3p2WjJyYjVWWDRHcjV2WDk5UzM1SmpSMTFiRUlhU3FvZ29vRmpLaHBG?=
 =?utf-8?B?YjFvc3h3U0VDV1dYRmN2ZjNPby9ZTkNsNHRyVnJvWTQ0K2Joc01keFJFb0ph?=
 =?utf-8?B?dm82ZzFuckdQcXZQMzNHRGU4SVBJaVJWeERkZ3RFNzJjbTB1OGFRV08yYWoy?=
 =?utf-8?B?cFJNYmt0SEdNNlc2MzJtYTlGQmVNenMzanNVTVFsZTY1cXBLZXQrZGZKM1lO?=
 =?utf-8?B?YUVKc2l5YmtLdUZqRHc4MStVSHRoSnB1UndSTzROQkZPaXNOZXBuOE9hTllG?=
 =?utf-8?B?M29GeWEyMzg4Mit3andUZGFPOG9OYTNsd3RRK3lIcnI0SEowMmozeWQ1SGpK?=
 =?utf-8?B?c29CNUxENHlSSlBqZFNxRFZPK1JTazZxWWI0UC9vclM3eUZadWZUK3NtUVZ3?=
 =?utf-8?B?SjZ4cmhzYWJRWVhuYTFjdDZQMDZRSTZ4dUZWY1hURm1mRmREVWpyNHlNVUcz?=
 =?utf-8?B?ayswYnlaTUlwZVdmREszenc1UXR5eXhUamMyR3IwRGlpMi9kSnh6S1Q3UDdh?=
 =?utf-8?B?eTlmekNONzdVbFVGM3pPWk9MUHJsWG5ndEdqcDVvbDNBQ1dNenB2MCs3bUJn?=
 =?utf-8?B?VWMxV3J6R3BiY2VlR0VtNXhPbGtTV0VBQWd2Q0xJRnY4MEtkY0dHRCtCc05X?=
 =?utf-8?B?UWNXSzlMQ1VuMHRuTEpvWlg1N0R3dFVZSkJVN0l2aDJmWnY2K1NYRnc2djJL?=
 =?utf-8?B?L0d6d2hwV3lVYUtGcU1hdVFrekJIWGNWUDhwQ1hrc3hrdDJFTXM1bmh0cW43?=
 =?utf-8?Q?cOAh27ABzGE/phlwvpr2FiLBr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QUiFkAZlLNS4Q2hllXos4WZWwDvx5C4hA5nwhBefPazVrbMUA1eV8pnuFust6mVY2NdEbTAFBNs+5z0X9Iwmn7oCH7ispgIdh575BzksWb1rxVerRepiJKAuSf10pr9TS/ZKn5t5CvryoC3VjQvMUnaaD7Iv3cfEtdLOR/IA7akIAt4LEldEldJ+8J9GxmyDDuENulV0y1lqVrirtW9ui1TQpR5zUxOdUusGCS3I30eZtLpJKrjfq9MU932Nnd9lf6ztogWjfjwmxyKmK//zm52c63wxDnCZLT9rkYwkRXMEk8MG31Ef+ImraNGBeouMZ9hkJib0V2pkl9I6OSZz7dipB1pkHp/JbPv4l1cnccUnRqUG/jjxKcWmOxtwXArsKtMTeutbO8ch5QLP/Ac7Hw71JqIBItWdZPXvEuVHnXyUwdUr54IPckDWLLQZ77dTanF7rQCwwUxMvkbAZsOFicVlGsvg0w8HACn9mjBUgNmhpEgi8ISs1J8tWQ+iVlazSkFb2gKsTnqppE7aKwALhEBW0aiwNxqVcPpctleCI8chuGwP4gx20JAoL1QLqaziC8TmCLk29LlsGH49cczmB4kB/KuWOcS1PpvNye560Vk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26efb059-5d7b-40fe-d3b0-08dd927ba9b1
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF97E574FF7.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 00:10:00.2783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vg/ujYX2U9vKF46dyENhATEGPM0ksgTICxG/f4R0D9ew/G3v+QHOcMtTX/NPHs/fiHyuy/B+IRUQku+7cSfpkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505130227
X-Authority-Analysis: v=2.4 cv=DZAXqutW c=1 sm=1 tr=0 ts=6823df5b cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=e4hUrpnj0vApEZVtKM4A:9 a=QEXdDO2ut3YA:10 a=_Xro0x9tv8kA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDIyNyBTYWx0ZWRfX9KyiM7z3rEBm X4q2fkZSKiUT2/akF40GXq6EWDYeL3nvzViVSqhM9H6jTYyTdSfv2Z9fuRVbvaxEJ32esOl5J82 f32TJf5sViIF7sWUCD+2rvMqFOKDu8lO1FFzfDyJOyOvc1/+Meo/0HF64ezq4zvFT1Dari6lQf2
 JJUIF2wm8tMoexEaXc4n+RVPgO3o63s/mKUBGstVqHdMO/Bf/hclzFDSggVVboQigFpi08OO/h7 BdzoukkXrOrLunTx80447+Is+oLLi0NCzdoimga0s1s4t6vmv2RAEhZCA2nxIpaO3F3TwaCdDZi Qj/x8fDDKgu1vnUStz6VJ7KvKJ8pfhtQnf+440VOZVsgomc1oUFeFJX68Uj7F4gTa/OaVtBub8h
 a82BIyXT8htZ/9Bzcvn5T+lLaMMiZbZxETGOAUVO86noHZi90++liBDUsxoFgiI5k27jDw0v
X-Proofpoint-GUID: FT37tiWrOC_LnggApHzWCyMkJ9p5wKLS
X-Proofpoint-ORIG-GUID: FT37tiWrOC_LnggApHzWCyMkJ9p5wKLS



Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

