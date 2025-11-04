Return-Path: <linux-btrfs+bounces-18629-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F4FC2F41C
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 05:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70BFF4E6BAF
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 04:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F4A287258;
	Tue,  4 Nov 2025 04:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E3Rb9+3x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0222641D8;
	Tue,  4 Nov 2025 04:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762229322; cv=fail; b=EN3D07p8VLEuvRALqCHiRt+GNvXGfbLTktoZv212GdwcqjBfJDzmkq2mi2fjGJvW9Fp/ZVHcTv64Lvae3cHuf5ncyisZB4uTKNS4FN3H073eLvbhnYJ5cUQNy8kVEZtOeI/dusBjAj9N4fOfI03KR8pCvcifvPeo8MJY4HvyXk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762229322; c=relaxed/simple;
	bh=oBhLReoGJsKRjAKSQAaaYLXAhhahYeEeqZ9cihaxjoc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k/vVD9DClG7gJek6FKHkzisMw3Mop4h5iEffqMtfLZQn6q5YWhp7FFfA6oup152Pvw28DAyFt0RTnxi8BJOdOIKCSVlH4uTyIg2NpEMEghdXLk1MoA/2RyrmT6o2IlS0IhM9WdoOuDcSFLtr81n6ueW2IQXtg/pihjlTR/JVHjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E3Rb9+3x; arc=fail smtp.client-ip=52.101.48.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjTGLSqZCQRasc1gwORj9f7VAg4U6+6SWHgTyitB7fqvJObI7vIPBXGzWUu7h9ihUm6wh6FIf28AkQhJAPU4TuzD3q/+aMSt9Pk3K5ZvN+/D2X3OzIIG0w7gU9xv0R4Ds5AcxgpuXoR20pZanClh+Uwfsffk3JzmDDftgTxEc2IZK43eKoZOw+c9+AvqTZ8J9hVFLZHNTsrlQioXH0RXoRe+OpD4mB+t2BxiC+GfqemyJOU7Mpa83axjrmX6mEqLb62K44yBVdN6PRtSCJU55rLjSVscfXSq9OMh+qk60nCDyaJlTuT1V+3AtkO+VSxxLKqSt+ndiXefTK+4b81UVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBhLReoGJsKRjAKSQAaaYLXAhhahYeEeqZ9cihaxjoc=;
 b=p92ZpMnoQXbbHp3scQMBCHxnscUA+zdg/SUXYDSZml13XgEmqkPgRWOcEOvJLKO2Cc5pocs4FBQcfD1F85dPEuPVNCqFT/nAHTrSe9y3qL8baBbKBvJqLS5DCTzzzMiFe97lbA0/jB+Of29DWACCOq1cRZOQQJkokcTfqkBnSLNezrXDw46110EBGhf6Wqzttmq4U0pBgd3aUFknCTkFfErS1UbNB0cutAUgh+KuAL7DG6CEorCo2r1VGbND0DcsjNeoS9PcFwOcgNzu2iKMBmuOiQwXmV0dQ3BIazHiAZhhAkRqCKOGbeyZMxyi5bQx8O1Rog9A0it0wTrLcfRBfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBhLReoGJsKRjAKSQAaaYLXAhhahYeEeqZ9cihaxjoc=;
 b=E3Rb9+3x9R37zqzFK8mhr+YE/DZrUh/N26BwwnWfBNIuZIx5jMgyvOGdZer9rOVbb0hdD+ZRhGLESIaYrkHdmag1xaEzeKFy3qdD3fGATl6PZVG5Ltvm2Bf4rN36q6HYKQ/XBN3FsU1MP2NhKj2mzYXG/8PS1eqPeTDRKXouMQkyZpyY2RPXW3WX1cljfyMfD+OUIM6H3mSlG0o7xsan2uyVdqMNBgxip/jONdVCnJrxZ6RP8BoIC0TCwN6OCyukFcWKGrEhz2cC6nDgEBcqtZ8vSebAZ920cCj5l6HKvKHMJiP4Skyo3DkHDhH30xgYxZbUTo31G+VLbXTW7SF0pg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 04:08:38 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 04:08:38 +0000
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
Subject: Re: [PATCH v3 07/15] block: track zone conditions
Thread-Topic: [PATCH v3 07/15] block: track zone conditions
Thread-Index: AQHcTStosBUzCm+HaEeRSWoiUtqgL7Th5wyA
Date: Tue, 4 Nov 2025 04:08:38 +0000
Message-ID: <0c309062-05f9-438e-91cd-22971339be2c@nvidia.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104013147.913802-8-dlemoal@kernel.org>
In-Reply-To: <20251104013147.913802-8-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB7632:EE_
x-ms-office365-filtering-correlation-id: b7384249-fcb5-42e5-e423-08de1b57d4eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?V0hZa2JhUFdSenV1NFA1TWpiR1owTThBTjViU2FpUkovSUdQUitVZ3E0WWht?=
 =?utf-8?B?YmpsbzdzZFluaU9LbFBvOEpUTmZOUHYyL29XK2t2aTNQZjEwTEt0Ty9rUG44?=
 =?utf-8?B?VGh5Z2J2LzJUNGVNcWlURFdhLzBmNUdSTjc2MjcyZnJSTTUrd0s2bWxveDhK?=
 =?utf-8?B?UWZGTytiaVFDS0J2K25wallZRmlQR0p5MWlSR2ZodXZBRHRURmZjWDVSa2p1?=
 =?utf-8?B?RHJyZEhISG0xbnVkLzZYMFErZTJRTlU0WU9kTmJsRnE2SFZGaG5VVlRYUjNK?=
 =?utf-8?B?WVdYRkdlblFWbWJJbGNnbGFiTHdMbkZMZDkvMm5sWllKeE5Xd1ZQUjU5dmEw?=
 =?utf-8?B?ejlBRDRRdU1xZHJOVmh0OVBlY1djWkFzSTg5dTg3bU5CTEpTRHluUTlsMndU?=
 =?utf-8?B?ZDZncXNwYmJMSTlEWlIyUWp0Y3JxeUdGSW94dVZuMFlkRW9DcHB4OHpqTHRi?=
 =?utf-8?B?KzFXZHVjbWE4K1RxU2txQ2x5UVNjUFhRdGovRzVZcEpKcVlLYXVIMnJqajVF?=
 =?utf-8?B?S1loMkFqNHVYcXQ5R0JSL3Rqa0hJT3hRb1o4K01TSHZWc3cwRkU1amQySDZq?=
 =?utf-8?B?K0J0RHFkcExoVm1jQys0dGRBK2NXZEo0MVVUdDFwMENBNXBvVHo2T2lUQW9V?=
 =?utf-8?B?MmVOZU40TWdHcEExSlBsb3hFTzFmWFMvV0FJN3FTNnQyRk1naEZOL1ppVkFq?=
 =?utf-8?B?TGpoeE5sQWRNeVhnanZoMVN1cGdLdzY3UTBLVUF6Y1JGVDljNW5lUVFIbDl4?=
 =?utf-8?B?RmRveFBraFFXSDRQRkl1OHJ2ZVBpTkQ1YzdGWU91ejQwQS9PUWNORllrWGxj?=
 =?utf-8?B?WVlDTkJzeXNBRjV1cVcvQXhXNysrR1lzdWlySDAzSVFGNDJNeDRTZWg4Um9S?=
 =?utf-8?B?WlBWWWVGZWlGbmN1aUdPV1JzbjhaT0c2SzNxeWFWMW5jMVJWeUhxNmtSM3Vi?=
 =?utf-8?B?ckhuUkp1QlBzWFFyYllxMlZBeDBzS0ZkY0g4ZkpZUWxNaFEvUjhrNWxyc1M3?=
 =?utf-8?B?eEdVaGN4WnZ3MnlRZTFlazlRUjVaRGVVWG1wRlVQOUVWODloQkw1akZ5UktD?=
 =?utf-8?B?WU80bTFhcm5KRHppejVYcndMVWZrSkR0V0g5eCtTaU8wd21YczdMMHFKMXhN?=
 =?utf-8?B?bkdLL2JEUXBKakFQZXVzQTZseFgyZ3BjZm5VVmR2ekhhUjIxd0tBcnBvN0or?=
 =?utf-8?B?OGVzQXNxTzdUOWlRTnNiSjJzUkgwdXFDcHdSYlBDMHpGSGFDaDFyV1JYMGNr?=
 =?utf-8?B?OWQrZWt0L0tySE9rWUx0S1VlMXFRRGFtNXBiZVArOWU0NHRCTU9rK0xSU3M2?=
 =?utf-8?B?VmZZM2kxcnA0ek1vRUZUUTNLYUt1VXpNOUpKSkY2RFFzWEZBcTAxNHRhTWJv?=
 =?utf-8?B?REhBdUFjT0lzUmNNcXJUdGVwb2tNclhmYWtiZHR0VGJMbGVlZzhYMDU5TUta?=
 =?utf-8?B?ZEZsQWNXS2VSSSszOG1ZTFJvZFFtVXc2Tms3ZHNiUGU2dzBTalpQUGZLbWht?=
 =?utf-8?B?b2Z2RjllZjNJei91bWNCVTJJTU5MeU5NQ1FrdHhTNjgvalp0cVJSYXdkNkVC?=
 =?utf-8?B?NXMvTU1PYWNqYlR6N1NxTStBaUUxcVZwWWFyaWJWalRqczlDVXIyQjhaeDNR?=
 =?utf-8?B?VmxkRmk2UU4rUXdGWkNSdldKWUtMSnZ3cHpyNEpVL0NOLzNTYjV4bUJMWG1H?=
 =?utf-8?B?cHlZWUJPNHRGc0RTV0NYWUlNMVROK2FEL05QcHBJeVFxRDVIdFpwUFhzN05I?=
 =?utf-8?B?Ulhmekx4bm5BRDV6NktGWStQLzlwNlVZU0JISmdZK29YOG4wMElyc1BFNG1N?=
 =?utf-8?B?QjRiV1h4QU9QUzBVZmJ2SGppRTNFdFpPUk9ueVNicVYxN0c5U3lJbUwyNGZm?=
 =?utf-8?B?eDAvdnQvdURYcUNVaENlcWM3bldxQ0tRYy9KR2tEbEI2U0xtU29weHFVMTNN?=
 =?utf-8?B?SkdQYXVJYUF0Z0hGV1g2QndiSzNDRlJzVU5VTXFFS25URnNtVk9URU9rM0hE?=
 =?utf-8?B?U281MktTdnNHMklLQStzTEs2cWZBQUJ4RHJSZDB5ZjJMVVhnODQ2dXNSMk44?=
 =?utf-8?B?QnYyZVkzNU5wbEdpR1ByYmVSQU9EaFdZZG5Ndz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M3dzNU5PYVdGRGgrMm1sb0dtbmJ6UlZscWc3dk5vNjNjWlpDR1c0NVhVNDdW?=
 =?utf-8?B?ZXhLWXNBbklZL1dMU0JMaWJxeHR5MXFlVzRIa3FjSThVS1hiY2pNb1VXV3ZR?=
 =?utf-8?B?My85b3Z1d2t1ei92S0FubTg3M2tMd05GYjlQQThPUTIwTU5PelRDTzZsK0Iv?=
 =?utf-8?B?c3BDQ0dUSzBYS0VaM3dmdjA2aFRsRW1SRGNSU2g0cjFuSEpnV1ZoeTNlTkRx?=
 =?utf-8?B?Zy9QcUswS25sYzl1ZTBya2tlTks2YjJKQXVkdC9xU1NFY081cjhzZEIzWnBE?=
 =?utf-8?B?Q0FkMmZrcVVkMUZtKy8vVUl3VFY1cVFmU21qbkt3ZmJ0amtycytLODhhUXNS?=
 =?utf-8?B?L3BjQ3YvL2RLYk1iSzZUeGZ2UWJxN2lxVTZpS1ZwRzRNK0YzbUxTMVl1MFE5?=
 =?utf-8?B?WW8veVpNVDRUQXgyRTM5RklFeVBoK0EwY0RSUFZGRUdQQWxjSEZicld2eXJp?=
 =?utf-8?B?OUZ4cmNTQ0hTWlU5R25QS0tabDNkNGRHRGh5aWlmQzRjOWZJVnJFeFJyblVp?=
 =?utf-8?B?bG1UbkNIN0F6blZKcklpTHhXZFI3R3NqQXphOWpaSEpvdnkxUG1kdThWWkhV?=
 =?utf-8?B?cS9zSlV5anp1NTN4RFVxVmpVbWg4RGRUSjdMaFNRKzF1SXd1S0RvZCtwQ1RC?=
 =?utf-8?B?N0hidUh1QVE0RnZEZTlnWlJqR2lYYWd0bmQxVUQrUHdYaDN3RzVVQUliNTZo?=
 =?utf-8?B?OE81QTMvTHBiY2NyVFV2R0c0TEZTNHRGTkMvWEQ2clk5WnlERk5FYXdzVGl5?=
 =?utf-8?B?ZGEvd0VOVzdHUlhUMDI2TDBucFpEVjVqNzJBdWFpa0U3eUFGT0JBdFhydE4y?=
 =?utf-8?B?NkxOZVlDR3ZVbHlRT0kxSVl0czI4Uzhob1FNaGlYVWVDMnJPcTM4QWZ1S0Vo?=
 =?utf-8?B?cWRqYThaSFkwclF6c0ZHb1dzZHU0U3NFci9uc25Ea0kwUmNKV0lUNHVmdmJD?=
 =?utf-8?B?dmZaNk8yWW16L0lnUk5HWWZEbkNyQzZTcjFvREx2YXVhcWN6N2d3NkxROUo0?=
 =?utf-8?B?R29MT0Fvd09TZlYxNE1xZGFIM1c0ellnOVJYRGE1ckl2ZFpzTU9HWkMvVmF2?=
 =?utf-8?B?ZW9ZQjRsVU40Y3FEYUVHRENyWXppTVpvTWMyZ1MzLzdyM0dUZ3JCemNYMXlK?=
 =?utf-8?B?azR3MDRNbk9XSGh4bFhFTEsyQWhTZ3lLNjdzZXdnNDk3SXJwa1F3ZStXK3Bl?=
 =?utf-8?B?R3c4MldXN0xBc3JRVUR6Q1QwcWNHVG9kdk5uVm9PcWVpNVUwUldveDJCdGZI?=
 =?utf-8?B?Y2hET0E3SnNKdXFtZ0o0TFpmNHRjN0Faczg0bHZCNWFia2FpcWtKRTRLZHRu?=
 =?utf-8?B?NXplak9EdmxXMTlTbVJZVjYrMkFFM1U4Zk45UHdyQWU5K2dnbTJsREtWcjNF?=
 =?utf-8?B?NjZrbTNVOGN2VmF3ZUw0R0kvYkxIR0JxR3E1ZnZjZHloRVlTRDh0OXRScGJQ?=
 =?utf-8?B?QS9ybHpPa29VRUhsQ2NkVHJuRmUzRHBmNHcrcHlmMXV2VGt5aC9mZm9uaFJF?=
 =?utf-8?B?QTBoYm9CeHBzQ2NMV3R4bG00N1dUMFIramJhdStPMWdsN29mM0s0TUdnUktp?=
 =?utf-8?B?eUg5MVFvWTNOak9qQ3k0eVd1YXc4T1hjMEd0Smhrb3A1RmR4Ynd3a1FQYU9D?=
 =?utf-8?B?QXd6OW1NQnpnRFpUSS9aVmdkc01rRkJoajZhbUJGSlcxMTBKRi9xVURtc2Yy?=
 =?utf-8?B?R3FpakZjVW4zUll1SERhRFdiT1N5WmJYNVJSd1pKMXR1UkYxQ3ZPVEs4Y2lz?=
 =?utf-8?B?TVBTOVE2dVJtMHU3TUxRMkR0T2N5TkpEeFU0WWdCcks5NVNlaTlCS1FubGND?=
 =?utf-8?B?aHFlQ0x2cjZlWjhtMzVZdjMwS05JQjNSWGJqWDNCN0NRN3ByS2ZvUnE5RWpP?=
 =?utf-8?B?OC9pbzZMUzE3eGlKMll1aFhuSXhQQWlKbmhobzBraTY1Q1EzSld2WHA2U2xj?=
 =?utf-8?B?Vys5MG84UjE0cTdBWDJxb0ozQVJoUzcySWhwazBRWGxFdlJkRG8yYVorSmh3?=
 =?utf-8?B?cjRoZ1FITlRwbi9YV09GdEN4ZGZjeTJLRjVpSktWazJsRWVJaW12SGRGNU11?=
 =?utf-8?B?aFIxTHcxRHNkcWdTN0tMZktOVitRZWtrWjBZSFEyd2hLSGp0b3JtUE1UMkt5?=
 =?utf-8?B?Z3BqbnJhbXNmSXRrWEFnS1J6MFFYK3Mvb0tnVCttLzVMQkdQWCtTS3Fobk5y?=
 =?utf-8?Q?tm2PAX/mlz2tazTXBDpbIzZ2NsP5dTn2s4ZmILENoOPn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62592BDFDD683844A810A7142B87942B@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b7384249-fcb5-42e5-e423-08de1b57d4eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 04:08:38.1027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8zPzwQl55sxiziYhRVNnfK8oA5D+Na/JZPsUUKtz2ppNQKbYSqnBXyvPktwaQkVhalQXV35+pU6k68/Asu7kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632

T24gMTEvMy8yNSAxNzozMSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IFRoZSBmdW5jdGlvbiBi
bGtfcmV2YWxpZGF0ZV96b25lX2NvbmQoKSBhbHJlYWR5IGNhY2hlcyB0aGUgY29uZGl0aW9uIG9m
DQo+IGFsbCB6b25lcyBvZiBhIHpvbmVkIGJsb2NrIGRldmljZSBpbiB0aGUgem9uZXNfY29uZCBh
cnJheSBvZiBhIGdlbmRpc2suDQo+IEhvd2V2ZXIsIHRoZSB6b25lIGNvbmRpdGlvbnMgYXJlIHVw
ZGF0ZWQgb25seSB3aGVuIHRoZSBkZXZpY2UgaXMgc2Nhbm5lZA0KPiBvciByZXZhbGlkYXRlZC4N
Cj4NCj4gSW1wbGVtZW50IHRyYWNraW5nIG9mIHRoZSBydW50aW1lIGNoYW5nZXMgdG8gem9uZSBj
b25kaXRpb25zIHVzaW5nDQo+IHRoZSBuZXcgY29uZCBmaWVsZCBpbiBzdHJ1Y3QgYmxrX3pvbmVf
d3BsdWcuIFRoZSBzaXplIG9mIHRoaXMgc3RydWN0dXJlDQo+IHJlbWFpbnMgMTEyIEJ5dGVzIGFz
IHRoZSBuZXcgZmllbGQgcmVwbGFjZXMgdGhlIDQgQnl0ZXMgcGFkZGluZyBhdCB0aGUNCj4gZW5k
IG9mIHRoZSBzdHJ1Y3R1cmUuDQo+DQo+IEJlYXVzZSB6b25lcyB0aGF0IGRvIG5vdCBoYXZlIGEg
em9uZSB3cml0ZSBwbHVnIGNhbiBiZSBpbiB0aGUgZW1wdHksDQo+IGltcGxpY2l0IG9wZW4sIGV4
cGxpY2l0IG9wZW4gb3IgZnVsbCBjb25kaXRpb24sIHRoZSB6b25lc19jb25kIGFycmF5IG9mDQo+
IGEgZGlzayBpcyB1c2VkIHRvIHRyYWNrIHRoZSBjb25kaXRpb25zLCBvZiB6b25lcyB0aGF0IGRv
IG5vdCBoYXZlIGEgem9uZQ0KPiB3cml0ZSBwbHVnLiBUaGUgY29uZGl0aW9uIG9mIHN1Y2ggem9u
ZSBpcyB1cGRhdGVkIGluIHRoZSBkaXNrIHpvbmVzX2NvbmQNCj4gYXJyYXkgd2hlbiBhIHpvbmUg
cmVzZXQsIHJlc2V0IGFsbCBvciBmaW5pc2ggb3BlcmF0aW9uIGlzIGV4ZWN1dGVkLCBhbmQNCj4g
YWxzbyB3aGVuIGEgem9uZSB3cml0ZSBwbHVnIGlzIHJlbW92ZWQgZnJvbSB0aGUgZGlzayBoYXNo
IHRhYmxlIHdoZW4gdGhlDQo+IHpvbmUgYmVjb21lcyBmdWxsLg0KPg0KPiBTaW5jZSBhIGRldmlj
ZSBtYXkgYXV0b21hdGljYWxseSBjbG9zZSBhbiBpbXBsaWNpdGx5IG9wZW4gem9uZSB3aGVuDQo+
IHdyaXRpbmcgdG8gYW4gZW1wdHkgb3IgY2xvc2VkIHpvbmUsIGlmIHRoZSB0b3RhbCBudW1iZXIg
b2Ygb3BlbiB6b25lcw0KPiBoYXMgcmVhY2hlZCB0aGUgZGV2aWNlIGxpbWl0LCB0aGUgQkxLX1pP
TkVfQ09ORF9JTVBfT1BFTiBhbmQNCj4gQkxLX1pPTkVfQ09ORF9DTE9TRUQgem9uZSBjb25kaXRp
b25zIGNhbm5vdCBiZSBwcmVjaXNlbHkgdHJhY2tlZC4gVG8NCj4gb3ZlcmNvbWUgdGhpcywgdGhl
IHpvbmUgY29uZGl0aW9uIEJMS19aT05FX0NPTkRfQUNUSVZFIGlzIGludHJvZHVjZWQgdG8NCj4g
cmVwcmVzZW50IGEgem9uZSB0aGF0IGhhcyB0aGUgY29uZGl0aW9uIEJMS19aT05FX0NPTkRfSU1Q
X09QRU4sDQo+IEJMS19aT05FX0NPTkRfRVhQX09QRU4gb3IgQkxLX1pPTkVfQ09ORF9DTE9TRUQu
ICBUaGlzIGZvbGxvd3MgdGhlDQo+IGRlZmluaXRpb24gb2YgYW4gYWN0aXZlIHpvbmUgYXMgZGVm
aW5lZCBpbiB0aGUgTlZNZSBab25lZCBOYW1lc3BhY2UNCj4gc3BlY2lmaWNhdGlvbnMuIEFzIHN1
Y2gsIGZvciBhIHpvbmVkIGRldmljZSB0aGF0IGhhcyBhIGxpbWl0IG9uIHRoZQ0KPiBtYXhpbXVt
IG51bWJlciBvZiBvcGVuIHpvbmVzLCB3ZSB3aWxsIG5ldmVyIGhhdmUgbW9yZSB6b25lcyBpbiB0
aGUNCj4gQkxLX1pPTkVfQ09ORF9BQ1RJVkUgY29uZGl0aW9uIHRoYW4gdGhlIGRldmljZSBsaW1p
dC4gVGhpcyBpcyBjb21wYXRpYmxlDQo+IHdpdGggdGhlIFNDU0kgWkJDIGFuZCBBVEEgWkFDIHNw
ZWNpZmljYXRpb25zIGZvciBTTVIgSEREcyBhcyB0aGVzZQ0KPiBkZXZpY2VzIGRvIG5vdCBoYXZl
IGEgbGltaXQgb24gdGhlIG51bWJlciBvZiBhY3RpdmUgem9uZXMuDQo+DQo+IFRoZSBmdW5jdGlv
biBkaXNrX3pvbmVfd3BsdWdfc2V0X3dwX29mZnNldCgpIGlzIG1vZGlmaWVkIHRvIHVzZSB0aGUg
bmV3DQo+IGhlbHBlciBkaXNrX3pvbmVfd3BsdWdfdXBkYXRlX2NvbmQoKSB0byB1cGRhdGUgYSB6
b25lIHdyaXRlIHBsdWcNCj4gY29uZGl0aW9uIHdoZW5ldmVyIGEgem9uZSB3cml0ZSBwbHVnIHdy
aXRlIG9mZnNldCBpcyB1cGRhdGVkIG9uDQo+IHN1Ym1pc3Npb24gb3IgbWVyZ2luZyBvZiB3cml0
ZSBCSU9zIHRvIGEgem9uZS4NCj4NCj4gVGhlIGZ1bmN0aW9ucyBibGtfem9uZV9yZXNldF9iaW9f
ZW5kaW8oKSwgYmxrX3pvbmVfcmVzZXRfYWxsX2Jpb19lbmRpbygpDQo+IGFuZCBibGtfem9uZV9m
aW5pc2hfYmlvX2VuZGlvKCkgYXJlIG1vZGlmaWVkIHRvIHVwZGF0ZSB0aGUgY29uZGl0aW9uIG9m
DQo+IHRoZSB6b25lcyB0YXJnZXRlZCBieSByZXNldCwgcmVzZXRfYWxsIGFuZCBmaW5pc2ggb3Bl
cmF0aW9ucywgZWl0aGVyDQo+IHVzaW5nIHRob3VnaCBkaXNrX3pvbmVfd3BsdWdfc2V0X3dwX29m
ZnNldCgpIGZvciB6b25lcyB0aGF0IGhhdmUgYQ0KPiB6b25lIHdyaXRlIHBsdWcsIG9yIHVzaW5n
IHRoZSBkaXNrX3pvbmVfc2V0X2NvbmQoKSBoZWxwZXIgdG8gdXBkYXRlIHRoZQ0KPiB6b25lc19j
b25kIGFycmF5IG9mIHRoZSBkaXNrIGZvciB6b25lcyB0aGF0IGRvIG5vdCBoYXZlIGEgem9uZSB3
cml0ZQ0KPiBwbHVnLg0KPg0KPiBXaGVuIGEgem9uZSB3cml0ZSBwbHVnIGlzIHJlbW92ZWQgZnJv
bSB0aGUgZGlzayBoYXNoIHRhYmxlICh3aGVuIHRoZQ0KPiB6b25lIGJlY29tZXMgZW1wdHkgb3Ig
ZnVsbCksIHRoZSBjb25kaXRpb24gb2Ygc3RydWN0IGJsa196b25lX3dwbHVnIGlzDQo+IHVzZWQg
dG8gdXBkYXRlIHRoZSBkaXNrIHpvbmVzX2NvbmQgYXJyYXkuIENvbnZlcnNlbHksIHdoZW4gYSB6
b25lIHdyaXRlDQo+IHBsdWcgaXMgYWRkZWQgdG8gdGhlIGRpc2sgaGFzaCB0YWJsZSwgdGhlIHpv
bmVzX2NvbmQgYXJyYXkgaXMgdXNlZCB0bw0KPiBpbml0aWFsaXplIHRoZSB6b25lIHdyaXRlIHBs
dWcgY29uZGl0aW9uLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW1pZW4gTGUgTW9hbDxkbGVtb2Fs
QGtlcm5lbC5vcmc+DQo+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZzxoY2hAbHN0LmRl
Pg0KPiBSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuPGpvaGFubmVzLnRodW1zaGlybkB3
ZGMuY29tPg0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fy
bmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQoNCg==

