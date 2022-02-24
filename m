Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A26E4C2DF5
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 15:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbiBXOND (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 09:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbiBXOMz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 09:12:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6779E163D4F
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 06:12:25 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F3EBD2114E;
        Thu, 24 Feb 2022 14:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645711944;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DuVAARN+rn8/P7fpNr+20XENignxFnJmVQqxfROj5nw=;
        b=GsAIykZpuDdNIqf36pz8GUl0CUtHd9q5lajvpSkIEpCQilkKsgJg5u0+34dMcqVWgpF9Vy
        UQZUFW8bXmQMLz5DyvXL6ttzQykcG1wPgxvUvGssfpBgH43dHCQoffNk9ALqdeKeDno9qH
        ht1xhCG5ne5YlKlqfoCyRG1JdYPxtqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645711944;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DuVAARN+rn8/P7fpNr+20XENignxFnJmVQqxfROj5nw=;
        b=guY9gbWxP/OO25YcS8/On3WpkC/grfGqrrat5cA+hV+r8m+AR9zDh9JY/V1FNm76T3dC3a
        E5kaLaRH05Ztn2BQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EB6A7A3B83;
        Thu, 24 Feb 2022 14:12:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 09AEDDA818; Thu, 24 Feb 2022 15:08:34 +0100 (CET)
Date:   Thu, 24 Feb 2022 15:08:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: do not WARN_ON() if we have PageError set
Message-ID: <20220224140834.GT12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <d6f76c251fa224e4987129a0ea15ae77a6a052c1.1645197372.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6f76c251fa224e4987129a0ea15ae77a6a052c1.1645197372.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 18, 2022 at 10:17:39AM -0500, Josef Bacik wrote:
> Whenever we do any extent buffer operations we call
> assert_eb_page_uptodate() to complain loudly if we're operating on an
> non-uptodate page.  Our overnight tests caught this warning earlier this
> week
> 
> WARNING: CPU: 1 PID: 553508 at fs/btrfs/extent_io.c:6849 assert_eb_page_uptodate+0x3f/0x50
> CPU: 1 PID: 553508 Comm: kworker/u4:13 Tainted: G        W         5.17.0-rc3+ #564
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> Workqueue: btrfs-cache btrfs_work_helper
> RIP: 0010:assert_eb_page_uptodate+0x3f/0x50
> RSP: 0018:ffffa961440a7c68 EFLAGS: 00010246
> RAX: 0017ffffc0002112 RBX: ffffe6e74453f9c0 RCX: 0000000000001000
> RDX: ffffe6e74467c887 RSI: ffffe6e74453f9c0 RDI: ffff8d4c5efc2fc0
> RBP: 0000000000000d56 R08: ffff8d4d4a224000 R09: 0000000000000000
> R10: 00015817fa9d1ef0 R11: 000000000000000c R12: 00000000000007b1
> R13: ffff8d4c5efc2fc0 R14: 0000000001500000 R15: 0000000001cb1000
> FS:  0000000000000000(0000) GS:ffff8d4dbbd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff31d3448d8 CR3: 0000000118be8004 CR4: 0000000000370ee0
> Call Trace:
> 
>  extent_buffer_test_bit+0x3f/0x70
>  free_space_test_bit+0xa6/0xc0
>  load_free_space_tree+0x1f6/0x470
>  caching_thread+0x454/0x630
>  ? rcu_read_lock_sched_held+0x12/0x60
>  ? rcu_read_lock_sched_held+0x12/0x60
>  ? rcu_read_lock_sched_held+0x12/0x60
>  ? lock_release+0x1f0/0x2d0
>  btrfs_work_helper+0xf2/0x3e0
>  ? lock_release+0x1f0/0x2d0
>  ? finish_task_switch.isra.0+0xf9/0x3a0
>  process_one_work+0x26d/0x580
>  ? process_one_work+0x580/0x580
>  worker_thread+0x55/0x3b0
>  ? process_one_work+0x580/0x580
>  kthread+0xf0/0x120
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x1f/0x30
> 
> This was partially fixed by c2e39305299f01 ("btrfs: clear extent buffer
> uptodate when we fail to write it"), however all that fix did was keep
> us from finding extent buffers after a failed writeout.  It didn't keep
> us from continuing to use a buffer that we already had found.
> 
> In this case we're searching the commit root to cache the block group,
> so we can start committing the transaction and switch the commit root
> and then start writing.  After the switch we can look up an extent
> buffer that hasn't been written yet and start processing that block
> group.  Then we fail to write that block out and clear Uptodate on the
> page, and then we start spewing these errors.
> 
> Normally we're protected by the tree lock to a certain degree here.  If
> we read a block we have that block read locked, and we block the writer
> from locking the block before we submit it for the write.  However this
> isn't necessarily fool proof because the read could happen before we do
> the submit_bio and after we locked and unlocked the extent buffer.
> 
> Also in this particular case we have path->skip_locking set, so that
> won't save us here.  We'll simply get a block that was valid when we
> read it, but became invalid while we were using it.
> 
> What we really want is to catch the case where we've "read" a block but
> it's not marked Uptodate.  On read we ClearPageError(), so if we're
> !Uptodate and !Error we know we didn't do the right thing for reading
> the page.
> 
> Fix this by checking !Uptodate && !Error, this way we will not complain
> if our buffer gets invalidated while we're using it, and we'll maintain
> the spirit of the check which is to make sure we have a fully in-cache
> block while we're messing with it.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v1->v2:
> - Dropped the patch that didn't set PageError() when we failed to read.  I
>   misread the code and every other file system does this, and I don't want to
>   break some weird assumption.  So instead just do this patch to catch us
>   invalidating the page while we're looking at it.

Added to misc-next, thanks.
