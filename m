Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92B0CF0062
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2019 15:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389505AbfKEO4W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Nov 2019 09:56:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:58504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389032AbfKEO4W (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Nov 2019 09:56:22 -0500
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 492D321929;
        Tue,  5 Nov 2019 14:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572965780;
        bh=buZi0+mS7wRf5GrdDBPhto2iXMeRgf5tYMRDbUvi1bc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rREkhPjTZI2cbIMlj+0gnrINfmB5XvyUUI+NUYWszawfSHOCk6Eulq/0GJhTrxB0r
         Pug4Dfo0PylYY6II3gPrl3dGXhz5qw2gPOYwjbAV+kfhSwQw5W5AGmuSNTGYBY9ih+
         8cod/Y1qT0xTeAIfhPSqXaYNtWcydm6Xj78LklcA=
Received: by mail-ua1-f42.google.com with SMTP id r22so3664306uam.11;
        Tue, 05 Nov 2019 06:56:20 -0800 (PST)
X-Gm-Message-State: APjAAAXRBJyHCScFTYR1U4Y7StAGfx3964eK58J3Nrvxtdm9O3zcyIU2
        A/AgDLm+dpFlA6yWlHhlYy+Trd59YMgwykBSQQk=
X-Google-Smtp-Source: APXvYqyo81Go4DISxxibAEj7kzM1Ks+3u/74JxbHfRwJASoQ42PAu+GCgKKtzNcI6oZ1trKAWY8u1F/2Vrwymf3FLxE=
X-Received: by 2002:ab0:7304:: with SMTP id v4mr6877867uao.0.1572965779087;
 Tue, 05 Nov 2019 06:56:19 -0800 (PST)
MIME-Version: 1.0
References: <20191030122741.11073-1-fdmanana@kernel.org> <20191102062625.GG2543@desktop>
In-Reply-To: <20191102062625.GG2543@desktop>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 5 Nov 2019 14:56:07 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5GvQeTyc=5y85sPnLKAzyqvRjJBOoxLQvHDEjpWR3MrQ@mail.gmail.com>
Message-ID: <CAL3q7H5GvQeTyc=5y85sPnLKAzyqvRjJBOoxLQvHDEjpWR3MrQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test that send can issue clone operations within
 the same file
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 2, 2019 at 6:26 AM Eryu Guan <guaneryu@gmail.com> wrote:
>
> On Wed, Oct 30, 2019 at 12:27:41PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Verify that both full and incremental send operations can issue clone
> > operations when a file has extents that are shared with itself (at
> > different offsets of course).
> >
> > This currently fails on btrfs but is addressed by a patch for the
> > kernel titled:
> >
> >   "Btrfs: send, allow clone operations within the same file"
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  tests/btrfs/200     | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/200.out |  17 +++++++
> >  tests/btrfs/group   |   1 +
> >  3 files changed, 151 insertions(+)
> >  create mode 100755 tests/btrfs/200
> >  create mode 100644 tests/btrfs/200.out
> >
> > diff --git a/tests/btrfs/200 b/tests/btrfs/200
> > new file mode 100755
> > index 00000000..e7853c4b
> > --- /dev/null
> > +++ b/tests/btrfs/200
> > @@ -0,0 +1,133 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test No. 200
> > +#
> > +# Check that send operations (full and incremental) are able to issue clone
> > +# operations for extents that are shared between the same file.
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
> > +     rm -fr $send_files_dir
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +. ./common/reflink
> > +. ./common/punch
> > +
> > +# real QA test starts here
> > +_supported_fs btrfs
> > +_supported_os Linux
> > +_require_fssum
> > +_require_test
> > +_require_scratch_reflink
> > +_require_xfs_io_command "fiemap"
> > +
> > +count_extents()
> > +{
> > +     $XFS_IO_PROG -r -c "fiemap" $1 | tail -n +2 | wc -l
> > +}
>
> There's a similar in common/rc called _count_extents(), but it opens
> file with rw permission. Perhaps you could just update the existing
> helper? (And add '-r' to _count_holes() and _count_attr_extents()?)

Indeed, I was looking at fiemap filters (in common/punch) searching
for such functionality, but apparently missed common/rc.
Yes, it serves well and it's basically the same I made.

>
> > +
> > +count_exclusive_extents()
> > +{
> > +     $XFS_IO_PROG -r -c "fiemap" $1 | tail -n +2 | cut -d ' ' -f 3 \
> > +             | sort | uniq | wc -l
> > +}
>
> And maybe add this one to common helper too.

Yes, I'll send a new patchset soon for that.

Thanks.

>
> Otherwise looks good to me.
>
> Thanks,
> Eryu
>
> > +
> > +send_files_dir=$TEST_DIR/btrfs-test-$seq
> > +
> > +rm -f $seqres.full
> > +rm -fr $send_files_dir
> > +mkdir $send_files_dir
> > +
> > +_scratch_mkfs >>$seqres.full 2>&1
> > +_scratch_mount
> > +
> > +# Create our first test file, which has an extent that is shared only with
> > +# itself and no other files. We want to verify a full send operation will
> > +# clone the extent.
> > +$XFS_IO_PROG -f -c "pwrite -S 0xb1 -b 64K 0 64K" $SCRATCH_MNT/foo \
> > +     | _filter_xfs_io
> > +$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 64K 64K" $SCRATCH_MNT/foo \
> > +     | _filter_xfs_io
> > +
> > +# Create out second test file which initially, for the first send operation,
> > +# only has a single extent that is not shared.
> > +$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 64K 0 64K" $SCRATCH_MNT/bar \
> > +     | _filter_xfs_io
> > +
> > +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base 2>&1 \
> > +     | _filter_scratch
> > +
> > +$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
> > +     | _filter_scratch
> > +
> > +# Now clone the existing extent in file bar to itself at a different offset.
> > +# We want to verify the incremental send operation below will issue a clone
> > +# operation instead of a write operation.
> > +$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 64K 64K" $SCRATCH_MNT/bar \
> > +     | _filter_xfs_io
> > +
> > +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1 \
> > +     | _filter_scratch
> > +
> > +$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
> > +     $SCRATCH_MNT/incr 2>&1 | _filter_scratch
> > +
> > +# Compute digests of the snapshot trees so that later we can compare against
> > +# digests of the trees in the new filesystem, to see if they match (no data or
> > +# metadata corruption happened).
> > +$FSSUM_PROG -A -f -w $send_files_dir/base.fssum $SCRATCH_MNT/base
> > +$FSSUM_PROG -A -f -w $send_files_dir/incr.fssum \
> > +     -x $SCRATCH_MNT/incr/base $SCRATCH_MNT/incr
> > +
> > +# Now recreate the filesystem by receiving both send streams and verify we get
> > +# the same file contents that the original filesystem had and that files foo
> > +# and bar have shared extents.
> > +_scratch_unmount
> > +_scratch_mkfs >>$seqres.full 2>&1
> > +_scratch_mount
> > +
> > +$BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT
> > +$BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT
> > +
> > +# Compute digests of the snapshot trees in the new filesystem and compare them
> > +# to the ones in the original filesystem, they must match.
> > +$FSSUM_PROG -r $send_files_dir/base.fssum $SCRATCH_MNT/base
> > +$FSSUM_PROG -r $send_files_dir/incr.fssum $SCRATCH_MNT/incr
> > +
> > +num_extents=$(count_extents $SCRATCH_MNT/base/foo)
> > +num_exclusive_extents=$(count_exclusive_extents $SCRATCH_MNT/base/foo)
> > +if [ $num_extents -ne 2 ] || [ $num_exclusive_extents -ne 1 ]; then
> > +     echo "File foo does not have 2 shared extents in the base snapshot"
> > +     $XFS_IO_PROG -r -c "fiemap" $SCRATCH_MNT/base/foo
> > +fi
> > +
> > +num_extents=$(count_extents $SCRATCH_MNT/incr/foo)
> > +num_exclusive_extents=$(count_exclusive_extents $SCRATCH_MNT/incr/foo)
> > +if [ $num_extents -ne 2 ] || [ $num_exclusive_extents -ne 1 ]; then
> > +     echo "File foo does not have 2 shared extents in the incr snapshot"
> > +     $XFS_IO_PROG -r -c "fiemap" $SCRATCH_MNT/incr/foo
> > +fi
> > +
> > +num_extents=$(count_extents $SCRATCH_MNT/incr/bar)
> > +num_exclusive_extents=$(count_exclusive_extents $SCRATCH_MNT/incr/bar)
> > +if [ $num_extents -ne 2 ] || [ $num_exclusive_extents -ne 1 ]; then
> > +     echo "File bar does not have 2 shared extents in the incr snapshot"
> > +     $XFS_IO_PROG -r -c "fiemap" $SCRATCH_MNT/incr/bar
> > +fi
> > +
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/200.out b/tests/btrfs/200.out
> > new file mode 100644
> > index 00000000..3eec567e
> > --- /dev/null
> > +++ b/tests/btrfs/200.out
> > @@ -0,0 +1,17 @@
> > +QA output created by 200
> > +wrote 65536/65536 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +linked 65536/65536 bytes at offset 65536
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +wrote 65536/65536 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
> > +At subvol SCRATCH_MNT/base
> > +linked 65536/65536 bytes at offset 65536
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
> > +At subvol SCRATCH_MNT/incr
> > +At subvol base
> > +At snapshot incr
> > +OK
> > +OK
> > diff --git a/tests/btrfs/group b/tests/btrfs/group
> > index c7ab129e..d56dcafa 100644
> > --- a/tests/btrfs/group
> > +++ b/tests/btrfs/group
> > @@ -202,3 +202,4 @@
> >  197 auto quick volume
> >  198 auto quick volume
> >  199 auto quick trim
> > +200 auto quick send clone
> > --
> > 2.11.0
> >
