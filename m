Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7229C606E0D
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 04:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJUCxp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 22:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJUCxo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 22:53:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854AE1863FD
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 19:53:41 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L0ECKF012296;
        Fri, 21 Oct 2022 02:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=kbw3uD5dMlw5vj8d5kLfUjxZg6GOmPELAipYxBQKweg=;
 b=dVPnzGITHA/UppAZ+Lwsl2nbhaRUgClGUoCrUyoqTAenBrYr6rpz7ND+1TgRz448onkR
 OJZ2P/aKrXZL6NczQWRSvhqirX250i1KeQOvPcD3vTy64aRgbuIs4vhsdQ08pOh1zovH
 Wv5fU1KylvRhH0+X0plIW8KSCihDDiMRUEq7nec0tSJnx59tyqylQO1xUtAi2xQlcElg
 IA9F/+YdvQiMYULqFO894hSWt8Z8oYvZg44++XhJiF31hZFK2Q1b6mYgb4AMQQWmkmgq
 RLXqUeRSbWjiLDV39q7sZ8pFeNx1DkKP3LHjbbS1LT7EdpQ8bRETRWIzVSFeuenp99yl Aw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9awwaem0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 02:53:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29L09cYE016955;
        Fri, 21 Oct 2022 02:42:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8huae3k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 02:42:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0FOwldmGG0L9NP0JMfMxsI5EDO/o2nhSPCYIuqebqms7++eojOSQChK7CnYvCJwUTmFxhIMsHbDTufYcsuWFWqLHVnqfESG2n5eJJno62SSL4TFx8uIRpaDSp7/b4arzQ1aa25SFYVwQf4/0oD1MLvRMX8e6KRTjSa7k7Iifjm9C2WG2p1LSp2fXxDvhQzUhQZc/8LuSPW1JiYG8eEkOuJfXYMW0R6QwCMOjobNhvH9M5aG2/QGidfOEV/H+ilnQawKDIRxDL6P+MzRHLJpeby9vTMjk3YPgEygL3P6fXxhwbSCUsBb7LZvu2aa+ShGLdb1y7WriArn52xAsLFfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbw3uD5dMlw5vj8d5kLfUjxZg6GOmPELAipYxBQKweg=;
 b=QKTQwmoSecbpwRrCP7ASxndrC7eGJDePZ+LJnRjCg3hrWhV6NInMeLXU2ZxBwtZ0e4rLU8L14Ug4AD8vmefhRffd1xKLgK59V+MfCuEr3Y3A6ZDLt+lMPbLTOH+wU7Ox5gdnIN7UjoFC8LBD6qwYc0epl9WITp1V8JIgcGHHvhuw+TOmLS24HAFtvoKIMQR2njZj4HnJKksAXUjbPCXotLr3Ju2ATm5PRzjSkP85IhrzB7WFSuN5nLXBx38ZGdyIpjzBZv3yQb3PNVMn58bZ2GOT3ekMcCdVs2ZETK52LQu6vTn/Y8/z6GbUL1DK48EPB8vYTHBMNTloAYTLeFo5uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbw3uD5dMlw5vj8d5kLfUjxZg6GOmPELAipYxBQKweg=;
 b=wrJ5xX1BcKIf0Y8hdmFYpZcZloy2X+ytv0D9+oLXqDlz8FKh8cN/lVpo6oQ6BDyqhllGy3fvWZ9YLUg6p78PS3uWnVXWhkej3RGJ2mBlIbPZ9d+xyn8kQ819x9s5Yg2QHX3EvQT4SyHhBewoTK30Maub7/kMBtpfjIqyP64LSG8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6237.namprd10.prod.outlook.com (2603:10b6:930:43::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 02:42:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a%6]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 02:42:20 +0000
Message-ID: <767b18dc-3ee2-1678-2780-ca78e99fd1d7@oracle.com>
Date:   Fri, 21 Oct 2022 10:42:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 0/4] Parameter cleanup
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1666285085.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1666285085.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: af4f837d-2729-4b7b-0b8b-08dab30de02c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v3tpLX50ktVDQi5pR/KfhBuQXeG7PVrerrEl3UjlzN+BeygtYi+zCUplJTRqjWcX5pmISwL7abX2ogDlNBq5tUu73nx0gpfCSXYbJY9d7fQWRtMF0DqqeF2uLem4LTDoBUkwqGLcTxE8eDm6Yu3JwwdspMuBzc8ww8UoixVjwPXUELhyXiAY8+2cIBOAjgFfJBsOB0V99J08inNx8eCqMdI/j3byPmFj7ZHS/xc/m4MmpIBHDVsxB4Gy1kJGbaBg/gmqW8qwAfwV3W83JX3nLjUJYTjwHRrTsYYvGAyUO7QMZG5l5XLygm3EE6AQZjY9D+5ShKlMZrAciXbXQ1HvrRUXdEpmYMzVkEjFBkFa32z0xUtuuhjGEJp5oMclxTnxZkajhK13d5xXAiBn9hhxmD8wBRLutzVOPGF/2hyqDDFguuPCO1VH0jnt5BmzOsCmXRYDPLCVSR5aGCtuPNpktRqYctrqqrLKv1wxWV9FSXAxjZJevi0XHBZ52GzAumBLyDMzFqU1vSTXA+ApUtQAIbFMTKofOGK2MOjJV/6HyqlpSRvAV8MQAeuN4XDnzolvannEx4/cAqGs2FDFJFQzQYVmAMYPazVZ+KYmix9Y8Q7GX0SzVBv3CwdqKW3SkTeuCgu8ixoeeZLoFFMtLmi6v/hajZ1XBVSWCmROk5Zc5ZB3G2gvlEB54qHU/pnYlnmdsMrsqhwqLeKqSH9iDwUZLbqjYzw49sMb8q2MhJ+mrVmtWmSvINosZVRei1t4FkY+xg8Td/yLFK+iszv7NEmQbqZFQzYDlQOToI8unPOGTm4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199015)(83380400001)(36756003)(66476007)(26005)(44832011)(38100700002)(86362001)(8676002)(66556008)(31696002)(2906002)(478600001)(41300700001)(316002)(5660300002)(8936002)(186003)(4744005)(53546011)(6486002)(6666004)(2616005)(6506007)(6512007)(31686004)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2NTa3lqWnFBemN6VFlveWRvL25uL3NsQ3RlVWtkMldwWFR6ankrWEl5bTQw?=
 =?utf-8?B?U1M5enB2MnJNWUdMLzYwVXlQcW8wWm52WU5iZ0lWbHcvR1IvZ1laNDBnTkhI?=
 =?utf-8?B?QjNyaUJETE9OeVBjZDFFVjhqbXhmejNXQnVYVWZpOVVzN1pEcTJWTmFuM3kz?=
 =?utf-8?B?RkpNZDZEVGxQYnQxeUg3Vml1T3NXc295aWgvcDVsamNDZEU4NGVhWlhlUlUr?=
 =?utf-8?B?U0VWMnVZVjlTeGx2c251RkRrVWczd2FyQUJXZGRUTXFTSXNNYk8rZkVHNFBq?=
 =?utf-8?B?bUVqYjdlV2c2a0wrL1V1NkFBOWNCZWc1eXFvMjRRdmNkREh1MklkMUZnTjBH?=
 =?utf-8?B?L0doQk5IaXhYRVdJdzZFOW56cjE1T0NBcW9NRW9aNkQrWWRhU0dwdUVRQVBk?=
 =?utf-8?B?MU1MeDBnMmtmTTRkZ3EzQ2MxSzJSOW84dGUzSE4yeThSWlYvM0hLMFBZMG13?=
 =?utf-8?B?eVRUc0t0ZGF6MW9LTEkvMVlveUR0ZUJOREUrcnB6NGxZR3Z6MXNiOUxWakdJ?=
 =?utf-8?B?VzFDaW51T2hMZysxNUNLWGFub01xSW9Qbkl6NGlGdGJ3YTcxTHljc2docEEw?=
 =?utf-8?B?VFFZQUxNQVdXQVYwVE1aeFQwTy93b0ozSTJFdGlWM3RPUlhHYXg2YTh0MzNV?=
 =?utf-8?B?ZG9yMFJ0VE16bGRpamhGQ2RRemZodWtNdG1WT01jOWF2R0RiNzNSd2pDZHFY?=
 =?utf-8?B?NUxYczRLd2szNUVXSzFJelhjbmRiS0EydzlPNWJRNHJwWS9DR0x3Tlp4MHJV?=
 =?utf-8?B?SVhvcHl0VW0yOW90UE4vd1ZuNXd1a3VQSmQxQ3czd1hUNncxVGdWeE5TbEo5?=
 =?utf-8?B?eE1KTkxYK0pOQUNaQ3ZMTExHOW1CMVFWVCtGLzdUc2FGY3hxRVZtbjhmWWxD?=
 =?utf-8?B?RGYxWGFaeEd4S0RPdzJJU3RJUndlaE9LVXRGQjJvRldQQzN2dzlrME1UNFll?=
 =?utf-8?B?MGdVM1MwcVEvWDlNNW9ZYVd3SnlRaEVVUmlTNGRYdUh3WDgyOWVTVVVHWHUx?=
 =?utf-8?B?cVhqTzd4TVRGZ0FFZkF4K3F6SjdCdWttVk4rNEdMc1h1VXhnZ3lMbTRrWDgv?=
 =?utf-8?B?TzFPV0dwM0ZqNEVGbnJLaTRxZDE2ZmJlSjhYN2VkM1BsT0FpYVpWMXhCZmlT?=
 =?utf-8?B?UUpNdTl2cHMybTUrSC9yOElrOHlQQnVzK0xDZGVjZGxSaXN6S2FzNlEzQWtD?=
 =?utf-8?B?ZUtjQldSWWlOU1MyVlg2MGR0cHlQQUJZcFB3SFZ2YTFPVHpHZnJNRXMyYUpt?=
 =?utf-8?B?elNaRXJvRFdldzBNY3QzMWRRWGdyTVIrNkphS2kvNzVkckRhVFJ1dHNBOHJD?=
 =?utf-8?B?ZllESkVwekVPcCtPUWVLaXc3WDI0WUdrck42OXFCN1gxQ2x5ZWM5Wlh2dWNn?=
 =?utf-8?B?M0J3SEN5TTNVOGlmZURUK0NFdmJzaks1Z0hpdEtMN1llTWhJbDNrOExZTC9m?=
 =?utf-8?B?TmxkL0xybHl3dk45UGJLSUpQZkhIL21mNU9wOFo4NkozY3Q5eGtHY05SSjkx?=
 =?utf-8?B?cUI4RUREa09qbStadDMvVFhJOWQ3MHlsdTd5TUVlcWsyeTV4MmdtQisxczVp?=
 =?utf-8?B?UXdHSHdhdnJ4KzZ2VUp6cURyR3NEZWFmWVlNVXpxZmozbkUrMkNXVVNxUHVD?=
 =?utf-8?B?b0RZcnRyZHNNazM3VVBCTmp4Wm8yVXJoSk1RcG51dlhUak5taXZUOVRYWXRo?=
 =?utf-8?B?N1ZuOW8vZzRmZDZNMUNDcjY0VXF1aEx6OG40VVdGelRiOWdnTDBLQ1pzRWtH?=
 =?utf-8?B?SERqd01kTGtJbCs3NFRqdVM3aStkTmkraklHcWZ3VzNGUmhtR2NSQzlRN2Qv?=
 =?utf-8?B?WkxUQzhWdktLRWdSWGJMR1BRYnJvbjdrK0EyTFFMT2IzZFllOUo4K2RCUXJt?=
 =?utf-8?B?dlpVWkFZR1VUTnlOL0JzeDcyRUN4OURYL1Mxd090ZXRxeUJtZWdYeW9FZmhQ?=
 =?utf-8?B?V2E0Z0pnK29kMkxVVENEY05uKzlNWm4xa0xJRGUyY2JOdjgrQTNlSHpxVGU5?=
 =?utf-8?B?UXY4R0Z4Q2RFL2UyZXR3cW9nNUdUOFh5bEUrT2ZxL2M0dFpDNDg1Z2xORjZl?=
 =?utf-8?B?SmxwdmNHWlBZT0oxOTMwaGVlUVM2TGlOVmdXbm1RMjhiN2h5VnllVFkzTk8x?=
 =?utf-8?Q?pymFBU9zsPM3rMGRPLc5ljxyB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4f837d-2729-4b7b-0b8b-08dab30de02c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 02:42:20.7437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMJMPrAXIZ+Jo/Zj8ehTHT9BfbGvCBOS2bLr4Gp+XEhn0XfmnOjcAkabTJS+EKD2cnvfw7wKjSRNqv6WmhnbVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6237
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_13,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210013
X-Proofpoint-GUID: lWCG9lxipeTWxydJ7EVtdhJqStrvaoRP
X-Proofpoint-ORIG-GUID: lWCG9lxipeTWxydJ7EVtdhJqStrvaoRP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/10/2022 00:59, David Sterba wrote:
> A few more cases where value passed by parameter can be used directly.
> 
> v2:
> - move related code from patch 2 to patch 1
> 
> David Sterba (4):
>    btrfs: sink gfp_t parameter to btrfs_backref_iter_alloc
>    btrfs: sink gfp_t parameter to btrfs_qgroup_trace_extent
>    btrfs: switch GFP_NOFS to GFP_KERNEL in scrub_setup_recheck_block
>    btrfs: sink gfp_t parameter to alloc_scrub_sector

For the series:
Reviewed-by: Anand Jain <anand.jain@oracle.com>

> 
>   fs/btrfs/backref.c    |  5 ++---
>   fs/btrfs/backref.h    |  3 +--
>   fs/btrfs/qgroup.c     | 17 +++++++----------
>   fs/btrfs/qgroup.h     |  2 +-
>   fs/btrfs/relocation.c |  2 +-
>   fs/btrfs/scrub.c      | 14 +++++++-------
>   fs/btrfs/tree-log.c   |  3 +--
>   7 files changed, 20 insertions(+), 26 deletions(-)
> 

