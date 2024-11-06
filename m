Return-Path: <linux-btrfs+bounces-9360-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656EB9BE515
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 12:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B1A1C20C6B
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 11:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AB31DE2BA;
	Wed,  6 Nov 2024 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RO86fP4l";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uU6Ta5+x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA27D1DC720
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890882; cv=fail; b=OPRnPSYXnywidUq2eXCqiTvTRlhPCi6Ro54opyiU5lxWKsNevwJWGr3FXQNr2Evi3XU9JsIF4bdHXB0JI43XfiiJAGWlN7CsyUs+6bQ98RykixoD49D/vpAeTIH2iHFkMT3ZcdCOLlf2/dNvJbv2ttY+V21bvyJjnIzBw3UCrmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890882; c=relaxed/simple;
	bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cEOd8sWwf/URSuACJylWQvggn69Ke2cArt28hSIPYfhiciRESZukdT5j8P5lfrWqhCPlTSWXWX1u7yU2ntVf6+cRC16jUrKdi6EZHeHIU/DZ2pbT+LsPNV4chUT6FnN3eYnw4xPCD/uJxeRVUG3RqLNxQelqm1i88sxJ9mNKmjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RO86fP4l; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=uU6Ta5+x; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730890880; x=1762426880;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
  b=RO86fP4lKUIe7wB/JIIPegvivlZQ9tOXCcf/q/VjvOZX88mQLrd3RKoQ
   gfslX7t8Kt1srWstRao5tMCimy6EPysquoYmzvNPRIlj61Dr8gdte0UQ1
   iuag5LKLbxvOySbAP5tKnaA+cxmpqT5XvePxWb8EcpCm5L4hyCRyjjtAC
   ivH0dgLU6HmaU2k7n3i4GGuCMOnaEDa6gl47MEbDzzB9C0dCO84wVwYgp
   6xw4YODzOw19V0fHnlPhCgdB1mCCLDSYmEnKNdoucQYid/IV1otAgbcpL
   NYDFy/sl5PZ63SOndXOvkx1HgPnbhjuWOV/5pbrCkbfUyIctMxDA00kzf
   g==;
X-CSE-ConnectionGUID: jn7ZS2HZQTulB1Ot2pAi1Q==
X-CSE-MsgGUID: xGNRxJkGRSOhiZVtekTBjA==
X-IronPort-AV: E=Sophos;i="6.11,262,1725292800"; 
   d="scan'208";a="30757279"
Received: from mail-dm3nam02lp2040.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2024 19:01:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=REJaZ4jUCTpO6cuhjb4MOgXKj16dKAiFDfWbnZboSM3W+B/XWqWJIs+AQGHgprTh4EOpWf7VsZnu+At9CYNxFSebkOb4l6+/H1+K7Amy3BvZXC/WA8NzYGG6/dcfTtbcEubZnMOc3oOURFdcWSctQ8ZajfYFpBYZsjQJTpP1AxHuoywemJQjntsjn2eixk0RNgwuti3ZyzkDV3/xpTNlNqlauxwJswgS8lhBCEgVxxczpOM8uLRFUeEUPSl+Xiu9w96E1C21ANUAzDa6bjxlxDXxcoCOMJZ4sTmrA0Fyrq+2V4pbosGhmYBfbbS89XLbf/hOV0oa6LiFEql8ZTXfyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
 b=Wb9lJK/V3cw8FmqlaVPjARTEPPMpp5DkpmbLz64OUm33LlBrhoisbeFNQSBqQuPqeejXl0OOXyRs6Q7a1MWYElRf/0ujyl2eMcEbVsOojuiQEUK4wtGBlFh4YXjL7kM5byeUJLyLSVUmxny0er58mcUxgvaBuNkaEUJDNofBX4Y1Yjky+SrDKQA5VhD7EHzWhDy/2eSczfiY15Ja8ZApZRZdbSDt0xb2gCtiVnZ8ONaz1II4p5ZMJYT1ENSZCOQKfl4S+qFfex50Pgy3x3+V4c9GEOv5fvlbv6rxZHKV/R+RjsH4Z7qB6WDotwCIOwkeN6q2akzqPIRPP3L57VJ6DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
 b=uU6Ta5+xP7jWieVzUyw/IkN2HnaAtiDvjJpjAcSjNbR6voeHZfth3Mu7mAoO+t+gAbfi++DxP5MQ7M3it4Ew0Esva3KBdVvqqzNlIa9qjDG+IMRvHUkmCoFfxFJgmnc8R0ZQ3M2nPtxsV2Uoao+L5XMOlC79wW3fPgUQ9oF66P8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6590.namprd04.prod.outlook.com (2603:10b6:5:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 11:01:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 11:01:17 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: update stale comment for struct
 btrfs_delayed_ref_node::add_list
Thread-Topic: [PATCH] btrfs: update stale comment for struct
 btrfs_delayed_ref_node::add_list
Thread-Index: AQHbLtAg1cdacXODVEyrnoGiAxhs/rKqGMeA
Date: Wed, 6 Nov 2024 11:01:17 +0000
Message-ID: <c525a4b0-8cb2-4a10-b12c-7a864eaea3fa@wdc.com>
References:
 <5fbc6e1d2a3ab67f1304f1115fdbc831c1e4557a.1730734691.git.fdmanana@suse.com>
In-Reply-To:
 <5fbc6e1d2a3ab67f1304f1115fdbc831c1e4557a.1730734691.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6590:EE_
x-ms-office365-filtering-correlation-id: 6f6a8b53-76d8-4094-940e-08dcfe5256e1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N2xTc0tqVHRRTmgveDRPc2RCamdWeStEbnhCNUdwWkRwSm1PbW9jRGQ2MEJl?=
 =?utf-8?B?YlMrcW92WDcwS2YwUnRPN2hNTVN2b014OTBDa0lrdjFJUkp6M1FnS29vZmti?=
 =?utf-8?B?bk5sdlBxcEhpbHM3WmloaVQ5Ri9keUFnTTFJSkpyTmwvV1hFSmRycklvSHhm?=
 =?utf-8?B?eit0UmcyYmE0LzFNOWwrV212UnY0eFVHTGhZMFdJYlNnQ1NMZVZSQVJHYmZT?=
 =?utf-8?B?cFhFS1VmZ1V2T0NNQ0gvSEtTS0hBUk5EQW9DQnY2N2ZHdmZ4Ym1tcU9KT0FS?=
 =?utf-8?B?ZWQrWDZpc09QQnBWSSt4UVdpRFlwWFZ0RkRhTVRjbkpCaThJTVVoRlZGb0V2?=
 =?utf-8?B?N0hNM3ppZWRSL0t1TStWWE90enlJb2x0V2FRdW4vMk5jZ21KdHNIWGpKN1o5?=
 =?utf-8?B?U09CcG1yWk15YkVLMlZ0bSsrMTF4LzJ0LzNYRWFKNmQwS2lyZlppbVk2UWZW?=
 =?utf-8?B?SjIvUDJ5OHY1K3N1UUhuQmxjaFJua1U4cnZ3bjRiLzd3LzQ1STFjYkljVmxH?=
 =?utf-8?B?UmVTbjU3dzFUQThmUCs1S0llZUJPUzFrK2tyczRrem9xcTRHcmVSOC9jaEdZ?=
 =?utf-8?B?Y3RCc1BvaS9Id096MEtHZGQ2ZkZ5ekwzUEd6SFlGR0w2NmV3Q1pBZEZWRDlW?=
 =?utf-8?B?VVp6VFJHeWgxRExnOVptUHEzQTROcUUySEcyV1lJaXA1aXZoaVhkd3hvdGEv?=
 =?utf-8?B?OXJoUUdEdURKakNOOEdHNHFYUnYwOEJJWTBIalBCaWlIL1dOWTRoZm1qM21W?=
 =?utf-8?B?MURuMm5LeFhtM3ZWQ3Q4WXJCRjlxa1l2OEhlVk5pWWxpZG1OdTdkT2RSeGNO?=
 =?utf-8?B?TXJ4T0hCT1NhZlYxUmNFRjJ2cUlTSGtYejJjLzdjWWNpaG51ZkJZWnQzWHhi?=
 =?utf-8?B?QXMwTFROTG9HbWMrMjdGMzJaMUszajNiUTNKaEZzcXNjcjFIUXlxZ21PUHdB?=
 =?utf-8?B?ckIxbG5MVVRETExzYUx6R1ZLV2t5YmY0VGRWL2lyeWx2a1ZBUi9WamJ2b1My?=
 =?utf-8?B?aWw2MjlEeTVtT1RhNVEwbStLdEpJclk4eUJkeG1KODY0azdxSDRFUlFJWWpP?=
 =?utf-8?B?V1Mwb2NHSjViS3hyelkyMWdpS2xTcDVSSktSZ2JQTllqMjZFcjdQQjVBWjFh?=
 =?utf-8?B?TjFPWGhPWU9uTFAxV1JzN0hLVExnR0t6Z2JTQkpIR084VHFHQ2g4Z2lWQk9Z?=
 =?utf-8?B?anZrazZ5TkhtK2FZeDAxNW9DVG8xMzF1eHZzSll1bmdZaldUUlEzRUdSeVli?=
 =?utf-8?B?aDVrd2RWc0ZKWHVyY256dUxzVG9hRVFXQWYrS2N0Z2p1N29ZcDBqTWgyQVZD?=
 =?utf-8?B?VFNzTGp4UENLcDdsMVVsTTdZOW00c05EOU1SK0xwelZWRkFWc3UwUGZPbmZH?=
 =?utf-8?B?YWttSlVnK1dITFcyRjQrb0RFSVk2d3hOSUdOWUxIazVIU1I4YlJWaURybmJK?=
 =?utf-8?B?ancvSnhEU0hPMnEwRzdvREYycWNqQWw3eFFNSlFSNkdBc2taWG9LanpGejQy?=
 =?utf-8?B?YjNhbW9lWFF1SFIvQjAvSTgyVC9MamptMVNjQXBHN05ZV3JwWGU4NUVqMVZu?=
 =?utf-8?B?eHAxa291QWdtaVdiQk0yYVVKZ3pacDljLzcxTHR4V1ZTSTRvRGs4OUdPZDVh?=
 =?utf-8?B?eUljYUdaWkE3SmZ4SVhPaGZmOHJ3RzgyODlwTW0zQlpNY0tHMGVGYlJJWE5q?=
 =?utf-8?B?amNUL2pZc2RtNUdEYTVWdGI5NURRRWFvMm5aOG9FTHJNZ3RHR3UrR2dTYlpW?=
 =?utf-8?B?R3ZKZDU3dU10Zkd4am9TVjVhd2VMVUlKc0EzWjhUYkhFQXM0bGxqQjl6djJm?=
 =?utf-8?Q?KG3+AUgUTu2ZAliUCdNlfCGq/hOWDUcF3s7NE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aDBsSXRiQk50b0FJQkIzMVJZNEhFcGZDT0ZtSkNSL1RXNVhHN0xEYmZLemNq?=
 =?utf-8?B?VzFuckx0WHc1dGl1Tzg4NVVXd0ZPRFFJcXJRb3dDdmdJaFFxRWZTbEZtMFpz?=
 =?utf-8?B?MWpwL0hJSWtyRUQ2bGRaOGhtaU5JMDNhN0FOUTB6M3pQbTg0ZHVBZzB1QkRq?=
 =?utf-8?B?dFo5d0NUTkNwbVY1bnV6dmY4aGlwQklaa3RqaUpCbGxwYU9rTWwxNFIzbVov?=
 =?utf-8?B?VzI3a2lzV1R6QkhtaXhIRVliS3lVREFjMDdhTnM3YWY0eDVycFR6ekVHNGth?=
 =?utf-8?B?Y3JDWHFXNW81L3Y4aUYxMDQ4RjFWMXhCVWI0SE9PRWFjZDdrTi9Sb0F3RVdx?=
 =?utf-8?B?dkxVSGZzSXNuU1ZNamdzczVWdlpxVENEVWY2TDZETTg0OFdDWmF0eW94SEhR?=
 =?utf-8?B?U3BKRVY1TDJPZ2hlamRsbUs4UFlNWUViM01OQlBmaTR4dkhveEdXYld6OE1P?=
 =?utf-8?B?NXp4ZENncmw2NFBYbnZGOU8yc3RsdDZldGNWbUFQOXp3K3RWM29odS9MbDU4?=
 =?utf-8?B?ejZXSkZ0LzV6RXlHa05vZ3YxZHdyRWFYc21BNE9OQlRMN0dmMmY0K0tOK2FN?=
 =?utf-8?B?RmFHeEJwcUpXR0NxWXhQeXVmYTFEdFFxV0tpWm5vNi83M3pOYVJaTGhRNEht?=
 =?utf-8?B?STFuUUFqWXNVTDN5SjhPUUVwWEVwZmFYVE1VOE9RVjh6eUpSSHpneTFHOXZu?=
 =?utf-8?B?NG5tS0w2T1BDaWl3WjBrTDUySEFlWG5adk9OaTZ1Sk9RN0Z4ZlFXY0ROQVR3?=
 =?utf-8?B?dE9nWUdOR3pkMVQ0MW5QWGpmNlczMFVBRFJRQ3BKb3VJMERFeTJCWlRZSTk0?=
 =?utf-8?B?c3ZHaVRXdkJwN1RKWmtwbGdUajNvTGYrazliNE90dUxNOGxZaVJGVVQwNVFh?=
 =?utf-8?B?SnpPQ2hqQ1FnTmlmSnhMK2x4L0cxa3IxVnR2UVZsWEdqdXhrM0RNQnJCVDdp?=
 =?utf-8?B?T2pPbVdUQmN0cG52SU1NRHJVNTQ4bWc1NG14UUZTcHZwUm1FZ2tTRjBDSUsr?=
 =?utf-8?B?RTNkcmVTVi9UcFpJbmY4T2t0MDhtTUh4QU5JbXFEUmxEcXNnUFdkdWp5NHhM?=
 =?utf-8?B?eFdXL0tibnJkL3VSMmU2d0VzQ1BPYUtnTGpTUHFOaC9NVFd1bm5HNnRHQWhu?=
 =?utf-8?B?Z3BCNTRPMnRjbkVPNXFidytCRlZEZngvWHdtQS9JYnpTdTNmbDRQSXMxMXBQ?=
 =?utf-8?B?VHdDdGxYR3BmY3ZwOEg0R21hOXFzOXJkUXN5eDRBWWdHeHIzV0Q5Q0pZWXZu?=
 =?utf-8?B?aldQaSsvS04rUElaNXI3Rkp4VlVsM3NsUmNqakcraXRMRXJUcGJONERnVkNy?=
 =?utf-8?B?ZEdZdDFzT1dPMHAvYVF6dnRoVSt3aXdmUlhmckxsL3lmS0h1azlneTF0UDNy?=
 =?utf-8?B?cTN0Z2pQNjVvTjBiME1jUktHU2xtUHZFK2huYkgzdWJ6ZENmMklBaHN0dVdF?=
 =?utf-8?B?Nko5VnpoQVdpVlhTM0ttMzdrS01laC9uaEdPRU1rVXhkZW5YVmNGYjZJQXIy?=
 =?utf-8?B?aWEyTHU5L0tSQzZOOTR5M1dubldaR2QrVXV5YTdOeTNRdFJncUxlVmEyRURk?=
 =?utf-8?B?NUw4eS8wb3ptSVo4S0RTbkdSQjN4RGZLSTZhTmlSTk4xeWk5bjlKWTMwTEUr?=
 =?utf-8?B?T2NneERlTno5ZnlWbU5BVTVkSXMySDA3bFhvUFdaS2F3MU56TWZoRXBkSEdH?=
 =?utf-8?B?YU1mMXd1dGxzbVhJdk5Eck9uNnprRXkrVk81UU5ndGdPY1YzV2N2TU15OWpO?=
 =?utf-8?B?anU2ck5lODlsQnAzWi93NGkxYVMrbjc2OHBPRVJYWG5hNmNQUHAyVlpsejU1?=
 =?utf-8?B?aG9YOGlBMmtyalFORkozTXhyQ2Q5b3lRMXdJcEZ3NEN1N0svL2VnbVJpZkZU?=
 =?utf-8?B?TEZScTNZWDIwWi9ocTNNdzNhektJUTk3eldEUFRiWVBpSnZPdGl3dXEyTE9X?=
 =?utf-8?B?dVhibU1IUHFJQjhxbFhaeWR2MnV5dWZ6UXQ3UnUrbzlSdFZMRG1JbXpxYWRW?=
 =?utf-8?B?c3dwVGRFd1MrTlJxVVJKOTkzT0hnS3YwUTU4dThHbkR0ZC92eURRandzWlIr?=
 =?utf-8?B?UE1UVENWWU51OWtEaFpHdTZZOXd4U0kvVkJzL0JEczcvR05LeDhURXhxOFlo?=
 =?utf-8?B?VEE0N3RsSWFaeUt0cURwZDRhWkZnYVJVWHpxUDlPUEEvdWcrZmN1anRXcG5G?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8711DF0E7FC9C6449DCF9E4043C92204@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/I/j8uMwnlqPsoKTu3t8g5McwpFfsyQAfFWU0m/WBannFadyWQua1bwF3WUvR5uxVHWHeYgftwip4dmaL3N0baxUPpJhdCSJ8UnSyCGAj1PECuJvdHZzZt16oia//dZW00uv6zOOtLmRlYT/HT6NsNFlnFWB9DMElEndnNtJjX18SWKyZMFgwjp1lSMiB2BcopK3g5YBqq9f29rEoHQQihcz4b8Z0IpH/AkLYSfiNexe4VTp0N4nzLWH//cp0nw/F3wAuj1iXD1szxEOGJxbcIqJLmOEzbU3OBIom7ppc8EdqMgo5WjPTm8JMqzf0XewLEr+0GiGAl7xdhr1EHSI/cwzXb/w3IJ2tvl10ctuAKIPSsDW8UcqWmm4iQcwZjv7uLuxq0xZuRJi2Kei0QQk+9eRNo55B+E2C2VUbBtNZh8jyuvOnNsXlSFzgDT3aPcI7Q2IYi1Ox6inYJ0ecpXuf52FYq31yUytxh+Yk+qlKzXJpIwrlWRm6QB8UwTDhB6SM5soKbIFAA+Dz+Yh0F0Le3T2hrbeB5KdIHfA6CB28fIfKb43HLAb3Fd/mOdGQ/o3aDqD1T0puhBh3jWGX4BJ3Scd+DIywgaoueD4/VEXjPrGwtB95iQTzhc1sRlwm+7S
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6a8b53-76d8-4094-940e-08dcfe5256e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 11:01:17.7624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MsjdEQZOsYV9OQ4g9+clzrZdH0lJjuT/2lYGlevW/gpiwVRxcUJYJcgqNI7TGtWBcGhVQMUJdo8J93VZNKIb/RtSF9IztXXwKI5U/2xvH5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6590

TG9va3MgZ29vZCB0byBtZSwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFu
bmVzLnRodW1zaGlybkB3ZGMuY29tPg0K

