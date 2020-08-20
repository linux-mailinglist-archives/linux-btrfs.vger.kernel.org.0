Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8CE24B6B6
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 12:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgHTKja (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 06:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729335AbgHTKjX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 06:39:23 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15215C061757;
        Thu, 20 Aug 2020 03:39:23 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id k25so784815vsm.11;
        Thu, 20 Aug 2020 03:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=qwSdSnDVzX21qHNaoN89POE/ltOFcPV+L3crDFb/NOk=;
        b=kJ97DcGJCMlfZzol/0y2p/vcJ/ugTCui0SW2F0iDt5VsFx93Bm6Tl5Nm237kAm2PUR
         FbRxyP4+Lz6A2/QdpU6Ro3hNebeZ0XUmjZVlJp1Q8rMPvjLNm04XzugEDVkybKChdN3y
         bHMDAIXZLcBzu4+ggIu+jAiNxzHnM4W2adqScTNvR+vO1Qu7M+cfex7L3laeLXKb10tK
         izURtmTxLkW8k+fgE3q4xIOe18Lz1nt0Tw8UkP/U9H4koI417Pn0BGkFZfVR/WvxBVAE
         h8RNl3Cf4X1xKhp/efq+HH4Ih65di9ydRvjrZQe+lYQVC6zAlmSrSiKAddBbirnuKZ64
         gW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=qwSdSnDVzX21qHNaoN89POE/ltOFcPV+L3crDFb/NOk=;
        b=LwoN1lbIebzr65Ypg81eqNU8bvIiSQR5XrVPD5S6nSVuHzJBeeEWxYbSyAJqV+jtm/
         GAffnHfLi8PVnZIQrT2z2ej0Z9etqszHf1/IVAo1G/6zYhBgjiizu7NlE36dljSvAPBg
         f5FWG5GL5aoAFVqIGDS7IJq7SxtmknMkiHO3SSDWitENPcz2DT7cBbWuDlLXFflWLeCO
         NVG1HDVgvvwWzLAbrkA1YC/7gCyG6MAiS/2/a8Nj/N0wZWhLPzQ1M2xNQm0zPn01zvsc
         1oyK+BkfsPkFgcXNeHnj4wHKOhBwGsDhZpPBs99mm+RnpJti2j0S4WOfr9wr+AYZnFW+
         TWZg==
X-Gm-Message-State: AOAM530AAuOGrYTvltnA+2PNOTZ5B4me9hMMJHiKV32d7q6VQpEJAwMR
        vThSnqvpoEflamH8c2WaGOcSgApH7Od8KbgoNfE=
X-Google-Smtp-Source: ABdhPJxxIY4uDR7LGrQ8kqL/S86ioZdGd9QjMo5FpNk5oZOH+oWvXNkP/rSH8jwmbrrd8xdpLQ9QTJd2rE8jAgBhIC8=
X-Received: by 2002:a67:89ca:: with SMTP id l193mr1383257vsd.206.1597919961599;
 Thu, 20 Aug 2020 03:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200803192559.18330-1-josef@toxicpanda.com>
In-Reply-To: <20200803192559.18330-1-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 20 Aug 2020 11:39:10 +0100
Message-ID: <CAL3q7H6xXXQO2bKNeXb3npxxNi=9LH2D7z95HR5q=49ty3iMzA@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/217 add a test for btrfs seed device stats
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 3, 2020 at 8:26 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> This is a regression test for the issue fixed by
>
>   btrfs: init device stats for seed devices
>
> We create a seed device, add a sprout device, and then check the device
> stats after a remount to make sure it succeeds.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  tests/btrfs/217     | 71 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/217.out | 25 ++++++++++++++++
>  tests/btrfs/group   |  1 +
>  3 files changed, 97 insertions(+)
>  create mode 100755 tests/btrfs/217
>  create mode 100644 tests/btrfs/217.out
>
> diff --git a/tests/btrfs/217 b/tests/btrfs/217
> new file mode 100755
> index 00000000..204298bd
> --- /dev/null
> +++ b/tests/btrfs/217
> @@ -0,0 +1,71 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Facebook.  All Rights Reserved.
> +#
> +# FS QA Test 217
> +#
> +# Regression test for the problem fixed by the patch
> +#
> +#  btrfs: init device stats for seed devices
> +#
> +# Make a seed device, add a sprout to it, and then make sure we can stil=
l read
> +# the device stats for both devices after we remount with the new sprout=
 device.
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
> +. ./common/filter.btrfs
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_test
> +_require_scratch_dev_pool 2
> +
> +_scratch_dev_pool_get 2
> +
> +dev_seed=3D$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
> +dev_sprout=3D$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> +
> +# Create the seed device
> +_mkfs_dev $dev_seed
> +run_check _mount $dev_seed $SCRATCH_MNT
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foo > /dev/null
> +$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
> +       _filter_btrfs_filesystem_show
> +_scratch_unmount
> +$BTRFS_TUNE_PROG -S 1 $dev_seed
> +
> +# Mount the seed device and add the rw device
> +run_check _mount $dev_seed $SCRATCH_MNT
> +_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT
> +$BTRFS_UTIL_PROG device stats $SCRATCH_MNT | _filter_scratch_pool
> +_scratch_unmount
> +
> +# Now remount, validate the device stats do not fail
> +run_check _mount $dev_sprout $SCRATCH_MNT
> +$BTRFS_UTIL_PROG device stats $SCRATCH_MNT | _filter_scratch_pool
> +

A call to _scratch_dev_pool_put() to compensate for the previous call
to _scratch_dev_pool_get() is missing.

Also, what Eryu said, removing the run_check() calls.

With those things fixed:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/217.out b/tests/btrfs/217.out
> new file mode 100644
> index 00000000..86c6e775
> --- /dev/null
> +++ b/tests/btrfs/217.out
> @@ -0,0 +1,25 @@
> +QA output created by 217
> +Label: none  uuid: <UUID>
> +       Total devices <NUM> FS bytes used <SIZE>
> +       devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> +
> +[SCRATCH_DEV].write_io_errs    0
> +[SCRATCH_DEV].read_io_errs     0
> +[SCRATCH_DEV].flush_io_errs    0
> +[SCRATCH_DEV].corruption_errs  0
> +[SCRATCH_DEV].generation_errs  0
> +[SCRATCH_DEV].write_io_errs    0
> +[SCRATCH_DEV].read_io_errs     0
> +[SCRATCH_DEV].flush_io_errs    0
> +[SCRATCH_DEV].corruption_errs  0
> +[SCRATCH_DEV].generation_errs  0
> +[SCRATCH_DEV].write_io_errs    0
> +[SCRATCH_DEV].read_io_errs     0
> +[SCRATCH_DEV].flush_io_errs    0
> +[SCRATCH_DEV].corruption_errs  0
> +[SCRATCH_DEV].generation_errs  0
> +[SCRATCH_DEV].write_io_errs    0
> +[SCRATCH_DEV].read_io_errs     0
> +[SCRATCH_DEV].flush_io_errs    0
> +[SCRATCH_DEV].corruption_errs  0
> +[SCRATCH_DEV].generation_errs  0
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index ca90818b..32604e25 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -219,3 +219,4 @@
>  214 auto quick send snapshot
>  215 auto quick
>  216 auto quick seed
> +217 auto quick volume
> --
> 2.24.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
