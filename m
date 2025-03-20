Return-Path: <linux-btrfs+bounces-12468-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBA3A6AB36
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 17:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F58486530
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 16:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF2421CA00;
	Thu, 20 Mar 2025 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SVPgqz3A";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="S/eABKG9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573D91E9B09
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488723; cv=fail; b=HbqfDpSZmZTYuWqdC5SrqaQqiBtZ5/x7x06qGyzDGKE5QULcLU3RJADlyHQEZFpZjfEVlSrWzFj/3hJUjuRlSnMojIF53mIeKt6eGD7pKvW1U7pfd0RgdtTkTn/SfJzxTrhj4uQgOvIZ588/7HKD5gHrJr4tICi0A7xcP/XJbIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488723; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uoxsB6ZAUnrI6jJGsJiBCuKgQya4Oqk/ydM4Sz71D8XLSediG2yjyVtBpqUclQGVHW+qhWaf4Ycmp+QiH+dTCLC9wItwgN3LJXG7DvCnKEol1T++qo8iz25tdurBM9OX7tXYvfDjh5F8TPWGCH7EEZ1U6IpAhRmhWbKwB7hguOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SVPgqz3A; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=S/eABKG9; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742488721; x=1774024721;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=SVPgqz3AuhS9GPG6ZtzjAasTiw51/ltQpzXiDZ7JUtQKDwQZRke/oZes
   bgi+pzrzXKHWTxxa3d7s6ejx2q9fiY25PW/YuIbb3kH/1jsP7UKsxbvuA
   tzFFEWe9fh6449oiG0dRpVsYiHzUYEGzPgeX2tchZonhib9FcQpmDjzPA
   3kDfpM7WMIzaM4oAWanlzHvUrid/Gj7vVxUKCUtdEv52s2e5Vu1plOSuM
   u6kHGLTyGUetymjYR+a0++iHNnSV1W5XB8H+pFuQwSJ6a7y+svYWklOgF
   R3wxL5QSmwybSJCjWxHitxM9YSgQk3O5LW2cPju4IknDV+OQqXuj8OR/i
   A==;
X-CSE-ConnectionGUID: FMApfT14T46vs8lXQTgYQg==
X-CSE-MsgGUID: qsAHD4+RQrOUfnMRo/rPTQ==
X-IronPort-AV: E=Sophos;i="6.14,262,1736784000"; 
   d="scan'208";a="55250579"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2025 00:38:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBuEvZbKnKpe1i4hCXzS+dfzy6ppvWrM7m3lk7lGSbl0gx9aUEuyYhDVaOBnG8rsotWQDu12MRw5MKhbxuVnRWeinttCx54SKNgzCO4+WmNvIyrICnfblHqI4hPEQkRSFSYx05CtQnWt+NYTOE1EgeLYGU9+fZ+j5Tvs6shhJjQVJ2F+G/TJd4NqZ2burhKkJW/h/bpO5dSBF7BiXEK2H5gAiBjDUEPKO0GxximE1fPlok4vVWoGHzWZjfE2fsOJGsIhOVFPpslRC9+Vi3P+f5fiFOgKk4lgHArms7co59uUATzi03vW1eic+CSCS2OBhwkPujy08MPWsRtvXe/7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=qy2H0ennbPGsgK0ubwhfJrHXfZ70YS5ZdisSuvFnopeTQPa1bUA0pPBbEQU2lL5DfsOPC5pE6nSrBiC1Mp2TA0TeOxSFXuP8aL3leTrT14+AKqdpp96pwePht+5WkMbFHdjzvufCFTk3BZdu2+KiltGc0LQYqqCu7BlMzAxk1/vWjEEuKcGDxOr9WtgxCUm87Rs+ah12gVlXtUYBPDz+1sqTEJc9xklbZAnWwnX29Xa2CEgD/6DyZsHfEOuMKBnXUFzh0BQo7uPJAvJi6+tXqm8sUmJ5hNCGwjsv9+iH7SkihgVcVZnSt/lT0e/a1XIXhtQuS6mOfa8OIjiACCUcLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=S/eABKG9UEmXViOsI318OZsTKB4L/8fbjJyjkQeYbdGKEgwG0uGCnLM1qdok78Ye7kwgHF2iJqr8CjJ8fEI1MvNlsTlR8dnh98z+HfSuXHXsaMK3CaHwYMU89enCutiCm+Sb67rSb85xERbyG8SA8NKAceKceT0jT9BKuWvHUoo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7885.namprd04.prod.outlook.com (2603:10b6:a03:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 16:38:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 16:38:37 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 12/13] btrfs: add block_rsv for treelog
Thread-Topic: [PATCH v2 12/13] btrfs: add block_rsv for treelog
Thread-Index: AQHbmJaYrhPvZCVx+0ynfSZfiSEbLLN8O+AA
Date: Thu, 20 Mar 2025 16:38:37 +0000
Message-ID: <c03baf45-ae37-4e37-8733-7f1a58995f57@wdc.com>
References: <cover.1742364593.git.naohiro.aota@wdc.com>
 <cbb972d4719e45833b59f6c28765a290af466a02.1742364593.git.naohiro.aota@wdc.com>
In-Reply-To:
 <cbb972d4719e45833b59f6c28765a290af466a02.1742364593.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7885:EE_
x-ms-office365-filtering-correlation-id: 87074aa5-f2ae-4f3f-7d48-08dd67cda9da
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0JuZzNGaGhrZFM3RnJIZys5cG9nT2NIT0x1RnMzNlpRSUNaUjFjMllJcEM3?=
 =?utf-8?B?MUlGMk5uMTVUT0htSkliejBTd2lsOWp5bzk2SElsWFNaVGNXM3E2TFZkSGF3?=
 =?utf-8?B?ZHM1SHFabys2dVVpZWt1UzRvdUpQR0dUUHU4K2FOUDBNNmJvQ3NzZFFLeC9U?=
 =?utf-8?B?Q3RLaU80dzZOaWRINzRFRTlwOXE0bWM5azdZZjRudVNtWVUwQllWdjIvWTNk?=
 =?utf-8?B?NTBBdjhoa0FHQTVxbml4ZGxLSVl1aCttNCtQTm9lbnZXMi9uaFJKbzhmbFBO?=
 =?utf-8?B?VkVHZStkWXRsTTcwajl3YmltQUJIbElsQ2JGVE51eVpmZDBDRHhZenI4eFMz?=
 =?utf-8?B?VnhuWmlYWjNwVjF1c1Z2aHhHVXRCSUd0WGJRVnlHWjRMMU5qdVVBb2RHVFF3?=
 =?utf-8?B?ZU9HUjZad1l6WUpEOGIrRHJKWTZrbzd2dlZ5dDY4ZHB2QVFSQ0tkWVJ4SXdU?=
 =?utf-8?B?R0tnUURGMHloWnVQdzJEbVRIMDlsekZuVzFYUHJGUDNlY09YdzAwRkNCTHhW?=
 =?utf-8?B?Y1BTUkdLS2lsRk5jdkFYaDMrNUEzVWRuTDlMcVB3VFNFcHhRREVOTVBNV2NZ?=
 =?utf-8?B?c0RReHVLeVR4RDd5Mit3bU1xKzJ2WjhLNDdyYUhkblFOTDlCWkh5aksyZEsy?=
 =?utf-8?B?WVZlMXpZTzlNOVJZd1htTVZ6RGFlUlJDbENOMDJKVmhPWnZzNHNlTTBzNWVX?=
 =?utf-8?B?MDlac1ZiaVdKeFF3WGJ2dUJXZG9IZUpqRFpSUmJBWDloMGNCeFMrQ1hlbFI0?=
 =?utf-8?B?dTdpSlVtWGlmWnRsRlRKUTNRNXhBbHVvZ1c5WUttVm1QOW53S25ZRzNrR0Uy?=
 =?utf-8?B?U2hGa0JQQlNLcVRTRHRWU3dWWDlLUHFGRVc5R1IzM0FWQytLM2ZaL1BxcXBL?=
 =?utf-8?B?amRpaHJyVE1KL0JpeW5DdmNCNVhTZ2tHbWVWeE5KWEo1MlpBUy8vV0NBWWlC?=
 =?utf-8?B?bmNBSTBPeUd1c2MzaXFGNlpEdVFsTkZQVzBEOWF4V3NuQTNQZmRjbDV1VTZo?=
 =?utf-8?B?Njg3Nm5LcnBkc1NqVmtkdDBqcEhPWVVyRFM1bnR4MjJtT1ltZUZOWVkyNHZ5?=
 =?utf-8?B?eEZ1dk51dGZUdmNnaUhQNHBPUXNzRktKc2ZGT1ZiencvNzZSVDRadTN5TmdR?=
 =?utf-8?B?K0FFWUgwUVBNV3A4UVpPUGs3VithWlhQTERzM0NIbE4ySFNTV2F5WDZ2VXBM?=
 =?utf-8?B?aVpWc1IvQllZaVpMSXJ3aEJRUWdyWTkzLzhmK1VFZFQyZTBIRFpHM0cyMFh5?=
 =?utf-8?B?MUl2TXFwUlJvMTBpWjF3c1pMZDFKeTdDS2NtQmgrSTNrYytTaU1pMklMRGpF?=
 =?utf-8?B?T1A4VzE5aDB2aTFPclkyc3VUYzk2ckF1eHBiRU1BcSt1YWJ1R3RQRVR6Mkxv?=
 =?utf-8?B?VXhVS1F2L0Rac3RGa3VFRFl5NzE4V2ZyL0NVSmp4WTlmNlBTZTROcXdvYThm?=
 =?utf-8?B?SUtYWFpZeXRHZ29ORXlVcXNOSWpFUVhiMURSUjkybXBkMFVLaUFQWVowNUx3?=
 =?utf-8?B?WWxRRFl3L0thS1NwVThJZ0JoVk9reDA2cjVoQVgyWkpVVHc5VG5SZkpNNGJx?=
 =?utf-8?B?L1V0cWNSK3VWUVV3MjViSTZoWjJHajkyaHdwNHF1NEhQdExHSi9jTTZFcVZ1?=
 =?utf-8?B?S2VNc3NlZDZHMUxRbXZIYkFRdTl3NHZITVNJQjZ5K0IrTVpBUEJqSHhJYnZ6?=
 =?utf-8?B?d2ZFNktWQ1F6b0I4UkM4Y2xsQjV3THhhdW1BU1NCQnB2NjZXVFA3VnZaeGdk?=
 =?utf-8?B?QkpWQzBaZ0Zyd2d3UGRuL2N3VGV2UitrSW1tM29WRmhJakZ4Um96TDBoazZ0?=
 =?utf-8?B?L29DMTlzOHBTTnJNK3RSclNxaWhFU1hLQXhqdWRUSjR2N2hXdm9RdDN1T1FK?=
 =?utf-8?B?WCtRc1d6MlhlaGY1NkVsTEltZkN5NE5VamJhMWhmUEZPNFF1NmNiNE5HclpX?=
 =?utf-8?Q?RskRdUwaKzpgBdmd/dh4OZO11Y02Zzik?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?LzFXVzN1SS9UV3NWVXYzdVFFUlRPWXdNWitZVmRoZmFWcTZZeTBDQlJRMDFR?=
 =?utf-8?B?a0Q2dTVXTXRubVFEbEdsY3E5bnl5U3JZdURNcm5IOTN2aU51cFljdUlyVDVT?=
 =?utf-8?B?aWppQkVkKzNLMEZWeUJiV0ZUcC9sZVhHdzlGS01ySWVEMWhrWlFkeURqWnZE?=
 =?utf-8?B?UHV5Mjl5djJXVW9XT3NremV4MzVjbHlFeDdYTWxpcCtaOXdidGFRcW1LMEE1?=
 =?utf-8?B?K1UwblJtOTJxOTlrdkF5WURKQ0hMR3ByYzFUeE90dDRUeHMxVHhtc29Xd0J1?=
 =?utf-8?B?TzFadEI4dnYzNzZFbUY5d3lZSFQ3am8zU0g0VjZNUXkzN2ZDSmJTNG0vdWor?=
 =?utf-8?B?SzF2R1dOeFl0Y21RaWZHcHFJbWUyVGRzUGhKU1BJT1lXVlhjNXlaZVhJQjlJ?=
 =?utf-8?B?b2cwVUt0dUFFY3hRMlFYYnJCeDRmbWYvNm81OUFtd29lZzM1dk1YbUd3RlZF?=
 =?utf-8?B?cTljTTdLNHduVzl2M0hmVkRzRnVHNExGd3Z6Z1NSSzN0cHpUTWVlbTgrK21t?=
 =?utf-8?B?aWlmNXdIcEZCTnhXSUl1aEcrb2VRMTU0NkZXand3YWpUVlpnanVENG11TXJ2?=
 =?utf-8?B?aFdCcU8yRU4vc2dhMnVMQ0drMXlBWnFRMzVGbERhYXlZUTFsVnBlalJOV1NQ?=
 =?utf-8?B?WEdRUE9JYVdKb1BnN2pCQkxFalg5WUJvaFZKYVJYVTg2dmFTTkZxVUJibG5M?=
 =?utf-8?B?VGNuRDRQRGF4Vys0TmJhdW4vUmpnYkpibU5DYnZvVkNUNW9DeUVSVS9XUTNi?=
 =?utf-8?B?TlZOeUdpc1p6NS95amlSY3lSWFZDOWNqb0RCRzRRQUNLVGhyK2E5MS9USzlQ?=
 =?utf-8?B?bUlRTGhXY25ERzhrMjdqbkxjMnc4bGtzeXVxRVdCOTN2TStaV3RkSnlrQ1dt?=
 =?utf-8?B?YkZweElVMnFhTHNQVlFRR0J1VDdTc2t6MCtHZXNkU0k4eCtkeTFxTyt0bnA3?=
 =?utf-8?B?TDVVZ2VBT1YzU1hwdFRHS1duU3IzWjZQRnZxKzVRbk1CZWVWU0VpRHNjZEpL?=
 =?utf-8?B?d2tiRldCSmc4OFFDcGZ5anNrT3QwcnpFZjhTYS9CZkNlT3U5QTFyd3RTTXpa?=
 =?utf-8?B?dmRNWDg2L1ZIcnJ5YTE1emc1YVI5a1NnOG1mUE1CYUdxanhoQ3IwS0RqUjlx?=
 =?utf-8?B?Znd6TkgrSm9VVXdXaGtPQzBGcjVBVHhZdEhhS09BMEZLWHVqME9kY0xOOVV3?=
 =?utf-8?B?TlF0RjVWemRWK2VFbkVxbU12eWNUaHptUVJrOERCd25sSk16OFhDbG9hc0cy?=
 =?utf-8?B?RFQrMnZoNTlqV0VNUmxhRzlPWVVrRUgySlhoN2N2eWtqcEk3c2thOHdhaUNR?=
 =?utf-8?B?L3hZWGUyUXIxSElrckxnT2d5NTB1M0pNYW9RZnoybGtZMTFOK2wzN09PblQz?=
 =?utf-8?B?ZzQ4aWR3cEQzT05uNy9DazFLMDR1bHJWbVRMUy8xTTYvMnI4elVXRmhCNWtT?=
 =?utf-8?B?VllhS1JNMW5xeVVGajRaaTNrQUdURXJSbkxlWHNybnNUTlR1S1FPVlE4NmFj?=
 =?utf-8?B?Y21aY2Y5ZExiblJZTm04TXFpZmtDKzFLbmlqSU81MHQwYyt5ZmM5QUlpT3Fl?=
 =?utf-8?B?Zm92Wmh0QjE2Qm1SV25IZUxCeHZOeXdIQkRyQ1BMeVQxUm5mbmoxVDJoQWdT?=
 =?utf-8?B?bnNKZTJjWE9xMHlaSEZDanVyeVdkSFFKTTZDM1B2RTlmeGFUN21EYUdSN3pW?=
 =?utf-8?B?dERkSmNwczZMbzdRYTMxeGRwTTRHdnFrbFNYR3VZSlNnQU00ZkYyUjZKMXQx?=
 =?utf-8?B?ajFEVUtmUkFpWFJNeFJUTGdTRXJYVEtyZUVWMjh4bGd1Q0xFOHpWeFhnaWph?=
 =?utf-8?B?MFloQy9UbUlabnoxM0JDaTNNemc2dWpZZ2puZm1qZ0M5bGxseFBmN3NubnpH?=
 =?utf-8?B?K2dPLzlsbU5RYkhUUHZDT25jWG1aZGt1bTBEL3NGck92YjdQMmEreVFmZ3BE?=
 =?utf-8?B?dTVHcUhjK2REMkZXd0tlZWQvRy94K0laa0JmQk9ZMS9lbzNXVFVMMDNkUjF5?=
 =?utf-8?B?RGRRWEJsUE55bGtIQ2N0VTlCS3ZITmV1cjJkek5RY0pVWEw1a3hJV0ZZY2JV?=
 =?utf-8?B?UURUU1M3V21hd0JsZ0pKVGJNV0hPZ3N6QUZ0RHBYWUVzT2ZROEJWaFprWkRh?=
 =?utf-8?B?ZXBEZC9zS3ZZWDZ5Wk4vNUdCTUlRaFJld1FqL25BOHVBSWV1UU9CZmNSYWY0?=
 =?utf-8?Q?Z6j80OAnYDdA8VN6NuSJ9bU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F97D7C6E3201164CA94282D56BBF011D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F1fRiHDU2A4DPJnbshYwSNAJu+y29dlk1W6mM4aaLWxqAwlTU8vE62ws8Nrz1VvB2cK0arzqPgpjJx3ztPqZQjB+8F4KKg8TKGrTkeXeXTj+2ZNEp8IeIZtACpxdoPVr/LYh8zVKHKOqPJFqdOsPN6YOABRwpcccOpyofENyXwCiKXSelTscsICKjvQ7cn1vhubEIfshPDhPwvQem7SxlATCA5BgxcyNXNVzRky3JoopmM/ZyR5Tvpz37fz99iVq/WMXPLQi/cmJjRmyJNDFC35B1WwrgSo/1neuLFQt2XGus0WBUvCkSf01imrawzoFKJ9yfXvKmHG26ZmhEMlepW9IpHsxscgNCfGdOGpXDMMp+CZhEkSsUKUzHIqB9Cv4oEcBZlhU734PfkPXiaowuv//5s94uS51EHLEZIxEr7qyLFdD4Kq7X2NJsCBp9yUVsO8t+I1hhEVENFbKprFcSLaN1Q7ARaxUTMbuvvCovJR1kVHKCDq8pgHB17DUAAPglskqmCgHAIFQ/wXsnUlLdf9o4xHw3g3w8X5emuYse87Y6k3X3QbiPa+slzNo1sqniUV71I87y7DEKw4O/nofGv4fn4Az05MpvOjFdPfs5IYgT196AntSMgCL6iFJwM0C
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87074aa5-f2ae-4f3f-7d48-08dd67cda9da
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 16:38:37.2029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7KxlnI6uGtsNgNsplNdgNWcq03GZCMaDY/JXGbcB+qjgz33nyEFdOQhi4e4kIBEOSzEROF2pUiygjjOlgaKXUjfi7HtRYjf8GVncUnp+Qlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7885

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

