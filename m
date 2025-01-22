Return-Path: <linux-btrfs+bounces-11035-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3D0A190B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 12:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207413A4558
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 11:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAC4211A10;
	Wed, 22 Jan 2025 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="maVa65Ww"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE18521171C
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737545745; cv=fail; b=rEasrnrZyu7b5ChBi80z6bqrHEePvgtG8ScOWB/JlPKwaVdfur5GEPQIc4qPB6SK6EKrlbnvkP+sx1k5JS7mTATEiQGvIJ/cRkELUsStNt0bIXCifXXgkHyYjovFWmGO49yS4OMXqKtlDx3xGl51tW1Jv/Iw+lyytbMK6NKHmQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737545745; c=relaxed/simple;
	bh=sV73F8dkbcWgyVmrLY+sRZs3fQjtwFnP4gy+SrVDoyY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QMoAwvXP7h6hCtXaUlYEi5z9dAeZ/JJJDZ6ZZmX91oY5KJwwwewibkwDaGzyjFsVch6awtmYaF2sxMFzCnRG7G7NdaThlZCSukwTuCuXyNJdkxehGQVhyUrSStTltNcAiEMQEk5iNP1i5ipbbKAYr2Z2IkMgIaDyH0tgQTWLelA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=maVa65Ww; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MASPgM004915
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 03:35:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=sV73F8dkbcWgyVmrLY+sRZs3fQjtwFnP4gy+SrVDoyY=; b=
	maVa65WwNNMFHxzcIyehWZ4gus+J0BFeVHQLc/BtRcZTND3ApiDGjvfi38Ldh5Qb
	gNzaExxzQSRlNyh+6qHIYulL1RvMxbpFtc7NKYh3SCgei7IAXkMuOkkhEOrpjHqJ
	GHwc89nqTB2v+sx24hCKcpkv7I8TrvRHPgylYVTnuGFXG8r351OdC8cNA7xxehl8
	90XiReToBgmWNbvaEMHRmdyLG4SXIpn2l7idY8nppUaR4bBEQcFjm5g9d4UYoCWR
	s/rBgNjYTiAl8IdlhmTryiU5vHsju39uyQT5W7QX+Zcg5ArGHRbIXj/iAfEz1Sbi
	uJBZjt+sQbkrkj6XG77smw==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44axxu89d1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 03:35:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdNz1oflK9InjGgKjGBehHM8RP5hkLlV16SLRqM5s7KDssLsk4/x77fSzdoBiR95htCh0/wp8mKU61RZZdXAf6ko2XwZ2HpNGuZBvDJSRb7MBQIjnlrPGieHbek2YvZwy09dgfsuRUmEz/qcT3iqRurzq/+R7aTRzShntPvnDVuDlmA88DOyitcyZh54P1i3IoHcH/fHCCVI2Gg8TjDLw8t+pMLRm6Qt+bpJQmO0DT5rVXhtMzpVXrR1oMUuSjbmD1Ygtx84o1a+z9iNkYzUTcDc+0ynsvNjFevxPwn+Ego4x9t1cZNDNo1Arxnv1Yvi5v4dHYPVKtuUmBOY09ZXtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sV73F8dkbcWgyVmrLY+sRZs3fQjtwFnP4gy+SrVDoyY=;
 b=gjowKhvAO7Q7lnr/jV2C2raSZOVorKMFddb3lTtFV/q//TFLhQCwzaoQtECjKGFKqXX2CLM/MuhCsBTFctenx7My8nkyg7QkaKxxe+/jwG2Lt4ff5fnqioXkrKfKyzGDDIjZIYFhkN/VCVoW8G251ABWc1O/dAInnOfsAwpdo08SzbgWjrTSYi72dNy/s5iVQAtI7jy8chLnEaV1sy0n2C93FyosdQ1OwENmbL6lcA3B4AB3pCIifbQPACeQyB9gpEUwIy9LA9RgrLeoSO9IP1v4ytBRLP287p9jtGnkMKLk8uf5Dd+Sv+wwWMaieDCKulEum/SzCDl7my/hevlDrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by SN7PR15MB5706.namprd15.prod.outlook.com (2603:10b6:806:34c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 11:35:40 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%5]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 11:35:40 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "neelx@suse.com" <neelx@suse.com>
Subject: Re: [PATCH] btrfs: add io_stats to sysfs for dio fallbacks
Thread-Topic: [PATCH] btrfs: add io_stats to sysfs for dio fallbacks
Thread-Index: AQHbbDOYW1HaLbrXA0imAWnyJlpfc7MiafwAgABBIoA=
Date: Wed, 22 Jan 2025 11:35:39 +0000
Message-ID: <080dca03-dd09-488a-b98a-5a107dbb76a7@meta.com>
References: <20250121183751.201556-1-maharmstone@fb.com>
 <CAPjX3FccHg8HUduLvOODAdj=SN3sNytOEx4TDhkKSJ+P_OVv7A@mail.gmail.com>
In-Reply-To:
 <CAPjX3FccHg8HUduLvOODAdj=SN3sNytOEx4TDhkKSJ+P_OVv7A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|SN7PR15MB5706:EE_
x-ms-office365-filtering-correlation-id: 7f236c6c-4baf-423f-fa6a-08dd3ad8e5d3
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MnFpeUdobGZtZHZxSmx6N1UvR2pJcndZaEZVcmExVjVXbnlVelhDV2szRUt0?=
 =?utf-8?B?Yy9YV2lxYjByQUIveG1OdkJVN1k4OXNXQzBkVFdmeFphRUU1ZlBia2NkdjJP?=
 =?utf-8?B?emV4YU0wMGN2QkNJNGhYbllKMGxHS1MxOFdqUXMxL1hLaVJSbGhFMXhOZGhi?=
 =?utf-8?B?N2Zsek9VeEhBRjRDcnF2em43aVd0WkNGTFZGbVNEOG13VkthaTZ2ZzVTUE1x?=
 =?utf-8?B?ZmNYWEJaMTBzWko2aG9XeGJFdGxtV1gwQ0NOM0J6ZWxZREd0Qmk3QXA4dnpL?=
 =?utf-8?B?SmloZGhuOHVUT2JTRHNTYUxZU2M5WHR0RmZ0dDU5NVhRd2ZRQVk4QlE4Tzhl?=
 =?utf-8?B?K2J5ay9YYXoyT1ptSXI3RVlteGI3a0xDOTRydlpUdklIcE9tc0RMa3RUMWtX?=
 =?utf-8?B?d1dOanVlZHE4bXdJR3NDRy9qM2ZwR2d4ck5KK3dMYVZFWGY4eFhOcXZSSWht?=
 =?utf-8?B?aXRxdTE0QVNXb0k1Sm9lWnZXUlE0aTJIZ0RIMlE0ZXVkaHF4aW9jZUF0a04w?=
 =?utf-8?B?cGc1cnZQZmExUUpYTjJadjV5dXFDZU9pMmJRTVp3VXZaOXhQaUsyUGlNSnln?=
 =?utf-8?B?dXhtTjdqTVNrN0tTQ3AwY1pSeTEvZ05YUG1XYzBobmVuM09SRVN4RXNFYkRk?=
 =?utf-8?B?NlN0YTJTSWZSOUIvbmZ3UXhoa25DZXJMN2JJM1h3QlJyMS9ZTFlaSm5DMTlR?=
 =?utf-8?B?TjJQajBSL0R4YmFEcHh6RmtoN1o0VmZjQ21aQkZDcU9rZ1BMYmZqQllTS3JV?=
 =?utf-8?B?R1lTR3FjNVllZzR6RjRacWNtdFZRcXlwNmpKa2FCM2lkcjMyMEhGRm0wTlor?=
 =?utf-8?B?MmVZWlBxUi9KL2hHU0VJelB6QzVYNnFBdGE4WG14UnUxYi93MHNuR0wzclNi?=
 =?utf-8?B?V25nVTlGWng4TUJQNXB0MHNieEF3V0lINmt5UFFkZVgyUGE4NFdFZitCaXBu?=
 =?utf-8?B?VU1TUWF4SWZEbHYxbWtjektMeXVDTnlZZFZ5bW5FNEV6NHpabkxrS2lXbFdU?=
 =?utf-8?B?S0ZCTm1jZXJZWmFEVjFGMXRZVURLbWIwNzBnV21TOElrRi9mWnRxbUtIRzBD?=
 =?utf-8?B?TTlJNUJOMG1BbUgyeFVWcHgvSEloQ3pOYVF1c0xVbTFTL3hEYm1oTzY0WGJT?=
 =?utf-8?B?K2pXdVBIUlg1eU9kY3gvYU03d3hHMFJlbHFOTFpGNzJSYnNEWnZMNS9Qc3Z2?=
 =?utf-8?B?c00xR281aUtLWm80ZHFtNitlbVErRzBZRWttZnMzSTYvVEU1TDB1YjBFc3Fi?=
 =?utf-8?B?aXR4aWgvdDcxVzZjajN4RTJrS1NNaStoN2taaXNVNUlmU1N2dmRLbEVqSmRn?=
 =?utf-8?B?M2phTDVFSEZRN2ExSWh4STRPOFN0aW95N3Z2cGk0bW9DdHdUNk5idzVvU1BD?=
 =?utf-8?B?M2FnbXAzbTZqeWppdTVBclFwSWYvRE5wVjJSZGh0ZEQ4WjJMT2R0Y0hqK2px?=
 =?utf-8?B?T0Ryazc2YXdLVGk5cGZmNXliS0pUOHNNMnYwOVFHdE1WUWlGTVhjdHkxbjJq?=
 =?utf-8?B?K2I5K1lsYTQxRkFTbWVnZ1lUYWZCZ053MFJha1JxL2tYenhxbzdmamsvTW9R?=
 =?utf-8?B?NXliVFRJbmd3OHk3aVZYTmZ2RTl2ajQrRVZRTXRkaVZFVHN3bUVWRW9ZY1Bw?=
 =?utf-8?B?NUV2aVFzb2h0anhXdEZ3bzg0bFlCVEEyR3B0cjEwcGRYWWRVWE9vYmRsTHZk?=
 =?utf-8?B?YzdHZHNxQTd3R1N1ZEhOYllnbVVJYTJjTWdramFmRFNHQTNRbXFlS1dLRk1o?=
 =?utf-8?B?S0lLU3RpQUZRZUFTdHRQaU91WU9ad1p4ZkVORzFJSEhBWjZXa2RrbEJxK1lG?=
 =?utf-8?B?bUEzNXhWZ2lQNm96VTEybXBSMW1CenovT0dqVVl5cm4wQTkrWjR0Y0hqQ1hZ?=
 =?utf-8?B?eEg4K2NSTzhiWjFycFl3U0M2WlBBR0ZEa3plbm1pbHljaTZCamR5UTREb1ht?=
 =?utf-8?Q?OVoLr0nB279kRLBB31SgSykRkAgJRBwP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXFwUDdicTFWYUhFd0oybCtGZWZ5NXFUb2c3TXFDY05sZm9Gb1VXNDZsenlj?=
 =?utf-8?B?YnRXTlN3NjhwTXU2dTRPT1d5TE1iUDFHT3Y4OXozUWY1NUZZUTg3TklGWFYx?=
 =?utf-8?B?V1MrUkE4eWJ4SlFVcVpRZEVhME5UQ0RQREw3bXl5alFpRTllQWFlcmVybi9D?=
 =?utf-8?B?VExKQWlTeDFBWEdUUHB3dXdIb2pnamVkMUVuQVdpOU9SN0JjWHF5T2tNdWll?=
 =?utf-8?B?Y0pGQUZpbjJjTkZZU2NsRStvdjN0UXFabkp6RGJZNzFXSFVHZHhVdFJFMTJn?=
 =?utf-8?B?TUZBa3cxRTBzVThLV2RhUkh3bHNkaGsyTHFDVmZlVVcwdkhvM0lKSWFCZHNZ?=
 =?utf-8?B?Z2dHN0JNRFhaclAvT281dE5sQ1R3aFNFUWhEemRSV2hKNC9odlpnZVAyQkVy?=
 =?utf-8?B?TCtmODZxenFEYlhVQTlwLzB0RzBRUWg1aE1WVWpTbXM5Ly9Mdmxxdi85Y0pl?=
 =?utf-8?B?WDdkZ1lFWHdCNXo3TC9oWXhzcGlVd2VUUDZaQ3VpSXpqTzF3V1JEN3VidFpp?=
 =?utf-8?B?YWlxS1A0U0RVaFo1WHlGOEpvSmwvUnp3bTVjNmtrVTBkOHZyaXlNOFBKcmM4?=
 =?utf-8?B?N2tzdVJNMFVlZVYrWnlWVHFvcmxOY01OQXVnUHRla2ZSbk5zZkZGM2xUODlX?=
 =?utf-8?B?WTc2NENZbWVuR0JBSldaWGZqd3dOdHVBdHM5M1ZZL1cvN3BDRXJRSDUrenZk?=
 =?utf-8?B?ZE1wbHhRRUg0YndLVTJZalhpM2UzWXFSOWxadXhyekdaNUNJTVlKNjZKYkx6?=
 =?utf-8?B?c1FQSk5jeHNudDNRNTRkdHhlK2JpNnhra2MzUStFU1M5QTZKRnpPam42VGdK?=
 =?utf-8?B?YWZDa0tSUVdOMWtmYmpMZmQyN01BYTl5Uzhjc3FMaHNKa0N5M2pKRENoMWQv?=
 =?utf-8?B?Yzc4bVJJdlhES3drK1JNOE9MYnhIcUo3Slh2cDZNcWVQSFpHL3BTTXNOUzVT?=
 =?utf-8?B?YWEzKzdrVmgwTS9BODhEOVNPTS9ZazFZZTErdEVrZ2x1eFFLb2ZYOXZoV3VG?=
 =?utf-8?B?ZnlBNTl1eGNOZjNhRm9NSldtZm9sMlBMNDd6blZkY3l2cjgrcyt4dVM1alNW?=
 =?utf-8?B?SWY3K3luN0VaQXh5UXIrOCtrVWE1eEtlV1NlcHUxMkpzZEhCeXA1c2poK3Jh?=
 =?utf-8?B?SnNaMFlFdTBWdDd5RXBSWFZHVytmU1dleXNFdGFDN2xmdmNsUEZXK3FxNkFt?=
 =?utf-8?B?UXg1cjA5cXVqMjNLVlppY3NuMVZNTEhzeEx2ZGhyUGdzbk9sOVNtdm45bmdn?=
 =?utf-8?B?VUcybDdlRDRIRkpWUEVQS2xNMzlUTUtYbXpmYTNsbmpDdjkybzNObVRtNWhS?=
 =?utf-8?B?UUxzeldhQy9ETGo2VUNXQUZEMG9oRjJ4VHRtNkNQTUFzakhwZnp3WVB1aFhH?=
 =?utf-8?B?VnRWNGt0WFJKRDd0cEVjVEdiNTdVUGpJRkd6ZkRaNlFiZ3d5cXdPYzJpMXkw?=
 =?utf-8?B?OFlTd3lYM3kvUHJrU3E4d1FwV083R1ZGYktkVG1Ra08yeDdPaHJaV2xZYzlI?=
 =?utf-8?B?UmpaemNpdVBuUi9tYTB2WUxLakpyYVg4Y0g4Z00zZEQ5N04vY2lFZnkySEtU?=
 =?utf-8?B?QkhBbFpwU1llWW5aQy9tb1Y3cWJUcS9pbnZ4alVQdlFKalZIV0p1NjBWRTNu?=
 =?utf-8?B?U2FQNHNjTmVwTlg0cWZjNXllOGtTKy9tZytoSVRJcWYzNzAxQ3VJd1ZxQUQ3?=
 =?utf-8?B?YjBBdUY3ZkJhcjZxaXBmUkZpdkV3RUkxVkVjdU1CbExYZXRCQmd2SWs3SFBW?=
 =?utf-8?B?TGxseXZ4N0xXR0VHM2NiM052cVNsSWNncUlCYUNoLzI5RUZvUzcwOG4wVkFj?=
 =?utf-8?B?NDdaTHRoc0x2UEpiVXA5cEtxMTIxRmhDbkFtY1hkWHpreWpLa01QM0x0ZURs?=
 =?utf-8?B?V1JYWnpNU25VTlFYQ0tTSUdld1djUEE1SnhKbFVSS1Y5c3lydHFva25VWEJP?=
 =?utf-8?B?Y1RpbzNHMUVzK29KOWxqVzZlVmVPNW8vZCt4aGJTMkkyaEl5WGdtV3huUks2?=
 =?utf-8?B?bjFTVFAwelNLdUlBWlJzZUQ2VHUzeU51Y2R3MzRTS1dMV0pBSDJ4WktHaS8v?=
 =?utf-8?B?V25ZUGgyVkQrdGxyaTVIYmNLZ3MyamhxY1JHQ3lNSy9rWXhQdU5jQ0xKcytO?=
 =?utf-8?B?OTVyQ1YwK0djZUk1VStWbGN6bXBrM1hPU1FGL1lKUEk1UDFmYjZwYk92TzJa?=
 =?utf-8?Q?MN3Az6Ij4Fe1cNl5M5w1jTs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A2C3F01E1000948A5966C565B0A8E50@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f236c6c-4baf-423f-fa6a-08dd3ad8e5d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 11:35:39.9652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QXFHMaiHkBwQYg288XaCr+hkL/d/K7qpG2ot3BtXToxyZ4GRt/Kq2qY9dfhBtL4W9MCNMDTI/0vDYc1hhFC4DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB5706
X-Proofpoint-ORIG-GUID: KtTB_9iKvQj5nN4knBeXJobvLZ-fdoNx
X-Proofpoint-GUID: KtTB_9iKvQj5nN4knBeXJobvLZ-fdoNx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_05,2025-01-22_02,2024-11-22_01

VGhhbmtzIERhbmllbC4NCg0KT24gMjIvMS8yNSAwNzo0MiwgRGFuaWVsIFZhY2VrIHdyb3RlOg0K
ID4gT24gVHVlLCAyMSBKYW4gMjAyNSBhdCAxOTozOCwgTWFyayBIYXJtc3RvbmUgPG1haGFybXN0
b25lQGZiLmNvbT4gd3JvdGU6DQogPj4NCiA+PiBGb3IgT19ESVJFQ1QgcmVhZHMgYW5kIHdyaXRl
cywgYm90aCB0aGUgYnVmZmVyIGFkZHJlc3MgYW5kIHRoZSBmaWxlIA0Kb2Zmc2V0DQogPj4gbmVl
ZCB0byBiZSBhbGlnbmVkIHRvIHRoZSBibG9jayBzaXplLiBPdGhlcndpc2UsIGJ0cmZzIGZhbGxz
IGJhY2sgdG8NCiA+PiBkb2luZyBidWZmZXJlZCBJL08sIHdoaWNoIGlzIHByb2JhYmx5IG5vdCB3
aGF0IHlvdSB3YW50LiBJdCBhbHNvIGNyZWF0ZXMNCiA+PiBwb3J0YWJpbGl0eSBpc3N1ZXMsIGFz
IG5vdCBhbGwgZmlsZXN5c3RlbXMgZG8gdGhpcy4NCiA+Pg0KID4+IEFkZCBhIG5ldyBzeXNmcyBl
bnRyeSBpb19zdGF0cywgdG8gcmVjb3JkIGhvdyBtYW55IHRpbWVzIERJTyBmYWxscyBiYWNrDQog
Pj4gdG8gZG9pbmcgYnVmZmVyZWQgSS9PLiBUaGUgaW50ZW50aW9uIGlzIHRoYXQgb25jZSB0aGlz
IGlzIHJlY29yZGVkLCB3ZQ0KID4+IGNhbiBpbnZlc3RpZ2F0ZSB0aGUgcHJvZ3JhbXMgcnVubmlu
ZyBvbiBhbnkgbWFjaGluZSB3aGVyZSB0aGlzIGlzbid0IDAuDQogPg0KID4gTm8gb25lIHdpbGwg
dW5kZXJzdGFuZCB3aGF0IHRoZXNlIHN0YXRzIGFjdHVhbGx5IG1lYW4gdW5sZXNzIHRoaXMgaXMN
CiA+IHdlbGwgZG9jdW1lbnRlZCBzb21ld2hlcmUuDQogPg0KID4gQW5kIHRoZSBtb3JlIHNvIHRo
ZXNlIGFyZSBub3QgZ2VuZXJpYyBzdGF0cyBidXQgYnRyZnMgc3BlY2lmaWMuDQoNClRoYXQncyBm
aW5lLCBJJ2xsIHNlbmQgYSBwYXRjaCB0byBEb2N1bWVudGF0aW9uL2NoLXN5c2ZzLnJzdCBpbiAN
CmJ0cmZzLXByb2dzIG9uY2UgdGhpcyBpcyBpbi4gVGhhdCdzIHdoYXQgd2UgaGF2ZSBmb3IgY29t
bWl0X3N0YXRzLg0KDQogPiBTbyBJJ20gd29uZGVyaW5nIHdoYXQgb3RoZXIgZmlsZXN5c3RlbXMg
ZG8gaW4gc3VjaCBhIHNpdHVhdGlvbj8gRmFpbA0KID4gd2l0aCAtRUlOVkFMSUQ/IE9yIGlzc3Vl
IGEgcmF0ZWxpbWl0ZWQgV0FSTklORz8NCg0KT19ESVJFQ1QgaXNuJ3QgcGFydCBvZiBQT1NJWCwg
c28gdGhlcmUncyBubyBzdGFuZGFyZC4gRXh0NCBzZWVtcyB0byBkbyANCnNvbWV0aGluZyBzaW1p
bGFyIHRvIGJ0cmZzLiBYRlMgaGFzIHhmc19maWxlX2Rpb193cml0ZV91bmFsaWduZWQoKSwgDQp3
aGljaCBhcHBlYXJzIHRvIHNvbWVob3cgZG8gdW5hbGlnbmVkIERJTy4gQmNhY2hlZnMgZmFpbHMg
d2l0aCAtRUlOVkFMLiANCk5vYm9keSBpc3N1ZXMgYSB3YXJuaW5nIGFzIGZhciBhcyBJIGNhbiBz
ZWUuDQoNCiA+IExvZ2dpbmcgYSB3YXJuaW5nIGlzIGEgdmVyeSBnb29kIHN0YXJ0aW5nIHBvaW50
IGZvciBhbiBpbnZlc3RpZ2F0aW9uDQogPiBvZiB0aGUgcnVubmluZyBwcm9ncmFtIG9uIGEgbWFj
aGluZS4gRXZlbiBtb3JlLCB0aGUgd2FybmluZyBjYW4gcG9pbnQNCiA+IHlvdSBleGFjdGx5IHRv
IHRoZSBvZmZlbmRpbmcgdGFzayB3aGljaCB0aGUgc3RhdHMgd29uJ3QgZG8gYXMgdGhleSBhcmUN
CiA+IGFub255bW91cyBpbiBuYXR1cmUuDQoNCkJ1dCB0aGVuIHlvdSBnZXQgYSBjbG9zZWQtc291
cmNlIHByb2dyYW0gdGhhdCBkb2VzIHVuYWxpZ25lZCBPX0RJUkVDVA0KSS9PLCBhbmQgbm93IHlv
dSBoYXZlIGRtZXNnIHRlbGxpbmcgeW91IGFib3V0IGEgcHJvYmxlbSB5b3UgY2FuJ3QgZml4Lg0K
DQpJIGJlbGlldmUgYnRyZnMnIERJTyBmYWxsYmFjayBpcyBtb3JlIG9yIGxlc3Mgd2hhdCBKZW5z
JyBwcm9wb3NlZCANClJXRl9VTkNBQ0hFRCBwYXRjaGVzIGFsbG93IHlvdSB0byBkbyBpbnRlbnRp
b25hbGx5LCBzbyBpdCdzIG5vdCB0aGF0IA0KdGhlcmUncyBub3QgYSBsZWdpdGltYXRlIHVzZSBj
YXNlIGZvciBpdC4gSXQncyBqdXN0IHRoYXQgaXQncyBuZWFybHkgDQphbHdheXMgYSBwcm9ncmFt
bWVyIG1pc3Rha2UuDQoNCk1hcmsNCg0K

