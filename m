Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F34777ADD
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 16:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbjHJOhN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Aug 2023 10:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbjHJOhM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Aug 2023 10:37:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F056F2684
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Aug 2023 07:37:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B188E1F86A;
        Thu, 10 Aug 2023 14:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691678230;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=75W/kDG8t2Ay621WNjDSFY79gJ6QCfHl34Bzlgoospc=;
        b=PHVRULvmUa8iKGfwlQ3iVVPiemUXS2n3AAD4MH5RoDdIN15CYThFOcytwr/ILM6l/zoj34
        rss4RAhWpm4kimC1Pxivq42GVbC2q8Tvcq+IKorV41fuEGUBYruRzONRRFRVrJzmiwwABf
        2ftvA2JTHW8GgKZ11UvASaTiMaHzLXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691678230;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=75W/kDG8t2Ay621WNjDSFY79gJ6QCfHl34Bzlgoospc=;
        b=jyaT+crXW58ZCuHUruz5M5E+fVeW84RQ3VkNH3TLYLDKVneSBOXqofFLjwxM4VxvhcvPXM
        xF/XruFyhcDvMKDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D13A138E0;
        Thu, 10 Aug 2023 14:37:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lYehHRb21GTLCQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 10 Aug 2023 14:37:10 +0000
Date:   Thu, 10 Aug 2023 16:30:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: wait on uncached block groups on every allocation
 loop
Message-ID: <20230810143045.GD2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <37333ca86d431906b58093d1700f0cfdbc57fa2c.1690835309.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37333ca86d431906b58093d1700f0cfdbc57fa2c.1690835309.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 31, 2023 at 04:28:43PM -0400, Josef Bacik wrote:
> My initial fix for the generic/475 hangs was related to metadata, but
> our CI testing uncovered another case where we hang for similar reasons.
> We again have a task with a plug that is holding an outstanding request
> that is keeping the dm device from finishing it's suspend, and that task
> is stuck in the allocator.
> 
> This time it is stuck trying to allocate data, but we do not have a
> block group that matches the size class.  The larger loop in the
> allocator looks like this (simplified of course)
> 
> find_free_extent
>   for_each_block_group {
>     ffe_ctl->cached == btrfs_block_group_cache_done(bg)
>     if (!ffe_ctl->cached)
>       ffe_ctl->have_caching_bg = true;
>     do_allocation()
>       btrfs_wait_block_group_cache_progress();
>   }
> 
>   if (loop == LOOP_CACHING_WAIT && ffe_ctl->have_caching_bg)
>     go search again;
> 
> In my earlier fix we were trying to allocate from the block group, but
> we weren't waiting for the progress because we were only waiting for the
> free space to be >= the amount of free space we wanted.  My fix made it
> so we waited for forward progress to be made as well, so we would be
> sure to wait.
> 
> This time however we did not have a block group that matched our size
> class, so what was happening was this
> 
> find_free_extent
>   for_each_block_group {
>     ffe_ctl->cached == btrfs_block_group_cache_done(bg)
>     if (!ffe_ctl->cached)
>       ffe_ctl->have_caching_bg = true;
>     if (size_class_doesn't_match())
>       goto loop;
>     do_allocation()
>       btrfs_wait_block_group_cache_progress();
> loop:
>     release_block_group(block_group);
>   }
> 
>   if (loop == LOOP_CACHING_WAIT && ffe_ctl->have_caching_bg)
>     go search again;
> 
> The size_class_doesn't_match() part was true, so we'd just skip this
> block group and never wait for caching, and then because we found a
> caching block group we'd just go back and do the loop again.  We never
> sleep and thus never flush the plug and we have the same deadlock.
> 
> Fix the logic for waiting on the block group caching to instead do it
> unconditionally when we goto loop.  This takes the logic out of the
> allocation step, so now the loop looks more like this
> 
> find_free_extent
>   for_each_block_group {
>     ffe_ctl->cached == btrfs_block_group_cache_done(bg)
>     if (!ffe_ctl->cached)
>       ffe_ctl->have_caching_bg = true;
>     if (size_class_doesn't_match())
>       goto loop;
>     do_allocation()
>       btrfs_wait_block_group_cache_progress();
> loop:
>     if (loop > LOOP_CACHING_NOWAIT && !ffe_ctl->retry_uncached &&
>         !ffe_ctl->cached) {
>        ffe_ctl->retry_uncached = true;
>        btrfs_wait_block_group_cache_progress();
>     }
> 
>     release_block_group(block_group);
>   }
> 
>   if (loop == LOOP_CACHING_WAIT && ffe_ctl->have_caching_bg)
>     go search again;
> 
> This simplifies the logic a lot, and makes sure that if we're hitting
> uncached block groups we're always waiting on them at some point.
> 
> I ran this through 100 iterations of generic/475, as this particular
> case was harder to hit than the previous one.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
