Return-Path: <linux-btrfs+bounces-11988-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA308A4CAEE
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 19:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAAD0188848B
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 18:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E6122D4C8;
	Mon,  3 Mar 2025 18:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HqSmzni+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1182E22C355
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026254; cv=fail; b=HQwzQJKUBLE+wQ6DU8cEBd+aZraEW/Gd85qUAcs+jka2XOSUyYFwwvK9ScppYK4qXsDWcylSTACq+2/mJ6Wl0z5EfPxvcDrLbrUFWiBzee2Q1zcuzx9cFEcgY5HpTycy4NgaUf7aojgb9OdSUkyxrTi9tfO2Le9+qEJv2oOFIzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026254; c=relaxed/simple;
	bh=8OHKzxpr1pkPPXxlV1wUJz3xJJ5mU6o2qEAgsKTErFY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=UEJ6j3oEymyfeiCd+OYi1mAofPfuPLJz7QEEjFuSt3+j0bI/pnF9SVa8J2NFWDSHL8Vikg7+in8r3QibSA5HKDEpzvubpKZDoRp2OeI60jDaaAdUv7jUldvL2Sn+PHZkWyWuE9CpwxSjQ7CrAor7VZhABJ4jXuhd54LG85D2i+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HqSmzni+; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523IBTbW027968
	for <linux-btrfs@vger.kernel.org>; Mon, 3 Mar 2025 10:24:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=8OHKzxpr1pkPPXxlV1wUJz3xJJ5mU6o2qEAgsKTErFY=; b=
	HqSmzni+GWRere1wsYUCY+fNZCQ23Jg0DJZuq0JMotpc84s7pz4pjlWnbWTQyunO
	cj1ZbCamjz9FIxTvDBRPvcYtGzeuxjMlQotDHcIJcipMUylPjMkBoDeL3+967iLn
	LQsdf3an5frI2/rwXihuRPw91guUIWcwEzgN/M2fei3OjgIdrunNikvUiioxNy5m
	o9e4/GAdRRFDu9Z7FiTj1VKoWSXAR0v6x0Dv+V0ktnSgqhORVDQJFMkpOTWV7q5N
	U8xoTCLQDFxc8TKrOBD/YqqBSadkq2vFXaOPl/t16o+e6pIq6BQ4BvCqS2yfuvzb
	J58L/WLJ1MKoqIT+Jdl39Q==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 455hfv8401-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Mon, 03 Mar 2025 10:24:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjRHK/HQ4+gb2Lk4f9YuSOTq4ZES1pUQb1Cro12HKL7BEqJVd4xTo4ESoX2mTu3vItgdCpLobahwND1cjYlFB9XlHWNoIrzXRWHelyUoLrMi6WbOuxgGeIlZPTOANqPNiP/tJPGWH78XTGmZ6fvoEe06zBoEqc8Yex9ku/23mXbzPemHnY8pYAnm9ZMp+dN4vc1l5yFv/QPRDZPTow0JtfYHvabtqgdQAByn8b3dHe3RaRbLK9Sa0bCR9mqY0ENB/1OpvITontk4Gskr8A5QxM0dpinip4KNMDB1riNwLND7Gd3quIw57Xf9h1hKYzd5MmnzQJMT2wmv46GHdX6YNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lQwuny+QKAlGa5+BGcZJz2PzAlJjnf/5r6V8kmFFsg=;
 b=N6ZoaadGVbJz0YD1u3vYbJkKade2xLaxbrw6S8yWEwIXmnku+drSlChYl3kswDsawAQnDEGJTCePqr3LyRlGqMipg6NStAve93lh+PeD2JuulR+dnqZzjsffAecBQ4MGhNuzrb7a38ptEkcgIXtkwcTlm1PmyAWCee+0xrtbvFH/4XRHyy6ph5pg7wkwWS5temzj0e32ptsrMYuhiL0AMcH4L61ml1jY+xkl0jpzRgm2V1w5On56MWQi2ELbE4j6MHZvw14vDqHtKne6eYAQQ4iNGCtLzqsjpbz4ZfsVPeQcT5qco1eeyit01HiyV6qc8aoXDqagIS1QDTCIVggybw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by IA1PR15MB6318.namprd15.prod.outlook.com (2603:10b6:208:444::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 18:24:09 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 18:24:08 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
Thread-Topic: [PATCH] btrfs: use atomic64_t for free_objectid
Thread-Index: AQHbbMivsPcQp6znhUC74MzCCLPe17NhX+QAgACZcgA=
Date: Mon, 3 Mar 2025 18:24:08 +0000
Message-ID: <4aa82ca2-6cb4-4942-a878-30c7bc7020e7@meta.com>
References: <20250122122459.1148668-1-maharmstone@fb.com>
 <20250303091456.GW5777@twin.jikos.cz>
In-Reply-To: <20250303091456.GW5777@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|IA1PR15MB6318:EE_
x-ms-office365-filtering-correlation-id: 8af32205-03f6-4bab-41c3-08dd5a8096d1
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SmpKd24ybHp3MDdkdFdxU2VacWdsTzJJTlkrLzd5anhrWjhGQ3lCOVhQUUUx?=
 =?utf-8?B?VHQ3TjlFU3FNeEhhLzE0cG1meHBhcG01dStVWCthaFR6aHpwM1JINS9vaVZ3?=
 =?utf-8?B?ZlNpWWo4UTNOQXVDaFZsck9pSVUvVkpFN3BaV3lZOGdwSWtoSUNNUEExNUFo?=
 =?utf-8?B?U09aWFVlY3J1aE9JSVFuQzFET3grMURuMnZaY29jK3NuaGF4Rkx2U2NBUHVZ?=
 =?utf-8?B?M3JsVTZXeWZnY2tWMVpKUHpxOHhJNDdna25yZktSRVkwNURRYWk3YjJsSUNJ?=
 =?utf-8?B?Zi9DTmcvdWdLMUdPSUZHSHFxWjVxQk9hVFFna3ZjbDI2Z3hsUXlmOXhhWjBx?=
 =?utf-8?B?V2VVVXRpVm4rVHNQdjMwZmcxSkJlWHF0UjA1ak10ekUzdmRDM0pVYldvdVl4?=
 =?utf-8?B?NWVkZEcweTdKZ0Y2bm5uTWxCYVpHYmZIamxDRUFEQXUrME9kVW02Y1ZieWpw?=
 =?utf-8?B?cHpzdUZpaHdwQmwwMlFWZk5YNXBMaXoremxuZ25kSWxNOXFVWmtJV21kbVJw?=
 =?utf-8?B?WHBpWEdCMGpRTk9WSDB3c3dmVU40NmYwaGlvdHM3eDNBNnI3cFBqdDJPWGxD?=
 =?utf-8?B?aEVaVkk4eGcvak9PRXo4NW84enNQVW9xUDhFYnE0eENkREJOZkpDdFU2ZWNH?=
 =?utf-8?B?aC9tcUVkbklweEJIMGZrdkJSb3M3RDYwdlphWHlBaGVURy9xVTdvWHFHRFRW?=
 =?utf-8?B?WkFBYk1Mc0RjWkVXcXJrV1VrT0JKTUM1M01WNzFuc2RXVUdRQWczekdTYmRp?=
 =?utf-8?B?UzRrOTU5UEs2Sm9xbjdVTnZnREdyZUoxVlRjUDhxcUQzdUxWTFVNUDBXWEhE?=
 =?utf-8?B?aEZ0UjRYMDJzZ0RrbVBJVWFHQmsxSlJ4UXFabTFGRDEzdDY4VFFvMHk3Unpp?=
 =?utf-8?B?WDR6QWYzZWdPQ3pNY2ZpSFBKYWtWdUNlNldlRFM0NnI4UE9lOTlSbFNxd3Ft?=
 =?utf-8?B?SEtHQytydEx1QnpkWGpIaU9zc0wwOXFDLzRYYmhOU3dHYU5EbUhocW5WdUJS?=
 =?utf-8?B?RjZ5Q056YzE4Nkt0RzBWQU1CK3FoYXdCVkp2QlRaeElwbFg3d1NjZ0hjWTZx?=
 =?utf-8?B?Y2M2QVBsaUgrRWhoSitXLzFiK0srZDJUUjJwSVRrb1RueENzYjdqYzgyenlT?=
 =?utf-8?B?NDk4Y1Y1SmIwb3pETmdiNDBMd054SDR1dUlKYmZ6M3Y1UmZib0ltd2NPVjlK?=
 =?utf-8?B?emxBd29KR21hSEhBWGZIOThSaDQwOHNZT0dnMitkU1hhWjI1WHBGMVdUQXpz?=
 =?utf-8?B?T0ZNc3VMaGR1ckN1RUUzSkt3S2hSQnJ1ZjF3Qmk3YVNNR2tBSVlhcUc1M3BG?=
 =?utf-8?B?ZXRwaWpzRFJyTUJBT2gxQXRVdzE1MG1YOUJBU0VEeUEyNUVnTjMwUE9peVBP?=
 =?utf-8?B?VXlrWjhHMW1hQnNPdG5kTXRxNnNSWkdhRmZaczA5d3M3SThlaWUrUGExL3I0?=
 =?utf-8?B?ZzR3emx4MmhJQWFWZSsyYzB5OUk2U1pEN2NaYWRETHRmMFMyd2RXUCtpcFk1?=
 =?utf-8?B?M21oYmJKSXNIY0Y5eDFNTkNJN0tHWWRrY09hM0duU1hrOHNmenNSdGVhVXRy?=
 =?utf-8?B?ZWpOaFZ0L21qNnF2QkdPL210cmYxellKSWlzcXhVSVBLOTlOVlRiUmpUNzJL?=
 =?utf-8?B?anBSbnlPcy83YXJDekwreGZzRVlQUE5lajBLRVkzUzFrY05GK3p3R0lyZ1hu?=
 =?utf-8?B?S1EyOFFPWElES1VySEVVcnMrWmpFSUhVdGt4QW5tTno5b1A4ZkQ4WWc2NTFo?=
 =?utf-8?B?TDhxemZad3Y4dDZHVytsOHNaa3RDNGJmVXo0UzNNN1dCSWNtUWk0cFB5NWta?=
 =?utf-8?B?UWtteUZuNE5xTWtOZFNiRFQrcUszZ25vc2cvRkMvTXhiSG1XT1ZVYUJ5QWhW?=
 =?utf-8?B?Vm1rRHYva1dXMmNLbVVnS2tHRXNNc1dDTUtrSUlITndFMDJXNGJnQUJRY3Fr?=
 =?utf-8?Q?wHDPBjG9tu4zJvH2f+F3p74DnKQk8Wig?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlVkTGJMVis1VENNRC9Xc1ordzUvSFBPcHNFSkZ3dnArT1BBVnpCQU5lcW1y?=
 =?utf-8?B?Vko4NXd2N2NEYmtaYWJzVjYwMnlMNXB3UURKN1A1YktIT0lBRnF3SmhCaG9q?=
 =?utf-8?B?SlVNTjdUemZCK2l6R1V1THV1dkN4NXNNUnF6SHd0WXFjZUZtVUhKMFFveUVD?=
 =?utf-8?B?aitRUTZkY015aTNoUTZha09aMEdqZ3VpMTdvY0dvSkxUbk9pZGhLYk83dVhl?=
 =?utf-8?B?ci90dzlOQkJIY2dQN1k2c3NUY3JOZkdGL0lnRHNsQXRFcWkyaE5iWUhVN3hH?=
 =?utf-8?B?ZC9ZaUVFNUsxa2huS1J3bG1ZcU5RZnhvczBQV0JoRm51Y2IwN1RZN2pacG9z?=
 =?utf-8?B?dU1veGhJTnBjbnhTRjIwOENHNGQvZnRBNlJ4UVJkMnJGSDFKdWJKdlNFTjls?=
 =?utf-8?B?a1phODhSbCtTWVl4UCtkY3RsRnBZclp4cEthZTR3WnFQb0tWcUJZaHJ0ak8z?=
 =?utf-8?B?NEYrNzZPa2RGdEowRERWV2Z1ZVcxTFhING1Ddk1xY3FpeStSY2Y1ZTNicEdn?=
 =?utf-8?B?dzBsK1RHWGpuTnVRQnd2aDNPcTErWEVJbGhnNFhmRzg0elc2UFlQZGpIaHlu?=
 =?utf-8?B?b2xEMnp0VGVKejloS21yWlVlOG8wbm5KRVdOdDU1cmozMXlRZ2xDOWMrQXFx?=
 =?utf-8?B?bGlRYVBUMHJLVXpNZWM1TUV0bVJ1MDJhYkZ6ajlveDVtWHFQYnNON2xzQ0g0?=
 =?utf-8?B?djUyNkFSYjVWQ3A4NjFlZExTZXE5aUYwUDZPVW1iZXo1U2tESEYyaVVmcWtH?=
 =?utf-8?B?ZWVFc2pmQkJFNGZhSHZNbzJYaVhKRlc1VXpvZmxna0JrYUhMV202ZGRKbDRy?=
 =?utf-8?B?NS96ckNFUE5PeVhIKy9tMmtrNDcyQzYyUXFtVGpVSmxlUUhHZHlKK0pYSzg0?=
 =?utf-8?B?OFUrc0huZ0FYVVBUbzQwVkNxRmxqeUh4VGZVeFpuNTBSaFRjYW8yT0xxOGFi?=
 =?utf-8?B?Yzcxdzh6cWhGYWVoSWhSMnlsbE9PQzhZMWZHa1QwODgrZURjN0pMK01nNG0r?=
 =?utf-8?B?ejNuUUJ0Q2RDSkpETEdUMm9pcEdNS0tZU2REREQ2eWlrRi8zWXM0ZUcvUnRq?=
 =?utf-8?B?NGlZYlMzR2UxSy9PM2MvZksvc1FyRHBtYmFnbEVQY3FET3BVMWtyTjc0alRi?=
 =?utf-8?B?U2NnQS9OVnBGOE5OTVZ5eG9hZTgwODBWMndvaHV2d1FRS1lWS2dHM1J4U2I5?=
 =?utf-8?B?dTVsQU41LzhDUkFtQWR1Y1NpRWd2aEJwT0VzVkhTMWNUZEZCWDl1WEdabDNx?=
 =?utf-8?B?TDFMck9pY1JpL3Vsa0daS1JaV2E4UzlRdWlFVmh3U1RhUjRDQm56N1B0SnlE?=
 =?utf-8?B?alkxSzdLNksyT0d0MjNTVG1oZmtZU0dMM0ZVY000Smgxb1A4akNKRXZjQy9n?=
 =?utf-8?B?bjZ0Q2x0WHMwRkYyY3FrZmkrSVY0WGROdkdJeklYbTNVL3BRZnRPWGF0Mi9S?=
 =?utf-8?B?WFNUQkxJc0IwNGtGMzk5UEtaVis5c0FmMkxJak80SW1EVC8rRzhGekkvQXBW?=
 =?utf-8?B?VXl5akkzcmZDOEE4RHJrTGI4cVVMSU1nZmJLZStMRHd2Y25FSVBGcXkvKzBW?=
 =?utf-8?B?UW9RZ2NBbXFSU3hzeHA4NW56M3ltU2cwWkhUZHhIVHRYdW85UU5SMU5Ydk0x?=
 =?utf-8?B?NmpIdGZZdU1vYXF1NXJEQzRJNndjTGczNWpTR1g0VFI0Snkya2p1TmdFT2VM?=
 =?utf-8?B?VHpvWWFVeHN1VXlLcTN6ZWxYdmxuM1dqSEZ2aFZ2N3Zyb2xTVCsxMnprT09E?=
 =?utf-8?B?UUYvZHkwUnJ4NERmVjZMWUw0ZytNQzg1cGlvQXU3L2ZZNjE1T20vWFJ2Mm9y?=
 =?utf-8?B?bllrNTJXdzVvU3FFM1NaN2MrRkNnbUgxM1Y2dXlOWjV3b0ZPeEJIcElNRmg5?=
 =?utf-8?B?MEZkb0h0NW5ia3lXRUlqeFNvWVRwS2ljOGNpYis2ZWg1UFVGSHRuVVZJTlJP?=
 =?utf-8?B?SWRRM1F3d2dNdmNWMm5lbHU4eERzODBpb1NBMGxWdzRrWlBpMnpNWVZhS3cx?=
 =?utf-8?B?elVkRlJtRWNvSkV3NTBGQzFlV3pGbFpERHNiZmIwNFM4TzdFSXppWldQazJi?=
 =?utf-8?B?U2JlYlM1Qmo4WTVQaTdETS84ZzVJQS84V20zeXl3M3RaNjlmeVlyUFFtdGtr?=
 =?utf-8?B?TFZiNFpkSXBlRElKRWdKT1pQTGhuWlpjUHRIbUlkb2hSRjdRdW51R0JIZm90?=
 =?utf-8?Q?9kv6tsiNyZrlqSwvz0dn+VM=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af32205-03f6-4bab-41c3-08dd5a8096d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 18:24:08.8874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZhOavlSsq2OMFn9hzkQyP0/qDKZgg+4CH9JHrJz1eq2gvTFxASozXGYe8mLtzvVRv0m/t+XJJklb4e9LOHOP4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6318
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <60E24E8525256F46B3CD5AA24ED0B734@namprd15.prod.outlook.com>
X-Proofpoint-GUID: mc0ZsT7eozoJhCpKk6FPTO5hHTgNQ-gZ
X-Proofpoint-ORIG-GUID: mc0ZsT7eozoJhCpKk6FPTO5hHTgNQ-gZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_09,2025-03-03_03,2024-11-22_01

On 3/3/25 09:14, David Sterba wrote:
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
>=20
> As we've discussed the idea of atomic_t for inode and agreed this is ok,
> if you want to get this patch merged please summarize the outcome of the
> dicussion and resend. This is still possible to get to 6.15 (during this
> week).

Thanks David. I've added a paragraph to the commit message explaining=20
why overflow isn't a likely scenario.

I've kept the actual patch as-is, i.e. still including the warning - I=20
don't know if you want to take that out.

Mark

