Return-Path: <linux-btrfs+bounces-18242-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E1113C049D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 09:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 672AC355EAE
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 07:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757B028FFFB;
	Fri, 24 Oct 2025 07:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C0EiUeQW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vVoBkj6w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A91289376
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289605; cv=fail; b=VNkPCA890mHbRtQ6rH+U1DgffxP6KaurPK21E/Vg8xgWT31Zm+JnMWYkL0xAGBzmHJuIZiU4PfRmuVqG6P7A5gXoTe6zfvUGKYYXcnSb8Q3imAYq2d7iofwivb5wo4UeR6LNoLirAXZ29gqdCRmyqbAYKMopqGDd8QeEygetkdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289605; c=relaxed/simple;
	bh=v3SM4s+y/SvYedchjIwqn87sMsPZcjq9HuYWJy2Q91c=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eupmPEKsHUX1uKcOW+nVeo5Mfs5ZxHT8FeFKgo9s4pNbxzh0V2JNQ6a6jIqw0x7IM7EAw6zAA3sKMVoFaE15LfMAoS3Dy19Ts+PVtOqqbusApJxU1ZcOxfG9D3stYeQMg4UPYG2iTGB66D5UqYGdtPZkLxVzyRSZgGOqWrA+UtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=C0EiUeQW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vVoBkj6w; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761289603; x=1792825603;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=v3SM4s+y/SvYedchjIwqn87sMsPZcjq9HuYWJy2Q91c=;
  b=C0EiUeQWvbxLQjGyINsUrNUg3j0aIPiBVRrlXCZwrC9VKptQ4VvQ2lvL
   ZqgT9aBwEShHbj8JP/e3gwp7JaeM6Rp5Ww4QVHvgByCtwTzv7Z3+jrnFG
   IvjFNU9zzcFnseUVUgNB6B+Xcnn3QhScGO6oDZIIIzHkmpsM25EnRoq46
   Xv3J9m0jQENE22xzl7NmtX553AqD4i1O0xuQxF8CJjqcsVEUyT0NYz3J4
   f6J9k4Beb3b6E01+28jiduUbpg4LFB0m3cefhLL9jBzu9SiDecU0ciS9x
   j72WNIHsXohjd2zd5FLqah5IBnFth1JaLV7XeK6cBzO9+VnC+SWGR3q9G
   A==;
X-CSE-ConnectionGUID: RtsXhcuQTQqnrgD0oRMOFA==
X-CSE-MsgGUID: 17yrbWZkRKGG6lW8yl6n0Q==
X-IronPort-AV: E=Sophos;i="6.19,251,1754928000"; 
   d="scan'208";a="133483981"
Received: from mail-centralusazon11010017.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.17])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2025 15:06:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkVuasmDsDEougMJp24NjI5xYBBe01DeaGC5ps0mxnuv6PcLK0g7S90oipDXYE07P/ILfSdHtgt9alD9EzSdF8j1eknKb1B/NLTL+J+WZWPyrmSWkiAg8dOmO+jUuA0D0wkTPyvoSJA2HL7tLQCZfaJWw/GyD+wMVaitups3uAXKLEUjCcjqARBHh0e6T+PjovHIc1eIkupix1rmQYlYSK8ugemPyRBIh4UZSYWLE2BzxGZN/rOT7uVZn35FEMi99XSHJMVWuqX+GBX13T671FgTAWx9OPlhe5uJIbiCC/CArz/nfCtXoDYBhGBittKirJn7ADztHcdEhTMZQs7bmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3SM4s+y/SvYedchjIwqn87sMsPZcjq9HuYWJy2Q91c=;
 b=cTiiWYhyxqunP/NxtPbyEvyDO1QQcH2XeM67HvUoANoMm48/RL9qHYn50ghkfB24rlihtUUyMiIBvr32OXJo3g17VmTGJa1Q8cCFesPs+2tCY24FNuyQte/IFfhgt03mRylAsdYAK96rKBDBxFkmF2AIe9qdwJFO3cN6FU1p7YzfA+CQ+TnpWDlrK0q88Kho4k5A371HFRcOIc+IFwExQw+X1Iv/laXQp0+TP81oA6tXOUlPNJVISakSbF18qYm/0+C2CzyyF2tV6kF4BJplyMMt31q5v+qkps/lRsb7/Ewtr95zrd2omIa65kX8784MKzxhvs7r8mqa2Q6P0LEyMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3SM4s+y/SvYedchjIwqn87sMsPZcjq9HuYWJy2Q91c=;
 b=vVoBkj6wxspknxrU/jTx7tTeoamYNBbK9HhcIJoArx6RoV33R+AYrjaRGj0cRiaXeK2Go20d85wRz9LpIKodOAwYNp9jRc30Qt6qWiOMvao6aptUIe74dqddfuBiaHWIZeYnN8uLtY7z08ZbZd+dwFC8AmNrzXsNHfIONpOeXdw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6985.namprd04.prod.outlook.com (2603:10b6:5:244::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:06:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:06:35 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 10/28] btrfs: avoid unnecessary reclaim calculation in
 priority_reclaim_metadata_space()
Thread-Topic: [PATCH 10/28] btrfs: avoid unnecessary reclaim calculation in
 priority_reclaim_metadata_space()
Thread-Index: AQHcRDZVPQr2PQoxBkyWQv69GEzwfbTQ4QkA
Date: Fri, 24 Oct 2025 07:06:35 +0000
Message-ID: <816109c0-a32e-484a-897c-c234b866fd80@wdc.com>
References: <cover.1761234580.git.fdmanana@suse.com>
 <80186103f5b1185fbec7bc6e6b478bd61a221522.1761234581.git.fdmanana@suse.com>
In-Reply-To:
 <80186103f5b1185fbec7bc6e6b478bd61a221522.1761234581.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6985:EE_
x-ms-office365-filtering-correlation-id: f8da5864-ad90-46c6-7c75-08de12cbde8f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NytRTXFBMkh6WGJOMXZSck5DbThzOFhxWkU2RVBoWE1ybEZ0clZ5YWpadnNX?=
 =?utf-8?B?Mmd1VDZiZFFqT0hoUit4bnROTXllczhLbEF4Vmt4QWlnRGtUeDh3MGFKQWRX?=
 =?utf-8?B?Wm5ncTRaSGxzcVV2WEpKcmtUeFQxaTdhRW1ZZUU1ODdNcmozRVhQRzZma1Q2?=
 =?utf-8?B?bEplMm5xTTBPNkY0QmNaYlptelBMczJEYU1rLzRMK2lVbzFxdTJuVTBpMzlm?=
 =?utf-8?B?bTB6cWlXM0tETzFNT3BnWFc4ZUFxVmlhbk1SalNhTnhaS0lVMlpHVmczRXlj?=
 =?utf-8?B?N29kQ2RjNTlpOTlKeTAxejBZTE13dVpwZTAwSUtVallLOHRGWnQwdXNucHcw?=
 =?utf-8?B?SStqQTlLQ1k1K1FxdENpK21XcGF4ZC9pQlpxNUUvVUQxRk84cWlDM0JFSDFj?=
 =?utf-8?B?N2t4a0ViamFBMTU1QUhjOHNmWHB4b3pxUFpXcERhOU5XSjN6YTIxdTdJaW5D?=
 =?utf-8?B?eENxSHJpckhzUXRZWkg1WHJIdjRlaDlreTVqTkQrSDdHU2pZUldLRytsYm1a?=
 =?utf-8?B?b3owTWRoZzc5cjluYWVhdEVXd1BuOVNqUGxaM3Riek9GYit6RkNPWjViWWZI?=
 =?utf-8?B?N2xWdlZseWs2emlkcURGeWlOZmtBdXZVR2JUUFFYb1p2T2JyUDZNVG1Qc1hz?=
 =?utf-8?B?dU1jb0xXakVrcTE2NEQ4ZUFTTVVqU2dFampDbitWTVFZajVTcC9TZ0ZDRkZT?=
 =?utf-8?B?SkxnQmxMaHU2U1BEeWxnb2VBd2VWTi9ucjZtSCtEN0VJR1NibnpuTlJ3VXMr?=
 =?utf-8?B?ZiswOG5XQ1NGbHBNdlpGNmhzYVhZOTVURkFnZ1QzTlJyMHZzUDRYcUoyV2Fz?=
 =?utf-8?B?dHB6L2IrRzU1MnF0ekF3SlV0UTJuM1o0T1Z1YllHVndQdmJLQkk0UnVMRGQv?=
 =?utf-8?B?M29PVStEaFhBaEhGZEtHNFRINmsxTzdoZ3cyb0NNcGRhMmhxa2luRFV4ejEr?=
 =?utf-8?B?M2JOVDhoeU5NdTlSN1dKS3J5N3U5cWpDZ05FUjkyNStUaGphVDZ1WDVTTXBC?=
 =?utf-8?B?V2ZsdFlVVUlhN1laMW9XaHNWeGpqSEtqVGQwb1RxUlZMRFNsMHRrYXlFYTVq?=
 =?utf-8?B?eEVtMlhQMVdKVXduK25Ib1lCRkZhUVN6QVJUbWJRNHlNT3lKSW15b1AzRXhW?=
 =?utf-8?B?VTRMcUQrTERpSXV3cXRiVW5lczVSaDNvb2JaUk1rMDdWQkRvRW9BdWUvRmhu?=
 =?utf-8?B?eWwwaW1hQnJPd3puQTRXeTBGTms1SEtUc0pXeFVPaTdXZDFxMjNjSGtWSW9r?=
 =?utf-8?B?dDBKNnJoTllsYW02cXJ5RlFVTnR2N20vTEErWkhYQjhBWFhuL3ZHd3ExWGVt?=
 =?utf-8?B?WXRUWFgxREdXL00wYnIvNXU1cUY2Ull5MGdwT3BPa1QzRzFFcHE5SWdTdlRt?=
 =?utf-8?B?ejdiRjZINzFxOS9UOVJWcFkrcVkrTW1tOG4zWEhadHBMZThoMmE3S015dkJM?=
 =?utf-8?B?TzhuK0x2YmlXSTMwSjNGSFJkODZRYksybnhiaTVDdmhjRGJXN2FhMC9rWHZn?=
 =?utf-8?B?MVkveFBsZ3dFQVVOUFgyeHNIUmVoQnZVQ0R0dm1pSTlZSFllWW02ak40OE12?=
 =?utf-8?B?ekRCLzZSNitGR2hSTkFobzdNdHlGRkI1UXBOVDd0djdsc1o4TEpKbXd6b3l4?=
 =?utf-8?B?UzdmSnBCTVEvV0hKOHljOGoxZ1laZUdnUWV3czJRN0s5NGdDY2FZNllDbHlT?=
 =?utf-8?B?cTJRVk40ZlBWbmpzZURTRkFqQXVNbDhUL0E4d1EyMUhjS2dreHRFcUdMd2Rj?=
 =?utf-8?B?RDFTYkl6SkRGUExvT3BodldDVzFWdE5MTEZLd0JoWTUzMUxGaWNTaUJTeTVk?=
 =?utf-8?B?QjVJTnF4YkpXMXdnVC9zTVRGZFZLZ0xEZkcra21QVjJ6SE42ZGNXQ3lMbnMv?=
 =?utf-8?B?azVGbXJjU0oxNTdUOG1wVXNLenZPWFluSy9aeG5yZW1lQjE0YjF2Mi82ZVF5?=
 =?utf-8?B?ZS94K2FkMDlSdDByUVhtVVZjK21WNjVUN2RZR0dlcTVJaWE5bXFJRHFtNjFK?=
 =?utf-8?B?N3pWbTU5TVdTaURqSzNleGFRYi9UYmZQT095MlhIT3UweXNFbVducktvT3pO?=
 =?utf-8?Q?zYppKd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2d3Q3F4RDAzZmJwV3FPWWRFaFAxTVcyVDNIZVIwQkUrSm8waUd2bDRNTkJ1?=
 =?utf-8?B?QmVvUGc0Ylk4bkE5V3dBMjdjYS9xU2RyN0VwZFVYZXh0YjM3eTUzOUtXaVlR?=
 =?utf-8?B?WTcyNzdJOWxOZ0kyai9DZnVTU1U2bEJGeXd5TFY1ZmhYTmpYZUoycUNMcmtw?=
 =?utf-8?B?R0F4bDJmUWJYVGlwNmJCSlhhKzVjZ3VxYTR1OEVNUmNWMWJBeFJCZnFCR1Yr?=
 =?utf-8?B?cnhZUjJPSnpXWUp0NzRyN2lsdzJtQXlRb0FCS1kvWGE0YU9vcUQ2SndwOTZW?=
 =?utf-8?B?NjlZSGV5d3lJUnBmSEZhUGFhbXNsZ3BVeVlRSWs5YzZTSklFU3NZQUlRdVh5?=
 =?utf-8?B?UDRybXFRY3FpbysxRWlVU3FGeUEzUm1ueHJ5bkN0TjZNa1NiSzRibWpHZkxL?=
 =?utf-8?B?MkZ2YVlNRFEvTWZYenBjNm54M0tJcURVSTlSR0FmeWUyRGRJakpObm5BV2hy?=
 =?utf-8?B?ZFR2TzcyNXVqTktzMFRtNnBNalBab1c3RnFjV0hDV2tUVFE3SHpCQzg1Q25z?=
 =?utf-8?B?cEFFUGlDL3QwbG94SGw5M2NiMytOVlBMWW1jN0R5VHpoNCs0RlZsNXdFSHBn?=
 =?utf-8?B?RXdWbXJyV3M1UGlaVzY2OFovSEtuVlRCdmR2a0xYK3UxTVRsY3hOcjZGMkxi?=
 =?utf-8?B?NjB3d2dEK284Ym9HeVFSaHBFUnRzRytEV3dBWFlGVDBCdnowYlN5QWpXYlcz?=
 =?utf-8?B?Rm9zR0lUQ1F2d0VzRG5xVm9yeE1oaXVGTHF2MW4zdG5aQ1hCRURqbVFMRnlj?=
 =?utf-8?B?eGFhUDR1NzBMeDBqWmx6bjNPd3ZiK3lHblhsdFpxMzJ2ZTBWNks1ZFZhbks2?=
 =?utf-8?B?bUlxMWVqV1luT0pxVGZtVVJ0UnNRYkxzbElRcnQ2MXZPcEFCSEtQNmd6YzU1?=
 =?utf-8?B?VWRwNFI3SmJlSDFzd0wrT24wcGJ5cVdUMHhIWmJyZXhpK0RXSjNlWmtZZzE4?=
 =?utf-8?B?am9CcFdHZUg3L0xHMGxTWFlJVGhmSkgzNUtZQnh1RlEwZWVxaG14YmJad1Nu?=
 =?utf-8?B?NjNSZEh3bmFreEpPU3BmNmpKYU9Ic2RLdUx4NlJ6ZmxZMzBrV2hRbnRjTVp6?=
 =?utf-8?B?cGZkT0M3YjRFK1hQRDUybnEya2xHTURCOGIwV3Q3NFFCa2lLY08xb2IzMDBi?=
 =?utf-8?B?RzliUE50cmxsZzNCUk5FMW5iYzNHbWlLYTcyZ1lGM1lLbTJpS21zcE9odW50?=
 =?utf-8?B?RmZoREtRQW16S3pDOHpra0o4K2tZVS9OVlhjOWxjSTZFWUlIT2xMdzl6eU1R?=
 =?utf-8?B?a1d0TmlLVU9TZ0hpZVI2ckx0ejE0bE80UFM5akpROWd0aFhWVzNydFl3c2Mz?=
 =?utf-8?B?Wk9LL2ErTStJQTBITGZPaFRtR2M3TzhPSDVsMmlJdFprYmJvZmNMMExhTXZV?=
 =?utf-8?B?VmoveEJ6Y29PNHZZNXI1YnNtSzlPdDN5aytqOGVsT2RGMkc0bk9VTXZoYUtl?=
 =?utf-8?B?REtoOWc0MVB3VFJQWFdkeVgxNXk4QzNaazQ5VzhaSWJtcENNMHRrQ2k4clBV?=
 =?utf-8?B?Z0x1RWRTS0tuN0VLenNvMTI4dHJqTWdURDdNOXRHOFNmVC9CdUhDODN1UWd3?=
 =?utf-8?B?Uk4zTjkyblRVcHQrNkxwRVlLQ0RlS1g1ZGdxUjBCYUpJRWZuVHBMWWxGVXpJ?=
 =?utf-8?B?OUhKa2pIdzNnK1V4L1JPQVc3OTIyaEgxRmhoekpZY3NmMW0vVW5ORGU5cG1C?=
 =?utf-8?B?TXFTNlFXZFVFY2FXNUhySjU5OEprUS9hWGFwaElwT1I3bFIvaUpBRWZSM2o2?=
 =?utf-8?B?ZklhMEZyR0hyUjVZUVJDZW5ZZlhzanhnN2gwTE5jc3hCaGk3M3E3Nmx6QnpH?=
 =?utf-8?B?ejlmY2w5ZWUwaER0dnUxRDZlQVlaL3dEem9kYUJ5QXpRN3JDZjdLSWEzVFBO?=
 =?utf-8?B?aEIwWE1va3U2YWs5YlkyZ2Fvd2R6VnljNVNGUGswNVNVRzRwcTZNUXc0SXBm?=
 =?utf-8?B?eTlOUVgrR1RvUEh1STRJdVJzYXRCdGR6dndvdFJ3NUhacDRDZjMwQXVnY2RY?=
 =?utf-8?B?RkdTUEo3N2RyUldLMWVnVU9UOFEzNktzWFBjTHpvcENnOG1tdUlRcFVDaVFp?=
 =?utf-8?B?OGtsdWJJc3FDc1VFV3RJSW9XQVlZWDU5K0VIRHJ4VUhaSkNsWTg1WG5jSEdk?=
 =?utf-8?B?Uk1MclhNU0lXZmpVbyt4eUdtdy9TT2VXRjU2ZDNZMjlFemZVZmkrNlJzcXpJ?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E55606E5C9155439B567EEE1CF1EE44@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q9/9CmGgIWYD5RRKNAefS+wHvVa1BMsaARNNvPMR47ic87kMWRBbGCle8StczyNArGk4qrP2FyvpT60kxNSLvclotO1PA6IV3bGxbW5FrY0EPHjTT5D29fyYHCBADg9h7J+Mhm/v0IwSt6I9MYOCjr0sPff7Lu36zyhYkTnudt6N9m2/LGWlvqyMP/Zb93rtKPNI1R2zd+hw4yddjsixgGgtoQtHeF17tDPQdocYNLXcW5eJn3nb+ZyAW8o18wR3oBlW+qoYU4Sxi78J5FRAeQRdPTPghU8EHC+e+/9RagqeNH9Qq0bvZSEkE2CoOdeAklgp7hi2mO+EkFobZRN2aeIWt742/cHD1An0kw+mCIGGB3CRRwqzQ6PA457bszXJeqiv38ofPxNJx22jPEVBqi6D5Ky+AoRKyetubXz7FQF14H/f/80mu4KhtJcCr3Juz4WiA8SXGykvSLVOiqs1n+OBSU7JLBQC5gQ0IY236mSR5ahVAS822m0dckY/2GtD0Uuk8bPG2SoWo6nGx1cxm6ivipgujGG6RjVKV2BMPBgFjcocpTrSjDDD9qKuLmkL11Fzk33qH3OK974LYdvXV3ZcBgPL5Yw5e2vH3u4Ct8cywJj+P980uk7ryaOj8hGz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8da5864-ad90-46c6-7c75-08de12cbde8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 07:06:35.4674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W19VtuC4rG/AsfLDSoX6+ZRlLpxghVzP6LXIIKGjOw9WKOFveDWR5RP0KtowQqamib+lwhaEFb8dsXe9PoMNKmQbcKLYwr/vx80TVsxre3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6985

T24gMTAvMjMvMjUgNjowMSBQTSwgZmRtYW5hbmFAa2VybmVsLm9yZyB3cm90ZToNCj4gRnJvbTog
RmlsaXBlIE1hbmFuYSA8ZmRtYW5hbmFAc3VzZS5jb20+DQo+DQo+IElmIHRoZSBnaXZlbiB0aWNr
ZXQgd2FzIGFscmVhZHkgc2VydmVkIChpdHMgLT5ieXRlcyBpcyAwKSwgdGhlbiB3ZSB3YXN0ZWQN
Cj4gdGltZSBjYWxjdWxhdGluZyB0aGUgbWV0YWRhdGEgcmVjbGFpbSBzaXplLiBTbyBjYWxjdWxh
dGUgaXQgb25seSBhZnRlciB3ZQ0KPiBjaGVja2VkIHRoZSB0aWNrZXQgd2FzIG5vdCB5ZXQgc2Vy
dmVkLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBGaWxpcGUgTWFuYW5hIDxmZG1hbmFuYUBzdXNlLmNv
bT4NCj4gLS0tDQo+ICAgZnMvYnRyZnMvc3BhY2UtaW5mby5jIHwgMyArKy0NCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQg
YS9mcy9idHJmcy9zcGFjZS1pbmZvLmMgYi9mcy9idHJmcy9zcGFjZS1pbmZvLmMNCj4gaW5kZXgg
OWEwNzIwMDllZWM4Li5iMDNjMDE1ZDVkNTEgMTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL3NwYWNl
LWluZm8uYw0KPiArKysgYi9mcy9idHJmcy9zcGFjZS1pbmZvLmMNCj4gQEAgLTE1MDEsNyArMTUw
MSw2IEBAIHN0YXRpYyB2b2lkIHByaW9yaXR5X3JlY2xhaW1fbWV0YWRhdGFfc3BhY2Uoc3RydWN0
IGJ0cmZzX3NwYWNlX2luZm8gKnNwYWNlX2luZm8sDQo+ICAgCWludCBmbHVzaF9zdGF0ZSA9IDA7
DQo+ICAgDQo+ICAgCXNwaW5fbG9jaygmc3BhY2VfaW5mby0+bG9jayk7DQo+IC0JdG9fcmVjbGFp
bSA9IGJ0cmZzX2NhbGNfcmVjbGFpbV9tZXRhZGF0YV9zaXplKHNwYWNlX2luZm8pOw0KPiAgIAkv
Kg0KPiAgIAkgKiBUaGlzIGlzIHRoZSBwcmlvcml0eSByZWNsYWltIHBhdGgsIHNvIHRvX3JlY2xh
aW0gY291bGQgYmUgPjAgc3RpbGwNCj4gICAJICogYmVjYXVzZSB3ZSBtYXkgaGF2ZSBvbmx5IHNh
dGlzZmllZCB0aGUgcHJpb3JpdHkgdGlja2V0cyBhbmQgc3RpbGwNCklzIHRoZSB0aWNrZXQgKG9y
IHRpY2tldC0+Ynl0ZXMpIGFsc28gcHJvdGVjdGVkIGJ5IHRoZSBzcGFjZV9pbmZvIGxvY2s/IA0K
SWYgeWVzIHRoYXQgd291bGQgYmUgYW4gb2RkIGRlcGVuZGVuY3kgVEJILiBJZiBub3Qgd2UgY2Fu
IG1vdmUgdGhlIA0Kc3Bpbl9sb2NrKCkgY2FsbCBiZWxvdyB0aGUgdGlja2V0LT5ieXRlcyA9PSAw
IGNoZWNrLg0K

