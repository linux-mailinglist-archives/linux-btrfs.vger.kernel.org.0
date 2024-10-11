Return-Path: <linux-btrfs+bounces-8847-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189B0999C6C
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 08:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B4E1C222CD
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 06:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDF0207A29;
	Fri, 11 Oct 2024 06:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J1d0v8pe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BH/5zf/T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB082192D77
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 06:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728626680; cv=fail; b=Dh6DR0/oFwaVruhhlg5rxoKz3WYJUaNxyr44q9ICqaQi19GvH2NOj0dlq8j0Zm50lbuyqT6eFOh8x8kWJY2clM5AjJbF+YVjMfEsjeZgbu/tKyqT9J227FwI2h58JqOImkfy/EaSIlHTXtRTYJbyQLKX0xgJdPmqWwfEjak+CSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728626680; c=relaxed/simple;
	bh=AELUIvs+gOMSsX5+Zb6wfXQwxdkP+SpcimODUOe2ctM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hDizuKIwbioWfqKmdCwLLkcxQyFhq8FhZMqTj3JXogFo0XB6pJwmVStEa/xvgtlztUwey6BhANk4+RN9dgQtZ1AYekhX22N5I6PDlN8w6HLPCf/oL2zQy77vstG9emUfwTX55PMMUkL5pINKLKiIAaMA2Z0HKkW3gdhUdFmRNOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J1d0v8pe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BH/5zf/T; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49B5Mo3V008533;
	Fri, 11 Oct 2024 06:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wjNSh8uvegvDT58XLhq6Xkc+rdxkhc2X6VXPJIaB1W8=; b=
	J1d0v8peFXxv02q/REgNwrdHxwCpZvTw6oasYNwHop8uX36eSsXv5cQYSEesnuRT
	0wa91rx3o9pcssmnLw3+VnRAXC+rr7O6Wo0iYLdpCwBIQXbFA0Ps5NH1DtxYNn7T
	hf8rhmMWaUQ+84LmwhnfydPTcF5pnREapS/VzHTOxy3nDdFJp4crapLO1TbMM3PU
	ZBQepRxQKCavelElxmTFfFEShRM/hAnBrlteJ8hULsVjUMmZV2u8BhtlhWtcA2ZG
	FucOWuTwaFox0n0iwea1WJ+EfmggkIcno55OXJzm6n+uX07MHnWiVx4mfDjOG49y
	9PpIL+NE1bY/24uWPFNPhw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423063v789-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 06:04:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49B5u6xi027748;
	Fri, 11 Oct 2024 06:04:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwayh7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 06:04:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSoG3FwZC4I/0Bz4fWxzmWpr9mW9YCYQEaIwNeZxaWoPTthgubbWOD08+mXWrKyoorYpGrhRWjGtf6P2VWgeF/lHas6/IQzJtCYuQzZBFbWQ8mC4G+TkySUvUnUv9eUHQLo/aNHowTdUqeE9IS4w5k9T+GzZTsxFWEjz2JsiKJ5t2hoBCmXfgBuAyfbrLq1hrCDWQQAtmkngMZb20nKb/oPQ2C3yc5oSyliXXQNJn0Sy341oCivCgaL18vyK+ywRBGwdprH+9Ow06ZL9FlS2GmsOAn7xmJuvXZgewJG5k0z2mozM0yr7tz8/NGcC9i77eHAPf9JLDH/kasf/hyoBWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjNSh8uvegvDT58XLhq6Xkc+rdxkhc2X6VXPJIaB1W8=;
 b=gMOwbFnl7ERruEMbvgzJ3/yeB29iItaXlDD5JsdKZd/CQ2lH0EVHTByU1EisGZCmvR7+UFeBoKVGzfP7ztQWDjQGAguMK3krutk3I37lWu3aok453MFFRpsDqlcBW69yjUZkQuMkM3FvyzPulhVLUVib6Q1UBvP3pipdncfPql3nLhslXSMtPwg3J7znfPdE+AreB5otevBoKjLoEmEHp1YG8I7dGRPKyWEj6UAdykKX4kTwIdYC86NOmj7MPCJ59N6SoI4Jf4GHhbcDRyjfMp/qX1sTFP/w+kSefJ4CS2Oo0g1KPd+mGxHNlgI+w4Pklh+3OmU8hxdKs4exEQ7/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjNSh8uvegvDT58XLhq6Xkc+rdxkhc2X6VXPJIaB1W8=;
 b=BH/5zf/TvUqY2Ho/6eXAtwKiuHbvaSqB+TM8W7PgKCENAEWAB2/oRsTEO/5L5gVSTIA3bF/7zYAQTlhJGM7nYw+LE29eNgY2QhKFOoJZmj62x8fXGjzBEM605E2E1HXnc9AJoXXKJ+0tjJh7UN+1F6sufvlJkMPsjlh1+jl6MzQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV3PR10MB7722.namprd10.prod.outlook.com (2603:10b6:408:1bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 06:04:21 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 06:04:21 +0000
Message-ID: <0bb512ae-19cd-492c-a8f6-231104fa9408@oracle.com>
Date: Fri, 11 Oct 2024 14:04:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] raid1 balancing methods
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
References: <cover.1728608421.git.anand.jain@oracle.com>
 <92545054-d640-4b8f-8026-d3ecd04c1eee@gmx.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <92545054-d640-4b8f-8026-d3ecd04c1eee@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV3PR10MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: e7457751-148a-4b4d-5b55-08dce9ba8c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWVtQ3VQeDgrbWFtZ1RPdzIzVUEzNzV1UzQzUWFrekJLRnQ5NTlpRkRlMDQ2?=
 =?utf-8?B?ZFlMY0ovL2F5U3VsUGcrcm45NjhtMWd3QjJYT0FkUTRsOSs2dzczTjIrdTNQ?=
 =?utf-8?B?TDJHeUVQaDRmV2Z3aGlhdGd4am5ZL1VKTWdlYWk0WUMzdXl4RnlCQkZvZ2M0?=
 =?utf-8?B?Yit2MkN0dklZSmhaUlkxbnpURGZnV2dDeEIzcWhWZzlwdEQ4dWt2N0FCYy9x?=
 =?utf-8?B?T1N1WTZYUkJYblpEYnlqL1F0V1VlZVJVTWhVcWhXc2Jqa0RCdUdKdCtIU0VO?=
 =?utf-8?B?RmxIc1Zib2YyQ213U0IzUDRhVkllRFo2Ylc1N0dpMDBEbTJGemNCTzd1ckpm?=
 =?utf-8?B?d3ppYTc5WjdLUFpOUmY0M3ZrK3cyYk5kUG96V1Jibm1nOWV6NHNVWXBlekxZ?=
 =?utf-8?B?UldWazdOU0h0WjhiKzlQc3owcC9ic1dsUEI5ZFVTNFcrOG5pU3dLcFNMVjh3?=
 =?utf-8?B?QzNrc2szYTN1WEhWNi9lMVlOSU1pNFFCK050OVV3N3hvV3Zrc3R5dGZTQzNq?=
 =?utf-8?B?S1RTSXlxMGh2YTN5K3NzTWg0Yk9NTG8wbHVYWXdBV1FOeW55MWlrUkJ6cDYw?=
 =?utf-8?B?bHpxRldWVnJMQUZpdU4wMm9zWHFRbzhXMGx3K3JXS0Y4Um1od0xobkNJMUxW?=
 =?utf-8?B?aDVLY1RyaFpySEFmblQxT09ESjQ5L3RHR3VNcjRLNnJZVWozeHlzeGxSK3B2?=
 =?utf-8?B?dWlEZUJ1NW8rays0WHZvRkNmVS9Gc20zOHBaanhPQ2t2eStDM1hJbnVISTRq?=
 =?utf-8?B?d09rR0VvNmFMQWp4SktKYkZXejY4aDV5UUhPYnBqV1E3VDgxWGEyMHloOWYv?=
 =?utf-8?B?dk5iait2aXhSMVJ3UzQ3NHJXcS9IUGhPOVhiR0F5Tzd0L3ZwY2tDdWgvamlV?=
 =?utf-8?B?NmUzYk5CVGsydkRSaS9wQXFadkZnOEkvTUdYSGNiSlk2K1Y2N2dnQTcxNDhZ?=
 =?utf-8?B?dW5PTTNTMU1aTVErN3IwUFVoRlltS2dlQmpjZ2E0a3d2aWJST0NNN0FqSG5M?=
 =?utf-8?B?azVvYmRsajkzLzZPa1NNUnFsYnQzK0dDZThOZ0MvYUk3MGRtek5mKy9HVXBl?=
 =?utf-8?B?UGtLV3VBMTJEcnRVSFFieVZvV2d2WW9WYWJZZGpaR0lxdlBXbWNQZ09NTVFw?=
 =?utf-8?B?UzIvTU14RFdBeCtkVnViN1Y1bEVnOCt4c1RPNzVxM09rdktxdEdMRmViTUxX?=
 =?utf-8?B?aTY5L1paM3VIRXdVOWt3RUFYQ0l2QVI0Y2tKY0JtRlFHU0RkMlJoTWMzazRx?=
 =?utf-8?B?ZVE4Wk93ZWJ5V3RhTGpQRk5HVEQxNlZsMzFoa2dsVkIvak9jWllLbWVlbDYx?=
 =?utf-8?B?c1hUaHE4dFA2c1VkWWpWUCsvVmo4cVpjUWs3U1MxUmVoZ2M4NTk4MzRiQ1l1?=
 =?utf-8?B?dWNMNUZEakZ5V0RseUlCUUJmQ01rSEhodGdFOEptTnZZSXZaa0IyWjhvNjQx?=
 =?utf-8?B?N25iZ1hvb2ZPRlpxVzlVbUpncFE4VnlSN2l6UmV2cEhWeTdUSUwxQ3BNUzE5?=
 =?utf-8?B?cFV0TzNRUGJzSUpGeGVDOEI3blFGTzZhaVY3SzZaRHpHUEVOcy9XSUFSK25t?=
 =?utf-8?B?UGJMSFFiM2h3YUM1SmUwb3Jnc21iblc1cEk5L3c3a1M1TENpZHRlMUd5ck9S?=
 =?utf-8?B?TVlKOE5tOW1UWVNHcEJhTmdVZXJjbks3NUV5dzdnTlI5UXJQaFJpM2c5NTR0?=
 =?utf-8?B?bkFvcG5WZ1BlUWVHQ3YweCt0c0FrR3ZiQWtiZVdhR2xCcThnSXlZNmxnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDVLNHZIaGxMUnZ3TTNNeXlXWHI3cVlyMnRnbDJIUDJFbzFZeks5YmFIM0NP?=
 =?utf-8?B?VURwZktYa1FKVjdNYmh6d3NiSy83Y0FmNXdHZ29oY2dPbnNPbDJzVSt5RnFI?=
 =?utf-8?B?cXZqa3l0bjRpWXY2TGlJRWExUms1dCt3TC9Uc0lML0d0TnNPRmVFWndlYXE1?=
 =?utf-8?B?dE5IdWx4UlNrM1dKTjhtemtjTEkyT3FkVktlSklIZks4OWpTazdpL0hIdEhu?=
 =?utf-8?B?ZWdzd0JtbFV2bFBqMWZyZjZSMzl5Q1BXRTdUZ1lYVUd5aE80YlMySGZGOTRz?=
 =?utf-8?B?L2NjUm5lSjlWT2NuYmVCbUFRMXE5c2xqNzAxd29WSG9NQk13S3JRRGJ0RGdp?=
 =?utf-8?B?MVZVYmZhd2gyUUZKVWJtUHlEZmRublgxeS9BYjR0TEJ2T1E0SHhaNUc3eW1X?=
 =?utf-8?B?OFExTitweWxvYkswbzVDQWtqWlBBUEFpcERCUWNCb0d2dHJ5bGRKSEdjQVhv?=
 =?utf-8?B?TkZkNS9CaWVSbFh0dExWa3JNL0l1cm8wKzBhTE52M2xHcjZTUkZLSVhyZmJs?=
 =?utf-8?B?MWFBQk03QUdocnhYbk5lUm9TdzVITXhtUWlacFREVHRlOHorbjBaNC9XT3pI?=
 =?utf-8?B?ZjhNNERKTFlLR0lNUkZBa21OV0lrNEVESzloZ09lSUhWYlpQenV3UzBYelZi?=
 =?utf-8?B?WWEwcmxPdXhSMmdHbDA0cWZCN1lJWDRtZHMvbldJN3loREtUVjNvcFVYRWMy?=
 =?utf-8?B?aG1JV0NsNW9UOU1hbkJzQUFEd0tnNVg5NjVDc2ZLcUo0VWxIMmdnQjU4aW1s?=
 =?utf-8?B?WFd0OXg4T2tlOHd0MXdhMDhXeEVWTmRuT2VqVjU4dG9qWHBMbUlOYzhlRGVY?=
 =?utf-8?B?Zjd5Tmw3SVRxc0xKNWw3bGNRdytncW5iMHJYL1RPeWk5OXBlS2VZLzQxK2Fx?=
 =?utf-8?B?amloZXUvMDJVZTBWcDBsalZ5UzRuVWlYWmhKa25nbU5HTE5ZNmRaOXdIYnMv?=
 =?utf-8?B?ajJaYmdaMk1tK21uWjZuREI1MTE3TDBjaDlManlsWWh3dG5iSGEyS2NvZWYx?=
 =?utf-8?B?Z1AzQ3pxUEh3NTJsYm04eDZPN2NCWURnaUo0RjBrdGFiZFE5MjZERzNqYXJR?=
 =?utf-8?B?ZFRNZEtkN1BVTnUreUZ6cjZRTkRpUXJ4UjFRTTEyMmp5MHhSMCtVYnZFVDYx?=
 =?utf-8?B?ZVZFdzJwRnJFZnlZSGxrU0lyVDhBOUMyZCt2aTVibDBCeHQ1V2NWV0FMWXdM?=
 =?utf-8?B?ZVVneXJPOTFja2tjNEdERnNSckxlczZlMDh5T1VDRFRqTlkrM0kyMzdLY0dl?=
 =?utf-8?B?ejZwUHJCOFlkZzZrT0lmdHFlaWpCZGpuYnZSNWdYYXplVytUSTVhZllNdGpC?=
 =?utf-8?B?NTl3RUViZjBucDFiNXRHSXRyUWhTSHFKYi8zajJhZFE1K3B5L1Z4b1RIampx?=
 =?utf-8?B?Vk5aTGRTdlR1bGFORk5xaTkxM3l2SG5YRzBIQ0RmVFVkME1ITmxMNDllSTFh?=
 =?utf-8?B?UWdWRFpDaGtwSGE5cUNiSTlCc0lyZnNiSkN0TmV6dm5QMTM0cmFFWXIxKzQv?=
 =?utf-8?B?cjdDb1hhVzFpdXIzbkxYR0FRaThlaVZyYmx0aGR3RjBjaDlCSzYrU2lDVHpS?=
 =?utf-8?B?R1orTWdxMFBsVzZXRm4rRGVReW9yVXNxQnliSFdPVCt0WGJwMTIvNGczK2NG?=
 =?utf-8?B?a2p0STlUMVpqL3RhQmVCWFgzdDRveG84MkdIQnVWQlU3UXRtWm9JWlN1alZz?=
 =?utf-8?B?MWR6QlUwb21FRVhzeHN5VEYrZmxoZ2hJQlZ0U2Flb0RtZmZleGZxM2hEV3dq?=
 =?utf-8?B?KzZ5VGZYa0pqMUt1TXRjL3BxK2FYK3hnMENEQmZ6dWVXYk5IbmNyWVNwbDla?=
 =?utf-8?B?NGdkUFZWSFViNVIxTU5HSERQK2pOVUowVmc2eUliRXhwK09tK2VVUU9ZUE1Z?=
 =?utf-8?B?SXJjenNKVlFrdGJMVUw5SEFSbXVsWGpkZFp4YlNJRHN6S1JvaE5qbTRwWDBX?=
 =?utf-8?B?LzNwQmd1aWxidHVDUVZONjBNZUprNDZkdCs2RnVqNzNhMjJVUTMrdkVGQW9o?=
 =?utf-8?B?RjJ5OEkwM3RocWxsMHl1OGZpU29XVVNibnlUOXMrQmR2YXNZUTZCZkFGY3ZT?=
 =?utf-8?B?bXgrQmxSTGkyeE9MbXFzc0ZHRE5HNENKVVdBQ0RZWGNXdzRoVTBXMWFWREJK?=
 =?utf-8?B?cTVZS0VmL29LTzM0a1NZMjBQb3JaQ2YrTzkwOEpXazI1VlNKY0ZOcGd1cy9y?=
 =?utf-8?Q?0lHPSJoYV/Ozr/R1FUDfG7E=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Dj2aOfeuJcg5DsJdudYWKeOc+aMQLYyO9KUngtxQ/X0/QyKkUo3uuqL2XcB5tkXg7ujN9Fhhqg1RhETYJe6olq/uijQ3/4yH/UU5z2upPn1d5ahzc1v3mC8+qxB8LVVC9XJyni7l0bzie32umeOS2zHsdEFzZ/8G/Y1b/4HAHHn8TGcqLa0tHIE/LblDmOsRXRvMP4OYDj5mFSiIi7uAd5zPO9b7A55F/w+x7I7QOmSXpt1IMR+0BD2YCczwI+SIdMmdsQGxOgeHF6cjs3BSl5h/QABwU0EZWNKBAaNziiwVBvJzkgexnzWksAf6CWZL6cHeJsSyMczvj+8mXHAwMcyV2p6fjnMZAqIZwiS1sbOzZNcsSnkyIhZOCpRaTHV8RI/YwUWH0UBz+Nv2lRiyW5CgUHVkr2/AhI7ZPljULJHNNZ5DM2WZrgyaYR1lbWEwVnFprBFv/V7qFEEawsCrl4rHsbc78oGw8ZZRforBu0RQbGT6os38wicJ/GUx/NeP055S9rI/m4B+4V+NEoTjN/mC1sVOHeh4UuRoDQkhub3nkA+pWMaYomY7XlPPHCQQIUJoMTzRDHmcpzcst6/IjTMqFfMMKKCGfv+PvUfVB6o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7457751-148a-4b4d-5b55-08dce9ba8c93
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 06:04:21.4018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGcc9sNil3+APNjbK/yONcBWyckaTrNptV/B9/V9oGhotHaOG4IfBthFQXgUQoX7W9oZelIYbFgN5/PTQ1hzMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7722
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_02,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110038
X-Proofpoint-ORIG-GUID: jRpPxIU9BWKKDca282uPg8UqdtkXe4xN
X-Proofpoint-GUID: jRpPxIU9BWKKDca282uPg8UqdtkXe4xN



On 11/10/24 10:29 am, Qu Wenruo wrote:
> 
> 
> 在 2024/10/11 13:19, Anand Jain 写道:
>> v2:
>> 1. Move new features to CONFIG_BTRFS_EXPERIMENTAL instead of 
>> CONFIG_BTRFS_DEBUG.
>> 2. Correct the typo from %est_wait to %best_wait.
>> 3. Initialize %best_wait to U64_MAX and remove the check for 0.
>> 4. Implement rotation with a minimum contiguous read threshold before
>>     switching to the next stripe. Configure this, using:
>>
>>          echo rotation:[min_contiguous_read] > /sys/fs/btrfs/<uuid>/ 
>> read_policy
>>
>>     The default value is the sector size, and the min_contiguous_read
>>     value must be a multiple of the sector size.
> 
> Overall, I'm fine with the latency and preferred device policies.
> 
> Meanwhile I'd prefer the previous version of round-robin, without the
> min_contiguous_read.
> 
> That looks a little overkilled, and I think we should keep the policy as
> simple as possible for now.
> 
> Mind to share why the min_contiguous_read is introduced in this update?
> 

The reason for adding min_contiguous_read:
The block layer optimizes with bio merging to improve HDD performance. 
David mentioned on Slack that 192k to 256k co-reads can
performance better, though I haven't seen this in my setup but it
may work in others.

> In the future, we should go the same method as sched_ext, by pushing the
> complex policies to eBPF programs.

External scripts for RAID1 balancing are achievable with BPF, though
it require writable BPF, which is disabled in some cases. That said,
still we should prioritize adding support and provide choice to the
use-case to decide.

> Another future improvement is the interface, I'm fine with the sysfs
> knob for an experimental feature.

Yes, we need to review tunables - mount options, sysfs, and
btrfs properties to have a clear guidelines/consolidation.

> But from my last drop_subtree_threshold experience, sysfs is not going
> to be a user-friendly interface. It really relies on some user space
> daemon to set.
> 

Agreed. However, for Btrfs, sysfs has been the most comprehensive so far.

> I'd prefer something more persistent, like some XATTR but inside root
> tree, and go with prop interfaces.
> But that can all be done in the future.
>

Absolutely. I included that in earlier experiments, but it was removed
due to review comments. Now isn't the right time to reintroduce it; we
can update the on-disk formats and xattrs once the in-memory graduates
address specific use cases.

Thanks, Anand

> Thanks,
> Qu
>>
>> 5. Tested FIO random read/write and defrag compression workloads with
>>     min_contiguous_read set to sector size, 192k, and 256k.
>>
>>     RAID1 balancing method rotation is better for multi-process workloads
>>     such as fio and also single-process workload such as defragmentation.
>>
>>       $ fio --filename=/btrfs/foo --size=5Gi --direct=1 --rw=randrw -- 
>> bs=4k \
>>          --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 \
>>          --time_based --group_reporting --name=iops-test-job --eta- 
>> newline=1
>>
>>
>> |         |            |            | Read I/O count  |
>> |         | Read       | Write      | devid1 | devid2 |
>> |---------|------------|------------|--------|--------|
>> | pid     | 20.3MiB/s  | 20.5MiB/s  | 313895 | 313895 |
>> | rotation|            |            |        |        |
>> |     4096| 20.4MiB/s  | 20.5MiB/s  | 313895 | 313895 |
>> |   196608| 20.2MiB/s  | 20.2MiB/s  | 310152 | 310175 |
>> |   262144| 20.3MiB/s  | 20.4MiB/s  | 312180 | 312191 |
>> |  latency| 18.4MiB/s  | 18.4MiB/s  | 272980 | 291683 |
>> | devid:1 | 14.8MiB/s  | 14.9MiB/s  | 456376 | 0      |
>>
>>     rotation RAID1 balancing technique performs more than 2x better for
>>     single-process defrag.
>>
>>        $ time -p btrfs filesystem defrag -r -f -c /btrfs
>>
>>
>> |         | Time  | Read I/O Count  |
>> |         | Real  | devid1 | devid2 |
>> |---------|-------|--------|--------|
>> | pid     | 18.00s| 3800   | 0      |
>> | rotation|       |        |        |
>> |     4096|  8.95s| 1900   | 1901   |
>> |   196608|  8.50s| 1881   | 1919   |
>> |   262144|  8.80s| 1881   | 1919   |
>> | latency | 17.18s| 3800   | 0      |
>> | devid:2 | 17.48s| 0      | 3800   |
>>
>> Rotation keeps all devices active, and for now, the Rotation RAID1
>> balancing method is preferable as default. More workload testing is
>> needed while the code is EXPERIMENTAL.
>> While Latency is better during the failing/unstable block layer 
>> transport.
>> As of now these two techniques, are needed to be further independently
>> tested with different worloads, and in the long term we should be merge
>> these technique to a unified heuristic.
>>
>> Rotation keeps all devices active, and for now, the Rotation RAID1
>> balancing method should be the default. More workload testing is needed
>> while the code is EXPERIMENTAL.
>>
>> Latency is smarter with unstable block layer transport.
>>
>> Both techniques need independent testing across workloads, with the 
>> goal of
>> eventually merging them into a unified approach? for the long term.
>>
>> Devid is a hands-on approach, provides manual or user-space script 
>> control.
>>
>> These RAID1 balancing methods are tunable via the sysfs knob.
>> The mount -o option and btrfs properties are under consideration.
>>
>> Thx.
>>
>> --------- original v1 ------------
>>
>> The RAID1-balancing methods helps distribute read I/O across devices, and
>> this patch introduces three balancing methods: rotation, latency, and
>> devid. These methods are enabled under the `CONFIG_BTRFS_DEBUG` config
>> option and are on top of the previously added
>> `/sys/fs/btrfs/<UUID>/read_policy` interface to configure the desired
>> RAID1 read balancing method.
>>
>> I've tested these patches using fio and filesystem defragmentation
>> workloads on a two-device RAID1 setup (with both data and metadata
>> mirrored across identical devices). I tracked device read counts by
>> extracting stats from `/sys/devices/<..>/stat` for each device. Below is
>> a summary of the results, with each result the average of three
>> iterations.
>>
>> A typical generic random rw workload:
>>
>> $ fio --filename=/btrfs/foo --size=10Gi --direct=1 --rw=randrw --bs=4k \
>>    --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 -- 
>> time_based \
>>    --group_reporting --name=iops-test-job --eta-newline=1
>>
>> |         |            |            | Read I/O count  |
>> |         | Read       | Write      | devid1 | devid2 |
>> |---------|------------|------------|--------|--------|
>> | pid     | 29.4MiB/s  | 29.5MiB/s  | 456548 | 447975 |
>> | rotation| 29.3MiB/s  | 29.3MiB/s  | 450105 | 450055 |
>> | latency | 21.9MiB/s  | 21.9MiB/s  | 672387 | 0      |
>> | devid:1 | 22.0MiB/s  | 22.0MiB/s  | 674788 | 0      |
>>
>> Defragmentation with compression workload:
>>
>> $ xfs_io -f -d -c 'pwrite -S 0xab 0 1G' /btrfs/foo
>> $ sync
>> $ echo 3 > /proc/sys/vm/drop_caches
>> $ btrfs filesystem defrag -f -c /btrfs/foo
>>
>> |         | Time  | Read I/O Count  |
>> |         | Real  | devid1 | devid2 |
>> |---------|-------|--------|--------|
>> | pid     | 21.61s| 3810   | 0      |
>> | rotation| 11.55s| 1905   | 1905   |
>> | latency | 20.99s| 0      | 3810   |
>> | devid:2 | 21.41s| 0      | 3810   |
>>
>> . The PID-based balancing method works well for the generic random rw fio
>>    workload.
>> . The rotation method is ideal when you want to keep both devices active,
>>    and it boosts performance in sequential defragmentation scenarios.
>> . The latency-based method work well when we have mixed device types or
>>    when one device experiences intermittent I/O failures the latency
>>    increases and it automatically picks the other device for further Read
>>    IOs.
>> . The devid method is a more hands-on approach, useful for diagnosing and
>>    testing RAID1 mirror synchronizations.
>>
>> Anand Jain (3):
>>    btrfs: introduce RAID1 round-robin read balancing
>>    btrfs: use the path with the lowest latency for RAID1 reads
>>    btrfs: add RAID1 preferred read device
>>
>>   fs/btrfs/disk-io.c |   4 ++
>>   fs/btrfs/sysfs.c   | 116 +++++++++++++++++++++++++++++++++++++++------
>>   fs/btrfs/volumes.c | 109 ++++++++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/volumes.h |  16 +++++++
>>   4 files changed, 230 insertions(+), 15 deletions(-)
>>
> 


