Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F456217AF
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Nov 2022 16:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiKHPKJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Nov 2022 10:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiKHPKI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Nov 2022 10:10:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27B41C42C;
        Tue,  8 Nov 2022 07:10:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 419BE615BF;
        Tue,  8 Nov 2022 15:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24E6C433C1;
        Tue,  8 Nov 2022 15:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667920206;
        bh=hbtusXrszdCUuuezacOibYIIs30nwcEHriBVUlO1A/s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RXv7krII/9fXTbaCRwlOrb715LnFWUpDLFYBqVYEZoLWQGUYSgHdiUtxzWBKhZmTu
         4+XrsXAT02HQa1IitIoI5u1zrTV/L2G2BEbxSgxCshuI8cgLniYIU3fONTwxKMTXrl
         Xpuz58bhe64OpfXR69Kbuon1V3BVX0FSNJ+as1sNMDQBVg71qF29rlvxLf42W1a/45
         N47cimw6yzLcFhco5OfNxDoECbLMKE4T+4QPWlFHj8KBu8a8xh1M1RHgn5XcCNHqLr
         9zQPVL6Qgg2lnOxy8hGFi0ghvX+W/N12GHEZHRURoMORUKvIMxJIQNLOSX1e1SRCoj
         +94JN2JSXNNUQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-12c8312131fso16540518fac.4;
        Tue, 08 Nov 2022 07:10:06 -0800 (PST)
X-Gm-Message-State: ACrzQf2iKs9FlenuHkzReLNNCloyNrfE3svX0Uv+UHN5wLhrbzs9PZqS
        pfx6eXd5fgJHmX4l+ncJpErgviYVeZLfI6825Iw=
X-Google-Smtp-Source: AMsMyM67aBECXaqE9BhzHkP4MOS0oJvk03SPtP0DMbVV0M8aL0zbF+eHHgJSLb6M5ZgDoHUmpaHOxszXJWNkxxSmGBE=
X-Received: by 2002:a05:6870:2052:b0:132:7b2:2fe6 with SMTP id
 l18-20020a056870205200b0013207b22fe6mr33680030oad.98.1667920205742; Tue, 08
 Nov 2022 07:10:05 -0800 (PST)
MIME-Version: 1.0
References: <fbbab438744d69d4882dbe6a2125a32affa20cd9.1667813872.git.fdmanana@suse.com>
 <20221108144208.tbn5f7rxfsp3lzhq@zlang-mailbox> <CAL3q7H44wHBskEV8U13UzfD7upoVdh9iKP+njx5x=KtNwtS9mA@mail.gmail.com>
 <20221108150150.i46y32o2qn5euose@zlang-mailbox>
In-Reply-To: <20221108150150.i46y32o2qn5euose@zlang-mailbox>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 8 Nov 2022 15:09:29 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4FdG4Du9vFPOPeSupJgJMsnN9FemWnMpAJKfrhEq6dHw@mail.gmail.com>
Message-ID: <CAL3q7H4FdG4Du9vFPOPeSupJgJMsnN9FemWnMpAJKfrhEq6dHw@mail.gmail.com>
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

On Tue, Nov 8, 2022 at 3:02 PM Zorro Lang <zlang@redhat.com> wrote:
>
> On Tue, Nov 08, 2022 at 02:50:10PM +0000, Filipe Manana wrote:
> > On Tue, Nov 8, 2022 at 2:42 PM Zorro Lang <zlang@redhat.com> wrote:
> > >
> > > On Mon, Nov 07, 2022 at 09:38:58AM +0000, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > Test that direct IO writes with io_uring and O_DSYNC are durable if a power
> > > > failure happens after they complete.
> > > >
> > > > This is motivated by a regression on btrfs, affecting 5.15 stable kernels
> > > > and kernels up to 6.0, where often the writes were not persisted (same
> > > > behaviour as if O_DSYNC was not provided). This was recently fixed by the
> > > > following commit:
> > > >
> > > > 51bd9563b678 ("btrfs: fix deadlock due to page faults during direct IO reads and writes")
> > > >
> > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > ---
> > > >  tests/generic/703     | 104 ++++++++++++++++++++++++++++++++++++++++++
> > > >  tests/generic/703.out |   2 +
> > > >  2 files changed, 106 insertions(+)
> > > >  create mode 100755 tests/generic/703
> > > >  create mode 100644 tests/generic/703.out
> > > >
> > > > diff --git a/tests/generic/703 b/tests/generic/703
> > > > new file mode 100755
> > > > index 00000000..39ae3773
> > > > --- /dev/null
> > > > +++ b/tests/generic/703
> > > > @@ -0,0 +1,104 @@
> > > > +#! /bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> > > > +#
> > > > +# FS QA Test 703
> > > > +#
> > > > +# Test that direct IO writes with io_uring and O_DSYNC are durable if a power
> > > > +# failure happens after they complete.
> > > > +#
> > > > +. ./common/preamble
> > > > +_begin_fstest auto quick log prealloc io_uring
> > > > +
> > > > +_cleanup()
> > > > +{
> > > > +     _cleanup_flakey
> > > > +     cd /
> > > > +     rm -r -f $tmp.*
> > > > +}
> > > > +
> > > > +. ./common/filter
> > >
> > > This patch looks very good to me, it even doesn't miss any _require_* helpers
> > > or group names, and its comments are good enough. I can't pick up any problems
> > > from my side, just two tiny review points (as you will change the commit log
> > > at least, so might change them by the way:).
> > >
> > > 1) This case doesn't use any filter functions, so don't need "common/filter".
> >
> > Yes. That came from that template.
> > Certainly, it doesn't hurt anyone to have the file sourced.
> >
> > >
> > > > +. ./common/dmflakey
> > > > +
> > > > +fio_config=$tmp.fio
> > > > +fio_out=$tmp.fio.out
> > > > +test_file="${SCRATCH_MNT}/foo"
> > > > +
> > > > +[ $FSTYP == "btrfs" ] &&
> > > > +     _fixed_by_kernel_commit 8184620ae212 \
> > > > +     "btrfs: fix lost file sync on direct IO write with nowait and dsync iocb"
> > > > +
> > > > +_supported_fs generic
> > > > +# We allocate 256M of data for the test file, so require a higher size of 512M
> > > > +# which gives a margin of safety for a COW filesystem like btrfs (where metadata
> > > > +# is always COWed).
> > > > +_require_scratch_size $((512 * 1024))
> > >
> > > 2) I think nearly no one use a SCRATCH_DEV < 512M to run fstests, but I can't
> > > say this's wrong, so you can decide to keep or remove this line by yourself.
> >
> > Well, that I can't tell. For filesystems other than btrfs, it's
> > possible someone is interested in
> > testing very small devices, I don't know. Again, this doesn't hurt.
> >
> > > Both are good to me.
> > >
> > > With these:
> > > Reviewed-by: Zorro Lang <zlang@redhat.com>
> >
> > So, do you expect me to do something else?
> >
> > Surely the unnecessary import of common/filter, is something trivial
> > enough you could amend when you pick the patch?
> > That's the sort of thing Eryu and Dave did (unless there were really
> > important things to fix in a test). The changelog also
> > has a wrong commit as I previously noted.
> >
> > Please let me know if you expect something more from my side.
>
> No, just check with you before I change your patch a bit.

Ok, thanks!

>
> Thanks,
> Zorro
>
> >
> > Thanks.
> >
> > >
> > > > +_require_odirect
> > > > +_require_io_uring
> > > > +_require_dm_target flakey
> > > > +_require_xfs_io_command "falloc"
> > > > +
> > > > +cat >$fio_config <<EOF
> > > > +[test_io_uring_dio_dsync]
> > > > +ioengine=io_uring
> > > > +direct=1
> > > > +bs=64K
> > > > +sync=1
> > > > +filename=$test_file
> > > > +rw=randwrite
> > > > +time_based
> > > > +runtime=10
> > > > +EOF
> > > > +
> > > > +_require_fio $fio_config
> > > > +
> > > > +_scratch_mkfs >>$seqres.full 2>&1
> > > > +_require_metadata_journaling $SCRATCH_DEV
> > > > +_init_flakey
> > > > +_mount_flakey
> > > > +
> > > > +# We do 64K writes in the fio job.
> > > > +_require_congruent_file_oplen $SCRATCH_MNT $((64 * 1024))
> > > > +
> > > > +touch $test_file
> > > > +
> > > > +# On btrfs IOCB_NOWAIT writes can only be done on NOCOW files, so enable
> > > > +# nodatacow on the file if we are running on btrfs.
> > > > +if [ $FSTYP == "btrfs" ]; then
> > > > +     _require_chattr C
> > > > +     $CHATTR_PROG +C $test_file
> > > > +fi
> > > > +
> > > > +$XFS_IO_PROG -c "falloc 0 256M" $test_file
> > > > +
> > > > +# Persist everything, make sure the file exists after power failure.
> > > > +sync
> > > > +
> > > > +echo -e "Running fio with config:\n" >> $seqres.full
> > > > +cat $fio_config >> $seqres.full
> > > > +
> > > > +$FIO_PROG $fio_config --output=$fio_out
> > > > +
> > > > +echo -e "\nOutput from fio:\n" >> $seqres.full
> > > > +cat $fio_out >> $seqres.full
> > > > +
> > > > +digest_before=$(_md5_checksum $test_file)
> > > > +
> > > > +# Simulate a power failure and mount the filesystem to check that all the data
> > > > +# previously written are available.
> > > > +_flakey_drop_and_remount
> > > > +
> > > > +digest_after=$(_md5_checksum $test_file)
> > > > +
> > > > +if [ "$digest_after" != "$digest_before" ]; then
> > > > +     echo "Error: not all file data got persisted."
> > > > +     echo "Digest before power failure: $digest_before"
> > > > +     echo "Digest after power failure:  $digest_after"
> > > > +fi
> > > > +
> > > > +_unmount_flakey
> > > > +
> > > > +# success, all done
> > > > +echo "Silence is golden"
> > > > +status=0
> > > > +exit
> > > > diff --git a/tests/generic/703.out b/tests/generic/703.out
> > > > new file mode 100644
> > > > index 00000000..fba62571
> > > > --- /dev/null
> > > > +++ b/tests/generic/703.out
> > > > @@ -0,0 +1,2 @@
> > > > +QA output created by 703
> > > > +Silence is golden
> > > > --
> > > > 2.35.1
> > > >
> > >
> >
>
