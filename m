Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1971068BA8C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 11:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjBFKlp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 05:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjBFKll (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 05:41:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA881969C
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Feb 2023 02:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675680027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ehBCBcwlvNslclBc65RDYInRPlbQLT1iinw60lRKVnE=;
        b=BBLMPcL+Y+J7WCQNZu/eNJKDcRLQyFstPhdUvo2M9wi32qv8j/POr488+n+PW7XS9xq7oH
        xwH+LPeaM84+bKiQd3YurvAQNhzjnZqmU1Hu00K2p6LieC3LBLxsaukXnOeoB18yFmoawT
        5bb4tsoMCvG9Ay4g2bF49DI0KWuBXOw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-59-96WOr-OONsOog2I09mhicA-1; Mon, 06 Feb 2023 05:40:26 -0500
X-MC-Unique: 96WOr-OONsOog2I09mhicA-1
Received: by mail-pl1-f199.google.com with SMTP id jb5-20020a170903258500b00199226cbbdeso394126plb.19
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Feb 2023 02:40:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehBCBcwlvNslclBc65RDYInRPlbQLT1iinw60lRKVnE=;
        b=zbozSxzohYS+zufgesrwMCKQd4dn38Hg/3EUk7KXKrUGxW2y8GfNUTz9PHLAFBFzQx
         XmNv1ESLXwJu3B0znYA9Os6eXD1d+RqG3w6v0Z0O4Ao6P5nmHgvVvbXhnOGpkR0IYiIy
         yMJAxi9aNgCJOS2iS12b/QC4FbDsa7w4QnjFA3t5H1InrOIt03HKxwmNQuHeIJ7ac96R
         O05QdSICgpaTuzoODeriZkxnHX0wI9Syn9/fJgVvBUUdLrw5r4WBEFHRUye5Ut8PJFX0
         MlnPDTii/voq+mBzGvGK7bT1ZytVuYwP1SOQD5uTZa/6mzkd1ZQW7YKc/g+3+0TaHLXC
         KkAw==
X-Gm-Message-State: AO0yUKUlmu5TIngr0hzGR1JZgd0EPQQpU3uuH8Fz5OXIOjMG7CBH/C/2
        HMp75hiChJu8OLOhzv8p/1R0aFQlnRLXLS38kAc1f0no1FeQWlwYdeWjLl0K/sn1FUdwleBjPgN
        hGLH5RwAPEbx6rCf18S1IR8I=
X-Received: by 2002:a62:aa0f:0:b0:593:adfa:84f6 with SMTP id e15-20020a62aa0f000000b00593adfa84f6mr18115290pff.23.1675680025278;
        Mon, 06 Feb 2023 02:40:25 -0800 (PST)
X-Google-Smtp-Source: AK7set/2vxMbx5oRYg96dLI/BvrQdd9NOEvOfstJlzpPDqQASxiA42eat3aTTd8JX+NQ2k3VjqGvIw==
X-Received: by 2002:a62:aa0f:0:b0:593:adfa:84f6 with SMTP id e15-20020a62aa0f000000b00593adfa84f6mr18115273pff.23.1675680024851;
        Mon, 06 Feb 2023 02:40:24 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z15-20020aa791cf000000b00590163e1762sm6702128pfa.200.2023.02.06.02.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:40:24 -0800 (PST)
Date:   Mon, 6 Feb 2023 18:40:20 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add a stress test for send v2 streams
Message-ID: <20230206104020.h5osarjgjowx4tsb@zlang-mailbox>
References: <a2a5700b744bca710ff0721f1d1fa268d76430fc.1675353192.git.fdmanana@suse.com>
 <CAL3q7H4i_CXH+sz0NtmuMBX5xg8Pjc3BOP0Kn1W-pwvKENGbzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4i_CXH+sz0NtmuMBX5xg8Pjc3BOP0Kn1W-pwvKENGbzA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_PDS_OTHER_BAD_TLD
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 06, 2023 at 10:14:54AM +0000, Filipe Manana wrote:
> On Thu, Feb 2, 2023 at 4:00 PM <fdmanana@kernel.org> wrote:
> >
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Currently we don't have any test case in fstests to do randomized and
> > stress testing of the send stream v2, added in kernel 6.0 and support for
> > it in btrfs-progs v5.19. For the send v2 stream, we only have btrfs/281
> > that exercises a specific scenario which used to trigger a bug.
> >
> > So add a test that uses fsstress to generate a filesystem and exercise
> > both full and incremental send operations using the v2 send stream with
> > compressed extents, and then receive the streams without and with
> > decompression, to verify they work and produce the same results as in
> > the original filesystem. This is the same base idea as btrfs/007, but
> > for the send v2 stream with compressed data.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> 
> Zorro, this is missing in the last fstests update.
> The test was reviewed (by Anand), do you expect anything from my side?

Hi Filipe,

No. Don't worry. It was reviewed last Friday 19:38:28, after I just submitted
testing jobs (before pushing fstests). So I shifted this patch to the list
which will be merged and pushed next week (this week). Sorry for your one more
week waiting.

> 
> I also often see other patches that get reviewed and don't get merged,

Thanks, feel free to ping to me or ping the fstests@ list, if a patch is
stuck for long time :)

> even after several weeks. For example:
> 
> https://lore.kernel.org/fstests/20230113070653.44512-1-wqu@suse.com/

From what I saw, Anand gave two review points to that patch:

1) Please remove the template code. (this's tiny, I can help)
2) IMO, it is a good idea to call sync to ensure that the transaction is 
committed.

The 2nd review point wasn't get any response. So I don't know if the author
and Anand agree with "don't need sync", or will send a v2 to add that. I
try to merge patches which reaches an clear agreement, no more dispute.

Thanks,
Zorro

> 
> Thanks.
> 
> 
> > ---
> >  tests/btrfs/284     | 133 ++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/284.out |   2 +
> >  2 files changed, 135 insertions(+)
> >  create mode 100755 tests/btrfs/284
> >  create mode 100644 tests/btrfs/284.out
> >
> > diff --git a/tests/btrfs/284 b/tests/btrfs/284
> > new file mode 100755
> > index 00000000..0d31e5d9
> > --- /dev/null
> > +++ b/tests/btrfs/284
> > @@ -0,0 +1,133 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test 284
> > +#
> > +# Test btrfs send stream v2, sending and receiving compressed data without
> > +# decompression at the sending side.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick send compress snapshot
> > +
> > +# Modify as appropriate.
> > +_supported_fs btrfs
> > +_require_btrfs_send_v2
> > +_require_test
> > +# The size needed is variable as it depends on the specific randomized
> > +# operations from fsstress and on the value of $LOAD_FACTOR. But require at
> > +# least $LOAD_FACTOR * 1G, just to be on the safe side.
> > +_require_scratch_size $(($LOAD_FACTOR * 1 * 1024 * 1024))
> > +_require_fssum
> > +
> > +send_files_dir=$TEST_DIR/btrfs-test-$seq
> > +
> > +rm -fr $send_files_dir
> > +mkdir $send_files_dir
> > +
> > +# Redirect stdout to the .full file and make it not part of the golden output.
> > +# This is because the number of available compression algorithms may vary across
> > +# kernel versions, so the number of times we are running this function is
> > +# variable.
> > +run_send_test()
> > +{
> > +       local algo=$1
> > +       local snapshot_cmd
> > +       local first_stream="$send_files_dir/snap1.stream"
> > +       local second_stream="$send_files_dir/snap2.stream"
> > +       local first_fssum="$send_files_dir/snap1.fssum"
> > +       local second_fssum="$send_files_dir/snap2.fssum"
> > +
> > +       _scratch_mkfs >> $seqres.full 2>&1
> > +       _scratch_mount -o compress=$algo
> > +
> > +       snapshot_cmd="$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT"
> > +       snapshot_cmd="$snapshot_cmd $SCRATCH_MNT/snap1"
> > +
> > +       # Use a single process so that in case of failure it's easier to
> > +       # reproduce by using the same seed (logged in $seqres.full).
> > +       run_check $FSSTRESS_PROG -d $SCRATCH_MNT -p 1 -n $((LOAD_FACTOR * 200)) \
> > +                 -w $FSSTRESS_AVOID -x "$snapshot_cmd" >> $seqres.full
> > +
> > +       $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2 \
> > +                        >> $seqres.full
> > +
> > +       echo "Creating full and incremental send streams..." >> $seqres.full
> > +
> > +       $BTRFS_UTIL_PROG send --compressed-data -q -f $first_stream \
> > +                        $SCRATCH_MNT/snap1 2>&1 | tee -a $seqres.full
> > +       $BTRFS_UTIL_PROG send --compressed-data -q -f $second_stream \
> > +                        -p $SCRATCH_MNT/snap1 $SCRATCH_MNT/snap2 2>&1 | \
> > +                        tee -a $seqres.full
> > +
> > +       echo "Computing the checksums for each snapshot..." >> $seqres.full
> > +
> > +       $FSSUM_PROG -A -f -w $first_fssum $SCRATCH_MNT/snap1 2>&1 | \
> > +               tee -a $seqres.full
> > +       $FSSUM_PROG -A -f -w $second_fssum -x $SCRATCH_MNT/snap2/snap1 \
> > +                   $SCRATCH_MNT/snap2 2>&1 | tee -a $seqres.full
> > +
> > +       echo "Creating a new fs to receive the streams..." >> $seqres.full
> > +
> > +       _scratch_unmount
> > +       _scratch_mkfs >> $seqres.full 2>&1
> > +       _scratch_mount
> > +
> > +       echo "Receiving the streams..." >> $seqres.full
> > +
> > +       $BTRFS_UTIL_PROG receive -q -f $first_stream $SCRATCH_MNT 2>&1 | \
> > +               tee -a $seqres.full
> > +       $BTRFS_UTIL_PROG receive -q -f $second_stream $SCRATCH_MNT 2>&1 | \
> > +               tee -a $seqres.full
> > +
> > +       echo "Verifying the checksums for each snapshot..." >> $seqres.full
> > +
> > +       # On success, fssum outputs only a single line with "OK" to stdout, and
> > +       # on error it outputs several lines to stdout telling about each file
> > +       # with data or metadata mismatches. Since the number of times we run
> > +       # fssum depends on the available compression algorithms for the running
> > +       # kernel, filter out the success case, so we don't have a mismatch with
> > +       # the golden output. We only want the mismatch with the golden output in
> > +       # case there's a checksum failure.
> > +       $FSSUM_PROG -r $first_fssum $SCRATCH_MNT/snap1 | grep -Ev '^OK$' | \
> > +               tee -a $seqres.full
> > +       $FSSUM_PROG -r $second_fssum $SCRATCH_MNT/snap2 | grep -Ev '^OK$' | \
> > +               tee -a $seqres.full
> > +
> > +       # Now receive again the streams in a new filesystem, but this time use
> > +       # the option --force-decompress of the receiver to verify that it works
> > +       # as expected.
> > +       echo "Creating a new fs to receive the streams with decompression..." >> $seqres.full
> > +
> > +       _scratch_unmount
> > +       _scratch_mkfs >> $seqres.full 2>&1
> > +       _scratch_mount
> > +
> > +       echo "Receiving the streams with decompression..." >> $seqres.full
> > +
> > +       $BTRFS_UTIL_PROG receive -q --force-decompress -f $first_stream $SCRATCH_MNT 2>&1 \
> > +               | tee -a $seqres.full
> > +       $BTRFS_UTIL_PROG receive -q --force-decompress -f $second_stream $SCRATCH_MNT 2>&1 \
> > +               | tee -a $seqres.full
> > +
> > +       echo "Verifying the checksums for each snapshot..." >> $seqres.full
> > +
> > +       $FSSUM_PROG -r $first_fssum $SCRATCH_MNT/snap1 | grep -Ev '^OK$' | \
> > +               tee -a $seqres.full
> > +       $FSSUM_PROG -r $second_fssum $SCRATCH_MNT/snap2 | grep -Ev '^OK$' | \
> > +               tee -a $seqres.full
> > +
> > +       _scratch_unmount
> > +       rm -f $send_files_dir/*
> > +}
> > +
> > +algo_list=($(_btrfs_compression_algos))
> > +for algo in ${algo_list[@]}; do
> > +       echo -e "\nTesting with $algo...\n" >> $seqres.full
> > +       run_send_test $algo
> > +done
> > +
> > +# success, all done
> > +echo "Silence is golden"
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/284.out b/tests/btrfs/284.out
> > new file mode 100644
> > index 00000000..931839fe
> > --- /dev/null
> > +++ b/tests/btrfs/284.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 284
> > +Silence is golden
> > --
> > 2.35.1
> >
> 

