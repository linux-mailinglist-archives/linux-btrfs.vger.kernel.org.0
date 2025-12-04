Return-Path: <linux-btrfs+bounces-19525-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DFACA3B93
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 14:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 298BD3112470
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 13:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942BC33F388;
	Thu,  4 Dec 2025 13:04:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E035033F37F
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764853473; cv=none; b=pFeFLxX8IZ+7G8s48IYptUsi1yqmGUvBdlsDjENuMziEIrQCF1G7FiS/8oNtbC94z+UPCU/r17s9WhJuyi+bhETTeIkUuk207Z6DvJYLD5Q543SbiluaByBWDL5qeaOaRZiTVXLF/6sd7zLBzSFPUlA86Fl9oY2tKlvVkyKUyvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764853473; c=relaxed/simple;
	bh=QDNW4p83aYOdjGk0ChnNOgzVr51/3l5A+Qk4GNT2yGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUX6yhYRipOPcjfehrl1kl8048friqPTzzz9Tg0YK3e+WZE+pcHAdRxoKc8HlJ4mcW0tMi8SIFyO+bDWMa+zjygpy97zG0wTrUclAVpDsawkGqKKx6maxlA0zgYQTMKNNVGEVlBvP6T5el/wF+4EapmbnciLro0SW/j4Bbj6Bpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 758DD68D0D; Thu,  4 Dec 2025 14:04:26 +0100 (CET)
Date: Thu, 4 Dec 2025 14:04:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v3 1/5] btrfs: zoned: don't zone append to conventional
 zone
Message-ID: <20251204130426.GA26743@lst.de>
References: <20251204124227.431678-1-johannes.thumshirn@wdc.com> <20251204124227.431678-2-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204124227.431678-2-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

On Thu, Dec 04, 2025 at 01:42:23PM +0100, Johannes Thumshirn wrote:
> In case of a zoned RAID, it can happen that a data write is targeting a
> sequential write required zone and a conventional zone. In this case the
> bio will be marked as REQ_OP_ZONE_APPEND but for the conventional zone,
> this needs to be REQ_OP_WRITE.
> 
> The setting of REQ_OP_ZONE_APPEND is deferred to the last possible time in
> btrfs_submit_dev_bio(), but the decision if we can use zone append is
> cached in btrfs_bio.
> 
> Cc: Naohiro Aota <naohiro.aota@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Fixes: e9b9b911e03c ("btrfs: add raid stripe tree to features enabled with debug config")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/bio.c | 20 ++++++++++----------
>  fs/btrfs/bio.h |  3 +++
>  2 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 4a7bef895b97..33149f07e62d 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -480,6 +480,8 @@ static void btrfs_clone_write_end_io(struct bio *bio)
>  
>  static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
>  {
> +	u64 physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
> +
>  	if (!dev || !dev->bdev ||
>  	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
>  	    (btrfs_op(bio) == BTRFS_MAP_WRITE &&
> @@ -494,12 +496,14 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
>  	 * For zone append writing, bi_sector must point the beginning of the
>  	 * zone
>  	 */
> -	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> -		u64 physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
> +	if (btrfs_bio(bio)->can_use_append &&
> +	    btrfs_dev_is_sequential(dev, physical)) {
>  		u64 zone_start = round_down(physical, dev->fs_info->zone_size);
>  
>  		ASSERT(btrfs_dev_is_sequential(dev, physical));
>  		bio->bi_iter.bi_sector = zone_start >> SECTOR_SHIFT;
> +		bio->bi_opf &= ~REQ_OP_WRITE;
> +		bio->bi_opf |= REQ_OP_ZONE_APPEND;
>  	}
>  	btrfs_debug(dev->fs_info,
>  	"%s: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
> @@ -747,7 +751,6 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>  	u64 logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
>  	u64 length = bio->bi_iter.bi_size;
>  	u64 map_length = length;
> -	bool use_append = btrfs_use_zone_append(bbio);
>  	struct btrfs_io_context *bioc = NULL;
>  	struct btrfs_io_stripe smap;
>  	blk_status_t status;
> @@ -775,8 +778,10 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>  	if (bio_op(bio) == REQ_OP_WRITE && is_data_bbio(bbio))
>  		bbio->orig_logical = logical;
>  
> +	bbio->can_use_append = btrfs_use_zone_append(bbio);
> +
>  	map_length = min(map_length, length);
> -	if (use_append)
> +	if (bbio->can_use_append)
>  		map_length = btrfs_append_map_length(bbio, map_length);
>  
>  	if (map_length < length) {
> @@ -805,11 +810,6 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>  	}
>  
>  	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
> -		if (use_append) {
> -			bio->bi_opf &= ~REQ_OP_WRITE;
> -			bio->bi_opf |= REQ_OP_ZONE_APPEND;
> -		}
> -
>  		if (is_data_bbio(bbio) && bioc && bioc->use_rst) {
>  			/*
>  			 * No locking for the list update, as we only add to
> @@ -836,7 +836,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>  			status = errno_to_blk_status(ret);
>  			if (status)
>  				goto fail;
> -		} else if (use_append ||
> +		} else if (bbio->can_use_append ||
>  			   (btrfs_is_zoned(fs_info) && inode &&
>  			    inode->flags & BTRFS_INODE_NODATASUM)) {
>  			ret = btrfs_alloc_dummy_sum(bbio);
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index 56279b7f3b2a..d6da9ed08bfa 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -92,6 +92,9 @@ struct btrfs_bio {
>  	/* Whether the csum generation for data write is async. */
>  	bool async_csum;
>  
> +	/* Whether the bio is written using zone append. */
> +	bool can_use_append;
> +
>  	/*
>  	 * This member must come last, bio_alloc_bioset will allocate enough
>  	 * bytes for entire btrfs_bio but relies on bio being last.
> -- 
> 2.52.0
---end quoted text---

