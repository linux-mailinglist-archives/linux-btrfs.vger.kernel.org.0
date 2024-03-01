Return-Path: <linux-btrfs+bounces-2961-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731F086D9C7
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 03:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBBA1284F2B
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 02:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152883FB21;
	Fri,  1 Mar 2024 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CDby2TRc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Uz2grRmV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8A42BAF1
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Mar 2024 02:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709260321; cv=fail; b=f3kK5SOeNpI6A89+pupv2ofxNgLkkhFKTm1bzYxDnTEobMWlRulc4s5rE45xvP3Nu5LFoai8suGNpmHmr+0XMd3SlH+k5pSxpf27+7u7YPhWFrlrMbyGmKH7sMku5qMD1hEo350mBy1ObiazZ9AViuE04DXpY912p44vHoan89k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709260321; c=relaxed/simple;
	bh=v9tggiXJkWeD6a4qpdlVoHl7LDilyy46dhbdB13/hsE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tSwSO2wE8/4dLEiWSwxfFmg4DKHaGsXAqCECzORJYkF1mlXt6PKG9XnbA3r6zWKRlTnIZ1jWodkvNZCytSa0WwAmAVg7BlImB1lY8G9PkxcxkMI8LCLNWqBAWZfVeIIZ86+xkNegI8SKH1AXoju6hAR8MH0yEHaA5N/eXG23cgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CDby2TRc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Uz2grRmV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4210igEb018276;
	Fri, 1 Mar 2024 02:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=k8H5O9mbYw8lWktc+VceNm2PutVElCTg6sGIVdsFpn8=;
 b=CDby2TRcvbX7MwdpBmY7V38ZZeS1Z0SO6uZcoKw/GiwLZAaIEpGxoQ6gMehgmCrkfOB9
 4AiBb6u4ifFaZpPSpDNCrUqzgRQRh8oF7Vpzbwr0vR/d+qPSXAhy1xuA6LG734vu+/jS
 zzNAR4tzf9d9qIJUZIOKdCFyNzXDdRUZW/Xgb8G+jLjcRPcobmBPKv8j/m+BSvW4MA3k
 YV3zhcGAKkmg6pweV0y4TVgcX7i1sAJElTR9O2XCbxZS6jHjcuPhtNqN0Pb4EML+QjSo
 mP7vm/NqVCjvGZ/7969CUYv/xvfkvMMBNX35iBJWBse6f5xccgyhCXejj0/yvQ9yAAqO xg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7ccqfw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 02:31:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4210wFSj005686;
	Fri, 1 Mar 2024 02:31:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wjrrbca4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 02:31:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebqmfpFHWmjNKdOZMC1nXYIZfpAh9doHm2ltsD/eESytpKLafYoe3VJd/2tsvHsBaUiAr9TSd2VyNHzv8dLAFCQN32gUsJy6JWV5bogcvtUyzQTWWbRyWvztRBlEEzrpddkWWtwKGMsaDg+druBAf1xCMO3bYahTP9VvESpC7Lc67PX5Onu2+5CieARd3s+GP7VSwWRJ1F9JkAZw2+y7QpHV0XRfxbZnjeDdbbez5OHMoM4OQfeP3M2A4AH/GfzEs01kvub0/BXoOmUUPAN3NmdA10kufxqe94i6dKXV4c7VaJvCYjaiL/nMGfOOVbE6BIfHANXUgVA6CtM5NOZTXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8H5O9mbYw8lWktc+VceNm2PutVElCTg6sGIVdsFpn8=;
 b=Rux0R5YMF1YkzZ1qyJWAf6VhIEWzLXJtiJosOIdS3YVPczaGhRWIrIygnNY+37Bm1o9iJj9uwjEXIjHSCeffudFbNlcky1Vf1xnxbm+7s3PjP69TyvWjnHtDcgUPBAbvDR6mAG0jc9/leqz+/cR04s4TTfWkI95+Mf39OWDYbFIU4rR/L/hyCI0n0AfUZmlalbypHX9j596A9Ac4gJIqEPnJvXtS8N2d2zJLCiZCL4BlQxxClmWlmy3awbpIRapvLVBdPfAYNNxsKAMhpQNPOz+dx5YTWKsNGClUtaKMyfVsTmLhf46Us6PAeRoxRXnX2Y8/T3IrszFwkrfVBK7ATA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8H5O9mbYw8lWktc+VceNm2PutVElCTg6sGIVdsFpn8=;
 b=Uz2grRmVRmumB9ql58dBXwcizbThtnTQAGTSW9y48/8akTToZw5agzqRb9vaaXXEern2pVQhaL8wgbP0w71QeCygAm4eH+Kh++p2v/0WKJqRJnwWOAImM5+A7zPWqrM5MmmWnelumiOMaYSiUlS4/5XQCv75Zy+TiE4vxLzbUQU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB7100.namprd10.prod.outlook.com (2603:10b6:510:28b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Fri, 1 Mar
 2024 02:31:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Fri, 1 Mar 2024
 02:31:52 +0000
Message-ID: <751eba3d-c72e-475b-8d21-e15c1d085ce0@oracle.com>
Date: Fri, 1 Mar 2024 08:01:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs-progs: forget removed devices
Content-Language: en-US
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1709231441.git.boris@bur.io>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1709231441.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: c1852184-673a-4140-434b-08dc3997c0cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/wKzEOcsqVKkPCqa/oBllXqZX+hlugv1KFZK21tEoaoxBRkcCovqLkdw8JfsYOfgSuCXfe9yKwk6An0zCdlxVlBiy0e3E6bv1yKjLrr9xqSMqh0qHUeW9NnSauj8qf94NVrDnHN0E9rrRwFXxQqDslxJJGdn9ECPtXYnyuYJvlvASXuIK88F+ja7h7Oj4m29dpL6CMyvrwJP7aJoGKRUkZJBPQrdZwu9X8Ot2t0Lu7XlLjWcbXWONy3G28wJkzk/CzNRRaylqDoyBNIHq3kyQs7wovb9gF6C6FE11ASxptbch3A8s32e7rfBjje8Pu37jJ9lKRLHtYACbGshCMZRXrgqFOPccqGKBKWkoNQn07QxDL7P1x4O78A7vDyX6S7siZgb3irFGB4x+2cXk9Onc2c81/H8pfmXXMQmwoeBMV8ju1Rh1DOmMuyBuD0WLRprhollj4tsKwNmVinFSbgws2fihladA7yg1JdZiA1Jim9FODpBsYmaMuPGBkFTBTZeBB7hj0XPBEL7O3lNoQowzz4zDY/1jRClFEEivYZyb7U2jvOsnavHR2mTDyNXVZjD/g1a1GYzP9stYJT+lyrL5v0rn0Xi1rKhqu32IbAVM6JSINQUccCLCLxk/jtvJk7a
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cHc3dlhnSWhYYWpRSDE0RE9LY0JGNXVSdDBWS2JsM0RDb3lwd3FKSW12YUNU?=
 =?utf-8?B?VC9iRStWcDFTcEFRR2kzTVltTGVWd3BvWC9VUkpzaGp3VzNXZTVXL3lPbzJT?=
 =?utf-8?B?amVJTC9jSnZYRm5Rc1k3M1NXaUp6bFpCZTRNM2ROWlpsYlZjaFNHelBvUElo?=
 =?utf-8?B?SnRvRlFMaWh4NEtVWGZwNmo4bjF6REYrdm1hWHBlVjVta1FVTCthcVlhNzlM?=
 =?utf-8?B?YlNMaUhCdU5PRmZLVXdWOGg2VjZEN0taaHp6VTFQSnQyVURhRm1zdHMxRzRP?=
 =?utf-8?B?eVRIemI3eTBBS3NLamxWbE04T3o3NTNaTjk0UW80QjZsekdlM2pxSFltdEcr?=
 =?utf-8?B?TUFMN1hra2dBK3F6TWNoWWZMcUs5WUVpa2ZpK3BWdVB0VEdBWCtvTkZ1eExq?=
 =?utf-8?B?cFRadERsRk4vQjBTMW1QOXR4RWtiU3VKeWFzTnFpZDNMRGFzdGNZYkkvYWdW?=
 =?utf-8?B?UFRSV1hrWWlla0tTMGtMa2t2UDdDTmIzdHRuTGszK25Rc2RMQWtHbDg2VVhR?=
 =?utf-8?B?YlhyK21aZ0I2KytjWXBmRUF3eWtiaFVLQkV1ZlpSekVuMGh5OXpFUWtjSE9R?=
 =?utf-8?B?SEh4MXRPeTlzekkyWTdqeTlWd2FKdmRLZFVESUpPcFE3djdzVkJIYjlHeWl1?=
 =?utf-8?B?MGFLN0dpVmNITjJPenhwVk1obG9RbnEzUFgwSFJFODE5OGZoaU4zblNsR3Y4?=
 =?utf-8?B?RE5GODFSczdPUzFLYjNBVDZHTm9QMjNMVlRoSVROVDA4cmtTMm13L0lBa242?=
 =?utf-8?B?b1duZUZwaHBtei80NWxxbVdJNUQ5NTgvNllTNnBKNkVlUG9YM0l4SzJLQVJY?=
 =?utf-8?B?VWFnVFZRQm5OMGt3dGx3dHhuV1hXVitQTWF2ZWVmNmFKTUZVMDNvakNJclNT?=
 =?utf-8?B?SDJkOWNaZTZGRjI0eU5SS1RVc3RqZUdrUUZlSE1Pd3JGbUFuWjlEbGtHU1RP?=
 =?utf-8?B?QXJIZkU2Sk10ajZpZzd1UHNGS09tWERBc3gyZzYwT1gyRHd1UFg5cGhkOXJq?=
 =?utf-8?B?YzFIRjVqUjhsd3VNa3ZLM01ybmJUbHdwSmZjakhTeDQzV1duWCtGTU1TRU0x?=
 =?utf-8?B?U1JtcXhUVm56YS9IdHpjaStJbGRHVktTdzZZaU0xNnp3cGRYVFdzVks5VUxR?=
 =?utf-8?B?N1ZtLzhxWVNueUxsM2ZGcU01MXVHN0xDTXhVdHFuY21iS0I4aWlPSWlnMG5z?=
 =?utf-8?B?NDlmTnlCaWp2U3kzRk83NEpiOTJzZVVhYkdsMkxsdStsSVJRUlE0bnE5KzE5?=
 =?utf-8?B?UWF2V1NmK2d6amcyYW83dzdGS1FuRElDMXhTVFUvNWU3Z2dPNmJnMkNscEZR?=
 =?utf-8?B?Zld5d2d3by9zb1pIOWYyZ1Z5Tk42WWh3YmRiK1ZhWTRiVzh6VnpSRXl1Um8x?=
 =?utf-8?B?RlEvNmN6aysrTXhoL1lXUmtyNmxoMWtLdHZMWXVlVDJJRVJvYzhpMEpqMFBq?=
 =?utf-8?B?Z002RmY4Mkc4UEdLeGpCUW5TNXBmM2YxUTd0OXNZLzJPSDE1MzJFQXJzTlZm?=
 =?utf-8?B?ajdjWnpjNVNTYUlISGRWV0VseDk2YUxBTktrYkNPN016cVFpQ2FRSm9XbUF0?=
 =?utf-8?B?UGJoZWVqWDhSNHB3UjROdGVaWTdCRmMvS2kzVW5yUFVZWXJGQjh6cDgrdVI0?=
 =?utf-8?B?bkE2MlpWTjllc2diZ213YlRkblBGQ3pkbXlUUWFRMWcwbS93bWlBVUxhejRF?=
 =?utf-8?B?aVJKb3MyYk5iWG9BSGZtUXNTaGRERUJ6VjhGZ3N6cGV0OWpuOFNhRzRXV0o2?=
 =?utf-8?B?Sm9oSzcrZFEvY0J2aHZJN1M4M3ppN0ZsUDJKQkxPTFZxZnRKcERPUnI5L1A2?=
 =?utf-8?B?eUlMWmpIbGdodXFYeE1nQ3FSL3VBV0xTNGEzVHoyM0xPRXRNWmkyWE5BUk94?=
 =?utf-8?B?TWFMMzdQTHdaVXEyaEd5bjhiQ0I4LzNpRXdMZDh3VjloUTAyb0lnSUFkYzR2?=
 =?utf-8?B?eDljcjkrQml2U2gwamJId1g5Y3FhUU1SalE4ZmcrV3g1RzFtQ3pzdUlKYkZL?=
 =?utf-8?B?eEhzVVN5Z0FLaWlEWnQ4bTU0enZoOVRwc3NKWmpPbFFWUUxCMTRFazJMYndq?=
 =?utf-8?B?b3ZtYkd0QVhuaGZVT09vYmNkUXJVaVNDWnZVR2pFaGU4SXo0bS9abUdoMHM2?=
 =?utf-8?B?ZVBsVlJPck41YjVHbVh4Uk0wWDI2ZVF4cDViTVlLSGk1RFhocmJXekx0U1g4?=
 =?utf-8?Q?aKUvM4s9GwNDWjvfAkAYTESW7FkM9YuApLETntnd3SIl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JSTNQbtDUPMSsGlQtKgVl2OQxxTaVeiaidzLoCfxgH2c36vFkPdytL8H1LouW2KmkVS7JjJr6OyZ/ldD0OBtJSmuSMpyEYGmeHfjDjPWTaCZz0Zp0Azq8MCIm/YLuTz+FvDndTGIHfPlta/RbL7u516iI+6z4XW/dPVMVxtm6bnRd2/JIRK/ZI60L4+ZR01eHuNR2b2t0FJv+0x1xiEU2YC95LsTL0q0yOukQ2qCBlveNZHA5/je6sTUZOazfw5LHR4c+RHzay3kwiROOQPLAQaJRZjpDny/Lfq/5cIItoUGRQmaF6w9VK1fUIRw2mRhJFHX5XS+ybyHNSFY95w8l+rgCv8KOeV/zQ0xYcOS1bgxHRRWqV5aIEy2JLRU5c3j07xdknEo/vVeASJaanhGlO4a7F91PFHf/UoLyuqw+/lSGaoT5nnnQJhiq/QuMu5MI94PquzI5gWch7BTjnAbW9iOzBBduEeTzHohGoSdPdPmpQ2NsM7jLuqTF/hjLA+/QbiyWf/9N3xf79QOAtncm5pc80OsveJt5H3OVbAQ2Co5KTMN5JDVz0WTZrBcvx3ArWps2wmAIFXd5DtCSEZ259f6LXX3ShbJQUHj2vd416c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1852184-673a-4140-434b-08dc3997c0cc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 02:31:52.0226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0L3Q9oom92V7gh4eqrtyuNKe7raO8ntwKTM8wGQ6LJrJog2/WwE0Ow7/po8hxD2ZNC2/BJvDdJ/ye83itgyzZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7100
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_08,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010019
X-Proofpoint-ORIG-GUID: T4MRbXSRsSzrQTNAcXpe1BujAbeIIl8V
X-Proofpoint-GUID: T4MRbXSRsSzrQTNAcXpe1BujAbeIIl8V

On 3/1/24 00:06, Boris Burkov wrote:
> To fix bugs in multi-dev filesystems not handling a devt changing under
> them when a device gets destroyed and re-created with a different devt,
> we need to forget devices as they get removed.
> 
> Modify scan -u to take advantage of the kernel taking unvalidated block
> dev names and modify udev to invoke this scan -u on device remove.
> 

Unless we have a specific bug still present after the patch
"[PATCH] btrfs: validate device maj:min during open," can we
hold off on using the external udev trigger to clean up stale
devices in the btrfs kernel?

IMO, these loopholes have to be fixed in the kernel regardless.

Thanks, Anand

> Boris Burkov (2):
>    btrfs-progs: allow btrfs device scan -u on dead dev
>    btrfs-progs: add udev rule to forget removed device
> 
>   64-btrfs-rm.rules | 7 +++++++
>   Makefile          | 2 +-
>   cmds/device.c     | 2 +-
>   3 files changed, 9 insertions(+), 2 deletions(-)
>   create mode 100644 64-btrfs-rm.rules
> 


