Return-Path: <linux-btrfs+bounces-18871-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB130C4F600
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 19:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 979194E9FF7
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 18:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA7336C584;
	Tue, 11 Nov 2025 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iih+4QzF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013013.outbound.protection.outlook.com [40.107.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9284270ED2;
	Tue, 11 Nov 2025 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884507; cv=fail; b=HjrnViDL+Hagtq5aWINJgO6sZ4/XpckAK4FfPiG11D7cuOWil7LOdkmWH/Hg2piwEWIXBw4xgbLwL4wYfcCi/GX9OeHSgjyx/P0999UWSjZg1Xw8jC8CgwrIgz5eLkUAaD+pXESAIERjP2JdxUoUEWJI6hGMz1rSfeU0tuisAcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884507; c=relaxed/simple;
	bh=K9NHT3Td9vhJz+CRwKrkOgmnEylfw3AyEGvUnZGF4kw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yf0IZAVs7OZKIesGne4uGIh5V6V3kEv0I2GgEMF/1E3UurkzEiMX2BcSJ5qKzPNvz+7fqO4PQ07hEFmZltnimJPYLKvepPi/CrASXFiiUSa8/2Mw5zs3SfZtkWxuzzjISE/OL04uYw1EqRhWVB7CYnGptF26pVyjkIj6SW/5ffU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iih+4QzF; arc=fail smtp.client-ip=40.107.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRonD3EGT3sJmqSk+Sqee0jfHKgyp4P/d2wjhxAP7o8tiM3x3+dJVzhQzUhhFrhGDiPsGCxe7p5R5h759I6zOnZwP5Vs5uFmDM3NfvdPUIFxVgej/8yJQUjmX5JX704xZhzjrC0h7lFlS8FJTfbZlAiOjmTtnayxk/ibeZXCCLghlPzYLpw0oRquYNQXzb46MrrEFO83YK3is+uZrUXCG58mLmrntfSF2dI1CCVhEwxjX81rAaq7o2IeujVcReckIv9wypuW9gGCef2w4S+KanTC4/PtV465QgPaXKmGdDxBGbwcUTjJx4huhw6SFp/O0dCP4/YUBaG6PE5cW/F6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9NHT3Td9vhJz+CRwKrkOgmnEylfw3AyEGvUnZGF4kw=;
 b=Aqp7WchnqQbRcI5RCzeD2YbaE4Sv6pD4W5Vt4Bcrba4o1vXrorXfDoiEn/6aGhhoFmOpb+SJb3DDizWj/eIxKctjEwYrgIxzJUIBJvgiW/r/bfG2J7mSL9aw7iMTUOr2F/gAKKQWXbJu61wUi5ouAfdmf8H4yMAaaAzXWr37gmHMF6tryOc+VrBxoXcqcF+gMgGDbPAZ6jDby80Vw/M54/SRDmabtK9+Tnf8opSW3ALrq6BGG2Tl/lopX3rKCZwocmXDFjIBE7i6EqaBOwFXfLacnSaXn/NvHnRuI+XE4A472x0M0Bb5ysRPJ2jprC33gPKgTdKjufbfl4/mDe8bKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9NHT3Td9vhJz+CRwKrkOgmnEylfw3AyEGvUnZGF4kw=;
 b=iih+4QzFAQpnilJSf+QpP0y6FtOtZ0Is2r+g+QFSETwvKTgVBoilXu7aODXSOAEGQ591stKEvg/kP9CL8hun64ZawSqTn1gKhVHKSCWghEgd9YnLaX9PH8ePn7/b0chK/OgMKf/Y28iTEAY2EewcbIUowhgXZgLkPxD5Ged96xiYPYp7YyZSNSnMmr3KVMjg+eBTsaJ6t0sNsUGnpF3sUktUaf2WgXgpelJj3oVFeXaXsQexcKvUkdZZsJTzXfWn2KN/Gt//NFVPCQqtsPOPw9Fdio7FcOCOpsve4W2aQdBxf0Pvhq2/WrlylrjXbdliOcjjw/+KqlYpSRsbA8K6Eg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA3PR12MB7921.namprd12.prod.outlook.com (2603:10b6:806:320::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 18:08:20 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 18:08:20 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Chris Murphy <lists@colorremedies.com>, Justin Piszcz
	<jpiszcz@lucidpixels.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, Btrfs BTRFS
	<linux-btrfs@vger.kernel.org>
Subject: Re: BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr
 37868055...
Thread-Topic: BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr
 37868055...
Thread-Index: AQHcUlOX2wlTGyIhxkq6/RKNu//y8LTts6GAgAAUCgA=
Date: Tue, 11 Nov 2025 18:08:20 +0000
Message-ID: <1e4dd261-0836-4eea-b7fd-8dec9a7453d9@nvidia.com>
References:
 <CAO9zADwMjaMp=TmgkBDHVFxdj5FVHtjTn_6qvFaTcAjpbaDSWg@mail.gmail.com>
 <e5a2b8b2-d4e5-42ce-9324-5748c5e078d4@app.fastmail.com>
In-Reply-To: <e5a2b8b2-d4e5-42ce-9324-5748c5e078d4@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA3PR12MB7921:EE_
x-ms-office365-filtering-correlation-id: 72982644-85d7-4dc7-2aa7-08de214d4c28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Mm4wak1HNEJSZVlDLzAydHJPWHNETHFYTkJpT29wQ25wSFpndThYVFl4ak5u?=
 =?utf-8?B?VzA3QlFmeDRwUk9vMzIybkJmWG1OT2xZdkRZMHlXN29pdkNoVUhzelFSUm9v?=
 =?utf-8?B?TzJ1cllGMDI3aHI2QW04QTdzUVZQVVFsYXovVCt2OUZNekt4VW9qeGM0Skty?=
 =?utf-8?B?YlptVU5EcStjQnVSNndyUGJUb2o3SithT0FycjRpUlozZStXUi91dEEyYjBI?=
 =?utf-8?B?ODFhMmZLamV0RlUvUDM1b1pVRWFlYm5MMyt1cGlScHhVL0R2UDZBSDdaSk5E?=
 =?utf-8?B?bTZmaVk4RnppNW1sRU45UThFeGoyb2JSUEZZNTVaUkVOaUFMVmlST3dCVVg4?=
 =?utf-8?B?YzZXWXZDOXZ4dThOVFFWSkJ6N3hTRkxqSGlVTVZRZDAvWmhqdVRFS1ZOUjVG?=
 =?utf-8?B?Zk8raG1XbElqOU1jVEFQYUR5Y3pCbndQR3cyOWMreEYydjUwQ0RQVWNHZTVI?=
 =?utf-8?B?QjZtZkdFajh5dHg2NElvb1dadFF4R0dKWE1jQWRvemFBaDBkbVBxbUtKdWFD?=
 =?utf-8?B?QmlRQVAwa3JMNzdzdnhoUnFOMHRFU21aL2J3MkdtSGoyQmJSSVZJZkhzMVJW?=
 =?utf-8?B?bVA0bEhjTEpxaFVDV3dlbW5iWVprOFk5YWZkZlN4ck1aN3RsVE95WElpdlZs?=
 =?utf-8?B?cS9QMHVWMHg5RkQ4ODN3M3AyYkhETmU3U3ZZTzM4OG8ydFpDTi9jSWdVV1dT?=
 =?utf-8?B?c0pyVDBMb3oxZmh0azFoZEdBVmFpbmxENFh6ZmlvRndTdWJFTzNiUFB1VWRn?=
 =?utf-8?B?RXA2Q0RLZ2JKWCtMV2NEMTlWTzN5YUY3OEszcFhIZlNCaXpXN3Y4dm83Kzhx?=
 =?utf-8?B?cWtTeEJ5K3FhZ2FNem9FeEJhd2wyQ2F3TGZkTnYrN2toNTUyVzBaVU1KbGcv?=
 =?utf-8?B?dGhrRXg2MnZWajg0Y2ozenM2K1EvbFY2cDZiVkx0ZitvZm16Q01hR2c0Z3g5?=
 =?utf-8?B?bmN4OFV6S25PODYzY1FKTlp5MDk4YlkzZGdIZlVNUlVBZmc1QmtwWXJVaUt2?=
 =?utf-8?B?cTBCQ09YNUFSbmw1d1U1RStBK3VrZXM4UG1uRnRLWnBrZHdIL2dVVzhLSWRz?=
 =?utf-8?B?aTl0K296T0RTNXpkbC92ZzVqTFg1eFc0N2hkWW5meTExeVlQWGtxVllTNGZq?=
 =?utf-8?B?cEp3aU9acmJPWEMwQkV2enplRGNPWVpYRmY5Qk1Sd3ZoaXh4OGFZc1dUNFNH?=
 =?utf-8?B?ZzZKeEQweFBOWm9wUmNWZFMyQnIzbHU4MlNBU2JxeWUxVGpRdW5URDl3QlFO?=
 =?utf-8?B?NTlab2tlQUg0dFlmN1BkcTJHTVE1aGc5VEZOK2thZUkrZmJpZmpGbSt3VS91?=
 =?utf-8?B?bk1tVkU5S1FHZkNQMmhQVVhTaTJ2Kzk3cDZZbWhRaDFBd28wS3JicnR6cm0y?=
 =?utf-8?B?aGNzNGRFemFSWm1HVnRXZ2t0eUFrSzlZL3NOSkpZcGZ3ZlpqSXVmZlh2Z3pz?=
 =?utf-8?B?bmZiaFNXWlExWWpMcUNrK3p0ai82U294ZDFxTkg1c2J6aUkrNVArZDdnajhZ?=
 =?utf-8?B?RHRlNjVuOEhjSkJFUnZldDVOUUtmcDFSTEdRYkNQVWJJSWVYcTRxOFUzNXlv?=
 =?utf-8?B?M3Y0VTE1OEl5ZXkxYk12U00yeHNNY29VR2NGSmNYSWN4ZEtrSE9UMGhmMXQr?=
 =?utf-8?B?K2ZJMGk3S2x1L2VOMkkxcnNvbzVhaXJaSWorbk41VlNnSFNDOXlqY2VKZU45?=
 =?utf-8?B?bFFmMUU1NmJmSXhzbUN4dThudWtlb0JOV3ZLVVVobXloUUhDcFg0cGJWOFBS?=
 =?utf-8?B?MG1SVHYrbEdIMS94enJqL0xyc3V6ejZZTkhKSjlzZWlDSkdkdFlUTzdtUFBa?=
 =?utf-8?B?OWc2Q2hpdWErQUhSci9OSHpXZkZpTEtKbWpBd00vbDU5NlZ2U0JQVzVVdHhL?=
 =?utf-8?B?bE9RWnJ6ZWdHc0lEcy85V0ZoQkxjVEJUbEQzNmtXaEJpSWlxVlBDckp2Rzhs?=
 =?utf-8?B?aVhUSGFVQ3NZTENDaG9OeVpOL0N1d0h0TWhGcE5LNFZNVTFTOTFndVNqOVA5?=
 =?utf-8?B?WTBmZmo2MFQ0N3hyNWxoUmhLcitMWmhpU2h0eUxYTWZ4eDliV0NXRDdLK3Jk?=
 =?utf-8?Q?yj7y2X?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODc4M2RxNW16RnhnaWJvS2l4WjNNcGZ4QmNuNXhrTk9pbk1ONnpHS2U5cEpF?=
 =?utf-8?B?YmdRaUVvaUNFaDdtRzA1RTZ4QngwMG5NeTd2WU5NamVkeGFnMDBEQzZJNEto?=
 =?utf-8?B?N01qOTRZNUw3cHdQN3lJMHRWa2xVU2UrMm9VV3dYN1pyN1VzL1NTYWpRSjI4?=
 =?utf-8?B?dFlaWDhhTjZzVTlubEhoc2xQazJMTjlNK3dMTFlvVXlKUHMxMVQxV29hay80?=
 =?utf-8?B?dXZzQmpRSmpWdFJ4TUlpL0dCR3hQYlJBSUROZHQxYzBiNEo5MjZPUHJvSGsw?=
 =?utf-8?B?S050d0JtdXo2dFhnTFAzZ28yaUJya3RGZnA2Nm1raEtvTEZzTDZCUGRmTkJZ?=
 =?utf-8?B?bGk3UjhDK1c0dTBnWm1tSVI3NHVqekd2V0ZTNVl0V1VaMFNRSzMzVnh1UmNw?=
 =?utf-8?B?NklVd3JsbWZBdDd3NUl2UW5RTnpDdjJMS2dwVGVyaVVsaTZZZitXcVNiWFFQ?=
 =?utf-8?B?YW9xbWkrcFpoN0NVL3l3UzI0WjdCbFAwUW5PaDFTTVgrZSt3L21VdWE1WmZC?=
 =?utf-8?B?VTN2em8xQjZOc2FVaEZtb0M2Njh2WnZjSks0QWZ6ZmJDakhFQWl2a09SL3Bx?=
 =?utf-8?B?UGJmUGM3TlhNUm95b0JhZTFZckNBRlhzV2FXYUZva2xvbkY3MDhsNHA0RUtD?=
 =?utf-8?B?a3lsNWo5VXk2dGcxRnQweWJWYmwvYzVuT1hWcFlKeXJQbmZBc0FtcFhKUE1n?=
 =?utf-8?B?M051MytxeHAzZElhWUgvSk40Ri9uTHlTekRSTlJQbHZ0eFpldEo3ZC8yR2FN?=
 =?utf-8?B?VTQ3OXpNaExjS1M1NENHZnU5QzBqYVZDUm1aZHluMUhxOUt5VVc0Rng2cnV2?=
 =?utf-8?B?V1AwbHZLb3ZVMnNONE5PeURVUHJKL29BbFMweVZJNmtwU1hWZEtoVjVBWnR4?=
 =?utf-8?B?T0RWUTdGMXIwT3VockVJUytqMzdCd1RrSG0xTWVEVU8vTFpUYWlWOFZZMnNj?=
 =?utf-8?B?cTlBUFMrRzROZ1paOG55NE0zakpBN0d2VDB0dEFTRmp1Tmw2Q0hxTDBPY1Ex?=
 =?utf-8?B?c204Tmxwa0J6U3Nhamc3NERnM2RPTXM4blYyNnFiN1NBSVVubVQ5UUloS1R5?=
 =?utf-8?B?eHpEQ05ITzAzYlRhOUtKcDVyOVhXay9GRVRBTFBMamNzdkVEdUgrMStTamFm?=
 =?utf-8?B?THVUWitsTXhkbzVVY2xUZ1dnOFNXWlVaMnRZeHc5R1M0b1BUbHdFOEpkNDJX?=
 =?utf-8?B?a2I1K3k4bS9lSS9CTU9tWXAwWldUOG5ZQ3FZaFhHNjNQeGtNYy9JbUJWbFZD?=
 =?utf-8?B?cjB2UVphSk0xdW1tYXdCMUQ0QmUxNWt6ai9xblJGUi9JNkI3WHdDdVhrMWtv?=
 =?utf-8?B?NjlJallZV0o0Y2FuK0Y3dFN2QzdvaGNTbmNxSnkyUzY2SlEycU0vNEhIM3pI?=
 =?utf-8?B?TzdoZGNLOHpGM2JUckJzR21TdWk1RGJhWEYyOGVpNDVZNzRUVmkvR0N5UEVa?=
 =?utf-8?B?aVNJb2ZORjZLb244VlJOSUNxWHRONndNa1JWMkN5Wlh4a0VTZnAxbk9jNnNL?=
 =?utf-8?B?dGdiVGJKeXR6MlA1Q0laL2Zpcm1WKzArUStDV2Z4ZjBZNjU5QVQvUEJockZt?=
 =?utf-8?B?QTZiK0VQY0NDYUxiVUJkNVRpckdLWVlLSXFTQ1NRcFAvV2tMYi9TaDRzNXFI?=
 =?utf-8?B?VFQxM045aEdmQjRRZGJRQkRjcjJtVVF3NDVNZ3o1dk1Dd0JlU2pOTU1BeDFi?=
 =?utf-8?B?RWtCT0U3M3ZRTHR3RkJQKzVlZDRsN1BqRGdZZERrMm1KQWt1MmE4OHdZVTJP?=
 =?utf-8?B?Ujk1b294eUVqbzNLVFQydXFrNjRQSExVTVVqZ3FXY2RWOEt5cFhmcjNTbGky?=
 =?utf-8?B?Q3VhTnpscUtIZTVEV2h2YjQrUXU2cDd3aG5iQzhScENCamYvcyt3TnE5eDhE?=
 =?utf-8?B?WURuYzJLVkF0REFmakhwT1dDNDZnZEFRdUhyZ0xncEZVY292TkE5Zm14R2RY?=
 =?utf-8?B?MkJhMlNZTmU3dERiY3JVb0c3OWRJVEFlelUwaStseGx3ekdjRHJJSWd2Y3hN?=
 =?utf-8?B?S1NGa2JCc1JQVHB2RGJaaUQySEtub2x4UVAvNjNROXlCdS9SV2wxUzg2Q21N?=
 =?utf-8?B?cW04eWF4QnZ6MHZVa2RINERLalZtNlN6Z05mRjFGU0FXS1BGVlp0UTZFSXVo?=
 =?utf-8?B?YUgwVE1zSnNRMzFNMjBJenUxcFIzRkttN25UMGdad3lYSWlycWt4L2dNcFVl?=
 =?utf-8?Q?aZBODzN8d+Kt6yokg0Oj/OajU00SQ3ZCGfkhx3N9GwPx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6970922EB63154C9D049B33B166C517@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72982644-85d7-4dc7-2aa7-08de214d4c28
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 18:08:20.6752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5x38xKkaIdwfWkn0mZF58WDtH6Aax+GRS1EYuMggZ7KpG1xLrvJvfAS0A1OyoqlznRdajFkCX/h3q/niRDkBZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7921

T24gMTEvMTEvMjUgMDg6NTYsIENocmlzIE11cnBoeSB3cm90ZToNCj4NCj4gT24gTW9uLCBOb3Yg
MTAsIDIwMjUsIGF0IDEwOjA1IEFNLCBKdXN0aW4gUGlzemN6IHdyb3RlOg0KPj4gSGVsbG8sDQo+
Pg0KPj4gSSBhbSB1c2luZyBhbiBBU1VTIFBybyBXUyBXNjgwLUFDRSBtb3RoZXJib2FyZCB3aXRo
IDIgeCBTYW1zdW5nIFNTRA0KPj4gOTkwIFBSTyB3aXRoIEhlYXRzaW5rIDRUQiBOVk1FIFNTRHMg
d2l0aCBCVFJGUyBSMS4gIFdoZW4gYSBCVFJGUyBzY3J1Yg0KPj4gd2FzIGtpY2tlZCBvZmYgdGhp
cyBtb3JuaW5nLCBzdWRkZW5seSBCVFJGUyB3YXMgbm90aW5nIGVycm9ycyBmb3Igb25lDQo+PiBv
ZiB0aGUgZHJpdmVzLiAgVGhlIHN5c3RlbSBiZWNhbWUgdW51c2FibGUgYW5kIEkgaGFkIHRvIHBv
d2VyIGN5Y2xlDQo+PiBhbmQgcmUtcnVuIHRoZSBzY3J1YiBhbmQgZXZlcnl0aGluZyBpcyBub3cg
T0suICBNeSBxdWVzdGlvbiBpcyB3aGF0DQo+PiB3b3VsZCBjYXVzZSB0aGlzPw0KPiBXZSdkIGhh
dmUgdG8gc2VlIGEgY29tcGxldGUgZG1lc2cgYXQgdGhlIHRpbWUgdGhlIHByb2JsZW0gb2NjdXJy
ZWQuIElmIHRoZSBzYW1lIGRldmljZSBob2xkcyBzeXN0ZW0gbG9nIGZpbGVzLCBzZWVtcyBsaWtl
IGEgcHJldHR5IGdvb2QgY2hhbmNlIG5vbmUgb2YgaXQgbWFkZSBpdCB0byBwZXJzaXN0ZW50IHN0
b3JhZ2UuDQo+DQo+IEFsbCB3ZSBrbm93IGlzIGJ0cmZzIHNlZXMgYSBidW5jaCBvZiBkcm9wcGVk
IHJlYWRzLCB3cml0ZXMsIGFuZCBmbHVzaCByZXF1ZXN0cy4gU28gaXQncyBub3QgYSBidHJmcyBl
cnJvciBwZXIgc2UsIHRob3VnaCBpdCBhZmZlY3RzIGJ0cmZzLiBUaGUgaXNzdWUgaXMgd2l0aCB0
aGUgTlZNZSBkcml2ZSwgaXRzIGZpcm13YXJlLCBvciBhIGtlcm5lbCBudm1lIGRyaXZlciBidWcs
IG9yIHNvbWUgY29tYmluYXRpb24gb2YgdGhvc2UuDQo+DQo+IC0tDQo+IENocmlzIE11cnBoeQ0K
Pg0KSXNvbGF0ZSB0aGUgcHJvYmxlbSBiZXR3ZWVuIGtlcm5lbCBhbmQgU1NEIEZXIGJ5Oi0NCg0K
MS4gcnVuIHRoZSBzYW1lIHdvcmtsb2FkIG9uIGRpZmZlcmVudCB2ZW5kb3IgU1NEcy4NCjIuIHJ1
biB0aGUgc2FtZSB3b3JrbG9hZCBvbiBxZW11IG52bWUgZW11bGF0aW9uLg0KDQpUaGlzIHdpbGwg
YWxsb3cgeW91IHRvIHJlbW92ZSB0aGUgU1NEIEZXIG91dCBvZiB0aGlzIHF1ZXN0aW9uLg0KDQot
Y2sNCg0KDQo=

