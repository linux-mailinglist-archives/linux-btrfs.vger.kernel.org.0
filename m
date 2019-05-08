Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3491117424
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2019 10:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfEHInN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 May 2019 04:43:13 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:35187 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfEHInM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 May 2019 04:43:12 -0400
Received: by mail-vk1-f195.google.com with SMTP id t74so4763447vke.2;
        Wed, 08 May 2019 01:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=R9LgyvhKzr6g6A/Et70yOrnWvhCpirq74P+6qTrVhUM=;
        b=qWime/BPInd+nIAHGU/2ygN8XxAJ+5J+Ackr6w27zFwod1AaSh2YL1Wv/+w15x4uXk
         +0ULowlyzoSrdG50+Yz6wfpDEpQfRfeAkOFhj8vuvyqvTY2eraf8VXpu131BCPKlid62
         GtX/vrtQpiuO+fKK0p5L5uBYpKZRsB8bH+BzZfpoGPsVBXTbNVr/GeV0VCbzaXQ3NKXZ
         CI4XPkETxY+pPIGAIJb6ZmQVRbzPbY3UcsgXo+3CiETooYJ3GLPk3yEqPGaIiXnO3skK
         UpUpZjPmcMmtpUxdOxzWfpyCFpTCwZ6ZqvkKVYejoPTvQm4GzS0EofRkAx+6jmsQP5Tr
         d4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=R9LgyvhKzr6g6A/Et70yOrnWvhCpirq74P+6qTrVhUM=;
        b=TXO0BsPx7SXWdQKsIC1/2VUK2+l1QSjag5/vzWYZdzr27vBxQ7FegfzUUEah7dDtlN
         9EDav5s6w0mRonx0sVpsK/LIDkldtR8IR1XntzoutUjN5CaL1oOf9gGSrXHkXEZUm8fH
         +aLVOVosPie8O2qkch0r5/nTWp8YclG0hJGZFVYilcp5C7P+BpbyERxhfL1gbHz6DvNs
         IC1VyqzegL4uEpb+RuVc+/ZOwnrxISJhIHYbDk2TwijQpn5h6cP2pQJl6WvJWZYQRuAO
         KejgiWSG0TMHgyHjgFFr654NlPrJu8gUkuNSA5S5J75caIZIeTzrigVDvmZDd+hhKyYk
         jMPg==
X-Gm-Message-State: APjAAAWPGHuvQS2xHkJp2vzq6rBqMQPqGkQ4EUz0TCbCfC53MxBeETSN
        rRAjiOL4CZHRgT7GZmk+B9fzpSaFL+c6R54CVo4cg+LW
X-Google-Smtp-Source: APXvYqyqUdV7JHFTmYhgi8o9hg/kI5xRcSaF+caGLj/vvnIHoQ5f2UCOt6FiLXRzWUfhsUrIR7OKokWFhJSTmpOOg8Q=
X-Received: by 2002:a1f:a385:: with SMTP id m127mr15770403vke.88.1557304991390;
 Wed, 08 May 2019 01:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190508074733.12787-1-wqu@suse.com>
In-Reply-To: <20190508074733.12787-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 8 May 2019 09:43:00 +0100
Message-ID: <CAL3q7H6naPCV8Lo5_cczv-ux8K0iuaXBmqGzY_EoNK-hShYoOg@mail.gmail.com>
Subject: Re: [PATCH] fstests: generic: Test if fsync will fail after NOCOW
 write and reflink
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 8, 2019 at 8:48 AM Qu Wenruo <wqu@suse.com> wrote:
>
> This test case is going to check if btrfs will fail fsync after NOCOW
> buffered write and reflink.
>
> Btrfs' back reference only has extent level granularity, so if we do
> buffered write which can be done NOCOW, then reflink, that buffered
> write will be forced CoW.
>
> And if we have no data space left, CoW will fail and cause fsync
> failure.

The changelog, for a generic test, should describe in general terms
what the test is testing, not how/why btrfs fails, neither the btrfs
implementation details.

Here in changelog you can say the test currently fails on btrfs and
then mention which patch/commit fixes it.

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/generic/545     | 82 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/545.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 85 insertions(+)
>  create mode 100755 tests/generic/545
>  create mode 100644 tests/generic/545.out
>
> diff --git a/tests/generic/545 b/tests/generic/545
> new file mode 100755
> index 00000000..b6e1a0ae
> --- /dev/null
> +++ b/tests/generic/545
> @@ -0,0 +1,82 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 545
> +#
> +# Test if btrfs fails fsync due to ENOSPC.
> +#
> +# Btrfs' back reference only has extent level granularity, thus if refli=
nk of
> +# an preallocated extent happens, any write into that extent must be CoW=
ed.
> +#
> +# We could craft a case, where btrfs reserve no data space at buffered w=
rite
> +# time but are forced to do CoW at writeback, and fail fsync.
> +#
> +# This is fixed by "btrfs: Flush before reflinking any extent to prevent=
 NOCOW
> +# write falling back to CoW without data reservation"

Same as before, it's a generic test, you should describe what we are
testing, not that btrfs fails and why/how, nor btrfs' specific
implementation details.

I've been pointed about doing similar in the past, see
https://marc.info/?l=3Dlinux-btrfs&m=3D142482279823445&w=3D2

I would just say:

Test that if we do a buffered write against a section of an unwritten
extent, reflink a different section of the extent and then fsync the
file, the fsync will succeed and the buffered write is persisted.

> +#
> +seq=3D`basename $0`
> +seqres=3D$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`
> +tmp=3D/tmp/$$
> +status=3D1       # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +       cd /
> +       rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/reflink
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_scratch_reflink
> +
> +_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> +
> +# Space cache will use some data space and may cause interference.
> +# Disable space cache here.
> +_scratch_mount -o nospace_cache

Have you tested this on other filesystems?
This will fail, nospace_cache is btrfs specific...

> +
> +# Create preallocated extent where we can do NOCOW write
> +xfs_io -f -c 'falloc 8k 64m' "$SCRATCH_MNT/foobar" >> $seqres.full

xfs_io -> $XFS_IO_PROG

> +
> +# Use up all remaining space, so that later write will go through NOCOW =
check
> +# We ignore the ENOSPC error here

Again that's a very specific btrfs detail - that btrfs will only
"enter" NOCOW mode when there's not enough available data space at the
time of the buffered write.

> +_pwrite_byte 0x00 0 512m "$SCRATCH_MNT/padding" >> $seqres.full 2>&1
> +
> +# Now setup is all done.
> +sync

Is the sync needed? Why? I don't think it's needed.

> +
> +# This buffered write will go through and pass NOCOW check thus no
> +# data space is reserved.

Again, very btrfs specific .

> +_pwrite_byte 0xcd 1m 16m "$SCRATCH_MNT/foobar" >> $seqres.full
> +
> +# Reflink the the unused part of the preallocated extent to increase
> +# its reference, so for btrfs any write into that preallocated extent
> +# must be CoWed.

Missing 'count' after 'reference'.
Also too much btrfs specific.

> +xfs_io -c "reflink ${SCRATCH_MNT}/foobar 8k 0 4k" "$SCRATCH_MNT/foobar" =
\
> +       >> $seqres.full

xfs_io -> $XFS_IO_PROG

> +
> +# Now fsync will fail due to we must CoW previous NOCOW write, but we ha=
ve
> +# now data space left, it will fail with ENOSPC

Again, describing the btrfs specific implementation details/failure,
instead of what we are testing (that the fsync succeeds).

> +xfs_io -c 'fsync'  "$SCRATCH_MNT/foobar"

xfs_io -> $XFS_IO_PROG

Thanks.

> +
> +echo "Silence is golden"
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/generic/545.out b/tests/generic/545.out
> new file mode 100644
> index 00000000..920d7244
> --- /dev/null
> +++ b/tests/generic/545.out
> @@ -0,0 +1,2 @@
> +QA output created by 545
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 40deb4d0..f26b91fe 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -547,3 +547,4 @@
>  542 auto quick clone
>  543 auto quick clone
>  544 auto quick clone
> +545 auto quick clone enospc
> --
> 2.21.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
