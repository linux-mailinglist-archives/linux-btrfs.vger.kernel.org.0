Return-Path: <linux-btrfs+bounces-9230-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5609B59B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 03:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CD64B225A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 02:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC11191F81;
	Wed, 30 Oct 2024 02:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X8NNCH5l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ISC8Ezja"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975A3D531;
	Wed, 30 Oct 2024 02:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730253673; cv=fail; b=XpNuyQiadO7CjpVQ3oRYiFy35NSCfTpvzY95P1qLk1n6p9GQ33PS51GdxJYOufFuM0zDsgON8pfIw/xqok9bokyWAb7uwhESIoYt9PfF7KiJEInrCzgiyAo3kdnLB85rlhiIIVSQmS7KsPT/3OpWGJzJcBrHfWIDEulJn4Sr1YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730253673; c=relaxed/simple;
	bh=UI1sTNQ4jHD7TXbmIyVwKNa9YG//sYeRHMFv3616yI4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qxL8rIu7er90oWj6+QqH7ZyGj+tqs92Z8maibDtSlEQRfbcaLFLntKjO9MR1gbjkf/tVkCeiXeanU2Ew3NoybN8L+zM7+6yXh8zzWAMJtDr2D9j+xv0xS1A1QBkD3PVZZHWDcVtbn2qe/0qLcuq6jL7N/ERL5j9byJtV6SC7zhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X8NNCH5l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ISC8Ezja; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U1htp6030237;
	Wed, 30 Oct 2024 02:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GzwSDEj42hT/Avx8Jb78ENN6rmDKZnfkCzOJiRpk3pw=; b=
	X8NNCH5lBVgBXDhUGZmcFOPA/p3wR+R5/IfvvuFG4rjMhUgI6eunfcQcbdX6dJk6
	dJ+f0USHFO9WWWZ7ZxnEe9YXjo/vWV+x7qLnKOOii4XmfFkVr93yHZmnYySuJm0U
	1l0S14ReSf7tyn9U3IQFlwdhXM6EZJ1NT/GKRQnasd+VXjO+ab+vCPo8qLYszq9M
	zqyEJUZX52Gq6dJ+r8OebDKM8O1gD+uLg7lVmaAULIrPvrOvraD5ZzBB4Zn+QBoq
	9xGlfdspIlDJJ7srRTVALq3QS2Nu8dWPW3a2HKTIsvaW4bs1M+wIk+Y6J3dI70c3
	ZRHYDQNQ7Uim27BlTSfSqA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgweuyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 02:01:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TNb9mg011760;
	Wed, 30 Oct 2024 02:01:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnadd6x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 02:01:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADz8aRZunyE5VEuz2Dt/SpFQQxWjNsCBU+LzMawiCRLSOWxiDU7/kpSaI1hBif2lxnkM36Ru6awP8gXFAswzxefH/B/ncSzwWsspCmz9b+fA3LjdUKuKuinu8OBMmkLmGarBNvnCs9YFBIdeifJL5yPlhqNXOIfuJo+PnPyH8i9bNXC7SQZ/ortHHXeiNeooGyC5ZyWxF/Tc0TFACjPgRNb9gKQV6E8FCLS/sIzTuFp6uiZc2r9kF6DsV323wDtm8RX5StErgRMrnkMQXvQ/7XCt9Q3xG8U7NJRPpGWdeBGGupPmgRTOZXrY8Pfd9q23V/ruf0AV+8AXJcjI4gzYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzwSDEj42hT/Avx8Jb78ENN6rmDKZnfkCzOJiRpk3pw=;
 b=Znee4BZ1zj8IBrxn5s0ew4oiOgqOzwV0fAPlhk/eudHLRtiAIfcVEmYv9+OoE2AzAvAVgWaAG6gEwx1KkcKPDSLt34QnAV+nKYbgJ9+GwUU+8bOzNmrWY6fRdMQW9cuBr8kRqvkHLDW1mvPiR20idJQwZeTXIbpF9kxL/55CGnjwwSrw3jvEClNJzgvq6mOS7kbqyY0fPTai5Is+6l1bl5S9jqMbkopgeRq6CPAChX/lDH2L60ppKIry5UMdpIm9KdoIPkytbnBGTTTxo5yUwOUl1pq+uXNzkG7D3+5ZTQUHT4o/iEq0EEXk+pEjzvwBbnR/OuQHDr0paWjPSLkoVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzwSDEj42hT/Avx8Jb78ENN6rmDKZnfkCzOJiRpk3pw=;
 b=ISC8EzjaZrfjO6M23+NYIUWfCturOJcC9m/xMzYyPvunP+2S0TuBb8MoX9Zea8WQy26xP/y/HaREImdFEXq7ovggXXGFfWBd11TwYFGMM+epWymPnF5ZD+EjVH91rTbBOTToFkj5TqQKrkKmySTa1zJjJQKLDKa8u83MhB8hf2g=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4338.namprd10.prod.outlook.com (2603:10b6:a03:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 02:00:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 02:00:55 +0000
Message-ID: <cb5fac77-6764-4486-9f36-90f447e0b6d6@oracle.com>
Date: Wed, 30 Oct 2024 10:00:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: generic/366: add a new test case to verify if
 certain fio load will hang the filesystem
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20241028233525.30973-1-wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20241028233525.30973-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0214.apcprd04.prod.outlook.com
 (2603:1096:4:187::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: e70a8bfa-a5fc-4cb1-e80a-08dcf886b094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mkt4U1pVa1E4U2Fsa0pDUVZ3cmNhTTJxV0FRdXhadDZQVU4rYWdrNUdnNWhG?=
 =?utf-8?B?RDQvNFhVREdDMTk2Y1JiTjhWVXpXZHBNSFdYbGZmdmJRd29uWHowSzhJeUM5?=
 =?utf-8?B?LzFXbUNnVEFwL0FMRUtId3NWZTU1MXlSQ0lLU1p0NmVjcTErckN1cDFxeVJD?=
 =?utf-8?B?VWFJWWg0RlV3MEI2NW4xWm54THVuWWxlY3dRUUZUN2pJNVNIKyt4Yk1YZWxQ?=
 =?utf-8?B?NGR5Y1ZCR3VvcmNvNFRNMWRvOWdwVVlKbGZsTkdoT3ppdGpOMC9SbWIybVhy?=
 =?utf-8?B?dXA3MTRVclpvamc0VVBHN3AwVHVxMjVaQ3d5cG9WVzhHejF1YzV4SlphNGRN?=
 =?utf-8?B?aDB4VXo4cGtnbTJrb1oxSkpmVzRhUGZ0eWZxOVJGa0p3ZEYrR1NmVEs2dnlk?=
 =?utf-8?B?dlFzMURlSFFFYSs0VEFkOStCNEZrcHFwN00xNlNNZURKeS8vWUNBTW5kWkh1?=
 =?utf-8?B?V2NJRjF5SHBIV3VjNEMyeldlTmhSNmVNKzZiMzhEekQ4eVV1aE1WQzJ0QmNt?=
 =?utf-8?B?MmI2WjFTN2kwZzVGY3p0U1lyN25GRmFiMXFxT0p4WXcxRytBWC8yditDS0xq?=
 =?utf-8?B?SlBydFBjK0dyYjlRc1kzeVlScHdlcEhDRzEwL0FHL2p0VWllQXVXTXVnVldI?=
 =?utf-8?B?a0lWajdUNWc0cUdYYkd2dm9uQU83UHBJUVJONDBzbHhTNWR4blJ1WmFwRTND?=
 =?utf-8?B?N3ZUY293V2lHUkIwOXZTWHh3d3UrNGhBWlFmTjg4S2krbEgrcE9leG9IMnZL?=
 =?utf-8?B?UENVdVBxWVJxV2xnRjFpRklHSzhwekozL2QzbDlVenFWWWJzelZtcHdROVpp?=
 =?utf-8?B?Z01SUVg2d05xSDJva0dZS3VLemJTR0NwdTJmc2dMNmIva1V5K2FIRldBQnJi?=
 =?utf-8?B?c2xsaVJDVnVtOFJiekxhYWtYM1RqbHFzbFNMbmdzWVdDc2hQZ1JtTktrR3RE?=
 =?utf-8?B?TXZhMUlFQk5jTE9xS0llYTk2d3gwamFRTC9ScUdrNGQ1cVl2eG50QUZML1VC?=
 =?utf-8?B?bGtYNTcrRkozcXcrc0RmTGlGU3R4TDlLQ3pKaDdkTENoZ3BMUG9Kc2prT1M3?=
 =?utf-8?B?YzB1YTBvbm01MzhGTkVJaFdKUjF5MzBTSTBRNzFpbXM2L3YxRGhzbG5XNmVU?=
 =?utf-8?B?MW9UNFFnMUkrcHhCaFlGMUdZNm9raHV0TDF1Y0tWTE5aZkppemUyN3JkNHBS?=
 =?utf-8?B?UnM2TmVLNm53Z1YvWTVjZDViR3Y3M2JWSWIzODAwZzlQVEJqSjF2akhGZ0cv?=
 =?utf-8?B?SlJTczdJU0g0ODZETWk1d2FDczJXeXNIb3lwdEhQRWZ1V0RvY3pqZzU0NlVi?=
 =?utf-8?B?ZHM4SE9hNTFDa1FKS0FvM0JYY3ljS1gwNTJjdVBXUzNXQS9uM2NBNkpZRGkw?=
 =?utf-8?B?bzlyd3FRYlR6UFNGM1UvaEMrazByTnc3bmkzOFg0d1JUZW1DQ2lzTXpaQmEy?=
 =?utf-8?B?aHZmbkErMHROSUFoNlJKTWFhd0NDYlRGMlFXN2taQW9FNnpDTXJESkhIL09j?=
 =?utf-8?B?Nk5KS2dsUy95Y205dS9pcnBrTmdjdkNsNEZLQmZaQmpUaGhBbjBESW5VMzM5?=
 =?utf-8?B?b0hHYStadXlwR3dnRHNhVkZrVVlsWEpTaW1ZbDM4bGdBSC9HZWJMOFhpZThO?=
 =?utf-8?B?Y2RLOC9GbGpOcXpwZG9nNVNuQm1nQ0Z3VnVkM242QWI4ZkdUTjhrK1YvSGFh?=
 =?utf-8?B?cHF0NDFrQXVMTzRtMHJYN09zb0JkZUxJV3VaVE44WlUzRW5YNUkvN1MvazNJ?=
 =?utf-8?Q?t+RpSI3ExtDz8dAnKGOaB273DYwI6EG2EmNM/lh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHVlcllCR0NvSlNDcWkzcWhwL1FHSzdnTmZrTWFRaHpYMjZmbXJ2YkhrcEVi?=
 =?utf-8?B?cENMMjlUU1Z2aDNKYjZPOUxCMnZtaFRGNjkxRUp6WGZFYndKVmQ3c1JyWWhB?=
 =?utf-8?B?OCtzM0JJdkhUb0V2cDZoa3ZzQmxMd0dES2w3VW4wN3Q1d3c1RFF0WU5lQnV6?=
 =?utf-8?B?RjdnV3VUVGZJekltRWNVSjJkY3BwNTBLdnZiTTQyNEFSWjdYTktvYkJjZmpI?=
 =?utf-8?B?T3ZScmd4V1c0U0IzSlpIWTR1VXJrTFV1WVZVZlZUSk90K0tHWldJKytuM1dO?=
 =?utf-8?B?RHRpekpXTGNidUNzOUl2V2s2WENhVzVqT01ySmYwNXBXZlBjVCtrdnlZL01i?=
 =?utf-8?B?am5zQnRNTEs2UzFtaFYwRjNkVEZJaFVqcTRzcnkwSGpUVWFCdC9BbmYybVBx?=
 =?utf-8?B?cVZKOTlSeEJ2dnFzQ0lVVHR1TXdMVElyTmxVRTc1MUN0cFZWOWR1TU9zWlZI?=
 =?utf-8?B?VjV0WDQzcnFpRWhVMldZSXhXL3pLZ2trN3RtNUgrZVlubWMvUS9yc1BYRm53?=
 =?utf-8?B?N2dKVmNzVFFTcTYvTnk0Zm5rUFJEMlNlc1N5VHNvTkNWVFlmL3hyYTh3aWZ6?=
 =?utf-8?B?c0p1cWFkdVJHM2JLMXBiaGxwNTNIQm1ZeTdsbmxnUUZldGpjSTR3NXlYYnVP?=
 =?utf-8?B?UFZBdDRNUUlmckpTcklnQTFpdStoWWFTVjFtNDhQZVp5NzNZM0dzREdSazJJ?=
 =?utf-8?B?d1gvMmdtNlM0Um5uSElGbjdSays3SkRiZFZRYlNBRG9Qa2cvOWpRVDNibHNH?=
 =?utf-8?B?Q004Njl1WFMxWXVaV2xIeVhHSk15NVNid0pYQW9aVGluczVOclFpQ0hTYmJa?=
 =?utf-8?B?YzNHZm8zWDhZWkRrcDZEd2NrcUxPNlJyVTB4Q1FPY2pjTFppUnVYNjBqWDVX?=
 =?utf-8?B?YXJ4S1NTa1AxU0FWZGNpeXVJZzIzUWdpZHdQeUx6WG1kbWsrQnJxeHROSHF4?=
 =?utf-8?B?cGdneDBMU1lUSUtJUEcwblYyU3VMcE5qbTVza2FjR3RqZUFSRFJDeGgyOVpI?=
 =?utf-8?B?bkN1RWtYZndHRzZIQThlV1JUVzc3ZmRmdzlkbG8rWWk1RHE4MW5xTmFMaDk2?=
 =?utf-8?B?TitXV04vU3RKRHhxVTNsVTdmZGIyeHA1Q1dxNVVpZXNGVEhYS0ViODFXamw0?=
 =?utf-8?B?Z1p3SGphZCsrdkZLU2M0YStQdm1BUHhMYURXbnJPc1cwcmNSUTJYQmZSMHB3?=
 =?utf-8?B?cjl5SVZLSVhITUNDUkVNTS9XRVk4TDdmbnl6ZE4wYXQyajRJbXJUUGJKa04z?=
 =?utf-8?B?b1VwdHkrWDVXOEdnZzM2TmIrdU9temRXd3llUW1kSFRPUUJXbFFLRER4ZHky?=
 =?utf-8?B?Q0FDWUlkcjVVbXNkUnE3UFBmUFlmT0NJNkpEdXhwS0VUbEExclVtWWY1Y1Uy?=
 =?utf-8?B?T0t4TU5wVDFXZThNRWV2WG0vcFcwTVM5cEEyY2gvRjk0aFIrVWFyNjJTaXNU?=
 =?utf-8?B?ay9vVlliYWpTajBEVkxFOGpwRHk4UjkwQmlwYzRRbjhnZ29Wb0p1cDBhOVJO?=
 =?utf-8?B?NVBEVW9CZFlTQ2lHQ0V4Q0FnTkU4cnZSY3FEbUl1RWNhNytVTmJqQ1lCelQ2?=
 =?utf-8?B?Y0x4NTlreDNvNE9ZSU5aN0RiRzZuZTJvZjQ5d2hCWDdKN3AyVkgyUUNNTnJr?=
 =?utf-8?B?ZkdUWU5aT1Y2Uk13ZW5PVXlPbGFHREZnR3FOU2NsTVNJdG00QmNjUzZUNjRr?=
 =?utf-8?B?T0ttdHF6TDE1NENWVTRjU3BlSTJyeWhoZzl0M1YvSmtqbFdFeC9DS0VTaW5E?=
 =?utf-8?B?WWtQTndHRmdwZlVSd1FhdzMxd1VJekVIZVpCUzNrUlJyTHJnZ2ErTnBpUlFm?=
 =?utf-8?B?RXpXVTFzeFNDdExCMUZ3YTZEcUQvY2sya3I0T2hONjdYR0h2MUJ5T3UrSnl2?=
 =?utf-8?B?ZWs4Y25ORHduS3BnQ2RJRFZCQ0FUMFJzcUJOQXJZTDYzdlZObDh4R3hHZlJQ?=
 =?utf-8?B?dnVYeU15WjZ2QVdMQjhabGhRREVEV0JGZWNyTVlnZEJYVTZ2VDRvQkR2aFdC?=
 =?utf-8?B?YXJpZFNVdVRaNkRDZlVqa0QwQkRmMEFtNWNIckZzeE9IeXhuT3REQy9WMWRU?=
 =?utf-8?B?WjhmcUkyTDlTbnpwdzE1UG94eXYweG10enZJNXE1RmNZSmUvcEZTTzVUTkY2?=
 =?utf-8?Q?4Ds9KwpswJSAs8d95aDmfT73U?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Sqpka7BkYo1UKjHv1l4EhQ9AiZ5wgSGii2TbKPbb0u/DZCRceYQDmtc4eletO9c0IjboYsFZ8HGIUXPo9l+sGZsQU4GPleIdF4wwTiwWFzKvAaMtUiR9UfPTz3GpG692JxKQVkGYCjJZY88fyzy6qe5beZEgvAabW+23DVt/Cb9e2GyTacyIdJv3Fy+qneMVrRktHTGDK7S32APMV8HIAaNkHXQ798ei3a6r87Hw7IDalDPy38AkcdAO37sJsY1L8kF3bIp56jh3xpIzWo8snKD81awM5peFeXT7re8CEkq7IMVbThC99syoExuhek9ierBs6fUEBrktJcHtdz0MBrUNybkb78QmCJNS+Na9EshekwhG7MkuSDXroogy9DKbesvbHA0JlZRKRqvpTYlaaKMkfWNgoh6G2R11apuS4oPCT163ZE8nftWfgWJpDtm5TqfQwbSuIR7dD3naViYIdKwnoCPL0jy0Xjr+VPWzJNbYxvmsLsS8jF80xxyrPCfdwNvL5FDJVbvV8ZvIMI+OZ3miDQqUMcFa+2Qih1ITSuEAKvHN4xyqe0CxYlc3ghas1dCimUKwZBPVlrWlXn2o21EnyyDW9JZrBpk1wMl1CbI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70a8bfa-a5fc-4cb1-e80a-08dcf886b094
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 02:00:55.4566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBcoH3sWMBHVLmylre2xj6xuEmi3Lf+feVFT8bcybzfOhk/9ABcvUGNlWUSjSdZALUlZpts93xlD2D95kG9RLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_20,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410300014
X-Proofpoint-ORIG-GUID: 3TufwCIrJNGT-aR9ts0H_pGl2EftFtY-
X-Proofpoint-GUID: 3TufwCIrJNGT-aR9ts0H_pGl2EftFtY-

On 29/10/24 07:35, Qu Wenruo wrote:
> [BUG]
> During the development to make btrfs pass generic/563 (which needs to
> make btrfs to support partial folios), generic/095 causes hangs
> during tests.
> 
> The call trace for the hanging process looks like this:
> 
>    __switch_to+0xf8/0x168
>    __schedule+0x328/0x8a8
>    schedule+0x54/0x140
>    io_schedule+0x44/0x68
>    folio_wait_bit_common+0x198/0x3f8
>    __folio_lock+0x24/0x40
>    extent_write_cache_pages+0x2e0/0x4c0 [btrfs]
>    btrfs_writepages+0x94/0x158 [btrfs]
>    do_writepages+0x74/0x190
>    filemap_fdatawrite_wbc+0x88/0xc8
>    __filemap_fdatawrite_range+0x6c/0xa8
>    filemap_fdatawrite_range+0x1c/0x30
>    btrfs_start_ordered_extent+0x264/0x2e0 [btrfs]
>    btrfs_lock_and_flush_ordered_range+0x8c/0x160 [btrfs]
>    __get_extent_map+0xa0/0x220 [btrfs]
>    btrfs_do_readpage+0x1bc/0x5d8 [btrfs]
>    btrfs_read_folio+0x50/0xa0 [btrfs]
>    filemap_read_folio+0x54/0x110
>    filemap_update_page+0x2e0/0x3b8
>    filemap_get_pages+0x228/0x4d8
>    filemap_read+0x11c/0x3b8
>    btrfs_file_read_iter+0x74/0x90 [btrfs]
>    new_sync_read+0xd0/0x1d0
>    vfs_read+0x1a0/0x1f0
> 
> [CAUSE]
> The root cause is a btrfs specific behavior that during a folio read, we
> can trigger writeback of the same folio, which will try to lock the same
> folio already locked by the read process.
> 
> The fix is already sent to the mailing list:
> https://lore.kernel.org/linux-btrfs/62bf73ada7be2888d45a787c2b6fd252103a5d25.1729725088.git.wqu@suse.com/
> 
> This problem can only happen if all the following conditions are met:
> 
> - The sector size of btrfs is smaller than page size
>    To have partial uptodate folios.
> 
> - Btrfs won't read the full folio if buffered write is block aligned
>    This is done by the not yet merged patch:
>    https://lore.kernel.org/linux-btrfs/ac2639ec4e9ac176d33e95ef7ecf008fa6be5461.1727833878.git.wqu@suse.com/
> 
> [TEST CASE]
> During the debugging of that generic/095 hang, I extracted a minimal
> reproducer which is much smaller and faster, although it still requires
> several runs to trigger a hang.
> 
> The test case will run the fio workload 32 times by default, which is
> more than enough to trigger the hang.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix the duplicated _fixed_by_kernel_commit line
> - Fix a typo in the commit message
> - Update the comments to show the workload and how it hangs btrfs
> ---
>   tests/generic/366     | 106 ++++++++++++++++++++++++++++++++++++++++++
>   tests/generic/366.out |   2 +
>   2 files changed, 108 insertions(+)
>   create mode 100755 tests/generic/366
>   create mode 100644 tests/generic/366.out
> 
> diff --git a/tests/generic/366 b/tests/generic/366
> new file mode 100755
> index 00000000..9d31c1c8
> --- /dev/null
> +++ b/tests/generic/366
> @@ -0,0 +1,106 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 366
> +#
> +# Test if mixed direct read, direct write and buffered write on the same file will
> +# hang the filesystem.
> +#
> +# This is exposed by an incoming btrfs feature, which allows a folio to be
> +# partial uptodate if the buffered write range is block aligned but not yet
> +# full folio aligned.
> +#
> +# Such behavior makes btrfs to hang reliably under generic/095.
> +# This is the extracted minimal reproducer for 4k block size and 64K page size.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +. ./common/filter
> +
> +_require_scratch
> +_require_odirect
> +_require_aio
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: avoid deadlock when reading a partial uptodate folio"
> +
> +iterations=$((32 * LOAD_FACTOR))
> +
> +fio_config=$tmp.fio
> +fio_out=$tmp.fio.out
> +blksz=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
> +cat >$fio_config <<EOF
> +[global]
> +bs=8k
> +iodepth=1
> +randrepeat=1
> +size=256k
> +directory=$SCRATCH_MNT
> +numjobs=1
> +[job1]
> +ioengine=sync
> +bs=512
> +direct=1
> +rw=randread
> +filename=file1
> +[job2]
> +ioengine=libaio
> +rw=randwrite
> +direct=1
> +filename=file1
> +[job3]
> +ioengine=posixaio
> +rw=randwrite
> +filename=file1
> +EOF
> +_require_fio $fio_config
> +
> +for (( i = 0; i < $iterations; i++)); do
> +	_scratch_mkfs >>$seqres.full 2>&1
> +	_scratch_mount
> +	# There's a known EIO failure to report collisions between directio and buffered
> +	# writes to userspace, refer to upstream linux 5a9d929d6e13. So ignore EIO error
> +	# at here.
> +	#
> +	# And for btrfs if sector size < page size, if we have a partial
> +	# uptodate folio caused by a buffered write, e.g:
> +	#
> +	#    0          16K         32K          48K         64K
> +	#    |                                   |///////////|
> +	#					     \- sector Uptodate|Dirty
> +	#
> +	# Then writeback happens and finished, but btrfs' ordered extent not
> +	# yet finished.
> +	# In that case, the folio can be released from the page cache (since
> +	# the folio is not under IO/lock).
> +	#
> +	# Then new buffered writes into the folio happened, re-dirty the folio:
> +	#   0          16K         32K          48K         64K
> +	#   |//////////|                        |///////////|
> +	#      \- sector Uptodate|Dirty              \- No sector flags
> +	#                                               extent map PINNED
> +	#                                               OE still here
> +	#
> +	# Now read is triggered on that folio.
> +	# Btrfs will need to wait for any existing ordered extents in the folio range,
> +	# that wait will also trigger writeback if the folio is dirty.
> +	# That writeback will happen for range [48K, 64K), but since the whole folio
> +	# is locked for read, writeback will also try to lock the same folio, causing
> +	# a deadlock.
> +	$FIO_PROG $fio_config --ignore_error=,EIO --output=$fio_out
> +	# umount before checking dmesg in case umount triggers any WARNING or Oops
> +	_scratch_unmount
> +
> +	_check_dmesg _filter_aiodio_dmesg
> +
> +	echo "=== fio $i/$iterations ===" >> $seqres.full
> +	cat $fio_out >> $seqres.full
> +done
> +
> +echo "Silence is golden"
> +

Thanks!

Reviewed-by: Anand Jain <anand.jain@oracle.com>





> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/366.out b/tests/generic/366.out
> new file mode 100644
> index 00000000..1fe90e06
> --- /dev/null
> +++ b/tests/generic/366.out
> @@ -0,0 +1,2 @@
> +QA output created by 366
> +Silence is golden


