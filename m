Return-Path: <linux-btrfs+bounces-13461-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFEBA9F3CC
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 16:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD37217FD3A
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 14:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAEF26A1AA;
	Mon, 28 Apr 2025 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A+OiDcr3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uOkUNRJf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69094C91
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745851784; cv=fail; b=tyP734IsB+hqAEG4dk1xdamWR8jMe9TLO3VcKX4Wk1wuPpEWu8PwpvDxEZ/o40otVaXZ57e0a3I35ChETHqTxJ9ScVo+BeiLCV6MKBFZ27OrpC9QEmtR0rJhvEEUcM2cVpnVjSxIEdZD0rGVXb/uLeAXqEkGEsmpAPJhfB0N6dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745851784; c=relaxed/simple;
	bh=U/8G08BWuDl98523KGWuDSuDyQ4pxMMafEoNtfRxejg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dTZvowRZaWcN64tvsFUp61O378DaVh7VBzEXWOMkLDKOHPEgs97QrYkLSxI0USDTecnLscxzRbrZmOjzGeKloR72/XNoZxZ74OVmibVIOyEaIJZ0vUoi/OdFSs3KTbfN9HLaAt77gixH54BfGh36TnRufHJpEmGHaFb3l47jASM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=A+OiDcr3; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=uOkUNRJf; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745851782; x=1777387782;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=U/8G08BWuDl98523KGWuDSuDyQ4pxMMafEoNtfRxejg=;
  b=A+OiDcr3xqP50Eg0jsTmGkCGRikQ3WOrOBQrCWuYHzn+3lqmRb7AaZxD
   l4mBmRzkK+sqHBBW8195uKoGMVFcRWBPRBQLlswabCQFe3TQ+toymRhxt
   uJQOpaKxvRg9b9yben9IDIx1UJCh9drfixP8Rz4FIepbjIlUL2BMYy3GZ
   x5gCwBO5keOKFsmQ8VNmn+7DrVyS2v6vGI55Glzjs9V5cce/inQsYG1rq
   sNIHkfTCBxCRiN1OUk4brNH4Nc0vGgNBWRcoGnrOeoKIHuPHc+ZxoXSF9
   ftXuyWNNIgV6YY2cfLYYN2vJxEUHL4MsVuIov0Mh3e0I31gxCl+m3LDge
   g==;
X-CSE-ConnectionGUID: Y/2QyT9mSW+eoRAExH7UMw==
X-CSE-MsgGUID: Pw5FDX1bS2Gm1OKDIPoVNw==
X-IronPort-AV: E=Sophos;i="6.15,246,1739808000"; 
   d="scan'208";a="83583519"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2025 22:49:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpP6wGG4vqio37oZ6wCD5m4On7B7gHKUxPxs6D1S5tvGfuxWXNNOquwrOqH1APaZJ2OD+y+vjXY/KH2Q+9eZgxg94tvwa0W1qUNm3ryIx6b8Gw+vhe0baTDqUxBdI7EmyQD9psSJT5W0OWVOSaVRGBWFh2NQcTV+fKb+kGuQ/4q1vByObj5hVWzBNSoWI+vfsphAxeCXyH57YTPrApDIcZAuXJ7hjIro83sHMjYPRZhxckJmEM8OGHZuW5BXYc9aC6/gw0Ibnbfl53/syPbMCwVzbpcohUr715OGO+4M+jE/MqH92terhlMxfMqqZUOozfnj2+P3W9qRPxRU3orc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/8G08BWuDl98523KGWuDSuDyQ4pxMMafEoNtfRxejg=;
 b=y2c+LyOU70i9YMQS6xVqTPcSXPC3ijJ7nWSI3dyrm+dWpa7D0yrXpC5o//+IqUl+fcU8VSH1puLKpXpu4MCRDZzAZoiilIhly4i0Xyi4pL0E75Rhf3QPLrO7A2OrK0hc8wx3NSZPDoDx2NZ7rcxJ29wncCkKkQbKRnwGLaHP4BwgCy4t/uAQwkHd/mPdHcC0+58+IaPHKDfOm4XvUqCysZxC+WSjtyknn1ZsE1tRxgtbYR1PBWU0C2IEy+tODM0SYF9uaNpDgR6VLNzVBYpBrSGAylLOIdlAutdOw3moNmiA2d2rQDD11IWWnyxPLCDD7ybLQtNA+nUWV9LMiml0sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/8G08BWuDl98523KGWuDSuDyQ4pxMMafEoNtfRxejg=;
 b=uOkUNRJflY38Aw87EigxpWFIxLIxdH0sl9GBi05jZy0z1WL8onZMpXnRQNRpBkROWUSU7GVAwETKNm0P/l9MGp8SzG6Ud+8+hT3lvSF7PoNSgVuGl9OBN36aaPZR75Cz38Pc63aDFxMKwc0BIWlMU3XIe1mtoAQtDVGXzZClAHE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8066.namprd04.prod.outlook.com (2603:10b6:610:f9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 14:49:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Mon, 28 Apr 2025
 14:49:40 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove unused btrfs_io_stripe::length
Thread-Topic: [PATCH] btrfs: remove unused btrfs_io_stripe::length
Thread-Index: AQHbs5xiV/hDqmoJV0Cr9lZE/UoXXrO5Mk4A
Date: Mon, 28 Apr 2025 14:49:39 +0000
Message-ID: <dcb2e1d3-22ee-4d2d-b0b8-fe69296cb7a7@wdc.com>
References: <20250422153217.256995-1-dsterba@suse.com>
In-Reply-To: <20250422153217.256995-1-dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8066:EE_
x-ms-office365-filtering-correlation-id: 54373e95-46ad-4395-4e4e-08dd8663e770
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3RFUGFiS1ViZWNzbFNNSjB6SGZ0RVVVZ09KUlFkVWxrT3JuMVpTNWRHeFk2?=
 =?utf-8?B?VGUyc2Uxc3JDcW1rVjcvd1hPWThyTVdWQSt4Uk9ZMHVxcVBlY0pWbDFEN2Rk?=
 =?utf-8?B?MTRMM1phR1llNHNaL0ZzQlVkY1d0K0tVUG50R25ZSHYrQzNmN0cvRGxleXpt?=
 =?utf-8?B?MXJCeGxRSXJDT21SejdsZTFQeFVvU1FTVkFKb1ZFS3IwS1RNMVJIT25GQ2ls?=
 =?utf-8?B?RHNEekVoaDZxUmFjYkhSZjdWZmNLS21tOGVCTmo2VFRINnNxVEdQYW5RaUZt?=
 =?utf-8?B?ellyY0RsMFhyWWxGZHRkMU1aZ3U4U1BydjNYemxmc0hSc0VXVzVFNVdaTThG?=
 =?utf-8?B?MmVWZXFhV2JyZ3F6dUdVVUd0MEhtdk02SWhpUUdTTHhnWnR1dm5XZnJQRmdI?=
 =?utf-8?B?UTFsWnQ3RDNIMlZBOGw3b2R1Qk1BdjdiWldocWVaY1FDcFVZM09zcXc1blp6?=
 =?utf-8?B?OVBrMTNGZzZHa3A0N1VLM0NpZjhrSFFFYlQxNUFqZi95d3VzalZTQk5yZU0x?=
 =?utf-8?B?b2NDUkJIK3BZK1pYTCtoVm5aR2ZNdUNFd2F4TThIVVk4bk91UkhMWjlPWC9Q?=
 =?utf-8?B?MXdJOEQrT1NtcWlqQVN1MzZ4eEo0cGhNL25jMU1zM1FLNFhHNmlQZEJDc3kw?=
 =?utf-8?B?Q0sxVzdqQ1FVOVZLSTl0WmJ0S28wRDdqUHlnU09IMnkwWWlxRlRocEVOOFpx?=
 =?utf-8?B?Q2VNaTlrWGNSMmExc0tWQTZQYm9Ec0JyS3k5d3pyU2lZVVlXUVVMNVBjVXBO?=
 =?utf-8?B?VS9NR0NhbmM5VGNsY1JhNEdCem1nNnl3bTZHNkR6UXk3dlBRM2pZOWUrQUdh?=
 =?utf-8?B?SUhnRUJGNGdTT1JJanU1NHl3Mld2UGpWWkZrTnNsT1JqR0piNXdnVGJCeUxj?=
 =?utf-8?B?b1lxQUJNUzI4OEIwRDh2UUIrM0YyMitkU0V2S1VuYkxQQzZDdWVWK2lrZWR4?=
 =?utf-8?B?eXpqdytBVXdzUHREamdxNjRsWnJLVmhqY3RWcS9JMk94V0g3Q0xEaHdqVXBW?=
 =?utf-8?B?M2ZnT0loWDV4U3M4TmxhUnk1UjRUYlNRTm11UXRkMGk5Mm9wblIzemh6RUlG?=
 =?utf-8?B?V2orZWtYSEw5OWJmZFNGUnhKT2tIYU04S2NId3YzdDdXVStjc1Iyekp5Zm9F?=
 =?utf-8?B?NTNkTUdRam9Edm1MVVRqSFhtTTI4em93WGhBakYraVNVeEgwamhLcW9HTElG?=
 =?utf-8?B?d0JUb3RXK0RyL1lVK1VEb0duOVJUWXJSK2dyODEwVzhRVnlqYm1Bb3NGdEd3?=
 =?utf-8?B?U29BUmQvckdFTU5ZM2pjZDM5dG5wV1RYclVDbi9XVEluQTdOMU9RZEQ3cnJS?=
 =?utf-8?B?RUVCU25HMXRuTHNYL1FhUmtmcXJ4ODR0RS9aVDNYYVZaT1ZMTit5NlRCdGpz?=
 =?utf-8?B?aTEwaW5EZElpUGl0SEdycW9GUThvWG5LV1hHNGtybVRrekNYZjVGZS9lMmpQ?=
 =?utf-8?B?SzJlcURnQmhDb0crSE1NR1Jycm9uMHREVE9YOXJVY09HcC9JSDNVOVdZTXN0?=
 =?utf-8?B?REVtN2Izd0lCdzZ3NW04S21WaFk3UUpYYzVvWmpRS2t0bHh6OTFoQUJrMHdJ?=
 =?utf-8?B?b05rQ3l0ZHY5OHBxVXNReDg1dGFuNXgxMTZ0TFplc21EWFh1d09kbVIxZGRu?=
 =?utf-8?B?UnExWTR0MFUrUHVCb1BiaEJTNEh6aVlSL2c5dEF1VWNZUmZsSndQSWZieUtk?=
 =?utf-8?B?dk9Pa0syUzM0MTBDYVN6V3Ixd0VWNkNEREJaRDUySnlaZVBZdTRjb3JJcDUy?=
 =?utf-8?B?UEx5WUJQRjRONlBDem15dGhnQlBWVE8rSzA4bEpFNEg4eVN3VkpYd2V1MTdE?=
 =?utf-8?B?NWdMQjdON0IvQTJQeXJib29vNW8xSWgrMXR1RC96bFNVZ3RnWmxGUzFYb2o0?=
 =?utf-8?B?Y3crNUdIL0pqRnlla3JZNHUvSDl1NHpZaWN4NW9ReUc4dUxTcUd0NDNvNWpP?=
 =?utf-8?B?cEJVdHc4d1dMVng2M3RhYktjNWlNQ2h2bUdIeTFRTXpvcjZsNFJ2aG9KOWM0?=
 =?utf-8?B?eU5iMVU4b1VBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bm52STdmZThPc3hUZGJCZE81U0JpM1AzUk5QaEhDcVcvc1JKVTdzeTY0L3FG?=
 =?utf-8?B?TXZLNi8xZld6UTA5RktrNW1rcHhaUzVZUjRJUDMvQWJoSGY4d0dVN1J6dUYy?=
 =?utf-8?B?RU8vd0ZnTWs0WnNrZ0VBS0huc3ZZUE1WQlV3SWMwY0syTFhiUlVOaTBjT2pt?=
 =?utf-8?B?YVJkc1ZNdXpJZEx4L0tXRHgyeElLRFlUeDEvUXk3eGNTOU1zOGZ1UDczQ3hW?=
 =?utf-8?B?Q080cHVBWjkraTVZenQvREJ4WlAwMzkwOHpna3B4c0VPOE9FOVM5Wm5jRjFT?=
 =?utf-8?B?NVI1UWloZUFzWVFFcDFidmhBWTJub3hVTDFlYnovZkQ1YW5qbDNYZWp6NUds?=
 =?utf-8?B?eDAxakxqclR0b0JOcWhlY2U0STF3Nnp2dGpSNHNZc0lQdzFkeWJSZTVsalVM?=
 =?utf-8?B?ZC8wK1NTSWhtMUcrdGVXTFpaWDdOWEhCcUpITEpJOFRpc1lmSE1XR25RTTBr?=
 =?utf-8?B?anhTY1dHdEt1b3VFdklUcDV0K0hVU09vemM3RSsrQ2FidFNrT25pbXQ0bWNv?=
 =?utf-8?B?eTg5WTIrTVRrSmFnZCtTL1lya0V6emI1ckRFY1hORjdSKytXWkdUcDhLVnFQ?=
 =?utf-8?B?RHEzWGN1QkxNc3c4aXZoR2ZGY1MvSVlPK3g3RW5NN2FaazhxVllPWEsxVjcx?=
 =?utf-8?B?REptVml6c1RWZmNjejJkbDl5ZHp5eDBSYjMwdFdxUjJqYmcvSTU0UjB4eXNs?=
 =?utf-8?B?YnRnVXpxVkowWUUxalRlVW9zOVlNbnE0Q3BOMnp3TUlCUTMzOUJUdFgyMnNx?=
 =?utf-8?B?SEZRamtJZUZ1Z1NJSGNycFBRMW41YXJrcTAwL0JjbHhIWkcydDIvVnAzOU51?=
 =?utf-8?B?UDNnVEFrcXlSS1BwbnlQeE53VnZhN1lTcEw1QVFqczdqVzdBZ2xHa1ppcjlH?=
 =?utf-8?B?VkRCaU5tQjBCVk9uM0VPK1hUVzJmSHBqUC9ZOG1aU0RZdmZVd1BubE9sdXky?=
 =?utf-8?B?bFV2THNBZndRNTB0ZGZWc3FjMzBJbzAyZDNhMmZTSjJ0TEFrT0RabEdibHp4?=
 =?utf-8?B?NHBIazQvNXVab0NzbndEL3JhVVEzUFVyS05GUjVaVnJpamtLSUNtczZLZThR?=
 =?utf-8?B?TityNmJ4SWdiS0VydW80Qk9KMm1ISm9tdDVHVEEyTkcweWhkTXp4UGFXUG9M?=
 =?utf-8?B?Wm5wY0FrQmZJL2ZEOWVWSkV5OXpZaFRFdzhkK1FPcVJ3QU4wZDR3Y3R0T1U3?=
 =?utf-8?B?eHA2alNxenZrZmhsUUtmaWEvMjZDT0E1SVJxM1lpSGc3TkhTMXBaTExCc0RN?=
 =?utf-8?B?WjJZK2tCaUJ4TGFIUWwxakduTmNyY2l6MVpqQ2RFc09TN2R1YkRmMTN2eFdU?=
 =?utf-8?B?MGtoY1ZLbHdiMTFEdDROdzd5b0NxRVp1S3hhTGtYejZuYlFXSFJFWTY5ejNs?=
 =?utf-8?B?YU1GcXltMCtUU2lMRU1MWkNHUUlNOEZlSGpCTHJZenZUSnYzeHphM3d3QTU2?=
 =?utf-8?B?d0tBRks2cUhnSU9GcE40aUE5bENOZDBKWVZOVW5mMm5jWjh6NjJaQzJXR3VF?=
 =?utf-8?B?WHZ3Y2hPcXFJV3Z2TkdrUTRtN1JZdTVSdkZESzN0Nnp2K3RGL3RXRUp0WjNo?=
 =?utf-8?B?bHpLNzgxdFlRdGh1YVBLRnNBbDJ1Wmt3eU8zUE1RaVhnRWpnV1RmbDlJM0VW?=
 =?utf-8?B?N1QwUjkxR0ZZdHBqUUpFdk9CZHVVL2Z0UG9LRFhocEtzZnJ0eEdCMG5ORzBK?=
 =?utf-8?B?RkRtckE4RHF4a0VLZkFLY0twSTY2V3k3OWZFQVBMbWZrTzAyUWtFS09oa2N5?=
 =?utf-8?B?VEtONnFKcUFOV0ZJMWduaTNxRFVIbzhzTWxrWFhPanRxeGkwSDVIZDBpOUxk?=
 =?utf-8?B?MERFWi8zL0xaQWdWQ2RVZTFPRlg2M3dXQ0NKSUFuMHdZamVTNngyazdCTTFa?=
 =?utf-8?B?eHNrVFhNRTIwZHkwaEN2S1lGMXpvVGZJTVdVRVFNQ2FBcUttVEJXSGxvMFZy?=
 =?utf-8?B?TTFxS1FxVkhXV2h1MjRmYTl5eTFlSmFXMEJqSzNMWlVISjEzV3R5RE5LMStp?=
 =?utf-8?B?ZE51MlJOOHZha0JBMERyYW51SW5vVnJKR3NQeEQzVHZEMWFBbUxmOGduTDlM?=
 =?utf-8?B?ZDErU0RnT09uWkNhQWRHamlLTmVpeVJuMUdUUnNkOHMwREorU2NWdXFBeUJL?=
 =?utf-8?B?b21UZklPYjdFQ2lZZ3VmOEJuSEM5RHlOejNwenJOOUZweVcvOFc4anBoM1Jk?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C828379613D18479609FE437286D106@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Pgi+pW769Kyqtz9vE47bNeMuSbvoSZoizjhSTA5mLyHv2ABnTrmfksUICz0kT5hRxElLRyRZ0CTgmX7TlE0STzptng48xCoFr4k1/wU7dYYMH8Gv1Ubtdim/HQxE9qaCf001o3cB74AYKNCfQkFyrk3Tuf4VYez/iuSLz5raIs4N739UrtlcThyODzSmMowPK6rZFXewFpV/vy6Ah69qFelnrT3UFwqQ40b1WluGGyV3apv8E5VgwHvGclxSj1W+wEZxpbNON+cxdfwIUR+mk6hwM2X4aVOHjUZvlIamt3iEMGGDyNUYT/+KZQjrYYRMrwqj0SsIVNjMXS86BTgKLhgMHkZDs04dkN6QsP9aa6TdecFiStAcJ70fGycn+lWnv7HfmF2jDlWyBM1UC9wzbuoqj5X6aTi2v5CNYsBFx6cI9itbM4jhyIHsrriDQ8LqzwpHAfO1OTYDo9IzbJai34CLUfJCecHGz3se9TZwRVn81uf/KG8BdGWUEvbPz2CNrNrwkJ+1oRuv0IlrCkZRt82xLbSX69cibf+QwBjz/YoTPDAekhNRtunqy26eO9u5UlJ8SNnJWweQTbcqUGqH3FudH07NG2h/Y9IAyRcuRlBIeHnm+2pELm8xl1tCJ0p8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54373e95-46ad-4395-4e4e-08dd8663e770
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 14:49:39.8717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XlN19qpl3mG3Ae+FFZIoC/EaCwjQNERv/ECSOR4lE9gamyvKwFAQmia2cwjC+pp3c5iF6orTX9bSfjZEWCnC4fNJ7GYj3qEEXPdaAqGxKoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8066

T24gMjIuMDQuMjUgMTc6MzYsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gRmlyc3QgYWRkZWQgKGJ1
dCBub3QgZWZmZWN0aXZlbHkgdXNlZCkgaW4gMDJjMzcyZTFmMDE2ZTUgKCJidHJmczogYWRkDQo+
IHN1cHBvcnQgZm9yIGluc2VydGluZyByYWlkIHN0cmlwZSBleHRlbnRzIikuIFRoZSBzdHJ1Y3R1
cmUgaXMNCj4gaW5pdGlhbGl6ZWQgdG8gemVyb3Mgc28gdGhlIG9ubHkgdXNlIGluIGJ0cmZzX2lu
c2VydF9vbmVfcmFpZF9leHRlbnQoKQ0KPiANCj4gICAgICB1NjQgbGVuZ3RoID0gYmlvYy0+c3Ry
aXBlc1tpXS5sZW5ndGg7DQo+ICAgICAgc3RydWN0IGJ0cmZzX3JhaWRfc3RyaWRlICpyYWlkX3N0
cmlkZSA9ICZzdHJpcGVfZXh0ZW50LT5zdHJpZGVzW2ldOw0KPiANCj4gICAgICBpZiAobGVuZ3Ro
ID09IDApDQo+ICAgICAgICAgICAgICBsZW5ndGggPSBiaW9jLT5zaXplOw0KPiANCj4gdGhlICdp
ZicgYWx3YXlzIGhhcHBlbnMuDQo+IA0KPiBMYXN0IHVzZSBpbiA0MDE2MzU4ZTg1Mjg2MSAoImJ0
cmZzOiByZW1vdmUgdW51c2VkIHZhcmlhYmxlIGxlbmd0aCBpbg0KPiBidHJmc19pbnNlcnRfb25l
X3JhaWRfZXh0ZW50KCkiKSB3YXMgYW4gb2J2aW91cyBjbGVhbnVwLiBJdCBzZWVtcyB0byBiZQ0K
PiBzYWZlIHRvIHJlbW92ZSwgcmFpZC1zdHJpcGUtdHJlZSB3b3JrcyB3aXRob3V0IHVzaW5nIGl0
IHNpbmNlIDYuNi4NCj4gDQo+IFRoaXMgd2FzIGZvdW5kIGJ5IHRvb2wgaHR0cHM6Ly9naXRodWIu
Y29tL2ppcmlzbGFieS9jbGFuZy1zdHJ1Y3QgLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQg
U3RlcmJhIDxkc3RlcmJhQHN1c2UuY29tPg0KPiAtLS0NCj4gICBmcy9idHJmcy92b2x1bWVzLmgg
fCAxIC0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2ZzL2J0cmZzL3ZvbHVtZXMuaCBiL2ZzL2J0cmZzL3ZvbHVtZXMuaA0KPiBpbmRleCAwZTc5
M2I5Nzc2ZDY3Ny4uZDA2ZDJkODcxM2Y4N2YgMTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL3ZvbHVt
ZXMuaA0KPiArKysgYi9mcy9idHJmcy92b2x1bWVzLmgNCj4gQEAgLTQ3Myw3ICs0NzMsNiBAQCBz
dHJ1Y3QgYnRyZnNfaW9fc3RyaXBlIHsNCj4gICAJc3RydWN0IGJ0cmZzX2RldmljZSAqZGV2Ow0K
PiAgIAkvKiBCbG9jayBtYXBwaW5nLiAqLw0KPiAgIAl1NjQgcGh5c2ljYWw7DQo+IC0JdTY0IGxl
bmd0aDsNCj4gICAJYm9vbCByc3Rfc2VhcmNoX2NvbW1pdF9yb290Ow0KPiAgIAkvKiBGb3IgdGhl
IGVuZGlvIGhhbmRsZXIuICovDQo+ICAgCXN0cnVjdCBidHJmc19pb19jb250ZXh0ICpiaW9jOw0K
DQpMb29rcyBnb29kLA0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQo=

