Return-Path: <linux-btrfs+bounces-16364-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25907B35AE6
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 13:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D347A99AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 11:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD582BEFF0;
	Tue, 26 Aug 2025 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cy+AoiTo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8782BDC00;
	Tue, 26 Aug 2025 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756206879; cv=none; b=RCaneIW0poW2LlBwKvYVrgYMWC+1RutTwGix7KD276isMp4rOUL7gN5BbUE2kg8Sx8ghDrG3nMmAbYP1tVb8at0QbXgDpzv5mraopeQ+oRzilUvDeFJJjqNVNM0NzJhOzYpwOCmVF2nOmEi/G8/yYxR8osCVXrSnpyiUg3XwL3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756206879; c=relaxed/simple;
	bh=EIG+PTN3nFfQoDguR2fuoUdfJby6oIkXdTscfqHqQpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BsQ4NCx9pGaYLYZoR/oZLyrt1T/+jxqMoQ1j3dAF6tFgoTEOgFGsGzdwMSrJwp8/PxckDEvGDV0Pu3u/vsiODMTBbjvXCtDRgz7/bosQg/ZbEH9jmjk/B6Vuto11YoQvLZQWPfulD0MLUMiek0kYsz2Z5JsccMJPoVsMViiWg0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cy+AoiTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60283C4CEF1;
	Tue, 26 Aug 2025 11:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756206878;
	bh=EIG+PTN3nFfQoDguR2fuoUdfJby6oIkXdTscfqHqQpE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cy+AoiTo8/9FCSJPTp9VG9+EsV7+F6Zq3qsvFpnJmWvvaSeUjLV5DiLYFnFkXJVP7
	 A383ep4k8pxtXKdUxwlKCnCrnfxmDMNtKYAhfO1QL58JmJKFR0tqcikWxmpCSBrmhN
	 FpW41xH3ag1VlNEgHMPs1+HHhpGM9NcJf1kIcHw4V6tg96fBXe0/3giCLPlRiN5ib9
	 fCMZSsjOxgqU2C8c9YpyBLMdG97wjJRgBBWxolxE2V+uyT7BhAaAV+ztx1tAQXBHLu
	 /BOyLkDHtXoLZqGWaIUTdHJkV4UbiEG09RrKFr0TAzzOks1YFsDH5jAad+wUv5Pr1q
	 iQccreusBooRg==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7ae31caso1000169166b.3;
        Tue, 26 Aug 2025 04:14:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV79VRDDLO2XxuWSOK6lZkUeoHNAEWOzUdb2XqsOAGbseS441yM/mMBj96R5hSLZ2QHVw6JZ6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqte1XeYWtTW+Dqt/GTSHxlY2VfC58q70KcTbJGuxvSb0F6Zui
	TPIsB2jQL9EAwqCdaL4iH8+S99IZ4Z7gbmyrksQOCwNMZb9aItyLLGI8m89BOO3qDUBA9ycLxHH
	8clwiIqOUEGGfvCvuIuXlAOZZZcvCSRQ=
X-Google-Smtp-Source: AGHT+IGBVOnVtbgdw5UwzJjcgwdxE9Yg0GHPPW93V7Q/xtiO/R6+wPoefSj+W4n7vVmID0yAojCvM4ycA0U8kgzwk84=
X-Received: by 2002:a17:907:2d0c:b0:afe:7cb6:60f0 with SMTP id
 a640c23a62f3a-afe7cb66cb6mr609042766b.29.1756206876822; Tue, 26 Aug 2025
 04:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <635dc58dd4c7ae44264e488bb9b2ef7bd9dd5e21.1756201932.git.wqu@suse.com>
 <CAL3q7H7tF=PLROaKv6qu22T5W7bYxiD2h2uNKGceZCYCWCbnZg@mail.gmail.com>
In-Reply-To: <CAL3q7H7tF=PLROaKv6qu22T5W7bYxiD2h2uNKGceZCYCWCbnZg@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 26 Aug 2025 12:13:59 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7pqOgB=MHde=Av5QFTiLt5ZBx2X9wS-0LDdcG84kvFww@mail.gmail.com>
X-Gm-Features: Ac12FXzhvhQj7MU5hvSm1YGL8z7IJjNcwZQhcxXPyx_H0q_DyIiLzRcyLDtmFcM
Message-ID: <CAL3q7H7pqOgB=MHde=Av5QFTiLt5ZBx2X9wS-0LDdcG84kvFww@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: do more strict compressed read merge check
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 12:01=E2=80=AFPM Filipe Manana <fdmanana@kernel.org=
> wrote:
>
> On Tue, Aug 26, 2025 at 11:34=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >
> > [BUG]
> > With 64K page size (aarch64 with 64K page size config) and 4K btrfs
> > block size, the following workload can easily lead to a corrupted read:
> >
> >         mkfs.btrfs -f -s 4k $dev > /dev/null
> >         mount -o compress=3Dzstd $dev $mnt
> >         xfs_io -f -c "pwrite -S 0xff 0 64k" -c sync $mnt/base > /dev/nu=
ll
>
> You can remove the sync, it's unnecessary as the reflinks will sync
> the file. Leaving the sync is only distracting as it's not needed to trig=
ger
> the bug.
>
> Keeping things minimal without unnecessary steps makes them easier to
> understand and avoid any confusion.
>
> You can also remove -o compress=3Dzstd, and just leave -o compress, the
> compression algorithm is irrelevant.
>
> >         echo "correct result:"
> >         od -Ax -x $mnt/base
>
> od -A d -t x1 $mnt/base
>
> That will print the offsets in decimal, far easier to read and
> interpret rather than having to convert to decimal when reading...
>
>
> >         xfs_io -f -c "reflink $mnt/base 32k 0 32k" \
> >                   -c "reflink $mnt/base 0 32k 32k" \
> >                   -c "pwrite -S 0xff 60k 4k" $mnt/new > /dev/null
> >         echo "incorrect result:"
> >         od -Ax -x $mnt/new
> >         umount $mnt
> >
> > This shows the following result:
> >
> >   correct result:
> >   000000 ffff ffff ffff ffff ffff ffff ffff ffff
> >   *
> >   010000
> >   incorrect result:
> >   000000 ffff ffff ffff ffff ffff ffff ffff ffff
> >   *
> >   008000 0000 0000 0000 0000 0000 0000 0000 0000
>
> You see, reading 32768 is far easier to understand than reading
> 008000... Same goes for the other offsets in hexadecimal.
>
> >   *
> >   00f000 ffff ffff ffff ffff ffff ffff ffff ffff
> >   *
> >   010000
> >
> > Notice the zero in the range [0x8000, 0xf000), which is incorrect.
> >
> > [CAUSE]
> > With extra trace printk, it shows the following events during od:
> > (some unrelated info removed like CPU and context)
> >
> >  od-3457   btrfs_do_readpage: enter r/i=3D5/258 folio=3D0(65536) prev_e=
m_start=3D0000000000000000
> >
> > The "r/i" is indicating the root and inode number. In our case the file
> > "new" is using ino 258 from fs tree (root 5).
> >
> > Here notice the @prev_em_start pointer is NULL. This means the
> > btrfs_do_readpage() is called from btrfs_read_folio(), not from
> > btrfs_readahead().
> >
> >  od-3457   btrfs_do_readpage: r/i=3D5/258 folio=3D0(65536) cur=3D0 got =
em start=3D0 len=3D32768
> >  od-3457   btrfs_do_readpage: r/i=3D5/258 folio=3D0(65536) cur=3D4096 g=
ot em start=3D0 len=3D32768
> >  od-3457   btrfs_do_readpage: r/i=3D5/258 folio=3D0(65536) cur=3D8192 g=
ot em start=3D0 len=3D32768
> >  od-3457   btrfs_do_readpage: r/i=3D5/258 folio=3D0(65536) cur=3D12288 =
got em start=3D0 len=3D32768
> >  od-3457   btrfs_do_readpage: r/i=3D5/258 folio=3D0(65536) cur=3D16384 =
got em start=3D0 len=3D32768
> >  od-3457   btrfs_do_readpage: r/i=3D5/258 folio=3D0(65536) cur=3D20480 =
got em start=3D0 len=3D32768
> >  od-3457   btrfs_do_readpage: r/i=3D5/258 folio=3D0(65536) cur=3D24576 =
got em start=3D0 len=3D32768
> >  od-3457   btrfs_do_readpage: r/i=3D5/258 folio=3D0(65536) cur=3D28672 =
got em start=3D0 len=3D32768
> >
> > These above 32K blocks will be read from the the first half of the
>
> the the -> the
>
> > compressed data extent.
> >
> >  od-3457   btrfs_do_readpage: r/i=3D5/258 folio=3D0(65536) cur=3D32768 =
got em start=3D32768 len=3D32768
> >
> > Note here there is no btrfs_submit_compressed_read() call. Which is
> > incorrect now.
> > As both extent maps at 0 and 32K are pointing to the same compressed
> > data, their offset are different thus can not be merged into the same
>
> offset -> offsets
>
> > read.
> >
> > So this means the compressed data read merge check is doing something
> > wrong.
> >
> >  od-3457   btrfs_do_readpage: r/i=3D5/258 folio=3D0(65536) cur=3D36864 =
got em start=3D32768 len=3D32768
> >  od-3457   btrfs_do_readpage: r/i=3D5/258 folio=3D0(65536) cur=3D40960 =
got em start=3D32768 len=3D32768
> >  od-3457   btrfs_do_readpage: r/i=3D5/258 folio=3D0(65536) cur=3D45056 =
got em start=3D32768 len=3D32768
> >  od-3457   btrfs_do_readpage: r/i=3D5/258 folio=3D0(65536) cur=3D49152 =
got em start=3D32768 len=3D32768
> >  od-3457   btrfs_do_readpage: r/i=3D5/258 folio=3D0(65536) cur=3D53248 =
got em start=3D32768 len=3D32768
> >  od-3457   btrfs_do_readpage: r/i=3D5/258 folio=3D0(65536) cur=3D57344 =
got em start=3D32768 len=3D32768
> >  od-3457   btrfs_do_readpage: r/i=3D5/258 folio=3D0(65536) cur=3D61440 =
skip uptodate
> >  od-3457   btrfs_submit_compressed_read: cb orig_bio: file off=3D0 len=
=3D61440
> >
> > The function btrfs_submit_compressed_read() is only called at the end o=
f
> > folio read. The compressed bio will only have a extent map of range [0,
>
> a extent -> an extent
>
> > 32K), but the original bio passed in are for the whole 64K folio.
>
> are -> is
>
> >
> > This will cause the decompression part to only fill the first 32K,
> > leaving the rest untouched (aka, filled with zero).
> >
> > This incorrect compressed read merge leads to the above data corruption=
.
> >
> > There are similar problems happened in the past, commit 808f80b46790
>
> There were similar problems that happened in the past (...)
>
> > ("Btrfs: update fix for read corruption of compressed and shared
> > extents") is doing pretty much the same fix for readahead.
> >
> > But that's back to 2015, where btrfs still only supports bs (block size=
)
> > =3D=3D ps (page size) cases.
> > This means btrfs_do_readpage() only needs to handle a folio which
> > contains exactly one block.
> >
> > Only btrfs_readahead() can lead to a read covering multiple blocks.
> > Thus only btrfs_readahead() passes a non-NULL @prev_em_start pointer.
> >
> > With the v5.15 btrfs introduced bs < ps support. This breaks the above
> > assumption that a folio can only contain one block.
> >
> > Now btrfs_read_folio() can also read multiple blocks in one go.
> > But btrfs_read_folio() doesn't pass a @prev_em_start pointer, thus the
> > existing bio force submission check will never be triggered.
> >
> > In theory, this can also happen for btrfs with large folios, but since
> > large folio is still experimental, we don't need to bother it, thus onl=
y
> > bs < ps support is affected for now.
> >
> > [FIX]
> > Instead of passing @prev_em_start to do the proper compressed extent
> > check, introduce one new member, btrfs_bio_ctrl::last_em_start, so that
> > the existing bio force submission logic will always be triggered.
> >
> > CC: stable@vger.kernel.org #5.15+
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> > Changelog:
> > v3:
> > - Use a single btrfs_bio_ctrl::last_em_start
> >   Since the existing prev_em_start is using U64_MAX as the initial valu=
e
> >   to indicate no em hit yet, we can use the same logic, which saves
> >   another 8 bytes from btrfs_bio_ctrl.
> >
> > - Update the reproducer
> >   Previously I failed to reproduce using a minimal workload.
> >   As regular read from od/md5sum always trigger readahead thus not
> >   hitting the @prev_em_start =3D=3D NULL path.
> >
> >   Will send out a fstest case for it using the minimal reproducer.
> >   But it will still need a 16K/64K page sized system to reproduce.
> >
> >   Fix the problem by doing an block aligned write into the folio, so
> >   that the folio will be partially dirty and not go through the
> >   readahead path.
> >
> > - Update the analyze
> >   This includes the trace events of the minimal reproducer, and
> >   mentioning of previous similar fixes and why they do not work for
> >   subpage cases.
> >
> > - Update the CC tag
> >   Since it's only affecting bs < ps cases (for non-experimental builds)=
,
> >   only need to fix kernels with subpage btrfs supports.
> >
> > v2:
> > - Only save extent_map::start/len to save memory for btrfs_bio_ctrl
> >   It's using on-stack memory which is very limited inside the kernel.
> >
> > - Remove the commit message mentioning of clearing last saved em
> >   Since we're using em::start/len, there is no need to clear them.
> >   Either we hit the same em::start/len, meaning hitting the same extent
> >   map, or we hit a different em, which will have a different start/len.
> > ---
> >  fs/btrfs/extent_io.c | 40 ++++++++++++++++++++++++++++++----------
> >  1 file changed, 30 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 0c12fd64a1f3..b219dbaaedc8 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -131,6 +131,24 @@ struct btrfs_bio_ctrl {
> >          */
> >         unsigned long submit_bitmap;
> >         struct readahead_control *ractl;
> > +
> > +       /*
> > +        * The start file offset of the last hit extent map.
>
> A bit confusing, something more clear for example:  The start offset
> of the last used extent map by a read operation.
>
> > +        *
> > +        * This is for proper compressed read merge.
> > +        * U64_MAX means no extent map hit yet.
>
> That sounds a bit confusing too.
> Something clearer:  U64_MAX means we are starting the read and have
> made no progress yet.
>
> > +        *
> > +        * The current btrfs_bio_is_contig() only uses disk_bytenr as
> > +        * the condition to check if the read can be merged with previo=
us
> > +        * bio, which is not correct. E.g. two file extents pointing to=
 the
> > +        * same extent but with different offset.
> > +        *
> > +        * So here we need to do extra check to only merge reads that a=
re
>
> check -> checks
>
> This now looks much better than before and without duplicating code.
>
> With those small changes:
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

We should also get a better subject.
The current one doesn't really indicate we are fixing a bug.

Something like:

btrfs: fix corruption reading compressed range when block size is
smaller than page size

And don't forget to update the test case too with any new subject.

Thanks.

>
>
> > +        * covered by the same extent map.
> > +        * Just extent_map::start will be enough, as they are unique
> > +        * inside the same inode.
> > +        */
> > +       u64 last_em_start;
> >  };
> >
> >  /*
> > @@ -965,7 +983,7 @@ static void btrfs_readahead_expand(struct readahead=
_control *ractl,
> >   * return 0 on success, otherwise return error
> >   */
> >  static int btrfs_do_readpage(struct folio *folio, struct extent_map **=
em_cached,
> > -                     struct btrfs_bio_ctrl *bio_ctrl, u64 *prev_em_sta=
rt)
> > +                            struct btrfs_bio_ctrl *bio_ctrl)
> >  {
> >         struct inode *inode =3D folio->mapping->host;
> >         struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
> > @@ -1076,12 +1094,11 @@ static int btrfs_do_readpage(struct folio *foli=
o, struct extent_map **em_cached,
> >                  * non-optimal behavior (submitting 2 bios for the same=
 extent).
> >                  */
> >                 if (compress_type !=3D BTRFS_COMPRESS_NONE &&
> > -                   prev_em_start && *prev_em_start !=3D (u64)-1 &&
> > -                   *prev_em_start !=3D em->start)
> > +                   bio_ctrl->last_em_start !=3D U64_MAX &&
> > +                   bio_ctrl->last_em_start !=3D em->start)
> >                         force_bio_submit =3D true;
> >
> > -               if (prev_em_start)
> > -                       *prev_em_start =3D em->start;
> > +               bio_ctrl->last_em_start =3D em->start;
> >
> >                 em_gen =3D em->generation;
> >                 btrfs_free_extent_map(em);
> > @@ -1296,12 +1313,15 @@ int btrfs_read_folio(struct file *file, struct =
folio *folio)
> >         const u64 start =3D folio_pos(folio);
> >         const u64 end =3D start + folio_size(folio) - 1;
> >         struct extent_state *cached_state =3D NULL;
> > -       struct btrfs_bio_ctrl bio_ctrl =3D { .opf =3D REQ_OP_READ };
> > +       struct btrfs_bio_ctrl bio_ctrl =3D {
> > +               .opf =3D REQ_OP_READ,
> > +               .last_em_start =3D U64_MAX,
> > +       };
> >         struct extent_map *em_cached =3D NULL;
> >         int ret;
> >
> >         lock_extents_for_read(inode, start, end, &cached_state);
> > -       ret =3D btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
> > +       ret =3D btrfs_do_readpage(folio, &em_cached, &bio_ctrl);
> >         btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state)=
;
> >
> >         btrfs_free_extent_map(em_cached);
> > @@ -2641,7 +2661,8 @@ void btrfs_readahead(struct readahead_control *ra=
c)
> >  {
> >         struct btrfs_bio_ctrl bio_ctrl =3D {
> >                 .opf =3D REQ_OP_READ | REQ_RAHEAD,
> > -               .ractl =3D rac
> > +               .ractl =3D rac,
> > +               .last_em_start =3D U64_MAX,
> >         };
> >         struct folio *folio;
> >         struct btrfs_inode *inode =3D BTRFS_I(rac->mapping->host);
> > @@ -2649,12 +2670,11 @@ void btrfs_readahead(struct readahead_control *=
rac)
> >         const u64 end =3D start + readahead_length(rac) - 1;
> >         struct extent_state *cached_state =3D NULL;
> >         struct extent_map *em_cached =3D NULL;
> > -       u64 prev_em_start =3D (u64)-1;
> >
> >         lock_extents_for_read(inode, start, end, &cached_state);
> >
> >         while ((folio =3D readahead_folio(rac)) !=3D NULL)
> > -               btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_e=
m_start);
> > +               btrfs_do_readpage(folio, &em_cached, &bio_ctrl);
> >
> >         btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state)=
;
> >
> > --
> > 2.50.1
> >
> >

