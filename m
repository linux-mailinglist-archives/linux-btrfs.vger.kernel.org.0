Return-Path: <linux-btrfs+bounces-9663-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B879C90DD
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 18:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D0A1F23B67
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 17:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC07218B494;
	Thu, 14 Nov 2024 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="W7PC7HZz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A342262A3
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605680; cv=fail; b=hbS9WI+Gt9seONiy9yOsT04b2pOSRrkxzjD09QtbFvoOYtuuLS+Ogel+u3S6H2mhM3G0lfEStxECSwZHaagvgf7mHIozcYpIQRHvVlOuWrBf6wG8E0HNg4uxWlU+3ebsHCgglSP7c1ybnZDc6IEoAgvSwkBheslZ7efLM30D2G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605680; c=relaxed/simple;
	bh=V/Y127A0ZJ5zZ2hBLckXZaNmwpQb1/dtjIc+ST4n2cU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=JnVsJwHUkVIYXhq0HvgNXI1YS6LIBnGT0ygOG1an0wB83jyVPvbxpRQasxNQuW1/fmkpATURmkCFm1s2UwEACOiVtBDtQ1ZFRmu/EjvmtihuaqdKR2Tq0WYL02i3CHpM0Us1zyZGbZRPIz3+jDUKtg0VDwPIQzt1VbicMqCeNrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=W7PC7HZz; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEHNvIO006393
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 09:34:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=3qMqEvAwyVkA3lYGPpH4PV8KQzfmmwQ6f853wp3pJvc=; b=
	W7PC7HZzSKJ4LXwhraHW2U3bmFMZruDP+9B5aL9LvcMpqcodxFNfN+Xc2udAkMgI
	jIYKYqVQBO119og5jFjI0tXvFaRv8AExEVCyXf/yu7xSMDcZdBNK0Wh+i8MuFGsc
	SRQYGP+VQCLa+NdsfHILe9jw+KB7K4cwVvNUTkWSQBHWxjCU7+pClMZhGR6XAt7d
	X2CRrq6+qXUd10CUoy93WAF0GadXZhkOc3fn1X+YjiFlXxgoU2FDXjpmfFIvB3kZ
	w7ZURTgEtlrH4ThEEf7ckOsv08wvvq2yr4lr08hidCbsxRcQEsbRr6FGoPT/Bnas
	r9MBjWDwx0IwyX7DSdZ9lA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42wbtfcdhq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 09:34:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsvdMctMXQBNMhNnLrczmxk9AEe55zuwOx0b2nRKI4Gv7N25TPCZuERuJSdv5QQstdMHqK6oASSSpdjV7B3zwmNEi4i/rqgCiQqifyU7JKJ4KFa+NJsUrLjCbycrnY4qpaq5/ECKUf35cCJ6leBk2pXEOLwdsoJvM83UztvxoBg/2ZXyyfLe1GPFJM7ddaQPDL52Glwql72TC3QNt2R9BA2c/+KClhmc93EjcGVnZMQ5uDpiLa82kq8KTY+rkyD8IVRAZz2MTlLiPQagmM8+IiNa6VVr+K1Av6tmEJ+NPvLgCI10ZwzZv7Sjpe6fh/uvCG0ydqY7JOEXnTtBV+AEYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaseJlfOV/RVgKmjoqXafU+ErQeFsWRH7ge89IenOak=;
 b=V9xaHPsIQj3Q1POPmuQnpCeRYA5IhBfS9Bf37XPa/JprY8gauFp9cHbHeIxWV/gz8gxc73qTcMlO8dzMSxK3EP8Z56k640NHF9oQLizPl27H4JRaQ2OT2vVNiFSGQNG7CduY35dHepWVVZE95npk/G17DWzZmkxs6f5FvqZRSh33HY60+STmSlIwIWjoEtmTN1Q1C2pFukFyCkK7Sz43BejF4E4lzqqXF0yNQvpsJGWpGfYSoeWxL+OQ7gam35jIGToN8gYx0Cch5aOX8rXUPngvxHL31b5ArEvmde/HXFQeiPWKuAAED6JzFBF0UhWwTy2WzxiOfxPqN1WomrKXqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by CO1PR15MB5004.namprd15.prod.outlook.com (2603:10b6:303:eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 17:34:30 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 17:34:30 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove unused macros in ctree.h
Thread-Topic: [PATCH] btrfs: remove unused macros in ctree.h
Thread-Index: AQHbNqkm4XTAH2ij3k6NlPnpVUZKuLK28sUAgAAW04A=
Date: Thu, 14 Nov 2024 17:34:30 +0000
Message-ID: <94f303ab-78df-4925-825c-61d470de6574@meta.com>
References: <20241114152312.2775224-1-maharmstone@fb.com>
 <20241114161248.GV31418@twin.jikos.cz>
In-Reply-To: <20241114161248.GV31418@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|CO1PR15MB5004:EE_
x-ms-office365-filtering-correlation-id: d7e7f088-cedb-4c56-8071-08dd04d2988d
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bmdJUG9BUEpCZUY5YWlpL2VzYlJyb1dPQmVMUWdsZ1hyWWl4REVHRmZVelZW?=
 =?utf-8?B?S294dWlSQWt0eGhRWTJ3eFdML0ZEeER0K2FtcXcrWUgrYlMxaWIzQ0J2R2l4?=
 =?utf-8?B?RStTUlpxTkgvTHZlcDRNZlA5T05SRlZka1NWeGJnL2c3SVM5RmI5R3BtNkNO?=
 =?utf-8?B?VkNSbmxyaUNsZTc1RnBTVmVIbFFFQTU4aTRucUdkZkxSMy9HdnliQ2h3SUYv?=
 =?utf-8?B?NE5IMmZaU3l1YjZIVlUzd2RUc3Y4SnFoeE9XWDNqSmRvOGlzL1JKNHpmTjd6?=
 =?utf-8?B?NG55S2MxQnBWZW03MWE3U2Nzd3VRNmlGZEx2MWcxUEhwTTNSR2ZSTHdxbDNv?=
 =?utf-8?B?dXpibHJMWHVTaXUrbWdKOSt4RnlPdko5RStVcGcyNmw1b2pzZWlYenB5dDZ6?=
 =?utf-8?B?aitGd2g4MVdnODRjWGNSL3NvWTF5OXdCRFdFcFFlcFBSUXd2MldBd09NbnJJ?=
 =?utf-8?B?b0tEbTE0SHI0dFNNeWhvRkpSai94VitFSS9TSGxheU9sRHY0ejZjVWx0TVZt?=
 =?utf-8?B?YVhwOTNqOUhPMUUxS0N4dnhjWCs3cUZyWEZNN1Z2ZllIMHJqcEEzQ0s1Wk8r?=
 =?utf-8?B?Qmw4eFVjbWNvdmFnV1pmZE1xOGJ6UmZYNUhYaUFPRkYwNXpqNnE0ZldKSkU1?=
 =?utf-8?B?dTROenpZekM5YWpLUG41UVFUUkR3bEtKSXpjTWhZcmIwc1FUTk1TaGNaMGhP?=
 =?utf-8?B?OHZKVWlQZWt0blMzS2ptQ3hZWlUwaHlpaFpLbWhOd0ozdDJRQVV5TnJyM2o0?=
 =?utf-8?B?dnc1UjQydGZPc3JOUXBZcCtRNnN0VHJoN2NWTHFFRzdZRFR6d3RUVjl3QTdj?=
 =?utf-8?B?OW5XSitjSHMwaHZ4Y3gvSFJkbVhNSHpHNk5udmk2THVUTW4zTWpIUzBlOENz?=
 =?utf-8?B?dnppVEFYWTZvRWh2d2ZSU1hIZ0o4MWhBU2tab0RZd2ErajJlaXIwcTJ3b21I?=
 =?utf-8?B?QjNxS0F3Rm9KQXlJOUthSmpnVWxDdzdhdHoyaHpydElTQ2NjTFNYR21LZU10?=
 =?utf-8?B?ZHZ4aFlmN1UzdTRjMVpGaktOa005eWptaU1hRUErS2Eyc0lBdnQrVXJmR21I?=
 =?utf-8?B?cHF3VmVPeW9OUk15STVycGprMnRuOGsvMzA3YXh4Z2tBN0M3ZTZ2TzZEYTFt?=
 =?utf-8?B?MGF0RlRHaTJBalpkQ3dMVUpUSkZJS1lKejFHdExxK1pZVVNZZ3Y3dTIxbDZK?=
 =?utf-8?B?SkR3UXBJdFc0bTJKTFZqTTN3VEpXTVlZQ2F4NmtZdUZHRERJWFBzZ0Zxd2hn?=
 =?utf-8?B?ZWVBc3Q4Zllsby81MjVvaWQ2NzJnd2lPaVBnaEdHeDRiUU1FUGVrbm1vZ0RG?=
 =?utf-8?B?djllaC9VTndQUUM5TktpeGRvSm52MW9PTWR0T3YvV2NET1dDay9yTzl3N2Nh?=
 =?utf-8?B?eUhaUlpYdmQ0ZzVNYTJhbUxaVWdGeGp6UFVtNmRjUUR6UFNrZWJVMXZFenN5?=
 =?utf-8?B?ZEZUVG1USDNWUWhMK00zNkxoMmJLbzE2cU1UMkErS2k2d0pMbGdqZW15TnZW?=
 =?utf-8?B?RUVHTWZjdUQyeUk0dW5KRHFIcG5TelkyTDlBMXNNZE1yYkRBT3JrUFpqYXpi?=
 =?utf-8?B?bFpST3U4MWxuUGs1enJiNXA1TjYrZE1Cb05WKy9DcmFmNVVYSmh0dWV1TDI5?=
 =?utf-8?B?RllKRVFmNSt0aUxaSmpPQmdoTjZhSkhDYW9zM1ZOQkxpUkhhd2tUNEpsa1FC?=
 =?utf-8?B?NnJ6bEE3QVJsd2xEYzZCSEVUTS9oK0hmR01PSjZvN1NCcmYyT2lPZmhxYnVB?=
 =?utf-8?B?elZrckYxWE5QZ3cxY0JjeEhld2JOZnhmZWxFK2xMVjZ6MDlRcWl1cVRVMEZ0?=
 =?utf-8?B?enhic3ZMaUdlSWFjOC9NOExkeVhsVXRHT3NDaWFQRlZVN3puNkZLMHcxb1ZE?=
 =?utf-8?Q?CDW/CbesAL5MA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3E5NjY0RXE2bVMzN0JweTJwd1B4N3Qvalg4dnhPRkM1YmVWb3l6YlFJSkVp?=
 =?utf-8?B?dkxKamhQTEsrMG1nUjFadmlwSm9VZktGMFlnb1l2RlBVQ2Q4QURUdTJ0aEds?=
 =?utf-8?B?NnF2WlZXSGxVa0NIYXBKeE1ybkhjbmEyNHlYS1U2RW5aUkM1R2RRd3VoUktm?=
 =?utf-8?B?Q2lpNkwrNTlPM01KM095L0syTVpjbWRqUGd2VGdLTmZRdi81WVJldHk5NmYv?=
 =?utf-8?B?bGZhcW9rcGlVSGFXUXY4WEpNM2hCcFE1WmR5bWZUeS9WMHJ4V2NsdG1OYUhp?=
 =?utf-8?B?U0JRVnhRbkVmcGlGdFVUbnVRNUYwS3lSc2N2TFE4MklCNFhJZkRoWXZUR1Nw?=
 =?utf-8?B?Qy9CcndWdjRvM1oxN0FjT1pjbWVRanArNXpjM2kzNmFQNVhpQmQyaFZmSkl5?=
 =?utf-8?B?UVQ5VkxGYUhLY3VaTFFsaVNHaWtjc01CTzd0SlhTa2g5cHpFcEVBanFlcnIw?=
 =?utf-8?B?ejk2TlBPSGdvb2JvUGltZUY0VDRiWDFvbDc4U2xhaGRpT2YyOGtJYXFLbWdI?=
 =?utf-8?B?d1VBcTFrZFBvY05UWVpRZmN0b1k4VlUyNnhtUDIzN0tFQThpNURDYXNqWldk?=
 =?utf-8?B?UW9MYlMvakwzVmtHTXovK3pXNm9qdnRUZUhJTWhYNitTQ3hDcUVOMU15aVow?=
 =?utf-8?B?aU5SN1dLSzRudWFOTFdycGtKWlZib3c5TDlQNlg1YzhWTzVSZ21yck5ibm5z?=
 =?utf-8?B?aG9ZWDkzRnY2YS9FUk8yK3BKZDdKakxOcDZZTHVTZ25zU3RlM2tXL3Z3L0ZK?=
 =?utf-8?B?QTloQ2E5TEpMTm00enNBS0Q2OFZqdVd5N2Q3ZU9Cb1kyUDNSUElrZGlEeEVE?=
 =?utf-8?B?N25PckdwLzU3R3ZyZS9yWFRNSXdnbmlaRCtMcVdUZ014cXZid1Y0VFlkM2Ry?=
 =?utf-8?B?Sm40UlNmczlrc0lTZm9XdWs1UDVnWHlmR3JGb0xTdHl2MEVzUlJEWTdqUmZJ?=
 =?utf-8?B?bWY2a3Q0NkpFRUVwZk1Jc29CMFdvRmh6ZmxjamxvL2NXdysxZFZaeVBHQjJm?=
 =?utf-8?B?MVF3blFNd1Rld1JrYWx0bEZBcGpXM1hwdS9iM3A0YjVrOWxEUjk2OTJkTmx2?=
 =?utf-8?B?NVRsS0dnMzRSWG8rdWd4MGYwZ0d6Q21jZ0REMDN6WXM5YU1mcEt1TlpaNG9M?=
 =?utf-8?B?eUpGbDNjZHVDWkxtWDJTSWcvYjEyVW5JbTVUcFZCY09jM1V1TWloZ1lHeWY0?=
 =?utf-8?B?MCtYNXltcVpnczZ5S0k4UTF2RGgwUTNDeGVONDNtME1xVjJhMmdGVTZLRE9o?=
 =?utf-8?B?L1NaUTloUFI4Lzd4ZGMxUTJCdStNb09URUVJRDB0dW1MTEoyaGJZOHcva05C?=
 =?utf-8?B?U3dCWFVNVklKQStQbDlIWnhXK1cxenA0Z2lrZEFWZlFzTU05K3hsVm5LQjdS?=
 =?utf-8?B?bk42UlJlRWYzaUVFQVRlaGhnZ2Q3K0R3TUw2cTBwYnF3NEhQTkxnK3ZuOVdt?=
 =?utf-8?B?b20rTStBemNBcWlyTGdhQXZkNUNTVEx5MXFyL1AwVldhSGdPeU53SnFKQktv?=
 =?utf-8?B?enpGUTZGbFFRVmUxUmVldXY2NkZ1TjdpcUZseGgrQ09ZRlo4ZHdEMG4zZ0FO?=
 =?utf-8?B?VjJoNWkydkZCVkxkNmFtaGF4TTFFQndGTHVTcUQ3VDlIR2VrNUQ0TWZlZzNH?=
 =?utf-8?B?OC83VU9NM2x1aFVYNmsrWi9Nb0x0aXVmWnRxbm0wUzRUODV2cUFWK3hDcUNI?=
 =?utf-8?B?aWM1NUVpTkR2Nm9pOU1takV3NjZTb04vN3ptTlhVRklnTXFZZTlhNWV1dndG?=
 =?utf-8?B?aE9FMldoTzlKSCtEaUIyL2kxY2tzdWhXRi85N1lrNzB4YUVFRkhnWEcxd04w?=
 =?utf-8?B?bzNNRW5XUDlja1JJc0JQdGZTazFnSXJFZWhBaHRVbExBeExwODlIYkJxaGVm?=
 =?utf-8?B?Ui9TSFdpcXBrN1FXR2kwS2lkUzJrMUpzQUJmQkZSWlBSSHM0TUdSWU02T0k0?=
 =?utf-8?B?a2dYbEU2NUdxTkFvc1B1cDJid0RwdE5FSVFoSTU0dnlwWVdCam5qS09VSmhu?=
 =?utf-8?B?VTJ6TWJiU3p5Q2F6S3R5T2xmSCtLS2hrcTRjdkZCVnVFZ0Z0SnNHNjZqVk5O?=
 =?utf-8?B?N2w0VVJKWUo5VHV1MWNDTHFicmhuUyt6R05neDlCZ2JEcU1ZVGUySzE5ZndC?=
 =?utf-8?B?M3lFOHkxaVlVdTk2YjJ1TlRyb3ZkbnNKZnZXQzIyaGRqa2E5eHJLcUkzNFh1?=
 =?utf-8?Q?d8IiSGiPljE2xOcsWs16OWc=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e7f088-cedb-4c56-8071-08dd04d2988d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 17:34:30.5197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gVxK0aIFPoqi2aUYbkTBtcyc7eV1MeWzuaZ0aJ8DeT9PAUhBdbixcDcVaB4HgwHfunmgPaKkOZdvlMrI2cdoDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB5004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <EC62B2C09CAEB64790C60489CE62AB70@namprd15.prod.outlook.com>
X-Proofpoint-ORIG-GUID: JM7qhiP0j8JYcxtVyb0IdxO1PpuH65Y-
X-Proofpoint-GUID: JM7qhiP0j8JYcxtVyb0IdxO1PpuH65Y-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

Ah, ignore this then. Thanks David

On 14/11/24 16:12, David Sterba wrote:
> >=20
> On Thu, Nov 14, 2024 at 03:22:53PM +0000, Mark Harmstone wrote:
>> The Private2 #ifdefs in ctree.h for pages are no longer used, as of
>> commit d71b53c3cb0a. Remove them, and update the comment to be about fol=
ios.
>>
>> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
>> ---
>>   fs/btrfs/ctree.h | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 317a3712270f..60c205ac5278 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -744,14 +744,11 @@ const char *btrfs_super_csum_driver(u16 csum_type);
>>   size_t __attribute_const__ btrfs_get_num_csums(void);
>>  =20
>>   /*
>> - * We use page status Private2 to indicate there is an ordered extent w=
ith
>> + * We use folio status private_2 to indicate there is an ordered extent=
 with
>>    * unfinished IO.
>>    *
>> - * Rename the Private2 accessors to Ordered, to improve readability.
>> + * Rename the private_2 accessors to ordered, to improve readability.
>>    */
>> -#define PageOrdered(page)		PagePrivate2(page)
>> -#define SetPageOrdered(page)		SetPagePrivate2(page)
>> -#define ClearPageOrdered(page)		ClearPagePrivate2(page)
>>   #define folio_test_ordered(folio)	folio_test_private_2(folio)
>>   #define folio_set_ordered(folio)	folio_set_private_2(folio)
>>   #define folio_clear_ordered(folio)	folio_clear_private_2(folio)
>=20
> While this is right, there's a patch (now in linux-next)
> https://lore.kernel.org/all/20241002040111.1023018-5-willy@infradead.org/
> that removes that (with some other updates).


