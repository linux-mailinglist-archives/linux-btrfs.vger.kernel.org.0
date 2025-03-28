Return-Path: <linux-btrfs+bounces-12650-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C127A74E40
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 17:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A093A6CFC
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 16:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC131D8DF6;
	Fri, 28 Mar 2025 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Ud5ea76H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F2BAOQr0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835A11D89E9
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743178174; cv=none; b=TkEtLvRI88Dyu+uT00oJtAWeR2YshgEHpiU/1PLxvc7WU7oYkvAK/JDMq0fE7VZCkfgRPHUK/ck0P+FE7vePhMgGfjjllASbi/NfL4JWGK7GzO2R5N64mxDbdsN3tPCQB/HN7W+kC9DWqeS/9BbgLIle92Msu5dabhTpfPXC7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743178174; c=relaxed/simple;
	bh=EPmJk/XNHyl80nl02CXtD9j+BQVRwEIhJnVm6eyETV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvDzQ4Yv5CKWN/wfr9BQQZeuoBGXWPkabSqNi0RXyIq/SBiILnKI7Gj5mDNJ4CuBa6MbUWzKCouolpgP3J53dYUBf/UzW+1QvQsyRy/YCqa4gOWkAGPLNQqKBn+cB+23AGVux//R7wV47v7QQq/zUPg1lhZ1M5J5kAcRTa4xrJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Ud5ea76H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F2BAOQr0; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 63EF42540122;
	Fri, 28 Mar 2025 12:09:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 28 Mar 2025 12:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1743178170; x=1743264570; bh=Baic48OB/s
	nqmuhHI24lVl3DGUJccV3HSXb4DvD/XRA=; b=Ud5ea76HGmZefmyWQWqDX8Je8A
	ElcLfDJNf5crdLVeY11LGpTFHUIVNjdP6yB8rVI8PB9g4k9kCLI25xPj4Uhpcyae
	LO1x36tR9oOjSILiIUNXdNL4WNKiekaf0CUImpzULOjitqfv9pRNk6OOsXHHyvTk
	igGipHBYjzlvOpBglQrRxLDXjEuoHwPEYUgUcLspyYFQDqRiWOofLrk4X6nxaoyb
	5GpXJ2L1CksVeZRDmUMqtsG14YgDO3BdIYwxXy+GIeZ3FzH4CUEQlpQClrTvNloo
	Jcq/8GlKFX8CD3b9lFRLbxQjlXWZvx8o2hj864rCGYnCvW0vInUj4mku6XBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743178170; x=1743264570; bh=Baic48OB/snqmuhHI24lVl3DGUJccV3HSXb
	4DvD/XRA=; b=F2BAOQr0HcsWtByLtFVJ9IEkfSfRO/hxQ++7Byml9qT6Y9f0P6U
	FHC0Cr700BeOHapp6B5vv9P58FpTwEPIx5TOpkfGb71waKqcWfFV9/1DY+DXuI8Y
	7onCYo1hn6+Cj/HhDi1iRm5XEtwuprDLeuE7aXpXhiig4L1vqauT/6bowuukc1Ad
	Htfof/W4t9lujKqGixEnwAVHc4V6zPBZlwbLBHLx5vtHg7xiRe47TYLCF5M5PwKm
	A9FAY4hcKGU2OkKL9xtka9z6lL5CVJNx0zdXvXn3n+uttiNzzYBmPHXWYHEaFBZK
	4MPhjFOhmoXx6JJpZZpXM0XC7NAH+OETtTg==
X-ME-Sender: <xms:usnmZ3kYdY-bgWtXrH5RPuCw27CJauCq0FF-jQjcJWzfj1UkRnczag>
    <xme:usnmZ609Wg6-iAJ-pTrjvfar9lZq9TyQ6PyYF1YrBvg8ubx_mtgH7HdWup75NFviQ
    e_2E6n5kTEuLkPvwas>
X-ME-Received: <xmr:usnmZ9oIsgjdBIQzjKuYHT6BRdR15cvpp8dlrSkJf4yJPycb4WBG_eTctRqsrFQVSnl2a0Rwzg6eug1ENQtwC9TglQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedujeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhho
    vhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeelle
    fhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfughm
    rghnrghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:usnmZ_kMnSF8UK29LhjEctuQwKRc_C0YBQsSmcRCprzJiXKPOYmlGQ>
    <xmx:usnmZ10AVonY54MpmQCFW3umlR71ni1D20i3Tc_Qt41AJ8fI5Szy8A>
    <xmx:usnmZ-tRlDp4x3Vs2DbZBbaDmKAEKY5_f1MS1diVbBOlw87sUsl0oQ>
    <xmx:usnmZ5WUAfRk9Q7GMnsYkKla5uTpNR-tYAj5vtox9cm-mavKoylzhg>
    <xmx:usnmZzDci6s5UHh95w3uHEJKgRPQ2gJ3-Is7PW4ENOS_p3wacUkps0zK>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 12:09:29 -0400 (EDT)
Date: Fri, 28 Mar 2025 09:10:21 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix fsync of files with no hard links not
 persisting deletion
Message-ID: <20250328161021.GA1042522@zen.localdomain>
References: <5b44edaf3e472a234a13e8cf2dd8c96f35970996.1742490795.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b44edaf3e472a234a13e8cf2dd8c96f35970996.1742490795.git.fdmanana@suse.com>

On Fri, Mar 21, 2025 at 11:08:53AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we fsync a file (or directory) that has no more hard links, because
> while a process had a file descriptor open on it, the file's last hard
> link was removed and then the process did an fsync against the file
> descriptor, after a power failure or crash the file still exists after
> replaying the log.
> 
> This behaviour is incorrect since once an inode has no more hard links
> it's not accessible anymore and we insert an orphan item into its
> subvolume's tree so that the deletion of all its items is not missed in
> case of a power failure or crash.
> 
> So after log replay the file shouldn't exist anymore, which is also the
> behaviour on ext4, xfs, f2fs and other filesystems.
> 
> Fix this by not ignoring inodes with zero hard links at
> btrfs_log_inode_parent() and by comitting an inode's delayed inode when
> we are not doing a fast fsync (either BTRFS_INODE_COPY_EVERYTHING or
> BTRFS_INODE_NEEDS_FULL_SYNC is set in the inode's runtime flags). This
> last step is necessary because when removing the last hard link we don't
> delete the corresponding ref (or extref) item, instead we record the
> change in the inode's delayed inode with the BTRFS_DELAYED_NODE_DEL_IREF
> flag, so that when the delayed inode is committed we delete the ref/extref
> item from the inode's subvolume tree - otherwise the logging code will log
> the last hard link and therefore upon log replay the inode is not deleted.
> 
> The base code for a fstests test case that reproduces this bug is the
> following:
> 
>    . ./common/dmflakey
> 
>    _require_scratch
>    _require_dm_target flakey
>    _require_mknod
> 
>    _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
>    _require_metadata_journaling $SCRATCH_DEV
>    _init_flakey
>    _mount_flakey
> 
>    touch $SCRATCH_MNT/foo
> 
>    # Commit the current transaction and persist the file.
>    _scratch_sync
> 
>    # A fifo to communicate with a background xfs_io process that will
>    # fsync the file after we deleted its hard link while it's open by
>    # xfs_io.
>    mkfifo $SCRATCH_MNT/fifo
> 
>    tail -f $SCRATCH_MNT/fifo | \
>         $XFS_IO_PROG $SCRATCH_MNT/foo >>$seqres.full &
>    XFS_IO_PID=$!
> 
>    # Give some time for the xfs_io process to open a file descriptor for
>    # the file.
>    sleep 1
> 
>    # Now while the file is open by the xfs_io process, delete its only
>    # hard link.
>    rm -f $SCRATCH_MNT/foo
> 
>    # Now that it has no more hard links, make the xfs_io process fsync it.
>    echo "fsync" > $SCRATCH_MNT/fifo

What specifies the ordering semantics between the rm and fsync if they
come from different processes?

i.e., if you did the rm in a different process, it seems like the unlink
could race with your new check and still let the file live. OTOH, if the
rm comes fully "after" the fsync, that is what we would expect anyway,
so I can't figure out how to reason about it :)

Are guarantees about fs ops being visible after fsync only applicable in
the same process?

Repro and fix look good otherwise, so if that race is definitionally not
a concern you can add:
Reviewed-by: Boris Burkov <boris@bur.io>

Less important, but I think it might be worthwhile to also include
some reasoning in the commit message about why this change is safe
for O_TMPFILE w.r.t fsync and crashes.

Thanks,
Boris

> 
>    # Terminate the xfs_io process so that we can unmount.
>    echo "quit" > $SCRATCH_MNT/fifo
>    wait $XFS_IO_PID
>    unset XFS_IO_PID
> 
>    # Simulate a power failure and then mount again the filesystem to
>    # replay the journal/log.
>    _flakey_drop_and_remount
> 
>    # We don't expect the file to exist anymore, since it was fsynced when
>    # it had no more hard links.
>    [ -f $SCRATCH_MNT/foo ] && echo "file foo still exists"
> 
>    _unmount_flakey
> 
>    # success, all done
>    echo "Silence is golden"
>    status=0
>    exit
> 
> A test case for fstests will be submitted soon.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/tree-log.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 90dc094cfa5e..f5af11565b87 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -6583,6 +6583,19 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
>  		btrfs_log_get_delayed_items(inode, &delayed_ins_list,
>  					    &delayed_del_list);
>  
> +	/*
> +	 * If we are fsyncing a file with 0 hard links, then commit the delayed
> +	 * inode because the last inode ref (or extref) item may still be in the
> +	 * subvolume tree and if we log it the file will still exist after a log
> +	 * replay. So commit the delayed inode to delete that last ref and we
> +	 * skip logging it.
> +	 */
> +	if (inode->vfs_inode.i_nlink == 0) {
> +		ret = btrfs_commit_inode_delayed_inode(inode);
> +		if (ret)
> +			goto out_unlock;
> +	}
> +
>  	ret = copy_inode_items_to_log(trans, inode, &min_key, &max_key,
>  				      path, dst_path, logged_isize,
>  				      inode_only, ctx,
> @@ -7051,14 +7064,9 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
>  	if (btrfs_root_generation(&root->root_item) == trans->transid)
>  		return BTRFS_LOG_FORCE_COMMIT;
>  
> -	/*
> -	 * Skip already logged inodes or inodes corresponding to tmpfiles
> -	 * (since logging them is pointless, a link count of 0 means they
> -	 * will never be accessible).
> -	 */
> -	if ((btrfs_inode_in_log(inode, trans->transid) &&
> -	     list_empty(&ctx->ordered_extents)) ||
> -	    inode->vfs_inode.i_nlink == 0)
> +	/* Skip already logged inodes and without new extents. */
> +	if (btrfs_inode_in_log(inode, trans->transid) &&
> +	    list_empty(&ctx->ordered_extents))
>  		return BTRFS_NO_LOG_SYNC;
>  
>  	ret = start_log_trans(trans, root, ctx);
> -- 
> 2.45.2
> 

