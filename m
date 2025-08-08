Return-Path: <linux-btrfs+bounces-15919-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C81B1E1DB
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 07:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6DAA18C2093
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 05:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E63205E3B;
	Fri,  8 Aug 2025 05:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TXZjCvq4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FzwQjrFc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ACF1361
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754632450; cv=fail; b=sDUUS3mY7Jcp+SzsNLtEiTFcUJguZ1cOzj1YFT/vXTON4wUwprsHEXdAOE/BiLl2TesgpijC2g0uD3WG+AHcZkGKjsco/KG7AS5QpS9QU7JpWQ/DEbtJUX4cLTUWvGQnmYnxQCKCZ4qazUL92iFsBcAByM2vsDtgiC59b4umaAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754632450; c=relaxed/simple;
	bh=ApArCwwhGmFneBXEL4BVUkX5tMjlAQAzhUkKdmd+bSE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uB6fynY3gvmqoE0Hmj7xx1bHq08cJYrC+9R9I6MIFGnSN2xdbiLYV2Kt4zONzKBEiImPjrQYLl0g41rHRZwJ/em5k23/X+LLMAvABya5zRQwsQOTblQKWdvGAUVtilyarYvKUq3iI9xqNDv4H+VxupUpaDu7VHUtM6fUK9ZJOtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TXZjCvq4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FzwQjrFc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5783uF7R020836;
	Fri, 8 Aug 2025 05:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=E3L0Fpofy2FZW8CXHUAEVplqesAa4fKgYfkxjstwGs8=; b=
	TXZjCvq4pQ+Bn5wRRjynipiRgkpGXjYT6G60SMAAz7OqtMGqEUw2iuXx/uruA3Uf
	+K/kN+6f9ZQy4Wf1Hxsej0u+qBWVgzC6iYDIfO9MkSmrZeaxBGGhY3nt0P4c69+z
	jCp7fC5cwEze8HP3fyd/ftiJqYtDuSzGyEbAWNjEt61TYixLhKIVlOETzQ19KKpf
	A/iJ32GcZL1APEzZZbdVmyMqiax37/Fw0EcnQc8LbPGlG4sjkGlX6t0n+n23uIsU
	qYWrRW51I/ybndISuT1vqeWseGIRphlcgqcKwxg0uQArd4nNjFyRYxvFDdd0Wu7T
	ZddlVTQD/FO+Aq0iClFtgQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvgwh4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 05:54:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57837TlS009743;
	Fri, 8 Aug 2025 05:54:04 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwpb3m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 05:54:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StKeWR4ZjFKgV6MsSa4xzWGRwrBf/f/pb4V/99Sa0xX1IgW0z1zOBkU6RQatmatlJvtVdoOpqNSoYyyoj8sNNGWfBd8xZ3442N/1NMVzI1s5qoLij2B96H4+h3RAc+HCHf0IDAgOK+sprEZGRQyOg1h7AgCtJlY8CjGMDfvn6pW8Q+/FUTS9zFB5aMHLS3xR/V6lhGVa2yeBAEeAlVNnFGXzU+qOnwIDAv9+6+jZdLpWlEGFlGuBN4wCQhK/7LMA/gATwLETM3kHSRsMPcKFGRYIHIW8tXEv2c4ExUoAYUcLw0lRe98NztaXvFveWuQOfFbSSmK4rN5TgrRNskGo4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3L0Fpofy2FZW8CXHUAEVplqesAa4fKgYfkxjstwGs8=;
 b=Aw/dzvL5qBFcvk8/cxzsjbxuJI963KQD4hB16mhzWFY7EGJRfZRSYMGM/ORFC7m1CejW2Dbc73Q9uEGS2l05UMo1bWObGqPfyPzVIlfB7t1n1iXDmvLwJS7VWtTGB9K1+kUFav5TYN/vcsBtmtbzVU25OW+PgSVkjqzSl51uwD5CfjqKzSxAZeOgILkb7W8qb2u9c0okLwP4NevLQfuSKMKZQj3V+ULTY2/CVupWbtLWCff9wY/1zWdwOUHIJ5vlaFuoPTZ5Z3KCUiJvKr3gYKLbWnk4nrVLkUpKui5Pt6G0fw7O7A8vaNTqGd59RVYne+RJcb0v+YiyL7awzxiUxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3L0Fpofy2FZW8CXHUAEVplqesAa4fKgYfkxjstwGs8=;
 b=FzwQjrFcpmNGyfCNaTbtDzdnMXpyIkgeqNy53t2eyM8DarAoakp3uKfIrmc9qaWNdhnTTsTQ9k3VBxJrLWj1XY8oaZP5CcY1cWkJJFmKo8MzXwnC8Ysn0YuH7U59UH5iGGVqVSw2WearaHgykCuKxVeZhEKTNHk9Nq5d9fy2qBQ=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 LV3PR10MB8057.namprd10.prod.outlook.com (2603:10b6:408:291::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Fri, 8 Aug 2025 05:54:02 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 05:54:02 +0000
Message-ID: <59a8ca0c-b299-4736-afd7-932961a11d95@oracle.com>
Date: Fri, 8 Aug 2025 11:23:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] btrfs-progs: remove the unnecessary
 device_get_partition_size() call
Content-Language: en-GB
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1754455239.git.wqu@suse.com>
 <a9638cec2d84c7142a5f3f884c29b8aba1be8552.1754455239.git.wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <a9638cec2d84c7142a5f3f884c29b8aba1be8552.1754455239.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::15) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|LV3PR10MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f4e2935-5f01-45f5-86cd-08ddd63ff9ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjRqMm9CejZST3orcjcrcWlmaDhWMGNTUGVvbXpHSDlTL3d1d3F6VXdnY0dZ?=
 =?utf-8?B?bnplQ0grOWxLcWdhYWFLWmdSc2IzMVpRNWdDRDByZ1djc2Z4MjJzWTNsaitJ?=
 =?utf-8?B?RWswQmErNjdGYUYwcmhJYjJBOEViTWdVVE5vUHJRWkNqWXBqakk1MExrbjR2?=
 =?utf-8?B?cU0vUVJyWU9hY0N3Wm9hTWRqeXpCTXQ4N3l2L2JEenBraDJPMHUzTUtIRmpu?=
 =?utf-8?B?b0YzSW9jUkh4dldUVWRWWi95NlFSc0dtZ25KL1FpVHh4elJGN2VvSkdlNm5J?=
 =?utf-8?B?OUVhWU5ScmZJY09acktLZmlFRGNienkxUHpYWUZ3NVJOTkJ3TDF1YkdmME5F?=
 =?utf-8?B?V1RnS0JwRU9iYW4vbDFEMWJHUVVvcmZXbzJuUTVVV1BibmFBcG5vTld6TURK?=
 =?utf-8?B?dllUSHpoa1Via003c0VOTEZ6WnZwYkJieENlK1UvZ3p4bDBZWEF0cEFzNE9Q?=
 =?utf-8?B?Sit4eHJ4MFhvM2wzNkJyWEN6aUV4QmR0bmdJRm9lS1VjVkdxWWpKTzBSVjky?=
 =?utf-8?B?QnFKMUFpR28xWDFTSXdyOVFBbTlYK1JwamJVZThDeTA1VTFITitGcVNXc1Zw?=
 =?utf-8?B?MW4waUljbW50bVl5M0VKRG4xTy9UY1MvaXZacjBEL2FzMXFOOXN3OFFuT0Z4?=
 =?utf-8?B?eFVOK2xYZm1DNXVqa2NJbkNGMi9rSzFTSEZ3SlIxZXV0UC8vS3VlYzY5WmVD?=
 =?utf-8?B?MXNxODlBZGk0NDVqVXhwK215YU92Qzd0TStoY1JBMDk1d1hnM2dWaHVrdDds?=
 =?utf-8?B?RTkyNXZMSHcvRUxWY3pqMVU2VWIzRUV3S3BMOEQrR3lsUENod0IrbU9waDhJ?=
 =?utf-8?B?dE9pUS9hTTVnK2JGMnZSNUIzRmhqWE9uczN6WmxmM0xOZVV5K0x6cmxMTjNQ?=
 =?utf-8?B?ZERtaFh4UEt6eElpY3NMVzUvU2pMdFJmeGI5Sks1MXl4WXEyN3c1bzk1ZGRj?=
 =?utf-8?B?QW54OG8xOE4xOER6UEFockd5SHBvK0puVmZXUlhGUisvelR4UWEyQ2pvVUQz?=
 =?utf-8?B?RHZZTkVjcElRRGE5dWxCQWFFSDEweE4yOGlrcWpmY3V3cFp4RGlwYm1IcTUv?=
 =?utf-8?B?NHp4ZFpVV2c5OFEzZGZmQ2V6RFRSaytNUHRtTkl2SHZ4ZFRvMnR0YW4zRmtp?=
 =?utf-8?B?UzU4bGE0NlFZVi9NU01CY0dnZ3NHaFFqYk91SS96a1dsWUFSa2V5a1FGR3dH?=
 =?utf-8?B?UUR3U00zaHRkcnpucFNJbTBLZDFtQmJLQU5PbEkrWGVBQjQvMUdVenI2SzBX?=
 =?utf-8?B?Z2RSYzNOTlMwR25HTGFCMkpPcFNUbnZaNkE4SE03WGlPZXRGWkV4bnRlbDRk?=
 =?utf-8?B?NWpQVy9qQ2I3UitxSVp3S0ljRDB1WjFtd3dLNFJVaC9nc1pHM21Sd2o5THI4?=
 =?utf-8?B?QTgxOUxWZ1l6dUcxdTBXYlZQS2NteEJJdUlwMThTZ0ZPQnQ4UGo2bzV2Y213?=
 =?utf-8?B?SmhldHN4UVpxaEhYWmttRm1BWmRscGJaTWJIbDNwT0gxVTE1QTl3am1ERlhZ?=
 =?utf-8?B?MUJvMUFOU3hXKysxaFoyWXVZdXQ4eGRidUVVNXhxd2hhc2hsaHFPakd6VDZi?=
 =?utf-8?B?cDlEYlI1V1NPbTE5RC9qQjRjcWVTZmtQNlZjc0duaG83RkxoRjhsRFdPSVNP?=
 =?utf-8?B?VkxEeGVuWit5Z25qUXAxTldXVlV1RDM4d2R6eU5BQmZDN01mcE1qWmpNK2p4?=
 =?utf-8?B?Q25nNzYzYmg3WnB5QkFtUGJMZzBhODljZ0tlbzlHNVVPWHFXZXJ3YncyVVd6?=
 =?utf-8?B?QW9GQnVuQzFwSEw4dmZicW9tbHVmOWxVS1RDaUZJclZIa0ZoeStqUThod2ln?=
 =?utf-8?B?U2wvYmJxSzl5T2hKa0xPRENHa2E1d1IyNHROeHV2ZlgzdXptbk1UYk5ScnZs?=
 =?utf-8?B?N2pyNWltTjkyVklua1BqeU1yNmpoMUdHcjBrVUE3L2dSd0ZxS29PYmhkRXB5?=
 =?utf-8?Q?wOlaNFmVkuw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WE5lYUpaQ2dqZnhWbGI3ZHRwSmhVZVRqZFZUdVAzVnlTMGl2MFJzSU92Tnl4?=
 =?utf-8?B?RVJ5QmNHUFU2NDFUa1FrcXZZQjdJc0dxcjV4RWFicTR3YkxoSFdHZXErUC9G?=
 =?utf-8?B?VFhSVHIyUzBCZHdVVzg4bDB1OTdMNWwyY2NwRndNMFpDQ1pKNCtBY3UwM0tS?=
 =?utf-8?B?RkFvQ2F6ellhNWtINnkrcGdsRVV0RzhIeS91Y3gyeEJja2twYzNVQnFONkxM?=
 =?utf-8?B?S1JEbEpKQlo4U0ZqSDBuYVVheDUvVTBNV3RqalIvTFphWnAwMXFhVlpRV01i?=
 =?utf-8?B?eW12bjFvbTYxT0kvNlBMWUFkU1RqejdIV1JLRHh5dTN6WWdoVmJxMUc3RlZD?=
 =?utf-8?B?bU1DWlRmV0h2VElRNlJDNDFCSUs1TElkeWxrdTZZN045eXhXcFplTG5aVlp2?=
 =?utf-8?B?aHp6WG9mbWtVdGJlYXBUMnlHT0p2ZUVUVStJTmZhRWcxR21IOW1SaCtRa1hi?=
 =?utf-8?B?M1VTWENtcnJna3psc1BGMHN5Y3hWeWREOFZwWVpEdk1MLzAxaitzajBqenRi?=
 =?utf-8?B?QVJTR3d6VVZWTWRaWU9OdTZOaGtqQUlYQ3BDUUsrVk4vUlhxMDdZc0NveTE0?=
 =?utf-8?B?eko1SStPOWZQQTRXdjRrQ0UzNUEyTmhZRWJaRmRLdjRqbWsvUkgzcGhoRzBa?=
 =?utf-8?B?TysrZS9jd3lzN3Q0VlVldVhNU0Q2NUtJRDliQTlORFZJb3VkNkx6TUM2ejVy?=
 =?utf-8?B?REJ1ODRrN1h1Y1d0SFpuNG4wMGNaV2w5R3c1TUZyRzRWWjlXUW9mSUtNbExJ?=
 =?utf-8?B?eU5udHZsRFNjYnZnaWlXU3RXaVZic29LSDh0TGJNWWNSVEdsYU1DWUNGSm5D?=
 =?utf-8?B?TGsreTVrTnNQWnJSQ3dMUU5CSm9FbkRYTFVuaHYrVlkyNUFXV2pSV1VWS21Z?=
 =?utf-8?B?OFB6dzgwSzZYUjhsYlpKZlFwTHlHNnIvOTVFVER4OTBxd3Z1OG9CU2kxUnNp?=
 =?utf-8?B?c2RZelRRRGhxNEFGRVdMektqbHA0bGJYVFBoZVF6di9adEVjWE9TRWt4dWlG?=
 =?utf-8?B?NnV3VXJBaDFXT3ZLQmcvZmg5cE5QTDdOY1g5dFkwQWw2S2h1NjBpV1pqb1Ew?=
 =?utf-8?B?cU91TFo2Z0ljWTdTdXJ4MnBvYVVCQWlTS3dhSlQyanB6RDdEOHJaRWRHUS9S?=
 =?utf-8?B?NzB5NFRIZCs1UzJRRUtlOUFCbE84RDg2VnFBMFhmc3FJSEs0M3A4MTdVODRk?=
 =?utf-8?B?OUZjV0NuMGJIY1VJTXFiYWtMWkRMYVQ1TllzcXNzNmIxNmw4dFAzZ2xjK0tI?=
 =?utf-8?B?Y1BjNDZTK3luNHhvQkJDM0RqZVRLZTZZUWFIUVhpaVgvbldrSmVVdmVmWi9q?=
 =?utf-8?B?RkdvNy9oQkRwTk5kSFpCWnhPMmtGWFpCMEJUUlEvNzNYOU5JUkcwVk1jemdB?=
 =?utf-8?B?clFHcWJDTFh3Q3JDVVJlZFNiSTNQYkd0d0xaMHBWTWs2RGw4TVlSTWVkcTdz?=
 =?utf-8?B?Q05XYnVZb09tYU43a2NDOXVKRDdGd25XclB2aVB2WVlaLzlBTi9jRitOTm9D?=
 =?utf-8?B?QUpQcTdZdHB3akxTSFlzZzBzU0xmL3luZEpHcHdwYVVGZlVUR01wdEVtR3dw?=
 =?utf-8?B?SzQyQm1iWXB5aDJoMk04WEljc2RYWGJPQ1pHb2Z2M1dRRmIxSzlDSHM4Z29D?=
 =?utf-8?B?bmRTc1hSODhOM3MvcmVad2FEWXN1SURJVTdTbmZtRnoxQ3JacE5WTzNzY1hT?=
 =?utf-8?B?ZEFLUFFrVXRPTWhrb2NhMmx2Q2xUNlluWU4zR05WRDViL0U5Znp4a1VOSU9U?=
 =?utf-8?B?K2RPek1hT1RHOWZCS0dYZitGMkxwR2dPbWNJMXRHanA4OTRzVWFsRlRoYkFW?=
 =?utf-8?B?R0dvVXpnUWFUcVNmQnIwWjV4TmRuNXhsVThJWUNQNnJjOE0wL3BwRUxZTEg4?=
 =?utf-8?B?dGQ2NFY4TkVyVm1mR0dCNGJpbEtid3BMdXhLMFE1dmlaVncvUExEY1dabG8r?=
 =?utf-8?B?d3V5WnVlbWRqbm5tN3VTaEVXZXo5SkYyVjg4aFB3bUtZbUxtN1BxcmlzenV2?=
 =?utf-8?B?eUh5Y0ErYmZiZGt2NXFpZWl0N2czcUNNandVVDFHdkZlTlhMTCtsTGtrMGph?=
 =?utf-8?B?MGZtZGNJRkppV25vaEhvZnNmeE82Y0lrSHYyUXdJMnhKR0JGMnR2dTdnY3NU?=
 =?utf-8?B?NHpKdFkycGlRV1VJaG1DcHZ4NlBqZ2FtaS8yZkRMbjRDa1R0WmhsNVl6WnNP?=
 =?utf-8?Q?qMCfeDfxpk5Zfi1QApnVkUGJT7zZSpWVxl9VazE1q/hA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hgqmJEzqUqp7HbwnPbZPKqhjr45NYx8oWyPE99qVCG5HDCA9FPNCf8As7ZiEl/SNulBtVjSYTVIp8xldM+7X3zGuJeMQ7vi5NCp7ivMemy1d0imi4kzWzLZQ8PUur1fCE65/REvNoaX5ao5/hL+qUIf8WTrq6CFTznFGEM0EmRKlXZU+4EgHBGTX6TXTJJt5O5dEnPXst87XlTvvntyaDXU/06j/C3WSUoJv6ejRYlqI3Cbc2mIaULI55jFXPCMYIhoVSTvCuhXIWnSSgiYePnSHpeDtyTEtt5sVlZzZNfKRkTldhQtcLQAvf8n2gpUcau0/Rm07Dn+GecVT2ZxC7ReekXKT+g1t2YrpfSPmSCNvGZoq4mUJ34MeqM0T+P2jvki3b5Gnp7UxIRsB+QcotmBOM+HL5vDSe4IXdiypp62B7z4YiMcbyTmdQp7KbTkI/MS4d5tpoRygkjMBAjGE8EmBlf5CXiO6VQmXSoWiYAcK+hAeBcvhLZW2uJi5hGhUvZdu5g2pqldxdHUvsDxL5z5lOWBH6ndIT1EHXydmc54W/qS5SkDrdgq5bceseUsv7kZ/fgRJJk2IQeknM+R1v641ZH1CFN0StFelTufy8nE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4e2935-5f01-45f5-86cd-08ddd63ff9ef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 05:54:02.5006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmzIJxBnxN6qtg2epxYUmS9v+JOX8eLKJm4C3oQ/k8BF19fxC03lIo+tqhPeWzgqo6cplW6CBxJcDZh4+zllBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8057
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508080047
X-Authority-Analysis: v=2.4 cv=WMp/XmsR c=1 sm=1 tr=0 ts=689590fd cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8
 a=1HyaXTxbbF_x060UpFYA:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: CeNL-fL3bw3NpmjGTFuNB1EnlFgFDMBF
X-Proofpoint-ORIG-GUID: CeNL-fL3bw3NpmjGTFuNB1EnlFgFDMBF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA0NyBTYWx0ZWRfX1Men4+NYd+hV
 EuSo0jeIuqdQjLgUVmz/rdsMSkuLrAZTPjhzh59JVi0eas9i/XdAoPfxEP1SP3pRi3IHfIEOyTQ
 eiDQRE6pRLzSwYMBXzA3BAukNNOzrmwdYLXsc1Mk5CK87QqkxHDCiGdPVdlMsVSIZZ8ZydJszGJ
 rwUVn5grAOyqXYt4Xpjm9jvLMz8V9owJ88EEXaqTB4xBGSUUb4WFLLSLCxC9WaeE4BsN4lRnMCC
 rRbDly98k+BEV9iqZvYOOMMwHNp6qVIH7x3vhXAiFS4SD7fBnZLjVBoukJR2j8KIbKklUbVZCcE
 rKeBLJEaHr2wqVSmLdSbBVL7gAJwalzzZhHkOLvFNHpL/kWe21hm6mLGdkIG/lroOLMoz13VxLq
 +i+IlKhE2b0p+AmxATNiYLzCY9PZYUl4U6uh+YX8R3DrwVPbG4VZtaPTaulqk2W3acaTc0kh

On 6/8/25 12:48, Qu Wenruo wrote:
> Inside function _cmd_filesystem_usage_tabular(), there is a call of
> device_get_partition_size() to calculate @unused.
> 
> However immediately after that call, @unused is updated using
> devinfo->size, so that the previous call of device_get_partition_size()
> is completely useless.
> 
> Just remove the unnecessary call.
> 
> And since we're here, also remove a dead newline in that loop at
> variable declaration.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   cmds/filesystem-usage.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
> index 473479a1d72d..f812af13482e 100644
> --- a/cmds/filesystem-usage.c
> +++ b/cmds/filesystem-usage.c
> @@ -959,7 +959,6 @@ static void _cmd_filesystem_usage_tabular(unsigned unit_mode,
>   		int k;
>   		const char *p;
>   		const struct device_info *devinfo = devinfos->data[i];
> -
>   		u64  total_allocated = 0, unused;
>   
>   		p = strrchr(devinfo->path, '/');
> @@ -1000,7 +999,6 @@ static void _cmd_filesystem_usage_tabular(unsigned unit_mode,
>   			col++;
>   		}
>   
> -		unused = device_get_partition_size(devinfo->path) - total_allocated;
>   		unused = devinfo->size - total_allocated;
>   
>   		table_printf(matrix, unallocated_col, vhdr_skip + i, ">%s",


Fixes:

commit 7ab0c46a814a719fc88ddffbdc81b29d5c946fa2
     btrfs-progs: fi usage: fix unallocated and print total and slack


Reviewed-by: Anand Jain <anand.jain@oracle.com>




