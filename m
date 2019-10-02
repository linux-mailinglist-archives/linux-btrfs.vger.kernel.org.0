Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5894DC8D80
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 17:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfJBP7l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 11:59:41 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37291 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfJBP7k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Oct 2019 11:59:40 -0400
Received: by mail-vs1-f68.google.com with SMTP id p13so12279648vsr.4;
        Wed, 02 Oct 2019 08:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=1qSD1pA0mVDAyNlcObKInkm71TQza8I4LieiYmzqGiI=;
        b=ocyGKDp2N/CG9LSi5go3mrRyW79l+HlNqFiIaWWYE/xIuhb2z8HIxn0+rlpoW8+Oo2
         UknilbMPlXw6Au2Dd7Uc+4lWwZCKGFpQGlehf3wnvLo7dgDlGUe9Od7LGZSQnrFUwpsL
         aQZgKFYbpb4ZgK1GHs9qyvbP/L3kIbqFvGR79unMtxgYJnxxHgKj2pzqN3ncypGcxCcT
         /QI9ZAmzoXS0PI6clse5PFek/FfuM+7voEXikL4g5xBsnjaSlmil0ZxUIY187l7Dj4RL
         HIhvCouQ9pi6MA/ONRPhma5VOS3qXyaOzBTtBrYQvstcCFYdt/yo/zyI+EonbVskoQjc
         deMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=1qSD1pA0mVDAyNlcObKInkm71TQza8I4LieiYmzqGiI=;
        b=SZ277gzj4OvmkIM7LyDUwVVtP0UXtxs3QdcrYYRm3Q0aTg7bYftRDVquD6VHRIyIze
         UrdZm4eL1jUEhndpitJZaAwpvTyIBfbocJVkph14xQnfWp8e2WEKOzAp4nAK88g+J6UF
         rqM8edQ24CegKqkH+d8Y0N/AmToDiilQDkQQpy1zWH+3gbaoLKqQBUQjBinr0+lw8cFk
         jiaD2PzPcNBH3v0yVLcswkDOSFBaBcSGRjLzOJUFGI1eOwrLO9dxzroDpMuKnRoGS8iN
         9PceY7zIrWeiRuDuHZgaazxDGwb7LTqtfQmRLaiQTKrfEA6vfibWTFZM6v8Y1/xiQFKX
         E/ZA==
X-Gm-Message-State: APjAAAV0+EG6IxpbQw9auwIFWoDe+/d8cjYhz74OiABUTenhiCVM/Bqu
        KwPoY4tAZAnfD9LzuhcZFDzPBlXSb20OztFxNrA=
X-Google-Smtp-Source: APXvYqxaKxIuFHzvmhJZxwJRWo8SsSLHc5jJ+ecOWfWO+z2lOPEMO4pRU3Lgxa/C7aJLKXzaBL5VBQHxBKMqpt3HsP4=
X-Received: by 2002:a67:bc15:: with SMTP id t21mr2237237vsn.90.1570031977528;
 Wed, 02 Oct 2019 08:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191001200551.1513-1-josef@toxicpanda.com> <CAL3q7H4CD8A+WjQbeT=MZ_k7ibiT9fe_+NvPpQ2m2=+99Mt9FQ@mail.gmail.com>
 <20191002135633.qeurdguga57r4mza@MacBook-Pro-91.local>
In-Reply-To: <20191002135633.qeurdguga57r4mza@MacBook-Pro-91.local>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 2 Oct 2019 16:59:26 +0100
Message-ID: <CAL3q7H44qTCA5vfWsJKbf9_qhO0Yg-FNq5wqJ6_TXeNXQ3gCjA@mail.gmail.com>
Subject: Re: [PATCH] btrfs/194: add a test for multi-subvolume fsyncing
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com,
        fstests <fstests@vger.kernel.org>, Josef Bacik <jbacik@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 2, 2019 at 2:56 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Wed, Oct 02, 2019 at 11:22:40AM +0100, Filipe Manana wrote:
> > On Wed, Oct 2, 2019 at 5:29 AM Josef Bacik <josef@toxicpanda.com> wrote=
:
> > >
> > > From: Josef Bacik <jbacik@fb.com>
> > >
> > > I discovered a problem in btrfs where we'd end up pointing at a block=
 we
> > > hadn't written out yet.  This is triggered by a race when two differe=
nt
> > > files on two different subvolumes fsync.  This test exercises this pa=
th
> > > with dm-log-writes, and then replays the log at every FUA to verify t=
he
> > > file system is still mountable and the log is replayable.
> >
> > Please mention in the changelog, or in the test's description, the
> > subject of the patch that fixes the problem.
> > Otherwise people running the test and seeing failures will have a hard
> > time figuring things out (think of QA teams
> > for example, or anyone some weeks or months after, where context is
> > lost and mailing list search is not that great).
> >
> > >
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ---
> > >  tests/btrfs/194     | 102 ++++++++++++++++++++++++++++++++++++++++++=
++
> > >  tests/btrfs/194.out |   2 +
> > >  tests/btrfs/group   |   1 +
> > >  3 files changed, 105 insertions(+)
> > >  create mode 100755 tests/btrfs/194
> > >  create mode 100644 tests/btrfs/194.out
> > >
> > > diff --git a/tests/btrfs/194 b/tests/btrfs/194
> > > new file mode 100755
> > > index 00000000..d5edb313
> > > --- /dev/null
> > > +++ b/tests/btrfs/194
> > > @@ -0,0 +1,102 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2019 Facebook.  All Rights Reserved.
> > > +#
> > > +# FS QA Test 194
> > > +#
> > > +# Test multi subvolume fsync to test a bug where we'd end up pointin=
g at a block
> > > +# we haven't written.
> > > +#
> > > +# Will do log replay and check the filesystem.
> > > +#
> > > +seq=3D`basename $0`
> > > +seqres=3D$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +
> > > +here=3D`pwd`
> > > +tmp=3D/tmp/$$
> > > +fio_config=3D$tmp.fio
> >
> > This isn't used anywhere.
> >
> > > +status=3D1       # failure is the default!
> > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > +
> > > +_cleanup()
> > > +{
> > > +       cd /
> > > +       $KILLALL_PROG -KILL -q $FSSTRESS_PROG &> /dev/null
> >
> > This line can go away, the test doesn't use fsstress.
> >
> > > +       _log_writes_cleanup &> /dev/null
> > > +       _dmthin_cleanup
> > > +       rm -f $tmp.*
> > > +}
> > > +
> > > +# get standard environment, filters and checks
> > > +. ./common/rc
> > > +. ./common/filter
> > > +. ./common/dmthin
> > > +. ./common/dmlogwrites
> > > +
> > > +# remove previous $seqres.full before test
> > > +rm -f $seqres.full
> > > +
> > > +# real QA test starts here
> > > +
> > > +# Modify as appropriate.
> > > +_supported_fs generic
> > > +_supported_os Linux
> > > +
> > > +# Use thin device as replay device, which requires $SCRATCH_DEV
> > > +_require_scratch_nocheck
> > > +# and we need extra device as log device
> > > +_require_log_writes
> > > +_require_dm_target thin-pool
> > > +
> > > +_require_fio
> >
> > All existing tests I could see, do "_require_fio $fio_config", where
> > $fio_config is not empty.
> >
>
> Yeah you can pass in a config or not, if you don't it just checks to make=
 sure
> you have fio available.  I originally intended to do a config, but just w=
ent
> with the commandline since it's easier to do the individual files and I'm=
 not
> using any esoteric fio options.
>
> <snip>
>
> >
> > Other than that it looks fine to me.
> >
> > However, on a VM with 8Gb of ram, I can't run the test:
> >
> > root 11:09:10 /home/fdmanana/git/hub/xfstests (master)> ./check btrfs/1=
94
> > FSTYP         -- btrfs
> > PLATFORM      -- Linux/x86_64 debian5 5.3.0-rc8-btrfs-next-58 #1 SMP
> > Tue Sep 17 18:18:55 WEST 2019
> > MKFS_OPTIONS  -- /dev/sdc
> > MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> >
> > btrfs/194 [failed, exit status 137]- output mismatch (see
> > /home/fdmanana/git/hub/xfstests/results//btrfs/194.out.bad)
> >     --- tests/btrfs/194.out 2019-10-02 10:51:45.485575789 +0100
> >     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/194.out.bad
> > 2019-10-02 11:12:11.382533722 +0100
> >     @@ -1,2 +1,2 @@
> >      QA output created by 194
> >     -Silence is golden
> >     +./check: line 513:  1324 Killed                  bash -c "test -w
> > ${OOM_SCORE_ADJ} && echo 250 > ${OOM_SCORE_ADJ}; exec ./$seq"
> >     ...
> >     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/194.out
> > /home/fdmanana/git/hub/xfstests/results//btrfs/194.out.bad'  to see
> > the entire diff)
> > Ran: btrfs/194
> > Failures: btrfs/194
> > Failed 1 of 1 tests
> >
> > root 11:12:22 /home/fdmanana/git/hub/xfstests (master)> cat
> > /home/fdmanana/git/hub/xfstests/results//btrfs/194.out.bad
> > QA output created by 194
> > ./check: line 513:  1324 Killed                  bash -c "test -w
> > ${OOM_SCORE_ADJ} && echo 250 > ${OOM_SCORE_ADJ}; exec ./$seq"
> > root 11:19:39 /home/fdmanana/git/hub/xfstests (master)>
> >
> >
> > 8Gb is a very reasonable amount of ram. This is on a debug kernel
> > (kmemleak, kasan, debug_pagealloc, etc, enabled). Not uncommon among
> > developers at least (even 4Gb of ram is common).
>
> Huh that's weird.  Do you know what step of the test OOM'ed?  Nothing we'=
re
> doing here should be using that much memory.  Thanks,

It OOMs when spawning the fio processes (btw, noticed now, the comment
mentions 100 process but the loop tries to spawn 50):

https://pastebin.com/hDhhNL60

>
> Josef



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
