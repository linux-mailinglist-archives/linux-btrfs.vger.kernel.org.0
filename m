Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8319149F973
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 13:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244445AbiA1MdE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 07:33:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43720 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244628AbiA1MdD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 07:33:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6437361B27;
        Fri, 28 Jan 2022 12:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E1DC340EB;
        Fri, 28 Jan 2022 12:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643373182;
        bh=pKX3dkJGV4eBG1d+PjMII13tK/8pm8flHozvQACV7OE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Msvj3gOnTfRyQYKW+IxruhP6r1nUz/qfp5i+ILIJj+/whzxIqf0aBbIQy37gtZrsY
         2thGPkazwLMqz9QpDnZ8k1+usQ9ujb22qZ/CnEmLADKclsSqU8IAl2hykcjqu8feyN
         OvAbl+0kV526zkyOYJGGBQzszlmWrl+SE/mmAH9a4vojWavZlPkw9xMGKhHVjrk825
         92f8YJalgRRHMh393wSivVkoEyYMKnKjkKH1U2Y7Qj7iCAmoINNiVCwEzs5sw217kU
         uozVF4wmgrNS029K0I9dmrq8ZdYU7cDhlphmu8dXEzIK3qvpIcl2+o+xVkYqxkuC1/
         6clu5q7fOsCqw==
Received: by mail-qt1-f176.google.com with SMTP id y17so4975775qtx.9;
        Fri, 28 Jan 2022 04:33:02 -0800 (PST)
X-Gm-Message-State: AOAM531FAV87DlhTLkt8ldeJ6Wj+vRr1zp2PVJ6mzWRwu4JaE/u3ctvD
        Z0num/tm5GYGDbyxv0EJu2+HqjjllYiJBGbtOXI=
X-Google-Smtp-Source: ABdhPJz4dMTf47lI/DVo3Q5RgeSGQSa9+xqIhrvhoOEjmIxylHkEp7j1DR5iFV4azK8n1IlM7a6zk5/LkeEjqJ+oxLU=
X-Received: by 2002:ac8:5950:: with SMTP id 16mr5729600qtz.141.1643373181811;
 Fri, 28 Jan 2022 04:33:01 -0800 (PST)
MIME-Version: 1.0
References: <20220128002701.11971-1-wqu@suse.com> <20220128002701.11971-2-wqu@suse.com>
 <YfPaJHzW4/KJoRAI@debian9.Home> <704d3e1a-38a5-cafe-d50c-ed2158bb20f5@gmx.com>
In-Reply-To: <704d3e1a-38a5-cafe-d50c-ed2158bb20f5@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 28 Jan 2022 12:32:25 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5ytZj+h9=mECvzy9UJqZDHx=BuxCcbS4tY4YqwGpQESw@mail.gmail.com>
Message-ID: <CAL3q7H5ytZj+h9=mECvzy9UJqZDHx=BuxCcbS4tY4YqwGpQESw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] btrfs: test autodefrag with regular and hole extents
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 28, 2022 at 12:13 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/1/28 19:57, Filipe Manana wrote:
> > On Fri, Jan 28, 2022 at 08:27:00AM +0800, Qu Wenruo wrote:
> >> In v5.11~v5.15 kernels, there is a regression in autodefrag that if a
> >> cluster (up to 256K in size) has even a single hole, the whole cluster
> >> will be rejected.
> >>
> >> This will greatly reduce the efficiency of autodefrag.
> >>
> >> The behavior is fixed in v5.16 by a full rework, although the rework
> >> itself has other problems, it at least solves the problem.
> >>
> >> Here we add a test case to reproduce the case, where we have a 128K
> >> cluster, the first half is fragmented extents which can be defragged.
> >> The second half is hole.
> >>
> >> Make sure autodefrag can defrag the 64K part.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >
> > Tried the test, and it succeeds here without the kernel fix applied.
> > I've ran it 10 times, and it always passed without the kernel fix.
>
> Have you tried v5.15 kernels? As v5.16 has the reworked code and will
> always pass.
>
> Or you can try to revert those 3 commits:
>
> c22a3572cbaf ("btrfs: defrag: enable defrag for subpage case")
> c635757365c3 ("btrfs: defrag: remove the old infrastructure")
> 7b508037d4ca ("btrfs: defrag: use defrag_one_cluster() to implement
> btrfs_defrag_file()")

With all those reverted, plus all the recent fixes that went to Linus'
tree, it fails as expected.
I got lost somewhere while navigating the sea of so many recent defrag
patches and versions.

So:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> That's how I tested the case with the same kernel base without going
> back to v5.15.
>
> And with those 3 commits reverted (aka, my baseline to emulate v5.15),
> it fails like this:
>
> btrfs/256 4s ... - output mismatch (see
> /home/adam/xfstests-dev/results//btrfs/256.out.bad)
>      --- tests/btrfs/256.out    2022-01-28 08:19:11.123333302 +0800
>      +++ /home/adam/xfstests-dev/results//btrfs/256.out.bad     2022-01-28
> 20:10:18.416666746 +0800
>      @@ -1,2 +1,3 @@
>       QA output created by 256
>      +regular extents didn't get defragged
>       Silence is golden
>      ...
>      (Run 'diff -u /home/adam/xfstests-dev/tests/btrfs/256.out
> /home/adam/xfstests-dev/results//btrfs/256.out.bad'  to see the entire diff)
> Ran: btrfs/256
>
> With the fiemap result in the full log:
> === File extent layout before autodefrag ===
> /mnt/scratch/foobar:
>   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>     0: [0..31]:         26720..26751        32   0x0
>     1: [32..63]:        26688..26719        32   0x0
>     2: [64..95]:        26656..26687        32   0x0
>     3: [96..127]:       26624..26655        32   0x1
>     4: [128..255]:      hole               128
> old md5=9ef8ace32f3b9890cff4fd43699bbd81
> === File extent layout after autodefrag ===
> /mnt/scratch/foobar:
>   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>     0: [0..31]:         26720..26751        32   0x0
>     1: [32..63]:        26688..26719        32   0x0
>     2: [64..95]:        26656..26687        32   0x0
>     3: [96..127]:       26624..26655        32   0x1
>     4: [128..255]:      hole               128
> new md5=9ef8ace32f3b9890cff4fd43699bbd81
>
> With my POC patch for v5.15 or v5.16 kernel it passes as expected.
>
> Thus that's why there is no fix mentioned in the commit message.
>
> Thanks,
> Qu
>
>
>
> >
> > Thanks.
> >
> >> ---
> >> Changelog:
> >> v2:
> >> - Use the previously define _get_file_extent_sector() helper
> >>    This also removed some out-of-sync error messages
> >>
> >> - Trigger autodefrag using commit=1 mount option
> >>    No need for special purpose patch any more.
> >>
> >> - Use xfs_io -s to skip several sync calls
> >>
> >> - Shorten the subject of the commit
> >> ---
> >>   tests/btrfs/256     | 80 +++++++++++++++++++++++++++++++++++++++++++++
> >>   tests/btrfs/256.out |  2 ++
> >>   2 files changed, 82 insertions(+)
> >>   create mode 100755 tests/btrfs/256
> >>   create mode 100644 tests/btrfs/256.out
> >>
> >> diff --git a/tests/btrfs/256 b/tests/btrfs/256
> >> new file mode 100755
> >> index 00000000..def83a15
> >> --- /dev/null
> >> +++ b/tests/btrfs/256
> >> @@ -0,0 +1,80 @@
> >> +#! /bin/bash
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> >> +#
> >> +# FS QA Test 256
> >> +#
> >> +# Make sure btrfs auto defrag can properly defrag clusters which has hole
> >> +# in the middle
> >> +#
> >> +. ./common/preamble
> >> +_begin_fstest auto defrag quick
> >> +
> >> +. ./common/btrfs
> >> +. ./common/filter
> >> +
> >> +# real QA test starts here
> >> +
> >> +# Modify as appropriate.
> >> +_supported_fs generic
> >> +_require_scratch
> >> +
> >> +# Needs 4K sectorsize, as larger sectorsize can change the file layout.
> >> +_require_btrfs_support_sectorsize 4096
> >> +
> >> +_scratch_mkfs >> $seqres.full
> >> +
> >> +# Need datacow to show which range is defragged, and we're testing
> >> +# autodefrag
> >> +_scratch_mount -o datacow,autodefrag
> >> +
> >> +# Create a layout where we have fragmented extents at [0, 64k) (sync write in
> >> +# reserve order), then a hole at [64k, 128k)
> >> +$XFS_IO_PROG -f -s -c "pwrite 48k 16k" -c "pwrite 32k 16k" \
> >> +            -c "pwrite 16k 16k" -c "pwrite 0 16k" \
> >> +            $SCRATCH_MNT/foobar >> $seqres.full
> >> +truncate -s 128k $SCRATCH_MNT/foobar
> >> +
> >> +old_csum=$(_md5_checksum $SCRATCH_MNT/foobar)
> >> +echo "=== File extent layout before autodefrag ===" >> $seqres.full
> >> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
> >> +echo "old md5=$old_csum" >> $seqres.full
> >> +
> >> +old_regular=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 0)
> >> +old_hole=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 64k)
> >> +
> >> +# Now trigger autodefrag, autodefrag is triggered in the cleaner thread,
> >> +# which will be woken up by commit thread
> >> +_scratch_remount commit=1
> >> +sleep 3
> >> +sync
> >> +
> >> +new_csum=$(_md5_checksum $SCRATCH_MNT/foobar)
> >> +new_regular=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 0)
> >> +new_hole=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 64k)
> >> +
> >> +echo "=== File extent layout after autodefrag ===" >> $seqres.full
> >> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
> >> +echo "new md5=$new_csum" >> $seqres.full
> >> +
> >> +# In v5.11~v5.15 kernels, regular extents won't get defragged, and would trigger
> >> +# the following output
> >> +if [ $new_regular == $old_regular ]; then
> >> +    echo "regular extents didn't get defragged"
> >> +fi
> >> +
> >> +# In v5.10 and earlier kernel, autodefrag may choose to defrag holes,
> >> +# which should be avoided.
> >> +if [ "$new_hole" != "$old_hole" ]; then
> >> +    echo "hole extents got defragged"
> >> +fi
> >> +
> >> +# Defrag should not change file content
> >> +if [ "$new_csum" != "$old_csum" ]; then
> >> +    echo "file content changed"
> >> +fi
> >> +
> >> +echo "Silence is golden"
> >> +# success, all done
> >> +status=0
> >> +exit
> >> diff --git a/tests/btrfs/256.out b/tests/btrfs/256.out
> >> new file mode 100644
> >> index 00000000..7ee8e2e5
> >> --- /dev/null
> >> +++ b/tests/btrfs/256.out
> >> @@ -0,0 +1,2 @@
> >> +QA output created by 256
> >> +Silence is golden
> >> --
> >> 2.34.1
> >>
