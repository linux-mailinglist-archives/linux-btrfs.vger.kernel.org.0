Return-Path: <linux-btrfs+bounces-19710-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A21FCBA603
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 07:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA9633051321
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 06:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56133221DB9;
	Sat, 13 Dec 2025 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="m4fEFZiz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RyewO286"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0076F2B2D7
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Dec 2025 06:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765606700; cv=fail; b=ryQUefFh58+wL5PQJ8FpSh7QPLQj9eBc/QIffqkvF6mXFsMX7husUZHaloh1ZgLsYrXbZJUsnI9TqLWTeMKxeoBStFEheaxAEzoxQZLZ6HMuOE6LZbsP8T/nTXV56/szK/ZO6sfsjfk/NxxNxGohm4Bo6+kE5gScKtu6xGjZa4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765606700; c=relaxed/simple;
	bh=v3im/p+/n7b/fNfSgax7SsqDUem2b4HHlWy1MRVKRLI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q8LTFwViaqEIZDq7Pt6iQBomGtOVIgcPCybvWeZASlyzdqPGUbe8ZvdSmqNlQKqe+9oJc4+sx5cu20EkXezF5S6EFMdry3HuPA1zG9FhmHy43b7C6XP7kyeLfhmsq+TtrKqLzOc77rDB/qMWtkO7nLcHHe3hF810843sInQ15OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=m4fEFZiz; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RyewO286; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765606698; x=1797142698;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=v3im/p+/n7b/fNfSgax7SsqDUem2b4HHlWy1MRVKRLI=;
  b=m4fEFZizhKy9VHzR0dHKpCqmIH1iBWqjJV2fTDbvTOPDlCKBLs2V51dS
   Jla3EgH1/k7QTEgF++tkXzINKLm9LjginjbGLaNfquBtb/M+G3QwYE9er
   e7Z4Yi1TM/haegLhWLwVV4b29MQ3NEd8fEOrek4y2gbEx4m3tPjuqsStZ
   KRfu5bhfD/CaJRGq+a7jczJD9BqMp2U9RySsym/9bWMYmcSKWKWrQoPcV
   J/ccagKWdb5tH4ydeDYTHcpK5nXA1oFY49fgsxqP8GdEUqABeorERTJiZ
   uFroT/zBTHxYP3BnO3dyNw7QNGf0CdYxAOhHV9qAJFZe40kDBd1Z4nNXN
   g==;
X-CSE-ConnectionGUID: oNEKtdOXSIy9u9RBcypSSg==
X-CSE-MsgGUID: Zswz+jFuS/eAC+srwWmWQA==
X-IronPort-AV: E=Sophos;i="6.21,145,1763395200"; 
   d="scan'208";a="136873536"
Received: from mail-southcentralusazon11011010.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.10])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2025 14:18:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veIF8pYzHdIuF09aGQp4bd9FC4ursA/GrPQ9pL0iGrJ6iEIpy1PyG+qduvP84F6lJ+Hj14ipyGIgVhQjPXfM758Ndn1hOal1qB8zmlpUd9wmyvOSmB2NrauyGE6F9+b1qAbfRDmw8hg2lhr8RZgAeIqiga4S6+X6srSDwl3slzySn04gUP1kUGEXO7tG6XXsr/BGGufuB2wj49buDss3UFZSXKR8kPniW4/5aGn4rq4YinkZ8OsWqp47mAm0DUR90PyKPzZ09mdZdrZVb9VW3P0vTLyt7qCLHhTebfN3+kuKsf8sEgpKyBrqZU2V9R6SgKlJWmHALyUrUNqhxfZdbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3im/p+/n7b/fNfSgax7SsqDUem2b4HHlWy1MRVKRLI=;
 b=WOtfanP5cDZXrR1HMrKwklGMgfCwHInZc9USLdItpZUQ7nQVIdtK/pU1PXk1cMnI+qhKiJun9Ny+IgeJ3NeoK4gKcI4goRb2w1yxX93RIBfVJ2L1txtzH0eVIm+nGNLh1feJIUjgMr3zR6uBkDm3zpMq5XI4/8hqh8fm1frVruyklF6MOAERPVRLjlZ6OXRpOP9XsJkbbmLUgd8kRlrPRguPJHdwzUcLz9kSwkdg7Cp7BuvcOV03MfHSAKT/OTui+uTdlv6ycAeYMz0M505Q3xU0zFuaGrAkmhpsU2gxo6j2pvh5rmBLSdgee048jUDkkxYnfLXjnhrnoItJPAWjxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3im/p+/n7b/fNfSgax7SsqDUem2b4HHlWy1MRVKRLI=;
 b=RyewO286Jpov4J/RFAeqS//rTqYA2mwHiEGdR8Y8jhXTdgRz3Bp/z2BV/cQVJ8zwZzU7M6XBq3Btz18NwFwVbnXiuMW414tqY5wkBvsViqcsNE9JSSMfyiOyur7WNnRsdOqVJup/LWfnZFZ4HM+pYfSDBIo1MP69S5kQ+JUbB0M=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by DS0PR04MB8724.namprd04.prod.outlook.com (2603:10b6:8:12d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Sat, 13 Dec
 2025 06:18:08 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9412.005; Sat, 13 Dec 2025
 06:18:08 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: Filipe Manana <fdmanana@suse.com>, Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v4 4/4] btrfs: zoned: also print stats for reclaimable
 zones
Thread-Topic: [PATCH v4 4/4] btrfs: zoned: also print stats for reclaimable
 zones
Thread-Index: AQHca+3WGPicSlMOiEGxPjslRBw+VbUfGKKA
Date: Sat, 13 Dec 2025 06:18:08 +0000
Message-ID: <bd16a4fe-3464-48fd-967e-d68e06aea4fc@wdc.com>
References: <20251213050305.10790-1-johannes.thumshirn@wdc.com>
 <20251213050305.10790-5-johannes.thumshirn@wdc.com>
In-Reply-To: <20251213050305.10790-5-johannes.thumshirn@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|DS0PR04MB8724:EE_
x-ms-office365-filtering-correlation-id: 592715f8-74d5-4fee-8680-08de3a0f629c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZjBIRjN0enI0UEs1K3UzRnlSRHgvYWNubzRkMDE0YlUxQ1BLeFJkZ0dMdjkx?=
 =?utf-8?B?M1JaWUQ2WGxqcVBNUFB0d3JvN3NDaklkcHRTbzl4dVNJekVoU3loajE5VVM3?=
 =?utf-8?B?OFJNRDZhU3lCZ0RTamEzMGV4S0ZDSjBYTFhaaVVrR0JUZzF3SGxlSjRUOWkx?=
 =?utf-8?B?dXdtOFZtcHVINlNVVnYxY2RrN2NKeEt6WTRRcU5nTy9UaUVadFo3UzNxREpG?=
 =?utf-8?B?ODViTkd4ejZOcGV2bUVKMHpZRUNnbkZiaGRFQ3kvM3BmWmJYZU1CdG91WE1a?=
 =?utf-8?B?RFZqallpN3Rlb1BMV3hSbEZkNHIyc1ZEdFJvQ2d2dkZTSnBaU1J6cVlKOFI0?=
 =?utf-8?B?MTZDTjc5cEhJQmlJc2ZxV3A4cVJHR3NOcGdtMEhzN3JtUWRIY2xyS0JYNE9N?=
 =?utf-8?B?Q3cvNU4raGoyVjNBY2ZKV1FaL2NHdUtveGtJK1hjMDI4b3QzRlBhbEVSTjYy?=
 =?utf-8?B?SVYvNVNpTXRoSXl6SElpRmJjRS9xY3dVVzNieWM0N2JaaCtvcU9OMk5ya1BK?=
 =?utf-8?B?dVJWRkpMdE1jTm1jNEJLSnZWK1V4TWlGSHlaczNxZ0FNREpXbWlrQzF4OVAy?=
 =?utf-8?B?MXlYZ1Q1eWYrVlJpcXkzZUhpcVozcmxmV2tFMnorLzR1WGFraXprNHUrQmJk?=
 =?utf-8?B?VllJMU44Z2ZFUytEM3JpbElZUHJSMmlpcERMcW8xdVU5Tmo3ZW5aR1FoMHJ5?=
 =?utf-8?B?clRRbHc2NWhXZ0NKNG4vVmI3QkNFd25oSkhVVzZxaXN4ZnU2UUJqdXpGOEpP?=
 =?utf-8?B?MWh6MHU4ak1FcnowZmlPVjcvUUhPLzErTHJ0SS84OEdqSm9GQVUxSGp1QWRj?=
 =?utf-8?B?VmxONUR3ekxQeEJMWTJuVUJmVUpZK2VoVlpFcU9Qa3dTTEdDSStUeTUvNUFl?=
 =?utf-8?B?a2FyNmRReTVrN2s2anYvUTJiZlV2dkU4YXZzSnJhRGhURkNnVVF5eWZDOG1L?=
 =?utf-8?B?QTdnSmFzNGp0ZmtFYW9ZM0U3cVJKUFF2SEpBQzJ1Z0dVenR0RHM3ZTVvcWVG?=
 =?utf-8?B?cUFHZ1BoZnZ1VXNWMWg0VHhlZUZoaVdXcDhDbkVaWlQrK1pXcHpxMEpTWmJ4?=
 =?utf-8?B?dzBiUEZEQTRuUENXMldrR0pES0lIN1ZYek16S21oakNsZStmSGdlb3JieWVa?=
 =?utf-8?B?a1hjSG9jUDcrdWFTbnd6VUMzYkQxOVdMRkNjOFVxUzB6VDlidHh4OEd3R1Bv?=
 =?utf-8?B?aDZIVk91YXY0Qnp1S1NMOStvZTg3ZnRnbGVxaUtmamlHc0pTUk5Nb0MyVVNZ?=
 =?utf-8?B?UFpmNVdCTWZoWVVPcTNjT2lZL1ZqbEtDelU3L093WGpzTDZIOXlCUG8zQTM1?=
 =?utf-8?B?ZnFlZWUxejhWSjE0eDlub2JLMFp1ZjRSVGVtdldpeWhkc2xmcVZqRVUzM25p?=
 =?utf-8?B?K01ZeURvc1FYVFFZR2dXaFY4SWQ2V2FVSi92Y0dzN205ZlJkeHZ6Z2VXV3RK?=
 =?utf-8?B?NFRSRTdxYnhaS3lDa2kvRkw2azBwc2JIMUN2WDIzM1ZRTjVaV0ZiN1lKNVln?=
 =?utf-8?B?T0RZMkQ2WURhcW9VdkVRSFNZVHduMGdEL0pCWENEKzhIS1BXUW16VVNSOU9Q?=
 =?utf-8?B?UFNVZ2N2c09UaHdBYTl2RXd4SjJ3Y1VSN3VqK2tyNzNOZm9Td3FpeG5DTGxr?=
 =?utf-8?B?OGJDZXVJQnVlTS85TDdLbnVVbE4rWUJNMUJaU0cxcTdQWlVIdllmZXdaMy9S?=
 =?utf-8?B?YVV5OFZ0QVI2L25GWUErOVg4RjByWUJ3Si9qZ2M4ODdpMnFPUDg5NDZidW9V?=
 =?utf-8?B?VVZ2S0d4clpjNG05NFVkODkvZWRuSE5FTkJPK3p0cHZsdVgxTnV2VzI4ck9Y?=
 =?utf-8?B?dUlicE1RMFphZkNFVWwxWmwrUmZZWTF3bFFGMEZLdG1TQlhPWFMyUHdaQ3Nx?=
 =?utf-8?B?SGg1dXRNYkpDVmwrRHcycTBHaEMxbUFtajhMSFdCM0NMUUpCeGlwZTlocTVs?=
 =?utf-8?B?bEZjMHhBdlpTWDA5Yis0SmJjdVpNck5xbHYzOWd5QmpkaHZNNDRlRmVqRkpY?=
 =?utf-8?B?UmFOdkxENHF0Q2NaUk5mWEhQK2NaVEFMcWQrWWZ1M3orZ1VVcmVEenhEMkxM?=
 =?utf-8?Q?CFyXbn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEdQWEJLeW5UcWNBb3ZvdGdMNlBCREswZ0xkRks5NGg4SjRtT3V5eVdobUhW?=
 =?utf-8?B?SEhOQnE0Sks3STBNMGh6czA1WWw3L1FHL09mbDI1ampMQ1Fxb1pqTXFaclRq?=
 =?utf-8?B?NDhza2h4cHpEcFhtUjdMQjR0aENaOFRXOExuYjhMNnpxaUpTWml6OCtTSTZk?=
 =?utf-8?B?cWxOejd2NHlJbEI5c3BVamdvbE9WdUNmL2VXZjgrdXJpMEt6MmhKNnpGTS9t?=
 =?utf-8?B?U1RZQVJYWG1wSmxhWTI5MUdBUDJQR2xodVF2djcyOEZrRE9XVkJBZ242OTVN?=
 =?utf-8?B?a3NHKzdxRjNBU2Ria1VmUXMvekRkdFZZRk10UWd5WEhaWFBKLzc2V0pZOEZr?=
 =?utf-8?B?OUFDVFQ4bElybUdtK3FibFlHMjdTZTBZeXhpWkFpaTJDRzdWL2F3N1R2dU0z?=
 =?utf-8?B?WjBOR2tmd3pTR3NZaE5hUU91Z01DdytuQWNEcE1lYWFsZHArKzNyQzNMRDlu?=
 =?utf-8?B?cndZODdta1hPc3JZMTM0YzNsRkxuWDc3V0V0N3JFZW4xQ2dZa3NwQmFCT0tX?=
 =?utf-8?B?WmRSU2s4NlM2Q2hiQU5PMVRMM1F3bGdKRWlkaVRWUnZ2dVJmSERVc1lOTzJw?=
 =?utf-8?B?MTB2bGRXV2lyMDgwSEpmd29GTTdhSExMQXhKVUV4MXZ4eFIwVmlkZXVDdHR1?=
 =?utf-8?B?c212aXJXdmJFcHNTUzNFS3I2dGs1aWx1UWtLMjV5eU9aYnQ5b1F0eW53RWdM?=
 =?utf-8?B?VGtRdGFaWGN0cUM5aHRmN1B5bForL3lSd0pUMS9xYVg4NXVQTXFPSWdJcGNN?=
 =?utf-8?B?bGxESjRWNXp3LzFldGRMY0dQMEN3M1JCOGV6cWxjNUNQUllqZ202SHd1RmVm?=
 =?utf-8?B?MS9INE5xODNhK3A0ckVuL0RGcXgyb2Q4WUY1M3NYOUhBd0FDcVNkVGdzOW43?=
 =?utf-8?B?VlUzTmo5Ry9ldnJhNW9TdEpMNmtKWjdOMGtJS1BhWUpjT2FEUkQ3aURkRzJV?=
 =?utf-8?B?MFpSaHp4WnNKM3lCVFNjaUZrVm9QWHlYUDlSNDF6V0pJQ2kyZnhMYlI4cldB?=
 =?utf-8?B?OGZwQm9CM1JneEpkeW92R2RSRnhrRkFQTkZKaHNoN3BINEVwUUE2Z1RDRUg5?=
 =?utf-8?B?RmdKclIrTGNmbEZhWjQ0ZkVtVVUzS29ONmtVbWVHdVhSZDNDNmRKcjVFOE5H?=
 =?utf-8?B?MmNncU5wTDF3bStNS0JObWFVL1FmUTJhVDhuUU4rMFM0Q2JIMlR2YWwzbExZ?=
 =?utf-8?B?WEFjc1IvU0lYOHNLWjE2eUo0YmN1dEhnQTlTbzVWWDhFNFdmemNCQjFua0pN?=
 =?utf-8?B?Ym8yRjdCbVJWU2NERDZEZzdNQVM0cEw2TUdGMVdUS1hVZEM3djIzcTJBQi9w?=
 =?utf-8?B?RG1vS1hYaWFFQkFaOGhOV1M1N3hKa3VxTXFGVzNnSnM4N1Bybkhla2IrWDJM?=
 =?utf-8?B?cjJyMllsKzRtUTdqTEFtakNzdlpVWjU5WS9HRTRTK0UvNjdPZEFVV2VzSkFZ?=
 =?utf-8?B?dTZPRVhqOUFLVzBPSmQ3NXVzcjUrK0JNVkpSQXJzYjR6STJHRFhiN3E0Z1NI?=
 =?utf-8?B?SmpzTXZsd3NOcGI3Uk9pZjlDL2tNZ3lMNERKMThMRmNjQlIzdDdqcEVzK25Z?=
 =?utf-8?B?OGVlbVdacGl1eWJ0ZnplYzZkTUdlVjArdHJYWjhvTUJ3NDd4OXI3ZTljMjBR?=
 =?utf-8?B?ZU9lM1lmdEVZaUpINTFmL3ZVcFJYMHpvRm5iZnU2anFqbXJIRFQ3ODlDMjR2?=
 =?utf-8?B?SXEyaDhwdHBrd2NBaGZoakFuUHBrM3pOMTdBSU9LV1ZoYnZ1eEdHWWVNcjl0?=
 =?utf-8?B?RmFZRFZRUDY4NW1rVmZ1cWUvM2FMSkV2eHZ4NlF6amgxZi9tL1l0NENCUHIr?=
 =?utf-8?B?R2pTaVFpU3ZmR0FpTHNDT2RiUnFySXZUS2RUWWRNTmJxakVnVG5GUVFwNjRL?=
 =?utf-8?B?U0NPUndoYXBrY1c2dVZhajN2dnlqS0NLcUdNRTh4Z0hzbktaTnVqeS80T3NL?=
 =?utf-8?B?RXR2bCt4QWhzYkQxRzcrdjQvbGcrWDFaaS9SZTM1dEljemttU09RamxLc2NL?=
 =?utf-8?B?d1d2b092b3BKTE5lSWpxVzIxaUZWMGFiempjaElGSGJTb0hYWmFGU3RnR2k0?=
 =?utf-8?B?QVZ2ZGFoTmdyN3hWZzQ3U1FGNnVHcnR6MXcwWTZ4UU9IdDhuQlNJQytHQTdt?=
 =?utf-8?B?azdUazFwVFpGQ2N6bldLRGJKRVBEd2lyVHZRRW9taTR0L1Z2ZEQ0QjFjeFFK?=
 =?utf-8?Q?y0P1/wQgKmli6/W/EFJOBoA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7EE7663B9F46F458F9BBE6276B20E4A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TN4DNENPA/on9G9Guq60a8EDs567mAuBgw2AHIlfo3p4Pp83NDhBr/SGa1+kR34/UfM7I+i1bvew44xesDe0llULxXYUp5U3V2IZTRoC9OuWTkqfFy6KNftGRPnhymKFcVtxaYKSkXDS+wcLaqy4dHt/a25YtzOQO1VEF83owfZPjjVbRnXlWcjmlRw79CVN1RVqmKOMptaloXiHSzC9KFfZBw2Fkw8dprGE1jG8sAD3pWC2I8CuhRRxpeReHfJ9NSz3Q9WmS9qc1ki7oOjYvyrHkkkmhn1AtMkWGN/OxaYc4UCx96TsbCCYrRna5E8gavYjHKaIdKLkfVSfU+vW9by3jZJ1szDzS2jPFpiDIjniSjCYXQvrZhze70Wy/P1RAgd4vJbS3Yvtl8skTbZKQ7RG4LVq2vr9cb5MimJqBP3x5hJY4zMDrW63oHuABRpEZWxnz3SmVPnzaC74zgm5CFWPCvT4JJSOEICvCmYbk6Myh65qU1/DfROnmiDsLkJle4G7mkc3DHeTRNwT5Fu5JBV5n7KWxy3IWD513ZnQhUfaJ4OHKjMwuxBv9Ebbf4EipffaQ0Zls4IqaOX+oOlPURwwXBC7okmoFBmHE9okDMwPGjDwaYLqDiy4gQ0JUTvV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592715f8-74d5-4fee-8680-08de3a0f629c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2025 06:18:08.6290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 97B+nmQ61ukx98sQEOVBkOXcjc8hirkMJQgvIdQTZsAyO3llo5smOHXSFGDM5eglP8ndGQWbZIU5VG2+2ixn3JhQqQQR5nOv3u3ImBeQzQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8724

T24gMTIvMTMvMjUgNjowMyBBTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiArCQkJc3Bp
bl9sb2NrKCZiZy0+bG9jayk7DQo+ICsJCQlzZXFfcHJpbnRmKHMsDQo+ICsJCQkJCSJcdCAgICBz
dGFydDogJWxsdSwgd3A6ICVsbHUgdXNlZDogJWxsdSwgcmVzZXJ2ZWQ6ICVsbHUsIHVudXNhYmxl
OiAlbGx1ICglcylcbiIsDQo+ICsJCQkJCWJnLT5zdGFydCwgYmctPmFsbG9jX29mZnNldCwgYmct
PnVzZWQsIGJnLT5yZXNlcnZlZCwNCj4gKwkJCQkJYmctPnpvbmVfdW51c2FibGUsIGJ0cmZzX3Nw
YWNlX2luZm9fdHlwZV9zdHIoYmctPnNwYWNlX2luZm8pKTsNCj4gKwkJCXNwaW5fdW5sb2NrKCZi
Zy0+bG9jayk7DQo+ICsJCX0NCj4gKwkJc3Bpbl91bmxvY2soJmZzX2luZm8tPnVudXNlZF9iZ3Nf
bG9jayk7DQoNCkhvbGRpbmcgdGhlIGJnLT5sb2NrIGFjdHVhbGx5IHdhcyBhIGJhZCBpZGVhLCBk
YXRhX3JhY2UgaXMgdGhlIGJldHRlciANCmFwcHJvYWNoIGhlcmUuDQoNCg==

