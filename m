Return-Path: <linux-btrfs+bounces-18382-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18513C141B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 11:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86755816F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 10:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903A72F691E;
	Tue, 28 Oct 2025 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ajr+Ewes";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cR23aTSk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91BC262A6;
	Tue, 28 Oct 2025 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761647409; cv=fail; b=f4cc7+KK2r3ZlVqU+r102A1RiI7HGLQ+3WbtTm49IEN4zVxGuGQzK7JMhJePmtU3/Jhd8aaj6/USCAKlMyc/0fHXllX5mruFLIchyVWwP8osLkDc5dXMvQucxLctE8Ua0XhiGEnl3UQwtAWeWPxPcumuTh9hqiGsvdTrmH8vC7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761647409; c=relaxed/simple;
	bh=xKMPMdCd7VwGPuPwTrjoolmn0Kq5/ySAv27G11mKnY8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n+eAusoPHrwr49KByEGIzs8QxZ+qZ0+0eoR3SfIYcFwvttoFqddb0LDmaDAHhCRl7ayBVqTV7n6EoiALtjt398ikFn5ngy3yKXr1SMJ2+nuw+nk5UDACqZgkO+38li9uHkRFzLJJQlP/WsigwRVYtIjEuTNlyfE9Wi8YJ9EhO10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ajr+Ewes; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=cR23aTSk; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761647407; x=1793183407;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xKMPMdCd7VwGPuPwTrjoolmn0Kq5/ySAv27G11mKnY8=;
  b=ajr+EwesY1VyiJKcuYduPgzU2p/5aJP4i5MUorZzjNMgHInq76uV02te
   Vr4WXu5slDOyKt5HvIwLNgeDo00Jk7/iFI8tJO1RXtAjbBJ30UjvJbyZg
   XM3KPUw6cpBNEuHyFE6D8+XTEra0vvt/cCaezEIRYdqS3xzNJezxf36dA
   M3qlbEHZisz+jZ89nokG5qz1UwBbyBFHEGl5klwq+VhUdMZhsqtsKZw+z
   dw/wzAgW38UeYZfrlHfTKQ9UzqtmM8GdSC5heq46FxbANTr5Hi7RM8OjJ
   h7fNV7RiDty7kzg37FstIYtbxB5MkwwoGtTMl7KdQksiy5yglW5Ou2neq
   w==;
X-CSE-ConnectionGUID: VTs1NkZdTWq+kAiENIQjUg==
X-CSE-MsgGUID: olFae/SnQd6/mvj3Q9tBsQ==
X-IronPort-AV: E=Sophos;i="6.19,261,1754928000"; 
   d="scan'208";a="134046985"
Received: from mail-westus3azon11010055.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.55])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2025 18:29:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYrLTvZB4hjYWCnqUNt2n8S1IMVnFTUwzMEsXkyoERCnap18uDKr8k4N/4DKMo0CMKjMlKxq78g3zULdj0sizGBE3/SD6/DlQB9KT2KiR8+DDQRjol28Uvg1x9IXWez9rnjy25Ir3TuS2fI1vHoNyoALFKNxnMqfN01tlx9yPOGZPty0A3ZlgsKM4XWnJ1dzs7WlkDyYsQJgRYwqiq2Ptpo/7a/q4hzbvKpJfSDmELUXIHzPPmDpcyrQ+7Wcj2yhvg/FGdHudw1gQrj6AakjCJxkg2R2MBRZEJHt61MgEbytGswQLqThjd1YsQnLsxsmkINGpTRbBbuAPgu++jRtlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKMPMdCd7VwGPuPwTrjoolmn0Kq5/ySAv27G11mKnY8=;
 b=XAH5t1zgiCeQqKDChuXGy2Le2Et65T9Gqdkcw+31BPf5G6dQSR9AxDmC3fGMx10+TNiOOdM5H4RMfMA6Fq1GpSp1BiyI1KWaIoz8dLn/Oq0q/y3nuFd1v3o01ZGgj3PQmumKJT81W0ZEPbQnHBZBp0e+QkzDc18nk1/4dlNnk5XPGmmdecLCSDgoo7plmAqIAYq/du6+7oUWrEW8iLWGdeFU2gv9bKbtPkHtg/wxg+F7PtMnRsycfFv0L5TcODGcM4BgZBpk4HkgdTuf6YwQzNX54FXoNmgb6Q9EsNo5hGsFWXnzrWRkLcpDR0+Ms8Xsoz51z44nMZs+H8wdVdij8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKMPMdCd7VwGPuPwTrjoolmn0Kq5/ySAv27G11mKnY8=;
 b=cR23aTSk60o7Mp8ldDc/zuTcbhM1ZmmJNu0HGi2lfziFsWJjaU9MFhtuIZcEt0edKZ3sgZUVl5aLq/WXRTtM59uqp6iQufA+3Fdd4C0xs69/JvsV/Mu1jP3flKXQPgdrFuTGFs3YhIDhb0Xy/99Cewjq2cvTLOxBsAZu3O/rbhE=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by MN6PR04MB9333.namprd04.prod.outlook.com (2603:10b6:208:4f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 10:29:57 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 10:29:57 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
CC: hch <hch@lst.de>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	Anand Jain <anand.jain@oracle.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, Hans Holmberg <Hans.Holmberg@wdc.com>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "Darrick J . Wong"
	<djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH v7 0/3] fstests: basic smoke test on zoned loop device
Thread-Topic: [PATCH v7 0/3] fstests: basic smoke test on zoned loop device
Thread-Index: AQHcQzYOjNrKXQTHSUemmyQ7TxVP2bTXZS8A
Date: Tue, 28 Oct 2025 10:29:56 +0000
Message-ID: <f1c10799-e3fa-4e36-ab79-13b107357a03@wdc.com>
References: <20251022092707.196710-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20251022092707.196710-1-johannes.thumshirn@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|MN6PR04MB9333:EE_
x-ms-office365-filtering-correlation-id: 5c61f98b-9883-48a6-95e9-08de160cf0e0
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|19092799006|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bkFEUEM1Njk5YU1VOFRhemZLeXdwd2tFZGhDcGhpbUdLMXVxOTdNWDZkYUti?=
 =?utf-8?B?NmIzQnJMakhRZHUyZEFWMXdlSW9oaUFuVU81QmN4eDhVUkFhQ0UrdEdKcHQ3?=
 =?utf-8?B?T0FpN0xkVkZKTzVxMHBtR0VUd2NmTHgydm9ZaGNvNEtkbzVyellhSUxacTYr?=
 =?utf-8?B?N3BHMXhtWFFzbVhTU3UyUTVtWFEvb2dQZCtMQ2FRZWxiZEpqZ3RHdVhnK2Fk?=
 =?utf-8?B?R2NVVElJRFZmcHlqc2FUa0dLMWw0ZWxUcTV3dHZnSEtRMnJzT1drQXZ6RzZJ?=
 =?utf-8?B?UVdiNGVZZnFLNDA1ZTRxWWREakZqVGxhQ0tHZ05WeEVraXdsOSt6WENoY3BS?=
 =?utf-8?B?d0d5ZXpkWUlocktKY09Lc25tQzJWZ2pYRzRJTjJsZ3MzU2JDL1VlblJPdlY2?=
 =?utf-8?B?NElaSUo5Q2FaNmRlekk0Q0ErMmUxYm1lRFhhVHU3aVN5cXQ2NTg1YXVJVlB6?=
 =?utf-8?B?L21HbnRBaU5ZYWxHVGtPM3o2dkJHMHMzZko5QVp6SFQrZGRIUkpoRVB5WHF4?=
 =?utf-8?B?TnZrcVZKeXVZamxQRDFTRFkyWWE1YmFySHhtakNiTmhFbVJ1WHE2ZmlzK1pG?=
 =?utf-8?B?TzJQNHMzNFpLdjZrbDBBczNXN2NIUGFNT3QyZmtUWHh3WEQrcFpXeks2aHBq?=
 =?utf-8?B?OTgxa2ZMUnZpSU9JeGQrUWU1R21SaUtHeDNOdzllSGkvcmQxMGtKSXR1VlNi?=
 =?utf-8?B?Y1hUWjNlVDRqckhabTRMZmxZYlpxaEtDYmZWR1ZPcHBRMFVrV1N2OEE0WDZQ?=
 =?utf-8?B?QlFiQWpyTTRNNUEyN21WblpRWlRYUGE5bU9mUUtEb2QyR0NPQnV1NllwQ3VF?=
 =?utf-8?B?eW5SMHBMUzI0ajJrZ081UEJHRmdrUnp5VE8yRTRTRmxoeG5qZmZOL2krMlNj?=
 =?utf-8?B?RDRieFRSSFBlL2ZGdUlLZGNjbFNmUXdhL0tJOWVibDhwSldmN0NGUmFSaDQx?=
 =?utf-8?B?TDB4bzI1NmFGbys1NkJZUjVaVzBFclArWHYxcFZES2llc0pVdnFNbXRmb0NQ?=
 =?utf-8?B?V3d6OXFKUGJuVGx0SnNKR3BiN25oMFRJWmZvZURnYm91QmxFWVBjaEhvWWZD?=
 =?utf-8?B?a0JwRGFBQlJ3MUhUdHhDamFGQ1p5dnBIZnpmVU4wMVZ6NFgybVptZ1V4eXRs?=
 =?utf-8?B?Y1VlaTJnNC9rQWRhSDFlRjd5bFlETnVKc3o3NWlRNG9TaE5oZzg3YjZRYXFH?=
 =?utf-8?B?MDUvRldGaXRCU1Z1VUFKVC9wUld6TUIwQWtXWWJPa2I5K1RLZ0p6TDBscmo1?=
 =?utf-8?B?eHVIVFA2dTV3VTBZN01xVGV0elNnck5pR1pSSml6ZTJGc3E5YjVZZTk3WUJi?=
 =?utf-8?B?bGlhclZkNDZLWSs0SEVsb0k2Mno1K2EwMCtKenZ1NHFZVi9aaXVNK2E1emM3?=
 =?utf-8?B?b0cwbXppYUxPSkUzRDF0ZXRuZGdhc0VyMUpuRHpVTythZFBCWVF4a3I3SUdR?=
 =?utf-8?B?TUhtd2lVNVhFSmFVUzZZZkN6bEdFNHBVcFNTN283RkVaUjNWVW9vWjdXUlRz?=
 =?utf-8?B?U3pkWUlsVkNCL3hkQ3pqWkphQjFHR3QvenhYOG5Id2N2d2MvQUZNZzllQ05C?=
 =?utf-8?B?QkJGbTRkNEo1V1dJa1ZWRDRueXJpMGQwTVhOKzRCL2hBWHl6NC9EbVBSL1dY?=
 =?utf-8?B?aUVqSkdmMW1xejJaZE43akJhRXY2ZnU3R3VMdlVXWngra1VaenZpc2YyN04z?=
 =?utf-8?B?RDczb0VZQnNxQjR0aTBGSk5mQjZsam5MUlBSUWlDV0VFNUMvMUQ0OXhneE5K?=
 =?utf-8?B?SXJKS2F6Y0JncjdhOUpnS0cyS2ZjU3BHcGo5TkNGbTkrSExyVEFVSWd1WU5G?=
 =?utf-8?B?dVpnYzZxKzBuRGxETXp5WkNNQWJrMjNaUUNlRVJPUzQrRldsaFkyd2U0eGEz?=
 =?utf-8?B?dnRXV0xqcDJXNGhYOHBBL2tIek8zLzg5OHVyTElnUGJpdStlcXY0L3R2a0hQ?=
 =?utf-8?B?VW9lclQ4SS82eFlSL2JaOFNCY25FdHpDTDRPNHp4dGhVV2VaRzlvVTFoc1dC?=
 =?utf-8?B?OExPYmdlLysvYjd1cEN4enQ4aEQrRS80Y0lmMEZyUWVNQjM1R0JiQkJFckhP?=
 =?utf-8?Q?bsJLgs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(19092799006)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aU0zTWc1UFRqMk14UDQyb1VjNFpoaTVYVElUY3l6Y1hNVms1Rjk1RCsyVWhm?=
 =?utf-8?B?R2U2L2prMWpaSDExOXNpZFJyUU1rb1ArTFFQb1ZPNVdxUmhZWUZFY1Z4V1FV?=
 =?utf-8?B?Z0tibHZUQnNWTjVFeFdJM2N3VUNRb2FKZjdTelJSRWgwUWFCMWlhWjlxeUt4?=
 =?utf-8?B?QkFCMEd6YVpXYWdmMDQwcTVTVXZBaGNIQWI4VGVyOVlNODdvNVNiSkR5ck0z?=
 =?utf-8?B?VXlDM0t6T2VnenN5MGdXb3hKQzRmNkJFSmZFUkMyN0xRRVFVUy9jcHA4YVM3?=
 =?utf-8?B?clBpLzFwMHNSaUx5dnRZWi9MeExZcTBxNVhGODA2aEhQWHFuS3grWTMxenVW?=
 =?utf-8?B?UUFKcCs5UFZVMHBPOThKN0xQbWI5cmVBUUlzM2lMa3I3Q2ludVpEdXNvMDhu?=
 =?utf-8?B?YWpRMWEzanVRdG1yVVJMRTNjb1NoOXdXb2d6ZGVrMncvOXZ1WlRzdnR1N2gr?=
 =?utf-8?B?eGM2V2NpZ3BUV2YrZXRsVWVLaFIycUxxbkNOeDhvYSs1alJ2OUZmV1R0ZGJt?=
 =?utf-8?B?alpxOHhNVUhFazNnWFI0dVFoT0s5NldOVWFRWjB2c2l5WEcvQU9lNndCMlpq?=
 =?utf-8?B?Q1ZmMXpWeFVUUk5rUXpybTJ0ZDZsOXdFdTBNV1Rndk1jWVg1TWNpYXRNVUdm?=
 =?utf-8?B?eWovWGpRa3ZGNmlTUU1BVCtTMW5MckF5M0I3VDNzdkliVDhHTzJxVXpiUzVD?=
 =?utf-8?B?RzdwTkt1MDYvZDJuZjV0MTlJQVpzS1kzOUFGUVFZQ1p5WDM0ckU4MVFyMzRX?=
 =?utf-8?B?dDU3QXNpRm82THJBMHJwdzVUUjBxVGZuTnA2dWVrY2NmR1dTS1FEeVJxRDgw?=
 =?utf-8?B?amwyWEo0TXpWdVRFYmxlT2JsNFRSYmYrN1MzbzUyS1BSTWhDM3lxcThuRHhC?=
 =?utf-8?B?OWc3NG5EVzJZQUc2Z1ZDZGVrU0Zia1ovWDBqU1dTYnh0TGRJUXF3cy9ydW0w?=
 =?utf-8?B?cC9xcUJQVkxodXVtUW1OZllHQUlLaERMUUxTdGs0YUYrSEUrNit6T0tGVTI1?=
 =?utf-8?B?a3FqNDN2cUlGZ0tFcjVJN2xXK2NsZkcvdmNxQ2ZIL1dIclN6bkRma3dLNjhT?=
 =?utf-8?B?Sm5rUEpvN0JCdWlHc2lVSGFPcXYveDROaEVTeTQzbFg0aEU0YTVEMmN0OEVD?=
 =?utf-8?B?azhOU1YyVzJwNm1zTjNiQUMxVko3dHI2QzcwUDVBZ0NXQWp4MWdCN1YvenNq?=
 =?utf-8?B?UzBQdklJZzlsVHFLUGY2M0Z2T1pQNmxTUnBZUVJxWXo1TXF5eVdPUGlvZVl5?=
 =?utf-8?B?clNIdEtvMFRNWFBJQjJvT0NHSHhLOUZhVmRVczZMZ3k4Nk94TjR2YndwN3I4?=
 =?utf-8?B?ckRsVW5IY2pLemoxdnNNQnVCRDdXcmw4ckdES040RkNWNjM3VVpaU2c2dkhK?=
 =?utf-8?B?V25iSnlmc2lLU3ZuNGNkQTJRazdlRlhDTmxVeGdWb3hidzh2ZXhvMTBNdWtE?=
 =?utf-8?B?ODBRTW9iZmtvWGYzejM5ajVXSFErcHovUGZPQWM0cVF3VkZQbFVTdmVSSTBE?=
 =?utf-8?B?dVFlRW80WWVPeGNMT25jRUhTcFJ3YzJLRU9FZ2ZCaWNaNDZDbHQySjVzUU5L?=
 =?utf-8?B?OGd5eDltQ3ZJcms0NnNiNWdBYWRBdTVNYTRxVmJ6TVp5R3Vqay90OUtyVlZH?=
 =?utf-8?B?WG4raVhWOTFIbTBZVHNMb3pUcEo2bzErUU9qb0gvWCtSRzdPRkppdUZlTEd4?=
 =?utf-8?B?VkphMEcxSmVWR0RtaVpwZkhWaHFxdVdaK2NmY2dRNll3dFVUWk10Y0k3cFB1?=
 =?utf-8?B?YkgvMi93bXFrcTBHS0pkV2xKajUzdnJWTTV1dlB6TzRTa3FRRUt2TzY0K2py?=
 =?utf-8?B?emJsdy9YbzZTc0pacVhZbnRON0tBeWFacFMyN1RMRHNJcHVMNU1HZDFmZmFx?=
 =?utf-8?B?ckpSWWxpcWZidHJCWHlNWG1HcXcyVEIvMGkwVFJXeHpXb1YwSW44ajNBMmNq?=
 =?utf-8?B?YWZrZmtyT2ZweEwxbUwvM1p1cGIvaFFVWlg0SlZtdXVqZUFQTk93MjZ1eXRJ?=
 =?utf-8?B?RWwzN05DSFdOcGRieFRMT1oyNlIrRFQrZWFUc2F1bU5RU0ZBblQ0WVBSTkpn?=
 =?utf-8?B?VmRselhEM09kUmFqYUl6MVllNzRaZUt4Z2ROUGhhdzI0TFU1ZFFJR2JaWlhy?=
 =?utf-8?B?WmFlb01UdzBWSmZrQUFnMTFDN0RuVVNoVmdKU2paMEZEUmVHSXFxTFpQWklw?=
 =?utf-8?B?QjZvYXp5M1E5UWF2cCtkUCtyRW56eERjU2lrczcyaTVobElCa1RaUTNYdWRt?=
 =?utf-8?B?RG4rRkwxLzhGM25BWlZEbnRGb0JRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43E9A09719DF7A47BD2345AA46D8D29E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y8oGjfvGngUXBlwCkEWs5gvDKi/jL76/d5QhLYngQhjO4NudtrlWxUcrOHu0lhjsZAoRSwwLGTgMWaw7H8aPmGzyyCMqzhtMcf34e6dHjrRBJgz7cS5w871SwyMhta+ft+FI94kieyRob0TGZlnb+JsBrG7W7qzw9tJJrqbP/2yoqLDHDxqhhF7SYnfQnvVkBPhuva5P6B97KntHc7ZapMicRbCZGBR3Kp8lQjqls+EuH4ym9kZ0ZoE/g2KfveA4W4rZnf64H8LJ4CqEIIa8NziKIKSNHbZdKzKAgtKNaJqBuCUd+iECrmd+pD7PF2M1ID31VEvK0E3PbjTAOM2oEqCIacrjrHYzdworGgYjkiKe3VgSh1/g3Z3CoTXUnHptgdEIpwzWJWf+SwNS3lrCi5oJ0J0pAM+GcTFXKzsKiXZu8xZZC/ZIMLazL1leaJ/I8kl+tbWs9SDFT6DgseoQGEq4w6eIqEHybUD+gBGupnQZm74tG5tNvi3coXwihOOtIOBfaM49VYy6dMcsjo+5x1IarXN4PgVQyRBTTeQ7W067sqY36ugw3vc0PO3FRX8Ub4ZYQ1W5UEQMXZ9WgIThwL99oFzJBzM0qUDXHBvKS1JlNRnqIUDGG2d+XnZR8nHW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c61f98b-9883-48a6-95e9-08de160cf0e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 10:29:56.9601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mSZEzpZ7rIqY8oMyaXVx8XEZs0jzcmJGDUkvmOB21DTPOxOOpT1UR7hnC5w0Ambh+ALi5JN+Fmk5xFtkqV5VweyaVET2UbFo9r6vWcOOqo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9333

T24gMTAvMjIvMjUgMTE6MjcgQU0sIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gQWRkIGEg
dmVyeSBiYXNpYyBzbW9rZSB0ZXN0IG9uIGEgem9uZWQgbG9vcGJhY2sgZGV2aWNlIHRvIGNoZWNr
IHRoYXQgbm9vbmUgaXMNCj4gYWNjaWRlbnRpYWxseSBicmVha2luZyBzdXBwb3J0IGZvciB6b25l
ZCBibG9jayBkZXZpY2VzIGluIGZpbGVzeXN0ZW1zIHRoYXQNCj4gc3VwcG9ydCB0aGVzZS4NCj4N
Cj4gQ3VycmVudGx5IHRoaXMgaW5jbHVkZXMgYnRyZnMsIGYyZnMgYW5kIHhmcy4NCj4NCj4gQ2hh
bmdlcyB0byB2NjoNCj4gLSBNYWtlICdpZCcgbG9jYWwgaW4gX2ZpbmRfbmV4dF96bG9vcA0KPiAt
IEFkZCBfcmVxdWlyZV9ibG9ja19kZXZpY2UgaW4gZ2VuZXJpYy83NzINCj4NCj4gQ2hhbmdlcyB0
byB2NToNCj4gLSBfZmFpbCBpbiBjYXNlIHpsb29wIGRldmljZSBjcmVhdGlvbiBmYWlscw0KPiAt
IENvbGxlY3QgUmV2aWV3ZWQtYnlzIG9uIDMvMw0KPg0KPiBDaGFuZ2VzIHRvIHY0Og0KPiAtIEZp
bmQgbmV4dCBmcmVlIGlkIGluIF9jcmVhdGVfemxvb3ANCj4gLSBBZGQgX2Rlc3Ryb3lfemxvb3AN
Cj4gLSBGaXggdHlwbyBpbiBfY3JlYXRlX3psb29wIGRvY3VtZW50YXRpb24NCj4gLSBSZWRpcmVj
dCBta2ZzIGVycm9yIHRvIHNlcXJlcy5mdWxsDQo+DQo+IENoYW5nZXMgdG8gdjM6DQo+IC0gRG9u
J3QgbWtkaXIgemxvb3BfYmFzZSBpbiB0ZXN0IGJ1dCBpbiBfY3JlYXRlX3psb29wDQo+IC0gQWRk
IENocmlzdG9waCdzIFJldmlld2VkLWJ5IGluIDEvMw0KPg0KPiBDaGFuZ2VzIHRvIHYyOg0KPiAt
IEFkZCBDYXJsb3MnIFJldmlld2VkLWJ5cw0KPiAtIEFkZCBhIF9maW5kX2xhc3Rfemxvb3AoKSBo
ZWxwZXINCj4NCj4gSm9oYW5uZXMgVGh1bXNoaXJuICgzKToNCj4gICAgY29tbW9uL3pvbmVkOiBh
ZGQgX3JlcXVpcmVfemxvb3ANCj4gICAgY29tbW9uL3pvbmVkOiBhZGQgaGVscGVycyBmb3IgY3Jl
YXRpb24gYW5kIHRlYXJkb3duIG9mIHpsb29wIGRldmljZXMNCj4gICAgZ2VuZXJpYzogYmFzaWMg
c21va2UgZm9yIGZpbGVzeXN0ZW1zIG9uIHpvbmVkIGJsb2NrIGRldmljZXMNCj4NCj4gICBjb21t
b24vem9uZWQgICAgICAgICAgfCA2MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+ICAgdGVzdHMvZ2VuZXJpYy83NzIgICAgIHwgNDMgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ICAgdGVzdHMvZ2VuZXJpYy83NzIub3V0IHwgIDIgKysNCj4gICAz
IGZpbGVzIGNoYW5nZWQsIDEwNiBpbnNlcnRpb25zKCspDQo+ICAgY3JlYXRlIG1vZGUgMTAwNzU1
IHRlc3RzL2dlbmVyaWMvNzcyDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL2dlbmVyaWMv
NzcyLm91dA0KPg0KPiAtLQ0KPiAyLjUxLjANCj4NCj4NClpvcnJvIHBpbmc/DQoNCg==

