Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C94390620
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 18:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhEYQE3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 12:04:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:45874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233008AbhEYQE2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 12:04:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621958577;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C+ZKXctjfR0YpfCCiqLZlZ5J1bFkTCe46+FCdtk/eiU=;
        b=m8bsqI6xniF6otXVo63O4GiDVDPG5DPAONJK6mtNTYjqSmmaHEzsaVufpIOfh5tTgmM8hZ
        vTcUi7M79clfS6+9exfmBuibgwt+1nhJNduXg4rtKf1S6/QcGyk9PJujFTwHQzORNloDgA
        KydrosIvzp8392WPbrIjs4D6QJW0CQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621958577;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C+ZKXctjfR0YpfCCiqLZlZ5J1bFkTCe46+FCdtk/eiU=;
        b=rxIa9c41PBzrbl/+nWSoKwe3s4T4CDPYiCWaSCob/xPqwBFsl/fe+SYWQeCRenyOyYHcqm
        nIMBG9p4WoIndsCw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C45DCAEA8;
        Tue, 25 May 2021 16:02:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 52EBEDA70B; Tue, 25 May 2021 18:00:21 +0200 (CEST)
Date:   Tue, 25 May 2021 18:00:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] btrfs: fix a bug where a compressed write can cross
 stripe boundary
Message-ID: <20210525160021.GC7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20210525055243.85166-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525055243.85166-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 25, 2021 at 01:52:43PM +0800, Qu Wenruo wrote:
> [BUG]
> When running btrfs/027 with "-o compress" mount option, it always crash
> with the following call trace:
> 
>   BTRFS critical (device dm-4): mapping failed logical 298901504 bio len 12288 len 8192
>   ------------[ cut here ]------------
>   kernel BUG at fs/btrfs/volumes.c:6651!
>   invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 5 PID: 31089 Comm: kworker/u24:10 Tainted: G           OE     5.13.0-rc2-custom+ #26
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>   Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
>   RIP: 0010:btrfs_map_bio.cold+0x58/0x5a [btrfs]
>   Call Trace:
>    btrfs_submit_compressed_write+0x2d7/0x470 [btrfs]
>    submit_compressed_extents+0x3b0/0x470 [btrfs]
>    ? mark_held_locks+0x49/0x70
>    btrfs_work_helper+0x131/0x3e0 [btrfs]
>    process_one_work+0x28f/0x5d0
>    worker_thread+0x55/0x3c0
>    ? process_one_work+0x5d0/0x5d0
>    kthread+0x141/0x160
>    ? __kthread_bind_mask+0x60/0x60
>    ret_from_fork+0x22/0x30
>   ---[ end trace 63113a3a91f34e68 ]---
> 
> [CAUSE]
> The critical message before the crash means we have a bio at logical
> bytenr 298901504 length 12288, but only 8192 bytes can fit into one
> stripe, the remaining 4096 bytes is into another stripe.
> 
> In btrfs, all bio is properly split to avoid cross stripe boundary, but
> commit 764c7c9a464b ("btrfs: zoned: fix parallel compressed writes")
> changed the behavior for compressed write.
> 
> The offending code looks like this:
> 
>                         submit = btrfs_bio_fits_in_stripe(page, PAGE_SIZE, bio,
>                                                           0);
> 
> +               if (pg_index == 0 && use_append)
> +                       len = bio_add_zone_append_page(bio, page, PAGE_SIZE, 0);
> +               else
> +                       len = bio_add_page(bio, page, PAGE_SIZE, 0);
> +
>                 page->mapping = NULL;
> -               if (submit || bio_add_page(bio, page, PAGE_SIZE, 0) <
> -                   PAGE_SIZE) {
> +               if (submit || len < PAGE_SIZE) {

Please don't put diffs into changelogs, it's harder to read than two code
fragments before and after.

> Previously if we find our new page can't be fitted into current stripe,
> aka "submitted == 1" case, we submit current bio without adding current
> page.

So here would go the "-" part.

> But after the modification, we will add the page no matter if it crosses
> stripe boundary, leading to the above crash.

And here the "+" part.

> [FIX]
> It's no longer possible to revert to the original code style as we have
> two different bio_add_*_page() calls now.
> 
> The new fix is to skip the bio_add_*_page() call if @submit is true.
> 
> Also to avoid @len to be uninitialized, always initialize it to zero.
> 
> If @submit is true, @len will not be checked.
> If @submit is not true, @len will be the return value of
> bio_add_*_page() call.
> Either way, the behavior is still the same as the old code.
> 
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Fixes: 764c7c9a464b ("btrfs: zoned: fix parallel compressed writes")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thanks for the fix, I'll have to send it to Linus this week but I want
to be sure there are no more surprises so this will stay in the tested
branches for a few days.
