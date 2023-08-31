Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4D178E3E0
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Aug 2023 02:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbjHaAW4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Aug 2023 20:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjHaAW4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Aug 2023 20:22:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64394BE
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Aug 2023 17:22:53 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37V0DhC5021825;
        Thu, 31 Aug 2023 00:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=EzGZdQSWg5eEqpT16yyMpAR0uPPrFqDPnUgCGfkMeoY=;
 b=MVrdNFvyKLOVcMz1Lsp81fFGKm8kNVoVeD7Xz92qqF1zYfNXbWmPGhu03wR/c9J/2iAD
 0UWdJOHOs3NoRFSd9GMAyM8OTxBOTX734OAegHxw5Ck1Ma+buTLIbgjWlsUnKx7ZZVwp
 1AZsoIdEdNnT9IgwsI3bF+XSHtk7J0uieIZtSGyI1Cycv+IuqtPoWZVUMA6WAWX/bY2x
 TWt4cQBGZwvw5iDBKCaweaBytD202uZQshDsMd8tGfATdKBQTVjT7dQk8lTR7FYWHCxw
 uI42SBDnISpPh3NnETuggPb/IK6OQlyyv6tRfavelSuRLH7gXp1nAlxgKa/EVNfMsyqs nQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9fk8pnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 00:22:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UNLHeX000581;
        Thu, 31 Aug 2023 00:22:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6gdagwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 00:22:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMZbPjozf9NYu2RC/K2ojHbUiKqI+uk/8w4VC4eMoq2JiJBXzWAqgs2619nVSRSKNUGKz50Dt7c4JEaWLLbMNcGAGXShtvceXek/MoqtKqVn3KJwIyVYrfwkkoEWMxy+sJZ0isxZbpYt5dfcVIgRfv0NOw6OzKxO3zt6B3Ny17ZQ5revmc9PfrJ56TLaVoCLOE3MRrrlCYS5ZcF+7OrJaY+xGWyWMK5lt4fEgCjYvyZzU2AxSjuWkK0xF61KWeM7X2iE/UeFbdTDGVKgCw1P63MapZhq61L22AhLbi9LG90mSGTFdPOgTGLhGs6C1WG+fFdKs4PpAptJz1Xeo403yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzGZdQSWg5eEqpT16yyMpAR0uPPrFqDPnUgCGfkMeoY=;
 b=BfsHQbReoMnLHgF6G1AGC1w3sLyepdXQa4CrQodKHkWDVEthGORja8TWpyHCwFftGsTclFBxGecMmMCumQD1k+my2a3/iXwGfnI2lvo+nPRfF0tWLU7bQz55a53rGSlgmBCggmKSHScrvzN7CTUyX/6Q8zwaYQuFttl0fAs8JmWUjeO2J65ZoQ91qBYD4LMV/y2zaylNRJjS2xCqg4brA30GIc3ytxQGrxzT81pjoY0podC75DvOOxEhFh8/z9SW4iCM3GMGFtTZTc8TYJi1JmXzli7/Gabw72APkmcXf/qVpCBih0Z60LJdQnhrspZKg6A0KI3KjTm/ObcuF8UOzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzGZdQSWg5eEqpT16yyMpAR0uPPrFqDPnUgCGfkMeoY=;
 b=nEYAZI1LfDqxGiphlEHVIu9Fv352119+G6ZjXe+Qr6cqEs5fyMiu5bFlbwM7QaSqAypSriievHat9/c3Kop4+xYHOOcuETWQ0QleE0ZuTc4kMvHd9tBLKCCZpSsP3bBPOIgduxS58xz0th5HhCj9VSQRpCP5vbACjZgFo5ZLczU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6319.namprd10.prod.outlook.com (2603:10b6:806:252::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 00:22:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6699.034; Thu, 31 Aug 2023
 00:22:39 +0000
Message-ID: <606c5a32-f14c-1276-cb9a-40ecbdc30f19@oracle.com>
Date:   Thu, 31 Aug 2023 08:22:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: (PING) btrfs sequential 8K read()s from compressed files are not
 merging
Content-Language: en-US
To:     Dimitrios Apostolou <jimis@gmx.net>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org
References: <0db91235-810e-1c6e-7192-48f698c55c59@gmx.net>
 <4b16bd02-a446-8000-b10e-4b24aaede854@gmx.net>
 <fd0bbbc3-4a42-3472-dc6e-5a1cb51df10e@gmx.net>
 <ZMEXhfDG2BinQEOy@infradead.org>
 <62b24a0c-08e9-5dfd-33a6-a34dd93b1727@gmx.net>
 <da72818c-6327-44d3-aee8-a73e7ee42b65@gmx.com>
 <ea6bde1e-1181-6bea-bc82-12d8225952ef@gmx.net>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <ea6bde1e-1181-6bea-bc82-12d8225952ef@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b98fff-3a3e-4df8-6428-08dba9b86235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pBXKdScUM4bwE3kPQJ7dv2EdN2deJlePB5kH+qhVCp0NZIjMTEB3BsRCnnPqwgaQb/G5i2gOuIXvOQLsIe4gjS6A5OCixy6HQOP4Tki8cThfdTXlWuMq0qw8MDxpAqEb2FmTBcwm+sdT6SrmXaj0j+PwZWI1JALDxqKVBJ/CmFq9w8a7PGUb0+K82xCyRyz4IoIbVhMnzn5S9gWwMkgK3qAOBGlh3jvok3FzI3ixbYBDMK9muGQxD+w6uSmcMa5xr1aQVSgNjz9yE3u6Tqwp7QJa2X0Z9VKh7TmG4rkK065DipqUYIabX1HzOKqT8iE0DR1SCTMph3qLmgAbUwtMQDOMXcm+E0gx42+qRdy8GuoaQLEiLDmlSo0otkP+kZrMz7fOr+Cs0O71nCMJUpZqPA7Xq5k2EoY8Jq/+tw4tVNZXftLGow2yqAoZUPfrxRnb3NRG1GQSuUOGsIW7Tv4zETkxtTTUr3aUm7gBUYxiPTSEMZzGfdmrzDNeAoD4GN2n5om7kZj+GR9pwntnxVWLGfVtPZWd/poGWdWFw3/Mzhk15OJCzX6r9L6YrVLPyu3oZPEthU3O4ZBq/3/LR3HQ6EVmmdCM/fCAnFQmSN/otHojp1E7snJ7uZEar3sUo5FzR0OwkcDCDd3DgZN7UqrZDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(136003)(346002)(186009)(1800799009)(451199024)(8676002)(8936002)(31696002)(4326008)(86362001)(44832011)(5660300002)(2906002)(31686004)(36756003)(478600001)(38100700002)(26005)(2616005)(83380400001)(6666004)(6512007)(6506007)(6486002)(316002)(66476007)(66556008)(66946007)(110136005)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk8rM2wzeW1sN1hUSzU4TElDZEVtbmI2YTg3MzJFVzlDRmViS091dDBOcWZh?=
 =?utf-8?B?N0xlWEE5K3MzazZjZGx2eGhEVGVoU3BYL04zTVk4ZVdMelhaWDFuSit2eFFO?=
 =?utf-8?B?OVZSSXVtcGx4OVppRWlITXh4QkdlVFhKTWhQTDZGYUZiV0NsUnFjcmw1WGhi?=
 =?utf-8?B?WmZuMWpwTldMdlVtaWJmTjVUSW9jdmRDeExKV2NhODlQNEJoc0RMbnB6cjJH?=
 =?utf-8?B?dlpmMHRZUkEvR09QV2NUWjlvS2ZZQURBeWVhMmJiUmFvWHhmdGxHUWUzaC9y?=
 =?utf-8?B?ekJOSU1aV3FIQ0x3V0c3eS9MM2tHcVFIYjdaOXZ1WExjalluK1FPR1ZsSVZo?=
 =?utf-8?B?NjBWYVBqenNVUUdja0NsS0VsK2tvdmVJMGUxVDZSdzlEQ09qc1JOdkhJZzNl?=
 =?utf-8?B?aTRyMU5rb0tNOEl0dFBZQ1huUXJlQ1RTOVVwTFkvS2RCazRHRXBqUHM3VkQ2?=
 =?utf-8?B?TjZKTkwrcm4xaFg3eW84bWdBWTZDdUcyUitMaXVvR2VidVF3a0RWUWVEWVZ1?=
 =?utf-8?B?TnIrbEcwL0Y2NldvVEdaYWNJb1RCckNGdG9oZjY0T3hlTUhlOXNzV0x2bHhj?=
 =?utf-8?B?ajUybGlSSitDTVdwUklWQlZoZVQzV3dZbFc4V1llb3Fzajl1cXNvWlBoVUFw?=
 =?utf-8?B?NWUxdEd3aEM2L1NVQ3FyTVNuM2RZVHVJbm0rODZ2NlNCdUxtR2EwZzhZcFhV?=
 =?utf-8?B?ZDF0L1dsV0RRcWhwNG9ZcHd5cGdDN3N2dFNMd2UyL25xOEVGd1hIdk5MMkRq?=
 =?utf-8?B?a1JjWFh3VFVKcU5PeWNSeGJoR2tQdU9LcnBldkw3OFJWS2tsRE14ZXJHbkY2?=
 =?utf-8?B?OEsveStPRFFucGxpaGxKRFVzNEZKYWZHU21NeGZMVnJ1MzNVcVBtQXNwcU1j?=
 =?utf-8?B?M2ZaVWJjbVExMkptNEt0Qk1uZndYOEhEY1dRQnJVd2xEeDNvckVVOXk5c0ZI?=
 =?utf-8?B?UHhRR1EyVVgrdkFqNXJnd21YZkxuWlFEMkQvOFlOdVFLM2ljZ3c3N0dRaHlt?=
 =?utf-8?B?NGJheVh4N3Z4Z2pJTGhrWVg1eHhpYWU2S2libDk0b3g3MXkxY1RxMDIxNGI4?=
 =?utf-8?B?UUlwUWRsbTBKbGFIWVN3eWlqaUFhZ0pGOXdtMWRZaGxESEVPRVZ3NGl5Rk5U?=
 =?utf-8?B?TndjRHNrSkJSbmhzcnYyc0prQm1VbmNPNlVLTG9XS2h5UFVqRVNBYnVGclVS?=
 =?utf-8?B?TzRGc1V0YUxuZzdOclZkSDNHZnhUbWg2NlhrN2NVK1MwbktMaGxiM1g4WThN?=
 =?utf-8?B?ZVA5NlBqenQ5N2hLWXh2TGY2UENsNFpzNitKcWt1dFlDVC9GR1U3ZEZPTklM?=
 =?utf-8?B?RjgyNTcwSGhudHg2cmFTU2hEU0dhOG5ZSUw5dFlVTFRKZG43VVIwOHRndndC?=
 =?utf-8?B?RGFGVkpabWlVV0ZNWExLYVI0djNiZVdKSXVwQmxjN3oxb2JsZEY2RUYwYzNs?=
 =?utf-8?B?allvekVFVGRpNjZSVFFaRXQ2WXoyQkU5OHVzaW5RWU9BQ080UGVXRGN5Z3FE?=
 =?utf-8?B?VGZIMGQxcUhraDgzenB5ZlZ3aFQ3NnJmeWtqclVRZ1dETTJiajcrWWhLYmx1?=
 =?utf-8?B?MmxXYWNzZ0gvU2hrSk9KY0t5TjZhNlFHYjFmZ3N0ejJuTHRIVGxSa21mWTB3?=
 =?utf-8?B?OSttM2NwZmd3MmFSaERGUkdNYzBkbGRDNElxbm04SHF4TGxEMHZNWGx6bUZS?=
 =?utf-8?B?N1MrZ05OL0h3R0s3dUYxdG5PSE1kZEFGVWZwNkFoVmFWQTNkOXRKd1F1L1g0?=
 =?utf-8?B?bVppK2U2NGhMaTlnRms2ZTRWaDRCRHVLT1Y2ajZ3RVFZY2puSlB6M3poUGRp?=
 =?utf-8?B?Z25CY2JNL053OVo1QXZaamp2OENVeUVqNWZrMi8rNDNoVWV4clIzYSt3cWp4?=
 =?utf-8?B?SE96eDVITEpoV2l2V3JLT1owN1VlaWptWFlIMlBub3d0S0kzRzZ4ZS9NWXFH?=
 =?utf-8?B?ZiszU1I1YXdlUEdiRmRGSVBCSDNsa2gwVUl4OGF0ZzgweVBqK0ExaSswOVJP?=
 =?utf-8?B?WnJvSjV2RHNJcWhOOTFndzBGb0hGTk9YTk54TEhRM3pkdUtlVEp5TjdDbjRJ?=
 =?utf-8?B?ZnMxcjZIR1BTWm9WOFBtRk5BWWFhRUNwazJSZG1IOVcvWlNyclYvN0V5elc4?=
 =?utf-8?Q?r6I/jtsNXkyzw987sCy9LjA2T?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: f7dhrWcnb2tvn0EK+15oTtqHWsBy9e5xJMS7hpoCU0KMIMMGd8rC3cQOxGeH8c1RSLIBcgY9Dyn6Nt3jPBs8/Rj0IKZ8kvHWEJB+sZzBrs9r7HeC/BBFuebC/s3q+tIOZDNTdsn/nNglKLNiCoyU4u2dLbVzzJkafwbMKb8L+/tVh4ML0RcXfMo6jp5zhcs51Bj5TLXhgU5fVR4/Ip4ql/5pejHxzsgbt8iSTckIbsC8faAKkf+cGZbQkpwlEff6VFpjarz80nB4zkK0joQZcCxA2r08g/WSd6BzhyiVtaJjkUIIMghXZZesugs1JLApYvfGZF2/GNnQVbDJohnR5yIz5q5JaWp2uc60o4g8cC6KSPXeHloG8jfM/kLb+J4dqpVu8xWysraqvKpXveYIJk9XmvqY6HQ46WIGnh2PTC+hbP1hT/gEsVA7ZibDVqk/H6xS/6PJCqS1TVFOqH7OFAMDlSu62AF+/ffOQJABJLdCn84q/qek66ikG2AT40KAEGqCqfwyRmCq173qI63mMd4yt918Gam9e/iPrcOGKU8NSu1lvif95X2gjlfNdlFMJ9/Jl8MglkZogud+pQ/q6CzOtoT4iTeIRK4TO4xzB74tF9IoQqFzZRsG2psIxIPygYVjSWVu+1jHz4EdtVWEy0wvUmm855CkUkwJfyTxpB7/W2HavxMzKMNU4/hqU3E9+yAVHm9UKv7qaO0qQS2KLlU7EOVKw4B0AD5GcXbLeNM/veeG4/49+hyW3Lp5mXxvK7BMz35cAYxTgqccRxcM4xy3+zV++pN3lxOo0sTzvaHwtHEWYQhUN3fDDc/ZzKcau4DdzyD0yDrMyQ684mbvNg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b98fff-3a3e-4df8-6428-08dba9b86235
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 00:22:39.1821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZES2rmvyabMYHbRaXbHyI1JARDND37GZA8N7DWKZ3jRyqjuRJtrWE2I3lYvz8yRTGL5ySaiRLkrDwyD6+1Xcjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6319
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_19,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308310000
X-Proofpoint-GUID: -NI3OTtWozlsdHx4PV4_-d1Mbr1Ur3Cj
X-Proofpoint-ORIG-GUID: -NI3OTtWozlsdHx4PV4_-d1Mbr1Ur3Cj
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> # dd if=/dev/zero of=blah bs=1G count=16
> 16+0 records in
> 16+0 records out
> 17179869184 bytes (17 GB, 16 GiB) copied, 14.2627 s, 1.2 GB/s
> 
> I verified the file is well compressed:
> 
> # compsize blah
> Processed 1 file, 131073 regular extents (131073 refs), 0 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL        3%      512M          16G          16G
> zstd         3%      512M          16G          16G
> 
> I'm surprised that such a file needed 128Kextents and required 512MB of
> disk space (the filesystem is mounted with compress=zstd:3) but it is what
> it is. On to reading the file:
> 
> # dd if=blah of=/dev/null bs=512k
> 32768+0 records in
> 32768+0 records out
> 17179869184 bytes (17 GB, 16 GiB) copied, 7.40493 s, 2.3 GB/s
> ### iostat showed 30MB/s to 100MB/s device read speed
> 
> # dd if=blah of=/dev/null bs=32k
> 524288+0 records in
> 524288+0 records out
> 17179869184 bytes (17 GB, 16 GiB) copied, 8.34762 s, 2.1 GB/s
> ### iostat showed 30MB/s to 90MB/s device read speed
> 
> # dd if=blah of=/dev/null bs=8k
> 2097152+0 records in
> 2097152+0 records out
> 17179869184 bytes (17 GB, 16 GiB) copied, 18.7143 s, 918 MB/s
> ### iostat showed very variable 8MB/s to 60MB/s device read speed
> ### average maybe around 40MB/s
> 
> 
> Also worth noting is the IO request size that iostat is reporting. For
> bs=8k it reports a request size of about 4 (KB?), while it's order of
> magnitudes higher for all the other measurements in this email.
> 

The sector size is 4k, and the compression block size is 128k. There 
will be a lot more read IO, which may not be mergeable for reads with 
lower block sizes.

> 
> ==== Same test with uncompressable file
> 
> I performed the same experiments with a urandom-filled file. I assume here
> that btrfs is detecting the file can't be compressed, so it's treating it
> differently. This is what the measurements are showing here, that the
> device speed limits are reached in all cases
> (this host has an HDD with limit 200MB/s).
> 
> # dd if=/dev/urandom of=blah-random bs=1G count=16
> 16+0 records in
> 16+0 records out
> 17179869184 bytes (17 GB, 16 GiB) copied, 84.0045 s, 205 MB/s
> 
> # compsize blah-random
> Processed 1 file, 133 regular extents (133 refs), 0 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL      100%       15G          15G          15G
> none       100%       15G          15G          15G
> 
> # dd if=blah-random of=/dev/null bs=512k
> 32768+0 records in
> 32768+0 records out
> 17179869184 bytes (17 GB, 16 GiB) copied, 87.82 s, 196 MB/s
> ### iostat showed 180-205MB/s device read speed
> 
> # dd if=blah-random of=/dev/null bs=32k
> 524288+0 records in
> 524288+0 records out
> 17179869184 bytes (17 GB, 16 GiB) copied, 88.3785 s, 194 MB/s
> ### iostat showed 180-205MB/s device read speed
> 
> # dd if=blah-random of=/dev/null bs=8k
> 2097152+0 records in
> 2097152+0 records out
> 17179869184 bytes (17 GB, 16 GiB) copied, 88.7887 s, 193 MB/s
> ### iostat showed 180-205MB/s device read speed


The heuristic will disable compression on the file if the data is 
incompressible, such as that from /dev/urandom.

Generally, to test compression in fstests, we use the 'dd' command as below.

od /dev/urandom | dd iflag=fullblock of=.. bs=.. count=..

Thanks, Anand


