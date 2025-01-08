Return-Path: <linux-btrfs+bounces-10795-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A64EFA0645E
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 19:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7DA3A6C72
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 18:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5089C201002;
	Wed,  8 Jan 2025 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fd40+Y/T";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rG96DbBx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645E7146D57;
	Wed,  8 Jan 2025 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361037; cv=fail; b=VL0QuyDdYXLkYcIH7AkFltMMDaKCUQRPNDsCKosH2u1+Uh9pbbe2f0IG2pv+YWxTRi7VcW5HRpvsU5sLHpVkLxMbJUNo7Cr/WhyDVdtaSxGbh68Nz90w8KbQ6RLDhvl5tlx2wqTgcN3KAbEsBmYja9v6hPTwfM1p4jn/84Nq2GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361037; c=relaxed/simple;
	bh=5Z4hI+pMWviIGkVe9PRf/gpVm8eEbSwISDYuxjCMtDM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bQG1MtOkpX4toUVmXCjoUzf5w2kuy2kTtEyki9xYTc3zlOejlaqUvqecWHQYTqnFLqLQkjHxrpUaXHHbAEM21p8TOOjRu9/7+foy8OzLJw6d7ouygoJCQhjO89uJsE8WTDls4mKkEx4E58Nl33vYrjVxyYsPTlXIMBybU9sIFfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fd40+Y/T; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rG96DbBx; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736361035; x=1767897035;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5Z4hI+pMWviIGkVe9PRf/gpVm8eEbSwISDYuxjCMtDM=;
  b=fd40+Y/TVgGtE9oQ8CWsoKn/LlDvcOsNlxbl09TW7bCM9CnzMYHPJIq+
   GfK/oKAVsE575opUufL6Uuq6BwdiED785t2IPUfAEKaNXumZFXt94OZXP
   tIFxA5rYGdnDswLWpPQmkNEyGw/g6EfrQgNfytM9uq46G69Y4eRePNOOC
   UXu7xtfFn+FHx8Zkux01A4FcULkQUbjac5ufC6KPSg271fJRyPO7oY+gS
   9rDvZIbkOArIeAJFIbKIa4LZLA6Hx5Ca/5QT5oPPz5RNcHOVqnyWqGh/f
   2Lrh1UGfP8tDPOxUH3ju5sKIezQVS55bVF0XDVgmZrNR9Y/q/P/+Em68y
   A==;
X-CSE-ConnectionGUID: m+pp6kwhQ/SwvqZiAzl8Rg==
X-CSE-MsgGUID: yyYVkv1aTOyCaf9TxlP3+w==
X-IronPort-AV: E=Sophos;i="6.12,299,1728921600"; 
   d="scan'208";a="34826822"
Received: from mail-dm6nam10lp2049.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.49])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2025 02:29:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wz/qea2Mvoi0KiePS8ZC0kQRA5fxHg4ENxcJ9H9iW+87SxjcXdIZOAKkGpLAtQuTpGLF5+aFueOVnxpnNgpXlKElddtM7jVhAv922D+NVV8Xzl1iPqSqTauzGcq1SdQs9vOINcW0WPURi3X4OfyLASFSdSXXCvPW7qUu4A/TrisxkZQ9OcewfjwLfaf2i4/GgKdGKf/ivyjlvJF6xBqZlSHijDBT8ppdNVxwmyWXGCYrNlOtpjxqV/Vpw1WR79v5Bj6OJYTou3KpL8GS87L9d4JnpEFCATWQlym4HjPwy4vhhyGopMLvNAgnOYgVpI4zjO6e+z+hG4GU2sndBoIo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z4hI+pMWviIGkVe9PRf/gpVm8eEbSwISDYuxjCMtDM=;
 b=uSJg+Avi0buJ9uZxhEgU3m6bFhhwkfXPoHigMWqUdHqO8rMJ4oOmHbfXgfmZPfka3pXYzJFJGVl0g/3BSEqUIC1BqyfD8fM5CenYRzhxdQwJw2YBPMSzGH4z2VmGKazMm0fWlGRzA9Hw8CKbiK6GZYYJU7ZsiEjnDSN8rvkrzXpqOWFYvHPHtaCrIrZ0UP2r6SiWiDk9dwjA49km+CXfx/pJ1yawAkC2nYtkCZJ39N07pvDq71ghOcHRkL14VeMmRZCIUMVGoed1zA3M+TLc5ErgLwSGP76JIEvGDEUZMr7GYsH+0Y5KNXfZDCBYsUafuQq7Sjfvi/N8T6pJuSVGmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z4hI+pMWviIGkVe9PRf/gpVm8eEbSwISDYuxjCMtDM=;
 b=rG96DbBxLImqmP8NZHRZCsK40/UYpKgB0zUI6AW0r5MGqqnXOLSdMkJVqG4hNG43fnghavAPHPV/8t1qP+XpzTaSBInSxbUG/K28LTzOg7bsWuAeX/OTEqdjcqkUJRjEsc/tSJeBvd3VulSwdjDNyQbvHBEjiEJnNnpaRSf1f/Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO1PR04MB8299.namprd04.prod.outlook.com (2603:10b6:303:156::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 8 Jan
 2025 18:29:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8293.020; Wed, 8 Jan 2025
 18:29:24 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Daniel Vacek <neelx@suse.com>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: keep `priv` struct on stack for sync reads in
 `btrfs_encoded_read_regular_fill_pages()`
Thread-Topic: [PATCH] btrfs: keep `priv` struct on stack for sync reads in
 `btrfs_encoded_read_regular_fill_pages()`
Thread-Index: AQHbYcKvsL66shJuj0GP7Xf11s6QnrMM0gAAgAAtQICAADO1gA==
Date: Wed, 8 Jan 2025 18:29:24 +0000
Message-ID: <c51c6cc1-4bc5-48d0-adce-a8d8d63227ce@wdc.com>
References: <20250108114326.1729250-1-neelx@suse.com>
 <9cca57da-3361-470d-83e5-0d78deffb673@wdc.com>
 <CAPjX3Feomu-=eBot9WRf3k3U+4BmbA0szH8cKHF6GdbKRBNZ1w@mail.gmail.com>
In-Reply-To:
 <CAPjX3Feomu-=eBot9WRf3k3U+4BmbA0szH8cKHF6GdbKRBNZ1w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO1PR04MB8299:EE_
x-ms-office365-filtering-correlation-id: 445cc437-9eaa-4f0c-d7cc-08dd30126079
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QkJHb2ZuZjRWelhDZDR4SW9oSlN0L1VOZG4yRHlYZHAyNlB3WmNPS1p1dFFT?=
 =?utf-8?B?Y3JNaXhVMTNUZnhJUzZxWVZkSTNIRm5FRjhnVXRtNCtKY0lmWDJGbzNQanFM?=
 =?utf-8?B?QVNBeDJFU2dpcnZGbkprdE1vMm1RS0VMU1dIMFhsKzlHV09vZ1k3cGtHaFlF?=
 =?utf-8?B?ODRnRVBXcXFCVjZ2eWpYNXpOWHQrRjdLMERQYzZhemo2NXMzYmRBcU85T2k1?=
 =?utf-8?B?MldWOGJtc3NudmhmU0hLSFk4ZjZvYzJwVFFSVkJYWCtpZGpkYVRuQUNIVk5J?=
 =?utf-8?B?UWVybk40bHg3L1YwS3d3dTBQVUFLam0yM0lHN3BkcEh6aUx1RTRqNVZON1Rm?=
 =?utf-8?B?SEJKb28zcmlWNEVlZkZHLzUzb3AyTTYreGJrcFd0clJ3UUVuYkRrcDZXR2tH?=
 =?utf-8?B?SlNjbXJGQWo5eldFYlJuZXJoaDVLY1hLSFdSb3J6Q0diUzMvN0l5VTN2VmFi?=
 =?utf-8?B?NlNnOFoxeXNVU1lScS8wbjh6TzBlZ2QxZDhwZU5FMjRuVWFZQXpvOXdCeWRL?=
 =?utf-8?B?ODlVY1VSUWxhekYvVjE0SGNobUREL0plWGtaN3JHQk5mODJMUjFzSERWNTJH?=
 =?utf-8?B?N3pFbGp1V1dncEt4aEoxTjcyS3dEek50Y2phcTkxZ3F0R1V5STR6L2RNei9Q?=
 =?utf-8?B?aUZYUHVZZ1E5UUFGRnoxamtsdmkvMUUzTkN3clRSYkR1M0JqcExxbmJhOGt0?=
 =?utf-8?B?MW9CY21Qa1dmNkJiL2FCTUNoR2dZdkhnNnR1MUltSjJRMVNMdFA1VHUramtI?=
 =?utf-8?B?K2NSWWdiOHMzMmVHUlZuZDNOcXBVLzRzT0NFVUpIZG1hREJUVldoVlI3ZkdK?=
 =?utf-8?B?c3dvQmNQV3gya3R0Q295VUFJZkZQN0swazM1V3p5VmNMOWtEVWVaMjczcDFi?=
 =?utf-8?B?QUxFeFlpK2xvNGtrRnI1Wk9GWUliYjZIa3dsYU1aYTZPTUw2S1hGQW5ZRDJ6?=
 =?utf-8?B?dExmUmYzMll2ZkdTRE9JSFNvbHhWVm1qQVhmMFRJcWFINUtNWm1YbWJWMk9a?=
 =?utf-8?B?OWFreStvdGJ1TXBuNkZRdEZ4ajNseU9kdjdUOTFWR3BVUm5hcS9HVGRVSnkv?=
 =?utf-8?B?c3ZmZHpvRTRsdzNrTENMY09rRXFDMmNBdVNDaVZ2ZFU4dnlmc2pobzZOWWIw?=
 =?utf-8?B?d0Z2aDlQOTlycy9CY1lrTWkxR3NvNGk5QnB5MlBvTHIwMkxXS083MmRsTVJ1?=
 =?utf-8?B?cmUzK28rT3BtaWVRNXdyaXdrQXp6OUNKc1dXZUlrYnUyaFM2RDF4ZFRhdTZr?=
 =?utf-8?B?OEJLRmxvdHAycW5adm5SRGMwMk5pZFdkNDZwVTdFbFQ0Ni9iK2hXcVZHSVlP?=
 =?utf-8?B?Tm5HcjhENmpEQ3QvWHd4NUlSSkFHZ1U2ZElyMU5EY0l0ZDdtcWhROFBZZ3BU?=
 =?utf-8?B?NkI5czlXckZwZGw0NVRtV2tGV21MTkNxbU0yN2pOVTJsZzVLdlNoUGtTWU1Y?=
 =?utf-8?B?dy9ZdzdKNmN6Z29zSHliS0M2VG9DR0RNSHFwc3R6aWszZGl0SUI4Y3JwZjI5?=
 =?utf-8?B?TFNUb2JjYkFJVjI5K2w5ZzNuTVgrRWwyYjYvSjN4RTFjYjY5ZkNBWWgzVkh4?=
 =?utf-8?B?MVpxVGZPTjJUcVFmRHZacTkrRllmLzU0c3N5dXdHeDRSNlV3UGdLWkJvVFln?=
 =?utf-8?B?MklpU2g3Z0RqSmI1NXVISjAvVS95endmUGIycmU5Vm9VSjlpNmpiOVMwS2hZ?=
 =?utf-8?B?ZFFKeDNOMFF6YVBYK3FZd1AvdVRBTll3TDZ6YzFEaFdDMllpQ2JGSmkvR1ZI?=
 =?utf-8?B?SkVwM0ZTakdGQ3hWYU9sL2ovT216d0k1amZkVGxvZjlpUWRwTUdjUFlxYUcz?=
 =?utf-8?B?Tkl4UExyNmxJN1FSa1J2M2tKdzNZM1JQOTloQlFtSnFSM05PTFJTZXN2Tm9K?=
 =?utf-8?B?NWxDTEhiYStlaHNOZjBDY25ieGxtSGV4QzZYRHk4V3hlZDZEVm5QTnlvMVYy?=
 =?utf-8?Q?IhZooHWe52oqoYC2pUIewahs+34U0BjP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGNlRFF1U0tQblA5UldCR0tHQ3FRYmdnNXZSTmhBWXZ5RnMzSEFHQWFuK25V?=
 =?utf-8?B?MDFPNW9QQ3d6bVMwQVhOUSs4UW9uYys2Wk93U0V1K3c1bzI2WUxWZXZJMVE4?=
 =?utf-8?B?NzBJQVFVeGU2K2xhd1dRY3ZpUEFKeXcyQjdqWi9SakhYd0JCdFM2WUg4Lzhy?=
 =?utf-8?B?ZWoxZE41dHdvRE9oa2Z6NmJ0ZkxnYzB4M1F4M1lzdWcwV3dtWGNHYlppSTVr?=
 =?utf-8?B?ZWt6c0RTTExSUkZtUFh2UExpM21YYVh1N09LK1JJcUxNSUwyQ01hS3RWVkFB?=
 =?utf-8?B?a2dIRmsxYStCOEROVVp0NWVKZExJMjZXRWsvT0Mza1RUd1AwKzdaa2JnN2Qx?=
 =?utf-8?B?UFc0VHpSRmcyZlpydjZtNG5LNU8xellCK0xudnFBZDUwZmQ1R3AvLzJlMElG?=
 =?utf-8?B?WjVYSWo2aERsbzY1SWs5OHFSYlluUS91SWhhY2Z2Mk93Rm5hdWVRR1Vrd1pF?=
 =?utf-8?B?bVN2OUVJRzNkL0E0WnZ3OGt0Q0ErY3VmVzhqYytadEVaeCtRU1ZkOU5TMjFo?=
 =?utf-8?B?Z3lXeVlaSEVJRjVzTHJDbVJFUzB6YjJLQ3JkZGhXRmcycUl1MW1MTlpmYTJ1?=
 =?utf-8?B?U1p5MUh4WUd6QWg5MDhCck8rVk5GWjRuQ3crV3V6WlZscU1iMndtOVh2YWRx?=
 =?utf-8?B?SDk1QnVLL0U5bEJoVFBtWGgybi9FMDNPVFRtQlRVbWZrUHZyZjFWODNOMjVv?=
 =?utf-8?B?SmluWEh0cUF6ZnRjMEdpaVpURXhyWnVVMy8yeTZlMjN4bWhTNDJ0aC9oejhV?=
 =?utf-8?B?Unc5eWs3QWVTb2R1L3Y1TDdzYTNyZ3JOcHZlbFl6aGR2V09SZ2pkRUhGaGFZ?=
 =?utf-8?B?V0lQNVltZVl2UjBxeExLMmkrWkwvemE5SVJYRHFISnpycDdIRFZPM3oxZWxv?=
 =?utf-8?B?M0htczUxVTY3Q0VkTUUvWDU2b09NQTVDL2dsMVBUUlNmWjA1TFRBMG5NbGw5?=
 =?utf-8?B?clNlR09obDlieEg4d1dOc1RJajJLNHlaSndkVDg0TUdsVnpaZEx6L2FaNHdN?=
 =?utf-8?B?citsSDF5RDladEJZenlFSTVnOFVFbmY1UnNZc1QyU1pyTDJ2MDN3dVdHQk1u?=
 =?utf-8?B?SFVXL2ZIOGV2Q21Wc25CYWlQbUg4V0Y2UWdDaUNmbERaNUdicldINVgrQjBW?=
 =?utf-8?B?dEQ5RFVlVENyZW5DZGNZUzNNSTZON0FoSEM4cTFWcm1pekdTbWU2N0JwS252?=
 =?utf-8?B?Ly9DUXRDSTJPdU9Gd1RaOXZzOTNIbEdsVmU3b1BFeVFoSWYydU8xbVBvZWg5?=
 =?utf-8?B?dk1scmFPSkZIaG5iM3BXQlM0aHBQNW5PNXFFQnIrQkxwcjM0V1NtdVoyalhP?=
 =?utf-8?B?ZjBkenNVOEFMS29VWFRRMHc2QWVpQk02TElpYXVMN0hldkdsaktvSGlvYllu?=
 =?utf-8?B?T0l5Q28zckdPVDZ3SWd3SXZnNEJ1Rk5tWEtTTGIyK3dYY0RBK2txd1YzQXcz?=
 =?utf-8?B?cE1SdVJ1L1kzcTNDME42eDZ0VFY1d1RzZmdVVFgrS01NUFIvdnJyTWtocXdO?=
 =?utf-8?B?VThiWjVNTWNEZGF6U2hHQlZvSkhSSG9jRWJOcUduRVVZOVorYzc5eDcxTnY2?=
 =?utf-8?B?cXFBeFBkTUk0d2hMTVRFeXNhSzVzalZmOVRvVHJ2RWJsQU1xMlBlWUZycW12?=
 =?utf-8?B?TllPU2ZCeWRjN2dma1htekhXQ09ObXN6emJJNGY1bkc2ZTVDdDVEdElaUXNo?=
 =?utf-8?B?SEdXZVZoblh4ekNLNDFsalhXVVo1RFZ0T1UxaWZoaGhPQ3ZvMHk0dVh2ZnNs?=
 =?utf-8?B?VytUVUI0dVRZbkJubDU4VFJrazhFK05YUDA3QVBrVkgyNHFvRGZuR2FVMU5V?=
 =?utf-8?B?ekQ1RXZJRXpXdmtBMXF1M0FUdFNpL1pDNFpES0ViWXdWaEZ2MDN4YmZtR3JR?=
 =?utf-8?B?S1dhV2hLL2RiSTVXeEJ0VEtiOXdleEkxWWV6ZENvaUJnR3lCZzJsbWo5ck5u?=
 =?utf-8?B?T2llc1Yvb2M2LzZkWDIrcS9OdVV3UTJROXJQb0RCeTNuWURJSklER0U4bEtl?=
 =?utf-8?B?Q3FqdkdtMmI4bzNlK3FLdVVra0ZRUGtJU2FvUjlwMWQ0a3drUkRac0Vjdm5N?=
 =?utf-8?B?MCs0cm5yeDJhN0ZpZzFHNUtEUGw2aFV2Tko1dWpKdEhvSVF4QVArYm80SmFB?=
 =?utf-8?B?dFp1MkpBSkR0aWJyVWFhalhOdER2bGhnQmpha2J4YitaYWUveTRsT25GMVp2?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB53E8701B683C45BDF2E46736F42DDC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B3hWYwkPXo6/HlZJ349SWAyGInOqBHXFo8e7sml11+1ECrJp9oFmEWZBci/v76tze2Tt+LHpUCLH4UlOiJBqkYc1Kc0J+3+aAoDee5BjHDwJMR0sb8GEr+CteU5NKUk8nrtwkJr+FPWNj1dsCWX3n3AuIXDusRVoS2aSvs9KIPHiPDaYlv9oXCNDxI4gNuu1Y1pjnZaHKBtFFi4BYoEH937GWLuKsrDUtwsrpR6iZ65ny1sGmJTGsPG4PYU/RkWvnCJsO0gpuPHAIfrHkjQYpwkv7F8/+bil+aA40fh5Gv4ReOIEV7eXVr+ThWRjp80Add5cu3OmvW4orPCRPaEMpXU8O9R1jQAthxh6MZDZyz9CltUvs19t7Uft4EPTXKTrNvFtDy0h3UMQPkrX7Snf+4bUjGEXoCNgaEFf8he1BIFGx8JB4ZQLsz3IQditkf7q3Arvw+xgR4x7BrqOVtJEN9j3iP5AiARo1yhx2Wq5niEfpkDozuxE1onXP/uGgptc4kegzP3eMFYKW067Gfa17xFeY5PMG4xBjNPA0CrcRZPrRNrEyQIIzb9aHnqdjyGFkdV31C20YKmrSR3S/RzcFLOWSQ4WXfVElGztmfj9RT++oci15QphvILEzfDKrxcP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445cc437-9eaa-4f0c-d7cc-08dd30126079
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 18:29:24.2160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ahVw/n4Gr9lJMoRzPvuqom6YVGFHbiGP6WOa9mvzBxxhhFb7OLW4a45h8gjMJBqxetM3Z3BQQfSOPOtRbECR2JF1wKPvdw5C9LwNRFVVMNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB8299

T24gMDguMDEuMjUgMTY6MjUsIERhbmllbCBWYWNlayB3cm90ZToNCj4gT24gV2VkLCA4IEphbiAy
MDI1IGF0IDEzOjQyLCBKb2hhbm5lcyBUaHVtc2hpcm4NCj4gPEpvaGFubmVzLlRodW1zaGlybkB3
ZGMuY29tPiB3cm90ZToNCj4+DQo+PiBPbiAwOC4wMS4yNSAxMjo0NCwgRGFuaWVsIFZhY2VrIHdy
b3RlOg0KPj4+IE9ubHkgYWxsb2NhdGUgdGhlIGBwcml2YCBzdHJ1Y3QgZnJvbSBzbGFiIGZvciBh
c3luY2hyb25vdXMgbW9kZS4NCj4+Pg0KPj4+IFRoZXJlJ3Mgbm8gbmVlZCB0byBhbGxvY2F0ZSBh
biBvYmplY3QgZnJvbSBzbGFiIGluIHRoZSBzeW5jaHJvbm91cyBtb2RlLiBJbg0KPj4+IHN1Y2gg
YSBjYXNlIHN0YWNrIGNhbiBiZSBoYXBwaWx5IHVzZWQgYXMgaXQgdXNlZCB0byBiZSBiZWZvcmUg
NjhkM2IyN2UwNWM3DQo+Pj4gKCJidHJmczogbW92ZSBwcml2IG9mZiBzdGFjayBpbiBidHJmc19l
bmNvZGVkX3JlYWRfcmVndWxhcl9maWxsX3BhZ2VzKCkiKQ0KPj4+IHdoaWNoIHdhcyBhIHByZXBh
cmF0aW9uIGZvciB0aGUgYXN5bmMgbW9kZS4NCj4+Pg0KPj4+IFdoaWxlIGF0IGl0LCBmaXggdGhl
IGNvbW1lbnQgdG8gcmVmbGVjdCB0aGUgYXRvbWljID0+IHJlZmNvdW50IGNoYW5nZSBpbg0KPj4+
IGQyOTY2MjY5NWVkNyAoImJ0cmZzOiBmaXggdXNlLWFmdGVyLWZyZWUgd2FpdGluZyBmb3IgZW5j
b2RlZCByZWFkIGVuZGlvcyIpLg0KPj4NCj4+DQo+PiBHZW5lcmFsbHkgSSdtIG5vdCBhIGh1Z2Ug
ZmFuIG9mIGNvbmRpdGlvbmFsIGFsbG9jYXRpb24vZnJlZWluZy4gSXQganVzdA0KPj4gY29tcGxp
Y2F0ZXMgbWF0dGVycy4gSSBnZXQgaXQgaW4gY2FzZSBvZiB0aGUgYmlvJ3MgYmlfaW5saW5lX3Zl
Y3Mgd2hlcmUNCj4+IGl0J3MgYSBvcHRpbWl6YXRpb24sIGJ1dCBJIGZhaWwgdG8gc2VlIHdoeSBp
dCB3b3VsZCBtYWtlIGEgZGlmZmVyZW5jZSBpbg0KPj4gdGhpcyBjYXNlLg0KPj4NCj4+IElmIHdl
J3JlIHJlYWxseSBnb2luZyBkb3duIHRoYXQgcm91dGUsIHRoZXJlIHNob3VsZCBhdCBsZWFzdCBi
ZSBhDQo+PiBqdXN0aWZpY2F0aW9uIG90aGVyIHRoYW4gIm5vIG5lZWQiIHRvLg0KPiANCj4gV2Vs
bCB0aGUgbWFpbiBtb3RpdmF0aW9uIHdhcyBub3QgdG8gbmVlZGxlc3NseSBleGVyY2lzZSB0aGUg
c2xhYg0KPiBhbGxvY2F0b3Igd2hlbiBJTyB1cmluZyBpcyBub3QgdXNlZC4gSXQgaXMgYSBiaXQg
b2YgYW4gb3ZlcmhlYWQsDQo+IHRob3VnaCB0aGUgb2JqZWN0IGlzIG5vdCByZWFsbHkgYmlnIHNv
IEkgZ3Vlc3MgaXQncyBub3QgYSBiaWcgZGVhbA0KPiBhZnRlciBhbGwgKHRoZSBzbGFiIHNob3Vs
ZCBtYW5hZ2UganVzdCBmaW5lIGV2ZW4gdW5kZXIgbG93IG1lbW9yeQ0KPiBjb25kaXRpb25zKS4N
Cj4gDQo+IDY4ZDNiMjdlMDVjNyBhZGRlZCB0aGUgYWxsb2NhdGlvbiBmb3IgdGhlIGFzeW5jIG1v
ZGUgYnV0IGFsc28gY2hhbmdlZA0KPiB0aGUgb3JpZ2luYWwgYmVoYXZpb3Igb2YgdGhlIHN5bmMg
bW9kZSB3aGljaCB3YXMgdXNpbmcgc3RhY2sgYmVmb3JlLg0KPiBUaGUgYXN5bmMgbW9kZSBpbmRl
ZWQgcmVxdWlyZXMgdGhlIGFsbG9jYXRpb24gYXMgdGhlIG9iamVjdCdzIGxpZmV0aW1lDQo+IGV4
dGVuZHMgb3ZlciB0aGUgZnVuY3Rpb24ncyBvbmUuIFRoZSBzeW5jIG1vZGUgaXMgcGVyZmVjdGx5
IGNvbnRhaW5lZA0KPiB3aXRoaW4gYXMgaXQgYWx3YXlzIHdhcy4NCj4gDQo+IFNpbXBseSwgSSB0
ZW5kIG5vdCB0byBkbyBhbnkgYWxsb2NhdGlvbnMgd2hpY2ggYXJlIG5vdCBzdHJpY3RseQ0KPiBu
ZWVkZWQuIElmIHlvdSBwcmVmZXIgdG8gc2ltcGx5IGFsbG9jYXRlIHRoZSBvYmplY3QgdW5jb25k
aXRpb25hbGx5LA0KPiB3ZSBjYW4ganVzdCBkcm9wIHRoaXMgcGF0Y2guDQoNCkF0IHRoZSBlbmQg
b2YgdGhlIGRheSBpdCdzIERhdmlkJ3MgY2FsbCwgaGUncyB0aGUgbWFpbnRhaW5lci4gSSdtIGp1
c3QgDQpub3Qgc3VyZSBpZiBza2lwcGluZyB0aGUgYWxsb2NhdG9yIGZvciBhIHNtYWxsIHNob3J0
IGxpdmVkIG9iamVjdCBpcyANCndvcnRoIHRoZSBzcGVjaWFsIGNhc2luZy4gRXNwZWNpYWxseSBh
cyBJIGdvdCBiaXR0ZW4gYnkgdGhpcyBpbiB0aGUgcGFzdCANCndoZW4gaHVudGluZyBkb3duIGtt
ZW1sZWFrIHJlcG9ydHMuIENvbmRpdGlvbmFsIGFsbG9jYXRpb24gaXMgbGlrZSANCmNvbmRpdGlv
bmFsIGxvY2tpbmcsIHNvbWV0aW1lcyBPSyBidXQgaXQgcmFpc2VzIHN1c3BpY2lvbi4NCg==

