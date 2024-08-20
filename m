Return-Path: <linux-btrfs+bounces-7336-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F18EE958861
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 16:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC281C20C0B
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 14:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80D7191478;
	Tue, 20 Aug 2024 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KEcpHuh9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2078.outbound.protection.outlook.com [40.92.90.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538C118CBEF
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162486; cv=fail; b=iwIUfd8Q2XjhPiIEoxAwcr4ufuG9UMl6Z3F4GkNjk+XN500H/OZWM36CEaTDZo8Lp2hYt0K+bUr0EbDomDZ4iw7Xcc+HC8v0aLHAqGrfvCvlKEpf22qHISGvGLLODglBYq1OFfn3/kJGNHIzaJMTEuqul8pbFH1WYEMQwirXQ3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162486; c=relaxed/simple;
	bh=oX+eubxP/2A38EMs1CAi3B7HvkU+a0+s4hDHSTn0Ycw=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LlFMpoYBMMtIdRfxTuK47XEyMolM9u5o7u+t7H3bP4NQ+a0qJ+yFQuIluyFTNyOJGm5g1eSba4pI9LVXcWQaeXl8T0s9fS+lZ99NK3PN/n6+ck1MQgELn+nOC89rN/h/Cgyefq3t5j0xAKne0+crV+nyA7dRuO+GBtaW8Tq60b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KEcpHuh9; arc=fail smtp.client-ip=40.92.90.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=riT4ytfBxE/+jkmMp6uY5gLXXGM1wO8jtNNJvadXVlD5R6CvBlOl8vuv2LGVh85zGFMP+GVx5up83XqE8d2BN4MNBTnziN7dxlFhMrIiETRA8/ZQt1KCamhxNhhIj46Lc2zj/UOSj3T9cetZ2OmQNetYfPyIznuXXa9OPM5zTBQ6ai6goADTBPh70yuBKYqHIUlkBet4us5S0rgOLpwkpKukwl1Vu0uq0Q5Te3lWTM0uneBXLWgIbh6Rx4+6iNhy8YA6pwcDhHXmntx3YUwym8/PQdzpnBsqV8yN3rDSqd7fTCF3wNI85f6SSDWD/LZGjLUXErrO2K5XECRe2qk3NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hTwlwUxT+1QSi3CKsuMhy2nwDHzFpyz+A6K/IeW2BM=;
 b=mEtXT7xIi76vQ3/WsJWqr3FgIF3Idodtr8G77fQYSdHpFwfNDUERhCzGEWG+Dcsp3xhzxy98G3gOILrwNiUVnH3cqabVnmZydgsMyKNR0Go+w9WAEcO+mHmCJWJ1XkqsB3MuGHXxDJ6/ccWQA20J0h4pIIO5o2/SIZavXiDtKo8CtU7gcLOsV44Nbc9+TDT1SKMRDdkjFTLrRMcyV0X5P2DVwsw0ckbf4uJgp0+yumajf4PoSKsLChqlhdC98NL8Z4/g/YxG0kVy+odEfKaqkjHamohv+GJop53vXlKMoSDEBKDFVks4AzI/8GQnTyIxTXbFfQyBDdR9BYTyG64fGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hTwlwUxT+1QSi3CKsuMhy2nwDHzFpyz+A6K/IeW2BM=;
 b=KEcpHuh9sfArPkpUQluFFOHPm2Ti1h69bqDSmGo+nhWOic1X4UbVCypo70D0zJkXRSM0OYmnrO0x303yyzHm8unj/RZbAK3DAnD9DYZPFy1BW0EWbJA+H5YYLkJKFPcRxbeZg32ks1V6xN3cd+RZnKNHxrwSY4ioep0oMXump9/RObrPa+9NB44DuQcjs7nz+ulZq2CNiOMqLpD3G/Jx2afCAdofxszW9Lsc9JDM9jiEF9xePw/0IP+XNl+FgShiOd3i+4BPevetshzy/3lexM9RFcrJaLt8XPj/UULzGqFNsYpwoWTDUiSg0xHmKRlMPybnwMGy1Vh8DIxy8K2sEA==
Received: from AS8P250MB0886.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:54b::7)
 by PR3P250MB0308.EURP250.PROD.OUTLOOK.COM (2603:10a6:102:17f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 14:01:21 +0000
Received: from AS8P250MB0886.EURP250.PROD.OUTLOOK.COM
 ([fe80::e8e5:32e2:57ff:ab61]) by AS8P250MB0886.EURP250.PROD.OUTLOOK.COM
 ([fe80::e8e5:32e2:57ff:ab61%2]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 14:01:21 +0000
Message-ID:
 <AS8P250MB0886FC6ADE47901FBD009A6D8F8D2@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
Date: Tue, 20 Aug 2024 16:01:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Errors found in extent allocation tree (single bit flipped)
From: Pieter P <pieter.p.dev@outlook.com>
To: linux-btrfs@vger.kernel.org
References: <AS8P250MB0886A81B469CD5F707144EA38F852@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <AS8P250MB0886A81B469CD5F707144EA38F852@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [l/10RcO1gTEy5CD0hSTbv++UicDV2AnD]
X-ClientProxiedBy: PA7P264CA0232.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:372::19) To AS8P250MB0886.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:54b::7)
X-Microsoft-Original-Message-ID:
 <6f0c9bc9-08b6-45db-b681-318da0a9fb9b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P250MB0886:EE_|PR3P250MB0308:EE_
X-MS-Office365-Filtering-Correlation-Id: e154b66e-15cb-43cc-f198-08dcc120920c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799003|19110799003|8060799006|461199028|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	EEBgnOkHvPReSL/P0RFgyouhlcuVsMC/gLDgyjSwHpchoVjt8Cxy07HTPJFyRvlW//VlAxjU8DHVQHTDcB3Ej2ZO2oUV7wG2HLX9h3chbvwY4dMcz7ySF7YKEMr9tAtfLphFyHqVVCeHcOMGUEqy52tOUwsgcUPukxZ6DazidImE57bFN2s1IPFYZCaY7mkf1p29fea1JQk7Dug3n5U3BVmpiwqprU3l7gf5/MnnJy6TBbSCJZb87Ear0/Pdix8p0zJA+a4ClQI8XvwAq2L6eb+e9qmZ69KDZTVnmhZB/Ch6X8KCI45MijuTTE4OctxSyAfwNx5NgsFS3X0UCCULrIj2Z1w0jxLN2IbLUsPgEJ7cscV9/60uwaaN8U0x7Ej6j2+S021tDDjZ6imvqhEAJI2suajjmxSubAM7zxZ8om9W8eEJ99/djVnSOwopg1ECsFzxoCgnfKDh8HSGl1F6lLFMsSU51w3PKIXiA7kYEntxzhTqpQZOl5oYec26DIajGusuMkppKO+FevNuFWonc1pZU2/at3sOqt623Ts8+3l+LPcpUT00+9IUyV5+TUxH5nHQt4YjY1+4GI+5Th5mpbpXO3j1TTvm0y3hvKgg69UxHZR+evgkgQdpJ85OZokrL5/RnjMWlUlEIUN4hSPs/XNbLbElq5CGV0YGcWKkgHAIcKh+IKAp1sRM7iJ5EqiX5MFwpxU+x5Yc5JRyoA0xiA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlBveTdiYm5xVTNKWERScGxwRHJaZEphN29MQXhZbHA2N29lckVFYklOVVly?=
 =?utf-8?B?MEhCQXVpbnNTVThxMkNGbWErSXRXWHZvNzBZL2sxRkh6M1ExeWNzdUZXRisy?=
 =?utf-8?B?aUtWTkZJWmdZTzY0Sm81VFNvUjRCZkNyREhNZW15REhxY1ZzblRCcFlzaitP?=
 =?utf-8?B?MDEwaFZDdlpvb0U1WlAvNTM4NlBlbU8xL3BFM3psMVlqdzY0a1JidHpmczhB?=
 =?utf-8?B?UXNmbFpwU2ZNZ2JFTkJMZlUxT1AyaUdQSW5NL3lOOEN6TW1ad2ltcS9WR2Rs?=
 =?utf-8?B?dFk0QkNjc3ZRZXYvbkwxQTVydEsrczNzZ0tMUXVpQjh6VVI3UHJOdlB0UHV3?=
 =?utf-8?B?UDZadWRtb0xwY0xtcGxVMjZLYWhZakRNTHVqc1RvUUdvUjFqd1ZycmZVWHFl?=
 =?utf-8?B?SVNvdkNpZmpKaCtZWkdPMXhXN3lNOFU4R0ppWXF4Sld2Nk9ycjNrQlRxaUNU?=
 =?utf-8?B?MTFsT3RoZXgyZXlJK1VoTE9YU01sV1JUc1V3a1NVeXpZdzB3SlJ1WVZIZmF4?=
 =?utf-8?B?T2dPRzVHNGFLLzVqRDFkZTlGVG1NMkJWR0RXNUFQMkE0UUxqV0VJUU5uSEpL?=
 =?utf-8?B?YXkzU0RUQ2F1eUhycWVkZVVRUE1QU28zSFN4WkMwdWo2bThEYVhaQjhVT0ti?=
 =?utf-8?B?cW01bmpDRFZXRDZZdGQrY2xhMVJQR3RobllPeW5XTEc0WXVpUHRGdUNMSWJY?=
 =?utf-8?B?aFdiSkJVekVKVnd3S005SEFaSmF1R1Z5UUxvREowdC9uUFVCYjFmV01sUVow?=
 =?utf-8?B?RTJkbmJIemNYR3ZsVUdvSDRXaWVacXMvTjVQYWRtY0xFTmFtN1Y5NnZjVVN0?=
 =?utf-8?B?TTlLNWR4R3BlSkd3aTNuY3VJWkx5eXBUVVlvNmhkK1d2KzM2UmRLcnpTbUhz?=
 =?utf-8?B?cllreDZ1Z0htbW04Skw0cnRjUFJYbDVBQVhXUDREZFhJT2NzVnlZakRJY0pp?=
 =?utf-8?B?c0FyTlVnZlk5eVJIRWRQUUxhNHpQWFVnL3pMWXJONUtJSEZMQkhGc3p4SjQ3?=
 =?utf-8?B?a0h2anByVE5MTTdMV3FLQnFGbnlXcFlYdXEvY1Uwakl5anl4T0lidFhxY3ZX?=
 =?utf-8?B?czBTSjVsUG1xWlFPNklwMERIQjhzNXJyWXRTOTZwY2JET05EWENVa0hzTVdO?=
 =?utf-8?B?b1E5L2NxdzUyN0VxbnFjd3U0cTFzV2dKRHRxNU9tY2gzNGtCN1VqMzZmQ3NH?=
 =?utf-8?B?YitQenJVei9DY2dwZks0RGZKYVA4citIbXRVcEdIcXNIVVdSWnFnSU9XYzh6?=
 =?utf-8?B?R2VEclh4bmhralJJd2pjcmlldEluc3hQRjBqTjlqRS9NTjdSTXFNWm0xK0ti?=
 =?utf-8?B?L3lIM1kwT3lleGdmZjhJcWVxZDY5YkJUY2traTQ0YmRVajJYWUV4YUtJRENX?=
 =?utf-8?B?L1Q4ZlZpMlA5NTNibXNSM3hUYnAvRzZwR2tQZlVTUzVDa1kvS0RWUFZ0cFRt?=
 =?utf-8?B?WFROckErZGtTR05pTzJwc3M1NGhCV0piTzZHMzQ0cVJhK05mNi9iSHBMamFs?=
 =?utf-8?B?clFYY3U0SkN6YUg5R0hxK2VGUmpsMExTOWdKUTgxdXFkWnBPSDI1Ly9GUW02?=
 =?utf-8?B?TlMvZTBoZVRyQU5tamlkNS85UGV1a3lqeGdPKzN5UFE4TU1vTmNGU09yMHh1?=
 =?utf-8?B?b1F1b25qbGlWdEtoQ3ZSV1hSRXRkSGF2TlFUbWYzL0hqeFgvai8vR2RYeFE3?=
 =?utf-8?Q?V865q9TgAaZpw38vRpyI?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e154b66e-15cb-43cc-f198-08dcc120920c
X-MS-Exchange-CrossTenant-AuthSource: AS8P250MB0886.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 14:01:21.6315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P250MB0308

On 12/08/2024 16:57, Pieter P wrote:
> Can this problem be fixed by running btrfs check --repair from a live 
> USB? (I'm using Ubuntu 22.04 with btrfs-progs v5.16.2).

Turns out, the answer is no :(
I tried this on (a copy of) a backup image of the corrupt file system, 
and btrfs check --repair simply failed in step [2/7].

1. What should my next move be? How can I fix my file system?
2. Or if that's not possible, how to figure out which files may be 
lost/corrupt when copying everything to a fresh btrfs partition?
3. When creating a new file system, can I somehow "clone" the subvolumes 
on my current file system (e.g. @ and @home, and the dozens of 
subvolumes created by Docker)?

Thanks,
Pieter


