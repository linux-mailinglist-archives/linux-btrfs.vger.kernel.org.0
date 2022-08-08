Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AAC58C591
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 11:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242319AbiHHJbQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 05:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242503AbiHHJbG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 05:31:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEE02BE1;
        Mon,  8 Aug 2022 02:30:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1B03B80E27;
        Mon,  8 Aug 2022 09:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FC5C433D6;
        Mon,  8 Aug 2022 09:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659951049;
        bh=zFfWcIGkez6OAjgy8mA5wQWRw8k14yr8+Z6IR90ax48=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DZOQXOH1kt4wLwa6TwPQ9dmL3RaEXcrzZ5gV5E8Brd2uL/9TP64HJ0z/S0AKT/mdw
         rV5mj4NUI0L4fyUcPulksSNtPt4b1Y2xtNlfO/yeDSGHPHEWVpEXZqCqsv50y3NAIl
         T0zSg+fPGkNwcm3uhbrRXV0sDRvy8YnMWNsC0gzhtJ4hyNzK3B5Yy1sKs6CnPx6rRC
         /VkdT1fjXzHF/SGxGYQJ4zWy/XUQVDPo7F4BmZFOtkdmxcv8JvuojsLi/k0/aVCBt8
         kn+M2hbU3cqSVcY+mufaFb39X09zuoUvFKHwmI0Ubog04XRRX1U6u7devPfnABUYVN
         A4hTthF7F+dbA==
Received: by mail-oi1-f176.google.com with SMTP id h188so9694501oia.13;
        Mon, 08 Aug 2022 02:30:49 -0700 (PDT)
X-Gm-Message-State: ACgBeo1DpzEbpoRw4davUUZxNxNfioEoLtHlLEzgA+vxLzU4Lfb31hQN
        P0+YOibi1oHSP5qZBAEHV2G4uchHZvCZWTen9u8=
X-Google-Smtp-Source: AA6agR6R/g5ZmsPXH2OKCK/AzfF+sZNqGiwrwbCEhEcOSOIFsSvxiMMt49D4P6HsO5nrTeKLCW8AFWcFrm4iUOzzz90=
X-Received: by 2002:a05:6808:1b85:b0:33a:7a2b:3ff7 with SMTP id
 cj5-20020a0568081b8500b0033a7a2b3ff7mr7543590oib.152.1659951048528; Mon, 08
 Aug 2022 02:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220806143436.3501-1-bingjingc@synology.com>
In-Reply-To: <20220806143436.3501-1-bingjingc@synology.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 8 Aug 2022 10:30:11 +0100
X-Gmail-Original-Message-ID: <CAL3q7H52=bJj7nGsso0zhD6kYHDtXGhR7FSM=aFkF2wUvtWOSQ@mail.gmail.com>
Message-ID: <CAL3q7H52=bJj7nGsso0zhD6kYHDtXGhR7FSM=aFkF2wUvtWOSQ@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: test incremental send for changed
 reference paths
To:     bingjingc <bingjingc@synology.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>, bxxxjxxg@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 6, 2022 at 3:35 PM bingjingc <bingjingc@synology.com> wrote:
>
> From: BingJing Chang <bingjingc@synology.com>
>
> Normally btrfs stores reference paths in an array of ref items. However,
> items for the same parent directory can not exceed the size of a leaf. So
> btrfs also store the rest of them in extended ref items alternatively.
>
> In this test, it creates a large number of links under a directory
> causing the reference paths stored in these two ways as the parent
> snapshot. And it deletes and recreates just an amount of them that can be
> stored within an array of ref items as the send snapshot. Test that an
> incremental send operation correctly issues link/unlink operations only
> against new/deleted reference paths, or the receive operation will fail
> due to a link on an existed path.
>
> This currently fails on btrfs but is fixed by a kernel patch with the
> following subject:

Thanks for sending the test BingJing!
Some comments below.

>
>   "btrfs: send: fix sending link commands for existing file paths"

Since the patch already landed in Linus' tree last week, the preferred
format here is:

commit 3aa5bd367fa5a3 ("btrfs: send: fix sending link commands for
existing file paths")

>
> Signed-off-by: BingJing Chang <bingjingc@synology.com>
> ---
>  tests/btrfs/272     | 65 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/272.out |  2 ++
>  2 files changed, 67 insertions(+)
>  create mode 100755 tests/btrfs/272
>  create mode 100644 tests/btrfs/272.out
>
> diff --git a/tests/btrfs/272 b/tests/btrfs/272
> new file mode 100755
> index 00000000..a362d943
> --- /dev/null
> +++ b/tests/btrfs/272
> @@ -0,0 +1,65 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 BingJing Chang.
> +#
> +# FS QA Test No. btrfs/272
> +#
> +# Regression test for btrfs incremental send issue where a link instruction
> +# is sent against an existed file, causing btrfs receive to fail.

existed file -> existing path

> +#
> +# This issue is fixed by the following linux kernel btrfs patch:
> +#
> +#   btrfs: send: fix sending link commands for existing file paths

Same here.

> +#
> +. ./common/preamble
> +_begin_fstest auto quick send
> +
> +tmp=`mktemp -d`

Overriding $tmp, which is set by the fstests framework is not a good idea.
It's expected to be a file and not a directory.

If you need a directory to store temporary files, you can use the test device.
Take a look at btrfs/241 for example.

> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +       rm -rf $tmp

Then here leave the standard "rm -f $tmp.*" followed by a rm -rf of
the temporary directory in the test mount point.

> +}
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_test
> +_require_scratch
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +_run_btrfs_util_prog subvolume create $SCRATCH_MNT/vol
> +
> +# create a file and 2000 hard links to the same inode
> +touch $SCRATCH_MNT/vol/foo
> +for i in {1..2000}; do
> +       link $SCRATCH_MNT/vol/foo $SCRATCH_MNT/vol/$i
> +done
> +
> +# take a snapshot for a parent snapshot

"take a snapshot for a full send operation"

> +_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_MNT/snap1
> +
> +# remove 2000 hard links and re-create the last 1000 links
> +for i in {1..2000}; do
> +       rm $SCRATCH_MNT/vol/$i
> +done
> +for i in {1001..2000}; do
> +       link $SCRATCH_MNT/vol/foo $SCRATCH_MNT/vol/$i
> +done
> +
> +# take another one for a send snapshot

"take a snapshot for an incremental send operation"

> +_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_MNT/snap2
> +
> +mkdir $SCRATCH_MNT/receive_dir
> +_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 -f $tmp/diff.snap \
> +       $SCRATCH_MNT/snap2
> +_run_btrfs_util_prog receive -f $tmp/diff.snap $SCRATCH_MNT/receive_dir
> +_scratch_unmount

Btw, there's no need to call _scratch_unmount, the fstests framework
automatically does that when the test finishes.

So, this tests that the send and receive commands do not fail.

However it does not test that they produce the correct results: that
after the receive we have the file with the same hardlinks, mtime,
ctime, etc, as in the original subvolume.
For send/receive tests (well, most tests actually), we always want to
verify that the operations produce the expected results, not just that
they don't fail with an error.

The fssum utility can be used here to verify that, and we use it in
many send/receive tests like btrfs/241 for example.

Thanks for doing this!

> +
> +echo "Silence is golden"
> +status=0 ; exit
> diff --git a/tests/btrfs/272.out b/tests/btrfs/272.out
> new file mode 100644
> index 00000000..c18563ad
> --- /dev/null
> +++ b/tests/btrfs/272.out
> @@ -0,0 +1,2 @@
> +QA output created by 272
> +Silence is golden
> --
> 2.37.1
>
