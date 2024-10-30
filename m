Return-Path: <linux-btrfs+bounces-9226-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 213EA9B58E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 02:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40EEC1C22B38
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 01:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF3E84E0A;
	Wed, 30 Oct 2024 01:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PzIV8ALm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XaOC3NdP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C512D383A2;
	Wed, 30 Oct 2024 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730250103; cv=fail; b=E/IAGOHEYQ/h2dIobJjrpId9kA0XlpXroNHL2biuZ5+3K1OD6hiILSQrj/pUprXFPHLavBt+7N+1bIDeWr8Xxo1/F26gWxQDMVitHKq1VEZva8mDq0mossCc+GgRQsSywqtJq1fh4/H6MlSHMSu7/6JlAiBNwP9fSeMTCAe2QYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730250103; c=relaxed/simple;
	bh=ArxP35KMhWpJbSUv6IFUtryr0hp6XZyq5z3NBhmveSU=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qhJkGdNODtbG6SNcF14NaqXaU8LMRDbP4Qsh+miFJXqmBMRuj591y/bqL87tDwV+Kx9YpdvE/wvqblqKNYdwaxvO6/guXUrO7mmKaoMJIAbkKrtfwXbJ3JC2eGorbVODXkFqdJgIPbPWpoXv//XKM0nkvI8tWM6Xt/OoVyO3dB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PzIV8ALm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XaOC3NdP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TGffnY003785;
	Wed, 30 Oct 2024 01:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Wn253kuSlIT+Sj+N3yyCZEopIRSN0QWdX8yZh8yVrjo=; b=
	PzIV8ALm/RlMKkSPXyko77mV50ZNA8QPq7DPfCAEfDrLwYXgTq++vVxOAnG8uOrE
	KirAYkqsoIaxJjqcJgT4TOBdRSRsObj9xWIRwr7kV2YR9HgvO2c9gVXZ5Cck5WFo
	fDANKpRTtKZs3x/+5Scw6slBUOxmy4cvC9qPy49NUNFIq8bVwqaULaw7AjK5FD3b
	j1HLjASShuZfMiUQWZD70oJR0e2eRShmcNpwrfNfk2e4sjUqePVnlu6IZVlb2lHz
	wi7fkUiY7TuPPe6MiiWP/bdGl4m556aVbgvEdhQUICkC9CqXk45u2G3JV1jN1LVW
	f59VDWxf7Vsn+vu7kNKJTg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgwetf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 01:01:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TMTJXx010127;
	Wed, 30 Oct 2024 01:01:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hn8xnfpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 01:01:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRLdtpugKk1C4lAhkw19+a6FA2fY/1Z4GUxl39jyzTP5jDLCnTWMDsIoQOPtG1KHlJmGXM6xXBd7W4DfGdCrmHYPRHf6R5Jep6r5CgAPv3PFuLtKt8eEjY2CHptdkw13H9YEheaYMHblFGvZx22Uqt81fZT3sF6baz7JoqfSk3vNswUOk651u96deGMzWxjEyQuntRBn8Tdz5AvlJUPHlT2X3OxSDXCIJ657OHPRRy1Nc2LNv9Zfijox0v7ZUaK0UWLe6pOpXnAtmZYXpJR7VN04iyP9ZFMGLIcMhpOrLf0DjTLLPCO6mPjA5L78IL+ZhGJQCOUB1WIBrUommiEhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wn253kuSlIT+Sj+N3yyCZEopIRSN0QWdX8yZh8yVrjo=;
 b=maw98n9Zoh4YEKIVx/aY1CMKsBtgorypz6e0yiN0qbKbsJKm3i3XFeQ8X12+imjviskcsWjsLVtDkt1dX1Bl6t5riTScMebeGrKDASCMjzjXI7EcJuq0siJPZKPnMVflXMfMvQsykzmD35twSlyd9MlBwf9oDAdZK8B3K/8WLyHl71yRHpBAoShR5zV+WnAVWBN8IPTuHzpvlQIF6hSLvOkLqoAZJgxQ6YcQL1IGniXvZl+B/ZNAFyhf54UG4hokGjKb9wHTvboMoPT2w7OfiLUjV5PY8VOk3LzZiox/2U6UrMHdM4B4pCFHG7+wKFXi6qIqjv87fOaOPBRy3JUALA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wn253kuSlIT+Sj+N3yyCZEopIRSN0QWdX8yZh8yVrjo=;
 b=XaOC3NdPbZf9eZCoEEjOup1hFu8mohASAvNqsv49a03IYQ+cgPz4xw6NBdDboplallgWV2xb12kNl1SCnC3PMFpG9K8+ol7DcXdhvTQHprJct3EYeWSQTE7KEgXykyb7Zsx4uxLBdtzkyshHjSjkbMlq3iY3uA2COUxiLXa2+6I=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB4851.namprd10.prod.outlook.com (2603:10b6:208:332::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 01:01:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 01:01:31 +0000
Message-ID: <793076f2-c1f2-453e-a17f-2cf4dce2fcc6@oracle.com>
Date: Wed, 30 Oct 2024 09:01:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add a test for defrag of contiguous file extents
From: Anand Jain <anand.jain@oracle.com>
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <e592bcc458f5c2ec41930975003702a667c92a8e.1730220751.git.fdmanana@suse.com>
 <a88924e1-4ff0-4cca-9d28-cd23f7a67b58@oracle.com>
Content-Language: en-US
In-Reply-To: <a88924e1-4ff0-4cca-9d28-cd23f7a67b58@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB4851:EE_
X-MS-Office365-Filtering-Correlation-Id: 413eb338-706d-47d5-26ed-08dcf87e6472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0RlaU0wNnYwRXk4a3ZhMVpLU3Q1RFl1aVJlR0NwWm9ST0FzVnhLbnlWU0Na?=
 =?utf-8?B?RlFZME1ZRENXN2QwSHlNQ3NEYUwvZDZGeE04YUlGWDZybEZoM2REeENYdzQ5?=
 =?utf-8?B?ajRDcnc3U1Vod0VlR0l1bnFsSlE5bDdQSGtQaE9EU3FPajJ4ekM0b1FqZkY4?=
 =?utf-8?B?VUVmVy9QQ1c3M1J6TjI2eWdpR3dyNjBsNkVPd3dxZVY2NUtRUm5uZllBRWJW?=
 =?utf-8?B?b0hpditlYjJDNjVFVHlRS1lPMUhmMEFZTFlzMzFNdm9YQTRSUEV3TVRHOXo5?=
 =?utf-8?B?a2JFOFluaUtjSGJBY1ZmZlpNQ3diRVUveGNnRXdKbVF2dy9LeldidWNYM0R5?=
 =?utf-8?B?ZkIrWmVnbHF0TTNXZW0xY3ppTWFzWDNMb0VhcHMrc1NZaTlwWGlWRGRZZTAr?=
 =?utf-8?B?T0hrbnArbFZzd281UmtkejA1K21YNGdTQmdnbEl5bEtZWFl4WU1MQzRBa1NE?=
 =?utf-8?B?eC9HN2hhVTNUaWp0VVk1dkJZalVIOXhYdVYzc1NWYWplMmw4LzJnN1pjSTl3?=
 =?utf-8?B?ZGxkNUQ5TWxVWjZ4M3FyVEc5b0Z5Sk9lRmpVdWxHb3ZUUGprQ3NwUkFZYSs4?=
 =?utf-8?B?OUdaSFZLNjNob2FaWDIxY25SVVhmSFZUbHpjeEJxNklEZWczNjE3QmFIU3Jy?=
 =?utf-8?B?MkhxT3pLT0RpVWdreUluUGpvcTZEZDFoRGZBZ1RldUkrREZUS2xMKzUrUlV6?=
 =?utf-8?B?VWFPV2xxSDVaVlc5NU9tZjl2ai93LzZBMUZ2VEQyWlZ2RHJGckNRNThlSWZZ?=
 =?utf-8?B?a29oUkZ0ckJETUhUaFBZa0RmZ2Y5d2Q1a3dBNG03RkZNR2lUOFBzaFJIOFNm?=
 =?utf-8?B?WkwrZk5kMWJYK0phWFlGMDhKYldrLzdFNVducDh3a1lVakNvbzJldFRYM3B6?=
 =?utf-8?B?RGZpR1pLRlZqZEkxd1oxdytQZWtmaFQ1aXBFd3haOVRPcVovcGNVd3l2b00w?=
 =?utf-8?B?RXNqRkd3WFpueHJvekF4ZFpTZmlXVnBRcW9QcEcxT0RnU01FNzBQaytTTzJY?=
 =?utf-8?B?ejA4bDNQTVhhSjJ3K0wyZXhtUitxMGFpbDBWUzNKbHVMTTVOeGNFT2JrSUUr?=
 =?utf-8?B?VDJHbldUTUU2cjR6U0FPcEw0MnRrYlJpU3dVMUJqNU1FVzU4YXdkWDZ5ZVZO?=
 =?utf-8?B?N2ZtUGVERE52TjdpcHVQZnZIWTNzYjZaazZNWHkvRmJIRUM2WiswWTlsZXFj?=
 =?utf-8?B?YTZBWGM1eFlEREdWMVZkUEh3NU5Hbk40enlkRW5wWUYyZTMvNGI1ano5MEpM?=
 =?utf-8?B?cEFuTGxqTFNYWXlSUFkrYmc2cTlkS2dSeWsxSFhORG4xeDVpdW5DVDhxT1dV?=
 =?utf-8?B?UFduQUtjVUlRVmFHOFhOZmhJTFZFSE8yUjRwYWJDYzVUL3M4REwvNmNDNjll?=
 =?utf-8?B?Mlhyakw1VjlNZGg4Q3JsT3YyY003dW5QWmFDbjhmZEc1Q3k3eDZ0MW5lU3pG?=
 =?utf-8?B?SWxhN0ZPZit0V3NUenJGS2pHSDVCeSt2eGlYY0l2TGlxSlRhVEpwZ2ZGOTI2?=
 =?utf-8?B?V0R0cmFTeFpiU2dnczVSRWphVlFpK0w3emhrNUNPRWVKb1M0SjJrc0Y1ekFZ?=
 =?utf-8?B?MytWVDNWVDVsNDJuSUtNZmhuYmF5ZVZYc3Y1RFNqYm1xMy94NWRsclduUzhQ?=
 =?utf-8?B?eEdJWG1uVEZDZXpwNVFndUN1RFJXQUlQMy9pVUN2VVFwbzczR2ZNamtsOG1Z?=
 =?utf-8?B?ekI0VzBacFM5RnJvbWg4Y3RlU3RDMkl2aWZLZHcrM3JUenA3SnpYVmFFelox?=
 =?utf-8?Q?D2ucli1auO+usTYfz+zT8XaAE1MbO/V3GD3PlET?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OThFS0FyYUdxMTRRdjhiOGVmcGo2Q1Zza2VORHVHd3JWeTJOTFVTSERGMVZo?=
 =?utf-8?B?SlcvUGtxS2NtUS9yNUZpRDRZQytseDFPT3RlUVdnODRLdXZtblVDeThoVmF2?=
 =?utf-8?B?TWkvWDJpK0lzeXRkdElMZGM2ZW1iMUR0d1hha2RRR1VneFJDU3lTdk5iRWNV?=
 =?utf-8?B?LzA4MytSY0l6NStqR1I1eXNxaVo1dVRWRCtzUkE5czZWdjBXRW1tSklOUG4y?=
 =?utf-8?B?VzVxMmc2WXpiQmRCYTEvbFY0V1hYM21HeEdscGVJRHpHMU16bTBoUndxb3pn?=
 =?utf-8?B?MzJDUHhXeS8velhIemJUSUhPOXd2T24rMGVkRGdYZVo3dVJmT1l2TjhYa3RY?=
 =?utf-8?B?U216ckVsRE9Lc0h2NlV0S3R2eVNCa1pyM0x0Znp4T3A4eldZMkRiNTJybG9G?=
 =?utf-8?B?VEhSQXRCUUVqZWdVeDlPbGlWRlRGMEg4a3R1ZE9LTWZxYkE3S1U5ZWtKR1Y2?=
 =?utf-8?B?L0tSWEU2ZUg3VXcweGluWDdHbXJIYTlWZ3pvdW1hcUlBNVM4UGRWTThUNjFO?=
 =?utf-8?B?S1MvRThFV2NreTBoaUVaQWViMldJWXpyK09WMjdTblA5RVdPM040L3p5UEhz?=
 =?utf-8?B?eENKdE9tVXJseisxdWwreWRTakJZV25aZlgxQ0FCaGdaWjIxQXhzdGRXaUhm?=
 =?utf-8?B?QzRLMGtZVHpGZHFsclRnMkFSNEoxMU9IV3lDdmdtTkVvZ3JwL2dmVExncmVI?=
 =?utf-8?B?MEdBcjM5UG5zN0wzemNwOXJVWXhRZjVMOHZZdzlaMkx2OWZQQlpiZnRPYjFs?=
 =?utf-8?B?UXNaT1prUUlQRTVhWjBxUDhvREtSTVJlZXd5L1ErVmpid2dqUGhtV3pjL1FH?=
 =?utf-8?B?Rk1zVzlSRXFNR29NQUdFdUtVSU1MSlhrd29WNk1FSFk4WWYvR2czaGhubEFh?=
 =?utf-8?B?aXJhUFl6NGlQYVFLRWh2WUk5WTFycDhYeElXYnliUjhoOUdmQVErbUxmSXdZ?=
 =?utf-8?B?a1NvQ1JhVEovZllGOEhUMlU4cmZxT3c5VHF1a1oybUpvdkxldDV5Y3A4ZW1G?=
 =?utf-8?B?UTNaVXRJdjBycmhTWnZHMVBXSUVud21KcXJFUk1ib0dEaUNNeU1uMHgzK2wr?=
 =?utf-8?B?dkIzaHVWUXlOT1VveDI0UGdPUU9IbXozNS9qcXBLSUJTVmlScitMUVc0cVFG?=
 =?utf-8?B?QjdVTHZQMjc1Vnkvb0gzYVlvcmdZTXZOYXlsQk40aWNnUmF4c04vNnZyVEVw?=
 =?utf-8?B?a3hFTEJuN2RQL1RIaHlPeWE4ZVAxVHd4L1ZpMkJmYXQ2V1dZeU9Wcy9DdjMw?=
 =?utf-8?B?OW4xclN0N2QxdDFpM3B0ZU9vKzNqZHFZRHhrS2hjWnJlWXVXNmNMdk9CRHV3?=
 =?utf-8?B?Q0g0Z3A5NXJUSS84NGJtYnhoRGNJaEpuTjRTSlEwVHh5OUNTak1ramZZTUxX?=
 =?utf-8?B?MHFhcG9hN2Z1OUtCbitGd0ZXYnpPVUc5YlhpVmllbHhOYk5zRGtUQmhOa0FT?=
 =?utf-8?B?aEJMVWFWWW4wSUM4YTdEazhhWExndUdsWFNFeFpDcjY0MmFGY1l0eWJtTnVq?=
 =?utf-8?B?cmF1WmFFN05rbGRwWlhSMDlhb2RtYnJBOXFOSGF3RzJxSFIyVjlnNElGWHZu?=
 =?utf-8?B?OTdqbE84Z2NmVjV0Y2Z5eW1lN09RRkdmOW94MERnVlNvRDdhNlNYWGhPSXc2?=
 =?utf-8?B?a1ptSFZGU29IdVlnTm5iZ3IzbGtZZFBoQ0lJcDFzUGVMczk5MGlYcHFMaDdS?=
 =?utf-8?B?THo1WmVZcFArd1BEaDVUdTI0T2hDSUg5MHZYdkJ0L2NGaVhTYUZQOWt4czdE?=
 =?utf-8?B?bTAzeG5qdDl3SW5ueERDT2x1RlJSb0xCOXNybGZvcWFMKzV0aGQ1YkZjRXJ6?=
 =?utf-8?B?S0VtZnZoV0h0ZSsybFdMRFhZZHBtbW9kbUNIaDliY3JBZVlBNVhsMzJwYXR4?=
 =?utf-8?B?RW5pc28xa1M2ZzBCcUE0dkx5NUZFbmttb05TWTRuOUJyWDUxaHROdEdHTExZ?=
 =?utf-8?B?UGdXYk5XakJOMURZMjVrMU1UcHlxMHNCd3I2ZnpadFZ2c1VOR0NhNDFWZ0pk?=
 =?utf-8?B?NnlTbUxXWVBSeHlxeWFNcXVUWHpDMmtKWGhNcExlcUpLT3hmdG85RW9NNzJ5?=
 =?utf-8?B?cWxzRG16Nm1wcnVldWlzQ29QTkJHUHFwaTFRRzF2MXNWOFVQOTJpOG9EVVl6?=
 =?utf-8?Q?S/vluzv2bZVvsiMb2Fb/K9EtO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aGYx/YPnUakOCbbuw25VrAzzBY4gFPbzxOB3kRb1DzYwtXYvpq6rIr5X6b3+DFJO/bFwBO2Lm+RcjjMKhPeomwlFoR7GbLB2mGfiQ+PBcIrw5e91+SRYo5s9fvOFm1xHkZSKtTEt/BI6w/ow4X3raFQ32UEcuMpbBHcTHpZFjsLPbZ+8hSqe3D0h0Ukqb9ypPs8zczUyn9sdB0ODcqHk8KRcphhFThsZws8bf8+rAT7k2faG5p0p/aYfw2yFtHak++qLM1RILM3JpxK/LfVfu1qJ4C3IsIEZfZ72mY7wpQKCD3UXYe8MKQUJz1UJ4JX2u/R4EYMDF+n/Y2EeGcDJAqpHAirEKrMA4JJnU8DoTg0wrHmXHF4WepGRT6lVHR5Tp5Cssmixdac96xTzmw8BuwWCen0KbZlIdxUc3TCSS1uMPf3h0IcX/To+6R9F3NbwU7attXPnn4srOZ7108+wJA5LBW0TM1QJHFuZ5O/mSz/NzlkTwHQDoPYqJoE+h3JkhxHYegknvTalFke7GrVl+m63vqUWv5U2Y4EF/kSNmfNhE42ZJgQnum0UGaDYmzuUbIi0dNmI2g3XxzXbCsMPMMf2qn81dAK0WkRiXsc3wIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 413eb338-706d-47d5-26ed-08dcf87e6472
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 01:01:31.7672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8vFaOvPz/9oyd7CeGzKPUrC4XblQBRltiNii73BzdHFDfbKpRFGKnXk/pjPMxhkXXDowVDKVuZRw7jU9fLO45A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4851
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_20,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410300006
X-Proofpoint-ORIG-GUID: rMakCIiBFolLtN2ANDTnQ9WywJNZ9ehT
X-Proofpoint-GUID: rMakCIiBFolLtN2ANDTnQ9WywJNZ9ehT



On 30/10/24 08:48, Anand Jain wrote:
> On 30/10/24 01:23, fdmanana@kernel.org wrote:
>> From: Filipe Manana <fdmanana@suse.com>
>>
>> Test that defrag merges adjacent extents that are contiguous.
>> This exercises a regression fixed by a patchset for the kernel that is
>> comprissed of the following patches:
>>
>>    btrfs: fix extent map merging not happening for adjacent extents
>>    btrfs: fix defrag not merging contiguous extents due to merged 
>> extent maps
>>
>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>> ---
>>   tests/btrfs/325     | 80 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/325.out | 22 +++++++++++++
>>   2 files changed, 102 insertions(+)
>>   create mode 100755 tests/btrfs/325
>>   create mode 100644 tests/btrfs/325.out
>>
>> diff --git a/tests/btrfs/325 b/tests/btrfs/325
>> new file mode 100755
>> index 00000000..0b1ab3c2
>> --- /dev/null
>> +++ b/tests/btrfs/325
>> @@ -0,0 +1,80 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 325
>> +#
>> +# Test that defrag merges adjacent extents that are contiguous.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick preallocrw defrag
>> +
>> +. ./common/filter
>> +
>> +_require_scratch
>> +_require_btrfs_command inspect-internal dump-tree
>> +_require_xfs_io_command "falloc"
>> +
>> +_fixed_by_kernel_commit xxxxxxxxxxxx \
>> +    "btrfs: fix extent map merging not happening for adjacent extents"
>> +_fixed_by_kernel_commit xxxxxxxxxxxx \
>> +    "btrfs: fix defrag not merging contiguous extents due to merged 
>> extent maps"
>> +
>> +count_file_extent_items()
>> +{
>> +    # We count file extent extent items through dump-tree instead of 
>> using
>> +    # fiemap because fiemap merges adjacent extent items when they are
>> +    # contiguous.
>> +    # We unmount because all metadata must be ondisk for dump-tree to 
>> see
>> +    # it and work correctly.
>> +    _scratch_unmount
>> +    $BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV | \
>> +        grep EXTENT_DATA | wc -l
>> +    _scratch_mount
>> +}
>> +
>> +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
>> +_scratch_mount
>> +
>> +# Create a file with a size of 256K and 4 written extents of 64K each.
>> +# We fallocate to guarantee exact extent size, even if compression mount
>> +# option is give, and write to them because defrag skips prealloc 
>> extents.


>> +$XFS_IO_PROG -f -c "falloc 0 64K" \
>> +         -c "pwrite -S 0xab 0 64K" \
>> +         -c "falloc 64K 64K" \
>> +         -c "pwrite -S 0xcd 64K 64K" \
>> +         -c "falloc 128K 64K" \
>> +         -c "pwrite -S 0xef 128K 64K" \
>> +         -c "falloc 192K 64K" \
>> +         -c "pwrite -S 0x73 192K 64K" \
>> +         $SCRATCH_MNT/foo | _filter_xfs_io
>> +

With the fix applied, this test case fails when the compress option is used.

--------------
FSTYP         -- btrfs
PLATFORM      -- Linux/aarch64 dev2 6.12.0-rc4+ #36 SMP PREEMPT_DYNAMIC 
Tue Oct 29 00:25:40 +08 2024
MKFS_OPTIONS  -- /dev/sdb
MOUNT_OPTIONS -- -o compress -o context=system_u:object_r:root_t:s0 
/dev/sdb /mnt/scratch

btrfs/325 1s ... - output mismatch (see 
/Volumes/work/ws/fstests/results//btrfs/325.out.bad)
     --- tests/btrfs/325.out	2024-10-30 08:07:48.507531048 +0800
     +++ /Volumes/work/ws/fstests/results//btrfs/325.out.bad	2024-10-30 
08:57:35.097186024 +0800
     @@ -8,8 +8,8 @@
      wrote 65536/65536 bytes at offset 196608
      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
      Initial number of file extent items: 4
     -Number of file extent items after defrag with 128K treshold: 1
     -Number of file extent items after defrag with 256K treshold: 1
     +Number of file extent items after defrag with 128K treshold: 2
     +Number of file extent items after defrag with 256K treshold: 2
     ...
     (Run 'diff -u /Volumes/work/ws/fstests/tests/btrfs/325.out 
/Volumes/work/ws/fstests/results//btrfs/325.out.bad'  to see the entire 
diff)
--------------

One approach is to use random data, ensuring that compression remains
ineffective.


>> +echo -n "Initial number of file extent items: "
>> +count_file_extent_items
>> +
>> +# Read the whole file in order to load extent maps and merge them.
>> +cat $SCRATCH_MNT/foo > /dev/null
>> +
>> +# Now defragment with a threshold of 128K. After this we expect to 
>> get a file
> 
>> +# with 1 file extent item - the treshold is 128K but since all the 
>> extents are
> 
>> +# contiguous, they should be merged into a single one of 256K.
>> +$BTRFS_UTIL_PROG filesystem defragment -t 128K $SCRATCH_MNT/foo
> 
>> +echo -n "Number of file extent items after defrag with 128K treshold: "
> 
> Nit: s/treshold/threshold/g
> 
>> +count_file_extent_items
>> +
>> +# Read the whole file in order to load extent maps and merge them.
>> +cat $SCRATCH_MNT/foo > /dev/null
>> +
>> +# Now defragment with a threshold of 256K. After this we expect to 
>> get a file
>> +# with only 1 file extent item.
>> +$BTRFS_UTIL_PROG filesystem defragment -t 256K $SCRATCH_MNT/foo
>> +echo -n "Number of file extent items after defrag with 256K treshold: "
>> +count_file_extent_items
>> +
>> +# Check that the file has the expected data, that defrag didn't cause 
>> any data
>> +# loss or corruption.
>> +echo "File data after defrag:"
>> +_hexdump $SCRATCH_MNT/foo
>> +
> 
> Nice.
> 
> Nit: This can be a generic test-case.
> 

> Reviewed-by: Anand Jain <anand.jain@oracle.com>

Please ignore the rb for now.

Thanks, Anand


> 
> Thx, Anand
> 
> 
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/325.out b/tests/btrfs/325.out
>> new file mode 100644
>> index 00000000..96053925
>> --- /dev/null
>> +++ b/tests/btrfs/325.out
>> @@ -0,0 +1,22 @@
>> +QA output created by 325
>> +wrote 65536/65536 bytes at offset 0
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +wrote 65536/65536 bytes at offset 65536
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +wrote 65536/65536 bytes at offset 131072
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +wrote 65536/65536 bytes at offset 196608
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +Initial number of file extent items: 4
>> +Number of file extent items after defrag with 128K treshold: 1
>> +Number of file extent items after defrag with 256K treshold: 1
>> +File data after defrag:
>> +000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab  
>> >................<
>> +*
>> +010000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  
>> >................<
>> +*
>> +020000 ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef  
>> >................<
>> +*
>> +030000 73 73 73 73 73 73 73 73 73 73 73 73 73 73 73 73  
>> >ssssssssssssssss<
>> +*
>> +040000
> 


