Return-Path: <linux-btrfs+bounces-20992-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GyRSNpvrdWlHJwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-20992-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 11:08:27 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5EE80194
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 11:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3F353006F2B
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 10:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD023164D7;
	Sun, 25 Jan 2026 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hWdaL1C+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fzT9IMO6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF6DEEAB
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 10:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769335700; cv=fail; b=hDP1NLP43AHBHRJdsnpo+627gz2S6ZdE69wQzzLAwdC04xaT5K+sYevBao2ecZh0ilM7IF53lbXhG6IyjRqzirkHyHAUXi78tRb3ksWFtIV1v4BTO+EZ+ltidd1gnTw4GtVAJV0Av1n56M/ruHY5QFt+/C/JCif5O/45QXN/Bz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769335700; c=relaxed/simple;
	bh=rUID3ukD6SG1NAI8UIagIbuLjfA9dt6sgJ0xLBZcjKk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r5awr+oZ8F6fx54EER5MIXWZAMi35czQ1QN8a7WkO9M6W6zF3ZzjDx5EPYZtVoAZ/4+K1/sbM5jAetTj4DaM5kzkVYb347QMh1z8vie1QNyHtW1jX+O4b4MibCAZzcxv0Jf+ZdpZpp57oE6vlOt8+wLoS5+qWLhuElxL4Z//8sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hWdaL1C+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fzT9IMO6; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769335698; x=1800871698;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=rUID3ukD6SG1NAI8UIagIbuLjfA9dt6sgJ0xLBZcjKk=;
  b=hWdaL1C+BY2xfjW4D2u2cvWVzYm6Vv/3hvbnJqeMBbkUdY4TqZfO7ftF
   tBTY4whmvpGbKKgtd/Dz+xGB5EFeXGkzoVhB7WSctNT8ajrIX1zRj8SCB
   YY5C/v5D/lI60iyZu+02Ngt2Zs/IZ7eh74g9IM95byPMdd5rUEDn2obwb
   2aY8A/wyiTt3GXyruxkK1OI7EnWvPqOMwKNHh6rFniWUsKNXp57VCGMpN
   +S1JNZavhPbq/UkDnsfjx7ZK3OV9uBwmWJvbhecxijf7TBCt+LmQ1tXV9
   s5PzSkT55OGwmLu+n++WYC7erzdnyKwUxWmnw6XXF5HRjCToG6itPE//t
   g==;
X-CSE-ConnectionGUID: q524xWjNTYqcHJv9PA4XsA==
X-CSE-MsgGUID: QP/KQjvQTdydBpgoePip4Q==
X-IronPort-AV: E=Sophos;i="6.21,252,1763395200"; 
   d="scan'208";a="138664489"
Received: from mail-northcentralusazon11010057.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.57])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2026 18:08:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLyL8R09YZSmUWXIWdX8pL6fCuX4bAm44vlL5YP1r9SzZIuw1F5keYqAcDOnmaWb7RYUFfskTMI5mk5CXhMRfGVs7wt/UUCXLQnhpJPEMycgwl2+oCKdaajQ47o/H86hsERZv56K0R2/XtZekB7Nr0uiekfFMk7i/4BICFqlTa9iKjq5uVzxJ/R6mHovUzZ4RHTUi/NswFtWZSlNyboNsaBo3a58/QpO8zjxoKcrY+IrVEGc/6R4RgETGGqPVoIujvAMX/GvduNWbv3sBfJcRLAGCN8pAHrSq7LevprpyKlNf04qdfaILA8AdneXUFmrmvNKOxWVEYRCTsXmxYx4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUID3ukD6SG1NAI8UIagIbuLjfA9dt6sgJ0xLBZcjKk=;
 b=q8ZpdZ9eDCb8BsqmERDrSdF4bnUUHD82X+nKSQlcmSE4SLmXn/XdM2iS5c8INT9PZIMTpuuq6JK7yQjwPDUuNas7sAIJ7o90GwrP6l7WSnOIVqX+vHe56MOB5nntdn2HhvBHpOMLcd+fnXEs3nVy28yGWwNy4oEcPjXNRgNIGrJR68c+BG7vFhCCku5LIZ33txY9QmGhpF9+jGtHSA8QnltQzb499CK2fQ8m9aBQq4nslQADU1hjukGSeqBqXz98x2udRKB2cDmga/mVoYeSrmpM7f95k3PePup0h9DcXrFc+yq01Whe+VIq8GeAuerLO6iCVZNdPGflJi3T/CsHsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUID3ukD6SG1NAI8UIagIbuLjfA9dt6sgJ0xLBZcjKk=;
 b=fzT9IMO6PXBczGrhfLkBJr13IP8FfDfxxFYb1Ls7ojDd3AcltVGaBrnwUPVkP8Du5HfJP0fRaqs1dDOXJiL+UXv37flFpjEqHrx5F6tKRI0GLRYxGgqgIfkK3v2jjUp7Fn3BWxZ8hUJbN1AhTpFTcQiNizf6aEdXmJ2sjALx9dg=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SN4PR04MB8397.namprd04.prod.outlook.com (2603:10b6:806:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.6; Sun, 25 Jan
 2026 10:08:05 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9564.001; Sun, 25 Jan 2026
 10:08:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] fixup last alloc pointer after extent removal
Thread-Topic: [PATCH 0/2] fixup last alloc pointer after extent removal
Thread-Index: AQHcjGW36Kc/lid2f0KdkfUov32MyLVirDYA
Date: Sun, 25 Jan 2026 10:08:04 +0000
Message-ID: <360bebb7-c8cc-4c7a-83a5-2496a1de8fb1@wdc.com>
References: <20260123124136.4110463-1-naohiro.aota@wdc.com>
In-Reply-To: <20260123124136.4110463-1-naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SN4PR04MB8397:EE_
x-ms-office365-filtering-correlation-id: 8b4c622e-9d45-4628-868d-08de5bf9a1a5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZitNakpBUWZWdkpDTUxEZDduZ2xKYkcxSmJzcTdrb0ZsKzJ6YVpWcGtKV2pW?=
 =?utf-8?B?VlRCMDYxSGxYeFpPZWV6NmZXUEFuS0xWbC9HVUJJdlFTTEcra3NwK0JQZmY3?=
 =?utf-8?B?R3dlTmgra2x3OVNJWUZhWExROWljRkp2NXJzR2JmZ2RnOFdGdHRIRTdjOFdw?=
 =?utf-8?B?ZmdDVkRON21DOC96bEwwVkhabng0WmdUV3VVeHBUWVI4aWlVRDI1TU1iRU5H?=
 =?utf-8?B?RStveEpOOElWdE00ZEhUSXZuQkZmb2ZZU3NVY0ZyYWNCbWJ5Nlg0UktMaThk?=
 =?utf-8?B?aVRjUm9tZ1AwTDZIekowaXZsVTZRejdUVURSM3VzVHVmbnNHd2l1OWRrWmo5?=
 =?utf-8?B?azNxSWtVb2JtOCs1VEQ2VFZ2NzhpWC8rTFp0LzVvbTJyWDVNQkpoN1JDeDBm?=
 =?utf-8?B?NHVnMzIxUHVsVFpjZi94aEJReXVDcndsQ3N4Qlg3ZDJIVHdTcGowOS96WjBO?=
 =?utf-8?B?YmtVSUFUa0JWeVljT0FQMUlsV0VyeHR6UUNoTW55VU00RHRqTUdZaUx6Wkpx?=
 =?utf-8?B?YnZjMis2VkVwV2hQMkJJNzZGaHNtNHhPUU9KRW5QMGs0L2xEUDZZYjFveDVi?=
 =?utf-8?B?bXlRbk1ocUlTdkZGT2RZanpFV24vKzZNeWpGNEtaRmJ6emRGZWtBQ3B6YVhG?=
 =?utf-8?B?UU04Z25wN1NlT3hzYzl6TU9qOGx3YXN2Y2szSDlEaXNjT3Z3VUl4R3BaR1ZG?=
 =?utf-8?B?eHk2b2hjZHhKUHFLUGVnYnBMdmt2TklmU25SUkNjRW9ZYXZEbms4cWRFLzhC?=
 =?utf-8?B?Q0RmcmRzdEx2QTVxeS9tYWdsZlNKYUswV0xYOXZyUlhPVVU2SGdKRW55U0x4?=
 =?utf-8?B?UFNzMnFpRnJkZG5PTzJ4WXYxWHlNM3REVmFKTHgzU3oraWFKZysyTnozWmlG?=
 =?utf-8?B?OGRlYnBaVGVEdFZ0Vm40bUlzNm1tNkdJcHhPMXBQZmtNM09kckMwR2tvVTNm?=
 =?utf-8?B?c3U4dWJQcWkyZTRrUTVhYjBxRlJpL0dkVDVZQzdmSnBXZWVydlo5Z0FBWEoz?=
 =?utf-8?B?amFQbUlrZXBDbmRFWHAyNHBWcjlwYnIzb0RxMDcvVHpyNFJabEFhQVJML2VG?=
 =?utf-8?B?b2ZhZzB2VEtnM2oveS9QU0I4Y3kvZWRxWWZPQXdLd0lNczZyYlJCRktLaCtS?=
 =?utf-8?B?a25CdUxrNkpVUS9LUHkxSnI5dkl2aW12RTFEM0tjUVc1N0NDYVdBR09QUk5C?=
 =?utf-8?B?bjE4NDFYMVB3UTdUY2FrOXhsaW9WNlVtRnVuMzFrUC81dXJ2TXJMaFVCemoy?=
 =?utf-8?B?cTFpVjM4TDJmSFFZbTg0anRxUXhlWjAzRDRSZWExdUJ2QitzNm5EdlFHQVlR?=
 =?utf-8?B?WWNhcG5RM05SUGJVLzE3YVFyNmMzQmpoOUt1ZExhWW1TcHN6ck02RC9PM3Uv?=
 =?utf-8?B?VUZaeHJobjg3ZkZ0YkZPUXB6K2RubkRwK2tvL3dSTXZ2REt3RU1iSlhHeWhx?=
 =?utf-8?B?ZVhsZkhsUDVHZkVHTU8yTm5WQjNkcjB5TWFlTnFxak9OeDB3OVlhd0ZRaVNH?=
 =?utf-8?B?NU0wdHpuRHF6dmNKWGd5Rnh6RDFjL0lCd1N1aVpxQUNUb2s3VkdkU2ZNbGhh?=
 =?utf-8?B?RkJNZUFjV3l4dVNVTFdhVVFVdVkrZ1VLMXNTWStoYXVVOGdUVitCQ09ES0tk?=
 =?utf-8?B?b28rQ1hucThwQmhDaTBCaFZpY3ZhalIwbmM2c2FMVUtGYXZBN1RXc0FBNko1?=
 =?utf-8?B?dzNmblhSZ2JEQUNGb0MzUnluYVArRXdIcjQ2TzY5QVIyNWo0Yll5VUE5QkRl?=
 =?utf-8?B?RDFLRjB6Qzd5QjBzYjZOV2ZiQm5tKzU1TkF0NFZCS0liRGR1emJtb25NVmcv?=
 =?utf-8?B?TnVQTzBpWWthcmxmT2FGVEN4cGNYODhOeEljbHBMY1ZUdzUzQW1SWU5nS1Bl?=
 =?utf-8?B?N0JtTDNDTW9jS1ltYTNoOS9OUTBhdGpmcTVGTkNycDA3T0tTZ0JoRFhYbEVr?=
 =?utf-8?B?b2lINWRiQXBwd1M0MnNkU2xES0JLR0l2NlY2c3BWUTBaTzI0a1RGb1hnNjdP?=
 =?utf-8?B?Z3VQQjNkK0hXb3pZSjJoWTlqWkloVnh1dE00QlNBN2ZiWTNjTTRNM1VjQnlv?=
 =?utf-8?B?ZmVqVElGR0lNK1RiMEVMbWY0UXRuWXpZMXM4cERLeUc1YnNnNVk3SkZmNzM4?=
 =?utf-8?B?S2pEY3M5QjFBdnloY2lGbW96cTc1VTFISTNKUnlvTjhMTVVMMGwxU3UycEFY?=
 =?utf-8?Q?G/T3iYeSitpMJ4/brAPEsIY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2xPNnh1SUJlcWZEQlRFUlhUMXJvdmVyREpZWUQ2VkozVDVONWJFOXdTVXFP?=
 =?utf-8?B?WnVCeHNIaDMzZ0ZOVXNqSGp6V29mSUxpYXBGdkh5QWE5dmU5Q09xWHl0RmQ0?=
 =?utf-8?B?eVV5Y1hHbFJwZlc2akdDa05OMnBqUFloVS91eGpxb1g5NzVPMDJkNzZyOU91?=
 =?utf-8?B?U0hlNTFYdjF2cS9ROU85OUFVQ0Y1djkyR3pOcElLSHM4RkxGY1pQM1RTRzJ2?=
 =?utf-8?B?RzAzRmgyUHJ6SHJlaHlRdU04akJ3U1o0RVRHWlFkUzdoSk1oWFEwdXgvZ3FH?=
 =?utf-8?B?d0dmdE9SVmpxSlBObU1HVk1kaldLOEsvYjUyRUZTWTlhSnpvNEU2THdPc1Z5?=
 =?utf-8?B?K1RveHBucHJVbHFreXk2VG5sUEkyYTVGMGdkMnZFVDFOMDQySERrZTM3N2Y3?=
 =?utf-8?B?d0ZEZXFRV2FmeVZkcml2MjVxU0xjSWYvZHVZZ0Jha21zOUp2YWt4YW9kTnB6?=
 =?utf-8?B?WmFST2g3UFY4a2hlZnFDdDFLQWQ5c2hnKys1bHdnRGkwMklXd3VkSWV0VURk?=
 =?utf-8?B?Tk5xY0pOU0NXZEVnMjFHcEhpREFkdFYzdkd2S1NsVTZGc0NLODVRblFzancz?=
 =?utf-8?B?Y09RSnM1OE5kOTQvSFc0Q1dqcXJGVkRhbUcxOFQva0Y5ajBXY2N1WmNaOUVD?=
 =?utf-8?B?NXlQemxNWWdUT0xFZGhRZlY5UG1vOUI2V2JjTTk1U1hyaVhRVmtPRG5IU25M?=
 =?utf-8?B?Sk5NWXZlNlZKTWJmWjg0QlUzMkNCeU00b01udGVTcFZ3UWhhN0ZlYlo2bUtC?=
 =?utf-8?B?b3paZUZVOW9na1g3cXFOYndSWDg4SnNBV293QjdacHZiTVpIaWtVeEZuTktL?=
 =?utf-8?B?Z2Qra2VjMXo5MW5nWDM5Mk1Hbk1rZThOQUNGbG9vcU0rMllsZ282ZHQwcFpZ?=
 =?utf-8?B?UWNSNnAxcnhLWVluakdXcUpvZGxvUThGemo2N01lYWZXNWJBdkI0NE43aVpX?=
 =?utf-8?B?Z2JqWUpoa2FjZHJGblJoQVpWcDJTajIwTTdBbmRFUUhqYWs5ZDNxM1I0SmZj?=
 =?utf-8?B?V2VOcmNiQjJ1SXk0bWNhSWk4RlhDNGJqOHlVbGxBQXhVbHRsZjhleDhDWGRy?=
 =?utf-8?B?Zk5OaTJsMkM1WXJxODluOWlTOHNvZlhtNmN5bjNWZnB5a3pQSGpyYUM4SVFj?=
 =?utf-8?B?ZzR2Tk1pVkNQbGpWVU9VcWRtdjFFTll5VTJIdkFjcjNRZmJ3Y0tTSmxrTVcw?=
 =?utf-8?B?S0w4NXZoWVZBQWNLa05qSTlSdGwzUitIeVVmZWxwZkd0MHBPMEZiUEs5Wnk2?=
 =?utf-8?B?dTVGZSt0b3hLemZyb21FUE45YzZRVWYxaFdkVlZpT0FodnB1c2pPZjZIY01r?=
 =?utf-8?B?NEwwV29jVlRCbmlRR1dNdG1GQ2hDQ21oZm44Zk1tNUJ2LzZNbUxhVExCUzFM?=
 =?utf-8?B?a3NmVGJwTS9sK2U3eEhvYVJIMU1ZNjZQbzlGazY2TE5pamJJZDVKQmZHc2tk?=
 =?utf-8?B?UmxBSHBPQ05pMzJ3ZVRHUC82dEhUanlIbFBLQkdQM25kZVRjNXY4blBzZ1NZ?=
 =?utf-8?B?aFYvZ3JBWVdBMmYvOXZqbGtTNG5PUGZON05rZnVUS3dEMU1hU3AreXpFZ1Ji?=
 =?utf-8?B?UFFmdkcrN2xMUVRzM3FsQWtaYXZHUUJocnduYWdsREg1R3BLTlZ5cVRlb20x?=
 =?utf-8?B?aEJXVTJqaDBmR2oyZFRvMWFaRXcwV3NiTjREQUd2SUpUSU8ydzNkNHpYTDFn?=
 =?utf-8?B?YkZzSmZNalg5UTRCbTFlM2g4aW1OMFlOek5QRGh4SFZVcm9TSHNjOVh1WFZs?=
 =?utf-8?B?WmI5L0Z6TTYxeWNXYTFjUnU0aC84UnkwS2VPYXRMcTZjbWo4d2l6QXFTSmtL?=
 =?utf-8?B?cUZoR3dDeExLZElEVlZ5cHpwbW5mNEdFSkR5VjNBUGNqT0h5VXVrT21XNmVv?=
 =?utf-8?B?VXhzSjdYVUFlVWhWclBFNU9xK3l4WjMvRWRpeXBlUzlTV3Qyc05RSE80ZEd3?=
 =?utf-8?B?cDhJbFU0YnFqRDQxZ096RHEwYmE3M1BZRjJUaFFNV0VHOE11MTFvazRPRktD?=
 =?utf-8?B?V3dXMHhvNUdVS2U4eTBYbEtNa3RWOUFxVUYxMkNvSmZMVDRrcGk1VnBCbHV2?=
 =?utf-8?B?VURHdTZDM0pUQmFhQWV4bDJnTDRFWG9oU3lYZG90TzdLcUVockQxa1pSQUZh?=
 =?utf-8?B?QWVwSGRjNk1USTA5M29vRExaL3lKQVpkSlliR0RlRVFrOXlGVnpUNU05bEhl?=
 =?utf-8?B?MU5IQWFEVUVFMkx6amtHcHI5U0FEcHFqeFpma0ZCVlJKNTYyQlhJUEVRa0pm?=
 =?utf-8?B?aGVmNzQ1a2UzUnR5NHNaTTlOd05ZbUxCSnBqTlFLYTZYY0pEZUp4UVJHRFQ4?=
 =?utf-8?B?VHU2bGNlNFZYRndYZE5Ga0VYOURZVmo1M0JBdTJJa2hXc1VMRkQvdkJJS243?=
 =?utf-8?Q?Zs6GtvRlkHaZ1M41dQiIFOx3e1jmX6HPsFnjSu4CuPw6L?=
x-ms-exchange-antispam-messagedata-1: Hb+cqVMnnAp2tgrINf3DjbJR6I+CMM9ISOY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F9B0F2A4CB2EE40A7EEB455A65B533F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4A80Feqj+CN4a0WWwDQfYk5AEMETKsbG4/37u2QK2Xhp/vEl+ZyrWlhrhcASYLFDKzDxQL+B7DLnGqICadwqOARDG4RbA7GuS4Mo28JCWq5Xqsi/3XQbDYfcwchi89Au9Jt4ESM7S8hlCoYlIwGz3bSwwA/v98/rR3K40Lx8i9fpTLXXowFnu0eiXS03ho/bNyALbL8fg+VNuy+vWwETPwEphdYBYjnGdpkjj2QDzZ0V76p8OCLmrnBKoZnhJ4pXKMHMSVTU6Qv+/cU6f2j04q8vpLmg/gi6y+YuETv0cUQMO/PaV2/pjhRzTWKc859TzouOtWYHBP24XQBXJilTdBdZNUWG5njRyJlvKOjOLvCF4M9zEkvZy8AZB8RBjYxCI/U1jChLZFVwEQMRtkmLlM2hzDgq+cWosnx0kD1FfNa7AqhSA3tN290HhQ8h0dsQF6x6u33bmQlePEy+1E5hyQs2goq2hwkW6t9KbxJiBezbwZqZBopKhG8TC/uOx7FJoHTal3R0ObAqr7xf/9CEHrdR1BgOsgvvgOpxkRHsmNyknp1pNqobHCTiHNY6qybIhGxtv38ZGTJeEBA0TExwHQnsMKnVj5el3Kra798zzQVR3+QE0VdeCfaTSf2LmSie
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4c622e-9d45-4628-868d-08de5bf9a1a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2026 10:08:04.9651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmPhWQSjpT7iwcSMeJIERoIv/l9FJKvH6tFG6aSR0G26L+7aVVZU9/F9+rLXo+nyt9z+CHDHLjEYT80sVXCDKLVpeWtaDIIGnxPrfuiH7Fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8397
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20992-lists,linux-btrfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B5EE80194
X-Rspamd-Action: no action

Rm9yIHRoZSBzZXJpZXM6DQoNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFu
bmVzLnRodW1zaGlybkB3ZGMuY29tPg0KDQpUaGlzIHN1cGVyc2VkZXMgbXkgcGF0Y2ggImJ0cmZz
OiB6b25lZDogZml4IGxvYWRpbmcgb2YgRFVQIGJsb2NrLWdyb3VwcyANCndpdGggbWlzbWF0Y2hp
bmcgYWxsb2Nfb2Zmc2V0cyINCg==

