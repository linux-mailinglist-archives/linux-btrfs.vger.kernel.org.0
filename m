Return-Path: <linux-btrfs+bounces-11786-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69F7A44956
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 19:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A283B765D
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 17:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BB019AD90;
	Tue, 25 Feb 2025 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+G8s7Cb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727552AF1E
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506187; cv=none; b=FdqLGNIGYz2KFkQvC7cH23NcW9QKCrEn3rZ3Dgk8tgWLIDE5l1G9GnMLI4txXbRwANwGbwmlAowL+Ar3PqDqnEOyUrvbU1gj6E2yzY0VqYGMTnF0ewpz6/WyypZ6BFBrbJdvwsMMWQftlFbAPpwTyMl2bwWxZQeh+eV1wZTlk3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506187; c=relaxed/simple;
	bh=vSHtO7XIInovsbRej0YQMNLgOMlbzT+JNGgxCeIVba4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJboXS1JkF1QhDhgwf7mfeVyIEpGgszMPt9aQ1noYggcGN/0jw8eOznf/pcE04A+8s/zqEW4lk2zBDilKKU8x0xK2ewXzTXxeWge9bEWVetjSazB7/LAagNmGks+QNSeNSjsp/JECBhQb9/aEmCnNDYOTVwPQ0sjQZ4V0Zh7eNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+G8s7Cb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62A2C4CEDD
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 17:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740506186;
	bh=vSHtO7XIInovsbRej0YQMNLgOMlbzT+JNGgxCeIVba4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d+G8s7CbRuPjbRQ0xSOjHj0kVF40ICsocs6zkHrWkeVxctGzA5X4O5d9zhDqPjShs
	 NfAOTG04HwG1mZAZinXrG2M445zj7PiCHdZDkdA+cGOCOhvdPnbUVTBIKvb2eTpYl5
	 DnBq1DjWMM1xOVaFTw4m1pecTH9EJ5rkx5HhQTjUYBPVu3cepRIcM8NCBcje6mqqMJ
	 fiuo1DruqEJlCfolcFZLIKkEo9WTyyc/gx5MlolNdi3bfMmf6YTLL9SaEyD/EQrmKN
	 wwgHuBAiEM2X5QMVRcmF/Wy4ijvIvVUXDIETK+XMm9TNg530tuRsfFro0hJZrtmJui
	 k1YCR9SZaPeOg==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abb86beea8cso1057484966b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 09:56:26 -0800 (PST)
X-Gm-Message-State: AOJu0YxSw5A4NyNXxchfoRlZlWnsrQwcuR3nmttkCuUIwqc3x32t2bTG
	V5M0MsfnLK+Xgn03rz4axgJp07YmkJgmMrCqVIwHwoYax5puPLLVjwxw8WICVV6mrQq1pFyiuAX
	hwHrWCU81+EH/D7PZL8JMmMUpMcM=
X-Google-Smtp-Source: AGHT+IHMcQtdAV+dYtizs5z+23QwmYOxHDjvLqljTUW34MIz306ICYObeDj6FdBbhG1eKN1PVaAob6Fsdw3EoCj62fI=
X-Received: by 2002:a17:907:3d89:b0:ab7:e41d:34b6 with SMTP id
 a640c23a62f3a-abeeedfd090mr9950066b.28.1740506185414; Tue, 25 Feb 2025
 09:56:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740354271.git.wqu@suse.com> <c496e3bdc3be2d828684c5536800d6a6554afa5a.1740354271.git.wqu@suse.com>
In-Reply-To: <c496e3bdc3be2d828684c5536800d6a6554afa5a.1740354271.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 25 Feb 2025 17:55:48 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7dOsKqYAKvZdzOoe4DZNJ28P2neBDopme=dFYT-PNn6g@mail.gmail.com>
X-Gm-Features: AWEUYZkW54cY3A6p9BMxajzQ87xbk47RLYWBa5G8ftkk8cDUPS3A3xNl1RZxfhs
Message-ID: <CAL3q7H7dOsKqYAKvZdzOoe4DZNJ28P2neBDopme=dFYT-PNn6g@mail.gmail.com>
Subject: Re: [PATCH 5/7] btrfs: allow buffered write to avoid full page read
 if it's block aligned
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:47=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Since the support of block size (sector size) < page size for btrfs,
> test case generic/563 fails with 4K block size and 64K page size:
>
>     --- tests/generic/563.out   2024-04-25 18:13:45.178550333 +0930
>     +++ /home/adam/xfstests-dev/results//generic/563.out.bad    2024-09-3=
0 09:09:16.155312379 +0930
>     @@ -3,7 +3,8 @@
>      read is in range
>      write is in range
>      write -> read/write
>     -read is in range
>     +read has value of 8388608
>     +read is NOT in range -33792 .. 33792
>      write is in range
>     ...
>
> [CAUSE]
> The test case creates a 8MiB file, then buffered write into the 8MiB
> using 4K block size, to overwrite the whole file.
>
> On 4K page sized systems, since the write range covers the full block and
> page, btrfs will no bother reading the page, just like what XFS and EXT4
> do.
>
> But 64K page sized systems, although the 4K sized write is still block
> aligned, it's not page aligned any more, thus btrfs will read the full
> page, causing more read than expected and fail the test case.

This part "causing more read than expected" got me puzzled, but it's explai=
ned
in the "Fix" section below. It's more like "causing previously dirty
blocks within the page to be zeroed out".

>
> [FIX]
> To skip the full page read, we need to do the following modification:
>
> - Do not trigger full page read as long as the buffered write is block
>   aligned
>   This is pretty simple by modifying the check inside
>   prepare_uptodate_page().
>
> - Skip already uptodate blocks during full page read
>   Or we can lead to the following data corruption:
>
>   0       32K        64K
>   |///////|          |
>
>   Where the file range [0, 32K) is dirtied by buffered write, the
>   remaining range [32K, 64K) is not.
>
>   When reading the full page, since [0,32K) is only dirtied but not
>   written back, there is no data extent map for it, but a hole covering
>   [0, 64k).
>
>   If we continue reading the full page range [0, 64K), the dirtied range
>   will be filled with 0 (since there is only a hole covering the whole
>   range).
>   This causes the dirtied range to get lost.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/extent_io.c | 4 ++++
>  fs/btrfs/file.c      | 5 +++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index b3a4a94212c9..d7240e295bfc 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -977,6 +977,10 @@ static int btrfs_do_readpage(struct folio *folio, st=
ruct extent_map **em_cached,
>                         end_folio_read(folio, true, cur, end - cur + 1);
>                         break;
>                 }
> +               if (btrfs_folio_test_uptodate(fs_info, folio, cur, blocks=
ize)) {
> +                       end_folio_read(folio, true, cur, blocksize);
> +                       continue;
> +               }
>                 em =3D get_extent_map(BTRFS_I(inode), folio, cur, end - c=
ur + 1, em_cached);
>                 if (IS_ERR(em)) {
>                         end_folio_read(folio, false, cur, end + 1 - cur);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 00c68b7b2206..e3d63192281d 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -804,14 +804,15 @@ static int prepare_uptodate_folio(struct inode *ino=
de, struct folio *folio, u64
>  {
>         u64 clamp_start =3D max_t(u64, pos, folio_pos(folio));
>         u64 clamp_end =3D min_t(u64, pos + len, folio_pos(folio) + folio_=
size(folio));
> +       const u32 sectorsize =3D inode_to_fs_info(inode)->sectorsize;
>         int ret =3D 0;
>
>         if (folio_test_uptodate(folio))
>                 return 0;
>
>         if (!force_uptodate &&
> -           IS_ALIGNED(clamp_start, PAGE_SIZE) &&
> -           IS_ALIGNED(clamp_end, PAGE_SIZE))
> +           IS_ALIGNED(clamp_start, sectorsize) &&
> +           IS_ALIGNED(clamp_end, sectorsize))
>                 return 0;
>
>         ret =3D btrfs_read_folio(NULL, folio);
> --
> 2.48.1
>
>

