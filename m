Return-Path: <linux-btrfs+bounces-4186-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF73D8A2F4F
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 15:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 875E3B22F46
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 13:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D12882484;
	Fri, 12 Apr 2024 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKyg2Q60"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3729773184
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 13:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928133; cv=none; b=qK2eg0hPP8V5TLYQWnTpfG/R/fTCjkZM3gv4YWbZeC+8Q3bi3J0E4Jq5OiYk1S40A3fZUIiBm2ipVD+E4RCpwh2xz3R4Q3geICL7JS5dhHuO7Rs/2AvT0l7MFxazejasPiIlWU2+fuZwO8XWHIezwkw2YGlXIhor9n5sfa1kI6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928133; c=relaxed/simple;
	bh=W3gObKb1HKu+NCjxr0nS7ZOHn4MXuNjMKufm9vAXBpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gs9gTFuMwyK2qSkIXd2HPwfYFHFfnB3u9ZmQ6Iidg8t4qC6kzns3q57wTliP9hx7NWZTLuu1yZ1ctuS7EzweEsC6D4R0RhROz4ebiAnda4pTQz78Ax1SBJS1rysGvvOAYdmS99gQtgYwdMRfjApo+jCGSQ+5gbHkznfDg/K+UG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKyg2Q60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1045C2BD11
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 13:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712928132;
	bh=W3gObKb1HKu+NCjxr0nS7ZOHn4MXuNjMKufm9vAXBpw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IKyg2Q60onmXyJyKrwmvTEnxWwicCKVDfAeBlaOCiyOzDTQTH5NLnyoEsLRWFUP5/
	 jI1Px5O6DVzTom+0CxqYI/QQXqUmbF+v9VySRZbPWuIaAL8OLd+GUr4kzoq/Dodx2u
	 ARK7oTSmII9ykPxnvK51TlVWhsWD38k+TwI1ZJ5kJ5vzguV0XoBK8ug5TRztD6iM0w
	 uGXM/DteqbQWTzmOUp7O+vecM0Nr+ifc+2O2EkxpnJYiS3FlBdvqYH9ogumJi7MGZn
	 4Y4OYa/uK/QgrFJoLZTGNHGtNOtNQi0nbAweoGJFFyMulZj59PL3Zvx0M62VuiBq78
	 FFJYwzez1JLLw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516cdb21b34so1135155e87.1
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 06:22:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxiPO+pJo4CfdTHFl8PZGARoNZr50hsI5Xqb6Nw0FxxFLmhhW4roevEl11C15lisUgj5X2GmgKEk4GpYRQwAff9xivR25S2ojK2Tc=
X-Gm-Message-State: AOJu0Yz/T+mHAwhG015+CAZJXBIqqLSh6wIwJsgK//rc8H7ka8vaWMTn
	j+NkWi4kH81i5gufw1ybXJNUfO+i6qS9TSB7nLf/hmxCZ/RKtvFWB7iRAxSs1YXNQT8mXvivxsU
	110WnfXz/WPfmOArghYirp/rTnhQ=
X-Google-Smtp-Source: AGHT+IEkALhpHPmDNK/DyQIbIXsco+M+g2+elRXXDf1FiVY1mzsHqRZfkgT92YjjgtxQ0zBpwJ9wsb1Jx80NdO+1S7I=
X-Received: by 2002:ac2:5324:0:b0:513:e642:e7f0 with SMTP id
 f4-20020ac25324000000b00513e642e7f0mr1564622lfh.54.1712928130954; Fri, 12 Apr
 2024 06:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712614770.git.wqu@suse.com> <5780c450b3b5a642773bf3981bcfd49d1a6080b0.1712614770.git.wqu@suse.com>
 <CAL3q7H77oYtaf4_M3mWYsdSucwi-gTu+wgpEsJhft1vQjwajig@mail.gmail.com> <65a7c2b6-9700-4d52-bd5e-9bfc2e32327d@gmx.com>
In-Reply-To: <65a7c2b6-9700-4d52-bd5e-9bfc2e32327d@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 12 Apr 2024 14:21:33 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7U087v0t3N_fpdsqCBXJGm9dr5oFft5m6jaGEhS1b=5w@mail.gmail.com>
Message-ID: <CAL3q7H7U087v0t3N_fpdsqCBXJGm9dr5oFft5m6jaGEhS1b=5w@mail.gmail.com>
Subject: Re: [PATCH RFC 2/8] btrfs: rename members of can_nocow_file_extent_args
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 11:03=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/4/12 00:16, Filipe Manana =E5=86=99=E9=81=93:
> > On Mon, Apr 8, 2024 at 11:34=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> The structure can_nocow_file_extent_args is utilized to provide the
> >> needed info for a NOCOW writes.
> >>
> >> However some of its members are pretty confusing.
> >> For example, @disk_bytenr is not btrfs_file_extent_item::disk_bytenr,
> >> but with extra offset, thus it works more like extent_map::block_start=
.
> >>
> >> This patch would:
> >>
> >> - Rename members directly fetched from btrfs_file_extent_item
> >>    The new name would have "orig_" prefix, with the same member name f=
rom
> >>    btrfs_file_extent_item.
> >>
> >> - For the old @disk_bytenr, rename it to @block_start
> >>    As it's directly passed into create_io_em() as @block_start.
> >
> > So I find these new names more confusing actually.
> >
> > So the existing names reflect fields from struct
> > btrfs_file_extent_item, because NOCOW checks are always done against
> > the range of a file extent item, therefore the existing naming.
>
> It's true for @extent_offset, but @disk_bytenr is not the case.
>
> It's calculated by file_extent_item::disk_bytenr + file_extent_item::offs=
et.
>
> That's why I find the old @disk_bytenr very confusing (and caused
> several crashes in my sanity checks).
>
> >
> > Sometimes it may be against the whole range of the extent item,
> > sometimes only a part of it, in which case disk_bytenr is incremented
> > by offsets.
> >
> > This is the same logic with struct btrfs_ordered_extent: for a NOCOW
> > write disk_bytenr may either match the disk_bytenr of an existing file
> > extent item or it's adjusted by some offset in case it covers only
> > part of the extent item.
>
> The NOCOW ordered extent would skip the file extent map updates, that's
> why it doesn't really need an super accurate disk_bytenr/disk_num_bytes
> to match data extents.
>
> >
> > So currently we are both consistent with btrfs_ordered_extent besides
> > the fact the NOCOW checks are done against a file extent item.
> >
> > I particularly find block_start not intuitive - block? Is it a block
> > number? What's the size of the block? Etc.
> > disk_bytenr is a lot more clear - it's a disk address in bytes.
>
> Well, the new @block_start matches the old extent_map::block_start.

So it becomes a single exception, different from everywhere else.
Doesn't seem like a good thing in general.

>
> I have to say, we do not have a solid definition on "disk_bytenr" in the
> first place.

Well I find the name clear, it is a disk location measured by a byte addres=
s.
block_start is not so clear for anyone not familiar with btrfs'
internals, it makes me think of a block number and wonder what's the
block size, etc.

>
> Should it always match ondisk file_extent_item::disk_bytenr, or should
> it act like "block_start" of the old extent_map?

It's always about a range of a file extent item, be it the whole range
or just a part of it.
I don't see why it's confusing to use disk_bytenr, etc.
I find it more confusing to use something else, or at least what's
being proposed in this patch.

>
> And if we have separate definitions, one to always match file extent
> item disk_bytenr, and one to match the real IO start bytenr, what should
> be their names?
>
> I hope we can get a good naming to solve the confusion, any good idea?

For me the current naming is fine and I don't find it confusing... So,
I'm not sure what to tell you.

>
> Thanks,
> Qu
> >
> >>
> >> - Add extra comments explaining those members
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/inode.c | 51 ++++++++++++++++++++++++++++------------------=
--
> >>   1 file changed, 30 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> >> index 2e0156943c7c..4d207c3b38d9 100644
> >> --- a/fs/btrfs/inode.c
> >> +++ b/fs/btrfs/inode.c
> >> @@ -1847,11 +1847,20 @@ struct can_nocow_file_extent_args {
> >>           */
> >>          bool free_path;
> >>
> >> -       /* Output fields. Only set when can_nocow_file_extent() return=
s 1. */
> >> +       /*
> >> +        * Output fields. Only set when can_nocow_file_extent() return=
s 1.
> >> +        *
> >> +        * @block_start:        The bytenr of the new nocow write shou=
ld be at.
> >> +        * @orig_disk_bytenr:   The original data extent's disk_bytenr=
.
> >
> > This orig_disk_bytenr field is not defined anywhere in this patch.
> >
> > Thanks.
> >
> >> +        * @orig_disk_num_bytes:The original data extent's disk_num_by=
tes.
> >> +        * @orig_offset:        The original offset inside the old dat=
a extent.
> >> +        *                      Caller should calculate their own
> >> +        *                      btrfs_file_extent_item::offset base on=
 this.
> >> +        */
> >>
> >> -       u64 disk_bytenr;
> >> -       u64 disk_num_bytes;
> >> -       u64 extent_offset;
> >> +       u64 block_start;
> >> +       u64 orig_disk_num_bytes;
> >> +       u64 orig_offset;
> >>          /* Number of bytes that can be written to in NOCOW mode. */
> >>          u64 num_bytes;
> >>   };
> >> @@ -1887,9 +1896,9 @@ static int can_nocow_file_extent(struct btrfs_pa=
th *path,
> >>                  goto out;
> >>
> >>          /* Can't access these fields unless we know it's not an inlin=
e extent. */
> >> -       args->disk_bytenr =3D btrfs_file_extent_disk_bytenr(leaf, fi);
> >> -       args->disk_num_bytes =3D btrfs_file_extent_disk_num_bytes(leaf=
, fi);
> >> -       args->extent_offset =3D btrfs_file_extent_offset(leaf, fi);
> >> +       args->block_start =3D btrfs_file_extent_disk_bytenr(leaf, fi);
> >> +       args->orig_disk_num_bytes =3D btrfs_file_extent_disk_num_bytes=
(leaf, fi);
> >> +       args->orig_offset =3D btrfs_file_extent_offset(leaf, fi);
> >>
> >>          if (!(inode->flags & BTRFS_INODE_NODATACOW) &&
> >>              extent_type =3D=3D BTRFS_FILE_EXTENT_REG)
> >> @@ -1906,7 +1915,7 @@ static int can_nocow_file_extent(struct btrfs_pa=
th *path,
> >>                  goto out;
> >>
> >>          /* An explicit hole, must COW. */
> >> -       if (args->disk_bytenr =3D=3D 0)
> >> +       if (args->block_start =3D=3D 0)
> >>                  goto out;
> >>
> >>          /* Compressed/encrypted/encoded extents must be COWed. */
> >> @@ -1925,8 +1934,8 @@ static int can_nocow_file_extent(struct btrfs_pa=
th *path,
> >>          btrfs_release_path(path);
> >>
> >>          ret =3D btrfs_cross_ref_exist(root, btrfs_ino(inode),
> >> -                                   key->offset - args->extent_offset,
> >> -                                   args->disk_bytenr, args->strict, p=
ath);
> >> +                                   key->offset - args->orig_offset,
> >> +                                   args->block_start, args->strict, p=
ath);
> >>          WARN_ON_ONCE(ret > 0 && is_freespace_inode);
> >>          if (ret !=3D 0)
> >>                  goto out;
> >> @@ -1947,15 +1956,15 @@ static int can_nocow_file_extent(struct btrfs_=
path *path,
> >>              atomic_read(&root->snapshot_force_cow))
> >>                  goto out;
> >>
> >> -       args->disk_bytenr +=3D args->extent_offset;
> >> -       args->disk_bytenr +=3D args->start - key->offset;
> >> +       args->block_start +=3D args->orig_offset;
> >> +       args->block_start +=3D args->start - key->offset;
> >>          args->num_bytes =3D min(args->end + 1, extent_end) - args->st=
art;
> >>
> >>          /*
> >>           * Force COW if csums exist in the range. This ensures that c=
sums for a
> >>           * given extent are either valid or do not exist.
> >>           */
> >> -       ret =3D csum_exist_in_range(root->fs_info, args->disk_bytenr, =
args->num_bytes,
> >> +       ret =3D csum_exist_in_range(root->fs_info, args->block_start, =
args->num_bytes,
> >>                                    nowait);
> >>          WARN_ON_ONCE(ret > 0 && is_freespace_inode);
> >>          if (ret !=3D 0)
> >> @@ -2112,7 +2121,7 @@ static noinline int run_delalloc_nocow(struct bt=
rfs_inode *inode,
> >>                          goto must_cow;
> >>
> >>                  ret =3D 0;
> >> -               nocow_bg =3D btrfs_inc_nocow_writers(fs_info, nocow_ar=
gs.disk_bytenr);
> >> +               nocow_bg =3D btrfs_inc_nocow_writers(fs_info, nocow_ar=
gs.block_start);
> >>                  if (!nocow_bg) {
> >>   must_cow:
> >>                          /*
> >> @@ -2151,14 +2160,14 @@ static noinline int run_delalloc_nocow(struct =
btrfs_inode *inode,
> >>                  nocow_end =3D cur_offset + nocow_args.num_bytes - 1;
> >>                  is_prealloc =3D extent_type =3D=3D BTRFS_FILE_EXTENT_=
PREALLOC;
> >>                  if (is_prealloc) {
> >> -                       u64 orig_start =3D found_key.offset - nocow_ar=
gs.extent_offset;
> >> +                       u64 orig_start =3D found_key.offset - nocow_ar=
gs.orig_offset;
> >>                          struct extent_map *em;
> >>
> >>                          em =3D create_io_em(inode, cur_offset, nocow_=
args.num_bytes,
> >>                                            orig_start,
> >> -                                         nocow_args.disk_bytenr, /* b=
lock_start */
> >> +                                         nocow_args.block_start, /* b=
lock_start */
> >>                                            nocow_args.num_bytes, /* bl=
ock_len */
> >> -                                         nocow_args.disk_num_bytes, /=
* orig_block_len */
> >> +                                         nocow_args.orig_disk_num_byt=
es, /* orig_block_len */
> >>                                            ram_bytes, BTRFS_COMPRESS_N=
ONE,
> >>                                            BTRFS_ORDERED_PREALLOC);
> >>                          if (IS_ERR(em)) {
> >> @@ -2171,7 +2180,7 @@ static noinline int run_delalloc_nocow(struct bt=
rfs_inode *inode,
> >>
> >>                  ordered =3D btrfs_alloc_ordered_extent(inode, cur_off=
set,
> >>                                  nocow_args.num_bytes, nocow_args.num_=
bytes,
> >> -                               nocow_args.disk_bytenr, nocow_args.num=
_bytes, 0,
> >> +                               nocow_args.block_start, nocow_args.num=
_bytes, 0,
> >>                                  is_prealloc
> >>                                  ? (1 << BTRFS_ORDERED_PREALLOC)
> >>                                  : (1 << BTRFS_ORDERED_NOCOW),
> >> @@ -7189,7 +7198,7 @@ noinline int can_nocow_extent(struct inode *inod=
e, u64 offset, u64 *len,
> >>          }
> >>
> >>          ret =3D 0;
> >> -       if (btrfs_extent_readonly(fs_info, nocow_args.disk_bytenr))
> >> +       if (btrfs_extent_readonly(fs_info, nocow_args.block_start))
> >>                  goto out;
> >>
> >>          if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW) &&
> >> @@ -7206,9 +7215,9 @@ noinline int can_nocow_extent(struct inode *inod=
e, u64 offset, u64 *len,
> >>          }
> >>
> >>          if (orig_start)
> >> -               *orig_start =3D key.offset - nocow_args.extent_offset;
> >> +               *orig_start =3D key.offset - nocow_args.orig_offset;
> >>          if (orig_block_len)
> >> -               *orig_block_len =3D nocow_args.disk_num_bytes;
> >> +               *orig_block_len =3D nocow_args.orig_disk_num_bytes;
> >>
> >>          *len =3D nocow_args.num_bytes;
> >>          ret =3D 1;
> >> --
> >> 2.44.0
> >>
> >>
> >

