Return-Path: <linux-btrfs+bounces-13637-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDC0AA7958
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 20:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0ABD7B8A93
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 18:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC5E267733;
	Fri,  2 May 2025 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEXqBUOR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5BA25DD09
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746211175; cv=none; b=CISNO8rt86xn78zjr5D5mDEV7KVIjBTd2elMFNugx6ov/48H2FLcMx5MHDa8LKTEC1YjUwtJPk4bV009niEsuzyDQfvLugBLB+LqPz4hlgpnilSNnUOu5D1XDCsQ98H2X2NMzw8yw1RUCtGdIwRycv7zD9k8MfKjvnz8mrwOTRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746211175; c=relaxed/simple;
	bh=pHowMNBv9U3Ix4w6SbvlbZo6hyPKetr+OPvwITGEzjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syPlHWmtlDIgNQD/MZxnMr6u6VgKkNR0AA51xkdhjckgkXb1lmqfY4aZvdsKTXnFBqn1Zpc+mUZrl6Ht/Bis2VHuqA6r3FtPNI/ZhkDE+BAPiFc6+7fnrYoSqiugAb+W0qvzEYEdE9Y003fUvmsNnD97HlIlhnaxeVJjaw0Zq+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEXqBUOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB70C4CEED
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 18:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746211175;
	bh=pHowMNBv9U3Ix4w6SbvlbZo6hyPKetr+OPvwITGEzjo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DEXqBUORhxSPE8zTkbzQwSYqOtqGcjplDz2+TZvdx9MkULVu774ee/Gz4p+nAKTSk
	 TW90QUYohhuCGrpchbMCYEfQXkyVWf+en1WNoMLAGz9t9Diu3B87bkk3NndthmbOjZ
	 YQlXJL41RPHx+RmYC/IbRgLHZ0VeP+hG0RAaVb/T1RKa4YedAFrb5o7FMXTLRLGUBf
	 A60/OskoZdlcBW8z7xivgTsLkjgtqnS+QgTiGAbUhMATh2FzQJAarRE7cCnh6R41P+
	 mE93smgzwB8LOX/cuzwv+8unpxBftdQPD153Qj0W2BmlnzYUqYJio/eOIHKXLu1vnI
	 wj8yLo0/gvC8Q==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso434073766b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 02 May 2025 11:39:35 -0700 (PDT)
X-Gm-Message-State: AOJu0YxrzlquFfExI7JcnYmfg6Ltwa+WEuP+KdMyBScnZ4mhh8ZKOhtD
	m4fOJrSwuhmmp2tQaZ4P/XyLxoim3hsZkwhYxHxe969LqwW3ED2/g/LvXWE96hceYpN2zyx/Evl
	ceQ2hSn2TbvUpPUIeJcVRb/ELFtY=
X-Google-Smtp-Source: AGHT+IGWlw1EBmCm54gPLUYrlZKAophVDxevFbo1PqWmLaLyvSylnzNO5JJYrTJwd3lk2rA6h+6etfeuBAFxZFOKHdE=
X-Received: by 2002:a17:907:c04:b0:ac3:bd68:24f0 with SMTP id
 a640c23a62f3a-ad17b470a90mr416650766b.7.1746211173674; Fri, 02 May 2025
 11:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4dbd03928f8384d926aff5754199c5078fc915cb.1746194979.git.fdmanana@suse.com>
 <20250502172323.GA1179844@zen.localdomain>
In-Reply-To: <20250502172323.GA1179844@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 2 May 2025 19:38:56 +0100
X-Gmail-Original-Message-ID: <CAL3q7H64KNfnQy2tJgqY5nhoSbB3X_Y50iGBLaLqerpRwjFpeA@mail.gmail.com>
X-Gm-Features: ATxdqUFZV_sE6SB1uDFWICIKFtVE4zZkg1JcpAO6qsb_Ky-Qfq7gu-66n_xtRuw
Message-ID: <CAL3q7H64KNfnQy2tJgqY5nhoSbB3X_Y50iGBLaLqerpRwjFpeA@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: check: fix false alert on missing csum for hole
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 6:22=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Fri, May 02, 2025 at 03:32:52PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > If we log a hole, fsync a file, partially write to the front of the hol=
e
> > and then fsync again the file, we end up with a file extent item in the
> > log tree that represents a hole and has a disk address of 0 and an offs=
et
> > that is greater than zero (since we trimmed the front part of the range=
 to
> > accomodate for a file extent item of the new write).
>
> I ran into this last week and reached the same conclusion about the fix,
> but wasn't sure I understood how the items were created so was still
> debugging. Thanks for explaining it.
>
> I did notice that we have a CONFIG_BTRFS_DEBUG gated check for non-zero
> offsets in a hole in extent_map (in validate_extent_map()).
>
> I wasn't able to hit that while reproducing this issue but was curious if
> you think that check is valid?

It's ok, because when splitting a hole extent map we always set
->offset to 0, see btrfs_drop_extent_map_range().

And when loading one based on a file extent item that has a non-zero
offset, we always leave the extent map's ->offset as 0 too.

So we should never find an extent map for a hole with a non-zero ->offset.

>
> Regardless of that bit, thanks for the fix. You can add:
>
> Reviewed-by: Boris Burkov <boris@bur.io>
>
> >
> > When this happens 'btrfs check' incorrectly reports that a csum is miss=
ing
> > like this:
> >
> >   $ btrfs check /dev/sdc
> >   Opening filesystem to check...
> >   Checking filesystem on /dev/sdc
> >   UUID: 46a85f62-4b6e-4aab-bfdc-f08d1bae9e08
> >   [1/8] checking log
> >   ERROR: csum missing in log (root 5 inode 262 offset 5959680 address 0=
x5a000 length 1347584)
> >   ERROR: errors found in log
> >   [2/8] checking root items
> >   (...)
> >
> > And in the log tree, the corresponding file extent item:
> >
> >   $ btrfs inspect-internal dump-tree /dev/sdc
> >   (...)
> >         item 38 key (262 EXTENT_DATA 5959680) itemoff 1796 itemsize 53
> >                 generation 11 type 1 (regular)
> >                 extent data disk byte 0 nr 0
> >                 extent data offset 368640 nr 1347584 ram 1716224
> >                 extent compression 0 (none)
> >   (...)
> >
> > This false alert happens because we sum the file extent item's offset t=
o
> > its logical address before we attempt to skip holes at
> > check_range_csummed(), so we end up passing a non-zero logical address =
to
> > that function (0 + 368640), which will attempt to find a csum for that
> > invalid address and fail.
> >
> > This type of error can be sporadically triggered by several test cases
> > from fstests such as btrfs/192 for example.
> >
> > Fix this by skipping csum search if the file extent item's logical disk
> > address is 0 before summing the offset.
> >
> > Fixes: 88dc309aca10 ("btrfs-progs: check: explicit holes in log tree do=
n't get csummed")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  check/main.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/check/main.c b/check/main.c
> > index 6290c6d4..bf250c41 100644
> > --- a/check/main.c
> > +++ b/check/main.c
> > @@ -9694,10 +9694,6 @@ static int check_range_csummed(struct btrfs_root=
 *root, u64 addr, u64 length)
> >       u64 data_len;
> >       int ret;
> >
> > -     /* Explicit holes don't get csummed */
> > -     if (addr =3D=3D 0)
> > -             return 0;
> > -
> >       ret =3D btrfs_search_slot(NULL, root, &key, &path, 0, 0);
> >       if (ret < 0)
> >               return ret;
> > @@ -9807,12 +9803,15 @@ static int check_log_root(struct btrfs_root *ro=
ot, struct cache_tree *root_cache
> >                       if (btrfs_file_extent_type(leaf, fi) !=3D BTRFS_F=
ILE_EXTENT_REG)
> >                               goto next;
> >
> > +                     addr =3D btrfs_file_extent_disk_bytenr(leaf, fi);
> > +                     /* An explicit hole, skip as holes don't have csu=
ms. */
> > +                     if (addr =3D=3D 0)
> > +                             goto next;
> > +
> >                       if (btrfs_file_extent_compression(leaf, fi)) {
> > -                             addr =3D btrfs_file_extent_disk_bytenr(le=
af, fi);
> >                               length =3D btrfs_file_extent_disk_num_byt=
es(leaf, fi);
> >                       } else {
> > -                             addr =3D btrfs_file_extent_disk_bytenr(le=
af, fi) +
> > -                                    btrfs_file_extent_offset(leaf, fi)=
;
> > +                             addr +=3D btrfs_file_extent_offset(leaf, =
fi);
> >                               length =3D btrfs_file_extent_num_bytes(le=
af, fi);
> >                       }
> >
> > --
> > 2.47.2
> >

