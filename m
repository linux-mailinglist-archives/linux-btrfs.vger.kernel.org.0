Return-Path: <linux-btrfs+bounces-10845-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE835A077F3
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 14:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D231518824A3
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 13:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2552480B;
	Thu,  9 Jan 2025 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jrxRrtZ3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Fr4vW91m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA48218AC1
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430102; cv=fail; b=AF518mMx4YIenikglvdowVYm5kv2fkmfRDcPc5Auq6wGTpmP+guxe4xvNq8sw1zL3aK3ac1zZJgB1/Vp4rqsX7iy5r+qVKpiZyBbf/aPCqMx740p3tTiaU27NElcmnQuGOlnIeMrkAUGlQgO1A31EG/LxWsN0z1a2XOdY8Rq1Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430102; c=relaxed/simple;
	bh=pjGF5d/Tv+kg6bV8nC5D91i6DyCR0by+HYYRlcpAyT8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S6DBcIGFH6uQVQhW+BJvdy0YKXmTFh+jRjmWcAXcEfVInP7dwfUe0OsMsqO/xttNKz3l3Tr52Q0tR5uAThOtlrZst6mKq58S+Jx14uJNW6sIAF95QAsCHQwIW209RzPyfaoM9syWStYHYO9iA8qyN2oPPvD03sVlwBNV7SguISU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jrxRrtZ3; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Fr4vW91m; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736430100; x=1767966100;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=pjGF5d/Tv+kg6bV8nC5D91i6DyCR0by+HYYRlcpAyT8=;
  b=jrxRrtZ3AadnK/35Tv+h9gvYyczaPOEGRUbXdoXFqWV8utxHYa+muYvO
   SiEwAJykMrpr0uLktIBlshp6dHi7J9gIamGDbnLr5YA/utzJlnJaVK5jX
   LITnhYtXGIllWgZHZOyTiZix3hnVmmxJ4KqiuAxhuSoJTO8ANU9WVyRP4
   1mmWCVu8ov0gbjvnlSV3+/QlnEDajZnhrZR65+/FwVqpCWVNptmCz+hRB
   Y4dsJeew0N8rIez+J+MgesfWxePXPUW8OJEGZgxcLeVE0nAUgaYaOx0VB
   DJODWKIzOyLe8Jop9A8If7HHtPyRTnTACLaKK+300xAUHdEstcfbbEzgd
   w==;
X-CSE-ConnectionGUID: NxttWIuHQ1KJLCso33n4iQ==
X-CSE-MsgGUID: qawLEKyLTE6CIIJ0+in4VA==
X-IronPort-AV: E=Sophos;i="6.12,301,1728921600"; 
   d="scan'208";a="36599218"
Received: from mail-westusazlp17010001.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.1])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2025 21:41:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5+MPw+AQwny1UiuO173KbzgCFjd0CiRdBqT39O69NboHV2sh2FvqsdiMWTWGeD2Pia04tv488BIWUKtZxN5KcDJKC6ek5vSi0Z5zk4eeYClToRnoYFB363WydTzyY51WuinZJsm1BCh8UN+mk6cBAufv9wl/Y68lOrsUshG7Gesx+91ZADHSz8VaLTzs1TyWDQ65aD/rI0h3QZ7lEc/VHnPZAsgYdTvMTvCpWC2Tne9gd7XvwQ9reMn1V47/HqtRfHDCCwGL6cYDqG16AmgzCcPhWzMAItCMYs0YlHfiuE52RpQ6VCNX0nQq4ft3Yxo1ZgULvsODw3fzVclNCJFfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjGF5d/Tv+kg6bV8nC5D91i6DyCR0by+HYYRlcpAyT8=;
 b=ZOgxkZ7Fpgetw9fdGqmaFMVcDGZE/R4MjS8D72J1yp210Gd0HleVZcQ15dULWWPyDsLtTHInk/WAmvKpFaiDleD6byry2XmnCBGahsK8rK1pUiQf20E9C6NNsu2me00/8+/kqBmoLMzE2BVMc81TGQPnbyfpaS7c5FkNWSBDFLxWbB3waqregme3Rxbxv7DXH034kwr1btPd7BTOgTdGKTC1hmhvXzLX+U7ejymmYE2xmPqjJrirOzHz4yAUPFqPMkhOOG1Kj4iTFLM+R9Ym8/hIOEK+VsAXhrwSgj4asnrnEGKXOFHkkdEnI9WBle8MAUbaPvYGkMF3N97fhPIzyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjGF5d/Tv+kg6bV8nC5D91i6DyCR0by+HYYRlcpAyT8=;
 b=Fr4vW91mdsjo6IUf0cZUp9Y4tYaidH6yVKWhmHF5Ph8YScs6Hv1OiUSolBI737AMrSyGQxOye0u2qR67iKj01tKJaLDEykg98kSgUBu2ISsjR7AP/zI1SwmYQicjSt9v3LbjEv29D/Gl7T//X8maXoR6lKZJfcgJZMCM6dk8BdI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6893.namprd04.prod.outlook.com (2603:10b6:208:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 13:41:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8293.020; Thu, 9 Jan 2025
 13:41:37 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/18] Random cleanups for 6.14
Thread-Topic: [PATCH 00/18] Random cleanups for 6.14
Thread-Index: AQHbYoD+hC5OdlYE3EaNGwU5cWNRqrMOc2aA
Date: Thu, 9 Jan 2025 13:41:37 +0000
Message-ID: <fcef9a5c-1fb4-4639-9a81-6a8f870dff46@wdc.com>
References: <cover.1736418116.git.dsterba@suse.com>
In-Reply-To: <cover.1736418116.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6893:EE_
x-ms-office365-filtering-correlation-id: 35866361-29a3-4415-ee96-08dd30b3572a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cmc2aW9aWEM1aXFCWjEyS2JwRENVL0g4OGZybkF0dkgvcTNZdmtIQ2Zad1pK?=
 =?utf-8?B?MU1nQm1sOGhXbk5GUVZxNStvQ2FMTzVZc1NQUjJoSVUxeGpXVVhQenBRWWlI?=
 =?utf-8?B?bUc2a1hSWkNRemI1QzlqeUVsMTJTT0N4SVJEdzdXU01ab2hjRkJacWJnSmUx?=
 =?utf-8?B?OFlkd0hIaGlmZkprQVpmVUcwUTB5VUVGaDMxOEUrc3dYR0EvRGpUSk1MK3dD?=
 =?utf-8?B?T2xadExHK1NWS0NYZWZjcnFDMHpnQ3hpVEZKM3k2U2hnUTJBRDZJOE5IanRs?=
 =?utf-8?B?cG5XQi9hQXlpQWVlWDBWbkpXKzg3VVg3WCt1T2cxRkpNNzZNbG1mS2ZGaU50?=
 =?utf-8?B?NkZzenh3YmNTUktjb1BpMGNFaHBMM0JrbUtOUGZBMEJkbHMyNTNmdThxVEEr?=
 =?utf-8?B?LzZ6VWprMVNlbzB5eVdyOVFTSmF3ODUzR1hoMFhGTGxuY0d3UlZwRmQzVzdZ?=
 =?utf-8?B?eVBvb05rQVZzWkpxeGpMbkkvVFJhdWlGMEtaNjlvekM5dzI4OTV2K0I3SnZU?=
 =?utf-8?B?MU1FRW1Md05FSVVDZlpCdFRmcVdQRGZGM2hmUEZDVUtTSEIrSXpGL2twSDhC?=
 =?utf-8?B?SzVXNTRqQjVtMk1Dek9OZDhOZGQ4cC9tT3I5dkdtSjlrVDFhNWtyMVE5WjN6?=
 =?utf-8?B?cTNWb2tBQXZJdWpLWjlwS2c5UWtiZlExaVhnVnpuQWNoWVBZeHdoNVgrMml1?=
 =?utf-8?B?Tktud2J0YzRYNTdlVDZTQnNlNTBidUlEQlNvOXBadW0vTFgrWWdMYnFwd2pJ?=
 =?utf-8?B?RE1OY1hRQ2I1RnNTTG9iVUplUjFqUDN4eldhRXQwcE5JSW5oSCtnUWFEZnJn?=
 =?utf-8?B?alZIRm4vSnAxVFpjUEtXdzhQNGNBYlBwU2VMTEtyNUlUaHppRTJjS3drbUll?=
 =?utf-8?B?YThqZFhseFIwSHltbUpGemFON1NoOTY5UzFOdkM0VjZ3b1BZSHNZOTFOMDh2?=
 =?utf-8?B?Y1VaaEtCZ2VGcnNxUU9FYUJHNUgwOW9DOXVGMHBzMmRIMlQ0N250ZWcvZ3Jm?=
 =?utf-8?B?RjdYQ0lkV3BhY2ltdFc5R0lzWU14MW50U3QyUnkveXgra0VKQVladDBzcDJS?=
 =?utf-8?B?QnlVaTVQZURZMWN6R21IYStUSm1lYTlZWmsyZzdGREpibFlJcHJsUjdIaUpR?=
 =?utf-8?B?ektNdnl3czFRbFRDNnlJNERkQS9haW9kYkpCV01BSzZicnQ1MUNZQ09TbWpW?=
 =?utf-8?B?K2tOT2lBTG5DeFVBUDVkVXV2eXZkTDR0N2RPZk9UMGNLRVZvcndtcXpmSHYx?=
 =?utf-8?B?OGxEVWh3NzBTcGxuWDVZZlRHVkhpVG5ack1JT0tKcVg4RVBieCtZT2FjVjJW?=
 =?utf-8?B?LzBEalFmdU9TeWJyK2FRVzRUZjNZcThuVG82ZCtnT0NxNUxienFSWWJ4Z3ox?=
 =?utf-8?B?WjN4dG14VlpGTXIvT2psLzdhR25kRmtUbWhOa2RiNHBjMHpPUmZ3aHhLbjE5?=
 =?utf-8?B?V2JzMGZQZnNkdDNQN0hDN2NkTnpwRVVFMkdvNEJVVExsQ2JGYmh2YzJRcGR6?=
 =?utf-8?B?WDdSL3A2cDFrQnNHQ0Q3cVRkK1FYejFqRFdYZWlGQWRQOVV6bW5sZVJvS3E4?=
 =?utf-8?B?VlN5NDBpV3lLMU13SkhzUmZNUXk0TU16TVNSVEFaMzNrdE9BUUJCVTQrdkFv?=
 =?utf-8?B?NlB6T3daQTV6aTgwWVcwNWp3TkdDMkhzZkNZZmcxUGd4U0VxNHNVUytpbVBR?=
 =?utf-8?B?bTNzYUxuamxVTThsZStudk41Vk5aUG1Kb3E2YTR1UzlsMi9Fc09lZCtZNGVo?=
 =?utf-8?B?U3UzY3JxVlg2dUJMTkJZRVBudWFlSUZxb3BOMTg1NnBhaVlQRUNyNUc0SXJ6?=
 =?utf-8?B?Q0YxYnY0Ty9QWDBTQjEvWGFnSHg0TkRRZ1puUm5YSXJkWTJZTmR4cENRWXZ4?=
 =?utf-8?B?aDNBSmYxSUVkQ0NweThmaldhQkJGbkNGVEVCUEIrYytvV3FpQTFWbXMyZSsr?=
 =?utf-8?Q?sUHmC0Is6zkny620D/E0oDCDcnyDyM2C?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1dCTFgvemNJSjlyYXJTWTlpcG9Wc2lCYitkR0lOYkFJRXJPam5BK1AvOThE?=
 =?utf-8?B?Z21IV0hPNmRhbHJ0UUI1d2JpUGllVWxBQ2htRDJpQ3EyWXlHd1FKVk0wSXRI?=
 =?utf-8?B?ZlZUTXVnVTdzTUtuUlI4Ujg3ZCtJNmhmWm5xOG5WRk93NndGZjFyYVRIdjhU?=
 =?utf-8?B?MkNuclZlYk5idEJGb1hvK0lCaTBsMkp4N0VQZ001YUpSQTF0RUN0UnRMaEUy?=
 =?utf-8?B?M1JlQzhlNTl1L2lUaWFETjB5K010M1JZS1FDd0t1YThYa1NRWGZEci9VQ3N1?=
 =?utf-8?B?NmExTzdTNWVDQkhPOXArZi8yQlBlNlIxN3B1UnM2eHNLR3JTQ29HdFN3UnY2?=
 =?utf-8?B?cTJUVjY0Sk9aZFVUbEFzZ0UxcDFWTDBSTnJYZ1Zkd2Nic1RNR3FLSGVlaE5D?=
 =?utf-8?B?RkJ5Wnc1TlhnLzllaWRZeHFhazFrb2ZqbnNrNUFPN1lnZk1IdiszQ3NaRHdz?=
 =?utf-8?B?b2huZitHNkg0ekI3MDJQR2pDQmk3M0lOS3lwSng1elZ1NWxmcGIvRjY1U0V3?=
 =?utf-8?B?RnpHbjF2MEg0NzIyd0FnL2g5eWVkbktsVE5FSlozcmRSc1R1SVAzUmkwKzc5?=
 =?utf-8?B?ZHJUcGRrczFscVZRVG8vQ1RBeXlhR01RcVBtYXdkZDFyU2RUWndkbkpJaFRR?=
 =?utf-8?B?U2dBV0tjbHRBdXhPVlFKanFhQ29XRWRneDJ0ZXV5TlJtaE5ScTQxNXk4MTJG?=
 =?utf-8?B?N1kxYVJJaGczZ1hvSTFVTkJyUlZJL3AwVXpjUzYyZnJqY29YTGdlQVpkV3lx?=
 =?utf-8?B?a1Y3Ry9hUzdIN2FtRWpPeHN4UmJ1L0RMWGdlUGg1SnUrdHZQWThncVhwbEEv?=
 =?utf-8?B?Rm5kcm1uMERGcWhud3JyN29NVUgwSWZQZjhvOTNwMW1ONE45TERQUVFDaDBQ?=
 =?utf-8?B?SmFHZGdXaFBBTVRpNEdnYzVqSGthL0lEUUxqcUJHa0xicEplV0hJMjg4aDh2?=
 =?utf-8?B?WSs1OFAxTWlwWnZ5dGhIL002UVhGQTY1QUNoRi9ZTHlBSC9IN1YvazB2R1E5?=
 =?utf-8?B?aE1BaHQwMzdOL1hDR2x2cm4rLzQvNnArV0dTb0FTZGh3eWpwNjVHdE9ITDdm?=
 =?utf-8?B?dWlpYmpaVkhwV1VwZVIrVW9TTlJoODBqemZsdHcrdXMrUUt1SS84cjkzSnVU?=
 =?utf-8?B?QWhYeG1jUkNScWZ5R2RyNkVUZUJEMVJpcVpUbVNsSjlMQUs1TEVLakZCZ0Ex?=
 =?utf-8?B?UEl5aTdQTHBnUzFTWXluZ0ZPM0wvVWZucThuZ1BJRURTZ0l3S0F0dnR5TE0r?=
 =?utf-8?B?U3dMVkJWQ2FsMW9HRnBnRkVCWnE4cTJVdGZ1NGNpTjB4SkJvY0dydmQ2YVly?=
 =?utf-8?B?aWVPOGw2dTVWNjVQTlBycXAvQWl6RGpCY0Vpb1MrL3Nkb3BpcVBGZFBWczNB?=
 =?utf-8?B?Nk5PbGJVUnNiTjNUTnF3R1pCQlNKU1lsekpJS3h4Y0FoOVcyaWhxOVUzSTRw?=
 =?utf-8?B?bndHOVd6N0J0azVYMk5wSm5PNFR6NnpxaTNhQXZxOGRHNjdFZ2JnS041eXFO?=
 =?utf-8?B?ZFJ3bTh4SjFzek5rbUdHMTNuZ2tUeUVhTGlEVTFVdVlXYnVpTlNpZklIVHhY?=
 =?utf-8?B?OTdvQ1psZXEweGY0QjNNOE0zaU42VFdWekpaMVBoV3RvUE4xbWM1cEowd3Rz?=
 =?utf-8?B?OU43UkN3cFBJaEg1SytoK2p3bUM2aGtiRFg0VmhwUzlITEtDdXpsNjd3eWE4?=
 =?utf-8?B?d0x6NEZnVFRSSytZVDhXNURnSlZRaHNhWDgzcEV3UU5nSmcwaW1XeFpVWS8v?=
 =?utf-8?B?QWQxS2dZajYyVEUzWnpoR0E1d1o0cUh4Y0Vmcms4THM1Um03U2w2OFZ4OW9S?=
 =?utf-8?B?MS9qZzFXc1R3dHdML2VNUjV5MmhOanRDWFJqdjZDc0F6UlQ2clBiQm1LM09J?=
 =?utf-8?B?Zk5jUG5YSnNqZ0tZcThqcmJTRlV1OFhJR1lrZGw0M2JKNUYvSjFsWUxZMzFt?=
 =?utf-8?B?dWtncTlVQVRIWnBERmErZWRjUVFoaVl2UUIyUHgrNCtxanF5U3BSU1BPdUI4?=
 =?utf-8?B?clFkTkxLQ3k2dmVKbDZHanhGOUw2ZURDZXNUZWwvZGsybHgwNlRmd2g2ZDlo?=
 =?utf-8?B?ODhCd0JJTzJxaFErSUxwcUpKVXZ4RmduT1FWcGxMTE5yaVJseDY1MHpINFA1?=
 =?utf-8?B?d0I0aXRsOFBlSk05K0lHZkVsS2ZvWGxSS2RuTE1zNDQvSERZaDNVS0ZJQzNQ?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D11C3E661BE5E43B61814C513169BBF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dcmp+3F6sfjmdza0VkJGntO/GFTbLex5nTwe56uo8qEAW/sbO8fSBmo4VBrrVvAXhFQOHE1+exrpdIkkMvK6vsH1qhtnAnVSfA7+oK3ahVklP0kYAkTEWMmts2TF7xroSnIzRS0kdV2AgnYSc+p5LUvNWbDmkahidMs8FpUTPVUg/DS1R1ICAkfkE4+lZ3s37CQW+uQR6blOlKxzFkGXrUlCSJNqoKB3epzSTmx+dhEObds32KNkU/F7kWTUCzjWgsWjm0nNpGAMkhgkzazObnzHt9peH9wuEH99HOQ6DI71p2Z9v+TAv4ZBbfa7vUes8GKKvIdBGgfzbNXgm04Rray7JrhiTzqlShAo2jDl/htGc1EmHY+qJc9QMXLtUObpRxp+U/sgjG/bcthvEaKOYUz2YKpeBPX9sRX28qy5Ki+wihKEc6/mwFB/0wtQqFijBPp1+usksDCfN+XQX+PkmL/5pPlskLKf49jtbY0IFkHnDnRixanjlWTaVOxmMscpssF8Y9idJWmD3XW90+Cn+/uG17LbBmFFo9QaBVkirgIE0Zu2Ax5goLkknWOaSoNd3zEcFw0nSVBtvWNzcvGW7qfRh9pjaDStAtL1YSjgrS+Bj3VmcZyO1N8FSELAvItb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35866361-29a3-4415-ee96-08dd30b3572a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 13:41:37.6056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D2Bjy+yxg1QdbRFObkskVbgiLgZLH1IbuTMCL+GbMuL94/q1ZnsQcfnw2NIA4Uiyje65IZUCjL8qNZ4kv8Ezfqerl5H3r+KUqn2pEjv6bZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6893

T24gMDkuMDEuMjUgMTE6MjYsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gVW5zb3J0ZWVkIHNtYWxs
IGNsZWFudXBzIGFuZCByZW5hbWVzLg0KPiANCj4gRGF2aWQgU3RlcmJhICgxOCk6DQo+ICAgIGJ0
cmZzOiBkcm9wIHVudXNlZCBwYXJhbWV0ZXIgZnNfaW5mbyB0byBidHJmc19kZWxldGVfZGVsYXll
ZF9pbnNlcnRpb25faXRlbSgpDQo+ICAgIGJ0cmZzOiByZW1vdmUgc3RyYXkgY29tbWVudCBhYm91
dCBTUkNVDQo+ICAgIGJ0cmZzOiB1c2UgU0VDVE9SX1NJWkUgZGVmaW5lcyBpbiBidHJmc19pc3N1
ZV9kaXNjYXJkKCkNCj4gICAgYnRyZnM6IHJlbmFtZSBfX3VubG9ja19mb3JfZGVsYWxsb2MoKSBh
bmQgZHJvcCB1bmRlcnNjb3Jlcw0KPiAgICBidHJmczogb3BlbiBjb2RlIHNldF9wYWdlX2V4dGVu
dF9tYXBwZWQoKQ0KPiAgICBidHJmczogcmVuYW1lIF9fZ2V0X2V4dGVudF9tYXAoKSBhbmQgcGFz
cyBidHJmc19pbm9kZQ0KPiAgICBidHJmczogdXNlIGJ0cmZzX2lub2RlIGluIGV4dGVudF93cml0
ZXBhZ2UoKQ0KPiAgICBidHJmczogbWFrZSB3YWl0X29uX2V4dGVudF9idWZmZXJfd3JpdGViYWNr
KCkgc3RhdGljIGlubGluZQ0KPiAgICBidHJmczogZHJvcCBvbmUgdGltZSB1c2VkIGxvY2FsIHZh
cmlhYmxlIGluIGVuZF9iYmlvX21ldGFfd3JpdGUoKQ0KPiAgICBidHJmczogb3BlbiBjb2RlIF9f
ZnJlZV9leHRlbnRfYnVmZmVyKCkNCj4gICAgYnRyZnM6IHJlbmFtZSBidHJmc19yZWxlYXNlX2V4
dGVudF9idWZmZXJfcGFnZXMoKSB0byBtZW50aW9uIGZvbGlvcw0KPiAgICBidHJmczogc3dpdGNo
IGdyYWJfZXh0ZW50X2J1ZmZlcigpIHRvIGZvbGlvcw0KPiAgICBidHJmczogY2hhbmdlIHJldHVy
biB0eXBlIHRvIGJvb2wgdHlwZSBvZiBjaGVja19lYl9hbGlnbm1lbnQoKQ0KPiAgICBidHJmczog
dW53cmFwIGZvbGlvIGxvY2tpbmcgaGVscGVycw0KPiAgICBidHJmczogcmVtb3ZlIHVudXNlZCBk
ZWZpbmUgV0FJVF9QQUdFX0xPQ0sgZm9yIGV4dGVudCBpbw0KPiAgICBidHJmczogc3BsaXQgd2Fp
dGluZyBmcm9tIHJlYWRfZXh0ZW50X2J1ZmZlcl9wYWdlcygpLCBkcm9wIHBhcmFtZXRlciB3YWl0
DQo+ICAgIGJ0cmZzOiByZW1vdmUgcmVkdW5kYW50IHZhcmlhYmxlcyBmcm9tIF9fcHJvY2Vzc19m
b2xpb3NfY29udGlnKCkgYW5kIGxvY2tfZGVsYWxsb2NfZm9saW9zKCkNCj4gICAgYnRyZnM6IGFz
eW5jLXRocmVhZDogcmVuYW1lIERGVF9USFJFU0hPTEQgdG8gREVGQVVMVF9USFJFU0hPTEQNCj4g
DQo+ICAgZnMvYnRyZnMvYXN5bmMtdGhyZWFkLmMgICAgIHwgICA2ICstDQo+ICAgZnMvYnRyZnMv
ZGVsYXllZC1pbm9kZS5jICAgIHwgICA1ICstDQo+ICAgZnMvYnRyZnMvZGlzay1pby5jICAgICAg
ICAgIHwgICAyICstDQo+ICAgZnMvYnRyZnMvZGlzay1pby5oICAgICAgICAgIHwgICAzIC0NCj4g
ICBmcy9idHJmcy9leHRlbnQtdHJlZS5jICAgICAgfCAgIDQgKy0NCj4gICBmcy9idHJmcy9leHRl
bnRfaW8uYyAgICAgICAgfCAxNDMgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+ICAgZnMvYnRyZnMvZXh0ZW50X2lvLmggICAgICAgIHwgIDE2ICsrLS0NCj4gICBmcy9idHJm
cy9mcmVlLXNwYWNlLWNhY2hlLmMgfCAgIDIgKy0NCj4gICBmcy9idHJmcy9yZWxvY2F0aW9uLmMg
ICAgICAgfCAgIDIgKy0NCj4gICA5IGZpbGVzIGNoYW5nZWQsIDg0IGluc2VydGlvbnMoKyksIDk5
IGRlbGV0aW9ucygtKQ0KPiANCg0KQXBhcnQgZnJvbSB0aGUgc21hbGwgbml0cGlja3MNCg0KUmV2
aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+
DQoNCmZvciB0aGUgc2VyaWVzLg0K

