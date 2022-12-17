Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FD864F605
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Dec 2022 01:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiLQAXH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 19:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiLQAWk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 19:22:40 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F58EAA
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 16:16:52 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZkpR-1pRdHc0o6x-00Wn4p; Sat, 17
 Dec 2022 01:16:47 +0100
Message-ID: <a5931050-7bc6-ff64-2496-79f658d52c1b@gmx.com>
Date:   Sat, 17 Dec 2022 08:16:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/8] btrfs: fix uninit warning in btrfs_update_block_group
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1671221596.git.josef@toxicpanda.com>
 <87302b559838af285024d47b3b738ef36ad0ebe4.1671221596.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <87302b559838af285024d47b3b738ef36ad0ebe4.1671221596.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:gqnMWXRldOh73+kg89djawA6nDxkMSxOIjdhcCiVN9JYdQvLdw3
 jWal37EFMoBPIdcoWMcPNqLvh4cPPW4dd+pWBViEuqY3HCVYwx1fHGyUAu3kJrEQlwN6Yag
 aVBwLQZY2+ixhX86WJJRJqOS7UB1BkFS7CRNfrmK3N2EONmnbmXf7uXwBQKzuLclUZaLHVJ
 tGwHc6NQ8gwN/7RxE0E5Q==
UI-OutboundReport: notjunk:1;M01:P0:2+Z3J+a1fOE=;O31Fws6YxSjH+pLXuFw44sx0r9i
 RLLDyuM9KFZi/cPHtpegtJ3leOXVItALciaRhdGGaD3vw7XS+EeD5IccJxqW1lZL+JREogWd2
 uL4lHfHex3qh4yqfL2dfY4yKmWkMgFY3kBJyomFjFIObEFZLeKlJGJTu2fRly5qFAx/tUSQaj
 YvKJ9Gfwhp0llWvCB5WLR1NrGeChLVMV6FLJqiDsBDp/0HnQudXnL1jnUbmsBiN5LIjXkuosl
 pEsb9SMtr0qPAphNjZOozKdcvvZ0MbbGrPRc31XRKuZtSLpG9s79fAZj94OXjclnK6Emd5LCq
 Aiy4I2Vlw0wsrikWwXOvr+xKK9ZzulUKBs0HIcQZWf4QdrxQOfyZLlAmd3zzhLr5pvchsVLrJ
 qCrNm0R8S5ym7XEfFgUzQ9kk4wvFrxTc2qZ0c8d+JqfRqZuqEoLjGhjtTifv2EXup6W1+67AC
 N87zPB0slkor/GRv7pb5+u9OSrZ0kFzM0+AyEDfXkP3IqT4WyFkzhtgbdCJoyT5kIewnDqtjs
 /qHm63PgHLRGOi9sXaNI87DK93UPUdZFD4lX6KyfmNUUmI1VsSh9tte1ETHDMo0m9A9SSbfcA
 xLTHqWcDlJjELimeFmIT+LpQi2GaDwcGAH9UG6/DJqSY4Wz8ddBDCriYUJljiKlPxHBPyXYAg
 XAFzYlD9RJVKV+EZTQHqiAfVa7ng+5fUm7prdnZde73lHkqELkcqg/TwEhNMmgTRPPaMJnh/w
 LrYFDylxybpxvLegoOgyN9NXqS8dlDjXW9iGIchS4+BdBPzPk/9uufgESozUcw/KP6j6LsBfP
 FFY++NMhxNwWwIoh/whLEOLvCuXgvm8eg19nTj1ZTxjCx0rH6AiSxpMOAvqQ4Y7KaHZNzhg1l
 5SBSsZYSDNDjfZ9hHJ+weKZIhSg9iHc3qI2Vw9xKCWwkGMTSN3xsTJQQEsymVY5TeiZuCJdta
 bN9zQg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/17 04:15, Josef Bacik wrote:
> reclaim isn't set in the alloc case, however we only care about reclaim
> in the !alloc case.  This isn't an actual problem, however
> -Wmaybe-uninitialized will complain, so initialize reclaim to quiet the
> compiler.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/block-group.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 708d843daa72..e90800388a41 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -3330,7 +3330,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
>   	spin_unlock(&info->delalloc_root_lock);
>   
>   	while (total) {
> -		bool reclaim;
> +		bool reclaim = false;
>   
>   		cache = btrfs_lookup_block_group(info, bytenr);
>   		if (!cache) {
