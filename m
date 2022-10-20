Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED91060570E
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 07:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiJTF4n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 01:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiJTF4e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 01:56:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32292196EC3
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 22:56:26 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29K5oZpY007660;
        Thu, 20 Oct 2022 05:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=UlUpwIwdl6Ja+8sW8v1ZhL0uLT57n1s/8I1ErA2zxU4=;
 b=iWpdG873XCc/MqEwPkj7F/RAsO1oxIKswSRaLOvOaa6GlAiuWxFtrp2JJvDmstBPRgwl
 qmuBaYxEUSBSKWlTPxPq7ZzOykL2jufbfs7tKfOM0Nnex/G2tGW6UFG28sT2PwlgqjiO
 DMcBYMH70ePCwxaQWc+FTUllHpMHm2VookuzTsnnSQi6xyAIIVNyZYkjf59raOh+trU9
 6ZfirdwgPbkENaBpsfAK/gtDdCJyxY660CqcGfGoyGJsHuAxaQz1damh8OHebx8Ss0fv
 9wpG0BDbdtps5OZfc7xXCAlnShWal3yxnUYq9gCrl4UTOL4QGca5anknt3ZDdqb8QUA5 7Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mu04833-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 05:56:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29K48uI4002745;
        Thu, 20 Oct 2022 05:56:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8htj8bph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 05:56:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQFbPFiHJs32crajaSlvNTWmC0OB858MKr6BrYWAtyIPZVYUwmvaDYmExve7nSr3kMLvkUiDJrznKYUXqc+tTNmzrOazy8VDVqqLmBdjmpjVG6zWYzH7FHotwIvKt+W/x90Dhe4dftzeptQeqzjauie58BUw/D3KihZgwJRqcdK2rBB/5LZ0a0Ha08RRBzmXc+W/9XA0MVs/9Uz2nuWFZdecyDYMw8QzSoUDkZu9awv4sE6L1aF+k1vYSETnmsGBrAHZ6Wq1/lgVvhU4ix8pFO0OnGXIH+yai0E6/CLz0OX+MFw4gx1RvqwrrvaRAvT03skyeoJ55+BJ9q2dvClq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlUpwIwdl6Ja+8sW8v1ZhL0uLT57n1s/8I1ErA2zxU4=;
 b=IJT/ur3S6LfAUpK7QMQnh7KjlQeCAh8pNNpwu36Mr/z6b0epAPJ0YczbotV6Gxxs2Wc4KAerUoQCfnNxi4VofI1LW3Y9GPrSx6gS1nVLTz8HoK2B/70sLHDsTXM6FIS7/zHwEuXGop4VLDW/QLuJfTuMFmkVCM06/CjOG8dTiRT4RbrD9G9rH2FcAm8lpDPRFGfJ7tgUJ3QWUEdeuGkgZHGNdMY0POap1QSRb0uVJVxpuTdGxfwjzEApzUR0x213b/Mse3ppVmWmnN0KdW+3/5YZ8EMOp2ZttD7CzoEDuaYMx8WoHp8UJOzmUcolM91KYv96yX/tq/HXXX0k0u8aew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlUpwIwdl6Ja+8sW8v1ZhL0uLT57n1s/8I1ErA2zxU4=;
 b=k0BIrLk8LwdmDPsho3XmW2W2nh2lt/ov4YrWeRYbDmfvtXti++EwjK7v4dk6rrtyO9GRJFciJG/XE8PfXFlCweMO9w6EM7YH8JwW0a16za7jYjU4dQWuGub7Ri05zOJG+DH0lcYzE6LF4EdaFUMvgdmhbRx/5YPSFas8fnpnI+0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB5823.namprd10.prod.outlook.com (2603:10b6:806:235::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 05:56:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a%6]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 05:56:20 +0000
Message-ID: <5507e5e4-e1cf-78d7-d756-59fc8e258a57@oracle.com>
Date:   Thu, 20 Oct 2022 13:56:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 1/4] btrfs: sink gfp_t parameter to
 btrfs_backref_iter_alloc
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1666103172.git.dsterba@suse.com>
 <c7040cb687cebc01e3155a330146fd55cc04f6f1.1666103172.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c7040cb687cebc01e3155a330146fd55cc04f6f1.1666103172.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:3:18::26) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: 849d024e-aa0c-4c31-ba44-08dab25fcfb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ia8G6/ZCheeoJkanAI00d1/nOn6eoyMsg8QSridTRUw0jYwGVYkQFT93/WuVUvudzN0BcvSg2Mdn2ELyGoGn+rjvsrjIS8VfPQWd6SqBqmeJKFEJ03OZUUO6jYttlthkO4/yoMOfLsDA7OscE6MDs8g2TkbSaXhEc5eDnzXmJUbkFU3EJPBiG6PD9TMxiq285X+gEZv/r39qAbLoOaX08bohzHPDVaOjEkD7LRbBZd+oHxPZ9hYik7bbE1emanaEt7COAA6hgd22RRr07eqiIY/2M9fD1U60cAu8X9dgnI0VmP/6jPMoRn/e20usTRM3uy9/qc1GCK8V8T4vhJj8ZEEy7UiaIOZczrxdjSEigg35hfDzM2ZMVywViRxzGh/CbFji70IMGUmfZ/lj56lXdvyknsklAWgJbOYCbvIuDzTFmbS5jdhDAah+iyqFGh5cA2lmwNfC+yyhP4pyxLn5/bvDBb0hxaqjJnKxAm+c7NYkP5tXyILZN4V8VRvfxqLQsNvlrnjcmXsoIyjHoTK+YCwbWMXO3m/C6Ga7EOri3GZq2p2EVK3j8LISjxjnTjCL4eF2FG5Apx8VKiZYVDkgfeZ+ukxALp7roZImLwdLoxBEy4NtId6x3RzUwa+6CQm+nrWtP/C6BBvy4LsF3Ab+EEW1+7AgBCZczrfu1Rre+MwnKqCegcna31lFc1iM6Xd2CEaCpXedyOy0LWStVmC66Z9F7SXllwfWIxLzHKqAgMiCtgDoU3o0FU/AcRsJUcRSS4v5i2SyZBweGjkwoHBvWYfUGzl8zeo/7MFA31HRuFQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199015)(83380400001)(44832011)(31696002)(86362001)(5660300002)(2616005)(2906002)(6512007)(26005)(6506007)(53546011)(36756003)(8936002)(186003)(6666004)(38100700002)(6486002)(66946007)(31686004)(316002)(41300700001)(478600001)(8676002)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGpQbmNobnh4bkJKZmNqK1Ivc3JpZnI1VHpZWndUSEVId1BmYUM1amhISWFP?=
 =?utf-8?B?b0ZlT3NLY0pJaHhMMWtKenh1QndlTjhScEgxSlBHQkt4ZU5NWS84WVEza2Fl?=
 =?utf-8?B?WnVaYWFNN1VvWlY3aUIvVWJGUjgyQlp5YnBaNDR2d1R2TGIxVlNzSVBZSjBM?=
 =?utf-8?B?WERGQkxrdTBGdFZKcDFCOVJuSkdrTHBqNlZrNFpjbFJ0TW5ML2lzQ2w5YjFa?=
 =?utf-8?B?a2tFRXBjSjhOS1NyYkF6R0NzYW9tN2hsZUJmWnVXTlJOWVdjazZ3RFZ5b082?=
 =?utf-8?B?M1o4ZkZrM1VJMnFSczhjWFY0bmVGSE9FZEU5eW9JQjZSSUxGaDFuMzNFczU0?=
 =?utf-8?B?OWtlRE5JZC9VcXVoVE1UcGUzQW9WV251SVUrZ2lXNERjQVFWdkN5SjR4Y1pk?=
 =?utf-8?B?L3Ruc1QvdTEvTkhlQ0x5R3NHbFhDeGJTRlZEUkxMNDgyWVNCcnlsbFppWUhv?=
 =?utf-8?B?TlZvc3VCSmVPMHVHcHc3WE5OZ2RxYklqdmFoVmF0YVNUSXo5emQrSWYyYjZq?=
 =?utf-8?B?eVVxYXJJVDFhMTF4emdkQ2RVeWprM09Xb1NCZTdraCtMcnlZekxqZGg0Qm1W?=
 =?utf-8?B?eWNteFE4cEN5alVxYTZJYTcwdkRxblF3alZHV0pGRnF4WW15amZOL25WNEhE?=
 =?utf-8?B?bnNuYlA0Q1BGcHRuSml4ZG0rY0NPZ0FIaTVIR2kyMG5rVWhqSGlZODN3YnpR?=
 =?utf-8?B?a2pQRW8zVnBwT0d5RG4xbEhtTDd1cjhIRSsya00yWVJIZ0g0TFk3aWpQT0hD?=
 =?utf-8?B?YlVCbnZ6c293eThPaGgrcGJpNlZBTTRaazlKZi9iQXJqU1ZUaWhXbWdlSm0x?=
 =?utf-8?B?SVhURHFEU00zU3djTWY0K1BJZ3hsSERhd3VUQzUzNktsekdnUk5HY3FsdHZj?=
 =?utf-8?B?OTF0Z3FUVGF4V09KRUdtQ1pjVUJ5Qk96WXFzOWNPUjlnT2E2NjdkMm1rVlpG?=
 =?utf-8?B?KytFOEVkTFlOeGxZMi9zUWVtQTBHcEVIVGlreGkySEQ4QjlZZmVkdEg2ZVlK?=
 =?utf-8?B?U1Q1RFB2d3VVZzRxcDF6a0VzNUU4dlBzMnhjK3N4SjdwenUvY0NxV1Z1Q3k0?=
 =?utf-8?B?bjh1Q1dCSHVmb3lqSTlqdVZRa3JkVXlLaEk0REl1RmdFb1VMTXdYdXlUaS9H?=
 =?utf-8?B?bW5NSDdja1FzRmEyZ3MxSUFLeEZwM0hBbUdHNjJKck9HYTNLaEJkSkRYZ2dl?=
 =?utf-8?B?QVFwV1FBdW1wZjB1bjNRZ1lLdk40N3h5WmlrQ0YvS0paOE5Cdkg0OEFHRGhH?=
 =?utf-8?B?VkZjN2x5cE5IVy9jR2pLWFVnZVhYR1Y0dXZ6TjQxNXhjNHl5SGp0VmlHbUVS?=
 =?utf-8?B?aTNRN29LZjVOSkFVUkl4MVpyKzh1K3U3NnRxM0czUlNMUkFFTGlabW5hMlRG?=
 =?utf-8?B?bmRVb2o0ZXNNRGZaaCsySm9RdSsrODZMVVQ0K1NNQkhZM2NhNitsa1pNRTgz?=
 =?utf-8?B?TVh0akZqc1FRSVFsQUpKdDBYNlpDSVkwVU1Bdnk5VGtSTklQMWpiYW9oYUFI?=
 =?utf-8?B?RmcxS0lsQUZKOHJPakFXUWFFaVpFOWNwbk9YOVVQanVwMkF4c2NidnFKRVBP?=
 =?utf-8?B?KzlSeWkwcXRTSGo4Z1pLY09Ub3hyUnpEZy9DbXZuTVo5d01nYk9SejdWWHRp?=
 =?utf-8?B?NDNHMzIrVHVxMUpJbHo2L1dob1hlYnQzYVpwRHpIZUhtd0JEbmhCKzlyMHNs?=
 =?utf-8?B?bFB1ZmxaOWpiTVhoeTBNa3BuRDhuQmVBZGVUN2tQVDkwWE1DK1dmZS9jbnRh?=
 =?utf-8?B?aVY3MUNvWjJHU0I2ZFFZdDJxaWdJd2IrVktqYXVFakI1ZVFYQmlBbFBrdm9k?=
 =?utf-8?B?K0dDZlZLQkR4QlZ0QkVhNkY3U2kzZkZ0TFJmd1VoL280cEhoZGtjclh0VWxi?=
 =?utf-8?B?cEhIcHlEMkdXMVFtK1RnUVZtN2Ntb3B2eWsyY0hjQUFnZUF3Rjk5ZG5rWFlF?=
 =?utf-8?B?MWxybXhEcGVuL0ZZTUtGUDVFTkhDSXBGYWMwWnZCR09FWnQ0L0d6azdva1BY?=
 =?utf-8?B?VmhPdHE3NkJYdlY5dmw2eDM2eWhkNmJhMVcyYVRIR3dOQzd4V2lUNWd4aG9J?=
 =?utf-8?B?YUV6azVsNWFvd3lkUGwvdHA4MFlXMkpaQStXMlFTZnRuQ21Lb2ovM3VobzNQ?=
 =?utf-8?Q?GegWgSr6zuoSOHhkDVf8GREWL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849d024e-aa0c-4c31-ba44-08dab25fcfb1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 05:56:20.7035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQsW7XKbzth6MVFd7HEKdB+L9zasOJxPHof2cQmYAowhV7MUpt0EgV+jb9XVrUf9r9xAX5bDJJXfN7QJqLmgGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5823
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_01,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200034
X-Proofpoint-ORIG-GUID: SH2hrBmCnD8bJjzy7SJyC0ieroWzQ_6W
X-Proofpoint-GUID: SH2hrBmCnD8bJjzy7SJyC0ieroWzQ_6W
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
> There's only one caller that passes GFP_NOFS, we can drop the parameter
> an use the flags directly.
> 

Compile fails with this patch, needs to update the relocate.c as well.

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 216a4485d914..f5564aa313f5 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -471,7 +471,7 @@ static noinline_for_stack struct btrfs_backref_node 
*build_backref_tree(
         int ret;
         int err = 0;

-       iter = btrfs_backref_iter_alloc(rc->extent_root->fs_info, GFP_NOFS);
+       iter = btrfs_backref_iter_alloc(rc->extent_root->fs_info);
         if (!iter)
                 return ERR_PTR(-ENOMEM);
         path = btrfs_alloc_path();

-Anand


> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/backref.c | 5 ++---
>   fs/btrfs/backref.h | 3 +--
>   2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index e6b69ac1a77c..a5e548f30242 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -2634,12 +2634,11 @@ void free_ipath(struct inode_fs_paths *ipath)
>   	kfree(ipath);
>   }
>   
> -struct btrfs_backref_iter *btrfs_backref_iter_alloc(
> -		struct btrfs_fs_info *fs_info, gfp_t gfp_flag)
> +struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_info *fs_info)
>   {
>   	struct btrfs_backref_iter *ret;
>   
> -	ret = kzalloc(sizeof(*ret), gfp_flag);
> +	ret = kzalloc(sizeof(*ret), GFP_NOFS);
>   	if (!ret)
>   		return NULL;
>   
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index 6dac462430b0..ea8b59a201e6 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -155,8 +155,7 @@ struct btrfs_backref_iter {
>   	u32 end_ptr;
>   };
>   
> -struct btrfs_backref_iter *btrfs_backref_iter_alloc(
> -		struct btrfs_fs_info *fs_info, gfp_t gfp_flag);
> +struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_info *fs_info);
>   
>   static inline void btrfs_backref_iter_free(struct btrfs_backref_iter *iter)
>   {

