Return-Path: <linux-btrfs+bounces-18574-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005A7C2CF59
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 17:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88604267CD
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 15:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F33333736;
	Mon,  3 Nov 2025 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gNpArqSA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JVdBWPAP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7444D333442;
	Mon,  3 Nov 2025 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181559; cv=fail; b=IbCIvyAUaM6gm5rvwNjd5dUvYmJ2GUBARU3BXEbCcsVL9xNdKq6qMY/xry+WSaYJiAwVKT/ZYTP7sc/4UkhPo9Fwu5RKDJ1k6/z72iEIFBansRJiSubSKhnW/DU93MdWq/RuH+dzgvbxdEA6IKDUGcN/a7VqtHDV8cwpq/XfuX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181559; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dyRVR+I6cEiXkXYxF3i+8ZMCbwE/XKkP8NuOiknN2dy0vy59zvgWN02d14DRtn29NNl86ckQB4yEWlY/Tc74tuWS3meQ65OG5bM44HI4V+cbbsqjeeNFpMEmGhjUoTTLRifN553gBqHJc0+kfJ41sPWzvvG8EWVYr2PBmrpnr4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gNpArqSA; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JVdBWPAP; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762181558; x=1793717558;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=gNpArqSAyq5VtW0FGp5Ejdoo9qJQD41o4vHMSywT04F+aBxwZC3r98+w
   HJybKwOYrRbRTzBzD6xE3EO5BouEat1yQxxKjZC1YcK/8cHHKBtnQxpfi
   06QF8l8lQNp2En1zNuUXnjKSae6+GQSQnqbuJQGI4SwzW6CJAzyd3SFtX
   C8QwiAJ3VDDm1kaq14wbD8CTSLiQLrRBcrKn8lrdTel/U2YP6NrZ7uc69
   cC6caIR9gpSaujJprBhliytJ+ASEygoRgi0iKvMfmssIbbFt5JC/Jh+nu
   9RCF0/K2ec6A/FEvdiCwGPMTXZb7TPVK2+lMiD3rOOQGPPxOmSn9u9BwX
   g==;
X-CSE-ConnectionGUID: nKlyzz84TBKFsZy9pv8JUA==
X-CSE-MsgGUID: hUzBaS16QuG1c5tw3s3n4g==
X-IronPort-AV: E=Sophos;i="6.19,276,1754928000"; 
   d="scan'208";a="135676154"
Received: from mail-northcentralusazon11013009.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.9])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 22:52:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHbcCpjcCu2ZFYAbnDG+15XFgzhFas/Hu+tNckoZVs5FeOqxv8O1N0RIS305m3hLqUivaICWRXpMLnGF3p9h9v1LVB2Q+2lXjqsXykGd400kSR5ZsZM4Im2oKES8ZmTHiBfhQlz3c6P7TgDlixWJkQWjDHeSBR/LeCc81+Ig1lqRTLU/OTKGwjtxjZQKOMTW2kyoXklw57tj5pzibWqnYLUL6iT4B8M6u60FN9H1Dlsa2aSLEjMnNUfm6LUWzMNMNiql7SuXRNN8J3/7YDdChXAmdODg3vH8nEfp1oIlVf20+kK3JFuqIbc+9ICvOynCz0hhypDQ71VBJRWOvOcZhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=ooMnX08kplgUQOnZBzxkDUKlRzJEUsiSgKmUSopJUDF44AufZrQixbmFbFb3jYrcmJOWcNlqX7EaKnxCHP6D6vJtQhNl4vMS91P/Kg8x5QaphwdZ/gLBC6VS62YuRtz13zH8P3UoA1wOroB2mmygwNDWNMhWy27uDJMGjnziqmiAn9S5OKRD7JrSf5tg0+1LOGeiODbkLiRdBhk4hhdmsOsRvdHcj1MCMKdlFHaQE0ME0J6Cg+HwwW0b/D1Rp5wDsDSwtKsiFAPlzTfn/Uc3XeLg7xCZqfOWDuEuY/BSydgMyXjJABk4bc5PEPKQ35iMC/bXMbgiYc/URf04gGL+WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=JVdBWPAP59V8OSlrYZAeSHwY8AvMILa3Vh+79nROUpzaZ4NH/RPvRtpYf9EQC4/Z/ScLrlaxm6xKwqugbhLYh9f7GindnlLf0YhzDAqjplX6rKikTnX7a97gxlzN4DBOkdqNq1XjsQQTYV12AqcFWpliO+LEqguTMtqu00KdTAs=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by CYYPR04MB8812.namprd04.prod.outlook.com (2603:10b6:930:c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 14:52:32 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 14:52:32 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <keith.busch@wdc.com>, hch <hch@lst.de>, "dm-devel@lists.linux.dev"
	<dm-devel@lists.linux.dev>, Mike Snitzer <snitzer@kernel.org>, Mikulas
 Patocka <mpatocka@redhat.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.com>
Subject: Re: [PATCH v2 06/15] block: use zone condition to determine
 conventional zones
Thread-Topic: [PATCH v2 06/15] block: use zone condition to determine
 conventional zones
Thread-Index: AQHcTMb6z+vEeeO41kS3+oSS1+ubBLThCWiA
Date: Mon, 3 Nov 2025 14:52:31 +0000
Message-ID: <4c1e5a50-e63d-4ea5-848f-64c079c3e28c@wdc.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-7-dlemoal@kernel.org>
In-Reply-To: <20251103133123.645038-7-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|CYYPR04MB8812:EE_
x-ms-office365-filtering-correlation-id: 58e4f0d6-73c4-4bd8-8fad-08de1ae89e11
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|19092799006|10070799003|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3dkYXNyT2s0cU9seExOZ1UwSkhRZDNSMDVDMTErSFd2NEFhb0NLSFM3TzE1?=
 =?utf-8?B?bEY2b05xbnJVdUNNMjEyV1AxbFluNTl1Qm40VzBsSGFJOTlxVitKcDk3MEtw?=
 =?utf-8?B?LzZpcWxka1FwRzJwc01QTjVyRDBweTVGdTNTbE9iN3ltWjlUM284SzIrcDBh?=
 =?utf-8?B?cFpTL1FxS0d3Q25INXgrRmtuajQ1d3g4QXRzbTN3cG9xdDdhb3didlZnOWFM?=
 =?utf-8?B?aitOdi9QdGJrZGQzaDRUMVRUNDRpNkkyVXFaTHNsb05PZ0JaQmxyYlpUb3hp?=
 =?utf-8?B?YkgxTStRdnpGUWpJUWdXRm5peG5yZzNSaVo0RSszb09nVGRKbTFOeFhWWjEy?=
 =?utf-8?B?NGVQQnFSS3ZDUXZqYnR4bEVEK3IvZ0ZsZW55ZU9QMEkyTVJURFVtUEx4ejJO?=
 =?utf-8?B?d2tMWXlTUnQrcmJJYXdBQnFkYWNhMVlkWEs1VVZicUFxdWg0d1VuNnBCV2cr?=
 =?utf-8?B?UU5hbXJWNFJvVkRCcndLMGZ0NmY4bE5FdTQ3Tzd5UmNHK3JNb01LMUFpVVY3?=
 =?utf-8?B?YXBjeTVpUWFqeFN6dnR6c1BQMG1xeXJKa1RTZXNvVDFvbHJtdHF3NlZOejlq?=
 =?utf-8?B?MDExc0kvdUYzZXg4QUIxYUd6aFNJdTJZSGJFcnhOVEhoYnluSGVzTlIxU2Ry?=
 =?utf-8?B?anc4eFYxMkpad2RrV0UzazhPOEpRVzgrcWVpOWxiQ0c0LzRpUGhhUUxlUGJ4?=
 =?utf-8?B?SG4veGw4aFF6c0FuNzIza0VDUmt2bkFGd3ZLZHBON0Rtby90U0VxWURqcUto?=
 =?utf-8?B?VjAzekYvQTliT0huT1ZGNGpKZDQ4bzYxWTRvSHBLRzdUUG8zOGwyYk9BQ1ky?=
 =?utf-8?B?SU9pU053NGdWN3JGU1hxV3Fyd1h1OXludlFwQ1E2MlVuU1VQd1FHeUtGdkhG?=
 =?utf-8?B?RWh6Ky9WK3Z5Q3RUZWNyUFd2SnZjbUR1WXhQQUFEbmZldW1raTZuQnJiNmd2?=
 =?utf-8?B?WmdTUHVoKzBOT3lWaXNxWjFoa09ESkM1djg3aUlHQkFuRVZxajBYMHh3TXo2?=
 =?utf-8?B?eEhnYWs1YjV3NlpmbUhDaUdTTGo1Qm1MRFFyLzFyL2V4SDQwTTRCMFVKTXg1?=
 =?utf-8?B?dS9jd09EQnBMYmM5OUJ2YXVheENCaXMvdzJhaDNiL05LR0o5MSt3THBZSWpU?=
 =?utf-8?B?YjBmV1BBcVJJYW00dmQ0QnNHQXJEa25lVmNHanhJZ1hNeURnRWRvbEE2cjRU?=
 =?utf-8?B?OE5ReU5uelFuclNXM1Y4dlhUcUU5UUdYK1drR203WWRuMTVxS3lJZXo5dTBt?=
 =?utf-8?B?K3R2UXdwK0tkbCs0YytJb0MxZDJTQlhqZi9RL3VuUkJtdWxJTk8yRTRhdnRo?=
 =?utf-8?B?YXV5ajNNdUJOSG4xRGdFVlJ4QWJhTFc2ajlvaXUyOUQrWUozeFNIV2VmL3RI?=
 =?utf-8?B?S1BrenM1OFdIZGgrK09rWWlaQW91OXBZV2xLYWNod2FjVEJBa1VobkNma3lG?=
 =?utf-8?B?WXhRb2Z5N3FldzhjNkFSK1lzN1ZqS2NyVUR5SGhUdkQ4SUQxWm9CaXFHTTdh?=
 =?utf-8?B?SThKK3k4a0pqdTh3UnJ3VTJSYUcyck96VnNHR2pkSnVhVStuaDdheFBoWE1D?=
 =?utf-8?B?YWx0WlBZMXlFQkpSajl5ZnZONDhCQ0YwbWpjeFNyeElBK3RmL282R0R6VWww?=
 =?utf-8?B?VDJmck42cE53NGFOWEdLaFZEY2o2WGthd3J5bDJiZnRrVnFoN2NYZnhHWTVm?=
 =?utf-8?B?dmxOSUM1MFk1MWZPTzVIV2E4WUVvNWpuYUkvSFZNMWFKWVp0bWFqWTdkeTlH?=
 =?utf-8?B?YjA0QnE4RGZpdmE0U0tlWHc4bUpWUGovY2duN0lBOE55N254YU5EazhkREZn?=
 =?utf-8?B?NEE0dkExUFI3NGRHWTJrWVBqSkNkbW5pQnBpNW5vRE5FWExYa1BDeDUydUdt?=
 =?utf-8?B?YVdodlNsRWlsUzBpbnppeVBSSy8zMFJiUElZYjF0YmtGT2lMdmQ2WmFMZmFS?=
 =?utf-8?B?S2lES29rZnIrSnFCMHZGYUFtZjVUazFpb3NEOEtVbGJqNDdmMDkxb1pyakJE?=
 =?utf-8?B?RW16YWg2clZnZUQrOUFQU3BycXhJSHQrelo0dEtrbHNXYmJRbHgwaW9TVXdS?=
 =?utf-8?B?SHFqbzhWNjViQlZpQkdsclJjL0lrb2pqekZjZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(10070799003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVBJWlUxRGpGNHRLRTExMmpXVkhPTmlIbEtOMm8xM0krMjErQmxXc01GclRZ?=
 =?utf-8?B?d29JOFhxUDQ3L1FHZXluWkl6WmV3WEJBbXJHUURQY0JCdDJwb3EyQ2tsSWZw?=
 =?utf-8?B?L1hFNStEYVptUmt6cFJ2c0x5QnRBR2pPc1hWUjlTSVgwQ3FVMHZpbEhmTTVr?=
 =?utf-8?B?N1ovdVI1eS8zdHFOaHB3OW9RRmQ1amUwUWpWb1oyQlYybm9STndxSWhSWDhz?=
 =?utf-8?B?R0FYVTVwMVNkNjJSN3VDdjA4VHdkNHJhZ1lwMFdmSVJFR2FmRG9HR0RYUGlG?=
 =?utf-8?B?M2ZseEF4dk10YURZb1lkTld4UUZTbXczQUJqZmVHU0pqWXFSbDIzczVxM2tl?=
 =?utf-8?B?Nm1aa2k0ZU0vUFdBb2FxbEdCZm12UHBnZUZnbUFyQUNzMVFNY0pxSUlSNEll?=
 =?utf-8?B?K1doQUd4ZU1hc0tFNFpySVV0OEZDcGZIZ3BQck9MRGFwa1p3UXl6MTdDR1Nl?=
 =?utf-8?B?QTVDMllncjBsbnJXMHhkL1FDL3lrMnJEOFVTbjJpSXJFd2V3RGtBaXh0UXVM?=
 =?utf-8?B?TzI5VEJHZXhsV1BLeG1NN3N4RXFaQXg1K0hBK0tyUWFZTW1uUS9aWi8wOUgy?=
 =?utf-8?B?SzJXMUs1L3I5WjNmRGd2OEN1Zmx5TlY0MGorOUJpUWRYdkJEOHZIZ1BuNUlK?=
 =?utf-8?B?S2Y5KytaMTc3Z1FJUjA4WGZxME9qRVVQa2kzZXNGTDUxb3BuNXRYSllVdjc1?=
 =?utf-8?B?U2ZxYmpIekcvRVBDa0s1akhqRXpDYmt4WTFlc2g2SkpEb3dOdUVoaDRCSjVB?=
 =?utf-8?B?bHlMVkowb0xDNnBhQW5JSGd4THMxbDNSYnhpM2ZDZ1djMXg3emUvRzhHeG1U?=
 =?utf-8?B?Wmd4UzJGUi9jTmxtZmRIS1RkUXlkbHlZa3BudWNXVW9YbzVKNDNSWjljL3FG?=
 =?utf-8?B?U1JLK1VTNmVYbWE0QXY5ODZmcm4zbXpHQlU2Mk1DK0RSR1E0aVl4SmFkazRo?=
 =?utf-8?B?OTlKUmQ5NjBIeHhVT0d5MncxNGgwRk0ycU9rM045dlV4aW1wd3lNTzkxcHRK?=
 =?utf-8?B?ZDRpSzNQK3Q1Y0F4cjZNNm9kWDZleDZ0Z0dKeWVUNDVkMGRTUTlBKytvVHcw?=
 =?utf-8?B?d1JhOE95VityZVRtNVRzeWxTM1JicDlGUUF5UXA0eVZJM1NJT3RpU0VvQm1m?=
 =?utf-8?B?cS80c2NqR0FaTDBvb2ZaamNqVFJzNWNhQTUwcDlMS2lwNXlrMzJjS0pQTDlG?=
 =?utf-8?B?SlNkTGZ2VjEvblZ3a0xlUHJvZlpMUTFLOUdOVnhMUldqSzhtbUFJbjFoOXFK?=
 =?utf-8?B?eUlJbGtybHpCRkRibDNOWnRhcnpmSWxHdWhUVWt2SERGOSsxSWJjZjdzSTd6?=
 =?utf-8?B?Uzc1VVVPTFM1VjdyMnJ3Q2QvZWhTeHc0alc4TUZCWnlRRkVsbERGQjladTI1?=
 =?utf-8?B?V2plbDFOeDBGSmhOVUQrSnozbmw4UGFhQUY0QStPeFBXdktrYjRBazJ2Zi9Y?=
 =?utf-8?B?cThRMCs1NXdobzBSRm1qd1hQREZ4ZGx0akV3YXNvNjdoQmxRYTdwVktzcjk5?=
 =?utf-8?B?b2RrSS9GMTg1MGxEektxR2tFN0FRc0gyMUZ4dUxLMkJVR0xnTEdYZUlCaklO?=
 =?utf-8?B?aFRrNWx4c2lHR3FOOWRHbkRNcmRwY1Vmd05sZ0hMaGhWczMxOG04YkhXRFRU?=
 =?utf-8?B?bmFOSHhNK2ZmRVYxb2doWHlVOXFSYVJFQWlPZzJkdUFKSnpPekxUVWUwR3Zi?=
 =?utf-8?B?NjdsUXpFMDd2WmtzWmh5RW9Oa0lOUFNwK3ZIek9vUlZWMUlGdG5hdnZFRFYv?=
 =?utf-8?B?dlBacEIwSHFYMW5Cb1F1SVNKaTRTWm9maDFUTDRVa09LckJZYzlraGk1WEpN?=
 =?utf-8?B?VVk5dVJUTE1sMm5Vb3ZQb2c2TVg1RVU4WHUraFRXN0NtQkxKNWYvRFlyL0FM?=
 =?utf-8?B?SkVHSUYyQ1J5Zi9GZGJqZUVMeVJyQ0g5TFpnajB2cDJxRFNyTE1tbGZkYnp0?=
 =?utf-8?B?YlhKNFJnYTAzSEFVNUVoVEt6d0lRRytMZHRvcFcrbzdmc0dMbnlHQ20zNk40?=
 =?utf-8?B?UVdId1RUUFNUdTg2dFFLMGI1cFdhSnpRZlBlREtuZWQ5R1RTdU5FMjJSWkg5?=
 =?utf-8?B?dndlNUJNdGlmbWZLSk15M1lMYWNPYjI0eWJYTm9ZTlVDRzEzZit5bUs0TWQw?=
 =?utf-8?B?Q09VbS9EdERhbFQrZzAvNHZBZVlnTGQxYkdtc2NhTlpVckNpSUJGN1djUVBM?=
 =?utf-8?B?NFY3S1VYeW42aWpPd2JYdVh3QjNKWHZ4WEF1UTBCay9TRTB5WHBZQll3VXVL?=
 =?utf-8?B?M0xhRWZDRllteUJJWklXT1ZBZUdnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73468587E29D0442B23EC0C752AC0D54@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vis6WKXXGXhziZiFiHBy9yqHROprnaDwU5X4FhcKJjfhvsmFISHjLAR8vZw9tCbfHrhQX2Ulfwy3gWAACb2wtp9eTL9JBrSRVgJ804Wf2vNzmhQD1dGe0d3TLFz53odQHSUFDE7nhdxejIkPxB7vsnUmkolLkM5eHBqNC/U5F/sagunYd85d9T5MavW46jDRjCm0g5wqBUPR+BwrZDJ7of7fQik2B3pypQyBfewRCY1X4XI/sZUnQPPAqLroNS7I5djbMBzl+Sn40+B6ZDPKLFAsQ8lEW3PWZxc9o4lwdVjAP3/uTrVzghm1FIQQRlkh1kr7mfjCq+v+Mo5aqcamikDNjnMjXskAU/StMb7xZvi4dfqYu30dl+QRFje38cz29mE2HzVBbFUPRQTCKKr15HZaiijlZkSvjquQx+maWyxGi1sp8qsPVHS737G0E1UqccQYOC8X6Wf0aIN8IhtXXl9FLNtrLSm1Wp9bsF2AVI5RYW74G58ZAyW3USxbEahdY2M6DvuVrVnlDlBNz29nujBQdUPzUMI2JPf0yKEbDskVOfO/fH6UsqDiGRDavURv5UVG7n7wub959A0qBwauqfc2p4S16cKhVSFImY3WQykdulvPIlVnG7UilSrJPoR2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e4f0d6-73c4-4bd8-8fad-08de1ae89e11
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 14:52:31.9333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mNKRnb9c//WifJ//Q2mu1lWcNCVvBfQcQT/Nc8iXBrrPPUS0ImvpyjSAiq89adO6xfAHbzCMlgczyOatQPsM+yqsrOlO0Gj/90mNQXjQwD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8812

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

