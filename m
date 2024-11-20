Return-Path: <linux-btrfs+bounces-9790-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EC09D4016
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 17:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E972841A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 16:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCC314F9F3;
	Wed, 20 Nov 2024 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W1tYWLXA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="D9FG45Dy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D278713B2BB;
	Wed, 20 Nov 2024 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120281; cv=fail; b=OhyHPi7Cnc61+kQh9W0aT0HChxWaIlDME1h/pnMXRakmwVnfmTTl5SdNtJfHnVcjRuY58YA1FFNqjPlQ3JxVg+rthwpE25zSHs46EfhhREXSVpEms/ygdee0Ov7HxLzKaVIb4Mz3rpZlUNe+LU1JTL4SX6ilhDASU3Wt4m+Evss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120281; c=relaxed/simple;
	bh=QJYMeDahmuMdOuSWDkCSp1+sUKv5QJGUcidbOiye0BM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iOFkyN9JIgS5TpMeqlYXgWJIOAuEFRHKl47rEv+9SKRIspFRbf+8DsIUM21nbPuaXYoCwA0/jH4JGHAHPz5pENX5gk0Rl7tvRyB9uo+5rVRJdcrsE5TgRpRf2650izc9zh7sEgV2XE9XeUpm2RNOgMUQEOOd0Qjx0P+RSWrR/ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=W1tYWLXA; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=D9FG45Dy; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732120279; x=1763656279;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QJYMeDahmuMdOuSWDkCSp1+sUKv5QJGUcidbOiye0BM=;
  b=W1tYWLXAoWfMEoRlnBuimZV+Nu/uBsPznzA5qRaTU/uv/ch6+oiSo3/G
   qyM4sl0Zx4Rxel0Ej0Ug4AwelHAowKzV3YrtvZoNY0q5k6x4CSf9k6k9P
   3vfM6X9vWUDgjAea7Cv7ixR+XGKXoK27k/+foi9VKmv4ydBW7ZhelxCu1
   Ai1nTxIh3pWsPsccIYOM8hW8/fHL+j2dE3mf+dfs+9qAMvmIRk8zJNwlK
   e71jJ2+A9Cj+KXkbD/Z09/erp9oz0/Vof+IGnUe1rWlkHcZoyXqcyyP6X
   z+/rouzYJD2C1TZHB31fsGA7TbyeEggJvhiv9wNX85agHsT8AaO9rBbeH
   Q==;
X-CSE-ConnectionGUID: wNcXbieoRR+At9SGvL3ZJQ==
X-CSE-MsgGUID: jFuRikUhRdC66SHK3RLDmw==
X-IronPort-AV: E=Sophos;i="6.12,170,1728921600"; 
   d="scan'208";a="32471486"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2024 00:31:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGkZZhSu2vONi1IGWc7y+0g/79Lc+L83HHZd8GLZRi8Y1QgEpFuPjtpwVPmsAe2U9QD2h28i6GnTr4AV07OIdqR1T0kXl3bDZFs0Tf4CUmQXfjjuJW3fgL4QthTFaHq5nXDWZJT+PGeJkRvRUpnU3u0nm51LJvD2zp2G4GHCSJ+fdWh/FD/lsurAEyGC6kMaTLmpkNg/+ToblwYvH0loYFPgTJniDKAOu8wHXliYgXMO8fD6VGIWgJSqGv67lSmi0bWKIBFk3slbd6Ngt95mZhc16UEjUSjyfKOKUY3Xzpz2T9vdX3Mo1/WvSOymHN++u1W2HDqTvxrEIWOW+Ou8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJYMeDahmuMdOuSWDkCSp1+sUKv5QJGUcidbOiye0BM=;
 b=efyI/85pioNwlwtwULcrSitMvJ5rjZrfuyVo7q7O6j97prpURadKz+VllA8TL2FviT6qLm6v2Rh9M0jwZUN5Si9ohsw6+1KCqOxlrKrfh0huirRUe8NPhuC1B4Y0/2VOVh7PRvqCX7Vw2HfIsHPX4y2Hfx5v1EPkYfSbvzHVI55U+G1Jtd9CzuuhOODvGabXNmh1rpaj/nuF0mbOY3Q07vgUXmdOG80qxcwhbHn1m00gd+HYWqmpzjTBRDgAZzq3bvEgl53+/P/+9GHygokDXbDv1qsjdWKF0sxnm2rmR67OJZRMj7Nj3vxsiiNa16W+v/127T7FGemyqsoDtdk4EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJYMeDahmuMdOuSWDkCSp1+sUKv5QJGUcidbOiye0BM=;
 b=D9FG45DywsozHPdXCK7JmCCHnNH8VpuLkhZNu67XOZpnypEdg2azLixe33dm+pqzPKAhuTcrl4th8JY2h89/WOOZ0ckK58RBS+bzBcAKIF9oWdSMm2l33mxrPFuVrnRtlzGavwZRMH9Lh1tJRaldp2g1QZLVKIOOG6EsHv4m/lY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6967.namprd04.prod.outlook.com (2603:10b6:610:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 16:31:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 16:31:08 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Mark Harmstone <maharmstone@meta.com>, Zorro Lang <zlang@redhat.com>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, "zlang@kernel.org"
	<zlang@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: add test for encoded reads
Thread-Topic: [PATCH] btrfs: add test for encoded reads
Thread-Index: AQHbNEniaq8NpBtZMEa4JGq7F4qOsLKzZGgAgAHCH4CAARbUgIAKKIUAgAAEv4A=
Date: Wed, 20 Nov 2024 16:31:07 +0000
Message-ID: <aef2abd7-8cda-4e5c-981d-3ac6da04335b@wdc.com>
References: <20241111145547.3214398-1-maharmstone@fb.com>
 <bf3e4e63-6496-46f9-972c-c0b5c7c4de39@wdc.com>
 <28c2834b-3223-4191-bb10-81ce53c010a1@meta.com>
 <20241114050631.x3urk2ti4ukgtaai@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <bbeea4ec-2f77-47fd-ab5c-6319d4248496@meta.com>
In-Reply-To: <bbeea4ec-2f77-47fd-ab5c-6319d4248496@meta.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6967:EE_
x-ms-office365-filtering-correlation-id: c014718a-2243-48a4-6fdc-08dd0980bc8a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UlhjZ1BTNjhEOGJHMXY2TWFxb3FTTWYweHFVUElxUXdDMGpWTk9rUVpOcHhx?=
 =?utf-8?B?ajBPRlZrV2Z4SjBIb1BOSmsxcFFVK2dQb2VLbXpXWDRnRUkycVNnckVlUXZC?=
 =?utf-8?B?aERSaE1Fc25WbkdORDZZTkpYLzNlWUtmSGZZYUlSWGc4amJmVGFTQXBaV01O?=
 =?utf-8?B?WEp2M3dRTGh1RzRncmRGSThaVHdFUXM1S3d0ZlNyVmZwWXc1Qy9VSE40d0Qy?=
 =?utf-8?B?VmUyOGV4OHVnZzZsb1hnU1FKbjRoa2VQdzZDSU51WEYydlB1ZldsSTgzdk1j?=
 =?utf-8?B?TTkyMWlKdEprZUkrblFqSndhTlJ5d1k0SHhGQ1hTNnFnTThVNWdVQkJKVG1q?=
 =?utf-8?B?RGo3L0RGNlJWRHA5eVM2a1N1bGxvWHVjc3ZmS3lQU1hlQVRyNHk3MDlEZ1J5?=
 =?utf-8?B?SmpFcEtlR0cyRWxqanM3RTk0UXZOLzRZc1lJOHE2YVJqVXJXVFJOdnpYaFEr?=
 =?utf-8?B?eDZ0K0tPMWtxSlNNN0FhTWoza1ptUnEvUDdyeEl5WktJQTlsT1dveUpWbEk5?=
 =?utf-8?B?YUdURVRxaFR3MWZSQmZ6b2RRN0Znd0c1cWUxOGtLeklEbjVMMksveFhNak5K?=
 =?utf-8?B?TFNpK3hoc2FIcW5GeFJPQUhWSlJ6WUdGV2dGY3ZDdWdoQUEvTlBwbVpaQWtQ?=
 =?utf-8?B?a2V0a0w5UWE5RlFHais2ZFZBWUpZaThLVXQ0cVdVWGcxcW5MQmg2aHhXOUMv?=
 =?utf-8?B?dDBGdXF0NERFSEpjM05VUWg1WWw1dFVIbVluamdHL0g4ZVFHdG5pMUlkWC9a?=
 =?utf-8?B?UDVxTEVIdXBtL2tiVEh4Mk1KM04vQlVqeG9jTFdGTFo0M0xNZE1OaDc0TXJC?=
 =?utf-8?B?YkNUekE1TU1pYnFWN09NWkZTeWNGd0JZUFhiWUJEY1UyQmEzTXY0TW1ERkxn?=
 =?utf-8?B?dVFKSzEzTkdTVStKVFJmczZROXhKSCsyblptalNIWEEwNzBVbEI2dFhKdm9q?=
 =?utf-8?B?Tjk1cWpodVlJV3c1NkdnVVRmcUFuKzJxRVl1MWt6T3Vlc2JTaitVUkQ5K25t?=
 =?utf-8?B?QnBNQy9jNTJMZ0NBWVZ5dUpQSFlHcGNFbnV1R0pPbjd0cU5uaklzT0hxM2lw?=
 =?utf-8?B?b08wbE9abnJKR05OZXlCZk1pNmpKVzFPVzJXVDNTT0diQ2wrM3JINVA4WHVx?=
 =?utf-8?B?UHEvTXhWc3BBNkR2czRTQ2ZoRWtubGRldnRSNno3NklUdlkvaHBRSnd2TWhH?=
 =?utf-8?B?OEZYcXBxVVBKTVE3Zk16a2JXa2RLb3NId0xXc0wySmtRNlJndytyWWQzQ05S?=
 =?utf-8?B?S2E0T25GcEJlSGxsRlBjRDdIUTk3aE5VSU0zMXF1a2d4N0FxUkx3b1FMZ0hs?=
 =?utf-8?B?L2o2bUhZZ1NGOE9VczU1eEx4YThXa1Rna1hjTi93NFc3bVQ2cWNmZHlINncx?=
 =?utf-8?B?cVU2dURPM1dqS25ZbkZMWkdkNEJJN0l3aDdPZzBhM0pjK2RIM1A0dU5TZkVz?=
 =?utf-8?B?T1hRWTN6L1duV3I5V0VteEVNNHorcVpIYk1HS1FrQ1F4eXBLYnFRbEMrc2Za?=
 =?utf-8?B?V1lPQWVVZjlOTjdQZHlnMzRqSGhyQ0t5V2dZVURzYzdTK0NSczFTQitwUWly?=
 =?utf-8?B?MFJPWlFXbXlKaFNOeU83b1lvZVpqdFppQkR4eE1WNFhPakZlM1R2R1JyK0cr?=
 =?utf-8?B?b2NESjFmczd6Q0l3Qm1JUGRNTkprc2JRVStJZVZUSE9BY2xMUzhDbi83b2pm?=
 =?utf-8?B?WGJGNUE5bm81T0FxdThIczZ1VllaLzFTQjczUXZJL1lPYjFSbEQzeGJaeHVP?=
 =?utf-8?B?RVRMcjhWYmRsazduZmszc25rak5Ob2F1bDB0SGh2N2xhSzh2NHc3SmpKUWg5?=
 =?utf-8?Q?R1tAHFeionqKgCIqdtQBjtSuKmMyFQzLbdpWI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTB3WllpQnIzMWVYYXM3ajJkZVVwTEFpRS9iYmVwK2pyQVpCb3I2Vzg0bnBr?=
 =?utf-8?B?UjlBd3RLdFd5ZFJLbEJpVThaMS9ybGJ4dHdaTnZuOFg0czlxS0hML0NVWHp6?=
 =?utf-8?B?VjFMTFdIOTRSVVRPZ1lGMzJmMTkvcHlvdmlNc00rQk52cXNOWGtsMXY3UnhB?=
 =?utf-8?B?d0NyUjZpKzRVZVY2OWNtajVUdGZ4U2E4aWFVOXdEWW1MNTNnbnJKSzAyaXUx?=
 =?utf-8?B?d0xiU0R1eThYWHBRaU5Ud2JBa0Vhb21iT2FSMUZxaFdmZHJULzFab0c0bE5X?=
 =?utf-8?B?YWFnR0hDUlIzcWgxTmZvdDcwRWFETmtGRklCUU1jR1pTanVpSTBtNS9qUVhl?=
 =?utf-8?B?Sk1yV1VrK0psVEU1UCtpM2k4VlZFQ1YvMHUyS1J2S3ZiR0dnbmJMd3VXelhx?=
 =?utf-8?B?a2pXZXhEdWp5NHRHeTZaZXR1NldlRHdZb3ZyVUdDcGRzNmFRSTRpbCtqNHVL?=
 =?utf-8?B?ajRlUktoQzRkVGhydUdENXJiOTZhWUppOW9zQnFBU0FxTldWTCs0WTJYVWhD?=
 =?utf-8?B?dFpNbUYyZ2lFd1lTcHBjNzMyQlNWUTdaTkNWZHYwSm9NZFlKc3lDQytCYVZi?=
 =?utf-8?B?VFlCZC9XSVBrN1B2TlVhUzBISE9aRkVSUjFHZUtzcE5pekxqcjIwc3BHazEy?=
 =?utf-8?B?STlTbURNR08rS2NYVitOT2NEeHN0bG9RUmExQlFwYXEzc0R2RVg5b1BxTktV?=
 =?utf-8?B?alFUemo4VXJURktTL0VzUDVhQ21PZWZYYy9ZRllhM2NtOGpheVM1ZDE4TjZl?=
 =?utf-8?B?dEdKZWZiMWdjamFaM0hCa29lelFTNXpIaklZOGdXc0hzdG8reG9sSkI4MlBL?=
 =?utf-8?B?RFhuam1FWm90V0UvZ0dySzAxQ2UwdFVLODhEY0NidzBXSVBqZlZCSTFyY3BI?=
 =?utf-8?B?R0Q5eVBKNlFnaWlJdmNEK2pKL0pNVUNjeDNWcFVZQW1XODlCT1dBYjhaOHo0?=
 =?utf-8?B?eExiRTBsQVFWUFkyb2tSZnViOHdkN21ZczdKejdtOE9mQWFYdjlTandBZERR?=
 =?utf-8?B?TVBYZS8yWDZ2b3pndmJxNzhBS25LcCtaT2g5Rk5HblFwRjZXMDlhMWNmZ3J4?=
 =?utf-8?B?eDd2bGpIYmkyRnRxYVhWZklEVUY2S0hXR2QwTzBPMjN4QkVwLzFWNDBZajB4?=
 =?utf-8?B?T2phSEI2Y3E2aUJENUlBbGRQVFoydzk2cnVyYnI0U2hMK25pNkZiTW9NYkFy?=
 =?utf-8?B?ekF4bnl3blVyN1dPU0pLUWtVMG9ZSkdtWDBXUWlrMjcyQlJDczVFNzVMTGdV?=
 =?utf-8?B?RmVQTmtPNUpVSXFmRVAzakcwN0xBeXpkMmNxWU9yTldSNjZKYUc2enBwalJK?=
 =?utf-8?B?YVNWUGZVbzQwdXAwSDVQTDFMTkg3YWhJb2FnWHdzN3JMUGhManJrTGFqRExt?=
 =?utf-8?B?cCtxOUR2UmI1dmVFUE5NUDJTUUloaGdtbGxFVnEvSWRvSkt0QUhLMDFxQXVZ?=
 =?utf-8?B?UFRmb2VTOHNpQVNMQXA4Qm5kUThjQkJKVDJYVXMycUhVdFFsVTJNNVAyNk1P?=
 =?utf-8?B?M21mcjY5cEJFMjFZbE1kbWdTVzBzL1luaTdqZmlQWFhYajZrbWlVTkU0d3hj?=
 =?utf-8?B?UE9ueEFVSkNWSFhTVy9QblNQUDViR05RdzdIV3dlaEhLY3R0VWJZVnExZ2xL?=
 =?utf-8?B?bWYzTTFCT1hZWXdTVU9wdHpJRDNTRENLU1lUeGpNVXFHTWRWWkpBLzlPWW9w?=
 =?utf-8?B?dEpLYXpaOHJzM0dNSGptTEVvczJFM1NxamN6M0dPd0diSC85OTkyZzRNNUtw?=
 =?utf-8?B?N1RmeFB5ZlMzb0FGRFkyeGVwK2FubWlWRVE4bWxqMjRDcXFEQWU1VkkyVDdT?=
 =?utf-8?B?dlJPa3ArMDU4UjVOMEtBWm5vRXdnejdNMkZ0M3FPM29tMitGMEI3TTRWTlpX?=
 =?utf-8?B?bEVZSEl0azM1bDJVeDJjbE1LeG9mdHkwRlFZMHNxK2pwS3c4a051a1g3Zkpp?=
 =?utf-8?B?RkxwMnFOMGFnTC82bnJTSTdoQUNxZDhGb3VsSThqandGbXhNRHFhNzE3SEN1?=
 =?utf-8?B?bnJmK3d3WFBpeTh6V1MvV0ZMQkZuQjJzZkhkSy9NYlowOVJNZFBFdlFTMjFM?=
 =?utf-8?B?Sm9ZYzI0RW94OVRma01rZFc1aGx2R3orZnlBRmRQRm01SkUzQzZyR29NUUxh?=
 =?utf-8?B?TUd3akdGdGpiTHp5RFU3SGx5WWZpSVFnejdZMGFDR1BlSHZRV0EySG83WlFW?=
 =?utf-8?B?dm1nbkJaYWlOZkxMb0VIL3ZUalRxWGFpTGVHdThpajlsQVNXOVRNZlVrN2hG?=
 =?utf-8?B?bVhrTlFFeG85NGNIT1pTV0V5SktRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0203A91568271641A44D9A2600651D3F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k9V/gNW3VQ8PGvqErQwxep1QhvA93LeLt02mj/eWXy/CQ9NJ5yW1icZ0YBo9Y/+uda/57JDtUpykD5LUoh6brMAZQkpVIEJ0jz9MU5UAM2D+k7T5jN6qT94Msfh9pbJyu59yx7RQ3vazmnhXR7AdLUiB2g/3cHF2enlMR9Mk949TrR5jHN79qG8Nr3L8LxjnAncOevtwkVKySlxE/0uxf2Of8khCekm+EbCzakQnMHIzMvpsI3+p1nJ0x02d3q07oFzmtzRnfyDwfExKOB8xapbnSk1bKscdao0GCkEuSMu6B6jk7vPznRfhBzM5OHWaVdarVUBUClod3Nfua2RxxJaMX65S1xNrz5C0t0OopDBKet+XfzKlP3YfIwMxfOLVwhYmMOwbI3COuHUMsHGusuURLfYSXw4HtF0InBqq7Z5bgGKKLQUDvsIfoK+ImbAgwPMpynKcgE2BhEAlH0Ry8hUlvoCTCRF5qnSSJela/9NU3Rm/RMhIF1NLDpoOktPKOmS3SLAX4dCQW8Ptnl1TysmkDnHqIl5WsBfo2yaRyUFaztj5iIBIBgawYOse87PSmEHPVK5S129iCfZbH+FBq6VpJ1w314Jk63VYo9/EOBJV9w7LJAnnTgBlNF/HlEyW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c014718a-2243-48a4-6fdc-08dd0980bc8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 16:31:08.0073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cua/498BoDxM2lm8XYH1fTEVQALRxrb5uSxMcEMoyB0PpNtrU/4TOC3Vhe/wlAmpcdOwqyaYVE3bVMxLlvwXCZ9Se5xu4aGZt3oKk3Lk6nM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6967

T24gMjAuMTEuMjQgMTc6MTQsIE1hcmsgSGFybXN0b25lIHdyb3RlOg0KPiBPbiAxNC8xMS8yNCAw
NTowNiwgWm9ycm8gTGFuZyB3cm90ZToNCj4gLi4uDQo+IA0KPj4+IEl0IGxvb2tzIGxpa2UgSU9S
SU5HX09QX1VSSU5HX0NNRCB3YXMgYWRkZWQgdG8gbGlidXJpbmcgd2l0aCB2ZXJzaW9uDQo+Pj4g
Mi4yLCB3aGljaCBjYW1lIG91dCBpbiBKdW5lIDIwMjIuIEkgZG9uJ3Qga25vdyB3aGV0aGVyIHRo
YXQncyBvbGQgZW5vdWdoDQo+Pj4gdGhhdCB3ZSBjYW4ganVzdCBkZWNsYXJlIGl0IGFzIG91ciBt
aW5pbXVtIHZlcnNpb24sIHdoZXRoZXIgd2Ugc2hvdWxkIGJlDQo+Pj4gcHJvYmluZyBmb3IgdGhl
IGxpYnVyaW5nIHZlcnNpb24sIHdoZXRoZXIgd2Ugc2hvdWxkIGJlIHdvcmtpbmcgcm91bmQNCj4+
PiB0aGlzIHNvbWVob3csIG9yIHdoYXQuDQo+Pj4NCj4+PiBab3Jybywgd2hhdCBkbyB5b3UgdGhp
bms/DQo+Pg0KPj4gMjAyMiB3YXMganVzdCAyIHllYXJzIGFnbywgc29tZSBkb3duc3RyZWFtIGRp
c3RyaWJ1dGlvbnMgbWlnaHQgdXNlIG9sZCB2ZXJzaW9uLg0KPj4gSSB0aGluayB0aGF0IG1pZ2h0
IGJlIHRvbyBlYXJseSB0byBsZWF2ZSBhICIyIHllYXJzIGFnbyIgc3lzdGVtIG91dCBvZiB0aGUg
dXNpbmcgb2YNCj4+IGxhdGVzdCB4ZnN0ZXN0cyA6KQ0KPj4NCj4+IFRoYW5rcywNCj4+IFpvcnJv
DQo+IA0KPiBPa2F5LCBubyB3b3JyaWVzLiBJIGNhbiBjaGFuZ2UgaXQgc28gdGhhdCBpdCB1c2Vz
IHRoZSByYXcgc3lzY2FsbHMNCj4gcmF0aGVyIHRoYW4gdGhlIGxpYnVyaW5nIGhlbHBlcnMuIEl0
J2xsIGJlIGEgbG90IHVnbGllciwgYnV0IGF0IGxlYXN0DQo+IGl0J2xsIHdvcmsuDQo+IA0KPiBK
b2hhbm5lcywgd2hhdCBkaXN0cm8gYW5kIHZlcnNpb24gYXJlIHlvdSBvbj8gSSdsbCBtYWtlIHN1
cmUgaXQgd29ya3Mgb24NCj4gdGhhdC4NCg0KSSdtIG9uIG9wZW5TVVNFIDE1LjYgYXRtLg0KDQpU
aGFua3MsDQoJSm9oYW5uZXMNCg==

