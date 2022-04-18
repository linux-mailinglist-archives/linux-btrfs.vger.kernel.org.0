Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475C2504D80
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 10:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbiDRIGi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 04:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbiDRIGh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 04:06:37 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7F31929F
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 01:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1650269036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D2DYDIAa/UtasI6T/UCYN3Gq6fXNla4DyQ5XaCgdHqk=;
        b=Ei90rbX5M/HnsPH8nhnjjwM4pPNRYzBvn7Ua41T2iOj1geSevNJ4E9XD+daSPdydfwbnbk
        /+4EQA0sziws4m/bnFGF2ray8KSkqoWdeYnZYbcmGBE4Cxzn4ya3JLTdeb4Ug4sOwDahV+
        xxURCl3kEM60mIDMeTyc4O4S2Kq6b5w=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2054.outbound.protection.outlook.com [104.47.13.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-3m-X7ZY2NSmf8_wEzZSCjA-1; Mon, 18 Apr 2022 10:03:55 +0200
X-MC-Unique: 3m-X7ZY2NSmf8_wEzZSCjA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCJpUvdU3IaA0A1u9ZVBn0hchElPt/vkjMAG3Fiau286PwijjYYH59c+U6eOUE7NPJGMbKlFZfIcIWFGKx3nn/g+0xP3xK0EuO3M9QpcD1qetEuu6CE5qjeVwJn9S+TSE+wgna2ReHAmXnLckiNIjpjevJUQTa69X8go6Wy7iqo3aBy3kPdQFxqjQwq+57GCHCwIhO13CZgXfwd+NmFPBSysFQHMvP3NcpIC6yjeTwuSPv2McrCnnLexzcQEbooLcOpgLh+onbcFjGo+f8lEyBYGiAsmdYtXf0RHkhBKgMeB9JcBbdEbk8+8yRATHGEDwaL58dF7Qdd17u6t5hvJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2DYDIAa/UtasI6T/UCYN3Gq6fXNla4DyQ5XaCgdHqk=;
 b=jNn30gP/WcHP00IvqmjtWTJcfN8QuY+te6W2te4volFH581cP3lw1i8tTO/1Blg0ritPlBDsiweGrBRtpPNWh0oAVEFx8w/jFTjJNgkM4tu3uv1/oN8ychp2LgrYQIf3oCmcX3/1tZxl+koe0rm6P0s0kX6jrFRVjgL9fgVZoOQpvt74dfJ0MoZW+v4M9PDx7iuYDuX5KzszsseXKQZ81RXHbW7/BYpd3fVP1HDTuZtymI7VzIhvl99Ck64cIN6Pc3T//xP6oOd1kXXid+CFhsBKM9CGfUTy8hYD1XJclQwPkAc19Jc1SdjofhvGn/fWRxXsJaFh/N8nvqvPFxJGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by HE1PR0402MB2812.eurprd04.prod.outlook.com (2603:10a6:3:d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 08:03:53 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::415f:1551:a6d5:face]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::415f:1551:a6d5:face%6]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 08:03:52 +0000
Message-ID: <03ea07cb-d724-26f6-bfce-99befb3ab15e@suse.com>
Date:   Mon, 18 Apr 2022 16:03:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220418044311.359720-1-hch@lst.de>
 <20220418044311.359720-2-hch@lst.de>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 1/3] btrfs: simplify WQ_HIGHPRI handling in struct
 btrfs_workqueue
In-Reply-To: <20220418044311.359720-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0049.namprd08.prod.outlook.com
 (2603:10b6:a03:117::26) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fa3a412-19d3-4190-92cc-08da2111fa47
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2812:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <HE1PR0402MB2812F24EE82ACFF5B28AB4B3D6F39@HE1PR0402MB2812.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kDdyxSf/hLrYHcJNorNIbB75efZe+KucC8tqkaNl/nmqxTosgqBOABY5jdVT/OJz0t6DltQOXwNBfU3f2co2y7iasKOjlIOMoIZKj7yjno5D3u7t3AYDb0rdlhRioe6OQXiur7zzuLRF4sgoOsMQdH4gtcESxrreZ7xBm5AC73Ad7Q37hcjxmqKTW/wn2Mv93YHsE8mhZ4g2UMIHn01XX1anLRryZTzHZ/3y/BomM3TxlDLFl0/q+S8aq0+7LRU8NnIvvZKA4b/hxNrr56Nd97I8mylNWQdAhAA4CH6viN/8kCWNtl3ce6+racWF+YNdYhiSFIVp6xhN4OI7E3Q7b1DK4actDO8+A1+70R1PH3VxjiqToQnRnL8033VRbDqEDxgPJW73F2YcKQsNBxVT0xdb17DjTIF1W6utgOZp8OvNFf9JQ5gEhG7IWvMaAlX8mZpX1g+XHVmQ5NXjJgalW1mhn3v9rjr//+/yTbjRD6KIA7JjOHfA2Mx+swNVMxixQdkI2D2R5cGUZVxOGE41TkTkRya9iC/eXPPgbv/MnXRqrO1ITsX7M/pK3mmuIG3FhR0VDPGi+kuRPxeq/oZHefc4RreQgibzOA5p7K9Kwb5wY8HyOdsLw8oK4hhxMpi6t90S59IVp5rShg6xBueHM0CePSwAKISkJCvpSLnbKH3n3W031kxbwhtRCVkeOYxgKITTZptCxvO4HvbmDPHTg7T/jDA5Oh0+MLxb2VgzsSs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(26005)(6486002)(8936002)(508600001)(6666004)(31696002)(30864003)(83380400001)(6506007)(2906002)(53546011)(86362001)(66946007)(6512007)(5660300002)(36756003)(4326008)(66476007)(8676002)(66556008)(6636002)(38100700002)(31686004)(110136005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHpWVTlmUUMyaHF3bHhndkJqSks1VzlNOVl6OVg2SjhZU2pZa3FBZU52L2FM?=
 =?utf-8?B?d3pETVBKRDk3c0pNcS9ucVN0aG9YdGMzMTk3VmRWaE5yVHAvNlFGNVVzdWdm?=
 =?utf-8?B?bDlaNWpZSDVoWlBMZ2xxc1ZIQVlxVWpVdy9CT2lCZVo4Mjh2REVrUzZoQVR3?=
 =?utf-8?B?OE9tcHh6T2pjRDhHU09vZFQvZVdqeU5aRTFZTHNpWjdrYWtwamdhSnNpVU9r?=
 =?utf-8?B?T29zU3NoNVExVkR4WUtzcDZEcWdVeWlSenFYNkFNNml3Zm9rU05HaEdEdTI1?=
 =?utf-8?B?MWRWSER3THM5K0t3czg1Q2I5S3ArUzlQTnhJMXRJQWdpNEJoRkJhdWhOOVhv?=
 =?utf-8?B?bTJmUDg3MDkxUWo1MDNZaENoVTZXN0FySW0remlqb0Z3aUxoeGphMThBZ1Rl?=
 =?utf-8?B?Vnh3SXQ0SjVFQnlLYU05NmpYbzhyUE8rbE5oYm5obDZ1QkEwd2FSTnNEQVZ3?=
 =?utf-8?B?dFJPYWxiU2VQaUdETVBhTjU2SElEZkFFSkJXaE8xbGNER1UyM2FzYTJoTXpq?=
 =?utf-8?B?d3BiaTlueGdaZjdjeTR5UzE3M013U043K3B2cTVtRWxnR2V5L0Q0dnVMSGpO?=
 =?utf-8?B?d3RJMlF1U0VEUUtBMzVkaGV1c01pZlg2b250N0pXRHpZWUxubEFFMXJuc3Fp?=
 =?utf-8?B?dkYzT3hjV1pxNXh4YUprb3R4RCtqZi9FS0dwZU1uL3FWSis2b3V0ajQ0Wktz?=
 =?utf-8?B?L25DYlZ4SEFEeWZ6cmhXMjhNSGRFUFpsc1gwRXlnSDdIQTRMcm1QR3E1ejFl?=
 =?utf-8?B?VEUrSmlwNjM5T3ZOQWxFdkgzUVV3aEtnNkxzWmN5NVFKd1Q2TnNFM1pvczdU?=
 =?utf-8?B?eTZvdGFQYVVJNGxsQll4dUthbFdSVTBTRW53SlBDUGppdGdHLzZ5dDU5WjJl?=
 =?utf-8?B?Z3dnQVBuUkFpTm9OWnZFdktEenpPR01JS2J4cGlPazFjSzJFa3R4emFVUy90?=
 =?utf-8?B?ZEhiZjZLa1lEZ2YraSttc2N2NnRTRjAyUFRxWTMvcW0vUVZ5WGdJcllGNmxU?=
 =?utf-8?B?b3lEUEJvRHFrNEduNG5iVUtqdnR5VGtuUkdITEZjUC9oU2lrWlZVUDZXZnBG?=
 =?utf-8?B?NTcveUJRS3RGTFUrSW5uamhtdTlKZ3kwKzNBK0QvcmNTbU13UVdCSjV2Y1li?=
 =?utf-8?B?NEtVU1NxMEhzejQyemF5UDBsQ044cFpBeGRQNGcvNGM1cWdFQ2daZkRsbE9r?=
 =?utf-8?B?NXpvQTJ3a0EzT2xlSGE4TW1DWDY4VVVIOXBTc3laUG00NmtXcDJiVnZlckxj?=
 =?utf-8?B?YmpJd21nbldGdE1tbm0zMHMwMDdNS01NbmFGR1dQTHJKRGtTN0tyMmdJQlM3?=
 =?utf-8?B?VEcxMGtrM2lnTG9TR0EzVFZ4MnlzbjRqV3BBbGU3OFVFOFBsbzFLY2J1Ukg2?=
 =?utf-8?B?dDAzZXMrTEZmTm9XY292K2lwT0lIelB1eXlwK0FJQVlPalJHbXVJTlZ5UGZ6?=
 =?utf-8?B?WFF2NzVCeVRUbDB2SmJIcDZFVWtMZlBXOWFXSTFMaExCVStEbHJIT1BzYzlB?=
 =?utf-8?B?REREMmtiUWZBeGFSamZnNWFTajhid2EwUHhiUW8xUzRiUXFVMFFqcGRHdkhq?=
 =?utf-8?B?V3NLcHVWUXl3QldJTW96MXQ4MXRJb3Qrdlo3QVBoWElRanFOT3g5TWk3VEMx?=
 =?utf-8?B?U3NpTGtGWHpMdU5FdVY4c2xHQ2VLYnJ3VkVrMW9TUWVlclFIZWtUcGtPNUtu?=
 =?utf-8?B?cENaRnZtRGQ0UUk2U2tML1dEMFhySVRyK3Z0QzRsUGpGSHpkRHA0YXQraTE5?=
 =?utf-8?B?RjJ1V0hzbDJqbTRwb1YrbmpvMDlRcVFnck85bDhBUFZuQkZTQmRpN3lVYTN1?=
 =?utf-8?B?TkxveHAxV0o3S3lvbklQeitBdXV4QXduRkpFN0ovUWlXTUY1L25CNlJmOURS?=
 =?utf-8?B?TjZHNE1BQXFIdlRiN0NGRHBXU0hHMzVzaStuMmFheEtjTy9lbzFKdzJBeU94?=
 =?utf-8?B?RHk2SDk2MTlBQ3NzVjF1T2V6TUFtOEhBbEZ5c2tmdUNxVU1SdzEyRHRlWUd6?=
 =?utf-8?B?SE9SVHpNb1RuMW5uZEEydlg2TC9lUFpLUFVTL2loamNNTlhjZ3dEejIxQ1c3?=
 =?utf-8?B?eWVTbGExSFpkQzdsbDRDbzBBbklQNU04cTcrVmU1Q0ZoYUNvY050di9BKzFz?=
 =?utf-8?B?eG5UMWE4RWp3OW5SaWxEWmYvdEJLdDhyRlRTRSsyODc5TGpuVWlMWm4zZGlL?=
 =?utf-8?B?YUJZODNsOElydDllRitkMW5xMkJ5dmN6UGdzN0xGT3MzV3dhUDVIQkthU3BE?=
 =?utf-8?B?SnlKM2dZeWtYOVUrWEc2UG5pUSttY2NCTVlIVTlzYm5LSTNJV2FpNWNMYzNm?=
 =?utf-8?Q?nA4xVu5ZLXwblzND77?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa3a412-19d3-4190-92cc-08da2111fa47
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 08:03:52.6313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QNv+12+0WSVgf7uIXb0uuVBrp3wpu/X0VLgZMNOQECEsJsefFg7wNwzJQEA2GMe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2812
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/18 12:43, Christoph Hellwig wrote:
> Just let the one callers that want optional WQ_HIGHPRI handling allocate
> a separate btrfs_workqueue for that.  This allows to rename
> struct __btrfs_workqueue to btrfs_workqueue, remove a pointer indirection
> and separate allocation for all btrfs_workqueue users and generally
> simplify the code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just small nitpicks inlined below.

> ---
>   fs/btrfs/async-thread.c      | 123 +++++++----------------------------
>   fs/btrfs/async-thread.h      |   7 +-
>   fs/btrfs/ctree.h             |   1 +
>   fs/btrfs/disk-io.c           |  14 ++--
>   fs/btrfs/super.c             |   1 +
>   include/trace/events/btrfs.h |  32 ++++-----
>   6 files changed, 50 insertions(+), 128 deletions(-)
> 
> diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
> index 43c89952b7d25..44e04059bbfc3 100644
> --- a/fs/btrfs/async-thread.c
> +++ b/fs/btrfs/async-thread.c
> @@ -15,13 +15,12 @@
>   enum {
>   	WORK_DONE_BIT,
>   	WORK_ORDER_DONE_BIT,
> -	WORK_HIGH_PRIO_BIT,
>   };
>   
>   #define NO_THRESHOLD (-1)
>   #define DFT_THRESHOLD (32)
>   
> -struct __btrfs_workqueue {
> +struct btrfs_workqueue {
>   	struct workqueue_struct *normal_wq;

I guess we can also rename @normal_wq here, as there is only one wq in 
each btrfs_workqueue, no need to distinguish them in btrfs_workqueue.


And since we're here, doing a pahole optimization would also be a good 
idea (can be done in a sepearate patchset).

Especially there is a huge 16 bytes hole between @ordered_list and 
@list_lock.

We can put all of our int/unsigned int members there, thus saving more 
memory.

Thanks,
Qu

>   
>   	/* File system this workqueue services */
> @@ -48,12 +47,7 @@ struct __btrfs_workqueue {
>   	spinlock_t thres_lock;
>   };
>   
> -struct btrfs_workqueue {
> -	struct __btrfs_workqueue *normal;
> -	struct __btrfs_workqueue *high;
> -};
> -
> -struct btrfs_fs_info * __pure btrfs_workqueue_owner(const struct __btrfs_workqueue *wq)
> +struct btrfs_fs_info * __pure btrfs_workqueue_owner(const struct btrfs_workqueue *wq)
>   {
>   	return wq->fs_info;
>   }
> @@ -66,22 +60,22 @@ struct btrfs_fs_info * __pure btrfs_work_owner(const struct btrfs_work *work)
>   bool btrfs_workqueue_normal_congested(const struct btrfs_workqueue *wq)
>   {
>   	/*
> -	 * We could compare wq->normal->pending with num_online_cpus()
> +	 * We could compare wq->pending with num_online_cpus()
>   	 * to support "thresh == NO_THRESHOLD" case, but it requires
>   	 * moving up atomic_inc/dec in thresh_queue/exec_hook. Let's
>   	 * postpone it until someone needs the support of that case.
>   	 */
> -	if (wq->normal->thresh == NO_THRESHOLD)
> +	if (wq->thresh == NO_THRESHOLD)
>   		return false;
>   
> -	return atomic_read(&wq->normal->pending) > wq->normal->thresh * 2;
> +	return atomic_read(&wq->pending) > wq->thresh * 2;
>   }
>   
> -static struct __btrfs_workqueue *
> -__btrfs_alloc_workqueue(struct btrfs_fs_info *fs_info, const char *name,
> -			unsigned int flags, int limit_active, int thresh)
> +struct btrfs_workqueue *btrfs_alloc_workqueue(struct btrfs_fs_info *fs_info,
> +		const char *name, unsigned int flags, int limit_active,
> +		int thresh)
>   {
> -	struct __btrfs_workqueue *ret = kzalloc(sizeof(*ret), GFP_KERNEL);
> +	struct btrfs_workqueue *ret = kzalloc(sizeof(*ret), GFP_KERNEL);
>   
>   	if (!ret)
>   		return NULL;
> @@ -105,12 +99,8 @@ __btrfs_alloc_workqueue(struct btrfs_fs_info *fs_info, const char *name,
>   		ret->thresh = thresh;
>   	}
>   
> -	if (flags & WQ_HIGHPRI)
> -		ret->normal_wq = alloc_workqueue("btrfs-%s-high", flags,
> -						 ret->current_active, name);
> -	else
> -		ret->normal_wq = alloc_workqueue("btrfs-%s", flags,
> -						 ret->current_active, name);
> +	ret->normal_wq = alloc_workqueue("btrfs-%s", flags, ret->current_active,
> +					 name);
>   	if (!ret->normal_wq) {
>   		kfree(ret);
>   		return NULL;
> @@ -119,41 +109,7 @@ __btrfs_alloc_workqueue(struct btrfs_fs_info *fs_info, const char *name,
>   	INIT_LIST_HEAD(&ret->ordered_list);
>   	spin_lock_init(&ret->list_lock);
>   	spin_lock_init(&ret->thres_lock);
> -	trace_btrfs_workqueue_alloc(ret, name, flags & WQ_HIGHPRI);
> -	return ret;
> -}
> -
> -static inline void
> -__btrfs_destroy_workqueue(struct __btrfs_workqueue *wq);
> -
> -struct btrfs_workqueue *btrfs_alloc_workqueue(struct btrfs_fs_info *fs_info,
> -					      const char *name,
> -					      unsigned int flags,
> -					      int limit_active,
> -					      int thresh)
> -{
> -	struct btrfs_workqueue *ret = kzalloc(sizeof(*ret), GFP_KERNEL);
> -
> -	if (!ret)
> -		return NULL;
> -
> -	ret->normal = __btrfs_alloc_workqueue(fs_info, name,
> -					      flags & ~WQ_HIGHPRI,
> -					      limit_active, thresh);
> -	if (!ret->normal) {
> -		kfree(ret);
> -		return NULL;
> -	}
> -
> -	if (flags & WQ_HIGHPRI) {
> -		ret->high = __btrfs_alloc_workqueue(fs_info, name, flags,
> -						    limit_active, thresh);
> -		if (!ret->high) {
> -			__btrfs_destroy_workqueue(ret->normal);
> -			kfree(ret);
> -			return NULL;
> -		}
> -	}
> +	trace_btrfs_workqueue_alloc(ret, name);
>   	return ret;
>   }
>   
> @@ -162,7 +118,7 @@ struct btrfs_workqueue *btrfs_alloc_workqueue(struct btrfs_fs_info *fs_info,
>    * This hook WILL be called in IRQ handler context,
>    * so workqueue_set_max_active MUST NOT be called in this hook
>    */
> -static inline void thresh_queue_hook(struct __btrfs_workqueue *wq)
> +static inline void thresh_queue_hook(struct btrfs_workqueue *wq)
>   {
>   	if (wq->thresh == NO_THRESHOLD)
>   		return;
> @@ -174,7 +130,7 @@ static inline void thresh_queue_hook(struct __btrfs_workqueue *wq)
>    * This hook is called in kthread content.
>    * So workqueue_set_max_active is called here.
>    */
> -static inline void thresh_exec_hook(struct __btrfs_workqueue *wq)
> +static inline void thresh_exec_hook(struct btrfs_workqueue *wq)
>   {
>   	int new_current_active;
>   	long pending;
> @@ -217,7 +173,7 @@ static inline void thresh_exec_hook(struct __btrfs_workqueue *wq)
>   	}
>   }
>   
> -static void run_ordered_work(struct __btrfs_workqueue *wq,
> +static void run_ordered_work(struct btrfs_workqueue *wq,
>   			     struct btrfs_work *self)
>   {
>   	struct list_head *list = &wq->ordered_list;
> @@ -305,7 +261,7 @@ static void btrfs_work_helper(struct work_struct *normal_work)
>   {
>   	struct btrfs_work *work = container_of(normal_work, struct btrfs_work,
>   					       normal_work);
> -	struct __btrfs_workqueue *wq;
> +	struct btrfs_workqueue *wq = work->wq;
>   	int need_order = 0;
>   
>   	/*
> @@ -318,7 +274,6 @@ static void btrfs_work_helper(struct work_struct *normal_work)
>   	 */
>   	if (work->ordered_func)
>   		need_order = 1;
> -	wq = work->wq;
>   
>   	trace_btrfs_work_sched(work);
>   	thresh_exec_hook(wq);
> @@ -350,8 +305,8 @@ void btrfs_init_work(struct btrfs_work *work, btrfs_func_t func,
>   	work->flags = 0;
>   }
>   
> -static inline void __btrfs_queue_work(struct __btrfs_workqueue *wq,
> -				      struct btrfs_work *work)
> +void btrfs_queue_work(struct btrfs_workqueue *wq,
> +		      struct btrfs_work *work)
>   {
>   	unsigned long flags;
>   
> @@ -366,54 +321,22 @@ static inline void __btrfs_queue_work(struct __btrfs_workqueue *wq,
>   	queue_work(wq->normal_wq, &work->normal_work);
>   }
>   
> -void btrfs_queue_work(struct btrfs_workqueue *wq,
> -		      struct btrfs_work *work)
> -{
> -	struct __btrfs_workqueue *dest_wq;
> -
> -	if (test_bit(WORK_HIGH_PRIO_BIT, &work->flags) && wq->high)
> -		dest_wq = wq->high;
> -	else
> -		dest_wq = wq->normal;
> -	__btrfs_queue_work(dest_wq, work);
> -}
> -
> -static inline void
> -__btrfs_destroy_workqueue(struct __btrfs_workqueue *wq)
> -{
> -	destroy_workqueue(wq->normal_wq);
> -	trace_btrfs_workqueue_destroy(wq);
> -	kfree(wq);
> -}
> -
>   void btrfs_destroy_workqueue(struct btrfs_workqueue *wq)
>   {
>   	if (!wq)
>   		return;
> -	if (wq->high)
> -		__btrfs_destroy_workqueue(wq->high);
> -	__btrfs_destroy_workqueue(wq->normal);
> +	destroy_workqueue(wq->normal_wq);
> +	trace_btrfs_workqueue_destroy(wq);
>   	kfree(wq);
>   }
>   
>   void btrfs_workqueue_set_max(struct btrfs_workqueue *wq, int limit_active)
>   {
> -	if (!wq)
> -		return;
> -	wq->normal->limit_active = limit_active;
> -	if (wq->high)
> -		wq->high->limit_active = limit_active;
> -}
> -
> -void btrfs_set_work_high_priority(struct btrfs_work *work)
> -{
> -	set_bit(WORK_HIGH_PRIO_BIT, &work->flags);
> +	if (wq)
> +		wq->limit_active = limit_active;
>   }
>   
>   void btrfs_flush_workqueue(struct btrfs_workqueue *wq)
>   {
> -	if (wq->high)
> -		flush_workqueue(wq->high->normal_wq);
> -
> -	flush_workqueue(wq->normal->normal_wq);
> +	flush_workqueue(wq->normal_wq);
>   }
> diff --git a/fs/btrfs/async-thread.h b/fs/btrfs/async-thread.h
> index 3204daa51b955..07960529b3601 100644
> --- a/fs/btrfs/async-thread.h
> +++ b/fs/btrfs/async-thread.h
> @@ -11,8 +11,6 @@
>   
>   struct btrfs_fs_info;
>   struct btrfs_workqueue;
> -/* Internal use only */
> -struct __btrfs_workqueue;
>   struct btrfs_work;
>   typedef void (*btrfs_func_t)(struct btrfs_work *arg);
>   typedef void (*btrfs_work_func_t)(struct work_struct *arg);
> @@ -25,7 +23,7 @@ struct btrfs_work {
>   	/* Don't touch things below */
>   	struct work_struct normal_work;
>   	struct list_head ordered_list;
> -	struct __btrfs_workqueue *wq;
> +	struct btrfs_workqueue *wq;
>   	unsigned long flags;
>   };
>   
> @@ -40,9 +38,8 @@ void btrfs_queue_work(struct btrfs_workqueue *wq,
>   		      struct btrfs_work *work);
>   void btrfs_destroy_workqueue(struct btrfs_workqueue *wq);
>   void btrfs_workqueue_set_max(struct btrfs_workqueue *wq, int max);
> -void btrfs_set_work_high_priority(struct btrfs_work *work);
>   struct btrfs_fs_info * __pure btrfs_work_owner(const struct btrfs_work *work);
> -struct btrfs_fs_info * __pure btrfs_workqueue_owner(const struct __btrfs_workqueue *wq);
> +struct btrfs_fs_info * __pure btrfs_workqueue_owner(const struct btrfs_workqueue *wq);
>   bool btrfs_workqueue_normal_congested(const struct btrfs_workqueue *wq);
>   void btrfs_flush_workqueue(struct btrfs_workqueue *wq);
>   
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 55dee124ee447..383aba168e1d2 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -847,6 +847,7 @@ struct btrfs_fs_info {
>   	 * two
>   	 */
>   	struct btrfs_workqueue *workers;
> +	struct btrfs_workqueue *hipri_workers;
>   	struct btrfs_workqueue *delalloc_workers;
>   	struct btrfs_workqueue *flush_workers;
>   	struct btrfs_workqueue *endio_workers;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 2689e85896272..980616cc08bfc 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -874,9 +874,9 @@ blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
>   	async->status = 0;
>   
>   	if (op_is_sync(bio->bi_opf))
> -		btrfs_set_work_high_priority(&async->work);
> -
> -	btrfs_queue_work(fs_info->workers, &async->work);
> +		btrfs_queue_work(fs_info->hipri_workers, &async->work);
> +	else
> +		btrfs_queue_work(fs_info->workers, &async->work);
>   	return 0;
>   }
>   
> @@ -2286,6 +2286,7 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
>   {
>   	btrfs_destroy_workqueue(fs_info->fixup_workers);
>   	btrfs_destroy_workqueue(fs_info->delalloc_workers);
> +	btrfs_destroy_workqueue(fs_info->hipri_workers);
>   	btrfs_destroy_workqueue(fs_info->workers);
>   	btrfs_destroy_workqueue(fs_info->endio_workers);
>   	btrfs_destroy_workqueue(fs_info->endio_raid56_workers);
> @@ -2465,6 +2466,9 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
>   
>   	fs_info->workers =
>   		btrfs_alloc_workqueue(fs_info, "worker",
> +				      flags, max_active, 16);
> +	fs_info->hipri_workers =
> +		btrfs_alloc_workqueue(fs_info, "worker-high",
>   				      flags | WQ_HIGHPRI, max_active, 16);
>   
>   	fs_info->delalloc_workers =
> @@ -2512,8 +2516,8 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
>   	fs_info->discard_ctl.discard_workers =
>   		alloc_workqueue("btrfs_discard", WQ_UNBOUND | WQ_FREEZABLE, 1);
>   
> -	if (!(fs_info->workers && fs_info->delalloc_workers &&
> -	      fs_info->flush_workers &&
> +	if (!(fs_info->workers && fs_info->hipri_workers &&
> +	      fs_info->delalloc_workers && fs_info->flush_workers &&
>   	      fs_info->endio_workers && fs_info->endio_meta_workers &&
>   	      fs_info->endio_meta_write_workers &&
>   	      fs_info->endio_write_workers && fs_info->endio_raid56_workers &&
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 206f44005c52a..2236024aca648 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1903,6 +1903,7 @@ static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
>   	       old_pool_size, new_pool_size);
>   
>   	btrfs_workqueue_set_max(fs_info->workers, new_pool_size);
> +	btrfs_workqueue_set_max(fs_info->hipri_workers, new_pool_size);
>   	btrfs_workqueue_set_max(fs_info->delalloc_workers, new_pool_size);
>   	btrfs_workqueue_set_max(fs_info->caching_workers, new_pool_size);
>   	btrfs_workqueue_set_max(fs_info->endio_workers, new_pool_size);
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index f068ff30d6541..5cbc60b938535 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -24,7 +24,7 @@ struct btrfs_free_cluster;
>   struct map_lookup;
>   struct extent_buffer;
>   struct btrfs_work;
> -struct __btrfs_workqueue;
> +struct btrfs_workqueue;
>   struct btrfs_qgroup_extent_record;
>   struct btrfs_qgroup;
>   struct extent_io_tree;
> @@ -1457,42 +1457,38 @@ DEFINE_EVENT(btrfs__work, btrfs_ordered_sched,
>   	TP_ARGS(work)
>   );
>   
> -DECLARE_EVENT_CLASS(btrfs__workqueue,
> +DECLARE_EVENT_CLASS(btrfs_workqueue,
>   
> -	TP_PROTO(const struct __btrfs_workqueue *wq,
> -		 const char *name, int high),
> +	TP_PROTO(const struct btrfs_workqueue *wq,
> +		 const char *name),
>   
> -	TP_ARGS(wq, name, high),
> +	TP_ARGS(wq, name),
>   
>   	TP_STRUCT__entry_btrfs(
>   		__field(	const void *,	wq			)
>   		__string(	name,	name			)
> -		__field(	int ,	high			)
>   	),
>   
>   	TP_fast_assign_btrfs(btrfs_workqueue_owner(wq),
>   		__entry->wq		= wq;
>   		__assign_str(name, name);
> -		__entry->high		= high;
>   	),
>   
> -	TP_printk_btrfs("name=%s%s wq=%p", __get_str(name),
> -		  __print_flags(__entry->high, "",
> -				{(WQ_HIGHPRI),	"-high"}),
> +	TP_printk_btrfs("name=%s wq=%p", __get_str(name),
>   		  __entry->wq)
>   );
>   
> -DEFINE_EVENT(btrfs__workqueue, btrfs_workqueue_alloc,
> +DEFINE_EVENT(btrfs_workqueue, btrfs_workqueue_alloc,
>   
> -	TP_PROTO(const struct __btrfs_workqueue *wq,
> -		 const char *name, int high),
> +	TP_PROTO(const struct btrfs_workqueue *wq,
> +		 const char *name),
>   
> -	TP_ARGS(wq, name, high)
> +	TP_ARGS(wq, name)
>   );
>   
> -DECLARE_EVENT_CLASS(btrfs__workqueue_done,
> +DECLARE_EVENT_CLASS(btrfs_workqueue_done,
>   
> -	TP_PROTO(const struct __btrfs_workqueue *wq),
> +	TP_PROTO(const struct btrfs_workqueue *wq),
>   
>   	TP_ARGS(wq),
>   
> @@ -1507,9 +1503,9 @@ DECLARE_EVENT_CLASS(btrfs__workqueue_done,
>   	TP_printk_btrfs("wq=%p", __entry->wq)
>   );
>   
> -DEFINE_EVENT(btrfs__workqueue_done, btrfs_workqueue_destroy,
> +DEFINE_EVENT(btrfs_workqueue_done, btrfs_workqueue_destroy,
>   
> -	TP_PROTO(const struct __btrfs_workqueue *wq),
> +	TP_PROTO(const struct btrfs_workqueue *wq),
>   
>   	TP_ARGS(wq)
>   );

