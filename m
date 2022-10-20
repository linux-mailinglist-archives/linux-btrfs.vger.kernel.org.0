Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340C260571B
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 08:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJTGCP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 02:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJTGCN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 02:02:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5F2180253
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 23:02:12 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29K5owGN016799;
        Thu, 20 Oct 2022 06:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7XQPnpHJ5Q+7mW9aDW19Ktw7MhxnZCbWgbnx9LLVaCM=;
 b=AHrbckj4SnNyrhzwbJ32532NzOHeTFW+FnVBtGhSI8xz2O0oYM0jbvDzLcW68slOCXDI
 M+mIBzo3Yw1bBCgxwb9RzIAD5aGNRbQ6OZh91zuTIR77X3eKXt+VCSLt5V9zLeBqzqSM
 wrG2V3CA+3wR8oj1/WTao6b+pwZEXbws9/vdZczTaYdim+qysHtbAHGZqIowg9O/f0zi
 /GUthB9AABtxas9aB6OAG43oU53Tz0fCq7VU1T2E6RqLaTpW+Uw04vAfr558OK0KVOoH
 G75H2XhXjoWkht1kwKDHxdc1MYPDfymJPYE8Ejlrjc3AaX37nc8+cCBRIBlRQudz58R1 xw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtmn70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 06:02:09 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29K40vDq017134;
        Thu, 20 Oct 2022 06:02:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu8esw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 06:02:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGGtoMC3y3WdGb7HMnjGyMRSy73PhLjEyQa6PS3iObeHZFicxYYK6Te8jrYElg7vJlEJ6HzkapaX7Ga3fuj59t0NOfSCnw1lHhFPWS5IM6yzxVV5DVPjeXn4z37DFcCXZX0X/45peG5r5seskz2pjTo3Edg93zzBQXna8SwhWhOD0hYZcyY2s1sqZ4L/JsfdELEoOzsnxbEaRJi4fE1Nm/X3t1jm9nLIkjxbpwzT6ZUzHERC/NKktU5ol1QKwOO2bbz+d9Z7IgIPbnswE7YHpzGPRJslWuP3qF0IjxDwsoVh0E6IQRRxeVFknaeaYUGKqDsg/2raiddoDWdqfP7Ufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XQPnpHJ5Q+7mW9aDW19Ktw7MhxnZCbWgbnx9LLVaCM=;
 b=XxiDNuMvw5knFFKDWG6UvIinS86uxIaUqSasRpJ+JGoVGcnBbbCx4E9Y+NAzLE3nvh235fcuNBO08h41w2Ea04EZOwXahfgY2AOEpZNZMkiZl3n5Zu7C881SvJSzU9tds9qlRsRquMxvjkim/un3axIAWphrzJD1rFac403Fj+iKTWR22I1o0ABkOIDaz7ihWOb/4juxHLMobgNLtqy8R8xgGu7Q8mofCPvSvoceL0acxnfxcgnkaY3C1MHhXoSm+hgJjtZ6izcsia4ul8j5sLjOqo8+GWAVQ/sRF8G9gQ8hEfoRtuxExWE5wMJ95m5PD8sS/R8X7Y3Yrecdh4PZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XQPnpHJ5Q+7mW9aDW19Ktw7MhxnZCbWgbnx9LLVaCM=;
 b=oY71qnq9aQNCarYOGwh1RymYkbs9xjsRJK6/5PMNSuR+KDwI1BcB2unAG4BgK9AHEOSbo3WQ+MqKgcJ98MJDJk2bzL6GLgAiijwy8louANDeOOLZD3puztmXAxlOKhZPEdbtD20eXD+ySVvyk8RgYe7YrbFyl0jj0KIORaaRaeE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4473.namprd10.prod.outlook.com (2603:10b6:806:11f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 06:02:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a%6]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 06:02:07 +0000
Message-ID: <0c79b07b-88bc-0fb1-804d-724e046f6b44@oracle.com>
Date:   Thu, 20 Oct 2022 14:01:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 2/4] btrfs: sink gfp_t parameter to
 btrfs_qgroup_trace_extent
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1666103172.git.dsterba@suse.com>
 <851400b247c547bd420dafa4b7ae78345f4a7ae4.1666103172.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <851400b247c547bd420dafa4b7ae78345f4a7ae4.1666103172.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4473:EE_
X-MS-Office365-Filtering-Correlation-Id: 71da5aaf-ed6d-464e-f92d-08dab2609e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GZXz+h/QKKMUpNG2snSjPeyo/269FcWolI5BWpMxaaiKwUTrW+lAcKY6K7QlzOoQRvRCBGurerUOyGFNSRD3TH4YQGOwvkFDUHde+DLZvMmlr+J+RkHhRuCXtoqpgKTkQzITuSESKJpn5s/h6gaPJwFGwg5PavhOc2evtgnXJ8/KiTAa0OgG0Cohh8Ffias6FXw/YXCAbBMDOtoIaUCbnCuzUn6FnVC5kZNXzwzB6sr5UK7qdNrjAlzJ7EE95rT3L7SPXfLyLc8jT5y7sxYpsApXhws3kiO8CPBpEfauKm8kk0tGyBYP3brOnLqONGRajP0AuOBK9tcJaUUJ/30uXNglaU/FmdtBh8ib47g3DCU7fX+P264tqB191ojDpHcse++BZltNTZjQG5x7bXvQqSZFDy6b+2J8lFpgmQUXLAJEB3+8m4EjIgOJMkAMdAzjdfDeugBkxOxLiNvbfk8R+Lhj/G1lmBUdIqxf5oRhoh0isAU5w7W7yU6NCn05Z4ojcJGkButuaZQkzQ7s7ykgsS8+anf1kGMPcvjpY15OqpdVE7XqiKlQfByx2tonmTtFJSTqIntCPUqv5jeX9X6uvFxGH3n2LAUMV6gqLcKBwc8Bm/mxKRet8Nt6AjktNMuRU5B3bXyRCb/MDztbgz6mrn9cJkkvVLylR1KT7UXUe3IBZehvIjS69QWtQMCVPgsatxQ8bpAkglx6Eo7ORFA/WXzyqma1elE+kh3d//OSQ2GdIaALPXqr5k0oX05/g7VhldV/zVKRvyDjVcyFehBUWgZJjNfIUxfB1lricQiBadCvKd9T3NbPjmm2ZIrhHet3nMS4nAJXTio9j+o8oi5b+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199015)(478600001)(31686004)(83380400001)(86362001)(31696002)(6486002)(6512007)(36756003)(5660300002)(66476007)(66556008)(53546011)(6666004)(8676002)(6506007)(26005)(316002)(41300700001)(44832011)(8936002)(2616005)(186003)(2906002)(66946007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3RBdXVtZU15ZGkvRkRGYnVTQXlUQlFJS0g5dkdpa0hpbnk1OWFPUVJLZmFQ?=
 =?utf-8?B?YXhRMHpudVphMjV3czI3bW80ck02bkhFZWEzN1VzNHlrclpJWTMyeC85REtw?=
 =?utf-8?B?MEJUZXgyaHpIeVlXVXNuTTI3Z09kalFJN1RCNHdyMGlQczR4RzZiUGR5V1lS?=
 =?utf-8?B?dmZDcElFNHJXek5IQ2tjTlRUSS9qNUQ2c2VBbVo4ZkhVRzJ3WitzYmVLRnE5?=
 =?utf-8?B?cG9NRTU4MWtvUGg0akk5dnVYZkpJU2Z1T1picnpZd0lSdlZROENBRHpVL051?=
 =?utf-8?B?MFA4V3hmRTJrb3g3SS9pNStuR0s0REVOc2RJUFkwcncxenN6aTJYcG9WSEU1?=
 =?utf-8?B?UjI3aU5RWEk5aWc4MW9ZMzlJL0lFYTVsWk9nZ2tJaGtFNitTdXFhS2pWcGcz?=
 =?utf-8?B?OUFYakxjdGVQNXRhaEZRNDY2WW11eitHMFJIeGJGUnRnc2ZEelJHSE1BNGFk?=
 =?utf-8?B?c0RRci9qY1YyK1VzNmdSYmhIeUxwV3c2Wk1FY0ZFcVVISWRlN1gvNlgwMkpR?=
 =?utf-8?B?N0FKRjZyZE00b1RaSzYxZnBSVHpOVWJWR0lLYkFNNCtveksxOVJUQzA5dE1y?=
 =?utf-8?B?eVl5UFVYRDI1REN4Y3FiV2d4KzNYSEM0SVFrVVhVMFdmekg2TVJFWXVaZFly?=
 =?utf-8?B?QjdOUFp1bHpqTWEyV3Uwd3BmeloyMGQ5eGF2MEFYODdQOWFnRzlVNkFYT29M?=
 =?utf-8?B?QzM1b1M4N2U3aXJjMzZRZlhDN1l6eDdsN2M3L01UWkRhZlZDOE02di9wMXlN?=
 =?utf-8?B?YUxUVjFwWkpvUUhzK1FSQ3pBWmIwUDZvYkFTVDZSZjZjR0p5a01waS9oaGs2?=
 =?utf-8?B?TWIrK1VRb0JCc1BSd0d1Y0kvcitRVllXZTJQRHJ0TEFvbXJHaVc5a045QTJz?=
 =?utf-8?B?UFMvb3gwcFAvMkFqdEU3eTdDQzVOZWNkenUvYnFLSlFGdnVtaWZURzRyMzUx?=
 =?utf-8?B?M3lhSUZNb3hsSUgvenhZYlFjdEpKWmo0R25iTlZpWkZreXdFdEpYT1VSTktO?=
 =?utf-8?B?aHhXM212aGdwNURUNStoZ0I3aWt3SUk1aFowTGFwSVNHWXY2alpsNkU2RGtr?=
 =?utf-8?B?T2hZaHc0ZE0zdE5VQ0UrT2x1bm5LN3FJTkIvSkJNTzBHVjlWVEdEKzdsUmtN?=
 =?utf-8?B?NWhMdWkxNFY0VmdTaGgzcEo1YUpPZW1hWFFVT3FSSXk4MmlQK3M5YjYvdWg3?=
 =?utf-8?B?TEx2M1VuUVRQM1JFZXZjMnNSQjFBQnNMck1KTXBiZUw4eWs4TFZsTTJOK0VZ?=
 =?utf-8?B?SzZhZyt0MEcyd1U5NFdvY25zU3AvVURhWnlBdzVvbFUzSFdHM0IwaWVHUW9W?=
 =?utf-8?B?V3ZYRzVrYzd5UW8yckF5WnhlcGRiNHZkcm11NDB1OWl1OHdUMUppUSt4ZHpH?=
 =?utf-8?B?c05XT2dHdE92MjQvUW9Wc2hPaERXajdtc21zeVlDM2pYaW9KbFYvTk1hZmpp?=
 =?utf-8?B?bWRoOWZEdVpWVGJQU2xkc3ByK2VnQkJZRk45VlhLNnlIUlg3NUlGdjdvRjRK?=
 =?utf-8?B?TXdzcEE3ZENhVmRsNmsvOWoybHU1TCtybFVOVEJvUitkSjd4cEJCVVliUVJF?=
 =?utf-8?B?bUtWTUx3VEs2ZjVXUmxvVGQ2RHZ5ajI5MDN3V0dTRGxTVkhCbnFVcmU1QnRK?=
 =?utf-8?B?TGpYZUdLNVpyVEpaeGw4emJrOVJwZzNEbWVmempaYTdvZ3VsM052d29PaGxt?=
 =?utf-8?B?TFhWakxRcHRoM2JCMDRmbVFYcTc3TmxKV014bk1TT0k3V1RpUTFCdkJWS25r?=
 =?utf-8?B?NEIwOUk2Q3hHSzJxUU1TZURhbnViL1pNU2dZYVpTRDllTHNnQU9aNHNIK3lD?=
 =?utf-8?B?dmJ3T09FMi95aStLRWIxTE8rODRPamh0RVBXSzh5UGhIejNVZitrQ3JVL3RI?=
 =?utf-8?B?em8zc2RsdWFaUkdBWVpweDVKS1M5aE1oN09YY1o3R3dOSkxJeU9ycURzV3Nk?=
 =?utf-8?B?Uk4xQnNpSFdJUXBCUXpSNjdIQUk2SkxobkNpTUF5ZktDR253M2VhV3krK0VK?=
 =?utf-8?B?MmRzcVd5Y2ZJNVVOUDBMM2hhb0NvWGE0dzYvWU4yVktRQzE5b2o2Um5tNkdt?=
 =?utf-8?B?RXFhVGZRWEhvS0E0MHdhcU1kTUNKWmJQOEdDVFZMdGtURkdicU1rQnhCTGVS?=
 =?utf-8?Q?DssaU5JtSeI09jalCq/dON2Ot?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71da5aaf-ed6d-464e-f92d-08dab2609e2b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 06:02:07.0226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMzamlYB0WQ7/oWJNR6eoR37O9uOGZdM34P30GIZ7K6AxsrguAiT6VccnhpdDYG473wITs5virAN7ajNtPojCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4473
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_01,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200034
X-Proofpoint-ORIG-GUID: F2xa6Tw1jb2vllQw2uuj0U3YXri-DSrA
X-Proofpoint-GUID: F2xa6Tw1jb2vllQw2uuj0U3YXri-DSrA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/10/2022 22:27, David Sterba wrote:
> All callers pass GFP_NOFS, we can drop the parameter and use it
> directly.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/qgroup.c     | 17 +++++++----------
>   fs/btrfs/qgroup.h     |  2 +-
>   fs/btrfs/relocation.c |  2 +-
>   fs/btrfs/tree-log.c   |  3 +--
>   4 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 9334c3157c22..34f0e4dabe25 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1840,7 +1840,7 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
>   }
>   
>   int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
> -			      u64 num_bytes, gfp_t gfp_flag)
> +			      u64 num_bytes)
>   {
>   	struct btrfs_fs_info *fs_info = trans->fs_info;
>   	struct btrfs_qgroup_extent_record *record;
> @@ -1850,7 +1850,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
>   	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)
>   	    || bytenr == 0 || num_bytes == 0)
>   		return 0;
> -	record = kzalloc(sizeof(*record), gfp_flag);
> +	record = kzalloc(sizeof(*record), GFP_NOFS);
>   	if (!record)
>   		return -ENOMEM;
>   
> @@ -1902,8 +1902,7 @@ int btrfs_qgroup_trace_leaf_items(struct btrfs_trans_handle *trans,
>   
>   		num_bytes = btrfs_file_extent_disk_num_bytes(eb, fi);
>   
> -		ret = btrfs_qgroup_trace_extent(trans, bytenr, num_bytes,
> -						GFP_NOFS);
> +		ret = btrfs_qgroup_trace_extent(trans, bytenr, num_bytes);
>   		if (ret)
>   			return ret;
>   	}
> @@ -2102,12 +2101,11 @@ static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
>   	 * blocks for qgroup accounting.
>   	 */
>   	ret = btrfs_qgroup_trace_extent(trans, src_path->nodes[dst_level]->start,
> -			nodesize, GFP_NOFS);
> +					nodesize);
>   	if (ret < 0)
>   		goto out;
> -	ret = btrfs_qgroup_trace_extent(trans,
> -			dst_path->nodes[dst_level]->start,
> -			nodesize, GFP_NOFS);
> +	ret = btrfs_qgroup_trace_extent(trans, dst_path->nodes[dst_level]->start,
> +					nodesize);
>   	if (ret < 0)
>   		goto out;
>   
> @@ -2391,8 +2389,7 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
>   			path->locks[level] = BTRFS_READ_LOCK;
>   
>   			ret = btrfs_qgroup_trace_extent(trans, child_bytenr,
> -							fs_info->nodesize,
> -							GFP_NOFS);
> +							fs_info->nodesize);
>   			if (ret)
>   				goto out;
>   		}
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index 3fb5459c9309..7bffa10589d6 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -321,7 +321,7 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
>    * (NULL trans)
>    */
>   int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
> -			      u64 num_bytes, gfp_t gfp_flag);
> +			      u64 num_bytes);
>   
>   /*
>    * Inform qgroup to trace all leaf items of data



> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 216a4485d914..f5564aa313f5 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -471,7 +471,7 @@ static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
>   	int ret;
>   	int err = 0;
>   
> -	iter = btrfs_backref_iter_alloc(rc->extent_root->fs_info, GFP_NOFS);
> +	iter = btrfs_backref_iter_alloc(rc->extent_root->fs_info);
>   	if (!iter)
>   		return ERR_PTR(-ENOMEM);
>   	path = btrfs_alloc_path();


  This change should be part of the patch 1/4.
  Except that, rest looks good.


-Anand

> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 813986e38258..3b44b325aba6 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -747,8 +747,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
>   		 */
>   		ret = btrfs_qgroup_trace_extent(trans,
>   				btrfs_file_extent_disk_bytenr(eb, item),
> -				btrfs_file_extent_disk_num_bytes(eb, item),
> -				GFP_NOFS);
> +				btrfs_file_extent_disk_num_bytes(eb, item));
>   		if (ret < 0)
>   			goto out;
>   

