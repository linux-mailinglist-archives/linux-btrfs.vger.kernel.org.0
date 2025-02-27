Return-Path: <linux-btrfs+bounces-11897-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE05A47658
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 08:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1657D188FD10
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 07:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2132222B0;
	Thu, 27 Feb 2025 07:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r4U7gvXD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZTu3uBVK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93432206AF
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740640163; cv=fail; b=iDwAqWwQ8HTA4KROx2VA+tDVTNqfC4uu2udNlAJaSBbbEjxnX19mQIY2kT9QQNcY45QlHIFR2kbNGtuw/5a/owoO9/hRx4fVc3bKvY5JC2HMbgfyDkpjqi+AwchWqE/7/tC7UbdQr3NJpyTnhiGgc9tUzouRKg0q3IWHbfMDYMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740640163; c=relaxed/simple;
	bh=arSQ8VhZV01e3OCEfMisaS/ih8ra5LpLJtoZjWKqU1w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tesoDKxK2itxuX4WosO7DS2ZkAut0LVDIdw6H3m6FRiBk0+YeMSD9aZ/WKs2iBi5F/EoQwSe/zRMcQgX37k1IlIPIeNOezkmU6MVo/AR1qyeJIYBRPgSag0RSsGbihyH5vGIb79wDmnY14QkxyWSEU8m/UGJoYHhquK2YA6wdOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=r4U7gvXD; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ZTu3uBVK; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1740640162; x=1772176162;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=arSQ8VhZV01e3OCEfMisaS/ih8ra5LpLJtoZjWKqU1w=;
  b=r4U7gvXDyQeR8AE3NQQt3vlj91GYz6EcQjHwBRdjQQHeqQyBeYs7S2Q6
   5Lhfx588XsScak3LLUBDVTkzBIRV2UAyI+h0XCIreG3rWlPIWLhMD6vAj
   fwpPLiyb8e9BwuMgzOwjylCAFEL0huYq6cSFTEbRHYxDTUbxq+So5SBnO
   vyCn05Ugl33zCCkzd/HB/dJxhWRcwYdofWD8O25qzzsYKLxZ9aWFlhyrC
   zxQsAStztqXewwbqzYBPRaECFuCV0ER8STQwrIDYKh69o8XauZ5omt4NK
   Vl++2qMDKAZSr1SOuOfOGGSgBnhDblVbOk/s9fH7KtYYoIVmb1RrTXZqd
   g==;
X-CSE-ConnectionGUID: JUpkDsPgSBKHl+cbp1vu5w==
X-CSE-MsgGUID: nWfpo7kcTomTRAE9r8En6w==
X-IronPort-AV: E=Sophos;i="6.13,319,1732550400"; 
   d="scan'208";a="39091763"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.8])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2025 15:09:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XC3RMoA5/V7jH3hUYN3yACz28PHHiO+eA1zLSWxFeG1K1t3GBPQlUI0pJK/u1O9sEgRO5BfL1/25vOagOjkA8wERm7ynL6MAUcIW036eWf5yB0pS494TOVseBwCqgLOll+/yEWhWXIlCNZf/AiVlD9Zxb4etKx7Z70Hzy7n67Lwc9ItdfXNhIe44vhdqyn319O4DFCP3r4ajn/I1AHaFDYodfA3JJp0LAG920VuCvjkl3vS9F4du6EXiVeIUgjA5vrHwcq6rDgxANgQzBQq+czySfPHzsb65eInz23gwGnKBl51JHbXmx1c3+HeLBnNAisVdDet7KwBciXG0kM2J7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arSQ8VhZV01e3OCEfMisaS/ih8ra5LpLJtoZjWKqU1w=;
 b=CE8pCC6owdPmXIdLXdc9Y2gjQzFzPpvKXEBIda3iBlXNTkTBJfkANX0A2jHLARuy5sPyWHUKiz6Jr6aemGcTHXkXtoE099UOU4ovxU5K+4EwlREl74/7cs/BTQr2dWToPisR7sGFQQplV+Y2aXhoWRxdnxuqnyBdKYL5ZxHQxVooY1Tq9yXSreswBtYgTKdmS/pATrklXy2+Mnwq9Mpmmp1j+8HphtPqaU/r+95quCvUnRqxP2y7zaTvdLg8VCLr9Lw5WFpVhL1eidvmfiezgnGQB1SQqTBQNeFzixINDymxy3zPiCAFeDEsG8lcJgK85+kQlsaqvOUtQE1Xxeqfww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arSQ8VhZV01e3OCEfMisaS/ih8ra5LpLJtoZjWKqU1w=;
 b=ZTu3uBVK9Mz9K600/MQQ/cfq+9HawIEtnbk6RQt/4iJ0b3orwp0tYlBis71SMD0SWKwvyLKE5hGjy6aN9r7sbVbiIHUN5mAfrvGCYtGcI/YstFeEAekU3NB8837SviLAuA9Zg1zKJiF4AQcuA7VGAEVNvhMFqSPVnjeXy2nwzKs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH4PR04MB9132.namprd04.prod.outlook.com (2603:10b6:610:224::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 07:09:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 07:09:19 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/27] Struct btrfs_path auto cleaning conversions
Thread-Topic: [PATCH 00/27] Struct btrfs_path auto cleaning conversions
Thread-Index: AQHbiDPyv4W8X0ySzE+XptUtRYEALrNavKAA
Date: Thu, 27 Feb 2025 07:09:19 +0000
Message-ID: <cae09f2f-3051-4254-ab7e-ae1ae3e853d3@wdc.com>
References: <cover.1740562070.git.dsterba@suse.com>
In-Reply-To: <cover.1740562070.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH4PR04MB9132:EE_
x-ms-office365-filtering-correlation-id: 74e38cbb-5051-497f-9c37-08dd56fda77f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c2VGTkpJZW5FR3pxL3JzSzROWTBGcHFiczJmeFQ5Z1F2ZGZ4T21NWG90QUhu?=
 =?utf-8?B?OGRJYndOYkxhNW5jT1cvTWh5SHE1alZSSWhqMEtnVDdJallQM0JsNFZ6VmVH?=
 =?utf-8?B?Q2xnRFZtTFc3K0loSnFVbjBYajJPZldaQ1N5ak1uMkNYWnpQdjdXdWZDY0Ja?=
 =?utf-8?B?b3JpK0hWRkxCNzdXNHFPVDdNWkt0RDA2TFBsYnE2UXFBdE9YMmdCNlo1VHNY?=
 =?utf-8?B?YlBVREk3UW8vcUtRMzArL3Q2M1h1NTAwUGlKcWVQaW9jRi9DTSt5ZVBNUWhN?=
 =?utf-8?B?bVZDd0tDK3BGS0w3eXU5UGc0cjU1c3p2Ym1BMXVEN0NjVlRnMklFZWgzV0k1?=
 =?utf-8?B?VWYxQXNCazRIRFAxaFl3QjErYzRtYnhWWDd2RHp5d01MQVY2ZDNmMGlmb01C?=
 =?utf-8?B?T0hNbm0wRkNJV2djZ0VyRnp0aVZpMGVlZENSY3RkeE94VGxBbkhEMnpvWWFV?=
 =?utf-8?B?QUZWcFlCZCt6dHdHMDZXWGxNNEZIZFpraWhJaUM0L2lFLzdVejM1Vkl3cDdl?=
 =?utf-8?B?aFF2NUpOVXVmRW5rZVVvSkNwY3ZmUGY0VWtKK21HWVU5b3ZlQjhnNVJiTWVY?=
 =?utf-8?B?S0NXQ3lNbVY3dnJuclhuTzU4QmUvOERwbDByNnMzYmZQVUdZNzhTQzJCRU9R?=
 =?utf-8?B?K1FKT1FvUjFQRExhYXd1RldualVpdFd4emdHN0xwK0trNElicHpTWjNmczcw?=
 =?utf-8?B?bU1jZHlPY2NZU1VJemFHYTZ2MUMwVCs1VDRoZGlweXJRRkFsdU00TlUrTlpQ?=
 =?utf-8?B?SERjU0h4S0twSGttdUhZeWttbFg3SmQ0Z0s1NmtDblhLWnMrZHNqL3R3bWVq?=
 =?utf-8?B?N0tybGFWQUg0SjA1WXFadmFNN0w4cE5uNVk1ZGlrc3pGOXZPekFNeGxmT29O?=
 =?utf-8?B?cUF2dG9yWmw3THIrdTlRbnZxWVQyM0sveHhzb1h5VGo3RkVnc2IyNjZtUlJW?=
 =?utf-8?B?VFB3N3pNRGdhSHVyM1B6S1ozRnNZQThwTTlERm5ycDQvb05vc3p5ZU5pR2hO?=
 =?utf-8?B?RmxxdjZMK3NDTTlkUXBib3d3KzdqaE93Tk0xeS9OeXVJY1RlemwrclYvOXp6?=
 =?utf-8?B?cmVNdWFETmZ3WndBQ0NhekZTSHBydjFiazJsR1VGb2VnNG1OdnVTT2VNS1Bm?=
 =?utf-8?B?Nm5kVzJIRmNaYU8rdy9EbVo4SWtPUFN5OWZxb3N0N1c3bFpxMjcrbXM2ZEFQ?=
 =?utf-8?B?OVZyM09vcnc1RlI3RENQOEFubVR2T1YwM3RLdCtzOHpiR0hOanpDUU1QV0Jm?=
 =?utf-8?B?WGIya3pKZ3NlL3pLdzhHR0RQY040cEQ3SmhFeUVHamQzeHhUMndxbU5UTGhC?=
 =?utf-8?B?OW8zYnl6dENUaXZZSEpxMEROcERjNis5RUxnZFBMMHNNMkxKTUtNblJqMEVr?=
 =?utf-8?B?M2duT0h1dExVWU9vT1hqb2hrb29CcGtFendUQTB1U2oweW9aczh0YXFZRDc4?=
 =?utf-8?B?dFZSQVNGczVBN1JJQzFaKzB3UmFCZVZXRXBlbjZiZ25DMXdBMDBkRnFjcWVo?=
 =?utf-8?B?OSs3TVF3cmN0YWsxa1RSa3NGb0tqR0Vwb2tENnF4L3QxZUVoUkFzeTdyakRS?=
 =?utf-8?B?R3JEcENjblJVSWFFODBCZlNUSDBWL1VBZ2pOUVZOQytreUdTTjdaUTJ4S0hH?=
 =?utf-8?B?dzF6RmNWYzZQWGpLVFFva0tuaWhsaklwUldCSzRnQVFKNFpQNXVLVVhpeExM?=
 =?utf-8?B?czgxZ2hHeEozdmUwRFBzRUc5SUdHV2UrQk1SWENaWjRDblVScUZnd2FqemdT?=
 =?utf-8?B?dDhTQmgzNVFoNGF4NWo4bjFJY1BUVXhyTTBXemIrcER5L1JWTWk4dU52VjhB?=
 =?utf-8?B?SzVQRVdBRGd6NllCWDdoSHR2UVhoV3U0RGxMT0c3YWFvWmhLVG92bXg3NnR5?=
 =?utf-8?B?RzBRYjMvZlpUblBSakJua0dLQkdRQVdZUlBnT0FSUTVheXBjSUNkUzl6NmM0?=
 =?utf-8?Q?ew6RFSkPd8w5FhEEVJId3HTeQST0Q/tb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmFnUXE4ckZ2SUMyclBuaW9FK2VkVzc1UUhzWk5RYTFmanV0VWZOTDlaRUJD?=
 =?utf-8?B?TUFJdklyRjdIRXdxTGx4LzAwVWY2OTNISWEvUzFNeDVUNHJaSDRDSTBlU2h3?=
 =?utf-8?B?S1VKN2JFZHRXbWd4NUI2KzBLMHZLdDZIbzFwSzRKM0Y4SWdqa1VtNTZ1OWdF?=
 =?utf-8?B?djhXT1liQVYyS0IrSzBTdHV0bDcyYmx2UmpPb0c4aEtldFl0ZEp4c1NRSEsx?=
 =?utf-8?B?NmpmcDNDS2g4bFhnRmRFODRMd1dZREtvbDRLWlR4WlJuaUZkMzd5SkhnMW9r?=
 =?utf-8?B?ZGo4anN3UDlxRDZTWWdRditHQyszUndKMXRRUkhtTjFySlNFWThHYzJuMnpE?=
 =?utf-8?B?RU1oaHZBVy9KYXJyaFVwVkZJa1ZVbjlvaUdXZXNVbmFINEkzc0tRNGNEdnF0?=
 =?utf-8?B?S09YQm95OXRXcndEWlA4dXcrK3R2TzAxMVg5bUk1SUVZbHczZHNLdU5oM3Nj?=
 =?utf-8?B?RnErSkVQSUpUWitmWUFxL0dxNXEvd1cxQzExNU41RTNHRlRZcGlPc2hCeEFW?=
 =?utf-8?B?S3ZwMVFGNlFhUEpjRHRtdXhpQkdBMGMrUGcrQ1F2NVpwRW1qRmk5T2FBblow?=
 =?utf-8?B?cFdzdFZxdVdqQ2dZRktZQ2FiRVBVNE5Yc1hQVFo0WGlHSFpaSzZOYWZ4OEhP?=
 =?utf-8?B?ZTBpQmZNbENVQzhuU0RXenYxSEpUOStmaWNOcEtPczBSK3h4ZE9Yc3VZdmZi?=
 =?utf-8?B?MzFidWNGYkhKaVhLaHBuanBLSjFSK0Q0eHp6VE0rVEgxZE5mSjA5eERITEow?=
 =?utf-8?B?OHNlbWJSV0xGVGdHUVBWK1U3Mnh2WEdKS0hJSXFkNVI0QVlUcEl3YVFJcGVG?=
 =?utf-8?B?ZWhSc1NKWmRwZExkdUl5N3hzYUhUSUI5TWNjSTZkeGZiNEZhMkZOT0RYVnls?=
 =?utf-8?B?VVJOR3BnTTI0M0J1Mk9iU3NUSWZiT3hXMmtTekpRQkZiN3ZkVFd1cEREUVBW?=
 =?utf-8?B?OXFlOEl0aTFoczkyMTUvQlZZYTkwNTRQZW8reitvQUVMMXdOcnYxZ2l1UCtL?=
 =?utf-8?B?Q0pDbDJod3p4TVpjTEx6VXJGYWpkMFVwYkNhZ3ZSdEZEZlVWZFRZaUJscTEw?=
 =?utf-8?B?T3lCUWVVYXhXOEpZc0YxQ3VVaTBqWmpOMENxWjlUc1Znd0E5Z3ZCVWUzb2RU?=
 =?utf-8?B?Szk1cGpxTVVld2dYN3JaWHl1SDJVNTB2b2xNeHJkMVVjbDJjMlUvMWtVNnpD?=
 =?utf-8?B?OUlVQjJwcFlTemQwazZPbkVLUUl5Vyt2VDN3aFZpVnRyVGNLSTlhdGxnTlRo?=
 =?utf-8?B?REFWZUNwYmJ6a1h4TVMvZDhjNUdvb1dRM0ZYMmRSSEVyeHloS0FlL0l0RmNs?=
 =?utf-8?B?bGVuZjhyVlljeHZXWTlEQVczUU03TW9aQWRoQWJjMFl6d1FzZGdXQTdHbDEz?=
 =?utf-8?B?TFNUWS9zeWZ3dUR3Mzh0OU9hV25jYVBBN3BSa3UxTVlRZjRGY1JVYWRvbmd0?=
 =?utf-8?B?OUFSYjJyaHhTVHIxRVRvV0dTbXd4dnNyQThnOXNQQnR0ejhIYzhJeDU0Nkh4?=
 =?utf-8?B?cjBwa3ptek50aGtxcTJ5MEhUSWVYNVVqeWtEaU8wMExBVnduZE9rTTFiK01y?=
 =?utf-8?B?dzI0akgybkdmeXJ0VDA1bU9tS0hwSndIY2RIRWs0K3d1Z0dwRENSaDVibEMy?=
 =?utf-8?B?QWRhTUV6SGlRUGRmdmd4enM4cXYwV3EwNndqR3BaeGtiM1p4dXA4SWptSU9z?=
 =?utf-8?B?dFpUUkxFMTZRa2sxMXZ5bm9zb3FUQlBwYmlQbzV3bkZqQjJpNmJoaHVsM3lF?=
 =?utf-8?B?Y3piemF3UFVJWGdwRWg4akVtcWN1RktBckVHU3Y3VHFpRWVMa0hKVFRsVkRI?=
 =?utf-8?B?YlQ0T3RSUmY3RVRKVWxCeFN6dHRYTmFiOGlPZFRpR3M4UUtDT0p0US9taXNI?=
 =?utf-8?B?ZnpJVzhUQ2s3RDFFWjdvWnJLRnI5Q0VudExaaFdDZzNJazYzZmpTTXJpaE0w?=
 =?utf-8?B?MFkycENQYU50N0o4MzF6L0dzRy91cjNURmdOY3BzU3gzUkhCRzJwWHpXVTYy?=
 =?utf-8?B?dWZiWkRlQi9SUlpSWnB1Uzd5UkpHVlhKcTVGUGZvR09iNEFyRmVOOXdnMHEv?=
 =?utf-8?B?ZitwdUR5U1FxTWlURUNidW1IallNZmhOR3VHR0xaeVo3MktwVlVpTHhLemFs?=
 =?utf-8?B?d0RkdHVIQXlyK2E2YTFzMjdWZm1DbWMwOGNHUEVwbTZBMHlqdW1JVG5kOFhy?=
 =?utf-8?B?a0lWT1M3YWlTQWNQZWM2aHlqcnE4N1JYSWRBU2NxTHQwZ3NDQTNONDBMQk9C?=
 =?utf-8?B?ZFZ2dGUySUtVTnhQMlYvdXhKd0NBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3D29E7951C4CB47BD2D5497AC36139D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OslMlALwdjz80olfc9gpCnEH9kh3kvK9bP/PgzqiOp1EzexYi1Eyz1m2BbZ/kQSe8RP7ybvvCh0qsql44BM+zOeg9GsIg3v9Pvl+inw2YMaPkBbfUx/zwoF9Cx3SwCE8/NzvFNLtzZDj+ROreDwROzvZbeLMk34XkopOpz1qCjEPuvQVMe8QebbQC5UGqnqn/T1KITN/B5t2Ij+BW6CiEchCD0XZcL75k4xe+PWAwUWdcveTfY3FIB7XeZrczF413yYKqGos3c2sWSd1UL2/rsUlBzfvDKJ7jDCWdy6bzOTTlL37T9wKhjmdPcHTLkIKf5xNNY3fJDPAxLzGkdHpMSnE+f1oXAT7DQ5KGkWNgqGyUF+viumqDqFLYFlf50cZIOEJrImMkXVamWYlkSD8V1qQ66VhhFqoaof1zkD+75OJPWRPTFltBWEI+RN2zcRHXxyErQ0GotTpAtyFfR6h3q0HnahiZoIjSjKyV5rykIX7CqBxeT7Uio+sZZQo9f6l56DsLkg8hoNehVyh9SncyX7v9j6+Lg/3/3jEJp7oQVkn6+KTQH2kOc/JnNSjWURfV6isjFemxjyJ9Cdybo6AQ4zFZKTlL1gNlxU2sGiXYXgDVDErb3/A2HUzRc7MyLgx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e38cbb-5051-497f-9c37-08dd56fda77f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 07:09:19.2901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Z34d+tZSaVVA2oCcfCBseytHcuQu9EAP7IzDZJ/aMD4VMwljZrDa8O9+8RJAq7SNeDhAX1+XZmrBXGOUlfXGNuExqAcEXBCxSm47Y6JhDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9132

T24gMjYuMDIuMjUgMTA6NTEsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gV2UgaGF2ZSB0aGUgc2Nv
cGVkIGZyZWVpbmcgZm9yIHN0cnVjdCBidHJmc19wYXRoIGJ1dCBpdCdzIG5vdCB1c2VkIGFzDQo+
IG11Y2ggYXMgaXQgY291bGQuIFRoaXMgcGF0Y2hzZXQgY29udmVydHMgdGhlIGVhc3kgY2FzZXMg
YW5kIGl0J3MgYWxzbyBhDQo+IHByZXZpZXcgaWYgd2UgcmVhbGx5IHdhbnQgdG8gZG8gdGhhdC4g
SXQgbWFrZXMgdW5kZXJzdGFuZGluZyB0aGUgZXhpdA0KPiBwYXRocyBhIGJpdCBsZXNzIG9idmlv
dXMsIGJ1dCBzbyBmYXIgSSB0aGluayBpdCdzIG1hbmFnZWFibGUuDQo+IA0KPiBUaGUgcGF0aCBp
cyB1c2VkIGluIG1hbnkgZnVuY3Rpb25zIGFuZCBmb2xsb3dpbmcgYSBmZXcgc2ltcGxlIHBhdHRl
cm5zLA0KPiB3aXRoIHRoZSBtYWNybyBCVFJGU19QQVRIX0FVVE9fRlJFRSBxdWl0ZSB2aXNpYmxl
IGFtb25nIHRoZQ0KPiBkZWNsYXJhdGlvbnMsIHNvIGl0J3Mgbm90aGluZyBoYXJkIHRvIGJlIGF3
YXJlIG9mIHRoYXQgd2hlbiByZWFkaW5nIHRoZQ0KPiBjb2RlLg0KPiANCj4gVGhlIGNvbnZlcnNp
b24gaGFzIGJlZW4gZG9uZSBvbiBoYWxmIG9mIHRoZSBmaWxlcywgc28gaWYgc29tZWJvZHkgd2Fu
dHMNCj4gdG8gY29udGludWUsIGZlZWwgZnJlZS4gSSd2ZSBza2lwcGVkIGZ1bmN0aW9ucyB3aXRo
IG1vcmUgY29tcGxpY2F0ZWQNCj4gYnJhbmNoaW5nIHdoZXJlIHRoZSBhdXRvIGZyZWVpbmcgd291
bGQgbWFrZSBpdCB3b3JzZS4NCg0KTGV0J3Mgc2VlIHdoZXJlIHRoaXMgd2lsbCBsZWFkIHVzIHRv
Lg0KDQpBbnl3YXlzLCBhcGFydCBmcm9tIHRoZSAyIHNtYWxsIG5pdHMsDQpSZXZpZXdlZC1ieTog
Sm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==

