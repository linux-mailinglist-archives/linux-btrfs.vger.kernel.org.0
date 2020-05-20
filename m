Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB9F1DB3DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 14:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgETMl0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 08:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgETMl0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 08:41:26 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A37C061A0E;
        Wed, 20 May 2020 05:41:22 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id w65so1694752vsw.11;
        Wed, 20 May 2020 05:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=5IVQbqd47LVHfYEPI+JZLN7Nu6+ehfOcH9Yro26bql0=;
        b=a/PCIt5eVvWhA++kkRsRVkQvbCZVJ6TTve+dTIX55Xm5K3nOUgNftBT4abL6nqdZL8
         sPD0kC+2iLcfDQOYXJT2sG6YZWXCDRf7mIK6/Llb0EoXbA1pHsC6PFQbrM9uK1TcUe9I
         kxa7/BiSByy7ZteMYX/Be9fyATIKK/ClWgxMJDHHxHt5ovHKPW5rWyeH50m0aeHBBY0Z
         Mri240/g+Vpp7HN+4eIVM9PEZKSfXlo4XjgbcSaB02wwUsPAxDnq49IXBrLdX3g9Fy1s
         a1+dSpFdXXCHCbHWXuDLYle4a7Sa7eb2mHYGkwmwAjG4lqmJDncU/K2L9szQjxPvvtnQ
         tx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=5IVQbqd47LVHfYEPI+JZLN7Nu6+ehfOcH9Yro26bql0=;
        b=AvJsE53Tpp8OJBsKLrP3kuSHOsBgROCcBi+LRsxwC1luyWvOkkEIV6TqhY+TtrbQTi
         yJLjiUevaLhhMJKGFuhkJKpkcH3XrNs1pLfXHNa6tOtZHD7Jw1uILTss7S42zX0XAG8t
         BRK57VHwmZaIxMohj1wgcYyT3Ybcbo8jey94Yvm3ZFlGmegy5Fl21B86ERAZhxr0uE7+
         PNKlmrmdd5Bs0MXzCaXBXuP1cVJwLJEXde97PJd1GnUix1tOIhgHbih7+hAhESYqAGjD
         /5HZgHX9xnZEgkHIpASMmUlj+/7C7pXmCz0qUppMPgS+94iiBGwW80qlWdGZfhWjSvxQ
         JnLw==
X-Gm-Message-State: AOAM5321LBORpmTM2y2UYs7pd2I7Z50c/mJLjpy/UiBNaEzRZo4zIeIW
        csxsZgcI99mpOzvDMA01yUTvvjHCJK+A1BbKgz0=
X-Google-Smtp-Source: ABdhPJxh4MOhkCiS4YNqDq2CbfP6MWWIC1LBMUTT+CMX9iDGXHnOmpVImka7BWsohkf90W+xWZl2VvqFhrNEjfPl/eQ=
X-Received: by 2002:a67:407:: with SMTP id 7mr2906029vse.95.1589978481697;
 Wed, 20 May 2020 05:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200520114443.21143-1-wqu@suse.com> <20200520114443.21143-2-wqu@suse.com>
In-Reply-To: <20200520114443.21143-2-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 20 May 2020 13:41:10 +0100
Message-ID: <CAL3q7H7XNJKA9SNab6zZpvPs1bGD9sMs2BniR9AconmvzZokQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: Add a test for dead looping balance after
 balance cancel
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 20, 2020 at 12:47 PM Qu Wenruo <wqu@suse.com> wrote:
>
> Test if canceling a running balance can cause later balance to dead
> loop.
>
> The fix is titled "btrfs: relocation: Clear the DEAD_RELOC_TREE bit for
>  orphan roots to prevent runaway balance".
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Remove lsof debug output
> v3:
> - Remove ps debug output
> v4:
> - Use $XFS_IO_PROG directly to avoid wrapped dd command
>   This allows us to kill the writer and wait it correctly, other than
>   killing the bash process running the wrapper function.
> - Fix typos
> - Use _run_btrfs_balance_start() wrapper
> ---
>  tests/btrfs/213     | 65 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/213.out |  2 ++
>  tests/btrfs/group   |  1 +
>  3 files changed, 68 insertions(+)
>  create mode 100755 tests/btrfs/213
>  create mode 100644 tests/btrfs/213.out
>
> diff --git a/tests/btrfs/213 b/tests/btrfs/213
> new file mode 100755
> index 00000000..a3a2afe0
> --- /dev/null
> +++ b/tests/btrfs/213
> @@ -0,0 +1,65 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 213
> +#
> +# Test if canceling a running balance can lead to dead looping balance
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
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch
> +_require_xfs_io_command pwrite -D
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +
> +runtime=3D4
> +
> +# Create enough IO so that we need around $runtime seconds to relocate i=
t.
> +#
> +# Here we don't want any wrapper, as we want full control of the process=
.
> +$XFS_IO_PROG -f -c "pwrite -D -b 1M 0 1024T" "$SCRATCH_MNT/file" &> /dev=
/null &
> +write_pid=3D$!
> +sleep $runtime

Probably you forgot, but as I said before, we should make sure the
xfs_io process is killed in _cleanup() too, in case we abort the test
while it is in that sleep above.

With that added,

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +kill $write_pid
> +wait $write_pid
> +
> +# Now balance should take at least $runtime seconds, we can cancel it at
> +# $runtime/2 to ensure a success cancel.
> +_run_btrfs_balance_start -d --bg "$SCRATCH_MNT"
> +sleep $(($runtime / 2))
> +$BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT"
> +
> +# Now check if we can finish relocating metadata, which should finish ve=
ry
> +# quickly.
> +$BTRFS_UTIL_PROG balance start -m "$SCRATCH_MNT" >> $seqres.full
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/213.out b/tests/btrfs/213.out
> new file mode 100644
> index 00000000..bd8f2430
> --- /dev/null
> +++ b/tests/btrfs/213.out
> @@ -0,0 +1,2 @@
> +QA output created by 213
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 8d65bddd..59e8ecce 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -215,3 +215,4 @@
>  210 auto quick qgroup snapshot
>  211 auto quick log prealloc
>  212 auto balance dangerous
> +213 auto quick balance dangerous
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
