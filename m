Return-Path: <linux-btrfs+bounces-18635-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D04C2F494
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 05:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8E43B20E3
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 04:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783032C159C;
	Tue,  4 Nov 2025 04:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mwbNu05P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2855B2BD036;
	Tue,  4 Nov 2025 04:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762229708; cv=fail; b=rADdqep700FZEmVHk8qQ21pw5aC3SLSe5CAKsesgOf5w3jK5YqcZ16mtE5FpfbDFSdwVMrk2AQqgsgbduPXJEksnCyb9kwt4PDHfrRqwo150/IDaBYYTWLiOBLS9Rs2R6VBM+XdA1gWsMqdjAWwxRCcHJXe9skHjmMkfH4V+UhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762229708; c=relaxed/simple;
	bh=U6AhDn9G9d0ftummkDWvUR3cgKzGDBs1ZnqTyWdiKIQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gIjay+EReAH1FAXm2AH0UUI1EgGUOlonay8kAmWoTI3mDZbHmgDme7y5zEHTnFMhHIQMUMYFV+UQfhzgJzq5yqAKBn2vIV7/HjHbcJhnfywsJXhfeEaXQbh4K+Xt1T6mFKvP9RSX36PZEjLfsHqC5ro/NxN62r8L3i+gGD2mp/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mwbNu05P; arc=fail smtp.client-ip=52.101.62.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjmWfI8bCbEje3WAdGhZ6iOJVesBCgLriClE6kOTqf/x+wEkEs/1QVXXLCYk4X1eB3P1ABk97witeOAeuQKccit9ZF5Dy7M+fgIZy0v6Vvw5SlvWZH8mcNLK4sE/5JYbuyiH0P6ngc+iwmxkqaGeyOcqgo2e2EAmYGBWbtj3GxW5ZcLijP+RFPbXROBAkg9QFaRdU8GGf3guDqrqVc5BsQPTNDnDuJU1ZwL5KR5VHZ+PVJAYpFWXU0B8hwc88csVCdc8MkLxOBEn1OZKimHV1AM51P+TWbe4hKr7ZUkoLKaao7D0mdH7OVyhJ1RNakfu3X7hh5Rp9NBKGmTC2RuolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6AhDn9G9d0ftummkDWvUR3cgKzGDBs1ZnqTyWdiKIQ=;
 b=usoM1pBwRLJDy/U1KDv0KFDOeDkmoBeND3YK/NT2TmiNS+mCz14GPd3gtwGHiTaXg38jC9gnoQSpv8ggsgKOs1UBxs/gaS0LjTOihNJP4BDeYFpdupmlg7qPG87ts2lzpvXacD7QdYibRbtqcUlrAp4Sa3CldinkbV4wal6OCbistZrxLE2FJlTygFXSL4GcDAg0FZnEntoURQOo2fe7/MBlFkRjfuDYVrX6rLIHGpcBr5FcnF/yIt72y/b96FLcTQ0INV9Y97wKBXFY/lA81cQrjzQeQ2C/FAGzd7QDga8+GxU55p8lZHWETVOIqkTzz2z/MnTDPvOmv5rCQAZ35A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6AhDn9G9d0ftummkDWvUR3cgKzGDBs1ZnqTyWdiKIQ=;
 b=mwbNu05PAUvuFj/DHNDvgx3DZAWKRbXIX65I89vMs1rU3NlMxuJKx6Elmp7ZeZ86Lek60qLgHvDI2WwVnAzKakX4M47ADiqcN8KorCP4bPaqaa3GnZqsIjhJ/TmFyUKC0eF//yhBqZFyN3j4oitMGaVlZCphwcKqPEoSYQByaGnCJ4ATJCByR6qf9dNJcYpuQ+vZz89KeRAGLi9/ap+t+PC+K61mPg1X4GP6VW9/V0tJmvbPAX8qhOCorg9OY+XaHiCL1H96sx4QRDH2SXiGwESOSuIlpqSkB+8khjVXP/evGrUN1pxjPzGt7c3yX8lOR/SrF3bGJy+9PSWVdR+ClA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 04:15:03 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 04:15:03 +0000
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
Subject: Re: [PATCH v3 13/15] block: add zone write plug condition to debugfs
 zone_wplugs
Thread-Topic: [PATCH v3 13/15] block: add zone write plug condition to debugfs
 zone_wplugs
Thread-Index: AQHcTStw/Y/PG8XRHU6f9yqgwf4NZrTh6NcA
Date: Tue, 4 Nov 2025 04:15:02 +0000
Message-ID: <27a519f0-cb72-4ec6-a405-9e81978606d8@nvidia.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104013147.913802-14-dlemoal@kernel.org>
In-Reply-To: <20251104013147.913802-14-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB7632:EE_
x-ms-office365-filtering-correlation-id: ed86550c-064b-49be-b7c7-08de1b58ba4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?NG1qNUN4Tk1GVzZhU1hWbzBLc3V0MzJxbjlCU3p1Q2huKzVlUzdRYml2Y2kz?=
 =?utf-8?B?OWpvaXdSUWgrcjQwM0x2UWFUOEZDY2RkRDRaMHdMWCtMbDN0WHVHQVlGYjMr?=
 =?utf-8?B?QkxVZ0tPUHFxSzBNZmQxRU9vTTkvQnJGWjVLUmgyeWhDSFQ1R1hmLzNXTFJ2?=
 =?utf-8?B?SGFpNy9WcmRubUxrNUZqaWQ2Wk1oZVdVYklqOVA3VDZHN3kvRTBDWmdBQ2ha?=
 =?utf-8?B?REcvcmRGcC8vdmlmTEdDM1J0ZlFyV0NaV0JWbXZWRUFRYnBmZUhGVG80azRk?=
 =?utf-8?B?VndUR0hNVXR1clZ6a1hxb2JaSU83SFF4WVhzd2tSY0tHTGVMSFIwcWp2VVo5?=
 =?utf-8?B?NUtlQmViRHQ3eGNqNlo3T1JoRUtReEIwT05TdEdqSGxLRmVkMVhnUnlSeCsy?=
 =?utf-8?B?aC9Td0grYkFSTExTZDF5cXoweCsvUktZdWxTZTlRMVgvYUkrancyYzRyaEtV?=
 =?utf-8?B?M3NnU010Vk81ZHRoQjd0eHNHMk9mTndwbGZLaElQMWRqbzlDNlNSZ21DZHFt?=
 =?utf-8?B?K0FHZlVERDRqbXR2YjBSZ3ZJY3pQOTRSN0FSaVVhMnkvbERQS1NXcVZBdWxH?=
 =?utf-8?B?TkVUR1BYS0lybkFIMXh0dXM5Qng5WUtmcy9RTzdWNjRlSzM4aEpWTVZCeWQ3?=
 =?utf-8?B?MC9yT1dURHZZQzh6N2ZvZE1ld1grU0tha0JVa01nZHBBMDJEalEzNzM4eERu?=
 =?utf-8?B?Y01PYlkzZFVXUHllcmpjZTB4SG8rSmJjVmo4ZU81aTVsaHNGbWo5UzJNYVJ3?=
 =?utf-8?B?d2VWTEVYUmlMM0NkUWRNL0NFWnlhT0pzK05tNmFtWmtOQVkvMDhOQlBnTVBX?=
 =?utf-8?B?OHlxbzBmcElNN2duYzM0dldlZWpOeWxITTZJQ2g3Wm9ybk5oaU1zd3c1YlEv?=
 =?utf-8?B?RlVHbWNxbHEwdUN4aGpEUkMwSVJDL3d0YTNaZGthd3lneU0zRnZtREtkUmdS?=
 =?utf-8?B?ZE9aemVzaVh3Q1d6dFJxekUzYks1dUJnWmpDaGI2YmEwcThNazJxZkZZUmQx?=
 =?utf-8?B?T25qb1VpSjVNR005QTIvVGlDM0tHYy9rVkJNVC9XdGlmOTRyZTMzK1JEV1dw?=
 =?utf-8?B?dUlMQ1pHT2p3aExIZEViNUlPZzJZRlNCTHdjeXgyN1ZSczRjSXZZQUFKV1Za?=
 =?utf-8?B?VlNJR2d5ZGQ1UC9wY2tHdGFRNW9jbHB0Y1ZLQWNtZS9mL2JucUlDSFBHYzFI?=
 =?utf-8?B?ZE9ubytHMUhIWjVuT3JiZVBFalhiSlAzVUdYdkV5ZWhrSkVLWVdyZzNiYUlL?=
 =?utf-8?B?NVk5L3NqclI1YzF3U1hBbGFhdWovN1JYYm0xZHA5Ui9STmpwcUpLenZZMFhu?=
 =?utf-8?B?N1lNVk1lQXZYQzFxazlxbWtoMnJEWG9LNWdqeUcwVEpxcWZMc3c5SUxUTjZM?=
 =?utf-8?B?QTZTWXFQTkZNL1orRmpZRmdqaytkSG96MnVpWHRZOW92T0xERSt4ZFAyb0x0?=
 =?utf-8?B?Q3J5aERPVWVXdnpQTU9raUJLZFFMRlhkemV5dklFejJnZjlGVEtRSnZ5V203?=
 =?utf-8?B?TS9Nc1RPWS9KNDVsVWI5NzVRRStkRDZka1MrNFVEVHg2dTBjMFRwMG9wYTZH?=
 =?utf-8?B?SGJZZWRES3dPeGJZc1JoZE1PRVZTMnYzV1QwTCttS3dlbGFzRlUvSkx6SFVn?=
 =?utf-8?B?Z1ZsSjY0OUJLalczUFVTT1Yva1lxTmpNcEdFL3hFbU5GL3c1YmowajdqNGJj?=
 =?utf-8?B?UmF3VEw0RXJtT1RTZDIyS0NqenRWcHFCMFZuUUJiMlZiM2hNbitoUWd4akxj?=
 =?utf-8?B?elhwclNRdU5kUDJjUVl6emNrb1g3UXhtWm56TytWMlIzNkpvSzNWTFlCL0JN?=
 =?utf-8?B?Y2oxblI4SXB0Y09MMEtZTk5xR043VFJWS00yMi9uTG5Wa2NvbEZUTmxaU0wz?=
 =?utf-8?B?dGcwWXV2RDdRZitJem55L0h0U1lnQVZ1OUdIL0E1UDBtbTR2QVp3NU0yVHZw?=
 =?utf-8?B?Z3RSamlUbzBHOUVjQlNtaGFIdzlBNlhhQ3pVUVhaelcrdkJjNWl1T0cvaFA1?=
 =?utf-8?B?ek01L3d4SUtERGYxVWwyWmZyNUlqL1BucW83Lzk4T3g2SzVPM3NmWXRSUmtD?=
 =?utf-8?B?SnVxQ2wveEJza0JlWmFyQ0pad1JiTC9XaDMyZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUR2bHhOMC92K3ltcmo4SUxuZGhrUUlZWUxvQW9oaEdZNmUyVVJQalN0OXd0?=
 =?utf-8?B?aUNFSXNvTVh0UHdQNGYzVTBSYjhIS1ZaMEVlM1BxaE52bzlLbCt0WkJqbith?=
 =?utf-8?B?RmVFSnVCdkJlekd0Z0lGM01PRkVwUVB2ZTdvV0pWZEJqWVFUanZnb2RXL0pH?=
 =?utf-8?B?UHgvaHNDMnpzRUc5Y0tzMW5hbFBXK2FQVExOWlVlOTlleTZFU1cvbEpBSEJF?=
 =?utf-8?B?cWhJTDJ1K1ZsRWNUN3RmRjlHRHJQbXF4U0ZpYXpTYzZuMFBFRWFwd0dYOFBV?=
 =?utf-8?B?VXhEUmF1KzB1ZkpKNms0OUtaSi9lNG9OMy9FL2l6aFphR1JVOGNDTVJTZ2Jz?=
 =?utf-8?B?U29oeFFLeUE1K2Z2dE0wOEJBRUhseDN0SU1aK05FV2w3WlhvVWR5Tm91bFdi?=
 =?utf-8?B?NmRiN0dtYjVoeTh6REV4Qmp5alRheXdmL29VRHFGQ2c4ZnUrV1FoOHZoMSsw?=
 =?utf-8?B?Z0ZSeFoxaTlDZlhNVWJHTEYrWGNFQUNDbGgvMkRkZy9JWW9JeHgySHZHQTJr?=
 =?utf-8?B?UmJZV3JORUh0K0FGZnVNK3YxUDdRbUp5NGY2cFUrSjhIN1FrU2pmV1VFekwv?=
 =?utf-8?B?b1pZa3ZLS1h5cGk5WDd6WDd6TzlvZDZrMlA1MjN4L2ExRXdqS2szaHIzWnJN?=
 =?utf-8?B?NTBIcU1JMGJVa1ZZWlFhbmVxNGpVS293YUtSaWxRTFlZU2NSSGxZaFlXc2Vy?=
 =?utf-8?B?RWZxeTBBc0p4QzNlQ3drc0hvTVkrUUZtejljYk94RzAvN0kyV1k0eE5WQXdO?=
 =?utf-8?B?RmMwa21ycTVYanEwaE1VY1pEa0VadUhOUlIvMkFvbFVHdkpyWXBiSm5vSnNp?=
 =?utf-8?B?ODhuNFNiS3YrYXNxWSszSGlmWFpxUVgwSnFhdzE4bExkSC80U1orbGVNY1FG?=
 =?utf-8?B?RkJFcFBpWU1TczFtUjg3QWtYMElQd3lXUFE3cmJidHo4VHVIWmpGWVR0clpT?=
 =?utf-8?B?aFJkeTJUZ1NEeVFWRWlXeWEzWXJlZTE0SnI2VTNJbWhOQ1lyWWVSZ2Z1MlJD?=
 =?utf-8?B?U1FOenN3RzdXMzJQSy9xWkNVNGM5VFY0S2RmV1lKcFFxSUdwRmc3MlFNT25H?=
 =?utf-8?B?U2d5WlBsMkJMZHdtc0IrU1JBMXlZSnBid0FTZnBMTFZHNmx4alBpSytoZU5E?=
 =?utf-8?B?Q09XaUFzYm9yYXNtS0orMjYrd2FTOEVwbnZWS091M2dkZTk0eC9PVWxRZlNu?=
 =?utf-8?B?akVvTllaSHBKazZzV3VmNG9XS0pHYTU1VThDS1hlZ2crOWlwQjBhSzFUTVJw?=
 =?utf-8?B?MTdWWW10SytlcXdDY0Fidmk4UnlrcWZHR0x5OWNHSHAvSmZuYXJRU3dKWFNx?=
 =?utf-8?B?aUpMMG5SU2RqNm9GcWk0YmV1MFBjMFdYTTJ5N1lmWHEvYUVLWkhBdnBZSXBX?=
 =?utf-8?B?elpwRTNFZk9VS2hwWENvR2g4Mk1qYldzWjhQNlhmR1B4SWYvZWpmdXA3MTM3?=
 =?utf-8?B?S0dlT0RGUHdoR1Q2S0wwdXhzSElYU1lHSGU1bGFvZ2RwSHhSQ3JrS2Z1Qkl6?=
 =?utf-8?B?S0NuaHlzbUpLUWpuYkdHWC9kVTFpeFFnWnhvdWJoK0gzYmFueXlKd2VvakNL?=
 =?utf-8?B?eG0wRVBJVnNlM1dzeUg3aWgyNUprQ05DcnJ2YzhHRE52bG40OVRaMG92aFZ5?=
 =?utf-8?B?TkpVNVV0Z3lrdFlUeUFOZnNrbDVrTGYrWFpZeVZZeXJPcUFqSmRBK0FKYXJr?=
 =?utf-8?B?REVvcW5LSXBqYUFVQnVUZG9SaU5RMit6QnpxeHdGZDQ2Mzh2YmlMd0d6eElo?=
 =?utf-8?B?RVFnMnFsbzRWMjRqbWFMaU0vTlVKQmpiMjI1cHFDKzlCbVBZMDJOSDZmM0VK?=
 =?utf-8?B?QUtKa0Rlc21PdkRVaWVmaWVINW9ieWVIZzQrMFBSYjRaemxnM3dpaUJjczVk?=
 =?utf-8?B?Ym9PN0pUeFJKVUdyQW5oT0FBQk5nOUFMQ3hkUXJocnc3NkpXa0U2MTVIMWVF?=
 =?utf-8?B?L3BSb0d3MWwyOUVBazUxMHRwd0xIbzVLaDRVakNEOE1hOWxsSktTcUtTazBF?=
 =?utf-8?B?eG9MVFhXUzZseW9xZC9lM3BjbExLeGExMWd0SHdNYzBhM1BlY21IOTFEZ2Rv?=
 =?utf-8?B?MmdRcWxtSnl3UFZiaEpDRkJVR1lDOE0yejY4MGpuM2tsVDVvVWU5amNoNlNH?=
 =?utf-8?B?SWRBVllkRTFNcW9lTXFQdUphb0FZanF5RkdsWG5JdnBJWjlCNW5SK0Q0ZzIy?=
 =?utf-8?Q?6+wxneqK/VYWoQ9G0P8htiqZhEcep28/JB1l/gjakZtD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B544ECF96DB4A342830CB5954779B730@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ed86550c-064b-49be-b7c7-08de1b58ba4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 04:15:02.9451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vXzFMrISfSV/UZRM1yzSS95CCeQ0vTlQt2XF5esvjQ5x3iSd0tkCUEo4SsVSsYAYSflkrhrhp384xVx1/lIEqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632

T24gMTEvMy8yNSAxNzozMSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IE1vZGlmeSBxdWV1ZV96
b25lX3dwbHVnX3Nob3coKSB0byBpbmNsdWRlIHRoZSBjb25kaXRpb24gb2YgYSB6b25lIHdyaXRl
DQo+IHBsdWcgdG8gdGhlIHpvbmVfd3BsdWdzIGRlYnVnZnMgYXR0cmlidXRlIG9mIGEgem9uZWQg
YmxvY2sgZGV2aWNlLg0KPiBUbyBpbXByb3ZlIHJlYWRhYmlsaXR5IGFuZCBlYXNlIG9mIHVzZSwg
cmF0aGVyIHRoYW4gdGhlIHpvbmUgY29uZGl0aW9uDQo+IHJhdyB2YWx1ZSwgdGhlIHpvbmUgY29u
ZGl0aW9uIG5hbWUgaXMgZ2l2ZW4gdXNpbmcgYmxrX3pvbmVfY29uZF9zdHIoKS4NCj4NCj4gU3Vn
Z2VzdGVkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm48am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IERhbWllbiBMZSBNb2FsPGRsZW1vYWxAa2VybmVsLm9yZz4NCj4g
UmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnPGhjaEBsc3QuZGU+DQo+IC0tLQ0KDQoNCkxv
b2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KDQotY2sNCg0KDQo=

