Return-Path: <linux-btrfs+bounces-14445-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 627D7ACD9B5
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 10:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50099174143
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 08:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47CC28C2D4;
	Wed,  4 Jun 2025 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VIaIjjg/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hwx4x2XS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2162B28C2D0
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749025561; cv=fail; b=dRdujkDkVy5QlaD+RGiiBfJUkuAepnBi+AUqykpEaWtTx4RINGpZF14/VzV6KJXsW1Is7um7QJNVVt9xwXpqVgaG0zYfKcNIEkUja/datA/m1PvDnU4kUyqUrwJ8C3vaGpnbscpW2QxkfUaOyoB3UMrM5yHD0W13VckK/BOwksU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749025561; c=relaxed/simple;
	bh=K+aKj1yZkuYX1DR5ew77TZVf0fTpHISLn3ewv0uXPJk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l3EhClfhoyytQjAIbZy5+SwRXSXY+fBvRWoDFAE8cNXd+rKagGffSHKc1Vok5qBvmYZDMgcGh+/HPQMW360MJDZJoz2y1ddg0z0G3YBw+a5MY8edR4C4GvmTFHzpREDY6hG0oyJ2lM1T4mmtAutPJhsy8wYR+kgdCh5v70ETm90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VIaIjjg/; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hwx4x2XS; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749025558; x=1780561558;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=K+aKj1yZkuYX1DR5ew77TZVf0fTpHISLn3ewv0uXPJk=;
  b=VIaIjjg/K1+09gDdfsq4bAWozoK16x+dNqtDlK2s4c5/hsxdF1gtZ//C
   rCtlfozY4TO/0UpomXla0J7LppRShe0wPzqmoI086T8gcdiRJprEfNCH+
   YhkZr+CanOx0iLqU8WbJE5G5/kcwy5eCcycN6JrccOzyqn4u8y3C+2KSG
   gNnzEVlZz/db5Ch3AJarDdaDIMwFVR8TwHGTBbRC1kweyI6mHljzvx1b6
   JOjq8BvBhgOYD7YCMa8QRFJi66/o/yvEkDQxceXeCG4RYyIjVtF9MKxPs
   wiI57oBGlNjyC82P1oe1IPV7lsGp5TaA08nohuZNqPn6RaMgalwfNZOfv
   A==;
X-CSE-ConnectionGUID: 7mC6f7c1Q0aY9l8gxBIkcg==
X-CSE-MsgGUID: WxO+8NfrR4Oo/WmXZepNmQ==
X-IronPort-AV: E=Sophos;i="6.16,208,1744041600"; 
   d="scan'208";a="88893820"
Received: from mail-mw2nam10on2089.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([40.107.94.89])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2025 16:25:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogEx9gSR8wy+UF1NnTX/iK1bQ4q26VB8NRId7VFX3uUT7iYxU7qWwaxLmqP88INGyLEWDLAYNKEdPDJiT74DCFfde2Ehyq+wOpp82Lrf7mfsLjMFxyhRWjPnEO+qGwVPAsLYk8esGRFzafnZLBgP+8wWmJKXjk9DgyKaRBZ2AO5ZPcqvigyZQF45j2wbFeZRw9u5/lVVfXw1A/DbdxnFMuUMnYmW3v59Df3YiaHAYK2t38wm7wvnyU4wBVse6wxvZPTxrK0WSqq13Ef+unzD+T3mF2OzewrR0xhG9hoj9vaVOkeRmOtXq5KqTkcgXC7eQPcvOHCwUA3awu3N4e35LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+aKj1yZkuYX1DR5ew77TZVf0fTpHISLn3ewv0uXPJk=;
 b=BbdWpBA90ji4Di2mklHh5DKcC2/GbyYsZLehRJy3rjOSTSPqy2YPJ/L1j2NVi9BNAiJ0kGkgoZuLId2JVBGhF1rCXOqF0UzCnm381o47fvDx9+HvSrH2jC/hWd78Bn2em2ebtXSYCJEpVqp3/IL0nfimcJV+Wpgc3tsT4OyuDtYr74FHotU35cvcyzQjx9swWu4APLN+saU4SHBkS4Wd2/qqJ7RxvI2rbY3HCbftSlHo3m2VhqYJiHKbeaXua4Ecru2Hui2RcEgNtDAcRH0dIzhNvixrHFUibXWOnNOvLg4lSZHjr8B6IO4UtPUPJcXzwb68qxq83uYM/k6ILWHAhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+aKj1yZkuYX1DR5ew77TZVf0fTpHISLn3ewv0uXPJk=;
 b=hwx4x2XSJRlZnj121TPS29vt0Fb2e1wi22o+1EtVdW97FjE98raIrt3YiZluI4WgttZjFozhq4qXwZcu2G4l3U8qVjfUaKLmuSTGkj61NvyInBZcNgn+tvp1zIRV0J7Mx1qNNNV7ktmuIYkxFV1VJi2llls0fKYrOvFzH+7Mm6s=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO1PR04MB8283.namprd04.prod.outlook.com (2603:10b6:303:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 08:25:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 08:25:55 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: enable experimental large data folio support
Thread-Topic: [PATCH] btrfs: enable experimental large data folio support
Thread-Index: AQHb1SmkepQo0r/EqkWyhXUlM/3/PLPyqkAA
Date: Wed, 4 Jun 2025 08:25:54 +0000
Message-ID: <29d563e1-872e-45ab-bfd2-094c05d12c39@wdc.com>
References:
 <899362450597548e37a52bba61f0157e929eb901.1749025117.git.wqu@suse.com>
In-Reply-To:
 <899362450597548e37a52bba61f0157e929eb901.1749025117.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO1PR04MB8283:EE_
x-ms-office365-filtering-correlation-id: df764ef1-d87c-4a8d-3c7a-08dda3416cd7
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UzNzSlViTmRkN3lROE1lMUQzVVl1YzNSTE9UMVlRYjRrbTVWWGRXNDRjWU1s?=
 =?utf-8?B?SlcwQUZlWkNlTU41UWpEMmNjSkxYNTZzR2UyQzBDTStja1JodHQ1cFpvcU94?=
 =?utf-8?B?b1NhcG1GVFpjWVBVdnBhUGU0b1NqOENpSTBiMEFZcWxTaW1NYllBeThjYVZ6?=
 =?utf-8?B?UWlZM3VqMmtUUEtoclQyMmxSTlZ4c1FZL0hwNWwwUWZXWVFFZFByUHRRWHVN?=
 =?utf-8?B?cFAwN2Raa0o0NkdWa1pqMEIrNDZHdUhtcEY2NE5rckFXZStxRk1IY0pnTEta?=
 =?utf-8?B?VVhOZGFJMW1Fb1VhU01HU0c3MW1oSXNyZ1hydStNVXpVTXNWRUFsNXZCR2R0?=
 =?utf-8?B?VHhhQ0Z3R3BwcmpveWFyaWJlWDdIYWRyMUdDZzlDUHU5NXUreEtCTVRYb3g3?=
 =?utf-8?B?WVVUeGZWaEFaUjRKcHB5RGJEQ3NiOW1NV3hHb0dYb2gycmMxZ2JWNE1HNXJn?=
 =?utf-8?B?akZVV05kSk5MZ1hITUMxVG1tS2dVZXBrMVU5bklKMkRKRG1vYkhmSjZVWFpi?=
 =?utf-8?B?Z0phcmhhQnMvR3IwYWErbDd5blppWlNrb0V6ZjdSL3ltMEwydmFpZWxDVzBo?=
 =?utf-8?B?ck9ScTVVU2lBZ2hlVzRoT21CMTNTSXJ6aVdZVkpWaU1qMmhURG9TL2dkdWR6?=
 =?utf-8?B?UVN1Vkh6QkhDTVU0U0dDcGJlcEVwQ3BTZWpxOXlXNEU2VE1BKytSZlYvckJv?=
 =?utf-8?B?ZWo1a0FNdkkvVStlaC9UNHV2VlRSU2VJSERBUXVmZTV5eGFPeWIwS3VVU2VG?=
 =?utf-8?B?WUNubk13NjdQWGRSRlkwQXhHVzI1RnQvWCtQSzlBSmJHSlREUUI2R01KSmxC?=
 =?utf-8?B?eGlMMUZLeFgxdEFyUGR0VjUza1RQWWk1cXNpLzJpRTU5elpUWTYzdExwbUdx?=
 =?utf-8?B?cnFVelZxNHAxSUNkZDkvandtTTRYbzV2aXlLR2ZRNmIzV2Q0ckRqc0pRV3hi?=
 =?utf-8?B?YnYrZTk4QXhVTnFxblBNRlhGMjNMSytrUUhCMm5KZ2VTSVBMTWFLZ1NBNE1L?=
 =?utf-8?B?bDFqRE56dUFiSVFBajY4bEpucnFoNjN3aDgwWitNejFQVzdRSThvMWFvMDF4?=
 =?utf-8?B?dm5FeURudUlBelQ1MkhVemZoSkhBWjZYalhwOUoxcG5VWThvVFZXVHBQUzI2?=
 =?utf-8?B?d2R5a1pXek9GVERybzRjTTQvRDZXVmlZakZNOWE0QUtsVS9vM0JUZ1dJRHJL?=
 =?utf-8?B?T1RNbXBFTTVJa0ZZT0cwRE8wN2NXMEE2a2JSUzl4SFpNL1ZnWTh4Q2J1YXRK?=
 =?utf-8?B?N2ltWHRxakloSy9WQmgzWnlqMURiUkZ0bTdHRzhBNXN5bCtlZEs1Ym1zOUVP?=
 =?utf-8?B?a2VCNmxYMTFTSFQ1WEJHdXhRczBJOGV4ZWFSNzZZby91TlNrRDk4VmtzdHNW?=
 =?utf-8?B?dkZwLy9CWjllakpFblZIOXZxWjdUbXI2MCtEemhHa2J0TGFmRnlYS2lwYWxL?=
 =?utf-8?B?VkQxdjhCbzQ2VGwva2lvQjJQYUNTRjJ2bGlFUkF2QWRCL3JyOGpvOGRSUUV3?=
 =?utf-8?B?dWg5Qk80N09XWnVBSFNtN3BON0V6WHgvalAxRlQ1VDhrenkrWWN3Mzc5RjVN?=
 =?utf-8?B?aDJRYWM0bTVNaWpaWFBNK0QzL0VDcWtpVjFhQjlieFJ3K2V2d1ZEeHJlRGlJ?=
 =?utf-8?B?S2JEbzdqQUQwY0pkcDVSdHg0Q3BsZks4N2lsWTdyeEt2dHBBRFM1N3k3Wk1T?=
 =?utf-8?B?UEN2SUl5Y0dvbGFhaDc1RnlGQ0ZrbGtia2QzVnAyWWNRUGdoakwyeXJhaXBk?=
 =?utf-8?B?QnVxQUw2WGY4cTNaZ05vcDkxTkFzTis0UE5Ec3E4QS82ZzhiUzA3TmJneU1u?=
 =?utf-8?B?blJzR3BlMFlVN2dFeGVVS2xPZ3B1YkZSNkUwNmFneFJ0NFhTVWMyc3NmQ1pM?=
 =?utf-8?B?cXI4UXRheG8zenBQQlRQeU1Oc0p4UFNOZHFTQ3llcWxDeExMUjBNbjdmVXlq?=
 =?utf-8?B?NmV2bEJxeW9acUFLM2lzR3VSVnhrUmpoeG9Jd3BsbFlJTno0TDFOZXlZUEt4?=
 =?utf-8?B?NzRWL1NGTHJBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGxHeHEwTUdERUdTcm5yeUVhbFNpUzNrNVY5RVNtbzdEMENtKzlWbGQrY2N6?=
 =?utf-8?B?L0hFK1lPc0VkNUNOaWx3eDlPRFZ1RENGN01BZ290QW9pOEluS2h2OVg1d2Vh?=
 =?utf-8?B?VVcwOVMyUHh2d21IeFRTZnlmQXJWNzQvbFRHREZyMUNpTldvN2gyN1NIdUFm?=
 =?utf-8?B?WEdOTWZnTGRhUW9wR0xpMzZJL29lYjBhOXFUazkyTzQ2TEdFLy81K1BIYkVS?=
 =?utf-8?B?VmNiUnFGT2J6R2Y2ZVFuaW0wQjc3ZnNsMHNkN2ZjVnE4NWhGM2NhZkYwa2Ju?=
 =?utf-8?B?TTJNU21ZQlhuOHFPaUlDaWFuaGpwNU9hc01UelRYM0hHcGUwTjhDRDZkVmt3?=
 =?utf-8?B?UWtuTVVmdzZMRUxaR3BMVHVaWDQ5VkE4VnYxS2V5UzNCWjJSV0ExUDdINmJl?=
 =?utf-8?B?ZDVEVC9UR3I1ZjVqc2JqN3ZOOHBiVlgrNmd5UTdBUitvLyttQmNicjlhSGxt?=
 =?utf-8?B?aEtNTiswdTA5dFNPV1lGMWxiNGdwQVlWR0k0QzVZUWJoYjM4TnpOdUZmVCsr?=
 =?utf-8?B?WjlOelFGeUxzT1ZUOFFTV2FXd0lIUnFtMVJtMFlvVDJCY2hQTHBrb1J3K3JE?=
 =?utf-8?B?VTRGYzVROWlGRHhwWWhKQmJDb0l5Ri9oS240cUhMV3JtWURRNVdQaHZERjZi?=
 =?utf-8?B?K2RDa3g4OWx0VDZndUE1eUg1YllKN1lGbmR3RmRRazY3UjFNRGwxbjJTQk5n?=
 =?utf-8?B?MXFYTHYyWFpiTEgxRlZ6SWdCL3MvUk16aFEvMlkrNXFPcGR2RnBlZ3VhVlFE?=
 =?utf-8?B?UVhTUnBtaVhrVlVtZGd1YjJWZTE2MU4rcGZoODl6ZG1OVmZDT25CRTA4TVo0?=
 =?utf-8?B?QzE1dG9sakF4d1JmMFdYeUJBdE9GdzhiSEtpdjFlNzlSTHlVQmxLZmh3bEZZ?=
 =?utf-8?B?OTFKNUtQUGxSZG1DUG83SUJpVTdrdy9BdU1zYlpBbnhRMHlOYkZnRS9GQmlm?=
 =?utf-8?B?WDF4VFFaTjk5TnA3RUR0VXEvcDNXZE9MNWsxY3IyQ0pESUFnVklPaGk0UDdk?=
 =?utf-8?B?MEVxMERTaDJGNkhhc0tEbkVxQmNPRkc0QXNycCtLT05BaGs4NWlwbE90WmJO?=
 =?utf-8?B?TGFiMHdyQUJKRExtQ3BGNnp0V2c0WFFoT0p1TUNoS1FyNDJMODVSMnAvYVJr?=
 =?utf-8?B?M0VlUVpIMWdWQzFoQktUSW0zb1c1Zlpsd0wrdjQ5U2ZhcEpOc3Iva05teFoy?=
 =?utf-8?B?ODJ4am9kMVN0MTRLQjdMQWJEakpDOUo2RmhqVEgrMGNTaDdEdzlHSEpIMU9q?=
 =?utf-8?B?QkNER0ZSRWlxSUpGYUg4MklFWS92eGJKYzNFUU1ybUQ3ejFpMllmZ3A5aWlQ?=
 =?utf-8?B?RWdsZVBUTFRvY2ttdGhvSkV2d2s3NDBjM3c2QkJFZlQ5UnpZRWJEQ2ZUdUNG?=
 =?utf-8?B?aHFsdEduUXQyRmQ1YVRCMWhhSmNGaGVYanFPZytIcUlOMDZ1aFJCbkxCS0xZ?=
 =?utf-8?B?S0VreVFzQ3E5L3gvaUcwbkNGRkpTS2NBVG9KRUxsMll6TTFOREU0YXNHN0x6?=
 =?utf-8?B?Ni9JWW5KQ0orVllob3RaQUQwN3FPNGhORVArRlEwbkJGdVpFSUxCdzdFdjZx?=
 =?utf-8?B?ZmZSQWFoaHliUkhlazlYUkdjdUVYeThCY2REYTJuSW1jczVDWlRnT0FzMGRQ?=
 =?utf-8?B?RUFhWExCSDlxaUJjenhIMUNNbldxM1ZPRnc4M3ByMXk3S29IeUo4N3pOcCsx?=
 =?utf-8?B?YWFJbkxvY1p6QURNUSt0VzdxUEhEaU1VdFNyMGEyUVRtcTlmYUViajJkTXhj?=
 =?utf-8?B?Ty9OV1VZSUo4a2M3MjFXWGFDZE1teFpZcnZ3d1pWK29nd2NZVDVIZG93c0xm?=
 =?utf-8?B?OGovcmxmM1c4aXdoVFB3T1h4S0JKNUJtWS9TTFRRNnA4Q3hzSXFBQzdVdjlV?=
 =?utf-8?B?MGkyQ2hHM0NldXdFbVB5NnlScm5ISjlUcW5NRDFwSENndVZIcVd3TmN6dXov?=
 =?utf-8?B?MDVaNUxWamNZK2NwM1RobWxXZHJ5ZURvSXZqenZhcUQwUXhzU1BhOGpCOGhN?=
 =?utf-8?B?K0JZbjJ2b1FSYjBUamtUVVJTbmlFYVVBTXRnQ1k5dEN4djREODVROEhXbGd0?=
 =?utf-8?B?MFN2cDVVZGdGeDF2eFFJd2pRcVNxb3M3cnVhbHdtaFlPZVplbkgxRk9MT09o?=
 =?utf-8?B?L3BTK2ZyWmtlYXBoNUF5bnp6NWFWSG5KM3RpWE5BNTE2WlNyVnNqWnNhWElM?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC4B38E3DDC03245AA237320C68E45D7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k0/LHhtDruR/qV/zOywdE3MFD9Mayw627sUOfIGwf+FyGwPYhiA1l7n3YWisPGKRMZvg4bl3AkK+wOq2vgqtOvdhSUiWk/msabgn7PSiy312prlor/u4GY9ntwqcCDEyrAlo3N7htvQbz5V+ktPSpVEYF4nBVy/E30c4VaTjn/nNUmIBSIWsdP20QdTVgweJT5zxH92vXK2rCuMZdYl1kEd38bneE7O+kc8IHgOn6WLwQOWLDFXUKelfKfzLhK7HEyHGU9UXYOuZZ5Q+BmQd7hn6QTUBInZ/KGt2wazDZCVcxSG7zGTp/195o54AJSLGWqL1TJkEPObU6riUEcGJpjiwgFCX8f8rdLY1h9C2tq+HSxlTP2eRgjQNbix1AVIYGXxp3s8naG78kZYZPUxaATWQp690TvxKaOL+lxMUdE4Gd5uty/ZpMIqRHXLHx/3QG1IplVymmI/3mdztlNHBrWruH6b0r8XeJU+vdfc1rCpvH+LRu2QW8RqUCyqiiAOvpjwTe6buogJ29VElyQoOYbd1HsnrEQfFfsA7fI4uso/I0r4M4tR0jM7Un2o2uoYezewja3nlNJjjfi1JRK7w2gwSyGFJfW81ytZansTBLUPytJcgT3bW/Z0V8BkayWKZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df764ef1-d87c-4a8d-3c7a-08dda3416cd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 08:25:55.0049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QP5Vo+V4FX4V7sRKasgsqr6DZnAdQvpLP6QMeBs06SmcSFL/UNqIW4GJyAK0e6RObcHSAh597VBiUojOp7hk/z+1ISFqzE2e540OmwhsjBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB8283

T24gMDQuMDYuMjUgMTA6MjEsIFF1IFdlbnJ1byB3cm90ZToNCj4gV2l0aCBhbGwgdGhlIHByZXBh
cmF0aW9uIHBhdGNoZXMgYWxyZWFkeSBtZXJnZWQsIGl0J3MgcHJldHR5IGVhc3kgdG8NCj4gZW5h
YmxlIGxhcmdlIGRhdGEgZm9saW9zOg0KPiANCj4gLSBSZW1vdmUgdGhlIEFTU0VSVCgpIG9uIGZv
bGlvIHNpemUgaW4gYnRyZnNfZW5kX3JlcGFpcl9iaW8oKQ0KPiANCj4gLSBBZGQgYSBoZWxwZXIg
dG8gcHJvcGVybHkgc2V0IHRoZSBtYXggZm9saW8gb3JkZXINCj4gICAgQ3VycmVudGx5IGR1ZSB0
byBzZXZlcmFsIGNhbGwgc2l0ZXMgYXJlIGZldGNoaW5nIHRoZSBiaXRtYXAgY29udGVudA0KPiAg
ICBkaXJlY3RseSBpbnRvIGFuIHVuc2lnbmVkIGxvbmcsIHdlIGNhbiBvbmx5IHN1cHBvcnQgQklU
U19QRVJfTE9ORw0KPiAgICBibG9ja3MgZm9yIGVhY2ggYml0bWFwLg0KPiANCj4gLSBDYWxsIHRo
ZSBoZWxwZXIgd2hlbiByZWFkaW5nL2NyZWF0aW5nIGFuIGlub2RlDQo+IA0KPiBUaGUgc3VwcG9y
dCBoYXMgdGhlIGZvbGxvd2luZyBsaW1pdHM6DQo+IA0KPiAtIE5vIGxhcmdlIGZvbGlvcyBmb3Ig
ZGF0YSByZWxvYyBpbm9kZQ0KPiAgICBUaGUgcmVsb2NhdGlvbiBjb2RlIHN0aWxsIHJlcXVpcmVz
IHBhZ2Ugc2l6ZWQgZm9saW8uDQo+ICAgIEJ1dCBpdCdzIG5vdCB0aGF0IGhvdCBub3IgY29tbW9u
IGNvbXBhcmVkIHRvIHJlZ3VsYXIgYnVmZmVyZWQgaW9zLg0KPiANCj4gICAgV2lsbCBiZSBpbXBy
b3ZlZCBpbiB0aGUgZnV0dXJlLg0KPiANCj4gLSBSZXF1aXJlcyBDT05GSUdfQlRSRlNfRVhQRVJJ
TUVOVEFMDQo+IA0KPiBVbmZvcnR1bmF0ZWx5IEkgZG8gbm90IGhhdmUgYSBwaHlzaWNhbCBtYWNo
aW5lIGZvciBwZXJmb3JtYW5jZSB0ZXN0LCBidXQNCj4gaWYgZXZlcnl0aGluZyBnb2VzIGxpa2Ug
WEZTL0VYVDQsIGl0IHNob3VsZCBtb3N0bHkgYnJpbmcgc2luZ2xlIGRpZ2l0cw0KPiBwZXJjZW50
YWdlIHBlcmZvcm1hbmNlIGltcHJvdmVtZW50IGluIHRoZSByZWFsIHdvcmxkLg0KDQpJJ2xsIGhh
dmUgYSBydW4gb24gc29tZSB6b25lZCBoYXJkd2FyZSB3aXRoIGEgYmVlZnkgbWFjaGluZS4gTWF5
YmUgSSBjYW4gDQpmaW5kIHNvbWUgTlZNZSBhcyB3ZWxsIGZvciBpdC4NCg0KPiBBbHRob3VnaCBJ
IGJlbGlldmUgdGhlcmUgYXJlIHN0aWxsIHF1aXRlIHNvbWUgb3B0aW1pemF0aW9ucyB0byBiZSBk
b25lLA0KPiBsZXQncyBmb2N1cyBvbiB0ZXN0aW5nIHRoZSBjdXJyZW50IGxhcmdlIGRhdGEgZm9s
aW8gc3VwcG9ydCBmaXJzdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFF1IFdlbnJ1byA8d3F1QHN1
c2UuY29tPg0KDQoNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBidHJmc19zZXRfaW5vZGVfbWFwcGlu
Z19vcmRlcihzdHJ1Y3QgYnRyZnNfaW5vZGUgKmlub2RlKQ0KPiArew0KPiArCS8qIE1ldGFkYXRh
IGlub2RlIHNob3VsZCBub3QgcmVhY2ggaGVyZS4gKi8NCj4gKwlBU1NFUlQoaXNfZGF0YV9pbm9k
ZShpbm9kZSkpOw0KPiArDQo+ICsJLyogRm9yIGRhdGEgcmVsb2MgaW5vZGUsIGl0IHN0aWxsIHJl
cXVpcmVzIHBhZ2Ugc2l6ZWQgZm9saW8uICovDQo+ICsJaWYgKHVubGlrZWx5KGJ0cmZzX3Jvb3Rf
aWQoaW5vZGUtPnJvb3QpID09IEJUUkZTX0RBVEFfUkVMT0NfVFJFRV9PQkpFQ1RJRCkpDQo+ICsJ
CXJldHVybjsNCg0KTml0OiBpZiAoYnRyZnNfaXNfZGF0YV9yZWxvY19yb290KGlub2RlLT5yb290
KSkNCglyZXR1cm47DQoNCg0K

