Return-Path: <linux-btrfs+bounces-6501-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA1A9325CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 13:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D79DB22D0D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 11:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C731991D4;
	Tue, 16 Jul 2024 11:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQzJkjig"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2252B55897
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 11:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129824; cv=none; b=jxxhtKjCfi3u+/FJLRbvj8sDhhnAiEoNaaPPMtUDQuS/hSGpq5K4q/LJCGrhhVQIfdSlhuk91NOVLa5qUBJDuVsY9ZYSPUapnyD7VMo87udgf9cHoOECh6mBQr0gMzYZyFZZQqC5myvdxqttKW6V5+dGB1AmDkjkAGBmYylaWBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129824; c=relaxed/simple;
	bh=x3X3vFg0qS5+QRStwH2xxvqJ6pO7rX4kRZtp87NQwtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5XUtzUDP/44AQ9v5aTnPWQ7iXNaSRlMchMg77/aKvkqNZekX78WYIiF9Shorj05EI0SRGhe83W9P9boPlsFxpXYXd/tF4pDuzYcWcXxiUqbDbx8EixzlhViIimallAaZ95UnGZRKRmZxFCIZDuUFYFAMStbNid9iPPIbNaHJoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQzJkjig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5767C116B1
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 11:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721129823;
	bh=x3X3vFg0qS5+QRStwH2xxvqJ6pO7rX4kRZtp87NQwtg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nQzJkjigKzWD/oY5JSFiO/FRhpXQ2pVlR+32X1ATFKpMEtQcKYdlA2AimH8FSZxab
	 v+lJQcjTZVhmhvK73gth4NbtC6cjqt1dHAnCypBswCCfWr4vBrDo4O2TkQxywYOhmT
	 wW+Nzn8YQ+SVppkpAkwi2y3HZGowV6XJEIzXhEmZBCNEkZcDTOUJyhLE9/qOgaee0U
	 Hpxo72DMusoQEjR/R6yt3mR1BxEd+E1pcLfg/jWK6DXXTawSE0iEmp9dgVen6LDkUt
	 a1iERkya2SQa6YaGInJ0em84kl8oGD/Ebk+DWsMcPwGVVA5282cyWq8PiKU70J5K5n
	 LFQKmv9nmgfSw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77c080b521so575684766b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 04:37:03 -0700 (PDT)
X-Gm-Message-State: AOJu0YwqdP6YlBbJ/IpnvjrKYn5UYgpcj6QB23ClnYhXqX3eKn3toOlA
	W4o73uczsEie7VYH4xXrtKp0auu+nOe2OoCpfq6ciVVp+oh6OA0NC0xCbffieig5j9NtO25VUDa
	2XbqmjE926hVg3m8deOqxp+HD5Hs=
X-Google-Smtp-Source: AGHT+IEWi0PY5aGx0BXeM5j0ndLzMHNfpWN1ERLi3gCMlvTwPOmP1cuAWk/e1gg+hkOrAIyJo/KnLcrzfROOMdf6VoI=
X-Received: by 2002:a17:906:5293:b0:a79:7dc0:4fed with SMTP id
 a640c23a62f3a-a79ea461316mr122568666b.34.1721129822241; Tue, 16 Jul 2024
 04:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7e186f2d4892bf5bfa1a66dd859a38c981acf8ab.1721124786.git.fdmanana@suse.com>
 <e3161618-5e9f-477c-9708-3428136d1fce@gmx.com> <CAL3q7H7DWJm+X2G68dd0rgn94=jMKSKYw-3rzh_fjiMJZcgTgA@mail.gmail.com>
 <35ff514b-25c1-448a-a9cd-7b7b0b3709a1@gmx.com>
In-Reply-To: <35ff514b-25c1-448a-a9cd-7b7b0b3709a1@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 16 Jul 2024 12:36:25 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6cpVcy6D=HYGGjzqgfvSq1ri_OV6rpuU5R-XddejbJ-Q@mail.gmail.com>
Message-ID: <CAL3q7H6cpVcy6D=HYGGjzqgfvSq1ri_OV6rpuU5R-XddejbJ-Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix corrupt read due to bad offset of a compressed
 extent map
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 12:30=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/7/16 20:37, Filipe Manana =E5=86=99=E9=81=93:
> [...]
> >> However I'm not sure if the fixes tag is correct.
> >>
> >> The fix is changing the condition so that even for compressed extents =
we
> >> can properly update the offset
> >>
> >> However the condition line is not from that commit.
> >
> > No?
> >
> > That's the only commit that adds:
> >
> > em->offset +=3D start_diff;
> >
> > to add_extent_mapping(). How can it not be?
> > em->offset only exists after that patch.
>
> Before the introduction of em->offset, the old code is:
>
>         if (em->block_start < LAST_BYTE && !is_compressed) {
>                 em->block_start +=3D start_diff;
>                 em->block_len =3D em->len;
>         }
>
> @block_start is the disk_bytenr + offset for uncompressed extents, or
> just disk_bytenr for compressed extents.

But that's a different thing.
em->disk_bytenr should never be updated for a compressed extent, that
was correct.

>
> @block_len is the num_bytes for uncompressed extents, or just
> disk_num_bytes for compressed extents.
>
> So for the old kernel without em member update, compressed extents won't
> get any update at all, thus should still lead to the same problem.

And they shouldn't get any updates.
Because it's disk_bytenr - we have to read the whole compressed
extent, and then extract what we need from the decompressed data.

>
> Or did I miss something?

It seems so. Did you really authored the patchset? :)

If you still don't believe that commit is buggy (despite adding the
em->offset increment logic), then do the following:

1) Run for-next against the test case for fstests - it fails;

2) Checkout for-next into a commit before the patchset that changes
extent maps and run the test case for fstests - it will always pass.

>
> Thanks,
> Qu
>
> >
> >> The condition is there way before the change, just the em member clean=
up
> >> touched that line by removing the tailing '{' since eventually there i=
s
> >> only one line.
> >>
> >> So it looks like the problem exists way before that fixes tag.
> >
> > Nop.
> >
> > Try the test case for fstests on a branch without the extent map
> > patchset, and you'll see - it will pass, while with the patchset it
> > fails.
> >
> > The patchset had that problem I mentioned during review, that by
> > adding all members and then doing the switch in different patches
> > would make a bisection point to the switch patches.
> >
> >
> >
> >>
> >> Thanks,
> >> Qu
> >>
> >>>        return add_extent_mapping(inode, em, 0);
> >>>    }
> >>> diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/exten=
t-map-tests.c
> >>> index ebec4ab361b8..e4d019c8e8b9 100644
> >>> --- a/fs/btrfs/tests/extent-map-tests.c
> >>> +++ b/fs/btrfs/tests/extent-map-tests.c
> >>> @@ -900,6 +900,102 @@ static int test_case_7(struct btrfs_fs_info *fs=
_info, struct btrfs_inode *inode)
> >>>        return ret;
> >>>    }
> >>>
> >>> +/*
> >>> + * Test a regression for compressed extent map adjustment when we at=
tempt to
> >>> + * add an extent map that is partially ovarlapped by another existin=
g extent
> >>> + * map. The resulting extent map offset was left unchanged despite h=
aving
> >>> + * incremented its start offset.
> >>> + */
> >>> +static int test_case_8(struct btrfs_fs_info *fs_info, struct btrfs_i=
node *inode)
> >>> +{
> >>> +     struct extent_map_tree *em_tree =3D &inode->extent_tree;
> >>> +     struct extent_map *em;
> >>> +     int ret;
> >>> +     int ret2;
> >>> +
> >>> +     em =3D alloc_extent_map();
> >>> +     if (!em) {
> >>> +             test_std_err(TEST_ALLOC_EXTENT_MAP);
> >>> +             return -ENOMEM;
> >>> +     }
> >>> +
> >>> +     /* Compressed extent for the file range [120K, 128K). */
> >>> +     em->start =3D SZ_1K * 120;
> >>> +     em->len =3D SZ_8K;
> >>> +     em->disk_num_bytes =3D SZ_4K;
> >>> +     em->ram_bytes =3D SZ_8K;
> >>> +     em->flags |=3D EXTENT_FLAG_COMPRESS_ZLIB;
> >>> +     write_lock(&em_tree->lock);
> >>> +     ret =3D btrfs_add_extent_mapping(inode, &em, em->start, em->len=
);
> >>> +     write_unlock(&em_tree->lock);
> >>> +     free_extent_map(em);
> >>> +     if (ret < 0) {
> >>> +             test_err("couldn't add extent map for range [120K, 128K=
)");
> >>> +             goto out;
> >>> +     }
> >>> +
> >>> +     em =3D alloc_extent_map();
> >>> +     if (!em) {
> >>> +             test_std_err(TEST_ALLOC_EXTENT_MAP);
> >>> +             ret =3D -ENOMEM;
> >>> +             goto out;
> >>> +     }
> >>> +
> >>> +     /*
> >>> +      * Compressed extent for the file range [108K, 144K), which ove=
rlaps
> >>> +      * with the [120K, 128K) we previously inserted.
> >>> +      */
> >>> +     em->start =3D SZ_1K * 108;
> >>> +     em->len =3D SZ_1K * 36;
> >>> +     em->disk_num_bytes =3D SZ_4K;
> >>> +     em->ram_bytes =3D SZ_1K * 36;
> >>> +     em->flags |=3D EXTENT_FLAG_COMPRESS_ZLIB;
> >>> +
> >>> +     /*
> >>> +      * Try to add the extent map but with a search range of [140K, =
144K),
> >>> +      * this should succeed and adjust the extent map to the range
> >>> +      * [128K, 144K), with a length of 16K and an offset of 20K.
> >>> +      *
> >>> +      * This simulates a scenario where in the subvolume tree of an =
inode we
> >>> +      * have a compressed file extent item for the range [108K, 144K=
) and we
> >>> +      * have an overlapping compressed extent map for the range [120=
K, 128K),
> >>> +      * which was created by an encoded write, but its ordered exten=
t was not
> >>> +      * yet completed, so the subvolume tree doesn't have yet the fi=
le extent
> >>> +      * item for that range - we only have the extent map in the ino=
de's
> >>> +      * extent map tree.
> >>> +      */
> >>> +     write_lock(&em_tree->lock);
> >>> +     ret =3D btrfs_add_extent_mapping(inode, &em, SZ_1K * 140, SZ_4K=
);
> >>> +     write_unlock(&em_tree->lock);
> >>> +     free_extent_map(em);
> >>> +     if (ret < 0) {
> >>> +             test_err("couldn't add extent map for range [108K, 144K=
)");
> >>> +             goto out;
> >>> +     }
> >>> +
> >>> +     if (em->start !=3D SZ_128K) {
> >>> +             test_err("unexpected extent map start %llu (should be 1=
28K)", em->start);
> >>> +             ret =3D -EINVAL;
> >>> +             goto out;
> >>> +     }
> >>> +     if (em->len !=3D SZ_16K) {
> >>> +             test_err("unexpected extent map length %llu (should be =
16K)", em->len);
> >>> +             ret =3D -EINVAL;
> >>> +             goto out;
> >>> +     }
> >>> +     if (em->offset !=3D SZ_1K * 20) {
> >>> +             test_err("unexpected extent map offset %llu (should be =
20K)", em->offset);
> >>> +             ret =3D -EINVAL;
> >>> +             goto out;
> >>> +     }
> >>> +out:
> >>> +     ret2 =3D free_extent_map_tree(inode);
> >>> +     if (ret =3D=3D 0)
> >>> +             ret =3D ret2;
> >>> +
> >>> +     return ret;
> >>> +}
> >>> +
> >>>    struct rmap_test_vector {
> >>>        u64 raid_type;
> >>>        u64 physical_start;
> >>> @@ -1076,6 +1172,9 @@ int btrfs_test_extent_map(void)
> >>>        if (ret)
> >>>                goto out;
> >>>        ret =3D test_case_7(fs_info, BTRFS_I(inode));
> >>> +     if (ret)
> >>> +             goto out;
> >>> +     ret =3D test_case_8(fs_info, BTRFS_I(inode));
> >>>        if (ret)
> >>>                goto out;
> >>>

