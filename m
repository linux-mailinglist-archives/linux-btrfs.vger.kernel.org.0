Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C0E3F7737
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 16:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241383AbhHYOZk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Aug 2021 10:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240327AbhHYOZj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Aug 2021 10:25:39 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FD1C061757;
        Wed, 25 Aug 2021 07:24:53 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id j9so13820613qvt.4;
        Wed, 25 Aug 2021 07:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Y43QiB49VzgqxoCVEJ8vauJRzbdb8+qpGK6YvTlBg3c=;
        b=KpO3BIyO2VOfJwR//VZ5tYhyVERlBPVxlr7h9WfSSHKAxoTL9rYdeTQdRF3IkSKNI0
         eQULjN6nW5mX0l9TMIn3wXyq0xt5DdGvD1DYaI0tMYlEULaDzAJ1lao1Dex5x5H17K/P
         8KTzm8eQc64DqPDu947a9pwjnlacxCz+BjJYUfoN0zOiX3KTwu4OZi+LfiqUp9unHlof
         iLz+ytTU2HXcSKkbEzMKEckbZtIpyfIWJn4wyKAan6rRaMC7lcnlL7AUnXCLUzof27BF
         2hHgS7nGWKwXtktxGPH7P2WVgAWqYbvZgDXP2cbNH4MPFWScpHYs/k6TBAzlw/HiKRL4
         vtpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Y43QiB49VzgqxoCVEJ8vauJRzbdb8+qpGK6YvTlBg3c=;
        b=m4Ea4bEKH0hPt+4X5lyunRT+gy+6tM/o8qUVe9Lv0/MOjj07SDO3smVkz4wut4dCAb
         oEiVHIwJbg02ngSJ7pGm/63psUM1xwZggrXuCS5I2LkCLTdo0mGJN4OaPAvfKWQZYDLU
         j3fX2aIBsS0RnxJbcmS1J5LQkYSKSBrF2T6tyBQoGVsDHksdq5KEs+4QjOsd8f8iMrWR
         NWZWKtdR+UJ+KBIqEpuhdSJxMnDwdlAS3ffgaFYtgB+GVXfvGcbi37RTJR8turw+Iudt
         1NFdtu71fmS5U6lggcfXDWK3pDnVUVD6eSsyKF8YfqnU4vAyvldFZ3LIErSop146oIMZ
         8LRQ==
X-Gm-Message-State: AOAM533wY+qVsgNrcphCtGSTCmWmsNuUHrk+FZVI/WHW4MDlPGldAQjo
        alt5vTkVQOCLiZx9t1BTpRyfNgeRAA9Ogm2n9Fk=
X-Google-Smtp-Source: ABdhPJzoEnPsAsqrXO8LDUgqLHDEbjZFYJMFbnJiYvJnAjUIc/5dTBb7N5/bqaxZwVX3HqXPAWg1zHXhZGxbIkimuzw=
X-Received: by 2002:ad4:4a04:: with SMTP id m4mr26408597qvz.42.1629901492960;
 Wed, 25 Aug 2021 07:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210825061923.13770-1-wqu@suse.com>
In-Reply-To: <20210825061923.13770-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 25 Aug 2021 15:24:41 +0100
Message-ID: <CAL3q7H6eaGgL8e3OPQMOb-E9wKR5JQTV5pzEAsMvbaSCpZY1rA@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/246: add test case to make sure btrfs can
 create compressed inline extent
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 25, 2021 at 7:19 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Btrfs has the ability to inline small file extents into its metadata,
> and such inlined extents can be further compressed if needed.
>
> The new test case is for a regression caused by commit f2165627319f
> ("btrfs: compression: don't try to compress if we don't have enough
> pages").
>
> That commit prevents btrfs from creating compressed inline extents, even
> "-o compress,max_inline=3D2048" is specified, only uncompressed inline
> extents can be created.
>
> The test case will use "btrfs inspect dump-tree" to verify the created
> extent is both inlined and compressed.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/246     | 50 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/246.out |  2 ++
>  2 files changed, 52 insertions(+)
>  create mode 100755 tests/btrfs/246
>  create mode 100644 tests/btrfs/246.out
>
> diff --git a/tests/btrfs/246 b/tests/btrfs/246
> new file mode 100755
> index 00000000..15bb064d
> --- /dev/null
> +++ b/tests/btrfs/246
> @@ -0,0 +1,50 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 246
> +#
> +# Make sure btrfs can create compressed inline extents
> +#
> +. ./common/preamble
> +_begin_fstest auto quick compress
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +       cd /
> +       rm -r -f $tmp.*
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +# For __populate_find_inode()
> +. ./common/populate
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch
> +
> +_scratch_mkfs > /dev/null
> +_scratch_mount -o compress,max_inline=3D2048
> +
> +# This should create compressed inline extent
> +$XFS_IO_PROG -f -c "pwrite 0 2048" $SCRATCH_MNT/foobar > /dev/null
> +ino=3D$(__populate_find_inode $SCRATCH_MNT/foobar)
> +_scratch_unmount
> +
> +$BTRFS_UTIL_PROG inspect dump-tree -t 5 $SCRATCH_DEV | \
> +       grep "($ino EXTENT_DATA 0" -A2 > $tmp.dump-tree
> +echo "dump tree result for ino $ino:" >> $seqres.full
> +cat $tmp.dump-tree >> $seqres.full
> +
> +grep -q "inline extent" $tmp.dump-tree || echo "no inline extent found"
> +grep -q "compression 1" $tmp.dump-tree || echo "no compressed extent fou=
nd"
> +
> +echo "Silence is golden"

While here, we could also check that we are able to read exactly what
we wrote before, after evicting the page (e.g. after a call to
_scratch_cycle_mount).
Other than that, it looks ok.

Thanks.


> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/246.out b/tests/btrfs/246.out
> new file mode 100644
> index 00000000..287f7983
> --- /dev/null
> +++ b/tests/btrfs/246.out
> @@ -0,0 +1,2 @@
> +QA output created by 246
> +Silence is golden
> --
> 2.31.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
