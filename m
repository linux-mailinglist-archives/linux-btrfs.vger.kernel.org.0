Return-Path: <linux-btrfs+bounces-16926-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAF8B84505
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 13:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429DB3B0E18
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 11:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E334A2D59E3;
	Thu, 18 Sep 2025 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyYDfZKe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F03E2940B
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194228; cv=none; b=PmFGE0mcSLIkoT1QoAd6aweoIIgsT/FPr01D5xm/nTwwopITnTk6mL/NWCxW2ZG66IV9ipzlV1rDAlSYMvyKZBMPLiFwhXs6tA4wLVAiB4TKfMdulfbt81mByJnXoTJ42uaCk0XRfrCc3jtKQgYp7foJIbgxRi//iPIQtnAPnDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194228; c=relaxed/simple;
	bh=5Ey8q5bTSw+1dViSWTGCXQfGrsW8tONWhxwK5p2+RoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMrc0PZjYp9rZ3epW8DPMfZvXN08Wqoyu2WNj3u3YvBGbhLDlL0tDMjTfRAwA5ys6+Q//EeDkAFsHZD0cBEnWT4nIBDjh8zbBVBAKdYNh6HcZqH8Rvl47qawvGqtYoBrED7fGWJPUUgnSyzNgm0UFIg43i19pT7ZFGoSQW9oZkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyYDfZKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045FEC4CEE7
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 11:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758194228;
	bh=5Ey8q5bTSw+1dViSWTGCXQfGrsW8tONWhxwK5p2+RoQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NyYDfZKeM1YJLnfBAvDRgerSRkPfxC4LbNBfZJOYnJcGP8AkrYunbu48k7mtenFq9
	 QV6orRMyUgDWZe3CFGiS6K/4xgqmTn+RyqD0u4Nue7C3rpwJCgc9jqN9MkXV6zLCQr
	 l3oduCe7N0xTyVXGQBh7j+uBnRHs/lNoN54DsVBIW67/mIm43nAkl4eE/YYHDj/vnP
	 9nYYxFmkV92kMbRBQ4CpzBMYOWc3KoOly4WKmY9xYQEk4cV4xjzjGgcG1OQlvClPfS
	 Cly8Csf7xI9aG1DrzB9vr3FqwyAxiME7pah9erMgEGQwQr+6B+zUiJ/D8LvvZ13U7K
	 NMFSazOUiOa3w==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62f4273a404so3755116a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 04:17:07 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxn6k/EBXs9FzIRnFjLcddZA5ebssgt7JoZOjZtXx5Eozn/BzCW
	aqiBCDYCQZA6vrAWbM836zNfe4A5Joib+dhVw3sfLQH9thZmCJKO8hO2Oi8r6kR+IvUHg4YT/1V
	4qjOTn3bzJ9/9DbV3Qg3J1iY66cvkklY=
X-Google-Smtp-Source: AGHT+IHsP5jHjmrPgRyeHZb7koTJcXLUdu7YlbooEc0VBx3nb1vg5x2RrbkCBJ7LRLC4HpGPeQh6RgDcEulZZnspnLI=
X-Received: by 2002:a17:907:3e9e:b0:b04:3cd2:265b with SMTP id
 a640c23a62f3a-b1fab1cb6c7mr344272166b.5.1758194226502; Thu, 18 Sep 2025
 04:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918105055.101540-1-wqu@suse.com>
In-Reply-To: <20250918105055.101540-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 18 Sep 2025 12:16:28 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4Kac8aNVsuwiemN753iZ11eLvE-H-3A24op1MKozSHSw@mail.gmail.com>
X-Gm-Features: AS18NWCsmZ_D7d1hJkTkbYJ2uxMIYoQqmmfbp886jBUdgZsWpjYK7jRQGGeJm6g
Message-ID: <CAL3q7H4Kac8aNVsuwiemN753iZ11eLvE-H-3A24op1MKozSHSw@mail.gmail.com>
Subject: Re: [PATCH] btrfs/304: skip the run if block size is not 4K
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 11:51=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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
> btrfs/304 1s ... - output mismatch (see /home/adam/xfstests/results//btrf=
s/304.out.bad)
>     --- tests/btrfs/304.out     2024-07-15 16:17:42.639999997 +0930
>     +++ /home/adam/xfstests/results//btrfs/304.out.bad  2025-09-18 18:44:=
13.761000000 +0930
>     @@ -10,7 +10,7 @@
>      leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
>      fs uuid <UUID>
>      chunk uuid <UUID>
>     -   item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>     +   item 0 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 16
>                         stripe 0 devid 1 physical XXXXXXXXX
>      total bytes XXXXXXXX
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/btrfs/304.out /home/adam/xfst=
ests/results//btrfs/304.out.bad'  to see the entire diff)
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

experiemental -> experimental

> possible to use 8K block size, and that breaks the 4K block size
> assumption of the test case.
>
> [FIX]
> Add quick scratch mkfs, and grab the block size of the resulted fs.

resulted -> resulting

> If the block size is not 4K, skip the run.
>
> Since we're here, also remove the page size check, since we have subpage
> block size support for a while, and replace it with a more accurate
> supported sectorsize check.
>
> This more accurate sectorsize support now allows aarch64 (64K page size)
> to run btrfs/304 successfully, improving the subpage bs support coverage.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/304 | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/304 b/tests/btrfs/304
> index b7ed66af..95c493db 100755
> --- a/tests/btrfs/304
> +++ b/tests/btrfs/304
> @@ -20,8 +20,13 @@ _require_btrfs_fs_feature "raid_stripe_tree"
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
> +       _notrun "this tests require blocksize 4096, has $blocksize"

should be "this test requires block size 4096, have $blocksize"

So at least 3 of the raid stripe tree tests, from btrfs/304,305,306
require the same exact fix, why not combine all the fixes in a single
patch?
I've sent patches for the other two that do exactly the same.

Thanks.
> +fi
>
>  test_4k_write()
>  {
> --
> 2.51.0
>
>

