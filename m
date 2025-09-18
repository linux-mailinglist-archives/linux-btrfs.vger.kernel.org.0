Return-Path: <linux-btrfs+bounces-16927-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82572B8451E
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 13:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC3E1C039BD
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 11:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070C62FF144;
	Thu, 18 Sep 2025 11:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gif6terR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441DE2F2609
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 11:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194303; cv=none; b=s4Lt/b3vJdSH6XKswY0yjWRfCX5Ih935imydbBEwQXTjZMlUjlneUEd0O8Hp0BsFNnzmVJfnq2Mdp4cvhePCLKTnMApWLMVqKTVQ3qHDHnpuOhDIBO3z//7G6yeQMHMjmFHUOYxzbAl/bxNQOyNO8eXx9jvvg7w8qRJKwd3Risg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194303; c=relaxed/simple;
	bh=yN4fx8BNsUZqj77c2eboa3yITdMjuH12ExPnOFI4wSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jaLPQS+HUtRnO/urU9xDunuQ+i28vcj731fTl5NEphkcRmeFe/9UdR07X3TTJT024SPLaUGEp9MmUXTMTJNsbeistBAcK7fx8swN5xZlu4GR3pH0r5w65+hb+9qBmy3AtRdhJLCxnXU6Bpb5DN4oxG708RCFqUZclCZ9dlpkZSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gif6terR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1D9C4CEF7
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 11:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758194302;
	bh=yN4fx8BNsUZqj77c2eboa3yITdMjuH12ExPnOFI4wSo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gif6terRV81nFppd5OTqgc9fsb0WnQmNWVWVdKmf0V/9Em6a2VQUNg9HG2fP0gukq
	 dX3PCKfLtf9g5Un3IRohCH0ck0WD0gKO+1ZtVaqDmhz4d8o+4meLVlLBethzMjbmit
	 ZfKbzIstG4X61GY4LDGhnDT7qBbSxnAP0lgPqQ+ZoHBPHn5q68CwsLe0DMFp50aw/X
	 D+Zz6dEgR6MXDa8VZZln3QPQjPkV7NBoZmS7MNJkqddY5ap5z5IRIGMzr9dQi+LUCN
	 UA2bcjFv4y1V7zbHXtKvD7Y2Rys24xFj5f3X2hp+8BwraKtqLRsKmkWJw3LlvRns/0
	 rFsPFbuhL2g4g==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7a16441so127500766b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 04:18:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YyqWnM963nGMidOGxUkhkPggWdUHjivz/pwcnvlfPdbgLj8xujh
	+Yeubn/8kARMTCJE+KVZIXPoXtXEU/Q159q5wg0LvsUM2b4FThlOZ6bk366chiJqf0/aQVNgqZ9
	epu2Df1kmaWLjFC/0aMpFfS+jNYSqQXc=
X-Google-Smtp-Source: AGHT+IFuFVisx1bXa4HffA6++qBMat3JkoOiCKLMgPv87wu8s23fwa4YvB94afWGS1dW42wsqCOwsjXnOvzIPOvcly8=
X-Received: by 2002:a17:906:6a1e:b0:afe:ffb6:bfaf with SMTP id
 a640c23a62f3a-b1bb50c4058mr653964566b.3.1758194301393; Thu, 18 Sep 2025
 04:18:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918105909.102551-1-wqu@suse.com>
In-Reply-To: <20250918105909.102551-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 18 Sep 2025 12:17:43 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6E=pcY12JGvz2Cx=vuDRMprLwptvWtsQ5FevtHpC37xA@mail.gmail.com>
X-Gm-Features: AS18NWDUMGdtsb_9uZ4IdtoL_JNxiztPMbGD4qfgXJtqnJOYh7cs-nNiGnkeG20
Message-ID: <CAL3q7H6E=pcY12JGvz2Cx=vuDRMprLwptvWtsQ5FevtHpC37xA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs/305: skip the run if block size is not 4K
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 11:59=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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
> btrfs/305 1s ... - output mismatch (see /home/adam/xfstests/results//btrf=
s/305.out.bad)
>     --- tests/btrfs/305.out     2024-07-15 16:17:42.639999997 +0930
>     +++ /home/adam/xfstests/results//btrfs/305.out.bad  2025-09-18 18:44:=
14.914196231 +0930
>     @@ -12,11 +12,9 @@
>      leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
>      fs uuid <UUID>
>      chunk uuid <UUID>
>     -   item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 16
>     +   item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>                         stripe 0 devid 1 physical XXXXXXXXX
>     -   item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/btrfs/305.out /home/adam/xfst=
ests/results//btrfs/305.out.bad'  to see the entire diff)
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

typo in experimental

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
> to run btrfs/305 successfully, improving the subpage bs support coverage.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix the _notrun message to use $blksz instead of the wrong $blocksize
> ---
>  tests/btrfs/305 | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/305 b/tests/btrfs/305
> index ad060853..bd484bbe 100755
> --- a/tests/btrfs/305
> +++ b/tests/btrfs/305
> @@ -22,7 +22,13 @@ _require_btrfs_fs_feature "free_space_tree"
>  _require_btrfs_free_space_tree
>  _require_btrfs_no_compress
>
> -test $(_get_page_size) -eq 4096 || _notrun "this tests requires 4k pages=
ize"
> +_require_btrfs_support_sectorsize 4096
> +
> +_scratch_mkfs >> /dev/null
> +blksz=3D$(_scratch_btrfs_sectorsize)
> +if [ $blksz -ne 4096 ]; then
> +       _notrun "this tests require blocksize 4096, has $blksz"
> +fi

should be "this test requires a block size of 4096 bytes, have $blocksize"

So at least 3 of the raid stripe tree tests, from btrfs/304,305,306
require the same exact fix, why not combine all the fixes in a single
patch?
I've sent patches for the other two that do exactly the same.

Thanks.

>
>  test_8k_new_stripe()
>  {
> --
> 2.51.0
>
>

