Return-Path: <linux-btrfs+bounces-21150-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GnwSHk6XeWnSxgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21150-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 05:57:50 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 736EE9D1B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 05:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 490DB3005310
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 04:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A2933121D;
	Wed, 28 Jan 2026 04:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kEWsU8WY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fhOSiwO2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B66C330B2E
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 04:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769576264; cv=fail; b=axRAkjmmxBAuqNXueRC9G/8J7wPIw/GjzFmv0Iy0K9qfpDv9vsL1sPybtRIH6JDIM+GPYMb5my+U9vKsY1UZy4FIYmbBgIIU4ymgGXsIzsxEXbZ4Lt8umxgXwxErzsP8SmFusPIY63zQaALWa98+IegMYPBDmL+GjOycfFMTO3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769576264; c=relaxed/simple;
	bh=7ClpGZdjXgyj3qBtirpVOBui5QGc5ONlRc2FFxPiR8s=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q0LqnSoNkFhnr9lXXc2SOUuplquZCI8jN2fgC5CD13jpRHUsLYOXXvdNN4/A21McvXVYY4NJZDjpGl6SGBjUf23piZVxyErktJtfec/dNePyzRxisgQpHmtDNFHnMclcvsxMTdt+7/H0iXWZApwL/u/h1QpiWPMIpuJp+YYvxRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kEWsU8WY; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fhOSiwO2; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769576262; x=1801112262;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=7ClpGZdjXgyj3qBtirpVOBui5QGc5ONlRc2FFxPiR8s=;
  b=kEWsU8WYtFjaTP/TsXDKHB/fARcrVvDCiP5Cay25s2TRd58a7OQ1G00q
   /4oKryPMfpk017GmvqY1laEDlcvBgHR3F3J9TveVS8+Lncd6dTRScvFbF
   SSdW9JKueb4C+OUu6WBEeMDxwmw5nzhqD86BGB/LSZEj2mBoa0P3JrQUt
   PA0CBsVQ5gTF2+vUS8UqbA9464vsZPjw6rpZSvuxavk5Qg0efuJYp3ThM
   HzOOUv8osiGe/zwEKPzQ5B3lQO1iJbQ+zxA3Roxrx+LVEei4snxQr5wWY
   O3Xc1dOv19xUcZHQPsT6sZAt3YPNz7Y/pMgEnyexrUTRnqJSrDbnaqrbn
   g==;
X-CSE-ConnectionGUID: m4jwai6oROi8rzKV9VWjIw==
X-CSE-MsgGUID: fhTfjkpxRL6GRwr/aVOstA==
X-IronPort-AV: E=Sophos;i="6.21,258,1763395200"; 
   d="scan'208";a="139610119"
Received: from mail-eastus2azon11010053.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.53])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jan 2026 12:57:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnMY1eRJDg/GjU7HF6/Tp+t3igEPL+nrZL/kOTu2IupWyPNdPu4M5zJGGhz0+mlDjiFe0gFELPtdLjsJ1vFvQlpL/V14Zg8L8v/wVXCmNvL7OL2/WzKvhQuGs8BpYEdYoiLcX9p1+hS2KyeK9FACe6NqDbamjewIJftMZ54BHtlUxfzOUGe+mRJ3XSr7Mb44rBGTlpZlzg+fo3bxPfSiVPodzHHGmznSLz4UFOKy7t4k6X4mxjMi0Fhg+BdrSJk0Qj0pRfX8Nj8XqYMZzq43mT/gcxVoZx/8yNp8125sdO+1PJClXkARZmStX0klzUDp9n7sqIyWpWHqF35I8ImSwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ClpGZdjXgyj3qBtirpVOBui5QGc5ONlRc2FFxPiR8s=;
 b=DtSe66BAkY8GU8owpTIGQcTGkg8RhAI1le3YY0uLCDp6lPBMrrpFqWHG+HjxXzisp13nUciEuJVRDVEdlkjWD2ltY52HKKA1m8yBmvXiAIqqjO9ebhhOBHU8H9Q2ZBiBHPGN9/Fyymn+fcySVTszgrvCMeA4mEUQlGa8ybIKyRdm5zA0nPDAuHcBBPyBcy5Ks++7kEySapYp8Mtx2xUbd12dtUy0smxh1RjuMUkYBNqpRy63TjNazZs9fljIhwgztqaATrfFa4eeGdAtrk/m8LiqaN1F3wqvuZeNh+8MBc9NXJJoR6V+zUDcSrACqSU1yQS9dCApbJ3+rPNhPLkcQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ClpGZdjXgyj3qBtirpVOBui5QGc5ONlRc2FFxPiR8s=;
 b=fhOSiwO2C5aADbjQoxLI070YYn4+M7qSLBdmAILeOQKHcaanyOxTbQKxKkwFpL0zfvMEYb8usS6mcJ2aCDM9J34ej+iIQZpMcNBZ1SLydssrqf2wHahUgWPIHQ0mPefTczBI6gpnkeAElG0D09fEDPitqd/5BAJz1kDB5hZi1dM=
Received: from DS0PR04MB9844.namprd04.prod.outlook.com (2603:10b6:8:2f8::22)
 by SA1PR04MB8828.namprd04.prod.outlook.com (2603:10b6:806:384::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 04:57:19 +0000
Received: from DS0PR04MB9844.namprd04.prod.outlook.com
 ([fe80::9647:6abf:8734:547a]) by DS0PR04MB9844.namprd04.prod.outlook.com
 ([fe80::9647:6abf:8734:547a%5]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 04:57:19 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] btrfs: tests: zoned: add selftest for zoned code
Thread-Topic: [PATCH v2 4/4] btrfs: tests: zoned: add selftest for zoned code
Thread-Index: AQHcjoew3YxSjMx+C0mTIqRbZ6FDJLVkMW+AgALWaQA=
Date: Wed, 28 Jan 2026 04:57:19 +0000
Message-ID: <DFZYEKB3Q294.7EZSMA3MBUU5@wdc.com>
References: <20260126054953.2245883-1-naohiro.aota@wdc.com>
 <20260126054953.2245883-5-naohiro.aota@wdc.com>
 <c217b72e-f416-4dd7-9028-7ac8233e3809@wdc.com>
In-Reply-To: <c217b72e-f416-4dd7-9028-7ac8233e3809@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.21.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR04MB9844:EE_|SA1PR04MB8828:EE_
x-ms-office365-filtering-correlation-id: a3e568a5-ce23-42fd-3f08-08de5e29b716
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZHQ3TE01Y1d1KzNQQ0xuOXR0bEZDKzBrQjBYVUw5cU0xRk9WRkRiTUwyOTR6?=
 =?utf-8?B?UkcrRkErSVY5Z0F6VVQwb0p0eWp1c1BXQUgwVTNkUmdFa0VTcGp3eTlidExx?=
 =?utf-8?B?R3B1RkI5R2VleXBNSlJST2EzZWVQUXhVU3Zvd1BKVHRTeU9lT2hSWFR4YjQv?=
 =?utf-8?B?VDdldG9saytqQy9sRWhGVzYxb00zcWtRdm9laEtRbEhNSERDY292UVQ1TDVt?=
 =?utf-8?B?NHpsVVU1ZGdLRkx2UGxTNlo1aWpkSW92K1dDQ1lXNWg5eERBSWMxSzVROHVu?=
 =?utf-8?B?RTlNTVJHM3N5UmRoNmN1cUtVdmF3VkRraExMYytvTEQxNGVJRXVxRGxJK2lW?=
 =?utf-8?B?OEZyVGF1eVVUbU5CNGFPNi92RkNRLzNYV0U4azVibFp3Z1l2aVNnZkp4MWhn?=
 =?utf-8?B?SjJrUm5QUnJBRDEvK2Y5MVpXM1dpUFpyZ3JEQjkva0xUMkM3MDBBeTloeWRx?=
 =?utf-8?B?ZzY4enpCVnYwUCtvMU1JTG5jZDBaODlmYmxhSmZuQ0J5Yld4enR0WmhOQmpY?=
 =?utf-8?B?dTREcU04dU81TjRIRFRwZmo4elBYYzg1TytKcjI1b3VWazFkOHBUK0FvN3hS?=
 =?utf-8?B?SW5rM2tDRlFlWTgwcnVieUhvN1NKTW1CSWlnL2pwa2pWbzFBakUyYmR1Qndh?=
 =?utf-8?B?R2pHTGRkb2psT090NzN0dFRNT0wyR0s2ckN4b1pCdENVd3N0d09Pb0E4Nnlj?=
 =?utf-8?B?MS9JY0VNNXRmWGs1cm1nTzhaSVBMeVJHUXk5SlIzNXZxSXk0ZTB1YnBYUWFj?=
 =?utf-8?B?OFlHVEpLeklMVVBBZE1FeC9LazU5SzR6Tjdrd3JpbmRSZ202SjFrZmNia25X?=
 =?utf-8?B?eUM1Qm9xR1drenVyYUdaVHd3VVU3SkpNWnhvY3F4T2c1TVB3RFdPT3ZWZnlo?=
 =?utf-8?B?eEMyN1ZoN3dMeitHN3RqMnFjS1c1Y0lWN3dvQ3dodmhrY1FYZ0pBMWxiT05L?=
 =?utf-8?B?MFNqNW9za1BGOXgvYzcveTBWQzZucEUrOHJsdTFOS1hYUmNZSjE0eTgvSWI4?=
 =?utf-8?B?aUI5WlBZMCtuVVd0Uzk4azM1M3YwaFo1aSs4QWlDT0thUktQM3pMNXFaY0NW?=
 =?utf-8?B?ZGdWN2tXMUU3U3kzRis5YThKM1hqdFZNaGMwaGpEdUxsbDNHNGdiclB3RHlr?=
 =?utf-8?B?dGVzQzRXWW13UlpXb3lhVWM3MndWM25Uc3BIQzlUMkd5WFZhRHhibUpRdVZi?=
 =?utf-8?B?STVQcTd5amRIWnVDMllrdE0xMjdIbDFFdFppRGwrVEF4K2hDbVc2VVN6cWlu?=
 =?utf-8?B?eWlQWkRvUUdPZjZwQTIwZVM5bUVBM1dHNXdWZHJWMTZqZjVJeTBWRjRnTHVv?=
 =?utf-8?B?TjJMcGVnci9YZzhoQlRYN095ZDk5cHRQeXhaVVhmS0kzNzNDZnNhdEhhaEhu?=
 =?utf-8?B?bGVQOWw3WlY5UW4xYUQxUXpkT2R0NVJWNzBrN2tkcG42M05QSitSdkpxODdz?=
 =?utf-8?B?d2Z5U3lLUjJ6Zm04cGRROEI1MVVaUXBhQWgvQ2FEeHh2dHQxblQ3R0xhaFRK?=
 =?utf-8?B?TXZuQ1ZoaTFhMXZvbkRlK2c0Snc3RGx0aUhQdTlBYTcvVFVXWDFTc3JzcHZm?=
 =?utf-8?B?b25CaGlxUmhaVlkxL2ZBUER2M24yUnlMZUxOR1dISGp5aWw2MDI5OEZhOFpU?=
 =?utf-8?B?UGNRNEw0Ull3dE5SeHFzbDQzd1RFZ2dvY3V6b1gvVlBLY1ZzbGJSek44U2Er?=
 =?utf-8?B?OWMwdUYzbWhGOURDZTFpYTRTVVd2dzBERTJoYm9zVUJ6QWU3MXI1U0VTZHNq?=
 =?utf-8?B?aUpXdnlpV2lYUGZlM2dvVlhmYjA2SnZ3YVZOcE51emhEUzhsd0NKTDA1bi9G?=
 =?utf-8?B?ZjI1YlR4ZWZ4UkVNd3Y3KzF6VE9wM0xkeXVaZU9TU1NwWCtKOFFlaWlRbWU1?=
 =?utf-8?B?UWw0WHR1S3p5TlY3NVd5bnkrYTJ3MWl5VUV0NDRIOFJLY1lyN2xFMnVScEE1?=
 =?utf-8?B?WmVtZ0xvVGtzR3hrRlRrR2NLcXZBbm5uaEQrODVvUkZ5OUVJS2NyYnBUem4z?=
 =?utf-8?B?SytVQ1BINC9lOGZVb0dpWjc2eGhRbzBMRjlFN3BNRGs5WTM5dFA5TXR6cGZj?=
 =?utf-8?B?SmtFTnhrZ3FJcWNyaWhSTFYzeW1SdUlja3pFYkVhVFpteTJkVjB4UHJpOXVS?=
 =?utf-8?B?SWZ6VWljMzJWek9pTjl5UVg3Qk1zYkFJRnVrQk9odTl2aGdOeDh2MUtaeDhW?=
 =?utf-8?Q?ccxTkKX+fQuTjKO+o/k2iO8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR04MB9844.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmFxaUh1bFc2STVJczNkek95V3I4YjJSNFdsUWwyUng3T0U0YituVU83dFB5?=
 =?utf-8?B?clZsbzV2ZnR2WGFFODZQeExCb1k3U1czd0lSNmorUFVJaGRDQVBXMGU0d2dS?=
 =?utf-8?B?dzc3VEl6NnFKbFZrbTQrcStPOUpGTnlMQjJTYmFmaENNNHo3UXMrWGh5SEkz?=
 =?utf-8?B?QXRSUnVlSWxsODBvOGcveGtKWWZUbVVSRWhFUVNmN24vWjJWZGxZdWo2Z2V3?=
 =?utf-8?B?blcxRklhTWRGdjdBNFh0QmNyd000VU1LK1VyUkZRTGRlTkJzZEdzSzF4bzBm?=
 =?utf-8?B?WG94eVFLcVBxME9hR0lHNExqMytxTDN3OTdocWlnQVdTbnlRSmJRRUc4NzVY?=
 =?utf-8?B?ZURpbVl2V1B0RzdieEpaWGM5cVdVdlB6Uzgvd05JRUs5VThOd2p1Uk9QVmJV?=
 =?utf-8?B?S2R2aFVDS3NTWTZ2SWRLVWNJZEIvMS9mb3RiTm15S0RCTkNjNTVtU1gzbjBy?=
 =?utf-8?B?ZnZ4QVR3RU52UXpKV3ppdUdpdkhLdmNCRVc3ck5EemtOUmVRUHJwSlpWVWU5?=
 =?utf-8?B?YWNvMWJmc2JaTG9UQlk3VndoYkpYQ3dnazQvRklkVHpUa3pZVXhUbTZOWVlN?=
 =?utf-8?B?YkRCanRFaWJqSFRaUXE5aWtsMzVQcU1LTUVGRFFCZVJaWVJEYmMyTS9ldVZD?=
 =?utf-8?B?MzA2ZnJVZFVIWUVPVnpEMktMUVk5c2ZENGhja3dsWkF0dVRxQjhyZTF4OENU?=
 =?utf-8?B?VFRBMmZkc0FWVUdqdGs2RjVKM2RhK3dnSStCN01Ja21ZUlJZT3ZFWjJNdjZr?=
 =?utf-8?B?Y0lYcFhUZzNVQ3pHakxNWG1iTXR5VFpJaGd6OHFNR00ya3Zlc0p1NE1DRDZE?=
 =?utf-8?B?Q2hka3VmdmZIMmxySjI2N1dZOUJsNlVtT2NuS2MzU2d0MkJGSDkvT2NWOGFC?=
 =?utf-8?B?dVBYMXJqTzF2S0VnSEgwUGNQREMvcE1PRDlSN3Y0TXZ5eDZtTjNlcGN4cVQ4?=
 =?utf-8?B?UDBuZk5hNGhGWWJkR0F5S1pRS1Urc1hYWjN6SGhpN0xpMW1nQ0ZrOVhLS3RI?=
 =?utf-8?B?ZGlmMWJtR1VKRThpRXI5V29mU1R6aWhIMGNGQ2VoVmJKcHpCYXBQK3VXc3ox?=
 =?utf-8?B?ekFNdk1hREVUZU92VVA4Ym9hUnN2UzhZOTFOemhpS3gvcVByZHhDSGw5czdv?=
 =?utf-8?B?OEQ1azFYMno5Y01tSm9QeXliU2xKSDd1Y2hWSWVnblFvVjRVa3N1UVRsYUpB?=
 =?utf-8?B?Q3BmSlFzTTlPRWZIUlh5LzYzaUZJMzBmRnNDTXVlNmhadkRWS0VjYVlxSTQ5?=
 =?utf-8?B?THEzcUpFOWdDUVdLbFFZV0pLWHQ1bWxzZ3BWOVhHU0pGMTE3bkU2Tnc0ZHpv?=
 =?utf-8?B?WjkxTVJYeE1wa3l5cjNUTnNnUEE5N3loaHFKRVc3WHUxYmwxeWhXOTdzbHIr?=
 =?utf-8?B?VHFLVlhYa0ZJVDJIZ3FJb0ZkbS9UakM2cUFiSjZYZHlVU0pmU1lzRk5Bb0NU?=
 =?utf-8?B?ZlpWYU8vNGJNSVdabWRSVmMwdnVrRFdCdzQ4V25qcHMxWUU1blY5bzJ6VlFE?=
 =?utf-8?B?K3pLQWExSHp4bHRHYnp1eS9PWTJ1cHdWRmpiVUVUOGtGbGtYZVh6cUtEZjNk?=
 =?utf-8?B?KzZKWEVQcXprQ05LMGtrZUJsTVVjNWtoam0yR3E1NjNKb3dvRTdBL3JBcVQ3?=
 =?utf-8?B?K0pYdVdXWnhjb1dGSHJ0Slo3K2VWMnVTcjNhTFZpc0NucVQ4SDNOb0dnTEI3?=
 =?utf-8?B?UUlNUlZTZENnNy9oYUFEajFBSnNlNmd2S0syZTBacHVSNzVmbXVZRjNUTlJo?=
 =?utf-8?B?OHVIanliRno2cXZ5RlpWdTZDdGxMTHc3YUtRZjVQTTN6b1pVdFJNT2pyRnRp?=
 =?utf-8?B?RGlqZjhpRVlQMmJvMHBycDFpOEhqbzExNHRLQ1Q1MzdSNUswdUFUWkwvVG5I?=
 =?utf-8?B?ZVlqdmxMQlhBWTVaSTJKQk02UnE2bUJobFdMSjNjNnVTKzcwUXVVcUdvMHAv?=
 =?utf-8?B?dHN2K0RTcU9vM2VSYW1RbmtMNGEyZ1pjYUZMSzNZNWxQZFhZNGNOcXNMcGlx?=
 =?utf-8?B?RXYrQ2JIQVNZdHpPYTZidUlSdlYrR2o2RW5zZjJpY1dGUXNpcHZBZmhYeDAv?=
 =?utf-8?B?UWkwMzJnNm1TVTg3TmZXZTdDMFZveXFJcWpPTmkrVVhrUEpMQXhKOUhvV0lL?=
 =?utf-8?B?QkVyRS90YzI3WDJWc3ZER2dZeXRPOFpIckptcS9oZnU5V2pkTWh4QmJ2K1B5?=
 =?utf-8?B?TUlvVnVwdjM4MGZ2RisrdkFLSTcrcGoxeU5nZmIzKzhtRThzSjVDY3NhNWRS?=
 =?utf-8?B?bVVWK3YzTFN4LzBVUkhUUCtHbFVaRFhrb0pvTGUySkwwRTRSdWtKaTZIc3dk?=
 =?utf-8?B?N2VpL0ZpQVg2OEs1U3F5U3ZGNFVJRnBVYkhCYkdYNlJibzR2RDBvUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C6E4FF2FF1AE444A9B5B19EDB72E914@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hoNnNanpV+Dij5qshQ9eQd6ruqOjK6N92Cstj8K2hTI89qgh+rerpcipY17GqBL+bqdVJPotQnYQOXq+3MtzN3YrH+ATSShdw2oqvzpK8rxgTkP+TWcMoVxttAf7FEzL4kc0foQ50YyAVlYiMTb/gkD3Muv2UUC2Khy/BRssAQM41Frr6eY7HlK67QVNL1O4iilkJFgZq6QhHc94bJkXlWjQl6FpyJGFzzYZGAdIFnbZz3tgBJ6F98gpEGTellJ4Y+ISBUaAH463rkn812/6HS4VQ02+VibeQpH9z3XFPwS7pJGbhCW8hQNmVII3aEMVseCXsHVFoQf0WaDU/ftki7+QZLfWsF9LeiRM+1SL9+Lt1lTrqnppZ0ohNQSFbyTL4nV7s0tqQtgP8FrikyU6GMJgw5VgN6TkAPYjEwo4jGJepALFFOi5iDiQeUs33WvIADP2rF4vUs5vD2j6k3GDjZkANU3jkHIu4zDvYaj/n29DNIerPftgbyYL5GXfkChbpCMsciPHqpSRaF/okS0pG+r56Nmj3qEulj5MFXAldIHXnn5K0YRcuNomA1yLhLBPrKtOD3X7GUYCVSj/kb8Grbqb4im2zZISTjf3pnc2DbmYHp+Vplr3rXYUpI+iq8on
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR04MB9844.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e568a5-ce23-42fd-3f08-08de5e29b716
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 04:57:19.1369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SffEZ41E/3cfauM0s8DHJt5MB7Dyu6UivTpwXmkgcvOpGQ5eh79IT1PCNMp2YasSlgUh7WrrpNjTuw96JE8ESg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8828
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21150-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Naohiro.Aota@wdc.com,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 736EE9D1B7
X-Rspamd-Action: no action

T24gTW9uIEphbiAyNiwgMjAyNiBhdCA2OjM2IFBNIEpTVCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdy
b3RlOg0KPiBPbiAxLzI2LzI2IDY6NTEgQU0sIE5hb2hpcm8gQW90YSB3cm90ZToNCj4+ICsgKiBD
b3B5cmlnaHQgKEMpIDIwMTUgRmFjZWJvb2suICBBbGwgcmlnaHRzIHJlc2VydmVkLg0KPg0KPiBD
b3B5cmlnaHQgKEMpIDIwMjYgV2VzdGVybiBEaWdpdGFsLiAgQWxsIHJpZ2h0cyByZXNlcnZlZC4N
Cg0KT3VjaCwgSSBmb3Jnb3QgdG8gdXBkYXRlIHRoaXMgbGluZS4gVGhhbmtzLg==

