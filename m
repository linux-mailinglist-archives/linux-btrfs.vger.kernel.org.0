Return-Path: <linux-btrfs+bounces-9017-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B1A9A5E94
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 10:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC3F281313
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 08:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A851E22F7;
	Mon, 21 Oct 2024 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XEaMRUkg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XgqHu2VV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A60A8C0B;
	Mon, 21 Oct 2024 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729499157; cv=fail; b=AHNdiDLiG0PHweu59t1FrtqHv2AbIheR9h2eS3jKDtWeFzmQDleXZLk4wLFmfH/IPGEbAkbpa7jSPzrR6+UXktUyUqv841CAS5tFBv0HgAL7Vjvj9qzTL7FX8B+aELsoVd+R2tPflYqlL6MpuNXCKt8xFvYeUJzFVCJzJPNXAIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729499157; c=relaxed/simple;
	bh=dlsUR3bqahE9qXcV/IVnr2fV7VDB1cWFdCSvOBBcLGI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hFAihivHDo9MKx1i8MwErEnclDpeZ253BGP2syqJpx1UgHcsVtiQ4Mo3gSSquMrueJTFuRfqiHtbx+hyI/8Ht7usfKzK7WhNaP7N1WBk56cQ5eOXXZ0yfIUROq/rQu0e8S1ThRK3uAIW4pOJTvhIijGVGB/v3nOi9HaHd2ayQu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XEaMRUkg; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XgqHu2VV; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729499155; x=1761035155;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dlsUR3bqahE9qXcV/IVnr2fV7VDB1cWFdCSvOBBcLGI=;
  b=XEaMRUkg0Gk+uA+tU5ixG8evfxLJiMwzlbh5MCt6yiNuOyoGsx3l8+hn
   EIdI72nwiVmLDSmgqnhXJfeYbqURZyy2/aXr7JmjcBC32/j94LN8JlTXK
   hQhJCeqd1opGSvGi30WwY0XXAxElDuzesGweG7yuJr/LU337j0X6i7cE7
   Mi/+55yX4XRM9xoXDntTz2hQIpbjsLinoikWpb6FnCCw/+WntfEtJC5Iu
   gDyCN6VuDpBDdEKI/OiNBU3zdjrFhFsKZiH0ovPTHrEysMRergcQcqnER
   lqF0r8NNAD4avMoi60bAqSxO2rhqeBtxoh02hl2y3f6wTmPgFURkLyblH
   A==;
X-CSE-ConnectionGUID: 46Mp2cvGR8KhDhRueuSl/w==
X-CSE-MsgGUID: 0JpPReoYQNq+6gFPWO9WfA==
X-IronPort-AV: E=Sophos;i="6.11,220,1725292800"; 
   d="scan'208";a="29953163"
Received: from mail-eastus2azlp17010019.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.19])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2024 16:25:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEIbSrMyeWy6LloYDHs8Rts3zj+Dz5ZpgAvJyorYJiEnwPEMG+LMMI2XlxUcE4b0m9ifTZPygk57o1+XDJTQ78mLIPgXbKQcSmarNUhRBQB5TroM013r/geAIFa4x8fFPagPqJ6heXUvrP8VvQ7muuErXtyv4pcAyj70eUGY3od9ncCQ9EPCeL/9dC5WKXQwy4NYkFQqxUXyIISCKtd44jFRN+pZWg7PxZnO5e32XNFDps7nYSITH5GkWiqVHjGpIzgsNrMSv2o6RHrS7BQ1Oujy9d7z+J9qeXFKzpKYuRmjeZAVdr/RdESb01UQCTLxLnFBs9KzjSuiTgNr2jPXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlsUR3bqahE9qXcV/IVnr2fV7VDB1cWFdCSvOBBcLGI=;
 b=fr2eZJxC4HHTIty1f8s5byg/yRakkfd8YN+MJGq6uzoZn2YrRsdudSAYWfxBivYcvPXc2sX7JSiZBLsg1wMmg6TpcjAa/+/njpq12ffopHJ//KcdMGojoDOSqgf4Kk/q3gHHKJlwMBkqZKrhAGG3T3lZaLS9irr7uco9C/sR9350IPL0/xwrC1Zqqiqqb3PJkNXpIfNAoMni88IvcZ0WdejDjpXZnlje/LWsoGe89G5ZVDHnYT5fs5XAgzJuFG61OyE4mF9jxYK8QePjKYNb4yBFxjJMpVo5EbFnQtGwsZsnu6U8bqjCS+Py9OmegvxiTAr97uWKJGLhvJW+EXWH/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlsUR3bqahE9qXcV/IVnr2fV7VDB1cWFdCSvOBBcLGI=;
 b=XgqHu2VVATi4WJmEYvT/rPEc7jDsXb/orGcEg8jaNKCKdneSz+VsUamAU2n/1OTC4FxirafFUTo2dFV3MO8T55gDTjhZs6jUTJS4sEh8A7BLcZhFyKP0hEANexx/tZXBrEg+iB4sC66gZwhgB6JNjx9tWwO7JLXbdF2Zw8gWrwM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6759.namprd04.prod.outlook.com (2603:10b6:610:a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 08:25:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 08:25:44 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Yue Haibing <yuehaibing@huawei.com>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "dsterba@suse.com"
	<dsterba@suse.com>, "mpdesouza@suse.com" <mpdesouza@suse.com>,
	"gniebler@suse.com" <gniebler@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Fix passing 0 to ERR_PTR in
 btrfs_search_dir_index_item()
Thread-Topic: [PATCH] btrfs: Fix passing 0 to ERR_PTR in
 btrfs_search_dir_index_item()
Thread-Index: AQHbIgZDQrfHY2OhyUuOS1VyUQ58brKQ4ZeA
Date: Mon, 21 Oct 2024 08:25:44 +0000
Message-ID: <7daf798c-64e1-4d22-9840-8954db354c9a@wdc.com>
References: <20241019092357.212439-1-yuehaibing@huawei.com>
In-Reply-To: <20241019092357.212439-1-yuehaibing@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6759:EE_
x-ms-office365-filtering-correlation-id: 2c397581-e9fd-4808-3527-08dcf1a9f526
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c05wSmpTWGN0YThja2VQSjExWG5oNkRtaCtoSWNrSlFGeDQza1NRV1ErV2k4?=
 =?utf-8?B?aE4rWVQzZm5tcDM0cDBwa3E1VDhwVzErUk13Y1hGYjhZc1F2Wm1XVGpQSW96?=
 =?utf-8?B?UVlJaXlETzZ2VEt6SjVXUUd5NmxteTQwOWgvMm1LN3JZbEk5eFE5dkpnbm9r?=
 =?utf-8?B?bWt3MjgrRnlxb1V1aTJ3WGgzRDJQS1U0NlJTNFlVbHBucnQrbFRwVkNNN0tp?=
 =?utf-8?B?MytmckdqSmNvRTlwdUxnbVlNb0dYRHlQNnZOYTFVQy9CaVJOYXFCb1V2cTBh?=
 =?utf-8?B?TVNRTEhPSWRYMzBNanlqYkNZRUFrTXF1QWFvYkNnRjIzaWlSSVNOWTNjVCtN?=
 =?utf-8?B?MWd1RFpteTdDUEk4MzQ5Y1dFMmxtWDc3WkI1QjFTVGRSeU93dVRSb3JmeSti?=
 =?utf-8?B?eGNLNFRYZlhkWCtNZ1Z2Q1p2eG5wZ0tsL09wclBtaTc2U0hrV3dlcUFpd29v?=
 =?utf-8?B?ZFdQMG1CZnNOMjhZOXlEWWtDR3ZiTUROTUtkR2tUVmdSNGNJTmJRRENJcGU4?=
 =?utf-8?B?VE90bVZWVUFHMHZpRzIyNFAwWFl6TmhvWXYzNWNFemZBWklWZGtEbmtTbFls?=
 =?utf-8?B?cUdhY2M2YTN5Tll1alNUcVJVak90TmNnZHg0UGxvcmdlb1pGY1NkWDNNRXpZ?=
 =?utf-8?B?MnIvcU5IN0FQbVJTMm81c3ZGN0RuTW9lL3FWRTVIdC92UFBWN0VIZ2lXN0dn?=
 =?utf-8?B?cllOWlYxZ2lxVmxJb1ErbUM2SEVEelNrQ1FPL3o1UmxzaU1aNWxKRnI4Wm5I?=
 =?utf-8?B?WThCVUFHLzhOMHcwWGVNdU1INTNTeUkwODVFYUQ1YU04cE1TNUZueHZZaTQr?=
 =?utf-8?B?U3FCUzdvRzF0L2s2QkN0TGpscTVWQVVMKytNVFdoeGUvUml5cDQ4c1lEdWti?=
 =?utf-8?B?T2xpVnp5TUpXMWV4d0I4NitkMkMvcllkRFZiVmwwN1YwWFF1MUw3QzRQamxJ?=
 =?utf-8?B?MW9uY3pYVjRxaURPbkJiUXl6MXBHTGluSCt3NzVuUCtMWXNSQW5jS3hwR2Rt?=
 =?utf-8?B?ZjBiNjhJM0pVNXQ1YmZQUjhzZ2Nrd3BGcjF6UGpubWtuNlhMY1pjMXJ1R3Z2?=
 =?utf-8?B?SXFNKy9USmE1aStPMVZFQ2FBZmVsTHVHN0lHZndSRjVMZmRaeUJjd2RXYm4w?=
 =?utf-8?B?VnBwUDlzd1NwNFEyR0x0WFl2S0oySVhZdnN4b29rSzQ2WDNqMmFhS3JFbnpF?=
 =?utf-8?B?M0VUZWZWYXY5RmtwSFZmdWtsVXdaWlFHWVdHb3lNcnV2V3B3QjFoSTNjNENO?=
 =?utf-8?B?V0Z4SlJ2VDV0RWRxZjNYMnRocEhxVDYyblB4RkhML2thU2dKVUhuNHFrTlBX?=
 =?utf-8?B?SGVLUnQ2TFdralRSSk1zeHBweWpBcUxJSUErRGd4UkhXOHFoZWVORjFVd1hX?=
 =?utf-8?B?VTZKQ2IrRlBVM1pIRjV1K1hSNGdGRkREMEo4aFdncytuejRVUnFrR3F1dW9x?=
 =?utf-8?B?RmRmVnlwaUlIV250R1FobDM0NmVzV21lNk1qSUdTRmhSbkJXVzlVYXRnUUtF?=
 =?utf-8?B?VmI5cDdDSUpGVGVQclJvNG54TE9rTm9QS3NzZlg2UVhjQTJ2OGJEZzA0blJq?=
 =?utf-8?B?Y0VLY29XdlU5djVTUXBhQ3JpNmxKL2JPY2dWUnhaRHQvM1NQSng3YWhzQnlq?=
 =?utf-8?B?cHpWY2JPK2ljOEtCWktpRWtMNWE5VktJeHhYajV2dlhSaWFUL2I0Y3R0SDhy?=
 =?utf-8?B?OTQ3Qmc0cnRHMXRJOHNJK2ZDWnpJK0Z3Zjk4RnBJOFVJTDd3dU1QdTltZm9u?=
 =?utf-8?B?WlFwU3dkcmhhbFZZVE5MYXluVjBSMURzQ3VtRldwUk15SEZyRmtFS3pseXh5?=
 =?utf-8?Q?crJ4sDdOw7ZeZCCSWdIzeVmv+UQ8bXYJAxIgE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SmVwUXJuSGJUT3F4YU5td0FUNDdhSWY2L1Ezald6dE1makhPeTVyQmVoWGsz?=
 =?utf-8?B?U3FQUEYxaW5IYndldkZWanRXTDNqWGtZUUxHaENjeXBJeWNMU2tnd1dveXJQ?=
 =?utf-8?B?YzNLVXYyTGZVZHJhWTZ3OXB4cnB5blNMQzJONlIwQUlOTXRsMStUbmFDLzVR?=
 =?utf-8?B?bVZPUUwyeURxL1hTbUViSllzTHhSWVl5NUxuZjlqMzBWdWtITG1MbFNjZVI0?=
 =?utf-8?B?NzhQYjJ4R2xIeWxtT1I0TE9JdURncVpab3R4bjlXZUFZejlKK1JHSDU5YzVI?=
 =?utf-8?B?SUg3UGJTdldaZXFISWdTZGlNZlkxWE5HTWhwUW5PQmxMNDE1Mk45UFF6Nnl5?=
 =?utf-8?B?Tlc0THhZMFdOTUZ6Nmh5ZGVSTTFFQzFLbTdwd3l5TWlubHJIdFlPd2FwQWdw?=
 =?utf-8?B?ZVZlKzJndDhJbFU4bjBwcmlxRGxxZm9UZ3pLdjR3VmNyL011eDF1YTJ5bDRv?=
 =?utf-8?B?cDA3ZURPTmxrT0FjWVFabDM2UTkwTmp6cVRRQnhRYW9XY09kQkY2R3pPY3h4?=
 =?utf-8?B?WVZTZ2wwNzZoVnBLZmt2WXNqdWRHcGd3R2ZBV0w3VUh5MWVTOGQ5bHo4ZUlX?=
 =?utf-8?B?TTUwcE0rMUJCUk9kQTdWYlZnbVAvSW9GdGZ5T2dYcVErZ2s3VkdZVWdzcUF1?=
 =?utf-8?B?Z3FLc0FKY3BRKzFoZ1ZVZjl2dnBtZHNWR3VXOUhINCsvWldWNzdYK3MwRWll?=
 =?utf-8?B?aTQxckR4QkhUTCswS3FxYlEzamM0bnJMbVAvZXlCY0UybmNrMitlemc5azFE?=
 =?utf-8?B?aXFCempPd2hZODkxWDVkSklVQVUwVVRkbEEyY1RhM2cvY0tWQ1habmI5NXVX?=
 =?utf-8?B?aTE4YnFqenI2WXBoQVdwbyt5RUpuS2M2bnNuWGYwMzJPeW1yNldLdVlBaDkw?=
 =?utf-8?B?QnlsYTBFK29ielU3cHVWRGR0NnJwTEpYOFExUklHVFM0YlAxVGp0N1JGL2Jm?=
 =?utf-8?B?V3QxbVcxSUpFbHhXU3hERStpMmFUMU9QNE5WKzNPcFpmYVBWeVYrdGtyeUN2?=
 =?utf-8?B?bzlxNUxXNFJUQlArVm41K1Btcm9VM2ROMld6YW9BZDhiMFVlR05qTWQ0Y1NL?=
 =?utf-8?B?NlA2TW43UTYreGJGVktXbmFsSko4SEtzUFpXUUN6NmhMQzF0dmttbTNPR3Fo?=
 =?utf-8?B?L2cwMEJBcnl1NHlCdldLaDNvaXVqVXF5emZsY2NiOFFMYXNyNmFHMmlEelgr?=
 =?utf-8?B?Qm8zNUdiR1dHTmJmZmRnazJ1OEl6SEViTkttamwzVmdpQXBKaXJzTytNSUZZ?=
 =?utf-8?B?eG9oVVNlMlFVdUlVaVhyTkNmVmRjT2hYL0VhOEJsa3RZZ0h0WVladStJRXJT?=
 =?utf-8?B?cHNLQlhIclNkN3FmbGJjWDBxT0k0K1lYb1JFZWphVEdNQUlkUVBYcVo5S1hu?=
 =?utf-8?B?WTh2M3BFZDFINnVFLzdka2hkeVRIbC9lY3JPVnAvcUF0azgvV0F5YmQ1d3p4?=
 =?utf-8?B?TnU5RlZVZkJ5RFFiUXB6N2lUVE0rb1BRQTgxbm1UbWVyUC9tcllYK2REWkJV?=
 =?utf-8?B?OGVFdktFbzZxNEVJSVJNWm9YUllQaUp4ekZTdlhtOE16UXZSTFFpQlRHNUFu?=
 =?utf-8?B?RU5UNVY2b2N3bFdRRUJDUFV2dkFYK1hEVDJLOUhCRjFLcCt5b3pHSHQzOTBK?=
 =?utf-8?B?OHJJNUtWVTBFQ29DeXU1UkxYYzdVTGR3WnE2OUxqL0JSWmZNVnozTkJSbG54?=
 =?utf-8?B?aUYvMHo4bzNZb3RXRWlyN3B5ZDN1Sy94TjR4cjZEMEVrL1BuemF4SFNtY0lj?=
 =?utf-8?B?Q2hvd0ZzNU5KM21admtUOHltR3VzMzVRM0dzRGszZzhNb3Q3L2FzUkdITlAr?=
 =?utf-8?B?cVRQYlJNYW9tcUplMVpMMTlmbys4OXNuc1ByT0Z5TVJQRWphV28vQjI3bnl3?=
 =?utf-8?B?REwwVXNDbnpHV3J5V0xZL0J2dnUyUHhGSURFNjFrRVNCOFdxQ1VyNllXRDNn?=
 =?utf-8?B?alRxemxLQXpDK2RjbFAwUmZkYWw0OVNHazljbFB6YXBJWEcwTXowTGRNcjU2?=
 =?utf-8?B?T0UyemlvQlhFTWROamE5Vk1DOWlQWlJLRFd3WFIzQk50TWpzcXppcmxtRDdW?=
 =?utf-8?B?alFuMGlWZkwxcVVlTGsxc1BkRjdkS2pQQ3pDVU9xNmxSTjNTcEQ1cEVGd1dI?=
 =?utf-8?B?Sml3TEtLOFovR0ZuSkNlWmcyZU1LdjRndVJDK2Y2TnhjRHdiYVRza240ZVVv?=
 =?utf-8?B?S3dWcUtWUG5XODV1cHFoV1JSQXZZRlR5ZWwrVVBha01kZHJiUUFZNEJibXh4?=
 =?utf-8?B?RkJIdnlzS2lSWXZ6ZFpMb2ErNXl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD9D07E99FC8644784580A2D7B9B0DDA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7QwB22NHnSrSVd4/O7jxmOwkYE87E4sDCDU39ec/DlODl2MhbfiSJYdpatU8ACpMCrrLQbxn9CsVxH7j2PmIDFSHOeHfb81ptS4eOXQWCqTzxG/gOGMIk2WlZN/szPJ9vG9RhZOhpzLnDhI4mTrqH9xXQz7VlLxAj5mKUN06OGlP+qpTI7MmSfMWPO6S5gwNSIAR48mj8ELreGEVIlwarpN/jjUEvrauv8i+IdOM1Cnol69OIEMYJ3MwWVAnx5rBs/Zq59bfcbX6o0op2Vox0/welZh7AzlkT7ARxpseMaNJEwjBYcuVxpDzFn3IHLv82tJwOfnFj7WEqtuQw8cB2oxWJtUlkwjILMwMyMzH+adHtAzIlEuRI1Xp/LVs89PEnZ0LXR+fA1GH0o24X50G6SqbYj8hNr3hIAjZ8FQr63CfPCXyO6jAOfw5tlWfUsZWEjd+kMZ0R8ZsiIK+PeYm0A8EMDByyGnf8Q2sW/Mk9X3ZyFmdPf85vI60bCrlnCV3UF2u3laPQ+rvsYBrpwtBCKh4YKC0Igj6RnI9QMyb34/MblpwG3+tSFDm9n6MOLDURdhpVXcOuvDFhO5YdLKCMd5pnKYsWwPLVl2g4l9dEKW4yRb6C723qDZK2HGmWv9r
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c397581-e9fd-4808-3527-08dcf1a9f526
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 08:25:44.3916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nrGFdKh9f4XxApc1HyCdjM+xZ6Lrze2Rc6JUcQbkwsbmxpa0b2R7x68uDKeTQdHbQA/98Own/8Z6+XEjKY3a+qyRNy5eDWtms9Z7xAZwlIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6759

T24gMTkuMTAuMjQgMTE6MDcsIFl1ZSBIYWliaW5nIHdyb3RlOg0KPiBSZXR1cm4gTlVMTCBpbnN0
ZWFkIG9mIHBhc3NpbmcgdG8gRVJSX1BUUiB3aGlsZSByZXQgaXMgemVybywgdGhpcyBmaXgNCj4g
c21hdGNoIHdhcm5pbmdzOg0KPiANCj4gZnMvYnRyZnMvZGlyLWl0ZW0uYzozNTMNCj4gICBidHJm
c19zZWFyY2hfZGlyX2luZGV4X2l0ZW0oKSB3YXJuOiBwYXNzaW5nIHplcm8gdG8gJ0VSUl9QVFIn
DQo+IA0KPiBGaXhlczogOWRjYmUxNmZjY2JiICgiYnRyZnM6IHVzZSBidHJmc19mb3JfZWFjaF9z
bG90IGluIGJ0cmZzX3NlYXJjaF9kaXJfaW5kZXhfaXRlbSIpDQo+IFNpZ25lZC1vZmYtYnk6IFl1
ZSBIYWliaW5nIDx5dWVoYWliaW5nQGh1YXdlaS5jb20+DQo+IC0tLQ0KPiAgIGZzL2J0cmZzL2Rp
ci1pdGVtLmMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvZGlyLWl0ZW0uYyBiL2ZzL2J0
cmZzL2Rpci1pdGVtLmMNCj4gaW5kZXggMDAxYzBjMmY4NzJjLi5jZGIzMGVjNzM2NmEgMTAwNjQ0
DQo+IC0tLSBhL2ZzL2J0cmZzL2Rpci1pdGVtLmMNCj4gKysrIGIvZnMvYnRyZnMvZGlyLWl0ZW0u
Yw0KPiBAQCAtMzUwLDcgKzM1MCw3IEBAIGJ0cmZzX3NlYXJjaF9kaXJfaW5kZXhfaXRlbShzdHJ1
Y3QgYnRyZnNfcm9vdCAqcm9vdCwgc3RydWN0IGJ0cmZzX3BhdGggKnBhdGgsDQo+ICAgCWlmIChy
ZXQgPiAwKQ0KPiAgIAkJcmV0ID0gMDsNCj4gICANCj4gLQlyZXR1cm4gRVJSX1BUUihyZXQpOw0K
PiArCXJldHVybiByZXQgPyBFUlJfUFRSKHJldCkgOiBOVUxMOw0KPiAgIH0NCj4gICANCj4gICBz
dHJ1Y3QgYnRyZnNfZGlyX2l0ZW0gKmJ0cmZzX2xvb2t1cF94YXR0cihzdHJ1Y3QgYnRyZnNfdHJh
bnNfaGFuZGxlICp0cmFucywNCg0KVGhlIG9ubHkgY2FsbGVyIHRvIHRoaXMgaXMgaW4gYnRyZnNf
dW5saW5rX3N1YnZvbCgpLCB3aGljaCBkb2VzIHRoZSANCmZvbGxvd2luZzoNCg0KDQogICAgICAg
ICAgICAgICAgICBkaSA9IGJ0cmZzX3NlYXJjaF9kaXJfaW5kZXhfaXRlbShyb290LCBwYXRoLCBk
aXJfaW5vLA0KCQkJCQkJICAmZm5hbWUuZGlza19uYW1lKTsNCiAgICAgICAgICAgICAgICAgIGlm
IChJU19FUlJfT1JfTlVMTChkaSkpIHsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFk
aSkNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAtRU5PRU5UOw0KICAg
ICAgICAgICAgICAgICAgICAgICAgICBlbHNlDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcmV0ID0gUFRSX0VSUihkaSk7DQogICAgICAgICAgICAgICAgICAgICAgICAgIGJ0cmZz
X2Fib3J0X3RyYW5zYWN0aW9uKHRyYW5zLCByZXQpOw0KICAgICAgICAgICAgICAgICAgICAgICAg
ICBnb3RvIG91dDsNCiAgICAgICAgICAgICAgICAgIH0NCg0KdG8gZG86DQoNCmRpZmYgLS1naXQg
YS9mcy9idHJmcy9kaXItaXRlbS5jIGIvZnMvYnRyZnMvZGlyLWl0ZW0uYw0KaW5kZXggZDMwOTNl
YmE1NGE1Li5lNzU1MjI4ZDkwOWEgMTAwNjQ0DQotLS0gYS9mcy9idHJmcy9kaXItaXRlbS5jDQor
KysgYi9mcy9idHJmcy9kaXItaXRlbS5jDQpAQCAtMzQ1LDEwICszNDUsNyBAQCBidHJmc19zZWFy
Y2hfZGlyX2luZGV4X2l0ZW0oc3RydWN0IGJ0cmZzX3Jvb3QgDQoqcm9vdCwgc3RydWN0IGJ0cmZz
X3BhdGggKnBhdGgsDQogICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGRpOw0KICAgICAg
ICAgfQ0KICAgICAgICAgLyogQWRqdXN0IHJldHVybiBjb2RlIGlmIHRoZSBrZXkgd2FzIG5vdCBm
b3VuZCBpbiB0aGUgbmV4dCBsZWFmLiAqLw0KLSAgICAgICBpZiAocmV0ID4gMCkNCi0gICAgICAg
ICAgICAgICByZXQgPSAwOw0KLQ0KLSAgICAgICByZXR1cm4gRVJSX1BUUihyZXQpOw0KKyAgICAg
ICByZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsNCiAgfQ0KDQogIHN0cnVjdCBidHJmc19kaXJfaXRl
bSAqYnRyZnNfbG9va3VwX3hhdHRyKHN0cnVjdCBidHJmc190cmFuc19oYW5kbGUgDQoqdHJhbnMs
DQpkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvaW5vZGUuYyBiL2ZzL2J0cmZzL2lub2RlLmMNCmluZGV4
IDM1Zjg5ZDE0YzExMC4uMDA2MDI2MzRkYjNhIDEwMDY0NA0KLS0tIGEvZnMvYnRyZnMvaW5vZGUu
Yw0KKysrIGIvZnMvYnRyZnMvaW5vZGUuYw0KQEAgLTQzMzcsMTEgKzQzMzcsOCBAQCBzdGF0aWMg
aW50IGJ0cmZzX3VubGlua19zdWJ2b2woc3RydWN0IA0KYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFu
cywNCiAgICAgICAgICAqLw0KICAgICAgICAgaWYgKGJ0cmZzX2lubyhpbm9kZSkgPT0gQlRSRlNf
RU1QVFlfU1VCVk9MX0RJUl9PQkpFQ1RJRCkgew0KICAgICAgICAgICAgICAgICBkaSA9IGJ0cmZz
X3NlYXJjaF9kaXJfaW5kZXhfaXRlbShyb290LCBwYXRoLCBkaXJfaW5vLCANCiZmbmFtZS5kaXNr
X25hbWUpOw0KLSAgICAgICAgICAgICAgIGlmIChJU19FUlJfT1JfTlVMTChkaSkpIHsNCi0gICAg
ICAgICAgICAgICAgICAgICAgIGlmICghZGkpDQotICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJldCA9IC1FTk9FTlQ7DQotICAgICAgICAgICAgICAgICAgICAgICBlbHNlDQotICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIoZGkpOw0KKyAgICAgICAgICAg
ICAgIGlmIChJU19FUlIoZGkpKSB7DQorICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBQVFJf
RVJSKGRpKTsNCiAgICAgICAgICAgICAgICAgICAgICAgICBidHJmc19hYm9ydF90cmFuc2FjdGlv
bih0cmFucywgcmV0KTsNCiAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCiAgICAg
ICAgICAgICAgICAgfQ0KVGhpcyBpcyBjb21wbGV0ZWx5IHVudGVzdGVkIHRob3VnaCBhbmQgbmVl
ZHMgdG8gYmUgcmUtY2hlY2tlZCBpZiBpdCdzIA0KZXZlbiBjb3JyZWN0Lg0K

