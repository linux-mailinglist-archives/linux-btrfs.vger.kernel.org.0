Return-Path: <linux-btrfs+bounces-20701-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D7ED3A979
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 13:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A77230838F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 12:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED1935FF62;
	Mon, 19 Jan 2026 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nBmSr0eW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xyRsf+E6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E14F35FF63
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Jan 2026 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768826971; cv=fail; b=ghq/6NG5D/F/hc1O/I4NT0bZ6lLzzUwSRooyBRMwDEtLdw1mfwhNXpUPt6X3auVa34yXByD4v6oIvTculzFdh9AFaQineqs41pD5LyiJJkYGhfqqGOFowgdXMC70m7jRh+kYhpZCDEif302L9uulLjvipH2/uCYIK9E/5Jkjl78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768826971; c=relaxed/simple;
	bh=EQLziC5suGh/7C99+yeRgUIkCLs/agrscI/28xv9J0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Geg15G/skld68z2SM9AYVITmnlWo03mchDV9kZZEuErAqLY7C0KizjYbG2/XL626qvgObP2eC1saciBMuKQX/KE27Xl5xCFBEGxxdBACtVfXENR6JHtSQy+Ud5zndjb1OCzjimUpAUtJe7pGyLCZFvKaSDt6yv5tPRXQWDCCRfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nBmSr0eW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=xyRsf+E6; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768826969; x=1800362969;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EQLziC5suGh/7C99+yeRgUIkCLs/agrscI/28xv9J0o=;
  b=nBmSr0eWe5V7rojRUJ+TQU2ohtftAn+o3KJryzAJfcNgsE9sifkpqcmU
   AilTVRgXpwPz6CLkNepVVkGUGk86idnTaKwFWTJ8qH28o1qVUSFv/GtZx
   XNZsJeytjpv8huJDj1KcBkjJ9dmKILt2pcUyloDpMv4N4zcoyPvTB16dN
   +FSC9VKUqi3xABVA1raexlFSRHyrDotm4JRlufImLFpTqcqFQjbaBS2j3
   2I/FjeDzziWOuK9wzazLXgqcBvjkOU5i1Fe08pYHvGiOSQJkiHOkuQasf
   gUJv7caJYc6mWWLHDKKOs8JbMzROJtWck0es2ovQP+W9EooC+Ib1o9XBv
   g==;
X-CSE-ConnectionGUID: EGCTTsAOTC+MPNpTbMCx6g==
X-CSE-MsgGUID: V21y/EJiTemCrS1KYaPlEQ==
X-IronPort-AV: E=Sophos;i="6.21,238,1763395200"; 
   d="scan'208";a="139061385"
Received: from mail-eastus2azon11010063.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.63])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jan 2026 20:49:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUWo48Uobg61kcD6T7gxl/DP+P50gMYcWcTX0weaZL1MyrjBfncJQ4sq9r28U4YxcdtwnRX6VE8cmYAELQ79rl/7JByw1eKeh/58ng8L8TGf1NOQ4wYYFMK2f5EphClbEv88WZgCsrSQijgLIl/sf22/cYql7g33fupDokU+rYhOe4ZQj3L1EK7AzVH9nn5HL/Wcf6hkL+rPRUT3Tqzj6kLJ6KYL135vDEjC+0fTioIRXfYGMBmWH5s7FNniJdc5AqVJViTUGNSyeWuWQgptD25qjkRFzrEX84R3W+47SOR5lVc53Nm6LfLKSJi0zcp6jYjJix8QfANfV1arQMe/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQLziC5suGh/7C99+yeRgUIkCLs/agrscI/28xv9J0o=;
 b=sDIYHUv1EhfldWIJHBb5ZjdO/pbRj0wkPadWuR3ZTvHawx/ckzFuY0PAUEhlax863Qck7kFF8j/WU+eN7ADdsuCuvoG7GLIy1CWgXEFui8ArnGFIXMWsykIly/QnMcgANlD2RC/0xfRKxYCYYj9vXZEhYTrQU7yPigMo0vtuQmxUuL/WCE1BAzF168GcG876m3pnyfpEinUZ6aE5BH6bqlhbeG/YIWCMyHXgYEJMI7EHaSUdNSm51c76b9gMGwY9fQ7tX4jmrEThS55o9uc9hGTR4ENeLhJ1T0dlzjCP8ERTPm5d9WqYfrptFSbPz5+sUvBlCctTqpyHFr44ix0vgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQLziC5suGh/7C99+yeRgUIkCLs/agrscI/28xv9J0o=;
 b=xyRsf+E6zsiiCz+yj40p2mmcXuUE62uzrHXKJxrOLx4DDLSN0BW2FwNMVRoU7lngEb1QVTX0xVNWH6upckbFDmfhz1TVDQi5tTqPinm/xlYMf9lcaVb5476FcF/Oy2xigzWJrCLHyvIhbie8k3UTe9cmYps+oSUM48+lKwhlqIs=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SJ0PR04MB7599.namprd04.prod.outlook.com (2603:10b6:a03:318::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.8; Mon, 19 Jan
 2026 12:49:24 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9542.007; Mon, 19 Jan 2026
 12:49:23 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Filipe Manana
	<fdmanana@suse.com>, kernel test robot <lkp@intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>
Subject: Re: [PATCH] btrfs: remove bogus NULL checks in
 __btrfs_write_out_cache
Thread-Topic: [PATCH] btrfs: remove bogus NULL checks in
 __btrfs_write_out_cache
Thread-Index: AQHciRO+tg98LELk80mdVAktYyMPU7VZcKUAgAABRAA=
Date: Mon, 19 Jan 2026 12:49:23 +0000
Message-ID: <ae042a04-6cd3-4ac3-9767-ca1c14f42d8d@wdc.com>
References: <20260119071750.43226-1-johannes.thumshirn@wdc.com>
 <CAL3q7H6yEoJEkGa_4YtvRG-k2nzor6UuvMr1Mfjc2hVQ1reyxQ@mail.gmail.com>
In-Reply-To:
 <CAL3q7H6yEoJEkGa_4YtvRG-k2nzor6UuvMr1Mfjc2hVQ1reyxQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SJ0PR04MB7599:EE_
x-ms-office365-filtering-correlation-id: 8a1729fa-0c3b-4611-4a4a-08de57592c15
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TjBKN0JnMGZ6aWFtcnlibVJXK0Q5YXhCczBKQVVWalZ2ZjFhbWpBZkRDRTd5?=
 =?utf-8?B?NG1XQlk2NjNRNnNJYmZTcUNJK3kxd2ZqWXRVZWNpS1JMTnBFS0s3TnNjaUow?=
 =?utf-8?B?eWxHTnBmQkZWSmxBbERqVmlpM3RBVXJLR01ycVB0RWxxdnBEOWdNMUd6TDND?=
 =?utf-8?B?Tko5a3Fidm9oWHgwZDhKNHYraE8zRkFKbFNMTisyV2ZLSHVEWTVzVDlsSHlv?=
 =?utf-8?B?Q05LRUlpZVdYamREN2pUVDdXcjM1ZkM1QUVkUy9saEgwbjF3ZlpMSXM4WC9X?=
 =?utf-8?B?UE5ZOThSSkxyRmN4RHpGYXVjM1RvVTk5aFVDMzNOMVdKMWdIOTZLMlZHNlZZ?=
 =?utf-8?B?WE9sM201N3R4NjcyT2J3YlNxV1Bma0ZONjMrdTg4TVFxYlBYZzVUSnQ2bVBs?=
 =?utf-8?B?WTlSMGZ0aURKbTU2UXh6NTJvN3JNK2FRV0dPQm1rY0I0RE1oVjZ5M0hyN3Nx?=
 =?utf-8?B?VUJHbC9rRFdrSFV2OEk0U3NBcGVHSmluTitFVjhWenVUUjNXQkdIamMwTm9t?=
 =?utf-8?B?Z25hZmlIaVM5T2RYUFJjRTBLcW1WaXpwYmtMT1VXQmR4ZXZaYmRlM2tiSUZp?=
 =?utf-8?B?KzV6MzBQUS95Uk00REltTU4wYWJvZ0hsT1F4dUdUQ1EwQ1FyckowejhyNjIw?=
 =?utf-8?B?ZDJoQmVsV0RhVjZFZE5mUVVkekhkem9RMmRDUlU3TjB5OC94NWs2c21jRFJr?=
 =?utf-8?B?UFFsaVVqeElGNWV0eVpnSUxDZzRYdnNHL0hYdWN3SDRZTEU5ZlVWQXMxZTIv?=
 =?utf-8?B?Y0d2QlBzTUFmdEM5MFpIUnZZakxYSnJjK3dIbHRHa3hnTEN1dStBYWlaT3dl?=
 =?utf-8?B?bTRqTkF5UWpXMGc4TDdnS205Ly9IUzNhU0pHKy83RlVoYlhOTnk5TFFsdEds?=
 =?utf-8?B?RE1VSVF1SnNzTDB0a1BuZkducWh0QmZLbTBMVjR6M3lnbVlXN2ZQV21wbXFk?=
 =?utf-8?B?NmlGaXRSdzlZeU9LZUVLNzRCM2IxcmVoT3dEL01yNDJaVXdQY2hnMzQwdFJD?=
 =?utf-8?B?WHBWdngwV3VSVmxYV2hMcVlQQkJ6eDNNeDI4ZFJhTU9BRDdtKy9yd2JhZWNy?=
 =?utf-8?B?ZjhUZ2F0M2FydmVET2JYai8rMnh4ajZuQ2lNYjZ2cnpMNU92UmIwRHp4ZGUy?=
 =?utf-8?B?Y2Q5cTRFZTU2ZlcwcTR4ZWJkcjdlTC9hQ3N6MUN4ajJ6Y3luRUdYdXNUVmd4?=
 =?utf-8?B?ZWU3TmNZV2ZBcTVMODJCT3lBNEN6S0JCUkpSYlB5UWNrcE5CT1ZUUGlvSjRO?=
 =?utf-8?B?ejZranBHcGpWWkxuRVRQYm9kR05sRTY5MmNBVmc1OGoycEJ6WkNqejJ4MWFq?=
 =?utf-8?B?eXNzOXl6QnlOb2wvL2xrNWs2dm9ZR1NiM3hRWkxpT0djWXhnb1ptRTFXZU83?=
 =?utf-8?B?V3pmdkVQRnVSZlFKaWcrNVl6VW42dXcwYkFVOGc1L1l1TkR0YTl1RWsvdFFa?=
 =?utf-8?B?MlNrRm1EREdlSXJzdzNtY0phWWx5M0ZyQ3g1OE05YlBKK2xwYzU4RmVMemc3?=
 =?utf-8?B?YUhjUFdqaVJON0cwZmNWOG5ZOUZUKytQNXg4V21FSnF5QlFaTElCMnR6UW05?=
 =?utf-8?B?NnE0dmp1MjdwSjM2MjFUczFYMGo3R3lnSlZnVVlxUnlJSGtIcDNBR2hIVmxK?=
 =?utf-8?B?bXpxb0FhSjZOOFJhTVNjM2FIQjBVWUcrQXNlSS92Wi9vUCs5YkI2V1JQVm5y?=
 =?utf-8?B?bXh2a3o5M0UxYmR3aWdKY2R6NmhQbENNcXFRdTlUSFhCb1hPRDZxWmp6OHg1?=
 =?utf-8?B?LzB4VjF2cWhoTVVDS213Sk5malY5b0N6ZmVaREpiMTdRMUlVcGxYNW9CTTFZ?=
 =?utf-8?B?ZlVibWZaZjBZZERxWkJuclZoaTJ4bDNpWGRBWFJSak1pUGxWVkppVDJVaFVa?=
 =?utf-8?B?OEx0WFdEbEp0T0pCVWxyazM2NlRrbVFFbkNLNGxpTVQrRjdjK2VmZEhDaHho?=
 =?utf-8?B?ZnJLbHhsNjZwUEFOb0ZoVGg5S1pURStNaGFEMmp0UUJNUjFMK0k4bVM3NTBa?=
 =?utf-8?B?b0U3cXY3d0hNUTA2UXdtbUsrV1FmaUtkYUlleGFKT0dYeHZxSU1Fd2ZDbVRx?=
 =?utf-8?B?YzBxdUV6S2R1WnlBMlBUTFVldjFseHVVbmdvVGhWNXN5VXY4Z1lrdXMvbFVs?=
 =?utf-8?B?U3lZOWdjYWNwQ29POUNEcmZxcExXMDdZZm1hMzAweGdiZkIyRlpIdlRHaXJi?=
 =?utf-8?Q?AkeD0GzuDRfAh5WTM5uKSJw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?azROMWZCbVZseEJMWUJxeUdHWCtaY1pQUHhtYlJjeExhYmxrTWxTNnhjV2VR?=
 =?utf-8?B?RldLNzhjNEVGS3d3N1BISmJiR2I5U3FjYkpCQ2tCZ0RXZU0zbEQ2b2FRY2Fy?=
 =?utf-8?B?QzJHQ3E5RlhjRTBUODgyNnFYVVFWblkvZ3RMcjZyKzZndnJEQlQxUUFvME5s?=
 =?utf-8?B?TEhaUFc0NTdOTFVZTHVYcWJHeVU2bHJzM2lLbEtvMkJwMWV2MEVqRXV5dHdh?=
 =?utf-8?B?OCs4c1pFNUlvK3YyanhDZ2dMM1ZXUVdLdlNlODlIZjYzc3crSEFZRFRRZlZC?=
 =?utf-8?B?akhJZEo4T21VTkZFQS8wcWdmSmlNNHpwUGNYbm0xSEFwQzRWNmJsUGUzWXFj?=
 =?utf-8?B?Um9DNEo1NC83TUE2SUtkY0F2bUFHS1cxY0gva2psbzRuN05FSzFSM1NuOHVv?=
 =?utf-8?B?UXorOFRDc3lOMVFQMjZQNmw1MmZ5cXBFam9aU2JMaTk3em5TZ2c0alJGb2xy?=
 =?utf-8?B?TE9YZkVxZS93d0N5N3VRN0M0K1c0dEpPNlRkNDdGREUwWFpjOUprQ2RjSnNa?=
 =?utf-8?B?Ykp3c0ZJcHRMTXh3ZS9RM3BJSEhCZnMyYjlwcVIySmM5cjNQNzVSNlJZdVdy?=
 =?utf-8?B?MVl0YVhjdlluVXVrMEt5a0NrZUlhMnpkT01aTjhvM1R4V1E1ZjI0dWJ2dUZo?=
 =?utf-8?B?bXdDNXVTZDhyR0J2aDhaM2dKZUxwUVpsRTRhRUxGZktpL0c1QU5BU0NZYjk5?=
 =?utf-8?B?V0ZhZ1RQY21QSjlsayswdVNJTk9WNE1UYmp1WHhXUmtKSjlMd1hQMGRZMU1l?=
 =?utf-8?B?TG5qS2t4TXkxQkVtN2R3aFUzbEkyd0x1MW0vbmNiR2N2Ykx0TlM1LzdPbTFH?=
 =?utf-8?B?Sm4rS00waUN1M1lIRFdEdjl5TmJhc0F1NUZ4K1VpalFWNmhkUi9xT05PdkQx?=
 =?utf-8?B?VkhPVzV3K29SODBDT2l5ODZvZUhiZ3puUFVBcU5ZdGdScXBJTGh3aHptdFdw?=
 =?utf-8?B?YUVSUFh5Ni9pdDZoNmlVdU9xTmhTaE9PRkM3V3FXaHk3L2hFZEtvdWg2ZVNM?=
 =?utf-8?B?OVpGQWo2T3BjaC9XbGxGcUdVZkNYTVJEcExScnZyUSt4bmtUc1hxR2pOQVUx?=
 =?utf-8?B?T3VleldWZEFaT0NhalA0RFlYWHNrbFlQMFZkaTFObEVCeU43R2pHb0JqRFVG?=
 =?utf-8?B?MDh4WEFHM28xNnlZYmpMVEhTYUk1TEdiWEM3MDhQM3MyZXJQVnIyeHM0K0tW?=
 =?utf-8?B?YVlDeERiLzd6SlpkSnBXNVZTOUtqejFwc0hDYlVySU1LMjVNK3EwdG5aSjZB?=
 =?utf-8?B?Q0pEWkE0SVVJWkQwQUlIMmd4SGpVL3JOYlloZHlvTWJVMWdOQlRpQnFlMjNJ?=
 =?utf-8?B?TmZsU29IRVo5ZE5wSG12VmxPa3pVSjI5MVNTeDkrMXNGUEtqSEJrZVpuWk9l?=
 =?utf-8?B?NUVGa2pyVFR4V05Ic0tTVkJmSWVFaGhhUjVHRkJiaGFQb2dtaW1RWUVqb2JY?=
 =?utf-8?B?RU5HVGhtOTRHTmt1eHpoamMwRHVhVEtHYWttdFNydEhPU3VpWENrUStrQlFC?=
 =?utf-8?B?TStKc1Jyd2FmemRXU0tVNG5RZG5teGZ0a1N3VFZocjhUYlZaem9Tc0ZWWkVO?=
 =?utf-8?B?VDNYTS92SzU3MTRnMzcycnIzRlBHVDJDVmRubGFvQlM4TEhpWDlpVzkyVGZU?=
 =?utf-8?B?MWNqV2drRXN5SUwzSjZwQ3U3MFQwbzhKYS9YMk95bUdxNGk1TEY4ZWZKUUxI?=
 =?utf-8?B?bjloeEVBTnU0TFdaa0NseWc2RFFZZ1ZqeFZsdEVGSkpPM21oU0MzajNqYnAy?=
 =?utf-8?B?ZUpNOVJ1OFlEM00yTGVNN3Vpb2JFSkJGNTdiZnMxeXBqcitqWU1aT1FpMmpv?=
 =?utf-8?B?NWpBRGRYd2tQOGF1SDVsWkpBMnMrV2hNT1BQcUl3T1J0ajM4M1RnM1RGQW1x?=
 =?utf-8?B?UFlkSVVrVSswSFBVRTZhY2o4QXU0OFNkeGRqNEtPdm9TY3BOdmFYbUtWSVlu?=
 =?utf-8?B?VTM5VDB5c2hXaGRCQWZYeCtzeVFEOFowVlpOLzBFQ0RGNkIzQi9iZWxUQlFP?=
 =?utf-8?B?SHhQTGlvSjFUTEJqcDBrMG1zRTFudFV6bEdtaWx5V21EQ0M5KzhYblVuTTJV?=
 =?utf-8?B?d25UallxTjk1ZWJWank4ajBPU2RSeWd1NXlyd0ZWTnlnWlduNENHT0g5SnpX?=
 =?utf-8?B?N003ZDgybHBPTnVRM1FKcDlLSWRvV252VlRuZFplZGplUjl6K3hVQ3A3cXRZ?=
 =?utf-8?B?RUJCQjN0UEdyQ0ZkYzd6WCtBeElGdEI1MWN4WWMyOEFxRnRPeE14Qk9HTGxy?=
 =?utf-8?B?RXJ2OWRoUFpwbkRWT0FpZDNWcjZGTXVJd2NmRlVBTzN3VmJ1dlFGY1hWVEtr?=
 =?utf-8?B?K1FjRGQzTmJCZTVvbjJxY3FJNysyVjQ2M1FiOENSYTZ2S2syOXgxTXdBWGNU?=
 =?utf-8?Q?KWm9t1fA6NwOJBjOv4jscdOUoPgEcI+pfklUCs6aDnCrW?=
x-ms-exchange-antispam-messagedata-1: UGo+Y78DuJS17we3njbRcXz190L0LMMqSMI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <962E4D40CE9BB64A8C568B770D19DAF4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A0DXnz34J5BIKD7TUyn3+wBoa5vi/JjvUzUQ77rzyCfpHbap0lbXxpu14Q15HNBSb+iR2mhKVPN8pTVxEDOXuNs+O7NLA2LLM502bTvVp0wH2QN9NblgYADa0xudgHHGTDNt1w2YtRqIF+XiiPoTy7MzZOssSqVam7S66eoL8WsJSBQKj+es5mNNS+R6r6ZAjFE7KtJk9AncguwYBTAD0ULE7AX8eK2FidJk+w0YOGpPR7Ai9dspyEYfcb5cT70gO8KEVNxISLmRQgBcLbrs9wS+lfMmB9iTeAig3g3XAmH4JVPZl5y8Sw/KFuYSS7Zu98+RI9CUHeu8wBme2xpVcsNCzFI3sMH+dun37YaK0S1KN2dy+2dU7BDy2QzNZ7I+7EaEg8OEAiqWSEJUcc5zfziq4taqHfP/03JPQVfDhjNpG6DyWMC9c3bMTeZt+6z09edoY+vDkSypA9oVbBslEuce8O7m2n2i6EnegIxELvZvo7Ktf4XSloLO1W3rZHYLEkv4aEAFhjaG+po1KJ0D8xc4H17hm657OYIQXfCAGjRVOizgJ210r+M4C6jcOJpJG7vzp1viYBHXmWCLGXLmfY089xexCpi34EnFk5c9Ir350QN3fgkIPam7cQHsUB5Q
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1729fa-0c3b-4611-4a4a-08de57592c15
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 12:49:23.6324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2S+FoS+J+5Wpptpt3p22wTVQDnAXScKatHYmOw6KKzMy5Zwnv4f+IQ/Jlcx/W18ICjOzj28bR7NzVd6R3fm0iJI+P4+PVciwBsKjBS6GUf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7599

T24gMS8xOS8yNiAxOjQ1IFBNLCBGaWxpcGUgTWFuYW5hIHdyb3RlOg0KPiBXZSBjYW4gYWxzbyBy
ZWR1Y2UgYXJndW1lbnRzIGJ5IHBhc3Npbmcgb25seSB0aGUgYmxvY2sgZ3JvdXAsIHNpbmNlDQo+
IHRoZSBpb19jdGwgaXMgZXh0cmFjdGVkIGZyb20gdGhlIGJsb2NrIGdyb3VwIHVwcGVyIGluIHRo
ZSBjYWxsIGNoYWluLg0KWXVwIHRoYXQgc2hvdWxkIGJlIGEgMm5kIHBhdGNoIG9uIHRvcCwgYXMg
aXQncyBhIGRpZmZlcmVudCBjaGFuZ2UsIA0Kc2hvdWxkbid0IGl0Pw0KPj4gLS0tDQo+Pg0KPj4g
Tm90ZTogYSBmdWxsIGZzdGVzdHMgcnVuIGlzIHN0aWxsIHJ1bm5pbmcgYXQgdGhlIHRpbWUgb2Yg
c3VibWlzc2lvbi4NCj4gSSBob3BlIHlvdSdyZSBydW5uaW5nIHdpdGggTUtGU19PUFRJT05TPSIt
TyBeZnJlZS1zcGFjZS10cmVlIiBhbmQNCj4gTU9VTlRfT1BUSU9OUz0iLW8gc3BhY2VfY2FjaGU9
djEiLCBvdGhlcndpc2UgaXQncyBub3QgdGVzdGluZyB0aGlzDQo+IGNoYW5nZSBhdCBhbGwuDQo+
DQoqZmFjZXBhbG0qIG5vIG9idmlvdXNseSBub3QgOigNCg0KTGV0IG1lIHJlLXJ1bi4uIEFsdGhv
dWdoIEkgZG9uJ3QgZXhwZWN0IGFueSBkaWZmZXJlbnQgb3V0Y29tZSwgYnV0IA0KYmV0dGVyIHNh
ZmUgdGhhbiBzb3JyeS4NCg0KDQo=

