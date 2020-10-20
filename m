Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83736293C33
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Oct 2020 14:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406676AbgJTMv4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Oct 2020 08:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406604AbgJTMv4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Oct 2020 08:51:56 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D20C061755;
        Tue, 20 Oct 2020 05:51:56 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id r8so1055858qtp.13;
        Tue, 20 Oct 2020 05:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=FA3cuFpXSnqWM8aXiRBabyjYhfs7bIWu9gsbJfABHi8=;
        b=Vtbs8DlZ+jnL7KHhZnj70srN4isLlPr7pa2nneccVwAoYYGkf5lzj2UF/in9TROHl6
         lnFCsb6SF/tM/CBi7H/1PmioeV+s9KzJIp8AWL4my/1JK3JBvTT8dO0+dgWKaoAjiXbk
         bQKE8pw2VfRfAIU97dQaNTg8eugqUgB3xnKugYPgwYQq3ps27OKvE/gQNDlO7n1aodUK
         jdpmyNXw0abeIH7BDuhMWYBFnjGko5zMeYTwEU4zIMYV42pnDRafBum64rKBjcM4IsC7
         2qU4r9mzR59TLGcbdRNQobgdkPbzXcrHTiKyW7BeliksfXhPf74Tmsgp6RgBRCKDiN9h
         Ux5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=FA3cuFpXSnqWM8aXiRBabyjYhfs7bIWu9gsbJfABHi8=;
        b=efH2Tv8OHjh6tXQQkFYSYCaRxrbW9NQloyAGGNJTBF8hTirJ08b/Ub9JVzC/6ZOpqa
         P9pNjF8fY/z0Vbnz/C+4umoXOXf6X8ttpqZM4ohVDYQtEIx3X0xRUiVL/bLDXJkw5dP1
         Vo0+F2sCiGuGmOv3Mbc7KMiQhGS0aoqcDn5aydgYVAt11zHUA0V5Q5bCdFgFMk4MV72z
         lUjtxEbzOrm7esoZNBiah5i8dXayMQk/Euv+rUppaRBexOelHl6vWcYBfuqMyX2aGnva
         GK1z4mn8s1nvqg9g59E2oMX9dSKP1IRvl6sklFYKEZkYsVBm142rBZgbQwjq5fRbv1uw
         o2ow==
X-Gm-Message-State: AOAM532KtIa4j0nJuwh35IbTruRQDEYthpXJ7Z3ZFQm3sikl7QnFNw56
        fxRaTNlF/aAzhSERPmfLr2nCCYIwlMSWVzElvDJgOu4NM+k=
X-Google-Smtp-Source: ABdhPJw/iDgyyazX5kdf133aO/B7DDmwNX5/87u3EE4SDmkl9YaUuPQDr1/BWcTwYvDngmzF2BJAnkhasYJEc7O/keE=
X-Received: by 2002:ac8:832:: with SMTP id u47mr2248347qth.376.1603198315478;
 Tue, 20 Oct 2020 05:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603196609.git.anand.jain@oracle.com> <07f630546b05c655fc68c38a695f67176673aa21.1603196609.git.anand.jain@oracle.com>
In-Reply-To: <07f630546b05c655fc68c38a695f67176673aa21.1603196609.git.anand.jain@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 20 Oct 2020 13:51:44 +0100
Message-ID: <CAL3q7H7QnfLnBTqXg-pBguDpZ-Uv-USgxbK9c6ruLRbdhSZRKQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] btrfs: add a test case for btrfs seed device delete
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 20, 2020 at 1:34 PM Anand Jain <anand.jain@oracle.com> wrote:
>
> This is a regression test for the issue fixed by the kernel commit
> b5ddcffa3777 (btrfs: fix put of uninitialized kobject after seed device
> delete).
>
> In this test case, we verify the seed device delete on a sprouted
> filesystem.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> v3: Add commit id for the kernel patch mentioned in the change log and
> the header.
>     Fix to _supported_fs btrfs
>     Drop _supported_os Linux
>     Use define AWK_PROG
>     Drop the directIO in xfs_io it has no use
>     Make it a new test case 225
>
> v2: drop the sysfs layout check as it breaks the test-case backward
> compatibility.
>
>  tests/btrfs/225     | 82 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/225.out | 15 +++++++++
>  tests/btrfs/group   |  1 +
>  3 files changed, 98 insertions(+)
>  create mode 100755 tests/btrfs/225
>  create mode 100644 tests/btrfs/225.out
>
> diff --git a/tests/btrfs/225 b/tests/btrfs/225
> new file mode 100755
> index 000000000000..730d9645f34c
> --- /dev/null
> +++ b/tests/btrfs/225
> @@ -0,0 +1,82 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Oracle. All Rights Reserved.
> +#
> +# FS QA Test 225
> +#
> +# Test for seed device-delete on a sprouted FS.
> +# Requires kernel patch
> +#    b5ddcffa3777  btrfs: fix put of uninitialized kobject after seed de=
vice delete
> +#
> +# Steps:
> +#  Create a seed FS. Add a RW device to make it sprout FS and then delet=
e
> +#  the seed device.
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
> +_require_test
> +_require_scratch_dev_pool 2
> +
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
> +_mount -o ro $seed $SCRATCH_MNT
> +$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT
> +_scratch_unmount
> +
> +# Now remount
> +_mount $sprout $SCRATCH_MNT
> +$XFS_IO_PROG -f -c "pwrite -S 0xcd 0 1M" $SCRATCH_MNT/bar > /dev/null
> +
> +echo --- before delete ----
> +od -x $SCRATCH_MNT/foo
> +od -x $SCRATCH_MNT/bar
> +
> +$BTRFS_UTIL_PROG device delete $seed $SCRATCH_MNT
> +_scratch_unmount
> +_btrfs_forget_or_module_reload
> +_mount $sprout $SCRATCH_MNT
> +
> +echo --- after delete ----
> +od -x $SCRATCH_MNT/foo
> +od -x $SCRATCH_MNT/bar
> +
> +_scratch_dev_pool_put
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/225.out b/tests/btrfs/225.out
> new file mode 100644
> index 000000000000..2e5d6ebee2c3
> --- /dev/null
> +++ b/tests/btrfs/225.out
> @@ -0,0 +1,15 @@
> +QA output created by 225
> +--- before delete ----
> +0000000 abab abab abab abab abab abab abab abab
> +*
> +4000000
> +0000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
> +*
> +4000000
> +--- after delete ----
> +0000000 abab abab abab abab abab abab abab abab
> +*
> +4000000
> +0000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
> +*
> +4000000
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 9ad33baa8119..960981e57eb1 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -226,3 +226,4 @@
>  222 auto quick send
>  223 auto quick replace trim
>  224 auto quick qgroup
> +225 auto quick volume seed
> --
> 2.25.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
