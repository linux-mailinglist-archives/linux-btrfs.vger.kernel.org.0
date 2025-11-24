Return-Path: <linux-btrfs+bounces-19291-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35634C80A04
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 14:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B731344043
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 13:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E0D302142;
	Mon, 24 Nov 2025 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAyRZQ8o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FB42FD664
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763989221; cv=none; b=nmis7LYoAdNOVOeJBYQ5GagdceQ10ZF/AGoNcIVxfnxzVFcSFXsH8KSAtRZ/xYWbreKLrq/XZhVP2GJ6XkvJjSQd5amnqLvxMhnB5FbQlYv3Eh1Vxp5PgHeWp2omuJh5raNUQ0yV/fmwbenkoDUCQ75dYlGcEWhC75L0AydvGFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763989221; c=relaxed/simple;
	bh=2FBUuo2hKHvJ8NQnsdqVQJfpHzs3rJPOXMw3mZJHybs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YiozlU1NxcBVNNHIdDS2H1c9/SVDa+QthlX6Ssp6bN3h0ymTCVL5weA9qGqENPAeTDBP2ysET34BJv984nAqrUotabJ77HYawx3v116TNRl2+KKCpzoaGZsrHakmV+lcMAe3tRmU5g+z3x0ILtfZghaKwiGKYnZYftsaRjPitqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAyRZQ8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B283FC4CEFB
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 13:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763989220;
	bh=2FBUuo2hKHvJ8NQnsdqVQJfpHzs3rJPOXMw3mZJHybs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aAyRZQ8oSZYnboDRxKBsbi/w1HGQ9kI3rQpd7keXJm+kg/QNibBqGXNnQFWIZVqP+
	 jg3KqSnZGdB/rhyACbp9OS/1A6nTIgWPZfA0C2xCO0n4cPKJGupG8/iW0oQRne69rc
	 YYprNcaiP71MzDnR6CBV9QTxL8UFjYK24bKZx5rmGTs49fdl6L+NbcVnW04SpaJ8N3
	 Z+CKoDpdWMxQM7yVcd14wE0neB1y7Z6bpSyvK5Cpw5eq9u7qwGgP5b0Wh+x/reunp+
	 N0DZy03+7HAy5nkNb8kE7pwkD3l8rnwglFlMIIBqZUP36IxfDkPVonamX0uXur43I8
	 rEDw6fwzIb3fQ==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b737c6c13e1so224594566b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 05:00:20 -0800 (PST)
X-Gm-Message-State: AOJu0YzWq673rGgRgJs4pulsPz1X7QmvEq4CiT3hOnVe6dRUx+pDS2iO
	eU0opCc0xMNG5OvKDzzN7+P6b301ZyTmaigFz1W0r4rBipNnlqdiRt+G/zMIgJzx3zRZJLj2Zj/
	5ZlJ1FEM0l2TMjUSVCgm0pmz4N0zLoKg=
X-Google-Smtp-Source: AGHT+IGlrswMJjQ5gg6lcfYBfcmY0KOrig6JiVA9KX6yebBsdSx0lzE4RqTjcCicinSxy/mr846pPVVC7u7wo2J88jU=
X-Received: by 2002:a17:906:99c3:b0:b74:984c:a92e with SMTP id
 a640c23a62f3a-b767152309fmr1228281066b.3.1763989219243; Mon, 24 Nov 2025
 05:00:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763939785.git.wqu@suse.com> <8f8e8639c8b7cdde04d0930017a2f354f33c82d4.1763939785.git.wqu@suse.com>
In-Reply-To: <8f8e8639c8b7cdde04d0930017a2f354f33c82d4.1763939785.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 24 Nov 2025 12:59:42 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5x+t_P=CoxcvmNLr8YKM-pUF3mAUiZBUkdRN3oN+273A@mail.gmail.com>
X-Gm-Features: AWmQ_bkNo6dEp8ahQ9QOAbmK5x-dBc_CCxUkm5uK7yqkDe0fnu0_pFj6XiR1SII
Message-ID: <CAL3q7H5x+t_P=CoxcvmNLr8YKM-pUF3mAUiZBUkdRN3oN+273A@mail.gmail.com>
Subject: Re: [PATCH 1/3] btrfs: return the largest hole between two file
 extent items
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2025 at 11:32=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [CORNER CASE]
> If we have the following file extents layout, btrfs_get_extent() can
> return a smaller hole and cause unnecessary extra tree search:
>
>         item 6 key (257 EXTENT_DATA 0) itemoff 15810 itemsize 53
>                 generation 9 type 1 (regular)
>                 extent data disk byte 13631488 nr 4096
>                 extent data offset 0 nr 4096 ram 4096
>                 extent compression 0 (none)
>
>         item 7 key (257 EXTENT_DATA 32768) itemoff 15757 itemsize 53
>                 generation 9 type 1 (regular)
>                 extent data disk byte 13635584 nr 4096
>                 extent data offset 0 nr 4096 ram 4096
>                 extent compression 0 (none)
>
> In above case, range [0, 4K) and [32K, 36K) are regular extents, and
> there is a hole in range [4K, 32K), and the fs has "no-holes" feature,
> meaning the hole will not have a file extent item.
>
> [INEFFICIENCY]
> Assume the system has 4K page size, and we're doing readahead for range
> [4K, 32K), no large folio yet.
>
>  btrfs_readahead() for range [4K, 32K)
>  |- btrfs_do_readpage() for folio 4K
>  |  |- get_extent_map() for range [4K, 8K)
>  |     |- btrfs_get_extent() for range [4K, 8K)
>  |        We hit item 6, then for the next item 7.
>  |        At this stage we know range [4K, 32K) is a hole.
>  |        But our search range is only [4K, 8K), not reaching 32K, thus
>  |        we go into not_found: tag, returning a hole em for [4K, 8K).
>  |
>  |- btrfs_do_readpage() for folio 8K
>  |  |- get_extent_map() for range [8K, 12K)
>  |     |- btrfs_get_extent() for range [8K, 12K)
>  |        We hit the same item 6, and then item 7.
>  |        But still we goto not_found tag, inserting a new hole em,
>  |        which will be merged with previous one.
>  |
>  | [ Repeat the same btrfs_get_extent() calls until the end ]
>
> So we're calling btrfs_get_extent() again and again, just for a
> different part of the same hole range [4K, 32K).
>
> [ENHANCEMENT]
> The problem is inside the next: tag, where if we find the next file exten=
t
> item and knows it's beyond our search range start.
>
> But there is no need to fallback to not_found: tag, if we know there is
> a larger hole for [start, found_key.offset).
>
> By removing the check for (start + len) against (found_key.offset), we ca=
n
> improve the above read loop by:
>
>  btrfs_readahead()
>  btrfs_readahead() for range [4K, 32K)
>  |- btrfs_do_readpage() for folio 4K
>  |  |- get_extent_map() for range [4K, 8K)
>  |     |- btrfs_get_extent() for range [4K, 8K)
>  |        We hit item 6, then for the next item 7.
>  |        At this stage we know range [4K, 32K) is a hole.
>  |        So the hole em for range [4K, 32K) is returned.
>  |
>  |- btrfs_do_readpage() for folio 8K
>  |  |- get_extent_map() for range [8K, 12K)
>  |     The cached hole em range [4K, 32K) covers the range,
>  |     and reuse that em.
>  |
>  | [ Repeat the same btrfs_get_extent() calls until the end ]
>
> Now we only call btrfs_get_extent() once for the whole range [4K, 32K),
> other than the old 8 times.
>
> Although again I do not expect much difference for the real world
> performance.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 3cf30abcdb08..3a76cea1d43d 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7181,8 +7181,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_in=
ode *inode,
>                 if (found_key.objectid !=3D objectid ||
>                     found_key.type !=3D BTRFS_EXTENT_DATA_KEY)
>                         goto not_found;
> -               if (start + len <=3D found_key.offset)
> -                       goto not_found;

Your point about the inefficiency for the readahead case is valid, but
this may be dangerous in other contexts.

If a caller of btrfs_get_extent() passes a specific length, it may
mean it has locked the range in the inode's io tree only for that
range.
For the readahead case, the caller has typically locked a larger range
in the io tree - except when attempting to read the last page/folio
for the readahead range and there's hole that crosses that limit.

By allowing to return an extent map for a larger range:

1) We can now return a stale extent map.
     After the path is released in btrfs_get_extent(), another task
may insert a new file extent item (such as a direct IO task).

2) While another task adds the new file extent item, it will also trim
the hole extent map created by the task that has just finished calling
btrfs_get_extent().
    The trimming (typically done in btrfs_drop_extent_map_range())
means updating the extent map's length, start fields, etc, while the
task that just called btrfs_get_extent() is using it, causing a race
with unpredictable results.

We've had problems of this sort in the past.
It's a bad idea for a task to create extent maps beyond the range it
has locked in the inode's io tree.

Thanks.


>                 if (start > found_key.offset)
>                         goto next;
>
> --
> 2.52.0
>
>

