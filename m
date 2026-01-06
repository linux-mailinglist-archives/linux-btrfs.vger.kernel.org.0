Return-Path: <linux-btrfs+bounces-20120-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B17DCF6B48
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 05:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B1ED304067C
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 04:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCFB29D27E;
	Tue,  6 Jan 2026 04:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F69Cqt+5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kOPBVcfU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AE11B4244
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 04:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767675377; cv=fail; b=kI4kN63J4aQuRXhhfLTiB//EzsodHcGygSDYV+x408kmK7p8HbaVAnOgc9T5VdLXEVIHUGLK7CDIj65RoYg9/qxLr3ySVsiODdrs94j1CGxVGB3n0pdJh7B902Qg3goixE0UfZ0Gdq8P/OyWRqHTK3PPlNpP9h6wEsJJaZfxmnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767675377; c=relaxed/simple;
	bh=cWA9einhKDOB1Do/3lYLKYkVpI89hVRbfupaiz5od7s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kx1RRU4nhBnkRnYo9PKEmHJmAdK5CNwaGibOMI8A9FmOa4lixkNLddGms8zD0lPwoFEml1EcrHZyKQXXWMxlr6k69OzEXHkDmwWabFFY1BRzIIWmynqh9qaHrcFZvvZPLQD/2+iOQFsPcDi1bPcnlOzvCY1MNZxuGXWVgVTWisk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=F69Cqt+5; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=kOPBVcfU; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1767675375; x=1799211375;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cWA9einhKDOB1Do/3lYLKYkVpI89hVRbfupaiz5od7s=;
  b=F69Cqt+57wZ/IlAANLS7fwF7WypVx8ptuVzA0xkzGdWR8laLbKYRTNQk
   NYg/njkLxCL+0Em0rOwJluzpLkIDwE2Kj9Mnu4kgpfAZ/BY2Cd52qhj1O
   Ovhb5QmqFoJ0XlnGNj7PRgCDN18ruwLQvaWpVTdcDOqCx3683umYReVVK
   ePjRmBuz5c6fI+NEsVMtjz6gCKn41zNtGpOUU5WETDOu4GvtrXRV32G6i
   n1GCDBe1MNAf0Zb7ORANU5phaRFjubPuEzDWofK9kelRoSbjcmzk67RIh
   FHm9H1HGzzeu47E1mg/S+SM1Dh978iE+IeQtrEC1cP4IgR/U5hIA0XCeo
   g==;
X-CSE-ConnectionGUID: hWCo7PsPRTO7RoYeXtHDLQ==
X-CSE-MsgGUID: Lf884oC8Qy2IgdbSMrs4nA==
X-IronPort-AV: E=Sophos;i="6.21,204,1763395200"; 
   d="scan'208";a="138037355"
Received: from mail-westus3azon11011044.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.44])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2026 12:55:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drlJh5d7EdA/tUIt/3LH/TdrVjvIUEOWZExH/VT8roaCxo9mp+jc45MVqAprso3YibNF48QmJF2J8+GAu3KqHxunyEvVURhl8jGovrZODiVpcRgorNk6GO11ywzp48oKdkzm06U8ahJ5zOvEmHuq9iKALz+gVE75aO5G9CjXJ7SFXJxiGuB4OVFGxdKLN95isinBW1sC7RCpmqXwqWXN2t6ffUCimyjldF90h0Mua6CCYSZpAt6oXvfY35czpS1zFgub7W98ev2AF6u7iNw91tibm7l+C29VZNnS90rwEJOBUIy850g3ggQ3E5cBsDQQU/mci9TCXgPUmLRlduMNaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWA9einhKDOB1Do/3lYLKYkVpI89hVRbfupaiz5od7s=;
 b=aJoooC7WofJFmZ/g2L818eqy20DXj9NFrxNmJQ+IrWT5rXrGdPuzdnz16FFMi2RuThXsQEfJTVx4ulQSinggPd9cMGP8dgTytLJ0OZFFRdWxlj49qM5fIivf5SsadKI79Ha9W8E00tYeT/Zgs2G0tFBbeMgxbK9VSfPJrSJEpmLcNU4Laiwykz1a8LBEj9YbXD5jQ+MWHYFZ7/iKc2fvhjXv6MVTKa6L6XgVWP/LGnWZzyAWy+YZt7MNLyUZcPiKdkMYR64vqRTyZfl+TSMPtVQ5tcMi2a21YvgkMzQYc/j6IIzE0S1twLD+ObJSMiANJ+Qzs0kMj9Ltka3hPPhztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWA9einhKDOB1Do/3lYLKYkVpI89hVRbfupaiz5od7s=;
 b=kOPBVcfUMmsrVh36YAIyNcyTE35azrahPOP9MTba7RqWUAezV5RPJlyGe8uKA36itOeqbuYZJo//CYfbh6HkvitT+ToLQvhXyDmOZpHXVbQENgdTVNDpn2FeLu+RYoUfxS69E36r1ExwLO/Ix1crVBmz2r+HQ4AYbiR73QXmul8=
Received: from DS0PR04MB9844.namprd04.prod.outlook.com (2603:10b6:8:2f8::22)
 by BY5PR04MB6405.namprd04.prod.outlook.com (2603:10b6:a03:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Tue, 6 Jan
 2026 04:55:03 +0000
Received: from DS0PR04MB9844.namprd04.prod.outlook.com
 ([fe80::9647:6abf:8734:547a]) by DS0PR04MB9844.namprd04.prod.outlook.com
 ([fe80::9647:6abf:8734:547a%5]) with mapi id 15.20.9499.002; Tue, 6 Jan 2026
 04:55:03 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: HAN Yuwei <hrx@bupt.moe>, linux-btrfs <linux-btrfs@vger.kernel.org>,
	Naohiro Aota <Naohiro.Aota@wdc.com>
CC: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [BUG] 6.18-rc7 cannot mount RAID1 zoned btrfs.
Thread-Topic: [BUG] 6.18-rc7 cannot mount RAID1 zoned btrfs.
Thread-Index:
 AQHcYFs7YSrT6wG320KO9dO6k+5PS7UIL5IAgAAJsgCABB3sAIANCT8AgADaJwCAGSCAgIARdWcA
Date: Tue, 6 Jan 2026 04:55:03 +0000
Message-ID: <DFH8LGFH8LD8.39G3E2X9L5318@wdc.com>
References: <0BED8C36F63EBD8F+f61c437e-3e5f-4a1c-9c18-17fd31abfcd4@bupt.moe>
 <e865d52c-8f07-431a-8fff-907bd6cfb0e8@wdc.com>
 <F24595B65EF81413+dddb8a6c-9da6-4480-b168-fcfa20d3c296@bupt.moe>
 <8bd72651-bad5-4e27-8972-1aa00ceead0a@wdc.com>
 <3BB597E0959AF3E9+275dc513-febd-4497-a73a-61707d2d9e90@bupt.moe>
 <99066be8-992b-4476-9a22-8c1ff6f5cff2@wdc.com>
 <36718DD03AD165EF+c4b42ca9-02f2-41e9-9c43-1ff360a6e73e@bupt.moe>
In-Reply-To: <36718DD03AD165EF+c4b42ca9-02f2-41e9-9c43-1ff360a6e73e@bupt.moe>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.21.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR04MB9844:EE_|BY5PR04MB6405:EE_
x-ms-office365-filtering-correlation-id: c329b4c8-15e0-48cc-955c-08de4cdfc111
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WFNqU3FHc1JJRU1tT3h2eEwrV2RBVHpLckozN3hmN1dPcW00L1VabmtGK2Zr?=
 =?utf-8?B?YWlxSGpQWE9HWGtHUXV5RGM5a1docnVFNmx0dVd0c284RHRtNUd2U0p6enUy?=
 =?utf-8?B?SDEydEE5MWhTeVpSL251S1AyVGY2NGNtVFVoTUliazlFOXFCRHJqMEd4aWJO?=
 =?utf-8?B?ZG9KdnBNdHZqNTJOSWxFZkhRelhyb2lGUUFkalNKcVZOMzJZdEZJdURZWS9r?=
 =?utf-8?B?L0FJMTJtZDR2T0dhdWtZRXphajl0NUtqMHJRR2c0b1U0bGhFd2s0dnYyOTN5?=
 =?utf-8?B?NkdZUCsrVGJ2bFZGcE9WL25vVGlxRGx0cHdTYzhNdXo4V2RVL2N2WGx2TkxQ?=
 =?utf-8?B?bHRhNzlQa1NHenk4M1VqWG5tSFEvNjRuTlhQRFN1VUsvdTJWaVMwSUFkRDBy?=
 =?utf-8?B?YUdndkFnZVVKS21FWEVEV2Jha2VEQjZpU3BSMWh1NmRKblBlcEJidWFGL29O?=
 =?utf-8?B?TDlHWlVxUGpsNmpwUEhXUXJJb3UzU1ZrQTdZcFl0RlRCM1ZkWmF5WGlXSGdN?=
 =?utf-8?B?N1JsRzdrVlI3WW94WGFkMU5sQzEvOWtpSmI1RXN6ZkwxQU5Cb2x0eVROVkxT?=
 =?utf-8?B?SnduK29xRXZoUksxcjdnOGdTc29wTmQ2SkdMcEVIci96S1RUQmZhSmlVb2g4?=
 =?utf-8?B?cmI1alN6UEttQXUxeW9aMjV5T0xyTDB4d3doYXhlcHQvcXhiNm4xQnBzcEZC?=
 =?utf-8?B?WEs1cVZlV0w2Qkw4eDY1UGN6bExueDQ3bVNKZnlUa2ZwVXJNSG1Ic0FkRUht?=
 =?utf-8?B?R3hrQzhJNStYUWlMd1BiQ2dLWUxKNnRISVhLWXpRSUpGbWZSYk1tQmlER3hz?=
 =?utf-8?B?WEF1ZVBvZG1XSE9INGthZk53a1lLeUFYRnU0bWp0REt5ZUVGM3FBeVFwYnZy?=
 =?utf-8?B?cjRqK244QnJTNzJPSkRTOGFZelZPWWREY0tiWEozbnB3N0N5dG13dk1ZUzRM?=
 =?utf-8?B?bDhTbEJ3eGdqdkQzeWN6TURsOE4yZkY5aTgvNmJKOWlOalZNTlVGbmpTK3VQ?=
 =?utf-8?B?dSs2R2xTVVBTSXZmUTV1SStseDA0eE1pK1plTkZ0emdTT0pkemJFL3RTcGx4?=
 =?utf-8?B?WXB5QitrQWJXSUVhSVNFVE5iaG9IT2xBSnVtQVQ4REhVdWtmV0IvQWVUUVFy?=
 =?utf-8?B?UDNleEg0TW5FNVdQaHhjNTNvMng4KzRTS2tOWGpHTTFuSXhJNFZVSTBZak9J?=
 =?utf-8?B?bUYvL0k4OWJjWXp6dWtHSnNGMHVZd0FOMzYvRFYwMWxobEVETEwwU01lOHdp?=
 =?utf-8?B?aTF1VlBic3hCcHJTb01lYTNXUy9aZjcwdkswMmRFb3Q0NWdlT3ROM1YvMXQ0?=
 =?utf-8?B?bS9WalVMaDNET2p6anphRlQ1ZGR2ZkQyMG54b3JjMzZ4cmRXbGladjRhSmN1?=
 =?utf-8?B?aG1YWTFTTE9yOWN0aWRZV2ExTkUvbGVTemMxWFh3alFST1Y0T3N6cWxsVVkz?=
 =?utf-8?B?U0JXSHdDN2dreW9nYlJUaFVkMC9EdW13QURYL1dFbDZwbHFhODAxYkp3VERr?=
 =?utf-8?B?djI2a3ZtaHlVR1N3S1JXZlh5SUM2VnJza01LK3lFOG15RVhmQ3l1WkNQbmtW?=
 =?utf-8?B?cEZ3eENrdTBiLyt4ei9wQWJXWnVqTWh4N295NVJEVmVFb2lIM0ljYUtVS2NW?=
 =?utf-8?B?SXBwMGlPVjhmUldLMk5sLytCVjBBT09ibnVaRFZERyt5M3loOGZwTnlhbFlv?=
 =?utf-8?B?d2IzSldjVGZROGN6c01ZVitLeW5KQ2Q5dWRsa2piL2hHcjB5NUdhWTltcVVD?=
 =?utf-8?B?YTJnWGtxTml4bUw3anFzWDlHbVFFaG1CMDRvYnlKeGRWeTk3dlUrZGE5UUJF?=
 =?utf-8?B?UXRYQ0V3S3VaV3ZodHNwdG41TUQxRlViaFNiL1FUNGJZV0ROTlpuZm5nMmh4?=
 =?utf-8?B?emN5WE5vNlc3TllCMUQ3UGhraXZ2OWFSTmUzVnR2Mi91V09LUzYzdFc2VmVS?=
 =?utf-8?B?RXdnVVVCMm5ScWtRSXRVV1B5VnFuOWEyenE1SERzMjQzUldHZmNFMGk2Smw0?=
 =?utf-8?B?ekljRFNEQWhLbjhFVnlhanl5YUZ5VE15KzN5eU9HWmV5dC9ZbHMwQ3JYMkdH?=
 =?utf-8?Q?elYuHI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR04MB9844.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ri9TQXMzYVdvZkNkQnJIYnhOVllnV3gvbDNKWEVFVkRVNEVrZjFFa3M3WS9P?=
 =?utf-8?B?ZHlZbVN3d1lZMzFsVEVVOXErVjNwL3ovV2NPT1NjR1Y3Qld0ZlVpNVRwRGNs?=
 =?utf-8?B?cFMwa1UvQVFMRjBvSHhYTzA3TmxaS0xZT3JDWEV1RXNxdU1xRmRJdHN5RGhG?=
 =?utf-8?B?UWNJNjlsV050TWRmVjFoeUpLZk0yZHVxZnl4cWZ5U051TXNMQ0NwK0lnbncx?=
 =?utf-8?B?b0xtd1RMT1FGQnR6c01sMU5QeWRjZXpyR2dXQ0tLRHVFVThZZE1qTE94a3px?=
 =?utf-8?B?VnowejU1b0hERjd6RDBIUGM0bHRJSFN3N1plckxxQ1ZxTDhSdTBZZnhOSG96?=
 =?utf-8?B?VTZid3czNHNBVk00QndabGZkZTRGVU9sWXppeHdCN2hTNlFmbDdnd1JCaEcr?=
 =?utf-8?B?Zlppd1V6LzNlbEV0QjFKZ05ud2dHZ1JJQm85R2I3WWJNZmIrazBDTnJtQlhu?=
 =?utf-8?B?NVB4ZHdmZDl6clZ4eVNLVkp6cHA3L1ZoN0Z2N0xUM1JDU3RhS3hyY0ZEckVo?=
 =?utf-8?B?Y09CMEs2VENEWFppMXJPRGdRQktJUjFIOXdjS0ZwbExtMTNmaTBXTDBXVExk?=
 =?utf-8?B?M1ZFUnJTRTZxRVRtZ3EvazVZaVhCVFFPVlFHZk5yTS9jbldwaEQ5MXVBUDRh?=
 =?utf-8?B?SHJoWnRxK0xrMTQ0dndNWFRYYUhVc0lIWlZNSTRvb1Q2T1o1QW15dGJJTFhB?=
 =?utf-8?B?TVY0ZGszTU1OTWxOTXZxc3hxcWlKbUFOVUVQQ3A1T0pQUWZzeXptcG1pYVIr?=
 =?utf-8?B?WXNJV2JVZVhXL0FYSkJCTnpyOFJZRDA1ekJ5aGJPNEw4U01hcmhCOExoOUtH?=
 =?utf-8?B?TE1STEhORllWT2dJc3VnRmNBNzFnZnA1WXJyQkFMbmJpdWEzUW5oRmFSeGx6?=
 =?utf-8?B?dmFaU0xqSGNPNys0RnZ1eUd1TkZCOHVvdm9wZ1B0OWpBQ21qNmczWXRjZTVn?=
 =?utf-8?B?Rk9nb1NvOS8zeTIzWkJ1Y2JPQnkwaUtLOHFDdmZhZXQzS0RKRnhpSzU0NDlQ?=
 =?utf-8?B?ZWFiVU5HditlTlVSbjI1MXEybnB6bzJEQlV3eHhLc3lMd1Uxa3ZvZ01wbUNk?=
 =?utf-8?B?bzFVdzR1dDZNNXkwVTkwemlMR0lSU1lCN0MweUtmaWhOWURCYXc3NzRZaWhU?=
 =?utf-8?B?Rk05akYvMlhZSUs0WUlSZ2JVemRIamd1OUFiZ1QvSUlhNDVja0RrOEtIMjdm?=
 =?utf-8?B?c1R6cFQ3THdlYmJzRW9zVXJBQ3lxOVNNeFE5bTN1dzN0K2hEdXdRdHlTYjg1?=
 =?utf-8?B?SkNZdVVUaDZ2di9OcURQdWRPaHlENi92bkE5ZGZqcGRsYVhOSTBiNGVUYy8w?=
 =?utf-8?B?Q0FkZEJIb2ZEbTFkNGtOZjZrRk4vcE55VThXQTRKSDd3RFJ0VEFuSGRxSUZy?=
 =?utf-8?B?WFI0TEs1UVAxdjVYSElNelhRaXFDc2pLTTRsOFZQemphR04wNnZtV1YrZ01q?=
 =?utf-8?B?S1hPdmtHazUyN2xNVllsZDFWTEloVkxyODcwY3lvajdxSVRKL0NmWlRsUkNY?=
 =?utf-8?B?QUROaXZEYXZSM2V0M1hTTHg5ODR6Q2krZm1LSFdza1pOdC8yUDdQRTRnbk1I?=
 =?utf-8?B?dy84dnY5MkwxMi9LQU10aUhWSjJJM0M2TWFiZ3NGS2ljTHBVaXZ6RWl0eS9H?=
 =?utf-8?B?WGh3L1R4VWtyZW5aRTdxR1JtRDZxL0F6UFpCdElaS3VBSk9uT0Q1VVExS1h6?=
 =?utf-8?B?M0FZVWwydEU4Q3c2NklnV1R0WGRNcFFLV3lUaXFPTksyVHBDWitHTzkvcWlp?=
 =?utf-8?B?dS90Yk1wblI1QzlndnJmM05PSEhVOS8yem5MMStvWElFWWZJbEhMbXNIKzB1?=
 =?utf-8?B?Z0F4a3VTTVlmekc2SHJTOTlMb2czUWFiTGtZOXRpdlZDQ1BZQngyekllUFFz?=
 =?utf-8?B?QWk2MWFuZ2MvbW1TUUc5c2ptbzRzVFppWkR1TmtvTE8xQlh2YkkzbTFSR0lI?=
 =?utf-8?B?VnNqZlZVMDJXK2hOSHBmcmpNSmxlRjdncHI1SkloODV2eGJwUzY2Q3BqZXg0?=
 =?utf-8?B?YXpnL1NoS1hzcnREbmhiVXUvUGRzR3JScDNqSGpiMkVCT24wNUFQTXNxdkxO?=
 =?utf-8?B?Q0h4QXNKRXlkZGhaM21jYXlWeHVmaWFjQy8xNDZLQ2szYW9WbmVaYVU1ajJG?=
 =?utf-8?B?MmVnaHhqWlRjY3FPcXkvc1Nzbys4Zmo3SWQ1TFRWKzBLU1ZZN2E4N0ZSTmZC?=
 =?utf-8?B?N2s3SjVuRktQM3VRTHpZSUdrVWxWM2FXS2tkb2tBNlJFdW5uY3VKbzJiamdn?=
 =?utf-8?B?ejVCS2d1b3lxSDRaSVRsZFNBUGZMTFlhVTU4Q2c0dDJSSlNvejdWYlJGK3NY?=
 =?utf-8?B?QkNhM2o2WThNN2dvZjVKSzNsKzRqME95TU5xMFQ5bVcvVll4bUMxdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF35D4A071C85347AD6F8FEDCAC55431@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/oANxgbm4KUvvb9osoi8FoQiJ2bkyQCNVVKmX7ob1us3hI3dcJQRQAOLqjwbGoNx5YXHninmLUnM98XacxlvQs9bBDJ5BpM3G9iXkSPw3VPTKrFboZIdfaI5lhkDb06hEvmvcbV5jMEbtA1mdIBNkuZjQOurmNYPF+VKxQ/ZZsA45Vzk+zUq8/3EQ6S8EsFxWgs70FsHOOPbf3mMaoCp8GmT5SRZljA5AXKaNMa8P4TcgnXWflEMdO0P5nKJKV5OrhePz7vlJsIDDSBOkjqY6AGflR1iIQjFu0Pqx/o8X2Goa+c++rHQV0D4fpy9MrXmOmHeZ/1WV/GV/RrBHqACrFyWvc8Ee4vP4/pOwgGgBzjs2FY6YvAoQt7m1eHLqkQ0wrDG0OkrESQoCrgCgTWoNfUW8r+hnRjrEVQRMxe2Naxbh6rdZQvWtq978mFsgcLebU+UqcKBOfdEHQj8PB7/ZG6E6ME/c5y+c8jmUX+gg9qrp8MCpXuxWoRs7EZvCyBpNiXZZQvr3HKqSpj8iocAP3JXxqTEi3ulKJ++wOMGrrpOS8Sa09TDn7K4Uy8oHxrjrnTnngAPz85/NT7euCvh+XqjHXpTgZWi0ql5Q6OdMCZyki2V3zYTkNzj6x351RjO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR04MB9844.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c329b4c8-15e0-48cc-955c-08de4cdfc111
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 04:55:03.3665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/TnepJ496cpFwf6vZ7w18ibDgBkvbm2Wxhypc9d8ChKuPUbgmo/t9oXAgeEQkmW3uQFTrMF7Ac71/4A8uHdnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6405

T24gRnJpIERlYyAyNiwgMjAyNSBhdCAxMToxOCBBTSBKU1QsIEhBTiBZdXdlaSB3cm90ZToNCj4g
5ZyoIDIwMjUvMTIvMTAgMTA6MzUsIEpvaGFubmVzIFRodW1zaGlybiDlhpnpgZM6DQo+PiBPbiAx
Mi85LzI1IDI6MzUgUE0sIEhBTiBZdXdlaSB3cm90ZToNCj4+PiDlnKggMjAyNS8xMi8xIDE0OjMw
LCBKb2hhbm5lcyBUaHVtc2hpcm4g5YaZ6YGTOg0KPj4+PiBPbiAxMS8yOC8yNSA0OjM4IFBNLCBI
QU4gWXV3ZWkgd3JvdGU6DQo+Pj4+PiDlnKggMjAyNS8xMS8yOCAyMzowMywgSm9oYW5uZXMgVGh1
bXNoaXJuIOWGmemBkzoNCj4+Pj4+PiBPbiAxMS8yOC8yNSAxMjozNiBQTSwgSEFOIFl1d2VpIHdy
b3RlOg0KPj4+Pj4+PiAvZGV2L3NkZCwgNTIxNTYgem9uZXMgb2YgMjY4NDM1NDU2IGJ5dGVzDQo+
Pj4+Pj4+IFsgICAxOS43NTcyNDJdIEJUUkZTIGluZm8gKGRldmljZSBzZGEpOiBob3N0LW1hbmFn
ZWQgem9uZWQgYmxvY2sgZGV2aWNlDQo+Pj4+Pj4+IC9kZXYvc2RiLCA1MjE1NiB6b25lcyBvZiAy
Njg0MzU0NTYgYnl0ZXMNCj4+Pj4+Pj4gWyAgIDE5Ljg2ODYyM10gQlRSRlMgaW5mbyAoZGV2aWNl
IHNkYSk6IHpvbmVkIG1vZGUgZW5hYmxlZCB3aXRoIHpvbmUNCj4+Pj4+Pj4gc2l6ZSAyNjg0MzU0
NTYNCj4+Pj4+Pj4gWyAgIDIwLjk0MDg5NF0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkZCk6IHpvbmVk
IG1vZGUgZW5hYmxlZCB3aXRoIHpvbmUNCj4+Pj4+Pj4gc2l6ZSAyNjg0MzU0NTYNCj4+Pj4+Pj4g
WyAgIDIxLjEwMTAxMF0gcjgxNjkgMDAwMDowNzowMC4wIGV0aG9iOiBMaW5rIGlzIFVwIC0gMUdi
cHMvRnVsbCAtIGZsb3cNCj4+Pj4+Pj4gY29udHJvbCBvZmYNCj4+Pj4+Pj4gWyAgIDIxLjEyODU5
NV0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYyk6IHpvbmVkIG1vZGUgZW5hYmxlZCB3aXRoIHpvbmUN
Cj4+Pj4+Pj4gc2l6ZSAyNjg0MzU0NTYNCj4+Pj4+Pj4gWyAgIDIxLjQzNjk3Ml0gQlRSRlMgZXJy
b3IgKGRldmljZSBzZGEpOiB6b25lZDogd3JpdGUgcG9pbnRlciBvZmZzZXQNCj4+Pj4+Pj4gbWlz
bWF0Y2ggb2Ygem9uZXMgaW4gcmFpZDEgcHJvZmlsZQ0KPj4+Pj4+PiBbICAgMjEuNDM4Mzk2XSBC
VFJGUyBlcnJvciAoZGV2aWNlIHNkYSk6IHpvbmVkOiBmYWlsZWQgdG8gbG9hZCB6b25lIGluZm8N
Cj4+Pj4+Pj4gb2YgYmcgMTQ5Njc5NjEwMjY1Ng0KPj4+Pj4+PiBbICAgMjEuNDQwNDA0XSBCVFJG
UyBlcnJvciAoZGV2aWNlIHNkYSk6IGZhaWxlZCB0byByZWFkIGJsb2NrIGdyb3VwczogLTUNCj4+
Pj4+Pj4gWyAgIDIxLjQ2MDU5MV0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGEpOiBvcGVuX2N0cmVl
IGZhaWxlZDogLTUNCj4+Pj4+PiBIaSB0aGlzIG1lYW5zLCB0aGUgd3JpdGUgcG9pbnRlcnMgb2Yg
Ym90aCB6b25lcyBmb3JtaW5nIHRoZSBibG9jay1ncm91cA0KPj4+Pj4+IDE0OTY3OTYxMDI2NTYg
YXJlIG91dCBvZiBzeW5jLg0KPj4+Pj4+DQo+Pj4+Pj4gRm9yIFJBSUQxIEkgY2FuJ3QgcmVhbGx5
IHNlZSB3aHkgdGhlcmUgc2hvdWxkIGJlIGEgZGlmZmVyZW5jZSB0b3VnaCwNCj4+Pj4+PiByZWNl
bnRseSBvbmx5IFJBSUQwIGFuZCBSQUlEMTAgY29kZSBnb3QgdG91Y2hlZC4NCj4+Pj4+Pg0KPj4+
Pj4+IERlYnVnZ2luZyB0aGlzIG1pZ2h0IGdldCBhIGJpdCB0cmlja3ksIGJ1dCBhbnl3YXlzLiBZ
b3UgY2FuIGdyYWIgdGhlDQo+Pj4+Pj4gcGh5c2ljYWwgbG9jYXRpb25zIG9mIHRoZSBibG9jay1n
cm91cCBmb3JtIHRoZSBjaHVuayB0cmVlIHZpYToNCj4+Pj4+Pg0KPj4+Pj4+IGJ0cmZzIGluc3Bl
Y3QtaW50ZXJuYWwgZHVtcC10cmVlIC10IGNodW5rIC9kZXYvc2RhIHxcDQo+Pj4+Pj4NCj4+Pj4+
PiAgICAgICDCoCDCoCDCoGdyZXAgLUEgNyAtRSAiQ0hVTktfSVRFTSAxNDk2Nzk2MTAyNjU2IiB8
XA0KPj4+Pj4+DQo+Pj4+Pj4gICAgICAgwqAgwqAgwqBncmVwICJcYnN0cmlwZVxiIg0KPj4+Pj4+
DQo+Pj4+Pj4NCj4+Pj4+PiBUaGVuIGFzc3VtaW5nIGRldiAwIGlzIHNkYSBhbmQgZGV2IDEgaXMg
c2RiDQo+Pj4+Pj4NCj4+Pj4+PiBibGt6b25lIHJlcG9ydCAtYyAxIC1vICJvZmZzZXRfZnJvbV9k
ZXZpZCAwIC8gNTEyIiAvZGV2L3NkYQ0KPj4+Pj4+DQo+Pj4+Pj4gYmxrem9uZSByZXBvcnQgLWMg
MSAtbyAib2Zmc2V0X2Zyb21fZGV2aWQgMSAvIDUxMiIgL2Rldi9zZGINCj4+Pj4+Pg0KPj4+Pj4+
DQo+Pj4+Pj4gRS5nLiAob24gbXkgc3lzdGVtKToNCj4+Pj4+Pg0KPj4+Pj4+IHJvb3RAdmlydG1l
LW5nOi8jIGJ0cmZzIGluc3BlY3QtaW50ZXJuYWwgZHVtcC10cmVlIC10IGNodW5rIC9kZXYvdmRh
IHxcDQo+Pj4+Pj4NCj4+Pj4+PiAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdyZXAgLUE3IC1FICJDSFVOS19JVEVNDQo+Pj4+Pj4g
MjE0NzQ4MzY0OCIgfCBcDQo+Pj4+Pj4NCj4+Pj4+PiAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBncmVwICJcYnN0cmlwZVxiIg0KPj4+
Pj4+ICAgICAgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cmlwZSAwIGRldmlkIDEgb2Zmc2V0IDIxNDc0
ODM2NDgNCj4+Pj4+PiAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCBzdHJpcGUgMSBkZXZpZCAyIG9m
ZnNldCAxMDczNzQxODI0DQo+Pj4+Pj4NCj4+Pj4+PiByb290QHZpcnRtZS1uZzovIyBibGt6b25l
IHJlcG9ydCAtYyAxIC1vICQoKDIxNDc0ODM2NDggLyA1MTIpKSAvZGV2L3ZkYQ0KPj4+Pj4+ICAg
ICAgIMKgIHN0YXJ0OiAweDAwMDQwMDAwMCwgbGVuIDB4MDgwMDAwLCBjYXAgMHgwODAwMDAsIHdw
dHIgMHgwMDAwMDAgcmVzZXQ6MA0KPj4+Pj4+IG5vbi1zZXE6MCwgemNvbmQ6IDEoZW0pIFt0eXBl
OiAyKFNFUV9XUklURV9SRVFVSVJFRCldDQo+Pj4+Pj4NCj4+Pj4+PiByb290QHZpcnRtZS1uZzov
IyBibGt6b25lIHJlcG9ydCAtYyAxIC1vICQoKDEwNzM3NDE4MjQgLyA1MTIpKSAvZGV2L3ZkYg0K
Pj4+Pj4+ICAgICAgIMKgIHN0YXJ0OiAweDAwMDIwMDAwMCwgbGVuIDB4MDgwMDAwLCBjYXAgMHgw
ODAwMDAsIHdwdHIgMHgwMDAwMDAgcmVzZXQ6MA0KPj4+Pj4+IG5vbi1zZXE6MCwgemNvbmQ6IDEo
ZW0pIFt0eXBlOiAyKFNFUV9XUklURV9SRVFVSVJFRCldDQo+Pj4+Pj4NCj4+Pj4+PiBOb3RlIHRo
aXMgaXMgYW4gZW1wdHkgRlMsIHNvIHRoZSB3cml0ZSBwb2ludGVycyBhcmUgYXQgMC4NCj4+Pj4+
Pg0KPj4+Pj4gIyBidHJmcyBpbnNwZWN0LWludGVybmFsIGR1bXAtdHJlZSAtdCBjaHVuayAvZGV2
L3NkYXxcDQo+Pj4+PiBncmVwIC1BIDcgLUUgIkNIVU5LX0lURU0gMTQ5Njc5NjEwMjY1NiJ8XA0K
Pj4+Pj4gZ3JlcCBzdHJpcGUNCj4+Pj4+DQo+Pj4+PiBsZW5ndGggMjY4NDM1NDU2IG93bmVyIDIg
c3RyaXBlX2xlbiA2NTUzNiB0eXBlIE1FVEFEQVRBfFJBSUQxDQo+Pj4+PiBudW1fc3RyaXBlcyAy
IHN1Yl9zdHJpcGVzIDENCj4+Pj4+ICAgICAgICAgIHN0cmlwZSAwIGRldmlkIDIgb2Zmc2V0IDM3
NDQ2NzQ2MTEyMA0KPj4+Pj4gICAgICAgICAgc3RyaXBlIDEgZGV2aWQgMSBvZmZzZXQgMTM0MjE3
NzI4MA0KPj4+Pj4gIyBibGt6b25lIHJlcG9ydCAtYyAxIC1vICI3MzEzODE3NjAiIC9kZXYvc2Rh
DQo+Pj4+PiAgICAgICAgc3RhcnQ6IDB4MDJiOTgwMDAwLCBsZW4gMHgwODAwMDAsIGNhcCAweDA4
MDAwMCwgd3B0ciAweDA3ZmY4MCByZXNldDowDQo+Pj4+PiBub24tc2VxOjAsIHpjb25kOiA0KGNs
KSBbdHlwZTogMihTRVFfV1JJVEVfUkVRVUlSRUQpXQ0KPj4+Pj4gIyBibGt6b25lIHJlcG9ydCAt
YyAxIC1vICIyNjIxNDQwIiAvZGV2L3NkYg0KPj4+Pj4gICAgICAgIHN0YXJ0OiAweDAwMDI4MDAw
MCwgbGVuIDB4MDgwMDAwLCBjYXAgMHgwODAwMDAsIHdwdHIgMHgwMDAwMDAgcmVzZXQ6MA0KPj4+
Pj4gbm9uLXNlcTowLCB6Y29uZDogMChudykgW3R5cGU6IDEoQ09OVkVOVElPTkFMKV0NCj4+Pj4+
DQo+Pj4+IENvbW1pdCBjMGQ5MGE3OWU4ZTYgKCJidHJmczogem9uZWQ6IGZpeCBhbGxvY19vZmZz
ZXQgY2FsY3VsYXRpb24gZm9yDQo+Pj4+IHBhcnRseSBjb252ZW50aW9uYWwgYmxvY2sgZ3JvdXBz
Iikgc2hvdWxkIGZpeCB0aGUgcHJvYmxlbSBkZXNjcmliZWQNCj4+Pj4gdGhlcmUuIE5vdCBzdXJl
ICh5ZXQpIHdoeSBpdCBkb2Vzbid0Lg0KPj4+Pg0KPj4+Pg0KPj4+IEFueSB1cGRhdGUgb24gdGhp
cz8gU2hvdWxkIEkga2VlcCBzdGF0ZXMgb2YgZGlza3Mgb3IgSSBjYW4gbWtmcyBhIG5ldw0KPj4+
IHZvbHVtZT8NCj4+IE5hb2hpcm8gaGFzIGEgZml4IGNhbmRpZGF0ZSBmb3IgaXQuIE5hb2hpcm8g
YW55IHVwZGF0ZXMgb24gaXQ/DQo+IFJhaXNpbmcgdGhpcy4gSG9wZWZ1bGx5IGl0IHdpbGwgaGF2
ZSBhIGZpeCBvciBqdXN0IG1ha2UgYSBuZXcgdm9sdW1lLg0KDQpIaSwNCg0KQ291bGQgeW91IHRy
eSB0aGlzIHBhdGNoLCBwbGVhc2U/DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJ0
cmZzLzIwMjUxMjE3MTExNDA0LjY3MDg2Ni0xLW5hb2hpcm8uYW90YUB3ZGMuY29tLw==

