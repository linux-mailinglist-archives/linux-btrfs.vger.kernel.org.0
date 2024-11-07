Return-Path: <linux-btrfs+bounces-9381-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EEA9BFEF4
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2024 08:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1180281B0F
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2024 07:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FA119ABD4;
	Thu,  7 Nov 2024 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U9DVjI4l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FWyYr/4Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B52B1925A1;
	Thu,  7 Nov 2024 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730963843; cv=fail; b=QODb8Jn6b4maQNQP+9GVwgOzT12dMpZqF2NTgELbekmZwnC4BQRL5eGSTVyETsLToSijjj+q0H9r1humVqgGQ0lBJM0dqAQB3WdWB7lrtCfe2B+3PFC3LB3ZssImusggd+kJ7KbSU8z9d1NaHwdwoIPp2OU9ma2zTrV90pcKZWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730963843; c=relaxed/simple;
	bh=a8vhUbvN97F2nGPOhRywwUXaO2/OHa1ZXamTHqOt4Uw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bjBrpLwqIQLUylGCAqvh3zBRsPcp9WEHOzca+JLe/dInZYTJSpDFnKCFjeF4dZVVVTAP4qTUrBK2zwUVGJCAH0P6csp6U2jjus82EBBqR/cpU9HTuQTU63sQj0Mv1+N5YfsWFvBY92/ts23QPzkm8d+Bg+S8nb4FiHbs5M49EsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U9DVjI4l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FWyYr/4Q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A71fg6T025085;
	Thu, 7 Nov 2024 07:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1UsmZ1xCAG5/8dfsghW4++R4IMn1QR5OFESenCtqgtw=; b=
	U9DVjI4laOD9xrzlopMK0lu2qvf/AzkgFvZZB7i+JeYghrh0i6RLS//tG2fZ5p4C
	12qZG0Khp5cz1PEW6HF3h+OurVxVD9OjO1ATmt9A5uVgYHmefXHOPbL8rhDsDbXU
	BrRH3gegRaLv5WNLYafu6kH90jPDkOsABwbCygR+XAV9TyIgNGTNiu3X+upmavWz
	fITS3tudnB4OI8M7mLO8wur/T5OZvebp99BUNQfth7aaI3e5hDA73K+V5NNxGKXW
	fIZwMOdR6BuKCWtNZNHopQp8gZ/Ko+BpuIb0D+A5RLsS/NdsVakdVyII5XRk9EF1
	YdcmPHr06fEcnj7zpG80qg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nap01uam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 07:17:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A75fh2I008674;
	Thu, 7 Nov 2024 07:17:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah9keyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 07:17:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bY3sdzIumvvzlxZ/J2cxliqRfJoR98ctUC3IPkk7JuV8oTTeZMrHfwnC21XKauI5Tx1R611fgWHsel7pzrjqYUZFgnKO5+iNvrIFXw2w9i7PmE1D6XY9TYSye1gaGl7LGyr1gXo3t4GdZNHSgz5kM5G72eq+7KupiH5h5S+FYgL1psfLHJoJJU/X51cfuOgig0PZvIFOQa4MkTZpdflp/9Koh93OXy0HbM+VgcXIqWkrfDaypNgLLprKaIbJFW4IK5dono4zVaHnwheaLB7+7SX0An2vXlci3pdq6+fVxVKOO4nW/HhfssRu+ZLyyIuAHjej/itSnC5vKefGrisU+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UsmZ1xCAG5/8dfsghW4++R4IMn1QR5OFESenCtqgtw=;
 b=Crw1NYgp/WaMXf00KA5xQQCgj29+mj8n4yf7Gx3SE8Bz1Y5dFJAYYVzedgbRWFEwo44tdVjCL8FUUK4Cl/Zv7TkQtq4R8jkiYmeWIqklggNXEjE6Bp1jcYAyoJ+Hh+lk/RhikOD7dyJG1NUJDYxksF9K+PQAHeuqxzcLjlz6vt9TCXGa0GLsi8j4EOzECvHlzBfJXqgPw5NLTW/R7yiDnX0xY5eZKRqdMS7P7JLg2/zmKnprkl+cUT2t0H4BgomZE82xZIkFFYY2ge392IXW1d4dFU5sklHnXEejhkPg8NPdrKma8poNbFRm7rV9BcXSzTX2FnzGjeURiW8kDPtNTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UsmZ1xCAG5/8dfsghW4++R4IMn1QR5OFESenCtqgtw=;
 b=FWyYr/4QoKsMXPWIVHfCth2rBDn/wmZuVClX605czxoau630FfW6umBLfprVFy8OZr8sTPW7QDRNlJCZnvvq1vgnjbfPAh6d60IN88dENaKSo08SjQX6SfZk7gxhjpycr7pQ8WgLXsU1Dn8VldnYVJsdDhxwWM5Z44aQFNpepy8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6655.namprd10.prod.outlook.com (2603:10b6:303:22c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 07:17:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 07:17:09 +0000
Message-ID: <1b96c1a2-c0f6-4c05-89a3-709c547d3e0f@oracle.com>
Date: Thu, 7 Nov 2024 15:17:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] btrfs: a new test case to verify mount behavior with
 background remounting
To: Zorro Lang <zlang@redhat.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
References: <20241106054328.19842-1-wqu@suse.com>
 <20241106093503.3gaon45f44b3r6sv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20241106093503.3gaon45f44b3r6sv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 535a2620-5cdd-4f2f-2262-08dcfefc3160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEhzazNOaHVxdEZkeGF1eXdmOGRyRlQyczVlOE9oNEtpdEphVFMxd2Rsb0dJ?=
 =?utf-8?B?ZllCWXhzeGNWaENiTWo0dXNYVGVDZVZjb3J1MnNyYTRXSnJVVStSTGR4OWNW?=
 =?utf-8?B?S0dJbkFoMEhmZkovT2orWmNvdDhGSTJlTzA2YnVYWkNGL25YYjRnamRqM3g3?=
 =?utf-8?B?R045WVNsUjZuWXZvcUxWUVNZUzlzOSt5bHpyNmZ5S3NpS2p6bmtuWnBtYXpY?=
 =?utf-8?B?WFE2c1BvWk1ZazhBdzFvZ3BhMGRpZ0cwT21sRlFiRjB2WU1EMzBseXRBY2tN?=
 =?utf-8?B?L3JtYndkWDZqelpVczAyWTMyaTh5bU4rOG8vVTJ0ajg0b01ONzczaTVCYXc3?=
 =?utf-8?B?N0wvMjUxbml2N0p0cW5tQXhMSDFNWFhRc0hWZ0k3STZBMUl5OFhwcG5qRXlu?=
 =?utf-8?B?bGR3cDRIN1VuMEJTY0JYcGtXQnhzeFZ5cUxPQ2E1dVE4MUxidEJFVlpOdWVS?=
 =?utf-8?B?V2Z3WE9iYmQrOHRPY1FRQ1ZPaXRaRUtXbXlBa0RybTZRcGNxRDBzL0JCamtm?=
 =?utf-8?B?UzdrM3J5YWpZbFpMdzFqalFxbm9PZnhKaktHQWVkTXBMUWpzOHpUM1JnbWd6?=
 =?utf-8?B?KzZxN2x4Z1JEVTR5ZDVWM1I0RVBST1gvcFZ5cTl2RURlbHZxUUV0TXBVa1VZ?=
 =?utf-8?B?OG5zSHVwYThrT0JVbmxxMWtNaVhDcHpqTWNJdytRZ3g1eFM4R1NNVjg4Tmpz?=
 =?utf-8?B?MWN5SGhkRzhjYTJZYXZ0bjFudm14N1VVZkZHRFhLUlk1VWVBYlpKSDIyUGp5?=
 =?utf-8?B?Z1JtU3BtWjlYNjBnVUVjdUw2NzRiM3JkRmlVUzZ3aG1JWmRVb2JNVnREL3pq?=
 =?utf-8?B?ZGtUSmJkcjJqNlBMQ2owbWxvZXdtMzhvNUtBT3BEWkJzVEs3dnhlMFFYR0Jw?=
 =?utf-8?B?aDN4Y01CVjNod2l6YnQ4V3Q4ZVVLc0dqSStKY0NnT2pnN25GTGMwSmdaQ2V6?=
 =?utf-8?B?VlplQmlBSzdBQjc4b2FmNHNVVGNhS0Q5NkhuQS9Ja3JpUWkvZkNTZWJkMjNK?=
 =?utf-8?B?bUpLNHc2NzkzL21rck5waGtxUUt2bzFLanBZajVma245L1YxR2VMQVFkN0p3?=
 =?utf-8?B?b1pDT1NrS09iWjZIeldvM2lybmNKa3NsV2l0TVlYUitrek1La0dxTkdVbktY?=
 =?utf-8?B?QXRiZ0NncFU4NkFRZWRqTm5MeVdPMVFQelNnU1NMV3gyVHZMcjNHSFlhU1Fh?=
 =?utf-8?B?UUR4NXYxQ2dBOGw3dkNGdnBGbWNnOE5HL0FhU2JpRHNjZ2xtNHIrQk0yTUs2?=
 =?utf-8?B?MG0rcG9XeXFEZ21NNER2V05GdmtZcTl2R00xSHNzT2pCS1p3aXozS0tudGtN?=
 =?utf-8?B?cFNGTTRsUXRNVllrSzZQSU5iOUdXUVFmOUQzTTRhaVgvZlNMVTdmTzZHSXhk?=
 =?utf-8?B?VHUxOHZ2cTlMQmJOZTFuVzl6MWhFeWF6UktKSjBTR0hQdzFhZVhncmQvK1ho?=
 =?utf-8?B?YzdDYzY0ZnFCTVNFSlRvZUNCQXJqRFYzU24rVkVsK3lGYnhkaVh0Y29iby9E?=
 =?utf-8?B?dzN6MUVJbzJCdnRYQWhjQ1hJY1J6N2t6azJwK3VkMzBzU2JHMkduTUJ6dGJM?=
 =?utf-8?B?NGF5dUdHSkpDTHBzOXpQcUlaRyt1U0pPUjE1cWRqNC9ieVhndXRNOWVuYnNs?=
 =?utf-8?B?WnJobjJuNllmNEVUd05hblRGZnpaaHVBNFNHdmQxTk9XeTFRYVNMU2pMc29H?=
 =?utf-8?B?Z2pTZmZydzdlVEY4N3V1eU93U3hPNkVtQjZEZ0pvT3h1SmJQTEFxY1REUGhn?=
 =?utf-8?Q?pqjR2fQkVcv0Ab2iyEL/bxWH6a5IiULQ70FzJ0i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGVQT2I2MUt3SmlrTHF3OE9Hak1ZZXBiMllrRGxJdEVBYk9JTzRiSXpBYjlV?=
 =?utf-8?B?WExUWGdpQVdxNDBsM2V5L1QzTlF5R1JsN0UxeWhoYzB5ZWx5Y0RETWMrbGI4?=
 =?utf-8?B?d0dRdUZ2ajJJLzRUOFlGWWg5N0FRaTFwVzJQaWlIeXplRWxrdW05WndQdWVC?=
 =?utf-8?B?RGhWU3EvOStxa2hOaXl5Q1VYUEJpWCtGbjE5NXdjc09HNjIxR2JJbkpxUysz?=
 =?utf-8?B?L1hnSDFaWHp5c1pZcWNGWmUyUGJaM0h1b1dSSVFFUitjNEMyYU8rNzdDaXcz?=
 =?utf-8?B?MlBpK2F0ZldaNmp4MXk0MVNMS2pJT1MwaW43R3hCV1c4NnpEbEx0TXpFNVFZ?=
 =?utf-8?B?bW44bHZiRExaQWdiSUtKa1R5elVBZnRKWkZlTFZOMXlheWYzcGhyVUphNWVp?=
 =?utf-8?B?U3JrMHZQVldFc3VnanpoY1JrZ1BEKyt6b3hmbENFY3BPbFc0dWVNYVVTYVVR?=
 =?utf-8?B?TE14OGQvZysrS2ZTRHFBejhYU2xwUytTa1h6ZjdsbWR3NGxnVEdHb1VaemRO?=
 =?utf-8?B?YzNmQ1NSVkRoK2pDUkw0WHppR3VFQ3d1ZWpwRUkxY244NDBjSkx3WnhVK3dS?=
 =?utf-8?B?bWNMZFZjY3NNYlZPYUFCcUlzZ0gycTMzbVNJcnpoK1p4bXd4SHRZTFl1dW1Z?=
 =?utf-8?B?OVFIWU81OXdDWS92L253c1k4SzU5SVMrcmRWaTNiZzZjbHJReTlMQVZQVm1z?=
 =?utf-8?B?TWpLQS9uM2pTSkp0em5PK0hFcDBLS3dxY21UdTNWSVdFVkkrVHZQdmxKSEcw?=
 =?utf-8?B?THR0cnRTclpaM3pROTJJUFN1eXNtMjJoQ1RjaG9URnZQaWhWbWlRcHYyQ3BN?=
 =?utf-8?B?S3F6V1VPcWd3b0Z2VzVFeTQwRGFFdXptUHZ3aVdQN0RYb0gyQmcwcFBDSVlT?=
 =?utf-8?B?UnBIY2NxNFBVMVZvNnhhQjRKU0Q5QVJ6aWpmMVBuSWVib2JTdnYxUG5maDdW?=
 =?utf-8?B?RlFNYU45N1pEenYrYVVDdzZLdkthVGdPT1pseGdUaFJuMU9RWGlhUGZ3TVk0?=
 =?utf-8?B?YnA5dThIWFVIb2RlRDFkYjJ0b0pjN3F1RHkvZHBLZ2h6MWliRGRsQ1hxa3pU?=
 =?utf-8?B?U0FpTjUxYS9hOGQwOXYyeG1TTnBJR1RjRUxwL0lCK1prL1FJYmNrTVNVdFpt?=
 =?utf-8?B?SlI0VXJ4cXo1dklrQlJXL0VPbStwNkdiM2k2TWxjRmpsR0RGcVY3UHlKaEFN?=
 =?utf-8?B?akkwVEVQV2FjdnFwSlFTYXUrMCtzSnQ1U1ByamdtR21LcmxwdGNCSzY0VkNL?=
 =?utf-8?B?UTVFaTZFSmRGQld2aDJuMCsyUjBKdXJ5eUJvT1hnRDdTUUl0NWFWTVJCditY?=
 =?utf-8?B?dmlCSGFSUVNjZEpPR0JlZ2s3anBxOWpicmJYMHJJbkY5UHRneit2ODY0dFo5?=
 =?utf-8?B?ZENXT1RldnRydlRSNTRkUkRyYnNweWZRb0s3R0dFSnJmUVcrdTJ5ckhVM055?=
 =?utf-8?B?K1JWeG1XbWphYy91ZWhVZDRQUzVJU1FtTllYeGpkalp0WUxDK2RFUC9WUFpL?=
 =?utf-8?B?TDVxK2NWd2RHRStpU3RKQTNjTkRiWDdkbFRuWDd3MU9BWHBQTFJqdHlNMi9a?=
 =?utf-8?B?WDNMek1JaHZDK2pzQURhbHVuV2hYNnNNVGVyNndRMXNaT01NTWZ3OUNzdTBt?=
 =?utf-8?B?VlFvRUxsNjZHclpKN3Z0VndzTzdTL25nZ0V1NVlianBzdFJZV3dvVmN2b0lO?=
 =?utf-8?B?Y1BIcWpKeVhJSHlyVm5GeXdTM0tXRTBiN3dlR2Rhd2swNXo5czFPSXpDS050?=
 =?utf-8?B?Ry8wYjNEMlYwS1ZFZzJHcEVTRlZKeS8vSzdtYTVySEtpUVEyQ05OcEs2dEQ5?=
 =?utf-8?B?Z1RGTnB0UTJ2NG9ndjVWT3VGendRcjJGZk1BcW1aeEczNGhGSzIyQ1o4eXRm?=
 =?utf-8?B?L1NQUm5VQ05YemUxaXVzWHg0WnJ6cVhtK1dqQ3VXYkwzRTh1Q3IwckZtTzl4?=
 =?utf-8?B?UHVXYzFBRTVBUTI0d3BrS2lIR0dvWmFzL0UrL3lMMU9TUmFHaXpXL1pkSWVB?=
 =?utf-8?B?cHhWY0V3Q1RKVVg3eFMrc1RwR2lJUWkwYkZRTVc2NGl3SjhFZ1cwa3g0U1M5?=
 =?utf-8?B?cERNcWg5SFF4VzhsTFlpL1YxQm5DVXdRRDJlOXdIdE40Z1Ywa3VVMk8vb05I?=
 =?utf-8?Q?YgFEKS36ES3GjeHjLD8ofbTz8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RLBAuaJgnJF63+9wFN7xf3aRGE32+hiF1A1xq3Xs/sMcsozFNz7cSCEVFntqvJr4J58aFPYF2RgXHUlyLGw56mqY8mqVEumoh5QZtB/GCwSJSfuOZqRCXGkBsotMOX16U/SQduo2bt00dQsE5Z/vj+Pf+K9uZv//uOBl3UcqJxkBe3OD6qO6UkK5e5WkWe/AKMT6NeSDKBfHzSklZ7e3tFlwSC50kIxc6DHtRh6Meekw/xrgkj9gy4c91FnrYMNFq5X9R61mMdvlLQCLXjuulOtRf6XIV4MVFp7tryUpxyj7Xh4FbvPfSla+SEy6DoBJJ+oNwAihiNwN+jm3BRud5aSTNpW8UV4fFXPxDqeyzKvwok8JYvtzzUZ9Bi4qWlp9r+BYTFQ70F7VF8Kxzksl7tK7R54zP4SZVutiQdSWNd+V3Lrm0igWD3aTuV5NroQ4o5tOsdQc+pTYsq+Q7PSGjE3uOd5Rgom8tJ3xcZ2PqAN6S8su3AaY6O2mfqRDva98c2guwe1lt8KSj3d6ca507UoXw1meuEI/V2RWupznyuoxtic2TRqF4jSBK+m1OE6+auTWIirSrZpP8iHjb8xcaHFzGwBYUdaYoSwRZQ+9kF4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535a2620-5cdd-4f2f-2262-08dcfefc3160
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 07:17:09.6319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1zrlp2liQ0i9/GlsNkd8X2PkeJE2wuR/Ngy5YxgdhBgUCB8L7xst6Bi1Hn+g6p8n/w31wemcu5L0W6PAfdhWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6655
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_20,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070054
X-Proofpoint-ORIG-GUID: GWpZi_G6YRCF4jaNC66PeV_JnYzRDYKz
X-Proofpoint-GUID: GWpZi_G6YRCF4jaNC66PeV_JnYzRDYKz




>> +# Subv2 may have already been unmounted, so here we ignore all output.
>> +# This may hide some errors like -EBUSY, but the next rm line would
>> +# detect any still mounted subvolume so we're still safe.
>> +$UMOUNT_PROG "$subv2_mount" &> /dev/null
>> +
>> +# If above unmount, especially subv2 is not properly unmounted,
>> +# the rm should fail with some error message
>> +rm -r -- "$subv1_mount" "$subv2_mount"

nit:
Nice, if unmounting $subvol2_mount fails, rm will fail as well.
To capture the unmount error why not redirect its output
to the test case’s full log:
  unmount $subvol2_mount >> $seqres.full.
If you're fine with it, Zorro can consider to change this
during the merge. Nevertheless, the code looks good.

   Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx, Anand

