Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305063387ED
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 09:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhCLIva (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 03:51:30 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36476 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbhCLIvE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 03:51:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12C8nVIG009996;
        Fri, 12 Mar 2021 08:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=gVWHjTUcwMbEPTE0+2EEDTcC9p4oO/qemZ7IDb6Lpj4=;
 b=Awvm+Vo/S0qtQUeSbIB0JXhK5eq/Yc/KaG6Mi+RobTqDNoa0NrguJMsFP7z9xVNomUQZ
 MO2XT4C9+OZ5yPYU52qm3TMy+yL471/hjg3vowXglIMQzOdfgt6AHOKvbelkNNNp9okG
 Xo81+UH4IQx91anzfOAMlfwiyqMRwGF+IHV4ID04twv1v2s42IyhsZr7lWnxMNfHjOwE
 se67Qen/KwWmdMFCiIv7ZNR+h5h9F26VZ9SYMVmV5tNbDSB9hE9SayOJSI0Kc5gjEQsi
 lTIY3xvDe9tGDfpjIL8Nosta41ISlccSzMvM7H3WxI2GpILCpzaaMgGIJ5VXceksY1aj +w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3741pms84b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 08:50:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12C8jecf134817;
        Fri, 12 Mar 2021 08:50:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by aserp3020.oracle.com with ESMTP id 374kn3s9en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 08:50:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaNdyJ4B2hWFsqKIHLjST3z4uGlfrUFM4IVEzyPbiFJ5S0RBNU0eaxUqLKwHn0Z3cE9wSLF5HhptQ5FRYdTgaNeC0QxlMZ9TzVNs8JJRL/lL7iNOrhfZVczgXGEmSnDNui8/wjNTfydDTUhAmdT9i/IwHCP6jHTqm1L2nmkd+SP25EulG98KEkzz1URkOH2Jn1SrWNUi65+ekJb/uDb9d6krH4JuxATr2uVk29LUU1/+B62y3Ekdju01Rpu7LWA9uHYrcCrMUXTWC33tL7S1dzfhzLIxca+DEwx4ckf1bvlxJ80suTim+XO7LZJSNPubDzgs0HnYoaoEahCozPf3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVWHjTUcwMbEPTE0+2EEDTcC9p4oO/qemZ7IDb6Lpj4=;
 b=CPohifUoFNpuPDdn+nJ/wyhf/Pt4VTnroMLjrCt1oH/KvAOkPrn/LEVZGyiuqRMvltbzieSLIzG1EDsPijQvanliPpkT9zd4Dsf9vlm61bz4lmGXnGxxvympAcwEFA1h3G1udHG5350J+z/FI+rozp/XhqLEM/ok46Yv7CxYGc3zWJtVCinKOiq9vcMOBQQCTzuK+aOHMtkdKN+OwTbh3MHqEVSClknzxZdqJ5chnImlsbEeUdonZkmEsAbm9LUd4y3NO2r0TzyI1wqB09hgS/Q22kwhtDRSfgUClm//BemDoLYxPSPNjT+XCdRbA90OqSAKiISbPs5MH7VHP05kYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVWHjTUcwMbEPTE0+2EEDTcC9p4oO/qemZ7IDb6Lpj4=;
 b=hMM7d2K7zwCtAb2wql31Myt4oc2/S7sWpoZEYhdGEvHTIDrRghmi0rryjEdakcIJ2z5cAmMNnMrW3n40KabWCuIazhvSHkps3qvrTks6BpmWbLtu5r4Xiik4FRCKFf+K2rgm/LctqRXAkPNPdFJD/WW8ZWwDD1585519t+S9MYw=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB4123.namprd10.prod.outlook.com (2603:10b6:5:210::10)
 by DS7PR10MB5022.namprd10.prod.outlook.com (2603:10b6:5:3a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 08:50:56 +0000
Received: from DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::197:4808:e2f2:a8cb]) by DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::197:4808:e2f2:a8cb%9]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 08:50:56 +0000
Subject: Re: [PATCH 3/9] btrfs: move the tree mod log code into its own file
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Cc:     ce3g8jdj@umail.furryterror.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1615472583.git.fdmanana@suse.com>
 <ac64033d4afeff5c10c4993323e7c1a388304aff.1615472583.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <a6275218-3bf6-d841-a67d-97f210940736@oracle.com>
Date:   Fri, 12 Mar 2021 16:50:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <ac64033d4afeff5c10c4993323e7c1a388304aff.1615472583.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR0302CA0010.apcprd03.prod.outlook.com
 (2603:1096:3:2::20) To DM6PR10MB4123.namprd10.prod.outlook.com
 (2603:10b6:5:210::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR0302CA0010.apcprd03.prod.outlook.com (2603:1096:3:2::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.10 via Frontend Transport; Fri, 12 Mar 2021 08:50:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b4146cb-1060-479e-4134-08d8e533f382
X-MS-TrafficTypeDiagnostic: DS7PR10MB5022:
X-Microsoft-Antispam-PRVS: <DS7PR10MB502287A15DB216204295B247E56F9@DS7PR10MB5022.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EpI9jrukqLKL9OX39WkIAEHAF3WjILmm6Wb0DnHee2kNMtqpn8m6jkoAdSPwbtjPFiIB7gm84D3/VuAx4wt5nOk24oFdhG3uHZTN1GY5jO8G7p2yyKwB1s+KWB76X+gABXoE2ZaBfIp0eGYX6u9flFe3DMQONsSQ1XLrMF6mXUTwWZtB6Mpnh2AVjx1iMlPR3oySOYh9upXxQKFngiR/ZBXSAaE8/14emfNhWIqHwMR6uPlKZKzcHlAICWyr2lZMvOG9BVavIXvSEHmPz24Ljx014/AtLutko+tJ3LxSJ14CNGy5K2WDaxzRiNXKDc9TeVDR5Nq/8uapXBrKCyifNsckjEAnjGBAM11w6xnbFVd5FDfQWlml7/N0RxYpMjYG5lJ3yzODLGLrvlnhJDEtGo04TLa+cayeifdDksFniaKcRhFErEtyUEBrcSuxr/ZycFOw9S7SNkZ0wJ9F4VilCoU1K/adtczrWHkSiUmqzwp0X1xFCcddHR7CD5CAeSAnP3RzG3/BcMiigNQMnAomXE6gFVRbFs4xhSWnONoBKBKt7XdsHnkZulk875yCyC574ierCGGONpccYzRLrqsKZh5UkxlJS0MbL5qaqEpdoYD+pY2ks7YwqSWmwlPxoesE6sk5J07s2J5jSGB/C1cirA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4123.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(366004)(346002)(376002)(31696002)(31686004)(186003)(26005)(86362001)(66556008)(2906002)(2616005)(478600001)(6486002)(5660300002)(8936002)(44832011)(8676002)(16576012)(6666004)(316002)(36756003)(16526019)(66476007)(956004)(53546011)(4326008)(66946007)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c2JHbW0vNzFId2RFZEVQbjMwRzJCYjArejk1TnhOTjgyRllwRFpkcHpTY0VL?=
 =?utf-8?B?NWNyeEJ1ZUNibXcyVnFVVmpIUFVQSWlLanMwSzRyVTNvV3g4SExnMmpkT1lW?=
 =?utf-8?B?bm5WbzdQRXZKY2FuRFF4eThadUYvKzE3VjhqZjFHaG16Q1JiRzZrZjZHdFNB?=
 =?utf-8?B?ekZWMWpKSnA5dk9WTzl0WGVKOW5oazFxTXVWUUpmUHdzNFZQdjZtTjU3dUlu?=
 =?utf-8?B?d3dhbjFGZFVSTnVxQzRiZnBZZkpGc1I0ZFFRV3Y5dnpIRmxNWEppY256Y01z?=
 =?utf-8?B?N1hGTk9RUG16RDNUYkRMWG1oVDkwbnpCQ1I0dXhpUjZmby9OTVlaemZIT0JN?=
 =?utf-8?B?WkpBd2tUd08rWmdJN2pvVmpyaitUcTFxSzB0ZFcrUkVQaERlb0FuTDVqRU1m?=
 =?utf-8?B?OHNzN3pZYklrRW1BdUsrVklEalp4c3AyWUZRUnRUSENnUysraXR6NkpUU3Nv?=
 =?utf-8?B?WDhrMExLdzRrVnptZE5GbVRrbU9LejBja2l4endaVzhFTmFnMTlKckpzNlM3?=
 =?utf-8?B?OFYxalRONVc5NTdyUWRzdUp5R1N4Uk9nRGZ6ZklpanY0a2VLN0JFN2RBVGdy?=
 =?utf-8?B?K1lGa25NWGpzbHhMaVFqTHlxVWN2TVE4alp4MEdoQlY2bHJzUmJLNXN6dUdG?=
 =?utf-8?B?bytEVm9lbEo3U25rbXhTeDZSdUk2a2lZcTB3c0JzQWkyQ2NTZnhCRnk2NVU3?=
 =?utf-8?B?THVzV3daYnFTR2E5ZS92SFR6QjNiQnR4VHZBa2pDRkVNMDVSYU9xUmRLMEZy?=
 =?utf-8?B?cVN2MVNFUWxsenVJdWpDRTNndU5hTzdQNmRZYStvU3gwRWFEamVxUE1XRS8y?=
 =?utf-8?B?V0hRRUVac3FyNVhucmJ0WHgxdHVxdGhDNGNLYy9IWnFzVkpIdEFucnRPaFJr?=
 =?utf-8?B?Ukc2YnQ4bmNJQTZVUFhTZ2ZOYlRIQmpRK3RyYzhpUmpWMlN5U2lXeXhJT1c5?=
 =?utf-8?B?VGpRbG11UGE5NUYxR1NVdmpwbnhpcjl2WXdnR3NDSFRZL2VGdU5JMVVzM0ww?=
 =?utf-8?B?SWNUSmZWeitIdDBPU09GR1A5MndFVnZWc1NZN2ZpcTQ5UEROa0p6a1B1ODdk?=
 =?utf-8?B?anJnWTMxemlQUGorbytKZjVuZzd1dnlTTTlURmdIUkhwblp4SHZoZWFxdDR0?=
 =?utf-8?B?UHh4cXh5aXlkNkt2QmR3RDdkZmgxWnowcE1Sa0Evc0tJS3lVeDJCa3J1VktE?=
 =?utf-8?B?NGduVTZ5SmFTL2loeUZXMnRFa1lpeG5zTTZ4a2lSa0xWaWtBRkh5S211bkxi?=
 =?utf-8?B?c2NydllVcHRmL1R1b2RzRmkwOW1QVkduR2lxMW02ZFBLN2YzZUEvNTVneS8v?=
 =?utf-8?B?ZzlCWTh3bDA5emhhTjhkeFhRSEV4dWlOcHBBMzFicCtBWHlTVDVLazdiSnJs?=
 =?utf-8?B?U2ViL0dFaTFSQ0NkcUxEK2RwZy9MNkh0Y1MzU0dBTG5URkNmaVBUdGxUQXpO?=
 =?utf-8?B?NUNBR1RsdG5xUWwyMDVDeDBucXdXa3RESjBPY2NQTUxIa2x4YktrclJicWJS?=
 =?utf-8?B?Y3pvYzFFV3Zsa2dLbnJrVVp4VGRnSUUwbnhqWU1STGxPMVA1N25WYUNMNmJ6?=
 =?utf-8?B?OU5jNDVVa3Bha2l0RE1nUjBLNFJRaVdtd0FVZHFHSTU1NmVBaENSVEtEQTA3?=
 =?utf-8?B?ekFKVnB3VVJUbDN2ckE0ZTZia0l3djB6V05WQnVnT2N0YVJpTkt0RVdiNnVh?=
 =?utf-8?B?WVVkMHVycUo1bngwZDFZRjBySkNZNEVTUnVGRE9QellrTit5T0xQSjhheXFV?=
 =?utf-8?Q?TQ9ZGD1QHrjaNkY+Vpy21kybWJMcTDIzVLNxhvF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4146cb-1060-479e-4134-08d8e533f382
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4123.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 08:50:56.8529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbSyB4vSSkAKUyGFCvZHOP/aOUchjuegFuHePATH/8zzCLOLicK7jfoFH3NFTYvEmamC0vSvbW0zyyIVr3qn/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5022
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120059
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120060
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/3/21 10:31 pm, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The tree modification log, which records modifications done to btrees, is
> quite large and currently spread all over ctree.c, which is a huge file
> already.
> 
> To make things better organized, move all that code into its own separate
> source and header files. Functions and definitions that are used outside
> of the module (mostly by ctree.c) are renamed so that they start with a
> "btrfs_" prefix. Everything else remains unchanged.
> 
> This makes it easier to go over the tree modification log code everytime
> I need to go read it to fix a bug.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
