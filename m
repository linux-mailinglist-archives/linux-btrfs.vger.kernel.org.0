Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29A92AB79D
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 12:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgKIL5R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 06:57:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgKIL5R (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 06:57:17 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BC8F20789;
        Mon,  9 Nov 2020 11:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604923035;
        bh=PXCY6qSCdTgNgfvkvHIaRJLY2bz4O4JR2TzlDlTRYL8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IKy+16oZopbCynh2CSv/k64q64Y1N17X7xONcl22nELjYaiw2ALHoOjzEStepdsrj
         Xqw40aKbqkzhpfrqHhapAXXay2VETcCjTM0sjPURqHaRSzRXTloaLsUU4rEpqhizVU
         9RG7L+zFvXykBhO/9zuof2Bp+/KMfs8Nx4Iw+9sg=
Received: by mail-qt1-f174.google.com with SMTP id f93so5719835qtb.10;
        Mon, 09 Nov 2020 03:57:15 -0800 (PST)
X-Gm-Message-State: AOAM532a/Q6P9REbUDpmRCBzdLF7i8iddpicA5RgucV6NZK831qXSgXl
        FdBMyfHbgOxWiJT3f1rQPiYl1aH3WjiOYyZ3k2Y=
X-Google-Smtp-Source: ABdhPJxq6Ziqs4FTzcUuJiUGd2xo3sd7fuVtGJ5pogKrkajiBv6F5eu92qaWSxFTpyK95KFWtYcbZ+S+PGhvVz7twh4=
X-Received: by 2002:ac8:5a04:: with SMTP id n4mr4087425qta.21.1604923034674;
 Mon, 09 Nov 2020 03:57:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604487838.git.fdmanana@suse.com> <97125f898446b152fd759eba2f2c5963d3daadc0.1604487838.git.fdmanana@suse.com>
 <20201108091707.GH3853@desktop>
In-Reply-To: <20201108091707.GH3853@desktop>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 9 Nov 2020 11:57:03 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4_Ce5v7UPKbs+1dayQ7wceub2VNbbG6uoXRO4S7AGhWA@mail.gmail.com>
Message-ID: <CAL3q7H4_Ce5v7UPKbs+1dayQ7wceub2VNbbG6uoXRO4S7AGhWA@mail.gmail.com>
Subject: Re: [PATCH 2/2] generic: test for non-zero used blocks while writing
 into a file
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Nov 8, 2020 at 9:17 AM Eryu Guan <guan@eryu.me> wrote:
>
> On Wed, Nov 04, 2020 at 11:13:53AM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that if we keep overwriting an entire file, either with buffered
> > writes or direct IO writes, the number of used blocks reported by stat(2)
> > is never zero while the writes and writeback are in progress.
> >
> > This is motivated by a bug in btrfs and currently fails on btrfs only. It
> > is fixed a patchset for btrfs that has the following patches:
> >
> >   btrfs: fix missing delalloc new bit for new delalloc ranges
> >   btrfs: refactor btrfs_drop_extents() to make it easier to extend
> >   btrfs: fix race when defragging that leads to unnecessary IO
> >   btrfs: update the number of bytes used by an inode atomically
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  tests/generic/615     | 77 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/615.out |  3 ++
> >  tests/generic/group   |  1 +
> >  3 files changed, 81 insertions(+)
> >  create mode 100755 tests/generic/615
> >  create mode 100644 tests/generic/615.out
> >
> > diff --git a/tests/generic/615 b/tests/generic/615
> > new file mode 100755
> > index 00000000..e392c4a5
> > --- /dev/null
> > +++ b/tests/generic/615
> > @@ -0,0 +1,77 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test No. 615
> > +#
> > +# Test that if we keep overwriting an entire file, either with buffered writes
> > +# or direct IO writes, the number of used blocks reported by stat(2) is never
> > +# zero while the writes and writeback are in progress.
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
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_require_scratch
> > +_require_odirect
> > +
> > +rm -f $seqres.full
> > +
> > +stat_loop()
> > +{
> > +     trap "wait; exit" SIGTERM
> > +     local filepath=$1
> > +     local blocks
> > +
> > +     while :; do
> > +             blocks=$(stat -c %b $filepath)
> > +             if [ $blocks -eq 0 ]; then
> > +                 echo "error: stat(2) reported zero blocks"
> > +             fi
> > +     done
> > +}
> > +
> > +_scratch_mkfs >>$seqres.full 2>&1
> > +_scratch_mount
> > +
> > +$XFS_IO_PROG -f -s -c "pwrite -b 64K 0 64K" $SCRATCH_MNT/foo >>$seqres.full
> > +
> > +stat_loop $SCRATCH_MNT/foo &
> > +loop_pid=$!
> > +
> > +echo "Testing buffered writes"
> > +
> > +# Now keep overwriting the entire file, triggering writeback after each write,
> > +# while another process is calling stat(2) on the file. We expect the number of
> > +# used blocks reported by stat(2) to be always greater than 0.
> > +for ((i = 0; i < 5000; i++)); do
> > +     $XFS_IO_PROG -s -c "pwrite -b 64K 0 64K" $SCRATCH_MNT/foo >>$seqres.full
> > +done
>
> Test 5000 loops of sync write takes 3 mins to 5 mins for me on my test
> vm, which has 2 vcpus and 8G memory.

That's slow yes. It takes ~60 seconds on my vms with 4 and 8 cpus (and
8Gb of ram).

>
> I think we could reduce the test time by
> - lower the loop count, maybe 2000, in my test it usually reproduces
>   within 1000 iterations.

I can leave it to 2000 iterations per write type. For me sometimes it
doesn't reproduce with 1000.

> - drop "-s" option, it speeds up the test from ~180s to ~25s, and btrfs
>   still reproduces the bug. But it seems dropping "-s" make it harder to
>   hit the bug, perhaps 3000-5000 iteration should be fine.

The -s is important here for buffered writes.
The purpose, as the comment and test description mention, is to
trigger a race between stat and writeback.
In your case, because it runs much slower, even without -s writeback
is still being triggered a few times, so that's probably why you see
it fail for the buffered writes case.

> - reduce the write buffer size, a 16K write still reproduce the bug on
>   btrfs for me. But if we want to cover 64K page size env, I think 64K
>   buffer is fine, as long as "-s" is dropped.

Yes, the 64K is there so that it works on the 64K page size case.

>
> Further, I think we could exit early when "zero blocks" is found, e.g.
> call "_fail" instead of "echo" in stat_loop() and in the write loop,
> check for $loop_pid before every write, and break the loop if $loop_pid
> died. So we could report failure as soon as possible. For example
>
> for ((i = 0; i < 5000; i++)); do
>         if ! kill -s 0 $loop_pid; then
>                 echo "Bug reproduced at iteration $i"
>                 break
>         fi
>         $XFS_IO_PROG -s -c "pwrite -b 64K 0 64K" $SCRATCH_MNT/foo >>$seqres.full
> done

I can do that, and added in v2 in fact, together with 2000 iterations
instead of 5000.

I don't think however it's that much important to make it fail faster.
What is more useful is to make it run faster in the success (expected)
case while still being able to trigger the btrfs race frequently
enough.

Thanks.

>
> Thanks,
> Eryu
>
> > +echo "Testing direct IO writes"
> > +
> > +# Now similar to what we did before but for direct IO writes.
> > +for ((i = 0; i < 5000; i++)); do
> > +     $XFS_IO_PROG -d -c "pwrite -b 64K 0 64K" $SCRATCH_MNT/foo >>$seqres.full
> > +done
> > +
> > +kill $loop_pid &> /dev/null
> > +wait
> > +
> > +status=0
> > +exit
> > diff --git a/tests/generic/615.out b/tests/generic/615.out
> > new file mode 100644
> > index 00000000..3b549e96
> > --- /dev/null
> > +++ b/tests/generic/615.out
> > @@ -0,0 +1,3 @@
> > +QA output created by 615
> > +Testing buffered writes
> > +Testing direct IO writes
> > diff --git a/tests/generic/group b/tests/generic/group
> > index ab8ae74e..fb3c638c 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -617,3 +617,4 @@
> >  612 auto quick clone
> >  613 auto quick encrypt
> >  614 auto quick rw
> > +615 auto rw
> > --
> > 2.28.0
