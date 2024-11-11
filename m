Return-Path: <linux-btrfs+bounces-9417-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 611FC9C39AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 09:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8462C1C21720
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 08:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E19715C15F;
	Mon, 11 Nov 2024 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B2bggGGK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eeLLREqL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A3C42A8A
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731314096; cv=fail; b=oL+ORXZ+TW0eblqDmv0w5QpFZuO82VWuZb7JoZKLpHSNkj9je1wCttdq/I0NUUMJ2zB3U5zYHfX81IHUieOLmhzZST21i1/dTnbCBYVT+wI53n2WuV5xpdgsRyGNQ/JXCiRNySzZC0ln7vYUx3XYwjMXSphfdHPu9WGEwAYWfEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731314096; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JcidU+C1Ud6VFDn6C/QXjfYgJceMLXTHzMOaM09KN184UOyBfTVrzv8bXE9IElNFgLp6sD3VerAnlJ38HmWmFV6Rbag6azrsAksAZ0D5IleTsde8EkByulg1gsCF23qEJICpLUil+AkLk2UfuXMhp9BjqMRQiHajT+kfNfJ3Ys4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=B2bggGGK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=eeLLREqL; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731314094; x=1762850094;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=B2bggGGKh+hftDmIFIz85vZBaQYzq2RfdGmKKsSTae/tUEB5/C92xcoF
   zA9dwX7AiwinuFS4hL9iKhM2vlJmX507DFYeJki7ofzJr1CCSUa8YXmmd
   HUrlhCZq2gmbnUopyH9ILjamGJXmRIJD2B1kAirhaAf7hyph8IFp2pWlt
   CmKhTd+xiCbEpARB5zjLuXPDbc4KT3zcF4ArVKHAkpFvhUDOMmijjmmso
   7Zyo4yV2O1cf+iA1gTZrSxtIYR3e6XwmywzQnH+mZpmIVK0FlBgmyfcdx
   z2h6YlPwBxJEfe9BIEX7HBjQc1aTk/+8fAnYBMTDk282U38fwMx3tfgvz
   Q==;
X-CSE-ConnectionGUID: SltISDL7T56+LLpi/zSmcQ==
X-CSE-MsgGUID: Z2PLTHtaTVaqyW6Amz1eVA==
X-IronPort-AV: E=Sophos;i="6.12,144,1728921600"; 
   d="scan'208";a="32238715"
Received: from mail-southcentralusazlp17012010.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.10])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2024 16:34:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSNAw0gNaGcnM0xt8yZfCBlUTdlWZa8Wy7VYBJcE54qYOps9gwoYIKhDFUGPEziqNIcJHeCr+B4JNQDWmFwVxY0FEKXj0NjDc0eFMAinm4DXCqwxxW9Il9WYrI/JzUPFhYGx/N+aeLmz+Qds7+wfRiC+hJj7VzEu5iKx+kdr8Rsg1eJvQaLUbKLvPDuiExFcIGa9SfeTNeBLz9HkBpoowQEUs2cd9bg011fFxDQzd6exp/eN8nshhcezFadn3EEVqzOygW68XVqMr5Qr6Nvq1r00wpnhhQ4O8GZsxfUTVUxwxnCirpzCX//tfL4CQrF4NN03KRCnxfZ34iNvosOWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=RTt5sgfoXfGbznzPaPzygEhnX97pEwAcp8+FVb17Gn7NWQQ5lm/J8BUbxu+GlSPsQCfbZUkvmTDJ9Ncq2TZZub57s8/j7/JCrw7yYm4SmWvQcuvXgQWZicocv3YNS+04L5M4NotoimFEg0zEZ4sDWk1FddgyMAzIay5SR5I9ylOtX3SqTu1vEExBI0e8MlOgKPh8wDyvHK31B0O/ZY1IDErikxQX22xSy2r3qOCF40nGbKALqdnFhCCsApSwczACK9ep07JjUCl7sCrE7Qn5ZgB9qDsNUjjn0OI6vKWiL1+/CjOZeMcVZrp3Vyr1qeGvGWxuamfcqOdkM8vCCk6LIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=eeLLREqLc4Hgl0pF+AF/bFkeR4mhEa+Qklhgder+XdqiWbQA6xG2Z0IcMybPt6YQbS3xANuf1sKvjLHx60ch7T7wXa3UOWUier+vPuX38JiL6gD2jE/V90KFXNqh0W38D3xWF8IlA1Y98nflTkmKNM8i6lAVHbTdCIC5dG/jajY=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SA0PR04MB7178.namprd04.prod.outlook.com (2603:10b6:806:e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 08:34:52 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%5]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 08:34:52 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/3] btrfs: drop fs_info argument from
 btrfs_update_space_info_*
Thread-Topic: [PATCH 2/3] btrfs: drop fs_info argument from
 btrfs_update_space_info_*
Thread-Index: AQHbNA5cYwWIncAjZ0GtgTBxBWxwxbKxwQoA
Date: Mon, 11 Nov 2024 08:34:52 +0000
Message-ID: <e764cc98-8931-4bae-84e7-42ee586da9be@wdc.com>
References: <cover.1731310741.git.naohiro.aota@wdc.com>
 <c8c70a6aed1f5983ecf323a3c51701610b0e44ca.1731310741.git.naohiro.aota@wdc.com>
In-Reply-To:
 <c8c70a6aed1f5983ecf323a3c51701610b0e44ca.1731310741.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SA0PR04MB7178:EE_
x-ms-office365-filtering-correlation-id: 3dfbc791-eb3d-4d8a-6789-08dd022bb692
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aEt6KzY2Z001UTVISUhKcVphNElEZEdZbmFPMUtiamgwMnlmR1hTMHV4WXRX?=
 =?utf-8?B?ZkZjS0RKMU50cjdFR1JsMXpUTHg2OHNVNXBqT0hGNzdHcGRtNjJKb3hIZFpi?=
 =?utf-8?B?UGN2eThBMlZ4M2RwNTJOalJPMVRCODA5TEpYenYyb1AyVEtkZDEwaVFIbDBo?=
 =?utf-8?B?Ui9rYXI4RlFGdWZkajNjT0lsMkNEMzBDTmdhckw3Q3p4OFY2d3VxUGtQSkMw?=
 =?utf-8?B?VjZoNWxEdFNIT0Z3MEY4S0phZnZsY1JNaU9hQlhBc2dqRjZXbUpWQkxEVEdX?=
 =?utf-8?B?OWpCMGV6b0R0VEVQOGFmWmM4TzV6cEdqM2RNTjBhbGtlUjE0U1c1MkROOFBo?=
 =?utf-8?B?TFFMbGZ0Z2NLbWcyR005OWtWNTRuK3NFektQVENSTmIyT2w4T3dxS1VOSDVU?=
 =?utf-8?B?elZRaDNwNjh4Y1NjRWJmSWZYcnBuRXZrZ0RvMWpUeXN6aDVDUWQyd0xoK3ls?=
 =?utf-8?B?YjVUc3ptbzRiZFE2ak1xdEllYXYwS05nU245NFNLVGJYbU1QdXYxWnRPSUky?=
 =?utf-8?B?KzBTRTJ6MDd4N0pqQWVtWklRQ0xZQXRyZ1BzQlBWMWt3N0M2K016V01RUWVa?=
 =?utf-8?B?ZytFY2l6N1psZXZLTmdXdXpCWUkrbGZNaXA5SHU0TER6NDRXbnRNOThwMVRw?=
 =?utf-8?B?b3loZEQyYXVwTjUzbHVTMkFKSk1RMnVDeTRYdFNFTmgzRUllMDY2QldLNllX?=
 =?utf-8?B?Ri9wU3ZEay83M3Y5ZkhrTDdYSDJiaXpNemh2OGJJbXJqaXJxRHZsYkJqWWVG?=
 =?utf-8?B?VVk2aFFCY0oyeGJweWdTTkMvTUdyZmpBcW9IR1AzZlFqSU8rRXNkbE1helhn?=
 =?utf-8?B?SWpueUh0RGpFbGxBanZMSmc1dXVSOUZGUjNTQmRFQ3VWb21KdG13UmRMeDFk?=
 =?utf-8?B?SGcrVWZsS1U4dGFNaG50MnRwZ0hLNFQxUUU4OFgvWEJQVjd5Smx3Ukdka2k3?=
 =?utf-8?B?SHdYdVhMTWpSeFFDaHJ1L04xdHJ1ZGo5eitFaU95dzlQOE9vc1BneWc0ODJJ?=
 =?utf-8?B?ZXBheHNyNGNDUkpnQUtJWjhScGNBeDNCOThHS05WTTU0RFNkSyttTEdLQWRK?=
 =?utf-8?B?K0swYUczYmp2bGNPOFlCZEpMZlhRMU91MFdQcVg2VU5DbXpYUHp3cmtVVEF6?=
 =?utf-8?B?SGdUMTg4a21RMzIwVGFnUUJYVU5TcENJem5kQ0lMYkgzaXM2MW43NkZzTTBB?=
 =?utf-8?B?Z0R6UDl1QUF4MG05RFBLMjBoczJjOHdMU2RUQlZjYk0yT0p4Nis4T0kweW84?=
 =?utf-8?B?ZElsK1N1M3lQOVg4NitsZnZkUkE4WU9JbFpITnlSL2VTdVF6TTV5b3hzRW9G?=
 =?utf-8?B?MDVOU3NIakxOSWM2RU16Tmw4L3pCUkFacXpPSGVaT2t4Z0xrbjh1amE4QzRv?=
 =?utf-8?B?cnM2bTVES01MYjMxeWVBdGlZQnh3K0ZvVXQyQ0IySm82MjlUa0ZzdHR3Ky8z?=
 =?utf-8?B?RDNqOEtkelMvN2J6Mk0zV2E4VHkyR0wxNys2Y1J4a2psdjV3U0ZmNDJyVEMy?=
 =?utf-8?B?K2s3aXJLb3VzeEJXaGdodGpRb2tkTGtqTW1pbWN6YlREZi8xOUNGeWZoekFY?=
 =?utf-8?B?bDI1aDhyRXZUdG0yUDk4N3lLdFh3SEFCbXJBYlBRbWJYSnR2am9LN0FVN1pJ?=
 =?utf-8?B?MktyWVM4U01seG5GWUI5bXVueG8wWVhYWmxiOGwzWmZZSlJFejRMeEkvMHVB?=
 =?utf-8?B?NmMvczFnZFgydml4eEVpS1N1MnBlRHlDRmVLdHorekNlZk5kQjc4c0c1SDAv?=
 =?utf-8?B?QjVhdkN1L2h1SEFJMDdZVmIyZXBqdkRwWmNJZ2sxWEROTnNvTUtHY1JpQ2ho?=
 =?utf-8?Q?YXvkE5lOb00SuTs665STeAlR7CiBx30Cqtq2U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bU14c04zaWtyeTZlRU9tVFgrQmg4ajh0MUkwdjRqMU04RnJia1NtVW9ydjhw?=
 =?utf-8?B?M2FtVVdzQjQvSUlibmlvTFZNTlBYbHVSK205eXFXam1HK1dURExKckxxaC9r?=
 =?utf-8?B?U0FJSHM3YUVVdFFzZFFBM2l3SGdXbTZWODV5OWk2cGczekFQSzRXMHQxems2?=
 =?utf-8?B?Wjdydkx2MUN4NnFMUm1zZndaY0tPazRvd1l4TXhxeUZvZExRQVBMd0hGS0Y5?=
 =?utf-8?B?NTAvN3BrbG9zMTR4YmlCQ3UyTGd5VlYwK2RsM3ZBSllFL0FGbzVBVGI4bnJ2?=
 =?utf-8?B?MXFtTWNVM1dOWDZCMzlOTWdrbjNVQTdtakxXUU5kK0VISnhNUms1am0zZ25K?=
 =?utf-8?B?Z3A0T0xvdzhaaDZyNmlRZGRNVEZYNW5mNXBWMWd4amhub0JIYWkyQnNDRFV1?=
 =?utf-8?B?eGYvUDVBbm9hU2E2eHcrY1A0TWhydFh4WTM2dXMwR3VnVC8xWjhQVE14ZVZi?=
 =?utf-8?B?bjdPd29Od1hURmVCQ0xTZlpWRVFaQzRNdDVpVDFtTWY2SUxTNzh3c05VRE92?=
 =?utf-8?B?ZWx4QmFSRDg0eElBb25JMG92RC95UUdCOEs1UVlVVnlIOVpMcnJUNGkxenFy?=
 =?utf-8?B?Mk4rZ2Z5UUZHWVF6dTdqZmFpbGo2U2ZnMGpjdU9nZVl1d1R1UGw2c2lDM0E3?=
 =?utf-8?B?N1QxNS80VTRpQlZPR0VZMlFFRVlUZmpOSHlQblFCeGVOQXBsWnVHOTQwTzMx?=
 =?utf-8?B?VGFtb2hpeTQ1TEV4WDE5Y05mZFNBM3IwNU9FRE00S21HL1VnbWRYS29KUUZV?=
 =?utf-8?B?MUtDUm8vdTVOODZaakZnb2Y3SmNGNnZDN0NDK2ZOc2FzNzBKdDAxd1pUUEFi?=
 =?utf-8?B?SWFQOTBNOXhta3diaG1rZS9pU2UwSU5EK2ZxTzI2aEZuVnNQS3RXMGN3UUJW?=
 =?utf-8?B?cDZ5Wm9sOVVsK1FTWVZtd2hkZmdjQU1mTTNtK2ZieW9Dcm91bnVNMklxRzJh?=
 =?utf-8?B?V0RxbzJPL2ozeEluM251OE1wR1hxbjlpUU9seGdLMVFYdGg5a3ArZ3gwRUs3?=
 =?utf-8?B?eUxPQTlOVE5iNHJhcXJOQ2hWRXlmVWhxbVJtZUxyV1VRaURYYzBXc2NOQWhi?=
 =?utf-8?B?R0RCY0FZV3h2RVBMdzRrK1N3VE1XYkhER3A4cTRxZ1FrSnRqaW1mZmtBUkxN?=
 =?utf-8?B?K01iSUJ0MktXZGZZMG9NQWJOdjU2S0pQZ003RDVtWFByMFNvcXlXNVhtS05J?=
 =?utf-8?B?MnZDSXJDQTBZcVpYaUcvT1FIM1hBWnlkWDVUUmxhYnovVlBROHZxQVA5Y2t0?=
 =?utf-8?B?aHgyMFF6amtIejg4K0NFeTcyUGl3VWtnMUtIUmtaYzZwZlI1bVltUUFnS3NP?=
 =?utf-8?B?ajZUWjJuYVh5VExLNnc0SFBkKzNWNXpXeGxzUGlXeWErOGVZd3ptTXdPTEYx?=
 =?utf-8?B?OXlub3B6bmMrVTh5aXY4R1hvTUhvKytGMGQzSzZndC9vOVJYOFFleUJZQUxn?=
 =?utf-8?B?V1dzOHNXNEh3T1lraSs1clRKNEdoVUo0WU9vcjg3U0hLOHVKMStBTzY1Q3NQ?=
 =?utf-8?B?aHFmdzVLR3lNaGxXdGdCM0RXcCt0SitYZnFmalJrbGovK2NzY0Z2dlUyd1VV?=
 =?utf-8?B?cmNOcnR5bEt1N1Y3QUp1cWVvSVRZTzhsRGtTY1lMdWd2aDhwRnRHK2dxYkF6?=
 =?utf-8?B?K2paTVJaeUs0SjA3QUd0ZU1rakw0N25RU0dTVCswaUlWRDlGY3BmSy9MWFRD?=
 =?utf-8?B?Vk5LbDdwS1JrSm1ybDczNkxETzFETG9GVHBtU0hlZytXQlpJWVUyRU9lYnZ1?=
 =?utf-8?B?UENrbjJJTnpmUXhhQW1KeERhMlpXUjZkVGtVUDhGT0JvVjFnbmlKTUZ0V1RF?=
 =?utf-8?B?Q0lQaGZweVQwckg2d3J3eUlPeldqc09sNWpBeUZsd0RZcXBJTldFOVUvRHFn?=
 =?utf-8?B?b09jSUtnOEJXOWM2dm9aUUhLWlNYeXNCK1pKODNjaFNJN01MMFJZN3EzOFRG?=
 =?utf-8?B?S0Fnb2JoVzhrVzMrMmRxQVdRRzV1T2ptZ2grSTUvTDJzRC9yYXVmLzJLcjBu?=
 =?utf-8?B?QWtlakkvT1lGR1hUZ3dZbUlJR0dXeDFycjBCRjFIYnFJTEtwZE5aU0l2azFS?=
 =?utf-8?B?Rmx0Z2FKNVlaYS9pQmZlL2U4WmlKc3pkUXJ1eEozOGdTeXlTdjhQS0ozNWRN?=
 =?utf-8?B?SGtYYzhxQzd5OFhUWFdmQTM2eUNtSXBDbUxaQTc1TUk4MXJsU1k2SGFkWjlj?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0DF67DCFD06B843860FE33B8CD5BFB7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ukwQ7mMhQofs2EaDWZl+jbO+uJeG+iceYBg/Iu7Fm2hWHisLUXIiG3jm9eZOSnJbFeueROpildTD6pB0fIliY0mq8t+qi0oX9K5eHJT58+1pspflskn/quWZne22Rh/TYolIvKk6NYifEl4IQZIfZynk9D/W9pkGIPBVoP9QbuSA/WQfNv1nsIaIhW1YdONh0uEf6VaMjJDlatoGZJodFN6oXm+nXOSAvCpMNeEWNGOUCAavGCGwDNIwjyUPdCrXkbIYcsuQrHyzHoFCk7zPGE4DKMtuZWPkqzZRcFEx3/0AlWArPySB88lw6lCcOsc+7vUFwDZHcksqEyXYAa9Ic/lBFNRKH7+xLDZEiPxlDwzPHcfqVZ0MRxCtxB27uuZPmjHgeKs+AJwTaOqLV/Gw5gBKeACqXvA5kRlogXTQjVNXkb6q6zfo/Sjuy+uFVu/w89YPuCes7MhuncaJ8kkhoO45qGsOj5e/TbacRrTbD2l9woXZTpYdR2W4pGnNd9156FRshovWdvIic2oRAFS04S+Oktwb65bgy3Uf4youGmHLTsRXsy9OZX9NfrS/mHv10hGPMZVxahowGqUksUtp2fA/iw+MlOxWR4ZHVgZZJpBKRjqzd0yoiWRpMd60KAit
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfbc791-eb3d-4d8a-6789-08dd022bb692
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 08:34:52.6107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQexZrl98QyFXXySmcLIn37us0I0Jmp+pAMdlLYez0/V2NFjyyr2sW138uWgDw46P/5uVUCCxlbunTqLfP40kwhr3ahClGd48vyV9ATaiNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7178

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

