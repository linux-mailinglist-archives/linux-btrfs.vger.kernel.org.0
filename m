Return-Path: <linux-btrfs+bounces-9220-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AB49B58D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 01:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5EA0B2264E
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 00:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8D8208A9;
	Wed, 30 Oct 2024 00:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TxgeSUcD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kSmzK/Mx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5470D4C70
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 00:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730249308; cv=fail; b=fuQxt/TsL+qrnR1xq6/pgYW5E3G6yyAbjjJf6Wcevy7xbyPhStISb+3wnS10MHHechZc1xhDo9KoMwu/JUmWMgi0D4ipM2u6j4LBhT60kcTHc39OApD1BAZH88dDreqEVuRW73Sa//V+d8FPSJdH+UwicvKBUmB+PWFbu12L1wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730249308; c=relaxed/simple;
	bh=td6qL0QS5ocZcQM4mXtIeb0fGmWMwJf6FkZZwN0JCQc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TpmUSIwtXgxi4dQrgASGoCmUHSJy4QJW16A4OUf7+LcqY+8mmnrvo9DTbeHXZfPTyzpuZPGaKcTObU90pIbt5pdiA1tlknrInKK4vMGVujKnl63SiKVWU/eZn4ZoZyix+sfWVyiSdxRk/4JsjNEZaodL1LzLlL/LjbKCTDbHjkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TxgeSUcD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kSmzK/Mx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TGfUgd030889;
	Wed, 30 Oct 2024 00:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=atQLrDuoz8Cd6+C/77URPRD29K7rp6NY985sJzfIxic=; b=
	TxgeSUcDpf4AYZmm+30BFFB3lbMZTj4XRSO5fGC4IwJF6wW0xzUn5iBF6UaisKs5
	Hl12Yt3d4NKv+S3MsIS+N4JdQgbiAE5zipzTZDhbKFW/Nrjgxj0c/YB8/zKxhtnh
	0xyhPVDtSOW4hwNkkYpekFXRvroGzs2x5nXFm6XHASH+NI4bTx3sK1WuHNA3YRUZ
	IdE3K+HJKUUcg7+921e/qjz+i1PBR9NnIgHEPTk7nuhYD/kPy2ncF58/Ser0VuKi
	iWmDA3RJohamCifbQTHudZ9pzZ3Lk/oNaMBBJWbEKR/nRENp6oYgdygjlUlAamUQ
	kd4JGYUQ0n7PiBDOZru/kQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdp6vb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 00:48:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TN0Dbm040331;
	Wed, 30 Oct 2024 00:48:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hnapwgpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 00:48:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4Ra4CPkjkn1KVxDzxdmBcoj4CLdYmxzXl7XRHuSsbalNM60HGa8t2QFVfKnz2ihAS5PADi9UgxAlHEo5ag5TfakIGtLL2t3kT83GE9lNN+Wp7ZLm8YzoBihwFEteQvWbkH39yk3xAajdvlg64lQK8fiROyV0ZNvBzB+xlvy/cLFNzAIbAWR4ngf/mq5jY72L4h8zjermRmc+6o2ThrxmfknSHew2XrHFVOGzILjhAdh2Yyq2RL5GTX83PU9k9puFFPtJ1ZpxuGk145WKoEf0rLvYR3X+MR0L/pztDHUFNmR8Rm+TyBG8SE41aXfwcp1uXy8c6rNmrJvMKBqoJl9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atQLrDuoz8Cd6+C/77URPRD29K7rp6NY985sJzfIxic=;
 b=F+fqdVf36YTcA8QNFhawmYt2AkgjUPmskR7BOpNBxeyRiVpW7VXaSxoxM3OL9YataI4NdnIRFc8ennGo/eQBTEjfc9hjn96HjiQ9VuoXs457q4c10cPCKR7caicKkjCR+3SbyDZubXnUfrBTjGho6oHu1bbiRzMYDKoxQ9+trZWhXNkMJyZO1L/BIRfS20xoAMOPzrDOIYgBpY89F+d4m/Gx5Ovrzr0yrTqNvP0lceROgrC+yzFtnovSYI4mQXj3WjOm4+Kvwue2Ma73m7xgXGEemxmqKBgAKrpd0KetM6Fqagk7rdqgXTy+VpGFLkHipqg7fMjK9Dn5/rFOZFWK4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atQLrDuoz8Cd6+C/77URPRD29K7rp6NY985sJzfIxic=;
 b=kSmzK/MxDb5jYcW/gWyiTMr2k9rtzm1tLdsMsNdMyP55pIqLAaeVWtc+syOQVmEmFcFtBq2IhpaZ7VnUG7P0K3xIaiUN2G8/ooWzqFCNvf1SxoqqjvG4ULhVyksD3w9zcFvFJeLEOJKn1+XHbcahHZTBB4Xz6W9aoUe7v9EQ/ic=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4480.namprd10.prod.outlook.com (2603:10b6:a03:2d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 00:48:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 00:48:01 +0000
Message-ID: <385283b3-0bd9-4937-8a7e-3393fa40069f@oracle.com>
Date: Wed, 30 Oct 2024 08:47:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: fix extent map merging not happening for
 adjacent extents
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1730220532.git.fdmanana@suse.com>
 <9243b672972756682e44c7e69a696c9cc08181ff.1730220532.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9243b672972756682e44c7e69a696c9cc08181ff.1730220532.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: 21900200-cee6-40a9-ecbb-08dcf87c8197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzVBWVk2K0NpZXczZlcwZkw2TUtGY0VEWk5RT3k1V09mS2dSbUN0MU1FdXNn?=
 =?utf-8?B?eFRrRFF2Ny9oVzJ6WDB2MXNuYXNCTzRjdGM1NndKUk9SWm0rckRrWmJRZk9s?=
 =?utf-8?B?QmZsY045K0JLa3hVbVRWemxPcmZDd3F5M0R5MlRyMEM0ZXVXaklUL1dINWor?=
 =?utf-8?B?cFgyeGFWUkJ2b3VUMUMySnVvV3lFQnNzaU56dlhra3VZamRQTzFZWkZnRE8r?=
 =?utf-8?B?MGE1Q20zT2h3M21nUjhCSHRiTU9tdlNka0g1YWc4Y3RNdldFc0dveFFuN29o?=
 =?utf-8?B?QjZTaXRBdThvY0Fhc1ZDblNoK1MveS91QjZ3NE50QWxvWDN4Wmc0UnhjaVd4?=
 =?utf-8?B?WWdnaVJoWnRGRFc2UDRsdGZtSkNlMWZqSHVWbm9CM25mM2Z1dGNYMWc2Z2V1?=
 =?utf-8?B?cnlzejVmQXJGQ0FMZkgvR2lOSEtrL1d2SzFFSm1OTnR0MWFvdWdDWmNsOWRk?=
 =?utf-8?B?Y0EzMVRJM0pYUGRDS1kzVXZUMm5TUGpvZVVFL1dkTFpqdEIrT1kxNFI2a1ZS?=
 =?utf-8?B?OE16WkkvVWdqN25JWm5EYlFmZ1VpTStHcnR6RlNQSk01N29uRkN2RjdRbUpz?=
 =?utf-8?B?MUF0VHZmaFNNUVhRdTBNZ0huT1NiR3Y4eU5jQXI2WEZRQ1cxbVVJSGJKdkRx?=
 =?utf-8?B?dkU5anFMWEd2Wi9XNWhIcSthelNtcG5BVVNGQlUrK1BYNlplTUlib2dzd2M5?=
 =?utf-8?B?NC9hN3NMR3hXYk1KcU0wTkhVeDZWSTAxYmM3Uy9UdUpjeC9DYUphSUdsVGIz?=
 =?utf-8?B?Y0lzZUl2VngvNEl0TVduY2hEekI1eEFBUE5YVncxY2FqV2x4QzEzZW1rcGVU?=
 =?utf-8?B?MXBMY1o4MzkyTndGY21JczJNLzdXYU9XMTc2V2ZTeXN3a3d2Rnphak4xWThC?=
 =?utf-8?B?TlFwMUg1SFFpVGhRNE92NzJuakFzRFNpSmRYaUp2QmpHN2VaZEIvOUYrWHFG?=
 =?utf-8?B?WTJMUFFJZmlPVDFEbUlaL0JWNzZTRmMyaXg1Tmk1K3N3VW1OVVNjUFUyNEVr?=
 =?utf-8?B?M3BaOWd0cGZIWTZkdk84VXA4RjU3czU5MXV5NUNyTmVpUnFyeVo3eXdtMmRt?=
 =?utf-8?B?OHFBVFBLaURjN2VtaCsvdjZsNUFCcEpEZjhxTHVnNnBzNVFkTUFQODhseXkv?=
 =?utf-8?B?OU5TZTRuY0JTUTdaTjZuUVJOb1phbzRsd2dnbk5wT05MZndDVlpvWi9VL1U5?=
 =?utf-8?B?QUhNTlVnZXk4aUNkT3h6dThvcExnaW00TW16Y2dOd1FmbHhkZllHdTltQjV3?=
 =?utf-8?B?K0Yzd3BlMWZIZG5yMEpJWURNQUVaL1hhS2ZkN3dCMHVGZThwaXdQcUU4Vm02?=
 =?utf-8?B?eUV4MG1QbCt5RVNKWmJHcGcrWVdWcjY3d1RlZ0loMG05MFlSRWlnYmZmemkv?=
 =?utf-8?B?R2FtQUpZMjI4eTh5L0YyeW1ybmdhTk9URER1KytuVUUrN3pFd1N4Lzh5RDBu?=
 =?utf-8?B?MDBZUEEwVDNmWUFzV0JKcUJwNkdwbjVsNnVkZWJtcnE3S1RkSzQzUUtkRURn?=
 =?utf-8?B?RnBXR3hmMyt0Uk9zRlZCZ1ZPVlN3Ulh2c0l3b3N1cHNsRHV0dkJsWEJZS2lw?=
 =?utf-8?B?MWIvekhMci94RHZwbXcwRE5leS9CU216QURLQ3BjT1JnaHY1eWl2T1lEWlRj?=
 =?utf-8?B?UWczUExsSUxuaWdzVW9Cd2g3SWprRjBHWDFESnIyWS95cnhZMEZ6MlFzNjVw?=
 =?utf-8?B?b1VDZmNNRmhQYUFRVFRZYXRaWkllK0s1b3MxRGJwTmRHdXh0WGlHL0FCdVM5?=
 =?utf-8?Q?0XpKUEkw2vPeoLHodTFEBNApQfrkHVusu+TzwwH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVNRb2tuNXlLL28raENOMVZRT1FOK1JyOFhVUnlHVGhXZE9oUndLdjNySHM2?=
 =?utf-8?B?MWtPVkx0NnVxVzVzNHNuZDBCWFZHczBFSERyUW1OY2NtMEZVOVlvQnhuR1Js?=
 =?utf-8?B?ZjVnY1pFbGplUEN6RHEwTHpjY28raGw1OEY1Vm9RS2xKNGRKeDVZQjJkd0tZ?=
 =?utf-8?B?Qmx2WUo0cndzSG13TEh4STNTNG8zRld4Y3JUNGpXVFA3R1hJaVN0MENsdk1w?=
 =?utf-8?B?ZUozM25PKzlWeW1SMXpCaXNKZU5nL0s5cFRIbzhKV2d2ZitlbHgvZERrenlX?=
 =?utf-8?B?K0ViOGpNK2FqbmlmRm4yU2FLMW1qTEEreVFXaGhRRHNGdlJLM2t5T2xFYVV6?=
 =?utf-8?B?bG5ESFF6Z25yYjJGMmtpY0cwQ0dtQmRwSjViWEJEWVNmSGlrd0ZaM2Jjc3k5?=
 =?utf-8?B?RjJ0ejZRTGJSTnpqOFVwK051Rk83Q2VCS0FsUWdhT1BmNlZ5eDhzTHRxNDBo?=
 =?utf-8?B?TjNNUUlLZUNFVkZ1MlNmRU5JcjFXdGhUeVBkcS9WRG5SL3pLYU9xN3RuRERV?=
 =?utf-8?B?WSt6eGZrblFZZkxFV0NickN1QmZQSzZpY0lOcElxTXhMZ1NScFgvdmVyc05T?=
 =?utf-8?B?WHhndmNMSUtidEZzV3RIYTg0ZmNhWkFjT1NoVGx3eGs3NmNkSVVwL013aklq?=
 =?utf-8?B?MXlHd29pTWE1bE5MVkQ1eGg3TG04cWhpK1dESnJWaDlTRmh3alBFYmVYS2Y4?=
 =?utf-8?B?bklvdDJXczZBUVg4UDMwQWpVZUpQMVVaK1Y5U0ZmSVVhOHpXSVB4MUFveXhr?=
 =?utf-8?B?SU4ybEwyR3hLaDlQSWpibjlyT0UrdmdXdmpDakx3WVk3bFE4eWlHM2FTbnJZ?=
 =?utf-8?B?MUdVeFExU1p3R0c0L1gxbWtFVENOYmkycXozV2g4Q1hEdTFiM1FsTnBXcjA0?=
 =?utf-8?B?UGYzaGRicHFLaEVSSnRudm9Vd1V2QzF0aktQK3VlL28rN1V1TC9vb3NpRUJV?=
 =?utf-8?B?UXkrRnJxTTdscE00YWhiNGlCUVFMR0xtSWpkZWI3c2plRlV5NzZsOWlsTzNF?=
 =?utf-8?B?YXZKRE9BcDlJRWtQWGlENkZOTUpNSjNoaVBINnpza2J4cy9kd3QrNExhcGYv?=
 =?utf-8?B?cEROa3g3ZERRTHNXNjRCOFRyQ3ZNUHN0bU85cEVzbkE4QTFqV0V4dTZrTnJw?=
 =?utf-8?B?bDBtZHVrSnNaZGJWNHdtQW1QSHlNVXVlekEvTmV1RGY4ZVBiZTVOMFlQbnVE?=
 =?utf-8?B?T1JXcHpkNUhwclBwbEx2VEhva1BVRHByTENXMGJsd0hjMXdqRlFBSVcwK1BC?=
 =?utf-8?B?dld0c3hLbitKZzhMUWt6S1BVdk8vYjBhZERDK1dYa2s3TTRqb21QeVRyci9p?=
 =?utf-8?B?cm9uY1picnRlSGR0bFJBcUh3c1FEald0ZzJ4WUR3OG5heWVBSmxBL3FXRi9L?=
 =?utf-8?B?cnE0NWNwZ2t2dGhLaTgwajdzZkU2QXRtU0lJL2VKQnBmQjZyU2tPeHpaWVFR?=
 =?utf-8?B?M3NvNWxrTm45TWU4ZU5TbzU0ZnBGSFE1WUNOZElPNi94WU5wdml5SWdNMW5K?=
 =?utf-8?B?UGZ5NTJBb0lXaUJIL0t1elY3aXpBUjlnSEgyR2hLQnByVU5KUEt5SHZiZktP?=
 =?utf-8?B?SWRCeVQwbURna0RncEQxU3VZcEFGWlNjbS9UWUZrN2xGU0M1ekN2SFF3eEY3?=
 =?utf-8?B?ejdZcUZQZGNTVFRFTkZ0T2IzcDhxUnZ6b2xhRzZJMDUzYVBzZU9nNlNpclh5?=
 =?utf-8?B?alhYemhxQUUxZlkvelRqUWRjTGhaMXp0TDMya1V6cmJsVllvRTdwM0RqaURy?=
 =?utf-8?B?M0xjZUtRb04zOUFrOThUSkN2a2d5dllJMFNhSnpNdENHeWxMbDN4L0NXZVFR?=
 =?utf-8?B?TUUzTmpuOExVVU1wOGJXTnJiMlErM3hzRnlrVkRoTFRrZTFnWkYxbHNyRm1N?=
 =?utf-8?B?Z09UdmRtbkhRbGZ6Y1cxSjZtck4vY2JaM1BLajhkM2lUa0JKN05hSC9vbGhl?=
 =?utf-8?B?M3N1VVFPUHlERGFlMFQ4elN5c0pEcWtmeXU3cUYrSEtKTmlrRUtCWTZVblZR?=
 =?utf-8?B?eWVKeFBWcWp0VEIzOWhzSno5Nk04NUp2WE82UW5pZEJmZUhpaXdUZU5wdlUz?=
 =?utf-8?B?dFFBREpqeEd3WEluNDVtcm50ZXBaZ3JDVEpFTk9nb1NQVGVYd3pKbjBneHhx?=
 =?utf-8?Q?Zf2G6q6tIC+bfHi/kQdE6vb/T?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dizsEAsRgSO27Tmmju3ipCFkHvJfPv94qJM5+6FS/7cnnaAfoYcm0YTKMj7ojjBz5TRdZPpJC8RXkuPdm6flCY6w3YICB5GvCKbr0opHjfDriVoqQM+t2EXTNJ43VXA8/ULZgN7AVSkjgXcfJVifNvI+m2caszycSalwfNuJ54jU0FC0/al/1gm2mw9JwPxCMYtlmbyvsWyab+1tJ6OMRg2U8HMKqXnwvRccV+t2KjJB6daG5Zeqtizc/XYmoRI45OPT8NWZdBJO1904wHtRG871lNQ/qLos4cvjaFNuXm2hAsWrltj3QxDKlludZZG7rv0aOWniZlo5e54fslf/KnlKTMHA8hi5ymuoonNoHm9ELED8s3e7f3E/lHyFS9+RobdoVQXPpFGj7t4QeO8x0LTJ5M08Jqywf9OgX64hq0wMJGycfxmMBT7/jzEjT/877y2f8SboL2nNFEd0z0mEujW9QeFjEEgsnLuxwnKcxVJL3YFkspufSabkf6OqbHx1a50lW77gDK/8IGY1CVY79ou+brsDNDA6Qi8gpoJKgJgfIwaIf6Dz/+CjVtzh+fV6AIx1qK13k6Vrdt2/x+JWX3pzwK9VV3RwWR3m2UpU0uw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21900200-cee6-40a9-ecbb-08dcf87c8197
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 00:48:01.6923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6v+wZ9sVt2qSfv6jgNxfd7UCG9btb+aUSDoE+UagrPEHxX2OQXCp289xm9K97wa7bbkKMCV42EPiCUYI4V1/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4480
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_19,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410300005
X-Proofpoint-ORIG-GUID: X4MYnYDmg80A-mXWgthw4xeyAe1q-GXL
X-Proofpoint-GUID: X4MYnYDmg80A-mXWgthw4xeyAe1q-GXL

On 30/10/24 01:22, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we have 3 or more adjacent extents in a file, that is, consecutive file
> extent items pointing to adjacent extents, within a contiguous file range
> and compatible flags, we end up not merging all the extents into a single
> extent map.
> 
> For example:
> 
>    $ mkfs.btrfs -f /dev/sdc
>    $ mount /dev/sdc /mnt/sdc
> 
>    $ xfs_io -f -d -c "pwrite -b 64K 0 64K" \
>                   -c "pwrite -b 64K 64K 64K" \
>                   -c "pwrite -b 64K 128K 64K" \
>                   -c "pwrite -b 64K 192K 64K" \
>                   /mnt/sdc/foo
> 
> After all the ordered extents complete we unpin the extent maps and try
> to merge them, but instead of getting a single extent map we get two
> because:
> 
> 1) When the first ordered extent completes (file range [0, 64K)) we
>     unpin its extent map and attempt to merge it with the extent map for
>     the range [64K, 128K), but we can't because that extent map is still
>     pinned;
> 
> 2) When the second ordered extent completes (file range [64K, 128K)), we
>     unpin its extent map and merge it with the previous extent map, for
>     file range [0, 64K), but we can't merge with the next extent map, for
>     the file range [128K, 192K), because this one is still pinned.
> 
>     The merged extent map for the file range [0, 128K) gets the flag
>     EXTENT_MAP_MERGED set;
> 
> 3) When the third ordered extent completes (file range [128K, 192K)), we
>     unpin its exent map and attempt to merge it with the previous extent
>     map, for file range [0, 128K), but we can't because that extent map
>     has the flag EXTENT_MAP_MERGED set (mergeable_maps() returns false
>     due to different flags) while the extent map for the range [128K, 192K)
>     doesn't have that flag set.
> 
>     We also can't merge it with the next extent map, for file range
>     [192K, 256K), because that one is still pinned.
> 
>     At this moment we have 3 extent maps:
> 
>     One for file range [0, 128K), with the flag EXTENT_MAP_MERGED set.
>     One for file range [128K, 192K).
>     One for file range [192K, 256K) which is still pinned;
> 
> 4) When the fourth and final extent completes (file range [192K, 256K)),
>     we unpin its extent map and attempt to merge it with the previous
>     extent map, for file range [128K, 192K), which succeeds since none
>     of these extent maps have the EXTENT_MAP_MERGED flag set.
> 
>     So we end up with 2 extent maps:
> 
>     One for file range [0, 128K), with the flag EXTENT_MAP_MERGED set.
>     One for file range [128K, 256K), with the flag EXTENT_MAP_MERGED set.
> 
>     Since after merging extent maps we don't attempt to merge again, that
>     is, merge the resulting extent map with the one that is now preceding
>     it (and the one following it), we end up with those two extent maps,
>     when we could have had a single extent map to represent the whole file.
> 
> Fix this by making mergeable_maps() ignore the EXTENT_MAP_MERGED flag.
> While this doesn't present any functional issue, it prevents the merging
> of extent maps which allows to save memory, and can make defrag not
> merging extents too (that will be addressed in the next patch).
> 

Why don’t the extents merge, even after mount-recycles and multiple 
manual defrag runs, without this fix?

Thanks, Anand


> Fixes: 199257a78bb0 ("btrfs: defrag: don't use merged extent map for their generation check")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/extent_map.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 1f85b54c8f0c..67ce85ff0ae2 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -233,7 +233,12 @@ static bool mergeable_maps(const struct extent_map *prev, const struct extent_ma
>   	if (extent_map_end(prev) != next->start)
>   		return false;
>   
> -	if (prev->flags != next->flags)
> +	/*
> +	 * The merged flag is not an on-disk flag, it just indicates we had the
> +	 * extent maps of 2 (or more) adjacent extents merged, so factor it out.
> +	 */
> +	if ((prev->flags & ~EXTENT_FLAG_MERGED) !=
> +	    (next->flags & ~EXTENT_FLAG_MERGED))
>   		return false;
>   
>   	if (next->disk_bytenr < EXTENT_MAP_LAST_BYTE - 1)


