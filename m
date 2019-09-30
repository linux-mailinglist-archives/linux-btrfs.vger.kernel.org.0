Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 037DBC1EF1
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 12:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbfI3Kdt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 06:33:49 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38124 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbfI3Kdt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 06:33:49 -0400
Received: by mail-vs1-f67.google.com with SMTP id b123so6394350vsb.5;
        Mon, 30 Sep 2019 03:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=bCGscPt1hwXu4Sog2iwtoW1gzZpbXzmRUrtd6xcWnrs=;
        b=c3SYlzBuoO3b+Q9El/Eh16IE/uNBjMHF86CxLBkprfegNbyg6LbKRzN9mod447Y5xn
         jEBleVqYAFu8Ydk5Rrh9ZNrSsu8KS+eS6LThipZ3kEfAzt8Mu/XPSYcghqwlqVqM6ej0
         QpL+6t1oYPpwQylYix4hc+XDWKW2lrMS7tYWjQ1sJ+rULVUQiEdy7kvkMEc9v/3pZcc6
         f2DOkoUGuK/LOA8BLDX5XpiVo5FDjhKV/12rP79SGc7QJ882295jvVWEU0z4OIuSLVWH
         JchyHu3jZW3yTF5W1XjYoFZ8rmlZq3Njh+22yUITzwzC7neUDz0AQI1uR7uM/sxoEnPX
         6I7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=bCGscPt1hwXu4Sog2iwtoW1gzZpbXzmRUrtd6xcWnrs=;
        b=uhPZfqY2gZgAP07DUIhlBwpco+UeatfwdVIayngOqQcVLuas011kxw2/I2tv3TL62Z
         NZ+OvOItBDCVruVJpN7V4Lw8PbqFq+XuDOrTUNP/CC8jsowy9klhsIccFhM9N1NPU5gO
         6fjry6rnAr0T6QZM476iNlHqQtpGkJ36YjR8mw30hQjt4bzeOLYivVG8k9yNIj7ba33Z
         yrfKgbnr0KWk56nkp9vp83JTVqFB1/Kn0T+wUlhEdEnvhM/ZNv1fI8vhgwXMRCxlqm0H
         AQi2ziF9DvcPZaHX5Cuv1IjfIi4cOpHF1lcJLz9LJecdWPXpXlLwO/RPwM0PoFq8tP+C
         o9PA==
X-Gm-Message-State: APjAAAX+Je9+Jbq6soWZMZIJ+qED6vUduO6McQHw7/R+SjCv1sLTcJk1
        raYPA++2JdmpBk5jKR/FasS1x+bAX/3ZFHqOmk6kgijl
X-Google-Smtp-Source: APXvYqyBUa/b92IGgFJzN8NnMN2qO+KcY5QG0cx0Pnd72e06qn4374E8j7CXl3W4M3gwstzpWgZTfYLypqbI+JtTojA=
X-Received: by 2002:a67:6044:: with SMTP id u65mr8808809vsb.95.1569839626646;
 Mon, 30 Sep 2019 03:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190930083735.21284-1-wqu@suse.com>
In-Reply-To: <20190930083735.21284-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 30 Sep 2019 11:33:35 +0100
Message-ID: <CAL3q7H5mVHUQJ31wANwM8hXbbumwcUNrxSCebv46zpgEGYA2zw@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: Add regression test to check if btrfs can
 handle high devid
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 30, 2019 at 9:39 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Add a regression test to check if btrfs can handle high devid.
>
> The test will add and remove devices to a btrfs fs, so that the devid
> will increase to uncommon but still valid values.
>
> The regression is introduced by kernel commit ab4ba2e13346 ("btrfs:
> tree-checker: Verify dev item").
> The fix is titled "btrfs: tree-checker: Fix wrong check on max devid".
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/194     | 73 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/194.out |  2 ++
>  tests/btrfs/group   |  1 +
>  3 files changed, 76 insertions(+)
>  create mode 100755 tests/btrfs/194
>  create mode 100644 tests/btrfs/194.out
>
> diff --git a/tests/btrfs/194 b/tests/btrfs/194
> new file mode 100755
> index 00000000..7a52ed86
> --- /dev/null
> +++ b/tests/btrfs/194
> @@ -0,0 +1,73 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 194
> +#
> +# Test if btrfs can handle large device ids.
> +#
> +# The regression is introduced by kernel commit ab4ba2e13346 ("btrfs:
> +# tree-checker: Verify dev item").
> +# The fix is titlted: "btrfs: tree-checker: Fix wrong check on max devid=
"

type, titlted -> titled

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
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch_dev_pool 2
> +_scratch_dev_pool_get 2
> +
> +# The wrong check limit is based on node size, to reduce runtime, we onl=
y
> +# support 4K page size system for now
> +if [ $(get_page_size) !=3D 4096 ]; then
> +       _notrun "This test need 4k page size"
> +fi
> +
> +device_1=3D$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
> +device_2=3D$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> +
> +echo device_1=3D$device_1 device_2=3D$device_2 >> $seqres.full
> +
> +# Use 4K nodesize to reduce runtime

How does the node size reduces runtime?
It's obvious when one wants to create deeper/larger trees for some
purpose, but this test doesn't populate the filesystem, it uses an
empty filesystem.
So that deserves an explanation of how the node size influences the
test's running time.

> +_scratch_mkfs -n 4k >> $seqres.full
> +_scratch_mount
> +
> +# Add and remove device in a loop, one loop will increase devid by 2.

" ... one loop will ..." -> "... each iteration will ..."

> +# for 4k nodesize, the wrong check will be triggered at devid 123.

Why 123? It's not clear to me why, the test case doesn't explain and
neither does the btrfs patch that fixes the regression.
If it's related to the value of the constants/functions
BTRFS_MAX_DEVS and BTRFS_MAX_DEVS_SYS_CHUNK, it should be mentioned
here.

> +# here 64 is enough to trigger such regression
> +for (( i =3D 0; i < 64; i++ )); do
> +       $BTRFS_UTIL_PROG device add -f $device_2 $SCRATCH_MNT
> +       $BTRFS_UTIL_PROG device del $device_1 $SCRATCH_MNT
> +       $BTRFS_UTIL_PROG device add -f $device_1 $SCRATCH_MNT
> +       $BTRFS_UTIL_PROG device del $device_2 $SCRATCH_MNT
> +done
> +_scratch_dev_pool_put
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/194.out b/tests/btrfs/194.out
> new file mode 100644
> index 00000000..7bfd50ff
> --- /dev/null
> +++ b/tests/btrfs/194.out
> @@ -0,0 +1,2 @@
> +QA output created by 194
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index b92cb12c..ef1f0e1b 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -196,3 +196,4 @@
>  191 auto quick send dedupe
>  192 auto replay snapshot stress
>  193 auto quick qgroup enospc limit
> +194 auto

Maybe volume group as well.

Thanks Qu.

> --
> 2.22.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
