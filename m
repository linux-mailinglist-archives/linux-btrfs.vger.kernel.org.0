Return-Path: <linux-btrfs+bounces-19206-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5988CC72EF2
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 09:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7822E347CE9
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 08:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F74A309F12;
	Thu, 20 Nov 2025 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AprvbwVN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bG7PYQuS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B082EACF9
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763628149; cv=fail; b=EUFh74NrJzqXTdZs0sI1E8z2hYCcAj7ZTK5ljWvgrdXZIXCZU271R0wVYWqKI/yLbqz/n+2zxCCQvZxjSwthHFyQgwX+1U8Cso4JrR1mYBi9+cEzIScms9JW39PMx0vOewdjdg84oxJTEt2HbEoYZOqgwqkby1ra87gNwEFOU5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763628149; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MPWjr9iYxSzZwO/2S3ePucOSfARy47mH8Clt/21iqfK5L2RTb+lKjpLztkUrWcqtAUwIvjTIbPjdwJrcZGJrdH9I4PCrDP/sDRu4UhpA5JljY3UJbwBdQD+CcBR7QXbA04/0HLONM7TMKyBWZd3yj/4Fr0hD4+N+/oxI+oh2KCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AprvbwVN; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bG7PYQuS; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763628147; x=1795164147;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=AprvbwVN2eQBC8kldUBpSsq3GOKoTzzGiro1Rcb2dF4RuSGeQY8b+MD5
   ZnX9kVDSUOedo/lafhWjoxsLrD9w37fWY/+E1TD7D9XQFL3jB8m6x4UW8
   P1zpURGZjMrYVAZiiEwSa35b3mySTRsriQtnApcSU81ik0E1ZiTGM+zOw
   oyKo6NfaTn8wnHCVvy3ZYrTSxhsM7fi5TpswAnzDYeJ+lPpAlhQ7OPMSZ
   OGmaJUZ2qlZgR16x8bdmLWu1mf9Y9gY2CN/2Gj7xsLLdfjwJg+UDRow+m
   xJSVLS1ApGxuDlCZWfYd6XJQ+Qd5z7sziZRejln3+a9eEC8NVoopzaT6P
   A==;
X-CSE-ConnectionGUID: CEDZCBMMTmW2Khbt+ADUGw==
X-CSE-MsgGUID: nh1LUpCfT6mGYOY96d14tQ==
X-IronPort-AV: E=Sophos;i="6.19,317,1754928000"; 
   d="scan'208";a="135452739"
Received: from mail-southcentralusazon11012014.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.14])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2025 16:42:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hqx91JRjImnzbOTJlDxDkQRIEAZLTDpNXqMCwBl+CPlVgIsz0RvgbcVIQ6iAzO93zuHasm+E00fzMCTP9unH/FuxwGdVccVieVeWahC6cFalM1CrEvSaNWdt70PwDUWUJSYuOJafxq1SmKZfafqd2QRmNrZot0ZjRFc5pi7Fa0M4sBnbNfGKPpJ/N5irXvwIlDlx8xW0yZBnV/tkSe8SIqflVTNnnim22/R5uSqYMwLH7A8P0/ztpyXBDc78FXeQ8sVhyvB9eSqG6X9mnehSS78itPpmnpjgOH4AtKPmV8Y3f6ZC9pRcKRRHN42A2RYEaRyQ8jrTsG0jGRuKYhl/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=ipvyqUC13CGUSwyir6T6ssf/kwFzfywumnKqt1paIjHlrjtRsTQ3bhD/rz8zzt2mAqeJpKA0IKStxMOWflcyV5cBqmKA7YqZZlI+4o5yS2ldATIGV9bUN4Y3lOKyOsOQ8QCIhPf9HHrG/I35nx64sH98pNM6pNWJlasibRCrhx1vXuf/9nmUmC6MDR0dja66yFLb0ahrdbalbn4GCPjl8fxZzrBHC7eccQRq9M4gkEL9AFfS6oe4a0Xsln43jMpLfkAuVc83NaoOsl96yiVe9vDruB4OsKNyxbCVuzYXRf8syY20LR5BwOVB9kprS1Ft4iWSRoQ99sDGH8JGpwkjHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=bG7PYQuS8ceICkZGnpegk3j7dmePnfxvLYk6h6riQylNOpnYn+sc+jRwR2tQmGtrjdaJNCzNonX6AEKKuvP0EjkBF69pl78vRT1pwhfE+LlKlSK/tnJC4IvqUqIgee5cAIpm9GAs1RzWX5a0erM7Ixz+5yHhwsGO2H4YpRdAS+8=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 08:42:24 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9320.021; Thu, 20 Nov 2025
 08:42:24 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] btrfs: cleanups for a couple log tree functions
Thread-Topic: [PATCH 0/2] btrfs: cleanups for a couple log tree functions
Thread-Index: AQHcWVejhAOJo4ruUEeFfyV7astYvbT7QH8A
Date: Thu, 20 Nov 2025 08:42:24 +0000
Message-ID: <1b5b3937-89b4-487d-ac89-fc5fd579f4fd@wdc.com>
References: <cover.1763557872.git.fdmanana@suse.com>
In-Reply-To: <cover.1763557872.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SA6PR04MB9375:EE_
x-ms-office365-filtering-correlation-id: cb139420-371c-410c-0af3-08de2810ba9c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2ltZHc4OXpBQjErSDh3alBLT2MrWGRvV0RaREJQdVNQandSVXFLWmd0T3ds?=
 =?utf-8?B?M3BGcHV2d2pxaCtDZk1vRHlwTVVrSlU0Y1hvK2JSS1IzNlNTWWJiR3BNKzAv?=
 =?utf-8?B?eWVyK1g4eXppaGkyQXBac296cFJHdnNCQ0NpWS95cWZtUWJDYWlzQytmRW5j?=
 =?utf-8?B?R0RQeDUrMDFQNS92VFRCalBiMnNxSlIyYWRxRDMyWHluTnl5T2V0Tm5NUWVm?=
 =?utf-8?B?NkQ0Nnh1VTlPU0xybk5HRGxVcVdMNEFpU2dYMVJkRmg1M2M1ZnVxMHJSRmxQ?=
 =?utf-8?B?cjlRLy9NNDI5K3lNbDZjb2VqV1pjQzUwZnZPWFRXZEQ0QTVUMWRteVJkNjQ5?=
 =?utf-8?B?Uk1ZcGF1K1dvZUVYM2NzejQ4azBwMXhHeWlmbXNVaURtZXNQSWpwcWZRZWFj?=
 =?utf-8?B?MHhtUU8vT3pHR3ZtR2FFTHhwakQxc29URlhEVWJBSGtBdk10KzN2Qmh0NlRL?=
 =?utf-8?B?R3BNWnBOQi9UanhlTTdncExpYy9FVGR3dVI2V3NPclF2MHQ4UVhvdXhlNE1T?=
 =?utf-8?B?b0h5QnN0djNiZlliUHU0aWJzZEtKdGNpcnEvcnNBYVJsbVZhSXF3TmtwR0Z0?=
 =?utf-8?B?eldOVE02MXY0bm5UNGN5VEh0RWhPQmRsdDhvUXorSVJOUmpQMEQrdzdJR3Fv?=
 =?utf-8?B?VVJ2UmpNZHVrbXBjT1RSQ28rSjNaY1ptbnVSak92R1ZxWVNlWGxaelM3Y05s?=
 =?utf-8?B?d3E4QUZqVEFCKzBwRVp2SVZZUUVGRU1HZW1wb3dhb2gvOTVHSnNRM0ZrY1di?=
 =?utf-8?B?VlE3Q0ZGVW81alo4YitXY1prKzFRQm9PQldKcXdYSDM4Y0VqUjFVYXIxZUJv?=
 =?utf-8?B?RmN4NlNKellQQjMzYk9udkZhT0ZFS2pmYzZQekN4N1FSdmpVNklsWlNaZFli?=
 =?utf-8?B?dUpyWmxYdTNCd2trVVNmZnpuOW5xWXdzQWJPd3Q0OWZhdmxCU2M2a1QwOWh2?=
 =?utf-8?B?L0dGY0wxMlRtSVNuNUpIaFR2S0pQNjAxUm5XbDd4dkxZR2o2VGdEdFBlV1BC?=
 =?utf-8?B?RmtaYWRtbDRKcFNwbUVhQXNscGhJbmdmZVBOQWZYNEtvNTRpZUJxdU1kTnVi?=
 =?utf-8?B?VDcybU95dlJLWXU2WHdSWE92cFNpeVlqZk5mUmdvdldlaGlYR09aNk1qZCtJ?=
 =?utf-8?B?b0UzdkRkdi81UjAzSjhNY0Q1MEY0dVdNVTFId3VzRlJRY0RVQ1B4YnhXc1Yz?=
 =?utf-8?B?TlBLd3hjQzAycjZxR3hrZk5ZNzdHZFpJMkUvL1E1SVBheE8xZXFUVTZkdXZh?=
 =?utf-8?B?QzVpVGp0TXNFd2p3a25Uc3RUZlVzMmFnOW8wb0pBeUkvemJwcGZ1dENwUENN?=
 =?utf-8?B?NEtNRkhpeE4vcDBkSHZ2S3RLbmcrSmY1Zms3VGd1dUlROHU2QmdvYkFRaE0w?=
 =?utf-8?B?ZnhkSTA1ellSRFVXa0pCQzU2cTlTL2o2c0x1c1Uzd2NITHBHRTFLdVg3ZXZj?=
 =?utf-8?B?ZW5FQmRYZlUwOFNISzBlT0FtbUVlOSs3M0R2aXEwVi9KQWZ6NVhwaHBydSs0?=
 =?utf-8?B?RDkzaTRhSi9zRGZTUC9mTFVHNldGclVRWnhhZ2hJOXpOSVhXZndDMUVzN3Yv?=
 =?utf-8?B?SENLNlB2TmQwM2ZTU3NmK0ZDTC9EeEdhelJDbmxrYzA3TGF6cjd4U0dCOEJG?=
 =?utf-8?B?TnpCQUgzeDJqd3hZd2xhNFV0T0tVRGFHbTVWQ0EwdFcwSkRYditDWXd1cEtT?=
 =?utf-8?B?bnZMM3RpVUJRKzI0UzFXNTNBb2dqYzBaZnp4Vm1KbW4zNHFNTTY1Uy9taVZI?=
 =?utf-8?B?Yis5Rm1FeSs3dEk5dWdUd1E3R0s2TjNTUmdUNk11eCtZTmsxTmd3TUJpUGJi?=
 =?utf-8?B?emNqY2pJN1VhOEZNQWtwV085eWtNcE8rT2NtR0lmNlhlaXc0ajFNMXhINmhJ?=
 =?utf-8?B?ZXByVXZ6Q0dMY0JDNkZiLzd5NDRFTUtuQTFiZ2RCQ0lvSFFuWFhQazBISXJp?=
 =?utf-8?B?OHM0RmFVZ2tZZjBPazhuV2l0aWhGSDBRMU5wd3R0dFJvRDNHbFhrYnlqeE83?=
 =?utf-8?B?UjEvcXZJOFlxeXovV29MOW5xVk1qUHMyTXFqSkFyY2M5UnRNZDVpSzdyOHd0?=
 =?utf-8?Q?aei105?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0FrbXV6MFZ4WGNtQ1daVFpwM1IvMWpuVmIxZnVYTUZ3aURpQWY0Y29Rekdu?=
 =?utf-8?B?dnVEVnI0U3puNU1sdUZCL1pNZkZFNFFHQ016MzE3ZkphZm5JU3RvM01DMlZi?=
 =?utf-8?B?SzR1ek90Tmg5VlRUK1lSVTFDTTV0Mkh3Q3d2Rk9FMDNPMktYQndMRTN6SHV1?=
 =?utf-8?B?dFVRcnpXRUlWbmF5N3ZvNmVSUzBGT09pL0tZeWxhYzlUUmZBWkUwWkJuUWZn?=
 =?utf-8?B?NisyQ25IdWtjdVdkWm9qa21maXh1MVUrS2ZhQmRiYXFGNVNYUVVVakRyb2ht?=
 =?utf-8?B?dFZLVDIzc0Z4eS9OaGVsNEtxamk1aHNVVmM2QnhVTDlkWW9Ocjd6a0g5M09p?=
 =?utf-8?B?T0trU0VKYWFDbzlrOWJsWml5dGlSOVBLQnhtQXVpdU5hbUtwWFdBaHdNS0NC?=
 =?utf-8?B?VVY1QVBnWFozSmx1VHN0ZHBRcFU0MjZsRlZRa2xRNEI1bGVVcm13ZXdQNkV0?=
 =?utf-8?B?YWJ3WTlscmFNZDI4NlQvSDdCaEZKWm5EOTUzRGErTmVXSTlGV1NhRFBtRStp?=
 =?utf-8?B?OWo4c1lvRHZ5R2p3Zi9RZElGcWMyTVhmME82VVRSREdhNGowenptcGRVbGQw?=
 =?utf-8?B?NGdKd3ZEZXVRYktRaFFlQWFjRHc4cnZHVHlmdmV3TnM2ZnN0ZkkzOXd0Rmlx?=
 =?utf-8?B?eE4rbGJIUCtVNjQ2bFZvWjRzck52UnBGV2t5SlU2QkpQNDhjc29rSjgyUzQ0?=
 =?utf-8?B?bHhQUDZVOTJZMWtUSG85RVJiMEVMcWFDb0xkTUx4cjVKUjl3VGI5aEoxcjgx?=
 =?utf-8?B?Y1d1djNuOG9tR0pRREY0c2N4MlJ3VGN5Q21Da2s1RkozV0JPYk84dWRLY3Zv?=
 =?utf-8?B?em1zMkUyQmw0T1d2NFY4cklTTUVzbnVPaTBkMHdtVEFTUGR4RjhsSE0rTERh?=
 =?utf-8?B?SjZlVnhxQkJGM1ZDSVFXZWZzVW9NZkU1RmpXQ2pZMUIrM0hZTnc3Tlhwb2U4?=
 =?utf-8?B?L2E4c3ZDQ0R4UXdoem9tQTNTUVVrMlZkS1B2OFJIVmhYOUFYRVhjNnFKU0FD?=
 =?utf-8?B?K1FUbzl1d3htdGFkZWY2bUR1V0pwUDk1WXkwVDl4cmhNYWhkZVVJNjBOa1dh?=
 =?utf-8?B?SnRRZ3hnMmtIUi8rTHJCdnNkd01Wa1JuaG1tRW91eFVGcXorNXhHd0VkVnMv?=
 =?utf-8?B?dFlNZm5aWW95cTMwYkNrY2FFWVpLV3VKYWQyZm9xdFBTbmJtanovV2pNSnV5?=
 =?utf-8?B?T25hVHdwc2x6aVpjTnNxNzEyclcvMU9IVTVoY01zaTBQV0NjdE5vN2daM2o3?=
 =?utf-8?B?WWVsY1dKdndVdFlxY3QyY3Zaem1Uc1hFQ25FL0hlajk5aVBTaElrUW5jZzNX?=
 =?utf-8?B?L284MUF6MEVxVjR5dUJzbzBMSTZuNitRYVQ3Sm9VUCtHNUdxSkdZRE9YZnlm?=
 =?utf-8?B?WUhQSlNERjR0OWpublVwT1IvMHVBbXlnUHlCTlNKVFRCQjFVL3hSS2tSRWR6?=
 =?utf-8?B?bDNhdUtSU2lhWWpjc2N2am5RVkFZZmVQZUFWV3JTNDhGVEh6aDFpaS9ncmtW?=
 =?utf-8?B?eitOMVJFZCtKQW42d09iaitVS1hldHhyaU1qWnB2VzN1dWRjRXRsdW5lWDZp?=
 =?utf-8?B?UlRkTE14TEczWW9QNzE1VUhoRGtuQ3cxUThTSlFPUThCTlVyRmo0VjhmdUpR?=
 =?utf-8?B?d0pvUkRZYm1NRTQ5MGxsN1FJeldCRkxIRlZVZG1Ebmg5TjVCYVJybGhyTU41?=
 =?utf-8?B?SWtndnNoR3kzV3RsUHBBS2FVSEQva01mMER3N0t4eWR3eWJFcUljNTR1QWJ1?=
 =?utf-8?B?R2hqdy95amJIemZuUWNML29sZDdOR3BZOHY0aTYrWU5aODVvaVBlZnRBTUkw?=
 =?utf-8?B?UWM0aC9HQ2N4VnNQVHA1NTJNOGFKTTRmMkxIL3VmMVd6cWJJNWVTV2hISkNu?=
 =?utf-8?B?RzFwaXhFRm1ObkNMRmtpYmhMQ0E5LzRreW04RzZMOSsvUzM0aHNESlo1UDUv?=
 =?utf-8?B?emdiUlpqb0JZQUdEeVZKZzNDUGJrdWJRZTVtKzJCeUE4WlFYc1g3bHhheWhB?=
 =?utf-8?B?R2xIaGpKeVF5MndBZGpyaS9VOWI3MGFlZXBpczNzUExDc3FWMmx3QnNCa2xl?=
 =?utf-8?B?Tkk0c0dqR2ZmakFRL1FPTTIwdUhxNW1zdHNuZ1RaeDBmK1FDWlhGWGJ6empr?=
 =?utf-8?B?MGhnemlvb2NLTzVGNnlEeDQ5RUtkeUxaNWVNL1graUxjWitGRWk0QUZtWnRQ?=
 =?utf-8?B?aEpqVEZFb1Q4OWxOVmJlaWxtMGJEQVZBK3ArM2VKdWlxTGE0WnVMWk1yNDVC?=
 =?utf-8?B?S2MzZFF2d2pLOWNHN01vb2lKaDJRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14F969A70541CE4C89642EF8DB796C01@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6PfenOww0jVLykinSpRiErvZkmqy7WmIwl1WCNWFVECirDE/KYVPLjkCJELccH2nSYGOG2+I+3FA6fgvRpQYBCSVf7DhXvVREsCkWuZGzrkJ1pnW5pTfIJiTPXniRM3qa3O4GHsFk2GCVCUgikwidPFwOz2OXxBFQfqERcJ/oSY3m8CLbgS3OjWEwL1luggnvSdbZyGPHix371dTdodxkjS3Yx986jKWndSNVM3NB75UZUKujZ1TrkeiHIWn5uB9q+CwLemnKJCVyTBLFchegHd72ZA3oqcvxy1/0VmkxKGVtXoSOre43fH5nyNz7KaX2i4gOXF70rm4btHvCvJayw6sa65lS7DgQNHQnnZ/kmH1zve9zuhf3gBZjgaxMcLMjIATgGWWpjqLn6emrax33TScnHeU30LNaPivDeTDNYpYqf4CEaAcMzxEs00GJMdD7nmn+eHdNXLd47FQiP2B0CiobspQXUWslZN5hNGd+XwsHF1Zz4CYMbRM4PWmITo6Dz+Ql4vu1UxyJQhrwys5StGfVYsOGeFBnozJjk1Yb6da4RJ+SvP1iC1AHOdrSDGb4bdFCXl3bRLJUzraYGYIDBM76MGHTaCMt/oQzHVR6ghL0aSTLx71IpZhDcs7lVat
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb139420-371c-410c-0af3-08de2810ba9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 08:42:24.8384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u/cV98BuYS0/OXzXIdF0ePWRvxNTNRUlaosPhpcklc801EGr0TW9r1IFEYwZ/Ner/dMGPu1YcYxWAL1lhV/dWnNJtC3KXO75GF99Qgj7hgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9375

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

