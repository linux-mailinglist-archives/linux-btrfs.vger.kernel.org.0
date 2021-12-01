Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B87F46476E
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 07:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347033AbhLAG42 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 01:56:28 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:21360 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239448AbhLAG41 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Dec 2021 01:56:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1638341585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3emI/MDpAqT6URsE9WIiQbNiMqu9qxtOOoDTC4LZTck=;
        b=DI4vUGs5yDf9m/V9ArB1B0WUYwGEcLPcziVRRakpifMZWR+JyYia5rhv/rr8tAlefbV66a
        C0Pz1QOo2yVDGrsgZqRMIB+ZRQsR+9eWvqlK+IwFkw04F0TV3MXvyXfTk7Vx2UcvGiNrXQ
        YU5HkzFybBN+CEfHggwL8qLv9Xejx+w=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2051.outbound.protection.outlook.com [104.47.1.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-ZgZ4dU4rM22g0_q7dWdHlw-1; Wed, 01 Dec 2021 07:53:05 +0100
X-MC-Unique: ZgZ4dU4rM22g0_q7dWdHlw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWReACPI17H/Q4Eqe8NYml+DL7JQZWDh53egQEgPjF6jDqQ2uhTwKh2wMDVg3aK9rWKzzm7gRtRvTtTHeD2nJB6sEZnwX3kakeX2pECIAll2laiyBiB9lBZjT/3QYtN7VrtNVIKuq6bSBYhZk2Viv8RS7032gZ1EQAEgvAiVwiRDxTTivWzJ0MuRpoSxyfCvbkUUWGdeuo8AI5YLGwLjkUBMbtJBslqgkApUQQubmAPW+66lex6MXPTJ7t0fknZo8UeiBY3O0nPddzqUhVm0TxDwlH5recKz+ER/fjh81vJ1xDXBmyrcd0Jy/xfDQmWwk4OfvpXhyttPwmGZHybd9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3emI/MDpAqT6URsE9WIiQbNiMqu9qxtOOoDTC4LZTck=;
 b=iJRdgsvTc7dPIPm5dW3DFqaQlYXRP5c1rmEgh6uHiwer3sXKAsxgHfV6L+TkeuJV519pTVHBZ+siuuO14AsT3bw2fs67LIIjYe5qGrrFKL/gH7lqMfUxzcGfbkdoXso2ksUnfx6SQOJJ01GMCPdObfOb1kadkqvn13xW6r1K0GO7mYkYJ36upeh8002qiLcPk4zjgAIcwTE8dXddWSgcPaYFpLgr5AzpZklQL0LpmgBWPkDADUvdvi/qgQ7mXOZyUZKV4ixtNudV/E6SkrSYuP9JAtimlSumF8iphMiMYgMe9ahgQ/5kuyjgLl5sGSmv4c1ONbKzTSP8KzCMoVm/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DU2PR04MB8824.eurprd04.prod.outlook.com (2603:10a6:10:2e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 06:53:03 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::ed16:bc50:4079:9286]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::ed16:bc50:4079:9286%9]) with mapi id 15.20.4734.023; Wed, 1 Dec 2021
 06:53:03 +0000
Message-ID: <0c495a80-66f4-9e33-f292-9c9377756243@suse.com>
Date:   Wed, 1 Dec 2021 14:52:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 12/17] btrfs: return proper mapped length for RAID56
 profiles in __btrfs_map_block()
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
References: <20211201051756.53742-1-wqu@suse.com>
 <20211201051756.53742-13-wqu@suse.com>
In-Reply-To: <20211201051756.53742-13-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0044.namprd07.prod.outlook.com
 (2603:10b6:510:e::19) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by PH0PR07CA0044.namprd07.prod.outlook.com (2603:10b6:510:e::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Wed, 1 Dec 2021 06:53:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f149335-749e-408d-859d-08d9b497386b
X-MS-TrafficTypeDiagnostic: DU2PR04MB8824:
X-Microsoft-Antispam-PRVS: <DU2PR04MB882450869E8D6C64E66D5B7ED6689@DU2PR04MB8824.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8UWbUpuiRE8ouW/Vy6Nl4BUF6WO4LdeN7mFjVZbvuMvpT/sh8e8hdOVr6zGZCoVhyi1SMPh2r6m+wy0RnSrBWPkfocRXi0JhIV2zeC0TWNgO5pU+0qNxpOLXgWCag/WX04U9xuTglV87oQTCbOthxRo4skl0n8IncOs9W2v4ukd5oKdyNwg5vfGC53h6yy4Zk8kL7C/qrKr+rhVcCCD/2f47bIJ1XE2Q86u5UFgPIHKJX7QyV2WlaDViQ8NA3vBFQaSSn3ti/W+X8stCkOZf01uXsRZS4YQS3VfidLdICWOKsv9920pt+Bko0f1RkR0sbQoSXJAAAY4sIgckeXsVPyAPm6xyqNrEfZWteQnFw8XeNjYg8txyi+yk3nosmWhClb0TJsVQYUFmDTUxTTWrERjlIGO9R7vRtrE+VDNk/FZiLFEleRFU68dZQPnOEd75S79DaF4cpj2ikFVc075HkY0t9vql7lIoMDhV7L/49jg0bvlpQ/E2Sk45L3/3EAkMM3SC1Q55V0J1jFYj5KqQF6sJtMLWPPN+OSXCB5VKT54MTnhzfOjrVVQR6HD0gbRZHWHTCmaw8AyUay+DF/slYda0Jn22qts0bYwShrxzuTnE4N26uYB1f7YAXS+apth0X7Td1gdtJ1ot56zpQsGhnWZfAIPXKgyqcDfLeBdycudR0ISUfOZt/im6kon2l9g5ai7rlNCCgKCAE97Mcv2SmPLQgCzo0Rj5MMMbsj1s9d0mpqAXxuTPd3FWBQ4I76dw3DhmyGuhdY9NWJZWverQYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(6486002)(26005)(66556008)(66476007)(186003)(6666004)(6706004)(86362001)(83380400001)(5660300002)(36756003)(16576012)(31696002)(53546011)(6916009)(316002)(8676002)(8936002)(2616005)(31686004)(2906002)(38100700002)(956004)(66946007)(4326008)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXBOZWlQNmJCQk5JZVd3WmpaV3FPZ2tVMzFGTkdaR1FFeDMrYzdBbEQ3S2VN?=
 =?utf-8?B?U0VmNk5WVkd5blU5ZDNlQlhTclhQYjczeFBFNzRkaTRvWmtSUFNoNDBPalRa?=
 =?utf-8?B?YUtrOFFSYlBWcWpMTGZ1WmxGWVpGTTFzWk5kQUxXOVYwdytFZmJ5T0VYUHNY?=
 =?utf-8?B?cWdXYTA3OGJMajd6MU1WUE1BV0VnMG41K2tudTllUm1CTzVBeHd1dnRxR1VS?=
 =?utf-8?B?QSthZy9hNEgwVklnc0tqSGlHd0d0S2I4Tjl4MVFSR3k5eHVhOG5Ga29kTjBs?=
 =?utf-8?B?bTBvM3pDR1JicDhRTE9BcThvMUFLY0pDWEJOZHFMczR2WDZpRGxoY0xmbm9Q?=
 =?utf-8?B?QjVYWWpSbFFzVnJFaEY4SGtIaW53YXExQlZmL0dpaGswWXkxZ1FuTENEdEFu?=
 =?utf-8?B?R0lTbUNCMjJvdGxTdlI2dzVpS0JZNEp0ZUp4MWt2aU9tZEVDcU1ydnNBYVVI?=
 =?utf-8?B?ZHVsU3RPYTJUbXAwNmtYKzN0MmZHWndmaHZZYWNCZkZjZVVrT3IyNGlDQmxC?=
 =?utf-8?B?bDlwUGkwdjJLK0F6NGhEOE1DZStGVnkrUUwvcEJCV3Jpd2NiVExLRndtSE9p?=
 =?utf-8?B?Y3hYOFNTVUV4eTYwR05oQ00zK21ILzAvV0RtOG4yNTlxK2VCWlZjTms4ZDNW?=
 =?utf-8?B?WDN6YTBLN2xxdGUrSkwramFUWFhwcDhTa2tuUEFtd2dzVWNBTWN2aCtzalBU?=
 =?utf-8?B?RHU4dWtpYW9jV3hoRldVSzBzeEg0bUs2V0tnc0tML2tUeWRHa015OHlzOFdK?=
 =?utf-8?B?UDNZbFpyUjkyWGpNdGduNjlqVTVPYnJDYzNxNUFIcTNoRFZBOFR4S3FZdTRI?=
 =?utf-8?B?NVkxYTFKTUNoQmFZS09BUks1ZERrQjRBQldmcVhYMmNnVUkxTGZmdStlZG1y?=
 =?utf-8?B?THZ6UzBpenFKUlhGTThjdXBsQzR1eVJBUCt3dERKT3pxTlkxdW1qSEpkREtK?=
 =?utf-8?B?NlZ0aGU0eHlsbDFYMy84b0JWNnhoMHU2d3JFVjJFdXQwakhxUXBmVVY0RnlK?=
 =?utf-8?B?bXE0anl6aWJsR3o3dkpNSkV4TXZ6dlZvVVVaVS9EOTFpRTRoRE1LdW9OaEph?=
 =?utf-8?B?cUdJTitIc1ROcTc2ZzYrMkI4Q0FLQWVHZFV2bU9FTXk3dHBEVEswU0ZRK3Vw?=
 =?utf-8?B?WVdXQTZJSjByWmZvcllVUDFvWi9sbUlIcVE4OTBnZUxNWTVIcmpGZVhnTS9J?=
 =?utf-8?B?dWFsV2plZXpCNG5FRkVhNVUzMTVYZ2c0dDhjS0V3RjA2RFBBSUVRV0daNHBL?=
 =?utf-8?B?enpTckJPTzRWanp5akwzbG8zT2t3RDFoVm5sUWt4cUgzWEZBLy80cFovTXE4?=
 =?utf-8?B?ZUN5c01XNGNWUmVadHVicUY0Y2dya0hycDZsNmxZbXhmM3JJM0NJZ0d4MXR6?=
 =?utf-8?B?cEpZVVZBaUh1dWdRUlBwcDREZUFUNXoyMnR6clg3NUF3cytXNVd1Uy9CM3Mv?=
 =?utf-8?B?ZEttSGE0YmFTTFNiQW1ySEhUblZXRm9vYjdtTXRFeWV1c3pCallSNnBzWVJY?=
 =?utf-8?B?K09aMEt6Y0VKeUc1dU5ENnZDY2ZZQ3Irb1R3eVdqbnhXVFZ2TVFQc2lkVEkx?=
 =?utf-8?B?eXhVazZXQUp2QkNVQW5FRzFQR29UNUx3Y0lCQkNWcUV5UW05VGJjdHpiem8z?=
 =?utf-8?B?b2tWRXBLNlhSWDgwK09wOC9HQkZCRUJ5TmMyTjVJZ041UDFEdUVBM0haMmRK?=
 =?utf-8?B?eTIwM1Znbm5rTDByeXN5bmorZWQwMTB2VlNwNmVORVh5V09hT09hdkoxaTlq?=
 =?utf-8?B?MDY1UFVlK3l4M2RCTG53a2xON3FVOWtGRDJrNlNpUFYrR09FM0NVU3djVC8v?=
 =?utf-8?B?dzVidTVmNjhqOXp4RW11b0t5OXRHU01lT2dOam1ubmlnRSt3MUpTOXNKczFY?=
 =?utf-8?B?aGFMQ1BIT1BWN3NBMGtPaU01OHM3bXRVTVdsZ08vYVlaanhneW1qZGtyZFZi?=
 =?utf-8?B?ZWc0ajN0UUhPR3lha3V1d2xBUEgrOWVmUGZxVkFjTFVoSlN0czJaMDhGc2NR?=
 =?utf-8?B?WDk1YW5nS3pxQU93ZE1lVkxwNmZKZXgzTzUvMzAyQ3o2alJER2dsZmwvWDdM?=
 =?utf-8?B?TWxiR2poZXNZMGZhSDEzcDZ6UFVzQ3I4a29pSlpOeXVuWW41RzVSb1ZYdTJI?=
 =?utf-8?Q?DiUE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f149335-749e-408d-859d-08d9b497386b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 06:53:03.0104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpjhpqllmyNc4ebtRpKBYJpqPTsMZY9MP+Abk9r6Bpbb0+AIjFY+jAQogv8BiS2T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8824
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/1 13:17, Qu Wenruo wrote:
> For profiles other than RAID56, __btrfs_map_block() returns @map_length
> as min(stripe_end, logical + *length), which is also the same result
> from btrfs_get_io_geometry().
> 
> But for RAID56, __btrfs_map_block() returns @map_length as stripe_len.
> 
> This strange behavior is going to hurt incoming bio split at
> btrfs_map_bio() time, as we will use @map_length as bio split size.
> 
> Fix this behavior by:
> 
> - Return @map_length by the same calculatioin as other profiles
> 
> - Save stripe_len into btrfs_io_context
> 
> - Pass btrfs_io_context::stripe_len to raid56_*() functions
> 
> - Update raid56_*() functions to make its stripe_len parameter more
>    explicit
> 
> - Add extra ASSERT()s to make sure the passed stripe_len is correct

There is another hidden call site, scrub_stripe_index_and_offset() that 
is abusing such stripe_len and mapped_length.

And this would cause crash at btrfs/158.

Will fix it in next update, and make this specific patch to do better 
check on stripe_len.

Thanks,
Qu
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/raid56.c  | 12 ++++++++++--
>   fs/btrfs/raid56.h  |  2 +-
>   fs/btrfs/scrub.c   |  4 ++--
>   fs/btrfs/volumes.c | 13 ++++++++++---
>   fs/btrfs/volumes.h |  1 +
>   5 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 13e726c88a81..d35cfd750b76 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -969,6 +969,8 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
>   	int stripe_npages = DIV_ROUND_UP(stripe_len, PAGE_SIZE);
>   	void *p;
>   
> +	ASSERT(stripe_len == BTRFS_STRIPE_LEN);
> +
>   	rbio = kzalloc(sizeof(*rbio) +
>   		       sizeof(*rbio->stripe_pages) * num_pages +
>   		       sizeof(*rbio->bio_pages) * num_pages +
> @@ -1725,6 +1727,9 @@ int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc,
>   	struct blk_plug_cb *cb;
>   	int ret;
>   
> +	/* Currently we only support fixed stripe len */
> +	ASSERT(stripe_len == BTRFS_STRIPE_LEN);
> +
>   	rbio = alloc_rbio(fs_info, bioc, stripe_len);
>   	if (IS_ERR(rbio)) {
>   		btrfs_put_bioc(bioc);
> @@ -2122,6 +2127,9 @@ int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
>   	struct btrfs_raid_bio *rbio;
>   	int ret;
>   
> +	/* Currently we only support fixed stripe len */
> +	ASSERT(stripe_len == BTRFS_STRIPE_LEN);
> +
>   	if (generic_io) {
>   		ASSERT(bioc->mirror_num == mirror_num);
>   		btrfs_bio(bio)->mirror_num = mirror_num;
> @@ -2671,12 +2679,12 @@ void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio)
>   
>   struct btrfs_raid_bio *
>   raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bioc,
> -			  u64 length)
> +			  u64 stripe_len)
>   {
>   	struct btrfs_fs_info *fs_info = bioc->fs_info;
>   	struct btrfs_raid_bio *rbio;
>   
> -	rbio = alloc_rbio(fs_info, bioc, length);
> +	rbio = alloc_rbio(fs_info, bioc, stripe_len);
>   	if (IS_ERR(rbio))
>   		return NULL;
>   
> diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
> index 72c00fc284b5..7322dcae4498 100644
> --- a/fs/btrfs/raid56.h
> +++ b/fs/btrfs/raid56.h
> @@ -46,7 +46,7 @@ void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio);
>   
>   struct btrfs_raid_bio *
>   raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bioc,
> -			  u64 length);
> +			  u64 stripe_len);
>   void raid56_submit_missing_rbio(struct btrfs_raid_bio *rbio);
>   
>   int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info);
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 15a123e67108..58c7e8fcdeb1 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2230,7 +2230,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
>   	bio->bi_private = sblock;
>   	bio->bi_end_io = scrub_missing_raid56_end_io;
>   
> -	rbio = raid56_alloc_missing_rbio(bio, bioc, length);
> +	rbio = raid56_alloc_missing_rbio(bio, bioc, bioc->stripe_len);
>   	if (!rbio)
>   		goto rbio_out;
>   
> @@ -2846,7 +2846,7 @@ static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
>   	bio->bi_private = sparity;
>   	bio->bi_end_io = scrub_parity_bio_endio;
>   
> -	rbio = raid56_parity_alloc_scrub_rbio(bio, bioc, length,
> +	rbio = raid56_parity_alloc_scrub_rbio(bio, bioc, bioc->stripe_len,
>   					      sparity->scrub_dev,
>   					      sparity->dbitmap,
>   					      sparity->nsectors);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index af01d54502ab..365e43bbfd14 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6051,6 +6051,7 @@ static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
>   		ret = -ENOMEM;
>   		goto out;
>   	}
> +	bioc->stripe_len = map->stripe_len;
>   
>   	for (i = 0; i < num_stripes; i++) {
>   		bioc->stripes[i].physical =
> @@ -6406,6 +6407,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
>   {
>   	struct extent_map *em;
>   	struct map_lookup *map;
> +	const u64 orig_length = *length;
>   	u64 stripe_offset;
>   	u64 stripe_nr;
>   	u64 stripe_len;
> @@ -6427,6 +6429,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
>   
>   	ASSERT(bioc_ret);
>   	ASSERT(op != BTRFS_MAP_DISCARD);
> +	ASSERT(orig_length);
>   
>   	em = btrfs_get_chunk_map(fs_info, logical, *length);
>   	ASSERT(!IS_ERR(em));
> @@ -6522,7 +6525,10 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
>   			num_stripes = map->num_stripes;
>   			max_errors = nr_parity_stripes(map);
>   
> -			*length = map->stripe_len;
> +			/* Return the length to the full stripe end */
> +			*length = min(raid56_full_stripe_start + em->start +
> +				      data_stripes * stripe_len,
> +				      logical + orig_length) - logical;
>   			stripe_index = 0;
>   			stripe_offset = 0;
>   		} else {
> @@ -6574,6 +6580,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
>   		ret = -ENOMEM;
>   		goto out;
>   	}
> +	bioc->stripe_len = map->stripe_len;
>   
>   	for (i = 0; i < num_stripes; i++) {
>   		bioc->stripes[i].physical = map->stripes[stripe_index].physical +
> @@ -6824,9 +6831,9 @@ static int submit_one_mapped_range(struct btrfs_fs_info *fs_info, struct bio *bi
>   		/* In this case, map_length has been set to the length of
>   		   a single stripe; not the whole write */
>   		if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
> -			ret = raid56_parity_write(bio, bioc, map_length);
> +			ret = raid56_parity_write(bio, bioc, bioc->stripe_len);
>   		} else {
> -			ret = raid56_parity_recover(bio, bioc, map_length,
> +			ret = raid56_parity_recover(bio, bioc, bioc->stripe_len,
>   						    mirror_num, 1);
>   		}
>   
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 8825a17d0620..b2dbf895b4e3 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -450,6 +450,7 @@ struct btrfs_io_context {
>   	struct bio *orig_bio;
>   	void *private;
>   	atomic_t error;
> +	u32 stripe_len;
>   	int max_errors;
>   	int num_stripes;
>   	int mirror_num;
> 

