Return-Path: <linux-btrfs+bounces-11789-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC51A44AD1
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 19:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B3C3A615D
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 18:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617251A01CC;
	Tue, 25 Feb 2025 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLUrtbis"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D4514F9C4
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508900; cv=none; b=gp9AJ3mDSKfCE15JWVQ6hOPEGbXxcNl0rE0eRLg70N9amkFJQM4BUumNMb7oYupx4MXEgfo5LdmLB8afsJwWd1NMppdUz2bno3ImcuYXxy91qnSt0+WvLLrMAxoacgXShMTfinX2v2IgWciOAYAaqPL5hu+OhsE6Z7cjdnJ3lJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508900; c=relaxed/simple;
	bh=N4g0SjgLU1W6gAAaXA+mMxfV+vp65Tgg17g6/yKWVs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fV5PxSSZcmjiwf9Qm+8o6GSEORH+ZvTLgzHTs1vQWh4FShi4A8V43/KHZhjcgH3kjUkuDzEVrrqW8dreQ1KCFQvhkMwY3yeDCmkUXWeZJKCbz8A4qpaXJkGS/yaGmZLbl6k3sdvIiL+AmT2aemC0GT0B+4OWs+ktfcZqeM/97ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLUrtbis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559C0C4CEDD;
	Tue, 25 Feb 2025 18:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740508900;
	bh=N4g0SjgLU1W6gAAaXA+mMxfV+vp65Tgg17g6/yKWVs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iLUrtbisz+2rlaUsCqMEY/7KA0GyXLFvsJN0asbee0869HNqWwf3pwv2CPzTMht8x
	 RD6/99vUxkvZfcCtCafjHQNLRQ5pcML+Ztqtn/3ShVWjchfDl2LefwE4EkdGHPy+vm
	 S2Pey54yD4jbaRGADqnN5uSWEWlh98nUKBOlQ24tG19gsQzwd1xwZR+AVNsCpoCIZ/
	 dZqH78t3q0GLD3NFTnScqc4miUgeOQnr9Lx/fLJjnmTikUtVe5Q5Q08ZyEwT7PE28g
	 1sH0ArJ3d/RhtcHxoppiWCpPDp3JVj6bzDfBKRJY582QV4M88wY8Z6zQTCEWe9lxY3
	 fcj0hmbCCF1Zg==
Date: Tue, 25 Feb 2025 11:41:36 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/5] btrfs: prepare extent_io.c for future larger folio
 support
Message-ID: <20250225184136.GA1679809@ax162>
References: <cover.1740043233.git.wqu@suse.com>
 <19dfc0e42dce6416b66df114513d18d93b830d17.1740043233.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19dfc0e42dce6416b66df114513d18d93b830d17.1740043233.git.wqu@suse.com>

On Thu, Feb 20, 2025 at 07:52:25PM +1030, Qu Wenruo wrote:
> When we're handling folios from filemap, we can no longer assume all
> folios are page sized.
> 
> Thus for call sites assuming the folio is page sized, change the
> PAGE_SIZE usage to folio_size() instead.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index e1efb6419601..88bac9a32919 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -425,7 +425,7 @@ static void end_folio_read(struct folio *folio, bool uptodate, u64 start, u32 le
>  	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
>  
>  	ASSERT(folio_pos(folio) <= start &&
> -	       start + len <= folio_pos(folio) + PAGE_SIZE);
> +	       start + len <= folio_pos(folio) + folio_size(folio));
>  
>  	if (uptodate && btrfs_verify_folio(folio, start, len))
>  		btrfs_folio_set_uptodate(fs_info, folio, start, len);
> @@ -492,7 +492,7 @@ static void begin_folio_read(struct btrfs_fs_info *fs_info, struct folio *folio)
>  		return;
>  
>  	ASSERT(folio_test_private(folio));
> -	btrfs_folio_set_lock(fs_info, folio, folio_pos(folio), PAGE_SIZE);
> +	btrfs_folio_set_lock(fs_info, folio, folio_pos(folio), folio_size(folio));
>  }
>  
>  /*
> @@ -753,7 +753,7 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
>  {
>  	struct btrfs_inode *inode = folio_to_inode(folio);
>  
> -	ASSERT(pg_offset + size <= PAGE_SIZE);
> +	ASSERT(pg_offset + size <= folio_size(folio));
>  	ASSERT(bio_ctrl->end_io_func);
>  
>  	if (bio_ctrl->bbio &&
> @@ -935,7 +935,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
>  	struct inode *inode = folio->mapping->host;
>  	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
>  	u64 start = folio_pos(folio);
> -	const u64 end = start + PAGE_SIZE - 1;
> +	const u64 end = start + folio_size(folio) - 1;
>  	u64 cur = start;
>  	u64 extent_offset;
>  	u64 last_byte = i_size_read(inode);
> @@ -1277,7 +1277,7 @@ static void set_delalloc_bitmap(struct folio *folio, unsigned long *delalloc_bit
>  	unsigned int start_bit;
>  	unsigned int nbits;
>  
> -	ASSERT(start >= folio_start && start + len <= folio_start + PAGE_SIZE);
> +	ASSERT(start >= folio_start && start + len <= folio_start + folio_size(folio));
>  	start_bit = (start - folio_start) >> fs_info->sectorsize_bits;
>  	nbits = len >> fs_info->sectorsize_bits;
>  	ASSERT(bitmap_test_range_all_zero(delalloc_bitmap, start_bit, nbits));
> @@ -1295,7 +1295,7 @@ static bool find_next_delalloc_bitmap(struct folio *folio,
>  	unsigned int first_zero;
>  	unsigned int first_set;
>  
> -	ASSERT(start >= folio_start && start < folio_start + PAGE_SIZE);
> +	ASSERT(start >= folio_start && start < folio_start + folio_size(folio));
>  
>  	start_bit = (start - folio_start) >> fs_info->sectorsize_bits;
>  	first_set = find_next_bit(delalloc_bitmap, bitmap_size, start_bit);
> @@ -1497,10 +1497,10 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
>  		delalloc_end = page_end;
>  	/*
>  	 * delalloc_end is already one less than the total length, so
> -	 * we don't subtract one from PAGE_SIZE
> +	 * we don't subtract one from folio_size().
>  	 */
>  	delalloc_to_write +=
> -		DIV_ROUND_UP(delalloc_end + 1 - page_start, PAGE_SIZE);
> +		DIV_ROUND_UP(delalloc_end + 1 - page_start, folio_size(folio));
>  
>  	/*
>  	 * If all ranges are submitted asynchronously, we just need to account
> @@ -1737,7 +1737,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
>  		goto done;
>  
>  	ret = extent_writepage_io(inode, folio, folio_pos(folio),
> -				  PAGE_SIZE, bio_ctrl, i_size);
> +				  folio_size(folio), bio_ctrl, i_size);
>  	if (ret == 1)
>  		return 0;
>  	if (ret < 0)
> @@ -2468,8 +2468,8 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
>  	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(end + 1, sectorsize));
>  
>  	while (cur <= end) {
> -		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
> -		u32 cur_len = cur_end + 1 - cur;
> +		u64 cur_end;
> +		u32 cur_len;
>  		struct folio *folio;
>  
>  		folio = filemap_get_folio(mapping, cur >> PAGE_SHIFT);
> @@ -2479,13 +2479,18 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
>  		 * code is just in case, but shouldn't actually be run.
>  		 */
>  		if (IS_ERR(folio)) {
> +			cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
> +			cur_len = cur_end + 1 - cur;
>  			btrfs_mark_ordered_io_finished(BTRFS_I(inode), NULL,
>  						       cur, cur_len, false);
>  			mapping_set_error(mapping, PTR_ERR(folio));
> -			cur = cur_end + 1;
> +			cur = cur_end;
>  			continue;
>  		}
>  
> +		cur_end = min(folio_pos(folio) + folio_size(folio) - 1, end);

As the kernel test robot points out, this breaks the build for 32-bit
targets in -next because folio_pos() returns loff_t and folio_size()
returns size_t, which is 'unsigned int' for 32-bit instead of 'unsigned
long', so the whole expression gets promoted to 'long long' from the
loff_t, mismatching the sign of end. I just silenced it with a cast to
u64 before folio_pos() but that is likely incorrect as a formal fix,
hence just the extra comment.

> +		cur_len = cur_end + 1 - cur;
> +
>  		ASSERT(folio_test_locked(folio));
>  		if (pages_dirty && folio != locked_folio)
>  			ASSERT(folio_test_dirty(folio));
> @@ -2597,7 +2602,7 @@ static bool try_release_extent_state(struct extent_io_tree *tree,
>  				     struct folio *folio)
>  {
>  	u64 start = folio_pos(folio);
> -	u64 end = start + PAGE_SIZE - 1;
> +	u64 end = start + folio_size(folio) - 1;
>  	bool ret;
>  
>  	if (test_range_bit_exists(tree, start, end, EXTENT_LOCKED)) {
> @@ -2635,7 +2640,7 @@ static bool try_release_extent_state(struct extent_io_tree *tree,
>  bool try_release_extent_mapping(struct folio *folio, gfp_t mask)
>  {
>  	u64 start = folio_pos(folio);
> -	u64 end = start + PAGE_SIZE - 1;
> +	u64 end = start + folio_size(folio) - 1;
>  	struct btrfs_inode *inode = folio_to_inode(folio);
>  	struct extent_io_tree *io_tree = &inode->io_tree;
>  
> -- 
> 2.48.1
> 

