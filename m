Return-Path: <linux-btrfs+bounces-10617-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F44D9F8447
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 20:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4013B7A18A8
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 19:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07321B423B;
	Thu, 19 Dec 2024 19:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ElCGSTzy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TQsXSdBX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9571A9B5C;
	Thu, 19 Dec 2024 19:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734636639; cv=fail; b=H9ZM8H2SP7oauxSWB1yQQ0n1d83Aa5J5vuL9Zj2dDnfS0ZBdJ4pZjjDfnSpxDHuyiVkStM8UpJyOzLCxw/Hf2eKj4E6b3Y2TXqA2uHqDA+N6beN+WNpDgBAzTEGjhSPRTVWFM2gYPoLWS2n8dlvhFTg8LVjk1Vuk8/yJmowIpSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734636639; c=relaxed/simple;
	bh=nCBkkasKv3MZHu80BMcg9s3SQbvUV/HGVXy58f/tzyE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qdSFWWfoiKIDbLJJr/LC+hR88sO4K0B8MnECZqHm4G1JA53cvyhVkou2JhWx5buYF/dy5Z/1ZqtqkmIEAckyGPjACIf/0Xh9Mo1k6X6K9UbeIvmF6E0r0KWh5cwcmKNnpCetVC7vYuQ8c76UOm2vVkK1dimry1S3Ago6/8szuI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ElCGSTzy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TQsXSdBX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJIMiLW031417;
	Thu, 19 Dec 2024 19:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BnmcYyhaqaut/v9tzxs6VWgX+a/Z0mFuPyuD7aFP1/s=; b=
	ElCGSTzy34S/5FGsRJ2O0srnViSytWInWbMy6fu4f51OgRJaM49BFOuOCHvxgrLU
	JUHljGZaoDOw1gG/5rY2uORRWTKfC1bbLpaCGuSwwf8g6ompWJdkZswRg6SFBd0b
	1unVE28UNjhTpU4BjoKNyNSoPAS8Wz0/YfRfyVibihJLJ0hraywBMCDk2G9S46FS
	/Wmlh0up9qPacQz2Y9T1kknx9G/V00d3T/OlSSAWmrKALugzlQ9EKmcg7SAc/p5O
	shzq4zkkghY6m/BLKFD55BzoRbyjNTggeUzsoDb+bS5TfZwAe9ycxeURizPI9XzH
	+76vuBI+Wiapkz5BV7RwHQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43jaj5hj1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 19:30:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJHnjd2011058;
	Thu, 19 Dec 2024 19:30:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fbey91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 19:30:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poXnOJ6vkmW4jx/oRacBOTqRmAcA3GAEyUPvrG+HZFrb1WK2FtGi726HQyya3fAUJmXtqxDjYAEaFZTP8aj5rpg7fua+f7fkrqZLKYDOp+8rRynaM1B1wsYcQcmAT5czOnYNJXFnel39kCMYnZlPgP4fAbkY6f+0LtazgnC00Y92orHEnbHtaXU/ztoWasPlydfOWJZ0qKkHt0RDA9RW81RIJPZTwP+2KTXls2DV8kk5lFXotaq+iyFgfUqHn+zoRmBg8FFLECNLgt6vpMGqD/3Am3QW79IvW3ppSOuLQuH0nHy8KjrWxBZqgLvUgi2COnunWYHQBKtQm2AcQJkKdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnmcYyhaqaut/v9tzxs6VWgX+a/Z0mFuPyuD7aFP1/s=;
 b=XavpXF43JTvaXshL5srHXVQbSOJKZChfmhHWH8wW9zPGsqeG0VpRDs2as9fuhlHdiD6X8mboCau1aBJEqP+qxlya3d+TTIAlD33u0zZHQtdxRrabN9Y7b+k9RRhhXtcaiFq0V18LWgIw+OpIxZKAfakXQwzGeN3u7V3Si/tIk16sSWci9GIrUr9HRA9C/PKRG8WX4nmQGmhcSN6csqI3a5gaDLDY68dA7fQjLnPDgl3TiuCu1VWXDOV53+Yg2uTTk27y82ObvoYgCrV/u0L8JnbDKsIWUEz19eLfCveDy47CENZiMgg+j1QW4jkJjr3grY3ZiGbXTX2dpY657hd1oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnmcYyhaqaut/v9tzxs6VWgX+a/Z0mFuPyuD7aFP1/s=;
 b=TQsXSdBXWR6SkiXi0qutxez27YRNEBSZR+Em9VFL9R/aoszd13ZVfq7QcIkYhdnuUmZXuaQqL5Ri+fBXdpHaLGnzfKcXwOhssfiVYCnVEFgJoOnoFOofG5RZlFZz0OkN6USe1PfCjQrgq2ajcaMbUHxBYa9JuuQxtxwgkG214SY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN6PR10MB7468.namprd10.prod.outlook.com (2603:10b6:208:47b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 19:30:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 19:30:28 +0000
Message-ID: <e271e5e3-8101-416a-b2a6-5f52bef6dc75@oracle.com>
Date: Fri, 20 Dec 2024 01:00:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs: add btrfs_read_policy_to_enum helper and refactor read,
 policy store
To: "Colin King (gmail)" <colin.i.king@gmail.com>,
        David Sterba <dsterba@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cd8135e4-2de5-48d7-a7de-65afb201b3fe@gmail.com>
 <38a661e3-f8be-4511-8be0-d16c589a540d@oracle.com>
 <6b17563a-dd94-4ca8-8ab4-3b3aa86e4d36@gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <6b17563a-dd94-4ca8-8ab4-3b3aa86e4d36@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN6PR10MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 5630ea60-28f1-4f26-4da7-08dd206397fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0RJTmFsaFNoU1NaOEVwZ3Z3bzZrWm1ud1BQbURqOUpEOG1tb24xK0JZRVpG?=
 =?utf-8?B?ZXlLbVoxNUZaUTc0ODB4QXpreUdYWFBUc2lEWGV5ekx0ZUZXMjNkQUxqaFVD?=
 =?utf-8?B?UXg5NGppSS9MclQrL0ZmWmJ0akVQTUpZMUdGZ0ptRDB4KytRaXE3dUoxYm9S?=
 =?utf-8?B?S2ZpWTJldVluS3RjV3RJS2JhQk80Y2o2TDlmYmVBWHBhbHpSekcrSDdubW1l?=
 =?utf-8?B?YThhMy96OU5JSXlWVHVYaERKV0NIb2RvZFlWQVg0UHU5QlVlY0h6SUx3aUk3?=
 =?utf-8?B?akhSRXpCNzN4R3hyQ0dmaUZwZlFrRFhCSG5KVTlhcUYxMmxxdCtmYXkwM3lu?=
 =?utf-8?B?bzViQXEwMVJlRi9xZ0lFKzlLbXEwbEFmem5USmZ2SjdTRlkzaGVhdExJT0kz?=
 =?utf-8?B?bk9nWG53bnhVNVFjZmNDc1VPY25ZaTN2UWd0ZGdrSzlSZk1CUUl2c0x6cTZo?=
 =?utf-8?B?R2tRN0xmbytnRnJrWTBrb3IrSlkrUE1Dbkc0Q3JNQXFIdkxiVW5Ib2NGcVBF?=
 =?utf-8?B?SEZudmViNTRYdDd5NHUrOEpNTHYrM3FIaGgvK3dQc3lycVV0QlVFMjFkaGFU?=
 =?utf-8?B?c2E3YnNNa0ptZGVEOVdPZDJucUR0cjlUV3NOVXlMTUNrcTFreTRiUHhPZ0Uy?=
 =?utf-8?B?OEtrcWkzK2pwd3NZSHNZRFhXWWJxQkJqZllBdjQrVWxYS1FnNnJKOVBVSEV3?=
 =?utf-8?B?cUtqdmh2a3JsS3k2Qit2SEdMM3NyaFZBUEgwN2JSb0xSd1FrVjV4cmEzRVZn?=
 =?utf-8?B?UnNtRWlzTEg1NHMyQ2pSaEEvS2Qyalh1NHBicnVUZjVSQTZ4cjF2TDljVXd1?=
 =?utf-8?B?UE91R3NCelNpZUozTGlmYXFxL0wwUW44NjJobVh1RzBLTzJnQjM0ekpQZVFV?=
 =?utf-8?B?d1o3UVIyd1lnNWxxWXRQQmJ4ZDdkR1dmWlpLYitrMUt1LzVBcXloWmJHZ25N?=
 =?utf-8?B?L3hWaHJiYXF6c1cxV2tRRHpWQWs4VDloSXZCbExjRTRoSW40L2JYNTFrSnVD?=
 =?utf-8?B?QXhrcnZ6U2VTRlZYcnlOaWhqT05tcDRjaXFTZ3pyaGlGL0tSTXc5alQyVzJY?=
 =?utf-8?B?ZWV4K2x0YVVtL3pGQjZjRGlJTTY5c2RoZ285M2RqSEg2dkVYUmkxMEJSWnZ0?=
 =?utf-8?B?eEdSaWx0M3pyaC9SNTZRR3hsOTdQRmYwcW5qWmtsUHRrS0wwRXlubzg4OU44?=
 =?utf-8?B?a081d0FiTU84U1pDV3hSQVJlcU1mUlNzL05EVFVPakU0bnc4S1hMSm8xVGUy?=
 =?utf-8?B?QkRUNU0rcnFrd29kRGhDZTNyU25aUFVTc202QU92NTFVOTBZazhPWlJEWitU?=
 =?utf-8?B?cmRWeWJBN0VrakVpOFBBLzNWUlJrUThENnlyY003MGNlMXN3MWUvWmRiaFlO?=
 =?utf-8?B?TlpZZGF0bi9OM0lXbUdWWHFVcEJaZjR2NnJudmltaDNheFV5emFlNk9WT0Vo?=
 =?utf-8?B?bGx4emJzdEhoMzgyclgrQXd5d2IxR1gva0dZYVo5WlowT1MvYk8zZHpOWFEz?=
 =?utf-8?B?YXJXRm5veDVUM0wrVHdML1o1RDBVVDU4MTV5ZVFvWWRHbWkxRUtlK1pFc1JP?=
 =?utf-8?B?ZC9FbHk1Q1VicWRkWnY1RmQ2eGhQZHBTRnN6ZnpTaXFwdjFrek5tN2NnSENG?=
 =?utf-8?B?VmJCaWF2c0NQS2duM2lqeitKUFZzd0JBdjM3SzlrMy9tSFZhdzVyejUxSm9V?=
 =?utf-8?B?dGlNQ0hCci9xTUdBMndEdFFnUFVmRE9yS2RvcWdQTE9MY1BaZ1g1ZWdjaWhm?=
 =?utf-8?B?cFFhY212bzh0T2pFZUJ4MHJ4cHB0Y2d1aHJ6MERkZGVmMjBrd1VoOStNUEgw?=
 =?utf-8?B?WXRPdHNJdzZFdlM2eWRBdElZQUpsSmNWaXpIWkQ2SEdlaDJxRXNpTlhuNndJ?=
 =?utf-8?Q?Cl+FGvqTKcHB3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjZBNlZEL0VhUWpUU3NMK2taeGd6ay9CVDQvdlptd0REeFdnVlRIVU1neTRX?=
 =?utf-8?B?RFZUQWJTa2U1N1NVdnBlMktvZW15Sk9iWWdwU1dwWEgzQXJyM1RlN1F1bEtY?=
 =?utf-8?B?KzA2aUVncUdQdjZDcFY1VUs1bDg5cUo0TVB5RFd6bHl0RHRPYTVEbm5pOG04?=
 =?utf-8?B?YkllWndRZFZPRHBBS3BXb0dadUNXK1B1UGx2RExKUU5QdFJPOUVNMUExWUVz?=
 =?utf-8?B?TjlhVTJVSStJOG9xUFhtNUE2MHNzdFIyVG91VjN5UzJMT2VGV3FVWlZTK1FV?=
 =?utf-8?B?cXczanFlOWk4Q3pZTE5WOWZvOXVoNTY5MWNIYXU3QUY2Ukh3enFyL1pweHBF?=
 =?utf-8?B?UjVMTGFJSzd2TEpSdlhiQWQxRmhyUDJJcG1LSFU0bTMxaG55MEdaRnQxNEtB?=
 =?utf-8?B?NGcxM3praVdZbXhuU2paRTZYTk5EaHduSlpxdWtYekM3cDluUXhUSTUwVmFO?=
 =?utf-8?B?eWVxMXJEeTF5eWtwTmE0ZDNzVnNTY2VyQXlKeHZ1ajlJRXFqWC90cWl1Y3JM?=
 =?utf-8?B?cWNzdnhZTjhHaHBpSW5haXpROWlrSzFXMm5XYUNYOFJsNmdKUWRMcFpWcUZv?=
 =?utf-8?B?WDRscXpjODN1aENDdVRwQVUrQ1dYNUp4bG1DbE5oa0VDbTJDT3NqZVY5QVEr?=
 =?utf-8?B?bW4wWm8wTnZkRyt3N1hnWSswUTFIMm42OUhCUUJ0d1E3cXRqczFmNGNHZWRj?=
 =?utf-8?B?aWduZnRMSVdCRFh0dE45Q2hTQ2tRMEdCOFhzeVpucWZGcWRoNVAyb2d2MVJQ?=
 =?utf-8?B?THVnQ0RBUGgyeDJRODBLL0YxT0paZFRwaTFnUEQ2Z1pqVE95dG1sUUN2cjR3?=
 =?utf-8?B?bzJWN3g2dUJtNURxYXczWjNTNmRNZUNRaFozSFF2a2Y2SWZYVHMrVExnalJt?=
 =?utf-8?B?dUYxZ041WDZ5bElOdDJDeW5Tdk1zM1dvSE1YeGdudVpjZjlMa2hmeGVZL0k2?=
 =?utf-8?B?TWVOMkkwSnlvUG1aZGhSNDdLQzMxL20rMTU5aUJkZlZiamdrTkw2Zjl0VlpR?=
 =?utf-8?B?Zm1rRnNHODBHTy9JZjlHS3RSNncrSVZxaHVyK3BsaTR3ckQzS3FnUHVyZGd2?=
 =?utf-8?B?YmtDbDV6YnNNYVlBMzdscTBqQStPUk54YThXUFBISHR2OE5KWEhnQ0Vzalpj?=
 =?utf-8?B?ZGdZb2JBcTk4bHpVUHN2QjdjM0JQT1VTQ01relU5VVNRQ0hBV29aWGcybHk1?=
 =?utf-8?B?V0dHMFI0UlJKc2xnaHRjem5PWWZDUVpDNXpMTE5Gb1pWVDFRSVVrYVFxakhi?=
 =?utf-8?B?Y1RicnYxaXB3MEpQRm1CZHFEWFVjTit5U3ZlUkpybEt5Y1V5bkxnM3ZNaTRV?=
 =?utf-8?B?dkw5OER2WDRoVGR5OE5GUGhXTXRkWC9IQWdiRk1ZdHlqV0g4a2RjNVNwYkxp?=
 =?utf-8?B?Z1JiVEExZzBEWFh2eFlXMGFuRkw0aWljVUlZditNcVlyRU5majI4aGZPOWZa?=
 =?utf-8?B?VnpsY0pFVmVueGNXeGI2VGpPMzFNQ04xaFkvR1hMeEJpc2hjRkxNMUk4YlNo?=
 =?utf-8?B?ZGFCb0V3NkdWN3VpWmJab2JWTjhHZmVaOVk4RStOYlhkemczRkVBbUxaYzE0?=
 =?utf-8?B?T05QeUllRnRxanowNVppYldidFpHa3ZsU0c4Z0tJY2tlVnV2TTVXM2M1S1Fh?=
 =?utf-8?B?cC84b2c4TDEzemFVNE9qYnM0OGR4RzYzU2xVbzNWMFVEVk81UDZPRVF6bmQ5?=
 =?utf-8?B?dUNFdmVHQms4YjdmYnJ5a0JPQk1wVzVhWTJ6TnlTMEJkdWlTOS90T2svZ3RR?=
 =?utf-8?B?RzNxUlBXOER6WWZhZEh1d3N1cytCQlZrdm1LMnZNREV6eGczcWhuME1RQnlV?=
 =?utf-8?B?T2Y1R01KMzA1MHVQdWxBZFlMK1U4SjlFOHJPQ0lHaWF1Z2NXL3ExQmlteG9w?=
 =?utf-8?B?WUNjOTNDTXh1eE1YeXJmK2dveURTN1hJVUcyckVUamFGWC82VTJrTFlwZTZE?=
 =?utf-8?B?cGJUcDVLSlNJOUYzM3ZPL3V4TVlrNUVCMDAyMFFUbUpENG05YWlpOFR1eXVh?=
 =?utf-8?B?S2J1OUozR1lKTXMxRTQ4RHk0cGtHaVR3eTdlWmJuWDZteWRhbjdHeFV5N1RE?=
 =?utf-8?B?bzFDR1hMTVR6ZEt1b0hMT1BwdFRPK01BczZ5TldOZjFWS3E5L2M4QTZmMnIw?=
 =?utf-8?B?YmtkSU9DcllzUzFlS3RmTVVRREM0Vmw0Zk93YkQrd1d2bm5LWVd1elZhdDNW?=
 =?utf-8?Q?i3wnXj54l32ua8dVqE9WLXy93YHOjnLufN49r9jgbyh3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ytFoJViHz0Sw+0AOJ2SWxc2Lf6DdVFFgBBAA3c7utJLvsM7SLt3wdcEXXPritoar9+sY52dD9JMFpxdq9CX8+ktDx1uZzTmXPnUAuXFaVtT8MTwyT1naTM0vrpYjaKCGCl/zfWOJUVb15up7OTx9fxeuiapr2wo5pKxHBawFTLNh3gTzHCG0Ot8iilLJt2pD3sateOO3eFWdJrJ0AX9X9TOuYqRFND9GvsV7s05+9NeT1zk0B/9DqMub0I/6u8dTMGIuWs3nTsUwHXvyPBEWsbQhwIePKzazemuucjZeq5MAi08vlqdr957V4w/nSmuxJyw9Tnahp64pr+R2qj/cRJXJTeuOdtwLgwwly+n4vrIKhoBBdn53G+Sx5iF5vaW9h4pXFThdH4qGsNU/lsbdN73vt2Z4wD3sJgB1EdXswT9W+0EY09ICzZ0jh98/3NnQGQHkX1Qd4hWGi8ZT/Mg3YseG8mLWUp/LweHSNr2zJCYTdUdg3fzzQhzQZWWZhEPEABqkqtTqK5u+/qiwMagRrxHRnJcJKSALaUUqEMZ1H1OcIRfyJQUD6ex4V9bUj+cOchwgnVWO47IH9WI2lbsHVbZYZfYmI/mYv/LNvE9P58g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5630ea60-28f1-4f26-4da7-08dd206397fb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 19:30:28.3934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7B/yjU/AQfHcMsSfxsDM3fcBqP07pDXn9DMnNSMfaTpr47dL3Lfvrvw5iDUczkUErQ9nG6XI0qEwdkouWHBbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7468
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-19_09,2024-12-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412190155
X-Proofpoint-GUID: NCwPuWVU0Gqu6x5yGChTQ0Ut44hfjxeX
X-Proofpoint-ORIG-GUID: NCwPuWVU0Gqu6x5yGChTQ0Ut44hfjxeX



On 20/12/24 00:38, Colin King (gmail) wrote:
> On 19/12/2024 18:59, Anand Jain wrote:
>>
>> Hi,
>>
>>   The changes have already been submitted and will be included in the 
>> next re-roll.
> 
> Thanks for the update.
> 
> I noticed the fix was:
> 
> strncpy(param, str, 31);
> 
> perhaps that should be based on the sizeof param, e.g. sizeof(param) - 1 
> rather than a hard-coded 31 just in case the size of param is changed in 
> the future.
> 

  Good point, I should have used sizeof(param) - 1.

Thx, Anand

> Colin
> 
>>
>>   https://patchwork.kernel.org/project/linux-btrfs/ 
>> patch/9fcc9f01bdab846db231b427f98fbb3e9df7c7a5.1734370092.git.anand.jain@oracle.com/#26168805
>>
>>
>> Thanks,
>> Anand
>>
>> On 19/12/24 21:10, Colin King (gmail) wrote:
>>> Hi,
>>>
>>> Static analysis on linux-next today has found a potential buffer 
>>> overflow in fs/btrfs/sysfs.c in function btrfs_read_policy_to_enum()
>>>
>>> The strcpy to string param has no length checks on str and hence if 
>>> str is longer than param a buffer overflow on the stack occurs. This 
>>> can potentially occur when a user writes a long string to the btrfs 
>>> sysfs file read_policy via btrfs_read_policy_store()
>>>
>>> int btrfs_read_policy_to_enum(const char *str, s64 *value)
>>> {
>>>          char param[32] = {'\0'};
>>>          char *__maybe_unused value_str;
>>>          int index;
>>>          bool found = false;
>>>
>>>          if (!str || strlen(str) == 0)
>>>                  return 0;
>>>
>>>          strcpy(param, str);   /* issue here */
>>>
>>>      ....
>>> }
>>>
>>> Colin
>>
> 


