Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CC46F1D4F
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 19:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345398AbjD1RVc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Apr 2023 13:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjD1RVb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Apr 2023 13:21:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A292D63;
        Fri, 28 Apr 2023 10:21:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0047F21F58;
        Fri, 28 Apr 2023 17:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682702489;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=otosx9HrW79cjY7RkW4xJExHEdLlgnwAWiEQcwOfVJo=;
        b=kFV4lVESW5Xvv+scmP3PlO69aNheaKAReDiRV1KaGlrOAw6Sfcueyb9p9hHTCGC7nceb6p
        dWf2iQyv0G6C1L2zjpS0YprVdeRFF+95AcLmRHw2ZGpoJ3n/yjKAZfDyR6fpQASlKq4/T7
        oTm4ALAOMWZffbv83zYgtO8tZNjBEgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682702489;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=otosx9HrW79cjY7RkW4xJExHEdLlgnwAWiEQcwOfVJo=;
        b=x7569MP2CkLRpK8ZUuDG1Y0dBsAoqOa4eFfWSIX3Adak8DtluiwJVHVsJ7cVFVGnY8G7iK
        +GvFcrhZlf8YrzDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD9911390E;
        Fri, 28 Apr 2023 17:21:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F84+MZgATGQWFQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 28 Apr 2023 17:21:28 +0000
Date:   Fri, 28 Apr 2023 19:15:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: avoid crash if scrub is trying to do
 recovery for a removed block group
Message-ID: <20230428171535.GF2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <45841a7e90525bf1efa2324ab9d80aeb9e20457c.1682477110.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45841a7e90525bf1efa2324ab9d80aeb9e20457c.1682477110.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 26, 2023 at 10:45:59AM +0800, Qu Wenruo wrote:
> [BUG]
> Syzbot reported an ASSERT() got triggered during a scrub repair along
> with balance:
> 
>  BTRFS info (device loop5): balance: start -d -m
>  BTRFS info (device loop5): relocating block group 6881280 flags data|metadata
>  BTRFS info (device loop5): found 3 extents, stage: move data extents
>  BTRFS info (device loop5): scrub: started on devid 1
>  BTRFS info (device loop5): relocating block group 5242880 flags data|metadata
>  BTRFS info (device loop5): found 6 extents, stage: move data extents
>  BTRFS info (device loop5): found 1 extents, stage: update data pointers
>  BTRFS warning (device loop5): tree block 5500928 mirror 1 has bad bytenr, has 0 want 5500928
>  BTRFS info (device loop5): balance: ended with status: 0
>  BTRFS warning (device loop5): tree block 5435392 mirror 1 has bad bytenr, has 0 want 5435392
>  BTRFS warning (device loop5): tree block 5423104 mirror 1 has bad bytenr, has 0 want 5423104
>  assertion failed: 0, in fs/btrfs/scrub.c:614
>  ------------[ cut here ]------------
>  kernel BUG at fs/btrfs/messages.c:259!
>  invalid opcode: 0000 [#2] PREEMPT SMP KASAN
>  Call Trace:
>    <TASK>
>    lock_full_stripe fs/btrfs/scrub.c:614 [inline]
>    scrub_handle_errored_block+0x1ee1/0x4730 fs/btrfs/scrub.c:1067
>    scrub_bio_end_io_worker+0x9bb/0x1370 fs/btrfs/scrub.c:2559
>    process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2390
>    worker_thread+0xa63/0x1210 kernel/workqueue.c:2537
>    kthread+0x270/0x300 kernel/kthread.c:376
>    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>    </TASK>
> 
> [CAUSE]
> Btrfs can delete empty block groups either through auto-cleanup or
> relcation.
> 
> Scrub normally is able to handle this situation well by doing extra
> checking, and holding the block group cache pointer during the whole
> scrub lifespan.
> 
> But unfortunately for lock_full_stripe() and unlock_full_stripe()
> functions, due to the context restriction, they have to do an extra
> search on the block group cache.
> (While the main scrub threads holds a proper btrfs_block_group, but we
> have no way to directly use that in repair context).
> 
> Thus it can happen that the target block group is already deleted by
> relocation.
> 
> In that case, we trigger the above ASSERT().
> 
> [FIX]
> Instead of triggering the ASSERT(), let's just return 0 and continue,
> this would leave @locked_ret to be false, and we won't try to unlock
> later.
> 
> CC: stable@vger.kernel.org
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> There would be no upstream commit, as upstream has completely rewritten
> the scrub code in v6.4 merge window, and gets rid of the
> lock_full_stripe()/unlock_full_stripe() functions.

I think we can explain and justify such change:

- there's a report and reproducer, so this is an existing problem

- it's a short diff

- we should do extra testing of the stable trees + this patch before
  submitting

> I hope we don't have more scrub fixes which would only apply to older
> kernels.

We'll handle that case by case, fixing problems in old stable tree is
desirable. Patches without an exact corresponding upstream commit should
be rare but with rewrites this could happen.

> ---
>  fs/btrfs/scrub.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 69c93ae333f6..43d0613c0dd3 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -610,10 +610,9 @@ static int lock_full_stripe(struct btrfs_fs_info *fs_info, u64 bytenr,
>  
>  	*locked_ret = false;
>  	bg_cache = btrfs_lookup_block_group(fs_info, bytenr);
> -	if (!bg_cache) {
> -		ASSERT(0);

I like the using ASSERT(0) less and less each time I see it. We now have
about 33 of them and it looks like a misuse. It's a BUG() in disguise.
We should handle the error properly, either return a code and let
callers handle it or return -EUCLEAN if it's an unrepairable condition.
Assertions should be for code invariants, API misuse prevention, not for
error handling.
