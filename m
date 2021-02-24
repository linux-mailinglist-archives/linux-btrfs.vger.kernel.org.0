Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF8A324448
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Feb 2021 20:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbhBXTB1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Feb 2021 14:01:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:56648 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235276AbhBXS7i (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Feb 2021 13:59:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8DB92AB95
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Feb 2021 18:58:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B8FFEDA734; Wed, 24 Feb 2021 19:56:56 +0100 (CET)
Date:   Wed, 24 Feb 2021 19:56:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Remove force argument from run_delalloc_nocow()
Message-ID: <20210224185656.GA1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org
References: <20210222131749.dxkq45umwehqm33i@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222131749.dxkq45umwehqm33i@fiona>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 22, 2021 at 07:17:49AM -0600, Goldwyn Rodrigues wrote:
> force_nocow can be calculated by btrfs_inode and does not need to be
> passed as an argument.
> 
> This simplifies run_delalloc_nocow() call from btrfs_run_delalloc_range()
> where should_nocow() checks for BTRFS_INODE_NODATASUM and
> BTRFS_INODE_PREALLOC flags or if EXTENT_DEFRAG flags are set.
> 
> should_nocow() has been re-arranged so EXTENT_DEFRAG has higher priority
> in checks.

Why is that? In the check sequence, test_range_bit is called first but
that's more expensive as it needs to iterate the range.

> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/inode.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4f2f1e932751..2115d8cc6f18 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1516,7 +1516,7 @@ static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
>  static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  				       struct page *locked_page,
>  				       const u64 start, const u64 end,
> -				       int *page_started, int force,
> +				       int *page_started,
>  				       unsigned long *nr_written)
>  {
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> @@ -1530,6 +1530,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  	u64 ino = btrfs_ino(inode);
>  	bool nocow = false;
>  	u64 disk_bytenr = 0;
> +	bool force = inode->flags & BTRFS_INODE_NODATACOW;
>  
>  	path = btrfs_alloc_path();
>  	if (!path) {
> @@ -1863,13 +1864,9 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  	return ret;
>  }
>  
> -static inline int need_force_cow(struct btrfs_inode *inode, u64 start, u64 end)
> +static inline bool should_nocow(struct btrfs_inode *inode, u64 start, u64 end)
>  {
>  
> -	if (!(inode->flags & BTRFS_INODE_NODATACOW) &&
> -	    !(inode->flags & BTRFS_INODE_PREALLOC))
> -		return 0;
> -
>  	/*
>  	 * @defrag_bytes is a hint value, no spinlock held here,
>  	 * if is not zero, it means the file is defragging.
> @@ -1877,9 +1874,15 @@ static inline int need_force_cow(struct btrfs_inode *inode, u64 start, u64 end)
>  	 */
>  	if (inode->defrag_bytes &&
>  	    test_range_bit(&inode->io_tree, start, end, EXTENT_DEFRAG, 0, NULL))
> -		return 1;
> +		return false;
>  
> -	return 0;
> +	if (inode->flags & BTRFS_INODE_NODATACOW)
> +		return true;
> +
> +	if (inode->flags & BTRFS_INODE_PREALLOC)
> +		return true;

So here it needs to do test_range_bit first, while before the two checks
were fast path.

> +
> +	return false;
>  }
>  
>  /*
> @@ -1891,17 +1894,12 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
>  		struct writeback_control *wbc)
>  {
>  	int ret;
> -	int force_cow = need_force_cow(inode, start, end);
>  	const bool zoned = btrfs_is_zoned(inode->root->fs_info);
>  
> -	if (inode->flags & BTRFS_INODE_NODATACOW && !force_cow) {
> -		ASSERT(!zoned);
> -		ret = run_delalloc_nocow(inode, locked_page, start, end,
> -					 page_started, 1, nr_written);
> -	} else if (inode->flags & BTRFS_INODE_PREALLOC && !force_cow) {
> +	if (should_nocow(inode, start, end)) {
>  		ASSERT(!zoned);
>  		ret = run_delalloc_nocow(inode, locked_page, start, end,
> -					 page_started, 0, nr_written);
> +					 page_started, nr_written);

Merging the two calls into one branch makes sense so that all the
reasons for 'nocow' are in one helper, so ok.

>  	} else if (!inode_can_compress(inode) ||
>  		   !inode_need_compress(inode, start, end)) {
>  		if (zoned)
> -- 
> 2.30.1
