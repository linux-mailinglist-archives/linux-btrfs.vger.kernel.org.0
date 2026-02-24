Return-Path: <linux-btrfs+bounces-21858-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHknAC9GnWmoOAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21858-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 07:33:19 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F40182746
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 07:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2180B308A8B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 06:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0F63043B2;
	Tue, 24 Feb 2026 06:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Qt4mB8XH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rtQ70C41"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80963043C9;
	Tue, 24 Feb 2026 06:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771914765; cv=fail; b=MMO5k8ADTLuZ+h7gKmS5fz7v7D0hRpuK4d7zhjQIBSERlzvSofM7Bdx/MhWPwZVJrbn+gPftu8LEKxEABzYLlU7+zSW05y1Toopq0Qh4B5xRzJOeyYV9g5Mw7zI0iKanJctJG4IzUblCTEgtWNIkQ3epzCvSFjP5vWsFeIogdPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771914765; c=relaxed/simple;
	bh=FR4jqR1hCD7QAXznTF7a3TgWxkfmoT+LIcHsAuy8Hw4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rxcIWOYH4CdZ7sqEI03Gg3n337bymQtJJOB3u4IYeWynN3ap0WE4tHMIYmVFNNQYMSpd+ed3Gi0hnBdWse+5lQKG+/JGwwshsqEZCSbw8zZYP8vrerROakqzPkZkjB+ZF2+kK6Q6z7iUDIJXWM80eHgHZ3baaNkcSN4cwEZJOO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Qt4mB8XH; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rtQ70C41; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771914761; x=1803450761;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FR4jqR1hCD7QAXznTF7a3TgWxkfmoT+LIcHsAuy8Hw4=;
  b=Qt4mB8XHFUvf6C/tuv+RXjKpD/8OR4ZJljkqtzgAg+ZqB32noSIiQPgB
   E+D8LhjNURAWEq4UHHjrtNZlPULwOhGkY2amI0wYsZIQ8iOQZqds0gmqR
   WOa7J+gZjGL4/tPgP1XX9+iCpoMe+r7CoZjKUUhry8W+pCwoio6MsINMq
   gdyMykoJS3VFK4Gwos6ORubFu77Sqdx3tsF3oh1NkOz2hocd82IuZqXLJ
   ZMMfYIMUqnRfSoe3253PRO04+TSF5l/7QtYztn42jUjn1Ztp/ytLlfxlS
   ffnyrFWIr4J0hl6EWIJH8AqtP7GSMcfpAw16IxgrSvHal2Ug7T8zdlVR0
   g==;
X-CSE-ConnectionGUID: 1VweS8O0RRyF4Pjh1e4a7A==
X-CSE-MsgGUID: HfwEqBeKSKmtG6Vf6P03wg==
X-IronPort-AV: E=Sophos;i="6.21,308,1763395200"; 
   d="scan'208";a="140913787"
Received: from mail-westus3azon11012047.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.47])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Feb 2026 14:32:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCxSPnRxRhH65ZvA490WfIEh9cjPn6riNHmFh/ywT6Jf0Amc7JxD57QuczTkP8RbVJq/FjioLBReFYTr9jP3d9MHTDx2fKwBtc89QoEgf2tHcksjmweYitb+zHdedkqZiySzncY0Rws5JhEA2FViYdFmOcEEJeujzJMW3C1U91hakoiRU9WEj9FjCo3rQlru1eRU55p1hOa8oUkFG92geaQok4fPhl0WWU9iLMIPukVe04ee1qWNkehS49OJcH8cqeWQeD0WKk/OzOC/6QAeOgyLTscMtTPky0yYUMg1Txa8WZF0voOOb/VL0Vv3+oErGU1qgy8wtXkqXSpfTNtE2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FR4jqR1hCD7QAXznTF7a3TgWxkfmoT+LIcHsAuy8Hw4=;
 b=RmrLsMUwe3ImMG+vDwdZJv0FMF+LHLKrPHSm4ln9fJxKhbImXMH8PZskE7hcJma+KC/slHqw9i3IS4n7pAeYgllMxWCJkm46H21XN304FC2AeWrntPk0uUM58kjU1nYMmbJ94YgM/FFDLKaQQTSJo1IGCRcOJMEL9q25MHpXEES/S3lFYwZ8UB1u1MLSyxp+AzIEQnyypvWETpIQHH0ovy/jkx/34sXDzxo/TSwVpTmr9HCjVstNunpmhyBOfyB7uV6dmzSUScnplvkUV2TbgGa/b86g/88e9N5sVZJ6PEThRvM6Mn0pvT5PdNzL9tBILUaBCBhDflKRKHzVPkfD3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FR4jqR1hCD7QAXznTF7a3TgWxkfmoT+LIcHsAuy8Hw4=;
 b=rtQ70C41vmOjQ1JxoZ9cWP2bMNCrXPSj/Mev4v+RjaOKxm4xn54lT6SWKr1tIcvWXUaOUkp4ta/eRI4OuBFzZH+oaqHV4ctBvGpqBs1w/CYWTATq8M10RCLw70SFKZwrzWJEMoltRtqD5vLwo28+wWJOYstz3rp3MNipnn3IRPE=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SA6PR04MB9591.namprd04.prod.outlook.com (2603:10b6:806:432::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.10; Tue, 24 Feb
 2026 06:32:39 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Tue, 24 Feb 2026
 06:32:39 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: =?utf-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mssola@mssola.com>,
	"dsterba@suse.com" <dsterba@suse.com>
CC: "clm@fb.com" <clm@fb.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kees@kernel.org" <kees@kernel.org>
Subject: Re: [PATCH] btrfs: replace kcalloc() calls to kzalloc_objs()
Thread-Topic: [PATCH] btrfs: replace kcalloc() calls to kzalloc_objs()
Thread-Index: AQHcpR6FTilAFWyQT0qTcoLEsg2m07WRZH8A
Date: Tue, 24 Feb 2026 06:32:39 +0000
Message-ID: <076d767a-48f3-4c71-87d5-5c304513f9a8@wdc.com>
References: <20260223234451.277369-1-mssola@mssola.com>
In-Reply-To: <20260223234451.277369-1-mssola@mssola.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SA6PR04MB9591:EE_
x-ms-office365-filtering-correlation-id: 395668f3-1611-4c07-9086-08de736e81bf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UWovSXd5SXU3R29BazkveFVRU1h3OGh3K1F0WG04a3Myc25kYTA3S0IzMDdO?=
 =?utf-8?B?QzVDL1ErcWxMaU96OVNLWXJsOFEvc1ZWZ1FiSnppR0EzaFJLRktNWi9hNGRh?=
 =?utf-8?B?TG1aVFJ0am5YNVFoNnhWY3JqbHVicEw1TThLSFpKeVRUZS9JT2I1OWltN2Vi?=
 =?utf-8?B?WG9LaXljYU9UR09lRk1TU0hRekZxYnA4empPb2t1QWZ2Ym56K1pCNzJ6M1h3?=
 =?utf-8?B?eThNK0JtNEo0TkRZc2dSMmVEbTdrekJVV2l0VXkzZ3RocnpxTHRJQlE0ODZi?=
 =?utf-8?B?RTFVSkZQRjFMT05WM3hCSXZsd2plWFJzSlhYNWRBTjNlWkdHQjNPdFBxdG5E?=
 =?utf-8?B?YmNCaFBrSW4yYzUvQW1YclNYZ1JCOGg3TjZnekw5S3R3My9lU1JVSTFxMDBZ?=
 =?utf-8?B?WFY4aHF5L05ZTEpIbnV3VjVnS05Lc3RReHU3QnNwa21la0NFbEpZQ2R4YUpU?=
 =?utf-8?B?ajd5K2hlQmFpeTd2aVZnN2pxYllHNkpvSDUyeGo5MDBpYW1Td0ZiRGorZndz?=
 =?utf-8?B?TjJmTm5MdnAyZnlpTm1ka2x4VkpKZnNqdzVNTXJLN0NPMFBQRDAvVFJoa3hJ?=
 =?utf-8?B?b3BOajVsYThwenVMaUJNd1RiU3J4U0tjM1BDSitwb3lUNzhoSU44ejBpb2or?=
 =?utf-8?B?R0FGd0lUMXhGQ2RERU9rVXlFVDhKMHFKUmlpVk1aV2xJSTBoSjBNM0JCbFE3?=
 =?utf-8?B?Y2FXWFZBUnhIbHExU0dqS081N3cvbTRaZmNhckpzSTVxRXB0M3ZVR3d2RW5a?=
 =?utf-8?B?VEhaMGkwUWdHMnZ5NDJPVTIvK2F3WURGNnR1Mkt5czBlS1Fuc2N3aEgySTZt?=
 =?utf-8?B?M3lJZUF1S2pNc3Y1bGg3TlArNjRpV2NyL01uMTBwaHlvbTRHU3VUZHJ0WnJo?=
 =?utf-8?B?R2M4NnVHeEo1cGdUUnBHQ1NWWjJmYjZRblFhN3c5S2xOem5ZTDgyVFRQSUw1?=
 =?utf-8?B?NEtPaDQ3R2tGd0tIa3praWZpOW1IVnpxQXhXWFRGYS8vUVVBQ25CODlZWmdo?=
 =?utf-8?B?WnFEL2FscEx0OHk3cTBSbEI3WU9jT3lBc21RZzJoRXQ3YTh4UzhUVUZ6dk9Q?=
 =?utf-8?B?ZkxVSW5uRnZtQ2QxL0M1QWlBandTRzRVS0lta3dWcFQ4bkZuTWcwL1BTNG1V?=
 =?utf-8?B?V0JUWXhnRWxmcG0wQlByWWpYbWM5Ry9LeUxNWkFYYTFSOGllR0JaY3R3SmJX?=
 =?utf-8?B?bUpubERJNjI3NFpEY2RTSW9DMFhPNWhJbEpVc29lekExMWJQWm5tTEIvUk5F?=
 =?utf-8?B?eW5sL1U1Ukd3MjN0aUxXNjNlUXVJb3NVc2I3aVNidjR6RmJSQ1AzRC8zejZv?=
 =?utf-8?B?M2hJK1ZVQVlEN2p5VHRRZlBwL0xHMW5UeWFXZzN4T21Ucm9GYlppTmVQL296?=
 =?utf-8?B?UVdMQy9jNFhsUmloSEl5ZEJLbVVUL3NIb1RMM3JQUXNickhwZ0N4Rm1TSlVa?=
 =?utf-8?B?VThHNTlhR0UydEwzS1UwR3JQZVZwMUVOaEdXMHNCdHVKeFpBdytzS2xtbkQ2?=
 =?utf-8?B?K0xtd1JQaS80cXdaZk83MXFpcUpUclZ5M2dHWktTVnl4MkZORU5HaG5IVGw2?=
 =?utf-8?B?dytaTTZMZ1J6clpybjQ5TFgzL1VxR29BMjg1WmkzcUlMS0tGUjBxUFltUng3?=
 =?utf-8?B?SHpTczF0OVNzMURIUW9wK2s5NW1qdUpxaXg0Vm91TlNSUGN1aTkyenh4MGdh?=
 =?utf-8?B?M1NBT04wSytiT1N1Z2Zxbjc4OVpXUVF1L0YwbC9xQXdaVHdqMzMzUTJyS0cv?=
 =?utf-8?B?Q09BSnlUZDJKKzdHbjIxWVd0M1lJcEdVdTJlTDB0d1ZSMTcrVC9PQ2ZuWnRq?=
 =?utf-8?B?TnpGUFFJaWN2Nnh4M1RDNXpTWTh1Q205SVljbUVrVkFERUF0a3RmV0NNY0V3?=
 =?utf-8?B?bmpTd25DZlB5azBFZ1N5dXI0UU11RjZqVHpPQkdsbG9tT1MwRk5MTGNzRlNm?=
 =?utf-8?B?RE82VC9STzNxZGJuSzBraVJmblo3WkxBcHR3OEJUa3U2elRkT1BqbXVnY2Qr?=
 =?utf-8?B?ZTJBNWZQaldNWHZ5cHZBU2ZKb2NqeEh0Ym1wUmF3WW03VUpSL2RSaFVocmVr?=
 =?utf-8?B?NU9xU1dRWnd6WFlIbmlRclorWWU5UjJUK0JyUkJnbS9CdVhZMElNYjM5dTNu?=
 =?utf-8?B?YzVmejNuL1dmQVdCTUxvMjZQbG9GcTlFSmNyb25teHdqUXFVZ3JsWGw5bC8x?=
 =?utf-8?Q?iR4FSxiUvrIapgQi7FoY0bg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHlaQ1R2Um5RcThNUlR6SzdSRkFjYTlWYitudFZQbHBWUzVFd0ZnM1FnS2xE?=
 =?utf-8?B?bHRGZi9Ld2VYcjBRRjFpMFYwL2Y1Z1IxTm9NUWZWcVljelE1ekF2TXE2MkRi?=
 =?utf-8?B?WmNIWkpWaW5jY05NUDRSNFBNR2xjcDVvTUhXL0N1bzRYQmFGamxDRS9QYUt5?=
 =?utf-8?B?aDZOM3Y1ZmMzOW0xQ0l0Z0hXUkp0bDBSTGRMSlNGQ3hpTk9vSlVkN1BNa3A3?=
 =?utf-8?B?cDFzcDY1c08vMU00aVZUMGpmOW41MUNKY2dOYzN1dnNEZnhtUDk1UEx2OTNL?=
 =?utf-8?B?OUZNTjc0RlJPQ3NkSnVMYXFvbzVlSnFjVy8zQko3UE4zdHB6a0laM3VMU3gx?=
 =?utf-8?B?SGZnK3phUWhWQmpVVWF5dktGSW9kTXF5OHorZGtHRFF2aU5KQ3J0ejY3VGFx?=
 =?utf-8?B?R0s4aFIwTkVtZGJiR2RmZ3BZL3RZRlJvSnplVDR4bkw4VUdLNE1pZ3NSMGhW?=
 =?utf-8?B?OXdXOGsvT0R1OUd3Z0hsN1RLcUNBYml3ZkRJNHJ0TGx6MGRsWFE4QTBxWmlZ?=
 =?utf-8?B?ZnZCMTJVZ3VVNGpaemsyU3RMYjZ3Nkl6L1BVV2JIVFVaM2pFL2xsYzhGb3Q1?=
 =?utf-8?B?cHFiM24xYStTSno1MlQ0dnpFb1l5alEyTzBvUmpHaVZSNWpubTArRDROVkll?=
 =?utf-8?B?RkJxRmVYKzZPYk5XZjhkU3dPY0hDVWtPdmYwRlQrVmxKbm1UZkRJd0FrWVAz?=
 =?utf-8?B?K2FIbm1GU2ZKRWlQa3JtbzMxOGVUYk55Zk5VdGhHSkNST1o3Y04yVlJuQ2pm?=
 =?utf-8?B?b2lHMXRuVnZhRkRvUVdBalZMR0JybVJGUk53Mkpsbmg4dFlHMGZNNW15N2ZX?=
 =?utf-8?B?VjY5ZFp0NXlUdW81MSthWkhnOSsrNVBmZWJ1RmNRSWh3VDc1czZyNldGOU9I?=
 =?utf-8?B?WjAxSG9adVUrbDJ4ZXRnNDl5MytaSmdUaE5tdmZIZmpVR3pJV3loUi9DM1BC?=
 =?utf-8?B?eXFIOU5YK1Y1SVlwVWs1RkhTUnA5WnVRQ3pRODdXc0ZSck1YL1QvWUxQN0lS?=
 =?utf-8?B?Ulk1dHVwdU9ZUlhNS1U3UGFKZG5FMDNVbEljYWYycTJCc2JRWWpQUHROa1dt?=
 =?utf-8?B?cGk5cXRwZkttaFRRQTBZK0hOc1FQNWRNdmpsMURUcTcxZVplVVUwTU1idGRH?=
 =?utf-8?B?UVpkUmhsem1XWjZEWjR5Z0NZUWlpWDh4Zys1VGl3bjdtTHV4d3JublVtWWg1?=
 =?utf-8?B?RFV0N1lNM050WEExUndzRS8xa3EzVTYyY2FUZWUra1pkQVByelJMMnlLbTNH?=
 =?utf-8?B?UmZjb3ZpNWlUVW5zQWgxRTRRR3grTUJQUUlXKzE2QnNaU3VvanF3V3VDRmsr?=
 =?utf-8?B?eGNGMTRhcTJrNjZuWUNjVU5CWDdMWlVKUGV0OWhLZ0huZzRObEIwQU1lNTBW?=
 =?utf-8?B?aUVjelZRMHIrekV6L2x6WnZSYXFIVEE1WHhWMFltbUVqS0VXMDUzODFpbXZx?=
 =?utf-8?B?NjdqRktpYVAvTXdJZ1UzdTEzc2RORTduZ05KeW5LT0xoZzUvT1RFUnZjZXZV?=
 =?utf-8?B?cFBheWdqSFZlSSthMkcrNUQ1aDdQb0Znc1lHdVdsY255Z1o5SjZmdWx5Zmo5?=
 =?utf-8?B?cnRXQkUvWTZDN0lYUTBDQ1FBTHB3cmZxNzN4dHA2VlJXaDNpeW95b1JsMXdW?=
 =?utf-8?B?T0lXbDdsWHVsZnZaNDJTWWxlUFRrbW1WSjZpSkZvdE15YmozNWhWT3JDd0RM?=
 =?utf-8?B?QW1rU3g5RTlGRGh2bndjc3dTdXZGV0F2eVhIZ3ExR3pvSlRZaUZZd1YyQmlm?=
 =?utf-8?B?TFJ4R0M5STArYW8zLzJoemJVSDVEdE95dWxMWXFzSWhhMTRGaW1XTU1pSlN1?=
 =?utf-8?B?R0FnbXdNeFIzZ0tDYUhERjhWQXIxQ2hsRVBpcG1PSzU0NFVHUStnRlprN09P?=
 =?utf-8?B?dzM0SFhjU3hKTzNpYm1udWl0QzNhTENZSnppUTUrQmFvVFA1cDF3U1B6NW52?=
 =?utf-8?B?bHU0QUhwcjBadjcrZjdvRlp5bU1ZVTk4WGhxZW0wZFJobElYYmFvbWxqVTds?=
 =?utf-8?B?aEQrRWNnYVpuSkJFbXR4WGdWS0oxbjBlRnZZU1pPcWluQStQdUdmMHlKVWg4?=
 =?utf-8?B?M3ZmdzBFN0pxS1NKSFRQb2pIWDZjMStqUnE1ZEwxeU1vOHNMRUY3T3h2bkxy?=
 =?utf-8?B?MmdJMExJSSticmp6ayt5eEZnU1ROZzk2clBETHBXRFVFa01wd1ZYb3djR0VR?=
 =?utf-8?B?eUpQOU9SU2Z3YVpHQVQzNHBuWkdsUGJ1YUx2djZDWm41VzdpYmVXTklyeXFn?=
 =?utf-8?B?NHlmakdVb2ZrYUNaUXJDcHFDRGRPN2pSN1B5N3pGTW4xUlVkUktWYXU2cXVp?=
 =?utf-8?B?dS84Niszd3N5QTRUWkU4ajFZYnFjWkdKcDZ4UFh0ejYzSnEvQldKNWdacUk2?=
 =?utf-8?Q?RSXCjNtZGX4JueQVTTt9rmIigy0HBN3Zn1ReRpdbWGg3s?=
x-ms-exchange-antispam-messagedata-1: py1BuXtFr5qpiO0DhTplfr/9AbuOt7fKbo8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5194F1540F3ED449B1CC53A8A2FCFDC3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8xoGz1G1YiAN9k4+XhnjR29rnRaAbQFmvkBfhBX9a/7v0xveoCCs8XeBQzdoXgTbkYZ5/yR4xOuHhFCUP/QYkCG0/6AZ1HyAdcP7/AzVPaekUekk1XPvc1qPX/eIQI+nDaoHJm5VlQn4HngRmB7ZcDg2gQulkA/4UpIQ3Jzaov1aRp4eZdbsgCR+P4DtR3EjB6p1rlYvZ3zMEnSh/vCD3C61/vI9ljl+F0LI9rUxt9of8slHZ5cLqPdDpUVrbhEbWC5nguv4E/HNCO4PS3czJBK8m/LBxE/JNUUWrBj+vDVHo+ZHyhXA+AVrGUve0bkCJQlH8RmZG1kA6wjgPtjjRZU0Wu/H3AWx87+INPWXCK4ANKSHKMa1yUQChnUcWHStQdZ24JZWozaCzy/topZFrKConKuXHIC/SBBmvpC+elvHDVqyWow4eh7675FdMO+x1x3bDP06vDt/uDQgyi+V58WpRoS5mK5Bm+6I9mdOoph5b9b2PKMH3A6e29fB47pU5NjtVs2YxMvSp0w8hINIE4dac9ybJda0t2yQj4gVZOY1zMS19fk0xI+k+p7dDB1/rrZluFelvmOCsV1j7lliaGtpEIO5gbCxGrk+t0HuGOvi1lPeifxb+7z97XknWq1u
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395668f3-1611-4c07-9086-08de736e81bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 06:32:39.3229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OghAVLyi6dhuCiY2ZXG0akJSVdsoUMM/+SX9m38gPr5K1LkMGYxgTQ2rvcKnZ/0cJOeSWxL0B4HALMrj7hXaU/ikguOuZh/D+OMsMR/FHI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9591
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21858-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:mid,wdc.com:dkim]
X-Rspamd-Queue-Id: 90F40182746
X-Rspamd-Action: no action

T24gMi8yNC8yNiAxMjo0NSBBTSwgTWlxdWVsIFNhYmF0w6kgU29sw6Agd3JvdGU6DQo+IENvbW1p
dCAyOTMyYmE4ZDljOTkgKCJzbGFiOiBJbnRyb2R1Y2Uga21hbGxvY19vYmooKSBhbmQgZmFtaWx5
IikNCj4gaW50cm9kdWNlZCwgYW1vbmcgbWFueSBvdGhlcnMsIHRoZSBremFsbG9jX29ianMoKSBo
ZWxwZXIsIHdoaWNoIGhhcyBzb21lDQo+IGJlbmVmaXRzIG92ZXIga2NhbGxvYygpLg0KTmFtZWx5
Pw0K

