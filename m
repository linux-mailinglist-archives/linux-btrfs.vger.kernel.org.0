Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C64C58D58
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2019 23:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfF0Vrp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jun 2019 17:47:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfF0Vrp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jun 2019 17:47:45 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A388D2133F;
        Thu, 27 Jun 2019 21:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561672063;
        bh=SpV/uemnOrRihge5TJk4ITU92ziigblP630GRC7lbrc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iDZwlAlRNE4TdI8zZGWLcHsYNsMKV28NI1/Z1FWSKsjfQL1MvNJnH3R4FfOt1FI6U
         NoA4RMc8FNTMy/xmWXqt/uWJxAl8AuodxTg1eEoBn0PUWQSj6LqdN9WWyUoa01fgzL
         Ul7eDI3qZJrsAg4aeoFpmunVxqDc4COun2zvENiU=
Received: by mail-vs1-f47.google.com with SMTP id j26so2658421vsn.10;
        Thu, 27 Jun 2019 14:47:43 -0700 (PDT)
X-Gm-Message-State: APjAAAVmPQSoLd4/S1DwEI4dEpYOA9mz22UWERHiSjHLnxd+fBsv+G0i
        NX7f/PYI21csdw1pCjg7CNuWpuTa+Efh36DyFgs=
X-Google-Smtp-Source: APXvYqzscPkX8+onkT0PS9yyWAEmKERA4byc8s6OtXj5hIMpb0Y27HgKk8Sg5fihvfMrys0KbcAS+H5hMd5yP9+S8sw=
X-Received: by 2002:a67:d990:: with SMTP id u16mr4271105vsj.95.1561672062824;
 Thu, 27 Jun 2019 14:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190627170030.6149-1-fdmanana@kernel.org> <20190627202818.GB5167@magnolia>
In-Reply-To: <20190627202818.GB5167@magnolia>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 27 Jun 2019 22:47:31 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7PbZh3SNv+jOm_St03bkq=f2-T8Cna-no6U2+FxxMchA@mail.gmail.com>
Message-ID: <CAL3q7H7PbZh3SNv+jOm_St03bkq=f2-T8Cna-no6U2+FxxMchA@mail.gmail.com>
Subject: Re: [PATCH] generic: test cloning large exents to a file with many
 small extents
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 27, 2019 at 9:28 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Thu, Jun 27, 2019 at 06:00:30PM +0100, fdmanana@kernel.org wrote:
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
> >  tests/generic/558     | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/558.out |  5 ++++
> >  tests/generic/group   |  1 +
> >  3 files changed, 81 insertions(+)
> >  create mode 100755 tests/generic/558
> >  create mode 100644 tests/generic/558.out
> >
> > diff --git a/tests/generic/558 b/tests/generic/558
> > new file mode 100755
> > index 00000000..ee16cdf7
> > --- /dev/null
> > +++ b/tests/generic/558
> > @@ -0,0 +1,75 @@
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
>
> What if the fs block size is 64k?

Then we get extents of 64Kb instead of 4Kb. Works on btrfs. Is it a
problem for xfs (or any other fs)?

>
> > +num_extents=$(( $file_size / $extent_size ))
> > +
> > +# Create a file with many small extents.
> > +for ((i = 0; i < $num_extents; i++)); do
> > +     offset=$(( $i * $extent_size ))
> > +     $XFS_IO_PROG -f -s -c "pwrite -S 0xe5 $offset $extent_size" \
> > +             $SCRATCH_MNT/foo >>/dev/null
> > +done
>
> I wouldn't have thought that this would actually succeed on xfs because
> you could lay extents down one after the other, but then started seeing
> this in the filefrag output:
>
> File size of /opt/foo is 528384 (129 blocks of 4096 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>    3:       17..      17:         52..        52:      1:         37:
>    4:       18..      18:         67..        67:      1:         53:
>    5:       19..      19:         81..        81:      1:         68:
>    6:       20..      20:         94..        94:      1:         82:
>    7:       21..      21:        106..       106:      1:         95:
>    8:       22..      22:        117..       117:      1:        107:
>    9:       23..      23:        127..       127:      1:        118:
>   10:       24..      24:        136..       136:      1:        128:
>   11:       25..      25:        144..       144:      1:        137:
>   12:       26..      26:        151..       151:      1:        145:
>   13:       27..      27:        157..       157:      1:        152:
>   14:       28..      28:        162..       162:      1:        158:
>   15:       29..      29:        166..       166:      1:        163:
>   16:       30..      30:        169..       169:      1:        167:
>   17:       31..      32:        171..       172:      2:        170:
>   18:       33..      33:        188..       188:      1:        173:
>
> 52, 67, 81, 94, 106, 117, 127, 136, 44, 151, 157, 162, 166, 169, 171...
>
>  +15 +14 +13 +12  +11  +10   +9   +8  +7   +6   +5   +4   +3   +2...
>
> Hm, I wonder what quirk of the xfs allocator this might be?

Don't ask me, I have no idea how it works :)

>
> > +
> > +# Create file bar with the same size that file foo has but with large extents.
> > +$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b $file_size 0 $file_size" \
> > +     $SCRATCH_MNT/bar >>/dev/null
> > +
> > +# Fill the fs (for btrfs we are interested in filling all unallocated space
> > +# and most of the existing metadata block group(s), so that after this there
> > +# will be no unallocated space and metadata space will be mostly full but with
> > +# more than enough free space for the clone operation below to succeed).
> > +i=1
> > +while true; do
> > +     $XFS_IO_PROG -f -c "pwrite 0 2K" $SCRATCH_MNT/filler_$i &> /dev/null
> > +     [ $? -ne 0 ] && break
> > +     i=$(( i + 1 ))
> > +done
>
> _fill_fs?

No, because that will do fallocate. Writing 2Kb files here is on
purpose because that will fill the metadata
block group(s) (on btrfs we inline extents in the btree (metadata) as
long as they are not bigger than 2Kb, by default).
Using fallocate, we end up using data block groups.

>
> > +
> > +# Now clone file bar into file foo. This is supposed to succeed and not fail
> > +# with ENOSPC for example.
> > +$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar" $SCRATCH_MNT/foo >>/dev/null
>
> _reflink $SCRATCH_MNT/bar $SCRATCH_MNT/foo ?

Does exactly the same. I don't mind changing it however.

Thanks.

>
> --D
>
> > +
> > +_scratch_remount
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
