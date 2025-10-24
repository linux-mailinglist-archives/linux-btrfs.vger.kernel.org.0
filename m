Return-Path: <linux-btrfs+bounces-18291-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC72CC06CD4
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 16:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6768B1A672CE
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 14:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038D92475C2;
	Fri, 24 Oct 2025 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="x4BpJsu+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fca2+UZY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4177121323C
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317479; cv=none; b=ix/q+ljpz7BceGZTeCwkHJP2HBPPeCmzV8P0GwSi8xzCV8XbgksK771sXQQTr644SahIbGn40eJiHZ8VBFS+kmgSSCf5I8NBy4XGxKkrHvyvsDlKn+K4ZzuxJWbEueWS0mYVSUYKPqD2iBqzUb5az1JqknvKAxtfkiEPZ5vMb6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317479; c=relaxed/simple;
	bh=j5TDz5x9/wbMS7+KNbExyNhYXrNHrXBztu/+faEmVE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTM1kROu6gHbGT2d1GRQJ1Wjg/Ejclm7Oxp3NNXRrikGOWCb/f2T2exAyg7opqDJRpzWMfrDwmof+vDsFuntgcM+U3yqOzjZ9oqBHIvnlfHO6semREdZ+5mFp/+m8WIEBmfxe7aBRjneTpQOucBkYdY8B8UCUqySPnQtFJTiSh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=x4BpJsu+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fca2+UZY; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1FF19140022A;
	Fri, 24 Oct 2025 10:51:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 24 Oct 2025 10:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761317475; x=1761403875; bh=MQpsnH9ad+
	WXxHyHUNDaKUhj6Uy02YCRmhmoU31193U=; b=x4BpJsu+SW6P90nM+ALty+jQze
	aVB0M4QmFZs/Nmu+9bkkvbpFi6HPmMuUIZhPEiT5edaZ1VE2psc8qv++QFFnN8SQ
	eiIwiQ8CEhQK9mtSpCjbnIJpWIlWJV7LvXfTGYHeE0P9ETTuFD9E0D8rBr2EkswE
	t9xaOIfg+zfR1YnUIxjDwRVZfLk6cqRbpq31zX7SRokUj3O8IUD7XrlMAB2yzZUa
	1Be/Ohaqm5Be4df+sOzn6bi5UIYpNf7FQeND9g5Y5oriuWmTbdqNplWd2+oG1k1Z
	pF7McNaGw6TBqhHiNhli5SCzVsO9b57PxcVfHj+ygYZBdGuaclxjejOpO+MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761317475; x=1761403875; bh=MQpsnH9ad+WXxHyHUNDaKUhj6Uy02YCRmhm
	oU31193U=; b=Fca2+UZYIb+3wiMA4SbtbX6HC/SzvHkNP0QGvvabbXCBN79PJGw
	tmhfvU+rmIW+WtlPFEJYtvrbimvjNwp2NtsN31ka52q3cjrdN75wlg3uCC4G9JWY
	J9/nxuIvX75QBJs71LKqDvk2+lq6JpHfT9NQg7/pcuTF7U9sadN1CYMTmI5EfmAk
	XaRQLZzLKdq16Hn5it5tqMQMUSEoIm42FeqepukpBdaBjUVQo6r4PKGMxnufrmCk
	HQZ/sdEPGJoiSC/OjFKtgYLkX4Wyo+9KcklCBYNVEHU3pG5loe8ShL6Y6sYUtccY
	fLR+biMUWseC3ZouETkOaEk9d0Ec9Fn1kQw==
X-ME-Sender: <xms:YpL7aGBU8ujMd6Wo-ZuxicLPhvDnuntstjZu-SBrVM_v9FSAWb0_5Q>
    <xme:YpL7aGjMD8iXurmiOmUJ9ORLswZzRL6-RNYcl0aDXzBggcsquSw4rV9jJCmN_pd7S
    1XDy6Z43ZPdlyn_k53y1KRsIMi_dF_hWMLZiO1pb47WfYKLR59TCGw>
X-ME-Received: <xmr:YpL7aHNuiDT-YrCaBAUh1vVvD5GhTE1BkIJ5qGF4wt_WQPUKKKg7lrwl3kUnww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeelieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YpL7aP6hMKXGFX_KtO2LiKszmr_TknjO6sbY20JobbeCvbwNFFyPTQ>
    <xmx:YpL7aN2qLYsQxgs9DDDBcaYeNZwZuveZswSttxZ4PnrYOltSerYHug>
    <xmx:YpL7aIY5SBEroE_hnmQw_IzRWISbakqaWEIq83Gpn7ijzVUehsWWUg>
    <xmx:YpL7aNCUi1YUNomDWxItJytVB-rkCxNCxiapuYZ7YV1Abz1ckepGPg>
    <xmx:Y5L7aAPvIjJhc6kJjs2PX3XVTuMKlpLbhz3UZW3NnKi1FTl7PNcEAudJ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 10:51:13 -0400 (EDT)
Date: Fri, 24 Oct 2025 07:51:10 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: introduce btrfs_bio::async_csum
Message-ID: <aPuSQ/fZyE/4LRQ7@devvm12410.ftw0.facebook.com>
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

This is really awesome! Makes me think we could also async the read csum
lookup...

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

This is a principled way to do it; ensure the whole endio path has the
csums. However, as far as I know, the only place that the sums are only
needed at finish_ordered_io when we call add_pending_csums() from
btrfs_finish_one_ordered(), which is already able to block.

So I think you could separate the need to change the workers from the
async csums if you delay the async csum wait until add_pending_csum. It
might be a little annoying to have to recover the bbio/wait context from
the ordered_extent with container_of, but I'm sure it can be managed.

One other "benefit" is that it technically delays the wait even further,
till the absolute last second, so it is strictly less waiting, though I
wouldn't expect any real benefit from that in practice.

Thanks,
Boris

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

