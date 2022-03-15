Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3641F4D99A6
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 11:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345262AbiCOKxu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 06:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347603AbiCOKwp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 06:52:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDC853703
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 03:50:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D1F16124A
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 10:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A2AC340ED;
        Tue, 15 Mar 2022 10:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647341409;
        bh=wOf5voORa/0j20v5xF+VXL8qGTh2iFqBFoNs1tMdpJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bcrknZQU3rjyoDLFNtaoTOXi6vh4h4YS00elc0Jh3X3IQhaCKwcJaHxXYUFwIz9YY
         XUNgZ4woI9XlAR38QlpYcjwe/4KdsnRXGf2CAPOqs77vHWgRl39UtccSezDd7LMbNQ
         pz6vngrnJZRpvl/0FH+3JSCrrLfhwFrKEjBOK+OcFNLhW7xOqjLofe3AE5qzLcsq2R
         BP8Ih1rHQAieitmM2huBVHK7aTEYMdNgMTMqoklTN25JIXewWvw5xW/3NFFfD176py
         N6sp/MxeQ23BG5BZCihxYfao6e3/aADYR7ZrlsjLMJQM8FBV06LoniwxgJ3Skzqek6
         lxWHstO0c90FQ==
Date:   Tue, 15 Mar 2022 10:50:05 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: fix fallocate to use file_modified to update
 permissions consistently
Message-ID: <YjBvXWVmy8ooT9FP@debian9.Home>
References: <20220314175532.GB8165@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314175532.GB8165@magnolia>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 14, 2022 at 10:55:32AM -0700, Darrick J. Wong wrote:
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
> v2: move up file_modified to catch a case where we could modify file
> contents but fail on something else before we end up calling
> file_modified


Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks, it looks good Darrick.
It also survived a few full fstests runs.

> ---
>  fs/btrfs/file.c |   13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index a0179cc62913..28ddd9cf2069 100644
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
> @@ -3391,7 +3396,7 @@ static long btrfs_fallocate(struct file *file, int mode,
>  		return -EOPNOTSUPP;
>  
>  	if (mode & FALLOC_FL_PUNCH_HOLE)
> -		return btrfs_punch_hole(inode, offset, len);
> +		return btrfs_punch_hole(file, offset, len);
>  
>  	/*
>  	 * Only trigger disk allocation, don't trigger qgroup reserve
> @@ -3413,6 +3418,10 @@ static long btrfs_fallocate(struct file *file, int mode,
>  			goto out;
>  	}
>  
> +	ret = file_modified(file);
> +	if (ret)
> +		goto out;
> +
>  	/*
>  	 * TODO: Move these two operations after we have checked
>  	 * accurate reserved space, or fallocate can still fail but
