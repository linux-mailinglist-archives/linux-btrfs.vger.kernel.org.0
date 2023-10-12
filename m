Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BF07C712E
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Oct 2023 17:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbjJLPPo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Oct 2023 11:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbjJLPPm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Oct 2023 11:15:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913F8CF
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 08:15:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E96421F88F;
        Thu, 12 Oct 2023 15:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697123737;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gjr0aLEaILrGfZxK5/43wqDDhLR28fzuLgG7AH94mgY=;
        b=3JyAa3z0MLX08tbi7uO/zuGpRSNmqMbBIBnHT4AxrqNFdZLzLaCSWKDhXR0Gj2cnu2b1vF
        Sq24DZwESxGugzljrl3dQPP1rhjFps3aSQz2q9Yh3f6r3Z9jhq7QOu6h/RyjRrKYnoFA70
        9LAKjHGP3lWjdqZkEa+jV5pf4SZeM/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697123737;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gjr0aLEaILrGfZxK5/43wqDDhLR28fzuLgG7AH94mgY=;
        b=9TXzkw029kU/LZxmt7o2uyeN3DMjoodfho91cQ2dIePGZWOg1it2CB0/zT9nD5X8o8v+lZ
        nvvPq0MRQAeZ5YDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CECC139F9;
        Thu, 12 Oct 2023 15:15:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DzGnHZkNKGU3LwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 12 Oct 2023 15:15:37 +0000
Date:   Thu, 12 Oct 2023 17:08:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix stripe length calculation for non-zoned data
 chunk allocation
Message-ID: <20231012150850.GH2211@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231007051421.19657-1-ce3g8jdj@umail.furryterror.org>
 <20231007051421.19657-2-ce3g8jdj@umail.furryterror.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007051421.19657-2-ce3g8jdj@umail.furryterror.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWO(0.00)[2];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 07, 2023 at 01:14:21AM -0400, Zygo Blaxell wrote:
> Commit f6fca3917b4d "btrfs: store chunk size in space-info struct"
> broke data chunk allocations on non-zoned multi-device filesystems when
> using default chunk_size.  Commit 5da431b71d4b "btrfs: fix the max chunk
> size and stripe length calculation" partially fixed that, and this patch
> completes the fix for that case.
> 
> After commit f6fca3917b4d and 5da431b71d4b, the sequence of events for
> a data chunk allocation on a non-zoned filesystem is:
> 
>         1.  btrfs_create_chunk calls init_alloc_chunk_ctl, which copies
>         space_info->chunk_size (default 10 GiB) to ctl->max_stripe_len
>         unmodified.  Before f6fca3917b4d, ctl->max_stripe_len value was
>         1 GiB for non-zoned data chunks and not configurable.
> 
>         2.  btrfs_create_chunk calls gather_device_info which consumes
>         and produces more fields of chunk_ctl.
> 
>         3.  gather_device_info multiplies ctl->max_stripe_len by
>         ctl->dev_stripes (which is 1 in all cases except dup)
>         and calls find_free_dev_extent with that number as num_bytes.
> 
>         4.  find_free_dev_extent locates the first dev_extent hole on
>         a device which is at least as large as num_bytes.  With default
>         max_chunk_size from f6fca3917b4d, it finds the first hole which is
>         longer than 10 GiB, or the largest hole if that hole is shorter
>         than 10 GiB.  This is different from the pre-f6fca3917b4d
>         behavior, where num_bytes is 1 GiB, and find_free_dev_extent
>         may choose a different hole.
> 
>         5.  gather_device_info repeats step 4 with all devices to find
>         the first or largest dev_extent hole that can be allocated on
>         each device.
> 
>         6.  gather_device_info sorts the device list by the hole size
>         on each device, using total unallocated space on each device to
>         break ties, then returns to btrfs_create_chunk with the list.
> 
>         7.  btrfs_create_chunk calls decide_stripe_size_regular.
> 
>         8.  decide_stripe_size_regular finds the largest stripe_len that
>         fits across the first nr_devs device dev_extent holes that were
>         found by gather_device_info (and satisfies other constraints
>         on stripe_len that are not relevant here).
> 
>         9.  decide_stripe_size_regular caps the length of the stripe it
>         computed at 1 GiB.  This cap appeared in 5da431b71d4b to correct
>         one of the other regressions introduced in f6fca3917b4d.
> 
>         10.  btrfs_create_chunk creates a new chunk with the above
>         computed size and number of devices.
> 
> At step 4, gather_device_info() has found a location where stripe up to
> 10 GiB in length could be allocated on several devices, and selected
> which devices should have a dev_extent allocated on them, but at step
> 9, only 1 GiB of the space that was found on each device can be used.
> This mismatch causes new suboptimal chunk allocation cases that did not
> occur in pre-f6fca3917b4d kernels.
> 
> Consider a filesystem using raid1 profile with 3 devices.  After some
> balances, device 1 has 10x 1 GiB unallocated space, while devices 2
> and 3 have 1x 10 GiB unallocated space, i.e. the same total amount of
> space, but distributed across different numbers of dev_extent holes.
> For visualization, let's ignore all the chunks that were allocated before
> this point, and focus on the remaining holes:
> 
>         Device 1:  [_] [_] [_] [_] [_] [_] [_] [_] [_] [_] (10x 1 GiB unallocated)
>         Device 2:  [__________] (10 GiB contig unallocated)
>         Device 3:  [__________] (10 GiB contig unallocated)
> 
> Before f6fca3917b4d, the allocator would fill these optimally by
> allocating chunks with dev_extents on devices 1 and 2 ([12]), 1 and 3
> ([13]), or 2 and 3 ([23]):
> 
>         [after 0 chunk allocations]
>         Device 1:  [_] [_] [_] [_] [_] [_] [_] [_] [_] [_] (10 GiB)
>         Device 2:  [__________] (10 GiB)
>         Device 3:  [__________] (10 GiB)
> 
>         [after 1 chunk allocation]
>         Device 1:  [12] [_] [_] [_] [_] [_] [_] [_] [_] [_]
>         Device 2:  [12] [_________] (9 GiB)
>         Device 3:  [__________] (10 GiB)
> 
>         [after 2 chunk allocations]
>         Device 1:  [12] [13] [_] [_] [_] [_] [_] [_] [_] [_] (8 GiB)
>         Device 2:  [12] [_________] (9 GiB)
>         Device 3:  [13] [_________] (9 GiB)
> 
>         [after 3 chunk allocations]
>         Device 1:  [12] [13] [12] [_] [_] [_] [_] [_] [_] [_] (7 GiB)
>         Device 2:  [12] [12] [________] (8 GiB)
>         Device 3:  [13] [_________] (9 GiB)
> 
>         [...]
> 
>         [after 12 chunk allocations]
>         Device 1:  [12] [13] [12] [13] [12] [13] [12] [13] [_] [_] (2 GiB)
>         Device 2:  [12] [12] [23] [23] [12] [12] [23] [23] [__] (2 GiB)
>         Device 3:  [13] [13] [23] [23] [13] [23] [13] [23] [__] (2 GiB)
> 
>         [after 13 chunk allocations]
>         Device 1:  [12] [13] [12] [13] [12] [13] [12] [13] [12] [_] (1 GiB)
>         Device 2:  [12] [12] [23] [23] [12] [12] [23] [23] [12] [_] (1 GiB)
>         Device 3:  [13] [13] [23] [23] [13] [23] [13] [23] [__] (2 GiB)
> 
>         [after 14 chunk allocations]
>         Device 1:  [12] [13] [12] [13] [12] [13] [12] [13] [12] [13] (full)
>         Device 2:  [12] [12] [23] [23] [12] [12] [23] [23] [12] [_] (1 GiB)
>         Device 3:  [13] [13] [23] [23] [13] [23] [13] [23] [13] [_] (1 GiB)
> 
>         [after 15 chunk allocations]
>         Device 1:  [12] [13] [12] [13] [12] [13] [12] [13] [12] [13] (full)
>         Device 2:  [12] [12] [23] [23] [12] [12] [23] [23] [12] [23] (full)
>         Device 3:  [13] [13] [23] [23] [13] [23] [13] [23] [13] [23] (full)
> 
> This allocates all of the space with no waste.  The sorting function used
> by gather_device_info considers free space holes above 1 GiB in length
> to be equal to 1 GiB, so once find_free_dev_extent locates a sufficiently
> long hole on each device, all the holes appear equal in the sort, and the
> comparison falls back to sorting devices by total free space.  This keeps
> usable space on each device equal so they can all be filled completely.
> 
> After f6fca3917b4d, the allocator prefers the devices with larger holes
> over the devices with more free space, so it makes bad allocation choices:
> 
>         [after 1 chunk allocation]
>         Device 1:  [_] [_] [_] [_] [_] [_] [_] [_] [_] [_] (10 GiB)
>         Device 2:  [23] [_________] (9 GiB)
>         Device 3:  [23] [_________] (9 GiB)
> 
>         [after 2 chunk allocations]
>         Device 1:  [_] [_] [_] [_] [_] [_] [_] [_] [_] [_] (10 GiB)
>         Device 2:  [23] [23] [________] (8 GiB)
>         Device 3:  [23] [23] [________] (8 GiB)
> 
>         [after 3 chunk allocations]
>         Device 1:  [_] [_] [_] [_] [_] [_] [_] [_] [_] [_] (10 GiB)
>         Device 2:  [23] [23] [23] [_______] (7 GiB)
>         Device 3:  [23] [23] [23] [_______] (7 GiB)
> 
>         [...]
> 
>         [after 9 chunk allocations]
>         Device 1:  [_] [_] [_] [_] [_] [_] [_] [_] [_] [_] (10 GiB)
>         Device 2:  [23] [23] [23] [23] [23] [23] [23] [23] [23] [_] (1 GiB)
>         Device 3:  [23] [23] [23] [23] [23] [23] [23] [23] [23] [_] (1 GiB)
> 
>         [after 10 chunk allocations]
>         Device 1:  [12] [_] [_] [_] [_] [_] [_] [_] [_] [_] (9 GiB)
>         Device 2:  [23] [23] [23] [23] [23] [23] [23] [23] [12] (full)
>         Device 3:  [23] [23] [23] [23] [23] [23] [23] [23] [_] (1 GiB)
> 
>         [after 11 chunk allocations]
>         Device 1:  [12] [13] [_] [_] [_] [_] [_] [_] [_] [_] (8 GiB)
>         Device 2:  [23] [23] [23] [23] [23] [23] [23] [23] [12] (full)
>         Device 3:  [23] [23] [23] [23] [23] [23] [23] [23] [13] (full)
> 
> No further allocations are possible, with 8 GiB wasted (4 GiB of data
> space).  The sort in gather_device_info now considers free space in
> holes longer than 1 GiB to be distinct, so it will prefer devices 2 and
> 3 over device 1 until all but 1 GiB is allocated on devices 2 and 3.
> At that point, with only 1 GiB unallocated on every device, the largest
> hole length on each device is equal at 1 GiB, so the sort finally moves
> to ordering the devices with the most free space, but by this time it
> is too late to make use of the free space on device 1.
> 
> Note that it's possible to contrive a case where the pre-f6fca3917b4d
> allocator fails the same way, but these cases generally have extensive
> dev_extent fragmentation as a precondition (e.g. many holes of 768M
> in length on one device, and few holes 1 GiB in length on the others).
> With the regression in f6fca3917b4d, bad chunk allocation can occur even
> under optimal conditions, when all dev_extent holes are exact multiples
> of stripe_len in length, as in the example above.
> 
> Also note that post-f6fca3917b4d kernels do treat dev_extent holes
> larger than 10 GiB as equal, so the bad behavior won't show up on a
> freshly formatted filesystem; however, as the filesystem ages and fills
> up, and holes ranging from 1 GiB to 10 GiB in size appear, the problem
> can show up as a failure to balance after adding or removing devices,
> or an unexpected shortfall in available space due to unequal allocation.
> 
> To fix the regression and make data chunk allocation work
> again, set ctl->max_stripe_len back to the original SZ_1G, or
> space_info->chunk_size if that's smaller (the latter can happen if the
> user set space_info->chunk_size to less than 1 GiB via sysfs, or it's
> a 32 MiB system chunk with a hardcoded chunk_size and stripe_len).
> 
> While researching the background of the earler commits, I found that an
> identical fix was already proposed at:
> 
>         https://lore.kernel.org/linux-btrfs/de83ac46-a4a3-88d3-85ce-255b7abc5249@gmx.com/
> 
> The previous review missed one detail:  ctl->max_stripe_len is used
> before decide_stripe_size_regular() is called, when it is too late for
> the changes in that function to have any effect.  ctl->max_stripe_len is
> not used directly by decide_stripe_size_regular(), but the parameter
> does heavily influence the per-device free space data presented to
> the function.
> 
> Fixes: f6fca3917b4d "btrfs: store chunk size in space-info struct"
> Signed-off-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>

Thanks for the fix and detailed changelog, added to misc-next.
