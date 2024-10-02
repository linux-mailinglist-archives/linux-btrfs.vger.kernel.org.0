Return-Path: <linux-btrfs+bounces-8421-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEBC98CE9C
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 10:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366B9284B82
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 08:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EBA194A48;
	Wed,  2 Oct 2024 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IVAE5ORx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pawGTKPf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF2C1946DF
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727857134; cv=fail; b=CvJ+PhVzIQJfwNGLUSTX7gXMX1VhkTlhlCxIhyGfwOMnu66rGv2TI8L5fOvVUX722i/Pgt3UwkuHrQo4lnAjIoIJJmKM04y3dAWRTJz+b6gNW7up+aaegj+2X8ukQxD22Zhru8IZtRCtm2DklkR6vPxukrc2DAq1pj/wAWqA128=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727857134; c=relaxed/simple;
	bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HhjES7DIRpfgu9AqubJYZCVssyKtWELnKedacsJJjGxPkNNMJxhXa4bpq9pnGX8m6zdwt03/Ht9xo73dzK2eeFmT15kQ+gadloCR3+3V6itsmhkct4XgoaxpwxzcNgc9iWRPPoFpOfur7ldq8wpD2DapgGlF/Z4ylD9pdMpIhUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IVAE5ORx; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=pawGTKPf; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727857132; x=1759393132;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
  b=IVAE5ORxF0bfnFHzvnmvSwbsWqgpMoc2DO8Mihu5jH5R1/9aXvw61sag
   T1480X+/plivNdPUR2bEJ+MgUhI99QREj5RzGEQCVsadv/2E7DoGHaBju
   nTQU2HNQcGNp2acEhhnQKmC2C4S9n4DuBd5vknM+zZ06fvfAFn0XC314n
   e33HuONavTG8DprEamHSr0IWL+3U/J6RuH+XmymK240fXhFN41Blod2Y2
   qfS3vgWwmm8oSW6vegiiU9bFrtkPF++Qy76DSNpcyZXXZqLp4tAgufSYT
   oXZz53amcre8V9UO3nn8RzMwFeb2WO0jQdsizVUaGnmzqHILBdDJPnz3X
   Q==;
X-CSE-ConnectionGUID: YvGQpe9xQDCtM+Yc+uuudA==
X-CSE-MsgGUID: I72ho+QyTJqm9bK9nujblw==
X-IronPort-AV: E=Sophos;i="6.11,171,1725292800"; 
   d="scan'208";a="29143955"
Received: from mail-northcentralusazlp17010002.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.2])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2024 16:18:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkLg/A7V6G1LHQsxXNAMYp7ZxLzWKymf9Co0DnUOTlMhVc0Y/36S7cHSNca+EUCMOJk1mkLLZ9p7oMEi0JRUmFQlQM0jZugfu0CLx6/rxidvj1k1dgZW6gMVOC5mDmFnH/oykWf7bosNfB9wE+vE5MD6mjudvAk/6CifsaCQr03VW+mlgpP+XQP/mLTjnxaG8hmkxmf5ryvGeIoF8YaGX1MrCZ2AwjjfPW8hVcLyJv9UoSDPJlemPoI2Ei3Actyz840qGYwSEKMdw4Pu3VmHcOaD7vj/ByspDdZIjdeZmzKYa97+fYmngi02XHoXLVZjE7V9zMprOSqu/rI8UaNA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
 b=S+IAoPH+VYVCK5k19wJdPpSYkzl6UOON14l2TX5x2XDUssh817MdpfJ5iSgLUiaiw2OJaTor4l/Fx9FJk5e9ah2obSs8rG/qzdfYNSSXDvMvI5q4fgH/fc65rcPumQqP/ycbrHYxIr+GkvCKz1jXh6ltwDZz+bfSL+czLPpEOsODlC8DQ7qybYI6SV0cvpojFnZZpZ43ZFbs65mBLshwDwRaUIDIbqzSfai8jNpIIZImlvncL1m9CtX/EqjiodaqdB5YDhsKuiCcb7g/8sZdjPHpafl8uqYTD9c/Gr5iZcZcZxPe2ahrIdGP+eKWD5GvUI4OO2ukeTKo157fBLdffw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
 b=pawGTKPfdZ5fToq1g9+ICgAmJVljteDNxkPN90cBJZ9FHbNHWMcWrqookPXF5/ueIrTwzOl9xZSsSpXDtCaznWhwZZC88jLsPQPb7HLcI3mgDytG5DoEORtTj6Sp7laF24+A6bRReTgJY+PFsjBs6MvzsJqXi6xHVP5jTuRM/SQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB7905.namprd04.prod.outlook.com (2603:10b6:610:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 08:18:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8005.028; Wed, 2 Oct 2024
 08:18:43 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] btrfs: small cleanups to buffered write path
Thread-Topic: [PATCH v3 0/2] btrfs: small cleanups to buffered write path
Thread-Index: AQHbFFg7hWCXrwDqVkKks37m+S5QIrJzHrKA
Date: Wed, 2 Oct 2024 08:18:43 +0000
Message-ID: <2100d065-5527-44b6-a29c-80aa239d830c@wdc.com>
References: <cover.1727824586.git.wqu@suse.com>
In-Reply-To: <cover.1727824586.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB7905:EE_
x-ms-office365-filtering-correlation-id: 53805804-1a4e-4623-f735-08dce2bad46b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QUpGcjRmQ09XMzIvQ0hzSDZVTEc1RU43cUlodWlGSWFtakx1UExBaFRBZ0xz?=
 =?utf-8?B?TGk1SGpiR0F2RTBYbUF5L1dtdVo3QVlFMm5lRU8wLzkrZWNQV1BQK3AzcWp3?=
 =?utf-8?B?UW9MSVRtRDh4WUhMTkljd2xiVUR4cUNjNW1NS0piT2ViVkhUK1F3Q3hVUmVB?=
 =?utf-8?B?Tm9rQ3JZNngwMGJsVHJ3OTdVZTNBTjhzdEVYL0wzandFODdFTGdOVXB4alZU?=
 =?utf-8?B?Z1A4Tm9XamUyT1VteTgxMGNuMXRsQUdLejI1OUQveDdEQlpBVkFHYUtnNVZw?=
 =?utf-8?B?a25hamFialkzYlIvSTg1a1pZbHZVVzZ5KzI3OEg3MDUrYlRBUlhnT0VOOXc3?=
 =?utf-8?B?c3JLZHZGZ09kUHYzNEgzNFhlT2M4eU1DaXlMMWtHb0VaYTV4RCtPYlZkTGQv?=
 =?utf-8?B?WFpVZ3JnWDJTVEx0bEdwVVJWVjI0dTJkbnNLSXAxTUhvVGxFRVdjcEFBL1Vo?=
 =?utf-8?B?MVp3NUpDdWlzWHZEWmxNcXhTN3B4S2xqM0RscmdlK0RTWGF1eFh6dXBOWlk4?=
 =?utf-8?B?cWE0RWs4RElFVThTNDRKRnk5NlU1d3ZCTGpUL1NLTzJqZThoMzFVSC9iSmJK?=
 =?utf-8?B?ME9TOFBUM0QwdktZaHBhNjZFWXEzZXJKb25udXBDd0l5SWFqYk9jd0U4Nk1V?=
 =?utf-8?B?b0U2Q0JHVzhiNWpaTDBaUThEeFg4cmwxeFRxcEwwWTArRHMyWlN5TWhDWlht?=
 =?utf-8?B?TnlkSlhvSGlEeFA3eGhaN1dPVGRNajNsZXYxN2RvM3VCc1JteGpTU0JsZ2Zr?=
 =?utf-8?B?TnZNQ1Izd2VORm9DRG55UG45ZE5SSGM2aVJUUktMZ1VuWW5mL29JTDF0am5z?=
 =?utf-8?B?OUxpNDV3TytCT3NmSFArMExER2s1WlhnR0NJVlZlU1o4QzJhUEdOcjFwVVZa?=
 =?utf-8?B?R0dobTg1M012MVNFa3RPQ2V6QmVEZ05EenRhcVZ3ckViZ1hUdlFoVjh2L1J5?=
 =?utf-8?B?NDA5L2hXSmtkcWhHZEdqTGZjdjB4b0xGVFlId0VsUzN2TXZ4Y0NoTXR2V2Jm?=
 =?utf-8?B?Q09xME9FR014YVVDWkhQRDA3UlZFM1VxMDVOWi9nbjlwOGpkQW1CdzRLOXF5?=
 =?utf-8?B?akNQMDhUcFpLVXpWeWprSnJhRnlxQ2FpTFp6N1M5WEhvVm9LSG9PN0tCSUpC?=
 =?utf-8?B?elBhYXBOdGdscENtRXBlY3FqaDk3Um5PaG0xQmx5UnUrQTdqcmJoQXZnRUNp?=
 =?utf-8?B?allNSnk3RHB4ZTlWMG4vZE1pdTlVQjMzZTZ3WHQ2SEdicnBWVVBYbyswMmpH?=
 =?utf-8?B?UUFwb1l1R09OYVBKNkZYL2c2SGgvM2dZZUtaR2pmamZBalVIVDBraVNDdC9q?=
 =?utf-8?B?bmpJN0M4QURIQktIM0s2YmE3VkhVZVE3Ky9TbUF6SDgwUlV5eFhDTmo3Z3V1?=
 =?utf-8?B?aE4rQWttKzljNkREcGUyYzQ5UE0zaG44anpEMDFsT2ZMQ09iOW14K1ZSc0Nr?=
 =?utf-8?B?MFVvYW1kem5xcHU3VzlGdExJSWZZWkY0enlZcTAvdFFTcG0xamIwcGFubk8y?=
 =?utf-8?B?bXV0NE96T2NMV3VtSkdzUnMrUFp3c3ZwRVErWGIyMzNROVRJY2Fhd0NJN1lT?=
 =?utf-8?B?RWx4K3JCd3VsYnhyOC8yRVdDbWFHRERhN1k1MlFFa1lmSDd1RzMwR1NZbFlN?=
 =?utf-8?B?ZmdIVkQzY21PQUtMN29hODFwanlONlBkdUFZMVlxbFZFS2FwTW00VHhqUENW?=
 =?utf-8?B?bmJNTUpaT0EwWER6WFJFbEVnVGdiQ2lQVnZJQmIzaFljdSt5ejNIcFBPUG1W?=
 =?utf-8?B?TlBqZTRZd1ljQkIvT1pIeE1JWnlwR0c5UGh4SW9lalBKbHIyT2NENWhqKzlB?=
 =?utf-8?B?SE52WDNLMTFjczl0NHFjQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YlBRZms2c2tZczBrNkVCMHFmZ0ZiWEhoOFF3RysvNkFNMmh5ZXhwZlh0SHgz?=
 =?utf-8?B?QW9qd2xwN29HSjM1eHZTVExRN3VlYWg4ZE0vOFMzMWhhUHZINUhKSTAxNXRZ?=
 =?utf-8?B?emdDNjBNd3lSbE80WHZPV2lqQ0F2QUppc1dCbTNXcUc5OFBGTjBMNWx5cEFW?=
 =?utf-8?B?Qm8zQ1VJTVp1UnN0UUorU3dkTHlIbndBTE9PdGlZbnNIMUlPOVpoWWpHWmtB?=
 =?utf-8?B?aVU0SHF1NHpRVzRMSzBKWUV1anVIUFVmMitRdENRQndCMkdsTktqQzVCUVJx?=
 =?utf-8?B?dlhXZ2xnbUVITVFBQUNDc29GektGSUFXTnZidDhEaW5XM3YrZ043WkJKMStl?=
 =?utf-8?B?TW1LckRXZU02WkJPVkk4QkM4U21SQ2M4dUR2MU1yUWpJc1N0ZHcydmF5SElo?=
 =?utf-8?B?NjNobi96dG80MXZMS2k0QWZESE1NYW5xRS80UjFrQ1lHUUlBcitnZkM3QTF5?=
 =?utf-8?B?VlQvaEFkdnRtL1hsRkczaEt6WXZLVVJPRnE0VzVzNElzTkVBVi9aeU5oSzBM?=
 =?utf-8?B?QjZLZHBGb2g0ZUY5UFJ4bGxGL0FyRW0xVjNremRFcjRUVUlVdEwyZEVsVUpI?=
 =?utf-8?B?M0VEdG1WVHRybGFpMTNSZ2Zvclo0U2N6ZXZOU2dpSGFySFlLWlQwNTFNTGtS?=
 =?utf-8?B?KzZ5eWJ0S2RSYVVsRWl5bXFyVThoSGxBTEdCOVowejBhdmhXeWhuM2lNajM3?=
 =?utf-8?B?UG5CMWFXK2xjQnNXeFZqMlBjRWlQbi9IN3NrZVAvcEEvZXdxR2FUZDVpcVd5?=
 =?utf-8?B?bURkdGpHbzY4ejY4UVpsenhPV3N2bWpUc0VwaFpIa1BjVHV3SnI5eDV5aXFP?=
 =?utf-8?B?TXZ4dGt3Z0xOd1JkV2RMZVFsa1FXc3BCMW1YZVlhYTFCQzZUcVR2U3pTRldl?=
 =?utf-8?B?c3FnMDIyeHp5eFVEOHhwejNpVzJqT29keUdDdTNaNUhJT3oxWmRQckQxUHZQ?=
 =?utf-8?B?cDJuaHo1TXBBTVRndE5mMENnYmFSOHhkajNiU2VBeHlrNS9rUjlVTHdSR0pu?=
 =?utf-8?B?VmVuaXFYaFE1V3dBLzV1SWQ4aURhVmZ3dW1MLzZUMTJoYVFSYjd4dVdBcHlj?=
 =?utf-8?B?MXBvUnZ2RkRTRHl5TVhJUlNrc1RjVzAzSmNOc0dUMmZ0K2Z1TXloRXVhdzQw?=
 =?utf-8?B?OTBNc0VvWStGWWxmUm5RT2RRMU9sUDJkNTNoRmRFcDdRN0VWZnhCWEJKSGU3?=
 =?utf-8?B?VUFYSGM3TldXWWc5OHBNRFZkcnN5WEdveVlHMWVpM2RLTVUrb0J4YVRoNUU0?=
 =?utf-8?B?WmhaNzVINlIxVFE4RE1hRGY2UndGYmxleWRoZmRiN09EVEJON0Ztcm02UkxG?=
 =?utf-8?B?NzlmL01FVStxSDNnNFZkRUF0cnRidXcvcXRJN0JXSitTOWNNWHo5RlVCbklZ?=
 =?utf-8?B?RkZTZjlnNGlUb2hoWmIxQSt6N0R4K0VIeUFhN2kvdW53OGpzdTRmeFAxNmhW?=
 =?utf-8?B?OTI0L0l5MitWekdrNE9YUXJWdGhEYTdQQ2Y5VEFiakhXdyt5NzYxWlR3RW9w?=
 =?utf-8?B?clErL1dkWkNQWW5JcWdST1FBUS9YdnNWN0ZZY3NRRStuc3gxZnZGRUFnZGl1?=
 =?utf-8?B?SzdEbGlhQ3RuZzZMQklkUmUxaXc2L2xKVE1ndEc2Und5cjZjdjJVTWJDNENL?=
 =?utf-8?B?dHcvK0VRNDR0bHdxMUtBd3lDMG4xYWtvTEhQdXo5OHRBVjRZbkYxcGU1OWE4?=
 =?utf-8?B?U3NURndSR3ZUWEpzeE50USt0RExoNmllSWJsVHM2cWx4aDRRQmJKR2Fja1Nr?=
 =?utf-8?B?ZUp2U2tUcjc2MVh3bGhqKzR3VzV1WW1BdHpKajZOeWFjczVsR21WYUdZWnV2?=
 =?utf-8?B?cTViSVBiZjlEV054RXlBbEtRc2R3UnVPNjlPVElDVWdYdzA5cXlYQWFFSUNO?=
 =?utf-8?B?S0NFT0o4bHFpR3pBMG9WejVIMFdDU2dDRnlKN1NGbmZ0UzNPL0dKZ2VSOXhV?=
 =?utf-8?B?a3NQdi9JRHpGYlVwWUFTdndxTjBRMTlQSTZFNGZlVHZHaWtjMnFJd29GbWVN?=
 =?utf-8?B?QkpzVDJSZVdyc3ZwbnZTajl4VEsvM0JYS1F6THpUMUlIcEplQWhOMmdNQU5R?=
 =?utf-8?B?YVoxNURqb08zd0ptU1VjNnlCeWZzUjdQVzhoMzJDaGdUZlkwOHljRmRQWFFF?=
 =?utf-8?B?enNwMWxTaWZtS0JTbFVaajlFUHVRakx2U2UzcWZGSVlPQ1JFM0c5dzZjOXVN?=
 =?utf-8?B?OFJwU3kweElUdTFOMHgvM01PaitJTHkyVlJKa3lUelQ5ZGx4cUw2bENRZHJs?=
 =?utf-8?B?Tm93VDZ5UmxCT3RLRlFvSTRZRzlBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8112EBF476C234684FA08B41654BC70@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j6g+tKHT3Wq2QB5riGfptRusmIScYu/iSdpGSLcSGHts2gUcdXloMsQxryzJbrKzGjU+4x2Dm3IKitKCkUvf0Zd32fU0QTK8CFDDEInrzS9BcNJXg0qaRkwz5wUALMQiBCv/CVMrpq+KLJqs24+OYs6bpOHaQsj+tvMx3Tpsfgcp5toyBRlznV8aTYBWi4naMSvCTWqCBw1RL2vqZWeNgu/utOJKHTKesEBBV+UfWBvltvzhK0KRwtGTuulpVRskaJApR7KG6Sx19V82dCKsQ1uW1pJ/d06wPmntZX+7HYZoZJ3lx3kwfcy3cgRiQ5DlFiHeLd21D7KGm/WVREv1UdNZG61qu6hBMxtYBO/TpO5UHyX82GPcjZS5E9bKwZ4lyVVe+2IfddHZiUfm1meqv8wpVLkuPQWaV8bX46nbnlJk2dbU/Zv1GkVFkjQTfJTt2nolac12OUfbkuqPD3PQFPQdT2QqAMkcAZy2Z60yaVQ4PKl4k8gg2rK22Qh2ndEfE25N9DvmVYDfP1TWF1xPB11yDCfM/xxPBucuwEostK2RsWUzIGKCHjyZ8u2aK+vVsUwPVXB77AviMtDWtURKy/05TyaDlMhbKqCQ9nyBHcM6SgaO/Ix41PGSSwEr0UCr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53805804-1a4e-4623-f735-08dce2bad46b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2024 08:18:43.5263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yj6swHlhjVqncLjmyWNT93Zp+dMnOS35JN1cimj4pctTliD6XxVEZAb+LOooQXCGBX4hVRMU5ZB3Fo0Sfttgr9Hs2Tg1lvvNk/214sKslh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB7905

TG9va3MgZ29vZCB0byBtZSwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFu
bmVzLnRodW1zaGlybkB3ZGMuY29tPg0K

