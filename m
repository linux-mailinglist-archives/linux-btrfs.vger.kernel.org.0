Return-Path: <linux-btrfs+bounces-10107-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2969E7FB5
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2024 12:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C91166F53
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2024 11:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6AC146A6C;
	Sat,  7 Dec 2024 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hOmGa73w";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AD/hVxzW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1451384BF
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Dec 2024 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733571003; cv=fail; b=dP8jAk2vLpwqjnoWcdyW2yzdl0p6fjhzgRtAbK/NyDlVFM0At3tzyIfoAu0Qn2/rhMlxa10Jd/G+231HcGTVCrTARQ/Ka71amTiMorex81pIwpxmBfu98GWph878Atqcq3CRL5KXq7DjP1sieNUQjNRl4PtyvBZtlmatJK5gjAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733571003; c=relaxed/simple;
	bh=dd/cYXvUOilDOKJr5ISoTSSQ10itPl+6fPTAnO0WXkU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rkk9ZOHlmM2dT9AlUDvT7tfZz2WDTiZRn7BTgX/f0bucjRFYNdYTPdsYo6tV7zKtOEIcsjVPdxseDFf1PugP4AOeFWnXVnGV2nuKL5nMiJrllKHQA02L8L6Kcp6+9+0qK2ExS437WKXwmLCuVktjBU23Q9sEvcPmmviglddq5PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hOmGa73w; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=AD/hVxzW; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733571001; x=1765107001;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=dd/cYXvUOilDOKJr5ISoTSSQ10itPl+6fPTAnO0WXkU=;
  b=hOmGa73wOSnP0Yfc45PLL9lv2u6NZAbBFlXNTCuAVnVIJm+z9LuH/iKh
   93QGgw8YDRQyZo127tc+LbBPCacX2hJMqXoG5i/5MJLen1nv/bO5Xow9t
   CPXOXVe+EOz3/APfYFn4HLmn4uN1xMpAuzTNIeg2972/BHBPEJUuql4IT
   wq+Ojyn5bNq+yKWp0hzGIG/JblDxNyictIgh79jvEAivguFcu4BVXGvGa
   5L8nv3JU9AExM+nuOcneFEa9j/TlIo4mi5Xq0c2gp2BJL9sjec2wUoE4s
   EpOu7DU+RaWqtn3aP8Uy8kgnPJBsgkfhe7ywfVJWbG57Ov5yHpMYY/b4Q
   Q==;
X-CSE-ConnectionGUID: eafZ2n7KR2q37jMhHqFNSg==
X-CSE-MsgGUID: 5I9EzrfGS7ygwMWq65FQkA==
X-IronPort-AV: E=Sophos;i="6.12,215,1728921600"; 
   d="scan'208";a="34403307"
Received: from mail-westcentralusazlp17012038.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.6.38])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2024 19:29:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVsi2vJuyLgYNRnlrzXXczJ16AfVUEpWzAe1AeoIlZdTr8+ox1E+OFQzxCkKIojh9XZECpu9o31Wr5Y/0Dc3ppB1/A2VFSkJZeq4wS8TxlWW9o5JArvUBH+R72WaMbJ0UiXC3y4I8U2LYTHWpMNghA2ZepjSSBNIcCTcJPOQb3I3rp2Lo2bzyiXA6VGSznUgGMEX1wmJMh35SLN+R9UKVJqGG39NqAkDu0BEqkcUPC+9aowaYpHfHVL7hRtasCyimPZLU6BF1W/mPCh5bE+OSIpfPReUKpq3tNhnnjrhlGf94D/TFWbGN/w7V8NPyXobaTcoJYdQf6xEJQDWqJiEIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dd/cYXvUOilDOKJr5ISoTSSQ10itPl+6fPTAnO0WXkU=;
 b=VPPm/EdvhUWKWeKIRJ3TPEkUqp7tRC4puNP2h0n5pae+wdMA1pbmQIUU/ik2yaCDy0iWdK4nJwC3ykw8FzWG39X2YmDA5w4+IsLuifPqUmMeQq4cmH+dYsYIYVXi3LigSn5ctRYz7YovwBe3EhUJwnHAxsvwxagr9efEDRtuLKCC1tdZRov6wRoDLgq5l05irC1tTYv3lCwt4MizMVE6PqBQpsVG+PA+HRwWeF5I+C5DcxpC8BjqlI2b0wUTpIHCWBO6tyK7XVi81HuyuZYkQ6H0blMiDefhDxff0GAGElx2Q7LV1Lc6nz1kDo4qT4wvCg/DuY15omGj8+TSGN4M9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dd/cYXvUOilDOKJr5ISoTSSQ10itPl+6fPTAnO0WXkU=;
 b=AD/hVxzWQ7nS242yUPEvY0Q5cwWig8Jxp7WTQezTfyWsCf01AUeH4kZ8JYwLXhShkCrd7J5yY1NQheywhzKIR/RNrLExtb3UB7kikPZmE98A2twRRebNEBv3yOw9/57hRMhgypcq3gmRnN1tcZFpO3xLzxiePZwvSbYwgwFuhp0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN6PR04MB9382.namprd04.prod.outlook.com (2603:10b6:208:4f0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Sat, 7 Dec
 2024 11:29:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8230.010; Sat, 7 Dec 2024
 11:29:51 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/11] btrfs: factor out check_removing_space_info()
Thread-Topic: [PATCH 05/11] btrfs: factor out check_removing_space_info()
Thread-Index: AQHbRups1XwEpvL59UGZqc8EYsm75LLaqNIA
Date: Sat, 7 Dec 2024 11:29:51 +0000
Message-ID: <4d51d335-ad2e-4ed4-b100-51f45fb3be20@wdc.com>
References: <cover.1733384171.git.naohiro.aota@wdc.com>
 <f4f89b4574df77147cffb21e5f74fd033a8dffbf.1733384171.git.naohiro.aota@wdc.com>
In-Reply-To:
 <f4f89b4574df77147cffb21e5f74fd033a8dffbf.1733384171.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN6PR04MB9382:EE_
x-ms-office365-filtering-correlation-id: 460de47f-3f51-482f-1bfc-08dd16b27736
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WnI5ZkJGaG01aWI5V3ZqVTlHVUNKZElFR3RPaEszU29kWU5OZ0U2NS9VYmJF?=
 =?utf-8?B?c3dzeEkrTDhONWJOUjQyeWtadEFacXNPOUV0WHF2RGpsOUxjY1VRbG0ycnZJ?=
 =?utf-8?B?SktvWnZsbDZqbk0zTURSMXV6ZEhSZGlhWkVaZXpBWnE5ODFuSm1tbnF6NTBQ?=
 =?utf-8?B?cThqSjRhckJibGRjTGNzc0VnRDdyMnM4MEZUWGMvem9sMDlCZjJNelFuU05t?=
 =?utf-8?B?dWJ2MUNFNGxCNHFHdkpDODFCZGhFUXBNMTNwMDM4TXlTYUYybWRGQ1RoTHU3?=
 =?utf-8?B?MGxHTDByR1ZpalU5cnNsUTdERC82QzFUR3A2SW1SQmNJYXBSa3pYS1NDckp0?=
 =?utf-8?B?ZkJsMTdDSk9qaWwyT0E2dFVxYjcxZHhINGJCSm5zeVdJZFYwM2JKQVhvQXBN?=
 =?utf-8?B?L2ZKaEJMTlQrNkFRR0FQOHJpdFdmVXkzUkozYW9pY1lFRFgxeC9yV0xrMHRq?=
 =?utf-8?B?N2VZb1RlakVLNjBVdVlJQjBkM210cTNPREZsUGlIQ1gxWFhudStOWTByYklF?=
 =?utf-8?B?U3J3S25FWGJlVW5xUmNJdktsQVpHUUJBS0tmdzdLblFrREtKNk1FVTdlNlI1?=
 =?utf-8?B?M21iRXBXeXN4ckxleG1VWnNIT01ZTU5oRDJmZmZYNkQwbDhiRzc0TlNaY3hV?=
 =?utf-8?B?OS85ZGpocE5SME9KMEpRNkMzOVBYMW45V2NudUlieTFoajU0VVlJRGd4QkhC?=
 =?utf-8?B?dTFZMzlXYWRKVnFZMmRFMGd3ejkrZHAzQmVxM3BmeHMvallqRVpVSGx3ZEI0?=
 =?utf-8?B?ZGxoQWlQN0hFaTNtdXB6aDhGRDF2czFzUlhpektxUWVkekNyZFZTVlFnOS9E?=
 =?utf-8?B?OHpOdmZ0Ym9BeTgxZjUxWEVNbTIvUTJtRm5nUjU1R25GL21nRGNKY1V4eDNJ?=
 =?utf-8?B?NHd4aUlxTEh3RmNQS1kyM2R0OWJLMEl6VjhmZlFmVmVobkdhbVlYM2xuYzJw?=
 =?utf-8?B?Q0xGWXZTejlGdERLQ2Y0dkRrU3lxa3BNQzNPMHJTN2RGTVZyMVFKTHRTekxx?=
 =?utf-8?B?Z0d2ZTk0dkpuSXcvdXFjeWc0YmZpNHErelhockJsQUR4cGpnVlRLZnkyZVho?=
 =?utf-8?B?Z1pjUUxGUHFlRkUyaWRadE9XVWNHY1F0cVZvNW1uVkdqTXc0YkY2ZmRpYkxy?=
 =?utf-8?B?UWRDUXBWeGYxYU04dHdUTCtRSmg4T1pPQjErN3llTXFWanVMU1VOUHg0eXZw?=
 =?utf-8?B?dnJWQjkyczRNc3pJTEJyUGV5YWJGSEhCcWN2NGVNUEdTZHRCV21XTUpUa3NJ?=
 =?utf-8?B?ZGdKR1RBQlFYWXhHb1RTS0NvK1NWTGdXOExwWmtsbW5pNEFIU0dTVHNDRDA5?=
 =?utf-8?B?WHhKYWFtTEFzNG1WT2FVbzNrb3pVbnkwTTdlcjhJcDBvWk9YSVJ4VCtPRjhJ?=
 =?utf-8?B?TVFQQjV1V3JST3hFYTlxd1FqSmJrV2lCb0FBTWlVM2UyY3BHNVpjM0xsSXlW?=
 =?utf-8?B?Q0kxZ2RIaEhQaEp3ZEI5bkJYTU1yQzJvcW1sVzY5WWk4Ri82VHg3ZUk1eVcw?=
 =?utf-8?B?M1ZiTW1pMVR4Z3ZxZ2M0bDhDclhuWFNoSVE5bVBvRzM4aXBWcklGSy9odUYw?=
 =?utf-8?B?OUM3YlRVMnZYOXVPeTBUZHQwVTZVbTJTYU9mU0lOQ2hBdklxYS9qY1oweGVX?=
 =?utf-8?B?YlJRWWRMQ1I4aVpVMVoxbjRhelZNTlBEVnR5SElxeVlyUlpxWktWZ0RUeEpr?=
 =?utf-8?B?Y1pWZ29GQjI4MEJZK0hkN05QNCs1VVFTcHFkbE1BdVJWODVPMXdIVmxNVWVV?=
 =?utf-8?B?aElLUTI4TlFncjNYQ3k2L3ZheGd0eXNkbDJCQlYrbnM5bFExS1dVNWllNnpp?=
 =?utf-8?B?VFNtTkFVQXNJT2QzdDdQN0w3U05EVFFIelpwRGk5VHFGK1Q1eGdvWmRQaTRW?=
 =?utf-8?B?eWhzY2NQKytiem9UZlR5ZFptRDdaT3d2anFNQmpDdExDbHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?am9tTHNFWlY4U1ROS202RnFwMkU4OHhqWGJsTFkzUEtNOGtJaTloa3drWlc0?=
 =?utf-8?B?bUtCeWxnUWZJTzlLZ3UzQ0l0aVFhWVZKaS8yVVZHcHQ3aWg4YWxoVGVkWTFP?=
 =?utf-8?B?dWhwTkdmVmZieXNWcnlMNU5NUTQ4WURuMHI4OE1pWStJQklZWGZ6a1QvQmdp?=
 =?utf-8?B?QXhrMkpwcDJNN2pMZlFQZ25LSE8xZm5EblIvcEVDV3JDZEowMGVzbVlJV2RU?=
 =?utf-8?B?eTJVVFBkaTI0RGRhbEdFVkwrVXE1eVc5b1JoTU1wU2VGd0krWHBianIyZC8x?=
 =?utf-8?B?cXU1WW5wc09naWE4OWFzeDAxUGpBay9FQ1pMdUFRTUpMV2ZFTVkzY0pIUE04?=
 =?utf-8?B?OXVkcnlrOTVUc1ZDYTFMc2NldzhwbzV3QkVqcXBQYXNId080aUxFQUpVRkR5?=
 =?utf-8?B?eUlQT0sxSEZPQlFVWjdLTm9JbkYybjlwM0FKRU1ZRHlnQ3hDdGwrNTlIaC90?=
 =?utf-8?B?T2M3YmdjYURyWmRCMVNoQVVYWkVQdit5SzVqWjBWdEFRcWhCZFFPSCtycGgx?=
 =?utf-8?B?emNvZVFxTVY5aWJIRnFwaTVOVUwyMXNiVlpTUjR0MzBBeGdHaGpBZ29JWndr?=
 =?utf-8?B?a3VDalk0NUZEbW1yallNUnNGNGxtNTJ4WkFBbDIvM1lVVU1leG93Z3pvSzNJ?=
 =?utf-8?B?eE12WjNXODR6c3ZLeEVuNGFjb2xZbDJMTDVSYWdqaFJOZjUwbXIxYS96ZTZ6?=
 =?utf-8?B?WjYvQmhmTjQrWVJGR2k4RytqRFdGRncwdlV5UDNkVXh1R3ZIWFh0ZHRxSjlx?=
 =?utf-8?B?MENseU1kTWU2ME01UlRXblRURjZMTUVhMWxGV082NlBUcjNtQUNkMnoyNFd3?=
 =?utf-8?B?UnZTTkNoWXMxZGNUajY4UVo1TFZJeE9pUVpldjhJZCtYblFBanJSemliNmpL?=
 =?utf-8?B?dWZkbzlISFA2T2pUc0NtVDhMUmZ2b0diNjV1Rm15SWp5QTlzTHU1ZU8xWE1J?=
 =?utf-8?B?U0hOT0F6Z243RHhPK1Ixb3c3YXdNeVlSSmVGREZJMHZNQ0xteE5VL1l3SFda?=
 =?utf-8?B?YW9WUFNJdENWb0gzUjY3bjhzaWM5QThjQjE4aGxhNmxLc0F0T040c01xY29Y?=
 =?utf-8?B?cXAyV2tsM1BHaVFnN0tQakkwUm1kWlRuTEM4Z0VYT2ZzNXJoWDdVU0MvMndX?=
 =?utf-8?B?aEkvd1pPdCtiZGRyS0t4bjNuY3N2V1VZbmxtc2NSdlh0T0o1alVTY3NYQWti?=
 =?utf-8?B?cE9kMEVQcVBiZjVBUDJlUFN2OW1pcUJITW5HMmtYL0tldVJDdlZsWHlXWUZ3?=
 =?utf-8?B?UVBHeE4zUzJZcXhtc2tRclNsak44YVRKNnBTL2xTQ2JMRjZZZmo0MDZ0Z3ZP?=
 =?utf-8?B?VEpoc0hGcmtrem5rMWtKUlQzenJqU21lRU9Reko2cXpmWkllNEtOMDRqME40?=
 =?utf-8?B?V3hqcHNBUnhNclBEbkM2MWkwQmlUenROZjdyNVA0azRGVWhqS296cGE2RFg4?=
 =?utf-8?B?bE1yc3VMYVV5MFJyV01PZ2JhS0dYNVQ2ZHJRSHhaRHB2dmtreG1qTXNkc29M?=
 =?utf-8?B?N1hVZ2szOUxCZnl4VEd0SHkrbDV1MmxRdDg4bG5NbmtUdzEwMkxuOVN4S3hj?=
 =?utf-8?B?TGkydE00YUdZeGZuU3B3cGZyOXRUT1pVeFRLS0NxMnlweFlhbzdBaWphVnJR?=
 =?utf-8?B?QnpYWFEvUmVBMzZZNzlSYWlBS1BId1g2ZXZCMDNFV1RCUTVZVXZJbDdDSmdF?=
 =?utf-8?B?bi9VVkUvdkhMK213NWJ1K3ZBaENhTlJKcHo4bXFEbzdKUEE2ME41OXFzWERL?=
 =?utf-8?B?Y0o5QTl2NTJweDN4RU94b3BJTm1TTVpPOVRsOHF4Zi9XcUZoUkhtWEw4YXV5?=
 =?utf-8?B?L0hlb1ZxWHVOZWdKOGZZNlUvRXQwTjZmMmliK2JGM01oazlBNDUzbnpUcnBK?=
 =?utf-8?B?RFlqYmprUy8zNThTWWI1WkdsMTJQOWx0bm0zRldubi9LYVFudmloc0ZlNFZ3?=
 =?utf-8?B?eldwaVlRNHB4cDdEUjVQRFlWZVpjT2Faa093UlRrbGl1UGlRUzYvOVNydWlD?=
 =?utf-8?B?MDlSUHZkN0tWREVCT1pDTk5jeWdGcVpzenZrQk0rNSs2N3ptbDNNUUQ5Y0V3?=
 =?utf-8?B?a3BKU1RwT1BlYklwOVU5S3Fwb1JqWlRrK3NyS0xvTzRJcmdEQ0RLY2lVTmNU?=
 =?utf-8?B?V2xaNnh0Z2RCUlNpNC9VcWpFNkdhbWRkd1IzajY2V1hlQ3VPd1NKTHB1MlM3?=
 =?utf-8?B?YVJLYlJ2ckRjd2FNQWJwcHRvOFBsaWVTZS9aRzhSaGdQclJKVmZHc2ViZnpQ?=
 =?utf-8?B?Tk0xWUJZUm44Q1RQNjBURnZyYkt3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D1877F01E1625469B66717972CF528F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IC0nKf8eZV+N/odWPR3FKd3fOIosEWDlZnvkCMwU2LwBhPAp/7BZk/d+SbcLfaP+ub44hhiMByTmOD5bJHIT3fAGVI/p2FOpcIPbqkRov9tLcJsbcVWLPFeKymJlgRq6sR8NiPVFeoYOoOf7qs7VP7Bzeak70MjtEmZ6vr+N8oy7w7tzwYWj8HO/ja8we/MgKlmFdyCSovTk7nX98orDvnr4DuXuYm6r3VKrBXh+iLupoFjvFwAUAraALGRGbjqqEKQzVFyy3vKi5yRO5vGajgIb1Ono5vu05De+Cv2nvswdi79tXhtnM4TW1+7bHi9zC7AYxUfOK+TfkZcs/Jbv64uyzTOGNaJ9mMoWYn5IY4sHr3CMB/tQ+HetLOse39EgtZJtv/GcSeESTuVO20QbVwGVxnNmdywy3PySSYKzOCVQUVkXgPI29W7Bg31GRTmfyweLjWq1tNP7eqb96HkLz8W0vVu282wlYC62MGvhNCHt+UOoE7L7jvnqNcbsgLy6PmDUQVuMrmi6oFl9P1J54EsEzVOUge306pGR9IHbFG/lN/NTmOkLIM+33tBN6yaV/VrKbHK1hU/GxNk2M9AU5qupSdTCw16yBpWvfQXa5/iPPH4Bc/A6ewqNVdZc0Zww
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460de47f-3f51-482f-1bfc-08dd16b27736
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2024 11:29:51.6369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4Qo+uwn9hwavvmTt899ttBKVYkpiB1H5mHHA84EJQICnv4mEb5Ahc2E+uPsiEHpn/54mKK/YyxlZ4+ore/p8VrexYvSaVfrpXa+Y1fSz08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9382

T24gMDUuMTIuMjQgMDg6NTAsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gRmFjdG9yIG91dCBjaGVj
a19yZW1vdmluZ19zcGFjZV9pbmZvKCkgZnJvbSBidHJmc19mcmVlX2Jsb2NrX2dyb3VwcygpLiBJ
dA0KPiBzYW5pdHkgY2hlY2tzIGEgdG8tYmUtcmVtb3ZlZCBzcGFjZV9pbmZvLiBUaGVyZSBpcyBu
byBmdW5jdGlvbmFsIGNoYW5nZS4NCj4gLS0tDQoNClRoaXMgaXMgbWlzc2luZyB5b3VyIFNvQg0K

