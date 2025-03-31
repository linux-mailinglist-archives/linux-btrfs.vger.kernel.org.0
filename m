Return-Path: <linux-btrfs+bounces-12685-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC81A764E7
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 13:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A051888C38
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 11:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60B81DF747;
	Mon, 31 Mar 2025 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edm34ntE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388BB13A265
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743420337; cv=none; b=GN6omNgiVZgmOBRqexRxVrXblyv7pGt8qeHgc3WNHq7yunGrscravaxSyQDSY5F4DVu3x++LOTz4qxXV3rG8dVO5ysMIASZLLMU/49IiD7DA0Wkbdj9Dp6csA0d+RLICQy6te5TzD2PgiwjZBwrSIyID59kN6IPpkVs5hIQJctU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743420337; c=relaxed/simple;
	bh=+Yj1AeVPHgvZbN4E90Wf4q6u2nVbck+gTCLwyVtwHjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIYz37xqmrcoB7HBqvyzK70kpZdlBEcMmw7pKJAPi2qiXW9TyVWFNKrrtERXZSUFW1F/4j7ydybpDxHxzx037z3qLN8LRNmxI3wUc/5jRiCFXyUhQAI4dFqbK15uDKlsVEjjbB7Q4/hUhwYlpYVLX1OpEqQevIk1cID8TXsYbGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edm34ntE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB7AC4CEE3
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 11:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743420336;
	bh=+Yj1AeVPHgvZbN4E90Wf4q6u2nVbck+gTCLwyVtwHjA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=edm34ntEh0RllncsvQt4aYk2HDwjLnJ7BIDrhS0cwlP41PtNUzLo3hzXn5JYVhmGF
	 n9UiJYm/NlWIRf8YvymtLXUnGuSLhrpWAPvRCwiy5+bnWcfeRvljJ7ggkd2UdIwVrp
	 HDXugQ0FjUUvKDVxTj/TfXgBrXqdMMQM3AHCeCStHYAXZgkOpPFw6CvznwvjV5pUNe
	 S0MH+vpMcOsJxDUQOfUT9x7adKvlo1S6iGCkRv/UjjiOJe8CDD4nFx4o4PzDOnDdh1
	 y5FlWoYk8nqrbxjxfXV+22Z6O9mo1Fo4oMGCFeL3nEgUDxWnVza1/zBlDk5eebJb2q
	 B1xIWAorXabjg==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so644448066b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 04:25:36 -0700 (PDT)
X-Gm-Message-State: AOJu0YxiasDK6ovU4Zq6yIdHSAD5rRQChhVuRLAvSWITFxvmYlfkL+PK
	HOmSUzQbvveAu1W0kesbsFnqqneXQyGDAf7K3Mvqy+FKDeIQG/1q3vRzgyWLsf9l/UzvIn/Fj4B
	xQ6Zd8MuqFLTEyWst8Luf/FC5I6E=
X-Google-Smtp-Source: AGHT+IG2I8bHfMrLnHPlFnztxs8x0cZ6w3VOd29wZNHUFfqLt1VzEwArLhnyzjr6KH4qnEXI/whm9Mqtx21CJ/U3jKg=
X-Received: by 2002:a17:907:7fac:b0:ac4:4d6:ea0a with SMTP id
 a640c23a62f3a-ac738a91226mr798080066b.27.1743420335242; Mon, 31 Mar 2025
 04:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743239672.git.wqu@suse.com> <21ee2b756ce8ad1dcf1b9ecdfec84f0b87c271f5.1743239672.git.wqu@suse.com>
In-Reply-To: <21ee2b756ce8ad1dcf1b9ecdfec84f0b87c271f5.1743239672.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 31 Mar 2025 11:24:58 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7_mLz1zTF5QMGf1XJnB+k1i0EA1RHC60a5H=xPPJujXg@mail.gmail.com>
X-Gm-Features: AQ5f1JptOSYpTW8rU5xEjRvx9ljwtj0bnTzcugCIxRBsPG8Vs7utggmOb3fzqY4
Message-ID: <CAL3q7H7_mLz1zTF5QMGf1XJnB+k1i0EA1RHC60a5H=xPPJujXg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] btrfs: avoid page_lockend underflow in btrfs_punch_hole_lock_range()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 29, 2025 at 9:20=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> When running btrfs/004 with 4K fs block size and 64K page size,
> sometimes fsstress workload can take 100% CPU for a while, but not long
> enough to trigger a 120s hang warning.
>
> [CAUSE]
> When such 100% CPU usage happens, btrfs_punch_hole_lock_range() is
> always in the call trace.
>
> With extra ftrace debugs, it shows something like this:
>
>    btrfs_punch_hole_lock_range: r/i=3D5/2745 start=3D4096(65536)

What's this r/i=3D5/2745?

Since this is from a custom tracepoint you made for debugging, I
suggest removing that part from the changelog.
It's not obvious (to me at least) what it is and it's not relevant to
understand the problem being fixed.

> end=3D20479(18446744073709551615) enter
>
> Where 4096 is the @lockstart parameter, 65536 is the rounded up
> @page_lockstart, 20479 is the @lockend parameter.
> So far so good.
>
> But the large number (u64)-1 is the @page_lockend, which is not correct.
>
> This is caused by the fact that round_down(locked + 1, PAGE_SIZE)
> results 0.
>
> In the above case, the range is inside the same page, and we do not even
> need to call filemap_range_has_page(), not to mention to call it with
> (u64)-1 as the end.
>
> This behavior will cause btrfs_punch_hole_lock_range() to busy loop
> waiting for irrelevant range to has its pages to be dropped.
>
> [FIX]
> Calculate @page_lockend by just rounding down @lockend, without
> decreasing the value by one.
> So @page_lockend will no longer overflow.
>
> Then exit early if @page_lockend is no larger than @page_lockestart.

@page_lockestart -> @page_lockstart


> As it means either the range is inside the same page, or the two pages
> are adjacent already.
>
> Finally only decrease @page_lockend when calling
> filemap_range_has_page().
>
> Fixes: 0528476b6ac7 ("btrfs: fix the filemap_range_has_page() call in btr=
fs_punch_hole_lock_range()")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

With those minor things fixed up, it looks good, thanks.

> ---
>  fs/btrfs/file.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 589d36f8de12..7c147ef9368d 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2126,15 +2126,20 @@ static void btrfs_punch_hole_lock_range(struct in=
ode *inode,
>          * will always return true.
>          * So here we need to do extra page alignment for
>          * filemap_range_has_page().
> +        *
> +        * And do not decrease page_lockend right now, as it can be 0.
>          */
>         const u64 page_lockstart =3D round_up(lockstart, PAGE_SIZE);
> -       const u64 page_lockend =3D round_down(lockend + 1, PAGE_SIZE) - 1=
;
> +       const u64 page_lockend =3D round_down(lockend + 1, PAGE_SIZE);
>
>         while (1) {
>                 truncate_pagecache_range(inode, lockstart, lockend);
>
>                 lock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
>                             cached_state);
> +               /* The same page or adjacent pages. */
> +               if (page_lockend <=3D page_lockstart)
> +                       break;
>                 /*
>                  * We can't have ordered extents in the range, nor dirty/=
writeback
>                  * pages, because we have locked the inode's VFS lock in =
exclusive
> @@ -2146,7 +2151,7 @@ static void btrfs_punch_hole_lock_range(struct inod=
e *inode,
>                  * we do, unlock the range and retry.
>                  */
>                 if (!filemap_range_has_page(inode->i_mapping, page_lockst=
art,
> -                                           page_lockend))
> +                                           page_lockend - 1))
>                         break;
>
>                 unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, locken=
d,
> --
> 2.49.0
>
>

