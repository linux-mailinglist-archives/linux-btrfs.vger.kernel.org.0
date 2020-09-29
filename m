Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD9C27D335
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Sep 2020 17:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgI2P4J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 11:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgI2P4H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 11:56:07 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05D7C061755;
        Tue, 29 Sep 2020 08:56:07 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c2so4782645qkf.10;
        Tue, 29 Sep 2020 08:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=8QLqoFub2sfyehUsDQ7pIYRmvtZ5+Xbgs+syMvpm1Z8=;
        b=RkCdVkfzporzMkXXg/cfoV4tiSKx8flsqo1rH3bQHAQwbxlo+VKpw8T72wkWo8gJzv
         0sD28NXsSlfgKujOXcIhHf1JrE1AnFLrQyFPGBlPA2Kdryzxad+8gzljtSbFvYfijxPB
         /6pwRcjTVkKCdbdX5hSxM3HAS1aTrv9Bo6Oap4Ouq4g2lV7TgG64cVrTnVJrQVU5D8bd
         QXr45fCceNu+BbHn8tTcAUIglLTD+fGwsIVmVutnUEVa1QxZO4PW4c62UZldwTrYx+zM
         OMHNP51SGISReZYLvVr5IisflyltI0QEIwsGkpmPf6lUGbhKiNKj/30jMsbLQaCURFXa
         pSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=8QLqoFub2sfyehUsDQ7pIYRmvtZ5+Xbgs+syMvpm1Z8=;
        b=GGdA1mIrIKDlsG8hWKgQk//CHNT7puDogUB1yr2apFPks9ibmg360Yyn0+JUFqFsfK
         EbsCi1Qeqexa5J7sevjcM0Qs5IOAYbz3cQVImO2E2OE4s+nJBBs+wpmIwkwNL31nh7qv
         sSo4x7ITuzWC9YWloGF7byYc2mebAcEah7+4wmHc7u7Dz8CA5H0PQF9lrykEHeNAikSW
         AJWin7N+4Ez0LN85OHruh9mIgMpgfHQ1qhcVRgOgLnoxAwuV2nyyqLWSuwtV3xE+Vfg4
         F/72JsQNDM2Ki0/AN0VGIKkO3f5ryUEn6sQ+VCkETF5T6IPoXU/p9WCs/Wl/IBdyjRYB
         iLBQ==
X-Gm-Message-State: AOAM531MF7IW1hSuR6yqVuyPlOxyauqzrNzjfYFmW0G6xW07j1V+6Dt8
        n7k9aEaxwWIp8b6Gwh6mihSLC5MLGLyZwVWV/Tk=
X-Google-Smtp-Source: ABdhPJzzi8CCTk+mDOcusr0Ymwbae35LLxULK2CXr6+fpx/7mxRWg8Q5zo972kc8ldzXalHUY1QowZEgQKaHiWjhPVA=
X-Received: by 2002:a37:ad09:: with SMTP id f9mr4757092qkm.383.1601394966816;
 Tue, 29 Sep 2020 08:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <f36fdfad33395cbf99520479b162590935f3cfd1.1601394562.git.anand.jain@oracle.com>
In-Reply-To: <f36fdfad33395cbf99520479b162590935f3cfd1.1601394562.git.anand.jain@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 29 Sep 2020 16:55:55 +0100
Message-ID: <CAL3q7H7QLe6EpK_g1S6MVhOPKaEsaYY9MeAHexdsEO=nz_qubQ@mail.gmail.com>
Subject: Re: [PATCH] fstests: delete btrfs/064 it makes no sense
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 29, 2020 at 4:50 PM Anand Jain <anand.jain@oracle.com> wrote:
>
> btrfs/064 aimed to test balance and replace concurrency while the stress
> test is running in the background.
>
> However, as the balance and the replace operation are mutually
> exclusive, so they can never run concurrently.

And it's good to have a test that verifies that attempting to run them
concurrently doesn't cause any problems, like crashes, memory leaks or
some sort of filesystem corruption.

For example btrfs/187, which I wrote sometime ago, tests that running
send, balance and deduplication in parallel doesn't result in crashes,
since in the past they were allowed to run concurrently.

I see no point in removing the test, it's useful.

Thanks.

>
> So long this test case is showed successful because the btrfs replace's
> return error was captured only into seqfull.out.
>
>  ERROR: ioctl(DEV_REPLACE_START) '/mnt/scratch': add/delete/balance/repla=
ce/resize operation in progress
>
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/064     | 105 --------------------------------------------
>  tests/btrfs/064.out |   2 -
>  2 files changed, 107 deletions(-)
>  delete mode 100755 tests/btrfs/064
>  delete mode 100644 tests/btrfs/064.out
>
> diff --git a/tests/btrfs/064 b/tests/btrfs/064
> deleted file mode 100755
> index 683a69f113bf..000000000000
> --- a/tests/btrfs/064
> +++ /dev/null
> @@ -1,105 +0,0 @@
> -#! /bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (C) 2014 Red Hat Inc. All rights reserved.
> -#
> -# FSQA Test No. btrfs/064
> -#
> -# Run btrfs balance and replace operations simultaneously with fsstress
> -# running in background.
> -#
> -seq=3D`basename $0`
> -seqres=3D$RESULT_DIR/$seq
> -echo "QA output created by $seq"
> -
> -here=3D`pwd`
> -tmp=3D/tmp/$$
> -status=3D1
> -trap "_cleanup; exit \$status" 0 1 2 3 15
> -
> -_cleanup()
> -{
> -       cd /
> -       rm -f $tmp.*
> -}
> -
> -# get standard environment, filters and checks
> -. ./common/rc
> -. ./common/filter
> -
> -# real QA test starts here
> -_supported_fs btrfs
> -# we check scratch dev after each loop
> -_require_scratch_nocheck
> -_require_scratch_dev_pool 5
> -_require_scratch_dev_pool_equal_size
> -_btrfs_get_profile_configs replace
> -
> -rm -f $seqres.full
> -
> -run_test()
> -{
> -       local mkfs_opts=3D$1
> -       local saved_scratch_dev_pool=3D$SCRATCH_DEV_POOL
> -
> -       echo "Test $mkfs_opts" >>$seqres.full
> -
> -       # remove the last device from the SCRATCH_DEV_POOL list so
> -       # _scratch_pool_mkfs won't use all devices in pool
> -       local last_dev=3D"`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $NF=
}'`"
> -       SCRATCH_DEV_POOL=3D`echo $SCRATCH_DEV_POOL | sed -e "s# *$last_de=
v *##"`
> -       _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
> -       # make sure we created btrfs with desired options
> -       if [ $? -ne 0 ]; then
> -               echo "mkfs $mkfs_opts failed"
> -               SCRATCH_DEV_POOL=3D$saved_scratch_dev_pool
> -               return
> -       fi
> -       _scratch_mount >>$seqres.full 2>&1
> -       SCRATCH_DEV_POOL=3D$saved_scratch_dev_pool
> -
> -       args=3D`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCR=
ATCH_MNT/stressdir`
> -       echo "Run fsstress $args" >>$seqres.full
> -       $FSSTRESS_PROG $args >/dev/null 2>&1 &
> -       fsstress_pid=3D$!
> -
> -       echo -n "Start balance worker: " >>$seqres.full
> -       _btrfs_stress_balance $SCRATCH_MNT >/dev/null 2>&1 &
> -       balance_pid=3D$!
> -       echo "$balance_pid" >>$seqres.full
> -
> -       echo -n "Start replace worker: " >>$seqres.full
> -       _btrfs_stress_replace $SCRATCH_MNT >>$seqres.full 2>&1 &
> -       replace_pid=3D$!
> -       echo "$replace_pid" >>$seqres.full
> -
> -       echo "Wait for fsstress to exit and kill all background workers" =
>>$seqres.full
> -       wait $fsstress_pid
> -       kill $balance_pid $replace_pid
> -       wait
> -       # wait for the balance and replace operations to finish
> -       while ps aux | grep "balance start" | grep -qv grep; do
> -               sleep 1
> -       done
> -       while ps aux | grep "replace start" | grep -qv grep; do
> -               sleep 1
> -       done
> -
> -       echo "Scrub the filesystem" >>$seqres.full
> -       $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> -       if [ $? -ne 0 ]; then
> -               echo "Scrub find errors in \"$mkfs_opts\" test" | tee -a =
$seqres.full
> -       fi
> -
> -       _scratch_unmount
> -       # we called _require_scratch_nocheck instead of _require_scratch
> -       # do check after test for each profile config
> -       _check_scratch_fs
> -}
> -
> -echo "Silence is golden"
> -for t in "${_btrfs_profile_configs[@]}"; do
> -       run_test "$t"
> -done
> -
> -status=3D0
> -exit
> diff --git a/tests/btrfs/064.out b/tests/btrfs/064.out
> deleted file mode 100644
> index d90765460090..000000000000
> --- a/tests/btrfs/064.out
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -QA output created by 064
> -Silence is golden
> --
> 2.25.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
