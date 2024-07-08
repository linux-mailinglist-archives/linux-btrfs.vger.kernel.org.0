Return-Path: <linux-btrfs+bounces-6271-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4987929B64
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 06:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526801F215BB
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 04:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD71BA45;
	Mon,  8 Jul 2024 04:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QeC6EskW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="W7tEt3Ab"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079313FC2;
	Mon,  8 Jul 2024 04:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720414626; cv=fail; b=KQ86ajYIsLMFsik9Tnm0i6uwFMY1LUJ3EbrgbTqrbXl/Z24R1vXqunBAe2/XibUGb9+kPy2Bpio7t/Fp6yOK6HgOnSQNatwUtr3s0MznFsi2aRKdkOMoV8Ei1bNDhehzNHi8XO7WAzDWMqi7cX62HPK7HbDIGmD4oYDFw170gdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720414626; c=relaxed/simple;
	bh=vU2UbXgtJznXb+seN7ZogCJ/8yzrPrkmz5LMEwINh8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uoZ0J5zToUcvCaAaglZL021945KdM/pA06ZbVRUhgJ8mZLZQFVsBsk8JvQPP47c7287nIDHoFMk6C49iu8NMj+B5ywEgIYSNP9eIJVIL2JkUp5vxHfi5GuyZCjU+avz+Ub7L1AjGXSt4zTWESzzL5UeGrZb/Lc8mkm6Nj7OdMI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QeC6EskW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=W7tEt3Ab; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720414624; x=1751950624;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vU2UbXgtJznXb+seN7ZogCJ/8yzrPrkmz5LMEwINh8M=;
  b=QeC6EskW7//IBE5x/AbcGUCJz9Qf3ClU+WT2ogNWVxEEM/n+H3xI315c
   6/6Su6F/fnMgFmLKiQSowaSaQLR5/Qz5DnZdvjoz72IEQ8PW66tnyTEem
   03USsVNpClwf+N0Ce6YtGyQMwfWonFLWnqkbeIGA75NyqZbrwufeWFvh2
   2furGgxwpab7fTz//M1KfenOlEeiACX0MK0Kt+HqnMLCWioshEo7Qfy13
   70MqX4vTNybrVpVFmDR0Z536kwx4Z3CRSAkW61K3qJwb6dd/TdlaLetA9
   taOWFhwe0TqThTByfQB18mxoDIGxJ7DE1adPWEDDznV1inYZkqfuu5au4
   w==;
X-CSE-ConnectionGUID: gZWthBKbS+iuwe/Kcch22A==
X-CSE-MsgGUID: Kwaw2cHBRUSxiYz2HQBJvw==
X-IronPort-AV: E=Sophos;i="6.09,191,1716220800"; 
   d="scan'208";a="21005150"
Received: from mail-mw2nam04lp2172.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.172])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2024 12:56:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7oTbxsYGwkHQTTlCT/JntUKfF1IAISRIWZF7ivlmykr6C/Zd2fA4cjTWzo82endKdDPbuKAju5vBJSukZ1tPNczynnTP623cUPSZIGsXzrzstSgANJvfAVs22Fmz6eivXOzlh8EY/B+6w1+qq/BTuFxEkowvwAXw/oL1/ChTXZKAiAhd5jbZVZwhxJnq1CCDROTpdGzlKdHhwqnuxSJlsuZM/lZtf88WNM2wGsckqfqAXW0ybWSA7Em/sFLjYrlOPdj6Gzy7Q6/qdFvXn7culG+7ebQDcAXYJn7c08TWvfD6TcET6E98GgvxE++azOBmtIcPLHcWzAlMHd431GdPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vU2UbXgtJznXb+seN7ZogCJ/8yzrPrkmz5LMEwINh8M=;
 b=l9B8uTh1ncTX+E4P6CYptC9zy+oPVjoCHSxlhIY5KWDaRbl9Sko+t95aq21PqDl0Hjr0Cbe+WUm8Q2q203SrN37dKl54Nvh6m3+N7f5+t7sKtZXgRq89qQl4CNFRS68NTXjoBognJZwgBh+huRgIey8/w6y/zMXNCXCrNGwOblFgPmdcqUUsphospf1XynCNNQDS7mwViUORPHYUoK65WU6b4KkP8JHgy+Dkjz4N9Jyh7/FIGARdc9R3ZsZlpFAd6onGXoHVwramZGXRFCxLrFDFm0EeVQKlBq9zuxoym10vDP6L3S35HXnr9jl3oiuiS3bxG8Y3wDYNRTfbU29EfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vU2UbXgtJznXb+seN7ZogCJ/8yzrPrkmz5LMEwINh8M=;
 b=W7tEt3AbEi0+w0f+8nmOcby65Cji+B3R4GVHEdRdB9EncanS0luOiyYnhmaKrsa1tHIlTjXg3RI6OOazX3+x/eq98r3wpp360Ju3AQ0go24d5z2w0nv6yIYKPzjH8JgMtWYT2SUHaOqRP6jq5Y1FJPp76XrAF5Ve8J7ac1idVR0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7304.namprd04.prod.outlook.com (2603:10b6:510:d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 04:56:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 04:56:55 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Johannes Thumshirn <jth@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/7] btrfs: split RAID stripes on deletion
Thread-Topic: [PATCH v4 3/7] btrfs: split RAID stripes on deletion
Thread-Index: AQHazu35+gWM7QXR/kW5py9pDxK19rHox7kAgAOA7YA=
Date: Mon, 8 Jul 2024 04:56:55 +0000
Message-ID: <e3927e86-d85e-4003-9ce5-e9e88741afa3@wdc.com>
References: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
 <20240705-b4-rst-updates-v4-3-f3eed3f2cfad@kernel.org>
 <e0041c2d-f888-41cb-adb8-52c82ca0d03f@gmx.com>
In-Reply-To: <e0041c2d-f888-41cb-adb8-52c82ca0d03f@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7304:EE_
x-ms-office365-filtering-correlation-id: 412615a9-dc97-42aa-dfa6-08dc9f0a63e8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RXYxekZJcEFCYS92Vmx5RTl4SUtlVlM5Zkd6VUM1VE9FWDNiODN0MTRKT3U3?=
 =?utf-8?B?MS94bENUREx6ZkUrL3c5RCtabDliL09GbkxBSUpEZW5QVzRTZVlydGpHMytN?=
 =?utf-8?B?czdhYTJCN0I0OTAvRzZ5WTVTZVB6RWtMRWlDMTRycFlJOEZzYmZhb0NKRFBX?=
 =?utf-8?B?Ykk1TTBTZnBaS1VJYm55ZWQxbXo4MjBVaEl1eDRVYzRhKzVRQk1HMXRHQVJ2?=
 =?utf-8?B?MkYvb1lrK1o2dlE4M3JzT3FBUDAwWjJMUGgrOU9nM2dkb3J6czI3bjdmeEcv?=
 =?utf-8?B?ZWlvbnBZYTVtYW4rRlZZdEZMQWRyT2Jia0JYdEhxQVFQSEs5RlZlTkhSalI2?=
 =?utf-8?B?N1M5MEF0VFUvcEhTc0diUjIxdEJ6VVJ6NEEwQjlZeVc0K08yWVdjUjRyamEw?=
 =?utf-8?B?VVFxSGhjYm1WcW5KWEJKUC8zS05UU1lTeHY0bi9IekNnczQ4dVc5c25QYjJR?=
 =?utf-8?B?aEJjYWJqWEdkZyszVk5YUlkydWZBTzlWaVkzUFp0N3RPeDlxckkvNFNPTDBR?=
 =?utf-8?B?Q0g2ZzcyYzlPdFlRQ05hQ3k5TTI4R1VNdmY3ck1HTG9wN0tabUlTbmtlUWZP?=
 =?utf-8?B?RmZnTWJneWJHQmg3d1hoSlJjZ3RkWmtXREF6YW9zKzdnZkl4TWViVWp5RFNp?=
 =?utf-8?B?Z1hHZFlKc1hxK0J5c1BLOFBTYU8ycXVLM1lHcHdCWVQ0WkwwVzZXTHFNT01M?=
 =?utf-8?B?QVFDTzhMUm9jQm83SDZuL0Ywc3J5NFphdmk2emRNdm1KVms3VzJKSGhvWFo4?=
 =?utf-8?B?bHA1cVRHTGpUak14TW13SVBrM2U0dFQ3TEx2YjRmcm9rVnVDNXlUQ2tVVWZl?=
 =?utf-8?B?SFBSdVpqSWxGZWdJTmtrZ0k3OXJWQmhRMkJkWWxOMC9DWTVNMUEyTXFLODhl?=
 =?utf-8?B?TU5IR3JmKzNoNTl3Zm1wNHZiWWZsNVcycEd6Q0dLV055SDFieG12NjFuRGRy?=
 =?utf-8?B?WFhuS2RSd1BJWC9HdzNSdHpsdVZUcTNLZ1NtRFd2RXMrczFlWTNMS3F0bUVO?=
 =?utf-8?B?d2Y0K2lmeFZKVWFiU2czZXJrWmdNY1MzOUZyQ3dPcXJFSGNWMm5oY3IwcUhB?=
 =?utf-8?B?ZHlCQUlOdGtjbXdkNHdaL1JrM21ScjV6S0NzWjBHcTg4S2IrbVhqU2xkOGVC?=
 =?utf-8?B?Y0wxL0oyMWlNS2FYcXNjTXJaWnM5RDIrWTNQZ210d25pbUloUHBCdEhodGtx?=
 =?utf-8?B?VzQrR3lTR0xlUGtpZE12MHh2ejZ6NFk4K1JVazZYZzVtZTJzZkVRaG9hZE1u?=
 =?utf-8?B?eEh1NWNSMjBzTzlTTUtSOTVCZCtjODBRbGRKakZRNWQya2VVYUR6cnM3UG5m?=
 =?utf-8?B?TDlkTDQvaVhHWUdUZkFkamhmQlNIU0ROUThaQ1F4aHZJc1NHUkhjdVI3Q1h6?=
 =?utf-8?B?TGVoYnNpR3dyVjRQSHc3VnVMWncyeHhwZkZKa0RBVnpyanROK2ppUVcwQmFL?=
 =?utf-8?B?VVdSUy9nY0J4ZmFva1VJcy9mMDVQT3pWQVlmL0lPZTlITGZLVUpVUk9uQWM3?=
 =?utf-8?B?bDRyOEhDZFdsWjF4TC9MOG1WWDdhWm5FVEdqMVl2bHRCdG9zVFVEVnBhKzc0?=
 =?utf-8?B?cjNEcnRNVGJwNE9YRGFQUHdqYmxaaVFmekFubTJBOUQ5bEQzUXYxaG4ralg1?=
 =?utf-8?B?Z3hjZFdHNFNQMTROdjB3aGtQY1ZBd1FTb2FJeUJQTXNqQzFLdCtSOG83S3dT?=
 =?utf-8?B?aExpNURtdzQydlFMcmhtMVZwWUNpZzM0a29kOS9BTFJlM2ozcFowN21DMGxF?=
 =?utf-8?B?UXZTcDZnTTVtbHV3VWVJWjQzSmdmWDBzd2I4NzRpNFMySGVERHZrZkNpU0R5?=
 =?utf-8?B?b0ZBa0VWZG9JRStNYmtueUlGNW04TlVJamF1VWw0SDBGVnBrZllPaTFuOExh?=
 =?utf-8?B?NGt2ZzhVNVRRMGRaRFJnVWZLaTZtTmlJSjlleGdYVnRRUmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZHU2Y0R0MjN5V05weHRVLzhGVmk4ekwvWnFzRE8vL1FGTjF2YTIzNGhyNmR5?=
 =?utf-8?B?cHpvRExEUkhlMDlZVjFhYVEwNk1FWWtYNnF3TVdkcnRJWi96Q0l2MEoveStx?=
 =?utf-8?B?dzE4WXdlOU5ySHpVWlhXdkdHR0ZhV3BSTGpwSGxKem9RMzczU1hwQ3JsUGxw?=
 =?utf-8?B?KzVvWldxcjNqWVdpd1FTSDZ0cUVSbmVhNFVSMGVSS3lRcms5MTVNdmhQMFBv?=
 =?utf-8?B?K1g4RzBqdzdiU0lpWkYwMUtJQWZBYWVxbjRRTTRueVY3emo0cENmQWlOVmV3?=
 =?utf-8?B?UDAwUVk5L3krYm1EUWQ0dENjT1RQTVRLM3NZQWRCSVE2VkUxcDZkeTFLSlk4?=
 =?utf-8?B?TEtQVnJGVjVNOHErZkVGcFBhQ1pJN2JNTHJKd2t6UElzVFJOVXg1amZkYStR?=
 =?utf-8?B?dUZWKys4eHJYUDJvV2RVUGR1TkhqYlFNMjRCK2NXaU9OMk1pbnhxdVFzSXVX?=
 =?utf-8?B?ZmZ5bVRVbkNncE1tL2ZSTGtMbFBWYko3N3BtS2lRL3A5U0VrUTN3cEcvRmU4?=
 =?utf-8?B?NTFtZFhnZGtFUTdOZXVrUTVvYjNnL0FvY1dmSzY5LzZ0V2l1MVBPaTFtMjRI?=
 =?utf-8?B?ckZDUDUxYlpGOHlseXNPYzhoTnZGN01pa0ZtMDhubThOVEhndXVNbkhtRU9a?=
 =?utf-8?B?MVg5Mjc1UkZyUlgzRnBjMHJUVTdWcGhpMkdoRk9ONWF5bVl0R3pjeUVKZE54?=
 =?utf-8?B?aFVPR29rUW93R3dNWk5GSmVDZW5GK0FvaWhSNjBJeGk1ckRhdUxCaHdNQmU5?=
 =?utf-8?B?TnU5QVd1R1RHeDdTN3ptQU81YjdyNDNmQkFhaUcrY081M2RZbkpMTTRDb1Ns?=
 =?utf-8?B?U1FyTEY5U09tcGdmaXB0cC9KZWxCK3p4a21iWVUzMS9PazlHWkxWSVpkdHhL?=
 =?utf-8?B?RDJQYXNuaW9CUWZYSkF3enU5L2hkVSs0cEs2QWhwbnVzUW1rSDNwazlYdDVF?=
 =?utf-8?B?L1NET1NtR1FmZHVVWGlKVTNmTU80Tno1cllPZ2VhTlJnQ3ZyQjVOKzlYUk9U?=
 =?utf-8?B?M2x1dEloL3lVdXUwbm5ORUo1M0RhNk5XRS9qbUNFREJYblhDaHhXbndZWUFZ?=
 =?utf-8?B?c0E5SXRuU3ZnQUVLNnVJSmpRZ29wYzJXc3pDcDBFRkdJOGRUWUZTWUtra09Q?=
 =?utf-8?B?OHJadmlhVURmcTdRY0MxemFGcHFOcG1NSUdQYkRad1dGcDJWSmFWdnFGTWU2?=
 =?utf-8?B?M3pVaUxHaUlQaU5NZEhNQUVhM3dHdTIrRWhSc24vdytqNFgzcjljbmIydzhR?=
 =?utf-8?B?ZjAxYVBzQU04dXlKV1p5ZVZHMGJ5UU0yVC9DWDNyeGVJNU9OT1lHWTR4QmxQ?=
 =?utf-8?B?UzRwYk9BRzF5c2dVSlR2ZmdWS05IS05LNzlsT1Zxd2V3enlpSlhDZkJGdmNm?=
 =?utf-8?B?elRjT3c5cWg0ZHk5ODR4L1gxVUhDS1RhWHR6Ly9ydzBrK3pzSWxLQnhLS1Rv?=
 =?utf-8?B?V0Vic1J3c3RUeVl1cXVLUFdWM3JWNFpYVEdZYk9IeW1DSFBrZktML2RMLzVZ?=
 =?utf-8?B?Q29YU05zNkJVSkV4WllDV29WWFg5b0FmVU05NllYWWIyZEcrOTBkK0NMVHRI?=
 =?utf-8?B?eXBMUTA0d1czZXhKT05vcTd0anliaXp4SmFqcWJNS2MwanI0YkdhN28zSWd3?=
 =?utf-8?B?UTVWMFF6cmNSRlJpaVBtczVPNjhmNU9jTjNQRGZyaVZmNjBMQmticXNIdys2?=
 =?utf-8?B?dHhXVXZodlFBYktnWjRqUWEzeWhBR3VHSzcrMjMzaGNDL3BqWlBheDBEUW9X?=
 =?utf-8?B?OWs3MUd6WUMvajF2SUw0dGorUnVxMVMvRGMvTDhtZUVYcUJIdFFCeS85ZGRV?=
 =?utf-8?B?NzljNVNSY2VkQ2FvR281cWlQT240eVEwaGdRS2ZhMFpxOXpabDk3UGN1STRW?=
 =?utf-8?B?TzU0OVk1OVVWL0tWaWFtWUxaY0JtUS9zUHh3Q0RlSWZqOXlTd3dRSkJXeGxm?=
 =?utf-8?B?QkYyaUFMOVA0dFoxVUFOVzZrb1pRdm10N0JwOTNqNFBMK3RBVG5IOVpyUjBy?=
 =?utf-8?B?TWhIdzVUQVFISk5CdTBMbW1vNGRKRDgwR3dZck5UUlBqd3lMVzRCaG9LcTNX?=
 =?utf-8?B?eHpTZjl4RzNjRlFMVDZKQmdEK2tsVlRFTW9JRTV5R2hwUjNiRTBsTlJOdjJl?=
 =?utf-8?B?Z1Q5MEpxOU9jdGJCVUp3THppVmY4cFVqVlpiVy82azAraDllMTBldnYvb2lD?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C6F536735408B4BB4B33A75A36F7346@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x3VwJ/k5XQXBZMDhL86FyN91Twrmou1ad7esaG9YSY05WDzCFlokWmgIu/GzNWxQwIw/PWTAVdZTWDz9BavCPjaBzHIuOUoKOw878voQq5f1ovRYRuomVJDVX9e8bVzsaCn2P6Qnc89FJkyLTDOBVEQ0JmzV/jGCowUG4/7p3GiYQn5aBFu1do8FHZfQh7nw6PVZ7RxLQpX611nhrxg3Q2XPpPui60bBBoNpRAz/YDG/uar82PMN06zR48G/hS+L6tPg+BSyiTBzSFLNZyhXoa88S8NGBZcbL9uuYnnPdQp5hKoEcRjsUwQjXxBx0PorMGia2ZiZ8K++Z6FKyBTiAmDi0nUg/KV0KwuwvvlyA1/5H0Xvk/BzbdAxJxMCOJa/goTU6GW468ozYHSlggU4ibXphapColCZD9HeuH91oAMph+g8idcGsDG2nZuJiIJwxoou8hQdrhF/CYs9deWqtc73oj6q1sf2zFF/0+slWlanDi+5SuypqMWKLWbDHJTqxVrFxYEZpCSsua1SAYGnDxFJNFXDUul5n2P5niAIr9ZsavQoJeG6yZiTOhymjxwpkaH6gWp7hcR3KM3+X6F4SyxcAAVbcNsfMe4tQNbuWApk5Muzpd0veeiu0OeKlLJY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412615a9-dc97-42aa-dfa6-08dc9f0a63e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 04:56:55.3181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pIaSDgkhhKIjaXOZfK1AIWj04vLl7Mgwz3k6mJXss5l6P3lLXaya4F8JbEDSFd3RsDjagRHIc7DSNshkdkRzaqBF03fx+ErcR1Dz8Oz4C6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7304

T24gMDYuMDcuMjQgMDE6MjYsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiDlnKggMjAyNC83
LzYgMDA6NDMsIEpvaGFubmVzIFRodW1zaGlybiDlhpnpgZM6DQo+PiBGcm9tOiBKb2hhbm5lcyBU
aHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPj4NCj4+IFRoZSBjdXJyZW50
IFJBSUQgc3RyaXBlIGNvZGUgYXNzdW1lcywgdGhhdCB3ZSB3aWxsIGFsd2F5cyByZW1vdmUgYQ0K
Pj4gd2hvbGUgc3RyaXBlIGVudHJ5Lg0KPj4NCj4+IEJ1dCBpZiB3ZSdyZSBvbmx5IHJlbW92aW5n
IGEgcGFydCBvZiBhIFJBSUQgc3RyaXBlIHdlJ3JlIGhpdHRpbmcgdGhlDQo+PiBBU1NFUlQoKWlv
biBjaGVja2luZyBmb3IgdGhpcyBjb25kaXRpb24uDQo+Pg0KPj4gSW5zdGVhZCBvZiBhc3N1bWlu
ZyB0aGUgY29tcGxldGUgZGVsZXRpb24gb2YgYSBSQUlEIHN0cmlwZSwgc3BsaXQgdGhlDQo+PiBz
dHJpcGUgaWYgd2UgbmVlZCB0by4NCj4gDQo+IFNvcnJ5IHRvIGJlIHNvIGNyaXRpY2FsLCBidXQg
aWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSwNCj4gYnRyZnNfaW5zZXJ0X29uZV9yYWlkX2V4dGVu
dCgpIGRvZXMgbm90IGRvIGFueSBtZXJnZSBvZiBzdHJpcGUgZXh0ZW50Lg0KDQpObyBwcm9ibGVt
IGF0IGFsbC4gSSB3YW50IHRvIHNvbHZlIGJ1Z3MsIG5vdCBpbmNyZWFzZSBteSBwYXRjaCBjb3Vu
dCA7KS4NCg0KPiANCj4gVGh1cyBvbmUgc3RyaXBlIGV4dGVudCBhbHdheXMgbWVhbnMgcGFydCBv
ZiBhIGRhdGEgZXh0ZW50Lg0KPiANCj4gSW4gdGhhdCBjYXNlIGEgcmVtb3ZhbCBvZiBhIGRhdGEg
ZXh0ZW50IHNob3VsZCBhbHdheXMgcmVtb3ZlIGFsbCBpdHMNCj4gc3RyaXBlIGV4dGVudHMuDQo+
IA0KPiBGdXJ0aGVybW9yZSBkdWUgdG8gdGhlIENPVyBuYXR1cmUgb24gem9uZWQvcnN0IGRldmlj
ZXMsIHRoZSBzcGFjZSBvZiBhDQo+IGRlbGV0ZWQgZGF0YSBleHRlbnQgc2hvdWxkIG5vdCBiZSBy
ZS1hbGxvY2F0ZWQgdW50aWwgYSB0cmFuc2FjdGlvbg0KPiBjb21taXRtZW50Lg0KPiANCj4gVGh1
cyBJJ20gd29uZGVyIGlmIHRoaXMgc3BsaXQgaXMgbWFza2luZyBzb21lIGJpZ2dlciBwcm9ibGVt
cy4NCg0KSG1tIG5vdyB0aGF0IHlvdSdyZSBzYXlpbmcgaXQuIFRoZSByZWFzb24gSSB3cm90ZSB0
aGlzIHBhdGggaXMsIHRoYXQgSSANCmRpZCBoaXQgdGhlIGZvbGxvd2luZyBBU1NFUlQoKSBpbiBt
eSB0ZXN0aW5nOg0KDQo+PiAtCQlBU1NFUlQoZm91bmRfc3RhcnQgPj0gc3RhcnQgJiYgZm91bmRf
ZW5kIDw9IGVuZCk7DQoNClRoaXMgaW5kaWNhdGVzIGEgcGFydGlhbCBkZWxldGUgb2YgYSBzdHJp
cGUgZXh0ZW50LiBCdXQgSSBhZ3JlZSBhcyANCnN0cmlwZSBleHRlbnRzIGFyZSB0aWVkIHRvIGV4
dGVudCBpdGVtcywgdGhpcyBzaG91bGRuJ3QgcmVhbGx5IGhhcHBlbi4NCg0KU28gbWF5YmUgbW9z
dCBvZiB0aGlzIHNlcmllcyAoYXBhcnQgZnJvbSB0aGUgZGVhZGxvY2sgZml4KSBtYXNrcyBwcm9i
bGVtcz8NCg0KSSdtIGJhY2sgdG8gdGhlIGRyYXdpbmcgYm9hcmQgOiguDQo=

