Return-Path: <linux-btrfs+bounces-1975-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB1A84490E
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 21:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE4029021E
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 20:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD42D38DDB;
	Wed, 31 Jan 2024 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="lFWar+4U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E2138FAA
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 20:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706733713; cv=none; b=ORtIk7mHNfDZDsBRDE4x3Uf13OHkULL+qti431A0ug19irq7Wy2QIkzKRsvMSExg+dnrCRc6xZu3nGk7nE7831SES+d34YU5Vu3gZYhuzTVfCVJ83C9/qxwYZhE7Dx6mZArzn5sT78LKHKjZWr9pvKwBMPhyg/sLdMsJJWC6ITY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706733713; c=relaxed/simple;
	bh=6AJOumOwU3lGrjfTqXweqd+2rUMyS8ROR8eYeZ752HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abvCdapqzzFN1Tz/ov691XQYyVLChqTaeaLLxVD+8xXA6+HwYbI59rRjUOCexlyi6551RHYqs01L9yvHIp/NPYT8iMI+8gLXvPyrqEYaMhFIY4LorzrE2cKdVcHLHlbUGZebsh+34uNmsP2kGGmJc4U8m218Cevrk+GDZwc30xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=lFWar+4U; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc226bad48cso147479276.3
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 12:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706733710; x=1707338510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O9nFRkJh91Bnnb6zCvOXiM/IRlcjZlBEPqU++gxWlRE=;
        b=lFWar+4Ub3fkSUV36csrynhdNQRj+qq8deL2MxD+M8B/GgUUTEH7dETSHFB3XwPAz+
         QHF5EDmMlgMV+YCK8zbM8fZbe1nyegFo2Z7cVQmZwPH3+FqcPA7LL23ZJTcSe8Rrn141
         XI2/ie/r2tS16FKqIAvXzVupCs2sq3XP0//U0fqXbgw6r8w10aoXjULSQ+S7+fUWl7JU
         rFULZaz9pk4DSIFDGHiKxv7Fs90hVavj7LJ0E9xXgjXGQC33iElRPhsQPGncv9Eu+sOF
         qFWcI36aaRNO+OrHamMTZGz50B4QINWGSqK3ZA/kENmZwMsubSTb1QfIxfE3ZgC6cAor
         SnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706733710; x=1707338510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9nFRkJh91Bnnb6zCvOXiM/IRlcjZlBEPqU++gxWlRE=;
        b=waAiycTUgGVU5kON/qXQog1tUVtZQOiq6N9k67FtENDFb6xWv40WrEHLPJOQwUXTbJ
         xZTvRD3D0H5LQxeXtDXnEnN4o2/s9Q7Ai7gMIr7YAi5AGRMkpSPaG+JDJRhsj3X8YXJs
         allBFGnMQJJd+jh4V1k2cvQ8LSejWWCx0/n33CQ13OreFcRYm49WdAR8NI8ziW2umD89
         ZiM+pKYYVd584zKTcVb8Tn9FA5MxKHOArhvDuUABlNRY79bRl3nvh6LnD2N0EKqP+mZP
         9324n5doawr7VujhoNVM6wnk3hSivFbLROBDRuCwHw3FjgS9E4UGLFR7QX7bjaeZ0D1u
         hSWA==
X-Gm-Message-State: AOJu0YzT8mzq/cpkwje/EOafrZPVXytllTXb7/Kc6PTNIhGRDiB+5/xM
	Qlh8ihwJYmDYyNkB38Nc+MbFUDFUPJGise2mse5fSvdxsu0SRv6IczO6wgSnz9bS1q21dQRqWtN
	f
X-Google-Smtp-Source: AGHT+IGeEq7VvSrFZiLE8XcO117XynxhHL1k4P1FkJ5xruXkM/tFF0t/+C3PQX/a+jCWJhXK/ixHpA==
X-Received: by 2002:a25:7188:0:b0:dbc:d57f:4632 with SMTP id m130-20020a257188000000b00dbcd57f4632mr184036ybc.61.1706733710265;
        Wed, 31 Jan 2024 12:41:50 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id lv7-20020a056214578700b0068691ce0e74sm5872968qvb.0.2024.01.31.12.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 12:41:49 -0800 (PST)
Date: Wed, 31 Jan 2024 15:41:48 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: preallocate temporary extent buffer for inode
 logging when needed
Message-ID: <20240131204148.GA3203388@perftesting>
References: <1ef0997eee1fbe194ab2546f34052cd4e27c6ef4.1706612525.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ef0997eee1fbe194ab2546f34052cd4e27c6ef4.1706612525.git.fdmanana@suse.com>

On Tue, Jan 30, 2024 at 11:05:44AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When logging an inode and we require to copy items from subvolume leaves
> to the log tree, we clone each subvolume leaf and than use that clone to
> copy items to the log tree. This is required to avoid possible deadlocks
> as stated in commit 796787c978ef ("btrfs: do not modify log tree while
> holding a leaf from fs tree locked").
> 
> The cloning requires allocating an extent buffer (struct extent_buffer)
> and then allocating pages (folios) to attach to the extent buffer. This
> may be slow in case we are under memory pressure, and since we are doing
> the cloning while holding a read lock on a subvolume leaf, it means we
> can be blocking other operations on that leaf for significant periods of
> time, which can increase latency on operations like creating other files,
> renaming files, etc. Similarly because we're under a log transaction, we
> may also cause extra delay on other tasks doing an fsync, because syncing
> the log requires waiting for tasks that joined a log transaction to exit
> the transaction.
> 
> So to improve this, for any inode logging operation that needs to copy
> items from a subvolume leaf ("full sync" or "copy everything" bit set
> in the inode), preallocate a dummy extent buffer before locking any
> extent buffer from the subvolume tree, and even before joining a log
> transaction, add it to the log context and then use it when we need to
> copy items from a subvolume leaf to the log tree. This avoids making
> other operations get extra latency when waiting to lock a subvolume
> leaf that is used during inode logging and we are under heavy memory
> pressure.
> 
> The following test script with bonnie++ was used to test this:
> 
>   $ cat test.sh
>   #!/bin/bash
> 
>   DEV=/dev/sdh
>   MNT=/mnt/sdh
>   MOUNT_OPTIONS="-o ssd"
> 
>   MEMTOTAL_BYTES=`free -b | grep Mem: | awk '{ print $2 }'`
>   NR_DIRECTORIES=20
>   NR_FILES=20480
>   DATASET_SIZE=$((MEMTOTAL_BYTES * 2 / 1048576))
>   DIRECTORY_SIZE=$((MEMTOTAL_BYTES * 2 / NR_FILES))
>   NR_FILES=$((NR_FILES / 1024))
> 
>   echo "performance" | \
>       tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> 
>   umount $DEV &> /dev/null
>   mkfs.btrfs -f $MKFS_OPTIONS $DEV
>   mount $MOUNT_OPTIONS $DEV $MNT
> 
>   bonnie++ -u root -d $MNT \
>       -n $NR_FILES:$DIRECTORY_SIZE:$DIRECTORY_SIZE:$NR_DIRECTORIES \
>       -r 0 -s $DATASET_SIZE -b
> 
>   umount $MNT
> 
> The results of this test on a 8G VM running a non-debug kernel (Debian's
> default kernel config), were the following.
> 
> Before this change:
> 
>   Version 2.00a       ------Sequential Output------ --Sequential Input- --Random-
>                       -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
>   Name:Size etc        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
>   debian0       7501M  376k  99  1.4g  96  117m  14 1510k  99  2.5g  95 +++++ +++
>   Latency             35068us   24976us    2944ms   30725us   71770us   26152us
>   Version 2.00a       ------Sequential Create------ --------Random Create--------
>   debian0             -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
>   files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
>   20:384100:384100/20 20480  32 20480  58 20480  48 20480  39 20480  56 20480  61
>   Latency               411ms   11914us     119ms     617ms   10296us     110ms
> 
> After this change:
> 
>   Version 2.00a       ------Sequential Output------ --Sequential Input- --Random-
>                       -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
>   Name:Size etc        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
>   debian0       7501M  375k  99  1.4g  97  117m  14 1546k  99  2.3g  98 +++++ +++
>   Latency             35975us  20945us    2144ms   10297us    2217us    6004us
>   Version 2.00a       ------Sequential Create------ --------Random Create--------
>   debian0             -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
>   files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
>   20:384100:384100/20 20480  35 20480  58 20480  48 20480  40 20480  57 20480  59
>   Latency               320ms   11237us   77779us     518ms    6470us   86389us
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/file.c     | 12 ++++++
>  fs/btrfs/tree-log.c | 93 +++++++++++++++++++++++++++------------------
>  fs/btrfs/tree-log.h | 25 ++++++++++++
>  3 files changed, 94 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index f8e1a7ce3d39..fd5e23035a28 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1912,6 +1912,8 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
>  		goto out_release_extents;
>  	}
>  
> +	btrfs_init_log_ctx_scratch_eb(&ctx);
> +
>  	/*
>  	 * We use start here because we will need to wait on the IO to complete
>  	 * in btrfs_sync_log, which could require joining a transaction (for
> @@ -1931,6 +1933,15 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
>  	trans->in_fsync = true;
>  
>  	ret = btrfs_log_dentry_safe(trans, dentry, &ctx);
> +	/*
> +	 * Scratch eb no longer needed, release before syncing log or commit
> +	 * transaction, to avoid holding unnecessary memory during such long
> +	 * operations.
> +	 */
> +	if (ctx.scratch_eb) {
> +		free_extent_buffer(ctx.scratch_eb);
> +		ctx.scratch_eb = NULL;
> +	}
>  	btrfs_release_log_ctx_extents(&ctx);
>  	if (ret < 0) {
>  		/* Fallthrough and commit/free transaction. */
> @@ -2006,6 +2017,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
>  
>  	ret = btrfs_commit_transaction(trans);
>  out:
> +	free_extent_buffer(ctx.scratch_eb);
>  	ASSERT(list_empty(&ctx.list));
>  	ASSERT(list_empty(&ctx.conflict_inodes));
>  	err = file_check_and_advance_wb_err(file);
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 331fc7429952..761b13b3d342 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -3619,6 +3619,30 @@ static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
>  	return ret;
>  }
>  
> +static int clone_leaf(struct btrfs_path *path, struct btrfs_log_ctx *ctx)
> +{
> +	const int slot = path->slots[0];
> +
> +	if (ctx->scratch_eb) {
> +		copy_extent_buffer_full(ctx->scratch_eb, path->nodes[0]);
> +	} else {
> +		ctx->scratch_eb = btrfs_clone_extent_buffer(path->nodes[0]);
> +		if (!ctx->scratch_eb)
> +			return -ENOMEM;
> +	}
> +
> +	btrfs_release_path(path);
> +	path->nodes[0] = ctx->scratch_eb;

Here we put the scratch_b into path->nodes[0], so if we go do the next leaf in
the copy_items loop we'll drop our reference for this scratch_eb, and then we're
just writing into free'd memory.  Am I missing something here?  Thanks,

Josef

