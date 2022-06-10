Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C224D545EDE
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 10:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347680AbiFJI0s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 04:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347676AbiFJI0g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 04:26:36 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7504198CA
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 01:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBW5Pt/otWEXfhJXpNrApvA3QrfA6ZbWZkgSiyXM5ORt9NL/5zFeFs5qDfMiq8z0iWG/Z8BYYcpK1LhMuZgZyCnbcJn9F7yUH7D3RAlUU8Sifwnw+7Q08bwNvWxHdiymBS1HwfGrxussthv/VCx3tggJcygjirsEGy0ScziWICSWD6pPdfUbUXHEI/AG1r9W2lgUCnpdBGx2gGwNelepafIBfIvC7n0HonLcUdNbJq1I3vDr1A/SG14S58M9Jme2epR3seOnViju8VAqpzk8BYWhyG43cpFQX4CCdPCdGwfsksuQvIbUut9uiO6YcGegbQMK+FBgA0bhm2vxCG9tIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEms/8ycL5OM7JOVXOh1pJQl7Oz3ndzdaR3bxphALTE=;
 b=Z8F6h3Kio7gIW2a9CBQneZpkjsmlOeqq1vYMpSKQrexYBNuqALfsLkxwQEI4vavzfHB/68qW8zhBbv9zRKoBTYaMVt7jUFbFqIvcEO//WdB/5IF0mADc+uMXBbiJX3vVKbyG5Vy3K1xo2Wql5ezv7SqTSxeQutnxwOUkkJf3YYfsC+2VegRvhpJ5jt7aoEjW/g9wWc3ugyuZ0POiMHZyYOLIRlJyha58354H0z6qTbZOHBBctMFzf8iWL8Y/Ch/0B8PnH0VdYdxLHiKAaLeIo+FTjiM7j5KE/4OKFXOsy8Aks1NRvIdBC1etbZjGrsWROzMt3hyWUhbuDMs02cOplw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEms/8ycL5OM7JOVXOh1pJQl7Oz3ndzdaR3bxphALTE=;
 b=rCqqH7Z5t94KjaLeWuFX38p3Pa16g02BWqj/KG/afcDSvFCaUBH7rULDFBIS9YFzCPX/uOO4zEQKXfRrAQEsqGiHzRB00n92eTzc5j4irDaHxD9ZG4rZB8jAX8CJLVMZVX84eErrcKOTajVTQ4dt2E2JYRSTUE+SGvvs+eQzKmcB6DxLYH9QuSFAD+dSVHLJ/auHSc1XhUXZsJ6nsZ/gPDCBwMHhccHApL4SV1shIwcKnGecZzJGkQxYfLkr50B2oWqxKmBQMRPFVe5TzgMVmcYo0brWosX1CVMKtV8ZkrrPXY6fay7WL0aQU604uexE3KBQXxjCZl/t1Ub3K3e+SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DBAPR04MB7384.eurprd04.prod.outlook.com (2603:10a6:10:1b1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 08:22:24 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::a57d:280a:598a:85bf]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::a57d:280a:598a:85bf%9]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 08:22:24 +0000
Message-ID: <b479101f-400e-1f16-c5d0-1775b7ea1698@suse.com>
Date:   Fri, 10 Jun 2022 16:22:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] btrfs: properly record errors for super block writeback
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <6726644169a9f4affbb6894a8a560c96072be9cf.1654841347.git.wqu@suse.com>
In-Reply-To: <6726644169a9f4affbb6894a8a560c96072be9cf.1654841347.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::7) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bb4800b-1d23-4a1b-bead-08da4aba591b
X-MS-TrafficTypeDiagnostic: DBAPR04MB7384:EE_
X-Microsoft-Antispam-PRVS: <DBAPR04MB73842E2FB4A08EB3AA749F63D6A69@DBAPR04MB7384.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Un2La+h9e/l+0daVk8qSwCEfSl+7haaCZoT2pEYcmNRXmyJ0fOx2b5f/T689EAdGwRENRXeDmV8pE4Q2x6K1FWNPQAFtZWYnjduXeVXNPFXcRSel9kXeSG0+XB7ftgAvPuVUx/Qwl7lvTwtLeC59pZBmrusWOybuY7Oihgdn/hlJJ7NsXtvnfcHNPXGhUU4FQzWuHYcotQhjjUqYNKqCPgIkIJgs/jjs5VupRQSIQSAdkXUakCQDMCi0dI4c5yUYexLvX9w++oxDqnVoLLuplgFHgKof+VhWFv+paxcvHKJiLofL4rXMxaZYkisZi4c9rDz8KydgpxwGiKS3Upn79twOqNmjxoOCDR442qq1aIrUpClC2Fc7A6wSP6YAmlGNSKZ6vzkhvldvte004N16J5mxWefyrF4w/M+SdPU7adhrYfHE5pl2Gu6LKWEvr+X90qeyM9crkHS2Kkn7pExaqfgnLxaPmHqrLyMUFdooGnFTreWCjsJJRdVgK9owJz5BQnM6bv8WQEtAElVJtWav0d9zjsxoxVV/hKK1uJuKWO6eE5Q6NUp5uPofKdZ2C9bvWDlTV0XHL3TzvgKBU/tnQkwc0Ac3oismKEMfGyWzRGpq10t+dps9vjvOJvF2JDwBnj8O+93CsEtCQ9YYVIOc7NdBlmyp7BmEBUwydLCAZRFohAcLHLdxgTx595WKVbYcI4AzVwiZRB2sTfKBvsjqFGqpMbisU3ZVXNdkX4mvuAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(316002)(38100700002)(8936002)(6486002)(6666004)(83380400001)(508600001)(2616005)(66556008)(186003)(6916009)(66476007)(66946007)(31696002)(8676002)(6512007)(6506007)(5660300002)(2906002)(31686004)(53546011)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGZLamVsY0lyYitwV1pub25RRGxseHA2YVVqZzBIS0RWb3NBeHhsOVpnQ0gw?=
 =?utf-8?B?TzJSLzhCUW1VZ2FOYXVIczBxMUY0bWc1VitoMXZnbVVrTGowUFFJbUxWY01F?=
 =?utf-8?B?SU5QM0t6b1RGSlpla1ZUc29CcDJnUzQ0d2FmVWRZZG9HaHpNY0lsclR5ZUZt?=
 =?utf-8?B?ckZlZHJacnFJcGE5Wmt5RUVtVjZKVTBBclhPTnRibW9JVWU5cE1xbEU5Ym9W?=
 =?utf-8?B?VUhwRWl2YmZqa0RjTHJaZnNVL1pCMnFXZGxOcFBqMWlmSVZNY1ZlblBnV1Jo?=
 =?utf-8?B?ZnVOQjdCUjE3WExVaU5nVHRVYW4rMU5pSlMwUzhGUUI5RkZPcTg0cmpGK0M5?=
 =?utf-8?B?bS9CUGNvWEFpTDZoaTdVT0s4bjZxSloyUGhDMWwwVGhUWTAwcW12ZGFkRkV4?=
 =?utf-8?B?WkdQYm9OOUl2cXNXTHc3UFNHcEZBTS95ZDVSSVk5d0ZzNmR5eWxKR0d6SHhq?=
 =?utf-8?B?UW1yV0JxN2lacC9zbWlaNWpyRkhVV21oZnVWamtSOGJVekRReEhwUGlVVkl3?=
 =?utf-8?B?TlJJL2x5RmhsbjRDUC9aTGk0RkxpWmlPUjJ2dU5XUkF5andNUlkrQ1ZiaDB5?=
 =?utf-8?B?TEVMQnAzMzZla3JBSEJQR1Nob0JyNjdVRnArUTEvWUNKLzh3eSsvRW5IdUJm?=
 =?utf-8?B?NkI0U3crVTVwcCttUHRuWUU0WWdoWm54cy9mT3ZMUUtpR0o1M0djSDlud2pP?=
 =?utf-8?B?VnZwZVBxaWNPZzlDZ2FDUWEyNHJjUTJsWlRGVnp2ZjI5QVlnQ3hhMVlCTzVz?=
 =?utf-8?B?Z0RaZW5ZNzZIcmZuSExzTXpHZ0NDRU9vZVdQeGtlNjFqRFAxay9KaDNycmFV?=
 =?utf-8?B?S1BSSFpIK21lc0pYTWJIMUpEdHpSaUN4Mlg0anhlaVpYc0JYdWg3QmVkQUk3?=
 =?utf-8?B?WjNNNjlKRWFhSUp4dXR2clJ0andrMVQyQWNxYTFwemc0STBCcEE1U3NydDly?=
 =?utf-8?B?OWVEK1QvbFcwUEVESEZIVWJxMmYvMkJybjRGYW5ETmNXcDQwREJOcVFIZ1da?=
 =?utf-8?B?ZlB5NE1OcTEyZ0VuNjVBeVgwZCtsSVRINlRnR3RKVEZEdHpCTWFhWDJqZDhR?=
 =?utf-8?B?dXZ1Yk9iUjNXSHR5REhrQy9NcHpqUzlac3hDTTJJYkIzY3hNcG53Zy9sUHZQ?=
 =?utf-8?B?YlRlUUpDdlRmTlIzczZqOTVCUDBlb0cxbkhBc1BBanBhRStZdmRqelFrTmRo?=
 =?utf-8?B?aFNUR0JqZ2N2STg4OUw5R0QyMC9PSHRGQmNwR253ZzZ6VlU3UXZxR3BDMVpT?=
 =?utf-8?B?RUJxcWxCbXNSeGZ6RDI4dEEydkhoNWYxMlpGNjJGNmxtQ0ZIVlBQZ1FLanUy?=
 =?utf-8?B?YXQxT09jbkN4MGZoTVZaZXFQQklYYURIdnFmTTMvWWxydVNLTFlDeWVtUTRq?=
 =?utf-8?B?amQxbGllV1dwVENERjFBTCtKb2pCSzg1K0UzYm1JaE01MGl4UGhLNllTSU0y?=
 =?utf-8?B?SW1tVFp5UUQ1ZWNjUUJlUFJwbGlDNmFtU0V6MnRWYkpkUmVwMTM2OVM4ME52?=
 =?utf-8?B?SmxlWVVPVVFpYUJ4L1pQVWl3WXhLUlhkNFZDYjM3RjRTc1ZzbGYwTldHTFJQ?=
 =?utf-8?B?MTZKUDJsTnUvemZ4ZHh6eDVwSTFxVXNlZ0RVSHFqOGo4bEo3Q1lSemc5S3F6?=
 =?utf-8?B?OE5hMGVWRU13OE1teWhmM3RscElIby8rSHdUamxsbis2MUZuMTZTWTBJbVV0?=
 =?utf-8?B?UkVJbXBCZDNiUkU5SlJZMk1EMDlpWDUyTnUwQktLWXYyMTlOUlIyNWVTYkV3?=
 =?utf-8?B?YUFTL0NxODZjQytwc2NHbnkra0Fpb0JoVDQ0eHlmVE91UnRTcmNZYkZ1KzhH?=
 =?utf-8?B?eE0xS1VweUlsanpaZ040OXpJQmM0cm80V2Y1dFVUNk56VGtXWngyajIvM09J?=
 =?utf-8?B?akc0ZlhDTkJGVWswUjdsUWVVRGRvN0dXU2NycFlkNXUvTDQ4RmZlMEFaK0Q0?=
 =?utf-8?B?SzN0ZkdWdTlOR1hNcU9WMmRGZFI4ZmJKcm4zWk1IN0FqaG1jcFNObjNyRGVP?=
 =?utf-8?B?Z2wzZTA3S1EzTHd5bGdxMDgzNDJQeVlzVlZWdlFrdlFEdWMxak5zV1hxL2ln?=
 =?utf-8?B?djl1a1AreFMycHVSTHphcVJZYzJxN1Z5Q2c4N0NjOGExbDN6cnVaR2w1c0R0?=
 =?utf-8?B?MkE4U1JXM1lsaGJlUnFuV0RoSkdjSzA1dnd1VmxVRVVycjg4Mm82bDRNQjh4?=
 =?utf-8?B?cCtxaklrelJhelpQQnpydkVGVFF4T1g4enZxSDV4b1hUTG1rZEsyVCt3NzQr?=
 =?utf-8?B?YUZxM3dwTU0vLys1alh0eDFndlowSUN1RUplVFBUYjNpczM2d203RFVZUCtE?=
 =?utf-8?B?b2NEa25BRlc2bG9JdFlhUnV2RmxQaXFjSHBwMEVOOWZXZXQ3T2VBbjJBMTha?=
 =?utf-8?Q?0w3UpLOvCeMVhIZnODEks9T7bxcu469QY5M3h?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb4800b-1d23-4a1b-bead-08da4aba591b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 08:22:24.7897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Q+gC8j1Ex+I0o+QRuyflEEIIYTrwDUCJxQPvsUf00tMKa2KLBm8CQysZMZAb9D7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7384
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/10 14:09, Qu Wenruo wrote:
> Although function write_dev_supers() will report error, it only report
> things like failed to grab the page, all those errors before we submit
> the bio.
> 
> But if our bio really failed, due to real IO error, we just set the page
> error, output an error message, and call it a day.
> 
> This makes btrfs to completely ignore super block writeback error.
> 
> Thankfully, this is not that a big deal, as normally we should got error
> when flushing the device before we reached super block writeback.
> 
> Anyway we should make write_dev_supers() to include the IO errors.
> 
> This patch will enhance the error reporting by:
> 
> - Introduce a new on-stack structure to record all errors including IO
>    errors
>    The new strucuture, super_block_io_status, will have a wait queue and
>    accounting for flying bios along with errors we hit so far.
> 
> - Output a human readable error message
>    Instead of something like:
> 
>     lost page write due to IO error on dm-1 (-5)
> 
>    Now we will have:
> 
>     failed to write super block at 65536 on dm-1 (-5)
> 
> - Wait for all super block IO finished before returning
>    write_dev_supers()
>    So now write_dev_supers() will wait for all flying bios to finish, and
>    use real number of errors to determine if the write failed.

My bad, I didn't check the later wait_dev_supers() call, which uses 
PageError to detect if our previous write failed.

So please drop this patch.

Although it looks like we don't even need to bother the parallel 
submission, since in super block writeback, we're already in 
TRANS_STATE_UNBLOCKED status, thus we're fine to do the work in serial.

Thanks,
Qu
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/disk-io.c | 54 ++++++++++++++++++++++++++++++++++------------
>   1 file changed, 40 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 800ad3a9c68e..9ed88a921465 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3864,9 +3864,21 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>   }
>   ALLOW_ERROR_INJECTION(open_ctree, ERRNO);
>   
> +struct super_block_io_status {
> +	struct btrfs_device *device;
> +	wait_queue_head_t wait;
> +
> +	/* Pending sb bios. */
> +	atomic_t pending;
> +
> +	/* Total errors, including both primary and backup sb writeback errors. */
> +	atomic_t errors;
> +};
> +
>   static void btrfs_end_super_write(struct bio *bio)
>   {
> -	struct btrfs_device *device = bio->bi_private;
> +	struct super_block_io_status *sbios = bio->bi_private;
> +	struct btrfs_device *device = sbios->device;
>   	struct bio_vec *bvec;
>   	struct bvec_iter_all iter_all;
>   	struct page *page;
> @@ -3875,21 +3887,29 @@ static void btrfs_end_super_write(struct bio *bio)
>   		page = bvec->bv_page;
>   
>   		if (bio->bi_status) {
> +			struct btrfs_super_block *sb;
> +			void *addr;
> +			u64 bytenr;
> +
> +			addr = kmap_local_page(page) + bvec->bv_offset;
> +			sb = addr;
> +			bytenr = btrfs_super_bytenr(sb);
> +			kunmap_local(addr);
> +
> +
> +			atomic_inc(&sbios->errors);
>   			btrfs_warn_rl_in_rcu(device->fs_info,
> -				"lost page write due to IO error on %s (%d)",
> -				rcu_str_deref(device->name),
> +				"failed to write super block at %llu on %s (%d)",
> +				bytenr, rcu_str_deref(device->name),
>   				blk_status_to_errno(bio->bi_status));
> -			ClearPageUptodate(page);
> -			SetPageError(page);
>   			btrfs_dev_stat_inc_and_print(device,
>   						     BTRFS_DEV_STAT_WRITE_ERRS);
> -		} else {
> -			SetPageUptodate(page);
>   		}
> -
>   		put_page(page);
>   		unlock_page(page);
>   	}
> +	atomic_dec(&sbios->pending);
> +	wake_up(&sbios->wait);
>   
>   	bio_put(bio);
>   }
> @@ -3975,9 +3995,9 @@ static int write_dev_supers(struct btrfs_device *device,
>   {
>   	struct btrfs_fs_info *fs_info = device->fs_info;
>   	struct address_space *mapping = device->bdev->bd_inode->i_mapping;
> +	struct super_block_io_status sbios = {.device = device};
>   	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>   	int i;
> -	int errors = 0;
>   	int ret;
>   	u64 bytenr, bytenr_orig;
>   
> @@ -3986,6 +4006,10 @@ static int write_dev_supers(struct btrfs_device *device,
>   
>   	shash->tfm = fs_info->csum_shash;
>   
> +	atomic_set(&sbios.pending, 0);
> +	atomic_set(&sbios.errors, 0);
> +	init_waitqueue_head(&sbios.wait);
> +
>   	for (i = 0; i < max_mirrors; i++) {
>   		struct page *page;
>   		struct bio *bio;
> @@ -3999,7 +4023,7 @@ static int write_dev_supers(struct btrfs_device *device,
>   			btrfs_err(device->fs_info,
>   				"couldn't get super block location for mirror %d",
>   				i);
> -			errors++;
> +			atomic_inc(&sbios.errors);
>   			continue;
>   		}
>   		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
> @@ -4018,7 +4042,7 @@ static int write_dev_supers(struct btrfs_device *device,
>   			btrfs_err(device->fs_info,
>   			    "couldn't get super block page for bytenr %llu",
>   			    bytenr);
> -			errors++;
> +			atomic_inc(&sbios.errors);
>   			continue;
>   		}
>   
> @@ -4028,6 +4052,7 @@ static int write_dev_supers(struct btrfs_device *device,
>   		disk_super = page_address(page);
>   		memcpy(disk_super, sb, BTRFS_SUPER_INFO_SIZE);
>   
> +		atomic_inc(&sbios.pending);
>   		/*
>   		 * Directly use bios here instead of relying on the page cache
>   		 * to do I/O, so we don't lose the ability to do integrity
> @@ -4037,7 +4062,7 @@ static int write_dev_supers(struct btrfs_device *device,
>   				REQ_OP_WRITE | REQ_SYNC | REQ_META | REQ_PRIO,
>   				GFP_NOFS);
>   		bio->bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
> -		bio->bi_private = device;
> +		bio->bi_private = &sbios;
>   		bio->bi_end_io = btrfs_end_super_write;
>   		__bio_add_page(bio, page, BTRFS_SUPER_INFO_SIZE,
>   			       offset_in_page(bytenr));
> @@ -4054,9 +4079,10 @@ static int write_dev_supers(struct btrfs_device *device,
>   		submit_bio(bio);
>   
>   		if (btrfs_advance_sb_log(device, i))
> -			errors++;
> +			atomic_inc(&sbios.errors);
>   	}
> -	return errors < i ? 0 : -1;
> +	wait_event(sbios.wait, atomic_read(&sbios.pending) == 0);
> +	return atomic_read(&sbios.errors) < i ? 0 : -EIO;
>   }
>   
>   /*
