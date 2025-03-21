Return-Path: <linux-btrfs+bounces-12478-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D887FA6B829
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 10:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77FF3B9A66
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 09:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFD01F130A;
	Fri, 21 Mar 2025 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GYUyGFP8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UcGRSJB9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FF01F30B3
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Mar 2025 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550854; cv=fail; b=TRJWNsRkpJ3V7Ne2AX4WnPZo51G9FQtREGub//mPtC593uOcN2aheR3IJEfLjncdkV2mN5NDdJLVXJw9CGrgPxq7mAu9m6wZpqKxOGl8nOcX21/5aZh5RujHlMSSWX8tS937yjwPej1Oi5va6ZrXebUmlZjOKBd10a80+F7t9rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550854; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gCAn9tP+zDOQ5MqNsuGb6hKgt6+te89PfvHAlais88zB5A4npsFcCzLdVJSly6w3MW3PVw6/fRzVRYUcdLhu4uyxyyPp8sDQPLEO8NhZKGGH80jYspndHgSOA8h/fu+ouW1l7a7wf7TbrUhC7EMpjbFFvmQ14NHyV+rD33zzxbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GYUyGFP8; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=UcGRSJB9; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742550852; x=1774086852;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=GYUyGFP8kR90Hmr4O7Np/VWgcg2lkfJhOH2EeA+qzFHCrcYd+FBdA0aa
   /YZ/+athyXb+Gaiw7rvAv/2nV2jdIbaIZ2acGBz7/EeCUDO7FrqeHNVF4
   1G6QY4yvH9u0i9Qz7vV5ZpWdbJVNY7fUBXIbldVHb3XRU+IPUgU+3w95e
   64RxqS4S//r5R2rRNNKhlrV8nAXJLb6AsqHgP9n2Exp2BXejwZ5hyolQ0
   hF5NS6TzBja4ExviA8xPOriU5mbXw9+829EWlmDd/NXILMvjqDpFugEHn
   zd5komyq5b7NlctUqb+hHsH+PmuVmYCAImoJCiTDUiJHc8pLotWR/v4Ub
   w==;
X-CSE-ConnectionGUID: eOjO52xqSb+H0ZxzKTe78w==
X-CSE-MsgGUID: +akkKo3nTtWYL09YIOBARA==
X-IronPort-AV: E=Sophos;i="6.14,264,1736784000"; 
   d="scan'208";a="55934469"
Received: from mail-mw2nam10lp2041.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.41])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2025 17:54:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNa4t/4dG3hnJXcfB9V06FKv8w2JkDvzBKSSamVqh/BW99E8fCtkMK1BmBCxkm0Dc3lFZ7oC/UlwZ1vw/98tcUSTRslPtwtQfIMhQ38IIGUnFNjHq2B5J43FQxXrRzDgH+Je9qb0YEj9ZL5hMolJCbIrFfgPoJYy9v5VGzaVKsVMMBxl0i8byaKmB3Plfx24F1K73qNICMZzugYUY9h93JPbMgT37sD2PNoZZO0o2JlntX505/tR+ZjDWmb15g1e1gCk21o3rSvm4T+DUiwJBux0qy/2ytawytKg/jA3np3FTkwZOQZ1l4udS8/Nyfino3zz49KPBBwDWRhIOMb0sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=XhqraklEmQb/4XmNCl51zYHavj4JF4Z734rPRyHzEZnnjPFcnxqKI/P/MRzCXMnXfwlWGhN1udsTel3XobtruUu7vFQKZCS0IOPRFCw9z3G45iVGb/Im2zuyQUZM8PCCfDG8e+ctbawZAIQz3uOr5Gs6ZVBIKI4z/58t2bMNek84xzGbRLyuLbSb9+cpeIQ/RJ+CoFxZHNqPIUvOejg8KMsmlPmvmqTwu+Rs2PPNWSmfuE1rNAm0h+KaDqKUAWjeG24e9AeA8ulTjoanDdx/GZqe3Ll/DvGl3Yz7fXQ98RocID+MTG1Z4dah9FSACUHz5hxafaMIYYePA3ddwAMERA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=UcGRSJB9N5jlo3D/NlmC6zJsrfV3hWGsFVFI+b5cFj+41UdqJRHvrm+OFwSUyrqgnPfykE9mnp6YEi3PxuJzshsA4iO6b78HvMPz6HSGPDtf0/XYU8aPSjo2b/SMrcYBGhIXoSki5aldUP0IgpGTqvyJULaxlAhvlTbXsKI6SFA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB8070.namprd04.prod.outlook.com (2603:10b6:5:317::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 09:54:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 09:54:09 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/4] btrfs: extract the main loop of
 btrfs_buffered_write() into a helper
Thread-Topic: [PATCH 4/4] btrfs: extract the main loop of
 btrfs_buffered_write() into a helper
Thread-Index: AQHbmVnfBlGsjsjs/Uum/k6XMUkQYLN9W6wA
Date: Fri, 21 Mar 2025 09:54:09 +0000
Message-ID: <49cec07e-82c1-4a08-8c5a-2bee6f1dc702@wdc.com>
References: <cover.1742443383.git.wqu@suse.com>
 <4710798bb9d917697384db6abbae75ac8a5ab6cf.1742443383.git.wqu@suse.com>
In-Reply-To:
 <4710798bb9d917697384db6abbae75ac8a5ab6cf.1742443383.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB8070:EE_
x-ms-office365-filtering-correlation-id: 32a4eb99-b5f0-42e0-7f3a-08dd685e5374
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?REFvY1FYcGp3Y0o0NzcrVUh3NWxndmRlb00wdmRPMW9WYUU0UzdScjI2YVkw?=
 =?utf-8?B?UXVieUJGMWtrc3FxTWJscERETmhpRVUyTVJnTG0wSUJkZU5oTWtPcmtWLzRo?=
 =?utf-8?B?Z0ZoRTQ2N0ZlUHpXV3hXR2x1R3luVS9VQk5xN0tIZkx2cDYyYWF2SE1Pcm1o?=
 =?utf-8?B?UXl1a0FiSHgwWnFWV1ZpU2JKb0FZbW1UUFBodEhFTlR5bEpWUDd1Ui9ISkdw?=
 =?utf-8?B?ZnhhTk1QU1NadjJ5cnFnVXh1V3JFUzk4bUt0KzlzZ1lrL1g5UFZmZjczS1hI?=
 =?utf-8?B?dlZ1cktIeG1qSnRaTlNXQjh2T0xiZ3hXNW5yRjBhZDhuMUFJTENOQnNnU0Qz?=
 =?utf-8?B?Zk9Qa0tnUjVQSW1IaHhEMUgzSlB4WGc3OVlGNXEyTFYyZUJ0ZzJ4ZWx2Y1pZ?=
 =?utf-8?B?S25URWJGNFJIS3NFb09MV0FaWU4rdGhDcFVEMGtQbk9hWnRIUytmeENtVk9u?=
 =?utf-8?B?NXkwYlhqKzhoVVZiZmdTV2ZnQ3BNdkgyVEpEa2ZYeHI1QmpsSmxsdHN0VDQ2?=
 =?utf-8?B?WU1FeVpWdXF3aXByRG5kdzBDaWtMT0dKZUlOcVoyU3lyNEhSaG5iNXJZcUlm?=
 =?utf-8?B?TW0vMGZHekZEcnpFMCswWG9oNnl0S1d6VjI0a1lPSDJPeFFZa3NGQ2ZxZ1FE?=
 =?utf-8?B?ck1BZWx2OXlYTy90UkJybUJzaFM5ZmlQV3BOdHJrOXltaC96ZDA5UDAzMzdC?=
 =?utf-8?B?aHVaZkZmL05nVjJrb3V3eWRwc1hob3RIY2xRYmFXRm4yL2FpRmhlUWZDYnpD?=
 =?utf-8?B?R1g1WkNFSDgxMmNWMldtWUNvLzNpTW9peVp1bmF3dkRqQVNsczZVMVdEdU9I?=
 =?utf-8?B?Vng2RDBtVGdUS1kxMmtJNEtyMHJMSWhrWERGZm9sL3RqMFlKZ05oUC9Denk3?=
 =?utf-8?B?Y0Y2Y1g5Zm8xVjhVc0Z0MDZpWWZxNFhkS0F5c1FCUWpmMnZCRXBhUzZPVERN?=
 =?utf-8?B?cUNHaFByVncvZHp5cnVuellhWFZNbnJRM0RGdy9XZUwwcUFSSXpWaDVJQTZ2?=
 =?utf-8?B?RHhzRkU2MHBQT1NCWHgrQzZKZGxsMFM5ZHpMVGt1SWJXT096dGtoY2RTdlFl?=
 =?utf-8?B?QVgxTmp6d1UrRG55OUVYczdsTkQ4eThVNGFJK3hqcjA4Tlg3ZkNHOUhFS3ZX?=
 =?utf-8?B?NXJINE0yWjVkNDd2NzNiSWtwZGQ4bVhqM1FGRVJQaitxT0hveUpmR1NaWEo3?=
 =?utf-8?B?V2tlTFpzcXJRNHVrc2hrWUN6VHFFcnNiYnh2M1FBWXo2UTB0dHNRRW9hOXJy?=
 =?utf-8?B?MVRiNzBIMnlNN2EvZWpkbkk1eExPME1Oc2ZTZDBWWmZ6cXJYOFAwMnNUb2NM?=
 =?utf-8?B?OS9pb1RsUVp5dnQ2T3RFL3A2ZkdGU0lkUWVJWWwvOGdvN0Z0L2xiWVBFb2Yw?=
 =?utf-8?B?MXp2ZXpFdTlrNFVCM0dkeWZ3L25XMC83RUQ4d2NldFlvT2IrbHByTVIwSmdh?=
 =?utf-8?B?OXVqVGtoeTByb1RkMkdIeFQ1K09KYVM1NVV1azNBYTROVmpjMENUVUs5K2hQ?=
 =?utf-8?B?YUxRUXorbTdySjVmcU5YUVpsVmZxUXR6MVpBWGpKcktReW5kOElDUThZcU45?=
 =?utf-8?B?bHY3V3RoWlNidVR6cDArenVvYXZDZWplNUU1Z2huV0VwWTRabFhlTWZxNDJR?=
 =?utf-8?B?akVqaWVJY2h3THczT2tQTjArZHlqbGtwYUorT1hkTEU5dzlLd29ybW4zaFEw?=
 =?utf-8?B?Y2Q4ZVl6bVFyUWIyZWVqVlBsUUY1ZlNxcTgvYkZrc3lSbzhRb3ZpaHBvbFRL?=
 =?utf-8?B?bHdnNExCRSt2SzZBMUtyYldwZG9DdGFBVXMrc2NnN0hXeTNLcC9wQk9wRXdG?=
 =?utf-8?B?QUZMNVZibEhOdFE1dFhlZWZOUzJmdEVJcUxYM2ovUlJRWUhHVlRpYkdiMUY3?=
 =?utf-8?B?b2JTRjF1N1BHRDF6ZkZnQTI5NXZoQU4vYjhmT1Q2U1VzelpkbStpdzZLbUUz?=
 =?utf-8?Q?KR3iO5AasTZJh20eM8qNZL0jFpcn2dOh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHhLTVhSenNCR081RHZsdFZla2JUeDZ2Nmh6OW1ucU1XejV4Z2M5R0JqNUdN?=
 =?utf-8?B?bS9YMU9QSVlBMzQ3ajQ4VGk0b0E1TnIydlRTalFRbEJxQXRCVE9jN0xOQUti?=
 =?utf-8?B?NlIxT3ZsNS96czdsbGdMSVljbERrZHRKZHhlWXVuUGZULzR4WTVuV0gwUTJL?=
 =?utf-8?B?MG91cm5SejZCMWJyVC9SS2p0K2Z4R2pTaGl1UUVVT09VUkJoeDcrZ3hKaW1H?=
 =?utf-8?B?ako5a3ZWRUcyMlJYRG0ydVN5R01rb0VuNCtNdWk0Z0F2Vkd6aE5rZjRDOTVn?=
 =?utf-8?B?RnNxRmx4dGdSUkFGMWNaQzNkM29WaFlNT0tRa1hiZDN0VWdUbXhCMjFFbGRW?=
 =?utf-8?B?eU9FZFBYenRzdi8zT1hCQWhlOEF1L1UwV3l1RU9HcTlTNW9XL1ZXN2M2N2p4?=
 =?utf-8?B?VEl3amN3WXBGb0x3amFLRlhHbzhwTzMxMU0zcUNhdFBZRVFwTWlKdFA4QWNF?=
 =?utf-8?B?REJZSXRCckc2eUEwRkJNNEJUdXBXOEZYeXBvSzRJNmdYbXE2eXdoQTlpWDhE?=
 =?utf-8?B?a0dMVlpabSsxYTk0YkZEaHhVQmJOSkNaNHF1aVhqRlJqTkgveHNYczEzczBh?=
 =?utf-8?B?cWlhVGNSUGkzL2llUUE1Q1VkK0tUSkVWY2JXTWtXWkJ0T2dJK2QrVitKSFh2?=
 =?utf-8?B?eERFZEVZaURCS2l3TXNsVWswcHJ2bkxabVIwTFFIUGF4QVFSdHBCSGZJUVZR?=
 =?utf-8?B?aGMvOXU1aitiN1M5SERqUmViUUNGczJ5QldRVFpMVHBwdlFIdkV1aVhEVzdH?=
 =?utf-8?B?MXpvNGEzRWpodmphWDloME8yM21oamttZUFnN0hoeTROL0JFY2JlSGhYTmgr?=
 =?utf-8?B?cWNmV1ZlRm1YOGxmcHZ3OG5Ib3lUMmpQS2xtK3dxVUFqN1FtYW8ycm1uZ1B1?=
 =?utf-8?B?ZG5mbFE3UzJQK2FrQlF1bis5aTArbmlsaTQxbDhYSkRDdXlPQ2FPUFR4S2Ey?=
 =?utf-8?B?UEJuZnA4cFF1WVBNNjltcGNwRTZYMkttYWpmWXNVaHRSQ0MwV2t4dU42UTJm?=
 =?utf-8?B?RTZDcHFvWmxHbW0wSEpIdmk0eHZlK1JhdERJN3VBd1YwR2Y3ZUZzNWdwb1Vw?=
 =?utf-8?B?bG0rRms4NDMyZzk2cWdteXRBek4rdDE2Z0VsWkUraXlpMURrSlR2cjEyWXNS?=
 =?utf-8?B?WGVlMU95QmZzYnVVMjJHN1BzUnZCUFR5cTloTGZvWjQza2VBVEVIZGN2RFpY?=
 =?utf-8?B?TGh2S1Q5VDBvYXlva2EvQURzRGVIN2tFKzhDVnVvUnJBaWFZV0l6YzJRNWMv?=
 =?utf-8?B?ekpreDgzbk91TGFiemtNbEI3SUZyNUc1WmJPd3J0RXN5K1VsY2paUFVHOVQy?=
 =?utf-8?B?cVoxSGlMV2ZwbWRqUjE3UHdJWWxCUnY1dEo0UkxIdDZ1enAwNlNqU2lIbFY5?=
 =?utf-8?B?ei9BSkJIQkF0TXVDK1B6aGEwWThidUZvWkRZN1g1b1BmYkoxRmpYZlBkTHVJ?=
 =?utf-8?B?MXRNMVVsZlMzREdVSElKek13c2Q4ZCtUR1dxTHhwMXRzbStkN1pxVWRDQTV6?=
 =?utf-8?B?Q1h1M0hNdzVtS1Zra0RYb2ljQjI0Q1g0R0VOOG4ybXhaRHNEMjdNYXlSNnZw?=
 =?utf-8?B?NjQ0OFg5VVloZDlaa2kvT3VwU0dwYW5lUU5FalkxZ1V3amt0MENqWG16MDUw?=
 =?utf-8?B?cTNvbmttclpuTnBlQVJsWXpaTEF5TUdxRkdTY0FYbzdmUjdNZTdjMnNDeTVE?=
 =?utf-8?B?UXRSNzFOa1ZoRlBlQk5EaEtRdXFDOEJURmtnUThENnFZR1RrTUZIMnlaa0NM?=
 =?utf-8?B?YVpzWUFGeVk3eUsxSDk0Vks3UHk4eWRPMFEvZXNtM3h5dEdURkRydGZBYXFM?=
 =?utf-8?B?Ni94T3REcjFEVERUOE5nM2NhaFM2a3EwK2RwekpWZVdYMWswOFdZQnNhUXV1?=
 =?utf-8?B?T0tCMUd6WXFVckgzNjM2d1lkT0l3YVBMeUZ5a0lKZnV0STVYZVNNaFNuRkwy?=
 =?utf-8?B?UC9jc3BHb3h1UEkyRm1sWDcvMUQ5dVV3ZnJHUnpTNEhrbFFJRWFJdSsrTTBy?=
 =?utf-8?B?blkxcVFsY3lDSS9CL3lhSUlwRFkybVU3WkEzdS9nREl0Mit2M3NkWDBvYnJH?=
 =?utf-8?B?OHBxSFc3dExZWVU5bkVGMVVEWUwrQWFNbnFPN3dGSjZiQ1Zsa1d6SEpvaHA5?=
 =?utf-8?B?N0gvb1dMcE8xeVRrcmFveDVZWmVya3QrMHk3QjVDcVp6NTJPK2UyQ09TdWpZ?=
 =?utf-8?Q?jDkgABUVwhZi4YW4yALzziM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6228163922455A4F8FCD1B5E36D38E21@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AzKKV6DpgDspGhQQsg0iBtX2nAC/YOgfV8o2LzAwGgZ9IJayBB7vUZQ7+64r2hT9qqZu/tf/BAzkUP6QQwq8EjgxeqXwA9IR1k2O3jtWsnjpPuTk9jlA9KXB2dytkPR3SAmMvo0z+xPPG0EmcfdyKvgM3h/fLuYQiJ2jZOYzWVgAhK2at0eE/MZPdR8mbkvpa64fegg+nr/gv3i/+UgF54tn0LXA0fww02RRHaGVr93q6XXcZArjJUwAIRY0kFHbQ+3QZdn09npp5VLpk52P1O1UAe/LXlv6ykcU7/fvunvN4LqW8EDZxfCjw2LQwJa5TpKrizz2Cc1s/i5ckV5XF2WKvM6juQ4MJZu8NMFduhbwGJSZGT1LfMPEuW0+Z7uVd75Biw/trKU9GlNp52m4pBxWaj6ZLdSSaN9g2MzCs6lvY1LpUO8vAUs3WSlV/IbqqXyeHnH6JLwpnZBF8KdcAgw8+gMJRkLUr9HStYh5yRE0RTg/p28qezstZy9XH9DfD3jrVy4BCQx2O2ovncVlL9TZ3U+F93DOYazQ+GdUUVpXN5AFm8lftcURSFyqGjwAJdi2hQ9a1q4QziTmER0GWgiqdS5j1KZYhdRFmFtOJavXBx4oeVnSfmKGn6gElM07
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a4eb99-b5f0-42e0-7f3a-08dd685e5374
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 09:54:09.2518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gWZVs1IXNkkjeYvj0P0nLACuYqPo/DzX/vlEh3IDCuTJGZliv53WOagZjgMOo3AYUNiJwMslDlQiNBFdjU6WVBhzZQ8nQhpsIbsKfKasxZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8070

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

