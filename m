Return-Path: <linux-btrfs+bounces-12642-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 071F3A742A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 03:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82ACC176916
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 02:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D3C20E01D;
	Fri, 28 Mar 2025 02:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z01gvQnK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oBGggE4C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2866714A82;
	Fri, 28 Mar 2025 02:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743130549; cv=fail; b=sLnOJ8V2rMnuE2FNN8OUKkKhCbVn2yG6v7mVzEaJKqK/m/xEwiq9RXJD4r2FguXMz/x01TS9zEX/v/HmG3tPC7U1OUTk0Cg+9g9c+7xSI8e+bPGsBcEWlk4wjJxm0Nhhg13bzZWlNgetoMV1QcqvXJ/ZgOGM9Uh2HRaXsvRFw7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743130549; c=relaxed/simple;
	bh=yVDts4KiuqChkJZCoAuzCZo5/tcS9tY/hiXpCxWCSiw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sGFUC6+wtF8peBjELfgrrTbcGQzol1XVFaBjJv/DKuMhTF+jFsoHe02aX6UecZFLjpvC2GFt2bFW7VK7PlX5FJ8hy57Nw3ct8NtWb4wKYOE+z/VYk2ORS0jpzCGHUZitsO6eGWBeRHVvk9Pyyq9eMK2sfzH6R/Ufo4lmUO2JHD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z01gvQnK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oBGggE4C; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S0uE5X029465;
	Fri, 28 Mar 2025 02:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=v2UuIAl5Scqfn/9nbB7MhDXk6ltuajNDUKFmmGMn8cw=; b=
	Z01gvQnK6mCVzlD3ImRHvMMJtyHvTU9gfbeMhZUcQj5PeMi9LOm8h+p8kud+6F7N
	CpoS3nQoZSxzDDq1hbtmOOY+ASO/kQul6TOvKqpohrquk1T6kkiO6nPULDwzMtGv
	2pQnkawspjx2YYGyFD+ILxY6pOsrJ6KSAScY8xLqgdR0DsrOwdRjYCTTXtaDLF1Y
	CMBlF4nu4BUgvqAU5VhQp/DHWHLTfdmK5xxyoWEIEnY5UC47cGfu609QNL672V3e
	fffqs43kmyeCl5O+LLu2DSt9uZtlQJ1VxqhuleJbR1ycnaNvboJx4YEV3rLc2fRc
	ShjwYhrUWmFfpO7vIx1r+Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn7dx1vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 02:55:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52S15Rll023264;
	Fri, 28 Mar 2025 02:55:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jjchfpk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 02:55:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+Kvi16PHGew67L+GOJ2AaoU3/rWCO2xNxls+nTaUYbWjzloA4XM5fb529HIvTDX3KstBvAF8TrA5mVI3WlwNgDJLPn9s2TIpEhFCEXv4eYrImJz8eTm9kMgDPq28dGHTSYqn65yjQBGWOgWVHTHACOVzYaZsWH1ji8S42vfqoOECZjLVQEAGgjPU1Cm77LTa3XrjH9hsdOG8nJydsLnz3HER9zpZnbyzK2uWwfvbUhxQeUcytEuE3LMBqEsKlhST3FWil0ISBHJZZAzSAhSNyxEK9G4B47kxqOPSiC5+SNBz+GgjBGdQDyvFkOVA09XD8Vj7x92vRUzeS6Xmi9FHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2UuIAl5Scqfn/9nbB7MhDXk6ltuajNDUKFmmGMn8cw=;
 b=Y+r30nLohlPp7rP9CfI1nHDywMsMLrJIKzLIdad808dA1h6hUKdkO5EjLH8EKjrOT1Tt6PM+/n9FB6PzsQyQ+RejUIsGTl4E4qOfSPl9/3y76o8dupqAviWVgG3Ci37t64wCnkve/jNM060H7w53g0yFd8k/+z/N5hNkr/Oe2N4dZ/P9Azw60WYd5xKVCytkIvCYmLIYF8GWSmxshYvB+ZBOE4lfcR1xMlq9junZu6jDeox9rYCTXMx9zIuDs7cfzr4UMGq0Bii9qdcCpfbXjYVVCFiKERSAZvURfyRYNVnprY0a63tvq/uSsDAJfm26hb/fsRZWYedsn5Qta6e/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2UuIAl5Scqfn/9nbB7MhDXk6ltuajNDUKFmmGMn8cw=;
 b=oBGggE4ClwpC7VDaf8x4jOJG85/c96YH9f8t8NNAN1S0nYiXrISl052IxgG+52xAXCv/NwmkZ+RbZDdm+7HL2oGlZvbEsHAevhbMMLfII0MkBUbscCFnVZNwJ712wVq0qi7w+DfkQGKuTe1Mv8sQe94FskS/AFdjuVk1ttXRt9U=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7257.namprd10.prod.outlook.com (2603:10b6:610:128::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.27; Fri, 28 Mar
 2025 02:55:40 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 02:55:40 +0000
Message-ID: <e53c9d1e-e747-4dd0-ba3d-4d713cd89c1e@oracle.com>
Date: Fri, 28 Mar 2025 10:55:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] fstests: btrfs: add test case to validate sysfs
 input arguments
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: david@fromorbit.com, djwong@kernel.org, fstests@vger.kernel.org
References: <cover.1740721626.git.anand.jain@oracle.com>
 <945cc1cc-d16f-4dd3-b13a-948e3239dbb3@oracle.com>
Content-Language: en-US
In-Reply-To: <945cc1cc-d16f-4dd3-b13a-948e3239dbb3@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:3:17::26) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: c2124c48-6c25-468b-e370-08dd6da4062d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHBoTUZzZmNTamZwUHljZWhUWnYyYkU2Y2hjMmdZZG5NeHJXeWQ4aDdSK05H?=
 =?utf-8?B?MXR4bDFLZUxPd0tiS2FqVWFyaXU1NXVBbHNyZEpPeElSdFU4RVNCVHhPcHI3?=
 =?utf-8?B?RXNLNXRhVjYzZ0VRRzIwMksvYzRWSEc5Y1NHMUtseXNESWtxRmdJbHBhNllz?=
 =?utf-8?B?a1dNaysraTZJMENjN3J5U2Y5NFBRdFI5M0dyRm96U3pUeFgrVTdUOUFvMFBm?=
 =?utf-8?B?aTJkSk01L2hDb0c3a0luZWJndFdYaXN1ZGpPQWRUd05ja1pMM1lZNEtVR2xJ?=
 =?utf-8?B?SzdoR2V1UE9UWHZBcDhLR3dRR3hZdk8xRVV2U0V4ZjhiRmhtRGpPeWgxa1dy?=
 =?utf-8?B?UDliZXRlWU9pVDZ3YlRraUdGQ2NVZ1Z6SlZsa0g3U1JldW9JUm4xdmdWUk9G?=
 =?utf-8?B?T0tmR0JGQ2JmMlNKZWFmYXhYUHNNTkVHaTZ5MWxvdEtFWFRiOE9yR0I2L1Z2?=
 =?utf-8?B?aWQ2QVNqbkRLcG1ZZW5TUnVSbnFZVEk5WmwxdXVGMnZ1T0krdjJ6bzlyR0p6?=
 =?utf-8?B?dHJLUHdDckFCYlRLSnRUZnFhdWFVV3pJc0pBUnN6Z0dOSS9Yd2U2SktVTVBY?=
 =?utf-8?B?ZkhiRlh5RVREanMybi92KzJSbzU2WFFMVGNZM0tKRmxiNzI3Vm1iNjVCWHJE?=
 =?utf-8?B?N0ZqNFpIZlFBNzBwWjgrTHRsRC84Sk9iRnpnUDlDWjNIenc4RUQ4Mkhid01X?=
 =?utf-8?B?ZTVzZktWTExuVFpKdllOb09zZFVhc2RSYkt4OEZVdTc4cWp1N2pLMS9HOTlM?=
 =?utf-8?B?eGRRaFVqZEowbVhrRVlaRTU0R2R1cy9LczJLNE1qY0J3bWxkRkdWc0ZjMnk0?=
 =?utf-8?B?UzV1SmNmREpOMWhNOHU0QkdDaU9ma1htcmlMYnJLQnhVZG9GOStIb2kzZEFy?=
 =?utf-8?B?eTJ2U1NvTWw3alRzNjZtcUpDakErcUpqcEFIQ1h3MmJaRWxmV1B5a2RTa1RX?=
 =?utf-8?B?NDkyaFhQeUs0NkFURTh1cno1SEJwMXFUS2pDREVWL0YrdHBOTEUzc2RUV0wz?=
 =?utf-8?B?dnp5aXpFN09wODFqMnU2V3ZkT3BPeFpmNVJRSTdNR3BJNjhUeVBlNHl1b05u?=
 =?utf-8?B?K1VJbTJHVXBFWHE4Qm4xYzM3d2M4eEFORHNJdkptVmFYSVl5a3NNMmdSSjZP?=
 =?utf-8?B?N0hqekdqbEdLTzhRZTYrY0pyT3pPZlI5VXZodW8yZjNBSncxYmVYNUhwM2ZQ?=
 =?utf-8?B?S3pDa3MxU3draGR6aGRiUFFHeWw3c1Vrc0srNS8yMDh0bUhCaTRpZUF6bmFL?=
 =?utf-8?B?akl1cEEyZTRiZEZsbjlNRTRJaU80cE1zZG9NTU5TYW1SRG4yMXhXVW1Cdndp?=
 =?utf-8?B?enZFdnVaVW5MWnZkeUhiV0RiTGt0cG1CVWNheTg3OVptcGFmdXpCbUlkdVdG?=
 =?utf-8?B?TElYSktscStEWkxjTnFLT3JKOElCb05PUVFZeUJJSytYNVZva0tpKzdZcUx3?=
 =?utf-8?B?bTJCOUkyZU1UWVI4aFB6azNiOC81ZzlQTktHdTllbDhIZHBWQjNPc1RRRkVk?=
 =?utf-8?B?cFRKMWdxMUhxZ0hkQnBiY3REVHp0ZnVCNG1GMzdvNjlXZHFEVnJCOUV5OVN5?=
 =?utf-8?B?UzhXUTRtUkJwQnhhT1Q1U1h0V1paQzFTTlNsSHBrL1RRaENSbXlNT3VlSmNz?=
 =?utf-8?B?WlJVZStkS0dia2I1dFM4bUpBQmlqK05HSVIxelROT0tTR2tyR09Sb1FDNE5u?=
 =?utf-8?B?bk9uL0JjK0JtekVKcC9SVndkeU9wdDNnVWZOdlA5SlZBbTF2RnRFcXFkaTA0?=
 =?utf-8?B?R3BaOFBJUSs2UWpiMnRQTS9vVHVBS0l4RlVZYnJzVVhSNG9Zcm1SRk5iYStM?=
 =?utf-8?B?aktEaWxpeThkaGhtZVNBZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnNOLzVqaWhXbFBJblFRdzRoU09kSDdKUkxNMGdFWG1MVVdhRzJsOFl4VzZU?=
 =?utf-8?B?TEYrSjQvL0lDb3M4SWhuL2dTRER4N0tHUkVCeUxzOHVMQVIrNU5ZM0RhNTZl?=
 =?utf-8?B?NUdkYWNkQ1JLUDBhNENKVWNKdzRwSmx3bGhydmUwVktYb3RPVW5mSnVpQjNS?=
 =?utf-8?B?MEdEVDRLNUdQNWdDZ0VZcWl2Zmx6allTdEhRa0YyY2w3WU1WNWdmS2UzYm9R?=
 =?utf-8?B?L05rNVdNN2RlL25PWG5WaEpUY2dFbWE4QVhmNHhBVzQ2d1N2aW53cGdobTNZ?=
 =?utf-8?B?WCtHSkgwM3ZldXBqRUdxMjhJUldFUkY1R1RWdkxoVGN2VGhXSFIvRlZaWlph?=
 =?utf-8?B?eU91aDFiUlJsVlBtME8zdDRkUGMrdlFqMXUzWDdFRVFMRXV0bzVDVHhpbHFh?=
 =?utf-8?B?OXo5cDJjK0Z5ZkdocmpPYy9xMlhuUW9KUFBRWTdTeGtSY016MVM1YnFZUE15?=
 =?utf-8?B?bzFRdDBLRm1KdGdsZHBmUFR5MGJNN1U4cUJ1MEpZVGR4UGg0T24yUUl3Umgr?=
 =?utf-8?B?TnpYeGFLUnMrY3R0RkVwSEpOOGxLNERUU24zMVVXTHZ0NGV4RzhnQUZSREtK?=
 =?utf-8?B?UTdianVhdHhNRCtVWXRJN2pKNmJJRlE4MGM3b240UDVZaStVYVlmdWduRC9R?=
 =?utf-8?B?dWFYRG9XbE12RUVoUnY0MGdVS3hhMWJPZ0ZRd1NMOVZPck1LMmc5R1V0a21a?=
 =?utf-8?B?QUZCa2MzYnhQSXR6MGpXOFU2Q3AyQkxHUFhpNHozcFRlYkRKTGc3YkdwR096?=
 =?utf-8?B?UFEwY3BqOW1TT21YUm16QmxqOWY1UGNUWVBCMjdPelNOK1ZTOTNTNFlLN0wx?=
 =?utf-8?B?ZGZPUlBTY2txZUdSRXB5eGxZUmgvbmhJQ2JqMTVQMXVveTA2aEpHZllMcjFy?=
 =?utf-8?B?YnIzUm1Udjc0dURET05KQ3cwQ3NvVy9MeEJ2bmJqcHlxVHYxUDhXOEpQeThO?=
 =?utf-8?B?aU96NjRoN1pVbmpCNFFnQ1FXNlhqNDJDaVRjRU5TWUtENVdqc00xd3BROHh3?=
 =?utf-8?B?cE9UTVU5MjdTeGVlS3g2NmJJYWx6WnZhOC9wNSszQ2g3MVhwdDRmZER5aDN4?=
 =?utf-8?B?MUVjS2tyRFlUcnhJUElOUTJRbzBZc1dOOXpIaG1YVHdsRDV5dkJQOWJVWnVX?=
 =?utf-8?B?NW9ZSXM4WHNaYkQ5WHpDNEJKOEd5ejBoWkxoOXozK0RxMWtRTFpBaVNMNk5q?=
 =?utf-8?B?VXNsTHRSZlZpNXlWYWhyMCs0andEZjFzNGNualBTWVVuZ0hVZnRhZHBtd2Qv?=
 =?utf-8?B?NDJYOC9UYVZIL3dWYW02bWJJZ3pBSzI5WmJ5WUJTTHUyVVk0N2NFYVRSNXph?=
 =?utf-8?B?ZlE3Ly9jVmpoU0h2S1pFc2t3dE1PbWhZTkNKUE5EWnZUaEpFeXp6V0VSTWM5?=
 =?utf-8?B?dFFqck43cDBrRHlkUEE2NkZYT0hvUTBPNW80MDl6cDIxaWxOVHhicXFjdmlr?=
 =?utf-8?B?LzErQmF1RnVTa2NSejBqNTdqS094TDd6LzYwRFlFZ21kRjRoT3ROMjlkRmxS?=
 =?utf-8?B?WnI1Vm5yNDdmdG8zT1hkZmhOZ2tNdFZVNDBGNmxLSk9WeWwxa3NUcmd2c1M4?=
 =?utf-8?B?RWxnUHlCdWNSeGlKOG1TUlYvelFqNmtWTWJiZ0x0NkNvQVc2djBPYVRjQTg0?=
 =?utf-8?B?dkIwbmhFOGdNVHZTVVVReEhWZjQ4SHpMdUhncU5oZmpPZDZhQVh2K0NYaGZV?=
 =?utf-8?B?TTRQc2p0OUtqMlJrYXk4cW5DR0FXRXpYdWx2b3dvS2hyVmVFYVlRNGFIRWs0?=
 =?utf-8?B?NWZqUHZBdzNnOFlrL2JLdGp2ZTgyRG10MU9mNFhlTnIzVmZ6L2V3eS9YM2pn?=
 =?utf-8?B?UnJpdXlnWmNDK2FDYUtOaGU4NHRiNU1FSkZlK0EwY01Ld3h0dzZxeUY5R0NX?=
 =?utf-8?B?VXpsejBhc21uMHUvU3ZIQXcxT0pvd0dGUytQenEvSWpTdmVNZ0xoYkZTVWp2?=
 =?utf-8?B?Nlh6OE53a1dmV1VxTkQ1MnFxRHA3U09ibElweXpETGJOU1hGREdVV3ZOeC81?=
 =?utf-8?B?L2o4UVRhQnVBVFdwRno3TWVsUDRCOWxrQWZPdVpCNUtrM3RzZ3lyYUh4Zmxt?=
 =?utf-8?B?RE4vSzNkL05WcWxXMDk0dGNVY3l2NXVJWkdUaGJjblNnYmJyNkNSK2FMeFJu?=
 =?utf-8?Q?wzNPBhfzevvD1xuQjNuVLucGo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q87UrR7tgx9CTw7mPowlOdWHpP+Ui8v/I0CQOVHDGHvZVs+1X++LfoG8Ed7h1o3leBaOL69UNSPxnSdcTAVyzwnK3n4e0nF1BS5bIPnPRpleRetsERzsk3zwDEquaHL6W6NgY63A/bloTHnFPXB1ZYvZ7e3Kd4t7upfOJhbu+2/cjsCK3uy27+8e32ViPtNWxG8Rrz7pZJ9uNGqWPDwtEq7fZDWQdtJGemdsN0SdIrHpJVFdk5O/8ZnmX25Mo3ZppI0g27X2cOCNb4lWOCh+y2Epo6AjAclyMIkB6lPzbtliME5XILGWo581jizNLzYgTfqlQ3Q5fp5vmN/oiX87gu9ZiblzY40HhBoQOIRu5Hj1DQ5VRbydSrUxJgJlo2zFtLTBf3CeS1GigCrs1dKYtChW/oKaxzskGgx+Qjy88zcY9y0FfAczQOINPMwUt+sgn/waEhrbH3sAk+HYSJRLdSi5wsb/YrbJA8Q83FqrttetWfF9N7dkx5+YWrY4u1XzWuwJRg32oecdBa3qtO0NbqLxqQk/4zD/S2jF2GL+1J+vXGYDV4M+eTkgyjgg+kLIGChapJWMv8TerzdGOE4S4J4ydUITSmBM8xD78Ez3FkA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2124c48-6c25-468b-e370-08dd6da4062d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 02:55:40.7139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtgjS2OqVlwjpWk0f6RjoV6R0dGydEIHtEsG96349kmv9kjjuSGZcMZWgk6Xefp8aSbwbiaxFRFYJfoa/r/Kxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7257
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503280018
X-Proofpoint-GUID: xI97LlCvPdtB46OOe3BvDKIL-1YXWMGr
X-Proofpoint-ORIG-GUID: xI97LlCvPdtB46OOe3BvDKIL-1YXWMGr



On 28/3/25 08:40, Anand Jain wrote:
> 
> 
> On 28/2/25 13:55, Anand Jain wrote:
>> v4:
>> Fixed the double quotes in 1/5.
>> (Thanks for the review! If no other comments, I'll push this set on the
>> weekend.)
>>
>> v3:
>> https://lore.kernel.org/fstests/b297a34f-4c09-48bb-86a3- 
>> fea50c364ba8@oracle.com/
>>
>> v2:
>> https://lore.kernel.org/fstests/ 
>> cover.1738752716.git.anand.jain@oracle.com/
>>
>> v1:
>> https://lwn.net/ml/all/cover.1738161075.git.anand.jain@oracle.com/
>>
>> Anand Jain (5):
>>    fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
>>    fstests: filter: helper for sysfs error filtering
>>    fstests: common/rc: add sysfs argument verification helpers
>>    fstests: btrfs: testcase for sysfs policy syntax verification
>>    fstests: btrfs: testcase for sysfs chunk_size attribute validation
> 
> Applied to the upcoming for-next.


Postponed for now. Waiting on RVB. Thanks!


> 
> Thanks, Anand
> 
> 
>>
>>   common/filter       |   9 +++
>>   common/rc           |   3 +-
>>   common/sysfs        | 142 ++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/329     |  19 ++++++
>>   tests/btrfs/329.out |  19 ++++++
>>   tests/btrfs/334     |  19 ++++++
>>   tests/btrfs/334.out |  14 +++++
>>   7 files changed, 224 insertions(+), 1 deletion(-)
>>   create mode 100644 common/sysfs
>>   create mode 100755 tests/btrfs/329
>>   create mode 100644 tests/btrfs/329.out
>>   create mode 100755 tests/btrfs/334
>>   create mode 100644 tests/btrfs/334.out
>>
> 


