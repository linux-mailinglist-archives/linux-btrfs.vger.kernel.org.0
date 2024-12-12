Return-Path: <linux-btrfs+bounces-10314-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 141E79EE3CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 11:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3C91888C5B
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 10:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29850211474;
	Thu, 12 Dec 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GMLv6aFT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jSV11iG9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966FF210F60;
	Thu, 12 Dec 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733998220; cv=fail; b=dc+XJ6vkmHZLl7YaKpQS47ggFW2oin9kIHVOQ+ER7kA3UFWq1Bh7yWlc8dAQj1qmHyU6ai0wOqOc0cF0p2nSF8WAyQnf9AyM8QPxv7T5kC4sXX6PoQaBrc5HzmOPIoEPqvzOI2+CVT4q1ZLJ+SvZnWHciGygkj2r8L/MwOQM2gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733998220; c=relaxed/simple;
	bh=rLBbvYhXrsh/EWJXWhkyMsODw3PBQUus0/dUrPOw12Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cmICF6mdxQzqsX7JMbFF3CPm5qA4BWrMP4U5ll9Q/zvtgk7bGO6yJMULYKQineh+bg0y4wQkwPk/KjGmkXw1ZjXjTP7muo2eNY7YzoQNgkwk5SPJ9iYRKxONp4XvFvxDtSeykHDxW7RcT/RiIGAuGJGYJMtJTXmASeuID0xwsIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GMLv6aFT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=jSV11iG9; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733998218; x=1765534218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rLBbvYhXrsh/EWJXWhkyMsODw3PBQUus0/dUrPOw12Q=;
  b=GMLv6aFTYdTmr1HeBFuSHfN5wajtsbCDfxz0TBKxDeyGVMsOx2VlUGN+
   zvGk7DuZeAbtGUhTYzFDa3D76B/g92OtryrTbmk7mlLdgFzWRVc9zd4gh
   uIO0G+Q51D5Q+hGtw/g2PqVCLT4tRiQOPfR4OEC/oisu/pKY7ItxWfiOb
   M7CpsCew30jLLbIJTz8Zb5H7gEKBZjbw8lRn0UE2FueebJFGp4Wf75CD8
   PEpP+g9RhS23hFCvU66Yy9USNRQc07Y+zi/HddRIBaCoUHfEMzSvP7cHh
   039uHbOBwBegOKQZnPU6TGkUPORW/d21fuEpkkldC8LKtOHEoe2VNym/c
   A==;
X-CSE-ConnectionGUID: NGPdmdcxT12a0xuWVH794w==
X-CSE-MsgGUID: tGKa1AhWT0i81Ebn4AjWsw==
X-IronPort-AV: E=Sophos;i="6.12,228,1728921600"; 
   d="scan'208";a="33514080"
Received: from mail-bn8nam11lp2176.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.176])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2024 18:10:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPMN4Z87yU+BnAELYFHXd1hoZkeV94M4X1UKxO4yaWzXP6qIp/ySumkLdrxzHaeTXmu8WTXSNr3IneHXIug71jj6F8B7zWI8rr1fDUsny6FjJjAga6i7ONdNzvTkuxPnLYShdE3RyKI2D4tXhOz5cqvVfRYCGLYwCrwd/b21H/LMlfGL56DhNziW5h8q7X/icC5ajOCJ19fRO8PjSrzVAcP5iOeoFul9hfpOnH4j/cl4OHv4ARHcpnBEHUv1mQ22XDa+LvlwQHqusmgxy/Q84oDch9NXN/kch2z815fJo/pR+UTWug10FKE5jFbgW1kvq9vQJYpn0p3GYJmJeDeRpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLBbvYhXrsh/EWJXWhkyMsODw3PBQUus0/dUrPOw12Q=;
 b=is82/0CxQBq1n6wFEXaf/SxqJ8jzBFjBkgev6oiKH5ic1489WXybMTM57UgSQU6kXzV8pDMMZgp3IpWAxhUoymymrlrt0EOLE5euv9CZU5QZi0nM3AMwaw45LiEywbScGlc7Vinw/VWTm5EUnjgD0PhYOlqyN3earebpsZvvIlGoU6vL/hQbEkFosENqGcRAeQEAF0vqh+WlrRqs2mMjFanGHL+35EfA0ClKu0KPcKv3D6evL2JdySjA/7DxxQg1Y2MgslRivDiKTlFymixzl7M+NXC8e+xqobe/V/4NW9OOg0FHej8XU7uGEGPWcfqK12a0pXjXIJv38i8+31lPRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLBbvYhXrsh/EWJXWhkyMsODw3PBQUus0/dUrPOw12Q=;
 b=jSV11iG9C6+/A2S6o58klY9fVVrJLKIuwnPbS4UGQIUwRMNn6iewMVnuxSs502XMKdIoALJp9kfCXzF/rHEJgJbZisUumw2fkgkNLkkM0mVvyrQnESO1HJWVjIRT3Cr4nrcXpBn9B41u0ARjF0YaLhyJOBn9jY9+Xnp8Kn8NpPc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7699.namprd04.prod.outlook.com (2603:10b6:303:b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Thu, 12 Dec
 2024 10:10:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8230.010; Thu, 12 Dec 2024
 10:10:08 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Daniel Vacek <neelx@suse.com>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark
 Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Omar
 Sandoval <osandov@fb.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH] btrfs: fix a race in encoded read
Thread-Topic: [PATCH] btrfs: fix a race in encoded read
Thread-Index:
 AQHbTGsKZcn7mGCkaEKERxWN6qbNxrLiPuOAgAAO24CAAAJwAIAAAbCAgAABooCAAAXUgIAACeAA
Date: Thu, 12 Dec 2024 10:10:08 +0000
Message-ID: <a8047d3a-ab45-42f0-8c60-f00829e40518@wdc.com>
References: <20241212075303.2538880-1-neelx@suse.com>
 <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
 <CAPjX3FcAZM4dSbnMkTpJPNJMcPDxKbEMwbg3ScaTWVg+5JqfDg@mail.gmail.com>
 <133f4cb5-516d-4e11-b03a-d2007ff667ee@wdc.com>
 <CAPjX3FchmM24-Afv7ueeK-Z1zBYivfj4yKXhVq6bARiGjqQOwQ@mail.gmail.com>
 <9d5b4776-e3c8-449c-bb0d-c200a1f76603@wdc.com>
 <CAPjX3FdU1mOkRr+JVE+S4og4NvjFerZhHC_qupFBTgjn9=s8MA@mail.gmail.com>
In-Reply-To:
 <CAPjX3FdU1mOkRr+JVE+S4og4NvjFerZhHC_qupFBTgjn9=s8MA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7699:EE_
x-ms-office365-filtering-correlation-id: e00b8cd3-9719-4576-ea57-08dd1a952863
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bzJwc3pUMjFSY2hzdlpxdUdzYjU0UWR3dVVmQ29wTkJyYnVUR2JuWUtYWDQy?=
 =?utf-8?B?V0M4SFhiTWh4ek1aMmVBbzFybVdNU25pVzh3ZXZxRDF6Sk1zRHB5UGpvNXBQ?=
 =?utf-8?B?aFBKdDZjdVdCQXVLOTNCYnRuMTdVdXZscVVQY0xsRmpKMUxWajg2cVhERkRN?=
 =?utf-8?B?Ymljc3BYS01WM2VkdG5hdkdYUlFLUGNJQU84aE5CK2xDWFNKVW83c3MrYkkx?=
 =?utf-8?B?L0NueWFZRzFBbDh3WFRTT0xtUDBVcnhIZG1pN0d5Q0gwWW5EaENQS1ZIdXN3?=
 =?utf-8?B?eTlVWFkvKytWbFlyWlBPRk84OXcvZ1ZJYmlvd3Uzc2hKRTZ0UEVHQ0ZwTWw5?=
 =?utf-8?B?V2dEcHl4RG1kaUJvVEl6dFdxeElqQTVSNFRGdGRnQzBTUUF4QUptVjZmaE1C?=
 =?utf-8?B?M3NDZ3hHdjlyZERGeDdZckJSNEhoMStCaE5IVUcrcXpaNGJlSmt2Z1YrMkRi?=
 =?utf-8?B?a0lhTUhNSVhRakQ0R1ZTcmRjRnIzQmlaWUpCa1dicTRHcnhHc3FBMDAwamE5?=
 =?utf-8?B?dlFGVzRiTmVtZkFhMkRiTjF0VW5rR3dtcVh6NFMycUFjKzVobVZrY29BN3JZ?=
 =?utf-8?B?UTRKMWVlRktQbWt1ZlVHaDVMeFJ3bTQvNWx6cERZVUd3djQxVGRYOG5YeG9B?=
 =?utf-8?B?TENSWGxmKzdmNTBqL0grWnV3UTZpWU04MUpIMXQ4U25xM1RodlJzRHVaRjZm?=
 =?utf-8?B?d2JUT2p2WGRyR3Y0NXFnVXo1OW1ZTWxtYjZXY0tqeW0wTlRTQ1BabmwrSXBv?=
 =?utf-8?B?QWZ3NEt5ZjNJY3hvNlRDRHM3elNvSFBYMjdWbGxaQTFhWG5zWXpvZ1BzenZ5?=
 =?utf-8?B?U2g0b1hpN3lnclRwK2wwU3BoeThTLzlRNlBnUmcrT21NVVVOWjd6WU8vVmxO?=
 =?utf-8?B?dk1VRTVjbkZ1anhUK1NiNEtiemhaNUFIR3pIeEVpOUswbHJQQy9HelllS25k?=
 =?utf-8?B?ODVTK2U4VkdQZjIzQ0krNVNvMk5oYjJ3NzdubjBGMCtld0c1RjROSkVKZHRC?=
 =?utf-8?B?Umw4czZSZ2tkb0VKT2J3Y0ZQS05OOTFZZ3lqN0xtTjdTNXNMUDRoV0taNFd2?=
 =?utf-8?B?UWRIaEUrRFFJc1Q2Ty9Dd2U1ZVlUbzV4YlZ0MVgydmxXL3RDc2JTOElTMnN5?=
 =?utf-8?B?eHVRMEo3V1NFaThhNDM0NG5Cam9Zbm1sOGNSaktaa1NXNVp4cGIzc0Jjc2x5?=
 =?utf-8?B?VDdlMHhncEFWMEJBaVBBZnVHMHg2Ym1CMmZWSVArb0dHMitydWluMUI0VWpC?=
 =?utf-8?B?eTJ3N2lwTWIzZDBtaXEyWW1pa1d1ekw5dVN5bXpibXlYZGE3ZmUrejF6Vys5?=
 =?utf-8?B?VFBDenNkeFRYdS9ZeXVGKzQvZTY1bi9iZUNuVzZXU2RFei9PbmpTUDNIUVNj?=
 =?utf-8?B?TWt1TjBxcHpIVTVCWEoySUU3N2dEUHE2LzBBOEd6WmF4K2pEWkJqK2ZoYnBU?=
 =?utf-8?B?ZWJhWVFmbXc1ak45OHduUUZEbDNlVmY2MFhaMVJDZEZsa0dHOTZmMDI3NW54?=
 =?utf-8?B?MWVwTXEzYWp5VW5HY1oyLy9uQjhZRWE4dngweDhCWVFMRzE1RVBIa2tUVlpD?=
 =?utf-8?B?L0s1SUlDc2NLcVhCS2pLM2tBemd4b1RnZDZ4dTBmdTRoaE1LK3g4QnpUQW5a?=
 =?utf-8?B?NEVxUEVGanBDc05VQUpFRytYWitENnhTS0ttZzhHUnVRVnlaR0ZxVzIxQmR2?=
 =?utf-8?B?QktDcThMemtQVXpQOEd6cFFkbVBtMzBoYUx2a202WnkyQ3dydmhUOWtnZ1g4?=
 =?utf-8?B?UmZabitSUXN1dkh5dTFpVVczSjdaQTFacE5XSmp4QVBCQUJGZEVPUzJGd0Nk?=
 =?utf-8?B?YmR4SGVHWVFRSGRrbnF6OXBac2dIWjFaNTJNNDIxOTlqZEc3MTV3M2Y0bSsr?=
 =?utf-8?B?b1UybDl3YXBVcW82blV3cEpuVUx6b0hDK1lGNEU3TWFTcnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bVJsRkcvQzBSWlFSTlprQlNJUisrR0hoaElFb1djcC9hZWJuYVJOUHFKaWNk?=
 =?utf-8?B?ZDNXbENXSm8rY01WNjVxVjVOMHdpMG9sNGloY2hMaEh5cmhNL0UxQ1VoSG5z?=
 =?utf-8?B?MG9VZVdvV0tUM1d0bFNHNVZXTXN4d3p6V0d3Qm5YWEQzOVdKMml5c0J4WU14?=
 =?utf-8?B?djVvTGFRRnBFWmJqOWdVRjEwNUVVYkZpMHhQSTUyb0F4aFMyT3ZFS0t2azNZ?=
 =?utf-8?B?ZTBoSTRneVdKSm9JZlJDUmo4S0NaV25UcFZBY0c1eWg5NWtLU2ZBK05OaFZV?=
 =?utf-8?B?UVZFd1NrOXdWaks4U0NiY3lDd09BS0Y1LzAxcWM1Qncwc2U2VVlObFlxY1dW?=
 =?utf-8?B?cGJZekVJNW9paEh5WlIveXZYMGZIazhBZEdqcWhJbk9PbThBUVE5NjlVUFFJ?=
 =?utf-8?B?R3Bja053eERXT0U0QzRGeWFYUmlVWmRVa2NJSnoxNVRCWWhlNUhQNnBidzBw?=
 =?utf-8?B?SkRnVkpIeUlJc3g3YStKZXUvVzBkUW1OUXpSUWxtV2RtQTRhcVc2a1QvV1V5?=
 =?utf-8?B?bHpVbVpiTG1sd29EZlNiOXhzTmtIbkhybTAwZDFLVGFIbmJ3Z2ZPTCtmMlRx?=
 =?utf-8?B?YXk2bkx0bDluTFRWMlI4Sk83T3BKSG4vblErOHBBOCttVStyb0NtQnBnQTZ6?=
 =?utf-8?B?YnNuTWxmZGNhaXNuMHdyTTNzbS9OaEs4eDhuVFo4Si9jR3RJTUZwaE00UEhu?=
 =?utf-8?B?SzErU0hkam1BdXFuSW1HQmdHYmh3TGwwQlJoaHB6L3hUc1FnenJkNGhxdXJq?=
 =?utf-8?B?akcxV1ZaMkk3dFRYME5TUU12dC9iWUtOdXBpQkFVQkptSGJhYUp0VzNTdmxG?=
 =?utf-8?B?TE43aFMxYXJOY2R2Mnc5YzRKOG1tTXlxcW9uN1dCQTdaQXFCUXlyeFpCRVU3?=
 =?utf-8?B?bmJWVHJNZjJxMVVZUk9saWVXSnhpNFZVc2Q2Rk0wUjZodDJFRFhxa2wrMTNo?=
 =?utf-8?B?YWRabnVDdG1UNmltczNDenVxYWo2M2QrMFdTR2s4MHRoRm5SbE1ORTM5RWlP?=
 =?utf-8?B?SzI1cTN5ZjlvaW9Hakk5cFEra1gvQVowLzhjeHkwbjhBZytKMU1sRGhmdEVv?=
 =?utf-8?B?OUdOUzUwdndXZnFjT2t6QytNSVpIeFZ6OTNKeVhGMXNYTHdnbXdoTlZHYStu?=
 =?utf-8?B?UUZQTDljaW5HMDVXQ2ZnaytubWRwMGJpZEhpZ1g1NG8xWmxYZmJRbUNPWmpt?=
 =?utf-8?B?UldEWWE3TzlzbnJoK1MrRUV0S2VwaS9tU0pEUWFPNzlRNWpMS1cvcWZ1ZVB6?=
 =?utf-8?B?SW1GUDI3dmJOUkpWQmZWWjMvdXNSWGNiYjdXU1VzY01TQUpaOFhSSzRvK3hy?=
 =?utf-8?B?aDh4NFYvMXdkc3REaW4vQUFFMUdMRytYYmFMbjd2bXR3UUVSQ0lkdHVGOEhv?=
 =?utf-8?B?cklHam8rSmFXOWZ1ZDV1aDJRTEFVdVRTcnRBOFZTS3ZpVGNnN2Z5VkMxWXpk?=
 =?utf-8?B?TTNHdjRJaWF2cmF5R3lzb045VXdIK0pZSnY0ams3UEc4MVI2MHdZTzN1L01k?=
 =?utf-8?B?SmloZVFTNFg5ZSthYS9xYlhnR2NPZUZxYncvbDFWT2FsZWlZbUhNdWhJTWZY?=
 =?utf-8?B?Y1dvdys4cWM3Sm83WlN3V3hyZDVtdHB1Wkhqd0ZzdHJ2NER4NkE1aHV5Ykx1?=
 =?utf-8?B?Z3ZxUEx0VTg0bWJRQVgwUm0zcTNZZndjQXNuVHNGOVhCMnptdWQvLzBxVkh5?=
 =?utf-8?B?dGkrZ242bmxNMTl2S3JKWDR0VTViVXJuWXlxUlEwckVkcittYW1YNnk2UUZJ?=
 =?utf-8?B?ZWxuWDI3RkR0bWxDcmN5YTRSQ2MvdW1OZ0NTSDdqSm9hR2I0cFg4eHBoZURR?=
 =?utf-8?B?SWl1QSt4eEo1aDJUUzk3UjMrczhTUEI4Z1RuRWdaRFBLb1BSYmVuVHh1eFJk?=
 =?utf-8?B?WVljUG4xNEJBZUxwMGRoU3YxL1RyNGtXbW4rOFRIeTlLWnQ5NzkxR05ZVytr?=
 =?utf-8?B?dkFOZHArN3dJeXJQTlpjQ2JoMnNoaEFYWmRURWlzNGJ4VDJrSUF0R0hnK2xy?=
 =?utf-8?B?bHVqdnVXL2RxT21Nczh4VURlSmJtNEtoeXdjWTlja0s0U2pnaFk0b01VZXo0?=
 =?utf-8?B?ZGdZMml3VmpCa1NxQmJPT3dEZ2tKZXRLTUdWM0pXN21CMFFvT0JEVHB4YXJ4?=
 =?utf-8?B?QytmWDFQdHZidmVEbXZ0MU9YblRwekl0OUZVV2JWZDlzVk9McWRlT2lHSEJC?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD47F3C94CFBAE4A98D8DB4BF3A437A1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iXE01sw0jn9gOG8aAvKVlX9PwtTHxPxAlMpm8Ir+ZtEN/ApXLTzJAerfuB0+EZo9qB93tsJzFyUsZzawntJvDqax3SUolT1h7SVXnNDrytjM9yIo/lelK6wOV/jhEOeTzAzGNLdqPoaHCa2paFtyPCxyEXPStm8WrW1q94zlomMMj7k/5rTb76miYjHNLXdL6JJEax7oXfUA9+oYbLOVH+crqcKfDLRx4AQkqDLemdVEh688v3dCKqcl9OHh1i6/iejPu3yfNdUqAARUIlu3xzfLtAWkARsYVubQXi4gMzIFXglHlfbkHetdztoqknn/6ctq2TTJsDslZg3qkJ9ZI+/rja0qj0M8Eh1xrlvg6lbeDfz2vuuJcuzicxFnWsS/PO38vVqL91ZrWpeHKOrheruNryViSdk05YMeetRVdiEvUIE7HC82y8kehB2CFAk2TOn2QMY5C5uY8lKbEVX14utYBMbX8t07SBUvg4s5buOpJWBsuDIvBAZWwxW+vcpJ10/NpzxVRjXYtdGkVlkLOYLU1UvLRjeIAxlQ5aILBfn9ZEl87YH8aUMgFMqoh2vgl07d6Sf42OYPhCPWBhzZymG1NpClbmG3SlHa0+3b5UySe473gi5OBVTnhl2k1l9z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00b8cd3-9719-4576-ea57-08dd1a952863
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 10:10:08.6067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jv37lmQX/6mSnsqsW4IJjS5dUnMrRXCef5vCs5EZjO4dA5NRjAJs11Q5PM6IpzGjP7H1mtvKj2/g3FQlqLZeILPeme/FuPVfcKmw6jGOYdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7699

T24gMTIuMTIuMjQgMTA6MzUsIERhbmllbCBWYWNlayB3cm90ZToNCj4gT24gVGh1LCBEZWMgMTIs
IDIwMjQgYXQgMTA6MTTigK9BTSBKb2hhbm5lcyBUaHVtc2hpcm4NCj4gPEpvaGFubmVzLlRodW1z
aGlybkB3ZGMuY29tPiB3cm90ZToNCj4+IEl0IGdvdCByZWNlbnRseSBmb3JjZSBwdXNoZWQsIDM0
NzI1MDI4ZWM1NTAwMDE4ZjFjYjViZmQ1NWM2NjljN2JiZjEzNDYNCj4+IGl0IGlzIG5vdywgc29y
cnkuDQo+IA0KPiBZZWFoLCB0aGlzIGxvb2tzIHZlcnkgc2ltaWxhciBhbmQgaXQgc2hvdWxkIGZp
eCB0aGUgYnVnIGFzIHdlbGwuIEluDQo+IGZhY3QgdGhlIGZpeCBwYXJ0IGxvb2tzIGV4YWN0bHkg
dGhlIHNhbWUsIEkganVzdCBhbHNvIGNoYW5nZWQgdGhlDQo+IHNsYWIvc3RhY2sgYWxsb2NhdGlv
biB3aGlsZSB5b3UgY2hhbmdlZCB0aGUgYXRvbWljL3JlZmNvdW50LiBCdXQgdGhlc2UNCj4gYXJl
IHVucmVsYXRlZCwgSUlVQy4gSSBhY3R1YWxseSBwbGFubmVkIHRvIHNwbGl0IGl0IGludG8gdHdv
IHBhdGNoZXMNCj4gYnV0IERhdmlkIHRvbGQgbWUgaXQncyBub3QgbmVjZXNzYXJ5IGFuZCBJIHNo
b3VsZCBzZW5kIGl0IGFzIGl0IGlzLg0KPiANCj4gSnVzdCBuaXRwaWNraW5nIGFib3V0IHlvdXIg
cGF0Y2gsIHRoZSBzdWJqZWN0IHNheXMgc2ltcGxpZnkgd2hpbGUgSQ0KPiBkb24ndCByZWFsbHkg
c2VlIGFueSBzaW1wbGlmaWNhdGlvbi4NCj4gQWxzbyBpdCBkb2VzIG5vdCBtZW50aW9uIHRoZSBV
QUYgYnVnIGxlYWRpbmcgdG8gY3Jhc2hlcyBpdCBmaXhlcywNCj4gbWlzc2luZyB0aGUgRml4ZXM6
IGFuZCBDQzogc3RhYmxlIHRhZ3MuDQo+IA0KPiBXaGF0IGRvIHdlIGRvIG5vdz8NCg0KSSB0aGlu
ayBpdCdzIHVwIHRvIERhdmlkIGlmIGhlIHdhbnQncyB0byBzZW5kIHRoZSBwYXRjaCBmb3IgdGhp
cyByYyBvciANCm5vdC4gSW4gbXkgdGVzdCBlbnZpcm9ubWVudCB0aGUgcGFydCB0aGF0IHdlbnQg
dXBzdHJlYW0gd2FzIHN1ZmZpY2llbnQgDQp0byBmaXggdGhlIFVBRiwgc28gdGhpcyB3YXMgdGhl
IHBhcnQgdGhhdCBhY3R1YWxseSB3ZW50IHRvIExpbnVzIGZpcnN0Lg0KDQpARGF2ZSBjYW4geW91
IHNlbmQgJzM0NzI1MDI4ZWM1NSAoImJ0cmZzOiBzaW1wbGlmeSB3YWl0aW5nIGZvciBlbmNvZGVk
IA0KcmVhZCBlbmRpb3MiKScgaW4gdGhlIG5leHQgUFI/IEkgY2FuIHVwZGF0ZSB0aGUgRml4ZXMg
dGFnLg0K

