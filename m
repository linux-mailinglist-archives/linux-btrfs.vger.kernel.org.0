Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C6429A9F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 11:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417618AbgJ0KpB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 06:45:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:58520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1417579AbgJ0Ko7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 06:44:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2202ACC2;
        Tue, 27 Oct 2020 10:44:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DBA2ADA6E2; Tue, 27 Oct 2020 11:43:24 +0100 (CET)
Date:   Tue, 27 Oct 2020 11:43:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v4 16/68] btrfs: extent_io: add assert_spin_locked() for
 attach_extent_buffer_page()
Message-ID: <20201027104324.GA6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
 <20201021062554.68132-17-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021062554.68132-17-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 21, 2020 at 02:25:02PM +0800, Qu Wenruo wrote:
> When calling attach_extent_buffer_page(), either we're attaching
> anonymous pages, called from btrfs_clone_extent_buffer().
> 
> Or we're attaching btree_inode pages, called from alloc_extent_buffer().
> 
> For the later case, we should have page->mapping->private_lock hold to
> avoid race modifying page->private.
> 
> Add assert_spin_locked() if we're calling from alloc_extent_buffer().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/extent_io.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 5842d3522865..8bf38948bd37 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3106,6 +3106,15 @@ static int submit_extent_page(unsigned int opf,
>  static void attach_extent_buffer_page(struct extent_buffer *eb,
>  				      struct page *page)
>  {
> +	/*
> +	 * If the page is mapped to btree inode, we should hold the private
> +	 * lock to prevent race.
> +	 * For cloned or dummy extent buffers, their pages are not mapped and
> +	 * will not race with any other ebs.
> +	 */
> +	if (page->mapping)
> +		assert_spin_locked(&page->mapping->private_lock);

assert_spin_locked per documentation checks if the spinlock is lockded
on any cpu, but from the comments above you want to assert that it's
held by the caller. So for that you need lockdep_assert_held, I don't
thing we'd ever want assert_spin_locked in our code.

> +
>  	if (!PagePrivate(page))
>  		attach_page_private(page, eb);
>  	else
> -- 
> 2.28.0
