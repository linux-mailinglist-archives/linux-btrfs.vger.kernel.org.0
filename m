Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B1372844F
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 17:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236728AbjFHPzJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 11:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237630AbjFHPy6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 11:54:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C10811A
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 08:54:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9925C21A67;
        Thu,  8 Jun 2023 15:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686239192;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R6m1D8woDn7c0kVtdI4yMhLFC0abMZBuSFrDU6uJL5M=;
        b=AC6FOmJ1Sb2NsnlJhGtM90pkr4ZFotDSDABVnxkEe6DP7O3d14FkHA/IJan7Z0IYeXiDDH
        PAmPGq76EuAYG5EIBKgRwbO+f/x2E515JVyzxhd+j0pvJxTAPjybADaQIoZDGu49nbXeHe
        0nLHQ+oU28+6YUKTav1xqYGEuF5TAeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686239192;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R6m1D8woDn7c0kVtdI4yMhLFC0abMZBuSFrDU6uJL5M=;
        b=Th5BaiQst06ZMoB9IwBGuyZQLkRy35d0NIzQSWfsAbPBMHMb2rX1ta57DQK/LVFr9i/FMm
        hbr9MieNM3G8MkCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6740B138E6;
        Thu,  8 Jun 2023 15:46:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PRxbGNj3gWS7IgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 08 Jun 2023 15:46:32 +0000
Date:   Thu, 8 Jun 2023 17:40:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: allocate dummy ordereded_sums objects for nocsum
 I/O on zoned file systems
Message-ID: <20230608154015.GK28933@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230608121410.275766-1-hch@lst.de>
 <20230608121410.275766-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608121410.275766-2-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 08, 2023 at 02:14:10PM +0200, Christoph Hellwig wrote:
> Zoned file systems now need the ordereded_sums structure to record the
> actual write location returned by zone append, so allocate dummy
> structures without the csum array for them when the I/O doesn't use
> checksums, and free them when completing the ordered_extent.
> 
> Fixes: 177b0eb2c180 ("btrfs: optimize the logical to physical mapping for zoned writes")

This patch is still in the devlopment queue so I don't want to do a
separate fix. Please send an incremental update that cleanly applies to
the patch.

There's a minor conflict in context of btrfs_finish_ordered_zoned in
zoned.c which only sets up the fs_info, so trivial to fix but the new
helper btrfs_alloc_dummy_sum() uses bbio->ordered which is not available
at this time and was added in a different series ("btrfs: add an
ordered_extent pointer to struct btrfs_bio").

Due to that there may be a cascading change needed in other patches in
misc-next but that should be fixable, the logic of adding bbio::ordered
is clear.

> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -773,6 +773,22 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
>  	return 0;
>  }
>  
> +/*
> + * Nodatasum I/O on zoned file systems still requires an btrfs_ordered_sum to
> + * record the updated logical address on Zone Append completion.
> + * Allocate just the structure with an empty sums array here for that case.
> + */
> +blk_status_t btrfs_alloc_dummy_sum(struct btrfs_bio *bbio)
> +{
> +	bbio->sums = kmalloc(sizeof(*bbio->sums), GFP_NOFS);
> +	if (!bbio->sums)
> +		return BLK_STS_RESOURCE;
> +	bbio->sums->len = bbio->bio.bi_iter.bi_size;
> +	bbio->sums->logical = bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
> +	btrfs_add_ordered_sum(bbio->ordered, bbio->sums);

bbio->ordered not available

> +	return 0;
> +}
> +
>  /*
>   * Remove one checksum overlapping a range.
>   *
> diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
> index 6be8725cd57474..4ec669b690080a 100644
> --- a/fs/btrfs/file-item.h
> +++ b/fs/btrfs/file-item.h
> @@ -50,6 +50,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
>  			   struct btrfs_root *root,
>  			   struct btrfs_ordered_sum *sums);
>  blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio);
> +blk_status_t btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
>  int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
>  			     struct list_head *list, int search_commit,
>  			     bool nowait);
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index bbde4ddd475492..637b2a2f45c94e 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1702,7 +1702,8 @@ static bool btrfs_zoned_split_ordered(struct btrfs_ordered_extent *ordered,
>  
>  void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
>  {
> -	struct btrfs_fs_info *fs_info = btrfs_sb(ordered->inode->i_sb);
> +	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
> +	struct btrfs_fs_info *fs_info = inode->root->fs_info;

Minor conflict here, function name is btrfs_rewrite_logical_zoned() and
inode/fs_info are obtained from extenta map tree.

>  	struct btrfs_ordered_sum *sum =
>  		list_first_entry(&ordered->list, typeof(*sum), list);
>  	u64 logical = sum->logical;
> @@ -1717,7 +1718,7 @@ void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
>  		if (!btrfs_zoned_split_ordered(ordered, logical, len)) {
>  			set_bit(BTRFS_ORDERED_IOERR, &ordered->flags);
>  			btrfs_err(fs_info, "failed to split ordered extent\n");
> -			return;
> +			goto out;
>  		}
>  		logical = sum->logical;
>  		len = sum->len;
> @@ -1725,6 +1726,22 @@ void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
>  
>  	if (ordered->disk_bytenr != logical)
>  		btrfs_rewrite_logical_zoned(ordered, logical);
> +
> +out:
> +	/*
> +	 * If we end up here for nodatasum I/O, the btrfs_ordered_sum structures
> +	 * were allocated by btrfs_alloc_dummy_sum only to record the logical
> +	 * addresses and don't contain actual checksums.  We thus must free them
> +	 * here so that we don't attempt to log the csums later.
> +	 */
> +	if ((inode->flags & BTRFS_INODE_NODATASUM) ||
> +	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state)) {
> +		while ((sum = list_first_entry_or_null(&ordered->list,
> +						       typeof(*sum), list))) {
> +			list_del(&sum->list);
> +			kfree(sum);
> +		}
> +	}
>  }
