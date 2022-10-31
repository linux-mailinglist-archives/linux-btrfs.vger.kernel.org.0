Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7C1613BBB
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 17:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiJaQvt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 12:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiJaQvs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 12:51:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC03812AA1;
        Mon, 31 Oct 2022 09:51:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2E847CE1780;
        Mon, 31 Oct 2022 16:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF03C433C1;
        Mon, 31 Oct 2022 16:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667235103;
        bh=3GEdvBk0AoTISmvBtsLWqOKKssIPgPm/pU5xepT7ZeE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tEIt+zfwr54ZvCtUp+R5u6joftlqteuf9ZQACdJ8CqXJOjHWc6lkOQ0TSkOtjUeW0
         0AwUenSzhcAIEnLERXgZWNy4JoYBmUmmOkJ71kKva+ihNzZPtQ25PnEgkFiEVYkbho
         JeFWjLIkMe2YrdghzeGXHxGu0fXgiE8myj8J+JgT4qyp9E05He9e2uUeZss5kKHr26
         uXK5eNy/MftmNfq8nu5dDsLPnVo1zxcXTaV7ABzA16lmvFbPgnYOGX37Uh1ZqGA+9P
         BbHmP/YxEZoLHQbezWmA9TDBseo/xurGMYRYnQah93RR6Shxra/qVkrqpRPrL/VYv8
         J5DjU11tRCG0Q==
Received: by mail-oi1-f170.google.com with SMTP id t62so2549517oib.12;
        Mon, 31 Oct 2022 09:51:43 -0700 (PDT)
X-Gm-Message-State: ACrzQf2xNT3S3JBjZ1Ko7dx2/LgUywglvbwuSiuYu8NuyWKZ0F//CltH
        gII3XA5jqZ1T/iE/YuvJp80YJRbCKs+MEJbP1zc=
X-Google-Smtp-Source: AMsMyM6WRUAxw2qoJdmm0838ghelsApnnBSIHtnzpcNRGT+QgQ5w/y2y+flJHl83DdEOQg1XHHPVBxHQfEF1HpWeB2w=
X-Received: by 2002:a05:6808:1691:b0:351:48da:62e0 with SMTP id
 bb17-20020a056808169100b0035148da62e0mr7246893oib.98.1667235102475; Mon, 31
 Oct 2022 09:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1667214081.git.fdmanana@suse.com> <27a0c4ab551b7a7410f4062f5235f20c88e77cfc.1667214081.git.fdmanana@suse.com>
 <20221031164128.z4cujrkrcxe6ujqr@zlang-mailbox>
In-Reply-To: <20221031164128.z4cujrkrcxe6ujqr@zlang-mailbox>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 31 Oct 2022 16:51:06 +0000
X-Gmail-Original-Message-ID: <CAL3q7H73zCMQgJ9VTneZ7rX9Z8qVTFojsuEVU5OhZw37StU_Ww@mail.gmail.com>
Message-ID: <CAL3q7H73zCMQgJ9VTneZ7rX9Z8qVTFojsuEVU5OhZw37StU_Ww@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: test that fiemap reports extent as not shared
 after deleting file
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 31, 2022 at 4:41 PM Zorro Lang <zlang@redhat.com> wrote:
>
> On Mon, Oct 31, 2022 at 11:11:20AM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that if we have two files with shared extents, after removing one of
> > the files, if we do a fiemap against the other file, it does not report
> > extents as shared anymore.
> >
> > This exercises the processing of delayed references for data extents in
> > the backref walking code, used by fiemap to determine if an extent is
> > shared.
> >
> > This used to fail until very recently and was fixed by the following
> > kernel commit that landed in 6.1-rc2:
> >
> >   4fc7b5722824 (""btrfs: fix processing of delayed data refs during backref walking")
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
>
> Looks good to me. As this's not a genericcase, I'm not sure if you need
> _require_congruent_file_oplen helper.

Hum? Why would it be needed?
That helper was introduced because of xfs's realtime config.
On btrfs reflinking always works for any multiple of the sector size.

>
> Thanks,
> Zorro
>
> >  tests/btrfs/279     | 82 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/279.out | 39 +++++++++++++++++++++
> >  2 files changed, 121 insertions(+)
> >  create mode 100755 tests/btrfs/279
> >  create mode 100644 tests/btrfs/279.out
> >
> > diff --git a/tests/btrfs/279 b/tests/btrfs/279
> > new file mode 100755
> > index 00000000..5b5824fd
> > --- /dev/null
> > +++ b/tests/btrfs/279
> > @@ -0,0 +1,82 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test 279
> > +#
> > +# Test that if we have two files with shared extents, after removing one of the
> > +# files, if we do a fiemap against the other file, it does not report extents as
> > +# shared anymore.
> > +#
> > +# This exercises the processing of delayed references for data extents in the
> > +# backref walking code, used by fiemap to determine if an extent is shared.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick subvol fiemap clone
> > +
> > +. ./common/filter
> > +. ./common/reflink
> > +. ./common/punch # for _filter_fiemap_flags
> > +
> > +_supported_fs btrfs
> > +_require_scratch_reflink
> > +_require_cp_reflink
> > +_require_xfs_io_command "fiemap"
> > +
> > +_fixed_by_kernel_commit 4fc7b5722824 \
> > +     "btrfs: fix processing of delayed data refs during backref walking"
> > +
> > +run_test()
> > +{
> > +     local file_path_1=$1
> > +     local file_path_2=$2
> > +     local do_sync=$3
> > +
> > +     $XFS_IO_PROG -f -c "pwrite 0 64K" $file_path_1 | _filter_xfs_io
> > +     _cp_reflink $file_path_1 $file_path_2
> > +
> > +     if [ $do_sync -eq 1 ]; then
> > +             sync
> > +     fi
> > +
> > +     echo "Fiemap of $file_path_1 before deleting $file_path_2:" | \
> > +             _filter_scratch
> > +     $XFS_IO_PROG -c "fiemap -v" $file_path_1 | _filter_fiemap_flags
> > +
> > +     rm -f $file_path_2
> > +
> > +     echo "Fiemap of $file_path_1 after deleting $file_path_2:" | \
> > +             _filter_scratch
> > +     $XFS_IO_PROG -c "fiemap -v" $file_path_1 | _filter_fiemap_flags
> > +}
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1
> > +_scratch_mount
> > +
> > +# Create two test subvolumes, we'll reflink files between them.
> > +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subv1 | _filter_scratch
> > +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subv2 | _filter_scratch
> > +
> > +echo
> > +echo "Testing with same subvolume and without transaction commit"
> > +echo
> > +run_test "$SCRATCH_MNT/subv1/f1" "$SCRATCH_MNT/subv1/f2" 0
> > +
> > +echo
> > +echo "Testing with same subvolume and with transaction commit"
> > +echo
> > +run_test "$SCRATCH_MNT/subv1/f3" "$SCRATCH_MNT/subv1/f4" 1
> > +
> > +echo
> > +echo "Testing with different subvolumes and without transaction commit"
> > +echo
> > +run_test "$SCRATCH_MNT/subv1/f5" "$SCRATCH_MNT/subv2/f6" 0
> > +
> > +echo
> > +echo "Testing with different subvolumes and with transaction commit"
> > +echo
> > +run_test "$SCRATCH_MNT/subv1/f7" "$SCRATCH_MNT/subv2/f8" 1
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/279.out b/tests/btrfs/279.out
> > new file mode 100644
> > index 00000000..a959a86d
> > --- /dev/null
> > +++ b/tests/btrfs/279.out
> > @@ -0,0 +1,39 @@
> > +QA output created by 279
> > +Create subvolume 'SCRATCH_MNT/subv1'
> > +Create subvolume 'SCRATCH_MNT/subv2'
> > +
> > +Testing with same subvolume and without transaction commit
> > +
> > +wrote 65536/65536 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +Fiemap of SCRATCH_MNT/subv1/f1 before deleting SCRATCH_MNT/subv1/f2:
> > +0: [0..127]: shared|last
> > +Fiemap of SCRATCH_MNT/subv1/f1 after deleting SCRATCH_MNT/subv1/f2:
> > +0: [0..127]: last
> > +
> > +Testing with same subvolume and with transaction commit
> > +
> > +wrote 65536/65536 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +Fiemap of SCRATCH_MNT/subv1/f3 before deleting SCRATCH_MNT/subv1/f4:
> > +0: [0..127]: shared|last
> > +Fiemap of SCRATCH_MNT/subv1/f3 after deleting SCRATCH_MNT/subv1/f4:
> > +0: [0..127]: last
> > +
> > +Testing with different subvolumes and without transaction commit
> > +
> > +wrote 65536/65536 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +Fiemap of SCRATCH_MNT/subv1/f5 before deleting SCRATCH_MNT/subv2/f6:
> > +0: [0..127]: shared|last
> > +Fiemap of SCRATCH_MNT/subv1/f5 after deleting SCRATCH_MNT/subv2/f6:
> > +0: [0..127]: last
> > +
> > +Testing with different subvolumes and with transaction commit
> > +
> > +wrote 65536/65536 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +Fiemap of SCRATCH_MNT/subv1/f7 before deleting SCRATCH_MNT/subv2/f8:
> > +0: [0..127]: shared|last
> > +Fiemap of SCRATCH_MNT/subv1/f7 after deleting SCRATCH_MNT/subv2/f8:
> > +0: [0..127]: last
> > --
> > 2.35.1
> >
>
