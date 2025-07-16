Return-Path: <linux-btrfs+bounces-15526-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD3FB07343
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 12:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CE9160AC7
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 10:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56732F2C56;
	Wed, 16 Jul 2025 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="m8+otfWv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eVJL1aVB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EA72F2C7E
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661340; cv=fail; b=EP0Ddo/k3ECSheTASket0i0e4HPW8MWAGS/KbtdDQZXsUIPDJ9SQOa9+x7twAOkEEOuxquiVjzVwsUbGigPQFSaYFDUu98jsNKfJ9wwtuSo0vvbsTgQmfJBF/yLVGyneCKPZXLu7KuLERVocRWrR69rM4qDdsRUbaxpfvXFejx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661340; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JgMCisK8cSI15Aaf50652FATopj3dAGmshcPQSL/3YP6WD24Dcnco7ds591npGs5H/VbosO4EnYIbF1fQ34uY43e20NQIiLsOzWfMSSkEL2yq2zDGVL4WXkvqC3uJHBDkY3OwT3QDxxtMfIvqPs77oi96D9sgvyjWyIxhdxAwnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=m8+otfWv; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=eVJL1aVB; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752661339; x=1784197339;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=m8+otfWvFHNkEchQXnLou10QdWjkNjJcDzzE9ZyfOWj72BSZXcvoQpDw
   SsbsifAZw4r3VvWtrJIwtG/PrZHFUmBmFJFXV/lncN/fmkn64JTSKwQKs
   QNnXWqs+Ej7UQAJ/cFG3s7IlENGQ9zsd6AtKY4voxaZw5XEd4amkrCarh
   l2NoOEkQf26a1JEN22vwJw55VZ7jTfmeDwJV6eRb4MRkv8zQpkf8YZ7lC
   FfO+fkJI9AZEdK1YE5YOx6659xS5Nbor7b++8aYToJN9A0Wzh+zW5vqWK
   QAY2s44eIPgUfBp/Y4vpRyA78i/hI9EjI3gjYUbr9E+4+KkFxEdZ87m5+
   g==;
X-CSE-ConnectionGUID: tWK3R/MKRB6o8s57QwhiCA==
X-CSE-MsgGUID: ngmhB3gZR8exZTA9YLUFaQ==
X-IronPort-AV: E=Sophos;i="6.16,315,1744041600"; 
   d="scan'208";a="88250944"
Received: from mail-westcentralusazon11013039.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.39])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2025 18:22:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKeI3mFPCi2k9IskE3siq8/P/qAx9ATvLYfhCehy2knsHPDM14loriod6cR8Ckpwgx9IZWQyEGXQmO3GFVd0X5iAPEG079E3p5YIIrxutvU3nZ4WpAdp4W9dTPZGKstCfySoBve5U+B9HGKS8WcnA1+BTAtDvX9KpZHj5qGCwLySJ3ncatkqSGzMU57ts2+WhWIPMgJItT/7dyeqhNT8bbyfmMEJL2DkR0WWK5AeFvYuYRII9pBc1BuCgBGHlXGpNyfWh2oGfpTz+NCGu8sMRErY++5BLM+lRzWRm9Zw1Ch5DtXBUydd4IH6EMTQGvJEkp28NqzReZbyD/tMv8kE/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ypvIWnPf0J4rCNQKlO8oDEHsKQZ9HTPhSiLaSoIgXxRZgP2gmJk/BHSrsx0IKtRWVoWNay6AUlO6HJk1HeXGTLVVhLM38XB4V1qVU0FZykCeAPbbZk5Zh8HBQlGikp6/rgu5iXO93Zst5PitG7rmGQJqSyNDRB0+FEXJf2mvXQbhqLeK/LW/rJJoiWvvj8s5FZUeKkmYfC4qbyTg2BFSKgv8TvQJWvQeZY/TOHMPXCooyj1RunNRoRCYPWH+jNXlmcDHpPiroDxK+yE7LgEpC1+4MOWA09CY90LmQVOUcDNKmQlNpA9z1NY6fJVQ6f1H229ziqakIf32jVRp4JQfoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=eVJL1aVB9XX0DBLfo8Ihpgl+UHl4ABFYy5OwnRk70qecOvHUQT75/GSfE3VMnnYTe50QBOHqlvCnHJ0WnCZBVAfqU3eqENT05ZLDwwRVA8fr5Ey1zgFrOxlGrE7LJmcxvlYoi3fVCO9bW2G4IEI9qEfNpJb60zp532C8EPXgLM4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7249.namprd04.prod.outlook.com (2603:10b6:303:78::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 10:22:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 10:22:12 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] btrfs: zoned: fix data relocation block group
 reservation
Thread-Topic: [PATCH v3 2/4] btrfs: zoned: fix data relocation block group
 reservation
Thread-Index: AQHb9ie5S7L9mOAMe0iOahRIFPKBxbQ0iquA
Date: Wed, 16 Jul 2025 10:22:12 +0000
Message-ID: <cf98aeaf-bebf-4946-a6b2-c1d664730d97@wdc.com>
References: <cover.1752652539.git.naohiro.aota@wdc.com>
 <7547a992a03414e821fd3093ba7a6d281140e6d0.1752652539.git.naohiro.aota@wdc.com>
In-Reply-To:
 <7547a992a03414e821fd3093ba7a6d281140e6d0.1752652539.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7249:EE_
x-ms-office365-filtering-correlation-id: 8ebde89d-b99c-44c8-face-08ddc452a0ef
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VjQ3UkRoMFhxaG9hMHBKL0JzMFBzQXJHRWxuMHl1MmdlRDhYSEhrRGp5Q1Qv?=
 =?utf-8?B?RWNYSzBNZ1UxS2hxK0tCTjYzVHZ2Z3Qwem5ybGhHNzRNcFgyOUxuc2UzZmtl?=
 =?utf-8?B?K2dmVEhRTnZLYWFJZnEyL1pzbXp0MlF4TW1QbFloelV4WVZpMTVIRHdkQmNU?=
 =?utf-8?B?Z2ZMZ1Y5enVyTnFWUENLTmNSOXFwSlZkNmtvUytUVUpMTXJQdUZ3TitrZ3o2?=
 =?utf-8?B?dmJzR09iZ1FnQmxackJYalQyaWFVc093K290U2Y3dWN1MGx1Tk0rSWVGZDlG?=
 =?utf-8?B?Z0tkSFNVMTRUWE4zZjlvQkJEUmxVMm9mNzJzR0lnWFZ4T2E0QUxMTHlEZGpQ?=
 =?utf-8?B?VjJlMVZzUmQ1Y1J0TkVEL25MYm1idjdlcGh0QlRRODFvVnVqazI5bXUyRGZU?=
 =?utf-8?B?cnRROHdwQWN5NTc5akhseGt2dDU1cFhlaU5KMHVPc0ZjajZhN2FYR1FVVEcz?=
 =?utf-8?B?Q0E3amRTTjRNMlNSTjlYVE5iMHNVanJjR3o3bkhtNktyaUhGZUlzNkN1bmY3?=
 =?utf-8?B?UE85eVc0TnRXelBkdkk1YWZxK1JocWFBa0dlQnBCMGc5REh2SHluT09FU2lH?=
 =?utf-8?B?eElXTlNKaW9ZVGt6TWdSMDZwS3FaSUtKL3lJSndHUVNRY2pRa1FwMWhuby81?=
 =?utf-8?B?K3pmZ2o0NU1yTGVSTlUrLzRsTGRWWkh0MXk1SXM2bjdwZ0o5Q00zd1VVQm51?=
 =?utf-8?B?enB0bGxCT1BFOXQ4cWpkNnVOZzZlTDV1cG5NTXJqZ3N2UkhGc0M0Q2hob1hQ?=
 =?utf-8?B?cEtGeXZUeGdJbVRKNFFSWmpIMk8vMFFqdDdoV1dWVWpWcWtMS3d4dHJpOUth?=
 =?utf-8?B?d3hhUlZtTkhEaytDZ3VHR09jY0kwOHU5TkRvcTNDME51THlvNGZSWVpLUVh2?=
 =?utf-8?B?ME5CdUpZNTZhMnpXTWpmdERKL3hLcVZ1SmpGcmJvNTZnUmVvdEx4bVZQTkxC?=
 =?utf-8?B?bW0xRk1PUW54dHBmc0I5UFNDWW9OMDlYaEZpVFlzT1BNS1ZzMXl5VlJmMzJG?=
 =?utf-8?B?WVFWTXkwNXdDTUZKY3RZenpXSW9jWjdOc0pkVERHa3NZa2xoOW43cVA2aEJL?=
 =?utf-8?B?T3dOR1BrZ2V0UklkZG5Ib1duSWNNTmh3d1lBbFFxSkxpZ1V3SE9BUTZuVktQ?=
 =?utf-8?B?Vm0zZERjeDRIY0ZxUmpSdVpJeTEyRUd6bmdXd2FGQ0hLNFR3S2NYRm1EUVBw?=
 =?utf-8?B?Sm1qZ1ZCVUp6Z0MrNTVxUHlzMExhWlpKVE9TSUcyMVBpNWdrbW04UUE2WDdz?=
 =?utf-8?B?Wi92ZENJYTR2aFFmaTEybVZ1aUtVcDBwZm4vQ1daMkFhbzF4T2VhT1hndFBt?=
 =?utf-8?B?cnNBODZiYWZLekNQYzAzR25DMUZwR0t2cTlQSGw4QTVIVFh5QnpUM3NkYmJ1?=
 =?utf-8?B?enZpTEtCY0F6U0hNa21Ba3YrOTJMN0g0Z0tQTFhGd0FhYVVLSCtWd29kNjRF?=
 =?utf-8?B?eHB3OU5ZSnlQc3NDYnB4RDRCNnprRzE5VEdjSnJ4cXhtWXZtVHV1cHp4STdD?=
 =?utf-8?B?dnRTaWV4aGEvOTRMNHdWeFhyZUxMYUlIK0pSSkFPOXRQMG9kVm51YktQczBC?=
 =?utf-8?B?TUduSU9DU2xISjU5cFR3WHZkTVV4SjA1czlZSThhK3BFSkZ3eEh6aU9XL2Ev?=
 =?utf-8?B?TFZFUXNOZml2dUkxNklnKzl2ZEVDMUMyQ0ZZU21qS2ZoVitvY0tMNGdySTl0?=
 =?utf-8?B?NHZrcHRieVJrSm1lay9ZUm1YVGFIRWZoQUpEeEduV0pjSEM0aXozMGJWMW1i?=
 =?utf-8?B?TmcrbnJtS05wSDIxdUgxckhzRUNDWFN1QzRDbGtodnJQWTJabEFHSWpMYUZV?=
 =?utf-8?B?S3JVc09RTng2UGRkSmN2b2dFM2RDYlh4SkVYT1YweVBZT1UvRVZIeks2Mkk0?=
 =?utf-8?B?aTFYdk9ybHM2SDJJRmh2VG50d3VadUwxaTlpM3dmU0ZMdllTV3NqaXdHcWRt?=
 =?utf-8?B?NlU0eitvQmlPZzh0aXZyUDhmanVjVUZIRXd5UTUyOVk5Q1ZnRU9kMzdrYUJQ?=
 =?utf-8?B?RFN0Rm9Jc0xBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWFBTDB6WS9EdGxSR0VBNFg5YU1aemI0USs4NG5xV1ZxbzkxTmN0Uno1Z2JF?=
 =?utf-8?B?Ylo4Qi9McklFc0FHL3Q0OFc1NVU2RTFHOVVwUlFVYlZqUXN4WFhIcVp2bll0?=
 =?utf-8?B?VTVyVlpJRjIxOHg0RzVjN3ZFMjc4NTh3NWZKUzNnWTBXNkhZd3RrV3V6RGkw?=
 =?utf-8?B?S0svbzBHZWUyVkhyUDgrVThxSmxsTlJNb0UxMGU1MGIySW5BOU45UFUzRjZK?=
 =?utf-8?B?aG5nd2RvTEJXZDdYWDBlZFV1WmJvTUxyOWdENFFHSHYvdlNrbXhjN3NuNnho?=
 =?utf-8?B?Y0orTWtoU3VRRDE3cTJTUjFNQUxjZWhEaTlBTVBWUm8zRGFZOG1QUlY1Uzdw?=
 =?utf-8?B?R3BxZGhGRVhnUUdGeUs3MEdDbklGNjBNR2JXcU1CS29VbFhlR3JRODdEc0x5?=
 =?utf-8?B?aThsc0p4bkxIdnRqVEZxUEQveStPNkIweWdnbnNpVEdBYVk3SVpjeEdaeXNs?=
 =?utf-8?B?R3JNTk53S1lObkI4OGVEdWR1TGRLay9lNHloZTFZdTkyeklieGJkL1ZraXFB?=
 =?utf-8?B?THNrZ0xoY3E1VnRRVHF2bEY2QmJIQ0t3ZHYyRlkwVHFKU2tzQlQ3Y2RFSy8y?=
 =?utf-8?B?QVNyMzcrdzZseUQ0UFhQNGJoa2UzQU1RWGs5SXFHR0tGQkloL2o1cVhBYlcy?=
 =?utf-8?B?RmZ6eG1HNnNFZ0ZwbXc1VGVOazhNdVp2RXAwTXdDK0dUOVZ3NjlZcnlNZndU?=
 =?utf-8?B?ZGtyVFNQZkpIcm1GdGZOWEhBOTBYOStQNk9VREdEUGhLeWcwaEF4Nmo3azZE?=
 =?utf-8?B?aGhlMDQxVWlUNmpzZ2pqNkN3NURuK1cvZVhDRk5zaHFzWmFveDVtQWgzOWs1?=
 =?utf-8?B?N0V0U2lrYlZ2WkdEcUh6TmdVY2taNmdrdFJRWFp1ZGtndkpqSnJQdlVXdWg1?=
 =?utf-8?B?cThuakRrWUp2WmlvVHArbkFIRFk3OHZ4SGlpUzFBcFA0YzNIeitQa09qd29I?=
 =?utf-8?B?YlVseUhmbnl4VXU0NVI2U1hpUHJGTGk3cEJZRnJLVkVrRmZ6Z3BJN1VLeC9F?=
 =?utf-8?B?N1gvTG8rMjB1aUNwbmhFRThDeG9wUTRyMGNWd1dPV2VSazc0NVcrWjV2RXhD?=
 =?utf-8?B?K1ZQbUtFRDB4M0xMQVZ5K0RON09UUjV4S2FUT29RNzRHeFdBdE1HUG9SbGls?=
 =?utf-8?B?c0pTVjNsZUNVOUErUVZ2bFhyRG5ic0IrTnZjRk9VSFc3NDA2YklPV2hlQmRr?=
 =?utf-8?B?M1U5TFVtZ0NhTGpaaDdjWkVIR3pDYVkyRGR4T1dUaGhsZHdIRlVISEdsZnJk?=
 =?utf-8?B?UGdsWjAxbjhhOGMvZTB2ZjREUWljU1Z1dWlHNkxUbzFRc3F6eTNsUjFDUWRj?=
 =?utf-8?B?bld0U25Kb0hxNU1JN1lHQjBSOVpYbkJvNVIzNWdITGdrOTJVUlhGaFpXZzJI?=
 =?utf-8?B?NzRMMUFudFR5N3RVa2dQSk9DdjRueXpqbFM3dFovNUxDY2ZWeHY4ejRQUnJB?=
 =?utf-8?B?S0tiVVpGSWNlb05CcFJuazlVaWcwcVd5VDNzU1Q4SEpCNng3bVAyeVpSMUN2?=
 =?utf-8?B?YzViaVJSK09ZZGw2cGdsS3IzTG55TkxidjZ1QmQ5eUJxY094N3JqcGwzcDdw?=
 =?utf-8?B?d1U3QzBWOFdVQjFKUE9qS2hRbUZKYk9QYUpTSThLYlhvQnh1R2pxNDlldlEz?=
 =?utf-8?B?ZHhiZHNKVjVTTkoxdVFmRnNTdFMyR1hwcEpZbm1NWkhaRlZBcU9jMzlHa3NR?=
 =?utf-8?B?VW15bU95TUlaalE5eDNMcnhhT0FVcENGamxiRFlsYTFkYlpXb1NXSForM0hm?=
 =?utf-8?B?dENxemhrRmV1RjRTQ0JydDN0RTV3cDRnbGhPcEFtMUJOVlhPMFNFRS9pc2Zr?=
 =?utf-8?B?V1JUcnBOakZIT3FPbEdBWFFtK3Y2Sys3VFlpRTNWQmJRejdaQlRaVWd6eWlP?=
 =?utf-8?B?cEV1RThRR3ZJT0tQNUFENzd6L2EwOEpUSDQ5TkdybUNuMTgyYjRGWUFVaWIr?=
 =?utf-8?B?WVdkdjdJU0dILzZKY2dHcTJDWDFTTFdBVGE3dmFwL0pXaUJDblhPcXliUVdh?=
 =?utf-8?B?UTl1RTRhaTdURElOMk1jMHBpNUhXZ09IWUhZSlFkbHMyZnJ4UFIrRzAxUlhZ?=
 =?utf-8?B?ZDNTRlkzMXMzTVpKSU43d3JWNWxlQVFzRzhxanhjNGxJcDlXQU5tTlJUSmE4?=
 =?utf-8?B?SFlPQys4QTg5Y0tvdW9XdWpYRC9LUlBVUm1xVXo2d282MlY2RnA5eFJJTG1I?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41D96286CAC58641B25FA217BA7F43A6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aeKCfGxoDCEjylSj+5hxW1M+Y9ESynPGuRL5Gl8NokItxznfJ+eZOuK7bnDLMEKhHGHHp6Qq6ecHfwW/kkEuE56XXPiaNhIiPv7xgCoSSXdnT5tn2WM2K2n+FxpEbpLAAk2mLwt6AqChbMl39wWHka67wZFdDQQw91eZmFYdZpXmA/VdJcdDfbibBnkd5fAXLic98eMt87+owlNHHePoY5sMaipuvHn6AQdzo3k++LRAiVseyDvcUsgcH2FUBk4Ajv/ag6yqAW+EuN/1WFPwgv19AI9oBh53CclQyt7P9mt1gzAFGazuA5NhU6Kq8/bRrcSnfBQKKq85LloCY8OWwlF2h5GDDC1vXZmsE4gV/m1FD3r2KOHVcA/zH98ESEbljGeQ7Qd2+dZpfYfv9cjB+ewVNgLZwY1DRzG47hVNKOf81bc9yjQ+3N4s0UHpqRD4f4aRByI3YcUC60JGOwbjvd2lNsjJLVp7JQo0Ex+q+rFDmx1u7+yKnZs1xgau4lC91O3ORkCkto9Nz/MmAmRrwaMK9I8ZZY6xKamhavgdqTo+tQrLmhvOOtHm3WrIgIrCpXw9rlS5Or9OZ2M0bxEngLL565omUF2pz/u7KibA/TCs2sswD4wJuaNfXsxAR7bp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebde89d-b99c-44c8-face-08ddc452a0ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 10:22:12.2684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lTdm9GG4bLOVJ83UJ/Ew0sWK+UJALXmCE/MSRaQ8qpWId3qoRbYtzRez5VnBh0abyGBM2ZkIbplNUdJS0tJDPC5IVC96iEBQEOsOamvLZsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7249

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

