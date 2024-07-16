Return-Path: <linux-btrfs+bounces-6497-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6825593249F
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 13:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B132854F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 11:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13A91990A5;
	Tue, 16 Jul 2024 11:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZsDnxBA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3801CFBE
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721128096; cv=none; b=AMgI6JaxTLJUF0QN+MbOOQw3a39IuboyxXiCPFpdffh0JZz6TPwL8UOVNryATyOP1dq7OCaWNpcK47/sSChMdyC1atzSyagDAyg91uNDvjtNGuREs7jEyabfS2wiKpavLNOOlRnYdtoaP5i/G07A8OwN/W1hSaOr4OIDUqZg+X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721128096; c=relaxed/simple;
	bh=qium5I+K+QlsOJQj7IVgacFv2WYIRYZ/DjFCn00IHNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c52eoXYtlgSNDEJ0PmaspKMIdmpSRbseiuDv/Ko4KxNBityIpZwi/lL6W44lfh08SfDgkuJsFrNaBmNN6YNgNqMQiLrLK/G0TNBzmN71zJOZbE/8bEYAQ3fo3XWZVVoc5feEzVB4U9S8sLvgilQp8rBxUHaCFG1s24Hu7csyh6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZsDnxBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78319C116B1
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 11:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721128096;
	bh=qium5I+K+QlsOJQj7IVgacFv2WYIRYZ/DjFCn00IHNU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hZsDnxBAP9u3E1uAEv3nld9YFiypgyUaSeClKNHRKzVnOPn9YgYqYxF4H9UNFOoED
	 sZ1aOPb4e3Tu0Mj5Qil4tKt8ChmAdfq1LQgBhSblm3RsLChh2iES937Rjl34H9NkE3
	 ZeZbZNTcP+i5SWvvB09XoCE/JOtPutp56nbiwOXsJvomGKsgl1/mc+SJKEGCyL35op
	 V8ePtU+lyrk/f01rfkyYfOK3PSdNTcsnr9iFMxcSkAridcizHlDqoy24nJ+wd6YTKN
	 SmypGOsv7A1NNj83odIo5HMLP2B27edkQpQV3TKdBV030v6z2X16ZCWhVnNi2PpWmi
	 oTRGkNF5Awt7A==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ea7bdde68so5810411e87.0
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 04:08:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YxzGk0sfvv7OQ/NioXHsADmdZGQbWbONsdpiPwx71XxQqH4sDnw
	qaI0g3Q5X6hLk7E1eHIb7/Dd0xQj8y3+mVHWmrJD07da+83N1W6pvjgQM5mXzoFrVj5z6CJKjOn
	KDfjpw2oTdr9cyKpO/LxHNIP/QGM=
X-Google-Smtp-Source: AGHT+IEV1wtIRUUpndoWBElRX4vVRbnY35X9k42sM2uFGkhO23T6+UXKqvgMV0AEYR5+OcbQFNpnyboQelFXuMFdvME=
X-Received: by 2002:a05:6512:3984:b0:52c:dd0c:4c57 with SMTP id
 2adb3069b0e04-52edf018ba8mr1094578e87.27.1721128094643; Tue, 16 Jul 2024
 04:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7e186f2d4892bf5bfa1a66dd859a38c981acf8ab.1721124786.git.fdmanana@suse.com>
 <e3161618-5e9f-477c-9708-3428136d1fce@gmx.com>
In-Reply-To: <e3161618-5e9f-477c-9708-3428136d1fce@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 16 Jul 2024 12:07:37 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7DWJm+X2G68dd0rgn94=jMKSKYw-3rzh_fjiMJZcgTgA@mail.gmail.com>
Message-ID: <CAL3q7H7DWJm+X2G68dd0rgn94=jMKSKYw-3rzh_fjiMJZcgTgA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix corrupt read due to bad offset of a compressed
 extent map
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 11:59=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/7/16 19:44, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > If we attempt to insert a compressed extent map that has a range that
> > overlaps another extent map we have in the inode's extent map tree, we
> > can end up with an incorrect offset after adjusting the new extent map =
at
> > merge_extent_mapping() because we don't update the extent map's offset.
> >
> > For example consider the following scenario:
> >
> > 1) We have a file extent item for a compressed extent covering the file
> >     range [108K, 144K) and currently there's no corresponding extent ma=
p
> >     in the inode's extent map tree;
> >
> > 2) The inode's size is 141K;
> >
> > 3) We have an encoded write (compressed) into the file range [120K, 128=
K),
> >     which overlaps the existing file extent item. The encoded write cre=
ates
> >     a matching extent map, add's it to the inode's extent map tree and
> >     creates an ordered extent for it.
> >
> >     Note that the corresponding file extent item is added to the subvol=
ume
> >     tree only when the ordered extent completes (when executing
> >     btrfs_finish_one_ordered());
> >
> > 4) We have a write into the file range [160K, 164K[.
> >
> >     This writes increases the i_size of the file, and there's a hole
> >     between the current i_size (141K) and the start offset of this writ=
e,
> >     and since the old i_size is in the middle of the block [140K, 144K)=
,
> >     we have to write zeroes to the range [141K, 144K) (3072 bytes) and
> >     therefore dirty that page.
> >
> >     We then call btrfs_set_extent_delalloc() with a start offset of 140=
K.
> >     We then end up at btrfs_find_new_delalloc_bytes() which will call
> >     btrfs_get_extent() for the range [140K, 144K);
> >
> > 5) The btrfs_get_extent() doesn't find any extent map in the inode's
> >     extent map tree covering the range [140K, 144K), so it searches the
> >     subvolume tree for any file extent items covering that range.
> >
> >     There it finds the file extent item for the range [108K, 144K),
> >     creates a compressed extent map for that range and then calls
> >     btrfs_add_extent_mapping() with that extent map and passes the
> >     range [140K, 144K) via the "start" and "len" parameters;
> >
> > 6) The call to add_extent_mapping() done by btrfs_add_extent_mapping()
> >     fails with -EEXIST because there's an extent map, created at step 2
> >     for the [120K, 128K) range, that covers that overlaps with the rang=
e
> >     of the given extent map ([108K, 144K)).
> >
> >     Then it does a lookup for extent map from step 2 add calls
> >     merge_extent_mapping() to adjust the input extent map ([108K, 144K)=
).
> >     That adjust the extent map to a start offset of 128K and a length
> >     of 16K (starting just after the extent map from step 2), but it doe=
s
> >     not update the offset field of the extent map, leaving it with a va=
lue
> >     of zero instead of updating to a value of 20K (128K - 108K =3D 20K)=
.
> >
> >     As a result any read for the range [128K, 144K) can return
> >     incorrect data since we read from a wrong section of the extent (un=
less
> >     both the correct and incorrect ranges happen to have the same data)=
.
> >
> > So fix this by changing merge_extent_mapping() to update the extent map=
's
> > offset even if it's compressed. Also add a test case to the self tests.
> >
> > A test case for fstests that triggered this problem using send/receive
> > with compressed writes will be added soon.
> >
> > Fixes: 3d2ac9922465 ("btrfs: introduce new members for extent_map")
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
>
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/extent_map.c             |  2 +-
> >   fs/btrfs/tests/extent-map-tests.c | 99 ++++++++++++++++++++++++++++++=
+
> >   2 files changed, 100 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> > index bacb76952fc4..f85f0172b58b 100644
> > --- a/fs/btrfs/extent_map.c
> > +++ b/fs/btrfs/extent_map.c
> > @@ -664,7 +664,7 @@ static noinline int merge_extent_mapping(struct btr=
fs_inode *inode,
> >       start_diff =3D start - em->start;
> >       em->start =3D start;
> >       em->len =3D end - start;
> > -     if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE && !extent_map_is_comp=
ressed(em))
> > +     if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
> >               em->offset +=3D start_diff;
>
> However I'm not sure if the fixes tag is correct.
>
> The fix is changing the condition so that even for compressed extents we
> can properly update the offset
>
> However the condition line is not from that commit.

No?

That's the only commit that adds:

em->offset +=3D start_diff;

to add_extent_mapping(). How can it not be?
em->offset only exists after that patch.

> The condition is there way before the change, just the em member cleanup
> touched that line by removing the tailing '{' since eventually there is
> only one line.
>
> So it looks like the problem exists way before that fixes tag.

Nop.

Try the test case for fstests on a branch without the extent map
patchset, and you'll see - it will pass, while with the patchset it
fails.

The patchset had that problem I mentioned during review, that by
adding all members and then doing the switch in different patches
would make a bisection point to the switch patches.



>
> Thanks,
> Qu
>
> >       return add_extent_mapping(inode, em, 0);
> >   }
> > diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-=
map-tests.c
> > index ebec4ab361b8..e4d019c8e8b9 100644
> > --- a/fs/btrfs/tests/extent-map-tests.c
> > +++ b/fs/btrfs/tests/extent-map-tests.c
> > @@ -900,6 +900,102 @@ static int test_case_7(struct btrfs_fs_info *fs_i=
nfo, struct btrfs_inode *inode)
> >       return ret;
> >   }
> >
> > +/*
> > + * Test a regression for compressed extent map adjustment when we atte=
mpt to
> > + * add an extent map that is partially ovarlapped by another existing =
extent
> > + * map. The resulting extent map offset was left unchanged despite hav=
ing
> > + * incremented its start offset.
> > + */
> > +static int test_case_8(struct btrfs_fs_info *fs_info, struct btrfs_ino=
de *inode)
> > +{
> > +     struct extent_map_tree *em_tree =3D &inode->extent_tree;
> > +     struct extent_map *em;
> > +     int ret;
> > +     int ret2;
> > +
> > +     em =3D alloc_extent_map();
> > +     if (!em) {
> > +             test_std_err(TEST_ALLOC_EXTENT_MAP);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     /* Compressed extent for the file range [120K, 128K). */
> > +     em->start =3D SZ_1K * 120;
> > +     em->len =3D SZ_8K;
> > +     em->disk_num_bytes =3D SZ_4K;
> > +     em->ram_bytes =3D SZ_8K;
> > +     em->flags |=3D EXTENT_FLAG_COMPRESS_ZLIB;
> > +     write_lock(&em_tree->lock);
> > +     ret =3D btrfs_add_extent_mapping(inode, &em, em->start, em->len);
> > +     write_unlock(&em_tree->lock);
> > +     free_extent_map(em);
> > +     if (ret < 0) {
> > +             test_err("couldn't add extent map for range [120K, 128K)"=
);
> > +             goto out;
> > +     }
> > +
> > +     em =3D alloc_extent_map();
> > +     if (!em) {
> > +             test_std_err(TEST_ALLOC_EXTENT_MAP);
> > +             ret =3D -ENOMEM;
> > +             goto out;
> > +     }
> > +
> > +     /*
> > +      * Compressed extent for the file range [108K, 144K), which overl=
aps
> > +      * with the [120K, 128K) we previously inserted.
> > +      */
> > +     em->start =3D SZ_1K * 108;
> > +     em->len =3D SZ_1K * 36;
> > +     em->disk_num_bytes =3D SZ_4K;
> > +     em->ram_bytes =3D SZ_1K * 36;
> > +     em->flags |=3D EXTENT_FLAG_COMPRESS_ZLIB;
> > +
> > +     /*
> > +      * Try to add the extent map but with a search range of [140K, 14=
4K),
> > +      * this should succeed and adjust the extent map to the range
> > +      * [128K, 144K), with a length of 16K and an offset of 20K.
> > +      *
> > +      * This simulates a scenario where in the subvolume tree of an in=
ode we
> > +      * have a compressed file extent item for the range [108K, 144K) =
and we
> > +      * have an overlapping compressed extent map for the range [120K,=
 128K),
> > +      * which was created by an encoded write, but its ordered extent =
was not
> > +      * yet completed, so the subvolume tree doesn't have yet the file=
 extent
> > +      * item for that range - we only have the extent map in the inode=
's
> > +      * extent map tree.
> > +      */
> > +     write_lock(&em_tree->lock);
> > +     ret =3D btrfs_add_extent_mapping(inode, &em, SZ_1K * 140, SZ_4K);
> > +     write_unlock(&em_tree->lock);
> > +     free_extent_map(em);
> > +     if (ret < 0) {
> > +             test_err("couldn't add extent map for range [108K, 144K)"=
);
> > +             goto out;
> > +     }
> > +
> > +     if (em->start !=3D SZ_128K) {
> > +             test_err("unexpected extent map start %llu (should be 128=
K)", em->start);
> > +             ret =3D -EINVAL;
> > +             goto out;
> > +     }
> > +     if (em->len !=3D SZ_16K) {
> > +             test_err("unexpected extent map length %llu (should be 16=
K)", em->len);
> > +             ret =3D -EINVAL;
> > +             goto out;
> > +     }
> > +     if (em->offset !=3D SZ_1K * 20) {
> > +             test_err("unexpected extent map offset %llu (should be 20=
K)", em->offset);
> > +             ret =3D -EINVAL;
> > +             goto out;
> > +     }
> > +out:
> > +     ret2 =3D free_extent_map_tree(inode);
> > +     if (ret =3D=3D 0)
> > +             ret =3D ret2;
> > +
> > +     return ret;
> > +}
> > +
> >   struct rmap_test_vector {
> >       u64 raid_type;
> >       u64 physical_start;
> > @@ -1076,6 +1172,9 @@ int btrfs_test_extent_map(void)
> >       if (ret)
> >               goto out;
> >       ret =3D test_case_7(fs_info, BTRFS_I(inode));
> > +     if (ret)
> > +             goto out;
> > +     ret =3D test_case_8(fs_info, BTRFS_I(inode));
> >       if (ret)
> >               goto out;
> >

