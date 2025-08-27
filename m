Return-Path: <linux-btrfs+bounces-16433-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581FEB37E1D
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 10:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5D27C6613
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 08:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6D43375A6;
	Wed, 27 Aug 2025 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDRALR6D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD40421C9F4;
	Wed, 27 Aug 2025 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756284557; cv=none; b=oLaon+u45eKX90/t175Ba5ZuIyaHHWtfe1HpQlz5p6XvQkLk2ESgQ4pr9m/XdH+ZkYkkq1amXiH3vGpVKsKLcV4eKpUgYHQin2a2/28C+ejI1VBaSYgQ/P6nu2b3+e73mCjrzv0YHbU1WawrVVebh90NhkJI3FqV3ij0HkZzvpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756284557; c=relaxed/simple;
	bh=JJPzO76SBMlE/609qI+KDyccjKYXuZdSquwj4U7KGUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzwhvO3sARQlDSKqzDdkBSDvP/GTkWs+9mpndWgVMdKW7sC9g6dYMejhvTUIOE4+3fgQJUV4bqrwazmF/qUCBJZY3ISukK/zNyZfJYJe7DCfVo29wQBFHSKkZ8OiWlD4gQfvv9W4M0a1R0W0doMmYDDR64pz24ciqw5j0saCaBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDRALR6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACFAC113D0;
	Wed, 27 Aug 2025 08:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756284557;
	bh=JJPzO76SBMlE/609qI+KDyccjKYXuZdSquwj4U7KGUU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kDRALR6DRnLUl4E4tEOYW6KX42G/lz5i8E9ZGyo3IN8K4S3DykokfUTNky5P0IISh
	 QjFukHH5eF7Og3qeHkyxWFpudapGut4BoFQN57klfJmSO0XHhRKwrW5j0/hEkedV3l
	 gZv+9yYpRZ/HTYgU7QFAxZuVgrftAAXYrHFWVNfOTPqPfeTLuhKyV26VDfBtr63YCZ
	 AGcABqzTmXCZ+iZuRH1JpME1SE6v33XFg+kZH5wsbvrCQHjVaKzrGevFNEgr3+wek0
	 8YVwItr88BdZ6CqI3bqe7cdIpT92lC7L5io2eez9os+U5KvHzaXVSwTFQSouAYNZ11
	 aNZ8tQnuAWRVA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afe9f6caf9eso309457266b.3;
        Wed, 27 Aug 2025 01:49:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWURUND4/Fo5na1trmhINXEWzcdV/HawMP5b8kBlg9D+cbw6HahQrhB/6ZyB6pZ4XI4yt4bUu8a@vger.kernel.org
X-Gm-Message-State: AOJu0YxSOzIgB6jXM1hSTeiAo2t+MQzwAbZyfiHsbc7IQdR3jhpUziE+
	AjMOtV52yW3RfkM3AzB5lx6dAHvGUGnU3pXAlJNpTSwnCiUo7u+tpbXUTQL85OOhJ5MxbFHCHnA
	XBTiqW8IgJxxqvhGfnctv+LdEdqepQ74=
X-Google-Smtp-Source: AGHT+IFh6Zu1CiJ+R3Bxpb7DrqO7Rep2Ov0iIZkwUNTG0nGYqvKPDMOfYFkQO4NQH6vOOTT+w1NrKefUAHiwaAdzZ98=
X-Received: by 2002:a17:906:fe05:b0:ad5:777d:83d8 with SMTP id
 a640c23a62f3a-afe29447253mr1614838866b.29.1756284555851; Wed, 27 Aug 2025
 01:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827014250.170552-1-wqu@suse.com>
In-Reply-To: <20250827014250.170552-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 27 Aug 2025 09:48:39 +0100
X-Gmail-Original-Message-ID: <CAL3q7H42rX5AxNXZF-t8Qs-=PiRhU818_iYxj8iaTq=egWAWyg@mail.gmail.com>
X-Gm-Features: Ac12FXyBiBcp4kEaIrZa3Q5VgQTYw40mw0Wq_mKsd150tzlNxWdoSPRMI6v84G0
Message-ID: <CAL3q7H42rX5AxNXZF-t8Qs-=PiRhU818_iYxj8iaTq=egWAWyg@mail.gmail.com>
Subject: Re: [PATCH v3] fstests: btrfs: add a new test case to verify
 compressed read
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 2:44=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> The new test case is a regression test related to the block size < page
> size handling of compressed read.
>
> The test case will only be triggered with 64K page size and 4K btrfs
> block size.
> I'm using aarch64 with 64K page size to trigger the regression.
>
> The test case will create the following file layout:
>
>   base:
>   [0, 64K): Single compressed data extent at bytenr X.
>
>   new:
>   [0, 32K): Reflinked from base [32K, 64K)
>   [32K, 60K): Reflinked from base [0, 28K)
>   [60K, 64K): New 4K write
>
>   The range [0, 32K) and [32K, 64K) are pointing to the same compressed
>   data.
>
>   The last 4K write is a special workaround. It is a block aligned
>   write, thus it will create the folio but without reading out the
>   remaing part.
>
>   This is to avoid readahead path, which has the proper fix.
>   We want single folio read without readahead.
>
> Then output the file "new" just after the last 4K write, then cycle
> mount and output the content again.
>
> For patched kernel, or with 4K page sized system, the test will pass,
> the resulted content will not change during mount cycles.
>
> For unpatched kernel and with 64K page size, the test will fail, the
> content after the write will be incorrect (the range [32K, 60K) will be
> zero), but after a mount cycle the content is correct again.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> Changelog:
> v3:
> - Fix the golden output which is generated by an unpatched kernel
>
> v2:
> - Remove the unnecessary sync inherited from the kernel fix
> - Use _hexdump instead of open-coded od dumps
> - Use the correct 'clone' group instead of 'reflink'
> - Minor grammar fixes
>   All thanks to Filipe.
> ---
>  tests/btrfs/337     | 55 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/337.out | 23 +++++++++++++++++++
>  2 files changed, 78 insertions(+)
>  create mode 100755 tests/btrfs/337
>  create mode 100644 tests/btrfs/337.out
>
> diff --git a/tests/btrfs/337 b/tests/btrfs/337
> new file mode 100755
> index 00000000..9c409e4d
> --- /dev/null
> +++ b/tests/btrfs/337
> @@ -0,0 +1,55 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 337
> +#
> +# Test compressed read with shared extents, especially for bs < ps cases=
.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick compress clone
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +       "btrfs: fix corruption reading compressed range when block size i=
s smaller than page size"
> +
> +. ./common/filter
> +. ./common/reflink
> +
> +_require_btrfs_support_sectorsize 4096
> +_require_scratch_reflink
> +
> +# The layout used in the test case is all 4K based, and can only be repr=
oduced
> +# with page size larger than 4K.
> +_scratch_mkfs -s 4k >> $seqres.full
> +_scratch_mount "-o compress"
> +
> +# Create the reflink source, which must be a compressed extent.
> +$XFS_IO_PROG -f -c "pwrite -S 0x0f 0 32K" \
> +               -c "pwrite -S 0xf0 32K 32K" \
> +               $SCRATCH_MNT/base >> $seqres.full
> +echo "Reflink source:"
> +_hexdump $SCRATCH_MNT/base
> +
> +# Create the reflink dest, which reverses the order of the two 32K range=
s.
> +#
> +# And do a further aligned write into the last block.
> +# This write is to make sure the folio exists in filemap, so that we won=
't go
> +# through the readahead path (which has the proper handling) for the fol=
io.
> +$XFS_IO_PROG -f -c "reflink $SCRATCH_MNT/base 32K 0 32K" \
> +               -c "reflink $SCRATCH_MNT/base 0 32K 32K" \
> +               -c "pwrite 60K 4K" $SCRATCH_MNT/new >> $seqres.full
> +
> +# This will result an incorrect output for unpatched kernel.
> +# The range [32K, 60K) will be zero due to incorrectly merged compressed=
 read.
> +echo "Before mount cycle:"
> +_hexdump $SCRATCH_MNT/new
> +
> +_scratch_cycle_mount
> +
> +# This will go through readahead path, which has the proper handling, th=
us give
> +# the correct content.
> +echo "After mount cycle:"
> +_hexdump $SCRATCH_MNT/new
> +
> +status=3D0
> +_exit 0
> diff --git a/tests/btrfs/337.out b/tests/btrfs/337.out
> new file mode 100644
> index 00000000..cecbbbcf
> --- /dev/null
> +++ b/tests/btrfs/337.out
> @@ -0,0 +1,23 @@
> +QA output created by 337
> +Reflink source:
> +000000 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f  >...............=
.<
> +*
> +008000 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0  >...............=
.<
> +*
> +010000
> +Before mount cycle:
> +000000 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0  >...............=
.<
> +*
> +008000 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f  >...............=
.<
> +*
> +00f000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >...............=
.<
> +*
> +010000
> +After mount cycle:
> +000000 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0  >...............=
.<
> +*
> +008000 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f  >...............=
.<
> +*
> +00f000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >...............=
.<
> +*
> +010000
> --
> 2.49.0
>
>

