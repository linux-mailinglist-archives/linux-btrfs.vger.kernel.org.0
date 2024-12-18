Return-Path: <linux-btrfs+bounces-10553-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 132769F69E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 16:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AADD7A39C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 15:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE1876410;
	Wed, 18 Dec 2024 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j9kfAXY7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="otwppbRE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FB4481B3
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734535238; cv=fail; b=kb3X0NIuOi4CV81YLcP7RfqGHXyA/Dw7X+J8EXx0moh6GZHpzlFXLSzvhtU4Y8q+gDhuNbRMdZkKLKS2dzeORU9Sowt7EpCm+quSylseN1C2rNziRZWHUrnlhj3YdHj8BgBMeoKYJwBM3P+bbESD8WEylLtZV+V/jEjzGt7unTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734535238; c=relaxed/simple;
	bh=VSGgcNyn+UcYx4K+YT2S649gxYhMk8oeVtHIEq5Holk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O2sJ6a4SfxfUpusl/tyAB04qVHXDVyPdQUH5KIZ0Zave8Wswi8Lt2wwzxUQWcyi+Q2BOwqe5tZ2+Y8hRkZQ67CLpUux4Q/wDWsR21U19TgSQQdCoB5yBjMh5jGeIwgyPXtukLJDPiCwybQRfEsKqHog4s9hYNfRQAkN8QQeim/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j9kfAXY7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=otwppbRE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIEljXe004831;
	Wed, 18 Dec 2024 15:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XD+XWcMc9YtsdpQklrloLEpE4lAdOlf8h4AmVtxBdQ8=; b=
	j9kfAXY7jkasVBYeJyftwLlRkm8/BwMMc4gufLpk0un27r9/fq0JX9LgKgKeVc9R
	oVsX9rvgAaOtu0Fe3sYSNJjjVdlykwoiNScZDuLTln3zdd9Wx5KCeA6AEGa2GnUq
	Exb0hxufT06Dj90eIKN8+9cc01lm8gF/5i5//Zqj/8WzRjaNvIWvX3MjXcJcvxgL
	DZ57qrnAKU8PNwUxnAKl0+u9XH517hnR+GKxAzP9e+aEL/yLJwkjp84YYyanmMyS
	o2X7H1lPJGdkFaVnwbYLRqa0O7C1IlUEYmPMbTUCiMCDYfgCEDuBvTCY29NXQoev
	OaCvS+nVTvZko3owIk/wqw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0ec8uxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 15:20:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIEwux4018984;
	Wed, 18 Dec 2024 15:20:18 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fa6r2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 15:20:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DI2/J/DPUXL1GG5qo1S8/J5CSgZ3lruQ2mKAHX2Kw6AvieB6XTXiaJCBRkm3nHTJk2I1Qa5TdQNg7KW8q40TzyhnwT8/NjCt0R5oC4vOFjrahH5dtGEKpnGVLmC6U8Oyob9vuFwILuRZ4fcdjTLI91cBq90UQCtdnM9KiydKroGMvzdnPCArDMX/LQ1k3HrNLxJ3I0RQmA+EG62guNulHzNfY+wCmbF2BH9w+KT73tS7egLvzXbNEq7WNveJOpL4XK0eIWuPfWqwzB6JkXGcbX3JjlmZhmur9qo/2LN3hSenzSduQszaWkWNfPpSJdE7Tt9AqVeDdNRwaVNhoDUIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XD+XWcMc9YtsdpQklrloLEpE4lAdOlf8h4AmVtxBdQ8=;
 b=L4LY6kaVuWJI/GXymFim8iDpeRpMPvsX5swqsyyA8baK/oUdqQt1Mb2kz1IZLiW5SXLjSnUJPCTgrmWq9FMgL5wQjfmRLV4K58ASx0w63XfNdE/PXwbbTTXoxREJ1T7gnmd9O14hAVbucMMWd5iWqWKdkHWBj4JnXWNAjrhB0ddhPqf9NMTpL/6kz6lCcK1bwXfluK11eYilXiIi7yEtOgL4Gl68wfmE7srlPpExsYJNDMQuuLaCeq0DkvC2El0F4Uizb1mPKsuZsrLUykCAUx7PYJBP3Wym4ixcue63Kdk5PMu4xnsVEqCuYTHq/HNxyM2U7NJgbDAgaz1IavRprg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XD+XWcMc9YtsdpQklrloLEpE4lAdOlf8h4AmVtxBdQ8=;
 b=otwppbRElELSebGQ7jYnSAaFWzEzvAJjhoJXsh7e2nOboDEs45njyDLrO5ehipD2OKVLEKG56wPYarp62lsYs/uHVJttY+2s1l8LUutSaCCPfTWBb4OjtOodMtU6YgzY8Yz94LnExIjo17xBrnr3cH9+2nqDYXvR4XMl8XwoRMg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6309.namprd10.prod.outlook.com (2603:10b6:510:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 15:20:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 15:20:15 +0000
Message-ID: <f74f3841-9a21-439e-975e-84df3e442386@oracle.com>
Date: Wed, 18 Dec 2024 20:50:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] btrfs: introduce RAID1 round-robin read balancing
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>, WenRuo Qu <wqu@suse.com>,
        "hrx@bupt.moe" <hrx@bupt.moe>,
        "waxhead@dirtcellar.net" <waxhead@dirtcellar.net>
References: <cover.1734370092.git.anand.jain@oracle.com>
 <90934f391bc1c9772f9e3a7902cf9d04f3b0d14a.1734370092.git.anand.jain@oracle.com>
 <amkllcfcvkuebolcjm772phammyqepfmb3agojgvfco7hznlhy@mmssvxw4yr5f>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <amkllcfcvkuebolcjm772phammyqepfmb3agojgvfco7hznlhy@mmssvxw4yr5f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b1d421-93d5-4b84-3568-08dd1f777918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjhBb3FwR1hINytSWGpMT2pYQUYwalExR0xkUkNBaDJMSU9jZWhxb3ZUcWVy?=
 =?utf-8?B?MFEwK2dFKytxOW1XY1NEWXhnU2F4RzZ1UHE0Wk9FRTNOTjY2ZmNLd2tXd2x4?=
 =?utf-8?B?eXYrR05kT2JISWl2S21nYjZPTkpwME9FZXg3VWR6NllQSitmeHpaRUs2ZWNw?=
 =?utf-8?B?cjc2V09MNmlOMVpaTzVPajFEd2tqOUxBTnNuQXc4SHc1eExGS0lybDZmOTJV?=
 =?utf-8?B?UlBDMmdMdGk3TUkzUFNsbzJmU0xwY3k5OXNCWFVqRWY4TzNGR01wR1dRR0RL?=
 =?utf-8?B?QlQyU2ZMQy9vcW5ldHhHQVN6UndxWnoweHl6b0p0cHo0QlhRSHhUQm1YVmNT?=
 =?utf-8?B?Y3QwRnZWN2I5VFY2bGZuanNNL24zL2lSVy9yR1JWVVY4amFZOEZ0UzA0WXFV?=
 =?utf-8?B?T1B5eWl5Z3NlNUtOZkdWbll0eEhtSTRqaDR3UW01b2Z5Q3FWQWhWcUpDZyti?=
 =?utf-8?B?RzlmVFlqVEI0dVQ2b1VBK3p5YUkxc3VXbXhkVXp1MnhLR3c2c2ttSFN0cTBM?=
 =?utf-8?B?ZjhRN2FpZmZiSXhLdEYzSXR5OHBYajJkVkQ1a2w3NENZWURLN0pEZDVmU0lI?=
 =?utf-8?B?dmRHTkpBYmcxUHFvNkIraktKZUlJU3J3SzVqdXZvbTA3dmxOVVlVRmx5MGx2?=
 =?utf-8?B?NGN2THhtdlFKQ3dmQ2lTQnM2SHdCYlZOaW9MSUg1QVZ6ZjhMdVh5eUxQMGt3?=
 =?utf-8?B?dEg0VUhJdEhueC9CUGk2VjdTNWkxWHpOZHZtN2pGN045c2cySUZhOFl4MFE5?=
 =?utf-8?B?bGxzei9McmlQMFZhQnY5OGhqWUJEREYzdWh1YkNQSFMxUlhxTjZYVVpyQnBz?=
 =?utf-8?B?N1c3ODUrbWlPM0EwQnA4YUgvVU5lNEhSSVdrNHdDYlIrYkY1Mk9lb2REbHJY?=
 =?utf-8?B?NmZiRVRnQmwySVNwWTJOalJkRGd5R09TV3VmYzA2TG1YWEdNZHFpdHVhUVA0?=
 =?utf-8?B?STdzMTYzVnBIbGc3WXZwVkFlWld2dUEwVWl4VjNrSGVoZGx5UHpCVEE5SUl2?=
 =?utf-8?B?bG16NW1yUU1qODN1eXI4Njh2eGVsYXdJZnJJOVBRdFc0VFdEeW5JMHdRZFg3?=
 =?utf-8?B?cmJOdE5saDNxSjRmeGVnRHNlMXdYejFwOTBNZmcxb2d6Sk5GNmJRNEVETXFl?=
 =?utf-8?B?aEZ6aWlSWEM0NlJNZjM4RGRPQU51Nll2MHdtMFZoR1U2L3dYbkF0blI5Z1FZ?=
 =?utf-8?B?OGdYOUdrbXlGamRpVDkxNzM1QW53RmxtbkRHMTdxZ2Jvb2pNa2VoVENZRXAz?=
 =?utf-8?B?ZWgyRi95Tk50RmRLeVU5TytrQWt2VUJwWVovb1VUWnBjN2IwUVliNzlVQnd4?=
 =?utf-8?B?ak8vT3RMbnFQYTJwTWJKQUlTTmdUdldZaUdKcWNZMTUyd3ZVcnhhWi9sODVB?=
 =?utf-8?B?R1RsVWpyRjJtb0ZpNEVxQlB1RFNFMW9uWWFoTVc4UFc1ajZsaHZZTW90RlNs?=
 =?utf-8?B?L291ejBxZWF3OVluN1V2L3FZMGN4UTkvaGdSbWhqeG9uM0l1L0RaVFhRUVN6?=
 =?utf-8?B?dS80QnBhU2FFTFNNMTBhTEo5dXA3eVhTNkJ3bTBIb3dJZUxBb2hoMEE5N21u?=
 =?utf-8?B?UEZyek9Fd2t0NlVsQm1LL1loM0NsVmNnTlhoNHJTU1J6SUZUUzgyMjdIM3lt?=
 =?utf-8?B?NzdhTUg2bEpvQ3hNYzI2YVFwNEh6ZnU1d1czelVWejkyOGMySWZRdVVjMjk5?=
 =?utf-8?B?OEs3WnNDNGZSUlNvc0p2YUVYdWhQSDluMUVlN3dsRlZVcW0xanVOUDBXQlY5?=
 =?utf-8?B?amVwTnA0VVRSQ21pcm1TQmRNM1FwVHN3a0NUUkdhUjMveG9iU1BKaEdsVUQ2?=
 =?utf-8?B?Y2lqWmxRTHpVM0FSWDJSUUJVRlJac05VbnJ4Yjk3dGtROGJ6N1R1Y3drN0JC?=
 =?utf-8?Q?HHvzm0XgB6u17?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEpOOHAyNGROQVRLUVFBK0RPeGY5ZzNJSmEydWQxeFl3aVMxY29EeTU5aGFP?=
 =?utf-8?B?dWhwbUdMaGt0TjhjTnFCU2RabGJyZ0pMN2FrTE5zM2R4M1JONmd2VFRJNlVh?=
 =?utf-8?B?cTdKK25rSWNsdkhrSWxZNjJyd0FZenNzTnBRTEJVNTFqZ3JvTnZiNERFVmdJ?=
 =?utf-8?B?VExmc2FRbGErdSs4djNVNjg2akhYODlFaFRUaW12clBKd0tjWEJ3R3VlVWlj?=
 =?utf-8?B?dXpxV0RrMk4zN29ZcEZXanV1WmtVZWZzMVordlZyS1greTROQi9BdFFRNXlH?=
 =?utf-8?B?OHJhM0c4Tm0vTHArYkFXa3Z1NXo2SDlMcm92ejFtTTJGODJWeXMxcXdWSkRV?=
 =?utf-8?B?aCtueEpRcThxNTM5dDZQWWs1UkJlUXU1ck9SSUVpNVRDZjAvcTZJQmVJYWpF?=
 =?utf-8?B?Mmozc1ZjTlQrS1JtZ1M5bU81ZFgwbWVPRkpLejdGOFVKU1BuM1VKdHRTMjdN?=
 =?utf-8?B?ekxQeEZhUHZKZ1ViNVp2dXJkT2JsdlJjbzd5akdsRVYrdUIxOVVmczBvK1pT?=
 =?utf-8?B?SWhHWHVZNmMrWEpFYnAxSXpTdUVvY2J3Qm03TkJSdnNrZDAxOVdUK2g2TG01?=
 =?utf-8?B?bDVYT2FjSmFFVitYRy9HSWR1V0VVVnk3SzRUaWo5UGM5bEQwdjhoUWtleHRa?=
 =?utf-8?B?YmRaWTB2VzRXa2dTbS84QVNBUytUa0lGbkZpcmluK3ZjVEhIbzVQR3JhR3lj?=
 =?utf-8?B?U1JwSWlBK0ZWeVF4Uk5sQ1AvbVV5Ry8rU0tuczU4SUdBaHo4TUE2TXlqc0NI?=
 =?utf-8?B?N3VLbGlMT3RKS1dFc0dGTmJSMi9OZWExTnJsL0FyTFl0VEs5S1E3Wng1YlhD?=
 =?utf-8?B?TVA3MGdlU1d1OWpKa0VqWmFpQTgzSldYTzVacmNUM1A0ZnlzOG16UnA0SW5G?=
 =?utf-8?B?S3RDSHkvWUc5OGsycml0Vk1hWGxhMXRrMUc5Qm9SanVUZlV0bDZTN21vYmJL?=
 =?utf-8?B?OGZWV2ZZT3JPTXBuVUFSdmxIazdqd21xQ0JUSXNrRjR1bWVhS29ZNnhIT2Vm?=
 =?utf-8?B?MXNQZlgzTkRJZHB0TTBCM1NmYjV1QVQzNGdqUEdldmNVdDVtNXVNR0dZRk1U?=
 =?utf-8?B?dVVJVHFkdGhSeUg0ZlVQNWtNZ2JZbVpMYlZBY2RHN1R3aUJDK2RLZDBRcmpp?=
 =?utf-8?B?aC9ZN0ltNmVmNlhuZXJ6a1VaOCtJUWprMmQwOWF6OFUrdFFJamhaelpnbkV6?=
 =?utf-8?B?ZmJqMG1icysxQmwxdGJSempqV3hRSTR4MDEzNXlYa3M5N1ZLM2dBUUs5Vk5o?=
 =?utf-8?B?bzhKdHZyUWR4aE1aWVNzVUtleTBXc1FBcW4velRxa2VwaDNiNUN2UmZ2Uk5O?=
 =?utf-8?B?N0lpUGFZR3ZFdE80VWVLd3hsUjRxWnNqVWZoRjVRNG96aTNObTJtdXN2b2No?=
 =?utf-8?B?Rm94Y3FPRnM5Q1NEL1RCcHNHQnhuTVEva3JJQkhHNFhXVXY1MlBUM0V4akRI?=
 =?utf-8?B?dGJoVVBJK0tEaVo5S0ExdXRMUU9RMW5iMWQ2K0p3bktZWHJaUTluR1JGcm5B?=
 =?utf-8?B?Y3JRQ2hoMUJXRFhCNGYxN3FOQVZXVHljdmxLMXRZbmRSdG8wRmNDWjViem44?=
 =?utf-8?B?ZW9SQk05eENUT3hDYWQ5cmllejhlU2J1QzlIcG9Wb0hTM2hKSW51MUxlTUFD?=
 =?utf-8?B?ZUhLQTM4aFBacHBhR3I3UkMvallOeU5NNUFRTkREY1lrbGxWVFZ2VVZia055?=
 =?utf-8?B?bGlQYmpFK3JrVCtUVWo0NzNSdkdqR1ZINURvU2puV0JFWHdtWWlYYTF1UElv?=
 =?utf-8?B?SHlCYXVZYWdHQ3BoV2lLNnBHdHREbTdKYzg0MzRsa01LaFo4a0xVYlNFOFNX?=
 =?utf-8?B?K1dwOGFDdTZtWWxodGppVmNPS1kzbVI2d2duRlhPSkZzTG9rdjVsVzFPelBJ?=
 =?utf-8?B?c2ZwOWhGS09GdnhQbFZLb3lFa2d1VGNLRGVSOTcvOXN2bTM4aWppV0JhUTIr?=
 =?utf-8?B?YXJWaVNQRHRrYmJqa1UzbTh6bjdFS2w2SjQ3bVg2aU5ZalVUUWxXSDNRY1NO?=
 =?utf-8?B?ekZVREFMbHNPd0g3d3owSHVEWTJmUkd3djN1Ym8rK0dWZU9XcS9tNmt4MDNq?=
 =?utf-8?B?VmVpelJzUTVDaGo4UmRWK09HTnBvSnFQOVFIRW1nenVIb3dWVjMzaDY3T09B?=
 =?utf-8?B?SVg4aTZmRkpxbURkV09ZeXJ6TjNpYmx2VkhjcDRnM0NuZlQvcCtMWWhRWXpZ?=
 =?utf-8?Q?uBAXzpBz5rGM7NxaAwaU0BUQrnnxWgd3Rx8IiOL9fXc3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	stFMXFz1fD9I0EvavkRIrgzUehdt1akuTJU4UmG9L9RhdQ+TMySCuMFyga8PCoVUXUgrYPqsynMNvHQzqHZK/gfpIQbwOk6prYLc9urZEY49yqm5D6UhavrtbW3pEUqc+7UTlu0GqmojjwD6xVUDoNjtn2wq8vmou9bkD2zoXrcX+dM9ZcBwH+vcYD0A+gBNSp/Oxc2RyOiJ78nlh28fsG5YhdMUuEGMrRqW1AXzLB2H1LotHdajlE/waio6pObxPntCDCCd1rtrVAr/9wuim8DXIbZ/mdsOreoWd0veCcuptKBWoQ9NsDCqgQ+SGzVszREv2A4VMCWTWlR0EoVl38DW5FD25KLtg2HTE4eh66Sroe9BKbA2LBGYPfEPMmo1xEAnlDACfsPdtDpxqDRCorPe+O3uIbMjGJ5TMfCeJ7iTaYAS/e94n8u5h7DR0Xe1a6XUxo3l13R8war2Cdo4CgU32ozZgwdEhsQQIteFWj4wev09wbZBOxJrqr3B8BeX1tfhfRtxoWXxr+7PvUfttRpz2swBi7GV4nDHHsB18O5oTrQkBfm+Zg7i0LCT50mY/etxj0lWhpbghqicdG3vnS/6rnvYglCOQeLR+bOTVrM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b1d421-93d5-4b84-3568-08dd1f777918
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:20:15.5203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nI2UH2PKehGM/RN9VDy/H4X1c9nuG1zyuTl9ujqOZCnIFTo1MTH14iGna01gpOGJrPgOmZ+8IILvup2beqTYSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-18_05,2024-12-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412180119
X-Proofpoint-GUID: ik7okC3iPlJjQMNnzZ4MTDqX9q58zIUy
X-Proofpoint-ORIG-GUID: ik7okC3iPlJjQMNnzZ4MTDqX9q58zIUy



On 18/12/24 11:23, Naohiro Aota wrote:
> On Tue, Dec 17, 2024 at 02:13:13AM +0800, Anand Jain wrote:
>> This feature balances I/O across the striped devices when reading from
>> RAID1 blocks.
>>
>>     echo round-robin[:min_contiguous_read] > /sys/fs/btrfs/<uuid>/read_policy
>>
>> The min_contiguous_read parameter defines the minimum read size before
>> switching to the next mirrored device. This setting is optional, with a
>> default value of 256 KiB.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/sysfs.c   | 44 +++++++++++++++++++++++++++-
>>   fs/btrfs/volumes.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/volumes.h | 11 +++++++
>>   3 files changed, 127 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 9c7bedf974d2..b0e1fb787ce6 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -1305,7 +1305,12 @@ static ssize_t btrfs_temp_fsid_show(struct kobject *kobj,
>>   }
>>   BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
>>   
>> -static const char * const btrfs_read_policy_name[] = { "pid" };
>> +static const char *btrfs_read_policy_name[] = {
>> +	"pid",
>> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +	"round-robin",
>> +#endif
>> +};
>>   
>>   static int btrfs_read_policy_to_enum(const char *str, s64 *value)
>>   {
>> @@ -1359,6 +1364,12 @@ static ssize_t btrfs_read_policy_show(struct kobject *kobj,
>>   
>>   		ret += sysfs_emit_at(buf, ret, "%s", btrfs_read_policy_name[i]);
>>   
>> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +		if (i == BTRFS_READ_POLICY_RR)
>> +			ret += sysfs_emit_at(buf, ret, ":%d",
>> +					     fs_devices->rr_min_contiguous_read);
> 
> I guess we want READ_ONCE() here as well.
> 
>> +#endif
>> +
>>   		if (i == policy)
>>   			ret += sysfs_emit_at(buf, ret, "]");
>>   	}
>> @@ -1380,6 +1391,37 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
>>   	if (index == -EINVAL)
>>   		return -EINVAL;
>>   
>> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +	if (index == BTRFS_READ_POLICY_RR) {
>> +		if (value != -1) {
>> +			u32 sectorsize = fs_devices->fs_info->sectorsize;
>> +
>> +			if (!IS_ALIGNED(value, sectorsize)) {
>> +				u64 temp_value = round_up(value, sectorsize);
>> +
>> +				btrfs_warn(fs_devices->fs_info,
>> +"read_policy: min contiguous read %lld should be multiples of the sectorsize %u, rounded to %llu",
>> +					  value, sectorsize, temp_value);
>> +				value = temp_value;
>> +			}
>> +		} else {
>> +			value = BTRFS_DEFAULT_RR_MIN_CONTIGUOUS_READ;
>> +		}
>> +
>> +		if (index != READ_ONCE(fs_devices->read_policy) ||
>> +		    value != READ_ONCE(fs_devices->rr_min_contiguous_read)) {
>> +			WRITE_ONCE(fs_devices->read_policy, index);
>> +			WRITE_ONCE(fs_devices->rr_min_contiguous_read, value);
>> +			atomic_set(&fs_devices->total_reads, 0);
>> +
>> +			btrfs_info(fs_devices->fs_info, "read policy set to '%s:%lld'",
>> +				   btrfs_read_policy_name[index], value);
>> +
>> +		}
>> +
>> +		return len;
>> +	}
>> +#endif
>>   	if (index != READ_ONCE(fs_devices->read_policy)) {
>>   		WRITE_ONCE(fs_devices->read_policy, index);
>>   		btrfs_info(fs_devices->fs_info, "read policy set to '%s'",
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index fe5ceea2ba0b..77c3b66d56a0 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -1328,6 +1328,9 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
>>   	fs_devices->total_rw_bytes = 0;
>>   	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
>>   	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
>> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +	fs_devices->rr_min_contiguous_read = BTRFS_DEFAULT_RR_MIN_CONTIGUOUS_READ;
>> +#endif
>>   
>>   	return 0;
>>   }
>> @@ -5959,6 +5962,71 @@ unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
>>   	return len;
>>   }
>>   
>> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +struct stripe_mirror {
>> +	u64 devid;
>> +	int num;
>> +};
>> +
>> +static int btrfs_cmp_devid(const void *a, const void *b)
>> +{
>> +	const struct stripe_mirror *s1 = (struct stripe_mirror *)a;
>> +	const struct stripe_mirror *s2 = (struct stripe_mirror *)b;
>> +
>> +	if (s1->devid < s2->devid)
>> +		return -1;
>> +	if (s1->devid > s2->devid)
>> +		return 1;
>> +	return 0;
>> +}
>> +
>> +/*
>> + * btrfs_read_rr.
>> + *
>> + * Select a stripe for reading using a round-robin algorithm:
>> + *
>> + *  1. Compute the read cycle as the total sectors read divided by the minimum
>> + *  sectors per device.
>> + *  2. Determine the stripe number for the current read by taking the modulus
>> + *  of the read cycle with the total number of stripes:
>> + *
>> + *      stripe index = (total sectors / min sectors per dev) % num stripes
>> + *
>> + * The calculated stripe index is then used to select the corresponding device
>> + * from the list of devices, which is ordered by devid.
>> + */
>> +static int btrfs_read_rr(struct btrfs_chunk_map *map, int first, int num_stripe)
>> +{
>> +	struct stripe_mirror stripes[BTRFS_RAID1_MAX_MIRRORS] = {0};
>> +	struct btrfs_fs_devices *fs_devices;
>> +	struct btrfs_device *device;
>> +	int read_cycle;
>> +	int index;
>> +	int ret_stripe;
>> +	int total_reads;
>> +	int reads_per_dev = 0;
>> +
>> +	device = map->stripes[first].dev;
>> +
>> +	fs_devices = device->fs_devices;
>> +	reads_per_dev = fs_devices->rr_min_contiguous_read >> SECTOR_SHIFT;
> 
> Want READ_ONCE() as well. Also, is it OK to divide it with (1 <<
> SECTOR_SHIFT), which is not necessary equal to fs_info->sectorsize?
> 
>> +	index = 0;
>> +	for (int i = first; i < first + num_stripe; i++) {
>> +		stripes[index].devid = map->stripes[i].dev->devid;
>> +		stripes[index].num = i;
>> +		index++;
>> +	}
>> +	sort(stripes, num_stripe, sizeof(struct stripe_mirror),
>> +	     btrfs_cmp_devid, NULL);
>> +
>> +	total_reads = atomic_inc_return(&fs_devices->total_reads);
>> +	read_cycle = total_reads / reads_per_dev;
>> +	ret_stripe = stripes[read_cycle % num_stripe].num;
> 
> I'm not sure the logic here. Since the code increments the total_reads
> counter by 1, can we assume this function is invoked per
> fs_info->sectorsize?
> 

You're right. To fix this, we need to track read I/O stat in
`struct device` on our own. I avoided this earlier as the
block layer already provides I/O stats (though they might
be stale). Unless there is a better way. I'm trying.

Thanks for your review.
-Anand


>> +
>> +	return ret_stripe;
>> +}
>> +#endif
>> +
>>   static int find_live_mirror(struct btrfs_fs_info *fs_info,
>>   			    struct btrfs_chunk_map *map, int first,
>>   			    int dev_replace_is_ongoing)
>> @@ -5988,6 +6056,11 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
>>   	case BTRFS_READ_POLICY_PID:
>>   		preferred_mirror = first + (current->pid % num_stripes);
>>   		break;
>> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +	case BTRFS_READ_POLICY_RR:
>> +		preferred_mirror = btrfs_read_rr(map, first, num_stripes);
>> +		break;
>> +#endif
>>   	}
>>   
>>   	if (dev_replace_is_ongoing &&
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index 3a416b1bc24c..b7b130ce0b10 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -296,6 +296,8 @@ enum btrfs_chunk_allocation_policy {
>>   	BTRFS_CHUNK_ALLOC_ZONED,
>>   };
>>   
>> +#define BTRFS_DEFAULT_RR_MIN_CONTIGUOUS_READ	(SZ_256K)
>> +#define BTRFS_RAID1_MAX_MIRRORS			(4)
>>   /*
>>    * Read policies for mirrored block group profiles, read picks the stripe based
>>    * on these policies.
>> @@ -303,6 +305,10 @@ enum btrfs_chunk_allocation_policy {
>>   enum btrfs_read_policy {
>>   	/* Use process PID to choose the stripe */
>>   	BTRFS_READ_POLICY_PID,
>> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +	/* Balancing raid1 reads across all striped devices (round-robin) */
>> +	BTRFS_READ_POLICY_RR,
>> +#endif
>>   	BTRFS_NR_READ_POLICY,
>>   };
>>   
>> @@ -431,6 +437,11 @@ struct btrfs_fs_devices {
>>   	enum btrfs_read_policy read_policy;
>>   
>>   #ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +	/* IO stat, read counter. */
>> +	atomic_t total_reads;
>> +	/* Min contiguous reads before switching to next device. */
>> +	int rr_min_contiguous_read;
>> +
>>   	/* Checksum mode - offload it or do it synchronously. */
>>   	enum btrfs_offload_csum_mode offload_csum_mode;
>>   #endif
>> -- 
>> 2.47.0


