Return-Path: <linux-btrfs+bounces-16917-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6741B83382
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 08:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 707587B9D9C
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 06:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2C52D9EDC;
	Thu, 18 Sep 2025 06:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p3Arr8fU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qRTVvVyp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B91D2D8793
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 06:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178405; cv=fail; b=PJTDJGw3bCa6F1WhzPQvmwx0jsOTKmbOwAcAqkx7NO/SqFFRa8MirM4wlld5D+FlvI43W0ThAIEFWpZ8QZctu4gWFhw7Uq1qHJRW+3UhwuwzcTX3rtAmnkJ0mpeK1jfRg0SbeLTEcK4MjENwX8YpL1epmqZurZwLkIoP4JFHCDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178405; c=relaxed/simple;
	bh=u3szKcq2T74/QLibVhddQk6R08pclel330BDfolLvOY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LPoSjoGzl0paZ3eB11CilHQSHs7sJ4c05mKB3cyB/s04FH8f4gTU7wSKitQMEQekB7qFP9FnLxbcJonjKgdsAkUKT7TQU3MQWbv3+QThJluqAsboi0Wjhlfwcj48LTSVm2wNKvPlcSx1qVUSfGaum3ZqhHzixblSDGERwFk4kgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=p3Arr8fU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qRTVvVyp; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758178403; x=1789714403;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u3szKcq2T74/QLibVhddQk6R08pclel330BDfolLvOY=;
  b=p3Arr8fUubS9xSDYeQKAb9ECzv3uWx0SAW+9nQAlZPcv/sRlZ6umnaqw
   cmZ73RmCWhKkAP+h4hpjk/Pl560aywnzl4O6ED6VZruCXdPXQF0LqD9iY
   Lmf6d4tqPCXKHpZNZo0kl+4leHgb2Vousqfaxe/ast8o9oIM5bWp8JZzd
   c7jCwyZudgNOYkH04gQZvgSXP/Y+HFkdwYCcas58ekHJHfqlcnIk5bLXU
   eZCaR2EJGY72PZiorRLNgV9IUZUVThFHjh3gx6fo4hFo5MaSUHtq934/S
   Uu8yKVb00/ajd+uZZNa2k54WiD8CAlnpmOi2V4Pph7Bq4EsLwFO0wKmbv
   w==;
X-CSE-ConnectionGUID: ajAhlmzoQq+0bAGWVmnLrQ==
X-CSE-MsgGUID: mC+XqX3rR3KBF1nNRsu4Jg==
X-IronPort-AV: E=Sophos;i="6.18,274,1751212800"; 
   d="scan'208";a="120511728"
Received: from mail-westus3azon11012001.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.1])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2025 14:53:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdbJfOnKVWgpHncN5hwXXPKX6zePXlqaaf0ZAwOI8zYpM3n/0A5I3ZmPLiqyGcKYX7lM3cl9bGNCuZe7RY71RLVbJgKknQkVLsDSLnmBDxWF9S5UKZdgQaAUJ1jp2r0JGbWRfL8fv3o8mq8Qa594zb69gIRlUD6qHjJ4T/BOZBvV+KTDwhElXfGCB21athXrSi0shv5Tw/wojT//uVhMoUtrseg5yksoQueGaOfQFmpOBv/j7B27d/DhuD1bgvdz1l6Asw5vHQnRlQ3+K6sjA2ukClTp0pZ6QfmhmsOl3+Ek2CrK+nOFDWQf9akXeGZ4FxbNmw0zGqC7JTua/R/Prg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3szKcq2T74/QLibVhddQk6R08pclel330BDfolLvOY=;
 b=wlPb3CsBengAc/GRXAtmGqcHmabd9+YijDmon7CCCvIqVOZE68C1BGcFD6Wvv4WQgYhBYaEcCMmaxlEe26Qb1PYgg62g/aN8TyQhBYEx/Y7v0oDQgtiFq30dnVVGkj8Ip2ma3oZAAzU+FQQpGMKYzjvRtNPE9RDVrLTS+sQ3ScSyaH2bNEC+mN8xc5DH6r/oZ7rSU4SgdlvFq9/IO7v55GPgB/Zu8k7TitxaeR3rloY8ACg6hSLb0jbB5P5fZwU2srH3ZQPCUr1+LPzeIf1SO6j0BAUf7xdgMHqUnHPVKCwRrRE1rlaZFbs8+lSDqzk7x8S+9nJMZpn/K1zs3qkGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3szKcq2T74/QLibVhddQk6R08pclel330BDfolLvOY=;
 b=qRTVvVyps+NVLibLSqbRmyfin9ets1hHmajYkz916yylOTj07alsXB6DQiZHqV2bULiAYR677hhSN1HGbLXEnqkIzF3RSl7pNY2FjEaW78MHypQWaMyIvNEVgw/TUwQD4mezg7LGVWs+18gIlBTNlPjQD3J/OaTbEP31Wl4XEJA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7316.namprd04.prod.outlook.com (2603:10b6:303:7e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 06:53:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 06:53:20 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: HAN Yuwei <hrx@bupt.moe>
CC: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs
	<linux-btrfs@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Naohiro
 Aota <Naohiro.Aota@wdc.com>
Subject: Re: performance issue when using zoned.
Thread-Topic: performance issue when using zoned.
Thread-Index:
 AQHcJWG554cLgRNI6kq+V/MRpm0fY7SSfW+AgAGm74CAAA0WgIAB6tOAgAAB6ACAAAoMAIAAoakAgAAoUICAAB0gAIAAeugAgACpc4CAAFNjAA==
Date: Thu, 18 Sep 2025 06:53:20 +0000
Message-ID: <98cab495-62ab-403b-9e5b-52843d369484@wdc.com>
References: <tencent_694B88D85481319043E0CE14@qq.com>
 <873c88ef-ee65-4e27-bc5e-156cf9e79aa9@gmx.com>
 <BD8FA84236613557+a3110e3e-3931-4ff7-a7ac-7347b9808642@bupt.moe>
 <c2d204fb-efa3-420e-b9d3-2ae45b17299c@wdc.com>
 <2F48A90AF7DDF380+1790bcfd-cb6f-456b-870d-7982f21b5eae@bupt.moe>
 <1c5e2ef7-f2e5-401d-8acd-0605b117dfcb@wdc.com>
 <43f21464-c084-42e0-bb5a-0572e3385b02@wdc.com>
 <tencent_6AE63A4E1F1CC94E1625B595@qq.com>
 <b86ab184-7028-4d58-8acf-1f995348a6f6@wdc.com>
 <tencent_29ACBA272F8BC2BE2BCCB091@qq.com>
 <c3260c71-10bf-4315-8cb6-f42933c12b55@wdc.com>
 <1350529CBB385708+9801e76a-3fab-4069-a947-1b847c64dbef@bupt.moe>
In-Reply-To: <1350529CBB385708+9801e76a-3fab-4069-a947-1b847c64dbef@bupt.moe>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7316:EE_
x-ms-office365-filtering-correlation-id: 6af3e8c7-a53c-4945-8737-08ddf6800e08
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVZWRmZxV3lNNk0rWGpCK0dJdEdhRnk1TzJ0cGtpcytlRkxHbVdNRTBVWWN4?=
 =?utf-8?B?b01lU1RmaDU4MjNZV0lVNWZRZE9lSG53R2xENmVHWi82V0E3MDM1OXhTY1h6?=
 =?utf-8?B?ZTV4N3BrOFQrNTRKU3VCTU9oZk9veXRoWjBFQ2lzWGo3bnBlOU5MOGFDYkJP?=
 =?utf-8?B?OGoxekpjNzhJM25IS3JUYkNEbUY5NjliZEI1dWZQcUY5a0Y5RnVtc3grUk1t?=
 =?utf-8?B?NUF2cGxSY1plMEVxbWVYMzIxSjZvMnNGU3pmdUlnWklqc3BGNnBHL1BTaERY?=
 =?utf-8?B?Z1VONC9uaURSNjNuUWk5ck1peXllbFhTdmY1Sm1uUUJyaFN3WWxwS1dLR0tJ?=
 =?utf-8?B?M1djTEtUZ3YzdXFKZTFFektXaUM3dnJGa01SRzZFK3ZpeHdrOHkxOGRocVRl?=
 =?utf-8?B?NzBjRHhGREM2UFBUWGt4S3JkMFpaMXYyOVFPOFFiUEUzOVNBclI3VDNCcUF2?=
 =?utf-8?B?L0xlb2hRVU54OEtWMWFMQ1dlOElCbnBzTTk5enRja2J6L09zeEd5YWcxMVNq?=
 =?utf-8?B?a2dDbzJxV3RyV2RWMU9iVUhYenRDQjMreEpZWnh1bkhrU1lXeVRzTHpkRU5p?=
 =?utf-8?B?ZU8vcUR3SUZRNnhBTVB2R3lSZ2F6ZzBTQlREb1ZhVnNaVUtTYjAwNnVHcXdh?=
 =?utf-8?B?M1ZOWVN3Ky9jSWx2THlhU0lmeHVINnBVTmdXU1V3U2ZnTHFlcjR1bXV2MHRy?=
 =?utf-8?B?MEUrbjMwb1BEYXNQWGRTUk1pQXpETlduTzJkUE1sVHQramtJQVdXRmhFQUk0?=
 =?utf-8?B?UWYvME54MzBRSko5b1dLWWdjSlZRWFNBR0hVaEQxaE5PQ3FhMkVGNjNqUktu?=
 =?utf-8?B?aEE3MjJXSm4zcU5zQmk4QkVjT1R2N2duVW9YRTZReDkwMVQ2dG9lQjJWYWFW?=
 =?utf-8?B?NW9BazllSlFQRTExeHZaVXV0by9zRm5DZXBmZWlORVI0RUpjYlF1NTlGZFJs?=
 =?utf-8?B?Q3ZIdnNsTWNkcnhDUEo1T0cyZy9LWGQ2TXF2MEFWYUk5L0ZXdlRVT01IUkx6?=
 =?utf-8?B?S2tKQ0QrSFJ3MjJkek0xL1A2c2psaS8vczBNc3UxcHB0TCs4Q0F6RUlzdGhO?=
 =?utf-8?B?Sk5tMUQzcVlxTEhnTG9LZWtRcHBoTUVaZk1LSUI3b1VRNUhiNXp6SUp1MjV4?=
 =?utf-8?B?c3F6eGUya1MySWltNTdOUG9YNXpIdkNQbUlnb1Q4UDZyK3hESXZpSnRFWXRa?=
 =?utf-8?B?dko3RkpMTTBRNHJoQk5rcngrQjF6UEZKZTN6bU1VZnRsMWJ3bFlmd2hqcEJ5?=
 =?utf-8?B?Z2lsS0I5QWt5VFJxWjZabXdOOUpEcnhXRDV5SzcwL2dhazhOY1AvblRhVkhH?=
 =?utf-8?B?Mlh0SWNQbStQblB4SVdpM3JyMjh3RGNzS0txcjJPM2gxU25qaHVrcWVBNDRo?=
 =?utf-8?B?VkRwSlNoWStYSEVpUDNPV3hKSWtndDhjSm0wV0FhQXY0UVdwakszbmNsNUlI?=
 =?utf-8?B?VzRMeE1ncWhydmNXYkVOclh5Q2RjMW4rRUFEaGRBa3NYdFUvc0tDSkloZVZo?=
 =?utf-8?B?dy95Zm1SS2pDWVRPT1RXd1IrcXp5L041ZHRxV2Fjak9nM1d1VmVzUm93dnhh?=
 =?utf-8?B?b0wzOWlvaU1vWWxyYUlvU2l3YmdteWZ6aUdvZWpMNG1HSHhPckFHYVFtVUxn?=
 =?utf-8?B?dWhabVR3Z0twQmxFS2EvbkhIM0Zqc2k5alpxRTdTS0hxck51WXBSRncwdERZ?=
 =?utf-8?B?T1FDQkFrQUF3N1p4MU56VWdFWGg0ZW5rS2N1UGdDY1hiS3lVMGQyYnVUV3Zn?=
 =?utf-8?B?eGdLV3FNNGVOd1R0bGlsVXNoUVFMV0lSTjZ4Z3VvVEs5c1htUmNkc3VqUWZB?=
 =?utf-8?B?anlyY21hZHAwZFBta1FubnUvdnc5eGdWcjJpeFQrd0wxcVdqZ0grSXpqNTFX?=
 =?utf-8?B?NExEdElMSmlBWGc5STM1cUFyZEtFZnIwZzVuUDhjZTJhSjNvVDBvQmJ2QTBZ?=
 =?utf-8?B?QkxSNlAvYW9LOW1ZZFZoQVdWcGpteEYxb3VpN25jZVVobkVUZ2FVMjM3bzM2?=
 =?utf-8?B?YWY0SWQ4d01nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MU9UY1hJb3Y2bmp1eDNreGVQQ29oVnFBSENlZEwvYTh6QWZWejhybTB5Umht?=
 =?utf-8?B?NWFMWFBvaGlUYkFuUm5KUGE1WGl2bVdyRmNYczVTMVJZTXRIdE11NDNtci96?=
 =?utf-8?B?cFNJNVlJQzFUZ003SGZCQmxrZHgyWFlCWGxxNWh3d1o5ZGlPVlpmNnRiTmlG?=
 =?utf-8?B?R2V3VlBuODNMclc1SEs1VmtlRTIvRDAyN2thMW5BbnZXSnJVY29lN1c2ME4r?=
 =?utf-8?B?QktJOS90QktNMmozclg5UjRydmlOQThNY0xqcFhTSWdvSzhtcTV3TmluaWdw?=
 =?utf-8?B?Z1FOOXlhUExYRGVhb3VvRzkxRnN2S3NjdlczUFh2d1U3UlF5bm1NcnprTFpu?=
 =?utf-8?B?ZUQvSW8zYkVMdVorbWNZdEIxaTFaK1o4OG82bUlQZjVrbzlMS3hvZGxadENr?=
 =?utf-8?B?cjdDZzhYajNlSmlWaGVsS0ttU0xrbVlIMHhwR2xZL3lsQzBHRHFDYkdlVDVZ?=
 =?utf-8?B?SGdpcmZVSGZWODdyL1JteU1aR2ZSSEhyNmpGYXZabEtiZkFVajF2Tmt4cXNS?=
 =?utf-8?B?NDRiYUEwKzZoUkZrRERVL2d2NHdFS0c3dTk4RjVDZnY1T3liRnVCYjh2S0Fv?=
 =?utf-8?B?emxrazdpRThCT1IwMk9Xd0NOa1dlRnB2aGNUTW9xQjg0b1lKTHpqQjVlTFdk?=
 =?utf-8?B?TFlheGliZ1dTQXpWN21PcXl6bTZUUXNjK1lhWUt1dCtoVzgrYXBCRW8xL0xa?=
 =?utf-8?B?MVQ1MWlLSFZFY2ROOFBpNzVHRVhwdGtNTCszRUZaZ2lhVjNyKzJlSTNrdE5n?=
 =?utf-8?B?RjlScTVaT0ZyV0J6ZEpTRWtlRlpEVURrODI3U2xkWFcvUEFlOFRPeWhFaUZm?=
 =?utf-8?B?ZlhqOFZOeUlIOHM4NDJLZkdQQ2tMUHlYTnppQklwUGFVT3pBTGQ3NzkxL21n?=
 =?utf-8?B?eTFjSFBYRW1CSlpLQUpnTzM5dnBMa2hUbjJRM1g3WTF6Uit0S2kyV3htU0kv?=
 =?utf-8?B?aVFPaFdOdnVreGFiOElPcnV6OXFlcXQ3WktqY3ppaTk1TWV6RlkxTVJ0R1NB?=
 =?utf-8?B?T1VheS9UZHFRa25rWjRZelY5WnUyaEhETWtrSWhRZlBtZTdpL3FvK2VQcmIz?=
 =?utf-8?B?WndtTHl1NWg4eDdRd3JKR0pIdXNjQWltSGxBR3BvMkJmc0FneUxYNisrMmtm?=
 =?utf-8?B?VEZEcjFaeUdrdm9wTUREM2VYTnlkK0VhZ1dld0d5OEE0d2dSZ2FVQmRZU1c1?=
 =?utf-8?B?NkJEY3FhSXhzY1lWNGhCS25kVzB4dDNrQTZLTlBYWFJQY3Y0bWJ3dWc5ODJP?=
 =?utf-8?B?SHdvTlRwbVJBSjk3OUlJSWM0VThtOW4wSDhIc0licnVDcHh0dUdoMjdzelBq?=
 =?utf-8?B?V1R5UEVNQVR1OFVwNjdGMkJCUFN0KzVCV1FaaVYzbzZ5R3RSYVA5RngzcTV4?=
 =?utf-8?B?aktYRWlTL3NqZVNnaC94SU1WR0o1cHJsZWN6Vzdyc3F2ZmdoRGV2WGlsUTBh?=
 =?utf-8?B?N0JjZytPUFE1bWdVTzIxNC85aWNyK3RYdGZwZm50QmpacUFScEpUMWlwT3l2?=
 =?utf-8?B?YTRQdSs0SDRneDJzY1VUYzVXaVBoOGRMTWZyS3BvbkxtMG5UVUVhUnhwc0ZI?=
 =?utf-8?B?M3NMbTI3YXR3U0xMOUtIZm4rSEUrMGRDRjFtb0U1RzJjTFAxM3NjWjc1RWdM?=
 =?utf-8?B?MEFNN29EbjdVeXczSHB4dXIzNFA4cEJES0ViSENpeHhvTTdMV082UWZLaVBw?=
 =?utf-8?B?a0ZSVzZFVTZVcTBiaWNFanZzL1ZRSTFENTkyUm5hKzJzSGVIdktZNFV1OEhU?=
 =?utf-8?B?ZjFidlIwa21OL2JpaDhZMlo2MzR3RE50NzB4TnBZM25tMmwzQ3RxR0pUZzUr?=
 =?utf-8?B?U0dhV0gzRGgzZTcyOW5Pd2kzdXZhZlppbjF5TXNkbWRNa2R4RmJ0NnovdXdk?=
 =?utf-8?B?THVBOEdXY0ZEMmpPN09zZ0thd2tJN21TL2t1UmZJcnJUOUc4RmxxYllpVnE5?=
 =?utf-8?B?NDlzYUcvbVBPZStPRkNWeDFtWDcwSXQzcHMvMlpTcTI0d2JTVm1BdU92MmVE?=
 =?utf-8?B?MEZGNW05eVJCK2RFbmhqUkxmdnBNSWhocm9hUDVQNkxkclQ5OHZJWHdMU0ox?=
 =?utf-8?B?RE5pTFhqNCt0YS9mMFB3YVlyRW0wenBkd2U1ZUQ3NGJVRW90UmNuenpHdG45?=
 =?utf-8?B?dW40eGJ1R3hjTWFLMmF6R1huNVhCbEd6TnQ2VnZwQkNxelBic3lXZzJDREE2?=
 =?utf-8?B?NmF0UE0waGRzUFhJQ0Rsc0VKczA2Zi85a1R2ZWYzWWpjOFhuSmVLKzZvNlBk?=
 =?utf-8?B?OWtRY3FtY0NXNDdBUlVGbTRoendRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <443815648990CD4986179E401ED6B406@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gdeI9WZdGPESZJ+D6aB3c8qnt7zM50Mr1JDnEkit1ixqwRv0WFv/IRv7TjgjN9XHVqplESryKBMfM2MFK7aaJqT+CJFBJN2TTWToZpddNAWCbOHc/rtPHpnIrEkPPtB0NM4C9T2tuFYyNyDpDEAXbWr6vpeYYE6NblE3K3WCS4qe9DJnlFobv/KXgtpd8X4kp+fTspMbF6VyLs7uGjinpxWF5Mt8y3XJ8NoKrBYSzhALJU9vvaHFX5YIhFl7Kx8F4QZQjtTBm+Hutm5DBV6SPYPs8KsqdZ2wXc5eidpJcVkmdpspSS1nViiv9q19o+eZusAcV9EFdIqDnkqf6I5TRHAHakqUtmmOlNZiw+5pHxQdB46abwqnJaz9542ICh7PSMu7EAtyym8TaNOiYplCPkfWwSMqWl2333lNB1Bp4cSXZ9qAXT/LZc2dXnH3m5cJvsMcT8C/CQjvGwqpM1HO9JzS8seP1ILzC27/YiaoZQzp4rSbXRQ/Ar5DYetjLJZT4vJNXrtY6mqxKmsPgz+/HyIk3dkURr5Ys9oFfvOJ3dsF2Wu3QrmV2HcPsLb2Nkfxva2dRElcx80KdByxxjhRuggXZh0HCpjsgcnsFkePbenFco5RHMIKjU4upu80uuJa
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af3e8c7-a53c-4945-8737-08ddf6800e08
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 06:53:20.7626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qi8fA2s7HPmh55yNoT+i2JM6e9GaBIGV+Q3Ebp/a2Y484nBTMxWXWI8UecdvbjsdmJvVmZTfcrhZQr+2sMf6RvYFu6iAkawGqkY/w7xQ8ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7316

T24gOS8xOC8yNSAzOjU2IEFNLCBIQU4gWXV3ZWkgd3JvdGU6DQo+IOWcqCAyMDI1LzkvMTcgMjM6
NDgsIEpvaGFubmVzIFRodW1zaGlybiDlhpnpgZM6DQo+PiBPbiA5LzE3LzI1IDEwOjI4IEFNLCBI
QU4gWXV3ZWkgd3JvdGU6DQo+Pj4+IE9uIDkvMTcvMjUgNjoyMCBBTSwgSEFOIFl1d2VpIHdyb3Rl
Og0KPj4+Pj4+IENhbiB5b3UgdHJ5IGF0dGFjaGVkICh1bnRlc3RlZCkgcGF0Y2g/DQo+Pj4+PiBb
ICAgMTguOTM1NjQwXSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYyk6IHpvbmVkOiAzOTAyMCBhY3Rp
dmUgem9uZXMgb24gL2Rldi9zZGMgZXhjZWVkcyBtYXhfYWN0aXZlX3pvbmVzIDEyOA0KPj4+Pj4g
WyAgIDE4LjkzNzMzNV0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGMpOiB6b25lZDogZmFpbGVkIHRv
IHJlYWQgZGV2aWNlIHpvbmUgaW5mbzogLTUNCj4+Pj4+IFsgICAxOC45NTcwNDJdIEJUUkZTIGVy
cm9yIChkZXZpY2Ugc2RjKTogb3Blbl9jdHJlZSBmYWlsZWQ6IC01DQo+Pj4+PiBbICAgMTkuMDM3
OTAyXSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkZCk6IHpvbmVkOiAzMTQxOSBhY3RpdmUgem9uZXMg
b24gL2Rldi9zZGQgZXhjZWVkcyBtYXhfYWN0aXZlX3pvbmVzIDEyOA0KPj4+Pj4gWyAgIDE5LjA0
MDY1MF0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGQpOiB6b25lZDogZmFpbGVkIHRvIHJlYWQgZGV2
aWNlIHpvbmUgaW5mbzogLTUNCj4+Pj4+IFsgICAxOS4wNjAzNDldIEJUUkZTIGVycm9yIChkZXZp
Y2Ugc2RkKTogb3Blbl9jdHJlZSBmYWlsZWQ6IC01DQo+Pj4+PiBTZWVtcyBzdGlsbCByZWplY3Rp
bmcgbW91bnQgZXhpc3Rpbmcgdm9sdW1lLg0KPj4+PiBPayBuZXh0IHRyeSBhdHRhY2hlZC4NCj4+
PiBzdGlsbCB1bmFibGUgdG8gbW91bnQuICBJIGFkZGVkIGEgZG1lc2cgbGluZSB0byBvdXRwdXQg
dGhlc2UgdmFyaWFibGVzLg0KPj4+DQo+Pj4gWyAgMzA4LjM1MTI3Ml0gQnRyZnMgbG9hZGVkLCBl
eHBlcmltZW50YWw9b24sIGRlYnVnPW9uLCBhc3NlcnQ9b24sIHpvbmVkPXllcywgZnN2ZXJpdHk9
eWVzDQo+Pj4gWyAgMzEyLjM3OTQ3OF0gQlRSRlM6IGRldmljZSBsYWJlbCBEQVRBNCBkZXZpZCAx
IHRyYW5zaWQgNzgzMCAvZGV2L3NkYyAoODozMikgc2Nhbm5lZCBieSBtb3VudCAoMzE2MykNCj4+
PiBbICAzMTIuMzgzMDk4XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RjKTogZmlyc3QgbW91bnQgb2Yg
ZmlsZXN5c3RlbSAyNjYyYzVhMy1lYWMwLTQ3N2EtYTgyYS1iMjk4YTE2ZGFlMDINCj4+PiBbICAz
MTIuMzgzMTIyXSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RjKTogdXNpbmcgY3JjMzJjIChjcmMzMmMt
bGliKSBjaGVja3N1bSBhbGdvcml0aG0NCj4+PiBbICAzMTMuMzI3Njk4XSBCVFJGUyBlcnJvciAo
ZGV2aWNlIHNkYyk6IHpvbmVkOiAzOTAyMCBhY3RpdmUgem9uZXMgb24gL2Rldi9zZGMgZXhjZWVk
cyBtYXhfYWN0aXZlX3pvbmVzIDEyOA0KPj4+IFsgIDMxMy4zMjc3NDVdIEJUUkZTIGVycm9yIChk
ZXZpY2Ugc2RjKTogem9uZWQ6IGJkZXZfbWF4X2FjdGl2ZV96b25lczogMCBiZGV2X21heF9vcGVu
X3pvbmVzIDoxMjgNCj4+PiBbICAzMTMuMzI3OTMxXSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYyk6
IHpvbmVkOiBmYWlsZWQgdG8gcmVhZCBkZXZpY2Ugem9uZSBpbmZvOiAtNQ0KPj4+IFsgIDMxMy4z
NDQ1MTVdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RjKTogb3Blbl9jdHJlZSBmYWlsZWQ6IC01DQo+
Pj4gWyAgMzEzLjM1NTY5MF0gQlRSRlM6IGRldmljZSBsYWJlbCBEQVRBMiBkZXZpZCAxIHRyYW5z
aWQgMTIwNjcgL2Rldi9zZGQgKDg6NDgpIHNjYW5uZWQgYnkgbW91bnQgKDMxNjMpDQo+Pj4gWyAg
MzEzLjM1ODgyOF0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkZCk6IGZpcnN0IG1vdW50IG9mIGZpbGVz
eXN0ZW0gNmE3NWYzNGItMWIyZS00MGY1LTg3ZWYtZDgzZDk4MDE0OGI4DQo+Pj4gWyAgMzEzLjM1
ODg0NF0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkZCk6IHVzaW5nIGNyYzMyYyAoY3JjMzJjLWxpYikg
Y2hlY2tzdW0gYWxnb3JpdGhtDQo+Pj4gWyAgMzE0LjE3NTAzN10gQlRSRlMgZXJyb3IgKGRldmlj
ZSBzZGQpOiB6b25lZDogMzE0MTkgYWN0aXZlIHpvbmVzIG9uIC9kZXYvc2RkIGV4Y2VlZHMgbWF4
X2FjdGl2ZV96b25lcyAxMjgNCj4+PiBbICAzMTQuMTc1MTA2XSBCVFJGUyBlcnJvciAoZGV2aWNl
IHNkZCk6IHpvbmVkOiBiZGV2X21heF9hY3RpdmVfem9uZXM6IDAgYmRldl9tYXhfb3Blbl96b25l
cyA6MTI4DQo+Pj4gWyAgMzE0LjE3NTMyNl0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGQpOiB6b25l
ZDogZmFpbGVkIHRvIHJlYWQgZGV2aWNlIHpvbmUgaW5mbzogLTUNCj4+PiBbICAzMTQuMjAwMzMy
XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkZCk6IG9wZW5fY3RyZWUgZmFpbGVkOiAtNQ0KPj4gQWgg
b2ssIHNvIHRoaXMgaXMgYSBiaXQgZGlmZmVyZW50IGZyb20gd2hhdCBJJ3ZlIHRob3VnaHQuDQo+
Pg0KPj4gSXQgaXNuJ3QgdGhhdCB5b3VyIGRldmljZSBpcyByZXBvcnRpbmcgbWF4X29wZW5fem9u
ZXMgYXMgMCBidXQgMTI4DQo+PiAod2hpY2ggaXMgdGhlIEJUUkZTIGRlZmF1bHQgYXMgd2VsbCBz
byBJIGdvdCB0aGUgd3JvbmcgaW1wcmVzc2lvbikuDQo+Pg0KPj4gVGhlIHF1aWNrIGhhY2sgd291
bGQgYmUgdG8gaWdub3JlIHRoZSBtYXhfYWN0aXZlIHNldHRpbmcgaW4gdGhpcyBjYXNlLg0KPj4g
VGhpcyBzaG91bGQgbWFrZSB5b3VyIGRldmljZSBiZWluZyBtb3VudGFibGUgYWdhaW4gYW5kIHdl
IGNhbiBoYXZlIGEgZml4DQo+PiBmb3IgdGhlIG5leHQgLXJjLg0KPj4NCj4+IFRoZSByZWFsIGZp
eCAoYnV0IGEgYml0IG1vcmUgaW52b2x2ZWQpIHdpbGwgYmUgdG8gZmluaXNoIGFsbCB6b25lcyBh
Ym92ZQ0KPj4gbWF4X2FjdGl2ZS9tYXhfb3BlbiBhbmQgZXZlbnR1YWxseSBiYWxhbmNlIHRoZW0g
dG8gcmVjbGFpbSB0aGUgaGFsZg0KPj4gd3JpdHRlbiB6b25lcy4NCj4+DQo+PiBQbGVhc2UgZmlu
ZCB0aGUgcGF0Y2ggYXR0YWNoZWQuIEknbGwgc2VuZCBhIGZvcm1hbCBvbmUgb25jZSBpdCB3b3Jr
cw0KPj4gc3VjY2Vzc2Z1bC4NCj4gYXBwbGllZCB0aGlzIHBhdGNoIG9ubHkgb24gNi4xNy4wLXJj
NiBhbmQgZ290IHN1Y2Nlc3NmdWxseSBtb3VudGVkLCBidXQNCj4gYWZ0ZXIgaW5pdGlhbCAxNzBN
aUIvcyBzcGVlZCwgaXQga2VlcHMgYXQgc3RlYWR5IH4zME1pQi9zIHVzaW5nICJjcCAtciIuDQo+
IEFuZCB3aGF0IEkgY29waWVkIGlzIGFsbCAiYmlnIGZpbGVzIiAoMzAwTWlCfjZHaUIpIHNvIHRo
ZXJlIHNob3VsZG4ndCBiZQ0KPiBhbnkgSU9QUyBpc3N1ZS4NCg0KT0sgdGhhdCdzIGdyZWF0ISBU
aGF0IHRoZSBwYXRjaCB3b3JrZWQuIEknbGwgc2VuZCBhIGZvcm1hbCBvbmUgb3V0IEFTQVAuDQoN
CkZvciB0aGUgcGVyZm9ybWFuY2Ugc2lkZSwgd2UncmUgd29ya2luZyBvbiB0aGlzLiBMaW1pdGlu
ZyB0aGUgZHJpdmUgdG8gDQpvbmx5IG1heF9vcGVuX3pvbmVzIGNvbmN1cnJlbnQgem9uZXMgd2Fz
IG9uZSBvZiB0aGUgZml4ZXMsIGJ1dCANCnVuZm9ydHVuYXRlbHkgd2UgZGlkbid0IHRha2UgZXhp
c3RpbmcgRlNlcyBpbnRvIGFjY291bnQuDQo=

