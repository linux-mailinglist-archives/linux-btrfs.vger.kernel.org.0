Return-Path: <linux-btrfs+bounces-6319-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DB692B118
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 09:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392042820DD
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 07:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23A113FD86;
	Tue,  9 Jul 2024 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZeWWJhKx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Wci6XeCs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4768F27713;
	Tue,  9 Jul 2024 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510273; cv=fail; b=EdP9TCSPIopokRsWRtE/hwCqZ7+L5S0mt3TFYGSrDMoK+tiyIeyllBD7Dm1TUxdVe93n9OgeCxUAy7HXMBWvp50ZtzstXyYbT0RrjlPAhUN93PcZBJOgUvEza7D/HYS7JXavXDT+6uLn/Nifn1f+E+jmkAc64cTqN0wOvxPI6Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510273; c=relaxed/simple;
	bh=M4ArTHDX6FxPx3kHBkSl9mYZG9F+pFVFhxnHhT5n/Zg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PX/9jNYn0F8D369ygIqbjYo0rSX83EDGqQwQXybxR1B6qZ2XFyq9qIGQDsxwFuO/Djsgehst5a6DfQwHdMH4WwjtAy3bZ+8tRN2EbhrYm1bWslHH4AjaU3smdfYQX65/o6bVjPunfI5aqve35O2XNBKD6v6tISg88gVVKnkN68Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZeWWJhKx; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Wci6XeCs; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720510271; x=1752046271;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M4ArTHDX6FxPx3kHBkSl9mYZG9F+pFVFhxnHhT5n/Zg=;
  b=ZeWWJhKxBd2nWNAyCJsAn3cJp16Xy5GQXLnIthy1LcYSWj5DB726/a1p
   jzAqNd8gxOFoOTjyi2TemSTkaLMLU4JwE1NgpPFDYml1ca1MpG2FrdSFH
   x8Aeqxpdrc9gyRTPayWzSnVPPtwXShjIDUMiNCl2986raSazU5w6GyPQ5
   rs/BWJAdYi6ajRExjkqXhSpLkPfJGYOWnP8jjGDz4un2TEpq0hYlXpeNY
   THegStSwXXvbkkMjetr2/+6p1uWz5GmwHjvju5hIgzHTO+7cex5P1cmXn
   nHkzqZYWvJO3da4LGJ5PGjxZwlX/YKlB8Bsr7jGgOd8AtQNldzAJ6ukLu
   w==;
X-CSE-ConnectionGUID: rP01wDHJSQq35em/hEVqcw==
X-CSE-MsgGUID: OFVXB3kSRyywEx3dI4ICxA==
X-IronPort-AV: E=Sophos;i="6.09,194,1716220800"; 
   d="scan'208";a="21100195"
Received: from mail-eastus2azlp17010005.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.5])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2024 15:31:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmtqHeKD4G1MFjyoJi6SrPspXSCRyljS8BETYQVJFOpGEUDaKyOn1hEhfJsg84Avh0jj2sHOkdj6MT1RibBIRWHgH10bh1UkmgWKrEm33v7GWbe4RrlgY2f08ocpr+E6VfC5e/6156qLIlBPOScOZ3lLAUrmHl4whivbmWXOsBLElZD8FJ+iiTiNvQr/qEaWqXw6a+HAZzLr/kKAV6SYksMu8zswPqG2TwgjdXMjxRVaE0o4gHsiMCF6vmE2zKa04XmRJSq3oYfr+dMgrO883tLWWYBhMZnPdGO6sqJqmxkWOLFVAnDV9Y2pdUf4YsQ9arYKgOMg9uhysewueSQFkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4ArTHDX6FxPx3kHBkSl9mYZG9F+pFVFhxnHhT5n/Zg=;
 b=VbbU3x4SOB+vgO7hFVUoTfUvV3q9KYBHbg21OBCaGeDumAyd1/osDoh3g+BFdlkK5my2l9Jlah/sxCLIyXKbk9gewcBsXg+bUjIj6luWzgOkSBiWU+vNq7UbfLy2yrRZ2e9znYppanrHjCkL8ifY8o7jUtTefOLn1cgZurqisdBU+EFaLU2sSHq4WcQSpmGcdb9XRAl/PlKxgoK9/09undbxVNpgGZ68qJImCFQHvDouvf0ydeGB9VOdINBIMaBVLArrAbP6qf5EXLWmhTOvi79ckSeHrEKBLGAWZWZcgG66r3iN5TmB74qiNMc7S34SlmZdtidYAwOarteU3sRgyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4ArTHDX6FxPx3kHBkSl9mYZG9F+pFVFhxnHhT5n/Zg=;
 b=Wci6XeCsX4DBPhW4dYWX6+H45hydFcvcQ8KRNLqM9a20rBmOn4OyBhkba5/Rfv2p7WGDyBq7p0p0CcinKLghKixOH1LgCX77oLyGz8RMQnjkAweGPcBcOZxtmFGT7FRWvNeJbatuPO2/4n6Q/5R0oyM0VDkSiMESiarcOtPgvVM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY1PR04MB9659.namprd04.prod.outlook.com (2603:10b6:a03:5b5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 07:30:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 07:30:57 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Johannes Thumshirn <jth@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Qu Wenru
	<wqu@suse.com>, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 2/2] btrfs: replace stripe extents
Thread-Topic: [PATCH 2/2] btrfs: replace stripe extents
Thread-Index: AQHa0cnFYxZwEtx5nE+YH67cGV/QJrHt/NcAgAADdAA=
Date: Tue, 9 Jul 2024 07:30:56 +0000
Message-ID: <09f08d98-a615-4952-9949-daf4a7119b96@wdc.com>
References: <20240709-b4-rst-updates-v1-0-200800dfe0fd@kernel.org>
 <20240709-b4-rst-updates-v1-2-200800dfe0fd@kernel.org>
 <4211723f-ddc9-4646-91c3-14a9a1769d22@gmx.com>
In-Reply-To: <4211723f-ddc9-4646-91c3-14a9a1769d22@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY1PR04MB9659:EE_
x-ms-office365-filtering-correlation-id: 4b6677c5-31e7-4cc1-f2f6-08dc9fe912ad
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0pMQUZOcUhCRFpOTUJJZ0MxSXRhQWs2cHd1eDVVdy9LdGxBWE93dTFKL2Iw?=
 =?utf-8?B?STM1aWtMVXByN3YrcTlFbUJmTUJHVXk3R0pVWDdSS0ZMS284d0dCK2pkblo4?=
 =?utf-8?B?NytSZ3ZOb3drclNkZm4zUEk1Umk2QTlBNmlxck9NSHJZS2hPZzgvYUJJbTUy?=
 =?utf-8?B?bVAxaDc5RkxDZnIxRW80dm1LY3RndUd4WENPNGlVWXVQWUlXQk5Wc2FLQ2R2?=
 =?utf-8?B?NHdKdGNwYWwzOW5hNkVVSGVOblBWRGFWMzdNM2Q0ektyalN5SFM3RkVUVlNY?=
 =?utf-8?B?SWVZeVRUak5pbFRLTGlpUlV2OXlrRFJxaktKZlV5cGZJZGZuZXlaYUxkTTdv?=
 =?utf-8?B?YmJISWF3RXRhdmdtNjMwWDJ5eHlnRm1YV2tWVkdHQmxJazdTdUsxR3ZKZjJV?=
 =?utf-8?B?MW1veUZ3M25qZWFscithN3Exck44UTUzQkpRd2lINldXNjhOaklseXIwWnE4?=
 =?utf-8?B?OUZ1d0NBYzRzRCtsdHVWdTJCU3hESk16SWl0M3dGcGdhUWt1czh3QXg4Nkh3?=
 =?utf-8?B?cEJXUGFHWjhxMjBJTTFMUUh1dmp5dWUzem1PNVhMd2dRVmRNSXQ4MTNaY0NY?=
 =?utf-8?B?WC8zNFh5Tkl2VGlsUVh5VlEvbkJ4U2hBNzJoZXd2QW03N1Yxc1oyMVRmYkdu?=
 =?utf-8?B?d0szekxtRUlFM2t4K1ZENTgrYnpxN2RwT2VabmlwVEpVY29CV2FrSno2MHF4?=
 =?utf-8?B?RlRCWkxSS3hTam92Yll4MjBaMUVsaC9zUFM5bEl2dWJsUjRBM0ZYNGthak5V?=
 =?utf-8?B?anZZTGh3WXk3SXp4VFhZczZ5TG1FcldTQkljWVdma3YzL0lFc29MM3pxQ0xq?=
 =?utf-8?B?M2ZrL0tESEszNHhwbjIvOTdGVjdSOGtGWFJvM2phVHkrM3VGTzRRck9TSmVE?=
 =?utf-8?B?aUx3eWw5Zmc2Zys0R0UxL2krUllWZWJmcDBpcUs3NEphMUpldFl6Z1VXT0JE?=
 =?utf-8?B?cWwwc0gzdk83RnFJb3BHcTVxR1dnOGVFU09TV1g2b3RGWURVSVEvdlBDV1R4?=
 =?utf-8?B?bnBVc3BlbFNRQk9XN3U0WS83cWhnNDdwS1E3ZU5tUHZlQzhMQU1tNjRBaG5r?=
 =?utf-8?B?aURNeTVDYWwza1ZNMmZUaThYNkJWR3d2QkRYSi8yZmJleHBoekJsUXErZTZR?=
 =?utf-8?B?WHdkVFZmUDBrb1lZNE41VzNGODNrMW4zVXBHK05TM0NrdWpuT09jWkRmNDhW?=
 =?utf-8?B?cHRRa0E5ZHdKa24rVlRVU0FkUVNTRlJlZm9EOHJZaDJMbFd4V1NudDVTMzhu?=
 =?utf-8?B?bngrYzZ1dFhJSTgrUm1lQjZja3ZlbHJRZ0NPVUJHNml0WHRWUHBQeG9OM0ZE?=
 =?utf-8?B?Wnk5c1JPSWE0Z1hMR2dtU1Zld2dlM1NHOGQ3Z3E1QVRseEZkZkJodmEvS2xp?=
 =?utf-8?B?Y1lyZEoyVXpycWg0a1k3c3FjT0Y2bjRBVjl5Qm4zN2VTUTdFNFdyTTIyRDRD?=
 =?utf-8?B?VXlud2dvWkVEMmVQek9jWTV1bFN1WW1ETXFqRkdXbFRHb1g5dll0WjVEOHdL?=
 =?utf-8?B?eUFoMHpIelM3c25XamtKckt3MVU1VFZoVDJYZnU0clExREllVW4xeWMwWXJa?=
 =?utf-8?B?eVhocElEZjgrMHN4cFMvUlRqbVE5VGJ4ZXJ3M0g0RklrTnBxUWVuRG5KWU44?=
 =?utf-8?B?OU5Uakh6Ujd1SGkvK3RkdU9zTlpvaVMzdFlFdUdCRDFEV3V5eVRXb3JNcC9l?=
 =?utf-8?B?YTBWcjNCQ3pJYjA4ZlN5ZGx6aTJGdnY3UytaQ1pnUDZYa1BoNVdQRzZpZ2ZP?=
 =?utf-8?B?Wks0MXZvT1lnbEVqdE9YRDdScHdwYlBucWdmMTE1MXRzbnc1b01kSzlBdHI5?=
 =?utf-8?B?THBlbmM1VjJkOUlWYW5nMXFiUVRHekg4aElnNGtKVjZVa3VabUpLRHZHUjFn?=
 =?utf-8?B?am44c2daTFIyaDZZd3hJMFBCeHNWdEhxaDFUM1pleFpZRGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUVxdlBSblA5RlVRRVVZRVZLNDBEV3JKcEg5ejBZbzNBTU51dXNnT1ArV05X?=
 =?utf-8?B?TTNiNlNHWUg1bGZjb2RJbGhNMnIyNkI2aWdnS1lzTlpXaWtHQ1c0WStJemJl?=
 =?utf-8?B?eGl0RHZ0WGpHRmFPNENXODY1bXZZRXcwcXJlUnZlVGVFNVh5cmN5KzJrbVh2?=
 =?utf-8?B?Z1Y3R3pQTzA2UTl6K2NHTlZ0TVN2a2xURmhGd2pJQmtzZTdIUDJVRDM4VTdk?=
 =?utf-8?B?ZHVyM2w4Z0QvQWpsUzN3SmRHRWxPMmZ6a0ZsMjVEckEyVTB1ZVIxWGJWeUd6?=
 =?utf-8?B?Zk5LSjhpMmErbkJJSHEwbU9zaytyZTkzSitTcmwrNGY0alBGd0xZbHRmcnFU?=
 =?utf-8?B?cEx5ZGUybmJTM2g3UjFVbjJKNWxTM3VNM3JuQjVGeEJUQmpQR243MjNCRUd2?=
 =?utf-8?B?NmVVaVhCVkFkZmZHRzlYdi9HNjJ4UFdCUW05azRVdGdaTklEbHd5dndEakg2?=
 =?utf-8?B?ZmFMcHFzR056ZlVUQW9CQWk5aElRWWZXVlJKYmIwanhUNzVVQ0JhTEFXQzMv?=
 =?utf-8?B?bzdabmJqcGFzcHZ5VGJhbENNQ1UwTEVxQ3E5OXVzeXBkTkVYQXRJRHhKc1lQ?=
 =?utf-8?B?aTlXMUdnRlJDNU5MRE9UQ0d1YWlndDEvT2dkNGQrQ2dvLy95NitVblB4dGt5?=
 =?utf-8?B?SGRIaG1ZaU1wbmg1TUZDazFPYXFkVHBFMG4zb0tSeFVTVGliYkJqRGlkRjkv?=
 =?utf-8?B?Yk8rSjJWbDgrY0dER0RyRENxMDdteHkvUFc5YWZBQkl3ZXhPbXFieE85VXlB?=
 =?utf-8?B?eUF0bTBLL0hTM2RtYjZ5b1pYMFBSdU90Z1hIZnRZR0E0dktnVnFQcENWbzUw?=
 =?utf-8?B?L00zUHJmbHRXNFkzVVFkZFVYK04rUnE2UHc3ZUN6Qjk5cm9kQnRGNHNXTnBY?=
 =?utf-8?B?MGdYc1k2cmNwQStoaDJmUjhxQ0Q1R3JKWU9jUWR2eENoNWRFemVFQ3VHWVAz?=
 =?utf-8?B?V1NmQ3hUOWNWa2Q4MzRuMEoySWlES3daOEJuNW9kSkxMMkVZUTNZZENjOERt?=
 =?utf-8?B?OUY5V0FHbGd0WlM1ODFzKyt4Uyt1VXBBMHlCYzFLY2J5ZVlZL3FUNmZoM2Fh?=
 =?utf-8?B?RWYrZkttWTNTWlFTMElYSXg5SVJxY2xxd2JGbmY2eW84NnRkcnVXdnpnYVIv?=
 =?utf-8?B?S0tOUnI4N293ZnNreDhYNU1hYVppalV6YkJyRnZoQ0NrR2ZBa0Q5bVdDNEg1?=
 =?utf-8?B?czZjanNSaWJiTUM2OVE4QXNzRjNYU1FUMEJZblZZMnFVNmxET1k4TkFORHNZ?=
 =?utf-8?B?a3JXRlhDbEVGMVZVUlpZMTJFQ0JrSG8rbFdOeDlwRHU2a05wOEJrMy9RMlBV?=
 =?utf-8?B?ZmIzV3F3QTNiSXZkT28xMS8zMkVadE5EcklHZ210UitaN1BtQVZEVkpjNEZZ?=
 =?utf-8?B?ekkyNXoxWDlDbnRLZUJmeUd1OFFaZjVMem9MN2NvTmxhUDJLUXVzbFJ0Rk1J?=
 =?utf-8?B?Q2FmaWh4WXVRUDZhY0h3NTc0RDVqYU5FQk45RXNkWTcrNXMxT08rSjRJTGFR?=
 =?utf-8?B?UXliU0sxb1Zyb2JpTEJYK0R2cTQ1WTZDVmJyaFZPZTNHMk9RU0tWWkwyTWdN?=
 =?utf-8?B?d2dDTlZYWE4xUVcxZ1d1RDV0aG5PN2w0SlBXY1J3OTlVbk1VMU5ScHNFd25v?=
 =?utf-8?B?RnJkb1FFaEY5Tm1mQit0bW5MTHJYemZacFd6czVEQ0p0VVdDL1luKzRvMHdG?=
 =?utf-8?B?bzNpQ0w1Yk5QcTFtNEdOdzJtZk54OGJGYjNzd3gvbURiR1h4bGE2eis1VDda?=
 =?utf-8?B?aHdWMHpKVWFKRWhzTHYrcFgwQ3hxSmJXY1pDdW5YY1B5QUYvYWQxRGorR2dx?=
 =?utf-8?B?UHNVQjcveUtXS2xRUXFlU2ROdFFnNWFHUHlFbzRPeENXL1J5VDhodHg1Sm1a?=
 =?utf-8?B?NC8xdUp1MDF0bS80ZlQxa2Q0VVFWdVBxNEE4ZDBiTGxTQU1PczZ5RW9Ld3J6?=
 =?utf-8?B?Y2Nadnh6RjVlS2tjZHQ1WkJSYkpTOGRjZitjTCtGNmtPRTFCRldTYm14azhw?=
 =?utf-8?B?TjlGd1pVbUNRY0ZzU1JITytlOWg2Y1htemg4ODhLbUFFWFc5OG9xYURTVWxw?=
 =?utf-8?B?L2xDVFVuazNMNDVxdmxlK1RrUjR1NE9xOGN4bmRnUUczWVFoRXpwcklLSGlY?=
 =?utf-8?B?cFNmWG11alhvaS8ycWljOEZaZVJwcXBXMHZkRkF4aTdDVFRocEJZRHFyTWFI?=
 =?utf-8?B?UlpvaE1QZTE3R3E1eHpWNnRkY0p4VUVhclVhekNnNFVTcGJPUnVJcHJVTndr?=
 =?utf-8?B?R0s4VGNNRDdjSVZzU0xnWWNMa05RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51E7DAA974A02E44895A5A920434CCCC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VJI9BrfvIQiPElEeeJl4eboD4CcH3jYldSzHWxZpgQ7U5PVUzKrUXj2Db+LgIgeLKoAZV8HUbMFg/PJrECiAy+WbALukTHYJjxMSOIcy6tiHcdeBeTRUYEe/NgtgT/HOKFaegs3U2MqHz5Njoat4cwFAuI2FYsbDb8z+jUvZHIR5vgPeXHVNbsU4lpD2jbgt1XXVRCLdlR4OcMihfD+c+7rQdIcJai0Ie6o2JppDfY92rV+HTb+h5frzh6VcFJOUtJkMjpoGRQQb2GEnwWY3VTCCSQdp90z3uPqhsl0gZ64FjvyoBpTS2iqQQX77T7ooeJwsU0WFKrU5vqJ7TY5qyld/tP22W+LNr+PnFB99K4yWF8okhOU/lB8VoWKDbGe+YH80gVGgo92XtBPBy7LmGqukNRPfVuI1uRi/3tPKiNjtmlsMKpZ8SxPiaG3S1ohtE8IrKriNcX94D7DMEIW29jkwxX4o72U6kMHJCBXgWC98/GznW1FL34Mxin6t7xTw0gVIFTL/TTi+PQoyiXqCnBmFcXc/niZlHslunVWrbvHZ7jK3dwatUEBcEkJOEKWHtxLHSUBKThQAs4mezhEFlit3pGyKHI3zpyLti6/POjcs6xwQKUnJzB2C7hyvY/cV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6677c5-31e7-4cc1-f2f6-08dc9fe912ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 07:30:56.8764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJ8btI9dLc9efJtfUZ4D5VyU5CT9ydfQLOCdpXc3/GCcHmShzG91fZAQSgqWEzus8HJcsVs5sLRlOi4fH5L2iDHX2ktRhlHE36xmL2NYbQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB9659

T24gMDkuMDcuMjQgMDk6MTgsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiDlnKggMjAyNC83
LzkgMTY6MDIsIEpvaGFubmVzIFRodW1zaGlybiDlhpnpgZM6DQo+PiBGcm9tOiBKb2hhbm5lcyBU
aHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPj4NCj4+IFVwZGF0ZSBzdHJp
cGUgZXh0ZW50cyBpbiBjYXNlIGEgd3JpdGUgdG8gYW4gYWxyZWFkeSBleGlzdGluZyBhZGRyZXNz
DQo+PiBpbmNvbWluZy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4g
PGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPiANCj4gTG9va3MgZ29vZCB0byBtZS4NCj4g
DQo+IFJldmlld2VkLWJ5OiBRdSBXZW5ydW8gPHdxdUBzdXNlLmNvbT4NCj4gDQo+IEJ1dCBzdGls
bCBhcyBJIG1lbnRpb25lZCBpbiB0aGUgb3JpZ2luYWwgdGhyZWFkLCBJJ20gd29uZGVyaW5nIHdo
eQ0KPiBkZXYtcmVwbGFjZSBvZiBSU1QgbmVlZHMgdG8gdXBkYXRlIFJTVCBlbnRyeS4NCj4gDQo+
IEknZCBwcmVmZXIgdG8gZG8gYSBkZXYtZXh0ZW50IGxldmVsIGNvcHkgc28gdGhhdCBubyBSU1Qv
Y2h1bmsgbmVlZHMgdG8NCj4gYmUgdXBkYXRlZCwganVzdCBsaWtlIHdoYXQgd2UgZGlkIGZvciBu
b24tUlNUIGNhc2VzLg0KPiANCj4gQnV0IHNvIGZhciB0aGUgY2hhbmdlIHNob3VsZCBiZSBnb29k
IGVub3VnaCBmb3IgdXMgdG8gY29udGludWUgdGhlIHRlc3RpbmcuDQoNCkkgL3RoaW5rLyBJIGhh
dmUgYSBmaXggZm9yIHRoZSBBU1NFUlQoKSBhcyB3ZWxsLiBJdCBzdXJ2aXZlZCBidHJmcy8wNjAg
DQpvbmNlIGFscmVhZHkgKHdoaWNoIGl0IGhhc24ndCBiZWZvcmUpIGFuZCBpdCdzIHRyaXZpYWwg
YW5kIEkgZmVlbCBzdHVwaWQgDQpmb3IgaXQ6DQoNCmRpZmYgLS1naXQgYS9mcy9idHJmcy9yYWlk
LXN0cmlwZS10cmVlLmMgYi9mcy9idHJmcy9yYWlkLXN0cmlwZS10cmVlLmMNCmluZGV4IGZkNTY1
MzViMjI4OS4uNmIxYzYwMDRmOTRjIDEwMDY0NA0KLS0tIGEvZnMvYnRyZnMvcmFpZC1zdHJpcGUt
dHJlZS5jDQorKysgYi9mcy9idHJmcy9yYWlkLXN0cmlwZS10cmVlLmMNCkBAIC01Nyw2ICs1Nyw5
IEBAIGludCBidHJmc19kZWxldGVfcmFpZF9leHRlbnQoc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRs
ZSANCip0cmFucywgdTY0IHN0YXJ0LCB1NjQgbGUNCiAgICAgICAgICAgICAgICAgLyogVGhhdCBz
dHJpcGUgZW5kcyBiZWZvcmUgd2Ugc3RhcnQsIHdlJ3JlIGRvbmUuICovDQogICAgICAgICAgICAg
ICAgIGlmIChmb3VuZF9lbmQgPD0gc3RhcnQpDQogICAgICAgICAgICAgICAgICAgICAgICAgYnJl
YWs7DQorICAgICAgICAgICAgICAgLyogVGhhdCBzdHJpcGUgc3RhcnRzIGFmdGVyIHdlIGVuZCwg
d2UncmUgZG9uZSBhcyB3ZWxsICovDQorICAgICAgICAgICAgICAgaWYgKGZvdW5kX3N0YXJ0ID49
IGVuZCkNCisgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KDQogICAgICAgICAgICAgICAg
IHRyYWNlX2J0cmZzX3JhaWRfZXh0ZW50X2RlbGV0ZShmc19pbmZvLCBzdGFydCwgZW5kLA0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZm91bmRfc3RhcnQs
IGZvdW5kX2VuZCk7DQoNCg==

