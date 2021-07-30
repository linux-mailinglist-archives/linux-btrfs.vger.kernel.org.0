Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FC03DB7A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jul 2021 13:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbhG3LK6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jul 2021 07:10:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59316 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhG3LK5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jul 2021 07:10:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6CEC61FDD5;
        Fri, 30 Jul 2021 11:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627643452;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kLeeLW9VUmSLNDSMOvzNs8LGwdMr9c1omA3yfKsPhCY=;
        b=vhR0REk6NUOYNBJckYLG2QzntM1XLCp6pu5GKng4V/Bv2/G0nzSE9igZKvpyaWNUPYHDCl
        Dcl5In3EIa4zvpW8evQeFORjFCD5k/Yua+a+GY6C11sDXVtBkBPdYoWl2TekWG5lZSiw85
        JG7SeVgvB+b0RmIE6J+mEbkQchmpqkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627643452;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kLeeLW9VUmSLNDSMOvzNs8LGwdMr9c1omA3yfKsPhCY=;
        b=jdrd3R2mB77oB5CsAcK82lVVC05yqQIqxsVAZPWyhFaCHyoBXAHbGvcGfFbnd4bwI3lccz
        VY2MxRs8Qw6JEBDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 66DA7A3B88;
        Fri, 30 Jul 2021 11:10:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1A8A9DB284; Fri, 30 Jul 2021 13:08:05 +0200 (CEST)
Date:   Fri, 30 Jul 2021 13:08:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: setup the page before calling any subpage helper
Message-ID: <20210730110805.GF5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210730055857.149633-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730055857.149633-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 30, 2021 at 01:58:57PM +0800, Qu Wenruo wrote:
> Function set_page_extent_mapped() will setup the data page cache so that
> for subpage cases those pages will have page->private to store subpage
> specific info.
> 
> Normally this happens when we create a new page for the page cache.
> But there is a special call site, __extent_writepage(), as we have
> special cases where upper layer can mark some page dirty without going
> through set_page_dirty() interface.
> 
> I haven't yet seen any real world case for this, but if that's possible
> then in __extent_writepage() we will call btrfs_page_clear_error()
> before setting up the page->private, which can lead to NULL pointer
> dereference.

Yeah it's hard to believe, but it's been there since almost the
beginning. Back then there was a hard BUG() in the fixup worker, I've
hit it randomly on x86_64,

https://lore.kernel.org/linux-btrfs/20111031154139.GF19328@twin.jikos.cz/

you could find a lot of other reports where it crashed inside
btrfs_writepage_fixup_worker.

> Fix it by moving set_page_extent_mapped() call before
> btrfs_page_clear_error().
> And make sure in the error path we won't call anything subpage helper.

I'm not sure about the fix, because the whole fixup thing is not
entirely clear.

> Fixes: 32443de3382b ("btrfs: introduce btrfs_subpage for data inodes")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> I really hope we can have a more explicit comment about in exactly which
> cases we can have such page, and maybe some test cases for it.

The only reliable test case was on s390 with a particular seed for fsx,
I still have it stored somewhere. On x86_64 it's very hard to hit.

> In fact, I haven't really seen any case like this, and it doesn't really
> make sense for me to make some MM layer code to mark a page dirty
> without going through set_page_dirty() interface.

On s390 it's quick because the page state bits are stored in 2 places
and need to be synced. On x86_64 it's very unclear and low level arch
specific MM stuff but it is still a problem.
