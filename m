Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1114537316
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 May 2022 02:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiE3Afq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 May 2022 20:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiE3Afo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 May 2022 20:35:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD1ADEC0;
        Sun, 29 May 2022 17:35:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24T8iwic026576;
        Mon, 30 May 2022 00:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RawqGVQb2ZsF0JSsRh9iO426s7dcCaE0ooqvNDLlwN4=;
 b=Xt4/rUrgDn4rbXQ9X9Hsf/PAT8Rt8+qLqGt4ie6GWXp5kYp/Oy7YLkEK5yC02mZHO7b7
 fb9+IHn2OK6Jl1ATFqEqMNhZpDdx3qmGINKkZ6MXVm82PaJwXUX9vsLpUr9/yQgYcqeM
 P0vmwQc15HAMkfsIgExVWPBxqvjZtCZTdKuiqIfs1uDy7Z7WbtRG17CVoaNPlJByR3hT
 fDuVglpS45oSVaRVpuqj50KsA/FyqVt14YVHDkSzPLVA7uSpLg7Y3qdWxG05xcVSGPWM
 Kg+tUFPaqzXmf75kiOX5kP/nlNS0ma+rOQzgZ+t5uGUyqXDp/Xf36gWJmU3rYv3ufQTp 8g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbgwm1gmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 00:35:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24U0QGqL034957;
        Mon, 30 May 2022 00:35:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8htrwag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 00:35:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaF/hPG+1Og0mkkQK2cW6QZdoRd0Z940Hhh5FKUj1hcLCJkgp992v+v8eWJEkzTJ9fLjrluR09TqKl58RQF+PnsuMpTIBLD/89epErs/Wd++J4XoPrKLZcA+7sJNQ7Edhv0a2ozonma2jwwMZA2pjDgD63LpZA30eP6NjrDOWFIb+Mak4SkqnGPxS60fMq+OVJYrhZiyq3gr5tvGfVa8KMv26puNDif6TReII7ZXsrHZH6BwUHhqnsH9NoNafECMrTmUE21vDABT2r0CAu8aIstuOSuAUnRT7KF0j5vuUch1d33IB6Vqx1J4mqJUwjqGaLA3iXG5Soww6TrfTrE+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RawqGVQb2ZsF0JSsRh9iO426s7dcCaE0ooqvNDLlwN4=;
 b=cL7ktqI2tcA/0mOUmDAxAFcn+FkGa6jCJMZLnRP5kqeizeY7KKhkxXPrnC5qSMtCoMqPFMjhlJIfgDGknAhlTufxfchGmtvldSSz1quj7in44+Dh+Xgblc2fPqTkMgAlfqZ7IJTySjxKTEE6bB4y+/VOrwKtGsBpLEDAW2sfoSV+yL+FyihEyhpReIu8uDv7RmUX2zeh/ln43XjUnaxFpl+nq6zXJD38cqwnmR05R5XlrTGIOaTFTBBKtzynyAHPNYNugvx3XpBdmZ9r0WPlfmn+NASpB/YOqSCh1yeJ5EOMelm45OL0yaPD6ou9kDRjAJtdit2x77yd2U+o9+BsMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RawqGVQb2ZsF0JSsRh9iO426s7dcCaE0ooqvNDLlwN4=;
 b=qKLaKTtH1PIj0OjCYu4g0nq24e88hIrTXMMGod3bf8X3FOYYsEr7Y1Fs1CVMQZzmNK6drDnuo4XNq3RZgiiBOCzWP6yihmX6oomsHtOWdQcN7WXrKxfKOZSJUtHDd1JXscH8S89dAxroWI7Xat/zMZkumxpWfIfYN9HPrGLZ80A=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN6PR1001MB2402.namprd10.prod.outlook.com (2603:10b6:405:31::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 00:35:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::5cd0:c06e:f0e0:784f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::5cd0:c06e:f0e0:784f%3]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 00:35:33 +0000
Message-ID: <c4a776ac-59d9-22a0-967e-ef6a41c64b34@oracle.com>
Date:   Mon, 30 May 2022 06:05:23 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 02/10] btrfs/140: use common read repair helpers
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <20220527081915.2024853-1-hch@lst.de>
 <20220527081915.2024853-3-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220527081915.2024853-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad69f2ec-3424-49ba-524f-08da41d44ea5
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2402:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB24023B7CF92A07740CD3F47AE5DD9@BN6PR1001MB2402.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QfnnOrWj5PNwD7uvm6WrZ+0PQMyPmm2SOm48X/o4spsBA+MgqY6AijQjDS7lVV5f2vZRgIF5jOrCVX97FHyVjyWKBlTKqmHR5v0TmR3CpqmAKnw9nG3lGc800MeuXISNVlNWKDwl9bzYixvqoReiEiDpbPWWquSXU6zgdqKf9F8WWu6cJcPoJGWil/PnmKbraZ/Rt2iRWp3efXMg8i9dxz+xfvYvCRBmFzqLskn7EkQ/93hZ3HmBXZDklr/hkq7uOqiK4ZviJaCl1jSFvyGKBwSrkVxf/Pv311cl8xgYpx1ssSCk6j7VoCiWyrzoVd5GsNHQoCrVKxIifBdY3U/1seCWh+GicOykieLks9lRbFDw6H66i3+1i2lImFOYWSlrapH93EY7a7FM2EG5iaf+b2FdE9l0Dm6fKEKSKh9Nw/MTqH5OaTFdlgS/vBk+Tst0inovwWxVgu814JRvq4gg9Bk8YaTXceuSOmLZmfW23pZBuaoryAiec2t1MUf6f/Z0WOX4ye7+C5nGEX6Qyuk76JrdvpgBCxDcZhHSM95wyMYIRMEbmAuvUtSR2YtwXsQJMS9OiyO67jwJ5ks1dksw7WNDp6xjtbpJWBK3EM30yNq7Nwh74pGPanAGKtwh1f8fXrZfrQQpdjSUC9/dI/JOEhiwYjtdnyNXkibnzAGCcbcOJahNQNolmZGkA5xLiv5ERjRyUBnz8H6JjkkbnGhACbZjyoZV8Ic5IfhIyiM8Newc2Cw/Wk8hEIx9+jwM7kEn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(31686004)(316002)(31696002)(66476007)(66556008)(83380400001)(38100700002)(8676002)(66946007)(4326008)(2616005)(6486002)(44832011)(53546011)(508600001)(186003)(86362001)(8936002)(5660300002)(6512007)(2906002)(6666004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bCtCSjVLZkpPZ2J5WVJ0QmQ5V09odnlqaVlDeVE1d1JwcTY1ZFBjKytYRDlC?=
 =?utf-8?B?ZTAwMHpCR1kxU1FNVmhIblhlcURLSUFBODJIR1VyVDUxbFBIMDVHUjlMSkhH?=
 =?utf-8?B?MzF3RFpKYnRTYXF6ZVNOSUtDeUNkZXNJZkJFTTRZTFBqeUFqakxhVmdEUFNj?=
 =?utf-8?B?cEFEaWVZRzlzMTFzekp4YXdTMzBhWm1qWEc2WmFkQi9YTDRnSkNHVVl1OGk3?=
 =?utf-8?B?RDFPRzNSOFhxZzZ5dTJmdmJQbHNNMkJKbFp0OUdsQ29FYzhBZjBIMnFxek9P?=
 =?utf-8?B?YkIvQ2FaRWVteGVHaUw1dW5TQ0liWFFLOUUvN0haMW54OENiL281a2VvOXNG?=
 =?utf-8?B?OE1ndXVqN2V4QTUvOHJqRFRVVEcwRFk1VklJRUZvN01DcW5aWHhwVU51RXNW?=
 =?utf-8?B?SEYvWkpmQXhTQnRYQllKdXl6bytjdFliZjY4c005RGs4MThYcDUxOUtHbVI2?=
 =?utf-8?B?T1MwYjBZNkJHYmRTMCtYNldWUWZEampkVUxScWJ3dVFGQWZiYWt2RzlqMUIw?=
 =?utf-8?B?YmVwUENiN1VLak1GN0dtMURzQXdHOUhMM3hZV3FtbGRYRjAvS01PdllXNkk5?=
 =?utf-8?B?OTl6bHF0OXFoc3RTU2dWMWRjT0JHQmRxcEJXcHl0Rms2VXRzcWVBdkducGNa?=
 =?utf-8?B?LzdDM0llNE9Fb05nSWViaVEyRkloaGR6OElEY3FqVHhUNlVzUUg1YTNDMkdy?=
 =?utf-8?B?WFM5V1o0MldjeitxNkMxNjhKY0pLSjlkNW9EUmQyaUx3N0VSOENNSmxsRm44?=
 =?utf-8?B?MG42QnAwb1JPckZORmhaWmVnYTR4YXhSQkhMWnF5aTJlclkyV29qdlljYlhp?=
 =?utf-8?B?ZjFYWGxZSElBdnBKN2RlbEtBQmdtdVpLNVhNZ2U2MEk3NlJkelNKQThpaEJt?=
 =?utf-8?B?SHJPckpScStxLzVETU8wZGEyRmxYdHF6NVdMQnJKZWhNOUU2Z1NMN084WjNW?=
 =?utf-8?B?SitmZkJMVjJSTTJUaFJuOGxzaFkyVDVRY3IwbXNwQlFjYVZHSmZ6TCtSNHFh?=
 =?utf-8?B?MG8vZkhSbGdBcmExN29vZU5QOGhNNzJ4Qm5jVk5DVGtnVDdJWGNkOVlWdUxt?=
 =?utf-8?B?bXljRlNRUEYrdEVKWVdMZ2ZTUlF2V0t6SUJBVnk3OVFIUVVjQnZkRzBKQWNW?=
 =?utf-8?B?YVZVT0l3Z3pnRFlpMVhlSzNYYnZQSlBiWExPU0VoUFN5ZEtSVExsWnloeGdB?=
 =?utf-8?B?YlhQYzZtMUZFSVVxK3hjRDhFaUZ5V3lYQXpUU1hQc21LWWhPTjNCcEprNThF?=
 =?utf-8?B?SDY5bmZWQm9pQnlBS2FRZi84WGZXZVZEU0l5T0FQTUIrVTlyOUdCSlFMZjh3?=
 =?utf-8?B?TGkvYmdmQ21namZWYlY4VzRYSkxCWm9XcWtsSWpyS244ek13cDMxYVBnTTdv?=
 =?utf-8?B?QVhYN0xmRms0bmpRc0Z0bDduSEVwVEhPM1NHQnJRMmJIWWZxdGNUeFBHVlVU?=
 =?utf-8?B?aFdvT1ZwOXFwdEs5ZGdtdU9LbmpTSjYvVGtHU3NCZS9xQ2tZTlp3eHBESTgz?=
 =?utf-8?B?WkNCbHpkOS9jSXBwQ2FVQ3J6ZU5GcThqNHFLdy8xM3NLRndYT1N0cytEV0lM?=
 =?utf-8?B?RmI3YlhRTHZIVmZRWW9xMnFaNmlEMHNXc2pFTGJiT0ZhTnliR1hoN09XNFlS?=
 =?utf-8?B?bmdub21PdkNNY1phb2pudC8rNUhWcko3Y3NOOFUvQmkvWmNjdWljdEJHRUc5?=
 =?utf-8?B?clEzRWV0ZDdTcDVyUHJoejg2Y2RzQ0dOSEdpRUQyZDU3YXNMWFB0WlpNcE9y?=
 =?utf-8?B?Vm1HQUd6TmwxZlVtbW9ZRGtDQThsaFY0d1RneGNjRGtQUTlxeGNOY05uWVVz?=
 =?utf-8?B?NWdxdnNpRGVTNjZraVAzbytBZ0Zuc1FGZXlqSjhnV0RoZGt4RERLT00rdjFz?=
 =?utf-8?B?NE1hcjVka2Irc0FKc05NR21GdFJ2VkZwbmZFQTJWRm5Nc04vdmxsZmt5RXk1?=
 =?utf-8?B?Njk4NVVuNXROR2d1bjVuMVpqRlBhZlZKSVNydndkZ1l0SWtNdEIrbkdHNVZ4?=
 =?utf-8?B?aXBGL2d2eU8xdHlNOGE4SkxhWTJmbHcwMmdjS0RGdkFyU0dtQThuMGxrMGJ4?=
 =?utf-8?B?Y3hZcTdtQlkzbEp1WGJ6cExyV3k3dHVDQ3MvT09BbU40b0ExV1NJNXViSWd6?=
 =?utf-8?B?RjU5WUtRalFwZ1Fmbm5YWWV2WmJGMTVud2cycWNFVC9vZ3FGVnhSM3RvRTJD?=
 =?utf-8?B?Y3YrenFjaStzeW5RSUh1dGdGZ1EwUzhLOE44THM0R08xRUdVRnErTGpnd2V3?=
 =?utf-8?B?cTdGSGxLbGdSVWttSDVUcjNja3RSTFJhekRraENJZU8zTkM1bnNLYUlEZVpR?=
 =?utf-8?B?bWYramVTTzdFcGt5dlJUUkdHMGxPeXBMSGV3b3Q3T1pNS2RmSk1kQTVhREdW?=
 =?utf-8?Q?VnhekbUqY+joUOL0ErKlaVRX67T+MGhkth/9XXAKLR2hv?=
X-MS-Exchange-AntiSpam-MessageData-1: ps3wm0x8HcNFLMFujYTVdvGMklAbhhr2T0Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad69f2ec-3424-49ba-524f-08da41d44ea5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 00:35:33.8594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bRycUSs5F2hKySd3hg0b9O6zGX60d26mspJJ6BxB6T6m6jWwa/fWVCR+qPrfV3E1M/whYuN4FKGJt2r7wv6Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2402
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-29_07:2022-05-27,2022-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205300001
X-Proofpoint-GUID: 4DktNm_ZooLBpvInL7cyIJHSyOJ3XIAn
X-Proofpoint-ORIG-GUID: 4DktNm_ZooLBpvInL7cyIJHSyOJ3XIAn
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/27/22 13:49, Christoph Hellwig wrote:
> Use the common helpers to find the btrfs logical address and to read from
> a specific mirror.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/btrfs/140 | 13 ++-----------
>   1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/btrfs/140 b/tests/btrfs/140
> index c680fe0a..fdff6eb2 100755
> --- a/tests/btrfs/140
> +++ b/tests/btrfs/140
> @@ -24,7 +24,6 @@ _supported_fs btrfs
>   _require_scratch_dev_pool 2
>   
>   _require_btrfs_command inspect-internal dump-tree
> -_require_command "$FILEFRAG_PROG" filefrag
>   _require_odirect
>   # Overwriting data is forbidden on a zoned block device
>   _require_non_zoned_device "${SCRATCH_DEV}"
> @@ -71,7 +70,7 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
>   echo "step 2......corrupt file extent" >>$seqres.full
>   
>   ${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
> -logical_in_btrfs=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
> +logical_in_btrfs=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
>   physical=$(get_physical ${logical_in_btrfs} 1)
>   devid=$(get_devid ${logical_in_btrfs} 1)
>   devpath=$(get_device_path ${devid})
> @@ -87,15 +86,7 @@ _scratch_mount
>   # step 3, 128k dio read (this read can repair bad copy)
>   echo "step 3......repair the bad copy" >>$seqres.full
>   
> -# since raid1 consists of two copies, and the bad copy was put on stripe #1
> -# while the good copy lies on stripe #0, the bad copy only gets access when the
> -# reader's pid % 2 == 1 is true
> -while true; do
> -	$XFS_IO_PROG -d -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar" > /dev/null &
> -	pid=$!
> -	wait
> -	[ $((pid % 2)) == 1 ] && break
> -done
> +_btrfs_direct_read_on_mirror 1 2 "$SCRATCH_MNT/foobar" 0 128K
>   


  (_btrfs_direct_read_on_mirror() is being reviewed in 1/10)

Otherwise. Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>




>   _scratch_unmount
>   

