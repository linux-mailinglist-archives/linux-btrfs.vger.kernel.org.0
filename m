Return-Path: <linux-btrfs+bounces-11506-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3030BA37BE5
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 08:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0308188BD9D
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 07:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0F41917D7;
	Mon, 17 Feb 2025 07:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EcTfLg95";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dOUeL8ua"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413424C70
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 07:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739776401; cv=fail; b=KM7ga5pk9byzFQ75Szq3p658qqleMhJNTdeBbWph5Qyvs9KbvfSQkVHbvckMYpQLmjz1WRM9Vhc3mPmQ38Ioc49fsN3n+vGm6/up7Sqv2k4MvprR4r8qksrncNqAh6B2bsA5eVkSgb90ugvMkeB43S04Y3UY+VR/t3Q5JzZ7xNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739776401; c=relaxed/simple;
	bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kyKMf1+KFIO7DXIpGlSafCr8OHvZ56HdjErpwcji1UXwcnAYAH0AzSpn0di+0VmOwss9OtLmOu4+rMQff1Djx6dCuiih+MVu/YAIgUZDT43fOhoHEKhpRqI2og1zGoXq8lBG+mFW0v5THUCnGEHDBZhFo/Ueq43l5olpTcjp9dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EcTfLg95; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=dOUeL8ua; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739776399; x=1771312399;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
  b=EcTfLg95rdW6QMcvNZihSBDPCoBCOybGmVi9TsT5Wy0ck5Fkuq5YoIAx
   DHO0GRvDgbYZJRy3NDcSIdZ2gwFN6Bq3R2HzQzuOdG1utWEDaEcmdl3Rr
   eEjUFndSiJJGjhAuifpoem5Ep394uQQM2Htl54e1yjfZ4NY9jp/amPIy3
   G47G89xnLTGPT3CFQKCKqj6aqdo4S2uf61GJWjOvU1R0W/dSensyPwGEM
   stztxyM3ZvF42Fj/7E/ZeUvxR14cpvNKyHCuRFcwyUM838tyJPfuyoxiI
   A47pakZGaFM2BA2JrKaj2qrDGzb2w07ukNEc1ryRUjQJncTxdiArhWcRo
   Q==;
X-CSE-ConnectionGUID: Xule+wW9SemuN2QMKlPtsw==
X-CSE-MsgGUID: zhOktRXESc+T7H0z/4CJQQ==
X-IronPort-AV: E=Sophos;i="6.13,292,1732550400"; 
   d="scan'208";a="38628234"
Received: from mail-southcentralusazlp17011030.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.14.30])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2025 15:13:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMHEwu5F1DljSZ5bMlApentDSitGwQZBfXJYhHLSZrh0FPMG9E/VlcINZ7PdH7laGe46K/6BldC1ON7gkCloH2K0IwjArMFADyEhDP0DWNN7yW9fjKXzFGIVVrfV50mI8FPkstZE+Hp7f5m0T7F6hOibdUgokPV/uc4Mp6PIrP4iFl2H+wBzfGP2bKoXzQBoMMsCoj0YpL4KAPpoV626q9irutJr15Rv+hBDZctWV+M73jkj/ptE2zhpOQWmOQnG8/LyQIxiMYvsbkdRc2hIdn1tKytkzEbQlLIps666/3GXZQA0XzMuKTyxEjRmJx0VSz/hJY/XFET5N8XZIUV0JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
 b=Ytz18KQ3/N4kWzbeuiIJmW3ZaL8XxwPk8MGBt464t6cyQwZHaKo8uHh8vwa4j4Kke82aLcempiFmteZOGnOrC8QyYb1M0Ky85e4rEHHg6u/wmW3oDOKarsRijsOUXvQLiiugS6S2veIBNk+TCXvLI9v39Ec9V5tR/rXSdyFY8rAvJ2DYdWxSd5V8S/9/GtdLtAXIdqS1mb0YqokL6Xafa3p6tPsrZqh1r6l9MPuFOv0d00m05v3xoZoVH2/ys6BOsbrE5tTxkDDjhEOX1xq4U0QO4rmPoflLw1WTqbE9gypmhH5feOCTjxSsl0OQk/zdm+RmSxuf33hqeSseJHjjow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
 b=dOUeL8uaUp7YfKY1zGJKOUjapGl/KKuAb50lRypPpmw4UfY3QL8DmJEihxW3wYfrGNJ/KnVNgFZssAB7zOkP/weZbAI17uJis1rHFFU/4iME9CoRRZvyhsffrms+VRWvXyJZ3Xidpkg4syPBP0DTg7oSEnAGwUcjO58S7NzrQYk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA1PR04MB8517.namprd04.prod.outlook.com (2603:10b6:806:332::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Mon, 17 Feb
 2025 07:13:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 07:13:09 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: docs: add an extra note to btrfs data
 checksum and directIO
Thread-Topic: [PATCH] btrfs-progs: docs: add an extra note to btrfs data
 checksum and directIO
Thread-Index: AQHbgQEaUI/MN86VcU+rpvTeBewvHLNLFMmA
Date: Mon, 17 Feb 2025 07:13:09 +0000
Message-ID: <0d834d45-ba71-4e8c-b686-291c0576db4a@wdc.com>
References:
 <90a1ea4049bbf6d80163aa8116af722280c5d70c.1739771926.git.wqu@suse.com>
In-Reply-To:
 <90a1ea4049bbf6d80163aa8116af722280c5d70c.1739771926.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA1PR04MB8517:EE_
x-ms-office365-filtering-correlation-id: 34c6e15c-db73-45dc-b27e-08dd4f2288cc
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a0hmcno0T1FoMWFKRG5mTmFSaVd4K1FGV2NZVlgxZ25mYzg3aEVCcmxxS0Fk?=
 =?utf-8?B?SFF4cFQxc2hsZzZRbWwwTUVKZi9JMndsOHNzNkhIdDF3M3FISlJWdko0TnVH?=
 =?utf-8?B?V1pBUG5YZ3lwNzJpNXZVN2xOM3Qrc3FpQzhtdjEzb1p3SDBtK295UWJHRjNi?=
 =?utf-8?B?MEducGgzWEJhY1hITWhHV0xJOCtFQUR5cHh3U0ZyTVVxZmtYU1NNaWlzVjRa?=
 =?utf-8?B?ZHp5Tmd4RElxSlIxQWJ5TDhxWnUwaGFkM21XQXZyZjNPWTZvTXR1U00xVjEv?=
 =?utf-8?B?NDJXU2lELzVsZVJRZ1VFSTY2SVFsL3lnVWVSQTlnRDlPbE14Ykp1T3JNQmgy?=
 =?utf-8?B?SkVxdFVwdHFGSTkzOEcxNGRtcjlFbFlYSXdGZUozNFdQcFF3cnRGWk1GaC9D?=
 =?utf-8?B?azdEdzZHNk4xRTVHM0M2bmhnUm8vZlpuTUhMVWF6K2dZd21JTGUrUGh2NGg2?=
 =?utf-8?B?cUx0MHM3d2doZUVJTVZWQUw5VDNFQ0E4TDFpM3RScmw1YWZUMjBHaWxxRnRt?=
 =?utf-8?B?S1VaT20xY0w2azQ2ZDlNQXhvNjNLRnVvRWlocVk1MjBlSjU5UGR6L2R1aXNJ?=
 =?utf-8?B?NHF4d1BSUTFlcUs3Q2hyQU45K0xkRGo4SGNLcnB3Zms0Y3pNNzJHM0w0Mi9o?=
 =?utf-8?B?MS85YUVSZm9mSzNURGo0OVFpNm1EdUVmVTFUZVdmZi9xa1dVejlNeWdrVS9z?=
 =?utf-8?B?d2hFYmdwRHJnVVhWeVBiQzhvRHFWbFM2MDIzMHNkdXozcCtnYmFmNVJlNldm?=
 =?utf-8?B?REdLUE5zNC9DNjJ3czIxRVlkV2crV1JjMkNWZFF0ZHdQYmpENGsxOG14ZENV?=
 =?utf-8?B?WkkwWUh6c0FNRnNxNmt4WWxPWEwyRktFZzlTMTd1UXl6Yyt4WUpML1Z4KzNp?=
 =?utf-8?B?amhoUHFwUTAwaGZsdFR4UmxuZytIeEN5RmlQRW44NlpsdXlDaHpaQmREaUoy?=
 =?utf-8?B?WU4xS1FzZ0ZUdHcrVGtWYUNBZ0tlTUZiNzA2a2J6YnprWHRsWTBXYnNqeUhJ?=
 =?utf-8?B?dDJYYmNCUDZ0QjFGNE9pclN5R204QnJYTUdTcFF4K1ppbWxDVHZIaStuMUFm?=
 =?utf-8?B?VnhHRUZWN0hxWTEyS3ZFbWowTWtzbVRnaGRsWis5ZVZnMXV3NE5Ua3VzTHhv?=
 =?utf-8?B?a1lnbVlkK2dRZ3hnb0lDdkg0dmRvZzRPM3pnWmxLMkNPeTJiWTVZTlJqdE44?=
 =?utf-8?B?V2pwbkdDUGloWHNHcENhbE9QNHZTL0p6MkhYeXRZYXlneDI4YXdnVnN3eS9j?=
 =?utf-8?B?RkpHaEJHSGpwcDJvOWFEYW9XWjV4YTJodGhmOVd6WXQyRzNyR0VmUjQrR0FK?=
 =?utf-8?B?QXVhbkZ5UGZ4eG54UEVjMlBjUXEzNmdvTkZ4YVpUYVBrS3FpOFRKbEdBVi9Z?=
 =?utf-8?B?aWRuLytWK3ZacGliTWRnNndXYjJCZzllYTdIVk1DUTY0L3o5MHlQSTQ0aVhl?=
 =?utf-8?B?M2JHRXE5aVNTK2ZFS3o5bG56UEhwcWJFNVJqRndqbW9uSHo3U0xMSUtLd0sw?=
 =?utf-8?B?U0pjbUlONUREMXNJUUZUTzY2aEkxSW01UlpWaG0rbk1CbjJkV0VlRHFmTXJ4?=
 =?utf-8?B?c1VqcnA5ZzZTbnhqeGZxbEhMRzdmRlYxUVpTbTBMM1FTR3BCWDFBQVd0N2tu?=
 =?utf-8?B?OEFUaFlnY292dVh1UGx3UVBOb0dlSit2dUZGbUR4RXc1L3pJb0R6LzM3bUtw?=
 =?utf-8?B?dEJHS0pUSk1lWC9WVkQ5QUtlNXJRMjYzb0tWMkpHY0VTZXFsTUJLanluclN0?=
 =?utf-8?B?cTBPRzdUdDJUR1pGWm4xaEJSNnJhZG9mYTQ0YW1leXMvdnZpc2l0WVMwbkE1?=
 =?utf-8?B?cjNuYk1YbEJCRTVvRUZUK3dORDR1MFJEOUcxZVBGYUlSS1UyR21lczJkVHdH?=
 =?utf-8?B?czdEdDBpSjh0UTJPbHVkSkRQTytMdXVJNjMxcC9uOE9PZDArcXB4NE1kN2dp?=
 =?utf-8?Q?WcY+8bdMtk7M3uS7/uKEnqqNgLErMBVX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SjNzby94RlhpbFdDbndRU1EvdFdFV1lFblovRDE3ekpldkk1UWpxQndUYTJq?=
 =?utf-8?B?cEsrMXpzSFpDOGVkam9FS1pkMWVkbE43RDV2RVJTMTc2VHlBdDRBbU43SHgy?=
 =?utf-8?B?SlBBcUduUHlKcHBtWUpWY3NxZmxSdkoxVEs5R21aSmxicmhEOC9NS3NNaWNX?=
 =?utf-8?B?RW9GTS9YTUJZMkxpbFlyblZHZXlzNUE1SGhRTU9Ndmp2cC9GUjNFRmdaYlpx?=
 =?utf-8?B?K2JZS2FtTlRVeklpczA5OWpxUTcvR0lhQ1dlR1U2aFA5MFhUVlA2RlRGdTZE?=
 =?utf-8?B?c3Fkbzl1NEVucy9BNmQyb1R1WU1hZFlZTXkyRG8za2V1VXNkZkJydXNYS21Q?=
 =?utf-8?B?RkhrcUJ0L01hWlh6Y3E0UGFtY3FndjlFYUVVTHdiTGQwWkw0a1JVeTNYMC9l?=
 =?utf-8?B?NENuMGdIaVJxejB4TWRhZkRvWmtUWUlRNzM4Sk9MV0o0Z2kyc0VvbWQ4aWxR?=
 =?utf-8?B?QlovU1FydlVmMHpHeTMvNDI4U0xTUzdzNGpLWUhhSkdzZ0p2cWtHMG1IY2o4?=
 =?utf-8?B?dDNwTkYxYWZEMW94MW0zY0xoOGdwWkN3WXJMNHVaVzZYRUQ3cFdtenp5UTli?=
 =?utf-8?B?cXpxSnFHM3ovVVRUSlFPTXdpeExOZUZWSi9LZEtRNGdNbW0rRUlqV2M5cHFW?=
 =?utf-8?B?QjdtbGhEN3F1Y291cGI4amV0UWZKcnNyMlVLSkNlNCt6ZXllVXIvOEJmWWxL?=
 =?utf-8?B?WE9HRmgvVGlyTS9KbDFDZEVmUk4wS1k1YnpvRTI2ZHRPeUYwQ21CeXpzTXBi?=
 =?utf-8?B?OTgxOVpFT1IzOFpSUXptTHhySkhBbUlkcjBnY2dHRnRrN2VyRzdVdHNYVjhR?=
 =?utf-8?B?cmFQQ0h1OTNHNUtGN3IvMjlwSjBLZERaeXJxL0xYUVRRemluNmV3OTZVTUFz?=
 =?utf-8?B?SUJDdTQ4WWsyOFhENlZ6M1Z0UE5iVFNhQnl4Vmd6ZW94dEh3Q0tWVXJTNlRQ?=
 =?utf-8?B?b3ZBd25DMkF6NkU0V1hDZFVJUTBHOEhBWjJUdThDaWR2OC9uTXhUTTBFbVNl?=
 =?utf-8?B?aWd3QVlmcnNjTFkvaU0zblpEZFRQQUJlVUxRZGlJU2dJTnZ3MU1WUktzamNl?=
 =?utf-8?B?V3VqblhZcmxvc2daM2pzdzBaOUpMbnYzQjFCaklza3NwQTMvMnczTGNrWkxP?=
 =?utf-8?B?UmMyZDJhMWtTYWlVZHVua016V0dzOXRjcGdTa0V4dWtPS2MvRzM4b2FHL3BY?=
 =?utf-8?B?dEtvbDBxVWNQQTJ5LzJBOVJhRVNiVVpvY1VnUUhMZkxub0N2YnhhK2FBNUVw?=
 =?utf-8?B?UENUczRFN0hDVHlKbTdxZXpZK2d3SWZEaUxMeW03SnVLV3BoNXVhRW1MT0dX?=
 =?utf-8?B?VGo2Nk9lcmFDWnkvZTFwNkJteCtDcTBmVzhEVFp6UlJnaFc4ZDRkLzU2ekxR?=
 =?utf-8?B?WkhUQXoxMml2ZzJlaXZITktsWVRpWmttKy9RcXBlMTdLd08wVlBBVllpeGZr?=
 =?utf-8?B?aFVUanNXR3BmSXNib2cyaEhIbklFei92K2VIY0J1YUh1U2xSekI5L0I3cXVa?=
 =?utf-8?B?MDNPMUFVZ3FsQkNWZUZZT0pIQ2lHSGdIOVdBS0FHVlkyUkJxSzIzYktuMFdD?=
 =?utf-8?B?Q2dJeGF2UXlzNi9hRmhoRzdvRjdreGtLQmhuVlFGQVhCNXRZbVJNQjQyazBU?=
 =?utf-8?B?T29UNmVvTThwK1ZRVDJjUVVSdDFFWUIzWE9IdFF6NnBLYnYrN1NFKzF1YWFZ?=
 =?utf-8?B?ZjdiVWExbXRUNng4V0Nva3BiVFh0UVZaTWFYMVBva3cxQXVSUERPZG9pR0dy?=
 =?utf-8?B?dDRuZ2Y3YjZybTVaUEd3M2F4UXNVUlZrbVNlK0lYbXQ0N01IT1dqNldzSHBH?=
 =?utf-8?B?WHU0eVZSY3JaY3k0NkhYNENiTzJKNGdHbmluelBxNmtnS004ajZPVnZ3RzdD?=
 =?utf-8?B?QytqMC9WV1IwaXhKMkhRWlJWekVqYS8xV0hWejZvdEVlckZUY0g2MXQ5cGw4?=
 =?utf-8?B?VDhFcG5tTTJSZXRndGV4YW1OY01kTEdvbnFTNVpMQzVYbW55Wnd6WnRDK1RR?=
 =?utf-8?B?d3U3Ulg3V0hYdlMwWDZZb1E4RmorckNBVkpXUUI2dVlzSjBUOTMzQWJRdjJr?=
 =?utf-8?B?Q0NBMGw5bHVxQWZCK2RKSWQwYjdaTk84M3lPdTRkYytwVlMvWm5RQnFObVRv?=
 =?utf-8?B?VmM3VE9PdWtETTlJZHdaTDd3SFBCbXdhT292RjV3blRyTkYycGp1T21jUjZD?=
 =?utf-8?B?NHk5bkdHSE5lYVhhRnBjZ0I4eHA1dU80UEJDZ2hDU21Mb1FZRXNTeHRmSE1W?=
 =?utf-8?B?cURkUVNvZ2t5eUl1RDF2QTJYZk53PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <196C8D26C6DED84D819DA88128908EEA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B/9JgfjpI6nazsQKfzUcEGMHlPw48eu/xCXt6sn+jbLFgpaYdDTDVshmnTdBSoLPgFHPfByGONzlTojlzwmWy5lLme+q9lZp/wHpelLqENLWeGGA4rbrXADtmEhdf2VA4RfGKQSjcrEa0UbeiOjRYKQzxEfn//7fCXorgTxtZLWhHopcGiBntz1jbltGa8ZGD2e8KPoDzGc/8OqW2ju4FXngPArIu3xyFz510zaGxu8H8HlnB2goZ7z8dO76gn1VO9KG0o55aFgMSmIyKRt6XCP1iEFKHPtlnyPRAJC1gYzy31Gs1VEmq2NWDVNu3UocuvHJ7LCZQtAI8SAKCfJhzD6CdFaOy30CBU1xYmceUU5TMChHHrZcefOlrIX/WqOPaO2STRzFSoe8fPLDBeihKXqoWuiwYPzb8xPwrf6l7iW71LsXgtSqbQ0bJnFCSid1rGKjumIWqDfWdoHFMpKsylPClLLhNEA4aqGmxl7xydE9IOPHcmwunTuIs9IgxrM6YGV3KkUvY9tsFS8E2XFNhx1xYKulnCerYaXtldRr8TviDQ+j9F/C9dIkH/USF0ccJgr4aXZ7yJubcDu3/1n/kJ1fnhnGe7Wm1YJqX9x9NKZrPzhZwhpbnMaI5cI4vRBv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c6e15c-db73-45dc-b27e-08dd4f2288cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 07:13:09.8895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zwq+769gRqEjI2B6zGXxFB05ox4lUQAaEjFp4AyeAaMNXUdVaYO7lXj3jiTJj/yUsykxWS/6WG0JudHFp2XQi2PzZSa+tjHLqTabeAkcusk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8517

TG9va3MgZ29vZCB0byBtZSwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFu
bmVzLnRodW1zaGlybkB3ZGMuY29tPg0K

