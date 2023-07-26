Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC323763DD7
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 19:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjGZRl0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 13:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjGZRlZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 13:41:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CA826A0
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 10:41:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CCC761F385;
        Wed, 26 Jul 2023 17:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690393282;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BrNi3zV7Zr1Y5zj3MrIsbzxjksI0g/8VRcgXSZY9UGs=;
        b=bjuHcOPtmg0rnMS52LFFtaFJpJjcGs/GMwpQxhi5bQr7nPl2oeo/scF2hwqTlz1FrvfLP1
        WLqwlitQOmVSjwm5rLCHuZMzK15lZgRvf2RyNvyujubedvdRU3yXTEmTcLqYzd0xGJQrQw
        zRzUM1V2i1EUawQ7FosP+LMOsbsw3ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690393282;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BrNi3zV7Zr1Y5zj3MrIsbzxjksI0g/8VRcgXSZY9UGs=;
        b=mA6x/nwOh2ImoSrAYpgBruzgxSH9QKVIG5DjWw5bJIq25CmZl3qZZ/Bt99TeSxudMOMrB4
        AvUVl5VSVI2u0ZBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99A06139BD;
        Wed, 26 Jul 2023 17:41:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id suCQJMJawWTCaAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 26 Jul 2023 17:41:22 +0000
Date:   Wed, 26 Jul 2023 19:35:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: wait for actual caching progress during
 allocation
Message-ID: <20230726173501.GA23444@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5b2f035fed89ad01183916d606e5735ffc2cf9c1.1689970027.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b2f035fed89ad01183916d606e5735ffc2cf9c1.1689970027.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 21, 2023 at 04:09:43PM -0400, Josef Bacik wrote:
> Recently we've been having mysterious hangs while running generic/475 on
> the CI system.  This turned out to be something like this
> 
> Task 1
> dmsetup suspend --nolockfs
> -> __dm_suspend
>  -> dm_wait_for_completion
>   -> dm_wait_for_bios_completion
>    -> Unable to complete because of IO's on a plug in Task 2
> 
> Task 2
> wb_workfn
> -> wb_writeback
>  -> blk_start_plug
>   -> writeback_sb_inodes
>    -> Infinite loop unable to make an allocation
> 
> Task 3
> cache_block_group
> ->read_extent_buffer_pages
>  ->Waiting for IO to complete that can't be submitted because Task 1
>    suspended the DM device
> 
> The problem here is that we need Task 2 to be scheduled completely for
> the blk plug to flush.  Normally this would happen, we normally wait for
> the block group caching to finish (Task 3), and this schedule would
> result in the block plug flushing.
> 
> However if there's enough free space available from the current caching
> to satisfy the allocation we won't actually wait for the caching to
> complete.  This check however just checks that we have enough space, not
> that we can make the allocation.  In this particular case we were trying
> to allocate 9mib, and we had 10mib of free space, but we didn't have
> 9mib of contiguous space to allocate, and thus the allocation failed and
> we looped.
> 
> We specifically don't cycle through the FFE loop until we stop finding
> cached block groups because we don't want to allocate new block groups
> just because we're caching, so we short circuit the normal loop once we
> hit LOOP_CACHING_WAIT and we found a caching block group.
> 
> This is normally fine, except in this particular case where the caching
> thread can't make progress because the dm device has been suspended.
> 
> Fix this by not only waiting for free space to >= the amount of space we
> want to allocate, but also that we make some progress in caching from
> the time we start waiting.  This will keep us from busy looping when the
> caching is taking a while but still theoretically has enough space for
> us to allocate from, and fixes this particular case by forcing us to
> actually sleep and wait for forward progress, which will flush the plug.
> 
> With this fix we're no longer hanging with generic/475.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v1->v2:
> - Reworked the fix to just make sure we're waiting for forward progress on each
>   run through btrfs_wait_block_group_cache_progress() instead of further
>   complicating the free extent finding code.
> - Dropped the comments patch and the RAID patch.

Added to misc-next, thanks.
