Return-Path: <linux-btrfs+bounces-2678-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A7686194E
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 18:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5141CB22754
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 17:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404401C68E;
	Fri, 23 Feb 2024 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R//cU0xM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hsowpTyt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC6F1292DF;
	Fri, 23 Feb 2024 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708944; cv=fail; b=hgKgPE53My6n0EX3Mc74WEHt0aoJVDePbuOqdOG60HJwMhyWCpvjqvfdhsi1y5eaF8F6WDvxuGdJV77ofN/8d8ufiTsV1Bdcmzvm3xFiQcxpRRHi7Kso9mmT/+OTjCc9ZD4L0TrRfqZSQIcdKZjlr+ybmduXVF/qRB/jtBblBzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708944; c=relaxed/simple;
	bh=TjIxB3uHLmLnT79n2o+Il9v7v9Ps1A+UR/7/jnt+DgA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I/91d8T5WbcRIiSgs1uEK86qEgnJR23Gbqmi3AYJVEgYR453lq0vewFV0//gVSyUp9+o77nkiq9mmegSNQd9p2560fFRIpQfKhi0qlzFeOlbXHLYybgoTQObDkGq4CY/xEAQgKJuYRUiR6F6VoWGAGgJ12JwyZMDjTozP1daCgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R//cU0xM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hsowpTyt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NG47WL025683;
	Fri, 23 Feb 2024 17:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=phlzcjCTBv7S0hBlELesSuVp/EI1A7sfAeF8xQToVqs=;
 b=R//cU0xMmEIJ6xWAji2DHJ54//roAp3nVCAog6hplRX8Qjew+as+WV32PrIfrJV0CUJ/
 UyF/V8vo9xHV5wLWguBXFtMYH3NtdiFTCMl05SdvDIyhEIYZ8sIx67FfS8VLGFa2LmON
 y7w3gq8pjPbu9kN1HgQad6mzXhO3dORi4miMfLgLZZ9nh6yWLW+WxP+cmRLsDLLJx8JA
 AdNQWBcEa/GhN4rSZVR8b0lMHgdiA/Sc+40ABmprFr/GkPaP7zDUXvVHOO6fVJwx5Jfv
 4e221QEytrjoYTUgVvzcJqOUQY6m8gHuYZkAO1TVKip2pTZNPr9wfAuh1hpx2CFMNF5p 6Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakd2gd5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:22:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41NHDhA6019175;
	Fri, 23 Feb 2024 17:22:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8ccvre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:22:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyUbu54NNXsnvhrfpst4weuMTNzplCYWSD2gzUN4+RP3uJYQQsgPr5V+atS9/+jW6NvN0qa51aGtPG9BaUs4TwAZvRJuer+e0mOOGtn/RZs7jxDAEVMsJejBAMhGWTtWYj5T4eRd12yVmVNGGM6LQIzK8UiY/0SN7WdukaqpjQeqChZwh9yigY8md2QnZakUWEXeAFwrVZtiHwu8bhffCjeRuCidkq21zzH6GqNsnkUcJ3flDbx2kY3zzTj7WNPzfkKSARyPccVACkkeySkUn1YiEFpLIc/hfBVNzpY215w8Za8BHLlBijnXbASRSLojr3RJ8bd0dT+Zn7kq4Jg8BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phlzcjCTBv7S0hBlELesSuVp/EI1A7sfAeF8xQToVqs=;
 b=jsAljT/0jLb9C2AI/rYsonuv7aXh8QRuaJTp+dSD+GoGolMnbFUcJZWp1JT4Nm7zqN/MYeBDpJbpC7W4G/ab/IEId3LUV4b7o6G8Ms+wg/+9OHyDB2IXJoHz6VAxVU3BxfurkTz8dbvptYusO42oE65UrnYI8lhHESBsazPzqrvvWFUhT1kGCcSG3D5c+VBNuVhNLfuZYaGrm9BMesbn3kryOUufmTadx7+RWMropxTFQ7KycU6/P2hIp9EnB0timJNfCZlvFzJbSkVeqnK8RWI/Ntlsz+7KkCmwcYAOmJFbjW9s7mQoMcrmhKhI7+NKkS+VyeTmJvfSNLCawPSr/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phlzcjCTBv7S0hBlELesSuVp/EI1A7sfAeF8xQToVqs=;
 b=hsowpTytuMkgmRwsY6ggXnw67hHshw0eMM82rXOsJJa36uHsWytJHHuzEmwiYLjHzVRLUnT0AaSRhheBc/gcDOwjzAcWCUpYkObflFty0QtnvxtwpZFknsETD8q+7Akzq7YEmQh/c83+vR5K+srO4D48tg5F9ZW09G5aPHuKsrE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5132.namprd10.prod.outlook.com (2603:10b6:610:c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Fri, 23 Feb
 2024 17:22:14 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Fri, 23 Feb 2024
 17:22:14 +0000
Message-ID: <4cdfd838-b919-45a1-85dc-a5e6d5f61f84@oracle.com>
Date: Fri, 23 Feb 2024 22:52:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] btrfs: verify that subvolume mounts are
 unaffected by tempfsid
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, zlang@redhat.com
References: <cover.1708362842.git.anand.jain@oracle.com>
 <5c5a57b1f937b7a6470976643fad1c147c682e80.1708362842.git.anand.jain@oracle.com>
 <CAL3q7H4qTrGrSuWys8rTRnQNdYFBJL=RZjsg3k_kVuU01Lf3Kw@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H4qTrGrSuWys8rTRnQNdYFBJL=RZjsg3k_kVuU01Lf3Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: 86bb90e8-65cf-4eda-6b37-08dc3493fa5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zEN1GxhAsdgSyjVX6gwluS2PSPFSiVUWdmdHt/BQHTy0gPGQ5ek1EJxTJZXYFF/ZMofKfC2b0PesldLK8SupqGb3DmfRxPR/DYF3P9nxbIhgLtThoRCUkiEOtbvVvB65auCji/UYCL0ubeaZmn5R65JJieodvFGfSeTKIe5mkmBT8x8cEp1xxIjeJs/TaDQatfhaMd+0iTpMvlFI+shwa/FDGrqwZ74kVT/VB+Dn1d/1lZaXeQnE56tkjZmnCvWpB4ET9z/lFOY1SQNOFHBv504BrvZaVfp62e+MzBShHdNN/NxQt/NRPy+0fxyN1ALOPcq04FT2b/xpyV6UugYd/yX3+7eqF8Gzg/zP6P0tGBYWEGobppJ59+ti7siVmSn3ZW/zJiue05/o1N7xF7BEIUas9hx4qpPTb10WijxNXv+UKvypUhlyrkMCTr9QMztb1QOY2AxwY8Nxcm/gkUNBgQsGxI9p/8RsgsGyt5LVk4bQBuT5dF8Dmhipvf87t1QEUGHgLoXTxhKMLv6Alo0pQD3RapONaisGWhXLrnFzTwc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VHNUeEJiWEZ1YmRnRDQ1RDN4UjZrZmovNStHSEFxWnB3WG5aMFdwaXAwTjJj?=
 =?utf-8?B?WWZ3eEExRDZRUEt0YlMxUElxRTZJTnd2S0tEajFCR3o2REN2aW1nU2pCN3dE?=
 =?utf-8?B?MzFhQm9wVUc4NTREQ293RWxSYlBlQ2VsTXFITzNZVzRBSmdkU3c0NlV6bmY3?=
 =?utf-8?B?K2M1MTRvMUZRWjJqWkJZTXhUamE2VTZrZVFhbnB6Y3lyeVA0NXZ5cENHU0tp?=
 =?utf-8?B?QUl4akJERGg0MHErUTN5aHVnUFEzVFppUXQ0aGZibEc2VjExaFdKYmkzRHQr?=
 =?utf-8?B?enNDa2RadmdBbS9aNThjQlRmZXVyTUNyTG90Y2g5ZDFtS2dvQXdybzBtZE8v?=
 =?utf-8?B?dktncEo2K2JSZVNvRlZHeVBwMXNrdzcvQjFZTXp6Qk5zYjBBUHo5ZWZGYkUv?=
 =?utf-8?B?SGp4eVNHTDMxMlErcSs1VkVORTZQSnorMjlMWGVmSHdBclg3UVAzWWtRaG43?=
 =?utf-8?B?cEw1NEFvUWZ5K2xDek1mdXRSVmE4Nm1paWN5Nno3MmxTT01xV1NpUUxac1VF?=
 =?utf-8?B?SGs1eHR5by9Ka3VsKzAzcXUvMnM2NkwyWWpGWDZQWDNBbE1COFdXR295bmw5?=
 =?utf-8?B?bmtIZHlySFpXUEhlYnMrZC9xcG1SUHNvQjRhTmhnWU9NdytsVk5sWWxlV05i?=
 =?utf-8?B?a2pZMS9YS1IyV2RGZVJ2b2VsTm8wZHNnM1J6dGxISTFzdHBkdkFoSS9LNEph?=
 =?utf-8?B?Qk9adDBab1lWVHJtTFlJRzV5YjZ2NHpCTEdBK3ZCNGlRKzZrWkhlMFloVERh?=
 =?utf-8?B?U1J3SWhLUlZlMWFUakJsTndNL2FBVG1mQklyUGZ4VkJSQ2VaQk04aVo4QkVh?=
 =?utf-8?B?UzhwU0w0OGFRdUhFM1dFWEtQc2QveWFXNFpFODZEYmZTWFIyZndkWTFqdE0r?=
 =?utf-8?B?MElnV1ZoM2VFbjJCNGRnMk56RWoybDFqU09FNDQ5RWQ0ZC85aTZoQnpNb2pZ?=
 =?utf-8?B?cVJuQVBqelZGbmxVMXpKbEJlTll1R1BWVGxlUGhOa1JHRnQzVHF6cTRBWFJ0?=
 =?utf-8?B?YUsrTy9wcXBJZFRVVmJjMXdCVmFvWkxPdlNkM1l2Q1krSmdwWFhuU0hLc3Fx?=
 =?utf-8?B?UWQ0OU9aY3ZEZ0dxSUpGQ2RhaW9tTnVwdTB6Wlhyck50WmNjSC9ZUTRta3ZL?=
 =?utf-8?B?S0VITkRSQWE4bXJMeXpJSHFiZ012clIzdGJiOXhEcWxKVGxrazBCUGdsZ0tV?=
 =?utf-8?B?eXRTSzh4cm15MDNIZ01RWG5uRDhRWGxhbjcxaXNzQTFmakNMV0g0ZzV4anUy?=
 =?utf-8?B?REE3bExRbDVRMnBMdmxuUG50N3RMcjVObzBIM1VUR3oyU1FWYlB1TGFSeGZv?=
 =?utf-8?B?UFpoZlQwanB4WmZwUHk2NkFPWm1IT2VoN3UzcGNkTS80dENPaWk2Y09NemdM?=
 =?utf-8?B?SWc1bzhTbm1LTGVUcDZSRWk3d0wrV3dhbVdlSE1VSlU3UHBjRGtuY3llUHhj?=
 =?utf-8?B?cXdkNmcvYzdZR3ZlS1hhejZvV05PMHM3Qkg3R0RwdzZCYk8rQ0RCaS95a1I5?=
 =?utf-8?B?dm1pcGJtQ3Z6WjRkeE5hblBsRE9qdmh1UVUwdmNGUExhQU5KNTJDaGJMVXk0?=
 =?utf-8?B?dVZwRnRVVTVTaFhjMXhEeVNlWDFNSEdpUGZDZWo2RmIvUVBnSnVIZVpaaDh0?=
 =?utf-8?B?WkEyUmhkMC83U290QkhEeTR2eUs3VW9kTEtHZWk3bkFFREFVbmxUK2c5cC9m?=
 =?utf-8?B?OVluem1XS250OEhMakc0bzVvR0pFM3pHc3dYWW5JZ1UrYTVGNVI5Q1VMaGhM?=
 =?utf-8?B?cENQL1Fvb1JLWXdWcWpmdk5USDg0dlZEbGFyb0VmREY5cTdIdXdpcXFPdUlr?=
 =?utf-8?B?dXdCSTVpTHA0bUpIYy9hc2ZCaXA0am5VYWEzKzhWbEpRdDdjOTlCbG9sdzE3?=
 =?utf-8?B?T1A2ak56YVBaTlZGdXA5UGI1azhEM0FZY3lNZHJ6S2tGTFFaQjZxRGR6dFc1?=
 =?utf-8?B?Z1pyZ2FIT3l5M041cUEzUENBVnlkS29OenFkZTQ2dllONjFnNE9qbCtkKzdm?=
 =?utf-8?B?KzlEakxtS3lCRUdJNTA3V0tSRTZxVFhldDduYVRRZGNRUjVQV1pDTHhlaDNW?=
 =?utf-8?B?eDZMZ2dQU2k5WGM4Sk9VVVRRUWN1eFFabVp5OU1lM2NnQ25SaXRydnA4Qms0?=
 =?utf-8?Q?p/i7GDFCOYYwfZA9GezWxCvEE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xv9z6e1G5zsBGcQc/YcpZosR21ilfzOXXZttGCdZyI/sOTA13rPsftdjRYTmYOZE93HVL4GsQnfFRGspTZ9bxBwwQ+RvyVOmVT5a0O7SyyjikKApy0Ld27EYy+kqlZStXJDhsm4Sc9oEzaKaXRkiiBd6D+yoz7FdmBHxfxXFKfunbSoswifUY8eLzDMgzhybEdk98Ql+oUqXK8qzMvZB3F/WbSr10qEGXZ7IM3hanQO/Lr6b9gio8tcH++mzVQmkUvN0xfKcUGuceWp93HfWywcOflcc0G3wVdCZhaqNbosojgE65ppDCOZ4fe1iywUCKKHk+kVtHtMIFoO2Pa5THNrzJ1MBLLKnkNJY6Ke1zbTQeoatV9AoSpw/GEAfx6w32xI1o8MoHnv86UK6NMlVLIW25Bdvu7lbUBx9jdEJ3igqOu23kiKDBDKglhocXyYxrZg1LerDkAgggrR/6IZzlKui27uOpWtCT16qemkHVqh+likP0AlrSoXc1TPSQ1psoDm9k9fitL3pyGc1PyPVCUwkMXeceiqYoTUx+N0EeWvJb8e9pJJgAQFQE3tiyjnbX569Dez7Kj/Ix0ZJ9X8Ua37e/Pjfwmb92s+Yhg+E1/s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bb90e8-65cf-4eda-6b37-08dc3493fa5f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 17:22:14.8739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukCEVcFlkILSttyDmiTEtaQJHThobD2GDv39PQ4oVU9l+Sq7K40EbgzsA0ZOed+w3ffUPEUvWuBV63q8j3PrVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5132
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230126
X-Proofpoint-GUID: ZNC45NESMBnZQTq-1dI4YtNxaO1GxsGe
X-Proofpoint-ORIG-GUID: ZNC45NESMBnZQTq-1dI4YtNxaO1GxsGe

On 2/20/24 22:00, Filipe Manana wrote:
> On Mon, Feb 19, 2024 at 7:49 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> The tempfsid logic must determine whether the incoming mount request
>> is for a device already mounted or a new device mount. Verify that it
>> recognizes the device already mounted well by creating reflink across
>> the subvolume mount points.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2:
>> add subvol group
>> use $UMOUNT_PROG
>> remove _fail for _cp_reflink
>>
>>   tests/btrfs/311     | 89 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/311.out | 24 ++++++++++++
>>   2 files changed, 113 insertions(+)
>>   create mode 100755 tests/btrfs/311
>>   create mode 100644 tests/btrfs/311.out
>>
>> diff --git a/tests/btrfs/311 b/tests/btrfs/311
>> new file mode 100755
>> index 000000000000..cebbc3a59e6a
>> --- /dev/null
>> +++ b/tests/btrfs/311
>> @@ -0,0 +1,89 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2024 Oracle. All Rights Reserved.
>> +#
>> +# FS QA Test 311
>> +#
>> +# Mount the device twice check if the reflink works, this helps to
>> +# ensure device is mounted as the same device.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick subvol tempfsid
>> +
>> +# Override the default cleanup function.
>> +_cleanup()
>> +{
>> +       cd /
>> +       $UMOUNT_PROG $mnt1 > /dev/null 2>&1
>> +       rm -r -f $tmp.*
>> +       rm -r -f $mnt1
>> +}
>> +
>> +. ./common/filter.btrfs
>> +. ./common/reflink
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_require_cp_reflink
>> +_require_btrfs_sysfs_fsid
>> +_require_btrfs_fs_feature temp_fsid
>> +_require_btrfs_command inspect-internal dump-super
>> +_require_scratch
>> +
>> +mnt1=$TEST_DIR/$seq/mnt1
>> +mkdir -p $mnt1
>> +
>> +same_dev_mount()
>> +{
>> +       echo ---- $FUNCNAME ----
>> +
>> +       _scratch_mkfs >> $seqres.full 2>&1
>> +
>> +       _scratch_mount
>> +       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
>> +                                                               _filter_xfs_io
>> +
>> +       echo Mount the device again to a different mount point
>> +       _mount $SCRATCH_DEV $mnt1
>> +
>> +       _cp_reflink $SCRATCH_MNT/foo $mnt1/bar
>> +       echo Checksum of reflinked files
>> +       md5sum $SCRATCH_MNT/foo | _filter_scratch
>> +       md5sum $mnt1/bar | _filter_test_dir
>> +
>> +       check_fsid $SCRATCH_DEV
>> +}
>> +
>> +same_dev_subvol_mount()
>> +{
>> +       echo ---- $FUNCNAME ----
>> +       _scratch_mkfs >> $seqres.full 2>&1
>> +
>> +       _scratch_mount
>> +       $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol
> 
> Need to use: | _filter_scratch
> See the golden output below.
> 
>> +
>> +       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/subvol/foo | \
>> +                                                               _filter_xfs_io
>> +
>> +       echo Mounting a subvol
>> +       _mount -o subvol=subvol $SCRATCH_DEV $mnt1
>> +
>> +       _cp_reflink $SCRATCH_MNT/subvol/foo $mnt1/bar
>> +       echo Checksum of reflinked files
>> +       md5sum $SCRATCH_MNT/subvol/foo | _filter_scratch
>> +       md5sum $mnt1/bar | _filter_test_dir
>> +
>> +       check_fsid $SCRATCH_DEV
>> +}
>> +
>> +same_dev_mount
>> +
>> +_scratch_unmount
>> +_cleanup
>> +mkdir -p $mnt1
>> +
>> +same_dev_subvol_mount
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/311.out b/tests/btrfs/311.out
>> new file mode 100644
>> index 000000000000..8787f24ab867
>> --- /dev/null
>> +++ b/tests/btrfs/311.out
>> @@ -0,0 +1,24 @@
>> +QA output created by 311
>> +---- same_dev_mount ----
>> +wrote 9000/9000 bytes at offset 0
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +Mount the device again to a different mount point
>> +Checksum of reflinked files
>> +42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/foo
>> +42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/311/mnt1/bar
>> +On disk fsid:          FSID
>> +Metadata uuid:         FSID
>> +Temp fsid:             FSID
>> +Tempfsid status:       0
>> +---- same_dev_subvol_mount ----
>> +Create subvolume '/mnt/scratch/subvol'
> 
> Because of this...
> 
> Otherwise it looks fine.
> 
> With that corrected:
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 

  Fixed this locally. Thanks, Anand



