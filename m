Return-Path: <linux-btrfs+bounces-17964-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12754BE8E11
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 15:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010C26E459D
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 13:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC6D3570AA;
	Fri, 17 Oct 2025 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EVOGHMxE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jELTlwZu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAF0332EC2
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707995; cv=fail; b=PimdFjetThwktwlX/fuh5KVPSjVG9VTJbUmgjaTkEV4eqaUR4Bq7ORpAkWPMR+z2jeyQ8ZoyDqfO7K/JGy8QgOrcdutXxI44QTb9ND8Fn58wBy0nrmk1fjlLwz1j2eZS96lD95GbfF7xDHgMJk3SpHdWqwRTaKz1X4hwOgK4WDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707995; c=relaxed/simple;
	bh=uEkbUL0hAf0JEDiodvd8wl8IHCD3zp7aDDo8D+z4FO4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yd5WbJWziL21ioROpcTLxrLkaK1BVnToNgLJkAVM/vNV+pQbtqSz7YdnBHTRISZKPFElgbvwq482f9c8+Nw9wcPa22+3urR36mUqpwuugMJl4C/MFoc1uXweHvurcuPaCwWXTgTd/6nxA/SHajp2zNomkLLBeeea4lfh57iVEBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EVOGHMxE; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=jELTlwZu; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760707993; x=1792243993;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uEkbUL0hAf0JEDiodvd8wl8IHCD3zp7aDDo8D+z4FO4=;
  b=EVOGHMxE85dYc9rN3/XUXVfyhcFPcVWTrxgyYOWFen6hGSXvjcDGTnFr
   Q0QlrCLHAaeTnx72KJ5hzoluAaAWBjLVzkXk/rHu+j8AE4C5FfJl+AF4O
   ILdKzXBybdmcTAIM5cW8dmpALHplvPgWKNptmf6xA8b4WJ52BnvP1PJDH
   k88YyNVHNQbtH7aSnXsSEegxweQ3i045Av6X6tUREccQF53OrWQuWWD8N
   XexEw4TbwLE9c3s4Q60C42HUlQgyZ8xqUhsurISwM/js8PHE3Vsk0pVKm
   luX3ciZArs8F8l1tL3ySSLHxHWC5ezcUh0Otl8OgskE6ClxUng/3/67uO
   g==;
X-CSE-ConnectionGUID: 9jYrytvMRwWTVedFx0P3oA==
X-CSE-MsgGUID: gUXOyBDNTd2ruLCBhAAhNA==
X-IronPort-AV: E=Sophos;i="6.19,236,1754928000"; 
   d="scan'208";a="133426042"
Received: from mail-westusazon11012029.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.29])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2025 21:33:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrV+KV5PlRFAIUrf45n2XaOSCZbh27kzYpQH/2e+ZU2UQGsZbWQYxEK83uJBDSIsq18aBYfMgR0lIi9jE0onsDlFMBwuoD2jXSg9UIWMIGGHRLOmL2Puv1Xm5S0zdnfG0x5q6mNm9sr+beQiyTBy341XIMgC5mi9gNrXBEGuSR4XRagRUPYH0DlSs63gLX7HPiHTuF/sjzqEi8AfbB/GXxqnz7RVMog+FdtIu5OzuRNPYVO1/c/mUNL3YQ3OgLevYzYcq5Y5WddNZah7vNpgvJ9YSBnkOvqQS8LlBRXrf1gHYcLXI6lCoCXGY9bAea8hP7TlhUjPPQqm46N/IXucVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEkbUL0hAf0JEDiodvd8wl8IHCD3zp7aDDo8D+z4FO4=;
 b=dCGM3AWO48V8vdqKut6Jt7TGb2xRXCNVhrcvvSmYKJ4FWzZOtEJQdHvBvPj7xBreCkezMj09LJFHCE8I+PnBtEsOerWpQBGSNstGTqOxZOvT53/0Yw4sqOBhaKhLLQeRr9VHiPmKsFjF8tB/DvmER/xpL14KXqyymuBM98HZxBh69gbnZxsx4KcMEfItIJlAOMuEo/j7ljc6BiaDLlI8ypMqXzn7tg2VIk7hR2vwA0EJ+DTq3R4dYUNn+Pb0OZ5MAS2WywnEjjF3gzBh0ziY96GENU261RbFuGGDsR+TBrG7fB/pVlzktDKqyYxVvwto95N4evJH9AHje0I1H28syw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEkbUL0hAf0JEDiodvd8wl8IHCD3zp7aDDo8D+z4FO4=;
 b=jELTlwZuaZ6Ug2kX5/yyqpxybwGfoSs56Pl8kB0+WzGaY6caCDTGX23pfD+ckmV0ibDoTyd7vlbR2dLFjdVwn46n88Gw+1HXkggy8GLN6ikJUZoo5ua8npdIqZveaKGU8KvXyWaVLHAaUK68sJEiKK31XaxaYl0JbCHuxnFjG+M=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS0PR04MB9509.namprd04.prod.outlook.com (2603:10b6:8:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 13:33:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 13:33:08 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: zbd/009 (btrfs on zone gaps) fail on current Linus tree
Thread-Topic: zbd/009 (btrfs on zone gaps) fail on current Linus tree
Thread-Index:
 AQHcN1KuGCX0HNOhIkayN1jmYD5sCrS2iOkAgAE6w4CAAAEogIAAhrYAgAwao4CAAgBTAA==
Date: Fri, 17 Oct 2025 13:33:08 +0000
Message-ID: <f141df1c-1d91-40f8-853a-f423ea4a452f@wdc.com>
References: <aOSxbkdrEFMSMn5O@infradead.org>
 <e0640c83-e600-410e-bbcc-4885852389c2@wdc.com>
 <aOX-g97die1kbVY7@infradead.org>
 <c5b15471-5a8a-4e0b-a7d5-ad682785b581@wdc.com>
 <a2c698cf-5735-4ef4-859b-057fece29c9d@wdc.com>
 <aPCXz7ktsyE8BLeG@infradead.org>
In-Reply-To: <aPCXz7ktsyE8BLeG@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS0PR04MB9509:EE_
x-ms-office365-filtering-correlation-id: 89db2975-a92e-477c-c6a7-08de0d81b5e7
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|19092799006|376014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?Tms0SlZXTzFTUVdSZEllYlFiTXR4SlV4Y21tckwxUllzU3VqOXdGTG5QUFZn?=
 =?utf-8?B?Qnhnd3JhUno0bmRPdEtoeXZiZ0Q3aWl3ZDVvQ3lJWVdBU3BJcmxPWnlxa2E5?=
 =?utf-8?B?MHdXemhEOTZuenV4aU5JRWxBU3VucytMa0VabmhaZ3pwYjAydlJzN1h0RDI2?=
 =?utf-8?B?cTA3VGJFRDk3Q05icGE2WUhDR1V2ZXZBZzNBdUlKeEZ6dDgzUDlDNlpEaFV5?=
 =?utf-8?B?cEMyM1ZjTU9lMEE4eHFNdlRiOVBnRnhsNUtPRWJKSTdjeGZ5Wlora1JhTU1N?=
 =?utf-8?B?TXJ1YzVWdWhSc2s1MXh4WENjakNiR1NuMHFYcVJuc0w5Mk9teG9JTGdNOVFP?=
 =?utf-8?B?YTJEdHFJRXR2RkExN1lsZDlMQVlpTU9HUWw5dHVTU0tJQTM2T3hSRlViTDFw?=
 =?utf-8?B?MW5sS3MxMjdmTzhJVjlRVjQ1M0pYT2dKV2FabE4rcmx0ZU4wSTdTNHVaV0lD?=
 =?utf-8?B?bzJpKzNjMUlwcVp3eCtMZWlZald3cWlyb08wbXROaTM3Rk16WWU5MVpNNEpk?=
 =?utf-8?B?SkpNb3gwMC9wVVNoL1ZJM3RDeCtCVkFkZE1BU29nMU1mNGZobVZzaW9DOEdB?=
 =?utf-8?B?dmxiam9vVnNVWk5qU01nL0l5N1l4YjhETnZxd20wYnFxNDMyUnhRU1ltdXhx?=
 =?utf-8?B?cHJCdTJMZ1Q4bHJtL245SDFsa1E1OXFtVHVVcnVWU0NsMDJuOEdJSW5UMmFR?=
 =?utf-8?B?Z0VvNDdhOGZKRzBUSENNa3lodmlTSUN5VGNScUNjaTRQRVNXbFZuTjYwWFRh?=
 =?utf-8?B?UW9nam9uVGRJdFBHM2tLajV4d2RMdXdudWdCc3AzWlJwbDdPRGVUdm82WXFR?=
 =?utf-8?B?eUZOY3NCTGE0NnZUeTY5bzREQlAwMzJadFpnbTVHQUlLVjNKam5VaGdYdjFX?=
 =?utf-8?B?eUNBWHBaVGFTZWRhV1VzaU9RM1dicFhJaVl5MmZmT3IzZ2xKU2M3c1h3ZjVS?=
 =?utf-8?B?UlV3Wkdic2JXL0xBSHBQb0ZVTDZHSU9YRHhKNFdieWRSRTA2UTRHN1VkUXd3?=
 =?utf-8?B?bEpraysveThXTWpBZ09YYlVkM3F0YzNWS3RMZ3lFTUg4bTZlTE1oY1JUMUR5?=
 =?utf-8?B?b3Y3WWtLdXMrVk93UytuVE5JNkpyRkZYL0RkbEhTQ3gySytFTHU1ME9pMlJa?=
 =?utf-8?B?WkF2M3NJbEdTT0VIWXJSU3FFU2JTb2pSVzJiNFRWTE9QZWdhUUR3b2xIY0tv?=
 =?utf-8?B?RFFnSVNDM3VQOFFsYkNiU0JtWCtlRmJUbzg4bjRLQ01mMHNhR1U2STdZV2pH?=
 =?utf-8?B?NHJuZ3R4V1g2RlN5V2c1dVhnemlTSHFIRStha1BoeEE0VVZaZVM2VHFDNllB?=
 =?utf-8?B?SEF4dWpmS1JybGZvODZnZE5pWm01RDIrcjUyVnRicWdEZHFqZFNsMkdISjZm?=
 =?utf-8?B?TDRndXd2QXJJRTdQR09aTXJEc2ZOUjAxZzRtNm9LM3AxUjRHdHR1MCs1MEtS?=
 =?utf-8?B?ZHRacng4dFlHdG0rZXV6aEZzV1RMckp6cmp0Y1VrRXJZSmVMRC9QMkF0RU1p?=
 =?utf-8?B?WHUwTURRcElzRlVsOWcvcW9NelUwQUFGZ3BwNHRCbmovMWMzQVl1eGxpaW1Z?=
 =?utf-8?B?YkNCU3BYRmJ6eWNkQzNFRk9LSEtTcmF5L3hnQTIycFVLWXF4Y0NLUjBCTWdj?=
 =?utf-8?B?KzZaM092MHFDVFdIdDdSQUJHUmUrQjFweWlNRzA2Q2NySjlLVVVjUndFUWYy?=
 =?utf-8?B?MkVwVjBsTm9LdEdCTXYzNlVwTVRiTXk0aWRDVlNsWDRma2VoL1RZcFBiYXFl?=
 =?utf-8?B?d3NibjZ2cFVGME42Z2VKWGVXMThXbEVPYjhtN2E4STRYVGgyVUthT1pVSVcy?=
 =?utf-8?B?ZWpJak1UZFI5NWMzRDlMVEZrTHpxdmVSck1ZL2NyVTIxcFBPZVMwWVJVVWZk?=
 =?utf-8?B?QnhkWkN3SHdrSWk0VU1QcmJVb1ptN1p1SXRLeFZMaTlZbWQ3N2dMWEc2aGdI?=
 =?utf-8?B?Q2kyYm95MFZkbW4rNFJ0d2VWbTZtMFRBb1QvK2dQdVIwdFZaTmZjTHJSNDlW?=
 =?utf-8?B?S0Ird1ZqWEtPdWljbWZDdkR2bXFMd1A5cU5qWU5RSTJzWnpOTVlaN2lQSGdy?=
 =?utf-8?Q?nmgF3e?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(376014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHMxVVRNZjBld3hpT1FlcG5MQXQySlJIbkRyL3UyUU5wMmtBQXU4Sk4ya3g1?=
 =?utf-8?B?STM5MFNrNHpTNEs1cGh4NzJiUU1HeHI3TUxyV0tnSDBxNU91RUZINC95WGJQ?=
 =?utf-8?B?WmpKSlFIei9VL2pwL3hHdnZZdXFnSCtLbjlQU2s4N2tmYy9zalU3WmNzL3Fa?=
 =?utf-8?B?QUo1c21kOURCQkQySU5yV3RpZDZPZjZMcDlla21Jd1ZXRStvU2h3SUQreFpN?=
 =?utf-8?B?VWg4WURnSWU4WUo2bmtXN1R6NXNVTUwrZUVaMGNJTUdDWURVWXVTV1FtTkpG?=
 =?utf-8?B?aDFpVkE5eWg3bG9xeGFKZCsycTZIUWpWUDF4cCtZaTlCeTM5SmVnMlJWUmhY?=
 =?utf-8?B?aXcwdGJMSVNBQXhwYVlzK3N6b2NqV1Y4UDRIVEI0Sk1FUkpXc3liQ3k4MGZv?=
 =?utf-8?B?eUc1bENYdkRJcTdBbDc1aWZpTGJNQ1NpbXZmY1ZWNm9IUXo1Zk9SanJxRnND?=
 =?utf-8?B?NUZLd3Q0MzBHbEtCT1RFTk1GWFVjdExaVXF6Mks4Zml1ejhOSm4wMGNOUURT?=
 =?utf-8?B?NllpRXJPbXA1MDRGQmxPNVVseDNieGF6YkVmNVc4STFtcGJtcGRwYlJUaldm?=
 =?utf-8?B?eUtmdGpuWGJzdmNBd2JWZWRNdnVWZzBvbUhXWDJFUk0rZlhab0RvTHFQNnpX?=
 =?utf-8?B?SzdSYW80OUdiRGhRU0I0cUdyeUNtVGx3MlFHMVpGZXN1TXBXQkZUclhoMlpH?=
 =?utf-8?B?OGdYazBSMGZPMDlQUFlaMSsxOTAxUi9LZWZScTVjalhzeWhobGNDamE0Ykwx?=
 =?utf-8?B?cWt4anBHcHAyaFNjVmJtZFR2SnNSVXdpOFUzejl2YVJDb2xxSGRPTzcxZkZD?=
 =?utf-8?B?eVlxMis1WlFKMHc2Zml5QW03NzZ3VFdublpsblVreWR5MjBXRkFENWtRQXp5?=
 =?utf-8?B?NEM4OXg4L1ZGQXdXR2RFamJiMDBhNFpqUk1wWmpsenEvUXdXMnZQRGJaRFFK?=
 =?utf-8?B?NC9mMGZxaVVCdGptNUpRTFYxL08veWlUMENTbmVpNkhTcUZ0U1FSMEpVbE5I?=
 =?utf-8?B?NzBHYWJsTHBETVJhRTRGSGZJT0s4V2x4VURLTUtJdnZGZi9qdk45Z1F0WUNk?=
 =?utf-8?B?dUhiaGRoS013eFZzVXYxdjdlNFdmNmgrZWM0SDQ0L0dTNUwyVVVwekkrSnpl?=
 =?utf-8?B?OWNURW1qMXZpOE5ucTBzek1GV0RGR2M3VUZrRVR5VFBYVGpmQlhSREU3OXYv?=
 =?utf-8?B?RTd1QkJjeTcyOHVXSGpjZWIweFVkSktycE0vbkZLK1Q4Um4vemtCSFh1dGhE?=
 =?utf-8?B?OW4rZlZCcWZDd05VODI0Q3MxYytCUmZJbXhDNUJqMmdnN005TUlwamUvM0Zx?=
 =?utf-8?B?bHpQL0o2YVdsUWQ1a1VNV1M4VUY0eHZDczVZdG5vaVdtQlc1UE5jMFBvb0xF?=
 =?utf-8?B?SU9RalVTTEVqcnN1aUxacDNVR1FhK1c3MWFrYlJzYU1IYldldGhlVUFDZndj?=
 =?utf-8?B?MkhkczY5OEZXdDAwaVhXc3l4ZFgrcm9FcDI0ZVFQOEptN252V3pydWZvTFNN?=
 =?utf-8?B?K2lzK2Q5UG9rRXdTSkRJaWlJclNab0RkNGdYOTR0cVZRRUFlOXNaMzZIZzk4?=
 =?utf-8?B?TVQ4VEcwdTRBZS9WeUFMUlhPM1pqcVBGQjBMTjgyaEl3WFR5dk45NmM2aVQy?=
 =?utf-8?B?amJpSDJTUk9iNGJtazMxV1RWYzk0akdVeDl6ZVFOc3VzSXFRWEo0MGtKWTY2?=
 =?utf-8?B?QWV0NU5QanJYSVJvYlVVTTJudkpzK000azU2ZUtyOHZCUStsVUhyY0U3ZTFD?=
 =?utf-8?B?WiswNWJFK2lMVU9laUhBNGFZUGJQY1RUSUcwMDhhUVY1eE1VUGs3dVc5aFQ3?=
 =?utf-8?B?QnNPMERwV3h5OGpKbUJnU3JSdjlsRll4aHdUa2lVWW54bkZTeHlocTZpeDJh?=
 =?utf-8?B?dlV4dDdwbDg0cDNnN3VwL0RQUHpUV1RBZEJEVm8ycVBCTlJGMnozbXkrSkpp?=
 =?utf-8?B?MERCZmNJSmVadlhNcWNhQlRMR0w3NlEwQStOZms0eWlXeXlpcTBWNkp2TFh1?=
 =?utf-8?B?QzhUWURrRzlSQkVtY1ZnUDlKYnNKV3F6VG1mK1crbnpjUTlMYVloQ2FRRnky?=
 =?utf-8?B?cXBwU1lzMStDa250OWNEMFVSOHBHQmhOLzV5US9uUklmZVJ5WTFadFVFcWts?=
 =?utf-8?B?RCtidHltNmNjakEzblJmZDRlRlF1ZnI4NmZGSWg1NXVmOGR3RVBwMG44Q1dO?=
 =?utf-8?B?QnhVOVlWYUU4M0taRDllZ1RGNDk3aDYvWG9GcW1ENldxdENXUnF1MWN1anBC?=
 =?utf-8?B?Z21IU20vZEF1Vk9nT3ZFeVpTYm13PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46400FA247C2A8469B8A63035D0AA03F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h8lVhsD9hZG1pE7kHI8gZrHu+k86CJk6tvfhvVzZQv/YgBhbzYfYWOz8WQTMOF9bTajw7ONcYC0tcUzNDWos1NsiHU0gOcKvAURnSMLY3GHwoP/Fsz7TeAffDJqFwRpg8oYEsg9Snp5EHsdl6mkW85Z7sMtlRNn40AnUafjYdkrKBYkBp3WP2OEVqgaQ0PGpyorXa1k4Xb7xPQdPwuElDHx6cidQcFdBrMHZB0vy68R/1bQvtMwifsyz2jwY1WagtRJvDcXAyvWgq/WZhbeKmE9tg/tVCdbYZuK7234V9TAJcJx4n64a9aJ6Ipppfn5UwqXhLp38Jy7QxeFLltey78PGXWzf3Xyt0cnFflsHnem+25SnQLg3eSYien3N8E0++pm4t23onIiZuGuGaUkLpRyiPMP18xdsWM8O5J2ZWDEnvd2G6acCGqv5ZFvFOyaa7ylmfiyaGEfM5CJmMprz7fPBBDpP+DyW8X9KoBTN3/AcYBNb6bU8xqgpcqWfMORy3rwsEawqfY0TpBe5DMArfDhVa26MVDO1JDK6j7Y+XaRIfRWg98cpktSjFW1Jo8lxXnPJZ11BJbrRyGbPda6MWZ1No6sRl+7smnXX2Lq/9TSpFkRi9GziTqMjfjGZWxAw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89db2975-a92e-477c-c6a7-08de0d81b5e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 13:33:08.6657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2lT6SJhDcbAgHTpg5vGlGk3IfjhsRfd5cAwZb9wV7Jmz4i3pu/aoTUcy1muXkcJDITqcQgwd/thnKebcYZFJepqNB/GnFiDbri3V8waHgp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9509

T24gMTAvMTYvMjUgODo1OSBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEkndmUgYmlz
ZWN0ZWQgdGhlIGhhbmcgdG86DQo+DQo+IGNvbW1pdCAwNDE0N2Q4Mzk0ZTgwYWNhYWViZjAzNjVm
MTEyMzM5ZThiNjA2YzA1IChIRUFEKQ0KPiBBdXRob3I6IE5hb2hpcm8gQW90YSA8bmFvaGlyby5h
b3RhQHdkYy5jb20+DQo+IERhdGU6ICAgV2VkIEp1bCAxNiAxNjo1OTo1NSAyMDI1ICswOTAwDQo+
DQo+ICAgICAgYnRyZnM6IHpvbmVkOiBsaW1pdCBhY3RpdmUgem9uZXMgdG8gbWF4X29wZW5fem9u
ZXMNCj4NCj4gd2l0aCB0aGF0IHBhdGNoIHpiZC8wMDkgaGFuZ3MgMTAwJSBmb3IgbXkgY29uZmln
LCBhbmQgd2l0aG91dCBpdCwNCj4gaXQgd29ya3MgZmluZSAxMDAlLg0KDQpJIHN0aWxsIGNhbid0
IHJlcHJvZHVjZSBpdC4gV2Ugc2VlbiBhIG1vdW50IGVycm9yIGFzIGZhbGxvdXQgb2YgaXQgDQp0
aG91Z2gsIGNhbiB5b3UgY2hlY2sgaWYgeW91IGhhdmUgNTNkZTdlZTRlMjhmICgiYnRyZnM6IHpv
bmVkOiBkb24ndCANCmZhaWwgbW91bnQgbmVlZGxlc3NseSBkdWUgdG8gdG9vIG1hbnkgYWN0aXZl
IHpvbmVzIik/DQoNCkBOYW9oaXJvIGNhbiB5b3UgaGF2ZSBhIGxvb2sgaWYgeW91IGNhbiByZXBy
b2R1Y2UgaXQ/DQoNCg0KVGhhbmtzLA0KDQogwqAgwqAgSm9oYW5uZXMNCg0KDQo+IE9uIFdlZCwg
T2N0IDA4LCAyMDI1IGF0IDAyOjA5OjAwUE0gKzAwMDAsIEpvaGFubmVzIFRodW1zaGlybiB3cm90
ZToNCj4+IE9uIDEwLzgvMjUgODowNyBBTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4+
IE9uIDEwLzgvMjUgODowMiBBTSwgaGNoQGluZnJhZGVhZC5vcmcgd3JvdGU6DQo+Pj4+IE9uIFR1
ZSwgT2N0IDA3LCAyMDI1IGF0IDExOjE2OjA4QU0gKzAwMDAsIEpvaGFubmVzIFRodW1zaGlybiB3
cm90ZToNCj4+Pj4+IGhtbSBob3cgcmVwcm9kdWNpYmxlIGlzIGl0IG9uIHlvdXIgc2lkZT8gSSBj
YW5ub3QgcmVwcm9kdWNlIGl0ICh5ZXQpDQo+Pj4+IDEwMCUgb3ZlciBhYm91dCBhIGRvemVuIHJ1
bnMsIGEgZmV3IG9mIHRob3NlIGluY2x1ZGluZyB1bnJlbGF0ZWQNCj4+Pj4gcGF0Y2hlcy4NCj4+
Pj4NCj4+Pj4gTXkga2VybmVsIC5jb25maWcgYW5kIHFlbXUgY29tbWFuZCBsaW5lIGFyZSBhdHRh
Y2hlZC4NCj4+Pj4NCj4+PiBPSyBJJ2xsIGdpdmUgaXQgYSBzaG90LiBGb3IgbXkgY29uZmlnICsg
cWVtdSBpdCBzdXJ2aXZlZCAyNTAgcnVucyBvZg0KPj4+IHpiZC8wMDkgeWVzdGVyZGF5IHdpdGhv
dXQgYSBoYW5nIDooDQo+Pj4NCj4+Pg0KPj4gTm9wZSwgZXZlbiB3aXRoIHlvdXIga2NvbmZpZyBu
byBzdWNjZXNzIG9uIHJlY3JlYXRpbmcgdGhlIGJ1Zy4NCj4+DQo+IC0tLWVuZCBxdW90ZWQgdGV4
dC0tLQ0KPg0KDQo=

