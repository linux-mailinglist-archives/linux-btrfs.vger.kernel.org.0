Return-Path: <linux-btrfs+bounces-11992-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AFAA4D111
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Mar 2025 02:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6BE3AFB9D
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Mar 2025 01:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F109156C76;
	Tue,  4 Mar 2025 01:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jTkr5jDK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DQLdtq/B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8A770818;
	Tue,  4 Mar 2025 01:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052050; cv=fail; b=h+m355pE68pQOjj2Pjt5ScaQ3bLqnAH5Vq19WbEK7aQjb0ypssd0Yn8/t9B8EmuqWRlCrWbyOwrbegw76NpiMLYRhYitt3Tz0qPQADcz+l/WHFOy4xD2Dh9b9XWg7qXesbjkemxIIpZs5yoJqUE9KMmjEGRpYA5eygvbtRfqrBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052050; c=relaxed/simple;
	bh=SKX07W8SRtkDrJq0irDhiuj6C2dgheStIzozI4qWiPY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F7eIYrWii8w+SlMBEwnQhBGuHyDN4k5UokxtnHkJDb0IUoCKNsYSz5KEM31aeypW2MRa+EAdmkGZSmOu1uLMgojiRkFTxO0tuMQLbvdLuZUlB7Vnhe6ocQuomGTNIdoYhee8GOoE9jSJw8TPxo3eWB6zssZh3CTb+eS86K/PQg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jTkr5jDK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=DQLdtq/B; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741052048; x=1772588048;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SKX07W8SRtkDrJq0irDhiuj6C2dgheStIzozI4qWiPY=;
  b=jTkr5jDK+Y4rWhhLEgb9u321F/qRffwFa7NSai4jLFxwKWhCII1dHh0O
   +0LIWWPNlxs97GyfU8TITJYVRoeTex2Si1soqLGHnq5HGznTGgpPvYob7
   d63T5AKb/1x1hOwmM5go86zYvfie1/wcTyPKMz7FLDJSgQ9HX6+b7Y7rQ
   Pj/7gqKWq+g/lDvvDdGpW4f3es3evDlxroLef18Ud2pAbnt+eKeqdbbwC
   pDx2rV72dFxIP9GlaqO1boifb6ZhfxW2b/KQvJcYOnqAWU0EWG2PQAoal
   Z5KjmhlhO6k6p71vdEwoWxPrVYXJwv7Ie7xzjxzWlZ8PqTbHWZfY8vAvN
   w==;
X-CSE-ConnectionGUID: 8PGhWRTASe+IwxtuhgkziQ==
X-CSE-MsgGUID: TnrBpNrHS6K3FYEncs5+SA==
X-IronPort-AV: E=Sophos;i="6.13,331,1732550400"; 
   d="scan'208";a="39960807"
Received: from mail-westusazlp17010001.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.1])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2025 09:34:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPKBjaikiWECxhqlCeAU12D0+rEUGQ7p/4unBAtJzlGFxMUtJvLv6+lWRZne6eaWCX2IqmtTKQUNfa1XVghxhtNX0Q97Zrzq8pRhKOdobOiQnwsl4GRRYt7VBE5tZ2CjFRnfQb8Eo/pH3RTWrIAxG7IvXZ03MY6RobS3KoTp7QJ2PUwxzpN/1+9LeuRGzl3w/uIL4Y7Du87JTzl87YNZTI58GchAxVjTM0M/7WUEbFVVHyDU2+GMVX/eNjzDB+0PAk6caK/9yu11L7xKwG3o8gPh297Bbn5Zh4k9NmNi7tbekdnYTSGpRRENTIeUVDD2G673WsbCBYzXb50XqoUC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKX07W8SRtkDrJq0irDhiuj6C2dgheStIzozI4qWiPY=;
 b=haFENeyW97T8/SKL5XKUTs0qXJV12FrZqM8nSej8mh636gfe7U5RHDSW7lqx+t1ElCX7CNZ2d1UYKV/msTZcLtOh6nKO0WjVfFAjU9s/7HsYxSCX5qYC3tMpvbFRwi3vSt5DmxXAY1D/Id7xUAveIUXjP/RA1skhxN7qFf/blgHaldV24vPwpnQCPL26IJCvzsnEvGWo/XPyNZjDFvMuz3UVbjegC9VlxoE4hQRJoD5TIfvPA6XuQjccHoDY4KcTdAZvvAguAFyh7d2F7TLmnpwmoqFShZv/9mR0H/Laa99+QEK64Ak+knztOCSHDWkHKbLjXuy4/ETL/b1FCpoqew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKX07W8SRtkDrJq0irDhiuj6C2dgheStIzozI4qWiPY=;
 b=DQLdtq/BW3FmObL+qAFXUw982mRN5pB3KxdmhZDf9elJ7sgGSDZq7DFFyYwpC7euOLFOGQUizOJA/D59VgYaYLwrbJ3AKAzI/hPfVU8lEcCWvFoPQDRdh3tGp/YmYqglZWONaITKRU3HuyPKkMY2962coPS7PdHQCuItsjRT9NM=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DS1PR04MB9276.namprd04.prod.outlook.com (2603:10b6:8:1ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 01:34:01 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%3]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 01:34:00 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Markus Elfring <Markus.Elfring@web.de>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, Chris Mason <clm@fb.com>, David Sterba
	<dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
CC: "cocci@inria.fr" <cocci@inria.fr>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] btrfs: Fix exception handling in
 relocating_repair_kthread()
Thread-Topic: [PATCH RESEND] btrfs: Fix exception handling in
 relocating_repair_kthread()
Thread-Index: AQHbjHtQuR0QMDeWAUOPbIm1biAX8bNiMgqA
Date: Tue, 4 Mar 2025 01:34:00 +0000
Message-ID: <D873FT11P5M6.JLH3TCARWATJ@wdc.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <cebfc94f-8fdb-4d5c-56ee-4d37df3430a1@web.de>
 <09fe60d4-8eda-42bf-b2d4-ada265a09ce5@web.de>
In-Reply-To: <09fe60d4-8eda-42bf-b2d4-ada265a09ce5@web.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DS1PR04MB9276:EE_
x-ms-office365-filtering-correlation-id: 4930b6d3-67b5-4338-6058-08dd5abca3cb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bFlCUFFPbmp0T0I1MVl5UzNkQStieXBRd25qMUNFYmxYb1cwcnVsbTExWG80?=
 =?utf-8?B?eHc0aHhRK2p3RTF4cVlVWXZTTnVvc244dUJkbHdKdmgyYThwMEhob0FLZ2Vu?=
 =?utf-8?B?bGhmYTZpakljVHFnT21zSXlCRjhsdWljSDdkMy93LzdUQXJOSDRLcUJwRWFM?=
 =?utf-8?B?OXRYMkFweFQ2MGdHcklSZ0NNSWNBQ0xrL2dXbDJwUXB1UFNWSGFlbnZVU2ZN?=
 =?utf-8?B?UVZuSUV1VGRrUTE2eVkxZUlFMk5kRDhQKzNsY09YQmJ0Qlk2VEpUZTZMNlNH?=
 =?utf-8?B?QUdTUWFvUW50MmtYcnRSLzNqVCsxMXFJakltYlZraW1zQktIQ3l5VUNsN1E2?=
 =?utf-8?B?eVlta0Z2NVFFWmsvS3VZYUxJSllYL0p2UUlCWmFJM1U4UWUrTmRqYjJqaFR1?=
 =?utf-8?B?YUZVVisvNDZURTJVMUlab0Q4a1YwMC9LeEx6VWRqVTZNcmErQXFvL0ZHcWdh?=
 =?utf-8?B?T3RrMFpGWG5hT0dSdk41MWZTa2FyNmJiaVNiZkJ3UnNsb0MwalFMQk85NWxt?=
 =?utf-8?B?OHhkbWN2NTJMUzBSUHNvZzdWSzZYem1YMVhTbURCWjMxMzgvQXQ0UkxYWXA2?=
 =?utf-8?B?eDFOcGMyQ0JjM2RlZFREM3ZhVXRXRkU5cy8zM1RBa0hhK2d1dGJWZ0FZL0FT?=
 =?utf-8?B?emZiYnR5Q2tGeWFOQnJ2UjZRaXhZRTlKTjlFSFFrZVFZTzUxRGtLUUZpYmhI?=
 =?utf-8?B?WGI4YTZpS3FMQzduS0QxTVR3L0czNmF3V3owcEVnSlFpYnY5RmpUZWRXUXlv?=
 =?utf-8?B?OTVaVVlsSXBnSUZsZ1d3aE5nemIrTVNNRGgyMHFLR0tvSkJDYlVVS3loWm54?=
 =?utf-8?B?RW1TVnFLSld4YmxreGRMRXBkV0RVNExlWXV4cndtRHRxekFsQUFWQzRGK3p0?=
 =?utf-8?B?Q0kvL1JKRUtxMXRwZTdpaG5vT0lTZkhuTVpwS1lhYWtaY0xuRzhBT01rVkc5?=
 =?utf-8?B?SmhjY1RWcDZCeGc5cFdQbm9NNlFFcCtDajdpUkxadCtKNStSaExzczBjYUlO?=
 =?utf-8?B?QXhpdEc5ZzlxNS9MbGsvSHN6eEZpbDhGYmhQcm9KdUtQRmU2dlJQM0lFWjRp?=
 =?utf-8?B?dmJrZXFiaTkwUUNWUWtDSXdSd21NQjNFQVNIYWpKZUxaNWpxWTU5WHl3RlJZ?=
 =?utf-8?B?d3QvMDBiNHBqSUZNSENmaElYdHJrUFFnYkVHeHBjVy9xT2l1RWorWm9iRU9O?=
 =?utf-8?B?a3dHSUJvVXpwZ3Q1S0N0OHRZSmoyT0hDS0U3aXBuUmQ2UUtrdEZJaHo5cDRD?=
 =?utf-8?B?ZStpRThseDlGZjgxWTd0MzBLUVZLRkt5am92NVdabVN4dVhvNHJXcXpJSU9P?=
 =?utf-8?B?ZEliZzJxSXB5eUdiUUtrVmhybXRRMkxHZnJrVGVhWER3dzc2R2FPZUlVdHRy?=
 =?utf-8?B?cE16YWJISi9wRVBCWWhtOVZMYXlTMFIyNXRKZ2UwZDJTcjRtc2oyU1NBTGNZ?=
 =?utf-8?B?ekRuNmEvUG1WSW9OZ011YXNuZXFTSkdyU1I4eVlOTnBFRlZ2UmdPY3QxZnBE?=
 =?utf-8?B?NmFUc1Q3NTlGZVdNSU1OZisyMW5qNWtqRmozcHE1cnNvVTZUcWlNR3hGOW1K?=
 =?utf-8?B?dDNOZVljSW9DU3ZxSkFoRHB1a2gzWldVaHlZWTh4b0RVMnFUQnFRTFd0eG42?=
 =?utf-8?B?UVVSZVpYVVFjZ2psZHlSNU0rOTJMZmVQcGpyTGhDUmpsbjBsMXN3ZGJSNndY?=
 =?utf-8?B?UXU5WjFOUmZMUWZOUU5jYW1MUDgvUkxJOW5jVFZJTWhvdGZCQjcxYnVDRitT?=
 =?utf-8?B?ZzFMdjZVM1VyUVhJdzMzaU05NEZZcHRoWE9yR0lWelFFMXJneFIxWlUyRXV6?=
 =?utf-8?B?clVMSEwyVjc4RlkwY013T2xnTUZGSXdpZWFyRG5nRXh6ZlN0NzdRdFlLNjlv?=
 =?utf-8?B?WUdXY2xDK2V3b1R2VE1pd2VQaUxqdGZiVTJDQVRzcmdVcVhqTkxmWHArYzh1?=
 =?utf-8?Q?rcc71oF3KCDdSrL1piPLSzDfpLVfbrMS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmVzckt6ZkdkTlgwSlRyclh3bzU2YXBXQk1sc05RVVg5ak1Odm5oQnR1d3pZ?=
 =?utf-8?B?TWxzOWpMVVpneVBMY0dkRVhHalpzcDc0SlJMUUdJYnI5cndkMzZwc2t4Si9y?=
 =?utf-8?B?cjA1SnBjVTdzVWZ4MnlYWHdoVGtIU2ZQcWNrWUoxNEhaNGZTaUlxd29tQU1U?=
 =?utf-8?B?YUpOdUVSMEFWd1hJZFJSZ3ptdXdSVUhFVWVJdnRBZ04wV0NTQzIzUnVmbStk?=
 =?utf-8?B?YkdIb2FqbFhJbnVudjhIOG5DKzQ3M2t2VVdXdEZhTXhaTzgvLzBONjE0RjJF?=
 =?utf-8?B?Qmk3ZGZFUWFCNWZJaVUzYjdVUlJ5WC82VUtjZUROdG1ZNUw2Z2VsREczMFYy?=
 =?utf-8?B?TVc2VVUzRnlhUERaVnAyMkZVTXNDVTV1OTBPaDI5MXg2NG5yWTBaNTBSZEcy?=
 =?utf-8?B?UVI5bEtLOUxGRkV0V3BXZWNLaUFZeFdmSUlzSkJqWDJtVUluUHAwQVh5TWFC?=
 =?utf-8?B?QjM5bFBQbWtTU05uVGVVN3oyaDZtZEgycHR1UU1ZSGU2QXdDYzczRG5YdTNN?=
 =?utf-8?B?cnh3T09HUHdnZkh0QUtoQnk4K2NBRXRlMnlTUjgzU3lBS3ovY2tjQTl0R3ZL?=
 =?utf-8?B?MFlRUURUNDk2cTlFOFNnZDlFMU1sV05QYXZveGQ2azcyMy9QSXFpblVJTmxU?=
 =?utf-8?B?aDNiY0FxZTJHaUgrZ2JmUlNuMitPeFJwN1NPVUw2aXcyS3ZqR2x6QVpXS08r?=
 =?utf-8?B?T0tBcFFWcm9Nby91M3NKMEFjbVlVTnJlN1YvYml2QTFjUGFIUlRZVDBFTjVm?=
 =?utf-8?B?OVhIVW9WT1N3UzFkM0xjZDhkVUZvQm9oSnBQSUQ0NTduUE9YRjBVS3RvME1C?=
 =?utf-8?B?TWVEV2pLUlR2YU43Qm9zY3NBVTlkVHJiWmdFSkpGR1ZnVERyQVFJN1FHWnQy?=
 =?utf-8?B?UGMwaUpJM1NjazhHN29DclFuMGRmMWxlbjd0T0FnN00zRkc4U3FJekcvNTdp?=
 =?utf-8?B?QjlMdjg0WFVtZDBPWnU0em9JVElLNnEwV1IvOEhERk1SQW8wdnBpcUxtMGhp?=
 =?utf-8?B?V1FnUXAwVEJMZkRpdXdPaFQzRzMwbmVUNmROK3IzOFNsbmxXTFoxUWhRVUNx?=
 =?utf-8?B?bGZtVXZKZUN2Nmk4eDdnL2FuS0doQ1IvYnl6UHhNam5ROE1saCtOdjcvT2oz?=
 =?utf-8?B?TXluM0NneUVzRGVFcDRRcnpCN0F4UktLT29zcno4NHFhRk15VEw5b3lFeXZT?=
 =?utf-8?B?bWhpMU41Q2RHK1RxNlRPVU8rOHU4WmFiZkt4UnJXaDIya2JiaTg1UzZ4U2h6?=
 =?utf-8?B?S2lwVSs2cjVpTWdyV2NKZlg5MlhOZXAxUjQ0UkZOZWVkdWNvTnZnMTZ6M2ls?=
 =?utf-8?B?a3QvWXBnWWo1UFk1MUpGQno5TStzemNnRFcrL0k2K3h4Q09xbHZrWGU0bGh4?=
 =?utf-8?B?M0pCNEw5ZDNkOExtdDFtTUVmSURnbzJJWnNLL1grZXdCaStqRENSSlNSOW1S?=
 =?utf-8?B?RVRpYkFvbmpCT3ZWRGlTWkhHSkZZYWdOV2JrbFpmcHZPMjhPMEduNVB3ZHRx?=
 =?utf-8?B?R3RWci92eVpodUg3NEh4c3QrbGEvQk9tbllDNk1wd2p6Q3ZXMThvMlFmeFVn?=
 =?utf-8?B?Tk9idHlEdkxid0Y1K1VPTHRQelFsK0VtSUlRYnQ3dGZtd1lKaS9YNUJ4WVVV?=
 =?utf-8?B?RVByeWNWQzJhb29aTmdIM2V5QmxTM0JHSVgzbFM1akJ3clhWNTEvbHNENWx0?=
 =?utf-8?B?TlpYZTNIY1N3dGs3TDVwU2xuQy9sUzVCM0FsczhXV1JVT0orZm5mTFhkK2JG?=
 =?utf-8?B?VkJ2dk5mR1B1Z3ZpRnhSMk9kZ0oybnJRTlg2ZXJValZNMDVMRWsyNmt5VHhU?=
 =?utf-8?B?R0RDdDVQMkhFaDQ5T0wvdk9pR0IrdWg3YVBPenN0Q1FpdVIzU2RiT3NHM0tL?=
 =?utf-8?B?NG9ybXdYaVFXL1RmbWdHYmptelVTK1hIb1c0dTFlNHB6eTVkUzdMNGNhMlRP?=
 =?utf-8?B?UFI1bGFUaHBQZnZROGlFM1lWN05MK1AzWHN1d0ZKeGZWVXo0R1BjcUNjeVI1?=
 =?utf-8?B?cFVMOU50VFpuLzVaSWRqdU9SYnVheWlXb1IyTC80RVo4bWduck5ZdGdDTUEz?=
 =?utf-8?B?djNWK0J6bC9FSFh1RGRTZlNIWWlpOVdwOVNTY0V5dlpGeHZHUGhkRnNVRDlJ?=
 =?utf-8?B?L1lpVVBjd2tHa1hTOWZUdnhiT3BuMGhBMWxoUVJ1L1dpUjFxRHNGVE04YThD?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A12821B04B157479A0734E41E275ED1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	35sfCkaKFp1tplWFn21qwN/ChL7KZVCfzqzBBWbMPQ05QMX6jnc/cfDyo7de+w+ChM0uP4TrOW5vVkYssq5JO5awbtyDQrNUcn94kNx/IpQJFXEzZ60dDFUpgDfbpFovuj5nmfwqxRzvg+NsKXdLVmpM69JQL9ifiB+jhGazAcrv7CMIZ8IiExfYpAQ62nz5qp+ier6mnLPbjBRjC/0MvLjIyJf49MoLSIjfU9+EneJeHyL4e1r58KypFhLy1/T29C5nX9DcvxNpC/gfUiOrg8vs3n3Vovye+kEZyAWLIXYgLVuqPoN4oecgff4qAJmqKtMo1drXA61kEDwN3dtsZjwYNdcqE9ndivr5hOCRq74EAI5nU2hJhXx+tryYgICIggM61Vy8gO90DgbnqlwrvbPttRSGE6SNwxhy8L01yGzAZIxCii/FQxIjch8T79LqwfpnbbvIHYxSXgqNU7bGgXxi9NDa99LhFbSStxKz25uzEdPgxMS7Vg4nQXQqTAxd9R8ASjIfYgNpbwwVUA5q+wzVFlpW/8Kg0L4XeECsv0vUId8zyLNTS4OLQJODyBuOQgO1Z75GUhgW6nbq5zODB2dkioqZdBxqXI19KgKje36V8DRnjxOtiFZ7o4Zr4u5z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4930b6d3-67b5-4338-6058-08dd5abca3cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 01:34:00.4601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OTVrqKkjch3GCzaNRfgTx8Z17g67Npgo8lsEwQMNOp7bdLRRuNFppdyRNU2sm+bqtufWREjyf/HlCz3OzcatNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9276

T24gVHVlIE1hciA0LCAyMDI1IGF0IDU6MzEgQU0gSlNULCBNYXJrdXMgRWxmcmluZyB3cm90ZToN
Cj4gRnJvbTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0Pg0K
PiBEYXRlOiBXZWQsIDIyIE1hciAyMDIzIDIwOjEwOjA5ICswMTAwDQo+DQo+IFRoZSBsYWJlbCDi
gJxvdXTigJ0gd2FzIHVzZWQgdG8ganVtcCB0byBhbm90aGVyIHBvaW50ZXIgY2hlY2sgZGVzcGl0
ZSBvZg0KPiB0aGUgZGV0YWlsIGluIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgZnVuY3Rpb24N
Cj4g4oCccmVsb2NhdGluZ19yZXBhaXJfa3RocmVhZOKAnSB0aGF0IGl0IHdhcyBkZXRlcm1pbmVk
IGFscmVhZHkgdGhhdA0KPiBhIGNvcnJlc3BvbmRpbmcgdmFyaWFibGUgY29udGFpbmVkIGEgbnVs
bCBwb2ludGVyIGJlY2F1c2Ugb2YNCj4gYSBmYWlsZWQgY2FsbCBvZiB0aGUgZnVuY3Rpb24g4oCc
YnRyZnNfbG9va3VwX2Jsb2NrX2dyb3Vw4oCdLg0KPg0KPiAqIFRodXMgdXNlIG1vcmUgYXBwcm9w
cmlhdGUgbGFiZWxzIGluc3RlYWQuDQo+DQo+ICogRGVsZXRlIGEgcmVkdW5kYW50IGNoZWNrLg0K
Pg0KPg0KPiBUaGlzIGlzc3VlIHdhcyBkZXRlY3RlZCBieSB1c2luZyB0aGUgQ29jY2luZWxsZSBz
b2Z0d2FyZS4NCg0KU2luY2UgdGhpcyBmdW5jdGlvbiBpcyBsb2NhbCB0byB0aGUgem9uZWQgZmVh
dHVyZSwgY291bGQgSSBoYXZlICJ6b25lZDogIg0KYWRkZWQgdG8gdGhlIHN1YmplY3QgbGluZT8N
Cg0KT3RoZXIgdGhhbiB0aGF0LCBpdCBsb29rcyByZWFzb25hYmxlIHRvIG1lLg0KDQpSZXZpZXdl
ZC1ieTogTmFvaGlybyBBb3RhIDxuYW9oaXJvLmFvdGFAd2RjLmNvbT4NCg0KPg0KPiBGaXhlczog
ZjdlZjUyODdhNjNkICgiYnRyZnM6IHpvbmVkOiByZWxvY2F0ZSBibG9jayBncm91cCB0byByZXBh
aXIgSU8gZmFpbHVyZSBpbiB6b25lZCBmaWxlc3lzdGVtcyIpDQo+IFNpZ25lZC1vZmYtYnk6IE1h
cmt1cyBFbGZyaW5nIDxlbGZyaW5nQHVzZXJzLnNvdXJjZWZvcmdlLm5ldD4NCj4gLS0tDQo+ICBm
cy9idHJmcy92b2x1bWVzLmMgfCAxMyArKysrKystLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZnMvYnRy
ZnMvdm9sdW1lcy5jIGIvZnMvYnRyZnMvdm9sdW1lcy5jDQo+IGluZGV4IDZkMDEyNGI2ZTc5ZS4u
ZGUxMWFkNmM4NzQwIDEwMDY0NA0KPiAtLS0gYS9mcy9idHJmcy92b2x1bWVzLmMNCj4gKysrIGIv
ZnMvYnRyZnMvdm9sdW1lcy5jDQo+IEBAIC04MDk2LDIzICs4MDk2LDIyIEBAIHN0YXRpYyBpbnQg
cmVsb2NhdGluZ19yZXBhaXJfa3RocmVhZCh2b2lkICpkYXRhKQ0KPiAgCS8qIEVuc3VyZSBibG9j
ayBncm91cCBzdGlsbCBleGlzdHMgKi8NCj4gIAljYWNoZSA9IGJ0cmZzX2xvb2t1cF9ibG9ja19n
cm91cChmc19pbmZvLCB0YXJnZXQpOw0KPiAgCWlmICghY2FjaGUpDQo+IC0JCWdvdG8gb3V0Ow0K
PiArCQlnb3RvIHVubG9jazsNCj4NCj4gIAlpZiAoIXRlc3RfYml0KEJMT0NLX0dST1VQX0ZMQUdf
UkVMT0NBVElOR19SRVBBSVIsICZjYWNoZS0+cnVudGltZV9mbGFncykpDQo+IC0JCWdvdG8gb3V0
Ow0KPiArCQlnb3RvIHB1dF9ibG9ja19ncm91cDsNCj4NCj4gIAlyZXQgPSBidHJmc19tYXlfYWxs
b2NfZGF0YV9jaHVuayhmc19pbmZvLCB0YXJnZXQpOw0KPiAgCWlmIChyZXQgPCAwKQ0KPiAtCQln
b3RvIG91dDsNCj4gKwkJZ290byBwdXRfYmxvY2tfZ3JvdXA7DQo+DQo+ICAJYnRyZnNfaW5mbyhm
c19pbmZvLA0KPiAgCQkgICAiem9uZWQ6IHJlbG9jYXRpbmcgYmxvY2sgZ3JvdXAgJWxsdSB0byBy
ZXBhaXIgSU8gZmFpbHVyZSIsDQo+ICAJCSAgIHRhcmdldCk7DQo+ICAJcmV0ID0gYnRyZnNfcmVs
b2NhdGVfY2h1bmsoZnNfaW5mbywgdGFyZ2V0KTsNCj4gLQ0KPiAtb3V0Og0KPiAtCWlmIChjYWNo
ZSkNCj4gLQkJYnRyZnNfcHV0X2Jsb2NrX2dyb3VwKGNhY2hlKTsNCj4gK3B1dF9ibG9ja19ncm91
cDoNCj4gKwlidHJmc19wdXRfYmxvY2tfZ3JvdXAoY2FjaGUpOw0KPiArdW5sb2NrOg0KPiAgCW11
dGV4X3VubG9jaygmZnNfaW5mby0+cmVjbGFpbV9iZ3NfbG9jayk7DQo+ICAJYnRyZnNfZXhjbG9w
X2ZpbmlzaChmc19pbmZvKTsNCj4gIAlzYl9lbmRfd3JpdGUoZnNfaW5mby0+c2IpOw0KPiAtLQ0K
PiAyLjQwLjANCg==

