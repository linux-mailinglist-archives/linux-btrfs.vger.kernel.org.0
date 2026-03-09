Return-Path: <linux-btrfs+bounces-22289-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJhhM5/srmmSKQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-22289-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 16:51:59 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB4423C1B0
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 16:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02292304E7F4
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2026 15:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9635D3D9059;
	Mon,  9 Mar 2026 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aFXMrJkd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jBQ+yJUF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C073D9057;
	Mon,  9 Mar 2026 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070568; cv=fail; b=QigScKEQ7llRcsbaNGWA1nCSbXGcgM6qFsdJOhoqbk81M7IOINH5A4s2mBbUKYaMEU3aDn99a1nkoVTrhMqN282Wv4tsqL7L8qf2AC62XyfhcCiOZapV5bCj57ZWBSuhgGK9G4swOXTfi/Kdjv8ubL9n3xndF1hutMVA+kFzjGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070568; c=relaxed/simple;
	bh=69ajqc7c6dmIz5cNsiRGfa6Blxvc7yBaqrKv0QhSDcs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rf3cIxPehoL8btFgNzHF2THccoDMc5gNEkSFx7BiZVpLozXDCwKm66jeY4r3NJ03GWecbzZRw6Cmj984xrZStKyDfcfNDbJ6Dxjf0QZVe4Ay32uxcMo3VmjEXU35bgVbepZNhsJNNy1g9zzpUwqP/w6jgK2WPznSOi8uArqyANk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=aFXMrJkd; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=jBQ+yJUF; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1773070568; x=1804606568;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=69ajqc7c6dmIz5cNsiRGfa6Blxvc7yBaqrKv0QhSDcs=;
  b=aFXMrJkdB3GQHoC4Bi1Ia5ZtgTCwity8i/vX6xQRcORjvJaXyI8V51yl
   qQS5j+XKqH03OiiZ9uQqsuRS2+F8PkwuUKdy3C3EktyRwh35civYIRxiJ
   /WuVT81WwtTyCKHUdPALMJxxXOedxEoPEhgvKm0/jXmwsikfEF1DaAQr+
   labtFH8UBSvG2P4RCH5ZALicSa5JSbBVVgl0A2Vr5veHw832vwpqdEHFN
   klXWBna/qma4O4MzVLecmgN5tibSYl444x4QH6Cc+vfdCGjRMgm3Lc8Ba
   qXpwmDO1xB1/sephR83oJXW91uclE9qtBoX5ft/nbNAtUoKje2Iw+G0Ei
   w==;
X-CSE-ConnectionGUID: Z3fTxb7ETTq9EwAodNqI2Q==
X-CSE-MsgGUID: r2QjCL7ZQm2kCK0FmpNxGg==
X-IronPort-AV: E=Sophos;i="6.23,109,1770566400"; 
   d="scan'208";a="142715936"
Received: from mail-westus3azon11010005.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.5])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Mar 2026 23:36:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPD010Bn2c6NdDAPmR5hJyhvL3zQJDJQaOOO0vfZwTTuv1IzQVy6Bsp80/QiP6XsQlDtLH8TVn5YuuWdjcm/rmvDtYUsOFgU9C2RKjeRUkF4Ui7oePdD+3MNHsLiuruT99YjiE/cXbptEPv1gg/5FsCtGYnVU3TW/RrREbsjiJLg47tQul6/L9f5F+ZuqBG0IQgby/q/vtSueiWu4+hJaeKiPSVraZpQudeuocT1n794Z+c0OHBxQFmzPVJpbqQL1Q9KRYtD4WdgvFdBtU1LO2AHzfSz1Z81qw/wwVQXeiqVVjSCbsEJ9CiCTfLNOICETFe1FlAzfx+X1WxchaJoaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69ajqc7c6dmIz5cNsiRGfa6Blxvc7yBaqrKv0QhSDcs=;
 b=ZM3xexzj6OuI+Y4XmGRtmVrTEg9AdiaVRfNSwOI/11LIL8KC7xq0esZNekjW68gtcoxHZrZVxdkS3qapRkMvtVsruIvxYNUyFV15U7BMRE4UR2k/JJwyhVv0pZTTLTGfEaBOtK04QOWsVrYQtaCU6l5pamGrwl/sESpmZtn3+lazwE5bwVowXG56/USwiH+5iCW7/GxPE9wztdrdP6RSttqmVJbBpkVFoCwb6ViaX+wcdJ5XEOlLGpjVDJnStNVd8pIqpPkV86QNFj7LZ+w1n3GcOFGLM1dgH+MB9VJG5pu5WcoUNy93Y/VzVno1bPU4wyZAHQo7TAwHrXxzahqlXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69ajqc7c6dmIz5cNsiRGfa6Blxvc7yBaqrKv0QhSDcs=;
 b=jBQ+yJUFSDbA8SFm18MV/R0m1YHwz/KHvTQ542ZFGr879VI3OLAxesREBGFU/IkP8CbgNMfKipAWqBSR9mUoxNtzDV8eS5gePum4bwwWuF8nSKJuRKpUMMID+iGUEgvPCAzUeIJHna9wenKckTl34ytO7vzO36P7gSp2oAkb6Eo=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by PH7PR04MB8682.namprd04.prod.outlook.com (2603:10b6:510:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.23; Mon, 9 Mar
 2026 15:35:56 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 15:35:56 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
CC: hch <hch@lst.de>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>, Hans Holmberg <Hans.Holmberg@wdc.com>, Naohiro
 Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] fstests: test premature ENOSPC in zoned garbage
 collection
Thread-Topic: [PATCH] fstests: test premature ENOSPC in zoned garbage
 collection
Thread-Index: AQHcmn380SEWYFJwgEKjj1PHhcZCxbWmfqUAgAABNgA=
Date: Mon, 9 Mar 2026 15:35:56 +0000
Message-ID: <f39bb05c-f3ea-439e-8a78-71909ec3ef3e@wdc.com>
References: <20260210111103.265664-1-johannes.thumshirn@wdc.com>
 <20260309153136.taooohkzuc4ov56p@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To:
 <20260309153136.taooohkzuc4ov56p@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|PH7PR04MB8682:EE_
x-ms-office365-filtering-correlation-id: d52ab895-174a-4b71-844a-08de7df18e91
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 K+1g8YaUmIWql6ciKZndnCXtb3gU5fHhMcWUpIbdgwbskL6zRj16f5vlUhbTXbz/LQ/takyuIHjQTln8VoCGKVhS4Udd4kLuOXE2NlVrOX28OkMQni8xHSdir7m6zjHwHTxepyzbs+NBWp3ndHTeM8K6rW22EldaVLo/X65ffhxDaimmkOOwpuidYfIzHz+/z4/Xw9AZWrwCLT4A/16a3k4rjBJHRGIRU7kBoP/CPotnRMwD6nJQhbMpM/Cqwf/CJAHDe3Bcuh/SxJcXAzt7rC1W9sV9vsuzk8F6ENOMWfwHs/QQlplUS65Ty7/SKUX/wcy7TrcSrzn+k+69c5IqJ6cYKEUu90jn4TZip0t6Dk/eMARRENb/VX5EEp8fE22T0zI6mWBcDYg80P/iUztexJq8mJq8RnFkP26cpnguX9evJEjezO3T41PMY++hLSAt6+3ExDY4Gbl+4m2weQhqDAw2Xl6sDXnN1InBkiwCLRNLVDZN6v/SZ8zo5zQ0a0DI9p5tz8ecOf9qaNMsO5etmIB6gla0RCTo5jgWsrZv5gnIQwbV+bpXUsuX1snSsEWH469TNYt0LtANtGyusroYoOJV2zds0+N/J/T0VE3GuVQqLTeewpXV0LRhiTBIO+KSL6SW55QnJ1ZuF+jXm3saVEt6sVMgMhLQeWlZaOgK50p2csNoY4K5EGx9UNTbIHsSeCyHesTyAlo9DN5obHdThoaK6/gsEwCnwqhTa6+JZ9ekFFjqdo2H5kxWHlEv+3yN8BWgDve3F9fpDf4sc3L0kmgtuHWjwTV5JOR9qqVmK9w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXoxMzZ5cnB3U1huYllKaTJHbVdRREp3aDMwS1AwUUZPOGZ5UGh6MXk3cTgr?=
 =?utf-8?B?anJNNTU0T09uOUkzdExxMGFUVGFnZjBxSHJFdUt5L0daZHRrbU5OTFJBZW4z?=
 =?utf-8?B?eHlNTDJmcW1QZDdXNVlWaHFuMEJBN25meEFENUJMMGgzR1NHZzBFL1c5Rlcr?=
 =?utf-8?B?ZE5YRVl4U2lGYTRzRGg5MEJBWFRZUGNrMmMzbXArbFhlV3luMDYrMUdYU041?=
 =?utf-8?B?TkpqQXM4eFJEMGhkR040M1R5SUthVHZjT2dGTllLUEhJM1BvR1dTV3lmZFpx?=
 =?utf-8?B?akdYNHBRaGFlNzlsbVpONk9xQ3lBUEFWWnE1L0VhRnVSMmdIWGpaTnVFVWhE?=
 =?utf-8?B?YXIyaW5JQUs4aXU0QjlHbkRnRTRCQ3hWM2thYkh5UUROdnF2bjZDQi8yVUJo?=
 =?utf-8?B?SzltcVIxQjVpWHZPTFVDekNMMmhqSHNIVlNXNXhFQUl5cWNIaCtPdi9yeU01?=
 =?utf-8?B?d2lhUWZUd3JKNzcxSWIrSnJCK0srYjgyV0J3bmtNVVJ3TG40azJId0JRdGNo?=
 =?utf-8?B?d1pyRmJrZGtQVHNCWDF6WllRSjFSa1lMMGVvTnhVVVJKK045VkZLSlUzR281?=
 =?utf-8?B?R2QrRjY3b0NNZktBSlBiNlpuV0tRRVRyWVZEY0JTS2FReW9VV1lENmdWamdT?=
 =?utf-8?B?N1RtbzFsWHMzWnUyTy9iZW5XRzBTU1NRUjB0endMMXJzeEp6cjkwUVNHUlFV?=
 =?utf-8?B?TVZuSmVrNEhNWW9HNmxPMloxeDlqMnRNMlh3b3VkZnBtY3VuVWhwK1JrWFMv?=
 =?utf-8?B?RUVLZmw4MjZPc1pSd3I0aytJd2NOb0F5WjRJdHZnWkdBcFBVeFhzMmVLeWNZ?=
 =?utf-8?B?d21zekZ5TGp0aXZMSVlXVDd6UDVSQ1pab0dVbm9lRllFc3pTZUFtclJYaG84?=
 =?utf-8?B?V1I4RG8rb0dvTkVIUCtjcUVhSC9SVisrcFYxd1F0Tmoya01pWWk5cWw4N0sy?=
 =?utf-8?B?MlRPV0s2OHF4Q2RkMlU2VGRSc3NZdzVmdklGK0UyTEphNG1ud3Q5ektwRGkz?=
 =?utf-8?B?OGhPUmd5Z3VCcGo5WDhWd0JUdndrMktyaENmWFhVclZYeFRscVI0VFhEeFFF?=
 =?utf-8?B?QzdLZ3BPL3IxWnAvRlZrVVhiUEZsbTJKcTZ0TStQTE1WTm9MalBSWlBmUkxW?=
 =?utf-8?B?VHZwZ29KRDNFbk5Ca3lkL0x4ZnR5UmJMSEJ1amlic1BNR2dxblN0RDJZSzVU?=
 =?utf-8?B?cmliRlZkV29mRU1FSm5DRHRGZnpkZ21QMVFxWjhtc1VRT05kYWM4aTh0MUpS?=
 =?utf-8?B?TVEwTXdJQlROemUwdWE3TjJudUNCOG9WYkdNYkI4OFIweDBGR1ZzQ2hGcUhN?=
 =?utf-8?B?NE9yVU1oVU8waEpFOVN4eThGeUU0Z0x4L2tneGRCT0R1ZEhQV25mVGROd1A3?=
 =?utf-8?B?UVdMWXhoMFpqK25pSnJEdEFaYXAyMkxuOUJJOUdpOTlsSjE3QUx1N0hrZXM3?=
 =?utf-8?B?eXNOOVpleW9XZkw5NW1UQmNsV2xxa1NYQnR5dUp1SW1rLzlsOFZ6enJTRXN6?=
 =?utf-8?B?Vlhad1ArWUNZUjY4MkhkVnM3cTVwZjdSOCtMZTFkQW1ia0o2SzZ1aHpGaG1s?=
 =?utf-8?B?cmlDRlAxRHNDeUpSRWxjelUyUzJFQVhUdmtNUlhVZHZ1OVNCNzlFQ01GazR0?=
 =?utf-8?B?ZzFrTk1oajhEcmVmSGVqQkY1OEJYYUNFNjkyUlFHSzlZeG1IWSsrYk0xVHo4?=
 =?utf-8?B?K1FqeUpDL0J4enI1Nm9xSVRrM0hkdFpjZWsybVMwZ3dtcmhwSCtGbGpoWDdz?=
 =?utf-8?B?QlIzajhOTThubnZ1NkNhUGFMNWlYNGd5TjhLcnVCemoxUno4SDh5a284T3dx?=
 =?utf-8?B?aFV4U2d5bFlQbGtOeVdKOERpbmJIWGNmUG5pNjhDem1xMGdFb25kME9nSXo3?=
 =?utf-8?B?R2pNT20rRUp0ek9aWmJyZmMwdklXbXVxWFlDeVQyN1FJYXVaMnJPMmtSSm5X?=
 =?utf-8?B?STdOZFRTdU83ckVHdTlaaFR5NjJBUHJYN0xETXlOc2d5SFozMEJQTzFHeDE4?=
 =?utf-8?B?OE04aWlHSHBIb05pY3JKZnlpQ1lWVHhEYk0yMGNDdFkxT0JkQlNMV3RYUlJL?=
 =?utf-8?B?U1J2TzZjeWUvNnU2bVdueERHS3NqVzRpWXpyd21QMWpRWDd0QjRZQ0wwTzdB?=
 =?utf-8?B?d2R6a1dweWNPa096VmdibjB1bEdneEVLVWFXYlV3M2JMWU0yNmxvT0w1WUYx?=
 =?utf-8?B?YzVZUnJuYWdUYVNlZHczR3F1YW1xRS8vUkRkU2o0dmY2eWI3NWtDWXpBU3pJ?=
 =?utf-8?B?a0NkWE1SUy95aE9ZUDY3dE1EeWVzQ3BTa3R4bHBaWUZHdXVjWG53cGZ2RFZ1?=
 =?utf-8?B?SmpjUGlHOEZVWTVFOW9ZNXFYTld5bWJNeTByUHk4ZXQzdmZ4L0dXRFRHUG1r?=
 =?utf-8?Q?ypzAq1vwrjIKw0c7XvqkweDF5JMQuPbOIxQHCeUIU9uPp?=
x-ms-exchange-antispam-messagedata-1: NsYfhzE3ib8IIEkh1okOCUavCeDX9IhT2GU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <986C3C4196895744B5C92895046F76C5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	q1gtWmobQsgMqKIi/Lex06TNDCM/weGoqmLbfDS6YNdU6mLggUYVV/PDMbRcatdXcq/O0UROFCTJNyV5+hZjXFnWaAtkjNv2EHWHR/VO+tVtP5yvG3XV76CxebDG/t+2MDb9Yu8Np0G5QrReKZfedQvbJvjObqEsMPJADWy7IVSpsRFtyKOIVFN6S0VDNIPSMzyuUsSVacIN2vb/Hw+aWLvBIQHA8W6vS0D2gueCa+dQRy6iE1IdKFTdGpvjn3xKNCXoN2URgdh4kMTF+4fl9GoVKQxNRELUF9Ml31XXDpOIbLSVc6BnDqyPKECeiOx4TdcYjd2ciPgiPNHBtUfj3A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v3UeM6PtCtUYxEE1sJz1qm2YoNToZB4deXcGReuk3iY/12xhetyAciN18ZeSyhmbYJgEov0xpzknFBD29TRiKRfRcqCIAH6EDVi45tetwvWfHMl0uS+FoiiLXGiIIrAzwbBqzgZOYLfQGvF/lMvwkE+XEK/rQ2waFNa8efhswlydD5o8RMaYy5TrQRzKR8vjKlPZJPZVi6eCjauotr20VI4CiUb4Tss5KkY2zhM0m56JE08yDXNpzbMrHY43qbaBj7mgF6OPSgUZkWGvv6MJmaR7rIJOy1P81GgNWbuYFj5RgmW+6R+GXO4iPadlEmZ+I9SYx09pYD1D837jM4a9xTG9PnJDukUOEg80IpRsEDGkOnz0zo1f690xLEvvHOFoKUfLxXMgeWRxZ4VrWr/cGk4mtZQlCExDJFWUO8LEzKxzcccRzgv9dHU+RKdDs785S9FqxkoQ59XjVytZ4XwVth8gORZ6r4xNrbp02zo9l3ZPdeGNtF0ahqFzjF9lDo7wzPPXhCYSJ0LtbaZ/I0Wp2TONJbFQ1LT6EZzEG3GsBtEr9zJBd1hdv5fzGcX/n0IKz6V9lXkuDTxRuKEXp+TnL9/ZKJ3B2IQlzFemAvD59s2DKCdIGkltaNwPKZlA7SoW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52ab895-174a-4b71-844a-08de7df18e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 15:35:56.5471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zgA5vn0OeRAlm3Rj+438P2/Xh5ARX/47cMRxNiEZdlm2zu2SIL2HZX7+VDtPiU2hD0IzvgDuw9KafwOhHQWzsUvohjn0niPfHkxGaXDa8Ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8682
X-Rspamd-Queue-Id: 5CB4423C1B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[wdc.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22289-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_REJECT(0.00)[wdc.com:s=dkim.wdc.com];
	DKIM_TRACE(0.00)[wdc.com:-,sharedspace.onmicrosoft.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	DKIM_MIXED(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,wdc.com:mid,wdc.com:email,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Action: no action

T24gMy85LzI2IDQ6MzEgUE0sIFpvcnJvIExhbmcgd3JvdGU6DQo+IE9uIFR1ZSwgRmViIDEwLCAy
MDI2IGF0IDEyOjExOjAzUE0gKzAxMDAsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+IFRo
aXMgdGVzdCBzdHJlc3NlcyBnYXJiYWdlIGNvbGxlY3Rpb24gaW4gem9uZWQgZmlsZSBzeXN0ZW1z
IGJ5DQo+PiBjb25zdGFudGx5IG92ZXJ3cml0aW5nIHRoZSBzYW1lIGZpbGUuIEl0IGlzIGluc3Bp
cmVkIGJ5IGEgcmVwcm9kdWNlciBmb3INCj4+IGEgYnRyZnMgYnVnaWZ4Lg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+
DQo+PiAtLS0NCj4+ICAgdGVzdHMvZ2VuZXJpYy83ODMgICAgIHwgNDggKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICB0ZXN0cy9nZW5lcmljLzc4My5vdXQg
fCAgMiArKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKykNCj4+ICAgY3Jl
YXRlIG1vZGUgMTAwNzU1IHRlc3RzL2dlbmVyaWMvNzgzDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCB0ZXN0cy9nZW5lcmljLzc4My5vdXQNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvZ2VuZXJp
Yy83ODMgYi90ZXN0cy9nZW5lcmljLzc4Mw0KPj4gbmV3IGZpbGUgbW9kZSAxMDA3NTUNCj4+IGlu
ZGV4IDAwMDAwMDAwMDAwMC4uZjk5NmQ3ODgwM2ExDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysg
Yi90ZXN0cy9nZW5lcmljLzc4Mw0KPj4gQEAgLTAsMCArMSw0OCBAQA0KPj4gKyMhIC9iaW4vYmFz
aA0KPj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4+ICsjIENvcHlyaWdo
dCAoYykgMjAyNiBXZXN0ZXJuIERpZ2l0YWwgQ29ycG9yYXRpb24uICBBbGwgUmlnaHRzIFJlc2Vy
dmVkLg0KPj4gKyMNCj4+ICsjIEZTIFFBIFRlc3QgNzgzDQo+PiArIw0KPj4gKyMgVGhpcyB0ZXN0
IHN0cmVzc2VzIGdhcmJhZ2UgY29sbGVjdGlvbiBpbiB6b25lZCBmaWxlIHN5c3RlbXMgYnkgY29u
c3RhbnRseQ0KPj4gKyMgb3ZlcndyaXRpbmcgdGhlIHNhbWUgZmlsZS4gSXQgaXMgaW5zcGlyZWQg
YnkgYSByZXByb2R1Y2VyIGZvciBhIGJ0cmZzIGJ1Z2lmeC4NCj4+ICsNCj4+ICsuIC4vY29tbW9u
L3ByZWFtYmxlDQo+PiArX2JlZ2luX2ZzdGVzdCBhdXRvIHF1aWNrIHpvbmUNCj4+ICsNCj4+ICsu
IC4vY29tbW9uL2ZpbHRlcg0KPj4gKw0KPj4gK19yZXF1aXJlX3NjcmF0Y2hfc2l6ZSAkKCgxNiAq
IDEwMjQgKiAxMDI0KSkNCj4+ICtfcmVxdWlyZV96b25lZF9kZXZpY2UgIiRTQ1JBVENIX0RFViIN
Cj4+ICsNCj4+ICsjIFRoaXMgdGVzdCByZXF1aXJlcyBzcGVjaWZpYyBkYXRhIHNwYWNlIHVzYWdl
LCBza2lwIGlmIHdlIGhhdmUgY29tcHJlc3Npb24NCj4+ICsjIGVuYWJsZWQuDQo+PiArX3JlcXVp
cmVfbm9fY29tcHJlc3MNCj4+ICsNCj4+ICtpZiBbICIkRlNUWVAiID0gYnRyZnMgXTsgdGhlbg0K
Pj4gKwlfZml4ZWRfYnlfa2VybmVsX2NvbW1pdCBYWFhYWFhYWFhYWFggXA0KPj4gKwkJImJ0cmZz
OiB6b25lZDogY2FwIGRlbGF5ZWQgcmVmcyBtZXRhZGF0YSByZXNlcnZhdGlvbiB0byBhdm9pZCBv
dmVyY29tbWl0Ig0KPj4gKwlfZml4ZWRfYnlfa2VybmVsX2NvbW1pdCBYWFhYWFhYWFhYWFggXA0K
Pj4gKwkJImJ0cmZzOiB6b25lZDogbW92ZSBwYXJ0aWFsbHkgem9uZV91bnVzYWJsZSBibG9jayBn
cm91cHMgdG8gcmVjbGFpbSBsaXN0Ig0KPj4gKwlfZml4ZWRfYnlfa2VybmVsX2NvbW1pdCBYWFhY
WFhYWFhYWFggXA0KPj4gKwkJImJ0cmZzOiB6b25lZDogYWRkIHpvbmUgcmVjbGFpbSBmbHVzaCBz
dGF0ZSBmb3IgREFUQSBzcGFjZV9pbmZvIg0KPiBQbGVhc2UgcmViYXNlIHRvIGxhdGVzdCBmb3It
bmV4dCBicmFuY2gsIHRoZW4gY2hhbmdlIGFib3ZlICJfZml4ZWRfYnlfa2VybmVsX2NvbW1pdCIN
Cj4gdG8gIl9maXhlZF9ieV9mc19jb21taXQgYnRyZnMgLi4uLiINCg0KU3VyZS4NCg0KDQo+PiAr
ZmkNCj4+ICsNCj4+ICtfc2NyYXRjaF9ta2ZzX3NpemVkICQoKDE2ICogMTAyNCAqIDEwMjQgKiAx
MDI0KSkgJj4+JHNlcXJlcy5mdWxsDQo+PiArX3NjcmF0Y2hfbW91bnQNCj4+ICsNCj4+ICtibG9j
a3M9IiQoZGYgLVRCIDFHICRTQ1JBVENIX0RFViB8XA0KPj4gKwkkQVdLX1BST0cgLXYgZnN0eXA9
IiRGU1RZUCIgJ21hdGNoKCQyLCBmc3R5cCkge3ByaW50ICQzfScpIg0KPiBXb3VsZG7igJl0IGl0
IG1ha2UgbW9yZSBzZW5zZSB0byBnZXQgdGhlIGF2YWlsYWJsZSBzaXplIGhlcmU/IEFuZCB0aGVy
ZSdzIGEgaGVscGVyDQo+IF9nZXRfYXZhaWxhYmxlX3NwYWNlIGluIGNvbW1vbi9yYy4NCg0KSSds
bCBoYXZlIGEgbG9vayBhdCBpdCBhbmQgc2VlIGlmIGl0IGZpdHMuDQoNCg0KPj4gKw0KPj4gK2xv
b3BzPSQoZWNobyAiJGJsb2NrcyAqIDQgLSAyIiB8IGJjKQ0KPiBJcyAkYmxvY2tzIGEgaHVnZSBu
dW1iZXI/IEhvdyBhYm91dCB1c2luZyAkKChibG9ja3MgKiA0IC0gMikpIHNpbXBseT8NCj4NCj4g
Q2FuIHlvdSBhZGQgYSBjb21tZW50IHRvIGV4cGxhaW4gd2hhdCdzIHRoaXMgImJsb2NrcyAqIDQg
LSAyIiBmb3I/DQpXaWxsIGRvLg0KPj4gKw0KPj4gK2ZvciAoKCBpID0gMDsgaSA8ICRsb29wczsg
aSsrKSk7IGRvDQo+PiArCWRkIGlmPS9kZXYvemVybyBvZj0kU0NSQVRDSF9NTlQvdGVzdCBicz0x
TSBjb3VudD0xMDI0IHN0YXR1cz1ub25lIDI+JjENCj4gTm90IHN1cmUgd2hhdCdzIHRoZSAiMj4m
MSIgZm9yLg0KSXQgd2FzIHRoZXJlIGJlZm9yZSBJIGhhZCBzdGF0dXM9bm9uZSwgSSdsbCBmaXgg
aXQgaW4gdGhlIG5leHQgcmV2aXNpb24uDQo+DQo+IFRoaXMgaXNuJ3QgYW4gYXBwZW5kIHdyaXRl
LCByaWdodD8gU28gd2Uga2VlcCB3cml0dGluZyBmcm9tIDAgdG8gMUc/IENhbiB5b3UgdXNlIGEN
Cj4gY29tbWVudCB0byBleHBsYWluIHdoeSB3ZSByZXF1aXJlIDE2RyBzaXplZCBTQ1JBVENIX0RF
ViA/DQpCZWNhdXNlIG9mIHRoZSB6b25lZCB3cml0ZSBjb25zdHJhaW50cz8gV2UgY2FuJ3Qgb3Zl
cndyaXRlIHVudGlsIHRoZSANCnpvbmUgaXMgcmVzZXQuDQo=

