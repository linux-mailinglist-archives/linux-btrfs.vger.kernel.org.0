Return-Path: <linux-btrfs+bounces-12665-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522E9A75176
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 21:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC9A27A61AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 20:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF2B1E22FD;
	Fri, 28 Mar 2025 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egFGfqqI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99828145A05
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743193825; cv=none; b=TzHrmvkWzmMBtr925omTkRmrR9UFS4qbzoq19Pt+g+qUkErvglmlrWVufh5iFDeWxB1qE6wjW6irigIBKXPM+gwdJ9TbjqUYlXH1kQ/XDhVg+F+SoNIW/O+ETs19TMblYxYKavOYwc6ylkxEqrBJ5h5/+D1D2Up3EHNHMEVcUh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743193825; c=relaxed/simple;
	bh=mOXuvKyLM4MIpqIUR+opdfyHLmdUR8BknASiCHnvGtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZiW+o59ikLjJxS+xVfH/qvpf+U1TBjbKne2gyX1P9yEIZ4NMW9T2CXH7QmhXMo9QuPV9cllVjLqQJ4l8oNoFTF+3FQ/F1D1Er+lsmdZ++s/l0UR8SZclipQbooHkEU5UNTDmQUgkVAhaX8RSd2HATGTybdSSdY/hThq6wruJvzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egFGfqqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE20C4CEE4
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 20:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743193825;
	bh=mOXuvKyLM4MIpqIUR+opdfyHLmdUR8BknASiCHnvGtg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=egFGfqqICsnV4qzzs0G/FmFZCKq/49S8I+QwCwPQVtYvvH/la0B9bvYCIBTAitW1o
	 yfeeNC8mqHpJQT9AReJ3RXiju2JFnU7APKgx44d4SSl72ddfBUjmaYrARvsft48ZEL
	 8TQTfgguto8y6+wyZS7k595FfJyEHAzKOmyJUQwKAQLh8DK1NmIso5iPJm397OpdXc
	 8vQY2ovR9JYGxPXkctCJkzH08ZpwnAvhbTTDQLxovGEJFBg8mLAHAeLWh5T368qrvS
	 mTCAD/yFt9d01abf4k+/teITABVUDu2PnSjjNFt+eMOIHTCxL7XB9A7yRzDAlNnpaU
	 hSp91zUEQtQnA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abbb12bea54so487370366b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 13:30:24 -0700 (PDT)
X-Gm-Message-State: AOJu0YyswOmOfajHuUndxb0R07ic5EdkhMGWPGM58pNm0AIG62yBgSmk
	8gysruTB2XVJDia7RrufN4ORqsJOJfYQL7gZpI1Eusu5E7DVN26mqwp4EQJH7yTknm9SmbTQB6l
	Y7h1lpEYtcJl0MUw50EyNy+gknHo=
X-Google-Smtp-Source: AGHT+IEOmeTRH5k84eRAxSQq/YAfpV3krznHpV5wMhzVORUI9pPHqbt9GOxD1RWKOJ08MCiQdM9DSt9zyFkmUwLSKaQ=
X-Received: by 2002:a17:907:d1a:b0:ac6:f6e9:6b9e with SMTP id
 a640c23a62f3a-ac738ae8756mr60827566b.25.1743193823259; Fri, 28 Mar 2025
 13:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5b44edaf3e472a234a13e8cf2dd8c96f35970996.1742490795.git.fdmanana@suse.com>
 <20250328161021.GA1042522@zen.localdomain> <CAL3q7H73A+5=pjc_QuhR136j1B8ndZV=M2c+a6Tfy=zCRmsJXQ@mail.gmail.com>
 <20250328190835.GA1118426@zen.localdomain> <CAL3q7H6vCMWcOeb3-sCeStUjQhjK7P6Te-x-s4pA+HpVOnA5Gg@mail.gmail.com>
 <20250328201732.GA1142233@zen.localdomain>
In-Reply-To: <20250328201732.GA1142233@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 28 Mar 2025 20:29:46 +0000
X-Gmail-Original-Message-ID: <CAL3q7H71CZAm3++1T9_tSNUU8LCqkn75X-ko_=a4jT+NJK1yHg@mail.gmail.com>
X-Gm-Features: AQ5f1JoVIWFbPctQNKbzdocyKX1IUMQDp6Jg8aaxPXNZtInJ3SZ47eAF3y9xvvg
Message-ID: <CAL3q7H71CZAm3++1T9_tSNUU8LCqkn75X-ko_=a4jT+NJK1yHg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix fsync of files with no hard links not
 persisting deletion
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 8:16=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Fri, Mar 28, 2025 at 07:49:52PM +0000, Filipe Manana wrote:
> > On Fri, Mar 28, 2025 at 7:07=E2=80=AFPM Boris Burkov <boris@bur.io> wro=
te:
> > >
> > > On Fri, Mar 28, 2025 at 05:00:32PM +0000, Filipe Manana wrote:
> > > > On Fri, Mar 28, 2025 at 4:09=E2=80=AFPM Boris Burkov <boris@bur.io>=
 wrote:
> > > > >
> > > > > On Fri, Mar 21, 2025 at 11:08:53AM +0000, fdmanana@kernel.org wro=
te:
> > > > > > From: Filipe Manana <fdmanana@suse.com>
> > > > > >
> > > > > > If we fsync a file (or directory) that has no more hard links, =
because
> > > > > > while a process had a file descriptor open on it, the file's la=
st hard
> > > > > > link was removed and then the process did an fsync against the =
file
> > > > > > descriptor, after a power failure or crash the file still exist=
s after
> > > > > > replaying the log.
> > > > > >
> > > > > > This behaviour is incorrect since once an inode has no more har=
d links
> > > > > > it's not accessible anymore and we insert an orphan item into i=
ts
> > > > > > subvolume's tree so that the deletion of all its items is not m=
issed in
> > > > > > case of a power failure or crash.
> > > > > >
> > > > > > So after log replay the file shouldn't exist anymore, which is =
also the
> > > > > > behaviour on ext4, xfs, f2fs and other filesystems.
> > > > > >
> > > > > > Fix this by not ignoring inodes with zero hard links at
> > > > > > btrfs_log_inode_parent() and by comitting an inode's delayed in=
ode when
> > > > > > we are not doing a fast fsync (either BTRFS_INODE_COPY_EVERYTHI=
NG or
> > > > > > BTRFS_INODE_NEEDS_FULL_SYNC is set in the inode's runtime flags=
). This
> > > > > > last step is necessary because when removing the last hard link=
 we don't
> > > > > > delete the corresponding ref (or extref) item, instead we recor=
d the
> > > > > > change in the inode's delayed inode with the BTRFS_DELAYED_NODE=
_DEL_IREF
> > > > > > flag, so that when the delayed inode is committed we delete the=
 ref/extref
> > > > > > item from the inode's subvolume tree - otherwise the logging co=
de will log
> > > > > > the last hard link and therefore upon log replay the inode is n=
ot deleted.
> > > > > >
> > > > > > The base code for a fstests test case that reproduces this bug =
is the
> > > > > > following:
> > > > > >
> > > > > >    . ./common/dmflakey
> > > > > >
> > > > > >    _require_scratch
> > > > > >    _require_dm_target flakey
> > > > > >    _require_mknod
> > > > > >
> > > > > >    _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> > > > > >    _require_metadata_journaling $SCRATCH_DEV
> > > > > >    _init_flakey
> > > > > >    _mount_flakey
> > > > > >
> > > > > >    touch $SCRATCH_MNT/foo
> > > > > >
> > > > > >    # Commit the current transaction and persist the file.
> > > > > >    _scratch_sync
> > > > > >
> > > > > >    # A fifo to communicate with a background xfs_io process tha=
t will
> > > > > >    # fsync the file after we deleted its hard link while it's o=
pen by
> > > > > >    # xfs_io.
> > > > > >    mkfifo $SCRATCH_MNT/fifo
> > > > > >
> > > > > >    tail -f $SCRATCH_MNT/fifo | \
> > > > > >         $XFS_IO_PROG $SCRATCH_MNT/foo >>$seqres.full &
> > > > > >    XFS_IO_PID=3D$!
> > > > > >
> > > > > >    # Give some time for the xfs_io process to open a file descr=
iptor for
> > > > > >    # the file.
> > > > > >    sleep 1
> > > > > >
> > > > > >    # Now while the file is open by the xfs_io process, delete i=
ts only
> > > > > >    # hard link.
> > > > > >    rm -f $SCRATCH_MNT/foo
> > > > > >
> > > > > >    # Now that it has no more hard links, make the xfs_io proces=
s fsync it.
> > > > > >    echo "fsync" > $SCRATCH_MNT/fifo
> > > > >
> > > > > What specifies the ordering semantics between the rm and fsync if=
 they
> > > > > come from different processes?
> > > >
> > > > An fsync is required to persist all data and metadata changes to a
> > > > file that happened before the fsync.
> > > > It doesn't matter which process does the changes or the fsync.
> > > >
> > > >
> > >
> > > My main concern is that "before" is a pretty loaded term in concurren=
t
> > > systems. I obviously don't need to explain that to you, just trying t=
o
> > > make my position more clear.
> >
> > I think you are over complicating things Boris.
> > Before means before - an operation that happened, and completed,
> > before the fsync started - doesn't matter if it happened in the same
> > process or not.
> >
> > There are applications where it's common to have multiple processes
> > (or threads) doing operations on the same file, whether using the same
> > file descriptor or not.
> > And they synchronize themselves somehow before doing an fsync - I did
> > that in database programming on a previous job.
> >
> > It was also exposed in the past, like in commit
> > cd9253c23aedd61eb5ff11f37a36247cd46faf86.
> >
> > This isn't about having different processes doing fsync and other
> > operations on the same file concurrently and without any
> > synchronization.
> > Ordering can still exist between different processes.
> >
> > >
> > > > >
> > > > > i.e., if you did the rm in a different process, it seems like the=
 unlink
> > > > > could race with your new check and still let the file live. OTOH,=
 if the
> > > > > rm comes fully "after" the fsync, that is what we would expect an=
yway,
> > > > > so I can't figure out how to reason about it :)
> > > >
> > > > Race how?
> > > > fsync takes the inode mutex, and so does every write and metadata
> > > > change to the inode.
> > > >
> > >
> > > This would be an excellent explanation for how there can be no race. =
I
> > > looked into it some more and I'm not 100% convinced.
> >
> > Well, when doing a fix for fsync, is one supposed to explain the
> > basics of the implementation? That the inode lock is taken before
> > logging the inode?
> > It's reasonable if we are solving a race condition somewhere, but this
> > isn't about races.
> >
>
> Fair enough. I do think it's good to look out for possible races when
> doing code review. Apologies for not seeing the synchronization.
>
> > >
> > > Concerning unlink vs fsync, I see the following:
> > >
> > > vfs_unlink() uses the vfs inode_lock() wrapping i_ops->unlink(). Our
> > > unlink() is btrfs_unlink() which eventually calls drop_nlink() in
> > > btrfs_unlink_inode() with no additional locking apparent. Notably, I
> > > don't see it using btrfs_lock_inode() with any mode.
> >
> > It's documented at Documentation/filesystems/locking.rst that the
> > inode lock is taken in exclusive mode for unlink.
> >
> > Look at fs/namei.c:vfs_unlink - inode_lock() is called, which takes
> > the inode lock in exclusive mode.
> >
> > >
> > > vfs_fsync() does not take inode_lock() around i_ops->fsync(). Our
> > > fsync() is btrfs_sync_file() which uses btrfs_inode_lock() to take th=
e
> > > btrfs inode mmap rwsem inode->i_mmap_lock.
> >
> > btrfs_sync_file() takes the inode lock in exclusive mode through the
> > call to btrfs_inode_lock().
> >
> > >
> > > So I don't see how those operations are exclusive, but I would not be
> > > remotely suprised if I missed something, since that is quite
> > > surprising...
> >
> > How can't you see they are exclusive? Both are taking the inode lock
> > in exclusive mode.
> >
>
> I misread btrfs_lock_inode.
> I saw three cases and misunderstood that the BTRFS_ILOCK_MMAP callers
> also do inode_lock().
>
> My mistake.
>
> > >
> > > > >
> > > > > Are guarantees about fs ops being visible after fsync only applic=
able in
> > > > > the same process?
> > > >
> > > > They are applicable to all changes made by any process before the f=
sync.
> > > > Even the first line from the man page makes that clear:
> > > >
> > > > "fsync, fdatasync - synchronize a file's in-core state with storage=
 device"
> > > >
> > >
> > > Neither the man page nor the posix fsync spec stipulate anything abou=
t
> > > what locking is required of the filesystem, at least not in a way tha=
t
> > > is apparent to me.
> >
> > Of course not, because that depends on the filesystem's implementation.
> > The VFS code for fsync doesn't take the inode lock because some
> > filesystems don't need it, they synchronize with concurrent changes
> > through some other mechanism of their own.
> >
> > The man page and posix stipulate that all in memory changes done to
> > the inode must be persisted when an fsync is done.
> > In other words, operations that completed before the fsync started
> > must be persisted by the fsync.
> >
> > >
> > > > > Repro and fix look good otherwise, so if that race is definitiona=
lly not
> > > > > a concern you can add:
>
> I will point out that I did approach this with a good amount of deference
> to your expertise in this area.
>
> > > > > Reviewed-by: Boris Burkov <boris@bur.io>
> > > > >
> > > > > Less important, but I think it might be worthwhile to also includ=
e
> > > > > some reasoning in the commit message about why this change is saf=
e
> > > > > for O_TMPFILE w.r.t fsync and crashes.
> > > >
> > > > Hum, what do you mean? Why wouldn't it be safe?
> > > > O_TMPFILE files don't have inode refs / extrefs, so there's no
> > > > difference in regards to dealing with a file that has now 0 links b=
ut
> > > > used to have more.
> > >
> > > I mostly just pattern-matched to O_TMPFILE being the weird case for
> > > changing logic around i_nlinks=3D=3D0.
> > >
> > > But thinking further, if we open a file with O_TMPFILE then call fsyn=
c()
> > > on it before linkat(), then won't we call into btrfs_sync_file() then
> > > btrfs_log_dentry_safe() and then btrfs_log_inode_parent(), which will
> > > then behave differently at the line where you removed the nlinks chec=
k?
> > > The inode will then go into btrfs_log_inode and commit the delayed
> > > inode.
> >
> > Yes, and what's the problem?
> > The inode won't exist after log replay, just like before and just like
> > the fsync of any other inode with 0 links.
> >
>
> Any change to the behavior is a source of possible bugs, that's all.
> Especially when it creeps in from a different case than the one the
> author is thinking of.
>
> Sometimes the author will forget a case and the dumb question will cause
> them to think of something interesting.
>
> As to what actually happens, I haven't tested it, but it looks like
> btrfs_commit_inode_delayed_inode() will return ENOENT since the inode
> isn't in the tree which will percolate all the way back up to fsync and

The inode isn't in the tree, how?

When an inode is created, either with or without O_TMPFILE, the inode
item is added to the subvolume tree.

> change the ultimate return value to BTRFS_FORCE_LOG_COMMIT, which I
> think makes it out to the fsync caller?

Even if that happened, running  into -ENOENT or some other error
during logging, and we had to force a commit, then the end result
would still be correct
Ideally we want to avoid that, but we're not running into that case.

>
> I will test it now, cause I'm curious. I'm probably missing something
> again :)

Thanks.

>
> > >
> > > If that is obviously fine, then no big deal, but it felt worth
> > > mentioning in the commit message, to me.
> > >
> > > >
> > > > Thanks.
> > > >
> > > > >
> > > > > Thanks,
> > > > > Boris
> > > > >
> > > > > >
> > > > > >    # Terminate the xfs_io process so that we can unmount.
> > > > > >    echo "quit" > $SCRATCH_MNT/fifo
> > > > > >    wait $XFS_IO_PID
> > > > > >    unset XFS_IO_PID
> > > > > >
> > > > > >    # Simulate a power failure and then mount again the filesyst=
em to
> > > > > >    # replay the journal/log.
> > > > > >    _flakey_drop_and_remount
> > > > > >
> > > > > >    # We don't expect the file to exist anymore, since it was fs=
ynced when
> > > > > >    # it had no more hard links.
> > > > > >    [ -f $SCRATCH_MNT/foo ] && echo "file foo still exists"
> > > > > >
> > > > > >    _unmount_flakey
> > > > > >
> > > > > >    # success, all done
> > > > > >    echo "Silence is golden"
> > > > > >    status=3D0
> > > > > >    exit
> > > > > >
> > > > > > A test case for fstests will be submitted soon.
> > > > > >
> > > > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > > > ---
> > > > > >  fs/btrfs/tree-log.c | 24 ++++++++++++++++--------
> > > > > >  1 file changed, 16 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > > > > > index 90dc094cfa5e..f5af11565b87 100644
> > > > > > --- a/fs/btrfs/tree-log.c
> > > > > > +++ b/fs/btrfs/tree-log.c
> > > > > > @@ -6583,6 +6583,19 @@ static int btrfs_log_inode(struct btrfs_=
trans_handle *trans,
> > > > > >               btrfs_log_get_delayed_items(inode, &delayed_ins_l=
ist,
> > > > > >                                           &delayed_del_list);
> > > > > >
> > > > > > +     /*
> > > > > > +      * If we are fsyncing a file with 0 hard links, then comm=
it the delayed
> > > > > > +      * inode because the last inode ref (or extref) item may =
still be in the
> > > > > > +      * subvolume tree and if we log it the file will still ex=
ist after a log
> > > > > > +      * replay. So commit the delayed inode to delete that las=
t ref and we
> > > > > > +      * skip logging it.
> > > > > > +      */
> > > > > > +     if (inode->vfs_inode.i_nlink =3D=3D 0) {
> > > > > > +             ret =3D btrfs_commit_inode_delayed_inode(inode);
> > > > > > +             if (ret)
> > > > > > +                     goto out_unlock;
> > > > > > +     }
> > > > > > +
> > > > > >       ret =3D copy_inode_items_to_log(trans, inode, &min_key, &=
max_key,
> > > > > >                                     path, dst_path, logged_isiz=
e,
> > > > > >                                     inode_only, ctx,
> > > > > > @@ -7051,14 +7064,9 @@ static int btrfs_log_inode_parent(struct=
 btrfs_trans_handle *trans,
> > > > > >       if (btrfs_root_generation(&root->root_item) =3D=3D trans-=
>transid)
> > > > > >               return BTRFS_LOG_FORCE_COMMIT;
> > > > > >
> > > > > > -     /*
> > > > > > -      * Skip already logged inodes or inodes corresponding to =
tmpfiles
> > > > > > -      * (since logging them is pointless, a link count of 0 me=
ans they
> > > > > > -      * will never be accessible).
> > > > > > -      */
> > > > > > -     if ((btrfs_inode_in_log(inode, trans->transid) &&
> > > > > > -          list_empty(&ctx->ordered_extents)) ||
> > > > > > -         inode->vfs_inode.i_nlink =3D=3D 0)
> > > > > > +     /* Skip already logged inodes and without new extents. */
> > > > > > +     if (btrfs_inode_in_log(inode, trans->transid) &&
> > > > > > +         list_empty(&ctx->ordered_extents))
> > > > > >               return BTRFS_NO_LOG_SYNC;
> > > > > >
> > > > > >       ret =3D start_log_trans(trans, root, ctx);
> > > > > > --
> > > > > > 2.45.2
> > > > > >

