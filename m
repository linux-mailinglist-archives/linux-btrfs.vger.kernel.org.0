Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE883DCE6C
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Aug 2021 02:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhHBAwQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Aug 2021 20:52:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44264 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230421AbhHBAwP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 1 Aug 2021 20:52:15 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1720penk004295;
        Mon, 2 Aug 2021 00:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Wa3rOMX0D+Y/dATxLdFnaWH8mItjZD0GNtkJba6TSuc=;
 b=FWHCQsn3aF23a3dS+PxIA63jCk7+4G5Ez3X/Vy6ZGkjXQlNtAOn+P8nuZRVLhGESZxPQ
 CP3mQuLKAdgP6w1JroHyfbJt6lgJ7Bxm9jpEybzwfOMXZZrWy20glylNp7zSUrsLr/9q
 NriIX/e7Wonjbg8mvsANGsE0tnhith7czx6qKVYbpGomSS9Ep4175+7aTEGUxspT20cJ
 SeqB5P4DErVYDZwPraKAxxVma+blnMGCuKg017WuWx418m6bBmvwY9NDFMrxBV2+OfyX
 eZicvpRbChA4N/vDbjXTgR5NfRhvRyeOcQPpKY1JsYh49xF9ErABOJYjRPUxBaKPKvkD /g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Wa3rOMX0D+Y/dATxLdFnaWH8mItjZD0GNtkJba6TSuc=;
 b=Sf1uhL7GA0c6iWCwfM4fnh7tngBocuCwKQXe/lTO3IWdx7gR9h7XajDMTee4PYIcZ+IO
 laisG/C3fTZrF5c0P8kWuOJ2rKKfj1S/V1+IKf0YOjCcho1NJhhawFdtwuvtKoCICyQa
 t3lTUIV5iUixuJ9X4Bkr3UuAX3ovwwWF7THDpWw5fwdb9MVXfoDbxKcBS0sunc6mtN7k
 GyJw4Y9K2w9EshZNtQgz2DS1ivb57u06+ZFstm9veEv5YGgpz7+ZnD6PmDeM3buX6sRs
 0amIR/bbw5QwrCDZMcPlmAkqflmzzWngLvFXvvnf9bpnMXo3ywk74XVLR6R/gO2h9uCr fg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a5wy1g9e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Aug 2021 00:51:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1720jlBf165450;
        Mon, 2 Aug 2021 00:51:57 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by aserp3020.oracle.com with ESMTP id 3a4xb40jst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Aug 2021 00:51:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKPWedxy/8pMHHIOgrX4ABX/OMdcryfZY9mEbYQnAuKkVXlPRYHardTgqyzUHYbr38AMGl5DPFDiKTT+rTc2rwFHDIZzchtK74U06wtj+knFfXjcVvaI+NrLgh7mn4FnT9md7/zfqDg681AxYcQYtFIp7cgeHOLFPqNqhQ9hB+9rk1aa+jISrs65KHifUy91TTidDz0k1uelqCGxvk7swPa+jv7XH3OWDKVf4ocwI7CIaluni2KFzzymj4kkuxOIPYAfteyGOghIlJ5yNSiDKR13tOW+lUldWYC++9vb+fW6zRyAHPjsUwT5GGbz+TQFvGVzQFCIMcoWRK+WUjS2hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa3rOMX0D+Y/dATxLdFnaWH8mItjZD0GNtkJba6TSuc=;
 b=jIoZML6Kz5lLFReX5fYGe686WUqS5MWBA65g2zWAQMn76J8ISyj8JOIZL8DH3K03N+qKkRcEdTSzpoizEPi+4tGHFTteK9mXcNGwEDHRtdNXjONji1HYV/TlHf91liyFD4SMn/Z8tZEpFN5SksNDop0hsJ/wC+LjLyCCYiodZVQJ+YKOHLpdErd0+qgEuFTZ+nUDe3rwJ38KkHb/YoaoaVRsHRZ+Kn+G1liR0wsdtF1U6RLiAGBTqdMDegyPgGrVY8DGkyt2aEd9ZI8Be+qoCYnx2U5BBcu+YpHU+ewvbXWVH3X09QNrvID4SzaqKOEW6M2IXijyQbgnRl+JVvmNQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa3rOMX0D+Y/dATxLdFnaWH8mItjZD0GNtkJba6TSuc=;
 b=mOz/FFuy6gjthBeEgg1jx0zR15oumB3yVjyMq5MXOIBa/3TXEOtQ4gWCUTEyJRJlX0rm5HygF1wh5zQuB5jM+f23cZmkFqx1xiT2tU4r46+AFqpruHudpGRPZk56LuxQZ3LfZacaFR6Nb/YdNeL2A2azQeVRcU941kGbrgNGz/w=
Authentication-Results: colorremedies.com; dkim=none (message not signed)
 header.d=none;colorremedies.com; dmarc=none action=none
 header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3855.namprd10.prod.outlook.com (2603:10b6:208:1b6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Mon, 2 Aug
 2021 00:51:55 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 00:51:55 +0000
Subject: Re: [PATCH] btrfs-progs: mkfs: set super_cache_generation to 0 if
 we're using free space tree
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Murphy <lists@colorremedies.com>
References: <20210731074240.206263-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <2007a29f-a3fc-4e0f-d216-cc91863ee0da@oracle.com>
Date:   Mon, 2 Aug 2021 08:51:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210731074240.206263-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0194.apcprd04.prod.outlook.com
 (2603:1096:4:14::32) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR04CA0194.apcprd04.prod.outlook.com (2603:1096:4:14::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend Transport; Mon, 2 Aug 2021 00:51:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f42a7bd4-5569-4de4-0002-08d9554fb967
X-MS-TrafficTypeDiagnostic: MN2PR10MB3855:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3855BA39C4E4378BBFD2BD0EE5EF9@MN2PR10MB3855.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AviZ01kpNI4zhk5XEZZTdiFUB5EMQfDx8HeEg5S7H/taH/MPHSWUqrKiwidwt+ZA0F+6lGmhcv3LhiX4qE6MiBITyAQMZc1EtPPSjZ76P01r2mi93gGGxfRpsN3XFLipUTTYIzOSsicAv0V2rS0JZV3aKVi6ok17ve8AuF2DcHusW38thwqTFh9slHDOb57xlv29HiEvLD+p68FHz0l4ST/2IlNq0B98pnvANCOk7+1w/GJ2vjonDQ4f2vh/Hirbpxblkmqnl1vlYute9hs7hhs+BiebTYJnjGOVSX+de1ky7aWLEFHm/yJfba/ZsHg8ASGsiJ7LjhBmSfC0wY5MtN56e5ploisAJjSNwz7y9ahgpAIFUAwNoEeYISqY+y0DcZOPvzOh/G00tBGklJkp8Mq7dKxXeCF4TFuiOs7dxKdmlKxyR6H4minSyFUxeX/uWEcVBfXbB+qAstGSTr6NcW3l4ox94kRdxA0sQrleoUehwCQ/C5cmPzEcrHHXOc/Peu7h9kKn2EIgXM+g8WCib0viLTiIn3Z9jdQVvpSWxg10lLdk15q7Gek9Ros2nJk0QYbuxaY8RX8qfz5W+iWhaGYBHlgbJoAACdFItcmE5EcblO49IKgW04TVcGxyPKPPR5x/XTZ9N/NX4K6dQOM7YwWJ1qJ/VQmTJQW2G3HKD0SSnyZ4Ncwik1vVfNRw3BCVsnugLw4T+CO1PMYrmZzwXxdxWY+Y+B1ZSyR14UU1d05HSlVnRHfGm9ieJRLl3TgGIRNuxwlyOrc5JK9WicQ8P8FsCDrXPCIkRYPvEXHZF7BQortN25lTYh4ar4uScbwz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(136003)(39860400002)(6666004)(5660300002)(38100700002)(966005)(31686004)(2906002)(16576012)(53546011)(316002)(66946007)(66556008)(2616005)(36756003)(31696002)(956004)(66476007)(86362001)(8936002)(44832011)(26005)(478600001)(8676002)(4326008)(6486002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3VjYVg2RHBaSjJRcDhzL0tVY0N3SnhQZk9jMGNlM3YyZVRBSUppOEw4ek9y?=
 =?utf-8?B?ZUZwQUFEVG55VHhNUmRVMlArdHdQTUN3TTUrdzF3ZUdZcFp6L0hhVU9ObUZl?=
 =?utf-8?B?UE93Y0ZNcnZYK1dYemYrMkR6dGgyQVVYS3hVeG1RWEExaFNDTVRYUjBrYUtB?=
 =?utf-8?B?WjI5dTNxMjJXUEdTUTZlYzRiY0dBTC9BTnVFRXpuaEZZMkdmVEpDdzM5bTNP?=
 =?utf-8?B?V3JtRGJPN0dwR1RHV2JQdEs3N1k1ang5NUpxTW1PVmx1Z0h3c3dIY2JydmRq?=
 =?utf-8?B?bHVRQXBMeUxPTEwrTTRUdlhDL1NPK3JyalVqamozQ0hhcGVIYlM1WmE2TXRu?=
 =?utf-8?B?Y3JJWFpvdmFMcjFqOUhjaHl4MStXV29zYjg3WStlaFY1UWpFQmlRSisyZGN5?=
 =?utf-8?B?SE5PMGlsR1RpTEc4U3BSdGZSdkJvQVBTS2N6RjR0QnN1RUg0b21Rdy9ub0hN?=
 =?utf-8?B?VStNZ3RYRU5ZbklCd0EvMWUxTk1lVDJHRTBuQUFUL2ZEaUpKSVVqL2U4S1ZK?=
 =?utf-8?B?RDJkbE1aQkxuem4zOVVOSktwWms0dGZLMTBBMDR5RDVRUVV1bG83V2ZqdXFp?=
 =?utf-8?B?ZUROUjltMmVnNWJYV0czdkFsVGZWdEh0ZGpJN2dyS1p3bkRxakhnTEdKNHMz?=
 =?utf-8?B?YUlkUmcwdFFPZ045YVc0NkN0SVl2OFB2YWhBaHdWeVJRb2pUSnRDNzBVVFJw?=
 =?utf-8?B?UnJJSU1jSWk4LzhzRFRFdU82MHNHRVRaK0wxLzVHOUo1R1VMUkFhY2RmMkFK?=
 =?utf-8?B?T2dJS0tWanAzUGVRd0RwNUovaml5M2RSZW5TZVdRTWJrdG1rb0tJdTBOSFZn?=
 =?utf-8?B?NW9lRWF1ZS9lY0t0ZVd0L1hwcjVxVXdPVGhuMlZITyt2TmJJRUlsRitJTkdL?=
 =?utf-8?B?YlFjbXorUURmRk5qbWhDOFgwWUFDQzV4bXVpelFRVCs4amhqNnNIMTh2QkFP?=
 =?utf-8?B?Qm1JQjd1d2FGR0JvT1JrL2RQTkpCZWYwWHFaa2dKcHlGT09FS2pURnBXNlBo?=
 =?utf-8?B?cFB0QTNIQ3VHbnBkRW91V05vUmFvUEVBUC9mTFcvOFlvOFNKYjhqU1oxS1NP?=
 =?utf-8?B?YzFNTXdSOEhsWWcxTFQ2b0p2dm5kSzNUbDk2ZDNCVTRKcUVPL0xaQVF0M3hr?=
 =?utf-8?B?Z24wMlVlTTErZjVJZlZvUm5YOEpUREhXbHF3OVo4RmltREpyWXo3dk5FSVFy?=
 =?utf-8?B?Ykh3Umt6MG1uZ1B1VGZaYk9BemZBU0hGK21OcC9wVWwzZDlyQ1FlRENyUlVX?=
 =?utf-8?B?R0NURFY2ajZaSGhEUGJlSG5KcGJyK1Y3Q2JYN2dKNXlyZU53U1RCVzh3VUZy?=
 =?utf-8?B?Q1BhUHZ4eW10eHpaVWpXWkVMbFFaWjdHZnhZMzM5QkdjODVWd21ZM1ZvV1Rn?=
 =?utf-8?B?U0NpODlaQUtrT09TOFdMTzRXVkdseXpYYWNabVZDMitHSXFxdTcyV2ZLcjVa?=
 =?utf-8?B?QWVqb290R1VoY3FZaUhsM1FYYTZOSlRrN3o4VnI4NHFDOWRmbVg0bExiQ2p5?=
 =?utf-8?B?QzBTZDBQTnYzZmhRQXNmdldIMXlaUmtCMlJnSTBRRnJ0aDNzWjhtd3o0dWIy?=
 =?utf-8?B?TG9yT0RDRHpFbnA1V1F6U2YyZ3BFSGlDK3dXbStKdnY0bU95bEhXWjF5LzFY?=
 =?utf-8?B?Q1VVWGpXdTJYRHkyRFNOLzN3MjJtemNWTHpjdmoySlpheTFtNkJPVVFEQW91?=
 =?utf-8?B?MHMwK0psRm5rSVNsRTZQd1VBbEJoTDNIUGJDK3FBYlMrZDUvNmxZU2lPL1dV?=
 =?utf-8?Q?D0ESmxRNEbkuTo3KESzkT2+b4mOrZ7cuMWzSrPb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42a7bd4-5569-4de4-0002-08d9554fb967
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 00:51:55.3765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmrViTeeDMGs5Y7sTQOKbVL0o8V+LP6coJ6I6w5qtq8NoSkQByf62jKli3abcP7N5oMStLSgd+6x1Ghj2eNmrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3855
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10063 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108020002
X-Proofpoint-GUID: f5puweOnmPAOS_9LlM2OhmVwx3bBtUJt
X-Proofpoint-ORIG-GUID: f5puweOnmPAOS_9LlM2OhmVwx3bBtUJt
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 31/07/2021 15:42, Qu Wenruo wrote:
> [HICCUP]
> There is a bug report that mkfs.btrfs -R free-space-tree still makes
> kernel to try to cleanup the v1 space cache:
> 
>    # mkfs.btrfs -R free-space-tree -f /dev/test/scratch1
>    # mount /dev/test/scratch1 /mnt/btrfs
>    # dmesg | grep cleaning
>    BTRFS info (device dm-6): cleaning free space cache v1
> 
> [CAUSE]
> By default, mkfs.btrfs will set super cache generation to (u64)-1, which
> will inform kernel that the v1 space cache is invalid, needs to
> regenerate it.
> 
> But for free space cache tree, kernel will set super cache generation to
> 0, to indicate v1 space cache is not in use.
> 
> This means, even we enabled free space tree with all the RO compatible
> bits and new tree, as long as super cache generation is not 0, kernel
> still consider the fs has some invalid v1 space cache, and will try to
> remove them.
> 
> [FIX]
> This is not a big deal, but to make the "-R free-space-tree" to really
> work as kernel, we also need to set super cache generation to 0.
> 
> Reported-by: Chris Murphy <lists@colorremedies.com>
> Link: https://lore.kernel.org/linux-btrfs/CAJCQCtSvgzyOnxtrqQZZirSycEHp+g0eDH5c+Kw9mW=PgxuXmw@mail.gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   kernel-shared/free-space-tree.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
> index 2edc7fc716f5..7f589dfef950 100644
> --- a/kernel-shared/free-space-tree.c
> +++ b/kernel-shared/free-space-tree.c
> @@ -1447,6 +1447,7 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
>   
>   	btrfs_set_fs_compat_ro(fs_info, FREE_SPACE_TREE);
>   	btrfs_set_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID);
> +	btrfs_set_super_cache_generation(fs_info->super_copy, 0);
>   
>   	ret = btrfs_commit_transaction(trans, tree_root);
>   	if (ret)
> 

