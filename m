Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61FB36F847
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 12:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhD3KGZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Apr 2021 06:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhD3KGY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Apr 2021 06:06:24 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D82C06174A;
        Fri, 30 Apr 2021 03:05:35 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id dl3so1818197qvb.3;
        Fri, 30 Apr 2021 03:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=q1isEl/U1z9cfAW/A0rJnz7R0WyM8fau03/7cjZNjVw=;
        b=ZAYaDeDIDBLywzscWUFDWeun76nGSMEHlxtGXzaTCRuGdMtX9w3XSVOsn39Syjaxu2
         CCoDKwPod6Uwzu+jYhxuwqAh4j++bb56cOrg+nTkPqg3ESupqKPo9hQ9g/eROWcK9Dt0
         qyvwT4zPegHlf4TcgA33ux1P5yIp1QbZnIa37h7wfmGsm1tMm1rKTLTCPqYZlpX2QwRz
         k7af9nf+fxA9e36Yl0Or0U4LzuGTgsfdOjTIxOP+pQJ0yjPHa82PYh0wgPtdGsGI3vUE
         Im1ZlYQ55Njclw2g5jdZOMDG1UlUC6hJ1EZd2UzdCPxAuxaHlA664TgorRnwiJLjYvYP
         IR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=q1isEl/U1z9cfAW/A0rJnz7R0WyM8fau03/7cjZNjVw=;
        b=g0UYKDDb4D0XLLj0A49yppgxkYzUo3IA38Y0Z0OV0a1+nDtq9m4e5hiakEVv8zlcBz
         Liad4caWYBQmJUjM3meheP/J/4DJSarr1O2Yp1gHnvcSBzMLTMET2wAC6qQ1V31TpMD4
         gzmTLBeYoJ6pf+UBwZmRfoT2e9y38qV010aXj4WN2bcHl/r4uwc38xU1MUicimpJneFK
         fOk6JmoZ/hMV7bZVHq6N6z9ueVRAQ1t+SvgKj0fDxPiLHEWN/3yWKMVPuJaXMXUGgf42
         419JoegLsXz22Tkmy1zyeG9gHSgy61DoK4fe0GEtv6ylxIL4uorT5INSxs90tjBB4Vlr
         WiPg==
X-Gm-Message-State: AOAM533uVpX24n+KHJkT7DyohCBDjXGurO7/NY4Lu0JrBSZ/Kvgbf2ds
        qjp5I6TSIC6m3fwe82Y2gN+xtC+PTXwLRS5FU7wJSVGsJHo=
X-Google-Smtp-Source: ABdhPJw2FDNeZx4mjLE4wyAvcWXSFhbaNLVnN/D+g/MtmRblksd104mvfkr+vay6dlzTcHHgrfgYQI6UV2d+R0OFfu0=
X-Received: by 2002:a05:6214:e82:: with SMTP id hf2mr4370059qvb.28.1619777134417;
 Fri, 30 Apr 2021 03:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210429123927.11778-1-johannes.thumshirn@wdc.com> <20210429123927.11778-3-johannes.thumshirn@wdc.com>
In-Reply-To: <20210429123927.11778-3-johannes.thumshirn@wdc.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 30 Apr 2021 11:05:23 +0100
Message-ID: <CAL3q7H7RpTjP+0fgcfiJP=w3o36e5Hz_twLHdE6j6rzN=+YbFw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] btrfs: add test for zone auto reclaim
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Eryu Guan <guan@eryu.me>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 29, 2021 at 1:40 PM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Add a test for commit 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim
> zones").
>
> This test creates a two file on a newly created FS in a way that when we
> delete the first one, an auto reclaim process will be triggered by the FS=
.
>
> After the reclaim process, it verifies that the data was moved to another
> zone and old zone was successfully reset.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good, however I don't have an environment for testing zoned
mode, so this is just really eyeballing.
Thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  common/config       |   1 +
>  tests/btrfs/236     | 103 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/236.out |   2 +
>  tests/btrfs/group   |   1 +
>  4 files changed, 107 insertions(+)
>  create mode 100755 tests/btrfs/236
>  create mode 100644 tests/btrfs/236.out
>
> diff --git a/common/config b/common/config
> index a47e462c7792..1a26934985dd 100644
> --- a/common/config
> +++ b/common/config
> @@ -226,6 +226,7 @@ export FSVERITY_PROG=3D"$(type -P fsverity)"
>  export OPENSSL_PROG=3D"$(type -P openssl)"
>  export ACCTON_PROG=3D"$(type -P accton)"
>  export E2IMAGE_PROG=3D"$(type -P e2image)"
> +export BLKZONE_PROG=3D"$(type -P blkzone)"
>
>  # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
>  # newer systems have udevadm command but older systems like RHEL5 don't.
> diff --git a/tests/btrfs/236 b/tests/btrfs/236
> new file mode 100755
> index 000000000000..a96665183a84
> --- /dev/null
> +++ b/tests/btrfs/236
> @@ -0,0 +1,103 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Western Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 236
> +#
> +# Test that zone autoreclaim works as expected, that is: if the dirty
> +# threshold is exceeded the data gets relocated to new block group and t=
he
> +# old block group gets deleted. On block group deletion, the underlying =
device
> +# zone also needs to be reset.
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
> +_supported_fs btrfs
> +_require_scratch
> +_require_btrfs_command inspect-internal dump-tree
> +_require_btrfs_command filesystem sync
> +_require_command "$BLKZONE_PROG" blkzone
> +_require_zoned_device "$SCRATCH_DEV"
> +
> +get_data_bg()
> +{
> +       $BTRFS_UTIL_PROG inspect-internal dump-tree -t CHUNK $SCRATCH_DEV=
 |\
> +               grep -A 1 "CHUNK_ITEM" | grep -B 1 "type DATA" |\
> +               grep -Eo "CHUNK_ITEM [[:digit:]]+" | cut -d ' ' -f 2
> +}
> +
> +zonesize=3D$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/chunk_secto=
rs)
> +zonesize=3D$((zonesize << 9))
> +
> +_scratch_mkfs >/dev/null 2>&1
> +_scratch_mount -o commit=3D1 # 1s commit time to speed up test
> +
> +uuid=3D$(findmnt -n -o UUID "$SCRATCH_MNT")
> +reclaim_threshold=3D75
> +echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
> +fill_percent=3D$((reclaim_threshold + 2))
> +rest_percent=3D$((90 - fill_percent)) # make sure we're not creating a n=
ew BG
> +fill_size=3D$((zonesize * fill_percent / 100))
> +rest=3D$((zonesize * rest_percent / 100))
> +
> +# step 1, fill FS over $fillsize
> +$XFS_IO_PROG -fc "pwrite 0 $fill_size" $SCRATCH_MNT/$seq.test1 >> $seqre=
s.full
> +$XFS_IO_PROG -fc "pwrite 0 $rest" $SCRATCH_MNT/$seq.test2 >> $seqres.ful=
l
> +$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
> +
> +zones_before=3D$($BLKZONE_PROG report $SCRATCH_DEV | grep -v -e em -e nw=
 | wc -l)
> +echo "Before reclaim: $zones_before zones open" >> $seqres.full
> +old_data_zone=3D$(get_data_bg)
> +old_data_zone=3D$((old_data_zone >> 9))
> +printf "Old data zone 0x%x\n" $old_data_zone >> $seqres.full
> +
> +# step 2, delete the 1st $fill_size sized file to trigger reclaim
> +rm $SCRATCH_MNT/$seq.test1
> +$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
> +sleep 2 # 1 transaction commit for 'rm' and 1 for balance
> +
> +# check that we don't have more zones open than before
> +zones_after=3D$($BLKZONE_PROG report $SCRATCH_DEV | grep -v -e em -e nw =
| wc -l)
> +echo "After reclaim: $zones_after zones open" >> $seqres.full
> +
> +# Check that old data zone was reset
> +old_wptr=3D$($BLKZONE_PROG report -o $old_data_zone -c 1 $SCRATCH_DEV |\
> +       grep -Eo "wptr 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
> +if [ "$old_wptr" !=3D "0x000000" ]; then
> +       _fail "Old wptr still at $old_wptr"
> +fi
> +
> +new_data_zone=3D$(get_data_bg)
> +new_data_zone=3D$((new_data_zone >> 9))
> +printf "New data zone 0x%x\n" $new_data_zone >> $seqres.full
> +
> +# Check that data was really relocated to a different zone
> +if [ $old_data_zone -eq $new_data_zone ]; then
> +       echo "New zone same as old zone"
> +fi
> +
> +# success, all done
> +echo "Silence is golden"
> +status=3D0
> +exit
> diff --git a/tests/btrfs/236.out b/tests/btrfs/236.out
> new file mode 100644
> index 000000000000..b6b6e0cad9a7
> --- /dev/null
> +++ b/tests/btrfs/236.out
> @@ -0,0 +1,2 @@
> +QA output created by 236
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 331dd432fac3..62c9c761e974 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -238,3 +238,4 @@
>  233 auto quick subvolume
>  234 auto quick compress rw
>  235 auto quick send
> +236 auto quick balance
> --
> 2.31.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
