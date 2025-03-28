Return-Path: <linux-btrfs+bounces-12666-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9F6A751B4
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 21:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EC047A6846
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 20:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011251EB5EC;
	Fri, 28 Mar 2025 20:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="lKDJXQeD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qkfFtY7F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06AFE545
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 20:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743195486; cv=none; b=O6dFEDMRcNhrh5aFQNq+BmTQGm3Q9Hlgl0QnnSDcnQZ7rGdNlXTP0H+zQg1x2MAGcx2nBVLTKvaeyXgrdgJFI5BJ+W4v/xFQ87ziMN1f3eTIPERO9UaKbrksbRsHwEv5V/fGcqiWWGBy6f74sgJgHdJT151t6HqjIquwdh8js+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743195486; c=relaxed/simple;
	bh=Srg+Szp/Hsj1eaufIK7j1r2GSJnCZykwGtKk4S8eJ+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaLk6Gvz8PqY4QjXzvjYNzuym4MBAe+Uk24pZR77M0iYNFBzL7qnM/6hnSVwxn/YPn4HkC8EtU0Nptt2qCNeXtstqqBMLjNiOID+ODUXdBsLHMoh/U7X5sIK8bmmlp2LPH3gW/L+R1RjK8SvDAimzFzCOCp+aeniqRQ2o/ghIPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=lKDJXQeD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qkfFtY7F; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id A321D114014D;
	Fri, 28 Mar 2025 16:58:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 28 Mar 2025 16:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1743195482;
	 x=1743281882; bh=2APUQ73hP4oerMvpCJaDLmy4IWCuru4/l9/9HykC3tE=; b=
	lKDJXQeDGIkyikXGHt2/4ELCcDCppbmsKoFSZs6Iu+MSH+87Dq3VQJB/8EkvY3qO
	YOK2XrVzPI7Dr9rHvz7EPwH7pLXc121Sxmf5ChWHaqFMzBbdKOkNEtupj2TRtOqL
	mIdRzcvgm/m7WEerHJXssKsucG0te0mdHwGr+a74M4n9bIR+HukNIxvZGSPU5l4I
	EuRdUzAH4HEUbHyBK0ygelc40rGotl7laJdDnCr7EsiZHoBHr3BCrh/pRmkvz4Ep
	XcWcQF4oBNXfzCWk61SpZnm4Etnit/T+ugHVbnFSEBfZ6AW1Yo5VsZGi+fah/AZ5
	3MAxr1i9NdllaPbUPOABdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743195482; x=
	1743281882; bh=2APUQ73hP4oerMvpCJaDLmy4IWCuru4/l9/9HykC3tE=; b=q
	kfFtY7F28I5gTq0uiEdfO2+0CXXh+Ro4E7Tv0ee6do3OPkalAa7/mFzin4SfUrm5
	cRttROETRsiQg7GuXXfFr3vN5BTvXu+StTq2oa7emuQXCqh2sIsPa7Mdbj24k7Tw
	2nQ8882Okp5MvDui5E9XNXhXZ89OhfZPNydoRzGA0ns3d7Ct51KweN6b/h3nTWmx
	KGMLQQiAk9sSMzbD33V5snhp+9VadFBoyq0d1oxX6EDYDGOP2LltRtTKAj6/qfCs
	j6l2IKG6+HsD3UL2PFLvoxbLs4h4FJe+vernmBicbX4BNkHU80N/aFXiillsCWIc
	giPwkGywQ07Hs8ABl2m7g==
X-ME-Sender: <xms:Wg3nZ0xRBsOI9Fm5AvUCWwoOAocQ0wuBOdTEM_g6ioSdH8aeN212aw>
    <xme:Wg3nZ4QBwdjU6MMsTheBmCXVJdYrsyj4jENAUiM9HJqajJknO8_wkjKLZwFa0aCSS
    YJpxudqAzCvfbmDlYk>
X-ME-Received: <xmr:Wg3nZ2WVmobIG64-mxByspdqrhU0vLjntkVp2_XkqVGb7nLM9eaLdZy-t1CQ3raREGjvY2npcz4vgHq5R9gxVXunFA4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedvfeduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Wg3nZyjGCcYPd8uNVou4sJRrZoQ-O9hVzpswBZnzuu2S0_mM2l2k_Q>
    <xmx:Wg3nZ2ATVbP1Es2Tj8CwIx0ZzhLOM12v369J1m-n6RNIX6nUfBaNKw>
    <xmx:Wg3nZzIcCGhFr3kcOc9bWZlKTCmLMSmaZxlf4x88jvKZ3jVvvZNWSw>
    <xmx:Wg3nZ9B-fmGk0UPbB3EG43V_Bbs4E-RHldU1pqxTlQrEl5nbcyW1nQ>
    <xmx:Wg3nZ5Msqx7GAz9xgIPVQz0-BsvdNLCdN-1lwXkBmeRqF-yedk7MLeId>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 16:58:01 -0400 (EDT)
Date: Fri, 28 Mar 2025 13:58:53 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix fsync of files with no hard links not
 persisting deletion
Message-ID: <20250328205853.GA1206783@zen.localdomain>
References: <5b44edaf3e472a234a13e8cf2dd8c96f35970996.1742490795.git.fdmanana@suse.com>
 <20250328161021.GA1042522@zen.localdomain>
 <CAL3q7H73A+5=pjc_QuhR136j1B8ndZV=M2c+a6Tfy=zCRmsJXQ@mail.gmail.com>
 <20250328190835.GA1118426@zen.localdomain>
 <CAL3q7H6vCMWcOeb3-sCeStUjQhjK7P6Te-x-s4pA+HpVOnA5Gg@mail.gmail.com>
 <20250328201732.GA1142233@zen.localdomain>
 <CAL3q7H71CZAm3++1T9_tSNUU8LCqkn75X-ko_=a4jT+NJK1yHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H71CZAm3++1T9_tSNUU8LCqkn75X-ko_=a4jT+NJK1yHg@mail.gmail.com>

On Fri, Mar 28, 2025 at 08:29:46PM +0000, Filipe Manana wrote:
> On Fri, Mar 28, 2025 at 8:16 PM Boris Burkov <boris@bur.io> wrote:
> >
> > On Fri, Mar 28, 2025 at 07:49:52PM +0000, Filipe Manana wrote:
> > > On Fri, Mar 28, 2025 at 7:07 PM Boris Burkov <boris@bur.io> wrote:
> > > >
> > > > On Fri, Mar 28, 2025 at 05:00:32PM +0000, Filipe Manana wrote:
> > > > > On Fri, Mar 28, 2025 at 4:09 PM Boris Burkov <boris@bur.io> wrote:
> > > > > >
> > > > > > On Fri, Mar 21, 2025 at 11:08:53AM +0000, fdmanana@kernel.org wrote:
> > > > > > > From: Filipe Manana <fdmanana@suse.com>
> > > > > > >
> > > > > > > If we fsync a file (or directory) that has no more hard links, because
> > > > > > > while a process had a file descriptor open on it, the file's last hard
> > > > > > > link was removed and then the process did an fsync against the file
> > > > > > > descriptor, after a power failure or crash the file still exists after
> > > > > > > replaying the log.
> > > > > > >
> > > > > > > This behaviour is incorrect since once an inode has no more hard links
> > > > > > > it's not accessible anymore and we insert an orphan item into its
> > > > > > > subvolume's tree so that the deletion of all its items is not missed in
> > > > > > > case of a power failure or crash.
> > > > > > >
> > > > > > > So after log replay the file shouldn't exist anymore, which is also the
> > > > > > > behaviour on ext4, xfs, f2fs and other filesystems.
> > > > > > >
> > > > > > > Fix this by not ignoring inodes with zero hard links at
> > > > > > > btrfs_log_inode_parent() and by comitting an inode's delayed inode when
> > > > > > > we are not doing a fast fsync (either BTRFS_INODE_COPY_EVERYTHING or
> > > > > > > BTRFS_INODE_NEEDS_FULL_SYNC is set in the inode's runtime flags). This
> > > > > > > last step is necessary because when removing the last hard link we don't
> > > > > > > delete the corresponding ref (or extref) item, instead we record the
> > > > > > > change in the inode's delayed inode with the BTRFS_DELAYED_NODE_DEL_IREF
> > > > > > > flag, so that when the delayed inode is committed we delete the ref/extref
> > > > > > > item from the inode's subvolume tree - otherwise the logging code will log
> > > > > > > the last hard link and therefore upon log replay the inode is not deleted.
> > > > > > >
> > > > > > > The base code for a fstests test case that reproduces this bug is the
> > > > > > > following:
> > > > > > >
> > > > > > >    . ./common/dmflakey
> > > > > > >
> > > > > > >    _require_scratch
> > > > > > >    _require_dm_target flakey
> > > > > > >    _require_mknod
> > > > > > >
> > > > > > >    _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> > > > > > >    _require_metadata_journaling $SCRATCH_DEV
> > > > > > >    _init_flakey
> > > > > > >    _mount_flakey
> > > > > > >
> > > > > > >    touch $SCRATCH_MNT/foo
> > > > > > >
> > > > > > >    # Commit the current transaction and persist the file.
> > > > > > >    _scratch_sync
> > > > > > >
> > > > > > >    # A fifo to communicate with a background xfs_io process that will
> > > > > > >    # fsync the file after we deleted its hard link while it's open by
> > > > > > >    # xfs_io.
> > > > > > >    mkfifo $SCRATCH_MNT/fifo
> > > > > > >
> > > > > > >    tail -f $SCRATCH_MNT/fifo | \
> > > > > > >         $XFS_IO_PROG $SCRATCH_MNT/foo >>$seqres.full &
> > > > > > >    XFS_IO_PID=$!
> > > > > > >
> > > > > > >    # Give some time for the xfs_io process to open a file descriptor for
> > > > > > >    # the file.
> > > > > > >    sleep 1
> > > > > > >
> > > > > > >    # Now while the file is open by the xfs_io process, delete its only
> > > > > > >    # hard link.
> > > > > > >    rm -f $SCRATCH_MNT/foo
> > > > > > >
> > > > > > >    # Now that it has no more hard links, make the xfs_io process fsync it.
> > > > > > >    echo "fsync" > $SCRATCH_MNT/fifo
> > > > > >
> > > > > > What specifies the ordering semantics between the rm and fsync if they
> > > > > > come from different processes?
> > > > >
> > > > > An fsync is required to persist all data and metadata changes to a
> > > > > file that happened before the fsync.
> > > > > It doesn't matter which process does the changes or the fsync.
> > > > >
> > > > >
> > > >
> > > > My main concern is that "before" is a pretty loaded term in concurrent
> > > > systems. I obviously don't need to explain that to you, just trying to
> > > > make my position more clear.
> > >
> > > I think you are over complicating things Boris.
> > > Before means before - an operation that happened, and completed,
> > > before the fsync started - doesn't matter if it happened in the same
> > > process or not.
> > >
> > > There are applications where it's common to have multiple processes
> > > (or threads) doing operations on the same file, whether using the same
> > > file descriptor or not.
> > > And they synchronize themselves somehow before doing an fsync - I did
> > > that in database programming on a previous job.
> > >
> > > It was also exposed in the past, like in commit
> > > cd9253c23aedd61eb5ff11f37a36247cd46faf86.
> > >
> > > This isn't about having different processes doing fsync and other
> > > operations on the same file concurrently and without any
> > > synchronization.
> > > Ordering can still exist between different processes.
> > >
> > > >
> > > > > >
> > > > > > i.e., if you did the rm in a different process, it seems like the unlink
> > > > > > could race with your new check and still let the file live. OTOH, if the
> > > > > > rm comes fully "after" the fsync, that is what we would expect anyway,
> > > > > > so I can't figure out how to reason about it :)
> > > > >
> > > > > Race how?
> > > > > fsync takes the inode mutex, and so does every write and metadata
> > > > > change to the inode.
> > > > >
> > > >
> > > > This would be an excellent explanation for how there can be no race. I
> > > > looked into it some more and I'm not 100% convinced.
> > >
> > > Well, when doing a fix for fsync, is one supposed to explain the
> > > basics of the implementation? That the inode lock is taken before
> > > logging the inode?
> > > It's reasonable if we are solving a race condition somewhere, but this
> > > isn't about races.
> > >
> >
> > Fair enough. I do think it's good to look out for possible races when
> > doing code review. Apologies for not seeing the synchronization.
> >
> > > >
> > > > Concerning unlink vs fsync, I see the following:
> > > >
> > > > vfs_unlink() uses the vfs inode_lock() wrapping i_ops->unlink(). Our
> > > > unlink() is btrfs_unlink() which eventually calls drop_nlink() in
> > > > btrfs_unlink_inode() with no additional locking apparent. Notably, I
> > > > don't see it using btrfs_lock_inode() with any mode.
> > >
> > > It's documented at Documentation/filesystems/locking.rst that the
> > > inode lock is taken in exclusive mode for unlink.
> > >
> > > Look at fs/namei.c:vfs_unlink - inode_lock() is called, which takes
> > > the inode lock in exclusive mode.
> > >
> > > >
> > > > vfs_fsync() does not take inode_lock() around i_ops->fsync(). Our
> > > > fsync() is btrfs_sync_file() which uses btrfs_inode_lock() to take the
> > > > btrfs inode mmap rwsem inode->i_mmap_lock.
> > >
> > > btrfs_sync_file() takes the inode lock in exclusive mode through the
> > > call to btrfs_inode_lock().
> > >
> > > >
> > > > So I don't see how those operations are exclusive, but I would not be
> > > > remotely suprised if I missed something, since that is quite
> > > > surprising...
> > >
> > > How can't you see they are exclusive? Both are taking the inode lock
> > > in exclusive mode.
> > >
> >
> > I misread btrfs_lock_inode.
> > I saw three cases and misunderstood that the BTRFS_ILOCK_MMAP callers
> > also do inode_lock().
> >
> > My mistake.
> >
> > > >
> > > > > >
> > > > > > Are guarantees about fs ops being visible after fsync only applicable in
> > > > > > the same process?
> > > > >
> > > > > They are applicable to all changes made by any process before the fsync.
> > > > > Even the first line from the man page makes that clear:
> > > > >
> > > > > "fsync, fdatasync - synchronize a file's in-core state with storage device"
> > > > >
> > > >
> > > > Neither the man page nor the posix fsync spec stipulate anything about
> > > > what locking is required of the filesystem, at least not in a way that
> > > > is apparent to me.
> > >
> > > Of course not, because that depends on the filesystem's implementation.
> > > The VFS code for fsync doesn't take the inode lock because some
> > > filesystems don't need it, they synchronize with concurrent changes
> > > through some other mechanism of their own.
> > >
> > > The man page and posix stipulate that all in memory changes done to
> > > the inode must be persisted when an fsync is done.
> > > In other words, operations that completed before the fsync started
> > > must be persisted by the fsync.
> > >
> > > >
> > > > > > Repro and fix look good otherwise, so if that race is definitionally not
> > > > > > a concern you can add:
> >
> > I will point out that I did approach this with a good amount of deference
> > to your expertise in this area.
> >
> > > > > > Reviewed-by: Boris Burkov <boris@bur.io>
> > > > > >
> > > > > > Less important, but I think it might be worthwhile to also include
> > > > > > some reasoning in the commit message about why this change is safe
> > > > > > for O_TMPFILE w.r.t fsync and crashes.
> > > > >
> > > > > Hum, what do you mean? Why wouldn't it be safe?
> > > > > O_TMPFILE files don't have inode refs / extrefs, so there's no
> > > > > difference in regards to dealing with a file that has now 0 links but
> > > > > used to have more.
> > > >
> > > > I mostly just pattern-matched to O_TMPFILE being the weird case for
> > > > changing logic around i_nlinks==0.
> > > >
> > > > But thinking further, if we open a file with O_TMPFILE then call fsync()
> > > > on it before linkat(), then won't we call into btrfs_sync_file() then
> > > > btrfs_log_dentry_safe() and then btrfs_log_inode_parent(), which will
> > > > then behave differently at the line where you removed the nlinks check?
> > > > The inode will then go into btrfs_log_inode and commit the delayed
> > > > inode.
> > >
> > > Yes, and what's the problem?
> > > The inode won't exist after log replay, just like before and just like
> > > the fsync of any other inode with 0 links.
> > >
> >
> > Any change to the behavior is a source of possible bugs, that's all.
> > Especially when it creeps in from a different case than the one the
> > author is thinking of.
> >
> > Sometimes the author will forget a case and the dumb question will cause
> > them to think of something interesting.
> >
> > As to what actually happens, I haven't tested it, but it looks like
> > btrfs_commit_inode_delayed_inode() will return ENOENT since the inode
> > isn't in the tree which will percolate all the way back up to fsync and
> 
> The inode isn't in the tree, how?
> 
> When an inode is created, either with or without O_TMPFILE, the inode
> item is added to the subvolume tree.
> 

Ah, good point. It just has the orphan item pre-made. I forgot how that
worked.

> > change the ultimate return value to BTRFS_FORCE_LOG_COMMIT, which I
> > think makes it out to the fsync caller?
> 
> Even if that happened, running  into -ENOENT or some other error
> during logging, and we had to force a commit, then the end result
> would still be correct
> Ideally we want to avoid that, but we're not running into that case.
> 

Agreed.

> >
> > I will test it now, cause I'm curious. I'm probably missing something
> > again :)
> 
> Thanks.
> 
> >
> > > >
> > > > If that is obviously fine, then no big deal, but it felt worth
> > > > mentioning in the commit message, to me.
> > > >
> > > > >
> > > > > Thanks.
> > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > Boris
> > > > > >
> > > > > > >
> > > > > > >    # Terminate the xfs_io process so that we can unmount.
> > > > > > >    echo "quit" > $SCRATCH_MNT/fifo
> > > > > > >    wait $XFS_IO_PID
> > > > > > >    unset XFS_IO_PID
> > > > > > >
> > > > > > >    # Simulate a power failure and then mount again the filesystem to
> > > > > > >    # replay the journal/log.
> > > > > > >    _flakey_drop_and_remount
> > > > > > >
> > > > > > >    # We don't expect the file to exist anymore, since it was fsynced when
> > > > > > >    # it had no more hard links.
> > > > > > >    [ -f $SCRATCH_MNT/foo ] && echo "file foo still exists"
> > > > > > >
> > > > > > >    _unmount_flakey
> > > > > > >
> > > > > > >    # success, all done
> > > > > > >    echo "Silence is golden"
> > > > > > >    status=0
> > > > > > >    exit
> > > > > > >
> > > > > > > A test case for fstests will be submitted soon.
> > > > > > >
> > > > > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > > > > ---
> > > > > > >  fs/btrfs/tree-log.c | 24 ++++++++++++++++--------
> > > > > > >  1 file changed, 16 insertions(+), 8 deletions(-)
> > > > > > >
> > > > > > > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > > > > > > index 90dc094cfa5e..f5af11565b87 100644
> > > > > > > --- a/fs/btrfs/tree-log.c
> > > > > > > +++ b/fs/btrfs/tree-log.c
> > > > > > > @@ -6583,6 +6583,19 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
> > > > > > >               btrfs_log_get_delayed_items(inode, &delayed_ins_list,
> > > > > > >                                           &delayed_del_list);
> > > > > > >
> > > > > > > +     /*
> > > > > > > +      * If we are fsyncing a file with 0 hard links, then commit the delayed
> > > > > > > +      * inode because the last inode ref (or extref) item may still be in the
> > > > > > > +      * subvolume tree and if we log it the file will still exist after a log
> > > > > > > +      * replay. So commit the delayed inode to delete that last ref and we
> > > > > > > +      * skip logging it.
> > > > > > > +      */
> > > > > > > +     if (inode->vfs_inode.i_nlink == 0) {
> > > > > > > +             ret = btrfs_commit_inode_delayed_inode(inode);
> > > > > > > +             if (ret)
> > > > > > > +                     goto out_unlock;
> > > > > > > +     }
> > > > > > > +
> > > > > > >       ret = copy_inode_items_to_log(trans, inode, &min_key, &max_key,
> > > > > > >                                     path, dst_path, logged_isize,
> > > > > > >                                     inode_only, ctx,
> > > > > > > @@ -7051,14 +7064,9 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
> > > > > > >       if (btrfs_root_generation(&root->root_item) == trans->transid)
> > > > > > >               return BTRFS_LOG_FORCE_COMMIT;
> > > > > > >
> > > > > > > -     /*
> > > > > > > -      * Skip already logged inodes or inodes corresponding to tmpfiles
> > > > > > > -      * (since logging them is pointless, a link count of 0 means they
> > > > > > > -      * will never be accessible).
> > > > > > > -      */
> > > > > > > -     if ((btrfs_inode_in_log(inode, trans->transid) &&
> > > > > > > -          list_empty(&ctx->ordered_extents)) ||
> > > > > > > -         inode->vfs_inode.i_nlink == 0)
> > > > > > > +     /* Skip already logged inodes and without new extents. */
> > > > > > > +     if (btrfs_inode_in_log(inode, trans->transid) &&
> > > > > > > +         list_empty(&ctx->ordered_extents))
> > > > > > >               return BTRFS_NO_LOG_SYNC;
> > > > > > >
> > > > > > >       ret = start_log_trans(trans, root, ctx);
> > > > > > > --
> > > > > > > 2.45.2
> > > > > > >

