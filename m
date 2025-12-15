Return-Path: <linux-btrfs+bounces-19727-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50203CBC99A
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 07:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73077301B2E7
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 06:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFE23271F7;
	Mon, 15 Dec 2025 06:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ql3N476e";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Q+12XGvC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF096326D77
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 06:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765778668; cv=fail; b=TYm63QGMgtuOht7+4FWyOmgrdzGWKKpWjgc6tthzZh1e8JNP8696q9OHEEW5rf9RHgPBqe2fSrZYK8twZB6ou08MCPs3/qRphQXJ8SwqCf0DrGQcQmDCh2GWVgxjoO+s6zAmdtgdhzrJE6ZK6Ya0QPZGTDW2vQSlIRjUlZVyj/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765778668; c=relaxed/simple;
	bh=dTOTKN422LhIvkHP1TxDcJ2Yh6JmR+1J5O3+rCPHces=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OxI0rp7dinH8dxGAkiU9HNgZH9MmJIsoNG4COG/zE3OXsgLP64AMRGTi1vmuHetfT7lVhmHYYdwdXI/6jKJwtVDstbYH4p+b+53a3M2scc355FTFSCKdW5WcLW/5P1pR4xuShBZ3aYJ1Yb++PcpL3rK/Yj+r/tfWR/ka2iTUDW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ql3N476e; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Q+12XGvC; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765778665; x=1797314665;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dTOTKN422LhIvkHP1TxDcJ2Yh6JmR+1J5O3+rCPHces=;
  b=ql3N476eTYNokd8v+gkmzdK5AxDGQOIn0EoZEM09IxzoOuhH/2cZxTcp
   TYchzfoe6gQZatQdZ4Xfh69HKOzNSp/6eG3CzpNsSCgCN3ZvMquSsPVKz
   ceJSCoGvHOQtcgcfrKHcs1wpJ8VBKhnj6s0CfSgO222KjPw0xIRS3+i6g
   lhDoEidmRqV5xjBGGKGbS0cn632fd2K3TeUvwB8zoBKSz/PG55jmwQMKQ
   T2kDlD4zNnfjPsZPrLn1icQOfxu+0+RyvJ2lQNMmah4TYPWPbVweH5hUt
   La67rIBAP9IaYEa7nS3TNbws+YTtK3hTC7Bqs2KelP2nO0rqQvLE3j02n
   Q==;
X-CSE-ConnectionGUID: OFGMYTjLSIeD44Hl/6gTHg==
X-CSE-MsgGUID: ro2L1pndRyaxm9ptFVJr7Q==
X-IronPort-AV: E=Sophos;i="6.21,150,1763395200"; 
   d="scan'208";a="136515488"
Received: from mail-westus3azon11012042.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.42])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2025 14:04:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zz71NAt0OKwwLabo15YRBwcow3TQNw0Y6lsYic2BavVbu9awb1AVRM3tx+J3yHHDCc0FH4DWoKauj8phxuVcv6x4hkeWK79B5VmdNe8jMWkL3m06zepX3zHkDVVCMV97nNAp9okk9ry+nQRh2s64+tgz5YYh22N+naplCmAkpy9X0BwqgebNmIZVLxI4DRCI0OtnuONZDGYptf9l+hiK0XYtXO7b/mgL4gglu50HKUflxX8SKLL4gTdqOt7qB+H6BnBEElio+kn7tDxSIuJRhc4/ez/yBEBepJt8s+hH99UakFXMBiEDATrlKDTrk1SQOYSwztGC6OhA4s4I40kGbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTOTKN422LhIvkHP1TxDcJ2Yh6JmR+1J5O3+rCPHces=;
 b=WmQdGX13Si6/Yict7iU+PAkSfU+aoG6ZmSwf1W8UzfVf4hQ9W3m54Z4d1PlOf2FEGeUI/ugchbj3MflYLR4v7SvdP4a8kt84d526bNGqubqgjJjOi0//Bi6Le8qBGVN02vnWbRiFnh/OUcZtBVf3TGTzmcHDw/kTyU2iwfeLs11s1AMAnGtSkzmdh6FuZy6eS/M0Wt0XvbMQ3gEJmh9h8enVYavZIf126o7Tjre30wdgQGu/k+vdZqHmB52L5Py8G0h+xiK7pJi2l67t5zMUso5iHYswzhE9uZv/VWmuoC7g3UImR1QKh/Sr5Rqx+C2dMmh3LA8vHGaEAIfR5AFgfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTOTKN422LhIvkHP1TxDcJ2Yh6JmR+1J5O3+rCPHces=;
 b=Q+12XGvCoyTlGepHBreszKzMRHWba9leqxL+p5uvdIYkJzE0s6eN9+m4IvpfDoc5CsFAQtXo68UcIYRHFqkUQBoPXYQtLB0x45kUQ3d2APoP4ZAObROPW2w9tfCkhSGMx8DM/htoOxvZghcZZjzKcMCqe8Q4E2x2jDra/1pTb+U=
Received: from DS0PR04MB9844.namprd04.prod.outlook.com (2603:10b6:8:2f8::22)
 by BY5PR04MB6374.namprd04.prod.outlook.com (2603:10b6:a03:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 06:04:16 +0000
Received: from DS0PR04MB9844.namprd04.prod.outlook.com
 ([fe80::1f92:3bb1:1300:b325]) by DS0PR04MB9844.namprd04.prod.outlook.com
 ([fe80::1f92:3bb1:1300:b325%7]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 06:04:16 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: Filipe Manana <fdmanana@suse.com>, Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v4 3/4] btrfs: zoned: print block-group type for zoned
 statistics
Thread-Topic: [PATCH v4 3/4] btrfs: zoned: print block-group type for zoned
 statistics
Thread-Index: AQHca+3WNMEJ7VPA/UOcWJrrig7v6rUiOW0A
Date: Mon, 15 Dec 2025 06:04:16 +0000
Message-ID: <DEYKAK3DRTPV.3J9P2I7DBJQTM@wdc.com>
References: <20251213050305.10790-1-johannes.thumshirn@wdc.com>
 <20251213050305.10790-4-johannes.thumshirn@wdc.com>
In-Reply-To: <20251213050305.10790-4-johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.21.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR04MB9844:EE_|BY5PR04MB6374:EE_
x-ms-office365-filtering-correlation-id: 81aa89b8-53ce-4530-2576-08de3b9fc77b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?U3lDbFdWT3VHQm53d0xidGlqSyt6MDNYWDFob2JJRjgzMVQ3cGFqQ1cxOWNE?=
 =?utf-8?B?dkpBVzh1TllVWHF3TlNXN2N0M3IwZjV4amU3d3BSa3Q0dDVvTEVsN3pJMVhE?=
 =?utf-8?B?bW5UOCs3b2t5UGtDMmt6UDU0Tk45aHpzdzd4K0E5bUVMR2lrMjZXL2Y0cTJk?=
 =?utf-8?B?elFrdkVKdmtDcmlNTmlNQVhkS2JHUlRqOHdYQnV6a0ZTVHQ3UkcvamtTZjBp?=
 =?utf-8?B?emRiaHFEbWlWUmJ3TFNPSnJYeVdHMmNySXE3c0VZdVZpa2pWYnFXUEVnc0Fm?=
 =?utf-8?B?cXZ5UWg2ZG5LN2dtVWtZOHF3SUN0NGlueUc1L1dqNy9zSDdwcHUwYkI3Q3lK?=
 =?utf-8?B?WXRPTzVVYko1YjJIS2VEZXFFWHo4WlJVR0dmbUFyMllzcWJSdlIxUExSVHln?=
 =?utf-8?B?RWNDZVEvdTkydExqNmRaQkZ1Rm1Hd2doQlU3b2NLU3o4ZzEzNUw1K0xkLytW?=
 =?utf-8?B?VG5SWkNUWXp3aE9ZTk8wNVl6ZG9oQ0NkOUt5RTlFYXladjUwZW5zaWJvY0x1?=
 =?utf-8?B?R3lHV2JJMnVRTHJTc3ZZZWpnM2llem9xZStRN0RLaHk1VVFoclVlSFQwM3dB?=
 =?utf-8?B?K0N1UUk2eGNhQ0grSCsxK1hoR013RGxPVmZEbVgzY0Y1dzJIUWt1Z05aVXRm?=
 =?utf-8?B?a0ZkVWdKVmxBQmdPVGxZckNyOFNiRHJWTjYvbGF3N1p3ZmhnT2IyMUpQSE5X?=
 =?utf-8?B?V2lSRWk1ODRkdFhZVUQ4SGtlOW1HUndVenN4aFI2SldXcWdqRTBLcnVpK2wx?=
 =?utf-8?B?R1Z3OUZvcWVZLzVQUGpGRmxmYkZxSjZUNFo1QVJxYU40U242RHE4eUJzVUpI?=
 =?utf-8?B?cjh1WVdETTAxZFhoeXFvNFpDMXQ0bGo0U3I2aDhkeGpXbUdsWEp0bWNJYVdH?=
 =?utf-8?B?MzVxMXRqcTJNWXN2N055alljMlhlNkpoSDNpMExsQTR4RDJpa1VaU3lCa1dv?=
 =?utf-8?B?d3Zwdi8zeXJpR2FEQ1JVQlpnWDIxNGovMHRSTXNib1hQR1BwcDJsVkdubE02?=
 =?utf-8?B?TXAxeGtlcHZFRXVXNUtVeW9saXRhK0FZR1JyTVBkMDJBZ0FsdUdRbEFRdG5m?=
 =?utf-8?B?d3hNU0JCNlo3RFZhVWZSUVRFZGJ2NnlIQmx3elZ1U3NoMHlnQktTMEJHR1hp?=
 =?utf-8?B?ZnN0ZWhabitSRmhYTC8vZWY5TGNwUkRCbk1nQnRmRXBzaDk3bnl1ZW9JdTMv?=
 =?utf-8?B?WVVobDB1VmtBSG45OVVKbGx6UFUveVI1WGZvNHVBWHRrRENMMk16MFpBeDkz?=
 =?utf-8?B?YUxpSHlRcnlLeXRqL1pXd0FHRTU4bHlrZTdpZ0lXTk0zRUd5Z2tTQTRGL2RH?=
 =?utf-8?B?ZmJzK09aSnRuZ3E0VHRxQ05rU0FXZ2RTanVlV2ZKZnI2YmdvR0RKUWtSdGFE?=
 =?utf-8?B?aEFKd2thYzduWTRTMDVNaDBFQW5xK2xmQTVlMXpzcFlGSnpvMXVGSVg0NmdX?=
 =?utf-8?B?V041akl3VzZaenVHekZScHQrTGFEeFh0ZW1NNWNOQ3VPUUFDWjlzMlgrSHdG?=
 =?utf-8?B?aTFEYkRKWGs1NmpPWFJTY0E2Yk1qQ1NadCtsN1FJeVZ3N0tyTXpuTExWYVdS?=
 =?utf-8?B?RDgwRmlXbGx6MGVmYmkzbUh6V1IyeDRFWFZVUE80ZC9qWlBCelFGTkY1UlJK?=
 =?utf-8?B?cGp0ZzBUdnd2bGhuVjNROU1ZWnNKNWxaUDlVUGM1T3oyTHQ2cFREb1VwWmJj?=
 =?utf-8?B?dFNsTzQvdjEvUkcxVGFEUXl6anJVR21VMlNqMHFzamdCK09aSVJXVEVLUDli?=
 =?utf-8?B?THcwZWx2WXZOWE5tOHFHcm90UVNsYVpZajNJTGdWT2dhdkZHclo1VGNQdVJJ?=
 =?utf-8?B?N2hKajRiTjh2dFMwcnBBYmZCVmh6ZVpKbGpqcTQ1THpGbTQvNlNFNDR6ZEtT?=
 =?utf-8?B?S3kzOUgrYkhvaHF0S1ZiSHNjeEhzeXAva2VRS2tjcFU2ckFDaHc1ZWhjWGhP?=
 =?utf-8?B?RWpxYWd5Ny94M1Y4WU1nL3FlQ0RMWVpXZkxyM0N4dERLMHJTdVA3d3p6VHVy?=
 =?utf-8?B?dEp1S1BDWU9WditqUlNiMmZrU1RzcGk3aCs1cFpmMHdJNWtwOWJhYmhwMnll?=
 =?utf-8?Q?jhOUth?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR04MB9844.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OHpVMHNsTnRZMnk3d1ZNNXhHMElIRWNVSU9kZ0p2bzMwQXFJcm95L2pDYkZQ?=
 =?utf-8?B?OVRURE1TKzAyM0lvc3piWHZlajlTOXFpNlpNNTRoMWtSTDVOUmJUVXFVcUJu?=
 =?utf-8?B?UEVGd3lTM0FaSk1lUklsaHVqZWQxaGlZZmZFNGh5SWdyTTE3WHNLZ2ZEenhE?=
 =?utf-8?B?NkdGQ1lwMUsrRDN5NkVWdEYvY0YrekxzeFdLQkRwZ0hObEREQW9WR3pMNnh4?=
 =?utf-8?B?ODg4Z2c1WDdwR2NZcldNd0hpb2lOMWdBMWlRYnU1QWlrSlg3bXF6ZWRQM1Jk?=
 =?utf-8?B?RUxxWXNsRVdkcnRNVmhwc0hYR0JlQ0pvN3NsVUdDU1ZIZkZwR2c5blV6QzYr?=
 =?utf-8?B?NEo3K2d4d1ZNZlYvOGpCWFM5S1h2anNUKzVJTnB2NnR3aTZONDc5K29VRytY?=
 =?utf-8?B?UzJtY3NrOUtMaVJDc3pUNW0wR0YvWmRrUlB0Yi9GMXF5TnQxNk4wYVhGN2RG?=
 =?utf-8?B?cldWVVFVek5sdGF3VzJ2a01nMGxpZWwvblVPa0NiOEhGeitJMWZ3QlB3WDBo?=
 =?utf-8?B?NEhZNDlPWHJkQTJvYThMdmtLYUxra3luZWpzeWt1WERRUXVxMlNYUWg5OEtr?=
 =?utf-8?B?Vy9aNHJucDJVbEtYbVlzSGpzMll2MitWbllTSEd1ZnUvSzFSN3o1TTJLZnQ2?=
 =?utf-8?B?cnJ0SndRajNjVGxSWW00bHpwcitwOVY4UkpTalBhd2VnSzBjUXY5UkdzMjBM?=
 =?utf-8?B?bFdYbjg5SEtmWkZvWlYwalluTzNQOUdFVmkwRE5YZFF2OEJBZ2grNEhVS01J?=
 =?utf-8?B?OGtHalVTT1ZCakMxUXI0SzJaQ2JzeXo3V1R6dmtRY1dhY3JoeWNxVTBObGZt?=
 =?utf-8?B?bk40UnAwVkI0M0IzcFNEK044c0hkL09vdTIwaDhycFZzY0hKVGNneE5KajlH?=
 =?utf-8?B?bDB0WnN6MXFoeEg2MjV5RXdKVi9yWEJGL09GVllLaG8yQ2tRNGUxS0ZYLzM5?=
 =?utf-8?B?dXdSckNGNUk2UGtnSzgxVEhFejczK2J1dmhZWnF2OCtzNWw1Vk5kVjdSWkNK?=
 =?utf-8?B?ZmtINk9vWEdwWmd6ZzY2Mmo2bTVXODgzcEdmamNkQlRrN3pScDI4UmYraW5t?=
 =?utf-8?B?QzVoSjVNUTljK1BtczBIendzaTBENUtyWTYxV3lhemdmRmFPMFpVcnBENW03?=
 =?utf-8?B?R0xLcGRjY0xqekt6UHc3WXdmamw5TDdjU0ZjZXdwRWRxMGdKZGN0ZmFMWFVN?=
 =?utf-8?B?d0J0OWRKd3FKVk1lVnowNElUZmM4d0ROVjNMdDFVN2ZBVTNZN0VOUUFDaFRW?=
 =?utf-8?B?RjZBSHFBUUNPMHJpc0VuM0gwUUhmSWZYbk9SUE9GZzF1elplVzJIZzhwenZV?=
 =?utf-8?B?cmNXSFdaVkE2ZWtsaFA5SmVWeWx2eGN2UGtucWVVaTNHMmVFRHorZ016MWg1?=
 =?utf-8?B?ckd6YWpyb1hnL1NETWtXOW1pd044V2Zsa21lNXJUcHhTcmdJT3hhaGNoSkJx?=
 =?utf-8?B?Vjh2RUNGazZJSlJacm8xNnBqSkZ0NVhWaFRhNUhMa2hjcUE5bitYeWxSQkFV?=
 =?utf-8?B?OGg5cDkyMjJQcFQzUGdaY1EvNTdjTlhCWEFhQWpHY1JZQm8zZUlVdWFKYjNu?=
 =?utf-8?B?dW0vTXMrYVlic0IxYndPbW5udFcxQmVBK1lGdXl4TnliWml0NzRRTmtIZXd1?=
 =?utf-8?B?dytubWxNdGh0eVFwajZtUlhZdWljWnRrWnF5U0EvZS9CbHJQNThoaVZtV2cz?=
 =?utf-8?B?RFYvSDk2L0VMNWQ3eHZ2RVl6STVDQzBDbWg5RzZMR1gxK0pRVDlBOWpHWUty?=
 =?utf-8?B?MkU2NWtGb0dTV3lCMUc3Z011UUN0ZDR5d0drR2U2b2NIbWxCeWZxcjdkWFp5?=
 =?utf-8?B?RWVsTVFWYVRVb09aNWJEVkZOTnBGczhjWTdoT1I2VnRXVlF1MGpjU3JYZVpI?=
 =?utf-8?B?WkVwbDkvU1RUbmh3TUUrbmsyVHdETy8yRlBVOW1NVkcwY3BoV1hrcVpOU1ly?=
 =?utf-8?B?ZThjZGlVbUhBL1lqRmlUNjB6OHlwM1M3T01yZmEyT285VUVxYy9QY3B4OC9P?=
 =?utf-8?B?bVREc1h2emJZTUh1ZXVJeHNPYWtzc3YxREUreWE0QTRmNHI0UXZKTXdVQ3lJ?=
 =?utf-8?B?SWd5WmRIV2hubWEvY2RnQUtucVVud3R4N3BqOVdNUGhuTjJkaTZlbmRpRVhS?=
 =?utf-8?B?U2hwNHgvdTVIUm4yWnZaL1FvQ1NDdHBkdHNQY0JYYXJHUTFGb09lUUFxQWVl?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6918866A98CBFE40A8975F27DD93532F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fdLhVgmJniuxsttud9JNs2ZWUvlVtGokNtnxs2LhREgy/vlTly/FpV+lUgDf99fUYzITwLghWTV0MZllwO7cFfA9MN1LWUugqc9JjePN8MT6O6jDMx2WWkai3Ed8zqL69/OS8r1qZL/VA2L6rjj6wkfcMZnzBjAMfnR+eEtGKWzeynIjJENOURyIRbf4dtH+Q/NK+d0cj+LrW/RETWjzVZhTAWPrbA61JDTB0Nzt5HcbbWbCno4FhelKItaL7cxSWQ9r6Fu7sowmKA38jnAxZ3JotBdTMgbnCQZiZbOiqBbGezeLkhvBlRL9QWYPFHQpbasULG4n44jsHoQzKI3tMhe3I+uEsZUHOf/cZfBXcxicKa1YrwOnQDv0NhyeKfYKsKL++LFa2yA7JKbcHGZq4yiBI5QpRo/rSpoCQMhi0IgP2BTvxILL0f57Cm2Ds2aV81zEeQ2fBjyPXCbkzrrIFnE/0V3MbLP/T3x5WgwHQ6fHBemYKpkMN/WkcnIY/pWJAsXLAyL6Rs4xxBMtVRN6EJzzXsYQLa3tPEGyMRxrkwU5HccUx/G2JGkUDCE5v2oA8IV/0v6dSgkzoNyZu6kuA0INkG18PVzOKqa3GdEGD6/j+TaIBrUuBxLFPTw3RR6I
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR04MB9844.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81aa89b8-53ce-4530-2576-08de3b9fc77b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 06:04:16.5667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VBGrE6UYXsZ8k9RGG5hlnpedov4sNhZj+W0WixuLVsw094y4o2mnQR4PEXC2X5F1wYABOQkNf/LTr/ELRKZn8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6374

T24gU2F0IERlYyAxMywgMjAyNSBhdCAyOjAzIFBNIEpTVCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdy
b3RlOg0KPiBXaGVuIHByaW50aW5nIHRoZSB6b25lZCBzdGF0aXN0aWNzLCBhbHNvIGluY2x1ZGUg
dGhlIGJsb2NrLWdyb3VwIHR5cGUgaW4NCj4gdGhlIGJsb2NrLWdyb3VwIGxpc3Rpbmcgb3V0cHV0
Lg0KPg0KPiBSZXZpZXdlZC1ieTogRmlsaXBlIE1hbmFuYSA8ZmRtYW5hbmFAc3VzZS5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdk
Yy5jb20+DQoNClJldmlld2VkLWJ5OiBOYW9oaXJvIEFvdGEgPG5hb2hpcm8uYW90YUB3ZGMuY29t
Pg==

