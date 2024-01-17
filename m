Return-Path: <linux-btrfs+bounces-1509-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481E08300D3
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 08:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B8761C209D7
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 07:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D0711CA9;
	Wed, 17 Jan 2024 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OyVcpBpv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="C3bgx9KG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3D111716
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705478095; cv=fail; b=c8ybX5wcDaXbVkHvZLffPNmJdlaUZJuClsx5RqRekMxmusjzD3N1/u2aN5GbRbA6stcOLOnxTrCV2CrVe9VVtlENKwhHw32s/q04lBAoZ46fYNzHsov/8bCTH0xN1XQnuRivK70cXl0DNRwV78t7qmrMfn8cFgccMUw99XqnqlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705478095; c=relaxed/simple;
	bh=timR0Qo23WKGwuaAfjjqvpX0xkhGFg+Lw6E0AXA3YO4=;
	h=DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:
	 DKIM-Signature:Received:Received:From:To:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:user-agent:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 wdcipoutbound:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=Wd1eD5KSr38jYvAOKy0zBPUybDUARKs4I5u02WFsZP78Ey/+T89tY4wXDmEtDq2GbKAxxQ8Vlk2mL2s/9Fv6oZyOjxUTT2YO/invgnvhmGely7XRbiUplStFRRUgR7H3OiIyYej6GBAmXOUGdrMls/a/KE1p1Bg+FTXBOm7wuOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OyVcpBpv; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=C3bgx9KG; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705478092; x=1737014092;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=timR0Qo23WKGwuaAfjjqvpX0xkhGFg+Lw6E0AXA3YO4=;
  b=OyVcpBpvXgDsdiJQ+gS1sIiFBzeBTzorfy6L/+R/L4r2vOkQzNTzc/b5
   L3RdyBXo340VVQsJivgYOG2eshWlAi93BYi85hpyQ0geipFjIAsyfbhlm
   hZB4DUVJ239nyi8DGfAwsZXCwCmMEpsmbgqe9v0uA/q4GrdkOiqltAoUg
   51kH6rfbGBtZFj/xc8wOKyODSeYsk1uCxQzrKmXAnUC35RpyVQj2hWoeT
   FaqlEjog1dUku/ZCI4/FJowPWr8MssRR6jbr7UHkZCOGw/palJYTjBCC+
   T1iMSS1fJQxElv2osZWR8aHe7rMxNYQyIvX7xV3o9v5itoa9C6AfFYdb+
   g==;
X-CSE-ConnectionGUID: Sd3uEEtSQWStqQ9kwe7qAg==
X-CSE-MsgGUID: LTl36FDjSv2esTR/ZDkg4w==
X-IronPort-AV: E=Sophos;i="6.05,200,1701100800"; 
   d="scan'208";a="7065071"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2024 15:54:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hd1AFwS6HoU5BloO62PLVulg3B1CMxiPoQCLptpBPcizxcQwyPFUaskeQ/CKAWlezq4NzK3mdckORW2+0sEJeUKKQfLFQr5IpbBzyik9wMgUgMTZYScv1Pkdh/vpMLb916g6r3qW6qQoPvWsInKkgA4HAWPEjVHrJyt4iINILkHfKDDEKM3sSDwF/hePKSrEqdIZAej53pXhLyLkE1IWiWmQqqtDE9dpnLtYXXWKdlvPMHImTAgsZALQTS4WgQEMxHy6zZbpxExmaua8/8U80h05b9r48nXdFJ0DJLHUSNW/KOJoadupYE5VlJN1zWITrRWU+Ctf+WRBSjBYXk2B9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=timR0Qo23WKGwuaAfjjqvpX0xkhGFg+Lw6E0AXA3YO4=;
 b=ebm76uwSpPr6xUuEGYeJE1cwtJsv/xrPE3q+hCZRcr0TlDIGfH1NvvOkDIsDL1Xod/EY0gOZI1oIsRFeeLbUHjRjvtEb5Nvpz8nXYCLOUvqJtAa+HClznHkDkLF26oWbAHTki7hQn4AtadKoVKN5ZunIXHX9beS4trqPB1sKwVxgbZIWMV8myq+qcRVRl9fOX+CysWv+DeZY/pac+AVORvkQMjeICciqIJ3lo75QrPfaUjRxNdkyEbLirw62hOFQVeU8F1wlM2PWN0cZa4AKiwJk8nHrc6rBIf1WOvhVTtLOs5we+Q2GJLuqa7a3Dt/y5dYHfgC0sulwjT5kO0x2VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=timR0Qo23WKGwuaAfjjqvpX0xkhGFg+Lw6E0AXA3YO4=;
 b=C3bgx9KGP8AKyMB43zB36GI3PzQyoL7sajWDQ7ZSE8fFnbmy9NEr7C3fPoR5bvvlzQnj6WfomzFK8sn0XHjk68hFY/ppbBwmB1O1kcQDOHF+7a4jkSB/Tb9LLhtENS62MqLK7sc+XuuKVuicHPbav5s2rUfK1U7vW2vh2vuOr3Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH3PR04MB8951.namprd04.prod.outlook.com (2603:10b6:610:196::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 07:54:43 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::317:8642:7264:95df]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::317:8642:7264:95df%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 07:54:43 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] btrfs: scrub avoid use-after-free when chunk
 length is not 64K aligned
Thread-Topic: [PATCH v2 0/2] btrfs: scrub avoid use-after-free when chunk
 length is not 64K aligned
Thread-Index: AQHaSNy+OX/p0UaZ8U2dm8znFmOQ/rDdoyIA
Date: Wed, 17 Jan 2024 07:54:42 +0000
Message-ID: <7810799d-23c3-4a43-905b-e5112cd7d6e9@wdc.com>
References: <cover.1705449249.git.wqu@suse.com>
In-Reply-To: <cover.1705449249.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH3PR04MB8951:EE_
x-ms-office365-filtering-correlation-id: b7c5db47-d6c7-4b6c-19be-08dc173190cc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tgQaPQ48tylCDRlfmB86MI64jW6kwBC17/+SudQdDmE2gtSrICrw9mLcnbBeXhV+WTWvPUC9DbJRzboMC1gHo9IOmg/gKq4XRi3tnAB0nR5RtOYiEuOLaF7Vx37GTxBje7F+A7zo9QQv+xrLXJrQwvpHaQC4s3smU3zHKN5jRxlgcptCo4Oq7RoyWHjw4rzx2OVE2+u9gFloAEXCueGVmSvax2qhkMi9mSEG2OJWndMMFCnOA86IiT7XBhPvFn4kUTnUn9mXJHHT4s/YxIuq5Ku/8EqZGzJ55n+1+r+BZM+GumTfkjMEOXuq7CHmMs0sJZWUFJZwKpGcwNWg99pcv1w2RgJMNz/Qr1BFPR5Ks3nwN1lmT7JgN0ybHz3U51gVVJj6azLuScpT4xpeiYeuJlI0FHf3b2AcE0z3dlN4rSpuThT2aysEHAurHbCbzHXpgKrHVTvIxWHdVa7+VZYLLg3lVrntCZqQhdWD9I8elloHeGNHJM5gxjRna/9Vq/aW36VrmCi78YCwlwhtNJfy1xUpJfGga8F4u8LoulvB1H0W3EwSsx2nQehPXs02HK50E1+PbNxLRfCknyDSMBmUSUusAbEKvD98jBMzTWX0OgOkS4XtmVRaKskH2xBkSr9bvEQOw+GOYq7/zP28OSmC83AvEp19sMii3dfC0yRPFKiRqqmNBZoQgwB2NjAkFon/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(6512007)(2616005)(71200400001)(6506007)(53546011)(83380400001)(122000001)(5660300002)(8676002)(2906002)(8936002)(41300700001)(6486002)(316002)(478600001)(66946007)(76116006)(91956017)(110136005)(66556008)(66476007)(66446008)(64756008)(82960400001)(36756003)(31696002)(86362001)(38100700002)(38070700009)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aml6QkJrejFoOEJDeEFiTjlxVDk3TlQ4dE8va0p4NFJIQjdEaFAydFh6RGxG?=
 =?utf-8?B?cTR0NzNKSm9MMWk2RE5KdjFXUHdLNWV3RFBXZFdGK2k1dTByUTRiYnpacllp?=
 =?utf-8?B?am9SQlY1Mi81cTFHbWphSDFQbVJBWkhqYWpqTzdKeS9HQmpBUFRaZlROMTNP?=
 =?utf-8?B?OGg2VE80aDdUa2ZmSmRnUzlrRWlPOGliV0w5TnI3QXE4NzZYWC9xYVRCSzRI?=
 =?utf-8?B?YjRDRmYvVW8yUHd0c242RzAxKzRJcHpWN2JxQ0krajlCRjlDZVRLaVdhMFJU?=
 =?utf-8?B?WFhpQ09pcWZjUnQrRzA0U3VZUHExM1VVUURUeHo2K3VnejQ2ZHBUV3dZL2lo?=
 =?utf-8?B?R0t0NW1US2ZNbWZkRlN2SVZiK1ZWTHJIbnd3bWg2ODh0amhIeVZvc3ZNOVRq?=
 =?utf-8?B?ZWZvbnFRbWg0WXlZRlVFczU1U0R0OER3cDBwZFN1eHhmQmRXWHJ6MlJZUnYr?=
 =?utf-8?B?ZlVTd04xSDhaK0c5c1Flb0k3OE1rZ1F6R3BPVjZOYlIrdDRITzB1Yjk5Qks3?=
 =?utf-8?B?V3Fqam5PMFFvK2lUUkNoV0ZiMUxNNGc0S2dFTk5qc25KUHU3QWR6M2ZVOE5C?=
 =?utf-8?B?YTVKZm5mamZxZ2lDYk5HSmFwUlBITDhSZWtSR3FvVnRwd2Vrck9sLzczOTls?=
 =?utf-8?B?US9NVlVsN0loVFhQRWRRWllXQnY4WFd5Y0xUa2F5ZW10TUFWZzNmN0kvb1Ur?=
 =?utf-8?B?TVZNRkVzb01ZSE5zaTh0ZVg4dERyYjYvNnVFSjNTR2N1VDJ0dE13eXJQTFVI?=
 =?utf-8?B?MVdkYkljNG5HOWswUGZ4cVRWVkVJZjc0ZzRWQVROZkg5cUt6NjBpbFZOUm1C?=
 =?utf-8?B?ZjJNdDFpOVl2cERtRWtTbTRKV2NJR1NQSkNLYktPcGNQU1JiSjE3SGF4emxG?=
 =?utf-8?B?ZXh5NjhSUHhaUCtzcGs3OW1ZVGVvVXQrM2d6SS9aRmxLVDQ4S2JXaWh5Wk1z?=
 =?utf-8?B?SWVlVlVYNko3ZEVvTWRMUldaUkM2YzN4Qm5GaDR2Mks2OC84Sk9WWXF5YVY4?=
 =?utf-8?B?SU9TM2crVFpLUUgwTmF2V1I1d2tDM3ZDeThOSEpxVHMvMnVwVVdTTVVGTEdy?=
 =?utf-8?B?dEx5bHlKYmV5cXNUVVYxYXJ0WXB5N0JhQ00yRk5CVTByNEJoV3ZpVXJkVXpW?=
 =?utf-8?B?TzVXVk5SMzNKTXY3dWh5czZNK3ZLd1J3OGtRc3YzN3R1SUpIdjR1NVJsd2tC?=
 =?utf-8?B?VFI1WkNsb3ZuaDhxaTRMR1NmYWxwVXAwWStFZWI3SVhWY1BwSnVYRDBWMWM5?=
 =?utf-8?B?MkduTkdvU3Zudy84TSs4SWk1Q2J6ZGlqT0N3a1FZaFVHRDhIdGI0TXdoaVhh?=
 =?utf-8?B?MmEyYklJamQwV21yc1hYdDhmcklTeFdGa0pLbXoxeTU5L3p5djhxSGNwNkZy?=
 =?utf-8?B?akxRbXhqVE8xekxQdFNIdTdQWlVwU3hqbGlhRGVOV1dLYjZIWHFMQnhlbCtF?=
 =?utf-8?B?WDRqQUpPcEhSVkZSVUFSSzJCWWFIQUhLek1XTi9lT3lxTm11di9JSm96VXFN?=
 =?utf-8?B?QlZ6QzFQcTYvOXgxY2tYbS9mSW12TXpXdUFLVGwwcklmYStaVTBrVUdsam55?=
 =?utf-8?B?VTRrN1QzTmV5YkVnV0o4eDRFRzcvSjVzZE9rYk5aN28rbk4yYVpybmlZVkNY?=
 =?utf-8?B?OVFxV0p2T0pBaXdwdnJNMTJNbHE5QVNHWFZPWW5rWkU2U1pLWUxlTFZsWGtV?=
 =?utf-8?B?cVZPeklGVWc0WVZ2eHpFNGJ2dTN3cXZNNTdrSCtxeU1wYWJyUVlBdW9hLzcv?=
 =?utf-8?B?d25CRS9PbVNFREswUElIL2ZEN0dveFlKL1dlc2xIaFZadUFZTFVxK0c2c3Bi?=
 =?utf-8?B?dmRhdmdyeFN0TUVBcC9SVmtRUnZSNHNmYUdNTWl2N204Z25GeG8vSFFBOEFr?=
 =?utf-8?B?ZFNlblYvcUdEdFlwcC9FMDdqUElHbzljZmoxTittdkl2cEtCcXJVY2NwdFZE?=
 =?utf-8?B?MHMyVThtU0ZEaEdzdWtBVVlZaGp2QnNMQUQxclZyL0NHZkF2cTlIUmpNbERY?=
 =?utf-8?B?eU5hdjUvbitNRUZsaVJvakFmekVGMWx2QitIczh6L0JGVzM2ajE2TytRbjJT?=
 =?utf-8?B?Y3J4blNSalNCb3JRb0hJcHRSaHVIeFJHZ0NRQ0w5R0Q2dHpCL0llNW5oM2g1?=
 =?utf-8?B?SzRGd0d1b2ZoV0FTOHdVZDNTVk4rY3FLdzYwYzQzSnk5SVpPRDNpZXhIWmJm?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84ED1597C02C5048A6256F71613D212D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8QWYvowvlTrSmmapZmHUGUrmNiKrARSuWzOkqm2kCwLaRhhm92Bn4CcXuZdFzO4Xcv71AZ5OlETZOMzI+9hoKsghBX0ho0XXd4Ma9Qfz33OgfVANfMOFVfx74v3r1WXxffAJ132xfkr5eGV8UUSfRq3r5SnyPULoPP8basvsf1+BsJyMtSJRZmBni6eUy+6iF126+YjOuTdwS7ys0bvVEVQuBgorWgouu5Cm2Y7dFUXEP4PAlgDX9NEDev8StlpUf33PvyrEC/eQ0Z5ButJ38wuU+rd12FSDIahkLyUFSe39lLSUBcq+AxqutffFMCwUQHUrtHCCmiJnShTI9U0fNt3XYU//+6qcpQzymQHU8GtTnFcCWCTmqBNJB5/Fs5PnSgyqLfuZFEfrENlvasKz1mJnob3D7bFvyrRqXuJDG7EyewnTyBsxqcV5KRNDTk1iJIkcfHHeK703F1DpJO8EIY1IqpwkeJIaA25/8txw708gUNWaT61QAWE8wNkWRt5cMAhzSo2mPR1o9Wiom8Ov79yhp6uMImeTcM1/Vl3NU9szXJllscgwGL4Ve160tQXt0lVlevW8IKJ/zEppBDmFdTx7TU8t6XLZZYS4/yx9ApXNe/7PNlNsUu8DUPj4gFZo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c5db47-d6c7-4b6c-19be-08dc173190cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 07:54:42.9381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bKOthxnFyhncGmAGgoS1KFG5g6VMjugdqGStZ5U5xtz/fXvc57dFVCt2q8lZTIv1uksi2NSI1/LhFGjfuzKghsyc5Lh6dY/yeN+yl3Dprd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8951

T24gMTcuMDEuMjQgMDE6MzMsIFF1IFdlbnJ1byB3cm90ZToNCj4gW0NoYW5nZWxvZ10NCj4gdjI6
DQo+IC0gU3BsaXQgb3V0IHRoZSBSU1QgY29kZSBjaGFuZ2UNCj4gICAgU28gdGhhdCBiYWNrcG9y
dCBjYW4gaGFwcGVuIG1vcmUgc21vb3RobHkuDQo+ICAgIEZ1cnRoZXJtb3JlLCB0aGUgUlNUIHNw
ZWNpZmljIHBhcnQgaXMgcmVhbGx5IGp1c3QgYSBzbWFsbCBlbmhhbmNlbWVudC4NCj4gICAgQXMg
UlNUIHdvdWxkIGFsd2F5cyBkbyB0aGUgYnRyZnNfbWFwX2Jsb2NrKCksIGV2ZW4gaWYgd2UgaGF2
ZSBhDQo+ICAgIGNvcnJ1cHRlZCBleHRlbnQgaXRlbSBiZXlvbmQgY2h1bmssIGl0IHdvdWxkIGJl
IHByb3Blcmx5IGNhdWdodCwNCj4gICAgdGh1cyBhdCBtb3N0IGZhbHNlIGFsZXJ0cywgbm8gcmVh
bCB1c2UtYWZ0ZXItZnJlZSBjYW4gaGFwcGVuIGFmdGVyDQo+ICAgIHRoZSBmaXJzdCBwYXRjaC4N
Cj4gDQo+IC0gU2xpZ2h0IHVwZGF0ZSBvbiB0aGUgY29tbWl0IG1lc3NhZ2Ugb2YgdGhlIGZpcnN0
IHBhdGNoDQo+ICAgIEZpeCBhIGNvcHktYW5kLXBhc3RlIGVycm9yIG9mIHRoZSBudW1iZXIgdXNl
ZCB0byBjYWxjdWxhdGUgdGhlIGNodW5rDQo+ICAgIGVuZC4NCj4gICAgUmVtb3ZlIHRoZSBSU1Qg
c2NydWIgcGFydCwgYXMgd2Ugd29uJ3QgZG8gYW55IFJTVCBmaXggKGFsdGhvdWdoDQo+ICAgIGl0
IHdvdWxkIHN0aWxsIHNsaWVudGx5IGZpeCBSU1QsIHNpbmNlIGJvdGggUlNUIGFuZCByZWd1bGFy
IHNjcnViDQo+ICAgIHNoYXJlIHRoZSBzYW1lIGVuZGlvIGZ1bmN0aW9uKQ0KPiANCj4gVGhlcmUg
aXMgYSBidWcgcmVwb3J0IGFib3V0IHVzZS1hZnRlci1mcmVlIGR1cmluZyBzY3J1YiBhbmQgY3Jh
c2ggdGhlDQo+IHN5c3RlbS4NCj4gSXQgdHVybnMgb3V0IHRvIGJlIGEgY2h1bmsgd2hvc2UgbGVu
Z2h0IGlzIG5vdCA2NEsgYWxpZ25lZCBjYXVzaW5nIHRoZQ0KPiBwcm9ibGVtLg0KPiANCj4gVGhl
IGZpcnN0IHBhdGNoIHdvdWxkIGJlIHRoZSBwcm9wZXIgZml4LCBuZWVkcyB0byBiZSBiYWNrcG9y
dGVkIHRvIGFsbA0KPiBrZXJuZWwgdXNpbmcgbmV3ZXIgc2NydWIgaW50ZXJmYWNlLg0KPiANCj4g
VGhlIDJuZCBwYXRjaCBpcyBhIHNtYWxsIGVuaGFuY2VtZW50IGZvciBSU1Qgc2NydWIsIGluc3Bp
cmVkIGJ5IHRoZQ0KPiBhYm92ZSBidWcsIHdoaWNoIGRvZXNuJ3QgcmVhbGx5IG5lZWQgdG8gYmUg
YmFja3BvcnRlZC4NCj4gDQo+IFF1IFdlbnJ1byAoMik6DQo+ICAgIGJ0cmZzOiBzY3J1YjogYXZv
aWQgdXNlLWFmdGVyLWZyZWUgd2hlbiBjaHVuayBsZW5ndGggaXMgbm90IDY0Sw0KPiAgICAgIGFs
aWduZWQNCj4gICAgYnRyZnM6IHNjcnViOiBsaW1pdCBSU1Qgc2NydWIgdG8gY2h1bmsgYm91bmRh
cnkNCj4gDQo+ICAgZnMvYnRyZnMvc2NydWIuYyB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCA3IGRl
bGV0aW9ucygtKQ0KPiANCg0KRm9yIHRoZSBzZXJpZXMsDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMg
VGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0KT25lIG1vcmUgdGhpbmcg
SSBwZXJzb25hbGx5IHdvdWxkIGFkZCAoYXMgYSAzcmQgcGF0Y2ggdGhhdCBkb2Vzbid0IG5lZWQg
DQp0byBnZXQgYmFja3BvcnRlZCB0byBzdGFibGUpIGlzIHRoaXM6DQoNCmRpZmYgLS1naXQgYS9m
cy9idHJmcy9zY3J1Yi5jIGIvZnMvYnRyZnMvc2NydWIuYw0KaW5kZXggMDEyM2QyNzI4OTIzLi4w
NDZmZGY4ZjY3NzMgMTAwNjQ0DQotLS0gYS9mcy9idHJmcy9zY3J1Yi5jDQorKysgYi9mcy9idHJm
cy9zY3J1Yi5jDQpAQCAtMTY0MSwxNCArMTY0MSwyMyBAQCBzdGF0aWMgdm9pZCBzY3J1Yl9yZXNl
dF9zdHJpcGUoc3RydWN0IA0Kc2NydWJfc3RyaXBlICpzdHJpcGUpDQogICAgICAgICB9DQogIH0N
Cg0KK3N0YXRpYyB1bnNpZ25lZCBpbnQgc2NydWJfbnJfc3RyaXBlX3NlY3RvcnMoc3RydWN0IHNj
cnViX3N0cmlwZSAqc3RyaXBlKQ0KK3sNCisgICAgICAgc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZz
X2luZm8gPSBzdHJpcGUtPmJnLT5mc19pbmZvOw0KKyAgICAgICBzdHJ1Y3QgYnRyZnNfYmxvY2tf
Z3JvdXAgKmJnID0gc3RyaXBlLT5iZzsNCisgICAgICAgdTY0IGJnX2VuZCA9IGJnLT5zdGFydCAr
IGJnLT5sZW5ndGg7DQorICAgICAgIHVuc2lnbmVkIGludCBucl9zZWN0b3JzOw0KKw0KKyAgICAg
ICBucl9zZWN0b3JzID0gbWluKEJUUkZTX1NUUklQRV9MRU4sIGJnX2VuZCAtIHN0cmlwZS0+bG9n
aWNhbCk7DQorICAgICAgIHJldHVybiBucl9zZWN0b3JzID4+IGZzX2luZm8tPnNlY3RvcnNpemVf
Yml0czsNCit9DQorDQogIHN0YXRpYyB2b2lkIHNjcnViX3N1Ym1pdF9leHRlbnRfc2VjdG9yX3Jl
YWQoc3RydWN0IHNjcnViX2N0eCAqc2N0eCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHN0cnVjdCBzY3J1Yl9zdHJpcGUgKnN0cmlwZSkNCiAgew0KICAgICAg
ICAgc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8gPSBzdHJpcGUtPmJnLT5mc19pbmZvOw0K
ICAgICAgICAgc3RydWN0IGJ0cmZzX2JpbyAqYmJpbyA9IE5VTEw7DQotICAgICAgIHVuc2lnbmVk
IGludCBucl9zZWN0b3JzID0gbWluKEJUUkZTX1NUUklQRV9MRU4sIHN0cmlwZS0+YmctPnN0YXJ0
ICsNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RyaXBlLT5iZy0+bGVu
Z3RoIC0gDQpzdHJpcGUtPmxvZ2ljYWwpID4+DQotICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZnNfaW5mby0+c2VjdG9yc2l6ZV9iaXRzOw0KKyAgICAgICB1bnNpZ25lZCBpbnQgbnJf
c2VjdG9ycyA9IHNjcnViX25yX3N0cmlwZV9zZWN0b3JzKHN0cmlwZSk7DQogICAgICAgICB1NjQg
c3RyaXBlX2xlbiA9IEJUUkZTX1NUUklQRV9MRU47DQogICAgICAgICBpbnQgbWlycm9yID0gc3Ry
aXBlLT5taXJyb3JfbnVtOw0KICAgICAgICAgaW50IGk7DQpAQCAtMTcxOCw5ICsxNzI3LDcgQEAg
c3RhdGljIHZvaWQgc2NydWJfc3VibWl0X2luaXRpYWxfcmVhZChzdHJ1Y3QgDQpzY3J1Yl9jdHgg
KnNjdHgsDQogIHsNCiAgICAgICAgIHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvID0gc2N0
eC0+ZnNfaW5mbzsNCiAgICAgICAgIHN0cnVjdCBidHJmc19iaW8gKmJiaW87DQotICAgICAgIHVu
c2lnbmVkIGludCBucl9zZWN0b3JzID0gbWluKEJUUkZTX1NUUklQRV9MRU4sIHN0cmlwZS0+Ymct
PnN0YXJ0ICsNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RyaXBlLT5i
Zy0+bGVuZ3RoIC0gDQpzdHJpcGUtPmxvZ2ljYWwpID4+DQotICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZnNfaW5mby0+c2VjdG9yc2l6ZV9iaXRzOw0KKyAgICAgICB1bnNpZ25lZCBp
bnQgbnJfc2VjdG9ycyA9IHNjcnViX25yX3N0cmlwZV9zZWN0b3JzKHN0cmlwZSk7DQogICAgICAg
ICBpbnQgbWlycm9yID0gc3RyaXBlLT5taXJyb3JfbnVtOw0KDQogICAgICAgICBBU1NFUlQoc3Ry
aXBlLT5iZyk7DQoNClNvcnJ5IGZvciB0aGUgY29tcGxldGUgd2hpdGVzcGFjZSBkYW1hZ2UsIGJ1
dCBJIHRoaW5rIHlvdSBnZXQgdGhlIHBvaW50Lg0K

