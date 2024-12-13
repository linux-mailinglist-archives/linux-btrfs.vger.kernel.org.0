Return-Path: <linux-btrfs+bounces-10339-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3809F057E
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 08:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1348A1884CD0
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 07:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB40C192D70;
	Fri, 13 Dec 2024 07:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ye53P6SZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KThP3ddI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FAB1925A4
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734074939; cv=fail; b=NIWzXGTyVEVte7vZSBE44mqqlap4cDwYgU8qc7ObD1ZyAM+z2JkA2JLOjwRyjikcgbsOQ4PnUZnUmC++krurEThkjZaSeEyvx7X7b0JRWWJ/GnBzOev6sp0O2InziJ4lidFuQCrz2TdR9ZCL3Ua4c2AE+D8+PX4RWJdDrV/qz7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734074939; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U3mBD+ALIH024NxiH/r0SABTi6dgsTw7zidVZRSO14p/jO5nUb64fEs81BK1nu8iTl3kgv4LSGJ6blAPwoXOcIpSxPYTxsOD3AHWS4630bm3+xVS6RF4L8QddNUsOHPWgIyA0Pck+1I0TKZ1HGsBazBJm/dHn3GazLSmMwgEUA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ye53P6SZ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=KThP3ddI; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734074938; x=1765610938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=Ye53P6SZ9/Wfo5TP54fNhRw3CbBI8o8V1PYJvGjEsJggRL10GE5uCEap
   peuPzHY4MJQRHvsl8HxWLY3mu+k37PP1DVu4nY4SkCLLxmIuDlXPqvW13
   K2kUIOSK5AiXS2D1ENbYjHNoJCWBkUITM/jAqURg/fgVYx/0WU75PCWjr
   w72RHxO0yfL4yaupwvuFbpyJ6RyfQ2eMoTa9nocMPwAl6RK4R1JiOqb6b
   jlkOIh0ychR+ajMeZ735vZ5R4dHDis5skXVbgeNfYmdJUI0Kco3Nqofey
   DdJ+jPaUubBRRSpjmiB2cQ14RVT9MGqYUW3m8mDHQU2zqV9r9rhNCYU6M
   A==;
X-CSE-ConnectionGUID: pzr+WFK3Snu9ha7RZiFyFw==
X-CSE-MsgGUID: PXkwHnsATeqGQ88W9qAx8Q==
X-IronPort-AV: E=Sophos;i="6.12,230,1728921600"; 
   d="scan'208";a="33781813"
Received: from mail-centralusazlp17010005.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.5])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2024 15:28:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKVWypPrUR6bVV1Y/sm8cK/ILnbZRpNISHl1R7EYHaUv1GjhuULB0DyoIMm5rmq1xrs0pUfZtYSTYq85gV2dY9jOrF78pCPrQuU5gBJoed2zXbfMmIKIwLLJOkT3y+wmVIsfri6fKvGvUqv+21+J9ToxvK2Hlq0EEmxlgDTxrKRk8pgCDNse5xa910kjKN7ute4qnEQQAleNwrShAiP5hc1ICFTFk5D/PowTw8wCQEWtL5hDH8ZynwUYh0CqkRKn81WocZPElsO95yVExvyilO/gjAmjSsI74gAZwz4BsvxWdeMHk2nqB52sadwC3+B3fKWPIKWMOBpgCfk4C9GXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=zW39CrmjXZ2V7q31aaXsRLig9l+hkSQp6P5h75Me3UZiNMmWEzbfJTTduw8MI/v0hPEt5a7pUG56hImy5V8RtdeNEJd/+SIn95EGmcAZcQYjSfYVpdoDBO/GqUIzZ3ntMRqtsOAtrPiA4blqYKgwfK4KdLD0jA1MuRk389RbCSHzknIivPqR/NlbYfMNTxKJsy9B9A9w40pfb/axgEM2FfIXcxXwyjed+dcywNHUr1kTYvKWcJiprYyktEZwiRQRTN3hXHvpkpG3GrUZGtnEossxyvrEyyfnSZn2bwu5iyZxMqKbsZDrX/tgZw76ZB5F+u6D5cDCGE20EKdT4mS9xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=KThP3ddIUBKpKFTyPvqJ9hQJoP1XrDou/nUR8RaXWzLrXZ/ZrQrnV+pPUIhpFs4qzIE16E5WAoZ+jWPslmYfgkpboUs2+up9/4LoeWFvags6x/k67xVfz3oS4yzd9tSU1jD+4vzJgUls1j7lcKAXSW03GUI1CXMF+0I5XwJVjs0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB6546.namprd04.prod.outlook.com (2603:10b6:208:1c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 07:28:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 07:28:49 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, "clm@fb.com" <clm@fb.com>, "josef@toxicpanda.com"
	<josef@toxicpanda.com>, "dsterba@suse.com" <dsterba@suse.com>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: calculate max_extent_size properly on
 non-zoned setup
Thread-Topic: [PATCH] btrfs: zoned: calculate max_extent_size properly on
 non-zoned setup
Thread-Index: AQHbTSplddvjYXf/ZkCSIujvISNHMrLjxviA
Date: Fri, 13 Dec 2024 07:28:49 +0000
Message-ID: <3b751283-c3b8-47aa-9222-7df624e955c9@wdc.com>
References: <20241213064343.1498094-1-hch@lst.de>
In-Reply-To: <20241213064343.1498094-1-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB6546:EE_
x-ms-office365-filtering-correlation-id: f91bfb04-7e6a-4142-7f95-08dd1b47c9be
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N0lGOEgrWEJEczlONSsrN0tRRVhpZlZvZTRjdTNRQWZUWFVKNlMxdkZUWlJu?=
 =?utf-8?B?R2Z6OWkrUlIxMHl3ODFKcU1sSmNFblp3VFZ5MXozdGI4VVJBekRXRDdqLzVj?=
 =?utf-8?B?L0lKK1B4M3BERHVQMXQrT0w3aVdpT0RsWldQNll1SWY0ci8vRmhRYmR5VWdR?=
 =?utf-8?B?Y2UvN3MwSklYdlBJcmxrLzd2dExsWHhtVG1UdjBFdE1HYXpsc0NhdHdLeGww?=
 =?utf-8?B?RWtXdkVsYlpIa2RZTnVpWXRGRE0wNlJFVVNrcnh3TlZCWXY1a0NmSDBiUmRG?=
 =?utf-8?B?Sm5OeGNLTTBTazlFR3p5aTQ4Sy9CQWVSR2o4ZEJHZmxRR2pPMUYrSEFGN051?=
 =?utf-8?B?L2s5Mk5tM2R0V2dCSUlGRDl3SlF0YkVxaUNPODFPYVBMOGJJb1dxSGJBNkZ5?=
 =?utf-8?B?U3dJSThIc0RNKzZ0SmtrTTV3TytoeHgxZFVXWjZMd0NIOVI3anYxMnVRZ0dP?=
 =?utf-8?B?MTBhdnFabVVpRHdkQ0JuaHVTcm1TSnBLTkx6OGRtV0JoK1hDd3lZMjZYemtV?=
 =?utf-8?B?Q3U4MWdpYm5HQXg1QlZTb1JXRnhzNmh6czZxWi8zdjlOaHpCV3NWRWlOaWsr?=
 =?utf-8?B?RjNYaS8zOS9xSWUxUlAwUk8yOG1tZTBVa1JtUmFPMW5FbEdSODU4ejBQaUs2?=
 =?utf-8?B?NGwwSnAxOU5OQm9STldWUlpEQWlkQUVNSFFIYWRsRE9mUFlJOUFNeG1UNkda?=
 =?utf-8?B?NEpDUDJxdzNMalJJc29rS0g0NTMrcTA0emdtNlA5VHVrcXdic3VnVVBoNEs2?=
 =?utf-8?B?eWQzYzZZMHMvNEZLbFVOalp5b1RZMTBGVGF3cU1mQkkzRGQvbjVFWklkWWVC?=
 =?utf-8?B?L1ZiTjk5UVMyWHFnWXhaTWlNdEEzSldVNnhibWJDQkl6N2p4dHNsa1JKRVN4?=
 =?utf-8?B?bjg0aUdrMjBCT0paYkJvYjhJczNKTkN2L1loT0RZMEJxT0Q3c2V2WXdiWlZ4?=
 =?utf-8?B?TEFRTWlROEtlcnVkdXNFS25uR04xWGFCMFZqcGp6RWRldFN2VFRNZWF3MHJQ?=
 =?utf-8?B?UTdpb2VxRXI0QW1QbnpXbDhwYWRtS1FyaEtiZDd0YUczNkgyNEhXcmNISHV2?=
 =?utf-8?B?L01BSzhQYTVZNjQyWjNBM3FPL3pOVHNiWm5ORmk2dXZ3a2Ezb1FtdThMaW5X?=
 =?utf-8?B?dTZoSFFwZVVSRHlSSVd2eXFvK2lscWNvdC83RVpubHVCdGhjZ2diZm1CQVdt?=
 =?utf-8?B?UE9vMlhIdFVVUFdCdHRzbGgySW5HOUd3ZW5udkJhOHJrUEMwREhqYzExU2Zw?=
 =?utf-8?B?RzFjejBCYTI1emtuWkZlKzhHN2RIeldvbmR6ekMrRzh5Y21FK05iMkJ4OWlU?=
 =?utf-8?B?ajUvM3QycFJZSW5sM1dwb3FCQVRnZnk2NHQrWWNteVRCTDZ0bjVld2tpN21Q?=
 =?utf-8?B?VS95ei9sbWN3WWtJUFYvQnlpUm5Zem1NMVlDbmhFdk5HeDNVbms3QzJDSWll?=
 =?utf-8?B?ankzdzBaMUhiOEsxS20zK1plcXJjV1lyZjBPanplN043MEUybytadnpwSGNG?=
 =?utf-8?B?YjBLMWxkNlhrSEdHTE45R1FBa29zRitBQzd4Z3N0Y1NCcEdWckdrNnFmeDFm?=
 =?utf-8?B?R3d0cWNtMUVFWXpSVTkyRHpRQWwwYVhyQ3RKaTBtUzRndEYzcjRMNDZKSTRo?=
 =?utf-8?B?elNTSGd0RXc4cEJiT1I1WFA2V0JXTHNFOUNPQVRQWHZWakVmdU51cHI3eVpP?=
 =?utf-8?B?WW1zMTMvQTE0TEc4eGtFaGwyZXNGN3QzMzBqOWFqTTdURTg1VU9sVU9ybTNX?=
 =?utf-8?B?dCtlQk56ZFNxUll1S1c4dE9JZk5YT0RMcktqZ0tyRThJUngwNysyOXJra2dO?=
 =?utf-8?B?dlB6c1dndjBsN1pKN3YwRGEwMEU3VGZnVmZaa3QrMjhtYmdCeVJFS3Z3ZXN4?=
 =?utf-8?B?RXFrUGJTSENoWTlKYmYyWDBqdFdyMHNTb3RRY3dlQWE4SHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OXhyOVJYWmdOcDNRNHFycjA3cTkxUUE2Q1lXbUhib2s5REtRQTh5S0FhNEZs?=
 =?utf-8?B?eCtDY3NBTHJCSXMvcW5qMDhSNHFyQjR0UmtubDViTVNHOFBkNXhwZHM0NGUz?=
 =?utf-8?B?ekFVUERDNlFndUk5Zy95eE5ldEFqTXN1am5KVlovc3dBcG9DaTBEMlFUVU40?=
 =?utf-8?B?ZzVjOE1oellGYzJsZHJIVi92TnR0a2luRysyZ3NNdThoaC9EYkZwTVBOeUtm?=
 =?utf-8?B?TjVHWlNqODIxTXBSY3JGUjd5Um9qaGNGc2oyM2w2WHFqU0NTalZHSDhBQWlK?=
 =?utf-8?B?enlNcVJVakR4RnlCY1JTQThJRlNwQ0xhdkloTmhZYWhZbHkzODBEWFFWVnBa?=
 =?utf-8?B?S1llRjFDVWplT0NPRVZxR0lkeFlGQXVVNHJ1ZGdkWE5uL1hBVTNYZ3ZmbnRT?=
 =?utf-8?B?cENzS1UyVVIxMjNXaE8zeVI2Wk9WTUZkbzJ0SmxiOHhrRklGVEp1dVJYdTNN?=
 =?utf-8?B?dXpEQjNtdUptSE10REVCSXZJNnNsc3p6UE5qNDI4MTFFazVpRG9Kdzg3UmVT?=
 =?utf-8?B?dGp5UzlvZzZWejV4M3d0dU5GSVpZNGVhNjhPcGxsQ0pPbmpyNWNGM2ZmUGxq?=
 =?utf-8?B?NjZUV0NCekhyVlNkUmlpcWxMQkN1YTV3S0MwSGpDNmJmb2RvZkExczZDQkpT?=
 =?utf-8?B?Nk9ZbXhsM3UwRHNONlhkYWpUbGJaeWFhNUFUV2xIaCtvU000VEVObWNTdldK?=
 =?utf-8?B?Y0JXZmdtRENXc3FXYjhETWsxT0d6Qi9qQ21PMlBZT3k2RWJpWnJ3L012cCtT?=
 =?utf-8?B?aFBQOGo2ZHowRGlCVllPTzhPU0FQYzJmeHZpVHNiSHVOWnhacm11VUsyQnhp?=
 =?utf-8?B?TUJ0YmhZdUdaTk1sYnpHaTFiQ2dXOWd6N1drMXJYYktNUDY2WmxVdW5DRXdZ?=
 =?utf-8?B?bG45cjgxMWZuZDg4YVZ0OU1jK3dBN09mMWI5STZST3JzUnJaZXREMlVLS3dS?=
 =?utf-8?B?YUtGbFdZTXBVdUQ1cVd5cGkwTEdpWVNsbjlUOFl0TG83WHpzWlBPODNpYis4?=
 =?utf-8?B?eXZqV2FIK2crUitlQ2dkRWE2WkZsVE9veHZSenRNdm9DT0x0dGhYTmlvTzFp?=
 =?utf-8?B?dTMrUzd0NTNnTkl3a3pMWDQ4d0FuL1FZTjFsbFVzSFV4WEE1S1E0cWVVYU92?=
 =?utf-8?B?aXVkYWIzTFErdTBNT0ZFREV3UU5jVUVnZ1F1SnFzNXNHd0hNZExSYUZZeWxn?=
 =?utf-8?B?MXpWUTRIWjJEaEtoTzZKandkZmNZNlBFdy9tOWF6TEF4TXllSm41WEpYc2FU?=
 =?utf-8?B?Z0NrdjN2dktxNUUrdkdSL2oreUJ3OFVCUW9waU9OZmZXUXlEQ25jUEdkL3R6?=
 =?utf-8?B?YTlaWlpvOHFuVEt3cGNia0wvSzNYcWJzcStRek56S1ZNU2ptRm9yMHRiQjdK?=
 =?utf-8?B?MFJ4VzhNNmFVcDQzVTRkZHlGVzRmRllxRytBWE5qQi9GOTlRYllJUXZBaDli?=
 =?utf-8?B?WEpHZVpLTmJzSXZNU3NXTzZmb1FxWDBCeUVZSWUvd3BSbVBkTXBHUm4xUzRG?=
 =?utf-8?B?KzFLV1gxVSt5dk5tTThtOUFDQ1k2SytMaFkwNTZtS0JTZ21LV0dzRytSU2N0?=
 =?utf-8?B?K2JxbXZocHdpWisybkl6bnRnR2JFdUc1QWZZZyswNnJuUk1tQUsySzdmT2Zq?=
 =?utf-8?B?RGc5cmtUOXI4TXR0MExkNHFpcEk5WktRa0NlNG51RmVhWVlLOUdvODA4Z0Zv?=
 =?utf-8?B?VTgwTjNQWVRnSXdqU1FhNTFNK0NwKzJQS0F4NUhWaTdmeFUydE9NV1J1eHpB?=
 =?utf-8?B?aVg3UTgyeVkxV0pEcjNmTDZkV0IrOUZIZEowZmVQc3JuSVE3YnBSNTdpcE9U?=
 =?utf-8?B?QXpvQnBpaWR3Y216bEg4MFNmc0hXSkZlQXZaU01DeFBZVW1HeWFub3BtSE40?=
 =?utf-8?B?V0k4TjlnVzZTbXRmbkxPSUxnWFRxYVJJWndQbG8zaG9NcHc1Tm5MV1pwMExW?=
 =?utf-8?B?d3dmTisxQk8vYnpyU2JRSDVTdTN0UVRuMzRRaU93UzhWZFJqbVBNRTgwTGha?=
 =?utf-8?B?QjJEU29Vc0hkcWhGTFdRTTNKV0dVV0tWdlpjWGQ4c3hjMDJEdnJRb1BLQXNS?=
 =?utf-8?B?cXJjQjU4ZGpCb015VFpVa0I1dm9MZ2F0SVZxLzlmVG5GdDNNWXdkVlhhVlVh?=
 =?utf-8?B?ejNPdWFLY3A0R2x0bVFRRG5lTUZHSjRQRVhLcGNOYnVQS2VkQ3dKSFVLbzdz?=
 =?utf-8?Q?9I9mBbW70cSDwI8dr3DMJ8s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88ABB729E3FE8E49AB5ED41513694E6A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	js7Joybac/r51yJqQPyjCbpNrB6kClD+PTaGhW4HdyQ2gbG8AEgVIhCFsZ4nTBGvYcv+SvZK3OQWJNXYbwPy358NNTa8LmjkBxUixQ9E+sed7wpxAWhU/rsJe9h+W5H+/EXR3MxFvI0t1cbVQehw5Kqi1VvuNMwqjHHlJUNUozrmMt2F74HC2Pt1EwkcUTC8HqEGfiDlKBOd595hW617/akW8aQaB5sUJLrrCsFteMo8rRYKV0vWAVKhW1MhqsWYet1kmZtE+2GIFFU9huA11sJijaPnxD+O+hegkP1awJ37b8bpGj6wuL9eLAQ7MzKgF/DsA7sqN8wMGQAG2fuHXpctoDnq2S7DmTd0hDfyffmog0phesYuHtUUbmVdb+ghUPuFbDXQQ81pKi0N6JWrz8ivHA4HFWQ77T/Dzw5jMLwCD7ZGSm6H7687GRX5F4cKiOSs2hHH4DO7g/9BUTukl9DMrIcFRq9FIY6ygSY+rtA9lA4nfo9zQfgvdCsW+mx0mzU9sTyy+FEODCD8MRzmrlK+atVQaZhsoo2bnAD4324VazbukwOmZNp6CDk2p4cfx6M4Y0A7TOoVelE3i9mzEFJzwJYFKBN/G4vQPB9FoL5RVCClXl/7fgmKXw02Nivs
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91bfb04-7e6a-4142-7f95-08dd1b47c9be
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 07:28:49.7187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZdyZ6F4R0Bw7ZavJSSGineCe/Ps+LlF609rpW2l+Vs7VMpGo+K/5xERvjHVEY8LSH22UW/lIwzvq8sEZctbUTbfXqeirXaj3dSG5h2dKYuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6546

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=

