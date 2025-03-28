Return-Path: <linux-btrfs+bounces-12652-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C28A74EC4
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 18:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B121898682
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 17:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3776E1DE3BD;
	Fri, 28 Mar 2025 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOjXmbMf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7906E1DB15C
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181271; cv=none; b=EppeVdUSoCWicnOI+v0FGLbP4u8BM+Yw7Rb2bR0cg6fSou1X/DfUiwblvUShXf+kWjcyjBkAsiG4N/QTBxk9DP0Bc4lqtqF8QyGru+gLsLG/yzSwD9OtH7D8EiImJjoc6WwW2bKQweoIEqoGI+SRBEzz4nnOyXYDmLVHV1t73lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181271; c=relaxed/simple;
	bh=uXE1p861Ouq854KbfMV4h+dUX3yEYMp34zFvNk9QRGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAztTK6JoMG4o670x2/xSrP38WQApNUKx4+GtHEfRxXz/8N/hmVFvXdw8sbheW7Sat1O4NKAb/aajS1yWvmV8fEUhOSK1h8UppBN2uCbkew+3KEjpjvnAQHsYENIEw1Us5aF0MbxqJ+qC/SBgRSR9BtFpWLJm3sAlYrkI4DzD/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOjXmbMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E559EC4CEEB
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 17:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743181270;
	bh=uXE1p861Ouq854KbfMV4h+dUX3yEYMp34zFvNk9QRGc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WOjXmbMfl5LBZ/hJ5n1NYqTpaoitHNwtihn1ZgxNle751IuNFb6XHGHLBi2HGVCpN
	 bTNCSgC4E9Iu6KGnVIHyGlD368E3zMYhJcrh82tWRmM5+bG3rFExxsRal5iq53GcsC
	 G31revCWLkl2TGTEPWXBLaptf8g7gIaxsYytZIZzlAsgee1jEeqJLf4JzZC/mKLG1H
	 8ATQqaZdMiaCc//nwtqBgcBhTwmT90cjq6yIXcdXnStTf4vh01txOEQwKK9JYZBg++
	 dblYIkpocTrjo43hRFOLDzcX57Z+67j9eAHTrIb6lfjkGflvrKvwUV/wWiauVNbR1l
	 YQcK4BRiHOtog==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac29fd22163so409512866b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 10:01:10 -0700 (PDT)
X-Gm-Message-State: AOJu0YxWmRhfJeWT2m5wi6nRYEH0IMpBqce4gHU0kSolb2rkJva44ZmF
	9f4zULEw218Vj1Y19xlYlYeocOl9kvLT8VrySva43N8bx9D3XqDXfM+ZWvlMWIP4JCWxDSiwmwl
	qUr/IyOi1toIRdbNJKcir1DqF15Q=
X-Google-Smtp-Source: AGHT+IGPx8BuR53vg5DWaOZ8mESDCWrfa8p7/xLCD0U3/ZWnDLM1NJBTluO+CO4OGgsf2qSEZuLzJkxoGoSR1rQLwNQ=
X-Received: by 2002:a17:906:eb4e:b0:ac7:30a2:696c with SMTP id
 a640c23a62f3a-ac730a26a0bmr126131366b.16.1743181268810; Fri, 28 Mar 2025
 10:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5b44edaf3e472a234a13e8cf2dd8c96f35970996.1742490795.git.fdmanana@suse.com>
 <20250328161021.GA1042522@zen.localdomain>
In-Reply-To: <20250328161021.GA1042522@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 28 Mar 2025 17:00:32 +0000
X-Gmail-Original-Message-ID: <CAL3q7H73A+5=pjc_QuhR136j1B8ndZV=M2c+a6Tfy=zCRmsJXQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqS0WHCuL1IoEMp5Jh4Sqvp-lOTLH7w9SWl6FgCAR6OTUIzveGBgvljK4g
Message-ID: <CAL3q7H73A+5=pjc_QuhR136j1B8ndZV=M2c+a6Tfy=zCRmsJXQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix fsync of files with no hard links not
 persisting deletion
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 4:09=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Fri, Mar 21, 2025 at 11:08:53AM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > If we fsync a file (or directory) that has no more hard links, because
> > while a process had a file descriptor open on it, the file's last hard
> > link was removed and then the process did an fsync against the file
> > descriptor, after a power failure or crash the file still exists after
> > replaying the log.
> >
> > This behaviour is incorrect since once an inode has no more hard links
> > it's not accessible anymore and we insert an orphan item into its
> > subvolume's tree so that the deletion of all its items is not missed in
> > case of a power failure or crash.
> >
> > So after log replay the file shouldn't exist anymore, which is also the
> > behaviour on ext4, xfs, f2fs and other filesystems.
> >
> > Fix this by not ignoring inodes with zero hard links at
> > btrfs_log_inode_parent() and by comitting an inode's delayed inode when
> > we are not doing a fast fsync (either BTRFS_INODE_COPY_EVERYTHING or
> > BTRFS_INODE_NEEDS_FULL_SYNC is set in the inode's runtime flags). This
> > last step is necessary because when removing the last hard link we don'=
t
> > delete the corresponding ref (or extref) item, instead we record the
> > change in the inode's delayed inode with the BTRFS_DELAYED_NODE_DEL_IRE=
F
> > flag, so that when the delayed inode is committed we delete the ref/ext=
ref
> > item from the inode's subvolume tree - otherwise the logging code will =
log
> > the last hard link and therefore upon log replay the inode is not delet=
ed.
> >
> > The base code for a fstests test case that reproduces this bug is the
> > following:
> >
> >    . ./common/dmflakey
> >
> >    _require_scratch
> >    _require_dm_target flakey
> >    _require_mknod
> >
> >    _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> >    _require_metadata_journaling $SCRATCH_DEV
> >    _init_flakey
> >    _mount_flakey
> >
> >    touch $SCRATCH_MNT/foo
> >
> >    # Commit the current transaction and persist the file.
> >    _scratch_sync
> >
> >    # A fifo to communicate with a background xfs_io process that will
> >    # fsync the file after we deleted its hard link while it's open by
> >    # xfs_io.
> >    mkfifo $SCRATCH_MNT/fifo
> >
> >    tail -f $SCRATCH_MNT/fifo | \
> >         $XFS_IO_PROG $SCRATCH_MNT/foo >>$seqres.full &
> >    XFS_IO_PID=3D$!
> >
> >    # Give some time for the xfs_io process to open a file descriptor fo=
r
> >    # the file.
> >    sleep 1
> >
> >    # Now while the file is open by the xfs_io process, delete its only
> >    # hard link.
> >    rm -f $SCRATCH_MNT/foo
> >
> >    # Now that it has no more hard links, make the xfs_io process fsync =
it.
> >    echo "fsync" > $SCRATCH_MNT/fifo
>
> What specifies the ordering semantics between the rm and fsync if they
> come from different processes?

An fsync is required to persist all data and metadata changes to a
file that happened before the fsync.
It doesn't matter which process does the changes or the fsync.


>
> i.e., if you did the rm in a different process, it seems like the unlink
> could race with your new check and still let the file live. OTOH, if the
> rm comes fully "after" the fsync, that is what we would expect anyway,
> so I can't figure out how to reason about it :)

Race how?
fsync takes the inode mutex, and so does every write and metadata
change to the inode.

>
> Are guarantees about fs ops being visible after fsync only applicable in
> the same process?

They are applicable to all changes made by any process before the fsync.
Even the first line from the man page makes that clear:

"fsync, fdatasync - synchronize a file's in-core state with storage device"

> Repro and fix look good otherwise, so if that race is definitionally not
> a concern you can add:
> Reviewed-by: Boris Burkov <boris@bur.io>
>
> Less important, but I think it might be worthwhile to also include
> some reasoning in the commit message about why this change is safe
> for O_TMPFILE w.r.t fsync and crashes.

Hum, what do you mean? Why wouldn't it be safe?
O_TMPFILE files don't have inode refs / extrefs, so there's no
difference in regards to dealing with a file that has now 0 links but
used to have more.

Thanks.

>
> Thanks,
> Boris
>
> >
> >    # Terminate the xfs_io process so that we can unmount.
> >    echo "quit" > $SCRATCH_MNT/fifo
> >    wait $XFS_IO_PID
> >    unset XFS_IO_PID
> >
> >    # Simulate a power failure and then mount again the filesystem to
> >    # replay the journal/log.
> >    _flakey_drop_and_remount
> >
> >    # We don't expect the file to exist anymore, since it was fsynced wh=
en
> >    # it had no more hard links.
> >    [ -f $SCRATCH_MNT/foo ] && echo "file foo still exists"
> >
> >    _unmount_flakey
> >
> >    # success, all done
> >    echo "Silence is golden"
> >    status=3D0
> >    exit
> >
> > A test case for fstests will be submitted soon.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/tree-log.c | 24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index 90dc094cfa5e..f5af11565b87 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -6583,6 +6583,19 @@ static int btrfs_log_inode(struct btrfs_trans_ha=
ndle *trans,
> >               btrfs_log_get_delayed_items(inode, &delayed_ins_list,
> >                                           &delayed_del_list);
> >
> > +     /*
> > +      * If we are fsyncing a file with 0 hard links, then commit the d=
elayed
> > +      * inode because the last inode ref (or extref) item may still be=
 in the
> > +      * subvolume tree and if we log it the file will still exist afte=
r a log
> > +      * replay. So commit the delayed inode to delete that last ref an=
d we
> > +      * skip logging it.
> > +      */
> > +     if (inode->vfs_inode.i_nlink =3D=3D 0) {
> > +             ret =3D btrfs_commit_inode_delayed_inode(inode);
> > +             if (ret)
> > +                     goto out_unlock;
> > +     }
> > +
> >       ret =3D copy_inode_items_to_log(trans, inode, &min_key, &max_key,
> >                                     path, dst_path, logged_isize,
> >                                     inode_only, ctx,
> > @@ -7051,14 +7064,9 @@ static int btrfs_log_inode_parent(struct btrfs_t=
rans_handle *trans,
> >       if (btrfs_root_generation(&root->root_item) =3D=3D trans->transid=
)
> >               return BTRFS_LOG_FORCE_COMMIT;
> >
> > -     /*
> > -      * Skip already logged inodes or inodes corresponding to tmpfiles
> > -      * (since logging them is pointless, a link count of 0 means they
> > -      * will never be accessible).
> > -      */
> > -     if ((btrfs_inode_in_log(inode, trans->transid) &&
> > -          list_empty(&ctx->ordered_extents)) ||
> > -         inode->vfs_inode.i_nlink =3D=3D 0)
> > +     /* Skip already logged inodes and without new extents. */
> > +     if (btrfs_inode_in_log(inode, trans->transid) &&
> > +         list_empty(&ctx->ordered_extents))
> >               return BTRFS_NO_LOG_SYNC;
> >
> >       ret =3D start_log_trans(trans, root, ctx);
> > --
> > 2.45.2
> >

