Return-Path: <linux-btrfs+bounces-18463-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD41C243DA
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 10:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8271883EA2
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 09:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC3C3321B9;
	Fri, 31 Oct 2025 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXozVk74"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0C5283FDD
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903985; cv=none; b=TFLs8cYTRzce6nhOs9UitJ3ziUc0N6gArX3ibpvoOWNJ6slYM4raFhqz4Dq6kUfl05e3n1VaSU0yZfG4YoOdkcbCTFQRxzByMUezwZ5/ndCI+dJhrhOd6C0EKhpvqdKVQGaiTJLXXiAV6ZgZIWE3ONiA7LXpaDfeHx9HhPW3Few=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903985; c=relaxed/simple;
	bh=RpWTsJSok6QIGfLxQGprd/Ppe06nm/UEj7FLINBTlBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAHraWRKkKM+WO6CgOy19sZGEetKM5tlagwbO1PVvRlr5KsrXrNO+CyChY4s8gY1AXwaAHFcSxNIAV4z9Bh0syjrX9CWJE+glL+u8VywqhDkhzB5xy+fsmhSGWZIIImX/AHARayP0BiWojQmownDL0CUY5lbIFtI4yTvi+/5BpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXozVk74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4231AC4CEE7
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 09:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761903985;
	bh=RpWTsJSok6QIGfLxQGprd/Ppe06nm/UEj7FLINBTlBU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qXozVk74eWorjfrSSjL4c7Q5LwOFwockzXCrA2PTgwq7/bo6dbcQiBN4hG4Kv08G2
	 qCpS5/iWAcEK3B3f43kpJ4mauuOpH30cGNsHy9RAW3XLwFmBQ6V2oKU3KVOOE+4GND
	 qWKGNvmENiMLnuLTHgzCN5q4fJBOnJhxG6yTzFIeV4NHSo3eQ9qjUiVDNiyvqTCvul
	 QjHwjYLsXJZBVWFrk3ymzjVwTSiaU/UPvolr94X+FGgbDK0tPFVS3vG5pwaeuKLgSb
	 QAFfZt/aNyid06brZVUzSlrgprCNTSTdNx9gN00q1pX+34HaQV3jt7NoJU9b5BxH9X
	 YVPF9UPm6J12g==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b6d5b756284so508771366b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 02:46:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDbwI7q52CWbddzIVy9YVvrRvKC23H33wX2KEjzKybyhtzxbpWb7CWwvsQ6i36DvfjI+ReP29WKUYx+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YydJM/92q+1pGAIdHRmAyljboeiwlq+iKfORsJ9jVX3TlU8vS5x
	x1Id/P9+xGz1gboRyVfBEPW+DiavslZb020EN7cwBoW/gm4FcX48wvijqyPkBURyfBdin06PBhJ
	RrGMqSglWun3SacbUgyN1G2XC5+Q8t5M=
X-Google-Smtp-Source: AGHT+IEAJ3HvnDqALTtqjsHqDm6pem9zkmQSYXCVw5if1ZE/DXYLN1nE3FY0XuWyNDgkrIrmP4615AvaCq2T3MNrhgY=
X-Received: by 2002:a17:906:7306:b0:b3f:cc6d:e0a8 with SMTP id
 a640c23a62f3a-b70701379e8mr312704666b.17.1761903983803; Fri, 31 Oct 2025
 02:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031030606.2972296-1-austinchang@synology.com>
In-Reply-To: <20251031030606.2972296-1-austinchang@synology.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 31 Oct 2025 09:45:46 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4iWO4+u3dvNqKAXmA6CuHC8LSRwcpzNuOrM_50RYPWzw@mail.gmail.com>
X-Gm-Features: AWmQ_bn2cjLlV0o5HPBaLgHP91ZWTdHrdma-zl0Xx-PWIvxaCFYhBtbzmEecWeE
Message-ID: <CAL3q7H4iWO4+u3dvNqKAXmA6CuHC8LSRwcpzNuOrM_50RYPWzw@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: add test for fallocate on prealloc extents
To: austinchang <austinchang@synology.com>
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org, robbieko@synology.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 3:06=E2=80=AFAM austinchang <austinchang@synology.c=
om> wrote:
>
> In subvolume without no_holes feature, following sequence can produce
> incorrect i_size for a file:
>
> 1. Allocate an extent at the offset larger than the i_size of the file.
> 2. Unmount then mount back the volume.
> 3. Perform fallocate on the preallocated range to increase the i_size.
> 4. The i_size won't reflect the fallocate in 3. after umount then
>    mount.
>
> The bug exists since the file_extent_tree has been introduced:
> 41a2ee75aab0 ("btrfs: introduce per-inode file extent tree")
> And became hidden since
> 3d7db6e8bd22 ("btrfs: don't allocate file extent tree for non regular fil=
es")
> Then became visible again after
> 8679d2687c35 ("btrfs: initialize inode::file_extent_tree after i_mode has=
 been set").
>
> The test creates the file with the extents mentioned above and verify
> that the file size is consistent after unmount and mount.
>
> Signed-off-by: austinchang <austinchang@synology.com>
> ---
>  tests/btrfs/338     | 48 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/338.out |  3 +++
>  2 files changed, 51 insertions(+)
>  create mode 100755 tests/btrfs/338
>  create mode 100755 tests/btrfs/338.out
>
> diff --git a/tests/btrfs/338 b/tests/btrfs/338
> new file mode 100755
> index 00000000..565a5ae2
> --- /dev/null
> +++ b/tests/btrfs/338
> @@ -0,0 +1,48 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Synology Inc.  All Rights Reserved.
> +#
> +# FS QA Test 338
> +#
> +# Tests the file size when the fallocate is performed on prealloc extent=
s
> +# that start after i_size.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick prealloc
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +       "btrfs: mark dirty bit for out of bound prealloc extents"

The subject was changed when it was added to the for-next branch, so now it=
 is:

"btrfs: mark dirty extent range for out of bound prealloc extents"

> +
> +. ./common/filter
> +
> +_require_btrfs_mkfs_feature "no-holes"

Missing kernel support check:

_require_btrfs_fs_feature "no_holes"

> +
> +_scratch_mkfs -O ^no-holes >>$seqres.full 2>&1
> +_scratch_mount || _fail "mount failed"

If the mount fails we don't need to call _fail - the test fails automatical=
ly.
However we're ignoring mkfs failures there, since stdout and stderr
are redirected. There we do a _fail in more recent tests, so make sure
the test runs on a new fs.

So this should be:

_scratch_mkfs -O ^no-holes >>$seqres.full 2>&1 || _fail "mkfs failed"
_scratch_mount

> +
> +touch $SCRATCH_MNT/file1
> +
> +# Add a 2M extent at the file offset 1M without increasing i_size
> +fallocate -n -o 1M -l 2M $SCRATCH_MNT/file1
> +
> +# Unmount and mount again to clear the in-memory extent tree
> +_scratch_unmount
> +_scratch_mount

_scratch_cycle_mount

> +
> +# Use a length that doesn't trigger realloc of the 2M extent before

Same comment I made for the kernel patch.
This is confusing, because any fallocate against a range that already
has extents never reallocates.

I changed the kernel change log version to:

# Use a length that fits within the range of the previously allocated
# extent. We want the next fallocate to only increase the i_size.

> +len=3D$((1 * 1024 * 1024))

Btw, this can be simply

len=3D1M

> +
> +# fallocate on the prealloc extent to change i_size
> +fallocate -o 1M -l $len $SCRATCH_MNT/file1
> +
> +du --bytes $SCRATCH_MNT/file1| cut -f1

Please add a space before the pipe too, to make it more readable.

> +
> +_scratch_unmount
> +_scratch_mount

_scratch_cycle_mount

> +
> +# The file size should be the same as before
> +du --bytes $SCRATCH_MNT/file1| cut -f1

Same as before, please add a space before the pipe too, to make it
more readable.

> +
> +_scratch_unmount

No need for this. The fstests framework automatically unmounts.

Thanks.

> +
> +_exit 0
> diff --git a/tests/btrfs/338.out b/tests/btrfs/338.out
> new file mode 100755
> index 00000000..0edd2502
> --- /dev/null
> +++ b/tests/btrfs/338.out
> @@ -0,0 +1,3 @@
> +QA output created by 338
> +2097152
> +2097152
> --
> 2.34.1
>
>
> Disclaimer: The contents of this e-mail message and any attachments are c=
onfidential and are intended solely for addressee. The information may also=
 be legally privileged. This transmission is sent in trust, for the sole pu=
rpose of delivery to the intended recipient. If you have received this tran=
smission in error, any use, reproduction or dissemination of this transmiss=
ion is strictly prohibited. If you are not the intended recipient, please i=
mmediately notify the sender by reply e-mail or phone and delete this messa=
ge and its attachments, if any.

