Return-Path: <linux-btrfs+bounces-10847-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AE9A07969
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCA6188A843
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 14:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E67621B195;
	Thu,  9 Jan 2025 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AaJd/f5v";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iioWHvX8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D4F5336E;
	Thu,  9 Jan 2025 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736433584; cv=fail; b=ofT71AxSwxXdVUEOSumjvKIPFxgrl717sBVUuAA/tQl9tH/dqPz0aFMXsexE2LLyxSKVR8YB7Lht0lw1faOXTnWTyirzoC5td4bXdNwy7mQh8GFM7KOAdxkyG3/SYFKvoUZsc/P5t6OE+bvQlK2/2NfdUAq/JQi99NswZgPrKYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736433584; c=relaxed/simple;
	bh=HIrjQggsTI4G6eyZAw/Pcm47oDiDUQKtyWiqxuB8T9M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=po79Lpvcfse2YkI8Pkx7vJpW+CVKvNdSqbNGmKz1b7fsd+c4Pz1wu9iaNnOyTx+LK6SoVzZDYMi/LYeOgCgK3plBktjMz0z9rwIuT+C6SaZkPARGjR8jPprH7a6bl4x1QDWgldSXPsZePwjvLuEbhms8M9Xss8I4UJR+s8A9RoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AaJd/f5v; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=iioWHvX8; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736433583; x=1767969583;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HIrjQggsTI4G6eyZAw/Pcm47oDiDUQKtyWiqxuB8T9M=;
  b=AaJd/f5v3x2tmnbpRFvJc1i9YAu4dJ4tcS6i3jk+YBhkfKOxN8wSrbf3
   Ukox2t1mV5dKDOvyjeW5tlX2+dpi1X5U9tMHMUj7cJ6qKIbLD3Iymp/QT
   VrpdAaiZ+Rk7JnEbhMLwwJR2DSuEey6sH0ccZ/3E4Yt5DLUiJ89RtuG67
   05MeSMxktiQbEqR1uLl21hivLjGzBJzoOYLVPJXIrvEllNlj5TpAmfXf+
   c8Xxfzl+JQyiuA+0g6GKVbuOpBJMImpDDsstD9mti44fBgCV5m2tK7KD5
   8juuyqBTF6/v3lEt/hzBtgBhscjlEwg2M3JkK8+wuNHeO1kHtQ7rPIdxo
   A==;
X-CSE-ConnectionGUID: 52zU7BbZQ1eh0m921mCmiA==
X-CSE-MsgGUID: srnqUWFpR1O6WmEaAwuQ4w==
X-IronPort-AV: E=Sophos;i="6.12,301,1728921600"; 
   d="scan'208";a="35357541"
Received: from mail-westusazlp17012036.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([40.93.1.36])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2025 22:39:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMHR1MrlvNn5PHha72AFH7BGUyESzHJzs8uVVgv6X5VDipcYV2GlU4zN5bfVzUMcKEI128jK0XMeuMbcjHcXNTtYxuMGLd9txrcCMmd2H5fnNALp28kTXwKfwX35DWLitMAMGYYIKc0xGnMS42VTytJ3a2iYMdvJ+uTP/AmxHKtLChWZV1ri1QyBSTzSp84KgnCSHIrin56f/drW1liDdEKHdzAvyjchLarHddj/Dv7fuEGksbzaL0cngy9xt52tLQ0IkuhTynFCDA9gGK6/yxwx85p6qFrXmvTYyh7d9yl1jmBvwfhDudr3JRX+rTR/+tqGykoVW1BB6i2+45Sc6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIrjQggsTI4G6eyZAw/Pcm47oDiDUQKtyWiqxuB8T9M=;
 b=OgvaLm0yvNiP2HdaxzWubha7pXYBDJhMXtweQIKRvVToiLjZhxqEH79zvsNk6A7v+bFLY6biHp8Kz0Po7Qk3Pw2Hh/19xq8GXocxgFz6NXrrsD1o5xYOvwiMFJ/llQOOLFu2RZxKnBITP/LexGr+/ttzQvWZAZ4RlcHZHT6l2XSEMdrZLKrqgk8CNbjEJLf2dOY9SJrfVGakeKmLG8RQwyI1iIhpb5RperkT3jc5mzUbu10SZWnnO7JWKIqXs56+LEgAT9fe3GzyZijiSLp91C2BMYLQ8CdSQOPVd1tgBYfsa6LUggjW6opYLxhi4vsL48/KSdkum9SxlWKGFInrtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIrjQggsTI4G6eyZAw/Pcm47oDiDUQKtyWiqxuB8T9M=;
 b=iioWHvX894ms8/DNBLJmVNjlfoIopgJ+Reio4boR+PC8W08UwrUBEz0ce+wDMvEba2sWcpTmR5wYXXjK9KpUTqoPSLsgr5rGd1j9vlvm3ahXekVrireFgJQhPMLtORmiHfet2Q0dHOGX5nNIqcjJWchMXzwEo2/f3aXFQyo/m50=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by IA3PR04MB9380.namprd04.prod.outlook.com (2603:10b6:208:50d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 14:39:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8293.020; Thu, 9 Jan 2025
 14:39:35 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 01/14] btrfs: don't try to delete RAID stripe-extents
 if we don't need to
Thread-Topic: [PATCH v2 01/14] btrfs: don't try to delete RAID stripe-extents
 if we don't need to
Thread-Index: AQHbYQJflUTtOhP83EGPi0Ll42eqgrMOY84AgAAiyIA=
Date: Thu, 9 Jan 2025 14:39:35 +0000
Message-ID: <ca324436-f214-468d-a769-fd4f236313c0@wdc.com>
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
 <20250107-rst-delete-fixes-v2-1-0c7b14c0aac2@kernel.org>
 <CAL3q7H58qoA1MjDG4aFbaGE5ddAJRgyNZ0rAyb+XhEqP20xKcA@mail.gmail.com>
In-Reply-To:
 <CAL3q7H58qoA1MjDG4aFbaGE5ddAJRgyNZ0rAyb+XhEqP20xKcA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|IA3PR04MB9380:EE_
x-ms-office365-filtering-correlation-id: 8e4fae0d-6e67-422a-df09-08dd30bb7030
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YTJrN3JPN0MrbjFnWVdmSG00M3dhZnJNUlJXSzVMcU1neHZraEJLVjVHUWx4?=
 =?utf-8?B?SkZUOVZ3dVo2cFU4dG9iaTJYOVp1Uk5mMlRMLzRxaFNhVnExT1doc3AwUjFn?=
 =?utf-8?B?Sk1YWlFOSUhzYUFRb1h2RVIrdEdOdzBRUXRoNlpnVzgrZ3FJdXlrTE5OWGZ5?=
 =?utf-8?B?anhmSVArZEV0cGZta2ZZTm1tUnRLRTVzdkhGSjVESHZSMHdmZW43UmJHTFp5?=
 =?utf-8?B?bkQ1Mml4UjFtZUN4WHlBd2FvSkEvL0R1ZU8yWllvT25maVExN2VVczFCazJC?=
 =?utf-8?B?bnJwdFBIeG4vV0FqeDRTNnRlaVNwMGd3b2RqbVk5MUVta3BFeks1RWZoUGJH?=
 =?utf-8?B?OEFoUlB2S1UrdlZyRnh0WHFPMW9TT3Q0RGtQbGh2WjZvYU9IRjJqeVpQb1F5?=
 =?utf-8?B?VnUyc0VWR1ErOVBSR1c2L0FVM1JnWVgwRmEzazFSaWpERWZxV29Yc1ZrSktt?=
 =?utf-8?B?VmFjRDhkY1hXRDZLSVExNEVzRFlMZTdlY1ZFWlJuSm9CMnM0RW9XdXhBQkZB?=
 =?utf-8?B?Q0tubk55cUFpWnM0M3RDUG1vTGZTOHB3c2tDUFhZWDFtM2tzbmJUZ25DRzNU?=
 =?utf-8?B?dXA5Ump6YkNycUc4RmJHZk1xN2NLZjhicU9VcDFnNEJiWFM3MG9LUXE0Y3RL?=
 =?utf-8?B?OURNektlVlU0UXNjRnF1NHpCMnM0UnVVaVluU1RTTlBmS3F1MFBuQnFRdU5G?=
 =?utf-8?B?VnpndzZHaHZ5MGdwczdnYVRsM2xKYU9wYVkzY0dldDU3M3U2eEVzSWJPRTFi?=
 =?utf-8?B?UHRyWTdrS2FmaGZVNFI2U1ZnVENLSTJacTlXV3NweWI5bExXQUNCenUvQkxO?=
 =?utf-8?B?SjNCdzhBelpWZXN2TmcyMWozc1J0SjA0Q1hYWXVMZTFjTE1kWXFhcVE3blpO?=
 =?utf-8?B?dEdKVEl1U2hSeCtxSFZmeE1POG1veUxYcXlYVlZnRk9hY0lGMUJUYzZvSUhu?=
 =?utf-8?B?UWNOMmZsTDJkM3pvVnc5d2FZZCtpdkwwZExueldDS2dtdS93aCt4MFNMamNP?=
 =?utf-8?B?MHF6bSt2Y2hQOFNaWERvb2dCcDExWFFSU0IyZDhldSsyV202M2U3dWpiMDF0?=
 =?utf-8?B?TzZMNlJ3VjJBa2RBUERXQ00zKzF1RU5YZ3BMZlZ4V0JiV1ZoanFmVjR2ajJ1?=
 =?utf-8?B?Ynkvck8xQWlscGJOQXd2Y1NHUXJVZk9Ub0p3MzlkWU8rZXF4c2pIMkhIQTZQ?=
 =?utf-8?B?SGRSbnR5M0VpRjdUT2crTmthdStuditKSlo4MW9NY1NTODg5R0t0aWt0aWx3?=
 =?utf-8?B?Y213VW1PeTVnZ2tqZ0tTS3hLS1Rob2R1czd2alM3WmJBVWpqWFJCUnVoUXd4?=
 =?utf-8?B?Z3BxL1lLckZLYklDUXFCWWUrckZlQm1aajNveHhqRlBPRlpFWjNSQlZyczk3?=
 =?utf-8?B?SmZyM05MaldZbGExWUlvejhTbVRKbnFXN2RqK2ZPQVZ0NVpkR0JNYzdVdmpI?=
 =?utf-8?B?aERTRm5xSSsrbWtiVitZeC9xWGF2dXVZbkhGNFBZR2M3K29oUVdsenpDMHE4?=
 =?utf-8?B?cXJRM3haeW1nTDZzNTRnY0Z2VEpLaitMWUphcTM3TGxsQ0FycmIvZnVucHRo?=
 =?utf-8?B?MGJ4MjI3UHJyemZBK3RQbEFiRllWK2pYcFZzTkdIR21IdVgyTUttQ21keU1N?=
 =?utf-8?B?bnRYZHB5a3UvRmxUYmFlNW5QNmt2TkhmR0dwMUJtMHcxV0poWnhkQndBcE9E?=
 =?utf-8?B?SmZqZU12UHc1ZmpiVHprOXdqZm02Ryt3cUVabDI1SmUzSVZnWnA0cE9UQzA4?=
 =?utf-8?B?aE15ZlMvTVh6Q3lIbzF0ellyZ0ZBeGZNVGZnMFBYUFhlblg2bnNhSUxoL0du?=
 =?utf-8?B?Wk0rRXVTMjdYT3NFMXo4NkJzaHNJcitpTGVCRENwZ2I3Rk5BOTNmeHU3aW5H?=
 =?utf-8?B?QTh1NWdrVStKZnZIR0pRWGluRDZuOVRZcXRYRWF2Q3Vla1Y1eC82Z2oza01W?=
 =?utf-8?Q?EIGlwXRm7bLP05SS3bak5t/PRpNb8d7y?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?azdRaGdZMWxkN0d3bDhIVzVuTXlWZkNFUkx5R1FZQ05uNGVHeVRKaWt1dllk?=
 =?utf-8?B?REJSQzY0RzQwWFpBM3oxSXpmQW5MSTJLMmpRdFdjeG84WE5oSTVKWWwydmpF?=
 =?utf-8?B?MFVWWENMRnF6UVZLMWdJTkVHU0tuWFFUc2xTeG8rWS9pTDlheVVqRzJEMG9I?=
 =?utf-8?B?NitUdnhrSXd1UEtrUHlkaDFqNUlkVjBHbnBVVVNqajA2YlplTkkyckU5MlFG?=
 =?utf-8?B?T2RuYzhsS0hxdmtBaUNobDZRSFNrVmhPa1pQZ1JpNnRhanZnaVo1WW9ZSjEy?=
 =?utf-8?B?VmtldjY5Y0FjU2dKQmJ5dkh3U1JXaHh4RkRPZExVSW1COTNLako2K3BucWd5?=
 =?utf-8?B?d1RQOHZkaVBLSlJTUHFnQi9tdnBpNHpvTDdKcE55ZzRlRUg3MnpVblZrRmZS?=
 =?utf-8?B?Lzk1WjlzVm03c0hZKzA2RWNPK3BrOWtsY2l3SGdqbVR1VWM5dGRMajJ2MHha?=
 =?utf-8?B?aUhZamZFajhRNmdMV28wbkltUTZBQyszQXdHOEFXQjQxTDU0dHlqcnV4SkdJ?=
 =?utf-8?B?ODByaVlRWk41U3FzcjVQQitNVG9ac1RlWE1HMmpFQXhNcnpvWGhVeUdzRnh0?=
 =?utf-8?B?Sk9IQ0VGMFVtYjE3REE4U3RReEJueGFmL0JKTWZ1L3VOei9QdTVaRlNTUGht?=
 =?utf-8?B?Nmd1ZGZPcnZaRWxVZnY1RXVnZnU2QlQ0ZjR6N1Aza3M1NzhybWhkNThxVkV4?=
 =?utf-8?B?RG9Kanp6Vm0wV2FQZzRyL1IvTExqclhGak9hRzl5VnJzMXBhZHlQd0Q2UTNx?=
 =?utf-8?B?WktNS3RrU0NLV1FWRndYeGdISE9HT3RJRDJLOFQ0OWNZMlNRenBmYTdxUmpZ?=
 =?utf-8?B?Y3kxbXMrdUZBNDR4L0VQdURKTUFNNDdNZnlhcU5qV0IyT2V4STgwVlRKTU80?=
 =?utf-8?B?RGd5R1phcmI4Wm5WMWRLb3g2d1B0NmdhTStPTmR4L3JGTEVPRllFMkx5cGFk?=
 =?utf-8?B?aVhVUmRVSzBFTVNzSzMyVmxKRnkvd3JFcDJPMHNDWDk4bk8vYmJNQU42KzZ0?=
 =?utf-8?B?c25Bc0h6Y25haURsZVF3REQ5M2Y5RVZXTzI4R2NiUHk2Q2FlY1RJSldScVYx?=
 =?utf-8?B?Tk5kS3hOeE01d3QrcTVRck10d2h0MmF1OGg2bUw5S2ZiNmxLaWVTSVo5Yi9y?=
 =?utf-8?B?RFhRV25FNzJRWTl4aUZkbitodDh3MGZvTGsvSGZ1THhLbFZES0U1ME1BbzNn?=
 =?utf-8?B?SlBTQ3ZFVjFBMzBVY3ZkNHBaNDBZWUVGekkydk5xeEliWmREOTFJVmdNM3hs?=
 =?utf-8?B?Q01WS0VPTmhxMzR0RzkvYm1DRjNqeFVnYlBqei9mYXFxQ1o5MXRVaTdQMHlq?=
 =?utf-8?B?cDFGdWhGNEhuc3Q1eEhXdXRHWjdZd3Q1TDltZjR0OEpjSGpjVEVWcjlack51?=
 =?utf-8?B?bTA2ZXdYTVFRRFpEODBUYTlRTzl4L1J5cjNybG1HaFFHT3pWc0F1MU9vRHBD?=
 =?utf-8?B?QklUNFV5ZUZnRmp0NThmYlRmNDhXWFlCODd3VmFmNGQwN0E2a2NPUWRyVkdp?=
 =?utf-8?B?YUNxUlFRaTEwdW84aWxjWHdBWmxWcWVlVmpIcXBmbmpwbDRzdktKaUQvaHFa?=
 =?utf-8?B?TG85ZnZGaDNjeEcwTlpQQWRjNnMvYWFZVDY4OGlOYlN2SlZPbDhlOG4zYXQz?=
 =?utf-8?B?ZStEVTdSODMwWGJSTGd6SXE5YngrdE9LZVVybS91c0lGbjhCZ3RNREZLMDE5?=
 =?utf-8?B?MXptK0ovQzZ3eTFDSEU4V1oxM0V1UVJIaXJlNGpnMGxZL1VmVWRUcy9ielM5?=
 =?utf-8?B?OEU4amprenBXYm01bjZyR2ZMb0dwYVIvcis2T2haMTNIbWFxTzJpMjZLZjU5?=
 =?utf-8?B?VU52TkQ3TjI2NnNOTXF6MGJNWExrTGJVUmkxUC9ScWtFRDNTRTViYlJHaWFU?=
 =?utf-8?B?K0xVLy9DUldaZyswS3hyVjJ4WmhSS2RBQ2x4MHlNK21EM2V6bS9ZZ1FOS1hu?=
 =?utf-8?B?VlZyT2czWGU1ZkIzdmtYbUtuZk5RWFQ2eWh5M3dsbmdVeVlkbnJZZFFka3NE?=
 =?utf-8?B?Q0ZYNFdYZStSTmNaZ21HUnZiMG1jczlYK2FhbzUzSG1JM1BYYzlZcmxkNHJy?=
 =?utf-8?B?S3llZGR3ZFlTRkh6WjVNTmhqUVRMRTk2aE9BbnVMdUZZbmtiNngrT3FsbTh1?=
 =?utf-8?B?OVhVNURZeTNJaENadTUrMTdiUzhnNlBUVWFYdHNRUktoU2pJK2dJWWxWNEU0?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D71C238BB3AC2439B011A1D9BA0A468@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DvDTpVXtGCy7T9r6n5Z6zw896gkK7gaFKFuHk2wDLDIITaK4p1tL4vG/qIrKc4EkjgYFumC8yegE/HxZN8QJVxM+K55M6CtP9/2es6Lh8vcnkEpjALBQAoi9gDfzcfYT84kccixNsSPCfzqNkYw3qaRzkhIKpUAVI5cat24XCMduyUXTWMCUSkoFiyb9LOvmFK7VMpc8CSudvqSduTth7CMThdmI9ykZhmLXSa2NvTVQvHue6otbTJU7sTr9fwZU65c7zW9/L3e6+sMQn/0uoA3n3WfgWkBNv7aGhzFZIPky4Co1oqycS6NqO22YynZ/nhqdEkCnSWe3LqPQbDfVd/dRRvJkYe8nwbfz7p7c9wQrxlyRTBwxA2W5zU2gEcUB+f5yJH75LKZRf3Gs4kaJxGaebF594ow7xT75R6G7UcBfUqJEVUPYBaE0o3vJIrdyJKcY6fBfkhgiVyfl0oC2btsqGW/8lTg1cqdWW5dZ6zvZzUaxmOdpT02Fo1wsMJuRKrDJ6mysLSEwZCbPVbJwwhyVVxgkdkVDotFAzBn9w0mkjYcTVeU8twsiRERO40e052HHmVV8V/zIU5qui0ySvBfu99+zyjnWKwDIXmcoZsuUfsXtguOLrDGQ1m0CP9CT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4fae0d-6e67-422a-df09-08dd30bb7030
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 14:39:35.5401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aCEQN4eTr9BgnZLeqX8AqeqjCPeYa2gALUQQeqFeXPiJbcwMA2ML/zDP8k/TqItl6DG+z0fqqpUtPRjy2ZZBX39p6cOHe+qumYDFB6JJaGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9380

T24gMDkuMDEuMjUgMTM6MzUsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+PiBkaWZmIC0tZ2l0IGEv
ZnMvYnRyZnMvdGVzdHMvcmFpZC1zdHJpcGUtdHJlZS10ZXN0cy5jIGIvZnMvYnRyZnMvdGVzdHMv
cmFpZC1zdHJpcGUtdHJlZS10ZXN0cy5jDQo+PiBpbmRleCAzMGYxN2ViN2I2YThhMWRmYTlmNjZl
ZDU1MDhkYTQyYTcwZGIxZmEzLi5mMDYwYzA0YzdmNzYzNTdlNmQyYzZiYTc4YThiYTk4MWUzNTY0
NWJkIDEwMDY0NA0KPj4gLS0tIGEvZnMvYnRyZnMvdGVzdHMvcmFpZC1zdHJpcGUtdHJlZS10ZXN0
cy5jDQo+PiArKysgYi9mcy9idHJmcy90ZXN0cy9yYWlkLXN0cmlwZS10cmVlLXRlc3RzLmMNCj4+
IEBAIC00NzgsOCArNDc4LDkgQEAgc3RhdGljIGludCBydW5fdGVzdCh0ZXN0X2Z1bmNfdCB0ZXN0
LCB1MzIgc2VjdG9yc2l6ZSwgdTMyIG5vZGVzaXplKQ0KPj4gICAgICAgICAgICAgICAgICByZXQg
PSBQVFJfRVJSKHJvb3QpOw0KPj4gICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4+ICAgICAg
ICAgIH0NCj4+IC0gICAgICAgYnRyZnNfc2V0X3N1cGVyX2NvbXBhdF9yb19mbGFncyhyb290LT5m
c19pbmZvLT5zdXBlcl9jb3B5LA0KPj4gKyAgICAgICBidHJmc19zZXRfc3VwZXJfaW5jb21wYXRf
ZmxhZ3Mocm9vdC0+ZnNfaW5mby0+c3VwZXJfY29weSwNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgQlRSRlNfRkVBVFVSRV9JTkNPTVBBVF9SQUlEX1NUUklQRV9U
UkVFKTsNCj4gVGhpcyBodW5rIHNlZW1zIHVucmVsYXRlZCB0byB0aGUgcmVzdCBvZiB0aGUgcGF0
Y2gsIGNvdWxkIGJlIGZpeGVkIGluDQo+IGEgZGlmZmVyZW50IHBhdGNoIGluIGNhc2UgaXQgYWN0
dWFsbHkgc29sdmVzIGFueSBwcm9ibGVtIChwcm9iYWJseQ0KPiBub3QsIGJ1dCBpdCdzIGFuIGlu
Y29tcGF0IGZlYXR1cmUgc28gaXQgc2hvdWxkIGJlIGNoYW5nZWQgYW55d2F5KS4NCg0KSSdsbCBt
YWtlIGl0IGEgc2VwYXJhdGUgcGF0Y2guIFJTVCBpcyBhbiBpbmNvbXBhdCBmZWF0dXJlIG5vdCBh
IGNvbXBhdCBvbmUuDQoNCldpdGggdGhpcyBwYXRjaCBidHJmc19kZWxldGVfcmFpZF9leHRlbnQo
KSBzdGFydHMgY2hlY2tpbmcgdGhlIGluY29tcGF0IA0KYml0IHNvIGl0IGlzIGZpeGluZyBhICdw
cm9ibGVtJy4NCg==

