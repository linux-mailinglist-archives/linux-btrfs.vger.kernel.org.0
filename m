Return-Path: <linux-btrfs+bounces-12454-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 585F6A6A5D6
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 13:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F4B884B57
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 12:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C35A224224;
	Thu, 20 Mar 2025 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BfKMwwWH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Wkm4UHfd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4FE2236FD
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 12:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472220; cv=fail; b=WSW7Ej2mFxXCRBoyYE0PdO4gk4OQ6BUxJxh/cX1SVIPzpLokBmGHEelc/hckXmcC/TzOwMn9JXI9Lo/DEI1MYBdM3F9CPIIvh2ns1IM2/vfmRF7zFKfTk/lZ+51lIlz3J8veKSYQwCAFhmpr1pQmkiDMNA7/WPn46LKTvFfDaVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472220; c=relaxed/simple;
	bh=wz2OfLWs4ZZvhDH6196t/BpQ10ldgFPlkKN7FrpRl0Q=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GL+8s2UAUz7bwqSEZ48TythAkp/yRrZRrqhluM6P0sFNwJySK971lAVZBncc18KaQyubrT+GvtQG9DMFOPCg/yQfDyhmJMDa57PyqRWVJZz+WEf6x13HJIFpKepClCSZ2EgRFGnJeBLDFeTZa/VLeMRgAE/9YtoMOvMPFzgKZXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BfKMwwWH; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Wkm4UHfd; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742472218; x=1774008218;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=wz2OfLWs4ZZvhDH6196t/BpQ10ldgFPlkKN7FrpRl0Q=;
  b=BfKMwwWHIHddpyQR5XL0cv0IITS63bokz7VXl2QrEFi22CTnBL+/lYfN
   ucyOCTqkP/3wpbpIiFprzz3LubiQy1RpYpmoGeNJDR039v9IY0eUVgYUV
   7J5F/Z2zTXz+E7Ukthz8SjxDrjteLGzObv1SRoypsZFSV5c/Hpkb2/0Qm
   HbAC23OMdeCrbVEONE1/0C4fGedqWCaKAzc3Wfn8JDekNcycG+hHtEz/T
   h3Z9WdOQr44M38hS5jPnhGSE2JrL1vXWpCQrTVqIqrFiM/+Hk1r8dst48
   8Gp6rQft0hrbsnFBuzPn1hpNl+n40VdNaXVd+45lR89Gq1VrDH5y/8lXd
   A==;
X-CSE-ConnectionGUID: kFmTXmb7TKSaxwCQAWaOfg==
X-CSE-MsgGUID: Xil0lBJuSu2v/xZKjxTxnA==
X-IronPort-AV: E=Sophos;i="6.14,261,1736784000"; 
   d="scan'208";a="55064165"
Received: from mail-eastusazlp17010000.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([40.93.11.0])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2025 20:03:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9H8oqsSAgqf4NCRs9dHHasyu0C8QFSuZxLC4bKs08tlnWUfYUj36XeEY8yG/yC1OjIuaHjIhkusvfPblysHl7+vuUljfvsTFn7XqmSEzZoPLYdH7Adpq/9inPzXN7iJXMMDZZ4BpbEUAPVlHlQS/AYKf+n/9tIVlA0hgQc9BD/QJK7hRBC9hn3nUtz91Oldplruxj2+LZn+rBMx1Ot7z16Z+g3DGAGuXcW3aNk1YTjgdr9OdL8AdH3eqaeVSGq3L2JcY0/wM8fGNiXrUkhelyomS1+pMRvMLjICWyi52qRpJoX8NA22nYvhoKDMQKjpLGuYT77ERU99GPF62+tyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wz2OfLWs4ZZvhDH6196t/BpQ10ldgFPlkKN7FrpRl0Q=;
 b=eALoEcNJyvBJGKnWLeQHMexs4aLNl/9oZW/i3lQSk5H6UWAL9y3FMva9NwymDop3ssN+gcnNxl4lJ4JF1i1SSmiNjJxDcCCNB0xnfG/4vtDEHdoI/rtxQeToPu2TwB7nCSLEPGU+NMv6lMiWjZ+04JPKRGs1nVbhrDo9qTK8grtia6384ZseCMrznVb/VojE6dOhJ2/KSqwaXdFY2nDBBWkPu7RdnDrHUk0lUGq8XxIgtDpXk7cXviB8TE3KUTWkDQK5FaV8LDsbvaKr1Mx+/qcHiyWkceJncYcuzxFbOotPJWMphwQksNDcYeGbaGIj47VKtcdQgwo4lPoWvQuyzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wz2OfLWs4ZZvhDH6196t/BpQ10ldgFPlkKN7FrpRl0Q=;
 b=Wkm4UHfdDXBgkLu73A/4cgSZxkUFW0KDj+p0TTXjCdxrqKNu989FD4fFI5RhKMsNHwMTCOxet92MYdA/yZFr7ebfJr94cUDdMO+xXIGM/trx5ypdDYmHTIl8gV5wukxyLr9UzRBa8k6iS4DzsJPEvYy7dTyoiKExobn6GEdymvo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB6530.namprd04.prod.outlook.com (2603:10b6:208:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 12:03:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 12:03:30 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 05/13] btrfs: factor out check_removing_space_info()
Thread-Topic: [PATCH v2 05/13] btrfs: factor out check_removing_space_info()
Thread-Index: AQHbmJaL/1ZWBSsWREudUPCrk5vfrLN77wMA
Date: Thu, 20 Mar 2025 12:03:30 +0000
Message-ID: <1b447ccf-d53b-4c0e-8abe-6fbc937d6281@wdc.com>
References: <cover.1742364593.git.naohiro.aota@wdc.com>
 <580c3b12069246506736dd829725feb500397f15.1742364593.git.naohiro.aota@wdc.com>
In-Reply-To:
 <580c3b12069246506736dd829725feb500397f15.1742364593.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB6530:EE_
x-ms-office365-filtering-correlation-id: 15a78e00-612b-4210-d275-08dd67a73b01
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MTNzdGVGZVpmR3hrelNVdHFjaUdBaEFDcWNsdkkrVk1EYlpCTVFQRzlBVE9S?=
 =?utf-8?B?bnBYTm9ma0w4bTJqVENKaGVLNjhvdWtVMStiTjJ1bnJNbC94d0Y2ZFd1dGdF?=
 =?utf-8?B?RXRhUEJzMy9OcU90a3BKMGV3SGdyMzl3dWYvWmdiK3FLMDdTek5tZk5zRHhC?=
 =?utf-8?B?WEpXcVY0cXIvNktNN0I5cXdraXhFVUs0Z3YxT1ZTb0Y2SkhOdFVRaE1ldUVi?=
 =?utf-8?B?YUFQQ0JDOTBlWEMzcHBPUVgvdkk1ek9UUU9zSUUxdVVzcjl6UEhMdHczSnFB?=
 =?utf-8?B?WGFITmRkR0c4Q3NHNzJjTmRwMDBuU05hN09OWklFUGV3dmkzUUppdnFDVVZM?=
 =?utf-8?B?Zlh3dzFiREZqZjNZNklmY2tRMnpMdmJ2bFBjNmRBcWJPaUlSSjVZVy9xTStx?=
 =?utf-8?B?czk5Y3dWWGU4WU1uQUZIa25VUVZXUHhYRkZEVHNqV2d2aENRU2lzc0lIUXNZ?=
 =?utf-8?B?UGdPMjVTanRtVzlNSWl6UHM4N2x3UWRMN2w1dWgrcXN2SlUvV0dubzBhalZ1?=
 =?utf-8?B?dkZzNW5GTlFMclU3UEJCZXh3eHVPWVVXUVRFRzZ1TzE4bldUVnNNbjlEcWxK?=
 =?utf-8?B?U1Frc2w4UHpPMnZESHdvWkd2YWUyU0I2ZW9vcmd1VmNCWE1ickU5bytpNm1t?=
 =?utf-8?B?dExYMjc4UkNLSEptdmFEZyt6L0d6bEhtbmFhTDJOUnhqeUJ1SWVLNGRlRzAz?=
 =?utf-8?B?UVorMXlUMmRObjZSbG9pSWpYSE5nZlNmRnBDZ204RjYvL0QxNUIxMGQ4ZlhB?=
 =?utf-8?B?S1lsT0Z6MGUzUW9OMHdWQjZ6eWY5YkZpSGpxbHZIOHVUcTQyQkhvMFhJMnZK?=
 =?utf-8?B?WTk0bWxvTDY3Qm1lY0NmYzhwam5iK2NKRTZiYUY0aWp5L3VlWTRHZnRHc1V6?=
 =?utf-8?B?ZHBpN1VhYWJFbjVMYUVqVGhXYmxrL2hYWXhIbFZsc202UnU0aW1Fd0FaMm1K?=
 =?utf-8?B?RVdheDZra2Q5MHprTG5ITGdxWnAzNUtFYVJOWGJBakE4OGxNZ1ZiSnJldmFL?=
 =?utf-8?B?WU8vaVNtV3RsL3FnbzFYY3BITFc4UjA3QVhZK0o0SEdEZ3pReFJLSDVrN0FR?=
 =?utf-8?B?WmNHdXMvNS9zWXF6UGFsQWdBRktScFRsSTN3d1gxbUlpMWtPRnk5eWRWUWNW?=
 =?utf-8?B?a0RNamZOdDlDSUVOdUtDc1grdnhZL0xkZ3NqTHU0VEdCZXpNZjY1Wm5kSEV4?=
 =?utf-8?B?ajZCMFd2bkNuZTJycURyd2R4S29iVGlicUxoT05DSUowdi90aHByZU9NNk93?=
 =?utf-8?B?aU50N3ZzY3FxOUZVSkVpaWNhL212K0M1Z3FNMjNabVRxeGFWWEd5RXUwdHBV?=
 =?utf-8?B?STNaNTJ6QmdGT3BNK0JTTW5MUytjeklSRTNvN01WRjJLQ0hadndXN2pSUElp?=
 =?utf-8?B?d3Y3ZS9iUy81blN0ei9pZWpXOVhIVWp6SS9BRXdkMXRQOTAzVlJMdlpqQXhq?=
 =?utf-8?B?L2tHVGwxQStJc21SRUp5NmNMNTBIV2ZCK0FMU04wNWZEcEE4Qm14dzZidGpt?=
 =?utf-8?B?R1l1bEZpQTFCZ2lLMGxES1NsRGpIam1tcStHSWlzUEswOHNlL3ptQ1QrdWhG?=
 =?utf-8?B?NWhObUJhcEdvL3NVZE1WQUttT1cxbXZNTUgrZmU1RW9KWFl3RnFrRjlYVEhJ?=
 =?utf-8?B?ZXUvZUgwSkdKRWJKU2ZHMjlGK0UxdGhOZW1pL0pETUY1aHZNTkhaQnRjRVZJ?=
 =?utf-8?B?OS85Tkw2SGNNVGlXaHFxNE82QnJjdml2U0VuVjQ5TW9LY3d5TGNUdEQvOHBj?=
 =?utf-8?B?bUpJM1hWL0o3MHpnY3JtUGc0cldyemJwTTdJSkFjLzhxb3gvM2RVNExOQS9k?=
 =?utf-8?B?dklqamFWdlZkWWVBOVFjZlY4dW5JckpFYjBOamhETERrYVpyMnB6RnlKSUZp?=
 =?utf-8?B?ZmhLTUQwSkx5MEtMbDNMTmdReE9MZmhaeVNNSmc3RkhuTlFoNG9iRk5iUDRn?=
 =?utf-8?Q?k/gihiHrPtAnHTtmE8ttEqU3r46iTMMQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UitocVVBVys3cnhrOU8xZTdJeVFtTDQ4TmhVTXNpam9RTnBFaTNiRjVXRTFT?=
 =?utf-8?B?akc2bDRiUWdLempsZUhmaUJVOS8xTUM4TnEva1NRR2t5OVVUUDJYS2ZkRmFE?=
 =?utf-8?B?U0ZIcFZpb0paVW5Fd0dvU25QRWpVT0U4U2k4Q3dleWp4VHBmKzY5Q1h2UThI?=
 =?utf-8?B?L1dqQU5HM1dSNG40UnIvMElweFNJMS9lbFczbXVKNGd6MDdCNkpZYU50R3I3?=
 =?utf-8?B?T0pFcE50UmRCY3ZOWmVhYzJMOUNQR0l0MlZBZmE5cDFoUXVDMk5kS2pkcmRX?=
 =?utf-8?B?aFR5T1dsNWJkKzFmOTI5ZkNLQUFmU1ZxTm9Ea0RNS1o1dFd5OVJZZ2JKcHZu?=
 =?utf-8?B?ei9nZHBFWmd5bG5TeXZwOU5lYkp5cmZleXV2VlQwYmk4VnFRdFZDMVYvSU5t?=
 =?utf-8?B?RWFVV3pDWUZwZmlXZWNQQlFFbXBXOHhkWWdMemJxdWgwUUJwN1U2WmNoMk1h?=
 =?utf-8?B?NW5peng0MnZJaFg1Y0UxdUswSW8xU3RrK001TkdRcklrTmtUYU8rSmRaT1Ur?=
 =?utf-8?B?SXJqWHNNanV1b3BkdTRoTTMwRDJWN2VQRGhaV1diRXVMZmV0d3hnQlNXYTcz?=
 =?utf-8?B?T2laRzNYWDdLdmhLN2xhZU5LZnVVdnE0cWZVREtsMk1WSmdDc1lRQnA0LzE0?=
 =?utf-8?B?Y1NSZ3pjMWxkYUU4c3ZBNXVpd3ZRZ2JHZ05WQUplc1U4TG5mMi9rVFhjQUQ4?=
 =?utf-8?B?aUtWNWwzNGlSSjgrMHo3bWdBT3kyUnVabldNeE9GcExjdHpVeFczd1NYUFRH?=
 =?utf-8?B?OXFpcFo3UXhrTHBJYnYvMlo0cEhWTnB2Uk5abEVWNENuNUlWVUxlck1rTHFG?=
 =?utf-8?B?UnV1My9HTGFQN1JiOXJSQS90TTBWUlpyWm1mNThiTEgwTzAyZjJkTWxyZDBO?=
 =?utf-8?B?RUVtWXBRN25PWnNQVWZaSnJsWFBTcmwya2NaYmtEVWpSbzQ5RnJoL0R5a01C?=
 =?utf-8?B?MG5Qa3JuSHhVWG1PMjhQMnR4aEpwUlpGbSsvcjRWK2R6d1RKR0M3TURZcDJV?=
 =?utf-8?B?ZEZENVlkTW04Z284cEFhNnhrL3Mzd0sxS2hnMHRoWEFma2hweUtZSmVJMjN3?=
 =?utf-8?B?ekw0Qmt0T0dHOHR6eVNBeGszQnEwU1N6Z29tNnJNOXVKK1JHeTVWMHBtbjVt?=
 =?utf-8?B?SjBjcDFUUXNzcWdHZEROQ1BpK2syRCtheHRFNE1XMVkrWHpTbEtES3phbWFZ?=
 =?utf-8?B?QWZNaTgvczlNRzZBUG56Z3VVYStnQ0F6a0lTNnB1UElBZU1PcEd4b25pb0pH?=
 =?utf-8?B?MkZoMWZQcEp5SVJFeDJwaTlBZ09oQmR3bmw2MEhUWlp0UWJKZnhHZjF1VnF4?=
 =?utf-8?B?ZmNSQVVMak0xN214YVdFNGNwWHB5OGF5Q1RSUnY3RmtKTnVHcnQ1c3ZuREpy?=
 =?utf-8?B?d3h3cXpIK0E5MlM1MFljOW1CK2JlNm9vTUx2L0ViSTlHbzVQbEhPbFZGZXVk?=
 =?utf-8?B?Q2FuVENpNzlwZGZWeDNMU3hpS1NQM1JRTHh5VHhVZy9hMjVPQ3VOclhYU1RS?=
 =?utf-8?B?TFZEK250c0owN1ZQSVRqcTVlSE5KOXFpVWtQTnQ3U2VtejgyZEdwM3lqcGUr?=
 =?utf-8?B?WTFZYkgrMnBTOWJwYnBVU3RHNWszK3NHbWpLTXE1VVpUYWRoWENleVBDZlYr?=
 =?utf-8?B?Rjc4N2xjYWg1VHhNOVZtc1ZtMEhCaUFNSTVGbGVwKzZCcmNYL0hnT1R2ZFFp?=
 =?utf-8?B?UkJLL1kvbmFTSnRUbjFESUcwanRhN1RNeVpXYnR6TnlrL3ZOL0Q3UkpqeWxs?=
 =?utf-8?B?WEtQUTBYc3R4bWRvK1hFanlNeXoxMHEyaUZzNUFUa1M3RGlWblJMVWRsRUd6?=
 =?utf-8?B?UlRsVVpic1NqeEVFRGgxc2hhNUtBWXdVWVJXMkdibVpOK0ZueEtWUlB2STFQ?=
 =?utf-8?B?OXdBcWh2QkZ2Ty9Cc1hOVlM5SUM5OHpIMDlhbFl1eklpVVhDRnZIck5jNXhj?=
 =?utf-8?B?cGcwdGFwZ1FCeG5obUlkRlg2ekJiYWc1NDZHM1ZiK3luNVRHYkF3RW9Sd3A0?=
 =?utf-8?B?YTF6WDB1L0M1b20zNEZqODBXcHMvMmlCUXRMbHQ5dVpDOThKekRTTmpsdHRo?=
 =?utf-8?B?TWlzZ3NuWGNsb1NPRm0zejZCRElXYXEwTlZlaEl6QXVsM002S3lDMzFKYlJJ?=
 =?utf-8?B?K3hzYkMzblM4cTVNTFJ1STlaeVM5ZEtUVGJYSzRUb1dlQTIyMVd5aWZXNkgx?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73AC2BA0A45C6E42887D075FE40FB73D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YEJ4nEAeIIOnPoViH+MYUsJj4QpMLCsPysHbq57EdQz8+5bCuJa94OabXvNlwnIryUcfFU+lq88IzUO1/85hXhdj19cb7uVZpCtR3aE8Hup3ziDnhgvyMnKAexiuIoUVHKNyA6qmxfJQp0NMpNK94jPVxkRmvt/NzJJg8ZKkXZtBNIMdPvD8Vu55LICnzWr93AA5juoJ5E6NPjqtTstbOq1qhMHa03wWkqL3SPBwp+Lw0Ef5Y7xf1OX8mAeZbOOuvtQfCLKrvQjWVf9znRGeHtEQlGYqB9qKb4RWOEqogyP5OWyVaZchLaDzvGxThZsdDjWGcsphQ/9C8m/UuTlHnvARc6LiIJKrCIo5+leFGdYvUUgDzPSfL6SSGqId1E4hF94tswEUxorgMLrPwoflxhvUvaYgCMg3yDgR9VdxLW97CMbg87Cn6ApuIVmXDBSOLa+5n3CJNxvuWCXxh5gHZldkUFxy27oSQ8G8QuIOkyR0B/rkP7nSfBGle4jaiTunmaJLHHWV0qN11jenk7VnICN8L8yC0hocDmBKb1rw89S25ghzRE8CAHdLsHlkXnp9jmBY78I9P8NtdJMuRTE2l6EHwfERJad979ZzPaKDw3mo6eL07tqY9sF3ckn7g9rL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a78e00-612b-4210-d275-08dd67a73b01
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 12:03:30.3201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bYPUF4jp3+dY4aixqTUqy2wm1H5VxtjxeJNuG3K3IKLoGJuF0iUYbxzx8ZmGI90PzZu6pXYeuc8LaFywiUThV2rbl+mLoO28kv5qr3b1UNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6530

VGhpcyBpcyBtaXNzaW5nIHlvdSBTLWINCg0KT3RoZXIgdGhhbiB0aGF0LA0KUmVpdmV3ZWQtYnk6
IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=

