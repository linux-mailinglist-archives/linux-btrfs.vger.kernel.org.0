Return-Path: <linux-btrfs+bounces-19793-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8001BCC424E
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 17:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04E2C3006D94
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 16:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAC0285C85;
	Tue, 16 Dec 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o+9eoMfs";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LtyrvxhD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981FD1DA60F
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765901457; cv=fail; b=urnCJaDuxhahezMG27sHxrcLkiokB/qWmuUoYn8aUe+hcrOcjIyXNAU25yHNappc7qe7k1ylFnPTDCwap4O7hRFMrlf5uNVGQ+NTKYHcVC7OVgDbT9dzDEqz+qGnc3v7ViJyQQFqyH/3i/KhoO1HcC/IYQba9QsLIFegQCMVkpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765901457; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QOSuTMzmQRNsWKK1d1RXgRphzXw3wHbZXZxc5YLxbjnlw1H7gsRMNotCaw60wyoNdN+5WaAbyhHfUDgWFYoF6W/6MvH2k32BPPXP+991pKOH+9Qx0xrXngnkcKjqSW0kNvLNx0FhMdv+Mm+BOPf21zstc9cr/8l9wrz+E4eS6GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=o+9eoMfs; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=LtyrvxhD; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765901455; x=1797437455;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=o+9eoMfs+HMk3c69iWZZa92r4O8t1DM0HQAtd/ti+l/hHTaqPDdaxr4M
   NND0JXjznjBIFzircn9kZdc+7BIqx0dhv2OwdeALp6i8sv69tnfCUpIQe
   w6e6Zfe8VywNzTFOQENF6aeRc/k/CqWk1afjzkmpNKl1lagQA9cnEFcOK
   DY2Xp1zvlaGjFei6q2/x5HFOu2MWofwrIku0AnyTOM2jfi6025gqt7bEk
   Xhz8p6T6eruWM36yr/9WeEEEj0L9lINPnDAG5SqPV+75IwdqZCrwdNjaa
   medsDjDLFHsAkoLHj8ClNS1MkjFTl3KLdo6tueq2H0+L7+p3dUEJK1fqG
   w==;
X-CSE-ConnectionGUID: HJmh2hNHS1iNZV2hDD48sQ==
X-CSE-MsgGUID: T8K0R7/tSsi4m3bI1gXxaA==
X-IronPort-AV: E=Sophos;i="6.21,153,1763395200"; 
   d="scan'208";a="133969082"
Received: from mail-eastusazon11012060.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.60])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2025 00:10:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8X9NMoc763z901MRZK/NPPduVLvmtoPRIe8cccFxeXeXkS+Y624q85T6ReZJdatWJzOI8Df+NA9cAmzaBrj44cHJntPgS4hkqY/k10WsTBHMLnx1PSKY4chLzGlABzhK4FIbvf+zZVSbRMcgZ0XIMI8fQ8vVSz+7UnTrI5vl0xHgchWiOTG1DsYJFqjdeGLtB9k3bbOjk+xe97uPe2S5iquJ7VBizG+cP9Ls+w7/itas261JPWn1ICBFjioq+0vZFyMT2RFBT6hvDcfKysFvyRDnVqySBwYXtWz+2i5e3MHM49YvYnXOGecqqlTJwEUBYjWijjUGNPzsPsLammhuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=OpJyH8aGXNQxatOhMLmw0npETpcBhsFDoALeq7QuJ8OkCUNloDkJdj6hHa71TtHQJT8tmrgXMoiSADnvmRvNB/LiiDK+KaixFDT+8NrEdxV3PqF/8Om51qnOdyMFiAaWXW5WMa7C40km1JmaId9lq2PhnH9Lp9EsYQYQAZO6ZsMucHnxpT0LIbUCuu1VTiBEV15r8K1x6szLGsy/OgGRHdZqIBJceq/OUSsB8Prj1+BS/TI9f1x13zvuhO9Fav6RC/lOo0apCeAEci63D2YH4NcHKfBE5S1PnxT+8DAB2SH8hKJWBdA4S9Wb6TZjXJ8YyHMBBW3V/PnOMZN0HY1l6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=LtyrvxhD6YN9BLuaxe57og3W2fSbiislHoJp6dz5+8fPCf/kEm4mG1rGsrh6P60ZZygHlPXp7n2/2zWbBZlEGgMLcMPBm18PDCKcTGneHmal4iEA3ZyPMbmiYTjomCwfJ0MrPBzt5UwXlLT1vPw5KTG3bOtkXCPwFowtkIlDcmo=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SJ0PR04MB7726.namprd04.prod.outlook.com (2603:10b6:a03:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 16:10:52 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 16:10:52 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: avoid transaction commit on error in
 del_balance_item()
Thread-Topic: [PATCH] btrfs: avoid transaction commit on error in
 del_balance_item()
Thread-Index: AQHcbqXeJHGSy4T/HUylvPLQKHTEt7Ukb8yA
Date: Tue, 16 Dec 2025 16:10:52 +0000
Message-ID: <3f2fd0c1-a6fc-4967-b11f-926c68d99eef@wdc.com>
References:
 <de940c4488c9be72d8df22f48651b3c2f7d2978f.1765900568.git.fdmanana@suse.com>
In-Reply-To:
 <de940c4488c9be72d8df22f48651b3c2f7d2978f.1765900568.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SJ0PR04MB7726:EE_
x-ms-office365-filtering-correlation-id: 3ce6c5bf-e264-4056-45db-08de3cbdaf6d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y1lMNXN2SVZBNUl2NEFWaForbVk4TE41OVh4a3FRR0F1M0doLzNMcDNGS3dD?=
 =?utf-8?B?RzhvMVFVVUpXdUJ4MjdUd1FzVlBUOHdVbzR0ckhPaWZNRy8ydldHd3IzSHVD?=
 =?utf-8?B?ejVzSTV1ekdCdGkreUYrenZvSFE4STJoWi9odUU0VDB2bmk0SU9VR0xIMGs1?=
 =?utf-8?B?QzBKVmUrTXlsSmlBemNibzBhQ1Q4R2FBSHEzczRpM3lQNXhnWHJsQTRtZ0FI?=
 =?utf-8?B?L0Qxei84UDBSbzkzRk94eTAzZWRCV09rQWwwNW9DcjhuSUFLalBlOWpqSlJy?=
 =?utf-8?B?bG05Wk1yVnlxR2R5SEdNUnRLWExTT3dZbDB2S2dSeGxRR3lSOHNMMkxCTk1p?=
 =?utf-8?B?a29rcklBMFZDRUh3L09NMXNCQUl5cXFISXJYSFZhTjRjZ3U5N2FDR2pZdVly?=
 =?utf-8?B?Z3VKdjBrOElXRGIxc0VPNFlpZ21YcXlFRHdRc2pLSEQvUWlKQWRDVklrZDVY?=
 =?utf-8?B?c0VrSVRHaFBLSnJudHFKUmVkdVEyODYvbFpxUGc4YXVONEpkZEtzTkZtK3BC?=
 =?utf-8?B?NTMrOHo0eGZZN0RJeXJFbTZZSlR5Z3NpRTNiWXk0SDlBdzVVYmMwMkROZGxN?=
 =?utf-8?B?NXl1ZHhaeE05VGpDQlRzdnZZamVZeW5pUnRrS2JPVHQ4enNvS1lmTWdXZHFM?=
 =?utf-8?B?VjhyRmhWSkE0M0JmekJoSnJvSEZjYU1TakllMks3RDBwVnIwblhtbjErc2VE?=
 =?utf-8?B?S2Q3V2ZWbkk2MVNnRTdzU0I5Wm9DT05mVDZyQllrVXV5ZHRlZDhEL3hxN1lp?=
 =?utf-8?B?OXM1dlJhak9ERzAxMVN1WlJ3eXJNaDZuQ25oL2JEVHR1OFNuWm9OZTBBWHQ1?=
 =?utf-8?B?dlB2M0tyM1MweXJud1JSK3FwbXd5b0Y2UHIvdTJyUnY1Vit5dXlQV3B5VzZi?=
 =?utf-8?B?WHhydjc3WFQwazYvNVNlbGtWSnBwQWo5cXZoUndLNHJOQzF3ZFN6TWNKdUZG?=
 =?utf-8?B?VGdhV2VnMTFjeHpGSUNTMGk4THRoR280clFMcmpDRGhBZnpsM25HZVJ3WTVa?=
 =?utf-8?B?VEJyZWt1elhSN3dxRzdFdkxjalc4UDBoREVxTmpVOGRhZVhiNmFST3VaWVZI?=
 =?utf-8?B?UkN3RGZwa2hmNFhCRE9mMjkwekw0RGFZRy9na3d2S09YR3FYeTl3SnV1OGw0?=
 =?utf-8?B?Vm9kRThId0h1alRpYVFRQ3YvN1RHVi9wZXRkd2hLY3FGTEIxTFBNK3RaMG5J?=
 =?utf-8?B?Yy8wMmt4d0dJZGxicFE4SVlDRWpTTkZ3MmxQbGQ5QnAzeDdsTzJOZEJVOXZ0?=
 =?utf-8?B?b3RDb3NsZk1ZRTMwSk1WR0ltb3JEbm1nMUd0dm5DSTJLK2xaQStGa0hmZmU5?=
 =?utf-8?B?RFMxS2l0WE1vL2lxMG5tdC9NU3B3S09ZYTJBNEVoS0Q3MGxaZkFacXZQL0Nr?=
 =?utf-8?B?cmdwYm1pUzVVOXlWRkkrc1h5aHdtR1VBeUNsTzlONm1yWDlwMVZIanY3cTB1?=
 =?utf-8?B?U1lIZHZSWHZSYWZQaldSZk4zMzRZOVA0bEthTU5uTFNLSXZxbUZPTDdLK3dm?=
 =?utf-8?B?bkZsMUsvb0R6VnNBSWtndW1BdnpQUWNPVVRxUkNLZEdTN0s0dW9jZnQ2dkx3?=
 =?utf-8?B?VkV3ZXExZ0dqK2plaFBLZ05CakxBOXl6MWg3UTJzNVdHU2M3RHJMM09OeXB6?=
 =?utf-8?B?Ny9yYm80RU9QZU43UnlkQUhQYTlJMjdIaEQ1TlRvZHhNZ0Z2bm45SmtKVFY0?=
 =?utf-8?B?eldxSXJsbVB5d1J2ZzVGM3dJcjRTbW5PVlYxNW1LcTlUUkNCQ3dLZGNPNXlV?=
 =?utf-8?B?dUdpY1hYMGpyRGtia29WTVhBRURwMTd6bFhrOWt2Q2JsdGM4MWNzNHJ2UUpF?=
 =?utf-8?B?YmxkRnNvMW8vVGJLRS9ZallHYlVQME02V2Q5eVIyUW5YR0ljWk5nSm0zaU5i?=
 =?utf-8?B?NEFpcHp3Sm9TeDkyNUJtRWdGM0ErTUVNcTJoZE9xSG5LZEprUU5DYXhPaVJs?=
 =?utf-8?B?TXlGQVZoVHIyTCs3VWVBdVd0UmNTV1hJcTJpbjhMZjBIK2lralVYZTk1TWxD?=
 =?utf-8?B?Q0VuNDVzSkt0R0t2WlBDczcyN2NmR1NYdEcxRjQzRUNWanVSbXI3em1UVzFL?=
 =?utf-8?Q?PQQm7O?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFhrTGFtb1lVWWR4TGFnNFErQno0OUcyZHppM2lOdEp1aDczRHhhdkN2N084?=
 =?utf-8?B?TEl2YXYzSXR4NGk3RUZtK3I2M2IyTlFvOUtLYS9JbjA4YjJONEJzYzlWckll?=
 =?utf-8?B?bGtvaTkyK3BPOWk3dUVVTUovRDBSaDVpQXNWVG9IcDAxUFE5cVVsVk0wN2hO?=
 =?utf-8?B?WHBQODVwbys1T1JiNU5jMWkyZk1NYThjY3F5Z0dja09iNHVuUFJEb01IT3Rw?=
 =?utf-8?B?bGdLcUIwWTUrTlpFOGhVME5qM2lvSWZTMnFqeks5OWFDcmdCR0NSNTU2MkFx?=
 =?utf-8?B?RHlOVmhMcW1mMEpuc3dSc0tCeHQ3Qm1LSEVjZXg4ZDZzRndNcmtjSU0xKzA1?=
 =?utf-8?B?ZjF2Ry85cTFaZGJDdmIvL0VFSDcwaTZLNkpydUd1RDBseDZ3ZkRZcVRFUVBy?=
 =?utf-8?B?cjNaN2VkaFhiemFNMU1VK3FmQ3BianBBS3lvUFJiYWdqRFhxcmtLUGcrUjV2?=
 =?utf-8?B?K2lVb3hSVGVlSjYxS01haW9BQ1E1a3RrT3JFaXNsQmI5ME42N3B3YjZTbEQr?=
 =?utf-8?B?dWQ0ZGN2aFdmRVVucXhMMzRyWmxlZkc4TG5KTFhEWVdKUjVVK3M0QXBjSkdT?=
 =?utf-8?B?RGZ4VjI3YVBnSFlJbVNnRWlxL2ZWRVd5NFVETFNYVHVsak13aGpISW9jdVdU?=
 =?utf-8?B?bmc5eWdZSnZQVTRpZFJwaENGb1N0dVpPMTF4d3lQc3huWUtodTBsQkw5ampw?=
 =?utf-8?B?NGd2YWY1dnl0eG9RZzhIczFhUUs3eWFCbTVmRDFHVlJjQnljL0xhV2xEQWdC?=
 =?utf-8?B?UXFTOU1GVEQva2VORnZQTmZRUkVWRXVOeUI5MXlHODFVR0JBenA1eElTaGpo?=
 =?utf-8?B?a2hsRFNPaHY2Z1VDZGZ6dk5HaC9pZ0RVWUxETk1Zd3ZienNEczBLQSs3cDdo?=
 =?utf-8?B?OU1jNnZRcjBzNlgwWGljbFN4NGJXc1dERG5iMDdmU2d2dlVZbnNYcTQ2YWJr?=
 =?utf-8?B?QVptazVLaUsxL1JubjIzWXp5cXJHRldJZHhoYU1FQTVmMUo4OG5EcmI2RUY1?=
 =?utf-8?B?R0xnc0Q3bi9FazFGL08xa2lNdTVaWDFUSXVWU1FsQ1ZCTVpveUZzeElVTVBX?=
 =?utf-8?B?Wmg5dzUvV0tGS0U4U0JCK0dCWmw2cXlqVWNQeDJyY3BiWndFWEVEL1B0aFVB?=
 =?utf-8?B?Yis5eDFleGsvYzliOThLeXFxa0Rzb0NOWGovSTIvNXl1bU03TW5qOGk1NUcw?=
 =?utf-8?B?eUw2RHdlSjBlYmwyTC9aTXVhRm8xRzdKejBpSk14dU8vWFNSa3JHYmZ4VWlj?=
 =?utf-8?B?dGhydTJHTmNDanVjSDVTeFlYVWRVSjQ1bi9PZ0d5cXR3REFlQTFNTTVCTHdX?=
 =?utf-8?B?azU4ejdsRjJZTC85dmltczdqdDQ0NnVUdHpLN1NHZERjcFVzMTRDR1Q0RGE2?=
 =?utf-8?B?OHU5bGJQcU5EZW9jTEZMWlhPU2IxeUZyY1FaODRadjdidEwySkt3akxEMEsv?=
 =?utf-8?B?Tlc0NXk1NGpEYnA5bzI1R1k4emk4T05YV0tjWHR3Zkt2NTZNSncxYnNKNnht?=
 =?utf-8?B?ODBESlRadWkydGNmWHpGVjkzVkJGMXJiZzdCNFA3RWNLTzFoWmp4WVF6NmZ2?=
 =?utf-8?B?RWxHZE85N1NvQ2NnWXdOSEJWV29DYVdwRENQOWJzRGpudTdqMVNvYUZSd0U4?=
 =?utf-8?B?NnpRU1ZmU0dKK3F2TVppR3pDSzFRRkNjL2pWeGFqTTBOMU9ZOVpxZDZENm96?=
 =?utf-8?B?N1FQcThWZHdsdmlVbW5pSzJJeXhsUU9HSWtlbnVGSFdiWENZZi9MNWwyWEFW?=
 =?utf-8?B?WXFPVkJ0RGIzNmhYRmRYSjFGNG1DaUZvelhEWVEvWk15WHZPQktZMU8xNFY2?=
 =?utf-8?B?alZBMHQvK2JZQVdYTTN0M0FkV0V5Y2lET3F5aFQxQnJSS2RWV2VwdEF4QXNo?=
 =?utf-8?B?VjB6c3dxemYxUW1pdnZuYUFNbzF6SkkySWJNai9ES3J4TXRpdEc4NGdLdGl0?=
 =?utf-8?B?QVNvSGNiWGFJTGlvajhNWExoUnRmZTF5Q1NXY2VqWmV1SUtmbWpXMkFNaEdy?=
 =?utf-8?B?OUx1TUVzU0NNZU5VM1dRZjhMSEF1eFJiaUltZEpvVDFwT0hDTGtSaDZKNlov?=
 =?utf-8?B?MkJySWNvQ0ZwSDJPNnFWYU91QUN6bEdYQlJxbHBINmZucHRpNWVOMS9RTDRy?=
 =?utf-8?B?ZEZiQkZhUm5kRkZkWVhoRnozSjFnaDZpdHFkbE5vNUEyWG1EVVZUYk9YWWJh?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FE91FE2FEFE854184FA5CC7CD6097A3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6Jmj5shzXIjxYGf+fgz3XunyzX3Cimpo7wYK0c2j+zQg+SsAqrx2l/bnlefetDUaCCjwPLv2aelLB1D9vD7epQcs23Zi02/2mAkek04TlGMJPHFuPXTfYa/VmDSIvQmbOJ/0jRPnDt13iW7dPuopr/NXDmxjj3jutaup77BW5xnL9Wv9TGsgEIG1tXBSRbzagzoWu/WLon/G8j5fu722qUqC7UvMEqpJVxAGMkfaEVJO5SU1MhoqlOKNVfi3XzN2ShZCFgPE0n3DcCaXHmLuHYkvmYNUED4zDTM0L4nI3zu1gWc2l3NDKveIQChVJQiErJHRexZTU6+hRuaQllenl1i3NQPOBmD56EVVyAil4ObyRp8afh+YWxQ0ZUC3IZO65m6ySMyNOh3zvh6woHwXlhs9FtWeLmc55lmnlXHc25U4biCJd2ikpt6MebGbaof/eRcpKNrxGN4cMuYyvbP2dnN55kEDTKBxW7SXVUxCENaVMO32sUPcxzrbqeYnHhFPMWZYl41rkLDI5i4bjDa485E/T7aD9jGvpBv0VpyN4eeZ8j+WPFNQyJ/GUTxKPLSlXtopZ0nrtI+actLZN909OtiNqR6sPxSBLsWUsvRzdk6EbGXy2kkQclXlkoqlKpAG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce6c5bf-e264-4056-45db-08de3cbdaf6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 16:10:52.2250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pw3AFqRO7GcVGpW9/7+VNSVeJkGgEDwVFEH2W8ucPpS+q8tasR+cp9bIgZm8NmMW92T6xOVoLmKy+CXua7dTNkmGBeVdTkXoOb1iS5Wj0vY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7726

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

