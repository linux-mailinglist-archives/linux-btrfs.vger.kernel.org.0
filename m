Return-Path: <linux-btrfs+bounces-10872-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6697A07CB8
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 17:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3356B166EBD
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0403F2206B6;
	Thu,  9 Jan 2025 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DTZUhu0X";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RqQEA62L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3FE221D82;
	Thu,  9 Jan 2025 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438418; cv=fail; b=LEp+KYO5UaDXwsM3auIcMWi6arzucTpEf2k1kzJnb6ysf0ZuAYoUVoBa0de8ZGzgkTkk/EX1u/TT0jetmJA6QbKN1BE173gGMU4110MA29sfZYGeHKSZRLT0dJ0gR0JRVAC6Do9otLuT8fWsDfyzkssDb53DBvgL1JMhQ2EM0lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438418; c=relaxed/simple;
	bh=lXRKhf/Z4SUufw5fCGpzoDdw/g/pjJbAsEr50v9YGZo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UHhGb4iT3x+ZiAaRWXdGpSEWMApeZdmcQ/YGtIOwS0T7mrn3xKN7NbjEzJkqQYLh36G1id1kJ532MKz0G0Eaa+uKb/tftEoMQhwom9vTvjn4z911F4gt/8TiGwUXf4ZcACrYBTwKWpy7KZv6SEaNkCBC3YkG5C/79RT98xg4EA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DTZUhu0X; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RqQEA62L; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736438415; x=1767974415;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lXRKhf/Z4SUufw5fCGpzoDdw/g/pjJbAsEr50v9YGZo=;
  b=DTZUhu0X78ECNb8omtithAg+Mf//tdXg8oLTSPJx/kwILwy0qfxTT3P0
   KFBxQJuqvlJ3/Oc+xIGmxMC8VOYApgVtQRw9dzEzxJDHsPHgAgjIBv/Ue
   /tgZe0cNeNknwyHYb5g2bA4MIBkj/N6gMHWuGfz5MbIAYU2JZPc4q/CDS
   YjluXYHpHMEBYH3NjWmkAWwcwE4+d+3AGN/sLdw0s3XtuNtiLHwFeaCnD
   aSj7I26YhB87MGpmRbehuV0lOZeriTK/FB36kAWpIcEGnv1zoaGgp5IdG
   39phu+cbQjBZ6B43AUDNHpkSmiHl1ZwDSebhXuFtXlpVshD8y1ZsAV+AP
   g==;
X-CSE-ConnectionGUID: sh3L4L/sQVGzIk5JD0X/gA==
X-CSE-MsgGUID: 8sBqZqOoR121ovti5Rmt9A==
X-IronPort-AV: E=Sophos;i="6.12,301,1728921600"; 
   d="scan'208";a="36086575"
Received: from mail-centralusazlp17010000.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.0])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2025 00:00:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fv4LHo/dlzXKfgBl4ZGVo/sqkJp1BTZI0MYlnkOfae8+tGFd7i1/YhLW2joUnXmJu5H0/gyR+f6tAzQzrBrAhUd80Of88rxPzo0m8TP7HVYOEgjgJrblmhXGNUc9PzO/X3omDm1tBjF3onvdhbHlADds9b/NQdjuIWMBoAALXvebk/rlAEkBUA053mJYJTb4z9JXPR3xCpfElXJIXtEVTPAjyolJwjVsF/eq2u+pGqRe5QFpAP8gfNZI71+53mlm4rs+ANl6tV5TG9G+t7jx8sE5GGDwQg3c0NSEAIN8v2eIwjcOC6+gJQR2xxcP7bZT3xm52KGpmydPWzLVgeRNMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXRKhf/Z4SUufw5fCGpzoDdw/g/pjJbAsEr50v9YGZo=;
 b=RWB1nThts5ow4rNNx0g6Js1f0s2qquJjMn/pF5fr0Xlvr9EYRC1bCmmTM3wJofdITY4C3bOKqWtS+213livVnZ8NyijxjGZaE5/qGXUlECV8/DzI2BSzmCEhzjXF34QJVPprkg79X0+BQV612E3nN7FLyKrcO1HHjCd3JdD59TlOUjnUueru9X0xR5OdMIAThgCzLW3DdrurBjYCBS7pYXHrIZRrqPQ0hhJ9Y0h+n10RKriqwHEghVuDW0V+NHcTGTEAxwBhrZ/4NQOB3zx/oiIvLB9nBdsnU5P2p++mj94T6qOHLayddgcCBqi0MKrtYw2Dd0Imrn76RRqqIAvqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXRKhf/Z4SUufw5fCGpzoDdw/g/pjJbAsEr50v9YGZo=;
 b=RqQEA62LeElNbwZTBnJc4BlbRIWX3Uw7hL6lN9SXGddt2RRPHnqrZote7irefk6ZIRPnBdBepMrjovyqoU5ne9MZmnZ5eLJJs3Ip441e4DH0YBbNM6msHerpTpPdD0DDtZ8CxZgfinoimOZtuVSUCwSBPDw+JcfBRTCJVidcs+M=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6846.namprd04.prod.outlook.com (2603:10b6:208:1e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 16:00:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8293.020; Thu, 9 Jan 2025
 16:00:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 08/14] btrfs: don't use btrfs_set_item_key_safe on RAID
 stripe-extents
Thread-Topic: [PATCH v2 08/14] btrfs: don't use btrfs_set_item_key_safe on
 RAID stripe-extents
Thread-Index: AQHbYQJkDJ63gMcsDE2Aj0HZ4IUtgrMOmNEAgAAEQoA=
Date: Thu, 9 Jan 2025 16:00:05 +0000
Message-ID: <09100ebd-4bc3-4084-8ecf-ce8a61455180@wdc.com>
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
 <20250107-rst-delete-fixes-v2-8-0c7b14c0aac2@kernel.org>
 <CAL3q7H5eRPN1GTOHdTwjgFuy-DWQtvju=qffGCVY_oi_KrDP7A@mail.gmail.com>
In-Reply-To:
 <CAL3q7H5eRPN1GTOHdTwjgFuy-DWQtvju=qffGCVY_oi_KrDP7A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6846:EE_
x-ms-office365-filtering-correlation-id: 6a268a41-b453-41d2-c348-08dd30c6af0f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UWN3NFFBMzB6RVZ2NjBNa1czQjFLQWhHSkNQd1FSMXZmTCtJZDdZQkRqRExa?=
 =?utf-8?B?bldHeU8vR2dlaWdQeHVvQ1laazBoYU1jeVU5YTcyUmhEQkUxMnA5MFcwRkNw?=
 =?utf-8?B?OFhQeFBLdHFqcC9VbU5JaUlTM2pIWFJlWXB6N2dLd0dLeW1CRWNBQzY2Y0Rz?=
 =?utf-8?B?VDNMTzF1ZkhZMC91TzFsZmxzU0FsRVVlc1JjbzFwRDE5RS96MG43UW83Y2R0?=
 =?utf-8?B?TUIrWUZDejZMWm10UVNHNU5jalgrTDZnYllBbmdETnVvcVcxcUFDMDRqOGgy?=
 =?utf-8?B?bEsrbWQvc1dHdWV4dUVKSXEzaWhHVXlFVXV6OVJhZHRRTW4rM0Q5VFZ4VmRh?=
 =?utf-8?B?SDR2c2RGUUZqWHU2RkQwT0RZcit0S1ExNjZZc0ZTMEpIa2tNdTBSbXErRmpH?=
 =?utf-8?B?Q1dFajhnZyt4dW1JQVJsVkZhWHJxMGFta3BOVzJKMmVnQjdZRHlGSnJnRVpr?=
 =?utf-8?B?TzEycjA0QkRLNG1KRWpxUmt5UCsxWmlIMnNwRTU1NGNjS3BxN1ZyTVZjKzBw?=
 =?utf-8?B?R1dqQm5RRVJsZUY2M1hyVndtdkxjQ09jNjV4MkJzMWRsS1Urc3FtcXA1UVdN?=
 =?utf-8?B?ZkZ2bmJEbFRIUVZuczJpRHpzei9scU9RaXdMalRVdnY4dTM5eEI3ajlMYVdJ?=
 =?utf-8?B?WkMxVFA2dGpsVWR0S1BsSnZsWnlDZ2hMZW1CN2NQWFRQZ3pPSHlSbG5xR0RI?=
 =?utf-8?B?WTRrL25uTzRqY04vY05FamtrOTcxS25yaGlIYnpieER2OGd0WUVqN1lNN2lH?=
 =?utf-8?B?aUx6NWdLTDZiMTI3YUpMc0hzME9uMUovUHhGbXdENHlaWDZnZ2sxUGRUOWVN?=
 =?utf-8?B?endZRkFWeXhpa1hodlQ2TDhGcGt2Y0Z1alpPZGhIU2VVYk9jVXBXZHR0UFlY?=
 =?utf-8?B?dWlQODQxb0twN2V0UFkvc3N5cXdMc0pCU3RmZWtvM2FxakJoaDEyWTQxa1c3?=
 =?utf-8?B?K1FkemtwRzhOdkpkMXN1WHBwMW5sNm9MNzNham1nUTFudld0dkRHZmdLaDgr?=
 =?utf-8?B?a3UwRVd3Y0EzRlNJUVpwYTlRakRmdnY5VXhPQjBHNmE3aC82RUMrWXBVanZk?=
 =?utf-8?B?QjVibmVjeXRtV3pwSGJiWVhVMjdWZWRFbUdFM3lyZ1pKaUVubFhOU2s2Tkxy?=
 =?utf-8?B?UWJlLzN3ZU9WOURad3JBQ1RKeHJTVi9OaCtYTTF3ekYyUE02U011d2dZcDEw?=
 =?utf-8?B?Wm5xbFhQNFZ4WlM2MzhkNndxL2VUbjBDV3ZDMyt0YlVWODZUOTBZbXFYU1JD?=
 =?utf-8?B?d2tsR2t4T202WHZGems1UnBRL2xKRkloYzIzV3NKU2V1NThOVG5sREJGcDVD?=
 =?utf-8?B?Z3I3V2pNSTFuWDlVaS9UVFpxOUU0UkZjaVk2Z0RUQzJvRnZQMEg2VVhMNTA1?=
 =?utf-8?B?cmZnMEZ5UWo0aGFPbHlvRDJReU11dm95UERIem5RK3UzR0hpNzdTNG02dkdw?=
 =?utf-8?B?VlIzREt5dUZ0dzRES21kaFBrMGVzcFlrdUxUVzlVM2d5STFFSU01SWNBaHR0?=
 =?utf-8?B?NGZpVG9NNXlIZ1VhMGViTFFPWnozUGRNYXdXZm0vdnR3c3Q0Z052NFNDcW15?=
 =?utf-8?B?TlpFblMyTEErSTJkREF4bVFaS2pGWFBNWk9DdUhxM0FvK0dIUnlvRnd3Wmsr?=
 =?utf-8?B?MmZ6RllYUURzeUx5T0VReGhzd3QyRHJYWnRmUk05Umx1SEJua0hsRm1EQTJU?=
 =?utf-8?B?WnlmM2V5NVFLbmlBd2hlQkN2S3VPOENOQXZuNklsMXN6YmNUM1E1TzJTZ1By?=
 =?utf-8?B?ajhNK1MvTlBNNDgyQmtMdDFSeFQyeFRxK0VaT0ZBVjlrTm5vQmpDV1YxcU8z?=
 =?utf-8?B?S3kveEFNMjJlVWV1Sks4OCtxcmlIZzkwaWoxVHo5UllRdXJJZk5NdXJIazBN?=
 =?utf-8?B?cGdDNHNSOFZvS3Ura09ibWw5eUdGb1JTNnNtZ2JGVm5jOEpQWUdHdzRHZk1y?=
 =?utf-8?Q?33L5tFduJfdAVWQQ/CVWUIDYE+N4b6Iu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3E5L0hWYU8xdm9KcGd2eDZLUnpZYXJVV3I1S01SMllCcnBwWG1ZemttWWJi?=
 =?utf-8?B?TEVZcENRYVBERWN5ZktNRmhjYVdOZGlpTGZSUlk5bXk3S09wMTN3TzYzV3FL?=
 =?utf-8?B?L3prTWtHdW5BWGFYRElpSk00MFVja3hhMXI5azlNZCtNRTIyY1ZrTkh1blZ4?=
 =?utf-8?B?Q1NqZDR5R21jQ3o1RzdZcVNwakxROWo2NlhFdjhSYm9wNmpTUzRFNm10Rkd0?=
 =?utf-8?B?R240Rmd3MEpKSjI1Yko0REZsVVJveTlYV1ZaOE5rNSttdmRJNlo4VWJzTXBR?=
 =?utf-8?B?VTN3RDRnbGJWZi8vaVVXZVFLYkVNUktlZWIzOEtxMldZaWxoSXpIZ2FFZlp2?=
 =?utf-8?B?UE5tUUZvTStTNmxxWEtnTm1UTXFzNGhCdE9tYzV4YXZYQ1Zzem02SlVUSDgw?=
 =?utf-8?B?WnBkMndlM3l2M3hlVDhoMldDUHdiRTdRajNJYkdNVWUxNnVEZk9LVGhUZEJL?=
 =?utf-8?B?VUlqYzN2MHYzVktJWk1FQ3FyOXpnRnViQkN5b1A4T2liNWliZ1ZvMjZwdXpE?=
 =?utf-8?B?T1NiM0xmTWYxaG5VS2J1dmVzNVhlaEFtYW9VWUovTkg4ZHErWXg2MHBBWTNx?=
 =?utf-8?B?VUFZbUZJcGk4SW5mV2o0TEovdmJDTFp0S0lvOTZNNkpFeGJ3TWQxR3NWUzJ2?=
 =?utf-8?B?UHpieDNxRE5WSzRzUHQ2VVU4M1VLdC9ZdmI5WmhpbkoxUUVrRWlZNHhMelNI?=
 =?utf-8?B?MFd1RHU5NmRUOEk4QmdEZzNmL00wam4vbXRVT0swcTRTbmk3LzRVUmMxME5u?=
 =?utf-8?B?Vy83R3IwT2kyMHpBRjZ0cFNtdWVsbkgxNTRkVWpkT0dieENrbEZDZExkWStp?=
 =?utf-8?B?SnhteFNnSEQrMDB2WG8xL011c2FCZFA1cEZiQ1JwRkhGT2NnVDBtUlBveDFI?=
 =?utf-8?B?TDdSd1dyUTNNQ2N3aC9uUmxGaVNNRDh6Z2xEK3BGMlRKYXYza2xSMHAyOUdv?=
 =?utf-8?B?cDJhUkFFVTY1L0NQdjVsWGRnaVFuazBzeHpYTmUyWlV2d21McCs4Z01USkh3?=
 =?utf-8?B?c0dqU1h3cHFjQkladVZmRHQwSTY0NXdJMWtmb2owQzIwbkhSSTVNOUQyK3Vx?=
 =?utf-8?B?RU1HOWNzRWFFd3IyYTI3WkhNZ2NxbUNOam5zQnNxUkN4UWJpZUluOHFJZjJI?=
 =?utf-8?B?Ujhid1kwVjRZSG10SURNNjQzZUhvOE1LZThTN3c1RlNPdlFSVm1rUzVyLzVQ?=
 =?utf-8?B?dE9ST2U0NFNhUElzUmsvbTAyWWswbnU0VzZXVWVQd01KNmdwSVFyQ0w4akhI?=
 =?utf-8?B?NmttU2tDR1I4TFdpNU9hUjIzb0JqUWFHL0pwZ1lXRTU3WWthZDAvSnVYVlVz?=
 =?utf-8?B?eVBGd0NKaUVqWkVlQUZkakx6MURST3lGWWk1c1lGWWlLbVA3RXdRdzFJTU5C?=
 =?utf-8?B?ZGNkWUNJRThoWUxoWWtqS1hWb3p6NGdqYzVZbWZkVmVSYmtoVjVEZ0lrNmFT?=
 =?utf-8?B?V2s1d3U4V3ltT3VPTFFNUlZ0RE1XVFIzU3RjVlJ2Uks1T3Btc1pkWVBBUkE0?=
 =?utf-8?B?c3k5REpkbnV5QlhVWC9HbE1WclB1bFB4VGVlOXNOcVlGZXFabzlvTCt4V29R?=
 =?utf-8?B?Z1c5cnNyUmFhclY3bE82Ky9tWjJGbFNuSllRSU9kL04wS1Y1MEdJM2NTMkU2?=
 =?utf-8?B?cVRsbmtqZ21Vd0oyVjJVdUNqVVZxUWk1YkxDS3h4TjZIeW1HcTNDeU03MEdC?=
 =?utf-8?B?YzJhVCtRcVFLZy92aFBKYUJ5TDVBWXlacXd3R1lkaTU2TTdCN1dlOU52REtn?=
 =?utf-8?B?cWZRVm40aVd4d2ZacW8zOUpuNlpzeFJwb2lEdStCS0o0TWt5aXgyc1JKOXJT?=
 =?utf-8?B?eWR2UzUza01NVlo4NGNOdUpPc2xBcDdVN1hEMHVudEdpUHA0WVdTOStNMWpO?=
 =?utf-8?B?QWV3eHRVMEc1eTY5VGttZE43ZVJRY0xWVTk4SkNsT1dSU3hFOGZGWEdLWUs2?=
 =?utf-8?B?VVg3eXdvK2RySy9nWGdsdm5QZmlGekdUYzkvb3JRa3BIMTF0OU9MQjFxNmlB?=
 =?utf-8?B?RTdEcjk2aXJnTjUrVFZhSnBPd056MjBkb2JOT0RCaFhxZVF0TDN6N2NjSnFV?=
 =?utf-8?B?L0ZhSWRROHZGYjJrL0dFY2dRcE82dy9ld2FGU1ZWNGJTVGUyam9ISkpJM3ZL?=
 =?utf-8?B?MEp3SG84aHVqUTIrdmcyRzNXeHc5UHRZandKQ2tEcmc3YWg5NzN1a2xQYit4?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36777D5A20711E4AA57D051BC1B234F9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ytCeC5hVVrGjbIP4bsdPhlwz5il+UN0Ru0c8VMXrQ+BGqGZ4a32443PkDD6SZrUJXD7OHH/O3np+v2Pd3WQUn649FZtxwUjzcFtEiNkW5TBSj9ND6TsOM2OK7WzYzDGO7A+/RSFXO3EB+8NbRUGNs5vHENhSzgGS9+Rnc+RCsYrrCCURUyC3rlxo7q8181LB3JG1MGlc/XWO+GH2al7xnvvlOTtGIowiU1zn4d3NLpo2XiEfcbCgllfl8XEUDxu/bBT8NvSsuoEFzutx+aq0n08sV9vCzSuLImjqhN+iLSzY2SUKGZ3cC3tyjbRT9BmF+ibBvfcW6z9FKj0G43p0plgFHymX12QJBm0cRhwEiKqfC7KlYWyKe/zgZ8KEt8KDGE81z+DMq8/rNopupY7p0baJ3g3MdgzE35BHN7EA+BPeG+g6wNWRvzg6kNL42Nn4FBySaGZidlAZPdBaZN9AakUI4Hhbbq10DEISbO+EqvqLv2EQy7sntjSE+ipN2b1jf8uoaNDdae2NVUUw7HggIw7Nszxo642hObEUyDtddhBEnapEV9eoF4KN+vpY111ZexTEa2M65ZYPILvzPKcC0op+vpkCi1fBOnz47F9j8KZ6bn4d2UmCn19QA5Cl0d6V
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a268a41-b453-41d2-c348-08dd30c6af0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 16:00:05.5013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JvQpB041PuOGbFiyfUBhWDE9mmhqfru9WskMge0MCD4REGqt7SS3gawALTR/ZVKbmWCWUJkv2BeQZzNPcXAHHVz7jWRC/xdxwtUNiTvcm1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6846

T24gMDkuMDEuMjUgMTY6NDUsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IE9uIFR1ZSwgSmFuIDcs
IDIwMjUgYXQgMTI6NTnigK9QTSBKb2hhbm5lcyBUaHVtc2hpcm4gPGp0aEBrZXJuZWwub3JnPiB3
cm90ZToNCj4+DQo+PiBGcm9tOiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGly
bkB3ZGMuY29tPg0KPj4NCj4+IERvbid0IHVzZSBidHJmc19zZXRfaXRlbV9rZXlfc2FmZSgpIHRv
IG1vZGlmeSB0aGUga2V5cyBpbiB0aGUgUkFJRA0KPj4gc3RyaXBlLXRyZWUgYXMgdGhpcyBjYW4g
bGVhZCB0byBjb3JydXB0aW9uIG9mIHRoZSB0cmVlLCB3aGljaCBpcyBjYXVnaHQgYnkNCj4+IHRo
ZSBjaGVja3MgaW4gYnRyZnNfc2V0X2l0ZW1fa2V5X3NhZmUoKToNCj4+DQo+PiAgIEJUUkZTIGlu
Zm8gKGRldmljZSBudm1lMW4xKTogbGVhZiA0OTE2ODM4NCBnZW4gMTUgdG90YWwgcHRycyAxOTQg
ZnJlZSBzcGFjZSA4MzI5IG93bmVyIDEyDQo+PiAgIEJUUkZTIGluZm8gKGRldmljZSBudm1lMW4x
KTogcmVmcyAyIGxvY2tfb3duZXIgMTAzMCBjdXJyZW50IDEwMzANCj4+ICAgIFsgc25pcCBdDQo+
PiAgICBpdGVtIDEwNSBrZXkgKDM1NDU0OTc2MCAyMzAgMjA0ODApIGl0ZW1vZmYgMTQ1ODcgaXRl
bXNpemUgMTYNCj4+ICAgICAgICAgICAgICAgICAgICBzdHJpZGUgMCBkZXZpZCA1IHBoeXNpY2Fs
IDY3NTAyMDgwDQo+PiAgICBpdGVtIDEwNiBrZXkgKDM1NDYzMTY4MCAyMzAgNDA5NikgaXRlbW9m
ZiAxNDU3MSBpdGVtc2l6ZSAxNg0KPj4gICAgICAgICAgICAgICAgICAgIHN0cmlkZSAwIGRldmlk
IDEgcGh5c2ljYWwgODg1NTk2MTYNCj4+ICAgIGl0ZW0gMTA3IGtleSAoMzU0NjMxNjgwIDIzMCAz
Mjc2OCkgaXRlbW9mZiAxNDU1NSBpdGVtc2l6ZSAxNg0KPj4gICAgICAgICAgICAgICAgICAgIHN0
cmlkZSAwIGRldmlkIDEgcGh5c2ljYWwgODg1NTU1MjANCj4+ICAgIGl0ZW0gMTA4IGtleSAoMzU0
NzE3Njk2IDIzMCAyODY3MikgaXRlbW9mZiAxNDUzOSBpdGVtc2l6ZSAxNg0KPj4gICAgICAgICAg
ICAgICAgICAgIHN0cmlkZSAwIGRldmlkIDIgcGh5c2ljYWwgNjc2MDQ0ODANCj4+ICAgIFsgc25p
cCBdDQo+PiAgIEJUUkZTIGNyaXRpY2FsIChkZXZpY2UgbnZtZTFuMSk6IHNsb3QgMTA2IGtleSAo
MzU0NjMxNjgwIDIzMCAzMjc2OCkgbmV3IGtleSAoMzU0NjM1Nzc2IDIzMCA0MDk2KQ0KPj4gICAt
LS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCj4+ICAga2VybmVsIEJVRyBhdCBm
cy9idHJmcy9jdHJlZS5jOjI2MDIhDQo+PiAgIE9vcHM6IGludmFsaWQgb3Bjb2RlOiAwMDAwIFsj
MV0gUFJFRU1QVCBTTVAgUFRJDQo+PiAgIENQVTogMSBVSUQ6IDAgUElEOiAxMDU1IENvbW06IGZz
c3RyZXNzIE5vdCB0YWludGVkIDYuMTMuMC1yYzErICMxNDY0DQo+PiAgIEhhcmR3YXJlIG5hbWU6
IFFFTVUgU3RhbmRhcmQgUEMgKGk0NDBGWCArIFBJSVgsIDE5OTYpLCBCSU9TIHJlbC0xLjE2LjIt
My1nZDQ3OGYzODAtcmVidWlsdC5vcGVuc3VzZS5vcmcgMDQvMDEvMjAxNA0KPj4gICBSSVA6IDAw
MTA6YnRyZnNfc2V0X2l0ZW1fa2V5X3NhZmUrMHhmNy8weDI3MA0KPj4gICBDb2RlOiA8c25pcD4N
Cj4+ICAgUlNQOiAwMDE4OmZmZmZjOTAwMDEzMzdhYjAgRUZMQUdTOiAwMDAxMDI4Nw0KPj4gICBS
QVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiBmZmZmODg4MTExNWZkMDAwIFJDWDogMDAwMDAwMDAw
MDAwMDAwMA0KPj4gICBSRFg6IDAwMDAwMDAwMDAwMDAwMDEgUlNJOiAwMDAwMDAwMDAwMDAwMDAx
IFJESTogMDAwMDAwMDBmZmZmZmZmZg0KPj4gICBSQlA6IGZmZmY4ODgxMTBlZDZmNTAgUjA4OiAw
MDAwMDAwMGZmZmZlZmZmIFIwOTogZmZmZmZmZmY4MjQ0YzUwMA0KPj4gICBSMTA6IDAwMDAwMDAw
ZmZmZmVmZmYgUjExOiAwMDAwMDAwMGZmZmZmZmZmIFIxMjogZmZmZjg4ODEwMDU4NjAwMA0KPj4g
ICBSMTM6IDAwMDAwMDAwMDAwMDAwYzkgUjE0OiBmZmZmYzkwMDAxMzM3YjFmIFIxNTogZmZmZjg4
ODExMGYyM2I1OA0KPj4gICBGUzogIDAwMDA3ZjdkNzVjNzI3NDAoMDAwMCkgR1M6ZmZmZjg4ODEz
YmQwMDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQo+PiAgIENTOiAgMDAxMCBEUzog
MDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCj4+ICAgQ1IyOiAwMDAwN2ZhODEx
NjUyYzYwIENSMzogMDAwMDAwMDExMTM5ODAwMSBDUjQ6IDAwMDAwMDAwMDAzNzBlYjANCj4+ICAg
Q2FsbCBUcmFjZToNCj4+ICAgIDxUQVNLPg0KPj4gICAgPyBfX2RpZV9ib2R5LmNvbGQrMHgxNC8w
eDFhDQo+PiAgICA/IGRpZSsweDJlLzB4NTANCj4+ICAgID8gZG9fdHJhcCsweGNhLzB4MTEwDQo+
PiAgICA/IGRvX2Vycm9yX3RyYXArMHg2NS8weDgwDQo+PiAgICA/IGJ0cmZzX3NldF9pdGVtX2tl
eV9zYWZlKzB4ZjcvMHgyNzANCj4+ICAgID8gZXhjX2ludmFsaWRfb3ArMHg1MC8weDcwDQo+PiAg
ICA/IGJ0cmZzX3NldF9pdGVtX2tleV9zYWZlKzB4ZjcvMHgyNzANCj4+ICAgID8gYXNtX2V4Y19p
bnZhbGlkX29wKzB4MWEvMHgyMA0KPj4gICAgPyBidHJmc19zZXRfaXRlbV9rZXlfc2FmZSsweGY3
LzB4MjcwDQo+PiAgICBidHJmc19wYXJ0aWFsbHlfZGVsZXRlX3JhaWRfZXh0ZW50KzB4YzQvMHhl
MA0KPj4gICAgYnRyZnNfZGVsZXRlX3JhaWRfZXh0ZW50KzB4MjI3LzB4MjQwDQo+PiAgICBfX2J0
cmZzX2ZyZWVfZXh0ZW50LmlzcmEuMCsweDU3Zi8weDljMA0KPj4gICAgPyBleGNfY29wcm9jX3Nl
Z21lbnRfb3ZlcnJ1bisweDQwLzB4NDANCj4+ICAgIF9fYnRyZnNfcnVuX2RlbGF5ZWRfcmVmcysw
eDJmYS8weGU4MA0KPj4gICAgYnRyZnNfcnVuX2RlbGF5ZWRfcmVmcysweDgxLzB4ZTANCj4+ICAg
IGJ0cmZzX2NvbW1pdF90cmFuc2FjdGlvbisweDJkZC8weGJlMA0KPj4gICAgPyBwcmVlbXB0X2Nv
dW50X2FkZCsweDUyLzB4YjANCj4+ICAgIGJ0cmZzX3N5bmNfZmlsZSsweDM3NS8weDRjMA0KPj4g
ICAgZG9fZnN5bmMrMHgzOS8weDcwDQo+PiAgICBfX3g2NF9zeXNfZnN5bmMrMHgxMy8weDIwDQo+
PiAgICBkb19zeXNjYWxsXzY0KzB4NTQvMHgxMTANCj4+ICAgIGVudHJ5X1NZU0NBTExfNjRfYWZ0
ZXJfaHdmcmFtZSsweDc2LzB4N2UNCj4+ICAgUklQOiAwMDMzOjB4N2Y3ZDc1NTBlZjkwDQo+PiAg
IENvZGU6IDxzbmlwPg0KPj4gICBSU1A6IDAwMmI6MDAwMDdmZmQ3MDIzNzI0OCBFRkxBR1M6IDAw
MDAwMjAyIE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMDRhDQo+PiAgIFJBWDogZmZmZmZmZmZmZmZm
ZmZkYSBSQlg6IDAwMDAwMDAwMDAwMDAwMDQgUkNYOiAwMDAwN2Y3ZDc1NTBlZjkwDQo+PiAgIFJE
WDogMDAwMDAwMDAwMDAwMDEzYSBSU0k6IDAwMDAwMDAwMDA0MGViMjggUkRJOiAwMDAwMDAwMDAw
MDAwMDA0DQo+PiAgIFJCUDogMDAwMDAwMDAwMDAwMDAxYiBSMDg6IDAwMDAwMDAwMDAwMDAwNzgg
UjA5OiAwMDAwN2ZmZDcwMjM3MjVjDQo+PiAgIFIxMDogMDAwMDdmN2Q3NTQwMDM5MCBSMTE6IDAw
MDAwMDAwMDAwMDAyMDIgUjEyOiAwMjhmNWMyOGY1YzI4ZjVjDQo+PiAgIFIxMzogOGY1YzI4ZjVj
MjhmNWMyOSBSMTQ6IDAwMDAwMDAwMDA0MGI1MjAgUjE1OiAwMDAwN2Y3ZDc1YzcyNmM4DQo+PiAg
ICA8L1RBU0s+DQo+Pg0KPj4gSW5zdGVhZCBjb3B5IHRoZSBpdGVtLCBhZGp1c3QgdGhlIGtleSBh
bmQgcGVyLWRldmljZSBwaHlzaWNhbCBhZGRyZXNzZXMNCj4+IGFuZCByZS1pbnNlcnQgaXQgaW50
byB0aGUgdHJlZS4NCj4gDQo+IFNvIG15IGNvbW1lbnRzIGFyZSBiYXNpY2FsbHkgdGhlIHNhbWUg
YXMgaW4gdGhlIHByZXZpb3VzIHZlcnNpb24uDQo+IFdoeSBkbyB3ZSBoaXQgdGhpcyBzaXR1YXRp
b24sIHdoYXQncyB0aGUgYnVnIGluIHRoZSBhbGdvcml0aG0gdGhhdA0KPiBtYWtlcyB1cyB0cnkg
dG8gc2V0IGEga2V5IHRoYXQgYnJlYWtzIHRoZSBrZXkgb3JkZXJpbmcgaW4gdGhlIGxlYWY/DQo+
IA0KPiBEaWQgdGhpcyBoYXBwZW4gZXZlbiB3aXRoIGFsbCBwcmV2aW91cyBmaXhlcyBhcHBsaWVk
Pw0KDQpZZXMuDQoNCj4gTG9va2luZyBhdCB0aGlzIGNoYW5nZSBsb2cgSSdtIHJlYWRpbmcgaXQg
YXMgIm5vdCBzdXJlIHdoYXQgY2F1c2VzIHRoZQ0KPiBidWcsIHNvIHN3aXRjaGluZyB0byBhIGRl
bGV0ZSArIGluc2VydCBhcyB0aGF0IGFsd2F5cyByZXN1bHRzIGluIGENCj4gY29ycmVjdCBrZXkg
b3JkZXIiLg0KDQpDb3JyZWN0LCBhbHNvIGxvb2tpbmcgYXQgYnRyZnNfZHJvcF9leHRlbnRzKCkg
aXQgb25seSB1c2VzIA0KYnRyZnNfc2V0X2l0ZW1fa2V5X3NhZmUoKSB3aGVuIHRydW5jYXRpbmcg
YW4gZXh0ZW50LCBBRkFJVS4NCk90aGVyd2lzZSBidHJmc19kcm9wX2V4dGVudHMoKSB1c2VzIGJ0
cmZzX2R1cGxpY2F0ZV9pdGVtKCkgYXMgd2VsbC4NCg==

