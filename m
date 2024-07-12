Return-Path: <linux-btrfs+bounces-6411-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2186092F599
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 08:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422241C20DFD
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 06:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968EF13D601;
	Fri, 12 Jul 2024 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HcNlgDQm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="a7sNlt+O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C842D567D;
	Fri, 12 Jul 2024 06:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720766046; cv=fail; b=KVRgwTzawxDewVMJzTM1xGFLG7qnUSSMPe18BC9KqAI63ztZ40mI+sKDO4j6tiLpRi1Q8aviqRtfaYHfY+e1+pQNZIKjOLfuVkp1ACmnxtbcUqHb2pBz9RMsKpOL7pBQFd9QUnJET4sZqPTwpoL4ItWZn5gXhxRlHsEQ+WTbNuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720766046; c=relaxed/simple;
	bh=psA6pN5YveiHzjSoX6mkb/qjPEFpILLaRHhH95kVGzE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CWQ+CwXW84YtJjme7TtiG1n/wChCvWbkpHvyaLjJ1v7lKri4aoByESOAxrL+H31LE1TV6T7M/kcry/sDRSjQ+e+SJixFGbg11MQIbROOOapmut+MkQzOYOhreL3cLx2IZwHN6uUa+9XjoBrVIyH1t1CjPu1WgpJOg/p5SRBdttc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HcNlgDQm; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=a7sNlt+O; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720766045; x=1752302045;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=psA6pN5YveiHzjSoX6mkb/qjPEFpILLaRHhH95kVGzE=;
  b=HcNlgDQmeZiQNTbzthLt0yaNnKKy9qadDo9XHW9Xu2zAkLXB41XdShcx
   zP6WvCOJvishpZZi5sMt1T1iHbLASYOLyFdJObFJIQ3MnJJhNVCpMmlpt
   pU/JaZD/ERGbGMrOSEHa7BPzumMLcgnkJgUQF+fbxRRFv7zU8z8gnlkau
   7Xm/Q6FvuyvwAiGQM7rn8dDHcoiiu4wFgwqlRKRUC+txZNT5Zzil+oBLZ
   u6HI7t53EE0n+6qtd9pWJCEEX0gFnErBj1zAdw8tWGmtfNYVet8AzZH75
   SrgFvfDzZDktykYLu3Q8W/HEK/lgRza91M+QAwzneQ8Ma0Qxv7kgFOupW
   w==;
X-CSE-ConnectionGUID: qPM4D4twS0WZDen2in69jw==
X-CSE-MsgGUID: rgiDCeIMTLu0Gb3dgEKSuw==
X-IronPort-AV: E=Sophos;i="6.09,202,1716220800"; 
   d="scan'208";a="21187706"
Received: from mail-westusazlp17010001.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.1])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2024 14:34:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGEMF6IrW/vfX5uQR780F5iM4Se7wqHBtxkxyk0M9Ibowp1sMLPlKhT8uqHy1AWpomGqg6WUpVEEBZSGYYwzdNJiQ61IA/N8hMvTQOT3q2wHHetfputsj+Lis23Sm+KhZzFBDJeY3xomSG3JJ0S4vZAMK+k7jmjoTdOCsjZ+p9swGdVefee6UoWd0GVCzOwT7/ApSPuK66thQNAZBf1gulIk6eeSxs3ged9yY14j1Q60PRdWzhe2EgJpaAAE2dLQJQ6IPFOm9GtiWwmhS6QziOzxFY8jA9R8EJLW2Gc2044nMzYnWGGVwaMZxlSMJiPrRYhJHGH8dbOUpctdDPo8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psA6pN5YveiHzjSoX6mkb/qjPEFpILLaRHhH95kVGzE=;
 b=xwRly0ACJqypP15pBr30E2QGW+Gkv1MuaUrggN2YhsTAotGouWl3W6k5NfjjyWpzd+huB6w7cDfK7SkzMu3ZSvshnrKmd8WvuW93qR8ZA2hQUzXqEWhSU9wSIgF63WJwqB4gKXaQ7P15p6xtz3gjKU6g700cJ9M33qhOEKxsEDGX7hrZwbl8IFJ+0QSk1fyURX0vVe3Sa9P8zfjO2HudGj/MAsSGdjfymbuACergtaktlQrOrsAwoVrmCmtLmyH6blMYJC7Fpa4FMCpZ+i+NbAkoWLufM4Zyrwrpq3UmXMQWodP5rVRQXCJkrdeueje329afOvDVdYa0iRiDudVGYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psA6pN5YveiHzjSoX6mkb/qjPEFpILLaRHhH95kVGzE=;
 b=a7sNlt+OksXCsqhIk8jsF/AtoeCqq7irWs8/uwl0Mglp5480RnML6Vf0XSpfd0pItbpR6LwDZnRo3bSFbP6EY5etPrBHqhX35jdWsTs2gJmYRqZi5dEEt330BGuwXKJLmlfnXSSLQG2L2qSQpDHB56OuW/OaiQ4cPjgojUWyBPQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA6PR04MB9517.namprd04.prod.outlook.com (2603:10b6:806:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Fri, 12 Jul
 2024 06:34:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 06:34:01 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Qu Wenru <wqu@suse.com>, Filipe Manana
	<fdmanana@suse.com>
Subject: Re: [PATCH v2 2/3] btrfs: replace stripe extents
Thread-Topic: [PATCH v2 2/3] btrfs: replace stripe extents
Thread-Index: AQHa01qdWrT6vB/Vy0qi6q9jhj3BvLHxJ38AgAF8woA=
Date: Fri, 12 Jul 2024 06:34:01 +0000
Message-ID: <c96b2203-feae-41ed-a9ec-f55597db591a@wdc.com>
References: <20240711-b4-rst-updates-v2-0-d7b8113d88b7@kernel.org>
 <20240711-b4-rst-updates-v2-2-d7b8113d88b7@kernel.org>
 <7vy733sr4wok7pj7lpsvks3kf4jkrujycia4cnp3oh7f6nu5s4@22cba7ceiawz>
In-Reply-To: <7vy733sr4wok7pj7lpsvks3kf4jkrujycia4cnp3oh7f6nu5s4@22cba7ceiawz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA6PR04MB9517:EE_
x-ms-office365-filtering-correlation-id: 4cbf3f9a-87ea-46fc-3baa-08dca23c9e70
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1dmRGMxdTAvV21vekRCa0Z0b3ArUTY5TjFLL3dhT0EwaFlxeU5FeGVhRnNx?=
 =?utf-8?B?dkxkcnE0bm8zSWxPT09WeDZudEg0Y0xhMWpnMjJMSURreUJXM1NpdEdMVm1M?=
 =?utf-8?B?WExmRUs4UExhVlZ4RUc4akw5cFJQRjF1eEQvdWs2T1kwQmRhc0FxbkROc05R?=
 =?utf-8?B?eCtwMGw3UjVjZ0JYYzlJZC9WTDZNRlpZTlhySG12dDFuZ1BUdk9wMGpYZFB1?=
 =?utf-8?B?bnk2QnoyMXNZYmd0RzFuaTF6c2E4bmdNaHVpc1VjaFpTU1dPUXl6RytxcUxH?=
 =?utf-8?B?MURkd0ZsNHRKTWgrYktpdDVDTnRCaHFGYkM4aVZ0TWExQUNQUzluMDN3WVdM?=
 =?utf-8?B?NGM5K1BhTlgyZnk5cWZzRzBWbCtCTzVWSUQ1b0FkalFKOXhUWTdOVzFIUk1D?=
 =?utf-8?B?UjJiZEIxa3doSkdpdk4zREYzOWxVd2d5WnB5Q1dXTzRnTWtNRHJlNFYxNTgr?=
 =?utf-8?B?RmczTnYwUHFrTUFXMlZadlV1b0xtU25QTjdTTUtpWXl6WXdOeC9vQ1dqdnk4?=
 =?utf-8?B?cmVMbEVFUWo4djdIaXViS0IyTFE4VWZNdzJNMUE2UGliTHl1Tm9mbDU4UnpS?=
 =?utf-8?B?cll0aWNhN3R1Vmh6N0RGemFPSGdDRnlLQVB0ejJ3Y3ZMS3hwektlcGxteTZy?=
 =?utf-8?B?MTBMMU1ONGdjZGN0dk5USWhOaDFrUXhVZGZxUWVCT2FEUVVkckd3a1NUOFRv?=
 =?utf-8?B?UXM2bXlTMi9oa1c1WjN3Z2dVbW9pU2RIeGxIdFdPdmhpd0FGVGo2VzVYbzhn?=
 =?utf-8?B?ZWMvNkZqY0ZyaEtOVXhKV3A4MU1wNTFVSTI1amoxeFQvVFZ6M2RFVzF5bjJu?=
 =?utf-8?B?NTVGOUw4UUZFRllETWRBUHhYUzloWnZ2NXlyaml6YzNKWXk4bVpXUEg4dytB?=
 =?utf-8?B?VXZONng2cEo1dFdUVytNQXdva2NNOXo4dHNhY2tCMmpOaVFLQlRMcC9YbjQr?=
 =?utf-8?B?Wmd2WWtzYmszdndSVW9pTHdnYmkwL3lVWmNJcG9NWVZKUXE1VTQ4dnVZZnZy?=
 =?utf-8?B?OFVjNE5ncTFncXZsa1VyendrT01TYU1ZYjFzSThPRWp3UGMrNHRncGhFVVhK?=
 =?utf-8?B?THRENitsT3drZTBGVGJPM1A2MTVYT3dSZkpIMng0Ujl0bXM2Mlc4QnY4YUZK?=
 =?utf-8?B?dG8vYmx2REh5ajh5Wi9tM2FRd2gvTDZMWlY1NVc5eW1DWjcyYjYxSGF6bk9H?=
 =?utf-8?B?QUJuNzNsTjJLK0RiOHlBTzdvRmtDYWd2cmR1ZE5paDcwRnJyZS9yNHBZb1Rt?=
 =?utf-8?B?SXQwRGFpbHBvNDNoK1RZbWROYWdFS0RWeDhVVk5PbHRtc2Z2SnpWZEF4MVI4?=
 =?utf-8?B?K2pIQTFzdDl5ZHc3aFZDUGJCOGZUM2dnclU1M1BiVVBzWWpiSHNUdDdLOTA5?=
 =?utf-8?B?QlIzMjh3TlFhYm1PWUNxeVNZRU93MjZsZXd5M3dEa3NBM0JCRTJQdUdsM3BZ?=
 =?utf-8?B?a0dUR0MvTWdDYUhvejAxbHNRTC8vNjhXbCs3THp0dmVPOHUyMmg2MTQrV2tQ?=
 =?utf-8?B?a05lU0lLaVVVL0I1MHFSeEZIM3pZTzNMdkFTT3pJSXVWTzY1Ukt6bkp6RkFV?=
 =?utf-8?B?WnY5bVBIenRYblpIS0FlazNZU0FNMUhwL3hPUFVWSHRTVVpVNEhiZHUyRlF3?=
 =?utf-8?B?cncxSmgvN1J0SXBlUmVWTUdFRzB3MVhIN1IxY3pmcHNhNTIxd3gzSi84RmRD?=
 =?utf-8?B?RFdTNUZEZkZwcU9IYVVvdlRiSXQ4cCtxNDBHdTBoTlF5cWVORE55bE5TNTN3?=
 =?utf-8?B?SENVWlh3anF5b1orajlUcmlXaFl3akIvb1I2bWRYbEdUVzZFSTlnbHpYQkRY?=
 =?utf-8?B?WTE5VHNJQ0QxdUZ6R05hbWxqK1N6QWFNZHM1Vkl2UWVQaDREeU1iS29hVExh?=
 =?utf-8?B?MUw1RWZPYUZGUytNR2VmL0FPVGhob3ZIUFlDWVJGU25pTXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OHhmaW1EcDFxMnlpNk4ybTluQ3U0ajZRUEM5UnVqdmtpZUU2ajc1cmM2bHl5?=
 =?utf-8?B?VVFRekdpaDdNczBNWUxDaEZjMlFMcStGZ3ZRVmgrRzlycG9TWDVzZS9CZ0FX?=
 =?utf-8?B?U2pHNnJQbG5TWEhmODduR29QUkJFbUR4RXJYdXV3cExCalBoR0xwWk5qMVd0?=
 =?utf-8?B?VWl4bFVQOG0vczRvMkx2RG5lS2k0bmtZdlk5cHNtSnVuOVB4bEtsa3o4ZWFW?=
 =?utf-8?B?eG95eW9icGxWRFk5U2w3OFFGQ0xaOE85Tk43dWcvUlF4NEUyODFiNUFTRDlo?=
 =?utf-8?B?SXVwQytlVURxY1hqUVVOWTNESTdNY1Vab2VjTDlUNVd1YkxsWDhFK2loZWs2?=
 =?utf-8?B?NVRjbWEyM21UbWdWVE42TVYvbjRLamFUZUNVM01LdjhySFdkMmVpaWY4WlBa?=
 =?utf-8?B?UW8xSWJDcXJyV3VnMlZoVmtubms0amlyM0dhazFNT0tRZ3VPaGpXcGNsMjRs?=
 =?utf-8?B?QTI4VGg0U1VuaDhBQnNHQjFKYlBVOTB2RGpLS21jRTNHUHE1aWNlcFlkS3Vt?=
 =?utf-8?B?c3cvVUs5bVN4N1RTR1VFdjhyTkZMRW5oVmdKajdHSDY3MTdhTTViclY2RHBr?=
 =?utf-8?B?SHRoYjZSODEvS1RYSFMwNVUxeWZOS0k3aER3SjZrUXpiQkl5N2cyZHdlclJJ?=
 =?utf-8?B?U1UrdTluWjlJK2EzaUFLbzBzd3hLR0NTS0JJNFlGL0U1NXF5TnQwc3M0KzF1?=
 =?utf-8?B?SEpLZTg3citWTExWNmJEMGY4OWNpMm1iOFUvaXl5UFlZcnE3dE8rTmxvaHJS?=
 =?utf-8?B?VHYzL2xSczNxN0VTWWRueGZjUHdLODJFRlRaSmd2cUFjQTYxZUdmNk45blNj?=
 =?utf-8?B?WlFqQ3E0c2NFZXA4UWdMNkJTZnRST1A0MXZPUXMzZ2J6bGRncEVBeWhyZ3Fz?=
 =?utf-8?B?TnRkRGtFaEFJMk8raWZ6YVRnRDYvVmlHZEREcExVWTZiVUtaUzkxODVVdlZu?=
 =?utf-8?B?dklzN2YxY3lQbEN2MU5LRVF3dTJkQzFNRTd3Ukc1S29jMVd6ZUxEUmV6YkRj?=
 =?utf-8?B?c1EyWEtJS2t0Yzgrekl1ZlVLajIyQnp5RUlDT1B4QzMyMUlQcCtGaENCb283?=
 =?utf-8?B?R05zNS90K1FkUDVvOENUUmZJTHlRc2hLUlFlRThnRk5La1pmYWk4cFNWZWRI?=
 =?utf-8?B?WjhoTmdsaWl5RkxLcHJNalU5K0k0SlFVY0JWc1lZZGVxS2VuTitET3VGRlRh?=
 =?utf-8?B?M3prTnB1Y2s5bGhPWlNYYlliM1Q2Q2o3MnNiRlc1eG85a0swMUhyNHl1Wlkx?=
 =?utf-8?B?ZzBjcTZieXBGUXhXZVpvdjF1bmNEQjZVVVNCek4raDVaYnVGcktxTS9IMERz?=
 =?utf-8?B?WlVlblV5ZWc4S0hIWHFNTHJYanBBMXA4RjNuVUpLdWRtOXhWQkhvZkRPNE9j?=
 =?utf-8?B?a1Z0T3BQaGY5MnZyYVJiQUw0Y0JyaFZyaytJM1ZiYU0xYUhDRWdaVzVvM0RD?=
 =?utf-8?B?M2pmSVVmL3N1WEJnU2d5RmEzamUxRlppZndIRUxZSDBXemhNN00wRXY3QWEv?=
 =?utf-8?B?R1VHTUtwckJrWnQrMEpZc09vSlZWR2kxSjVRaWF3VTBXcjNrUENpdzBZWnN6?=
 =?utf-8?B?T05HWHNldDFhNUJSVlV5UysveWNJNFJRM2hDUTNOUXVuSWV0ZmN3eXVyMWtJ?=
 =?utf-8?B?SWk2WnFOTVNJcGI1L3hyZlBpSG9OdVdaUVhuVFVtbG9adnFwMXAwdy9SaEo5?=
 =?utf-8?B?cFpnTWtBSWEvYUxyZ0pjMkpFazF4TjJRZWpsY2M1bnFvQTIxRUdXdkRJVC9B?=
 =?utf-8?B?UnIwUlJzZk5kSXFieHc1Y1JLek1aQzBsbmVPK0x6VW5KQm9yMGpmZldXWmhr?=
 =?utf-8?B?SXg1TFVNL3h3OXFQWVR1bXMrdUxRZTJGY1RnaTBQRksrdFNsanBxam5vdWgv?=
 =?utf-8?B?R0ZMZ3NLR2Q0SDBNaUs3aW83MGFZclIyR1RMWnFPZ05zSVN1a0pwT3NSUjFX?=
 =?utf-8?B?Rkt6cndwSzYwQXhVM3ljQ1d2ZnQ3VmUrRlBpRGI3QVh2ajB0aW1wT0FJcXds?=
 =?utf-8?B?RE1pQWt6NS9XUGZUYnlxTm5XeVhVWm1yQVdrTU1ueXVkY3U5Vk5BZkRHOSt4?=
 =?utf-8?B?REpicFIxUjdRRDdtTi9Zb2ZoeWxWOTFCM2wyR2NuMEJoMTlWQ2YxdzJ5Mk1W?=
 =?utf-8?B?WlQ0WG5uelJNTldrNllvS3kwVDhCTG40cTlkZDZ4THRFZHRVUlJ4MG1ndTYy?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53A86B419788AF4FAA17FF84295D6529@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yPsP5T3+6YkEcQFeYAo+7pr/WmAJ2SfhCAYZ2daPcd8x0xTkMJIJu73SGcGeUAKSM1AwVNqBqtdu3xVKthDpUigNRrXGjKn73P7flhDJdp/ONxmYAUietZt0qHhOWVEDwDq+g4cN9SOUgVYFYTGn8dYTFLz4+rzWp21NILiLICe8JkVWzpw4I8UEItQW6onadaUNFhonLBBX3wnzehbm7bDPm+m0CDTSIhkfm8GCz6nyvdYjM/iDrTyOVSPJ8LLGRHGyS2bMOjX8P3PPaLP6bEgTeC+CveMoExn7qDuTI58f9foGvlJTpY66GYACGgGPFWMWuNNEg0lsI2PCYACv8V6JqQoj64SlXTPFBbY3FPY96943wMnnYxjSac0EAUvWOypM+LDIua1N5+hFSsQojG5El06OTknmwzMdCXcBYOvV2ZB1GGK3cN0tnNunmG9PpEMJ16yJDq93DGEGEtvYhTsHp0X/xecWjyCywjE2GIoqBpouzsSLL5E4EqMLqZM8JMHc1mo2w0CJM0hp1xwg56L3Ki7SPxrncF2k3tDTGwoNEzvnb/Xf2HC1H5kIqGjA2T8e7ZEqgA4PijXA6/HbrXYxskjL3GONPTi0H9/bKsKpql6hhzN63/Glsa38M1Yl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbf3f9a-87ea-46fc-3baa-08dca23c9e70
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 06:34:01.9421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IW+Y1sGNYRYyNg4dnLY0FsnguYEFruM9d/ge/ggqYGo2S2jd9q2Tg0XqeBpPtvyhhmFnnD+aQSn6JmLnt79aldnRREbjJvMBJgL20wNnNp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9517

T24gMTEuMDcuMjQgMDk6NTEsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gQ2FuIHdlIHRha2UgdGhl
ICJzdHJpcGVfZXh0ZW50IiBhbmQgaXRlbV9zaXplIGFuZCB1c2Ugd3JpdGVfZXh0ZW50X2J1ZmZl
cigpDQo+IHRvIG92ZXJ3cml0ZSB0aGUgaXRlbSBoZXJlPyBUaGVuLCB3ZSBkb24ndCBuZWVkIGR1
cGxpY2F0ZWQgY29kZS4NCg0KVGhpcyBjb3VsZCBpbmRlZWQgd29yaywgbGV0IG1lIGdpdmUgaXQg
YSB0cnkuDQo=

