Return-Path: <linux-btrfs+bounces-3612-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA5E88C963
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 17:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96361F8219D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 16:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCF21C2BD;
	Tue, 26 Mar 2024 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoANvDLC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF081803D
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470729; cv=none; b=LfmxolOTAN1fNqSUyuRz+HFKsTL7qQpzyZJQcHqhSn2xlkAXmKUiR5eWfLgc9IDCe/Jh8TEKaNabOJbPcVJCnijnvcLaXPuJjJtfNplAsxPUen+fBslpra9A7eoJ2L8xzLKoMw4YgBVtFsJSpNFSslTO++vBHg1/aLAaH8T6jgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470729; c=relaxed/simple;
	bh=HcUp8eRvYmetUoMa77TqsxnWSaWHVX2qE2J94A/RCok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZV/xnAUurWDqTy8aelSzPlwnAxf3gzm8Q63GsPJznIQTnh2OrLl+JcgC1EhPm8+jC/b8sp6uWzJBJqS1wp+XhRE6YPN/Ir1FMjbMoATxgvj3SpWqnWOGOvvUVqH5gb2H7aM4lsFv9Lb5lWVKq777kCJhjCcyd3mzhUP+V5gvuTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoANvDLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6F8C433C7
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 16:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711470728;
	bh=HcUp8eRvYmetUoMa77TqsxnWSaWHVX2qE2J94A/RCok=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qoANvDLCr+wtLvk1kggwkrtaUmgCmeNaP+NidYSv0dfX9AAou4L+uzln3M1JRPX2D
	 0SWqGQg0mnpi6BylDeXWNfuFx1pAykv1QdfhK6D4zqo2qaEinblfANhD0pilcTzmXV
	 dSNBzs+kBQv5rZERQTk7Uu+UArJaU/x+s/vD0Xt0lWzNW1Yr/PO+BnSwdWPYbwqx0W
	 pYCpt0jWN1SZKoRcnoNDmVovPKYlpC78tDQb2J2oidOiAt+VBDnNsUpQsAo9xmw5j+
	 mF62AsPQA0Cy6bmCAoWiJlLhGDKFUuGQFFMda8zINK8mUPM1/PvzFA0x2aynNQhTUH
	 hEtURZPHBRcrw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4751063318so342812666b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 09:32:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YxRme3v1fgglWKgCoWqPMKPyZ7Qw09nFBXS5PcfcRlrV7+kRORe
	S/b4xpSbXDaxbFgM0DZAapFFjYXe8FDEyy56hyi3gx5sOWC2jZG5ksFFFBkioatzPso3sAF5td7
	6UFdJRIFI6nfa2SuLTmFxh0kpkWo=
X-Google-Smtp-Source: AGHT+IGW8nO6EYL8JSD4iYa51wrTtZZGzVKL4u3NkNj9KwAgt7ptjOabW/6kS0xEF7jv5/1EoXEb4x665jGgoCVMaWs=
X-Received: by 2002:a17:906:ae5b:b0:a46:da87:26e9 with SMTP id
 lf27-20020a170906ae5b00b00a46da8726e9mr1081830ejb.77.1711470727090; Tue, 26
 Mar 2024 09:32:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <09a3da957a5b7f60a1dba5f4609971a62b3f7c23.1711134182.git.fdmanana@suse.com>
 <5fe82cceb3b6f3434172a7fb0e85a21a2f07e99c.1711199153.git.fdmanana@suse.com> <20240326160500.GA286197@zen.localdomain>
In-Reply-To: <20240326160500.GA286197@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 26 Mar 2024 16:31:30 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6Gbshitar+EpfgajTTMC8g=wxwOM-uGSzfiWZtqFOnGw@mail.gmail.com>
Message-ID: <CAL3q7H6Gbshitar+EpfgajTTMC8g=wxwOM-uGSzfiWZtqFOnGw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: stop locking the source extent range during reflink
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 4:02=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Sat, Mar 23, 2024 at 01:29:25PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Nowadays before starting a reflink operation we do this:
> >
> > 1) Take the VFS lock of the inodes in exclusive mode (a rw semaphore);
> >
> > 2) Take the  mmap lock of the inodes (struct btrfs_inode::i_mmap_lock);
> >
> > 3) Flush all dealloc in the source and target ranges;
> >
> > 4) Wait for all ordered extents in the source and target ranges to
> >    complete;
> >
> > 5) Lock the source and destination ranges in the inodes' io trees.
> >
> > In step 5 we lock the source range because:
> >
> > 1) We needed to serialize against mmap writes, but that is not needed
> >    anymore because nowadays we do that through the inode's i_mmap_lock
> >    (step 2). This happens since commit 8c99516a8cdd ("btrfs: exclude mm=
aps
> >    while doing remap");
> >
> > 2) To serialize against a concurrent relocation and avoid generating
> >    a delayed ref for an extent that was just dropped by relocation, see
> >    commit d8b552424210 (Btrfs: fix race between reflink/dedupe and
> >    relocation").
>
> Great catch! Did you notice this via blame or did a test catch it?

I remembered and there's even a comment about that in the source code.
Plus I authored d8b552424210, despite being from 2019...

> Should we try to write a test which exercises concurrent reflink and
> relocation if we don't have one?

It's not easy to hit, it requires hitting very narrow time windows,
besides having relocation and reflink in parallel,
it also needs tree mod log users running in parallel (backref walking,
fiemap, logical to ino ioctl) to prevent merging/canceling of delayed
refs IIRC,
and hit the situation I described in d8b552424210.

The issue could be hit with existing tests that exercise fsstress with
balance in parallel (btrfs/06[0-9] and btrfs/07[0-4]).

>
> >
> > Locking the source range however blocks any concurrent reads for that
> > range and makes test case generic/733 fail.
> >
> > So instead of locking the source range during reflinks, make relocation
> > read lock the inode's i_mmap_lock, so that it serializes with a concurr=
ent
> > reflink while still able to run concurrently with mmap writes and allow
> > concurrent reads too.
>
> The local locking logic (order, releasing, error-paths) all looks good
> to me. It also seems to restore a similar amount of serialization as the
> range locking with relocation, so with that said, you can add:
> Reviewed-by: Boris Burkov <boris@bur.io>
>
> However, since I missed it the first time around, now I'm a bit more
> curious about how this works.
>
> Clone doesn't seem to commit its transaction, so is there something else
> that gets relocation to see the new reference and move it as well?
> It
> just keeps looping until there are no inodes pointing at the block
> group? Or is there something about the order of adding the delayed refs
> that makes the delayed ref merging handle it better?

The relocation code eventually ends up replacing the file extent
item's bytenr if it can't try lock.
This happens somewhere through the main relocation loop IIRC.

>
> On the other hand, if relocation wins the race for the mmap lock, then
> reflink will re-create the ref with an add_delayed_extent?

If relocation wins the race, then reflink code never sees the
pre-relocation bytenr, since the subvolume leaf is locked and the
reflink code hasn't even done a search in the subvolume tree.

>  How come that
> doesn't happen without the extra locking?


>
> Hope my questions make sense :)

They make. It's not trivial stuff.
Thanks!


> Boris
>
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >
> > ---
> >
> > V2: Protect against concurrent relocation of the source extents and
> >     update comment.
> >
> >  fs/btrfs/reflink.c    | 54 ++++++++++++++-----------------------------
> >  fs/btrfs/relocation.c |  8 ++++++-
> >  2 files changed, 24 insertions(+), 38 deletions(-)
> >
> > diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> > index 08d0fb46ceec..f12ba2b75141 100644
> > --- a/fs/btrfs/reflink.c
> > +++ b/fs/btrfs/reflink.c
> > @@ -616,35 +616,6 @@ static int btrfs_clone(struct inode *src, struct i=
node *inode,
> >       return ret;
> >  }
> >
> > -static void btrfs_double_extent_unlock(struct inode *inode1, u64 loff1=
,
> > -                                    struct inode *inode2, u64 loff2, u=
64 len)
> > -{
> > -     unlock_extent(&BTRFS_I(inode1)->io_tree, loff1, loff1 + len - 1, =
NULL);
> > -     unlock_extent(&BTRFS_I(inode2)->io_tree, loff2, loff2 + len - 1, =
NULL);
> > -}
> > -
> > -static void btrfs_double_extent_lock(struct inode *inode1, u64 loff1,
> > -                                  struct inode *inode2, u64 loff2, u64=
 len)
> > -{
> > -     u64 range1_end =3D loff1 + len - 1;
> > -     u64 range2_end =3D loff2 + len - 1;
> > -
> > -     if (inode1 < inode2) {
> > -             swap(inode1, inode2);
> > -             swap(loff1, loff2);
> > -             swap(range1_end, range2_end);
> > -     } else if (inode1 =3D=3D inode2 && loff2 < loff1) {
> > -             swap(loff1, loff2);
> > -             swap(range1_end, range2_end);
> > -     }
> > -
> > -     lock_extent(&BTRFS_I(inode1)->io_tree, loff1, range1_end, NULL);
> > -     lock_extent(&BTRFS_I(inode2)->io_tree, loff2, range2_end, NULL);
> > -
> > -     btrfs_assert_inode_range_clean(BTRFS_I(inode1), loff1, range1_end=
);
> > -     btrfs_assert_inode_range_clean(BTRFS_I(inode2), loff2, range2_end=
);
> > -}
> > -
> >  static void btrfs_double_mmap_lock(struct inode *inode1, struct inode =
*inode2)
> >  {
> >       if (inode1 < inode2)
> > @@ -662,17 +633,21 @@ static void btrfs_double_mmap_unlock(struct inode=
 *inode1, struct inode *inode2)
> >  static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 le=
n,
> >                                  struct inode *dst, u64 dst_loff)
> >  {
> > +     const u64 end =3D dst_loff + len - 1;
> > +     struct extent_state *cached_state =3D NULL;
> >       struct btrfs_fs_info *fs_info =3D BTRFS_I(src)->root->fs_info;
> >       const u64 bs =3D fs_info->sectorsize;
> >       int ret;
> >
> >       /*
> > -      * Lock destination range to serialize with concurrent readahead(=
) and
> > -      * source range to serialize with relocation.
> > +      * Lock destination range to serialize with concurrent readahead(=
), and
> > +      * we are safe from concurrency with relocation of source extents
> > +      * because we have already locked the inode's i_mmap_lock in excl=
usive
> > +      * mode.
> >        */
> > -     btrfs_double_extent_lock(src, loff, dst, dst_loff, len);
> > +     lock_extent(&BTRFS_I(dst)->io_tree, dst_loff, end, &cached_state)=
;
> >       ret =3D btrfs_clone(src, dst, loff, len, ALIGN(len, bs), dst_loff=
, 1);
> > -     btrfs_double_extent_unlock(src, loff, dst, dst_loff, len);
> > +     unlock_extent(&BTRFS_I(dst)->io_tree, dst_loff, end, &cached_stat=
e);
> >
> >       btrfs_btree_balance_dirty(fs_info);
> >
> > @@ -724,6 +699,7 @@ static int btrfs_extent_same(struct inode *src, u64=
 loff, u64 olen,
> >  static noinline int btrfs_clone_files(struct file *file, struct file *=
file_src,
> >                                       u64 off, u64 olen, u64 destoff)
> >  {
> > +     struct extent_state *cached_state =3D NULL;
> >       struct inode *inode =3D file_inode(file);
> >       struct inode *src =3D file_inode(file_src);
> >       struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
> > @@ -731,6 +707,7 @@ static noinline int btrfs_clone_files(struct file *=
file, struct file *file_src,
> >       int wb_ret;
> >       u64 len =3D olen;
> >       u64 bs =3D fs_info->sectorsize;
> > +     u64 end;
> >
> >       /*
> >        * VFS's generic_remap_file_range_prep() protects us from cloning=
 the
> > @@ -763,12 +740,15 @@ static noinline int btrfs_clone_files(struct file=
 *file, struct file *file_src,
> >       }
> >
> >       /*
> > -      * Lock destination range to serialize with concurrent readahead(=
) and
> > -      * source range to serialize with relocation.
> > +      * Lock destination range to serialize with concurrent readahead(=
), and
> > +      * we are safe from concurrency with relocation of source extents
> > +      * because we have already locked the inode's i_mmap_lock in excl=
usive
> > +      * mode.
> >        */
> > -     btrfs_double_extent_lock(src, off, inode, destoff, len);
> > +     end =3D destoff + len - 1;
> > +     lock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state=
);
> >       ret =3D btrfs_clone(src, inode, off, olen, len, destoff, 0);
> > -     btrfs_double_extent_unlock(src, off, inode, destoff, len);
> > +     unlock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_sta=
te);
> >
> >       /*
> >        * We may have copied an inline extent into a page of the destina=
tion
> > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > index f96f267fb4aa..8fe495d74776 100644
> > --- a/fs/btrfs/relocation.c
> > +++ b/fs/btrfs/relocation.c
> > @@ -1127,16 +1127,22 @@ int replace_file_extents(struct btrfs_trans_han=
dle *trans,
> >                                                   fs_info->sectorsize))=
;
> >                               WARN_ON(!IS_ALIGNED(end, fs_info->sectors=
ize));
> >                               end--;
> > +                             /* Take mmap lock to serialize with refli=
nks. */
> > +                             if (!down_read_trylock(&BTRFS_I(inode)->i=
_mmap_lock))
> > +                                     continue;
> >                               ret =3D try_lock_extent(&BTRFS_I(inode)->=
io_tree,
> >                                                     key.offset, end,
> >                                                     &cached_state);
> > -                             if (!ret)
> > +                             if (!ret) {
> > +                                     up_read(&BTRFS_I(inode)->i_mmap_l=
ock);
> >                                       continue;
> > +                             }
> >
> >                               btrfs_drop_extent_map_range(BTRFS_I(inode=
),
> >                                                           key.offset, e=
nd, true);
> >                               unlock_extent(&BTRFS_I(inode)->io_tree,
> >                                             key.offset, end, &cached_st=
ate);
> > +                             up_read(&BTRFS_I(inode)->i_mmap_lock);
> >                       }
> >               }
> >
> > --
> > 2.43.0
> >

