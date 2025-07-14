Return-Path: <linux-btrfs+bounces-15488-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1B5B033C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Jul 2025 02:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AACB616C611
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Jul 2025 00:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC31D17B505;
	Mon, 14 Jul 2025 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Cs71vCYw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hkspjzC8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3F41CD0C
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Jul 2025 00:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752454216; cv=fail; b=deYmxno1JrP5vfJ1HcXJSUq15P8Is+9z4cMbmLBP2bcM2aHHJ2EWOCEoHrL4YG7qbDLBfSgduqQYKwCfJTM6wlkqr6pPoxsOuzsZk7Z3uzWveFMLXqlPPh+nCTEKtPGiPYtvddmpLvusE9e6vm36SJI7bKgKu08SuTbpG4m746o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752454216; c=relaxed/simple;
	bh=KINVz4SWcfcKIMBpi2stdykTVgSWAGEEzlJhteQhQWk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cXidB2QLUAxcXm+GWGBWGqmMcUH1N9PagqQTdsbK2BSacsrYW1up/bDm0cJOTPP3Ya90wRIlKud51CE2HnKL3uiLaJlHiO17ErglqTI0FD4xb59DjeqXb2QbOp5sIQG9Pm1jawRaeuzoS8BPW7DnsI0/PfCtXOaI0Lyj9kxV3rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Cs71vCYw; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hkspjzC8; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752454213; x=1783990213;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=KINVz4SWcfcKIMBpi2stdykTVgSWAGEEzlJhteQhQWk=;
  b=Cs71vCYw8w1Ri9OQZ+g0Xsa1JYsRQFtGcn6W9iCfVGdBR+1FKDO5Wa6g
   xGGuU1EGrqcibah5UCte6L0161zt5D87LeE1cx/IqInvERbnf00YZzIJP
   dG85yG/0fzpOOrMBVh+GyVRM+eSkvFp3N0HTzfumLO8a46LoQtXKMYoB1
   DfzE4md1/wHhjTnIRXSodGzvtJMAU1LESySUIs92edyYvY65YcwoqEsf9
   r2cqOXuJ+64iJp3lY5lImVw8JhBoj+K8oS8rtqDKHFHbMmOwWc+XYeI2l
   rzgHS1EW9nPB2tauZpDAa8b4cEEHaxIt0fCrUVeCfFMXK9gzPXQ6WODi6
   A==;
X-CSE-ConnectionGUID: hpeElKxJT7GjqrndyqwpDA==
X-CSE-MsgGUID: Y+nX51b5TLe/LFBFPEeR0A==
X-IronPort-AV: E=Sophos;i="6.16,309,1744041600"; 
   d="scan'208";a="86973991"
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([40.107.237.67])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2025 08:50:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1YEiM/AMA97zGZvDuBgfEGQtB6tnTx9grjpFz5E2SnESHRSOqz8qTDdUMF+KS+dGpvG2XFz9fdvyvO6nSlnf0VKUqNAvOzxr2e4lftZXG+16l3zneMrsYsj5A9Tw6Ycgw9FawnTIpdT1ldGLMloGKmQAcpamWYk1uEZeUEMfY3YkERMchQ7BIqLWZ7rw9jC/VdktkhB5pnPR4+fO5ylspHo7StoKue7FwJfyQY39hOAVy7cFWnidNHXoMlDQZP/k6UPAFaW/izfFPL4NKVD1nOMzXcd7h5YleQjoorJJXSUZ4gb6Xl18qZPcJu0DNQf1l76i8YAE+kfBrXdmgcwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KINVz4SWcfcKIMBpi2stdykTVgSWAGEEzlJhteQhQWk=;
 b=fcWHiYGzPlA3LftSeT9EkoXQDfjuBgrXVHIOdybCDHZuyTv5S4qpDtDL08ULT7yiZhVaWC2BYVVnG8bZkwOaHsHkma2nyPxd1kUed+MtVZbl9w8sYueiA6p2CG/akiGTeYh22Idx8h9IE8GlzzMUaYzl7RsYz5FtGMMGeNx+HaUuIge68tgz4WDnH9OHTRHdAZDsDhXtMOh7q5RBSLQoEVmhh+m4v1la21nmvlGQThtdnPA2cxS3rU9s0ar+l4723fbl0Ql8fCY3BFhfaAyaVzSWc7gFrp0YOKnpLjh7J8hxdVNTFZAipRE6gymxKqzOrNaTBjN0dPFcRIHFYWgeyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KINVz4SWcfcKIMBpi2stdykTVgSWAGEEzlJhteQhQWk=;
 b=hkspjzC8wb8Jg3DzdmZ66ifyQjibKxALvaPtN6KWkBFBzx1T0u8Adhxk3u7VnvUaDlKBpWYHiU/j4VrA5kyRC94lfT/hoCvsBuemnnD5iMWzEZ/xXq49lzwq20Plk7wZouclnOMUkSGDVETqOUBlMkOJ/nRPD4s4yaWogwqa0xo=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ2PR04MB8849.namprd04.prod.outlook.com (2603:10b6:a03:53c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 14 Jul
 2025 00:50:03 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%4]) with mapi id 15.20.8901.028; Mon, 14 Jul 2025
 00:50:02 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] btrfs: zoned: fix write time activation failure
 for metadata block group
Thread-Topic: [PATCH v2 2/3] btrfs: zoned: fix write time activation failure
 for metadata block group
Thread-Index: AQHb8jTMP75p/6bTHk657fvo/6oAbbQsv4KAgAQOiYA=
Date: Mon, 14 Jul 2025 00:50:02 +0000
Message-ID: <DBBD621D5H7O.BYB40GHYOA4G@wdc.com>
References: <cover.1752218199.git.naohiro.aota@wdc.com>
 <aefabcddbc2038246813704a1c8bb29a60eb1e9c.1752218199.git.naohiro.aota@wdc.com>
 <6d2f4c04-c401-41ea-8acb-d633262428f3@wdc.com>
In-Reply-To: <6d2f4c04-c401-41ea-8acb-d633262428f3@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ2PR04MB8849:EE_
x-ms-office365-filtering-correlation-id: 0661fbb5-5d8a-4bf5-2758-08ddc2705e0b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MENac29IMnQyQ2d5RnVvNnRqZklCSnVXSGtRUDNhYllqMTU0MHpObFkxc01V?=
 =?utf-8?B?N3JzeWUxdVpYK1ZWNERid3JaUHdxcXZYR2V0QjIwQ2tGajcwZXNhUXM0Rk4w?=
 =?utf-8?B?amhjSlNiRExqSVFrZUZ6T000c3BUVWFZTmRjRkUrK254RnZ3TEN5ZWRrWVA2?=
 =?utf-8?B?bjdLWHJNWkdOWVdyZ1lmSTFWdjJCWWtxSEVzY0pMOHFvUkEzdlVwUEwwU2hX?=
 =?utf-8?B?S29JMDVGbW93UXBUY2lBeDNpYk55Sktpc2Vkc2ZsZjZjZzkzSzluTDdFT0ZY?=
 =?utf-8?B?Z0trek9hTmRIZlgwelFCVGNjTWJDTUErQlZzamZyUEFyZDlPZGxhNGhudUtU?=
 =?utf-8?B?MUplL0NEaHlwK29DdEpkS2lsM2Jtdmh2UTkyQS9EWE91YWtNYUtRZXh5SlY2?=
 =?utf-8?B?NXV1UTN4aEJPZGJieU9BWGp0d1F1UUE3TmQ5MWdQVG9MZks5cFZuNkZLakF6?=
 =?utf-8?B?WEZSZUM0REtzMVlzV3pGb2Vvek5KeU0wbW1DbzhyTU16ejdielFJZVRBd1BQ?=
 =?utf-8?B?UExZQ25wY1NsTjh3WXdRZFBRdTlpNERPT1ErcVErc2hqY21kWXJBUlV0U2hs?=
 =?utf-8?B?WTRxSmRVN01zMExjc0NNbHJFU0MwZFBHMDNGQ3pxNDlNb2x6NFFhVkZkWXl2?=
 =?utf-8?B?UUc5Q2o1aHJzU3VXOFVyMllabjduWHRqdzgzUHFQdzBVQytoSVVJYko2THM5?=
 =?utf-8?B?U3lkM3VSc0owT2JpTXVNZWtvb3R5Z1pESlhoRFhVUElKalUyV1U5MWVOZU1r?=
 =?utf-8?B?OExWT28wV1VVNGtGRVYyam5Lcmt1cFIxZ2RLOVlRVG10QitNdDlWajczdGFS?=
 =?utf-8?B?NE9WaCtlanN4YmQ4YWxCNG9lUHFsU2pZRkF6OUJ3dkR0OUNqcUN1clRrTzgv?=
 =?utf-8?B?R1lPaWVQbHlsRUJIcHVsK1BHdFQ0ZmwyVnIyMnNib0xiVGxVQ2d4eVJ2VWFy?=
 =?utf-8?B?QkJ3ZFdubnZRUnlLUmVGeU9wWndQRWdMbGtySzM1cWk2eTVBcUdSb0dwV2g0?=
 =?utf-8?B?NmNKc1hiRjRmcFYraEdycHVWZ1RoRHJZVy9uMG1NRkF6WGVDZHM2US9Zd1Fu?=
 =?utf-8?B?OW5ONXZ1SnVGNmhWek4yN0xPTjZURWN2WEs0em5zRjRpOHZ5djRTcWdha2Fw?=
 =?utf-8?B?N2lDZ0NDbjVaTllkVGdxSlhicVhCQ3NOZGZUQkc4UnVidkZaRnVuQzFnenQx?=
 =?utf-8?B?L1dXRm1sOTB4VTdBVG1YUk9aNzhzSmE0azVVMXdtUE5ZK1B6UEV6cVk2d3RN?=
 =?utf-8?B?a1J0UWtjNXBIRUg2MXdwUXhzaVpYL0lxNS9TZGVqTjFZYnZrWjdOS3dabHdj?=
 =?utf-8?B?ZmRKb040c25xY2tGRzRZem00UXpzcnlpS3N0aWtKQldSQUthakcyd2pIbm10?=
 =?utf-8?B?bnZFcmRLZnNIdFk1Q3lJaEMwei9kR3c2a25ScUtaQXNrVEp0RDJSUXdJekFx?=
 =?utf-8?B?MWdWeElxWjRncjJ1Zm9EVVpuMnpsdTAySEx4U2hRQ09mSCtwNmIzT29KYkVJ?=
 =?utf-8?B?VHBMSG8zYTRUb2Q5N0ZZK0VycE5zaFplcnduUkRDTHlpREh0S3IwTzVWVTd2?=
 =?utf-8?B?UGJUU09NUkVaUmZoUVlYTTBKcS8zWndPRmhUVzhVRUxkTmU4c3EyTG5Zei8y?=
 =?utf-8?B?N1JFcStCeTU4V01lOTBoRXZQWW9FWVJCMGVoOHJ4a0w2TlNjMjlodW9nQXRk?=
 =?utf-8?B?aitVS3lCb0p3TTJMM3NuYk5jZEx0eVR1ZTBrUUF5V3Y4NWtudmJTNlVWWCs5?=
 =?utf-8?B?dUNyY2VBQTJuMjZ6ZVpsNzE5c1c4MGxqK2g5cG81NVdiNThPeTZ3SXY2Y0d4?=
 =?utf-8?B?cklHWnFBYVViY3doMWxUNXRvaGtSNWlwVnBvbDNXengvVnpCSEJNcHdJSm5v?=
 =?utf-8?B?eWFCT2ZqQk1SeFRvdlhzS2NTV2ZFZTlGRE9idWw4S2hteHZKcG51cFozZU40?=
 =?utf-8?B?TGNEU3VuTldadHlqQnlTdUJ2OXJZaDJMaUZEc3J4d1h5SFV1ZnBhQXhXbks2?=
 =?utf-8?B?MVBkcmY4dml3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0xjVmdoWldSVEJHVDN4NEs5dFVHM3FrOVhaRlVVSWZHbnFIbmdybVFNeUVo?=
 =?utf-8?B?eGpMZVFGOW1pWGtCR1Mwa2pVcEtOVVAvbU40blRQMXdhc3dXSXNTTU5ndFRi?=
 =?utf-8?B?RFNhWUdKQWozTHo0MU1VeEpxbkdQTkVjcEZ2Q3NrN2U1dURNY25qc1FrTENa?=
 =?utf-8?B?aHZibFJyaE93ZTQ1UTBoMjV6OWR3eENuM2tDYTJKUTQxUDltTndVQlpZYTdx?=
 =?utf-8?B?NmozUFRiUjJuVDJFMVNVUEsvR0JSUDZjNmRMRGt4SG1YRXBIdm0xOXJ6TVJU?=
 =?utf-8?B?QTdQNXFsTzdNTG94U2x3Mjg1TGY5eExwSW13aUF3V2VlNTROYkNhVHpBanlY?=
 =?utf-8?B?T0FHcHd5Mk1jZkdpaVVEU3RGMm1iSHY1U2dLQXB3OWVsWmRrbENTWE5OYmRp?=
 =?utf-8?B?NjBxVWRUaFBFc1ZuREJxaFRSM0ZCYTlHYUVxRHloblBkV1Y2c2UydnpRem1a?=
 =?utf-8?B?NWZUMzQ4Vk80K2ZnQm5PRHRmaU8rTFJ1NmM2ci8reXZOdUhMV1pUTHFnZXpi?=
 =?utf-8?B?T0x2dXFMTEhtQzhhZm1BRTg4QUtLbW02eWszeGlHbmduNzAvTzgvdm02N2I4?=
 =?utf-8?B?Y0wyTTRscnZKNlFzL1d6dUcyUExvUVpDaDllTTVDZXpQaVA1RlQ5U1pkaHNM?=
 =?utf-8?B?K2ZNajJKTmNJTjBEOTk4MDZsQzBvb0cxci8zeXFVT3NBSXNaczlIWVdTNm1W?=
 =?utf-8?B?czB1aUFoNnMvempVd2xQSGk2bHNJb1pYTFFrMldLdWRxRnZYenBkcjlzZ29z?=
 =?utf-8?B?L1UzcHlyNmRyNzVmeTRSWStlUkx5SWZkRWNvRmxQY2c1ZU0xd1NrYnR2M1g4?=
 =?utf-8?B?VFZMSmtLYnRZdFR3OHRwY2VYelp1b3kwemVuSEp4cllFNHhFZnBaS3B4WXli?=
 =?utf-8?B?cFZtZzJHWjRSaTl3K2xEVU9jT1Bma3N3Z3ZlUVBtcmRFanJPWFEvZ3V0WjRP?=
 =?utf-8?B?RWh5eHMvYUNmQzVlZmtmbHJKZmdjRjYxWFI1eU45dStEaEhDU0w0VUNEYkh5?=
 =?utf-8?B?MWFYYkg3eTY2ZVdHUHIvS0VmM0IrVTQ4L1cvWHk2UHArKzhHTFpPbkpKUVU5?=
 =?utf-8?B?aHRnbyt4NVArOE9hV1JtOTAySGFLTHQ5QmlXemJLRlpzdzJUQi9Ybm5PNytF?=
 =?utf-8?B?MUpaVi9hRlpzdlkraXVNS2RCK3k0TG5VNHBITDRtM3R0RXFUQnJQeUwyRkwx?=
 =?utf-8?B?c1hxdjJTbGUrdEhFcE1ZNERRdXJFWmp0QUhjanVvaDdKbDhHSXl2V0RQandk?=
 =?utf-8?B?em9xZk5MTFJXUnJnQmZSdkhnVTE5eVRjYmFJUHhrR3Z3SnVOd1A1eENCUUly?=
 =?utf-8?B?eU40Uzk1ZG94RUdLMDFCUnZkZ2lnV1RTK3NoQzYybHdPNUdWVjlKK0d5cGxC?=
 =?utf-8?B?RXhQNmlvZWRHakRQNm8rYjdJYXYwcm42Wlo0SGE2cU5pRE9tVm1JTitEL1Fk?=
 =?utf-8?B?RUhHQVFGa3BhR1B1OWYyUVVHYjNmQy9xMTArK2ZxcXU3WndtNVRkZzVtT0JM?=
 =?utf-8?B?d0QyY00vYno5bHF4RDJhMS9sREpIWTB5NkZydlRPNkVzYXRwY0VWTDl2UDdp?=
 =?utf-8?B?QUtiT0lwdUJBVEQ5KzE3eWcyT0lZS3VTSStQN0pmSFBVOFFBRy8xSkxHelgy?=
 =?utf-8?B?TDZURHlWT3NoL0l5ZWR6MUJHMEgxUXU5WkdCbFowdHZxM3JwRnN1Nm15SWN1?=
 =?utf-8?B?ZURMaXZFNHZkQ1kzeEV4L3AvMVkyUTZFbUFwN1BRcXBROUhiSHhDbzhxRS9Q?=
 =?utf-8?B?ZWQ5VlFmakxGenhHVFM1czhzWkxjcStyS2hIY0ViaTRZY1ZSUjJMaDB6WVIx?=
 =?utf-8?B?ekh5Q2tXaVFEY28vQ3R2c2hCSkpOTVJ5amZFblVGbW1qR2tLQTI4MmVMcTRG?=
 =?utf-8?B?d1NoMFgvNHVFRUczT2txcFplVy9CUHNoN082R1hvYjAwczRlUG9nNjZ4RFBv?=
 =?utf-8?B?ZDV2ODA1YmFQV3Fha0pzNHdpQlBlZHRXa0p5RkRadzFLZ0cyUGdUZHl4ZnNQ?=
 =?utf-8?B?N3ZLdnJ6US9rcmVWY1E5RjJLcitmVVZXa3MyZG1YaVZCVEdqNzhtdVZpbVN5?=
 =?utf-8?B?OGhUNm1KOXU0aHhzK3FvQ2pxMUUrYjRiYlVET2JaZnFwZUdUSVJmYURzN1Zj?=
 =?utf-8?B?cldUOVBZbVhxZjlQaE1PQUY0WHZtQVVCZEozOFFRZTVwaFVrOEVLclloRVUy?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3C48954A76BF54FA5A50AD78CE80704@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Lf4r2AmlZpLNlpX6vHl4XkEUb6bVrGXCWLK7f+x/Hq3lrPAH/kkG83Nq6hVZRRINmPfvasZmO4Iq87tNh/lamRcQAEOSr6UK5kY+IG+ysY4OnfnL+K6N+Dnl7hmGBckxjk8/NaHB/F3Qat+w/4a6lxn1iB+1eGJBgjmpSUT7OMOsP463qm61hmXq9fXPYy9hFQxHRAda4c2CO8iXDZMCqdFEuAcmbf9U0zEO/oexmC/2xtLuBkuj0/aV8FyT2WjzcIX94CF1XsfO+N3Aq7fZXeDKza5hMjQ0Qt8fZApAWdZMmVxO9dtHg3zvgixT34Wdd8wfq6VUaXCsOjeShrmTY1KgRmixpVSlf8nYfAfqXlKpY4CQuTWrJaEclIkzvknNR3/YrapVT/NUcUxvtnTJhyLkrK/2iTbbej/PUDZoTRjf6GU3/mQk9BewdhYdfY/EHQ4ZbQUXvfoRvEyq/6Bm0NN/ScshhTasr3tibsdlz6DHfIvEIAqslPk1mpFbYMHZa9VMxYcVkpUEP6lW4xaLpGPpo4dhYGPAyM02OFl4SlHKfxzm+roEaJiC98pmTV4fCyKLQ8LX+jannDUbGqhd1eRfNc3jI/EvyHjvkx/ZXhg6dSs18cpXtCp+4Gi+ViqV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0661fbb5-5d8a-4bf5-2758-08ddc2705e0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 00:50:02.5857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oIq5YMFRunLi9UVTp1g1mDCVLG5rtuNjZfNvTTeg5lsX/Et9uEX0SqRscRBJ0BK6UhOyQezj9Z3c55LQCZye+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8849

T24gRnJpIEp1bCAxMSwgMjAyNSBhdCA3OjUyIFBNIEpTVCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdy
b3RlOg0KPiBPbiAxMS4wNy4yNSAwOToyNCwgTmFvaGlybyBBb3RhIHdyb3RlOg0KPj4gKwlpZiAo
YmxvY2tfZ3JvdXAtPmZsYWdzICYgQlRSRlNfQkxPQ0tfR1JPVVBfREFUQSkgew0KPj4gKwkJLyog
VGhlIGNhbGxlciBzaG91bGQgY2hlY2sgaWYgdGhlIGJsb2NrIGdyb3VwIGlzIGZ1bGwuICovDQo+
PiArCQlpZiAoV0FSTl9PTl9PTkNFKGJ0cmZzX3pvbmVkX2JnX2lzX2Z1bGwoYmxvY2tfZ3JvdXAp
KSkgew0KPg0KPiBJIGdldCB0aGF0IFdBUk5fT04oKSB0cmlnZ2VyaW5nIHdoZW4gcnVubmluZyBm
aW8gYmVuY2htYXJrczoNCj4NCj4NCj4gWyAyMDU0LjYzNDgzMV0gUklQOiAwMDEwOmJ0cmZzX3pv
bmVfYWN0aXZhdGUrMHgxZTAvMHgyMjAgW2J0cmZzXQ0KPiBbIDIwNTQuNjYwNDc3XSBSU1A6IDAw
MTg6ZmZmZmQyMGYwYmQwMzliOCBFRkxBR1M6IDAwMDEwMjQ2DQo+IFsgMjA1NC42NjYwNjldIFJB
WDogMDAwMDAwMDAxMDAwMDAwMCBSQlg6IGZmZmY4YjdkOTg3NDdjMDAgUkNYOiBmZmZmOGI3ZDQ3
MjlmNTA4DQo+IFsgMjA1NC42NzM1NzZdIFJEWDogMDAwMDAwMDAwMDAwMDAwMSBSU0k6IDAwMDAw
MDAwMDAwMDAwMDQgUkRJOiBmZmZmOGI3ZDk4NzQ3YzEwDQo+IFsgMjA1NC42ODEwNjldIFJCUDog
MDAwMDAwMDAwMDAwMDAwMCBSMDg6IGZmZmY4YjdkNWMxM2IwMDAgUjA5OiAwMDAwMDAwMDAwMDAw
MDAwDQo+IFsgMjA1NC42ODg1NjNdIFIxMDogZmZmZjhiOWM4ODIzOTQ4MCBSMTE6IDAwMDAwMDAw
MDAwMDAwMDEgUjEyOiBmZmZmOGI3ZDVjMTNiMDAwDQo+IFsgMjA1NC42OTYwNTBdIFIxMzogZmZm
ZjhiN2Q1MzE1YjAwMCBSMTQ6IGZmZmY4YjdkNDczODk0MDAgUjE1OiAwMDAwMDAwMDAwMDAxMDAw
DQo+IFsgMjA1NC43MDM1NDZdIEZTOiAgMDAwMDdmZjQ1YTRiMjg0MCgwMDAwKSBHUzpmZmZmOGI5
ZDAyYTdlMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDANCj4gWyAyMDU0LjcxMTk4OV0g
Q1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KPiBbIDIw
NTQuNzE4MDkwXSBDUjI6IDAwMDA1NjA1MWE4OGRmNmMgQ1IzOiAwMDAwMDAwMzRkYmMwMDAwIENS
NDogMDAwMDAwMDAwMDM1MGVmMA0KPiBbIDIwNTQuNzI1NTgxXSBDYWxsIFRyYWNlOg0KPiBbIDIw
NTQuNzI4MzkyXSAgPFRBU0s+DQo+IFsgMjA1NC43MzA4NTRdICA/IHNyc29fcmV0dXJuX3RodW5r
KzB4NS8weDVmDQo+IFsgMjA1NC43MzUyMzNdICA/IGJ0cmZzX3pvbmVkX3Jlc2VydmVfZGF0YV9y
ZWxvY19iZysweDc3LzB4MjMwIFtidHJmc10NCj4gWyAyMDU0Ljc0MTkxNV0gIG9wZW5fY3RyZWUr
MHg3ZTkvMHhiNDAgW2J0cmZzXQ0KPg0KPiBCdXQgYmVmb3JlIHRoYXQgSSBzZWUgd3JpdGUgdGlt
ZSBlcnJvcnM6DQo+DQo+IFsgIDIwMy4yMzAzNzddIEJUUkZTIGluZm8gKGRldmljZSBzZGgpOiBo
b3N0LW1hbmFnZWQgem9uZWQgYmxvY2sgZGV2aWNlIC9kZXYvc2RoLCAxMTE3NjAgem9uZXMgb2Yg
MjY4NDM1NDU2IGJ5dGVzDQo+IFsgIDIwMy4yNDA0NjVdIEJUUkZTIGluZm8gKGRldmljZSBzZGgp
OiB6b25lZCBtb2RlIGVuYWJsZWQgd2l0aCB6b25lIHNpemUgMjY4NDM1NDU2DQo+IFsgIDIwMy4y
NTEwNjRdIEJUUkZTIGluZm8gKGRldmljZSBzZGgpOiBjaGVja2luZyBVVUlEIHRyZWUNCj4gWyAx
OTU4LjY4OTk0N10gc2RoOiB6b25lIDEzMjQ6IEFib3J0aW5nIHBsdWdnZWQgQklPcw0KPiBbIDE5
NTguNjk0Njk3XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkaCk6IGJkZXYgL2Rldi9zZGggZXJyczog
d3IgMSwgcmQgMCwgZmx1c2ggMCwgY29ycnVwdCAwLCBnZW4gMA0KPiBbIDE5NTguNzAzNDI4XSBC
VFJGUyBlcnJvciAoZGV2aWNlIHNkaCk6IGJkZXYgL2Rldi9zZGggZXJyczogd3IgMiwgcmQgMCwg
Zmx1c2ggMCwgY29ycnVwdCAwLCBnZW4gMA0KPiBbIDE5NTguNzEyMTU3XSBCVFJGUyBlcnJvciAo
ZGV2aWNlIHNkaCk6IGJkZXYgL2Rldi9zZGggZXJyczogd3IgMywgcmQgMCwgZmx1c2ggMCwgY29y
cnVwdCAwLCBnZW4gMA0KPiBbIDE5NTguNzIwODgxXSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkaCk6
IGJkZXYgL2Rldi9zZGggZXJyczogd3IgNCwgcmQgMCwgZmx1c2ggMCwgY29ycnVwdCAwLCBnZW4g
MA0KPiBbIDE5NTguNzI5NjE0XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkaCk6IGJkZXYgL2Rldi9z
ZGggZXJyczogd3IgNSwgcmQgMCwgZmx1c2ggMCwgY29ycnVwdCAwLCBnZW4gMA0KPiBbIDE5NTgu
NzM4MzQ1XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkaCk6IGJkZXYgL2Rldi9zZGggZXJyczogd3Ig
NiwgcmQgMCwgZmx1c2ggMCwgY29ycnVwdCAwLCBnZW4gMA0KPiBbIDE5NTguNzQ3MDcyXSBCVFJG
UyBlcnJvciAoZGV2aWNlIHNkaCk6IGJkZXYgL2Rldi9zZGggZXJyczogd3IgNywgcmQgMCwgZmx1
c2ggMCwgY29ycnVwdCAwLCBnZW4gMA0KPiBbIDE5NTguNzU1Nzk4XSBCVFJGUyBlcnJvciAoZGV2
aWNlIHNkaCk6IGJkZXYgL2Rldi9zZGggZXJyczogd3IgOCwgcmQgMCwgZmx1c2ggMCwgY29ycnVw
dCAwLCBnZW4gMA0KPiBbIDE5NTguNzY0NTI1XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkaCk6IGJk
ZXYgL2Rldi9zZGggZXJyczogd3IgOSwgcmQgMCwgZmx1c2ggMCwgY29ycnVwdCAwLCBnZW4gMA0K
PiBbIDE5NTguNzczMjU3XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkaCk6IGJkZXYgL2Rldi9zZGgg
ZXJyczogd3IgMTAsIHJkIDAsIGZsdXNoIDAsIGNvcnJ1cHQgMCwgZ2VuIDANCj4gWyAxOTU5LjMw
NjkwOF0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGggc3RhdGUgQSk6IFRyYW5zYWN0aW9uIGFib3J0
ZWQgKGVycm9yIC01KQ0KPiBbIDE5NTkuMzE0MDMwXSBCVFJGUzogZXJyb3IgKGRldmljZSBzZGgg
c3RhdGUgQSkgaW4gX19idHJmc191cGRhdGVfZGVsYXllZF9pbm9kZToxMDE1OiBlcnJubz0tNSBJ
TyBmYWlsdXJlDQo+IFsgMTk1OS4zMjM0ODFdIEJUUkZTIGluZm8gKGRldmljZSBzZGggc3RhdGUg
RUEpOiBmb3JjZWQgcmVhZG9ubHkNCj4gWyAxOTU5LjUzNjkzNF0gc2RoOiB6b25lIDEzMjU6IEFi
b3J0aW5nIHBsdWdnZWQgQklPcw0KPg0KPg0KPiBUaGlzIGlzIHdpdGggdG9kYXkncyBmb3ItbmV4
dCBhbmQgdGhlIHR3byBwYXRjaCBzZXRzIG9mIHlvdSBhcHBsaWVkLiBXaWxsIGRpZyBkZWVwZXIu
DQoNCkFoLCB5ZXMuIEkga25vdyB0aGlzIGlzc3VlLiBUaGlzIGhhcHBlbnMgYmVjYXVzZQ0KYnRy
ZnNfem9uZWRfcmVzZXJ2ZV9kYXRhX3JlbG9jX2JnKCkgdXNlcyAiaWYgKGJnLT51c2VkID4gMCki
IHRvIGNob29zZQ0KKHNraXApIGEgYmxvY2sgZ3JvdXAgdG8gYmUgcmVzZXJ2ZWQuIElmIGEgYmxv
Y2sgZ3JvdXAgaXMgZnVsbHkgYWxsb2NhdGVkDQphbmQgZ2V0IHVudXNlZCwgYmctPnVzZWQgPT0g
MCAmJiBiZy0+YWxsb2Nfb2Zmc2V0ICE9IDAuIFNpbmNlLCByZXNlcnZpbmcNCnRoaXMgYmxvY2sg
Z3JvdXAgaXRzZWxmIGlzIGFuIGlzc3VlLiBJIHNob3VsZCBoYXZlIGluY2x1ZGVkIHRoZSBmaXgg
Zm9yDQp0aGlzLiBJJ2xsIHVwZGF0ZSB0aGlzIHNlcmllcyB0byBpbmNsdWRlIHRoZSBmaXgu

