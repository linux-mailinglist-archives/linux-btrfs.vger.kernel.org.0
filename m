Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181561DAEAC
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 11:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgETJZ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 05:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETJZz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 05:25:55 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84349C061A0E;
        Wed, 20 May 2020 02:25:55 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id u7so1418992vsp.7;
        Wed, 20 May 2020 02:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=zkW4TjVRoZsKHMZ+rba136e+jXkLgxqOEABLFO6R6v8=;
        b=HWkiT5PrOtIHfjWkYHLbFCv7PzMKBAcTNz4kPPbgT/xeAkjFmpiKDN5lr5sm3J6ITw
         +lGXYGd/Sm9F3amJS5CN0E9r5CjhAGuq0pMxMmPAJfof5/1LFjXsdPxQoGmfWor9jDQw
         odxpeZGOTTr+5nEyxpFs+d0G8ZQv7uS2VPvpxXM0Ng45CY42lQEFwNnbXLJx7ZGwVfkT
         JdH4dFSP4Ph18KMfeL+piD1VYtscMczFcI/7w6tiNQ1ddEZf++cEW/fdzkB/iz/aCCxm
         n1Iku70UtlKDn96oBrsvyn9S1OxS60aCcaQiVUgIcONAy3mJPLxBM/hGwVy+OCB3YtS3
         ugwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=zkW4TjVRoZsKHMZ+rba136e+jXkLgxqOEABLFO6R6v8=;
        b=lBO9wWHRk8I+hOvZUytLPSxCQL0XQ4A1BoqS0smesftlA/IGHBtmooX56Pz3E/G69Y
         ZLnceKvcjYqYLY3L98AnRrBc2Crt4DjPxdqU296V4hJTUr86wg6tjzIktCxRyvJLr91O
         sZS30xcy2JGpfpMQNZleZTVrb5qBumrKEHXExKeiK6UROssOFFzHSuyUpgeoS1AghNtO
         RBjtwkY38c5CxNcVzW85b5QHjf2wT9ppV6Pajpxlf1uI8VQiVrCdONHVP3voM/UFA1Wl
         aZuRFDRygHv5rzlAdBiEN9FTT0btdoHp6G4YRPK3FlqvtywotRTNIDkM3FlzdThn7i9N
         RU/w==
X-Gm-Message-State: AOAM533krqnqKipu8RaAGIhMRwOR/5iuA3OrVA9g94KZLN9AYFxQm3uJ
        Tb/qQuWSbsLuTW0WnDEQNHpdkAd0wF2ZIAIg9p8=
X-Google-Smtp-Source: ABdhPJy13PlqWaaAW127N1CFZ1ahCQ6mQe21edfZFNJ2mQbmi/pBEa2Bi08F2NcpxQRoUeC3lxa/rC91rJ7VWFL6XBs=
X-Received: by 2002:a67:c813:: with SMTP id u19mr2646449vsk.206.1589966754674;
 Wed, 20 May 2020 02:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200519021331.14028-1-wqu@suse.com>
In-Reply-To: <20200519021331.14028-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 20 May 2020 10:25:43 +0100
Message-ID: <CAL3q7H6GqgL9wAmgdUtHBWN8ex1r-BdRT9uuodEDXTrQn7OJqA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Add a test for leaking root crash at unmount time
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 19, 2020 at 3:14 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Test if canceled balance could lead to root leakage.
> If the kernel has CONFIG_BTRFS_DEBUG compiled, unmount time root leakge
> check would detect it, and cause NULL pointer dereference as the pages
> of the leaked root is already freed.

is -> are

>
> The fix is titled "btrfs: relocation: Fix reloc root leakage and the NULL
>  pointer reference caused by the leakage".
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/212     | 85 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/212.out |  2 ++
>  tests/btrfs/group   |  1 +
>  3 files changed, 88 insertions(+)
>  create mode 100755 tests/btrfs/212
>  create mode 100644 tests/btrfs/212.out
>
> diff --git a/tests/btrfs/212 b/tests/btrfs/212
> new file mode 100755
> index 00000000..4f4e177b
> --- /dev/null
> +++ b/tests/btrfs/212
> @@ -0,0 +1,85 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 212
> +#
> +# Test if unmounting a fs with balance canceled can lead to crash.
> +# This needs CONFIG_BTRFS_DEBUG compiled, which includes extra unmount t=
ime self-test

includes -> adds

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
> +       kill $balance_pid &> /dev/null
> +       kill $cancel_pid &> /dev/null
> +       "$KILLALL_PROG" -q $FSSTRESS_PROG &> /dev/null
> +       $BTRFS_UTIL_PROG balance cancel $SCRATCH_MNT &> /dev/null
> +       wait
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
> +_require_scratch
> +_require_command "$KILLALL_PROG" killall
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +
> +runtime=3D15
> +
> +balance_workload()
> +{
> +       trap "wait; exit" SIGTERM
> +       while true; do
> +               $BTRFS_UTIL_PROG balance start -f --full $SCRATCH_MNT &> =
/dev/null

Please use the helper _run_btrfs_balance_start(), it will
automatically add --full-balance if the installed btrfs-progs version
requires it.

After that you can add:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> +       done
> +}
> +
> +cancel_workload()
> +{
> +       trap "wait; exit" SIGTERM
> +       while true; do
> +               $BTRFS_UTIL_PROG balance cancel $SCRATCH_MNT &> /dev/null
> +               sleep 2
> +       done
> +}
> +
> +$FSSTRESS_PROG -d $SCRATCH_MNT -w -n 100000  >> $seqres.full 2>/dev/null=
 &
> +balance_workload &
> +balance_pid=3D$!
> +
> +cancel_workload &
> +cancel_pid=3D$!
> +
> +sleep $runtime
> +
> +kill $balance_pid
> +kill $cancel_pid
> +"$KILLALL_PROG" -q $FSSTRESS_PROG &> /dev/null
> +$BTRFS_UTIL_PROG balance cancel $SCRATCH_MNT &> /dev/null
> +wait
> +
> +echo "Silence is golden"
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/212.out b/tests/btrfs/212.out
> new file mode 100644
> index 00000000..32d11390
> --- /dev/null
> +++ b/tests/btrfs/212.out
> @@ -0,0 +1,2 @@
> +QA output created by 212
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 66b1beac..8d65bddd 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -214,3 +214,4 @@
>  209 auto quick log
>  210 auto quick qgroup snapshot
>  211 auto quick log prealloc
> +212 auto balance dangerous
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
