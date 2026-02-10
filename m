Return-Path: <linux-btrfs+bounces-21589-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEvALREHi2kdPQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21589-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 11:23:13 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 604461199AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 11:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6A053013474
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2AF35A927;
	Tue, 10 Feb 2026 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Kil2MRcC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bBa7eg6P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E99343D86
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770718986; cv=fail; b=mxDyQ0bomeq6P6W9uBepcosxiGX/vWciNI05VEDcUucCJCbIlPdouvmp9hfUQznGlFEonO20yy9s7SrCX/U2phQB1g4CHIHNTV+lfNIX55CrAhOsUPJ1GkWoQ3ZSJ/ed6lv+hGYx8+t/hjGWADo2T5hyRKMadkmr+zuBY2Dy67g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770718986; c=relaxed/simple;
	bh=3a40kUPKm9ByiwipSbDDEa3w2DgRp2C6IuSd17fKQP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PGjD1s/Jf0KlsrFqPvOxWxEtS4Jl4XhJvbBHVun6imkrqOp20PaLf4oBZ2/ZLiHrvsYbjqUJlY1BfwW71Q9vNYRqj/e0ofes+9UUcfZtlZbp8JFuuDuTCAhavuhXPf0krv3DGC0dDDo79SDMyq8pAFqTkxDKBQBEPLc61EdjQPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Kil2MRcC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bBa7eg6P; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770718966; x=1802254966;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3a40kUPKm9ByiwipSbDDEa3w2DgRp2C6IuSd17fKQP0=;
  b=Kil2MRcC4GChM8OkW8RKhL9DnAfR2MfHHIIOf58nQp+3CAIc0xvprDD6
   4X9blMlZ+SRF7cp1SL5G737msZRisxVAggUWrS9VwpP7kxgv6y6YQJ4bT
   tWev7yt0zmLLymqmRSdYv11qQviiAFJoWSwuH/g6pxFz3Xc3XzLscX6e1
   yGYNsX3OoFlE/o676LJtRYjwRCXUvk6gPb+qsc86GjNxNnqK8EwqHaNbA
   yRjI01p0ihrWd0AcAbnnZETkZRMaDTKKKxfL8O4XgSoNebF3agBPhQkad
   sTnyxZF5m9VFYoR8mpYSvk4L0NnNSIcCvL/VqpEPLUb2d1dBI/XvMJ0im
   g==;
X-CSE-ConnectionGUID: 5wqAowZZRYOpT2SqAzbpww==
X-CSE-MsgGUID: VSpdrh6pRrymJzSR1sQ7bw==
X-IronPort-AV: E=Sophos;i="6.21,283,1763395200"; 
   d="scan'208";a="141596712"
Received: from mail-southcentralusazon11013025.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.25])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2026 18:22:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPM6UTZzj9alRPaIDZyS9xjBTD/+F3fFrET72IGT4o4rzii9K0+io91ZRENzdov6uKgP+xuAL/qUz+Bdj+HzqBpUeMO1A5KPd0u49VcYY1Bh45bRXXCKAhJidIZe+lHN4fzUdTr4xpW67uqGbhk3Bv3Ubvm0yZD92r61KhBJSo61eBGmhYNhyM6ojjtPwlsc+O71vlB+sNfI074s5e6KysTecbhbGpdbwVBS+3w0/QTw8Tr4eLKZCD/KouE/P7zdkEGy3+g5CrSjVk0Q4elNs9+ZVCKGAxcu7d0tCakykh70CFJuhfDq48UUDclajag2zAbMzWjI4Ly+rLZfrIScUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3a40kUPKm9ByiwipSbDDEa3w2DgRp2C6IuSd17fKQP0=;
 b=bUkpCnRF1AnH+BE/NgQdG5dkC38Gcvq0XEpP//0dzhyrwkR3os+GrrcFjdmeSUYOTnvnMK/Jyzx9tWYr/yoKVQ9gjYYrmlri6K4UEDefzwrG/JNVGOGkHXCPEtrLzrpNvIrMHTOKHyKV8kKxtX21JN/8LvTjqhkAmULHjZeTDfJtuQpj7ZfhjMJx7FH++UsymRgv5s3wIRBTg/TPe7iYz6JEvR+U2XDw1QUezQzNFh7veTa0iiqWp3C2MH985bfa7sUw8sta5VPsNESrrOsXdO1KUFraAvxm1xf2MtI+Whl8y9J2sN/QJLpUgva3PI5bgOQcucI7lUJ9crX1ke0GWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3a40kUPKm9ByiwipSbDDEa3w2DgRp2C6IuSd17fKQP0=;
 b=bBa7eg6PYD3Ewg4X3BieMoX0/OLDq2E6K+G9SWHwPUgbP31yC9JuX0zCLEVOiTPypT14eQTqVJdpu40nsi5Dl+fjkLfXF1qY3jFgAttLuyUt65sN+KexGGYx+8mAjZQxl/ypXjwLjHG9/CJj5F0foTTQW8Yl96VdCHlMainfMbY=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by BL0PR04MB6577.namprd04.prod.outlook.com (2603:10b6:208:1c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.5; Tue, 10 Feb
 2026 10:22:41 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%3]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 10:22:41 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: handle errors from cache_save_setup
Thread-Topic: [PATCH] btrfs: handle errors from cache_save_setup
Thread-Index: AQHcmnQ5Dqwz/NhzwkCPwLhq6JRX1rV7uKyAgAAAygA=
Date: Tue, 10 Feb 2026 10:22:41 +0000
Message-ID: <7f14bc17-431c-492f-9b00-d4c835e03ac3@wdc.com>
References: <20260210100115.235406-1-johannes.thumshirn@wdc.com>
 <CAL3q7H7n+sq=ULNqx2MWCPcv4USEpd2qvwzyawC66NtVMh8rJw@mail.gmail.com>
In-Reply-To:
 <CAL3q7H7n+sq=ULNqx2MWCPcv4USEpd2qvwzyawC66NtVMh8rJw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|BL0PR04MB6577:EE_
x-ms-office365-filtering-correlation-id: 3935a739-5fec-4743-1da1-08de688e5290
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QjZVUWYrTXdpMUs4T1RBM2h0dXoxbHdlMXNTOUdnOGwxZmVLOGF1K3FHU0lP?=
 =?utf-8?B?K3VWZ2ZsZk9XUXp6dkRBa3A2cWR2aTgzUElET2JZVUxEMXgvQ2ZjMmUxS3A0?=
 =?utf-8?B?YlFoMFBpSXVSOGNnWlZrK1dyYWpsejdid3dSenVvcisybnVEU3ZhdXBwR1ly?=
 =?utf-8?B?R2xUM1NXRDExbFJzTWZQVk9XRGlNVjlBOFRmTEs1NkJyUWpFekNMUzRaZlZO?=
 =?utf-8?B?MGc4NFhTZjJkSGNaMGIydG81OXB0b1dOY0dUUUZsdW03Y0FmS04yMW85eUJO?=
 =?utf-8?B?dzFkbmVjT2pOWEUzWTRLTlptaW53WmZZaUFTWmY1NnZNRlMzeHYzMkdrcjcy?=
 =?utf-8?B?Tm9CL0NOQWNQUTZWQ0gwVVpoRWZnTFlMUlNIdDhaaERmZGJ1ejhBaWZocXRO?=
 =?utf-8?B?ejlYM1ZOcnplWGhkVUFJcWZwT1FBZFIvUUVHc1cyRjdwS2pKaDBFTUxKUDFB?=
 =?utf-8?B?YXQ5bERHeGNvT0x1SFoxM1hxSnd1V1hDZ3VFTnJHblNJUVNZcGQyRTloMnV5?=
 =?utf-8?B?WWZLdDJ2aUNPR1FzTzRydlNjSSsrY1F1ZU5qZjdGMXZxSFNvUXZITUhiN1U1?=
 =?utf-8?B?alRaQmE3TmpLb29VaDd4WnNwYXozYndFbVBJdllvNUViNC9nUlZxZGxETVRG?=
 =?utf-8?B?S000RVIxMGl1OFV4alFNZ0dPRjVPME9OVmFJLzRFUU1XOE9OdTIzS1JoVkVx?=
 =?utf-8?B?dGMyeGxBU0llK1RhakVCYXVXaHJpZWhsdlQvYjdnR3VLdWVPVUdFU0YwQlMz?=
 =?utf-8?B?bW8xOWZ6Y2YzTUVYQWpnTWZEZXhaUFJJZWx3bEk4MXMreTNjNmdUTFA5aUNn?=
 =?utf-8?B?clJ4SXY5ZENybnFubTBWck1WYTNLYzkySEFKNW40R0gwUlhhWUg4S0VUOFpL?=
 =?utf-8?B?RHZjQjdRUkNqaVRmT0xJVWszZ0o2UWh2Wm9FbjFqNHRuKzN2MllDczhzWENQ?=
 =?utf-8?B?YXNKYjROTDNueG5uQ253RlYvRWIzU2NpaXFLNmtyc0JoUDZqUmlrUmhyNXJH?=
 =?utf-8?B?cVRIYXZmb05uUTZPVHl3QU1MYUFIWTFjV0wrbTdWV3ZoNkc4ZGNTSjdQTjY4?=
 =?utf-8?B?RVo4dXlXRzQrRURMd2xQN3F3Q2F2ZTlrVUw2VldVQWs4dUZzTTNyWHJtR2xE?=
 =?utf-8?B?WkZPZ2NFQUJVMGNiVEVTSVNNSHhoZ2hOVW1WTm5obDRENFdrVVFIU09JdmQw?=
 =?utf-8?B?Uk1BOTVrRm5Cd3NnZmlSQ1p5YTdLQXBaN1RGQzVrQlpDKy9GaXJramNKY052?=
 =?utf-8?B?N1dONStydGpUUFphT3lkR1pweEpFa2g0NlU0L0tVQlhYVXpxRFR0cmlXbUxY?=
 =?utf-8?B?QXEyejh1aCs0RXh4b05pazE1c1M3Ukw0Yk9KblRVd1Z0UTQ2cTI1dDRVRFFw?=
 =?utf-8?B?K2hqdjFVWEJOemhaQzE5Q1NianhtYk4yV2NFUmhTTEI3S2ZseTB2Q0FEUzJp?=
 =?utf-8?B?SE9FN2JhdXRFOUNwUDhHM05KVG5VSk14TC9tQ3dBVHd0c1Z5VWM5a3ZwOUIz?=
 =?utf-8?B?dUxZSlFNR3hObkNSVkdaM25ZYzR0aU5pbGc4aW51MmkwL29sd1F4Rmd6UDA0?=
 =?utf-8?B?a1lNUmRmQ2RpbjN6MnZ6RENsRHZJSWk2OEVUZDYwdWhySjk5U0loY1FxQThs?=
 =?utf-8?B?UWVOQ1NYUjRBZmhOWjNma1ZzNnFPSGhSSUFaYWlsMlMyYmxnbzRGUGE2MkE1?=
 =?utf-8?B?OHF1ZlpYMTRCTHZHazdsd3FhNkllMkdJRk5WYS93d3JjTTFydzBTSkwydklr?=
 =?utf-8?B?NWVGRzhMVnBqOVFqQ0ltTzg2Nk1HVFVuQkFBV0tmM2RKYmlYaldIcmRsblVh?=
 =?utf-8?B?b1RMUUptOVhUY3V4TCsyNG1qMzE2clk0ZWlHUmFKR3hKeXdMam43dS9JL3Jr?=
 =?utf-8?B?U3BRaWlUREViVFJyd1NoTllkeWFsRzRzN29aSzhPbHRLbi9iaW1sK0IvT3F6?=
 =?utf-8?B?NFhSaXB3Z3kvd3BCdFpUd0oxYnpDUjQ5VWJ3b21jbEhZamh0QUlwemlKMkI4?=
 =?utf-8?B?RXp0Mklyc1NKeWc0eFVZMEJPYUZqZWNocjNqQ2FpV2h5ZkNEZ2xzMG5aSkxH?=
 =?utf-8?B?THVJdzVkNXE0cmxaeWtZSFVZaXN1aWVWOUQvNDlTWm14djRMZFVQNkxJNXRY?=
 =?utf-8?B?VnZFZmtxMUJsNG92SUFJL3JVZGF2OVlKQ2NmYURVVDVMcko4OGRBdEZ3eFp0?=
 =?utf-8?Q?gASoPyYvCno//cEn3MCvM70=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UE1aQUtCTnhsZUJGekg1eEE2cHBwY20ycWQrakxMZlZZQlFxdVVZR0ZMc215?=
 =?utf-8?B?aTlldGl5cDd3RzduNmFEZTM2Sk1sYUt1V3Z6SG9XcHZSelFBZGV2L0RBL2R0?=
 =?utf-8?B?cFlkWU95NlpqTmVrWXp4SGVWQ0ZVSTlKYTNLMFEvbXFESmRkT21xQXpUNkI4?=
 =?utf-8?B?bDJEM2ZIRXBHRVVHNXhHQnN6WWxwbGcrcjZobmQrSDFOcm5UN0VDaHI5NTlw?=
 =?utf-8?B?cDRld0JaYTREL2hLcWhzbEVpcWNZU1JlRTJKejJLeDlsM3o5Y0Z5a1lGN3Qz?=
 =?utf-8?B?YmNZN3hWNUxSaWhFNUNnU0ZuUWVISnVOYjZOOUJpY051VWxkYTh4ZElEWHkx?=
 =?utf-8?B?dVN3VENldmw5S3pCdmtFZ1FwUEJ2eFZqQ21WR1l3SzFWdW5Wb3pZTG16RG1j?=
 =?utf-8?B?K2t0b25iWUp0QTVIbmtvblZ0Nk1acE9Qdnc1eXN0bG5jNzJOaDhCS0FVY2Jr?=
 =?utf-8?B?Ymd2SWgxb0xFRXAwQzNvdVNZSmwxNVRmZGFtbG1CYngrUk1ZQk5vUytjZWtl?=
 =?utf-8?B?Wk5SelZoWkU0WHF6WHNPVWJKRm9UM2lGQlpqSmNodGJEbVEzM2Nza0ZRQXMv?=
 =?utf-8?B?b3BhZ0Z1LzlXVnA3dlFNNUJqQkNqcHRSbjh4QTNuRytiQ0dydzNKUWdQaFpF?=
 =?utf-8?B?ZFlPT1F4cjRjczAzSjVrRkZ4TEsveEdmRVRKTjNvdUxQZmhQRVV4K3daR3ZF?=
 =?utf-8?B?RWUxL0gxVnRDakdWeXdWdWRrSVRNRGFXMFpPWi9ZLzZMc2thRjgyNWtrZmpJ?=
 =?utf-8?B?RngvSitweFU2V2QyS29yOEpBcVljMDNVSFhOdG0za3pwMlkvUnYxNk1xVFRO?=
 =?utf-8?B?Vlk0a2h0ZmttQmdzcXNjcE5WZE90Q1o2eFR3bndQRHh0Z29FRW43ZzQ1T0Jx?=
 =?utf-8?B?U0dmdGxwK0JxZ1Q5WXJyREZhc2xLcnRLUmZWZnFaL1ErY2VJelAyMDhEdVhM?=
 =?utf-8?B?TDJ4Q3R0ektKSDZ1bUFJSnFaL3FDSTBHWDZtckdVUDE5RkdrdS9NQlhuNXpD?=
 =?utf-8?B?WVlCMVFHNktlMTNBR1p5S2NxU2VlU2NQbzJycGNhMWt2NC9xQWplY3dTQnZi?=
 =?utf-8?B?WWZ0RjJubkFEdjRsakZycWo1NGNkdDNGRUhxR00vQ2ltd3lTNG9PSUJsWHJW?=
 =?utf-8?B?Z1QrVU84NENzWUl4cmk5NWU2YWpTWXUzSkJzQzZZcDVIbmJWcG9iYnZFMXJ0?=
 =?utf-8?B?ZWpLa3FYZHd0T3U5VjM3VWVPS0JrOVh5U1Z3czdDcEZlU0pERFd2aVVkbExI?=
 =?utf-8?B?eW10QWhtOXV0MVBudXVEY1g3UXIzTTJsbGlibkR2OGd3RUFUU2dRdjBWRU8z?=
 =?utf-8?B?VDJXNEdxd3ZZd2ZoOGhvbjBLdEwyQUVpVW54S1BGazQ3WFJsL2x4TWVLd1Zt?=
 =?utf-8?B?LzFUTmZsY2h1cTBueVVKNWRia25Qb2FnOHZZS2QySnNPVDNPVjlyV1hOVzh4?=
 =?utf-8?B?dWN6SC9kc1hnWTBSQXZ2NkJMUVFoLzRtbDVQVjJ5OWxaU3F3Q1ZiczM2dHg0?=
 =?utf-8?B?SzRWQUlPS01pR1RzcC96WUdsNExLak4ybndaOXBHd09LcU1PUkVqTG1iQ3pF?=
 =?utf-8?B?OWxHQTk5MkFWOEg2WTdyS1BxVTE5ajBibjBiaCtrVWFhQXNXU0dEdkI2VEd1?=
 =?utf-8?B?elBTVU4xSUs4YXdLRzNFa0t5Q1JYZXdMTk1xeENxa1dqMjlNNWRLbU1WRjdS?=
 =?utf-8?B?SE10cGhEOTNIZWNiaDBLYkVYTXBoNGZQazZjYWhjSGp6dDArWkFNTzEwL0tC?=
 =?utf-8?B?V1B5WUNUMXFpTDR5L2xha09NZFpPY1FSY0x0VzNlcnRaYlpNUThucHlQOFls?=
 =?utf-8?B?UDFSejVzMWp1Zjg5T2kyRnNPZEpJdm90VUZnTHhSZTVXQjQ2cHN0VTBXbCtt?=
 =?utf-8?B?dU5zMWdwUUh2NS9GSlJ4Mkw1T2d1NnBYRU1XODVvaHZXeXowd0kvRGNKZTNs?=
 =?utf-8?B?TStmanNwKzhsWmUyNndTaU5oVC9heHJoNVRQZElpSksyY05TRUZ1TnMvdm91?=
 =?utf-8?B?UEZlaE5GdTRmLys1NDF1YjR5c2ZHUDNWWEcvQTFMWHkrVXowb05xRmZPeXhu?=
 =?utf-8?B?NnJOTnZXcDArVWwwazBpTzFYUWwxbjF1TnllR3hTSFBwRzY5VkNiQkRmQmJz?=
 =?utf-8?B?OElubDhJQTZ1NlVPL1loNG9RbnpJMUVjQTduclBON1Y3Sm95KzQ2WjgwSnVR?=
 =?utf-8?B?c2hsQ1Jxd1FMeGdYUi9HSEQ0c0JsWHlFRW9FTEhOVDdOa0p5NzdnRUtqSkRk?=
 =?utf-8?B?QzZ0RWk1U3dpbS8zbHJEUVVkVU5yaWRTVHhKazJsNGQxdkk5Z2wzYWdsMk1Q?=
 =?utf-8?B?Skt3TzRnN2FzUG1iTzBsWU5ybGpDSFFUTElyUUx6Z1lXQXMyTFF4bWlob0xZ?=
 =?utf-8?Q?jexIqM6CI2rfyE+g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C03B0D6FE3AF1D4FBEE4DA8072B69708@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NKUVWHI4LuE+zYks4/NRacULlkEbeSTx+zOUv3q5obaXq7jpadj+5VME7Ln+0FfMkD+nlnjwrF+hK43YvR0IoE0wpL0nr9mFU3YWAuquMWdhC0KYFOZveYihYUOixoJumlFceGzk72qC1+M5Qpoup4ZgkHYMAm6+nX1vvB29K8GT6wB4ZpyF/Wg57nmSzYRfQilyqJeAsbMMV50TlkPhMWVInxwKbTbWofxZJX6AiwpHaRUDAgzC553sXoBMp6FGKliaipNt7FIP+ywcG6eOF/PoEXDxcfvTywv4/wBgkJOxs5cVmwTLBu5EKmLK47jkqQ7IAU5X8R1PRPYW6CfA6aayfMcH0xtpwXvWaY91v4uLuAwp+E0pPj9I1Edl6784Tjxc8Uljzd95+if/3Aofre5mOYd/COZvon11Pp72vFrdD6HFa+C5/UkDmZNd0xfh4Bmp6pqibS/zMl5unJWAId4X0KLd9z4RuroPQg2e/XhV2I4MeJA5g+1f4V64PjSTn2xSZXgZjA1CULW4pjFsocWibSPdkRhnbu28lNo1y6uDgbs9q6uk/lxcJOuEdJeOg16Dn0G3vWGe8pKOV8VhMhUqAfZVkcjJCQIgcJhFRwMB8m6s7YSuGIJqVb+ZFaq8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3935a739-5fec-4743-1da1-08de688e5290
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 10:22:41.2553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ayUGvZtUZL1SCPHKglYZ2F35WYa8O9u+zJ3YMo1D42xGvQgCoQdPG34LRxNKQdlgODshEUltwpFdrFD9de4aZQR2ALwy2IiVEguBb4waWjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6577
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[wdc.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21589-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_MIXED(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	R_DKIM_REJECT(0.00)[wdc.com:s=dkim.wdc.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DKIM_TRACE(0.00)[wdc.com:-,sharedspace.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,wdc.com:mid,wdc.com:email,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 604461199AF
X-Rspamd-Action: no action

T24gMi8xMC8yNiAxMToyMCBBTSwgRmlsaXBlIE1hbmFuYSB3cm90ZToNCj4gT24gVHVlLCBGZWIg
MTAsIDIwMjYgYXQgMTA6MDXigK9BTSBKb2hhbm5lcyBUaHVtc2hpcm4NCj4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPiB3cm90ZToNCj4+IFdoaWxlIGxvb2tpbmcgYXQgY2FsbCBzaXRlcyBj
YWxsaW5nIGBpZiAoVFJBTlNfQUJPUlRFRCh0cmFucykpYCBJDQo+PiBzdHVtYmxlZCB1cG9uIGBj
YWNoZV9zYXZlX3NldHVwYCBhbmQgcmVhbGl6ZWQgbm9uZSBvZiBpdCdzIGNhbGxlcnMgaXMNCj4+
IHBlcmZvcm1pbmcgZXJyb3IgaGFuZGxpbmcuDQo+Pg0KPj4gQ2hlY2sgaWYgYGNhY2hlX3NhdmVf
c2V0dXBgIHJldHVybnMgYW4gZXJyb3IgYW5kIGlmIHllcyBoYW5kbGUgaXQNCj4gVGhlcmUncyBh
IHJlYXNvbiB3aHkgd2UgZG9uJ3QgaGFuZGxlIGVycm9ycy4NCj4gQmVjYXVzZSBhIHNwYWNlIGNh
Y2hlIGlzIGFuIG9wdGltaXphdGlvbiwgc28gZmFpbGluZyB0byBwZXJzaXN0IGl0IGlzDQo+IG5v
IG1ham9yIGRlYWwsIGl0IGp1c3QgbWVhbnMgdGhhdCBhZnRlciBhIGNyYXNoL3Bvd2VyIGZhaWx1
cmUsIHdoZW4NCj4gbW91bnRpbmcgd2Ugd2lsbCBzY2FuIHRoZSBleHRlbnQgdHJlZS4NCj4gTG9v
a2luZyBhdCB0aGUgY2hhbmdlcyBiZWxvdywgd2UgY2FuIG5vdyB0cmlnZ2VyIHVubmVjZXNzYXJ5
IHRyYW5zYWN0aW9uIGFib3J0cy4NCj4NCj4gVGhpcyBpcyBhbHNvIHNwYWNlIGNhY2hlIHYxLCB3
aGljaCBpcyBub3cgZGVwcmVjYXRlZCBmb3IgYSBsb25nIHRpbWUuDQpJJ2xsIHNlbmQgYSB2MiB0
dXJuaW5nIGNhY2hlX3NhdmVfc2V0dXAgdG8gdm9pZCB0aGVuLg0K

