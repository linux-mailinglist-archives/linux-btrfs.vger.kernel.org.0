Return-Path: <linux-btrfs+bounces-12523-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB99A6EC19
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 10:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B715716C29F
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 09:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7406E1EA7F5;
	Tue, 25 Mar 2025 09:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LnhyMxnb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U90ZBxu+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0185C2F5B;
	Tue, 25 Mar 2025 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893455; cv=fail; b=udJJaO900OtQRTnfO+WdtehvSKT/o1R5qMSigE8sOtuq4w976tb+9KtGEBqg2N+p7f+4p8trvbBAXx2OBE0KggWGvFFP6cyl0e51Ge1sNYju4pv9U5zmmC/NLCLhL4N/dQVzD+rZPzElpx6TBlcUy/PxbNgAJTa63S3U3UMZ70g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893455; c=relaxed/simple;
	bh=gAPzgWlL401PX44WcyypIAFWx5it31lJO7tEpdWfG98=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JAenNHNol/RQRlnBlf0GCX4nTYlStryFFrwP05aicmzPYbiCScnHaAOQxLw1hGKhVskzilZacjw7cikj+JGNIaCTGimExeidpOu2R3M8F2v9hiT5RUKz+xVjX6ekCCnuGbGLzJHFRoQcbAECZhd/arFeKC5vRo46MHr4NlcHNIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LnhyMxnb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U90ZBxu+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P2txw6030297;
	Tue, 25 Mar 2025 09:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=61N4gutgNh1tPn+YBwe5hrGra4I7THiTJBPiAPMWLKE=; b=
	LnhyMxnbDr2zWqIgSk1+MP9NKFnFyGZvpvSq/aM+EfPREf+WigyrUyQP85bS2fgj
	HrBVcdtvAiGRpPVGn5Goru/SUNaVR2YrP/LiY/pMCS70ukBSxEEjdUEV+4r8fW+S
	YKzhA6SZaxHLWYCM8uAiaSULsN6IxKZHo7uDZJzbUwY7MtNEhBPdXXRmlmCzTIF+
	cEf4fc96DOUhc9lKi3qle5ioMUPACLVPrxjn5p0tb96RWtntTn5lsyKjJIt6PER5
	esKLwujsOWWRVXTNLeaCIhBfq6hYo5CoXuEosLSDyxxnjr4iy3bCiuEcw/oy6q6A
	TRZfRHBnVls19W0D2XG4Ow==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn86xcd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 09:04:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52P8bimn022906;
	Tue, 25 Mar 2025 09:04:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jjcda7s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 09:04:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExWR1l3N8/jK6tbRLBdcgtCl+L7WH3NCMLnw3jyoNkG0Uw8WYKtiq5SqIbqSHxYFtIoudCDHmq0vmKbpRLH4kGwhkX2la7jUT5sG4bRbV70/iTlYZdOwqstWChBycw2SQOXao/lPW2ZMzSuZw3G58vSCx9xytH4jrryU5L9OFxsAkC1so4skqTpmkC8Cn51DC8Wl60GWk/+8Cza37QYapnIm20op2PLOOWU5ufHIWEHb5501Bfje293wws0V/Xn0Zs6avvLrfkgV11Mgkb6KWNQJqySbYWrMP3NTQSYO9J2GkAZ+R8fFXcDd3zxwCOXyuZhhXdEyCTN9MhDObkr8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61N4gutgNh1tPn+YBwe5hrGra4I7THiTJBPiAPMWLKE=;
 b=mKecfq7nnTDj3oevn5TDrpMGv/cJusnLCycGJaxdXppPHuNNPOF9onS4SWPGEJrPC3Z3qdfPjpBHsDiDAov0rZH+zra7TlKkvHESs2nxEhC3h+FVPsgZhwrfWeAeOPBKVFyeYSOha9cG/pmkB95tFqub8h0B8QnOH6xbudPEsfrWOZQFW80w+Vumpk2lZgTpl+zEjwtQlz822kwjj3i3m33u60VLyDUe4sY4G98v7GZucRYLj9ZBQJF3a1n4IXJVKx7tjkwOhZj//1WzkzYx4m6JAcD+1H717s7QpZwgQJcQYHS2E4v9aXWY7/mLHga/AZsJGGUbpz0bZYYyDrD1ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61N4gutgNh1tPn+YBwe5hrGra4I7THiTJBPiAPMWLKE=;
 b=U90ZBxu+qYtCjvNFCk7/xNm2XvJ2SkwPCi0qu6RaTh85oWRYj5JvBheGr4kwzlzZfuOqxe372HTQiIvhoeRIvJZRKGxd3s8+2ZQS3mU/Q9ANxMoD/RDKa28vXv3iaNyk9aG9UXISTUp4E7EklVJt7BzQAinSs4uW047NLbMTvsk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB8152.namprd10.prod.outlook.com (2603:10b6:8:1fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 09:04:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 09:04:00 +0000
Message-ID: <1302dc1f-ab5e-4f7b-8338-3ce806717c08@oracle.com>
Date: Tue, 25 Mar 2025 17:03:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/058: fix test to actually have an open tmpfile
 during the send operation
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <f2f3902ab7603f82751a9729cc8f1b406c5cbf98.1742386250.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <f2f3902ab7603f82751a9729cc8f1b406c5cbf98.1742386250.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: bddbbe26-bbb0-43b5-b20e-08dd6b7bfbab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czBYc3N1WjlWZGMrQkJGMlpvMkwvVWV3UGM4WEtxT04vUnRteU5OVk52L1Ey?=
 =?utf-8?B?b2hwQzAzRGUzR0tFc2Z6RkhlcUFyTFJNSVRpN0JPaGFSdGUwZndQUzNzK053?=
 =?utf-8?B?OWJYVXY5QlRybUpBTUM2STFrWjlVdENUN2FMeGpJTVBZVjRxZmpUN3d0TE43?=
 =?utf-8?B?Wm83RVJkZ00rMFFlWGkxV2pHelJqd0tSOGtCSXpXdlZQQk1sR05LaTV5TGlO?=
 =?utf-8?B?SGZiS3N5R0FDRzdSV214YTZUeTBOZS9JT2NUMTNwSXI3Qk9EQ2x5aW1Sd211?=
 =?utf-8?B?VHNDZEI2UU90MFM4clBIVGNsbUpXQi93V1RSWnNHOFZ5bFMrSnJoc1dzWEI2?=
 =?utf-8?B?WG44c0NtVC93eGM1ZDlFbUhqRG9HeFQyV3NYUDE2RW9TclRycjEvMkQyZGhF?=
 =?utf-8?B?Mis4eWxLc0RCdW5yai9JakFPdDRvWkFzMTRWMzBYS1lDbWxSaVNML2M1d2o4?=
 =?utf-8?B?QVRYbWhybjRmZDNVM1BSSWxQKysyMWYrTWtHcXJWNFpPa3ErVm00UFN5aTFp?=
 =?utf-8?B?UDBvUUFPR3RZd2F1ZnNsNzJoUWk2R3JubjhqZ3lKcG1SNFNpb1J3TFhZeUpp?=
 =?utf-8?B?UGRucnl6NFBYYWdVTjVjbmFDMFNLWFU4dmpzVkpLS0N0cDQyRW14N1dXRTdC?=
 =?utf-8?B?alhzeldQWHgyUTFCTHY1TlBnVGtRd1RFekVkYTFvOTh6YW5IbVVZS0tyQitZ?=
 =?utf-8?B?T3NyeHM2UlRrWVoyMHhBcDJrVG5nS3RCektRcFpYZUV2a1hVdktYTFF3TVFh?=
 =?utf-8?B?Qk9pOGszWHFyM3Y2Z3I5V1ZidTBiSnpLYTE2eWxTOVBwWHMycm94NzBUMFd4?=
 =?utf-8?B?R0RHaEpLM2N6c3h0Ynp5elp4SWYxclRQTCtLV2hrZXgrWkFIS2JLdDNlYlpV?=
 =?utf-8?B?RUxzcFpDaktndVZoMWx3Zmh0MkNINFU2ZXg5MmZwbG5TTEZ1QVRsOXJJTVpZ?=
 =?utf-8?B?RzZwN2xvcDRQNjkyakZydkNGYTdLQU1maUFTRXowMUsxUnhLZDM3S3FKais2?=
 =?utf-8?B?QkhFNWZBUEw3WlRLTDhXMDVTUXp2aSt3ZXl3enFmZndYNXJsbDdnNUI1ZERt?=
 =?utf-8?B?NmZnUXlvK2hyMjVkMGYwdCtBem5idFNPd1diZmxpbWlSWDVjOUU5MXFQWldM?=
 =?utf-8?B?Z1NUeWJhVVZ0cTVybndJOVoxZnliTXhuNWl6WnAyY2JYL21BakkzQ0VFeDkv?=
 =?utf-8?B?Sm9yUzVqdXVydWZ6RitpN2lENWN3eWoyaEZFUURyeDFCUG5QbXBvM2l6N0o3?=
 =?utf-8?B?MllxanVHNXpQZWJuVXVtRkI5dnF6T0tlVlE4YWlYeEJWeXFrZnh6QzE5QTVG?=
 =?utf-8?B?RHVFWC85VGx3MTJZL2kwNFhvN3k5U3RKd0NJb2dyUDFmS1BxdFFqc25qdS9S?=
 =?utf-8?B?S0pXdG9jUUlOOHJ3SDRVYkRuOHhkaEt1d3FQK1JvSmNGUkhMWE0yeGphTDJo?=
 =?utf-8?B?clRiaEZtYWRmcm5Hb2o2VVJ0cVFvNlRPTndNbnFNRzNLR3hZanRlTzFGNnV6?=
 =?utf-8?B?MjVqMTdGcnpoQTFuQjNzYk1sZHo0d2pVeDVlQXFrS2tkZ0k3b1hGKy84VDRs?=
 =?utf-8?B?dVZickVyVHdzTURBbUZIMkpoUTVDQjFldDl3ZUlPdkVFdU5rSm40Sjczem1o?=
 =?utf-8?B?a3JTbzhXeVM3WDJaN005RE9CZk4rc3AzaDF0K291MlJNaGtBa2lGdVh0Lzc4?=
 =?utf-8?B?ZmJwaWZIZHVUZE51UzhLZmtlcklmT25LZmx6MjRkMVlheHl4b1BtWXFoaG1N?=
 =?utf-8?B?K2tpTFQ3RGFKZTNZMXpyVy81SzN0dE9XbTE1ZnJEU3VEV0o0OHA2M0RRMjFE?=
 =?utf-8?B?NXVEQkhndVNrb2c4dmJRbkYvUWoxdTVRSnc0T3oraWZaRkkzRGJKSUsrenFj?=
 =?utf-8?Q?ugKbHEMQh/Tqt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlN3RzNQT0l1RnZ0emJ4MVBjUVZHMTJoMVNoNW5GSjA5Tk1DcmxISkkrOHdy?=
 =?utf-8?B?aVVkektxUlVXL3ZaaW9SWW9aUnZmeUNPdWxhb2lHcWpJOWxPZ3hFUkhzWnpj?=
 =?utf-8?B?S21QQU83aFVJeG9wMzNla0hVMXZNYktUam14eWVDMnBiOVZmQ1BLOS9lOU5w?=
 =?utf-8?B?UytwNGs0Q1RvOHBpVGUwMUZlWDlYMk8vQU82WlRZZHdIVjVDT0d0ZzVyQjFX?=
 =?utf-8?B?aU9wc3NBQWR6WnBzZG1JL2d5V1R1UFhuY0lUSjhMbWhlOW9QcTdRZHlId2Jw?=
 =?utf-8?B?ZjFkdk4rTFV0QXdRS3JUOTdHWXUvTXlnTmFwYUQ5MHpHeFA0cHhaNk5tUS8v?=
 =?utf-8?B?eGNSaFRkditYNmpkVU95QmNOWHFZMStLM0tyZ1h6S1BkSDBIMGRPaDFUNVJs?=
 =?utf-8?B?c1NRRnpjWGZ2UVpac3cvQWUrSk1qRW04a2wrQkxLSk04NjZtUjErVzM0eVg0?=
 =?utf-8?B?WjVPc2QxQlNSbEs5dmh1eXphYm12SXVZT0F1NnBSSU0rR3NJU1NmL3M3MlIv?=
 =?utf-8?B?LzNURUFSdFJKQzdWREJsd3NkY3JkRW12SGVWRi95MUdWeUFFMGZBOG5nRWdU?=
 =?utf-8?B?UzFnakQwZHJoN25rd1hvMWV1UzBsU1htK242dkc5RGY1U1ZiY2xPQm5iU0Z1?=
 =?utf-8?B?SWNJY1hiYVpHNkxTb1RPZWFVSjJYeHJYQmdvdEJJNjJSZzVua0JhQkowaE51?=
 =?utf-8?B?UUxwTkhwZ2gzVU5iR0xYdm55OHAwT0I4eHRYT3ViSXBaVk04bWYrTGtNckN0?=
 =?utf-8?B?Mk9keG1nRVlTNnZoVURDVzY3UE92bU1EQW4vMmtpWEVFWXRaTG5rT0xyNjJy?=
 =?utf-8?B?djRlYkRQK0Y5VkphOERSYzlKaVZsUVlDOEJSN3Brd2xMdk1lZ2FVOVg2dnpL?=
 =?utf-8?B?L2JVQnZUNFBmL3llanh0SXRMTjBLYmdWQW9MRzhCTllQd0xWOWNFOXY4L2Yy?=
 =?utf-8?B?azFWcll6OElNUlkrU096dkxSbVZxMUpSRnFJSUpmaGRXQnhMTFllbUZzUGtu?=
 =?utf-8?B?WEwyc2NrZ1Vka1lSRlVxaGJ0RzJmUk9UeDhwRVk3ZkxQbUtQZ3RMdC9tYVl6?=
 =?utf-8?B?MThUc1YwOXV6aURETFhkYUcwU0NadytQbExzdmh5cjJVd1NRd3psbEVhNG5q?=
 =?utf-8?B?b1ZqMExEOUoxRUVMRTNRb1hxZDZVSVIzOFVzcFluR1BiWmZ4VTk1eGRpSmlX?=
 =?utf-8?B?OUROcko2NWp1bTRpK2xuUkxBb09mMC82ajMxdDFyNzBoMFRuNDV5VUVneGFL?=
 =?utf-8?B?Y1FtMStERGRZdXJqWXREYUxYWGpBQW93V3Y5RlNycnlwUWgrSXkxZnBUeUNa?=
 =?utf-8?B?MDhqbGtjcmtyNGdFYlVzRjVISHhQNFA1RkR2WWpvMmpxRnJKcEliNkJVVEhO?=
 =?utf-8?B?YWhXUmRRaGxjYURxVmRCcE5Kdy83T05FUXRkZXRIQzFJMnlVdExGNzNLZFp3?=
 =?utf-8?B?VExIckRaZ2J0d0dKUDJHajEyZE81ZndRd29YYVJHWjRyMXJWdGxhTG95d2RK?=
 =?utf-8?B?TDJHa3FOeVdJUHV3M2hiLzBnaW53SStuMVBnSHY2a2xYWlMyekhodjByWi9M?=
 =?utf-8?B?WFBFMjZSY3VCZWFVUEZFY3IxQnNpOVFJZndVdFplMVRMTXptdExYTTl1TDBu?=
 =?utf-8?B?K2xZbUdIeU1YRmZNdlY2SEhjOXlKMnBESUpXcUhJeU91WjhON0JIMVd6cFZi?=
 =?utf-8?B?MjlDV0dHZ1U0ZGxoY1J4Zm1RZ3lxck5pU1A5VlRDWmptNjBXTzJlUlFkYzdK?=
 =?utf-8?B?UVUvQmRiNWdodkZoc01VSml1UnVLRCtHRklIZzVnaGliZG9NRlZQN0hQWG9l?=
 =?utf-8?B?eE0zV2ZCSTBMdTdNelZYRjg1WHJNam1XZkoyVjZXTHo3dXJJdGFFNFQ0UHpW?=
 =?utf-8?B?RWwxaGp3YUxHaDdTVkhuR3BLeEhiVDgxYkNha3Yxb3JMZEN1OVQzcWlmVTN5?=
 =?utf-8?B?bWxzL01QZ0swdFJta1V4dkNIZ05PanhmNzZrVlNhMU9sUElVMFNRNFJTVzFX?=
 =?utf-8?B?MlJTTDB1VXFpSnJJNlBKbStLSjdRbXBLMTlnM0xCZVlxeE50Mjc3OWlpRCt2?=
 =?utf-8?B?QTlTVXRkeFhtQUZYRDErRDNjeTJPT3lvckhraUFEQXNkL2ZNVXFmZVF4WGlU?=
 =?utf-8?Q?68G3PDahQMyCliA+dyk5MhaS0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2wPF/uBd4QLQAxSNMVu8BKgL1c01Tqgr5xZ/maJlDzHxoeVKbi8pEFbIlMZdhaHK2TsWeVarf2FbdhWJlEdV+AdJ18kaBLIuEJYjH7bOn8K2C1s3ejcYrsyjfAcVIHmm3BqG7BfBjv71GkyYUzdSETulpuz3wiH2mPkouer72weO4taco8BsCj0nN91thsway6EAInFHY670AfNwfHBsvEbnqn/ksMVrbh/OFPAdtsC1RKFeOSCtDvZUE17PirzHSX97giDqZn+f5Id7yxoeuIJv4aR6rFWG43SdYd+FV7UpPOiNMP6tody6M2oi2j+bqcwEBHKUDuwFvNqJ/RIKkVr15uqyiT8pr+yovTop3bor3OO2lLZniN1wrC/vDVDfAXhrsgDGO2vhtBhIVgWwUi0dajZv5SqKvhySEgASKTndr+yRoSlkkYOJofEpV2tMTdG0jCoLvzzN3PUzzkV2WRp6ABlWJhkhCPKhYQHvd57Sll9aWW3SiyXsP5rKc4OItXfzNqBz3qMKJp99wYvGb/2WKDiw7ypc3S/tzI4FAJgYqWLIGi9vjWMT2fzyOF6ldEx8NOoNEbCuZ50fg1koWBwybM7pKFvPOuh/5BuLO58=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bddbbe26-bbb0-43b5-b20e-08dd6b7bfbab
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 09:04:00.8054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwIsvh3mOweE08XO9+YdxzjFLlWn4uirSRX6yde7eAuxkQiIoFy1PAFZFnyijNJf7k4FL6Ft/gQK7B6rE8kudQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_03,2025-03-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503250063
X-Proofpoint-GUID: huHQvMYFEufRPyv4QWUnNpFOUswgfCkT
X-Proofpoint-ORIG-GUID: huHQvMYFEufRPyv4QWUnNpFOUswgfCkT

On 19/3/25 20:13, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The test's goal is to exercise a send operation while there's a tmpfile in
> the snapshot, but that doesn't happen since the background xfs_io process
> that created the tmpfile ends up exiting before we create the snapshot, so
> the snapshot nevers gets a tmpfile.
> 
> Fix this by using a different approach, with a fifo and tailing it to the
> stdin of a background xfs_io process and then writing to the fifo to
> create the tmpfile. This keeps the xfs_io process running with the tmpfile
> open while we snapshot and run the send operation.
> 
> While at it also add code to verify we have the tmpfile (an orphan inode
> item) in the snapshot's tree.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Applied to for-next.

Thx.
Anand

> ---
>   tests/btrfs/058 | 28 ++++++++++++++++++++++++----
>   1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/btrfs/058 b/tests/btrfs/058
> index 7bc4af5b..3bb0ed21 100755
> --- a/tests/btrfs/058
> +++ b/tests/btrfs/058
> @@ -21,6 +21,7 @@ _cleanup()
>   {
>   	if [ ! -z $XFS_IO_PID ]; then
>   		kill $XFS_IO_PID > /dev/null 2>&1
> +		wait
>   	fi
>   	rm -fr $tmp
>   }
> @@ -29,18 +30,22 @@ _cleanup()
>   
>   _require_scratch
>   _require_xfs_io_command "-T"
> +_require_mknod
> +_require_btrfs_command inspect-internal dump-tree
>   
>   _scratch_mkfs >/dev/null 2>&1
>   _scratch_mount
>   
> +mkfifo $SCRATCH_MNT/fifo
> +
>   # Create a tmpfile file, write some data to it and leave it open, so that our
>   # main subvolume has an orphan inode item.
> -$XFS_IO_PROG -T $SCRATCH_MNT >>$seqres.full 2>&1 < <(
> -	echo "pwrite 0 65536"
> -	read
> -) &
> +tail -f $SCRATCH_MNT/fifo | $XFS_IO_PROG >>$seqres.full &
>   XFS_IO_PID=$!
>   
> +echo "open -T $SCRATCH_MNT" > $SCRATCH_MNT/fifo
> +echo "pwrite 0 64K" > $SCRATCH_MNT/fifo
> +
>   # Give it some time to the xfs_io process to create the tmpfile.
>   sleep 3
>   
> @@ -48,6 +53,21 @@ sleep 3
>   # The send operation used to fail with -ESTALE due to the presence of the
>   # orphan inode.
>   _btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap
> +
> +snap_id=$(_btrfs_get_subvolid $SCRATCH_MNT mysnap)
> +# Inode numbers are sequential, so our tmpfile's inode number is the number of
> +# the fifo's inode plus 1.
> +ino=$(( $(stat -c %i $SCRATCH_MNT/fifo) + 1 ))
> +
> +# Verify that we indeed have the tmpfile in the snapshot tree.
> +$BTRFS_UTIL_PROG inspect-internal dump-tree -t $snap_id $SCRATCH_DEV | \
> +	grep -q "(ORPHAN ORPHAN_ITEM $ino)"
> +if [ $? -ne 0 ]; then
> +	echo "orphan item for tmpfile not found in the snapshot tree!"
> +	echo -e "snapshot tree dump is:\n"
> +	$BTRFS_UTIL_PROG inspect-internal dump-tree -t $snap_id $SCRATCH_DEV
> +fi
> +
>   _btrfs send -f /dev/null $SCRATCH_MNT/mysnap
>   
>   status=0


