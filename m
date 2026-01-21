Return-Path: <linux-btrfs+bounces-20861-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH7hDpoZcWmodQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20861-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 19:23:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BC95B362
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 19:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BE5C2843B97
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 17:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456BB425CCB;
	Wed, 21 Jan 2026 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bX6cMFOB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B809364055
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769015381; cv=none; b=I/qG2E/bPCdctDdGY8RSyn/iMysDgsebzBzABK8mLMKskRbhUgdkkSfWevRNkhGvUi1DtzYEVRy1jgI/mU7TzDhiqBxDpkJd8YW19D2dNJZrPOXAIWWZgUvGa6W3+SJYuQaQhOTNyUdh1IpQv3itZqRp6nT6BscdnFtJNt7yGKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769015381; c=relaxed/simple;
	bh=bjLqqqFAbq1ou/TGgfdoOkuLotg3q/3aXz6e6O2yr3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZKaKlE/57UW93DyIU3lBFbZxCu1SJTytRCG5xnQdNHVj618hxUI/sYFLKeUMl9aflHfYnuuxXgI5QRtBr6wIIm3zAnI5yh3DpjjeRwMoyy6w3ZaEANTVXCqR0EOIIsethpmyyE81rRO2YKAHUpE21qT60Qlbn+wXW/5Lq01GYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bX6cMFOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FF8C16AAE
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 17:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769015380;
	bh=bjLqqqFAbq1ou/TGgfdoOkuLotg3q/3aXz6e6O2yr3o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bX6cMFOBTRP2l52e8hb2cGv34AJOqfL/cpcCwgiS/wVoBSGCkEmaGm+cBOuazR85t
	 7e90VtLVs7mupevImLjW3vRO2SP9z2I/EPWKkXczyIb0G3j50lBVWDnGmzJf9bjXBI
	 2j/nUWaIjE4GtibhYBx7A/EUcjTc4tHDuCDef6d45pFFKPtAVG+aTDcisRIRmi3JR5
	 5xNQlDjGnqw6rGSzUiGQSSPgt7NsERq4ZkesV41O0Rrv8L5BA47my9OiYxXWjBdZtr
	 hID3wV8+GjUBy37BNj+9/29zJEJdv3bc/ANsKbeHcxqeps6m5blZxvwFH4Vj0rzdlg
	 Akp/tO96BhBcw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b86f81d8051so4601966b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 09:09:40 -0800 (PST)
X-Gm-Message-State: AOJu0Yw4t0XZNueYcnND6ZnwjffzKXxAGjoVOlwlGHz57JpCVH0Q25xt
	PxD6pZs6KH6l699MIsCZK18sx7uKNggGISMuFgGJH0btjC7mkylJrXGFs6NCrK/Uz0v0P4fv/50
	U410ItwTtxRo6m0fPyGGDneMGISfGEWM=
X-Received: by 2002:a17:907:a089:b0:b80:456d:bd99 with SMTP id
 a640c23a62f3a-b8831b8e715mr9461466b.19.1769015378988; Wed, 21 Jan 2026
 09:09:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768714131.git.wqu@suse.com> <86b8394ca75b3e8ac35b08e8ee8b4617d5f44331.1768714131.git.wqu@suse.com>
In-Reply-To: <86b8394ca75b3e8ac35b08e8ee8b4617d5f44331.1768714131.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 21 Jan 2026 17:09:02 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6dBONyBSO08RjH_K3fWHOLFwQ7aRQrGMUTh9xebn_eZw@mail.gmail.com>
X-Gm-Features: AZwV_QjFzyW4spJT7Qtq-om2Onuocu6TKaApp2DZhuplFv1XwlJ8pDvqrZjCjJA
Message-ID: <CAL3q7H6dBONyBSO08RjH_K3fWHOLFwQ7aRQrGMUTh9xebn_eZw@mail.gmail.com>
Subject: Re: [PATCH 1/3] btrfs: tests: remove invalid file extent map tests
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-20861-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D8BC95B362
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Jan 18, 2026 at 5:30=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> In the inode self tests, there are several problems:
>
> - Several invalid cases that will be rejected by tree-checkers

by tree-checkers -> by the tree-checker

Also missing punctuation at the end of the sentence, and this is a
pattern in every first sentence below too.

>   E.g. hole range [4K, 4K + 4) is completely invalid.
>
>   Only inlined extent maps can have an unaligned ram_bytes, and even for
>   that case, the generaeted extent map will use sectorsize as em->len.

generaeted -> generated

>
> - Manually inserted hole after an inlined extent map
>   The kernel never does this by itself, the current btrfs_get_extent()
>   will only return a single inlined extent map that covers the first
>   block.
>
> - Completely incorrect numbers in the comment
>   E.g. 12291 no matter if you add or dec 1, is not aligned to 4K.
>   The properly number for 12K is 12288, I don't know why there is even a
>   diff of 3, and this completely doesn't match the extent map we
>   inserted later.
>
> - Super hard to modify sequence in setup_file_extents()
>   If some unfortunate person, just like me, needs to modify
>   setup_file_extents(), good luck not screwing up the file offset.
>
> Fix them by:
>
> - Remove invalid unaligned extent maps
>   This mostly means remove the [4K, 4K + 4) hole case.
>   The remaining ones are already properly aligned.
>
>   This slightly changes the on-disk data extent allocation, with that
>   removed, the regular extents at [4K, 8K) and [8K , 12K) can be merged.
>
>   So also add a 4K gap between those two data extents to prevent em
>   merge.
>
> - Remove the manual insert of the implied hole after an inlined extent
>   Just like what the kernel is doning for inlined extents in the real

doning -> doing

>   world.
>
> - Update the commit using proper numbers with Kilo suffix
>   Since there is no unaligned range except the first inlined one, we can
>   always use numbers with 'K' suffix, which is way more easier to read,
>   and will always be aligned to 1024 at least.
>
> - Add extra ASSERT()s and comments in setup_file_extents()
>   The ASSERT()s are used to indicate the current file offset.
>   The extra comments are for the basic info of the file extent.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/tests/inode-tests.c | 111 ++++++++++++++++++++---------------
>  1 file changed, 64 insertions(+), 47 deletions(-)
>
> diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
> index a4c2b7748b95..58b75bdfed9e 100644
> --- a/fs/btrfs/tests/inode-tests.c
> +++ b/fs/btrfs/tests/inode-tests.c
> @@ -81,17 +81,20 @@ static void insert_inode_item_key(struct btrfs_root *=
root)
>   * diagram of how the extents will look though this may not be possible =
we still
>   * want to make sure everything acts normally (the last number is not in=
clusive)
>   *
> - * [0  - 6][     6 - 4096     ][ 4096 - 4100][4100 - 8195][8195  -  1229=
1]
> - * [inline][hole but no extent][    hole    ][   regular ][regular1 spli=
t]
> + * The numbers are using 4K fs block size as an example, the real test w=
ill scale
> + * all the extent maps (except the inlined one) according to the block s=
ize.
>   *
> - * [12291 - 16387][16387 - 24579][24579 - 28675][ 28675 - 32771][32771 -=
 36867 ]
> - * [    hole    ][regular1 split][   prealloc ][   prealloc1  ][prealloc=
1 written]
> + * [ 0  - 6 ][ 6 - 4K       ][ 4K - 8K ][ 8K -  12K      ]
> + * [ inline ][ implied hole ][ regular ][ regular1 split ]
>   *
> - * [36867 - 45059][45059 - 53251][53251 - 57347][57347 - 61443][61443- 6=
9635]
> - * [  prealloc1  ][ compressed  ][ compressed1 ][    regular  ][ compres=
sed1]
> + * [ 12K - 16K ][ 16K - 24K      ][ 24K - 28K ][ 28K - 32K ][ 32K - 36K =
        ]
> + * [ hole      ][ regular1 split ][ prealloc  ][ prealloc1 ][ prealloc1 =
written ]
>   *
> - * [69635-73731][   73731 - 86019   ][86019-90115]
> - * [  regular  ][ hole but no extent][  regular  ]
> + * [ 36K - 44K ][ 44K - 52K  ][ 52K - 56K   ][ 56K - 60K ][ 60K - 68 K  =
]
> + * [ prealloc1 ][ compressed ][ compressed1 ][ regular   ][ compressed1 =
]
> + *
> + * [ 68K - 72K ][ 72K - 84K          ][ 84K - 88K ]
> + * [  regular  ][ hole but no extent ][ regular   ]
>   */
>  static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
>  {
> @@ -100,40 +103,49 @@ static void setup_file_extents(struct btrfs_root *r=
oot, u32 sectorsize)
>         u64 offset =3D 0;
>
>         /*
> +        * Start 0, length 6, inlined.
> +        *
>          * Tree-checker has strict limits on inline extents that they can=
 only
>          * exist at file offset 0, thus we can only have one inline file =
extent
>          * at most.
>          */
> +       ASSERT(offset =3D=3D 0);

Err, what's the point? We have just assigned 0 to offset right above.

>         insert_extent(root, offset, 6, 6, 0, 0, 0, BTRFS_FILE_EXTENT_INLI=
NE, 0,
>                       slot);
>         slot++;
>         offset =3D sectorsize;
>
> -       /* Now another hole */
> -       insert_extent(root, offset, 4, 4, 0, 0, 0, BTRFS_FILE_EXTENT_REG,=
 0,
> -                     slot);
> +       /* Start 1 * blocksize, length 1 * blocksize, regular */

End sentence with punctuation (done in most other comments below).

> +       ASSERT(offset =3D=3D 1 * sectorsize);

Same here, we just assigned sectorsize to offset right above.

> +       insert_extent(root, offset, sectorsize, sectorsize, 0,
> +                     disk_bytenr, sectorsize, BTRFS_FILE_EXTENT_REG, 0, =
slot);
>         slot++;
> -       offset +=3D 4;
>
> -       /* Now for a regular extent */
> -       insert_extent(root, offset, sectorsize - 1, sectorsize - 1, 0,
> -                     disk_bytenr, sectorsize - 1, BTRFS_FILE_EXTENT_REG,=
 0, slot);
> -       slot++;
> -       disk_bytenr +=3D sectorsize;
> -       offset +=3D sectorsize - 1;
> +       /* We don't want the regular em got merged with the next one. */

Remove "got".

> +       disk_bytenr +=3D 2 * sectorsize;
> +       offset +=3D sectorsize;
>
>         /*
> +        * Start 2 * blocksize, length 1 * blocksize, regular.
> +        *
>          * Now for 3 extents that were split from a hole punch so we test
>          * offsets properly.
>          */
> +       ASSERT(offset =3D=3D 2 * sectorsize);

Same here, we have just incremented offset by sectorsize.

>         insert_extent(root, offset, sectorsize, 4 * sectorsize, 0, disk_b=
ytenr,
>                       4 * sectorsize, BTRFS_FILE_EXTENT_REG, 0, slot);
>         slot++;
>         offset +=3D sectorsize;
> +
> +       /* Start 3 * blocksize, length 1 * blocksize, regular, explicit h=
ole. */
> +       ASSERT(offset =3D=3D 3 * sectorsize);

Same.

>         insert_extent(root, offset, sectorsize, sectorsize, 0, 0, 0,
>                       BTRFS_FILE_EXTENT_REG, 0, slot);
>         slot++;
>         offset +=3D sectorsize;
> +
> +       /* Start 4 * blocksize, length 2 * blocksize, regular. */
> +       ASSERT(offset =3D=3D 4 * sectorsize);

Same.

>         insert_extent(root, offset, 2 * sectorsize, 4 * sectorsize,
>                       2 * sectorsize, disk_bytenr, 4 * sectorsize,
>                       BTRFS_FILE_EXTENT_REG, 0, slot);
> @@ -141,7 +153,8 @@ static void setup_file_extents(struct btrfs_root *roo=
t, u32 sectorsize)
>         offset +=3D 2 * sectorsize;
>         disk_bytenr +=3D 4 * sectorsize;
>
> -       /* Now for a unwritten prealloc extent */
> +       /* Start 6 * blocksize, length 1 * blocksize, preallocated. */
> +       ASSERT(offset =3D=3D 6 * sectorsize);

Same here, and every ASSERT below.
We have the comments to guide us at which offset we are too, so one
less reason to have the ASSERT, not to mention the tests will fail if
they get screwed up.

>         insert_extent(root, offset, sectorsize, sectorsize, 0, disk_byten=
r,
>                 sectorsize, BTRFS_FILE_EXTENT_PREALLOC, 0, slot);
>         slot++;
> @@ -154,19 +167,28 @@ static void setup_file_extents(struct btrfs_root *r=
oot, u32 sectorsize)
>         disk_bytenr +=3D 2 * sectorsize;
>
>         /*
> +        * Start 7 * blocksize, length 1 * blocksize, prealloc.
> +        *
>          * Now for a partially written prealloc extent, basically the sam=
e as
>          * the hole punch example above.  Ram_bytes never changes when yo=
u mark
>          * extents written btw.
>          */
> +       ASSERT(offset =3D=3D 7 * sectorsize);
>         insert_extent(root, offset, sectorsize, 4 * sectorsize, 0, disk_b=
ytenr,
>                       4 * sectorsize, BTRFS_FILE_EXTENT_PREALLOC, 0, slot=
);
>         slot++;
>         offset +=3D sectorsize;
> +
> +       /* Start 8 * blocksize, length 1 * blocksize, regular. */
> +       ASSERT(offset =3D=3D 8 * sectorsize);
>         insert_extent(root, offset, sectorsize, 4 * sectorsize, sectorsiz=
e,
>                       disk_bytenr, 4 * sectorsize, BTRFS_FILE_EXTENT_REG,=
 0,
>                       slot);
>         slot++;
>         offset +=3D sectorsize;
> +
> +       /* Start 9 * blocksize, length 2 * blocksize, prealloc. */
> +       ASSERT(offset =3D=3D 9 * sectorsize);
>         insert_extent(root, offset, 2 * sectorsize, 4 * sectorsize,
>                       2 * sectorsize, disk_bytenr, 4 * sectorsize,
>                       BTRFS_FILE_EXTENT_PREALLOC, 0, slot);
> @@ -174,7 +196,8 @@ static void setup_file_extents(struct btrfs_root *roo=
t, u32 sectorsize)
>         offset +=3D 2 * sectorsize;
>         disk_bytenr +=3D 4 * sectorsize;
>
> -       /* Now a normal compressed extent */
> +       /* Start 11 * blocksize, length 2 * blocksize, regular . */

Space before the punctuation.

Otherwise it looks fine, thanks.

> +       ASSERT(offset =3D=3D 11 * sectorsize);
>         insert_extent(root, offset, 2 * sectorsize, 2 * sectorsize, 0,
>                       disk_bytenr, sectorsize, BTRFS_FILE_EXTENT_REG,
>                       BTRFS_COMPRESS_ZLIB, slot);
> @@ -183,17 +206,24 @@ static void setup_file_extents(struct btrfs_root *r=
oot, u32 sectorsize)
>         /* No merges */
>         disk_bytenr +=3D 2 * sectorsize;
>
> -       /* Now a split compressed extent */
> +       /* Start 13 * blocksize, length 1 * blocksize, regular. */
> +       ASSERT(offset =3D=3D 13 * sectorsize);
>         insert_extent(root, offset, sectorsize, 4 * sectorsize, 0, disk_b=
ytenr,
>                       sectorsize, BTRFS_FILE_EXTENT_REG,
>                       BTRFS_COMPRESS_ZLIB, slot);
>         slot++;
>         offset +=3D sectorsize;
> +
> +       /* Start 14 * blocksize, length 1 * blocksize, regular. */
> +       ASSERT(offset =3D=3D 14 * sectorsize);
>         insert_extent(root, offset, sectorsize, sectorsize, 0,
>                       disk_bytenr + sectorsize, sectorsize,
>                       BTRFS_FILE_EXTENT_REG, 0, slot);
>         slot++;
>         offset +=3D sectorsize;
> +
> +       /* Start 15 * blocksize, length 2 * blocksize, regular. */
> +       ASSERT(offset =3D=3D 15 * sectorsize);
>         insert_extent(root, offset, 2 * sectorsize, 4 * sectorsize,
>                       2 * sectorsize, disk_bytenr, sectorsize,
>                       BTRFS_FILE_EXTENT_REG, BTRFS_COMPRESS_ZLIB, slot);
> @@ -201,12 +231,21 @@ static void setup_file_extents(struct btrfs_root *r=
oot, u32 sectorsize)
>         offset +=3D 2 * sectorsize;
>         disk_bytenr +=3D 2 * sectorsize;
>
> -       /* Now extents that have a hole but no hole extent */
> +       /* Start 17 * blocksize, length 1 * blocksize, regular. */
> +       ASSERT(offset =3D=3D 17 * sectorsize);
>         insert_extent(root, offset, sectorsize, sectorsize, 0, disk_byten=
r,
>                       sectorsize, BTRFS_FILE_EXTENT_REG, 0, slot);
>         slot++;
>         offset +=3D 4 * sectorsize;
>         disk_bytenr +=3D sectorsize;
> +
> +       /*
> +        * Start 18 * blocksize, length 3 * blocksize, implied hole (aka =
no
> +        * file extent item).
> +        *
> +        * Start 21 * blocksize, length 1 * blocksize, regular.
> +        */
> +       ASSERT(offset =3D=3D 21 * sectorsize);
>         insert_extent(root, offset, sectorsize, sectorsize, 0, disk_byten=
r,
>                       sectorsize, BTRFS_FILE_EXTENT_REG, 0, slot);
>  }
> @@ -316,28 +355,6 @@ static noinline int test_btrfs_get_extent(u32 sector=
size, u32 nodesize)
>         offset =3D em->start + em->len;
>         btrfs_free_extent_map(em);
>
> -       em =3D btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize)=
;
> -       if (IS_ERR(em)) {
> -               test_err("got an error when we shouldn't have");
> -               goto out;
> -       }
> -       if (em->disk_bytenr !=3D EXTENT_MAP_HOLE) {
> -               test_err("expected a hole, got %llu", em->disk_bytenr);
> -               goto out;
> -       }
> -       if (em->start !=3D offset || em->len !=3D 4) {
> -               test_err(
> -       "unexpected extent wanted start %llu len 4, got start %llu len %l=
lu",
> -                       offset, em->start, em->len);
> -               goto out;
> -       }
> -       if (em->flags !=3D 0) {
> -               test_err("unexpected flags set, want 0 have %u", em->flag=
s);
> -               goto out;
> -       }
> -       offset =3D em->start + em->len;
> -       btrfs_free_extent_map(em);
> -
>         /* Regular extent */
>         em =3D btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize)=
;
>         if (IS_ERR(em)) {
> @@ -348,10 +365,10 @@ static noinline int test_btrfs_get_extent(u32 secto=
rsize, u32 nodesize)
>                 test_err("expected a real extent, got %llu", em->disk_byt=
enr);
>                 goto out;
>         }
> -       if (em->start !=3D offset || em->len !=3D sectorsize - 1) {
> +       if (em->start !=3D offset || em->len !=3D sectorsize) {
>                 test_err(
> -       "unexpected extent wanted start %llu len 4095, got start %llu len=
 %llu",
> -                       offset, em->start, em->len);
> +       "unexpected extent wanted start %llu len %u, got start %llu len %=
llu",
> +                       offset, sectorsize, em->start, em->len);
>                 goto out;
>         }
>         if (em->flags !=3D 0) {
> --
> 2.52.0
>
>

