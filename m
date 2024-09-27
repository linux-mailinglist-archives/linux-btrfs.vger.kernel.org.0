Return-Path: <linux-btrfs+bounces-8307-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 497699889BB
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 19:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E991F224D1
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 17:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434FF1C1AA1;
	Fri, 27 Sep 2024 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Wj5NdRYj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41131714D7
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727459074; cv=fail; b=Sop2nicvu5Ud35IKQKp29CgfkqRkLgaqxRQC08dXrGhoq1kSw5nqfnj0i61/t+lnfxvDZ57NfYRINZzq4nu6WUFOmfmj13wERXjQ4JQnX/Q/vBJDCO4g6yP7fx8JFq3y5H7qYQJJFA0VRM5IqxQa1ITStHiI9cQnYo+hhVo8Odg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727459074; c=relaxed/simple;
	bh=CQXRRuwHpDJIK1TWoWpV2czP/koqi+xGYbz4X6tNmZ0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rs/Nshw4kdCleMt+JVUUvXRxT9PLBiBaBJ3/SAAjN5oYKeyhSS/Yfx/gxS1M11zqJSEKXskn+nWn9uKfztntPGrm9sajn62CoYwSwVIpQyS4dU3ynnX8tZuLujSH10KNweQIhWyC4ckDie6Z3qD++mAIRJVSrvLVMe1qvaDtTxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Wj5NdRYj; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48RHKBuk016285
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 10:44:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:subject:date:message-id:references:in-reply-to:content-type
	:content-id:content-transfer-encoding:mime-version; s=
	s2048-2021-q4; bh=CQXRRuwHpDJIK1TWoWpV2czP/koqi+xGYbz4X6tNmZ0=; b=
	Wj5NdRYjxxWjVb0iaHMuC2pdh55gy8gfQtZ/ARGWxEj0qNgJoGet/Om4GdsqtE03
	YQhFF9iokKCgLENGPJbpcAe62CtZ4plkfQfrFqv7+Cu4IhrKcUf7V8vKd+J/xLyA
	84Yy/t3DkY2lu0JBPQYNh8vcJKWO6zXP2HyDHO8raEF5NWuhhVkPOicrxoYygrsM
	QIKV2gOd1JnNrg+mNKrtVfkl4iCuX0KZPUGknv5WUncu4EoEOmG+9uIj9SO47uIG
	3WpNN6uMkG7sSrcL6s8F0hcaOrg0qkpK5h1y+zUwP112U3/JEVpABFx+HxpE4YJL
	2LiascwPaXek4wo/huWqvw==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41vnt9y8fd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 10:44:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUqCvJPhmOV3DebyBRY44MXMCwrgqSXIZjSyC+gaQPClcJkS1bG7IxcKVeoJHJWzUdvKCSD8hkk7px2ZVasYJ9jDdXxzmabc5Cy4OCT2m7o0vsmy0LqVd4j64V6WjMMPZi66Y/yBECP/4G6Iw1C7wq9bFJdslUHLnA072eysvaeQgW/NjWwgIerK0HJsE5NzmLIAO1krlv/8Uq0n+7Y4mNy9Q6rvPt66Z3Y+GmnUMSFXzSJEd6isIgBp8RlVnfRcI3FxVTTFgSaaWmb1Qz+J1DlS/9yQzdPRW6pwZHfCtg5UJgIPtIDimyuzFt21IxYBeoHDEQNWpMgIseI2/Smn0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQXRRuwHpDJIK1TWoWpV2czP/koqi+xGYbz4X6tNmZ0=;
 b=Vil6lo0YZLpjO5VaM++dcTF4VxPPohWAi43ldMJi5lQePQQhGLoZGAtUGFOszzX458c0MX/QANP88t4ZYNfucp1IDm1ZwTRWlX4qMsRhemHLZBCAhKMH1Hz5fiwGSC0Nw73rzB9tRjBKN6wQduoLukzypAgrsyHru+CINpwzaNNcuxk9iuXjXSeeNXg7RZjniYpxrpxXZkVAna/VORt455Al2y5MPy03fASSZZHe88/T3VgucxhSIRqoDkDGTRfVHElcarxb+NPFBzdgogE/LEN6LX/bg36J4FY4tr1GZ3D/WErxdR4WwxDx3Y5nzvjAXhpJguVpIRO11WTmTgSKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by IA1PR15MB6007.namprd15.prod.outlook.com (2603:10b6:208:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.23; Fri, 27 Sep
 2024 17:44:25 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%4]) with mapi id 15.20.8005.020; Fri, 27 Sep 2024
 17:44:25 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: "waxhead@dirtcellar.net" <waxhead@dirtcellar.net>,
        Btrfs BTRFS
	<linux-btrfs@vger.kernel.org>
Subject: Re: BTRFS list of grievances
Thread-Topic: BTRFS list of grievances
Thread-Index: AQHbEM85B4YmraALkkmhuRUsMOk/TrJr6CiA
Date: Fri, 27 Sep 2024 17:44:25 +0000
Message-ID: <20e5cba7-2112-4023-9994-5fac115abc2a@meta.com>
References: <aebe9671-6f44-9d20-f077-b19e09fa1fcd@dirtcellar.net>
In-Reply-To: <aebe9671-6f44-9d20-f077-b19e09fa1fcd@dirtcellar.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|IA1PR15MB6007:EE_
x-ms-office365-filtering-correlation-id: 613b20f7-57ee-480d-6478-08dcdf1c0714
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZHJPeUlvbklLamlTNlE3N3c4TDJ0ZmtxamxnNTRTRDBTVk5RaHowdEoxaTQz?=
 =?utf-8?B?TkVUdzczcUQ5VFZFd0xWdUc2b0JyYnp5NmIwRlRYZSt3OHBlckVGczBaOGg2?=
 =?utf-8?B?QTUvc3JiVkMvY0tnWjNCVGFKVzI1TEg4RFY4MklKY09PVDlPNmdLcUhPVW1P?=
 =?utf-8?B?Q1VVWmFQZ21CQ2kvNzd4UCtnc1lGZFRKTWJtanJYb0FObHNjMXluRjdMSUla?=
 =?utf-8?B?ZFZ5ZXdIWU8xUXozdXdIYWdLMjZlVVZic1BCOW9jbkdxZUxMaFJYRzRKYnhh?=
 =?utf-8?B?MjY4V013K2hxZUlSWUpUalYyaExoN0Fyd1UxQXVFOWs1d1lDNmYzZmNNalA0?=
 =?utf-8?B?Mllpc0hzenQ0UXRKRzFKNVpSTlBqUlVKRm84aUo1eGJVNnhVMVFGRWJsRjRV?=
 =?utf-8?B?c1JZTHhGVmFnVHU0QXhjUWpVVmE2ZUpJU1BReU81ZWNDKzhrVW9zOUt0Rmxx?=
 =?utf-8?B?ajQ2Q2xwVEsyZlVQT3AvMEpacWFNdlRNWkloV2NTMXUwRDMxajBqSmEwM2dk?=
 =?utf-8?B?ZEdDcXhPNDd2cTRFRHNsWWxxUTVIOGFKaXdtclVaQ2tMWHFDaUxjYkhJWDNQ?=
 =?utf-8?B?TmY3bHIrY1AvTjlVbnRPZ3R0QS9XNFpJMC9pOUNGTWkwUjB5QUFzVFFLTHVx?=
 =?utf-8?B?cy9vN1dja3VsZGxWY1VpNHVFOWFzL1JRc2hadkFYdFlvaVNnMGZSRWNnREZo?=
 =?utf-8?B?S28zNEdSWXZydDc5S09NZFVwS0VvRmk3MEdHdTRrQWd5VVByNy9jUGh0ZUhH?=
 =?utf-8?B?aW5sS3Zvd1V1cndXVjhibVl3R2Q4dXVCZ3lla1I3QnV6UlIxS1pUU0lHaU12?=
 =?utf-8?B?S0JzN1RONDFYemxWeUZOYitzS3hKV2N3S0lJekFWSXpQWm5PRTB5clFISjMx?=
 =?utf-8?B?dUhRdHhZTkVYOGRHd29rb05pdE1nSzkrUDVVNkh2dEgrdHUvQzczSjlBY0Vy?=
 =?utf-8?B?VzhmOTIwLy9BaVBWd3lGU2hoTitvc2MyOS91LzFQVU1GYjVvWWh2TzJyUlJQ?=
 =?utf-8?B?dDcwQVNOcnFlNlRMY1Flb3M0K1EyKzhPZkdxRVo2WDN5cTQxWEVsYVlmM29r?=
 =?utf-8?B?NUloWFZkSGs1UlphUmRGT3gzRERvT3BjQTBiSkFYNnpZVXlqUHhsb2J4TU1O?=
 =?utf-8?B?MFZyNE5UcitzQVRGakk4VUx6WUJveE1aUllNd0J5UURKRU5jeitsNjgrNHB3?=
 =?utf-8?B?cHdENi9kZWVaQjhGdGtTZk5OWHJ2N2h3MDdidTdCZmtURmVnbUJ1S3grWFdr?=
 =?utf-8?B?c0x2aDZLY2pyMXB4T091SjQxaEhYTDVrQlhMZ2dKZDVIR1BpZVRKM0xmdzh3?=
 =?utf-8?B?bCs0WGZBcFc4MXJrU1NveGxTNmpOWTlhK29Gakp2N1ZXVGFPSWgweEt6N0JU?=
 =?utf-8?B?aU9HQTR3K0dPMk1JcnplN2Q0ZHQ3Rk9TMWZrRTNZNUs3bkVDcWZQRzgxZ0RM?=
 =?utf-8?B?WlhHZ1N6OG11amxUT040Nk1WM25LN01sWnFablFON0xvQXNUSGF3aEZIYlhJ?=
 =?utf-8?B?MU1XOFFtbjhETTdpeC8wTkdjSGltU2l2REJ2TEhpbXZuWGVRQnlTUXpMRElk?=
 =?utf-8?B?NlpQZXh6M210M1p6ODdGRm5xUFYxNERabDRya1QyWHc4SGVrVndHY3dXK2xy?=
 =?utf-8?B?bC80U3ZxTkpOeUlJUHdUaUNJTFZnQ0d3VEZtUXk3UnQzSjJHMktXWWg1RDlG?=
 =?utf-8?B?aStHY3pQbUVEdWkvbmt2b2V4aFlldm1hRVpPNVpNd0lHQXBhMTAyUWt5b21U?=
 =?utf-8?B?SjFncG85NHBLS1g0aXZHcDltMHVUN0s1Kzc3ZWd2NSt0QnNCNkJydW9LOUU2?=
 =?utf-8?B?WDVnL2lEYnZSVmZHRWVGdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkF3eks1dTF2TUxZbnhjQ0lWb3pyb09DZmxzT0t1ZXBFNlpOWlVFTFAxdzFI?=
 =?utf-8?B?cW10YTR1aDJreXdUb3dSMUtGTUNGdlA4b255SGpuMjM5elA2MVpCVERzZkpB?=
 =?utf-8?B?OFN6b0FMTkN2Z09qYzIxQ1pQVlRHeFUySUF3T0ZXRlhTaTRwN2ZJYXJRci95?=
 =?utf-8?B?dStNeHU0MjhsdGVtNVh5Sy9WclljVGZpQjdCdjRFOTh1MHhQcjJCRFp4aS9t?=
 =?utf-8?B?OVVwbGl2K1psZWljc2cydk5lblkvZHQzYklyZmR1cEwyYUFiYjV6UDc3QjQw?=
 =?utf-8?B?NUEwUXNSeUFiMDdVemE0Ulo2SzRaNWtzdjBKekdLaFdCWGltNlp1aFVpMEtm?=
 =?utf-8?B?K1B2RWNsUUQ4QzRkY1NxMnlJVmtkbmN6dTZ1MGJBNm50RWhlTmFxNkVpc0c3?=
 =?utf-8?B?T0x2ak5CSHJ0TExqZHM3dmxINksvZTMyUjBKYzZ6SXovUnlYdEJZeVE3NWFa?=
 =?utf-8?B?eFIwZnpaeEZRZGlucG11WTlManc2d0RUOW1xOUJqUE9FSStwbHBaalBZT0Y4?=
 =?utf-8?B?Z0VSaTY4Y1ZMaG8rRXlyRWwxR0ZSc0xXb2I5WjMrdGFBcGR5d0lpNWVhMlNB?=
 =?utf-8?B?cEtlNSsvSC9HQjEzcDNYMFpERWZIblNHbGp6ZHRZdmtEVHcyVmRuMWhXblNj?=
 =?utf-8?B?OW5JeGFiZCtQSytCWmo5ekhOenUzMnhxZ2Zza2YrWm0zMkRGby9VK1RzaDNV?=
 =?utf-8?B?SHB6Z1FBRVZiRktxZWRiRHdOYksyTVFyV0lmZU1ZNmxKNGl3ajJISWlvRTV5?=
 =?utf-8?B?TkQzQkJMV2xDNkszMDJBMDZLc1lweXhha1dHTDB0RmlycTVmT2hSR3BQOXVo?=
 =?utf-8?B?SldqM3IzMmNpQWdsM1djVVRJb3FnWHRoRVk0bEZCVStPQnlKdXc0VHlhR1N4?=
 =?utf-8?B?a3B5MlhxUkNjdm1GMG1ieGZqVXNqbU1QRmxsSVJ1OHorOFVESFord0hpMmd0?=
 =?utf-8?B?cVBTclQwYW5iZUZxb1FqTFBKOVpEakZMTjBZdWlWeDlxZElIRldvb2ZFU05B?=
 =?utf-8?B?NkZxWW8vazc2dHBJcFRCSUZGYWk4SDJFbkxwRFBVbm9LanJlcTFlOTFBVDRO?=
 =?utf-8?B?SC9CMEM4TFNmakJ6cWtJT2ROMXBTeTNSNi9jREVWOHVkMzFERmtQSFpNZlRH?=
 =?utf-8?B?Y1FSSHcvSWZ3MmNNbnJLcFVzdjVKRmFyQ3ZmQlltU0Q5TFZWOEhiV3p2OHVP?=
 =?utf-8?B?RG56SC9DYWJ2STY2UVFkWnhhbGRUYlRWZEhNWHpIakxkWDc3L0U0UWpRYStK?=
 =?utf-8?B?WXlTMU1hK1E2LzZNKytxWUd3cFJXWUFYWUdIMUNHbDBFY3hvblU5R1RJVHBv?=
 =?utf-8?B?SHQza29vRysydU96NHNxUjU5ZFpEQUwvMkZaZUQvV0JlUEZjMG1uWEVpalU2?=
 =?utf-8?B?QVBIamlNNWt1QjQ3Q3dBZW8vS0t6Tzl1YkpYZnhkdHpWenluTkpQL1FydGl4?=
 =?utf-8?B?UFZGcFZZejRtY2dGQ3hEZWJ0SXAvT3JLUEVlbUVlY1hZNzN5M2w2OEliVXhD?=
 =?utf-8?B?eFNtdDdocjd2ZmYxZERDL1VPQjZ5Ulc5bCtaOXdDZ2FTclJJazdKRGFqZmpM?=
 =?utf-8?B?MVZ3ZlUyVitscDdITVNMNTRwRTVnbDFJN0tycUlMNFlCZXBIa1JUYy9RejVD?=
 =?utf-8?B?b1k0U09naXBYeUM0SHVieWx4OTQzQytIVjRrb0QwS2p1YkgxOHdOT0hUb0k5?=
 =?utf-8?B?Q1g5aWEwSE0rZG04SGlNOE0rcE9wLzkwUjFVSnkxdFhaZmxubFU2QjhqK01N?=
 =?utf-8?B?L25hSEw1MXoxMjYvWEYyRlc4MmltUEJ6bENweHVUQUI2dlBJTjJEMVdHeWYx?=
 =?utf-8?B?TjdxUFI3aEVvT3R1M29GejFUa3ZvWURxV2JUK1BLNzVObEN1TUtMUks4ZnJE?=
 =?utf-8?B?NkFvT3E1T0lpV0hiMG1Ia0s4NUV1dFJQaGl4eUQ0dGJyZjkrNXV2aFhyajho?=
 =?utf-8?B?c1pzVXBzTnkwWm4rZUR0dFFhM21veGF2R21mTWhNWnBRdFo2aGl3T0ZLNmRJ?=
 =?utf-8?B?Mkd0cWs2QWxEM0RSWmlhREZYRC92cU1OUHl4ck9aeDk3WHpmOTZOT2Q0Z0Nu?=
 =?utf-8?B?bXRkL2xMN25keHJKUkJLN3VkTnVvV0xmeWZGaldZTzNkQVdiNlgvNU9TRGdJ?=
 =?utf-8?Q?zgdw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0066736854374549A0E0F94D97B8839D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613b20f7-57ee-480d-6478-08dcdf1c0714
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 17:44:25.0272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zizS4AGZ7DhQOW0wu0TfyH9k+UFYra+GUJ0c33Ai2pWRqzUSJdX9Bv0Ulhw+VzyszEYOJ21QQhwHYZemYzXRlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6007
X-Proofpoint-GUID: Q_1AZs-gJyrgmJqSQL7FA-IOUgCridrl
X-Proofpoint-ORIG-GUID: Q_1AZs-gJyrgmJqSQL7FA-IOUgCridrl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01

T24gMjcvOS8yNCAxMjoyMCwgd2F4aGVhZCB3cm90ZToNCj4gMi4gVVNFIERFVklDRSBJRCdzIEVW
RVJZV0hFUkUgSU5TVEVBRCBPRiAvZGV2L3NkWDoNCj4gNC4gVEhFIEFCSUxJVFkgVE8gU0VUIEEg
TEFCRUwgRk9SIEEgREVWSUNFIElEOg0KDQpJIHRoaW5rIHRoZSB2aWV3IGlzIHRoYXQgdGhpcyBp
cyB0aGUgam9iIG9mIHVkZXYsIG5vdCBidHJmcy4gUHJlc3VtYWJseSANCnlvdSBjYW4gdXNlIHVk
ZXYgcnVsZXMgdG8gZ2l2ZSBibG9jayBkZXZpY2VzIGFyYml0cmFyeSBuYW1lcy4NCk1heWJlIGl0
IG1pZ2h0IGJlIHVzZWZ1bCBpZiB0aGVyZSB3YXMgYW4gb3B0aW9uIHRvIGJ0cmZzLXByb2dzIHNv
IHRoYXQgDQppdCBwcmludGVkIHRoZSBzeW1saW5rIG5hbWVzIGluIC9kZXYvZGlzay9ieS1wYXJ0
bGFiZWwgaWYgcHJlc2VudC4NCg0KPiA5LiBBQklMSVRZIFRPIE1FUkdFIC8gQ09OU1VNRSBFWElT
VElORyBCVFJGUzoNCg0KWWVhaCwgSSd2ZSBoYWQgdGhlIHNhbWUgaWRlYSAtIHRoaXMgaXMgc29t
ZXRoaW5nIHRoYXQncyBkZWZpbml0ZWx5IA0KcG9zc2libGUsIGl0IGp1c3QgbmVlZHMgc29tZW9u
ZSB0byBpbXBsZW1lbnQgaXQuDQoNCklmIHdlJ3JlIHdyaXRpbmcgYSB3aXNobGlzdCwgSSdsbCBh
ZGQ6DQoNCkJBRCBTRUNUT1IgVFJFRQ0KDQppLmUuIGEgbGlzdCBvZiBzZWN0b3JzIGtub3duIHRv
IGJlIGJhZCB0aGF0IHRoZSBhbGxvY2F0b3Igc2hvdWxkIGF2b2lkLCANCmluIHRoZSBzYW1lIHdh
eSB0aGF0IGl0IGF2b2lkcyB0aGUgc3VwZXJibG9ja3MuIE5URlMgaGFzIHNvbWV0aGluZyANCnNp
bWlsYXIsIGFuZCBJIHRoaW5rIGV4dDIgZG9lcyB0b28uDQoNCk1hcmsNCg==

