Return-Path: <linux-btrfs+bounces-8851-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9991F99A2F4
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 13:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5371E283417
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 11:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6352141B9;
	Fri, 11 Oct 2024 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KH3k/Uu9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fvnN7+1D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FDA17D2
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728647168; cv=fail; b=BsZL5GQiIdsg9zNG92YKartdRW1ilNDrcbFR6uO6R10sA12djUhHpa3m9THt3R/ADVmbSDkVA1LVRunKFDIBvBVxnv0lo2Bzlx6rm6Jh5YDnZUUI7KY67pPNwqvnhgBOc5diBU7F71lUgm1ie0WqcEgfCtQaYr7Ti9d7VZ26n/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728647168; c=relaxed/simple;
	bh=bh3wHtJovmnQS4LHUgV/fBWPW2LK8tEwfGl5uLXUgvk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XJSwb0G+ygrSSLAR/xTbAkxcf0n6bQrEWNhGehKojYWUG/fW5SlgwzYpZbzebBtWvqyS6kbouuf4AJW+XUyZbofhF4bEbsn9q+A2IrAU5sS5QIiQ0+qRHUtJ1QCuu1WujjP/3BovxBf92/i1k0GTqPd9eL30vtmbTuNmsvNJY2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KH3k/Uu9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fvnN7+1D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49B8BgAa026192;
	Fri, 11 Oct 2024 11:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HY/3CpSljp6rJLkZM9GfrEovwjZuGFQaVG585jIBpQE=; b=
	KH3k/Uu9rkLJYnRWrbbbpTeoskj5F2DteCqCnD/Z5OfVdmehzVD6Y73HjwCHV9tG
	ydAdTD9aQH10xoLTYrX/kPD7DKYQm0yJm09cgtvOVTB6YsAjSTpr6IejJ0Lmuyws
	Kr0FiRl7+YqSCkBfpudSLKPkIZGIUNbBVar7Fsd3mVpQP/9RSRFW+LpT2OI273gG
	0QTu1MiIo+JgHRwBzvvvPG6b3yzvWAMZaFdKRhxasbM16nUZywwr/cTXqjX0Ft8M
	eGopB9dSQLon3e7i47E1C2KWV20GgMHOhTCiulpMMn3O1t/fXGmS+rKUNkgde4zp
	8ncNL2i6utreIC6EZ6PfjQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42306emprk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 11:46:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BBedBM040289;
	Fri, 11 Oct 2024 11:45:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwhj8xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 11:45:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNqIrFnNOixrQAh5nl/Of2p/wyK0ICylvTejqBUVFX3BPkl56uoFohqTPBdmDsQChvbVX3Ez0JwU5t2TbUHkBWNMGj5NbRiwlbJ+jZcLG1iKxciB4OhKTDDr+tYAbLrBCjp5kHAKF6ISvnbytPpoSfKa/JJMAI46iK5NbXnccal9bTNTlplJGX+B/qvu2qdwJLgnSDr3FGdwmRzoTzDlzh3hg90MlzxqtYlKXj2rFP7JGF1UVRY1h8SNZ4UsXsoKyN5kMwU0b+DtKVgjRVAn0O/yXnGoo525uFaw4ZKJdUtqJ+yYOxVF7SHpXcTmE+26LWgJ+nB2vdqqCGw9Rh9E6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HY/3CpSljp6rJLkZM9GfrEovwjZuGFQaVG585jIBpQE=;
 b=sJcPEugcBKHIB/imEuYR0B1xpT1aAdpRxsIhIbwBkyZe9/m7ciIV2FHjkQQwQORtEvdkPZd3IpelJSSNUpdSOs0GkHPOlBiXzO/8UKF34LHncomItFTRxPvTWa5kGmnOQCViz0tMp5JV3sQgHiLyAtQAi+JU5JPpgSgmcyu1Gn6IXQLDbpR5s6nrlP4e2CCIL1u4j7ECHIz2hcXcvjg3GR5C2ejjsFudpv6bZDBxXDCZ8gAayO95xhHKr761+Pqp08Z0JIkzu2qNJ3W+3ibaDYDCFLuKqQL3+S7pmcAWf25go/wgwac+yWL9NjsjJcNFKKij7OA61pMsRAloSPhacw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HY/3CpSljp6rJLkZM9GfrEovwjZuGFQaVG585jIBpQE=;
 b=fvnN7+1DYoocQY+ZDQxTfaZYHDzqW1xlnT4F0i98P+mhzpvQa8Lz8FFZxkAdpAt0QMjZJb4JP8/nCoZnQ6128AcOmT0OLGKKROqDIbvH2apjl4jjfDjF6heVFL6ZPjyZLvPc6Ucvsh6zGVOx7CMjXuERWG8VQ/OQ0tqEHhB/pJA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV3PR10MB8009.namprd10.prod.outlook.com (2603:10b6:408:285::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 11:45:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 11:45:56 +0000
Message-ID: <b2a617ac-5014-4a35-a231-6c150b34d2b6@oracle.com>
Date: Fri, 11 Oct 2024 19:45:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/25] Unused parameter cleanups
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1728484021.git.dsterba@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1728484021.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV3PR10MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: be95360c-9045-42bf-da0d-08dce9ea4446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFVCVFNHcEtMdmwyS3U2dDd2WVB2cHhFSmRsOC93Q2Fnbjl5NjVHdzlvUFdC?=
 =?utf-8?B?ZHAxcVVCdmFyMld6T25Ya3FHbUo3bGRlVHBMaEZvVUdkY1Y0eWh2eTNmRXRJ?=
 =?utf-8?B?R2xIWFEyNmRMTVhsQ3ZyUW9NdDFCMkFRY1hXVnhGaXJ2c3h4WXpyNTdRajFh?=
 =?utf-8?B?RHhKN29oeitOUnR1b1M4azNxN0YzWVFCeDJJVzFmQ2NZWm02RTFmc2FreGVw?=
 =?utf-8?B?OTdGaDdXNDR0bFdZVVlxdUpFcG9jMTN5aWxTYS9GeUFOYkV3eHVyOUlGUUZa?=
 =?utf-8?B?SnYzTTIzb3JpaFZnN0c5dWZwNDNHQStZbEJybjMwQTVrRlJCK0tBaDhVeFNF?=
 =?utf-8?B?RzJVUGgzU3BOYnlnWGdzUERBRUx3R1MyeFZQbCtFMnA5ejViZ2N2L3dRWk1y?=
 =?utf-8?B?MVlabWQxa2NwZW1NOGZRaEtMTXpXM2FocXExZHpLM1ViM3dyVDdrYitwcmJx?=
 =?utf-8?B?d1E2ekpBS0ZOWHU2VGVIYjdqc01qUnVqTDFianpGOWFOZHY2eWlzcHo0S0hw?=
 =?utf-8?B?TmY3ZDRKMFZWM3RFeGJFQkpFamhxYll2eEtKeVZYUjF1Sy80dmtNWWM2Ymxm?=
 =?utf-8?B?NGMyNmRobDBHWUNwQUdFSThZOXRIbFdjdXVoV1RvRU9vTVRYc3JjejF0L2tR?=
 =?utf-8?B?RTZ0ZXBCNE9vTHB4R1FSN0NCQ0VYTTVDb1dJSXJKQldWNVJtMzFqaEZUUGt0?=
 =?utf-8?B?SzFjM1ZmYW50c3lGNmQwZDEyVWVtUCsyVVZsTm8yL2NZRlR5KzVSRjhxdkha?=
 =?utf-8?B?VGJoR0RqVGxaMGdWbXIyWDRMbmtGblFmM1lyMVlIcHAraktIeCtoWGE0L2Jh?=
 =?utf-8?B?VnhMU3I3QkU5VVN6V1F5eERlYzh1V3dqS0I4RmVUcmFEaFF0QWZKc1ViV3FT?=
 =?utf-8?B?SmFjVk5XaTdTL3VrNEZzRm5SRExFcTR1aW03bjhubEovWllmb3B0cC9hSnVX?=
 =?utf-8?B?dVcxaUdtODh0UUhmWk5UczhaMVRma0ZWU0hIeHAyUEcyeXFpdnU3RUVRQzUv?=
 =?utf-8?B?bWdwM2xQN2FPT0R4Tnh5OWdPeHRnNUJBcHY5LytNTUZKdVVmR3FyQkxPa0hj?=
 =?utf-8?B?cWpKeUNaWFczWjV0UzhwMlN4TGVoOVVOdGU2Rm9VWmhzZlhpYW5Xd2JqZVZ4?=
 =?utf-8?B?QUwwY0JVeElxY1hMLzVSYW5uTjNWSFQ5YkdsZEEzK1l3YklvNmc5RlJZVHl3?=
 =?utf-8?B?OHZxd3UvWHpNdmoyUnlYb2pVZVNWdDFCMVpyYTJIUk5ZSWQzbVhOV3lVeVpi?=
 =?utf-8?B?OFBGa2lZd0kwcnBaSEVnVE1qUis1Tk5qbUdRK29GM3RpS1FWWEdKakpFRFov?=
 =?utf-8?B?cUplUlFCZm9jYmVPR0VvS3doOThqSUxMa1QxekRWN2ZRUWhFZWEzQ2dsSVBT?=
 =?utf-8?B?TmZWV3hCdkhrWW4wbysyUERWeHZnVmhuZ0s3S0Z4UWYxcWpheDk2WStHbEhr?=
 =?utf-8?B?Uk5NVnNNNXNXNzJHRHBHY1BjUG5neDJYU0JWbEVuQ2xja3hiRzVLcGV3SklJ?=
 =?utf-8?B?aFpnSEFCTmdiZTFyVlpHOGZFUmlRcjVCREZ1QURnbnBXOXpWUFo1TGZPSmxa?=
 =?utf-8?B?dlNZVmRCMHVSRGVrNUJOZ2YvbGhJaXNQeUtCdGFpWmdhT2x2aVl5S09PUkk3?=
 =?utf-8?B?TTdNZVh4NWFBdGxZd284cFUraWFhdmw4RnUzbjJhWlpYeTdLYU1VTHI4aG9R?=
 =?utf-8?B?UkkzRU1XaGpXNGJoeGZkZk9FdnZLU2crMVM2cWRaT0k3bFYyNE9qL2xRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmk2T2tNSnVObU91OXBweDRnSHo3RG1LLzN5QzNiVWpYOXpQelJpamFXQ3N6?=
 =?utf-8?B?UFl0RC96MmJSQ1BiRXZucStEam9mb0Vjb1EvSFpBVTUzSXYrRUhFd0w1QUxz?=
 =?utf-8?B?NGRmUmE1aDg0eHNvbTdXNkpHWmdmOUxLUkt1Qmx4N05ENmVWb05BK3VsUjR2?=
 =?utf-8?B?L1ZTd3JGek1WVEtDQWdsdk00VDJVUTZ0SGcxMlVKSnpBZHUvTmJRMFRlNG1i?=
 =?utf-8?B?RXJvVW15bkpKQTZrVDl1clNDT3Z5Q3hXSjdFR2pna29udHg4Q0xVNWNTdEZj?=
 =?utf-8?B?RncycllVU0RaQjRsOThITDJXWmducDZtYVY5bWR0R3JNWWNPcW5OMHhCNGo0?=
 =?utf-8?B?cnRRMmptTkN1QmxtZWlSUzlzRVJIMUlBT3VJZHlPU1pUT29vMHhvcm52QnVH?=
 =?utf-8?B?ZTZ3ZS9XNzJrQTJHTGs1Q3dpSkhTNTNVT1BsUkJOOGVMbEVrMjRUYnZuQWdO?=
 =?utf-8?B?dlIvVlFtVE5DUU9HdGhubE5CdVcyTUZ3bGlJVVlmdUxwcE55L3AxemZzMFlp?=
 =?utf-8?B?SFdGVmdYTmp4WTdjUCtrUFhvcmdkZ240YzVWejE5YzBTbUZhMzJkb0owdTI1?=
 =?utf-8?B?cWtmQW12TUgzdXRMOC9ub2V0STFWMzJpVHhiSmgxMkZsQ1orcEx3NURmd0ZC?=
 =?utf-8?B?SitQTTJScldKOHZLb3VnS3pqdEZLUkRTK0hsek9RVm94R2pJak0zVjZOcEdN?=
 =?utf-8?B?Q3g0ZUJHRitTbWtCcjlMVExyME9ncG9aTFh1dC9LaVZCbUljaGhNaEVMOUhs?=
 =?utf-8?B?eTlwYVNKVE5YdWs4TUgxTitaRk51ZVFUTlR1YklPd3VsTVczN1Zta2UrQ3pC?=
 =?utf-8?B?VG1ZeHl5SG5nb29WUmdrNzVxR1Q1K3R2Y2hzdHp5b2VQYUJuMmFKa3FGbnM5?=
 =?utf-8?B?NzVRRzF1T05va3pXcCtRUlRqOFBWQmpuNHZIWlhvdC9EVEs3Znd5WDVScjJj?=
 =?utf-8?B?U2wzOXJsbTRTTEMzc1hGdnN5NGRldSthWTV3NDNkMFVYOTFsSkIvWFNEMk5S?=
 =?utf-8?B?ejdrOGZ4UUFhTjRYVDBtdmVhRElaZ3N0RmlwSDhoTmgyQkI1eEVXcDFkOENJ?=
 =?utf-8?B?U3BBOTBLeTVqSlZ3dko5bkhLeExJcHVkdU5pSW1zN1ZVYnF1VUJkZ3ZSVEVw?=
 =?utf-8?B?V3JYUVVJb0pUR3FpTC9WcjBneGtXN0oxbTlHTlo0SGNKQU8vdEdia01IYlRG?=
 =?utf-8?B?aGNBOFpSQWNmTlZkNCtEOVNSSnZ2OC9jczAzdmZEM2s4Qm5rdnc4UWVZaDFn?=
 =?utf-8?B?MTFnUzR6WUQ1RVlmd1EwZG5keGhUSi96dm8wWThzZyt6VWRyUU1IbFVDb2RB?=
 =?utf-8?B?L3prcGtsbDZ0eDkzVENHaFZuUjVCWVFPU1J6VFFyeUJHTnpRUlhGMEU4R1dN?=
 =?utf-8?B?VVY0UVNFUDA0cVladzBPdHRxOEZqYXFDR1dHU2VrdUx4Ynd5RDYxYWFvRWdS?=
 =?utf-8?B?ekRjODdXNTBqdlFSK0ZHUUhnRVlsbDRneXNGNmRObjBQQ3JpYU5BUjhFRml4?=
 =?utf-8?B?eE9NaG0ySDQyZ0luQVUrcmY3aG5ER2JsVEJzUGd4SkxVOElIczJRb3pZQlhS?=
 =?utf-8?B?ZnRMK09SbFUwWUNHZE1JQWVPZzBTNHBiM0Z2T1R0eWdpQTgvU1pKTWdsVlpw?=
 =?utf-8?B?MVRRUUJFcFl1ZDdveHNUSDkxUzludmVrWE45Q2N6bDBjejMzeE5KZUJiWlQx?=
 =?utf-8?B?RmpMUmwzOTJSbVdKUSt2Ym9VRlUzRlhnNmlMcVR3eEFudUUyVjFwMVdGUmph?=
 =?utf-8?B?aFFvTnVNSUoxWTBOcDhSRGdLRkJXVngzSy9wOTcrVVhOazhuN0g4bVo3U25a?=
 =?utf-8?B?TXpwTGV0VnNVQVhPVUpTdzliWFBaVTBCV0YrZCtaa3pBY2FLOWpqUmgwQTJ2?=
 =?utf-8?B?YmF5OXQ1K1hIMmJFVVB5d3BXMXJ2WDlvV00rSnB4NWxQdEhZVEtTSTZqNU5n?=
 =?utf-8?B?dkxudkovK1pSQkFOLzNvWmFjNUV1YzZHUXJSQ1NpWHZOUmhGdDYzTVdHVytU?=
 =?utf-8?B?Z3BPYWtTNVVvZSs0djhqeFVpTFFlTkxaVmdGbGR6YTdTMnVjS3VYdFRFeDkv?=
 =?utf-8?B?S3R5aFM3dyttWEJjVDgxL04veTVLeWxCeDc1aTNYK1kyekxMeU9OSWxzeE00?=
 =?utf-8?B?dkpWcUdTY05nTTljOFBYRGxOMjc2MndaTGFvTGZvVHdRSGszdVZwTWhSRFNS?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mO/D3Clmg70PnPySZvgdQ07fbXHt4GLXNCEiFsezXlF8+AL8vB4odu08yAy2SVFgiE1jyJFO2bJPOsMp5KEsghuo7v7UykmFb5kGa/rq7Lh4l4ZDmJoMGIa3YG80rclpY0NUUUsjEMYmOycltBkAJANFW8L8SW3/2nCNM9Fwr+uKwdYHrEgH6WfKvG1DCto0CTxW01fPsaEHfio3XIhKM/rVMoLvO1DXeP6rhTEJbh5krPHUxK1vUcQD3JhPfH8b4fKR4ksk0A1XjwKbBigDQdeXC6PA8R4OO2KUoeCBWsoNPAGSojGWtVn/TgPUDWWetW59dKFbGn6m7F4+q6rZmZrXK6hdcERPVhUSTvYK4uwVnR2Qt140w4yAzCZvGVsSyM44IQOIadSn9+re8kIJNJv7j4adAPSFWRbIzSkMOTgJ8AYKgbphljjfov1/PQ/o84TT/a/f8669QSSFRsyHFx+OAli2sY4qo35DGuU5n8UXnjPSwRcEv7IFvxBA2okSkS6ZqkGM5T0CQTDSHpxoiuSnJn51ovhZbji5aDm3wdNTKNSVVOhEtxg2YIRaf+btat3+vshBAYmq0Z+KwzgGh/+brxJwUjM61zG6dRk4ca8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be95360c-9045-42bf-da0d-08dce9ea4446
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 11:45:56.0559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fUwdM/ZJX0T8ymFe2D1tXz/ok8IVbcijePSr02iG0NmXACulkulPyfJGKcF00zANzvHtI548T5IqJTbDjHxQkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8009
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_09,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110080
X-Proofpoint-GUID: YV83bFPuCV4HGn6zGwnCXjE1Fpw12tu5
X-Proofpoint-ORIG-GUID: YV83bFPuCV4HGn6zGwnCXjE1Fpw12tu5

On 9/10/24 8:00 pm, David Sterba wrote:
> Assorted unused parameter removal, I tried to go to history where it was
> last used and seemed important. Most of them look like leftovers after
> other changes.
> 

I'm curious, how did you come across them?
Using `CFLAGS="-Wunused-parameter"` or `-C=1` doesn't seem to report them.

LGTM for the entire series.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx.



