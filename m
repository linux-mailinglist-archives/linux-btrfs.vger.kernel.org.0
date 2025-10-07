Return-Path: <linux-btrfs+bounces-17513-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D063BC1536
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 14:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E901E3C6BE2
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 12:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7560A2DC782;
	Tue,  7 Oct 2025 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FSuiTZDh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IEHBrlWv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FAF2797BE;
	Tue,  7 Oct 2025 12:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839276; cv=fail; b=cfb9vqxsljmytvjRXg/pvqML9nEBXc1tL/97T5kBK6APbLXlKOYEuFUWaIkPkw1D4n04sWWGE1j2xkQw9rk5jsN3n0gVr6L0Gs6VmvNlW7h94cRK5821UQ5cqvwBjIdcV3K5YD3WJeKuNsK/QO1LbRFWWl/anU84piJPpXLJ9a4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839276; c=relaxed/simple;
	bh=M3Nv93IMJsYkGwt4GqnEfrY0jQxcuEdzexVqAL5uuTY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oA8p3vg+VvGA20xF2u0c5QwnpK+k12AU+DnvHk3a/CisOo7fbwft1P6TyDlXnHW0ZzJLr1uqfMbA1xyPX219iPiDunO4fvCMKhcIokfYIH+WhOLn61Oc6D7dS6o43MaAD/T805VkrEXaxzReGC2NtmlH8n+JxIpA32P6AgK0sZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FSuiTZDh; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IEHBrlWv; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759839274; x=1791375274;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M3Nv93IMJsYkGwt4GqnEfrY0jQxcuEdzexVqAL5uuTY=;
  b=FSuiTZDhKrAkuW4sIwLywEqFg7vGNmw53r8L8iV3XHFM2WzgI0wvFOtu
   UHRBNZFLY7E+s2a6dseD/6fjiiqsm3JOINCWrAY0v3z6jycxfhP7Zg4dp
   AYRd4Mb75A0LEff4kQLi+bd8oqqZH7ypjgiP4n+baPzMQAL12gzaxdnXM
   ib5gjL579ugkMfP5DRyRxLS5XW2bRWXtazcwHo+FR0wQwvTTjbJY4wmag
   yPu8z8TVJzI+lzu7WGyiWEyGcEIj/HnyGfdjw6ef3vXt5tDybI/ceu7r0
   PrMDR/E+LDM9B8tvJM6Oo6YTXLyhIhNu3lx+DTdNmJNtL2hCcv3eOlXal
   A==;
X-CSE-ConnectionGUID: BtOwY3kiSK+HQkNKcex3sw==
X-CSE-MsgGUID: zDbuxbk8SNWKag0X/EFJsA==
X-IronPort-AV: E=Sophos;i="6.18,321,1751212800"; 
   d="scan'208";a="132615918"
Received: from mail-westus3azon11011009.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.9])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2025 20:14:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCGpU9EU0XnUTl1pC31TiLz18Fr1rydTUKpovFO1jWKoWEE+vfp1WsjUpu/FQ86HuqU5tNwbkKgANFoFbzWGwgX3tDWicSCxmFqx2nDsVR/iASYN6CSsx4M78f0YEAYl346i7H0u5Zj8kYYj09P7jhqLkNiuoDW/pyiMYwDf65QVyje7mGs6AbQM2SLIEjXaTC7zKjt6F+KuCOl6VeaFP2DctUWEGW6bEg0fArc6lBNWQ5/kQH3Hg0+Ovr/XQFGpAR0BsUfOlcRapacsMtZ4Cf4V4fSa2PWCG32wLbwcgdtGMectBzkxB4GcqLAJdbJAo9pmgNaSC6sI5r0+8TRJHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3Nv93IMJsYkGwt4GqnEfrY0jQxcuEdzexVqAL5uuTY=;
 b=tFu0RxcSwaQrFPmYdXhkeltJ+AQ8quTe2mAgAtYdAlwpMWaUULXnodRj0hbqI97bfWAkRMt3LWE/0AYA8yv+TLCgLGX+EaAbG0lsQS9Ul20VqfqAV5wtWfJmEM3Df+IdxSj6ytmp5EZbmDyT+g8aAtbbI7SRdXLOzoZ8xru1AwcYinArhNZKtMz68Yf03wNvw2yvJifo4QWSar8AuUZdnSH+loXo0PNh3+1nlR0G5uWRU/yAW+fJrgknv7n+EQw0U6mGnI6x5a1HaM7CSl2bU69FebEknpzOry4HRnJ5eHNgHM6LuzMPnh/fGyznu6A9ajbtUFJc2Wxan23hjw77hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3Nv93IMJsYkGwt4GqnEfrY0jQxcuEdzexVqAL5uuTY=;
 b=IEHBrlWvP7JrRVZduvCJ+iGJkG/Lc9AqytgdSPvw85EAuTb9V62roF1ciWIq+yHsaFfJBKx8Jw7qfhu1/h+o5DLLOyu7rNZd6EeCgIG0VgDjTkMS/9pzGB1ae53IZ4gJ1+eZzzECdh4NEVN+xH53E1h4KzXvqnCMsg+AA/IwzIU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS0PR04MB8761.namprd04.prod.outlook.com (2603:10b6:8:127::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 12:14:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.007; Tue, 7 Oct 2025
 12:14:27 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: =?utf-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mssola@mssola.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "clm@fb.com"
	<clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix memory leak when rejecting a non SINGLE data
 profile without an RST
Thread-Topic: [PATCH] btrfs: fix memory leak when rejecting a non SINGLE data
 profile without an RST
Thread-Index: AQHcN08Ff68oaDows0qTslh6hE1dNLS2d2IAgAAOe2CAAASQgIAAC/+/gAACz4A=
Date: Tue, 7 Oct 2025 12:14:27 +0000
Message-ID: <a3065e3a-41eb-4f1f-9dfc-2051885da734@wdc.com>
References: <20251007055453.343450-1-mssola@mssola.com>
 <e82bb44e-5f56-4ddc-976a-9ff268a5b705@wdc.com>
 <0a87083a-cfef-4cf5-a73f-465797fa5759@wdc.com> <87y0pmj4uc.fsf@>
In-Reply-To: <87y0pmj4uc.fsf@>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS0PR04MB8761:EE_
x-ms-office365-filtering-correlation-id: cc03c863-db44-4063-fd8a-08de059b0fe9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dHhHaWRLS1FFTmRFR0dwWTM5eWV6V1U4dlN1akhQSzU2NWppbFdtcHZ3aHhZ?=
 =?utf-8?B?c2haV25sYUhvcTVlNVcxRXRPQWp5Z0FZVFZiekc5Z011SGdsVzc2cEJLQzIx?=
 =?utf-8?B?SS9hWHVpWDY1QXBDOURuS0VSaVNzZjF2bFFpVmdiOHNYNjNPQWFJK214WjVz?=
 =?utf-8?B?NVZ6dXB0eEh6b0w3dnRucnVoeGZmdHg5engyVWdOTzQ0cDJZcmtQYjlzamZM?=
 =?utf-8?B?dU4vclhzVnVDbTBrS0hsTXUxb3hSS3pnZ1hHZ2NvS1hrMzRtc1kxcWR4RVBw?=
 =?utf-8?B?TEU2NDNWcGFGNEsrNDd2UlJOVmJWRjRtbFY5SnRvZVV5bU10ZlplQ3U5Tm9t?=
 =?utf-8?B?bEs0cFBnS1Vmak1ENVQ2cDJpcU5aanRHcFR4cWRZRGZ3RkpuT2J5Und4eU1m?=
 =?utf-8?B?NXRvcmtxUGkxb3g2ZCsvREo5c29WU0p6WE9JZG8wL1ZKUkg0WTkyL0tXS2Rk?=
 =?utf-8?B?ZmZtUUhjY05sOEtZaUZNRzRja3o2ODhjRWpvSitGd3FQdmRxczZxTWJncmlY?=
 =?utf-8?B?QXZrYnhMZEJrK3ljdURrcllsYkMxL2dhREZJV3VxaktlYlBWWTdxRE81Rm43?=
 =?utf-8?B?Mk1RdGdkcFpKYTMwWjVsdEtnaGVaVWd2MlkxWm1Vd0t0d2dzQjFScE96OTg3?=
 =?utf-8?B?Y3hwNDVlTDE3T0RncFV2VGNVdzRyNkpkOHg4YzBWeUNRUXR3R0NyL2R1Ymc4?=
 =?utf-8?B?eWdkTTl4Z0NDVXVXRTdVbGo5eHgvVm5jaDNVZitqN1h3anRnVHNZRjI1VW4x?=
 =?utf-8?B?cjBmYTFwL2tjSFpYMkozUElUdFplOSswK3hUODl5TnBHSEpybWR2cWN1VXkw?=
 =?utf-8?B?QVVQVStxVDRYS05XeTlMckNSYkV1TmNLQklMeDhTTVNoV1FlMmJiQjF1SXY1?=
 =?utf-8?B?Nkpjejg0TG1ZblYzTEV4S3RpZWpHVEJzMlRlOS9EMnR3R091dXNlQ2UwYzNQ?=
 =?utf-8?B?dVcxVW1WNDRCREN5R2s3SVlYa0hFb2xuNUJzQXNFc3MreDltMUhVYk5rV2Q1?=
 =?utf-8?B?emE5eEs5TTF2U3JlMFVZMUExTFhqN0RMdGxRbFlRcmp5MzEzbjkreUtQTEtU?=
 =?utf-8?B?elF3czhhdTFQWlFNZGpWYVl0SStzTm8rd1BacEJOdjIzVGt1WVFPUFFrUUpG?=
 =?utf-8?B?Q3ZzMGJDZURsam80RlRmbFlpcXZkRXp3YXc3TkEwdEhtMVd1V2V1ZXRVdTBP?=
 =?utf-8?B?UFdkRnFGWVlhcEgvMVFoK1lldmE2cklXNHlKVlRhaUc2aHBJQ1VialVDVE1w?=
 =?utf-8?B?Z0JYYnczbHJSekN4OVlLdkVsSmkzUE9oR09EeDRZREIveWMvZmwxU3Z1eVc4?=
 =?utf-8?B?UGJJOHVhM3RxN1h3ajB1M1p6U2VIRDRYbW5pTXY3SiszR1BWWXhTOWdqQU1x?=
 =?utf-8?B?NGhRaThrSFRZdjUvdVRINWNta09uTHFYZTJ3UlB3LzNVOUQ1dUg5NnBVRVIz?=
 =?utf-8?B?K1JkVXhBMklZMS9UdlN4MnMwdjYvU2g3dWJBQWhlSmRiV1gycnk5VDJ6cXQz?=
 =?utf-8?B?Mkc5OXhUZzBIN3d5TnhGbkZBdGk4RGZ4NXl4WVdEQUxmTjFGT0JFTE9UWEl5?=
 =?utf-8?B?c1FjT0tSYldqTVVEVGZFdmt0NVZTN2RFT1QyZFM2SUl4UHZFVlBmVG1EOXRj?=
 =?utf-8?B?VmVidmtMaTlvbUM1VzdYdm5qV2g5WG9WbkxBODI5WWFZVDdXNTVUeFVUSTcy?=
 =?utf-8?B?ZUNiOVFIa0I1dTVXejl0U2xPNjhCQUc2OVBGS2VIUCtROHlLR2pjeVIwTGJN?=
 =?utf-8?B?THlJUFV3Mkt4eEk4NzltaWp3NWJPSVNvd3FPSXo0WkV6VEQveW44UGdlSG5m?=
 =?utf-8?B?Ung0OVZNbWhPK0EvU3BQajEyVEU0YlZOZDh5VkdYQVNtRjMrSWFRRG8yNEJi?=
 =?utf-8?B?Z0JIb0N6TEJZY29DT2drcnczL1hiMTkvaklpZ1pUYUJNUVFjYWRjamJ4OVRC?=
 =?utf-8?B?Ukpubm52ZlBjNmtPVDVyWHVmVFQ1VjFicUpqM1pTMCtKOU0zNk5JVmtXdlBL?=
 =?utf-8?B?YVBxQ1FlaVlWaTQwMVVvNmNOQ3lYamRFZnZBRkRXeXJrRTkxYS9mYU1uUWN3?=
 =?utf-8?Q?XE00hT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkJMUm9rNTVVVDRJbUhQRkxVdEt1RURZNjBJb2hYdWE4THlwTjhGdU8yWVl6?=
 =?utf-8?B?Z256cGJyWnJEZ1BMUHgySW12Q2ltZGdFUnQrQTRQTlJGZmdNaUFiQnJMV3lG?=
 =?utf-8?B?REdkTk42M3l2UnUvdXV5Ti9ncTVucnU5RWNzMVNoaEwxM0lyVk85V3A2ZERG?=
 =?utf-8?B?a0Y0YitPTEdqS3VqYmQ2OGJjVTBkOWEyZ1JobXZHUG03dnYvQlRFNDNlSDJ4?=
 =?utf-8?B?QmhwZFVHeDlIMEtxQSs5YWNibHgvOUhpSkpNY1NNZHV3RUxScjVCS0k4eCtF?=
 =?utf-8?B?d2lwak1Fc1lhQlZPcWFrMGlFcmtHaWVGUEVtUXFXck1MWU56bXVRWWZkajMr?=
 =?utf-8?B?L2VrZDBEUmpmUVAyTTJnQkIraGpwbFV4eFA5YlhQcFNMdFlsalFDUDA1d21X?=
 =?utf-8?B?ZkM0L0FWZ0s3NVJqK2g5WVNsRm5mbjJ1cWZjaTcvSW9mNU9BUjB3RmthQ0Mz?=
 =?utf-8?B?NWxZOGR4NTRvVFRNV2ovQkxZRkl6MlpvRXl6YVRxK2hoTHJwc2JmNEREM0FJ?=
 =?utf-8?B?ODJQWjRnZzBpd3Z0d0djS1ovU2RxRkJIVVNmcFF5eUt0THhUb0p1QzlpTjgy?=
 =?utf-8?B?WUpJVEttTEFwd1BraGU0MHR6TnA1MS9YUzlxeXFSNFRMdENocTlnWkZPZ2Jv?=
 =?utf-8?B?OFprdUpBemRiZlpTN1R2dnU1bFhnaWE5T0t2MGxFK29JVmxya1FsdlljaWor?=
 =?utf-8?B?YmpkbnkyM0NCOEtMUmpzVUZzRVVKOWZRRk4vbk5kUytMYU1xWjZFaUxzTDFB?=
 =?utf-8?B?VzZzSVJKZFRhb2o2Wjh6WDJpbng5SWZlbVRKbTAxUURLNGhDWUI2eWNpTlFy?=
 =?utf-8?B?dDM5akZ0K2hUUzJMdVNYUk93UkJOT0hEamZZVFU1eVMzY1kzdWE5cy9qMytX?=
 =?utf-8?B?aWV5UDNFWWkwUkhENng3dGtIazQwZWpIWVpZenNYWEt0U2pRM2JJcjIvd3Nh?=
 =?utf-8?B?b2xPSFZWUTdQeWpnam04c1BOanRwM2JtaHhHcG1ZeUNFMytZRDRZS21ndloz?=
 =?utf-8?B?dEd3bldkL3lCaERwWXY3OXBCOFR6dEVjUVAydS92WmpSREdxK1NMbDNLMXpV?=
 =?utf-8?B?VXhzY1V5U25OczBnK3p1bHoxRlFDZlUxbVN2Q0RGR0w1d292Sng5SXNPZ056?=
 =?utf-8?B?M3JSNE5CSGlQT2UvMXFMRVB4WjNIUHI0dHNXc0J5Y0ZkRWVjdHh1dXFlcldi?=
 =?utf-8?B?bGRoaGVESldsMU9jUzZqcStTaVUxSEZPTURVSzZQVzdjNDBLRzZZWERTZ3dQ?=
 =?utf-8?B?cWhBR0g3MWU2N1ZheGxrUHVPOFU1by9nVHh6VjNrb2RJaGFkN0dLaXQrWXJX?=
 =?utf-8?B?MmVDTTlWY3lEVnEzRmtGUjcrQmJPVCs1dGtQeHB3RThJZlQxb256bG51bnU0?=
 =?utf-8?B?OGtYOVhHL2R1SmJpRmkvQzJwMW41R0V0QkJUdmhvM0R4bXM2QmJDV1dGWEVs?=
 =?utf-8?B?VW9DU3BqL3Jkd2Q0WnU3OFp3MFh5RWxZYUlQc1RNejY0dldMK3RFQmJYN0hM?=
 =?utf-8?B?WXRpUlk4alRxZ3M5SmRlNXFkU21MQUJlTXZtMHhzTHduV1NVVllxeUNhVHE2?=
 =?utf-8?B?Nml3RWZGWFR4ZTgwcUR5Ry9mbVN3TFI5OXEreDVGRUZqSHlQaUJCZzdDQUY2?=
 =?utf-8?B?bzZaUktWZUlYRUh6YlZGS0syYTd2UG1OUm5QQUxYblVreHlRZ3ZhcE14dktL?=
 =?utf-8?B?M0dEM0tTZmlyYzNMN0hkNHVlamxzTmxwM05NNThRemp3UFlKdkNTamFIeTFa?=
 =?utf-8?B?eFhhcEVWQUtWVTh3bFRFekN5L3R0MEpBVW0xVVlZWGNLNnl0dHM0cWxaT1l4?=
 =?utf-8?B?VGhBczBiVHBHT0p1NFFRZzU5ODJWRkNMcjJuYnlBbjZVWFhRcG5pWHFydWl5?=
 =?utf-8?B?WkdvcnRMYlpVeXhxWVllMXFRaTFIMndGQkpWQkpqNEVjU2gwM2xuTmJuUEhI?=
 =?utf-8?B?bTZwWjZUWVRRa2tEKzhxU1RmeWtDQnpZeEdNWTdCN2MxUHdaMUtiVlVIbWto?=
 =?utf-8?B?QlN3UmRFTUluQmJTOUJReWwvYnpPMjF0dkY3ZHYvRE1ERWM4bjlTRmhVbFAz?=
 =?utf-8?B?WUVrNUFoZGl1RFl6VzNFQ2YvSmQ2K3FjbDZqdEF4VnlhdGZHODNjb1RnMlZC?=
 =?utf-8?B?REtaMHJQVzl4amxYTDFNYUI2MlN0WWE1VXg1WFlUVUh3NzFrc2xBQ0hERHlS?=
 =?utf-8?B?UGZLS2tYQTBiazlBaUVlOWNJQ3JXYm9DNy9uY2RlWW5lbXZtb0ZKVldYVE5R?=
 =?utf-8?B?NkpHOGE3aEN3SDRabVg0cGprcTB3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1396A65B352A414CB5FDAA520437DD0E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NhT5tt8ETIsfl50+8t+sNHo6qE7KBaPU4ixMmzDYZ282KZSLHvzA6s5AGPZnoJXCMzvy6Cn2/O5mKaYqziVDTo9Cy579wUDF/E0uZCERoxJSIAq29im7XFxAOIEtViKK5xGfGAcHkuUIPm7HEYQJegi17SFnmrbV/UE/v678vxyG7jvBhuyZtzC4AwnyjYNd8SQV7+KTnSwsoCd0Dd/c+LrpgxXsjlQ4CQatPlvRNFNA7KMQ4OSQccpMM07UkYaYaEV+184lJmYCHNku80y7puhrvOSyouNMAlONrRRRHxEFfYR4GS46cGkwzeKh4FAQ72DhzWZyPHl/F4Wke7pPL6bsl85qWDDJwjnB8isiUlUTF42v9W98VC1zb+f83McO3qWtP0SMiVSV5BMiYkiLDHvHm/uTWsocnP3Vdhm3xmIBwMJ03sN3ZooSOBP3SZNfKUnIp2dD4Np0l8PUMw5n54ExKRvlaNIsSXjgWSIUU41GjlFDA5VVUO53dPt3/g98dR+arF7pxQ2gewnWMqpaiufQDPLejZtAA9In54JHaTd7PZCwc+zCe2SaerkUxX+T6r3j7fg9aOVK/6aSPeHZQPzKFzLNXO0ZRV3PHmyl3917inkldRsnlqmqh2YI3gRA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc03c863-db44-4063-fd8a-08de059b0fe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 12:14:27.7710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b+XQpw2k9xtdfb3nJTkC52DPAwFi8d8POKonoA/XwydasNaGKHEAan59Bm3dVoAl2FKEtu1ViKbSuwb/0nqwEElIUmt9YXg32pcqvCV4jxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8761

T24gMTAvNy8yNSAyOjA0IFBNLCBNaXF1ZWwgU2FiYXTDqSBTb2zDoCB3cm90ZToNCj4gSm9oYW5u
ZXMgVGh1bXNoaXJuIEAgMjAyNS0xMC0wNyAxMToyMSBHTVQ6DQo+DQo+PiBPbiAxMC83LzI1IDE6
MDUgUE0sIE1pcXVlbCBTYWJhdMOpIFNvbMOgIHdyb3RlOg0KPj4NCj4+ICAgSm9oYW5uZXMgVGh1
bXNoaXJuIEAgMjAyNS0xMC0wNyAxMDoxMyBHTVQ6DQo+Pg0KPj4NCj4+DQo+PiBXb3VsZG4ndCBp
dCBtYWtlIG1vcmUgc2Vuc2UgdG8gb25seSBzZXQgInJldCA9IC1FSU5WQUwiIGFuZCBydW4gdGhl
IHJlc3QNCj4+IG9mIHRoZSBmdW5jdGlvbnMgY2xlYW51cD8gSS5lLiB3aXRoIHlvdXIgcGF0Y2gg
dGhlIGNodW5rX21hcCBpc24ndCBmcmVlZA0KPj4gYXMgd2VsbC4NCj4+DQo+Pg0KPj4gVGhlIHNo
b3J0IGFuc3dlciBpcyB0aGF0IEkgd2FudGVkIHRvIGtlZXAgdGhlIHBhdGNoIGFzIG1pbmltYWwg
YXMNCj4+IHBvc3NpYmxlIHdoaWxlIHByZXNlcnZpbmcgdGhlIGludGVudCBvZiB0aGUgb3JpZ2lu
YWwgY29kZS4gRnJvbSB0aGUNCj4+IG9yaWdpbmFsIGNvZGUgKHNlZSBjb21taXQgNTkwNjMzM2Nj
NGFmICgiYnRyZnM6IHpvbmVkOiBkb24ndCBza2lwIGJsb2NrDQo+PiBncm91cCBwcm9maWxlIGNo
ZWNrcyBvbiBjb252ZW50aW9uYWwgem9uZXMiKSksIEkgZ2V0IHRoYXQgdGhlIGludGVudCB3YXMN
Cj4+IHRvIHJldHVybiBhcyBlYXJseSBhcyBwb3NzaWJsZSwgc28gdG8gbm90IGdvIHRocm91Z2gg
YWxsIHRoZSBpZg0KPj4gc3RhdGVtZW50cyBiZWxvdyBhcyB0aGV5IHdlcmUgbm90IHJlbGV2YW50
IG9uIHRoYXQgY2FzZSAodGhhdCBpcywgbm90DQo+PiBqdXN0IHRoZSBvbmUgeW91IG1lbnRpb24g
d2hlcmUgdGhlIGNhY2hlLT5waHlzaWNhbF9tYXAgaXMNCj4+IGZyZWVkKS4gRmFsbGluZyB0aHJv
dWdoIGFzIHlvdSBzdWdnZXN0IHdvdWxkIGdvIGludG8gdGhlc2UgaWYvZWxzZQ0KPj4gYmxvY2tz
LCB3aGljaCBJIGRvbid0IHRoaW5rIGlzIHdoYXQgd2Ugd2FudCB0byBkby4NCj4+DQo+PiBCdXQg
aXQgc3RpbGwgc291bmRzIGdvb2QgdGhhdCB3ZSBzaG91bGQgcHJvYmFibHkgYWxzbyBmcmVlIHRo
ZSBjaHVuayBtYXANCj4+IGFzIHlvdSBzYXkuIEhlbmNlLCBtYXliZSB3ZSBjb3VsZCBtb3ZlIHRo
ZSBuZXcgIm91dF9mcmVlOiIgbGFiZWwgYmVmb3JlDQo+PiB0aGUgYGlmICghcmV0KWAgYmxvY2sg
cmlnaHQgYWJvdmUgd2hlcmUgSSd2ZSBwdXQgaXQgbm93LiBUaGlzIHdheSB3ZQ0KPj4gZW5zdXJl
IHRoYXQgdGhlIGNodW5rIG1hcCBpcyBmcmVlZCwgYW5kIHdlIGF2b2lkIGdvaW5nIHRocm91Z2gg
dGhlIG90aGVyDQo+PiBpZi9lbHNlIGJsb2NrcyB3aGljaCB0aGUgYWZvcmVtZW50aW9uZWQgY29t
bWl0IHdhbnRlZCB0byBhdm9pZC4NCj4+DQo+PiBObyBpdCByZWFsbHkgc2hvdWxkIG9ubHkgYmUg
cmV0ID0gLUVJTlZBTCB3aXRob3V0IGFueSBuZXcgbGFiZWxzIEFGQUlDUy4NCj4+DQo+PiAxKSAg
dGhlIGFsbG9jX29mZnNldCB2cyB6b25lX2NhcGFjaXR5IGNoZWNrIGlzIHN0aWxsIHVzYWJsZQ0K
PiBJIGRvbid0IHRoaW5rIHNvIGFzIHRoZSByZXQgdmFsdWUgd2lsbCBiZSBjaGFuZ2VkIGZyb20g
LUVJTlZBTCAoYXMgc2V0DQo+IGZyb20gdGhlIHByZXZpb3VzIGlmIGJsb2NrKSB0byAtRUlPLiBJ
IGJlbGlldmUgdGhhdCB0aGUgaW50ZW50IGZyb20gdGhlDQo+IGFmb3JlbWVudGlvbmVkIGNvbW1p
dCB3YXMgdG8gcmV0dXJuIGFuIC1FSU5WQUwgb24gdGhpcyBjYXNlLg0KDQpJIGRvbid0IHRoaW5r
IHRoaXMgbWF0dGVycyBhdCBhbGwgYXMgdGhlcmUncyBzdGlsbCB0aGUgZXJyb3IgcHJpbnQgYWJv
dmUgDQooZm9yIGJvdGggY2FzZXMpLg0KDQpBbmQgdGhlIGNoZWNrIGlzIHZlcnkgdmFsdWFibGUs
IGFzIGl0IHNob3dzIGEgZGlzY3JlcGFuY3kgYmV0d2VlbiB0aGUgb24gDQpkaXNrIHJlcHJlc2Vu
dGF0aW9uIGFuZCB0aGUgaW4gbWVtb3J5IHJlcHJlc2VudGF0aW9uLg0KDQpFc3BlY2lhbGx5IGEg
V1AgbWlzbWF0Y2ggb24gYSB6b25lZCBkcml2ZSBpcyBmYXRhbC4NCg0KPiBNYXliZSB0aGUgcmV2
aWV3ZXJzIGZyb20gY29tbWl0IDU5MDYzMzNjYzRhZiAoImJ0cmZzOiB6b25lZDogZG9uJ3Qgc2tp
cA0KPiBibG9jayBncm91cCBwcm9maWxlIGNoZWNrcyBvbiBjb252ZW50aW9uYWwgem9uZXMiKSBj
YW4gc2hlZCBzb21lIGxpZ2h0DQo+IGludG8gdGhpcy4uLg0KPg0KPj4gMikgdGhlIGNoZWNrIGlm
IHdlJ3JlIHBvc3QgdGhlIFdQIGlzIHNraXBwZWQgYXMgcmV0ICE9IDANCj4+DQo+PiAzKSB3ZSdy
ZSBoaXR0aW5nIHRoZSBlbHNlIHBhdGggYW5kIGZyZWVpbmcgdGhlIGNodW5rIG1hcC4NCj4+DQo+
PiAgIEFzIGEgbGFzdCBub3RlLCBtYXliZSBmb3IgdjIgSSBzaG91bGQgYWRkOg0KPj4NCj4+IEZp
eGVzOiA1OTA2MzMzY2M0YWYgKCJidHJmczogem9uZWQ6IGRvbid0IHNraXAgYmxvY2sgZ3JvdXAg
cHJvZmlsZSBjaGVja3Mgb24gY29udmVudGlvbmFsIHpvbmVzIikNCj4+DQo+PiBDb3JyZWN0DQo+
IE15IGVtYWlsIGNsaWVudCBkZXRlY3RlZCB5b3VyIGVtYWlsIGFzIGFuIEhUTUwgb25lLiBJcyB0
aGF0IHNvPyBKdXN0IGFzDQo+IGEgaGVhZHMgdXAgZm9yIG90aGVycyBhcyB0aGUgcmVwbHkgZm9y
bWF0IG1pZ2h0IGxvb2sgYSBiaXQgZnVua3kgOi8NCg0KWWVhaCBteSBtYWlsc2V0dXAgaXMgYSBi
aXQgZnVua3kgdGhlc2UgZGF5cywgSSdtIHNvcnJ5Lg0KDQo=

