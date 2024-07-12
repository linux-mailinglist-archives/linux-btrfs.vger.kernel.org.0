Return-Path: <linux-btrfs+bounces-6420-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C7F92FE4B
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 18:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD171F23288
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 16:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46079175564;
	Fri, 12 Jul 2024 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kXDqVO+T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o//omILz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F58A441D;
	Fri, 12 Jul 2024 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800947; cv=fail; b=K6aYzLB6y5Gw5J1ccRA9FeDzrYYhuL5L7M/QqcF0rWIhcmN1SoPfKXZiwGayWmVwHwGOEwSkW74noSU/uHlhfSeTjLn+AjjBf+DHYG5A3IptiyeTxm+Y1LdiNBVYBHbi6EUbrWuiJt6gg5gufDGbUwDfUN+MMg22GubPxisZgkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800947; c=relaxed/simple;
	bh=kstdEJbreQhn6uvQCk1+rlD/TuScboFFv6DZbQDwmMY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gMC0VXMlKWKkZ3TUyXQntijSwW1nMJbVlAusD18TjEwp9uEaadhaU49klGZv+4LzE+J1Cv4QDpqrPy+0VBDomU43eWrE3ZymMb0bfzh0LORctt6dxGrhgCecoxlnLyIbg4VZjRyvszqwSMtUSlouLDmDalIfY7yaBQi1HJL6WXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kXDqVO+T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o//omILz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDIOU5021654;
	Fri, 12 Jul 2024 16:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=3uGYoCvGfnZux45e4OFKZmDzV1jwS9JDlhfI6MoymLA=; b=
	kXDqVO+TMDq7jmqp0p5eQmaL//e0dRtRI7A257W37afq/fRv/tVLrHdlv5axSWuZ
	NUtfEtM4nKhY8/dx4X+nmMtnfC1pOVl134awS+3qOl2Z4ZwAJq+1Wh0ze27jB0KF
	1xUQrpF01iAN50b/SK5ckWVdXyT3uDyR8JvNMb/5eQ4m+dNvyOI7luWnH3SjJ1YE
	YTEuqqeaMCY2uXL1daieR6jLyfFmEa/1cG0Ode7Fhv8IX4xJ0Oxfeny9cBQFS4K6
	OMFPTRdNpGAn8vampe6XBsraamxuiE8vKC8rfoMQsZpl9VztSTczE2s+/722EUaB
	AxA3GO5MATm1w5gdCQnoBg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8m6vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 16:15:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CFHqn5028847;
	Fri, 12 Jul 2024 16:15:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv6ha95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 16:15:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhaAsiKQhMa44WX8E6Fb11laIfmTFT6O8ddyf+Po1frfTWwHsYiWEh5vuftFw9OIMOY1xbYKaqL/4sOuo8fWYzH1XXd5IpQqiXQLY0gASwqac0owUY40UMPspaCsyH/9742Mr9SqpHpb5XX4xXMBl5kxIOsY/N+KR8SfWb2ir9/Ox+wwCUAHk6VPheg1BbhSnTLvplUq2h6HjQ8NhhpCRduXhCco4CCI9H1GLN4Y5X/v9Pcw1CBMBQDA9Bbd34ZrbcrRuMKCDGRbpyhuHRFWREb8qnDHlpr5Z20tWXpOpkt3HUAcrOU8d9ghdmrj+B3LZv6HpfcxqsuAxFUsrm/DwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uGYoCvGfnZux45e4OFKZmDzV1jwS9JDlhfI6MoymLA=;
 b=d6Y0NravdJmxiz296OkfbuyCuCZZm8DTaKh8K56lAa3py4OE2JJEoXSTWCsX5UZqY+QLHbAVmJD6OgUnTer52ClmpHBt5zCwwjYrQLtZKxpW5m8johiUK8BG6nnB6LoGeZ2nn7cgMolDvAGKo5Cj0VwIQJKcAjMO+F/ekHWJf6gmFpp3GpF0iKZ6AwhLh9HZRYVzRmkJk+KL1AF4J1FAggldiW7BZCcqHQKNT04xsfa/hdfWAfMqnAAIHo8pkR83V/jCDCY6evZv3W9tdxsUruULDUQlJ+SLrT643aVFAZZ0MWI3Y1Y7rdHB4aZNpR7Qdqtgmw0qTM5r5z9ujjYk6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uGYoCvGfnZux45e4OFKZmDzV1jwS9JDlhfI6MoymLA=;
 b=o//omILzgmEwLLoVg3ZDZ91O7i9hu13/GXbHPKJo9OOibIygfgviMJ83JtpzVsN6LKJV6MHg2cLuVJgNaCUbsH7EdDwjfvG8L24OZwznleoLtwSDIG3/8KdnDxOCR70W+DkgWQBNi42kIzFcwpLssWvIWU+STGzoTutKzs1OMac=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO6PR10MB5540.namprd10.prod.outlook.com (2603:10b6:303:137::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Fri, 12 Jul
 2024 16:15:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 16:15:36 +0000
Message-ID: <4c8a46f9-e104-44d9-9687-42429b9ac969@oracle.com>
Date: Sat, 13 Jul 2024 00:15:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add test for subvolid reuse with squota
Content-Language: en-GB
To: Boris Burkov <boris@bur.io>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <53cdc0c4696655a0e7a5eb62612a7b87ff4d48cd.1720547422.git.boris@bur.io>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <53cdc0c4696655a0e7a5eb62612a7b87ff4d48cd.1720547422.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0181.apcprd06.prod.outlook.com (2603:1096:4:1::13)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO6PR10MB5540:EE_
X-MS-Office365-Filtering-Correlation-Id: e422b774-42a2-4ee3-6fd9-08dca28ddd06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?akpJVHpoWG9qODJEWk04R21zOThPWWJxSjkrQ3IyNU1jSVJVOTJ1RlpMalM5?=
 =?utf-8?B?NitzazNvLzBEeVBBK0E5bnBsenJZcXVQTThxaGxZK0xVUngvckQxdzlVcWJr?=
 =?utf-8?B?MGV4VFkwSHUyb1JVZFVyRGhVK0s3MlhGb3JMcVJJbGZDRXh3UUpUVWI5bG1q?=
 =?utf-8?B?SzFwTi9zaXpoMmQ4UEIvMkhEVkFFTE0wdkM1a0FGV1FmYzExcExCVW04YzNa?=
 =?utf-8?B?MWcwRWgrS3daZjZVaE4rODJPZjlGNGJ1UXZBZUhsdWpGV0VqQlVYUS8yOEls?=
 =?utf-8?B?azd3L3FMZksrTWRsV0FjZ0ZOVGxGT3pGcjgzSXJDellRUGlaNk52Y3pZM2sr?=
 =?utf-8?B?Rlk5aXJUZ2RnZUFzNkR6b1kxUDk3MTZUV2I3QzdNd3FZTTNsZnpKdFl6OTRq?=
 =?utf-8?B?TDJtYmtma3pDb0ZiY1JkdUt1Um1NU0pFZGs4dkZhK0twbmxISWZpeGVZaVVs?=
 =?utf-8?B?dUFBLzJlSHQzQXN1K0VHODlWZ0U5b1hTRWVFdXprSDlOVkVaTHRPQzc3aURv?=
 =?utf-8?B?ZEl6NElwUTNmblFIemJzUFQvakk5R05XNTMxSFRhaFVZdE5OS3Z0VCt0SlNY?=
 =?utf-8?B?R1g4bTY4dk9GeGRnZ0FhbXkrYStnbWd3VzZQMjQ1S3ltc0ljaHltVVBmUWlm?=
 =?utf-8?B?ZGl6b1FmeEVqTGlSbXZMN3JaZjJaQUVjdUtPWkFPZnhEQU5LT0hjMnRLRVdy?=
 =?utf-8?B?aHB5cE1uL2hGL0N0YUI0UFNkc0hSM1lBVTlEMTVnNmgvSHNsQy9DVlZOOW1B?=
 =?utf-8?B?THhFMXY0YTliVzBENkVPaS9jL3FuSnlja01oLzlCaHJxU1N0RmdDUnkrbFM0?=
 =?utf-8?B?dUlHeHdnWHY2REZKdHJ3SE4xVTlXRDNvMm9zWVc5R1hQSFlXS0grZlpTdWpx?=
 =?utf-8?B?L25xK1IvVzFMUTIxT3RBTldqd0cxTzYwcG5KY3EwRDVTVWhId3EvVm5JT0Fp?=
 =?utf-8?B?RDJFUU5LQTdQbWVuYldPOTUwOFdzS1hEelVMWEJGb0RBY1JlZXhsNW5zQ2Zj?=
 =?utf-8?B?dEVES25HRTZ1dlhnYnk4bFR1QStoTWdiZk1uQ20wQXFFd2djNGdTVmlqdU5J?=
 =?utf-8?B?T2ROd2dMU1FwUUorSmpEblplZDVwLzUxZjc1cGFhaU5kdmc4TFU3TnZGZ2Z3?=
 =?utf-8?B?WWxENWJ1SitQOFBBZ1lMSEhuandCZDA1L1MxZEtvWkRnZVYvRXY3Qm43KzNo?=
 =?utf-8?B?V2NMWjFqcUhhaE42NDVYelZnOEo0eUpITUV4bXBZdTVnR0pyZ0ZuMWYyMEh1?=
 =?utf-8?B?TkNBZW5hb2V3MFBwUUNsT3l4MTFmTXRKclBqV0wzT0ozZ3pEMmJpT1B6VGg4?=
 =?utf-8?B?YTk5VlJsSGxKRzlYTWdqQjI4b2VIcHlId3F0UFNjMHdsVTZpcndQWFhwaUdT?=
 =?utf-8?B?L1J0d3lxL3dwK3JJRjQ5clMvYUpBeDNiSUk4WEU3VnpRWVF3U1gyMnRrM0JB?=
 =?utf-8?B?NFhLRUtoY01EOTFQN2xmdWJyZFBLeU1BcU9XU21yaGpMNkRzSEFrckZRSnVz?=
 =?utf-8?B?dkRHMlN1NjdBKzRRamhRR2RJZzgrRzNWenVlMzAvNHhGNlNIMi9yMC81RHcy?=
 =?utf-8?B?NHA3SFMzeXdsbFZNQis3TmRzZHl4Vm9lZzFPbEkzem83UkJJdjg4Zmg1NVV4?=
 =?utf-8?B?Ti9qbFYwTmtUS1FVRW51UmJXeGJFcE1wak9lS25DSHVPREsvUGltcTlRZnZt?=
 =?utf-8?B?VEUyUVJhTW1XUXI4TnpacXNMeU9QVXFBK3NpSEEySzdaUUw4Z1oyUkx2WWNp?=
 =?utf-8?B?WGJaMTcwalN1YnJpbW5qTTJVZWM5ZGtBYzc1U1dYM3djZTFmcmhDVmNNc0dr?=
 =?utf-8?B?QlVEZG9yc1FCa3BtY09wQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RFJzNlBxK0RScXhORUU0aTdKbk9vQ1ROTnNtL044eE0yeGZWbnB2dGkrdk1I?=
 =?utf-8?B?QzR1cXExbEpFVlpoZHpqSERpeUlZcTZ3Uk0zTUhPOVNYMThKZ1V4eUtVN2Vy?=
 =?utf-8?B?QURPa1lGSUFqMjNoc0xFb3F5eGN4NFlJL250RURCaXl0b2lNWTB1YVRYRnNu?=
 =?utf-8?B?dGhsT0ZuTHhEY0QwQTBCaWF2V3AybkRRcnJ4dEZHRmQ0VlRkNno1amN6dnVX?=
 =?utf-8?B?ck1yUDczc1I3MDVRVnBmaWFjNlRxTnpKUjRUNk9NSGh4NlRuZ2gweUJjRito?=
 =?utf-8?B?WVhnU1hZcjRwcGlFTlE3SDdZNjhveENpeDE2N0ZreStCaWF6K2Q1N1VrS1R4?=
 =?utf-8?B?SVhyTVR5NzZsVUJKRzk0bmZUOHEzSzR5eThZK0c3OUFDbDQ1WnhpQkFBWnU5?=
 =?utf-8?B?VTErc0RKQkFVcVQvTlVhMlc4VnJEOFhtRks3WVJkSEFSNi9neFRIQ3Z2dEtq?=
 =?utf-8?B?c3hPZlVKWUlSZS9YMy9aUFdoS2dzcEN3TDJ4TC95N1gxZmEyUHBndmpDNWhW?=
 =?utf-8?B?cEpUSEQ0ZDlpVjhxV1FNMXRLc0EvZXlzNUJKaTExZUM1TzJ3WVlwcEVCL2k5?=
 =?utf-8?B?VUdFY0x4STBpNG12cXg2L3M3WEs1QTBKSTBjWlZyVVloemM0VE1lYUVZUVZj?=
 =?utf-8?B?d2Q1THMvRS9BZE9POUNUU2NVT0hMRGtzRzFLTE9oWnFmSTdHejlvSC9VUXVt?=
 =?utf-8?B?MTU5NGJqZDlTR0ZqeDBIcFFicWhmOHl5eG15M092TTllZlNtL2hlME1vMzhO?=
 =?utf-8?B?bnhpU2d5TXRHSmkvMk16c1VseHYwV240TmlvNHVZZ1FHY0VaSnBIeXZmRm5n?=
 =?utf-8?B?S3BLRmcyS0w3V3pYeStNQ1VDSVJ4dG5aY05PTi9LbHlRMjNWTUw2SlhYdi9z?=
 =?utf-8?B?ZWg4NUhoNm4wVkJHc21NWWNJdkpxZnl5d2Ztd1RReWZoZXRsdUVqMTVna2xP?=
 =?utf-8?B?K1NBRytHenlxTENpcEE1UDk4UW5GWk5rRjVDays5TnQ5Lzk3TFp0NFFqeWc3?=
 =?utf-8?B?K3lXeGVlOVh5OGtrYktML0tIUThjdUw4NmIxOW5zc09DSmIyRXFndDFzemhE?=
 =?utf-8?B?RitqUmNIVHVlOHhGbk5uZnBBc2pyMFcvWkQ3ZmhKSnYrZGhoN2YraUgvVGU5?=
 =?utf-8?B?QWdMSG9uZzRzUDI5ODNDVk5sdXdqeHBOZFY5RGpMMFF1VEJ5cWdWRzR5Y0V6?=
 =?utf-8?B?MkIxaUhQY0J5YVVKUjExNlBFanFYcnF5U01VazRXSVpGT3ZuU1R3SGc4NFZY?=
 =?utf-8?B?dTZHeHlXaXdXRzR6bjVqTi9kL2MxblNKaFJDV3k3Z1FwQ2FkU3JkZHgrVjdv?=
 =?utf-8?B?SE81OW4rT21BSHdvZk1hWnlmS1FpRCtGUWU2YXhEYVEreWZLM1R6VE9TellW?=
 =?utf-8?B?MThETE1rTXRKZlloZzVYOWlyQnRJa2ZZN3pKMTc1QU1lWHp6cVJSNzhBQnB4?=
 =?utf-8?B?S0cvUUl5Y1VvVVRrN2IxdkIwZUFKNHhzY0dLS1U3Y0w1Z1lVS0Z4SFlCSFV5?=
 =?utf-8?B?LzV6MVduV1BYVEFUK3phbFA4dnExZ1BEdVUrME5qbUZ0QXcvVlVoT2NnRVg2?=
 =?utf-8?B?TDlsaXM5Z3RHZTRMWG95T0xJV2ZmaUJmYUtmQWdkejVmMTg5d3BUNG90OFZR?=
 =?utf-8?B?aDl5S0laMEdjV1ZlTkZOc054bWtNU1pnM1FiVmhuSU84TEtGVElvcmFEUklo?=
 =?utf-8?B?WExVVDdvek0vc2g1a1FjN0hjUVFoU21jbVdSNXI1OFpjY29NWXdER3pmTE9s?=
 =?utf-8?B?eDlwMTl3YzFmcG9oRmZuMXFvZ1lvTEliWFA5aCtaa3JaV0FWM01FRE1ka0l6?=
 =?utf-8?B?S0s4TTRTa3VYOCszQ2FaOTBYR3dGMnVLT0VTZXhvZDRMNTVFZzNMMituOUhy?=
 =?utf-8?B?b2VQT0xVbkpmY09ac3FzMTB6cHFHTUdWRWs4a1RnajdGemJnMzkwOXR5WEo0?=
 =?utf-8?B?WFljeUNBdUtobGZPM0Y4K1VzY0tockt5dm5IY2dRaS8vTVFRbUh3dFh4VDdr?=
 =?utf-8?B?SVd1WXBvM0JCaUlLbXVkVk9VOWFVWW81NFFwdGpBMktmQWVBbzNZdFd1RHFB?=
 =?utf-8?B?WEZla2pYaHhwbUhlTW56c2hCNDVQV0ptT2FreTNjbG5tcS84ZHZRM3BSWXhY?=
 =?utf-8?Q?GtQCSCbW/vNz99e64U46s2kfn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HYb+gBq0kxJsmw1+By0XrTSBofHqJ/MHFlVlQXqZ4/XKO3eqJqfOct3e090dtrN+oCNesbeKLc6Dx9jX6Rf0GSZBjxPi8d51T8x5OTtt39nTYBWfP3/nWvgCBa7QioBa+9zd4TunT+eHItgVfmVFx92CW+ks95DAsTKaetWp6tD5YHLWosS4mxSNZY4fSsQztjToBCQrQ1+/AR4hL8J7w/cyWKcEPiCAmXeEZ5wjDCG1WYqvZgtDZqLIUpyoD0Ex5ycOP7yykvjAxPuW3I6eO8Hp+KMFfIz9Chi5qPDS0iZ1pAgXaLMm8QyncdkjmapIgclgqkmrbR8xKl7dVUkmoJ7E8ngdioh56TXWh1kj0FpI/XgbRoFCf5JlkZ5G+Wa7EEGO2KCD9QLyAQiSG+b9d7t+Dgoritti9FzWH/BqaFNf7NCVsRplzaUlQr8B6J+Yh1R2V4dy94kON4ujeRDlTXDiLyzVKVLe5WjAUroSqVFToS2l6heOwf6JUBgfTsXMUato1KdZ2H1PxdR7tdP3iJmMNyOPfXvUXrdNoaU5lCjn38x1Op+srC6vN07xofRIun2awQjcNzCcxMvIJ1QGGAckj0Z0hRYVZ3JI7ZC0l9c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e422b774-42a2-4ee3-6fd9-08dca28ddd06
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 16:15:36.4731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOoYeOB5UwRywIjaX3LJD4vELMcgJY4Sk1Knen3re1GXj+cW/SPjDdbN6ma6ummz4SFS7bS7gwAb7lya/B4+ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5540
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120111
X-Proofpoint-GUID: XGbm_mzXu5wMVyak17NdS0qgA6rbCIGD
X-Proofpoint-ORIG-GUID: XGbm_mzXu5wMVyak17NdS0qgA6rbCIGD

On 10/07/2024 01:51, Boris Burkov wrote:
> Squotas are likely to leave qgroups that outlive deleted subvolids.
> Before the kernel patch
> 2b8aa78cf127 ("btrfs: qgroup: fix qgroup id collision across mounts")
> this would lead to a repeated subvolid which would collide on an
> existing qgroup id and error out with EEXIST. In snapshot creation, this
> would lead to a read only fs.
> 
> Add a test which exercises the path that could create duplicate
> subvolids but with squotas enabled, which should avoid the trap.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>


Reviewed-by: Anand Jain <anand.jain@oracle.com>

Applied.

Thanks, Anand

> ---
>   tests/btrfs/331     | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/331.out |  2 ++
>   2 files changed, 47 insertions(+)
>   create mode 100755 tests/btrfs/331
>   create mode 100644 tests/btrfs/331.out
> 
> diff --git a/tests/btrfs/331 b/tests/btrfs/331
> new file mode 100755
> index 000000000..8a99d5527
> --- /dev/null
> +++ b/tests/btrfs/331
> @@ -0,0 +1,45 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 331
> +#
> +# Test that btrfs does not recycle subvolume ids across remounts in a way that
> +# breaks squotas.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick qgroup snapshot
> +
> +_fixed_by_kernel_commit 2b8aa78cf127 \
> +	"btrfs: qgroup: fix qgroup id collision across mounts"
> +
> +. ./common/btrfs
> +_supported_fs btrfs
> +_require_scratch_enable_simple_quota
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +$BTRFS_UTIL_PROG quota enable --simple $SCRATCH_MNT
> +
> +# Create a gap in the subvolume IDs
> +sv=$SCRATCH_MNT/sv
> +for i in $(seq 100); do
> +	$BTRFS_UTIL_PROG subvolume create $sv.$i >> $seqres.full
> +done
> +for i in $(seq 50 100); do
> +	$BTRFS_UTIL_PROG subvolume delete $sv.$i >> $seqres.full
> +done
> +
> +# Cycle mount triggers reading the tree_root's free objectid.
> +_scratch_cycle_mount
> +
> +# Create snapshots that could go into the used subvolid space.
> +$BTRFS_UTIL_PROG subvolume create $sv.BOOM >> $seqres.full
> +for i in $(seq 10); do
> +	$BTRFS_UTIL_PROG subvolume snapshot $sv.BOOM $sv.BOOM.$i >> $seqres.full
> +done
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/331.out b/tests/btrfs/331.out
> new file mode 100644
> index 000000000..0097e61d8
> --- /dev/null
> +++ b/tests/btrfs/331.out
> @@ -0,0 +1,2 @@
> +QA output created by 331
> +Silence is golden


