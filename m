Return-Path: <linux-btrfs+bounces-11309-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6DEA29D8F
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 00:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2BCF18891B9
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 23:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C486722068F;
	Wed,  5 Feb 2025 23:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TC+ABVk7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qAd/iu6O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08997217733;
	Wed,  5 Feb 2025 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738798225; cv=fail; b=S4XoB0mcbgivcqUH8w7Q1GSLDaGbXZqUfwRv87LWxMjU37lODhKrfNQ5EjQuYbopViZZvK5MzDMrzXAQaDe9OuQNEkBA/yHYUKKpRAEPbicisPYjKjZIPSGme2G2LpI7q+UrXqWlxcyJxH+h2ktDd5N34S7BtdNO2Hd81VhAYa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738798225; c=relaxed/simple;
	bh=x3pk3dMLhWXPlq68P8ykUMbq6JlezD+UCOHOkg9vaU8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=izT2qePU4g4dlK4Ep9JHMcquAcffcf2630KHvW+SxuqWKJzsar857XQWMvhXU3KzVcjPo1PhQYMcjj7N1NI+mehEuWwtjDANNwLA00dD2smiva6F4BLSoF5BexOu0ukAZ75mkQzoe2CY9H+6Ji/TVV9/hbbH+jJ7XeFeaFzp/J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TC+ABVk7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qAd/iu6O; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515N1PSi023037;
	Wed, 5 Feb 2025 23:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XTxCABj0pZAab3mvRHnHeGaUgv/uo5b5JVX8G1Sa02Q=; b=
	TC+ABVk7rlIk0QHqRAvXJ8Q7DvABkxDTYzSUwk+eDr24tux1p6av6c4LCp+Aena8
	FEMbPAMHbvxy+GtwZCYhX2AN93LsUCvno8ArSsF23iZohHXsDK3EUxsUs1xAngw1
	A1+qGp9B/CC2qZks8ysJ7+83FtEgyOXzoa3YCwE0rc9kVZwJw6R8tmhe41U+J+aB
	SE6r2q7yfHDGvaAS1L2pNxRrpRq3lBZcFqkZZIRy++Y2tfl5v6v582C2BRlGwEqF
	4U7HjMszY4jsLU95a5MGeNAxxi+Lqd1JcTEffpfpMDNYlZmmcQOWe4tfacaP2T7y
	7nUpkZv/vMgDS4pFzBUilg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kckxm6kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 23:30:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515Lv11P023505;
	Wed, 5 Feb 2025 23:30:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8gk0swv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 23:30:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0vkC9c3IfEu9Ijr50k5fcO5ZGStyRS3w5KDHQbDqzJF/U8/86CoQPFPysGzvP+53Esp+iN4ggBKadOoaal2ohfSWNDwjQeV3OOC95LyorpqQuzJTnRxuM+0dwfPecTmLvQwyQpxTMTd8GUdCryOvzYNwI/jZ1AD1AUlCfemoOuvJiH9ox5sYwyrWDA7f3SrsZDtcq57/J7lBJe66J6boRozxFYPhmfePHBiBwySO2M3PJJclQ7BX4uy6UNwr3yzAh/S57f3YkeQHkV7imFxHgaAq3OQGXQV2EC5oK5O92aXOSj9Z1CIOUS0fOIMcABkIlqK03qNSCcVXyG0I6j7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTxCABj0pZAab3mvRHnHeGaUgv/uo5b5JVX8G1Sa02Q=;
 b=ZszMDhy5Q8uD//A5elXehVaxLEc1oT4IJGtxegSiQEox4lJAdoeStQTU/9g0hV/EITlnFKhIzBcXJ+abj814xHqY7qj2P+CwS1Cg9majzOsIj92zsj2bVvaDgVDwX6Kby3uLfBeohB8ye943tEu9DH0AQFYK2uahdGfT9L97UXhA1m69vuinYoIrmcl2mfFCrpfCSDOO1whUT03T3Uvme67yicVacoBIhh5s+WNz4gSCclTnpCUSgPZWW7PPM7Rl7d0P3AVDFjbMbmLl99TIo8Lmmd72k7O0FKjaK3Z4sXe0sD0Dvwqwp3iD7wCY1ARqWlR2wxT+MN25NwoufI1jqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTxCABj0pZAab3mvRHnHeGaUgv/uo5b5JVX8G1Sa02Q=;
 b=qAd/iu6OU9C7AxFfVuKpM/LtpyqOtomuBpD7RYzEcE9K5Tn+sjQ0DSDiY3NQWmOX74iDvdm8uKS85Yqf9qu6K7Zm0ckuoLMGE73du4Yo1+kkSTkRG3MjBAGp8FNM0nDIjAofDYVJ6w3gzVCzHNP9fgvYgybFsDPnct0EFmtli+0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4438.namprd10.prod.outlook.com (2603:10b6:510:36::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 23:30:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 23:30:18 +0000
Message-ID: <6d95382c-181b-40ea-9096-37a16b68a3bc@oracle.com>
Date: Thu, 6 Feb 2025 07:30:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] fstests: btrfs: add test case to validate sysfs
 input arguments
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1738752716.git.anand.jain@oracle.com>
 <Z6PWb__u9h25RCX4@dread.disaster.area>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <Z6PWb__u9h25RCX4@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4438:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f3fc9fa-344c-4a10-8a87-08dd463d0d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0FoaEFFMjNjNE55ZE5TTG9ldityTmpxKytJcitjQk1jam1RZERrSTJGeXNw?=
 =?utf-8?B?N1B5Ny9jUFMxcHZPbVhHeHlGOE5qTnc2VVU3UllUcTRpT2h1OWFsN3BwMFY1?=
 =?utf-8?B?eFE5ZFRXaVorU1F0Z0RIZnVTY3hVNC9EbzZhcmZJSklpdDlJTVkvVnFneUc0?=
 =?utf-8?B?V1RWdFpiUFBKczRBRWNJdWJiQW1MN2o1byt2L0pyeWlVdXRFcHZvNTMxTVkw?=
 =?utf-8?B?QnBnZGxpMFZobzdUbHpQS3VVQSt1R1JQa1YzbDRpRGIwVy8zVm4yb3FoSlMz?=
 =?utf-8?B?VUJyaGpmSW5md2lQbWpxZE9vR3RxNVJEemR2VlZ4T3dRT3lPWDhxZDhYdk54?=
 =?utf-8?B?UTh2ZU5BeUdUaGxOOG1HVlMzckR0STRPU3p0OGsxc2tUeXRyaVQyOWxBeG0w?=
 =?utf-8?B?WnplNHNqT2M0dEdaVDRSdCtVRlBmd1JMTzNUbnRxRFJ2cGxES1B1YnNOWWUx?=
 =?utf-8?B?ZGNJTzdqNVdESE5tdGY1VkpzMG5iMFNXMTRkTS96bEpuSUMrUHo1enVJK3NK?=
 =?utf-8?B?QVVpVEFhOEdScElFWFNDU3hVYkVRRUFBRnliYUdCZ3dtMGkxRXZJWjJ5d3lj?=
 =?utf-8?B?RGRXYXBnTVFPZytuMEdmd1BoamtYYjBlYjRFT2RqWnhpQzFnSnZoeTVNUjdz?=
 =?utf-8?B?cHZvNTNmTU0rMEZJS1VNbVFubXloQVVxZERNU2hYdkdrMFM5SkswVTc3Wlo2?=
 =?utf-8?B?Sm5WanZISmc1cU9qODYralh5SmkxcGtmRnVId2c4UzJuc0ZJZE5jWWNuZDJW?=
 =?utf-8?B?cHdzZEtHbHZEU1Vob2lYekd6MUJEdjRiWW9uZ1lrUEkwWkdiaVhkaFp3WnJr?=
 =?utf-8?B?aU9GOGRmQVBmcTBoK0IzdVNwT0ZJSERKcTlTTC82aHpKOFEwYXMvM3NMMjJF?=
 =?utf-8?B?a0h2bUVxZkNwb1pvSVFvTFdPUCtkRmhUOTRjVEd3Rjh5Q1FXTlZ0ME1zcHkx?=
 =?utf-8?B?SVJUc2luK2NDUXo4MkZaa2F3RlhlOVliYi9zS08zY2ZvSE1JQ3ZUeTFRa21V?=
 =?utf-8?B?SUNxUm5vektyUXJCZU1TcWM2M1RlMlNRdlpacm9nYTM2M3pXR0tWRTl1a0Fo?=
 =?utf-8?B?UnJ5S2E0dGV5V3VDQTVZaU02U3NmcEs5S3V6a21NcWI4dzJ5WEpReWloYlp3?=
 =?utf-8?B?ZUhSOWl0OEdKWG8xR0JCb3g3b0M4a1NZazdvOWMwR2s1NmFpdUlQV1A4OUIz?=
 =?utf-8?B?UFpINTJrcGU0UWQ1ZU52V1pvYTlacUU4SUc2alZqVVViYXZTSU13ZXdDOTV2?=
 =?utf-8?B?QkljM1RxOGxqem1DR3lzWEZaVkUyQjJOVDVkWHk0QVIwS2VQbzU4L3phdnpN?=
 =?utf-8?B?UGI3b0Fzam9RQkZjN3BpVWZsdmVLM01SNTNnd2FvN2J0V0ttU3B3ajRqRUV3?=
 =?utf-8?B?akpqZ2pzQU1oSVZrd1hEL2xTUUZERXhGdXFrUi9IdEhGQ3pIZlRaVHl6eTlT?=
 =?utf-8?B?bGE0MWdBcUg1RS9MQzAzbzNjd0liWDhzY3k2WWlXWkxEblh0THp6U294VFBy?=
 =?utf-8?B?QTF0VjRoV3F0ZWFWQ3ZKcmRoSHZYY1N4aVJpbVYzREl2bTl5cUlTbGc0TmZv?=
 =?utf-8?B?SFg1ZUk0R1VGQUQ4L1Y4eWhBWk9kLzhGRnJQMWFPTnMxOC9uanpsT3lYdEJr?=
 =?utf-8?B?cU8zaitXMEZsZUU4UGxMeC9EeHZuYXRmclF0MlpYTGgxa014WFIxcFVvejlL?=
 =?utf-8?B?ajE0TXZkb1FIa0lwVm43SUE4d0wxSTg2NlVVUnNaNDI5WTBRMEFpVy9kWi9n?=
 =?utf-8?B?UTdWVVdQQTFKOVQycTRTSVVRSnFaeHBtSXY0NEVUKzdVZmpnVG9wczI5bnox?=
 =?utf-8?B?THo4ek1zcDZmWDNobHQ2UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGQ3N2h2QlhZUTAvME1SVk1zTnhMRGdQU2lnWU95YmpucFdNbkd3NC9pOVNt?=
 =?utf-8?B?UGZTUW9DOTI4cElsUitXOXlDaVVTeXlmbWVkRFIrTXVvZ01Ta2hiM3JxS1k1?=
 =?utf-8?B?RFVqalBMQzczWDJEZ3dtUElBcjMvcTBJM0RINlhFR095cGw5N2NyU1llTEpw?=
 =?utf-8?B?NDNsV0l6alczSDUwRFBIcDNCNkQwRSs3SkpNQmczVkxEL2wzUXdvTkkzbHVj?=
 =?utf-8?B?YjhYZDhyaG9pRS92blI0c1NNL1BQY05VMWlxUG1zNXoxMWVRYlRLTTJCUjlY?=
 =?utf-8?B?QWVoN2NxRmhQTWdaWnRHQkgzNzluVkUwU2V2bDIzems4U0ZNR2ZoZE11K1hv?=
 =?utf-8?B?UU9ncVZGWVBEU3dEc08wSHFDa0FRaU5ibEhLcjZRRWpuRFRkczY0NlA2QVFT?=
 =?utf-8?B?R0xMekhtLzVXUyt1OUJJTlpoQnJjY0ZqY1huTk1xVzBwajFCQitjalQyQ203?=
 =?utf-8?B?TXZsYlRQWUllWGlvMDUxZXNaQXJ6VUhqRkNjUERKMHk5YWZwUkVwRHRPcFNG?=
 =?utf-8?B?ejBnaTJhbklHb1hPQmtTaXVjbWVDTmdtSVBtc3U2NmtOU2dXdzduUzlDdTdu?=
 =?utf-8?B?akZTUnI2NVZHUDNTUDZvb3l5aTRKd1VPdy9FbzBSZ0hMUzB1ODhKZmk1aW5o?=
 =?utf-8?B?anN6eUJWZG96OS9JWHdkNkttTnNUbS8zRTF0Z3U2cFV5bml6M1dyRHk4cnV3?=
 =?utf-8?B?d05oZ3pDRlQvMzhOY1lFczdsTk9HN3lyQXY3UzBBMVV5MkEyK1MyanhZSlFV?=
 =?utf-8?B?MEdUY3NNc2VZRnN6enJoQXBuNXJpTXJ6TzdJV1RHL0JLVzU1YmxJOFVTbCtX?=
 =?utf-8?B?NjV3ejh5WWx3eDJCQVhsSjJxTXduNEk5UWFzL1ZvKzJZNlprVmNSSnlVc2s2?=
 =?utf-8?B?RVltaHFudTNSSjlLbUNibXVOME00Vk1ZVVh2dmpwb0djRHZMZWlWcmtYcG1q?=
 =?utf-8?B?MFc5Y1d2QXhuQWlKV1d6MUNXOFlZbm5iRStmbkhEWlhIUDVjRVJIZEhvSFEy?=
 =?utf-8?B?NmJzRHgvNVVHOFpNR0FVYW1MS09LNTcwd0swTDE3UXRYOXQyMFNSS1h5djBK?=
 =?utf-8?B?aVR4OHBIakpHN0taK1IvTGY3elBSNnVIOXl5NUpSMFNjdjVTaDVDTW5TcUlB?=
 =?utf-8?B?RVRSVGJFQnYwaHlGdjN1bHdkcHdnVEQxWXR1ejZrM2dRRlVybkpzazdYa2RP?=
 =?utf-8?B?d2t4ZDFHQ2JKWGZESEVOR1NHaHEvaWNLZ2dnQkN3NkJUaVZxbjgwL0wxK1FX?=
 =?utf-8?B?Z0NQQk41SjAyckJGa1hGa3pDUk1vQXMwS0o0MmFkeXAxRjlQZkhGQ0M4K2du?=
 =?utf-8?B?N2FESFNlZ3gwRWpIdEFTMGhXMmRDc0JJajRJbTNsWnNXUUJYYlhsbDh1a1JD?=
 =?utf-8?B?T2l6aDNhUkYzTGJlbGk2bjRFL292UzgzR3htTmV1Z1RDYVlWazc2RGNMbXVC?=
 =?utf-8?B?bHNSTWxDNXZ3cmlJamlUVXNia0V6amFpUDgxNUFtVmYrWVRENUJyM0RRcmxj?=
 =?utf-8?B?a05QcHBrNzlLWk1WL0crR3V4L25WVzJ1anQzZGhpV1ZBYm5ab3Rwek9MYitZ?=
 =?utf-8?B?UTMveWI2T281YWhQaVNMYUVsbkV1SFBhUXA1NjY5RVduQmIxdERySndNM3g3?=
 =?utf-8?B?N3h6Z0ZPc0pnVFRyL2pUdjdJR0NGbEhPSDZKRVdiL2plTkZNZjgyOU8wbjY3?=
 =?utf-8?B?eGVoWURtU1RZK0hmbWY4ckh2SEs4SlpvWGdBVEhuSjlOakpjK0NuWnIzTTVN?=
 =?utf-8?B?WitMSjhzSk1VZzUwMHhKMHIwMTRYa0JmcWR4ckQzdmNheWRUQXphMGF4WFBs?=
 =?utf-8?B?aVpUMXZxeis3NFJYdkkrZmFDdjVZaHAvNERhRStldWozTUkxeGNFbk9LMU5G?=
 =?utf-8?B?UlRvYjREem54dVMvdmRCU2FaS1kzMVdSU1hzRmMvajYxRFAydFVyRDJnZkdn?=
 =?utf-8?B?RDVvUGt1aVpOK3R5VmVTWkpRZlNuS3JyS0ZEVkFiWGRlL09HRVN1WlRFZW4v?=
 =?utf-8?B?WXMzU1dWa0krNG9JbDMxLzN5Vm5Gd0E3OENnZXZWV1FhVEdrdmY3M010Yzkw?=
 =?utf-8?B?bEplaVR3V3NSVFNDZnpWeFJtYU1uV3RjcWUvcVJlalhKY2ttZjBldyszQlJR?=
 =?utf-8?Q?QKiuVoZ35guvmGiGKtNfbnKra?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CSFyQegw0m8GIHoxBMCtAOjoTpqoDPxhDCrqS0WdE9DPvJJAscjnOkdBSC50NhpFwzbXsXTc5pWtRKwl09s+iiNOaiO1PYQhNL6+/L1NAXxl4UKMX5Crj3FG+20CTkzc6RGk+2XjozzXyJpREOXAcX471vaaetXtpkD3Rpyvt3poJ9Ob5NnIKdGH8JLki7ncIJtIcQPVbAV4fyWPqtos98TyYkyVKFfIylgDSR75rCKHWoYXc/iP5KEdRpWhMZUDLVYziAU/qt/XFvMLQKGAAWLKak9GZcz2zX7ymVCJTRmfAtVNo4p4W+AtI0MKBDRqcw8qJN3ExV4QYi4MkEgklGvaabYoURL8qP67bSzpKcidWm7Mcv3TN55yPwwO0U4AG/TNzy0Mz86sxni1CZ72jpTho2NFomXW+cOd+ktEJi0PaLVz/YNBD78g8cTYbdeGRokppFSgcQhRr+ZD9i7OipAvsqh9Eg18ceqRA5EkP98Igx4XAQzVraUoBexy79oajdLn1iosj6xMiV8wHxAXf9zPaEHN9Uord5Qvm3rkQ75p+A6FEsdqW8qN99B7h/9u/VwLEvo/WHVRuh8cNZ3U9Y2rskxjU6ft3v2oTN1sR6E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3fc9fa-344c-4a10-8a87-08dd463d0d21
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 23:30:18.7590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBwhFp9iSLpDsu6aDjcrRgJgcBOSiN5GVLMYAzNjnO+VRzJPs6d7PrNoyh5CK4C8HDVdVY/COSLQav9p+JHyPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4438
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_08,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050179
X-Proofpoint-GUID: ibLYCGb9SJYlOHgial2Jc2mucRb4DyfG
X-Proofpoint-ORIG-GUID: ibLYCGb9SJYlOHgial2Jc2mucRb4DyfG



On 6/2/25 05:21, Dave Chinner wrote:
> On Wed, Feb 05, 2025 at 07:06:35PM +0800, Anand Jain wrote:
>> v2:
>> Mainly adds a generic function to check if a sysfs attribute reports
>> invalid input.
>>
>> v1:
>> https://lwn.net/ml/all/cover.1738161075.git.anand.jain@oracle.com/
>>
>> Anand Jain (5):
>>    fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
>>    fstests: filter: helper for sysfs error filtering
>>    fstests: common/rc: add sysfs argument verification helpers
>>    fstests: btrfs: testcase for sysfs policy syntax verification
>>    fstests: btrfs: testcase for sysfs chunk_size attribute validation
> 
> All looks ok, except for my comment about creating common/sysfs for
> all the sysfs stuff. The individual tests look much simpler and
> nicer, too.
> 

Yeah, the sysfs functions need a new file. I'll send the reorg cleanups.

Thx, Anand

> -Dave.


