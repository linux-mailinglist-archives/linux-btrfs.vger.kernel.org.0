Return-Path: <linux-btrfs+bounces-4022-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9874C89BD7E
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 12:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3A5284176
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 10:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59B35FB99;
	Mon,  8 Apr 2024 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qD48FwAr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF92552F82;
	Mon,  8 Apr 2024 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712573335; cv=none; b=eY4aq+Qxe+xdziSxxOJskzzBZd5s3csqZPPAnThIxCe/xGzO80hru5I+Uk672cOjVWAsttfORqGtVS4JlPQfeog/GXVCYEcOW5Jx2s8Ld1XgSik3OMQMlmDzbYftSULsDfx2yR7sFRN95wzhm+/nRb6vsDBcZMyGXtjXgtD2HBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712573335; c=relaxed/simple;
	bh=elu5o2Nk651q4fO2eutWphweCyySROh9JXN2jH19ups=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pquqmcIgVI619Ft86A+F93KWhQoJz0twkVxkUrAQtLGnNsbW+v0Z2Z14ZmMGfS4VuSllfDwvKwz0WDaLIO9hZOd+Ow4ICBsz1uHaX0VRAcN05hU0g2CnFYaHJZy18tMR56Tv3hDDJF8EBcrSx/iia6ZnbZFTvDexkWAvizgiB3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qD48FwAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA558C43390;
	Mon,  8 Apr 2024 10:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712573334;
	bh=elu5o2Nk651q4fO2eutWphweCyySROh9JXN2jH19ups=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qD48FwArEE4ZztFPxCtH6g+UCtcepkOpPIJ7fjLU/nC32YvtTsfcQlKY9mno3XwQZ
	 8ywKvmkx3+unWW3UeZp3Ox3deI+/zwE76wxL3a4As8PU+rk/H9AoA9fGsn8p9WUWh+
	 HIPDsXbrUMMb08CkIcYQ9i01Gt30z411wZny21hluNLE4sOaLoRsSpPH12dapIhEX8
	 jLf7xEp8AZ6Q2XP96Xcvbp/fhK2SXtRDO/7EdsRd+kvqNgf4DGe5lp0KO1TuonabhY
	 1TRF67OZ9ZMpcT6afId8nDT9ZlnNPuWvF+jUE8oyv6RSSuce0yl08yYdVw7Lf2SH2b
	 GacGtG7jwucdg==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56dfb52d10cso4882979a12.2;
        Mon, 08 Apr 2024 03:48:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxGM99yZwBluKDApBHdkOZ2SpLwhS8+YYyRgQJSKHggVprjWv1GLCvWE1k1tji8EztbaA8E7yeiqWyuwAI+SqVes8GAAiV
X-Gm-Message-State: AOJu0YzG0n4oL2HQVy8XxVuUgwbQCw8kYXo3HUThtvIlsfC50fWvNcVZ
	CQREhJHEhaSOGgF1ueZF5wU7LgJEdj1hutkxxu301fBCXVugP0bntTXwzGgm2cX+JIx1VyG6ofG
	bPK0Vrzo0tPTrZ0y8sodK/NHlwHY=
X-Google-Smtp-Source: AGHT+IE8Mew/m2s02esaChCsHEu3qQCJodKBvLY9HEH9z12G22F2u+MSC7/SBJvyiyJxgKFPYimhxfdhS5HiDuVpiaw=
X-Received: by 2002:a17:907:3601:b0:a51:de8a:fe99 with SMTP id
 bk1-20020a170907360100b00a51de8afe99mr944935ejc.42.1712573333199; Mon, 08 Apr
 2024 03:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4240e179e2439dd1698798e2de79ec59990cbaa0.1712452660.git.wqu@suse.com>
In-Reply-To: <4240e179e2439dd1698798e2de79ec59990cbaa0.1712452660.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 8 Apr 2024 11:48:16 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6u_wa14tny7yFt0p6POoocnnAf4VHm9xBSioMtOYP66A@mail.gmail.com>
Message-ID: <CAL3q7H6u_wa14tny7yFt0p6POoocnnAf4VHm9xBSioMtOYP66A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix wrong block_start calculation for btrfs_drop_extent_map_range()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 2:18=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> During my extent_map cleanup/refactor, with more than too strict sanity
> checks, extent-map-tests::test_case_7() would crash my extent_map sanity
> checks.
>
> The problem is, after btrfs_drop_extent_map_range(), the resulted
> extent_map has a @block_start way too large.
> Meanwhile my btrfs_file_extent_item based members are returning a
> correct @disk_bytenr along with correct @offset.
>
> The extent map layout looks like this:
>
>      0        16K    32K       48K
>      | PINNED |      | Regular |
>
> The regular em at [32K, 48K) also has 32K @block_start.
>
> Then drop range [0, 36K), which should shrink the regular one to be
> [36K, 48K).
> However the @block_start is incorrect, we expect 32K + 4K, but got 52K.
>
> [CAUSE]
> Inside btrfs_drop_extent_map_range() function, if we hit an extent_map
> that covers the target range but is still beyond it, we need to split
> that extent map into half:
>
>         |<-- drop range -->|
>                  |<----- existing extent_map --->|
>
> And if the extent map is not compressed, we need to forward
> extent_map::block_start by the difference between the end of drop range
> and the extent map start.
>
> However in that particular case, the difference is calculated using
> (start + len - em->start).
>
> The problem is @start can be modified if the drop range covers any
> pinned extent.
>
> This leads to wrong calculation, and would be caught by my later
> extent_map sanity checks, which checks the em::block_start against
> btrfs_file_extent_item::disk_bytenr + btrfs_file_extent_item::offset.
>
> And unfortunately this is going to cause data corruption, as the
> splitted em is pointing an incorrect location, can cause either
> unexpected read error or wild writes.

It can't happen for either reads or writes actually.

As for writes, it can't happen because:

1) The issue only happens when skip_pinned is true, which is the only
case that adjusts the 'start' variable (parameter);

2) All IO paths pass false for the skip_pinned parameter, only
relocation passes true when replacing the bytenr in file extent items,
and the range it uses for btrfs_drop_extent_map_range() matches the
extent item's range, so it won't cover extent maps outside the range;

3) Extent maps for writes in progress are always pinned;

4) Before doing IO on a range we lock the range and wait for any
existing ordered extents in the range to complete, which results in
unpinning extent maps;

5) Extent maps for writes are created when running delalloc (or during
the write for direct IO), along with the ordered extent, and are
created as pinned.

With all these, I don't see how we can get a "wild write" or any
problem in a write path.

As for reads, it doesn't happen because of what's said in 2 regarding
the range passed to btrfs_drop_extent_map_range().

So as far as I can see, it's currently a harmless bug, and maybe it
always has been because the bad calculation has been there since 2008,
see below.
If it affected reads or writes, it would be easy to trigger with
fstests and fsx for example (fstests).

It's certainly a bug, it just doesn't have any consequences as far as
I can see, so the changelog should be updated.

>
> [FIX]
> Fix it by avoiding using @start completely, and use @end - em->start
> instead, which @end is exclusive bytenr number.
>
> And update the test case to verify the @block_start to prevent such
> problem from happening.
>
> CC: stable@vger.kernel.org # 6.7+
> Fixes: c962098ca4af ("btrfs: fix incorrect splitting in btrfs_drop_extent=
_map_range")

That commit doesn't influence how split->block_start is updated, only
split->start and split->len.
So I can't understand why you chose to blame that commit.

The bug was actually introduced in 2008 by the following commit:

3b951516ed70 ("Btrfs: Use the extent map cache to find the logical
disk block during data retries")
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D3b951516ed703af0f6d82053937655ad69b60864

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_map.c             | 2 +-
>  fs/btrfs/tests/extent-map-tests.c | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 471654cb65b0..955ce300e5a1 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -799,7 +799,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *=
inode, u64 start, u64 end,
>                                         split->block_len =3D em->block_le=
n;
>                                         split->orig_start =3D em->orig_st=
art;
>                                 } else {
> -                                       const u64 diff =3D start + len - =
em->start;
> +                                       const u64 diff =3D end - em->star=
t;
>
>                                         split->block_len =3D split->len;
>                                         split->block_start +=3D diff;
> diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-ma=
p-tests.c
> index 253cce7ffecf..80e71c5cb7ab 100644
> --- a/fs/btrfs/tests/extent-map-tests.c
> +++ b/fs/btrfs/tests/extent-map-tests.c
> @@ -818,7 +818,6 @@ static int test_case_7(struct btrfs_fs_info *fs_info)
>                 test_err("em->len is %llu, expected 16K", em->len);
>                 goto out;
>         }
> -

Please avoid such accidental changes.

Thanks.

>         free_extent_map(em);
>
>         read_lock(&em_tree->lock);
> @@ -847,6 +846,11 @@ static int test_case_7(struct btrfs_fs_info *fs_info=
)
>                 goto out;
>         }
>
> +       if (em->block_start !=3D SZ_32K + SZ_4K) {
> +               test_err("em->block_start is %llu, expected 36K", em->blo=
ck_start);
> +               goto out;
> +       }
> +
>         free_extent_map(em);
>
>         read_lock(&em_tree->lock);
> --
> 2.44.0
>
>

