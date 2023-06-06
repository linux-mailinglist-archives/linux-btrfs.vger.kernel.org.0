Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0208D7249FD
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 19:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbjFFRSC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 13:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238366AbjFFRSA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 13:18:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF81F121
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 10:17:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 851C71FD79;
        Tue,  6 Jun 2023 17:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686071878;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pvaC67rvh5+ZmB/briAiEoMlTZn6mzX/CwmhLVVZNTU=;
        b=pk4epV+WbQETQ/+PaLJBF77XcZoGG2v2pX6W+5D4pryy0xtZvcm3T2Tv8ZBvSx83DVxBBO
        F5y6W56XfAW7PYbRM0wUm3DrNiMKru5bL32BmXxpv+H8Z+yOSyr+IBAg3TLb2dP5w1uCga
        17GuMI+kgUFioxShAcCECZzuhhFx5os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686071878;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pvaC67rvh5+ZmB/briAiEoMlTZn6mzX/CwmhLVVZNTU=;
        b=XuMhsfNrPRYCEkhNFl/hN5ae1K+zZv5uKtgGtg+1fZI4O/W46SNls+lHTtT+piL14bRfQN
        Z5DIAH88/QWZCVCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C72713519;
        Tue,  6 Jun 2023 17:17:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PmDWEUZqf2T4VgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 06 Jun 2023 17:17:58 +0000
Date:   Tue, 6 Jun 2023 19:11:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: allocate dummy ordereded_sums objects for
 nocsum I/O on zoned file systems
Message-ID: <20230606171143.GM25292@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230605084519.580346-1-hch@lst.de>
 <20230605084519.580346-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605084519.580346-3-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 05, 2023 at 10:45:19AM +0200, Christoph Hellwig wrote:
> Zoned file systems now need the ordereded_sums structure to record the
> actual write location returned by zone append, so allocate dummy
> structures without the csum array for them when the I/O doesn't use
> checksums, and free them when completing the ordered_extent.
> 
> Fixes: 5a1b7f2b6306 ("btrfs: optimize the logical to physical mapping for zoned writes")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/bio.c       |  4 ++++
>  fs/btrfs/file-item.c | 12 ++++++++++--
>  fs/btrfs/zoned.c     | 11 ++++++++++-
>  3 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 627d06fbb4c425..2482739be49163 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -668,6 +668,10 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>  			ret = btrfs_bio_csum(bbio);
>  			if (ret)
>  				goto fail_put_bio;
> +		} else if (use_append) {
> +			ret = btrfs_csum_one_bio(bbio);
> +			if (ret)
> +				goto fail_put_bio;
>  		}
>  	}
>  
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 5e6603e76e5ac0..1308c369b1ebd8 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -751,8 +751,16 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
>  	sums->logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
>  	index = 0;
>  
> -	shash->tfm = fs_info->csum_shash;
> +	/*
> +	 * If we are called for a nodatasum inode, this means we are on a zoned
> +	 * file system.  In this case a ordered_csum structure needs to be
> +	 * allocated to track the logical address actually written, but it does
> +	 * notactually carry any checksums.
> +	 */
> +	if (btrfs_inode_is_nodatasum(inode))

So nodatasum in checksum bio implies zoned mode, this looks fragile. Why
can't you check btrfs_is_zoned() instead? The comment is needed but I
don't agree the condition should omit zoned mode itself.

> +		goto done;
>  
> +	shash->tfm = fs_info->csum_shash;
>  	bio_for_each_segment(bvec, bio, iter) {
>  		if (!ordered) {
>  			ordered = btrfs_lookup_ordered_extent(inode, offset);
> @@ -817,7 +825,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
>  
>  	}
>  	this_sum_bytes = 0;
> -
> +done:
>  	/*
>  	 * The ->sums assignment is for zoned writes, where a bio never spans
>  	 * ordered extents and is only done unconditionally because that's cheaper
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index bbde4ddd475492..1f5497b9b2695c 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1717,7 +1717,7 @@ void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
>  		if (!btrfs_zoned_split_ordered(ordered, logical, len)) {
>  			set_bit(BTRFS_ORDERED_IOERR, &ordered->flags);
>  			btrfs_err(fs_info, "failed to split ordered extent\n");
> -			return;
> +			goto out;
>  		}
>  		logical = sum->logical;
>  		len = sum->len;
> @@ -1725,6 +1725,15 @@ void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
>  
>  	if (ordered->disk_bytenr != logical)
>  		btrfs_rewrite_logical_zoned(ordered, logical);
> +
> +out:
> +	if (btrfs_inode_is_nodatasum(BTRFS_I(ordered->inode))) {

The zoned mode here is implied by the calling function, open coding the
condtions should not be a big deal, i.e. not needing the helper.

> +		while ((sum = list_first_entry_or_null(&ordered->list,
> +						       typeof(*sum), list))) {
> +			list_del(&sum->list);
> +			kfree(sum);
> +		}
> +	}
>  }
>  
>  bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
> -- 
> 2.39.2
