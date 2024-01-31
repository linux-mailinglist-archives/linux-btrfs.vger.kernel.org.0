Return-Path: <linux-btrfs+bounces-1977-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B74844940
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 21:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF95F1F275CA
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 20:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8189339877;
	Wed, 31 Jan 2024 20:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCUVL7Dv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC90E39859
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 20:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706734583; cv=none; b=i85GqdquyK3xBLXQpiqOY7X+6DSbTAIwMqtQRfx84UvUNnsXoTudnbSh9g35yX3nPwZ2L9FbwWwY17QOxxMiHtRVnG925Wxa0UkMF+u3DilkXBaiFIuzHZfOBj02IITmx481J9Y+8f23wFQJH3oD4JTA2uydRPlE6dVRvBJxTjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706734583; c=relaxed/simple;
	bh=7iT0NJjmJeNkpCwdCcxbk0e7BjOLcCnA1hEyW0RcUvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HEVzjiP8eLxZOp0E6wiHEmCyDmYPSThFvoxocyiqYqDZCWg03j2ZPq4cihyQ8BpZqDBTvo5dD1/3Xo6MxMFDUjVud92CavY2e3GEvHDN5aEURSXJWPLlFAEEOLIoPfLVGOyEvCGzBuQ14d3+89D3pOYBzRd1u/6yhDetV8YyJk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCUVL7Dv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2902CC43390
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 20:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706734582;
	bh=7iT0NJjmJeNkpCwdCcxbk0e7BjOLcCnA1hEyW0RcUvo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nCUVL7DvSavxQ1M5kwFFKigYnp3cWnLLBWfMq52lFZI+BPI88XEUcGnz/S5js6NPW
	 gbA3DMvwbJrMYN7DAxe2QdsP6kqe92itjgh7Ht8B6182+6KPOFVdO3qlHPs1+48tjq
	 cqgOhmodk3TKubQoST+VWQyPjoieqSlJeqhwON1stsmDePp0YZQnpRdxXvDYUukpqH
	 jFwUf7SJTbPuLmV1MaFqVqobqbYmOhykD2kdeLsXPZu9dK78vCNxGsab3lKYIxLgyD
	 0rFq2DuAxQ0qA2Ii7I3zQcEd4okEMmlOWxyj4aBgzRJlKMPjNBEwTD0LIbFuQjpAl4
	 /3Nskbi0ue8cg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a35385da5bbso25996366b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 12:56:22 -0800 (PST)
X-Gm-Message-State: AOJu0YxZ+NgQaIdRmHAfqz+6qLhXozv5TSnNm4brXUvhvlFYGpgqcEMW
	KmHI6MSnq7DyoYbzqOdwKowCc2RZ7/p3JOXn4NrVp1tgQGsG4lv4MMs+1iY3DkZv+2Yg4WYdMsS
	UZem3bpAWeIblfEqmcLMnSuRQsMQ=
X-Google-Smtp-Source: AGHT+IHMFCrLgcUFtL3nGIZ5KNIfxy0wEZWXEmk0CTstsi5XGef8e6uoOel/CsJs2R+ODeUWGEU6Ng5W9cYKGtV9YDY=
X-Received: by 2002:a17:906:c457:b0:a35:edda:ca85 with SMTP id
 ck23-20020a170906c45700b00a35eddaca85mr1941821ejb.67.1706734580467; Wed, 31
 Jan 2024 12:56:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1ef0997eee1fbe194ab2546f34052cd4e27c6ef4.1706612525.git.fdmanana@suse.com>
 <20240131204148.GA3203388@perftesting>
In-Reply-To: <20240131204148.GA3203388@perftesting>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 31 Jan 2024 20:55:43 +0000
X-Gmail-Original-Message-ID: <CAL3q7H60nJ5ir3-64u78FyGaj5KTw5KQdtY4Vhz=uDutUaFgEQ@mail.gmail.com>
Message-ID: <CAL3q7H60nJ5ir3-64u78FyGaj5KTw5KQdtY4Vhz=uDutUaFgEQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: preallocate temporary extent buffer for inode
 logging when needed
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 8:41=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Tue, Jan 30, 2024 at 11:05:44AM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When logging an inode and we require to copy items from subvolume leave=
s
> > to the log tree, we clone each subvolume leaf and than use that clone t=
o
> > copy items to the log tree. This is required to avoid possible deadlock=
s
> > as stated in commit 796787c978ef ("btrfs: do not modify log tree while
> > holding a leaf from fs tree locked").
> >
> > The cloning requires allocating an extent buffer (struct extent_buffer)
> > and then allocating pages (folios) to attach to the extent buffer. This
> > may be slow in case we are under memory pressure, and since we are doin=
g
> > the cloning while holding a read lock on a subvolume leaf, it means we
> > can be blocking other operations on that leaf for significant periods o=
f
> > time, which can increase latency on operations like creating other file=
s,
> > renaming files, etc. Similarly because we're under a log transaction, w=
e
> > may also cause extra delay on other tasks doing an fsync, because synci=
ng
> > the log requires waiting for tasks that joined a log transaction to exi=
t
> > the transaction.
> >
> > So to improve this, for any inode logging operation that needs to copy
> > items from a subvolume leaf ("full sync" or "copy everything" bit set
> > in the inode), preallocate a dummy extent buffer before locking any
> > extent buffer from the subvolume tree, and even before joining a log
> > transaction, add it to the log context and then use it when we need to
> > copy items from a subvolume leaf to the log tree. This avoids making
> > other operations get extra latency when waiting to lock a subvolume
> > leaf that is used during inode logging and we are under heavy memory
> > pressure.
> >
> > The following test script with bonnie++ was used to test this:
> >
> >   $ cat test.sh
> >   #!/bin/bash
> >
> >   DEV=3D/dev/sdh
> >   MNT=3D/mnt/sdh
> >   MOUNT_OPTIONS=3D"-o ssd"
> >
> >   MEMTOTAL_BYTES=3D`free -b | grep Mem: | awk '{ print $2 }'`
> >   NR_DIRECTORIES=3D20
> >   NR_FILES=3D20480
> >   DATASET_SIZE=3D$((MEMTOTAL_BYTES * 2 / 1048576))
> >   DIRECTORY_SIZE=3D$((MEMTOTAL_BYTES * 2 / NR_FILES))
> >   NR_FILES=3D$((NR_FILES / 1024))
> >
> >   echo "performance" | \
> >       tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> >
> >   umount $DEV &> /dev/null
> >   mkfs.btrfs -f $MKFS_OPTIONS $DEV
> >   mount $MOUNT_OPTIONS $DEV $MNT
> >
> >   bonnie++ -u root -d $MNT \
> >       -n $NR_FILES:$DIRECTORY_SIZE:$DIRECTORY_SIZE:$NR_DIRECTORIES \
> >       -r 0 -s $DATASET_SIZE -b
> >
> >   umount $MNT
> >
> > The results of this test on a 8G VM running a non-debug kernel (Debian'=
s
> > default kernel config), were the following.
> >
> > Before this change:
> >
> >   Version 2.00a       ------Sequential Output------ --Sequential Input-=
 --Random-
> >                       -Per Chr- --Block-- -Rewrite- -Per Chr- --Block--=
 --Seeks--
> >   Name:Size etc        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP=
  /sec %CP
> >   debian0       7501M  376k  99  1.4g  96  117m  14 1510k  99  2.5g  95=
 +++++ +++
> >   Latency             35068us   24976us    2944ms   30725us   71770us  =
 26152us
> >   Version 2.00a       ------Sequential Create------ --------Random Crea=
te--------
> >   debian0             -Create-- --Read--- -Delete-- -Create-- --Read---=
 -Delete--
> >   files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP=
  /sec %CP
> >   20:384100:384100/20 20480  32 20480  58 20480  48 20480  39 20480  56=
 20480  61
> >   Latency               411ms   11914us     119ms     617ms   10296us  =
   110ms
> >
> > After this change:
> >
> >   Version 2.00a       ------Sequential Output------ --Sequential Input-=
 --Random-
> >                       -Per Chr- --Block-- -Rewrite- -Per Chr- --Block--=
 --Seeks--
> >   Name:Size etc        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP=
  /sec %CP
> >   debian0       7501M  375k  99  1.4g  97  117m  14 1546k  99  2.3g  98=
 +++++ +++
> >   Latency             35975us  20945us    2144ms   10297us    2217us   =
 6004us
> >   Version 2.00a       ------Sequential Create------ --------Random Crea=
te--------
> >   debian0             -Create-- --Read--- -Delete-- -Create-- --Read---=
 -Delete--
> >   files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP=
  /sec %CP
> >   20:384100:384100/20 20480  35 20480  58 20480  48 20480  40 20480  57=
 20480  59
> >   Latency               320ms   11237us   77779us     518ms    6470us  =
 86389us
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/file.c     | 12 ++++++
> >  fs/btrfs/tree-log.c | 93 +++++++++++++++++++++++++++------------------
> >  fs/btrfs/tree-log.h | 25 ++++++++++++
> >  3 files changed, 94 insertions(+), 36 deletions(-)
> >
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index f8e1a7ce3d39..fd5e23035a28 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -1912,6 +1912,8 @@ int btrfs_sync_file(struct file *file, loff_t sta=
rt, loff_t end, int datasync)
> >               goto out_release_extents;
> >       }
> >
> > +     btrfs_init_log_ctx_scratch_eb(&ctx);
> > +
> >       /*
> >        * We use start here because we will need to wait on the IO to co=
mplete
> >        * in btrfs_sync_log, which could require joining a transaction (=
for
> > @@ -1931,6 +1933,15 @@ int btrfs_sync_file(struct file *file, loff_t st=
art, loff_t end, int datasync)
> >       trans->in_fsync =3D true;
> >
> >       ret =3D btrfs_log_dentry_safe(trans, dentry, &ctx);
> > +     /*
> > +      * Scratch eb no longer needed, release before syncing log or com=
mit
> > +      * transaction, to avoid holding unnecessary memory during such l=
ong
> > +      * operations.
> > +      */
> > +     if (ctx.scratch_eb) {
> > +             free_extent_buffer(ctx.scratch_eb);
> > +             ctx.scratch_eb =3D NULL;
> > +     }
> >       btrfs_release_log_ctx_extents(&ctx);
> >       if (ret < 0) {
> >               /* Fallthrough and commit/free transaction. */
> > @@ -2006,6 +2017,7 @@ int btrfs_sync_file(struct file *file, loff_t sta=
rt, loff_t end, int datasync)
> >
> >       ret =3D btrfs_commit_transaction(trans);
> >  out:
> > +     free_extent_buffer(ctx.scratch_eb);
> >       ASSERT(list_empty(&ctx.list));
> >       ASSERT(list_empty(&ctx.conflict_inodes));
> >       err =3D file_check_and_advance_wb_err(file);
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index 331fc7429952..761b13b3d342 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -3619,6 +3619,30 @@ static int flush_dir_items_batch(struct btrfs_tr=
ans_handle *trans,
> >       return ret;
> >  }
> >
> > +static int clone_leaf(struct btrfs_path *path, struct btrfs_log_ctx *c=
tx)
> > +{
> > +     const int slot =3D path->slots[0];
> > +
> > +     if (ctx->scratch_eb) {
> > +             copy_extent_buffer_full(ctx->scratch_eb, path->nodes[0]);
> > +     } else {
> > +             ctx->scratch_eb =3D btrfs_clone_extent_buffer(path->nodes=
[0]);
> > +             if (!ctx->scratch_eb)
> > +                     return -ENOMEM;
> > +     }
> > +
> > +     btrfs_release_path(path);
> > +     path->nodes[0] =3D ctx->scratch_eb;
>
> Here we put the scratch_b into path->nodes[0], so if we go do the next le=
af in
> the copy_items loop we'll drop our reference for this scratch_eb, and the=
n we're
> just writing into free'd memory.  Am I missing something here?  Thanks,

That's why below we take an extra reference on the scratch_eb, it's
even commented.

Thanks.

>
> Josef

