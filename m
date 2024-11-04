Return-Path: <linux-btrfs+bounces-9319-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342C39BB16F
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 11:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D2C1F230C7
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 10:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351611B3725;
	Mon,  4 Nov 2024 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HzJSMHQd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oPdtRvjx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533E9290F;
	Mon,  4 Nov 2024 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717134; cv=fail; b=WuXCmXVY8JksKSOUiNgTQ3lqbe+5KSqVJ4XJXbwRXchB7wgSJimLzQd/jXWFrhp4USC6l738mixiuglBxkvvEzMdwZ1uVScR0GvlRZdJbusix28pgVZIDmgXXys8AJy+T7r9n2jLRIj2ykyTl0l7DtYePWGc+KmPyPw/I9goepU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717134; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oEJ2m+ATc+AT7DcrB+agvsQ5YaVAzN9PKhgFn4vQXaegCDnpUzrz2yGrutxRt4iz+NwSrmTjOUT3WFlrJBzEVOg1s5TV60lAyMER+xPQNz5NUlmqz9oZGO2rI6MccGNbCSH7kfnt0j/zzMKssSrq+uP6OO9Ns5csNKSeGIRCHmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HzJSMHQd; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=oPdtRvjx; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730717132; x=1762253132;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=HzJSMHQd/+8BhPGHtu7HpTkHSNRGx3XzJuCKLfvYQSJUAaX8NC/ELQKW
   sGHwQbLilexNA2Ig0M2+Os5RPO6M/0dMPXgQ/vWLOJom3BMESDDigl/ej
   ipT68mwG6ouhi2isb7q1uGkp/4Wa2s1U1yA4sxH6gNoF51qXu9U8b8rnH
   ESiOhINuitrJ8mAY5NAY9B4tDztm0IrPUk/n+4bJJRw52cQt0/JOxxt1x
   VyCj1MSRB0mGPg4FHlZtLAzSkUbHg7J/3svxv7SWzmPGQzvo8G67MtzFo
   9bORk9p0PI8mtaV6B7nUMwbdhaAiboLEaRv9jA9KYgWGy2w8CaZ+1ppU9
   w==;
X-CSE-ConnectionGUID: lYlCDAomRkedJXc11Fb2zQ==
X-CSE-MsgGUID: HwjhckQgSwKdK4IpIu11Tg==
X-IronPort-AV: E=Sophos;i="6.11,256,1725292800"; 
   d="scan'208";a="31081401"
Received: from mail-northcentralusazlp17010004.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.4])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2024 18:45:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yerCZ4dOWcUtp4cmGP3Cbc3NDr7FNfSB439rbqTqNWiTJXXn2FCZd0hFFp6dcocbCcIy6viDRDKU22Ygxnc+82CD8VwkffxeoiNrobuWWPUbs4mSIScaFnAlD9JGUL8f1Mhp98jhgbhgJOz3Hux97m4c/70gPWVJW2ZrYHJLdtOUqrWYbRdUKcww6eJ4W0926rCUKwnDCGGT83bj/p+CO/WLLNDsTMk0XmYh7/B15Gvri5/EL73snEDIqkWIrkvf7vcztxKYJO2l4G4GcCRY7Mh+yQCBoAFR5U35qaJ6JIfX1B7IrNiJ2JHLE7LpQiY2DPZTEVA5sVPdpz/sJ+YUig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Me83uQugX7IhyfxMl5nC4BTzzi2y2mkZkoGIZzDvSXaWAgvUXYT77XxpYZBv7RdQ6ZT1WJkP/nQqrbmL75di7aCqzpH4KZSfheqP5blz8y7B3aXGB6orLFHZYqspdc+Y5/FQ2wpLFclA6G8GlcGKKjWeYd7gnE52a+EuAhJPsWGNC/LOGCmRmkVZqbYBs2P9sJkvlnwd/q1Da4Px2/uNrBYUgvo5Aa6+HI2EvxuaKLBPw+3bOmvt/wyyObaURJcHqgXOnJGJBhqoulUIvfDbp2xo6ZMrVL4rOaUl2cMCh97+E4ENy7ny067KwyBsUZB9wWrQpFiuGOPv9tn6UwyDuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=oPdtRvjxmtD6rl6C/UbOzVeEl8uNQuRu8lBTKIhblrp2MNa7nefCV0YpaUwadBftPR3svwujsOwJo2prMJvyjOg7sfJAG0K9OGX0alrzfNB6QlM7vHlgbGzKsb2kzO3VQydeMQ+CPWRX5t0LE14b2+dDsezmx1y5EmESuPKI4ek=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7690.namprd04.prod.outlook.com (2603:10b6:806:141::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 10:45:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 10:45:28 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Damien
 Le Moal <Damien.LeMoal@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] btrfs: use bio_is_zone_append in the completion
 handler
Thread-Topic: [PATCH 3/4] btrfs: use bio_is_zone_append in the completion
 handler
Thread-Index: AQHbLB4W3DaOk1JD3kypEi8Ce678QLKm9RYA
Date: Mon, 4 Nov 2024 10:45:28 +0000
Message-ID: <2f12362c-869d-4b8a-8ac9-f58f4de87ff5@wdc.com>
References: <20241101052206.437530-1-hch@lst.de>
 <20241101052206.437530-4-hch@lst.de>
In-Reply-To: <20241101052206.437530-4-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7690:EE_
x-ms-office365-filtering-correlation-id: 8ee45689-489f-401c-4bae-08dcfcbdcc6d
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZDR3M2ZJZlh4SjYvU0RicTh6NVZ4dUp5NXRMZlJGWnVjbHpOSkM1Q3QwVmVL?=
 =?utf-8?B?QUhWZ2loeGpIZ0RQemtSRVNIL0FFbUg3NEQ1SGVCTnI3c3kyM3Ywck1GbFpP?=
 =?utf-8?B?dERQdm8razRnbDZKL0hLMjdEaWpQcXNWZVZINmMrL3RFRG1IdnNFOHJuK1RC?=
 =?utf-8?B?RXVRa0ErSUgyVU5EMVJYOUtvWUlsK3dOTmJ6WFI2dERnRFB1RldYZ0xGTC85?=
 =?utf-8?B?Q3FUV0VldVU4TFBxUFRiWnFuaEIwUE13Q2lPS3pvdHVzeHV3Skdub0lvbWFk?=
 =?utf-8?B?TmpDRjZSbU9qakR4K1c1N3dDSkVTTWtmSkM1WnNFZm5rc3dPM05abHp3SjMz?=
 =?utf-8?B?MGZJcDRHRzROdGtHY1ZQd2JrT2JzTzVHUjRNdjBRcGxZQU9Wb0p4V242MUFV?=
 =?utf-8?B?Ym4xQ2pkNGk0NjE5RVNBU05XRXBYY1hMUElFdW54YmQ2ZG1vZmdDYlc3UkxI?=
 =?utf-8?B?MjFTQ1pMYWFrV00wVWJQN212a2tKL3FjaTdrWTBLb1R5d0ZqUUZualF0NSsv?=
 =?utf-8?B?bG5CU1FWL3VTQmNWa25hVXY4ajlCVzlETUNBbnBJTjluMUkwZXVucTk5NTBo?=
 =?utf-8?B?dG1HRUNDWUwzNWg0YS8vV08wK1cxOGJ1eG40eEFJOS9NY0xrQlRZMm8yelNR?=
 =?utf-8?B?ekgyWlpBcFZFRnF1QndIS1RHRVVaekphNWpNZ3k1RGI4Y3E5RWx6OS8zNHRU?=
 =?utf-8?B?VmJUQThSbktGaHpFdVhqQitGYy9wemZzczFUWUlXMHBoK0orRmVTUVMzZTlO?=
 =?utf-8?B?MzZoVzFzSm5ZKzhJU21VejhNUy9JMWVjK0JaanVRRExsU0FMamMyQzBFSEY2?=
 =?utf-8?B?RktYd0wyazh1V21CaXVBM1YwZ0tQWDRrQkswVVkwY0tVZzc1SUhXMVhhZW9o?=
 =?utf-8?B?aW1IbSt1M0EwTlppUDdhd283Q1BMSnJlVExUQU1pNEFGazlzd1pReFZZMFI1?=
 =?utf-8?B?cE5GeW1TWDBoVDZsRTFWVE84eHYweVovU0ExTDEvZVhCem9CbTVFMFZ4ckR4?=
 =?utf-8?B?aGdiTmJkaGxYTnE1WG1IN1Z0TGlwSFpsb2FVYXh5SnZIdnVFdmM1aFFYTFhG?=
 =?utf-8?B?c2RIL01DR1ZJa3VCazFuNVUrZTcvaDYzZVZuS0dIeWFQU2E4eGhqdWpKZWV5?=
 =?utf-8?B?QjBTTFVmNmo3V2lCY2R2ZDJEdGFSbEs2RHBaM250ck5sMml0L1JzdEc3NFJn?=
 =?utf-8?B?ejNGdU1tL3BwMXlKajRxK3N6WWt0K1JOa0orQWRJTzFzeHRTaUl4cFc4MWVn?=
 =?utf-8?B?SUZrUk5FaU5LWTdEdlZEemZrNWVaMzgyRXNucGNWSmRiNTRqZ1RSc3JudFdm?=
 =?utf-8?B?eE0zVlRLb29qRXRTU293VmRqTXUraHdEeVNZeDJjOFNFTjd0aU9KVmZJZ3NL?=
 =?utf-8?B?ckp6WUJmTE1HbWpCRlJRb0NLVE9FckJXbDVHRkJlUTljd0h0SkpocUZnNHNl?=
 =?utf-8?B?U0tQbGZweGJMQ1JKaHNOR2FyVU5vUTQ4VlYxbjhta3duVFlMcWxWLzg2MHVX?=
 =?utf-8?B?NGovL2txTlBrdnpaMStJNy9zaGk0bFo4TDNObWpDZE1QdkFZTkF6T1dwNWNY?=
 =?utf-8?B?djYzbWdiWHlzcHgyTUR6azFOQlZmSGNuaXhxeWVuN09Cc0VjVWNtK2NtRWdL?=
 =?utf-8?B?bGZYY1MrckRZY0Ezcm1jSWhhcm0wdFN6QitPbEVvcEFnWGJHbG9PME0xc1dH?=
 =?utf-8?B?V0poQmhSTy9zMHBJV2VEbjgzL2VDYlhpMjBPMkU0WHVnOTNhMFRQRmY3c09s?=
 =?utf-8?B?amtjNEs2bm9vS1ptTXRnRUdpdmxScFhCRk0zYjJqd2pDY21iY3FERTlSdEtZ?=
 =?utf-8?Q?0cAWQ0TgdNqb+uWi8OVIgdxtIyUM6QL6fpab8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MlNwQnRkblNCWUV5eTVNSTBlUFhKV2t0bmtCUmtyc3ZtZDcxWFNaVTU4emxq?=
 =?utf-8?B?Mk5YVXAwbXVicklmOU9uS09NKy9UbUorUkVSNUF6ZU9CczYyaGR5TG14Qmdo?=
 =?utf-8?B?SG9URWxJRjNNSmx0U1hnRFVQTThwdTQxdEd1RWtIYmlSRUpJUFkzdDJHQ1ZM?=
 =?utf-8?B?a0g4dStibFA4bnhPNlVONjEweHk5ZldCUFR1VGtZWHlCK2NQMXJWbGVwK2dE?=
 =?utf-8?B?TjVQV1MyZFkwaklwM3FBYXc1dWZ4akhBMlZYaUFzM1BqRUlIRHFQcksrdTcv?=
 =?utf-8?B?bC90a3NZdUZWeUI5bW4vdVFDNVlnU2FJYzI5eC8vMERtYnVEQzg0c3pmaGFW?=
 =?utf-8?B?R0poK1hqeHFJNmtWRDZRcFRxbVVvbVZvZ3p2NHVkWVhjUGI0YThpNm1tTDBn?=
 =?utf-8?B?cFdhOFBzbEFLeGkydUpTOU1xcllFVnJPSXhlZE9oQlhMUlo0NU1qVXlTTlRx?=
 =?utf-8?B?d0ZSb0ZnMjAvQzhUemUxclc5aGNVSEtXR1Jzd1hyWmxoVmRUKy9GWHY4T2ho?=
 =?utf-8?B?N2VhU1pSNlpFMVBJZUlvZHdPb2ZCeGJmb3N6WFIyNTMyUXdEVkkrZXJ2RHds?=
 =?utf-8?B?REFUZi9OQyt3K0ltczRrbXBuSE0rQzlwTHYyNHBMc1pTUnA5cGFXZkdKSzV1?=
 =?utf-8?B?clBHMk52UXJQRDQ5VnpQTmRKd2hOQjZ2NWNEc09jam5ScFlNdjg4RmJ4U1hW?=
 =?utf-8?B?aVUwWUtwL0NrOHl1NUdKNW5xNDRvdEhjWWo0NEVBaGZQZFpzczBOTGN0dlVZ?=
 =?utf-8?B?eGZxTWpBNmlSYlduc2ZXRXBGellHRklmMkJ4Rkdwc2pwbmZxVUd5WW1vSDhI?=
 =?utf-8?B?QVBjVytjVnBSdGRXeXI0THlCcUl1cjVUUGI5TTlvMExpSVlvaTNNc1RGWFFF?=
 =?utf-8?B?YzlERHd6OGZKZk5ZRGdMekl3OWlYd3NwaU1sNThHRXBxdUxEWkd5RnltMXEr?=
 =?utf-8?B?TG0rcVhRNy8vT3p3d0lJRGVwUktjWEQraGYzaTdjZ1dic3hjOFduQ0liN1M0?=
 =?utf-8?B?MHZOK0VDM2VJVUxXaTYrYUV4bmR0VGlERzFycHVwR2xQODlpWTJyeGRncS9u?=
 =?utf-8?B?a042Uk11eGR6KzU4USs2c0htcUlHZHQ1U1YyS0dvSk9xY0NJTWZqZHc3T0Zm?=
 =?utf-8?B?L285aG0rVzlIWGc1OFJibHp2RFRxTkMrVlRwL1pyaXlLT0RaM1dyck1KR1JY?=
 =?utf-8?B?Z3d3RHB4YWQvbWV0M21ydlNqV25vTC94ajNrd012RlZ5WjhqYkVUbFhXNUgy?=
 =?utf-8?B?UjZDVEdrdmhIRkhTSlN2SHluc0ZINDV1VU1oL0liL3hZaTZvYzdhVjZDS21W?=
 =?utf-8?B?MmRDUVV0RkFsUDdNODc1UkROQzZVcEhqbnN6MTFXZ2RLRVFERDliTkRzR1U1?=
 =?utf-8?B?ME9mUjdJUkE3RnZvTEppbW1UdzhVM3E5U1FNVEFObFJoeHhqNnZ2VTcyMjRP?=
 =?utf-8?B?NTFnVTBHVzhlRUV2RndvTnBiV2VlMUNGQ3ZaTmVHbEd2V1NOZllWdmZsQXlI?=
 =?utf-8?B?bnhTd1I5MGFFdTQ0ZUpqNTBoOEppWTRRWEhaSldNQ3RMbW41elkwVFRxdWlu?=
 =?utf-8?B?cXUzbjlycnIxdXMyRE45cSt6T0tPeFBCVy9hUTdJd3ZRZ1JuSHA2THNXdmF0?=
 =?utf-8?B?QzhxSkwwTWtWS29uM1BWSlJNMVRUaGRsamdtRnAzeVp1dUZtdkYwaEM3ekhX?=
 =?utf-8?B?T3JTaWEyYzByTlpMTUdtaFFMTXFSbjY0anJlWjJUOVRWZmR5QWRYTmx6QWtQ?=
 =?utf-8?B?TGZMclZRcUVCazJrYVZ4YkRmVFpVUUNrQklOS2ZqbUFYV2ROalNKOXNvR3ZR?=
 =?utf-8?B?eU84bmRwWVdJdm1sQUdpcExJaXVkcDJpTHFNcDNmWVlBbkNCVEhmVVZRTGtp?=
 =?utf-8?B?NXVIV2lYM2lFWEtrRmFGdWQ3TWV5SEJZLzF6WGMvRldyalg0M01iU0dERFpr?=
 =?utf-8?B?QWFtdzF4OVlUZXdBeG9rbWVFSjdDZ1QyVUU2QkEyNUd3eXZveVJaRWp5SFNV?=
 =?utf-8?B?WDBJMlRRNHk3bXlrN3pHT3pKcVFZY05GZ3hlenF3T3d1YTVqOERsdG9vdlV0?=
 =?utf-8?B?SjdRa3dibktSb0hUbkxRTkY2RlhldUJBTmsvK2VVOENHV0pZZzdhQ21Kc3pq?=
 =?utf-8?B?UkZEeEVtQy8zcVBZSEh5L2ZTWGdZVHdyYUJaWHlQK3ZOYmRCdkhieG56Yi9L?=
 =?utf-8?B?RCsxaThzdFhzVC9RT2Z4L0tXdG16VW5NdSt0ZWdVRTB3bHB0Qk9Ma0tIRkR2?=
 =?utf-8?B?QzYrVTJUTnZHV2FGQjZGallJZVd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E12E6ACE503C7B4DA83854445BEBBFB7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UnRLTg7WHutYh2qD12QhrlXri2iybtb0EHrVTnx1jJfgD0Tw+Ayxy29gmOnuRk1V/MAmg9dqjzvYiA2Lxk3eJDQCTc7JT/Xx6hNf2MFSvnHB+epvaiw3F2b0OXVwyoxFBPMahzQGRgDGbjSPMmeZH/hEqPM6j5Vk5ixi82nj0YAEHMjPpuP5zEe4yq2atd8BbG0HQmtPHJD2NbOpq3tuzVUiyPSI98ytKY+h7lJo5TmOZc8ib3RuU37lJymHuHCb6+NaGyNboe+HYXE4qJM5EiAdUmpAhOHOFTM7gWzYoIFZibjeAD9xqYJLIts/dpJLks5Q1I6XGJijy3RTDkH4zgC1pWM9MgF67iDZx/7JYJnVHSqwzNTas5Ax45EHtuNwDILwUAFGCc+WR2bnxnuYil6c5XPHm2Oxl22AaERr5az5fkFNAyJd8cMOvKi06nC2QJnYaOpea9vG1qh0yrkKJTvUa1JG5dDdGkbT/nxszk7CrZRvEfplNpnl8SWro4jpwU8SV2TOVb1hqblVNFfuroGuT17XT5BQwLbcEE0o7b13lab6Qa/rkfzJDfWzNCejRyMtiV45xewV/ZhKdaA4iEkYe9XvcxnAyORjvzHhnb2z7LCI/jXVH/sIDNgLNaDL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee45689-489f-401c-4bae-08dcfcbdcc6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 10:45:28.7900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AUqZAcgGIqSOuR0gCoVRJkW5tzqhwzU7zCFARWopiTJ109Z1ETQlq6BRc97ar/2YQz1Y0m/IdMFmITBwQ7Xhb5QPxmZTgHZmf5dMGKO1yTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7690

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

