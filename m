Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08933166261
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 17:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgBTQYu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 11:24:50 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44752 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgBTQYt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 11:24:49 -0500
Received: by mail-vs1-f65.google.com with SMTP id p6so3021982vsj.11;
        Thu, 20 Feb 2020 08:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=FhdCyKjZbHfoDKbCRkBESDk5Zw2plmBm+404Yl8BWKI=;
        b=bnee3yO6qjyOEBEdQmOK3/FjVE0AxdITFh27+wtdfEBvwGPmLwYJx0l/UpSdWvdV/a
         CwwyaefNXsRMa7a+X28cT1IYm/uCAQGuzU+cxjhzne+8Kzf6j+p6p+uiJk92w7TSthTA
         vDR+sfe5lc+PFy8/PrW54sfpyFyIvz6PlLir0kuzmpx5IH8802DvB/h0utnkICtCn//7
         iGIxmzUYn6xEeDJPl+oeDnKy0lkuxwYR9pu6vLW0cGcxnV+kO6RINPTwJSPsjzu1vIW8
         S6e8gb2i0ggaZvtsO2MeLen09rw9CcsZ/NapamuPny8MjHrp8CRSJrWdxiMpptmNz1u7
         5c4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=FhdCyKjZbHfoDKbCRkBESDk5Zw2plmBm+404Yl8BWKI=;
        b=k6kIhUgYisfd6EqwZt4G9USK7r/RpJrg+ZIKcLU7Q/WP80XSaWagr8wFNPeMPXk64R
         MxZ5e3RoZaIVs5CsmjlAB/Mf/K0iIBaYjrzbpR5O/ri640gPyYqrldV6Jk0yIarfNX0n
         m1u9+wZNk+ibalkcrxVq0dEfSraap2eYkE0pElhkbdthbwOOMgGXuMnnPUXTziUwIl/p
         /cmgT6uD0sprQUKlmD39o9HAno9Nlc7ade2XAaGe3s0NWD6FwbAfwZ6MC+mADWB4MomQ
         Q9NOApZIF67ik4e6EiwkxvpPt28z7TBoIc35TBDzkJgMdjD0RsmMqvk/OyiIywTg5Gxt
         6U9g==
X-Gm-Message-State: APjAAAVJzL9IuPnpo6TVpPpuFarWU4LNfvGs5LnADiubsCNwiJrJtKrd
        IW/ui1sCtXMcJ4VsXuCITMkSjqU5CwXKaOhOBiA=
X-Google-Smtp-Source: APXvYqwFJr+v+UeMjpi1ZeGJg0QO6VQMwUss5a5K88vgBxBRYI10LRAhcWULdKF9LGRfNANoHn5sgxWKWNj8Fjus5Ok=
X-Received: by 2002:a05:6102:18f:: with SMTP id r15mr17425773vsq.206.1582215888433;
 Thu, 20 Feb 2020 08:24:48 -0800 (PST)
MIME-Version: 1.0
References: <20200220143855.3883650-1-josef@toxicpanda.com>
In-Reply-To: <20200220143855.3883650-1-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 20 Feb 2020 16:24:37 +0000
Message-ID: <CAL3q7H7UaJ-_aT4-Ab1eheVJUDwyuc6UQ6-Q9cQZCU1GqjuSGQ@mail.gmail.com>
Subject: Re: [PATCH] fstests: add a another gap extent testcase for btrfs
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 20, 2020 at 2:39 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> This is a testcase for a corner that I missed when trying to fix gap
> extents for btrfs.  We would end up with gaps if we hole punched past
> isize and then extended past the gap in a specific way.  This is a
> simple reproducer to show the problem, and has been properly fixed by my
> patches now.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  tests/btrfs/204     | 85 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/204.out |  5 +++
>  tests/btrfs/group   |  1 +
>  3 files changed, 91 insertions(+)
>  create mode 100755 tests/btrfs/204
>  create mode 100644 tests/btrfs/204.out
>
> diff --git a/tests/btrfs/204 b/tests/btrfs/204
> new file mode 100755
> index 00000000..0d5c4bed
> --- /dev/null
> +++ b/tests/btrfs/204
> @@ -0,0 +1,85 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Facebook.  All Rights Reserved.
> +#
> +# FS QA Test 204
> +#
> +# Validate that without no-holes we do not get a i_size that is after a =
gap in
> +# the file extents on disk when punching a hole past i_size.  This is fi=
xed by
> +# the following patches
> +#
> +#      btrfs: use the file extent tree infrastructure
> +#      btrfs: replace all uses of btrfs_ordered_update_i_size
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
> +_supported_fs generic
> +_supported_os Linux
> +_require_test
> +_require_scratch
> +_require_log_writes

_require_xfs_io_command "falloc" "-k"
_require_xfs_io_command "fpunch"

> +
> +_log_writes_init $SCRATCH_DEV
> +_log_writes_mkfs "-O ^no-holes" >> $seqres.full 2>&1
> +
> +# There's not a straightforward way to commit the transaction without al=
so
> +# flushing dirty pages, so shorten the commit interval to 1 so we're sur=
e to get
> +# a commit with our broken file
> +_log_writes_mount -o commit=3D1
> +
> +# This creates a gap extent because fpunch doesn't insert hole extents p=
ast
> +# i_size
> +xfs_io -f -c "falloc -k 4k 8k" $SCRATCH_MNT/file
> +xfs_io -f -c "fpunch 4k 4k" $SCRATCH_MNT/file
> +
> +# The pwrite extends the i_size to cover the gap extent, and then the tr=
uncate
> +# sets the disk_i_size to 12k because it assumes everything was a-ok.
> +xfs_io -f -c "pwrite 0 4k" $SCRATCH_MNT/file | _filter_xfs_io
> +xfs_io -f -c "pwrite 0 8k" $SCRATCH_MNT/file | _filter_xfs_io
> +xfs_io -f -c "truncate 12k" $SCRATCH_MNT/file
> +
> +# Wait for a transaction commit
> +sleep 2
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
> diff --git a/tests/btrfs/204.out b/tests/btrfs/204.out
> new file mode 100644
> index 00000000..44c7c8ae
> --- /dev/null
> +++ b/tests/btrfs/204.out
> @@ -0,0 +1,5 @@
> +QA output created by 204
> +wrote 4096/4096 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 8192/8192 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 6acc6426..7a840177 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -206,3 +206,4 @@
>  201 auto quick punch log
>  202 auto quick subvol snapshot
>  203 auto quick send clone
> +204 auto quick log replay

"prealloc" and "punch" groups as well.

Since this just tests another variant of the same problem, maybe it
could be added to btrfs/172, since that test is very recent and you
authored it as well.
Anyway, I don't have a strong preference.

The test itself looks good to me, and with the _require_xfs_io_command
thing added and the groups (maybe Eryu can add these at commit time):

Reviewed-by: Filipe Manana <fdmanana@suse.com>


> --
> 2.24.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
