Return-Path: <linux-btrfs+bounces-10786-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B240A04FBE
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 02:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF88164649
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 01:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE294F9C0;
	Wed,  8 Jan 2025 01:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gP3pSIXj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qdnQ6Pt4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4342AD22;
	Wed,  8 Jan 2025 01:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736299957; cv=fail; b=VlNen9a5ibpO7A92M5Hy9C0ZY4ZdoEqS0BwMFDFjLvzH6Dd1EE2fhzhakrgLRjWpfAKdZoVFeFw8DUsvd4m4PLktM12skOuBM60KeWlreJXvu36Vml1lR2GLl3adASZhI0kzi9Qaafx/nhr1EJeSnOuOoUsL9mBgTFfkqd+Ci0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736299957; c=relaxed/simple;
	bh=m0baaTth1QehEeKSnqWIqFKxhisKUNFw6oOyywtlaBE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jMD6rhT1UE3ToU4C3NnnLqAs9hy6yzE1zqcmfYXLkOPVlAerwws5x3SSs8JIE5GB1rO00pZwgvpUe4L/xV8PHV8w4pfIUb4ln3ZsKoaq99eZY5FtYLKJya2JNjAC71K7E5cWHKqsOnxIuJTp+V2BCbeRP8Qm/yMXeJCEdptwKvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gP3pSIXj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qdnQ6Pt4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507MNYm5016515;
	Wed, 8 Jan 2025 01:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=m0baaTth1QehEeKSnqWIqFKxhisKUNFw6oOyywtlaBE=; b=
	gP3pSIXjbILJ9lGzl1thJxWwkOmZGuFcDbYr8jcKLCzNwofY0RjDVC+ANgki/6Z0
	wsS6VKRO0316/TKoD+n5aOBxnR21T7YR9+lirX7qI8tXlvev4Gb0XJxpEpAMWQQu
	1lwxfYpUsn3myMKQ9E/6MbYdJnT5VJw1WQrmdbqAZkmdOCICktlagHgZo4w33iYU
	4detV6pmhs8MykpXaM/a9ye30byB7a6+Vr3tq/48A5rZBfdv2SXrrWSH3MOjKWc7
	IIJPx7Z0zdUalesnIdmpwDU722/Z4ZvLx7a5pVO7Zzi5Mx5+07z0ubOXyLARw2Mw
	lwk++ykd97YCOAShDK/LAQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xwhsnrhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 01:32:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50812wqp019902;
	Wed, 8 Jan 2025 01:32:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xuefgtjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 01:32:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSof5RHTHsDTYcGHXo1tL4fQMhjL+WlcGy8i525DCHU/JaK4zqHmm+Y9PPuiVGbs/FOrn/5+bkApUffmniMjgtWrj/DQLRIL7yZzMW9vW+8b0pDeTUmcP4LLO22hQxss9i0xHp9C3SiLyaLjY3dXAzgcK+IfuFVOpXNYEp1qlgRsxgtwLK3Yshge+JDUDoMvOpUFZTPwAmOmO4Wa9xG2EGQxMqK58dQTDibbOJQxsXI4flHo30NCpy91e6/sQBGm4u7YwJzQDs8p7BF560JyFtriPj7RwCfoQ5H+Q8oxosd9dUUVSvlzzGXumvCYqDXQHhAw8y7xeVYEcymZ8t8qVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0baaTth1QehEeKSnqWIqFKxhisKUNFw6oOyywtlaBE=;
 b=C1aUk/tUOWIW/Hb+dczl6yWlr3yBQUTEcWNUU+JcZIu9hNSeG5QIY8PS2mVi0eZb2Lf8dPKvrRcG0c2CNQyshPARHbmfQceXdzV1sSTB0PVLyVPD6IciakrYqZuuFtD2HQixDAMXJDvBZhbGvoQ2THvy9V/WxAYW+QBcDCDEkK12jnn0kg4SuCJLIgHpvDTeLkxZGKiHTKZnRj6uerErtBj06X0QaDfO/On3WtTJGlUt8lr8gLkdNhWr4hlLIah3RzdlXS1cv4TT9AfYbetcpe5kXPerJhm53whdfMKeYB5mUaUHRMIb2fDOG5DDs5doUeTEyjh2uk0MPpDKk9RXeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0baaTth1QehEeKSnqWIqFKxhisKUNFw6oOyywtlaBE=;
 b=qdnQ6Pt4KQIBhXiiPOAWSaMA/q7iWXpXNPdcQA5iTLbNseSrDIxyGc2pHOwLyLDf3FqW7QglnV1lHhk5EdmKn+U6G53aOGGyWjMn+Cn5tIr8oB/6wWpb8TSb6lXaLt2zrvPmo6kXFbwrhWYujTHZmVSxz6tUoq4BLHJFujLINCI=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by CH2PR10MB4343.namprd10.prod.outlook.com (2603:10b6:610:a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 8 Jan
 2025 01:32:25 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::a6fc:c6a3:7290:5d1d]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::a6fc:c6a3:7290:5d1d%4]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 01:32:25 +0000
Message-ID: <c743a9ac-9e8c-4e23-8d15-24463b2d9683@oracle.com>
Date: Wed, 8 Jan 2025 07:02:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: test cycle mounting a filesystem right after
 enabling simple quotas
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <c4991049b54536bb7073f3c2118d12dae604d73d.1736265642.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c4991049b54536bb7073f3c2118d12dae604d73d.1736265642.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::16) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|CH2PR10MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fa0e19c-a147-47cc-6f3d-08dd2f844d2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFdHK1Vqa0pRVnVyMHU0TGtXVlRWVElYejJYRXEydU1DV0FrWlJmTk50WFFG?=
 =?utf-8?B?NS9xd1k4MjdFenQyUEM2UExjM1ZCVWlVMzNDNytlaFQ1OS9sR1BrZFI4d3Mz?=
 =?utf-8?B?Ums4T0ZLbktST0xHMXk2UkdLd2FjNnJaVGdZZ1ZlV3FMUjF0aUJIK1lFYmdH?=
 =?utf-8?B?Tm1YakMzSDM3bklaYnlEWjNhVTAwNnpoMlRSa3JqMXNGQUx3MXFNdmVYMGpK?=
 =?utf-8?B?bTN1R3dRcXpGaXVwRmFSYW9hOVk3KzZxbGFzMjBPUzBQVVdTWkRzL2ZGdVoy?=
 =?utf-8?B?QUMzZjdrcUl6eTFpQkdWdVJ6M0ZzQmRMQVJleDJUaWcvYXNpa3JvTWJtSS9J?=
 =?utf-8?B?MExMZHdGUnBFc1pENnk2ZDlFYU1IZzVPaEVVaUNBZk1tWVFhSmxFTE1naHNw?=
 =?utf-8?B?UWdCdGpGOGdWcjBZTllLd3VxcEdNUEEyRmhFdHZYUGd0Q250M3NaNEhmZFpE?=
 =?utf-8?B?Z2R0aG5NMGJZZ2t6NkVPNHE1QUFIM2pQcHcydThpTDMxMWFLNU5SQ1VKa012?=
 =?utf-8?B?UDFKbDk0MExuU1NWZlVEMEdKY1NYbkc2RUNmZkRwcFc4cG45RzRZVzVJSjhs?=
 =?utf-8?B?emg0KzJBR2d3bC9vV3M0eDFDcFhmTFkxaitVUWNjeFZYT2MyRlBVcU12cmI1?=
 =?utf-8?B?eDd5b1pSRmQyQlJNeXUyR0ltSExXWjZnRkR6empwZktjZE1rTmJJYmwxZGhU?=
 =?utf-8?B?cHp3alR2WnZkWjV4cXIxdUEyZXhLbXp0UytEVFd2ZVNmNFdPMFNYbjM4SmNS?=
 =?utf-8?B?SGo1WUZMejNmZXRZTWNjdXJ6UFZLQ0NMaVFRZFBJNmFGdGZzamRxMG5PbEo2?=
 =?utf-8?B?bmxUQWkzbFpnaUdwRDVuc1VqZGJ1UEFHbGQ4ak54YitrUzFBM09EQWMvejAz?=
 =?utf-8?B?aFI2UXhCbDlVVDNNVXdqYUVuQTlaVlVQWGlQK21BUEpWQjVRSWd1MWYxdUh5?=
 =?utf-8?B?OFNVdHlSaXgwWFllQS85djZLMW5XTmIzVjRZSStkU1pTK1hpWmwzT3h2M0lT?=
 =?utf-8?B?S08yN2JLRkhKdUNoR0NtMTMvRWtQVnJVd0pqcUxZdXBiRWFOYnkyUDJHN2Rn?=
 =?utf-8?B?TGhLSUxBOUxOelRzbEJYQXFKcGpISExQSUR5b3Zzd2ZkVElGVVNOSGMwZEky?=
 =?utf-8?B?UUdDN3p3dmVpMEQ5V3NML2lGL0h2SlplL0ZncDE4UmdwQ1g5emZqaWlBUllF?=
 =?utf-8?B?aGpzdEY1N2FiWHFVK2d4blVaKzA0UXdEYitYeDl3Z3l0VVpsK1JnMUEvWUxU?=
 =?utf-8?B?cmN0MWh1R3FYdmR6QWdkL0dWQVV5V2dkdWx6MnVwVFhJRXhNOHBJQ0orZDJV?=
 =?utf-8?B?eHdZZTRPSHYwMExWMTA0TnQ2blVmenVuMUlLQWgzcEM3NnhRbHNMYjBjMTVX?=
 =?utf-8?B?NmFnSkQ5RlJ0ZENzbXBlbkRHa3BkdUVRUFNURyt3aWJGWHRnNHVGK0ZUbXRr?=
 =?utf-8?B?TUVCRHptdG5Cd3VYbEV2eUxSZURtR0FkWHphNWNubWNxNVZYN1Rldm11bHND?=
 =?utf-8?B?clRwMjM3dmxOQ0RTVzlHNUwwKzViZ3pleTNpSWtRRHUyeUdyK2FQY2NWQXBQ?=
 =?utf-8?B?VUNEc0lIdjIwVnpHeEp6T1BVYm1ySG1vTDVwN01PKzBWNFNSQnB3MDBCbzVE?=
 =?utf-8?B?YzFYaGQ3OWM3NDJNZmExbGhRS0tUbUE0a0xUMFFmK3hac1BSRVFnbFhaMGF5?=
 =?utf-8?B?WFRMaWZvdFMrYlMwNkI1aWQzS1RnVk44bDZLUHZsbG1iK3dDTUpueXJBSWNs?=
 =?utf-8?B?cDdSSlo3M3ZTMHBrdTJYeldoeFFha2JGemIxeDR2eEVYR3MybkM4Z1pvRE9Y?=
 =?utf-8?B?TzZhcUdoSWxncmhBUWRBOTJ2M0UwOUhIOTlNQlNiY1ovTnEyV0hwVzlabURn?=
 =?utf-8?Q?yW3TkeoNA59w3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXdwMktxQ0JQcTRRaUYwcDlpV2VVeGNPUmVia1lzNWNldm9uRCtGd2RLNXNn?=
 =?utf-8?B?aHl4Q1Avam1uczdGMmE0aWJTRlc0dXd0SFRsL3dMU3NJbHRGaDVqUjVoUXhl?=
 =?utf-8?B?N1U1dlRya25wWUFNU3N3bFhZeEtZVTFqRXpjRjNTSjZBaFhnOTMyb3I4TEwx?=
 =?utf-8?B?ei9nK1dYNldaYXc0bWJ1SXhqWEhlemo3c2RCbFIxMHhiOC9sajRiVTNPY2N2?=
 =?utf-8?B?Y2NKRlhZY0k4dnVyTUE4RGI3NEZBRUM2ZUhNeEtTYUpGeG1lT0dtOHFIYlJa?=
 =?utf-8?B?Y3JiajNKdi8rOHo3YUVIYkZtV05JZHdWd29JRzg2VHUvMHFlMmNodndhZjZh?=
 =?utf-8?B?d3g3T0RPa1JRWjcvYzVFRXFJWnZHUzd2MTFROG1QUXJSZG56VXIwT1lHYUFl?=
 =?utf-8?B?WEJVWGFwVXpGNFp1U0NVR210c3pDb3BNOEgzVFcvOW4wTkNyRE5VM21uYlZV?=
 =?utf-8?B?MkowVUVJekoxem9RUXl0MDZ4OVJubXpkaHZVWDBQeUtUK05tR1FJb0ZDYUho?=
 =?utf-8?B?TTVMRTZBTWdOUkhYNkZEenErTmhoWWR5MEVzbk9KVjJKd1FMQmdIZ3ZVTnIw?=
 =?utf-8?B?SzZFUmdQRExKUXdLSDUxRGhqNmloR2ovWlRWaktjdTZQU1kyd1JWSXhtNzhL?=
 =?utf-8?B?RndaeUJaNHhibEJRZytiZEQrMFpXR0NlaUhRUzBWUWJXNWEwY2tZcSt3eTU4?=
 =?utf-8?B?ZFlLZVlNSWN1NjVqS0lUVGMzblZCM1lxN2VHdU0zVG8wSG5SblliUVBQeVdY?=
 =?utf-8?B?VkkwQ2w1RzZ2VkltbWVqeVpvMW56dmM0TGptRUp4SCtETGtWakc4dHMzTlUy?=
 =?utf-8?B?aVp1ZStIamVvM1B6MTRWRXJ0dTRPL1hkRHh4MnJDSFJVc1pKUkRqOVVnbnEz?=
 =?utf-8?B?VU5yUlp2blp1M25TVXdhTDZiYWVjek5oK1dWYldpbDlQeG05N0hPQzM0bTVi?=
 =?utf-8?B?KzZQUXhOYVh6MnowK2RneVhCU1M0TktyN3VVUEZoeW83YVUyeitSUnk2Q3E5?=
 =?utf-8?B?WGVwL3kzOUlmUGMzZHBQU0M4T3NwNS9oaHcxS0FUMUx5V3VBczJWMWZMTGZy?=
 =?utf-8?B?RXJmN3hLZnJvV05HSTR1blRIMkJubE5kcWZXY0ZZMlhnS1ROa0hKQkRzQ09i?=
 =?utf-8?B?MVJybjZEWWppR0NiTCt3dzVKR3o0TmNBTWNEWHM4T2RFVHI3UGE5RXJGOG95?=
 =?utf-8?B?MmVmNmN4ODU3ai9qNmx0WHBRL2pxcis1MFZ5cSs4SFY1NCtDdFV2K054SUJL?=
 =?utf-8?B?Rk9rakpORnFyaXdvc2dvekdqbkhoNVY5S2FEWjlYckRKck9SajVwQkNndFJh?=
 =?utf-8?B?UlNOQUZaa2lZa2JpUXBBRWNubmNMY1ZidkVId2xiby9BdkVHVkdrNThXQnFO?=
 =?utf-8?B?dFpUT0R0UjEwamdJSHFnVURnSHFqMjZPMUh4aVA5ZDFnck4zT2JHYUVtVjd4?=
 =?utf-8?B?SDMvVHZQV09mWjVYK0NIWWcyMjdhZnVaU0dPcTkyRDkwRHlNRE9KR0FCZGRM?=
 =?utf-8?B?NlRFcFRXc2ZTc3hJYkNBY0E0OFBiMkh5U1hnQTBRKzZ4eWVtUmVjeFNpa1Az?=
 =?utf-8?B?V3NGMTNkbnNsN0x0OHV2Z25ZU3o2VHNTYUs4eGpaZFpyVWtqbVNtMUxXM0I1?=
 =?utf-8?B?azdHZEFiS3g4a0h6TmhqZ3hoY2FYMFZ4U082bUIyVVEvdDJvRDd2WlhHZHhE?=
 =?utf-8?B?Zy9QeXcrd1h2emFzMjROUnA4ZWI3dnVYQ294SGM2dkVKWWZDeUN4UjVRSFNW?=
 =?utf-8?B?c29sMnFESVZ4MnBoVjMwOGpXcnlTOEl4QmVlZkNUOE5Zc25laUhENU81MWNs?=
 =?utf-8?B?SFR0Rno2Q0M2SWJRNVF1Q0VWbkNnUU4zeW8rcXRVRnlOTEdqY3B1bjBLM2F3?=
 =?utf-8?B?OURiRkNjSENkTjRscDc2YlNpT3pnN3Q3Q0R4eTJuUXJCSm5VRFhnNWNoY0Qr?=
 =?utf-8?B?OEsrLzFkOW1JdnRLMWtZSHlJeTl2bXg3eTFBNkMrZTBIZE44bFpoMUtiMVB0?=
 =?utf-8?B?S25acmtHOTNDZGhPZkkxZ2dwRTNoeW9zTHZyNXNkVnM2U2ZwS05KNzFIVlIv?=
 =?utf-8?B?U0YyeUtWT3hjRnNId2toMk1jS1Q5TnZ0djFjcVhHQXBMdWhQQlRTclZPVDZp?=
 =?utf-8?B?cGg3YVp0bGtacXhaL040NThBWi9lM2piS0hTVWY4QUlYNFljRnBZTFJOSUlN?=
 =?utf-8?Q?WZxVDYWs3p0fmhUMdnInIEl9KfTmtUvei3rqkhzzcVcY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JaRGuXUIzng70mWHRvtwgZ2X/VYbLOv32YqpMUdxb42rtuH0mbs1yF4iHwQaR1r3CRTYyky0atGf0OMp5tyIxrQTHIzy6cil/83Yf4LRkecPNt+L2W/T+vQfZGwIAsLKANiJUVlvRciH8mnHt7oEvPL9Qh+IzRUz0oDSiPMfPoVeb2b2Fu3NlTo0nnx8gPH/FutDHniFRyQlOEPJ+W+s6ydpGnWf9PnUe7cJK46S1T4C5OBgJlx5U1mtuKp/NF+v3VAKl42L87cf+aTmOe3xbl4xqo/8yZJSty2J5MkJ/D70mi2ibm+VcQBeZ1UZPFZbMSMOVy2c/WsZ7fbRLiXPgjVdxbQPweyUDfeeMJCkhhv9Mp6RDksb/wpjAjLdzsc4XXwt90ipJDUTC1nV5M3EXV/2t+YomgteKsyTK8yhDZKWpiWLOQWZwbwU6PlKEoqCLFIWjKlyrEuPB4EpjWsbyCXGkAzwyCoa3qr/s12cpEAxwGHwK0QOfPj2a2a+vOkZY8nbNPl2vxW3SMYYm/RB6oR7l5kFT1f9RmfhsboQda6lOCjjrNFx/nOx12USX847WkRLiLGB2iJ10bMMV8Bba+GInszJm8xU4eqgIZWpxi0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa0e19c-a147-47cc-6f3d-08dd2f844d2a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 01:32:25.4249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCa/W0MgtckZcH39c+3ahPJ6uiLdiEo5xej0eSEDzODP2ckhn4xN+iLNSyLM9RA3j/CdbgeOskqu1ux6OAOZvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4343
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-07_06,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080008
X-Proofpoint-GUID: YH4mKAs2wvV5D4Bg_ARH134AJaClb8dK
X-Proofpoint-ORIG-GUID: YH4mKAs2wvV5D4Bg_ARH134AJaClb8dK


looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


Thx.

