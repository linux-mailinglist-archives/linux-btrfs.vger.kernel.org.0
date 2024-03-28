Return-Path: <linux-btrfs+bounces-3705-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E803988FA24
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 09:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E591C241C1
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F6F59B73;
	Thu, 28 Mar 2024 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="khg5yB+M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MfbmKX8y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D816F849C;
	Thu, 28 Mar 2024 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615321; cv=fail; b=N8NQ50Cr/vzPzicOl1UEIZFsoZMHMH/bRgIBZTM71nsXo2rhCW5f44H9lZtnf3dEOY9d04SOG4GlHgr0g5xy9JONrLv0Kyxc82IWttLbNhnFBqr3OY6bk0DssmfS7/EkiDrFSfRktPawIGZF2+sUskUBGKECUw99ad9NhzNZ6rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615321; c=relaxed/simple;
	bh=5+s+qobUSty7b1nwvHK9WRV/YY5uOYCmqPWmG4ODhuE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WeH5pVvbcu3iRcXOpTWrk9D6CDcu6pxq9OAVugzkM3bEpJiOY8TYMf/z3zhuGXlD63+EZbDQoOpR9eKoxHQ8txUDqUI6QAnJcrpsKORwGBXX/SQcvpsKQdcFNq/A1kwTveVBVKw2LuVUSGTDDvghwu8I7cc5lwsb4J8ShCjz9bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=khg5yB+M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MfbmKX8y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42S7BYTL020357;
	Thu, 28 Mar 2024 08:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=zgThfXYg82grY6FkCCWjOTJa1J7HR1iRCOgZKG64Px0=;
 b=khg5yB+MXIPFOTtcEz0pUOIeLsBDKRG/HYanbj18+53xzTflYV4PSewiU+Hmd7C6RpEZ
 lUhzrCrJUGj2BvU6e7I8f7WIjrTjBvjoYNGf20R11Z0duUMsOgw0QZpFBVoKYZE+RHG1
 Ym6PTRKqWfUx5B+eQoVXbWMJqv/gEFVzvBv1e40niP8fVAEDPkIpOBxAMpJxlz1lUnzT
 rwdD+FdrNVkPF4UND9zXLoSkVzwsdhVnk5Ckhc08I+BwVxk3ZX7SWTNet+LIvuinjUBT
 5xJOiNeHtQ3KcxQ855I6Fq1FxkL6ajSBPAfCbHRCwoTkt21gOyOucB8ttkwpWZqt4snU yw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x28ct8hpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 08:41:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42S7R8Z8008918;
	Thu, 28 Mar 2024 08:41:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nha1xps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 08:41:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQLERSyTz4sMBAI1AlSLePWfPMm0jNUSVQFTfLa4Fd9JVunp3MG60fVw019RSmRBnSLujiEvgK6ROHUHShzw4jbneNTLSm5uTh46PVZpvo+U4zi/bTlwJ+d1eBtSBcOuRx6YrGas/aElEYzgfBX8dI+0dSI65KVCjb2Of41apNFWawCQJT2PYByZ1Ni52w9CUL3djT309go5VIx6rDOeAsBJ3A0xrhbrsW7o1Dt58FTOvfqV+1C2WrErrdWpm5uG7sM4bBV59BIaMUgPToBk94EMe0m4HGpXqGsCkN9fAO41a3nHSfn3+iW4vMAkKauO1QKBr8a0XEpc5qUrV+XZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgThfXYg82grY6FkCCWjOTJa1J7HR1iRCOgZKG64Px0=;
 b=KXwyqzB7zQffvNhXNfN1QIhqniGtHHTlYtlgpm/CbUbs+jedQjRslYPsqKua09VfeeY9v6ebEtkWxhTsgehpybyZN+oy0qoqaOsJVHf2baMF+ZFi3ZGSXeG97TRahqNUlJKRZHBNuwdg6RkkyscfEdL4ktn96k/CbB8yv7SN50FxHJthb4QPGdYxSfKwHFDbMgCL2/czTZ1/TeEW+dU0FIUkXzefsDHeGs3pZ956vNJ7LKnSX+EXYEF8jMzQ2YJF4pX/JvP1MaaH12JVawu8CxT3gO/jD9N4/AAAwt7b60jr6yKIHY78GvkAOsPc5Y/Ns/FKw06DZuw+ckHSD3sGmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgThfXYg82grY6FkCCWjOTJa1J7HR1iRCOgZKG64Px0=;
 b=MfbmKX8ycgD/aTnwD6DQMGf355yiot0vpnW/f2jNqK28YjGw5hxRVu2niPRL9qFbSgFAIObcDm9tgJ3g8zKTj50mpTPQoP0yeYURbbh+zgVqqvG/2+VnPQ3JXxrBZqQ8xL8IdTmC8n7oVLiIQJIzLN9pHBZsUjlq8cvfhw8R4nQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO6PR10MB5553.namprd10.prod.outlook.com (2603:10b6:303:140::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 08:41:53 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 08:41:53 +0000
Message-ID: <64c47fe3-8db9-4f9a-aac0-64cc5bb07fb1@oracle.com>
Date: Thu, 28 Mar 2024 16:41:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] btrfs/028: use the helper
 _btrfs_kill_stress_balance_pid
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1711558345.git.fdmanana@suse.com>
 <375e94a8cc448c369d4346cba2f6ef6f65b34df6.1711558345.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <375e94a8cc448c369d4346cba2f6ef6f65b34df6.1711558345.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0144.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO6PR10MB5553:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d071b38-2975-4ccc-783f-08dc4f02eadf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	j0w5LffMYYml+dwi8KxZz9PEHeB0/i9ISS+awCrCuFAC6juFBYF3VEZRjEYOXBF0yPNAaYmsFX9V8e8eTmiX0w8LJEp1acpYK++AMQy/UQ4jhoCtdvvof8RNsfIaImWMZs891vrWNiKumDIOjUxE9wokwrZi9bo5LeiXzJmfGCtgg+RSIkoNJReR7WhOlv6bWpibUy73MJ2zOIsewxqpUEuCFAsdL46MlHUpzbYrAQNTwqplKwUrdDQ/jY5RZ7KfRYpL+Vg/zYw1VfsTaDVeSRjuTyA/AYz9NPgDG0JeupDy40Sl5xK6RN/BK1fNSDs8XXLsX3uyZoDnnyvQQL6sBx14b5uaFtUuhFTxTdmOM6m+VEki4UjDhtEFZHuAOz3IUIw7l+uGqMquzY9pa+qzWWFS+ehRvQZRWocG93pszmifkCMni/rPRckKut9pwC+pyIMUWAEaPkPVcrs4XftZ0UyMhBbVa4KixqCLvPCUQ3DeKMLpeKMr74jiLayL4qVkAKy9JRheWqGrO0yggJRZ+p06kVHzBzNvDizDTDa+pWAMiGVLabL1GtLyEpShSHJYURoyIEGA5Nq9hchIB8NJNyOmZm/jwNVeNuqpMCWodPIJ4XqwntV2uP9SoNv/D3qzhYfcMADzJizPzN0oUqbYCclUSKKHXj/UHDVdmKcHH9o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cnhhUU4xREQxdVkydVJKVTF2Q2lrZ1pRdURQT2VlN2RpR0J3QXJMbVo1NFQ5?=
 =?utf-8?B?OG8wQ2FsY1RYVTZMNFU5Wk9vLzBpOW0wR2dJa3RYSzZ4UVVydVVMTU4zZExJ?=
 =?utf-8?B?VU9zU1JIcVc4eCsxZmNyekEwSjduWXl2SFJaeVdCdGJrSWhKRjk5Q3FkMy9V?=
 =?utf-8?B?Q2tCVzhYd0JUSnZRWU90TWZuYTQzejRhZzJpU09Lbkxjcmorb0xHcVV5YXlV?=
 =?utf-8?B?NGZpOVJKUkd3dFd1ZkFzalNMMmsxZXFBMExBQnZUNHNiclpKcUJRazZWNDNT?=
 =?utf-8?B?TXI3M2FjNWJwTno4aVY5a2RqWmw3d0dMVFRmREkzZHVTVzVycTJuQVZWd2FL?=
 =?utf-8?B?Zk4yZTJxY3NZKy9SdnBOYzVseU1hQXVlNlNVMmZkdVZ0Rk83a3RvL0Yyd2Rs?=
 =?utf-8?B?Kzk0Mm0vYUFhK2g0ZGd2ZVN4dmprMmVKQ0laT3ZTeWdQaFpDTTdRV2tWb3ox?=
 =?utf-8?B?RG9FV3pXQ2VFT2tHOWM0T3BQMDQ5cDNZSEVEQ0tUdFBsaTFpZjRnSlMyVERn?=
 =?utf-8?B?a25XUzEwVVEzVkFkcXRxQi9jOTlJWHRodE12eEtrQm1SbGtlQzF1ZEs2UWs3?=
 =?utf-8?B?b2FLV1d6dFMreFd4bkVwdWYxSVVHZHhZRHRqdmJhNVNEcUY3RXJwdHNDQ2VC?=
 =?utf-8?B?OS94REExWGl0djJCallMd1NYYTVKK0hhTWdtN1hrdVlVMUt4ZXdPSW9rNXo4?=
 =?utf-8?B?cXIrUEpPWDM4dkUzZEtEQnpLL0N2ZFM0MSsvQ2RjQ0hrS3RyOW5sNGZUMktX?=
 =?utf-8?B?TkNlT0s4dHAyb0NMekhZZEUzL2ZWa0ozSjRCNkFlWjY1aXNtVFB6SnVoVlFX?=
 =?utf-8?B?S0lIQzJ3eWNBYTdDVG1manRCQkN4VXJ6QUwwUzlPY1d0Z1k4RzhlcjBPRXJs?=
 =?utf-8?B?MUpKNG5WV0NOS2wyMFlCdGZrdkpRVlBHQ0tocUo2K1ZzdWgvVE1sYXA1ZDE5?=
 =?utf-8?B?QWFnRkZLVTRrWnUwWUI3cTZ6dkRBV0p3NEpEUlVGaDROVzZyeW9VYzgrL1ZX?=
 =?utf-8?B?TXpESGRmS3VYZHVZUnRTaWtCdkQyRVhXUWd5bW1LQThKZXBwYUtKQTVuL1Y2?=
 =?utf-8?B?S2hJQkgyeVN2bjNGS1pqSzNxYkRFdmhVWHlQMFRud0xObDI0eDRuQ212VUgv?=
 =?utf-8?B?UXBzVVFNdnB6ZnZ3dWZ2WEJFa05tU29GZkxPKzc3cHJJaHdzRVEyaWh5SWl1?=
 =?utf-8?B?NEVTQnA1dTR5bHgwby9RVU1QWFk0M3cxVWwyYU9PcUtYWG1OQnJtUkNuaFB4?=
 =?utf-8?B?Q00xSVpVOEVkSEY2dFJsOXpFMHg1TTFGeXlxc3Z2RzNqVGZ5RzRzUURqL0Iz?=
 =?utf-8?B?bkFyekV0WFNFZVVDNUFYNjhRaWZHMVhjZTBDeHJ3R2hGUFd5ZEJGY2pvRlFG?=
 =?utf-8?B?aFVWdCtWOGJObG9SUDY2L3RqTTB5bUZHWEZUNU9SWEo3WFBXR2Y1aEs3RDBL?=
 =?utf-8?B?VVZaZzU3UC9jNVdzWlZrMHFvQWxmT1IxQUhaakgvamdEZjRDT01IR3M0K3N2?=
 =?utf-8?B?OHpMWVorMmx1ZUs4OHVvQkx3UytKaitncUZqSnVqcWRWdUdCUExFK1haR0ZV?=
 =?utf-8?B?Y2Qyc0FQWGZxWE5rejVieGdaWmh4Sm5UNWZoV2tiOEtycTMydlR2QUhUSEVL?=
 =?utf-8?B?Nm01dWhkbU96RHp1VnZzU0ZVNnZOTVYxMjZEWER2MWZac3o2c2hVaVcrZGp1?=
 =?utf-8?B?ODZJVlA3elhPcEp6Z1gvNDRubW5uM1ZkZmdGMkNwQXA0WHA0R0tuL0V2Y29a?=
 =?utf-8?B?QmF2MFBNNFJRa2p3RnlKUDNrcytRa0JvOGhOdEhNZ0gvbkx5OXhnaUJzcVRi?=
 =?utf-8?B?emsxa3FiSzlUZ3ZKSlRoM294ai85ZHp2QXZ5NjAxS29tR3JFN01POHJvbkhu?=
 =?utf-8?B?RkVPc1M2RkZwbTc5RHBqbnRnMkhKT01JVWUyRTkzUW4zU256cFJvSmF5ZVBr?=
 =?utf-8?B?c3JTTmViYjB3NFZ2TW0yZU5aOXRLb2dtcWVNU096eEw3Y0hidnM3dDVJNmpl?=
 =?utf-8?B?Uy81NEJZSGY5d1JyNXg1WlZtTTNSb3R1bi9oZnh5eHA3dm5pZTg5WHJqVkdr?=
 =?utf-8?B?cTF2M0tYQTNwTVk2STNpRFdoSDQ1L24vTkUraW9HWDB1QzlNOWNBQUdUdXJN?=
 =?utf-8?B?WVhCdXRXREs5ei9DREZReXdqTCtLaElmY2R6QkVTRVplY290b2ZIZWd0T3Z4?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SZ0AZeKeLrK9J3iiJBtydHdsRnS+g8zHfiF2L5wPVxqxilSfb/bUSDyO68w4DQFFKUl+ZGsmzIGT/pUhQ8WcE2l46U/JfSZZStqViYRKu7wRbT0+to2AtFnGFvpMaU0PBDa/5pJsci4vPwdoovWA2wrUqSM1irbxZ4Qh0Si+jWbVvzfAhLCmfaSBxrCuszi0QBuXbILJU51vlSy3CeKvTyD0ky13k1AeAWa9ksxJBuferm9U57J3/tskNDaHy+4bcEXXRkceYJKqOvpand4Xyq9eP9lbWvWo4iAGmRT9sM0a/M0UKCawBPNz4K03i946L2u7mubgW5gPO4UmIy89/p2KOPbn65MuhO8igNYkGbri7TUv/NMMUw9et3/WIblfvG0xCk8Rte1lMu4TJ5g2xlT1nn7UZGIR9xf8FUZbKivRS+t5YjJ+xeQ6Gu/m7DB9Sl0eWegSuT6xEAkIX1h4KHGK7QibMrwiMhP4CaTeCfhNhQHmMAZLWCpda7urrZq77qAmHutaBFoOmujE/U19M6wNMLB0hz8bKWsc/4OosDQxHZu6U84YRJkc3NnAWNOj/RyOYYIvtGmFMdpvzH2D8/4KIIN/ITNaXTimOUN00Lk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d071b38-2975-4ccc-783f-08dc4f02eadf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 08:41:53.1539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpB+TwPsEnAGrmFL5CMbAdxiln2U2h59Hx0zZPft34FSYppQaG/QYedNgBysG+GTKp1swFXErgM+TyEU5lEWfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_07,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403280057
X-Proofpoint-GUID: vWD0skV7_jxGFtaOpCXDsyOFa6w2M2in
X-Proofpoint-ORIG-GUID: vWD0skV7_jxGFtaOpCXDsyOFa6w2M2in

On 3/28/24 01:11, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Now that there's a helper to kill a background process that is running
> _btrfs_stress_balance(), use it in btrfs/028. It's equivalent to the
> existing code in btrfs/028.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   tests/btrfs/028 | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/btrfs/028 b/tests/btrfs/028
> index d860974e..8fbe8887 100755
> --- a/tests/btrfs/028
> +++ b/tests/btrfs/028
> @@ -44,12 +44,9 @@ balance_pid=$!
>   
>   # 30s is enough to trigger bug
>   sleep $((30*$TIME_FACTOR))
> -kill $fsstress_pid $balance_pid &> /dev/null
> -wait
> -
> -# kill _btrfs_stress_balance can't end balance, so call btrfs balance cancel
> -# to cancel running or paused balance. > -$BTRFS_UTIL_PROG balance cancel $SCRATCH_MNT &> /dev/null
> +kill $fsstress_pid &> /dev/null
> +wait $fsstress_pid &> /dev/null
> +_btrfs_kill_stress_balance_pid $balance_pid

  I didn't understand the point of replacing 'balance cancel'
  with 'kill'. The Git change log also doesn't say anything
  about it. The old code also tested BTRFS_IOC_BALANCE_CTL ioctl.

Thanks, Anand


>   _run_btrfs_util_prog filesystem sync $SCRATCH_MNT
>   


