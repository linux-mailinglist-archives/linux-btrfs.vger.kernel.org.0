Return-Path: <linux-btrfs+bounces-9886-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F04F09D7BC0
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 07:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD002823B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 06:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61B317E44A;
	Mon, 25 Nov 2024 06:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kMavkOoM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VqraJ1pR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3631E517
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2024 06:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732517662; cv=fail; b=jfdQ7QX1PmlXnBGmkTIa7sHhCdC3eXJNd75zs5LyHB7gCKz9HeSYe5pzn59pypZWXF2VNz687mY+Eh+SGFZ8FsRo+XisGSYtKm1h90KKRA/fOAXdTmjKeelJ0jypEGmhBoFDYaLz6AWQEHHvgWOhkx6MJO01c1KamHpZbkXwlMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732517662; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MG3P+wDkA/+ZPOd5DctlxPCO5HNKR6tVKyZpbL8y1oOmEg3Wc7S3p+17U+X4j2Kga4NOgawCsHmRTJjrf37LxPZdj/o6iTgAhotL+QfUX5wPzz9BV4tF+4P53s5JpFObZOVIAaM1o8iw7/hxU00BrPLjAHtOmB2c/ldVLvtkzVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kMavkOoM; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VqraJ1pR; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732517660; x=1764053660;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=kMavkOoMlbAxwH0uZ+2HFVrkgY3ZpE8y6RygEY/HiUyIlJNpoLyoqpsl
   0u1EwVOrHj/61YRJtEUXFG7m8mkeMnNH4QZ4I5VZvFO3rw4Qi+D6r8IAV
   QW6FNzzWFL5VpDZBhFUAGwyfpbDWRRUWBGfBH7ZT1rn2RXcu7Psj33ykP
   PDrYplDAaC8qqmoXFAMs5gSRixvgpjjldxuGaFJN6kfWZG/e4q+RWA2tM
   bGsBfjY8NLtWUVHiCL6X2krrnsNQWHi6JiBDbc2KisICr4KlR7QpgoQPM
   qh0xl+or+iaaT7wGbg7grVQl4v9xQ5SOAvKDQWhE+5LmjYj1B8otyFeK0
   Q==;
X-CSE-ConnectionGUID: CikWlkfnQyCOUD5eN7+CYg==
X-CSE-MsgGUID: bgtL/jdOTwOk0Cy9MMA/Cg==
X-IronPort-AV: E=Sophos;i="6.12,182,1728921600"; 
   d="scan'208";a="33340600"
Received: from mail-centralusazlp17011024.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([40.93.13.24])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2024 14:54:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLAXE/dfm95gS6hL2mIHcrOmhrmdqZ83z0uxFmMKqARBKoTG6NI4IP1HzaDSXFBPZTjX3RiP78tDZeKWccZbmd7PQT7aoXx+UsjhEeWYAvoNnRYt8M0L+jundL/Abt+VgRlgcqwtFi3QGF/W9JtUJO7Xuzy8VKW+yNU1y1DpMhaMfWYHA4JYKzAHu7sFaqVuwyPW5+HZ+wxpMBuThbMztzym3dg22sEvpodK6I5lQ2W/vdLCRNGDih3aBd1O6ulOMDtiOMwDVElUV/PPSq39QT1/0tRKxkMZF0L+JaeGls6S9u0eOLZAtAjgtfGhZZwYDgdORGKIGAU7nXZNi6TbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=xR4+NWcZNiYYHZgqsb2lGqf6QB8gm1adZB7/ufAeCeCR4sF9cL0GDFjyICSthQhys8kgxBDbfRZu1p3L7bWKY3CKGPKq4zyRdjeZJsxb/aI6aMoADnl+lSDEnmcsk2wSMMz5A1lF9egS7zMGTXqOvhiM8oL2U4kxMDO03fs6bso/ICBqxpVh0NLeY5M+odgTLJiud3a3zPa8aJ13PcMZJJ1KEOrGu9B47rQsER2PyMnnlMbaW7Z1gGWi3pvOoA6Uy0mKdGt1gxT8tRMxzulHFQJ1l+VCtvjRfbVQmnogKIX6nC0dtgwxaPhutS3U30YkCjiAMVeAlzuHYLfh1eKVtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=VqraJ1pRtg9TqJwiMUs2K5KboA2LcgAQ0/6JpewFKHQVyQw3y/0YM9r6N3z4cK+mB8WQMF53gu3UV8M70G9w5+famMkC4KRyrSpGJTlz1Zl5O60GRljncoecSKrU43TYWfLPSQefUYt6J2dxgr39yN60596Am3ohg4+5x5pV3H8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8732.namprd04.prod.outlook.com (2603:10b6:510:237::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 06:54:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 06:54:12 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use PTR_ERR() instead of PTR_ERR_OR_ZERO() for
 btrfs_get_extent()
Thread-Topic: [PATCH] btrfs: use PTR_ERR() instead of PTR_ERR_OR_ZERO() for
 btrfs_get_extent()
Thread-Index: AQHbPsLsePhokNc9OECbRxyXPYnWXLLHkCOA
Date: Mon, 25 Nov 2024 06:54:12 +0000
Message-ID: <c6f872f7-1fa7-43c0-bad4-d2f29b33d7a3@wdc.com>
References:
 <1453d9d1513fa03098f5bf4d2fbecb29f7fd1332.1732488201.git.wqu@suse.com>
In-Reply-To:
 <1453d9d1513fa03098f5bf4d2fbecb29f7fd1332.1732488201.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8732:EE_
x-ms-office365-filtering-correlation-id: 5fdfa97a-0012-404d-e1a8-08dd0d1df802
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aWRUT3FGbmN2OTFHazJIWDlPb1JobXJDV0JZakNjZ1Z1ZWo1QTZ3K1ZJU3Fh?=
 =?utf-8?B?MVE2bjBwMHc1R3Y1ZG9BeHVkSjFpMExVN09odDdCTzJ2d29VMkNNNnNXMmVF?=
 =?utf-8?B?TDZlM0hCeW15OWszVjU4UEFacFg3WkNtRVpJdWd2UEV1TW9LYVJSd2FRbnBB?=
 =?utf-8?B?eDBLS0lGNGtFRnJLU0xIQThlSjhYdFhnem9pVVZ2SFBvTE5YOW9MdzQ5WGxh?=
 =?utf-8?B?TnpnSUNtRmpzQVFpK1BMOEt3Rjh3TlMzOFF0MHdUQkpSWHFCdjNFOFhISFhl?=
 =?utf-8?B?OWNLZ1dBMnE0OVI3UmdnSUNDREp5WXVEOWRsMlNsZUM0ajlLWDI1b01BQzBZ?=
 =?utf-8?B?eHAzNFMvOWFkNlM0SFZCTFMwR0poczJpM1JTV1piUEdIdkFlZTYxT3h2TGZu?=
 =?utf-8?B?MmdLNzlFL1BtRUllK1NyVkdpd2lObWpYcEl2NEJmZzRGSzdYUmFHZmcrY1Zk?=
 =?utf-8?B?Sk9RQ0RMcVA3ZUl2MkVkR0drMGVtcFJoclN2VWRBdFVreW03UzVqb0RpZXlZ?=
 =?utf-8?B?bnBYcnhQcVdaL3BRRUU2SSsxdjBZMmVjTnNDUFEyenFRMUExQXJRVzg1Tnpv?=
 =?utf-8?B?VENFRUdEWkZQYnY3QUlDcG9vMVlvd1VzZTVkQ2s0Q1FTMkw5bHZpZ1djNE1s?=
 =?utf-8?B?NUdWVCtvNHNmaW9UK1IxOGdQdFRlemRIZEVVTU95WU5leHJZL3pxdVk5QnZq?=
 =?utf-8?B?bmwra0syVzk0Q2xtY2IrSndPY3Njd3Z1WGV3aWZLTFJxS3U1Tk1zQStIME5k?=
 =?utf-8?B?OXFxVnZwQlRENTMvaW1FVzI5Sk1ERFU1YUkxTndNdEpJd3Rwek5rcXl4Uk5K?=
 =?utf-8?B?YjZQVzBpaW5aNFZEZUp3aGdxa3hGMVRGSncrekt2c1hsaFcvbG9jRDA1ZXMz?=
 =?utf-8?B?cG44R0tzZUY3UXo4aiswWGRJWHhJMlNQdnNyNVRHV3VlSWJHbnpIUUNKQ1B2?=
 =?utf-8?B?cjdtcXZ0cUdqMzJtNjFqdkZsWEE3cnBiVkNGWktnRXZMbUQ3b2p1LzBKV1NS?=
 =?utf-8?B?TncxdGdtcWdmdUd2Wjg2M3I0L0FiQ1hOc051cUNzWDJ1azR1Mi9ZVmZJcG5F?=
 =?utf-8?B?dUYrcFNCRnl5WVJ1bWI5QjMrZXErZGdUeElzSC9ScVRHTzNqdFZyeG43L2Ry?=
 =?utf-8?B?T3JwNm4vWkozdE1pZ0EzeHhrRGNaRWpIeHNnV3YrMGRRZ0pOODMwaW5Kd01P?=
 =?utf-8?B?VC94alhFZyt4clkyMkRkYVAzUm4vMkpMNlpJRHFZYWZ2S0lkVVlnbkpnZ05H?=
 =?utf-8?B?MVBTMzJWZ2hOdVVvVGJpbm1kMW9sOXgweUhaeE4xTDFnWFpMUDZSNTczQWNZ?=
 =?utf-8?B?VDdiY3UxRXNwZDBHV1R4b3I1Y3JXUGpZbzhING5WWGFaWnAwMjlFMlJhUDg4?=
 =?utf-8?B?Rk91QWowNjhaWmJ1MWMzMldxTHR1SVQxMW5IbEJOcTdteW9zR09WK1k0T2p1?=
 =?utf-8?B?Ky9xOUttYjdJaUprV3YzNHRPYmplNm9jUld0ZDgzVVRXMUZzM05uR1Q2Z0Ez?=
 =?utf-8?B?L3Y5aUJWbnhuenlxNXAvcHR2N2tIZExnY0REajJpYUVMVGZlZzJvaThSdXNV?=
 =?utf-8?B?QnYrVnVFdDBFNWZxRCszaThMY3NhUUZIa1l4MDJYV3RkK0ovS1FKZ211eEdi?=
 =?utf-8?B?SlZ5K1V6YWxDVmFWaFd0NWc2T0VURUpZaktnMU12OCs4Rmx2ejV0SkJDbyta?=
 =?utf-8?B?Vk9rZ0NRcDhhQ2sxOTV2a0txRFFqZFBVdExERW5xdHliQ1gxUDZsK0djZVIz?=
 =?utf-8?B?YTZCdnBHUHVaU204eHFGaEFyOVlrMVU0Z2Mzb0dCVXlGeEJKTVZMdEJPTGd5?=
 =?utf-8?B?VEZOcUd4Zkp3U08zcjZ1VHV4UUF6dWk4TkJjTVI5bGh1N25FWHE3MVdJVk54?=
 =?utf-8?B?WXBZVE14NHJFNldBWWJkdGdiVzlCdzNFVVB1UVMzcThQakE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bWR0d0hlenJOM2I5WTZhSzNlSUpyK1JnNllZNjhVUlEyaFZQdTJKYnRKUWlH?=
 =?utf-8?B?cU5LUUlibUVHeElGK3Z6WjlmSmJqSEU3TEdVYzNDSXJtYUJ3T253YTlPMkJt?=
 =?utf-8?B?QWlkTHRPTHJ0MVFrV0tXenlIR0VZWFBDdVJaZXNYU1JrR3lNa3dLZGo2UVJZ?=
 =?utf-8?B?Wm5HZE5Oek9odnJsbjJKMk5lRUhMdUJNN0V5RlF3WVIwYmUxTTZwQ05yRnM0?=
 =?utf-8?B?b1hlZUpaQXNTYUpORmpRVWh3czUzcVRpaVJNNkxDLzMvSm1ZVG1MRE5YejJG?=
 =?utf-8?B?bFVHd0NsUWU3aUJXcEtZQlpReWRpaENwYXpyY1k4OHk0TStoUUYyak9aR1JK?=
 =?utf-8?B?OEt2bG94MGl3anhkWVMxcWJJYWRkZGlsUG1lWTRWWXRQQSswaFd6bzV0Nk12?=
 =?utf-8?B?czA0QW51TTFETEFMVktyS0c1cXFVQUh5S3hOd3daay9SOWdObUZ3QW16Rm9Q?=
 =?utf-8?B?UVZVSituNmM0NFdxd3lmMW9tdFFRYTZNUURIWWV5dTVsdUdOZXBrZFNUbmhI?=
 =?utf-8?B?eENHbWluenRvU1R2TXBJU0J4SmZKL1FHMVYzTFY3Snk1UERtVVZWYnJsZUNT?=
 =?utf-8?B?eVgwWTc5MHZBT3hkKzhpL2FOT3JzUWYzdmVtQXFWc3ZlMU9JTXlqaDMzWTBj?=
 =?utf-8?B?dCswNDhvWC93U29yaHZIRytodS9yZzVLcEZOMTFRSTJpdDZ1TDR2NjBXRUtZ?=
 =?utf-8?B?UE9kSHE2T3puejZyVkRYM25qZ29LcHU3VlBkTmJoMms0UDZIenYxZFFwNWlu?=
 =?utf-8?B?KzhvQm5OSmltb1JaK3Bpa2dpM2ZkbS8xRlVJYk51OUNjTlNiWGpsRHVvY2VS?=
 =?utf-8?B?NjRrRXdjSmNuRmVGcFlaUE83UUZwUytibEVxeWs4SFRRS21ZcXlNVkxLQkRl?=
 =?utf-8?B?V1dhSFRuZUJkYmYyWUZjVUxKSmlRMVBrZGdxZVJrbFFYT2g2M3ZIYlNvQk5p?=
 =?utf-8?B?amJuYys1dVZrZ3JzRDVzYzFnYnpwYWZvVTdlOXJaWVpFLytQWHVFanE4eTF4?=
 =?utf-8?B?YW9PZ2RKaHlFeTBFc2lxc2srY1dyakxYekF4clFBaXVNYTBhbW9yVEJrYTZr?=
 =?utf-8?B?MjRzVDdEcU9sWDNHU3IyR2c4bWM3TWllNWRQQ1FMaTU5QS9FZldXb2hRQmRE?=
 =?utf-8?B?L3E2TEI5N09vbHhjZEdGU1JyWHBJNWFsUCtPa0NCS08yeE5xdlBRaUtMcG56?=
 =?utf-8?B?c1JRQ2dMc1JBNFhiRVM4Y1lKVTlYcjhtRHllQi94VHZHYWt1MHV6aGhNR3pW?=
 =?utf-8?B?SjRITHN5MDZkL0NEdGR1L1RJV09GWi9SeWdHZnJxVS9SOTRVM0NyajFrS045?=
 =?utf-8?B?ZGQ2WFJrOXVZRWVHeVZualZvWURnc2hpSzdlVWZvbUJ5MFJ6eEcvbUNrVkh2?=
 =?utf-8?B?Yy9LSUthSHFlRlNocjVTRXp2V3ZGT3V2REZTVHlZTjdFaXVySXBsL25Ocm9M?=
 =?utf-8?B?VC90aUh5NDQvTkJ4M1F2UVkwRWU2WlNhOUJUK3c4dDZmQmFFaHExbHM1MlJE?=
 =?utf-8?B?b3E0SkU3TXk2SE1ra3BqcTdIdnpvYkRPTzVWd2tHQjRreHJPNmJiZGp4TlNV?=
 =?utf-8?B?eEIrME1oUkZ5Rm9ybGFNU29LaFFKUTdvY2J1WFp2R0tDQU9SS1g0OFF3NjNh?=
 =?utf-8?B?d0JvWkY5NjYxUityaTMxYm1xUUdRdzJkamFtclI4QU92L2RHelhXTnZ2ay9h?=
 =?utf-8?B?bTVMK1ZnK0xXcFNxbzdGREM3K1hBaW1JNTZWYUJDb0ZJcGIwWG9jRWcwWFVQ?=
 =?utf-8?B?aGdVbnRJeXRWUUkwUUtEWlBjRHZkVTBtM0JmcjlQTEpuNm5XNFFVVkptRmdY?=
 =?utf-8?B?a1dKTG5JbmEzS3F3Y1ZHQjJEL3JMSWllMXVmOEpxc1VxbnhJeHRYS3k5clpD?=
 =?utf-8?B?aHpaWTN5UzlsU0ZudmRlNDRGTW5DbEMxTUhnaHMvdEhDTTBVdXB5MnU2N0ph?=
 =?utf-8?B?VlhOTERsSnF6WmJJTjFPQy8yVStoUW5BZHVyVk4wRkt0Q1plSTAxS292M0lS?=
 =?utf-8?B?LzRkQ0IyUDNOS3hDS3A2ZG1sblhrRFpSc0M3a3RSSXlWZGFPZzhjbE9PL0xO?=
 =?utf-8?B?S3hLUmN3VzMxYlI0U3pMbXd0TDlrWTNzVUw3ZUdEZWZXazNrY3M0YnVaVStn?=
 =?utf-8?B?SXFnTjJhVlhWdjVaM3plbE9hR295K2IvRmwxMTYwdXgraVgxbXBZV0x1Z1dk?=
 =?utf-8?B?VHoyZkgrOXMzSW9IdmdxT2J3WFhpaFVHVzJ0R2xVc09aaHJRc2hDTUhkRmg5?=
 =?utf-8?B?MVYzMHlBQjMrcGJvZkRSZ1ZrVTRBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B57BDB00EBA09549865E1EC1F34E60A6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	phRNF267AfbqwS5BDAISxBzNsBPT4P3IYhK9PtbIvQCDTUenH7rdNaTewLA45oZuSWnbvTvhyIt5CHI0JPhzQnCg1zi5EBNxduYapntU1ZGCfNQ2+siZnp+sgrBTit71dXo1ci0+si0uxjza2I4DURYr+fPnkadJockPzXzQ8tTh21DWlBumeOC2JOECl3hLWUYKT+BZbKdPUqj5oPtzKGdElsxbGM/5RKc17cEvaMeZDBlnbDJ6h6D7Os13/QLFb/Bg3ZVXbOiKJNTqbDHYIXSaEVYnnUM8OaTVaqi39Iq+Kmg1PlmX4id0jl1amzeUWHlP1t1tEMHDd8FS0MpVZL8nKCVetYx/LT6RlpAh0nVdXj44XaxWuxg/YWvMZ6pyd0VcH4EsyXYq+eumfJeATqP6Lr8IzNyBpYByiCWRhX3Zm5iP19rCwkkTcqDyf7lia6RYvLSg2cyN4sQJtgfnpTUrCFm7T+EMLVx1+4cpzQJCmMa8slq1kV6gzjgiN/En7yTvvOmyvvIXu8Dgm30WznyKW2t6N1lLJAVPmVbk06Ix4yj9FNoEpd+Qb3BYQkOSTQySySbGRq5w7hXQ4fwLOLJZKHwTRCT+Pn7madVeDlM/igddYiGmhda8f8mTOKHp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdfa97a-0012-404d-e1a8-08dd0d1df802
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2024 06:54:12.2523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZRrX1sLsmennuu/Xxk+ROZK762jVp0bApjNyigJXJiEbUceVaR9tiYh/ye/QulkJ1uDEJZuMQSTs0pwA+aBYPnM1SXdo6H7fOVUnt4iNTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8732

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

