Return-Path: <linux-btrfs+bounces-20753-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 580DDD3C2CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 10:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 351596209F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 08:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8453AE706;
	Tue, 20 Jan 2026 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VidmrlLm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TJaT7dLt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C26E225760
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897614; cv=fail; b=OLrudONSrNtUxlFS/w2aKg9hTd3kDIpRb6xZq9YJ9m5IJJm0nC8k95P1WDalgt49FMwq9+NXUxqPXhF+2efsbztD/2gOXD4sOyS+uJPEZl0cJg8gS1E39QBLPrMA8CkUNu4MDZZxrwFM9KfsbTHZzuXYgxLzJ8xj2X0ePG4dj3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897614; c=relaxed/simple;
	bh=bPVlbEA/CcbkTHXcR8CUqYvYUnlLmqt2GQfJB+uZrIo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ru/m6AMoXhELl39UEQ3gODw7JpCOP1sNB+zlWBy4m4CT+fICpON3q9Ca/0zvSGksmFGywZ94tH9v+FNiETuUY1LCUUMJAIdXvBt5PoWr7uzNdFbaAxyDaf/yvQjI8zzRD7oE0o8+eGO+mYqP8FaVgOXKvmHK40wFMi8xBxARj0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VidmrlLm; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=TJaT7dLt; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768897612; x=1800433612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bPVlbEA/CcbkTHXcR8CUqYvYUnlLmqt2GQfJB+uZrIo=;
  b=VidmrlLmp187Pa/Rp2hx7y3100z6Atoa8Q1vGAaawi2vodmQ9qLpfQh3
   YbDbJ0QotRocu1bRsGm422qzar1/JgWBA5Ob4vqOcmbVILvIyUWOBieLx
   RJIXMRSe3znWUQUjBOoGULOZIN5Cao1ygrO2Bdhxdj2NdAcciMQS9rbok
   2/sOnxVn/YfzUKRpvtjMn9/BFKLPC5TJBUbg+dy6kOOay9paDkJnc24Ei
   YQW1KlXYvcSkr9WcoMySOfGZhRKyvOwCczC7YXaC3D9M2Q8UyG7tRXT77
   oL4ITGrSlG5Qy+YI19NnX5ksEaUQccRr4JBvDGd3KVxDzAcCLsQKBgkHy
   w==;
X-CSE-ConnectionGUID: UsbpjAukSqqnPp5VLCtVuA==
X-CSE-MsgGUID: rfG/ddhVTPenp0Ehip3/pw==
X-IronPort-AV: E=Sophos;i="6.21,240,1763395200"; 
   d="scan'208";a="140288270"
Received: from mail-northcentralusazon11013058.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.58])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jan 2026 16:26:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIsb1EN7yrDChx//lA2bZJ2w28hpQbKwAUVRJs0idySKD/ME2EvS9Ms2Gwd7mPJpiOlaUXmxuMg7TOJQlrREhw0v345FQkd9oTbZTRFfseTZ0lZ6gsKJtM6I0SG9QG99rGX6LtYSR0FKrFJiIbpBVOB4o0LwhxwFl6upmnB2uS7DpUjS7pgJjAunJYvE3ggZpEGaWqxkoqehe4HxT+vVaV8BQpbMUm2SWilfvv4vMaU0q48OweyxH7vfxFbD4dmRIy+tO104PK6pO4ZSgNGMBCWs90y9GGdtyz1xmIEQj7cuElAGpKtTMLeGJlcgznEquz4PcN0hYb5wswTh4PQjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPVlbEA/CcbkTHXcR8CUqYvYUnlLmqt2GQfJB+uZrIo=;
 b=WshzQWzuirm27omsjxAEe6+lRAyXlae+j5M4Bz3v+oU9gh/1SL29I8eR821+PJUDAhzgBmA342/PnQuZ1fXqcsYZXFht6x+jCECQyNry+nT0/kPG2uyBywX7xy11cyOH6g31zFF34mpqY5rJpWcfG+Y64b6frsgSEb/JcEIEy7yQ2HV4KADU72krP5F85okVelAKvvHMNCeqH9FSpH02foAXMWfufVQSxfUjwkzfD5lYRn4C73DYpihOjRgIM8lopUezSKPfgjaB++T15AieIUHswL7AQ5dzHYf3V3zRKWRW4CsAlhsQpVo2SdwD9GgPvxHymvs0gzdGDNBrfV7JTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPVlbEA/CcbkTHXcR8CUqYvYUnlLmqt2GQfJB+uZrIo=;
 b=TJaT7dLttC5fVCaUaXyrhnBFPoqbsANI1jl85eFRYny3hHqg/zCIbivCOlKSxOEM6zlQHwlj7ws3SwMQI2VA7G96mF44wEbp8IG1jSTk14VMl4TMExXkA7az1fRU/aaRgBb8O2JQdijPUEn/y0qD5PuvQooGq3Av3rt+scOICWk=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SJ0PR04MB7310.namprd04.prod.outlook.com (2603:10b6:a03:292::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.5; Tue, 20 Jan
 2026 08:26:42 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 08:26:42 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: jinbaohong <jinbaohong@synology.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: "dsterba@suse.com" <dsterba@suse.com>, robbieko <robbieko@synology.com>
Subject: Re: [PATCH] btrfs: fix transaction commit blocking during trim of
 unallocated space
Thread-Topic: [PATCH] btrfs: fix transaction commit blocking during trim of
 unallocated space
Thread-Index: AQHcidij5+cQLHpuAkmRE8LUffeGp7VauVCA
Date: Tue, 20 Jan 2026 08:26:42 +0000
Message-ID: <cf826f01-b6f5-4b2a-a850-b066f268dff3@wdc.com>
References: <20260120064305.439036-1-jinbaohong@synology.com>
In-Reply-To: <20260120064305.439036-1-jinbaohong@synology.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SJ0PR04MB7310:EE_
x-ms-office365-filtering-correlation-id: 122e3c03-e662-4a18-4ec5-08de57fda401
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?c2NodVVaZUcwSWdVY08yYWRGemE3RUl5Rm9weXJDdjdMbFFlZmhIT0lwL0Rq?=
 =?utf-8?B?NzB4NTNvM1MrVkVuZUU4RW9pT0YyTER1aERoQzUwSG9YTlV3eTVHclBCOXlx?=
 =?utf-8?B?eWorNCtIZnI3VWwxQm5KUkhqck5MWGd2YUhzdmVXYkVSZEREV1NoUGQybWll?=
 =?utf-8?B?NXlZNms3UTdKWFZBS1lJK3V6eExVY3VZa1pWNTQ2OWZsWWE2dlR0NzNzQW9T?=
 =?utf-8?B?cjQ3UnZPRXVTM2MyUS92ZXdDYnpIV3NBYzRlSmY0bTRjQnlvcTJVVXFkbUJN?=
 =?utf-8?B?SDI4NEN2d1Brc3VFcnZkTGtOK2ljWWx2aThhenBFR2F5RWhpVm1wNzkwOW1t?=
 =?utf-8?B?UTFISWl3R2dmc1h0V3FJVWJ2VlBWeFZ0cGY1eDFvSE1QdmNVYkNqZHRzc2ty?=
 =?utf-8?B?aXhkOE9HaDhZWk1KZHh4VFVhZ1MrcUErOWxiOWV5K0RoS1JibElnOG4vTVB6?=
 =?utf-8?B?NEpwcmVQZzJadHZpcnZqM3hxU2FiMnlSdnZkRkIvN1g2RllZcHFiNlN4bWND?=
 =?utf-8?B?WHplUm1sQTJIM2w4SUt0V3ArazJVTnhkUWZWYWZJQU1wYzZtOTUzTUZFR2Vt?=
 =?utf-8?B?NWpyTll1L2pzSUdHUFplbUcrTWRGYXRVclZ3czRoQ0lJZkh3ZUQwczB5UWFP?=
 =?utf-8?B?NXNscTdqY0txQXNQSEVZZjBvcjJMU0p2aHo5cHBWVk5VOG52QTMxU0gyL2k0?=
 =?utf-8?B?SHFTSGhrQkgwVnVaaDVJQzFsYXZiWVJyOENOYmVrcGJ1TmZ2RG56QTZ5dTBD?=
 =?utf-8?B?RG9GMXFKUUVnenJRVm1NbUxHTnp0Q3VOaGRRYU9OY1BpcTZOOVpMd1UvQmZo?=
 =?utf-8?B?MzhiVUhkYUtYdjkxcnpQS01rMmVTdnZNV0V2UnZmclJnQXdSTXlhVkhkbGo2?=
 =?utf-8?B?aFhVaWprcWVSREg2MHFrd0dxMFpCb0FqR0s0WUkvdUQvTFZJOXV5NFk0Yjdi?=
 =?utf-8?B?RlZoL1Y0VElDbHpneDBEcklwN0o2VWlpNCtvOTMxODRaZC9IbnVBL1NrY2lv?=
 =?utf-8?B?U3pMYWlIYlRhaFlSZHI4U3JKUkNtajdhTHcxUXZjSHlDaUxhanpBcEZ4bHk3?=
 =?utf-8?B?NFp1bDI5REJWdXJoc1JnU2d2MXYydWdKU2R0Y09sQlBBam9leXNPV0RCd0dl?=
 =?utf-8?B?bnJMYXFid3VaSFB0NVArbFl6OWdyMDhIeFBXb0RmQlIweGFlOGlrTUxubkc0?=
 =?utf-8?B?aFBUWlBON3FkL2VhT1c4aVlrb2dKUHcxb0NTRkpHY09FN215VVdhcWNWRk1s?=
 =?utf-8?B?T1h2b3RxK0RrYVoxV21qdFJVNFloa2lNQkhjZ0Qzb21xR29xOHVpY2RpMkpW?=
 =?utf-8?B?ejQ2VUttbzZUM2F3M2dOUnlIUWJKRmk2OERLS085WDJEbWJCbEQxdWZicits?=
 =?utf-8?B?QTIwLy9QbUdxdXRKdmZ0Ylp0VVBSaFZQdVhtRS9GVGNUNkxMR3ptck5jVEs2?=
 =?utf-8?B?eHZBY0w3bUlFTTZjMDYvVWlnWTdhZG4vRElmMXk5S0hZVEc1eXNFekNkU1Jo?=
 =?utf-8?B?cm1hUHBRODM3RzBNQXY2czNlbnRJa2FPcmd1dlo5OWJ3eXZnbmM2aUh1alBB?=
 =?utf-8?B?MGlPM1RqTlM1TWRZVnladUFnZ1RkUmNtU3FPTnF3QjdsblBQbXNUQ3Mxd2lt?=
 =?utf-8?B?MFdENUtoWXM0ZFNoVDR2SkFjd3A5bU9jSzRkd2IrOVdhN3Vaa2dsaEV4dDE2?=
 =?utf-8?B?UHh4M0lHVkhkaVRBSXpQdG81Sjg2S0lDSjhJby8wYmpNbnRKQ0lXREt2MHYy?=
 =?utf-8?B?ME1pRUtGUUFmVjA0Q1U3MGdDN0VuWGw2ZGZCSTJiWWNrcGlmTXRHV2dwQi9M?=
 =?utf-8?B?YVF2S3RGRTl6RFpXQWpkQWFEbnphOFNuMGZzaXRGaWhVRzRvdHhwaXpxK1lZ?=
 =?utf-8?B?STVpYi8xZi9iNFJMLy9DdkthTnQ0ODhJMFc2bWhYckg5WW9teCtIQ3FWV215?=
 =?utf-8?B?RVQyYlFSdkNvQjlIRWlBSnJBV1lzTG9iTEFndi9WUWJjR0hUU0xRbXd5U1lm?=
 =?utf-8?B?dGYyN1VtNzVvS3NKVXNCK0xJWDNSK3pHL09KRW1YMkJGOWJUQnNzUDBKMEk3?=
 =?utf-8?B?V3ZPM0RWZDJUSGpWZGJUOCtvZ2xaVUIxbEcybGFXdG03VTJiUGROaXk5MTNU?=
 =?utf-8?B?cHYzdlkvRWo3ZDkybzQ3T0dTUlY5SmlXalVpd0RxZ3JYLzRZTGRoNUpCV09G?=
 =?utf-8?Q?5EcOsryp6whJER70BJiF5TQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmpibEpzVWdzbG9WaEFYeGdzK2t4bSsvY2RnR2FnTVkyd2hxV2dqZlFvbEdZ?=
 =?utf-8?B?bTdNUVBNVnE1eXJWU0xLVzJLMlgrOHluNG9NR2VrOE4xOGZFQmdLV25XVlQ3?=
 =?utf-8?B?MExLUTNGa0ZUUDRNd2REQXEvN1BmZ2NtR1V0RTZwU0VpZjNxelB2MEJZM085?=
 =?utf-8?B?bzdweTA2N00zMCtPSU42V2ZtLys4WHFvRFNHYldad2h0RzJDaElFaFZoWWNt?=
 =?utf-8?B?STFIRk9vTkR2b1VraXRIRGU2YzdsdzAvQ1JicUtiKzMvdmhPTHk0NmYxQ2xq?=
 =?utf-8?B?emVoblcwS3BVNVdrblc4bGpoMmpydHl0QVR0czN4aGZkT3lmNTNobnNpK3FB?=
 =?utf-8?B?ZTNsUTJ6REF2RURyQmZiemlOcCtibzMzTGFDV2cyanNTS3l1RVRqWTBnMVEw?=
 =?utf-8?B?dE9LYjJ4Nm5qRW9zbnVIV0xGL1BzM3pJdzNFSkdnbDBWRHRnd1ZZcVNEVUlu?=
 =?utf-8?B?S3NkN1I4WWo3UDBaYm8vL1pNNXlyVEtNK3QyUnZpM2d1NWlxV0F5TzZkMnlP?=
 =?utf-8?B?QjM1ZloxRi9NUGpibmdaQUJLS0s2VU5PY2lkU0tXUE4rdXpaRDRJWmZ4WDZH?=
 =?utf-8?B?ZEhIUzl3RjdhRnczZ2Zubk5rVEQxaWY1V1k5Ri9HazZJMXJBK2JJK3h1VDQ4?=
 =?utf-8?B?dGVpOStaUmIrZHdnUHhuc1A4QTdvcy9pcGcxcURxYjg5bUt1MHZ5OHFISEQ0?=
 =?utf-8?B?MFByWWFjL05OQVR2Z3QwZ3BjWGxVT3R0L3R3c2JpY0docFVuYmJOWHdNd1Zx?=
 =?utf-8?B?S1dUNGoyVkdaYlVDSlBFaUFkbnloaHF3Y0JvaWx0VTh3WFB4ellDUHl3ek4w?=
 =?utf-8?B?YWxsdm9HZnBUdjk1RnJKWlA2bG1pc0I0SG1WSWxBODNBNEIwRWFIVUpiWlox?=
 =?utf-8?B?L3hsVG5HRkUyNElNelo4OEE4YVRHWUVrdDJQeG1IWW5VZVpwNk4rQVRSUmN3?=
 =?utf-8?B?MDBkOUNsQXhMTDJncjAyMU5uQVh2OGxoQzNhUG53cWhUT2tJOFE3VUNIbCtL?=
 =?utf-8?B?dE9CcGVqQlFjaFhBWUVhUG92M21SK1hFc1hFMlp4dkFPY2RNMGhhN2t6Y1lZ?=
 =?utf-8?B?Z2FacHk1TENUTUNzb0tXeXpyN0FOOHdYNWFuMktPR0l3dVpYN2xlTG1aT0hB?=
 =?utf-8?B?NkpWNnFIRzJBbHVQMUpmUVkyTFJlNzdMUmhOWlFab05HUkt3djk4SEdmZFlr?=
 =?utf-8?B?bFI3S1RLaWlMb3JPcjlteFFEWUNIeElLZmZEQkpuci9KdnBpeWRCYWx3eEZv?=
 =?utf-8?B?T0l0MHFPWnZMdWpjajk0cCtMeC9CSHpFQjc5TlpBck0wQm1wMS9NdjgzZ1Vm?=
 =?utf-8?B?K3phSEIxQ1lpTHJEa0g4elJxK09wb3l2bTFBM1VINnc1R0IvMXlPd0dWUnp4?=
 =?utf-8?B?WmZkOUNoQVYwb0tKcVpEeHpveW43SWxNZzhNMkltU05nZTloVE9OVWNGUGRN?=
 =?utf-8?B?ZXZCOTU2c1cwSnpUYzNzWmNEZGZUdHArYXN6MFk5Z2UwdTcvZUkzeWRveXdn?=
 =?utf-8?B?Yy9IOVhkUUJBakh6TjFwUzJ4OCtvY3lHY25TbEd6SHFLRTlIM2lKUWJGeVNr?=
 =?utf-8?B?allrWldBQ3creUp0ZEFkVGhFOGp1Z2wwZmpLM1NoTE5zOXE2bHVlTU9nbDVW?=
 =?utf-8?B?TDVHZ0swZDNxTTAvRlBpV01uTjZGYlpiQ1ZLUlZKK0xCQmRZVlRkNHJoc3Zl?=
 =?utf-8?B?eGExQzBmN2tWeDc0YTc0c1RhdmN3QlBKMnUzUmdYdDNFajFodkUzK1IrZDVi?=
 =?utf-8?B?L0F6ZjNMdzcxTzFGTG1QdWlKZWlyYkpHaHFPdzdxVnhzWlpPVTZtYXJhbFBz?=
 =?utf-8?B?amtnS1RMcXMzekp0bER1ZFBZT2FZSUZ2SUV4MFE0UUNjbUpMenV5OEtkN09k?=
 =?utf-8?B?VlVmZlB0d1pEZDk1WllURUpGcjZDWk4xUDlHcDVxaHlWaytxbTJYTWttTGpi?=
 =?utf-8?B?TUJZZngvRyt6N0E5d2ZhT1hQVTBjS1RPM1pUaU5WWUpWOWlSUjdsSWxqRzd1?=
 =?utf-8?B?VGhoZGhkU016U3dLRzhBUmlRbEN1NSsyUUVlWUxETVFBSWlabm5uNHRnV3Yv?=
 =?utf-8?B?cHpSSFUyb0FVSTNxVnc1Q1BQNXZUcTVLQ0NiYmJYOGl1KzZMV1F3VUFGL3NE?=
 =?utf-8?B?WC9pZEFpbFR1aGFYVWZ0Z2hGYW1RQ0o5UENiemhNUkxEcVAwZlNLUGxIQjVD?=
 =?utf-8?B?LzJKclhnRzB0ZWtOZ3c0SVB4YisvZk9obWFOcjV0UDVkcFJQR3dLT1BjOXgy?=
 =?utf-8?B?Tmd0Q2wyTE5Da3NmMm16NVlBMW9xOGNEL08xZXlxQ0R1MXVoSVZiY0RhT01l?=
 =?utf-8?B?dlFuRlJZYlNjK2d5SXd6cmpaNGd4SUZCQTR1U1pwQno4ZmZsanI2cVROWUxZ?=
 =?utf-8?Q?Fx8PqWNEItUUZD+M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <016D043F443BB24B8C42FF1D48625AF7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QcEh5dB6S/Zpirc/5fgBMSOf044Ww3kFjVhWNvamGxwpbq8mm2qFZ+6QI7Hu3uyPHEwKOgQ4dPoE66CaPzz6fAdSYxUUG/ur591DLeO7khYlse+bBw/EAZfcxUHZwKbd840qfnE+7fFN1QNnByc3nsFxuAfYy9oHIZPN90Exw8dWGq0aksaa7aNM4ZuKQPhmWBMFXdEcDEjdWWGeDPcMXrj6obltxDRW3CuU4r38gr8YTPvQlsMUjyWb3yec72ksWTDt4dMSP3f7OjrNOqE7LoPLuyZVKNmlw5zyrlVdxd4MyHiEs9n5iuO5hjmT32TaK6ou6UopwXhmmBHhaVyQV9AOOsISFeSO2vtKk+9Y47Sj5DDJ1nCHOCtf2CUFHJXpvECjv01BP5HPLNPWrn7nHb04pBs2stRF+kav39YI4LRlJ87fWGiPzeFbZa9YvHOkHsHFnoJa4zF/XeRd/+yo4hVWbOJLty4JPp5A1pDQZIHVj8/9Cd+++lCsJxN3N4xYjIC5CDpflb+YUq1Y0DghnFmi95snF/iP7lJbFAhYo393WIRLRzJf24HP/PES07g5rN0yVaWKEFyHx41n6OhngN5J4I5Y84sTFzWbW+NE+EJB0Gv93SvOsReTlJhKM1B3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 122e3c03-e662-4a18-4ec5-08de57fda401
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 08:26:42.2769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHdx8lehsCa4th8l3skmTi7mA5G8kWBpGmQCEcLchnwCOxE/eh5sb+xugEi1QQnOuYZi1CqujWu2EApV0n1xQJ283HY7TD6Pw+9O6WflWLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7310

T24gMS8yMC8yNiA3OjQ3IEFNLCBqaW5iYW9ob25nIHdyb3RlOg0KPiAtCW11dGV4X2xvY2soJmZz
X2RldmljZXMtPmRldmljZV9saXN0X211dGV4KTsNCj4gLQlsaXN0X2Zvcl9lYWNoX2VudHJ5KGRl
dmljZSwgJmZzX2RldmljZXMtPmRldmljZXMsIGRldl9saXN0KSB7DQo+IC0JCWlmICh0ZXN0X2Jp
dChCVFJGU19ERVZfU1RBVEVfTUlTU0lORywgJmRldmljZS0+ZGV2X3N0YXRlKSkNCj4gLQkJCWNv
bnRpbnVlOw0KPiAtDQo+IC0JCXJldCA9IGJ0cmZzX3RyaW1fZnJlZV9leHRlbnRzKGRldmljZSwg
Jmdyb3VwX3RyaW1tZWQpOw0KPiAtDQo+IC0JCXRyaW1tZWQgKz0gZ3JvdXBfdHJpbW1lZDsNCj4g
LQkJaWYgKHJldCkgew0KPiAtCQkJZGV2X2ZhaWxlZCsrOw0KPiAtCQkJZGV2X3JldCA9IHJldDsN
Cj4gLQkJCWJyZWFrOw0KPiAtCQl9DQo+ICsJcmV0ID0gYnRyZnNfdHJpbV9mcmVlX2V4dGVudHMo
ZnNfaW5mbywgJmdyb3VwX3RyaW1tZWQpOw0KPiArCXRyaW1tZWQgKz0gZ3JvdXBfdHJpbW1lZDsN
Cj4gKwlpZiAocmV0KSB7DQo+ICsJCWRldl9mYWlsZWQrKzsNCj4gKwkJZGV2X3JldCA9IHJldDsN
Cj4gICAJfQ0KPiAtCW11dGV4X3VubG9jaygmZnNfZGV2aWNlcy0+ZGV2aWNlX2xpc3RfbXV0ZXgp
Ow0KDQpEbyB3ZSByZWFsbHkgbmVlZCB0byB0YWtlIHRoZSBkZXZpY2VfbGlzdF9tdXRleCBoZXJl
PyBJc24ndCB0aGlzIHN1ZmZpY2llbnQ6DQoNCnJjdV9yZWFkX2xvY2soKTsNCg0KbGlzdF9mb3Jf
ZWFjaF9lbnRyeV9yY3UoZGV2aWNlLCAmZnNfZGV2aWNlcy0+ZXZpY2VzLCBkZXZfbGlzdCkgew0K
DQogwqAgwqAgdGVzdF9iaXQoKTsNCg0KIMKgIMKgIHJldCA9IGJ0cmZzX3RyaW1fZnJlZV9leHRl
bnRzKC4uLik7DQoNCn0NCg0KcmN1X3JlYWRfdW5sb2NrKCk7DQoNCn0NCg0K

