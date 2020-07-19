Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD9C22537A
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jul 2020 20:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgGSSYG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jul 2020 14:24:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgGSSYG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jul 2020 14:24:06 -0400
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E4D720B1F;
        Sun, 19 Jul 2020 18:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595183045;
        bh=EMQ1w3V7wP8iasTNdqlfMZr+zUUZ6WJ1+EOFYxCSaJQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qC6ABpIrAPnC+snSz0qcLmNp2Hu76I1PnD81qikVB4Tk3IqLzE4k7Nrb+/9sRnNJ1
         Yt2H6APE+/0+UsEsfKFs2tdXLCF/7exGozg89Bx+2uyNxusS/3pz6xiNPSJyE88Kkf
         FhMbpvDg0n8zvjD7pnamRBr/1nElfLiUV+tjSok8=
Received: by mail-ua1-f50.google.com with SMTP id r63so318935uar.9;
        Sun, 19 Jul 2020 11:24:05 -0700 (PDT)
X-Gm-Message-State: AOAM533XWTdvEjDtA7FYyYLOfgRC/vBWz7nj5Ux5+vvUEwSZmXo2jYUh
        6QZVUN9Xdzz9eqf+YL67juGHfNPtCZC8DOJbKfQ=
X-Google-Smtp-Source: ABdhPJybNdYWUSxamBik5NKrgfpF0502hrkTVnc6LE109OR8Btf+VdU5LpG4rlaKTFCRXIZqxoav25u7F5ErcBDBsK8=
X-Received: by 2002:ab0:4821:: with SMTP id b30mr13849827uad.83.1595183044474;
 Sun, 19 Jul 2020 11:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200615175028.15090-1-fdmanana@kernel.org> <20200719164417.GC2557159@desktop>
In-Reply-To: <20200719164417.GC2557159@desktop>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Sun, 19 Jul 2020 19:23:53 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6PPBF6UqUHoOGpU1bDo0bg2-jUP9o5h+oCpNzjfM8DRA@mail.gmail.com>
Message-ID: <CAL3q7H6PPBF6UqUHoOGpU1bDo0bg2-jUP9o5h+oCpNzjfM8DRA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test creating a snapshot after RWF_NOWAIT write
 works as expected
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 19, 2020 at 5:44 PM Eryu Guan <guan@eryu.me> wrote:
>
> On Mon, Jun 15, 2020 at 06:50:28PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that creating a snapshot after writing to a file using a RWF_NOWAIT
> > works, does not hang the snapshot creation task, and we are able to read
> > the data after.
> >
> > Currently btrfs hangs when creating the snapshot due to a missing unlock
> > of a snapshot lock, but it is fixed by a patch with the following subject:
> >
> >   "btrfs: fix hang on snapshot creation after RWF_NOWAIT write"
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> So sorry for the late review.. But I hit the following failure with
> v5.8-rc5 kernel, which contains the mentioned fix
>
>  QA output created by 215
>  wrote 65536/65536 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 65536/65536 bytes at offset 0
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +pwrite: Input/output error
>  Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>  File data in the subvolume:
> -0000000 fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> +0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
>  *
>  0065536
>  File data in the snapshot:
> -0000000 fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> +0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
>  *
>  0065536
>
> And I did hit hang when testing without the fix. Is this something that
> should be fixed in the test?

Odd.

Works for me on 5.8-rc5:

$ ./check btrfs/215
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian9 5.8.0-rc5-btrfs-next-63 #1 SMP
PREEMPT Sun Jul 19 17:53:27 WEST 2020
MKFS_OPTIONS  -- /dev/sdb
MOUNT_OPTIONS -- /dev/sdb /home/fdmanana/btrfs-tests/scratch_1

btrfs/215 1s
Ran: btrfs/215
Passed all 1 tests

Is there anything in dmesg?



>
> Thanks,
> Eryu
>
> > ---
> >  tests/btrfs/214     | 66 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/214.out | 14 ++++++++++
> >  tests/btrfs/group   |  1 +
> >  3 files changed, 81 insertions(+)
> >  create mode 100755 tests/btrfs/214
> >  create mode 100644 tests/btrfs/214.out
> >
> > diff --git a/tests/btrfs/214 b/tests/btrfs/214
> > new file mode 100755
> > index 00000000..c835e844
> > --- /dev/null
> > +++ b/tests/btrfs/214
> > @@ -0,0 +1,66 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FSQA Test No. 214
> > +#
> > +# Test that creating a snapshot after writing to a file using a RWF_NOWAIT
> > +# works, does not hang the snapshot creation task, and we are able to read
> > +# the data after.
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +tmp=/tmp/$$
> > +status=1     # failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +     cd /
> > +     rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +. ./common/attr
> > +
> > +# real QA test starts here
> > +_supported_fs btrfs
> > +_supported_os Linux
> > +_require_scratch
> > +_require_odirect
> > +_require_xfs_io_command pwrite -N
> > +_require_chattr C
> > +
> > +rm -f $seqres.full
> > +
> > +_scratch_mkfs >>$seqres.full 2>&1
> > +_scratch_mount
> > +
> > +# RWF_NOWAIT writes require NOCOW
> > +touch $SCRATCH_MNT/f
> > +$CHATTR_PROG +C $SCRATCH_MNT/f
> > +
> > +$XFS_IO_PROG -d -c "pwrite -S 0xab 0 64K" $SCRATCH_MNT/f | _filter_xfs_io
> > +
> > +# Now do a WEF_WRITE into a range containing a NOCOWable extent.
> > +$XFS_IO_PROG -d -c "pwrite -N -V 1 -S 0xfe 0 64K" $SCRATCH_MNT/f \
> > +     | _filter_xfs_io
> > +
> > +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap \
> > +     | _filter_scratch
> > +
> > +# Unmount, mount again and verify the file in the subvolume and snapshot has
> > +# the correct data.
> > +_scratch_cycle_mount
> > +
> > +echo "File data in the subvolume:"
> > +od -A d -t x1 $SCRATCH_MNT/f
> > +
> > +echo "File data in the snapshot:"
> > +od -A d -t x1 $SCRATCH_MNT/snap/f
> > +
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/214.out b/tests/btrfs/214.out
> > new file mode 100644
> > index 00000000..6cc66972
> > --- /dev/null
> > +++ b/tests/btrfs/214.out
> > @@ -0,0 +1,14 @@
> > +QA output created by 214
> > +wrote 65536/65536 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +wrote 65536/65536 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
> > +File data in the subvolume:
> > +0000000 fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> > +*
> > +0065536
> > +File data in the snapshot:
> > +0000000 fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> > +*
> > +0065536
> > diff --git a/tests/btrfs/group b/tests/btrfs/group
> > index 9e48ecc1..a3706e7d 100644
> > --- a/tests/btrfs/group
> > +++ b/tests/btrfs/group
> > @@ -216,3 +216,4 @@
> >  211 auto quick log prealloc
> >  212 auto balance dangerous
> >  213 auto balance dangerous
> > +214 auto quick snapshot
> > --
> > 2.26.2
