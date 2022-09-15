Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4275B9428
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 08:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiIOGKh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 02:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiIOGKg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 02:10:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958F942AC0
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 23:10:30 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F1OGCI005212;
        Thu, 15 Sep 2022 06:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jtlDeyXh4rafA+mK+yzAzTKBlxtrr08qUFJEc0oH6js=;
 b=XXHq49JIeliG1/lAdiP7FkceIX+RQdt0MhJLFqE37Megnu06QQnc0a91stgAoc2ExMvl
 6rIaMwBXi7lZk2n8Qv8IjYd2ofwZMwBZnfGn46gwtiSikXc2xsLz5d5qN81e6T4eFH+L
 LVhrQjzOtMcLDqAlPyYD4r5H7c5XHl9HtrWjmvL3Sa6FHoSt0hni8adaUetlrAa/3Z9u
 nDf2tlV6ASIMnEdw+TV1EMUEBPXa3Z4VSjtkLJ+bduN9CjEF3kzDUTxcJd56JbC6/Rax
 JKFs2VSDmhabDPXR9u+Fpji2xsGcm+Sc4NdTFqkq7flLJ4nCBfHivsSALNoxyAVgZe5b zQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxycc7gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 06:10:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28F3KgG6035541;
        Thu, 15 Sep 2022 06:10:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjyej61sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 06:10:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQLfu6njEByXGnbjmvtF2IuG+377pAgdCY8Sfn5wwClJks1y8j0IVp1qeY703toGZkk/b2kY6/5/ghxm70CCSz8+DZPnl9H1G/gmfMAyJ9HLFT3NZ9XGSutT/DsIuxmfkAhHshhCbWRDnI9TWQVVtV8Uiro06JIlCrHk61bAMa4PPKv+0YGLvl3Z+R7iNSbiQo73NZl4RJlquK5+C4TST9u95bfJ1Yae/D7sNqj84NYEYxDeOD4/WCCDw4/Qp7i74L+7nAcRFzmoc3CXgPMPdAbH66Uvf8e1MkYsHYNLqQlwAZPje+oJeR3DYKXYY3GCGyXXIDtcGwFj2S/9321RyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtlDeyXh4rafA+mK+yzAzTKBlxtrr08qUFJEc0oH6js=;
 b=FQxRpu25SPob+GOQKWe30a+oHkw3J70tIx8HfKvvfxIoXJCJR80P6s4kD4/xHMtdQzZe9FwaKcBpaaHpRep6wUbp0bBLsY7nQYSr1M4BcYKCddLNf4C0VNT8OqNibsnlJ9LtypFaEGVv+F2JLjAi0Hrou4wYww58d7fbT0QX4ueJa/LWhkcKBgTs2IVv4CJEhhsZWBQnDpGGdFCKuskvm5eqlbv/0gPD1NBM+eE2H+MLGxYNwqMIfm8v/UQyU/175bD19wUs7pZYUXxlfa8ZjiTpH428Eqj2HJBU38/p3ABh0qc5l2KeO7Pf8ktsok2dIBdvmOaZrIFA6h+e0XwBGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtlDeyXh4rafA+mK+yzAzTKBlxtrr08qUFJEc0oH6js=;
 b=H8XprkLi+Sv8HOqrN2fFnsiXDxX4mu64nyhi5MQJtDo4EChoqimrX6ccLDOm3UTaQWHAqsKYPWF1hqBea4z2taTY83fklrTb1QQE6bY4haCVYv4ceUq6L7ahYxYt27TjR7bSBuSZtKqzOd0fCMwn/UvS8K08fCUxoi9WkA4BtwI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4720.namprd10.prod.outlook.com (2603:10b6:a03:2d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 06:10:25 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 06:10:25 +0000
Message-ID: <464fbf8f-93e4-920f-d59d-0e8f5b6d5173@oracle.com>
Date:   Thu, 15 Sep 2022 14:10:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 02/15] btrfs: move btrfs_full_stripe_locks_tree into
 block-group.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663196541.git.josef@toxicpanda.com>
 <6f4bd25183fd8844b5592259971ed4e060d9018c.1663196541.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <6f4bd25183fd8844b5592259971ed4e060d9018c.1663196541.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::20)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4720:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5a1907-eafd-45cd-3e37-08da96e0fa67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n5VVocWRHtq3AOE75ycNj+nI/+bm3xKA+jFzSRhCrK2MUgIRQs+xfgG4LQKYuC6dFqCIIkai8u6a7ML6zIeK9K8yC7NSjpSuCUL85c8kCPTtKeKOhzsWPLkPA6UResLKYORVs52lCDj3fAcJ/q5KbCYjRjCiV4WSroFh0OBve7Is9rvv/ceJ7DAXKKVTaKwx7GS/rG26VIZTZ2sHM/TV/5kGHk9UjSdJbiqGOSFM9Tsc+Ri2WSNLVwiumfrF+1vWmWyzWy0Siqx2w5XsJwJSCxIsZGX6BVaqUmeKBDUWlEfjuntkS0eG1Yeen9TQSpATsBice+moBAVbso+jQkalpJbYQkHqZ3yEgnHhOmuUSAwamErP7RAWHe0K/8IN9/gRaVZgA/naYwjZFgOvR3ZbbOj6kHSdboy3h3gIJp7JkgIZ4blpFxfT/Y/d/SG09ISF+tgqcV0fWqr5nxmd0U09SXXTpZ/6hwk9LkaKuDVhuwHyTYpoK0mDp6N2Y5eFUJPcNyvvZB+BZWNZH8IjF9VlUQxqx8A6VjB14WyxldrYrzRn4SpYFqxOgiJsJXQKFWqm5ll+8PiQwuCAmQ7mHiiLhivErL5GMi2KouWBPMv5VXLgpTLMhMy5rNVi0yjeOtvH8i0FulXexVbQo7t2xtT5GTR8Xqeh0P4pCcZN9Mh2XsGTfiIlK5ejG5Y6iajKgCS/FVWxOv7jW6Kq3yT5vi/XhG1D5yZkVOsaSXhRxTrm0WsWQLUOZnrMCCHAQfLYZB5OVkfSl+cLHCsZsoJpumztXcRXy3bXhwuPmnZkNAddLyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199015)(83380400001)(186003)(41300700001)(8936002)(44832011)(2616005)(5660300002)(478600001)(6486002)(316002)(86362001)(31696002)(66556008)(66946007)(6666004)(8676002)(6512007)(66476007)(6506007)(53546011)(31686004)(38100700002)(2906002)(36756003)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTlHajFyZG9YVFdBMkRxWmFjSHZMMDhiWHM3T01QS293ckVOdWdvNlFqd2Rx?=
 =?utf-8?B?QlNEVXVRUUN1cHVpY1RjQUQ2WmFXb091eGtpeDlPS2hwM04yYm9hREFMcmpK?=
 =?utf-8?B?UkpsSjc3czQxWFpNVlhKeW10dUw3MXZvWGRSd0hIc3dmbmE0TzJQMEFKMDlp?=
 =?utf-8?B?NWx2WlV2RHV6YzdUc1RJQ2ZYS21GMENHcmo4TWlRcE9SaStCcDE1WlNvZ2FX?=
 =?utf-8?B?aDhBL0ZKOWlIRzVUVFo4QUxlZlB5bitSMkdtQVFHZUdhWStwdzQ1SUEraU53?=
 =?utf-8?B?V01kejRBaXZONWk4ZXBGOXN4M2hML2ZUZkhYU3pvdkExTFI3aXphU3RzTnk1?=
 =?utf-8?B?VkhTLzM0eDVNQUtMVE4xOEJicWNRMG40OVp2aWlhT3IzYkJxOTBZNXNQcjdV?=
 =?utf-8?B?aFI1bFpITGFCRnpHaE55UUc0YmV6MDZVTzVtMEsyZ0VNdXFiM2ZIU01hNHN3?=
 =?utf-8?B?dS9hQ0VVL1FYNGp1RlkxajNoM0l4eTRjajU0bno4RHJCQTZKWE5IaHBVZWRO?=
 =?utf-8?B?NmY0YzczNVlUTitIanJ4WHY3YlcwTFA3dzFZWndNeEw0MGZ2Q2pKb3pkVE13?=
 =?utf-8?B?YndHaWRsM013WHpzQTZ5ZW83eHdEMjNPc0xWY2ZKeUphWklxUHdLcGdUK214?=
 =?utf-8?B?M3NGZjZkeTlBdFZZL0FtM2RpZnNMc3BnczJKS2hKM0ZoeHhzcnV0cDBhYUFu?=
 =?utf-8?B?WmE3QnNIM2szU25xZzJUOUpid3p2TUFTTFNnWFZMYVIyVzR1SXh1UkZtZmFM?=
 =?utf-8?B?TkY0N1NCczlZSmYxUitldHJnYjVzbzZqVkU0b0dLTW9BeHNyLzcvcVg2dkwr?=
 =?utf-8?B?b2FReDZ0YU9idUhlaVFRMHBLZCtibnJWMmdZVytUcStRS09SbTQ3WG1QSVVk?=
 =?utf-8?B?WnRITk1WSU5KTng1N2NjQVMxU3VidzBMZVJha3RJU2d2bFFhbW8xdGlSUTlo?=
 =?utf-8?B?WG5Ha3A3ajJkVlBkQ2RWWElzZjd4TDBVQkZMbVMzVG5VNDltaWhmR2xxUFd2?=
 =?utf-8?B?QU14UDE2R1YvNVhzaldNVlNxRDVCRkNwSzNTbm5HeWl0VERvNUREclhSenI0?=
 =?utf-8?B?SUg5ZU5nSXdmUnIwVXJKcUJ6dVRiNm8ySDFjQlJLaitubnlCSjNsY3lyZGx2?=
 =?utf-8?B?MWZrNEkyVWtneGxRbXhDZkFaZGRJUnh0cVgzUUFsaWxhSlhzNXkySE5NbnBS?=
 =?utf-8?B?MStCWEFZRkYxYlV2OXNnMEszMTdMV2g2dkoyRUtwT1pHVDU4N3BhWmZaL0tU?=
 =?utf-8?B?U250cXBIb1JJZ3dxQVppWTFHaWNSMmdsVncrSmc1MG5pc1dHdWduV1NUVVcv?=
 =?utf-8?B?VlFPTWVHcndjY1Q2elh4VGlnOVkxZU0vQml6S08yVFJjSTZ3WklKSzNiT3VP?=
 =?utf-8?B?N2pOSm92ZDBqeFhQOVA2Y2JvaUhpd1I5WFRuYVJzSDVNMlR3dUtHSkd2VmYw?=
 =?utf-8?B?eVo4Sk1sSG9XZjViWmNnZVpFQ1JENlRyQVh5UFQwSGhVMTlSdzdaUzcyUU5G?=
 =?utf-8?B?M2ZSRTFJeDloclpWRWU4em9ib3ZwU0NFZnJNVFpJei9FQWlpK09UTmk0Undr?=
 =?utf-8?B?WC9KeFRuQkMrVnh5MmREUzEzYnRtaWV0V1FOMytRSTZEbDlTL2NBTWhaRzZ4?=
 =?utf-8?B?SVlGY0JIY2lPWWpjcUdFaFA0cnIzakc5S09PYWxXc0lRM3dpek9KOVBNMVdG?=
 =?utf-8?B?QnM5ZGpjNkNXZC9POTBlYkREUzE1UkROclVDQlNZbmx4aTVNRm9XYzJHWS94?=
 =?utf-8?B?bzZyb09RbUw1ajhvUm5VVGorNk02VktYT1VZRnlJV2xZQmVuNGphcHZnY1FX?=
 =?utf-8?B?L1YwOHdRQi8yelVCMGpxN0lTSnVtOEN0cGJ2bEwyMHZDN0wwQkljOVdjbzdR?=
 =?utf-8?B?WEhXMkw4RXdqWlEzUVJCMXVObERObkpBRytJeG9NNjVpcGxIeXdlR1lnM1Z0?=
 =?utf-8?B?MGdhZlFSOXFMazQ2MXdXZzVickwra0NCN0RGTnVaeWovNEtzR3NUdk5YT2NL?=
 =?utf-8?B?YmwzTVpGSHhQVG9MVjlQMzVRa0hLSFJROC9tOGJ2TnRHZXROQ2l6eHk4NGFs?=
 =?utf-8?B?QlRwcG1NR25sdWtjbDltTW1FbnJzWld4WVpwUFRvZm12RWc1WG1PZ290N1FG?=
 =?utf-8?Q?fluE82Mq/1W7OaUJmec+rL2+x?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5a1907-eafd-45cd-3e37-08da96e0fa67
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 06:10:24.7537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7K2fCuE5+sm1QovaZGZ7B2oLRh4Fb3wjcFOrtaClT2ZXjh39gSqOHjKGhHP9vko8VCz1DH8ed3CqoL5/7nn07A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_02,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150032
X-Proofpoint-ORIG-GUID: ECdYnNOmb2z47rWtA7_o2IT7Cb8N4JKv
X-Proofpoint-GUID: ECdYnNOmb2z47rWtA7_o2IT7Cb8N4JKv
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2022 07:04, Josef Bacik wrote:
> This is actually embedded in struct btrfs_block_group, so move this
> definition to block-group.h, and then open-code the init of the tree
> where we init the rest of the block group instead of using a helper.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

> ---
>   fs/btrfs/block-group.c |  3 ++-
>   fs/btrfs/block-group.h |  8 ++++++++
>   fs/btrfs/ctree.h       | 14 --------------
>   3 files changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 20da92ae5c6b..e21382a13fe4 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1940,7 +1940,8 @@ static struct btrfs_block_group *btrfs_create_block_group_cache(
>   	btrfs_init_free_space_ctl(cache, cache->free_space_ctl);
>   	atomic_set(&cache->frozen, 0);
>   	mutex_init(&cache->free_space_lock);
> -	btrfs_init_full_stripe_locks_tree(&cache->full_stripe_locks_root);
> +	cache->full_stripe_locks_root.root = RB_ROOT;
> +	mutex_init(&cache->full_stripe_locks_root.lock);
>   
>   	return cache;
>   }
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 558fa0a21fb4..6c970a486b68 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -76,6 +76,14 @@ struct btrfs_caching_control {
>   /* Once caching_thread() finds this much free space, it will wake up waiters. */
>   #define CACHING_CTL_WAKE_UP SZ_2M
>   
> +/*
> + * Tree to record all locked full stripes of a RAID5/6 block group
> + */
> +struct btrfs_full_stripe_locks_tree {
> +	struct rb_root root;
> +	struct mutex lock;
> +};
> +
>   struct btrfs_block_group {
>   	struct btrfs_fs_info *fs_info;
>   	struct inode *inode;
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 725c187d5c4b..12d626e78182 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -180,14 +180,6 @@ struct btrfs_free_cluster {
>   	struct list_head block_group_list;
>   };
>   
> -/*
> - * Tree to record all locked full stripes of a RAID5/6 block group
> - */
> -struct btrfs_full_stripe_locks_tree {
> -	struct rb_root root;
> -	struct mutex lock;
> -};
> -
>   /* Discard control. */
>   /*
>    * Async discard uses multiple lists to differentiate the discard filter
> @@ -1944,12 +1936,6 @@ int btrfs_scrub_cancel(struct btrfs_fs_info *info);
>   int btrfs_scrub_cancel_dev(struct btrfs_device *dev);
>   int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
>   			 struct btrfs_scrub_progress *progress);
> -static inline void btrfs_init_full_stripe_locks_tree(
> -			struct btrfs_full_stripe_locks_tree *locks_root)
> -{
> -	locks_root->root = RB_ROOT;
> -	mutex_init(&locks_root->lock);
> -}
>   
>   /* dev-replace.c */
>   void btrfs_bio_counter_inc_blocked(struct btrfs_fs_info *fs_info);

