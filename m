Return-Path: <linux-btrfs+bounces-19284-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F623C7F6F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 09:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22E544E3564
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 08:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FC42F068C;
	Mon, 24 Nov 2025 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Se7gyz/i";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PoEZZj1Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A529E2EF677
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763974552; cv=fail; b=nck3oFUa6Zw793x65ipT9hB93KMgucUUCVf8HtYS4nci43uV7/R4d+1HNbAXLPvRsPZpAGVujRRwR262stlcH0EwNQ/TFDiArZNZ2qNHN1CUgUll4t5bFUFmg8J53Yi0yC77n5Dy5DeWTiFQvS4yr8NXts9SVP7SDJxU+zbIDoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763974552; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cqhsJ6tLzXY/xVhHJ/T5eCS2Z+ORd8abHCDiFmY9p+Aa6oLdnwMvb7GJILori3LCW6UqN6lX9P1hGJnSCefvq7i87b6UaRgEkPjmc1BhAZtMCdf4uyui3em0DJKWOjyMtiHFrtke7zk9Z+b1KIqOVMtJuZ/cUDYfphY/7FfNzq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Se7gyz/i; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=PoEZZj1Y; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763974550; x=1795510550;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=Se7gyz/iRSiETt4fRdoy1BDQrcmGOTeT/3O5FupyFI+er9VeMuCnu3mR
   4jvCsIEmj8iYukURa3w3beLwFQetKh91xgbcOnqhIGKCwOeEBzq7pc6ep
   nLE7MpREEJRIxMBdNTChS84J4EfNWTw/ZUplOvXjgVjTbSAm2K2t3hwYR
   Jn29CubWSunHJpc/z2n6r3rfWQad7TwYVmwVhehjqb/2COlJfcOP5Mk6Y
   Tb+oSm5FISkKxiU3pZFG66A3kRQZiMVMFtprqRkO52Am9K/AGfE3hj+q7
   pczkWeHPv9vcHIuHZKA9HM6pPk4TZCHLofitMSSbuqtM/lK6kIqxEnn2W
   w==;
X-CSE-ConnectionGUID: kP6eioCBSBq5w15PDhI9Ww==
X-CSE-MsgGUID: CnodGH/mQ6GLVUZqzCUWcg==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="132623538"
Received: from mail-westcentralusazon11013046.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.46])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 16:55:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzMJFKcSKANmb5L9eVAAq8b0hwYpVZzAOe0aFzG7spaAIfDhnpiyZR3jLMdEecnslD8OlLEu59jTYe4ce8GSLmHshcEpjPWMSlF5IwPqB7AKmx+X+dYOsMbLjLU7Jyo9RdKLYzgju00naVVgUJOyJpyYr579g4Y7z38q4li1566nHDbQ1saW8kSYzGhN6AFNqyy1MuH64634l1bvfnyR047m8EqCdX6UjFgnaUEq5HdZVffWna71p1B/rR/5ND7vqt2GZhbGudGKtzWbfvxDrVbbf4Ju5BfSOOfJ7CpCa+zcw4TiGActSCtTtM/BR+ncwMmVkjnDHSVNpxXSWfiU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=jbeAgcJPVEnL8rU79MfxsxHgcbFyfLiBef2OsgciSxWoWRml83sBP9K4CIY9i1Xn3iULZRNrHD3dKxOfHhIUe4Vh7WBiRa/Ug+DCWwNlwYOVpYmlGn/92hiErBJshAYzNtp9j4GGU1PViaRRQDn9KB4YmRZsHrSwA9XbcZgwgbvSg0dhdtg9Vl0tDvlgA2E397NiKNbLy4WdZu6r804iziU39mYMNW9mrj8BHNpHjjswz6l2QfMyVPwiQqxaivsTv8dAzzFFbh6fZbBwbaWrY4j7ajELJdscXiKFoCNdwUFGkyKa0+el3g5Lt+0Biirailrlli9BqhBx0OU2PyO/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=PoEZZj1Yi2TPBMRGdBF5nqLRaSpCmgs/GQU2TT5FaBujc8im06URZGBP0WlFvseQd/4II5Vu7Ya9+bRPSiLEvAQnVU8ahMdxSsZqC6CCQ/bJ4M81SjZdxQGKyGCyD6ZpFeZYeS9RVdtmpqDTIGk/R6luwgfQ1se2AYG4ZaDh9qs=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SJ0PR04MB7214.namprd04.prod.outlook.com (2603:10b6:a03:2a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Mon, 24 Nov
 2025 08:55:45 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 08:55:45 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Sun YangKai <sunk67188@gmail.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: update comment for visit_node_for_delete()
Thread-Topic: [PATCH] btrfs: update comment for visit_node_for_delete()
Thread-Index: AQHcXPX4GH8EvkGHwEq9kCMGX4WKirUBhlGA
Date: Mon, 24 Nov 2025 08:55:45 +0000
Message-ID: <3e172e4f-0f17-476c-a096-4a77343d2620@wdc.com>
References: <20251124035328.12253-1-sunk67188@gmail.com>
In-Reply-To: <20251124035328.12253-1-sunk67188@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SJ0PR04MB7214:EE_
x-ms-office365-filtering-correlation-id: e189170f-b479-4b88-08d9-08de2b374179
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aElTWFc0ZER0RUxTZk5vSWcwQVpLSVdPVUFVVm1KYzgybm0zWFJjK3hwd1Bi?=
 =?utf-8?B?SWE0aEluR05ISlA5bUxRTXY2NFJzbjR6SkhnVndlVjVldnNjZFJJbkdoWFB0?=
 =?utf-8?B?Rnd2UmNTK1FDTHNJbzE2cEtnbFZ1WFVWaTVzQnRrckRMK3QzQjlUVHVBclFW?=
 =?utf-8?B?MnUwSUVhN0R3NWJKbGNaUGFXcEoxSDVYNjRUT3pxZWRaQWh6aE0yTzF4N1ZZ?=
 =?utf-8?B?S0FtdUtha05JK2NvWlovREs0WldVS1ZOZitVaHBKTHJlNTliMzJBa0NBdjFt?=
 =?utf-8?B?NTBCOUR6RFFKL3NuNmdnUkdhMDlYWFdiM0xqdVIrN0pXcHBndXdCME1yTkJD?=
 =?utf-8?B?UEVBUmQxQnNHSTE1QnBHVGpzb3d0aFpjU28xUjRDOE1zWFZtS0xYTlNoRzZh?=
 =?utf-8?B?SlloZHRlMmk3cmJhWGIya09URHZiV3ZhbUx2N1p4UDVMOU5Da3pXeGdqN0FJ?=
 =?utf-8?B?QkxycWsyY3JBdVl2ME91Rm5GaGwxOWR0V2N2YlVzVmhybFN6WENwN1ZKMzNu?=
 =?utf-8?B?YnVrZ3Ztc0NuM3BQWDZlNHFoVXRaVW5sTnFMZllYS2dCRFFaSXJrUmVTR1U2?=
 =?utf-8?B?R2JEb2F4bUoxcitaV050ZkdlNXJNb2xORDgwMUJuZzRwa1BDTWNIa1g3cytP?=
 =?utf-8?B?Q2NralN0aDc1azRwbGJyRGdTOEt6bTAxZmNDenExUXJFZFdwbFczNDUwNnRh?=
 =?utf-8?B?RmdNRmNURWhXdktiQU1NNm5zaDFyUzg0ZDdsbFE5NVNYTDBTdkhyV2h5Mi9L?=
 =?utf-8?B?Z1I5ZTJZdVZ1aWt5WFo4dFlwV0syT3NoZnJjLzJsRVEzNFBEWU1MQnRCMlBo?=
 =?utf-8?B?QXJoYnNpQ1JyamZBMGNhaHFkTi9ubVhVOUhBN3NwcUpReTJQQUxkTWx5OXBu?=
 =?utf-8?B?SFhURHBjRSs3YlV0bUkxdE00VUQ3ZHUzRFRqUFhzek8reXV3N1AwbDRDaUZ0?=
 =?utf-8?B?MzJ6RHU2aWUvVjVxYkp4MjBiRXFFOUlTallwYUZxNDJkMHdwUHFNanc4UnZq?=
 =?utf-8?B?VnB5MTlqZWFrbERtcDFralBkSmE0MndGYVdiNG4vaCtrWGlRUlF0Z1o5NG1S?=
 =?utf-8?B?UUFIL2t6dHFiSmZqZUw5WUFIRDk4cGNvNVUyZnNPQlBpWFplVlFJcHNmREh3?=
 =?utf-8?B?dnVkUkQ1ZkdkTVJubmlWdm44YVg3NDNzcWZrSVRuSzZCVEVYc1F0YmxNbmdP?=
 =?utf-8?B?TktWREdxTFNuUkZyYzNtd0hBd1hrbWwybzl2RTl1bEYwMmx6MnJ3TitmZ1oz?=
 =?utf-8?B?dUZDMDFKZHhCZ2xlUUpLcDQ4TUw4ZEwranhTeENsUklPZGNDTGsyb3k1cjRk?=
 =?utf-8?B?NW0rK3hPU1cxSTJ1VWZtcXllWjYyZTUxUWo5eWxsbzJPbXh4MTA5S0UvZllF?=
 =?utf-8?B?am1iRFVYZVQxNXBiVzVBUGdQZEFVU2x4bU5RcDAxQ1pFVFFLT3hYZTRiWWJF?=
 =?utf-8?B?WlgzaE91M3dsTG5qWHB3T1VaR2tJdHdsZERxUlNVWUpNbzNVNTV4VVJBdmRp?=
 =?utf-8?B?b1lWbVpTY2hEZDFQN09XTEFqYnZlcjE0MmdhdVpsbVQxSDU3dlZVT0wrYWFX?=
 =?utf-8?B?MENKQWkyTDVnL0RpWnNPa3Mza2JvTzRpQ294RGZNL3czT0Nnd09oREVtWjA3?=
 =?utf-8?B?ZHZicnR4eW1pcUt1eE9wR1BlYWFkVGlNdmpZOVZwTWtpTWxTMEJYZ1N3MDRF?=
 =?utf-8?B?SXdqU2RSa1BhL005SnBUVklWSHBWUUh4RExGQWxmWW9PN1o4M29sRkFrT3p0?=
 =?utf-8?B?VDZZaEd1eG1YZDA3RXJEVElueDg1aXBMUXRUeVlOcmtham9BZTM4VEloNk9K?=
 =?utf-8?B?TjB3MWlHaEtZcDl5dzI4Y2gyWUo3TlBBb3F5QWVIc1ppNjJLMnJybFE2Q0ov?=
 =?utf-8?B?OTNITnJjck9NU3RVWTJFeERNL21YRFNPdHYvWG9YYkpGWkJiL0w0N0U3czNs?=
 =?utf-8?B?REJVbjFGc3FwU1hNb0MvWnRuZWlGM1ord2tXNDVWSmxJc01PbFBsQUo3K0tl?=
 =?utf-8?B?NGNvdkNDU3ppWWdHc3RHTWh3L2ZuZTFGRzNGb1NSU0N6RXNjb0YwbGFSYXBM?=
 =?utf-8?Q?wPW7OK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmpXQk9VcHg5THhoWTc1ZzRwNzhwNVVTZTZMTjV2YSt0RTVJMDFQeVBoL1pm?=
 =?utf-8?B?bU5GcXRxd3pHMTZ1MVhvczFkNWdadGRrMFVGUkUwK0srWGs1RDZoamxzMzdP?=
 =?utf-8?B?MysvMCtPNy9aQXAzVDVCNVN4U1hRcVhBcDJKWldTc1NVNGlqOVZQYkJXUmI5?=
 =?utf-8?B?clRFc21uUjlvdWlWelFhbUxJZlZ0cXAyUHlET0o0WDc1QkhuUzFyRXN4S2tU?=
 =?utf-8?B?ZHE4ZG5jdTM2UVFqbGNkUXBTZnpCNEdxaXlmZ2pqZ2JRR0lPNXBFRWZWVFND?=
 =?utf-8?B?WnFTdlF2cUZTM1VzRWZTVzNNUXNqUkJGd0V0SXZlRitVOHZPQXFkMGFNWndV?=
 =?utf-8?B?SUlKeVpDNVd1UFRIZ3FhSTRQS3NyNHQ3SmROMmh2MGVCK0hiTHdYemkxU1k2?=
 =?utf-8?B?MklsNjlqRDFYOHN2VWt2Z2x0Yml4Ti9QM0ZIRDEzOHV2VUZad2RZei9qcVd4?=
 =?utf-8?B?RkJ2R004Q3Nib3BFTWc0L0tJakJkWFFpU1d4N1M4bnBYdkJhZ3oyWndjTUQ5?=
 =?utf-8?B?V3RjZU4rbTdhS0w3NTl0V2preTBha291T0hhQXlxNmxMM2lhNlp4NlNUQmFQ?=
 =?utf-8?B?S1FNMWVtakZZQzJBdnQ0WWk2TEM5ZDJ2WDJxSi9Id2ZRZGM2Y3FkRjY5MTZZ?=
 =?utf-8?B?ZkhwVE9lbzdCMmRGUm1DeTRpT2hjNjBMU1VZdDdkVWZ0V2Y4dlVoejl6cVdG?=
 =?utf-8?B?ZExjVUtoQ1JjVFJoOHBZYWZSZXpuWmRzOHZub200ejY3L2FFc1pVaWo5ZzVQ?=
 =?utf-8?B?VUxldE5uK05TQ0hQWmFDUzQ2QjNEZ2tHaE1aUFR4NXBmVmx1cW5mOTJmZUdJ?=
 =?utf-8?B?cUEzSFJBbndzN2RUYy9TUTYzSEI2L1JicjV5NGEwL2lXVXdZOFlPRldkMWxr?=
 =?utf-8?B?S0swdkcyb1lTaUpBME5KaWZMTnI1VU9zclZxRUdKbkpaVHdUd1pVcGZUKzdI?=
 =?utf-8?B?ZW10eTVPdXpMWTVIU1c3VkdYSHluWHo5MkQ0K0tEQS8rWmFScmpzd0dlV0NJ?=
 =?utf-8?B?Q3pKNTM1MStTOGlMUDZndm5oOFFVWFRTWTY2dUtuVWhDNHQ0QlFWRUM4TXdv?=
 =?utf-8?B?OFVLQithL1lmTVNBbjllYzRmbk5RVXZ6WHZBOHJXNkFUcHJ2THBDMytmNWRr?=
 =?utf-8?B?U1VKd04vSEN4TVcyekU3anN3cDJraWJzamZ3Z2V2bjZpVUZtcHhYbXVLczZp?=
 =?utf-8?B?VFV0MU9aR2RuMlZUdTRqOVM3YkxmV0h1anhyeC96ZW9QbjhVL1lWT0luNVc0?=
 =?utf-8?B?aGZDR2x1eEJTZHZUQklmbWdJaC9OVDg4cE0zTzR0S1lCVmhva1Q4dCt6VEJI?=
 =?utf-8?B?WTl0SVJCM0FRRTJsdlFwVFJFajlUZWQwYXRISDEvdzhlUU9MZGtqeWxHZUJT?=
 =?utf-8?B?SXlUWDR1bktFOGgrTXNBUzBWd0YwMlZHMzBxbXcvNDIrRkVtQUZXRVVlRFhw?=
 =?utf-8?B?bHFNem9QYnRnU3hpczJVNDJuMWl3KzVWUGFKUmNpWUVhUUMySWVFZEozM0tl?=
 =?utf-8?B?MVFCVmdnNG50MUJtZzlJNG0vbEVKNVVIdEdWNEpjMDBjNzhkbXRDanBvdEht?=
 =?utf-8?B?Tk5VKzVDbzh6eVR1eDkvSkIxN1VBL0h1eWpRaWM4K0ZzOEN0S1VrTEpwUGdQ?=
 =?utf-8?B?WnFIRDJtYStrQjRNQW1uK2hoSVk4TXFQN3o5OGptY095VXRJOFBJRlVNMnli?=
 =?utf-8?B?WjBNa1lvdk9VamN1NVFkNFUzLzVBOXpNVWtKSk83MjErc3JVSTRNbStKVUQx?=
 =?utf-8?B?R0N2SnB1TDdUcklvbmtGSUIwUzFzVUluN0Y0anUxV1duVlYrSWd5N01wdFBT?=
 =?utf-8?B?a2tKa3ZTZEoveHM5K3ZuRnltWFBjUE5zbUFYUElMSWl2aDhDY01FTWxPYUlZ?=
 =?utf-8?B?VTRLYlY4aG1HK2MvUXVBOVJ6R1JaclVHUG1yU0VmckVJZ0I3bUZuNzNaakd3?=
 =?utf-8?B?Z2puOVZZMThsSmdibUhrSTE3VERFSURsNlMrSGZVcWRCWHd4eWVIWE8yV1pn?=
 =?utf-8?B?MjNZTHBkTG5XWDZyM09vZjhiTCtESWJ0TlQ1aU5KN1FyKzFMR1dJT0NiV00z?=
 =?utf-8?B?QUNQRndEc3FzRDEwTjBjV2NVRmM2dGwrRitCYkkrTWY4OHRhM3RrcnZQeUJN?=
 =?utf-8?B?YStYeWJHc0sybUhXU2xhK1ZMaGNmR1Z3VE5TeVR4MXlnTlEwRlJ5ejJ2UWta?=
 =?utf-8?B?Y01YNksyNTZQVUlwRlZCWEc1SlRNeHFzcDFoc25JS0tNaEUrclJiSGwra21v?=
 =?utf-8?B?WDR2S29DQW82d1MvL2NLM21IUU9nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03A40B9D702BF64796C891EF927B06D2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PkloISs1f8earhP+0YFFOQG/HWnb6C8hrExn9k5Iue0Bh/QK6Ctjbl3Hq99Os7fSy0as7bYvrLcISjaJUXLWFdeO/vXsKnvu6iVFdkXtVnhoFcfDP7AF1TBkf/rBHt7mw83uuJW8d0uOiiUo1y+E7ttHPHaV3LBpS18/Wp7P/Yhj66UHWfxRGx8xoYquTZD/7BI9fS3eD3z2qQvwEXV7KYBiB/4E7sfQfiUPEJ7PM9c29FL+b6f9L0760uDJHJO9fp/YzVg3gIcp60XQX8RFv3PfVWvZNSMC5IW04CawaPgo6pwutV5/98u5lgXoNKZLFZeW4zmVK9xy/0gC52DShPm4sb9tiYFt5IVl/v0gykpT+JBTva/bN3Be50XXm5ufRtH3jYh74BdUgVuc9OZLYdXQz8M4umqAtSp7Pf5bQE6dVarLELwefBNTWGXzlK3STyVzm8uMByulMhZF+nS0zV0FR0SMw7V0839H47BLFr8W/AOjXjN/RdaeLBBz6W2wxHD/FZRBrZSMeO+BFIP1VLzg+GfJ3TmLJVeJu9S7b9Lh4XUcZTnBayLaHcskkAbmmbxoFUuTwJlnSaXfHshLyXa8uoxSt4SEn9hpcwkqqSAJLuztDq6ezmKwZZWJXQuu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e189170f-b479-4b88-08d9-08de2b374179
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 08:55:45.4282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kedGuCKRC1/nn1rV84U9cI4gkJFMUInQDiF1ul5b0xJGPZe1Fzq9P8pJmHCBf6BYq0or6SNZ4hjZPtyrEm7WQUEFdawd+wC2R9bpN+LVMV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7214

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

