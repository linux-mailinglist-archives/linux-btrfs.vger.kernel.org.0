Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EA26748D6
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jan 2023 02:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjATBa5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 20:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjATBa4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 20:30:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03B94F355
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 17:30:54 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUosN-1p9VI62WC9-00QgVQ; Fri, 20
 Jan 2023 02:30:48 +0100
Message-ID: <b5ddc5cd-fdf3-76f4-56cf-66f27fff65cf@gmx.com>
Date:   Fri, 20 Jan 2023 09:30:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1674164991.git.josef@toxicpanda.com>
 <ff064f6f4cf17cc5eafc127dadfc3474d46869ad.1674164991.git.josef@toxicpanda.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 1/9] btrfs: do not call btrfs_clean_tree_block in
 update_ref_for_cow
In-Reply-To: <ff064f6f4cf17cc5eafc127dadfc3474d46869ad.1674164991.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:wWBWZTQJUI1+Jj11FJHMUhvx4htLxASMGJoBgNLhL/KM0c7txk3
 vleu6LDqq1laf6AmEoa56mM9Ejn1f/NhgzGq56W+S07/wvZn0agxK6YceTEUAKStd5Qv2s4
 hImrKU94UwBm1XILPjxJYkC2IIVrpVGCcR9krrFfF8E3P1uLqZjFtNPQkzhfPTJPC8ptJEO
 Mlzd03kD9AjflAZgYT6Dw==
UI-OutboundReport: notjunk:1;M01:P0:zidQslC/3bs=;b5I30fTHgt7iJheaxQGtPzHNTDr
 WBiGFfVB88pVCaV6o5F43oQxzOXGOUXE+X1DiprAXFQVIDDJCK4KqbhD3haPvfpu3I1KZVBfi
 MP5uPSANqpmbutLfoHrcv4goOE2wSbB9SGb1bH2UtXqJz+u4J/IQ9HTiWPrcibNEudtglO8Vo
 v+K8oKcInxAQbh85dqv5SdFoO1Bnju4Aqqqgjb4cRpPp2eXeKMPnrAFsfQc9LUvvlXRMZ3y4D
 utFrdTth8N+UmQAOsiEeCHbnbsp5zyX0xnWDg2K+dB32qe9ng9pSaBIQMc2fPJCMsOL67ozvR
 TLBO96a/5/pYVL9scArmz7Rj+nnoqhEk3o3kmQ/g00lV1LCICdBh+xRTlEu2hlse/JP5VFFtx
 8eJpvZwZ5Fjazg1FVMm6+7kzYI7GFKtyTb+oEuOuCOtUCKiIrcLkTxXVwVU1lwpGRKVyUqhQ0
 MvdkJVJYYFKahYB7AYnourYg6xojXV9zGzs6CHW5bL4kxtr5Vbsg9S0Ndzv2qJuEQ3xtQlcCT
 c2bCgTe0CDSaTL2pWzRjkC1sQwULh47NaktdCZpJUubHlc7XJyWzLn+74IuY115eovWP3VKfR
 WSAVlNVlH6MHzCTYj/sTp18aZ+Z3w482e0d4JyJaKF9YjI3svzP2gu33fsM+V1IMOYu9/hz1z
 6bDzkaOBnrq2DRnHpOOJRwjww2HhTwXfUbAgr6+kAXqweBn/12STU1EKoy7FMBnbIpLYa0IFE
 v0joIqW1cApWbzfyBthcHF4E41/nXFL8XUV5GUQnshRnuMWqf4+dlGD3ohg11wuQpVR8TUCgs
 loIo8RwiC3Un6q41jKZFrV6vGVyiDSoGLYk//vx0zmLSOG38XkNJaNpY97rcml75qwPs0RBz/
 OCj58xKXC2N842HzIU2cZL0ICrLKgEm4lahasGDbvMfIz3VhQ4FH6DhVE5X4Tr9RlrWvRKVcL
 rlrLnjrX/MpedtPUQEu7dU8WcBo=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/20 05:53, Josef Bacik wrote:
> My series cleaning up the btrfs_clean_tree_block usage uncovered a
> pretty nasty problem, we weren't writing out metadata that was getting
> cow'ed away before the transaction commit was able to write out the
> block.
> 
> This was because I changed btrfs_clean_tree_block() to unconditionally
> clear the EXTENT_BUFFER_DIRTY flag, whereas before it was only doing it
> if the header generation == the transid of the currently running
> transaction.  This check exists purely for update_ref_for_cow's benefit,
> as we only really want to call this when we're sure we won't use the
> block again.  In the case of update_ref_for_cow() we're only truly
> wanting to avoid using the block if we're in the same transaction that
> dirtied it originally.  However we only get into update_ref_for_cow()
> with refs == 1 if we already wrote the block to disk via memory pressure
> or something, which means we won't have EXTENT_BUFFER_DIRTY set anyway.
> 
> Remove this usage in update_ref_for_cow(), as it doesn't make sense, and
> is actually harmful with my other cleanups.  We want to reserve the use
> of this function for when we free a block in the current transaction,
> like with delete's or balances.

Reviewed-by: Qu Wenruo <wqu@suse.com>


To my understand and most part of update_ref_for_cow(), we really only 
need to inc/dec refs for a tree block when doing regular COW.

Thus this patch looks good to me.

But this also means, btrfs_clean_tree_block() should really only be 
called for tree blocks that got emptied (mostly by tree operations).

In that case, can we add an extra ASSERT() on btrfs_clean_tree_block() 
to make sure it's really empty?

Thanks,
Qu

> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/ctree.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 5476d90a76ce..ac33dbb08263 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -459,7 +459,6 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
>   			if (ret)
>   				return ret;
>   		}
> -		btrfs_clean_tree_block(buf);
>   		*last_ref = 1;
>   	}
>   	return 0;
