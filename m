Return-Path: <linux-btrfs+bounces-16611-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8CBB4175E
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Sep 2025 09:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50476169D12
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Sep 2025 07:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F002E2EE5;
	Wed,  3 Sep 2025 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JXkO4Sup";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XJ+faJTT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19172E2DD0
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Sep 2025 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886179; cv=fail; b=e7K/Eem5LVeNkLjglBQC5kYnM36qPn8cupaz9bmLwAto3vcJGdxZbSPVQL6h5gJbEs3R5Wp+LEyMUPG2GoyLHEcUUfhnz/57zZaatBRBDSEz8BBEoBgKmXpQbR6TnU3Wu5TIoF1P5WBH9kIGkXdsuTtLlYldqokT9Yii1a1FRco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886179; c=relaxed/simple;
	bh=ha4A8j8vCK7RRZBtQ4/nEq5ij0WsH25svcCT3qSp8ic=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rSo3xJVoMh1/yvnhtKmGMDTzSkt5ZvmTUrDOFRPalxwtnFFOAeyTl4TJgdf7pBv74KojaVxD0UsxQsWkmXmH/OTlxCPu+zAhAUe1s/CW9M6058qMCTZgtQ+bO16clpOaEtU2WVoDZhucyCAV1avFcJ1Td/qS6L+9A2ysqRdsvGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JXkO4Sup; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XJ+faJTT; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756886177; x=1788422177;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=ha4A8j8vCK7RRZBtQ4/nEq5ij0WsH25svcCT3qSp8ic=;
  b=JXkO4Sup3YJhU2z7Ssd+7PjCeINZ4/yqwiBxbGuC9loi8/d3WSG46E3X
   OoNhRmprwOn3845cgK8VQPwxVxHgumtOqJN6FanegQacmf5H3nVkYUQua
   HO5MqpFspp/gOmw+00VYu8JNkN14gKIYV5LyqzdpPvRqMMEN54sVRGznK
   7hFluMbCBohzILxnX2vn8QXY4qjL3GqJPYjaCW++/C60VXG3gxQooh9xy
   7KdBhgYLvlaRs/fqrgI1mAuSx4dQtThQX58iuFGofKWrxaRGv8fHZuei7
   T7G81c2I3ABp7EzBwHOX+/jBg8Jlvp3w9lBbcqcSN5zH3xGQDAKEyo5Q4
   g==;
X-CSE-ConnectionGUID: YX3zkXUgSHGluKF8yoDu6A==
X-CSE-MsgGUID: PaEaqr1cTI6seWRtEufG2Q==
X-IronPort-AV: E=Sophos;i="6.18,233,1751212800"; 
   d="scan'208";a="107546143"
Received: from mail-bn7nam10on2085.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([40.107.92.85])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2025 15:56:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoMU3zMKeYpSXejPoX+p7YxZvfZzvhvzGSX7n+dg5feOqh2MYC1uFTCDYRXODPdmNpxzo6ctLJ6y++ZgEen5ondbCqd5DAPi/+age0oIHtiWjbnzLei02bw/gu5Xycb3azkHh3Z5NN9fkEAo9c8YvrLjUW0T8zTpy44Sl9GnFRSLAwUrZ8oO8fuESu+Cik7y09V9THF0Al7lk6E8903i9ab7XP/LJmbtZyU+IWvh0Y32GyM7asGHNY6lW3bEWK839tJ7/NLW2mYnE59r74NpGG5gFwqfxHclNtfFlnCdET2xsOCAHyw6B9QBnqEhGnAtRWUHwpKDZ8UoDDReqxcT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ha4A8j8vCK7RRZBtQ4/nEq5ij0WsH25svcCT3qSp8ic=;
 b=opW5neo2VRGFj9U15udhigJqXFC0S+WY44NKwsVFkaOa93stEEypeWhWyQ5RkcwmiKVpXAwN2B0YsdUEpOvWdRoG2wPWNUXRBp0e7l7ZcS7t36p2Pu8aOUhpHXT3hm+g2OVvwG/GG+VQNi26/SGwTYjvgyVrkFLiisRgGVniAQqdQfgkeyFp2kyKbyF3nbSeUPUGUo30ctK8Q4cJgVtUvhhFYaTGSNHIlvIESxEc+J5gwmAPhs5RulUy/mOIcD7NQLkA/DLqcFd1c3s9oVjGiKiyNewe6v56hSe7XAz2y9MMn/j1PLo7rpu3JTjIX5dj5V45Er8ls70EVoGJpPR7rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha4A8j8vCK7RRZBtQ4/nEq5ij0WsH25svcCT3qSp8ic=;
 b=XJ+faJTTbVSXqkEVieaK+3zxg8vql0A3ThiU/SiC6qOs14smKlhxUmJqJ+2tHrrGctvRcLjjc/sseJArRoB8d4XUVbbSukKZ3EggcB8pOJdLKQhr11FJv1yool79yygfVSPjwjxkVvOG+TPINK3hM+j0hJMsn7If55YHzaZMbFg=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SA2PR04MB7723.namprd04.prod.outlook.com (2603:10b6:806:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 07:56:04 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 07:56:04 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: WenRuo Qu <wqu@suse.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs-progs: tests: check nullb index for the error
 case
Thread-Topic: [PATCH 1/3] btrfs-progs: tests: check nullb index for the error
 case
Thread-Index: AQHcG8JKa1uj/jnueEG8gxFVNCMkyrR/m5iAgAF9R4A=
Date: Wed, 3 Sep 2025 07:56:04 +0000
Message-ID: <DCJ061KCN8B0.34ZV9AZNH7SF5@wdc.com>
References: <20250902042920.4039355-1-naohiro.aota@wdc.com>
 <20250902042920.4039355-2-naohiro.aota@wdc.com>
 <ace116f9-3395-4d40-a8a0-d22ad6756191@suse.com>
In-Reply-To: <ace116f9-3395-4d40-a8a0-d22ad6756191@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SA2PR04MB7723:EE_
x-ms-office365-filtering-correlation-id: 1a6fd907-7f2a-4456-c2ac-08ddeabf5526
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bjBYUmNKS3ZTa1hJSlJsYURLcnFyVDA4bXNURWo1UjhsNUVFSjhESDNoL25V?=
 =?utf-8?B?dnA5b0JhalQvdE84MER4NnpvUjl6VDZTemYyb0s1Mjc0bVA5ZDI1dDhDMlVm?=
 =?utf-8?B?VEdRcXEzNXAyYURnRWJGN0o3WjhXM20rc0lpRzBncjRKazFuT2grZTJsdVQ4?=
 =?utf-8?B?dHRvM2d4NGhHenljRTA1RUNKa3hBZ2xsSVQwd2tWUzJsZ3dDREpjMi8xNWVJ?=
 =?utf-8?B?VmtQN2xNMXpXK1l2YTNHVXhibktpcnNaUTU0VWc4cTdWQk1TVCt1c1NkblJ6?=
 =?utf-8?B?NmVpb2dpMGNQdUF3NlVCMWtVL05wNW54cDJieWwzd3pqUmhhMGtsYnRmRGtp?=
 =?utf-8?B?MGdqSHpXbXNWa3pRekRwcFkrMUhuQ2QrTTFFSFdDUkVyYjNNcndHUDN1SWJP?=
 =?utf-8?B?UkF0ckw3OTFKRkNOelo4WWIzY21rNXBQamFGNDdRdnZPaWg4eHJlK09BOE5a?=
 =?utf-8?B?c01oWWhwKzB6dlhrRmllVkdpM0swUERQRUV6MFB1aHYrODZWV0FOenFuNnZo?=
 =?utf-8?B?Wi84STg4Ky9oNS9maUNyeDVKTjFSd0ZKaGZ4dE92dnVuQ0o2UVg5MEJJVHhD?=
 =?utf-8?B?NjYvcjFSY1N5ZHpsRnpQbm15VnFBcTBpb2lxZm1JaUV1TkVhUG4zL3REcHgy?=
 =?utf-8?B?Y2tINGRmNW56cU1IRVJqVGo3bUwxREFtbXBtNzZJUWlla2dRVzBKdWRwTlg0?=
 =?utf-8?B?U3dRNnJIWGdSUE8wcUJJaENacnhGY1pCYW1BM3hWeGIxeTFwc09JV1dxSy9Q?=
 =?utf-8?B?dTJQbjlqdjB6cGdkSXZvWGRoRG9ac0o0ZzNsUjFwVFhOTEwxUzZFaVVkNndm?=
 =?utf-8?B?eUdmZDU3ZnBtTFExS1hCTnhvSHhicDFEY1Awc1RsQlpJUEtnUmcvWXgwUlBk?=
 =?utf-8?B?Z1hrNHdOaHhCaHk5VDlwUlhZajJlWkcyYjZGa0xWSUJPaHQxVnpYcXpSNmNv?=
 =?utf-8?B?cU42a3FLV1R5aW84eVVJM2liVkFuZE03TCtkVnU5bmxnTzVTMDFPc1hNV3l6?=
 =?utf-8?B?TkthblRuZDhuK0VxVEtwTm5wMTNqM1NuMkZYdTBQU3Vzd1FZZHFiUGZudU9v?=
 =?utf-8?B?YnZTV0FYU0diK2VZdFhvWU83YTVkbmYwQWJja3hmbStnQnhXZ1BHYm92bndt?=
 =?utf-8?B?UURwTVhBdzh0dU1FVzNLQWozMmprSXdYUUNFSnk2WXk1V2M4ajAwSmNqVEJU?=
 =?utf-8?B?S3ZibGVsMEZGejQrRUpBMmJyZm1EaWlHNWlNV3UxdDBFTTZYTVZlVGRIZm9Z?=
 =?utf-8?B?R2R6ZDlQR1gyMGZsWWhoZzM1ejllM1RUUUJ2OUpQQ1pqRWtwZWVKT3poUTFy?=
 =?utf-8?B?NWhIekdVaVM0UmlPcE0zTGtGdVNnUit4bWhQYnJCd0g3UWplSEQyVllZY1lw?=
 =?utf-8?B?Z2IwOVY4VXh0b0ZXRHV4SkhzTXFBY21ya3E5VEY5VGFpTVJkVC9ZdG1QbFVS?=
 =?utf-8?B?aERwRW96ODArUmtia0R6aHZZWlF1TXhvQ2hoWTJzRlB6WnJsUnVGNVJDMGJK?=
 =?utf-8?B?Z09SQS93UFlVM1FPbzJEQW83bloyWTByZisvWWRXS29yaXZzUU5OYlhRcUFh?=
 =?utf-8?B?azZ6L1ZrOW5sK2g0WndUR3NhN0JDQ3Z6L3dJL3ZFZTBFaHU0OTEvNkJ6RFJn?=
 =?utf-8?B?ckxOUUdPb0M5QzhiSnJZUWY2bHJWV1FaSDNTa1dJendLT0c2SnJ1ZWJZVkYw?=
 =?utf-8?B?aldRWitWMFRPSUg0NGVZemtCbkg4ZEpkMzAxSldYNVhrQVJKY3MvaGwzNDJG?=
 =?utf-8?B?aS94MDRZb25PUmVIOG1MRTZHL1JlMkNhYkxjdDBBbzM2cjExbTdQVFVZdU42?=
 =?utf-8?B?NWtHZ3BMYnNSVnR3dmFFQldQWXZDK2JtOW9SOGJlN2dqazR2OTNQRVpXSTFP?=
 =?utf-8?B?U1dnMGJnTnpubWlhekdIS2krbjlDUmxndzczY2FkeXdOUngxMk8vRGZmTzZS?=
 =?utf-8?B?RmpsZ213N3F5b3ZOclIvUjdGaUdtb09NU1dZNk5jVXN1bnNOSGhYcVd2SldP?=
 =?utf-8?Q?krHoN6A6cx7MOqbVXkR7dK2P/t1Ns0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OER2c3ByT2lIeTQvUUJHTkhyMDYxZ3R5NTVYVTJYM2F0M3VxUmxld3ZwcVlG?=
 =?utf-8?B?NVNvZUM0NFNDcEhiRnY2Y0lLUllER3JjODN4cUpPZEFqWmVJdjF6ZFM2cllv?=
 =?utf-8?B?ZEFsSitRbTdyRmQzZWxON2sxVHlwQ1g2UndNZ3dSeEg0Y29RU3hPd3JoZEEw?=
 =?utf-8?B?UkhPMVBUZGtUNW1USVZXcXBwYkFFVkJ4eDhQTXFVMFlMcGt4S2l3Unh0QStH?=
 =?utf-8?B?QVNNRTFXcXZmYy93OHFETlNHRTEvbDFCNzFUbWUwcmRTbFVNYnZZM0szbGw3?=
 =?utf-8?B?R1lvajBSV0d0N0FaazlCUWl0dEJDRnUxaEhYUmd5QUtuK0pMUzVPdW1nS1pq?=
 =?utf-8?B?QzlzL2JlUkRTZ3Q3LzFpTXlVMzdBRWVnRW5lTHltSXpISHlGYTZMR3Z6WnFj?=
 =?utf-8?B?YlNtQ0t6WG5ZcThuUFB1ODY0MUR6YngzMHJ4SHlEdkRwMkQvS2F0RWJ2WDdi?=
 =?utf-8?B?OVJic3BVMzRMazNHSjNPU1pUWDFyQmZWNEpyb3FvNkh3dmFaMHRWK1RzU29F?=
 =?utf-8?B?NmNZOVF6R0MzQlFMWWx4cytZTFJHbGdUNFVmQ25HWnN4d1pjN3BIb1BjMzJN?=
 =?utf-8?B?azlDbHM4UCtac3U4aWlBR3FTME93YkU3QnZ5SEVLL0g4bkJ5UUY2TStNcDQv?=
 =?utf-8?B?Skh3aE4xSkpwK0YzYzNGc2tVUW5FWlo0T2U2WnFFMWVsSHNlQnJYcjE1TFBn?=
 =?utf-8?B?UVFBMXFydGtDaTQvNWxxS3RneGRSaUVFMmszamJsQlhNdEZsNFBlNis2NUdM?=
 =?utf-8?B?NHJBVUFFT1J1M01PKyt0dlM1VDBwWW56MWdSVGU3ZlJoOTVqeEJuemZvanBu?=
 =?utf-8?B?blFMYjN5MUZBeGtqaGZxTEM4WWxHTWxGeTlMVTYxWjNMT1AyTGdBOFExcVhT?=
 =?utf-8?B?Z3gxWkZ0RUcvWGs4T2J2RTRESGF6UTExM0NvNWtwREZtc2J2L1orVG1rd0ZS?=
 =?utf-8?B?dXFreDZJTE9jSGU2anloU0Y3S1NzZ2V4eDB6NmQ1TlpBa2VwdFZzaG1Idm5R?=
 =?utf-8?B?RGZmdVByTEw3U01SbGhJNVFJY0VIb0lVbmNISGZQUitOWnRhWkZzUk0wZVRk?=
 =?utf-8?B?TjV3REFyVWRpaFArRE1HRGxGN1JNZ2pyYW1CQ0RwREhDbHpYTG4vSUFCRDNx?=
 =?utf-8?B?c0lNZ3llcVNkWGtQNmcyelovNGJGYm81dUdCU1ZQcFp4eElsYy9DUjdNVytt?=
 =?utf-8?B?REhmcElHeFFnUnJtOXgzNFdWVlEwVU5CYWZYZ0dzd0k4YnBYZ21XVGhSZlAy?=
 =?utf-8?B?MnFhS1hBY29MQjg4cndjcTEyMzVweUhuRlVZL1hVUmpJZ3owNFdaZjZveEpL?=
 =?utf-8?B?Q2hhTW1KTWNySy9QaGtsUzVlTG12LzF6aGx5bVY3RDVoT011VFYwak14czds?=
 =?utf-8?B?Ry9obDVwZllHdXN2ay8xZ1FIMTF1OXBoR0J6SnkzNzZ2d3FVYmpNTXpxOHFG?=
 =?utf-8?B?RzF2YVhRWTJabHRGbENuZWxvaTFVbEY4NTVyZm1FK0JVSWQxaWtlZzJtcGNZ?=
 =?utf-8?B?VFdJZC9zZi9oMTJ2SkQ1YW5nV2Vra21JYnp4V0JnVWhLd3ZSUXc1UHlSUWZV?=
 =?utf-8?B?bWFhZUVCcXgzZnBHRWsvQnJQMU1OOWNOSFVWTXdCZS9abVZ2ZnBGMUNWc3pz?=
 =?utf-8?B?SUpJUU5ZdVBkYmVPYkhkd0JSSXh2OG9zOXZVbHcrQWVJSVVQTURIZFZocDBx?=
 =?utf-8?B?L0FOOUxXZUVFTlQ0KzVYY3ZuNTB6cHBTNStsVVA3WjRsazZCa3UvMjU4b29H?=
 =?utf-8?B?ZGptUUZDckhsa0NPbXowQVRCem1QcW5EZk10a0pNWElRTXpYN0xncXZFelFw?=
 =?utf-8?B?S1VBMnpyT0lDV05PdzhMQXlhVStvcDA1YkVkaGlMcFE4Q010K2ZWVFdyWHpZ?=
 =?utf-8?B?cHJhQmNRTDZQdEg0U1NRd2FrNVV5UUtjUjRWK2hIWjVJWG96emlqbks2MDlX?=
 =?utf-8?B?ZXYrWXpvNDBYbTRjY1lyQmhNVVBxQnUrdWJqeXhXMjh3Yjc5YSt5MUhVeXFw?=
 =?utf-8?B?UjV1V1ZabjByRXpOZm1pSTI2eC9CcUhZWUN0MlhUN3hRdEt2NVE4NjluemJs?=
 =?utf-8?B?L2g0VTJ6VFp3eHdGMDYwVlk5WmgrM0xZR0NnMXV1Z0QzUlg0NFpuSVdhcGdB?=
 =?utf-8?B?ZXF6LzVwOUR5N3Z2S1J4TUxyNjR0Zjh0QVRhUnVCZXhVT0R0dG1zMjFNSEhC?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E79C0C9BD09F648AE027D34DAB2E3B3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OH2hsgpCl51DDLAWxlr2c1gTJR2kbn4hCVBAdHnLoIu5Xk/JvVqG0AKx8KTBmIzsVkQeuaXS2/YCkmxub5eI3Z7HhDYkmYeV4x2Ei9EANd6uataHgSR+458SgJny4a1MURNHi74j1JdRaTP/y6CN8ky4qDtk3mihi8fqT6omurKD7++NKGyDL1RgBz1e0oVO+ywEXG9hQ+wmDzOVI9ypWcnuCE7O85kf0nZbicgueZQvRoP884170eSTXpefYDxPZ3FW9tcM1K+VeAT2VYVK6/l/vJdGogY8OB+fvFdPCijro430Y4QBxluggrIKLtOS+Zq1VBAJH5GOfn+Sru+cUUCwMLK0X+/+D6YL7r1dqnpAzepdxKOLKSAwaEvzR5IlGcT9f31Gg5ULPpgT8rkBMzurn9h9MRoSMTuZ5gheP2wg06t3yVBw+bwkSmiSDOeggGTKXeLnyuM1uzRQk89BySpu0cAQSweaWs9ge4HONtOWIHwRA7cJwoR/WJRhRTi64uBbobaNkwXai1NhMAJ6xKDcbudxbLy3XENtZcblEdIFOEdCgP0tUq9jkus27FBxlWA20VlkWj5RsS2+UTn7kGE3lmpvow60on8el6dr8++Qb9PYrk4hZz49RSBAE88s
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6fd907-7f2a-4456-c2ac-08ddeabf5526
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 07:56:04.4440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Sl/AhLHt/1+cT0NAt5PFt+xSzoqbbVw5ZVPMg3FQt28bIjg+eiEjIsgMCRk83UWNerTwqjcY/b3P1ux4xxcVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7723

T24gVHVlIFNlcCAyLCAyMDI1IGF0IDY6MTEgUE0gSlNULCBRdSBXZW5ydW8gd3JvdGU6DQo+DQo+
DQo+IOWcqCAyMDI1LzkvMiAxMzo1OSwgTmFvaGlybyBBb3RhIOWGmemBkzoNCj4+ICJfZmluZF9m
cmVlX2luZGV4IiBjYW4gcmV0dXJuICJFUlJPUjogLi4uIi4gQ2hlY2sgdGhlIHJldHVybiB2YWx1
ZSBmb3IgdGhlDQo+PiBjYXNlIGFuZCBmYWlsIHRoZSB0ZXN0Lg0KPj4gDQo+PiBTaWduZWQtb2Zm
LWJ5OiBOYW9oaXJvIEFvdGEgPG5hb2hpcm8uYW90YUB3ZGMuY29tPg0KPj4gLS0tDQo+PiAgIHRl
c3RzL251bGxiIHwgMyArKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0K
Pj4gDQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvbnVsbGIgYi90ZXN0cy9udWxsYg0KPj4gaW5kZXgg
NDU3YWUwZDgzNTRhLi5iZmM1NjQwYzQ0NzAgMTAwNzU1DQo+PiAtLS0gYS90ZXN0cy9udWxsYg0K
Pj4gKysrIGIvdGVzdHMvbnVsbGINCj4+IEBAIC0xNDYsNiArMTQ2LDkgQEAgZmkNCj4+ICAgaWYg
WyAiJENNRCIgPSAnY3JlYXRlJyBdOyB0aGVuDQo+PiAgIAlfY2hlY2tfc2V0dXANCj4+ICAgCWlu
ZGV4PSQoX2ZpbmRfZnJlZV9pbmRleCkNCj4+ICsJaWYgW1sgIiRpbmRleCIgPSBFUlJPUiogXV07
IHRoZW4NCj4+ICsJCV9lcnJvciAiJGluZGV4Ig0KPj4gKwlmaQ0KPg0KPiBJIHRoaW5rIHRoZSBi
aWdnZXIgcHJvYmxlbSBpcyB0aGF0Og0KPg0KPiAtIF9lcnJvcigpIG91dHB1dCBpbnRvIHN0ZG91
dCBpbnN0ZWFkIG9mIHN0ZGVycg0KPg0KPiAtIHRoZSAiZXhpdCAxIiBkb2Vzbid0IGhlbHAgaW4g
dGhpcyBjYXNlDQo+ICAgIEl0IHdpbGwgb25seSBraWxsIHRoZSBjaGlsZCBiYXNoLCBub3QgdGhl
IGNhbGxpbmcgb25lLg0KPg0KPiBTbyBJJ2QgcHJlZmVyIHRvIG1ha2UgX2Vycm9yKCkgdG8gb3V0
cHV0IHRoZSB3YXJuaW5nIHRvIHN0ZGVyciwgc28gdGhhdCANCj4gaW5kZXggd2lsbCBiZSBlbXB0
eSBvbiBlcnJvci4NCg0KQWgsIHllcy4gSXQncyBzYWZlciB0byBkbyBzby4gSSdsbCByZXZpc2Ug
dGhlIHBhdGNoLg0KDQo+DQo+IFRoYW5rcywNCj4gUXUNCj4NCj4+ICAgCW5hbWU9Im51bGxiJGlu
ZGV4Ig0KPj4gICAJIyBzaXplIGluIE1CDQo+PiAgIAlzaXplPSQoX3BhcnNlX2RldmljZV9zaXpl
ICIkQCIpDQo=

