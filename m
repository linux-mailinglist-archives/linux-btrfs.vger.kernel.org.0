Return-Path: <linux-btrfs+bounces-15717-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A54B13D8E
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 16:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D7F3A160A
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 14:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A7926FA69;
	Mon, 28 Jul 2025 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Hxxs5+ww";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XBWMvDXS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E55E270542
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713863; cv=fail; b=PShZlxviQHMfVy+SPj11xGWBGWFQZewcqAzbS8aVyPCmAoMTL7JRr3O5RSDJsKDOdiG2snqz1+Z62I5LlGtalcjo/h/XloleU11I4XTyX2swoJAfsIsnv6tiqkyoas6y9EVD5GMCynFAX+zXhHWIFTIW1z2nwsyh2qOkx3sb0SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713863; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ODhWLtfzkXyN80Q37h8NnuPUQxg/caDi/7d6KyahxVuhCn8jqQxy4rJe4zBNQ8gUOtMBwXA/tt6Zo3VCAYbMovJnUQQTW2TfvFBAgyOvGydU2aFCdro/7F5Z/zwxPYDzf/QCulBB4TmccORouFZ9QcTWPF4H6+EbuWPT3hdtCng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Hxxs5+ww; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XBWMvDXS; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753713863; x=1785249863;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=Hxxs5+wwAUa4YiiciCgEjKOM3GLsNALZObAuwfM+qK0y+r1/JzYgzcNU
   8BNc6wDdCdFnXNfXgwsoTAwK4P9c3Z0oiG/OEr5e+SWo+XqINYxSAZiUG
   3gpop2vJOcFkBSIHIuu8NGXLkiji9cwEwxoW0qlfwEeYh5Sixgtr3zoMO
   8MK4pvSGQjI8yXiiraTqB5cS8fwonFbJY3Gksakk/00mIVQKw7HvH3PvD
   2TueNTxsK9P4gUtSQofZamenx0/w4q5NNLvFv+8ye2m+4XeB/smHUqysW
   Ckvm+0EYkyh8HzVS+i6qHtunrcnWibeGCyzo9cnWIgdup20GX7Wv+WYlt
   A==;
X-CSE-ConnectionGUID: RtvAoDimRL+YQyo+y+CHXQ==
X-CSE-MsgGUID: XVHHRaqTQaaaEhR3S5JlHg==
X-IronPort-AV: E=Sophos;i="6.16,339,1744041600"; 
   d="scan'208";a="101262164"
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([40.107.92.87])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2025 22:43:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJ/HOKzJROrL5VJ5OBHLDdkKigHTi/VL4lQi8CzeGq8H4lGdnFek6Gx4aNxF2Oyk5FTcknbqTZvwH0YtwJwep733NK3MpOGrXuKvHG3YemifO0rBaNxbwnvddZMFEYQ+TbtbpBEECDwNPvDoaYRoyF0ve2M3nOX1sIYDQrtfZo9bXFNVMtQCEYCMo3CAV76nbgXIwhUUZzAEIlkY+L6lr6FHIsVNCAdI1T98D8D38AaBghU4bumv2wtQ7vIfjnArkZKjFKWyyePlle6HV+UZwotVP8scxaJ3AdD3FCoKpiKg6PmjvAa0erxfitSMlVsudDyqzZPhTc291w60Vozjlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=R1lVZbc1dYLAJgq4Fz3r+IcFNtoMJf2UuAc4440UxdIBAmZ1aTNDTfz9BdQ8tDckz2NtfJVkcAtfUu+zNbdo/Qe83YXL6Zda2EoYyNDrET451Mb9fCfdFt6+DGQmwFjpqWSn0bEM0s8kxbN2TS803WAP1t1UbSZAPvRl9K3e6IjCYpvbwRMKMH5NZyZUyhlQc0glpNN4qvMOYNF+VAGhPTXGo/XvJFt3CGwN8xkhPqRaZZorhCDqoQktHD4qpqxFzxkES4legNxB6la2/3gF+k812rMbSK5NMdPe8+xuamZB+fHe6jJmYJblzwW+f7Li5a20lYx0HwrgDJm/IoaUVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=XBWMvDXSSOqTV74ogPfE64VyeIp2H1hPOtfnUdVG/Ce5cWmKEpa5PeEaeAod8Fl3rr6eL+qTBu0TGpm++7eef1JUOkVG9x4ukHLYCyf4XP3U4s0VmOjUn+QLsp9iBUWniXTXEkEhv6fbq/MceAWbl/KZjId1uEatMqxThssXtkA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7570.namprd04.prod.outlook.com (2603:10b6:303:a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 14:43:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 14:43:10 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/3] btrfs: fix inode leak on failure to add link to inode
Thread-Topic: [PATCH 2/3] btrfs: fix inode leak on failure to add link to
 inode
Thread-Index: AQHb/6Oc/DoeDwK/w023LDL8s4h7ZLRHnJkA
Date: Mon, 28 Jul 2025 14:43:10 +0000
Message-ID: <c11d2d7d-2e38-48f7-a583-c4389e3684c2@wdc.com>
References: <cover.1753469762.git.fdmanana@suse.com>
 <7fb0dc01b44be5d7d505e0361daf0732009e8f57.1753469763.git.fdmanana@suse.com>
In-Reply-To:
 <7fb0dc01b44be5d7d505e0361daf0732009e8f57.1753469763.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7570:EE_
x-ms-office365-filtering-correlation-id: 065b8500-1aa3-4b09-8c9b-08ddcde51316
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZlAxZ0RsWVRLVEs5OFVtWVhQR2NzOHF5LzFXTmtUOXRHdDl0Y1E2QStsWHBQ?=
 =?utf-8?B?dmx2MitGNVFOdVNLKzFBRTV5U2ZQL1h5NVhnRG51SUZYaVZGZkVLdEdjQ09R?=
 =?utf-8?B?bFJRZWczQUFjK3U3cDZaRk83TW1nbGt4L2RHQW4xMURSNTNHZEx6OTU0M1l1?=
 =?utf-8?B?SEQwdkRMVktjN3d6SHVlYi9iUncvVjVWVXJXbVlGa0ZIS1NlWkgrcks0QTVz?=
 =?utf-8?B?Q2RQK1d4NG5namFSQ0JTMDdIeDN4NG4yQU1GcitKZHVhK3FqRXNneWdCVlMz?=
 =?utf-8?B?YVdvZGUyaDZ1b0o5SEE4dXVHZTcrdVdQVTVaeCt3TXBMT1BuNW91YTB2QmdD?=
 =?utf-8?B?aUdTRkEycjJnazRwejFIUUxUOTd6UTdCTjdSTG0raDJNc0tRU05YYUt4Nnd5?=
 =?utf-8?B?b1h0ZjNkamplMFlLSXVHMzV4TXBaRmlOSlFPZS9DdUtNY0tBT0Jna0pYaldP?=
 =?utf-8?B?eXNGMVpuNFZvTTB0bjg0TnJMSVovSEtHanJDWVhQV0xFMWdFVkZJbUptUGdG?=
 =?utf-8?B?NEliM1V3aTM5Y01EMVJmcEM3d1hsVCtIMFNNY1ZkbDJnZ3FZemlWL2hJeXN6?=
 =?utf-8?B?TVNlcTgrUEdjRkM0NFU5MXowZjVlNVFuTjBqRWo4MEVTYjRaWmFmSHk3aFpa?=
 =?utf-8?B?Rzh3S2NybkY3b3lCMXI1a2FNMlJaTHhMSHp5MXFaUTRXdSsvK2ZmK3gwWlVL?=
 =?utf-8?B?MFhhTGgycHhHUUV1TzM2aGNySTZzcTlIaG5DZTdiNmkyaFQzWVF0Lzd1dmlh?=
 =?utf-8?B?NVZ3ZjVkZTJoeTY5OUkvMlpHWkIyQkp4VzNSL2pISi9TalBhS21uamdlOGRq?=
 =?utf-8?B?cDhmK3NFbnJ6TVhvUnltQ0ZSSVZsb0s2bXFPWUJPVmNoZjd5NDI5SERVdGtV?=
 =?utf-8?B?NG1SMXdCQ1hMeGpXODI1TXIybzJ2V0NQamNBUkpmZnRLZjlBdjlwbWw3YnVX?=
 =?utf-8?B?bEVhZHkxRUl4MlB5WE5wNFNINEcwQ3FjVjhyc2lSbVk5UTNWSFROQlIrNWpi?=
 =?utf-8?B?bFdGRVNNbW1ndWRWVnFWcnIxZmYrSXJNa0p1VXp0eFZYWU5RMlkwaXdNV2RS?=
 =?utf-8?B?WmNqeXNGLzNMTlUvQm9nT25mYkpMUENieEZnVm9WaE54aHY4ekpLTmVCZEpH?=
 =?utf-8?B?MnZFK0QzS0RIanJFTDV0RkhFYk9NZEJRRGJ1NWNYOGdoUndJcG9HQ1ZROWNl?=
 =?utf-8?B?MUlKcGtFdS9ieU5UNTJXcGh5a0RMeUY2RitrSHdvODg4aG8vUTYzZkI2bE55?=
 =?utf-8?B?NkRNMU4vclZEa1Zod0hjMDNBMjg3T2t5azVVTjhlS3RDNVE1ak9BVU50cXhV?=
 =?utf-8?B?N1JHN3JzcFVBUUw5c214cUxSWkw4Sm1xS2dYdkVsNXdVN0xlM1ZMTDhlVVpn?=
 =?utf-8?B?YWpvK2YxUU5OTlVydHFxTkdnZHFKWGZKZS95bWhZN2pBRjBCR2ZjdWhxSTVy?=
 =?utf-8?B?ZDd1VjViV29KWnNtdm53WFJvcWViT0dIK0NCL1pUQ1RJb1pwakVGS1A2VWhR?=
 =?utf-8?B?NXI2b21sbUZmTGU5TU10V0N5dFhUSVZBby9ybVhlR29qR0FSUmdVY3Arb1pz?=
 =?utf-8?B?RUU5YWdFdmI2OG9MYUNKNFNoNFZmVHpTU1N6d1Q5MXJtNnRXMk92NDcyelcw?=
 =?utf-8?B?Y0dpQ0R5a09Tak5OejNQYXdHMDRNcFdiY2VtYzU5RGdDcWRUWFhESHRwazFi?=
 =?utf-8?B?ejR4MWJFd0QvWS95d1pPMzVYeHB3bThpNzhiWlpvdklrR0ZQUHdvVFZPRC9W?=
 =?utf-8?B?THJVeGhtcE1tK1RoVFNra0Nsem1FaitrdFZBSnNVanQ3Wk1VT20yZ1AyTzRU?=
 =?utf-8?B?M2huSEtYVllXeitXU2VTV1AwQXU3a1A0ZjQwZC94c3Jmakt2Y0V3d1lSSTVy?=
 =?utf-8?B?TDU5WDBGdnlRRGpqTXN1TmhKK1M4SEVKMW5SVThQK21SMDRFRU1kbkd5RUxN?=
 =?utf-8?B?MzlPT2Evamh3K0wzby9nT2ZuSTVVOFNXRlhoSDJObzhremxIMUJHTytnWFZH?=
 =?utf-8?B?NWwycTlDVU5BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkpYVW5xZ20vbkZ5dXI0NWpVcjYyY2VNcXY5RVFXeVJBYk5IMkhocC9hR1Zn?=
 =?utf-8?B?amVFc0RUZ3oweENockRScHpoVTFXRjBkcGk4eUU2TllXZTg0andVVjRsdUJj?=
 =?utf-8?B?ayswM3ZkZkNLNjc5WWYxWVcxMy80KyttMWNhcU43dCtSSXYyNk85WFlHOEFu?=
 =?utf-8?B?T0tNUDNLWDhKbHF1Nzk3bTZDZ1l6YzVNTmFReDNZaW1IRDBPekNSajVNQXpM?=
 =?utf-8?B?UXJTdXNaTkJsNC9XdjJydGsyaGN2SUsyazFhTG9YTXl3cEJYTm1WQUcySmIz?=
 =?utf-8?B?UnNRS21ydjUzQkFyYXpINkFxWkpKc09KamhYT3M3R1FxZEVuUFZHOWxLejFr?=
 =?utf-8?B?K21zZlp1WXhJOXc0L1lSOWdZVlZLc013bjVwb2twZ1pPRkNkMmc2M3RrUmdI?=
 =?utf-8?B?aTc3MDRGb1JLQTZYNzVvSVQzRERuSmdhNEQ4Q1J6NFFzZVZybnVPaFh1S2FL?=
 =?utf-8?B?R1U5ZnplK2M3cmp4bTJ6V0gyOWl2SnVZdCtJVjJESmxaUDc3c2dNUlNKTTgr?=
 =?utf-8?B?ZktJdmJMRW43cnJvTnMwMy9kN2gzdjIrSWRqdENoWnBNd0pVbjBBaTNHL01x?=
 =?utf-8?B?MGlvUDRPZm1aMnlQSlJ6NUttNmg0bVlITUN0VjEyVUQ2QzJwZmVkRjJRdG1o?=
 =?utf-8?B?OUtaei93dVFXOXYwd1E0K2Vmb01ZTzlkd2hFUW1xU2lnV3padGNWalQ1ZGgr?=
 =?utf-8?B?QmFENTlyU3dva3pqMW9lcm5yTjVKcmNzOUxQOFE4QUVpVnJPYlM3RXdIWlFO?=
 =?utf-8?B?QTlFUE9YaW9RUkZ6Z2l3TWtxWTNPYmNqOCsxSHVaODByeS9YcWpOQXRTT0p4?=
 =?utf-8?B?d1cvbjJxSmo3NjBLQU8vd0p2MHhhOVVPNXVNcTFqNzRCYXA4RHdEN2NBVjlq?=
 =?utf-8?B?U2U2K0poY0JWM3VqclB3UDJWVUZDWkIyUzdKNzQ5WkczQ2VpY2dnZzM4OWd6?=
 =?utf-8?B?cU4xT2dqeEEwMndVczRRMjV1VHZCdVVZT1FBblU2WVlqYjdxM1k5OXNyTTVC?=
 =?utf-8?B?MDVVNlQ4TGtPY1IyRGpkWHJXVnFyWXQ0eElLSXk1Y2xTSDl6N2ZwdXNzMEU2?=
 =?utf-8?B?YzdBc0V5TE4vb05oZkx3RDNWUjc4eXJmSHQrYWNOMStRSGRENG15dHh1dHhQ?=
 =?utf-8?B?endoRndLQjVHK09sWGxpbWoxWmxlbFpDT3ViaGQ3NHRRNC80ak0wNThTVGxi?=
 =?utf-8?B?ZWlpOU9lOGJvV3o2bTJ5V3hia0tBNElrMzF3dDNFcWVnLzErOU8zKzkxYTVT?=
 =?utf-8?B?NUh6SFpaeTh3T1RrYnp5Q016Tzl4TFEvbUh2QnRmTDVUSmJCU0d0ekhhcU1a?=
 =?utf-8?B?L0RLL0pQelBnVFhuQklaTWRUOTlGV1MzQkRjSU16ajV5endKU2VyTzVwQUZS?=
 =?utf-8?B?QmJBMFVNWFFObytNN3hPclJpS3o4QVZ3Mm4yb3NzR0VWTmpnRmo3TlFSdkxE?=
 =?utf-8?B?ZVJNL0hocFcyeUUrcVlQU1lqUWdoYVFWV2I2bFVKUXVKQlc2aTdTTDV6VkRq?=
 =?utf-8?B?cURma2pMSGlRZGhLWWJYMVdIWldOY0lCc2NjL0JoZWxrSzBkK3FnWE9YOFhQ?=
 =?utf-8?B?WXlnUzgyRlppOFR6NkhJZUdBWGtPZFpHcnNMQ3NkRW1Pbm1BMVlPeEUxVmhS?=
 =?utf-8?B?MWJ5bWVKWStSQkh1aFZJdGtDTlVXTWMwRW96VmlZdmVRWUFFWUlkaXZwY2ww?=
 =?utf-8?B?cXdUeUQ4aVFzTmg4TXc1dFFiNk1HWG5PdnEzL3NWMW54RG1aMTdkMmlabkdP?=
 =?utf-8?B?b3MzR3BSU0s5Z3hjd3BFNTZKa2QxQTM4Y0MzOWt6S2t4UmdCTWdGQUNDZ1ZO?=
 =?utf-8?B?QytyR3hjUEpHQUdHeCtVS3p5bkJmSTBCR1VNbTZhK0dOamdMZ3RCbTRQdGRC?=
 =?utf-8?B?cUpOSlFiMVFKVWxpdlltWDhodjBIYjREWDVuSG9GTkZJVHIrc1A1Z1NlR3FB?=
 =?utf-8?B?cGJkQzc2Ym81SFRpZThQM2tWVktudW95bnE3bElOK1F3R2pSOEdkMDBtRm9j?=
 =?utf-8?B?akROYTNmUFFnK2pSc3RZckxuVi9CMHZDWWlLOFFPeXVVMHZMcUlUMlVmTnV4?=
 =?utf-8?B?eFFqc0JZbjJrQi9sYzVIYlJadUZkL1I4UE5YSlI4czJSZHQ4TSsvRC9OdkZO?=
 =?utf-8?B?SndYdzFRS2M0ZkVhRUl2NTJXRC9Ya1d5Mk9BRUk3Q0VlMnNvUWNwNG9PaC9w?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85E92A8A75B5BF4AB786F3833E5FE3C0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D6g8hBHgbvl+f11xkEpVQb/4VRJPWausv8lG4Cg42eClFHtUSG6f8fX335BYdEO8dpi3S3zbQXmfubxJzJeIPNg6n1MJtj9XND/3BAq1YyLM5WVC5JYfaFYx1UjB4bnJNRNnNfIlT/9xPgKxr6ssaJwyWsZUhAeDLq/9+9u/fhCOUY70viq8sGw+8OvstUhbTzXkb50ZrkdTvHEpaNcMVlaIKLOHZOEyQ9+iCiZWTLBmAKyftQ8YldM0yugVZpRXhhWdUzn7TFpoIY2tTFWe6II2L+5QhYuyeWOQxDtd/TPwAIYJvM6JHCFGcP9lDWwTh9VpTcxP/lL+5bA3xjkroWr/5sE4fgywvS5pE+BL5cBSdcz6UyiblE6qkIGoR3+nqMbCODK6r+tT5B/xSK2vm5XDTi0BfVLR6I97QPKXF+7DNQ/8TBN/xta/rZNaAXNJJnngfIwWifCQyUuWY/qOaxy/oQbt1ZAjdqGB3VBzNccx6dmPERUSePErHN+cTuOTX6yXWfKZgZ5Cp10BCOg+NBC2hH77Z4RuubalhsDUdc6xa2JCzD0Lm0BwcoyI2fInbtRmFOFWYmfb5yPeU295uzvahxytJHCvdbE7ZsOdvJaMJQIjkRr+7dkrLYcPfGMh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 065b8500-1aa3-4b09-8c9b-08ddcde51316
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 14:43:10.7348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +tHQuRiJUbTDyBlLix1i0yE2nT2MEtZX3o5Xq45bLPr7E5DIRnYSG1JguRZXUdsUEIiPFUSViNtH2rRAg2faE2vpMnnxDQTJ7EjIEfjFeFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7570

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

