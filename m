Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 988A7C9CFC
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2019 13:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfJCLMu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Oct 2019 07:12:50 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46931 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729912AbfJCLMu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Oct 2019 07:12:50 -0400
Received: by mail-vs1-f65.google.com with SMTP id z14so1377826vsz.13;
        Thu, 03 Oct 2019 04:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=yBDHlcoYRQdJmmXThhd8XlzFxe0grDwuOQ/RnIBDyj4=;
        b=dMm2ZxL0vi0uHyI3gZ06R5FPeEaymd3GM9TCzNk8jbSMAK3CA0fR/H56BOQdORPXtw
         3oIoddQE3VgTh1RqqYkZ/j1xKCElFkT/bPPjnLIbR5pIFbtsBKsme18oiuwP2PttTisg
         XfbhgVyu6sEWtE14oO6IFsznjMtjhBMnZZNrlsql/ZnZI+/aNdSoDZWV5B8qPM1QDiGt
         WbrEJhRmdeBJaBFEdwbkZPMJUUbDTP8ZC3i+BJ/PW0oa3f50JvUla8jUrbNtQaH1A+WA
         oQ2uKRMd5A0BnbcnxkP4syECaxL97xcNCIZMUKBf09jXhWaMjaKJYNfnBFIji4Vt9v30
         ny+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=yBDHlcoYRQdJmmXThhd8XlzFxe0grDwuOQ/RnIBDyj4=;
        b=lxtwsbomUENFnUQF4vqfvz3RFYG/XG6FUQYueOCc+K/HDQBBbFsDNaisacMHuTkkkk
         9IBBnsE6rgOiWvBWWdlFSkJhMJyotMimp6iJFPvt1EeHL+IRSq46diMuoMJFE6cqxCcq
         818kYkv+K7qgf/dY2MQDTR2fVPj+NOHseNOj8SLEuabK1dHD9g3fJepY3kfdzVw0xiB6
         0UtoKgN+oeYCSMDlc0EMGtAA0lNUCuz3svYwtop8AhgJs4GP/hSFFKXz0Yn+9OtzJY2J
         W5u3nhT+TKLF25vg1dgWD/GVAovH9Avgg/XGSEadS3DuPWNnlhrcSiSFfXOLmzv1jImn
         xNnw==
X-Gm-Message-State: APjAAAUcbpTaCqGHpr7lOKIoE6XgJ9xVcgSCfH+I7twOIQg4vomq8dvz
        Cp8qplqtbKZGvijfYGR6JLfOXLyk+jwHzr+ifqk=
X-Google-Smtp-Source: APXvYqzw6XX2a2rcNHe2r6nDiR42wU22xVfEtiY0pzoYqHwW8PrGKBEuuB6d87E0fSkPB08Pt3VNtLUYJ3+XNmb383g=
X-Received: by 2002:a67:2d13:: with SMTP id t19mr4067794vst.99.1570101167781;
 Thu, 03 Oct 2019 04:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191002184133.21099-1-josef@toxicpanda.com> <CAL3q7H6e2DS-zCs+0z1U4SfLhcQw3UM1tte6kgmk0uNx+hMf7g@mail.gmail.com>
In-Reply-To: <CAL3q7H6e2DS-zCs+0z1U4SfLhcQw3UM1tte6kgmk0uNx+hMf7g@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 3 Oct 2019 12:12:36 +0100
Message-ID: <CAL3q7H47wKpDPGDd4v5-xYsbsSVug3tEeWNxJYSUJ1Cr-8FtTg@mail.gmail.com>
Subject: Re: [PATCH][v2] btrfs/194: add a test for multi-subvolume fsyncing
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 3, 2019 at 11:59 AM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Wed, Oct 2, 2019 at 7:44 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > I discovered a problem in btrfs where we'd end up pointing at a block w=
e
> > hadn't written out yet.  This is triggered by a race when two different
> > files on two different subvolumes fsync.  This test exercises this path
> > with dm-log-writes, and then replays the log at every FUA to verify the
> > file system is still mountable and the log is replayable.
> >
> > This test is to verify the fix
> >
> > btrfs: fix incorrect updating of log root tree
> >
> > actually fixed the problem.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> It's working now.
> Confirmed this triggers the bug, and after about 4 hours of this
> running with the btrfs patch, it doesn't trigger the bug anymore.
>
> Thanks!
>
> > ---
> > v1->v2:
> > - added the patchname related to this test in the comments and changelo=
g.
> > - running fio makes it use 400mib of shared memory, so running 50 of th=
em is
> >   impossible on boxes that don't have hundreds of gib of RAM.  Fixed th=
is to
> >   just generate a fio config so we can run 1 fio instance with 50 threa=
ds which
> >   makes it not OOM boxes with tiny amounts of RAM.
> > - fixed some formatting things that Filipe pointed out.
> >
> >  tests/btrfs/194     | 111 ++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/194.out |   2 +
> >  tests/btrfs/group   |   1 +
> >  3 files changed, 114 insertions(+)
> >  create mode 100755 tests/btrfs/194
> >  create mode 100644 tests/btrfs/194.out
> >
> > diff --git a/tests/btrfs/194 b/tests/btrfs/194
> > new file mode 100755
> > index 00000000..b98064e2
> > --- /dev/null
> > +++ b/tests/btrfs/194
> > @@ -0,0 +1,111 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2019 Facebook.  All Rights Reserved.
> > +#
> > +# FS QA Test 194
> > +#
> > +# Test multi subvolume fsync to test a bug where we'd end up pointing =
at a block
> > +# we haven't written.  This was fixed by the patch
> > +#
> > +# btrfs: fix incorrect updating of log root tree
> > +#
> > +# Will do log replay and check the filesystem.
> > +#
> > +seq=3D`basename $0`
> > +seqres=3D$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=3D`pwd`
> > +tmp=3D/tmp/$$
> > +fio_config=3D$tmp.fio
> > +status=3D1       # failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +       cd /
> > +       _log_writes_cleanup &> /dev/null
> > +       _dmthin_cleanup
> > +       rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +. ./common/dmthin
> > +. ./common/dmlogwrites
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs generic

Btw, only forgot about this.
Should be: _supported_fs btrfs

Eryu can probably fix that at commit time.
Thanks.

> > +_supported_os Linux
> > +
> > +# Use thin device as replay device, which requires $SCRATCH_DEV
> > +_require_scratch_nocheck
> > +# and we need extra device as log device
> > +_require_log_writes
> > +_require_dm_target thin-pool
> > +
> > +cat >$fio_config <<EOF
> > +[global]
> > +readwrite=3Dwrite
> > +fallocate=3Dnone
> > +bs=3D4k
> > +fsync=3D1
> > +size=3D128k
> > +EOF
> > +
> > +for i in $(seq 0 49); do
> > +       echo "[foo$i]" >> $fio_config
> > +       echo "filename=3D$SCRATCH_MNT/$i/file" >> $fio_config
> > +done
> > +
> > +_require_fio $fio_config
> > +
> > +cat $fio_config >> $seqres.full
> > +
> > +# Use a thin device to provide deterministic discard behavior. Discard=
s are used
> > +# by the log replay tool for fast zeroing to prevent out-of-order repl=
ay issues.
> > +_test_unmount
> > +_dmthin_init $devsize $devsize $csize $lowspace
> > +_log_writes_init $DMTHIN_VOL_DEV
> > +_log_writes_mkfs >> $seqres.full 2>&1
> > +_log_writes_mark mkfs
> > +
> > +_log_writes_mount
> > +
> > +# First create all the subvolumes
> > +for i in $(seq 0 49); do
> > +       $BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/$i" > /dev/null
> > +done
> > +
> > +$FIO_PROG $fio_config > /dev/null 2>&1
> > +_log_writes_unmount
> > +
> > +_log_writes_remove
> > +prev=3D$(_log_writes_mark_to_entry_number mkfs)
> > +[ -z "$prev" ] && _fail "failed to locate entry mark 'mkfs'"
> > +cur=3D$(_log_writes_find_next_fua $prev)
> > +[ -z "$cur" ] && _fail "failed to locate next FUA write"
> > +
> > +while [ ! -z "$cur" ]; do
> > +       _log_writes_replay_log_range $cur $DMTHIN_VOL_DEV >> $seqres.fu=
ll
> > +
> > +       # We need to mount the fs because btrfsck won't bother checking=
 the log.
> > +       _dmthin_mount
> > +       _dmthin_check_fs
> > +
> > +       prev=3D$cur
> > +       cur=3D$(_log_writes_find_next_fua $(($cur + 1)))
> > +       [ -z "$cur" ] && break
> > +done
> > +
> > +echo "Silence is golden"
> > +
> > +# success, all done
> > +status=3D0
> > +exit
> > diff --git a/tests/btrfs/194.out b/tests/btrfs/194.out
> > new file mode 100644
> > index 00000000..7bfd50ff
> > --- /dev/null
> > +++ b/tests/btrfs/194.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 194
> > +Silence is golden
> > diff --git a/tests/btrfs/group b/tests/btrfs/group
> > index b92cb12c..0d0e1bba 100644
> > --- a/tests/btrfs/group
> > +++ b/tests/btrfs/group
> > @@ -196,3 +196,4 @@
> >  191 auto quick send dedupe
> >  192 auto replay snapshot stress
> >  193 auto quick qgroup enospc limit
> > +194 auto metadata log volume
> > --
> > 2.21.0
> >
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
