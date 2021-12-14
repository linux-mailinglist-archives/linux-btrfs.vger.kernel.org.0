Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C59474078
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 11:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbhLNKcm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 05:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhLNKcl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 05:32:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9608FC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 02:32:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32A3A612FE
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 10:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061B4C34600;
        Tue, 14 Dec 2021 10:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639477960;
        bh=dROSUdSROQeqay56JyoCgwGa58lC2iN3KPoRcyrH230=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WE1e2kbQz+F/UKjfCHlhwP6gf0HxpDBCxZjA5kA9SujrSIa1jFg6PNhNFbqvLKZ54
         UYE0raU4FUijgnhpoM5TdKX55ZhsB9oL1fxWXOHSZgTTHoP85u2d2ySTuEXh62Oy/c
         hpSaFdxeySyvFE19Rk0Ag86iNrlKnxVHw0gzfd7gOLKpMCxqJpg9g6LQfUhi0pJ8iZ
         acDD+3HK2u8sTOr6mQwfIVNmVGwMnuqktZ8fDetv+rYCD/N+6Y7/TQCKiZSZljM15N
         gcCwfPM7pwgI/ONnytw9nlSiG8ter9QugQyvcf1kJLjdggE8JHjlOlqjYUb8rCIPIa
         XHpvgnNL2plGg==
Date:   Tue, 14 Dec 2021 10:32:37 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: check WRITE_ERR when trying to read an extent
 buffer
Message-ID: <YbhyxZPERYm4DYFU@debian9.Home>
References: <1676bf652be3e37ef3ae55ed784c8f0ab2ff3f8f.1639423346.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676bf652be3e37ef3ae55ed784c8f0ab2ff3f8f.1639423346.git.josef@toxicpanda.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 13, 2021 at 02:22:33PM -0500, Josef Bacik wrote:
> Filipe reported a hang when we have errors on btrfs.  This turned out to
> be a side-effect of my fix 666cc468424b ("btrfs: clear extent buffer
> uptodate when we fail to write it") which made it so we clear

The commit in Linus' tree is c2e39305299f0118298c2201f6d6cc7d3485f29e.

> EXTENT_BUFFER_UPTODATE on an eb when we fail to write it out.
> 
> Below is a paste of Filipe's analysis he got from using drgn to debug
> the hang
> 
> """
> btree readahead code calls read_extent_buffer_pages(), sets ->io_pages to
> a value while writeback of all pages has not yet completed:
>    --> writeback for the first 3 pages finishes, we clear
>        EXTENT_BUFFER_UPTODATE from eb on the first page when we get an
>        error.
>    --> at this point eb->io_pages is 1 and we cleared Uptodate bit from the
>        first 3 pages
>    --> read_extent_buffer_pages() does not see EXTENT_BUFFER_UPTODATE() so
>        it continues, it's able to lock the pages since we obviously don't
>        hold the pages locked during writeback
>    --> read_extent_buffer_pages() then computes 'num_reads' as 3, and sets
>        eb->io_pages to 3, since only the first page does not have Uptodate
>        bit set at this point
>    --> writeback for the remaining page completes, we ended decrementing
>        eb->io_pages by 1, resulting in eb->io_pages == 2, and therefore
>        never calling end_extent_buffer_writeback(), so
>        EXTENT_BUFFER_WRITEBACK remains in the eb's flags
>    --> of course, when the read bio completes, it doesn't and shouldn't
>        call end_extent_buffer_writeback()
>    --> we should clear EXTENT_BUFFER_UPTODATE only after all pages of
>        the eb finished writeback?  or maybe make the read pages code
>        wait for writeback of all pages of the eb to complete before
>        checking which pages need to be read, touch ->io_pages, submit
>        read bio, etc
> 
> writeback bit never cleared means we can hang when aborting a
> transaction, at:
> 
>     btrfs_cleanup_one_transaction()
>        btrfs_destroy_marked_extents()
>          wait_on_extent_buffer_writeback()
> """
> 
> This is a problem because our writes are not synchronized with reads in
> any way.  We clear the UPTODATE flag and then we can easily come in and
> try to read the EB while we're still waiting on other bio's to
> complete.
> 
> We have two options here, we could lock all the pages, and then check to
> see if eb->io_pages != 0 to know if we've already got an outstanding
> write on the eb.
> 
> Or we can simply check to see if we have WRITE_ERR set on this extent
> buffer.  We set this bit _before_ we clear UPTODATE, so if the read gets
> triggered because we aren't UPTODATE because of a write error we're
> guaranteed to have WRITE_ERR set, and in this case we can simply return
> -EIO.  This will fix the reported hang.
> 
> Reported-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

As this is already in Linus' tree, and it was tagged for stable backports, it should
include:

Fixes: c2e39305299f01 ("btrfs: clear extent buffer uptodate when we fail to write it")

David can probably add that and fix the commit id above.

Other than that, it looks good, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  fs/btrfs/extent_io.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 762100a00978..38c5e9eb9a10 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -6601,6 +6601,14 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
>  	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
>  		return 0;
>  
> +	/*
> +	 * We could have had EXTENT_BUFFER_UPTODATE cleared by the write
> +	 * operation, which could potentially still be in flight.  In this case
> +	 * we simply want to return an error.
> +	 */
> +	if (unlikely(test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)))
> +		return -EIO;
> +
>  	if (eb->fs_info->sectorsize < PAGE_SIZE)
>  		return read_extent_buffer_subpage(eb, wait, mirror_num);
>  
> -- 
> 2.26.3
> 
