Return-Path: <linux-btrfs+bounces-16794-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEECB52FE2
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Sep 2025 13:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A13B1CC0795
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Sep 2025 11:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E0E311974;
	Thu, 11 Sep 2025 11:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f/5+SW5T";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aSDJdQlf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727E22D130A
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Sep 2025 11:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589188; cv=fail; b=KM/9H0ow9cHZLvstNeK3CETkuiqAFR2oQ7MWbuOBeKyfvQ5SJvuYimBwx+VJ342Lsb/gXKr3Fqtc14QUco4ww9I0NCw0VDK8u9MTG7XOxwUkeCFSJOuch/QD/TsFeQxBWVXvU7w2NXbEE0WJ5F+JA4CIlLAQ9d86bElFPorbXVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589188; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sy964R9Kt5AleC9+q37Po8CTETuqVMWyFXjalid08oeQaO33/sq0UUqDVES7yUpwyoroeUEP+FPw18/t8ML0XYQVYp+Mpkd5agzVM4U6+3/+xAW5k57CcBsfsoV/JCBJZd//zla4WjFwQeMglKq6d+AZNHa72wqQkRkSwPE3LSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=f/5+SW5T; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=aSDJdQlf; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757589186; x=1789125186;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=f/5+SW5TTJQIg1PEI26atAmZO9rHdwzs+hNZucX4+A8GBkZ6jkQg3nT0
   12Tybb1YBqcoO24L7rbb8yb01tmuGi3+OYu9arZWGyJUuvAKlDW5oJGV2
   dqz+fT/G7T7DHUfPMz9dBBJIvlSizlhWG0i0Cmg6eH6AZLiKSlg75ieIw
   itkyfG9Gfl0rqZ33+k0PoApctFBWpJ6g9VkjKmClgdnvc0JkAf5SDbJZ1
   jCCXJHtZgG3BDLau8Xyad/iNvamNs/RiVCqZrxUrLQg/hnxjjPI77YQGi
   o9A1j4LaCsAwzW4MzeaWfRp6TyHIv8jfCdnuk9P0Lz82pPItyqzVJi/t3
   Q==;
X-CSE-ConnectionGUID: bFgUdwScQMGdJ9Er/X4DPQ==
X-CSE-MsgGUID: jzFE7WkTS+eZbRsro05b4g==
X-IronPort-AV: E=Sophos;i="6.18,257,1751212800"; 
   d="scan'208";a="116573822"
Received: from mail-westcentralusazon11010052.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.52])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2025 19:12:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKl07M+zpx0oZEUE+c2vgv+jjCXcth7EEHeLh2g+HxOjstuNsZuraW3lH/hwI1SnIrV3BAFsVCkYuPKP8+4O1gf/4emYYWuG0ePNLojeScmuJeKTj/vgIAeGH7jeBweREC0Pkf8E54cyXmxniXHQIGyONnYU7iLSqVGiurSade7iUaQnGHZaKhUO8fVHJWqgErLY3xr3yZv6tCctWxhF8dEbRDs5FEY4ac7yf4NGpc1xDFpXmU87K7DCFVBn+2g5maNxnwVhDenKz5IMkJ1yqukA8noDxKfWzS3KOdPHN8vkHimFQnz8L1/KjmKfyH72ZMmNA9BVVlAtU6Jh2ZY9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=NekEjjZewF/EXqS5TzoYEl9qvwlsF3ShaFULVsvdiz/8HWSOUpCP7AeIE1w3LbHCuaP8JxwiOAeLID58GRp4OcW7FRIS+fXM9f2o8lQy6U42GPuju6RCywssAv/DGPMveUMWesGzkFan1hGoBUtxySL+IIj4Mn3Pp8+iybDI9AL3xoIh6utCqzexrUThxGTSLGb85weYsCMV8cusNgTLZjwrwF/fbAgAcKQ7VyrrEMYmUHdS0h170+IcKjJ9XSlUC6gAMBR1bl6bnoh07Z8I+DJ3WDsOEOcDGamK0d/Z65laqHlsDrz9YMbIol2bBnhuIxSfNonXcxIzr+Zgmoa12w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=aSDJdQlf7hd08tTYR+JCLpIGaqKi9n97B5533gblsZGmFSH6AnD3+Qq2df6IMAms72GZHoY2q4qcEkZkXpaTc9aiVmhue86kWJ6FOk9JNfugY/QzHm5oyS8PCcuS3RQ0QQlbIzAYwrMgMmUmqtGYC/rLOpMJ70GuXrBAbpBDBiY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8093.namprd04.prod.outlook.com (2603:10b6:408:15c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 11:12:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 11:12:57 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: annotate block group access with data_race() when
 sorting for reclaim
Thread-Topic: [PATCH] btrfs: annotate block group access with data_race() when
 sorting for reclaim
Thread-Index: AQHcILjzexoHn1waxkKXG55/X2EMJLSN2JmA
Date: Thu, 11 Sep 2025 11:12:55 +0000
Message-ID: <994cc4ee-7b30-4a52-a3df-caa671031605@wdc.com>
References:
 <456b17e9620d5118fcca2674b365e0770b1d1fc1.1757332833.git.fdmanana@suse.com>
In-Reply-To:
 <456b17e9620d5118fcca2674b365e0770b1d1fc1.1757332833.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB8093:EE_
x-ms-office365-filtering-correlation-id: 877f611a-04c6-418c-ba54-08ddf124285d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dU5ka1h1ZTRuTytSQXF3NTRzdmxVZ2lEREVpd1Njck1DbjNiZDNHejUxTG5Q?=
 =?utf-8?B?K2hiQmtySnpDa0pPVzlaemdhUkM1eDV2eUVUSGc5S012MHpPQ1ZJRENiMG5F?=
 =?utf-8?B?aTFIWDN4Nm5jWlpuSjNXYzFaL3gvdXBPVGN6VG9rU0RwTFZDUmp5M0hqbjR2?=
 =?utf-8?B?YWY1eGNwZ3Q4N1RqYnplU0RrTUlBMUpJUk8zaDJCaG1VaGlpcW1GcUd5NTU2?=
 =?utf-8?B?U2ZYMkQ2eG5vMDNPR2ZkbGFidWZUY1Y2UERlTU1JS2srenQzMUZRUFEzZ2hs?=
 =?utf-8?B?RU9jbVc5c2NYcGorWVErUnFqbkdPUlJXYXJOMERnVnljMTVmSmlFS002aFFB?=
 =?utf-8?B?WDFVS0xCY3ZiZTM4cTNiREtGTjFKRmVFcC9sMnkyZDBYODVNUXhIZVhlOWww?=
 =?utf-8?B?Y004UWhBRW05SGQwcm5FYjZmcGFIazZ2aXBtbWNjejgwNEEwZml3ek5xalYw?=
 =?utf-8?B?aXMvOFBqcUVkL21ORkV3dUlhS2JZMW9uUDJJQUM3V1JyNklnY0RkaXYvQTZO?=
 =?utf-8?B?RXVTM0VTc3hSQWJib1Q5QnRxMzJLMGJGVWc2ZFIyMm9jMVFEMkFKYUZsZ041?=
 =?utf-8?B?L0lMOXlWMUhZUHpkcWZ1OUQ1ZVdTRng1Ny85NHZoS01NMG94cHlxMVhOSEor?=
 =?utf-8?B?TDFyNDcyeitzM04zR2t0bW85WTVSVjFvYUtWSFRwaTV5V2JGMWFGemtoekJr?=
 =?utf-8?B?YnpKMjAzcWFLT2JESGpyR0lyWitKN0tTSWsxeUVKSFpLNWJGTVdzWEg2ZHhw?=
 =?utf-8?B?TmhxT1hRZzQxUjlVMU83aGhROFZacDAvRVdIbHA1OE1hWGd2SmFaYWJxanNG?=
 =?utf-8?B?WXBhTmFvbUpMZzJXVnl5cFlUb3YyWGdMbUliVGZXakZ4alR2ekZKTkk5WFFq?=
 =?utf-8?B?MmUvSDRuanBDUnRPSG0ra0piQlc0SFpvZm54MTBmY0tVS1dVQ0dUNGMvTmpr?=
 =?utf-8?B?MFQwR09XbzIrV05jc3VPVXdicW9qNTNJVzVST2tlZXFRSE9sV3U0Ukg0ZUxS?=
 =?utf-8?B?NlBDblEyTE1ZWno2ZHNzZWpJYldreU52aVlHYUFLMEJUN1JKNTd4UVNkdnZ5?=
 =?utf-8?B?MlJwdi9ML2xTM0x2OFJTRkcrWFBBVzlYaCsvc2ppTTFhbGthT3d1TU5yb3g1?=
 =?utf-8?B?VzdSZ1pCZUt2MXZQOXhCUFoyWm5EZHBPcGFjTW9kZDQrK3pDdmN6VFZQdnhn?=
 =?utf-8?B?RzFWVDk0QmtsT0p3T1BxM25POU1KM21Qc0IwOVZWUS9FTk9tb1pXVHM4cVQ1?=
 =?utf-8?B?Y3dOS3FZY2VRNElGYklNYlB6NS93TDNGTlNEam53MmZDL2hzdTdyUXMvM1Vq?=
 =?utf-8?B?empGWGxYTG1BMUNkL1dXOUlzTURudUFnVG1DQzhvNUNURHJTalZ4VUNwWkV1?=
 =?utf-8?B?cHJuZ0prdjNWaWFCM0J5MmI3ejREVjdMRXUyS2lXMWFwRUdzUnhhR1MxY3dF?=
 =?utf-8?B?Z1BySW1kcUQ4bDV5dEZzV3RTZGJwbnVvYlVXblhtdVlzaGRFbTVhUXdSQ2oz?=
 =?utf-8?B?OURnS2FNUm80QTRvei9DdnpRV0VmZDlKZ1gxK09rSFJvYUpjNFpzMjhuSzY0?=
 =?utf-8?B?WFZJWG9Zc3FOb3JUTnN6c2ZSTGwzVVpuOFpYV3I5V2FVNE1rNWFaNTZCcW4r?=
 =?utf-8?B?a0ZYck5NYUNJeHVyWVljY0prZUY1aEhZY3RtdHI5U1RFMEdjTTJaeW56K0lH?=
 =?utf-8?B?MVZHM1B0T1pueFVFdDNvQjdhZVdEQ3pmSWtBazRNLy9ESDRzNUdnZklzWXBn?=
 =?utf-8?B?bHovMEdmSC9FTlJoUDRjSitEVmo3N2VrR1B3QVgyUTloSkREdzBhSEIzNWNX?=
 =?utf-8?B?SGtRUlZIaTdqb0dmTG9wRUQ2ZG11SEtuSmFhNkNsNDNITU42cUtibHk3d1NZ?=
 =?utf-8?B?M0NNTUdLQ1pSbTNMMjdCL0t2eHdwa0o5UHVSTjZFdUJZMFdXa0R5NEJHVURa?=
 =?utf-8?B?TlZNYThxMXR3RklrQjErUGV3cjNZV1FUbTVxSFBPMm9Gb3lma1VUbzV2OEFi?=
 =?utf-8?Q?/lVGidiCJMI/L4f5aSFn2Kt6Ekjyyw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGEvRkRRejdBdkdRVWUrempxVm02czdCQ0F5UTlyNkl6Y0x1OFpzV3c1dVBk?=
 =?utf-8?B?dk5LMXg3QVEzMDRvOW1HV25yNWlTUXNDQnVaek0zWENzZXpBVnJaVUY4WnZP?=
 =?utf-8?B?UUpIQVpyNlVYNW5hRGdtUEdBOXZSbGZtWmVPRmtUZlNtSXI4TFNnbFRMbW5w?=
 =?utf-8?B?SERVdDhRRkFXaWtVSWF5L0VCTlFYdGQzYXFzQnI5bW1zcERLV3lEWnF3NUdu?=
 =?utf-8?B?TDk5aXJnWDB0eHNQdGFPQzV6RzFuMmhmTHd0dkhWTHRzM2JmWk1uWFBvclZZ?=
 =?utf-8?B?ZmxDZElLbnZWc1JSVVhjaHo2Yk5HczdJczE5elhxRTBkaU9FRVBHMnZyMTlZ?=
 =?utf-8?B?R2Jyakt4SGJPSTBLSXBPZnVnMk9XbkF1WkpQYjBtc0ZLb3hicERjdlNpdnMv?=
 =?utf-8?B?cWN1QzFoN0Y4T0drQ3ZnQzFBYXZEMXZXY0x4alRZYUJzSHpxa1FqNTBNM3pD?=
 =?utf-8?B?cXpyMFpIMnlLbzgvTjBYWkVzSFdvdzlCWWR1Q0NvRlBRZWl6NmtoRVVIWkMy?=
 =?utf-8?B?UWloNjQ4TldWWmxvWWJLb3ZQQW0zMnZOYlV6V3R0UkdjY3BXK0xsRmxyWGFW?=
 =?utf-8?B?dnZaZ1ArWTJZZGVUKzNOMzFadXE2Tm01WUJ0K29yT0w0b2xtWHEydlhuVmhG?=
 =?utf-8?B?aHFKRDRnY0h6cUErd25QcmwwZUNGWmxpbitad3J4NHlKL0kxUDhyaloraGxy?=
 =?utf-8?B?THo3dk0rcWRuTXIyWjlpMGlXdjZoOTBvU0IrNm50bHFkUEhvZStzbHE3WWt4?=
 =?utf-8?B?Q2pVT2lFYXZ5R3oyRTJEQ212TE12QnFOV2lBcVo5cnVIb2M5MmFYcjZkaTBv?=
 =?utf-8?B?N2x1ZDFIMDZFeFR3cGViSDdrd2pjY2ZaUkpqNHBlQnd3VC80RURuWGZVMUo4?=
 =?utf-8?B?VEVWT0h0WFhFdTJKNmFPWHJLZUFwbENNeDl3SUdsa3FzTVhiaXdEckkyak1L?=
 =?utf-8?B?cXA2NXlZNU5oTzAxa0pQOWc4am5maVRNSTBVK2FYUjBJTGRIQ3AvUUFCTE9S?=
 =?utf-8?B?c2E3ZGE0VU53SjRxMlZuOEZpdms2Nk5xMi9XMVl6N2NsekxCbWhPYUdLMU1C?=
 =?utf-8?B?ZDUzdGtLVm1qTndqazNIQmxLZVNFT0FYL1hRR1RCdHVNcU1VTVlhOW1id3Zv?=
 =?utf-8?B?aCs4U1ViendISTN3NElTd2dQbE9RbGpLdStnRjB5QzhDemMzYmtGN2xyUTUy?=
 =?utf-8?B?UHFnNHJzVVZOeU5XV1VsRUVsbG1GMmZtU1hKcUYzVDk4eEVzZno1T2REeXE1?=
 =?utf-8?B?eW9YcS9vZ3RCaWpXSXljc1lsNFNvNnZ3dFJ1MnBqQ0E0TVVUekZQbGQ1aWxx?=
 =?utf-8?B?K3BYeHhwRm5Ibm91T0lWRmV4UnNDUUdTU1duL282OUxEZzBiRWRDdlBROEw2?=
 =?utf-8?B?L1k3NXRMRnA2TmNQejFQMjlYUkRzVUFENDV2YzdNalVlZ1d6am9DQ0VjOE5W?=
 =?utf-8?B?UXRSNVJiN1oveWR4Y3hCLzJWRW4zQzVWaS9CcllCSFBxZEU0SERtVk53Q0Fm?=
 =?utf-8?B?OWZRUHpsNUV6OXdUVUtUUGVzVjBwOC9KWUZ3bzc3eU9Pbi9UNERhbTNrNjE4?=
 =?utf-8?B?M2ltQmVwVkFtZFZrUUtBZEtNRjNHMW44bk5jOFRFUzV2T0JkZlQvRUVSN2pG?=
 =?utf-8?B?NndiZFM0ZHB4bm1YMXBRZHh6YjhnK1dsVXpzVTdIK3RZYWhGQXpqQnNCdVNT?=
 =?utf-8?B?M0huWEJkTHE5aXRoMmpOMUl1R3Y3QXNXMUlyQ3dvem1Fdld2SHBrWXdoKzh0?=
 =?utf-8?B?UlFGVzdlY3llWjVJWjRnMTcxM2lSNHNnRFRCaGNaL3BpMG9RemdoNytNRW5Z?=
 =?utf-8?B?aElEc0diMnZzdWc0OFdoREFYSHVwV0xwOVFSOGhScUYzbUMxTFNYZDVKQUt3?=
 =?utf-8?B?VTFYKzd3UmtZcVp4bnh3cVY2Q0pKZlpGczBkRE9DR0NreFpsMWhLSUdvU0tn?=
 =?utf-8?B?NS9kdWRYV1Q3MW1jZkdNQ3cvQWJRSlVqaXlrT25qV1dMbnJYdThIcURKZ0hK?=
 =?utf-8?B?RExra1lwb2VvSWpNSUJ0K29pV3lzZ2prWEdLT2s1ekZwdTZPbEg5bFc1YitR?=
 =?utf-8?B?ckNEWlZUc0hTc29HQzZPNG5GL0xBL25IcWVEbTJSNXJPWGR4a0VmTjFhK3ZO?=
 =?utf-8?B?OUNSdCthZ0VISjc1dnBpQ0U4cGVFQVJScDJTc0lpY0hqclVicDdtK2lOTFM2?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD94B71C2500C24E86B4272DFD07235C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h8jU2gvrM67M84wC2dof13dEQlW9sicIUU3PlSSNf+AE1lYVjrgCNBe/EuHUVayXKJgidziujNYfJwFkSdE9E8WMEIj0qlojIv79POTe4suWAZpDAO9uNTN/W9UVffPOUR7fjrh/WwT5989OwfKYCbH5D6+It+gpS7w7vlnzvVHgUM22tQKGmBO5GEhidvigA4xvk1zjNrsAx1STEndnsnlt4DC3DWCEEhAu4p4yHnM9FiWwPOKxL2g5Ve/C1kqpbVV1HbDvmuGvp/qQTjgkT4PzoUIRqu5djGrZ3mneMIAh0WVy3lNDv3klGNj1njj6aZhGNobAWEjXnn7PKh0Aco8q2e3Eg7JogLhhU7sQfEs9CkfH8TvIpdYHFXyryp7fakQJcJOJ8e4wMQ/3TSa54J/OOS6hWurj+i6yE3+VXYeKNFWcPZDj+ZW/6TRCBc2HRafU/jdazWvjlrH9RkBjYtd3oFsmuKS6lS3WQ5Y9EXgxVb6Se/3sj26MqLuFdEUhoWmAeNdZwhO+xzx7DwyfVWmO5GiVOGpAU3BvVS2qe/6yd8R++OIHdqAqtnpP+9PX7uLsed0IcARQeZ/stG5o0a3YZhQogDLTxLAb4Mzy9MlAWTd8REvhbPR0SL8eEoy5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877f611a-04c6-418c-ba54-08ddf124285d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 11:12:55.4664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3RwanM2jkm8CIFaBDUPtZJhLyn9N6t9OhgEKqaawJz83GkWi7K4Ve9IyPucJWrWzyI6BtnD6eHg89r5zxsJPizdR1YO+1EXenA4OOpLKCGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8093

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

