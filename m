Return-Path: <linux-btrfs+bounces-6904-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D52FB9424B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 05:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABA92860AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 03:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FE817C77;
	Wed, 31 Jul 2024 03:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bNnp7IMw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QejdrE+H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3077C1C6A8
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 03:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722394996; cv=fail; b=GkgPvuHOzoIGIsYzDi1ijmo8n72mR8EA3+DEP5MsE+r8kj/oITz8UDjezpa9Xc3KajJZtiHu+gtJO3m6nxV+SMdoQydJR9S2OPeyaqp87jV3QGXZjKo7ZXQAovGG2xjOqyj5GGoVmvXV2IR42PONg6g8pl+dLyo+lvODYbI2+ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722394996; c=relaxed/simple;
	bh=chxJfX/OD6cTypVzXbkDkZXDX0w0vKqATUna1h3efNE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tg2GqwIS7bnmGl6J1ONRwJIYWzjJ5ZXg7cXycU7kqUf2z6rOK+jKijaAFZe/YnTHZqnHXtgYi+v+r8lJw7e0zk1sZxq7qkcPmmv6foE6HWQmyh0D0tc2v5iKnIlak7B5pvg9fLPnHNH7gZWDqOxTjsGdvaVtYVLOh/IbxIZ00p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bNnp7IMw; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QejdrE+H; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722394994; x=1753930994;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=chxJfX/OD6cTypVzXbkDkZXDX0w0vKqATUna1h3efNE=;
  b=bNnp7IMwGLAjpkpo330QrgXI+Zsa/mZ2VfwX+nPRl9wcF58ocbx5pZ1s
   forGvIvES/9OJs7hKabQ00i6wkTW4nesg9wZPm/r4/VpKj1rdx81AG4bJ
   5dzhFTG4H1McqKBgbsYyZm9A1WOPehX5s2l3kc+xyrJfKc+Op+E4VOFj6
   LKCwvxH6XMC8lRS7HQYDH+NG0oY3/4SpYU8miDb9PnJMzyJtbGqqGuFqM
   hzBTnW2xBrbepMbnMA5lsVn1ouEcpz/hueXPJfD9XWfHbbqTUsY21Pw2h
   MrIf3bTzQKijJKtTWBImELNPhCHU0AX2EptUhLmsSm0Cr8e7V1PUdC1SJ
   g==;
X-CSE-ConnectionGUID: TfMcBZ3mRcWznA6BOgG5Tw==
X-CSE-MsgGUID: DNmflEd3RMqrt5sPJbAoZg==
X-IronPort-AV: E=Sophos;i="6.09,250,1716220800"; 
   d="scan'208";a="23060803"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2024 11:03:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUSKBtlXNZE1VwX3Z9cGEzygeRNFfCrT8YjahpuWkcD7PAZsV+Cqn4vj03PmekVLPspXIug2fp1MmE6F4WrUPvGo7wrXiJgSTXO6qEFLqVRub8ViOieH+CURY8ebv9YRWuHu+MSzCKUEBs1f2N9JuweocMujtC0NECJf8a5/KENzwWxJp7BXQSyVWnkiHogJTbTmS5bOSago+NRdSEhrCta69/UKOTpQm1mkwuFAOGE5ORMct9BbocxpcZGE7x/6ItqEIUgqd4tJWdsHZkvSPFmO65IdQQDEACVDya4cBBOdR3XoCt5QRizolXQHKBlnQM43BbcDUpD0tam/YWNDsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chxJfX/OD6cTypVzXbkDkZXDX0w0vKqATUna1h3efNE=;
 b=DsotGcsojq+Ms0OB/beYmJC7D6O70jyK5rVWOT2sBesOiJShIYLr4uEVGfuTji86M2jvT/1RxAqhwBFs/Wg0UPoeohcVtiIsROQJz+63U8Ri1FN5+wsMCD21KSxs551qXiNLAVeDGPOXlo99taGtXzEtVuCkhE+InnWHObTUPuKXDVMSUcqCRsySGVN7Hw1HROiMfPUiyTohJ1HQkIeMEkMdxhz7OxmJk86KI3YmficfgMM1MEHGpyvv1eSYAwt/viII7/FePwGBpDn6Jt7wzRRm2XU6+dWees9LuOyA9oGf4MGP519xeVf003wSbNw5pdmO5NaoGfqov4qkf/tVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chxJfX/OD6cTypVzXbkDkZXDX0w0vKqATUna1h3efNE=;
 b=QejdrE+H7klqetolYn9xcgWKi02uu0SzUDGTCsmvL0PeEb6mPRcQ4njDiNw5TqBrd0nz+B28rJaFpR8bYHy6tTnrVQhC2m3a/7JqNpdeRkvop4C2Tt5+dzo7PrytPeGPwIqJvbzoGEza3LnNlz4kSwLFIGJRlyAr+w/9iMOGcmg=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB6698.namprd04.prod.outlook.com (2603:10b6:5:22a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 03:03:04 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%6]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 03:03:04 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: Filipe Manana <fdmanana@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] btrfs: zoned: properly take lock to read/update BG's
 zoned variables
Thread-Topic: [PATCH] btrfs: zoned: properly take lock to read/update BG's
 zoned variables
Thread-Index: AQHa4ZHuECsm74Ko90KvFWL7iN95VbINltgAgAAw6ACAAAHngIAAAqcAgAJcwQA=
Date: Wed, 31 Jul 2024 03:03:04 +0000
Message-ID: <5jcvyo65cvtovk2rhzecd2rnanxuqczzzhkilgw3frspu2wzgc@bwytkb76ovfg>
References:
 <9eb249aedabfa6008cbf13706b7f3c03dc59855d.1722241885.git.naohiro.aota@wdc.com>
 <CAL3q7H6AZOGvYbf=BmEVEE_qWZYk86Li1s=jrfyOoUKAHhtDdw@mail.gmail.com>
 <20240729144150.GA3589837@perftesting>
 <CAL3q7H5Nbo=0=kM8-sWv3KO9Xbki+zwyD8gyVgDu87dESBwMbw@mail.gmail.com>
 <20240729145808.GA3596468@perftesting>
In-Reply-To: <20240729145808.GA3596468@perftesting>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM6PR04MB6698:EE_
x-ms-office365-filtering-correlation-id: 7f4d8526-4640-4fa1-e084-08dcb10d4bbf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WUlod2daVmR5VW1sdmo3dnRSQWcxcFgxUlBMdFdlMlBrUkwxa0V5U1pxVEdS?=
 =?utf-8?B?RzBWMS9rbkNDSnBtRUFwUVpiSkdtZnU4UnA1a05Edms1UE4zTXBFaHpnY2ZZ?=
 =?utf-8?B?WFptSU9CSjNpNjZ2Snp4OVJyTlljMEdSaktaeUZLSlZLVnVYQ1p2WWIvNGEv?=
 =?utf-8?B?YUF1a01FL0lVSUxPOUJDZ1RsNUkwbTNFamVsclZGRmNxdEFoRnVMRUZZd291?=
 =?utf-8?B?c3NnQUE3d0pTSkl2eGZNalJtTXIreUFrbnFJaUwwUGE5Z1I4QllaYTJaMi9p?=
 =?utf-8?B?WXpZeWp4Ym8xc20rbUVSdEpzUnk2L3BVcnlGT2dpM0x3UDBXS016dy9tV1lG?=
 =?utf-8?B?SWR1aXRUU25udVU5U3Urd1JULzNuV0hTckNFQnZiWVRrMDk1MG9lSDZTNzFI?=
 =?utf-8?B?Uko4emNjSFgzVTVUUkNvaVFUQXRxaUtFK0pPY1h2T1ovYTVjK3VBVVhmSjI0?=
 =?utf-8?B?MFBNVGtlV21kSHFXZldYV1VIT04yTlhubGpvU090L3lGUE5Mck1yTjk3ZzdS?=
 =?utf-8?B?OTRYVXV4OStMNjBjdGYzM2RWZHVFdFRyTHNObXk3RkY2eVlqTS9hUHdEZ09o?=
 =?utf-8?B?am5VTWYxbnNDRk9Ra08wdXVyTmU4ZUJzTlVOcXoxUG1KYis5UUVJaCszRCtn?=
 =?utf-8?B?UFNoMjZIancySnpqSjBwUnhrK3pEQXpoeVd2UzZlcVpEM1pLUExkR2c1Qlhq?=
 =?utf-8?B?VnlqUEtzdEVWdlJxdC9RK2lXc2g4dlp6M1doa251VUZYcWd2b0tjdTdFMFVV?=
 =?utf-8?B?NlVNL1BFU21RYk1NZWdyakFtYWNHRXg2NEFiRFowTzI4ZWtnOSthMTc0NWZX?=
 =?utf-8?B?MUt1Ylh3QjMvUWYwOFVvTjNGMGFoeXRvUWNEaHJ3VStIaEJIOXRaQ05VZG1I?=
 =?utf-8?B?YVMzT050UWhKMWNTK2FxZytEalFHbE1weC8xNGlBWVp2TDk0NXRCbTBSNXdh?=
 =?utf-8?B?SHlXSS9nUEl1MDF3dWRIc2pEZk82NC9xZHBPNWVoMUNTNHM0T1JzMWpMajlR?=
 =?utf-8?B?akdxTjU3L0kwN09kVVF0K2FYNFI0Y29aTExnb25vL2gxMEQ5TlZySDFvNm5h?=
 =?utf-8?B?ME84cHd0ZGxNZ25vdUpqNEZUSjkwRzgybmNkNEhuVUY5KzF3Q2NEWjg4WXpa?=
 =?utf-8?B?N2ZNbmQ2MjJKT0VLakJmclRJd001b2RsaFAwOThKZ2IrdzRyaE5aYjlkc0M3?=
 =?utf-8?B?RXhaandseGVoZDI2U25WRkJETnlTT080K3EvQ2hGWFloYlFIbE9CVlVzR2VT?=
 =?utf-8?B?RGJnRktvbE1qRmowR3o4TVVLZGlIeDk4YXV0NVpMaGJjRmFURjAwMHhDNTJl?=
 =?utf-8?B?T0pORno1NEpmWnN1SmpQWTR2NEt3SFM2bGh4V0REUnkrWnplMDZiQmJFZ1py?=
 =?utf-8?B?WThIL1hQQWZXZ3kxcmdnS3M5N0lRT1pNcldZR0JldWdCZjFqNlhkdHd5Qy9P?=
 =?utf-8?B?MmJBY21JVVR1Tjg1eUNjLzhkSm1KaHBvTHpMZy9wYUsxdDVnUDRQb3J3LzJn?=
 =?utf-8?B?bUt6VllOQ1RlMDcxbE1OdUtyWDhsNi9Ib0M1QlpjNGUwMjh3VmJHaVcwbWJv?=
 =?utf-8?B?bWl4cTg0dDNWZGJwd1BqRXJYUWRpQTl4Qks4YitEb1p1Z3IvVUdQaEFycE5J?=
 =?utf-8?B?dmRxOXBjNXhZUnRjRnJBdHZWSU1UVDVnbWNRZWZqVlhPd3RqNG9OSU5FdlZy?=
 =?utf-8?B?Mk1ocy9EZFFhczlvaTAxRWFZZDMxanRuNnphekUvaWVyZTI2K1kvVFQ2S0dK?=
 =?utf-8?B?VENSVy9lQ2NGRG5KektzaHlUZGdnMk8vRkEyMUQ4d2dCMVYvdVd6UUpBcXJL?=
 =?utf-8?B?cks0YjJTS2RhV2YzejVFN0dnTmlkSGQ3dlZwQWIyT2ZrWjV5cnYreUllMVMx?=
 =?utf-8?B?cCtkRnorRkJXOWxPOFpGdTFrL3AvMW5PMjRxbTJ2R1NTQXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?THJNT09NMEZqWmtDWE54QURxYzQ3NHlodDhBYWRjR0lycUgxYTVabjlmUS9G?=
 =?utf-8?B?WTgybnREN0tYazBETkZSbG1KTG5VN2QxVlVGanl3WVBJTDBPN2ZtVER0Z2Jz?=
 =?utf-8?B?clF1Tk85clJJcGhRdDJwVWp6VlRibjZscVprSDNGRWI4V3RVRllPa0g3TVhh?=
 =?utf-8?B?MXFxS1FWT1V0aGk2K0dvSTlLZlYzdTlkaXREQm1vNlhWeTFLbEQxeUhRcTBw?=
 =?utf-8?B?bzYyc25EU1QvdTNPT2pPNlpjcm9YL085WlVSclUrMDhRVHpyZ0hnYmo3Q0lW?=
 =?utf-8?B?b2dnbHZZYUJ5cmpVVXhQMlBtemtxcHVmUTZFcUlhRTRoTkdhQnk4RERkVkJS?=
 =?utf-8?B?L2g2TFB6T2ppMUVLbmROVC9zZWNuRStBejU1S283RjZobFNZY2YvczRPUDJ0?=
 =?utf-8?B?MlhhOWc0RThzcDlJMFRCYjZyTVBiVU13NXhiVi94TmxrVzVjbWN5Q3ZaV2hv?=
 =?utf-8?B?RGlYZmJ6WDlHWGVaWTNrQ1FQVHZCUjJ1dS9EaXJIZkRMaUhqSUxEKzdHMmxs?=
 =?utf-8?B?bUFOVmlJRU40eHJCMkhMaXB0YmM2YkhOdEd1VTFaY2VaM1A1bFFRTm9pSGFO?=
 =?utf-8?B?bFVSSk5PMXFHaHdrdUVONEJ1OFp3eHdXV0loamgycFdTRlRLNkY1TThQQUFL?=
 =?utf-8?B?YWxiR0xsWUk1dkg3SlpSZ2hnZVd6R2xuQk1ubnkyYzhyYm1BTXArd3Y2cEVy?=
 =?utf-8?B?bklvQ3BWb0JhRFRJYUN1QUdSRkFtNG5nMTJ6M3JJcnpacVZWTTIzemZxZncw?=
 =?utf-8?B?cUk3Uk5ybHJvRGRKRkhlUnF0U0JGQW9XQWpoOGZyVmtKcnZTeXhLYjAzOHVR?=
 =?utf-8?B?cUlCdmppTUdtSzhDdFdPejZ0QTRka1lqMWRoaVFJZHd2ekozQ2lBZEpzWkJL?=
 =?utf-8?B?Sm9pTE9ZQVVIckEwQUYvQjJ0QkVLWWN1eFA4YVQ1YmZXRW9pb0lIRGN4TDBi?=
 =?utf-8?B?bGkrbWVEMVpRWFVQVzdyVUVqWmozaHBsUDQ4bmZ1TXZNTXZ6d29oZGJGdzdL?=
 =?utf-8?B?VFgrQWowVXRkOUxuNStjUWFCek90UWQrZzNUa0N6UnpRU0d0YnFlM1NiOHNP?=
 =?utf-8?B?TjVKcGcrUFp3VnpoRE43eVZuOFRvR3A4SWhMTFB0MDBKMld3cXdlL09DOFJV?=
 =?utf-8?B?QVMybDlzanFTSHFHU3JJcE5qTVkwZ0xlbDFSR1FjRVY4blZEQWVhL0d1SnNn?=
 =?utf-8?B?enZ0T0NLSms1VzgybW01NHo5MGNmdC9lZ3JPeGVnQlE0RjdSRHlqaDdWTi95?=
 =?utf-8?B?VE0rYkNtSG1Ea2Q3NmM2bVJRME5yMktReE9EZ0pqRy9KRzJpT21SdGZldjBu?=
 =?utf-8?B?UWJTZzA1blJKcmJqN2o2YURBQ2k4dEV4V0FoRnlSZzMxNHhjUWUyZWZ3NmYr?=
 =?utf-8?B?WlhYQ0dWSDdoUTNkL3VwSC96RVN5SktucEx5cWJybXp0aFp6ZGdMeW84bnRl?=
 =?utf-8?B?WG9lMFplcFN2TVN4Mk9kOXVpaVNGY3gzRTh3bEFxY0NkTlRFMjdrekFiMzlr?=
 =?utf-8?B?cFhJMFQ0U2MvanQvYUQrcFdlZnljcE9CUmdsQUxpb0NZMGJxRTlwT1k3a1hI?=
 =?utf-8?B?QWZHVDlzQUduWFo1TjdlNXhOT2ljWFM2K2w1alFuRnovQzVabVZlMG1sc0ty?=
 =?utf-8?B?Q2FRL3RzUkUvVzZOT1RYQjdnMmNzVE9LL0JTNU5jUHBRMXozUDRia0FwYmlv?=
 =?utf-8?B?TzRFOStvaWdkL1RpbUYvMThGNU1HcjNuT3lFVEovWmY4d2V1M0ROTXcvOUpV?=
 =?utf-8?B?M1A3b1psOFFyT1djSC9FdlNRSTY3Z3dEalRNcTBUZk9RWHk4TW1PdGs2ZXNG?=
 =?utf-8?B?dXNJalJpQVBSbnV4S3lvaDFiV1Y4WTlPV1U3bWd1VURadlBGSk8rL2NIeHQ4?=
 =?utf-8?B?MGtDcG8rZ0dkVTVhV2hoelI4Rk9obDd5anVtZGRYSkxrSDQzNEI1a3hnQ1ln?=
 =?utf-8?B?ZlEzV0xudms2UFYyRzBzY3NRWFB0b2twVm1ZQytibU5aMnBLZ29TcmpqUVVq?=
 =?utf-8?B?YlhvWkovOENDL3dvMmZoUVlPK04rSnkwWkdVQkxpSW1mczdORXV6QS8xcmtv?=
 =?utf-8?B?M1VBQkNKbnJFOVRXZUFZNW5sUDhDWnJVMm9nTXlTTUpDQkx4b3lGMkE2dGhC?=
 =?utf-8?B?ZmxCMjYxWWxHSXNERjV1cG5QcUE5bVF1UlArZkNqUzlTSmNXQlJ0R3NKM3JN?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <089ABF12E3822440951B4BBF8191BA23@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XPdICKqGyJ+KQAQneltExKcYxmCKXqLLXLYmMufdC9Xw/Hte0BlaI4Vf/WmYBK5D8FSxpZ5EsTRPXOrzUIG1x9D+bnYDFr/K0vwv7dRFEdeelygwE7acEezNTAFOMyLApOLTc9ApYi+3qCLVJ3m2JcXFUAsrmlBcnoJO9syLiOytlA9uErF2SCWMrTJ0MWmsEeAQp1j1IbF+zi7vk4lkpW1NiIYHb0/jyCEzDp8CRDDgwE8n4o66RdrNm7uMxZPTtJo2o6FLhsPpAbxmi5ek0IusNT3EMujBE/jX/U2hTlOHkfRb1JS24gXr4c9+i1CYrqK4JxDzrHbi2twHmAtX/ziu9Ac0GBXEj8X9eu5sdDd3AB2P24RQOm63voNHfSJag9GwEn9rVRl3WTH6bM7PArsGUAXwZZhopW8WKIBkiqtRIbvDrsSis3B3TgrnNKY4wVrqClILoE3ObDdMWnIaskK6Oxqo35HkRGdFth7O5RxkjmIv/ba9paIuZ1rO9e14jaQFfoXxuI2wA0D3aOaAVofjNKxv+36XjzyTvcXaa95Zwd3OmeBVvLD8QRKgcrB0dQm+BoBVpeubSChWm6R8u0cIH9oXSGrclIlgzeiGkvK4jbPBQ16QErBAnMvKmMCR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4d8526-4640-4fa1-e084-08dcb10d4bbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 03:03:04.2614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I2wDDiPRnxPS4wQ6qvaoYCoLZrjlJ1pHks8Ks1PLrA5E+W76C+dZs6jifpqEwlzf5omKpGETzJ/FRaChQOtSPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6698

T24gTW9uLCBKdWwgMjksIDIwMjQgYXQgMTA6NTg6MDhBTSBHTVQsIEpvc2VmIEJhY2lrIHdyb3Rl
Og0KPiBPbiBNb24sIEp1bCAyOSwgMjAyNCBhdCAwMzo0ODozOVBNICswMTAwLCBGaWxpcGUgTWFu
YW5hIHdyb3RlOg0KPiA+IE9uIE1vbiwgSnVsIDI5LCAyMDI0IGF0IDM6NDHigK9QTSBKb3NlZiBC
YWNpayA8am9zZWZAdG94aWNwYW5kYS5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIE1vbiwg
SnVsIDI5LCAyMDI0IGF0IDEyOjQ2OjQ4UE0gKzAxMDAsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+
ID4gPiA+IE9uIE1vbiwgSnVsIDI5LCAyMDI0IGF0IDk6MzPigK9BTSBOYW9oaXJvIEFvdGEgPG5h
b2hpcm8uYW90YUB3ZGMuY29tPiB3cm90ZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IF9fYnRyZnNf
YWRkX2ZyZWVfc3BhY2Vfem9uZWQoKSByZWZlcmVuY2VzIGFuZCBtb2RpZmllcyBCRydzIGFsbG9j
X29mZnNldCwNCj4gPiA+ID4gPiBybywgYW5kIHpvbmVfdW51c2FibGUsIGJ1dCB3aXRob3V0IHRh
a2luZyB0aGUgbG9jay4gSXQgaXMgbW9zdGx5IHNhZmUNCj4gPiA+ID4gPiBiZWNhdXNlIHRoZXkg
bW9ub3RvbmljYWxseSBpbmNyZWFzZSAoYXQgbGVhc3QgZm9yIG5vdykgYW5kIHRoaXMgZnVuY3Rp
b24gaXMNCj4gPiA+ID4gPiBtb3N0bHkgY2FsbGVkIGJ5IGEgdHJhbnNhY3Rpb24gY29tbWl0LCB3
aGljaCBpcyBzZXJpYWxpemVkIGJ5IGl0c2VsZi4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFN0aWxs
LCB0YWtpbmcgdGhlIGxvY2sgaXMgYSBzYWZlciBhbmQgY29ycmVjdCBvcHRpb24gYW5kIEknbSBn
b2luZyB0byBhZGQgYQ0KPiA+ID4gPiA+IGNoYW5nZSB0byByZXNldCB6b25lX3VudXNhYmxlIHdo
aWxlIGEgYmxvY2sgZ3JvdXAgaXMgc3RpbGwgYWxpdmUuIFNvLCBhZGQNCj4gPiA+ID4gPiBsb2Nr
aW5nIGFyb3VuZCB0aGUgb3BlcmF0aW9ucy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEZpeGVzOiAx
NjllMGRhOTFhMjEgKCJidHJmczogem9uZWQ6IHRyYWNrIHVudXNhYmxlIGJ5dGVzIGZvciB6b25l
cyIpDQo+ID4gPiA+ID4gQ0M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyA1LjE1Kw0KPiA+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IE5hb2hpcm8gQW90YSA8bmFvaGlyby5hb3RhQHdkYy5jb20+DQo+
ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gIGZzL2J0cmZzL2ZyZWUtc3BhY2UtY2FjaGUuYyB8IDE1
ICsrKysrKysrLS0tLS0tLQ0KPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25z
KCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2Zz
L2J0cmZzL2ZyZWUtc3BhY2UtY2FjaGUuYyBiL2ZzL2J0cmZzL2ZyZWUtc3BhY2UtY2FjaGUuYw0K
PiA+ID4gPiA+IGluZGV4IGY1OTk2YTQzZGIyNC4uNTEyNjNkNmRhYzM2IDEwMDY0NA0KPiA+ID4g
PiA+IC0tLSBhL2ZzL2J0cmZzL2ZyZWUtc3BhY2UtY2FjaGUuYw0KPiA+ID4gPiA+ICsrKyBiL2Zz
L2J0cmZzL2ZyZWUtc3BhY2UtY2FjaGUuYw0KPiA+ID4gPiA+IEBAIC0yNjk3LDE1ICsyNjk3LDE2
IEBAIHN0YXRpYyBpbnQgX19idHJmc19hZGRfZnJlZV9zcGFjZV96b25lZChzdHJ1Y3QgYnRyZnNf
YmxvY2tfZ3JvdXAgKmJsb2NrX2dyb3VwLA0KPiA+ID4gPiA+ICAgICAgICAgdTY0IG9mZnNldCA9
IGJ5dGVuciAtIGJsb2NrX2dyb3VwLT5zdGFydDsNCj4gPiA+ID4gPiAgICAgICAgIHU2NCB0b19m
cmVlLCB0b191bnVzYWJsZTsNCj4gPiA+ID4gPiAgICAgICAgIGludCBiZ19yZWNsYWltX3RocmVz
aG9sZCA9IDA7DQo+ID4gPiA+ID4gLSAgICAgICBib29sIGluaXRpYWwgPSAoKHNpemUgPT0gYmxv
Y2tfZ3JvdXAtPmxlbmd0aCkgJiYgKGJsb2NrX2dyb3VwLT5hbGxvY19vZmZzZXQgPT0gMCkpOw0K
PiA+ID4gPiA+ICsgICAgICAgYm9vbCBpbml0aWFsOw0KPiA+ID4gPiA+ICAgICAgICAgdTY0IHJl
Y2xhaW1hYmxlX3VudXNhYmxlOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gLSAgICAgICBXQVJOX09O
KCFpbml0aWFsICYmIG9mZnNldCArIHNpemUgPiBibG9ja19ncm91cC0+em9uZV9jYXBhY2l0eSk7
DQo+ID4gPiA+ID4gKyAgICAgICBndWFyZChzcGlubG9jaykoJmJsb2NrX2dyb3VwLT5sb2NrKTsN
Cj4gPiA+ID4NCj4gPiA+ID4gV2hhdCdzIHRoaXMgZ3VhcmQgdGhpbmcgYW5kIHdoeSBkbyB3ZSB1
c2UgaXQgb25seSBoZXJlPyBXZSBkb24ndCB1c2UNCj4gPiA+ID4gaXQgYW55d2hlcmUgZWxzZSBp
biBidHJmcycgY29kZSBiYXNlLg0KPiA+ID4gPiBBIHF1aWNrIHNlYXJjaCBpbiB0aGUgRG9jdW1l
bnRhdGlvbiBkaXJlY3Rvcnkgb2YgdGhlIGtlcm5lbCBhbmQgSQ0KPiA+ID4gPiBjYW4ndCBmaW5k
IGFueXRoaW5nIHRoZXJlLg0KPiA+ID4gPiBJbiB0aGUgZnMvIGRpcmVjdG9yeSB0aGVyZSdzIG9u
bHkgdHdvIHVzZXJzIG9mIGl0Lg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IEl0J3MgcmVsYXRpdmVs
eSBuZXcsIGl0J3MgbGlrZSB0aGUgQysrIGd1YXJkcy4gIElmIHlvdSBsb29rIGluIHRoZSBWRlMg
d2UndmUNCj4gPiA+IHN0YXJ0ZWQgdXNpbmcgaXQgcHJldHR5IGhlYXZpbHkgdGhlcmUuDQo+ID4g
Pg0KPiA+ID4gQnV0IGl0IGRvZXMgbmVlZCB0byBiZSBkb2N1bWVudGVkLCBpZiB5b3UgbG9vayBh
dCBpbmNsdWRlL2xpbnV4L2NsZWFudXAuaCBpdCBoYXMNCj4gPiA+IGRvY3VtZW50YXRpb24gYWJv
dXQgaXQuDQo+ID4gPg0KPiA+ID4gPiBXaHkgbm90IHRoZSB1c3VhbCBzcGluX2xvY2soJmJsb2Nr
X2dyb3VwLT5sb2NrKSBjYWxsPw0KPiA+ID4NCj4gPiA+IEJlY2F1c2UgdGhpcyBpcyBuaWNlIGZv
ciBlcnJvciBoYW5kbGluZy4gIEhlcmUgaXQgZG9lc24ndCBsb29rIGFzIGhlbHBmdWwsIGJ1dA0K
PiA+ID4gbG9vayBhdCBkODQyMzc5MzEzYTIgKCJmczogdXNlIGd1YXJkIGZvciBuYW1lc3BhY2Vf
c2VtIGluIHN0YXRtb3VudCgpIikgZm9yIGFuDQo+ID4gPiBleGFtcGxlIG9mIGhvdyBtdWNoIGl0
IGNsZWFucyB1cCB0aGUgZXJyb3IgcGF0aHMuDQo+ID4gPg0KPiA+ID4gRldJVyBvbmUgb2YgdGhl
IHRhc2tzIEkgaGF2ZSBmb3Igb25lIG9mIG91ciBuZXcgcGVvcGxlIGlzIHRvIGNvbWUgdGhyb3Vn
aCBhbmQNCj4gPiA+IHV0aWxpemUgc29tZSBvZiB0aGlzIG5ldyBpbmZyYXN0cnVjdHVyZSB0byBj
bGVhbnVwIG91ciBlcnJvciBwYXRocywgc28gd2hpbGUgaXQNCj4gPiA+IGRvZXNuJ3QgZXhpc3Qg
eWV0IGluc2lkZSBidHJmcywgSSBob3BlIGl0IGdldHMgdXNlZCBwcmV0dHkgbGliZXJhbGx5LiAg
VGhhbmtzLA0KPiA+IA0KPiA+IEkgc2VlLCBJIGZpZ3VyZWQgaXQgd2FzIHNvbWV0aGluZyB0byBh
dm9pZCByZXBlYXRpbmcgdW5sb2NrIGNhbGxzLg0KPiA+IA0KPiA+IEJ1dCByYXRoZXIgdGhhbiBm
aXhpbmcgYSBidWcgYW5kIGRvaW5nIHRoZSBtaWdyYXRpb24gaW4gYSBzaW5nbGUNCj4gPiBwYXRj
aCwgSSdkIHJhdGhlciBoYXZlIDEgcGF0Y2ggdG8gZml4IHRoZSBidWcgYW5kIGFub3RoZXIgdG8g
dGhlDQo+ID4gbWlncmF0aW9uIGFmdGVyd2FyZHMuDQo+ID4gDQo+IA0KPiBGYWlyLCBhZ3JlZWQs
DQoNCkpvc2VmLCB0aGFuayB5b3UgZm9yIHlvdXIgZm9sbGxvdy11cC4gWWVhaCwgSSdkIGxpa2Ug
dG8gdXNlIGl0IGZvcg0KYmV0dGVyIGhhbmRsaW5nIGFuZCBub3QgdG8gZm9yZ2V0IGxvY2sgcmVs
ZWFzaW5nLg0KDQpJIGFsc28gYWdncmVlIHRvIGhhdmUgdGhpcyBidWcgZml4IHdpdGhvdXQgdGhl
IGd1YXJkKCkuIEl0IHdvdWxkIGJlDQpiZXR0ZXIgZm9yIHRoZSBiYWNrcG9ydGluZy4gSSdsbCBy
ZWJhc2UgYW5kIHJld3JpdGUgdGhpcyBwYXRjaCwgYW5kIHdpbGwNCnN0YXJ0IHVzaW5nIGd1YXJk
KCkgaW4gYSBuZXcgY29kZS4gRXZlbnR1YWxseSwgSSdsbCB0cnkgd3JpdGluZw0KY29udmVydGlv
biBwYXRjaGVzLCBtYXliZSBwZXItZmlsZS4NCg0KPiANCj4gSm9zZWY=

