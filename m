Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2662F62179F
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Nov 2022 16:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiKHPCz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Nov 2022 10:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbiKHPCx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Nov 2022 10:02:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571D24E433
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Nov 2022 07:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667919720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KQOqssMMEyAlhJ6N5rum0bqBveIGK3+xbl4xUYEdMKo=;
        b=EEol5koxOgyyZs3Qrl9bU4e2JYinic895yHuNfpPkY5E47Diij4f5tAGl20b+yFyktJSto
        3S15UomnwLpg2maMxQZcTirPYr9OWmf0K/Ned55aVVUepsDZ2QhxalCuYVyf0QhIFWIb6W
        fzjpTNY3cN/I881448sDoLaxQmmHznc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-622-X4m09b8BN_6FKyCcJBEGcg-1; Tue, 08 Nov 2022 10:01:57 -0500
X-MC-Unique: X4m09b8BN_6FKyCcJBEGcg-1
Received: by mail-qt1-f199.google.com with SMTP id n12-20020ac85a0c000000b003a5849497f9so4675970qta.20
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Nov 2022 07:01:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQOqssMMEyAlhJ6N5rum0bqBveIGK3+xbl4xUYEdMKo=;
        b=lsQ1p87uNPeQTi3ICV+MEPsfjkRvN1hW5SMAkXfN/A1GU8NOau0W8qIeC5gcG/v34L
         87DrStQvl0M+gLHmXI6x+ZwZ+6+8WeDQsb6mS8Cs0Ur5Q7LDy8b1Q+AeFLhpM/PsQ5y8
         jnOh5Ace45twy8lg+j/St8qUVrMPWCkbPO8YFttEg/6C27/1iMeIesfsem/cGVwXiuaf
         vHzOuQ8xqAhDR6SPbhGXJoZpZDxqhzA1DtOaJfLpZ4EjISsZD7RdPoL3M1bXZaWOWUfg
         xDPtYawYvat2N4yDHhSpgbfFwhAIutkK/yPRNooRDBS7+z4vine+1HtamVqRNcw774Jw
         8t1g==
X-Gm-Message-State: ACrzQf1h8/izdh/vJkXY3/OlZjh57oLUtR6MVMtQQIHQ3faOvVoXlwjk
        zwHLTiJ8wxoaKbIOcHg9dLvDdBVr7AsrNpJ4ZxmmaPFsWS4P8JwDzsWHqZguPqNaEDk7SS2MtK5
        T580yB3gObtxmZT2eJRc1360=
X-Received: by 2002:ac8:7216:0:b0:3a5:3cb0:958 with SMTP id a22-20020ac87216000000b003a53cb00958mr30133865qtp.113.1667919716752;
        Tue, 08 Nov 2022 07:01:56 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6ZhbCYf7RO9d5ufUczdf6GrwInMrtnYiz5zNndn0CsJGhvSz0GXoTnqX9+eIJoX6eoTJ0Hfg==
X-Received: by 2002:ac8:7216:0:b0:3a5:3cb0:958 with SMTP id a22-20020ac87216000000b003a53cb00958mr30133830qtp.113.1667919716449;
        Tue, 08 Nov 2022 07:01:56 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ge17-20020a05622a5c9100b0039cc64bcb53sm8295203qtb.27.2022.11.08.07.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 07:01:55 -0800 (PST)
Date:   Tue, 8 Nov 2022 23:01:50 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: check direct IO writes with io_uring and
 O_DSYNC are durable
Message-ID: <20221108150150.i46y32o2qn5euose@zlang-mailbox>
References: <fbbab438744d69d4882dbe6a2125a32affa20cd9.1667813872.git.fdmanana@suse.com>
 <20221108144208.tbn5f7rxfsp3lzhq@zlang-mailbox>
 <CAL3q7H44wHBskEV8U13UzfD7upoVdh9iKP+njx5x=KtNwtS9mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H44wHBskEV8U13UzfD7upoVdh9iKP+njx5x=KtNwtS9mA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 08, 2022 at 02:50:10PM +0000, Filipe Manana wrote:
> On Tue, Nov 8, 2022 at 2:42 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Mon, Nov 07, 2022 at 09:38:58AM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Test that direct IO writes with io_uring and O_DSYNC are durable if a power
> > > failure happens after they complete.
> > >
> > > This is motivated by a regression on btrfs, affecting 5.15 stable kernels
> > > and kernels up to 6.0, where often the writes were not persisted (same
> > > behaviour as if O_DSYNC was not provided). This was recently fixed by the
> > > following commit:
> > >
> > > 51bd9563b678 ("btrfs: fix deadlock due to page faults during direct IO reads and writes")
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  tests/generic/703     | 104 ++++++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/703.out |   2 +
> > >  2 files changed, 106 insertions(+)
> > >  create mode 100755 tests/generic/703
> > >  create mode 100644 tests/generic/703.out
> > >
> > > diff --git a/tests/generic/703 b/tests/generic/703
> > > new file mode 100755
> > > index 00000000..39ae3773
> > > --- /dev/null
> > > +++ b/tests/generic/703
> > > @@ -0,0 +1,104 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> > > +#
> > > +# FS QA Test 703
> > > +#
> > > +# Test that direct IO writes with io_uring and O_DSYNC are durable if a power
> > > +# failure happens after they complete.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick log prealloc io_uring
> > > +
> > > +_cleanup()
> > > +{
> > > +     _cleanup_flakey
> > > +     cd /
> > > +     rm -r -f $tmp.*
> > > +}
> > > +
> > > +. ./common/filter
> >
> > This patch looks very good to me, it even doesn't miss any _require_* helpers
> > or group names, and its comments are good enough. I can't pick up any problems
> > from my side, just two tiny review points (as you will change the commit log
> > at least, so might change them by the way:).
> >
> > 1) This case doesn't use any filter functions, so don't need "common/filter".
> 
> Yes. That came from that template.
> Certainly, it doesn't hurt anyone to have the file sourced.
> 
> >
> > > +. ./common/dmflakey
> > > +
> > > +fio_config=$tmp.fio
> > > +fio_out=$tmp.fio.out
> > > +test_file="${SCRATCH_MNT}/foo"
> > > +
> > > +[ $FSTYP == "btrfs" ] &&
> > > +     _fixed_by_kernel_commit 8184620ae212 \
> > > +     "btrfs: fix lost file sync on direct IO write with nowait and dsync iocb"
> > > +
> > > +_supported_fs generic
> > > +# We allocate 256M of data for the test file, so require a higher size of 512M
> > > +# which gives a margin of safety for a COW filesystem like btrfs (where metadata
> > > +# is always COWed).
> > > +_require_scratch_size $((512 * 1024))
> >
> > 2) I think nearly no one use a SCRATCH_DEV < 512M to run fstests, but I can't
> > say this's wrong, so you can decide to keep or remove this line by yourself.
> 
> Well, that I can't tell. For filesystems other than btrfs, it's
> possible someone is interested in
> testing very small devices, I don't know. Again, this doesn't hurt.
> 
> > Both are good to me.
> >
> > With these:
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> So, do you expect me to do something else?
> 
> Surely the unnecessary import of common/filter, is something trivial
> enough you could amend when you pick the patch?
> That's the sort of thing Eryu and Dave did (unless there were really
> important things to fix in a test). The changelog also
> has a wrong commit as I previously noted.
> 
> Please let me know if you expect something more from my side.

No, just check with you before I change your patch a bit.

Thanks,
Zorro

> 
> Thanks.
> 
> >
> > > +_require_odirect
> > > +_require_io_uring
> > > +_require_dm_target flakey
> > > +_require_xfs_io_command "falloc"
> > > +
> > > +cat >$fio_config <<EOF
> > > +[test_io_uring_dio_dsync]
> > > +ioengine=io_uring
> > > +direct=1
> > > +bs=64K
> > > +sync=1
> > > +filename=$test_file
> > > +rw=randwrite
> > > +time_based
> > > +runtime=10
> > > +EOF
> > > +
> > > +_require_fio $fio_config
> > > +
> > > +_scratch_mkfs >>$seqres.full 2>&1
> > > +_require_metadata_journaling $SCRATCH_DEV
> > > +_init_flakey
> > > +_mount_flakey
> > > +
> > > +# We do 64K writes in the fio job.
> > > +_require_congruent_file_oplen $SCRATCH_MNT $((64 * 1024))
> > > +
> > > +touch $test_file
> > > +
> > > +# On btrfs IOCB_NOWAIT writes can only be done on NOCOW files, so enable
> > > +# nodatacow on the file if we are running on btrfs.
> > > +if [ $FSTYP == "btrfs" ]; then
> > > +     _require_chattr C
> > > +     $CHATTR_PROG +C $test_file
> > > +fi
> > > +
> > > +$XFS_IO_PROG -c "falloc 0 256M" $test_file
> > > +
> > > +# Persist everything, make sure the file exists after power failure.
> > > +sync
> > > +
> > > +echo -e "Running fio with config:\n" >> $seqres.full
> > > +cat $fio_config >> $seqres.full
> > > +
> > > +$FIO_PROG $fio_config --output=$fio_out
> > > +
> > > +echo -e "\nOutput from fio:\n" >> $seqres.full
> > > +cat $fio_out >> $seqres.full
> > > +
> > > +digest_before=$(_md5_checksum $test_file)
> > > +
> > > +# Simulate a power failure and mount the filesystem to check that all the data
> > > +# previously written are available.
> > > +_flakey_drop_and_remount
> > > +
> > > +digest_after=$(_md5_checksum $test_file)
> > > +
> > > +if [ "$digest_after" != "$digest_before" ]; then
> > > +     echo "Error: not all file data got persisted."
> > > +     echo "Digest before power failure: $digest_before"
> > > +     echo "Digest after power failure:  $digest_after"
> > > +fi
> > > +
> > > +_unmount_flakey
> > > +
> > > +# success, all done
> > > +echo "Silence is golden"
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/703.out b/tests/generic/703.out
> > > new file mode 100644
> > > index 00000000..fba62571
> > > --- /dev/null
> > > +++ b/tests/generic/703.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 703
> > > +Silence is golden
> > > --
> > > 2.35.1
> > >
> >
> 

