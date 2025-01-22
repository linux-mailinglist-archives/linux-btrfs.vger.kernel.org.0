Return-Path: <linux-btrfs+bounces-11038-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 976FCA191EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 13:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 497757A10A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 12:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298B9212F9F;
	Wed, 22 Jan 2025 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="aeGwX67Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98DC211A18
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737550771; cv=fail; b=eVyRZYiD82y+OuHOluzcEibJIWEK9wpVHdEmzYKAEEnETX3VJACmDp1sRDdyvAjzpC3Ca9f9uq264Kbz5f80IFC6qUFpsC0HqIX6deEFA1/Wx1idiOhrpgwHyc7EIAJdFRK4V8vQfNJkBth3mr+lwiSdp1KBZknWVUN8zBuXc5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737550771; c=relaxed/simple;
	bh=ApcahmWHCOwLd7GONsTC3YBeYC0sGcooD4cru0ydHGI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bt4ewvAmIm+ylT/XvfXefvhgBqm4KqvJBGuyN3cehvY2GniB1tmQUrTGIoltKp0Lxmki0BnN9IGgKuRn5LOt0OkUvA923+H2yo/ewUNpwckAudBcYGgBbyTM40eoQEDyGDSQlHmWMsibQoRC28dRrgw2eyFAR3jEY/q+l5drDgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=aeGwX67Y; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MAS2Er009301
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 04:59:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=ApcahmWHCOwLd7GONsTC3YBeYC0sGcooD4cru0ydHGI=; b=
	aeGwX67YrOwsdzh+9XVoeMVnkJcm5qhAjwKP0hUvKGLsAnRdck55CvcPJhUqH4RR
	1WEdxq1eKeuNSUDNpk5AMsI93URg8HqZgFCswP4gO8t4inkQlSeLhXFE7IFMd7BE
	+n/VyHaVVMmWmRqbuL0CEjbi89M+RJY6ye23ftwStCMx1QDEHm30i+jAdDGLpL+k
	kOJyqiNxcg6CiufGbJaccCWRzRVW6mE5HlkENUXxx89K7aFUD7R31CL3ReF5vOMg
	sr8vFh94s/+VOd4obboalzOfyJCMeee4hk6sL3h+RHWVrNT/i6DL27xzUMaRrVD0
	ffvOAYEHN0GGOinYCJjHBQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44axxrrpbx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 04:59:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDTFGcvJ/4aQ6ABY6cyZ0DDggWFifAnMGxtiPR+juTsVesft+Vv7s79TKiO6mKibXVrGdfxYPel7HrlyAuX8xvbdjpos85NU3cqSGOXGgttTqx/zyybo9IfLyAQ2Q6uRM5wzjjHbe/ekhxk+0+N80aE865r8+emxkGbGUQkaB08AFKVrQzEtv/EG37gvAmKwCtpVSTvrkLmTt++Pa7UnLYZjumNIikq41GZOWuur54yxb0zJZyMu94s/XCDuZdp1lOeZIZ8QUWaD0s3VMIlXGHQ5XTc1Zi7UInRtigaMC6UGO6pMM2o9pktvyxstBxZdph4HQZuvvMn/uh/5x9/tfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApcahmWHCOwLd7GONsTC3YBeYC0sGcooD4cru0ydHGI=;
 b=Ds7x7NYIzq6wYatIVPZxBzoWRJdIsVir6ILPwDoHrCpqdoMwusKLR4KtRKvX2XWPxlxM+nfwZEHBrbKaAYARJ4SwmADfppZyGpdiF7Wqsu9JixCOedbSaNh5T7ACXJLFnUISb7y+7/mslnqsXxIRNXmDPMW1UqKrd/s4maTcQ2Azyv+iDYlmyL8VYUK4tuhc469LaCgzcjuKwzr99yQUzB4XAsUuKVsysmXRFiFqMUDbUiaEM71M+yFT3fS4lay78+jgOvA+bVnlXd1tK5nRWZD0jrIKjdf/L8oHj98Ze8PtL1dHYL6PZypG5ac6YmHNSdjtTnIJGf4qLn1nYjmnXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by IA3PR15MB6559.namprd15.prod.outlook.com (2603:10b6:208:522::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 12:59:21 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%5]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 12:59:21 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
Thread-Topic: [PATCH] btrfs: use atomic64_t for free_objectid
Thread-Index: AQHbbMivsPcQp6znhUC74MzCCLPe17Miu8CAgAAFlQA=
Date: Wed, 22 Jan 2025 12:59:20 +0000
Message-ID: <9845595d-1015-4012-96e7-a56856fb522e@meta.com>
References: <20250122122459.1148668-1-maharmstone@fb.com>
 <CAL3q7H4tB3Cb-djYhh_bGB-BRJ7EahjUZec2qfbhH7QHP2iSUw@mail.gmail.com>
In-Reply-To:
 <CAL3q7H4tB3Cb-djYhh_bGB-BRJ7EahjUZec2qfbhH7QHP2iSUw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|IA3PR15MB6559:EE_
x-ms-office365-filtering-correlation-id: 5bc3ddd0-96ca-4f0d-39f8-08dd3ae49696
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bTNRQVdZWG9iaUxKS29pOHdJR0xPRnBuUFB3STRCcklTcTBNdEVQcElwQlVa?=
 =?utf-8?B?OUVEZ2NQaUY3ZEZaQlcxcHg3QjB5eUYvUG1kMEl3M29nTVlGYzVsQlhWTFYx?=
 =?utf-8?B?WUZhakVYb0dIU1FKTXZKOStWRlhKbEFuUEx5dEtpbEhLTEtreDV5SStzTXhK?=
 =?utf-8?B?aEtnbk1tUUxJOWJZMGVFRnVkLzR5RHFyVlBHNDlRVUw0THhyK3ducDF4YVg5?=
 =?utf-8?B?T3doazVkanprQVkzdnllNFRsQXZ6WXNNc2dLdHAvMXRRY3IyeFdpOENpZ1pt?=
 =?utf-8?B?SGIrNFFyWFdWeFhVa1Erc0kzQ1ZQYnJYcnE5bzZxcitpaG42S1preXNWcGhY?=
 =?utf-8?B?ME5PMUd1WFRLb3ZRdTBGa25YYTBXZ0ZMcEwxaDV1a2Frb2Jad3FoZTZZWW9N?=
 =?utf-8?B?TWZGeGo0U29HN3JndGZCcktVdWhwQUdVbjEwRUlHZjl5azlMU0lYSm5HdVhI?=
 =?utf-8?B?cnBWTDI3REU0RnJyNkp6WmNrc2h2R2lvWUFtWkxJNXJOSXlLV2M0d3JkQW5Z?=
 =?utf-8?B?QTYwb0tnZUFzVTFwWUNKZ2NSZkJneEVZWDA1UklNaVE3N3gwTW1oM21RY3hK?=
 =?utf-8?B?NHVyUWxtMGIwVmdOckg2SU1obVh0R2dyQU4xN2xuajBpSEhxRU9BZDg2ODVu?=
 =?utf-8?B?UlVDYUdKSVZ0aG55MnBNWWtJK2xwQTltNExMMWhoRm5Wdnh3YXFCcFhOdUYy?=
 =?utf-8?B?T3k1QnNiaUNaT1RGVm9XMHZtVWRCZU4vcUloMjM5RC8vcnJOaTRuSVRubFVr?=
 =?utf-8?B?MXh0OEJjaitaT2crTlA3amwxVVluZFFXaUxjVFdlL1dFbXRLQTl6U0VNWHVM?=
 =?utf-8?B?OFd3K3NQaklER0Z3N2FXK0xnQ1RMMU5oSXRrM2dkZWJsWmthVFRHUWlrNFpv?=
 =?utf-8?B?RmV0UWpIaEE0UXYrNVE1RjBURVI0QkcrWkZmUzEvZE9oYzZWWFNWV2FjZ2hy?=
 =?utf-8?B?UmVWUmdNaFhhUkdZTjFvUE1tS1RkK1kyamFYY3NEcXVNanVSL09FOE5MNC9R?=
 =?utf-8?B?N1d6b3BmTFVTS2YzRWoyTys4SVdCbC9KeXlFb2kwYU5Eb3VaR05HaHVZMTkz?=
 =?utf-8?B?OGJiNnRkd3FsYkFGYW4rcU9NYlhOd05seGlHWjBmeDU2QVBPUXZGaGxHcWpV?=
 =?utf-8?B?T1F0VGlDcC9rZ3BNUWg1eWtWc1RZWHlWL3UvOWRpbmljMy9DMHNza0NBcEsv?=
 =?utf-8?B?Wi9mWXllT3Avemg3WEw3YTVrTVRXNm1pdktPWnZ1YmdCdGZ4MWVzT1ozc21w?=
 =?utf-8?B?cGgxcER5VmxUZXlpQSt4cVJDRS93dks1UWI2bG1Yckk1L2NOSXVacXExeitI?=
 =?utf-8?B?Y29kSnI4WnBBLy9YYnZKaFA2UG5IQndqcnU0dEcybUJ0amxVWEpFd3QwTDJv?=
 =?utf-8?B?WVg0cFF6aHpQRGJSUmdSdDZaNlN0ako2SnRWRDN5MWpHVEFlcjNiUEcwUGMz?=
 =?utf-8?B?MURCZStxbEJaOEZSN3FFNWVzcXlGZDZmWUtkZGdqNW9iM0xydXI1V3orR3NI?=
 =?utf-8?B?ZnpDV21naUtPMEMyL0kvWjAwSDcrOFJLSDVIdkNOY2g1WDVMOHhBb0s5Z0R2?=
 =?utf-8?B?MjV0dzZBTlY3dXhuRFpVZ0ppOStrbHlJci9lQVFlZnY1QkVOcC9Ub1pVdnRW?=
 =?utf-8?B?dnZ5a05YRVZCemljMEc0dEFiLzlud0NBYnFoWlVPd1djWTJtdEtsOEtXZU1q?=
 =?utf-8?B?QUF3WjhZcG82bGdMck5qREVnZGw2WmhON1FVMjgwYU9La3JDL1BTV28vM3JG?=
 =?utf-8?B?Y3hyWEc3YVdCOWhCV0w3Q3kvWEhmUWo1a3htMjBhNHVKSjNmWUZrbmJHU3dH?=
 =?utf-8?B?d0pYOG4rb0JFWW5nZ3VFcTVQaW9qTmlwT0FXSHAvUHNzTTVReWw0TVh0cU5Y?=
 =?utf-8?B?TjAzKzhYZjMreEt0NXZDT0Fod2d3YVAwQ1U2dzFmK01EVnBNNlpsZ3FwdGFN?=
 =?utf-8?Q?+cKiBWlrknVWaKBMTqixxJJs1xem0wdv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MVVDMlVuUjZ1TFh4dzM3akZBTTdiNGp5MHJhQzF2SHI4RWNGRCs5MDlWOFFv?=
 =?utf-8?B?TUFFUUxGbDdUdDc5NzFmVEJaVXJFS0lhQThJMS9jRFJNaDgyVVNIeFZQZXZo?=
 =?utf-8?B?ZUNXSkFpSXRTOFIvNzhjNEJiQy84T0R1OU1IMllRdlF6dkZIK3NrMFBITC9l?=
 =?utf-8?B?S0p2eUNqTFArU3k1SHR5VmE3MkdmTWNjYjVQKy85ejN5VUdmVytxcXlveXlS?=
 =?utf-8?B?allJRUlZREdJcXozRUdKV1Q1b0x1WDc3TU51K1h6enViY01nOXRPNzJUY2sz?=
 =?utf-8?B?NjRuSk9MdEtPNnRacjhqNlR3UDN1M2NYbFRMWG1OeThiMzAyWE9idmtCRzhN?=
 =?utf-8?B?OW1mZW02OXJFUVBIVlhvdStiZm5QUVMxcjdSMFd0UFpzNVJGTk9pU2hmc0lI?=
 =?utf-8?B?eUdtdlVnS1ZVYisxRVhTbTdXSllUN0dCNXlCRDh5UnVYY3pNUi9KdTZtNlZC?=
 =?utf-8?B?SFhNOW9raTFkeXRlR1VocjZxOFJObytWZXE5VzRZOW03aDhHQy9GSktqYkZN?=
 =?utf-8?B?TEpnd29SK0hvQzJJUUFpZU9oT3lkT3BkbThGZnYzTVJHUkhoNDM1YU9rV1Vn?=
 =?utf-8?B?SitzQ1JqNGZqOWRQZy9kSVFPdHdoWlcrNHA0QlJrbEZpRWlYY2I1V2xJWlRo?=
 =?utf-8?B?S2VMWjkrd096NDVuTEw2TkY3SFBpckFZRXQwZ2FFajE1MG1kMFBzS1ZpMmhG?=
 =?utf-8?B?ZUlMN3Q0L1VEVGZuUHdiSHJ3VkVBYTRRVGR1RTNmWVBkaXAwWTFHZ2ZaMGsr?=
 =?utf-8?B?eWpMR3J0TCszb1ExV1oyczY5RXFPd3hFWXdkYisvQ04xb2Y3WlFjNkFtaWJ0?=
 =?utf-8?B?Ymc0blgvYy9pRks1Q2RveFpkVGlGOFZvQkltaWZjZ0NLS1YrQmZQUEJtRnVo?=
 =?utf-8?B?RFpMMHM2eFFZK1pCSnpMSDRqSkxsS0VBdGtBNlMwMlIzNUtMeW0xT2F4NUhH?=
 =?utf-8?B?NTF2T3luUjhzVERGaG03Z1RFenQrM3p0V2FIakNhU0M3bml2TDI3cjhXamZJ?=
 =?utf-8?B?citkUkw5KzJkUEZsQ2ZGNFlwNXVKNDdTVFB2ZHJaclFsNUNrbDJYUk9PUzBw?=
 =?utf-8?B?bHNaMVg3MzJnemZtQlE5cWJnMmxHdkZ2ODVLSzZDUjQ2cUlkRVA3TGZQR2pX?=
 =?utf-8?B?aHVlZm84YkNYR2ZyeG8reXhhVUVXcVExbUYxaTRRQjRpbGtTcHRpWTlOcmRp?=
 =?utf-8?B?WERMdnFWcldQY2RUNGNUK1IrZHRlMm16S3d3UWRraWFBVFhldTJJZk5GTElm?=
 =?utf-8?B?aThhWkV6NExaZXhYaGhyS1Zpc2ROT0pXK0lzdW84WDVGd0p0KzVjZFVhUFpM?=
 =?utf-8?B?VkhRVERRNlBublhuUDkyMGFZQWFnb3Z2dTBqa2cwOTV4WHE3Vkc0QTlBTFlq?=
 =?utf-8?B?aS8raVFoL1AwOWZaMldzVW1QbE1kTXpVTXZFZXBNSWVocHZuREdDREZtMmdk?=
 =?utf-8?B?WUgzT3dXd2tRMWIzWUJJL3VvNEpFZHpaakNITTJQNk1ZL3Z3aTZXRFNlcUxs?=
 =?utf-8?B?NDlkYzdLeUxvWDRSWnJYWHVVQzFYdHRFekFUVStIbWJNUjh6cVI5MXQ3cHA1?=
 =?utf-8?B?KzZxODRmMk42MU5oNE9qeW9LbUtDaWFnOGRMNHFvQUMwL0gxQlpISEp2UWR4?=
 =?utf-8?B?WHlZUG5Cek1oQjN4TnZFR0VtbjhQM1R3U1VlVEpuODRhQ0VMUkxORmEveFhh?=
 =?utf-8?B?YUIvZFRRdCtIRkFPQXdnSzJ3WlFjMzVxcnpwdHRneU9McjVWZTAwWTYrMlhR?=
 =?utf-8?B?ZHkwcUtjZFdxdzNodXdzR2pFTWl6eGcxL2I2N1BSU29DU0g2ZXFra1hMcE1O?=
 =?utf-8?B?MmhUdXUyOTREUG5YRzVZektWeE50M21sTzUxTWg2SDkwZEw3R0dmVkI4OFVN?=
 =?utf-8?B?b0N3MjZsLzRWUkdLNXhPMzU4OHJ5R1VnYi9tU0VlQ0NPVGl4MDhQSUpzT1VE?=
 =?utf-8?B?dU9BUXpHK1lQRnZUc2h5MFhydU9XTjFlNjk4ZTVzd2NERjlKREhIcnpjaFVa?=
 =?utf-8?B?ZHp5RXVvSVRPRUZSSEErUzNKNDAwb1VwamlnVW4xZ1JIRWVQc2s1L0VWc0RQ?=
 =?utf-8?B?eTI1b2trclFPb254cXc1TzRSYTFLWmhlVzJRM1J4STdFMzZBcSt5OVpoSTFR?=
 =?utf-8?B?WTR6ak9RbFU1ODREeDVnVHFMcWF5OE53QnRJWnl6Q2Y3RkE5V2c0VmJ1R2Rz?=
 =?utf-8?Q?Lm6XgbPNknYPI5gPSJbubj0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <860F018745EAA54EA6DD234AD3383955@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc3ddd0-96ca-4f0d-39f8-08dd3ae49696
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 12:59:20.9289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGRpqbgmvYNLCx2IVNYMUAZw0gWhNd08eQTKe3Ip0M3eNdLvOhZ1ibqwjMhTm26DKn5Q6AYq9VYOvwwjKZLOVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR15MB6559
X-Proofpoint-GUID: oPASBA_V-uugvXgL01H9ti3nt3B-jNt7
X-Proofpoint-ORIG-GUID: oPASBA_V-uugvXgL01H9ti3nt3B-jNt7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_05,2025-01-22_02,2024-11-22_01

T24gMjIvMS8yNSAxMjozOSwgRmlsaXBlIE1hbmFuYSB3cm90ZToNCj4gT24gV2VkLCBKYW4gMjIs
IDIwMjUgYXQgMTI6MjXigK9QTSBNYXJrIEhhcm1zdG9uZSA8bWFoYXJtc3RvbmVAZmIuY29tPiB3
cm90ZToNCj4+IEBAIC00OTQ0LDIwICs0OTQyLDE1IEBAIGludCBidHJmc19pbml0X3Jvb3RfZnJl
ZV9vYmplY3RpZChzdHJ1Y3QgYnRyZnNfcm9vdCAqcm9vdCkNCj4+DQo+PiAgIGludCBidHJmc19n
ZXRfZnJlZV9vYmplY3RpZChzdHJ1Y3QgYnRyZnNfcm9vdCAqcm9vdCwgdTY0ICpvYmplY3RpZCkN
Cj4+ICAgew0KPj4gLSAgICAgICBpbnQgcmV0Ow0KPj4gLSAgICAgICBtdXRleF9sb2NrKCZyb290
LT5vYmplY3RpZF9tdXRleCk7DQo+PiArICAgICAgIHU2NCB2YWwgPSBhdG9taWM2NF9pbmNfcmV0
dXJuKCZyb290LT5mcmVlX29iamVjdGlkKSAtIDE7DQo+Pg0KPj4gLSAgICAgICBpZiAodW5saWtl
bHkocm9vdC0+ZnJlZV9vYmplY3RpZCA+PSBCVFJGU19MQVNUX0ZSRUVfT0JKRUNUSUQpKSB7DQo+
PiArICAgICAgIGlmICh1bmxpa2VseSh2YWwgPj0gQlRSRlNfTEFTVF9GUkVFX09CSkVDVElEKSkg
ew0KPj4gICAgICAgICAgICAgICAgICBidHJmc193YXJuKHJvb3QtPmZzX2luZm8sDQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgInRoZSBvYmplY3RpZCBvZiByb290ICVsbHUgcmVhY2hl
cyBpdHMgaGlnaGVzdCB2YWx1ZSIsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnRy
ZnNfcm9vdF9pZChyb290KSk7DQo+PiAtICAgICAgICAgICAgICAgcmV0ID0gLUVOT1NQQzsNCj4+
IC0gICAgICAgICAgICAgICBnb3RvIG91dDsNCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVO
T1NQQzsNCj4+ICAgICAgICAgIH0NCj4+DQo+PiAtICAgICAgICpvYmplY3RpZCA9IHJvb3QtPmZy
ZWVfb2JqZWN0aWQrKzsNCj4+IC0gICAgICAgcmV0ID0gMDsNCj4gDQo+IFNvIHRoaXMgZ2l2ZXMg
ZGlmZmVyZW50IHNlbWFudGljcyBub3cuDQo+IA0KPiBCZWZvcmUgd2UgaW5jcmVtZW50IGZyZWVf
b2JqZWN0aWQgb25seSBpZiBpdCdzIGxlc3MgdGhhbg0KPiBCVFJGU19MQVNUX0ZSRUVfT0JKRUNU
SUQsIHNvIG9uY2Ugd2UgcmVhY2ggdGhhdCB2YWx1ZSB3ZSBjYW4ndCBhc3NpZ24NCj4gbW9yZSBv
YmplY3QgSURzIGFuZCBtdXN0IHJldHVybiAtRU5PU1BDLg0KPiANCj4gQnV0IG5vdyB3ZSBhbHdh
eXMgaW5jcmVtZW50IGFuZCB0aGVuIGRvIHRoZSBjaGVjaywgc28gYWZ0ZXIgc29tZSBjYWxscw0K
PiB0byBidHJmc19nZXRfZnJlZV9vYmplY3RpZCgpIHdlIHdyYXAgYXJvdW5kIHRoZSBjb3VudGVy
IGR1ZSB0bw0KPiBvdmVyZmxvdyBhbmQgZXZlbnR1YWxseSBhbGxvdyByZXVzaW5nIGFscmVhZHkg
YXNzaWduZWQgb2JqZWN0IElEcy4NCj4gDQo+IEknbSBhZnJhaWQgdGhlIGxvY2sgaXMgc3RpbGwg
bmVlZGVkIGJlY2F1c2Ugb2YgdGhhdC4gVG8gbWFrZSBpdCBtb3JlDQo+IGxpZ2h0d2VpZ2h0IG1h
eWJlIHN3aXRjaCB0aGUgbXV0ZXggdG8gYSBzcGlubG9jay4NCj4gDQo+IFRoYW5rcy4NCg0KVGhh
bmtzIEZpbGlwZS4gRG8gd2UgZXZlbiBuZWVkIHRoZSBjaGVjaywgcmVhbGx5PyBFdmVuIGEgZGVu
aWFsIG9mIA0Kc2VydmljZSBhdHRhY2sgd291bGRuJ3QgYmUgYWJsZSB0byBwcmFjdGljYWxseSBj
YWxsIHRoZSBmdW5jdGlvbiB+Ml42NCANCnRpbWVzLiBBbmQgdGhlcmUncyBubyB3YXkgdG8gY3Jl
YXRlIGFuIGlub2RlIHdpdGggYW4gYXJiaXRyYXJ5IG51bWJlciwgDQpzaG9ydCBvZiBtYW51YWxs
eSBoZXgtZWRpdGluZyB0aGUgZGlzay4NCg0KTWFyaw0K

