Return-Path: <linux-btrfs+bounces-12967-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21475A86ECA
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Apr 2025 20:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B04F27B2078
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Apr 2025 18:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA06F21018F;
	Sat, 12 Apr 2025 18:35:35 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C964714AD20
	for <linux-btrfs@vger.kernel.org>; Sat, 12 Apr 2025 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744482935; cv=none; b=UcIc/f2wxSnRFODAmCAr2AUw9/sN+yJ2P7swcRsKxRH0xFxXgt+r/oAm2gryovyETA7c84AA2Pqfiveaf0wJNeuXItF+DgwSZzL2hWI+YmulzuczHG7HFNrS0IDG/O0KNpMCXfshYt3K95LuF5FgY2yIanh5BT4VI1ejm9MxKpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744482935; c=relaxed/simple;
	bh=af8eVjl9yGFlCgpz9LDN1kDvxHgDQlRa1khJ1UO3MCA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtyCBApPmi9ok4lLn+SsJdwJiaHpyfQDvTU3Z18pwIgbb69+xxOdHyp7xp1xVnkexGMl3b5JH2zZplBC37jTnImCr3EePf+NRd7ysiSq+8mBJPtLVDB5UL9O3Nq47Hc85HwBiJGFQSxUHqiQ6XOxtNTbcGEV+7YuNUsdBhSQ0DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id e93b71c8-17cc-11f0-8e9d-005056bdfda7;
	Sat, 12 Apr 2025 21:35:30 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 12 Apr 2025 21:35:30 +0300
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: make btrfs_truncate_block() zero folio range
 for certain subpage corner cases
Message-ID: <Z_qycnlLXbCgd7uF@surfacebook.localdomain>
References: <cover.1744344865.git.wqu@suse.com>
 <d66c922e591b3a57a230ca357b9085fe6ae53812.1744344865.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d66c922e591b3a57a230ca357b9085fe6ae53812.1744344865.git.wqu@suse.com>

Fri, Apr 11, 2025 at 02:44:01PM +0930, Qu Wenruo kirjoitti:
> [BUG]
> For the following fsx -e 1 run, the btrfs still fails the run on 64K
> page size with 4K fs block size:
> 
> READ BAD DATA: offset = 0x26b3a, size = 0xfafa, fname = /mnt/btrfs/junk
> OFFSET      GOOD    BAD     RANGE
> 0x26b3a     0x0000  0x15b4  0x0
> operation# (mod 256) for the bad data may be 21

[...]

> +static int zero_range_folio(struct btrfs_inode *inode, loff_t from, loff_t end,
> +			    u64 orig_start, u64 orig_end,
> +			    enum btrfs_truncate_where where)
> +{
> +	const u32 blocksize = inode->root->fs_info->sectorsize;
> +	struct address_space *mapping = inode->vfs_inode.i_mapping;
> +	struct extent_io_tree *io_tree = &inode->io_tree;
> +	struct extent_state *cached_state = NULL;
> +	struct btrfs_ordered_extent *ordered;
> +	pgoff_t index = (where == BTRFS_TRUNCATE_HEAD_BLOCK) ?
> +			(from >> PAGE_SHIFT) : (end >> PAGE_SHIFT);

You want to use PFN_*() macros from the pfn.h perhaps?

> +	struct folio *folio;
> +	u64 block_start;
> +	u64 block_end;
> +	u64 clamp_start;
> +	u64 clamp_end;
> +	int ret = 0;
> +
> +	/*
> +	 * The target head/tail block is already block aligned.
> +	 * If block size >= PAGE_SIZE, meaning it's impossible to mmap a
> +	 * page containing anything other than the target block.
> +	 */
> +	if (blocksize >= PAGE_SIZE)
> +		return 0;
> +again:
> +	folio = filemap_lock_folio(mapping, index);
> +	/* No folio present. */
> +	if (IS_ERR(folio))
> +		return 0;
> +
> +	if (!folio_test_uptodate(folio)) {
> +		ret = btrfs_read_folio(NULL, folio);
> +		folio_lock(folio);
> +		if (folio->mapping != mapping) {
> +			folio_unlock(folio);
> +			folio_put(folio);
> +			goto again;
> +		}
> +		if (!folio_test_uptodate(folio)) {
> +			ret = -EIO;
> +			goto out_unlock;
> +		}
> +	}
> +	folio_wait_writeback(folio);
> +
> +	clamp_start = max_t(u64, folio_pos(folio), orig_start);
> +	clamp_end = min_t(u64, folio_pos(folio) + folio_size(folio) - 1,
> +			  orig_end);

You probably wanted clamp() ?

> +	block_start = round_down(clamp_start, block_size);
> +	block_end = round_up(clamp_end + 1, block_size) - 1;

LKP rightfully complains, I believe you want to use ALIGN*() macros instead.

> +	lock_extent(io_tree, block_start, block_end, &cached_state);
> +	ordered = btrfs_lookup_ordered_range(inode, block_start, block_end + 1 - block_end);
> +	if (ordered) {
> +		unlock_extent(io_tree, block_start, block_end, &cached_state);
> +		folio_unlock(folio);
> +		folio_put(folio);
> +		btrfs_start_ordered_extent(ordered);
> +		btrfs_put_ordered_extent(ordered);
> +		goto again;
> +	}
> +	folio_zero_range(folio, clamp_start - folio_pos(folio),
> +			 clamp_end - clamp_start + 1);
> +	unlock_extent(io_tree, block_start, block_end, &cached_state);
> +
> +out_unlock:
> +	folio_unlock(folio);
> +	folio_put(folio);
> +	return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko



