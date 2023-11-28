Return-Path: <linux-btrfs+bounces-427-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E62677FCAD5
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 00:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC5FB21772
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 23:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A71A5B5BE;
	Tue, 28 Nov 2023 23:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XBI/JIzA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t5cC+auu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219E610C1
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Nov 2023 15:28:33 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASNOD08029051;
	Tue, 28 Nov 2023 23:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Acue2tnFxJkH5RiX63TAtdye89ZY1qIdApSPnzW1MM0=;
 b=XBI/JIzA0JR6C502kBFzb1TFYbA/gXf4ZGPY/RuVQ/0npm1T6Qv55AgggJGVIfZbussX
 DE5y+/du8rGni+KXfb7ge0Mv5Dq2MAZrWmm7uZUlynRd0tQJhIJwop05yCwGPgW/bO2q
 z9LyRM24kOm8jPr883cdKJb7qIfnkk2/NxHivTJsF3mTHvJa/KhJ7e/nayvtWBL3FHBe
 EMcZzVTuJgcXAKa4QsrIgW2zym2+26u+quJNKpNZqArs6gcXN8Akm2ou9NXhw5yH3Zqz
 wx1u+0+Cn3zv/jQsrAxyftxLeVE2XMkwzm7kR5pZCU+aFJnnlG+rKaBj+LYDdcBCkf4T ZA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk8hu761s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 23:28:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASLxPvm009626;
	Tue, 28 Nov 2023 23:28:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c7euca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 23:28:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaUQtUnYRWlBzXCT9cU3XBa7yV8kSFzedF61gKn0H0nxF46Zz64/6xWbHtl5plwXBxJQV/MWAWe1HwQg7VvSAb+Pk9WT0984FMCIZey/OPY4hJQkg0CZLw0nKsen0xKoe0hy4Kztxp8cr5yQe/EtJZdb80e1RZMdxigHRaEvlDIgTyi1Lrt9Z07JGmSh96VkFhCFFiAOpE5hNTZM7vPkLluknsEdTy7YHYecelemLzp++TIBYSkmA5xbM9rO5pJ41zvmzLzMimU6XJaIA4flB85JbrW5LRryZCCY1581bxq9VgtPGaSTvYpvKY9aJHD77yJc9FZu56ZeN0pxpiRuEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Acue2tnFxJkH5RiX63TAtdye89ZY1qIdApSPnzW1MM0=;
 b=K4FW8iwcCWmFDNTwCaXCf5IZsF/r3U3AqDwr3cyH3IEFnxfZIUE+96G0KAxG7dw5UhFQeRpLE+chokKn23GYyYIYGhxrdk6rfEiVkYDUICn64UNYbxfoWpiLnGaK9wQqXA2tamAQmiBhNUMJe/ay6NoGRWBoavtj15yI+35h2p41m6sClUzGyle6PuVKNGY9USIPPYDO3sgroF6A8zEBbKoYPHfQYVmCfOmm+qr4/po8TJsjngvVNZ8JgEUL6k+cR9ipeWs1NUki/xJ0/eD1NBYbrrerIrbWFvvZJvuxkrzAXffZUgzLvvnu65RxpNWNxFSsCpXwwhF01BmtrEW3lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Acue2tnFxJkH5RiX63TAtdye89ZY1qIdApSPnzW1MM0=;
 b=t5cC+auuvNGpnFEq44dEwzim5Y4T84EwOC6Ieg13h2v7ohAOgcrEMHb3NCcg6HlbyQ8UnO931TZEoytjJCP7FzmazA19cSHSehUM2LMQzsKcv32Z/FVIfF2aVyYxEBwtE1aeSZa4LbL1QrWqwR8hjySuYWgqNzwSszpmmRLlUo0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 23:28:14 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 23:28:14 +0000
Message-ID: <336d54f8-3a27-a7e9-3482-781559fab709@oracle.com>
Date: Wed, 29 Nov 2023 07:28:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH RFC] btrfs: pick device with lowest devt for show_devname
Content-Language: en-US
To: kreijack@inwind.it, dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <85226cf68d7a72a034f0c0895b96b2557169755b.1698917826.git.anand.jain@oracle.com>
 <20231124161906.GE18929@twin.jikos.cz>
 <36171811-ed49-4427-a647-e052ec70faa0@oracle.com>
 <589d8650-26e8-4c0e-a602-bdb5ce427ed5@oracle.com>
 <2248a4d7-bbd0-4bf3-992a-c1e13c8f2c20@libero.it>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <2248a4d7-bbd0-4bf3-992a-c1e13c8f2c20@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0117.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: d08f3d24-0540-4e42-a95e-08dbf069b133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	y88h2sed2lHsAtgJqbs5xZCAqNJIU9/z5VWVdW5Rxx36oc4uHe0N0Sy9h1wgBtrtgRznLYTv8NAIwyvGwZUI1lEJmnHTxMPm+iRMeinyZHnM72TvTT8Ki6eW59i6jOLoWiS6VUVU2/r7dzFw7rMyBclEhZHh3e/Wv35RV2wCnba90anQf/lgLBNPXcESBhDNReBLH0oknzVeNxIH8BD9Xy91j7XK4rbUcbmoVY6Mb6yPH8jsvvZ7PFoEpHywF/OBdxsUkg9TzsBIzxe5tJLUL+5EixFy1XRKjWr0YkhjUdivr9KG/0Mts9mryPUAmF9ORuxR5QYJLlLLgg0g0QLPNvMTXTU1eItwZTQnJxZ047F2fySEXu9eH0RsXUj4DZkwRkIUgPVX3I5otv+9Lj2IRlE5343IM9S7hRYt4BR/mX+bgmpz08nedcMkUC5x39Ozn/l+WA1yrJuloFxkuQPAEA9+Q/CwWpbLd9UHOwbxEOFP+LbkNmXUYPYJ72RC4pskD8S/npDvE4ZPSbJy1HZq5onF5rZ/nqhIgy+StZmVbwgNOjAnPdDuw12HfbuwnRPdWgJEdNnRftmNLVE2Mbkk4BRyHFR41z/RuL7MxORAIEy4EHNmq8UBPhyI5nH2LKOqNwDdX2m2cJOTMt7ZuYGKO+sBhCKSN8PVl1REmArrEcw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(376002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(36756003)(38100700002)(41300700001)(31686004)(2906002)(83380400001)(5660300002)(86362001)(26005)(2616005)(44832011)(6506007)(8936002)(8676002)(4326008)(53546011)(6666004)(6512007)(31696002)(478600001)(66556008)(6486002)(66946007)(66476007)(316002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MFZsYkt3YU54UFZzKzRxWDVHZE5HNkh0alQvQTJsbmVod1FBWlIvNVlKWjVj?=
 =?utf-8?B?Mm5qbUMyZC84aS9ENVlkZVBPT0s5VjBUM3VyUVBpdTZLalNQUWUrSkVPQTBY?=
 =?utf-8?B?S2lpTWdyR2haay9ERnNCTldrUWd5TVp5N2QvbjZCeE9CRUdBVTBXeHFySTVz?=
 =?utf-8?B?VjQ3SlNXSkZPSHZhYTZuZUNZT1FNZWlCR0ZUNklyaFhZcE9GOUYrWUVRL3RS?=
 =?utf-8?B?K2FQZzN2TlZySzN6VGVJcklzRUNmdDcweFY2bmdsR25WRTlBalliZUFzRHdZ?=
 =?utf-8?B?RkpUWE4zbmhxdWJqa3Jram90NWpDa0tCLzNwdk1ZS3Bsd3JXa1VKdDZqeVVz?=
 =?utf-8?B?eWpPUzB0QW90L0wzS29RSGh6b0tzQzV4WkROanhmeERTajg4QnJobXZUNWRD?=
 =?utf-8?B?eW9RU0QweTNsVUV2SmdJMGwzMzV3eGcrbVZIVFZFV2lESFdBMkJTVjZoUWtj?=
 =?utf-8?B?OXBtdlp1USs0ZnBnNC9WYjYxQWEvY2RxbFZrWnpzS0wyUkkvcmRwQmN1M2FE?=
 =?utf-8?B?d3RrbzRSNkkrYXp4ZHAvYlV2cTVSdW5ZdWdTMC9WdTRTSXlYaXM5dUpBNEtG?=
 =?utf-8?B?MENobVNFTW1PazQ1WkdkV0NtZlJOR216ZWdmTWd1RDE2YmU0SVdCWllWQkJu?=
 =?utf-8?B?ODVLb05yQUgzTUYvM2hHeW11RVJ3eUVZTDJsTEJXWXlvRWJxN0drNzVUeDBx?=
 =?utf-8?B?a29TZFFMWGw2M2pTQVpFSHdDV1BlUlpWdjdpdGp1eEJYV1ppMjBUbUVFNk93?=
 =?utf-8?B?cG9kRmNDZnpyVlM2QmpvQThlU1M3K2FTcDUvdlkrTzQvN3c1cTdmV2Ntd0Jj?=
 =?utf-8?B?Ky84bXhmaFMrY2VxdFVZR1Fka25oQVdVRzN6bzNqTzY1NmxFMVpJY1FPNlJ4?=
 =?utf-8?B?Q1lTODJONFZxcVpsZHpKbmgrakQzaXR4ejdMak9TcWZSYjB6WDZQbUNqcS8x?=
 =?utf-8?B?NWE4cndZRnprSURrMmxGNExnMURuTUNJSFg3WEZsOWtVWjdGbDkyc1lOZk5t?=
 =?utf-8?B?NlJsajBoZlNBc1gwQWpRdUJzUGdvQWZpdE9KMEk0NlVhUk9oVkVkT2w4SHdm?=
 =?utf-8?B?TUpuUEFUVW91bUJqU3lyT1dDU2hsZ3VsK0l5eUpENWdjNUlhaFpJNG1pNVE0?=
 =?utf-8?B?M3E0RTBwNWZWYUQvWXBMS1VtVDZNZHcydDRaRm4rUEx0dUhMQXNrSTY3dVRo?=
 =?utf-8?B?NWlqejNsMEtYeGpicnJmNTNsamFMSjBSU3NFMkNZbzVWdmdyaUx1cU10VFBu?=
 =?utf-8?B?MVV2UE9tTFZKUHRFcWVBSDVKVERYZ3JHcTZwbHhsc3VIYkNZTWduMTN6Vmll?=
 =?utf-8?B?ejZTWUpHemd4UE91eHFDTWZGUmovVTg4VmJyRkxjWFFmWFg4TzdrZnM1RmNV?=
 =?utf-8?B?cDVGYkZlZjZoMXZhYUxiV0dvUzBKb2c1OGpJQzRrem13dS92dFJPVXJET1p3?=
 =?utf-8?B?eDNKYVoyOWtXRnVzYlhQK1ROZTcvQktVTVRrejJkT0llZUd1NEcxa3lIK0dZ?=
 =?utf-8?B?S3Yxa05XeE80K3dlbVhoY2tPTTZFYkdWRTYzdVhPNk9Sd1JzQm5oMitSY05U?=
 =?utf-8?B?OWxYMVAwSkVtMk41cko1bCtHRXBQZXgyRTVJUmMwUFFYek9YSHVMWS94RW1o?=
 =?utf-8?B?TzdXLy9wTXp5aEo2UWptRjVGNFJibHNDc1kxdWtINFVQRnpRUVBmOHV5bE85?=
 =?utf-8?B?MTJRTzl3Njh1K3JSUm0wK2JXN3JLOVFobFVBUVdxNCtpTStOUmlFbFRFV3Zw?=
 =?utf-8?B?SHZRZDRRZnpGMkxPbkl1cUMvaGc1MjVZbEVDRU00cC82djBXUFl5SmpudWM3?=
 =?utf-8?B?SG1vZzBsNnI5eHV1RnFLMEhYd1RucVRxOTRwR2VDSUdxenprTDQ0d1ZMVTRv?=
 =?utf-8?B?NVd2VU1CYktNS0ppQVpFTWxiSHpaekJoNTBSUHdpaDFMMzZYdElZL1pXYkl5?=
 =?utf-8?B?c1J0MVVmU2lGWXppYWxFdzZuSHgybVpYbVlxRVRhSDVTMTF5dXg0YisrWWRR?=
 =?utf-8?B?clJSZU1relpKNG5wNUp4b2F2cE5QOHZDNHRqOWVmbzVWLzdmS0J4d2JBb3di?=
 =?utf-8?B?QTViSE9GOThMSVZNUVM0eTl4S3VDZ0I2cXJGWHRhSUhOOHVmS1dlSTlEQ0pw?=
 =?utf-8?Q?Jc4fdcKng8PVjUp5AgVoVPaPW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/Tqexl9IKCv69DW6u3mgXc44xks+Tg/67ZZvOsytBJfXyUQzu/GVph8AGbwuUmH09OgQr17FFa8FXsQuuuVi4jYi2UmGHJJ5JSwN4EKvuXcZU4KuPU7g5l/ewBJ3JtQ+YuUL/HO6lPahBqyS7DEFdHPQWqlt7iL/C5dDYh/B3Gd5EzkMcwieF2Ylh7/VKiHSzfSUn07paiB4ORC20lGPHVZNDntCwuxtmys45rLO7rK3cfcLxjLZgr7qr1D8gu52e4phbl5rAEBhdMhDD8JRjFFVjEFKUQJBsdWngyZ6R6PI5cW6oKKX0FxT/ZUVlUNGzezZ6FR4Gti1x4ijuKDZexKADpJAo5F6DPIsoqyNbmTd8NhSd1xmAy6kc2aMW0ypTCgpxKPq+jaG1RLLxPd+Qx0cRIOlffip7pDC2OvftMQOw2eBrHD+M+nXpn1GNCt7tZaCwq2b3rMSOLCTkwSLm6nMYp4tLytDSajGhfaHAHKl3A9L9VUASoaTXvlabKVbbbE9pqhyFVH5XYqxACSdPObM3kqClstHx4LPaXvLxos54lFLWqcq56lnEoqIwk8IcICmNKUwBBpivvFIydf/eZXm8MhXkZNTpi2Z10zY9Aw3hNFQEhr48RhbjbNrPlth7kDDDKrnUDAfeoXSbLpQm87+Y54S2Puj4nIIoD54gXCAmMRRo3Z/vkg8vb10icC/ReXY5CnvaPANUte7gdSFssGSuZppzR4eAQizQtUuTIb0cbL++O09G+You3CDY4yhGIAz/ydev1QmQgVcAuG+ClXBvax1XxUFXpaNFhNxPz7yOeFD3zzIWFSZ/9J5W89X
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08f3d24-0540-4e42-a95e-08dbf069b133
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 23:28:14.0995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOax9lFgTr1Bg3aV/HsYOPs3i8dj0CgccQY7EoaTdBKyAc53RJbWoKug4FHHpaVdAZ8hjz7Rdpdrb94zgkB3dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_25,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=597 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280185
X-Proofpoint-GUID: 1jdfXlVckjNnKKSrzQ9N23jG8Bs0hjt-
X-Proofpoint-ORIG-GUID: 1jdfXlVckjNnKKSrzQ9N23jG8Bs0hjt-



On 28/11/2023 16:00, Goffredo Baroncelli wrote:
> On 27/11/2023 12.48, Anand Jain wrote:
>>
>>
>> On 11/25/23 09:09, Anand Jain wrote:
> [...]
>>> I am skeptical about whether we have a strong case to create a single
>>> pseudo device per multi-device Btrfs filesystem, such as, for example
>>> '/dev/btrfs/<fsid>-<random>/rootid=5' and which means pseudo device
>>> will carry the btrfs-magic and the actual blk devices something else.
>>>
>>> OR for now, regarding the umount issue mentioned above, we just can
>>> document it for the users to be aware of.
>>>
>>> Any feedback is greatly appreciated.
>>>
>>
>> How about if we display the devices list in the options, so that
>> user-land libs have something in the mount-table that tells all
>> the devices part of the fsid?
>>
>> For example:
>> $ cat /proc/self/mounts | grep btrfs
>>
>> /dev/sda1 /btrfs btrfs 
>> rw,relatime,space_cache=v2,subvolid=5,subvol=/,device=/dev/sda2,device=/dev/sdb3  0 0
>>
> 
> When I developed code to find a btrfs mount point from a disk, I had to
> consider all the devices involved and check if one is in /proc/self/mounts.
> 
> Putting the devices list as device=<xxx>,device=<yyy> doesn't change 
> anything because
> the code has to manage a btrfs filesistem as "special" in any case.
> To get the map <btrfs-uuid> <-> <devices-list> I used libblkid.
> 
> I think that a "saner" way to manage this issue, is to patch "mount" to
> consider the special needing of btrfs.
> 
> Pay attention to consider also events like, removing a device, adding a 
> device:
> after these events how /dev/disk/by-uuid/ would be updated ?
> 
> What about bcachefs ? Does it have the same issue ? If yes this may be
> a further reason to patch "mount" instead relying to a rule (pick the
> lowest devt) spread for all the projects (systemd, mount...).


The display-devices-list in /proc/self/mounts method simplifies device 
listing, bypassing the need for sysfs or Btrfs-progs and it replaces the 
lowest-devt approach proposed earlier. And, yeah, all multi-device 
filesystems would need a special case handing in libmount.

Udev's /dev/disk/by-uuid, gets updated upon an (over)write sb event. I 
don't know its updater, it is not in util-linux,  I find no rules in 
/etc/udev either.

Regarding libblkid for Btrfs device discovery, I m little confused what 
are you referring to, an example would be helpful.

Thanks.

