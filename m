Return-Path: <linux-btrfs+bounces-16889-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AC4B80C2F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 17:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262DD4A3596
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 15:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7432F547C;
	Wed, 17 Sep 2025 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QD3jvsXK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="T3xM0YpX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9456341355
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124111; cv=fail; b=Q2MHoXlfcv12GKdpd14h1NcyN0CjB1vZUmj1cH63DPti+/Y6pkd92PKEBAx8CQreTy6lyeou1nwMUV8Cb8y3wJCoSKBY+KtiOYw8oj8zU124S16euOB3ModQifzy4v7KVFe4hAtbC5x2meyObSXgnFTC8O/wFf/ZzkErP8tw8MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124111; c=relaxed/simple;
	bh=fqnh8SPJhpfuWLiRAHGMu5SywgcdtpNSJil12m68gYw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PC4o66WEkapQ0xvKW+NUszXqse9ZQPjcwT2a6x/wgfjsQjKzVAW5PdVlw1oQt6Y1lD3/ltMlrVGXzbO9kg1kU4wAGU1lbMsDecQF+NnsiueuqZ4/6GO6MduuIc236Gg/l4btb7knMqgsKyiSjYvx2IcAzUP0eqvTs0yM2eTUdUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QD3jvsXK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=T3xM0YpX; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758124109; x=1789660109;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=fqnh8SPJhpfuWLiRAHGMu5SywgcdtpNSJil12m68gYw=;
  b=QD3jvsXKoDE8SevsyTkglr2KoZW0kcVMYoyJQEekU2YDGAueISp8x2pE
   SVm+VhfblnfAMrvm1L1vAKDXHy2FV4snnOALeYeMOHbRvcnb2bGPwh3dr
   q2hgCwo0wWs18UM6inMyzCGyDyUT2rjMJ4lG6PBVfeCprlC6g3n3x6K5v
   sAYgHwUFQNg8DZ62HsNS3XOVTxv1P2VbddrkB0Bg/8xGRrUgNXERpSmdr
   YjGzVO0Juxm0SMgFXAEiY3WNOBnuaNdd35OSQDkbOXE9n7uRTRGw320In
   slTJBYeR9mxarSEG6RcOK2MXJRgkVeDhlOpdeVYUYgWB3zKfSva/egm5N
   g==;
X-CSE-ConnectionGUID: g+Mc1FPrSM2zgN/pFxJ3yg==
X-CSE-MsgGUID: 5lSH+KjtRqixakng5Dnmvw==
X-IronPort-AV: E=Sophos;i="6.18,272,1751212800"; 
   d="scan'208";a="122802820"
Received: from mail-eastus2azon11011069.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.69])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2025 23:48:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOXv/hqmbAS38Y3WRAN4S8ywQRIP/zkf2amcDfxV0EgOPph3lpljcg72+fzGM9R275XgmiXRw8Ah2GW+mJn6GNqfyIk4PH6Bf6z5x8c8+JGgmqeVtSz/S/45423P7tlXIh91ps/nasgiA9AS4D19SdiGXU5x93IvjlU6kWGkeMEEGy+7kSMsKembnKPX3068zLnBbv5ecDfhgJds3h0U72KsfhUd9Ew4JUVC+6XOcfZbWeKIuNMSquAPrkmjk46GflKOaAKBpdhwZiB8b/la88tHKBm0LDllzGS2ypG+6lpkx+NEHN13EDogNlAI1dBgBEn1HX10Iomi707gxrjqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yr4TYCuJXE34WThg//7y9j45hf1uFmiFDJxcUPPzogA=;
 b=xUJuRMTCf1gm4e+Gi+iV+0oyFsQj8ipL0BlXggsx+NCHFqqaKD7RYCEBLprJHXMvvpMNRmbZoorBxoQhNJiyzzY96rRMjoOIor77O87rKwEPjqwFkgyD7hNH5ZGfXM5s+d9cslDatUjxEGqkZSPA4zqqRiyHikZYffS2nGv2t/veoB3H7ritDPA4WkQVriILURzBZTJ+pFUUpCS0P9YGE4yt3gG1IaeRnqh5iNt50bqPZhysYK5AJvQeKiVNV8reLL/EEQAtr1oeNHZqt6mrwzm/+/KB+hElC4OC4zb7E1iJhhXrkeYkgGwzashfXtW51y4UopY8Bn16XlJI8fX5ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yr4TYCuJXE34WThg//7y9j45hf1uFmiFDJxcUPPzogA=;
 b=T3xM0YpXUPCEH8Ule8jtn8+5hehbq1xd28bjR/S9SmbkqSUxFXA6jPUyfvTa8LICiBypryUG5OVCOoDgqP8IOG1QtFloNjsMR8EHjWIu81dWJO7rS0ch6+L7joAFu3OVNLpr35FmAMNrgfbng1YsHmue/goeLHY6DuXE1H3CQ2Q=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8580.namprd04.prod.outlook.com (2603:10b6:510:2b3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 15:48:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 15:48:24 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: HAN Yuwei <hrx@bupt.moe>
CC: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs
	<linux-btrfs@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Naohiro
 Aota <Naohiro.Aota@wdc.com>
Subject: Re: performance issue when using zoned.
Thread-Topic: performance issue when using zoned.
Thread-Index:
 AQHcJWG554cLgRNI6kq+V/MRpm0fY7SSfW+AgAGm74CAAA0WgIAB6tOAgAAB6ACAAAoMAIAAoakAgAAoUICAAB0gAIAAeugA
Date: Wed, 17 Sep 2025 15:48:24 +0000
Message-ID: <c3260c71-10bf-4315-8cb6-f42933c12b55@wdc.com>
References: <tencent_694B88D85481319043E0CE14@qq.com>
 <873c88ef-ee65-4e27-bc5e-156cf9e79aa9@gmx.com>
 <BD8FA84236613557+a3110e3e-3931-4ff7-a7ac-7347b9808642@bupt.moe>
 <c2d204fb-efa3-420e-b9d3-2ae45b17299c@wdc.com>
 <2F48A90AF7DDF380+1790bcfd-cb6f-456b-870d-7982f21b5eae@bupt.moe>
 <1c5e2ef7-f2e5-401d-8acd-0605b117dfcb@wdc.com>
 <43f21464-c084-42e0-bb5a-0572e3385b02@wdc.com>
 <tencent_6AE63A4E1F1CC94E1625B595@qq.com>
 <b86ab184-7028-4d58-8acf-1f995348a6f6@wdc.com>
 <tencent_29ACBA272F8BC2BE2BCCB091@qq.com>
In-Reply-To: <tencent_29ACBA272F8BC2BE2BCCB091@qq.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8580:EE_
x-ms-office365-filtering-correlation-id: 17f3f811-1639-437f-c1d0-08ddf601a2d6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|4053099003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cTBZSFhLV0JGSjZPNHFReHk4ZU5rRkdjNWRiTlYvNE1ZTVFPQThXZEhOTVVv?=
 =?utf-8?B?RXN1czJDMXJacGhTcHRJMVVjRndxZWVob0N5bHBHcFFVR0IrcDZtOUJVRnEy?=
 =?utf-8?B?cGlJVW5KS3N3czdJWWVmTXh1S2JHMFlRNUErSlJ2aHFkNUdXNlZEQk9TQnBL?=
 =?utf-8?B?NDYzeXZtTXkrM2Y4em9PbXR3SmV0S3Brb2NBbXhMek00V1dHYWpMTWhYa08x?=
 =?utf-8?B?UElXTk1qSmdWVDV4ZjJha1FYaDNFZk5CZGhkd3RYR25uTVU0ZC9KSmFXaXJu?=
 =?utf-8?B?K1dWd2FlL0NKZFpLRjNQd0R4ZldTT3V2MUhaN3FVTUw3S3NIWFMwS0ZVRjFU?=
 =?utf-8?B?eDBTMWNtVWtQMnk3cDkyZVhsRlY1YlA5QkRRNTk1NVEvald2MkVKM2tUWC9a?=
 =?utf-8?B?Z0ZnbU1NaEY5aGlEZlZ0Vnd0THRna2lXaW1jSHd5RXpPOGpPRk4wV1VjN0Fa?=
 =?utf-8?B?aC9vSjdrQ2ticTFqRE5GaHU1M0FsbjFtRzhoT25xcnVkQ3hLS3JsS3J0ZHF6?=
 =?utf-8?B?V3lVSFNEUUp4U3JVcFdlMzJtM0tTelgzZkttWEVaWmloOWVqbGY3QWVQcDJQ?=
 =?utf-8?B?UGFhQ2NDVmNNbWg0dGxwVXdVNWFjTU0xUVJ0ZGsva1E1RXAzMncxS1J0YWxl?=
 =?utf-8?B?NnNwVHh5clAzSXpGUkZxVStaTjd0OEhwOXRVT2Npd2ZqZ1lBZHNPK2tNOXJn?=
 =?utf-8?B?dVAzU21HaU55bHY5cGxTZHRZZCthUDg2OGZMSW5BLzJsbGdUSzdzQVlvN0JK?=
 =?utf-8?B?R1BQUkNMTkxNTjlDelpEdWIxMm5xVjFNald5UVFIZ1B6bXNtcFRvS09EcnNL?=
 =?utf-8?B?SXdveWp0VEs2OEd6OFFaUkFZTW53aVZlYjJEdlYvS0hLUzd6aDZDbUtramdQ?=
 =?utf-8?B?S2tsZ2lPNSs2WkkwQ2lRQ3hBSXU5M3drWGtaTUN5VE0xSHl3aG9BRmFieVhB?=
 =?utf-8?B?dnliRmJPcnlmWEYvTjE5b1ArMlArNVJCdWxRSk9DTXIyWW1WYnE0UHRqcmdv?=
 =?utf-8?B?Q1FWSlNRbmVidnZzV3Z2RGtCanRDblQ0aWw2Tnh1WEJ2eU0vK0VvQVczdUNN?=
 =?utf-8?B?blljc3BNMzBRblpxM1l0emlkdTI2RnduU05iTnEyeDlIT3ZwMENsMzdoMlBG?=
 =?utf-8?B?YjFFdE5tV05FTTVvLzliamRZaWdXOUVIZFBnYSsralhBWEpraStBZExnQlM5?=
 =?utf-8?B?K2RnK01XOVpNOVlPckdCZjNNNVRGaGRsVDBiTUFBR3J1STJzRVpnZlBGa1Vw?=
 =?utf-8?B?b3dZa3ZodnlENUd0SzhNNjF5U1VJYUtaN3pnb3RZUlhuVGZrNXBMMzE2OXlj?=
 =?utf-8?B?Z2gxOVpSdzBieTVrRVBycVMrRExyNFYwMHhUUUpwYVJJQ2FPUEJyOU9XZE10?=
 =?utf-8?B?ODdUakg3V3JOa05FZ05XRVkxdllvNCs5NURMZGNxSW40Tm44MVE1a3oyNFFD?=
 =?utf-8?B?UDk4R1dNeUJzZkwxWFByRWI0Si96ZlNXeUk0a0xaSlFKTG81bVJXd3J3N2tM?=
 =?utf-8?B?WElwUGcycG5rb0prRExIajcrTmIyaU1UTFBDbTlQZWsxbHNLVDVqRUhLVWty?=
 =?utf-8?B?d0pqKzZEeC8yMlJXSjlkazBaTUFmbU9KRThhZnlueUI2RUZUN2lmYWd4aUtL?=
 =?utf-8?B?bHFQZUx6dzdnSHhRdnNzRUpwazN5cnRRcmpKcXN3NXZNMjl5U25sVHl0NDM1?=
 =?utf-8?B?S1JJeGEwblZRNitOeFkyS3hCeCtIM1V4ejEzNmx6R1c4L1hOT1JLb2tCYU1I?=
 =?utf-8?B?TEdrSHJRL0RIeHFzM1BUYU1mQUFjR08va3dGSUtmT0FKR1E2Y09lY3U4allh?=
 =?utf-8?B?R05iS3Y5REFrVm1yUHp0aTNEODBEdVErQXNuRmljT0Zyd2xxSnE1WXBZc2F2?=
 =?utf-8?B?UWFlcUg3dDBXMUNBMkNicUdnY3dpUWJlaEZiZU1TK0sxbjRjcnhibFo2YVVO?=
 =?utf-8?B?M0Mza3I3REYzZnEvSEhORitndnZUM21YTU9mQ2pLa0ZiRnRqN2hFbXZNY3Vr?=
 =?utf-8?Q?kLcJh4KN4nmnkMNXzH514BeONYlxuc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(4053099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cHRYSWIrMkNJaWd0VTdHd1RXNzBBT1hDV0pLWUFEV2NGaGZiL1dnenlyQmd4?=
 =?utf-8?B?ZDM0cjgwOGR5ZFJWdVFSb1ZQaFhubUg4RFhLYWd2cDNIVzFmQ09vSlQzTGRl?=
 =?utf-8?B?NXVYS0xrWldMbEZjSWp3N1lKQjk2eDJ5Y0RBWVVGY0I4Qm1oaDhIODRmclF3?=
 =?utf-8?B?VkNpS1RQd1dFS0o1SXpUd1NvZEk0b0hXVVQrc1d5ZFFGV0JnVi8wTEtscFZw?=
 =?utf-8?B?YWZLaFd3NXp0ekdRTEZQelhoQVRWN3hsaXc4WnBOSGo2NW5NQ1JtL2NNOGU5?=
 =?utf-8?B?dytTU0Fib0pRZmhaU2Nnek9KZzhHK2RMRnkyOUhMY2Nlc0xiTGJyejcvWVZa?=
 =?utf-8?B?L01tNmg4dW9ibFlMbmhBY3JwVldXcjRPZHg2ZXRGQXpBMzJ1VWplL1BwWXF6?=
 =?utf-8?B?OG5mcVJFV01PZDVGeU43TEl5YW5majhESnlMSGhYTTJ4QmtlYjQ5cmlKejJ5?=
 =?utf-8?B?a2FKMXlndi9UVjNaZ3ltNnRVMDVCMCs5USsvbDhxblhHUkVDbitCVEhaU3FR?=
 =?utf-8?B?bnUyMlJEOVQ4RDZBNk1RdXFUdGRabkhQdi8yWGRabE1TTDFOczFreFNaR3pT?=
 =?utf-8?B?TXFWbGZZY0p4S2lVdnJTVXhRdi9wamNmUFdISlpUaUZIdHdWTm1YRFNFR2lF?=
 =?utf-8?B?WXhuOGF4QnpPYnh0elVia1IxSXdVS1FKaS8rQ000akp2YkdTdm9ySnRtUGJN?=
 =?utf-8?B?SGc0eGpHUHJrbktDTFMxdldhdmp1OUxxOXRDSllvSlN6QXFoSFhGM3crNzBi?=
 =?utf-8?B?MEtIdTcxbHlPTEpBWTlRcFhNT01IbjhyQ1lzS051ZERNQ0I4dk52Q29PMHNJ?=
 =?utf-8?B?M3pxRlJjRzQwRUxlOHF2VWZDbEptOG9SQzRySFJzOW5RbnV0VHhwWmtjRXVO?=
 =?utf-8?B?T25iL1poUkVzeFQ2TTU2ZnhhajY0TzNoUnJrK0EzNlRKS3JIYzRadjVqa3ZF?=
 =?utf-8?B?cUtFNmpSZk5yYmlpdHRtTDFaYmc0aU9XT0ZiNm40WmM0ZkR6T2JlZ0RsMFF6?=
 =?utf-8?B?TWVPckh5VVZaUWN6NHBVNEtlVHFKZXlyZmhsZU9na2hJV2E3YVYzZUhXaWhw?=
 =?utf-8?B?RWt5MGYxcUZxZHhRRUxSN3Y3OHZQZ0xiVDd6VU9kbjYwYWxPOXo0Tm5HeVdo?=
 =?utf-8?B?Q2lmZU02YXJQVENxZ0tGVzRIMldCeU44V25xU05pRUo0ZGxENWpCclZaUUNQ?=
 =?utf-8?B?eUxqWElXcGVYY0l6YjRoa1JPWnhLdlh5Y2ZhVlluSis0bVcySmhocHV2eUlL?=
 =?utf-8?B?bTlETGthQndHZytrYnR6a3l0a3g2RFhlV0RBOEFrRmhqM0tGZm1vczJFMjkv?=
 =?utf-8?B?NmxPN01RT2JiMEpkNW9Zak9MUDVaUVdXWWVJNXFHVWdTdnc5NXFaTGNYenR2?=
 =?utf-8?B?cTdCaGpyaVFwVWJZRzR6MjdGWi9xVmRDbUJDTkJveFAyd3JwUDZNeCtsTmIr?=
 =?utf-8?B?UGdFWXNpZkMvZDlnVTF5bnE0c1FhMmNZdUloSTNQOGYyVWw1NURGUEtIMXNW?=
 =?utf-8?B?YndmWnNLSGpQbVR4ZjRkN0E2TFZjUlp1MTdaclV2b29EcGNjaEdXT1FIUTRI?=
 =?utf-8?B?U01LUXNhVnVpT3pyN3RBZTl0ZDNjbzdjNUpCWWRxSXBqMEV3ejk5cWpGaVE2?=
 =?utf-8?B?d1JsSFF5M1FBbmZIYW5xSkhja0FTbnBiOTFibVd0UmlLaGdhazAyMlRBQ3ly?=
 =?utf-8?B?a2VYczcvL2VXcjN6eXc3Ky9selVxeWZDcjBDWFRnL08xMWxCdC9FVHFoVkZM?=
 =?utf-8?B?RXViMW43ZmVoWDhyZGdXNTJJVndJNUtzM0wyQjRJZWhRd28xazlGaDFqVjA1?=
 =?utf-8?B?S0lIZGpVY0taM0RwVnZIWDJyWEZYL2ZFSk1sTCs5V1RhT09Db1ljS1VGRDgy?=
 =?utf-8?B?Y1FrMW5aWDJ6R1dsaWkrNGIyRXF4bkt1M21COStnUDNzMDRudHRZNGtkUGhp?=
 =?utf-8?B?aWp6OXNMelpEbGNaUG1RQ3JIaDZRZzkycDJIMHQzNnlPS0dwL0lZNmg5VUta?=
 =?utf-8?B?dzJCTmFCeVl0cnBRRzRmYmlXY0dUcFU0WGVVMXBQWE9td01CL0V1OUFqZ3Ir?=
 =?utf-8?B?OVRYV3JDTjZ2K2IvYVZwYUpPVFYrZk0yNDFLdlV4RStTSC9mN2JXR0FrcDZL?=
 =?utf-8?B?cVU3amZ0L2swbEtnakZFbDdYRDRXdGY2OTdLZSsxQmEvcmVmRHFFeldqZE4v?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: multipart/mixed;
	boundary="_002_c3260c7110bf43158cb6f42933c12b55wdccom_"
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0gZaGI3D2NyxbaTs0FE2uCmia0NW9mYv687hHXQn5wyDV4FtF8F6b/p15/Jg8b72Mp5TMNby8xwjEbkdWXLfDbuW5f5RcNpi1qLXxoOE1JTxb3XbpkYxL0iFdXzFHrPPO8vv0Rohbxu1bPq8cEPW29E+pSR/6I6xeqALAkcEIScFma/WH8WgobMWBaWvemepIuIdcmjMcpbf9Xqx/CK+SgRvtkh6Cv72xFEGeWWalSvfX0Brq2EajLvYH9ypUFV1yObCtbDFLmBkydY2CuOnfdSoF/4J8xLgiLyV+VevokGG/Hf7p63EjG5eMJhCbPvG5jGlZbzrZACwfdKXfAfXi5tfn1kNHXXhhseYjqLH0aouREwUbFqNJMlzA9RV1tJuwQltbTjRe4SdteoC8iX7MyzeQrGXkHqXRVKyrCyMMaFsNM/yQ/YA+h+jmKMrsEb6bqZhGZ9XuRvzuYOLQJWwln6COLONoKZL3CYlyAji+vrHzU04HSl8L0pL03M3r80fVu4I5ct8hld2hjlGo4G67gKJKWjBzhcGyQORcmCPaCHikn3EiG7/oLgisJYcroFjmVCGlZ4hVp91VbyWNklRr7TUxpir6MQFfA6obxewYakBKczzlo4zrNK6eyQq/fDw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f3f811-1639-437f-c1d0-08ddf601a2d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 15:48:24.3775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZ7Mq1viaqK6T0JjKnIo8skqzRNe0xyapvIUJUEDJPD0KwQysbIcbcpdUGMLbUu9CaEbWwtzvTQmKRYawVQh3f45wk6NC63/niWhBrcIcDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8580

--_002_c3260c7110bf43158cb6f42933c12b55wdccom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <C87262AE5BD998428E9715B52D1EF66F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gOS8xNy8yNSAxMDoyOCBBTSwgSEFOIFl1d2VpIHdyb3RlOg0KPj4gT24gOS8xNy8yNSA2OjIw
IEFNLCBIQU4gWXV3ZWkgd3JvdGU6DQo+Pj4+IENhbiB5b3UgdHJ5IGF0dGFjaGVkICh1bnRlc3Rl
ZCkgcGF0Y2g/DQo+Pj4gWyAgIDE4LjkzNTY0MF0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGMpOiB6
b25lZDogMzkwMjAgYWN0aXZlIHpvbmVzIG9uIC9kZXYvc2RjIGV4Y2VlZHMgbWF4X2FjdGl2ZV96
b25lcyAxMjgNCj4+PiBbICAgMTguOTM3MzM1XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYyk6IHpv
bmVkOiBmYWlsZWQgdG8gcmVhZCBkZXZpY2Ugem9uZSBpbmZvOiAtNQ0KPj4+IFsgICAxOC45NTcw
NDJdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RjKTogb3Blbl9jdHJlZSBmYWlsZWQ6IC01DQo+Pj4g
WyAgIDE5LjAzNzkwMl0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGQpOiB6b25lZDogMzE0MTkgYWN0
aXZlIHpvbmVzIG9uIC9kZXYvc2RkIGV4Y2VlZHMgbWF4X2FjdGl2ZV96b25lcyAxMjgNCj4+PiBb
ICAgMTkuMDQwNjUwXSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkZCk6IHpvbmVkOiBmYWlsZWQgdG8g
cmVhZCBkZXZpY2Ugem9uZSBpbmZvOiAtNQ0KPj4+IFsgICAxOS4wNjAzNDldIEJUUkZTIGVycm9y
IChkZXZpY2Ugc2RkKTogb3Blbl9jdHJlZSBmYWlsZWQ6IC01DQo+Pj4gU2VlbXMgc3RpbGwgcmVq
ZWN0aW5nIG1vdW50IGV4aXN0aW5nIHZvbHVtZS4NCj4+IE9rIG5leHQgdHJ5IGF0dGFjaGVkLg0K
PiBzdGlsbCB1bmFibGUgdG8gbW91bnQuICBJIGFkZGVkIGEgZG1lc2cgbGluZSB0byBvdXRwdXQg
dGhlc2UgdmFyaWFibGVzLg0KPg0KPiBbICAzMDguMzUxMjcyXSBCdHJmcyBsb2FkZWQsIGV4cGVy
aW1lbnRhbD1vbiwgZGVidWc9b24sIGFzc2VydD1vbiwgem9uZWQ9eWVzLCBmc3Zlcml0eT15ZXMN
Cj4gWyAgMzEyLjM3OTQ3OF0gQlRSRlM6IGRldmljZSBsYWJlbCBEQVRBNCBkZXZpZCAxIHRyYW5z
aWQgNzgzMCAvZGV2L3NkYyAoODozMikgc2Nhbm5lZCBieSBtb3VudCAoMzE2MykNCj4gWyAgMzEy
LjM4MzA5OF0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYyk6IGZpcnN0IG1vdW50IG9mIGZpbGVzeXN0
ZW0gMjY2MmM1YTMtZWFjMC00NzdhLWE4MmEtYjI5OGExNmRhZTAyDQo+IFsgIDMxMi4zODMxMjJd
IEJUUkZTIGluZm8gKGRldmljZSBzZGMpOiB1c2luZyBjcmMzMmMgKGNyYzMyYy1saWIpIGNoZWNr
c3VtIGFsZ29yaXRobQ0KPiBbICAzMTMuMzI3Njk4XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYyk6
IHpvbmVkOiAzOTAyMCBhY3RpdmUgem9uZXMgb24gL2Rldi9zZGMgZXhjZWVkcyBtYXhfYWN0aXZl
X3pvbmVzIDEyOA0KPiBbICAzMTMuMzI3NzQ1XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYyk6IHpv
bmVkOiBiZGV2X21heF9hY3RpdmVfem9uZXM6IDAgYmRldl9tYXhfb3Blbl96b25lcyA6MTI4DQo+
IFsgIDMxMy4zMjc5MzFdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RjKTogem9uZWQ6IGZhaWxlZCB0
byByZWFkIGRldmljZSB6b25lIGluZm86IC01DQo+IFsgIDMxMy4zNDQ1MTVdIEJUUkZTIGVycm9y
IChkZXZpY2Ugc2RjKTogb3Blbl9jdHJlZSBmYWlsZWQ6IC01DQo+IFsgIDMxMy4zNTU2OTBdIEJU
UkZTOiBkZXZpY2UgbGFiZWwgREFUQTIgZGV2aWQgMSB0cmFuc2lkIDEyMDY3IC9kZXYvc2RkICg4
OjQ4KSBzY2FubmVkIGJ5IG1vdW50ICgzMTYzKQ0KPiBbICAzMTMuMzU4ODI4XSBCVFJGUyBpbmZv
IChkZXZpY2Ugc2RkKTogZmlyc3QgbW91bnQgb2YgZmlsZXN5c3RlbSA2YTc1ZjM0Yi0xYjJlLTQw
ZjUtODdlZi1kODNkOTgwMTQ4YjgNCj4gWyAgMzEzLjM1ODg0NF0gQlRSRlMgaW5mbyAoZGV2aWNl
IHNkZCk6IHVzaW5nIGNyYzMyYyAoY3JjMzJjLWxpYikgY2hlY2tzdW0gYWxnb3JpdGhtDQo+IFsg
IDMxNC4xNzUwMzddIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RkKTogem9uZWQ6IDMxNDE5IGFjdGl2
ZSB6b25lcyBvbiAvZGV2L3NkZCBleGNlZWRzIG1heF9hY3RpdmVfem9uZXMgMTI4DQo+IFsgIDMx
NC4xNzUxMDZdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RkKTogem9uZWQ6IGJkZXZfbWF4X2FjdGl2
ZV96b25lczogMCBiZGV2X21heF9vcGVuX3pvbmVzIDoxMjgNCj4gWyAgMzE0LjE3NTMyNl0gQlRS
RlMgZXJyb3IgKGRldmljZSBzZGQpOiB6b25lZDogZmFpbGVkIHRvIHJlYWQgZGV2aWNlIHpvbmUg
aW5mbzogLTUNCj4gWyAgMzE0LjIwMDMzMl0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGQpOiBvcGVu
X2N0cmVlIGZhaWxlZDogLTUNCkFoIG9rLCBzbyB0aGlzIGlzIGEgYml0IGRpZmZlcmVudCBmcm9t
IHdoYXQgSSd2ZSB0aG91Z2h0Lg0KDQpJdCBpc24ndCB0aGF0IHlvdXIgZGV2aWNlIGlzIHJlcG9y
dGluZyBtYXhfb3Blbl96b25lcyBhcyAwIGJ1dCAxMjggDQood2hpY2ggaXMgdGhlIEJUUkZTIGRl
ZmF1bHQgYXMgd2VsbCBzbyBJIGdvdCB0aGUgd3JvbmcgaW1wcmVzc2lvbikuDQoNClRoZSBxdWlj
ayBoYWNrIHdvdWxkIGJlIHRvIGlnbm9yZSB0aGUgbWF4X2FjdGl2ZSBzZXR0aW5nIGluIHRoaXMg
Y2FzZS4gDQpUaGlzIHNob3VsZCBtYWtlIHlvdXIgZGV2aWNlIGJlaW5nIG1vdW50YWJsZSBhZ2Fp
biBhbmQgd2UgY2FuIGhhdmUgYSBmaXggDQpmb3IgdGhlIG5leHQgLXJjLg0KDQpUaGUgcmVhbCBm
aXggKGJ1dCBhIGJpdCBtb3JlIGludm9sdmVkKSB3aWxsIGJlIHRvIGZpbmlzaCBhbGwgem9uZXMg
YWJvdmUgDQptYXhfYWN0aXZlL21heF9vcGVuIGFuZCBldmVudHVhbGx5IGJhbGFuY2UgdGhlbSB0
byByZWNsYWltIHRoZSBoYWxmIA0Kd3JpdHRlbiB6b25lcy4NCg0KUGxlYXNlIGZpbmQgdGhlIHBh
dGNoIGF0dGFjaGVkLiBJJ2xsIHNlbmQgYSBmb3JtYWwgb25lIG9uY2UgaXQgd29ya3MgDQpzdWNj
ZXNzZnVsLg==

--_002_c3260c7110bf43158cb6f42933c12b55wdccom_
Content-Type: text/x-patch; name="max-active.patch"
Content-Description: max-active.patch
Content-Disposition: attachment; filename="max-active.patch"; size=868;
	creation-date="Wed, 17 Sep 2025 15:48:24 GMT";
	modification-date="Wed, 17 Sep 2025 15:48:24 GMT"
Content-ID: <5EFC79986DA4E544959554EBDD40CEE3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3pvbmVkLmMgYi9mcy9idHJmcy96b25lZC5jCmluZGV4IGJh
NDQ0ZTQxMjYxMy4uZTIxYjU3YTY4YjNjIDEwMDY0NAotLS0gYS9mcy9idHJmcy96b25lZC5jCisr
KyBiL2ZzL2J0cmZzL3pvbmVkLmMKQEAgLTUxNCw2ICs1MTQsMTEgQEAgaW50IGJ0cmZzX2dldF9k
ZXZfem9uZV9pbmZvKHN0cnVjdCBidHJmc19kZXZpY2UgKmRldmljZSwgYm9vbCBwb3B1bGF0ZV9j
YWNoZSkKIAogCWlmIChtYXhfYWN0aXZlX3pvbmVzKSB7CiAJCWlmIChuYWN0aXZlID4gbWF4X2Fj
dGl2ZV96b25lcykgeworCQkJaWYgKGJkZXZfbWF4X2FjdGl2ZV96b25lcyhiZGV2KSA9PSAwKSB7
CisJCQkJbWF4X2FjdGl2ZV96b25lcyA9IDA7CisJCQkJem9uZV9pbmZvLT5tYXhfYWN0aXZlX3pv
bmVzID0gMDsKKwkJCQlnb3RvIHZhbGlkYXRlOworCQkJfQogCQkJYnRyZnNfZXJyKGRldmljZS0+
ZnNfaW5mbywKIAkJCSJ6b25lZDogJXUgYWN0aXZlIHpvbmVzIG9uICVzIGV4Y2VlZHMgbWF4X2Fj
dGl2ZV96b25lcyAldSIsCiAJCQkJCSBuYWN0aXZlLCByY3VfZGVyZWZlcmVuY2UoZGV2aWNlLT5u
YW1lKSwKQEAgLTUyNiw2ICs1MzEsNyBAQCBpbnQgYnRyZnNfZ2V0X2Rldl96b25lX2luZm8oc3Ry
dWN0IGJ0cmZzX2RldmljZSAqZGV2aWNlLCBib29sIHBvcHVsYXRlX2NhY2hlKQogCQlzZXRfYml0
KEJUUkZTX0ZTX0FDVElWRV9aT05FX1RSQUNLSU5HLCAmZnNfaW5mby0+ZmxhZ3MpOwogCX0KIAor
dmFsaWRhdGU6CiAJLyogVmFsaWRhdGUgc3VwZXJibG9jayBsb2cgKi8KIAlucl96b25lcyA9IEJU
UkZTX05SX1NCX0xPR19aT05FUzsKIAlmb3IgKGkgPSAwOyBpIDwgQlRSRlNfU1VQRVJfTUlSUk9S
X01BWDsgaSsrKSB7Cg==

--_002_c3260c7110bf43158cb6f42933c12b55wdccom_--

