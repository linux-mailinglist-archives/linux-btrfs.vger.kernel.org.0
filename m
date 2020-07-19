Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8954C22538E
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jul 2020 20:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgGSSpX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jul 2020 14:45:23 -0400
Received: from out20-111.mail.aliyun.com ([115.124.20.111]:60788 "EHLO
        out20-111.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgGSSpW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jul 2020 14:45:22 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.9239135|0.8991504;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_system_inform|0.0827289-0.000855932-0.916415;FP=0|0|0|0|0|-1|-1|-1;HT=e01l10422;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.I4OqYPw_1595184317;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.I4OqYPw_1595184317)
          by smtp.aliyun-inc.com(10.147.42.135);
          Mon, 20 Jul 2020 02:45:17 +0800
Date:   Mon, 20 Jul 2020 02:45:16 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: test creating a snapshot after RWF_NOWAIT write
 works as expected
Message-ID: <20200719184516.GH2557159@desktop>
References: <20200615175028.15090-1-fdmanana@kernel.org>
 <20200719164417.GC2557159@desktop>
 <CAL3q7H6PPBF6UqUHoOGpU1bDo0bg2-jUP9o5h+oCpNzjfM8DRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H6PPBF6UqUHoOGpU1bDo0bg2-jUP9o5h+oCpNzjfM8DRA@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 19, 2020 at 07:23:53PM +0100, Filipe Manana wrote:
> On Sun, Jul 19, 2020 at 5:44 PM Eryu Guan <guan@eryu.me> wrote:
> >
> > On Mon, Jun 15, 2020 at 06:50:28PM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Test that creating a snapshot after writing to a file using a RWF_NOWAIT
> > > works, does not hang the snapshot creation task, and we are able to read
> > > the data after.
> > >
> > > Currently btrfs hangs when creating the snapshot due to a missing unlock
> > > of a snapshot lock, but it is fixed by a patch with the following subject:
> > >
> > >   "btrfs: fix hang on snapshot creation after RWF_NOWAIT write"
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >
> > So sorry for the late review.. But I hit the following failure with
> > v5.8-rc5 kernel, which contains the mentioned fix
> >
> >  QA output created by 215
> >  wrote 65536/65536 bytes at offset 0
> >  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > -wrote 65536/65536 bytes at offset 0
> > -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +pwrite: Input/output error
> >  Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
> >  File data in the subvolume:
> > -0000000 fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> > +0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
> >  *
> >  0065536
> >  File data in the snapshot:
> > -0000000 fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> > +0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
> >  *
> >  0065536
> >
> > And I did hit hang when testing without the fix. Is this something that
> > should be fixed in the test?
> 
> Odd.
> 
> Works for me on 5.8-rc5:
> 
> $ ./check btrfs/215
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 debian9 5.8.0-rc5-btrfs-next-63 #1 SMP
> PREEMPT Sun Jul 19 17:53:27 WEST 2020
> MKFS_OPTIONS  -- /dev/sdb
> MOUNT_OPTIONS -- /dev/sdb /home/fdmanana/btrfs-tests/scratch_1
> 
> btrfs/215 1s
> Ran: btrfs/215
> Passed all 1 tests
> 
> Is there anything in dmesg?

Hmm, there is a dio failure message.

[ 8077.648741] run fstests btrfs/216 at 2020-07-20 02:42:37
[ 8078.169516] BTRFS: device fsid 0de433a0-628f-4f7c-bb81-a9632d690d0f devid 1 transid 5 /dev/mapper/testvg-lv2 scanned by mkfs.btrfs (76661)
[ 8078.199269] BTRFS info (device dm-5): disk space caching is enabled
[ 8078.200897] BTRFS info (device dm-5): has skinny extents
[ 8078.202227] BTRFS info (device dm-5): flagging fs with big metadata feature
[ 8078.208853] BTRFS info (device dm-5): checking UUID tree
[ 8078.231519] BTRFS warning (device dm-5): direct IO failed ino 257 rw 1,2131969 sector 0x6800 len 4096 err no 10
[ 8078.357124] BTRFS info (device dm-5): disk space caching is enabled
[ 8078.357906] BTRFS info (device dm-5): has skinny extents

My kernel version and btrfs-progs version

[root@fedoravm xfstests]# uname -a
Linux fedoravm 5.8.0-rc5 #52 SMP Mon Jul 20 00:25:44 CST 2020 x86_64 x86_64 x86_64 GNU/Linux
[root@fedoravm xfstests]# btrfs --version
btrfs-progs v5.4

Thanks,
Eryu

> 
> 
> 
> >
> > Thanks,
> > Eryu
> >
> > > ---
> > >  tests/btrfs/214     | 66 +++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/btrfs/214.out | 14 ++++++++++
> > >  tests/btrfs/group   |  1 +
> > >  3 files changed, 81 insertions(+)
> > >  create mode 100755 tests/btrfs/214
> > >  create mode 100644 tests/btrfs/214.out
> > >
> > > diff --git a/tests/btrfs/214 b/tests/btrfs/214
> > > new file mode 100755
> > > index 00000000..c835e844
> > > --- /dev/null
> > > +++ b/tests/btrfs/214
> > > @@ -0,0 +1,66 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> > > +#
> > > +# FSQA Test No. 214
> > > +#
> > > +# Test that creating a snapshot after writing to a file using a RWF_NOWAIT
> > > +# works, does not hang the snapshot creation task, and we are able to read
> > > +# the data after.
> > > +#
> > > +seq=`basename $0`
> > > +seqres=$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +tmp=/tmp/$$
> > > +status=1     # failure is the default!
> > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > +
> > > +_cleanup()
> > > +{
> > > +     cd /
> > > +     rm -f $tmp.*
> > > +}
> > > +
> > > +# get standard environment, filters and checks
> > > +. ./common/rc
> > > +. ./common/filter
> > > +. ./common/attr
> > > +
> > > +# real QA test starts here
> > > +_supported_fs btrfs
> > > +_supported_os Linux
> > > +_require_scratch
> > > +_require_odirect
> > > +_require_xfs_io_command pwrite -N
> > > +_require_chattr C
> > > +
> > > +rm -f $seqres.full
> > > +
> > > +_scratch_mkfs >>$seqres.full 2>&1
> > > +_scratch_mount
> > > +
> > > +# RWF_NOWAIT writes require NOCOW
> > > +touch $SCRATCH_MNT/f
> > > +$CHATTR_PROG +C $SCRATCH_MNT/f
> > > +
> > > +$XFS_IO_PROG -d -c "pwrite -S 0xab 0 64K" $SCRATCH_MNT/f | _filter_xfs_io
> > > +
> > > +# Now do a WEF_WRITE into a range containing a NOCOWable extent.
> > > +$XFS_IO_PROG -d -c "pwrite -N -V 1 -S 0xfe 0 64K" $SCRATCH_MNT/f \
> > > +     | _filter_xfs_io
> > > +
> > > +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap \
> > > +     | _filter_scratch
> > > +
> > > +# Unmount, mount again and verify the file in the subvolume and snapshot has
> > > +# the correct data.
> > > +_scratch_cycle_mount
> > > +
> > > +echo "File data in the subvolume:"
> > > +od -A d -t x1 $SCRATCH_MNT/f
> > > +
> > > +echo "File data in the snapshot:"
> > > +od -A d -t x1 $SCRATCH_MNT/snap/f
> > > +
> > > +status=0
> > > +exit
> > > diff --git a/tests/btrfs/214.out b/tests/btrfs/214.out
> > > new file mode 100644
> > > index 00000000..6cc66972
> > > --- /dev/null
> > > +++ b/tests/btrfs/214.out
> > > @@ -0,0 +1,14 @@
> > > +QA output created by 214
> > > +wrote 65536/65536 bytes at offset 0
> > > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > +wrote 65536/65536 bytes at offset 0
> > > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > +Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
> > > +File data in the subvolume:
> > > +0000000 fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> > > +*
> > > +0065536
> > > +File data in the snapshot:
> > > +0000000 fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> > > +*
> > > +0065536
> > > diff --git a/tests/btrfs/group b/tests/btrfs/group
> > > index 9e48ecc1..a3706e7d 100644
> > > --- a/tests/btrfs/group
> > > +++ b/tests/btrfs/group
> > > @@ -216,3 +216,4 @@
> > >  211 auto quick log prealloc
> > >  212 auto balance dangerous
> > >  213 auto balance dangerous
> > > +214 auto quick snapshot
> > > --
> > > 2.26.2
