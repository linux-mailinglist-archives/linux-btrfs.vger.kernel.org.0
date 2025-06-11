Return-Path: <linux-btrfs+bounces-14596-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFC5AD4DEB
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 10:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50C017A38B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 08:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEECB23505B;
	Wed, 11 Jun 2025 08:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cBpjz/FR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78742126BF1
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749629204; cv=fail; b=um59Vi1ndzMlSILd+u9jOV3CpFcXZ5Viv400Z21DOl8ojrpyqoeilUWROFX/9Z1cAbLHNL8lWslwTJJ8NS6YvMqU7TAB/q2mHbarmXL12J/RhGb7DMSZrgF5jxiqU1BRs+DcFXfBmgIHCDbpdsBHTc1199a0m3LQX7BUc/c5lB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749629204; c=relaxed/simple;
	bh=JI9Ikzz3PJp/Ulo6//zdc6VIBoRo3RcVLQ1MrbBiixs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DOiT+d1vDoZUgdZLucUGvV1fGAanETcpXs59x34iWNmcz0gdI/muIg9ZpM8fhUi8xjeW1D5JInzGYoTYL//nWnYlT1IWYREg4C/Y4LPSwFnu/0zbCqB6gtXjgixXU2GcqkLRUvL+Fa6WEssZZjg7dvoA7h38XHzFth2OoiApD6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cBpjz/FR; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B4svXO003046
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 01:06:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=JI9Ikzz3PJp/Ulo6//zdc6VIBoRo3RcVLQ1MrbBiixs=; b=
	cBpjz/FR7TVAYGLBy3HZkiDbw2DyyAuNcxe1PwWwjGyvvPSWyIBGrEo/1IB2SfZ7
	RkhJSJ8KvFlvr7JA62Tfv6jEy1xyaMTPk3/zGRNFHwKF1Flw5SyJBiN+WHVdH/LW
	Cj8LcjpE34qazAZKT7ym8nEx++m2gYOe1o18WbPawFfNG72iJVSQNKB2rAJ4BSpV
	NAFGds46xVzZXmySWcrzSYOJEP1RzGo4c/B6plOTSRTlPc0NCBReUKlksLWQN0rR
	2sgJKSVy1mWddqcOGN4YuGEwwC/tgJ/bQ9WmEodYtKxSMyjCOtlwn/e3e73VCnPe
	vWZ9fKeWfSmCukUKi58rPg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 476yf9hsns-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 01:06:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uW8sgIFv5o4+gjoETeijqk9wk0PAr2PdNSv29gHoaTjQetHiTOHW9sYt+RcnZNdG+auG2ysObJPvBywFiPZ5FktPtPKwIUE2ycCt5dRUOw+sf/co+nGT2dDtAQI05aH/ziPC2Fyf75kpzgNAnn2+TV9Zr/LPdjTKfuTBcf0Bum63faA3bVSb6025qeX19DilXdYfm4BCiQMxiNpkxzutCHa6PF7PdOChKCTNfYPsh1EBB7elVmcKaLPG/2+PNL2t9N4ZpJeW6zhPlCDJoaJN3Sa+klRv2MJN0Cg3ihOn7CZXSoupQcU152ZaJQKhCrVHi/221SfuOYEClUbkd/OHRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JI9Ikzz3PJp/Ulo6//zdc6VIBoRo3RcVLQ1MrbBiixs=;
 b=UNMvrxALjIT5Yna4ODl6Bf0/WimjQkjV0Aiq7x9YD9BLdQBFF71pFEhBwi7EYeYWzkhQmn4yOZmJWC0XdGyaDZ8479515bOWbzROOlKC8MApk40eqHu/olVY7K5pKyxFV/FMpbFuod4wHXqchb0CixuY4iId/H9KuS47UOHzQWTqaMMZsSp+RpSxioZdbAaWrssYRJpo7iG/kjK5Z0Gc57QBdoWBLoKeq2XTraL4UF6wWzK8ACc1B5u7gTmkuTduzMfjizZXU54pN+l2HzF1g72ayXdtwsEUIGPw1QW5rA93kQdyqm+/ipXDr4yjc40dvfzf1HbA2/pFkxx05mFQyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by SA3PR15MB5726.namprd15.prod.outlook.com (2603:10b6:806:315::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Wed, 11 Jun
 2025 08:06:38 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%5]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 08:06:38 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/12] btrfs: remap tree
Thread-Topic: [PATCH 00/12] btrfs: remap tree
Thread-Index: AQHb1jY9ptj9DkqFPkuHGxeXOfmKP7P8fFoAgACd7QCAAIjOgA==
Date: Wed, 11 Jun 2025 08:06:38 +0000
Message-ID: <fe02c731-104f-444b-a923-e4c380f83b97@meta.com>
References: <20250605162345.2561026-1-maharmstone@fb.com>
 <dc9e87c5-03c2-47f0-b727-43c9e1d5c086@meta.com>
 <7a58ebec-17e1-4070-a80d-3828f639c5f1@suse.com>
In-Reply-To: <7a58ebec-17e1-4070-a80d-3828f639c5f1@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|SA3PR15MB5726:EE_
x-ms-office365-filtering-correlation-id: 401f37c9-bbb5-4317-ba8a-08dda8bee455
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L0w2djFuOXFibi9jSHFQb0ZLdkZpOStZdlh6TUxLRkR1b3BmRjltYjFsb2VG?=
 =?utf-8?B?WVorQkVlUWRDaHZmenAvVFY2K0c0dG4xanlIRDhqalNaOTNXY0Z5a2RzQzl0?=
 =?utf-8?B?MUZtSkp6LzQzQ0gydHJsdXViSkpIdmxQMWFXSHdvN1pEU0FMRnZYRkdQSGpl?=
 =?utf-8?B?Zm52cnZiNzJmYlJlRloxZ1BRckEvU0hsdzlsaG8weUVGenBJQW9iYmJlWHRQ?=
 =?utf-8?B?VGdlNXU3KzI0T0VmN2VXcTkxTXpueHh6UjErWS8rcmxaaWJrVzkvTmRyUmRH?=
 =?utf-8?B?U1c3YVZyaytGOFlIakZFcHI5bkF0U1k4anJ2SkdPMm1YdkFGNU1FTnBiSUlQ?=
 =?utf-8?B?QUpDTDVLMnRWampTMEl5aG5IRktmYmsxc2Z4TVRBSFJRU2lHWkZmK1pXTE51?=
 =?utf-8?B?bzFkdEsxNEZETHErMHltditIM2g0RlZBVllxMnBCTFIzeGNWVGxOcUZhcW0r?=
 =?utf-8?B?UGcxRHBnTXZMZ2NnbmJaMjZlZGhmczRCazd6eEhkVFhmQVg2ZTNXU2lieWVN?=
 =?utf-8?B?REp5UDdCNnhvUFVxRHlPR0hnSmowMC82Qk81MXZIVG44UWNDczZPc1pQRXNm?=
 =?utf-8?B?dmJmOHIyTzVJajBXUzRNT3Y3SElDMWNIVEpyOVdkU2dLc0g2MTdBZ2MvanRL?=
 =?utf-8?B?RXZISUsvTVJUb1crODRra2xzK09uQjZ5cFdwK0VIZjFnMXdxR3BTVTI2d2c1?=
 =?utf-8?B?RFF5MzkxaFpXTUFXVE9wMXRrV2t1ZC9KMEJXS0RrR0Z0cGRNZWc2bFZSaFhM?=
 =?utf-8?B?cFF0Q1pEZzJMai8xbVhxRTc3eDVNeGlrZW91Qms4L0VaOVZ6MnMwWGpwZkpl?=
 =?utf-8?B?UXdUb3oxNWJaRjVrZk1TY24zcVhXZmI0dlhCNDJrWlBKS0VFY2lsMDA5TW5v?=
 =?utf-8?B?S0V0Vjl1RThqRklocTJyZ3pFZFNSMDdjYU9teTArNzg5SjIxaVFOZW9BQnd2?=
 =?utf-8?B?SXV6SDVCUjkySy9sRGJNdDNFT25ORlRiT3p4WStzZUxsU2xYYXltU1ZxZWxn?=
 =?utf-8?B?QnFBNmJaa1VSazJDcTYzRm8rck1CN044VC8wRTJlcFo4R1NCamwrNTVVbU9o?=
 =?utf-8?B?cXl3L2ZWTDhmbzkwVkY0WFErL3lQZE9lZ0hQbEF0WVdqUXprc2M1K3dFaFF3?=
 =?utf-8?B?RmhsT2ZQOGFlWjRTRWlHNzdmNUhtVUpmaVFWeHRTUmhzbERlam9GMHBxN2ZI?=
 =?utf-8?B?YWxEek1xZUl5VHBqVGpyNkdpamthYVhRMWp1UWxCQ1RPV2hPWkxITnV6NmxP?=
 =?utf-8?B?M3dFNXN4dFpqQ3hnQnhsZE1jbC9vSlcvNmJrTUM2RlFwZWg2RVBLZkk1QU1v?=
 =?utf-8?B?M0RhVXFzWHlYRWV1TktJK1paMjVBa3hmREYvb2M4Mlp3eG90QXBVN2cyK3JQ?=
 =?utf-8?B?ZmJzd2h5MGFMV2dhY1pTT0pGbTFkdHNESU4rVGQwYmxnMGxGRkUyOU5NMjds?=
 =?utf-8?B?R2JqM0NrMXVyVnZmLzZWK1gzRENrMzcyRU05QXVUMzc3VTNmMFFyQXV6RmlH?=
 =?utf-8?B?WFZ1MUlQMENRYVRFRkxmVHIveVk3cmNCL2h0eSt1cGthSVB1VVlDMjRBN1Zw?=
 =?utf-8?B?a1B5b2hqK0s4WGVJMGc1M1htQ25tRHE2L0ZLU2pjUmhkRU9kRy9JUGI1Sjhj?=
 =?utf-8?B?aEl4Y3JGU2hwNFJHcUhaUmxvbE5hN2w2VnE2SUpUaFFJUytGOFFoNkZpNnZq?=
 =?utf-8?B?RW1SNWZVNTZ1NkIzeDlZNDhiQzZqelpVWmpPTUI1akxqTlFYM0plRVIvWVNF?=
 =?utf-8?B?K1oyYWQ4aTZEdC8xYjB6UGxPUnBwVi9wQXlWbXVLWlQrdHIxa3Q1emFSajBs?=
 =?utf-8?B?T2JSM2dkSWJ2UHdOUGhYMlB2V2RQS1hPRkhFQmtMQzh5TmVPd0RoaGM1Wjlw?=
 =?utf-8?B?blMvTUh1WjVOeXczbkF6cS9zMTdaR2x3WlNMckdDMDI2UnViMG41clFGQ2dX?=
 =?utf-8?B?NkVNbTUvNERuNHJmK0F4YUdhZVhmdS9XWGxaNDI3SE1ndmVhS013aUtndktN?=
 =?utf-8?Q?gicioGa+lwEj0royumNZ85MjmJyte8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2Qya0lpbnBzcVZieVdjRnA4N1AyYmIyZXdxeklSVEFKVUVDTTc4cjlSTVVO?=
 =?utf-8?B?MVVvREc2dDE1bDkzeEkrWmNVOVNCZnNsUTEwK1lQa2RoT1B3c1lvWGoxbG1F?=
 =?utf-8?B?ZGxNNjJpOWQwMFpEczhSNEE2cGxURU5GMlBwM2t4ZnFDcnhhZjlGZTNNR0JU?=
 =?utf-8?B?SjdVb0kvc2ZKUkY2ZnNaZWRtcDJKemIxc2VJRkVOMnJ4V0hZN2pOdEFIK2Fy?=
 =?utf-8?B?T1U4S3JPUXB4RERTSFhQNlJJRkdodjRjaTdrMVVpenB3NURCVkhEblpaZWtF?=
 =?utf-8?B?SG9TOWk4d0YzY1QwRlNMQjgzbDFjY0FDNHkrNkV0Z0RySDlaVVJGOFlOYkJO?=
 =?utf-8?B?YkVYVFVDVGdjRzU0YW1JbjZIa1BvUGtoTFNWaGw4QU0wNWJZY3pISStsbVBY?=
 =?utf-8?B?dk85TmNmaDZPZllaZGxUNnZ3R0VKTzd0TTRjMCt2NVVGeVFUeHRERzRQYlEx?=
 =?utf-8?B?aDdoWHE5K0hseittV3BLRkYxdlpVM0FmSGZTQkNhUERSejBUSWpSY1dSVzRK?=
 =?utf-8?B?bXNxTjU3cm44OHhPRndrUmk1WTNoaHlIVUR0dHFwWVd2UUJJOWUrQW02b3Y3?=
 =?utf-8?B?a2h4Y1o2WG1RQko3RjlkQjRhNGoydXg1NloybjNSZkZ5QXhOOXpTcG5FQWk1?=
 =?utf-8?B?WUExTFczZHVMZEdRejBQeVUwRlhYNWRoclhncEhsY3FsZmFhOHpNTHUwYUJt?=
 =?utf-8?B?U25TYk9kaGVHWWFTMHg0QVBMcWZLOFF0MHluV0VvdCtjQlZMekVqQUlPSjJI?=
 =?utf-8?B?bVYwa29TVmtlU1NHcUF1N0hROTNtYnBoUVVuYjFmZ1pFLzhOMGxXMXZaMjdu?=
 =?utf-8?B?dTJ1b0lGVVcxenhTbEpET1ZjV0N5NHFDQmV0WHl6OXF1aVk2TjhEdHVkd2U3?=
 =?utf-8?B?QmlSc2NHd0pRb3ZFa1haQUhVcWVHR0RCZ0ljQ29PR21nOElmeWUyRGl4TERm?=
 =?utf-8?B?WGRKRVlvSmJvbDFFYmNTMWdycUdwcEk2WWMyUC85eXVDRGJFWS9NYU9JWlBB?=
 =?utf-8?B?bmNCVVloN0V4OHFtRndXS29KRkdYTDhuSnI5b0NDWE50YTNvdU5wQ0lQb3ZR?=
 =?utf-8?B?end1SWF6bmRtS25YZmJQNUVpczNJUmdmZCtneDh4MncraTRGZUVUZGI5SFFv?=
 =?utf-8?B?YlkyUGVSL1oySnNpZEYvZ1luaHU1bGVDeU5yandiMmVlUkFSdTFISmZZTGw5?=
 =?utf-8?B?OW8vcG1ZVDI3TmdidzhGaXdFVmlBVjNoTEFtbDB5NHlURldnTkppUW9yeTZQ?=
 =?utf-8?B?YXZPTHg4UlR4V0xseFVCc2NuSzA3TkJ3S0xWcjhUdlRzb0hoUlNtcElIUHlZ?=
 =?utf-8?B?Wm5sekU3LzJnUHRJelBldTN4UU1VN1RSK2s4MXg3RkJ5UzZ2clpFMkcwQ09D?=
 =?utf-8?B?ZEZ1MjB6TzhiajJGNmlJSUJMQW1jYVN5OFRwOXNUU1Y5L3ZPdElIT2c4Rld4?=
 =?utf-8?B?UDlvNXRiMCtHaHNJM051cXlaYkJiMjJUTDdjOUt5MjVEVHkza293YVlyRUdN?=
 =?utf-8?B?ZHdDS244Tm03eDFCdWMrMDVnUGp3MzdZQWgzZk5UZ3lxYWhZdkE1RFNNV0c4?=
 =?utf-8?B?ajlRUktMelprdkpBUFlvM0hlTnNCbkswdFpRb1lCMjRKeGVTM3ZDVVB4WkJo?=
 =?utf-8?B?MzlvM1cyU1ZMcHUyVVZuMWM3UGVpRkxCcDNxdzdGOFJsMGxTMXdUbG9JdnlG?=
 =?utf-8?B?OHlFQXlKeFFQejRnVndWbkdxTkVjL1plS1pkdnZVYllIYlIyQ0pVbGtpVTc1?=
 =?utf-8?B?OWhiQzBqeG9meEM3YitIR0FVWVRKWmdOVXVOOGlKWlBWWjFJQ202bFNGNWk0?=
 =?utf-8?B?QzdpakFHK0o4NGptU2V4bTFKTVhLRXNLUU5MRjNyeHBzY0VzRitCMVlBbjRB?=
 =?utf-8?B?NFBVdGNuZWRwaVhjRkJwaU9YTFlqd0ZEeUZTcDMrbUpWM2tJczhJQjNWM1Fn?=
 =?utf-8?B?b211RjBzWjliRThnRk9FckZnVEdSajZIQmc4VW5lRGdFVjRiaUJlMDhSdlFS?=
 =?utf-8?B?Y3J5anpDN1dJY2x3UlBsNzIyVllSRFV6ZFRGazdWZHZlNUs5eE9zaGp3RjBr?=
 =?utf-8?B?b2FWeit3WVQrb3I1UGN4RFZGeWM4c3hrUFgwMEhrV1k2SDZONjBOc0QydVVk?=
 =?utf-8?Q?pqzY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E4CA9510A0F5A44B50CA75818EFCCCC@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 401f37c9-bbb5-4317-ba8a-08dda8bee455
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 08:06:38.4326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J6NtEdDgXT9a4mn9r6voLoI9KWXyeGWyN8H7u/mAASJlzEUVD0xxR+7m5ARS33Ff4C1yes/tDn2eV0juSrP/PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB5726
X-Proofpoint-GUID: _Q82Qiruu1qz4xdOuwPCBJOluo5saAGH
X-Proofpoint-ORIG-GUID: _Q82Qiruu1qz4xdOuwPCBJOluo5saAGH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA3MCBTYWx0ZWRfX4WRpGLAqFMts wngcqReGtUkJlbZjrWrkXVWk9QECduSM7UlZHBaAUdEDmRCo58al/fIDm95ksDoMcQhUCrdyRCg BxH7un7oeUSETHoJn4mD5CZ0FUwCqzZ6N0dQfc5zufykb7pKIo/exxlhxFUfHvnMg+Iu29VJlXI
 ioxKeYpt27P13VJ5QiiPQzAoDSOAf0eqLSYcYSu71rZZ6jeF0C6ZBcCFvB3PYLzgSFO+/Akmr82 a9GA09cnciuOF6tln2FrjzxhzhSTjl1DtzJRj9jycF9XC+cmMVbmE2oRfI0gWn8QpycZBs0j9P5 VuDVTp/R55hRLlVrEBgF9HQb+ueLWxQXPw9rUtzCKKxUzm97k4AcoC4VRpOj6hfE/g4koCFX+vY
 SbcFCSSJJLfhOGBZ+g3ayWCbGSWOhKLBap3WyI/aAT8uyBDspPJzwF/BnVtbkEfOfoqMTsor
X-Authority-Analysis: v=2.4 cv=Maxsu4/f c=1 sm=1 tr=0 ts=68493911 cx=c_pps a=S+bK3CcnjRkaVKfFm0nHhg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=RGRIAUP4iXkly6KwgWYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_03,2025-06-10_01,2025-03-28_01

VGhhbmtzIFF1Lg0KDQpPbiAxMS82LzI1IDAwOjU2LCBRdSBXZW5ydW8gd3JvdGU6DQo+IOWcqCAy
MDI1LzYvMTEgMDA6MDEsIE1hcmsgSGFybXN0b25lIOWGmemBkzoNCj4+IE9uIDUvNi8yNSAxNzoy
MywgTWFyayBIYXJtc3RvbmUgd3JvdGU6DQo+Pj4gKiBTb21lIHRlc3QgZmFpbHVyZXM6IGJ0cmZz
LzE1NiwgYnRyZnMvMTcwLCBidHJmcy8yMjYsIGJ0cmZzLzI1MA0KPj4NCj4+IFRoZXNlIGFsbCB0
dXJuZWQgb3V0IHRvIGJlIHNwdXJpb3VzLg0KPj4NCj4+IGJ0cmZzLzIyNiBpcyBicm9rZW4gZm9y
IG1lIG9uIHRoZSBidHJmcy9mb3ItbmV4dCBicmFuY2ggdGhhdCBJIGJhc2VkDQo+PiB0aGVzZSBv
biAoMjU0YWUyNjA2YjI1OGE2M2I1MDYzYmVkMDNiYjRjZjg3YTY4ODUwMikNCj4gDQo+IFlvdSBt
YXkgbmVlZCB0byB1cGRhdGUgZnN0ZXN0cywgYXMgYSByZWNlbnQga2VybmVsIGNoYW5nZSByZXF1
aXJlcyANCj4gbm9kYXRhc3VtIGZvciBOT1dBSVQuDQo+IA0KPiBBbmQgZnN0ZXN0IGNvbW1pdCA3
ZTkyY2I5OTFiMGIgKCJmc3Rlc3RzOiBidHJmcy8yMjY6IHVzZSBub2RhdGFzdW0gbW91bnQgDQo+
IG9wdGlvbiB0byBwcmV2ZW50IGZhbHNlIGFsZXJ0cyIpIHVwZGF0ZWQgdGhlIHRlc3QgY2FzZSB0
byBoYW5kbGUgdGhlIA0KPiBrZXJuZWwgY2hhbmdlLg0KDQpNYWtlcyBzZW5zZSwgdGhhbmsgeW91
Lg0KDQo+PiBidHJmcy8xNTYsIGJ0cmZzLzE3MCwgYW5kIGJ0cmZzLzI1MCBhbGwgaW52b2x2ZSBj
cmVhdGluZyBzbWFsbA0KPj4gZmlsZXN5c3RlbXMsIHdoaWNoIGFyZSB0aGVuIEVOT1NQQ2luZyBi
ZWNhdXNlIG9mIHRoZSBleHRyYSBSRU1BUCBjaHVuay4NCj4gDQo+IEkgZG8gbm90IGhhdmUgYSBn
b29kIGlkZWEgaG93IHRvIGhhbmRsZSB0aG9zZSBjYXNlcy4NCj4gDQo+IEUuZywgdGhlIHRlc3Qg
Y2FzZSBidHJmcy8xNTYgaXMgY3JlYXRpbmcgYSAxRyBmcywgYWx0aG91Z2ggc21hbGwgaXQgDQo+
IHNob3VsZCBzdGlsbCBiZSBmaW5lIGZvciBtb3N0IGNhc2VzLg0KPiANCj4gSWYgZXZlbiBhIHNp
bmdsZSAzMk1pQiByZW1hcCBjaHVuayBpcyBjYXVzaW5nIEVOT1NQQywgaXQgbWF5IGluZGljYXRl
IA0KPiBtb3JlIEVOT1NQQyBpbiB0aGUgcmVhbCB3b3JsZC4NCg0KUHJvYmFibHkgOE1CIGFjdHVh
bGx5LCBhcyBJSVJDIHRoYXQncyB0aGUgY2h1bmsgc2l6ZSB0aGF0IG1rZnMgdXNlcyBmb3IgDQpl
dmVyeXRoaW5nLiBJdCdkIGJlIDMyTUIgdGhlIHNlY29uZCBhbmQgc3Vic2VxdWVudCB0aW1lcyBy
b3VuZC4NCg0KSSdsbCBpbnZlc3RpZ2F0ZSB0aGUgdGVzdHMgcHJvcGVybHksIGJ1dCBJJ20gZmFp
cmx5IHN1cmUgdGhleSdyZSBub3QgDQpkaWFnbm9zaW5nIGEgcHJvYmxlbSB3aXRoIHRoaXMgcGFy
dGljdWxhciBwYXRjaHNldC4NCg0KTWFyaw0K

