Return-Path: <linux-btrfs+bounces-1229-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB72823CE5
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 08:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FAC1F25C75
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 07:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D029200B2;
	Thu,  4 Jan 2024 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M4aDH6nk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EHHY6a+A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC40200AE
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jan 2024 07:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40427qJY012315;
	Thu, 4 Jan 2024 07:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=lUUJ0OJjuNDXB6SnKYLLuiO1ftUK6rCOH4SBPwwrpXQ=;
 b=M4aDH6nkwp4gfspumuk7e04b259gz+xUuR0eVALnlF5r4Vse9j2CaJE9tukZmnUe2WGW
 rjmGtD4ff4y61cS9LLeFbfBrHzpRcHm/31Sfi7TfC/0HnxS5bhqK+lXiGKlGVBUd8Xp2
 kBiHw+87KiN2Nu8sIoF1bq8TLCnj/LFvEFiB8ShGma8NoJbE3Qgn3pNn1VkTHGQy2cvV
 j0PnqGQ5dWj1d8ycJrDmXJc03iCYSIMSg8sTY3guP2bzXi5UNaIvcMugIb+bo+0Um36b
 Wk8UJzno5U9oqBTyWWE7tA0PW8ImL7klfuf7OG7vu1GwDHxAzvGqPOB5BE59DhfsxIE3 qw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vab3axhh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 07:43:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4047holh000777;
	Thu, 4 Jan 2024 07:43:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vdr659081-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 07:43:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZZQvKjyzODLkcYdPbsmHAeKmA/pmm3fKSccdM+DQlBdaT0MIDg1qRMClgDp0qONELPGwVxPwSDHvoy4kBVRcLU8MEgIdZEDjfS7RkE/v8RgVhMuQJfgyNoLixulWs1mjwGQr6hnYTKfwK/+b9OTrcHT2LZQVR7XGmjc718P4Foy2Qq7sbIZYA+J+ELXD73RQSQ6QwC7LlunTgvhlURvJmTee3XTuej/Y+2qjKMXao4LUGHOMy7TPFc9zCH/xurzC2/Wj8UiEIjKZGW8kWnCLnVk8GlAD4Eho6eCGOR/VSxOPx2ONtdRgDXEfYnWndaHrawK1E55iswtUaKih/DbjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUUJ0OJjuNDXB6SnKYLLuiO1ftUK6rCOH4SBPwwrpXQ=;
 b=J0oUzXL9YD/eSR4caK87jLfHfO9NtjjdWRC6lZDOc9AcEsFXVeD7EsD4WXKwWNlw6zoS8qJcHd/q4Yh5FJmTRqtZm9mDaPsxLpHd8v5PZB6UJYtWBtKRb0Ln6ip2OiPu86LyMSZTkRhsbfXn25GgVBUcuP/qF4tvli5++F2ncGelrsPTpNxaiZbStvmAlara+wwPeH7DjX9nc52erwRzfVTFzmyMgouaYEtk8PG4zdjZJMno8kVeUi4czrzmk4UG+M61sQj7SGT/lhl3mSHCcfTa7KX4d0ldfUVaKEXc5v19zx3aZy/YWs+QQu1wYsEzWjYR9coa9PalLKdioPUXaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUUJ0OJjuNDXB6SnKYLLuiO1ftUK6rCOH4SBPwwrpXQ=;
 b=EHHY6a+AhGyLVDHr2hY7SvId7ODqN0pNfhuHK7bCRNiqsNz28jNsEp6YcWDsVDVfvAetu7/LjK2zxWAQP/WleaPtTKzIzA4KDtm+vdm1RBTvpboCcu4NuHeeHW7t2mOplIDCMZHR6WBO7VCifK0oFIVQHGBlpyBDEaJEUUV6nmE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4223.namprd10.prod.outlook.com (2603:10b6:208:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 07:43:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 07:43:23 +0000
Message-ID: <fbba70ef-4cd8-462b-4c82-c08dbbf7ffa5@oracle.com>
Date: Thu, 4 Jan 2024 15:43:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] [BUG] btrfs-progs: btrfs dev us: don't print uncorrect
 unallocated data
To: Goffredo Baroncelli <kreijack@libero.it>, linux-btrfs@vger.kernel.org
Cc: Goffredo Baroncelli <kreijack@inwind.it>
References: <3ab02bc2189617b9d60ec6de924f60ee3899babe.1702831226.git.kreijack@inwind.it>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <3ab02bc2189617b9d60ec6de924f60ee3899babe.1702831226.git.kreijack@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0193.apcprd06.prod.outlook.com (2603:1096:4:1::25)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: d38286b3-7869-4b9a-21c9-08dc0cf8d44c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	khZLVIoxeXwwnC3rJ3L96o9YMn8yL4+zThgIP0jR6vxB6vPhwy8i4rqQuRYevLrOnGsUYCZKkGGCEt8fMzA2J/DlCY26iydhraRWCjNTqEdbZ2E9ynMitzl4xB8Gn489e6UgZ9hYPh6G66fgumCdZolBtco3hoS69jdjSsI6mk9/ISdsLIIfF66CQebzvY6Y5LlPBlOF220DstWYyg7Pg2l7fdIwGEfn6QVGNOQ1wz/g0bapOTV+HbKb/qWhyRppTQU6KxAQ4BYCk2IcEvm1eMzYJNbMjgTf8dMpnnG1WPHodPx0T3MLM8uJUhnWhw4bdNOaSvDC5tCsq0jcKeTcRJDwnkDP8WX4R380IsVKH+vAocLTCExHM4jsRy4v5YJU+ARSXCwZ5k26tP8tN4LGhmkk5L+7v2sikkjgj2i2+wqmv3rGgffRDBU8hzW83/lkYM11Y8hk/m34tBM+U5LrkOa2H6ZMrHoT7v5ofHwlW3Cg+e2SXP3DIdPA084pRqZWCqtHpJJf/YFeJlfft0Y30PV/19tQ6D5045/aB7erYLeYsJN3qHp1KCKo3z/r4J+KJl+ZFGDKOC5TCoC4QSnfwU1yluwBiE0LJL0GyD4jiB6572YgTeS0lsBwtzVD3LvrdLAxHcr7x+06uY5gGOAxWA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66476007)(66946007)(66556008)(2616005)(558084003)(478600001)(36756003)(6486002)(26005)(31696002)(4326008)(316002)(6666004)(6506007)(6512007)(31686004)(41300700001)(8936002)(8676002)(86362001)(44832011)(5660300002)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZVFRb0tQZ3NWZkdIY2tkYVFTcklERld0TTVack0xY1p3Q053VDdqNHZGQytN?=
 =?utf-8?B?Q0U1NWgydDI0c2RnRGpNR0VWT2ZsTWI2aXg0VGJrMVVOb1JacHI4YjBVRm90?=
 =?utf-8?B?Z244STM3QU1yU2JXbTBrd0VBMDdWb0FVQVEwaW4zK1VBNERLaGNNY2pIeHJV?=
 =?utf-8?B?c2pHcXh0Z3d3d0NURXhseFN1TEkzZlJ3YXhNVkd0QjlnM0lQbmxFOVlxV1dD?=
 =?utf-8?B?NDJqOG1yK1VhcGwyQVMvWmRvdkxHQWFNbVdLWXJQbkV6TWxlbzg4MlpTam1v?=
 =?utf-8?B?U3c2VjZtWjVYbkErWXFoWDV3bHI5L2RNRGw0eERudHg5OEdxVEwxMWtGWHUx?=
 =?utf-8?B?SXpLcVkyN1NLbzZUY0UvOWw4ZHowVEVCcEROdFU5Rm43dGdhSitRS0d2THc3?=
 =?utf-8?B?OHNMeXFKVGZSU2VtbHpaWHFValQ1eHVxVGV6M2VBMWJxWVc3SW8wZ0ZrZkgz?=
 =?utf-8?B?ZXVFYWE4V3I5MkRUdVhlUE1JbWtIQUxydHdnS2ZzQWNNTnQvR2d6VVBHeVIy?=
 =?utf-8?B?WC9XK1V1NEs4dzRIUENsaVF0dXNJOUZJYm1neVN2UHJna05qYnFBTDNsMEFN?=
 =?utf-8?B?Z0cwQ1J5a1ROK0NRMTJ3bURvTTk3c0FtOWNuVmplZ0dBaEsxTjIxMVdnNmdo?=
 =?utf-8?B?V2tQZnZhaVZ6NU1MTkd6VXB5OEVkdWdCN1ZNeUg3OUkyQWhMVGRodnBPWkpV?=
 =?utf-8?B?TDBDSUtiTTVFdG9UOERLSEJZWGlKbm1tQW9weVQzT0ZnR3NGK0ZFUW5zMkpj?=
 =?utf-8?B?MlhkS0dsL05lWHJNK1owR0NTUVZmS3NTd2VSKzAzMjRtMGdvcXd6anZkWGtQ?=
 =?utf-8?B?SVBKQWp0cDR6OHV5VkozL0Rpa3lpcW1Uak9jTFJvMGUwRTNqcFBGNXhOMXRk?=
 =?utf-8?B?R24yWmo3SXIxaUxXRGdsdzBSNHlUZjVNRnQ1RTN1bkFBbUw2d3RacWIyc2ph?=
 =?utf-8?B?anp3NnVOc0U1TnBCSW1selhMcDVBTzVCNHp3dytQak52ZEkxZjdnWm43ditV?=
 =?utf-8?B?eHZYWFZQVG5VWE1oS2RuSnl4RmlZL2lvRmthZVVlY0RHakwrY0VmdkxBSTIr?=
 =?utf-8?B?THFmQ1hVOEVQUHdJU2FqWUxaQU1KRW5yZlFrRHlRd29NdFRLSlhpMzluMFU5?=
 =?utf-8?B?ajlwc3ZXQ1hSREk4cU5uMjNROFVjQ242emMyajhQeDc3RmlMcnh0REYrVW0y?=
 =?utf-8?B?NHQvTE5mUlZJaDZJWEdiMkNrV3lwUkQyd0pQKzZUUElwNFZyamNNSlpPek1P?=
 =?utf-8?B?YTg2dWxDMXg5bjdvVnd4eVpCZ0dwdVFIcWg4RCtrbjF6S0JjZ1hXa0IreEYy?=
 =?utf-8?B?UHFIRjFtK2k1clN5VGtBelVBT0o0eTFoakUyR29CcFRJQkR5bzZWVFNTVkwx?=
 =?utf-8?B?bWlYZisrRnpiSytNdjhxOVExaXlWcmU0aVovakxYNmxkQklzNTh2RE83bG92?=
 =?utf-8?B?VUtabG5rV3RGM01EYlM4ci9pUHZEYjFhRzhPM0d4OXAyakNtK25rUVQrTVBZ?=
 =?utf-8?B?UHFsS2tsMXZDUlRLZXpPNlhISEszUVdxK1JPUGdoczJLUHNXT3RpN0RPL2hk?=
 =?utf-8?B?cTFsclhsTEFXUlczR3NpMUVJWXNzeHBoenB1UVNUcDVxZCtMcEVRZEp6azRZ?=
 =?utf-8?B?YWQ4MzVmeFlCWDFzS01kWnVDNFZzRUEwbTBQNDBzUWozNlNnaWYyb2ZzSGhl?=
 =?utf-8?B?dlhYbVVxRkI3Q3FmZ2lRcnUwSlVYbHo4S0FISGJ1QWw0ZHErRGVFcXRONEJo?=
 =?utf-8?B?Zis0eGdqQi9jK1o5YXMxSHlEUDA3djF3N090TjFWQXJJYnhHSCtrd1BYRENJ?=
 =?utf-8?B?ZTFDVEJUU2xZSjVmRkhKMUNVdDhySElTc3VBVlByd2ZtVGlsRUxhdjVOMFI1?=
 =?utf-8?B?RDNRSUpLTVBZL3hzcDRuU3lUNlgyMGo3YzdkYzBRUjV3dHZQeDhLekRMS0pr?=
 =?utf-8?B?UWVRZWw2Uy9QRUtaMDVxeHQ3ZGEwWlpNYnZBeG1nZEorcVlCSU9VWlVwMnBS?=
 =?utf-8?B?ZWUrczhYK0hFREQvMHJXdDBrY2VKakJhN2dveDFwSzBPRzdvdEd1d0xySndV?=
 =?utf-8?B?b1ZobzFUVm8vZm12dmVpR0JJMUhhVXZ2QzdiY2Raa3Zzdm1oUkQxNE5GM3hl?=
 =?utf-8?B?R3dBYm9oQU5ZQjQ4a25FOUJzWnNIa1FHY1NLU1N0eFN1L2Z1YUx0bEsyY2NF?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BIZWWgYfFiAwYVAo3rIhwbv9Y4jkZsyQxcS5tNFEC6Juzn5+wrFgL0K6RPUrTXM4O0JBDFkckFXyaiIt7Yfzl3f85srgImVbu2NhfJKQThYdzEcoejIJVz3ejy2mHPgUzEw2D6GCirkNc/lLaYniNTSXGx2abPUUhEUfj6ZE1ucB2BjoGJjlOyW6DKXhR887YHV4epIDcGDENl0RLtCnYuMQE+tfBcXi29ARjcWWx2HqulX8H7Y+dzHDNpGAXGzYKjtJMA1+lJ8Awi0THJr6Q+ghunXzDkUPKsBdTRTMcDe5ohWANATnGah4Qyht1C6VC83cnyCF2GFJtwcaYjURIMcE56ZAfjtdOg8Dn+1Q+6zzCUjIFr4nXVvs7AmMXkQ7qh8R+CnRiFbo6kduoBKmMrY1LucR48si86YngLL5eacHKtvULlgYGM6umTrBNktL5d0OPHYbOb6rHjdT25bKqs9hFbN3Zgmm7R3EI5MGUyNLDgcrX2ycABZiyu7J2Oh8iWy4hdKBLaOv/d+XrCGIU7KaMmk5um1TIzDVRM6r4fV5VDaxP5xbP7nTqJElVY3Q6bZY/sxDD9pYAa6KApWwkRWL8Wkh+5zzCwbgBJdT9GU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38286b3-7869-4b9a-21c9-08dc0cf8d44c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 07:43:23.6555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ko1OpRoeqgcIE8ZpfgSAqimKUPzVvVPd+sbdeRkXIB3gvqWXh7XEFxuq+aaFWsh0BzoPH0JVUd6y7aBdSAFtxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_03,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040055
X-Proofpoint-GUID: WqygLjzx8k_s8Svbb-0KqIBVvpV8TaDK
X-Proofpoint-ORIG-GUID: WqygLjzx8k_s8Svbb-0KqIBVvpV8TaDK


Except for the missing sob, the changes look good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx, Anand


