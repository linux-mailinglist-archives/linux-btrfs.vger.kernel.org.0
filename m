Return-Path: <linux-btrfs+bounces-4920-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0356E8C37B1
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 May 2024 19:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87D1AB20B76
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 May 2024 17:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FFC4AEE0;
	Sun, 12 May 2024 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="m06ZqbwZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="b+pPYMW7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF2A1CD1F
	for <linux-btrfs@vger.kernel.org>; Sun, 12 May 2024 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715533714; cv=fail; b=iFuFMwyGZ8KC3MHuBpuMbhlHz3oDE34zEkFtxAtB0IMJvtSEednuc1JFhwP7g3LZEtLtHJFV5qfk1wbAP0TMZLpNJWrInT8g5GvuTqjzAQ1jhvbrihBpDPhGimDXs4LM3WrKlPW/IsHjiAcbZH+Qr46j/ErOJyunc2u5qC9FMgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715533714; c=relaxed/simple;
	bh=oUY9XJ3YeOK5jhguOImDIm8jifVCye7xczTcAescT1Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aPfixrhhEYwxwe3VP9ltQ7zpogREtPLFzrR/bhdZVTvVzdZ70wexGD9JnXma46Q/7RdlV7D1uab4oITIh8f34UgQsA2E45BVdMwy97C7l5ihQqRLKi23HLBWk10kWZEQevvN5DIG1e1L8P1Xzxf2k2WnfZNmu/NSLRK245i4FBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=m06ZqbwZ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=b+pPYMW7; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715533712; x=1747069712;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oUY9XJ3YeOK5jhguOImDIm8jifVCye7xczTcAescT1Q=;
  b=m06ZqbwZDU7Q9vYONCBriJdPJhpq1hvLbe3hbw8ksEJzIl8IDiIq65AR
   LUk4H5fUHXnezNGKHGZ3ZjQ/qM6gOjX7IjCjRfoiPA1ZlKINkZFVkLmpK
   1e53FfiMKpRI9PlPtS56JdxlJN9Ok6Yg7A5jgjOloDh8BRrvl3N0bfviA
   5BdQHo3m63l9mIRbLBgtGQ4CJEuUs8DxX6VqEJ/zZqmEAggw2qxwHJbcu
   0Yirk3nhvWFCQCRqPU++9u/9iiDpXEFhKX8fO2ZPveDJ/TV7KjOjFUP0J
   wy08GkedncLsCe44XbCtq6AjfktnNcDfj0x1fPmF0sGrAAHLRjcgER914
   g==;
X-CSE-ConnectionGUID: slZKVXFDTOGrSPBkDVbBog==
X-CSE-MsgGUID: +H2B/P3GQIyxMt6MZl5vSg==
X-IronPort-AV: E=Sophos;i="6.08,156,1712592000"; 
   d="scan'208";a="16191352"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2024 01:08:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGZ/8Ux+2UH7/Hnh7aeQakTRTjraU2r5NsDyGhS5ggi5UpC3UiOiOd/w9xcSJQo34jr5SqR0+8+LT+hVLmQTEpdyaRFLeyH3bilXVF7jzK9hO05O4y94Du8Qsek2nAw9xJ12TDO2sCNlivqhB4Z2AZDWADpDDI4m2BFUyULmmZPJKEIEqOYh5dOow4+7zeoV4zB752VHHFp0s78sS1JMWgTizM0wjxTTGhe+U31PeoS6sH1FO82Vbj7WJXMNM9DVjZmJT2ueYPLPSrojrtzC0tBL27cH5B9N4nGUGvA1OO2bo4dGH+Ha4gc7R3sg2SAoUMvi4s84q3UIcpzDut/L7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUY9XJ3YeOK5jhguOImDIm8jifVCye7xczTcAescT1Q=;
 b=ld/2Sa33kSFDTSMLsv9Or+b3YfgzP5TO4+9msI0ppLm6qz2krGd81yLXuO1/jlJ7zLIWDw+/cf8HOK34ki935M9c1/3g89FCQFWyRUtiDHvEtjZTAF4GUe3CgVg9KEOD1bWYhrT/0eNZSoCRtYf3gqmKohloy3o1pBQ01nFzTr4Re81+VoFVk+iXlKfL2dIAKYoqPdr3RRhjs6aKuYkPfk2hpbir6uRUDj9KtYKk98t9tW+LipRSaZqBtMfqLOaQP8UMU6i9zLdSNy9MC5lns/lvQdlDe7/5G+1h3+sC50VYFj0A316R9x8Cc1rsX4/eamNgmXFw8ujo2+Q+p0kc9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUY9XJ3YeOK5jhguOImDIm8jifVCye7xczTcAescT1Q=;
 b=b+pPYMW7gdtUMHBk6XTW7ldD8nMMaTDwH3njZg9OhA7YzlCidPyvtY1M1n/EFw0LTPlVJubnutXGbX1jz8cF4aoA1QTM2aZrVHUkeM5QJl5kwfSlwKcBjC/Benu+4cq/qqTMey4qEmoOlDN0hX6Z43QleMb9UW2q2IJEppgOgPg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ2PR04MB8897.namprd04.prod.outlook.com (2603:10b6:a03:547::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 17:08:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 17:08:23 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: "josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [PATCH v4 2/6] btrfs: lock subpage ranges in one go for
 writepage_delalloc()
Thread-Topic: [PATCH v4 2/6] btrfs: lock subpage ranges in one go for
 writepage_delalloc()
Thread-Index: AQHaozhcHCUTYADbUkeOEQoBwxdgUbGT14sA
Date: Sun, 12 May 2024 17:08:23 +0000
Message-ID: <84a9472d-87b0-41dc-a8dc-b9c644e81b53@wdc.com>
References: <cover.1715386434.git.wqu@suse.com>
 <91da2c388f3152f40af0e3e8c7ca7c7f8f6687db.1715386434.git.wqu@suse.com>
In-Reply-To:
 <91da2c388f3152f40af0e3e8c7ca7c7f8f6687db.1715386434.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ2PR04MB8897:EE_
x-ms-office365-filtering-correlation-id: 02b145ad-4dbc-4a44-b315-08dc72a6217e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z3k1aVJuT0c4SWNTMzQ3L0NNMjBDOUVRSFJEcy9wVGlaSXN6UEgzSjB0Tkp4?=
 =?utf-8?B?T0s1ZDBVWXRtbHBod1dXcCt6OW1hVnhwZllqMlJXQzhZWitVSzJtL2xIbU1U?=
 =?utf-8?B?Vk53SlM4VjR4QndXdWN4T25WWGloTkU0Vmh1bG1yUTN0SUZnNTgwdmJ2eUlV?=
 =?utf-8?B?b2Q1Zm1OVHo5K2J6ZUxNaHJwaFdqT3dwak9rT01TRGl2OUhKRlQ5a2FlWVB2?=
 =?utf-8?B?THRoREhjTW5tckptRW9FN2U5NERGTzBjY3FHY0I3UndqaVRBR1lSTkNiSVpE?=
 =?utf-8?B?NDhLaVZOcjZIWFNLVFJhMTFCem9SbnU4M3pBRWVwU253OVZVa3BEaFp2S0tL?=
 =?utf-8?B?dUJUMnRHTVhMTm1PczdWamJHbGFacXlEWThOQjNCRDZ2WHNvN1NnTnNOWGg4?=
 =?utf-8?B?TUV0MXZqKzZwazhuYnpLVXJTNUdYL0VYWGwzY0tQTkdzNllPanF3OElNNVI3?=
 =?utf-8?B?VXh6d1U0ZEZVNVJGUVhZWXR6UzBQbzZJRm1TTzhQa1RPVTF1YTQrSEhqUnFE?=
 =?utf-8?B?cUg5RkhaNnJyVXZ6Q1RBeW9OQlZSK05yalp3UzVIaG9tSHZ3Ry8zODZodXFY?=
 =?utf-8?B?TzdxSmNqd1EvZ2FjNTMvMXpVRGU2NWQ1bUY3SVhaN2VWbDRhQVVoMi9MelFx?=
 =?utf-8?B?ZnlOWFRuaXQ2NjNjVUwyY3hWYy93SWdCYmxEdDFFS1JqeEw4b3RXZW9tejdk?=
 =?utf-8?B?blVOSnFJSWJRMVVFOVRYTit4Tm43MWpSV29uZ3hncVNlVzZseXArL2FKcmJE?=
 =?utf-8?B?U1ZRbDFLc282RmZiZEpaTmo0UU1vTzVtNkkrMk9tbmkrY0lIV3ZNbnFML2dv?=
 =?utf-8?B?ZHlJM0J3UDBkNmtSd2JMeTRPRzU1RDIwdy9nc2VPWGVVcjNuZGY4U1YyZEhh?=
 =?utf-8?B?eCtkd1ZwSURNam5nd2hkdzVwbkIrb3NubTZYcWtPbWptRnpNbUZidFloRHFn?=
 =?utf-8?B?NGlrUUUxdTFWOFgwZzNFS3JHK0N4MERVbHdYcU1yZmdTMGhNSVJPU2VrNFkv?=
 =?utf-8?B?MnJJWng5eUZOa0xkMTE0eG5LSitVSlMrOHh5dFd2TWZTLytIK1FSR29mQSt0?=
 =?utf-8?B?THhjWDQ3Z1d0RTZaRVg1bmdhcWw3anA4SDQ2cVZOY1pyc3p6U2lhMTdPVTNU?=
 =?utf-8?B?NFpwcG0zUE0xaWd1eGRDbEZxTUc0bG5reVNxQ1d0Z1hWT2dtWkhJTHREMEV1?=
 =?utf-8?B?YlVwWkJQQ2hHYTZVcnV0NWpBdEVQU0Y4T3lKbWUxcHA0dHVoaERmV0h0UDd3?=
 =?utf-8?B?elJOVWZIaThMSk9iS3BmM2x3NjN2MU9ML1dLK2FGTDYzWUdoeHkwVXpsNDEr?=
 =?utf-8?B?ajRpWm5XSWpTQmsvRCtTdXExcXJNU0l6RDVzZGs4M1FCZ0g0czZDUm5jMnVE?=
 =?utf-8?B?MG8vT3M0TkNiOXdEaGZXMlQ5L3JqVGtUV3R3V2ZlRmtIQkdYdjk2RDcvQ29H?=
 =?utf-8?B?bDZmTU9pU2FEcVNCM2IvYS9nWGtoR2pEN0lxOVIxNGVUVHhlSHQwUnAxSzBG?=
 =?utf-8?B?NVZid2NOOHMzZHdJbTJYdjVxQWxaY3BwakRvcjBzYWJtMzJxVHN4dHMrV3l4?=
 =?utf-8?B?SGl0L0U3SmgvdmlaY2NlYjZrUVV5ZWlGZjBheXB6RGlVRTFGb1ZIdW5wUVFF?=
 =?utf-8?B?WGNYNXpySDZBOTQxcDJIUmZ0MWdqZEd0TWxGMFc4Zi9qTGJsdndPUnY1clZs?=
 =?utf-8?B?NUhOZVpjalV1MkpRRmJnb0JqQjNHVWNmRk9TNDJCWmxFeURQTW9jWW5kTUpR?=
 =?utf-8?B?c2JOVEYyaFVwMHdEYlh6T0FyU21VYmFiWXFjSStoTXBvNENlTGRWbklWTzdF?=
 =?utf-8?B?N2VoWUYvZ3VPeTEvY0tWZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TDNabGxQUzZld2Z3SmkvRWFwZ3dQMi9OcmlXUHRiZWF6VlN2cnBpQ3ZZcmp0?=
 =?utf-8?B?azhOV2t3WDdxaTZGaFdwYWZIOXZxbWpySWtiaWxIMlJUNjBkZUJEU2xzSlZs?=
 =?utf-8?B?ZzhDYS9JOFZ6L0FKL1lqYjROS2txcWMvR01xTk1QR3ZpTnJNWWNGVEFPYkFG?=
 =?utf-8?B?c1VqOFFUNlJRQlM2ZXJwLzRBbW01UzcrbHNmaHkzczNieVR4MjVqSjJrdmlw?=
 =?utf-8?B?cFdDN2ZVTVEwdGRrc3Z0NzVRLytvU0Q4bXFJN2xWcFRlSTNPcmhDOWZaWGhN?=
 =?utf-8?B?a01KN0k2WEFjL0wwdzdyVVM4WDRqdjVRZ0x6SkhlVHZERXBxaXg4MmJiWTBq?=
 =?utf-8?B?VWl1dm9VVjFUbzEwaHpjVS9wR0k2YVo3QzFidGxqcVdCSnRWdzc1K1I1ZWNG?=
 =?utf-8?B?YzFMQjBUSk9VSURDNGxQbVFCMjRtNHBXWG13N29UcEpGa2ZReEdJcmJpemZh?=
 =?utf-8?B?WWtYTXlsQ0tRcFRxSHQzNnJock9TVXN3eVBYNEEzQnpzQmp4ZE56dk5IVGpl?=
 =?utf-8?B?RUZ3TjFYR0Y0MGJiaU1uaFA5dys3WEszWWtwZWVMZXF5MEJCRWw0c3dZTVAx?=
 =?utf-8?B?dGpySlM2WXFRTXRoYWRqOVU3S0g5aWNSdk9JL21rUE9PaEk5eE41OXp0SFRp?=
 =?utf-8?B?dWFrWFRFK09Ya281U1Nvd2VaWWQvWloxUExUd204bytvNzVNVXJrMUJ4MFlu?=
 =?utf-8?B?TzQ5Q1YyT2dDcUVoYmp3eUtTeUdrb3R2L25IV0cyS29VOEVBUld1L00rN2Fq?=
 =?utf-8?B?akx1clFYZXhkaFQxeWlDYXdoNUJ3eTE1NFlJSjZwZDF6OWZVQld5dk9XNkFv?=
 =?utf-8?B?ZjA1RnZBd1JXeTl2ZGdNS24xNFgzeUhaVVoySmNmQ1I5Q1RucGJacnpUdXpv?=
 =?utf-8?B?NFMxVDcvQ2RpbkJIVzlSaFpwMzI4NXJ0M0lvTUxwRnRsbXQzK2lBVHVidDRK?=
 =?utf-8?B?R2l4Z2Y4aUNOSC9oTHFyN2F6aVdBRXNYOG9jaHhYU202U3crbTBwL3lVK1Vj?=
 =?utf-8?B?U3drNno0clNmZ3U1Q041bHZxREowU2xTakFYSzVGcDNHcnVTN0cwYnJyS1Fh?=
 =?utf-8?B?dDRIU1NnY1oyVFRRQU1PZ3lwSDNBRTVQSlBrRzl2ckI0UFVpaEpyVFBJT0h4?=
 =?utf-8?B?VHlCSCtHWDF2cUJiUTdlYmdHeVh1R0RGM3FqN1l0UHJ4dmo0MGViUnRYMERj?=
 =?utf-8?B?dUxLYnMzcEhlL0dsL2pSNzQ3STZvaVRPYmYreFpXUHNKcVQ1aGk3NXRiUkM2?=
 =?utf-8?B?TEUyZzhtTUFncXI3OE5XVm5BdDhaaE9NT1lmM0FESCtKQzlHamZSUFRlcTlM?=
 =?utf-8?B?b1JJaHFzMDhCRzFScWhhZDBFd01jc0p2VE5vRGlObnBmb2FCREFyck1ic2Ra?=
 =?utf-8?B?emRmbDRaTjZQTThLQ3NsYUtIWDZoTlU1ZG16dU16S1h3a3BkdGVKc24zSjNI?=
 =?utf-8?B?R1ZsN04xbERBMDA0NE1lVXhHcVRkYnJZRmY4ZHpHeElsSjVQTW1pL014V0Vl?=
 =?utf-8?B?d1RjOFl1QUcyYWoxVUx4SUJSWUFObWRPR3hpMlkxVW9uVGVWM2UvWEVTZ2Vj?=
 =?utf-8?B?Ky9VaEpzLzNDVmYzWFUvVFZMcDNZMkk2dTRhb21qYzV1emltUGRvTkF4TGlZ?=
 =?utf-8?B?RldseHdCcjFLektRZ3l4Z3U5ZEptVlJEMTlIVnRmOTR0eUZrQ3pZeHBKek9B?=
 =?utf-8?B?OFlSakhHeERzaWhlNnVWZUpnQmZPSy9yL0JMSUVTcjBwYjdaUm1ObHU0amV1?=
 =?utf-8?B?czJ6NFhaT0w0Y1VYOEoyVUthc09qaHhBSHZOQk1xcW5pbmZaenkrMGgxUDBI?=
 =?utf-8?B?dFQ4UTdsMlNIMU5YSGkyQS9kUUxiU2svUzdONitFQmxnVlhkUEJveXpOamZh?=
 =?utf-8?B?TzhjeTVVdFlHR3dUQlpEQTN4OGpUVjdmWndVY2pwUkt2TUtnRzJIeFlRYXNr?=
 =?utf-8?B?eHFCRXBmeFRER3NRYXd2WHhGVUs3dGdJR1RCc25LY29ZRmhhSzF4enFyd1d6?=
 =?utf-8?B?a2RiMUtIVTRKTGJwaUlucDdOem9VWEJpcXJqU3BRaVEzdVVBRklMRnVTMDdD?=
 =?utf-8?B?UkpsbHVGVEh0dVVoZnJpVjZyaGJJb24vVVNIRFpXaFVNbFBzUHdyVWwxTmVa?=
 =?utf-8?B?MTkzVmpGWi92T2xjRFZOanJ3RGRhRDh3bFZKT2MySTVEYmFUT3c5dHFPczgr?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42FB8055BB10F247915B11265419E5F4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Hq1/9Zpe7myyFMgPRcHwLHAxwjofJGGeRmKvsfTrFYxtet8Pfrd4bNzE6Lc2pRirAv4jtWw5hxm2L5DbOS3QbkWV2T34m6unkQbyRmHkWTP3i6o9oV75Lw7c2B/k/zMJKMAWG8dYUEKGMvQhEf0fe8F5WjaZvKE/iopdAzEOTgTvR71RFN7u+YCmQk+bU3jfxkxC7cI3On+imes9QyZDCCReVaSf6/q693rgGdF2HbxptryGl91+GzR3tmFR9Laib71HV7nGdf0oPHjkBiRz/Sp7G+vhppOPqd8Fw+WqUDWt3/mddjlionVjA4/LCnkka7VzqXLbm881hQ65VcN7YWXCBEGI22+7cHsAKZvWmKfru7PbnGeH4MgGPuUWDlW4NW1u+9S8J/Q4y6kOz2QF+7RWEONZxGh2Ht+wmEvTLC3TTEYkeFbOzruDSMbsco9nrNpFzmbqHirk7ODp0SxqzpQCWsL7WClvuhVbfR/xiTTK/B2cqwDIScNsCJcm6oGy634XWj2lODi18rHu0NgA5x5TIUCOT8FVBYMw2SAoXTdoK7KxSuEm8+JhJQiU7eT0nyya4MTvZg0YV5R3ePV9vKyaZnNThLxmnN++F+HdG/TxuUt3dxJdKdyaYMD0MwtY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b145ad-4dbc-4a44-b315-08dc72a6217e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2024 17:08:23.1237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eM/Nwxk1n7g78nf0fJtli+UPCFqHBpGAB1WOE3hH2+J1hfnPe9JJfHXnbTeGpmwadxMBm/7jx4ySu0KgHzGSPnIyiXUgcKvNgWOGuUEb9lY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8897

V2h5IGRvIHdlIGV2ZW4gbmVlZCB0aGlzIHBhdGNoIGluIHRoZSBmaXJzdCBwbGFjZSwgd2hlbiB3
ZSdyZSBiYXNpY2FsbHkgDQpyZXZlcnRpbmcgaXQgYWdhaW4gaW4gUGF0Y2ggNC82Pw0K

