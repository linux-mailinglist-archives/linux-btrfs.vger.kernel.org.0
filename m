Return-Path: <linux-btrfs+bounces-3270-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538C287B637
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 02:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785261C21C58
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 01:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9590B5256;
	Thu, 14 Mar 2024 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UhWByL7h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aRgrF2hF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6298E3D76;
	Thu, 14 Mar 2024 01:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710381146; cv=fail; b=RX1eCmSDwcGRxYE6eROd+3Y/GMEmsDmxvih1b/X2VL66boBIVeMML3Otg7/K13ALgBid6cPyuir+5Bll0FRwPf/ZLAH2YwAxwHpnVcEMi9Ig08Eo+npO/w2yavUu0Dytx0b0zEPYDdFLvtwqfoyiazuzJZ7wZeVuFa4YRSqjy0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710381146; c=relaxed/simple;
	bh=BywWynmJXx14zv92p99hcqqQvQo9j5aqGNUS4ggcptg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lRxSz+FUKft0XiA9x5RAdoyt9+VLq1M3p843myjznN8e6IpDIpQBuuHIQmE5h+mtukEDhL999LXYO995kjaJC7gwMNt0x9jCLQZEjbfdKh5OfxassEGbB1snwuCJlSKivd77xiZuia3JNXNPYFi4MuQy+zwSes4Q1m+X4+LXsME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UhWByL7h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aRgrF2hF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DKwt31001352;
	Thu, 14 Mar 2024 01:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=o+KxawhUR94sOKP9B3CmPaydQdWm3RW+79Yn1cXIkaE=;
 b=UhWByL7hB3ktmWsWMiwWnrK3YsPr6OBjqdVHpuoBQBHkaqUdYaSAmb4mYp+F0pVVpUSE
 fsKyRXsidlmdZfbZJ1shQ4EX0m7frrzdJnNTWebnebcPoJtW7UcJoSAXvGyQZC/g4aX8
 iB2LvGXAaQ/ivNkBQCwvgN1Fv8KfuQkc1VBQIqkQ29zwrGMiHsYwsrd1UlnKUduKIQqA
 0KOie8CGJkfEopDXTb4xgDXvzYf343mi0o3ReR6tHzYGW8hWUutTdDj5FsfQKfCeVCuL
 5fySDSIKg11sowlkaHMZH6YFmoMaMZJb6XtqkdQPm1GbPLpm+bOiEgzTG8rtN81UTjBa rA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfcujd9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 01:52:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42DNOsW5037806;
	Thu, 14 Mar 2024 01:52:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre79pk8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 01:52:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIWbanX4l+EheBVhL5b2b1Q4WEGRXIdWcP8AZqz39TSs9oqk2aviauaSHg0Iy/D83dcnBOzL4vcbVj3qvn+2dmUyUe+IK/Ap7BExyEXDw9UVfbA6kPZkJDSNISA80fAYY3A2UN8IjttRwECCVeWAZY2YgYIkydUQmI4mGZE+szyKFJZbab82rWbAcgs9pGJMNczPpBJ5gn8csjAyA/+6jP03J/cAC80qPLs8QVJ3G3QMGRwKkA4zwHZzG2SH+j9RPqyQlRE0wWdaazERh1UU2rLkg8svImiSTBLsb726zt7W/nF0I8PjotZxZcjWbAecLbJe2sULe6BSVtPhEOPsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+KxawhUR94sOKP9B3CmPaydQdWm3RW+79Yn1cXIkaE=;
 b=JMrZcvu2rWaaYi0YcrDqjRHOWjg8ydiQR4HDNszH+/LRBJxjenGlOzEJMVGdltgSYUBTTxlBkeN310itJKyaEBy6LWrdDbFb8SbMH84tKTNkf29GLFs/qv+ovO5IxQZKSnWYCEa0N0ClHlgzeuUTeKUAa+mDAf2NZKiFhZw5sgNY/iE3KNgQJCjC5qTKEWzN5N9/P6CQxauuOuaqg/iOWIhlvI42dU0iYwOloO9+1ujkQHNlvndmunRKxrMLTQQ7bZlXOygfj8rtO3hIssPdKsH+EJ1VGy+rz0QrL93l2lFrMcAyjQEceLFHsRyz8GFTnkT2IvT4AYdzWDLYI+K3Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+KxawhUR94sOKP9B3CmPaydQdWm3RW+79Yn1cXIkaE=;
 b=aRgrF2hF6PzzNucNY1stUHVUnHi6Cb1nVeyeaw033NXFYmBp4N7lFIgWhZUJrgi/T0n87toDcuaOi6byq3Y07ke7KlxJSJ/n9mNtnzqIVVY9vkZqccHDtpgJMWxLpKWZ8mRfgvd4NjKvi3gIjagwuufGtGLbITNbiGuGOwa4D/g=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6779.namprd10.prod.outlook.com (2603:10b6:930:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 01:52:16 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 01:52:16 +0000
Message-ID: <18a7d3ab-1396-49d1-8754-ba17023d6cfb@oracle.com>
Date: Thu, 14 Mar 2024 07:22:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/316: use rescan wrapper
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <3528774789271f9e46918f8b1d1461dad0e11cc4.1710373423.git.boris@bur.io>
 <5c2dd52fecbc5ac86068a725875882e3000bc969.1710373423.git.boris@bur.io>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <5c2dd52fecbc5ac86068a725875882e3000bc969.1710373423.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::36) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df29c77-86b0-4ff1-c8cc-08dc43c9603b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SuCK+a907gpJNiP/hMJF8AvSo30n9q7rFb2unhYu8EGFYJzTybovsgA3w2/UVbEVcMClih8xwOhlUg85LlpDQATiulPKHtYmiWVv74KUmS7FvLrHcStS4+DE9yIkseAl1SUCPizWt1Wzk3yGdL2w+KvWlY2EVIHBeLiq0u/DSxKwtmzlskfujk/56xgebAwJ6v5uVOiZzXhufG1OniGE0e4myl6pPhCnDSVAHfZW5d2TekQCyMbMU4nEr2JWvTz0XJE0wiv5rJ5tZl/5s8OHrXYS9/iUHz4EwWxjmUlOjTJ28U4hmEiitOHM3uw42n1GmIqjMT5Ad2J1KUX+M8Qz32+v/uw1+DEmQFwew6TNbMLXhSgsSP3vpuZ15FxE2/5LNIXOE9v/BAPf+UidCGcQ519Yu8xLzUfX0VxZApu7XUwVIxdrx1h3/6b23FyP3r1N75+4kXUdENs+b5d76Ye0UjcXad6dvZgpgy5c55qYFL+60nXC/v/HnBPJ1hx5+zixHisAmcDGbWkr9LdG5sg/LzKMMQffjFnS5EU++S84v3yVdJD+bw/QzOIv9N1RqsNrOfvaZmeLehFX3WL0JGdC0pbPxnW5HgzMKAvH7HaxHfY1NV+DJby87/OTfRzCzUtAQMeyeOJ8qrV6Bf4kxgYPLTcs7DT6NOI5rcO/UUM8H18=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SU8wV3hkWDhTOTE4TjdUT3hMOS9tRUpMcm5nRldVdHEySDN2T3FKblRPOFNY?=
 =?utf-8?B?WnZLZEhlam5wTTVVT1BWQVhFUGFJV0VCRkVrd0NkaUtPUXNBUUwxVmJGWXoy?=
 =?utf-8?B?U3pwQXFvT2FwSUdGdENqUmZtbkVJWDFMLzczTXdxN3BVL1R1KzNaNzRMcURo?=
 =?utf-8?B?R2EwaGVYQi9POHpJYStodnl6TE82c2xITVc3WmwxemdaS2ZRSDA3VlBIOVgr?=
 =?utf-8?B?eWRkdjBMY3RWU1ArYTFPOFBYbVczRTFIdEVYVnpnWUg4SE9uZU1jaHBxZ0tN?=
 =?utf-8?B?anpWZDMrNldoYmtnb1J3MmRNTkIvVHFGVHpsaFo1TkFibklveWpOTUdyZE5M?=
 =?utf-8?B?TGZIVDZGZTBrQ0FBbmZWN25DMGZIVU5ZK0pXanBReDN0WWdHdEVaaHQwYlN1?=
 =?utf-8?B?Q21ybGwzcWRhWFdpdzVCczlHK3QyeWpUVU5ocG10RXpnek5KUTQwLzROemNU?=
 =?utf-8?B?TXZLekdRQnRuTkovVjFvRm56bFZ4dU8zRDRWaEpBOUVJVVlHM3E4ZFZ1c1Ax?=
 =?utf-8?B?UEs1YmN5NkMvTzZybDJYSitJcWMrNXhDNThnbWZ5UlNHT1RXdEx2RHNOME9t?=
 =?utf-8?B?anlqa3VPcGlQdUNzREhnWnlKYlZkQlR6ekxncXVldEdHNk5lL2dkR3BVTjJ0?=
 =?utf-8?B?WXE3YlhlclJVMkl5YXdYdVNCS3A5TjgrVlZxazQxcmRaZCtmUmh6NEJZZ2Rv?=
 =?utf-8?B?WTZYbm9nM1VPMFY0b1BiWXdIckNWSDZsZlNYdFdtVDJtUHNya1dtRmpUd3RD?=
 =?utf-8?B?N2c5YTNIaHNtRUl4RFY2dnVHc0NUVUVGN25oTlR4K05BVjZ3R3R5ZS9WRHFU?=
 =?utf-8?B?MjJ3NnNweVpDU3p3cG5EaDRLakNBY0R0MDdCM2xBOGpLSmFBUm1JVGhQRkdq?=
 =?utf-8?B?bVNvSjF0TWtBTFc2b3UyWlFmNWVyZG0rNVBKMmdIWUlUbzZzK1pJU1VOaFF5?=
 =?utf-8?B?eDdqSHhFSExEZWtJZ1pIaSswSStuall6akRLNFc0VmtkdEJvdFloV0c5RGRq?=
 =?utf-8?B?RDJvZXJhK0ltcnJtc3R1TDV0VG1qUUZmWFhGSldNU1FwNGU4RE4zYXdrMkM0?=
 =?utf-8?B?QS9BZjl5YjIrUGZRMlByejByZ0pSMDluL2UyMVVIQkRrRUVBa0dxdi8rTzJG?=
 =?utf-8?B?NnVKZUl3dllMZW93ZnhETCs0MU5nekN2VUF4OWM4UWo3MEdQMTR3WU0zaXlj?=
 =?utf-8?B?RzlqeDVMeEE4ZGVoclpudTJkMHZsZytKVXcvVjBBNEtvVFU0ZVY3ZmdXRFc3?=
 =?utf-8?B?QWw3WlhFUDhRSHFWZmFxUGFJZ2pqdmU5NVVPU1l2TThxb0k1SnBXVklYQTNy?=
 =?utf-8?B?WWNVZnFzTmM2VFl0dkxiUmNleXRNemNSWkJDOXViZVpsK29BUmxIU3hRdmVQ?=
 =?utf-8?B?V2FGRW1paXFTODFkRkRxZ1pKSFVOWVUyTkJvd0VNajc0eGh4ZXN1djdaeGI5?=
 =?utf-8?B?TVl0U21XVG5UeEpJQTYyQjc1eTZGK0FJTk1CNC96c1lqc014cnl4V1dOQk8w?=
 =?utf-8?B?cmh3MTZIVURVbTRkbmVQY1hUaDdyUitGTisxVkVWTVVIUGZaaGFQSjhzbnl0?=
 =?utf-8?B?WkhyclZTazFEajEwckJxa2dOend4RHpmbXFSWVVZZmtUVFpaNTc3c1B1ZVlK?=
 =?utf-8?B?ekRLNzV6alRxenV1dENIOENlOUl4S2F1azhRTzc3UnZUVExrek5FTjdlcjhV?=
 =?utf-8?B?ZlN2RDZlRy9GYW1laEJaY0ZCUTh1aXE2Qm41R1VGemtMUkVQeERhblVUVWY1?=
 =?utf-8?B?ZmcyRGZxcWcyVDdrbHlxekErQzk2WDhvamNoTDVJNGtqRHpDSk9NVjJmUHYy?=
 =?utf-8?B?b3NZN25oREVjVytIT05rQUduSVNPMjh2cStnaHkrMVFoMTB0MGNWMjNFOTFu?=
 =?utf-8?B?WHZibC9HM0NoM2djbjlNUnJXaENMdmsyUUJVKzBJMGJJZWNKeWNnSkdCT3Va?=
 =?utf-8?B?UWNLS3kxemwrelVVTHZ1TEpaYjRwUFJ2eUU5MmRzTVdWaGVkYU82TTdHSGZP?=
 =?utf-8?B?S0JLMG5uWDZBLzdiUm9qSlRpYkRGL3liYnFQa2d2WWxPTGVZUlRBZVdBTzZt?=
 =?utf-8?B?TnZoTnY2TlN3SlRqTVBKQ3FGV2tnRG43UUZJbnpaY0NTUG51djV4UzFodW1N?=
 =?utf-8?Q?WEvJn96+xhHap4Q7zcaW6pjyZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0c9FIALSMRoNUzIGUVb/F2YxFZn1T/HfGHIqfrW8Rvp+JU9cZ443VuImJdxPpqnUGqkcCefleOBRE32EyHzLeq7LVqURqE+1aIBAicSjdHN9pif1vpGoZmW92Na8c4qEfYzg4aObZFuIchbfNJ2YWvawW2HQtOVi0UrtpTJpIjhTNgreCew2d6rWqD02zYyAHAmKtkiK+dyaXJx+D+31LOA+VCVd7jR5/RPdyxgtsEXXlgCqcOoHXcQLwLHS1lrU9rkzpRiGgtQOV/VxFOEYBJslq+EZzzPK5lV4sPwunzUa0UXVDiKBsEp/H8QIaR+ifiyqOCeMJM2olcOcqFhkAIECJ8175M07v0SseINxrATK3kAShNytRbChYzIFLky3Z9xwqpi33Qh/TYxy7XJJPOvnIrkAmaszgomPErwU1Sknc4NuLysKm51m1hCpYsiNSs4b4RdKxixm6NoiPyjSzrIiBrJAY8Bqmpiz4Qpl1Sht6XL4+PSPa4LownbErPIUELptdq15/3tVz4RPXjhxMD4ZPniTfO8L0Er/RncTV/Rs1ncTMw7RIR88kXDNs7jEha0hllVH8txJPOfOLSGDQAybJWwR/HXUkw5R9xg+6/4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df29c77-86b0-4ff1-c8cc-08dc43c9603b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 01:52:16.6394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/kLlOnIbFZSbTui1xq7mICTpflFKVXZzP1Kav+uBsX8OF1VIk7gNYohsYw+AVoZZvn3FrKwryZwma3LNTKFxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_11,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140009
X-Proofpoint-ORIG-GUID: X_diUTcP1iQ7av0sDjd8WweLEUZj_CbJ
X-Proofpoint-GUID: X_diUTcP1iQ7av0sDjd8WweLEUZj_CbJ

On 3/14/24 05:16, Boris Burkov wrote:
> btrfs/316 is broken on the squota configuration because it uses a raw
> rescan call which fails, instead of using the rescan wrapper. The test
> passes with squota, so run it (instead of requiring rescan) though I
> suspect it isn't the most meaningful test.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   tests/btrfs/316 | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/316 b/tests/btrfs/316
> index 07a94334a..36fcad7f8 100755
> --- a/tests/btrfs/316
> +++ b/tests/btrfs/316
> @@ -24,7 +24,8 @@ _scratch_mkfs >> $seqres.full
>   _scratch_mount
>   
>   $BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> -$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full

> +#$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full


Delete instead, I'll fix this locally.

> +_qgroup_rescan $SCRATCH_MNT >> $seqres.full
>   

However, we also need.

_require_qgroup_rescan ??

Could you pls confirm. Thx.


>   $BTRFS_UTIL_PROG qgroup create 1/0 $SCRATCH_MNT >> $seqres.full
>   $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subv1 >> $seqres.full


