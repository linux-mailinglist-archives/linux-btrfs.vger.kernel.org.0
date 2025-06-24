Return-Path: <linux-btrfs+bounces-14910-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4162CAE650C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 14:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9AE7165302
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 12:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0C5280CC8;
	Tue, 24 Jun 2025 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fRBtOxJX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uhvT5lUj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A615C2B9A6
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750768385; cv=fail; b=aqD2cpuHwwnNUejTlczAMmXC3FmogR5nqO/NxyEsxRbojzJs4iQxXlHXXmnkVd8kCcif+qoDOkx/6VICu6ciC9XGzWOFx2p0N5GZporM6JgE7jW8GeGL1BRx96xiEOmlS9yZOEFICUkKcwr9UYqMiGH1sJRTYwi2fjCm2rZIa7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750768385; c=relaxed/simple;
	bh=s7Fk0Vkyy6qxxc6me4BO8VGyaSgt1jvr3BAuG4m5nHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gagorcWHxDpwryCLf+VZAcTY7bmMOg7b0y0laf1B4qlDlA+yf3XOoVvnz3SqT7xWyLb5OYKa60oC7w4it/dv2G83Ic6CFL2FefDb+egaZpb9RhajsnoS2J/gmnwUbW89ysxDgG+TZ9L5Baa8I8z4LjQtonCfg4tBBkwcdTpaZds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fRBtOxJX; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=uhvT5lUj; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750768383; x=1782304383;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s7Fk0Vkyy6qxxc6me4BO8VGyaSgt1jvr3BAuG4m5nHk=;
  b=fRBtOxJXpKhwUe6ejQWCqQzi7YPuKdhD32H/QFXrZO5bd4jn2LYFFhoF
   NQC34z5KmKS3mEuKGsAomqYaeoHgjpan8Eg4A8MuPIi2V5njSqa+6enSd
   xY61nRfQ6ndaV07ynumFHHjcRQy3JbNwnKVPUAvsyu8z2BQPBXwYr8Bjm
   rFVT99nxARgSDDKsX0hI4ZTY8aTItPdr/j1NrfEqIvXjHgNJOlyqgypKz
   NgbVlCMC6dbIBhMKJYDYkLpJ3KM2CdpdbKlxqFEGgO7SKIyBLRZKBEAiq
   qfzOUmYjv5giuIqCGQnlICnoamDj4yoCdb88zsG0mDnGC1hDz3JZcrDe4
   w==;
X-CSE-ConnectionGUID: xucw2jhJQ9WHySnE5qJxIw==
X-CSE-MsgGUID: xxRAWcbiRTGhwFYWwEaV2g==
X-IronPort-AV: E=Sophos;i="6.16,261,1744041600"; 
   d="scan'208";a="91178057"
Received: from mail-eastus2azon11010010.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.10])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2025 20:32:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/F1pEGF7A3lviLdKS9h9wqxmXC0knhTu0hZry5I4oszl1cvRxSLYaPygtwc7qHmvYkYnjXikReUda9KjYTOJ7EN7LG2rX0NjjoZgex9W2DnsBWARJuYvpUjgxdJxF0islyKe9paWrNDUHGNYS6vmPqCoEVGVtsIpPOPTrpX05vdBBej4ANE2Yo9ASZhMV6R7xU4SIH1Xc5WfeydwqsjBUyD3159F1dOk6ao3OkgqoWTBE6vlxRepcHbgBSpsjJDT9qzzK01znx8mCtnMnUYPRwRly1b6OnLZxRRsE8zD5WKYgJ0v5T1WQLqHc82QYdORAIN9Yn+7Q99zrhSrGz1gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7Fk0Vkyy6qxxc6me4BO8VGyaSgt1jvr3BAuG4m5nHk=;
 b=L8a5dpIhiMjti+TilcZPDz72z1u5zfWTMNFfjctUAW0cHp+p7YZgVronEYVxFlFg5m3yonUW/I4+TENtTLKy90vZXOpvOCIY0dKkczH9R1gJf0IzWMiwPA2MzBJieBSkQkCDIAcG2daqZchNKOVXvhOckVcKTgWpWp6Ac0GKhJVNVTXe4IIsyf0KmgBPb7qSWFS1BndGpVNRY6d0aB/p/zZ2dYjHHfUmid+Lt1cmWUoCSK5RhGAloYrCTQhwg6b0K4tcCVVtEXSN+sUvJj9K2rUsylkYP6j9OWXNr4x02Fk5MLIZYOgKNmXne9NwQT+2L2uI8Op+vBRJRpTdNI4pMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7Fk0Vkyy6qxxc6me4BO8VGyaSgt1jvr3BAuG4m5nHk=;
 b=uhvT5lUj34NDMCEFXy1h0MTfJS2VYw8avcLyT/S0jsleuYvF9LE+gsK7Fm01dmwOYAaK/5FvYGFm+qvW7R1BOvRMdp83XzcetIZpcz0zVrBHPqsaNbwksGPQ7qLMDQVTo2vnaGbjN/H6cIyMVijtAD+DOECveQ37WcNKSozQOtw=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by PH0PR04MB7835.namprd04.prod.outlook.com (2603:10b6:510:e6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 12:32:54 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%5]) with mapi id 15.20.8857.016; Tue, 24 Jun 2025
 12:32:54 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v2 1/3] btrfs: zoned: get rid of relocation_bg_lock
Thread-Topic: [PATCH v2 1/3] btrfs: zoned: get rid of relocation_bg_lock
Thread-Index: AQHb5Oua4ffn4XxTS0WOFTuo8mhsW7QSPl6A
Date: Tue, 24 Jun 2025 12:32:54 +0000
Message-ID: <DAURLBJDUGQJ.1W5C4RDQ8GJHF@wdc.com>
References: <20250624093710.18685-1-jth@kernel.org>
 <20250624093710.18685-2-jth@kernel.org>
In-Reply-To: <20250624093710.18685-2-jth@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|PH0PR04MB7835:EE_
x-ms-office365-filtering-correlation-id: 22ab752c-8f99-4de0-552e-08ddb31b3e4f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b013WGFRakN2dzNScVpPTEUzMUlNd3RHdEdYK3hpZ2E0YlJrQWIrd3JxR0NM?=
 =?utf-8?B?dStKTVlYb1RGS0NkWS90c0I0dktQQjJ2aDh5V0FhSzd4OWh4aVRoUlpqOUxJ?=
 =?utf-8?B?MTVPdDVSblc0cHlHVDNWSnNjZmplRStEalhod09VeXRDRlZmeTdWV0JYUG01?=
 =?utf-8?B?NEgvcVYxd3BSbEFxSHA1Vnk3R25SKzdkN0E3ZkZTYUZZcXRVYXZzenNrZU40?=
 =?utf-8?B?RXU0c3RSYUxLaVhOTHRPSFBmZ2FydnBYYnUvUittNmtaRjhLRzl0cFRGcmF1?=
 =?utf-8?B?Q3FDalJTR2hpQkxiYmw2WlZzYWljMUpRUUJhVXBZRGZxNDZwQWNQSmRyQWdh?=
 =?utf-8?B?dGhoUWdOU0JWdGRNUyszSkJJQTlQbzJXOVRvLzdKZGkzL1dLdWFOS09GSFBi?=
 =?utf-8?B?RUVTRjJ5cjd0b2JXREFWcFZQMm5ZYzl4Q3N6RjdTQnc2bkF4Z2R1N3hVTnUy?=
 =?utf-8?B?VHZoV0NrMFJJM2xFQWUza25neExXUmVpa3FSUEIvSGZkc0lObjVUZnpLUkc3?=
 =?utf-8?B?Wll5OXRjMmlsZDdhNGFpQllwOFc0NUs5c1lubjE3bFhhSFV1VjJXZThmQnpt?=
 =?utf-8?B?K2RkdVB4Lzg1cm53cysrb0dQUnk3c3VPMTNSUmsrV093SXZPcjJObVMvVjd2?=
 =?utf-8?B?bmJTM0VTZWFhZ2NMd05LamNmR09VNTdBUDZhajNKalVzU2oxVldMUzJuOEFQ?=
 =?utf-8?B?NjRFZnZ5OUh0ZXNSTGRuK0FMYUhHR05GcWRPdzc5YzE4anNBUGQ0ZVh1VU1p?=
 =?utf-8?B?RHdqbFJPeEQ4QTlsQ1NLdVJkb1kvRVNaSWdIUlBYY1YreXE0dTliSnNVbkJl?=
 =?utf-8?B?eUtpc3prQnM0MUFTN2V6TmZ3dmZDdGVka0gvb3hMOEh2ZXZpdzU2WUx2VnY1?=
 =?utf-8?B?NUY1NzM0TlN6bHpYek5hdmlKVnRmVDVUeGZOV3JrY0ZObUNDVjhVZU1MTUh0?=
 =?utf-8?B?K0VXYmNudEMwZEdFa1V5WCtoZU01YVhwWDNnL1dkaTJ3WGJNdWp5U2FWNHNo?=
 =?utf-8?B?cmNRRG9rVVlGYk84QTA1OG10TUwxVkN0RXlaUHVhaWNaa2NEL3BKcm1NaThp?=
 =?utf-8?B?YTdrR1NqZmFSd3p2dTNuNmhQOGx1T3UwNjE0N1M2aEF1RU5GUEc2SUovYk5T?=
 =?utf-8?B?OG5xMzRSRGpEekpFTVJjaENxTmNvZXZDYURSamVCcDVpclFuVXhPUG5wZ0FM?=
 =?utf-8?B?ZllHZEZoL3dwNHZab1JOSlI3c1pCSVRwUTdZd1lPbkg3Z1lFWk9UcWg4bGpw?=
 =?utf-8?B?aDE0OVNLb3oxVTRkbnZycEQ0TWJ6TDVRWldkYzEyMlFxbmRtY2ltMWFQYm45?=
 =?utf-8?B?QmJWaUwvM0lqVmxVSHg5dWUyZXl2aVBPMzR0N3VRMXJOZVZvb0xTUUFIM0Rr?=
 =?utf-8?B?YXR5MW5VV01LY3dWOTkybTBDQk52SkhTZFR2cHdYMEFqNktkODlyMytraUNq?=
 =?utf-8?B?clBBVzlndlN3ak1sSDJNUk54OGFtQzNxSnI4Q242NWsxSHpROHVQank0VFhk?=
 =?utf-8?B?YnZrTDVMcld0WE5WYUR3OXVTdi9JZEZPSktOV2ZjSVNIdXBQdzdXTGQwLzBa?=
 =?utf-8?B?ZklXOHh1eUtHazdHNjRoa3J6Ulc4ZGhKR1RDTkdwSVFrK3RGNDZHSVQxRk5h?=
 =?utf-8?B?MWlxSWk5V3NvcnVkazUrY1NSKzE0a2x3Z0kvY0pBaVk4THFUVmx3UGxzM29I?=
 =?utf-8?B?K01wTENvQXd2RXgxbjJrYnhmUnZCYUpUYm1YVWFndks2QXpCR0c3ckRXQ01N?=
 =?utf-8?B?RFQ0U3ZET0N3c0JScVFhWFozRjB3ZGpneUxSaU5Uc2g0WUgvUW9JWUJIbUlH?=
 =?utf-8?B?S0N2dUlCak9zengyR3JNcXFRYVl0N0NhOHllb0NSTERYY3Faem9NLzg4d3dv?=
 =?utf-8?B?M1ZTZTNCMHFRY3dwYTFUYlBESi92QTZWSXVzUmVCeUttR0t2UFBCcU1SZG9C?=
 =?utf-8?B?b1hFc01qR3c4VnFPSkc1Z0FnOWhCV29qeHQrbG1kay9RY0NZZlFURjJZK3JI?=
 =?utf-8?B?SThxNFlmV053PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2JMVU9aUDZUYVM5VlRRcjZNRFhSemlSUXBUYWVrZUp3YlRoREZMUStkTzBB?=
 =?utf-8?B?SStzTVh2SXV5QXhqVzg0akJVTTR1dkRPL3ZCd3BTdGlwc1JveWVodnBlUnRw?=
 =?utf-8?B?cFVxMHJBZ1oxZU82bzRMR1R3OFAxM3Y0aHl1LzNNL0JiMXhuRGoxeW1EK3VR?=
 =?utf-8?B?aUlmTzNuSGl1aW0vVjhpQWJiWU9UVy81Vm56QW1TQ2dJN1BEUG5rK1c0N2RW?=
 =?utf-8?B?Q2dFMGVpcFlrQm5pVTZtbno2aXRMR2Fyd0xHa1p5b3Vzc21HNG8ydmc3Mmp4?=
 =?utf-8?B?M0RLUWlpTC8ybDc5TkZPVTRQT0JyNXYxdUptTlhJYm11Y2xYTFdBd3Z4SUZy?=
 =?utf-8?B?TVZDYW5lZnZRSUxGVStUZjZqbzFWbVVLL1l0NXppOXF0eTNKaG1XQXBKUUlT?=
 =?utf-8?B?MU9sVDl3QnhzZ1FCaWo1SlYrSnN6ZE9RYmozTTBWeUN4Ui9KZlk2THlIQk0x?=
 =?utf-8?B?TzB1aE1sNDl0Z3UxL2R4SUl4dlI3ZEQyTDFyQXBMWDN0V21QdGFqV201R2ZT?=
 =?utf-8?B?VnJvYll2SyszeW8weUJRUGpDS2Y5U05lT2VCeSsvZWtKc0ZSaEltMHFFT1lE?=
 =?utf-8?B?Tksrb0dFZWhINGM0NnRaWVY0K0Q4YklvQzNXeUc0R0VPNDREOE1FdmhkeXJW?=
 =?utf-8?B?YmtzMFp3QmhBMml5RzJqK0JqL3V4cHBGUFpFS1R3aWRNZDVHRmEyZHhNSUZZ?=
 =?utf-8?B?dG1qaVNQV3c1RTAzcWdTOFRmenBPbGVGY2RVc1NkTHNDWHl6TElVT1ZvMGJs?=
 =?utf-8?B?QXlvaVlxaVE3NmViaUlIU0hHYzgrYnVNWFEzT3MwNnI1U0pxWTNRUVNkSUVY?=
 =?utf-8?B?b2g5WmRUV1RIY0tyTnp6ci9XTmJtN1l3SWlyQjVsblVFaHJQSXFCSmptY1Vt?=
 =?utf-8?B?RG05Rmcxa1pvRWtKMDRwSXRvUDVOQi9GWFBFNVBsbHRYTU9JblV6MXZPSU8w?=
 =?utf-8?B?N2UxQm8yNWI5cDFGbEp4Z2N5LzlCVmdGT01JM3pvWWNKQlNya01MY0laR1o5?=
 =?utf-8?B?UlBoTkdkOGRnZDZsaXV0eVBESkwrbXY1RTZsbkdlYVl2Q1lwekxTSUU5emVD?=
 =?utf-8?B?VWF3NUhOemlhS1U2c0RNK0g0QjBMblZnbDRBWnBKYW0yRUU4WElQK0dyMGJx?=
 =?utf-8?B?VmZtSllDc2VRU3BkSytoS1BQck9EZzlkNEFVLzh4c05welRTZ1I0NFhKWDVW?=
 =?utf-8?B?SmFVdVNhV0wzeXliWTB4R1V2T1NxenRjcE11c2R6d2ZaWDN0VlNwdFF3M2da?=
 =?utf-8?B?TS92TkpKM3VicE5UN0laUmQ2Qy9WaElKeGxzdHZpNDdCZDliQndFb1BxRUlM?=
 =?utf-8?B?SW9EY3d6NXRLUVdONDJVNFNGbjdtUFZOTDBnN0xSNVp2MHdpRTcvMVM1RmtO?=
 =?utf-8?B?ZVpxcGQ5Y3RJOEdkSGN3WElKVHJDT2tHQWg0Sy9LS1plNk1LMWEvajd2MDlw?=
 =?utf-8?B?ZUp5WFNrQmxGOHZ5Ky9vb01BQTl3ZG5nSEJEQU9SQ29UVldYU0VIaVpjYlN5?=
 =?utf-8?B?UU5WT3JuMW9majQ4enJMMzltd2R4cE9MU3BscGdIbXEyQVJyZW51VUViVDgv?=
 =?utf-8?B?SXlFbVdIREJORkowbCtPK3RyWGVHNTFwMDFJVTVMSmFxY3hiZGdpQWFTNXZq?=
 =?utf-8?B?SDVRcFZ4OE5YNG9FMkR6WmxaYnFBK3NmbmZuc0pPSFkxWWluNDZBRUxYdlJW?=
 =?utf-8?B?dXpnN0hhSGlLbTlUZFdsQWRoQ3BiQ1cvdjlWRzkrVUlVQjRsZHZNQnp2U3E2?=
 =?utf-8?B?MERFeS9VbXhuZzNYTHltSGNrcGV6WHNucmgyK09wd0pzbVpGdHhrUkw4Q1pk?=
 =?utf-8?B?dzh5akUzQzE4eEY1ZUVlaG9VcS9rUzkvUzYyYmprUEF0NzdGNGVjalRjQ1Ey?=
 =?utf-8?B?d0YvN0hyc1JtMkNWSUh5N0ptanZRN1NuYXNDcGowaUFrazBVeTVjV1ZDb0xW?=
 =?utf-8?B?SXFLT2Voa3JwdTZBTU9kelN2cjFpcVVIa0cxcXNWQUEyVWJxTXVZeTVGV3h5?=
 =?utf-8?B?KzVFNXBFSVR5eklDblpXQ0VZRGlFWTBjTkxMVG1VRVV4d0NXWlIvcjdveWVN?=
 =?utf-8?B?NzlZRDgrZzB0SXV5YWtQbzRBRXA4ekZiaVJTU2VmNEZ6OGFzYkRuMmxPUVZj?=
 =?utf-8?B?TWQ3TzQxOTZidExlQit4Ykk1MTQ3elB0dlcvTzdkWmNOeGRMMHVzcFplOFZG?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00AFC45D53F2C74F90C2E2AE6FE0FA5C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GJwxduFeZrzOb9PoEP9JyI8f6eauaWJNw/Bo6FQN5uYX5OQOusmn/nT1bzBIasQf35eDCYE0as6LprOlMRjB/xRrC/OsrY/l1+ca8L+7mTSOzJ3OsLPG/gzqGGk6oUKv2RCtSe5vReqm412U3epnlE1yuRzEIMYVf6ccYCU9dfaTxI7WE7DklWBfZYBo9smHG8qoEONN1u7WJECqO3A3jQqnMknBvZNM8uOhVT0V5ZWqrnJmPs4BVUUyVU/UCWx7hr61BGDJQ58N3K99WyX1e+AGZI+w8Pf3tut/PBCAQ41GTezIdlYbsSgMAI3O3hVxcsxDfm/mrg5bkDb4hB3m1fcwjIUk+/F6QTgCyaxUJ4bgaDDfTV1yMvgxQWt3scFNKi4v9CRFRns7hcXuXUhkxlVAApoCW5UFH+TctKYZ3XaQ9YwhLH2WcbAy2TEjyRPFakouMfqQ+s3qQax/h54I8gQPZYen/ll0bETTehCfjEneDSMj6Cc+7onJ0YRZvFRxinEs4Cej4Ed0nIIAW7gfsKOoFUeUdHaRzqQOj6VvHLH9vHDoZLQjvdQXyFXpyssp87uoWrsVJzV9uMHrXnJxKUBLqd1cv3bq5tec2YbqFsrSJhkkBm3I5Mzm9pHHwmly
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ab752c-8f99-4de0-552e-08ddb31b3e4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 12:32:54.7314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ua8Qf7iAcB7D5/vhI5iGbnOg6978ZAKAVVcKWAVqUOQ9eh97SdLbyt2S6LpHKglCeVKGCHnpW+G1TeD//hCn1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7835

T24gVHVlIEp1biAyNCwgMjAyNSBhdCA2OjM3IFBNIEpTVCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdy
b3RlOg0KPiBGcm9tOiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMu
Y29tPg0KPg0KPiBMb2Nrc3RhdCBhbmFseXNpcyBvZiBiZW5jaG1hcmsgd29ya2xvYWRzIHNob3dz
IGEgdmVyeSBoaWdoIGNvbnRlbnRpb24gb24NCj4gcmVsb2NhdGlvbl9iZ19sb2NrLiBCdXQgdGhl
IGxvY2sgb25seSBwcm90ZWN0cyBhIHNpbmdsZSBmaWVsZCBpbg0KPiAnc3RydWN0IGJ0cmZzX2Zz
X2luZm8nLCBuYW1lbHkgJ3U2NCBkYXRhX3JlbG9jX2JnJy4NCj4NCj4gVXNlIFJFQURfT05DRSgp
L1dSSVRFX09OQ0UoKSB0byBhY2Nlc3MgJ2J0cmZzX2ZzX2luZm86OmRhdGFfcmVsb2NfYmcnLg0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGly
bkB3ZGMuY29tPg0KPiAtLS0NCj4gIGZzL2J0cmZzL2Rpc2staW8uYyAgICAgfCAgMSAtDQo+ICBm
cy9idHJmcy9leHRlbnQtdHJlZS5jIHwgMzQgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiAgZnMvYnRyZnMvZnMuaCAgICAgICAgICB8ICA2ICstLS0tLQ0KPiAgZnMvYnRyZnMv
em9uZWQuYyAgICAgICB8IDEwICsrKystLS0tLS0NCj4gIDQgZmlsZXMgY2hhbmdlZCwgMTcgaW5z
ZXJ0aW9ucygrKSwgMzQgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9mcy9idHJmcy9k
aXNrLWlvLmMgYi9mcy9idHJmcy9kaXNrLWlvLmMNCj4gaW5kZXggZWUzY2RkNzAzNWNjLi4yNDg5
NjMyMjM3NmQgMTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL2Rpc2staW8uYw0KPiArKysgYi9mcy9i
dHJmcy9kaXNrLWlvLmMNCj4gQEAgLTI3OTEsNyArMjc5MSw2IEBAIHZvaWQgYnRyZnNfaW5pdF9m
c19pbmZvKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvKQ0KPiAgCXNwaW5fbG9ja19pbml0
KCZmc19pbmZvLT51bnVzZWRfYmdzX2xvY2spOw0KPiAgCXNwaW5fbG9ja19pbml0KCZmc19pbmZv
LT50cmVlbG9nX2JnX2xvY2spOw0KPiAgCXNwaW5fbG9ja19pbml0KCZmc19pbmZvLT56b25lX2Fj
dGl2ZV9iZ3NfbG9jayk7DQo+IC0Jc3Bpbl9sb2NrX2luaXQoJmZzX2luZm8tPnJlbG9jYXRpb25f
YmdfbG9jayk7DQo+ICAJcndsb2NrX2luaXQoJmZzX2luZm8tPnRyZWVfbW9kX2xvZ19sb2NrKTsN
Cj4gIAlyd2xvY2tfaW5pdCgmZnNfaW5mby0+Z2xvYmFsX3Jvb3RfbG9jayk7DQo+ICAJbXV0ZXhf
aW5pdCgmZnNfaW5mby0+dW51c2VkX2JnX3VucGluX211dGV4KTsNCj4gZGlmZiAtLWdpdCBhL2Zz
L2J0cmZzL2V4dGVudC10cmVlLmMgYi9mcy9idHJmcy9leHRlbnQtdHJlZS5jDQo+IGluZGV4IDEw
ZjUwYzcyNTMxMy4uODBjZWNhODlhOWVmIDEwMDY0NA0KPiAtLS0gYS9mcy9idHJmcy9leHRlbnQt
dHJlZS5jDQo+ICsrKyBiL2ZzL2J0cmZzL2V4dGVudC10cmVlLmMNCj4gQEAgLTM4NDIsNyArMzg0
Miw2IEBAIHN0YXRpYyBpbnQgZG9fYWxsb2NhdGlvbl96b25lZChzdHJ1Y3QgYnRyZnNfYmxvY2tf
Z3JvdXAgKmJsb2NrX2dyb3VwLA0KPiAgCXU2NCBhdmFpbDsNCj4gIAl1NjQgYnl0ZW5yID0gYmxv
Y2tfZ3JvdXAtPnN0YXJ0Ow0KPiAgCXU2NCBsb2dfYnl0ZW5yOw0KPiAtCXU2NCBkYXRhX3JlbG9j
X2J5dGVucjsNCj4gIAlpbnQgcmV0ID0gMDsNCj4gIAlib29sIHNraXAgPSBmYWxzZTsNCj4gIA0K
PiBAQCAtMzg2NSwxNCArMzg2NCw5IEBAIHN0YXRpYyBpbnQgZG9fYWxsb2NhdGlvbl96b25lZChz
dHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmJsb2NrX2dyb3VwLA0KPiAgCSAqIERvIG5vdCBhbGxv
dyBub24tcmVsb2NhdGlvbiBibG9ja3MgaW4gdGhlIGRlZGljYXRlZCByZWxvY2F0aW9uIGJsb2Nr
DQo+ICAJICogZ3JvdXAsIGFuZCB2aWNlIHZlcnNhLg0KPiAgCSAqLw0KPiAtCXNwaW5fbG9jaygm
ZnNfaW5mby0+cmVsb2NhdGlvbl9iZ19sb2NrKTsNCj4gLQlkYXRhX3JlbG9jX2J5dGVuciA9IGZz
X2luZm8tPmRhdGFfcmVsb2NfYmc7DQo+IC0JaWYgKGRhdGFfcmVsb2NfYnl0ZW5yICYmDQo+IC0J
ICAgICgoZmZlX2N0bC0+Zm9yX2RhdGFfcmVsb2MgJiYgYnl0ZW5yICE9IGRhdGFfcmVsb2NfYnl0
ZW5yKSB8fA0KPiAtCSAgICAgKCFmZmVfY3RsLT5mb3JfZGF0YV9yZWxvYyAmJiBieXRlbnIgPT0g
ZGF0YV9yZWxvY19ieXRlbnIpKSkNCj4gLQkJc2tpcCA9IHRydWU7DQo+IC0Jc3Bpbl91bmxvY2so
JmZzX2luZm8tPnJlbG9jYXRpb25fYmdfbG9jayk7DQo+IC0JaWYgKHNraXApDQo+ICsJaWYgKFJF
QURfT05DRShmc19pbmZvLT5kYXRhX3JlbG9jX2JnKSAmJg0KPiArCSAgICAoKGZmZV9jdGwtPmZv
cl9kYXRhX3JlbG9jICYmIGJ5dGVuciAhPSBSRUFEX09OQ0UoZnNfaW5mby0+ZGF0YV9yZWxvY19i
ZykpIHx8DQo+ICsJICAgICAoIWZmZV9jdGwtPmZvcl9kYXRhX3JlbG9jICYmIGJ5dGVuciA9PSBS
RUFEX09OQ0UoZnNfaW5mby0+ZGF0YV9yZWxvY19iZykpKSkNCj4gIAkJcmV0dXJuIDE7DQo+ICAN
Cj4gIAkvKiBDaGVjayBSTyBhbmQgbm8gc3BhY2UgY2FzZSBiZWZvcmUgdHJ5aW5nIHRvIGFjdGl2
YXRlIGl0ICovDQo+IEBAIC0zODk5LDcgKzM4OTMsNiBAQCBzdGF0aWMgaW50IGRvX2FsbG9jYXRp
b25fem9uZWQoc3RydWN0IGJ0cmZzX2Jsb2NrX2dyb3VwICpibG9ja19ncm91cCwNCj4gIAlzcGlu
X2xvY2soJnNwYWNlX2luZm8tPmxvY2spOw0KPiAgCXNwaW5fbG9jaygmYmxvY2tfZ3JvdXAtPmxv
Y2spOw0KPiAgCXNwaW5fbG9jaygmZnNfaW5mby0+dHJlZWxvZ19iZ19sb2NrKTsNCj4gLQlzcGlu
X2xvY2soJmZzX2luZm8tPnJlbG9jYXRpb25fYmdfbG9jayk7DQo+ICANCj4gIAlpZiAocmV0KQ0K
PiAgCQlnb3RvIG91dDsNCj4gQEAgLTM5MDgsOCArMzkwMSw4IEBAIHN0YXRpYyBpbnQgZG9fYWxs
b2NhdGlvbl96b25lZChzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmJsb2NrX2dyb3VwLA0KPiAg
CSAgICAgICBibG9ja19ncm91cC0+c3RhcnQgPT0gZnNfaW5mby0+dHJlZWxvZ19iZyB8fA0KPiAg
CSAgICAgICBmc19pbmZvLT50cmVlbG9nX2JnID09IDApOw0KPiAgCUFTU0VSVCghZmZlX2N0bC0+
Zm9yX2RhdGFfcmVsb2MgfHwNCj4gLQkgICAgICAgYmxvY2tfZ3JvdXAtPnN0YXJ0ID09IGZzX2lu
Zm8tPmRhdGFfcmVsb2NfYmcgfHwNCj4gLQkgICAgICAgZnNfaW5mby0+ZGF0YV9yZWxvY19iZyA9
PSAwKTsNCj4gKwkgICAgICAgYmxvY2tfZ3JvdXAtPnN0YXJ0ID09IFJFQURfT05DRShmc19pbmZv
LT5kYXRhX3JlbG9jX2JnKSB8fA0KPiArCSAgICAgICBSRUFEX09OQ0UoZnNfaW5mby0+ZGF0YV9y
ZWxvY19iZykgPT0gMCk7DQo+ICANCj4gIAlpZiAoYmxvY2tfZ3JvdXAtPnJvIHx8DQo+ICAJICAg
ICghZmZlX2N0bC0+Zm9yX2RhdGFfcmVsb2MgJiYNCj4gQEAgLTM5MzIsNyArMzkyNSw3IEBAIHN0
YXRpYyBpbnQgZG9fYWxsb2NhdGlvbl96b25lZChzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmJs
b2NrX2dyb3VwLA0KPiAgCSAqIERvIG5vdCBhbGxvdyBjdXJyZW50bHkgdXNlZCBibG9jayBncm91
cCB0byBiZSB0aGUgZGF0YSByZWxvY2F0aW9uDQo+ICAJICogZGVkaWNhdGVkIGJsb2NrIGdyb3Vw
Lg0KPiAgCSAqLw0KPiAtCWlmIChmZmVfY3RsLT5mb3JfZGF0YV9yZWxvYyAmJiAhZnNfaW5mby0+
ZGF0YV9yZWxvY19iZyAmJg0KPiArCWlmIChmZmVfY3RsLT5mb3JfZGF0YV9yZWxvYyAmJiBSRUFE
X09OQ0UoZnNfaW5mby0+ZGF0YV9yZWxvY19iZykgPT0gMCAmJg0KPiAgCSAgICAoYmxvY2tfZ3Jv
dXAtPnVzZWQgfHwgYmxvY2tfZ3JvdXAtPnJlc2VydmVkKSkgew0KPiAgCQlyZXQgPSAxOw0KPiAg
CQlnb3RvIG91dDsNCj4gQEAgLTM5NTcsOCArMzk1MCw4IEBAIHN0YXRpYyBpbnQgZG9fYWxsb2Nh
dGlvbl96b25lZChzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmJsb2NrX2dyb3VwLA0KPiAgCQlm
c19pbmZvLT50cmVlbG9nX2JnID0gYmxvY2tfZ3JvdXAtPnN0YXJ0Ow0KPiAgDQo+ICAJaWYgKGZm
ZV9jdGwtPmZvcl9kYXRhX3JlbG9jKSB7DQo+IC0JCWlmICghZnNfaW5mby0+ZGF0YV9yZWxvY19i
ZykNCj4gLQkJCWZzX2luZm8tPmRhdGFfcmVsb2NfYmcgPSBibG9ja19ncm91cC0+c3RhcnQ7DQo+
ICsJCWlmIChSRUFEX09OQ0UoZnNfaW5mby0+ZGF0YV9yZWxvY19iZykgPT0gMCkNCj4gKwkJCVdS
SVRFX09OQ0UoZnNfaW5mby0+ZGF0YV9yZWxvY19iZywgYmxvY2tfZ3JvdXAtPnN0YXJ0KTsNCg0K
V2hhdCBoYXBwZW5zIHR3byB0aHJlYWRzIHJlYWNoIGhlcmUgYXQgdGhlIHNhbWUgdGltZSBhbmQg
ZWFjaCBoYXMgYQ0KZGlmZmVyZW50IGJsb2NrIGdyb3VwIGxvY2tlZD8gT25lIG9mIHRoZW0gd2ls
bCBnZXQgYW4gdW5leHBlY3RlZCBzdGF0ZS4NCg0KQXBwYXJlbnRseSwgaXQgZG9lcyBub3QgaGFw
cGVuIGJlY2F1c2Ugd2UgaGF2ZSB0aGUgc3BhY2VfaW5mby0+bG9jaw0KYXJvdW5kLCBidXQgcGF0
Y2ggMyB3aWxsIHJlbW92ZSBpdC4uLg0KDQo+ICAJCS8qDQo+ICAJCSAqIERvIG5vdCBhbGxvdyBh
bGxvY2F0aW9ucyBmcm9tIHRoaXMgYmxvY2sgZ3JvdXAsIHVubGVzcyBpdCBpcw0KPiAgCQkgKiBm
b3IgZGF0YSByZWxvY2F0aW9uLiBDb21wYXJlZCB0byBpbmNyZWFzaW5nIHRoZSAtPnJvLCBzZXR0
aW5nDQo+IEBAIC0zOTk0LDggKzM5ODcsNyBAQCBzdGF0aWMgaW50IGRvX2FsbG9jYXRpb25fem9u
ZWQoc3RydWN0IGJ0cmZzX2Jsb2NrX2dyb3VwICpibG9ja19ncm91cCwNCj4gIAlpZiAocmV0ICYm
IGZmZV9jdGwtPmZvcl90cmVlbG9nKQ0KPiAgCQlmc19pbmZvLT50cmVlbG9nX2JnID0gMDsNCj4g
IAlpZiAocmV0ICYmIGZmZV9jdGwtPmZvcl9kYXRhX3JlbG9jKQ0KPiAtCQlmc19pbmZvLT5kYXRh
X3JlbG9jX2JnID0gMDsNCj4gLQlzcGluX3VubG9jaygmZnNfaW5mby0+cmVsb2NhdGlvbl9iZ19s
b2NrKTsNCj4gKwkJV1JJVEVfT05DRShmc19pbmZvLT5kYXRhX3JlbG9jX2JnLCAwKTsNCj4gIAlz
cGluX3VubG9jaygmZnNfaW5mby0+dHJlZWxvZ19iZ19sb2NrKTsNCj4gIAlzcGluX3VubG9jaygm
YmxvY2tfZ3JvdXAtPmxvY2spOw0KPiAgCXNwaW5fdW5sb2NrKCZzcGFjZV9pbmZvLT5sb2NrKTsN
Cj4gQEAgLTQzMDMsMTEgKzQyOTUsOSBAQCBzdGF0aWMgaW50IHByZXBhcmVfYWxsb2NhdGlvbl96
b25lZChzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywNCj4gIAkJaWYgKGZzX2luZm8tPnRy
ZWVsb2dfYmcpDQo+ICAJCQlmZmVfY3RsLT5oaW50X2J5dGUgPSBmc19pbmZvLT50cmVlbG9nX2Jn
Ow0KPiAgCQlzcGluX3VubG9jaygmZnNfaW5mby0+dHJlZWxvZ19iZ19sb2NrKTsNCj4gLQl9IGVs
c2UgaWYgKGZmZV9jdGwtPmZvcl9kYXRhX3JlbG9jKSB7DQo+IC0JCXNwaW5fbG9jaygmZnNfaW5m
by0+cmVsb2NhdGlvbl9iZ19sb2NrKTsNCj4gLQkJaWYgKGZzX2luZm8tPmRhdGFfcmVsb2NfYmcp
DQo+IC0JCQlmZmVfY3RsLT5oaW50X2J5dGUgPSBmc19pbmZvLT5kYXRhX3JlbG9jX2JnOw0KPiAt
CQlzcGluX3VubG9jaygmZnNfaW5mby0+cmVsb2NhdGlvbl9iZ19sb2NrKTsNCj4gKwl9IGVsc2Ug
aWYgKGZmZV9jdGwtPmZvcl9kYXRhX3JlbG9jICYmDQo+ICsJCSAgIFJFQURfT05DRShmc19pbmZv
LT5kYXRhX3JlbG9jX2JnKSkgew0KPiArCQkJZmZlX2N0bC0+aGludF9ieXRlID0gUkVBRF9PTkNF
KGZzX2luZm8tPmRhdGFfcmVsb2NfYmcpOw0KPiAgCX0gZWxzZSBpZiAoZmZlX2N0bC0+ZmxhZ3Mg
JiBCVFJGU19CTE9DS19HUk9VUF9EQVRBKSB7DQo+ICAJCXN0cnVjdCBidHJmc19ibG9ja19ncm91
cCAqYmxvY2tfZ3JvdXA7DQo+ICANCj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2ZzLmggYi9mcy9i
dHJmcy9mcy5oDQo+IGluZGV4IGIyMzllNGI4NDIxYy4uNTcwZjRiODUwOTZjIDEwMDY0NA0KPiAt
LS0gYS9mcy9idHJmcy9mcy5oDQo+ICsrKyBiL2ZzL2J0cmZzL2ZzLmgNCj4gQEAgLTg0OSwxMSAr
ODQ5LDcgQEAgc3RydWN0IGJ0cmZzX2ZzX2luZm8gew0KPiAgCXNwaW5sb2NrX3QgdHJlZWxvZ19i
Z19sb2NrOw0KPiAgCXU2NCB0cmVlbG9nX2JnOw0KPiAgDQo+IC0JLyoNCj4gLQkgKiBTdGFydCBv
ZiB0aGUgZGVkaWNhdGVkIGRhdGEgcmVsb2NhdGlvbiBibG9jayBncm91cCwgcHJvdGVjdGVkIGJ5
DQo+IC0JICogcmVsb2NhdGlvbl9iZ19sb2NrLg0KPiAtCSAqLw0KPiAtCXNwaW5sb2NrX3QgcmVs
b2NhdGlvbl9iZ19sb2NrOw0KPiArCS8qIFN0YXJ0IG9mIHRoZSBkZWRpY2F0ZWQgZGF0YSByZWxv
Y2F0aW9uIGJsb2NrIGdyb3VwICovDQo+ICAJdTY0IGRhdGFfcmVsb2NfYmc7DQo+ICAJc3RydWN0
IG11dGV4IHpvbmVkX2RhdGFfcmVsb2NfaW9fbG9jazsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZnMv
YnRyZnMvem9uZWQuYyBiL2ZzL2J0cmZzL3pvbmVkLmMNCj4gaW5kZXggYmQ5ODdjOTBhMDVjLi40
MjFhZmRiNmViMzkgMTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL3pvbmVkLmMNCj4gKysrIGIvZnMv
YnRyZnMvem9uZWQuYw0KPiBAQCAtMjQ5NiwxMCArMjQ5Niw4IEBAIHZvaWQgYnRyZnNfY2xlYXJf
ZGF0YV9yZWxvY19iZyhzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmJnKQ0KPiAgew0KPiAgCXN0
cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvID0gYmctPmZzX2luZm87DQo+ICANCj4gLQlzcGlu
X2xvY2soJmZzX2luZm8tPnJlbG9jYXRpb25fYmdfbG9jayk7DQo+IC0JaWYgKGZzX2luZm8tPmRh
dGFfcmVsb2NfYmcgPT0gYmctPnN0YXJ0KQ0KPiAtCQlmc19pbmZvLT5kYXRhX3JlbG9jX2JnID0g
MDsNCj4gLQlzcGluX3VubG9jaygmZnNfaW5mby0+cmVsb2NhdGlvbl9iZ19sb2NrKTsNCj4gKwlp
ZiAoUkVBRF9PTkNFKGZzX2luZm8tPmRhdGFfcmVsb2NfYmcpID09IGJnLT5zdGFydCkNCj4gKwkJ
V1JJVEVfT05DRShmc19pbmZvLT5kYXRhX3JlbG9jX2JnLCAwKTsNCj4gIH0NCj4gIA0KPiAgdm9p
ZCBidHJmc196b25lZF9yZXNlcnZlX2RhdGFfcmVsb2NfYmcoc3RydWN0IGJ0cmZzX2ZzX2luZm8g
KmZzX2luZm8pDQo+IEBAIC0yNTE4LDcgKzI1MTYsNyBAQCB2b2lkIGJ0cmZzX3pvbmVkX3Jlc2Vy
dmVfZGF0YV9yZWxvY19iZyhzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbykNCj4gIAlpZiAo
IWJ0cmZzX2lzX3pvbmVkKGZzX2luZm8pKQ0KPiAgCQlyZXR1cm47DQo+ICANCj4gLQlpZiAoZnNf
aW5mby0+ZGF0YV9yZWxvY19iZykNCj4gKwlpZiAoUkVBRF9PTkNFKGZzX2luZm8tPmRhdGFfcmVs
b2NfYmcpKQ0KPiAgCQlyZXR1cm47DQo+ICANCj4gIAlpZiAoc2JfcmRvbmx5KGZzX2luZm8tPnNi
KSkNCj4gQEAgLTI1MzksNyArMjUzNyw3IEBAIHZvaWQgYnRyZnNfem9uZWRfcmVzZXJ2ZV9kYXRh
X3JlbG9jX2JnKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvKQ0KPiAgCQkJY29udGludWU7
DQo+ICAJCX0NCj4gIA0KPiAtCQlmc19pbmZvLT5kYXRhX3JlbG9jX2JnID0gYmctPnN0YXJ0Ow0K
PiArCQlXUklURV9PTkNFKGZzX2luZm8tPmRhdGFfcmVsb2NfYmcsIGJnLT5zdGFydCk7DQo+ICAJ
CXNldF9iaXQoQkxPQ0tfR1JPVVBfRkxBR19aT05FRF9EQVRBX1JFTE9DLCAmYmctPnJ1bnRpbWVf
ZmxhZ3MpOw0KPiAgCQlidHJmc196b25lX2FjdGl2YXRlKGJnKTsNCj4gIA0K

