Return-Path: <linux-btrfs+bounces-22250-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGkNDj1/qWnA9QAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22250-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 14:03:57 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2AF212576
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 14:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8CB030574BA
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 13:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2126439EF18;
	Thu,  5 Mar 2026 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j+HHOMGK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EVsxKIca"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191635DA52
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2026 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715766; cv=fail; b=FNu+4kFiJ7OBBgI/p6eh06Zf1io+E7M+Z6e3Y9ntI8XWQohUPp177a9bIKy8sDZA7CGkRRJvt6BPgfumFYRc8uGAP4UREh9hbunWz95iKwqQJC+FfT3F47sFSbkhNP1QyMH2qQFV8ffrykFkGweJTByMdPWX8xgwMlDTQr++0Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715766; c=relaxed/simple;
	bh=QV8GxE1sneW46537N1kW0biinYBJVIyaXkuCqYjpLQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZHp9W8GMt5uX/QWl+Bpd+hHOTrpA91uc515LJaOsbV/6ceP7v4rxb3bF9ZhehhgoMoEKo1Yexoz34e58C9YDsyAfAn40CYi4UAmJxHSoe9DBMi1M5hNki8a3rlfhb/X3p0DcaSJO8g/Lo2PXW0kdgRi0Lz/93/4CM5glGvIsZ94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=j+HHOMGK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=EVsxKIca; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772715764; x=1804251764;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QV8GxE1sneW46537N1kW0biinYBJVIyaXkuCqYjpLQ8=;
  b=j+HHOMGKuHWf4oElo2XX9m8cKpK+EQRwOevq4TE8GkfVBI3X4uo0VRG0
   lX2tT2VmYtBALrDZ8mymY+FShwLCGQon9T0i1JyYtV226o0eS886E521V
   kab33o0qf7Q1PuA73k7IaMx12BDLUpXjerfHWeGEVN2nqRxBvNGuA6Mpa
   0x9YyzL2jj98o5ks5ojhKFvhjD6J0y2G6uNQrtCAnjuxpWXeTJuXJHDbD
   81vK+TxaNEfybwX/H623xIIVtbF9qSjXRFDDz6dkuN5TLtVcKrntEZWoK
   zTNrYZQv+FeurX9Ie8x4GrlEjzUB3bf+jZs3vAimVMCiUzIu18NPFJmkP
   w==;
X-CSE-ConnectionGUID: iBdRwrULT9uMEJVMRrfW5A==
X-CSE-MsgGUID: jhutx4tlS5yf1ZNJHujEjQ==
X-IronPort-AV: E=Sophos;i="6.23,103,1770566400"; 
   d="scan'208";a="141562011"
Received: from mail-eastus2azon11011005.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.5])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2026 21:02:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDnrF7phk0AuuEkyfmmfkpGegP3kdstiGmMokG+yqBLnYwkJvvY2j+bukpm+O+L4/DFZwCbVMxPUYmseKAIpkZJ4DMHsgqZyBalb/WTTsXghTMUAtXaFA0nfMKa7PeQ/tJdDS7IAG3AXkW4bVsyj60tAv8qyxVm0seTEC8SwDT/Jnb1s4a7WLYBzqH2hnJvgTH9EyL+DujAcwoYqd2w0tDoNIlE81ztIZj7fySmSpWnobaELdMVycZhNnev8ju+eMVOAUL8YJFIufG+zzlrOvNKxzl0L8lJzHTbKIrMyAiMHqdrN/2pJLyP08O54R8TeJdTwPNIPhkSnpgiZao8Apw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QV8GxE1sneW46537N1kW0biinYBJVIyaXkuCqYjpLQ8=;
 b=M3LI1K5mzSMupZKsgufWb9rzL7J0R29GqKQT5UEGybJYLeOnMDF115ucBSyiUIqslPKOPJ17RgC0vZmh+QqPcGiJldfZj5iNNefIuAowcEewhAnB+kofytiL576N6Vu2SvzvlvwvCIG1uGJ7LqOA5//mh2Xx2GZ1PHGPBD1YnIpygg6BGY8bJv5HriU+uvDfuxVyjdQPsY6lOwb5tS840aE+HBfBjZ3eRnKbVt2PwK5VeEeLkpj+XcWfvEWMFxNi1J8sOlCuxyrP94oXOiFgV/veA/meA74+JfzjmKOQ+O9rHyUhMYNyY9oLpqi51X5OfQ2RS0hQ0ShFVM8MbCyA2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QV8GxE1sneW46537N1kW0biinYBJVIyaXkuCqYjpLQ8=;
 b=EVsxKIcabcUFwVMnw2i+1zM6uUaaunwtmQbQ9fX+A5jVWjv5mFLRwqEiTfqQrk/XiihrYosyh6IazSw//zHYL2v9UZI1S8mrSqkHE/O+WyUmcbhWAZCGG8JoIwAwMBYD6UnZ3/hv9eFzeaf8HSLu+Stq/zvARwurJlSu8ZQwy6w=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by PH0PR04MB7430.namprd04.prod.outlook.com (2603:10b6:510:18::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 13:02:32 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 13:02:32 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Sun YangKai <sunk67188@gmail.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, Boris Burkov
	<boris@bur.io>
Subject: Re: [PATCH v2 3/3] btrfs: zoned: limit number of zones reclaimed in
 flush_space
Thread-Topic: [PATCH v2 3/3] btrfs: zoned: limit number of zones reclaimed in
 flush_space
Thread-Index: AQHcrIfQ4DivehccTEmAJ0T9aATVD7Wf4L+AgAAG2IA=
Date: Thu, 5 Mar 2026 13:02:32 +0000
Message-ID: <eaa84469-ca22-4833-b6e5-9dc1af4d2bab@wdc.com>
References: <20260305100644.356177-1-johannes.thumshirn@wdc.com>
 <20260305100644.356177-4-johannes.thumshirn@wdc.com>
 <0bb1f7b9-18d0-4fe6-96a4-88a6082c3342@gmail.com>
In-Reply-To: <0bb1f7b9-18d0-4fe6-96a4-88a6082c3342@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|PH0PR04MB7430:EE_
x-ms-office365-filtering-correlation-id: 85f7329d-4092-4f77-09f7-08de7ab776c4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 WiexWriArTOKPFvTWduah7Myl/N6wr+fxUHUPXA0/dsTX+8lJ25Azf3PyBqo5BB4XducnQPySUHmwAvHyzwaxghLCSEUjTQBmL3hcvJkLh/QnFDdMd/elYaa0JsY/cv2R6Ve3i22QyFmGg4PAkPKzh7NRJDUHPLACxuNxQeMOQroZH9GVZJ8ot8a7Uxp2i8llKca+SQenX6EBM21a4EYgV+1CWVbRhhQ+VU/5ohfyuGRaZSKNCB/zxk5QEyIqJCXlrhHXT7DWt43TkAETQvJP843AE21VuL5fVtQOHpov4uN2JvBL4wTEoB+gNAvyzy3MEUYnyVLI9RfX4fowD4R4DLVFLIaMUpxxTkzlpcsePrJ8HAXqob8vH94NkKJH9MPiZsp8Kx/HWRlPXpINaj3s6SH83bqzjcAD6iPgqMdtEFmc7eOXfByOLWAi9XxyRcviLvESsyYW6J/AQ6uBPPLdPK0V7rzX3qZpq5AblbQHn/LR9FPEFrOlbxLpfD8iOc5tk8dr5VEfihj0zc467Pzw+3/SGUz3K+CUViNI1NxCB34hhXB6tUS54g9pIozQJnu0OoY7cM6oWkCP1zCiL50OPosl7KhTvs7gDJ6Vm12hPgKe8J31UdJSqLRYEyIoJI6KIeEaLpJWZfhp/0Ao8maOtgSca/nxVeSxtor4uEJ4sz5ESdCyAb2SEihoxf/a8kevAm0b8bTrKNu2911AFgjhQ6rXxz53upv4teO/2cdto13yP7+kyzxs+kPwOrZ7vJfHR9/79Ei69v2zdQuc3JtsHnmImZb89QjqJh4oxPe8GE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y2ZLUGNrdXp6dEZpVDB1MVhlZ1htSGQrQ1NOSkNUbjBVYWs0bjJJdjlFV1hS?=
 =?utf-8?B?enBTZUJXbm9kUzZOcW00ZHlUbkhrc2lXT05KUVVQbzUzUFNHbmFnK1gwd25v?=
 =?utf-8?B?TEVEZVpwNTlEYzdxOWFsdmlJbk00MUxNb2htcnR3OW5hNHUvOXV5OW1vc2Z5?=
 =?utf-8?B?TSt5UktES0JoUDQ4UTNWQTllTERCSEJlL1JTVHNTZERUMktnalhJeGpwK0FW?=
 =?utf-8?B?L1NQZUpBV1FFaTlKU3IzdGVlaHc0Z3I2cXNPcm11MzcyMk4xMkZvVTI5djhn?=
 =?utf-8?B?ckhBU0phQUVCWkJGUnNTTVVMZk5VSkpKVCtDSnBxdTQ3dGxHbGdPVzIzZ01E?=
 =?utf-8?B?ZnNEeFY1SzJSWWlTNzRsQmpqWDY2bzh2Mm9TNVdidkRwVmU5bDk0M21QUGpi?=
 =?utf-8?B?NWMxQVFIK3hPOHp6bEFua1NTRE9mMEtia3c1Vko3K2M3bmltK0xUNTFYTkpO?=
 =?utf-8?B?cmNLTmlBVEhPTFJEaXBmRVV4UkZYa2daZ0tGTVNiQlY1VmltbWtycm9yd3No?=
 =?utf-8?B?RTkxbFAwRUdUMEVhbTlHMENVOXZ0TWNNVFBFK0p3aHpIa0RMY2hLYWFwK012?=
 =?utf-8?B?ZnJRSU9rL1JoWlNFY3NiY1d0SWt6d3QwcDJPL2lEajdUczhhM3Q5S2NkUWFF?=
 =?utf-8?B?UnVaSytPMlBQYjVEVWhSWVlVYXRPaThrS2JuSDExdlNvZktJbWpZTTJ4Szcy?=
 =?utf-8?B?amh2MXp2MkFrY2hTUUZaNlQ4VlJBT3MrbHFPMTNObzF0S3pXeDJaS3htTmlS?=
 =?utf-8?B?bXRWOWxaeXZQYUZaTTliYVYxRFQ2Yi9zOEFTQjRDdlV1eDk4My9DR0lqc2Fv?=
 =?utf-8?B?SzI2eCtBOFR3ajIyNGxVZlU5b3Z2YjA4bDIvMUxvS1RqK3BqRVkyWnpaVTRi?=
 =?utf-8?B?UmUrUnZTN2czZHFzTTB4R0w2d2pRNStTM1E4ZVp4R0QrUEdOSkhWa3ZnT0xT?=
 =?utf-8?B?bjk4enJrWHU3a2hSK3pYbE10YXJrSktiUWJTQ3FWQ2JjQ1RUalBrMk9FUWk3?=
 =?utf-8?B?UFRCTDBsVnlqb1Y2UW1Eb2lwUk8zMEJtT2tYd0xoSVdDZ3k1ZGkyME1aQ213?=
 =?utf-8?B?RnliUmJDRWh0aXBmQkg5MVNiNjJDeGhBRW13ZXRhZ2ZpanVlZ3NOZVlOaGhY?=
 =?utf-8?B?YjY3Um1NRk9TQ3F3TWJNYlljaUN2RXpTdlJxaDl1YlJCeXAvM1owQVRqblN5?=
 =?utf-8?B?TEpmTW9qQVBCSUZKUlJtYVBjOURVL0dGSWtCZmVibHpWaWgvZHdoVllnblhW?=
 =?utf-8?B?Tkl6N2JUNUpWdUhpY05JRUZCOHFJVGQ4N1B6RGMrckw4WmRmdkFMamozTEZw?=
 =?utf-8?B?bnEzS05scFNQaUcwV096WU9qbkpqamdRakc3ZGVjdmYrUmRmNUNKcm9tNGU3?=
 =?utf-8?B?M2ZPMTVxYVFYWXNsbnZMNm5Jc3NWQ2VvVmFJb0t0RGNWTE5NbWswY3U5T0Rt?=
 =?utf-8?B?T0oxWjhHMmE3M0tOR2NzZXRhVk1YMmszTEc1ZTd6Z0E4MmZoelNGMjZOSHhU?=
 =?utf-8?B?anZyc010Y3Vub2JvaHp5ZmVuVlVDaGpZd0d1TTl1L0lQV1ZVL0VwYU9wemdE?=
 =?utf-8?B?cnJmdU1lcWJNYmxoeUxDR1dOZEYxaVpTTDZwczBnZWtyWkpLY3B3eWo0S3hL?=
 =?utf-8?B?eEZZYTdUcGZlS1pDQUJDWk55L0x4elpHM0JIMXJCUEJJRmRSVFVTRzlhR1hK?=
 =?utf-8?B?MjVrQjd6U0N0MXhLcEhHdFFlUzFRNlk2dVlmaXI3T2VUNTBGUGptNFl5ajNF?=
 =?utf-8?B?cXcyaXNBTVR0aU9IV2NUOXY1TW1vRUQ4VWt3bDVINEVGbjJ5TERuY1o5Mjk0?=
 =?utf-8?B?UUEvS09xcWdyVGVpU0g5YkxTVEdGVFROQXNDUzRCczBVR3R6Yzlpckp5QStY?=
 =?utf-8?B?cHp0NGZnb2prQ3ZvdjcyUU5wbmRMUURuMWVxc1YwRkR1cnZZQkNqaEFxQWxT?=
 =?utf-8?B?RWwxVEVxUFdNSjNjNnJ0S2VQMC85cnY2SktiSGtXQ2NUcmRsUk1HaGtnenMv?=
 =?utf-8?B?UUtLMEIzNGFyZHZudTduK1F5aGRNSDZ0NXdTTHE4bE1QVlVVUUNiTjhFbmVv?=
 =?utf-8?B?bnVOYlNnaGcvTjlhYkNvK2dIQmIzQ04vYmNVVFdoUXN0SEN0elJlQ1JiMXB0?=
 =?utf-8?B?TXBhRDhyNG94b0U3cEVpeFdVck0wbEE3d05iekFXdnRmdnlmYzdzMFNGbm1U?=
 =?utf-8?B?QVM1NlpocFVFS1F5R2w1R09INTl6cnVVVSt3MDZkRmQwSnZEVjBKei9yRWlF?=
 =?utf-8?B?dzBRWDJ3OGZvRUszRm9BeDlNTzk4enpoWlBtNmltVFEyTHNvMUs0TmthRUk1?=
 =?utf-8?B?MzlmUXNwZnpzalBnMGZJYzhGNEt0R0E5T2JPTWh1amxtYVJsV1NDYkJFdDR1?=
 =?utf-8?Q?Z+62hdBNal2jaUEMBtzzziFmtQ0xMkyx1JLVFAuKq5Xf2?=
x-ms-exchange-antispam-messagedata-1: FqrmN+l/wFxKsI3/0jUMaH7Y24TEDUbw8Kk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C982C57293BEE342BF4045BD96D4C17C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	f0pN6PSjq34Vc9zgF9PA+bsqzsWMN5aal76ziQaYAGzV68qTJQJsQuxTXcMSaMXVxh4oClYUKa7obTA25e69lEV3BGRvYJsaCGSAjZCUkYuBHiWyC2zZuSVlhNeB2hMX+0HMMUa0ai33dX5LWjvZri3NZfxa4RwghDau4qsnB3X+t6h7Q4tUdLnr6vFr/CuUkDl79QOn5fqQI01RyyFXk+zJ5Q2NHhRO06xnCASo+RzreOsR6cj/l0A0P6cG+GcpMgdVpsfyESz5QfCu/dfPLZZx6gtsf/2+ubZJGAdMxmpBFkwk/TlAy2JM1XWjdNqffpLiAv4KpNoXd0NjTos/Qg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pqPTDkEBdCcVMK8wXaYvfhtMk9x73l+tY2XMXYJvumTtpWJlibldD8lwtvZN4nr68zVHv4rmw44VDCDhQhCrYAcdXVSgDARq5MkTNd6Ts8I7LIYAVVFHeQOXptquiFhIM4dvSWb8JmhS1rkjP/EmjkBSOJgyHvy1H8QLyOAkTFurR94yxT44vobZMfbQz8L8VvZdb/k897K8Iy+jgN4/09JmWS0K9NTMfLcTlYaiAjzVwqij/rlWz4skpDSNEmQdoLtnowzmpHFjVBWmWVsvLgiT88nYQlXEDgVdmvyh20dH0YU/I4dxlYfPLavDIdONvN0PwNFz6tASbkYDBPmA57xhtt7zhtIowcdmI5etDiAFBKmrv7W5aumzhFzcByuv39HC4BZQQo5SB2E+ARA0soBjn0W8HzYvKolBFQN00amLMqDwiezIsIX0ROqFbov3UV/S4nfumasOhvfHNFaPN0Xwe7f4PTUI2Vv0o7o6gXCttpOcyQO2xxPhgVvKgBoTWwuZJn7MI5JE6z6juetriodNE4M+P+pb1YUkNHxnWt3PcoqUq34sZJmb2Vki4TjMBhoa3kbY6PlteR99voy8ThhB7uKzC4zPWrWxxLV054R+l7xza87ixxgi/ugxBi3F
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f7329d-4092-4f77-09f7-08de7ab776c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 13:02:32.2787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2rQ4m3jWpFKW11wQy6rEWahf4rwMDDU8KqPnKyEdisidUb3VXp/wIpSFpXw2S4tZ5+nD0beq3xaUcHK44uHOXQlUBVgZA50C6CeK+hteT1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7430
X-Rspamd-Queue-Id: CC2AF212576
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22250-lists,linux-btrfs=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,wdc.com:dkim,wdc.com:mid]
X-Rspamd-Action: no action

T24gMy81LzI2IDE6MzggUE0sIFN1biBZYW5nS2FpIHdyb3RlOg0KPj4gLXN0YXRpYyBpbnQgYnRy
ZnNfcmVjbGFpbV9ibG9ja19ncm91cChzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmJnKQ0KPj4g
K3N0YXRpYyBpbnQgYnRyZnNfcmVjbGFpbV9ibG9ja19ncm91cChzdHJ1Y3QgYnRyZnNfYmxvY2tf
Z3JvdXAgKmJnLCBpbnQgKnJlY2xhaW1lZCkNCj4+ICAgIHsNCj4+ICAgIAlzdHJ1Y3QgYnRyZnNf
ZnNfaW5mbyAqZnNfaW5mbyA9IGJnLT5mc19pbmZvOw0KPj4gICAgCXN0cnVjdCBidHJmc19zcGFj
ZV9pbmZvICpzcGFjZV9pbmZvID0gYmctPnNwYWNlX2luZm87DQo+PiBAQCAtMjAzNiwxNSArMjAz
NiwxOCBAQCBzdGF0aWMgaW50IGJ0cmZzX3JlY2xhaW1fYmxvY2tfZ3JvdXAoc3RydWN0IGJ0cmZz
X2Jsb2NrX2dyb3VwICpiZykNCj4+ICAgIAlpZiAoc3BhY2VfaW5mby0+dG90YWxfYnl0ZXMgPCBv
bGRfdG90YWwpDQo+PiAgICAJCWJ0cmZzX3NldF9wZXJpb2RpY19yZWNsYWltX3JlYWR5KHNwYWNl
X2luZm8sIHRydWUpOw0KPj4gICAgCXNwaW5fdW5sb2NrKCZzcGFjZV9pbmZvLT5sb2NrKTsNCj4+
ICsJaWYgKCFyZXQpDQo+PiArCQkoKnJlY2xhaW1lZCkrKzsNCj4gV2UgdGFrZSB0aGUgYWRkcmVz
cywgcGFzcyB0aGUgcG9pbnRlciB0byB0aGlzIGZ1bmN0aW9uIGFuZCBqdXN0IGZvciBhDQo+IGNv
bmRpdGlvbmFsIGluY3JlYXNlIG9wZXJhdGlvbiBzbyBJIHdvbmRlciBpZiBpdCB3b3VsZCBtYWtl
IHNlbnNlIHRvIHB1dA0KPiB0aGlzIGludG8gdGhlIGNhbGxlciBzaWRlLiBJIHRoaW5rIHRoaXMg
d2lsbCBtYWtlIHRoZSBjb2RlIGVhc2llciB0byBmb2xsb3cuDQoNClRoZW4gSSdkIG5lZWQgdG8g
Y2hhbmdlIHRoZSByZXR1cm4gdmFsdWUgdG8gYSB0cmlwbGUsIG5lZ2F0aXZlIGVycm9yIA0KY29k
ZSwgMCBmb3Igc2tpcCBhbmQgMSBmb3IgcmVjbGFpbWVkLiBDYW4gZG8gaWYgdGhlcmUgaXMgY29u
c2Vuc3VzLCBidXQNCg0Kd2UgaGF2ZSBzb21lIG9mIHRoZXNlIGludGVyZmFjZSBpbiBidHJmcyAo
YnRyZnNfc2VhcmNoX3Nsb3QoKSBjb21lcyBhcyANCm9uZSBvZiBteSBwcmltZSBleGFtcGxlcykg
YW5kIEkgcmVhbGx5IGRpc2xpa2UgdGhpcyBpbnRlcmZhY2UuDQoNCj4+IEBAIC0yMDk5LDYgKzIx
MDIsOCBAQCBzdGF0aWMgdm9pZCBidHJmc19yZWNsYWltX2Jsb2NrX2dyb3VwcyhzdHJ1Y3QgYnRy
ZnNfZnNfaW5mbyAqZnNfaW5mbykNCj4+ICAgIAkJaWYgKCFtdXRleF90cnlsb2NrKCZmc19pbmZv
LT5yZWNsYWltX2Jnc19sb2NrKSkNCj4+ICAgIAkJCWdvdG8gZW5kOw0KPj4gICAgCQlzcGluX2xv
Y2soJmZzX2luZm8tPnVudXNlZF9iZ3NfbG9jayk7DQo+PiArCQlpZiAocmVjbGFpbWVkID49IGxp
bWl0KQ0KPiBUeXBlIG9mIHJlY2xhaW1lZCBpcyBpbnQgYW5kIHR5cGUgb2YgbGltaXQgaXMgdW5z
aWduZWQgaW50LiBXb3VsZCBpdA0KPiBtYWtlIHNlbnNlIHRvIHVzZSBib3RoIHVuc2lnbmVkIGlu
dCBoZXJlIHRvIG1ha2Ugc3VyZSB3ZSdyZSBjb21wYXJpbmcNCj4gdmFyaWFibGVzIHdpdGggdGhl
IHNhbWUgdHlwZSBhbmQgdGhlIGJlaGF2aW9yIGlzIGV4cGVjdGVkPw0KDQpJIGRvbid0IHRoaW5r
IGl0IGlzIGEgcHJvYmxlbSBpbiBwcmFjdGljZS4gRXZlbiBpZiBsaW1pdCBpcyBVSU5UX01BWCAN
CihsaWtlIHdoZW4gYmVpbmcgY2FsbGVkIGZyb20gYnRyZnNfcmVjbGFpbV9iZ3Nfd29yaygpKSB3
ZSBoYXJkbHkgZXZlciANCmhhdmUgYSBsaXN0IHdpdGggMl4zMiBlbnRyaWVzIG9mIGJsb2NrIGdy
b3Vwcy4gSSBrbm93IHRoaXMgc291bmQgYSBiaXQgDQpsaWtlICJZb3UnbGwgbmV2ZXIgbmVlZCBt
b3JlIHRoYW4gNjRLIG9mIG1lbW9yeSIgYnV0IHdlJ2xsIHJ1biBpbnRvIA0KZGlmZmVyZW50IHBy
b2JsZW1zIGJlZm9yZSBJTUhPLg0KDQo+PiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvc3BhY2UtaW5m
by5jIGIvZnMvYnRyZnMvc3BhY2UtaW5mby5jDQo+PiBpbmRleCAwZTUyNzRjM2I5ODguLjU3Yjc0
ZDA2MDhhZSAxMDA2NDQNCj4+IC0tLSBhL2ZzL2J0cmZzL3NwYWNlLWluZm8uYw0KPj4gKysrIGIv
ZnMvYnRyZnMvc3BhY2UtaW5mby5jDQo+PiBAQCAtOTE4LDggKzkxOCw3IEBAIHN0YXRpYyB2b2lk
IGZsdXNoX3NwYWNlKHN0cnVjdCBidHJmc19zcGFjZV9pbmZvICpzcGFjZV9pbmZvLCB1NjQgbnVt
X2J5dGVzLA0KPj4gICAgCQlpZiAoYnRyZnNfaXNfem9uZWQoZnNfaW5mbykpIHsNCj4+ICAgIAkJ
CWJ0cmZzX3JlY2xhaW1fc3dlZXAoZnNfaW5mbyk7DQo+PiAgICAJCQlidHJmc19kZWxldGVfdW51
c2VkX2Jncyhmc19pbmZvKTsNCj4+IC0JCQlidHJmc19yZWNsYWltX2Jncyhmc19pbmZvKTsNCj4+
IC0JCQlmbHVzaF93b3JrKCZmc19pbmZvLT5yZWNsYWltX2Jnc193b3JrKTsNCj4+ICsJCQlidHJm
c19yZWNsYWltX2Jsb2NrX2dyb3Vwcyhmc19pbmZvLCA1KTsNCj4gV291bGQgaXQgbWFrZSBzZW5z
ZSB0byBkZWZpbmUgdGhpcyBhcyBhIG5hbWVkIGNvbnN0YW50IGxpa2UNCj4gQlRSRlNfWk9ORURf
U1lOQ19SRUNMQUlNX0JBVENIIGluc3RlYWQgb2YgYSBtYWdpYyBudW1iZXIgNSBoZXJlPw0KDQpZ
ZXAgSSBjYW4gZG8gdGhhdCBpZiB0aGVyZSdzIGFub3RoZXIgcm91bmQgKG9yIHdoZW4gYXBwbHlp
bmcpLg0KDQoNClRoYW5rcywNCg0KIMKgIMKgIEpvaGFubmVzDQoNCg==

