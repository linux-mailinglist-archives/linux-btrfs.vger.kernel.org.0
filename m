Return-Path: <linux-btrfs+bounces-11515-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C2FA38A73
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 18:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D6C161E32
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 17:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295632288F4;
	Mon, 17 Feb 2025 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Su/Fo+Rg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fuVU//Y7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE04224894
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739812584; cv=fail; b=qgrcYcYhMwaqAAQpUlTS7g5ATyZ0+KtY7FLLAex5PPC1Jil3BR5+YT+LrTF6HjztwzIZlrASOqr6iAcbJQIqlXBXcyr1dpjr5TNyzDQwlxa8B2NPsu6UfgZ3f4oI6aaD2Kz6wiiPZ+IDFcPuHNOmosDSZq9bn0MUgsO8QekNUiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739812584; c=relaxed/simple;
	bh=KMfw8jc1Sl1JTUA9JfnoCmyfSPAO4g9yySsRZ+Y9RdQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ngIUGobZmp5g2HKKM5o0hZ8jZp+OhjUd6uLOmod9T24vTsCsL/79iHVioN/u1tQ21yTw2WbHbK3DjXSNRTJvowSrLuRw6dYj0rbkmxJKK/HydxVED2zF8YJGetSEAqSnvXVgBTkreozqh1x26CX8fL0l13l83lIiyMUpdoIKiOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Su/Fo+Rg; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fuVU//Y7; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739812582; x=1771348582;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=KMfw8jc1Sl1JTUA9JfnoCmyfSPAO4g9yySsRZ+Y9RdQ=;
  b=Su/Fo+Rgg3mH9N3tFfrJzHdh9gnGDW5dQPSwiHC58DCveswQsUvQH4W8
   jM0jmgJPEG3rrkoui5YOg5y/2LFCHr64VeynYm1Urec3oxWwhyFeL+lHb
   gkHX2xC6j0F+nTD5cOyCp5e3EehuxYqX/LFfrvTgqV01pjldiBBWJSMgW
   +uEGGddLytn0QifEoi4OVOGnUxOTlQUhMlsZRvYST0f2vw6ndBE6zZUtk
   4Pi3VbOJWfmQSFCCLyCG1qhGTMuZweSuEI/9UQcvt3qUC6AHEP29sE8Fx
   G7LE8GCdQnyRPj/Gc4mZU7hU4tSq5pyvlN/NE4M7p9lZ6ORdKObuiENsx
   g==;
X-CSE-ConnectionGUID: r8B/v701SmqxDZeyJYVxmw==
X-CSE-MsgGUID: CXOUPZa/Q9CFu64751Lwxw==
X-IronPort-AV: E=Sophos;i="6.13,293,1732550400"; 
   d="scan'208";a="39946252"
Received: from mail-northcentralusazlp17012052.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.93.20.52])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2025 01:16:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDDLSGN4XQi3LTKNjOMyilg20c6GD6bWq4nK3zGflFKaUhnvDCIeGet2rx4n+dnXtYtkf73knc2mpvxtnJy3k789YslTz2QjxkAEupwsJwyMgzzStHYKjXP2x0qr/MN1bjlAkA+QgpyaOPaErdyRn4ZymCAJqp3MzC6Qg+LCgHsKyTHSsSoxYPH5OFzG+FchloYx+ZbfLjYKRz+wbBZmL6S4RmwpuYq2qjYuV4vMnF7Dez+PQlotYUUNnNJV/SmcyY/KRXz2yAZ5PUzApqHboosrURURDNosJghDO7d43QpPdQyRmNnhX0rCZBOcY3iK3gT4U2gok+lyhak9TgtkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMfw8jc1Sl1JTUA9JfnoCmyfSPAO4g9yySsRZ+Y9RdQ=;
 b=eKpgo0AttcwYvjW7i7llFclB938orzZP6EIMU/oHb9Jy2iSobCQWHIXrkmF/WZu/XUHaCzSMZDT/0T+oIKFPjIK/STdK/6T4xBzC72FlUqhp/Ng6F20EnAvAHfVnH2jEo6+wj7MzMZYPajHSS24WIShMT+AeLEzsJ/i1leieScCtFqUVXiyPRK2rWUU3SQrbU0uQmhodMjrHNF+jQX3jPSu0sZsaIpT9YyyL4jgPDYj/FCvwB71pf97XQz93eHTyrvjE62887AnUOoC5xH5kxQy3vb0haQwuSA3FAWyQ7KXrs6xErfHIxzcFQ/vXgPi0JWAZoDrpngKXz40Li+rJfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMfw8jc1Sl1JTUA9JfnoCmyfSPAO4g9yySsRZ+Y9RdQ=;
 b=fuVU//Y7oAh69Adimqk7634u74ZRl+ovQjx40EI7Uv9TkCIVSKD6O0HNqKWKukELY53o/MpcKRZbzUXbnN/wQQ8KWISgvINheOLKkfBxGOC2frLBoyBvExsJyfQh7XdWoHMnx/enNn9txmJoJ5//BE2cz/ladDWugp/0c0Ef4fM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6435.namprd04.prod.outlook.com (2603:10b6:408:79::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 17:16:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 17:16:19 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 07/12] btrfs-progs: zoned: factor out SINGLE zone info
 loading
Thread-Topic: [PATCH 07/12] btrfs-progs: zoned: factor out SINGLE zone info
 loading
Thread-Index: AQHbgOUaldOrIlU8nEWOAZAF+WdF57NLvI+AgAAA9wA=
Date: Mon, 17 Feb 2025 17:16:19 +0000
Message-ID: <fc0340b1-9600-4bf4-b82f-e7d699206798@wdc.com>
References: <cover.1739756953.git.naohiro.aota@wdc.com>
 <11de06f6243f4f048d19f105a170cbd6f8e5f4c3.1739756953.git.naohiro.aota@wdc.com>
 <47145e0a-29f0-4bf7-ace6-97f226f73c15@wdc.com>
In-Reply-To: <47145e0a-29f0-4bf7-ace6-97f226f73c15@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB6435:EE_
x-ms-office365-filtering-correlation-id: 57842ce0-aead-4b1e-505a-08dd4f76cb36
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a3V1dklHL1lqdzZob0hXaTM1T3FiNDEzdWJxWnVOQlY5RkR2OVFnaUpzd0VY?=
 =?utf-8?B?Ny9kb3N4L1NDNk1vWEJsYk00R2lIVjRJbnVMOUtqZ3pWZGx3MkkybUNxVEdv?=
 =?utf-8?B?dmZ3OUtUdFN1b1RtSjl6Q1BtYzZQc3F6S0U0R3ZzK29ZV3d3QWlLUGZoblgz?=
 =?utf-8?B?eWlHbE1hc3Y2Y1ZEVklFUWFPcWNNd2FHZ3h1WmRqck1ESEdCQjFmd1l5amFL?=
 =?utf-8?B?dnljQmVxRlgyTzBIdW1zWVdqakdSOFRFejRYbjRsaDVyZ1ZtYVFweElyTUtM?=
 =?utf-8?B?aExwNHR6a2p3dHF5RWxaYnpLdG5VRkEwdU1BWXpyY08rT0laK2tSOWRLL0Uy?=
 =?utf-8?B?dnU4VU9LcEJFejBOWW9tcS81S1k2UXRWa1l4ZkVuVUREem5OaFBHU0pvdHR5?=
 =?utf-8?B?d09zNDNYOGlDM0l4RlMySTlOTkRSS09ZK1Fuemc4VkJDSnRMWUhpeEU0QXdU?=
 =?utf-8?B?TDlpaWYxVVlTa1VMQlhidXIrUmlUWDBHQTB5bk9ER2lucmYyREpUVUtFc0Ns?=
 =?utf-8?B?LzIyb2M0NXcxRjY3T3VnQ3JPK2k1TVR5SG93VFhGT2ZHMmp0S0hUdTE2RmlE?=
 =?utf-8?B?QzVkRlV2WXVQN3JnRC9Ib3VEVm9NMXgydU1KcEhYb256QVNHMUR5YW5hNGtH?=
 =?utf-8?B?dVhyVWdwWjdpKzRldHptUUF5RWtHODBvdDZVTU9laWoyRjlsVjM0NDZVRHdt?=
 =?utf-8?B?Rm5qb0ZhSGdSWHFXL1U0Q29QMUVVMDBhbUlGWFA2NlBqZCtJR0tuUEE5SkU2?=
 =?utf-8?B?emVkYXZaMzROZlA1MTRrZUlSc1NjQ050RDl1M3h0STRNSHFNUDZ3V2FKQ2dC?=
 =?utf-8?B?R284VGpFYzNDa3dNVHprVU03T3Zud1FCcU5RQWEyTS9JYjNNcE9lNkV6TFJF?=
 =?utf-8?B?alphSk5ldCs4ME1NTGp3bTVLa3JyNFo1MDd1Y1Q2VnJZRFROcC8xSkhuTTA2?=
 =?utf-8?B?K01HY1hkbVYrRUxFM3l3THZ2aVFBWkZWV1kwcDQwcWorOEJhN2o5ZFMzQlhH?=
 =?utf-8?B?OHhuVXlmOHR0anh1TDkyVWsxdFlleUxrUWxXSWY2SmViVVpnaVpsQ3hxMDBG?=
 =?utf-8?B?QjJNT2trcWNUMkhFY0FlYXFzc1ZZOUx3VzBkMi81TGw5OER6ZlZEd1REV2t6?=
 =?utf-8?B?SXc4VVlWVDJHclEwTllER2dWWnZLb3h0Q3hZSDJZckZaWExlUTMwS0owQ0xN?=
 =?utf-8?B?WkgrMGZCdEVySXVvZlB3bUxnUVRIK05zWnpqSDJ4Q1NPcEFLbUo4K3ZBY0d6?=
 =?utf-8?B?dFYvbUg0ZXR4UERwR1RQUlJ3azNkVUQxRDRVS1RPZlZEK2xUTWtqa3ZBc2Uz?=
 =?utf-8?B?SXVnMWNNMk44RGJYYlpTVXMyejV6dzNnbHhJRWd2VzM5T3gvU292bkF0L3Aw?=
 =?utf-8?B?dWEwMDFHK3g4NlFrNTRPWEZXb0FIU29mZkFraWZaTjRnRjNsSVZqMGQ2TlIr?=
 =?utf-8?B?UGo0bmUwMXBENlJ2MHhSNU5YcnJ4ZkxpdFAwREMxUHpySUppZXJmUzNxYmFq?=
 =?utf-8?B?S2IvUFFBbkliR056bHdBdTBldnNFdjA2bGIyMHloRy8rL09vVUdSTmZaZi9r?=
 =?utf-8?B?WDhCRWdyajBLd21kQnJ4Q3gxU0U0TmRLK1VKb2ljNmh2b1hZUFpMcnJTeFNj?=
 =?utf-8?B?d1JDVHd1MDdza3hoUlhJL1g3bUJwUnF1VHAxUmRMSS9USVlkY3orTWl5TUN6?=
 =?utf-8?B?V0laWHI1V3V2UlIrcWo1S2hzM0VROUkvWlhyd2JKVjU1U3BISzdIZ3lBbDI1?=
 =?utf-8?B?MGR3RjVnUEl5YU41eFpsRnZTWUVUVnR6OXdTcFgvc2pldHUwYVAvNlNVMGdQ?=
 =?utf-8?B?QUkyWklOWjdaWEZ6SGNxTGRoWC9CSHp5Wnh4VlowRGFkRzM1Q1ZkYmtEaDBv?=
 =?utf-8?B?NExnMDdnVCtMdmZoeDVRbVZna1RPWXhPc1RPM3BIRGpnN1JDUjdYN3FPVkkz?=
 =?utf-8?Q?Rj2BUnSSDeceA9Qln7jTcntudIpHe38R?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2xPcE5CcXBLRk1FNVhvY3lvV1I1YUdOclRiNkNJWURCQTZVa25OUjNTZnJv?=
 =?utf-8?B?enJHbTBGcWhweGh1Mis3aHZFc2R6YWlxeEI2ZnoyY1hhUWdRZ2pSZy9qMCtV?=
 =?utf-8?B?ODdWMFBDVVJoTTJTMmp4L1d4Y0drTVlLTzVJUFprb2NtTHd2akd2U1FCYXJD?=
 =?utf-8?B?Tjk5QXJlRndqdUdyWUtrdVdSVXNTVk51dzZoRHhvSXFoWEkyamYvbjIxcGI4?=
 =?utf-8?B?ejVzTEFKME94cXBkeWZiN012aFdWUUdJR05PMFMxRjVSdlVWYk5IRk9HVzY3?=
 =?utf-8?B?elhXWG9jQ1NHQjFRZ3I4dE1yNmxqWmZwbGJQdy9aaC9XL0lNenlnZlowdnFW?=
 =?utf-8?B?d28vdXRyM3pnZVBBQ2liaVNocEtJQlFoU2pOc0xSaFRwWnBvMk91R3Q4OUVF?=
 =?utf-8?B?cUxVNUZMdUdRTEhWRkpDVmliSThpbVVaV3dOVmJFV0ExeFBGUXl2WXRTL0xH?=
 =?utf-8?B?OHhzaGNROFhEWHEvcTRLdTA1R0tOVjZwV0tITWVkKzJuUW8rc3FnWUt1ZVJV?=
 =?utf-8?B?d2JwZHg3MXJPODdGVkVWT3ZHVEdLdjVSVzRCaFQ1Wml1M1k4Z2RyQ3RPZGZS?=
 =?utf-8?B?V2RPcGJJSE1RcHl2eWNHb1FIa05oakJlME9DR1FSVDNXazlZVmJoS0czdmhG?=
 =?utf-8?B?THNyTVhJV0dqNlAvODIxbVpYeTNSSmc4TUFwV21HRFZNMlhrSnBLaHhoeDYy?=
 =?utf-8?B?OVVObk1zdS9nVzM4M2NWNFNWYVlWZDcwa3U1QVlBUFJmWXo0UVlmYy90VFpW?=
 =?utf-8?B?Zkc2QVkxWWkydytvTW5GdzZPeXlhdm91dmRORzFxeVZ6VUtPOE9FRjJ2V0VZ?=
 =?utf-8?B?UHNnR3BTZFZVNUNMakJ2YTlYamFhSk9wYU8xOElqUlFtZFBRTk1MSTFyMGNy?=
 =?utf-8?B?Zlh2RmVMeXp3TnJiVllOSzFqL3ZzZ1dqWk02bFJhTmZKQ0IzVzJPeU9KVGZn?=
 =?utf-8?B?QUowckN0N3VXZUJRRE1mK2k1Y3lrME93V2pnMlBKemJpeXJ4ZGI5R2FvODJw?=
 =?utf-8?B?WDhVbXRITWl5TXhiSS96bUY3cC9ibVJqN3NHUDY0TStLVEZiL2d5blZMNDJr?=
 =?utf-8?B?OFBMY3NlUjlDZ05waGo4UWNnQ1dJN1pkTklXQTZIdjlhd2IyYnpZcml4UXNM?=
 =?utf-8?B?RFlrL3dHczBQODJYYnJXR1lySVhLM1l6VVZ5NHkzdG9FZmRpZWREeEZGKzls?=
 =?utf-8?B?VUJkMThETjZLTGJHMUk0ZnpiNTJXRjE2S3N1b0ZML1ZEaExRWk90SFJ0eS9O?=
 =?utf-8?B?aG1vd2JnS0NhOE43WjFEby9iT0JsNzRFTDJ6NnQ1OWNYZDViZTNsVzJsT01z?=
 =?utf-8?B?T0lWZUpxM3RXZnV0WG92NFMzM1VqSlZzM2szSXFzOHVlaDRmWm15akJKR2Q4?=
 =?utf-8?B?Tm1FQU5pcDFIU0NEdnl6SWRlWWd3UFlXNEtVeE53Z3R5eVZyU3JNRE5uWmYw?=
 =?utf-8?B?b2orSU1Xak9CS3g4eXlxMEdINnBIeVNiNmF4TnVwOFErNEw0WVhrcFhRODBL?=
 =?utf-8?B?eFZ4Wk9BYmUxSjJlci9KampVaUR5ZzFKbWR4Z002Z2JJTmFnK28yY216TTFv?=
 =?utf-8?B?WjZybndzeDBLekRySklwczBubXQxUFdCMWNIUHdzck5uZ3pMd1FSajJlNUhI?=
 =?utf-8?B?R0pQUWRNbUI5dFBXbTdzYjUyRllRcEJzUS9EVHppclZXVXVCSEJ1ZDVpdWVt?=
 =?utf-8?B?dmZTSWdaYnA2TjJyQVlXNTNzRzJ1eXQzSjZxVzVLT0s0dHN1b0lLNXhsaTI3?=
 =?utf-8?B?bVpaYjlNOXlvQ1l3SDJkU1hzMFVNbkVIaXFsQnU1YzdNWTdScGk4anBWS2w2?=
 =?utf-8?B?VWlTSmJ5eUZEdW1XZ28zb3FNMEQyeW9rSzZ1U1FScEo4ZHB1MGZEYnhJSERu?=
 =?utf-8?B?YmJRMHpGSE9hZnJzakdvYVhFdzM0NlhyZXZvMnhzZUtldElwakI0L3U1dmUw?=
 =?utf-8?B?N3NXZkxrSmRScnIxbC9Nek9SS2tqNW05MGs2dWVYTFc3QUo2YXIvNHFhWFhs?=
 =?utf-8?B?ZEhQMGI1QnBXWi9Uc0ZYLzdGRlZWNVhsREFyZm8xdkxFb0F3WnBoTlU2Wm1W?=
 =?utf-8?B?clhlVlIycVV2bDlZOU4xUG0vRGRkTjVkSEF2elRCa2FSaWZkY3YxREV1QlpJ?=
 =?utf-8?B?dGlvQUEvK1RSNDdrMkdtR25nUGJqOGc5d1Vhb2NXa2Q5QWR2ZnQyVEVCcFFQ?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D999065B193FC489D5F9E69C5E9BAF9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y2Ov2uMv0GritKsPK2M/Lpq10iLwAHpue2+f6xotb6iKFLzwCobfTn80XldRgG7rUOKumoaPiUqdT23rBkB7jhKdiw2sEPvPc5cIo5GF8P2gqweXEupfbFtEnp7Ai6+YgsYhH/jpzu1hq7Fr6VWE3lIpdCvsYvp5bZCxJmTjOeNTTH9MWlZmwN4C139hHVH1qqvpQWZ3RMZ3+veXa7nFKelZoRkEDpBWb80b2vJgCwSiGPYaR7yNrg7Jixx4qzgbuFnSVxz/Gdw4I3uyWpDMkQ3fm0NWFIuOdsqPkLrsdfrukSo2KPmB0geuCnS3acdmpfEANI1RHNNYM1i+J6X4y+4Wqsh6C9VqNtDjgit8RT2DlbLyWMgmGYImY8fUoGiB0otzvUvP6uLKA7v2PPwYS1MI5LxR47rdu1hMhz0P732x1zR5dVt/INZM+vlIHncYwTCndEWxQst2STHkQ/u7YDamDMsq8lB14B+/M27A30RgLu+Jo+yCgDZFiNTn/z4bwhR4Q5hjsyar3KZmzYSm070AHDPcfWM7U98wyyypiKvH3idcV8wRKIFbBtK9ggzB2VC0fzDllu5pTA4hkDQ1iT6I3UAwlqFazR36Ms5IXCDB6nUzw6Tsyh5oadLyNfs6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57842ce0-aead-4b1e-505a-08dd4f76cb36
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 17:16:19.0454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lQCHV32dpCBgi4q8Zy9grYs82JK1vChJ7dp7GGasSk9ssZlBPZPJZDk+Q0yvMFOatjX6lEyMqOSKIR3jSvDXhkgbYoFeHszA65xj87D7Ruw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6435

T24gMTcuMDIuMjUgMTg6MTMsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gT24gMTcuMDIu
MjUgMDM6MzksIE5hb2hpcm8gQW90YSB3cm90ZToNCj4+IC0JLyogU0lOR0xFIHByb2ZpbGUgY2Fz
ZS4gKi8NCj4+IC0JY2FjaGUtPmFsbG9jX29mZnNldCA9IHpvbmVfaW5mb1swXS5hbGxvY19vZmZz
ZXQ7DQo+PiAtCWNhY2hlLT56b25lX2NhcGFjaXR5ID0gem9uZV9pbmZvWzBdLmNhcGFjaXR5Ow0K
Pj4gLQljYWNoZS0+em9uZV9pc19hY3RpdmUgPSB0ZXN0X2JpdCgwLCBhY3RpdmUpOw0KPj4gKw0K
Pj4gKwlwcm9maWxlID0gbWFwLT50eXBlICYgQlRSRlNfQkxPQ0tfR1JPVVBfUFJPRklMRV9NQVNL
Ow0KPj4gKwlzd2l0Y2ggKHByb2ZpbGUpIHsNCj4+ICsJY2FzZSAwOiAvKiBzaW5nbGUgKi8NCj4+
ICsJCXJldCA9IGJ0cmZzX2xvYWRfYmxvY2tfZ3JvdXBfc2luZ2xlKGZzX2luZm8sIGNhY2hlLCAm
em9uZV9pbmZvWzBdLCBhY3RpdmUpOw0KPj4gKwkJYnJlYWs7DQo+PiArCWNhc2UgQlRSRlNfQkxP
Q0tfR1JPVVBfUkFJRDU6DQo+PiArCWNhc2UgQlRSRlNfQkxPQ0tfR1JPVVBfUkFJRDY6DQo+PiAr
CWRlZmF1bHQ6DQo+PiArCQllcnJvcigiem9uZWQ6IHByb2ZpbGUgJXMgbm90IHlldCBzdXBwb3J0
ZWQiLA0KPj4gKwkJICAgICAgYnRyZnNfYmdfdHlwZV90b19yYWlkX25hbWUobWFwLT50eXBlKSk7
DQo+PiArCQlyZXQgPSAtRUlOVkFMOw0KPj4gKwkJZ290byBvdXQ7DQo+PiArCX0NCj4gDQo+IFRo
ZSBhYm92ZSBpcyBtaXNzaW5nIFJBSUQwLzEvMTAuIFdoaWNoIG9uIGEgbm9uLWV4cGVyaW1lbnRh
bCBidWlsZA0KPiBzaG91bGQgYWxzbyBlcnJvciBvdXQuIEkgc2VlIHBhdGNoIDkgaXMgYWRkaW5n
IFJBSUQxIGJ1dCBJIHRoaW5rIHRoaXMNCj4gcGF0Y2ggbmVlZHMgdG8gYWRkIHRoZSBjYXNlcyBh
cyB3ZWxsIGFuZCBlcnJvciBvdXQgKGZvciBub3cpLg0KPiANCg0KQW5kIERVUCBvYnZpb3VzbHkg
YXMgd2VsbCBzb3JyeS4NCg==

