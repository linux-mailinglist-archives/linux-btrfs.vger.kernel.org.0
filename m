Return-Path: <linux-btrfs+bounces-18633-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 127F8C2F464
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 05:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A32C188F670
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 04:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D10287258;
	Tue,  4 Nov 2025 04:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EHoMQlc2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AADD1F95C;
	Tue,  4 Nov 2025 04:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762229554; cv=fail; b=BoCPgAltj3oMylk72Hxy7PM8zluL/b4dE3BSI1/qJWBn5dmQq6IHa0/cL2b1TeCWHjSYPpqM3FjUqXBfsv0+xaht4UfZZCmDBmBsotSNk9dKz7vpWQqA+ptCMFcBqNwcJ3jbvlePPkIyKlP7UNFQiLfd/kgnwaDfVBl1ENuTsIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762229554; c=relaxed/simple;
	bh=iSdUQnpCoyT25aG+5EJvdVEDmIrg3Ozznah7rlDuIh4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fC7hcqJCKea5Axrc3YtngMGCGPLXK2BdLyx662jzjqEcaOlzN3/lbiqb2I+echoMDWXVoEL+VJcd4XzZhOLqYZUf4aqFri5XQKYL1zOdRZ5XtEg0WGFluDMOkvAergYkDwcZvGgyOV67MwSs7qte/LrhgFY+93Ot3/6jQjlnrbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EHoMQlc2; arc=fail smtp.client-ip=52.101.43.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKJh1DB9UCAW1xCJ+MMM8h5AYaVYvtB0lyOi1CBhm852Fai/RP4N9SN7yWkwon1hR1fegtIaSAxNeaNJ3q2itEsv75rrGaMN03qiMeNc9qNHQNaks9vnpT05NQ8O7UsL0BO7crL5JgbpSgZ0kWPkelxhdq4B7xtokx8HcaVM5SHiAuZuhQ/FA4MFg5pxQgLJFxGV7jr/xX1M7Qkn1LB8/IGZRh+kuO4svwRNbLsp01d0XN6LcNES/KjvM/lj0Zz44nf3zXuAnG/GD+VxDzhdex8rzYnMubzTtrne1GZ6jbX4M2fEUvbSjGrXwmVeNS4IJzfw3hP0P+322ghndtPJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSdUQnpCoyT25aG+5EJvdVEDmIrg3Ozznah7rlDuIh4=;
 b=B+QUX0ArQ+Ma2huv/g/rr7C1x95KvUxd0zS17BEUOibdhEWxk9myewsx2bXbM34csxEYUXNAsDT7hLfQpfmaTMUQXdXGUuX30tfPFKkXWOsI0LZYkZhEC2zzLHGmEoBcFzi7Q7WscVXaoaCNmpI6Gn+jJCgVGZZEt/yZ/ICjLaa7inBLCXbeBd+BKnDXLybf8BLxWFpGScu2zqCiGJjx+vnMgkv1DC87p3Leh4UBOE6aodZaPVnbC/jLnhTUctnQt0fmORehmvodKcO9UOmNGOulaGdY2jLXXDmSu4RqKhqUGDuxixbZRtlDfYM2kV1BbcR9oqEa+FZg58sJgMWvzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSdUQnpCoyT25aG+5EJvdVEDmIrg3Ozznah7rlDuIh4=;
 b=EHoMQlc2qLvjywoYdj4dI7kwiYFTHTbBXPZOO9EBBhfGE5tSOFA1vsfVwvtcMSmu6EiYBXI8UjRll3NaRDvExZ4xiH2aHs3ivjD5lQrDAw9FZBe3NyKPXegT1yU11XmrzDrMFygG3mcabEcJy5fO5sM3QwMAbnGXkGsrhBellrk8sXEbUi9fgwTIoMBaasU41SC9wJflUUqZH/jTfTDoNj0jUwVho/whGjUCvBNMjdOuddF5knL4+MNvgv38FweFR/n7gidIT7dytMEom+7Eq7+2SzO0uLdb05MkIFfVlL8b1TaHAvioDdqv0fe7QH3etUeQtitBm+sdpQJiyl1+aQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 04:12:30 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 04:12:30 +0000
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
Subject: Re: [PATCH v3 11/15] block: introduce BLKREPORTZONESV2 ioctl
Thread-Topic: [PATCH v3 11/15] block: introduce BLKREPORTZONESV2 ioctl
Thread-Index: AQHcTSttaDofssBZuEW070+im4tuW7Th6CGA
Date: Tue, 4 Nov 2025 04:12:30 +0000
Message-ID: <43fed7d1-5e46-4f51-ab64-85321b955a68@nvidia.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104013147.913802-12-dlemoal@kernel.org>
In-Reply-To: <20251104013147.913802-12-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB7632:EE_
x-ms-office365-filtering-correlation-id: b3ff904e-2785-4db6-59eb-08de1b585f2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?bC9lSXNWVFJjUnlNcERpaHE5R0w5V1RNdExJRG1acEZTbEhCM2NvSEdiTkg0?=
 =?utf-8?B?S1NsMEh4bXhUdlYxYUpJWmhxSERCeUJxemxYTmtkd2dldHl6NWpNY2lGcXpS?=
 =?utf-8?B?a2NsSkViOWQwZFVqVTlud2JvY1FraVVSSWM4R3M0UTNNYjRXZ2dLTkRacUpi?=
 =?utf-8?B?d0RNVUVIbG81QXloT3lRZ1loSWZVRWJxc01SaDM3WUh3bTR5eGlpSnBSYnlm?=
 =?utf-8?B?LzM1ZUlWalFjV0N5b1hlUi9BRlQzTDRsSGlwT1U2OEIyRVFZUkNrc1RzZnk4?=
 =?utf-8?B?bk5hT3ZFMWtxY1R1RDhrT25oR25lcldaRGl1ajJTS0x1Q3Vnb1RBMGZKL2p6?=
 =?utf-8?B?eTI0U25IZERKdWRBNW8vbFBCSllzUHQ3ZDVBeHRrY3dnNVJvaDRpeW84YVNY?=
 =?utf-8?B?dXNoRGlTejdOaXZIdC90d3dEYjZPN3c4RnpPbjJmQW1CeXRXYVFnYW96VTVk?=
 =?utf-8?B?V1Z5WFdPNkZMVXlHcm1MRHpMUTk3bzdLODlvQ09ONmtJdktoaDgvWTlQY2tp?=
 =?utf-8?B?M0FVbHBDaktVNEROQzRIYUNUZmtNeE90OTZTZjhST0FseFRkZkhxcTFPQWpx?=
 =?utf-8?B?NW1xWUtidU9Gcm5RTW50bnFPdm55MkhBTk1TTm9ha3RGcGdCYkdpbUlrdVJs?=
 =?utf-8?B?TEtRVVJYZnh4aEdXK1lPdVZZMEErUUoyQVVDRHlnSDVxRllZWTlaM21BdUFJ?=
 =?utf-8?B?Ym00NmlpY0JiVmNaOVB4WHJVMVdSc0twVEQzNHlCZEluMmY0VlhKNFd5Z0NE?=
 =?utf-8?B?YmNQZ3FxZ3BOaFpzeVRNaklKZzd2MWRHVXJMQkR5V0ZHSDBIbUNhVFpFVXN6?=
 =?utf-8?B?YWFHeDFFNDVVR0w2czdvVzR6cFNyWVRqVHlLSyt1eEpGQUREL1k0MzgwOFpp?=
 =?utf-8?B?ZjBJaHlyUmJMQmgvRFNsQVZGYmtFWm1JSjQxMHlqMkl2QktsTDV0T1VhYWpP?=
 =?utf-8?B?UDVUNGtHTUxBZEs3Z0FrQTVXWHV1ZTRqT0NBbmxzQTYzVFNTVEpjMkZPTjhp?=
 =?utf-8?B?aVpqYlRKQlNMWU1DYUNYQXpvUFpMWnVST3RsMlFDQWNkZERKV2RnYUxWSDEr?=
 =?utf-8?B?WGswZWVwODZsWnFXZWh2UzdCMnlLZ1EzZkRNZ29vV3hYWlBKSUlRV0xCSitR?=
 =?utf-8?B?WVBuWTBURUlzamh1YkQrQWgvSTdBenZLMElDc29KVjhGS1BLRFJvWm0yQ3Uw?=
 =?utf-8?B?SjRzek4veWVUa3hkVldpM2FFcU9Ud2NiOS8xT1hHWkZlQWRyWnh1UnRtZkNy?=
 =?utf-8?B?Ri8zdHdNRVpXY3Z4Wjl5WHoxc1BTOWhFWHVOMi93OWRySFNESGQ1NFE2SW9E?=
 =?utf-8?B?N1lIYkg1ZUR1SHVOcmQ4QkdtRTZhYm5FamdNY1R5a2FRd3U3dm4rU0U5dTlu?=
 =?utf-8?B?ZDBlc0g4Wm1EUDB2UFltbnZRamNaQnlXNFpyOE91dUFrMnlNSEl6WGtybHlQ?=
 =?utf-8?B?djI3N2J4cFZsUlRnd2F5OE1SS3VGcDdNS0NJTnZSWlQ5WkM4UG51NVJ2N0V3?=
 =?utf-8?B?aXZoQ2JHTUxDOGpwQkpQN01jUE1zbllvOGNXbzlILzRFdHdubEVZbTBNN0E5?=
 =?utf-8?B?NmFvWkVJZ0MrM0c5RmdDczQxM2lOTGRzZnpHaGlyRWxveUFlem43N3MxRHdK?=
 =?utf-8?B?c0U4eVR1ZDJuL1lxOTQzaERVTkVFV0VoZFp0bXlVNUh3MkxFckREb3d2NVAz?=
 =?utf-8?B?Vncxa2U3U1hwUExOU1hOZWNXbjdqMzlFNWpOSm1BWkxaVEQ3R2tTWGM4TEhI?=
 =?utf-8?B?d1pOMFhUTGNCS240OWx3OFdneU9ERzVhdXExQTNIeVlFRkxTVEVKNUJlT0RM?=
 =?utf-8?B?dFl5SlQvOG10NnFYMk1lZmFESTZtdXg1eHBrTWFJTXFKdzc0dmtoTFdHUy9O?=
 =?utf-8?B?WnNyaTg1WG43UCttdHhoRFZaMVFrRHlwSGJmWmk1UTdPODFyeWtPVE10UEFH?=
 =?utf-8?B?MnVwMFlmR2FPdDY4YlZFOWlFUVRTZXNzb2NUeW1DdEk4Y1NiN1hZYWxpcFl0?=
 =?utf-8?B?NTkzWXhyekFmVWRFYWM1K2lRblNVRTF0akhUUGY2MktJMzVGUHNxSTVwdEZh?=
 =?utf-8?B?OXJpWGtwS24rNm5LTVR2djA4U2tUc3RhRWFyUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmMzWE13ZHV0WVpNUUdBbzV2OWcwdWl6QUFRaXkwTW52bEpDTVIyRUVYc0Iw?=
 =?utf-8?B?cjdic0FjZ1QweTQwYXIveGtjUjBWMU5DY2xmUk1sQUV2SW5CZHNQbDJRWG9M?=
 =?utf-8?B?anFnUHZ0eEg1V3duUm5QUGppd0ZmSGxRcU9WSjliUHh2MDdmTDZWS1E3VzdV?=
 =?utf-8?B?b0sxZHRwbTZWK1poaUxsbDhMUUxKYzVzbVRMclZyRmJQQlNOajdsQnZJejlO?=
 =?utf-8?B?ZVhLdU5MdDBUSXdhdTU4emFvOGMrRU1OM2dUWnZzOXZjWUNsMEdFbjgzWm1J?=
 =?utf-8?B?L20xeGNGd3N5bDgzWGo0UWRYWFFIZlZxdjFLZUd1RjkyaDlNdlBqWUhVV0tS?=
 =?utf-8?B?T0FuL3B2bmU1Q2xiTTBlTHp3NERZUlZLVWVXWm5kb1VNY3g0OUx5cFFycDFZ?=
 =?utf-8?B?Vm8xcnhPZW9CdWlkQXNoNVprblE2RW1ISmkwSmE2bWdPTUtFQjNIc3lGcGNt?=
 =?utf-8?B?Rkh4Vk9pZmFCUXBIbFppblhDem9EZVhrWTVOQ2svSkQ0TXFOL2JRUTlkVVNy?=
 =?utf-8?B?bkl4dTZZK2gwQjQ1ZFY1RWxwL0dpeGZxVTErUENHeWZMS1NnTlB2RTdtaHcy?=
 =?utf-8?B?bDhTSHNMRlJNYWNMeGtrYkRNTWY1SnlnYk1JdmhjeWJjdEs5MzNYQ2NKd0tt?=
 =?utf-8?B?RGhndlBnaDQ2blZScDZEcExMcUZOeVJHRzVkWWljeWthdmxEd1lPSituZUdF?=
 =?utf-8?B?ME9SVFlKaVpVNDFLVXJUdWVoRDFwV1RDYnBOYWh0V3pGR2d3aC9wREpOYTZa?=
 =?utf-8?B?WGRPc1pYbHhjWkNpTFU5U2cya3VLQTNGRDFQbXo2V0U4dEJaTUhaY2hFTEV0?=
 =?utf-8?B?VS9WMTZWOGtIclYzbWc1VkxQZHJ3Z2NrT3B5cHlPTzMrdjRjeE1jRnNxdjVU?=
 =?utf-8?B?Zk1KMTBtRW1qUDg4dUJnUXpIeVYvUG5zZE44TDFTVlJ4SStQaS9aN1pVcnR0?=
 =?utf-8?B?Vm1TeUYvTE5ZQTFRNS83SjhjdW1KNDIyU0phdGx1TGJnZjVNQTdQcDhWRTRk?=
 =?utf-8?B?eU5vcTE0WUMrbG5qNXdvVFVPKy9kZkNUbG9iNC80L2l6U3p1UVIrTzhCOHRY?=
 =?utf-8?B?Y2lkL3RQK0ZtQSthMW9qc3ZzelR4aHFrYndWZ2NrWThtMlo2dk5BY3luL0Er?=
 =?utf-8?B?VWtUdm5saGcwaEhIblVEb0d5eC9MaEIzWENEN2JzVUJrVkRaWUxRaEFqaUJX?=
 =?utf-8?B?NmdsczR0cHRuTktIa0Z4TDEwRzhCdXhlWmZzWTNxTjRNTXRJUk4zb3RUZ0Fu?=
 =?utf-8?B?NzFMaVBBeDNkYTdRK1IwNk1RdDlBb0NxczJXSTdxeEpnazhhcWJMNTdCNnR4?=
 =?utf-8?B?ZlRqeXNiZGZNTFRkRG14YVNwMy90cFROT2dQMy9aSm0xWm01OFFmNUxtS1Z4?=
 =?utf-8?B?cmtJUHVTelVKcndrZ1dNOEY3bTZ0N2V5WWhVNkF4RVFIKzhhMzlRY0xTdDI5?=
 =?utf-8?B?ZkJKbzBZR1dHd1RCdmV6YlBUSVNra0tUdGlxQXduZzFGVnV4RjgrQXE4UUht?=
 =?utf-8?B?cWwyM0VKdTM2d01WVnBaMnEwbjEwNkhBUmFaeld5a3hWUWFBN2VOTDFGd1Zt?=
 =?utf-8?B?dW1icXo2T2IrVlZUUGFNckNPQXVzZEpMckhhdnN1NmJDL01icHBtSmFWQlQ5?=
 =?utf-8?B?RGxmWW5JSWRjQzhoMG5PcnhNT0VxWExwdi80RzZpMXRCNjQ4QlZpZGZwZldp?=
 =?utf-8?B?MkVia0Q0WkJwTWR6cGZmQ1lkaUFxcjYxZnlsbUFoQmV3U2tUbTd0RzJBU09a?=
 =?utf-8?B?LzFxb0NlbEsvN0FxeGlBdDdTeVJkR0ltNEYxbUJ3R3ZoVWpSQ1ViQmoyS1dM?=
 =?utf-8?B?WjJ6WnM5aFZKQ0xGVWZVTU5PYlgrWlpUR3BBZzJzdGpYT0FUY3dRR0dIUjNU?=
 =?utf-8?B?MGF5bE1tUUtwSDE0ckltRjdFZVRHTHlvL2xTQnJmT29GYlB3ZTgxVmNJUVlR?=
 =?utf-8?B?T2NaTkwvd1h3cHg1VXp2MFduOGRpaGM3Uy9EOVAvSk9NY3pXMjUxTUsySGpE?=
 =?utf-8?B?VG1sNmtla0RHdGIzZ1dRSUZDQ3JQSmlEeEdHTFhWUlVMVklUcGdVV20zYlpD?=
 =?utf-8?B?eWRXVHVGaU1hSEV2YnJhaldkZk84TmI5N3Fzamx3UmZyQnAzcDNqZisvNHVw?=
 =?utf-8?B?RFZPOHBKd2JKWGVzekt2UHBKSCtNcTkwT0wwZVBnSTgycXNUYkpNUUt4eHZH?=
 =?utf-8?Q?AKl+vdAgjfvWqr9pJ5/EudxMtPaaA4PVskucCiRU7Ase?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C53BC9ED58E9448A5DF4FB6A13FBA40@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ff904e-2785-4db6-59eb-08de1b585f2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 04:12:30.0908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +QqAG0JEq27WroBs388CX4946kRvj27lnAFl+bcdDqazNOj86Wm+IQr/aDxK8vb03JZe40M4kS8LhCG55SP/zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632

T24gMTEvMy8yNSAxNzozMSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IEludHJvZHVjZSB0aGUg
bmV3IEJMS1JFUE9SVFpPTkVTVjIgaW9jdGwgY29tbWFuZCB0byBhbGxvdyB1c2VyDQo+IGFwcGxp
Y2F0aW9ucyBhY2Nlc3MgdG8gdGhlIGZhc3Qgem9uZSByZXBvcnQgaW1wbGVtZW50ZWQgYnkNCj4g
YmxrZGV2X3JlcG9ydF96b25lc19jYWNoZWQoKS4gVGhpcyBuZXcgaW9jdGwgaXMgZGVmaW5lZCBh
cyBudW1iZXIgMTQyDQo+IGFuZCBpcyBkb2N1bWVudGVkIGluIGluY2x1ZGUvdWFwaS9saW51eC9m
cy5oLg0KPg0KPiBVbmxpa2UgdGhlIGV4aXN0aW5nIEJMS1JFUE9SVFpPTkVTIGlvY3RsLCB0aGlz
IG5ldyBpb2N0bCB1c2VzIHRoZSBmbGFncw0KPiBmaWVsZCBvZiBzdHJ1Y3QgYmxrX3pvbmVfcmVw
b3J0IGFsc28gYXMgYW4gaW5wdXQuIElmIHRoZSB1c2VyIHNldHMgdGhlDQo+IEJMS19aT05FX1JF
UF9DQUNIRUQgZmxhZyBhcyBhbiBpbnB1dCwgdGhlbiBibGtkZXZfcmVwb3J0X3pvbmVzX2NhY2hl
ZCgpDQo+IGlzIHVzZWQgdG8gZ2VuZXJhdGUgdGhlIHpvbmUgcmVwb3J0IHVzaW5nIGNhY2hlZCB6
b25lIGluZm9ybWF0aW9uLiBJZg0KPiB0aGlzIGZsYWcgaXMgbm90IHNldCwgdGhlbiBCTEtSRVBP
UlRaT05FU1YyIGJlaGF2ZXMgaW4gdGhlIHNhbWUgbWFubmVyDQo+IGFzIEJMS1JFUE9SVFpPTkVT
IGFuZCB0aGUgem9uZSByZXBvcnQgaXMgZ2VuZXJhdGVkIGJ5IGFjY2Vzc2luZyB0aGUNCj4gem9u
ZWQgZGV2aWNlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW1pZW4gTGUgTW9hbDxkbGVtb2FsQGtl
cm5lbC5vcmc+DQo+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZzxoY2hAbHN0LmRlPg0K
DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBu
dmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

