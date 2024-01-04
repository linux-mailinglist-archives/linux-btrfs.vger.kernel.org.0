Return-Path: <linux-btrfs+bounces-1227-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 586B8823C90
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 08:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1CEE1F2668B
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 07:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4231DFF6;
	Thu,  4 Jan 2024 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WQmV2puG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U3lVGCqf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983AA1C6A4;
	Thu,  4 Jan 2024 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40433SsF017997;
	Thu, 4 Jan 2024 07:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=foKL+w0xdxWErNwbJhQKV0UhYx6NDYwI2K7HE2eqex4=;
 b=WQmV2puGtNK8i8edSPq2ITnP0kTZiuMf+xc/+qAgmH9+9X+gVF8zIavr92+v63poKLYF
 fg3q+UZtEC2tDqPXCd/M0GNcRzVqWx3VXAwWEZWVACzfXB9TsX97eipiLXoxzZDK4klL
 kpGp9C2H5lIxuoh2HrpkqI22Pr6cizJBNOndhJDL2LZFgfWQFho4XIT12ClejKIi9CZC
 UsPFIsaXYLkmyNAYQp8T5FX6poFBDulLdYFhSQro2yuG+MiszIS0WPjDQzzH9/CPoa60
 fH6OCNajkeRIsbYP1eYVA4eAvwNJbmYDjWKEn/3rOI9Qds8zYBA5adO5m51yw2DLIuEH mQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vaa4cem1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 07:19:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4047G2Ql016274;
	Thu, 4 Jan 2024 07:19:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vdqa4u715-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 07:19:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAz2GFvIxSF4uqqhn0fWp8LpiXPOuXinM3NqS+MXMbluHXuW3gGPbC/YdEwznq1KCmZNp9uvG2RlVFYFrj9O9Hx802D5y+W7IDvql26Ke/cVSV9gL8eFbXdZr7QJYERxb8xNDLmERFhCCyZndRF+u97gq1GITlJX0LJtan78rwq3HVcu8wdVEiU87a5v8XvDDIXAr8Wn2rYE8CWlbaq3uWKmKwqSEDkIqyDa1iazHCw/twa1ojuHbZS0JD+KRTSsu9mDz4ZeBIlrzIUxTqc6ehDOtW8MF1ZzQQOGXlBmeeFECuCxTM8m01t7csfNMcnPYTeGeVfuE7ihGolzjAVUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foKL+w0xdxWErNwbJhQKV0UhYx6NDYwI2K7HE2eqex4=;
 b=jbVnhBwl/NDCwp1hiBpSwogA9eZLYFcGsHI7cIM9MVeD1TWxYDZ+RwEdm/vbvmT2gn/9ntkw71R/Hf+NWJHmlSrbZPUXrw2NYeRWcj+E02fsJlx3jgszXfDE5bk3/RZz2cKLgeBqQQ3HS8Ada6Jn6JnCox5lyGoN6V3dOVqW8DKd7FhoO2GXEVNLrDy3cngr25FUv97DewBKmPaR3xiCshLkJWKtbqjk2SUoA5myjFr6idEI9uqtOA6z4qySKfhlhanM+vLyfz8qfRJWsF6Ta2IvKQ9+jwYZrXOJ90YRzoBVgXG+YZtNGCc5cxbKqpNxXBgKInj3lOIaviqgezZZvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foKL+w0xdxWErNwbJhQKV0UhYx6NDYwI2K7HE2eqex4=;
 b=U3lVGCqfhhKIbQ8bNirMNAH5mjpRf7PwNaNLfAOJpOLOGeN18/PFToMScZjowLkEJbp4j87jHmQODSyAIr1DVNtEKZQ2RehjkrOAMevxAgqFXMwMEGIskEQ0pq/jC48H/R05SDn/SRg4h6MbPHueYFPfJwxahuGKPmWbnu/rAEo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4671.namprd10.prod.outlook.com (2603:10b6:a03:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 07:19:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 07:19:42 +0000
Message-ID: <6f72f159-1aa5-ac86-3d44-4d3d4e68f779@oracle.com>
Date: Thu, 4 Jan 2024 15:19:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] fstests: btrfs/260: detect subpage's limited compression
 support
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20240102043732.143225-1-wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240102043732.143225-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4671:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e8b688-b745-4190-9f2c-08dc0cf584d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ouSwX2h5qdwE8r4aaR6uqn6Z297w9lQDgKlcDY0XOLb+oIYR1TwOJtcmCcbp/ydljvlZZb83GuWsud3irkb9IDfIKUNtZxFUxu6GdWaDgJAU8cOy8BrN8/0fFoVBP2S3wgHweQ2YqDz9q6AGYxQJ2oYMayC758XCHEwAtt4nzOWS7tteIBI2X0Ic2OfyHhO/jh1QfIt3NLYdM+H1W+5niD8Zbp01NFVN6UUrtIUNh0m93cKCVrgq9OEI8DItZ2W4eTNIfDKJNprCx7dFqz3CRDFOpo5+BVJb+z5PdBpnaiGgj5EuNV3WmuD5XOaKmTCIYjgLSRUOT51cwSB/hyjvX07TH1+TvhPhDe3ATy7z6L9nOo9XCFMZ+Zw5WtoP+c37+vxcLCqyi5nyODZ7aF3k9o1zQoQPCGgsx5icZEpsRewsW9MjseokP+3bonS/ne8/KTYw85z+qjR3NqCRtjZQ5RL9cmNpYhGkku6m20JZQl77HkYC8t4hOIrqn3leKEyfJU/lmvDGDTvL2oI+I8UJl85a7cOQM9Oc8H8pPJlmAcznHIeM1WCyRHJlrnCe5zKS/TKBoFXiDItbQqDr94195zldXT5laRYYmJp5tLd3ctamsbCgwbtggBOiW8CKILi1a3cDmuKFp4VOnaVeM0/DAg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(38100700002)(2616005)(41300700001)(8676002)(8936002)(316002)(5660300002)(2906002)(4744005)(44832011)(6666004)(478600001)(6512007)(66556008)(6506007)(66946007)(66476007)(6486002)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Zi9yVE01WUZFSHRWaTIvRFFPS2lHYTBvamdKaXpwL0d5alZhMXBWdUduRWJP?=
 =?utf-8?B?a3h1M3Yza0YzdTRwSC9nSHBuUUVIYmdIN2t2UUZoSWpoZDFud0FEU3BJQkdp?=
 =?utf-8?B?QmVDb2pjeDY4WUQxOCs0V2ZsVzEvbVRiZ3hBVzlrc2hNT2dMdTl4OVVtcUxQ?=
 =?utf-8?B?eG4rK1MrRi91NGFocUF1MlZFMmE5OFA5WWhBYVZldUUvR3VQVW10YWJQSVRw?=
 =?utf-8?B?eWM5clVoK0U5NUc3RStLaTV4a2pXdkRXUktJblk0bmxISjRFdDhGSDU2Wity?=
 =?utf-8?B?TjdDVVMwSGJkamJsSVBwYzVuMHNEOWx1THp0ZElEaWp1OVF1L29MR3NuYmt3?=
 =?utf-8?B?UFduN0l6b2tYTU5JTklsTlFDQ3dkUG92TUV0S3Njb2xrOE9GNGxIWkpZVEZB?=
 =?utf-8?B?Z2s3d1ZGbWNVUXJ1RG9ZT1BCdEdMNkpNb1lWaWVJcE4ySmROZGNRUXJKR0NC?=
 =?utf-8?B?OVpKZGlUMUdPRGNpWUNXVHhxalRBVUNwSlBjVzAvVGNveHEyTXIrMW1GYVlE?=
 =?utf-8?B?dG01Nk83WFpyMlZmVWw4bzBqcEdFSEgva0wzSEc0M3dWVnk2ekJySlQ4Z3gv?=
 =?utf-8?B?R1kxeWJYM1YyZ2JxZ2FnOEpXVThTejZaUjZXcWJDb1UyTGQ2eWZwQlBCRnFS?=
 =?utf-8?B?bXBJcmRwSXk1ZTRhbUYxRlZyUWtJWnFRbVpEaDA3bCsxSHNRVHFCUTRIWm8y?=
 =?utf-8?B?SDVqNmV6dS83Y213NmM1YW1mTE9vdC9HNUd1SGxqalFnT2JFWmtLVUMxcVNj?=
 =?utf-8?B?WXNOQVFvOTkySnZkU3JmbC8zYlF0aDZGbVRUZG42eGM3bUU0TGhRZnJaLzJO?=
 =?utf-8?B?cEFmTy9hT1NaQlhHNys3ZnNMWk8vc29qeDZRZUM2UTRzZGpvVXR6bjUrVEht?=
 =?utf-8?B?Z05BODhFTEliaThtT3QwQjV1UWtPbnVrK1hYVE1rb0E2R1A0VitYOTdSNWhy?=
 =?utf-8?B?Ym53bjdKM01ZZWhoV0V1ZzNxYlk2V1dRMVVucWFaenRzWGZwbFg3bDNjM3BG?=
 =?utf-8?B?NHlDL1JqVlBISi9IY1MyeDc2SnFJbm9iNjRRaWRPWGdqUjYxKzFzRjlmcUJW?=
 =?utf-8?B?SkRXTldvYXJHcGJVOHVydDhXQUdjb2ZSUTIxd1JpcS8zYm5nbFRWZkpob3hP?=
 =?utf-8?B?R3FwNzAweUlsVGlxV1B2UFFrTGZvbkZWZ0VQbDVLSlF2MHIyU2hKNzJiWXpp?=
 =?utf-8?B?MXp4Q01ic0ZBcmNndjJZaEh2ZEFORG9wQitpWVViVWJJdmx0dFhKVnk1T3ls?=
 =?utf-8?B?U3pwSFFXQjU1dEd2QUsyKzh1cTZBUnRMZVR1TGo5YVU0Z2djMkRQZ2dCaUlX?=
 =?utf-8?B?YTRPNnd0ZE9XTUZSS2cyWWo4UWlTa3dWWmU3VG1tRFEzdGZiL21lZHA3Kzg3?=
 =?utf-8?B?SjFtSHI1cU50aGdYWE5YaU10VUNsT3BVYWhqZmRFbC9HWmVJYU11QjNLTFdY?=
 =?utf-8?B?QllDTkRhSEVpNzlHRnpyTkxwRG5jMEI4TUtOcjh1dUgzemZUSmpsQVJCNmhZ?=
 =?utf-8?B?d1UyejFaRDZQeUs1b1dLOEdVNzM3UjYySXVtakV5YWZwZjVyeW5kS0ZZSnFF?=
 =?utf-8?B?Slhxc0xXeGVEOU1BRnVIMkJLVWFLNmxFSkV5NHltVXNwQkFTYUc5dEFXVlQz?=
 =?utf-8?B?L2lwTmN5MnduRi9FZXBsVXdEeWN3NTZSZktheUVqNGFiRFRzQU9CT3l3b1Jl?=
 =?utf-8?B?NisyYlRHSUdYRzZIYTBNQVpQQXo2S1Zqcm1Gb2lQV0s2MnNudmpCbFVsUlN4?=
 =?utf-8?B?ZnFpcFhQQUliRUc3cHJEOFpGL0oyTDlsR1V6b2RzTTZQM3NqaENFWFEzVzF1?=
 =?utf-8?B?Z1FIK0FOaVZMMDVIT2NGRUZFa1dOazNKc3JFdTcraklZY0hhYU1MVFl3MUtL?=
 =?utf-8?B?QlRRN2pDVXNzYnNiSlJDN2lWNGNNUXRDOHFjZmlLcGxXd1Z2eXBYWm5qOVNu?=
 =?utf-8?B?dzNWajVTRWpmL0ZsNk1IeFM0L2V3ODduQkZFYkJJbTZkQm1Na3g5bFN1Y2hE?=
 =?utf-8?B?OHNmVXBuQlU2QkZKNjQyeVRzcm5kYVYrUm5iY2x4cEtKN2tWekh3NHRHTzBu?=
 =?utf-8?B?aTNIL0I5NDZObklWdDMzM1NUWE9YQXpTYTR3cjZjYk9CNDBZeW9DN29jVVZ1?=
 =?utf-8?B?eVFGZ1l2S1dpNU1xbitxbFMwZThVeFlrOVA0WDVYcWVLYnZSY01ZTjFEeEE0?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hZTiSROWmSu6+IX8gHZJ84YK4mIEp0MMPqRPMuIbdScMg8n4NmekPXY/bA28uCs/GJLQsP/gzqOeSdyQNv3/EAvGhsBkDH/VwEcHyd3hVMTyeMCpaPF9CuSapjeBjtvUJAa3orBURHBXZWRV2PUq44jyVsFRljV++NAa0YoMXpQpUpu+XfO9hxfhX/QfhbGk7gqdijDF/CSep7zYdmxU5MMZc9f4Tzj/WOyiZH3/Ymn3BrPvtV18uKbzadANz2xKSTir5XzbTyXbdz5pIspALwG3EmTRssYqmICN/9XBl3KcFHCIP2hwk2uyjsVLE/kZkGpDdH4QWLiAjZhYE8xB4cB1bdOIaFORW64Y09/dSSZFuVZ4uRAvCwZC4tvqt2bid5yPMfkn4qakPeP3ptLLpAQvKC+MccvNYJXNsXSAmHmrTsiTqjZCOAzqu19tMgaaNG8gpvnXudu44iqae/gx5mYQEhdxThh/ahA4QwulAGY37ZDUXM8Kj4VAjQih/97H1yCJAUiYhKR4D/Hs/b4MHyyahnNwK8nhQsV3i94OAaeFW9N3dg/AQkFBLJc/aGF46uphyoXy8ju9f1By2NLIXBIf8Cky06jrxR/JFUpEHfM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e8b688-b745-4190-9f2c-08dc0cf584d6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 07:19:41.9619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFOFXGD6IBwWClTtTe6ySzTnrJPYGi9xWKgMbImScQNE5oce4JkBRdUVpH6Sp9Pi4Yf5H54hnzPZzGhFzTNuIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4671
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_02,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040051
X-Proofpoint-GUID: g-_-W-E53x2SypLV1wRQS9OwDfYu7upn
X-Proofpoint-ORIG-GUID: g-_-W-E53x2SypLV1wRQS9OwDfYu7upn


> Signed-off-by: Qu Wenruo <wqu@suse.com>

looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


A nit:

> + 	_notrun "Compression for extent size $extent_size not supported, maybe subpage?"

+ _notrun "Compression for extent size $extent_size is not supported; 
perhaps it is a subpage?"

(no need to resend; it can be fixed at the time of integration).

Thx, Anand

