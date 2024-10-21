Return-Path: <linux-btrfs+bounces-9028-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0C89A6E50
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 17:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C66FB2138A
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 15:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40481C3F2C;
	Mon, 21 Oct 2024 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PX36Dnlx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JRV+qNmS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9224A1C32E5
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524991; cv=fail; b=u5S2CnMIAHOTrYY5JiE6Td1h/Sp9kPthyoiOFhAFpr8/C+Eq0tKTqvWRnLtQ+ziBDI1RAdIn0lSBCGaohJhunlGNAY5t9Fn1YQV5rGQz7fNLlG2Y6OZqlYD1QIj4FNIgN8FqHZ4+19jmAzFgujwiRGpePtBKAbjntiXIqBjeBww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524991; c=relaxed/simple;
	bh=WuC3hOHRS/6dX+PbZE9f52crNU7ADzGMTG/GngCC9DU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X6oW0k4mNf9CO+ShjJA0u/WjL6DjBqJ6kddFx5/ID4gAv8sXFZt4imQz9sYbwxFm+QyqtWCHPV7qD+zgNqNkVsTtCOhl/+WQ59LIb6BQTSlD8ssYyfuFyGxr2eYPKd/tC4byFOBjybGAE0AMaUpZ7c2w1iZAjTapfed0ljgQ1eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PX36Dnlx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JRV+qNmS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LEtlTm020016;
	Mon, 21 Oct 2024 15:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gH5kJaz2acUNrc1vj5r8iKP4WnUgIky6YhCFmsZubts=; b=
	PX36DnlxLubZhtf6+0SNVvW9NY3zC96jpLh/8+1FrTczHLu4vcpQBbsnohBcBjsj
	fGkkSnfShV8rD4zYrZU7uvI9sumCsMeY+WY/q7mDQoCxd+i/D49V7EIDy52yJ6xV
	1YSA8Ll1ZLrP/MbWlP9AlOdYaYfQeoIzHRbvZzmbkciFiSlC6GVU4cwBbcEotZ31
	lTQtz6KwaL79Ee8GdtKiW7GP+yEO/O2QLKJ9Mv4Q+k1zszDVzAYZhXpBxFqwVoRx
	X29LI1/S3ti3GLYzW16EIl9Qt/xkDS5q/qV6bCT/BXZGgoex2mX+Kog6upcm2AvH
	2U8lVK1GIMZSz10i0BhuXg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3ak1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 15:36:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LE51qZ012015;
	Mon, 21 Oct 2024 15:36:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c3768t9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 15:36:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOFnR/G0L9LK9btqexx/Jd0Q8SLWEI12Axj3atkX9Dc4lmZhKqyJzTi80NEwHvSf5KSFHbPnHJoy2YS0lCYj/Tru14iP/MGIPZ06L1UG06xJ3Me1o/0E2yCL8sQPA5ErKwD9UIyK7lTtc+24G/wmtABy9n3/JI+Bil1vl/TNwz+JOsyYZMRjBobC4UqrrRXH1hJewjOtQvXwke1Xui5KHhVEMwG/MVAyAUjiBXyAPZ+6LCSUfpjTxaAjjWr2Aou1E9neNSb9r2j6S3XVxR/26r7JixTdjUt612QVYKt9anfIhDEw0L55fgWRTAhxCzDR/aOOjpMV9X07aDMvuYm1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gH5kJaz2acUNrc1vj5r8iKP4WnUgIky6YhCFmsZubts=;
 b=T8BszZCoZVJYhGJ4YZZ2/OG/6sctr79Z5U9t2NkdORv9ey6YGfE4hJJ7JTNf3HfNikgKBKKjFY5WyQINzfrr90EjNYAEyiXkMm45dzCx2JpwmycH2qVnrdNeh1Z+HnZvKoSdwujleGoAbhUIn5aqRwg30GG9qjwffyWn9KB6j2lHj1bK39AVYEuOlxwunLaz6v5SlSSqj8Agiwkyhp4dsR4LV5RQPoYYdwuagElkWR+6PUViuVE46pm6I3lSdWDnRyAONVPLEzVHlH70DHfUay3cfnyeYfTW8SV/HT3kBsL3p3aH2c0ioNZ+Em/fJM0mbtBOrJ5vZ7VZXW+CrCAsqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH5kJaz2acUNrc1vj5r8iKP4WnUgIky6YhCFmsZubts=;
 b=JRV+qNmSTCgzpZrGBh3TtZYBLlMp0qDvBXdjw2dPab2Ad587OnOkIUAey1rizfEfkE/qCP4lZNeDuPJPG20jKzPuVz/RHDior2rbja3Bo/TnKNARuzq3WQgzXkSWslzFP05Mlu1V90lGfdIE990eKzm+FPGqm5mncK7dV+H1CrU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5859.namprd10.prod.outlook.com (2603:10b6:a03:3ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 15:36:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 15:36:15 +0000
Message-ID: <788e9d8f-df2e-4d54-b60c-dddbc47fd701@oracle.com>
Date: Mon, 21 Oct 2024 23:36:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] raid1 balancing methods
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, wqu@suse.com, hrx@bupt.moe,
        waxhead@dirtcellar.net
References: <cover.1728608421.git.anand.jain@oracle.com>
 <20241021140518.GD17835@twin.jikos.cz>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20241021140518.GD17835@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: bca2c0a2-84d8-4d20-76d0-08dcf1e6191a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1VMbFdzbWRRMTNKVTk4ZHZxUFY1eDFnNXNKVXIrc1JvV1lxelhyTnQ0ZC9j?=
 =?utf-8?B?eXNQd2dmdUxMdjVONEJsV1F1bkpWMEFkOFJ5WE1BVUk0TXZvbGJqZ3FMcVpN?=
 =?utf-8?B?K1N5M2ZrVHdmYndwbGQvY3IyTXVrZzVXTUdFSEkvdXgraGE4S2NjRWtsT1Na?=
 =?utf-8?B?eWZyblVRN1hDYUNnMHEyeFhVSER2cTFqSkVBSGxhUk9ldXlpSk04UUlNalF5?=
 =?utf-8?B?Mm5ORGFWTHZWbGlYUGFVcFU3blNzc3hBZktPSCtWM2xIMHJjb2pVSkpBcDJM?=
 =?utf-8?B?L2pnSkFKWno2OGFEWURzMW5xc0J4cUNkOExkQk10ejJsMXFzVkdtaVlhbkZn?=
 =?utf-8?B?NnlQbnF2ZFFDMURxY25uRUZ2TEJWUlBnM1Q5MGF2R0ZWNWlPeTFzb2lSYm5T?=
 =?utf-8?B?b1d4eHRpWjZkYlhZQ3BtQ3hvSG5EZ3BJSVg3c0tBN3FGU0R4OFFyWUQwbE0w?=
 =?utf-8?B?aGdoRVF4VWc5YXQrcG56eEJ5aHA3MTdMczVuWUhNRVJub3BidzJuZFhzQXJP?=
 =?utf-8?B?U3AzZlNub1pWdlVmeFFXZ0VYTUI2NWtmQmEvZWRGTnpoR0hlQzJrM0hpYWxL?=
 =?utf-8?B?Q3I4c01BejRpamxZQU5Uc1lvS3h2b0VRUVlHSXV0WW1QQlBmSEw2T3lnaDhs?=
 =?utf-8?B?K1ZnT1pxOWJudDdTNU9HK1Rjd1d3MWNWcTI5NmV3c0gzd3MySm1EcWxKam1i?=
 =?utf-8?B?djB1SG5yR3NuSHd6NEdpYjFBaENhZHZUek82dUhLRHdIUVRmQnkvWWdlZ1lV?=
 =?utf-8?B?a3BkRm82UlBBRFlTc0UrQ0ZLSGhIQ2VLRUk0OC9IaDE4WTlwQXFvWDVXaDFF?=
 =?utf-8?B?R3VkTnkyeHRSRDg1WTlXZEltV1NIZUs1WWhoZUs5bFRCTlN3MGNOMFdKa2ow?=
 =?utf-8?B?UWlkRnBtZHlTTjFIUldtL0ZHSVFWWSswQXJaaXdLM0lLR29mQlpSOU10eTIv?=
 =?utf-8?B?L0orYlV1b0NSOTR1S2g2OVZNTUpYbUU0akJBYWh0MWpITWFtNFl6NXhxMXor?=
 =?utf-8?B?akRIRDFnUXo4MXd2bERPdzZoVmtaTjZCdk9aaDkxMkJEVmFqY3VSSkhXYXpL?=
 =?utf-8?B?TndsS2FFb2wzYlZFK0plT0dDS0ZWWVlLZzdFRFluSWE5eFRDOUMxTC9NQTMw?=
 =?utf-8?B?ekt5OVM4ZFYrTExVaUl6Y2YxWEtGdFhkeGtHMHQvdG1iYmtnWEhUZlJNdUxo?=
 =?utf-8?B?R0lDTFNZWG94TzNNVGN4cFY3MXdjRnFBK2lvdXExQmpiZ1VxeDZGU0VZZEUx?=
 =?utf-8?B?SUloTEY5Sm9JK1VXZDVLYTB4NnhEbjIrckxSRXJZcFVTY2pkMUZYTVM3Z3pF?=
 =?utf-8?B?ajQ1Ykcrb0Z0RE9mTFUwWDlEYjFxRjh6YmRUUHFXOGQ3OEY5ek1ERStNclov?=
 =?utf-8?B?ZGZDTWZEcmFFQWZMY2ZRV21wS2d3eWMyanp1cHBJaTZ3VFh0cG9ZeGpTbjBa?=
 =?utf-8?B?ZzY5UGxEMlU5WEkvSU1BZVREazJEZ1lCeTRKRWtsbEhEVG0wWGNzbnhRSDRl?=
 =?utf-8?B?eTlBMXlMUTdWR2RsbzBpNUlSQXB3UGdnWThiUGo5MVk0UW9wanJzUU56VGp0?=
 =?utf-8?B?bCs3cnJURlZJeXdmT3UxOXRMRVlnSVNrU05ZcHhzS1lSdVJQMk45djcyMzNP?=
 =?utf-8?B?VENPZmYyeSsxWXBIdU04cUFhMEhJRjBaeHY5SUhWbzNoOVNiZEgyZXRvUENt?=
 =?utf-8?B?MU44Vk5jTUh5M0xwVTUwaEpSQVdyZGdmZFlHMFJwVDJ3WU5OUkdPZmtROS9M?=
 =?utf-8?Q?+u3pzCb33ft3RyLbX8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHdqdU0vZGlRMGFyN3hpTnREbmdPYkcwcGNweXA5QlJ3WGdXZ2hpYk00cEZu?=
 =?utf-8?B?UUtkSmNqb0tydkJyVVJrTGpJaENtMnBYa0VtRWNhNHRLNW9kaVZpbXJlL056?=
 =?utf-8?B?N2YvaWI2VHp0RjFNdHZna1pWY00xMEN1L1B4cDJ6S3pJNi9nMno2S0tOdHRo?=
 =?utf-8?B?bVJPOG9vV3Z5aTVTUzRBOWRMTktSQXVQOHh1Y0E0SzM1a3poYzFZS2pCcUlI?=
 =?utf-8?B?RVZxUlZ5SVp1d3ZXWmVCVE96cUp1ZDRBYUpUZGMwRlE5YnNXY1NtZDRmNGJP?=
 =?utf-8?B?cThieHpJQnBBdFUyZGxPRlAzSk9zVmVhOXo1dEhQN2JhamdkL2k0SmhxcThO?=
 =?utf-8?B?cnZlMlMyVWJNZ1pEdlpRQ1BObGVrRklJQUJsVTUwQWZESE84ajdqSlVhdHR4?=
 =?utf-8?B?dnZLMUx1Q1h5MFYrZHA2YnNoSG1tRStycXN2bFRwK2RCM0NTNm55Ujg4ZVNn?=
 =?utf-8?B?Mk1nQzVXa1gzbFZrbG1NYmUrckV1K2VSZTg0K0J5dU9QejJRTW1idnJlRFk0?=
 =?utf-8?B?V3JnbHk2LzN6N0ZFRVY4dmxoM1NpZGFOd3ZkaXB4Sjg1VGdEelNrejhtZU5v?=
 =?utf-8?B?SXRxQndUN1lMNU9iWWF2TXdKRXRiL2tmbzZmNzJWRWVucGF4WHkwWG5jdVRT?=
 =?utf-8?B?ZUM2dGlLMlYxZnpkd2JkRDZidjA2c0FjdXNDUndpZWplLzJRbXVjbE9zVmpB?=
 =?utf-8?B?Mkp6Wkhydk1zZEJ6R1F0UFlIbStCVHVtRlhhRVZoQ1hzVXdvT25wVGxsNG5G?=
 =?utf-8?B?S3RqN1dITTRTQUFWaWlibmg1K09lcC96clZhZjJSYmpvdjArUWpiNG1NOVMy?=
 =?utf-8?B?OURiaXYxZHZnUzF6eDIvOU1CTlppMnF5OFRodTR3R2ZyU2p4S3JaYmQ2MkVq?=
 =?utf-8?B?YUxZemc0YmcvZSsxMTNSTVpaMUJJNkxSSGpBTGJacVk0MTZrK3owaWVIVXpJ?=
 =?utf-8?B?S1ViNCtvSWgzRk43YXlScW5jU09ES0lPQ3lSbGVXNHdtMUJSdUhNMUdBbmdI?=
 =?utf-8?B?YWp5dUZ3dTJ5VGJvaTFxTEpid0p6SGRxUGxEdndvUlVKRFJleVA4RGhZYnJU?=
 =?utf-8?B?OXJTTnlXNjRZY0xKc1FROWxiY09GUzc4U1R4UlVEcUxTK2J4ZUZMOUtCd1Rm?=
 =?utf-8?B?dk1JSWQySHlud3A1UlpRNE5vcUdKNE9NUDZ2OWdPeGc4SW13L09XaXp5Vys1?=
 =?utf-8?B?UEovckJKbk5YL0x2b2F6WVVVWFBjdTVEZWxITkdQQUhqa1htTExNUzBWK0Vs?=
 =?utf-8?B?NThiMEFtRitqNFJ0N3R0NXFzejJBU2JCZEtPUmkzN2piYm45Nm5hSThwR1kx?=
 =?utf-8?B?K3Y5UGNObkJlTXRJcmEvekorUUdCS1FhdDEyS0NLYTRVcmFVdU9XSzdJYlNu?=
 =?utf-8?B?N2Nxb0p5bDhUZVlORk04M2EybzAwMFFKczRXeHAyM0U5N1lBaUpFR2VoMjJw?=
 =?utf-8?B?b1RRZHA4N0NTMWhmNmowL0dMWEp2M3ovSUhsRC9ZQzZLN3JzT2JNbDByYUZK?=
 =?utf-8?B?WE9zQXNBVEJOaTVsMWtKZXJLa0pqOHhkRUNSV3g0QjNLMld3SzJ2aUN0WkJL?=
 =?utf-8?B?L1o1d012OWhIWVJkYlJ3bHNMYVZ0d2NhQzZBQnFMY29ySGtOTHA0clhLVGRV?=
 =?utf-8?B?WE1wN2JQa2VHUmR5eTNGVXhXZWwzbExuUWtJaE5RWWxIYi9jQTdFVVlwUkNx?=
 =?utf-8?B?cGI2MHV6VncxRXhnakVabW5XQjEvbW5iYnJtbHZyWXg0by9qZzI0ODEycmt4?=
 =?utf-8?B?TUFrellhTXV5cXRoZ21MNzlkMzZpZ0k3MFZMSEdqdzYwZ01HMFppcis1OUpB?=
 =?utf-8?B?bldqZGowcXdCNkNSSlovb25ueVkxYlAzSUxkQ3RIVmRUcjN0L3JrUHFMbE9U?=
 =?utf-8?B?OERBTzh6RVlMN3Q2dDZFQzdwSlJjaDduc2VzbitzMVBqUTJEWlRjWFArRzd6?=
 =?utf-8?B?QVc2dEpaT3NiSkMrTkUrREJuR1NGaElrYUQxRHk4dHVSNUVjVXk0V2pGcEh2?=
 =?utf-8?B?alZ4REZPdkZaVGpsYlBkaVBRNUQ3eHQ2WG5nQ3VCNisyZVhPeHFhdjh0ZTdk?=
 =?utf-8?B?VkdsRkxzcXZjK3hma2dpWXpjOVl4c2NhNlBsODJ1OEhUOEFYRERmcnloS2R1?=
 =?utf-8?Q?9C88325JL6ITVbCSpiJJwgC/H?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dyV41A2wZQoFs9eAZe3OuZLEAAmHeY13/q++QoD1YSKv70akahJt1sFJba5Ny0CL4QGtje6+xVuFrEVYJ+nB9h5FKc0/YxGu/hLpGhEL86nnTv3C+tS22dZMyeEJj+VjdQQAyYNZzd6W4BXMbbnogEGYdCae1NvMufsz+hMsRLqdZvsnqoG077RAIv8kprmRgSiTJkqE8KN/0GR9rH7pHCSEbSCaLMCHriOyshtddqruLJi/U6PA0UsVictBSG5nxdmqVSb88JNu4BEb9pYC/hFGg/vV/3rBcDz9S09GlkP45bEvp03q0ArmOQ87phshbBOloHp68zxECJc52lFPEMxvvdwrGVeHOLU/CK6oELLPxNwyN/vwUXO5u/T3e/d1S+K+xiAnQqDExQX54dVe+XPJM6Uah9IOoXIVbAAXcS920b9SqDaLsUXgxEIJGROVFgyQRrSnuzTSVSAWYzDsL1Nj0dpy12O8QcIY2ICUnWFaPtx0QvjzGoEQUv659AvFsIWNhsIkg4A0621Id9VlA1UiDmJqRDzJnAYv0eNKtEhrkqTz+npkM28GCpblPGoAg+Y55TmOzu6Jq0Vcfeya43RZtgf2O5Ae9bfGMYzleG4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca2c0a2-84d8-4d20-76d0-08dcf1e6191a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 15:36:14.9230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igcCOqMw9TLPgEuCXCv/AIqZMmMuY1EWFVugLtX/no23Glni3Z9xO49E7WNHPrEjtsP01q9IwiI827+ph8RErw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5859
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_12,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410210111
X-Proofpoint-ORIG-GUID: Kc5zXUaYtUOVX1c-VNDbbkbfa1RrX0y_
X-Proofpoint-GUID: Kc5zXUaYtUOVX1c-VNDbbkbfa1RrX0y_


Thanks for commenting.

On 21/10/24 22:05, David Sterba wrote:
> On Fri, Oct 11, 2024 at 10:49:15AM +0800, Anand Jain wrote:
>> v2:
>> 1. Move new features to CONFIG_BTRFS_EXPERIMENTAL instead of CONFIG_BTRFS_DEBUG.
>> 2. Correct the typo from %est_wait to %best_wait.
>> 3. Initialize %best_wait to U64_MAX and remove the check for 0.
>> 4. Implement rotation with a minimum contiguous read threshold before
>>     switching to the next stripe. Configure this, using:
>>
>>          echo rotation:[min_contiguous_read] > /sys/fs/btrfs/<uuid>/read_policy
>>
>>     The default value is the sector size, and the min_contiguous_read
>>     value must be a multiple of the sector size.
> 
> I think it's safe to start with the round-round robin policy, but the
> syntax is strange, why the [ ] are mandatory? Also please call it
> round-robin, or 'rr' for short.
> 

I'm fine with round-robin. The [ ] part is not mandatory; if the
min_contiguous_read value is not specified, it will default to a
predefined value.

> The default of sector size is IMHO a wrong value, switching devices so
> often will drop the performance just because of the io request overhead.

>  From what I rememer values around 200k were reasonable, so either 192k
> or 256k should be the default. We may also drop the configurable value
> at all and provide a few hard coded sizes like rr-256k, rr-512k, rr-1m,
> if not only to drop parsing of user strings.

I'm okay with a default value of 256k. For the experimental feature,
we can keep it configurable, allowing the opportunity to experiment
with other values as well

> 
>> 5. Tested FIO random read/write and defrag compression workloads with
>>     min_contiguous_read set to sector size, 192k, and 256k.
>>
>>     RAID1 balancing method rotation is better for multi-process workloads
>>     such as fio and also single-process workload such as defragmentation.
>>
>>       $ fio --filename=/btrfs/foo --size=5Gi --direct=1 --rw=randrw --bs=4k \
>>          --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 \
>>          --time_based --group_reporting --name=iops-test-job --eta-newline=1
>>
>>
>> |         |            |            | Read I/O count  |
>> |         | Read       | Write      | devid1 | devid2 |
>> |---------|------------|------------|--------|--------|
>> | pid     | 20.3MiB/s  | 20.5MiB/s  | 313895 | 313895 |
>> | rotation|            |            |        |        |
>> |     4096| 20.4MiB/s  | 20.5MiB/s  | 313895 | 313895 |
>> |   196608| 20.2MiB/s  | 20.2MiB/s  | 310152 | 310175 |
>> |   262144| 20.3MiB/s  | 20.4MiB/s  | 312180 | 312191 |
>> |  latency| 18.4MiB/s  | 18.4MiB/s  | 272980 | 291683 |
>> | devid:1 | 14.8MiB/s  | 14.9MiB/s  | 456376 | 0      |
>>
>>     rotation RAID1 balancing technique performs more than 2x better for
>>     single-process defrag.
>>
>>        $ time -p btrfs filesystem defrag -r -f -c /btrfs
>>
>>
>> |         | Time  | Read I/O Count  |
>> |         | Real  | devid1 | devid2 |
>> |---------|-------|--------|--------|
>> | pid     | 18.00s| 3800   | 0      |
>> | rotation|       |        |        |
>> |     4096|  8.95s| 1900   | 1901   |
>> |   196608|  8.50s| 1881   | 1919   |
>> |   262144|  8.80s| 1881   | 1919   |
>> | latency | 17.18s| 3800   | 0      |
>> | devid:2 | 17.48s| 0      | 3800   |
>>
>> Rotation keeps all devices active, and for now, the Rotation RAID1
>> balancing method is preferable as default. More workload testing is
>> needed while the code is EXPERIMENTAL.
> 
> Yeah round-robin will be a good defalt, we only need to verify the chunk
> size and then do the switch in the next release.
> 

Yes..

>> While Latency is better during the failing/unstable block layer transport.
>> As of now these two techniques, are needed to be further independently
>> tested with different worloads, and in the long term we should be merge
>> these technique to a unified heuristic.
> 
> This sounds like he latency is good for a specific case and maybe a
> fallback if the device becomes faulty, but once the layer below becomes
> unstable we may need to skip reading from the device. This is also a
> different mode of operation than balancing reads.
> 

If the latency on the faulty path is so high that it shouldn't pick that
path at all, so it works. However, the round-robin balancing is unaware
of dynamic faults on the device path. IMO, a round-robin method that is
latency aware (with ~20% variance) would be better.

>> Rotation keeps all devices active, and for now, the Rotation RAID1
>> balancing method should be the default. More workload testing is needed
>> while the code is EXPERIMENTAL.
>>
>> Latency is smarter with unstable block layer transport.
>>
>> Both techniques need independent testing across workloads, with the goal of
>> eventually merging them into a unified approach? for the long term.
>>
>> Devid is a hands-on approach, provides manual or user-space script control.
>>
>> These RAID1 balancing methods are tunable via the sysfs knob.
>> The mount -o option and btrfs properties are under consideration.
> 
> To move forward with the feature I think the round robin and preferred
> device id can be merged. I'm not sure about the latency but if it's
> under experimental we can take it as is and tune later.

I hope the experimental feature also means we can change the name of the
balancing method at any time. Once we have tested a fair combination of
block device types, we'll definitely need a method that can
automatically tune based on the device type, which will require adding
or dropping balancing methods accordingly.

> I'll check my notes from the last time Michal attempted to implement the
> policies if we haven't missed something.

Thanks, Anand


