Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADF8A14EA18
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 10:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgAaJd1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 04:33:27 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:35901 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgAaJd0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 04:33:26 -0500
Received: by mail-vk1-f194.google.com with SMTP id i4so1893596vkc.3;
        Fri, 31 Jan 2020 01:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=LLTVrBQ2QFZki5/mkGlwfjp46hmKmmnDdD7OZ/7u1Bo=;
        b=X0ANLcEDK3lHDZ8+S9muWgTSlhvdnlcpFHQK5ed6hWcqGUW5nDZkoQibVN+xu0k41N
         q0rAHAEnPo5o8xKEWEnWpDplEZsqA1qZnP+RbbfhGDw2xMApy+pVDBvE0Zrr+QoF4lxm
         JD/lhwXRiTpryVCY8PtWDErw+A7ZhYxOAgnLI/iHZe/qaIn+o/Pw4z929JKEW3z3SfHR
         bJEds0xdohkZScsL9AEDhw4F+wuNh/C3ENnj+nT75Qw4KSA+XwJ+EqJOOX+c1BKRrm0o
         00puvp5nGnELFI9VvbgzRyoQFLrTAQu5iZ2JpD5N3ABpXdwmPpJYXERcy2oWlzfPf0cT
         MgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=LLTVrBQ2QFZki5/mkGlwfjp46hmKmmnDdD7OZ/7u1Bo=;
        b=VGUo1Wzz9PmRN1O7UjuUlDzom/IsRu+sdwv2Tl6A6s0YDlQzFgDcJepZVqbaFsk3Tu
         c+LYmk08KorxfvYJ89yo1oKttocviFJ4V8DHWbTUAHn8dVGBcvTaL+hWZS9k3F2Z3hLD
         FY04Ds1x8OF0flvTCFEAHxPV50lDntZ+C2ZcXGlMIDnqKMfYg3uyAHmcf+VgvhQhD9MM
         JSdNbKQMQjthpgBwkjwYkHzgpuJNhs+8XVJtltu5ktj5qp9CfsRR+5ldKZ4PTEAKJyEc
         JIAgwyc/YHqwSiNu7A7vV6tDrv79Clm6okpcrec/6J8VQIAJhV/wj0/FHFmkQHcI7qx9
         NX+A==
X-Gm-Message-State: APjAAAXdqBVRq/TaUGMv0bw+3uYjCWiBDVHc6ZC5XoStHsm/lOl5+bR0
        X6Pn0AWvhx63owRvmP8G+teMf7fqFRUvPIcDRwU=
X-Google-Smtp-Source: APXvYqyH4TOYkqttr+yFOA1QmnCH0q2x79ISJeMNs7WS19+7uJYqGs98OfzD2cjC0Aods7nRocbd6qOJ3a+zTaOsKa0=
X-Received: by 2002:a05:6122:1065:: with SMTP id k5mr5758329vko.14.1580463205694;
 Fri, 31 Jan 2020 01:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20200130205244.50551-1-josef@toxicpanda.com>
In-Reply-To: <20200130205244.50551-1-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 31 Jan 2020 09:33:14 +0000
Message-ID: <CAL3q7H7Axfd1uB82=-U+Nt_fdhBpUVVHHt+Qv9SS1c3kjkz_nw@mail.gmail.com>
Subject: Re: [PATCH] xfstest: add a test for the btrfs file extent gap issue
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 30, 2020 at 8:52 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> This is a test to validate that we're not adjusting up i_size before we
> have the appropriate file extents on disk.  We had a problem where
> i_size would be adjusted up without a contiguous range of file extents,
> which isn't ok without a special option enabled.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  tests/btrfs/172     | 74 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/172.out |  3 ++
>  tests/btrfs/group   |  1 +
>  3 files changed, 78 insertions(+)
>  create mode 100755 tests/btrfs/172
>  create mode 100644 tests/btrfs/172.out
>
> diff --git a/tests/btrfs/172 b/tests/btrfs/172
> new file mode 100755
> index 00000000..8c0c94d6
> --- /dev/null
> +++ b/tests/btrfs/172
> @@ -0,0 +1,74 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Facebook.  All Rights Reserved.
> +#
> +# FS QA Test 172
> +#
> +# Validate that without no-holes we do not get an i_size that is after a=
 gap in
> +# the file extents on disk.  This is fixed by the series
> +#
> +#     btrfs: fix hole corruption issue with !NO_HOLES

A list of the patch subjects would be better imho, since those are
grepable in git.

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
> +. ./common/dmlogwrites
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch
> +_require_log_writes

Missing:  _require_xfs_io_command "sync_range"

> +
> +_log_writes_init $SCRATCH_DEV
> +_log_writes_mkfs "-O ^no-holes" >> $seqres.full 2>&1
> +
> +# There's not a straightforward way to commit the transaction without al=
so
> +# flushing dirty pages, so shorten the commit interval to 5 so we're sur=
e to get
> +# a commit with our broken file
> +_log_writes_mount -o commit=3D5
> +
> +$XFS_IO_PROG -f -c "pwrite 0 5m" $SCRATCH_MNT/file | _filter_xfs_io
> +$XFS_IO_PROG -f -c "sync_range -abw 2m 1m" $SCRATCH_MNT/file | _filter_x=
fs_io
> +
> +# Now wait for a transaction commit to happen, wait 2x just to be super =
sure
> +sleep 10

Could be 6s. Saving test run time for something so trivial.

> +
> +_log_writes_unmount
> +_log_writes_remove
> +
> +cur=3D$(_log_writes_find_next_fua 0)
> +echo "cur=3D$cur" >> $seqres.full
> +while [ ! -z "$cur" ]; do
> +       _log_writes_replay_log_range $cur $SCRATCH_DEV >> $seqres.full
> +
> +       # We only care about the fs consistency, so just run fsck, we don=
't have
> +       # to mount the fs to validate it
> +       _check_scratch_fs
> +
> +       cur=3D$(_log_writes_find_next_fua $(($cur + 1)))
> +done
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/172.out b/tests/btrfs/172.out
> new file mode 100644
> index 00000000..45051739
> --- /dev/null
> +++ b/tests/btrfs/172.out
> @@ -0,0 +1,3 @@
> +QA output created by 172
> +wrote 5242880/5242880 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 4b64bf8b..527fbbf1 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -174,6 +174,7 @@
>  169 auto quick send
>  170 auto quick snapshot
>  171 auto quick qgroup
> +172 auto quick

Missing 'log' and 'replay' groups, like all other dmlogwrites tests.

Other than that it looks good, thanks.

>  173 auto quick swap
>  174 auto quick swap
>  175 auto quick swap volume
> --
> 2.24.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
