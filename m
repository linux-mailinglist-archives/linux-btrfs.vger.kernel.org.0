Return-Path: <linux-btrfs+bounces-11600-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240A1A3D09F
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 06:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDECB179A5E
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 05:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1D41DED4A;
	Thu, 20 Feb 2025 05:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="djVX8/DP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KPbrAGAl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D668488
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 05:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740028011; cv=fail; b=rpaRYtQ0fMWSiVcGJdCStgmXbBGh+AvvsLdIDUjPSpAI4C0kONkKBOY/PAcBWxWg0MLg0TIVQMRsDSNAB0lHVkD6WYjNu9vJlFK6uyUUzKPBPryxkMfXhsr3Bt85feQlbhRsLa62XolPEnGoN4iBZr2tGp4HbG9aFNZiYRCxp34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740028011; c=relaxed/simple;
	bh=HwLHulz2YtjvP9DiEhuoznkVH1+vgivlEuhonZ4kNOo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nTQJ1zCSpoDg6wG3DBgSi6Ya+EfaXZYLYC5PYWyqgalsFOk2z584wru7qVGyxqZ3YYKNfSY3aXxpMryQfazt1dCubOGqykucgZ2vLnIqqVra0+YLhWMlPHlhoJaNHlf0VvwFUtis0o4j5lexUFzMiwNB0Oz6jRo3c8c3jcxyWb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=djVX8/DP; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=KPbrAGAl; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1740028010; x=1771564010;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=HwLHulz2YtjvP9DiEhuoznkVH1+vgivlEuhonZ4kNOo=;
  b=djVX8/DPhriiJ4FeBK1AnDWJEBhikHQPpFON9BYD5ktc3PP0poizKKA4
   r9HPVcezJhWuLQN7gxtgfjRmCQa/PEhCw/ifOItU5epjwrBb7Z55IrBkX
   Nu8lovy4ujVq12WeEkBMZjTlcA/pXtDd97bMhTZ9mxDS4+09CsiQnJzE0
   RrXQkJuSo+3Vi6prgotYqboIM7ilFWJFI8q+Z0EvF+loDFy88Nd+KxsQh
   iyxsvxbREfht19frtDBsOyqX8/dga9KlIv+29GFwzJcdB3VPuKUmgk1NO
   nsVeRug7JOdmFO5yuFc+r6NKzYiPfD5of64ZpA1vJskypBR6aE4NwjEQT
   A==;
X-CSE-ConnectionGUID: 45BKOc85SUWMNKyCtrsSFA==
X-CSE-MsgGUID: RS+EN++LRquJs9E6ewNu3w==
X-IronPort-AV: E=Sophos;i="6.13,300,1732550400"; 
   d="scan'208";a="38415027"
Received: from mail-bn7nam10lp2047.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.47])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2025 13:06:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kh5i6gGJUspqpXoNYprBjnGp32fMtL74v9k8YBb7Te2OrEbNZgMt9tWuGVe7XWnGeefOKtatQD388rmxaKAG6OqL7ybaEWQwhaXnbDbL5FmXMpZC4jPc260dIPqD5HjUbeeUWjVK40DAFqVUGH+BlURHFDtx5TlKmb75U/5kJM/SjSRpVlaTtiyLZF742xpKjkGiXwDupk7h5pc2yK1mb5ta3leRyKAwh1N+Wqo+KNzR9GIBNvUr2FA9p3SjzKSbYyIMrkBfdHSPmpzzIt3jGLP9Ttc3mSYrAROmH1UHFYhSumNeijHwQ0P41JLwbQZduIj+f/YsYdIv76Y1EZTfFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwLHulz2YtjvP9DiEhuoznkVH1+vgivlEuhonZ4kNOo=;
 b=v9+yuiASFq+a6oekbE7moRngaEZEwi/GrB150R/oJUw2GwENsHoCXpNY7draLk9+vFzzVBBNBY74a2jfotl9imBRLidsie8gV6S/fAVrOIYfm5tSU+UJ1CAm11qoQRlN9oJyG4Pgn9QEExeymj9aJIj/XVvbn/8XGOeEOPvAMCUKre7zG4WS86io4R3w/q/HSthXWMLAnCODzEMTZ4/hgFu6aAmmlz/YocyanmAkCHRpzgxUj6K97pJXolOnMlKZVNpWA07vKKwCp1ZvJi1uVgTeYpnpVUwtEB/aVw6Z1nY5F6DbH52VhALKVU6/StlgBJ0sw+AqzZSOgOUBuPtnrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwLHulz2YtjvP9DiEhuoznkVH1+vgivlEuhonZ4kNOo=;
 b=KPbrAGAl0MzJvQBIZFNLoSrQgqxzspK1RXfIFJh772d26Bu46JpS1ucgqRPSeqCmwsYX5MWs6uWcBSShnpFrHn7WOYBI78gSrqXcbPtq6lhhFlWWG5mFFTbNJGqTITiU4AKFmdkzYMhtQR1NRnm/mjsa2jH0P2huQNpPp0ZK1Lc=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by PH0PR04MB8525.namprd04.prod.outlook.com (2603:10b6:510:298::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 05:06:47 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%3]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 05:06:47 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 12/12] btrfs-progs: zoned: fix alloc_offset calculation
 for partly conventional block groups
Thread-Topic: [PATCH v2 12/12] btrfs-progs: zoned: fix alloc_offset
 calculation for partly conventional block groups
Thread-Index: AQHbgqQLbuSagqNKpEKBqZd0azuQdbNO2ZcAgADLh4A=
Date: Thu, 20 Feb 2025 05:06:47 +0000
Message-ID: <D7X0FZ5OI61C.301HD82VLXS0C@wdc.com>
References: <cover.1739951758.git.naohiro.aota@wdc.com>
 <c6a9d1c664cf8595ac6a2a8acf458cf46c7cce8d.1739951758.git.naohiro.aota@wdc.com>
 <64e99dfc-e2d3-45a4-9216-ff9cd8aa7d7a@wdc.com>
In-Reply-To: <64e99dfc-e2d3-45a4-9216-ff9cd8aa7d7a@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|PH0PR04MB8525:EE_
x-ms-office365-filtering-correlation-id: c709ae98-6f8e-4628-7ff3-08dd516c6056
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NmZIdVVvRDVrN3RGWGt5U21lQ3l2cU54cE9xMDVXa2U0bktRQ3VDUzBvaGtO?=
 =?utf-8?B?VUZYay9CVlhGMUpvQ3VCQ0VQbkpNaitzMGNoRkUrS210MWZtRjJoOStEaDFl?=
 =?utf-8?B?cDQyd2wxTFAzSGgwRHRmdzN3YzVxZ0NwcmlEOURDRlVLSHR1cVp0Zi84Mmcw?=
 =?utf-8?B?RDY1VDhoV08wR0ZoWmhxdURxclBMTWZ1OU5NVjN1NGI5WS9Ra3U2a21sYURF?=
 =?utf-8?B?ZDNmK3pLWnBOajM3UFEyOXFaK3I4RE1zRGFpZm8vcWNXZ3ZuMHZpUHEyYU1G?=
 =?utf-8?B?V3hqbGNUVjRjM1BDTllzd2hwYTZ1NXlmVU4zWXgxU3JvVTRTWjVGRnN3WCt5?=
 =?utf-8?B?QS9FTXpWQ1hLTHk2cWNmcU4xVUJaWThUdFBiYnB0Rlh1YTIxQTdUVXhmZVRD?=
 =?utf-8?B?aGJJWHdybWRvUWhtTEtBZUh4WGYxS2Y4T05EMU9rc3BmYTFMSkFuK0h1SmFK?=
 =?utf-8?B?eDVnTGtTTlVuSllKekhtb1EvK0cwMWNpMnRLbEc1dkxCbDNuSEhDbUNKMmtL?=
 =?utf-8?B?VXlrajZ3NWNJTnExL252M0VrL2JJOWdwVHpaaHR4bnRGZDhzK1pRakxqM0RN?=
 =?utf-8?B?TDQ4ZHpZdjJFazVDOTZFRHVJczk0ZEVsaWI5Z1R3OWZFem5QL1IrSGFBSkVR?=
 =?utf-8?B?enczNVNNMDcxOTlhOElLMHNZMGxHejhYRHExNnJlUDcxZmZNaEdxbllueXE2?=
 =?utf-8?B?a0xKR2srV0x5MzJDWlZvcVY3K0NZSnlIeGdxazNGUjdBaXF4VWJqcDNFK2pT?=
 =?utf-8?B?c2Z0b3dBZDBzUkRZU3dRbTRjcTF0eVE5eWpWQmZyRWh0ODRSRzN5NC9OMVNt?=
 =?utf-8?B?YVgwOEIvcFZrOUJ3b0o1eGVERStTSk5xcktIYmEvQUwyOUdsVjhDZEdnS21l?=
 =?utf-8?B?NmdQUXZvU0NqTExrbTc5MDZYSzVpOUR3UWRVeEI4TzhweTlxWUZCa3F1eGpK?=
 =?utf-8?B?a0RiYm1kcncxM1psNWVzZ1pHRTVxcklFY1JkZWErVWV3eWRGTFJlQXdiT0sr?=
 =?utf-8?B?RXVpOUJJTTlTL29RN0VLcFh4MWJZVm5kNEVESVI2eWU0aWdyZzFrV3Iyc28v?=
 =?utf-8?B?SU15bVM0MXZNazlEa1FaZUZYdU0wQTkxOTVaSUFvWVhtcHp2SVpTRHRYU1lQ?=
 =?utf-8?B?WkMrZGh3bndzZEloNWpWSlJ4VUI3aFBDS2pzQU02emhYbk9uM2ZoKzV3ZkxP?=
 =?utf-8?B?VmZkUW5QdHpEeFgxVkJxQkhHZWN3OXVieUVkQzdvV1FWUEFuZkxQMXkzaVIx?=
 =?utf-8?B?N1NoczZGb3ozbitXRUs4NFRMcjlwQnFuZElTL1JSemoxZW93L3BuUzhJRTgy?=
 =?utf-8?B?Z0RFTjUrYnhDNEIwZEhSODJpTkt5cWNmWDVXTnZBc2tpS1BaSnZPVXhQLzF4?=
 =?utf-8?B?OHFNSUNHM0ZrRHNWOTVRZXQvbkEvc3M5ZGkvTklXeFhnbXl0TWpyWVh3ZXlV?=
 =?utf-8?B?WGlIQ0IwZmpuTTlnemVXWDJUOWRxSlNKWk1aT2NIUEVMenFUckllL1B1RkZ4?=
 =?utf-8?B?d0FsRzNaY1BYUkhFcXhjVi8zdU1XcXlIQTBjWjJwakNKaXlyMHVvbktGSEVU?=
 =?utf-8?B?NFNxUDJrZ1VRK2d6bDZEU243cmZ4U21xQTV2cnNMTWdhaFhHNDg2TDJ2YWFk?=
 =?utf-8?B?bE9KMkZDV0ppYy94Y3p0dUFkOGphWVhMTk96aG9mNUFpMEdrSUVyS280UnpL?=
 =?utf-8?B?eDhLc01PV2tmZnB5MWxubUNoZFdSWjI4VWJaSjBFMjVPaG5NL3BsaVZYNzVJ?=
 =?utf-8?B?UFJlRm1oaXF5cklsOW1xWTdwQTZOZEdiMzdIOWlwK1hFMFNEM1FnKzZTSHk3?=
 =?utf-8?B?Ti9Eb3RBRytXajhWRGFhb2dZQzZpTnU0aytDcWN1OXRDb0xrZ0FDWGxRbnNH?=
 =?utf-8?B?OFhBSWlxdVVsZVhseFAxOWtQNWk0NmdMUFpPUUZhTEhzWmhUOHVTVmZwU21C?=
 =?utf-8?Q?R1nImSoodyhdd9bciQLDegt1a4//dnNK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dStzSWpnOExHeFdiN3UzRnUxdSthOHdFR2tpN09ZMGJzcWQ1THRiaHVCZU5i?=
 =?utf-8?B?UGdobjBLVUZFZXI1QmdHTUNNWTQ1bXUwVktQd3VUUUpzV0dnaGtYK2dKWEpE?=
 =?utf-8?B?MXIxbS9UOGs2UnBSVUljRWtxTG5rNzJTdGo0WHpQemFITS8xb0loVG9xMzN5?=
 =?utf-8?B?ckJFV2I1amNRNmMzMk1kL3cycjBQMjNRaWR3SUE4YXUwZDZnaHBRdkJIdmFs?=
 =?utf-8?B?RDVKanVHemZ1RmFiWHZmTi9KK1MxOVNrYkpvVE04ZnRjYWdqOU93RlhURk1S?=
 =?utf-8?B?bllNUVZJekJ4NG9SRzI5VFhjUEp4UmJFZEdET2dIUXoxVFAzWFNuV0orSDZF?=
 =?utf-8?B?eXh4WUtFMFdVRXpBMDE5aWo2SkQ0UE9UVkJ2NHFFMWZxN0RPUWI2NzNjYlVF?=
 =?utf-8?B?WkxBWGF5LzlSeFJIcFg2bHZpTmViVVUraDV3aFpWem1uQTNzTjJrd3d6S1ll?=
 =?utf-8?B?WlU2ZWdEZTFWbEZxQ2YzRlFlelBxaVl4Qk9WTnVaSXZaYzFBM1VwMDJ3N1h0?=
 =?utf-8?B?aHlCdHhldE5ZTjFEWElnN0c3bGh0NWMxODNTNmlieDZYaFRpTG42RTFpK0Qx?=
 =?utf-8?B?UUpLVGx1OXRCeGhKUUkxVjBhTUsybExsbnp2cU1DQXNpazNGcS9oa0tPdTNG?=
 =?utf-8?B?UHB1MXRtc1JacEx2WnRJTUg2R0RYbEJFaStaM1ROdy82bkp5R05YYXpsOTNX?=
 =?utf-8?B?dDU5bU9oakJUaUFqeXdNNFJEMFV2UXdId0JtandXNElpNDdtR1ZlUGgzVzZL?=
 =?utf-8?B?U2YxRWdlNURWekxRVG9WSDFGQWI3TFI4U0sxUWl0bEYzZ0xZcFlBTXJyRS9w?=
 =?utf-8?B?QXdabU5JOVRHbDF2aTNJbzhjVS9xTWRoQmQxb3A2ZGw4emhPeGpqMHBzWDE5?=
 =?utf-8?B?Q0dnTWNaNXZzWmo0MG9ReFZaenVxQlZ0ZzU2RW9EZnZWaWFFWnNndWZpU0lu?=
 =?utf-8?B?Vk5uVXVQcEwzYUpabTAvYXlNa0NLQzM3bnk1YkRlQitkeFVTOSt4ekFoLzN5?=
 =?utf-8?B?QnpVRHNKMVRMMmVXaEw0TmpvY1B1RUxxcHRreUs1Qm1NVU9QVmxkblNwWlV3?=
 =?utf-8?B?Si9NbXdkSUViaTR2R2hqY05rOHlKK0hYaEZqTEdzVHAycERTVmRIT2VoQ0VG?=
 =?utf-8?B?aWpBZmgrajhBTFdhTHI0ZDF2bG1xeGZFZy9RclY0THRVMk0zS3FncThPNjIr?=
 =?utf-8?B?b3ZZRGtoYS9vUnMvOHhTTjlTcThoRThGUTZRS0JTUzQ5QXJJRlg4dzB5NG0z?=
 =?utf-8?B?eWpBemt1Vzk2VjJaR3hGbFd5dzFzTCtJeGhFdmlRZzU2UTdMV0lKL1F1ZVNo?=
 =?utf-8?B?TFJOUXlWck5vK3czUS9XRGZJNmRoU285TkpERUFKUEVZZjBzYlBhdnZvdG5T?=
 =?utf-8?B?enVtUXRVNDIxRmFITUxGUmJuTkdsKytHbThDOEp5OHFyd3dqdVRtdDBJdW5a?=
 =?utf-8?B?dnRhY2FPNVhmV2ttREQ3WmN1Qmo5eVgxSTBMWUdzcmh4QUh4NjRwVnJNeXdr?=
 =?utf-8?B?SldyUDVKZjBUSm1JdDltcnpUU0RPUC9NcFNZcVhERVNDOWNiS0hjYU04V0FC?=
 =?utf-8?B?OG40c1MvNEhWa1RsaGRYKzN0c0c2bFlWdzBmSGNNUXN2YVpWOWZjWmI2RWhj?=
 =?utf-8?B?QTdHVThoVlJkSUYvbkFOSTRIK21aUXliSE5MWE9OQjk0UGEyNm1pN2lYenJE?=
 =?utf-8?B?bUI1dVNFcnk5dzFrWnRBZ1RQd1kyekVNVCs1blczdjBHVDA1U2NOYlJLVkRM?=
 =?utf-8?B?OUk5T21VQ0pOQzRjTlk5Vi9wanlORS83OHliWnlnelZtOTE4a3NYNThvRm8v?=
 =?utf-8?B?V1d4YVp5THMvQnNXWExleUdnNjBxT1ZxOGJhS3ByRjhTRVJWQ3J2ZWNDNkxj?=
 =?utf-8?B?Ym9HQkFPOUx1cWZUWGVsWkI0djgreStack5TS3ZQM3haekYxVEZEOFR1NE42?=
 =?utf-8?B?UFpEUjMvbDdKZmw5RG1iVTBBbThHUHdzQ2pFYkUwZndGdTRIMThreHlFZVRo?=
 =?utf-8?B?UTkvcDU2S2UyaENmT2JhNWZ6SGt0YkVUbGxUVjZZWnFFdTJmd3ZsMmFzZjZ0?=
 =?utf-8?B?ZjlNMmg0c3dFRzlHRnltUVcwMjVUYjFQUlVRZ1ovUjdwL1IwcVVqWDlmOGJZ?=
 =?utf-8?B?WGYrZkZ6eHB1Y2ZhRjNLSW1UYUtxNmxwN1J1aVdNNW9pengvODdXb0puYVFP?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFA826CA10FDD544A85A524B124273B7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B9RDR6PODVcA0zTNMa/q+dL8AmoX2hxg8Mr/KFBZ6Vcel2PCCzb9kys7soPyYV4GM7Sd2EZkLlUVY4XlZHps4aHKqrKiEih8DHvCFvBylyRsLL3gCSOQAq7IlbZw0k6SoIUO69jx1BSa/iQwXuRl5EqJPg7p9T5X60UqHQ/NZIWhFlzJbbBQuvZFXvMPeIV2GLnP0KhmA3t3alTAl21/K9U4bYDouAneOSJfYE2NVF27WaK2RITNwyri7UZF6s9Pub1+I6CdJrgGeCE5nEEsRKzTlbVOTPXmI6jJwa14p/sStm50ZuhPzTlT74ZIz+zmqzbqF8TcZoSTgff5So91F2qkrM08s1YAfk7/5YE/YM5YqzLrwvBYd1y/x+fmYZSRxsyFpqgzN7TlsCW5zhgqGBlKAdXIncssFrMfCbLZhekDW2mCJn1TDC5heOWMcOEOR2nNPpN8QpA18pYPj3AoFeupwPOEy8t0UV4QwR0wqMp4bOpGz1xg86UsvvRA+tUDlCOyiLxRGfH393bNv58LrXQsySA7zMbq0umOVzAenFDqCO5wYuiVQ8IXdg0CaF4QrwfaRG6yAx1ZIFGiSgqNOi7wasC7eoaFRODeoiQ+wJY4xoiR625+F2XOSOIOlUjV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c709ae98-6f8e-4628-7ff3-08dd516c6056
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 05:06:47.1018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zGQPdPbnOTLKxBfUFmmhGVymCMRHpmB3AH5T7WeQ68mEDKa02EAWR2eut+/2LoHlg1im1TGSV4W3cCvTwaul5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8525

T24gVGh1IEZlYiAyMCwgMjAyNSBhdCAxOjU4IEFNIEpTVCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdy
b3RlOg0KPiBPbiAxOS4wMi4yNSAwOTowMCwgTmFvaGlybyBBb3RhIHdyb3RlOg0KPj4gV2hlbiBv
bmUgb2YgdHdvIHpvbmVzIGNvbXBvc2luZyBhIERVUCBibG9jayBncm91cCBpcyBhIGNvbnZlbnRp
b25hbCB6b25lLCB3ZQ0KPj4gaGF2ZSB0aGUgem9uZV9pbmZvW2ldLT5hbGxvY19vZmZzZXQgPSBX
UF9DT05WRU5USU9OQUwuIFRoYXQgd2lsbCwgb2YgY291cnNlLA0KPj4gbm90IG1hdGNoIHRoZSB3
cml0ZSBwb2ludGVyIG9mIHRoZSBvdGhlciB6b25lLCBhbmQgZmFpbHMgdGhhdCBibG9jayBncm91
cC4NCj4+IA0KPj4gVGhpcyBjb21taXQgc29sdmVzIHRoYXQgaXNzdWUgYnkgcHJvcGVybHkgcmVj
b3ZlcmluZyB0aGUgZW11bGF0ZWQgd3JpdGUgcG9pbnRlcg0KPj4gZnJvbSB0aGUgbGFzdCBhbGxv
Y2F0ZWQgZXh0ZW50LiBUaGUgb2Zmc2V0IGZvciB0aGUgU0lOR0xFLCBEVVAsIGFuZCBSQUlEMSBh
cmUNCj4+IHN0cmFpZ2h0LWZvcndhcmQ6IGl0IGlzIHNhbWUgYXMgdGhlIGVuZCBvZiBsYXN0IGFs
bG9jYXRlZCBleHRlbnQuIFRoZSBSQUlEMCBhbmQNCj4+IFJBSUQxMCBhcmUgYSBiaXQgdHJpY2t5
IHRoYXQgd2UgbmVlZCB0byBkbyB0aGUgbWF0aCBvZiBzdHJpcGluZy4NCj4NCj4gSSB3b25kZXIg
aWYgd2UgbmVlZCB0aGlzIHBhdGNoIG9uIHRoZSBrZXJuZWwgc2lkZSBhcyB3ZWxsLiBDYW4gaGFw
cGVuIA0KPiB0aGVyZSB0b28uDQoNClllcy4gSSdtIGdvaW5nIHRvIGFwcGx5IHRoaXMgb25lIHRv
IGtlcm5lbCBzaWRlIHRvby4=

