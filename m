Return-Path: <linux-btrfs+bounces-4134-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D88C8A0B28
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 10:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A501F22E22
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 08:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF2C13FD97;
	Thu, 11 Apr 2024 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JMbJ2ERM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ThHqwTwZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612FB13E88B
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824174; cv=fail; b=MfpVNKyfwXz9nPYYf5ZPHb4QOHeSznq1vFcmBV4IUOwtk2e7XM/J1m2HnkbwXfHVDumtXoAXc3c3z5GG/vtlBPhhpm96cNuBJAG2w5fyGlzTjFoIOi3fv+6zJgRzSlnYk1f3Wg7qUJs30DJJgawFJHMkr4bAXCVyd9tHCq3ErK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824174; c=relaxed/simple;
	bh=3FuGP+NiC7OwfNN/ngAWBrDxvxCuri6vvwvlhLn4a1I=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZpLwXh15JFA8qlO+jYK6NqXnBLlcxIOFlN8Q/H6R7DqWRTR/njYnBdmJAHSPO9itrl7mv8lBu7SMZ6CMK/eUSfH7HOYUM4B2Ctik8sJ1V0UqKOCiI6ugE4niV9KU544/ECvLu2qD0tjegmokH0ApFf7kaDEgMn9dvFbDWxN3QWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JMbJ2ERM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ThHqwTwZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43B7mrRH006929;
	Thu, 11 Apr 2024 08:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=U/hIaOUrFEca0/MD5tVA1YMSxSbMhOGVeW6ca9mVbiA=;
 b=JMbJ2ERMBfEOdXP+eXD49Ectvs08OZitRi/Qaw3I88sfLXTeKojikY8UfncAAyZw0twF
 wN0OU+0zFtVZ71eb5P3joowoysOqKMwdKBF7ZfomZujvgTGUKOzfymOorhqKGp5ublvf
 tgRzsM7RC1Pi6UtC/HSLWYhaN2j6nR9ZetNUJNgYqSgFTqlUaoSSKnYVP9hXJa/zm8sJ
 3pPdZtC9ePQuhOQ3HoNfdVQmhqXP8LOEVxbxhW+gi1iCMbXxmLX6nRYPFXOJUOxS2F7D
 7XwmLkJSAD1lqhH0qk5zEVlRfnXsiVThVh7tmb1+Xci0Rjvh7i4YhWJOtukJ4XPZx+el 7Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaw0295xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 08:29:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43B7Um1i010649;
	Thu, 11 Apr 2024 08:29:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu98bad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 08:29:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IU0tde1mAbuN1J220taK5Gtg6om8Bpj9R7jPavLPKyyIZJ2Ef2snwSVi0CRYg5p1ET6ePIwlWFgdXICg+fq9e8v4G0MEIJFj2C/55BL2NR/m+5ArKtWvJoXYL6eA18y5GXwpQ2DdcyGs9blhrGseKGuF2e9vwjIh7t+eJyoVacg5cZan44Ho2PEt2emIem6H3Jmfft9R1y2KLyU34fi8PYuUTWGCP9O8odt3ajVoMcaLClAnWbIq8MHIl9ofKEcn+uYcMLlk8x3nSSGwQRrtj+WSBCulnCPBm/oM7OSzxZrLzAP2siST/IuttzbZfuIjND83E3OojPoI9CNVvXIpjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/hIaOUrFEca0/MD5tVA1YMSxSbMhOGVeW6ca9mVbiA=;
 b=PFOx1F5OwcdpqQsPRZkw0T15Y2h8hOiAEKAAa2KPpElbkSj0tdKH/M7Z9ICSKlZ3SHtDb4Q7Zh5iAh/AcpeK+1X4zp0DUB9caRvnIoOa5nH0GTzm00msvOZS+DfKgScAcVg/CxVAUbKQflJPTBDWsJcvqoXpvqpDKDHqSXwhBkdZEr/mIEsfjUd6z1CeMjZPUDFzuu2VhVntU44xwpc0SXmzih+PWt3FSs+slsV/jgcSkbh58EUCYk6Tj9OihxFNLdkQcQEMDwvo14TTTnPAMJhkOGE0535srhJrmXeRpMbspXVOsUI9Z0wUjdil18PrTG9RIr6Gla9X0vSpRNAyHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/hIaOUrFEca0/MD5tVA1YMSxSbMhOGVeW6ca9mVbiA=;
 b=ThHqwTwZGTAe0/5qrNnnHAMfd7cy7+YCywlZeXAUVyOGFnPbxP3PrnJdbg7c+cyRp8so4dNKhELDWshPxexMOZSoCeb+7WCLU9mPo6f3i+/kSRoeazNBgUx+gecxKhnzjulflseM90b0+2dAtP1/IaCOtweaSsEC54CjjaH2Dz8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4361.namprd10.prod.outlook.com (2603:10b6:5:211::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 08:29:27 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 08:29:26 +0000
Message-ID: <201b2633-db3a-429a-b692-8813f6e80097@oracle.com>
Date: Thu, 11 Apr 2024 16:29:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove colon from messages with state
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20240409141954.16446-1-dsterba@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240409141954.16446-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4361:EE_
X-MS-Office365-Filtering-Correlation-Id: b67ea858-d6e6-4e5a-faa7-08dc5a017fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FokrokZZ/yNSy5yLpoLbdkLb9AYDwr58TlEjUG4Ezu97+ldnN0fOFp7ltetK4f7pSyUngLs6LN3Qk4jgsGi9OoLutAG00/KNd195zt869Vv+gfeKdMZvzmyk3SRrSr0hwC3AAepjYLZkCuWrNgHUrzy37/4T1IOMVqAftnsIpo4Oaw2mfclk+Bt1843bXHV+AiDHbHaBzyiD5g21fD3C0Hx8fQtwXz66JweHaaNLQe5In4aawUoEMxG6u+4zsJE/qJAarKgDonzyuUDR9bPjp3ZkyoA9CCAZchsvlkLZdxV2pnxsLgidqbyjx+dHD/jNwqO8YftCQE/1fe/IMv07Wiwbh+IgpdHNDeTjhgfO9QLVpFneH22tLHp48hMvNq9ioXokRHtz0VFpAtqh5Mz88KjCn9GTYOKJ7j6KpRb/CWqXh8eKJFHmf8rmEmLGH0/n70zEd64D8FPjIBMYar2mWyNWsNLKUZX6WdYPgiTRhB+YMTSdQcc7YKcdzfN/hoLoKuq0FsZSnmu8VmrPoc64BhwkFPcN8ns68f6/JKVOTTwdeuVhDgMnYVnTh0qT+nLwnjd9oqiyAS+OxpQd2KgJBcrAu93LqE3pigKOItprioTw4CDgQ9yUkr9Y6inPs3xRxXlPO6R9rW1ptdZWWkmc6wuwCgeOtBL8+xVZJ06mLVY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YW0xOFhKa0ltdndMZ1dlWUN5K3ZvOEUrWmdHZkFSb2lrRlhBSVBaWG1hZmpx?=
 =?utf-8?B?a0ltRFZ3aFloVmxFZ3J3ejFIMmVCTXVLOFFPOCttOUdXeTl4VXFBd1Z1M01q?=
 =?utf-8?B?SkVQdlJFQzFNVnZjdzRNbU0yeHVOV3FURjNOSEQyNFNHampwMERnMWZ0RlNz?=
 =?utf-8?B?T2NxVFd4WHZ4c1lKVVppa0xuakFXSG5WdnZybHBsSTN1OEsvU0loalJKOHFY?=
 =?utf-8?B?KzIxbTYrWFI5ajhUaE8wekFtOGJ6ZUhUSWo1bWlLU3dlalZ5QXFJM0JUQVdi?=
 =?utf-8?B?ZTdvODJvMzUva1JFc1ZodHNyY1QzSkxYTHNSdlJtbU51QTlVR0FJMzBtREZD?=
 =?utf-8?B?Vk5RQzNSRGZuOVIxbEg3dWdBQnUzMTJCWUFBQ3RuaUI1VXNxSkQ4cnZ5UGZn?=
 =?utf-8?B?azhidC9mRnZMbW1wNkpTMTJ3ZzZOUzhoU1pkZ3VhTzBDZzRZK0I2N1MyMU0v?=
 =?utf-8?B?dlV6OGt1RHMrcGxUVHEyVlJwWmNMTFFObTd4MEdocWdLYkhQUERUWGdLK0FY?=
 =?utf-8?B?aG1mODdrOEMwZWpuYkw5c0Y5NHFZaVdyeU1SWVhheW9jd21ueU9MVXJ3V3RY?=
 =?utf-8?B?aGg0ZGQ3VnI3MlVmdWFIbXVPODZDVU1KNXk3RUJpTER4d3R4eEEya2x4aXRT?=
 =?utf-8?B?NTRzQjV1UDRxY0x3YnB2dHlORXg0eDFYcngwMUtFZlY1YVZxR2luNEd3RmdG?=
 =?utf-8?B?NWFYVEk3MEVHUjJib2xVM3M5YXZLRk1Ib1g1dzlyU0RoTlZxaEpOYVFzYnRY?=
 =?utf-8?B?MHYvUlhSczhIamxzNjNCbHNPbThveHBMV1lmaVBLK25JQkFYK0pLTlI0U0Yy?=
 =?utf-8?B?Mi82RWdmcVErUHZQbktsVkJxM2x6UXVJK01tTjNMaFphdEIvRGNTY0k2VTd2?=
 =?utf-8?B?bjYrWVVtSGh5enJhZmtvNXRJUkY0aWpyUW9GMlU2T21CSW9iTXVJU0N0TEk3?=
 =?utf-8?B?UVQvRDdaTVpqZFd6WnkrdEhMRE11NGZ6QkNXYXNwOHRhekJnSmEwRUVaRExl?=
 =?utf-8?B?dlJteFNyT0p4SEF3dXIvMXJpN09uOXJMSTBoS1hyM1ZEaTYrWUUvUmROZlU3?=
 =?utf-8?B?RjgxRWJwKzN3cGE4RE81Rm0wd0ZFK0wyYkFsM0tNMDJraVFtZGJBNDYySk9L?=
 =?utf-8?B?ckZtcXZpVUJxY1dvdFVLTVNGdWEzZytHZDU0TVFZSHVVaEVkT0s2Si83dTNV?=
 =?utf-8?B?TXZvOThvaldYMzEvcEkzWCtoY0o1TC9DRVRqQmhmNHQ5OEFmTm55MEFtQU1O?=
 =?utf-8?B?SStzakYwNXYxRVVtMVFHdU00TkIxNEtBY0kxNThkRHJTMlgyZjF5TmovMEFR?=
 =?utf-8?B?c0ZXUXdDTG0vK1QxRDZGQ1hrR1E5emJ2OG1ldmkrWlVQV1lHbWhkRXVqNHFz?=
 =?utf-8?B?ODM4QWRuMXBZcldSQ1hKVGRuN1JoMThLc0E3S3U4R3JIaFZvYS92S3AvWjVM?=
 =?utf-8?B?eEFJTThTc0JMbmlucmRnQWkwR2pHa1VubDNRMGVLNHBiRmhXWlFHWWkwbjh1?=
 =?utf-8?B?QmJMTE0yWUVFS0pqNlFUSkxydHlCNEdPMTZRbVEveHNaNzRMSGp4and6QzVQ?=
 =?utf-8?B?NCtpVDVBN0h5UWY4dUNEcUlIaGVRSlV4ZUNQVGJ5WDRXKzRxcGUwdjE4TDRC?=
 =?utf-8?B?eTlZR3ZvQUFlcEV1TVRHdGJsQVRVVWxTbTIvN2d3TmNhTnRtNnJOYnU0WE13?=
 =?utf-8?B?bEUzY3BBWXR3bkRJZ0ppaXpPQ01kdFpSOXloY0NXbG9VV0NtcFk1eHBscGxI?=
 =?utf-8?B?RVYvUDVyY1FiUXY0Q3FTWTRET3o0UWRwdzIxNDBxT1pBdUlOVE5lYys2bElN?=
 =?utf-8?B?ck1aUGg3UW1JL2FWNXA1SjZGQkFxY3pna3FZbU1MM0F2SnBjQmJxa2djeE8z?=
 =?utf-8?B?V2F0OTB5czN2aStJNTZucFExWnB2QkZscEJQd0dLQUNlNHM2cTRUWmR3eE45?=
 =?utf-8?B?QmRYVkl5NnBzZ0l4Q2lWWkRSWGdSSTVEZjdrZVM0VmluWHlQcEFHUmF2a1pk?=
 =?utf-8?B?cWhYb1ZHYkJXUFdNbXFReVo2T3VZQlltWjlmY1BaRFNObVBmb2hvdHhoSWdF?=
 =?utf-8?B?aC9raTN5aTMzaTdhOU9rd0xEcy96V3I2NFNqelRvbC9LZnp1SzVJeXBpMWt5?=
 =?utf-8?Q?k09/CI4LrQB05ZhXl5it5OXW4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CweFBcBMbv4rhv7VQi8TvOCfOPGigLOLZS4mb3SkdPPlV5Z8R3LVb2JOF3hiy00htZ6TtToXypaKPAlXhbmcRSDtCOsG+JYU7GMfpStKE2cXLMWX/q/yLm6bbka0CC3dBWyb88AXBJYToLgkK0Osz/QqNlYHRBXRDSuqxVyAMPyYmQOg02vkUZ3rYmBKl17vHNRRSvT6qCCs0gm7IT+eE6y3eAotqszaKqEzv/xmws4lu7iF2Xw5LoZYkEOJXvToFgBVpTLCLgUEb9pJvq8DjwchKl3YlUvVAVs1U4aJvX1rg8YRDfbRJQ9XbjKjttdeAnvtmuNHjXLHmfPG9ljdE+H4FDfwUsTCPYGOs5BYlxCu4tx8te+DBeZltmo7JL0AWdF50XRh8Zc7dH/fHHKGPSTLxLX2LQu8J9sHGenO2O0cmFHEuoWxI07wjv9PZXLy6+FM/RFKxebNIofux7oxJzREV4FuXG0gr6AeXgeOwGOt1iS7vRkQFwyHdmz5AdPoVTgLEC4vt/VA6PodR/Cr9s1+2ukB/3ymg8AIt9SY+Qkx2w6NlIJCSvQfGFFo6Gqt9Ouo8eA5m+lIgabehuFY2zejZL902dcasZPkWYP7Fpk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67ea858-d6e6-4e5a-faa7-08dc5a017fbc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 08:29:26.9004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDN4Jr3ANawMdh6SvVJ5kOKG3pZd6T1k9mNC63VsuLdq+tp7fBNYcoMPAZsFUE8NXR7+2H2Ta/SizC3g6fVSHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_02,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404110060
X-Proofpoint-ORIG-GUID: Zy5GQ0uLJ7Am9v7Zv47ke_3XDIvxlgQM
X-Proofpoint-GUID: Zy5GQ0uLJ7Am9v7Zv47ke_3XDIvxlgQM

On 4/9/24 22:19, David Sterba wrote:
> The message format in syslog is usually made of two parts:
> 
>    prefix ":" message
> 
> Various tools parse the prefix up to the first ":". When there's
> an additional status of a btrfs filesystem like
> 
>    [5.199782] BTRFS info (device nvme1n1p1: state M): use zstd compression, level 9
> 
> where 'M' is for remount, there's one more ":" that does not conform to
> the format. Remove it.
> 

Reviewed-by: Anand Jain <anand.jain@oracle.com>



