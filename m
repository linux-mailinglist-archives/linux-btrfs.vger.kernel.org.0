Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319202D9641
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 11:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405776AbgLNKWk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 05:22:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:57844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729460AbgLNKW1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 05:22:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607941300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=5mpblBlhQ7TbmbydSdwgPbUrHHxMjHJLyUjKbRXdLUE=;
        b=Cv29VZkBCbxZh+DQxQEai/WVxinTd7NWArD22fD0cw2BK2H8OCZb1xgCW3W8F/qyG7fJ42
        BzWwj3K79qvg7yXyZ7o1i77/3wmSI3c4i60LfBh3r33i4+hRiGvjd0oV7Ef8DJl8Ahk3Vd
        d7kxhWjFnJl5nW7rgIUWPnS2BlRHjHg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85AF5AC90;
        Mon, 14 Dec 2020 10:21:40 +0000 (UTC)
Subject: Re: [PATCH v2 15/18] btrfs: disk-io: introduce subpage metadata
 validation check
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-16-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a0ff059f-b1d1-29fa-6d0d-2d37a5c5a5e3@suse.com>
Date:   Mon, 14 Dec 2020 12:21:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201210063905.75727-16-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.12.20 г. 8:39 ч., Qu Wenruo wrote:
> For subpage metadata validation check, there are some difference:
> - Read must finish in one bvec
>   Since we're just reading one subpage range in one page, it should
>   never be split into two bios nor two bvecs.
> 
> - How to grab the existing eb
>   Instead of grabbing eb using page->private, we have to go search radix
>   tree as we don't have any direct pointer at hand.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/disk-io.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b6c03a8b0c72..adda76895058 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -591,6 +591,84 @@ static int validate_extent_buffer(struct extent_buffer *eb)
>  	return ret;
>  }
>  
> +static int validate_subpage_buffer(struct page *page, u64 start, u64 end,
> +				   int mirror)
> +{
> +	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
> +	struct extent_buffer *eb;
> +	int reads_done;
> +	int ret = 0;
> +
> +	if (!IS_ALIGNED(start, fs_info->sectorsize) ||

That's guaranteed by the allocator.

> +	    !IS_ALIGNED(end - start + 1, fs_info->sectorsize) ||
That's guaranteed by the fact that  nodesize is a multiple of sectorsize.

> +	    !IS_ALIGNED(end - start + 1, fs_info->nodesize)) {

And that's also guaranteed that the size of an eb is always a nodesize.
Also aren't those checks already performed by the tree-checker during
write? Just remove this as it adds noise.

> +		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));> +		btrfs_err(fs_info, "invalid tree read bytenr");
> +		return -EUCLEAN;
> +	}
> +
> +	/*
> +	 * We don't allow bio merge for subpage metadata read, so we should
> +	 * only get one eb for each endio hook.
> +	 */
> +	ASSERT(end == start + fs_info->nodesize - 1);
> +	ASSERT(PagePrivate(page));
> +
> +	rcu_read_lock();
> +	eb = radix_tree_lookup(&fs_info->buffer_radix,
> +			       start / fs_info->sectorsize);

This division op likely produces the kernel robot's warning. It could be
written to use >> fs_info->sectorsize_bits. Furthermore this usage of
radix tree + rcu without acquiring the refs is unsafe as per my
explanation of, essentially, identical issue in patch 12 and our offline
chat about it.

> +	rcu_read_unlock();
> +
> +	/*
> +	 * When we are reading one tree block, eb must have been
> +	 * inserted into the radix tree. If not something is wrong.
> +	 */
> +	if (!eb) {
> +		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> +		btrfs_err(fs_info,
> +			"can't find extent buffer for bytenr %llu",
> +			start);
> +		return -EUCLEAN;
> +	}

That's impossible to execute and such a failure will result in a crash
so just remove this code.

> +	/*
> +	 * The pending IO might have been the only thing that kept
> +	 * this buffer in memory.  Make sure we have a ref for all
> +	 * this other checks
> +	 */
> +	atomic_inc(&eb->refs);
> +
> +	reads_done = atomic_dec_and_test(&eb->io_pages);
> +	/* Subpage read must finish in page read */
> +	ASSERT(reads_done);

Just ASSERT(atomic_dec_and_test(&eb->io_pages)). Again, for subpage I
think that's a bit much since it only has 1 page so it's guaranteed that
it will always be true.
> +
> +	eb->read_mirror = mirror;
> +	if (test_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags)) {
> +		ret = -EIO;
> +		goto err;
> +	}
> +	ret = validate_extent_buffer(eb);
> +	if (ret < 0)
> +		goto err;
> +
> +	if (test_and_clear_bit(EXTENT_BUFFER_READAHEAD, &eb->bflags))
> +		btree_readahead_hook(eb, ret);
> +
> +	set_extent_buffer_uptodate(eb);
> +
> +	free_extent_buffer(eb);
> +	return ret;
> +err:
> +	/*
> +	 * our io error hook is going to dec the io pages
> +	 * again, we have to make sure it has something to
> +	 * decrement
> +	 */

That comment is slightly ambiguous - it's not the io error hook that
does the decrement but end_bio_extent_readpage. Just rewrite the comment
to :

"end_bio_extent_readpage decrements io_pages in case of error, make sure
it has ...."

> +	atomic_inc(&eb->io_pages);
> +	clear_extent_buffer_uptodate(eb);
> +	free_extent_buffer(eb);
> +	return ret;
> +}
> +
>  int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio,
>  				   struct page *page, u64 start, u64 end,
>  				   int mirror)
> @@ -600,6 +678,10 @@ int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio,
>  	int reads_done;
>  
>  	ASSERT(page->private);
> +
> +	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
> +		return validate_subpage_buffer(page, start, end, mirror);

nit: validate_metadata_buffer is called in only once place so I'm
wondering won't it make it more readable if this check is lifted to its
sole caller so that when reading end_bio_extent_readpage it's apparent
what's going on. Though it's apparent that the nesting in the caller
will get somewhat unwieldy so won't be pressing hard for this.
> +
>  	eb = (struct extent_buffer *)page->private;
>  
>  
> 
