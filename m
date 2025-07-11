Return-Path: <linux-btrfs+bounces-15445-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 875A9B014DE
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 09:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473A93A956B
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 07:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039011F1301;
	Fri, 11 Jul 2025 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V09mRIU3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bKqKYBPp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2481F0985
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 07:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752219649; cv=fail; b=ZMKUwfBJvABuAjVTbuy0JJzsuQwEqaDdgzSzLlcA91iobUB7SZZMhkbKqd6fBq4X/GhxfqM+sDqYXbULUhcUCpTcjpL0D5FynwwveQ8la8AwoJs22DvVZfH7pH2Ph3Z6/W7NxiNxeAWhYOBWjLRgQ9QpRGMjoOch831fNpNYxuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752219649; c=relaxed/simple;
	bh=gCPc12mIxh9a5ghBmEyp+8eb7Fm/CUSM7ubJbKGfneo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e2ewjxtsA/6h9gS+nXGnZpVndjktVCZIwJ6LVOJxy/AdmE7XZhtR6bWcCBfL4INBTbdfJcnVdNily8zx0fhT+94f9PSctG+6ASocPRs5CsxiFe64MtEjtLlP7pV3btzf+pyDc26zLLCmKhTqrBI7lFdmZaYkS2LI/hjmhiyQscA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=V09mRIU3; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bKqKYBPp; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752219647; x=1783755647;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=gCPc12mIxh9a5ghBmEyp+8eb7Fm/CUSM7ubJbKGfneo=;
  b=V09mRIU3NmTElmG04XRtODc1gxkt7Jmil2Z8lLen6h7XynDnNITUA3sZ
   ytFEKhqD83ZZ2k6Mi8H2Z/C4FofhODT5WfYAaRTKr2DKiq+JDEqEXuwEY
   OPWLOwkarbGH9/eyG/cEv8mkwiu4HPdKth8miqDmxfAAQCqPxi0mwZygn
   DDQWvGoamBCdVXgYzvvS51aKnvQL8+k01Nu+4yW1E9esIoUEUMXQqqOCw
   gj+xjG2B5trtdS9+yVdB7yDLWhKcgtWtGjJ6OmC4crrzC1ZcYrzG491Sh
   8UEHXDcuhvVgSUmp90jIf13UBhEQBSt2OsVJlErAdsAc9v5a1+xtJl7on
   g==;
X-CSE-ConnectionGUID: XiLYNpkbRNWIyaTAfenkVw==
X-CSE-MsgGUID: sYsX97LiR+acQ3XTas8xNw==
X-IronPort-AV: E=Sophos;i="6.16,303,1744041600"; 
   d="scan'208";a="86372211"
Received: from mail-co1nam11on2071.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([40.107.220.71])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2025 15:40:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmPKjCgJTplzRIO3pY/1u5gaFmn9RvS2htKU02i8aeiRBFnA2yK+gzxxkSetLwDmZT/A9dHr402/ObNtAYA2WYEV3hBHQJ1QHYhDStNAFB1BdWYV+7cbqJ5vJ3ZlVdEVrOIhNFbss93qtF1X5Npuo6zVmp/wL7cgkJlvbINfh5QrfPezFaPouRJb+y0zRw+WXrC3wQAG2t1s+gqtzdCEVFt3QOw9ht/3aC//q/fvvH56XdUsYPJ1yK8xJ5UUWtNVbt11QFBXU7BALcRJzrash7zIEN9gyONEIALq5EWffgDhqIg4ZM8g0xtTSc0gp/Y+kyzIVm4ftziy0muNL2kjLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCPc12mIxh9a5ghBmEyp+8eb7Fm/CUSM7ubJbKGfneo=;
 b=dsrpbFZSaQxxncfoFDmoIn66dfz5iLXmHc6rpM64uwJXXAGQFGT8zMoqtaI9kTkMgOV2Hhj2XDVKdukskx1f7n35ed4GhuWHhIZ+tQIElE7llBdP/NTKNMbf1e0xoUIoQaf6X3pWguBhr3gxSozaMZdRi5NzKIbSWLTtx9vTmM9mr32xv9ljqq9jlgg8PuGzEgIsNemomJNdMDti7sIWO0fHQC0jzEx1J+comS5LH22lEVBKfarv7CZ/D8IFBafZXA35zZW190YGMwOZiVDHNwRyJf31G7t5bg39IelJG5G7eaTtiDUlxQgoQCWkcGHf7aMeWq6Hn/W66wFrkptESQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCPc12mIxh9a5ghBmEyp+8eb7Fm/CUSM7ubJbKGfneo=;
 b=bKqKYBPph2YgHwr6Yse4IwBgKJtTfWiEBaNcLx7bOp8sxEhRtLgBWnpml0rjxrmWX+s8/J7sE1FpV7sc3OX1pdM6LZc4/myyhIF5z9BPtkY6npCkLBy0x68tVe00RVe5E1pmFybEBzjj5hno7SbLwj/J8diHJDMb8ehUKRmqbNA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7712.namprd04.prod.outlook.com (2603:10b6:a03:32d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 07:40:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 07:40:35 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: set EXTENT_NORESERVE before range unlock in
 btrfs_truncate_block()
Thread-Topic: [PATCH] btrfs: set EXTENT_NORESERVE before range unlock in
 btrfs_truncate_block()
Thread-Index: AQHb8KsiZFRsiQXWYEywL8Ajjf2cHLQsjNaA
Date: Fri, 11 Jul 2025 07:40:35 +0000
Message-ID: <906e355a-134d-4edb-bba3-07c7a5df799c@wdc.com>
References:
 <b780ff5c6ffae11065555177e508a1c78cdf9ad9.1752049280.git.fdmanana@suse.com>
In-Reply-To:
 <b780ff5c6ffae11065555177e508a1c78cdf9ad9.1752049280.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7712:EE_
x-ms-office365-filtering-correlation-id: 1faa1e11-1439-41aa-afec-08ddc04e393e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?enlZYUNtUHBnWnZIYUUydElzRXJCSGwxekU3MzlUWUJndjdhRVRqS2gyU2hY?=
 =?utf-8?B?WkhsVXlOQ2hjVWZTZnNUSWwrRHlYMStId0VnSVdIWHE2QVRSOTYzc1VnNTZz?=
 =?utf-8?B?aDdLQjkwZVBlOGkyWTlJMWwwM1MvUTFrd0haQ0JDTmNxelp2NUFIU3VndlRx?=
 =?utf-8?B?YTdXSkpBU0Z6YUxzcHF0bHFITEwrM01BaGhZNzhISkhTUW9reVRJZk4wWVdR?=
 =?utf-8?B?Z0tVY2w1S1I2U1dUMHg2N3ZSWmZtRnNqMnVUYWU4b2IydWZBZ3JIK2tFeFpn?=
 =?utf-8?B?dU9SSitub0p2cnVZL0pXYzdZM2J2VEJPaVBCb2NnaFEzQUtXT2owb1NNejA3?=
 =?utf-8?B?Z3JVK0FIdi9sSUdhTDhmWlJFbUNTOWJqWk5EQ1ZrcjR2dnl1aXV4ZXMydCs5?=
 =?utf-8?B?azltS2I2U25ibDZYTVc2ajhGYngxRDAxWWpaZ1ltOHBXK1l2ZGl0dldKSWFY?=
 =?utf-8?B?Vzk2ck9DRWZXeGloSHJWcEtIZXlldjFFNlU1ODNlTWxZY2w4eUplVngxOCsy?=
 =?utf-8?B?MUZERnFhUGlBeVcwV2Zoc3lyQmlOcGVBRjdhYjlVTEUvUjBBWk4yWmJkV3da?=
 =?utf-8?B?QkhrL25lUVNMQkxjUVRhcUszb3krZkRXUHNZbGxFOTk1bnhYSCtKejBvK0xP?=
 =?utf-8?B?ZW83UlNZVjJIUDhTeWw0S3dzS1FzMi9LYWMvVGFSV1ZKOE5uTDI5MmV4MklL?=
 =?utf-8?B?bFd4bjBuc2pranN3NjBwTTlCcitCYUZuMEpzaE5MUHJ2VW15SnJ6YTU1eHRM?=
 =?utf-8?B?UHZWK0R2SVdhYUxDRlR3dDBSUyt0aFo4dFNDc05HYjVQeVhoYS93N0dObTI3?=
 =?utf-8?B?ZXB4U210TFRSTGRjL1NTN25JaGJRWlFJOWUxaDdkNUw4RXdUUXBrWTNJQS9E?=
 =?utf-8?B?VFd6ZitCOTNzNldWSStLdzk4Mzh3NWp3UUh3dnZzdUlBUU13bzRqUWZPMm1y?=
 =?utf-8?B?RjB2aVpnTllXdE9BZ1NONDl6Y09KQklVeThNZ3EyNHZJbFFXcjZCcEp6T00x?=
 =?utf-8?B?S0t6dE9sQUtkSjcvNGh1dnNFcHJkaS9LdnZjMktGcUNTSXc3RUpCZ2NUdlRM?=
 =?utf-8?B?N1l5WDZJdkF2V254Tk5aRElzUkYrMTljS2c5T0NFcEQzYThkSHdmcGdudFFE?=
 =?utf-8?B?a0RGNFR3ZXlwdzNrdHJjWTBwQ0RsY01oS2J1bFBUbEhML0JXR3d4SFBYa3dM?=
 =?utf-8?B?ZXpTdGljMU9mS25kSlhSeWY3T2RxTTBwSHkwTHIvRGQwUWRtNnNINDdyWS9u?=
 =?utf-8?B?dGZRQzc5RkU0SUt0cWtMc3lBTmlTVHlVS3llc0xoRWQ2Rjl4VjFQTWFtS1hy?=
 =?utf-8?B?ZERnUFFXaWlpV0U0c0VnOGh1N2NYUThRYmlXVHZXalR3cWlZZW05QjlpODFJ?=
 =?utf-8?B?QUhCWW5WUUdFVTVRR1J6c2oveWxZVjh1K1NqQy94eUpralErMW1XRlpBS3Jx?=
 =?utf-8?B?TDBZMEpoVmZHRjk5akhMZkFoYlBrOENJeUZ3NFhlK0xmSVRyWi9ZZWh5am1C?=
 =?utf-8?B?bGZZTm5GNVVIa0pVZ3cyMDNXWUVHUWlDNUVQK0h2Wm5iZG5YZko0MmlFY2FU?=
 =?utf-8?B?NXN1S1ZvelEwQjVEZ3crRWhnVzBuWitjWTlrdDhBYzhBVmNWV0VFK1EzQ3Vk?=
 =?utf-8?B?bS9Mc3Mvcm1HVlFvamRmbkFuaXlPWm9NdFZyL2pPRjRTTTZFQzNTK0crdXVH?=
 =?utf-8?B?NEdFVDRnQTQydjdKc2tzR2YyZENZc0hOQXorZTg5cmxCLy84cEtydFFEZmxF?=
 =?utf-8?B?MGFjWTRoVkxpTVcwZmZMeUEzWkhhcDdkWjhTQXordzlkZGRScEwva2pVNHpY?=
 =?utf-8?B?T2poNVVEWHY5TGRUQktYUFU5ZTN5bTZXVmNCV2hjMENMRjVoUG1RTXpPdms4?=
 =?utf-8?B?NTZaeGVLL05OTXlRNjFya1dMd25VOWhKN1d5ME85emZvbUZOd2hUUXlBZFc5?=
 =?utf-8?B?UUxUc05NaHd6VWNtYmc4My8yY1NKaEJUa00rcC92S2x0SnlHS0tVRE96WlJq?=
 =?utf-8?B?Z2hYdFljZ2hRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1JzTThYM20yeEk2ZlJCSEpjWEs0QnFOSjlZblNVVmVXaS9sMk1lQlZqbjBM?=
 =?utf-8?B?V09lUmJHbkxpeWZPeUJWaERJbGppbDdwUEFhN2ZaZGdTWEtWY2Y0T3QwZ1lx?=
 =?utf-8?B?ZHZIWEVzak12V2JnV3M0QVcxSFR2U1hjZG1lcHFJYVRnenoyZFBGeWdmeTJG?=
 =?utf-8?B?ZWtXSGJiN3RkQU91UndDUSs5QjhWT0ZIWGdCMFNWcGFVYk5abTlpV1BMMVhX?=
 =?utf-8?B?bmR4WXBWZjZEdTlkTGdvNXRPb0tnaTYrU2dQc3djQVQrbHhrV0RqclRuYUJv?=
 =?utf-8?B?ZDh5dlVaZnpyOGw1MDdYRnNFeFdLeWJFb2Z1SDBSNHJQMEtvd0dxYXl6VnBS?=
 =?utf-8?B?ZldaK2V2MWlpcWdVUEdqenFaSjIyY2xPM0JEd2J5NjJ3aVRFb3V3bytuNUZo?=
 =?utf-8?B?eHlQRzFOQ2lONzlrUEdtTWt2QWtNV0hHVTMxNk9meFBkMWFzb3lHa0trMXp2?=
 =?utf-8?B?UWZyQzdQK1lZbjZaRFJHN3YyanhscEMyZS8wbmRlRHdYSkh6MCtSZFR3R1Rj?=
 =?utf-8?B?blJCbFFJa1IzV1NvVldlMUo5Q09PRTY0dU43ek11Z3MyNUJlejZIUFNwYVlQ?=
 =?utf-8?B?S25ZeTdNYm9oZEc3cWk0eUZwV0FpT1BqT1l3ckY3UWdITWhuSTh6WHRiZ1hw?=
 =?utf-8?B?OCtRZThnbkc5UlNDOGVVYThuY0xTTDBEZHJkWjNGb3o0WHVydjZ3U1dmaVg4?=
 =?utf-8?B?dXM3UUQ4Y2FSa3h3b2diSnRXb3lIWDY2bjcxVjhtV0RqZE4xWXkrZmVvRk1r?=
 =?utf-8?B?QTRlM3dDd1d6bGd5eTJ6ZzVLMnRVWlRMSlhaNEdWeUxCcFVFRDU0d2lpSms1?=
 =?utf-8?B?TFZsMGptbjlhTVd2alVqS3kzRkJjZkIybSs4eFdNNVBzT0RaQ2lQaHJ6ZWZq?=
 =?utf-8?B?bUVrU3cxdjFmUlZwaEhaVlRWM0pIcGpnMS9GK3pPQ04vc21vZFZ2LzNWVGhT?=
 =?utf-8?B?WDBaY3BMcVEwZmtHcG9vcXBLU3pYbXVRWmRkYjl6SHRWUnZpVFY1bjBVVUlo?=
 =?utf-8?B?ajE2YXI4WU8rY3RhTU1qaTZWNXE5Q2paZDNYZW5WRTFad085R2NBeTNicVU3?=
 =?utf-8?B?M0pZSGFmZ2w1a2VUdXB1YUV0bkJIRFRGWVN0OE9xUHBvTis5bzhYNGoyVmFL?=
 =?utf-8?B?VUQ1MFRjcnc3eUVWZlJONEpkMGNBcEFsL3dESG1UNTQyWDBXY1BlTG1oWUZ3?=
 =?utf-8?B?YlNpZTI2WmhWOTcvc09VRjR1T1d4WStVVW9nTmRReDlvTFlzd3djZTJUMXFt?=
 =?utf-8?B?cCtoUmNJeFZpeG03OUxHNlZSZ1dVd0ZrdGVGemJiV0ZiUEdxSXl2MlVlczBx?=
 =?utf-8?B?WXF0K2U1Z0NXSnZkYTNmVHZ0eHEwcURiRkpXb0RCc01oRFRUVHN4Ymp4Nm9J?=
 =?utf-8?B?UUNzQzBqdUtFcFhSRXFBNStPT0hPK1o2STNLK2kyRFVaUVRNelphbG8xZ0hz?=
 =?utf-8?B?UXNIa0Nzd2dhUko2Z1gxeXlBeURFWCtMMmZWWnFhM3BXZ2FKTTM0V3lETjla?=
 =?utf-8?B?eFh1VWY5NFVVejlsazduUUdnSHQzS1JlSmZXUC8xKzM3MkxOMHJpV1p0OTF3?=
 =?utf-8?B?SzBPcmVFL0cyRk5tZnROQXB3WjVIdG5DNVVINThaYlZsVER1emFOVmo0T3p6?=
 =?utf-8?B?MGJMTU54NlZMT0hCc0pwaG5zWmtKM0NWdHJHM0tGUVRSQUFIOWFjMGZ6UmJD?=
 =?utf-8?B?V2JHcXlHa2lETnFweXBhbm9VNFFZb2lRNTNwdG8zRHJDbVJFUXVJTkFxSkZi?=
 =?utf-8?B?Y0tpWHVEb0EyeUlCQnZncVhPdkRtbWt3NDJ1VUVxWW8yWThhUGJVMDZPV00z?=
 =?utf-8?B?UEg3a0ZJL0VJcnptWGhBZjNJVWIxeWRKMDRYWWVxSFhocGd3VEwveEdZN2FS?=
 =?utf-8?B?Z3BmcDZJMFg1QS9XemdDaTlwRHkzWVJYMjBYbXpSUkpZUTNabTl1QzZsN0tw?=
 =?utf-8?B?R1dGWUNIcEtKSlU4eWJ3M0tiUDM1amgvanl5SS9CR1FISGpsenBLVGpsZU5V?=
 =?utf-8?B?MUlkOFVTOU9PSHg4eENuL0dhQy9ObEE2VS94Rno2TmdvTUJvN2VSMFNwd0to?=
 =?utf-8?B?OWgzSkdrK2ZEZ3VjRzVqM012VXVzb0wzeWhKUzlNL0FuQUVBUGtkNjF0ajNW?=
 =?utf-8?B?d2t3bjArV2JtMmkxTThoOC9tWjNuc1BTUUN6SllrOEljSXNtcjYzNHBuMCtW?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54307291EFDCCC48AF3C9B29605EC8E5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uFQTwf13Y/1lClVJTQZGRLukBEIqElQ6oWk2VHQHelZrWHCVfqMwea/nziv7PFZcoyEV6uzhSqFvt8el/5XT0RDRg1k3tfUGTlYLcgkmvm2PWPhMRYTUyKTrL2rOPxVR82hXhhSEFFA3SsiwpAp9rfoiLRt0Vs56GfKI0H6LEzDTayALBoFZ71G4siczRmLBZEGbyo9DUeOVuu0ubV0cyGCANLKxvt4AG5Ancq58+RFq3FpAI3k8jB685UcTzewcLEo/KPSpGzclPgYRApo0Ak3yaS2/+XQ97bI9rh4ZIuARkoo7+4K2X/QhqB72MaLfgkZeW6oxwaVL8pUpBcS9bdWBJMWPpR8ieY6ijqq/UMLQkkPyjB9+NcdiKt8rNN8PtyqaHw2+PmCXVHVYnSJYIz4lzT3jgiplxDAAeCZbCRLomIbEVMbLVQcJA2FqL67xunFJ1yvlbLed1Imr+WQZkHmUhzcICCzj4HeEOlIs0Q473w0BptT971Q2CD7B4R2jOKApnX1L33w5V3N76LAPRZC7EGWpHeay0LPotNJHdygAEEvnL/Kg7ApUjn2kZqiooNJSRtT5hxhyjU8agdWVOtJIOwyYgzejB7OaG0V6Vx3EjRT/H67PRGIwamz1XuUQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1faa1e11-1439-41aa-afec-08ddc04e393e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 07:40:35.6569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SKLUrQu2LUt/Z9nkFAPO9XWBKY9EmoOGcLikdPXMihlgsydgbVing6E1uKEEtgQrSu6W/K40m6VjWkv789Ih6vHEPJJXz+Yw7TXL9jIZDgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7712

T24gMDkuMDcuMjUgMTA6MjYsIGZkbWFuYW5hQGtlcm5lbC5vcmcgd3JvdGU6DQo+IEZyb206IEZp
bGlwZSBNYW5hbmEgPGZkbWFuYW5hQHN1c2UuY29tPg0KPiANCj4gU2V0IHRoZSBFWFRFTlRfTk9S
RVNFUlZFIGJpdCBpbiB0aGUgaW8gdHJlZSBiZWZvcmUgdW5sb2NraW5nIHRoZSByYW5nZSBzbw0K
PiB0aGF0IHdlIGNhbiB1c2UgdGhlIGNhY2hlZCBzdGF0ZSBhbmQgc3BlZWR1cCB0aGUgb3BlcmF0
aW9uLCBzaW5jZSB0aGUNCj4gdW5sb2NrIG9wZXJhdGlvbiByZWxlYXNlcyB0aGUgY2FjaGVkIHN0
YXRlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRmlsaXBlIE1hbmFuYSA8ZmRtYW5hbmFAc3VzZS5j
b20+DQo+IC0tLQ0KPiAgIGZzL2J0cmZzL2lub2RlLmMgfCA1ICsrKy0tDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9mcy9idHJmcy9pbm9kZS5jIGIvZnMvYnRyZnMvaW5vZGUuYw0KPiBpbmRleCBkN2EyZWE3ZDEy
MWYuLmQwNjBhNjRmODgwOCAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvaW5vZGUuYw0KPiArKysg
Yi9mcy9idHJmcy9pbm9kZS5jDQo+IEBAIC00OTk5LDExICs0OTk5LDEyIEBAIGludCBidHJmc190
cnVuY2F0ZV9ibG9jayhzdHJ1Y3QgYnRyZnNfaW5vZGUgKmlub2RlLCB1NjQgb2Zmc2V0LCB1NjQg
c3RhcnQsIHU2NCBlDQo+ICAgCQkJCSAgYmxvY2tfZW5kICsgMSAtIGJsb2NrX3N0YXJ0KTsNCj4g
ICAJYnRyZnNfZm9saW9fc2V0X2RpcnR5KGZzX2luZm8sIGZvbGlvLCBibG9ja19zdGFydCwNCj4g
ICAJCQkgICAgICBibG9ja19lbmQgKyAxIC0gYmxvY2tfc3RhcnQpOw0KPiAtCWJ0cmZzX3VubG9j
a19leHRlbnQoaW9fdHJlZSwgYmxvY2tfc3RhcnQsIGJsb2NrX2VuZCwgJmNhY2hlZF9zdGF0ZSk7
DQo+ICAgDQo+ICAgCWlmIChvbmx5X3JlbGVhc2VfbWV0YWRhdGEpDQo+ICAgCQlidHJmc19zZXRf
ZXh0ZW50X2JpdCgmaW5vZGUtPmlvX3RyZWUsIGJsb2NrX3N0YXJ0LCBibG9ja19lbmQsDQo+IC0J
CQkJICAgICBFWFRFTlRfTk9SRVNFUlZFLCBOVUxMKTsNCj4gKwkJCQkgICAgIEVYVEVOVF9OT1JF
U0VSVkUsICZjYWNoZWRfc3RhdGUpOw0KPiArDQo+ICsJYnRyZnNfdW5sb2NrX2V4dGVudChpb190
cmVlLCBibG9ja19zdGFydCwgYmxvY2tfZW5kLCAmY2FjaGVkX3N0YXRlKTsNCj4gICANCj4gICBv
dXRfdW5sb2NrOg0KPiAgIAlpZiAocmV0KSB7DQoNCg0KTG9va3MgZ29vZCBidXQgSSdtIG5vIHNw
ZWNpYWxpc3QgaW4gdGhpcyBhcmVhOg0KDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJu
IDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0KQnV0IHdoYXQgSSd2ZSBmb3VuZCB3aGls
ZSByZXZpZXdpbmcgaXMsIHRoYXQgbm9uZSBvZiB0aGUgY2FsbGVycyBvZiANCididHJmc19jbGVh
cl9leHRlbnRfYml0X2NoYW5nZXNldCgpJyBjaGVjayB0aGUgcmV0dXJuIHZhbHVlIGJ1dCBpdCBp
cyANCmRlY2xhcmVkIGFzICdzdGF0aWMgaW5saW5lIGludCBidHJmc191bmxvY2tfZXh0ZW50KC4u
LiknLiBTYW1lIGdvZXMgZm9yIA0KJ2J0cmZzX3VubG9ja19kaW9fZXh0ZW50KCknLg0KDQpCdXQg
dGhhdCBoYXMgbm90aGluZyB0byBkbyB3aXRoIHRoaXMgcGF0Y2guDQoNCg==

