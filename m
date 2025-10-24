Return-Path: <linux-btrfs+bounces-18282-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD5AC05EF6
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 13:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67FF7582FD6
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 11:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD503176E0;
	Fri, 24 Oct 2025 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Il5Mb24p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530B3312814
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303504; cv=none; b=GumtQmU2KLSwM++M6nm71a+2Y0iIVyq3gv6kN0rNX8f8HIQsiVrJKfT6QQJ77aCy7hWX3zWaw+UwpRSmEY+upX5a1FA303M8ItlMYrmZCayCegOVya9Jh+5U1AHHC30DdevTcoAF1JV6i4PYlXVMzfVrbkeZ7b4SgsBoQUs5ZPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303504; c=relaxed/simple;
	bh=zxdE4iwxfZf5fMJriKzhhfGrtoHqDdoW8+ZLytvvZD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGy+L4lYy3k2Px4siLid0WuwFnUckVezQFTw4FmqGq8F1VFWgYkXNjZEXdCnIN9IwBoFVxCM5/72oghBMPq8098Fupdeu5Kcmt2sF2FDEneD/jXwcFpYfR+DS5k6dHJfF5O1G+n/ogDa0KxW2sn+/Lx96mStmc46eF52Tvcbc5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Il5Mb24p; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xS2JX1iX3jeYiEr2UVgnPoGCKLknHhwM5E3m+MtTLZc=; b=Il5Mb24pqsJIaL4Vcuw20/mwgW
	BE1EBI4xFxLLHtjTM2gfo/EltvWNPl430m24VDoByyORZKMUSmUGlPPBy6tMeVj8X5xQgh9gfIpAG
	lvOEpZbQ9Gfiy+HHov2/n52Z6z5H+CGPkkGenp1Nz4OwM54fUvF/WDKCvbbfKTWXn0Uj1ImV54CYe
	fE6MlqG54Ef80Wqq6nYM4TAqKuKSoxWbV/27IL2kOt1BFDScucFWBULOTTstzuWyFhvejCKuKjfo/
	pQVESuHc9CgncL/rb3yf9T2Q6YdgYI4iK1yfHCbY4Y2p0/E4jWpuSPENsjgLCsoTuLyXvqpD/7acT
	3wjSonAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCFUy-000000096Ar-3Htb;
	Fri, 24 Oct 2025 10:58:20 +0000
Date: Fri, 24 Oct 2025 03:58:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 4/4] btrfs: introduce btrfs_bio::async_csum
Message-ID: <aPtbzMCLwhuLuo4d@infradead.org>
References: <cover.1761302592.git.wqu@suse.com>
 <44a1532190aee561c2a8ae7af9f84fc1e092ae9e.1761302592.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44a1532190aee561c2a8ae7af9f84fc1e092ae9e.1761302592.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This seems to be a lot of overhead at least for simple checksums
like crc32c or xxhash.

Did you also look into Eric's

[PATCH 10/10] btrfs: switch to library APIs for checksums to reduce
the crypto API overhead, which is probably the worst overhead for
checksums right now?

On Fri, Oct 24, 2025 at 09:19:35PM +1030, Qu Wenruo wrote:
> [ENHANCEMENT]
> Btrfs currently calculate its data checksum then submit the bio.
> 
> But after commit 968f19c5b1b7 ("btrfs: always fallback to buffered write
> if the inode requires checksum"), any writes with data checksum will
> fallback to buffered IO, meaning the content will not change during
> writeback.
> 
> This means we're safe to calculate the data checksum and submit the bio
> in parallel, we only need to make sure btrfs_bio::end_io() is called
> after the checksum calculation is done.
> 
> As usual, such new feature is hidden behind the experimental flag.
> 
> [THEORETIC ANALYZE]
> Consider the following theoretic hardware performance, which should be
> more or less close to modern mainstream hardware:
> 
> 	Memory bandwidth:	50GiB/s
> 	CRC32C bandwidth:	45GiB/s
> 	SSD bandwidth:		8GiB/s
> 
> Then btrfs write bandwidth with data checksum before the patch would be
> 
> 	1 / ( 1 / 50 + 1 / 45 + 1 / 8) = 5.98 GiB/s
> 
> After the patch, the bandwidth would be:
> 
> 	1 / ( 1 / 50 + max( 1 / 45 + 1 / 8)) = 6.90 GiB/s
> 
> The difference would be 15.32 % improvement.
> 
> [REAL WORLD BENCHMARK]
> I'm using a Zen5 (HX 370) as the host, the VM has 4GiB memory, 10 vCPUs, the
> storage is backed by a PCIE gen3 x4 NVME SSD.
> 
> The test is a direct IO write, with 1MiB block size, write 7GiB data
> into a btrfs mount with data checksum. Thus the direct write will fallback
> to buffered one:
> 
> Vanilla Datasum:	1619.97 GiB/s
> Patched Datasum:	1792.26 GiB/s
> Diff			+10.6 %
> 
> In my case, the bottleneck is the storage, thus the improvement is not
> reaching the theoretic one, but still some observable improvement.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/bio.c       | 17 ++++++++----
>  fs/btrfs/bio.h       |  5 ++++
>  fs/btrfs/file-item.c | 61 +++++++++++++++++++++++++++++++-------------
>  fs/btrfs/file-item.h |  2 +-
>  4 files changed, 61 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 18272ef4b4d8..a5b83c6c9e7f 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -103,6 +103,9 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
>  	/* Make sure we're already in task context. */
>  	ASSERT(in_task());
>  
> +	if (bbio->async_csum)
> +		wait_for_completion(&bbio->csum_done);
> +
>  	bbio->bio.bi_status = status;
>  	if (bbio->bio.bi_pool == &btrfs_clone_bioset) {
>  		struct btrfs_bio *orig_bbio = bbio->private;
> @@ -535,7 +538,7 @@ static int btrfs_bio_csum(struct btrfs_bio *bbio)
>  {
>  	if (bbio->bio.bi_opf & REQ_META)
>  		return btree_csum_one_bio(bbio);
> -	return btrfs_csum_one_bio(bbio);
> +	return btrfs_csum_one_bio(bbio, true);
>  }
>  
>  /*
> @@ -613,10 +616,14 @@ static bool should_async_write(struct btrfs_bio *bbio)
>  	struct btrfs_fs_devices *fs_devices = bbio->fs_info->fs_devices;
>  	enum btrfs_offload_csum_mode csum_mode = READ_ONCE(fs_devices->offload_csum_mode);
>  
> -	if (csum_mode == BTRFS_OFFLOAD_CSUM_FORCE_OFF)
> -		return false;
> -
> -	auto_csum_mode = (csum_mode == BTRFS_OFFLOAD_CSUM_AUTO);
> +	if (csum_mode == BTRFS_OFFLOAD_CSUM_FORCE_ON)
> +		return true;
> +	/*
> +	 * Write bios will calculate checksum and submit bio at the same time.
> +	 * Unless explicitly required don't offload serial csum calculate and bio
> +	 * submit into a workqueue.
> +	 */
> +	return false;
>  #endif
>  
>  	/* Submit synchronously if the checksum implementation is fast. */
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index 00883aea55d7..277f2ac090d9 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -60,6 +60,8 @@ struct btrfs_bio {
>  		struct {
>  			struct btrfs_ordered_extent *ordered;
>  			struct btrfs_ordered_sum *sums;
> +			struct work_struct csum_work;
> +			struct completion csum_done;
>  			u64 orig_physical;
>  		};
>  
> @@ -84,6 +86,9 @@ struct btrfs_bio {
>  
>  	/* Use the commit root to look up csums (data read bio only). */
>  	bool csum_search_commit_root;
> +
> +	bool async_csum;
> +
>  	/*
>  	 * This member must come last, bio_alloc_bioset will allocate enough
>  	 * bytes for entire btrfs_bio but relies on bio being last.
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index a42e6d54e7cd..bedfcf4a088d 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -18,6 +18,7 @@
>  #include "fs.h"
>  #include "accessors.h"
>  #include "file-item.h"
> +#include "volumes.h"
>  
>  #define __MAX_CSUM_ITEMS(r, size) ((unsigned long)(((BTRFS_LEAF_DATA_SIZE(r) - \
>  				   sizeof(struct btrfs_item) * 2) / \
> @@ -764,21 +765,46 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
>  	return ret;
>  }
>  
> -/*
> - * Calculate checksums of the data contained inside a bio.
> - */
> -int btrfs_csum_one_bio(struct btrfs_bio *bbio)
> +static void csum_one_bio(struct btrfs_bio *bbio)
>  {
> -	struct btrfs_ordered_extent *ordered = bbio->ordered;
>  	struct btrfs_inode *inode = bbio->inode;
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>  	struct bio *bio = &bbio->bio;
> -	struct btrfs_ordered_sum *sums;
> +	struct btrfs_ordered_sum *sums = bbio->sums;
>  	struct bvec_iter iter = bio->bi_iter;
>  	phys_addr_t paddr;
>  	const u32 blocksize = fs_info->sectorsize;
> -	int index;
> +	int index = 0;
> +
> +	shash->tfm = fs_info->csum_shash;
> +
> +	btrfs_bio_for_each_block(paddr, bio, &iter, blocksize) {
> +		btrfs_calculate_block_csum(fs_info, paddr, sums->sums + index);
> +		index += fs_info->csum_size;
> +	}
> +}
> +
> +static void csum_one_bio_work(struct work_struct *work)
> +{
> +	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, csum_work);
> +
> +	ASSERT(btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE);
> +	ASSERT(bbio->async_csum == true);
> +	csum_one_bio(bbio);
> +	complete(&bbio->csum_done);
> +}
> +
> +/*
> + * Calculate checksums of the data contained inside a bio.
> + */
> +int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
> +{
> +	struct btrfs_ordered_extent *ordered = bbio->ordered;
> +	struct btrfs_inode *inode = bbio->inode;
> +	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> +	struct bio *bio = &bbio->bio;
> +	struct btrfs_ordered_sum *sums;
>  	unsigned nofs_flag;
>  
>  	nofs_flag = memalloc_nofs_save();
> @@ -789,21 +815,20 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio)
>  	if (!sums)
>  		return -ENOMEM;
>  
> +	sums->logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
>  	sums->len = bio->bi_iter.bi_size;
>  	INIT_LIST_HEAD(&sums->list);
> -
> -	sums->logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
> -	index = 0;
> -
> -	shash->tfm = fs_info->csum_shash;
> -
> -	btrfs_bio_for_each_block(paddr, bio, &iter, blocksize) {
> -		btrfs_calculate_block_csum(fs_info, paddr, sums->sums + index);
> -		index += fs_info->csum_size;
> -	}
> -
>  	bbio->sums = sums;
>  	btrfs_add_ordered_sum(ordered, sums);
> +
> +	if (!async) {
> +		csum_one_bio(bbio);
> +		return 0;
> +	}
> +	init_completion(&bbio->csum_done);
> +	bbio->async_csum = true;
> +	INIT_WORK(&bbio->csum_work, csum_one_bio_work);
> +	schedule_work(&bbio->csum_work);
>  	return 0;
>  }
>  
> diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
> index 63216c43676d..2a250cf8b2a1 100644
> --- a/fs/btrfs/file-item.h
> +++ b/fs/btrfs/file-item.h
> @@ -64,7 +64,7 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
>  int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
>  			   struct btrfs_root *root,
>  			   struct btrfs_ordered_sum *sums);
> -int btrfs_csum_one_bio(struct btrfs_bio *bbio);
> +int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async);
>  int btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
>  int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
>  			     struct list_head *list, int search_commit,
> -- 
> 2.51.0
> 
> 
---end quoted text---

