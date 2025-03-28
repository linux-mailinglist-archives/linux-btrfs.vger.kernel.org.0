Return-Path: <linux-btrfs+bounces-12660-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C44CA750A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 20:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0084F3B502D
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 19:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0881E04BB;
	Fri, 28 Mar 2025 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="qBcO/VdA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LVsxvbAx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC49D482EF
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743188867; cv=none; b=sXfDIihQclpCf3PtUMTd2iCFBuUC1laEkjgVMUJQVOV6ybW6eheLSaXKnT1LiDaeB8aZySoxL7CKbRdYFR4EEQQEd8H/PaXlXXrnhFSL3SZk7V2KM43QnvSrXv3A0xCFprlwke3pFvGam01U90kc79M4f+iA3uA7VmNVjRmg9VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743188867; c=relaxed/simple;
	bh=cDGFF2oJV3E81bgLJLv3JOoUmNszOMDIoBc8TRl5uw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwgVnYaldEEOJ65Pv2MdVzuOrfYrxZN3N3JgAyB5yefGt/509i71NNdPSghT+qN4hDQ7oVa11nOLw9m/UOOyNB2EoCfbo7RFuD5qxF2SWiA8CHo/HE1vIu9l3YQXJ1K4ixVrYUHiat72OGHgIpMeX+kSda0O2HUmRR+h2fUjjuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=qBcO/VdA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LVsxvbAx; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C36C625400D3;
	Fri, 28 Mar 2025 15:07:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 28 Mar 2025 15:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1743188863;
	 x=1743275263; bh=YJ4zP93Z6PwG4y9hRbJxC2Fc2xsBBOAvgfesyrg34KU=; b=
	qBcO/VdAdLeB2Kvc6BNP+RbG5Z9VR+zgcsMcX6TG4uz1mLPa6VFF/8nO5YYxz1JH
	pGzcKs4MkjrZ6VOJdZG4uXSteX3YuVFSahv1K9ppUrm+/Ld2PpY3Ih3YJ0FHKXFY
	K+gLfvEZ1HswE0imj3/liNHAB6RxUSEORBkSdZkdmYK9beW0Du+Fv2OK66BqK2i3
	jYuqa/WA1Gvadz5Q9+U8YQufz88eo21C++IEsaM/L1XBSGda5963vatG+nbh+ShY
	NselTa660FnQ46/kIpkm11+Q/jxkycD5UYWUujsdG/KhNth/R+ZeywnHGskUR8TD
	ApIDC2xTgvtp9Uomv1d+hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743188863; x=
	1743275263; bh=YJ4zP93Z6PwG4y9hRbJxC2Fc2xsBBOAvgfesyrg34KU=; b=L
	VsxvbAxdKmb3GnPVLzZKT6Xv7/6JQ1LoeitAwlbzbm4WAXWSnhXvg1ZdZU/hr9g3
	2fPsdmLrRH3788AmOdvkbgrAqnnxW5nVx3lReR28UTGtSV6yFhAQ/xxfZN6wE+wi
	B2uh4ydPXJZcMAVrkmSWrRpFUggtxZmBx4e7fpbbEc+Qy7uYVKAQ/rhg5Fntonhg
	elnJiIVZVhmn9PENkkC+UlHvA+u0+wOstT1mKkTEks6xuKMrohkxQMVsmjtvGDrz
	Y1ztlkZMDyKRkGN2puMJnfJr/lX8miD8L5O4IA5I44OQHj77PBeyFBd4IekG2V+O
	1iDGUE5dLRkvqV3k2tTRg==
X-ME-Sender: <xms:f_PmZxi49iHagXOD0iX0kUqN8-Mc2Xw60IuLKwAQbTJgV2BnDxPaOQ>
    <xme:f_PmZ2AOiO17MyJmypHNgzi3Xg_Ae6j_hleE4jLzJJEwbg-Dv5ikfvjWcvTFr0iln
    eLNfmh7nuGU-NmzubM>
X-ME-Received: <xmr:f_PmZxG3uNeVnj0JSFfQCkX3kJqC01Om-YbhU2gEFg88lIw_4TzHrVTdlxxnWKDUVMDkkWooQjVSWHk2reG3XbV8fKs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedvtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioh
    eqnecuggftrfgrthhtvghrnhepudelhfdthfetuddvtefhfedtiedtteehvddtkedvledt
    vdevgedtuedutdeitdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:f_PmZ2SkrpQ9fVipaiSI8Uiw04ugPdu9zcpjr8bUM72KOD-o6icOiw>
    <xmx:f_PmZ-yagbZOy3vMGgcaeW69vwrWB-rBq7gv1UPE4y6vXJxl8sWqDQ>
    <xmx:f_PmZ86a1SDcBIwMgVvvlftJoLuWkLTakUyjK0tq2dkXAth5wwtAcQ>
    <xmx:f_PmZzyPjbCxExYa8TiZjuNpSzxIvl1KI0hYUpvtLFASqgE5YrRoDQ>
    <xmx:f_PmZ5-Z1LrvhCPJZw5-yRugJwWzwsJDVIKnarMKBWjJUXcYY98VszNU>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 15:07:42 -0400 (EDT)
Date: Fri, 28 Mar 2025 12:08:35 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix fsync of files with no hard links not
 persisting deletion
Message-ID: <20250328190835.GA1118426@zen.localdomain>
References: <5b44edaf3e472a234a13e8cf2dd8c96f35970996.1742490795.git.fdmanana@suse.com>
 <20250328161021.GA1042522@zen.localdomain>
 <CAL3q7H73A+5=pjc_QuhR136j1B8ndZV=M2c+a6Tfy=zCRmsJXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H73A+5=pjc_QuhR136j1B8ndZV=M2c+a6Tfy=zCRmsJXQ@mail.gmail.com>

On Fri, Mar 28, 2025 at 05:00:32PM +0000, Filipe Manana wrote:
> On Fri, Mar 28, 2025 at 4:09 PM Boris Burkov <boris@bur.io> wrote:
> >
> > On Fri, Mar 21, 2025 at 11:08:53AM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > If we fsync a file (or directory) that has no more hard links, because
> > > while a process had a file descriptor open on it, the file's last hard
> > > link was removed and then the process did an fsync against the file
> > > descriptor, after a power failure or crash the file still exists after
> > > replaying the log.
> > >
> > > This behaviour is incorrect since once an inode has no more hard links
> > > it's not accessible anymore and we insert an orphan item into its
> > > subvolume's tree so that the deletion of all its items is not missed in
> > > case of a power failure or crash.
> > >
> > > So after log replay the file shouldn't exist anymore, which is also the
> > > behaviour on ext4, xfs, f2fs and other filesystems.
> > >
> > > Fix this by not ignoring inodes with zero hard links at
> > > btrfs_log_inode_parent() and by comitting an inode's delayed inode when
> > > we are not doing a fast fsync (either BTRFS_INODE_COPY_EVERYTHING or
> > > BTRFS_INODE_NEEDS_FULL_SYNC is set in the inode's runtime flags). This
> > > last step is necessary because when removing the last hard link we don't
> > > delete the corresponding ref (or extref) item, instead we record the
> > > change in the inode's delayed inode with the BTRFS_DELAYED_NODE_DEL_IREF
> > > flag, so that when the delayed inode is committed we delete the ref/extref
> > > item from the inode's subvolume tree - otherwise the logging code will log
> > > the last hard link and therefore upon log replay the inode is not deleted.
> > >
> > > The base code for a fstests test case that reproduces this bug is the
> > > following:
> > >
> > >    . ./common/dmflakey
> > >
> > >    _require_scratch
> > >    _require_dm_target flakey
> > >    _require_mknod
> > >
> > >    _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> > >    _require_metadata_journaling $SCRATCH_DEV
> > >    _init_flakey
> > >    _mount_flakey
> > >
> > >    touch $SCRATCH_MNT/foo
> > >
> > >    # Commit the current transaction and persist the file.
> > >    _scratch_sync
> > >
> > >    # A fifo to communicate with a background xfs_io process that will
> > >    # fsync the file after we deleted its hard link while it's open by
> > >    # xfs_io.
> > >    mkfifo $SCRATCH_MNT/fifo
> > >
> > >    tail -f $SCRATCH_MNT/fifo | \
> > >         $XFS_IO_PROG $SCRATCH_MNT/foo >>$seqres.full &
> > >    XFS_IO_PID=$!
> > >
> > >    # Give some time for the xfs_io process to open a file descriptor for
> > >    # the file.
> > >    sleep 1
> > >
> > >    # Now while the file is open by the xfs_io process, delete its only
> > >    # hard link.
> > >    rm -f $SCRATCH_MNT/foo
> > >
> > >    # Now that it has no more hard links, make the xfs_io process fsync it.
> > >    echo "fsync" > $SCRATCH_MNT/fifo
> >
> > What specifies the ordering semantics between the rm and fsync if they
> > come from different processes?
> 
> An fsync is required to persist all data and metadata changes to a
> file that happened before the fsync.
> It doesn't matter which process does the changes or the fsync.
> 
> 

My main concern is that "before" is a pretty loaded term in concurrent
systems. I obviously don't need to explain that to you, just trying to
make my position more clear.

> >
> > i.e., if you did the rm in a different process, it seems like the unlink
> > could race with your new check and still let the file live. OTOH, if the
> > rm comes fully "after" the fsync, that is what we would expect anyway,
> > so I can't figure out how to reason about it :)
> 
> Race how?
> fsync takes the inode mutex, and so does every write and metadata
> change to the inode.
> 

This would be an excellent explanation for how there can be no race. I
looked into it some more and I'm not 100% convinced.

Concerning unlink vs fsync, I see the following:

vfs_unlink() uses the vfs inode_lock() wrapping i_ops->unlink(). Our
unlink() is btrfs_unlink() which eventually calls drop_nlink() in
btrfs_unlink_inode() with no additional locking apparent. Notably, I
don't see it using btrfs_lock_inode() with any mode.

vfs_fsync() does not take inode_lock() around i_ops->fsync(). Our
fsync() is btrfs_sync_file() which uses btrfs_inode_lock() to take the
btrfs inode mmap rwsem inode->i_mmap_lock.

So I don't see how those operations are exclusive, but I would not be
remotely suprised if I missed something, since that is quite
surprising...

> >
> > Are guarantees about fs ops being visible after fsync only applicable in
> > the same process?
> 
> They are applicable to all changes made by any process before the fsync.
> Even the first line from the man page makes that clear:
> 
> "fsync, fdatasync - synchronize a file's in-core state with storage device"
> 

Neither the man page nor the posix fsync spec stipulate anything about
what locking is required of the filesystem, at least not in a way that
is apparent to me.

> > Repro and fix look good otherwise, so if that race is definitionally not
> > a concern you can add:
> > Reviewed-by: Boris Burkov <boris@bur.io>
> >
> > Less important, but I think it might be worthwhile to also include
> > some reasoning in the commit message about why this change is safe
> > for O_TMPFILE w.r.t fsync and crashes.
> 
> Hum, what do you mean? Why wouldn't it be safe?
> O_TMPFILE files don't have inode refs / extrefs, so there's no
> difference in regards to dealing with a file that has now 0 links but
> used to have more.

I mostly just pattern-matched to O_TMPFILE being the weird case for
changing logic around i_nlinks==0.

But thinking further, if we open a file with O_TMPFILE then call fsync()
on it before linkat(), then won't we call into btrfs_sync_file() then
btrfs_log_dentry_safe() and then btrfs_log_inode_parent(), which will
then behave differently at the line where you removed the nlinks check?
The inode will then go into btrfs_log_inode and commit the delayed
inode.

If that is obviously fine, then no big deal, but it felt worth
mentioning in the commit message, to me.

> 
> Thanks.
> 
> >
> > Thanks,
> > Boris
> >
> > >
> > >    # Terminate the xfs_io process so that we can unmount.
> > >    echo "quit" > $SCRATCH_MNT/fifo
> > >    wait $XFS_IO_PID
> > >    unset XFS_IO_PID
> > >
> > >    # Simulate a power failure and then mount again the filesystem to
> > >    # replay the journal/log.
> > >    _flakey_drop_and_remount
> > >
> > >    # We don't expect the file to exist anymore, since it was fsynced when
> > >    # it had no more hard links.
> > >    [ -f $SCRATCH_MNT/foo ] && echo "file foo still exists"
> > >
> > >    _unmount_flakey
> > >
> > >    # success, all done
> > >    echo "Silence is golden"
> > >    status=0
> > >    exit
> > >
> > > A test case for fstests will be submitted soon.
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  fs/btrfs/tree-log.c | 24 ++++++++++++++++--------
> > >  1 file changed, 16 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > > index 90dc094cfa5e..f5af11565b87 100644
> > > --- a/fs/btrfs/tree-log.c
> > > +++ b/fs/btrfs/tree-log.c
> > > @@ -6583,6 +6583,19 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
> > >               btrfs_log_get_delayed_items(inode, &delayed_ins_list,
> > >                                           &delayed_del_list);
> > >
> > > +     /*
> > > +      * If we are fsyncing a file with 0 hard links, then commit the delayed
> > > +      * inode because the last inode ref (or extref) item may still be in the
> > > +      * subvolume tree and if we log it the file will still exist after a log
> > > +      * replay. So commit the delayed inode to delete that last ref and we
> > > +      * skip logging it.
> > > +      */
> > > +     if (inode->vfs_inode.i_nlink == 0) {
> > > +             ret = btrfs_commit_inode_delayed_inode(inode);
> > > +             if (ret)
> > > +                     goto out_unlock;
> > > +     }
> > > +
> > >       ret = copy_inode_items_to_log(trans, inode, &min_key, &max_key,
> > >                                     path, dst_path, logged_isize,
> > >                                     inode_only, ctx,
> > > @@ -7051,14 +7064,9 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
> > >       if (btrfs_root_generation(&root->root_item) == trans->transid)
> > >               return BTRFS_LOG_FORCE_COMMIT;
> > >
> > > -     /*
> > > -      * Skip already logged inodes or inodes corresponding to tmpfiles
> > > -      * (since logging them is pointless, a link count of 0 means they
> > > -      * will never be accessible).
> > > -      */
> > > -     if ((btrfs_inode_in_log(inode, trans->transid) &&
> > > -          list_empty(&ctx->ordered_extents)) ||
> > > -         inode->vfs_inode.i_nlink == 0)
> > > +     /* Skip already logged inodes and without new extents. */
> > > +     if (btrfs_inode_in_log(inode, trans->transid) &&
> > > +         list_empty(&ctx->ordered_extents))
> > >               return BTRFS_NO_LOG_SYNC;
> > >
> > >       ret = start_log_trans(trans, root, ctx);
> > > --
> > > 2.45.2
> > >

