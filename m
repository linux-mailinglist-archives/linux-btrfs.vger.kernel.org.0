Return-Path: <linux-btrfs+bounces-19638-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3F3CB4D2E
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 06:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B97A300F9DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 05:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B351DF27F;
	Thu, 11 Dec 2025 05:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MBpnx3S2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="apFO3OVE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A2A3B8D67
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 05:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765432395; cv=fail; b=Me7uZphMd8DIqtX4WUWcTKf9l8YKWBHfMFbZtUEoFnRY3vkPZa3bgF99M80ktfFwOYS+/UV3FIMSRUE513do+NvPVKnlvGUwI06WE6buEOLbAp0Rnj6hTtOz0sXCaO70v/5YesWpS1YSaySx06BIRpRImlhuXmRiS+OvV1Lhs9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765432395; c=relaxed/simple;
	bh=9Cfqbkpwg31+yP1XS8Zkop7GU9Ej0U356bHoYH+otpM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HBiYh/lRNLqPc3lTPZtIKvSloQ5HN5c60v56vq0siSDBT0QOAKICFZo7ZjBn7F5UZAVh66RbLQCQDwSO9eq31LmlYYPGaJ/J29E9UNXPAIjER1zHoNlrWLAhOah1OZBWJpEYLr2ptKItLTRJYnxg9bxcUes7jwIXg1NgIPF0FYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MBpnx3S2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=apFO3OVE; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765432393; x=1796968393;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9Cfqbkpwg31+yP1XS8Zkop7GU9Ej0U356bHoYH+otpM=;
  b=MBpnx3S2u8jmiQyM5+zrHwundOtIcx9ZB/KKB6gZ1eg3MpexelTZkGgu
   U/pTtRGUAifR5uzOsFH0csqt7Kt+L5G/T17NCo31rlwgS2a76ctSwKh29
   D1FrNZUQW/w2sQQC6KfpZ90+rxyPhn+GjH7mkkLjTga0tXhkRA5mGDr9R
   ZPxUy3cD/pZKyssC62keqyrMVld8qmOdtaK6kGFH734nYQ1lEMfGtthlI
   SP0IUYVOnviBX3Dpy2l1sVZaYzVW8mLsUT20VZhnylEE7KEeBPskoTMRW
   yGWS/1gvbY25X+C5J6kIyI/jzx2yNTZAeMxXSP+mc+LsmIGazIPaZ3+Gq
   Q==;
X-CSE-ConnectionGUID: l5DXQEJ6RzWtDr1m7KMEvw==
X-CSE-MsgGUID: sn+ZaiTRR2adKCj6zeJ+eA==
X-IronPort-AV: E=Sophos;i="6.20,265,1758556800"; 
   d="scan'208";a="136303798"
Received: from mail-westus3azon11011029.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.29])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2025 13:53:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIrfIJVPGOQEgvJ+pgFOlQgfGVYcN56dy+l6YnLc64qmC+wPFltLUJ7+Nya///Gjk656UQmkMBaVN7/Nexf9K7OkfQbSptqKJyn2Z81yOsmaWLkyER8z4Aui+PU6HdseHIYA5DjpmxJejO/qKzVNYuM8kOmb20E6cAJfE0KQtDBHqc9dvmFLjUekVEp6JVdnmaD4+3b1qI45NPkRtAL+lf9kyHeNMEJd8X6+yGA+is9xbtbpFptxZB/qITYn9eqd/S2vgrbP91WyqMUzN3USx8MwVdf9OWIVEyNNIgeIJVyszSY3bcgolOLGskjlpSigCgMxeM3bmvHM4ebeYqwNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Cfqbkpwg31+yP1XS8Zkop7GU9Ej0U356bHoYH+otpM=;
 b=V+8JWhTUwI6wuG9NtwrhsP38XI15r29ClwHo7VwL3C8OT+2upJbHtOPMrufbNdJlZkEaO5Mu/AZnN/veEDwQvJaVYDthHH6HbSuN2g/0HW8qd4idXUjz2ZCnq/ddb+ZjAraGtvjd2siINY1lK92U7OWCfqlrtcbfUklTDdYNJIavKKVFl6UDbDz15wGsww7jx2945/n/E84f6eI1iM0/51OHrodgwcYT+BZLpVgEL8bX3MVx0EqisS1ckMAJZrGo0P+r8XEs+Yj9WvWDUa4zLKveqSgjPtoyzmKXeOeNYj4FiGA0EZME0AXdNpBEFNMMnInf470Zdcgp0cY+Htk1iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Cfqbkpwg31+yP1XS8Zkop7GU9Ej0U356bHoYH+otpM=;
 b=apFO3OVERGqPdDLUngBukaQLt/885NZy8SyTwqVuMkau74Bw62N2tyFP5zRzq8YeD3yZCY8thkdt9+puZ67qIwsoOW3VmHmYGhALtjA68cImJ4MoT7x0g7TMVWIibxDg0ZwyYXS82UQNFi/EQedCPTwYT/5L86HnkqmHvNI1Ew0=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SA1PR04MB8270.namprd04.prod.outlook.com (2603:10b6:806:1f1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 05:53:11 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 05:53:11 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: print block-group type for zoned statistics
Thread-Topic: [PATCH] btrfs: print block-group type for zoned statistics
Thread-Index: AQHcacTQMUxIFB18nUeWzMBFKT5Z9rUa1wOAgAEaTwA=
Date: Thu, 11 Dec 2025 05:53:10 +0000
Message-ID: <e1426ad4-eab4-49c3-bb08-8e12fceeef04@wdc.com>
References: <20251210110442.11866-1-johannes.thumshirn@wdc.com>
 <CAL3q7H4ArKoO+yrUQiAsVcybTJgDOKTNn5zJOz_F_Cj_mt82OA@mail.gmail.com>
In-Reply-To:
 <CAL3q7H4ArKoO+yrUQiAsVcybTJgDOKTNn5zJOz_F_Cj_mt82OA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SA1PR04MB8270:EE_
x-ms-office365-filtering-correlation-id: 7d9aab31-b89b-4c8b-45bf-08de3879912f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VjFxVUZNQ2pDSEIzTnN2Z0tIbnE4ZzdMbWFVWFd3WVQ0MUlKSFl0UFV5OHN6?=
 =?utf-8?B?TjRHTkorR0FMTW92MTVQZXh5UzNZMlUvc0toMHdDQkZSWkVnSFNURXludXZx?=
 =?utf-8?B?NlpDcU9sRnhKeFRKL2N0dzZGT2s3ZEpHVVkxQ0ZvUW9nV3I4NjY2dEVRUFpx?=
 =?utf-8?B?MENXRTVnNXNiUXlmOUlQcnlwRzFLM3Y5VVhzVnJOTWxzOW5zeGxqZ1hMbXp6?=
 =?utf-8?B?YmIwZXcvM0FVMEhWUnY5dlZqaFZWSVUzdDJRUGpPN0JVOFMrWE15MS9iRUVp?=
 =?utf-8?B?N1VuRzlScXFMTTBUVERnTHVCOUppNThTUjhlbWxEam5OcUllVG9kcEkyWkp4?=
 =?utf-8?B?eXZZMy9rU3hmWlh6WTZKd3p1NWkwQThPbG9XQkZzaGpTQUEvRlpETzU0azZ3?=
 =?utf-8?B?SmVZK1dlbytRZWNuNm1BbjhNNDZZaDBORUJXWmQ3ZVRHNFlidWZKVnovMVM5?=
 =?utf-8?B?dUpXeWp2TlZSTUtSRkVnb2MzeFZWL0RFNjhkcjMzMHhzM1FvT2N2QWxseUxs?=
 =?utf-8?B?Qmp2KzhvUjRUcnZ2RUUxb3Y5QzRoU0dScVJYdmQxaml6SXd1Ym1iMXpPRTdM?=
 =?utf-8?B?QXVLQmtXbHUxKzhpYWNaQmJMZmV2R21ycXVZUXI1MnVDTkNvTkF1Y2tEaXhK?=
 =?utf-8?B?dldYY0g1bkIxYXYrQVJPTXc1WjBaZFMzMmh1V1NSUklCYVI3cFI4WHZvQVV5?=
 =?utf-8?B?OTFiYnAyVnF6UUxuRlR1RTloSUg3ZDhtcGg1Z25odHJFMlFPb1BWNzZIL0dV?=
 =?utf-8?B?djRjRThpMFErMTlRNXFDVU5FMnRiMWwyWE1GTnhRT1o2U1ZrNDlvVG45cS9P?=
 =?utf-8?B?cnpISUUwNnJ4S1lhQ3B1QW9pUlhxYTFDWXNFdmViOHVXemN2TVZ1ZjA3NTlT?=
 =?utf-8?B?ampjaXArRllDbGtOYTJINTlwR3ltTkdMQ3RibmY3c0huZmRlb2g0VzNDTERU?=
 =?utf-8?B?NkVLVlk5eVZzYXRzaTk5VGJMa2hsZzRuQkJkcFhIaEp1cklLSDlUbnlxVmZN?=
 =?utf-8?B?dEdFMm1QZUxQYVVIYmZPYTJ4c2tqZ2pyTGM1Y292dkI0RzM3YkFDY1V4Kzdx?=
 =?utf-8?B?azlDN2JGNVRRdi9Qa0srcHRNY0RDQkxwMlUzMkVjdGFqaXJFKzFUTkMvNlNJ?=
 =?utf-8?B?d2ZxOCt6K01kYzNHbzJyb3VkaG5MbElBUWZsWmZ3NERJb2dWNmtvZG9tNWxE?=
 =?utf-8?B?TlR2UE81QXhZT3BUakp0WUZXcXhBV0ZGMzVTTlY4dTBEcnF4c1VNelNsK3Rt?=
 =?utf-8?B?ZUNQb1dBY2lqU1phNEJ0QmR1aUo4L0NKNmJCa3c3aDllaUd2VU5YTHF2bEVy?=
 =?utf-8?B?Z1p4VzJlZklTZHRDVFZubHdjOTFoNXpOSnBHcTF2Q2lKaDE0eWJrakx1RDZE?=
 =?utf-8?B?YkN0Z0tHTFJrTkdrZjJTZzhFc1FZTEVKWFAvWkpaNXREVzRkNFFockdSN2tG?=
 =?utf-8?B?T2hZcS9aMkp2S0VPbDF2YzZsZng0L1JkUm9KK0U2Sm9Bc0xCWVRxUk5JYXV5?=
 =?utf-8?B?VmIvdE1uNjhib0ZnNXRIQldCSG5SWFJEaHlJaVFqTEQyNDloMWkrdHZLM0l4?=
 =?utf-8?B?d2crU2JlZzJFYlhYTno5dC96eVQ0RDAxeFZGOG1wY09RNkd2c2dBeG9oV2dP?=
 =?utf-8?B?b0lzbU52Qng1NjNYdVpMRkJNaHZRdGJFYlBqekpIOE1WNUplWlFsZ3RHRlBq?=
 =?utf-8?B?VURCd2NMeXRPYkJ4ZmptakpOTnVPbTYrMnVkL1AvYzVVOS9waGJsL05kWXRj?=
 =?utf-8?B?dUxXaDZ2VHBKYSs1V3dncUhadS9HK2w4REwweWRQc2NvTWR2dDFYZEtWYmxy?=
 =?utf-8?B?T2VOajhnaU1uSW0yKzVUc1AwWkx3Y1VXYXpsYnR6TFN3S1JRRXcrVi9ZbFcv?=
 =?utf-8?B?OE9mQllwZUJociswc2Y4UEwyQUhLeEluenZwUnNNaGpnaG1hOTlQZTNpcmFk?=
 =?utf-8?B?TUxZSmJSdGpxNS93REpHSG04SnFoenZUQXZVcHBqMDBVNFUzamVBczVjUmx1?=
 =?utf-8?B?RXRLd0ZyaHVmU2tGYnB1d1kwQjc2M1IvQTZSQzB6S0l6clRkYXlhcGg3dGdN?=
 =?utf-8?Q?vrObie?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2lzc3ZIZjVPbUdGZ24xaUYvMjVnNlhlZ0JkMUkwRWR3d3VOeHpQdlR2VThj?=
 =?utf-8?B?M0x4dW5aOTVqVVlWN1RVekFxbHdsVnZDdCswczdjWDMvdEV0enNPT2xDZjhW?=
 =?utf-8?B?MTkwSkJjUHUrV29DWk5SN0xKeDJEZzFMT2xrYTRMRzBFbktvNjFkdjJ2bi90?=
 =?utf-8?B?UGZjNzkyWkhtaXcrc1RmM25WUktlVXpRRWszUFJSRWxlYnNvenlFQjZUQjBL?=
 =?utf-8?B?Vmc3NGxhY0JzN05kMnFkYjRjSUxROU10VkozYlU2MkluSFdud0tRbzVnYkQy?=
 =?utf-8?B?bTRlOEI0SUtPNUpXeE1GRTNNd2VjSTdxUnRUK1N5OXdGRjUvOGRqOTZZNDY2?=
 =?utf-8?B?OS9LM3N3SGtSN0Q1VWtQYUptK0Q2bkx5YjhZbWV3eXpZYm85dGhQdnFmQW94?=
 =?utf-8?B?Y3h5TkxpMXo5UzQxOUErZ3VFdFBHcVFiTXpTbkVCL2sxcTVKbEZSODFKYmcv?=
 =?utf-8?B?dXFqUHFiVnRGbWdmOVlFdXo2V0NyNFN5czc3YjRibmZ1SjhZWEg1MllrRW02?=
 =?utf-8?B?WXhoWW9XVUdpU2I1QitNWU1PUDFVUkVBSVFTcUpVYWprTVhhRmVNRUFVSHZM?=
 =?utf-8?B?dm5ydjd4YWx0Q0xISUl1VEtjWWo1UUl4cGQyeWtJMU9laEJIdkVRRnhwYTZL?=
 =?utf-8?B?U3M5aGpvSnA5RFFoVnFIS2ljT0ovR2RtaFBpNTJHZnpSbGNGRHNBTmpsSWhJ?=
 =?utf-8?B?bXJYVlg1TzI5TDh0ZGk5djBLbVBUeWVubzR6NWJNWE51L0NrSEc5Z3JJalAw?=
 =?utf-8?B?Z1grUGxxY0pjaHBwYjQzVm90MUxYKzYvUy9RRUJaWFJxQjEzN2RJa1FieVdu?=
 =?utf-8?B?ZTQ4U2V3NnlNWDVVbHEzcENrMzJ4RjVPaW5pdzJ4aksvZDJ2MDJCQm15c2c2?=
 =?utf-8?B?Tm1JckRLY0haamU5SkwxVjErWUVZZ0prODhxSmF6TWZQNEFDYjFiZElaTEdv?=
 =?utf-8?B?NFkxMU1mMXppZm1ySEZ2Nm50TFFXckFJNVVKVmlvNXZ4dzA2eE1SUTRNOUpR?=
 =?utf-8?B?YUxEUStLSVNKcVJ1WjluMVB2a3pybDNOek0vOHpQMi9tekRsZXM2MG9sVHpH?=
 =?utf-8?B?NmRKRWVUSW5PUE9ZanNkbGFLN3A4enQwM2pFclRFeWFpMUtHWXpDQWRHNUto?=
 =?utf-8?B?SFRmN0FJUFp4cFcvZkdNS2ZTV0lHS0ZRZkovSjFvTE5zQlZVNTlUTENEdVVk?=
 =?utf-8?B?RTl2RVhOelFMZkxNd3E5bEltMittbmtUUE9PQlcwUUlqK0ZKODgxQ0t1a1d2?=
 =?utf-8?B?bjRyd21WYTc2bzVMSlMzMXl0ekE2OGhSQm9pNDR6cmxaNUhoZkw1WWZQM21W?=
 =?utf-8?B?L0FGb3JiakdzdjZ5bGhnM2VGTlFENWMzcktoS21ScStqOUVrZWFCOXpWTHFC?=
 =?utf-8?B?d3V0a2xFbi9tV2thZzh1WVplWHRBRm95K1ZHTFdiK2E0d2JaWWlrdk4vdjJD?=
 =?utf-8?B?NEVKUDRxRHNBd21jeCtpbkZTWUZFOXVsaCtUeW1uOVdnNlFRRTJYRGFKRUNK?=
 =?utf-8?B?eEdyTnhrQk50UTNkOW5sb3hHSzlEUlZkVjJqaVJ3Y05WQURLSVFrQVZDbmM1?=
 =?utf-8?B?MHE2aFJoS2x1Z08xMUN6eUNWT1c2ZHpia3RPVERpSC9TejVOS2pMeHgvQisy?=
 =?utf-8?B?NmR3MDFyREg2S1NSVWpkM2JjSndwbVNNSEo3TTBzZndXK0NveG9DWm1oNVRR?=
 =?utf-8?B?MHFEbDdYY0NENXU1TEplalQ5SnNaeXNwWmE0WkpvZ2lGWTU3QVJHQ0ZkRk5a?=
 =?utf-8?B?cVdjV0c2TzhUU3lJY2VESGNMQUVuM0RRbmFqTnVRSisrMFBBV3IrOVFhMDRP?=
 =?utf-8?B?VWFGdTEvMWFFeDIvZUEyYmRKZjJOVkNuZzhhWFFwTnB3OXFtenNrRUtPa0ox?=
 =?utf-8?B?YWo0cFdJTVNjNVk5TDNnWEh2Rm9LemFLS1VmM2plZ2laaC9PODFGMWxubUV5?=
 =?utf-8?B?RTRpUWNjUVBzYmxneUtXL3dMR0RPMGFHNFpiV2JBZHp3TkdFSXVIaUlvcG9U?=
 =?utf-8?B?M0hlU3lWdjFoaE5PZlhlOHNnQ0MyUnUyM3ZTVTByOS82VWZoMjc2c3haN2VI?=
 =?utf-8?B?WnB5bGhQb3lvVEdPQ2xuRUJEeGpYRVBWUEYyVTgxOEFmWXNUY3J2WVlPTURF?=
 =?utf-8?B?aFpvU2xhZHFFZVQxdXhxR1hFM0kwdFBBeEpTRnRTV0pib3NGY00wZGR0eDNC?=
 =?utf-8?Q?XDjwKT6HeiR7YLRANv4doh0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C583A9FB908A547953CFBE00439CE5B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wa2uO4FIPm4+fJe39pgekeajBDJy6exCjXBKZ6Yl/ggs/PFFGs5Ew9t2d1a8iye+HnuHREItCm7lfykN9Hhacr5bm3gPpkpb4rlzjzb0PpTTqT8hAHXSGtjK85sUUDmuv1O9u5tResY/i7lopWXq9pFk4fjp92ry6mdDynwzCqiKSEgyvAux1cahTuHtlyWRjChzAS8UfdmjT4L3HeXrDV/OmgONB99svVex/GJPn/UvNRPTKk415G6Ad6/6+5s+7ntQOJw7VVezdc6t94DE0Bf6xwJJp7g4LaYzIg1mvgsX1gd7rrjWk2P7u+qNVE2khgXjjyoXmrzvJGJ+/kQgFmU8z6E4PAVvrnO1T3kGffGfaaEmyDKnx573A6kxBBqs7o6MgRkczPFBxBaefyr1DssyBA2ow6+ehJ0mP5zMs8reZF3ECADeVJajGvQq3bj2FbAUwH73SRllxxx+CtGKO+8WwW4Cb6EMIMxuQ3MqfW5US7UXikIeZebSVgvVl+dwa80CtKMXtkYQw3LFlwFr+Mb+kd2FmgkwZXOMxEBBLsmdp9Izxvl/QF4i2PGobHFs6b2HsrIhOm7P8aHqE0UZJcy3PRi6+9fl85eDNJAbQDfhFtyh+6k4XO6aCa/Ki7ih
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9aab31-b89b-4c8b-45bf-08de3879912f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 05:53:11.1079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8OHkelTB/y99rbQa0dvMmlGWXZbU0KQl83i2f+aLDlR37NIu3VsTR2ecLfbXolnzW5Ss8ns+UFp0+mjxBeYsIKwXRb5kikdNrVNsFk0wUe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8270

T24gMTIvMTAvMjUgMjowMyBQTSwgRmlsaXBlIE1hbmFuYSB3cm90ZToNCj4gT24gV2VkLCBEZWMg
MTAsIDIwMjUgYXQgMTE6MDbigK9BTSBKb2hhbm5lcyBUaHVtc2hpcm4NCj4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPiB3cm90ZToNCj4+IFdoZW4gcHJpbnRpbmcgdGhlIHpvbmVkIHN0YXRp
c3RpY3MsIGFsc28gaW5jbHVkZSB0aGUgYmxvY2stZ3JvdXAgdHlwZSBpbg0KPj4gdGhlIGJsb2Nr
LWdyb3VwIGxpc3Rpbmcgb3V0cHV0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRo
dW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+PiAtLS0NCj4+ICAgZnMvYnRy
ZnMvc3lzZnMuYyB8IDE4ICsrKysrKysrKysrKysrKystLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwg
MTYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZnMv
YnRyZnMvc3lzZnMuYyBiL2ZzL2J0cmZzL3N5c2ZzLmMNCj4+IGluZGV4IDdmMDBlNGJhYmJjMS4u
NTQxMWU1Mjc1ZjgzIDEwMDY0NA0KPj4gLS0tIGEvZnMvYnRyZnMvc3lzZnMuYw0KPj4gKysrIGIv
ZnMvYnRyZnMvc3lzZnMuYw0KPj4gQEAgLTExODgsNiArMTE4OCwyMCBAQCBzdGF0aWMgc3NpemVf
dCBidHJmc19jb21taXRfc3RhdHNfc3RvcmUoc3RydWN0IGtvYmplY3QgKmtvYmosDQo+PiAgIH0N
Cj4+ICAgQlRSRlNfQVRUUl9SVygsIGNvbW1pdF9zdGF0cywgYnRyZnNfY29tbWl0X3N0YXRzX3No
b3csIGJ0cmZzX2NvbW1pdF9zdGF0c19zdG9yZSk7DQo+Pg0KPj4gK3N0YXRpYyBjb25zdCBjaGFy
ICpidHJmc19ibG9ja19ncm91cF90eXBlX25hbWUodTY0IGZsYWdzKQ0KPj4gK3sNCj4+ICsgICAg
ICAgc3dpdGNoIChmbGFncyAmIEJUUkZTX0JMT0NLX0dST1VQX1RZUEVfTUFTSykgew0KPj4gKyAg
ICAgICBjYXNlIEJUUkZTX0JMT0NLX0dST1VQX1NZU1RFTToNCj4+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gIlNZU1RFTSI7DQo+PiArICAgICAgIGNhc2UgQlRSRlNfQkxPQ0tfR1JPVVBfTUVUQURB
VEE6DQo+PiArICAgICAgICAgICAgICAgcmV0dXJuICJNRVRBREFUQSI7DQo+PiArICAgICAgIGNh
c2UgQlRSRlNfQkxPQ0tfR1JPVVBfREFUQToNCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gIkRB
VEEiOw0KPiBDYW4gd2UgaGF2ZSBtaXhlZCBibG9jayBncm91cHMgZm9yIHpvbmVkPw0KPg0KPiBP
dGhlcndpc2Ugd2UgbWlzcyBhOg0KPg0KPiBjYXNlIEJUUkZTX0JMT0NLX0dST1VQX01FVEFEQVRB
IHwgQlRSRlNfQkxPQ0tfR1JPVVBfREFUQToNCj4gICAgICByZXR1cm4gIkRBVEErTUVUQURBVEEi
Ow0KDQpObyB3ZSBjYW4ndCB1c2VkIG1peGVkIG9uIHpvbmVkLCBzbyB0aGlzIGlzIGZpbmUuDQoN
Cg0KPiBKdXN0IGxpa2Ugd2UgZG8gaW4gc3BhY2VfaW5mb19mbGFnX3RvX3N0cigpLCB3aGljaCBp
cyB2ZXJ5IHNpbWlsYXIgdG8NCj4gdGhpcyBmdW5jdGlvbiBieSB0aGUgd2F5Lg0KPiBNYXliZSB3
ZSBjYW4gaGF2ZSBhIGNvbW1vbiBmdW5jdGlvbiB0byByZXBlYXQgZHVwbGljYXRlZCBsb2dpYy4N
Cg0KT2ggSSB3YXMgbG9va2luZyBmb3Igc29tZXRoaW5nIGxpa2UgdGhpcywgdGhhbmtzIQ0KDQoN
Cg==

