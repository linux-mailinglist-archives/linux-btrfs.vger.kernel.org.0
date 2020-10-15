Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CD428F60D
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Oct 2020 17:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbgJOPp2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Oct 2020 11:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbgJOPp2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Oct 2020 11:45:28 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CCCC061755;
        Thu, 15 Oct 2020 08:45:27 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b69so2668339qkg.8;
        Thu, 15 Oct 2020 08:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=get3lmOGf8J6HCZZGRd2LhZ9QmsBRKMjErGrqguK9Ls=;
        b=tc6pCKX1w6x2S2u0IqsgNWuqcnc/4rFwx32T7fqFqUcrN5+fAXCJHCMO9Rk3742t3S
         x2ktlhSSIr6Ozmt3qxq+tAhi1fFwoamwHSoiXJcyH1/bg4T9N2ZdwwqB1th3DIXK85fE
         XVQG6M/RZ5s7ywC13Qdb7+//yvCtgHQ3gsu5fcRHxF3cHajLkznQVbjD+ji20PV5P2vb
         D1Zp2AXEcgv4V4Gps5U0Wcn04fNNJDLQC00p0B5l6hKK5F4uH9vY9gxp3ifIZisibAEv
         xsR6NvjWm56xGb/HCu+Q4YBpdUWqAIlp0InQA2pcAsejvk5N7u3SHaqon6cj5cptZXkC
         Gcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=get3lmOGf8J6HCZZGRd2LhZ9QmsBRKMjErGrqguK9Ls=;
        b=JDfEpVoZA1e310F3rxIv/I1ddgeoxyO2HI634ovJl2hPNCPCqRt8S+Lbwuzl5Fzu8p
         Ouf9Qa8+CS0HVaNfPi1KPKJ8UXVsFYiRnpIgdAJgev7yxiR00bh89Ag6BnEG+a9XuUhB
         hJ8pOWz9JslSybVhCsa1E+UNuIfYWykS+cUHp1rQCn+oKV57DPfx4Ix6EzNpK/MtQVSv
         LlIW9XvJI0xdF3W3CEvnpSHwL10w3sHzRvQrzdbwVKzntthENohMzD1y+ZMzB58gyjlx
         zgcTyEm5TcAxI9Do96iADAHvk6FJ82AcDoB10U/vvDP8NhbyfrrmHNEdpDyKbZErbG6x
         dIKw==
X-Gm-Message-State: AOAM533DlosjVWkyquRKfQ42dWOLx33oO9Ss+RZ7dre80xo0oeiqAdO0
        6TcaMwKwG5i/qCgkB6q65tKBrOMwP2UF3tMSMQxf935Q
X-Google-Smtp-Source: ABdhPJzNaYjxcWKQ+/zNwHqZ4DnKlNQsr862k/EBf2JcIJzLcfZkM+iz07HWpcg5aSII0MB54u3oqNOpB0tdrcF1v3E=
X-Received: by 2002:a37:9cd3:: with SMTP id f202mr4440055qke.479.1602776726265;
 Thu, 15 Oct 2020 08:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599233551.git.anand.jain@oracle.com> <53f76be87a0b414d6074f358b45b40cf1419950b.1599233551.git.anand.jain@oracle.com>
In-Reply-To: <53f76be87a0b414d6074f358b45b40cf1419950b.1599233551.git.anand.jain@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 15 Oct 2020 16:45:14 +0100
Message-ID: <CAL3q7H7Kkz=5gwaAyNvHoer+rYrqRPjjOL_reQay6DvQtU7HMw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] btrfs: add a test case for btrfs seed device delete
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 5, 2020 at 12:25 AM Anand Jain <anand.jain@oracle.com> wrote:
>
> This is a regression test for the issue fixed by the kernel patch
>    btrfs: fix put of uninitialized kobject after seed device delete

Now that the patch is in Linus' tree, we could have the commit id as well.
Just a few comments below.

>
> In this test case, we verify the seed device delete on a sprouted
> filesystem.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2 drop the sysfs layout check as it breaks the test-case backward
> compatibility.
>
>  tests/btrfs/219     | 83 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/219.out | 15 ++++++++
>  tests/btrfs/group   |  1 +
>  3 files changed, 99 insertions(+)
>  create mode 100755 tests/btrfs/219
>  create mode 100644 tests/btrfs/219.out
>
> diff --git a/tests/btrfs/219 b/tests/btrfs/219
> new file mode 100755
> index 000000000000..86f2a6991bd7
> --- /dev/null
> +++ b/tests/btrfs/219
> @@ -0,0 +1,83 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Oracle. All Rights Reserved.
> +#
> +# FS QA Test 219
> +#
> +# Test for seed device-delete on a sprouted FS.
> +# Requires kernel patch
> +#    btrfs: fix put of uninitialized kobject after seed device delete
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
> +_supported_fs generic

s/generic/btrfs

> +_supported_os Linux

This should go away, _supported_os is gone now.

> +_require_test
> +_require_scratch_dev_pool 2
> +
> +_scratch_dev_pool_get 2
> +
> +seed=3D$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
> +sprout=3D$(echo $SCRATCH_DEV_POOL | awk '{print $2}')

$AWK_PROG should be used instead.

> +
> +_mkfs_dev $seed
> +_mount $seed $SCRATCH_MNT
> +
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foo > /dev/null

Why the direct IO write? Why not buffered IO?
I just tried the test, and it passes too with a buffered write (no -d).
If there's any reason for using direct IO, it should be mentioned in a
comment, and _require_odirect added at the top.

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
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xcd 0 1M" $SCRATCH_MNT/bar > /dev/null

Same comment here regarding the use of direct IO.

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
> diff --git a/tests/btrfs/219.out b/tests/btrfs/219.out
> new file mode 100644
> index 000000000000..d39e0d8ffafd
> --- /dev/null
> +++ b/tests/btrfs/219.out
> @@ -0,0 +1,15 @@
> +QA output created by 219
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
> index 3295856d0c8c..3633fa66abe4 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -221,3 +221,4 @@
>  216 auto quick seed
>  217 auto quick trim dangerous
>  218 auto quick volume
> +219 auto quick volume seed

New tests were added in the meanwhile.
For the next version don't forget to renumber the test to 224.

Other than those minor comments, it looks fine and it works.

Thanks.

> --
> 2.25.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
