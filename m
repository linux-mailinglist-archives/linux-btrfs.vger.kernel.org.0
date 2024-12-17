Return-Path: <linux-btrfs+bounces-10479-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A77FD9F4C73
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 14:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8444189737F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 13:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9E81F426B;
	Tue, 17 Dec 2024 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qZplvm+2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UB+afvFp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0471DB37A
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734442078; cv=fail; b=XIKsLXV1twv6Hr21EhGwisUrnR76JyxnikrAmR/oT+mSlkf+MT2lO4eKFKx7XACsJHBuWmdnTfWtJ8zWfIZcwsz/DV+J2Axg3QI2vUO4YbC9JanXN9r8Rfj4gTuq9LSYrUf+jp9hrd3bz85hgn0zFkspy1gqL9uyEB+Nw1gAevU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734442078; c=relaxed/simple;
	bh=66jWmGpcxcoZZNT7EjiZdjTIi1gaUBKKWp58896yK94=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MR9m1tYZ83pQnxZsq0T2texUh+2iYLqE7AhAgatFrKkm25R9xwdtEyJq6D4VsJKz+vbauonqWwSFA6Eb9+jl/mpRbBrV38oUu44Sgmn9URikN7nSK3ZPY2wa7eZLF+fDdrToXl8L5KMD2pym5q+6FFWehRTKwhW9zkHELq4EuiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qZplvm+2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=UB+afvFp; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734442076; x=1765978076;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=66jWmGpcxcoZZNT7EjiZdjTIi1gaUBKKWp58896yK94=;
  b=qZplvm+2Cvxz/amfctpa0kgW9Ija7OzSG2pl4Olb2Rcz5eXSzxaVGNGC
   yui/1bSBx0xl78kE1WE4GPJ8EuiKc5mR369hqe1RGueL3L6np97EHlCGV
   vJh6UNorkSqxfxbArNqilOckHFrREuYAlMsQC65c8CNLFse/1ixC7ux7t
   AGFFyKzDAprfBAEKfObKIkdgtQoK1PkJopk4qUPYIyKAZmjDNTvF8W/Hl
   xTkXXeo/1MpLlu3kePXs/E6JYBDmcTxFvXJq2exQ/bYjRtd1hr75b4NUL
   baOWfxcvzkiLTlRtaPPkMpP7Vh0iJQggjO/Nzl9CFS3e+1bApvNGxf/Rc
   A==;
X-CSE-ConnectionGUID: 3Ct2yPGqTqC2qgf0PuKa0w==
X-CSE-MsgGUID: zvtXSbqTTAer+XfYuo04QQ==
X-IronPort-AV: E=Sophos;i="6.12,241,1728921600"; 
   d="scan'208";a="34564336"
Received: from mail-dm6nam10lp2044.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.44])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2024 21:27:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiloFUfeQKU2P1mcxFTCQbCLEHiyitAZw8QrWdD0DTUAx5pOodNl5FMS/7J7vWHDCzZcfy0lU6O+GmEDD+UxD8AMksHfZ682cL+vY6SEDCVpPsVw+c6lybHTEpzgVc85+pk8o01uAcmlbnWrw1oB7uSGeLVAxzqlRmjFt451EB5+W99UgY8LhPH/9g3wt0wAIeWX1pJTlzoKlUjaq7H0WWfYIC0YLeGNPrO3N0qP+IepCc0wGyPh2WGN/PEwUyjbmVTC2STrDQi4vq/z5Qr5tG/Yu1+zEZLJ2BZA1ZFEBiKdbeHX24hmJLNIJfjf3w4pERbnFaJvfXJAWRKXCjMTtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66jWmGpcxcoZZNT7EjiZdjTIi1gaUBKKWp58896yK94=;
 b=Lajx2NMGewJg21KqQQEgpJQw+pNFYTpB5zLdmN+nFlaWLGSt1woh8BJZ49I+H1ZeC1wJ+9TeChGj0SY1ipTJkbLUdRWp9QYI4N9ydREd+/f5vcwDiy7sU48ASbyd9I37l5Sznbp3V1oFWKHZrKmLidfMbQ75TGCiWxBmVTZLsEZO3xahbiDAVaUdMLy5WXzEwQJ0K3dUiJ/vytUfYs/1k4vTNhfDS7iNjH6JKH0/vZCyAzMERESGq6J0puHbp5KKJKTl9ykH4HXcDfWEE8bcZay/f9/FxHanOyYEPweiepRhPeXhcUzYpB1tIGeci3SNRBE58ooizXGipXYRiQXJjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66jWmGpcxcoZZNT7EjiZdjTIi1gaUBKKWp58896yK94=;
 b=UB+afvFpYETI1ZBpLavb8LjYLLFrfxyjYnc+A4UoCyUjTmk+0n/sjJbDkqkkcRwYPY2Ely2alpfEj5XSvZ6RuhgMFqHvuMk0iyWr4Z/G4tJthYsa72XnNgVJaDlFmhdyuXSFl/ZpkJiv3Ua9pZO078dNLnuPJnftzE+kVns637U=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6571.namprd04.prod.outlook.com (2603:10b6:610:34::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Tue, 17 Dec
 2024 13:27:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 13:27:44 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use uuid_is_null() to verify if an uuid is empty
Thread-Topic: [PATCH] btrfs: use uuid_is_null() to verify if an uuid is empty
Thread-Index: AQHbUH1A5SsUAFhtC02hrWGvzGulZLLqbe4A
Date: Tue, 17 Dec 2024 13:27:44 +0000
Message-ID: <6b6ee2a2-882b-4df8-982b-157c15b07da0@wdc.com>
References:
 <60c0e07d871249ed86b53087c75a1013233da355.1734437595.git.fdmanana@suse.com>
In-Reply-To:
 <60c0e07d871249ed86b53087c75a1013233da355.1734437595.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6571:EE_
x-ms-office365-filtering-correlation-id: ce342435-25b5-4bf6-73f6-08dd1e9e9742
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?blVYbVFONkJtUDFGckFrRUJuYUNUMXVqZ0htOGFqUXE1U0x4VHVIU3V5RjJw?=
 =?utf-8?B?dWI4MmlVMWswQWhjZnMrb1dURmNYMFZGZlhxczJJQnN0WXI4SmtLMUl6Z1Q2?=
 =?utf-8?B?VlNyaktOS3BFV01SSDhKdEdIQWJxY0lYanM1cXo2SDNhWGZkOGJmYW90K2E0?=
 =?utf-8?B?b2s1OXJCZFlhcW9kT0MxTkxIWEFTZlgxRGUxL1ZCQzZ6QU11eTIra3BnSHRt?=
 =?utf-8?B?UU9RN084VTZjcEM0MmcxY0MySks0ODlTRE5adVZGNHVzejdoQzd5dFE0SWVX?=
 =?utf-8?B?VjhuZEU4RDcyNDZQY2JsZEh3T2dYMlhlTjZBZzZKQ0FEYWFMcVRocnhtWGRR?=
 =?utf-8?B?OGJnUVQvTWZ3eG5EOUhPd3RoajdmSnN6NFVPSENGWWh1ajA4MWR0RGlkSUJi?=
 =?utf-8?B?Z1ZuOWlDZHRFQ3U2cnk0K2l5L09PY3c1bG5rTklKRkdLRU95VW1yZHV6dDZY?=
 =?utf-8?B?ZjVVL3pFZ0o2QXNKYk1oQVE0SklXMXdkT0V5TWMzcTNKWFFtdnlIQmYrOVZV?=
 =?utf-8?B?WlFGalcxcThrcURGVjFkVGVNblhMOXhOQ1liS1pHNmU5U3EvalNlWjVRVlB5?=
 =?utf-8?B?Skc2bGZTamlTTDdaaDBCWldTRUNkWHlCYXJncDk0bFFocHo1UHduZm1Zcll6?=
 =?utf-8?B?V1RldEVoQ21yYzFRb3h4TFpKWlRoa2J0ZS9LQ29RRzlua1lUU1Jqd1RuTDda?=
 =?utf-8?B?U0Ura2tFaEp3VzdRT1FMR2hKMXAvNXhmcmZTd2h5VG5HYVE5bG8yYkVSMGsz?=
 =?utf-8?B?S3lXZlcvZmFYWVBhV3BkRDFBNUxGTEkxT2RQTW9aUW9YUHhKeTNyRFZCUDU0?=
 =?utf-8?B?S05IemNZWmNzRTJGdDBCeTRBVkpSRlNaTTZ1QmVWQzdtZUxId201T3ZmU1d3?=
 =?utf-8?B?d3lEUmFyVGVhZDNwdzl3MWRkSExjeXNMWFhINFZIUW9XSXlad3ZUSDhVV3F5?=
 =?utf-8?B?NjZVSmc5SjlMZU9VVE56MHBtcFhlWjNKSE4rQmc5Vm5ZV1VOTWtLU3RwL01j?=
 =?utf-8?B?aEorRlRDTnF2WHZGZmNGT2hlbUszK253ZzVIMVdtZThPYlJHWE16Mlp2QzBJ?=
 =?utf-8?B?dFIrMVVFYXR0bDNzV214M2lkNVZ3MmJyMGpLS2lyWUVQUWVrMUNSV3R0ZGpB?=
 =?utf-8?B?L2NVREJ5MFpxNmlYbTgzKytoVzlTb05IK0RlS2FzUENjUDAxdS9waTdxWDB5?=
 =?utf-8?B?YlhpbVJsR0VOamR0L0YrZENodWwyak1DL3FyTGQ2K3QvWDVBc2gxK1o0Yktt?=
 =?utf-8?B?NGVIbFJkbm5lSmVHSW5rdVYrak8wT0xYa3NFUThQNm9PcGlEOWRkVzlPcmZF?=
 =?utf-8?B?UTFhdmZoQTl6WUtlRzB3TWtiQVRTdk1iOTNVZWpGZFJzeTM0bkxsUUt2MTI4?=
 =?utf-8?B?cUd2SjlmL1dNOFRFUUpzTE4weE9BczI2K3lGR293L2F0aGlwaHFEUFpZVEEy?=
 =?utf-8?B?eGhjRUxlSUFUYTNmd0tNbjNEdVEzS09GQVJTMFlsWlphb2NBSldYZWJsVDNO?=
 =?utf-8?B?cnk4bVlZQWg2a3ZDV3hiZEJSUzRSeXZrN1c5U1lIeS9lZjlCUk4xdVB0dlpt?=
 =?utf-8?B?NlJvaUFRYlJUeTBSUS9kZldBTHZzeXY5RWphNDRFNUI0MFFDcTcyY21xSTlD?=
 =?utf-8?B?b2VraUI2ZTc3ZnBkRUV3NWtCL0phK3UxeTl2eW1ielVCNGxnNjdHRWlNb1BF?=
 =?utf-8?B?cUE4Z2U5aldUNlpkTkhUSkFFVjVva21nUnk5Z20yOWxTbkJmYjhNeVRjTkcv?=
 =?utf-8?B?eWMvMzBUeVhDd0Y4VWhhOWJtRDBsWDF0VmlCcXl1bm4yWUxqWHFQRGZCTHUv?=
 =?utf-8?B?K0h3U1JaQWN1N20ySUZtMGY3aWVjbGU2RVJUNEdZcVFRWTZUcEVKbnB5SUU0?=
 =?utf-8?B?eGZWbXg3dUxnT0lnTGdoUDNzc21mN0NGYUtKY2hEWUs3dGM4cDQ3VzB6c1RR?=
 =?utf-8?Q?vyeI2d3P/det6FXL5fDSEpdrnm0NHpm4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eEFFWXlsTzllNHA2WWZsZkFhc2g3Yytqci8zclIvSkJiSGM4bFpxeGhwS0tI?=
 =?utf-8?B?eTZobVl1UVhaNk9vWEFnUENuc0U5ZXFYeEdNNHQrdVVzL3grVWRsV1lMTDZw?=
 =?utf-8?B?dnBDNUZzbDlyajAxb2hYRTYzakxKR0hWdnNFNEROOEMrdWxjcWZXVGJFeXAw?=
 =?utf-8?B?NGZjaVdRd05hbmRzWWRjbjJ1L2pkMTJXbFlRU01oOFQrdEI4V2U5Mmg2cEN4?=
 =?utf-8?B?alk5dlNlSVFHcWhxSW8xOTVkS0p2d1F0aFo5VkNURU5lOEJMRmlPZjBqY3I2?=
 =?utf-8?B?ZkpuN1VOOTFpSWZjN1NkNmNhMW1hZFBuYmtPZnhaZDJXb2h5NjR1MGJxM3Nu?=
 =?utf-8?B?UU5TM04zaXBsaGY1aWFwem1zYXFZbjh3ME9YQlVPUzZ6enBuYlpvSXFCQ1ZX?=
 =?utf-8?B?azJFMmlGbjZQbStSZ2tZTldiaFFVZzQxWEhnSXFXOHRUTVgxT3J4aE5ZdURj?=
 =?utf-8?B?c0pjL05sb1pGVkJpTG5EOGg2L3ZZR1kyTmdaV0src1o4YW02WE42OHVFcEhF?=
 =?utf-8?B?S2t2MU8yVUFYODhxQXpLTVFPRU1CNGtwY0Y5YUZScGJ5Y0ZacEs5elhSaGdI?=
 =?utf-8?B?Z2xoa3RiVFYrbEVqRXIrUjhjQWZqaXpmMWpQU3R3aWZxQWMwQk5wUW51VStk?=
 =?utf-8?B?UkVlL0lqRDhiNUlpZnBtaHExdzVsL2VGRGFPSnN1ZThLcllycnBwc2JjMExF?=
 =?utf-8?B?alg2VEhLVFJKVUk3NG5HeXBDVm1ZKzZpaGN1VForREFJWWJIa1V4T1lyQkg0?=
 =?utf-8?B?Yk55MWhaQVlBaTU0bVJ4RmhBT0dvWkxCcDlhbzJLUmtCeU9KNGN6a1Z5eElk?=
 =?utf-8?B?cXFqeHg4SlFURmt4c29UV3psOGRPZGo0VCtaanFSQWNJZXIxNmIzZ0NyZ0Fr?=
 =?utf-8?B?NzFkNlExQ3hDYzFQSU90R1Q3WlY2cTBZU2R6QW96dE9vcEJpUGcxV2lBSEdW?=
 =?utf-8?B?SlFBVUpzZC9XRm13dDVSVGhNa25IM1VtTzVHSTEwdlVUOFgxQ0EwbkhSWWZW?=
 =?utf-8?B?dnQ1b0hkRmwwOGZYa0ZlOEFjdHFQL1FjQlNFNzBNczAyM1hYTjQ5bDExYlFP?=
 =?utf-8?B?OHF6UFpqbXc4MjBvb0xib2d6MjduWTFCeWVNWmxJMWUwZ3VTd2J4dW01QVRj?=
 =?utf-8?B?OENoSFdjeWp6U3ZZNjFtODRGUEdpSnY1ODJKb3VMcnZUNk9uR2tTWi9qYmk4?=
 =?utf-8?B?NTEwSWdscmRTc3g0WnIxVmMwVFVXSjZITVkyY0ZmdnlFaEFJRXg5Nk12ZUtR?=
 =?utf-8?B?WlJ0SUlzQVJUTTdlbEdNQjQ2bEhWSWRnY2paUDI3MS80NE5aVjRqR0Z1K0U0?=
 =?utf-8?B?TThpbVRuc3dVZGF4ZFJPQlNHRVNYWFY1aUhYMTJnNnRBTGFzWXU0USttTEJ5?=
 =?utf-8?B?VlpNRUVXcW4zcXZtOEZIUjRwLzJ2b1VGU0Y2N2NCTFk3cFRFRXRsZ2FCZlRn?=
 =?utf-8?B?b1dqbytNeTBJYkhxQ3QzeHRnVi9ma2FXRC80NEtYU2N6bUFZS2dtVFBzR0xl?=
 =?utf-8?B?V3BHQ2tpYkt1N2FSWkVISkV3RnBENWtIZDA3L21XbUlCdGdneHh3R2tqSGUw?=
 =?utf-8?B?VFo0SFU3ZkFIOUVwQ0Y3YnVrcmw3Z0Q0cHVKVkZZM25vME9TSFFwN3ZrM1RD?=
 =?utf-8?B?N3BhV0JCekt1NFcyUzhuTm1QeVNwN2RLWm1sRUVONmE0WEEwblJrT0NzYzFN?=
 =?utf-8?B?ZGhsd3A5dHU1VU9tTk14R0FZNFkyZjZibGhGcldJVHRsN1Uyb2xFU0xTeG41?=
 =?utf-8?B?YjhUa1pWRlZESTNzMVhmUzR4OTc2STNxZlpUL1Y4NllwZU5DcU9QUkNJZ29H?=
 =?utf-8?B?S2l1ak9ranpxZGRzTUVtMitlYjloc2tFUC9hRWI0Y1Y2N3VIc0hiVVlNYjZ0?=
 =?utf-8?B?ZmdMdllhQklxeGh1MDduV2JtMlRTSWdjcjF0c00yTk81NGg1M09ERXlnMzdu?=
 =?utf-8?B?cmw4VnNvT0MvQTQ0MUxVbmNYQWpLalJKWG9TSVlzTUVYaGdZQWZIMW9vcGhM?=
 =?utf-8?B?aW9MMkF6Z0VmdEY0VmlzRGs4T1g3N0VpeGNSN3RjRmVQZHpHbHExZXdEVThM?=
 =?utf-8?B?QkpGTmpoQnhiMDVYaDZVR2FOMWMrZmsrRTlXK1ZKTVczOXZ3c0Q1SnI5TFEv?=
 =?utf-8?B?ZG1BRGxEbHVsRFlxZzNzemJQVHpPVEhLcHhMTTJMUnVRWmdlckRiNDFzMisw?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F340ED53F63505409B9EA6511BEB3969@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RSxjU7rySG6b5zzhx0a0/A6SnM6EeVhXijSuP1sdlhLBxooDbb36ZEeZW81phLM+Wh0vIfK7MnXShkm9Q7UMK+keUF5mmZd4SYgufhcL+4CL1Q7HDSNH87dBrue7U1NAkmf7QOuXbdx60Iz8gn7X8kLTVdHpcGidvvc/fgrYQ9eJZcNg+J8BWPvESSaS8W22p/IYSleY8om+6Bep62yklvNlLNkhggGVOgVzJDyicQZR2ROzDljcpsiQn3ctfE3oCfLjPYA//zNxxFN1arGFqxuo6wzZtNHQcvy20FqVJqecEXAmwJrmerxYvOs3FXAECKlrWrTCLCL918oFQUXqwBsNbpsxX6YhabS6T0xZiOS6kMEdRf9HqppzfxQIAU/9Q4s8hb9uKHlE8Mxp4xKQfB9W38Cx1QFocbA51uvT4PAWPal5uU63fcmWjrSX8FRCpfzNfKgKepOROaeTa3dCwlPeqmLBcJpjO4hLEt56qszol2Bmazl+Z97F9nPWawNffRiUqmLcUzCO7Zewhpx0ziZZ/g72tnkg7/kzsYckxoJMzLGJN3wwGeFKOqNgVFXdtAFYzXYTbzeq5YJGGKJpySGZNA+vZ1kSYyCwQ4GqlkvKKSD8hT8kDdNzK0qOWTYt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce342435-25b5-4bf6-73f6-08dd1e9e9742
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 13:27:44.7241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D975SuLOx4yXFu0YLg76BXn9EvF41BkU1kXYIWMq4n2fVrns1djd0wKPyj0lKX+yADkROalHWvAIAvw/dGIxwWF6GPUdTO5G3Avd66drwRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6571

T24gMTcuMTIuMjQgMTM6MTQsIGZkbWFuYW5hQGtlcm5lbC5vcmcgd3JvdGU6DQo+IEZyb206IEZp
bGlwZSBNYW5hbmEgPGZkbWFuYW5hQHN1c2UuY29tPg0KPiANCj4gQXQgYnRyZnNfaXNfZW1wdHlf
dXVpZCgpIHdlIGhhdmUgb3VyIGN1c3RvbSBjb2RlIHRvIGNoZWNrIGlmIGFuIHV1aWQgaXMNCj4g
ZW1wdHksIGhvd2V2ZXIgdGhlcmUgYSBrZXJuZWwgdXVpZCBsaWJyYXJ5IHRoYXQgaGFzIGEgZnVu
Y3Rpb24gbmFtZWQNCj4gdXVpZF9pc19udWxsKCkgd2hpY2ggZG9lcyB0aGUgc2FtZSBhbmQgcHJv
YmFibHkgbW9yZSBlZmZpY2llbnQuDQo+IA0KPiBTbyBjaGFuZ2UgYnRyZnNfaXNfZW1wdHlfdXVp
ZCgpIHRvIHVzZSB1dWlkX2lzX251bGwoKSwgd2hpY2ggaXMgYWxtb3N0DQo+IGEgZGlyZWN0eSBy
ZXBsYWNlbWVudCwgaXQganVzdCB3cmFwcyB0aGUgbmVjZXNzYXJ5IGNhc3Rpbmcgc2luY2Ugb3Vy
DQogICAgIF5+IGRpcmVjdGx5DQoNCg0KT3RoZXIgdGhhbiB0aGF0LA0KUmV2aWV3ZWQtYnk6IEpv
aGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=

