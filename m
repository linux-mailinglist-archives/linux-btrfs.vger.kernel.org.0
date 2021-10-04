Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2204217D5
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 21:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhJDTol (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 15:44:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51648 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhJDTol (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 15:44:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1318F1FE0E;
        Mon,  4 Oct 2021 19:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633376571;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0DIb+/zZjD5Cnw3YASDOFsfYfjtYryuN5oPjCx6udHQ=;
        b=c+8CQ4x9pipeKTN64nn4TCVrT2rc1slDaOJDUWJgjliff7qWL/dAWxerjiuomOLO/KNe7h
        Mj+TryU9VTAXAd5czH8kQ3JukeGaVl4jFMiC8K8AkGPTxQLB5WcgGMQDf9xqfHL79MLGYR
        9xgkwOjQJOK349BlLnNAuQmhH22D9q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633376571;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0DIb+/zZjD5Cnw3YASDOFsfYfjtYryuN5oPjCx6udHQ=;
        b=bZnWwzEEbco2ZH4UeGuTn/S65+XAtqkBCIvGljW9U/wpyFCP0L7tGhMGUxKFiD9w/hHvsf
        WtxycveFAonKz0DQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0D488A3B84;
        Mon,  4 Oct 2021 19:42:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BB61EDA7F3; Mon,  4 Oct 2021 21:42:31 +0200 (CEST)
Date:   Mon, 4 Oct 2021 21:42:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 10/26] btrfs: introduce submit_compressed_bio() for
 compression
Message-ID: <20211004194231.GC9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210927072208.21634-1-wqu@suse.com>
 <20210927072208.21634-11-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927072208.21634-11-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 27, 2021 at 03:21:52PM +0800, Qu Wenruo wrote:
> The new helper, submit_compressed_bio(), will aggregate the following
> work:
> 
> - Increase compressed_bio::pending_bios
> - Remap the endio function
> - Map and submit the bio
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/compression.c | 45 ++++++++++++++++++------------------------
>  1 file changed, 19 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index b6ed5933caf5..3f0be97d17f3 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -422,6 +422,21 @@ static void end_compressed_bio_write(struct bio *bio)
>  	bio_put(bio);
>  }
>  
> +static blk_status_t submit_compressed_bio(struct btrfs_fs_info *fs_info,
> +					  struct compressed_bio *cb,
> +					  struct bio *bio, int mirror_num)
> +{
> +	blk_status_t ret;
> +
> +	ASSERT(bio->bi_iter.bi_size);
> +	atomic_inc(&cb->pending_bios);
> +	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
> +	if (ret)
> +		return ret;
> +	ret = btrfs_map_bio(fs_info, bio, mirror_num);
> +	return ret;
> +}
> +
>  /*
>   * worker function to build and submit bios for previously compressed pages.
>   * The corresponding pages in the inode should be marked for writeback
> @@ -518,19 +533,13 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>  
>  		page->mapping = NULL;
>  		if (submit || len < PAGE_SIZE) {
> -			atomic_inc(&cb->pending_bios);
> -			ret = btrfs_bio_wq_end_io(fs_info, bio,
> -						  BTRFS_WQ_ENDIO_DATA);
> -			if (ret)
> -				goto finish_cb;
> -
>  			if (!skip_sum) {
>  				ret = btrfs_csum_one_bio(inode, bio, start, 1);
>  				if (ret)
>  					goto finish_cb;
>  			}
>  
> -			ret = btrfs_map_bio(fs_info, bio, 0);
> +			ret = submit_compressed_bio(fs_info, cb, bio, 0);

Can you please send me an explanation why it's still OK to aggregate the
calls as it changes the order. Originally there's

	atomic_inc
	btrfs_bio_wq_end_io
	btrfs_csum_one_bio
	btrfs_map_bio

While in the new code:

	btrfs_csum_one_bio
	from submit_compressed_bio:
		atomic_inc
		btrfs_bio_wq_end_io
		btrfs_map_bio

So in particular the order of

atomic_inc+btrfs_bio_wq_end_io is in reverse order with
btrfs_csum_one_bio

> @@ -889,7 +887,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  						  fs_info->sectorsize);
>  			sums += fs_info->csum_size * nr_sectors;
>  
> -			ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
> +			ret = submit_compressed_bio(fs_info, cb, comp_bio, mirror_num);
>  			if (ret)
>  				goto finish_cb;
>  
> @@ -904,16 +902,11 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  		cur_disk_byte += pg_len;
>  	}
>  
> -	atomic_inc(&cb->pending_bios);
> -	ret = btrfs_bio_wq_end_io(fs_info, comp_bio, BTRFS_WQ_ENDIO_DATA);
> -	if (ret)
> -		goto last_bio;
> -
>  	ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
>  	if (ret)
>  		goto last_bio;
>  
> -	ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
> +	ret = submit_compressed_bio(fs_info, cb, comp_bio, mirror_num);

Same for btrfs_lookup_bio_sums instead of btrfs_csum_one_bio.
