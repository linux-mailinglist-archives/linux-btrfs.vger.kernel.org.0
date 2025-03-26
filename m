Return-Path: <linux-btrfs+bounces-12593-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 408EBA717A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Mar 2025 14:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C6C3B5DC7
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Mar 2025 13:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555631EEA38;
	Wed, 26 Mar 2025 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BMDONyEb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZgltAmdS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4561ADFE3;
	Wed, 26 Mar 2025 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742996374; cv=fail; b=AifdSHLf6y778HhQbIrRDWK+pFgsHfGWUSgKvEXi8g4yG1VwgQId7Qprn1WLFz0f5JeRxzo03mJLRa3enqsM1tArfIXNMNtVkLM9fPbMy2FO2M4keatgyCrAvsm5TNKxgTa2pPy9A6NQzbCMKNL28qmKkMYdZAjr285xk/Kg/FY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742996374; c=relaxed/simple;
	bh=QgXqnnA6VsRUt4KCM6QQ+qD4q2/LnR/B2NSBgRvIk3U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sO+tvIFPOvKo9n87AHDjPQALnU5ruXhCx3TfCdHxvlZWLpmqB70jchJkRKo0C/R9Z01JrJW+3QXtHuTw6vZ4tHcc6imIMTuZcp6OqSkYurGGZ7lFN8NydaEQ0tHYorZGsX+ptZyu0tCq24Nu/OgAUFYBk6pY/pCbdlBePQMLS7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BMDONyEb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ZgltAmdS; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742996372; x=1774532372;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QgXqnnA6VsRUt4KCM6QQ+qD4q2/LnR/B2NSBgRvIk3U=;
  b=BMDONyEbyuiCwTBJIfmP/hDRGh+vbgWRtNZ+mnOTGCiwBZlS3lp4wFy7
   0kg2EU4MsVVTFZSEV3ZOhgYv79sPqFv9ae0HCrAAP9lzw67r/WJsZuJh4
   Pc4MSVhMZ2NxBpAmP7R7yYkgW7TKyGgHwSHvM7kN3ULh5QuJ6X2aIxqP3
   NLR4EU+awWe7u/IOKWrCEbIvPszHFYghj0VNLD6/08KQ7ydn/QKg1dtOX
   ojXZl+NBAPDPRDCWOVnOEAlm1S1DQTGzfPjohI0g36cyN0ERV0BXTOIWi
   GqRyqxhnzOrW0ur0vGXcaJ2oKGT161qWH1BdiLC2LdKexzkKkQ1jpt/Rh
   Q==;
X-CSE-ConnectionGUID: ftUAq3ggRJiMmAzunBXUpA==
X-CSE-MsgGUID: kM9ylVpMTCeGMVWpfKynUg==
X-IronPort-AV: E=Sophos;i="6.14,278,1736784000"; 
   d="scan'208";a="63618752"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2025 21:39:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6Zan8P/Zuiu4YO1VnSV1M8uZdJgbT4+ubVdRGRmQM5siFUL69RQoXK0jWItPAcmgQ+zG2Uv30RB38ohS1aLmpXUFB2CvqSOG1HOGRDftWOGNevsoABvoCvthEqZTv6Fu2m9viRE7lMkTRbAcOcBMMpTUHTU58RUss4FTd+8B5IKTv1DncZQN5dwEsfR8dLSgNlSYnmNaFlbve3vIs0TCz/3i3RktDCuoYY766hDtlRxL5mgeo0VyZatmV34lpz5UmpJgDP1TWdI04mkpocSjwcMy2LsT/+QFgLZj5DyJ82YeOXGtPXGrxdD6/IVy6bjJtOQrA5lL8YC5404vOUuEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgXqnnA6VsRUt4KCM6QQ+qD4q2/LnR/B2NSBgRvIk3U=;
 b=oN6nHfJox9rFvtwSCv3U+ROd+iJoO2s5bmBG2F0DosNrSa9jgkIASmtbTpntgY+GMnhqIVnkzIWZs0yC/BupQzUJJ1AtYDN5CXstK1AnUsnx07wE5OVWJPDIonUjWJzPG4jPr5Lsk3xo1qACFytvPnNdK06xUIEt7O0kxsxxQOIa6vdNLy9SL+XS/xlHYq8kFJAVZBov9DSQSIc6WZApo6LDE+N71uGV6MIFTj+w77VjwQeCQjUxrM4ROoeXE07cxY4IJK7dyJcjjSoXfMINS0tVptwxck4FGYXBHM605XeoXHoaqNdYKW+CJaTmxzLKwRhkPbCOd6+K10a4gJyq/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgXqnnA6VsRUt4KCM6QQ+qD4q2/LnR/B2NSBgRvIk3U=;
 b=ZgltAmdSApyxFF4Ll4UbMGpHRq2VypnyDLizTNg2zSI2oRto7GX4rQT4MU4PFN7F3j788qYNeP4iJxQ54FFdhF0kOJpRbPPxfZ532xli62z+ZxCI7AlivWtvsg3B27ESqGAYeDW/MBybWQHh3P+FpVN0FeIrmR1EZgb6XAoucQw=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7405.namprd04.prod.outlook.com (2603:10b6:a03:295::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 13:39:27 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%5]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 13:39:27 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>, Zorro Lang <zlang@redhat.com>, Anand
 Jain <anand.jain@oracle.com>, Filipe Manana <fdmanana@suse.com>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v4] fstests: btrfs: zoned: verify RAID conversion with
 write pointer mismatch
Thread-Topic: [PATCH v4] fstests: btrfs: zoned: verify RAID conversion with
 write pointer mismatch
Thread-Index: AQHbmL93xtfCvkkqBUqHXGqVbFrb+LOFdxUA
Date: Wed, 26 Mar 2025 13:39:26 +0000
Message-ID: <D8Q8M54FIFKG.34J9M1WWISFNR@wdc.com>
References:
 <8390a7748c1e2005fb7b9dbc1f5e6bd38ea22506.1742382386.git.jth@kernel.org>
In-Reply-To:
 <8390a7748c1e2005fb7b9dbc1f5e6bd38ea22506.1742382386.git.jth@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ0PR04MB7405:EE_
x-ms-office365-filtering-correlation-id: dae9586e-c4a1-4e04-ea36-08dd6c6ba0b7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eldnYkYzakxXNnEvcWcrWWFjY3hVblczc2QrK2hWMGUyVHNLR0FFSUxDM0Zk?=
 =?utf-8?B?S2FJa1NQbm40d2NvQitaU1Rjd1VLNEFqYWdadmhUbTJNSTNUVkl0ajhuaVBq?=
 =?utf-8?B?N0ZWMGNrNUpaU2NFOUxqVHFnaU5nYUFkcldsSm4vQmgwcXFEOGlQS3hkVUM3?=
 =?utf-8?B?eE1wZDdDQWRyNlVwa29nMW5vaWhRaXZSS2RGTWRVdXdzWmM3c0dON1ZoUHdW?=
 =?utf-8?B?SGVkUHhPajdVMGpWd0NGL0lxUkFDM053ZUlXcXZldUdUQ3VKbnlCSjRCazY5?=
 =?utf-8?B?NUxIN0xjTEs3a1lBdmNjYTNYMEtRVTV6SVN2UGZtR2pFai9Fc0ZtTHBJckFG?=
 =?utf-8?B?SmxwejVBOUlTNWtxbHFqeTlBdEZtbzI0bFp2dUxpK3kyY2lITXVmeDRGNkZa?=
 =?utf-8?B?R0pqRFVlMlhNRFlCdUhtT25lR0s2c05lWVhXZWRSbTAzb3cySERvbXhOS0lq?=
 =?utf-8?B?Q1hWd0pESWpWWllRc2Z4WS9mTUkrUXZiMHhENmk2WXlOQ2ttbjRsbk5aNTBn?=
 =?utf-8?B?aXJjdnI2clpsSk82ckIxNWo3LzFlVktQSndvZGhrOE9JZGRRZ2NJaDVNL1Iv?=
 =?utf-8?B?M0FEREw1R2FXS1NRVmVzV01lL085czJveWYzM0VxdmNkbzNCUzF0bGduS2ht?=
 =?utf-8?B?VEZLd2gxZm1sZUcxVGpYSTdDanM4UHlhcjNwMjg0ODBuZlFmR3pIVlIxalNJ?=
 =?utf-8?B?MUYzUVc1VmZaeUVzd2dSeVkyUS82Y3huSjE4Z2FBbi9KcXZwVWNVS1Zvb3B0?=
 =?utf-8?B?Nml0Zk9RVmREcnJ1YTMzYWFPWWY2MDloQWNheVUrbU9ScERpaTM1WTd6WnEz?=
 =?utf-8?B?RytEdWR6SGlIanFZMy80RkxWV0RVa2ZpVWgzNFovY29yanNacFFDY2I0Tkh1?=
 =?utf-8?B?cE9nSkFxeSt1U2duUGpvOW5HNDBpQTVqM2FyejJzR3Zqb3lrNlNJWENIWGpF?=
 =?utf-8?B?Wml1WkZCZ3k3cXFIdEZrbHk1R1ZSSnpJbUIydWVpZjRIZTNySG1hYTBIZStM?=
 =?utf-8?B?dE5vTGF3bVB5SFA3bVUrSkM1MGVJNEtYTGV3OVRCUFlYK01Ta0xCTmQ1dzVL?=
 =?utf-8?B?ZnBMR05vdmJKZ3Z5SS8yc0U3WFpieXpLWGVVbXdZU2MrbnBaU0Q3TmlOM3hU?=
 =?utf-8?B?SmJOZDZabDVRUUNxanFvbGlwME1JZVhtMFcwNExLdnluOHJmV2ZWZzJIK3Jh?=
 =?utf-8?B?cWtZSnAxTWhnRzRsam5NekQzbDVaZ0M2d0JRSm5KbnZ2Ky9ZSUNnSXVIVjFu?=
 =?utf-8?B?UnRvVitrVnRrS3V3Z3RDN2pzM3k0UDZkRUR6cDNEcmc1UU9ITzFWWC9BREVI?=
 =?utf-8?B?Rm5HR0lXUldieE9ic3ZuTWY0UFo5UXFSZFdNY2pVNVdBdTFhY1VTVVlrZUhM?=
 =?utf-8?B?NnRrTWZBdEJXckhWb1Y4WEROdWtQQlJHZzBIMUNuRk9LdHhoOVNSUzlSUlll?=
 =?utf-8?B?Uzh1Z2VqQnF6RmNqN2hsQy9WeTlKNUtUelFiOEhrQmZzUDMzWXR6KzE3aFRC?=
 =?utf-8?B?ZGFiNjF2N05pekJTR3F6NWZzVHlXbWs5VHdmSWxpOGNLV2piTnVaN3FXMmRX?=
 =?utf-8?B?R0xYSHFpOE5DTzJXTHJ5U2pVU3JYR0ltL000bzFTR3BBK1dRZ3lodzlkSW1R?=
 =?utf-8?B?cEZGQmxOT2dqNldSUjVWalBUU3hTQ0dLcGZWaTdrbC90S1U1Wk9EMDBMS3VU?=
 =?utf-8?B?NVAzb1p4S0V6dTBWZTB5NnM5eFB3OXZqL3N2YVltR2pIZnJpdHdaOHgxcitI?=
 =?utf-8?B?Z2I0UThLTjhNeGczazNZNE54c25sdUl1bXM3TlJYc1d3NWJyQTNsbmEyalo4?=
 =?utf-8?B?VFlENTcxbGI5R0FNSmZqVURkY1dpQnBRV1VCcjVHNnQ1dmNvZ1NDa1pUckFX?=
 =?utf-8?B?WHJhbTdCWEdac1BRYWIxazdoUlYvUi9lQlVjalhpb2tKQzM1NmQ3VFZEVVRj?=
 =?utf-8?Q?JEviTrqY83aKWVHZj6I9pLGAbctCwlhY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VEcrSDZjQTh5bnBwMXlpQTBGVExxcFNtcnZZSWJzbWdDcll0SFBkdWZlTWZS?=
 =?utf-8?B?U2hxUnRZRUJMbGlieHNYbWtwdENrcFB1ZmF3SlZpalo1YVNYQ3lnY1lHTmdE?=
 =?utf-8?B?bVpOajRGNmNnQmk1Qk85ZHRKU0VsMXF4aWZ1OU5KUHJ0VXpkT1VoWlF4aElz?=
 =?utf-8?B?aGozS0g0U2EwTWtCcWZvSG9QYXArVUVrcVN6RVl5QVJmSC8wN1J4NVNVWjFG?=
 =?utf-8?B?T3RKKy96OGFEay9aTFlES1Z2SFlWdE50V0VDR1ROdnY1UHVzQm9TbmtMWlN4?=
 =?utf-8?B?SzIybTcxUjVPZnNOSlRlWktGbGxUdzJ3S3BrT1lGWlpheHphQWlCTTZSZlVC?=
 =?utf-8?B?NWlKWUU0ZGFIejhRVkwrM2dNdVd4R1ZhRnk5aTIwSk11Yy9Ia2thWXQ0ZnJz?=
 =?utf-8?B?ZTIrRytaQWU5aUlsMGdseWU1OEVJTkt3UmxvbVlocHpyVXBmN3NRUUVQM1Jv?=
 =?utf-8?B?L0JTenRtSUpNTVZ5cDJtd3dwNiszUjFVZEhsd1BaQVBYVjc3Unp0bGc5eWpY?=
 =?utf-8?B?YmZxVVJkVE5peXgvUncvNGVZelEyeGU3ZkdnenJuTCtoQVM4dzhxeUwzeU1P?=
 =?utf-8?B?Mk5VTDFtS2xJY1VkbHBaSXhrakVJSzN6N0VtRTB6WjQ5REJwQVltZ3l0MHZC?=
 =?utf-8?B?cnMrMWZOWS9haE04dWxlOE5FK0Y0Q1IwOTlhTG1uUi9VUkZGb1M3TnBlYXMv?=
 =?utf-8?B?OGZlR2J3MFhCSVRxNXlVMGdMVUJDVkhvbzBubjZXWVJqampyS3F1c3JhMDB4?=
 =?utf-8?B?WDhtcUViZUpUK0R0T01SVitkUjRMQzQ3M0wxa3J6SnB2MnZEY0Z0MmJzN1gy?=
 =?utf-8?B?VDRMRS9Vek1GOUNnMGhjWU93NmlvdVp6N29tR2lqMW9EUWhYY3pTb0hIWE1x?=
 =?utf-8?B?b0NkRWlsdmJKM1FkSWt4OGREanhQZCt6L09YZmRWWDluWE9PVlpydkM1amYv?=
 =?utf-8?B?YXhYSGptRWhaRm5TTE1KQ0svVU84eWFKYWJBNysxVWpKV05NYUs1aklpVjRn?=
 =?utf-8?B?dHdoRm52NHpNdDJHczFGdll2NUxySGhDeWtWc2MrV1IwaURmSTBQWmJGZUFC?=
 =?utf-8?B?UmRpVDRGZTNlaW1EZmE0V3VqbFJ0bHBCTUhES1VDUDFMUXJUQ3BsMVVrUmll?=
 =?utf-8?B?VDhLQ1dSa1ZZSnZ1bjZRRkZTZm1CUWJLeUFkOVVkL3BPQkVDU1Y4Kzgrekwr?=
 =?utf-8?B?QURIaE0wMEg4NnJrK2IzejZZOFBKeUJ5cG9aY29kakJJSytvTUQ1Tzc1ZGR4?=
 =?utf-8?B?dDBlR2lsUDR0cjRhSlp3UmtCUHpobVdZSXlsZmpHWlp6YVY4c01yem9KS0tY?=
 =?utf-8?B?VVBVWk1DUmFPUVpiYklyOEtQS00wL3BreXdXYjl2eGZaaWFSSHNCVHJvaEZS?=
 =?utf-8?B?bWlja21nMkFCVlRlajRuYUlySFJtWVI2K0duZDMyNU9KSDNDSGE5TWMweUU5?=
 =?utf-8?B?Z3AxdzZvWUcxUFArbmpsbkZzNStJeWFZaW1iTzdCVE5EMTRuZWorc3lPUTFT?=
 =?utf-8?B?NTVOSHNCNXFVa2s2bDhSV3FqVVpqd2xKNVVndHZCMlBuT1RhYjBRajR6NENB?=
 =?utf-8?B?aWM4UWZlZzFZaDdzWmovcGtaVmt4dE9kN3pKT3ZYc0huUk5ya2lpTGlvZW9h?=
 =?utf-8?B?RldZYnhkQU9zM0FQdTdudTBjVGllQm9NRGNucU5IQWx5YTB4NUczaWNzb3Rk?=
 =?utf-8?B?QzhBa1FvNC81aks4SjJ6OUZqeVBtZVdkZ0d1Z1lnQWhTMWxoT3FaYW40b1Vy?=
 =?utf-8?B?UHUyNkcvOUVZK0h3V0x4T2N3WkswbFN1bm1JR28xdWxTQ0RORk9ITDJsOFl1?=
 =?utf-8?B?TzlnUkhoenBSQmxLR3pSOUgyQ2tHRUl0K1hCdFNwUUU5QnNZd2h2bXpmdUpX?=
 =?utf-8?B?OVNRRWU1OERXVEdURGFaM3ZGai9vYTBwUHpPd0R5cmpwVmo0WjZFeUFCZDlT?=
 =?utf-8?B?a0F4Ni91cHBvSEQyTHd0TGx2VUpCQzVET285aXp2VEJ2TzNNL3JXMVhFd2No?=
 =?utf-8?B?RUd1N0xjZHRCSW52VnJqeFdTRFV5djJZenNFNGNreElELzZxVk11QmZEYmhF?=
 =?utf-8?B?ajdtbk9TRnROd2Z0Mno2bElDK1R2RjArbHlJaVErSFo4VkdwOFJlTklBSUVR?=
 =?utf-8?Q?vzmg5WOZUz44bh4Wro+UPDYZT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75DC64BD93AD7240B0518746CFB5DA43@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A0+jxiAKUGS1MopOb+Le46bw11l45rxyM9zB0OuRAnQjuc8/mR/D2KL7FXi6CSvcIKcIEEjv1gY9FlW37j5ZdbrBhx4pa5tr92UeCH3yvcwrRPLhbKTlWOoxAEvDptU3YhVNr6lp6zWR8X8Fn683Q9fmpdBlBiiN8HtsDo64huS/MWeuAo3+VhC+6k5v7Kl2z49wAZ2/BoIJ2WElmnytAgd3odfm9Gpgcs0CT+Sx/MEEnBWAT5miw3jQQ7/qQFk0A9HW4s27U/T0sdNHM+iDDF96dHCBFYZ45L2ISidxoU3H4YhotLcjqQGyPyoYbDoYV0orZ0Yj01Rh9HkpLVp76aw5VFbupsfC7qEco7/7OP/I/HpNQv5JLuZMI5zU57G1QqNet5KvF1EjXlbgGUhIjmxfz01v6asZclYfOSER9arIZOqTDWOEdBF6LVkcpY55oj9awTQ4ur8aapowivzU1V1jtr/VAO6fMoUhZn7btEn2UVVfmOOrhkYFH84nP8KqcD/9xETPOIh1Q3J9zhq9/HeQZnqihrN/UGQV2gp+8U1v4tmO8kkFFLjLvTdxpDo/U41HXo4svisvnJauxFEBbxYvAUKzXLY7PTEuj+yN6gA29YMwBMeQrdCRDFFFZbSQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae9586e-c4a1-4e04-ea36-08dd6c6ba0b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 13:39:26.9724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eYDjFfDJ5jNJuDreIAyZ8e2Ctz8dU19O8nJvg+f0wvZbwzDZu1Cm/kpegz6QQHmOjvG4R67Y7Nes1LfkXSALig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7405

T24gV2VkIE1hciAxOSwgMjAyNSBhdCA3OjA5IEFNIEVEVCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdy
b3RlOg0KPiBGcm9tOiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMu
Y29tPg0KPg0KPiBSZWNlbnRseSB3ZSBoYWQgYSBidWcgcmVwb3J0IGFib3V0IGEga2VybmVsIGNy
YXNoIHRoYXQgaGFwcGVuZWQgd2hlbiB0aGUNCj4gdXNlciB3YXMgY29udmVydGluZyBhIGZpbGVz
eXN0ZW0gdG8gdXNlIFJBSUQxIGZvciBtZXRhZGF0YSwgYnV0IGZvciBzb21lDQo+IHJlYXNvbiB0
aGUgZGV2aWNlJ3Mgd3JpdGUgcG9pbnRlcnMgZ290IG91dCBvZiBzeW5jLg0KPg0KPiBUZXN0IHRo
aXMgc2NlbmFyaW8gYnkgbWFudWFsbHkgaW5qZWN0aW5nIGRlLXN5bmNocm9uaXplZCB3cml0ZSBw
b2ludGVyDQo+IHBvc2l0aW9ucyBhbmQgdGhlbiBydW5uaW5nIGNvbnZlcnNpb24gdG8gYSBtZXRh
ZGF0YSBSQUlEMSBmaWxlc3lzdGVtLg0KPg0KPiBJbiB0aGUgdGVzdGNhc2UgYWxzbyByZXBhaXIg
dGhlIGJyb2tlbiBmaWxlc3lzdGVtIGFuZCBjaGVjayBpZiBib3RoIHN5c3RlbQ0KPiBhbmQgbWV0
YWRhdGEgYmxvY2sgZ3JvdXBzIGFyZSBiYWNrIHRvIHRoZSBkZWZhdWx0ICdEVVAnIHByb2ZpbGUN
Cj4gYWZ0ZXJ3YXJkcy4NCj4NCj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
YnRyZnMvQ0FCX2I0c0JoRGUzdHNjej1kdVZ5aGM5aE5FK2d1PUI4Q3JnTE8xNTJ1TXlhblI4QkVB
QG1haWwuZ21haWwuY29tLw0KPiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpv
aGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPiBSZXZpZXdlZC1ieTogRmlsaXBlIE1hbmFuYSA8
ZmRtYW5hbmFAc3VzZS5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIHRvIHYzOg0KPiAtIExpbWl0IG51
bWJlciBvZiBkaXJ0aWVkIHpvbmVzIHRvIDY0DQo+IENoYW5nZXMgdG8gdjI6DQo+IC0gRmlsdGVy
IFNDUkFUQ0hfTU5UIGluIGdvbGRlbiBvdXRwdXQNCj4gQ2hhbmdlcyB0byB2MToNCj4gLSBBZGQg
dGVzdCBkZXNjcmlwdGlvbg0KPiAtIERvbid0IHJlZGlyZWN0IHN0ZGVyciB0byAkc2VxcmVzLmZ1
bGwNCj4gLSBVc2UgeGZzX2lvIGluc3RlYWQgb2YgZGQNCj4gLSBVc2UgJFNDUkFUQ0hfTU5UIGlu
c3RlYWQgb2YgaGFyZGNvZGVkIG1vdW50IHBhdGgNCj4gLSBDaGVjayB0aGF0IDFzdCBiYWxhbmNl
IGNvbW1hbmQgYWN0dWFsbHkgZmFpbHMgYXMgaXQncyBzdXBwb3NlZCB0bw0KPiAtLS0NCj4gIHRl
c3RzL2J0cmZzLzMyOSAgICAgfCA2OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gIHRlc3RzL2J0cmZzLzMyOS5vdXQgfCAgNyArKysrKw0KPiAgMiBmaWxl
cyBjaGFuZ2VkLCA3NSBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdHMv
YnRyZnMvMzI5DQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvYnRyZnMvMzI5Lm91dA0KPg0K
PiBkaWZmIC0tZ2l0IGEvdGVzdHMvYnRyZnMvMzI5IGIvdGVzdHMvYnRyZnMvMzI5DQo+IG5ldyBm
aWxlIG1vZGUgMTAwNzU1DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uMjRkMzQ4NTJkYjFmDQo+IC0t
LSAvZGV2L251bGwNCj4gKysrIGIvdGVzdHMvYnRyZnMvMzI5DQo+IEBAIC0wLDAgKzEsNjggQEAN
Cj4gKyMhIC9iaW4vYmFzaA0KPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0K
PiArIyBDb3B5cmlnaHQgKGMpIDIwMjUgV2VzdGVybiBEaWdpdGFsIENvcnBvcmF0aW9uLiAgQWxs
IFJpZ2h0cyBSZXNlcnZlZC4NCj4gKyMNCj4gKyMgRlMgUUEgVGVzdCAzMjkNCj4gKyMNCj4gKyMg
UmVncmVzc2lvbiB0ZXN0IGZvciBhIGtlcm5lbCBjcmFzaCB3aGVuIGNvbnZlcnRpbmcgYSB6b25l
ZCBCVFJGUyBmcm9tDQo+ICsjIG1ldGFkYXRhIERVUCB0byBSQUlEMSBhbmQgb25lIG9mIHRoZSBk
ZXZpY2VzIGhhcyBhIG5vbiAwIHdyaXRlIHBvaW50ZXINCj4gKyMgcG9zaXRpb24gaW4gdGhlIHRh
cmdldCB6b25lLg0KPiArIw0KPiArLiAuL2NvbW1vbi9wcmVhbWJsZQ0KPiArX2JlZ2luX2ZzdGVz
dCB6b25lIHF1aWNrIHZvbHVtZQ0KPiArDQo+ICsuIC4vY29tbW9uL2ZpbHRlcg0KPiArDQo+ICtf
Zml4ZWRfYnlfa2VybmVsX2NvbW1pdCBYWFhYWFhYWFhYWFggXA0KPiArCSJidHJmczogem9uZWQ6
IHJldHVybiBFSU8gb24gUkFJRDEgYmxvY2sgZ3JvdXAgd3JpdGUgcG9pbnRlciBtaXNtYXRjaCIN
Cj4gKw0KPiArX3JlcXVpcmVfc2NyYXRjaF9kZXZfcG9vbCAyDQo+ICtkZWNsYXJlIC1hIGRldnM9
IiggJFNDUkFUQ0hfREVWX1BPT0wgKSINCj4gK19yZXF1aXJlX3pvbmVkX2RldmljZSAke2RldnNb
MF19DQo+ICtfcmVxdWlyZV96b25lZF9kZXZpY2UgJHtkZXZzWzFdfQ0KPiArX3JlcXVpcmVfY29t
bWFuZCAiJEJMS1pPTkVfUFJPRyIgYmxrem9uZQ0KPiArDQo+ICtfc2NyYXRjaF9ta2ZzID4+ICRz
ZXFyZXMuZnVsbCAyPiYxIHx8IF9mYWlsICJta2ZzIGZhaWxlZCINCj4gK19zY3JhdGNoX21vdW50
DQo+ICsNCj4gKyMgV3JpdGUgc29tZSBkYXRhIHRvIHRoZSBGUyB0byBkaXJ0eSBpdA0KPiArJFhG
U19JT19QUk9HIC1mYyAicHdyaXRlIDAgMTI4TSIgJFNDUkFUQ0hfTU5UL3Rlc3QgfCBfZmlsdGVy
X3hmc19pbw0KPiArDQo+ICsjIEFkZCBkZXZpY2UgdHdvIHRvIHRoZSBGUw0KPiArJEJUUkZTX1VU
SUxfUFJPRyBkZXZpY2UgYWRkICR7ZGV2c1sxXX0gJFNDUkFUQ0hfTU5UID4+ICRzZXFyZXMuZnVs
bA0KPiArDQo+ICsjIE1vdmUgd3JpdGUgcG9pbnRlcnMgb2YgYWxsIGVtcHR5IHpvbmVzIGJ5IDRr
IHRvIHNpbXVsYXRlIHdyaXRlIHBvaW50ZXINCj4gKyMgbWlzbWF0Y2guDQo+ICsNCj4gK256b25l
cz0kKCRCTEtaT05FX1BST0cgcmVwb3J0ICR7ZGV2c1sxXX0gfCB3YyAtbCkNCj4gK2lmIFsgJG56
b25lcyAtZ3QgNjQgXTsgdGhlbg0KPiArCW56b25lcz02NA0KPiArZmkNCg0KTml0OiBXZSBjYW4g
anVzdCBkbyAibnpvbmVzPTY0IiBhcyAiaGVhZCIganVzdCBwYXNzIHRocm91Z2ggYWxsIHRoZSBs
aW5lIGlmIHRoZQ0KbnVtYmVyIG9mIHpvbmUgaXMgbGVzcyB0aGF0Lg0KDQpPdGhlciB0aGFuIHRo
YXQgbml0Og0KDQpSZXZpZXdlZC1ieTogTmFvaGlybyBBb3RhIDxuYW9oaXJvLmFvdGFAd2RjLmNv
bT4NCg0KPiArDQo+ICt6b25lcz0kKCRCTEtaT05FX1BST0cgcmVwb3J0ICR7ZGV2c1sxXX0gfCAk
QVdLX1BST0cgJy9lbS8geyBwcmludCAkMiB9JyB8XA0KPiArCXNlZCAncy8sLy8nIHwgaGVhZCAt
biAkbnpvbmVzKQ0KPiArZm9yIHpvbmUgaW4gJHpvbmVzOw0KPiArZG8NCj4gKwkjIFdlIGhhdmUg
dG8gaWdub3JlIHRoZSBvdXRwdXQgaGVyZSwgYXMgYSkgd2UgZG9uJ3Qga25vdyB0aGUgbnVtYmVy
IG9mDQo+ICsJIyB6b25lcyB0aGF0IGhhdmUgZGlydGllZCBhbmQgYikgaWYgd2UgcnVuIG92ZXIg
dGhlIG1heGltYWwgbnVtYmVyIG9mDQo+ICsJIyBhY3RpdmUgem9uZXMsIHhmc19pbyB3aWxsIG91
dHB1dCBlcnJvcnMsIGJvdGggd2UgZG9uJ3QgY2FyZS4NCj4gKwkkWEZTX0lPX1BST0cgLWZkYyAi
cHdyaXRlICQoKCR6b25lIDw8IDkpKSA0MDk2IiAke2RldnNbMV19ID4gL2Rldi9udWxsIDI+JjEN
Cj4gK2RvbmUNCj4gKw0KPiArIyBleHBlY3RlZCB0byBmYWlsDQo+ICskQlRSRlNfVVRJTF9QUk9H
IGJhbGFuY2Ugc3RhcnQgLW1jb252ZXJ0PXJhaWQxICRTQ1JBVENIX01OVCAyPiYxIHxcDQo+ICsJ
X2ZpbHRlcl9zY3JhdGNoDQo+ICsNCj4gK19zY3JhdGNoX3VubW91bnQNCj4gKw0KPiArJE1PVU5U
X1BST0cgLXQgYnRyZnMgLW9kZWdyYWRlZCAke2RldnNbMF19ICRTQ1JBVENIX01OVA0KPiArDQo+
ICskQlRSRlNfVVRJTF9QUk9HIGRldmljZSByZW1vdmUgLS1mb3JjZSBtaXNzaW5nICRTQ1JBVENI
X01OVCA+PiAkc2VxcmVzLmZ1bGwNCj4gKyRCVFJGU19VVElMX1BST0cgYmFsYW5jZSBzdGFydCAt
LWZ1bGwtYmFsYW5jZSAkU0NSQVRDSF9NTlQgPj4gJHNlcXJlcy5mdWxsDQo+ICsNCj4gKyMgQ2hl
Y2sgdGhhdCBib3RoIFN5c3RlbSBhbmQgTWV0YWRhdGEgYXJlIGJhY2sgdG8gdGhlIERVUCBwcm9m
aWxlDQo+ICskQlRSRlNfVVRJTF9QUk9HIGZpbGVzeXN0ZW0gZGYgJFNDUkFUQ0hfTU5UIHxcDQo+
ICsJZ3JlcCAtbyAtZSAiU3lzdGVtLCBEVVAiIC1lICJNZXRhZGF0YSwgRFVQIg0KPiArDQo+ICtz
dGF0dXM9MA0KPiArZXhpdA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvYnRyZnMvMzI5Lm91dCBiL3Rl
c3RzL2J0cmZzLzMyOS5vdXQNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAw
MDAwMDAwLi5lNDdhMmE2ZmYwNGINCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi90ZXN0cy9idHJm
cy8zMjkub3V0DQo+IEBAIC0wLDAgKzEsNyBAQA0KPiArUUEgb3V0cHV0IGNyZWF0ZWQgYnkgMzI5
DQo+ICt3cm90ZSAxMzQyMTc3MjgvMTM0MjE3NzI4IGJ5dGVzIGF0IG9mZnNldCAwDQo+ICtYWFgg
Qnl0ZXMsIFggb3BzOyBYWDpYWDpYWC5YIChYWFggWVlZL3NlYyBhbmQgWFhYIG9wcy9zZWMpDQo+
ICtFUlJPUjogZXJyb3IgZHVyaW5nIGJhbGFuY2luZyAnU0NSQVRDSF9NTlQnOiBJbnB1dC9vdXRw
dXQgZXJyb3INCj4gK1RoZXJlIG1heSBiZSBtb3JlIGluZm8gaW4gc3lzbG9nIC0gdHJ5IGRtZXNn
IHwgdGFpbA0KPiArU3lzdGVtLCBEVVANCj4gK01ldGFkYXRhLCBEVVANCg==

