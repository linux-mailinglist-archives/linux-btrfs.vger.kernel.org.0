Return-Path: <linux-btrfs+bounces-16568-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8FBB3F1F2
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 03:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A0A3B2221
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 01:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CD22DFA2E;
	Tue,  2 Sep 2025 01:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dNOg6o8d";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="e13gvAp0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D552DF71D
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756777219; cv=fail; b=IHao7ZW98hFOGi2aF7oeJxAxxFGMcIANewOfhYST0g8VQmGu4427xrEMzIG64+LEmSKwOnGgXyYjZZPL36EMIDWcvdHD7fKLDcTSx4T0fsVrPyCzCWlE7vs/61FWNyZMU+3BVJHJ6wmoi6MhPyqpLwctGjF9ZaaQyxMB+x8U0h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756777219; c=relaxed/simple;
	bh=XxQoVFEK4dJX3vOSKrojicf9aaRaz6lzHfiPSCtEgKY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ArNa80Q8txCnjTdxSvaBwCBlrujQx05We36LSWjZW0SJV4eAT8nyuPe89uLPE0NRHG0/t5zotsHt+L6gxib7hIaZ3BxfhZV0NQXFtIR+l0B/M8f1CkUeGleWT1ZBKnGWdmO8eEmzXVOQc+dNpUsPRQciuK9DUuyn44aPzyz8gls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dNOg6o8d; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=e13gvAp0; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756777217; x=1788313217;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XxQoVFEK4dJX3vOSKrojicf9aaRaz6lzHfiPSCtEgKY=;
  b=dNOg6o8dTda5THG33YvJXhuWYdFab7tcWb6W4E2YNTx9oK2KQCmsVkiZ
   DMcTZeCLUgeAjHp2XGMI1ZBAuKHrtGLhhwEVB/otE5pDGhcVodn2lJJ5L
   KZqmlCLPgMg9kS00fHX/brC4SWSv5UKVNNCtifuTo2s6yje+NXmqPgmnR
   x2k2IcYDoIE7BMHSX1C0V9/A41VFnk01dtYxQBxZ1wca/UvZr9QAPvsjL
   pGEa8YdOxYrXiuiZ8SF8t4cB0rM1HZbh+iNpDjEUhn6czx6PfbTGoQTqG
   uiGA2mti7wypad2/WR/KzicJ9JhwV1yvlWFq7OsmEFnI0dRmcCfwa6OEa
   w==;
X-CSE-ConnectionGUID: QBofl5DBRRaGd365QtzBjA==
X-CSE-MsgGUID: H8F7PnJTRUipzSAbkt14IQ==
X-IronPort-AV: E=Sophos;i="6.18,230,1751212800"; 
   d="scan'208";a="106417345"
Received: from mail-dm3nam02on2061.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([40.107.95.61])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2025 09:40:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qft8pKVTemp92PStiNxzakpUJzV8WAwntHRdtwmcb/w3gMB3iuDYBekcokrxcY1PNFJQfalG1bIACfFt4zhGelcdsaKqQT0iM66v6bLjQ2JmBp5MTxVd9RXMDoJ4cGoPkZAU/fxX1D4Ei5ghFKGhbvaNWc2EQPBK63H2iLGz3Fe5NI+CGHwshVOqRTQk4LgKWw9KWm+rgr6tBvBqFP2Kq0lWeNN2Ms8lNVfgYFQQVlrkTj8tB/jFiYELPAF9kARuiemNiudFkgpopf/7I/kXEXJQsYz7dYithl3TCcdQcGuoOLI5uTL8qYzW1+mSCiks3wNlM7UVUBk2yd1opJ6G+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxQoVFEK4dJX3vOSKrojicf9aaRaz6lzHfiPSCtEgKY=;
 b=oUTKNoReBVuzbkZFfU1OWaMoxqmcx9g2zCzPu/piUqNQ3kiVqhxYbRvbEXA6L3nCP/740rRiJhayfK9uQKJZCvOiVMMe3gFk8ow5igZfmU9PrYf2tYI8blgfHPfwXfa5j78K+hh2RWCRSbWENzWgntLrvyqDarOKRBQxCu/7WENdb6+/JYcxfoYy5y0Noik7EqD8HTbT9Z9+vetc8flr61BUfcRRolWcpYFF0yofnqQjDZMna0s7632nEmaC3fD4NtiS2xy9LZ/BTHLJgyvHkC1IJ2oz31luUklt6kikemMP2Y1k3sgitRM1olY3dwo66ILI8UlPfRDJVJPjWrcgfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxQoVFEK4dJX3vOSKrojicf9aaRaz6lzHfiPSCtEgKY=;
 b=e13gvAp0uJ2wGTcBTGT6bjwVa2S1E0/4oII0Sgnunl4f8tvoqN0yNdFV0ugep0413iyu5ADX7kEyRzZYmHCADp8RT/MlKJJAd8gT+CJPDjGMdgnGsQ8Ylyj3mDdI2OFlyryf1gI7FOrB/cOjR3ltZ4zJ++oxnwYIuaFLaDxKi/I=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by PH0PR04MB8226.namprd04.prod.outlook.com (2603:10b6:510:103::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 01:40:07 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%4]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 01:40:06 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: WenRuo Qu <wqu@suse.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs-progs: mkfs: recow strip tree as well
Thread-Topic: [PATCH] btrfs-progs: mkfs: recow strip tree as well
Thread-Index: AQHcGxN5EIvHQTlGNEuX1nhkQRflCLR9/rqAgAEgIoA=
Date: Tue, 2 Sep 2025 01:40:06 +0000
Message-ID: <DCHXJMTID1CX.3LMR9FL5EOP8S@wdc.com>
References: <20250901073826.2776351-1-naohiro.aota@wdc.com>
 <7e86289e-aeef-4ecc-999d-ac79778863b4@suse.com>
In-Reply-To: <7e86289e-aeef-4ecc-999d-ac79778863b4@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|PH0PR04MB8226:EE_
x-ms-office365-filtering-correlation-id: 75e7fdee-20c5-4dde-7716-08dde9c1a562
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0RlTTN4bmpuSkpjaW94UXlpaFc0eXBldVRrZkFyY2J2cFBuUFpOekxVSGdZ?=
 =?utf-8?B?QWYwNnp0aTdWejRtZEdTVUp2ZG9Qbjc1M3JETytmcUFwTjdUQmxEeGZIckxV?=
 =?utf-8?B?dzQ2YUhTN3kvYmR2TmdkTTAyNlFtVVFSTWdWTitSRFJTTUdWSW5kTjZsTENT?=
 =?utf-8?B?OGc3ZXJuRVkxdGpPTmZROFkrMEJpZDNzakt5N2FJY0xPKzg2S0JMSnZTc2FI?=
 =?utf-8?B?dk02ODM5OWt6T2h2amsxamY2bE1VMnIxbzgwcEtac1VhWmFZaFNFemUwR1VF?=
 =?utf-8?B?OXorWkxJM1BVMzM2UUtiS1Iyc3dMMHJ3T3gyaExHUFlzakdwVy9mWnVoc2NP?=
 =?utf-8?B?NEp3VlM5NUNiUDhOZWlidmF6c0JPdElJQzNmbHBjQ0w0aDhWbmJTNFJzam5l?=
 =?utf-8?B?NEt1T3l6Y010cGMxWGdlV3p3Z09xRkllQURWOUlNOGFjamNzaFlBQ29VdWQr?=
 =?utf-8?B?N2N4Qnk4Wmd5WFAzOHgzcHZzdjljb3ByQUgyYzQyWnJSdy9nWUZGai91aThO?=
 =?utf-8?B?Z1BEcG9FMjFPRVo2ekpnMWVGTERVbExDckdSSzBDT2FpbkRPYm90QkV2RExW?=
 =?utf-8?B?amsrTUFnR0Q0ZmRmcU44NDBOdFM0K1BJSlErMjZadlljM2llZzVrakFFQnFS?=
 =?utf-8?B?bGFyYXFpbTJjL2k0cDIzMHFIR0dIVHlxLytSSVpyYWxQYXl1aEpHYmJ5NWxq?=
 =?utf-8?B?Z2R5eEYyR0J6VUYzQWNncTRWRE9tbWYvSWoyeXBxNmp2Y3BKYXdueXdzM1U1?=
 =?utf-8?B?cmY1aUc3QkJSa1JzVTM3RmJLYU5WeVlTR1oydkdqRlBZSjVMa0NtSnBrRnZZ?=
 =?utf-8?B?dU9vT0FDazdyZS83d3dlSXVPRExJMEhTQU0yYXViaHI3UXY2WU1JL1BaODNM?=
 =?utf-8?B?WTRtQ0tXVXhnNGc3NnpMNVdFZmxZZ21Nb0M3MnRsNnpwTUxDYUZQY2svb1FV?=
 =?utf-8?B?L0J5QThpRUg5L0tOd2gwOUY3L2F0YXpjSG9nclVwZWlDQVBWUjV1aDdGT0xU?=
 =?utf-8?B?N3VBakZheTFzU3ZvbmVuaW1pSjl3UlI1SXBidGVjZTl4VTNYdjByR1lHZ25M?=
 =?utf-8?B?U2QzOXdzUDl0TDJEOEdWS0ZhMnVTRFRFbi9ydzlLRldsdGwrczRjdkxJZnZ3?=
 =?utf-8?B?U1IwQmdMQVQvQ01vZVdVN0p2b3B4blpSb1FsQlk5ZlhRMmVSMEh3ZVowUGVu?=
 =?utf-8?B?ZWRIdHgzWlF2ajQzVUNpdkh6UG1oWkRDYStwSEduMVQvRVdWUXFaSElqZTVl?=
 =?utf-8?B?YkhkWmJEU3QxeEtGb2E0aldGcUFsdmk0cFU1c09Sclc3dTJlS2VXWkxFUnFF?=
 =?utf-8?B?Wlpra3BVS0N2SnNnRnhQRmwxVGNNVjR5cUZmRWhqdDlVNFVGMzVmWjFKaEVw?=
 =?utf-8?B?UHMyRkYwMy94dTZhQUw4bTEyNllsNUI3M0Z0OWZLV2JJcE13VjhYZkFMTnFX?=
 =?utf-8?B?ajQvaUsvL2t4RHprZGl3SjNzek5nNE5QSFZlbWVDOWo0aEgvZHgvRGxxNGNk?=
 =?utf-8?B?d1h5MEwzRWovRzNLNS9FVjAvdzlycDRxamRzMk1VUjhJM0Zmbm52OG9MbjU0?=
 =?utf-8?B?dkVVZkcvckRuUENqVnk2YW9nb2txUFBubnJqSzFVQTFpdThYK01wNklSVEg0?=
 =?utf-8?B?WklDTk9tT3ljUG1XSjFRSXhRall5QjlycTFVbXZWMnlueTlLdThrbkkyWCtO?=
 =?utf-8?B?aDR6VEZYMy9Obit1VjhMYXJkbkFTZllTa1JzVGszMnJuczE3YXpNVUh3cVNE?=
 =?utf-8?B?TGhad0piM3hzaUV6cy9IeTY0TmdHd2JodFExcWpWM3pOeVB6Vm0zOEowWGNZ?=
 =?utf-8?B?RjcrRFFSUVVRUFJxTWVFVGxSb2xHTmduY1hVUk11MjMvRzBaaE55U1hZdjFv?=
 =?utf-8?B?MjkwTU1JZXMwZEZ1WWlQZnZ2dnRvdHUwMzgyZk9aMThoMDREMFZRY20weGtY?=
 =?utf-8?B?WWgyUjRiM3lUTUE1Q0NsbjZMMy9QNjJzZlloQjF3QzJiNkkycGdCMHYyc3hB?=
 =?utf-8?Q?90k9UkCaXdiq66NItPleg31fkKY21g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?clZRNlRjRjhpcVRJUGUvQU5HdXJXaEFRVjZMSklhOUkwOHJpUkw4YXVBTVBj?=
 =?utf-8?B?S0svV2tBR0prV3BxWno5RUc2c1ZucldRZTJObHBqd0pacG4rZVY2cUd5ZXp6?=
 =?utf-8?B?RElzOEZIcytqRTZETU9PWGNrbVhhZUppVHlkUCs5L1Z1ZWo2U2dsMGlucS9p?=
 =?utf-8?B?QUZQVHpLN1A2MVNBb2xhd0hjRUo4aUw2TUIyQXpiR1ZjSXZ0eWVESGJ0aitO?=
 =?utf-8?B?ZFVnblVFdzJablJUaHlkZUNWa2JZeXFqWkFwajZVdHA3UEJhTnRrdHRjMDc1?=
 =?utf-8?B?K0gxSDZZYWVWK2VYVGVMMXlVaEpZQ05Eem0vMExmWUZVbXRrcEt5Ly9ZQmV0?=
 =?utf-8?B?dit0TlNWbEFCWUZId1RmL0dSTnZrRmd0bGx4Wm9EVk45VG9PVkltS01qcGZB?=
 =?utf-8?B?aUxxMVN2VHJ0VmlmTTk2eWs0dVAvaERjSVBaRlBzZWI5YmFQZ1JqV3g1VXV4?=
 =?utf-8?B?N3NEL1FQTGtJK3g5NUNndjRPdiswdnVkS0o1M2ZYREFiLytYTVJtclNEdFdX?=
 =?utf-8?B?dVpsWkgwNjJOR2k4akxOdUxTVW15N2lWZ2pueXNqaEVrUDIyTkdnb0VWc3pP?=
 =?utf-8?B?S2xtRnVOUXlmR2FhVDQwTWU0WE5leXMzT0xSZEkzNVp0aDFOWkM0dmhZdElw?=
 =?utf-8?B?QXcrSFZ1S21FV2ZNUzUvdkJzekJ1TTlVVllUWXlJdlZPZVdpWjEzeXNJWjRo?=
 =?utf-8?B?bXNkZ3E2WXlsL0ZDd3ZNZWJ0MC9TdmloeTBVQ1IxTFRiVHFWZllTdkdLOW9J?=
 =?utf-8?B?U25rWTVSMGF1aGJ5QldsVXNIZGtaWU9oc2tlaG93VlZnMFJpVmVJWTNIdCtN?=
 =?utf-8?B?RzF6Z2dGZWpqY1Rlam1URWVKcGU0U0FJMGluYjFFa2VqemJkUUF2bXlnQ2N5?=
 =?utf-8?B?QUwxOW5lclJnaXF2Q0w1MEZaSXVmTjhJOTMzcVJ6eS9EZUpQVGNNa3FUNnlq?=
 =?utf-8?B?bFd0MkRqM0NIU1VYUmNCamJGaEE0ODNmMkRHOW5wcHJqRzRhNmVFanZqM1ZE?=
 =?utf-8?B?cUpCWDdUWHUwOWhIWWZ0WWVhZVdKUXdBMEYxZkdUL3NGNU4xZUJsWHhJOENh?=
 =?utf-8?B?eHVNV0s1VDdjcC9scnNGTzJ5ZzhvM3dnRXE3dTNRWnVmVHVxU2VlS2g0OEY5?=
 =?utf-8?B?eXBLWnBYQU1DdGRaRUk4OFNycm5NVGNHZEpFdTRka1U2akU0bEdxKzZDMjV1?=
 =?utf-8?B?SUlhazNLclF4UVUvcmVES0gzR000WUlaNTRUOVpnajFVbEczRFJvbUt5bnM2?=
 =?utf-8?B?QksyNWZSL29ITXc3VmZyYlF6V005TTJob2owVG01ajBISWtvaW95R3ZzbUJy?=
 =?utf-8?B?cmtZMDJPWXA0b0oxVXhjWVkybmRlcG9ya3NOQ0tObXYvVnhJbjN4cGVST09E?=
 =?utf-8?B?a0czdzhkKzRLU3k4dWlBOXFzU0hia0pNNmJnc3hua0VPM29lT2lLOFZRWnVQ?=
 =?utf-8?B?SStCQm8weG9jSG12Yy9oWS9PcVU5T3k2ZjA3TEFka1VmSnZhbHpRTWl3bjF2?=
 =?utf-8?B?U1hhbFlPNTZSQXBRV3lSWklSZ2UzV0Z1Z1lGWCtzcWRmRUt0Y2JZUzdIc0ND?=
 =?utf-8?B?Y3lGZG4vM2F0OUllRDhzLzF5N3NZZTI3dFdHcjdmR0NxM0oyaGszL3E5dkx4?=
 =?utf-8?B?MEpzZ2J2M1NpakxHK2QxWGNnSkpYZXdMV0pmcnNHblQzczNiT1RGZDNOWFUx?=
 =?utf-8?B?cGIrZHRySVEwZFRYS0tPblBNODJEc24zQnRNRjliaGRBTE5DL21BRVZRcE5q?=
 =?utf-8?B?SjdTamlNanZibUFiYzRWTnEvb0VyVnZXKzl4UVRFL1FIeUJSejhYZHRVdkFC?=
 =?utf-8?B?eXF5aitZajhCenBBUG1kSW4yY0pleVZrOCsrVUo5a0Nkd0UvcUxwTE5RRXlP?=
 =?utf-8?B?M2VFR2dzUklJVVVLeUNyM1ZpYWczUU1JNVBlSmZyUjZyTGN1dlNWSEhkZ3hC?=
 =?utf-8?B?VXJyc3dxMXVPM01PaWNWUHFpUjhpWWx1WkFENFJta1lHaGFKRkhpWkZrSVRE?=
 =?utf-8?B?UzdjMmFWUVpDa3BPdXAwMFBVUXhjTVpGN1YvTXM4N3VxM1ovYjYxcnlnNzVZ?=
 =?utf-8?B?OGttcDVVTzh4MGFlT1RXMFprNjIxcnJBa2xHVERFTzZ3VGVHeTdiRUZNc1Nu?=
 =?utf-8?B?dkJVU1FjdE5mKyswZVRhNGRXMUM1MklPL3dLNFI0QWJYalNCRThibUxhL0J6?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C46EDF72C02C694C96A53B1B155FC035@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BL59vEA3qpbV9MmMIKH/moDcEDQijVF1n4yKKaF0iKZOKvrqboEZTBWkHSNql4pnlqxY+SwxzKPKlN9mLNCppc8D36d6ndvXTSIICRwt/gsQi5VL2CkQUiv0DebXFEzmvUVmyx0ppusmfk6d7DlpiD4Ufx4DcQNYVZyW7YTtRD2mFlurmU4WLu37PqfsodtyxKIR5kbgc3vRYi0lqITguST14hd8ZfdXsSGwF82URmilsl0P2+2/2pLsaDroVulLtAQDPPF3Iss8IeG8+/WHTL1jkoN8g/lGEIM1dYdoYVpG80zjw3qwTYVVT40WelAp0zSmY7Z7p+UmIRRd7rbRfsvjQnMA3qeyWHgeUNuos8Pp/Tb6gYlSOqpFT0tK4vf8SHHkHxVLsmNMiyuu2VTi6bNncxojOzfr8BqBahCKoULBnQkkBvyi1m6KIysVLekP6ukBV74DF/Enp9VCqIv5OW1VoiPxdXZElvE+DufyQtET5n3HbW0s04B0O7fpUgafi6+C98Ma266sjb03LJiFhTRfGUn/dQdKL7Izqz6F7Zf8BAhrVI18DYF5IDiKZMlt0EhCTsoxX98eZMQVH/Il6Tnpsl3Lj/4wF0zMJLCM0BR4btK9ZvwIHQKq/v3Cu/K5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e7fdee-20c5-4dde-7716-08dde9c1a562
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 01:40:06.8709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CLLiPH7YrStjX81pDYdJbDNk1qukj3K6MsZ1N5hlzv94Ti2kIS0+aeRlE+jZ16blhzIFwvkM/V3pHBUPcksCsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8226

T24gTW9uIFNlcCAxLCAyMDI1IGF0IDU6MjggUE0gSlNULCBRdSBXZW5ydW8gd3JvdGU6DQo+DQo+
DQo+IOWcqCAyMDI1LzkvMSAxNzowOCwgTmFvaGlybyBBb3RhIOWGmemBkzoNCj4+IFdlIG5lZWQg
dG8gcmVjb3cgdGhlIHN0cmlwZSB0cmVlIGFzIHdlbGwuIElmIG5vdCwgd2UgbGVhdmUgdGhlIHRy
ZWUgbm9kZSBpbg0KPj4gdGhlIHRlbXBvcmFsbHkgU0lOR0xFIHByb2ZpbGUgYmxvY2sgZ3JvdXAs
IGFuZCB3ZSBjYW5ub3QgcmVtb3ZlIHRoYXQgU0lOR0xFDQo+PiBtZXRhZGF0YSBibG9jayBncm91
cC4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogTmFvaGlybyBBb3RhIDxuYW9oaXJvLmFvdGFAd2Rj
LmNvbT4NCj4NCj4gUmV2aWV3ZWQtYnk6IFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPg0KPg0KPiBD
YW4gd2UgYWRkIGEgdGVzdCBjYXNlIGluc2lkZSBidHJmcy1wcm9ncz8gSUlSQyByZWd1bGFyIG1r
ZnMgd2l0aCBEVVAgDQo+IG1ldGFkYXRhIGFuZCByc3Qgc2hvdWxkIGJlIGVub3VnaCB0byB0cmln
Z2VyIGl0Lg0KDQpZZXMuIEluZGVlZCwgSSBmb3VuZCB0aGlzIGJ1ZyB3aGlsZSBJIHdhcyBhZGRp
bmcgYSBuZXcgdGVzdC4gSSdsbCBwb3N0DQp0aGUgdGVzdCBwYXRjaGVzIHNvb24uDQoNCj4NCj4g
VGhhbmtzLA0KPiBRdQ0KPg0KPj4gLS0tDQo+PiAgIG1rZnMvbWFpbi5jIHwgNSArKysrKw0KPj4g
ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+PiANCj4+IGRpZmYgLS1naXQgYS9t
a2ZzL21haW4uYyBiL21rZnMvbWFpbi5jDQo+PiBpbmRleCBmMGQyZTQyNDIxZTYuLjM0YTRlZTRm
ZDZkYiAxMDA2NDQNCj4+IC0tLSBhL21rZnMvbWFpbi5jDQo+PiArKysgYi9ta2ZzL21haW4uYw0K
Pj4gQEAgLTMzNyw2ICszMzcsMTEgQEAgc3RhdGljIGludCByZWNvd19yb290cyhzdHJ1Y3QgYnRy
ZnNfdHJhbnNfaGFuZGxlICp0cmFucywNCj4+ICAgCQlpZiAocmV0KQ0KPj4gICAJCQlyZXR1cm4g
cmV0Ow0KPj4gICAgICAgICAgIH0NCj4+ICsJaWYgKGJ0cmZzX2ZzX2luY29tcGF0KGluZm8sIFJB
SURfU1RSSVBFX1RSRUUpKSB7DQo+PiArCQlyZXQgPSBfX3JlY293X3Jvb3QodHJhbnMsIGluZm8t
PnN0cmlwZV9yb290KTsNCj4+ICsJCWlmIChyZXQpDQo+PiArCQkJcmV0dXJuIHJldDsNCj4+ICsJ
fQ0KPj4gICAJcmV0ID0gcmVjb3dfZ2xvYmFsX3Jvb3RzKHRyYW5zKTsNCj4+ICAgCWlmIChyZXQp
DQo+PiAgIAkJcmV0dXJuIHJldDsNCg==

