Return-Path: <linux-btrfs+bounces-6313-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8806192AF93
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 07:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B721F223BB
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 05:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9D81304A3;
	Tue,  9 Jul 2024 05:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eW6JJWon";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dlEi7j+m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42983BBC9;
	Tue,  9 Jul 2024 05:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720504181; cv=fail; b=NvwF2/MbO7SsvlzxSIpJe+jEK4Rt2P7x1a/z/lawlZgkI42uW2kmMA6D+hRpIXVznkfffx8guqpg/HUXlqGOcWyaVO4q3qOV7fyuoEX7oY5p8sCAvZUmVASj63Px8IfbCmydsjk/BDAwPsGOttvFUVmr0UzM6yTNsfNEesRcqis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720504181; c=relaxed/simple;
	bh=SdLDdKboM0y4MDR1Wm2APkPjATAjuzdXKqX/tbyw534=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AGWnF8V36W+otdeyV+9ml3KdxJucLGjzgpR/0rHwGss1rieAlF1j7dI/GjvIJHZwaVzbp/AxoszASXLgnKl/2h3XyJ8uTNrkUxTMoggIHJdi5p3SDDDVNvxFd1COiDxqyodyRa31NpQenCdKh8GdMyT4FWh7zgbYtXmZB/mnbmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eW6JJWon; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=dlEi7j+m; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720504179; x=1752040179;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SdLDdKboM0y4MDR1Wm2APkPjATAjuzdXKqX/tbyw534=;
  b=eW6JJWonFJ/1+F9KNLXJzmHBiXN3dylAnh1FHxsUx6ra0e+UHwtzQeNq
   QLgqBtEQ5wudZHZ1riHSH4LfHPITpLTk1D1VESQDTLu1nQs7UpM1HFQng
   F1OUSjiEPvIMhyw8t8OX1vcmnBjluWSsgHCxO5OxuaaqOsnosSVEdIKvO
   gl89ponsSy30KYCy22r75uHz5V5ImBOag7hiFKfQVMtWReRLxHQJ+ZMCj
   pEwq8iELHlaxjb/Pv0p+eCm3vk0y7SpGHbd59Coc9aGHm1k8JFDWvcIKD
   pdKrXn5+AQNKZ7AiQuT6TEaW4Mc1dkstbgdq/Uqujpsjy6ya3hgyB/j3G
   g==;
X-CSE-ConnectionGUID: 2HNabmLiQLSi3rZrzHJPkA==
X-CSE-MsgGUID: AwcrvwQmT8OZmhSvMPgW+A==
X-IronPort-AV: E=Sophos;i="6.09,194,1716220800"; 
   d="scan'208";a="21508954"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2024 13:49:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ve/iGw5igLUbrBzkw+K1TAUqD/JjTmYvDe8b66fRrDkEf0N8L7+hqiYyswuZYmalIgo4KZCRPjNk2yuXgZm3qa+UpxNuSwu6ttjJ3xYSUXaUHj96+62vC6kfr9XJ/hmJtm4JVOFrDbPXFvywJX99zXO6KmDXBdcCLsHf4PLD90hz/vyqkGb0FR+nbOA7SwUFOxLAbAC+z4nD1Hj5mYQqnbQ246oj+zHpszpCyKzIED+uT5dk7GThRtBUkbCBAP7r1JbrUiVTNvD7T2ZYHLWlHEB3bH37UqMvB7khpZjEsjDtiM2Z9Kmg9MR8HfQsb6PcCqqAPncbhHky3TRlsLL2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdLDdKboM0y4MDR1Wm2APkPjATAjuzdXKqX/tbyw534=;
 b=mCvXXcmW+UeL1hz9UacKTVI144AN1EZcahH1LblBmSiPwq7dLlS7XFgz10dD2jZev21kUUSLuBKNBho2tdtHuH4ayALBOuZt8XSAK/zXz1Upe3sdCwBjDbflRqhgNzz1SDGRkNfvEB/8XeOBWfd6cZewPI0lVpE2cBhlTDWkK7JUfv+gWi056yD6b7hs6pMatve6lukDmTLswymmWVGpHwHM0eqqbj1COLhz+YxMs19elSgZQrgoT54Ovm/Dd8a6MFLHP5wodUDeCXbBY/wghLmKT+f9XEURLbi1W5LREwfpVmGUVUqBm3fm9XFefzUrQYrZUhCvw1RsY2hIEG7qtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdLDdKboM0y4MDR1Wm2APkPjATAjuzdXKqX/tbyw534=;
 b=dlEi7j+mzLAjMv/KgiB2mxgMHghbgMspty8cai6pWc0qHgVL1mD+dmZ13kDEEV8Qq5sSmGYcxwuKOQLVEaqZMzVgjZECwtkW6cyx4ghMI+2Ku8Xjdk05SuTJTsuWi0it2p1zfFHdMn4YcIoS6bhkafSICqRtuKCP17pJ8bHtR+s=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS0PR04MB9341.namprd04.prod.outlook.com (2603:10b6:8:1f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 05:49:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 05:49:29 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Johannes Thumshirn <jth@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/7] btrfs: replace stripe extents
Thread-Topic: [PATCH v4 1/7] btrfs: replace stripe extents
Thread-Index: AQHazu35BKhoadzCtUipxOmgzcB//7HoxbQAgAP0iQCAALBZgIAAfxMA
Date: Tue, 9 Jul 2024 05:49:29 +0000
Message-ID: <6bdc75df-02cd-47e0-943f-e9260a1385c1@wdc.com>
References: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
 <20240705-b4-rst-updates-v4-1-f3eed3f2cfad@kernel.org>
 <e51d0042-ec10-4a50-bd76-3d3d3cbc9bfc@gmx.com>
 <9d7f7acf-8077-481c-926e-d29b4b90d46f@wdc.com>
 <51eebc20-94f7-4e3d-8a44-741dad2e9900@gmx.com>
In-Reply-To: <51eebc20-94f7-4e3d-8a44-741dad2e9900@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS0PR04MB9341:EE_
x-ms-office365-filtering-correlation-id: eaed7668-063d-424f-7962-08dc9fdae609
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RUprM1JVTVdYTzBlSFM4ZFRJckRxNjZERktMcmZ5dGRTcXVpUVczdHpIRmkx?=
 =?utf-8?B?UGo2MnpRb3A1UnZxMkRUUmt3aUFlT2YxbGlVNk9mbkRLakh5Y0IxM0pwaHBi?=
 =?utf-8?B?WUZrV056ZDdVUDBHeTZDakFMc1pVYlQ4Ri8rOTFWczV2Q0FVS29vZkJyaGhv?=
 =?utf-8?B?cGxSa0RqQmtKOFR3YVV2R3JwZFVnNDRQZmlMNlBEbDhacWxnazc4U1VmRXNv?=
 =?utf-8?B?bHFjM210eTViUjRRbUIrMFdUS2pGcGorQVZFd2hpa2UxRm5tRFhNN1ZOMmRz?=
 =?utf-8?B?S2R6Z0lvSEQ5M1RHYmREdVJyd1VZREQ0LzBTYWVmUHJFMWlDSk5qZTdzTGNR?=
 =?utf-8?B?RG5MOVp1dnpiZFlNaDFQNWc1NGVKMS9GdE50OHdKWk9BellWVEE2K0lvWmtW?=
 =?utf-8?B?Q1dBUmtRZ2txVEVXNWRYejhoOGlCN0R4TWpuY0xIeHpNdjk4aGlOTU1kRnFk?=
 =?utf-8?B?UUFVMmhaRlJVQ0tQa3lqSWJVTGJxa2F1M3dLNU5ORW9Fc2hSYUFXZ0w5ZmZ1?=
 =?utf-8?B?NlkxUTR3Zytvb0RrV2FjTjl5akZMc3ZSdmNIV1ZJRWc0aEpsSDB6R1Y2UkdU?=
 =?utf-8?B?VGhLbjYySlorUXRZR2JaQThHbVJtd3NWeVZKaFRSckVQZDFEUzIrbzVqcmNR?=
 =?utf-8?B?ZVhEb01iZ2ltQjdvVytMa3B6bFc2Y2owSGVsZEZONVB3WmVSNXB4SVV4RHMr?=
 =?utf-8?B?MngrT0Q4cjRCcHFpTXl2WUxlRWJuWFVlMDNOdzREUTl6L2ZqUk44cWRyZlZr?=
 =?utf-8?B?UWlZTUdEcW5ndWxER1gwVFhBSXN6emhYNjd4THc0QTRYVVljR0ZYZlpuZkNw?=
 =?utf-8?B?WlJ4MC90OE5wRkZLWFl0OXRNdEpHU25ubnJrR0NBYVFScGZGaktyQTVPTmlV?=
 =?utf-8?B?NEg2ZUxhd3lQNXNjTmNhdlZsOVpIZGFkMWZJY1NsdzAzUUQ4OUtXbVI2cndG?=
 =?utf-8?B?bkFtN0JoTFAvZVA3OFZxbm5mbDdYN0t1aXgyNlZiVDk5V1BweHFFZmxGdWN4?=
 =?utf-8?B?akVqa0VNVHlVS0hhbExYeG9sYmp3azRnVzRkOGl2Z0ZwODFVM3VLV2xmd0NF?=
 =?utf-8?B?OHQxMkcwSHd4MmZoWUJxdllEbkxEUTQ0SGRPY3FUazI5ckw5Q283WnJpQU51?=
 =?utf-8?B?a1ZKY1AyNTh2L3ZTczJRVnd0Uk9mczRKZG5qeGdXdFpuakI4T3dEV1p5Wkh4?=
 =?utf-8?B?bDdYdXZSR3dwemh0K1lkS3p5SWVaR0dXV1BpVnVKeWRFaWE1amtjZ0ZVNDhS?=
 =?utf-8?B?SnlnZ3pGUTVLbWUyT3dVb2I1dWRaM0FWWm45MzlnM0JsSmJNMmREeGZSUzFV?=
 =?utf-8?B?S3IxU3FxUjllMTg4Yi8xVUVnY1BQVHpZdEhXOFlKQmFmZzMrM1Q5VzlUaGNo?=
 =?utf-8?B?Sk9CWDdpdURtRnB0ZGJlZmp4UDhFTjBoV2pLNWwyZ2ZkbDRvbnV3czgwM2xH?=
 =?utf-8?B?RjlucUM4blQyT2ZXTU1PdWFObVNkbGpJcFlzYjJ4clpualFnT1EvQVMrbnV4?=
 =?utf-8?B?dUxmTThYVmdoa05vbFJ1WTd5K21CNVRCUEV2NE05ZDFkZUVSZ0dadGhrWXBX?=
 =?utf-8?B?ZGhJeitBN0RIV3hqdlhoTGFoUWZWekZlUUVNZlZlYnFFYkg3czE0bUlNTlBo?=
 =?utf-8?B?WnNNWnoxVGIxRFhiNmtXNllVQlJMYktGQWsrd1JFWExLUzlwSUxKVnFjZVdT?=
 =?utf-8?B?Yy8wKzhGYWpmZGpMb3cvTGtkRks5Vm5HZDYrNFBjM2tpZWkzRTBIOXlRUmYw?=
 =?utf-8?B?REkzeGRsalVlUDFtVjN0UFVkbTlrQnZSTXFkZGhEaUpUakJ6WUMxQmpQYnhr?=
 =?utf-8?B?Y0FUaUVqNnBmZmhBaUdncWM4ZGFPaGp5UGRtczdTWm1uNDhpZXA5WkpEdzRr?=
 =?utf-8?B?cnhUNmpKWkp5YlZOMXBFMWJLbGJ1RVRNY2c2UHUvVjFYMVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y2FEUWlWZW5iT215YisrKzJ2Z1lsdDhDYk5vSmNVdHluWUN2aUg0WWxZanFW?=
 =?utf-8?B?b3pSem9TTDVLeFBLNGxsMVVGbVNsZDlQaktNa2FLaGY5Y04rQ1o3UXZRVmVH?=
 =?utf-8?B?Z0dWcG5ZaERhaWhjaVcxUHRzK2c2cnJ6ZGdFNVczR3oxNHJSRzRBM042cE5y?=
 =?utf-8?B?VGJ3cWRaZEJNL0tWUGtDUmc5VmZhWDZublhnYmxPWnljTUdGbUk4bGxaYnRp?=
 =?utf-8?B?ckFia1BoZUhGR2l0NFdNQkE0cit4Mzd2LzA2dzlCUFZLUVI0RkFzZ1ZjYlA2?=
 =?utf-8?B?QU5sVDQvVEp5UDRLMTFtV3pWSXFsVlgxZVNPd0FsNzVlY0l1YTh5QWNEYUxG?=
 =?utf-8?B?Q0NVS2wzbGZYT2tYcTRvbTJodnhxMGNncUFxOTNpZmZHbWFJdzlsLzRPZ2tS?=
 =?utf-8?B?ZnQ5aWszZGZDbld1dUtxaGc3TzkrNklyUTY5ZDdzWklqYmUxc0l4a3BoV3ht?=
 =?utf-8?B?Zi9JRlpWbDB4K3R6bGNHaVp0WU1BNzhTcjdnMlY1Uk5WVEFFOFJhdXR5OWJP?=
 =?utf-8?B?bFV2Wk5zS0t3V1M3SS82TmxQUHIvcklHNnFJdnZmRVJMOE9lNDJ1R1VxaVJi?=
 =?utf-8?B?VTRjODRhZU5mVDh5Si8yR0JOWllCMkNvOE1RZEZ5Z2VyNkM0ellDRkRmaDhr?=
 =?utf-8?B?WUdEZUJ3L0orb0kxUGZIK3BGdDhhVm1XeVdjK1RVVzFBZXh5eGNMYm04eTYz?=
 =?utf-8?B?eGVqZXZUYnhRZHdJeC8vWk9aaFZWSk5tV0RPbzJpbXdtMUVKTDhmYkErSzJS?=
 =?utf-8?B?WnR5dTFsQkx0bHE3UjluNExOeFdJSzdLSDEwRjhyOXhjT1EyMkxJTUR3TW5J?=
 =?utf-8?B?M2U4RFcrNG5GQy8xUHJpWTV3OE1lVm1DWG9RY0tabExRVE5aQnBJbXMxZTY3?=
 =?utf-8?B?N0RrTldGbEdJdTI2R2dISUhhOS81d1ZBdnZCbzl5b1pDYzlCQTJYM0t6Rlkx?=
 =?utf-8?B?bksySWFrOVJZTUVna0ppamgyd01QR3VTa2gyRy9tdmdMREFuTisvL2tsZElD?=
 =?utf-8?B?RmpwUFJXeWlaWGxvUE4xRXBCb0IxNEpDOVdmek94ZXJhYldjYmNEemFrM2pY?=
 =?utf-8?B?YWVYc1pFc2VqMGo3dnFsRnRYV0hXTW5VWjVEQWJ1eWZNWEJCc1RmY0YrWWJz?=
 =?utf-8?B?QktILzRFMEd0ZjMzNDgvdEhDbUYwOEpJVjJjZ2REVi9HKzE0Wk5uTG1yRTUx?=
 =?utf-8?B?ZUxSV2ljNDN1cnJTYjIyejVrNzBYZmx4VWc5aHpFRHR5UGhteW4zbDd6UXBh?=
 =?utf-8?B?RmlNV1M5RW00VFlKTlNpMTNuV2ltWHFlaXFJeG4zd1UxSFhUNTAzbFNsYVFt?=
 =?utf-8?B?Y2s4RzdZUit3V050Tm9OVDdEM2EyWnU1OS80L2wrYXBSNUZwMGo3SkQ2cVZJ?=
 =?utf-8?B?WUdTVnR2YW1CYXRoVFpGL2txcGpRQnNXL2pocGVDZU1GM0F5aE1YbDdpOUhz?=
 =?utf-8?B?SkE4blBXdklWUTdXNlc0MmNBL3RlQnBPYUt1TGRZd2VvbStVM2JRdTUzSVJ1?=
 =?utf-8?B?T0RiVThXSjNXclZYbXJLT0xQRS9DN05kWkpOWHRIQmJoTUkzYTdhSmYzMklS?=
 =?utf-8?B?aWtISEd2TWNqYmFRaVcyMzFFMy9jQ1VvcmJsLzJmOXF0c0hmOFh6NGcrYjdF?=
 =?utf-8?B?SFB0ODlRNHVCVnVmSEtxWlp3QkFhRWV6TWFXVmJkelh6VHpoZStYYmJ3c2JH?=
 =?utf-8?B?ajVaM3drblNrU3k2bDFkTmxCa0x5M0s0ZzlTT1IxVmJGcW55UFVUMVNMMzla?=
 =?utf-8?B?cTRKYXpDWllhVEdkWktjVXRCbzFqUE1xVFNoOFk1V1RLM29xbytiZjFCQmNL?=
 =?utf-8?B?K1dnakwrRlkzdm1odWVrazhhUmVEYmNGTVpxalFUcTZkWCt0bFFRT2tHRldX?=
 =?utf-8?B?aHh3dDVwZmp2NjNLQXhNQUpuNmhocjRINjhrMm5icHQwTkJ2U1NEczJZM3dE?=
 =?utf-8?B?TzBDM2pNc3lwR1hEU29YYTBYZ3BqZjc4N0JEa0FEQUhicWE1NitUK1JkSjdR?=
 =?utf-8?B?TlExQ256NVh4N3l4KzVVS0k3c1FUdlVJU3MyYUJUMzRkbTBLbG1TdjBBeWxF?=
 =?utf-8?B?ZXpYZis5b1BCTE5BYkhkMVlTZ0plRXpuUXVWd2dXaGNMclhiMkdveEhqbjRy?=
 =?utf-8?B?S2tUMEZkZ3FOb1pIZ2ZTY0F6NEtCZEpwS3dHNnkyZDdZdEVFUllaUFUwUTRy?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60F9A17575E37C4086681590212E33AB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WwfIYFioAc2FQh7SH1SY//91gRFPsLyfCdpDJxvTcny2NBafdADuENvLz8WlL0jHOiLIpsUt4wQ0y5KFMSSnm3T+l0p3HshTwgZhBP0uj+WamawvJ5BktRj44ShYFGb+LmYq2Q9ZjCSo+XAWdwb6vZd+lnqApKeD4uxQwuVD4hxjeIH7No1kpTfkSzKcEZ/9UY18kQzx9LGUH2aFTtYJEWewPBXo4MEZHNlw3igDm7XQKcl1IL6GgCIIYNya15SNEq1JCV4WuWhtPhgzq1MCX7EJ6agw+Vm6LC0tTshtQ4etZ859AQJl+oLpuNtqEng0J8mcIaPrkmQiZrphMk1LLG6QLBZrYFfNkS2dz6R+aNeZ8nCmMTxMY5eYST2XtblN8VCInvJgBlsWf9dtP0JnXv6cvYMNMgZgfAJCHr64XByPn3KvnnEeUM9P8Wb42M4/U965IDF2HtEEva/jJFB4j2kPjyx0/NQxCuxt5GmJiQa4bR1O3Sz/OV6L1Rk8etZMHVoo1Cz6roMe59yT3Agtaq3iima3sKLT1D+gbiNIEQt7Yj5f+IelxFJtUfWRpOgXvJOSsU9dyksAR8Eu76atGXBvSn0/ehMn4FAnI8vk9182QkutX5IB5E3Q9zeMe5N8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaed7668-063d-424f-7962-08dc9fdae609
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 05:49:29.0582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DBt/4JT2n8xBSp2vLbIxLPnAUC9VWKvTPcPlzvMEDdRRToY3Bz6CesYC7TblXdeEVO0qDYCm9AOSy3v+HnHSVNPojx4SgfViYIVSlggljFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9341

T24gMDkuMDcuMjQgMDA6MTQsIFF1IFdlbnJ1byB3cm90ZToNCj4gTG9va3MgZ29vZCB0byBtZSBv
dmVyYWxsLg0KPiANCj4gQ29uc2lkZXJpbmcgaW4gdGhpcyBjYXNlIHRoZSBiaW9jIHNob3VsZCBt
YXRjaCB0aGUgZXhpc3RpbmcgcnN0IGVudHJ5LA0KPiBjYW4gd2UgYWRkIGFuIGV4dHJhIEFTU0VS
VCgpIHRvIGNoZWNrIHRoZSBsZW5ndGggb2YgdGhlIGVudHJ5IGFnYWluc3QNCj4gdGhlIGJpb2M/
DQoNClN1cmUgY2FuIGRvLg0K

