Return-Path: <linux-btrfs+bounces-14237-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A23EAC3A38
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 08:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2AD1188E937
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 06:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CDC1BE23F;
	Mon, 26 May 2025 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iT5MCPmE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="byG664kG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA479148832
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748242394; cv=fail; b=e4xzEUqCrhGzlqFa+SPn2n5B46+SDvHjDDiImMuNxqCvgq/s8L6EzTELygKqbTnqEA8NuS5ZxB/zRbqGwdWvytYudhUdXh6M813Gywi340obImPFEubSVCAIa0dAWYNzg2rJtf35WG3ESeq9Xt3QlIU5wxLxic3utyTXvGPHi4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748242394; c=relaxed/simple;
	bh=YXLXbK+SBcmLi5QI0R94zqW5H8b2TAsP2k5immjNNuY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DgSEmMD6srhQ1uwrfeSJAseUu9pWpCztyZ6WXguXLiIPlji8tYDxfWj75rwn7PDXS8OSfjU+kOECHOtbuu19SsZYR2RWhBY/CDEXn9f2o39UanL3Jo58MTnelErk8uB0+mlKqghdt62OiASdeaMxYK4/0ahwazKL1r7e4NWESvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iT5MCPmE; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=byG664kG; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748242392; x=1779778392;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YXLXbK+SBcmLi5QI0R94zqW5H8b2TAsP2k5immjNNuY=;
  b=iT5MCPmEI18blZDMZGfM00A0UzeR4UwLUcbvfx5sKed5RhoQUIiwQSEC
   fGRsg8ZMn0EzYxBkJIpVczml/79uJchXow7yqvhDFCBb1e55FbR92uj5L
   M4FII2oNWAXMOzs7NNHkrP8W27I7MKjvUBqSPzqFcFHOO9LS6Q09DfJo7
   6oOwJYLp+zJl2eWoWtnvoExCJ9XIb5dtBguHRR9h2CP+E4eUCz204vRv4
   es3mQWlHF4dnhXmN3xgkuuMNwks6QOLOEJO3RQDofZdUgQYvuN1p8JYoh
   xBheh+60McdgnV5wcvnhEDFo64DpET+5Tk/5aR5g0MScHyGRlviTTAZ0B
   Q==;
X-CSE-ConnectionGUID: T6dEKAs5Qoa9zOB4Z8oHLw==
X-CSE-MsgGUID: 4eAcusUDScChYJHNlmdvEQ==
X-IronPort-AV: E=Sophos;i="6.15,315,1739808000"; 
   d="scan'208";a="82476932"
Received: from mail-bn1nam02on2059.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([40.107.212.59])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2025 14:53:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EL0vYWMUHC7mVm8fylpsAw9+k7yPSsGyi/yyUeDthzR4nd0hKzZAaQ/BtM9vB0uy95qgDjpvRRsfCkqwuNZJ668wXNirblJxOAIlsqkvBVoVmid6XOl5ZItcmrr9F/klxLU0uNIkh7G6Zcz02ddvCrJ4Wy7Gc9aBIvSGMGG/bjopDVK/dufDss4eERYwHmBiZCJL1kdeyI0u1SiYsWwzX6o9AZ9PYqfVmI0yhF2PE4D7+prhmpGU8TqzLWzPwCERB55uD88LjXNOSChMKjKE/UVpPwGmqDa1nWS3Jq7Ba0vqmdn7I3d3j8PC8UmgSvLrrQb6Mh3yDtDdJOI+NRON5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXLXbK+SBcmLi5QI0R94zqW5H8b2TAsP2k5immjNNuY=;
 b=dHTXUVLUNyBdc8Mh9aQwwHwz2pMRngWxaUKAFR9CpDLfdbtdJfSJwWGKDV0yX+84uMHu/UofvhDRUNloP+fRVPE6+Sa36OQ1qY5IMt+W0NDlL43hBaSKeNme4MqTa0cgP5Hs5UyVklCghioiwMafunvKw92aIU+TL3EsGz4M6gMf9z9mCUq1Cf+ZkGViJEFjwUcekDCfQeGIuQ7E4n6jP0ryqF8VYcyckLY1Epqo4xqpluBKDiT30LMUewnPYbTB+ZCMXWlDqEw9ZiocPQJYIdOIEgvS1Bz2qFN8FQyuZEUtwdIJo3u5MwAzZLIko2obnZBE8fzM4M9b51BQadiybQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXLXbK+SBcmLi5QI0R94zqW5H8b2TAsP2k5immjNNuY=;
 b=byG664kGC6rpdSYJ6yH329D2AO0ke6ABgiUT6Lmvys/UXkWgLmh9GXGkbrv9T6I0pcc2kkYGyP7Kg1UZFPUjKMEHeFw8nrxztGWy6Afek29uxEFH3dRGV3HZWmEd0JaXLi9ZZp/JAs+pbZli8KR2Go5pHOntot9bm24KDXFhzZI=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by BY5PR04MB6406.namprd04.prod.outlook.com (2603:10b6:a03:1ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 06:53:03 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 06:53:02 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
CC: Josef Bacik <josef@toxicpanda.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>,
	Filipe Manana <fdmanana@suse.com>, Johannes Thumshirn
	<Johannes.Thumshirn@wdc.com>, Naohiro Aota <Naohiro.Aota@wdc.com>, Damien Le
 Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v5 3/3] btrfs: use buffer xarray for extent buffer
 writeback operations
Thread-Topic: [PATCH v5 3/3] btrfs: use buffer xarray for extent buffer
 writeback operations
Thread-Index: AQHbzdwA5Q9JiujHbkuFJItv9Ly52rPkT1sAgAAqkgA=
Date: Mon, 26 May 2025 06:53:02 +0000
Message-ID: <h7tbeznpfl762xay6d4q72ghjqeqieqrhjvq3vk53oedm27yq2@ksw6k4ggrxwn>
References: <cover.1745851722.git.josef@toxicpanda.com>
 <182a186a376f40b01dea6f4cd3da9ec84b62a088.1745851722.git.josef@toxicpanda.com>
 <dkvtoqqdlx7op3ta57fefmcbcshxsgrlu64mdldlkptzsiuise@xa7ihulvyyrc>
 <97723bdc-828b-47cc-afe4-469b9afd3a22@gmx.com>
In-Reply-To: <97723bdc-828b-47cc-afe4-469b9afd3a22@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|BY5PR04MB6406:EE_
x-ms-office365-filtering-correlation-id: 02fe9d04-1dda-4aca-b31e-08dd9c21f5da
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cU0yd3dMQTFhUld5Z01IcWw3OWc3MzBQQVI1blNCNno1MlFFclU0alJ5MElr?=
 =?utf-8?B?VHpWRUlpbzNCUWVqVllUektTZ2Y5VysyU2s2RGVROTUxWUFlWkpPei9DcENu?=
 =?utf-8?B?UTBnWjBoNC9tOFNKcFUreG1lM290a2h5eTZJejloTHpnS1J5cGdzaldOdzc5?=
 =?utf-8?B?SjYxUU4ycnh4WW1mSzh4SlE4cmNzdmFWcHIveDZJakcwVml5WGU0eGlhYlFh?=
 =?utf-8?B?SkNXRk9LM0FEYjNleTFucDVmZUh2MDNhc3Fsd1Bhd2x3MVBsSVdycmYwUjZH?=
 =?utf-8?B?S0dZSkJBTENMMnpZUWZ4bmwzYjN5aU9WdG9DY1ZPVDFXUGwrVW1PS3l4N3JC?=
 =?utf-8?B?N2tPVGYrZHlISm5lTEQyZU5ZcXpOeWRDS0NwRHp1NXo3Szk4b1cyTlBRTUw4?=
 =?utf-8?B?R1VnaFVsQ3FjOWREK2ZIU2g3WHozd2VLaEl3MzhqeU9OZ1dxZ0ZoWXpIcHI5?=
 =?utf-8?B?N1JoUStNb2VvOTJ4Wk4xVkJyemduNVFManQ3OEhOeWVNSUh4RFhSazNnd2cy?=
 =?utf-8?B?NDF3S2FzZjUzb1RGakc4SlRaNTVuVG9QTnBOSTFybjgwZDBtWWN4cFM5Nmdu?=
 =?utf-8?B?aFdKSWtVanVTRWdCQktZalVDMW9rRjZ5bEJTR3RRRGRTYWowUi94cHppOGxH?=
 =?utf-8?B?bHBHSCtqMVBkTHZVWWtncjEyWUJoaFV5aDgzaWhTVmsrOEkxZXpRRjg2UzJV?=
 =?utf-8?B?Z1BQY2JudHBidHFNK2RQZTZBWWdPUjVqbU9PcElyUXpQRWg3bmtsbVYvVmFq?=
 =?utf-8?B?WmlwMFNiMksvOXBRNHY1cnNFWUtUbTN5Q2VpZUxLWGV5M0dkd1c5bmRYZGo2?=
 =?utf-8?B?alZnVVNybmQxdGFpZm9rbWlodkRHN3hjc3BEekdHRmRQRUlwUnZXdW5HZ0JO?=
 =?utf-8?B?MTFkMWsyVXBZa1k2S1B3Y3VWSWVEYjhReDdKeSs0WjcwRUVDYzdHS295Ukla?=
 =?utf-8?B?OWdxRTV4ZjFvNnNnUUNqbkNLZ1JBSFp6aFVUMmZReEVUZ1ZobFJtTmI3a2RD?=
 =?utf-8?B?WEVGNVZuT2RTZ0R1bVhHNTZtUG1pakVEZU1JY3hLWkFkaWFRQVd6WURkZjQ3?=
 =?utf-8?B?czJGU1E2U1B4c0I2T2ZiYTZUSVl3VEE5emNkL3VHL0I3M1loeDVBZlF1YUNk?=
 =?utf-8?B?anpyTWxEUmxwZlExVSs1ZTZ5cEt5cGh0K1FvS0lLRUdYT0RobGNVY0NNcWZ5?=
 =?utf-8?B?MEpZVUYvVDNGRi9wTk5XT290aDVYQjAxRVhQKzJvSG5Xc3NZUVdWZThxa0ZP?=
 =?utf-8?B?bnFlL0EybXZ1RXZ1Wm1mT2hBL0lQOWMrSTB3MWx1OVpoSFYvOW1oWjBQRE1D?=
 =?utf-8?B?ekFUZ25uemZ6VmR2QkpENCtsOW9JdnVsZE93OE91djJmUitvSUdwYUF1NDNn?=
 =?utf-8?B?QUdIdjFWZzdkY1BacThSbWpnZDdxSVVTS2dpTmZFNCtQWEhNZW9RL0w5ZEVw?=
 =?utf-8?B?ei81c0w2S0p2OE5Hak1XTXhaVHBnUGswQzEyVWdtSEt5bkZObmFxQWRSSEM5?=
 =?utf-8?B?UTY1dUZycDdNOGpUMmtoZGZIWUZSTTYwVWpPSHQ3SWx3WVh2NzRIOGtkdDRy?=
 =?utf-8?B?Wk42SGMyd1RGTE8yd0ZMWlBhMUV5K3ZEVDhLUS8vM0lIcmtsMHBRbUdlSnp3?=
 =?utf-8?B?TFJFdGhGbjBDNldVanlFSWZrSVR4ZVdzYWI4S29mMExVYjBzTlZRY0Y2bjRH?=
 =?utf-8?B?aE1wcU93cFdnQ1ZYZ1hCSmJsTjNYV1pHZ1ZyU3NEUXFQTGtWYlAyOStaVUhT?=
 =?utf-8?B?SXdRZHJyd3pBNlhtODJOQTRmOE5PNzNTcWorRUtmcXJweEdmSzRFdTlCc1hj?=
 =?utf-8?B?c3ZSTlROMUpMT0xNSllzUWxiczFHSkFjbVczaTVhUUhGaWpaL3JEZ29Iay90?=
 =?utf-8?B?WHdNNXI2SWEveWFUbFl1Rk96REVRVTZCTzBVdnhNUi8xV29pZmN4VytPZ2pB?=
 =?utf-8?B?bE9UVlpqd3VWZUFTanh2MzBwTm12QjJCT0s1Wk9BbUg3amVjQ0pqMlRkMTN6?=
 =?utf-8?Q?eTQRQc1zLoiQyhjUyLkgX+r7hweoYk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFM3bjlpUHFWb0FrVStDSVhWZVFpOGwycDJjQzRRdW5kRmxWOWFCK3pGRktu?=
 =?utf-8?B?RVlqZkROZTlzNTZybkcyaVEwT3FKQnhKRFh5NGFjc1JXZ0xKeGcyZ1MrNnZH?=
 =?utf-8?B?dEZpTHJYN3ZlMGdKY2QxdVVyL3RnVnVQbUpzcXhqaUJxdUg1T2MwbGd2QjVs?=
 =?utf-8?B?YlREa2dQZHloQjJmeUNwdFB6KzFWUkdCNngzSHFCZjY2TVB2WHIyZWlPRkFp?=
 =?utf-8?B?NFNlT3ozdmVHNHdxa3B0ckNqMG9Ebm9CUVhHWDNuNmtWOUNIWHVIeEVZTTVB?=
 =?utf-8?B?QzNLVDRtQm5vYkVOaTNNVkhlYWEzRFUxaXpxUkdQZUVpZ1BkL2R0UkVYYWhu?=
 =?utf-8?B?V1VBUWZGdjczdjJJdmZVcUZEMFFLVUxXZDVpRi9qem1oZ1dLekdOMkx1eWlE?=
 =?utf-8?B?WW9JRHVOb1E4dG81ZDl3MkM0L0haS3N6dnZsRVNsQTl0WWp0WStacWZ1dW1h?=
 =?utf-8?B?SUJmMVpEa1gwWEJYcFE2YUNRSEtLL2RlZVVxdzlaTDVNMm4rdXQvaGxQRWRW?=
 =?utf-8?B?OUFsZ3g3dGxJL1loV3pnWG01VitQdGtYSUY4cDU0TXdoTWZzUDFPbFNtN3dZ?=
 =?utf-8?B?NzNZaEZNY05sYnY2OVZxMTFub3ViOFlnZWRoZWdHRzBYaVc3OERYczBQWkVj?=
 =?utf-8?B?NlhoekcrT2RUSjl1NEpHN0p5ZXIvRDZ5UEdlSkV3SFl2LzZoaE0vVkZCMWx5?=
 =?utf-8?B?Z3VUTDlKcjBGK0NnNVQ1L2o3c3NWV3NhbSs2OEVSeEl0N2ZkbkRUN0tpR0RX?=
 =?utf-8?B?bm5iV2w3QVBLQ0hMVDRTd1Qwa2kwOU1zVm1oQWZFREd5Wkhva1JJTEFqMHVq?=
 =?utf-8?B?V1BtcmsvZGRLaTBjeHpEUVhnaXQ2OU1ScFNESmtmT1VBb1pqakNuVmFEUFA2?=
 =?utf-8?B?b25EWG9zRjNPOHJ1QmRkRXh6Rm5vZG41ckI4eGxaY3JqeWJJUXhWR2xzTm0w?=
 =?utf-8?B?RmJyci95T0JSNlRPa2xXUTNhZTNZS0JYSkxySTJ5dE1TcHpqUjRVWGxlOXhK?=
 =?utf-8?B?UGg1ZElmTTNHNE9vV0MvK3hwNEtRL2NnTmZzdGF4Q05rMkdDQ2V2djdPeEgw?=
 =?utf-8?B?S0ZEWUJMdm5kanp1SEZsZ0UraWRBdzlEdGxhbThNcm5uc0taNGhKM1Y1SVlF?=
 =?utf-8?B?V21lcUc5T1BHZ1BFMWFZNWM0RkZyU1Y4Nm1FNnpNQUcyWjNXRjd2NjI5NnFJ?=
 =?utf-8?B?VzBuVUJkZWluRmQrWU5WN0x6ajdQMTd6bzlxUUwzdHAyNnB3K21MWkdXVVU4?=
 =?utf-8?B?ZzBROWNJRzdPUlRNODZqMkFCM1Q0RFY5d1Y0bEJUbFNBQkpFZkNBekNxMllv?=
 =?utf-8?B?RW5TMEc2QitWc0pjQWZKY0xOQTRKS2c0YnprNFZBeCtYdWFXMTdTSzJCNFZp?=
 =?utf-8?B?TXhod2RnWFBFSHRRQlk3YS9tZGVIZllLTzI2Um9vRWQxVDE2cXo5eE94R1Av?=
 =?utf-8?B?Vnl4d3Jad09veVQyZndOYzhsa2VuWXhmTW4xUWFJQXpwWXY0NDlmVWJuMDlm?=
 =?utf-8?B?S2ZoNTNLWlNvUlBPWHg2K29sUUVKOXdMcjJNRzJ5WjF3WGlrdUcwSjlGOXFl?=
 =?utf-8?B?L3ZPRnRYQzlFbTFpbkdBakZjdENRVXUySGJaWk4yeHpoTDJPZkR5YzZLVEZ4?=
 =?utf-8?B?VlpFM2thcWxYaXd0dDBZY2lEdlp5NVBpek5PL3pHWmJ0U09GeDJ2cXBVTHhN?=
 =?utf-8?B?K2o5YkRjZ29KTkJPWmlMMGVHMHAyU01mMURod2thQlJGUHFCR2R4QXg5N1Q2?=
 =?utf-8?B?MG1KemFURkhhR3YyTCtqaEJWYjBXYU5pb0hHbGttY1ZvOVI1cG0vVThiWkwv?=
 =?utf-8?B?UGpEM0FqMUF0ZUVYd0hWY2EyMHpCdXJjVm1CeFgvdXRSRS8xWDkzZThvZCtl?=
 =?utf-8?B?bU1CZHBUUzZFWXBUM1V5Ly9HVUFPMUJydENUV0p0Vkl1Y1FHME9EUFhmT1A4?=
 =?utf-8?B?YU5sNDB6eTRPRWx5aUY0K042MUllbGVWeE0vd3QzeTJ5S1E3TGhodjg0bCs0?=
 =?utf-8?B?Q2RCemNaN2lkZjNqNEZmdEw3THg1Uk85Ui80RlRxVEovVXVlYlBPbkU5aFRa?=
 =?utf-8?B?NGd2cGpZeU9xRVhoM3p5bndpU0pGeXNoQzVnNzIvVWMxTFp5NlRIY2YwcDFU?=
 =?utf-8?B?MTJZY0M0cEVNOGNOMTc5TGhmZWVEVGhvVWhqUnhVVHFFV200dzJmQzE3UHUy?=
 =?utf-8?Q?FCfbD5ctz7/9ClGIBdJEtx0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <442783BE5E616649974C71CB1D85A312@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xmli7TP9w5cq2eYC2jlPvI9zaaN9Z6uIubQPHtA39ezTkrQ602BttS8ltLDKHZ6X/VwAVlHu/YqM78jJ8QBCv/aTKOiAw4FdBBRXhEXGYTcCttxQ0gHNsgokUr+w67UwsjhnkosgzssFFNEKIeXDEeB5msHw3E89U5xhdzrP6ziqD3XcLd5ox4QkVvKCwMxGpfLQ1/ETPqxob6jVcHKelhfHIujMHO+7Fk3+MD5S+RQkj83S9uq/6koXXqOaIQnHc6IoF0tz9lxV3rjF38JoJgka/FptsrsSccaU+kN1AyukWEK1wqqwflYb4rKFvrD2CXZmIcGlLNMhKcH+fXWb0b+Xq0MzUK/Olgj2AGoojHwGbCjxllAh9ckrQSzcuBPG52EkqpTcIQAJr8Is/jhI9Jdz+ST8G76JySiGJzTzLLjWUIPQpfLzK3Ka/73yU/YwjzqMgjc+S1XKE3lIJ79K1gENNXlt/iuLm5u+XjxhRzpXgmKECNX5IPz7vO8ZIGchIlAXSFCh1wnJ9ZD8RSdXA7FXUVHyMi5yb0WTMXrwTYh1lbXacglOq6S85srq141FphaaCuLLdPQfES/93eYAlsiVBcwEYDNDw9n69ZBh6yr3P4qjrPdNO8hOMaqSdcN7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fe9d04-1dda-4aca-b31e-08dd9c21f5da
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2025 06:53:02.8474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 88IBt9ks4OucjEwqYnsPyEkBrrQ+d+BgitbcoVH2sFa/oYOarm5kQ/6QuBnokCzHUUYdk/A/5O8F6u/OMF2v/EXhryPcO4QKJPUqrwbsKdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6406

T24gTWF5IDI2LCAyMDI1IC8gMTM6NTAsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiDlnKgg
MjAyNS81LzI2IDEwOjQ3LCBTaGluaWNoaXJvIEthd2FzYWtpIOWGmemBkzoNCj4gPiBPbiBBcHIg
MjgsIDIwMjUgLyAxMDo1MiwgSm9zZWYgQmFjaWsgd3JvdGU6DQo+ID4gPiBDdXJyZW50bHkgd2Ug
aGF2ZSB0aGlzIHVnbHkgYmFjayBhbmQgZm9ydGggd2l0aCB0aGUgYnRyZWUgd3JpdGViYWNrDQo+
ID4gPiB3aGVyZSB3ZSBmaW5kIHRoZSBmb2xpbywgZmluZCB0aGUgZWIgYXNzb2NpYXRlZCB3aXRo
IHRoYXQgZm9saW8sIGFuZA0KPiA+ID4gdGhlbiBhdHRlbXB0IHRvIHdyaXRlYmFjay4gIFRoaXMg
cmVzdWx0cyBpbiB0d28gZGlmZmVyZW50IHBhdGhzIGZvcg0KPiA+ID4gc3VicGFnZSBlYidzIGFu
ZCA+PSBwYWdlc2l6ZSBlYidzLg0KPiA+ID4gDQo+ID4gPiBDbGVhbiB0aGlzIHVwIGJ5IGFkZGlu
ZyBvdXIgb3duIGluZnJhc3RydWN0dXJlIGFyb3VuZCBsb29raW5nIHVwIHRhZydlZA0KPiA+ID4g
ZWIncyBhbmQgd3JpdGluZyB0aGUgZWIncyBvdXQgZGlyZWN0bHkuICBUaGlzIGFsbG93cyB1cyB0
byB1bmlmeSB0aGUNCj4gPiA+IHN1YnBhZ2UgYW5kID49IHBhZ2VzaXplIElPIHBhdGhzLCByZXN1
bHRpbmcgaW4gYSBtdWNoIGNsZWFuZXIgd3JpdGViYWNrDQo+ID4gPiBwYXRoIGZvciBleHRlbnQg
YnVmZmVycy4NCj4gPiANCj4gPiBbLi4uXQ0KPiA+IA0KPiA+IFdoZW4gSSByYW4gYmxrdGVzdHMg
b24gdGhlIGZvci1uZXh0IGtlcm5lbCB3aXRoIHRoZSB0YWcgbmV4dC0yMDI1MDUyMSwgSQ0KPiA+
IG9ic2VydmVkIHRoZSB0ZXN0IGNhc2UgemRkLzAwOSBmYWlsZWQgd2l0aCByZXBlYXRlZCBXQVJO
cyBhdA0KPiA+IHJlbGVhc2VfZXh0ZW50X2J1ZmZlcigpIFsxXS4NCj4gDQo+IFVuZm9ydHVuYXRl
bHkgdGhhdCdzIGEga25vd24gYnVnLCBmaXhlZCBieSB0aGlzIHBhdGNoOg0KPiANCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYnRyZnMvYjk2NGI5MmY0ODI0NTNjYmQxMjI3NDM5OTVm
ZjIzYWE3MTU4YjJjYi4xNzQ3Njc3Nzc0LmdpdC5qb3NlZkB0b3hpY3BhbmRhLmNvbS8NCj4gDQoN
CkFoLCB0aGFuayB5b3UgZm9yIGxldHRpbmcgbWUga25vdy4gSSBjb25maXJtZWQgdGhhdCB0aGUg
Zml4IGF2b2lkcyB0aGUgZmFpbHVyZQ0Kb24gbXkgdGVzdCBzeXN0ZW0u

