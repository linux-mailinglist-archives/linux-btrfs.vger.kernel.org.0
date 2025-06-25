Return-Path: <linux-btrfs+bounces-14959-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D29AE898E
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 18:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854E44C035F
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 16:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FB52D1F72;
	Wed, 25 Jun 2025 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BbTfiJR0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RfN9oacm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEF82D191F
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868298; cv=fail; b=hJ0yB5hVZ4F2GKXrpzpXALEIxD/Aj2IBuXR3fKGykcz3lNutD0pQi7q0C3s7XDBvlmdcoHzllGGU5ZHnbfL6PbmNHjUh508QEwTGaQaG4+1KT5HyADe82+3vIbh37pwwXdtAJx4TzSa9OOaUgDTVRzrxkGUm5a8Bl7oF1E1a+EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868298; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E3mOQWIJ/+wF2VB9HWGNstpUpp7AomweixHNv6ysIKE8x5V+YMU4YIeIQjRlXXzUkItOrITsqte/rF09SGI8+7yiBLxHz18DdPwxpl5zPNCsTwaxtcIiVaFnhbldO748FFBPQGYrInj6D01E1losyM8rc9Tv3LquavvjLkOyj9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BbTfiJR0; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RfN9oacm; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750868297; x=1782404297;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=BbTfiJR03FlBPRer9EmkwdBi3gJEfX3OcijJ7ogoQUMCYvSMydgeiEex
   2ZCJD0TW99fC4PB7naUrvDIScWN9djReBJwFbX2BwV7mGVfuRsL4j6B7g
   HIpDvD2g16S2xMpaYAftj49QdUm2pokyoa3S8mvB7Wqkdgkk76/tsk9bt
   MsMcHXNeXsWv1SKbRgkHEKc8I1Kx+7pD1ZCBW7RFxZrxxfrzEn9W/8uP/
   S0ZdkQH1F8YtqBTXKLMv6nD3UkHAaOhrnLFyKuttW7hC5cANWUm/PfbGB
   u5vAFGoNwqypmiZgEo+Qx7u/ZSsWg/B94A0MvOBoZmQoVl/HLzsgnIW4y
   w==;
X-CSE-ConnectionGUID: 9HCr5IOJSx+hYjJmkdzEVw==
X-CSE-MsgGUID: BMsIxLVJQiS69LW0Kv+ZMg==
X-IronPort-AV: E=Sophos;i="6.16,265,1744041600"; 
   d="scan'208";a="85969741"
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.40])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2025 00:18:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUUK6phn3Ois6gOGqBEUU94P2pcFPqcOnjmxbTUJHyasV9GY/2xLvYeYhHMsHCXU2If6WzGb9tIwIVedhdBI76dOjpKeUtC9qdPuOTPsT2Oyf6lbizZyRNTqZs5nFJu6bPfzfJYis+mDbud5p8wbdOv3px+ojJEho7ibkPTZfBVAtJGQuZeNjGXhOxFvT3EvAXMwYy1yzXG6NAyYpOSvWQJuQto53FUBaY5wz05SzltzniMtLAT6rjMZG4NR8Pd4824QUxy02LrQ9daeOIeO5XqTBCoKCqFZ0t7arTpYKe+QTyDnqsPIeob2i8AHTZ53+ftyu0jpZxwy0srooJBxFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=QMlg/L36llUhEBxl5r+RKG/vGb2I22V4IWlYQfvDhnxPj6IarNoh3h7EC04p7I5+dG2uhvEpooE+XE2CRs6vQ9FH9oit68phC5UYFprXTz0Ef+Lh3wwIB4u+4pRwJX6FTjFCAIauM4TsOkHN1/0TxKTXRnESapc/nMwJzY8Kyuv+vt5+WHNElHyaMQJc7AskkE2XaZU/OowHKoYUoBLONqkXm4HeEdvqKC3XFRmZ2LLO/sG4F0Gyxuw3NMfoIvihys51XgZMYSC0yOp62xFbarbh/sw1REIXE0hxSQ+UfT/dn67y1ivOI/CI2/KgP5gVmoD/ZL4uP+a2VwwKgMgAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=RfN9oacmHin1quVJeJlEfM1Z2AjRyiNP0tkYnJeEdMn2oWEu1VTeoZ/ijmcFiXy5MTHakuw6FyjbwIm+WpgT5RhmCbBX5KFjFC5HjFv0waT+LoKpzlBnW6qzM0LMed0LJYN55exNcjXbT04YFC4AhAEqcdLzy1QpgD1CVFAX0es=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7368.namprd04.prod.outlook.com (2603:10b6:510:1d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 25 Jun
 2025 16:18:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 16:18:13 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: qgroup: remove redundant check for add_qgroup_rb()
 call
Thread-Topic: [PATCH] btrfs: qgroup: remove redundant check for
 add_qgroup_rb() call
Thread-Index: AQHb5esx/GuP3RN+OU6GZloCRj4g8LQUDamA
Date: Wed, 25 Jun 2025 16:18:13 +0000
Message-ID: <667c4145-763f-4990-ae54-5e843383d0e7@wdc.com>
References:
 <4017a6e8b1a7b5a839f0552916cc2c281286210a.1750867517.git.fdmanana@suse.com>
In-Reply-To:
 <4017a6e8b1a7b5a839f0552916cc2c281286210a.1750867517.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7368:EE_
x-ms-office365-filtering-correlation-id: 365a28a3-9d1f-42ac-35ab-08ddb403e288
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eStValdWOUtSVzk3bWlyd3BnRVM1U3ovWEdtUXNNei9mbGorUFFPeGxRUmpa?=
 =?utf-8?B?cXdraGUxb0w2MUZhWnE4a3R0RklDSkhlU0dkZDdYNGd5ek1WN3VHaWVWSHJY?=
 =?utf-8?B?cVlpUWZBeTNGeU0vWWUvbWhBaGpjWXZSUFRjZllYWUN0M1IwS3AxMzlOaVJ6?=
 =?utf-8?B?S1BwTzd5cGhYMTk4NkYxam5xd1V2UEpvd1dHN0xDY2ZIV2gyWXBpM1J5Vk9s?=
 =?utf-8?B?MHZJNTFLSEx3YVdJcGNnU1gvbXZELzVnTXNtcEpTaDJWRjNUeXVBZmM2WmVn?=
 =?utf-8?B?WXpNQ0g2TDUwS3dldFJuZnNRVWRoU1htSGtKd3Z2QkZlVXlWajB5dWlMYWNt?=
 =?utf-8?B?empJTFduMUtjSXZJbk9zeDloaHBUcjVQajhPNnNZVHU5WUtnd3NYUXlxQ0Zv?=
 =?utf-8?B?OGxWR3FIVmdkRFJzcUgzaHV2blgrbDNQVnVwTTMxOVdKL3ZXbWJBM3QvTU1l?=
 =?utf-8?B?VHVGcEtBZ0l1ZEpiQkprSk5EN0F5MUhySTZBQjE3WWJNYW83WXI4ZE9GaGsw?=
 =?utf-8?B?MlVlT2VCSGFxcXNhQldHNE9YNGdqS05XbGZURGdCNXpVYi83SS9SbU5HVFcv?=
 =?utf-8?B?c0hUWmEvL09CUmtSNWZiRWk4eG1Ha3lZUEppVHc5c0s0cTUyRmVkTkxhK2w1?=
 =?utf-8?B?ejVML1loVHRMb3lnRjQ3eTRCQVVWeWk0UlNLVnFXSUZDMHJMVkhUQ3hUNzVz?=
 =?utf-8?B?TW5LZm44NUorb01iaThISXJuejhlNVVWODFDcnhZL0UvemRIZzNBTTBJblJJ?=
 =?utf-8?B?bHljb3llVkIrb0t4UTBQVmNzZDduYmI2YTRQNEVONEp1YTBIWUU1R1RtdkVv?=
 =?utf-8?B?S0Rqb2xmMXFORTZYVTBvZDUwNEVGLzl0WXBOemNKZlNSY25EcVFjczlSeHNz?=
 =?utf-8?B?UTJOazZnM0RFQkFpSVBSNWV5L2hGVFpIc1BYV09Rb0Nsc0Z4Q3NQYmtqT0ZY?=
 =?utf-8?B?dGRueW5GNlpPOERiRSs4UWowWXVxNE1zSjRZa3hYZC9leW9nMzNPZnAxZWJ5?=
 =?utf-8?B?blBNdktZd0FPUE5ndkd2cTVFS2kxamFlbzBGWEp1UFNUYXFBb1BDTVFKY1hj?=
 =?utf-8?B?b2JReTBQYjVmc3prT1UzcVc4aEFqNXJDbVZNWlM5MHdQcE81M2llcWVJeHAz?=
 =?utf-8?B?LzAxZnQ5cHJIQXh6M01PTk1ZcXFTY0M1UzZjd3ZVdGtHbWtBMlFwNUhpNnlT?=
 =?utf-8?B?RTMzaDJWc3VveGxYeVdOcHlkczdRSGtmV3FIT3YyblQ5Z2tveFhrSUgwT1g4?=
 =?utf-8?B?YTNlMUxFZGZtRVhzWVlPRHVtS0dEMGRUWUg5Wi96ODZPd1cyUFphbmF5RjhF?=
 =?utf-8?B?UXY4VWcrQTBGbVZzTnVUd2tiZE5PWlBnL2hkTlN3UXcyUE1SMExaZGVNZFZW?=
 =?utf-8?B?VEczaTUxUFVQU09naWphUHZ4YjNERFNwSkFBVXdUWnY2c1hwQ2RuMXlseUVB?=
 =?utf-8?B?TGRNTmFUZnNkRXdwVXo2KytPbyt6RHBsWXRVekZlb0xuK2M4RG96SVFzTDR3?=
 =?utf-8?B?WEw0QjV1eUd5MTR6cFBiMVJRdkJ0SWprMDkrblNwTGtFaUV3QnpBcEJBZmw3?=
 =?utf-8?B?cHJ5N1EzTFBVUEFKWVl5NTBCc3R6Wkc5SUU1UHBvM0lQb25lbFZtVHQ5bUNL?=
 =?utf-8?B?eThGNXY5bGFORGM5ODc3SDJCYUVPK2ZBZENmVzlXT1RBYUI0aytiM2lhMnNK?=
 =?utf-8?B?MlhjTjhUR3lSQmF1SlJFdkVRMVlOMVZ0L1BIY2xsZUJpbng2N245S1dsNlVa?=
 =?utf-8?B?R2FlenZKejJoN0hDa1VFaE93aG03QndqaHV3UkVsaG9CRVR6WTBQamZBanQ2?=
 =?utf-8?B?dHU4TDM4YlNKT3h0L1ZRU29RZ21lNHQ0RVFVbHdoeUlqU2NFeWxiSldqNnFq?=
 =?utf-8?B?Q3BNOUx4emRHTjBLeWs1Y1oxeDBNUmxKOGUrZzdwZ05jWjZHMGN6eHQ1eEdB?=
 =?utf-8?B?eVBZVnhnUEoxTVdjbUV3M040WnRkZHR6R1VrTVlsQmhrMHdTSTlaZ2t3dE9p?=
 =?utf-8?Q?CQg41TzGbnMrybI3nWWTc//t9WfJnc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dTlPV3pHdVI2MU9iNEZJSFowSGowM0luSml2WmVMVzJNMkw1SldqUlE1Q2Fw?=
 =?utf-8?B?TkxJVDJ2V0VGVVdxOXZrRmtQUTJOcTFDWFExTXBuL2dvcEJaZnVGaFZhaXJt?=
 =?utf-8?B?ckNRNUJqOVowU0VIWjdBaVp4eVhReWUzb1dVUk54bTdDV2U2dmlRZkJ2NnRs?=
 =?utf-8?B?ektzcnVYNEJGQjBtMXdaV2ZUdUpRcGJGcXFoTmd5WDM0bk50dkV5ZFl4a1JF?=
 =?utf-8?B?VzVpR1RKbnI2TmhGdUcrK3k5MmFXR29adEJZRHIwNmpabEZWQXhtVlNCSk9Y?=
 =?utf-8?B?UU5Rc1V0R1l5dStjd1JWQWNOamx1ZzQzbXpXcldqUTlzOHhmUmYvYklJV0sz?=
 =?utf-8?B?N2lDdzNPRDlmOWxxL3RoaEJiNXZqeG9NaVdCaEdONnh1VkN5MlFYMW5OWU9T?=
 =?utf-8?B?SllRTXcySXVLQWRzS2dCRmMwYmxpNXBYTmRYT1dFR3NsWHRkZTJ5RlFyeS84?=
 =?utf-8?B?Z2hIY3BKaEx4UGdaaGV4QkdtTnQ5azduRm95bjlsclNEOUVmelg5eWZINHBC?=
 =?utf-8?B?RXRWQlJxTUVKN0Z4R001eXh4UDlhUWhEa2NTU1p6Q2FRanZmRmFLQU5VdG9P?=
 =?utf-8?B?TVdzU2E0M3NiQjdKMlJPQ3g4a1pGUjFOMVhjNjNRdnFaUFArSmZWVjdxL2Np?=
 =?utf-8?B?VG4wWjlwNzJvYnZsY0k1b0Q2OVh4b3BxVGszMmxCaXJ6eWJid3pXQWphb2g5?=
 =?utf-8?B?d3VXODZ6ZWlZM3pySkFVd09KejMyUXVNVHBheHFGZktINTVhY0l0T0hienlk?=
 =?utf-8?B?a0ZyZFVCbDRVMjlCNThhWU1YRmJMdmNWQzZ6RzdhYi95TUJRLzlBcW56d0F1?=
 =?utf-8?B?S3hqSkhTUlpHWlMreFFBNHk4MVpWaXlpek5JYnA3a21pNG5KRERPamp5N2s0?=
 =?utf-8?B?eE1WRlJCUFhlRlJCRXBFZUdpUXRBQlpOWEN0dlU3eFZKQ2FvampkU0FuVlRx?=
 =?utf-8?B?MmdoSEJDKy85NTFkN2x4Tmd5R3k5VEpHWTlabmFHUWwrVDVoTTYxalNjUU1x?=
 =?utf-8?B?dFhtTThFN2JwRmYydWxZYXp5aVZDOHpDNGUzREtuR0ZzMlV3eEZhTFdPd0Zu?=
 =?utf-8?B?d1FQTmhCUmlnZXFTRlVyNkVGNmhiOXpvSGxxM0hacjlUckVucFlSc2JpcWgw?=
 =?utf-8?B?THNCTWhndmFTNnU1ZmIyc3VkSG5CSE5GelYrSnNybTFpUU5qY05pdmo5OE9u?=
 =?utf-8?B?cDZMRlNpSngvT3FpTlBiVmxJc1lXc1BhaTQveE0wcDhoUk8vejhRR0lOTDEv?=
 =?utf-8?B?YlFsM0dyMHUrKy82aGFta3BIamtaVU9SOTRRdDZmN1dTQklzNFBIWUlDM2Vu?=
 =?utf-8?B?ZVhMZVk1SS9iM0VYMXJJYm40WGJMRUQ3b0xZTHZvZkNqcG9NSElXK1hqWUlr?=
 =?utf-8?B?aWJhM3dkT1pqR3pGU1FSR3lveEtGRHRCYi9wOU93c0lMSHdkMmZtekRXMlUz?=
 =?utf-8?B?ZWY0N01hd1RLWHhYajZjYlBpN0VzVGJhU2JLYUdMZzJzZ2ZRWGZFSUFWVnFs?=
 =?utf-8?B?a2piNjIxVWJaM09Ua2RtaEE0YUFZN1NZWHhmZ21jQmNlcFVReFVyRVpteE16?=
 =?utf-8?B?SVE4SEd0d3B1U0RLVTlvbFdyc0JwZmVMWHNPMmhnOU9JOERtRXdkVUkzTXF3?=
 =?utf-8?B?WjhkS1RjWDVVMjBWUElEQ0J0ZU9FenN2cHI5TXBiR1BGS09VakZ4K2d1ZXNY?=
 =?utf-8?B?OU1ISUVrWTlOUUxhRlExRDR2UkhhcGZ1dWdxekFqRG1BZUx6VzhQUUwwc1hR?=
 =?utf-8?B?bytDazU0eHl3YjZTRmFEa25KTWxMdEpFam4xU2dJdG5vK3RUOHZ0eVlDZkdW?=
 =?utf-8?B?eUlJTSt2RjFCSzY1a2FUVGlIYjdhSVdGWktpcnIzTFFBd0lmYnJvc3A1cmRi?=
 =?utf-8?B?ZDl3dHdmWUZoeGVVNGVRNDBCZGY2bWdMUFhyWmZQbjlIWFJVazVtckp3K3Fh?=
 =?utf-8?B?U205YTRINVhUWWNsYmxKcHo0VFRsZm9Ma0t4N0lpSkpKZk8zb0VaU1ltRzZT?=
 =?utf-8?B?K2hianl1dWJCMzRnZEdLVzU0Wjk5d1NycUE1VGNnMkM2UUhENkNXWmJPTW10?=
 =?utf-8?B?cEM5NXF0M2txMFFNaGVkQkkyem5kUUxFdzA1T2JQd29yQkRaVWVCQ0ZlbUpC?=
 =?utf-8?B?WU5nZUo3czEzWE9BZ0xxbEE4UnRGcGxSc0tUQ3paMXBCelF5VXZNV3pldHFF?=
 =?utf-8?Q?IIwyw8Lpes5L3XLReOve6Rw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A17649F3A532C45BE49428252668B4A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i5jg4w+YkqczsZDqK9WjRV49J1TmCT0b8h0BS5E9GGw3gcu/wfbHI2FxU6A1jXd3o/ePttBqI1nnnqnCw0D0hblKJ6xSwRGqgZ65wy18OKmJVnm8EkaTuCjAYNLfQy6OE9Ubp/Cbo8Qs2MJsx7UbzhzdyLHjv3nUu8SK5H7I6z8eKUnnSp8iQ6TWK3rKyDQCbsbq2Jv8Fl9jc1Nega4nwR8X3WP5IxgKQZcooDm4CKQnVqTuBwMpvc0s7cMU2J9soLC80hUKmsQBObFfRbVT4Rr2bJ9VRHtG0UKfqdbF69jNpYsMrT2gTxx0UGw2lVwkkhhnaAwlJNHoJEH2AOVxv4Z2a3JOR8KVngN6KRG8dh/fXmsP5iCy2ZB386qxJ/r/F5cTjnbj10Ob2pEaQmvgKL4t01nIyWEd+0MV9rUmhYrvsqEUcz6svAO4tjdlqI7giJUW8eZsBmkUQqyKd4dFzjZR5pyWBOkcNS5YvvwFUzEQpyOMd3/BUY3qpsmccrGbHGJUGdetV66YWmGMR7Wq3Guu0YkZ6ZcirLCW7Z3VF6EGD+dgAOxRwfeq7pva9Knee8H6StQyTAWGNeujVPk3yoDUm6kfPvqR0wu5mr1sR84XHi/F7V8VtBi5oYCUS7jI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365a28a3-9d1f-42ac-35ab-08ddb403e288
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 16:18:13.4328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: taUq1GcB5WE7AyysI4lUhu+i5ORpAJLKwpdTvO4l5WA7sV205JurwUf0Milj1g/UpfPJ678E6e82pKQ+dxrpG4G9P9EapS0ubmCmE0PFAPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7368

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

