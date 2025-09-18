Return-Path: <linux-btrfs+bounces-16928-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E448AB8452A
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 13:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A599D3BF8A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 11:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A235930102F;
	Thu, 18 Sep 2025 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiarqEh9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FCE13C8FF
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194390; cv=none; b=qS4YgDDr1BkKB9/Jmr8uda7p/yvgCc0Rq3XsizDMR/+nVMk7WmJZzwBJPcvvyhYoMUuGC79LTMmISdSofg7bCpWd6iFOLHI2ZxuJtYsuoiKErbXcag5Zu6oVnqz6XduMuhX0/CxcsSTou+Q/FrfDPsthgwZ3s58krhWl397qmTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194390; c=relaxed/simple;
	bh=58ZMBiztLWUBU3i5KuzjeteCmBUI4zr9/LXkBezAkdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcrgtDXgE8gUNNGMQvwsPSf3R0F4xv/hIro5hH0YQW3z34c0iaDwX0MjpqxClWx47RFUtfzFWXbBjzXXigDM2KvUvyblcRUgXvWQhc8E2u325Osv5eW5Hulo/O4oaDNpAJkHZLS0xqrrsVUTYkojPOHa3YWHrIhxe6a5H0aLE3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiarqEh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986AAC4CEE7
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 11:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758194389;
	bh=58ZMBiztLWUBU3i5KuzjeteCmBUI4zr9/LXkBezAkdo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IiarqEh97BDBYoOFnQNK7UpA69i/T+EA/tX6vgYD0z2HCx7EMv/t2WDHxAxbZxGQk
	 55aPPPP2tVGlK5k/eg+qRRuqNhneLcKNCigwpw50kH2X7CImfuXCv4d3UZmCqIERaE
	 gv0wwfUDnPxjvsVOrSa6Dge2IG2UUidrlWiIYwCg5WyDe0M5RErMvOwu4CFVqwjkKl
	 olF7GX4Fzj3sNCQL9wmuIwLPv6cYI7GKWEsHd1Pj9BmCymeK/GDrGn7J3AJm9u+Jz0
	 GPwmPHAFm6iQGre4g+QnbbmUoDrEqa+pZA4FoshfzZUExq0ePESBTMf50JJOcmkyzM
	 PRWqJdh9Yd7dQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b04b55d5a2cso144897966b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 04:19:49 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz4QHnv/X3NkYeC9d37wIHkh9rjwG7pPiJS97FK9ny3ndcm/aMT
	fqEAx6PeEFOMDJ4/Q8aoSaI7idxeoCLcd8eZ+o/P0F6rLyn9ZYWzDwsqTAknYe2K/l9B/alMoTL
	pGIEgesTG+cVhVkUWqT4OVA4myPROpXg=
X-Google-Smtp-Source: AGHT+IEzaFpg6ZH/WZu0Zr9q77+2zk31Vu8O5/N5z1ob2L9aX/aXkHW3j3/NrXTjZT3LDex3PNMAvlUKmVJtaIs9CjA=
X-Received: by 2002:a17:907:9444:b0:afe:b311:a274 with SMTP id
 a640c23a62f3a-b1bc106eff5mr630771666b.46.1758194388123; Thu, 18 Sep 2025
 04:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918110236.102931-1-wqu@suse.com>
In-Reply-To: <20250918110236.102931-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 18 Sep 2025 12:19:09 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4QR4J-=Qhdgr_J_eyGDKj04Zx9e3tAQMSQ5zfWdKzvwQ@mail.gmail.com>
X-Gm-Features: AS18NWDsySC-V1gOw-TcVxbukZ-Kj6SehIrQJ2aftxmosd6Xo3AplddxIyVPGNs
Message-ID: <CAL3q7H4QR4J-=Qhdgr_J_eyGDKj04Zx9e3tAQMSQ5zfWdKzvwQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs/306: skip the run if block size is not 4K
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 12:03=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [FALSE ALERT]
> When running btrfs with block size larger than 4K (e.g. 8K in this
> case), the test case will fail like this:
>
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc4-custom+ #287 SMP PREEMP=
T_DYNAMIC Thu Sep 18 16:42:54 ACST 2025
> MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
> MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
>
> btrfs/306 1s ... - output mismatch (see /home/adam/xfstests/results//btrf=
s/306.out.bad)
>     --- tests/btrfs/306.out     2024-07-15 16:17:42.639999997 +0930
>     +++ /home/adam/xfstests/results//btrfs/306.out.bad  2025-09-18 18:44:=
16.075000000 +0930
>     @@ -14,7 +14,7 @@
>      chunk uuid <UUID>
>         item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>                         stripe 0 devid 1 physical XXXXXXXXX
>     -   item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>     +   item 1 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 16
>                         stripe 0 devid 2 physical XXXXXXXXX
>      total bytes XXXXXXXX
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/btrfs/306.out /home/adam/xfst=
ests/results//btrfs/306.out.bad'  to see the entire diff)
>
> In the above case it's the experimental support of block size larger
> than page size.
> The feature is still under development.
>
> [CAUSE]
> That test case requires 4K block size, but it has no way to control
> that, as QA runners can specify MKFS_OPTIONS=3D"-s 8k", to override the
> default block size.
>
> Normally this is impossible as on x86_64 the only supported block size is
> 4K, already the minimal block size of btrfs. So there is no way to use
> other block size in that test case.
>
> However with the experiemental bs > ps support, even on x86_64 it's

type in experimental

> possible to use 8K block size, and that breaks the 4K block size
> assumption of the test case.
>
> [FIX]
> Add a quick scratch mkfs, and grab the block size of the resulted fs.

resulted -> resulting

> If the block size is not 4K, skip the run.
>
> Since we're here, also remove the page size check, since we have subpage
> block size support for a while, and replace it with a more accurate
> supported sectorsize check.
>
> This more accurate sectorsize support now allows aarch64 (64K page size)
> to run btrfs/306 successfully, improving the subpage bs support coverage.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/306 | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/306 b/tests/btrfs/306
> index b47c446b..879f67b4 100755
> --- a/tests/btrfs/306
> +++ b/tests/btrfs/306
> @@ -21,8 +21,13 @@ _require_btrfs_fs_feature "raid_stripe_tree"
>  _require_btrfs_fs_feature "free_space_tree"
>  _require_btrfs_free_space_tree
>  _require_btrfs_no_compress
> +_require_btrfs_support_sectorsize 4096
>
> -test $(_get_page_size) -eq 4096 || _notrun "this tests requires 4k pages=
ize"
> +_scratch_mkfs >> /dev/null
> +blksz=3D$(_scratch_btrfs_sectorsize)
> +if [ $blksz -ne 4096 ]; then
> +       _notrun "this tests require blocksize 4096, has $blksz"
> +fi

should be "this test requires a block size of 4096 bytes, have $blocksize"

So at least 3 of the raid stripe tree tests, from btrfs/304,305,306
require the same exact fix, why not combine all the fixes in a single
patch?
You've sent patches for the other two that do exactly the same.

Thanks.

>
>  test_4k_write_64koff()
>  {

> --
> 2.51.0
>
>

