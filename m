Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D99A39E587
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jun 2021 19:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFGRef (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 13:34:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45578 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhFGRef (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Jun 2021 13:34:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C426D21A90;
        Mon,  7 Jun 2021 17:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623087162;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B+U8mAmOtgNWiQbH57K3dY9IjUSoMPK898hJ5NQl8/M=;
        b=kQ17nSHWSIU4pKCzPQW1ZmltCAQUHyK7t52JvrP4XWUoZuHgMgFf4EN+GXtB37RHQET1hA
        3f7J8rLzfJ0iTTF2Bf4K7Ce0A3xjE0An6yOQZ9zPEcHr1L4pVP1ss8AYZ587bh1UtxyG4Z
        J+769Rd24MmKrQ9WzxVSUTc/LrU6Bdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623087162;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B+U8mAmOtgNWiQbH57K3dY9IjUSoMPK898hJ5NQl8/M=;
        b=JTWc4C7sCB4USIxdeBYHE+lkQRHAYFtdBkmCBJTDGatOOWnSa0nwKUaDzfqohZGHnUd5M+
        FYdD/Plg/fD9CbDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BE1A5A3B87;
        Mon,  7 Jun 2021 17:32:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ACCC6DB228; Mon,  7 Jun 2021 19:29:59 +0200 (CEST)
Date:   Mon, 7 Jun 2021 19:29:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH] btrfs: fix a rare race between metadata endio and eb
 freeing
Message-ID: <20210607172959.GG31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210607090258.253660-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607090258.253660-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 07, 2021 at 05:02:58PM +0800, Qu Wenruo wrote:
> [BUG]
> There is a very rare ASSERT() triggering during full fstests run for
> subpage rw support.
> 
> No extra reproduce so far.
> 
> The ASSERT() get triggered for metadata read in
> btrfs_page_set_uptodate() inside end_page_read().
> 
> [CAUSE]
> There is still a small race window for metadata only, the race could
> happen like this:
> 
>                 T1                  |              T2
> ------------------------------------+-----------------------------
> end_bio_extent_readpage()           |
> |- btrfs_validate_metadata_buffer() |
> |  |- free_extent_buffer()          |
> |     Still have 2 refs             |
> |- end_page_read()                  |
>    |- if (unlikely(PagePrivate())   |
>    |  The page still has Private    |
>    |                                | free_extent_buffer()
>    |                                | |  Only one ref 1, will be
>    |                                | |  released
>    |                                | |- detach_extent_buffer_page()
>    |                                |    |- btrfs_detach_subpage()
>    |- btrfs_set_page_uptodate()     |
>       The page no longer has Private|
>       >>> ASSERT() triggered <<<    |
> 
> This race window is super small, thus pretty hard to hit, even with so
> many runs of fstests.
> 
> But the race window is still there, we have to go another way to solve
> it other than replying on random PagePrivate() check.
> 
> Data path is not affected, as data path will lock the page before read,
> while unlock the page after the last read has finished, thus no race
> window.
> 
> [FIX]
> This patch will fix the bug by re-purpose btrfs_subpage::readers.
> 
> Now btrfs_subpage::readers will be a member shared by both metadata and
> data.
> 
> For metadata path, we don't do the page unlock as metadata only relies on
> extent locking.
> 
> At the same time, teach page_range_has_eb() to take into
> btrfs_subpage::readers into consideration.
> 
> So that even if the last eb of a page get freed, page::private won't be
> detached as long as there is still pending end_page_read() calls.
> 
> By this we eliminate the race window, this will slight increase the
> metadata memory usage, as the page may not be released as frequently as
> usual.
> But it should not be a big deal.
> 
> Fixes: ***SPACEHOLDER**** ("btrfs: submit read time repair only for each corrupted sector")

This won't work, I won't refresh this patch each time I rebase
misc-next on a new rc. A reference by subject should be sufficient.
