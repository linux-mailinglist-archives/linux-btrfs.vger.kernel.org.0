Return-Path: <linux-btrfs+bounces-18627-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB11C2F3F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 05:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 413F334CFCD
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 04:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA32F28642D;
	Tue,  4 Nov 2025 04:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ccEai5v1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9690248880;
	Tue,  4 Nov 2025 04:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762229147; cv=fail; b=KUryDrm3WBxqpBxzRrc+pVrKVYHUnzyftjxxdpnk8vGB0xM4GAo8mNSWI+wf502gN/HOoJcEBkpakxvW4U+tktPZwITJU6EvOWs3eARDqPiX+ydYiTzzIEOlhXtd9s1kc9jSGItgNtQ5OI6BRbQsekzba6jCBA0QvtZFArlNa4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762229147; c=relaxed/simple;
	bh=mAwSvv48Jg21lYEz9XrEClGpAtdtk6BvlbCGlxPKkf8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gyrnE2xxW5SmHh9OZyO92MtWra9Up9I4U4oEHiZ54UWEGw+gR9TUjlbVQVpvigRNq59u556e2G31zofA5FCe3m4YrFnPUcR0AV10KsyaYM06Iz1/4mVomGw6hXv82wzFgzDDoNQHdArkQlvWY3kdqeUOXpczWMsDUL4UkbmdBXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ccEai5v1; arc=fail smtp.client-ip=52.101.48.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrpJEBqESfUHZLseK12MkgWrfqxrzQNz0OWzTpaDuLstyaAO2fwO+/s8SarWCclUpu2xSCWJ+Y8AVO7opzzOc67tCJarRWeItw4GWASjDBZMhPwekbPxBdEST8rcY6MkwX6wjog6NG8dDRMW9qLpu4D5eqdakVNT+BRkPa1+5YfqLiVARombCjif7LZ2fY8RT4gKb0wuLn+FKs1ZTtKoUYKXTQJ65IeoJC8/eUl7NSd82BLwenB7kXw1jMEXaDVenOjglPCAvfGkTDlLMVmNzXA7nIeq8Q8mw05Nbsy5x2xPG2tY1F1mv6cTbrtPRbqSlOUj0TSt0PuGzkk3wxwAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAwSvv48Jg21lYEz9XrEClGpAtdtk6BvlbCGlxPKkf8=;
 b=ng/GdvSSVfSr5/iOlSvmIrdymLS+n8VHLIn7p2EJmSr6m0N1AlZwAuskA8o2xZYKK9hkNHEJKgaBH4TiNtzazERgyt/0GpFHVH/gw3YttJMsKQuMTGXW0O/ppu90GNZ4I5KG2IG1t6CKZRGOBzvfHjV+l+zDUeECfuY5LMuyCVcTvn6v1pKLpqJxLkbsLJbA73d2oEb3oqPvruZzLpvXJYxf7g83TY0yRChxDFZfg8XiSH3sARgDh92AxXMHI0Y6Bjt1fku9/EySqyxdhAkbZtZ4EGNj38uSl9n25TYv/rloGXCenXIMbCjK7SHrHSf53joa9rDLGM+T4k9SzT71YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAwSvv48Jg21lYEz9XrEClGpAtdtk6BvlbCGlxPKkf8=;
 b=ccEai5v1QoDTNXtL3/gZWl1dXENeqc8lagQw8T+9BWIOlzxkFOIHME/LigjPMCMN8rkkkaK+pY6uCtAKTfhBqBh+SZ4IVtsNdss72bsv+ufexcBdpxtJ6FVxeOeVSCBuWr6OpWsW6U4hfELSIr2zyiNewQC891mXHyZLrQcaRn6gcrhwyX7I+GTeST45Q2dcswwraiVYkSUZxLJa5dT/ZIidwRmjRqvERwSG4doVFDOyfs1bNGT7lrGhYAZ2SNa13eqw5XW1FO7tvM7kqqQoKh8ndzidPNjHjIYRH1EisoCWQ6uhViWM3KJjHTJIYQtr19duyMV4dFbswAjaZRePpw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 04:05:43 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 04:05:43 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>, Mike Snitzer
	<snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.com>
Subject: Re: [PATCH v3 05/15] block: reorganize struct blk_zone_wplug
Thread-Topic: [PATCH v3 05/15] block: reorganize struct blk_zone_wplug
Thread-Index: AQHcTStlbYvIUle1nkOYnFuYfpNdQbTh5jwA
Date: Tue, 4 Nov 2025 04:05:43 +0000
Message-ID: <f3ee6072-4743-451f-b8d9-a2a6bdbaaa93@nvidia.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104013147.913802-6-dlemoal@kernel.org>
In-Reply-To: <20251104013147.913802-6-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB7632:EE_
x-ms-office365-filtering-correlation-id: c4acaa63-bc09-4df7-e3ed-08de1b576c96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?bDNHUDRMMVFkNmViWm9Eb0dScURvTmZpTFBJejN4TURJR2Y2MnZ3TU5TVkZP?=
 =?utf-8?B?M2k5YVpNaE5iZEc3MkhrTEZ3VXRaNG04WmNRSTdqb1llL2NHM0xXNENqNWkz?=
 =?utf-8?B?aHhtZDJNekdtRW80WGxLTWRuaGxVWTBHSDlCTyswc2dFK3BJK0RCSEtDVEQ4?=
 =?utf-8?B?QXVDZVYyenBZekZsdTNQMHNrMjZLbHNUWXkzTFdLa2JjTmJLdDJxL1dBNEtB?=
 =?utf-8?B?TnBYeWNvV1hJUWZCVzBaWXAvSTczMFBhN3oyd2JkNlVWTHlMRGRGbTEzUkIv?=
 =?utf-8?B?RTNja1AvYkdVNnN6M092RjZwSzdmck9CWm9mK1REa1ZIb0pWSWJjQlNzOHhN?=
 =?utf-8?B?cTkxTXFXendsekZZbWZyRlVtb0dQRzBjN2xGU2pWWVNuRThaTy9HeWxMNUhH?=
 =?utf-8?B?ZlJmRStxRk5xVFA1R1RHV3UxK3NPSVNkdWhMbjJ1NE1rRWlNM2lEKzl4RWhr?=
 =?utf-8?B?bThmeSt5bkpnWEtjSFJ0LzBHbWRydjFxa3d5ZkJlcVo4SURDOTRTMElFTUtn?=
 =?utf-8?B?NHd0Y1hrWnY4cVEydXZ5bFpuVkVvRzNmTmFNNkRnaURraHlwU0Jld1VnNE9M?=
 =?utf-8?B?QXV6SDBqS2R0VEI3RFhKZmQ2NDBSVWdPUWIyRHMxSktnVWhpSHNRWlBFRElm?=
 =?utf-8?B?TU1YUTZWbEhyeWVVVjNaWnRPa2VGaXU3cUVVbkF6a2owaFhtQVJrdlJNd0Fq?=
 =?utf-8?B?Uiszb0RWOHNsajUrTWRYRXVLRlhPVWcyVitJTXFMRElDTEZCRmxzV1hESCtS?=
 =?utf-8?B?VGt4T0tSaGxwcEE1cjl4VU50NVNTVHd4aUhxV1dneE80dlFEUUw4Ky83Y0RO?=
 =?utf-8?B?TVJVQ0xjc2Y0Y1VFVzlRMExlYldyamdxcUdnOG81YSt6Y08xZVlQdEt5ZGly?=
 =?utf-8?B?UmxLUlVwVEVadE5tb2ZzdU1GTDhabTVlK3ZWY3ZEaUhJQ1ZBYmRCMXJJRTlH?=
 =?utf-8?B?eUowNFRzVi96OHdQS3lhR3IvaHJLcnNTUDNDc3BncFF0M2UxcjV0YjJiQU13?=
 =?utf-8?B?ZXRYckljT2lnd1lvZGZKQ3dBQVpFcjQyOVdQRzVEd0JJWWRKTXZ5YUYwYWtz?=
 =?utf-8?B?K3pKSmNHenZkWDFvQWFjckRZanE1dEZCOEl0TUR5cEFVdGdZSDZNcVJHR3I5?=
 =?utf-8?B?R2JtamxGNGFTU0VsUC9ibU0yS2M0UUV4TUlqY2JtRFNCZWZiQ2lVdTh5YXNm?=
 =?utf-8?B?aytFeVpLR1NHMk5IMElUUGgwSkR4UVhBZXdIWUp2TzBLQk0zblFhWERNT1Rr?=
 =?utf-8?B?VUhLZVZqMm1NRmI1NkdxNGd4OWV1QWJ3cXMyU1JQSFBmOWY1WndCVGgyMkhD?=
 =?utf-8?B?Y2hSY20rcDVIQ2JTeXYzZWlIeTE1dTJTYU81MFFFQ0w4YjZ0MGtrbnNkdDAr?=
 =?utf-8?B?S3cxZlRtbFprcEd0OGlNRkF2emtQaXBEY1ZuOCtUNUllTDQxNEZnVXhvcnhJ?=
 =?utf-8?B?dU1VaEQwVE12TEsxT0pISzlDSE16QXdHbnI2RzNTMVhJMlpSL0cya3JQUjkv?=
 =?utf-8?B?d2RVaGhqeGdQZGlLUGJVU3dkakN5a1M1dUw4NFp2OHNmZ2dnMWxvZ3Q4bTBk?=
 =?utf-8?B?TzRaQWxYdkRCRy9uWllPekhtSUd6Q0Vxek9VczlkR01hRDBSalk3RkU4Z0Js?=
 =?utf-8?B?MzBmbHJkTGJ4NngzaEdsSncrOHN3UEE1Z3VpNnR2R1ZDSGsxSTBVai9LUHJQ?=
 =?utf-8?B?c2lETnZEYU1SL0d0a2QyWlVWakN0ZnRQa0NKMmJpZUg3S1VDazdNQVZnRXBB?=
 =?utf-8?B?RGhuMnJrdXBQOWVNNmEvdC9ubTRaYTFHM2hKeXBZOHVqZ2xSTERyMWFoYXlm?=
 =?utf-8?B?aWFybWNNZFN5T0xHNkxDeTBBTGdxeFNvWlhkeGtWNnloK09FbGYrRmx4VjRh?=
 =?utf-8?B?b05yRlhzYldGVnBUTnNEZjRNQTVCRmxEVzAyMHJUQjhhTU9XY1pjeUtZcXBL?=
 =?utf-8?B?Nzh2QmJQUUJjdWxWNG40MkRuMEhBNGdPeERXZ1RkTHB5L1JLVUN4RVk4bG9T?=
 =?utf-8?B?clU3dmpFNDFpYkhKZVRLNkwvZWd6OEpDZ0hqcmVHSmtjNWsxTUhSejc5RHBI?=
 =?utf-8?B?N2hKZ1owajF3SlQwY2FETVZ2ZlNmRGdhUk1Vdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHhPKzJqZUVuaWg3VEtaM1Z0azVSaEFndnBrWmZNL1NwWUFyaFZnUkxla2dV?=
 =?utf-8?B?enhyTm96NHF6dHlqaXp5VWxjNDFCWTBhV1R0aENxTFdibzBFVFZTZjA3S2x6?=
 =?utf-8?B?dmRoQU52VGxiZ0pFMmtZaXJHNVdwL2dnNGNrWm5ReXZ3VmNjVVNsTUJHR1R6?=
 =?utf-8?B?Tmlkc0oyR1VnUHhNaU92OWxwUGRNaXhoVWE1Y0NLOHg0bEZuYWEvVERVQ052?=
 =?utf-8?B?aytpTm0rOWZkRUYrRG4yMGovZjB6RDdldTBPb2wybXo1N1lINUoyTldPNmpI?=
 =?utf-8?B?d2p5WUoySGFMNERxZ0RheEtGRHhmdlpUSWZjUTNiNTI5UjdadVVTZmRQSVhU?=
 =?utf-8?B?Mm9JZ0NEMk5wSVBLQUR1VEE4WEhwN0x2b1pJcTZwbEhwWERFalI5T09WRjdF?=
 =?utf-8?B?MGkyY1MweS91Q2h2MUpMTFcwMmJCUytvOW1DTGNFajE2dGF5bzJQZVpTcEVi?=
 =?utf-8?B?WG1BOWwxQXdGYWxyZGlSWVUzUDkxL0ZSR010aCs5TEZxYWdNRkxZVE1XOHpv?=
 =?utf-8?B?RC94OFp1VkhoOVo0elpsMDNJUkoyTzNidUdMS1E4S016cnhkSi8vR0lQbk5V?=
 =?utf-8?B?SnRsaDBFUGtVdWVFYjNiVG9mL3RNMDZOSDNEKzJUZ1dLQTBnNlc1T2NJamky?=
 =?utf-8?B?S1JaUUwxSlUrRHY2dkpmS0V2MDV4Q29KMTI4T0dsYVpoM0thRmpLSmZxRHVp?=
 =?utf-8?B?TklaaSttVkcwckJ0anlGUU9ETVNQcXgxWHVWU3crbUt1OFZaNDkzQll2T2pG?=
 =?utf-8?B?anA5R2EyL1lCS212eUh6MXlWYm9tM1E3V1pTV0NhRXM5TWxrblR1bjVrV1g5?=
 =?utf-8?B?d1lWSjR2QlFUYndFMWpWU01MSzJpdWRkT05Jd2g4UjJRVkE3TEZiNStxVUVS?=
 =?utf-8?B?N04rNk81d09oS2VyaWRQZUZId21TbXFxZzVqUHpEZVpPZUF0RlhWSUhwUTZa?=
 =?utf-8?B?TmNEa1FaMGs3bmxsVlI3SDdKZUFJRXRVZEFldzZ3aG1HTmJpWGtCYndFdnBq?=
 =?utf-8?B?Yk9xZ0c0RlRxaXJXNGo3UEUwZ3FEa0wwV3ZZWFZPZ2poalZLT3ZOY1FKd21Q?=
 =?utf-8?B?c1hmajN4Sy93dktSMG55WVlEZjI5U2szMUh5Y1EzSlplZXdsbzFrSFpNK0xV?=
 =?utf-8?B?bkw5a0dPYzNlTWdiZzRJL0JZZitIcVRkQkhYVEZjUUhpUWNFcEh4dEZOb2VR?=
 =?utf-8?B?YVM4ZDhCaGZObm1zOUh4TEJtNk1MN2Q1blRaYyt6Tm5seHV4SW0xUVRzcDFB?=
 =?utf-8?B?UFBSSWlDYS9Gdm1MYkNvaHBGM1lEbEViY0FPZFplNStUeWl0aHhwSXFIYnU4?=
 =?utf-8?B?Z280WEVzMXk4MTZzRGtCblFsT1F4cU1ZaVpuRUtqbDI4Ty9OdjN5ZUVvUnky?=
 =?utf-8?B?VWI5cHQycmV5a00yclRybGc4VDIwWXVRaENUbzZNdFBtV0FyMG02WVFtcEJQ?=
 =?utf-8?B?akJxSFhrMk5kd0RaOFVXUVVBSXZEcEFiZHB4NnZQaXE2SEh3WnNRN0hGakxa?=
 =?utf-8?B?bElVWEc4RTREWlFzS3Q5eFRDV3NzNTNhTUtGRTVNREUxODdxenl0WmtFcU1q?=
 =?utf-8?B?NDhJRkYzWU1FRlRuaFBxUGdQMmFyTHl1d0VWaXFpdHk5TkRtUzZpNjA0c0dy?=
 =?utf-8?B?K2FwRHoxYjNTRHQ5b3VGc2k2cFhaV0hqWjM4dTlVSHpuUFhJL0t0Ync2a2xi?=
 =?utf-8?B?WTU2T1lDRmxEYkd2VVprTWd5RXhveDhtYVdBQk13WWlKVVIvK3orUFBCSEZs?=
 =?utf-8?B?SnpLbU5hRUZlYWFSbDErQWtnNEdWb01MTDh5dEhNaGdzK0cycHJNdDQzWUo4?=
 =?utf-8?B?ejNsU3lTTjh5YXpLd3p5MWVkVXdEQ3p0TzM3cXpiR24xbkZMcjd1d2tnTTU3?=
 =?utf-8?B?YlBLOHNTMDZPekVSdzZCZ0o5YkpGSVZJOUIyN1VJSGR2N2c5ajhSaFM1ZWpE?=
 =?utf-8?B?bGdVYmh4WWtwV01uMTVnekFOZGxtbnozVmNWMEVnUjdkRzFueU1PZFpLamhL?=
 =?utf-8?B?SS9DcGM0Sm1HMTNUanFiZ3RNOHI1Ry9uSlIxTzBmeVZFQjlPZlNESVM2Nk93?=
 =?utf-8?B?UHdGYWFUc0t5dnJ0Qkl0Nm1CNElac0NoY1h2cVlvSTVvY2xtOTlMZDQ0eHBC?=
 =?utf-8?B?M0RhUlhMTFhaQmRja1RhN3ErRllMNW1WcWhUMmZSdUxTZHE1SzdjOGRrWCti?=
 =?utf-8?Q?qpXHaq7Wj7ZIyVbyWn2UhK9mp3sDvGM8WPda8bsDNahE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96E5C1ACF35FD54DB9159B3CCB5EB228@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4acaa63-bc09-4df7-e3ed-08de1b576c96
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 04:05:43.0496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NtJdPQP/n+zOmBQEZvFWZw+5ZCdwtEJjXxr0USQd+xX/092LEgTrPJjtD1fJWxsJHR018v3L6m31jWf1T8zFvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632

T24gMTEvMy8yNSAxNzozMSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IFJlb3JnYW5pemUgdGhl
IGZpZWxkcyBvZiBzdHJ1Y3QgYmxrX3pvbmVfd3BsdWcgdG8gcmVtb3ZlIGEgaG9sZSBhZnRlcg0K
PiB0aGUgd3Bfb2Zmc2V0IGZpZWxkIGFuZCBhdm9pZCBoYXZpbmcgdGhlIGJpb193b3JrIHN0cnVj
dHVyZSBzcGxpdA0KPiBiZXR3ZWVuIDIgY2FjaGUgbGluZXMuDQo+DQo+IE5vIGZ1bmN0aW9uYWwg
Y2hhbmdlcy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogRGFtaWVuIExlIE1vYWw8ZGxlbW9hbEBrZXJu
ZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWc8aGNoQGxzdC5kZT4NCj4g
UmV2aWV3ZWQtYnk6IEJhcnQgVmFuIEFzc2NoZTxidmFuYXNzY2hlQGFjbS5vcmc+DQo+IFJldmll
d2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm48am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoN
Cg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52
aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

