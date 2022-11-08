Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E291621758
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Nov 2022 15:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbiKHOuv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Nov 2022 09:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbiKHOut (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Nov 2022 09:50:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FCEE88;
        Tue,  8 Nov 2022 06:50:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 533A5615B2;
        Tue,  8 Nov 2022 14:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF800C433C1;
        Tue,  8 Nov 2022 14:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667919047;
        bh=5CBlUD1DKwV/sKTsYRL7czanbSbf7pbAYG6dkHNiqOU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dOAmLlpj0KT2crNLKmomPY0nLmTaEZ0hIyvAbxHoOkvjpKSrq9/0w5gK1swO3s4fA
         2RIabJucdHGrweM52lFHksCWrCSs44nkPPkbjkKGrFB9+8JIYhrwodU5O3Xw0GUoG1
         ey34iLBi9sD0pFGcw/5xCxAfJNximuzuVGSHVzhV7lH0SKpmZx3W9L2uS8WKKdQFdH
         TS0CstTg+1JdZdoO8AUusgyh2rHLbwFDCX6132T2MBTo9Lwc5riIYUUZWZtMfsAK9E
         EZV/Li/ZGH7pxWuljg37zNwsdK/PI+9QqHW1R6Dl2g08YOXQcosO387PeMqF5F8uQ1
         XwixeUEoobQdg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-13bd2aea61bso16533931fac.0;
        Tue, 08 Nov 2022 06:50:47 -0800 (PST)
X-Gm-Message-State: ACrzQf3mh+Hv19/2svnzhtATLVCzxyDVGLE5qk5i6ogi5oLe/NCnBlEZ
        kNLqcKshnTbNhMLkz5TEeP/3s1o/79rWfKrr0HU=
X-Google-Smtp-Source: AMsMyM4Fa4/tCvsleee+/VTKquNYzKLJgz2gTb3V8hc7kYLs34X25oLfTwWfLxKZhCjCB8/0nC+ZT9chpen9TlXe1TM=
X-Received: by 2002:a05:6870:2052:b0:132:7b2:2fe6 with SMTP id
 l18-20020a056870205200b0013207b22fe6mr33623674oad.98.1667919046735; Tue, 08
 Nov 2022 06:50:46 -0800 (PST)
MIME-Version: 1.0
References: <fbbab438744d69d4882dbe6a2125a32affa20cd9.1667813872.git.fdmanana@suse.com>
 <20221108144208.tbn5f7rxfsp3lzhq@zlang-mailbox>
In-Reply-To: <20221108144208.tbn5f7rxfsp3lzhq@zlang-mailbox>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 8 Nov 2022 14:50:10 +0000
X-Gmail-Original-Message-ID: <CAL3q7H44wHBskEV8U13UzfD7upoVdh9iKP+njx5x=KtNwtS9mA@mail.gmail.com>
Message-ID: <CAL3q7H44wHBskEV8U13UzfD7upoVdh9iKP+njx5x=KtNwtS9mA@mail.gmail.com>
Subject: Re: [PATCH] generic: check direct IO writes with io_uring and O_DSYNC
 are durable
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 8, 2022 at 2:42 PM Zorro Lang <zlang@redhat.com> wrote:
>
> On Mon, Nov 07, 2022 at 09:38:58AM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that direct IO writes with io_uring and O_DSYNC are durable if a power
> > failure happens after they complete.
> >
> > This is motivated by a regression on btrfs, affecting 5.15 stable kernels
> > and kernels up to 6.0, where often the writes were not persisted (same
> > behaviour as if O_DSYNC was not provided). This was recently fixed by the
> > following commit:
> >
> > 51bd9563b678 ("btrfs: fix deadlock due to page faults during direct IO reads and writes")
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  tests/generic/703     | 104 ++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/703.out |   2 +
> >  2 files changed, 106 insertions(+)
> >  create mode 100755 tests/generic/703
> >  create mode 100644 tests/generic/703.out
> >
> > diff --git a/tests/generic/703 b/tests/generic/703
> > new file mode 100755
> > index 00000000..39ae3773
> > --- /dev/null
> > +++ b/tests/generic/703
> > @@ -0,0 +1,104 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test 703
> > +#
> > +# Test that direct IO writes with io_uring and O_DSYNC are durable if a power
> > +# failure happens after they complete.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick log prealloc io_uring
> > +
> > +_cleanup()
> > +{
> > +     _cleanup_flakey
> > +     cd /
> > +     rm -r -f $tmp.*
> > +}
> > +
> > +. ./common/filter
>
> This patch looks very good to me, it even doesn't miss any _require_* helpers
> or group names, and its comments are good enough. I can't pick up any problems
> from my side, just two tiny review points (as you will change the commit log
> at least, so might change them by the way:).
>
> 1) This case doesn't use any filter functions, so don't need "common/filter".

Yes. That came from that template.
Certainly, it doesn't hurt anyone to have the file sourced.

>
> > +. ./common/dmflakey
> > +
> > +fio_config=$tmp.fio
> > +fio_out=$tmp.fio.out
> > +test_file="${SCRATCH_MNT}/foo"
> > +
> > +[ $FSTYP == "btrfs" ] &&
> > +     _fixed_by_kernel_commit 8184620ae212 \
> > +     "btrfs: fix lost file sync on direct IO write with nowait and dsync iocb"
> > +
> > +_supported_fs generic
> > +# We allocate 256M of data for the test file, so require a higher size of 512M
> > +# which gives a margin of safety for a COW filesystem like btrfs (where metadata
> > +# is always COWed).
> > +_require_scratch_size $((512 * 1024))
>
> 2) I think nearly no one use a SCRATCH_DEV < 512M to run fstests, but I can't
> say this's wrong, so you can decide to keep or remove this line by yourself.

Well, that I can't tell. For filesystems other than btrfs, it's
possible someone is interested in
testing very small devices, I don't know. Again, this doesn't hurt.

> Both are good to me.
>
> With these:
> Reviewed-by: Zorro Lang <zlang@redhat.com>

So, do you expect me to do something else?

Surely the unnecessary import of common/filter, is something trivial
enough you could amend when you pick the patch?
That's the sort of thing Eryu and Dave did (unless there were really
important things to fix in a test). The changelog also
has a wrong commit as I previously noted.

Please let me know if you expect something more from my side.

Thanks.

>
> > +_require_odirect
> > +_require_io_uring
> > +_require_dm_target flakey
> > +_require_xfs_io_command "falloc"
> > +
> > +cat >$fio_config <<EOF
> > +[test_io_uring_dio_dsync]
> > +ioengine=io_uring
> > +direct=1
> > +bs=64K
> > +sync=1
> > +filename=$test_file
> > +rw=randwrite
> > +time_based
> > +runtime=10
> > +EOF
> > +
> > +_require_fio $fio_config
> > +
> > +_scratch_mkfs >>$seqres.full 2>&1
> > +_require_metadata_journaling $SCRATCH_DEV
> > +_init_flakey
> > +_mount_flakey
> > +
> > +# We do 64K writes in the fio job.
> > +_require_congruent_file_oplen $SCRATCH_MNT $((64 * 1024))
> > +
> > +touch $test_file
> > +
> > +# On btrfs IOCB_NOWAIT writes can only be done on NOCOW files, so enable
> > +# nodatacow on the file if we are running on btrfs.
> > +if [ $FSTYP == "btrfs" ]; then
> > +     _require_chattr C
> > +     $CHATTR_PROG +C $test_file
> > +fi
> > +
> > +$XFS_IO_PROG -c "falloc 0 256M" $test_file
> > +
> > +# Persist everything, make sure the file exists after power failure.
> > +sync
> > +
> > +echo -e "Running fio with config:\n" >> $seqres.full
> > +cat $fio_config >> $seqres.full
> > +
> > +$FIO_PROG $fio_config --output=$fio_out
> > +
> > +echo -e "\nOutput from fio:\n" >> $seqres.full
> > +cat $fio_out >> $seqres.full
> > +
> > +digest_before=$(_md5_checksum $test_file)
> > +
> > +# Simulate a power failure and mount the filesystem to check that all the data
> > +# previously written are available.
> > +_flakey_drop_and_remount
> > +
> > +digest_after=$(_md5_checksum $test_file)
> > +
> > +if [ "$digest_after" != "$digest_before" ]; then
> > +     echo "Error: not all file data got persisted."
> > +     echo "Digest before power failure: $digest_before"
> > +     echo "Digest after power failure:  $digest_after"
> > +fi
> > +
> > +_unmount_flakey
> > +
> > +# success, all done
> > +echo "Silence is golden"
> > +status=0
> > +exit
> > diff --git a/tests/generic/703.out b/tests/generic/703.out
> > new file mode 100644
> > index 00000000..fba62571
> > --- /dev/null
> > +++ b/tests/generic/703.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 703
> > +Silence is golden
> > --
> > 2.35.1
> >
>
