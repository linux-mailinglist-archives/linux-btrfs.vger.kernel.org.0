Return-Path: <linux-btrfs+bounces-6056-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5D791D8D1
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 09:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAD41C213DE
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 07:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA626F076;
	Mon,  1 Jul 2024 07:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mhd4Bj6s";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aPkMvP6y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0BE1B809
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 07:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818331; cv=fail; b=nksTJcnfFqLmj7qrWxd0SDhoukB+oakcvLUxiN3n2c9wQ7w7f+p9EMbRSEZay/DI3EDXH+V4eBRNMEzrkifssXfSb0pEi5r2zGHlzL+M8pFpOPaF8OfzjsqNJZSY2/6gOdJ0RRelyLR3z/SaGVNM4QPgqOVgWPIKRGh7/OgxBcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818331; c=relaxed/simple;
	bh=cSOjX6WzE5Ru3EJsr27EexEQaH3YERC09egw61NRYAk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rQkA1eL9qsGHgopfdMrV9XoToOKyxem/r5Tkakx+On3fTqTQPWEC06QDGOMAePFs6dFD3p5gwawF52XNbLUYQewILCwvfaH5Fu2l3vyggLwUHZYDK14QjMV5YOnZrfn3auKBQgV4d6dFbl0xHyQP2IUC6PPO5WpNmizB3UhWvg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mhd4Bj6s; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=aPkMvP6y; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719818329; x=1751354329;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cSOjX6WzE5Ru3EJsr27EexEQaH3YERC09egw61NRYAk=;
  b=mhd4Bj6sSN6/HDC8MIDMZYSgyhpsxVor9f8rix9i4UKJZQU4WpQ0GSeb
   fLvN/nMkkp2NPF3xIfC7O/8304T9AAsORRUNyUHin2p/feHPLYyp6KF+L
   rIuw+qMJ8zd2lSZxf7K6ZdX4ENxEW8f/rf9RdBIpAgU+jDZCwbRDrl2YT
   a95rdfyjURpI20k9+VhoV8113uJwh/JDqe3a1AtseIOn96orXXU8E/SUn
   aYu5vtl3QmYHAq9lDodp+Oa5kxsQEapDAONvq3RTQvot2IGWfdK1MMFeW
   IQMg3R9gggUQ2KOzF+hqT+/+I/E2/jDoCQhgMxu0FStG1ynLC6dqNFv/y
   A==;
X-CSE-ConnectionGUID: JlG/96H1QbaHT48ntbsieQ==
X-CSE-MsgGUID: n/E/5CnIQgmy/3M+ZxdsOA==
X-IronPort-AV: E=Sophos;i="6.09,175,1716220800"; 
   d="scan'208";a="20470567"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2024 15:17:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cohQkQrtiunvNwfRCB919tbfflwl19FS1Yur0Jd/DISZ7cSPJ42Z4IG2tQoaVzjDRcUEgnhi89uWdYpzpnCoACbfU1KSx13p4pb+mCHvl5RhFDho2Np+avl/cUM6vTlT5UaNlcGz3m4ZtwymnKU1y43E1ABFM9y8K4BDBUknc1o5SzFFaEL8Kb4ZQIVSlY+DVM3QAn1u2DQ4lSXsmiOoGx6OX/K6FGsF+0VAboI9WslFB+B72aCIuWt/4ve9nGHLweKmBk/A97PhuUX9HiR4Aj22A+MTmT5/BuAOCOQlDiAjcbuBKw9IDkxYfakpRtV/Fn8vugQkn76dUn5LiW5hkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSOjX6WzE5Ru3EJsr27EexEQaH3YERC09egw61NRYAk=;
 b=NVFgN378N7r/7mgxRumBEiBXDtlrqZ3m/HWl7Unw2LwuAghWg9YkVit7oAp0rPMKuS6fN6jw3mqCRMhrkNDE0XJj8dH0fAiPDODCSL7Dgun3uRlWFVSJ+4Dqu3f6SioO2rLepE7bJoX+1Ghm+0skvLywlP/66gJuxRiSosmYpgAdSJ9bbqPu0zQ7eVoLvI0d9y9eHfKsG8IppleufOlIELC+AS9zQO1q0hxV2sDqIL5lf7n9lwlzjVLpwvdeBrXeV43JLJXvqqIJ7/6SkXQYSqe6A6jQohASQVlPIi9W4iTyk+YLWGyk+OKzthlj6ruM8w0147LUePzpjS4TR6Xfbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSOjX6WzE5Ru3EJsr27EexEQaH3YERC09egw61NRYAk=;
 b=aPkMvP6yn3CJbbZjYe/5JgnphPgeq4NWmwT4gp6xdw5JQVDDeHfgp1WWEa3ZhEgjCwrkV4GPyo1GSA9UgqWCAXVhXGEbsjczl4Q1rXk1YSnGJyJNM4M+nP+9eBpXeCqA5LTZLaOdJBkbFyweT/t0Bq3PNKwzfZGO1jinmfhvKAA=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CO6PR04MB8331.namprd04.prod.outlook.com (2603:10b6:303:136::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 07:17:38 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 07:17:38 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Shinichiro
 Kawasaki <shinichiro.kawasaki@wdc.com>, Johannes Thumshirn
	<Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: avoid possible parallel list adding
Thread-Topic: [PATCH] btrfs: avoid possible parallel list adding
Thread-Index: AQHayRZ66O6rWExFRUmxidXXuvxvtrHc8s8AgASIhIA=
Date: Mon, 1 Jul 2024 07:17:38 +0000
Message-ID: <vc3fl42xufzk5jkqaa2so62wddib3x24oktlu5mhryo6uif4ru@wnax7hbe37vr>
References:
 <58e8574ccd70645c613e6bc7d328e34c2f52421a.1719549099.git.naohiro.aota@wdc.com>
 <CAL3q7H5dDjoB-otDKHX0XGZXCXS+r4LhMxsiP5ZNGqnAi7Df0g@mail.gmail.com>
In-Reply-To:
 <CAL3q7H5dDjoB-otDKHX0XGZXCXS+r4LhMxsiP5ZNGqnAi7Df0g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CO6PR04MB8331:EE_
x-ms-office365-filtering-correlation-id: ac7307bb-6fb6-41df-e2eb-08dc999de33c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T0JJaysyMXRaKzBUL3ViRnZlM3NjVHFybjRVNml2UHNlVkNOYUNxTW93R1oz?=
 =?utf-8?B?MTNrYnBZS3p6bHp0ZldoKzIwb0JOT21ZdHdZV1FIZGs2ZmVCVHV0RXZmQWox?=
 =?utf-8?B?RXNKSUQrOEFEYkU3WG5nM003eHJ0R0wrbDdnakZhTFBjN1UzZk1UZVdyakJl?=
 =?utf-8?B?bFRGNHV2WnBGUTN4WWc4Mm5NSFVOMDBrWUtJQTNwRXc3b0lNTzAxeUdEM0FF?=
 =?utf-8?B?RStwNVlZOTlWZ2puUjQzbGEyWjBsVm5TSndHM0pZckxqSDBaNHAvMnJyOU1R?=
 =?utf-8?B?dXkza2FHOXJ5SnhQQm85bmJHeTlGb0lkWHdhKzlaWHlleU16RVJyVXVMVEk2?=
 =?utf-8?B?L1J3K1F2bmJFa0Z5eXpJRXdGWGRHMytvM1Biem1VTmVwYUZXODlmS3lCZ1Vw?=
 =?utf-8?B?enREbUhTM1U5YXRhR09PU3BLeit3R05XcnNydDBqTE44Z0JYN1kxNTV5azRX?=
 =?utf-8?B?ZlpWbFRqcmZZelJPZUpDMlp1YU80aTg2RVcvck14L3huNEdMUTVibXh4UGZH?=
 =?utf-8?B?bytWYkRFbUNOSFBHYk1BRzl3VmxUUm5HdC8zWEl4WWJRUU5aangvZ3NmQ2tJ?=
 =?utf-8?B?a1hZTTk2d2g2blI3OVhiREVWRm1Gc0RwYWdESU52djNoYTVUSWxJa1QzTnJq?=
 =?utf-8?B?T0dlMjQyT1NIN2lmNzVXenlJRks1NElvT1Qza0lBc0R4UlBsNmJ4V3oycUFE?=
 =?utf-8?B?NEJ4RGFXVW01cEhZemNJeklIeFlTMjRnZzJ6VFNTRldjSjFJc0hNWVJQVEhL?=
 =?utf-8?B?WG9uekROWEVNSUp0cGk1c2QwTUZHQ1JpQ1JYUWJLS29wbUlnVmZ5WkVJQlhz?=
 =?utf-8?B?SHE2YitFdGU1bEQraFBQNVhtMnRDUWlSTTVZc1k3VkN0S1pYcHdxYXB1bDJQ?=
 =?utf-8?B?OWhLZzdiQnp5U0pmUk9YOCtVcWp2Tk9TWi9UUVhocXNFQkYyL21LS1JSS1lt?=
 =?utf-8?B?eFZSaHVIeFJpZVlXUFB0NTU5cXo3T3RmenAzQUl5SlA3aWVRdGwrWWEzWk50?=
 =?utf-8?B?ZlVRck9FYjIrUHpRS2E3ZXIzSzd5WHlaNk1rdzMraEpnckUrTkV1YkhOdHZT?=
 =?utf-8?B?UDdmdUdpNnptRzlqeVQrUDBVRlQzUlFISERUQm9lUWEyc2c1STNtcFNPdDFj?=
 =?utf-8?B?WTh3Smp1NmlXWFhNVmFTMFdXTlVqT2RHbTFxc0VjcXYxNmhEOW5VSkJRNldr?=
 =?utf-8?B?WHpKbmgvR00rMTlQczk2OGlEQ1l3UzlGSkt5ZWFoVDdUY3BhYzcrU2V2R1k5?=
 =?utf-8?B?R1hVY1ZlTThkY3M4Yk5nOUNYalp2U0NOeGNrUWVEYVR4SHYwVHk4cFZYLzcy?=
 =?utf-8?B?NEdHZ1VoZVBrWUJ1N0h2OWRENDY1R1VXTnVBcThmVi90emY0Yk5lbnBPMEpZ?=
 =?utf-8?B?ekMwblQwb1BaTE5kS3lxOGoreHFKS0YwZVJ3dExtaVdTTmVMZjVYN0F2amlo?=
 =?utf-8?B?bWp3S2ZyRUg2R3BoOHl4L0doN2ljK0VySkNWaVdGWDJ3TXdRNHdiWDFoSFkv?=
 =?utf-8?B?a1FSMlJ3YnVRdTRadVoyeGd5Um5kWFdGNDVNSEZvZkhLQ2Y3MDg4K3RaMnBw?=
 =?utf-8?B?bGxkUkx5Wjl3VmVHUHYwMlJiWW5raTEwQTQ2dW1iVFVXRXY0anJUbXNhSXRH?=
 =?utf-8?B?NG5GaVNVcEk5TkM4K240RVdOTnNKZ2FxeVJHaFlBbW84R2xWcllLNmY0a2cx?=
 =?utf-8?B?ZW5OZjNCaFVObkJYSEM4OWk4OXZWb2tMV2w1UnVRbHFGZHFnd3V4aDQrNXA4?=
 =?utf-8?B?ZzFPRkJlSXdER3NLMHVZWUVEMExTZ1VnYWs1Ukp2Z1phRVVROGF6YmFMQTI1?=
 =?utf-8?B?M05zd0gyWmR3YURiLzRzL0xwZ08xTTF6SHFnTmlmajNiK0RLVUtuNWs4TnFV?=
 =?utf-8?B?YUV3bjZIQVR5U3daeHpZQWR4UEVSbEduZjNFcEVSS3VEa1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0Y3ZVJBUFlsanVCQ01KQm5sYjFDTWF2ZnN1aG9SMHFMMVg0Z3dHRTJERnBK?=
 =?utf-8?B?dTdZRHowZlJRbWNxbVJSSWNKcHVEWWRSdXltUDJ0NnJTOUlsYUVaNGYvemhV?=
 =?utf-8?B?N2RJWGNoSU44bDRKU01DWjlBWVo2UlpLOGFBQTlCRlJzUElQOFRvK0ZFamxT?=
 =?utf-8?B?MVBwallWWUxxNWk2T3IvNzg2UGhnd212dU9zMm5iRDR4R0xCZmhMcnBxR3o4?=
 =?utf-8?B?NGg5a3Z3Y0xKejFyNlV5M1hYYWhzUkZLT0N2dmZVYTRxUWh3R2ZHT1NzNkNI?=
 =?utf-8?B?ZzNMWlZwaks1dHhzUlNDSHB3QTNNb0RCTFV5YmFEQkZEL24vbXdRSXMybXJ4?=
 =?utf-8?B?L0w4SWhKZmRvS1d6KzBHd2hmaC9TZWhmOXI4dWpKU3JPbDlCR3VVb1ZneXVU?=
 =?utf-8?B?WmJIWGEzaUE4MUZycFFVSi8zLzJSL3ZReWt4UXpvWjhqd1hZTWI1c21yZmRz?=
 =?utf-8?B?anpaZTduWHoxVG5kYXMzUk5GZC9DdEZVSU1McnJPWmZHNWs3ZVhGSDFwTWZw?=
 =?utf-8?B?bDRKTUZFQlVVR1kxUEovenQ2ZG5yYk9QOHFLM3NYMFBHejRRaHdDWDlMT3Qv?=
 =?utf-8?B?TjVFUTk3MkNMNitGZVRMSlBUcFBqRzBoMGtndFpLbkxnL29kMWJsdGVtK3p1?=
 =?utf-8?B?dklaTlRRcUpWTWNHVFZhcFV3VXVTeUVhb2s0V3Q0WjRybjRJcmgwbmlQb2xz?=
 =?utf-8?B?NkJqc0VHRG1yNHZxbkFjTFNqQ0p3elZoc1N5WlFyNmNsVmlBamN5ZkpiV0hl?=
 =?utf-8?B?ME5vcE83TzYyZUlDNUxJMy9nM0ZDeXkyR0JxbkdoZjk4Z05MNzVTbkp2UzFL?=
 =?utf-8?B?d1NpS3BUQmJXUkxzUFpSOHRZNlRXcWExeEJRZmVtZWJKajRUT1lZbjJCRmNn?=
 =?utf-8?B?emxTaW43VUhSb0JUdGdCVEVZQ0FjeEVPWXcxK0lsZ1lwdWJXaEJyakV4bXhD?=
 =?utf-8?B?ZnR5dWRwOGxSenpjeVltSDJla3JqM1VWTnRxaFNnZFpqN1h2dUprUmlyNXJG?=
 =?utf-8?B?YWhnbmNGYmdHNDRBS3dDbktYbjcxK0xia0dWSXVIZEpNdzdBS3FlMldZVUV3?=
 =?utf-8?B?UHR0Y3Jhb29ZYWg0SzFJTG9hQnZrdjNRb3A4Um1pUlp3a0RpckgvY0FUZmJx?=
 =?utf-8?B?K2dVbkdKRGJ2c0VxMnU0NzNYTVhqL2ZvZHBjaEJsVnJsQ2o4U3NjenhJc1pZ?=
 =?utf-8?B?VmhhWVhWcnVJaVRPazBUM1l0RTZEYlFKYkdWUzhCOWhPNWZoV296YlRJSnA0?=
 =?utf-8?B?Uk1mRlcyRndzYjFLRVNVVGNhU0NpMFlDczZpTnR0VHN2ejc5WDRUV3M2M3FE?=
 =?utf-8?B?REpaREthQVJsWldvbnRtbVptNi8yeWRqUzZ2NHBtZmRGMjlGMlhtVWJ1LzRF?=
 =?utf-8?B?S1llTGdYb3Z4SXBTWkhLUjJ6cEt3KzlTMkQrQnZycHZnc3Zrbis5WUJDaTBO?=
 =?utf-8?B?WEJ2LzRKN1lPZnI1L2RaQ0RYVEdibklsWE1SeGIxVjBUTzN6RW13MSsvYnk5?=
 =?utf-8?B?MVZXY0duRlFGRGlCcllxQk5IMkhmWENRQUYrV2x6b3dLNmxGSWE4TytFY3RI?=
 =?utf-8?B?cVd2YjhIRUJ4dWM1VkdXS2YyK2RUSGl1R053V05lWW9YQmdEY2lYLzZsbjAx?=
 =?utf-8?B?cjRRWk53WlczbGtJTVVhOElOYmR2RTZIWGRYTjlrNUpjd1AvRDYyK0wxcmRt?=
 =?utf-8?B?VXVXM3N0ZVc2azM0WWphUXlPdWVvNlhydFFvbXNQMGo4V0RzN2ovemttOTFx?=
 =?utf-8?B?R0JGYlNmbWFFWTJkWllBajJoeGtRQ3dmOVZuZU9DZElId0ZhMi9aOEtOemk1?=
 =?utf-8?B?ZXNVdUtUQVh4ZHJ1aHhYYnliTDhVYVg4TDdEUTcrMFVySUlpMk9GQXg4L1VJ?=
 =?utf-8?B?ekZreVFqb0FtZFQxVlowSTMrN2NzOU9acldkNU93eVBQNVRxWTVaWHhxQlVy?=
 =?utf-8?B?Wk9RUzVKNEthbGdrUFFvKzkrN0J6UnhCNUVybUJiUm1NYVovUm91MitTWnoz?=
 =?utf-8?B?Rm95ejUva0MycHdSaWtscVVxMHVtc2Vyem1KYzVtM2FicjA1Nk80QnJtUzl0?=
 =?utf-8?B?NDJJYThxdk5PcmJ5enZnQ3Y3bG9FbHZmQVF3M1JGVVF2NllsSytEY29MUVB4?=
 =?utf-8?B?ZnR5UmhPZ2xkZlhlNmJmTEo5b2gyekd0QXZBR3Z4RlZZZ3hYSlA2NWlINGN0?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF1108A823C5C24EB831FFF1EBA86B48@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wGFZkSZ+L3XZ0i/Rm7UgtUXsQ0LWa9r7YYdOv9UKIuh6x057+53j18UdzFgbrO1OQfhVzfKztkqmbmwMEOPo+AeQfWK+Jd4okggjKiHFwz/XNhxdTDIcYKkc6Ru1QT+BeLg4AlQ95+Ax3WBMY88Uw/7QDuqE0iP6HxHxoua4e4L50/4SA7JxBeex5xP9OAgQh6feMC2aZoyfCKuA+HR3HfwW3p3CRgB4FxQHvvQqNy1h7aVagZWsKSkXa9nWhqGlbVkNQdfgmAgWAHFKVMGQU80m5l13h8YRzuJR3cUrja7nUPgtoXWZ0pcvOd8afbv4Xvksywg0keThGyqIxUQGTmtVpH/gWeOoYz05eaOLlklB/GKz8Ez7j/Wca7AWrWj3Lv6lvRzNIizOLqbOEloeBiYYfU6u17hHxEa8Pwatc42V1S81glqq/HXDq9KpP+691aMIQsWfLvfOG3Qv8kdFww/ry/yDXSHXmrmxm+RkQV1Ht2BqmZ9HYO3uQHTmOJgAYslHWv4RdvkOM8bI6FhqJWwantRaxppY+6/szySX8YGvbD7zfz+a6lLoZGtZsY/5YYcjAYRyjA8hikFs6sgCPM6JFcMdH+/n4bVp7OJ2BqLb+PBvlpDPl451byNn2JJk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7307bb-6fb6-41df-e2eb-08dc999de33c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 07:17:38.0956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uu4z7ykXlkcS88D9UUdXY0E1SmnopohwiNruVzGiQnP1uhdSld0QvrR3A8J4hor8aW7fh0OY08bKJ8MkiMgaSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8331

T24gRnJpLCBKdW4gMjgsIDIwMjQgYXQgMTE6MDM6NThBTSBHTVQsIEZpbGlwZSBNYW5hbmEgd3Jv
dGU6DQo+IE9uIEZyaSwgSnVuIDI4LCAyMDI0IGF0IDU6NTTigK9BTSBOYW9oaXJvIEFvdGEgPG5h
b2hpcm8uYW90YUB3ZGMuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoZXJlIGlzIGEgcG90ZW50aWFs
IHBhcmFsbGVsIGxpc3QgYWRkaW5nIGZvciByZXRyeWluZyBpbg0KPiA+IGJ0cmZzX3JlY2xhaW1f
YmdzX3dvcmsgYW5kIGFkZGluZyB0byB0aGUgdW51c2VkIGxpc3QuIFNpbmNlIHRoZSBibG9jaw0K
PiA+IGdyb3VwIGlzIHJlbW92ZWQgZnJvbSB0aGUgcmVjbGFpbSBsaXN0IGFuZCBpdCBpcyBvbiBh
IHJlbG9jYXRpb24gd29yaywNCj4gPiBpdCBjYW4gYmUgYWRkZWQgaW50byB0aGUgdW51c2VkIGxp
c3QgaW4gcGFyYWxsZWwuIFdoZW4gdGhhdCBoYXBwZW5zLA0KPiA+IGFkZGluZyBpdCB0byB0aGUg
cmVjbGFpbSBsaXN0IHdpbGwgY29ycnVwdCB0aGUgbGlzdCBoZWFkIGFuZCB0cmlnZ2VyDQo+ID4g
bGlzdCBjb3JydXB0aW9uIGxpa2UgYmVsb3cuDQo+ID4NCj4gPiBGaXggaXQgYnkgdGFraW5nIGZz
X2luZm8tPnVudXNlZF9iZ3NfbG9jay4NCj4gPg0KPiA+IFsyNzE3Ny41MDQxMDFdW1QyNTg1NDA5
XSBCVFJGUyBlcnJvciAoZGV2aWNlIG51bGxiMSk6IGVycm9yIHJlbG9jYXRpbmcgY2g9IHVuayAy
NDE1OTE5MTA0DQo+ID4gWzI3MTc3LjUxNDcyMl1bVDI1ODU0MDldIGxpc3RfZGVsIGNvcnJ1cHRp
b24uIG5leHQtPnByZXYgc2hvdWxkIGJlIGZmMTEwMD0gMDM0NGIxMTljMCwgYnV0IHdhcyBmZjEx
MDAwMzc3ZTg3YzcwLiAobmV4dD0zRGZmMTEwMDAyMzkwY2Q5YzApDQo+ID4gWzI3MTc3LjUyOTc4
OV1bVDI1ODU0MDldIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiA+IFsy
NzE3Ny41Mzc2OTBdW1QyNTg1NDA5XSBrZXJuZWwgQlVHIGF0IGxpYi9saXN0X2RlYnVnLmM6NjUh
DQo+ID4gWzI3MTc3LjU0NTU0OF1bVDI1ODU0MDldIE9vcHM6IGludmFsaWQgb3Bjb2RlOiAwMDAw
IFsjMV0gUFJFRU1QVCBTTVAgS0FTQU4gTk9QVEkNCj4gPiBbMjcxNzcuNTU1NDY2XVtUMjU4NTQw
OV0gQ1BVOiA5IFBJRDogMjU4NTQwOSBDb21tOiBrd29ya2VyL3UxMjg6MiBUYWludGVkOiBHICAg
ICAgICBXICAgICAgICAgIDYuMTAuMC1yYzUta3RzICMxDQo+ID4gWzI3MTc3LjU2ODUwMl1bVDI1
ODU0MDldIEhhcmR3YXJlIG5hbWU6IFN1cGVybWljcm8gU1lTLTUyMFAtV1RSL1gxMlNQVy1URiwg
QklPUyAxLjIgMDIvMTQvMjAyMg0KPiA+IFsyNzE3Ny41Nzk3ODRdW1QyNTg1NDA5XSBXb3JrcXVl
dWU6IGV2ZW50c191bmJvdW5kIGJ0cmZzX3JlY2xhaW1fYmdzX3dvcmtbYnRyZnNdDQo+ID4gWzI3
MTc3LjU4OTk0Nl1bVDI1ODU0MDldIFJJUDogMDAxMDpfX2xpc3RfZGVsX2VudHJ5X3ZhbGlkX29y
X3JlcG9ydC5jb2xkKzB4NzAvMHg3Mg0KPiA+IFsyNzE3Ny42MDAwODhdW1QyNTg1NDA5XSBDb2Rl
OiBmYSBmZiAwZiAwYiA0YyA4OSBlMiA0OCA4OSBkZSA0OCBjNyBjNyBjMA0KPiA+IDhjIDNiIDkz
IGU4IGFiIDhlIGZhIGZmIDBmIDBiIDRjIDg5IGUxIDQ4IDg5IGRlIDQ4IGM3IGM3IDAwIDhlIDNi
IDkzIGU4DQo+ID4gOTcgOGUgZmEgZmYgPDBmPiAwYiA0OCA2MyBkMSA0YyA4OSBmNiA0OCBjNyBj
NyBlMCA1NiA2NyA5NCA4OSA0YyAyNCAwNA0KPiA+IGU4IGZmIGYyDQo+ID4gWzI3MTc3LjYyNDE3
M11bVDI1ODU0MDldIFJTUDogMDAxODpmZjExMDAwMzc3ZTg3YTcwIEVGTEFHUzogMDAwMTAyODYN
Cj4gPiBbMjcxNzcuNjMzMDUyXVtUMjU4NTQwOV0gUkFYOiAwMDAwMDAwMDAwMDAwMDZkIFJCWDog
ZmYxMTAwMDM0NGIxMTljMCBSQ1g6MDAwMDAwMDAwMDAwMDAwMA0KPiA+IFsyNzE3Ny42NDQwNTld
W1QyNTg1NDA5XSBSRFg6IDAwMDAwMDAwMDAwMDAwNmQgUlNJOiAwMDAwMDAwMDAwMDAwMDA4IFJE
STpmZmUyMWMwMDZlZmQwZjQwDQo+ID4gWzI3MTc3LjY1NTAzMF1bVDI1ODU0MDldIFJCUDogZmYx
MTAwMDJlMDUwOWY3OCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEgUjA5OmZmZTIxYzAwNmVmZDBmMDgN
Cj4gPiBbMjcxNzcuNjY1OTkyXVtUMjU4NTQwOV0gUjEwOiBmZjExMDAwMzc3ZTg3ODQ3IFIxMTog
MDAwMDAwMDAwMDAwMDAwMCBSMTI6ZmYxMTAwMDIzOTBjZDljMA0KPiA+IFsyNzE3Ny42NzY5NjRd
W1QyNTg1NDA5XSBSMTM6IGZmMTEwMDAzNDRiMTE5YzAgUjE0OiBmZjExMDAwMmUwNTA4MDAwIFIx
NTpkZmZmZmMwMDAwMDAwMDAwDQo+ID4gWzI3MTc3LjY4NzkzOF1bVDI1ODU0MDldIEZTOiAgMDAw
MDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZjExMDAwZmVjODgwMDAwKDAwMDApIGtubEdTOjAwMDAw
MDAwMDAwMDAwMDANCj4gPiBbMjcxNzcuNzAwMDA2XVtUMjU4NTQwOV0gQ1M6ICAwMDEwIERTOiAw
MDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KPiA+IFsyNzE3Ny43MDk0MzFdW1Qy
NTg1NDA5XSBDUjI6IDAwMDA3ZjA2YmM3YjE5NzggQ1IzOiAwMDAwMDAxMDIxZTg2MDA1IENSNDow
MDAwMDAwMDAwNzcxZWYwDQo+ID4gWzI3MTc3LjcyMDQwMl1bVDI1ODU0MDldIERSMDogMDAwMDAw
MDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIyOjAwMDAwMDAwMDAwMDAwMDANCj4g
PiBbMjcxNzcuNzMxMzM3XVtUMjU4NTQwOV0gRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAw
MDAwMDBmZmZlMGZmMCBEUjc6MDAwMDAwMDAwMDAwMDQwMA0KPiA+IFsyNzE3Ny43NDIyNTJdW1Qy
NTg1NDA5XSBQS1JVOiA1NTU1NTU1NA0KPiA+IFsyNzE3Ny43NDgyMDddW1QyNTg1NDA5XSBDYWxs
IFRyYWNlOg0KPiA+IFsyNzE3Ny43NTM4NTBdW1QyNTg1NDA5XSAgPFRBU0s+DQo+ID4gWzI3MTc3
Ljc1OTEwM11bVDI1ODU0MDldICA/IF9fZGllX2JvZHkuY29sZCsweDE5LzB4MjcNCj4gPiBbMjcx
NzcuNzY2NDA1XVtUMjU4NTQwOV0gID8gZGllKzB4MmUvMHg1MA0KPiA+IFsyNzE3Ny43NzI0OThd
W1QyNTg1NDA5XSAgPyBkb190cmFwKzB4MWVhLzB4MmQwDQo+ID4gWzI3MTc3Ljc3OTEzOV1bVDI1
ODU0MDldICA/IF9fbGlzdF9kZWxfZW50cnlfdmFsaWRfb3JfcmVwb3J0LmNvbGQrMHg3MC8weDcy
DQo+ID4gWzI3MTc3Ljc4ODUxOF1bVDI1ODU0MDldICA/IGRvX2Vycm9yX3RyYXArMHhhMy8weDE2
MA0KPiA+IFsyNzE3Ny43OTU2NDldW1QyNTg1NDA5XSAgPyBfX2xpc3RfZGVsX2VudHJ5X3ZhbGlk
X29yX3JlcG9ydC5jb2xkKzB4NzAvMHg3Mg0KPiA+IFsyNzE3Ny44MDUwNDVdW1QyNTg1NDA5XSAg
PyBoYW5kbGVfaW52YWxpZF9vcCsweDJjLzB4NDANCj4gPiBbMjcxNzcuODEyMDIyXVtUMjU4NTQw
OV0gID8gX19saXN0X2RlbF9lbnRyeV92YWxpZF9vcl9yZXBvcnQuY29sZCsweDcwLzB4NzINCj4g
PiBbMjcxNzcuODIwOTQ3XVtUMjU4NTQwOV0gID8gZXhjX2ludmFsaWRfb3ArMHgyZC8weDQwDQo+
ID4gWzI3MTc3LjgyNzYwOF1bVDI1ODU0MDldICA/IGFzbV9leGNfaW52YWxpZF9vcCsweDFhLzB4
MjANCj4gPiBbMjcxNzcuODM0NjM3XVtUMjU4NTQwOV0gID8gX19saXN0X2RlbF9lbnRyeV92YWxp
ZF9vcl9yZXBvcnQuY29sZCsweDcwLzB4NzINCj4gPiBbMjcxNzcuODQzNTE5XVtUMjU4NTQwOV0g
IGJ0cmZzX2RlbGV0ZV91bnVzZWRfYmdzKzB4M2Q5LzB4MTRjMCBbYnRyZnNdDQo+ID4NCj4gPiBU
aGVyZSBpcyBhIHNpbWlsYXIgcmV0cnlfbGlzdCBjb2RlIGluIGJ0cmZzX2RlbGV0ZV91bnVzZWRf
YmdzKCksIGJ1dCBpdCBpcw0KPiA+IHNhZmUsIEFGQUlDLiBTaW5jZSB0aGUgYmxvY2sgZ3JvdXAg
d2FzIGluIHRoZSB1bnVzZWQgbGlzdCwgdGhlIHVzZWQgYnl0ZXMNCj4gPiBzaG91bGQgYmUgMCB3
aGVuIGl0IHdhcyBhZGRlZCB0byB0aGUgdW51c2VkIGxpc3QuIFRoZW4sIGl0IGNoZWNrcw0KPiA+
IGJsb2NrX2dyb3VwLT57dXNlZCxyZXNlcmV2ZWQscGlubmVkfSBhcmUgc3RpbGwgMCB1bmRlciB0
aGUNCj4gPiBibG9ja19ncm91cC0+bG9jay4gU28sIHRoZXkgc2hvdWxkIGJlIHN0aWxsIGVsaWdp
YmxlIGZvciB0aGUgdW51c2VkIGxpc3QsDQo+ID4gbm90IHRoZSByZWNsYWltIGxpc3QuDQo+ID4N
Cj4gPiBSZXBvcnRlZC1ieTogU2hpbmljaGlybyBLYXdhc2FraSA8c2hpbmljaGlyby5rYXdhc2Fr
aUB3ZGMuY29tPg0KPiA+IFN1Z2dlc3RlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxKb2hhbm5l
cy5UaHVtc2hpcm5Ad2RjLmNvbT4NCj4gPiBGaXhlczogNGViNGU4NWM0ZjgxICgiYnRyZnM6IHJl
dHJ5IGJsb2NrIGdyb3VwIHJlY2xhaW0gd2l0aG91dCBpbmZpbml0ZSBsb29wIikNCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBOYW9oaXJvIEFvdGEgPG5hb2hpcm8uYW90YUB3ZGMuY29tPg0KPiA+IC0tLQ0K
PiA+ICBmcy9idHJmcy9ibG9jay1ncm91cC5jIHwgMTMgKysrKysrKysrKystLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9mcy9idHJmcy9ibG9jay1ncm91cC5jIGIvZnMvYnRyZnMvYmxvY2stZ3JvdXAu
Yw0KPiA+IGluZGV4IDdjZGU0MGZlNmE1MC4uNDk4NDQyZDBjMjE2IDEwMDY0NA0KPiA+IC0tLSBh
L2ZzL2J0cmZzL2Jsb2NrLWdyb3VwLmMNCj4gPiArKysgYi9mcy9idHJmcy9ibG9jay1ncm91cC5j
DQo+ID4gQEAgLTE5NDUsOCArMTk0NSwxNyBAQCB2b2lkIGJ0cmZzX3JlY2xhaW1fYmdzX3dvcmso
c3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiA+ICBuZXh0Og0KPiA+ICAgICAgICAgICAgICAg
ICBpZiAocmV0ICYmICFSRUFEX09OQ0Uoc3BhY2VfaW5mby0+cGVyaW9kaWNfcmVjbGFpbSkpIHsN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAvKiBSZWZjb3VudCBoZWxkIGJ5IHRoZSByZWNs
YWltX2JncyBsaXN0IGFmdGVyIHNwbGljZS4gKi8NCj4gDQo+IEJ0dyB0aGlzIGNvbW1lbnQgc2hv
dWxkIGJlIG1vdmVkIGJlbG93IG90aGVyd2lzZSBpdCdzIGNvbmZ1c2luZy4NCj4gDQo+ID4gLSAg
ICAgICAgICAgICAgICAgICAgICAgYnRyZnNfZ2V0X2Jsb2NrX2dyb3VwKGJnKTsNCj4gPiAtICAg
ICAgICAgICAgICAgICAgICAgICBsaXN0X2FkZF90YWlsKCZiZy0+YmdfbGlzdCwgJnJldHJ5X2xp
c3QpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHNwaW5fbG9jaygmZnNfaW5mby0+dW51
c2VkX2Jnc19sb2NrKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAvKg0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAqIFRoaXMgYmxvY2sgZ3JvdXAgbWlnaHQgYmUgYWRkZWQgdG8g
dGhlIHVudXNlZCBsaXN0DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICogZHVyaW5nIHRo
ZSBhYm92ZSBwcm9jZXNzLiBNb3ZlIGl0IGJhY2sgdG8gdGhlDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICogcmVjbGFpbSBsaXN0IG90aGVyd2lzZS4NCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgKi8NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAobGlzdF9lbXB0eSgm
YmctPmJnX2xpc3QpKSB7DQo+IA0KPiBIZXJlLCByaWdodCBiZWZvcmUgaW5jcmVtZW50aW5nIHRo
ZSByZWYgY291bnQuDQoNCkV4YWN0bHkuIEknbGwgbW92ZSBpdCB3aGVuIEknbSBnb2luZyB0byBj
b21taXQuDQoNCj4gDQo+IFRoYW5rcy4NCj4gDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBidHJmc19nZXRfYmxvY2tfZ3JvdXAoYmcpOw0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgbGlzdF9hZGRfdGFpbCgmYmctPmJnX2xpc3QsICZyZXRyeV9saXN0KTsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgc3Bpbl91bmxvY2soJmZzX2luZm8tPnVudXNlZF9iZ3NfbG9jayk7DQo+ID4gICAgICAgICAg
ICAgICAgIH0NCj4gPiAgICAgICAgICAgICAgICAgYnRyZnNfcHV0X2Jsb2NrX2dyb3VwKGJnKTsN
Cj4gPg0KPiA+IC0tDQo+ID4gMi40NS4yDQo+ID4NCj4gPg==

