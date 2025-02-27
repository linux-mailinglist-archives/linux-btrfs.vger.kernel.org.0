Return-Path: <linux-btrfs+bounces-11906-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 082A6A47E3A
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 13:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03F2188D2C0
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 12:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C70122D7BD;
	Thu, 27 Feb 2025 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q98H2VOk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B60A22B8A5
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660534; cv=none; b=qvo5cgAenqhJg7IKuZa3PoRflm9KrSoKK1yzKj+TTZVk/XvhIjttf34QASKP3moOJJXwli22XBjzzAfwGC1wBR0LweR980klO9u7a/RFfVhA8IAyVwC9uTyDOuylFiHNo9rq0eU0MWEUJyw8wl4vootm3MmdcAHH9Ep7QX8zLGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660534; c=relaxed/simple;
	bh=/g63OFKmsqhZUBLMf9M16sejeTvwf0vQK3hHBz5GTX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dj/+EoXjgqVywFVVIFznd0yTSq7rPCchAC4peLx34xxr92Kja5c5nXSwVuRQE+gTpRmC5zavavBtimBj5mlR83df1UKsZ4bT9OyjIbt+P2wvKlj2Z7dJGwQflZwUTc2yOvSU/4nI11k2Hwz/26wPegu1B2yJq2CxZGXJVk1VxpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q98H2VOk; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab7430e27b2so142759166b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 04:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740660531; x=1741265331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ybDRdcW9fdG6Fvuty3QnUHHkDHbkXlx78zMJDXp5xa0=;
        b=Q98H2VOkRDfXL2crsmiZKKvaA5MsQdlGzvrZjevjDOw5y6VUHUcmEIlDd5btVjRGna
         3SLwBetRBrMX2Hp/nrlJ8SonUHbPQGJHzln1MAPUPec3lnNpStlpQX4c7Lxafcji/uKQ
         aZZUESj5VwMfogtgAxj7XMYprUG2eX9eNKEAXGJ4AA21Oji8U1VOKOU+eKzuG/kBAbOO
         7uZhwumiSIq+xpFRZ8Oty/kzcajH+tcz869650x6sU+a5/5vNRqvEP0pfvZiHtzz5yws
         BAXcmtjxytKCjK8VpUlLn4ibXEeBYoXps6q2k++Ycg7yI7iF0A02GVV+9LYJQk01dCQs
         ngmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740660531; x=1741265331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ybDRdcW9fdG6Fvuty3QnUHHkDHbkXlx78zMJDXp5xa0=;
        b=CFkBqfG2Z1+XZBp6hofx5WGiHmStSr3oQrxPbIhR7pNJcb34+9SNh8RFLKQ0hOPuCq
         xmIruMQVWaWP7EbNhnGdJanfZfDpcbuE1W5tiZfwM+vqyrJgSy0zOflDqK0aoY1F3LeI
         EkjbjUksDUNhoeX8DRVsgS/uldFMpohdORx8xVS8chYHvcGf0BDO9hNTpsDMUM0qhell
         B8mxxuI/F0FRRdwrgoMnP3bVPwOmUeR8M23OBSrv/+7GtsxagDUd0FJKEics//pbc6G9
         nizdWPmVL5WABhsdeb1AiRPO4AVKDDqZ+Ch0lDwKSY3c2wh0oW50KeDy5kUdOxcTa03j
         LuLA==
X-Gm-Message-State: AOJu0YxNGSgdhT+QK9m6hAHPgjeuVl1zb17MZ6d12ZWHuEp4donLaIkE
	fUHqQTpuqDFziBbMP8Kg8hTpvr7EahXPB4ahPLttT9u2BHx/bPu7e/8ZJDEib2vKPEH+XiSf0nA
	h/xsj436vFA0RiPx2lFOqDXH28L0GIhiy
X-Gm-Gg: ASbGncue4iS8IqvSI2XomqcIbqL0P90QB4yyQpzaDot43Ex+X6ZqNO8FYHrb+sFSzlM
	q1kJZF3IIAMzB3oyQcZxv/lceIK3wtk4hxcMUi0dMRsRcXHKxLm5lDmVe8z+lBNxF4pP9yDi4hS
	1/TvF3e9c6MAOXtxucLQF47SIFhna0g3EAxzhwR5k=
X-Google-Smtp-Source: AGHT+IElhd0JFta7/txoP2gcudH2NC6Yg7uaQcFI/6RAH0bb5MLIQXUT56jz5K/gNT8FvBDG7U8YUOWU6C9kRrWJukg=
X-Received: by 2002:a17:906:31cf:b0:ab7:6d59:3b4c with SMTP id
 a640c23a62f3a-abc0d9e5e51mr2243035666b.21.1740660530496; Thu, 27 Feb 2025
 04:48:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740635497.git.wqu@suse.com> <bc941d1a5ad95c25de4108bd261ce9da96145689.1740635497.git.wqu@suse.com>
In-Reply-To: <bc941d1a5ad95c25de4108bd261ce9da96145689.1740635497.git.wqu@suse.com>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Thu, 27 Feb 2025 12:48:13 +0000
X-Gm-Features: AQ5f1JpKJ5UKumu8JCUpql331jZANJOA0_01ri-XirRMbbobL7a0RXMhQ6A3DOA
Message-ID: <CAL3q7H4Pznyf=JCnrhRAwddsZbVMgPwbMK8DkBVJkY3fzAaYoQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] btrfs: make btrfs_do_readpage() to do
 block-by-block read
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 5:56=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Currently if a btrfs has its block size (the older sector size) smaller
> than the page size, btrfs_do_readpage() will handle the range extent by
> extent, this is good for performance as it doesn't need to re-lookup the
> same extent map again and again.
> (Although get_extent_map() already does extra cached em check, thus
> the optimization is not that obvious)
>
> This is totally fine and is a valid optimization, but it has an
> assumption that, there is no partial uptodate range in the page.
>
> Meanwhile there is an incoming feature, requiring btrfs to skip the full
> page read if a buffered write range covers a full block but not a full
> page.
>
> In that case, we can have a page that is partially uptodate, and the
> current per-extent lookup can not handle such case.
>
> So here we change btrfs_do_readpage() to do block-by-block read, this
> simplifies the following things:
>
> - Remove the need for @iosize variable
>   Because we just use sectorsize as our increment.
>
> - Remove @pg_offset, and calculate it inside the loop when needed
>   It's just offset_in_folio().
>
> - Use a for() loop instead of a while() loop
>
> This will slightly reduce the read performance for subpage cases, but for
> the future where we need to skip already uptodate blocks, it should still
> be worthy.
>
> For block size =3D=3D page size, this brings no performance change.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/extent_io.c | 38 ++++++++++++--------------------------
>  1 file changed, 12 insertions(+), 26 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 3968ecbb727d..2abf489e1a9b 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -942,14 +942,11 @@ static int btrfs_do_readpage(struct folio *folio, s=
truct extent_map **em_cached,
>         struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
>         u64 start =3D folio_pos(folio);
>         const u64 end =3D start + PAGE_SIZE - 1;
> -       u64 cur =3D start;
>         u64 extent_offset;
>         u64 last_byte =3D i_size_read(inode);
>         struct extent_map *em;
>         int ret =3D 0;
> -       size_t pg_offset =3D 0;
> -       size_t iosize;
> -       size_t blocksize =3D fs_info->sectorsize;
> +       const size_t blocksize =3D fs_info->sectorsize;
>
>         ret =3D set_folio_extent_mapped(folio);
>         if (ret < 0) {
> @@ -960,24 +957,23 @@ static int btrfs_do_readpage(struct folio *folio, s=
truct extent_map **em_cached,
>         if (folio_contains(folio, last_byte >> PAGE_SHIFT)) {
>                 size_t zero_offset =3D offset_in_folio(folio, last_byte);
>
> -               if (zero_offset) {
> -                       iosize =3D folio_size(folio) - zero_offset;
> -                       folio_zero_range(folio, zero_offset, iosize);
> -               }
> +               if (zero_offset)
> +                       folio_zero_range(folio, zero_offset,
> +                                        folio_size(folio) - zero_offset)=
;
>         }
>         bio_ctrl->end_io_func =3D end_bbio_data_read;
>         begin_folio_read(fs_info, folio);
> -       while (cur <=3D end) {
> +       for (u64 cur =3D start; cur <=3D end; cur +=3D blocksize) {
>                 enum btrfs_compression_type compress_type =3D BTRFS_COMPR=
ESS_NONE;
> +               unsigned long pg_offset =3D offset_in_folio(folio, cur);
>                 bool force_bio_submit =3D false;
>                 u64 disk_bytenr;
>                 u64 block_start;
>
>                 ASSERT(IS_ALIGNED(cur, fs_info->sectorsize));
>                 if (cur >=3D last_byte) {
> -                       iosize =3D folio_size(folio) - pg_offset;
> -                       folio_zero_range(folio, pg_offset, iosize);
> -                       end_folio_read(folio, true, cur, iosize);
> +                       folio_zero_range(folio, pg_offset, end - cur + 1)=
;
> +                       end_folio_read(folio, true, cur, end - cur + 1);
>                         break;
>                 }
>                 em =3D get_extent_map(BTRFS_I(inode), folio, cur, end - c=
ur + 1, em_cached);
> @@ -991,8 +987,6 @@ static int btrfs_do_readpage(struct folio *folio, str=
uct extent_map **em_cached,
>
>                 compress_type =3D extent_map_compression(em);
>
> -               iosize =3D min(extent_map_end(em) - cur, end - cur + 1);
> -               iosize =3D ALIGN(iosize, blocksize);
>                 if (compress_type !=3D BTRFS_COMPRESS_NONE)
>                         disk_bytenr =3D em->disk_bytenr;
>                 else
> @@ -1050,18 +1044,13 @@ static int btrfs_do_readpage(struct folio *folio,=
 struct extent_map **em_cached,
>
>                 /* we've found a hole, just zero and go on */
>                 if (block_start =3D=3D EXTENT_MAP_HOLE) {
> -                       folio_zero_range(folio, pg_offset, iosize);
> -
> -                       end_folio_read(folio, true, cur, iosize);
> -                       cur =3D cur + iosize;
> -                       pg_offset +=3D iosize;
> +                       folio_zero_range(folio, pg_offset, blocksize);
> +                       end_folio_read(folio, true, cur, blocksize);
>                         continue;
>                 }
>                 /* the get_extent function already copied into the folio =
*/
>                 if (block_start =3D=3D EXTENT_MAP_INLINE) {
> -                       end_folio_read(folio, true, cur, iosize);
> -                       cur =3D cur + iosize;
> -                       pg_offset +=3D iosize;
> +                       end_folio_read(folio, true, cur, blocksize);
>                         continue;
>                 }
>
> @@ -1072,12 +1061,9 @@ static int btrfs_do_readpage(struct folio *folio, =
struct extent_map **em_cached,
>
>                 if (force_bio_submit)
>                         submit_one_bio(bio_ctrl);
> -               submit_extent_folio(bio_ctrl, disk_bytenr, folio, iosize,
> +               submit_extent_folio(bio_ctrl, disk_bytenr, folio, blocksi=
ze,
>                                     pg_offset);
> -               cur =3D cur + iosize;
> -               pg_offset +=3D iosize;
>         }
> -
>         return 0;
>  }
>
> --
> 2.48.1
>
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

