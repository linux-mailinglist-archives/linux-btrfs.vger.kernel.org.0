Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB44F3800AD
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 01:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhEMXGo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 May 2021 19:06:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:52402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhEMXGo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 May 2021 19:06:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BFC9EAEAA;
        Thu, 13 May 2021 23:05:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 41EDEDA8EB; Fri, 14 May 2021 01:03:02 +0200 (CEST)
Date:   Fri, 14 May 2021 01:03:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [Patch v2 05/42] btrfs: refactor submit_extent_page() to make
 bio and its flag tracing easier
Message-ID: <20210513230302.GO7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-6-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427230349.369603-6-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 28, 2021 at 07:03:12AM +0800, Qu Wenruo wrote:
> There are a lot of code inside extent_io.c needs both "struct bio
> **bio_ret" and "unsigned long prev_bio_flags", along with some parameter
> like "unsigned long bio_flags".
> 
> Such strange parameters are here for bio assembly.
> 
> For example, we have such inode page layout:
> 
> 0	4K	8K	12K
> |<-- Extent A-->|<- EB->|
> 
> Then what we do is:
> - Page [0, 4K)
>   *bio_ret = NULL
>   So we allocate a new bio to bio_ret,
>   Add page [0, 4K) to *bio_ret.
> 
> - Page [4K, 8K)
>   *bio_ret != NULL
>   We found this page is continuous to *bio_ret,
>   and if we're not at stripe boundary, we
>   add page [4K, 8K) to *bio_ret.
> 
> - Page [8K, 12K)
>   *bio_ret != NULL
>   But we found this page is not continuous, so
>   we submit *bio_ret, then allocate a new bio,
>   and add page [8K, 12K) to the new bio.
> 
> This means we need to record both the bio and its bio_flag, but we
> record them manually using those strange parameter list, other than
> encapsulating them into their own structure.
> 
> So this patch will introduce a new structure, btrfs_bio_ctrl, to record
> both the bio, and its bio_flags.
> 
> Also, in above case, for all pages added to the bio, we need to check if
> the new page crosses stripe boundary.
> This check itself can be time consuming, and we don't really need to do
> that for each page.
> 
> This patch also integrate the stripe boundary check into btrfs_bio_ctrl.
> When a new bio is allocated, the stripe and ordered extent boundary is
> also calculated, so no matter how large the bio will be, we only
> calculate the boundaries once, to save some CPU time.
> 
> The following functions/structures are affected:
> - struct extent_page_data
>   Replace its bio pointer with structure btrfs_bio_ctrl (embedded
>   structure, not pointer)
> 
> - end_write_bio()
> - flush_write_bio()
>   Just change how bio is fetched
> 
> - btrfs_bio_add_page()
>   Use pre-calculated boundaries instead of re-calculating them.
>   And use @bio_ctrl to replace @bio and @prev_bio_flags.
> 
> - calc_bio_boundaries()
>   New function
> 
> - submit_extent_page() callers
> - btrfs_do_readpage() callers
> - contiguous_readpages() callers
>   To Use @bio_ctrl to replace @bio and @prev_bio_flags, and how to grab
>   bio.
> 
> - btrfs_bio_fits_in_ordered_extent()
>   Removed, as now the ordered extent size limit is done at bio
>   allocation time, no need to check for each page range.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ctree.h     |   2 -
>  fs/btrfs/extent_io.c | 214 ++++++++++++++++++++++++++++---------------
>  fs/btrfs/extent_io.h |  13 ++-
>  fs/btrfs/inode.c     |  36 +-------
>  4 files changed, 154 insertions(+), 111 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 278e0cbc9a98..b94790583008 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3146,8 +3146,6 @@ void btrfs_split_delalloc_extent(struct inode *inode,
>  				 struct extent_state *orig, u64 split);
>  int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
>  			     unsigned long bio_flags);
> -bool btrfs_bio_fits_in_ordered_extent(struct page *page, struct bio *bio,
> -				      unsigned int size);
>  void btrfs_set_range_writeback(struct extent_io_tree *tree, u64 start, u64 end);
>  vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf);
>  int btrfs_readpage(struct file *file, struct page *page);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 8e18dc9a415d..949b603e7aa3 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -136,7 +136,7 @@ struct tree_entry {
>  };
>  
>  struct extent_page_data {
> -	struct bio *bio;
> +	struct btrfs_bio_ctrl bio_ctrl;
>  	/* tells writepage not to lock the state bits for this range
>  	 * it still does the unlocking
>  	 */
> @@ -185,10 +185,12 @@ int __must_check submit_one_bio(struct bio *bio, int mirror_num,
>  /* Cleanup unsubmitted bios */
>  static void end_write_bio(struct extent_page_data *epd, int ret)
>  {
> -	if (epd->bio) {
> -		epd->bio->bi_status = errno_to_blk_status(ret);
> -		bio_endio(epd->bio);
> -		epd->bio = NULL;
> +	struct bio *bio = epd->bio_ctrl.bio;

We've been using _ctl suffix for the control structures that affect
behaviour of functions that take it as a parameter. I haven't modified
the patch to avoid conflicts with other patches but as a further cleanup
it would be good to get that unified to _ctl.

>  static int submit_extent_page(unsigned int opf,
>  			      struct writeback_control *wbc,
> +			      struct btrfs_bio_ctrl *bio_ctrl,
>  			      struct page *page, u64 disk_bytenr,
>  			      size_t size, unsigned long pg_offset,
> -			      struct bio **bio_ret,
>  			      bio_end_io_t end_io_func,
>  			      int mirror_num,
> -			      unsigned long prev_bio_flags,
>  			      unsigned long bio_flags,
>  			      bool force_bio_submit)

This function has been a challenge for anybody who likes to do cleanups.
I have a few branches that try to do so but no luck yet, so I appreciate
any reduction of the parameters with potential to move more of them to
the control structure.
