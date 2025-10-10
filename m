Return-Path: <linux-btrfs+bounces-17607-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C99E8BCBC9A
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 08:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1FB3A84BB
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 06:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C0422A4F1;
	Fri, 10 Oct 2025 06:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K8DzAgO8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="K/R6YB8P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A27219C540
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 06:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760077830; cv=fail; b=k/SqcvvqxajmiDna30GU2ianQg7JDQWhL3F3cJUTydQxiW5ykiwdqKLn+g1dYiZNnqfaKmhjHHdDcSPZLSSDU8kSPASWWwt5jX5ZVpce+yGraJ9uD98B8JdYW7KGwwJRVkDoZ5iH6VpjMCfvrwGwl+iLw6ZKgHvCKDzY6m7wqNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760077830; c=relaxed/simple;
	bh=zcqiZF6W30JsMqgn/sCE6+xin+emFEghPrWBTAw5WYM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p//iFDuzvDjWf/lPDBrtTAZGQvsTXgQqZU73BAzH1b0skSBdnVpXJ3P7bh81ZwHAdPcew1ETXpRrU3GwUhZ3vW0mv8Nk4oq6Ldp+5lqFQAEPD1VEWMJSKvROUWxXSVVWSd72qreRkwMzMYlpXyF+9c3I5XeC9H4/ZfhJVqos6DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=K8DzAgO8; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=K/R6YB8P; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760077828; x=1791613828;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=zcqiZF6W30JsMqgn/sCE6+xin+emFEghPrWBTAw5WYM=;
  b=K8DzAgO8XbGZfQsz0zijnjzHA/bohdnZpCFN4l9V3UczY9AXA8DyM9/k
   5WFwULUshr87ss+7n0il2Swpi2wLsVtJRl36NiMNoAX4e9as7UF73t8S1
   uoBik/qei2Wq8U0XTKxZRnNW2gckqtDpqOVZMRUY3suPPDoRi+nHg3V4E
   PvLex+ElWQV1D6p4IitPd8a6RWKCJ00WlmiAI9eY4cLXP1QOhHVPydPrh
   lApc9HWsEaFRzHnHCd8CBunxaF5hxlXFftu8hY0gI89B+WqI2uarhPP4j
   6pQNkUPZiHOq+AkJ3vU9PEoDBQ+4dRnAKXw1x/HO5Kiymmh1bUGwrBraL
   g==;
X-CSE-ConnectionGUID: HSCZMzmRQx2mhygwifaMrA==
X-CSE-MsgGUID: EqL85FpPR6mFqanQfDi2Dg==
X-IronPort-AV: E=Sophos;i="6.19,218,1754928000"; 
   d="scan'208";a="129981308"
Received: from mail-westcentralusazon11010032.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.32])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2025 14:30:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCLJYmjwIWiQPVg3nXo4qOzy+mGVfZXZl0u7XjBQM33Z3yan66uYvJk3+uMSAbOAbwmqXIoNlDf1D8sTFxZCWHFgKPH+CEPQRqJGfkXyx3D4WOINEiBNEkUqY7PE5J+Ul3sdbsF2XGGse/DbIWjObhDrdyjga1ayxJ7FvhkJslq/kdKwjFHp5DgCM2ktcdYLQ/jO5hyAJZJ2Ef233Jj7+U2/5NWpeF4LzDqpBOZbCz238W6s7GnTyMujmPaSm2Oljq0XkJaBoHgKYDYWxxwK1mXJihCr9dp8Q8UI/bmfX6D+Kfesl/auJ+vXV++vHJTLKGPNd3BVOtVthw/mguVnsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcqiZF6W30JsMqgn/sCE6+xin+emFEghPrWBTAw5WYM=;
 b=pvT7HRdSEiA9jyBrd35TAK7TALPwcYikDDCJcm9uJTA1HS2QYfOlu+sL69J/GpJ7q0r1ut7Un8rJkqBRqiWSh0ABtiCt1Bh08QXbXRmzpLUlncZCVKEXcKhkel5lLsloBkiW3Z0pVDoX+m6PB55Aj0x7CLo81mxcZDbJ6aJ7GxfWRXxoMe1HsC2BWG+9NTn/3SCPcU6pes0Ug5OaMHQM3C3+kRY+Rg3xT0vj6pzLicxKxuTpbSXHcSdDjF3KlKvBzZy2amWnMRgI2eOzQ/XUecY/ixDFI/epF5ACNKz4L1+kw6uzCOUGA2krcQ/uQzfiBUG8NFTYdWqsYKuTEFF1Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcqiZF6W30JsMqgn/sCE6+xin+emFEghPrWBTAw5WYM=;
 b=K/R6YB8Pww+I04pUee9/jfA/CQCioYLHMd5EcJxSiKIG3YFmIZdobrfnF42dxqHPDLKLki6ATj1z0pzuDUncQMjCZ9qeBOCTWMlocKZVjWQiFe6mCjAmGJG6CgpNFzXzN8YoDfKLKO1bAzwUlVtm9+bAZV1S4PuYJaI2XQDT9KA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8609.namprd04.prod.outlook.com (2603:10b6:510:240::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 06:30:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 06:30:19 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v6 1/5] btrfs: introduce a new fs state,
 EMERGENCY_SHUTDOWN
Thread-Topic: [PATCH v6 1/5] btrfs: introduce a new fs state,
 EMERGENCY_SHUTDOWN
Thread-Index: AQHcOaLfSH1jwZblAUSjXLcRN14KJLS662sA
Date: Fri, 10 Oct 2025 06:30:19 +0000
Message-ID: <a30388d6-26c9-43cb-a222-13745cca30a9@wdc.com>
References: <cover.1760069261.git.wqu@suse.com>
 <38d32b204adb73c36ab00d03dd8fcf7d372a4df6.1760069261.git.wqu@suse.com>
In-Reply-To:
 <38d32b204adb73c36ab00d03dd8fcf7d372a4df6.1760069261.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8609:EE_
x-ms-office365-filtering-correlation-id: 01cefc44-e263-4682-0406-08de07c67b84
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eEN4YTgva0FWU1NvdHYxYlZpOUxLNlZxNGxCYlJodmxHS250WUlocC9pUjVF?=
 =?utf-8?B?d1Q2eFJvRHhzWTRtaVBDMnR1N1llbk9TV2dOQ0g0c2tneHltWEkrUnl1dUdl?=
 =?utf-8?B?amtiNlF2eVlNbWRleVE3ZkVQRU9tQTAraFV3cnAwVVovZE9qU1U5NnZENHhN?=
 =?utf-8?B?UStRMllZWGowcDRnMjZPb0hJWURpREhqaDZ4M1dqRjFSOGRGOFEvcEQzU1RW?=
 =?utf-8?B?cXZtUXRiNXo1cEJEeTZQYnFsOEwxeEVDY1ZxN2VjUmxxTlBzeVZUVHZDcTQ1?=
 =?utf-8?B?ak9URlhqTzRWNDhoeWNCbmVnRGlvMVBUQ0FiWm95M2RPK3NUanVseWxMdDVt?=
 =?utf-8?B?ZEFzZ0RLNnFhL0RZa2VIZ0psWDIySCtkb0JWUHlsMFErMDdmdDdwc1FHRHUz?=
 =?utf-8?B?SlpPTlF2NVlSWUtEbTErWG9UdVFWZmdJT3lMLzhUV3JDT0pLRUFweTFHY0xQ?=
 =?utf-8?B?cEZOTm95NXdtOHMvd1A1Z1IzTDYvc1FudzBJSzRWbHM2d01KaFcvSDJURFNE?=
 =?utf-8?B?cXk1dVBzU3k0ZlI1WnNqSEFQb3BnRkhwN1Y3ZVBZZlA2QVhUZG82cndQckhn?=
 =?utf-8?B?K00rWnJVT1JYWEx5ZVord2tscER3WUxaZVJYTGtueENlbU02UjAveW5PT2h0?=
 =?utf-8?B?bTFzQVY4bEhRSVBFdHpxWW1VRVcrZ1VwL1I2eXptd2FjcEczYVVEV0cyeTh6?=
 =?utf-8?B?M2VSNXNoa1BBMUw1NGdaMmY4KytCUFdOTjViZ05iUWVBZDIyZWxUbSs0dEwr?=
 =?utf-8?B?K3lBdklkc3l6aDNQQXYzNHloM2p1UTQvZTJSQlBTM25wWVlZRjVqZVZOUnNx?=
 =?utf-8?B?T3EvQitOWllZdGRZZHNNdnRCNENMVU9McHFCS2lvSE13Qi9pK0pxMFJxQks4?=
 =?utf-8?B?OEh6NVdxMDZGT0orb1hVcGFzQXBLS0tSZk1JQ3RlZHA0cHhMdDFRbTlqbU1L?=
 =?utf-8?B?cXR3SHoveXR5YndEUjI2Y1FDd2QyRWJSTHV5T1FxZ21jVmxwcGRDY2JmVWVt?=
 =?utf-8?B?TElIQU16YkhLMWtORjMyVy94MWU2VHZDbFlkWTVpaDFzWGpnL1ZzeFFQT0J6?=
 =?utf-8?B?a0srRUNLSVFrcTFMd3dvMlhHS1NlcDNRcmlGK1k2MmczMWdFNm05b3BuK0N1?=
 =?utf-8?B?MGR3WVRocGVNRVR6bWIxZCtSV3hjQytxcXhoT1pRa2V3cmJFUHkxUC9UYVdR?=
 =?utf-8?B?cW9yQlRhbHJhVWU0MnVGaFo5Y1pJdC9RaHo5OFZkNnpuZFBCOHVSelZjekNS?=
 =?utf-8?B?Wko0OFNqU2FnYkpxaWZYUVRZL1FKUHRTbDgrVnJYQjdtcStNWTVXb1ZKVjhV?=
 =?utf-8?B?VzhoWnFhUWIrM3QzYmRrODU0UHl4RE53N0lMZmpCellPcTExWHlrZVRIbDJr?=
 =?utf-8?B?TGlrUy9jMUJXRmN4a3hkeE4zSmcvRXJQZkZ3SHF0WU5tcE5HazJPMjdGelZq?=
 =?utf-8?B?aDZub2kzazJmT242dWgzdjR2WURzeXpjbmpTMW90THdhUHdCWHkyRk5IalFT?=
 =?utf-8?B?a1ozRjJxbVczQ1pEU1o4WEhtZTcwdHRFd2NrbDRmdUFubFN1c1lIWTFEcVpW?=
 =?utf-8?B?OUg4SXZ2YUlBUzhCWDZndU5kbE0yRUpUVTR5WXpXdkJjQjR4RDhHVHBJeDIz?=
 =?utf-8?B?bThJOWZOc0NaNGovWmVJNSs4Rll1ZlZseE5XdFlUekJra1EyUlJwMy9abGdt?=
 =?utf-8?B?VEwyNUQvU3kxVGNpbHpRZlJPcWZ5bEU1VWhxYzhQS2dJeDZUaDhLV2s1R09a?=
 =?utf-8?B?SDFCcnNZdkZuRmZqOUlYSWRvb0U0TVkwMDdmeUVhelZCNk83YlJJc29oOGF1?=
 =?utf-8?B?THgvdWV4YkhSZTNwN2R5Sjk4dk5yN0FxMDhwelliZ0x6cHVVQytTcTM2Ulpv?=
 =?utf-8?B?VnRnaytWMVI2ZUd5eG5lTlBsRURla014S0w4QVk0WFpDNElCU3lTOTA3WHBG?=
 =?utf-8?B?SUV6K3lIbFdZQmVtZXJKYVJIQVFpL2xkcUUwS1pvRFVpbXB6K0dleVB6bDdX?=
 =?utf-8?B?Sms1Zlh1eHZGbjZGNC9TZ0ZpaXhYOWRWdmR4dUhWR3BpY1orU0FJZ1RqSTNY?=
 =?utf-8?Q?rjotsr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTFhY21ERFowUGhJWk1KS3FoY1BkbnVqMkJoc1lpaWNHOGlxOXl3elVMeDJv?=
 =?utf-8?B?WEVFT2JvajNiQWtOWmlkYkJialBuTFByWEs5dFpFUDYwdjJodlgyanBYd0NT?=
 =?utf-8?B?THlhU3JLSTZFSEtwUWdUYzVCOGpxVk0wMWpwbXliei9LZnplaGh5VUNHOUV3?=
 =?utf-8?B?VjVhYkRwcmNMaldDUWhZcjZFZHBKL245VXF5SXQ5ZXMwUDBBcDlzeTBBdTlP?=
 =?utf-8?B?T3gyN1NuNzBaNTZzZitZandHQ2dqWEJyQ2NQR3lrb1pNQXJJZkd6TlJDVVQ1?=
 =?utf-8?B?L0I1eUNVNlVoZnpFZkVHbC9IQlZSZkFmN01ZTkFQd0NHdHZzampneVJnN1hK?=
 =?utf-8?B?TEoxQzl6THdOMllhVk5sdzJGbHVkMi9sRktwRVhhSDNwQ0ZvU0RYdjdJYzEz?=
 =?utf-8?B?L1IyamVhU0h5eVF1Tk1GZHZOajlsYU1EU2dSQXZuQ2p3WUs4QzVWYkZIdVls?=
 =?utf-8?B?NHVQSENzTHljZ0xRbjJScHRwc3EwVTFNREEwcHpzOTFoQ1RKWTBKSnBNb0Ur?=
 =?utf-8?B?RXpzeXNUbDZkUVhGKzZyRXFkeVV2WnlxbDByekU3Q294b05RUmNIeGRXaks0?=
 =?utf-8?B?YUMweUZzeENTNWJxUkZ0cXcremhtc0JFTmtaWWkyR2FjUHV2OEEvRWFWN0ll?=
 =?utf-8?B?Ky92bVhjbnpjdGRqUDNlaFIvMWh4Q2h5RlNUZVNLTStDdTVOQ1RtMUpWeGpk?=
 =?utf-8?B?TkxqTGxQck04NDBtOEtTT1kweUd0REswMGM0THJWVHFKU29rbW1vY2t0Q2xH?=
 =?utf-8?B?SzlxRllubU1WZ3gvZ2x3aGVjeksrbmRHUG1UTHY0eGI4OENsZ2VEVGFJWVhL?=
 =?utf-8?B?Sk8zUjZsZi9BanFUeWw0QzF2enZjTlBwQjAxdUJkMUZnQmZpNmRxMFBxcVU2?=
 =?utf-8?B?R2VOaTgvU3UwaXNSZFNhd0VGZHNHZmJnT2JDQ0d4RXNSdkErR2tNN2xvcjZI?=
 =?utf-8?B?TThHOGo1RWdtTUlEQkNJVHdqOW5vbGduRS8xd1IrRVRVbWR1VHhFdFpMeTBN?=
 =?utf-8?B?NDFxdXZxc2tkSHRRN2dCR3M5aEVORVhTNDNTUlN2cjFnR3RxNWttWEZ6R3Jq?=
 =?utf-8?B?dW5laTBwMjVIa3VXRHRsbnd1K2IzeFVBVEhyZ3dpcjcySTgzQk55MjFuNHU1?=
 =?utf-8?B?MFZXSXAwRitKc0crbzlBRE5sNjE1SFB4M2FUQkpMeWQrVjZwcFBlYWtkeUVJ?=
 =?utf-8?B?dXF4b0ViNHVNYmoxMDJMVGRFajlWSnlzNW0wak8ycTNBUFNtRjk4MmM4dVNV?=
 =?utf-8?B?RzRwbWpudHhMVmhWemw4Q0h2aktzY2VDa1ZKYXlPTlhQS3BsSEs0Q0JTWU1q?=
 =?utf-8?B?ZzNtdW5yaVUzcFd4OUNZdjRiS25MTTBwNDhXZUFNaEFFakJVSnZVWE1NSS9x?=
 =?utf-8?B?aDYvMVdDeCttVkpTNEFJWFZoLzMwZnFkN3hWR3cyOW43L0VCOVNDZUY4a2lJ?=
 =?utf-8?B?VWN1UUhMSVkvMGd3SHdvaHVLUGVhY3czWXJmZVZ0RytHYVpNc09iQ3dvU012?=
 =?utf-8?B?UkViYmNaYm02SGJHQmhYZW83NmdMOW5mdzN6bW9rdVpkSTFEeTMrV1FaTHhQ?=
 =?utf-8?B?UUpvTEhLOGFiWGFkak12K1lHY3hDNmxsSDRqRGxLb3lMemwrREM2M1creGpx?=
 =?utf-8?B?bldwRFVNZDkxbGVpTzlTckpkTnNpZ1JMdFBQZG9BM3Vhd2RScXlSOXNyVlVZ?=
 =?utf-8?B?RWordWxMRDdhNTNzMWRleDVWQWhZbXZ3NzE5KzFOb3V4UU1ncjR3TXRGYmEz?=
 =?utf-8?B?UTNFekRMRk9KZjA1L3NmaURWMmZiaUhPc21YWEY3b0hwRkJ2Rnc3cytnb1o5?=
 =?utf-8?B?dnlLZzNwZ1paS3JtNFpvcUphQUhielJjSGJjVHcrbW5adnlIVGd6RndLS0RS?=
 =?utf-8?B?ejV6YmdnbGhSTlVQMVpMU0pPMTI2c2ExTmFKa0t2S2dSVDhwbXo2S0owdjI3?=
 =?utf-8?B?YmZDWFVYNlhtUUozM3hpREg1ekVEa1RKNXFib1ZzakY0K0cweFFONEZXczNp?=
 =?utf-8?B?b25qV2ZvTTJXMnYrN2VpdStUK1krMXpYZFhnejNxTmoycm9ieDR1eEY0bDdS?=
 =?utf-8?B?M3F6eXhoa2RSNU9SdGVKVWxzU1BNR1RYWUs2QXJDY09mQkUzVnpLeWx3c0Fh?=
 =?utf-8?B?dDduRGNpaVhvQmZiay9RRkZqOWVCdnVSalAyZFMyV1N2am5yNGdBcWhQR1R3?=
 =?utf-8?B?NWFvdElOVlVyOWFBTXR3K3dWeVdMRGszdTBUODVpT0FXY1pSZXE3QmZ0TUpt?=
 =?utf-8?B?bFkxMFRyNGVabk1DdkFwdnBaN0pBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A81C6A9B990F445B5FEACF975093463@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vZRFtKgUpzqJOcdWOU0TcpqvhmyYq9EA8cLNw9kRjltXou5rZOWDudCT5gB5lEWQLhuj1wJBrkdCtPlGaHjAD724j1LwW+88MDy5O/9ROXbmj4foexP91Mw8B4RntabDrs3VzDOFbgUQTNRfMytTWKm6FNIdit8Ql10zKs2cSLYq/dWj/tsfq4lo5Cq29kxjAHZxbeYj1BKS8UsnY3bWiEMQQYwmf/GaSOIaJWYjHkqs28+vIYER1ygBVxI6GAVNH7oLNn464fKGGAnmtoETH2VkHknKGrvvvpJ4qzGcKUAMBxjgBpLw6WNwZ/Xw2C1ESPDJaYIMpSqGEewYkVwNdEdjv1VERN1SR7UC+Ouid95sQTD5CCh5k1omCZz7DV4bp+5OIbIzZzDlhHxMN3GwtT6meG2x250ne2KMA6E4bjjvkTg7BFHAMW3KcWciIhDD38ucQgH4O5hqJKX9Qdwdzl8Lww7ZJWlb+sgyWhWfVFCbo6UHLFbff/eXwDv8xDB8S7ZKulTInxBtsKIbyCaiPtII67ys/xcIDIjQrFVuIurpqaPqRgotfVfuBcjsiEX/bHloKWHgNZOVJ+eeIxEeWJz1845HwS/kgajlI/tLtWOZsp+GXR4NiTAZuPDJF/Xf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cefc44-e263-4682-0406-08de07c67b84
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 06:30:19.0226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TKc+T/6Vw+k2JK9Mma9RS9IWmn58MfDhLnlgKjSDIRth+QuHKkPpUwIbP0CP6ki/03gGmNINw+qDAKKK9Bu8VP3sgYM4MMWYVg4ITkv4X+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8609

T24gMTAvMTAvMjUgNzowMSBBTSwgUXUgV2VucnVvIHdyb3RlOg0KPiBUaGlzIGlzIGJ0cmZzJyBl
cXVpdmFsZW50IG9mIFhGU19JT0NfR09JTkdET1dOIG9yIEVYVDRfSU9DX1NIVVRET1dOLA0KPiBh
ZnRlciBlbnRlcmluZyB0aGUgZW1lcmdlbmN5IHNodXRkb3duIHN0YXRlLCBhbGwgb3BlcmF0aW9u
cyB3aWxsIHJldHVybg0KPiBlcnJvcnMgKC1FSU8pLCBhbmQgY2FuIG5vdCBiZSBicmluZyBiYWNr
IHRvIG5vcm1hbCBzdGF0ZSB1bnRpbCB1bm1vdW50Lg0KPg0KPiBBIG5ldyBoZWxwZXIsIGJ0cmZz
X2ZvcmNlX3NodXRkb3duKCkgaXMgaW50cm9kdWNlZCwgd2hpY2ggd2lsbDoNCj4NCj4gLSBNYXJr
IHRoZSBmcyBhcyBlcnJvcg0KPiAgICBCdXQgd2l0aG91dCBmbGlwcGluZyB0aGUgZnMgcmVhZC1v
bmx5Lg0KPiAgICBUaGlzIGlzIGEgc3BlY2lhbCBoYW5kbGluZyBmb3IgdGhlIGZ1dHVyZSBzaHV0
ZG93biBpb2N0bCwgd2hpY2ggd2lsbA0KPiAgICBmcmVlemUgdGhlIGZzIGZpcnN0LCBzZXQgdGhl
IFNIVVRET1dOIGZsYWcsIHRoYXcgdGhlIGZzLg0KPg0KPiAgICBCdXQgdGhlIHRoYXcgcGF0aCB3
aWxsIG5vIGxvbmdlciBjYWxsIHRoZSB1bmZyZWV6ZV9mcygpIGNhbGwgYmFjaw0KPiAgICBpZiB0
aGUgc3VwZXJibG9jayBpcyBhbHJlYWR5IHJlYWQtb25seS4NCj4NCj4gICAgU28gdG8gaGFuZGxl
IGZ1dHVyZSBzaHV0ZG93biBjb3JyZWN0bHksIHdlIG9ubHkgbWFyayB0aGUgZnMgYXMgZXJyb3Is
DQo+ICAgIHdpdGhvdXQgZmxpcHBpbmcgaXQgcmVhZC1vbmx5Lg0KPg0KPiAtIFNldCB0aGUgU0hV
VERPV04gZmxhZyBhbmQgb3V0cHV0IGFuIG1lc3NhZ2UNCj4NCj4gTmV3IHVzZXJzIG9mIHRob3Nl
IGludGVyZmFjZXMgd2lsbCBiZSBhZGRlZCB3aGVuIGltcGxlbWVudGluZyBzaHV0ZG93bg0KPiBp
b2N0bCBzdXBwb3J0Lg0KDQoNCkkgdGhpbmsgaXQgd291bGQgYmUgYmV0dGVyIHRvIGhhdmUgdGhl
c2UgaGVscGVycyBpbnRyb2R1Y2VkIGluIHRoZSANCnBhdGNoZXMgdGhhdCBtYWtlIHVzZSBvZiB0
aGVtLg0KDQoNCkkuZS4gYnRyZnNfaXNfc2h1dGRvd24oKSBpbiAyLzUgYW5kIHNvIG9uLg0KDQo=

