Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0140C61EF77
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 10:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiKGJqO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 04:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiKGJqL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 04:46:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC7518375;
        Mon,  7 Nov 2022 01:46:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4401A60FA2;
        Mon,  7 Nov 2022 09:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8EDC43142;
        Mon,  7 Nov 2022 09:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667814368;
        bh=wFvcsLMFbhzjBuDFLZXeBaOLJuL2mPqVmFxuTKWPh+M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZkqZA5NRPmUxPNxr9e2s8B8xHMIY9fe6l61zZoUofLTneZhcYieimM4yE5cp4ikQP
         airFjLIFbxXhBRM4qRZadSZ/Q6ki3CNcfwtweIQOJ+e78XT0bhVXrsncEuK0CHi3XZ
         wV2ScnoK+q62um2WB2+2iq/CQSZ8Qspn8fS0KWyxp07GfdGLGdT3aith3aCywlbnPq
         GUuBvSDrBnpqvMKxPgDF1WaB8Hf8HYo5oALCMDXajY/R6w9ooofdkbc4xS9M6jPT4P
         BoIoG5WBcBVv4m5NdkrD5qrI7vz1WTXT2j7kWvpAC61qgChrzXhNKYt9qBEZlSLxPa
         YUPsajAqQinrw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-13ae8117023so12020552fac.9;
        Mon, 07 Nov 2022 01:46:08 -0800 (PST)
X-Gm-Message-State: ACrzQf272UeBnYh8aLRC4+yurGLG+40FvQmNzgJzBYpxtLtmT4cqnQP4
        6KLvsTQryx4aANZNGVQ2zbd5/7+9L5JiRR4iJoc=
X-Google-Smtp-Source: AMsMyM77akpsaW5PlYw7dmyRvnDxpBHl9EO1ad5w+3EPEF3yMakUzFJWCtcPURl2TLpKia0b+TpzqdWu3uFR+GEArtM=
X-Received: by 2002:a05:6870:2052:b0:132:7b2:2fe6 with SMTP id
 l18-20020a056870205200b0013207b22fe6mr29541489oad.98.1667814367860; Mon, 07
 Nov 2022 01:46:07 -0800 (PST)
MIME-Version: 1.0
References: <fbbab438744d69d4882dbe6a2125a32affa20cd9.1667813872.git.fdmanana@suse.com>
In-Reply-To: <fbbab438744d69d4882dbe6a2125a32affa20cd9.1667813872.git.fdmanana@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 7 Nov 2022 09:45:31 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7UqVJtYpG51q7QnEL8g3kZBB_ELyx9xCU5=2KLvS29zg@mail.gmail.com>
Message-ID: <CAL3q7H7UqVJtYpG51q7QnEL8g3kZBB_ELyx9xCU5=2KLvS29zg@mail.gmail.com>
Subject: Re: [PATCH] generic: check direct IO writes with io_uring and O_DSYNC
 are durable
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 7, 2022 at 9:44 AM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> Test that direct IO writes with io_uring and O_DSYNC are durable if a power
> failure happens after they complete.
>
> This is motivated by a regression on btrfs, affecting 5.15 stable kernels
> and kernels up to 6.0, where often the writes were not persisted (same
> behaviour as if O_DSYNC was not provided). This was recently fixed by the
> following commit:
>
> 51bd9563b678 ("btrfs: fix deadlock due to page faults during direct IO reads and writes")

Wrong copy-paste, this was meant to be:

8184620ae212 ("btrfs: fix lost file sync on direct IO write with
nowait and dsync iocb")

Thanks.


>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/generic/703     | 104 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/703.out |   2 +
>  2 files changed, 106 insertions(+)
>  create mode 100755 tests/generic/703
>  create mode 100644 tests/generic/703.out
>
> diff --git a/tests/generic/703 b/tests/generic/703
> new file mode 100755
> index 00000000..39ae3773
> --- /dev/null
> +++ b/tests/generic/703
> @@ -0,0 +1,104 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 703
> +#
> +# Test that direct IO writes with io_uring and O_DSYNC are durable if a power
> +# failure happens after they complete.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick log prealloc io_uring
> +
> +_cleanup()
> +{
> +       _cleanup_flakey
> +       cd /
> +       rm -r -f $tmp.*
> +}
> +
> +. ./common/filter
> +. ./common/dmflakey
> +
> +fio_config=$tmp.fio
> +fio_out=$tmp.fio.out
> +test_file="${SCRATCH_MNT}/foo"
> +
> +[ $FSTYP == "btrfs" ] &&
> +       _fixed_by_kernel_commit 8184620ae212 \
> +       "btrfs: fix lost file sync on direct IO write with nowait and dsync iocb"
> +
> +_supported_fs generic
> +# We allocate 256M of data for the test file, so require a higher size of 512M
> +# which gives a margin of safety for a COW filesystem like btrfs (where metadata
> +# is always COWed).
> +_require_scratch_size $((512 * 1024))
> +_require_odirect
> +_require_io_uring
> +_require_dm_target flakey
> +_require_xfs_io_command "falloc"
> +
> +cat >$fio_config <<EOF
> +[test_io_uring_dio_dsync]
> +ioengine=io_uring
> +direct=1
> +bs=64K
> +sync=1
> +filename=$test_file
> +rw=randwrite
> +time_based
> +runtime=10
> +EOF
> +
> +_require_fio $fio_config
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_mount_flakey
> +
> +# We do 64K writes in the fio job.
> +_require_congruent_file_oplen $SCRATCH_MNT $((64 * 1024))
> +
> +touch $test_file
> +
> +# On btrfs IOCB_NOWAIT writes can only be done on NOCOW files, so enable
> +# nodatacow on the file if we are running on btrfs.
> +if [ $FSTYP == "btrfs" ]; then
> +       _require_chattr C
> +       $CHATTR_PROG +C $test_file
> +fi
> +
> +$XFS_IO_PROG -c "falloc 0 256M" $test_file
> +
> +# Persist everything, make sure the file exists after power failure.
> +sync
> +
> +echo -e "Running fio with config:\n" >> $seqres.full
> +cat $fio_config >> $seqres.full
> +
> +$FIO_PROG $fio_config --output=$fio_out
> +
> +echo -e "\nOutput from fio:\n" >> $seqres.full
> +cat $fio_out >> $seqres.full
> +
> +digest_before=$(_md5_checksum $test_file)
> +
> +# Simulate a power failure and mount the filesystem to check that all the data
> +# previously written are available.
> +_flakey_drop_and_remount
> +
> +digest_after=$(_md5_checksum $test_file)
> +
> +if [ "$digest_after" != "$digest_before" ]; then
> +       echo "Error: not all file data got persisted."
> +       echo "Digest before power failure: $digest_before"
> +       echo "Digest after power failure:  $digest_after"
> +fi
> +
> +_unmount_flakey
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/703.out b/tests/generic/703.out
> new file mode 100644
> index 00000000..fba62571
> --- /dev/null
> +++ b/tests/generic/703.out
> @@ -0,0 +1,2 @@
> +QA output created by 703
> +Silence is golden
> --
> 2.35.1
>
