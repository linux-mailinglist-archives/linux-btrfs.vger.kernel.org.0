Return-Path: <linux-btrfs+bounces-15767-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BC4B168AC
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 23:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3033A38BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 21:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81290225760;
	Wed, 30 Jul 2025 21:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1z4XW+Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F922206B5
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 21:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912745; cv=none; b=rSP00DuLMpH/B7kS2/ulGVCFGNmLj4HSATUhn2JJbu15HXYGxyxf+CHYxTJpaGKC8KvkM/q4/bJ04kah1MbCkRZ75F7Y+/T5xINBWFvDlufKWQyWz/nkM65wgo/C89nuDBC53z+zDdtQ6srEGPPfEXB5OdLSN+b5nps/2RFtiZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912745; c=relaxed/simple;
	bh=ZKld/HcrGQz4GsE6rPEQnr6qyp8N6IH0Zwc6JaclicA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlWOtEZ3UR4LMWZOMJvx2F3IqAhrmnf3uS3WZ2kpAsU4Upp1AUAFfvu+p+8JTU7ACkMj7uPDLyzXu3AjeFuH5vgNg9gGMELtGE6JYBDfWVtSXbNgR+6ee73YW+9S0ksMmO4ixzjXmmK1kSPxsqVYMxhWxOuxuQlBJdRVS0gFEVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1z4XW+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E76DC4CEE3
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 21:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753912745;
	bh=ZKld/HcrGQz4GsE6rPEQnr6qyp8N6IH0Zwc6JaclicA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W1z4XW+YBaWkiIPW5p9Q+0V0Tj+pAHj7fGswXVFrRuoMLsczdlof7+Mu1AJD6iwGT
	 7kMT4pJq9gT0zhWYPMDuoUWpXKVrKP4EsNRRFgRfBc597uNFR5nA+yQpyTPMjyOfxL
	 HAL65LyU0iBnaErfbUtQbMPkaa9XWZyQ8NV3X3MNfdKkjr7dGYOxAE/oaEw9kpj86k
	 6D0BAdcoGRcT4ZRL40lj17SAqS/tCLCQD3VGkYaFJbAE2Ojnp1IN8foVzNDlMYjWC6
	 0pnJY9ET2MyvqBjtJ2KbA2ez9jglVlgIatYc6KRvy8SW5jJUh/RYMG74LujTMubVFj
	 fbOKGxClF9ifg==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-615aa7de35bso148783a12.2
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 14:59:05 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw8Uzu+IfIOmsfG/Lnf6XCnAKpJrV42OvtVYHr7mgeJdROoRoZX
	M1RWX/YeFwCCbfsUNjDUGJpZSaICT0oobFysY+rhjemQeL/DepZYB4FJCn6jzGgf5HkvAKmQVr4
	n2QYHWvqZ9bpwroPGsu0pm7eYj5fqRu4=
X-Google-Smtp-Source: AGHT+IEgSPqUNC/4BPZvMle7xopsioZKyetn8KXI/0j+au1vfmpmmBFtwNlY0MBUa2L5rVN5WIyDosXUJqK3WHkelFg=
X-Received: by 2002:a17:907:1c93:b0:ad1:e4e9:6b4f with SMTP id
 a640c23a62f3a-af8fd9bbd53mr635584366b.36.1753912743801; Wed, 30 Jul 2025
 14:59:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5c89804b07e3681c3a9bc50bf1d63d9ce77d7020.1753902432.git.fdmanana@suse.com>
 <20250730201752.GA909565@zen.localdomain>
In-Reply-To: <20250730201752.GA909565@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 30 Jul 2025 22:58:25 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4T2n4q1JsJsmQYE0t+p3YWFwtifBBJ9KKkE=iC4MaVLQ@mail.gmail.com>
X-Gm-Features: Ac12FXxgqp-58AvDmS4Bcz6VHjAzOZtL8LoRg8eKyDgBTqdeAX5rG8iWW-Sx7_8
Message-ID: <CAL3q7H4T2n4q1JsJsmQYE0t+p3YWFwtifBBJ9KKkE=iC4MaVLQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix log tree replay failure due to file with 0
 links and extents
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 9:16=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Wed, Jul 30, 2025 at 08:20:40PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > If we log a new inode (not persisted in a past transaction) that has 0
> > links and extents, then log another inode with an higher inode number, =
we
> > end up with failing to replay the log tree with -EINVAL. The steps for
> > this are:
> >
> > 1) create new file A
> > 2) write some data to file A
> > 3) open an fd on file A
> > 4) unlink file A
> > 5) fsync file A using the previously open fd
> > 6) create file B (has higher inode number than file A)
> > 7) fsync file B
> > 8) power fail before current transaction commits
> >
> > Now when attempting to mount the fs, the log replay will fail with
> > -ENOENT at replay_one_extent() when attempting to replay the first
> > extent of file A. The failure comes when trying to open the inode for
> > file A in the subvolume tree, since it doesn't exist.
> >
> > Before commit 5f61b961599a ("btrfs: fix inode lookup error handling
> > during log replay"), the returned error was -EIO instead of -ENOENT,
> > since we converted any errors when attempting to read an inode during
> > log replay to -EIO.
> >
> > The reason for this is that the log replay procedure fails to ignore
> > the current inode when we are at the stage LOG_WALK_REPLAY_ALL, our
> > current inode has 0 links and last inode we processed in the previous
> > stage has a non 0 link count. In other words, the issue is that at
> > replay_one_extent() we only update wc->ignore_cur_inode if the current
> > replay stage is LOG_WALK_REPLAY_INODES.
> >
> > Fix this by updating wc->ignore_cur_inode whenever we find an inode ite=
m
> > regardless of the current replay stage. This is a simple solution and e=
asy
> > to backport, but later we can do other alternatives like avoid logging
> > extents or inode items other than the inode item for inodes with a link
> > count of 0.
> >
> > The problem with the wc->ignore_cur_inode logic has been around since
> > commit f2d72f42d5fa ("Btrfs: fix warning when replaying log after fsync
> > of a tmpfile") but it only became frequent to hit since the more recent
> > commit 5e85262e542d ("btrfs: fix fsync of files with no hard links not
> > persisting deletion"), because we stopped skipping inodes with a link
> > count of 0 when logging, while before the problem would only be trigger=
ed
> > if trying to replay a log tree created with an older kernel which has a
> > logged inode with 0 links.
> >
> > A test case for fstests will be submitted soon.
>
> Great catch and explanation.
>
> While studying the ignore_cur_inode and stage logic a bit more carefully
> I noticed that ignore_cur_inodes has a comment where it is defined in
> struct walk_control that says it needs to be set only in the
> LOG_WALK_REPLAY_INODES stage, which is no longer true.

I'll update that before pushing to for-next, thanks.


>
> Reviewed-by: Boris Burkov <boris@bur.io>
>
> >
> > Reported-by: Peter Jung <ptr1337@cachyos.org>
> > Link: https://lore.kernel.org/linux-btrfs/fce139db-4458-4788-bb97-c29ac=
f6cb1df@cachyos.org/
> > Reported-by: burneddi <burneddi@protonmail.com>
> > Link: https://lore.kernel.org/linux-btrfs/lh4W-Lwc0Mbk-QvBhhQyZxf6VbM3E=
8VtIvU3fPIQgweP_Q1n7wtlUZQc33sYlCKYd-o6rryJQfhHaNAOWWRKxpAXhM8NZPojzsJPyHMf=
2qY=3D@protonmail.com/#t
> > Reported-by: Russell Haley <yumpusamongus@gmail.com>
> > Link: https://lore.kernel.org/linux-btrfs/598ecc75-eb80-41b3-83c2-f2317=
fbb9864@gmail.com/
> > Fixes: f2d72f42d5fa ("Btrfs: fix warning when replaying log after fsync=
 of a tmpfile")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/tree-log.c | 42 ++++++++++++++++++++++++++++--------------
> >  1 file changed, 28 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index 8c6d1eb84d0e..09ddb2ee4df4 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -2602,23 +2602,30 @@ static int replay_one_buffer(struct btrfs_root =
*log, struct extent_buffer *eb,
> >
> >       nritems =3D btrfs_header_nritems(eb);
> >       for (i =3D 0; i < nritems; i++) {
> > -             btrfs_item_key_to_cpu(eb, &key, i);
> > +             struct btrfs_inode_item *inode_item;
> >
> > -             /* inode keys are done during the first stage */
> > -             if (key.type =3D=3D BTRFS_INODE_ITEM_KEY &&
> > -                 wc->stage =3D=3D LOG_WALK_REPLAY_INODES) {
> > -                     struct btrfs_inode_item *inode_item;
> > -                     u32 mode;
> > +             btrfs_item_key_to_cpu(eb, &key, i);
> >
> > -                     inode_item =3D btrfs_item_ptr(eb, i,
> > -                                         struct btrfs_inode_item);
> > +             if (key.type =3D=3D BTRFS_INODE_ITEM_KEY) {
> > +                     inode_item =3D btrfs_item_ptr(eb, i, struct btrfs=
_inode_item);
> >                       /*
> > -                      * If we have a tmpfile (O_TMPFILE) that got fsyn=
c'ed
> > -                      * and never got linked before the fsync, skip it=
, as
> > -                      * replaying it is pointless since it would be de=
leted
> > -                      * later. We skip logging tmpfiles, but it's alwa=
ys
> > -                      * possible we are replaying a log created with a=
 kernel
> > -                      * that used to log tmpfiles.
> > +                      * An inode with no links is either:
> > +                      *
> > +                      * 1) A tmpfile (O_TMPFILE) that got fsync'ed and=
 never
> > +                      *    got linked before the fsync, skip it, as re=
playing
> > +                      *    it is pointless since it would be deleted l=
ater.
> > +                      *    We skip logging tmpfiles, but it's always p=
ossible
> > +                      *    we are replaying a log created with a kerne=
l that
> > +                      *    used to log tmpfiles;
> > +                      *
> > +                      * 2) A non-tmpfile which got its last link delet=
ed
> > +                      *    while holding an open fd on it and later go=
t
> > +                      *    fsynced through that fd. We always log the
> > +                      *    parent inodes when inode->last_unlink_trans=
 is
> > +                      *    set to the current transaction, so ignore a=
ll the
> > +                      *    inode items for this inode. We will delete =
the
> > +                      *    inode when processing the parent directory =
with
> > +                      *    replay_dir_deletes().
> >                        */
> >                       if (btrfs_inode_nlink(eb, inode_item) =3D=3D 0) {
> >                               wc->ignore_cur_inode =3D true;
> > @@ -2626,6 +2633,13 @@ static int replay_one_buffer(struct btrfs_root *=
log, struct extent_buffer *eb,
> >                       } else {
> >                               wc->ignore_cur_inode =3D false;
> >                       }
> > +             }
> > +
> > +             /* Inode keys are done during the first stage. */
> > +             if (key.type =3D=3D BTRFS_INODE_ITEM_KEY &&
> > +                 wc->stage =3D=3D LOG_WALK_REPLAY_INODES) {
> > +                     u32 mode;
> > +
> >                       ret =3D replay_xattr_deletes(trans, root, log, pa=
th, key.objectid);
> >                       if (ret)
> >                               break;
> > --
> > 2.47.2
> >

