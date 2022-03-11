Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911044D6181
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 13:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242683AbiCKMaJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 07:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiCKMaI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 07:30:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FDB13D7B
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 04:29:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFA4DB82B70
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 12:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160E7C340E9;
        Fri, 11 Mar 2022 12:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647001742;
        bh=cwidxhKYP6WtBH7uYjuh4Qv+hK1vAHCHNxbM60JdJBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D7BqkZ/eaSIAW5Y8vS5kP1vU+qkw61ZaBbgAfw/4J+Y7c9FNiZPnAK6oqsU1YTlu2
         LSJX6edDtebAdAF5pLAvi7kLA++4Vfhz70P6ed32l3Zf4tD2pDpPoBjOzxRCG8z74K
         TxSIYyuO39Ln7LiIzxl00SapzJntlTDIqwDI0mCWOshWTQBwGSw9KGa5We8x0+PhB4
         4Xjkob+IhlpRZN/5TZbuX9Tt+6LSvjUZ5vGJoL9J+LLnWy688kYq3TL4cM9/Pcaoow
         CQ1So1QN69VuOplFkwsNS2eqoDFRB+tzNPiZ6TEF3vgDcJaPduzK5NawNWE3Y5vGNj
         kIb4RIQSGIx8g==
Date:   Fri, 11 Mar 2022 12:28:58 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix fallocate to use file_modified to update
 permissions consistently
Message-ID: <YitAiiQ+cpbGZ2K/@debian9.Home>
References: <20220310192245.GA8165@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310192245.GA8165@magnolia>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 10, 2022 at 11:22:45AM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Since the initial introduction of (posix) fallocate back at the turn of
> the century, it has been possible to use this syscall to change the
> user-visible contents of files.  This can happen by extending the file
> size during a preallocation, or through any of the newer modes (punch,
> zero range).  Because the call can be used to change file contents, we
> should treat it like we do any other modification to a file -- update
> the mtime, and drop set[ug]id privileges/capabilities.
> 
> The VFS function file_modified() does all this for us if pass it a
> locked inode, so let's make fallocate drop permissions correctly.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
> Note: I plan to add fstests to test this behavior, but after the
> generic/673 mess, I'm holding back on them until I can fix the three
> major filesystems and clean up the xfs setattr_copy code.
> 
> https://lore.kernel.org/linux-ext4/20220310174410.GB8172@magnolia/T/#u
> ---
>  fs/btrfs/file.c |   23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index a0179cc62913..79e61c88b9e7 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2918,8 +2918,9 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
>  	return ret;
>  }
>  
> -static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
> +static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
>  {
> +	struct inode *inode = file_inode(file);
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct btrfs_root *root = BTRFS_I(inode)->root;
>  	struct extent_state *cached_state = NULL;
> @@ -2951,6 +2952,10 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  		goto out_only_mutex;
>  	}
>  
> +	ret = file_modified(file);
> +	if (ret)
> +		goto out_only_mutex;
> +
>  	lockstart = round_up(offset, btrfs_inode_sectorsize(BTRFS_I(inode)));
>  	lockend = round_down(offset + len,
>  			     btrfs_inode_sectorsize(BTRFS_I(inode))) - 1;
> @@ -3177,11 +3182,12 @@ static int btrfs_zero_range_check_range_boundary(struct btrfs_inode *inode,
>  	return ret;
>  }
>  
> -static int btrfs_zero_range(struct inode *inode,
> +static int btrfs_zero_range(struct file *file,
>  			    loff_t offset,
>  			    loff_t len,
>  			    const int mode)
>  {
> +	struct inode *inode = file_inode(file);
>  	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
>  	struct extent_map *em;
>  	struct extent_changeset *data_reserved = NULL;
> @@ -3202,6 +3208,12 @@ static int btrfs_zero_range(struct inode *inode,
>  		goto out;
>  	}
>  
> +	ret = file_modified(file);
> +	if (ret) {
> +		free_extent_map(em);
> +		goto out;
> +	}
> +

Could be done before getting the extent map, to make the code a bit shorter, or
see the comment below.

>  	/*
>  	 * Avoid hole punching and extent allocation for some cases. More cases
>  	 * could be considered, but these are unlikely common and we keep things
> @@ -3391,7 +3403,7 @@ static long btrfs_fallocate(struct file *file, int mode,
>  		return -EOPNOTSUPP;
>  
>  	if (mode & FALLOC_FL_PUNCH_HOLE)
> -		return btrfs_punch_hole(inode, offset, len);
> +		return btrfs_punch_hole(file, offset, len);
>  
>  	/*
>  	 * Only trigger disk allocation, don't trigger qgroup reserve
> @@ -3446,7 +3458,7 @@ static long btrfs_fallocate(struct file *file, int mode,
>  		goto out;
>  
>  	if (mode & FALLOC_FL_ZERO_RANGE) {
> -		ret = btrfs_zero_range(inode, offset, len, mode);
> +		ret = btrfs_zero_range(file, offset, len, mode);
>  		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
>  		return ret;
>  	}
> @@ -3528,6 +3540,9 @@ static long btrfs_fallocate(struct file *file, int mode,
>  		cur_offset = last_byte;
>  	}
>  
> +	if (!ret)
> +		ret = file_modified(file);

If call file_modified() before the if that checks for the zero range case,
then we avoid having to call file_modified() at btrfs_zero_range() too,
and get the behaviour for both plain fallocate and zero range.

Otherwise, it looks good.

Thanks for doing this, I had it on my todo list since I noticed the generic/673
failure with reflinks and the suid/sgid bits.

> +
>  	/*
>  	 * If ret is still 0, means we're OK to fallocate.
>  	 * Or just cleanup the list and exit.
