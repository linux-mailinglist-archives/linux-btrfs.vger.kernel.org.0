Return-Path: <linux-btrfs+bounces-8143-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1617697D3E6
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2024 11:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A86E1C2133D
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2024 09:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E4413BADF;
	Fri, 20 Sep 2024 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="djkGklJh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JMD1G4P3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9F325776
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Sep 2024 09:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726825927; cv=fail; b=AKqBwYQz5qCcY/r8u8yOH2aHFwBSif9qi03ns4r0ApdYR5PhwdCSNyHvo15sLNoN0t2lQ60NT8VjPWkGhqlGupcEXU7Ghr20gwU+ifjtcc7m/m20US9oJQGT8KkPMVjJh2hHK8MSGMmtg1OFMqgxIX+V6u/RHQDEbnBA2tnb914=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726825927; c=relaxed/simple;
	bh=7i0Hdf6RNfDiI91aWlbIqy45LXgH1hbZOeAst/6dceU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=acwOFqtIgb9JzHEImr34ZDKRjL25kf9OZU+AAsJTHzUDZmyy9X2ZBdfacdt4ArUwVrGN835Yeg2vECx52NQ1C4sXFV4AT9CeVHWj6wevfrIOC9y9clK8SdLVjR6LpBkFpOHQqXY6PabKDOFjZkiYF/w3yEyy3A3OVi6fVqtouf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=djkGklJh; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JMD1G4P3; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1726825925; x=1758361925;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7i0Hdf6RNfDiI91aWlbIqy45LXgH1hbZOeAst/6dceU=;
  b=djkGklJhYpCu6Dx5FhC6IZuHEB5/fNtxp+1ADSGlKnteFgwsMEXJgUni
   cns6yyKaPWZR0PYsKOo+J6eVkEtRRvMuQtsuX6f0df2rxt5Z1ogAx+jkt
   GSMcLJ+QQCxKEqlke4hUqdVkuWRFqIYUTT2IUOsXr3NnXQbySA0gwPghD
   VRrL1dBUWeDEvseamo/XwfyDTZAMldSmxybBcwdxYoeHqBGxuQChTK4I5
   qLaCEj/NV9JlWxTduuCq4Nh0zokxlJZsHMD0ysGc7bsDUIdSa9sQOmSd3
   /iLH7fc35z8X7ozIYZbUHJQswCeMXmBHdEzu7wcJoYTvWYt7QPMXe2HTj
   Q==;
X-CSE-ConnectionGUID: Yzcon+2US2myC8wapdaZ9Q==
X-CSE-MsgGUID: 0gRsloL1QZGgRTWTQwQDuA==
X-IronPort-AV: E=Sophos;i="6.10,244,1719849600"; 
   d="scan'208";a="27142012"
Received: from mail-mw2nam10lp2049.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.49])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2024 17:51:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rk4sEx8jGQ7e2MyjYmzIijo+tb9rIdu7pWbMtl7L5ARVs3bEY+/VSm80XuE01L9beGWdPCt4Fm0iU94RpZ3lmTjK9Ju84EYM6P8+1ZcUo3Fo1TlFQh5/RqTPrP55YSq1G9+cQybBfRbOdznnqkk1eqrYq0csvlu29x31QRVGTShZ0HQbfHgtBWYh9WEKTJCxLMxoV79aeOd/0FSOsxecmkdcvhDYYmoSX3EORpKe75FVdpICt8JOnGLGec8CxR9fXf5C4jDcnH2UB3IY7CNkDvbwVuU2llq6l4EIAVsrQZlhiL7riBoCbXFYUeybqj8YVAiHd3u+R5FePxGoTUWunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7i0Hdf6RNfDiI91aWlbIqy45LXgH1hbZOeAst/6dceU=;
 b=NCDlVreO5Ecl0AUgZc8LhJh1TPQ9qISNXyPixZqcmpLubQMVYWUnaxmQWy1ZA++ks4mHRur4WIwkBinIKmnmbMQqwiDgSygtOA/q6ugY1gg6/+fMELgM8db6d+QxjEA9x38GyQJFcnLAIkKYOew3X6usaeKz9AyYXJsUIeFdRhHJ1wA5OSKFaYl0LsYAThglOBR/PrWrBC2xFX4CuZqPv+e8YUceAh5gqzm5D3R2SyXSuZ+KI5YHAfFP9FCHmc8sNsm+GeZYowvdZAeJnr69C20MDdzjTWt7x8yDXRSsEyKocPLdl9CUOYWWM2i7770RYrHC3bHWExoRdYFHIbbwQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7i0Hdf6RNfDiI91aWlbIqy45LXgH1hbZOeAst/6dceU=;
 b=JMD1G4P3Wc7VoP9iwACM5PK3z0c3suXjIfndpc5+frvNAKwif538dIeU91Q74gK2HjY5rZPgo20JjR0N26n1VpdZTqrcdqeDOVxTaAO1IvwvBKQY0d1kCj6n6PjQRP++SZLUqwpTiRDD50Ewl0Pupvkoji6BQ81/H6Z4yGQGAt8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN4PR04MB8384.namprd04.prod.outlook.com (2603:10b6:806:203::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Fri, 20 Sep
 2024 09:50:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.7982.022; Fri, 20 Sep 2024
 09:50:52 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Gerhard Wiesinger <lists@wiesinger.com>, Johannes Thumshirn
	<jth@kernel.org>, WenRuo Qu <wqu@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC 0/2] Add dummy RAID stripe tree entries for PREALLOC data
Thread-Topic: [RFC 0/2] Add dummy RAID stripe tree entries for PREALLOC data
Thread-Index: AQHbCdT4jVtO6XSQ6U6iM3wx68oLnbJfVluAgAEbIoA=
Date: Fri, 20 Sep 2024 09:50:51 +0000
Message-ID: <8756a50a-fd75-4dff-a523-15cfba1cf3e4@wdc.com>
References: <85888aaa-c8f5-453b-8344-6cabc82f537e@gmx.com>
 <20240918140850.27261-1-jth@kernel.org>
 <5924fc09-8abb-4163-854e-5cdac28f47d6@wiesinger.com>
In-Reply-To: <5924fc09-8abb-4163-854e-5cdac28f47d6@wiesinger.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN4PR04MB8384:EE_
x-ms-office365-filtering-correlation-id: 5430a651-1ba1-4732-b64c-08dcd959b6ae
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OVg1ODdiY1ZkWER1cU9GQWs4U3FjdXl3Q2Q4YXJCUGozaEpaMHdzTEtjK3NJ?=
 =?utf-8?B?Ry81cEd5SmdIMVJiTEZDdnhnam1zK2lMOTBrLzBuK3cyYWRsei9jM2l6ejFj?=
 =?utf-8?B?SERTUEkwRno0S0MrSDZLMXFZcWdYcTFaU1FTdzl2dk9nNmtrbzNLQTVzUkxM?=
 =?utf-8?B?MkIvcm10S3dQbk41MXdsWVk4bndWZm5LWG9sS0pLc3RYSmJ5cDBBbkN1Y3NO?=
 =?utf-8?B?YWNJSmR3NHZuUk9JVVlEek1qQnJsOS9pa2VoVU9zUXZVTGhVNXRNcHl5dk5G?=
 =?utf-8?B?YUplK29jNjZZS2ZDOUJxbDFaY09SelUwSU85ODNacE5pd1VyTVJMdlMrSFNr?=
 =?utf-8?B?a1ZiMnFra1VqazVqaEtMVldEYXFqcTV5RlFhWkp6aEl5S2puK1hLRktjTG93?=
 =?utf-8?B?NUFoMDhqYURJSUxGY3JsbjlGQVhMYnZaazM2WU1MY3g1TURRdEFCTzJodXcw?=
 =?utf-8?B?eUl4KzgxTG5xdDdudVV6TU9IMGdISWY5QmphdDZVdTRSc2JtYTlNK0l6aEds?=
 =?utf-8?B?cUMzOVNPaE5YK3VHVWhXczdNUGFwZ1pJZkRNellDblMvSFdnanpxNU9uRE9J?=
 =?utf-8?B?ckZUb0lhSVhTcXFJbWNBRExYdHJZMURCUUFSZzdZT2NaVmVSNjY2dSt4NjNJ?=
 =?utf-8?B?UU8zRlF6UUpWU0JKZU1qdmZ6eUFDdEFNQ0FGcjc2RWFoU0dtOWJpTHA3SDcx?=
 =?utf-8?B?RVpBR0twU0VmVy93UkhMZVVqdG1yMCtxMHpFemNwSWNWRjljQnptZkVmRlEv?=
 =?utf-8?B?SWlaZ0Z5TGo1VWhHNGJia0FRWU9WUmJUcndoS0lmQlA3STZTbWJBM0RTcGtL?=
 =?utf-8?B?a2RjeCs1bUtxV1NSM0ZQMzNXc0luY3FQY1hqSDJFM3B2VlplOUhUZ0ZUa3VK?=
 =?utf-8?B?V0xlb1B6cmlwVVFmUmdLcE1rcGZtL3B4S2k2WVNmUmdNTEY5Ym82cGNtTGNt?=
 =?utf-8?B?MFh5YXI1bUJBVjF5TTltVlJrbURkUjN6WmtPZ3ZwMmQ5QzUxV0pqa0IxUmJq?=
 =?utf-8?B?U2twRVN1M0ZncGQrWVZQRFREcW5objIwNEVRRC9SMGYrcmNIOERBU3c0RUxr?=
 =?utf-8?B?dUJrS2tRR09rd1VoN3Nud01ER0MrWjRBVzB1bXc5aklmdTQwUjR4OVI2cWhR?=
 =?utf-8?B?QWdsekluemtXOXNjdEJ6eEd5ODhUR2UrUlF2UGVVZlNwVGlTTFBqYk5Yamsw?=
 =?utf-8?B?cWVxR0dXVWdJdFdNYVRpK09tN2RNUUFkUm8vLytVWm5KMlZvaW9WODlrM3BL?=
 =?utf-8?B?ZGpUWmlsUUhXL0k1TGdqODVUdFZUZDdDWWpLdHludXRmbW4vY1JjM2ttajAz?=
 =?utf-8?B?eFREL0VkWnlZci8yVzFqYlkybXkwNkE1L1J0NjNBazBuTG5xdzdLUVJwSWtL?=
 =?utf-8?B?SEl0bks0bVBWbU1ETUpDemdsMUJLb2lmSGIwazdTOCtXRC90SmVuN2J4RjZ2?=
 =?utf-8?B?TEt6TGwrMHV1ZHJUeXlFOFBkYUNEWnFzbVpWRWk0KzNjWlBMMHQ4WmdBWEZi?=
 =?utf-8?B?OGExNkk5WTgrYVZMSVZyL3VaTXI3V0FaaXBkQ3NNTHpYanZCTGdLUVBvb1d5?=
 =?utf-8?B?Zmlhb0RBUGN3emU3R3ptdDBmakp5WkxYT0ZyTGw5eXhlV09LMnl4L0xZRk1L?=
 =?utf-8?B?a01wV3pVQlNaUkZmS1VjZjlJdnJYb25QS29TcTVaSHY2WGc4cnF2bnFCTXYv?=
 =?utf-8?B?U1pzeGFWY21EUjJ2bVNjSHpVMGJ4WHBvRXVpbUZHVWZ1aFVGT2VweHRIcHVT?=
 =?utf-8?B?UkZFcFVwblM2MkpEZTJ6bGRWeXk2aE9TbXlLRVhRb29ZV1dkZk1VZ1A4ajF0?=
 =?utf-8?B?NDBxZXF6ZWdLenNaWWVGTkJRSkN5NksxMlpzTjZURUtJTUpab1JQN2hZNGd0?=
 =?utf-8?B?TVFNZk53aHZwcTRZZEIzYUROWllqL0xWU2tVNi9oL3hqdkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WE56YXpyWW9YSGJDVENMR2x0YzRKQ2dRdW1Gczl2anJsTVZKQzh2UjBWcjh6?=
 =?utf-8?B?K3dpZU0rMzg2M0xwUkdxREdFTXV0MG8yeFFZa0t2RGpMZk5waWxodUVDWGRT?=
 =?utf-8?B?cDJaSkx6S0VscVVnRElvVzF4b2FweDVyTzdnWEhNTVAya0NsZDZLL1Nvc29n?=
 =?utf-8?B?eUpxVnZxSFJ3UWtWWk5JTVBzWUFNWmhiMjY2YWpJdjZxdUVQY2QzcExmaGRX?=
 =?utf-8?B?WFQzLzl4VTdXeGwzQ3NOZk1LWlVsOHl1c0hwZlJxaWtvbEVxY2s4dEd4SnYr?=
 =?utf-8?B?TEZScFhoZnp6TW1zNi9ieVBnbTNLZFVtVm9WWGZ3cUIwbmQxUVcrTDZod1o2?=
 =?utf-8?B?VzlxaEpVMWFmd3doOXVBMU1sdXZXa09BVmdMMHpHbSsrcjFNODNNV0VRdFNH?=
 =?utf-8?B?MnUycHM2Rmo3dDZRU1dSaXNvQWhMK1MvTWgxb1N0U05GbGgxTU1lRjVoa0ZC?=
 =?utf-8?B?TVR1d29hc29XOUxITkxrU212V2VKWWNabWM3dFdUVzFhQzByTWp0SUxNQW1U?=
 =?utf-8?B?Z1l0dXJSNGdndVo1VDZJa0pUM3JoZW1GRHRta21XRW1NdSt3cFMzNTJUd1A4?=
 =?utf-8?B?RGhOOXc2MUg1VTczQnlVWnkxaE5kemNBVWZBa3RBNVVkM05GL2lrcUFnUXZm?=
 =?utf-8?B?WEF1RE1LVllaUnBiN2g5N2dxNFFhUmE5dHdjdzVTdVFtd0tNcGVucmlnTHZx?=
 =?utf-8?B?UW8zUlR5aEpjVm4vM3VhRWRoRHEyeTFZVUpnK0VSU0dkODE1UWgwejZwY3Er?=
 =?utf-8?B?ellzRkpGaVQrS09NZXhSNWFBaU9hSHY4MGU3a1ptUGhhZ2pkU2hZM2lZM292?=
 =?utf-8?B?bU9SVTNaY1lwSGFNSFF3NjRnV09HeTg1SEpONk1jYXRyc0pRdURlL2ZTbFFL?=
 =?utf-8?B?NEZYblB6ODdZNHBQRWxpTEJBOTBSZFNydERaK05tWFFYNS9tVXlmSkRLcWpj?=
 =?utf-8?B?QW5DOVJHbU8rVWpxMzZxY0IvY3FnL0hDY0lGTldvNStjVGl5OWtnTTArYVBW?=
 =?utf-8?B?OWZadUxQa01qUk5adU9VeW1ycEZIcmY0OXA4ZXpGOFV6dGdHeEtoelZGUTU5?=
 =?utf-8?B?QkJmVUFZeTE0T2p1a2JXaWdyWWhYYkh3WHd2S1o4bUVEN3FpdFV5T2Rhbk1u?=
 =?utf-8?B?eW9vUitMaGx0dkhoK1pYZmxZcVhacHJrVXl1TjhOQUhsOWdKckVQRzdKL09I?=
 =?utf-8?B?Q044aW01VFk1d3hHMFFZSWFNVWZMK1gzMzNvZGhrNUZRclEvOFdGZ3RFcWVG?=
 =?utf-8?B?V0lmODZKTDVPQnZ2Tit0WCtXMHNSZWZKd1l4LzgwYmw5ZUN3c0JLaWZSVkdF?=
 =?utf-8?B?RjhBaEdPbE5OZitXak9KU21iTUx1R0FwMEJ3VDlQdEhKc1NmamhyMG90RjZV?=
 =?utf-8?B?alVybGMzOVp4RlVuOS9VSTVQM0l3MVVCeGRJKzJoQXltUjRxUmVuc1N3NXVJ?=
 =?utf-8?B?OVZveU5XUDV1WVVVamhBOFArNGU3UkxKZVE4RXF4YVljM2lZVWJSY1dBbGVW?=
 =?utf-8?B?MHZOR0FZUEU5bXBXY3VWUHJJVmVRNXd6M1dKMXBuSWxMaFdyUWdGbDN1VG52?=
 =?utf-8?B?UkRqM1duNnZ1YXlnVHJ4QkczYm81N3RMVjRta1ozTFR2eXMvaUVqbmtobE1v?=
 =?utf-8?B?R28wUjZLYm1GVXJkWTNlODl5eHNEVVBTMS95RGd4NmtvTTl0TnRaU2JFR2dM?=
 =?utf-8?B?S1FCQURVc3N4Uit6ekdkSEZ0ZmRaMGNlQmNkRG83aDVxZlVZanhjVVl2QTU3?=
 =?utf-8?B?a3htamJXQjBKZG1mb0FOZVQyd2RFVi9FOFpKV3hUVCtMZXNlN1o0anFmYnFm?=
 =?utf-8?B?REFBd3JkWFZtTHFVbTIrV0swb2QwdkFIUnVxTmZlOTZ4c0tYNWFFNGFWZUJw?=
 =?utf-8?B?YllRWllIdzBMbURZbjM2QWJaS1EzR2tEc0luVHhjSVlVQkg0RGpYaU9CanVi?=
 =?utf-8?B?VzVtVVVaT2FhYW93S0VIS0FOL3JPQTNLbjZJMWlpSDRtdnZHdEUxbUkwVHRy?=
 =?utf-8?B?di9JREJzTFY5NXRtYm1raWRjc1FhQmlnNjAxTnVydWY3V2cwWDVOS1pHSktC?=
 =?utf-8?B?ay9NbytvVGlGWEs2MTMwTjF3aHphUklmT2pMcEM1dlRKNHluTDVJL0U1Y0JS?=
 =?utf-8?B?bTlDazdEQXVGK0gvWGNscUh4ZmJBaVFTRFZrZ2dpd2EyayswRVArQUxiK0FS?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F0A6240A943C2419F17F890FDE1C7C3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p0dd5o2PH06YaRDhyW7u2CFYK6pFTADSlZgyj/8mlJ3P7Loqo9Ir1GV4x6La3axet9RDXH6yhr/kYINJ6tl1K9eA7oWePS+jCJQyEblQ10sz79QHakgZf0PRBTB0slUwlta1O5dmCj5naHfTEalh3Lm68q8Co7CUSkP/xypnYEbPxkfQMisRejfLECyk6uBq6Y6zBsFBz7vuta6WIv7h/Uy7K+70aaA/QRV8st8jya0o0ORFBE1ueG0F7xfiwV3RJSVqwUybTU5ky745iNkazTO/227hqlnd4AeCeXq0t1bOmWyQuVnmzrMz8PS5eH8u7ZiCO7MFitGhKm/pDIHQsNKqVVENcfPh2eWOR1DXFxLA4hnUr1nkeqMXEMHp8FfBsiGnL3xOfCrIYV0XK8SWfFu9Ay7E12wAfwoSf5ZBsPScwnTp6PJm8cSjQwUsa7HT7kYc1bovAfmvIufAnLrdoBHB8QRLcMsBorb4RboD2Z5xPs1tBbuo9zHW+0gIjXso5A0wVD/8H2ninByNdJDX3IRpPFaFBIl0y8Na9bhD7hZJ6MQuIzZdcaqonFe4Zp9TdbFJf+JxXIamrsnjF+gxCUmVmQz9FhCeU1ZomhKLwkGKO8rIN+1Y5z0ab4VslM8j
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5430a651-1ba1-4732-b64c-08dcd959b6ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 09:50:51.9896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jW+E3h6d+TtP60XeP6+ymayYElAvOIFSF/0p/4SaN6b9/BsusVWnCRiUEUke085NYacG6ovpGtrYb5z5bbklrOmVVV9Darbkw8b9GqPg4SA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8384

T24gMTkuMDkuMjQgMTk6MDYsIEdlcmhhcmQgV2llc2luZ2VyIHdyb3RlOg0KPj4gSm9oYW5uZXMg
VGh1bXNoaXJuICgyKToNCj4+ICAgICBidHJmczogaW50cm9kdWNlIGR1bW15IFJBSUQgc3RyaXBl
cyBmb3IgcHJlYWxsb2NhdGVkIGRhdGENCj4+ICAgICBidHJmczogaW5zZXJ0IGR1bW15IFJBSUQg
c3RyaXBlIGV4dGVudHMgZm9yIHByZWFsbG9jYXRlZCBkYXRhDQo+Pg0KPj4gICAgZnMvYnRyZnMv
aW5vZGUuYyAgICAgICAgICAgICAgICB8IDQ3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPj4gICAgZnMvYnRyZnMvcmFpZC1zdHJpcGUtdHJlZS5jICAgICB8IDQ3ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAgZnMvYnRyZnMvcmFpZC1zdHJpcGUtdHJl
ZS5oICAgICB8ICAyICsrDQo+PiAgICBpbmNsdWRlL3VhcGkvbGludXgvYnRyZnNfdHJlZS5oIHwg
IDEgKw0KPj4gICAgNCBmaWxlcyBjaGFuZ2VkLCA5NyBpbnNlcnRpb25zKCspDQo+Pg0KPiBXaWxs
IHRoaXMgYWxzbyBzb2x2ZSB0aGUgY29tcHJlc3Npb24gdG9waWMgKHNlZSBzdWJqZWN0ICJCVFJG
UyBkb2Vzbid0DQo+IGNvbXByZXNzIG9uIHRoZSBmbHkiKSBmb3IgZS5nLiBQb3N0Z3JlU1FMICh3
aGljaCBwcmVhbGxvY2F0ZXMpPw0KDQpObyBJJ20gYWZyYWlkIHRoaXMgaXMgc29tZXRoaW5nIGNv
bXBsZXRlbHkgZGlmZmVyZW50LiBUaGlzIGlzIGFib3V0IA0KY3JlYXRpbmcgUkFJRCBzdHJpcGUt
dHJlZSBlbnRyaWVzLiB3aGljaCBub29uZSBzaG91bGQgYmUgcnVubmluZyBpbiBhbnkgDQpraW5k
IG9mIGEgcHJvZHVjdGlvbiBlbnZpcm9ubWVudCBhbnl3YXlzLCBhcyB0aGUgZmVhdHVyZSBpcyBz
dGlsbCB2ZXJ5IA0KZXhwZXJpbWVudGFsLg0K

