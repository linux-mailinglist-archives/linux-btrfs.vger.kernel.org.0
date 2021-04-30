Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10DF36FDBB
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 17:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhD3P0E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Apr 2021 11:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhD3P0A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Apr 2021 11:26:00 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C16C06174A;
        Fri, 30 Apr 2021 08:25:11 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id q127so11847209qkb.1;
        Fri, 30 Apr 2021 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=GQFZzIn3cqXmJfhDczA+sivtyw37IjaUrU4YZFnoO10=;
        b=j2hE4sCq3qkjtoKHXSrEgJvCYw3EBNjcG+sbJnRqq/9aIHKSiLTV/nYPMfHGNVZmlF
         VE/1IrrYOZ82OXqzgn+RWVdpCXZtTrZj+xrbQTSB+PPVcwzSXjFiUR7iezjnJzS9duNi
         GMBbEjD+T3Jd9SBUOUsM5qm4Xq5oF1murkkrNMVOYKDCpyyfcYWHXacT7idtb63Ae7St
         CaflxnljnlLKCme2o3pfJIVRkB5Anlr0AdrvW4uXR7/8++O9yN4qo2aSUkL9h0h5sqAj
         Xin16M6Zs9rJuctxczMklIEy38hpqXJAsNAVN2WkHI0aUqMC6tSbFydMFtzytqm8Wftf
         lr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=GQFZzIn3cqXmJfhDczA+sivtyw37IjaUrU4YZFnoO10=;
        b=mIdoEBEIjEalmTC5UgrfWvyCYt4vPS40GQ1/ZCwSQUNdcRXVb3GTlu2lDxZPx7ppRg
         CDRiTKuWwLa1q0jBvaWdVtPBjdPFNh3nJgcPr7SkG++3NUxma6VfXqqMmkL5k8EBcPnk
         Dgxdrb1578evqYqafbMT4NqNKBtt3L056jnHCuR0AxGfb8phwRNYaEQVsbaLfuz/6rzp
         nYF2iNxdr44/9PjjJg4Oq/t+oarKM4q82OiIu0XU5c86zQ5o8W9714U+bk3yl87n1MlJ
         drqQRC9Qbnu1mTgUZWm2wUl2sMDdXdZ4r+iqIvSMkwGsrEzKi0dn6O6hfdizgjyeFWdJ
         LUjg==
X-Gm-Message-State: AOAM533FR7EB4xv/z6szn6umwbNbDLSKaHHL7T1qad3tSnL/eiZ60AvT
        aUYVA77er5mKfxyPy80FJ4TJFQjcenHW+mbgw9M=
X-Google-Smtp-Source: ABdhPJwfvDZQKhdiSs1JkENh+kMobJPwU0MksaGaSxQpiaZDcfR2lO50uk4TBiHScvkBIs2+s0rqxwq3iSjzEcO97LA=
X-Received: by 2002:a37:b741:: with SMTP id h62mr6051235qkf.383.1619796310875;
 Fri, 30 Apr 2021 08:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <d6fcae756c5ce47da3527e5db4760d676420d950.1619783910.git.anand.jain@oracle.com>
 <96fe1c0c8747d24ad6c45bc3f0a5551b8e1ebbde.1619793258.git.anand.jain@oracle.com>
In-Reply-To: <96fe1c0c8747d24ad6c45bc3f0a5551b8e1ebbde.1619793258.git.anand.jain@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 30 Apr 2021 16:24:59 +0100
Message-ID: <CAL3q7H4-zRWVpTnxmQ-VkCmQ8hWvd5L_5ouC7CEWPgHwxMbqqQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add fstrim test case on the sprout device
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 30, 2021 at 3:40 PM Anand Jain <anand.jain@oracle.com> wrote:
>
> Add fstrim test case on the sprout device, verify seed device
> integrity.
>
> Needs kernel patch [1] to pass the test case.
> [1]
>   btrfs: fix unmountable seed device after fstrim
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/236     | 72 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/236.out |  5 ++++
>  tests/btrfs/group   |  1 +
>  3 files changed, 78 insertions(+)
>  create mode 100755 tests/btrfs/236
>  create mode 100644 tests/btrfs/236.out
>
> diff --git a/tests/btrfs/236 b/tests/btrfs/236
> new file mode 100755
> index 000000000000..599892bebf10
> --- /dev/null
> +++ b/tests/btrfs/236
> @@ -0,0 +1,72 @@
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
> +_require_scratch_dev_pool 2
> +_scratch_dev_pool_get 2
> +
> +seed=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
> +sprout=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
> +
> +_mkfs_dev $seed
> +_mount $seed $SCRATCH_MNT

Missing the check for discard/trim support:

_require_batched_discard $SCRATCH_MNT

> +
> +$XFS_IO_PROG -f -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foo > /dev/null
> +_scratch_unmount
> +$BTRFS_TUNE_PROG -S 1 $seed
> +
> +# Mount the seed device and add the rw device
> +_mount $seed $SCRATCH_MNT 2>&1 | _filter_scratch
> +md5sum $SCRATCH_MNT/foo | _filter_scratch
> +
> +$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT
> +_scratch_unmount
> +
> +# Now remount
> +_mount $sprout $SCRATCH_MNT
> +$XFS_IO_PROG -f -c "pwrite -S 0xcd 0 1M" $SCRATCH_MNT/bar > /dev/null
> +
> +fstrim $SCRATCH_MNT

Should use $FSTRIM_PROG instead of fstrim.

> +
> +_scratch_unmount
> +_mount $seed $SCRATCH_MNT 2>&1 | _filter_scratch
> +md5sum $SCRATCH_MNT/foo | _filter_scratch
> +_scratch_unmount

Missing a call to _scratch_dev_pool_put

> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/236.out b/tests/btrfs/236.out
> new file mode 100644
> index 000000000000..2929d39395a8
> --- /dev/null
> +++ b/tests/btrfs/236.out
> @@ -0,0 +1,5 @@
> +QA output created by 236
> +mount: SCRATCH_MNT: WARNING: device write-protected, mounted read-only.
> +096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
> +mount: SCRATCH_MNT: WARNING: device write-protected, mounted read-only.
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

Ok, it fails as expected without the btrfs fix.
But with the fix applied, it fails differently for me. It looks like
different mount versions output different strings maybe:

root 16:18:40 /home/fdmanana/git/hub/xfstests (master)> ./check btrfs/237
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian8 5.12.0-rc8-btrfs-next-86 #1 SMP
PREEMPT Fri Apr 23 17:35:49 WEST 2021
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

btrfs/237 - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/237.out.bad)
    --- tests/btrfs/237.out 2021-04-30 16:09:33.103380077 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/237.out.bad
2021-04-30 16:19:31.577988213 +0100
    @@ -1,5 +1,5 @@
     QA output created by 237
    -mount: SCRATCH_MNT: WARNING: device write-protected, mounted read-only=
.
    +mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only=
.
     096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
    -mount: SCRATCH_MNT: WARNING: device write-protected, mounted read-only=
.
    +mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only=
.
     096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/237.out
/home/fdmanana/git/hub/xfstests/results//btrfs/237.out.bad'  to see
the entire diff)
Ran: btrfs/237
Failures: btrfs/237
Failed 1 of 1 tests

root 16:19:31 /home/fdmanana/git/hub/xfstests (master)> diff -u
/home/fdmanana/git/hub/xfstests/tests/btrfs/237.out
/home/fdmanana/git/hub/xfstests/results//btrfs/237.out.bad
--- /home/fdmanana/git/hub/xfstests/tests/btrfs/237.out 2021-04-30
16:09:33.103380077 +0100
+++ /home/fdmanana/git/hub/xfstests/results//btrfs/237.out.bad
2021-04-30 16:19:31.577988213 +0100
@@ -1,5 +1,5 @@
 QA output created by 237
-mount: SCRATCH_MNT: WARNING: device write-protected, mounted read-only.
+mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
 096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
-mount: SCRATCH_MNT: WARNING: device write-protected, mounted read-only.
+mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
 096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
root 16:20:06 /home/fdmanana/git/hub/xfstests (master)>

Thanks.

> --
> 2.27.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
