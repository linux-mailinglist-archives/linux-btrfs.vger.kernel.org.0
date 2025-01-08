Return-Path: <linux-btrfs+bounces-10789-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CBBA05446
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 08:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89EEB188789F
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 07:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAAA1AA1DE;
	Wed,  8 Jan 2025 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XdYZ8gkk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hFdtgI9E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB881A0739
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Jan 2025 07:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736320313; cv=fail; b=TV+YTWVomxc20WQdvacrd6b1k4OWfbRpY3jTB/KRs+DI/xei1H8Lv2YCgcptN7Q7dq66fY4SbBQ4RGUFXm6w2JfjD6xasH3ufSGO0lR2mTGdr/49V6zQh+xUhLy/boAeOmVU4+8J0fFhxi9tlMqTGx3laDfIKvcoWJ/SxEOyBg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736320313; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bWNcAgR/S5adR1p1V0HChf8hJGF5MxsIo32+e/XpXOJMItBV8pTxBwZtxAzz3T7jaKDWWpMCUZ62N/pVg1SyBiESGFtuT9Jbwy+jIwODDn2Z+W4rseiUyZT9uo9i3zkAXoF7uWX1V7S/IQOaqKo7CS2hzDoIi+UMqJNCIcH4fHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XdYZ8gkk; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hFdtgI9E; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736320312; x=1767856312;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=XdYZ8gkkTfm0xuM7xGUa8NtWAWAW/mPoAZu8/FhkrbN3M1zHljs3l89X
   YCAVMgiqCqCqkxxxooxIB4ndWc/ffS/+GyX9+3Aux4oKqSwrbbTeavHGq
   RMYZWlyzscHNwhZLX88UWpYwlqhJ36EY+BAs1/q2djzsuRlxIMU+RpyAi
   ThtK7/pctxJWWxdiNMPR6G5kF+xOGYLE4skN1pFZhy7q+RCQkFO8Fsssr
   ozHro8hEDiab9mcVcgCulCAYlBhA+hr9yKHIh+qcgfBT5bYOxMnhpjl3r
   wDnDs3jdaIS85/pD/iYxyLcU0n4ONGPMedhaotBWE3/ea8wf2k1glP8Do
   Q==;
X-CSE-ConnectionGUID: OhLCZh9VTSeeWIfGW8Cb1Q==
X-CSE-MsgGUID: 5QPUfsxeTfau9yF/Exa8bg==
X-IronPort-AV: E=Sophos;i="6.12,297,1728921600"; 
   d="scan'208";a="35962014"
Received: from mail-eastus2azlp17010023.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.23])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jan 2025 15:11:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIiwpfqQaoyp1L+LBhuw3XViwLFc6nROjwG+GvkHvoi2bRDyKOyLwwZiX/8gFi2IqRaYHlMIVLKrswghcEwGqT2CIjlc8Gjjs73pqiJO6GzPqCCSX3GWh+41z7mbR9bEo1mP8UzineG83ItzXZz10+f55xGV3ezKdp3ekCyyUfOpaLmNg1DNwiyDjewFdxpI1jsMd6iAi0P6qys0xYLW0f22gmh/MX+kuIXLbrpS5U13T4GEZppIKhue2wliBAvU/RPSbynglmvVfUQ0aPtMCUsk4b7NP8oRo93MIquBlBuPlQvsVB6TviKAFc4Pnhpn5uLA3pdt1vQsBbNfupnWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=NyXyuP9LzUwmYpOw9z94PiHy92+PGQyeL0RiSfaSOefJQklRTpJMMnPd3S+IKpljUQkZlP3hdnjMqo4tm44SU7opnn9gjJEnG+X2iwUN8NIxjmA2ZEk41qFMDeuREPe654nkEt+uGJ4ddqNlFpRbSTayDDENcnU0qzFsDQ05cLtL0zZ73Qa9pXCSZNOb3J5zi9ZBrHfGe6ksWFi2z3K5ZADHXh/jY6MtGinvoSN3qFM8YdnB1xp/EBxHNQZLvQqECl46JsoMQSdp5bMKMsfAT/p2ytYT8iujl+BwldHrGLNGzww51RfiWnAw1IqCAo3GXiqYC+dltPQ8lcGXy6kPXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=hFdtgI9Ek6RhkXYPN3Z/tQXq/mm2TPQM5qt2XM7QhIye9o8YdbKnRKojp0POiO8nRBAEjnYjFmypIntJStR9sYJD90cL+oqApqoUIDEDwKtQfkGh3sWQ+C1W0lGruKC95V63x+t4/B7LTM8maxIIqOF5XzXfabdGvrzUoPNqOIc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6333.namprd04.prod.outlook.com (2603:10b6:208:1a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 07:11:43 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8293.020; Wed, 8 Jan 2025
 07:11:43 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Boris Burkov <boris@bur.io>
Subject: Re: [PATCH] btrfs: add the missing error handling inside
 get_canonical_dev_path
Thread-Topic: [PATCH] btrfs: add the missing error handling inside
 get_canonical_dev_path
Thread-Index: AQHbYX+l/3NyGlOej0OxGWGg95PHebMMdiMA
Date: Wed, 8 Jan 2025 07:11:43 +0000
Message-ID: <1f16db05-d7a5-4808-bc91-d7db78049afc@wdc.com>
References:
 <60f37e9b853b0c37f6e1895658bd2500b27a93ad.1736307675.git.wqu@suse.com>
In-Reply-To:
 <60f37e9b853b0c37f6e1895658bd2500b27a93ad.1736307675.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6333:EE_
x-ms-office365-filtering-correlation-id: 15498eea-a99b-4935-0297-08dd2fb3b4a8
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cCtZRFk3T0tWWXU3dkNSQXRxZlUzR1J5c3ZudXh2SngrZ0FkTjM1YXU1NUE4?=
 =?utf-8?B?cUJncmtnT1BLQVZtbmxjVitVM1lUR2tYbm1pbkM0MFE3QzJTeTBuQjF6Nmds?=
 =?utf-8?B?Wjd5SVlpalA2R0FyZHlFUm1SUzRJZnlGUmprVTI0VFc0bE5rVTBHb3hZM1Rt?=
 =?utf-8?B?NDRqcmlPTDdUVGcxbHdTV3IwU1NjZVcxUmFhODRORFpQbEsrSjBOaVIyd1kv?=
 =?utf-8?B?Y3hFQnFUZk8raTVMcVk1QTZOZEpPZTVWVEFFQmpCazNPaUVPb2tQODR5Y3Ri?=
 =?utf-8?B?aUhBMEJsVy84QTdIQzdtaCtQQUxsVzBXbE1FUTkwMUtLTTdwajhsMjRBaDlD?=
 =?utf-8?B?cEM2UElrSFI4TmJzL1cvMWZZeHNDekFMRXpWdUxjQWdCenJQeHRWeUJCcVJF?=
 =?utf-8?B?aXByQnVaQWRJQWdYMGpDV2Qvb2dFVEVmOG9kTFR6NGRYMlh0bUZuY3lIb1Nn?=
 =?utf-8?B?T1h1eUM3anlyZ2xKbkRXYkNZZDN6aUJQNUFKaUVsb0F2NkI3c1FmRW10SDAz?=
 =?utf-8?B?K0FkZUlUUjRzZFFENXZTbGluNG5yZUxpcW5LcXJ6RFJvZDRpTHJkRllGdGVu?=
 =?utf-8?B?ZjA1WUdDejV1dytpQ29DeXhpcjk1Z3RuV2VicWdQWlFkaEtNMGFRNUtldUty?=
 =?utf-8?B?dEFtNTBSc0xKOXBacmtsTWQ2ZnVzV0dQUDNrNFZpc0E2VHRVQnpPMFBWelk2?=
 =?utf-8?B?Q2o3ZlExU2hyOFlJN0tzakJvYVJLb3VmTC9rSEdtWVVHZG0rQUxHMGxxTnhU?=
 =?utf-8?B?QUtyb3l3VTA1a29KaUw0cVdtbEIxdnhlUCtjZGs4WUZVZ3RDUHVCc0ZCTnZ5?=
 =?utf-8?B?RmxtL2p3dVF0ZTk3OUdQbXNZeXZSVG0wbUlXdGpkYnVIUWZaeUJ5a0RUYW11?=
 =?utf-8?B?SGNseEZsZDdnNXhhZTlsZUwrWTV3d3lJeVNLTHlZSVRQYUJIckJuZDZ3SXhN?=
 =?utf-8?B?RDFaMGhrMUJWSmZnUVoxOWcrZW5YQUFSdmI5N1BqdDN3WkROMFVQcmtPbVRI?=
 =?utf-8?B?QkY3QW5BTlF4UTJNTmo1WHdvbUJtVmtCaXY3RVJ3U0ZsMHFuVWtOckdjSm13?=
 =?utf-8?B?eHlUSTJ0dGJBQ0JUWWNwZnhiNnZ2eEdGVlFNYmd1ZlpqdGhFSXNEL3dWeXRp?=
 =?utf-8?B?T3VId0hnTm1ObTA2ajBGSXJxQ0VOQXRVbmxJNnpxRURVbkRodk0yQ1RaNDV1?=
 =?utf-8?B?cC92bnVUZlpZdm5keFdXUjBJU1VCblZJN0pCV2V6Ri9YMEZxcktlVFhmenVv?=
 =?utf-8?B?RmRoRDg5TUsvNmREc3JrTnlpbGpNaXk0Yk5tcWJPODcyaTkrLzFKN1JPWnJl?=
 =?utf-8?B?ZTk5UzZoUk9XeWlJV3dGQVRnNzFVZ3FkUkdVN3BFanVlaDJtYmdwOFErNjZL?=
 =?utf-8?B?T1p6MmhFa3Z1NkJsUC9icW9mandqTFo4TTNRZUJjdG1yTnJlMWVrbVU1YytB?=
 =?utf-8?B?TGRHTmZ4Tnhab2crTjVXQ1JwK1N1WFQzY2lwMHB5S0lPeWpJTWc3RmlVclFH?=
 =?utf-8?B?WHBJYzhybGFkRW1rZ1Rnay85ZHRtcENHRGFOM2wyYlRUY2VVWmp3T3dnWncz?=
 =?utf-8?B?WlV2and2dnA4TnVrSHR3U0lzRjVKL1JZcUxWanYyL0NNcHIraGdwSmR6d2VK?=
 =?utf-8?B?Zmc0QjJtMys4YzErRk9oLzJTMFovTFNYRmJCQUxlKzVOUmtGR3lxMzFQSUhv?=
 =?utf-8?B?WG1qZWxXMmxPMzNLUTh6UWdKMnJWdTBVRVYrUkp6NEl6M3ArdnBXeDhMOUpS?=
 =?utf-8?B?K1BleEc3YUUzbGZua2cySkpvbUp3dGR0UXUzb3JKQ0pQV2MvTTR2YnJ6SVR2?=
 =?utf-8?B?M2RFMjUrdHE5Y21GeG1ZeXVqUHZDUGpOenB4RzFZSVE3elQyeDdJdzhHQS9j?=
 =?utf-8?B?OXkrREo0NldpbmcrNjRsdVhqdE9XamZuSnNJMVJVZHN4OXFTYmRDMFJvVk1T?=
 =?utf-8?Q?RRZlFZNvrM4f22bv/7oNQWczT2kZ6aZG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QjNrWUl3TWY0WmQxMHdJZ1NtWnhMeHFNY283VndiVytkcmIvL2JHTFVGc04v?=
 =?utf-8?B?OSt1ZElxbGZ6QUxSYzgvZmd3NkZvT3dzYzBsL2NCbVExUy9OZTlTZ0M5WjJL?=
 =?utf-8?B?RWVYMTZ4REc1Rlc3ZXNRem1Fa0tNZUs3SUJ3dkpvbit4aFZQS3lKVVliNkJw?=
 =?utf-8?B?YTRTQ1g4eE9VWEIvbHg2dEUySWxCeVg5Y0ZsYnRqTi9vc1Y1Q1FsbjJYWFFC?=
 =?utf-8?B?Q0xaZnEzeU5WSkY1Ky9zZ3I0d1NNR0l2THVoNklaUm5NUXkwVExaanRnMWNN?=
 =?utf-8?B?TXpVWnRPdTRKNXVLTExyV0JUTU5YNlhDaCs2ZUt3djY2OGZWVUpDbGhHU3pG?=
 =?utf-8?B?dTVLUkdnNmFmMHFLY3U0SzFKTmpMTk5tZVpScGdwOG9mUHNVZDlJcWd6a2ow?=
 =?utf-8?B?TzRlUlZtalhBQ0VZK0tnZ2ZjUlhlak1sRDlOREMxSWVOaTlSbnFjMit6Zmw3?=
 =?utf-8?B?OHF5K3R6ZXRkQWJ6OURTaDlla1lXclNlSmxsM0tvc1BUNDFFNG85SmxXRU5E?=
 =?utf-8?B?a0l2bnk2aEVTNmlDbXlXMnp6RnBIcTRiaDRnbGRQaGRRU0lzRzdQcW9RV1No?=
 =?utf-8?B?SHUrdVc4QjF6eDBXZk4vcEs5SjEzSEhXZWZNV1BVczhXWm0zRC94VEdvcmtQ?=
 =?utf-8?B?cDh4L1hZRU12blY2a09qUWtLcEJBUWQyNkdRL1NhQkU5dG1IYTdzRnZ1cTUr?=
 =?utf-8?B?SWRKdFBnQWtlUmtrMk9SaHFhaUgwOHlqSDRseWVOOFptWDdpWnZ3UVV5SXZp?=
 =?utf-8?B?KzVFNmZsYnQzZWNvU3BzdkIwNnZtWDNZbzRRZjlRYThBNG83Zi9QWXVhMUor?=
 =?utf-8?B?eW9NNE4ybGJMbWZMVVQrUHUzNmwwNXNaT1lQd2cwaU51KzdwUEhYam1Lc2JS?=
 =?utf-8?B?MmdOVVduem9WaEN5T2V2QzRKa3NvMUVuYkNoU040TGhJWnJSMnZHNEtvQ2Ja?=
 =?utf-8?B?UlY4V3o2VXRBcmJneERZL1lpMEVYZlRRR3Y1WEVsS1lOMWVTYnRWbzEvdlIy?=
 =?utf-8?B?UGZRVHRKblIvT0YyZDhxOThVRmlFUERDN1NZQzd6R1NFai9KT1FKQ2hXcUFy?=
 =?utf-8?B?NG5LdE5kYmFPTHZIUnRGcjcySDlLeVhPV2RucEN0TEs2MlkzOGJzeDBXSUFZ?=
 =?utf-8?B?Z0FRenZleFpsMG1DcmxnWjQvSmo1bzEwUjhHd05NdEIvc2ozTjhOSUF3RHhv?=
 =?utf-8?B?ZHB5cDRRUllaQ3BmejRBNTl1NGtTbjA2Z1hGM3BaamU5SnRsMGxJY2s5dnRU?=
 =?utf-8?B?VE9SVExsZDdLNWVUZjZMTXQ1bGszKzlmck5OK3hncENsaUJvL2xYbXY0eWJF?=
 =?utf-8?B?d0JJZDRFamJkM004RDF1d1lod1Y0KzBqd1J1NElnYUhYM2pqVVVzVW9UbjI5?=
 =?utf-8?B?Mk96UC9pWXVwOW90TXY0STRGeGtPRnZEYUtuYVZIWWd2djRrZ2dhZUZpTVk4?=
 =?utf-8?B?UVlnWXd5cHhuUHZYRldKRXgwbzV5OEZjQVFWZUZuY3QvZk9YbUxaUXhaV1lM?=
 =?utf-8?B?Wkw4azZNWFlHU1h4YlFOMlZCYnkyajlRZ0FSMUxCMXEyeDVSUm1aL1lsZDhy?=
 =?utf-8?B?Q0pIMTlBeFpCbFBCZmY0eFdMdzBBYnNXUC83QlBESS8zWGRmbWRvTVVjUDFa?=
 =?utf-8?B?dEowQWJoQmV1aEJTWUM1YmFtSW5Rdjl4NWk0S3J1VFU5dlBqMkRnWDJJSlp2?=
 =?utf-8?B?QjVCUGVnZjRsVllDaHFLZ3FEcjRWcFFHVmlvYVJybG5mRnVENHdESHFnd29n?=
 =?utf-8?B?Zkh5QVBReEVLaDhqckdjZzhaQWpCMU9kQ1BjMDljMjVMM0VGcVlQODdYNlRE?=
 =?utf-8?B?SHVuR0Fkd3N2NGxSbVRHeWtjekVzdEtqd2dSRDNOSmpCM3lNTGxHM3VUYzN4?=
 =?utf-8?B?azYvNHliS1J1QXd5bFlQU3ZMQTZnSWlZaXFyc3hzelF2VENRd1hoUGRFZ0o5?=
 =?utf-8?B?aWpydjNtblhTNHNnUWZmcVhPaHFabGo1VUIvaEdzN1dZQzNNMVo2YzhWSUht?=
 =?utf-8?B?dDMvdEdrVFR1VEREaWo5TThJRDREYjBtU0xGdGEvbTRncDRzdStPaXdEYkkz?=
 =?utf-8?B?ZDczZE9pVGh1VUNqT3NXc3hiSndpUTJDK2IxWGRva3JCT2dYZExJTHordkhI?=
 =?utf-8?B?RVl5R0FVV0NZZ1REUXpDSDZWS3E1RnVrQUVrWURNYStIeU5BeGVpN1VJR0U0?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66945BDCC082424D893513890B0BE8F5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7slMXue4ujiUZXagkJI4WAxRaqxTi2E5i/DZSI5oV2jAtby3oTSVrMntuELHOQlen6Bmd2K3GqasEJ2AZwAk2vhIPiUwdnvrOktR/PapOp8Y7dxv6euiSFaAsaFt2r/4IMSw+7Z7kjrXAZAt2UMO13HuiwFsbXrwQ4BYHX3ogJyfH3ALnUxsABMdy1xoUj9lwaKZkSvo7zx1Tt8ZT1BJsNdjwzaFd4cWE6YsucFvdBVh6kZ1KzyK3HMHVsgDvUci6C6vk+wuAzEsUHOVfsL/ua3WFrJkIp7OaeLWunzVVwscmtmF2Lfi9K91sxYWtXUAY10OIZKjNmY2WgjTOgTI5LtjlUYnmNiXNoPhsWGW5NDdAjsldWXEQNb3bSaBv1pJrRsqUICrBeZokD/yfCBlYo5qR1nSneBdiJDNhdwf+76Rb9cbOK0op47FGiHJWuOAAXr/zP5p+VKBZjFXB+hQDaFI1YCKMSptR/e1r4JmmYr3MgcyiwKFx/OjOJ4qVN/mrfoSvSATinJZRf2gbuLcZ2Qo7swXtXm17p3772g53rska/VtFT92uUCoWdlENXx+IAdbmx2eo8FkfiMDMOYjaYpSw8dwqab6UiCmgQFrBuUPcv8Kyoammc2/aLOpmIbM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15498eea-a99b-4935-0297-08dd2fb3b4a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 07:11:43.2932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 87f7atgeFC3WfWSUNv2tE8oFmV/iS4BySqc/4FIiZwAOYKur7NSIAvScZyb8mnH3mirb+LY7odflyF0Nw8G5v8ONHJ5K1a0+o5L8W2CjVkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6333

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

