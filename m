Return-Path: <linux-btrfs+bounces-17610-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8992BCBD51
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 08:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01AA3BE5B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 06:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2125526E17A;
	Fri, 10 Oct 2025 06:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nuO3cDST";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Wep5uWnp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A6714286
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 06:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760079392; cv=fail; b=UGmJsyODHXIOT7bk200/PYY88iJjG6TC72f4xJfGaRvBUuvibk98pUzXgE+RxRYRHX07nDryqFtFm9OhRY4HFN5lDFN4ZMbWCokIAxGqLtfeCfFxF4VhrELg2t2IQ5Wo9XCrbghxInInDOdOLI5wCTOQWf8i/numj3j5Sa11Akk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760079392; c=relaxed/simple;
	bh=bddPzEsQwFl2RAXBJh4Tw8gKNyKMqg2oKVa8K0JtKB8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hWxKubgP1h29XkXqxcrjXu2H7vaY6emlybbg4NKht9wMQ5Qz3aSUDpE5vVqYaZOZgPIjN3MhBnRYUdfYwtsk0iWKnLYbMus7yvCSYCp70PjSVciOrKac0FUL+9z5T36YUc3hDk/0RSAGJ2O8A/mq3RKSgoj0W7wB5Y5lEQdJb3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nuO3cDST; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Wep5uWnp; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760079390; x=1791615390;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=bddPzEsQwFl2RAXBJh4Tw8gKNyKMqg2oKVa8K0JtKB8=;
  b=nuO3cDST/F/0BRTw5nxunQFoiTcXmlH2qc65UsDXCOZXZZWGjn0mtCXs
   bva6YS8CPDVD/vLI3+CZL2nBNXY4c/c/cwDeJuuh94Trim9ldrXiWzu8e
   a4tlVAJGypBhFJG7d/ecoQkYDBPvEkWPGfGRADBlk8D1KW6R5gd9jZqpD
   rmDIsPxT0RiDsYz8hhes9boBcZNu10cZvwzFh2UHldQbdZgZqSO1bOBqu
   0aiqvJVEQDmM6rGGbNsTl0wECmMtHDTE5SZH0sHOW72FmZyXFv9HlKXki
   L1UfpdhFNtSkQ8SrHg1i35O7q4Ofk9cOtqkpraYkLD1MowAnwVZUiCarC
   A==;
X-CSE-ConnectionGUID: W6GsiVDVR2qoM5IdHqE2sg==
X-CSE-MsgGUID: fKTbju+JS9akEEezk5mGeQ==
X-IronPort-AV: E=Sophos;i="6.19,218,1754928000"; 
   d="scan'208";a="132974893"
Received: from mail-westusazon11010024.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.24])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2025 14:56:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C21bQe0wcea2k7+WY7ZmXDhlwU0tKvvEb1Eq2ZaOU7y+zw4FwiElflNGhPo+hsUoBhPkkzGqftP8jHeY8Y+qTulru2hkJg2ldHwR5vMfBlFErv7bEtmYEdQdgScn/wQhUnxH4jSV6YFk5GIGX2sswM5T92C7D4xw7yMMXKWE/5vflNDmlGBgmWfAmweSzCuPXoz5gihq9F8IYUur8/9CIXsfyDKiYRYElxAyRrHaf1Y6EgxNzF5YF3yLYdLnAoMtUSgNtspPZVYU7nEYpPC1V7vFPl2dFb6MyWhWL1VYTMRnN9lDzAYqOpG8rPPhXzQCrY6znH9tZI4WlGrbfwQ14g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bddPzEsQwFl2RAXBJh4Tw8gKNyKMqg2oKVa8K0JtKB8=;
 b=fF4VI2u6HRITC/oqJ5qrqmRuKQFEMoOf1Q0CkC3RxhBkqYWUvjngA5yKLhKg56ELVUWgiuLegWF6/rZnwN7TU1pWA2HpVvMtlVNgAyarv5Q/DAOl0Gxvg3MXOwbjWW0pVtwfgrci2EBgazLZWY45AT+ARgaPAPYm3nsSi4ueROFTIcQCunwCPh18sw141qR3BIRDEagor56a9tIaGMdFUbSiDV9Lyr1RxHdvuFDKEeirvKxWFsiknUUar2n8zhM1/LmvsHCfnQX/P+6WJnYsDMbE7SLTfX5LMCt4kwC+ibvzEWQS60TwnGLUN4b0A5A9fvs+05Hqfqc1dg05e5SDtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bddPzEsQwFl2RAXBJh4Tw8gKNyKMqg2oKVa8K0JtKB8=;
 b=Wep5uWnpEhV1DSjMclKUyLnQ+wzF1dwVbBpuL1LIriTco81FmcIKzBIVzldI8KKC5/pv9VPC/kGBUhIJIKCf7V5/STDx/W9TYz11sEDhptdnDK6TnOtj2AezQPuK7T9OFku+Y7aFa8n/I/JG1B2FDNPPASG7c8LTd5jlQCJd+lA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH3PR04MB9037.namprd04.prod.outlook.com (2603:10b6:610:179::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 06:56:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 06:56:21 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v6 4/5] btrfs: implement shutdown ioctl
Thread-Topic: [PATCH v6 4/5] btrfs: implement shutdown ioctl
Thread-Index: AQHcOaLgoMXdHYq7eEWjSBXIfTd1ubS68rEA
Date: Fri, 10 Oct 2025 06:56:21 +0000
Message-ID: <a6cddf1f-af02-4c88-a3f7-992d546e0748@wdc.com>
References: <cover.1760069261.git.wqu@suse.com>
 <924a4b645cd2b425a7eb4a89822ff37adc02a52c.1760069261.git.wqu@suse.com>
In-Reply-To:
 <924a4b645cd2b425a7eb4a89822ff37adc02a52c.1760069261.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH3PR04MB9037:EE_
x-ms-office365-filtering-correlation-id: f950190a-fe29-40c2-da6b-08de07ca1e99
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|10070799003|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YWtnNkVFM0pUa1F4ZHViSFJWU2JqL1JheDQyVTNKSlV1bnJ1anZPWTYwby9V?=
 =?utf-8?B?RjVDaFBzR1F1VnVCZFI0cUR3b1hYSzdEbm1QTVovakZlNXpxaXJ0T0VFOEJt?=
 =?utf-8?B?eHQ1R0dQa1NQVkkwOFB1WGpWTnZ0SE5VWjdxcVJEVnJKMHZjQitHLzRKTU10?=
 =?utf-8?B?L3dQdGtER3VnZEg1dGhnQzNMOFRpVEVuWkRDbTZVaEY1cmtiT1Z2eU90eWFZ?=
 =?utf-8?B?RHJlS2hYeTBFVlh1cHZsczhmTlVkellMT05KTDlWV0dKRTYydnhpNFcvc2NH?=
 =?utf-8?B?eXJXQStaTzc5b0FLQzdsWHJYMlVZS1VETW5hcWhJOEI4VkN4RUJqRHhVSmlT?=
 =?utf-8?B?ZWFiUndKSFQydXErU0p2NWVwV3l4Z2lwcnNUM1FLUFVLS2V6NUl4Q2Jzai9z?=
 =?utf-8?B?MHB6Zi9YSDI0SERhQ25BaFhuRUVoaWlpVjdoOWRwRU1ibFZ0ZE1KTlczYWgv?=
 =?utf-8?B?aG9qQ3IxWVhkTCtKelpvRk45WGdpcEtxSTRrSXVxOUFHajBnVnNENWNXRnZK?=
 =?utf-8?B?dXJzQW05eTBlNXNpSCswaXZXdFgzbGpXNlhmNHhJZFAvN0xjVk9tOUcvUHJn?=
 =?utf-8?B?VmdaWHRBcDFtYVFoYzdwK3VoVzNQUEcwWG51c0RIN1d5Mml2bHpVc25PaEcz?=
 =?utf-8?B?RUl5WGJHd3RPK0VHQUxCNEI0djBaSHUrbkh5OXg3NTJBZ2lTR2NpQVhSK05L?=
 =?utf-8?B?dmdESnhaMWRBSHAwYndZSzZwTVFhTVhNQTd0Rys0Vis5M00xWW4wZVExaW51?=
 =?utf-8?B?aFA0V0NiVXZSalRpMitMWXAzR1VnYUkyK1F0VU5UV1VqWjcrSmplczFJRHhN?=
 =?utf-8?B?SkRkV05YVmpNR3NROU1ENXdDRlBHTzJ0eUxKaGJiSk1qeTYwREErTTNncUIw?=
 =?utf-8?B?UWdTMEpPZTRJdXhSTHpXd2YwenRCanQxY0JxaXMrVFNnMFNZZjlYZUlSZ2N4?=
 =?utf-8?B?VEwwbGlBdlAvaWNKT3pDZ1BoVUpCZnhoSTdMVzhXSzZKTzcxdzg5U2hidGll?=
 =?utf-8?B?cEk4YURHR1Q5Qk1IalhYeHhCVTBMUTFudGxEQ1l5SW8yNDBVTitvTnlTVS84?=
 =?utf-8?B?Ujc2bm94QUZkbUZDRDJkYjh1MDlRaWVLQ3ZqRzNkdi8rUDhnbzVyRzhHMVFZ?=
 =?utf-8?B?ZUIzVEsyMkp2Q1B1Q0phQjloc3hyc0lWT2M5MDc5c0lFNFFPNWo3STcvSDdX?=
 =?utf-8?B?eTZhd3hDRzZHMHZNbkF3SWlUV0JMRnhzUVptV2tQcXdrbDlwT0dWMkNLbkZr?=
 =?utf-8?B?U25YU1J0eFN1MTREcE16b0UwQ3hjakkxcVg5dHdjS1JUM3BQeXhtYTdBVTdq?=
 =?utf-8?B?a2xCTDJFSWo2c0NNZHRrcWZuZ1RFN1kzcXAvNnRYT3AwVzVodG04UU1Ld3A5?=
 =?utf-8?B?YmpHSzI5UkNRdG9tMnBOKzlwK0NES0huaTZKcTBBek90VE56T0JtYjBwUzJG?=
 =?utf-8?B?VXlXNW5JQW5LRm5YZThpcDZscUV1MjJ3OThSZlFRUlZKbFVLek8xSXlwUUY5?=
 =?utf-8?B?MVhVbC8zWDdsS2FVUXYwUGJJbDQ0M0JRNE92SkVFaWNhZGNSemEvREdvQkJz?=
 =?utf-8?B?c3A2NnNGVFkxdmt3bG90ZVgwOWtvb2lFZmJsMEVJNU9DRWFZOEJuUXJWOERt?=
 =?utf-8?B?TjdOSVhlS2pzVDZhMTQvZGc0UXk5VjAzVWdmT2R3QjdGWU0zeW9oUWMvNENZ?=
 =?utf-8?B?b0s5QVBHZDRDR0twQ3NNaVZkTFJpejY0ZlV2UUlmUW52Zm9lcGZzZ2w5U0ZB?=
 =?utf-8?B?Y0JpUi9kRkc1UTFjYUlUTXNkb2dwVnpMdlhUZ0JYZzRyZkpxSk5xMXRZZjZ1?=
 =?utf-8?B?WWZBU29nTmpEbDdRelhJUys3bHJGNzBQUk8zUFRzdjdXQmRUcHpzQzh3a3pU?=
 =?utf-8?B?VHBPRHJ1OWU3Y1dqYTNSOHpPbGgwSXIvTFlyem9VOGVaQ0tOdmN1aWthdEVN?=
 =?utf-8?B?WnVrUkc1U1dLQmRkMG5PVFU0cjFEWjc0ZDhQMks0UW9HZ2xQOTZ3OWtGc1RZ?=
 =?utf-8?B?VkxWTk5rY1J6L0dUU2JhTk13NU03TjZWNnR1M1B4Q25xVktxWWdFVEQxcnlI?=
 =?utf-8?Q?WhXJnZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2ZISkF6YlZoV0JCa3drd1UwWmcxRjRwd1d6d29hcmFDSGtnK2FSTEViOEpS?=
 =?utf-8?B?UlZhaFBaaDJiQ3lFZGplbWp5dDNtOGZqSXRpOGkzV1VtVWxRcFhLbTVZTUJI?=
 =?utf-8?B?dUQ0cDRDMFl5aHlWNmdnK1NPZUxnVzhyRURWaG5sN3djYWlYVWZKVEhyRlFi?=
 =?utf-8?B?TkFmRFNHQ1VjTzgydjIweUM3aW8yZHM3T0VOUzkzc2IvQTd4U0xmYlJJYTZw?=
 =?utf-8?B?TjY2c2FjYWhtMkhwM2REL0dsWDZkeTBtT0ZsMW1RWHgvQXdYekdFUmM3c3Bu?=
 =?utf-8?B?UTZSblpNeTZ0U3Y4elRoejdEZHFRR2FOM1JGNWNNR0ZnclU2NjN1U1RuN3lS?=
 =?utf-8?B?cWFzd0Urb1kwL1JaZGxZNzIwK1JHR1hyVnMzSHMySzBRY0Y1cGFyTmVKZUow?=
 =?utf-8?B?TzNQOEdtMnh6VWxML05GM1pXZ0NiQ25TYWR5TGU1VVR0SjVFbmEyZlEvRldX?=
 =?utf-8?B?NWh5blE4WFl5ampOSUpaWmdQV0ZCekc1SXpwcWN2bGk3dlB6OVFFcmsxL2I4?=
 =?utf-8?B?ZmVwTVpwSjFKdXZUbFpoVXMzMlROdVhoTEVhdGRlSHg5L2paa3NqdmR2TG9t?=
 =?utf-8?B?VWhZOTMyTTZnclJNa3hndE91RDFYbUVGbGRKOTArVHoyQXh5bnVjRnhjejY1?=
 =?utf-8?B?RldkbTZLMGNRUVhhaGtlRnhHbitiSHJJUlhKeWFKK3NnSGhCeXZ4RjVwTVM4?=
 =?utf-8?B?Q3JMN3dCd2JKQStYRThNclF0bC9PSDVKUGF4MGVJd0xoWUVTd3lPd3owcGlG?=
 =?utf-8?B?R3dKSmUwOFVoZExLMG1LSEpXc2FHSDRjb0hmVVQxenVPU1g3V1V3cUlHcnJ2?=
 =?utf-8?B?bWR5SEltR1NxMy9saE91b01idWw0ODU1SmRXSjFYUWhNdzl0RndGZWtoTkVD?=
 =?utf-8?B?d1VwaTZnRWZwMUN4aXZtMGRldnlmUzlya2ltOTdjZS9nOWZ1dzg1aDFDN3cv?=
 =?utf-8?B?ejgwSkxGOERKSHRRcTNtZHRiSithMnB5WXU0NkxxYmVVdWN4MmxPOHBOUkw0?=
 =?utf-8?B?WGFNQjNiM1ZEQ2pGSHQ2clpKOUYvblo3QllxQlVpZjhRVjBleGx0MHZXbTVS?=
 =?utf-8?B?MXJiMFBMTWxxbVJuTWovU29KTmtpa2R2a3RIZzhJbXdXMk9MR2JDb3lUSGcv?=
 =?utf-8?B?TmVpbWJ5QkpUQVZNTHl1WVQ3ckRzV01hdDVIemlmUExtTWZaUEplVHNsKy9R?=
 =?utf-8?B?bVArYUNVeHRla0taVkh3Zm5oZGhkSjVoUk44Qi9hZGxsejNhQkJzbVJOYnN1?=
 =?utf-8?B?U3VqRlpmTTJtV244RXUzazIvY3FkT2xNZDkvbVRaQ0Z6elh5QXVhUDFQZm12?=
 =?utf-8?B?VVBoaWNKTmNhYkpZVE9vOFNacmk2bTVlRE5VTDQybnBGVUY1QUthQXU5UEhN?=
 =?utf-8?B?Vi9CdXRQQmpnTWptbis4RTA4NVQ0d1ZyRytCSkdOT2xJc0VjRSsyczBjU0FD?=
 =?utf-8?B?V1NFQVdxMDJ1RmNoRTBHSnZrbFZBZUI0cmtYT1R5RXc5dkxQTUk0U0VmUElC?=
 =?utf-8?B?WG9yVUZxY1VZclA2WlZZZk9jK0RWVGNJU0FMQ1ArdFFKLzRNUU12UVBRU3o1?=
 =?utf-8?B?QkYraDFLTmI3bEM5U0twbWY3TUdqZHdvUi85bzVnbjI0RGRndnN5d0RWTWtt?=
 =?utf-8?B?dXlxOTJoSUhOS3dQMkhNRHl4RUVWb3pZY1ZzVE1RWTUwOGcwc1UwWm5KR2Ir?=
 =?utf-8?B?ZEpNbWYyL255MzgzWjFQZnZCek41SVh1VFRlTnJoV1dyTGdLWmN5eW1NaVoy?=
 =?utf-8?B?dVRPazJTYXI3S0RDNmNhWndpMFJlT1lMbCs0Q2FOMWVzbjBmQXU5SEpaMWpO?=
 =?utf-8?B?a0NCdkdnaU1yaThDbmVpTityampWcEd4NXdxaFB5VDlRU2ErdXQzM3ZwL1Nw?=
 =?utf-8?B?eUQ2R0lUNGRFZWZzU1ZTSW1WZEdyRkF3bjU4Sm5QL3B2c05YN3RHNCt4aFI1?=
 =?utf-8?B?S1YrT3dZblVjMWRlVTEwVVkvbFJaY0FSYTNiS0tRYTBuTXBqT3piMnRibllr?=
 =?utf-8?B?aVh1aktQM09LckpzS3BuOUdVNWxRVmMyR2RUUHZldWNtaFNXYk1pVDBQZjcy?=
 =?utf-8?B?ekt5VGdCbUZzSlBBUEhhVFRib09FcVJmb0FLWFlmaHJpRWRxN2tPZCtlYXBm?=
 =?utf-8?B?a2NneGxqLzFhcno1TjlFZDZ2bnJoVDhIN0F5S0pCY0hUaWMzNW5abXBpYWhj?=
 =?utf-8?B?NVc3NGN2amlLeU1uOGc0R2VGZUtVazRUKzdZK21GU0xXZFJwR1F2UkJtWFRY?=
 =?utf-8?B?WWZEMlF4UTN3dDYxTldCNzFDdCt3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE57B7571A3D704FA6D0D73D06561745@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Cp1nTGfpuBktI9A0+y2BuSLtqE+1XoF2H484pCb8DYgCpvNczyXs64At73/vc9BcUFnDMpgNAtm7OSDV7Z7kpW5Mp5540WzSYdDmk3Vll18fVmX9RvE35ElRgXdnR6+TA81QuuvO7ZiN3WUlgx5fAk1IjWX2OQZxbIFoVTY2OeCWaU+pRqXn4xqTj5Qv57ANcKzhopqUAYXbV6W7dVvWLzIEPmQFpb7U2m1lUdhrkhen/vXCrHmX+uA7ZM3eLOXvCjHWDZsPpfGa1ujAJodE732U3wnzu8DiPCPQ8HB7zsRKqMqyisCkay+Ci1z4jMXkJOC9VZa7pzsXHrprA1QqBrdtTS+R6uhdW7Q893vArP3rLdwT+4VzPmlq6yIR4ypkJab/a1fBwrC8Xds+TqWZ7ITiyW1Lz4AWrnE4od58i4gpY1PKBzJRVhV3wWSVI6b6eXMc17Iss1lkamMp0CxNuM57veixOp02KSUNjBrEe1LETESm+Yn8toHYEY81I0GWZ0VZlnfSEopMiHI4sAWo0nHzjZDNRVOfVF2GldKNiCJvn8xHbMWLrwRA4fsaafVvp7F5RXhJZHuTdg3swa1Qp1yCS5KymPwtuL5W943xCT5vi3c6WVXQ9WP3Np0d65sj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f950190a-fe29-40c2-da6b-08de07ca1e99
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 06:56:21.1278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 97b9qgxyAyscIZ9mCU0SA/Bqe7rFcMKAKGodGWutreOj6S0ixZiDOphq7toqifkxg897yblZpiClwFg1r6idHtsF7TdDktnIYFPv+5JX2Lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB9037

T24gMTAvMTAvMjUgNzowMSBBTSwgUXUgV2VucnVvIHdyb3RlOg0KPiBAQCAtMTIyMCw2ICsxMjI2
LDkgQEAgZW51bSBidHJmc19lcnJfY29kZSB7DQo+ICAgI2RlZmluZSBCVFJGU19JT0NfU1VCVk9M
X1NZTkNfV0FJVCBfSU9XKEJUUkZTX0lPQ1RMX01BR0lDLCA2NSwgXA0KPiAgIAkJCQkJc3RydWN0
IGJ0cmZzX2lvY3RsX3N1YnZvbF93YWl0KQ0KPiAgIA0KPiArLyogU2h1dGRvd24gaW9jdGwgc2hv
dWxkIGZvbGxvdyBYRlMncyBpbnRlcmZhY2VzLCB0aHVzIG5vdCB1c2luZyBidHJmcyBtYWdpYy4g
Ki8NCj4gKyNkZWZpbmUgQlRSRlNfSU9DX1NIVVRET1dOCV9JT1IoJ1gnLCAxMjUsIHVpbnQzMl90
KQ0KPiArDQoNClNvdW5kcyBsaWtlIHdlIHdhbnQgdG8gaGF2ZSBzb21ldGhpbmcgaW4gVkZTIGZv
ciBzaHV0ZG93bi4NCg0KDQpPdGhlciB0aGFuIHRoYXQsDQoNClJldmlld2VkLWJ5OiBKb2hhbm5l
cyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KDQo=

