Return-Path: <linux-btrfs+bounces-5988-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1E1917EDB
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 12:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB291C20B6D
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 10:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3603181CF7;
	Wed, 26 Jun 2024 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGeb7LTR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E762F181BB8;
	Wed, 26 Jun 2024 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398963; cv=none; b=dtwWUnL7yEinrtWrU702ODucY/I0hKwvA0eSnWvlL7r96CkXxlDEionj2jpfJ2EeZzIV0hFSvqk325zCi2i4azoV+whCXmMOg06dxosHRveOSIAtjEO0DI3S3iDS+8wcdVHzLNzQ9ZeEShbxZiM7Q3qg0LdZahKf1VWYC85iuns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398963; c=relaxed/simple;
	bh=LF+V/YGvNyhi6W1Q8K48YhxFw5P+05yaDiJQ3on2hCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=drgTrY6OCMx0ZvFYNYuFz/0OKk3nHip5U2HngHz0l9CSvvxe+lPqGjzVj2TuMXa3YZ1h+pjY4QCnA3DUd/YV12+zQgEF2/Jm9L+zl92zGdlh0BaJxhViqI7g/r5N+giMWycRJJUtjdIGNMnjn4c6eUZ3YEA9fsOfMW7hUpxK8B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGeb7LTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF7EC32789;
	Wed, 26 Jun 2024 10:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719398962;
	bh=LF+V/YGvNyhi6W1Q8K48YhxFw5P+05yaDiJQ3on2hCg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gGeb7LTRK+Sy61ygjpRWpFUJP3n3pd2vBAtVlkuGjoFbbVSRSsDcxA2+jGGB4jEwQ
	 IRPx8KuGSG2mjC5GBG7ZkTxBAN840r9OxOnYrH2OJUMycsTD1u+/AxTO7jrRPT6VFQ
	 IEOCdT77AgCF+WFgGjN3+xmeADz3xdwRt1abJ/PGamontinqsiKH+FxYh0e+cVV+Fa
	 YMjQBCSYKhn5PCQaqf2Vir/qZ4j4PrYir3dLgWKjrBDUgnD7m/O63ol+QUViky9w1R
	 9jh8hKSjUaGef8EGFLkQhDTMnUnfSOfKLlZq9KIFeO39YBTNy/9D6w27iUikhwzkWv
	 ejub5egT4BadA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee6eso70683a12.1;
        Wed, 26 Jun 2024 03:49:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX4E3OzZchlKcbjZDTsIzQ4hthszCQlZ2ZVEW0o8xbm7x0pA9UJ4mIo1hsL3hsIcFgq5iGWnOcCQeh2FmR357lCDMLAD/creVtvIqc=
X-Gm-Message-State: AOJu0YyUEPdSRUJozj8omqv3TJ0mU3IAQc2n1Yxwx5MIkCdnc7jScih9
	IL/SO+mR/Wu8rtKqcMZQiinMNJRGST8FvFaXjnV6ENz7WA5wwQ1ZmQ8kUxO2qGhuFVW8qoE+qWg
	vftDIAMBRYpffbFbYZxav4aTxrwE=
X-Google-Smtp-Source: AGHT+IGf02sUk1R5VoUyhOJIJYA/N64Dho19OyqmfhLr+JY5KDzh6lEXiqS21ilAavBwhCqvfz+saZavIx6wmKimVkw=
X-Received: by 2002:a17:907:c788:b0:a6f:996f:23ea with SMTP id
 a640c23a62f3a-a727fbd5c81mr238458466b.15.1719398961026; Wed, 26 Jun 2024
 03:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs+A@mail.gmail.com>
In-Reply-To: <CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs+A@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 26 Jun 2024 11:48:44 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4yBx7EAwTWWRboK78nhCbzy1YnXGYVsazWs+VxNYDBmA@mail.gmail.com>
Message-ID: <CAL3q7H4yBx7EAwTWWRboK78nhCbzy1YnXGYVsazWs+VxNYDBmA@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 10:04=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi,
> after f1d97e769152 I spotted increased execution time of the kswapd0
> process and symptoms as if there is not enough memory.
> Very often I see that kswapd0 consumes 100% CPU [1].
> Before f1d97e769152 after an hour kswapd0 is working ~3:51 and after
> three hours ~10:13 time.
> After f1d97e769152 kswapd0 time increased to ~25:48 after the first
> hour and three hours it hit 71:01 time.
> So execution time has increased by 6-7 times.
>
> f1d97e76915285013037c487d9513ab763005286 is the first bad commit
> commit f1d97e76915285013037c487d9513ab763005286 (HEAD)
> Author: Filipe Manana <fdmanana@suse.com>
> Date:   Fri Mar 22 18:02:59 2024 +0000
>
>     btrfs: add a global per cpu counter to track number of used extent ma=
ps
>
>     Add a per cpu counter that tracks the total number of extent maps tha=
t are
>     in extent trees of inodes that belong to fs trees. This is going to b=
e
>     used in an upcoming change that adds a shrinker for extent maps. Only
>     extent maps for fs trees are considered, because for special trees su=
ch as
>     the data relocation tree we don't want to evict their extent maps whi=
ch
>     are critical for the relocation to work, and since those are limited,=
 it's
>     not a concern to have them in memory during the relocation of a block
>     group. Another case are extent maps for free space cache inodes, whic=
h
>     must always remain in memory, but those are limited (there's only one=
 per
>     free space cache inode, which means one per block group).
>
>     Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>     Signed-off-by: Filipe Manana <fdmanana@suse.com>
>     Reviewed-by: David Sterba <dsterba@suse.com>
>     Signed-off-by: David Sterba <dsterba@suse.com>
>
>  fs/btrfs/disk-io.c    |  9 +++++++++
>  fs/btrfs/extent_map.c | 17 +++++++++++++++++
>  fs/btrfs/fs.h         |  2 ++
>  3 files changed, 28 insertions(+)
>
> Unfortunately I can't check the revert commit f1d97e769152 because of con=
flicts.

Yes, because there are follow up commits that depend on it.

I seriously doubt that this is correctly bisected, because that commit
only adds a counter for tracking the number of extent maps.
It's using a per cpu counter and I can't think of anything more
efficient than that.

The commit that adds the extent map shrinker, which is the next commit
(956a17d9d050761e34ae6f2624e9c1ce456de204), that can
explain what you are observing.

Now the one you bisected doesn't make sense, not just because it's
just a counter update but also because you are
only seeing the kswapd0 slowdown, which is what triggers the shrinker.

The shrinker itself can be improved, there's one place where I know it
might loop too much, and I'll improve that.

Thanks.

>
> > git reset --hard v6.10-rc1
> HEAD is now at 1613e604df0c Linux 6.10-rc1
>
> > git revert -n f1d97e76915285013037c487d9513ab763005286
> Auto-merging fs/btrfs/disk-io.c
> Auto-merging fs/btrfs/extent_map.c
> Auto-merging fs/btrfs/fs.h
> CONFLICT (content): Merge conflict in fs/btrfs/fs.h
> error: could not revert f1d97e769152... btrfs: add a global per cpu
> counter to track number of used extent maps
>
> However I double checked every bisect step and I am confident in the
> correctness of the result.
>
> I also attach here a full kernel log and build config.
>
> My hardware specs: https://linux-hardware.org/?probe=3Dd377acdb9e
>
> Filipe can you look into this please?
>
> [1] https://postimg.cc/Xrn6qfxh
>
> --
> Best Regards,
> Mike Gavrilov.

