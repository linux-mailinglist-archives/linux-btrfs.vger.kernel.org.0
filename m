Return-Path: <linux-btrfs+bounces-11527-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6346FA39396
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 07:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 133337A38F9
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 06:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31F91B6CE8;
	Tue, 18 Feb 2025 06:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P4mynCW0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RxMmftpc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F76D819;
	Tue, 18 Feb 2025 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739861600; cv=fail; b=cDAWqCUas28vK8OEhqosVUmj8F/3TzjJ7O9uKYP4Q9IWeZDxbXE5K4q4NFgpNNNRlzIpxU+layfZMXqYG4TK5Satddq+44u9Q21G3Nv36snNLMY2CLAzUnmGbx0RAj48kxozL1hr7QrMt+8j/CoUWVNSyCSqzYTEZQG/Msw4p+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739861600; c=relaxed/simple;
	bh=j5g9NM3ErhtOfv++LfbUZc7d2PmdTPNudWqE1E2dBzU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qLBP8KKplPSM40jpxVjBynVjA5sOyQIPSwfYujeQfus5zQ0BWK+N62n/sjB8b3pQD49C/3zW7c2nWKKtLSFKIyes2fMzjEb8UDwdVhPwABz0fJwFjU4Y7MEcAhduUuAcOBbHZhhEQ5SPamEukrlWUs7rYAu49SUiq6CF+9Bztqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P4mynCW0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RxMmftpc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HLurei030195;
	Tue, 18 Feb 2025 06:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nsz8fu9X6+vUakNFfXLbgepApK0iKp9Fm+eHr8bn/A0=; b=
	P4mynCW03Yrg/66exEpS04fyUptddmHDbpr4G/hwun8cGJPRWTdQQrOqHNiNfgpP
	4jju3TNNEdgkipAqISL0XUyFRCHGXqiaiXSRWGL6dz0kDH0B9x0qPEr+Kx3CNqlv
	VOUdrlsWiL/rdcoRjnD5O5EsnSSqG5w3Nnq250N1nj8NOVVFZN0Dq/ZL6uZCiAU6
	SBVEYepJ/t+2If8UH1yaGemc5Dyf+rIVNlWwScI50Zcx4EnEmNgdkJ1iecMeOr4P
	CpxkG3+oBi+XJ5UIWu2hXfeebxl8lgub4b8DGBHMrvvoXpb1N3+70VaeSTBoo1Uv
	goi/0oorsWw84B8MYqeUKg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tjybx0x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 06:53:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51I5JFne038759;
	Tue, 18 Feb 2025 06:53:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44thc9x7jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 06:53:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkD3HvwiNyAjZWufnYmM9ZN+6KCxuybD4P19Zlhy2UXonZ9gU50gNVYVHytraD8BrOf7hPp6q1ECkJMyH++OaoKYTgKN5nVSITFiGcx01iPwDgfPWmvkYbkaQQEDQ2BjXrLob9R8L5D2ZM7WawCsklcO7I0fR51+rIna96wcroBKNrZtMhPFEDWuyWkI3iign+3MR3VVZZKTNIKDMrDsyZ9bOmLbNljkQzFxUUNXE3VlfxR9sXvaU6UBvZV0SxSGZMs9eO3kxrTV0f5Rj9miL2u4FS1S9XyMtEGQf59z7sngsTrXq6VrzFWsOv2nZitTu2n7Jt61UoI+n0WZtYSb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsz8fu9X6+vUakNFfXLbgepApK0iKp9Fm+eHr8bn/A0=;
 b=I+MvkmkmOVfSinXmXg+uHYMq32sGJ3dJrjJNDVdnkAVdWpDPRXMNczst3VZ44C95iuFKWVIlJzmdxXnRNnJ0c27Pvn60m815g+N6yL3eBVa2vcC9iokFTsm4D+WNv2PxGyrZjNiLw2P4ovOqoN216Ji8IzFVICmQqJmsOm7PMKIqdflIEb3RCb4wCDcBY/HwzPxPFqclDQqJR1C+pztBfBWs5r0FgdmRxN17rlHINFjjuXhIlbOw7jLPOe+r3LgcUEUbZ4Kd44Hnnu/lXF5SVjcARoMfFxjQlN9T9IyoFTXqw9dFOLlRgJQviDGbEqtIVxYC3/fToVrMp+zqMH2irQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsz8fu9X6+vUakNFfXLbgepApK0iKp9Fm+eHr8bn/A0=;
 b=RxMmftpcLsGuB2MzTnYy7ffi0TuECjJ/Avz0Jh6PotWAzKkdfDUc7gz2xw/TPAQur6QO5qCppmdirScJCo4vAWl/2SFayoPcjP/4shiphJYDMhM74xvgDbcDHMJcNmNFFKvowEfCEuwZdT0gh2Y4Eq/DnQmfH+lGs1sp+1M8I1U=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BL3PR10MB6161.namprd10.prod.outlook.com (2603:10b6:208:3bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Tue, 18 Feb
 2025 06:53:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8445.020; Tue, 18 Feb 2025
 06:53:09 +0000
Message-ID: <5b0f6e62-128f-4410-9b45-90eb70b8f5e3@oracle.com>
Date: Tue, 18 Feb 2025 14:53:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] fstests: btrfs changes for master and/or for-next
 v2025.02.14
To: Zorro Lang <zlang@redhat.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20250214110521.40103-1-anand.jain@oracle.com>
 <3b2a541f-da83-4658-a47b-8b8a1ea75b83@oracle.com>
 <20250218035111.vkdtzkjskutvpvqa@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250218035111.vkdtzkjskutvpvqa@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BL3PR10MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd90124-74f7-4406-7938-08dd4fe8e74d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1BQeDhpWnEwd1RPSjNVWGFoOVdUTU14UzV0SjBPbHIwK1JEU3Q1M1RvTFBu?=
 =?utf-8?B?RDhrRUNFbWdWaHZmOUlac2V1TEZoMmFsblZnUGR3V0xoZTlSM01WdnM4UnU4?=
 =?utf-8?B?UE5zUjhidjJOQVprNVBucERpSU5kNFlzRTJCaG9IQWtGMllaUkcxc3p6bWxu?=
 =?utf-8?B?YVNkUVZWSmoyWUNNbzBpaHN0ZjlsTjlIcUNHb2pIU3ZnN3psR0F1YUhnc2Yw?=
 =?utf-8?B?SVlwRkZSY0IrckI1Ykg3UGxuNWtIY3VHSGRjdnJCTkdEeFUrSWlvRGJwemdn?=
 =?utf-8?B?ZnFpTHRvaGpwOEJ6QVpkbWprWWIwdlpqWjZUc0ZyOFd4eERWdDU1TTdxaVNx?=
 =?utf-8?B?aVNYbGJRUFlaVXI3UkRHSXhKZEQvVXFBQnp4UzhyM3NMVWVjbmcxUWNNN1FY?=
 =?utf-8?B?QzM0YUFnNXYrUHplRVUxN2IzZjFqNnk2cm9TSXplNWVqUXVZajlTakhkZlhI?=
 =?utf-8?B?TGRCeWpFR3djbk5zTnhUSnp3RWV2dWhHcjMvMlkwN0hYTWt3TFk1QXNpbDgv?=
 =?utf-8?B?bVZFWXpFeXZHaGt2SEw1elg3U1hpYXNVY3hGaXphTk9MajF6Mk5HaExJV21i?=
 =?utf-8?B?YWZxMHh4YVo2Zm85Y2M4cVM3UmllazdXU3EyanBJREtBSlZPd2s0Snl3L1Ba?=
 =?utf-8?B?VlYvS2x4ZDRVQk9iZldGVkdrRW53a0IvM1lWdms2dEZBYnZidUZWeXNVaUxz?=
 =?utf-8?B?Z3hkaEFmVGVrL1hGd0pGT2pFUlc5dVZlTXlBM1dUcE9XanlhT1NEYzVsRks2?=
 =?utf-8?B?QjhQaWZ1U1NSR25iOWFLRFBidWhheFMrYjQ4eG52UllqenZXSnEwQTV4NTl5?=
 =?utf-8?B?ZVRVZXJWVnVabFNjMzNkSXY5YkFUSURLbFVZMHZranNSVDNOZFJ3ejNWendV?=
 =?utf-8?B?Y2hjNjZiV2ZxRVNLMU1WRWhqVDNEREI5ajBaR20yNG16bmthVUtXcGhQUTdv?=
 =?utf-8?B?VUZtK3JsNDREZVNNNzRSMXJ4WTRYaFFBUnZ2SXVSZW9QQkpDM1JiWXFkdEkw?=
 =?utf-8?B?Y3VRZUJaOFdDUWtSSlNNNTNsekcwRWthOE84eHRjUDZKREhONjJyZzhSVnNM?=
 =?utf-8?B?UVM0RmIzZG5tZ1k4RmNSK2NqZzUyV3NBbGZrMUk0RnZSb3p2Ulh1WWJVSm9s?=
 =?utf-8?B?azVlNUZTOGJYcWt4eHVxRW8rL090Vm1uZEQvRzdCejZvMHphYnVQcXExS1ls?=
 =?utf-8?B?V1lrbnRibld4azl4UjBTS0JLM0paclRZQU0rc0VJZTIvNW4wSmo4QktCVElT?=
 =?utf-8?B?Zjl3L2Nod041OXk5OXhoY09uc1VoYnp6MER4aWU0cS8wYldSRXgxN2RRRlhJ?=
 =?utf-8?B?amJkclZpa2MyWVhiQVpmVHR3anVFUHVlS3FDN1JZMzR5Y01KeEhpSG9PTGov?=
 =?utf-8?B?MXd2eXhrZTFFNW04MVduVjRhdlhiZ1JJNWlGVGJtdEs3NVNYdjUrR1dxWHl1?=
 =?utf-8?B?eGozVzRJNDExL1dvMnBPM0NyQjZ5S1hDbEtTVXRkdDNYZmw4M2RYTEwzWW9V?=
 =?utf-8?B?WGZFYkhvYlhnVnE5NkF1NHZqQXZZTWRqTUdjUGM4V0NPL2tKRU03dTJERS9C?=
 =?utf-8?B?bWdUeEdraUVrd25rYnA4Vy9GMytDK2taY3RibExKK2dvcm9yLzRpWUp0M0Rn?=
 =?utf-8?B?ZklqUStqdjF6U1lyNk13UFZTdlorZzdsNmRNT2tKVEdnelBWdXl3UEN5b0ZC?=
 =?utf-8?B?NFB6eGR5Y1lXN25WR3hleDRsU040OWNYaXRiWUc2TDRXTEpSQ085S2l5cS9W?=
 =?utf-8?B?UFFDajJJb2tOS1RVbURJampkcnFKWi81WjFmdFFQakNMK2xucXdVNXo0bXkv?=
 =?utf-8?B?aXVVVWFVWCt1Z0JmNjUydz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmxmazRzeWhVSG90VVNma1JWNjRSOEFvdlhGbmd1NUpmdkgvcjRGWHh0aCtD?=
 =?utf-8?B?YWhoek5NSUhSc1VLMGUrZmI0dVlpUVJaQWkvQ2YxanMrNFZPZEhLMkdUOS9m?=
 =?utf-8?B?dDlFK211elljTnowcmk3VWVqcW13OC9od2QyREtCUHBKTzliNTNGNE5JUUFU?=
 =?utf-8?B?bGZtdjlFK3VtcFRuaHl4RHMwZXRRMC9JZm1Ubit4RlppK2Q5aVQ5TGdtM29W?=
 =?utf-8?B?SFUwbVlNWEVsTWpsM01aVlRoYXRkNDBqUkZ0bDEyTnR3Yi8zcFVGbU1EM01Z?=
 =?utf-8?B?ZmhqcnJxaHJxNS9yMEFZMUpaYldSRHcxeC9uQjdLcnJ2MXZ0NlkrUnZVdEQy?=
 =?utf-8?B?VVdhQVJSSmJ6SHdVbzlPblR4QzU0WUE3bHBlV3VQeWlwWldpaWl5b3FzZkJZ?=
 =?utf-8?B?RFlreUdKUzB2aE1MT3FLeG5HRjA4ellDbjdEVUZ4dFd2U0h0VGJyVkFuVkxH?=
 =?utf-8?B?MHBuMG5nejRmcmxIVFRsUFpJRnpQYXhNbGdxRUNEV3gzZEp1ejNpcGE1Yjhr?=
 =?utf-8?B?WXRQd2hSdFBTcDVMeVdWM0lhc1NlTE5MbFRvSUU2bU9LL1dNdjdzaVNYakw2?=
 =?utf-8?B?ZVlIb0pYNUFQQzZaQzZOdENjcXYwR21mckcxNDZNMjFMZVRGQkltVHZQV1Qv?=
 =?utf-8?B?bzlBRk9aTVAxei9mbWxjc1JPSFp5anZRM1gyaU90NGhHOG5RYVJyblNLcmQy?=
 =?utf-8?B?YkNEYUovMUQxZ3YwKzU3Y2hyYlJ6Uk8yMmZCc3RWYmd3bUV3dzJuVi8xUzhU?=
 =?utf-8?B?clFVMVR4VExOUmhjM290Si9zMEgzTnozSzNJK2QrSURoY3JobzI5Y2VQaVZD?=
 =?utf-8?B?S3hzN2RTU2oyd1pOVVJoYXdsRHo0bjQvVFZVL082VEl1NmorcEF0K2Jmck53?=
 =?utf-8?B?bTZlRFEySldBNlRvNnR5YllweWxmR0tkai9IMitsSFJrbEs4d2NJUWdWTVBS?=
 =?utf-8?B?TGF0Wi8wSlFrNjBLU2lDZ3hiblpzM0NHVnl2dEx5YXI5ZGc3dVpZTkpEbHRF?=
 =?utf-8?B?eEtqa1R5NE54Qml1eklwV21qckltL25TclZUbmxKcXozUzRiZW5XZ2FKTnFv?=
 =?utf-8?B?cjZoU2NJUjN6dmw4NHdSRHFaNmI3bC9meWQrdkw4NjdHQWJFaHpRUXA0TXJh?=
 =?utf-8?B?cjZmWXB4TnJrazhuaG16dHRBNzNEbzZmT1NzSEw2T2llRG9oK05FVFY4YWkw?=
 =?utf-8?B?bnREVXFjMWsvd2ZHa20yNTdkZ0dVRmx3d2hJTG14ZDZMSXhGUDZUSXdCQlo4?=
 =?utf-8?B?dm4yU3lJdWJSc1A4M1Z0S2tqZWJtUWRoQkNHTEtjK1g5MEQyM0FJeFN4OWIv?=
 =?utf-8?B?QU5mcVlVcUdEOHBlbnJ4SEVndmp5VE4reVZ1UTduSHVndGNSRCt2aC85SXlS?=
 =?utf-8?B?MlBlUWdCeUQxdmZJZ3N3RFNNdmVMVmhzNEVTWkJ0a3ZFWmh0Yk14M01Ybzdm?=
 =?utf-8?B?S0lYUEswaUFxREVjMzdUOHhMWEc3UE56U2o2VG50K29iOGRJNnhCZnE3Um96?=
 =?utf-8?B?cXNTU1YzbDBjV3NsU1gwWWRLeWFQd2lIL2tQcHpzNHVzM0RiZXRVdEhra295?=
 =?utf-8?B?YnA1ekZQQ1RBWHIvU0w1aWZCZENXS0w2WThzOC9UcXpycmtNR2dUL1Fnc0tj?=
 =?utf-8?B?V09wRDJQQjBibCs1K1p5anFNVEo4MTZ4SWRHa0dCcUNFeFJnVDM4Z0owSUtx?=
 =?utf-8?B?Y3BmU1JuaEVGV2psQ1FhdTBYMm5yM01jbCtNN0dJVy92dWptNmdwems2QjA1?=
 =?utf-8?B?Mk5SMGZYdEN1RjVLaG41UzdOOXR0aFl4Q01VNU5ZTlRieWM5Lzc4MXV6bS9h?=
 =?utf-8?B?bU0xWWRMamc5bEh1cVVHNU1weVJTNDZrWFI4MUpSNzdxbE40aGprc0dqd3FC?=
 =?utf-8?B?ejl0SU8ycUpQRHdPZWQ2WC9ucGJPS1daNTFkRGJtVnRGM0h4am5rRWE1dHlt?=
 =?utf-8?B?aVlaV2RabmdReTZ2Q0xzZmdYa1JUQnJyaU84TWRac1hNcUI1WWwvc1hFMVhQ?=
 =?utf-8?B?Rys0ZzR2MjhZc3VSUFBWZXpNaE9MRTJzNENkaFN2Qm44cnpDbFM3Y2tPdjl5?=
 =?utf-8?B?UlEzbjFDeWxOWWRNdzBKdGYwUEw0alZNWXppRFhtcFVPakVJR3J1akdSYWNn?=
 =?utf-8?Q?VuLZea8fXI6G0oFiop4Sdjgoe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vUkgrQKQQwHPK7+RRR+tEc2hPk2k8+NLFcT7rq4A4Gu4/hnTThQZWmYGuCNv9gQXNg3ETPSzJ1Xzt13V47X6cNStrG8a7iW+Bs5lAWY4fLgVZ46AQ9wrsy6WRa2OQeQBj/NXGnyHfauCjquESP0qVvBWNzU6cVJgMLbepmMtGssVkI2G777HRBa01hfxxq9B9YCE/QrZTjKOR5+nOiV5YLXJ8zmdfRYn/eJA7qNLJygnuSRHtONrPCNrmT5Twk3xzvhZ2WaHgX2/EGHDALvaPoERhmCJi3gxermtKUkust/KMA3cKt5zpF6hh4osMNvhdCp4XVrVBN9uft5Ae2oFXODkao6Uz2PZjI3SPV8dk5wEskoBu2nx8vAJHpsZS6QuSqPOcyrSDFiArO/pBeHvPT1a4d04xkvUbiiRfNPp/juPxk2ZzpLuAUstSs0mB6e8EUCqKEU6WhX8bmm1aFApezxSqxEZ2895UP7ha/Tcmkn2vein+XddXSGgA10E9PSnGIUN2TbC7NoIGsX/vPbp7Mi0uWVYVPLfe1NwKCwq/6SHyoAYiq14ZnDvBCDiocSMlcYDlkLrlu5T3Q23BGh0GZkZ7EgosJIPQLPnAqZHKwU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd90124-74f7-4406-7938-08dd4fe8e74d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 06:53:09.1022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: od8QJGvm9KX6jf/a3n+WAzS5iV55dziWPHJkLYql78xHakj/pKkRM1+KDwrcjA2k9S0VBMaTzsCpz++/wMwTGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6161
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_02,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502180051
X-Proofpoint-GUID: f3DgpsbZxLgHD3V5sM4glAdLQS-0LNzh
X-Proofpoint-ORIG-GUID: f3DgpsbZxLgHD3V5sM4glAdLQS-0LNzh

On 18/2/25 11:51, Zorro Lang wrote:
> On Tue, Feb 18, 2025 at 08:26:20AM +0800, Anand Jain wrote:
>>
>> Zorro,
>>
>> I wonder if you've already pulled this?
>>
>> The branches in the PR below also include nitpick suggestions
>> and fixes that didn’t go through the reroll.
>>
>> For example, commit ("fstests: btrfs/226: use nodatasum mount
>> option to prevent false alerts") updates a comment that’s missing
>> from your for-next branch.
> 
> Oh, I've merged this patch from your for-next branch when I saw
> you said: "Fixed. Applied to for-next at https://github.com/asj/fstests.git":


Got it! Moving forward, I’ll keep the `for-next` branch up to date
so it’s ready for you to merge whenever needed. Does that sound good?

Also, the fixup patch for the missed changes has been added to
the `for-next` branch.

Thanks, Anand


> 
>    https://lore.kernel.org/fstests/68aa436b-4ddd-4ee7-ad5a-8eca55aae176@oracle.com/
> 
> Sorry, I saw you used "past tense", I didn't notice you changed it after that.
> Please feel free to send another patch to do this change, there'll be a release
> this week too :)
> 
> Thanks,
> Zorro
> 
>>
>> --------------
>> diff --git a/tests/btrfs/226 b/tests/btrfs/226
>> index 359813c4f394..ce53b7d48c49 100755
>> --- a/tests/btrfs/226
>> +++ b/tests/btrfs/226
>> @@ -22,10 +22,8 @@ _require_xfs_io_command fpunch
>>
>>   _scratch_mkfs >>$seqres.full 2>&1
>>
>> -# This test involves RWF_NOWAIT direct IOs, but for inodes with data
>> checksum,
>> -# btrfs will fall back to buffered IO unconditionally to prevent data
>> checksum
>> -# mimsatch, and that will break RWF_NOWAIT with -EAGAIN.
>> -# So here we have to go with nodatasum mount option.
>> +# RWF_NOWAIT works only with direct I/O and requires an inode with
>> nodatasum
>> +# to avoid checksum mismatches. Otherwise, it falls back to buffered I/O.
>>   _scratch_mount -o nodatasum
>>
>>   # Test a write against COW file/extent - should fail with -EAGAIN. Disable
>> the
>> --------------
>>
>>
>> Thanks, Anand
>>
>>
>> On 14/2/25 19:05, Anand Jain wrote:
>>> Zorro,
>>>
>>> Please pull these branches with the Btrfs test case changes.
>>>
>>>
>>>    [1]  https://github.com/asj/fstests.git staged-20250214-master_or_for-next
>>>
>>> The branch [1] is good to merge directly into master. It’s been tested,
>>> doesn’t affect other file systems, and has RB from key Btrfs contributors.
>>> But if you feel we need to discuss it more before doing it, no problem—
>>> kindly help merge it into for-next. (It is based on the master).
>>>
>>> After that, could you pull this branch [2] into your for-next only? as it
>>> depends on the btrfs/333 test case, which is not yet in the master.
>>>
>>>     [2] https://github.com/asj/fstests.git staged-20250214-for-next
>>>
>>> Thank you.
>>>
>>> PR 1:
>>> ====
>>>
>>> The following changes since commit 8467552f09e1672a02712653b532a84bd46ea10e:
>>>
>>>     btrfs/327: add a test case to verify inline extent data read (2024-11-29 11:20:18 +0800)
>>>
>>> are available in the Git repository at:
>>>
>>>     https://github.com/asj/fstests.git staged-20250214-master_or_for-next
>>>
>>> for you to fetch changes up to 429ed656f99c06f8036eff1088d93059d782add4:
>>>
>>>     btrfs: skip tests that exercise compression property when using nodatasum (2025-02-14 18:35:16 +0800)
>>>
>>> ----------------------------------------------------------------
>>> Filipe Manana (7):
>>>         btrfs: skip tests incompatible with compression when compression is enabled
>>>         btrfs/290: skip test if we are running with nodatacow mount option
>>>         common/btrfs: add a _require_btrfs_no_nodatasum helper
>>>         btrfs/205: skip test when running with nodatasum mount option
>>>         btrfs: skip tests exercising data corruption and repair when using nodatasum
>>>         btrfs/281: skip test when running with nodatasum mount option
>>>         btrfs: skip tests that exercise compression property when using nodatasum
>>>
>>> Qu Wenruo (1):
>>>         fstests: btrfs/226: use nodatasum mount option to prevent false alerts
>>>
>>>    common/btrfs    |  7 +++++++
>>>    tests/btrfs/048 |  3 +++
>>>    tests/btrfs/059 |  3 +++
>>>    tests/btrfs/140 |  4 +++-
>>>    tests/btrfs/141 |  4 +++-
>>>    tests/btrfs/157 |  4 +++-
>>>    tests/btrfs/158 |  4 +++-
>>>    tests/btrfs/205 |  5 +++++
>>>    tests/btrfs/215 |  8 +++++++-
>>>    tests/btrfs/226 |  5 ++++-
>>>    tests/btrfs/265 |  7 ++++++-
>>>    tests/btrfs/266 |  7 ++++++-
>>>    tests/btrfs/267 |  7 ++++++-
>>>    tests/btrfs/268 |  7 ++++++-
>>>    tests/btrfs/269 |  7 ++++++-
>>>    tests/btrfs/281 |  2 ++
>>>    tests/btrfs/289 |  8 ++++++--
>>>    tests/btrfs/290 | 12 ++++++++++++
>>>    tests/btrfs/297 |  4 ++++
>>>    19 files changed, 95 insertions(+), 13 deletions(-)
>>>
>>> PR 2:
>>> =====
>>>
>>> The following changes since commit d1adf462e4b291547014212f0d602e3d2a7c7cef:
>>>
>>>     check: Fix fs specfic imports when $FSTYPE!=$OLD_FSTYPE (2025-02-02 21:28:37 +0800)
>>>
>>> are available in the Git repository at:
>>>
>>>     https://github.com/asj/fstests.git staged-20250214-for-next
>>>
>>> for you to fetch changes up to dd2c1d2fa744aa305c88bd5910cce0e19dfb6f41:
>>>
>>>     btrfs/333: skip the test when running with nodatacow or nodatasum (2025-02-14 18:37:09 +0800)
>>>
>>> ----------------------------------------------------------------
>>> Filipe Manana (1):
>>>         btrfs/333: skip the test when running with nodatacow or nodatasum
>>>
>>>    tests/btrfs/333 | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>
>>
> 


