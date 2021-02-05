Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEC4310505
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 07:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhBEGkL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Feb 2021 01:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:55100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhBEGkK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Feb 2021 01:40:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79E0C64F10;
        Fri,  5 Feb 2021 06:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612507168;
        bh=hpZtN0Aqnss96YC/dADnXc5NyF8ZUnBWNcAKb4gtS4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qbuU79DBYJRrNU6/JZn4lXhLUOWvE4x41NWFpmzKiU1VGgN0kAFPpnbV0Upbvkmms
         pV0NidzmnNPq7Jkgb8yO+dKzOb7N4TX1LSmozBtPtDtnQEoVHCrDMa5RISUtx9AUxw
         P0BXJzGCGnQYr5nxZpHKp/sLuHAHHrRkkuoequ7u7Tq/v1piJic2/cBz9Wl+/NYNbs
         vd8xpmL8twuIRpNcNe3StN2sxTm3P2mNFZMRpcz97ukDCgKWTaab42CJ8rXmuy9LaD
         6Tl8l6JYYVtCPahbfOv1FIWrzZ6XzBxD12oXzUOatPKE8Z2Fj3OTuvg9wm7NkN7iB6
         YvzOPpqHljy+Q==
Date:   Thu, 4 Feb 2021 22:39:26 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/5] btrfs: initial fsverity support
Message-ID: <YBzoHniIpslKZtbp@sol.localdomain>
References: <cover.1612475783.git.boris@bur.io>
 <88389022bd9f264f215c9d85fe48214190402fd6.1612475783.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88389022bd9f264f215c9d85fe48214190402fd6.1612475783.git.boris@bur.io>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 04, 2021 at 03:21:38PM -0800, Boris Burkov wrote:
> +/*
> + * drop all the items for this inode with this key_type.  Before
> + * doing a verity enable we cleanup any existing verity items.
> + *
> + * This is also used to clean up if a verity enable failed half way
> + * through
> + */
> +static int drop_verity_items(struct btrfs_inode *inode, u8 key_type)

I assume you checked whether there's already code in btrfs that does this?  This
seems like a fairly generic thing that might be needed elsewhere in btrfs.
Similarly for write_key_bytes() and read_key_bytes().

> +/*
> + * fsverity does a two pass setup for reading the descriptor, in the first pass
> + * it calls with buf_size = 0 to query the size of the descriptor,
> + * and then in the second pass it actually reads the descriptor off
> + * disk.
> + */
> +static int btrfs_get_verity_descriptor(struct inode *inode, void *buf,
> +				       size_t buf_size)
> +{
> +	ssize_t ret = 0;
> +
> +	if (!buf_size) {
> +		return read_key_bytes(BTRFS_I(inode),
> +				     BTRFS_VERITY_DESC_ITEM_KEY,
> +				     0, NULL, (u64)-1, NULL);
> +	}
> +
> +	ret = read_key_bytes(BTRFS_I(inode),
> +			     BTRFS_VERITY_DESC_ITEM_KEY, 0,
> +			     buf, buf_size, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret != buf_size)
> +		return -EIO;
> +
> +	return buf_size;
> +}

This doesn't return the right value when buf_size != 0 && buf_size != desc_size.
It's supposed to return the actual size or -ERANGE, like getxattr() does; see
the comment above fsverity_operations::get_verity_descriptor.

It doesn't matter much because that case doesn't happen currently, but it would
be nice to keep things consistent.

> +/*
> + * reads and caches a merkle tree page.  These are stored in the btree,
> + * but we cache them in the inode's address space after EOF.
> + */
> +static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
> +					       pgoff_t index,
> +					       unsigned long num_ra_pages)
> +{
> +	struct page *p;
> +	u64 start = index << PAGE_SHIFT;
> +	unsigned long mapping_index;
> +	ssize_t ret;
> +	int err;
> +
> +	/*
> +	 * the file is readonly, so i_size can't change here.  We jump
> +	 * some pages past the last page to cache our merkles.  The goal
> +	 * is just to jump past any hugepages that might be mapped in.
> +	 */
> +	mapping_index = (i_size_read(inode) >> PAGE_SHIFT) + 2048 + index;

btrfs allows files of up to the page cache limit of MAX_LFS_FILESIZE already.
So if the Merkle tree pages are cached past EOF like this, it would be necessary
to limit the size of files that verity can be enabled on, like what ext4 and
f2fs do.  See the -EFBIG case in pagecache_write() in fs/ext4/verity.c and
fs/f2fs/verity.c.

Note that this extra limit isn't likely to be encountered in practice, as it
would only decrease a very large limit by about 1%, and fs-verity isn't likely
to be used on terabyte-sized files.

However maybe there's a way to avoid this weirdness entirely, e.g. by allocating
a temporary in-memory inode and using its address_space?

- Eric
