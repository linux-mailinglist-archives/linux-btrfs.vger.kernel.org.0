Return-Path: <linux-btrfs+bounces-6122-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB4D91EE74
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 07:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8162838F1
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 05:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D115477A;
	Tue,  2 Jul 2024 05:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mLL5iRS1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AC/0tVkZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E702B9D8;
	Tue,  2 Jul 2024 05:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719898885; cv=fail; b=nRfYGldJKnjl0r9AMh4Qm5TLfQKxQXl6ocC0Ah460VckgwJoRk+zvbS//+9GUbFxRciALUKOVdvs89h/TtAPTpz8m8v67MU6X7Oc1KJlj10TX9yM0h8HYWI9q7ezyOPb6GZkY/BJp1FVAQLlPiPsezRNUaGeM35umolFHCgI9AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719898885; c=relaxed/simple;
	bh=TPADmyGfhHgn3rCrbERf70/Ulj2xDv0HjYwtueRQtrE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dHWIy5fxwXAEwQqukXkft2HJL4A9PLjbW3kgGKPx+2UIW0B1GOUNskjx/5A3a/fte0Q4h075UMfMm43NAuQqFmjvTQxGpV01XZv/ggoeDO5Zw0iYarz8F50AVLtFl/RPSNbuXstZvjTR+pkotcTetxdzzz7OkJ4iSekzxldCyks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mLL5iRS1; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=AC/0tVkZ; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719898884; x=1751434884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TPADmyGfhHgn3rCrbERf70/Ulj2xDv0HjYwtueRQtrE=;
  b=mLL5iRS1fhJuCjMiqIE1eAASdMt6NItGQ5IMP8Y7ShHIoG+SSWp30NYr
   R2o4TC9LVObeq1mVMGfyvrgY7LonBBROksZoniReQfL+bJWTTGFmsNyZ5
   9XQMIpI9c3RR5dqgXbzFuwZPztEwwMYQUE+/Gq0pwbAGSMma3XOKs9423
   KN2vbe4stY46loouIQLOfFPahw/8JkAOiDeWteZbgTJ1M6xwOMrRlTnDj
   pANyRfFg9a5wsCH5gYmIAli4IxIwvULvaUVkHlPewNTz8TEZSroZQcplC
   Xkj5DUyFm9jXJl6pBCyU2Abs/coHke9xQQkgjElCVHA7Jn1S8ljsN5uHI
   Q==;
X-CSE-ConnectionGUID: DAaEbu27Qdihzt47HubCFA==
X-CSE-MsgGUID: msPxGH4oSNujnIm9Mz8Bmg==
X-IronPort-AV: E=Sophos;i="6.09,178,1716220800"; 
   d="scan'208";a="20326640"
Received: from mail-bn7nam10lp2049.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.49])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2024 13:41:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxC3Sker5BdwTIoDXOsVQEeUslxtxMq+N7CC9YFDJ+qq9qH2aSsHpDcXTNyqpvMp5h6+pt9niL+2KGCbukO38gDrmwCEyobKOKVPDUyxNVujLqbohQl8yz0xkaxY6d7CJtaiJ9BJy3qfNrcLrMaly1/RjlcoZeGvgK6S+ZsxJ2N9XIDgdpsMmzgkFg7Nhwzpde85awPWWF3yOECHjU+Jm4YheR5h7txlLPR7ZEgfMxS7JhSXckRDOP1mqGWK1KNO7GnjqyeboX6UQtT1P6DT65JLiwLrQb+74ZB+Qkvgd994IPXrv9LF0IIGJ2jLF/jLiwIuRyqzxw8/t1DqXaBDqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPADmyGfhHgn3rCrbERf70/Ulj2xDv0HjYwtueRQtrE=;
 b=MTbqQ3DaZh4GCkzU+M0/Qr9eE6MazUrVrcx9DtMD7sLeogfbzUnXE3ZNhEaQS++PsoQ4uXuT9SER+aaQ/mmFUPoFVsg1pCftApxl6IBAspQ8MQZ6ZCPfUK7yTo13ii8rKiu6T5fiRHWD5eo/Dhycnmk3o34ldFWPWGfKxNu0YhF6Z9oTIHgSQbeJvTPX3AwMdQo7gi1li3AZnQoJvCqa85nlt53FadC8NlKqla2ZYtQ8CAjaobDp2fD6v8Gg3xHkLwNyQwN/v8RoiLuUu5Kjg26AvZp5UTF/4uG8glv6rdPCwLAtowoJRud+vAXrCfrjDE7bgK6/Z3CK11Me4YU6rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPADmyGfhHgn3rCrbERf70/Ulj2xDv0HjYwtueRQtrE=;
 b=AC/0tVkZ/4sOFqEYFQBMRWPJ/+F5D5iN9hnRKP66/t9qQV8WrCPKYe4xMr7IxkqBPfBirnn4HGmgJZx8KN6Y+md6C72lifHpdfDllbHbakNNWzj8HLlZnzgbwnBWVo4Kfroxpy+ybwCxP0ksT+YqQ0+LKHod7YMpepYVrJtk6YE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB8229.namprd04.prod.outlook.com (2603:10b6:a03:3e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Tue, 2 Jul
 2024 05:41:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 05:41:19 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>, Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] btrfs: replace stripe extents
Thread-Topic: [PATCH v3 1/5] btrfs: replace stripe extents
Thread-Index: AQHay6EAp8S4JW/Ct0a3xUYtoSH4nrHiVbwAgACX74A=
Date: Tue, 2 Jul 2024 05:41:19 +0000
Message-ID: <88e73b63-27b8-480e-9df5-847acb9c093a@wdc.com>
References: <20240701-b4-rst-updates-v3-0-e0437e1e04a6@kernel.org>
 <20240701-b4-rst-updates-v3-1-e0437e1e04a6@kernel.org>
 <20240701203732.GC510298@perftesting>
In-Reply-To: <20240701203732.GC510298@perftesting>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB8229:EE_
x-ms-office365-filtering-correlation-id: 5930fe43-da22-4bb4-b402-08dc9a599958
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y1ZPUUtZeFFtOTdnd3prU3FlQnNEc0RPbGk4VmRkYWgwSXIzQ2lCdk5vbmpL?=
 =?utf-8?B?Q0gyYlFta0R6YWRwbnB4aUpIQmVSdVhLSlliVnBuZWI2eXpjN2FLNjl5WUdm?=
 =?utf-8?B?Wkc1eEtkNGFYOTU0R3JkUVZ3TFduc2RnUkV6MmxoNlhHdk1XLzRCTW4zS0d1?=
 =?utf-8?B?TkIvTVpJQjFDOU5MdkgzZG1DSnl2WktTNlEvcHVQNDBaMjFaeHgxaEtUMWpH?=
 =?utf-8?B?d0RleUxLaDBpVi91ekE0RTRyQ1o3V3dMMGdsaDIzRzduUlBwVm5PNkxTWWhh?=
 =?utf-8?B?Rm1QMEFyRVdwK1ZjaU9udXJxYnB0ZFRFay8vNEtUWVpSQmdDVml2bS9YTGlF?=
 =?utf-8?B?bkJLSHFVRmdKc3h1d3NoSkZ2dGFxdHFXSFRBUFVUaklPOUtWTjV6M2NIZmpp?=
 =?utf-8?B?SUVFd3BRcmZHRmJKZVhFZWt3K0ZpaC84NkZRZ2Y4ckpMU2NsM2g5VmVacnpw?=
 =?utf-8?B?Nk1PY1VXdHJPL3JtTERMUXo3YVJGajZacUJSV1hXRFNkTkg2cjErREhDMmtO?=
 =?utf-8?B?R1hEaGFGZDZrRk9FRklOQk5PWHh0VVpZb2d1b09yQ1AvWDhDOTFOL2lFYmVF?=
 =?utf-8?B?NDdlNzdwSDZLbGE1SnZDR0JYVEZtRGFJN2NOLytXeVB5QlVtWHRIMWJwcGto?=
 =?utf-8?B?bGU1OGpFbkZQUUlUQWdUbXZ6V2NKUmE3clhZYmpGQzlqdllneC9NQ2xRZXdO?=
 =?utf-8?B?QUxteHd0ZG5FN0E4S2d4OGlFRlgxVXFZTmJza20yamV0ZU1kK25pOVFaUnZO?=
 =?utf-8?B?cGNRWlB2WkIzMVp6eXdYc1lrdmEzN0plVEhCbVljRjhtcnRlVHIzU25iNlUw?=
 =?utf-8?B?ekVGU1J0cVZ4bnNjN1RpZXhiUzUrTDYrbEJEbEtyQmd0Z3J1dXJ6RnNlUi9q?=
 =?utf-8?B?dU1HaXhORUFRNnpZN2lweXByL0U2UnVKSzhIa0t5cWhKemJkMEY0TmRZZGFE?=
 =?utf-8?B?THZrcFhkeHA4N3RudWFXbng0amtZRW4xZ2lYekc0bjhrdW45VzdBR09PNEs3?=
 =?utf-8?B?RjczeW4yQVl6aC85MEwzUnBjTFdkVUxnYWx6SCtrUTc2R1pUSDVFR1UwQUlH?=
 =?utf-8?B?NHlhM3pPeDI2QVpQMWlMWkN4OVhFUGEwbk84WEl2ZUJwbmdBN1FKK0lBNHdq?=
 =?utf-8?B?SFJPRGUvdFB5ZEwyZThTZU9UTTJlVTJjVTJyTVNSblAyQmcza0VxK29jQ3Qv?=
 =?utf-8?B?T2xGZmlZRGlEV0IrMy9hVjdTdUhZdmoyanlVVGQxOTY4ZzlCV1pKYVg3NVdD?=
 =?utf-8?B?NlZsU3NCU1puQ2FZRG9WUDNtWXl6UHE0cTdkMGlRREdmeDFCVkpiK2FUdDg3?=
 =?utf-8?B?eWlSdnlZYUExRXNtbjA5MHRWTUJOdnB6NFA0YlB4cWNPRHNCUTlQL0h2anJw?=
 =?utf-8?B?ZXF1TTRnVjhlcFZKa0F5TUVvZG5VdkErQlI0M2lGSlF1bFB6YVg2b3ROZVJp?=
 =?utf-8?B?UDRtQUwvUFhLQi9wVFJHQ0Uxb2JvSWd6c1VyWnpwa3pyakJXbE5oc1pPdkRG?=
 =?utf-8?B?Wm9waFJLNExHVWhmR09JbmtISVF2aWFuQm9YSGwzN1FEVHl2NEFFbytkclFh?=
 =?utf-8?B?NGtHWHdoVjV2VzFweU5VOWo0WmZxQ3dBOXdORlFCNzIrbzI3T094dTNPMVRi?=
 =?utf-8?B?SjNPWVkxc2QwYStOMDdBZXpUcEdMR2pZcGlMMjNUT2w2THo1Mk0zLzEyUXBL?=
 =?utf-8?B?V3FsL09NZktEMXZaSUFLYmpkYmh1dktnUWdzbmpPaHh3djlGdWxYbHRxSlpn?=
 =?utf-8?B?a0xHR05QTUlEa0M5dFlkWDVTb05Qc1RxanNoUXpkWlgxRG9hRFVwVjhxS3ly?=
 =?utf-8?B?YVhwN1BmUDlONExGUnEzejRLYm9kV3VLSlhaRU1mVnZVZXp0a25hRGxSd1pP?=
 =?utf-8?B?NUNkNE9LeGhheGxTd1FOTFVCdStpVUk3dWNiTy9IMHc2aEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T0lHMVovWlhHNkE5czNlTkFjYk9iakZ3UVFVdEVtYWJZM256VFFDVGtJQkNv?=
 =?utf-8?B?TjBxRlN5YVp4NjhlQTNXb3J0TmZid3Y2SHdsVTd3c2dzc2tpb1BvMWZOeng2?=
 =?utf-8?B?UFg4Z2NFMUd0b3p0VjRoQy91dlkrMy8xd1NYbFNONUhFSlhhTXpxdGJRUmFB?=
 =?utf-8?B?L2F2YVdGalJoQlNJTUdkR0tmVHcweklEdVlVUUhhd0tBbEtGUERLc21sZi85?=
 =?utf-8?B?ZTVYdVBJeHNkOHlDY0NhY04vY1BPdDJLRGt2UE8vaXVXODg3Y2tLSy9DZkYr?=
 =?utf-8?B?a0JXMXdqN1RNemk4S0VxMVV3RWlBdzZNWjk4SFdMeFRTVmR4MElnQ2N1elRW?=
 =?utf-8?B?TU5rOTgvVnAwbmk4RzAxYTI1TWlUSlRwSGhYaU5yMUZGMjhCRENONXFxUC8x?=
 =?utf-8?B?VzRkVDVHM1VWM3FIT0RtUzdXZXZyRzV5Zk5rTjdTY2hCS1BqZi8vejBPZk9a?=
 =?utf-8?B?YWFTd09HMW14S2QyT2xocDBlNmhqUjQ0d2M1b05OTCtiWnlEUXN5MGtxd1Z2?=
 =?utf-8?B?cFAycXdMaGRpcVZJNEFGbUc1Q2tkYTBGV095eUxUZGU3MVdHdkpGaEE0bXh6?=
 =?utf-8?B?VE1ldG4vWnkwVlhNQW5qUzBneHR4RG9xV3FvVTlYMGRvTy91aElHc3BISFdz?=
 =?utf-8?B?RG1SQjRMYU01VVpuUGs2OEdGRjROUVhqQisyUUhXdXBNSDVrMWFCaHdvbVVm?=
 =?utf-8?B?MXFXaE1JanVCYjV1ME9ZZnBWMFo0OE16MFRaWWl2Q0Z6SXJlUmNZMUJiczJT?=
 =?utf-8?B?K0xKZjBKT3pRZUVSVWN3VWwrSjB4N2RkNGlnMUJBaDdraUdNZ1liZWttbUpC?=
 =?utf-8?B?VTA0Z2JGVFJYQmxRL0ZOUjNPNVZOYjd4ZEpaYmlWRW5xU1Z6aHMvcmZnak5p?=
 =?utf-8?B?MmNidHdtbDdqeXpYbXdiS0F1QVQ1UmEvVXdGUlJmV05DbE9kL2NlM3hQUFlW?=
 =?utf-8?B?TE5FQXJvVzR5OWlvRGRpYjNkSVVMSXNFN2duMzVlVDJSYUpENWw2eWsxV25U?=
 =?utf-8?B?eU5PNzBUUFFaVXF4Q0dtdUIwTVU5OXhIR1JtZ2xrRkgveDluNmlsWjFnSFc1?=
 =?utf-8?B?N1pDd2FlZ2R2bWdoV3k1eVpGck9OdytqdG1Tb1hkblJrT1ZhRHNnNGtjczJz?=
 =?utf-8?B?Mld1VjBFb2x0czZQSWduYmxocGpWdUNoVzREdDRqOWZwclBUUGx1NU14Qmh3?=
 =?utf-8?B?UUtYYU8xV0JmeGJQT2lIOG9oOU1xMU5lcXJVUjNCdjRFaEJkbHFTck52MytZ?=
 =?utf-8?B?NDFwdm1pVjR0eUJhUk9QQWdLUEQzUGxhdTVtSDl3MlNjaU40enR6YmNtVGpa?=
 =?utf-8?B?NHRQNkJtUmdYMjB3SFJVYlRqdms0S3BmUXJRaXFpeW5EdGtrUnRvNkJoNW1N?=
 =?utf-8?B?Nm5TS0d1TVFFTnVmaW1zVEpjeTQwUkJ6R1dkY2FSWTF2TXpxZjdpaWh5UGtQ?=
 =?utf-8?B?VTFFSGhrd1JLRE0vdGlrblZUQkFMNFZVM3E1MGJ1N1lEdzJqSktyU1JuT1hx?=
 =?utf-8?B?SDc2TmNZRDhzZzJQRGNWcTkrcEEzZ3dla1RYMUF4RXJFR0ZaT2RML2E2Yk53?=
 =?utf-8?B?S1lGQlBnTitCNzR1QkE5QjVtUlFLdzFWWWxwV1pXa2dBTGNjZUJ4bUMxYm5k?=
 =?utf-8?B?bHZWb21jaENzMHV3M2xHYWltT0pwbzVoY214M24yeHhzVk5BeVU0QXJ0NzJH?=
 =?utf-8?B?cWZ3RVpsVFNwOVZlbTdJWCtWNTRWR3RyVnV2UmJNN3JaYWFsWVpWampTaHZH?=
 =?utf-8?B?L0Nya0pGVXQzdmxFYXZ2Y3JqRzB3VEtMMTJWQ015ODRTckpqbWg1Wm5sanJo?=
 =?utf-8?B?Q2RHazZqM0l1ZVlpc3gzbkZjWTdlL1EwM3djSFZEY1RwNUZNK3ZhVHdZc2N2?=
 =?utf-8?B?Nlo0M0pKV0JQYWQ4eWlMQ1VjckljRzU5RFR6OGtjRmcxNm5PS0lIdW9xOGhI?=
 =?utf-8?B?YTdER01wenM2K29GdjlWK2h3ZGpsSjRsSDdPMUVRNGw3ZEp1UFI5SUw2aW5M?=
 =?utf-8?B?YVpWNnVCOFZvblowRW1ZVXV4QmFRZEdsK1h2bXprblB0Z01yaTNjU3F2WEtC?=
 =?utf-8?B?czY0ZTZlWjFvVkp5WEF1UnNTREhTazNlMWYxWU5WdEdtTUlyTHlLblA1TTMx?=
 =?utf-8?B?NnFuN2s5Q0JjMTU2cjFMaUFTS2RoNjU1US9CT1JmV1pwQ2lPS1BMWmpBT0VQ?=
 =?utf-8?B?U3JZTnNRdnNBWVhUOGVjajhMU2FzR1h2elhXZjdoZkFUU1QvRTZ1YVhEMmFB?=
 =?utf-8?B?LzR1L1FwTVBscWZyOHVITkhNUXJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <332A1400E652F248B039D7DEB98C4E31@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NJFozIn9q1B4Gkp3ArRWTL4cHbJG2uC7Wk2a9Lp2I7Uvmc+96E33675/Fivg7CZdHVGK9L+X7lP+BoGrmRlnQhBU4TOlY3VCO064s0mR4+yKeiwhWjaEe04cqeUuxG931sDjEgP1Z/F6Ii2WGC6n+EVX7UPgQJYzkcXObobGm8L4Mauy4JXgGTMDFqntxswqAmHvP/yiVRgtmvjBRUb6lqwE1cyR9v5oPSosP4hjHWGvuR4DF5T4wmQ0z+KiwTn0JGRfncANI83toj2J5Do/RY5a545fw883V0NPUAYbLMzjfbr99P+bGZHipBNUAvAVy0rVy1M93dzLLobnx3p2QiNsMUZYW2C9Pkj4JGG9G2JeSJQiZ1nks1hRykCwjxinEmNnRqPXmTkN/zzxujaQihRXquyAUIuUDeBvMD1yZjjR1ZVhz6OmY7RVLdPIUDX6iBHOEOkpOg96s4/1srosfd/815bfDif8dYHvZM+u8ZYWZjJYjLQwuC4O2O1i/cr+rfMYKMYXf5SFsX0LSnA7sZLXDjfEH42zhD6o2K4ZRyMdRlXn0WtpQgwSIleOnx6MWxSZiMk21ZbyA+UDCaNzN/b7zQ4thvTuy2uPSB5Kn07kGXbDn7tsX2noK2dHk+sg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5930fe43-da22-4bb4-b402-08dc9a599958
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:41:19.4752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t58sxxC5i+aRSlyGhafyQDXBznrLqRvOOpAzTjz0UxBsuvZ00HZOZjC6SPsuxsJNagcLY+8bnwmHWIc52kSIDUWlml4ONFKgItBtqyI7/Mk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8229

T24gMDEuMDcuMjQgMjI6MzcsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPj4gKwlpZiAocmV0ID09IC1F
RVhJU1QpDQo+PiArCQlyZXQgPSByZXBsYWNlX3JhaWRfZXh0ZW50X2l0ZW0odHJhbnMsICZzdHJp
cGVfa2V5LA0KPj4gKwkJCQkJICAgICAgIHN0cmlwZV9leHRlbnQsIGl0ZW1fc2l6ZSk7DQo+IA0K
PiBJIGhhZCBhbm90aGVyIHRob3VnaHQsIGhvdyBvZnRlbiBpcyB0aGlzIHBhcnRpY3VsYXIgdGhp
bmcgaGFwcGVuaW5nPyAgQmVjIGF1c2UNCj4gd2UncmUgZG9pbmcgMyBwYXRoIGFsbG9jYXRpb25z
IGhlcmUgaW4gdGhlIHdvcnN0IGNhc2UuICBJZiBpdCBoYXBwZW5zIG1vcmUgdGhhbg0KPiBzYXkg
MTAlIG9mIHRoZSB0aW1lIHRoZW4gd2UgbmVlZCB0byBhbGxvY2F0ZSBhIHBhdGggb25jZSBpbg0K
PiBidHJmc19pbnNlcnRfb25lX3JhaWRfZXh0ZW50KCksIGRvIHRoZSBpbnNlcnQsIGFuZCBpZiBp
dCBmYWlscyByZS11c2UgdGhhdCBwYXRoDQo+IHRvIGRvIHRoZSBkZWxldGUgYW5kIGluc2VydCB0
aGUgbmV3IG9uZS4gIFRoYW5rcywNCg0KVGhhdCBpbmRlZWQgaXMgYSBnb29kIHF1ZXN0aW9uLiBJ
J2xsIGFkZCBzb21lIHRyYWNlcG9pbnRzIHRvIHNlZSBob3cgDQpvZnRlbiB0aGlzIGlzIGdldHRp
bmcgY2FsbGVkLg0KDQo=

