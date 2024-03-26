Return-Path: <linux-btrfs+bounces-3593-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA4A88C296
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 13:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6831F6441D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 12:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE8B6FE09;
	Tue, 26 Mar 2024 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XNJoZmA+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Xt6x22Mj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFB7495FD;
	Tue, 26 Mar 2024 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457486; cv=fail; b=nHypXoP71T5x9N5Km7NbAUGbk8eqHxj2P3EddmulbumclOoQkAF+DmuLDoV8ddz/9ZT2M8k8XNKKSDvUchE3cZtvasD8EUYy9f0uGn9FVdYwg1Yw0OhJqjb3WmvKh2MAyIEsnNd/RwgxzlsZ0vUk9svFdOw1zUvP8KwgWDUkfoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457486; c=relaxed/simple;
	bh=K6V9dB16DLRBZPp+RHAGJfwgQwmTO4H7cYyes1+fzbk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rQxGsyW1T1ELi4/Z9VV4MYVWzdlUnwPV34Qg721R79WzYqIV4kLAjvYHyuvYDFN1er+5LmyIuBEXPj2upSMrINvuDP6Dt54lgJRb+GVaezZ7f3jzJVs0OTtVbPL453Xwa7oL0yZd1W1zbm+vzbioevvl7zavxkAV2mkRmON5+ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XNJoZmA+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Xt6x22Mj; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711457483; x=1742993483;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K6V9dB16DLRBZPp+RHAGJfwgQwmTO4H7cYyes1+fzbk=;
  b=XNJoZmA+3ONO44W2LtZWN2hjYVkCtf9MESBoZl91EWpnn2oWtnyYdjzP
   AHf7mR++/taOSjf1Z2KFd2SgIUpvhv97pQpKKwscLrEIksIl7F8cjOv3C
   bP8xaIBQEhuoPQhLlBcgNIx8RpFEw4FF2Qc4M/NnDk80RalmIj4kA/wH3
   JOgueGR+QG0AB1lcgyNk1NEazUNJil2PUbVv2ravT2+xVO9Le9U+XCP38
   GIA9cqczEsGpNR//woKSXvrFfl4bqzBel/Mzy5TlHZdVWEXpitZaVwK8J
   OIoo3W/lfMVCGxElT4M5uTctEqhiTHbfQ5ddeUJvn01fMHlhEQyl7GDL/
   g==;
X-CSE-ConnectionGUID: TstmACp/TGuDiujPINV+7g==
X-CSE-MsgGUID: irvUwfMUQiG5UOBXz6iNjw==
X-IronPort-AV: E=Sophos;i="6.07,156,1708358400"; 
   d="scan'208";a="12498084"
Received: from mail-dm6nam04lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2024 20:51:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDQS30U42ux107C37Hvxc341jEALFbSU1y3Iltmk1Uz9T97J3NRT/yggQB/YPhU5cRnWSrszhoT7QRbZd3NhorjX2muFnH38eohvFLd+J9P4TBj90UMZTdlPLDthwmPED5SZs9sb7ckMrlOgywjwfvjYj1YKShnk/eqNyisZogTa2tP8pgCIJogZpXbZi9Q74dxpXbkSSyWVNRUY/bEV4N02Ee2ypUD+U64EBYRqf5LJST5FBrObx9EOVPdL+CqIJPuOVZyL0RZcVvM+PF2hS2bBaLD6dQxCRIsvHA/ZcYeFFaVO1tPa8KSDJ6yLd0Ixv0fr62dSZ1k8o2Qd+YhApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6V9dB16DLRBZPp+RHAGJfwgQwmTO4H7cYyes1+fzbk=;
 b=AHcbl+3vfHshmwLVfeOybn2qcWx5sUWEUQWsQKMF7cK2+3npN/RiHaYSh50VqdmskZ+5oKylaYmFnbTD2a3oHl0q2z7KccJ1Yi/WnKsNfepKobaZfsDBZbtC/R464zeGlOLZuLy/NlATWu2dy9wef4L8TTjOGf6V4Ia2bmyvunv4slLr2guyMCBvw3Akpi55ZNGaKWcyv6JSeKqiAgbZ90nkd0Bmau3Y62mku2bfnSbNTdZq+zRsVyfq3lVtPMjVtayBX+tvOTY/E4EZCm8z6znM2AWA2Py4KZvfMf1UkEPLvT8grEjEWUbYP453Uh4vpCgb6HEz+sllwh0yhTPPPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6V9dB16DLRBZPp+RHAGJfwgQwmTO4H7cYyes1+fzbk=;
 b=Xt6x22MjiOpIxREixpGwoF6773aXF7CRVs4UtltS1SpLAsiQSx9TI6xemaq+ULCkTjFBVd9ef7mwgKm9e7P3GdQn7P3AxJL7iL1pTKPGkECWXK5mbwJMNT62zHGtCr+/nzXwL9lkmWTwx0jj3YNbq3uBJcEc5sap1QMKgdSz3nA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6399.namprd04.prod.outlook.com (2603:10b6:208:1a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 12:51:14 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e%7]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 12:51:14 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet
 Singh <navneet.singh@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 15/26] range: Add range_overlaps()
Thread-Topic: [PATCH 15/26] range: Add range_overlaps()
Thread-Index: AQHafmeod9YSMyiE/EyhZ92C7YUu3rFJ+8GA
Date: Tue, 26 Mar 2024 12:51:14 +0000
Message-ID: <34c1f5b4-8748-4886-b4ff-cfbf8dc71afa@wdc.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-15-b7b00d623625@intel.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-15-b7b00d623625@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6399:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oAxQXQtW4BJVQSjdRMsP0WN3hMFGHqSHTz3jcaDX31u8wWGlZ/5PoVqPd38iSNiexs54FVEK4FKdYhtNfcbFygd5XklXHsFRdj3T3OrlmvkPgzo9M6bx4OZMLKIYmDPjxRx7X8WCKRewwWQk3ZeoLq0SB1dTo2tGFS9/sLlAAqci/ziGIDTxVTGdAWnpbCBnQuuxinuthT6wS+j5QAhkQe8cHDoA9frXZZ8LB6CBps9aH48L6IvoVJVkQuXw7Q8w6js8Y0a6G0moB4i3+nxhRWAjUlOgJRsKvkezO6yFkt2x4qPYW3pc4RXRj4Xl668DzPRatoni1E/CPkyv+r9nafnwkTC3qszG+sODYB0F8HXLCAlGV8JBjDHvjEeHQhUqv4NBIGwoQIYFdxp4XZArncqbJYFCMu+Z3RUyjOXvf608aMGwL6dPoPBEZEAys0OTKCfGL+8ap8y6CuqJQBmlm6Rd4P51KwXL9rcx2obxR25lhvFACEzAqmEHqMYSq2SleibteESex68yIjKotNrpvRDpOmnYEpP24iI4Nep/GW1XxQxX/O/XsWpwu08FulN6sNf4JEIY1jCDdbiTrH9n2Rh3NWB4M5rQEy3IKr7DViE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXY3ejAwN29aUXFKM1RuZ3NIcWZiekQ0N09UYkwrd0FpVjhqQTJiNEZrQ29T?=
 =?utf-8?B?YTBuTWNrT05IUUU2QWt5YzhncFA1Qko1OXFRZWpXK3dLbVlnUTkvazc3MEMr?=
 =?utf-8?B?bHNXblUycEFyZTA3MDQxZk5DcVVBVmhqRmw5alVpMVRUVzRNcmpuM3cvYWd1?=
 =?utf-8?B?cysydC9DOENrblhQME1oNjJObnJEOFgzQjJNOGVaNjhtdVVOU2Rna2hJK3ZO?=
 =?utf-8?B?WWt2Ykt5aHNnaENlazNuTk95MzhxV2phY1FCNXNRa2ljL05ZQUhpQ2VMR2hM?=
 =?utf-8?B?RStUTU5QOFNyQnoxVEt1Qi9jejBzZU5Ydk52bmdLcDJwQVJuQUZFY2xrZUcx?=
 =?utf-8?B?Q0JrUis1cG9ROTdiYWw5YjJOTVFIQnJTL04vR2xQcXdPczJ1Y2pPd3J4cXc4?=
 =?utf-8?B?M3RxaVRFVU1xSlFEaG96SnVGSmYwTjZQeFVpMDdIdWRjYXA4MkF4RTlFN1g0?=
 =?utf-8?B?UjZpZUp2VldLY0NBbitqUFViNUVJelM3Vi9pZmhyUjFFZlpmMWtJN1FIVkV5?=
 =?utf-8?B?cUEyZ2tPYXl3RXJIOEVvaGUzLytlZHhFbjQ5ejcxUVNpbzlFN1ZZOUpKYTJP?=
 =?utf-8?B?ZGk2VEQ3TWlZL28yYVdST3lrc2s4NFVTMUhZVjZzYTNRbUVVTUgydEpaZGla?=
 =?utf-8?B?TXplY3M4UXlMdDR4dndCejBKMnVYemFYbS9KTjJOTGUvRUZnc205S0M3N0dZ?=
 =?utf-8?B?a3hLUVZDWURpRFgyejVyQk1pZVRFUG5ZYUFya1BsOWtHc3dSb2JtSTFGV2Jv?=
 =?utf-8?B?NldPbkc0SnI0TEhRbkg5cnk1NDlaWlFuUzJTOU1DUUF2UzRDaW5pT2djTzN5?=
 =?utf-8?B?ZlJIQ3FEbU5PVTlxbmtKT0l3eDk2QTZ2OE52dk9CUkhkYkxEL044cFVNdXJJ?=
 =?utf-8?B?VENqazc2bU9VZkVyZlRJaDlVbllDMXZRMEZNRWtqTGF0NzNuZG9xUWtUOVdv?=
 =?utf-8?B?N1VEQTdLS0NaM0l3SUV5ejU5WGxDKy8vdUJwN1Jic3ROS3VnUmFwT2dBaDll?=
 =?utf-8?B?Y1NmcDZPd3ZxRjFPaEp1aElmQUNIRTRnc2owQ2oraE96c0JXZThZc3MvUXRH?=
 =?utf-8?B?QUplUjRTY0VscjZGRWpicE9oV2FXeXBHL080bWhUYlhuUG16TVEwcE1vUFhw?=
 =?utf-8?B?aXRabzZyTzFaeGR6SldiRk5qdC9vQ0lmRDRlUldhSThOWXZmTjgreWcrK0p4?=
 =?utf-8?B?elhISFNDZW82VTVBTHN0ckdzMXhCdXlGNVJHS2J0QzN6cFBzRjZGd0ViMXZK?=
 =?utf-8?B?RU5GTlVTSFlTMkczTzMvTGhZNmNzc1VJVjU1RDlIU1BzUVQ1ZXdIRVhqT1Ny?=
 =?utf-8?B?VGpRK1loVGU4clYwbFlVSnVEdU9mcUltWlZMZUhmc1d3SzAwZENGZHE2RS9L?=
 =?utf-8?B?ZmNyOE5nc05MRWl6UXdWdk5GWDRJVldVOVFydzZpc01VQXFCc2xjcmpNUHFX?=
 =?utf-8?B?cWxtS0tHN2xleVl5OE5UWDRmZDdTbmdQYVJ2czI2aTVzQUVMUkpkTzB1RXZL?=
 =?utf-8?B?V0VhVFdpanByRGVvUDA2ZERlU2s5b1dpOFZ2VFZWNndXRGlicTBDbDE3cG9P?=
 =?utf-8?B?djBWTHE5VjlYRVQ2QmxpRDdnWUdtSTd2MGpNdExNZWZyWG9UaENkZkNldTJS?=
 =?utf-8?B?VDJxWkZlbEZIT3lpK3I4ZEJ1QWM3NUhkVWRaeE83NlVEMDF1enFMMlJXNDhu?=
 =?utf-8?B?OGVod2NicURvd2ZIdjVlQ0dCMmlXbDNyMGJYMVNmS3gxSHdVN25yS052NXNy?=
 =?utf-8?B?YUZUcE0xVUFjRStlUEk0K21VS1JxZGhZdHEvc3YzaHdsYVVVR24yT0Z2aWdm?=
 =?utf-8?B?K3ZTSUdocHZDdnREb3RxOFZ4UTZxL1dGTlBQRytjWUNOMmpXWnBNQys3WS9a?=
 =?utf-8?B?d1pNaFBBOXBIVHBoTHl3Y3hhSnFXelorWVJXQnRONGk1Y2w5WkRmcG9DcDJM?=
 =?utf-8?B?N3luNzRNYllmRkI3aHZ4M3hrUXFaT3NsQmRCUFlqSk1xMnZlV3l4SVNFK3dX?=
 =?utf-8?B?aTh1YUF4cDRDZkFuSWgvWjh0bHVRTjI1Vk5mSXRHQmgxNEVkRXFPWjhrSTVt?=
 =?utf-8?B?WXlmcEt1cmgrTjV1Y04wQ3d6eW5BL0E3amFWTnFPeGZiVTl2VmN2UGRyNlFo?=
 =?utf-8?B?TFFQbHZjQTVTNXQ0V0kyQ252VVNBSHNXRFJNS1ExT3gxamJ1Wk1GVzRzMGdC?=
 =?utf-8?B?RktHNXhEVWVsbEYwU0F2cEQ4VXlsOVJkYlRJUllBdUUzZndJc0lIWVZUYU4v?=
 =?utf-8?B?MVNaUW03RmNKcWZCUUN4WDhFSVVRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1540004E7B8DC4696E80993BBCB1D73@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lkXF/y4N0T6uARioyg1GLz9eszoZVH2HuBFKwTtVaM+7oq/5YHrgMTkRU0GMG17BYKOAniXy4jo6buP5HRrTc4c9544DXl5BWB5SAn+PRR7ntqNbA6TrDgEb1Op89BiBGE4CRH9Gp1fzuaUqMe2Gvaw1OwA4H/Q/nFp2Ul2ymfoMJIz8R9hdvhSsDHwDezEvgxsOXdoiJzE7MfeKtjI1YFUFexdXNuBtLsOQCZ/WGcdu5Uz3G9PNXRw2m/IBQda+sdMx6feWKdhpJN/DsXrisNTVTIUniWJoHJMsB0pZUjEzqO1zTgbg+S+KNpnxGN5sfh2EOf60LKYelamyqgbHilkGy1hP7t2hMN/DkhwrVk/m1nDbnsHik0mm6uKONdXyEn3gsJuTOiZylK5O4IazazxxQQAgcl4auqOCzjpgbhyt793rUtzuGWAG/ods7vnAQc0Rgd8yL3Zs1TqwQDs6Fg4HPKSOXgJEsIhZ9vUybwT8ZqL0PWnnWDTCITkddhMeqCzACn0Pd4SoOJ6TDBcgNQBuYTXedgY7uBP3UjiqdWAR/6AlQ0MB+CsCdo8l8zHLQv2YqWg9e2iiI/jq2uUHNTYdzBSVIUIRP/0G/bRRpDjWbTS/7Wnf9LHh8iInDTUG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb69b88-1ab5-4d45-bc10-08dc4d936bb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 12:51:14.1902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XUnofuTqfj3XbFMFlmwFtYS8+AISlMjMwFNll2IsN5Caa/A6OqS5ikTjEut4eL9t7MAQALxfAjBPFfQAiarHcj9OHyIX/ZodalvBlECgG2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6399

T24gMjUuMDMuMjQgMDQ6NTEsIElyYSBXZWlueSB3cm90ZToNCj4gQ29kZSB0byBzdXBwb3J0IENY
TCBEeW5hbWljIENhcGFjaXR5IGRldmljZXMgd2lsbCBoYXZlIGV4dGVudCByYW5nZXMNCj4gd2hp
Y2ggbmVlZCB0byBiZSBjb21wYXJlZCBmb3IgaW50ZXJzZWN0aW9uIG5vdCBhIHN1YnNldCBhcyBp
cyBiZWluZw0KPiBjaGVja2VkIGluIHJhbmdlX2NvbnRhaW5zKCkuDQo+IA0KPiByYW5nZV9vdmVy
bGFwcygpIGlzIGRlZmluZWQgaW4gYnRyZnMgd2l0aCBhIGRpZmZlcmVudCBtZWFuaW5nIGZyb20g
d2hhdA0KPiBpcyByZXF1aXJlZCBpbiB0aGUgc3RhbmRhcmQgcmFuZ2UgY29kZS4gIERhbiBXaWxs
aWFtcyBwb2ludGVkIHRoaXMgb3V0DQo+IGluIFsxXS4gIEFkanVzdCB0aGUgYnRyZnMgY2FsbCBh
Y2NvcmRpbmcgdG8gaGlzIHN1Z2dlc3Rpb24gdGhlcmUuDQo+IA0KPiBUaGVuIGFkZCBhIGdlbmVy
aWMgcmFuZ2Vfb3ZlcmxhcHMoKS4NCj4gDQo+IENjOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxp
YW1zQGludGVsLmNvbT4NCj4gQ2M6IENocmlzIE1hc29uIDxjbG1AZmIuY29tPg0KPiBDYzogSm9z
ZWYgQmFjaWsgPGpvc2VmQHRveGljcGFuZGEuY29tPg0KPiBDYzogRGF2aWQgU3RlcmJhIDxkc3Rl
cmJhQHN1c2UuY29tPg0KPiBDYzogbGludXgtYnRyZnNAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25l
ZC1vZmYtYnk6IElyYSBXZWlueSA8aXJhLndlaW55QGludGVsLmNvbT4NCj4gDQo+IFsxXSBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvNjU5NDlmNzllZjkwOF84ZGM2ODI5NGYyQGR3aWxsaWEy
LXhmaC5qZi5pbnRlbC5jb20ubm90bXVjaC8NCj4gLS0tDQo+ICAgZnMvYnRyZnMvb3JkZXJlZC1k
YXRhLmMgfCAxMCArKysrKy0tLS0tDQo+ICAgaW5jbHVkZS9saW51eC9yYW5nZS5oICAgfCAgNyAr
KysrKysrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQ0KDQpGb3IgZnMvYnRyZnMvb3JkZXJlZC1kYXRhLmM6DQpSZXZpZXdlZC1ieTogSm9oYW5u
ZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0K

