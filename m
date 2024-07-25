Return-Path: <linux-btrfs+bounces-6687-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E60A93BB4C
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2024 05:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3B41F23EF8
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2024 03:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AA51799D;
	Thu, 25 Jul 2024 03:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lzic/gUx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HuD6M7sf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09E611711;
	Thu, 25 Jul 2024 03:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721878757; cv=fail; b=XrIDtqB2V5YQDv8Wi6NwgCzgbB2e4itMYF8nYlUi4Lj1sTjj+ZeGxcua0FGRTDNaOIbjYjbbqjNwLyqMaM2PY/fMYKgPnJXJDXeb3WSN2Uo34Fkyu1oWuU+NujKPDonJnYAdmP7VAEDjNv+BDW2kXthe20H8H8kqCSMj2BELPZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721878757; c=relaxed/simple;
	bh=cIbZ6/rkhtqjfTbVxoae0vzthdm1/T3hzI/KFqBxsPc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pPucrjzLB+me3Bf8fwSeKhgCdZeZTLwzODd96JpQSIqBwCK9DaeeIwyJnRe0E1w+NVQYlY5Zgfh41gUeUIbOvhEDGoNIbvGXlvpLya1d7KxaLJdmfKYQOkb9FLt5tx0Q/Wi5OjhGX/hfz4ce7o9DQTVgehgoatJ9/AikJiCZqXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lzic/gUx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HuD6M7sf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OJePnf025511;
	Thu, 25 Jul 2024 03:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=kU7GvViFPN5MBtGUePX+f91MyOdSsdB9wmHPD32B94s=; b=
	lzic/gUx+k7vRklrNYT870FUa5e8E3eyfUnckcVURFzgSyUEKUt4DzxVN46XTdAp
	TY/TVNbgrDIqnX5w3Z/YFBmvN8RC7lEjESwznVsbMzn486Xw76t24bcJa1ZtmRuz
	sUlnuN8nIP2dJFhjcsggwQuVVM4iE4NuVO61Mlx6jUJ+RHCCFlt/y0d+LUJYvb6t
	+HhAk/FJ7UrbXS+K2CTnlGokhvYj+TjZVtyuhSZKOsVG93z7UYHKaxjOFUuEeiWf
	LdEigzl/WYQKE7dGDbbEsqUwIhWZEVv3aAoQnfFII5gsVZaqWfPwjzRbGbPoOObM
	h3hYxuC99lvPdwyL7PT7XQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft0jcv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jul 2024 03:39:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46P0mq6B034308;
	Thu, 25 Jul 2024 03:39:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h27pxq1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jul 2024 03:39:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywnsU8JxkMdwTb6f87/hFin0DhZ9tbwwj7JPesIIteEjIh0qR++ANiVaOgYGLf4h9mY+SYi463im9VcM0DNOvvmJqcQEtryzWIMX8AsC+o/4RmEyTT6YTw53bA86eUfDQM3wm5lI1GyGcwGMKxPiG7gw44BjRRYA9GBpVBYqzZYQCdOAM9XNObyrGxTCozHi2nQWea2YGOeO5bJVcZUdVFVdjT6d/oUjpTg+5gofEXKDsLwpWmkM0PyOGpNmBXFqZO6V9Wbt7y1wHj+tyUz1QagUMGsxbnAVLjC5QTWmzqyl4B0rWqpyzhfoBv/yq7aH8VAjGUZtKSZCRp/IG3tXBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kU7GvViFPN5MBtGUePX+f91MyOdSsdB9wmHPD32B94s=;
 b=oI5BXj+uF4+5RKC8gFrD8lvqqvYFqj6muq/jz8RNNYs4dGaq1GaQsuB/Xo8021LfPqZk4kr80BQK9XFSgobkNbn6IVOpX7lFV4SNzGa9RGC85IOXpfWobld9nPFBKWQOtjVM/JKcuvagdMPcZQPuTCcoAxMt2oxnRDPm40OazDzPMC5ASpG7JRA7MzeI3goT11uHp+yDNE0zEmKs6YaXGulbQaPFaWO/IzGdv2GOlLq1IF3yIa+TLM373C6tdToexHYTDazcZtukZMoeABuEcRDouzurdsGNaA188Cq/8ox2cnaw/GTs9Y+adydK7QpIlvO/lUcixzhA6ofcS5TnXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kU7GvViFPN5MBtGUePX+f91MyOdSsdB9wmHPD32B94s=;
 b=HuD6M7sflrDONpIpTSdhbEMN7SFD8lpCDy4B6m+cb+LKkiF7mzXsFJxQ919rcnEVDCRq7Gm4vuZ/EGmP9wuCBQLadGaVddAPBeYirxIsEzMZ7CNKzMqwDpeAJ2GRlr7xlpYtOzCaW2ldKBQtbsL/ihN1Y3LRmOZP4yZlefG4mhA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN0PR10MB5909.namprd10.prod.outlook.com (2603:10b6:208:3cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 25 Jul
 2024 03:39:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 03:39:06 +0000
Message-ID: <5e4ab3f7-fcd8-4a91-9492-aa74d639f929@oracle.com>
Date: Thu, 25 Jul 2024 11:39:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: properly shutdown subvolume stress worker to avoid
 umount failures
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <4ee3a7f176ee871345a68aaa48b13e8ca89c2262.1721829411.git.fdmanana@suse.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <4ee3a7f176ee871345a68aaa48b13e8ca89c2262.1721829411.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:4:188::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN0PR10MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5c99c9-2ce7-4674-b812-08dcac5b55cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHd6RUNnblN0Sm90N2pBeVpZVVVySzlOTElXL09jV2xFYmU1c1VOc3diUk9B?=
 =?utf-8?B?RFlScmJNMVJIcEpGeHZQN3FaeHJCYTlLSWU1c0o3b2pDNGtSSEVTamNuSVli?=
 =?utf-8?B?bTZUWlpRNlVad0drNVZ3RlRPVTR1QmFlMS9JWU16djI2WWgyRDZ5MnM4VnVP?=
 =?utf-8?B?cTlkWkMrSFArVEV6VitYck1jbzY4bE9hOFo1T2pUWERCbTg2NWhVQ3VWK0tx?=
 =?utf-8?B?YmowR3UwbjYyOG5hejd0OCtIOEhMSkdTbSt6STUwR21IVDVOd0NMU3ZONm9I?=
 =?utf-8?B?Z2xLTjBaNk95MitZV2oraXd4RkhNRXZ6MkFiRWpkYnFDdVR6bHdNR1ZxeXBN?=
 =?utf-8?B?MXllTVVLT0xoM0w3SVBQRkJBMy95THhqZDFqdnVBYzUwS28za205cUo2UldJ?=
 =?utf-8?B?RHpQR3Z4bzlyV3BvdVVHMThBN3dLbnVwbGVaeDJhcGYzWGZJSG1FYkFJVkR0?=
 =?utf-8?B?a3dFbmd5dGxFdFN2aTNIYm9JTHowTVEyTmQ0cDFEOHFVQXpURlNYcWRVVWF1?=
 =?utf-8?B?cUF0MXZFU2svK2xPSm1nL2U1WFVEMGF0RlZEdFVkMXJGbDJIajFaMzhLL1B4?=
 =?utf-8?B?SUxISzk2TnVOUTA4Wkdxd0VwY3NlREN0YklNV1l0d3J1VVRWVmtobk5lMG1J?=
 =?utf-8?B?cDl6M3RUNlJFTlI2WEErNVYvTnk0dHJvcmdNaXNDaUJwZ0lhd0dlcHpJYXNZ?=
 =?utf-8?B?RlIvUG1veDhtYXVYbEVJMS8va2hCTlJ1T0QzTUxyZHlvTmlrZnJjdXJsVllG?=
 =?utf-8?B?VTF2VllkTlF5dy9ScytYcnRiZHdYZVE4SXhHUEF5bUpCUERXSUhGTzY0T3Y0?=
 =?utf-8?B?eFpjRDhLZWxFeHhvSXJYU2pUd2lrTDRYaGk4VjZDa0dtakxaWnhVbkc0Rzhm?=
 =?utf-8?B?NTJwQmk5OU10bkVLaEVqUCtyZFI2bWptVjdiWWExdi9aV2dTRHh3OHBMVWlt?=
 =?utf-8?B?TUF2ajZOZE54QXFtbDJjVTZqalZCZ0l3RHQwblhueHlLVXdhWjBGWmk1UFQ2?=
 =?utf-8?B?YzE3Vit0M0J3NG5MdHM1aklJY3NqNkVjYzYvaTdUNFh1SkRlM2VtajRHc0pw?=
 =?utf-8?B?N1R1VkpqRGtkQmc1ZTlHYkp3RWZpTTIxTlg5N2c1SnBCS0pNeGtoc0M3U1Ny?=
 =?utf-8?B?aG9yb1liTXkxd1NHWDlPUlpuaGlFSnpveTNGNnpQLzc5aERodi85SHQ2M3po?=
 =?utf-8?B?MWRTQWhkOTFCZ3FnV1pDeXJsd1RHWFRNanRzcWhRZ1BQcE5ydW0yYVFUMUM0?=
 =?utf-8?B?V0xDSWVPdXhpNlduY3BuWFFTYngxL2VuQjdRN2VLUFl2WjdCcGxaYmlDazNC?=
 =?utf-8?B?S2V4S1lEK0VLRkJEeEFEcStKeFVTM1dhZnF0dUQwN2d6S21jdEZZNmw5aEta?=
 =?utf-8?B?bEo1OStvU0p0emNLc3dNMGszWGkwOGtHRGhEU3kwcUk4WStoSmx5eDZZZnNv?=
 =?utf-8?B?c2FqaG9MZVl1ZVBwUnpXMms3dnhmRUcvODFTVWNDRG4reTZhNzhkaC9NcGhH?=
 =?utf-8?B?TzE0dWcwc3Y1WVJrOFFtK3JEUWZwbVJwbTZsR1VDcHJIVmJpV2V1WW9qcGRV?=
 =?utf-8?B?MUZxVVVtcTJJUXAvMVdkOFl2UXp1ckZPdEFOMWV2THVNRjhEQ1J1N29ZSnJF?=
 =?utf-8?B?anpxR0RiQnU2cmpGTHYwSEVWS1BXL3pZOUVLWmJoTlppaXJCM1Q5NUwzTU1y?=
 =?utf-8?B?Z0tJditqVnZZTyt1RTBBUzRncjcxOWlWSkNIWFJoZ25PNVRWeVJTNWloc2di?=
 =?utf-8?B?TVY0alo0VzdUbi9hUjVQcjFuUVJ5WnJPNEVDQXpMUk15OVpPdWNRSmFqdUZG?=
 =?utf-8?B?WVZkdXFpZTdaUTZZSEUydz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mlg2QnNHVml5c2dVR0tVa3VSUjVUVEJBdW9TbFgzbFhnclk3cUJXVzNTSzlv?=
 =?utf-8?B?SDVXR3c3Q2JQRTVjaHVLNlNVaHhpTnl6VFJtRUl1TmdmRzhsck5vWFhFKzJZ?=
 =?utf-8?B?WEg4elhUaSszMFo2NmR2UkhUc2NpUlRTNXZoSGhCZ2VDVGpmTnQ0UFUyeXpZ?=
 =?utf-8?B?eWYzWURhY1B5Vm5oMGhzQUh1VU1MOXZkVjJWdWRTZ2JYUVBXVTRzU3M3eklh?=
 =?utf-8?B?SzhjbDhJSGszRWRyT1doTG0waUlOc21RV2s0M3RZakdmb0xGSlRHeWNoQTdV?=
 =?utf-8?B?SW9Fb2Y0a0xnZGlaZlk3Vy90SG9zOVM1d2kxU3FrelZGeFdXQnBUT0hLV3VB?=
 =?utf-8?B?Sm5JK3pNYjFjMUtZOXUwL3FBWHNqcDl6c2ZsRlBsU3JJUDk4L3k1bWJHN2VL?=
 =?utf-8?B?UkRWQ0N1YWgrRmNqVEZ6OWtkcW9kTE9QOS9IYVZpREs0ajF3RC9lTGE1OUc0?=
 =?utf-8?B?bEVScWptdXFNeGpncm5PdGtXdDE3V0RHZWN2dU5rZzJqQ3pKMzlrYTZ6Umw2?=
 =?utf-8?B?azYxdGZJZTMyMFlwK0IweGxqUGpjZEQyeGNuOEp4ZTBScXN3VTZGelZWN2pm?=
 =?utf-8?B?RWxYYjBvbklaT3pZQ0dtaDh6dWRVOTY1ZlFxVUtzNUFQbk90cU1pVTR1b0xt?=
 =?utf-8?B?R1dFeHFrNS9ZODk2Z01RdTlOUnZUQTVDRGEwVXRrbFg4eXJGUUdpdUlzNDkx?=
 =?utf-8?B?MndYTVYxVjVWMnE0N3doRnZxN2tnMWZmMmxsbWdPaVZFekthNWN5R2xxTmhK?=
 =?utf-8?B?MDA0RXBBdzRzSno2MXJmQVlQOW9KZkhYMlhSL04raWpqelZDZlp4ODVpeDlX?=
 =?utf-8?B?TDdTbmIzWU4yeUNyQnYvdUkxSmxNeUlybCtLZS9qNHB5VXpucFY5S0wzUVkx?=
 =?utf-8?B?b1FKWUxIZm9haHJ4WkxVTlFlakd5elVEVlVaa1grNlhnbVE3MExPeXlYYW9D?=
 =?utf-8?B?b296UzZhaGZmdGI5RFoyWkt0RzRBYWVqOGpvbGw3emNEa0hZYjNsQnk1ckhL?=
 =?utf-8?B?Wk1xamVFdk94bHBtbFFLR2hucHhIUG5JODlScTVobTl1NXA4S1p4czVhT040?=
 =?utf-8?B?YjUwcktrdHRiMXE5eXQvdHA5bVpRbDhRbFYwMzdmVGp4R0htSS9SWVdvNVhD?=
 =?utf-8?B?UzZRaGZNLzlRSGI1L0p6TndYdklPWmxmWWM2NHRvNDNhK0hNN0JoNW5ZZnpr?=
 =?utf-8?B?Q1hhOTRxQWdZSmpZbk5uaVBDMENYczFNd0MxTGEyV1VVb3RybXFkZVZZWDBV?=
 =?utf-8?B?akxnYWs0NEQzWTdBUk11RXVMUVJ0R0VYdVFia0lZM201aUdISzgvU01SZjRL?=
 =?utf-8?B?L2xxaWQ5WWkxYmNaVWJjeTlZMDNZeFU2NElvMFFaUjRPTFBzWEpxOU1EL0Zr?=
 =?utf-8?B?RHozTStUNGdUc0dOeVhBSlpTMHlOOXhzaVBRbkJmZUlMNGVybjh3VC9Ua2NF?=
 =?utf-8?B?NlZBUVlyVC9KRUZtOHdhQ3ZQRVpkeFZsODQyRHRQWFAvZThDZUp2M2VLY2V3?=
 =?utf-8?B?V3Z1dGowaVI5cFV1dUZMRFdkSENHU1NuZkNBWGt0RVZ5a3pBbVBWa0xRUm5a?=
 =?utf-8?B?MEhTOU1weElhbzI4cVVZejNHMSt4QnhDaWMzQ2Q3bEovMm9Zc0ZQb01PbElm?=
 =?utf-8?B?UDRtT3ZKeWRkeTd5RjltVkFCclNqSUdBSWttNlNzM2l3T0oxZEVnVWhydmZJ?=
 =?utf-8?B?RVRJUzV1U201d2JVWEtjTU1XVTNVR3RIWHZUUHAvOHg5Y3RHbEtkRys4UW5V?=
 =?utf-8?B?UUxTVnJKb05xL0VKRVBPNmZBcW53VjBTQ0JNVEJ1SnlzYXM4bE1VczgxRm16?=
 =?utf-8?B?R2RIT0NJY2EwRlZqRm13bk01bCtTUjRyYzdjNFZwSGhka2J3VFd3SWdjbVpZ?=
 =?utf-8?B?aWI5TWlRcjBYUy9CQUJYeWxERHZNYmtyRGxjZXQ3SHduM2Y3WFFsWHY1eUJH?=
 =?utf-8?B?aE1zby9wVlBIelNjcU1qaXg3cFNTSklLVTF6WnZDa1RwdE1TekQ0b3I1dFly?=
 =?utf-8?B?ZUgvNWY5MFdreG9JTXVxL1RuTHRqelpQNEQ4VFZnbWtZZUVFY1JQUkV3NkVn?=
 =?utf-8?B?M2trM2N0VlNHeUVNRk14Qnh4TEluUGxGcTVUZVhmUGtvWWFjK2pqY3dORFlL?=
 =?utf-8?Q?tk9jOfRcbc0z3WX7k2K1RLL9z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vJ5b8GEKRzySSqvgFnMFWLiGdA1V9S8FvML5rpXfE3fR8E7L05OEJ4P1OcD83miiMiMnJThU/6KLSz0MIStFFmwhWcr2jUFgg/il3hy6uVxkF/lYG3jqHtx+KMHIs4cEcNS81rTVmkqo4zbIuQgawcKHqBYXS8OrRhjnmfeowCU+XgmyxKkonpKsHkmCH2dM7nsHtEJI0w++a9x/MPyoDoHx4k17+oS6JnbLwjOOeouv7M2zyzrAnZ4FI+2d3sz/DE4p/MNh7YVPcvqzOa5E6ew8g+9mnZ7jOlWuXAof+k/5f06VWGwWQ6Goqoq7Lmbx0ErMIrN/2QU2NddxtvHVQhE1rWwTVip3E9itFi4XVqGAme1/HJ2U0maitbxMtL2JU05Inm3Ufa0DZc8jkSz0WXBB8goSRfdeB/o19xkxUcjXBgE/LuCvit5cNWwWCBDw+7+P3dXWD3cFPzKfoFgcc/aXytJCSd+xwoQnTpVmpWViL5ciTgsSeH+hFAcGktSiyA3KutzjQg/sLUugc49ao7cLjdafp/sBpNDNDxO/wUkaitFPD0OFPgOH9rZMiVjQGvcWaZ+Rl6ft69fG0eVa3YNpY119xvZsLLsbvh4bO1Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5c99c9-2ce7-4674-b812-08dcac5b55cd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 03:39:06.5497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxKlYcWE3+myyGtgrZXkDl6xiZ2pQdh18X42IiCaTpw9Mt6GH8e5bpbMskkYUJ4WIuPkxlnKPRsd5muyiozRcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_03,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407250021
X-Proofpoint-GUID: WvKDQYFbNalx-88BlO-z0Qqc2KQEOTdj
X-Proofpoint-ORIG-GUID: WvKDQYFbNalx-88BlO-z0Qqc2KQEOTdj

On 7/24/24 21:58, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When killing a test that is using the subvolume stress worker, we may end
> up in a situation where we end up leaving a subvolume mounted which makes
> the shutdown sequence fail. Example when killing a script that keeps
> running fstests in a loop:
> 
>     FSTYP         -- btrfs
>     PLATFORM      -- Linux/x86_64 debian0 6.10.0-rc7-btrfs-next-167+ #1 SMP PREEMPT_DYNAMIC Thu Jul 11 17:54:07 WEST 2024
>     MKFS_OPTIONS  -- /dev/sdc
>     MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
>     (...)
>     btrfs/065 23s ... ^C^C^C
>     Iteration 134, errors 1, leaks 0, Wed Jul 24 12:14:33 PM WEST 2024, flakey errors: 0 MKFS_OPTIONS="" MOUNT_OPTIONS=""
> 
>     SCRATCH_DEV=/dev/sdc is mounted but not on SCRATCH_MNT=/home/fdmanana/btrfs-tests/scratch_1 - aborting
>     Already mounted result:
>     /dev/sdc /home/fdmanana/btrfs-tests/scratch_1 /dev/sdc /home/fdmanana/btrfs-tests/dev/065.mnt
>     grep: results/btrfs/065.out.bad: No such file or directory
>     Error iteration 134, total errors 2, leaks 0
>     'results/btrfs/065.full' -> '/home/fdmanana/failures/btrfs_065/134/065.full'
> 
> Running 'mount' to see what's going on:
> 
>     $ mount
>     (...)
>     /dev/sdb on /home/fdmanana/btrfs-tests/dev type btrfs (rw,relatime,discard=async,space_cache=v2,subvolid=5,subvol=/)
>     /dev/sdc on /home/fdmanana/btrfs-tests/scratch_1 type btrfs (rw,relatime,discard=async,space_cache=v2,subvolid=5,subvol=/)
>     /dev/sdc on /home/fdmanana/btrfs-tests/dev/065.mnt type btrfs (rw,relatime,discard=async,space_cache=v2,subvolid=2627,subvol=/subvol_3395330)
> 
> Then this makes the next attempt to run a test (./check) always fail due
> to the extra mount of the subvolume, requiring one to manually umount the
> subvolume before running fstests again.
> 
> So update _btrfs_kill_stress_subvolume_pid() to also unmount the subvolume.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx.


