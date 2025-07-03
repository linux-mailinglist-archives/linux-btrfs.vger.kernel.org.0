Return-Path: <linux-btrfs+bounces-15223-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E46AF7303
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 13:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06564162852
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 11:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0932E2F12;
	Thu,  3 Jul 2025 11:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeru9fJY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314041E5711
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Jul 2025 11:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543641; cv=none; b=Zk4hkNlGnfb8LBqU9hhb6+iTfqgvSsQBWuQbf8bxYeYHA5xjW0Ddw/gweln7JhIH12NZMXn/y5oRWlH3IlpPQFFSCBfzs43J6DOjJywF/6D+PNsEVBdd3hW+1VEbZlQ4JAdFeuRqmYGCkGce1ZPDrHas7ws7Uryr4OZWRt/ko8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543641; c=relaxed/simple;
	bh=Vz2Ly6MbFT6rp672cd88fP9Jt6KsVZFbSrnGtbSg5ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7R69IifJdhygsrejY6bmod2U9tpZCDJomWCNHRJGzChEpxulpHC0UcaiaPRYxv2x3Ss2vKBY+XTyoBHdWIYjDmZDrYxYmEc4jn1dwMC3f6ISKRwBS6QDxbIYsXmcSYqrgByPsj9slb/+Scgw4Uk7PtZnD51FeF9CAw3QByZJSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeru9fJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A725DC4CEE3
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Jul 2025 11:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751543640;
	bh=Vz2Ly6MbFT6rp672cd88fP9Jt6KsVZFbSrnGtbSg5ho=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qeru9fJYO/CuPWvVkOBRfpa2AzMWTDVfM7rNnYye4CuhdQ5bhvZHHgVY82rk/bRNa
	 LuSV6TyAmu5h30ExjGp2c3H7qllOyLLQVqsPJcVHEGAWx97okkOVor+powYdL9etdp
	 Oc2BoOH4TGpR+zaAfU4q4M1dGKLELUuLPHkGwX3ldq5ZeXL1Cj0RO279la9qO6AhWN
	 REA0mgozQExmVBtv88ryJFdgMi42Q0vMUuXjTmuT5Tutb6Q3Rt9PAZvxPWLe+bEHxS
	 x1VHpU9hq9Mli9CxsIv+tbPpH7vf71YS241jd9mIP/u6biJH4NMBw4iDHZb4vfsH1+
	 Z0V+cgawDzT8A==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae3ec622d2fso46798366b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Jul 2025 04:54:00 -0700 (PDT)
X-Gm-Message-State: AOJu0YzQ5W2jyEyDCumhuGXhsytqeOEJZpU0gKq3jZcnchG703hv6w6n
	Zez146RYMOiRHMassPlUXkoLmOHw/LmS8nbJ51oVGMIXpbOU+//+UKthhc6slbjd2hmXn75Amc+
	eDpyiYWEXcJIsh75XPh4SlXV/2lIEPbQ=
X-Google-Smtp-Source: AGHT+IFyuMDKMi1Fn9wOm+dft5EO8ZreFDYJ5aZwXmab29pPSlA4un0FkPp7bNWsgQdXrQExaU0BWdg4ZkQGVvYfhX4=
X-Received: by 2002:a17:906:3c7:b0:ae0:da16:f550 with SMTP id
 a640c23a62f3a-ae3c2c37f36mr567344466b.49.1751543639211; Thu, 03 Jul 2025
 04:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <656838ec1232314a2657716e59f4f15a8eadba64.1751492111.git.boris@bur.io>
In-Reply-To: <656838ec1232314a2657716e59f4f15a8eadba64.1751492111.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 3 Jul 2025 12:53:22 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4JPumV5YPUdbTU=gS6wyYOpUga0H47ffxgirqrEVE=pQ@mail.gmail.com>
X-Gm-Features: Ac12FXwZAEikXPjXjeKitt987mN8o7cPey08pNp75KxoKika8FzSOJYRZj1BeUc
Message-ID: <CAL3q7H4JPumV5YPUdbTU=gS6wyYOpUga0H47ffxgirqrEVE=pQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: use readahead_expand on compressed extents
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, willy@infradead.org, 
	dhowells@redhat.com, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 10:36=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> We recently received a report of poor performance doing sequential
> buffered reads of a file with compressed extents. With bs=3D128k, a naive
> sequential dd ran as fast on a compressed file as on an uncompressed
> (1.2GB/s on my reproducing system) while with bs<32k, this performance
> tanked down to ~300MB/s.
>
> i.e.,
> slow:
> dd if=3Dsome-compressed-file of=3D/dev/null bs=3D4k count=3DX
> vs
> fast:
> dd if=3Dsome-compressed-file of=3D/dev/null bs=3D128k count=3DY
>
> The cause of this slowness is overhead to do with looking up extent_maps
> to enable readahead pre-caching on compressed extents
> (add_ra_bio_pages()), as well as some overhead in the generic VFS
> readahead code we hit more in the slow case. Notably, the main
> difference between the two read sizes is that in the large sized request
> case, we call btrfs_readahead() relatively rarely while in the smaller
> request we call it for every compressed extent. So the fast case stays
> in the btrfs readahead loop:
>
> while ((folio =3D readahead_folio(rac)) !=3D NULL)
>         btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
>
> where the slower one breaks out of that loop every time. This results in
> calling add_ra_bio_pages a lot, doing lots of extent_map lookups,
> extent_map locking, etc.
>
> This happens because although add_ra_bio_pages() does add the
> appropriate un-compressed file pages to the cache, it does not
> communicate back to the ractl in any way. To solve this, we should be
> using readahead_expand() to signal to readahead to expand the readahead
> window.
>
> This change passes the readahead_control into the btrfs_bio_ctrl and in
> the case of compressed reads sets the expansion to the size of the
> extent_map we already looked up anyway. It skips the subpage case as
> that one already doesn't do add_ra_bio_pages().
>
> With this change, whether we use bs=3D4k or bs=3D128k, btrfs expands the
> readahead window up to the largest compressed extent we have seen so far
> (in the trivial example: 128k) and the call stacks of the two modes look
> identical. Notably, we barely call add_ra_bio_pages at all. And the
> performance becomes identical as well. So this change certainly "fixes"
> this performance problem.
>
> Of course, it does seem to beg a few questions:
> 1. Will this waste too much page cache with a too large ra window?
> 2. Will this somehow cause bugs prevented by the more thoughtful
>    checking in add_ra_bio_pages?
> 3. Should we delete add_ra_bio_pages?
>
> My stabs at some answers:
> 1. Hard to say. See attempts at generic performance testing below. Is
>    there a "readahead_shrink" we should be using? Should we expand more
>    slowly, by half the remaining em size each time?
> 2. I don't think so. Since the new behavior is indistiguishable from
>    reading the file with a larger read size passed in, I don't see why
>    one would be safe but not the other.
> 3. Probably! I tested that and it was fine in fstests, and it seems like
>    the pages would get re-used just as well in the readahead case.
>    However, it is possible some reads that use page cache but not
>    btrfs_readahead() could suffer. I will investigate this further as a
>    follow up.
>
> I tested the performance implications of this change in 3 ways (using
> compress-force=3Dzstd:3 for compression):
>
> Directly test the affected workload of small sequential reads on a
> compressed file (improved from ~250MB/s to ~1.2GB/s)
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dfor-next=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> dd /mnt/lol/non-cmpr 4k
> 1048576+0 records in
> 1048576+0 records out
> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 6.02983 s, 712 MB/s
> dd /mnt/lol/non-cmpr 128k
> 32768+0 records in
> 32768+0 records out
> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 5.92403 s, 725 MB/s
> dd /mnt/lol/cmpr 4k
> 1048576+0 records in
> 1048576+0 records out
> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 17.8832 s, 240 MB/s
> dd /mnt/lol/cmpr 128k
> 32768+0 records in
> 32768+0 records out
> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 3.71001 s, 1.2 GB/s
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dra-expand=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> dd /mnt/lol/non-cmpr 4k
> 1048576+0 records in
> 1048576+0 records out
> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 6.09001 s, 705 MB/s
> dd /mnt/lol/non-cmpr 128k
> 32768+0 records in
> 32768+0 records out
> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 6.07664 s, 707 MB/s
> dd /mnt/lol/cmpr 4k
> 1048576+0 records in
> 1048576+0 records out
> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 3.79531 s, 1.1 GB/s
> dd /mnt/lol/cmpr 128k
> 32768+0 records in
> 32768+0 records out
> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 3.69533 s, 1.2 GB/s
>
> Built the linux kernel from clean (no change)
>
> Ran fsperf. Mostly neutral results with some improvements and
> regressions here and there.
>
> Reported-by: Dimitrios Apostolou <jimis@gmx.net>
> Link: https://lore.kernel.org/linux-btrfs/34601559-6c16-6ccc-1793-20a97ca=
0dbba@gmx.net/
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> Changelog:
> v2:
> - added a comment about skipping non-compressed and subpage for now.
> - fixed stray whitespace.
> - fixed const on a few parameters and removed unhelpful extra parameters.
> - used btrfs_is_subpage() and got rid of extra temporary variables.
> - tested non-compressed extents; fixed a bug in btrfs_readahead_extent
>   from those, but did not add any reasonable clamping, as we are still
>   not calling it on non-compressed extents.
>
>  fs/btrfs/extent_io.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index b551e0641b0c..7ad4f10bb55a 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -110,6 +110,7 @@ struct btrfs_bio_ctrl {
>          * This is to avoid touching ranges covered by compression/inline=
.
>          */
>         unsigned long submit_bitmap;
> +       struct readahead_control *ractl;
>  };
>
>  static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
> @@ -881,6 +882,25 @@ static struct extent_map *get_extent_map(struct btrf=
s_inode *inode,
>
>         return em;
>  }
> +
> +static void btrfs_readahead_expand(struct readahead_control *ractl,
> +                                  const struct extent_map *em)
> +{
> +       const u64 ra_pos =3D readahead_pos(ractl);
> +       const u64 ra_end =3D ra_pos + readahead_length(ractl);
> +       const u64 em_end =3D em->start + em->ram_bytes;
> +
> +       /* No expansion for holes and inline extents. */
> +       if (em->disk_bytenr > EXTENT_MAP_LAST_BYTE)
> +               return;
> +
> +       ASSERT(em_end >=3D ra_pos,
> +              "extent_map %llu %llu ends before current readahead positi=
on %llu",
> +              em->start, em->len, ra_pos);
> +       if (em_end > ra_end)
> +               readahead_expand(ractl, ra_pos, em_end - ra_pos);
> +}
> +
>  /*
>   * basic readpage implementation.  Locked extent state structs are inser=
ted
>   * into the tree that are removed when the IO is done (by the end_io
> @@ -944,6 +964,16 @@ static int btrfs_do_readpage(struct folio *folio, st=
ruct extent_map **em_cached,
>
>                 compress_type =3D btrfs_extent_map_compression(em);
>
> +               /*
> +                * Only expand readahead for extents which are already cr=
eating
> +                * the pages anyway in add_ra_bio_pages, which is compres=
sed
> +                * extents in the non subpage case.
> +                */
> +               if (bio_ctrl->ractl &&
> +                   !btrfs_is_subpage(fs_info, folio) &&
> +                   compress_type !=3D BTRFS_COMPRESS_NONE)
> +                       btrfs_readahead_expand(bio_ctrl->ractl, em);
> +
>                 if (compress_type !=3D BTRFS_COMPRESS_NONE)
>                         disk_bytenr =3D em->disk_bytenr;
>                 else
> @@ -2540,7 +2570,10 @@ int btrfs_writepages(struct address_space *mapping=
, struct writeback_control *wb
>
>  void btrfs_readahead(struct readahead_control *rac)
>  {
> -       struct btrfs_bio_ctrl bio_ctrl =3D { .opf =3D REQ_OP_READ | REQ_R=
AHEAD };
> +       struct btrfs_bio_ctrl bio_ctrl =3D {
> +               .opf =3D REQ_OP_READ | REQ_RAHEAD,
> +               .ractl =3D rac
> +       };
>         struct folio *folio;
>         struct btrfs_inode *inode =3D BTRFS_I(rac->mapping->host);
>         const u64 start =3D readahead_pos(rac);
> --
> 2.49.0
>
>

