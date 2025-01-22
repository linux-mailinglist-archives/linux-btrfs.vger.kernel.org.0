Return-Path: <linux-btrfs+bounces-11046-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C143FA19851
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 19:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5BD3A8CE4
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 18:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575B12153FF;
	Wed, 22 Jan 2025 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="IdB5cU2i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD6021578F
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737569980; cv=fail; b=GRn0j6UlcwZf7DjgQqWvUYvhyiCHc/eoVPXSal4sR0QdjHX68N58cDPiveetK2dJ8dMgMNR/rP8iAMIWchsaSDD7u5enFIMEgFodjHP7+BS6CfAM6GuiR5I3qXeyIhWNCpoDmEzJZs5Fvf2ewTqrtotDkn0joATgXJe1qd84zCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737569980; c=relaxed/simple;
	bh=4ZgVWWY+zcWVQwQpVjQJrkMWMaXemHRBoUbav0STaCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=OPFaD4IRnSDVlipkP7lRt2PSAn7ywRVKh7tkoxSMIsZM8nv3AfyBVAAtTWWzVoTrJGky+m7T3g1fmyuAchyJDgs4ZOpjGRlLDerAKYlAV6OBYa9/lBQlb5nk6LNi9av5cE7vo9O1qaQzb8n7S2DER/77N91Rd0NCdC/ckIWcyOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=IdB5cU2i; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MHxo8h025044
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 10:19:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=wJ9nJGqUXHMgg5YrWGoiVCZnDIYjquGK6wca2CLAk6c=; b=
	IdB5cU2iyLkXNIfMR5AbNoDDbwtsHJEw5aKZe6XnCNvCp4ilNMnlvDHj6oje5sXW
	1SlpFqK/qI1S0V1gQB3ZlRElX6V+v2K3Z/jSo5kbDJnXq8oa4Jb17n8bqGymr5Gg
	aqZG9NhtgwhZntiqo/YLfvyR3Arm30RRGoR0JOIfB8S504C3vEGzo5UoHLNVX/ym
	u8DVZqHh82JM7n+s/7jrDYFP5yhOJF7PFm3qjK1C6tFDvtNsEn4OmWtEkZ5YvFAw
	4qBrek+Z3avtvTPBlGXU+PckbMfjC0qZWW1/3EdYLGZ+z0qQnuXdhsa5CeYqadH+
	lL3yMKq06vMoX8xKRN/8lA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44b4c2grpf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 10:19:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnKiwnGGeihmPQYEp1p0ezvpXdKxpDa6pR2JZIY0WtapuDs/kwNXCejiH8vvm+4h3NJfmmpHaFkVNz3p/aNvvlZZDtq01VwAII01AnUzPzjisjQs7fZEzcxZpp9ZTZX0hzd4Xxjl8mEHkrX9T9sWnPon5wrp8dBX6zc6L2QpSHUTCcJRcAMGz37ML04aCHbxZ7f+HvsYVZs0NMvfUaBUBHES5rI2MvABr0T1cWfZ2arNA7U3jiKD7iO3lt/Yr6M5oyc1PbE5HC5YyzH3kmoJOp3KwOpuu3KMB45Yc/Yq0SqO/REvGyzXCabS1GsfrCh70Z5p0xfMu00Ve0avfJ3BeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqVN4cj+VjFMIP2VD1xau8hXeXGoocpE/H+0NoopPos=;
 b=f4kcfXHI73V3CpWGuIEfyIlC3ZV1O0a1+k5zy77FxXZrOxlut3Fy322l+Lpy5X00XNeKY6D2GSKfn/BI/jT2jt3/IsLjdwlt61rnR1jxOVw02WalzI2v0ii+OwJSwI96z4YAkgidp4Wi91eKyfs0vshj83RUFClthqaSAl1h3nbdewphpYvn3WMoMc/D7k+PXRvOf5f0PIJ8cnjFANSdIsvH9Fug94Mw3Ieuon3zLPM0rAv5VzoqSE6cprPYXEuLUTh03L9+rQ2LTf7RAj5g70yjVmwTdQgPRbFY83eeuWYmgkHag0Z52+jqKuid9b8GtyLjSde2kC9iXmJGUYX81Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by MW4PR15MB4617.namprd15.prod.outlook.com (2603:10b6:303:10a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 18:19:35 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%5]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 18:19:35 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
Thread-Topic: [PATCH] btrfs: use atomic64_t for free_objectid
Thread-Index: AQHbbMivsPcQp6znhUC74MzCCLPe17Mi5T2AgAA1kQA=
Date: Wed, 22 Jan 2025 18:19:34 +0000
Message-ID: <cbb47129-294c-452c-af9d-951d8e644292@meta.com>
References: <20250122122459.1148668-1-maharmstone@fb.com>
 <20250122150751.GH5777@twin.jikos.cz>
In-Reply-To: <20250122150751.GH5777@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|MW4PR15MB4617:EE_
x-ms-office365-filtering-correlation-id: 280a0326-8aa5-4e71-d9ad-08dd3b11530c
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZTl0blkySjE2MDdhZ0kyYmlSZ2JjaGdWQjNjNmlKbjZtaXpUNkJrRVl0d3Bn?=
 =?utf-8?B?eDdLbXZEYXNQRkV6ZU9FT3Z0Sy9sUlNmdEppeTE1dG5uOWlwQXhZakpsNXU5?=
 =?utf-8?B?YnNyRWRKaG9tbGpNZVlMZ3ZCaWx6a05NblhXNm5tUXVmZnNsVlRjaFNqa0Mw?=
 =?utf-8?B?RzExdnNJOUpjM2xZLzNCOUdYd0lucmdLY0dzMkt3S05zdml4cHE5S3ViRjBn?=
 =?utf-8?B?ZFI3MVMvVmtZWnhXWlRnREFaUjFlb3MvaDFyakZkVy8wZXBJZnVXUnZVbXI2?=
 =?utf-8?B?dVQ2cERldXpLUlNjMmdFS3BEMEd5RndEUlZ2NWY4Y1llOGNtL3p4V2lKUlNy?=
 =?utf-8?B?cExYS3hkS0dvKzFyOWJYL3FoWWNaZExJSTdVeXdnblhXa05rODJYb05CQWwx?=
 =?utf-8?B?VXF5dENlbWFiS2NxR2c1bWtWRWlLY2Nob0JLYU1XTnJsVGdoQStNUHF6aFhh?=
 =?utf-8?B?YUNzbVFYZU1MU1BZKzNLOGJoRVFUQjluL2IyVUtQZ3laZ3d6MTArckpaZmoz?=
 =?utf-8?B?dUwzcWVtcHZMM0ZPKy81SGVRbEdMZ1NPVnlvdlBNb1RaRzRXM1gyaGhTZFF4?=
 =?utf-8?B?bDlVMi9FdnpraVA0N2RyVDdjZzNURVBtU2dzbVQwRnd2cm9kUE51aEsvd1FR?=
 =?utf-8?B?a09mWGEwN1Q0aTJFVFB6RVdSaFFQeFhsY1FSazh3ZVdnUkVEUlVaYW50L2J1?=
 =?utf-8?B?aGV5TTNkOTRQMzBBVXMrNElDSWs1WlFmT3RRb2RoSWJXaGRNekd1SnJsZGxO?=
 =?utf-8?B?eUR2L3R6Y1lBK09SVXRFV2NXVzlNMmxtSFRvUk1UZDV6WWlFWXJyc1A1a2Jw?=
 =?utf-8?B?SGRsUytRYXBsay9rQU1NbEtFUEZDOUtQbnNoMFJPY0wyTWQyZXFvZEJhYXc0?=
 =?utf-8?B?ZytURzZNVGoyaTkrZlp4L0NYSWUyVmI4bi9MRmpsNkNJaGwvMmdod1VESXdB?=
 =?utf-8?B?bEZyL3kyUjlyb3NPZyttZmhqcm1ObjdLbGRRSXBTd0N3WmQ4L1BsMTV5LzQ5?=
 =?utf-8?B?N1pxL2ExekRmTVV5L25ncDRmMmN4T25SeFVuNnF2RW9LVzdSVXgrcnpmUk13?=
 =?utf-8?B?aFEzMXd1b1JvaDBudUlseFFlNlZDNXFUMWl6RWpIc3BBSmN0ejA0ekkvWS9V?=
 =?utf-8?B?aDdJdjVLT01XemRDL2JhVGtoaGFTSEJsRFU4TzF3WjIvZXhIUGM2bzk4dmh3?=
 =?utf-8?B?bXRDT1NNLzZNaXd2TTFra25GeG40WVdVaWc5QTBocTNqYXZOakZEeVRTck1u?=
 =?utf-8?B?OEh5dmxRL0V4b3o5WExaNndwQlZSNjhUa3drQkI2Q0NNcURmcFdURVlFMzZY?=
 =?utf-8?B?SVViZitTZldYakFCK0c2Y3NCcUtvQXoycEYxTnQvbk1ydXZRRkVQVUJydktW?=
 =?utf-8?B?UW80MkVCQnphTnlzNkIybHRyTmNIWS9NeklvNG5YdHN6YnhUZmZ4T1NuQjd2?=
 =?utf-8?B?TlJtTUJPWXVoR1QxN0V2WDF6MjNrR215eHJwSnRYaVdYN1lUaE9FRnFIYXVB?=
 =?utf-8?B?WjlkS1N3UTZtc2hhZnhBRHlVSlZpMU5HQmJ5cnBoVUhjVjJGSXd6TElzZFQ3?=
 =?utf-8?B?Zm1RU3M3eUVwMjF3UitVRUYxaTk2UFE5eUpmblluUG5sNGFhbm5SbnpRZ1pK?=
 =?utf-8?B?bmxLaDNaOFVhaTRPVkg3UEJDaXZrbEttdkwxN0pPVGFwVGRPNHA5VzV0dFc1?=
 =?utf-8?B?KzBTQ2hkcGlsamVrbEljV2QyMHFHRml0Smhkdkl1R0U0RlowVkN3TjBYZzI5?=
 =?utf-8?B?bndoQ0lEcUpqc2l3bW5uQXZxemdCUUo4U2ZxTFkwVlM0SjhuaVF2QUcrbXFv?=
 =?utf-8?B?ZWFKaDFlQmQrWDYxeDZIeGVZVjRXeVZwUVR5Mkt0TW1CNHVQeE85VlFjOFk2?=
 =?utf-8?B?UVdlMVZOeTlqQjNyejUzSmlwNVR2Q29HYTBVcVhyMmJhOVpvWms4OGNuUkZX?=
 =?utf-8?Q?147hxXH3Va+8q1eZ5AC3pFIjAafIkqBm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzExd21KRGw1bXNXeG0yWjhDbC9Ha2hybGlwUUdnZ2tBU1JtdXEwQ1hWclIx?=
 =?utf-8?B?bVh2blpLWHNudDNKc1RDcmRkcldTRFI4ZmtRb1NHUEtyMS9VQWJmeXVUYlVN?=
 =?utf-8?B?U1pFUkEvbS9RcmloL2Z1MHNQZXVWMmVSclNGb2tUKzdYWVBoWnFrOW9lczZ2?=
 =?utf-8?B?eTVRaXk4UzFYVFJlVlBYWFNtbGlEM2p6OHdGVkNnN2YrWDZZY3J2K254dDZl?=
 =?utf-8?B?K2NOTFc0T05JZVFmbEU5SUUrTXZsejc2L2xDSjl6cVlvQ29zZ1dMYzkrTUZV?=
 =?utf-8?B?ZUkyOGxKVU5WRFNabjBRZGNPQjMrd044RTZ2UHllVUJlVzVLU2tqaDQycUdF?=
 =?utf-8?B?NnVLV2xkYlBFMENnaGRySFNuQmZWZW9lWU5SMEt4d0s5R2FaY1A3bWpLRXRX?=
 =?utf-8?B?V1hqem1NUTI1RFpvWDNaNzJnRUMxRWhvN3ZSMCtUZ3Q5VmtRTlN5UmUwdGVi?=
 =?utf-8?B?bDN5dkxBUkZnd2NQVGVJRGppL25DVVA3WFlZcFE4aXorMlAzOU52alhhNG5h?=
 =?utf-8?B?bkZlOTNjOGJOaWxzQ3N2RVIwb3pleXlaQUw1bGdZKy96VHdScnJPNk4yWGNW?=
 =?utf-8?B?UU40TGk0WElVNkwvTnF2eStib2l1dDBXMnByVWNYS2N6VHlSMVhKYSs3Ymp4?=
 =?utf-8?B?YmN0V2p1cHY4VE83TE1EMnZNS3BHZmNzbHZDVEV4NW5kdTRzNzhBbGhYUWlv?=
 =?utf-8?B?OCtiaUdUMGRrRERKb0VhZ3VmaXNWZWxIOU1zS1RxVHA1RlJqTjdBeTlBNW1X?=
 =?utf-8?B?NXdvS2JyN1FXdVdxWkt4ZTN2Tm44TmVlQWhRYUFOcE5EckJlbllzYU9CUEZi?=
 =?utf-8?B?WHYxVkhaN0NlTEFCNnRYelYzVnMvMmFZYncvN2s5MC90Y3ZYTGJzeW13d0l5?=
 =?utf-8?B?dzcrYVdmdVpWNG93N3grSlJVVmQ5RVQ4SkhQUFhuMmY3cVFSOS9tRDQza3cz?=
 =?utf-8?B?ZGhXK0t4NnpOOTRIYUs4QytMdTA1Q21yQW5NRU9DVVEzbHM2enlGM0llRkVk?=
 =?utf-8?B?OHVLR0dlZkNLZFhydW5MMFpHVGtDT1QxdzVEczBFcUhPamtiRHI2b01hMk1s?=
 =?utf-8?B?R052akpOWmxGckUrREFvUDA2UHVjODcxazR2ZVY1eE5yVTNXcDFzNkppMnp3?=
 =?utf-8?B?Z1cyczBhK3ZocDRId2s1SVFSb0JJbCs5TVZ3Mm56LzRFYVVCeGhPOStVNytO?=
 =?utf-8?B?aDg5aWJRRU5RZUhHQWl2QmVnMVZBWU5pVzdCNTl3TCswZWpuUCthM1lyQWVv?=
 =?utf-8?B?T29BQWs3Rm9OZllpY3pibWpUaDFEYnFPUmtsMnRtL0QzMmlJZXFhdzFJb1Z4?=
 =?utf-8?B?aGZkRVpESTMya1gxVTBFcUIwbDNPQWRDOTVPRCtRb0tyTGc1dmJoaEUzcHZ0?=
 =?utf-8?B?OUpiTVlkaFFWS3R6VnhPVng0OEF6dURoTmZPZmFtZU9zRlJMMk4zUlRvdkFi?=
 =?utf-8?B?M2NGWVBIMmhzUlhRRG9JYkRFZGVRVkV0WjlOVDA1RURVSG5nTTBTTlFqS0dS?=
 =?utf-8?B?RlpMWEJlcFFWVkVDTk9Lekw5Z0IvYUM0WEZwU3ZvMURiV09iVlVPa1QwSFRs?=
 =?utf-8?B?MXpiRSszdUgvMlp2Ly93M0dYelBRN0lSYllFdDRsWEJtU1lxbWNKWkxVT08r?=
 =?utf-8?B?c0wyUUZrVDBTN0ZXT01hUEI4Wi9ZbENZdzFPVTNwVDZnQW5hMzVLakt1bDlI?=
 =?utf-8?B?YXBiNEJIeEY2bXJUMlRjT2NPUGlMZFlUbFBQZGNOM1FXT2hta05SZmJPcUpF?=
 =?utf-8?B?akUvWGtpS1ZsWVVjR3pHZElpbGRGNG1QMTZXSGRNZTFqT1NJak9iWTNJRk93?=
 =?utf-8?B?Wm1Oblh2dkRZeHREOUZoN1JyY0xGRjVvM3pDaXBrSkdKaTgvdFVuc2dFZksr?=
 =?utf-8?B?MFNROURJN056S0JxZG1pTGhIcXFidjZlKzd0ZHV2MVpuVzdkdDQyUm5WZzBP?=
 =?utf-8?B?Y3hSZU9STTBUNWFGeDAvTUtGOFYyZTUxL2VMKzQ2Zi9nM29lY2VGa2RreTlZ?=
 =?utf-8?B?SU56cEdIaC9yTE5CNVNWazBHTmdwRUtVd2NHZ0FSNDg5L2Z6UmdoNWlWYk5K?=
 =?utf-8?B?aGNjWU1MWXE2RXJwVzNkYTV5MmFCUUZoSFh5MmNMcnprQ2g0bHNDL0FnMjdD?=
 =?utf-8?B?a3RBUzMyZG15enEyUzNkbU41QkZldkZiUGRZR0RuVmZMNWNQVGplNWZqR0cr?=
 =?utf-8?Q?eaoqPg6I/xd16rAgFGMvRQc=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280a0326-8aa5-4e71-d9ad-08dd3b11530c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 18:19:34.9984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3oIUdMWmftdighxkvchhBTLfDka4OKvBPjOd1BH8K4V6TLMP6ZEKGQ5m7+IKZAHE4SYDfNZBxIRy4Uyobuthg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4617
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <E265904EC1BC39499ED1D2C39E8FF849@namprd15.prod.outlook.com>
X-Proofpoint-GUID: xcXK6KUYZB7rU7ZNEfGkLlBCz260smUY
X-Proofpoint-ORIG-GUID: xcXK6KUYZB7rU7ZNEfGkLlBCz260smUY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_08,2025-01-22_02,2024-11-22_01

On 22/1/25 15:07, David Sterba wrote:
> >=20
> On Wed, Jan 22, 2025 at 12:21:28PM +0000, Mark Harmstone wrote:
>> Currently btrfs_get_free_objectid() uses a mutex to protect
>> free_objectid; I'm guessing this was because of the inode cache that we
>> used to have. The inode cache is no more, so simplify things by
>> replacing it with an atomic.
>>
>> There's no issues with ordering: free_objectid gets set to an initial
>> value, then calls to btrfs_get_free_objectid() return a monotonically
>> increasing value.
>>
>> This change means that btrfs_get_free_objectid() will no longer
>> potentially sleep, which was a blocker for adding a non-blocking mode
>> for inode and subvol creation.
>>
>> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
>> ---
>>   fs/btrfs/ctree.h    |  4 +---
>>   fs/btrfs/disk-io.c  | 43 ++++++++++++++++++-------------------------
>>   fs/btrfs/qgroup.c   | 11 ++++++-----
>>   fs/btrfs/tree-log.c |  3 ---
>>   4 files changed, 25 insertions(+), 36 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 1096a80a64e7..04175698525b 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -179,8 +179,6 @@ struct btrfs_root {
>>   	struct btrfs_fs_info *fs_info;
>>   	struct extent_io_tree dirty_log_pages;
>>  =20
>> -	struct mutex objectid_mutex;
>> -
>>   	spinlock_t accounting_lock;
>>   	struct btrfs_block_rsv *block_rsv;
>>  =20
>> @@ -214,7 +212,7 @@ struct btrfs_root {
>>  =20
>>   	u64 last_trans;
>>  =20
>> -	u64 free_objectid;
>> +	atomic64_t free_objectid;
>=20
> Besides the other things pointed out, this also changes the type from
> u64 to s64 or requiring casts so we keep u64 as this is what the on-disk
> format defines.

It does, but there's casts to u64 every time it's read (which, asserts=20
aside, is only in btrfs_get_free_objectid).

