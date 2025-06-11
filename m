Return-Path: <linux-btrfs+bounces-14603-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76225AD51CD
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 12:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24664189FF47
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 10:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322D72652B6;
	Wed, 11 Jun 2025 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jHElARSg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pMo8tVSO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EEE25F967
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637566; cv=fail; b=ck5MfyaKCbjVwUJFTqS3hVPCxI4g4QkxF8WYOMB60mwvylvTjZIhaikdyB0XrxE801a/KvPgct/4aXIy7QXA5rkarUHI4X7UfGSQPq7XjvTuy8gkNh7WQgs1hHdQmhjAcOW9FN+Yi0y5+3pwoeBpOFowyJ1cySypH0viQYnG6tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637566; c=relaxed/simple;
	bh=/yHID/oo+kRjoTqJH53TMSj9IBrmrl4TEGXzuY+I1uQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J2B0hqR7htWwi0T7J51zivh3L1p2JQ8F4Q6FBTRh+th9p7BbbDdzedPiEReybnZ89osgeDPpuiAgkawQh+IdoQxrWV4q50c3up+L8mByoAEpSPBQOcA8t/elDIh5ePAGwdhC9I1n+ovg+vbC/k9xIGyI1QrFKvvReK0az5L/O1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jHElARSg; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=pMo8tVSO; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749637565; x=1781173565;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=/yHID/oo+kRjoTqJH53TMSj9IBrmrl4TEGXzuY+I1uQ=;
  b=jHElARSgBOYIYmwz46yB8ziGFyhUrmvGYsrLettx7WKAjEL5NNjShEkZ
   duksU9q5WTq0Fj0sEYSzIj0CsCNkc5LE3EDuRAEMlzXFBFrLpCotQpBjf
   9smvihH8/19UwTVj5roGQlfRgN9RzHXGM9bZrYu/ZO/hjV+qFYadZz9CD
   r8nL+D/vXEDsXekEU6UpFV4+lpKSnVtI+XRa91fywX0e2ZaKUaXkagUbs
   8P7UZN8zC8NtL9dnTm2F79H/KKfb2QLkFRa9bV3r1+yj+NS3CzH4j9maJ
   2axiBIbTIN9/e1ty2BYUAXZhaQTId24K3riy9/JAmGaVaYXR0Bq3nOdsd
   A==;
X-CSE-ConnectionGUID: 7taV+FINQGysbn3af+QDKw==
X-CSE-MsgGUID: CdAEGQ9TTIawOAkecp6rRA==
X-IronPort-AV: E=Sophos;i="6.16,227,1744041600"; 
   d="scan'208";a="86381500"
Received: from mail-westcentralusazon11012049.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.200.49])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2025 18:26:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0H8rmCO1liaf+zJz5Jp6pX4s0PuLDMZrzNI9aorlT9JHSebQBWnQNiklyS54DsvEDI8uY/pv0Dftas4A82EYBe7Q1R8dB0dHDsd9OgDKuG7bp9oNTdyAtbYSJYxIFTUgkzLrxoUvkawKrUItJSElYYF51NtsKL5rXFVNbgqTsw2sQhe+l8fd3rawZqcaDW06Mrod1UBMnV/EobqCGrPLyHteD3l0tK1XA1S9X0SNAr2BI1RyOXi5XQri68yQjozs3sGha+AHvcD/9IGN1jg6PqcsbyF7xh4AaV3PvO7HuhFAcXnPpX7W4Jvmx6x+sZJ3U4NR6DU/hPr8v50IxWEYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yHID/oo+kRjoTqJH53TMSj9IBrmrl4TEGXzuY+I1uQ=;
 b=HzHlIRyITfSSET33Qm6NFOzZbu1A4hiyfBNXmDC6eOOl5GjMi9utGNxrqzX4D8Gcuxd88A7Zl/fQKeFVmgETV3cBWbnWhPruYfiQnGU664/ooGDe2FcA6tlAVJgj5qC7MyvBdQfZctiySoweeb1s+yWEbNARV5ABYUV5VWoYRd05x+Qzl6/MR4wivMG9uYLppjrr91Chd0yxJnJ1ceDmh3nfdRvqJ85pxT8gPEbemUUE40jH6Zs6d48yCKzadYYYM0hgJhTrOojP6EVHKKGe2X8vq8Xgj8VuFHe5nGOZRQBXiao4FOQu73cCsR30LjIG9pNdI0nla6xRRdhMD1kUEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yHID/oo+kRjoTqJH53TMSj9IBrmrl4TEGXzuY+I1uQ=;
 b=pMo8tVSOY2SqqkRx5n6oN3gIKpeAbij1Li605bNZ8/OzhrpzEXQ7rVRILDRJPNnZzJj4CPCqh8K53j0cBqoAIJe6HwseUURb2IGJnMESA7ln043dIR71lWYUzwRVBsLXEiTARVG0zmiPGOreG6cLouuoI67/I76L9A5r0mT9yAk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7792.namprd04.prod.outlook.com (2603:10b6:a03:3b8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 10:26:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8792.039; Wed, 11 Jun 2025
 10:26:02 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] btrfs: simplify range end calculations in
 truncate_block_zero_beyond_eof()
Thread-Topic: [PATCH v2 1/4] btrfs: simplify range end calculations in
 truncate_block_zero_beyond_eof()
Thread-Index: AQHb2gHdHVxzr8j+i0C04PeQUwlES7P9wnCA
Date: Wed, 11 Jun 2025 10:26:01 +0000
Message-ID: <b9241722-6095-4c83-b93b-8e9aa29e0eab@wdc.com>
References: <cover.1749557686.git.dsterba@suse.com>
 <f158a5836e767d722627920c4b3d5c5942e95b35.1749557686.git.dsterba@suse.com>
In-Reply-To:
 <f158a5836e767d722627920c4b3d5c5942e95b35.1749557686.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7792:EE_
x-ms-office365-filtering-correlation-id: d4eeb30b-fd83-4ad0-d8a5-08dda8d25d69
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U0JJR29RblBNV2llblIzNjUzWGp4U0tKZGNLSThlY0o2Mk9lZFNweEMzOXJU?=
 =?utf-8?B?YWhlR1NKQU1NQVBOYlgzZTRSZnlmNzBSRmdIYW9Gc2tWb2lXWmtOQytsaUJ2?=
 =?utf-8?B?cjAwYy84TVhRMjBjdzFIR0hTeWgwOUg2WnlSR29DOGhQa1pieStLQmFGU0JQ?=
 =?utf-8?B?OWpmY1B0NkR5NXJVcVNaVlBEKzZZZ0FQQ3hzVDJuTnh3SGtFTGFqdmtWOWU0?=
 =?utf-8?B?QlJvZ2JNQnY3Um54K3k1TWxaS3pRcm9jTCt5ZFZZcGMwTWp3TFpaTmt5dlNZ?=
 =?utf-8?B?VFVGdHNOcEd6L1dvQ2J2cENFYk1MZ0I5cW5HSHo5SXhJRXBRTTRXLzdWQk9y?=
 =?utf-8?B?ZENoUTRPTjMySW53Tzg3Tks5NmcwSEtLVGZzRlpOYWphR3JKMHJhLyt6K2Mr?=
 =?utf-8?B?a2dxdy9ZMkRTMElKdVEwVWVWcDg4MDVGNTljb1ZiR2w3RG40bG5UV1pGYkU1?=
 =?utf-8?B?TTRFUHZNbmplelZYMkhMaGFWaTlaa056bG1yNldRSDMwTG5FL0E0WFc1Wmts?=
 =?utf-8?B?V2F1czdRd3p3K0ZTQlZ4ZjdLTm9UYzBHRVJSMmF4bVU3S3U1VWpOMG45cnNq?=
 =?utf-8?B?dHJiWlIzYjJPUnB6WXBaZGZFaEFOem5PcjZOT25zNmFzcmlqL05qeDNZbVJG?=
 =?utf-8?B?VlV6WG9KamFjV1VFN056QnpHaWJjN2J5eVdybWNldkVLVzA5YnFMZzB5bk4w?=
 =?utf-8?B?a1RxdEdJVFVVMXhGeVF6Uk8zVldiQk5kd0dyZVBpbmkrck9LQ2ZBV205eVIx?=
 =?utf-8?B?Wm9WM3RhT2JudGF0TFc4L1RRMWp6b3U2VVIvM3hjYmh0TTZnRGhWWVozWHBm?=
 =?utf-8?B?Z2VFa2IvaEZBT3ZJNnFGaGFXdzNLQXo3UjFDYU1CV2tZeDRHYUNvQVorQm9r?=
 =?utf-8?B?N05qN1lGenFiblowS0xzakN2KzE2RUdUS0RxbHo2YXVOUkZoU2JzVEhnOEp4?=
 =?utf-8?B?cytlRDRBVnJkU2U4Ri9tdjVXWVdlYitWMzBnOWQ2MjRIWlE3akh3dVpFTUEy?=
 =?utf-8?B?akJja1l4dUVXREFKc280VHZURzBiWUx0U3g2WnVHOTlmVUE0TGgvNXVlTkh6?=
 =?utf-8?B?N0VEYTFPTi9zdmZvM1FGaG51VzRMNmJUdFM2anVPUXUralJnQkVmREI3YXdl?=
 =?utf-8?B?MFpOMEswdEZ0QlJBY3VnU1dXcjhsUklZeUVhMlAwSGxOK3p4L3Btam9HcDVv?=
 =?utf-8?B?ZmlWbE00RFhkY3lyZVpQOVdCNzNObW9taGJwNFhpN1lZdVB3Z3RnckI2TWgv?=
 =?utf-8?B?S2hZbENQMkVWdG9vekNXQm1PTnAvakV0YU9SeGxodEFWTTUzSGliN1NvdFJ5?=
 =?utf-8?B?MkJIWUE2V05UWmJCMmtkdE9WWkJtdVdTZWdPTlRxeVQ3enVaZm9zcXVpVWxU?=
 =?utf-8?B?Ri8xSU9aT0lXZ0JEZDJIbUxHYzBGYVZwLzdjZVBTNUpvNE9qMVlqbDBxdVVs?=
 =?utf-8?B?M2d0SHlOWUJGb2ZBZFRKeVJQZ2R5Nm1yY3J3WXVGSTBQV0VOWUtNLzVlVzJH?=
 =?utf-8?B?YlhmaHZ0K01JdElDSGRXVlFiWHA2L3g1WDNNU2hEY2hkRnBqTmNieFRMdkZv?=
 =?utf-8?B?NlhhM3RrYStNbUp3NU11MlhVeVhPcVlYU3dtcUdRSkVtRGcxSnIyMVk5czIw?=
 =?utf-8?B?aGJ1MmExRXdiNklJUW5ZSHFHRW8vVEtmVytzQWdjWjdVdzFETFpvY2JldWg0?=
 =?utf-8?B?VGtrN2RZd0ttSWZ2b2xPTVpnSDJuMkJydDErbGdneTJHZWlGb2RLM0xuUUlM?=
 =?utf-8?B?cUxGWW9Ed1czTGZqRUxBdXpEa0ZEOGZpR0hVaWpmSlR6bHloaC9VU1dESlh2?=
 =?utf-8?B?S05PS1hXTCt0YjRoTlViK1RKUnkrTFkrdk5OV3plQXdvT24vdUhxajZEcXU5?=
 =?utf-8?B?MEowMkdDd2VuYUczak1uMVZLU3A4WVlHRE5aM2xKbGlraGYyR0phaTVnOFll?=
 =?utf-8?B?YU1NRnQzSnZLd1BkZzJCYjFMZ2NhaEFBaFcwV3hYOVB3OUI1ZWk3ditjSkky?=
 =?utf-8?B?R0dqalQvdVlRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anJMcmVCandNbmplaXhmbUZiVTdZeWdhVlNJT2NLVkZpc250YndrUmhNVXR0?=
 =?utf-8?B?d0FwUDBxbE5xMnFhcWFiN0VJNHZOdEVzMXdoS1RqMEdXeE1BcFc5dGNXYWI0?=
 =?utf-8?B?U2RZTTF1UkxhaFZyQzFibDFvS0VTWTU3MStpNkRtSE1zeXZ1UzZmQldWOExw?=
 =?utf-8?B?SGErQ29JUnVhMmZoQXZqMDdjSEFndG5VZENLSDVFYUJCMElPVGV6QUw4eEs3?=
 =?utf-8?B?K0tuS2FPUlBrelNGN0NLUW1RRmxiTTgrVytHREJHNUIyeDZaUXhpekN6RjNv?=
 =?utf-8?B?MTBSNTRJYXFsL1Z3bEt0S3NlazVxMTM4QkxrWHJqaWlISjhIYi9mUEYxR05K?=
 =?utf-8?B?ZUdFcWpkYm4yVUdzTVhINVpDM2hQZ0tHbzUvWWMwOHl4WGxmYTcvYklaYzNH?=
 =?utf-8?B?NDR6RlUxQlZrdHBzV09yMUNKZG8zZFNvbkJGTTladkhjdU1EOUM1Yk5UNVEw?=
 =?utf-8?B?T011SFFTaWdMdG85L0QzU0lHdUhlTG80d2E3UVl1enpuVk1hQkZYK25ycjJ2?=
 =?utf-8?B?cTEyWTAzVmZtakRYdGUxOHh1T2w1anlFZDg2cHlBckhsRmVLck9XeDdzRVpu?=
 =?utf-8?B?eWNBeDJPUWxaRU0yZCtWeXEzaUVOWnQ3d05GSjk1SG5OS2VQeGM0U1NQL3N3?=
 =?utf-8?B?WmN6ZGYrQ0xJUldNNmVDUVZWQzVqN0NTWkRqbzJ2a1ZiOExKamVlaUd6ZEcw?=
 =?utf-8?B?bnNWakV4MU9LUktTRVRlWWgrR2F6RGxRMEVzSlYraVhTc3NGZ3k0cHpUaDJm?=
 =?utf-8?B?Mk9tK1lvUGJXNEErcDJtRFJkWWJ3YmJ3czZJOXM4OVd1ZERZOXh5cGtxdm5T?=
 =?utf-8?B?UTZRYTVnU3daV3Z4RlZSeTNhL01hSDlwS0xLNWpMdFl0VkplV3ZZRDVzbC91?=
 =?utf-8?B?aEh1ODlxM05TcXY5Z01uM2NNb0VOL1RKMFdYbHAxZGdJQnJqYTFKWkRkdmly?=
 =?utf-8?B?SFFMQTB6dzNqYTQxTEUvcy9qUWZ1R0sxbzVJQmMwYVJwTWJ3RmxDeGtrZ2xC?=
 =?utf-8?B?RDNXa0t2QUt6L2ZOMUtNTTYyR2hreENxa0J2L3M4MHg0WFh1S0R0NngxUkhK?=
 =?utf-8?B?OHh3bDl1c1ZQcDRIK2J3WEl6SGVHUDk3K0FFNmF2ZHZUcEhGb3VDQnNyazJy?=
 =?utf-8?B?QncvNk1OWklvOU5RWXpkTGErdW1DMDMwUGo1emxJVnR3QXgwTVBoZ2ZmUWd4?=
 =?utf-8?B?UGRaOXEvQTl1OWFpWGR5R3RlRnlpNlpQM0dFY1dIS3BCM3RNdFJSdHpId0lq?=
 =?utf-8?B?UFpBMkJvUmpoMFpGQzFoWXpqemh3V29jU0dtMnk4dXZFUy9mVC9qNzBrMnhv?=
 =?utf-8?B?RjFOQnYrWnZXV1NXUWpzODE2Zi9DY25iSnZnT3RmWHNoWXZOM2J1MXF0RGw1?=
 =?utf-8?B?aFR1U3l1a2I4cXkyZFRrNWM3ejc5ck1uTVhKRndsd2NxamttcGFHV1ZxRXBn?=
 =?utf-8?B?aUh4QmRMaVlVUXJJRit0V0NzYUdiRkRReHZjTkNXTVk0cnlEbGpBdFY0TmpW?=
 =?utf-8?B?am1hMG01akJZNUF4ZGQ5bE1jWk1xOWxwM2VjemU4Y2g4ckZEUlBFaHp5a2g2?=
 =?utf-8?B?Y0xOSkJ3RGNIcmMrbGc3czBGQVNHWSs1bE1RRm55QmJVRmJqeTloUDdNU1FL?=
 =?utf-8?B?VGFxOHdDUjlHenlVVjVud0VRcEJ0R3VUNEdqdUMwc1Y5UGVwQXZBT2dZa09E?=
 =?utf-8?B?UVBjWHRpSXlRY05SNzhwZCt5TmJGL0hpRGZBWkpaSlBmMWQ2L3N5NG9YM1cz?=
 =?utf-8?B?SXFkeGY3S2QxUGV0dFlLVVdrd2hMNnkvenZ6L1JRUW5ndGVKZVg3RkNLTXps?=
 =?utf-8?B?ME53OXBwYzdpZFBzYStuRHVPNkx6MWJqcmt4bS9rMGd3dEFsdkdqSnZrWGxi?=
 =?utf-8?B?dkEzZm9DZ1dObEd5azNUdytrL0xJS3BMQTFYWHMyMENldDhaR1ppUnJ4RFVt?=
 =?utf-8?B?RkNqaFNHZ0k0cHpZOEpmUmRDM2FXU1NrMkk5SjBRRElTL0E5cW1TMTNxRWlm?=
 =?utf-8?B?QUY2MUEzaE5vbDhJSkFCNjJySTlIUnExcXNKK3BXWktDSWpOOWlOU2IrZllB?=
 =?utf-8?B?UUl0WERuSUJZMmRxY0tCRVNaSGlNdnFVZ1JWWDVBNi9ZZk5ZWTJBUU15K0hy?=
 =?utf-8?B?bEM0VFRYWXRiMmlJM1o3NnRmaE1iYWxtc1MwbGNSdjVjSnNxZE1ySG5XZHhR?=
 =?utf-8?B?bmE4UVI2WjRzV0Z1UWJNL3VPTjlmamoyUTNOZUZGalptZm9INDNENFJGNTMx?=
 =?utf-8?B?Z3Bvb3E1STZzNnZPYjdaQk9DcFZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFEDEC5E5249AA4DB0EC4007578BC2B8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dWA5/N05ck7TeyXx91o9umfzDiqbFvI4xUpGe0mT+JxS7C7prbSpUHYhA1TaIhXum9RO0T4Bj/8ncEjpOumvVwuEbNAO6GA/UqP9hLaoQ88zEW6x/U1AwBP8t5zhXpzqut3I20+euSBNd73n7Vhe5kqJC/S4JOutEHQaj0pfyIYv/KyLecpQEjrHVQPfaZT3N61wo2Yo8ckQiAM5wMH4MUW80aGtJng7zxVFo+86a7tuMWMpOR4TKRB7c0AKwLkjIuNVmHTi+udf6BNnvW5HImw1nhrB77RyUWoDPF32EuM6YB+XonOi3PJdWCn/DRgfCOAKdDaG5+GCnmKcUgyIph1Ma2tXby3lF2n/bE9DjzjAZtpOrEYDT+149MJg3y7rmR8lqHMonAgsZyx3aLStiEF/kzPFoYTWbYeqZav/78YHlVwfh2DguxkjIPOQMs1A7zn/piNSFCBIR51z2zVtJ4cwJhITOHPORG7nfK40RS4RFT2SZytANcNkUkdvM0magslTvPrLjh5pX07bCDEuZ0ZWGbvRP1EcvRSy5jH5yTCzU+E/GT/tbEF5AJd+sH7JH4lF9DizbV9sQbiwc3bv9Fg6qTJWdWJBw6gibK849PJpW9KWbwyIwxs0+xYcsIC2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4eeb30b-fd83-4ad0-d8a5-08dda8d25d69
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 10:26:01.9790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tazq9p8cZV71otNBrMjR6EageV3v7AUn2uhu6E5t4MpKxaH/ABc6S0Xk6IKe65uIJ92cK9kIibg0rILpCAZGGvcdn980YtvL6bVSOEdXFrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7792

T24gMTAuMDYuMjUgMTQ6MTksIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gVGhlIHdheSB6b25lZF9l
bmQgaXMgY2FsY3VsYXRlZCBhbmQgdXNlZCBkb2VzIGEgLTEgYW5kICsxIHRoYXQNCg0Kcy96b25l
ZF9lbmQvemVyb19lbmQvDQoNCg0K

