Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB0C371341
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 May 2021 11:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhECJzO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 May 2021 05:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbhECJzO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 May 2021 05:55:14 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B734C06174A;
        Mon,  3 May 2021 02:54:21 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id o5so4453128qkb.0;
        Mon, 03 May 2021 02:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=9RpqQfQakx5sccBn/igrW39urW9z+0J3JA5W7+w7hEQ=;
        b=f63wDXNpYH/vT+N+h88MSOz4O5MhUnIK5yXTmvgg09coOnwCik8Vt+6GagHpB2est0
         6/wLEltn8Fvld6QzjnKgHuE382lbKZtYNo0s7j6w0VSjcAUigmY4nFXTpdSTiSRvwvpA
         TE02+mEqnNC69oVKX4rdzhKsiafpsL0xL4spVd9QDxJO/DijJZKGJvFaqLHs3Fhs8YzL
         rycU2z+M3AM8v2YxxEMyIUTHpipDjxUxDjapP4TsvLxwMNJuC1PHv4rohvmrPsaicnu7
         z/nnYBqVbjhW6rgjepGhvbOJEFz7EnjXKlpmeh0KioTAvKl4x8QRu78mN2dMqozDeO3/
         jBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=9RpqQfQakx5sccBn/igrW39urW9z+0J3JA5W7+w7hEQ=;
        b=Q/UQYzr+laZph1hwgzZfajbZfqzwQWfrOc7Gzo36ofMfIOLDVBp5TgoAvqHV08ZmOn
         BJDnSSsCEfpr7OfKB3ztGaIX8GZ1FAqRsv4bp3kAmOMJi2fqx/Pt3NB5MDOK0Yg+uq9y
         UCbmnlH1FbqtJhNvj0RZj+ahjOuOK8Bi3HmRZ1/5pswrlLctS/EHmGpkSlqdQv45AOBZ
         ld+3+LsdskfTnVMrymbBpfGh9DJLZV1pjz8halJhRB28atbjncFRHWj4BYg8kDXJynFb
         44/tHUn0dWMa0ybQcwBUtMuw258E/zVaL+d5fXSWB5WbeBbkkHHQMD8csz8i2eR0ZPLK
         r+2Q==
X-Gm-Message-State: AOAM532fJLUPQV/dmNYjgJQQazH2u1aMtWwo6QSWLtI7oRPX5rlz0CQa
        GiBVDzMcuDeh76+hRcFm9TC4YBsum4kU4rAdC6Y=
X-Google-Smtp-Source: ABdhPJyd16W8BtO8y6twUnQCWKI6AGS57F3JXGwLqGYBp0CEyiG4+UzvN4BCOQDWj7MiJTcvJT4lthYUd+4u5PxBuPk=
X-Received: by 2002:a05:620a:1326:: with SMTP id p6mr9028183qkj.438.1620035660469;
 Mon, 03 May 2021 02:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <96fe1c0c8747d24ad6c45bc3f0a5551b8e1ebbde.1619793258.git.anand.jain@oracle.com>
 <7ff015576992de7e8d6ff554c27c420a9ffa1595.1619800208.git.anand.jain@oracle.com>
In-Reply-To: <7ff015576992de7e8d6ff554c27c420a9ffa1595.1619800208.git.anand.jain@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 3 May 2021 10:54:09 +0100
Message-ID: <CAL3q7H79zG9rm-kOu7rys=ev0Ja_fuTNoYvdz0q6hwgqyQrhkg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: add fstrim test case on the sprout device
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe David Borba Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 1, 2021 at 6:24 AM Anand Jain <anand.jain@oracle.com> wrote:
>
> Add fstrim test case on the sprout device, verify seed device
> integrity.
>
>  btrfs: fix unmountable seed device after fstrim
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2:
>   Add _require_fstrim and _require_batched_discard.
>   Use FSTRIM_PROG.
>   Use _filter_ro_mount to handle the difference in output in different
>      mount(8) version.
>   Call _scratch_dev_pool_put.
>   Add _check_btrfs_filesystem $seed to check the whole seed fs.
>   Update in-code comments.
>
>  tests/btrfs/236     | 81 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/236.out |  5 +++
>  tests/btrfs/group   |  1 +
>  3 files changed, 87 insertions(+)
>  create mode 100755 tests/btrfs/236
>  create mode 100644 tests/btrfs/236.out
>
> diff --git a/tests/btrfs/236 b/tests/btrfs/236
> new file mode 100755
> index 000000000000..aac27fac06dd
> --- /dev/null
> +++ b/tests/btrfs/236
> @@ -0,0 +1,81 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Oracle. All Rights Reserved.
> +#
> +# FS QA Test 236
> +#
> +# Check seed device integrity after fstrim on the sprout device.
> +#
> +#  Kernel bug is fixed by the commit:
> +#    btrfs: fix unmountable seed device after fstrim
> +
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
> +_require_command "$BTRFS_TUNE_PROG" btrfstune
> +_require_fstrim
> +_require_scratch_dev_pool 2
> +_scratch_dev_pool_get 2
> +
> +seed=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
> +sprout=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
> +
> +_mkfs_dev $seed
> +_mount $seed $SCRATCH_MNT
> +
> +$XFS_IO_PROG -f -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foo > /dev/null
> +_scratch_unmount
> +$BTRFS_TUNE_PROG -S 1 $seed
> +
> +# Mount the seed device and add the rw device
> +_mount $seed $SCRATCH_MNT 2>&1 | _filter_ro_mount | _filter_scratch
> +md5sum $SCRATCH_MNT/foo | _filter_scratch
> +
> +$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT
> +_scratch_unmount
> +
> +# Now remount writeable sprout device, create some data and run fstrim
> +_mount $sprout $SCRATCH_MNT
> +_require_batched_discard $SCRATCH_MNT
> +
> +$XFS_IO_PROG -f -c "pwrite -S 0xcd 0 1M" $SCRATCH_MNT/bar > /dev/null

We aren't doing anything with this file ("bar"). Just remove it.

Otherwise it passes now with the filter.

Thanks.

> +
> +$FSTRIM_PROG $SCRATCH_MNT
> +
> +_scratch_unmount
> +
> +# Verify seed device is all ok
> +_mount $seed $SCRATCH_MNT 2>&1 | _filter_ro_mount | _filter_scratch
> +md5sum $SCRATCH_MNT/foo | _filter_scratch
> +_scratch_unmount
> +
> +_check_btrfs_filesystem $seed
> +
> +_scratch_dev_pool_put
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/236.out b/tests/btrfs/236.out
> new file mode 100644
> index 000000000000..01699b8fc291
> --- /dev/null
> +++ b/tests/btrfs/236.out
> @@ -0,0 +1,5 @@
> +QA output created by 236
> +mount: device write-protected, mounting read-only
> +096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
> +mount: device write-protected, mounting read-only
> +096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 331dd432fac3..5032259244e0 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -238,3 +238,4 @@
>  233 auto quick subvolume
>  234 auto quick compress rw
>  235 auto quick send
> +236 auto quick seed trim
> --
> 2.27.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
