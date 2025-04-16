Return-Path: <linux-btrfs+bounces-13070-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28173A90448
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 15:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970E43B2DC5
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 13:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57541A8F89;
	Wed, 16 Apr 2025 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DinC0V1l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2047.outbound.protection.outlook.com [40.107.255.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D861BA32;
	Wed, 16 Apr 2025 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744809879; cv=fail; b=IJlG9FeOXOeO9z8yyCVmj99V+ZTQwDVb6nTk14v8ORHbFOUgUb1mQzx0dkGAV8C0ZLnoJ32oFskV48/O292/tFZiqXhrpkOAgdltjFVO15/kO7iW4VNKe339Tp1g6jEAGdC4nuY3b48fQnhc+0oKO6ir4wuWVanVxIFRstyfW9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744809879; c=relaxed/simple;
	bh=YReSF8qECsAteTN4V3JB2Oogej1J9SECVWMW/DM2Gnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G6gpbNk4BB7lh2VTm9bUg/V/QG3zgddFNDEsKv0aF2svMobdHlBCo2/8dofxI3Jawf42H611cP5hnH1lQKKLJqsdoN84Up8/YoHMXM7hbcMjlErG3HDIyoxKjQJsta0nCeOnmDKiJmZVz80brg47vefCA1c2ZQO7bO1W9dZc50E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DinC0V1l; arc=fail smtp.client-ip=40.107.255.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0pnauEf67pdx8QMWKoQY8yPOW1Q6xFJvi8Ge9TjLUnNZaS7cVCvw7uVkTWUBjFsfwpq8UfQeVONYsuen6xUYA9wtZaaPOiqArsoABU/1MNmGn2j9wUmg016e/HDp20wgUyWYBTG1mV3HERqjVGOFEWn3+ZgCcybUHkuJJAjBZo+uRWZfctvVLZf3WUIOc3O0JEv66S4bhnjNbMGDwfuKW/5tAz+X1ZCxiSD/S/HM046Se8zr+96Oppolvv8c3xNz5mi9XDwxpfA58HX0pc0GmVQEOuBl2VCPpKe7+FCeXGsZrMr6R1BoeURTIfiD5TjeeX+rLDiwbGj2MtSXN1DLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YReSF8qECsAteTN4V3JB2Oogej1J9SECVWMW/DM2Gnw=;
 b=L9GlYIiPorqxDpIrI/zVrJmPLpm1Y/QLePBcu5vndUCTIayef0aNTVTxY0TOEMi8BapZUgsJL6nKk//M+KugOOPxYjWRvtaT5LmsB20bRKHaa9+iphsS5oz+Rh8rqrLHDQLQ5F8HiXCAlUHAOlVLMToJxoqNTNck2JRYqumWcXYrU9fxuquTM4dV7toHuiVQFJDIuR34RAsfbIAelTaC6UE+WbXubopNIxpIIMv3c5lYgQ6CS+AFoJRXVMS3ooTW9bkttnKAaHwNd/Utdn0e66yATxO66YYB9UjLNQ//+Q0gsVbsNeOq6buuYNKBaflar7pX1n2uS9jd/DG9Oyre0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YReSF8qECsAteTN4V3JB2Oogej1J9SECVWMW/DM2Gnw=;
 b=DinC0V1liNXVac8m7hYAhwxzRDqo5/6zpAoVH8P9Qu0sxglA6C9AUI/ZfFDdvCmAb2NYQ1kP5F5oyWxW6ds09F4ITWnvm3Dl7PPFQPZ3NieZelhwXJZMIS5ReO3kEvH5/V/sevME0kgKu6ewVd2akaV6cuCpUCrzjxl53MBAF9yxhX4zidRCXrf1O2wuwSm5ReFh5K0pukPJM35NvG59Q3G+PiYEaDUg9QQTicrnHISxAp37pIW/E/1xg9lU5fdddu7ED44x+cdIxcVK5D2Q+WOqQ0Blq91/iQekQCX7RpT18nAyk8thU2Anm/ooYdaZOxliLPG8WjSY4AlgvvwaJg==
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB7300.apcprd06.prod.outlook.com (2603:1096:405:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 16 Apr
 2025 13:24:32 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 13:24:30 +0000
From: =?gb2312?B?wO7R7+i6?= <frank.li@vivo.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>, Sun YangKai <sunk67188@gmail.com>
CC: "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "neelx@suse.com" <neelx@suse.com>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIDEvM10gYnRyZnM6IGdldCByaWQgb2YgcGF0aCBhbGxv?=
 =?gb2312?B?Y2F0aW9uIGluIGJ0cmZzX2RlbF9pbm9kZV9leHRyZWYoKQ==?=
Thread-Topic: [PATCH 1/3] btrfs: get rid of path allocation in
 btrfs_del_inode_extref()
Thread-Index: AQHbrbUqBDIkC3HhxESrhQE2MboFAbOkzooAgAAT+4CAAWa94A==
Date: Wed, 16 Apr 2025 13:24:30 +0000
Message-ID:
 <SEZPR06MB5269DCFA737F179B0F552B01E8BD2@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20250415033854.848776-1-frank.li@vivo.com>
 <3353953.aeNJFYEL58@saltykitkat> <20250415155637.GG16750@suse.cz>
In-Reply-To: <20250415155637.GG16750@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5269:EE_|TYSPR06MB7300:EE_
x-ms-office365-filtering-correlation-id: 20c3befd-6221-4ae7-5e16-08dd7cea0527
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?ZEp2MzAxVmJKcjlkVWpCMDJqNjhPdkxSUWJOeWcxMkdlYW1iWVh0czZLYk03?=
 =?gb2312?B?SWdhMWhKQ1FxeVAvcFVnV1RBeHozSVROckZmVFBqUS9Fem5pdmgrME4rTWNk?=
 =?gb2312?B?QkJza3BRYTdUd0JDZkMzZlBoQys5OWtMdTRkQ0FsWG9idDdaM0NJQU1wYXJ4?=
 =?gb2312?B?c0x6K1p4NlVzZkdBMWVaRjBFSU10WjlwcXJ3MGUxRkd6TGRldExzOW1aMUxU?=
 =?gb2312?B?R3N1SDVFaFBqeVAxeFhoN0t5a0JyWDhkcG8wSTdUQ3Fwem1Vb0JFQmFzalZV?=
 =?gb2312?B?WjI0SVp6aGM1RGFBRTFxeExqVjdtNEc4Vi9ENkRXTmtWZW1GTmdpeFc2TUQw?=
 =?gb2312?B?aW4rWlZ3R1RWdFJxQ3V4NGxTeFVJM0g4VndHbzgvN2lUMVRaeC92UjN6MElU?=
 =?gb2312?B?MlByS090Z0hYbUg2UXNZQzNObjBiVk93QzlwOVRSMWxrSjcySmg2Qm9kT3R3?=
 =?gb2312?B?N2lwY0QxbHd2azhTV01BQ0hoZDEwWWJ4cHpEcDNVZ3hGbDR0MTZXU2tibnM5?=
 =?gb2312?B?TzNrditRbDlzcElCTG1DaXFpOVBUb05FbEpYbWgvaUo2ZG1lSDMxZko4Unpr?=
 =?gb2312?B?U2ZwcUF1UDh6WDlaQzdPODhYWXhERittV2hIR3hDM3JSZkN4ZnVvTTkxZ0li?=
 =?gb2312?B?cFhMMkNPVnlOelk3eGZ4ekRsUzRhREVQYncvZy93dS8xMnlrVmNPbFdGWG45?=
 =?gb2312?B?b3dBVmh3VGQrZWhxdUVrbFVzRnBtUC84M3ZsaXRRRWQ3T2lQWEF4MzNVV0U4?=
 =?gb2312?B?NmI4ZEF6YnNQNmExRy9nQS9rM2JqeG1GUk95VUdGMm1SQ0xNUlRtbEVuV01J?=
 =?gb2312?B?VEt2SklHWTBDOGdzeTBSSk9yaWU4VnVnN2pUckcxcjdKZWRrZy90bTRhVG9D?=
 =?gb2312?B?WFZpcFRodlVybDRkRmRYNzY1VWh1NXZaOXhBTGx3QmovVm1Gbm5yemVjRWJD?=
 =?gb2312?B?RGs5dFFkanhRaFBlVkIzTTVldnZGZDM5ZWZ3cnBzVkVDVjRxZSt5S1JvSGZQ?=
 =?gb2312?B?a3dzbWRBOFN5Ri9SUUE5bnQzaGNkQUhJWjNsdVdZUHFPemtSNEtwcElTZjdF?=
 =?gb2312?B?eTdVdnN3R2JocXNVTEJaUHBpajJDeTJPTldTUGlqMFBudUljV09vY3dLcXBO?=
 =?gb2312?B?TEgrUXE4NC9yOUFOb2srek1BOWNIUmlOOW1uc3FVTm1Md0ZVd0pJaFFpZml5?=
 =?gb2312?B?SXBDcjdCQ0dscUY1NGpaanJKTFhoalBpdSt3cUlwTkF2bzBnM3JNdFNiYTND?=
 =?gb2312?B?L1NIcHNXL3ljZVBYR29QaCtITTFMR3RpT0ptSURMWHZ5bnBQQllqME91Q0lK?=
 =?gb2312?B?NkgzT04rN09qTCtjZnBmNHAvN2VDMFdaQ2hMWUQxNldhdEFVUmczMmNSQWp4?=
 =?gb2312?B?YlcxNXNpd1NGa2VwZ2U4ajJRYXF2RmdxTzkwbWl5bXFpZitWTEU3S0VwZE9C?=
 =?gb2312?B?S3RsZi9aZnJzR0FPSGtjZWc0WStvWEFUUklPQ3MxRXRCT2hmVDBwQWR6eEhR?=
 =?gb2312?B?SE16bTZIUGdDM1dQdTVYbDRYUkNvb2JLOG16OTFkNCt1TU9za1kxZ24vZkls?=
 =?gb2312?B?eDdXVGgwbTFYNlByYWlFeFl1RjdPVGtaSXgvMHZteTQzMGFqNTJNWjVUajRO?=
 =?gb2312?B?bXhCWXpBWmZlZW9YdlZJWENFM1JNd2dDZDlQa1dXUTdoWEFDcUU2MEtRQzBx?=
 =?gb2312?B?dGRtUThuVXh2L095QnU3SU9saXJaaHU0UWJkY2M5Q2RuZVB0TUYrUklrMEhy?=
 =?gb2312?B?OHR3TFZTVnQ1RDZrbXduTytUMjF2TmZlRVdlZk9nc01ZWGRWdnVVUGVYM1Uy?=
 =?gb2312?B?eEozdmhadzBLYXRQRytuK2ZWYkdtM29MUHIwRkxEZTUxWkMwYzhESVpFU0dL?=
 =?gb2312?B?ZExtV1Q1MDRPdFlRV1lUY2U5ZFgvdE5JbHhDTmhCYzFxY3k3NnNmWVV0VUlN?=
 =?gb2312?B?b2dzUmFoeUg1dkx5SGF4TVJ0ajNWaUtycW9vd1dBMGZUODRuVnU0S3lkOVov?=
 =?gb2312?B?UTZrQ3pPTndRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?YkZCUFJoQTZTSTBQTFIxSG8rYUZINDcyMjdkeGxoM3BlSTRiZTBDY3A3TFFs?=
 =?gb2312?B?ZUJET1lqbUkvRVU5MUNTWGMvZkhxdjBWdFpvQXdlS0VvSkt5SGRYQW1od2lt?=
 =?gb2312?B?UG1UaFVjL0pweVdrM2ZTWmZGaytibFI0WVhXYkt1cEJUOEEzZmRUMEtKTGt1?=
 =?gb2312?B?WHVjQ2g3c0YyYndVcjB5YzBQamJWTTdvUmNlUmVTVFloeWdUSEJhTHRxVnhr?=
 =?gb2312?B?ekYwSXBZcFBEMlpaeDRyOWRaNkpDRk84UUhlNFJVK3Njb2RaOHZ4UzlsVmI2?=
 =?gb2312?B?cENTaGJWekw2d0xBQ3NEQk5DTzFjeDh4QTZDNmc4TlRIT0g3R0NUMXVNMTJI?=
 =?gb2312?B?Z0F2amVTY0g1MHlhSncyMkRCcVBzUXJWRVgreWhFY0JKTytnZ2F0ZkFCZU8x?=
 =?gb2312?B?Q09xZXkzR0VGMUh2TCtOY3ZSQllOQlcxaFZSZ0swOExzeW5qZ2w4dnRGcE9X?=
 =?gb2312?B?a21KUHFTb1lrSm9tcktTSGhQcjRsN3pzSUw2dWhhNFRwZHA1cXlRcDRVZHZ2?=
 =?gb2312?B?MGhaZXJVUDEvWGNORit3L3lqTmt6UXNHKzlyZGpqOEIxZC9HSFFsTm9xN0tU?=
 =?gb2312?B?b00wb0F0M0hIVVFVT0lLcThJYmhsQ0J2WUsrV0JKVW9aR1BlczVpYWJ4MXky?=
 =?gb2312?B?WHdxakljYlNZNHNEcTZLcTRZbXdKN1pYNVlwK0lzMWkyYkRGVnJpM3ZUWE5U?=
 =?gb2312?B?dUEvT212T1Q0TVdyU3hkenNOOGZ5WDA4NmtEamZDYldkYjFqSkpJbldjYUxn?=
 =?gb2312?B?cEgwQ2FqLzQyTWkzZ2hNUGlUVmx5ejk1RVozTGJHNHdkYzZXUzMvWUxyeXJK?=
 =?gb2312?B?Zy9kejUrMTFkc1NxU1NKbStWM21KbVZhemtySU93Zk43S0owMHd2VkVOVmNo?=
 =?gb2312?B?amlmaUd3NndNMHd3aVNmbjFRVVhaNldmNGpld3JCNVh4WEZVNlhCclptNlAz?=
 =?gb2312?B?eXlJa0UyQmNYYmxsUlFJQ0FvYjZISllrdlZXUSszUS9zUTBkeU43d1RzTG1T?=
 =?gb2312?B?SkRydlA4Smk2aFAvRFNsZERMeWVPd25HS3VOaW1mZG00WDRyeXN5UkEvWmg5?=
 =?gb2312?B?ODR4QzF1RU1OVGw1Y0tUT3RMUHVBOFBJazBXb1U1dVJPQUhWLzZUeGhZTFQ2?=
 =?gb2312?B?RDJqVXBWTVgydVV6UjRRUkMzdTNia3hEMCt4Q3Uyd0pHSm56OXlGMHVTeSsz?=
 =?gb2312?B?TGVHVDJEZFlWNGFhbHdBdGw2NFJ5T3g2bkxVT095YWhjdzJqeXliNXlDUHB5?=
 =?gb2312?B?L1dRUkM2VXhldXhaUjNZeHNpTEJZc3JSSEQzeWZQYXdsQkM2Zk96R29GS2RP?=
 =?gb2312?B?YVN2eGl2UTU1TW9GWDV0cmhSSmk1Mi94ZmxHemtQcGpGUmJ6NG56dU5wblla?=
 =?gb2312?B?TWhTcFY3bWpQMzBIenF5MVpqTis3Z3JRaDRaK0Z3bU14bTRrMk9seXErdHRW?=
 =?gb2312?B?ak1ZTFhMUXBlNWcyRzlHK3JVUmUyUHRSL2hpakVqaE5ZcG4waFcvUXlsOG5J?=
 =?gb2312?B?QkNyVXFwNzZWZWdKUFlmb2I0T0Y0V09INlhWck9mQkwyS1FNRE54SHJ0Yk9F?=
 =?gb2312?B?T2gyUjB0Sm4rTlJOM1FFK2g5QkM0dlZZUEdwQUgwQ2dpWUxNZTF3K2M2N05h?=
 =?gb2312?B?djUvUlAxZExlMEtuSkpWOVphY2hac1NCU0FVSmtNbE1LVkxpSGpvcHNycUVv?=
 =?gb2312?B?RDYyaGRRQjVrV3JNYzZ5aTN4YUp5N3ZkRm94aVE5a08yYlFyUUdLdjFPaFds?=
 =?gb2312?B?RFZtbjgxTmZUQkpUTFU5THNCR0JHdVF3QVNUSUhZZENMTDZPSzVwdzh1bW9x?=
 =?gb2312?B?ZlVYN2U4NmJCMTI4NFNYd0dHakIrSGdUcHZsR1pwRFNObXQrT0cxUTBsOXR0?=
 =?gb2312?B?RUVvM1hyV3ArTzMrZ2tTdGlMYUFnY01XNlppeEE4cHNNK1psODNhaVJsam03?=
 =?gb2312?B?YTh6WHpzdGJMclh2eTNvbCt1ODVCdDZvODFwSjQwZzdUTnlVWmMwV0pvcWQ5?=
 =?gb2312?B?OGJoWCtEeVZOWnNwZ1dMQlNwVSt4T1BTVktXR25ZZDQwOHNabTlOWFFHaHRN?=
 =?gb2312?B?OW1iUVkxdWpZYkp6ajJ5YS9zOEZQUEViVzVocGhOZGgwTW5hS0lOb1RuQnpK?=
 =?gb2312?Q?uaFY=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c3befd-6221-4ae7-5e16-08dd7cea0527
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 13:24:30.6648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BXqqaLBqiMBDcx/R5XLzK5DKge5iCbtKqw5EgCRPe+WB11OBb8g+qkVHFQZFesSj3mv7GyuPy/Objl/0Tq7IFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7300

DQoNCj4gQWxzbyBhIGdvb2QgcG9pbnQsIHRoZSBwYXRoIHNob3VsZCBiZSBpbiBhIHByaXN0aW5l
IHN0YXRlLCBhcyBpZiBpdCB3ZXJlIGp1c3QgYWxsb2NhdGVkLiBSZWxlYXNpbmcgcGF0aHMgaW4g
b3RoZXIgZnVuY3Rpb25zIG1heSB3YW50IHRvIGtlZXAgdGhlIGJpdHMgYnV0IGluIHRoaXMgY2Fz
ZSB3ZSdyZSBjcm9zc2luZyBhIGZ1bmN0aW9uIGJvdW5kYXJ5IGFuZCB0aGUgc2FtZSBhc3N1bXB0
aW9ucyBtYXkgbm90IGJlIHRoZSBzYW1lLg0KDQo+IFJlbGVhc2UgcmVzZXRzIHRoZSAtPm5vZGVz
LCBzbyB3aGF0J3MgbGVmdCBpcyBmcm9tIC0+c2xvdHMgdW50aWwgdGhlIHRoZSBlbmQgb2YgdGhl
IHN0cnVjdHVyZS4gQW5kIGEgaGVscGVyIGZvciB0aGF0IHdvdWxkIGJlIGRlc2lyYWJsZSByYXRo
ZXIgdGhhbiBvcGVuY29kaW5nIHRoYXQuDQoNCklJVUMsIHVzZSBidHJmc19yZXNldF9wYXRoIGlu
c3RlYWQgb2YgYnRyZnNfcmVsZWFzZV9wYXRoPw0KDQpub2lubGluZSB2b2lkIGJ0cmZzX3Jlc2V0
X3BhdGgoc3RydWN0IGJ0cmZzX3BhdGggKnApDQp7DQogICAgICAgIGludCBpOw0KDQogICAgICAg
IGZvciAoaSA9IDA7IGkgPCBCVFJGU19NQVhfTEVWRUw7IGkrKykgew0KICAgICAgICAgICAgICAg
IGlmICghcC0+bm9kZXNbaV0pDQogICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCiAg
ICAgICAgICAgICAgICBpZiAocC0+bG9ja3NbaV0pDQogICAgICAgICAgICAgICAgICAgICAgICBi
dHJmc190cmVlX3VubG9ja19ydyhwLT5ub2Rlc1tpXSwgcC0+bG9ja3NbaV0pOw0KICAgICAgICAg
ICAgICAgIGZyZWVfZXh0ZW50X2J1ZmZlcihwLT5ub2Rlc1tpXSk7DQogICAgICAgIH0NCiAgICAg
ICAgbWVtc2V0KHAsIDAsIHNpemVvZihzdHJ1Y3QgYnRyZnNfcGF0aCkpOw0KfQ0KDQpCVFcsIEkg
aGF2ZSBzZWVuIHJlbGVhc2VkIHBhdGhzIGJlaW5nIHBhc3NlZCBhY3Jvc3MgZnVuY3Rpb25zIGlu
IHNvbWUgb3RoZXIgcGF0aHMuDQoNClNob3VsZCB0aGVzZSBhbHNvIGJlIGNoYW5nZWQgdG8gcmVz
ZXQgcGF0aHMsIG9yIHNob3VsZCB0aGVzZSBmbGFncyBiZSBjbGVhcmVkIGluIHRoZSByZWxlYXNl
IHBhdGg/DQoNClRoeCwNCllhbmd0YW8NCg==

