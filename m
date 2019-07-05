Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D2660425
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 12:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfGEKJv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 06:09:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfGEKJu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jul 2019 06:09:50 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFF242082F;
        Fri,  5 Jul 2019 10:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562321390;
        bh=0BxU01BrYomMrX2p6MmpV7gLPH+Dbl0eYHKq+5X5nho=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SpUm7wXEcMAIN0BjTj1HwjtQw3Q5gSfg1oCejLtYBP5cQWFHtObOB2ax4t8G9rqnT
         s6HBqbt5e7st2FS5XG4FOv6yIwvfhuX6XY/xtgENTaHRUwsmlM9+AuAOYWLQ9+WuA+
         ZiofbQdhXTKJSqIYjfI4hUvRx7UCahMC/6q+VLd0=
Received: by mail-vs1-f44.google.com with SMTP id m8so3495749vsj.0;
        Fri, 05 Jul 2019 03:09:49 -0700 (PDT)
X-Gm-Message-State: APjAAAVEtaI7kRFUST465jf+lYCTLEFXJ5wmQxccxTWBZUpq+UPnida/
        LYPjOCs0Pc5Hao/FIsQwhGut/Lm7TQ6e7y1olq4=
X-Google-Smtp-Source: APXvYqxC9mlSHFSZfIw2suhBlmywevbCb5toDOGArzpSHq4KXZZaXhnnZ4R/5ccUGfMAlSVpOjKsQvLi7ibLZGohJc4=
X-Received: by 2002:a67:de08:: with SMTP id q8mr1585634vsk.206.1562321389000;
 Fri, 05 Jul 2019 03:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190627170030.6149-1-fdmanana@kernel.org> <20190628220836.16096-1-fdmanana@kernel.org>
 <20190705074327.GF7943@desktop>
In-Reply-To: <20190705074327.GF7943@desktop>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 5 Jul 2019 11:09:38 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4co58OcST+qZpB1mz_EQb=jOouDd+g+Ykmkx1dB01m0g@mail.gmail.com>
Message-ID: <CAL3q7H4co58OcST+qZpB1mz_EQb=jOouDd+g+Ykmkx1dB01m0g@mail.gmail.com>
Subject: Re: [PATCH v2] generic: test cloning large exents to a file with many
 small extents
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 5, 2019 at 8:43 AM Eryu Guan <guaneryu@gmail.com> wrote:
>
> On Fri, Jun 28, 2019 at 11:08:36PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that if we clone a file with some large extents into a file that has
> > many small extents, when the fs is nearly full, the clone operation does
> > not fail and produces the correct result.
> >
> > This is motivated by a bug found in btrfs wich is fixed by the following
> > patches for the linux kernel:
> >
> >  [PATCH 1/2] Btrfs: factor out extent dropping code from hole punch handler
> >  [PATCH 2/2] Btrfs: fix ENOSPC errors, leading to transaction aborts, when
> >              cloning extents
> >
> > The test currently passes on xfs.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >
> > V2: Use _scratch_cycle_mount instead of _scratch_remount, as we want to see
> >     if the operation was durably persisted (otherwise we are seeing content
> >     from the page cache).
> >     Use _reflink instead of calling xfs_io with the reflink command.
> >     Make the comment before filling the filesystem more clear about why it
> >     is done the way it is instead of using _fill_fs.
> >
> >  tests/generic/558     | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/558.out |  5 ++++
> >  tests/generic/group   |  1 +
> >  3 files changed, 86 insertions(+)
> >  create mode 100755 tests/generic/558
> >  create mode 100644 tests/generic/558.out
> >
> > diff --git a/tests/generic/558 b/tests/generic/558
> > new file mode 100755
> > index 00000000..f982930d
> > --- /dev/null
> > +++ b/tests/generic/558
> > @@ -0,0 +1,80 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FSQA Test No. 558
> > +#
> > +# Test that if we clone a file with some large extents into a file that has
> > +# many small extents, when the fs is nearly full, the clone operation does
> > +# not fail and produces the correct result.
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
> > +. ./common/reflink
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_supported_os Linux
> > +_require_scratch_reflink
> > +
> > +rm -f $seqres.full
> > +
> > +_scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1
> > +_scratch_mount
> > +
> > +file_size=$(( 128 * 1024 * 1024 )) # 128Mb
> > +extent_size=4096
> > +num_extents=$(( $file_size / $extent_size ))
> > +
> > +# Create a file with many small extents.
> > +for ((i = 0; i < $num_extents; i++)); do
> > +     offset=$(( $i * $extent_size ))
> > +     $XFS_IO_PROG -f -s -c "pwrite -S 0xe5 $offset $extent_size" \
> > +             $SCRATCH_MNT/foo >>/dev/null
> > +done
>
> This is taking too long time (1000+s) to finish when testing on XFS.

Hum, for on 5.2-rc, debug kernel (lockdep, plenty of other debug stuff
enabled that slows things down), it takes about 350 seconds for me.

> I'm
> wondering if we could take use of src/punch-alternating to punch out
> every other block to create a file with many small extents.

That's fine, I didn't remember about that.

>
> i.e. with the following diffs, test runs & passes with XFS within 90s
> while still reproduces the btrfs bug (note that I have to increase the
> file_size to 200M to reproduce the btrfs bug, while 256M seems bring
> test time back to 1000+s). Would you please check if this works for you?

It does, thanks!
And, because of the holes, it uncovered a bug in my fix (second patch).

Now it takes ~15 seconds on btrfs instead of ~300s and ~100s on xfs for me.

>
> Thanks,
> Eryu
>
>
> diff --git a/tests/generic/558 b/tests/generic/558
> index f982930d65a2..40f8a7a98d3f 100755
> --- a/tests/generic/558
> +++ b/tests/generic/558
> @@ -30,22 +30,22 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch_reflink
> +_require_test_program "punch-alternating"
> +_require_xfs_io_command "fpunch"
>
>  rm -f $seqres.full
>
>  _scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1
>  _scratch_mount
>
> -file_size=$(( 128 * 1024 * 1024 )) # 128Mb
> +file_size=$(( 200 * 1024 * 1024 )) # 200MB
>  extent_size=4096
>  num_extents=$(( $file_size / $extent_size ))

These two variables, extent_size and num_extents, are no longer needed.

Do you want me to send another version of the patch or can you apply
this patch on top of it?

Thanks.

>
>  # Create a file with many small extents.
> -for ((i = 0; i < $num_extents; i++)); do
> -       offset=$(( $i * $extent_size ))
> -       $XFS_IO_PROG -f -s -c "pwrite -S 0xe5 $offset $extent_size" \
> -               $SCRATCH_MNT/foo >>/dev/null
> -done
> +$XFS_IO_PROG -f -c "pwrite -S 0xe5 -b $file_size 0 $file_size" \
> +       $SCRATCH_MNT/foo >>/dev/null
> +$here/src/punch-alternating $SCRATCH_MNT/foo >> $seqres.full
>
>  # Create file bar with the same size that file foo has but with large extents.
>  $XFS_IO_PROG -f -c "pwrite -S 0xc7 -b $file_size 0 $file_size" \
> diff --git a/tests/generic/558.out b/tests/generic/558.out
> index d1e8e70f5b79..00cb5a9744aa 100644
> --- a/tests/generic/558.out
> +++ b/tests/generic/558.out
> @@ -2,4 +2,4 @@ QA output created by 558
>  File foo data after cloning and remount:
>  0000000 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7
>  *
> -134217728
> +209715200
>
> > +
> > +# Create file bar with the same size that file foo has but with large extents.
> > +$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b $file_size 0 $file_size" \
> > +     $SCRATCH_MNT/bar >>/dev/null
> > +
> > +# Fill the fs (For btrfs we are interested in filling all unallocated space
> > +# and most of the existing metadata block group(s), so that after this there
> > +# will be no unallocated space and metadata space will be mostly full but with
> > +# more than enough free space for the clone operation below to succeed, we
> > +# create files with 2Kb because that results in extents inlined in the metadata
> > +# (btree leafs) and it's the fastest way to fill metadata space on btrfs, by
> > +# default btrfs inlines up to 2Kb of data).
> > +i=1
> > +while true; do
> > +     $XFS_IO_PROG -f -c "pwrite 0 2K" $SCRATCH_MNT/filler_$i &> /dev/null
> > +     [ $? -ne 0 ] && break
> > +     i=$(( i + 1 ))
> > +done
> > +
> > +# Now clone file bar into file foo. This is supposed to succeed and not fail
> > +# with ENOSPC for example.
> > +_reflink $SCRATCH_MNT/bar $SCRATCH_MNT/foo >>$seqres.full
> > +
> > +# Unmount and mount the filesystem again to verify the operation was durably
> > +# persisted.
> > +_scratch_cycle_mount
> > +
> > +echo "File foo data after cloning and remount:"
> > +od -A d -t x1 $SCRATCH_MNT/foo
> > +
> > +status=0
> > +exit
> > diff --git a/tests/generic/558.out b/tests/generic/558.out
> > new file mode 100644
> > index 00000000..d1e8e70f
> > --- /dev/null
> > +++ b/tests/generic/558.out
> > @@ -0,0 +1,5 @@
> > +QA output created by 558
> > +File foo data after cloning and remount:
> > +0000000 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7
> > +*
> > +134217728
> > diff --git a/tests/generic/group b/tests/generic/group
> > index 543c0627..c06c1cd1 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -560,3 +560,4 @@
> >  555 auto quick cap
> >  556 auto quick casefold
> >  557 auto quick log
> > +558 auto clone
> > --
> > 2.11.0
> >
