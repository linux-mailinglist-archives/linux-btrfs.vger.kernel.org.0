Return-Path: <linux-btrfs+bounces-19655-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A996CB5A1C
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 12:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 298793011425
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 11:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B189D3093B6;
	Thu, 11 Dec 2025 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2M3FW36"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30C73081B8
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765452440; cv=none; b=tEe5WzAg3SPIGmO1m+WFEBfNGlXZheSYy8YEopSvN6SqZqgLJjhaAT0+GdmTHgs74UOem0lHAZTyliJhJBQrnWvcWFCcys5zziTVRe23if2H0nG03sznx5wd3M/k4dwIVzJsdXd/IIXktDJr0Fb2PioalllYM2PmyjhzlCcKRN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765452440; c=relaxed/simple;
	bh=kQAw0IAMRna6jKX/Q2x47HBOf1gpFkKwx0F/nl9ECFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhLKCgCOAWQul3xEVauGCgljcQTu/r3z6B+ebq2GvRKzQwU2KKYK+mfq4Ijk2YyXEZojLH9FxcNcHFoSEr6OgX+IfcMKRmc9dkFIWPVxP+paNULDS2ZhxZse1x8wHuw5tSs4mGKuixAPzkO8y1IzsHBlgrW/Fyv4MYCtzFT8Tuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2M3FW36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A6FC113D0
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 11:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765452439;
	bh=kQAw0IAMRna6jKX/Q2x47HBOf1gpFkKwx0F/nl9ECFs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t2M3FW36heDDwTZWjZp7mEq4HzBDD6x+2ridDeBMz+l8Tv3JwsgoTRZmBY6xRvGK2
	 j6HvnlRtHFSk0+UhC4KLOSW2EdjJjQvM9VrmXccS9WaBkBU2m+1YNXklO4UWaoYDfA
	 pVxbCbzBxMiL5jpwb0EViCj4/R9bsTjrrrYHQZNmwW8Uy3L0lgkZvyZibwxVC/z/bL
	 Odoc58h61dR7hHNZELxm8lWMQBzMMhe611d+L7DtfhODryJrQMXfhIES+zWyWtcWDN
	 svniVDEpUECirmjs1TYj/kvnjYoAK4GkNEsE5Bi9VO7yl7G48OD0Ogz+RJzQsbw3yv
	 D+9Oiz2CgkyzA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b736d883ac4so132253866b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 03:27:19 -0800 (PST)
X-Gm-Message-State: AOJu0YzEmueeE01WY2xmSKwEg2qv4IwIgcy+4neejNaa7YksNKCtdmVb
	ijGfQFag02UE13MzIxt3j21FQlHBp1wNDIcCu5GDBy7TaGUlZ0jDWehE04du8PWvNSeRLzTeBKU
	cpY2DZErWOcJOYtbj3VmNl1ZxAaq379s=
X-Google-Smtp-Source: AGHT+IHtWAE4eBnNFHTJXayG4mAtiXimCO5w3FF2uYO8JE4iBUAbFnpARxgHTcM1sxRHjNAaRMubRdbyb0u33UR00t0=
X-Received: by 2002:a17:907:9443:b0:b73:880a:fdb7 with SMTP id
 a640c23a62f3a-b7ce8414fcfmr675544666b.35.1765452438226; Thu, 11 Dec 2025
 03:27:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765418669.git.wqu@suse.com> <2e646aa21c452f80c2afbbf50ceda081c5c3ed4c.1765418669.git.wqu@suse.com>
In-Reply-To: <2e646aa21c452f80c2afbbf50ceda081c5c3ed4c.1765418669.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 11 Dec 2025 11:26:41 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5_AU-SUacEd8H0Qz8vg8jAq1fmSEkhvwx_qpmQTGvS8w@mail.gmail.com>
X-Gm-Features: AQt7F2qz1uAnwG4E7VJiOBxNTd2EG0WCb7u-BX7SVZ8399pBt-MY6fTlgpxWW7I
Message-ID: <CAL3q7H5_AU-SUacEd8H0Qz8vg8jAq1fmSEkhvwx_qpmQTGvS8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: fix beyond-EOF write handling
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 2:15=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> For the following write sequence with 64K page size and 4K fs block size,
> it will lead to file extent items to be inserted without any data
> checksum:
>
>   mkfs.btrfs -s 4k -f $dev > /dev/null
>   mount $dev $mnt
>   xfs_io -f -c "pwrite 0 16k" -c "pwrite 32k 4k" -c pwrite "60k 64K" \
>             -c "truncate 16k" $mnt/foobar
>   umount $mnt

If you can, add this to fstests.

>
> This will result the following 2 file extent items to be inserted (extra
> trace point added to insert_ordered_extent_file_extent()):
>
>    btrfs_finish_one_ordered: root=3D5 ino=3D257 file_off=3D61440 num_byte=
s=3D4096 csum_bytes=3D0
>    btrfs_finish_one_ordered: root=3D5 ino=3D257 file_off=3D0 num_bytes=3D=
16384 csum_bytes=3D16384
>
> Note for file offset 60K, we're inserting an file extent without any

an file -> a file

> data checksum.
>
> Also note that range [32K, 36K) didn't reach
> insert_ordered_extent_file_extent(), which is the correct behavior as
> that OE is fully truncated, should not result any file extent.
>
> Although file extent at 60K will be later dropped by btrfs_truncate(),
> if the transaction got committed after file extent inserted but before
> the file extent dropping, we will have a small window where we have a
> file extent beyond EOF and without any data checksum.
>
> That will cause "btrfs check" to report error.
>
> [CAUSE]
> The sequence happens like this:
>
> - Buffered write dirtied the page cache and updated isize
>
>   Now the inode size is 64K, with the following page cache layout:
>
>   0             16K             32K              48K           64K
>   |/////////////|               |//|                        |//|
>
> - Truncate the inode to 16K
>   Which will trigger writeback through:
>
>   btrfs_setsize()
>   |- truncate_setsize()
>   |  Now the inode size is set to 16K
>   |
>   |- btrfs_truncacte()

truncacte -> truncate

It looks good otherwise, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>      |- btrfs_wait_ordered_range() for [16K, u64(-1)]
>         |- btrfs_fdatawrite_range() for [16K, u64(-1)}
>            |- extent_writepage() for folio 0
>               |- writepage_delalloc()
>               |  Generated OE for [0, 16K), [32K, 36K] and [60K, 64K)
>               |
>               |- extent_writepage_io()
>
>   Then inside extent_writepage_io(), the dirty fs blocks are handled
>   differently:
>
>   - Submit write for range [0, 16K)
>     As they are still inside the inode size (16K).
>
>   - Mark OE [32K, 36K) as truncated
>     Since we only call btrfs_lookup_first_ordered_range() once, which
>     returned the first OE after file offset 16K.
>
>   - Mark all OEs inside range [16K, 64K) as finished
>     Which will mark OE ranges [32K, 36K) and [60K, 64K) as finished.
>
>     For OE [32K, 36K) since it's already marked as truncated, and its
>     truncated length is 0, no file extent will be inserted.
>
>     For OE [60K, 64K) it has never been submitted thus has no data
>     checksum, and we insert the file extent as usual.
>     This is the root cause of file extent at 60K to be inserted without
>     any data checksum.
>
>   - Clear dirty flags for range [16K, 64K)
>     It is the function btrfs_folio_clear_dirty() which search and clear
>     any dirty blocks inside that range.
>
> [FIX]
> The bug itself is introduced a long time ago, way before subpage and
> larger folio support.
>
> At that time, fs block size must match page size, thus the range
> [cur, end) is just one fs block.
>
> But later with subpage and larger folios, the same range [cur, end)
> can have multiple blocks and ordered extents.
>
> Later commit 18de34daa7c6 ("btrfs: truncate ordered extent when skipping
> writeback past i_size") is fixing a bug related to subpage/larger
> folios, but it's still utilizing the old range [cur, end), meaning only
> the first OE will be marked as truncated.
>
> The proper fix here is to make EOF handling block-by-block, not trying
> to handle the whole range to @end.
>
> By this we always locate and truncate the OE for every dirty block.
>
> Cc: stable@vger.kernel.org # 5.15+
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 629fd5af4286..a4b74023618d 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1728,7 +1728,7 @@ static noinline_for_stack int extent_writepage_io(s=
truct btrfs_inode *inode,
>                         struct btrfs_ordered_extent *ordered;
>
>                         ordered =3D btrfs_lookup_first_ordered_range(inod=
e, cur,
> -                                                                  folio_=
end - cur);
> +                                                                  fs_inf=
o->sectorsize);
>                         /*
>                          * We have just run delalloc before getting here,=
 so
>                          * there must be an ordered extent.
> @@ -1742,7 +1742,7 @@ static noinline_for_stack int extent_writepage_io(s=
truct btrfs_inode *inode,
>                         btrfs_put_ordered_extent(ordered);
>
>                         btrfs_mark_ordered_io_finished(inode, folio, cur,
> -                                                      end - cur, true);
> +                                                      fs_info->sectorsiz=
e, true);
>                         /*
>                          * This range is beyond i_size, thus we don't nee=
d to
>                          * bother writing back.
> @@ -1751,8 +1751,8 @@ static noinline_for_stack int extent_writepage_io(s=
truct btrfs_inode *inode,
>                          * writeback the sectors with subpage dirty bits,
>                          * causing writeback without ordered extent.
>                          */
> -                       btrfs_folio_clear_dirty(fs_info, folio, cur, end =
- cur);
> -                       break;
> +                       btrfs_folio_clear_dirty(fs_info, folio, cur, fs_i=
nfo->sectorsize);
> +                       continue;
>                 }
>                 ret =3D submit_one_sector(inode, folio, cur, bio_ctrl, i_=
size);
>                 if (unlikely(ret < 0)) {
> --
> 2.52.0
>
>

