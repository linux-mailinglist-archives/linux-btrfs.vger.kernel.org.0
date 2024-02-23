Return-Path: <linux-btrfs+bounces-2674-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 553A486178A
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 17:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25FA1F25DE2
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 16:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B354913DB86;
	Fri, 23 Feb 2024 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gXnB5l6t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B8uYW6pX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B185813B79D
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704916; cv=fail; b=bPkoOuGjQJHgQa1LlyIs017njDf10Id0IbYuSV0vV9WzcwlOEpDbwb3QUStTmc2qlIBXuJxJo7AupAtgL3MQuYp+WyCtwWNyL4sSlwlNdymzUFq1qJBHoYjPncu/DnH4Bzfs2+IM7fEE6KScTZGxzrj1TuwFmwM9eRUCeiBCD4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704916; c=relaxed/simple;
	bh=meiTyJftuKWEZ3MZMisHUVK9uum7qxwhU8ewIB2e51w=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pxIpjEwkjAVds7HHUZt1AhsIrMbtfh6cyYzIQAGdH/I/uBV20tz4UApaJQa2Rapx2JIe84gK4T5AWjBx5GihujCD7orh3xbVpFgadClxlEtoR3X5js6akM1p3UNYAEOdBQPKw7bgcddjLqLjXc1xKxkHpsdqH3yCnq0zCKli0yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gXnB5l6t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B8uYW6pX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NG3xKr002935;
	Fri, 23 Feb 2024 16:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=wdA49XIdtuMCqsBJtVkm6tPuDEHWmgitKKPLw/zUQRA=;
 b=gXnB5l6tz8p8jJZDHo+T1yK2tgSUHrYbD1uOu00J4QHjwA4d9Wmo7S13xQrM0uIKpjxV
 Re2+RfdDaI1Gx3Wuhnyhvl9ybcVukE86DzewP3E1O4jXEr+cvTkHPErKD9DrZWs7Rjr3
 vqJlsmIiW0KYtd7n1ug0VUECecu11wupjDxCgLfRe3qJKETJj23r4dvxP9OyryQr8cra
 YYnhHjczcHY4bF3stSK06Je31S+iLgdWVCiYySnhNCWc6EQS2KTn65/twVaPaVltRqjG
 5gNAHslywYyZHTpGiZHk+oOC5KHk/mwJLfkOJJ7urL2p3yUU9lnh9oSdOAM+bxcrOEP8 IQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk483ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 16:15:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41NFihSY030664;
	Fri, 23 Feb 2024 16:15:11 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8c9tc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 16:15:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wzoc060HVipdTKI5FK+RE/8mbJot000ypSHt1OjEIHB2+alVUtOiqT6VSJjZhmuf2kgACraHPE9XIEws3if97mEGHnd8OPTSroNdmyCVf4MAsxlVw40hLJpNcyStON885FqZx0nRzzKqwpSQHgUR2BtNYP+pZ1wWRBachyi0EPmVUqeTXgLsVnl3NU6a51i/I+UzX0b0e6yizDnZIiCiBnU6xh0oy2Dxrwyy3L1L9VkWVQgd7FqYc5xWlwyt2AjHamIpmkjF+MgpmyikUpUa7urYfj2Ih+663mQM4WIDZh29YB0mT7n5R5Z5yERSSNwVJaCdRA27V8Q0vAty19eWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdA49XIdtuMCqsBJtVkm6tPuDEHWmgitKKPLw/zUQRA=;
 b=lG7dpYm9cLaxqPFyxHoJ/sVATGf8oZ/GaZgsaCcjripJYqFVD/mt/wlMG9/GzING8ekzTcR7+VUNDDd13B7UCMnkeA3srnWCpFdGAUKzL7Pf65AUNBAnOD3prZnwQm+Dyfx1n+nHR6bPb0Wr+JUQ8+GH4Vdc/SgiLjMoWESnCQUupZKBstD1fo238tmXtGETLDTn8Bx+7wZ6c5/m4hJC9mEMZo/24CprCaDEwVkzOoyAlUMPn+mC1VnKo4zhmyWlyGSqP26ebxAp5q1QsbW0RBXRV4UrtFVhmFL2jd6TzB9GJon0gvidJI0sFPQIphY5J8S1G/ohuZZdCMqbc+3SGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdA49XIdtuMCqsBJtVkm6tPuDEHWmgitKKPLw/zUQRA=;
 b=B8uYW6pX0fP5+X9QGQ9PKU/C3Q4nobA6TzjvPcOOAy4gBMKOrJ8Vi85sRc8xCUk9u09lpqHM88e6UxJcYI2boZ0vj/wba9QX8ynSArC13dxdAH5u/FK3vWx038oYBVhJX/I8yCdBFrg5H/3z82JV4qsRY3pImiRfR02teHT4AT0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB7473.namprd10.prod.outlook.com (2603:10b6:8:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 16:15:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Fri, 23 Feb 2024
 16:15:09 +0000
Message-ID: <e413899f-9951-44ae-870a-ea280bb061b1@oracle.com>
Date: Fri, 23 Feb 2024 21:45:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: include device major and minor numbers in the
 device scan notice
Content-Language: en-US
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        linux-btrfs@vger.kernel.org
References: <9b8ddccde70488086ea466b33b9cc1e52d0dee3e.1708687432.git.anand.jain@oracle.com>
 <3da9b99e-96ff-4d74-8a74-da8284f169f0@dorminy.me>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <3da9b99e-96ff-4d74-8a74-da8284f169f0@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: bc551b81-bffd-468a-3891-08dc348a9ac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VLjr3G9kBJHhvHZb+mrTWdx8PqOCndjq3FD9YbTrQkiCSsCQ8GaKeJNZojhPUdhQfxKdPy8a7OmjOwVd0wmhdmt1UTJC/avTr7iPLkAg8UZXuP2uZbGw75N/PEPiLCS0zWaDpDq3DgV4u1fzlY3JXIRHoj/xJJMPYW5JhDNxpzV9qtvle0xecPVU0hhuoIKLlixL6uy+RupBvD4KTbVOUJoLSF2LLe1Nphy9qFcFqnaNQ72bKFbUxdePg7SFNKCzr3ZYCFOD2aiBn797ZjrjkeYNdjOIxhiVridV0n6X+CkFc5DA/f7d/B+rG3Zdqr1dKaosD/lFl9GyIQrYUNpXIgSqtUFieaa7LzC3vTk0ujr/EyBIslPY04bL58fjFwymhEJMAci3dgz81SQQ33z4/Ck9LCPhuV5iiQxJUtO4Dd7GiMPgkUapJzXfE3FoM9pdD6V4vWgFtkaxUSUM1rDjfww66BO3OqIaOY5eSStySAE88+B/PS8zanLlDZ711mD2IjbWkd93HMGUgjZ4iEzzrA+rPe14j8/+x2oKczYj9BU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YVhOSnFUVjNKN2VCZU5uRnVXQ3BpOGdYSlUzd2xWVlBHcmVnLzZXNkNrcTNw?=
 =?utf-8?B?QkxBWVpZVXMrLzl4MC85MEdHS3lCT2owNGNVZUxReXBsVXV4ditsa0pncHd1?=
 =?utf-8?B?T3czZDF3K2ZvUFFhYXBscm9pa1hQejUydjJKdEcyZ0FDeWlzRnVCamdzTU1o?=
 =?utf-8?B?WGd1VjdMNHFpaVYvSnRydTUxQ0g4THNUVGdVVWJraXYvT0Q2ekt5TDZLZE5O?=
 =?utf-8?B?ZmRwWEpmRVJLa1kzS0pzQjRHVmJLb1Jsb0JkTVZNUnRDWGlISWJYWUd0Yzc0?=
 =?utf-8?B?RHpMRE0rd1pvR3pOTVE2U1RKcnRzK2RsU0RMRzBhOUdWclRBbm9Pa015SmVp?=
 =?utf-8?B?OXZNY2pDc2pyb2xJL1hES09GbDdnalF4N0hUSlpaOGJBUFVEOWxTOUtaaVMz?=
 =?utf-8?B?L1RpenMwamtGeFZiZndhK3B1YjlISGoyZ0kybmdUNlRDRXZMekZNU2JKdUt6?=
 =?utf-8?B?eXJQMHpjeFlYa0hnK0MxU3k4RDNjYmR2c1lVSEw0RnQ3a2FlK3V6Z1ZydnRD?=
 =?utf-8?B?MUFJdEZGOHZWeWRsOWY4clFCcTBOMHoyejdZbDBTTjFzU1ZPb3NZcGNtT2h6?=
 =?utf-8?B?YjF4dSsrYnN6MkdxcWpyeHRlNno2ZHFGcmx5d3VkOWNSdlorWlUzYVJMQXlK?=
 =?utf-8?B?K2o5NWU4UmovQmgyRFBWR0hYZmYxRVVxYmF4dWtQWjR6N3ovbk9KZ3UyNUJJ?=
 =?utf-8?B?ekZuYThWUGNhWHU3ZjBXVkh1a0FKY0ZWbkhacUI0K2VMbUpJRk0za3lyVVNG?=
 =?utf-8?B?V3lXRzY1R3ArREs5VW9ScE1iS21taTdMVHBRVmJNa0RpNXV5M0o4YTgyaVNs?=
 =?utf-8?B?NkgyZFlpTXZ2cnlnRVFicFFMUlo1ZXV2a2lwV05QZWt1eVowWlB4T3pVR2VX?=
 =?utf-8?B?ODR3VytXcmNhaXVHSFczVldxOExQdTFGc0hoU0NvNENWWUUwQ09kdEIyTW1D?=
 =?utf-8?B?VHdpT1A0Z0p6cE9XbmxubEVqNHMyelpncW9NUG16OXVjckpCN2dLVHhuai9Q?=
 =?utf-8?B?a2h3ZlJlZWNlR0pnL1hVZVR3K0RGWG5Ya0pLdXE2UUdrTnBjMnl6ak1mdXEy?=
 =?utf-8?B?M2tjYkhLdlJtSVY3QldRY21RWjJMYVB3NGJWeWg0cXV1bVNaWG12Z3BYRytE?=
 =?utf-8?B?NVdsMGRWTE12dTRtckNNVWFWbVE5NW1Ba0UvcmxGdXkrVDc0bnhCcjQzUUQ1?=
 =?utf-8?B?akU1WUZUVFREODVjbU9vbG5WTmg2TFRuZU9reGVZeUUyRWJ5RW5sRTBFaWxz?=
 =?utf-8?B?cjROL2NWa3pJZGwyOVluK0pUampLenRRUjIxNWF0d0o3MGFzbDJDSk4yUjk0?=
 =?utf-8?B?RmFhcWdCNTVleUlkc0RES3drT1JMR1VLeW5EYzI4MGJkRWdVZHArKzZKNlNy?=
 =?utf-8?B?bnRJMTlqWUFKbTdEQW9MWFcza0gvOTRuSzdmVUE0d2MrNEVBZzNjZVYxWUNO?=
 =?utf-8?B?YllyZ3RaQnFtK2ErVDhITjQwQ0JkVmRzTngwVzZTajh3dVhFZmw5Z1F5MEdh?=
 =?utf-8?B?MzhPSlJJRmcyT1J4S3g0dVdNeFVGWFFmSnlRM3g4ZXh5KzVSUTJtRmFMcmFS?=
 =?utf-8?B?SUs2eXFZVEtPM0oyWWRWbU5nVG90ZlNZaXV2M2FXUnRmd3Z0UmwxdzczK0w0?=
 =?utf-8?B?b0g0WGJ2NVVoMExOTE8wMlE3cko0NjRpMFMvS1Q4L0I5bERldWFOaE1LTEZ1?=
 =?utf-8?B?MUFrdTJaQytoSWZFTVNLbU9oTUZFK2FIK2ZNcGJqQ1lXdzA3QjB0QStHaXhz?=
 =?utf-8?B?RW14cHN0ajRYU0xCNG42ZERKTkxrTjE2eXFINnRRK2FEZ1l5SWdLR20yZnR1?=
 =?utf-8?B?dSs5MUZFZnArTFVXSXpVaWZrWnl3djNPUDliVjZSWkNPaW9IUWJEdmJqMXdF?=
 =?utf-8?B?Y1c4OTFNSEhxaUl4QVZxS3ZiVmtjRDgvRys2b2wxUEZlYlBjQ2hINEFBeVJH?=
 =?utf-8?B?L3ZpVzNLejBQNUI5VGYrUHN2V3JnazZhelpjR1NCOUFlMGJDWm5UUmowa3ZO?=
 =?utf-8?B?SHU0d3Z1VEg2dkFKSWJZbEFIdUt6a2FBN3F0dFE5bUZuT1JiTVhsN2FJU2ZZ?=
 =?utf-8?B?L2RGWG1QNUUxYm5lTVk4UkRYd1VMVzhFM1ROSE9wWFpsdm9hTkxNRkc0bUND?=
 =?utf-8?Q?HIAThCO8zr6FOU3F3nczCZhQY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	P7c29mQj6ulUPRaFZA+RQjzHdFwFJlpSiF33aLQZEbq3AkhtXnOiKlcmP1EQflSARXsRjfPvnLni0120U5exNQCPxfTv3XRz4+qJm8o/R71PSjf6P32ZHvAOacn3rTRbR0RXpXV7zNA3z468J2ou9yPzH779vv3PQmeeXy7ZQ0ivjvGkV7CtI28K2hXjDFgAWKTLRm0EEBBjjaXPyKmsFvHEgaGhkT2ZO1NzAcz8cNaaDJQcR4Ia83lIyiowzHIqpMkdDyzbzGIJn4Mz9sjxVJ5Pxj2GohjQ9fm+FslJGSwWudjalsq+fXtPFbgXvkSESubgo9iAfoS+O/qVK8CoFrihiDpxC8+6vRJnHITxaw0uBH5SE1jlNZNOpR2g0NsduA6NtkhyRs0HLD42NdIh0P7M2+N2eKXQML9WsNPfmzppBjL5RxZr+tRaY4eZm5rOf6xjh205iJBLU5DGK+ZTQUJ5cXYwVQIqxS9ErKV1AEWvqQ8T9EMOOdvyUGW0TTeFuFDSfAhcvU0RJXsdTFVHDgM8+4YRrpflpgzPQCGxosbZZtUSXWr4zbac3BGBXJApO6WdrjBERWf79CI/bZdblO8CAq/C43CaZGBc4LQUEMc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc551b81-bffd-468a-3891-08dc348a9ac1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 16:15:09.0244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vmRBrvJCN1Mw0CZsQ8/2b9T6ytw+cezQNNN0358mg19Tr+1L8gU181zkQf33E+xxuwRKxgwQbzNG+O/CakkyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7473
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_02,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230118
X-Proofpoint-ORIG-GUID: ZxMFCgSPw3c86QECsCqIsEKWP6z5YhIJ
X-Proofpoint-GUID: ZxMFCgSPw3c86QECsCqIsEKWP6z5YhIJ



On 2/23/24 21:42, Sweet Tea Dorminy wrote:
> 
> 
> On 2/23/24 06:26, Anand Jain wrote:
>> To better debug issues surrounding device scans, include the device's
>> major and minor numbers in the device scan notice for btrfs.
>>
> 
> It would also be nice to add in maj:min into all the error messages in 
> that function too, if you're sending a new version. Or I can send 
> another patch with that if it feels too different in spirit to you.
> 

Sure, I'll add that, certainly these logs need clarity. Thanks.

-Anand

> But either way (with Filipe's adjustment):
> Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

