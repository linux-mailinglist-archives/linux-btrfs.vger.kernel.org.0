Return-Path: <linux-btrfs+bounces-12663-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1553FA75106
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 20:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A190317386A
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 19:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720F61E0DDF;
	Fri, 28 Mar 2025 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgMYJmtY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAAE322B
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743191431; cv=none; b=Jja3VOnpTu0+yXxdNnhCgw+OdWBJdEkFMw9gLOqA6wOuMJojznFZvygBoFdp4MlXKUhY4WRJ1yGfISUbIDlx3OMv37Wx3ynX4/R3xdJiCpMCUglDqF47bRJeWoxSAVgumsxYcy5yywSvZOnyTRcTOLD1vuuaDpbvUaxiRjVhUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743191431; c=relaxed/simple;
	bh=VLcxfEEK/zgQtlXjmMMT3Oy/X4yqEmBryLKHO3yghy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txc9uuCf0PDvzmghRvrPI9LAWsfEpJnB6+mxAhO3x7xpjhswmSLfeZnbOMnDBsNhhGYqX+MvLp0lGiE/B8RtyXuYH8WnwxB7u238pj4fX14IKQTrXYPDY1B4UIdc+XRv8MV+E6PoKgUjT7MbJGunjI6oWwYHKXFVr1gDglnCBoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgMYJmtY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238DEC4CEE4
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 19:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743191431;
	bh=VLcxfEEK/zgQtlXjmMMT3Oy/X4yqEmBryLKHO3yghy0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WgMYJmtYZzAB5WTPKpgZpHa2qHPjsgYvhEitJBrn+fq+LpFwTzPKh9a/OhaVsLcuu
	 TkABKreiJpTz6I5x1UBW2UuXNNjFpNyi2uiprMTGrchvYdTQz6HYPHhOPaiiQVKsFN
	 mbkuJqL027T4Gg9ROan25FB3mfPoaWOF17hJ1iEcZJB1mGMSv+32NzZ8o/UvkC/wYk
	 SbsW1qZjM9R15Yl4w6RtLwqQYFbVZY//CLt8zZ/8y3CfiAbFgLScnESW83mBA7k9nF
	 QNY3u7gO765NAgMehZmlIOwUWj9AOXK3RO1gxVKmpTCWEsAJgiBmcs6Msa/8dAMGmE
	 n8Xm5SfyOv8uw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2963dc379so401608666b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 12:50:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YyMJhbUjOE5rKsrhgdbnxmmJS8DXATtE5eyEAcTdco/CCp0e7/Q
	qcNtEcGT3ZBEhHfrc8sTrBjASEjZ7+yac64FvJOnbDXVjSNpI5ra01PsZC+esz3dT+An1pgc3+z
	90BS9wwUEtjDmuCTwVaLXv0bfZyI=
X-Google-Smtp-Source: AGHT+IH8tInO87I2vkOFnFwUVy2ZugLuxpAihZYS0xz8qZyfkniw3Q/LDnbMNSeNfGw7EPptQB5KptdVtAtZo99EdbI=
X-Received: by 2002:a17:907:86a2:b0:ac4:3d8:2e90 with SMTP id
 a640c23a62f3a-ac7389a3b89mr40233966b.13.1743191429581; Fri, 28 Mar 2025
 12:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5b44edaf3e472a234a13e8cf2dd8c96f35970996.1742490795.git.fdmanana@suse.com>
 <20250328161021.GA1042522@zen.localdomain> <CAL3q7H73A+5=pjc_QuhR136j1B8ndZV=M2c+a6Tfy=zCRmsJXQ@mail.gmail.com>
 <20250328190835.GA1118426@zen.localdomain>
In-Reply-To: <20250328190835.GA1118426@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 28 Mar 2025 19:49:52 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6vCMWcOeb3-sCeStUjQhjK7P6Te-x-s4pA+HpVOnA5Gg@mail.gmail.com>
X-Gm-Features: AQ5f1JpGOIrneBnzqCwDK0YFdSgunaYqG9y4vXknureM2QHjv5pLHD_prYCUQDE
Message-ID: <CAL3q7H6vCMWcOeb3-sCeStUjQhjK7P6Te-x-s4pA+HpVOnA5Gg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix fsync of files with no hard links not
 persisting deletion
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 7:07=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Fri, Mar 28, 2025 at 05:00:32PM +0000, Filipe Manana wrote:
> > On Fri, Mar 28, 2025 at 4:09=E2=80=AFPM Boris Burkov <boris@bur.io> wro=
te:
> > >
> > > On Fri, Mar 21, 2025 at 11:08:53AM +0000, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > If we fsync a file (or directory) that has no more hard links, beca=
use
> > > > while a process had a file descriptor open on it, the file's last h=
ard
> > > > link was removed and then the process did an fsync against the file
> > > > descriptor, after a power failure or crash the file still exists af=
ter
> > > > replaying the log.
> > > >
> > > > This behaviour is incorrect since once an inode has no more hard li=
nks
> > > > it's not accessible anymore and we insert an orphan item into its
> > > > subvolume's tree so that the deletion of all its items is not misse=
d in
> > > > case of a power failure or crash.
> > > >
> > > > So after log replay the file shouldn't exist anymore, which is also=
 the
> > > > behaviour on ext4, xfs, f2fs and other filesystems.
> > > >
> > > > Fix this by not ignoring inodes with zero hard links at
> > > > btrfs_log_inode_parent() and by comitting an inode's delayed inode =
when
> > > > we are not doing a fast fsync (either BTRFS_INODE_COPY_EVERYTHING o=
r
> > > > BTRFS_INODE_NEEDS_FULL_SYNC is set in the inode's runtime flags). T=
his
> > > > last step is necessary because when removing the last hard link we =
don't
> > > > delete the corresponding ref (or extref) item, instead we record th=
e
> > > > change in the inode's delayed inode with the BTRFS_DELAYED_NODE_DEL=
_IREF
> > > > flag, so that when the delayed inode is committed we delete the ref=
/extref
> > > > item from the inode's subvolume tree - otherwise the logging code w=
ill log
> > > > the last hard link and therefore upon log replay the inode is not d=
eleted.
> > > >
> > > > The base code for a fstests test case that reproduces this bug is t=
he
> > > > following:
> > > >
> > > >    . ./common/dmflakey
> > > >
> > > >    _require_scratch
> > > >    _require_dm_target flakey
> > > >    _require_mknod
> > > >
> > > >    _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> > > >    _require_metadata_journaling $SCRATCH_DEV
> > > >    _init_flakey
> > > >    _mount_flakey
> > > >
> > > >    touch $SCRATCH_MNT/foo
> > > >
> > > >    # Commit the current transaction and persist the file.
> > > >    _scratch_sync
> > > >
> > > >    # A fifo to communicate with a background xfs_io process that wi=
ll
> > > >    # fsync the file after we deleted its hard link while it's open =
by
> > > >    # xfs_io.
> > > >    mkfifo $SCRATCH_MNT/fifo
> > > >
> > > >    tail -f $SCRATCH_MNT/fifo | \
> > > >         $XFS_IO_PROG $SCRATCH_MNT/foo >>$seqres.full &
> > > >    XFS_IO_PID=3D$!
> > > >
> > > >    # Give some time for the xfs_io process to open a file descripto=
r for
> > > >    # the file.
> > > >    sleep 1
> > > >
> > > >    # Now while the file is open by the xfs_io process, delete its o=
nly
> > > >    # hard link.
> > > >    rm -f $SCRATCH_MNT/foo
> > > >
> > > >    # Now that it has no more hard links, make the xfs_io process fs=
ync it.
> > > >    echo "fsync" > $SCRATCH_MNT/fifo
> > >
> > > What specifies the ordering semantics between the rm and fsync if the=
y
> > > come from different processes?
> >
> > An fsync is required to persist all data and metadata changes to a
> > file that happened before the fsync.
> > It doesn't matter which process does the changes or the fsync.
> >
> >
>
> My main concern is that "before" is a pretty loaded term in concurrent
> systems. I obviously don't need to explain that to you, just trying to
> make my position more clear.

I think you are over complicating things Boris.
Before means before - an operation that happened, and completed,
before the fsync started - doesn't matter if it happened in the same
process or not.

There are applications where it's common to have multiple processes
(or threads) doing operations on the same file, whether using the same
file descriptor or not.
And they synchronize themselves somehow before doing an fsync - I did
that in database programming on a previous job.

It was also exposed in the past, like in commit
cd9253c23aedd61eb5ff11f37a36247cd46faf86.

This isn't about having different processes doing fsync and other
operations on the same file concurrently and without any
synchronization.
Ordering can still exist between different processes.

>
> > >
> > > i.e., if you did the rm in a different process, it seems like the unl=
ink
> > > could race with your new check and still let the file live. OTOH, if =
the
> > > rm comes fully "after" the fsync, that is what we would expect anyway=
,
> > > so I can't figure out how to reason about it :)
> >
> > Race how?
> > fsync takes the inode mutex, and so does every write and metadata
> > change to the inode.
> >
>
> This would be an excellent explanation for how there can be no race. I
> looked into it some more and I'm not 100% convinced.

Well, when doing a fix for fsync, is one supposed to explain the
basics of the implementation? That the inode lock is taken before
logging the inode?
It's reasonable if we are solving a race condition somewhere, but this
isn't about races.

>
> Concerning unlink vs fsync, I see the following:
>
> vfs_unlink() uses the vfs inode_lock() wrapping i_ops->unlink(). Our
> unlink() is btrfs_unlink() which eventually calls drop_nlink() in
> btrfs_unlink_inode() with no additional locking apparent. Notably, I
> don't see it using btrfs_lock_inode() with any mode.

It's documented at Documentation/filesystems/locking.rst that the
inode lock is taken in exclusive mode for unlink.

Look at fs/namei.c:vfs_unlink - inode_lock() is called, which takes
the inode lock in exclusive mode.

>
> vfs_fsync() does not take inode_lock() around i_ops->fsync(). Our
> fsync() is btrfs_sync_file() which uses btrfs_inode_lock() to take the
> btrfs inode mmap rwsem inode->i_mmap_lock.

btrfs_sync_file() takes the inode lock in exclusive mode through the
call to btrfs_inode_lock().

>
> So I don't see how those operations are exclusive, but I would not be
> remotely suprised if I missed something, since that is quite
> surprising...

How can't you see they are exclusive? Both are taking the inode lock
in exclusive mode.

>
> > >
> > > Are guarantees about fs ops being visible after fsync only applicable=
 in
> > > the same process?
> >
> > They are applicable to all changes made by any process before the fsync=
.
> > Even the first line from the man page makes that clear:
> >
> > "fsync, fdatasync - synchronize a file's in-core state with storage dev=
ice"
> >
>
> Neither the man page nor the posix fsync spec stipulate anything about
> what locking is required of the filesystem, at least not in a way that
> is apparent to me.

Of course not, because that depends on the filesystem's implementation.
The VFS code for fsync doesn't take the inode lock because some
filesystems don't need it, they synchronize with concurrent changes
through some other mechanism of their own.

The man page and posix stipulate that all in memory changes done to
the inode must be persisted when an fsync is done.
In other words, operations that completed before the fsync started
must be persisted by the fsync.

>
> > > Repro and fix look good otherwise, so if that race is definitionally =
not
> > > a concern you can add:
> > > Reviewed-by: Boris Burkov <boris@bur.io>
> > >
> > > Less important, but I think it might be worthwhile to also include
> > > some reasoning in the commit message about why this change is safe
> > > for O_TMPFILE w.r.t fsync and crashes.
> >
> > Hum, what do you mean? Why wouldn't it be safe?
> > O_TMPFILE files don't have inode refs / extrefs, so there's no
> > difference in regards to dealing with a file that has now 0 links but
> > used to have more.
>
> I mostly just pattern-matched to O_TMPFILE being the weird case for
> changing logic around i_nlinks=3D=3D0.
>
> But thinking further, if we open a file with O_TMPFILE then call fsync()
> on it before linkat(), then won't we call into btrfs_sync_file() then
> btrfs_log_dentry_safe() and then btrfs_log_inode_parent(), which will
> then behave differently at the line where you removed the nlinks check?
> The inode will then go into btrfs_log_inode and commit the delayed
> inode.

Yes, and what's the problem?
The inode won't exist after log replay, just like before and just like
the fsync of any other inode with 0 links.

>
> If that is obviously fine, then no big deal, but it felt worth
> mentioning in the commit message, to me.
>
> >
> > Thanks.
> >
> > >
> > > Thanks,
> > > Boris
> > >
> > > >
> > > >    # Terminate the xfs_io process so that we can unmount.
> > > >    echo "quit" > $SCRATCH_MNT/fifo
> > > >    wait $XFS_IO_PID
> > > >    unset XFS_IO_PID
> > > >
> > > >    # Simulate a power failure and then mount again the filesystem t=
o
> > > >    # replay the journal/log.
> > > >    _flakey_drop_and_remount
> > > >
> > > >    # We don't expect the file to exist anymore, since it was fsynce=
d when
> > > >    # it had no more hard links.
> > > >    [ -f $SCRATCH_MNT/foo ] && echo "file foo still exists"
> > > >
> > > >    _unmount_flakey
> > > >
> > > >    # success, all done
> > > >    echo "Silence is golden"
> > > >    status=3D0
> > > >    exit
> > > >
> > > > A test case for fstests will be submitted soon.
> > > >
> > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > ---
> > > >  fs/btrfs/tree-log.c | 24 ++++++++++++++++--------
> > > >  1 file changed, 16 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > > > index 90dc094cfa5e..f5af11565b87 100644
> > > > --- a/fs/btrfs/tree-log.c
> > > > +++ b/fs/btrfs/tree-log.c
> > > > @@ -6583,6 +6583,19 @@ static int btrfs_log_inode(struct btrfs_tran=
s_handle *trans,
> > > >               btrfs_log_get_delayed_items(inode, &delayed_ins_list,
> > > >                                           &delayed_del_list);
> > > >
> > > > +     /*
> > > > +      * If we are fsyncing a file with 0 hard links, then commit t=
he delayed
> > > > +      * inode because the last inode ref (or extref) item may stil=
l be in the
> > > > +      * subvolume tree and if we log it the file will still exist =
after a log
> > > > +      * replay. So commit the delayed inode to delete that last re=
f and we
> > > > +      * skip logging it.
> > > > +      */
> > > > +     if (inode->vfs_inode.i_nlink =3D=3D 0) {
> > > > +             ret =3D btrfs_commit_inode_delayed_inode(inode);
> > > > +             if (ret)
> > > > +                     goto out_unlock;
> > > > +     }
> > > > +
> > > >       ret =3D copy_inode_items_to_log(trans, inode, &min_key, &max_=
key,
> > > >                                     path, dst_path, logged_isize,
> > > >                                     inode_only, ctx,
> > > > @@ -7051,14 +7064,9 @@ static int btrfs_log_inode_parent(struct btr=
fs_trans_handle *trans,
> > > >       if (btrfs_root_generation(&root->root_item) =3D=3D trans->tra=
nsid)
> > > >               return BTRFS_LOG_FORCE_COMMIT;
> > > >
> > > > -     /*
> > > > -      * Skip already logged inodes or inodes corresponding to tmpf=
iles
> > > > -      * (since logging them is pointless, a link count of 0 means =
they
> > > > -      * will never be accessible).
> > > > -      */
> > > > -     if ((btrfs_inode_in_log(inode, trans->transid) &&
> > > > -          list_empty(&ctx->ordered_extents)) ||
> > > > -         inode->vfs_inode.i_nlink =3D=3D 0)
> > > > +     /* Skip already logged inodes and without new extents. */
> > > > +     if (btrfs_inode_in_log(inode, trans->transid) &&
> > > > +         list_empty(&ctx->ordered_extents))
> > > >               return BTRFS_NO_LOG_SYNC;
> > > >
> > > >       ret =3D start_log_trans(trans, root, ctx);
> > > > --
> > > > 2.45.2
> > > >

