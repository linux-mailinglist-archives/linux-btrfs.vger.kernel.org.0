Return-Path: <linux-btrfs+bounces-4050-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B5A89D6FF
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 12:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4974B2861D8
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 10:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B43284FCE;
	Tue,  9 Apr 2024 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qoxqj3v8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEC87441A;
	Tue,  9 Apr 2024 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712658608; cv=none; b=QB1JJxSQQmyMgYoAC9u3aRaVNe/LK6mWeT3nJipBLzbBBkKNelIlIii6fixRNQCSxO4ICsa5X8AoTPP68qjDUI668LDD4azQm53B55a4ysOCNS1XmFPYI6bE7rewM8eenfNEsFchFbRiSl4QoN3W8INVM+JgEvis10G+zlUVVE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712658608; c=relaxed/simple;
	bh=1na2OPcbjVkMfnpKNFakytcG2eeZOeCtOBK4ia0Rqrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1pzsCUM0ZNuLR4jh3VAOjthdw5ur2HiFFidX+4NEZYcrJrGhD3qtOTsomopaJRhph8XImnbz0L/B3dVR9fj/5gmGfK2/3LwDHTwQp4Jc0KXG1vHvijtYV9NEupJj0UfX9eVkH8plBG5A8pCRdWa3WymSq54j8U0wTw1a6Aw2QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qoxqj3v8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C313C433F1;
	Tue,  9 Apr 2024 10:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712658608;
	bh=1na2OPcbjVkMfnpKNFakytcG2eeZOeCtOBK4ia0Rqrs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qoxqj3v8l9o8mvYbNu5mbdNXvkBcO/0TWhIpJKb75C9eqocSoHDuOeuRyHSem9QBV
	 x5FiYkD9Z+kNyTalYM1X2/qfcx+bQFhQXys7QmntGetg2E6ayZQmQ7lmAV+uFbhoPd
	 59x+LrL3XE2C2UxXvJ5r4G8Ji2ioUVHIHvnRu8ClDPiWwRaryiXVYcoDn9R+Y7HpFe
	 lEhLQOsbk/EpsbB/RuKWKFiG4OhyZ0qIdr8hjcpSZBJKRLCm7cUkntqAqx1JkZt7xx
	 MwW3bR/1JDki1KTaTztLhyV4+XRHawaTnwyj2g0ACrZ/MM8my0vohsQYzNkT3b1YWq
	 szUrYO3MqO73g==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso5403129a12.3;
        Tue, 09 Apr 2024 03:30:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWl8gr/Zl33dykdpLUAdg2cTOROIc1cuig8EklAeCM6+RcTfpmWPUSXlzKVdl3AXeqvS5lzrlz+ISdsJCjpgiHRse/mWSpJ
X-Gm-Message-State: AOJu0YxD2SEsw6SzHhNs4spa3kpcQGwfssTrTAKM3HtO55J/sA1sp3Qo
	P9noSLfNkSpaTsquR1kYBaskWx0qStPqDTcMCdHEwQCB9krt327cJvVhFQQ19H/vBrSjzWUjVL+
	cHliOrLh3intm838jepROYJP9eV4=
X-Google-Smtp-Source: AGHT+IHsmEjdjWVXb35P42/rrHd9VLOE3C2fBJlmIkW4J2tDfz60zAsEkJnzQEZqopTeiXDA4nDaEV+LsZuaWkmIH9A=
X-Received: by 2002:a17:907:9444:b0:a51:d70f:b5f2 with SMTP id
 dl4-20020a170907944400b00a51d70fb5f2mr4993820ejc.20.1712658606849; Tue, 09
 Apr 2024 03:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f6e36de0cc45247c30c645764f3ffe4f6a487007.1712621026.git.wqu@suse.com>
In-Reply-To: <f6e36de0cc45247c30c645764f3ffe4f6a487007.1712621026.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 9 Apr 2024 11:29:28 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6HV5JKfQLYUfRcJ98kMeJJXEeZhx7xWunNjhZF-QCasQ@mail.gmail.com>
Message-ID: <CAL3q7H6HV5JKfQLYUfRcJ98kMeJJXEeZhx7xWunNjhZF-QCasQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix wrong block_start calculation for btrfs_drop_extent_map_range()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 1:06=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> During my extent_map cleanup/refactor, with extra sanity checks,
> extent-map-tests::test_case_7() would not pass the checks.
>
> The problem is, after btrfs_drop_extent_map_range(), the resulted
> extent_map has a @block_start way too large.
> Meanwhile my btrfs_file_extent_item based members are returning a
> correct @disk_bytenr/@offset combination.
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
> This is a regression caused by commit c962098ca4af ("btrfs: fix
> incorrect splitting in btrfs_drop_extent_map_range"), which removed the
> @len update for pinned extents.
>
> [FIX]
> Fix it by avoiding using @start completely, and use @end - em->start
> instead, which @end is exclusive bytenr number.
>
> And update the test case to verify the @block_start to prevent such
> problem from happening.
>
> Thankfully this is not going to lead to any data corruption, as IO path
> does not utilize btrfs_drop_extent_map_range() with @skip_pinned set.
>
> So this fix is only here for the sake of consistency/correctness.
>
> CC: stable@vger.kernel.org # 6.5+
> Fixes: c962098ca4af ("btrfs: fix incorrect splitting in btrfs_drop_extent=
_map_range")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Remove the mention of possible corruption
>   Thankfully this bug does not affect IO path thus it's fine.
>
> - Explain why c962098ca4af is the cause
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
>         free_extent_map(em);

As pointed out before, please avoid such accidental and unrelated
changes like this.

With that fixed:

Reviewed-by: Filipe Manana <fdmanana@suse.com>


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

