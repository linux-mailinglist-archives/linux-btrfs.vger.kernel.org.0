Return-Path: <linux-btrfs+bounces-19515-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9682CCA317B
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 10:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53549310C8A2
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 09:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38723358DA;
	Thu,  4 Dec 2025 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TEY+KK01";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JMgOjEid"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425EB335BC0
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764841672; cv=fail; b=eYdJIz2lGN9Z6CVCOrc4Rg9QnMRDuLQ+SIg4KyflnvD3EEer5ZGJpLVxSHlHc3ZBUJXrcyspwjOWNCKnCmff+xV9IE20wnCxdBZ5s1HYlcygCmfrq5piK0lu2odDlMSmZdUCzfuVV6ww1wpKyhaIdlMSqx9H3pLp8tT6wudzVa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764841672; c=relaxed/simple;
	bh=IJKHqwDNqZuI9MgzsG28AnDdyvM5UuvCrC4fkUv3mZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VBnz52IkBCJRCMnypJVw3MDxluA7GjpHngGW2gu/7WYIqqM9D35zOJUQ3WoodUxRJRf2enhCz+wcyjPZjj2DJEYdEVsOH0+gVplCBN2FjNRcUhEC5UuCXsRCz66wMpWPgpow8CMymfzqLOafv/q0KYbkFkXRGiDZPz9Xh/IiyOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TEY+KK01; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JMgOjEid; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764841670; x=1796377670;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IJKHqwDNqZuI9MgzsG28AnDdyvM5UuvCrC4fkUv3mZA=;
  b=TEY+KK01B3ptzkvAMrIxR867az9xDjkbr6wDCYKyA0CKZSWH/hb21X7t
   RsF+trrUVdlqDsOaJzJgNh8viX1L1pmLsXLjwYfWyo7aN3ick7+UzRskV
   uraJLszPP4DS2841NsfzoKFUDLvnkRsNEWPDCJ3BQRZz2TfjCrdeuqQTn
   vtF1aQ6R2fviDI6Srn2iJkmjmvN4QLDLcdtw/w5M50NtwDRTSxYJdb/3b
   H8J4BvcbZ9wvvsIsXP8tcBGdeozdw0ysQ5ilGItS7eE+YgYnSDnOP84TW
   NnmNDSampj2MIcxi8U2IuKfWPJM7t7QgZ3ex4PEiPmQMUk27xbQ4KnmRg
   A==;
X-CSE-ConnectionGUID: oCzxRbM1SDOIwBgwdMil9Q==
X-CSE-MsgGUID: CMPRTC99RlqRPUJ5Bzx+uA==
X-IronPort-AV: E=Sophos;i="6.20,248,1758556800"; 
   d="scan'208";a="135894547"
Received: from mail-eastusazon11012019.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.19])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2025 17:47:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=et/iRkzQNkhd1pYKmoF5kiKeWYgqoQvuws0bgGgxR+7v2IqmL9S9LILySkuf5176u8UR8YKygmhTLmJugnMModkKS5Mh8SqYQrLr3QFZqfMgJVdF29p/0R9X0wO4JjrRnDHJ5AZ1RUrtDoGBJYPo2FlqNPTHj6pGTIdLAJ9+lQ/OjXmNoyGjkmgtRbaeFYeNuPY204Z+1+M9oG4mYUasPucOmC8FGn9SZp5XR/oMVL0dI6GFTGxKh24l7dxn0r6bKsASNmi6uaban4g7Xv5XQ158DtehT7yzWuqZsxzkH0Qu8UV+s3aJBxG85mndIfX5RN9JNCUxufY4UjqsBcanyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJKHqwDNqZuI9MgzsG28AnDdyvM5UuvCrC4fkUv3mZA=;
 b=gen7AbQH3V33tFdXx5Io5aJuCD3JADdTqO7BrXow6oOrZf9sRot+kwzRGFNyh/yIroeXEB1UVqr8PzlKgXvCpnUg+Zm3PMaJbik5k2iVvB/vPXlvjJFmXp39xH5TMrwHf1sfUeBiUpKr72ko6HpmuUFNLYxQLS8c9/E2oCVKFLUyAFNn3xalmq97606Nq3J3I+LqofAWNPaIo1JC7E4BuQtYV1XBCHTBOXq4P1T2IM+IvkvQKkEU1tNB8cL5iGtsP6LUbBG3JtFUuysvt4vQEXBITm+GZqdJy4n61RG4imswXKEV69zUDbBHjMvtckLKXyyJj0I1D1sEYtdmxtu/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJKHqwDNqZuI9MgzsG28AnDdyvM5UuvCrC4fkUv3mZA=;
 b=JMgOjEidY5SCsnizp4FJ4XFFPU2PfKPqcGLUSIBrfjEsKEOwG5izI5krTR8p8Xle/VXoiy0ix7RSB+lHn1R6OqD/gEnFpcKjLAJthmFr4crzMNlR+E7cjwGMZtvqL9Dk9xPqgf9MOXx02rXok7YAVRH6D2bT+tPzWv/UNgCdH5M=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by CO1PR04MB9535.namprd04.prod.outlook.com (2603:10b6:303:276::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 09:47:46 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 09:47:46 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v2] btrfs: zoned: don't zone append to conventional zone
Thread-Topic: [PATCH v2] btrfs: zoned: don't zone append to conventional zone
Thread-Index: AQHcZFkr5YfjKh5HREiJ50FnL5d587URN4mAgAAF2YA=
Date: Thu, 4 Dec 2025 09:47:46 +0000
Message-ID: <9864f40f-c23b-43c7-a550-49f26f3f5d53@wdc.com>
References: <20251203133132.274038-1-johannes.thumshirn@wdc.com>
 <20251204092649.GB19866@lst.de>
In-Reply-To: <20251204092649.GB19866@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|CO1PR04MB9535:EE_
x-ms-office365-filtering-correlation-id: 865448c8-d866-4d67-b51a-08de331a2da6
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WTQ4QnZocmdISzJ2bWV3S09CQm1pekV4MEcrV3UyTWNwY3dqZElhWnArU1cw?=
 =?utf-8?B?WGJOUU1GbEhoQzhHQmhIbVRINDlNbkcyMlM5WjF6cmF5a0RtdzhFR3liL09m?=
 =?utf-8?B?ZysyWjhXNWRZY0VwdFhZK3NPUTU1dHBLclZTcStvTVlMTzNhZkhUdEFEcGNm?=
 =?utf-8?B?WE11eEF6R29sbFdRbGpSZDRNeFR5Y2tIQ3diYm1nVUNxTE53cXU4alZPRHhy?=
 =?utf-8?B?REJTYXZFUHpzc1c0SVVGT1hWSHpOT1dxRHd2QjYrM013bURjSStRQ3Uyd1hI?=
 =?utf-8?B?ZzV5WHVPbm5xV0ExYzhGSWFkUmdXampWQVkzRkhOL0JQblJ6Y2t2U1dmamNh?=
 =?utf-8?B?Y0E0WXRQN3NoWWRRaEUrVmMzd1BadVJ5UFBWYjRMYU9FQWhrbkd6dUNTN2p1?=
 =?utf-8?B?TU5Eb2NyNjQ1dXhFTkVaMGZqck9VaGNKU1VDNHFmbDY2UHNDVHFrdWFQTUVK?=
 =?utf-8?B?U3dKc3I4bzR3bXRyWmxhRElHUUgvM2JOZVpaWFBHT2RiYTJGWjVGSzZVdmNQ?=
 =?utf-8?B?UElocFEyL3IvRnhCaVF1cGVHOVE4RjNWa3N4SERuYU9OWEtOVDRtRlIzNTZ3?=
 =?utf-8?B?VkwvSDQ4K0xydWYycTFkZFlNZ0lYTlhFVTdkTkZQSnUxbCsvZEhRQmNiMlYr?=
 =?utf-8?B?bjQ4cWI4R1oweFVVTzd3Mm5Ic0ZnZ01ZMFdMdnBiejRXK1FOR3padm4velV6?=
 =?utf-8?B?R0l5MXJ3Tzd0THlmNjdMT0xlYWlBUS8wY0VRU2J5TDhRenV3U2c0Slh5bzIr?=
 =?utf-8?B?NmFQS2FaWWVsM1dVdUIyaktKTW9ZcDBtWjVCc0kvTTN5UFBrQnFWZVBxNW41?=
 =?utf-8?B?enVsOWNiWXFxUTA5RkxtQldKNDN6UVVQWTJ3RTdqWGNSREhkUTNTUlhuZURE?=
 =?utf-8?B?ejI5QVJpNjQ3Wkt5NHp5RXhiM3NuaC9sSEw3K242azh4WUxPUFlUdUVuSVZO?=
 =?utf-8?B?b25jV2lxWWdnWG4yOWcyVTZodFdqdkFWUkJkWUxxQXN3V242dlVUblFCOU8y?=
 =?utf-8?B?c0lhdjRQQXhxd1BqRzRyTkIwYzBjSldacU03OW9QTnlHV05EdWhrY05TTXJa?=
 =?utf-8?B?cVBsSjlNdS9UemwwNDA2TmNDTUhEZWlHZFFYUGlNUkR4eWJYdHJvcDhZdEcv?=
 =?utf-8?B?bS9Hb2NPTGtvSzYvWFErN3Q4eFZwWUFqZE5aR3FxVG5DYmVrSDUvRzVsalBY?=
 =?utf-8?B?b2R5R3JQK2J4TGJJYXJSZmorT2JKcjRDRytGZjI5NWVobFRTK0FkcGN3OFFF?=
 =?utf-8?B?ZGpiMllvQVA0bHJiMGROSG94RVhJZ3dQNUFrUHVCVTVNQ3dDazNBZUt4eWFh?=
 =?utf-8?B?ZGJ2TDFMRW4wZldvZ1RueXIzL0pkVGxJQ0NCU003eHRKZmNVMlMwZkZ1OFI2?=
 =?utf-8?B?a09ZZEw3RU9OVkpHNzkxOVlFdERhaHZhK2o3dDQ5Zm1aYkYvUWg5OHdGckRE?=
 =?utf-8?B?VnlNNEc1citjMjZXdnlkd3phUVdwTEptQlIyT1ByUGJxRXgraHBGZXBiNlBI?=
 =?utf-8?B?VHBnM0swcDgrMUI1Ti94dFM1NEZlQWtyOW9LdW9zSGFFaWxTQUc4MHdJTnRZ?=
 =?utf-8?B?WmphNW4vRGZhdFVmT0tuSHpOQXNHalhqSnNmdkVkRnBBdkhjQ253R3BHZDRZ?=
 =?utf-8?B?N1l2N3RYYk5SLzhHeHJNc1dsUjZkTVRndVFhNndWcHlLMUhuSHY2Y1RFZk5o?=
 =?utf-8?B?YmZSSGI4Vlh0c0k5aU9TTUt1MzZoNGZ3cnZzemp1b0hrMmNGdEFNdHFIY1lr?=
 =?utf-8?B?VW1sUEdYbUNhWlNDWjd6bVhUdTkzdkc0TERkL1ZlNHhKRVdFMVFJMlpLNXdk?=
 =?utf-8?B?TU5rdkFnbWxkT1hjeG9CbVVVVG0vV1M4bTNYT2E5b2JQL2N2UnRlaGtuMFJ3?=
 =?utf-8?B?Y3c3RFlLYXFua21HdHRRdnptRU9MRWxEMy8rM1loalZsUE1FSHhhQ0l3Q2JX?=
 =?utf-8?B?MCs0Y0xORlYvTlhweXhERU9rdndrbGpqd3AwR3Z6bWxmbTlsSU4xdXVJRS84?=
 =?utf-8?B?N1ZLQVFxYmNibDJyUDJaY3JSQXhwQW0zTGlUYWxMQ05mSE1UQ3hBYmRrdWFV?=
 =?utf-8?Q?xngQJL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a1U5eVdkanZIYWtWZ1ByOHdENkREMEJvK0NsdWtBeW9pelFXY2lGU0wvNmVy?=
 =?utf-8?B?OTlnUHlpZW9wcnk5c3JYaDU5Yk54NlJtemlwSzZSQ3VncWtPVHhWMmtiVFph?=
 =?utf-8?B?YTN2VzVQaHJLaWxPNTFJdUhKSXhOVENidi9ZVm1vZm5FSGVneDhOTk1NdlBx?=
 =?utf-8?B?WWhWRDJPcTFna3E4ZnIwK2dWbkxtU1pPWmF5YWUxRStrVFVNUUhGU1AxUCtj?=
 =?utf-8?B?MUhUUlFLcFJEa3dFVitGeFAxSkJNZ0RHQ1kxQSt4V0tQVHpvTlI2ZEpaN2ht?=
 =?utf-8?B?UWpFeDdBT3luMWo2RElHbUN5Q3NpTTJyUTFFblN2SmorRnhjYU4xbEJvcmFy?=
 =?utf-8?B?ZHRPMkMxMlptVGpxSGthaUt4bnJYU0t6TnJNN2Q1RlpIUEw4UC9SRnlsdzBZ?=
 =?utf-8?B?Y1FUT28vdXQ1RlA0ZkZsYnFZckRhT2V4QStPdEd3RFcxeGNhekcvaWx4Wkx2?=
 =?utf-8?B?VGlXeUNiTExzREF4VFk4cDBwbUY3UjB3VmtEQldwekU5V1I2UG16NnJlMW1n?=
 =?utf-8?B?eWxDWUFLMTF3ZHFMQmlnT1VpSzM0ODRObUs0V1pldkZuTmdPMGwreXpmNmFW?=
 =?utf-8?B?YjcvOER4Q0NnSXZBU0Z1elFxWEcxZ2NpRVZsK1c1UUdHVHl2NTM3eS9nRWFz?=
 =?utf-8?B?b2I4dWwwdFNrNm9jSVBHT1IvYi84eWhIK283TXVMYzk1YlVJWkZnalh4ZnNN?=
 =?utf-8?B?WnVzMzJmS2pSZi9hcTlpU21BVWZPdGZteGtGMG1RWFA5SEp1enRCb01QeEJF?=
 =?utf-8?B?M21pL0I2c3ExcjNHVHVyWk44TGxENEFjb1hTM08xUUozR0RtajRQYTdtV3R0?=
 =?utf-8?B?WU1uRHB1WGdLRmVCZVdUVDBrVVZ5VXF6ZHFtRmFnc0g1eUkyREkvaG90eERX?=
 =?utf-8?B?cUt3eVR1MGxlT2p0OXdlRDdrbmIvZ3RMVUdyNTBCWE9CUXB5TFdOUkY2WWZR?=
 =?utf-8?B?OE42VlFHd2ZLSnJRaUIwZnlITXNLcmF4WVNoRnk5eE1XOThFdmd4STNVc2Uw?=
 =?utf-8?B?NWtSNlV5ejduVnkyUVBFOXltUlo2aG9WbHNqTXVVbVhPNVZkOEVrM3A1cytY?=
 =?utf-8?B?emVRTk9yb3JNbDR6Q053MFNramxxWnA1RGhaUWt6QkRNMmVpZWJvRU5rdkNq?=
 =?utf-8?B?QXdoNGhvTlpFOFZaVnJ5N1I2cXR4QU02NUVVTG0ra3d5Z2g5NXB1SFd4Mjhx?=
 =?utf-8?B?QUxwTkdoblZpOW1Dc1BYbFhQYUhnVVlRU09qUXVaL1RCUmEyTDkzT1NYMzNU?=
 =?utf-8?B?UHc3MzBkMTUrK0NVYU9EVm9SY0V5TzdHRXBodlBpZVp6S0k0OHUzczg2WHpY?=
 =?utf-8?B?TEdoODczTXQ1dHhyN1VEOW9jQU9KRDdhcXZLWXpySXA4NmVtL0M1ZVRjbkRh?=
 =?utf-8?B?Zmo2Uk5xeXVHbVpYcWZOK0doN1V2QzJLTFR4TjBkZ3lQV24zclAxV0puellO?=
 =?utf-8?B?OTR5V0Z5R3FoZ2oxUEtqQm1WQUhuQm1tUHg0Uk9nbFlrOWhzZ3N2cFFzT2tF?=
 =?utf-8?B?WVNJclZPSFhnbWxDVGc2bmVvbTQ0ckYxTTVueGUzSWE5WGpMK01rb3NGSnVU?=
 =?utf-8?B?b2F4c2YreVAxcVN6Y3BiOGh5cW5Qci9kK1NyZXZCRVVHOCt1RVBLV093aE1x?=
 =?utf-8?B?eUJWYkluS2VQRFhmMWpzamxYZ1ZXUXdBazVGQjA1bkpHU3JTWWxaMzh0SDlk?=
 =?utf-8?B?VXdSMWpGZnI5dlNUek9EWGd5T01XMk9UalVramduVUlWNS9GLy9RWGNNM3Np?=
 =?utf-8?B?MTRWbEd2ZjVkTW1YR1NGTUxmR25kR1RGbWVSNnhldjRvZGNBOFFQT2c5dXh3?=
 =?utf-8?B?bXRzL0cwNkpMSzJsQ1RPUURNbUt3QStUUkpDL3JTRmtIaHdGZTB0ajdLWGdI?=
 =?utf-8?B?T0pFY0lFOHRSdms5aTh6UGhHQTJXN0VXL1p0cDMrQjJ1d0NJUnRZb1oxRk9E?=
 =?utf-8?B?VngwQUYyYVE5bktDZFFLT0x6ODlQUjlEWS9xNDM0K2Rmbmo5Mm1yM3Z5UXd4?=
 =?utf-8?B?c1BnWFhKSFk5M0dLSExrTk12cW45ampsVmoyYk4wL3VxRkZhY2t0MHR2U20z?=
 =?utf-8?B?YzlmQ2ZudHUxQjFRQWtrUU9uekhqZXNBSGFuKzM4NW02OHpnUVhGMEJ0a0hU?=
 =?utf-8?B?cUVSdVB6MWxEMUJHajQxc0UybEM3TGpXSm9SOVoxbkRvOE9HcDNJOHNoL0FG?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABAB5F82D9E0E246B1431B2AF36B2006@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wOTvB3SKrIANOysaUv3hB5OAULHe/Na0ZIO2sVvgT2unVi9GgCvbSvc8XneMuWmJGx24IJ0okVbxH4sz2J+hIdQQWJDczYCyXyMtyU/aTFO3FmIEUE473Yt3J67jRXZiVAj6jOEnAjlC7ft/M+gJb27+3NR2LHz8xAXarLZUNCKOzZBIkl1OEiIAf8XAf0kVqZortT4VNFek2VU4js1ne6BakobIbEVr7YMbiGCtRVLjyyULMTv6KLB23C9oxFJs9P18OPRjtQRVPkx6em/L6bd5Z0J3/QA3p/xPNlCrAhwvYvUfWF8Wugy5U2TEZn1gUWlyQta1lxEbhKXYDbsUyKuAmNO8Lc7E1V0vRvaiGJUOOtZM1eQ3NH1/0d5CwRmiMf9PesHWGo7YT38pkBp5sTWwC0a+iKX6E+/uA2/RkIOelwGoOCoSXp6zy4xBeweSAq+cTWyWpxoAiErfyvO8n9/DBGcXK/4Z1ohyL7nsKqUMxPAXLPhku+Jh+tAxGNTd9WXrI77F9fXz37xF25STvAS3SCPWG8ulESLnXgeDdPwz9dXRS3EeDQ4jF/I2Q9rrybja2ZgLLaWuIZPE32te4WT/4ZDDG1mLNwjEkwWvKw7ehxZkHR0SXPNXzjXIk7Zf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865448c8-d866-4d67-b51a-08de331a2da6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 09:47:46.1226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sJ1NOOHoCYnFZo+cHOCrjFZa1TE+7ReYCN7wHwBM+t9AVmnpYNdA6o+hFmOPhmArYtEdbxNJpXBc8Qbab4nRBdIgbsDvMJ5M3EpjPpuRe+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB9535

T24gMTIvNC8yNSAxMDoyNyBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIFdlZCwg
RGVjIDAzLCAyMDI1IGF0IDAyOjMxOjMyUE0gKzAxMDAsIEpvaGFubmVzIFRodW1zaGlybiB3cm90
ZToNCj4+ICsrKyBiL2ZzL2J0cmZzL2Jpby5oDQo+PiBAQCAtOTIsNiArOTIsOSBAQCBzdHJ1Y3Qg
YnRyZnNfYmlvIHsNCj4+ICAgCS8qIFdoZXRoZXIgdGhlIGNzdW0gZ2VuZXJhdGlvbiBmb3IgZGF0
YSB3cml0ZSBpcyBhc3luYy4gKi8NCj4+ICAgCWJvb2wgYXN5bmNfY3N1bTsNCj4+ICAgDQo+PiAr
CS8qIFdoZXRoZXIgdGhlIGJpbyBpcyB3cml0dGVuIHVzaW5nIHpvbmUgYXBwZW5kLiAqLw0KPj4g
Kwlib29sIHVzZV9hcHBlbmQ7DQo+IFRoZSBjb2RlIEknbSBsb29raW5nIGF0IGRvZXNuJ3QgaGF2
ZSBhc3luY19jc3VtIHlldCwgYnV0IHdpdGggdGhhdCBhbmQNCj4gdGhlIGV4aXN0aW5nIGJvb2wg
KyBibGtfc3RhdHVzX3R0aGlzIHdvdWxkIGdyb3cgdGhlIHN0cnVjdHVyZSwgd2hpY2ggaXMNCj4g
YSBiaXQgdW5mb3J0dW5hdGUuICBFaXRoZXIgbWFrZSB0aGVzZSBib29sIGJpdGZpZWxkcyBieSBh
ZGRpbmcgOiAxLCBvcg0KPiBqdXN0IHBhc3MgdGhlIGZsYWcgb24gYW5kIHN0YXNoIGl0IGludG8g
YXN5bmNfc3VibWl0X2JpbyBmb3IgdGhlIGFzeW5jDQo+IGNhc2UuDQoNCkluIG15IGNvbmZpZ1RN
IHRoaXMgaXMgaW5zaWRlIGEgNCBieXRlIGhvbGUgKG1ha2luZyBpdCBhIDMgYnl0ZSBob2xlKToN
Cg0KDQpzdHJ1Y3QgYnRyZnNfYmlvIHsNCiDCoCDCoCBzdHJ1Y3QgYnRyZnNfaW5vZGUgKsKgIMKg
IMKgIMKgaW5vZGU7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyrCoCDCoCDCoDAgwqA4ICovDQog
wqAgwqAgdTY0wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZmlsZV9vZmZzZXQ7
wqAgwqAgwqAgwqAgwqAgLyrCoCDCoCDCoDggwqA4ICovDQogwqAgwqAgdW5pb24gew0KIMKgIMKg
IMKgIMKgIHN0cnVjdCB7DQogwqAgwqAgwqAgwqAgwqAgwqAgdTggKsKgIMKgIMKgIMKgY3N1bTvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qwqAgwqAgMTbCoCDCoCDCoDggKi8NCiDCoCDCoCDC
oCDCoCDCoCDCoCB1OMKgIMKgIMKgIMKgIMKgY3N1bV9pbmxpbmVbNjRdO8KgIMKgIMKgIC8qwqAg
wqAgMjTCoCDCoCA2NCAqLw0KIMKgIMKgIMKgIMKgIMKgIMKgIC8qIC0tLSBjYWNoZWxpbmUgMSBi
b3VuZGFyeSAoNjQgYnl0ZXMpIHdhcyAyNCBieXRlcyBhZ28gLS0tICovDQogwqAgwqAgwqAgwqAg
wqAgwqAgc3RydWN0IGJ2ZWNfaXRlciBzYXZlZF9pdGVyIA0KX19hdHRyaWJ1dGVfXygoX19hbGln
bmVkX18oNCkpKTsgLyrCoCDCoCA4OMKgIMKgIDIwICovDQogwqAgwqAgwqAgwqAgfSBfX2F0dHJp
YnV0ZV9fKChfX2FsaWduZWRfXyg4KSkpIA0KX19hdHRyaWJ1dGVfXygoX19hbGlnbmVkX18oOCkp
KTvCoCDCoCDCoCDCoC8qwqAgwqAgMTbCoCDCoCA5NiAqLw0KIMKgIMKgIMKgIMKgIHN0cnVjdCB7
DQogwqAgwqAgwqAgwqAgwqAgwqAgc3RydWN0IGJ0cmZzX29yZGVyZWRfZXh0ZW50ICogb3JkZXJl
ZDsgLyrCoCDCoCAxNsKgIMKgIMKgOCAqLw0KIMKgIMKgIMKgIMKgIMKgIMKgIHN0cnVjdCBidHJm
c19vcmRlcmVkX3N1bSAqIHN1bXM7IC8qwqAgwqAgMjTCoCDCoCDCoDggKi8NCiDCoCDCoCDCoCDC
oCDCoCDCoCBzdHJ1Y3Qgd29ya19zdHJ1Y3QgY3N1bV93b3JrO8KgIMKgIC8qwqAgwqAgMzLCoCDC
oCA4MCAqLw0KIMKgIMKgIMKgIMKgIMKgIMKgIC8qIC0tLSBjYWNoZWxpbmUgMSBib3VuZGFyeSAo
NjQgYnl0ZXMpIHdhcyA0OCBieXRlcyBhZ28gLS0tICovDQogwqAgwqAgwqAgwqAgwqAgwqAgc3Ry
dWN0IGNvbXBsZXRpb24gY3N1bV9kb25lO8KgIMKgIMKgLyrCoCDCoDExMsKgIMKgIDk2ICovDQoN
CiDCoCDCoCDCoCDCoCDCoCDCoCAvKiBYWFggbGFzdCBzdHJ1Y3QgaGFzIDEgaG9sZSAqLw0KDQog
wqAgwqAgwqAgwqAgwqAgwqAgLyogLS0tIGNhY2hlbGluZSAzIGJvdW5kYXJ5ICgxOTIgYnl0ZXMp
IHdhcyAxNiBieXRlcyBhZ28gLS0tICovDQogwqAgwqAgwqAgwqAgwqAgwqAgc3RydWN0IGJ2ZWNf
aXRlciBjc3VtX3NhdmVkX2l0ZXIgDQpfX2F0dHJpYnV0ZV9fKChfX2FsaWduZWRfXyg0KSkpOyAv
KsKgIMKgMjA4wqAgwqAgMjAgKi8NCg0KIMKgIMKgIMKgIMKgIMKgIMKgIC8qIFhYWCA0IGJ5dGVz
IGhvbGUsIHRyeSB0byBwYWNrICovDQoNCiDCoCDCoCDCoCDCoCDCoCDCoCB1NjTCoCDCoCDCoCDC
oCBvcmlnX3BoeXNpY2FsO8KgIMKgIMKgIMKgIC8qwqAgwqAyMzLCoCDCoCDCoDggKi8NCiDCoCDC
oCDCoCDCoCDCoCDCoCB1NjTCoCDCoCDCoCDCoCBvcmlnX2xvZ2ljYWw7wqAgwqAgwqAgwqAgwqAv
KsKgIMKgMjQwwqAgwqAgwqA4ICovDQogwqAgwqAgwqAgwqAgfSBfX2F0dHJpYnV0ZV9fKChfX2Fs
aWduZWRfXyg4KSkpIA0KX19hdHRyaWJ1dGVfXygoX19hbGlnbmVkX18oOCkpKTvCoCDCoCDCoCDC
oC8qwqAgwqAgMTbCoCDCoDIzMiAqLw0KIMKgIMKgIMKgIMKgIHN0cnVjdCBidHJmc190cmVlX3Bh
cmVudF9jaGVjayBwYXJlbnRfY2hlY2s7IC8qwqAgwqAgMTYgNDAgKi8NCiDCoCDCoCB9IF9fYXR0
cmlidXRlX18oKF9fYWxpZ25lZF9fKDgpKSk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKsKgIMKg
IDE2IMKgMjMyICovDQogwqAgwqAgLyogLS0tIGNhY2hlbGluZSAzIGJvdW5kYXJ5ICgxOTIgYnl0
ZXMpIHdhcyA1NiBieXRlcyBhZ28gLS0tICovDQogwqAgwqAgYnRyZnNfYmlvX2VuZF9pb190wqAg
wqAgwqAgwqAgwqBlbmRfaW87wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKsKgIMKgMjQ4IMKgOCAq
Lw0KIMKgIMKgIC8qIC0tLSBjYWNoZWxpbmUgNCBib3VuZGFyeSAoMjU2IGJ5dGVzKSAtLS0gKi8N
CiDCoCDCoCB2b2lkICrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaXZhdGU7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgLyrCoCDCoDI1NiDCoDggKi8NCiDCoCDCoCB1bnNpZ25lZCBpbnTC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1pcnJvcl9udW07wqAgwqAgwqAgwqAgwqAgwqAvKsKgIMKg
MjY0IMKgNCAqLw0KIMKgIMKgIGF0b21pY190wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBw
ZW5kaW5nX2lvczvCoCDCoCDCoCDCoCDCoCAvKsKgIMKgMjY4IMKgNCAqLw0KIMKgIMKgIHN0cnVj
dCB3b3JrX3N0cnVjdMKgIMKgIMKgIMKgIMKgZW5kX2lvX3dvcms7wqAgwqAgwqAgwqAgwqAgLyrC
oCDCoDI3MiA4MCAqLw0KIMKgIMKgIC8qIC0tLSBjYWNoZWxpbmUgNSBib3VuZGFyeSAoMzIwIGJ5
dGVzKSB3YXMgMzIgYnl0ZXMgYWdvIC0tLSAqLw0KIMKgIMKgIGJsa19zdGF0dXNfdMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgc3RhdHVzO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyrCoCDCoDM1MiDC
oDEgKi8NCiDCoCDCoCBib29swqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjc3Vt
X3NlYXJjaF9jb21taXRfcm9vdDsgLyrCoCDCoDM1MyDCoCDCoDEgKi8NCiDCoCDCoCBib29swqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpc19zY3J1YjvCoCDCoCDCoCDCoCDCoCDC
oCDCoC8qwqAgwqAzNTQgwqAxICovDQogwqAgwqAgYm9vbMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgYXN5bmNfY3N1bTvCoCDCoCDCoCDCoCDCoCDCoC8qwqAgwqAzNTUgwqAxICov
DQogwqAgwqAgYm9vbMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdXNlX2FwcGVu
ZDvCoCDCoCDCoCDCoCDCoCDCoC8qwqAgwqAzNTYgwqAxICovDQoNCiDCoCDCoCAvKiBYWFggMyBi
eXRlcyBob2xlLCB0cnkgdG8gcGFjayAqLw0KDQogwqAgwqAgc3RydWN0IGJpb8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgYmlvIF9fYXR0cmlidXRlX18oKF9fYWxpZ25lZF9fKDgpKSk7IC8qwqAg
DQogwqAzNjDCoCDCoDEwNCAqLw0KDQogwqAgwqAgLyogWFhYIGxhc3Qgc3RydWN0IGhhcyAxIGhv
bGUgKi8NCg0KIMKgIMKgIC8qIHNpemU6IDQ2NCwgY2FjaGVsaW5lczogOCwgbWVtYmVyczogMTQg
Ki8NCiDCoCDCoCAvKiBzdW0gbWVtYmVyczogNDYxLCBob2xlczogMSwgc3VtIGhvbGVzOiAzICov
DQogwqAgwqAgLyogbWVtYmVyIHR5cGVzIHdpdGggaG9sZXM6IDEsIHRvdGFsOiAxICovDQogwqAg
wqAgLyogZm9yY2VkIGFsaWdubWVudHM6IDIsIGZvcmNlZCBob2xlczogMSwgc3VtIGZvcmNlZCBo
b2xlczogMyAqLw0KIMKgIMKgIC8qIGxhc3QgY2FjaGVsaW5lOiAxNiBieXRlcyAqLw0KfSBfX2F0
dHJpYnV0ZV9fKChfX2FsaWduZWRfXyg4KSkpOw0KDQpCdXQgcGFja2luZyBhbGwgdGhlc2UgYm9v
bHMgaW50byBhICJmbGFncyIgbWlnaHQgZXZlbiBiZSB0aGUgYmV0dGVyIGNoYW5nZS4NCg0KPg0K
PiBBbHNvIGdpdmVuIHRoYXQgdGhpcyBkb2Vzbid0IGFsd2F5cyB1c2UgYXBwZW5kLCBtYXliZSBy
ZW5hbWUgaXQgdG8NCj4gImNhbl91c2VfYXBwZW5kIiA/DQpJIHdhcyB0aGlua2luZyBhYm91dCBp
dCBhcyB3ZWxsIGFuZCBub3cgdGhhdCBzb21lb25lIGVsc2UgYWxzbyBzdWdnZXN0cyANCml0LCBJ
IHN1cHBvc2UgSSBzaG91bGQndmUgZG9uZSBpdC4NCg0KDQo=

