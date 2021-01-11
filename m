Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C032F1AA0
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 17:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbhAKQM1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 11:12:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:43978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730167AbhAKQM0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 11:12:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19FEF22211;
        Mon, 11 Jan 2021 16:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610381505;
        bh=9Ex4/gJDvCk8tGoMDtV17aJjra3G4JrPmGCOFpcPVzo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oJEeIFyi6431FlM54ihWS03TrLK8nEV0Uht18se7zu/Svtcwe7fZEzMG+G7DPPcUX
         VoWYXxIzqJCGIfFig/2L+LUtvVUuBwlE/QZE6emvWQjextHVxeyUtdtbzhVzRkNDiQ
         GZF6hnv1J6HCBfprkK1jGmG0vw8PGTSxr2jK+nbAF1S51Zubj93XtqN464Fp1N4ZVt
         vV3j+0BcpNNL5WvBJcEm+sy9nee8PVx/OIVGd1+B/HKXx+WUEJT/7pmV6stIhTorfj
         8GA3SHMaiJpIFQepnh+15nUGhDBIqH+WmaX3crw30gxShgZ2J74O3EoM01ltWV/Avd
         wtnDHXzN5oBiw==
Received: by mail-qk1-f170.google.com with SMTP id h4so15009620qkk.4;
        Mon, 11 Jan 2021 08:11:45 -0800 (PST)
X-Gm-Message-State: AOAM530qB7eP8Y4nNfSbMUbclWpxVaJAI3dQwSjUeJLGtrFhsc3GfmJ7
        2sxaK69IDNTLrA4XZeyQ7dqRSamUWFOt11gu1A8=
X-Google-Smtp-Source: ABdhPJyoupV95FYrGtUEyUjA8/pwHiPhQz9NwTwnTBjMCJ3EJ441JxWOaTWxQpHvvcYYcrMnje4np1vW76Syt6NJ9Xg=
X-Received: by 2002:ae9:e8c5:: with SMTP id a188mr16655121qkg.479.1610381504111;
 Mon, 11 Jan 2021 08:11:44 -0800 (PST)
MIME-Version: 1.0
References: <8337e3633d362dba6c2df168bd13ff3b75c68a92.1610363747.git.fdmanana@suse.com>
 <7a05e386-9843-fac3-464a-fbe6dfb1848f@toxicpanda.com>
In-Reply-To: <7a05e386-9843-fac3-464a-fbe6dfb1848f@toxicpanda.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 11 Jan 2021 16:11:33 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6p4RidLDT_NnunwJ27N0zHEuybEsZ4oqsePMxpTuwe6A@mail.gmail.com>
Message-ID: <CAL3q7H6p4RidLDT_NnunwJ27N0zHEuybEsZ4oqsePMxpTuwe6A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test incremental send after cloning extents from
 the same file
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 11, 2021 at 4:08 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 1/11/21 6:41 AM, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that an incremental send operation correctly issues clone operations
> > for a file that had different parts of one of its extents cloned into
> > itself, at different offsets, and a large part of that extent was
> > overwritten, so all the reflinks only point to subranges of the extent.
> >
> > This currently fails on btrfs but is fixed by a patch for the kernel that
> > has the following subject:
> >
> >   "btrfs: send, fix invalid clone operations when cloning from the same file and root"
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   tests/btrfs/228     | 109 ++++++++++++++++++++++++++++++++++++++++++++
> >   tests/btrfs/228.out |  24 ++++++++++
> >   tests/btrfs/group   |   1 +
> >   3 files changed, 134 insertions(+)
> >   create mode 100755 tests/btrfs/228
> >   create mode 100644 tests/btrfs/228.out
> >
> > diff --git a/tests/btrfs/228 b/tests/btrfs/228
> > new file mode 100755
> > index 00000000..0a3fb249
> > --- /dev/null
> > +++ b/tests/btrfs/228
> > @@ -0,0 +1,109 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test No. btrfs/228
> > +#
> > +# Test that an incremental send operation correctly issues clone operations for
> > +# a file that had different parts of one of its extents cloned into itself, at
> > +# different offsets, and a large part of that extent was overwritten, so all the
> > +# reflinks only point to subranges of the extent.
> > +#
>
> Can you reference the commit title that fixes the problem?

It's in the change log.

Thanks.

>
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +tmp=/tmp/$$
> > +status=1     # failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +     cd /
> > +     rm -fr $send_files_dir
> > +     rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +. ./common/reflink
> > +
> > +# real QA test starts here
> > +_supported_fs btrfs
> > +_require_test
> > +_require_scratch_reflink
> > +
> > +send_files_dir=$TEST_DIR/btrfs-test-$seq
> > +
> > +rm -f $seqres.full
> > +rm -fr $send_files_dir
> > +mkdir $send_files_dir
> > +
> > +_scratch_mkfs >>$seqres.full 2>&1
> > +_scratch_mount
> > +
> > +# Create our test file with a single and large extent (1M) and with different
> > +# content for different file ranges that will be reflinked later.
> > +$XFS_IO_PROG -f \
> > +          -c "pwrite -S 0xab 0 128K" \
> > +          -c "pwrite -S 0xcd 128K 128K" \
> > +          -c "pwrite -S 0xef 256K 256K" \
> > +          -c "pwrite -S 0x1a 512K 512K" \
> > +          $SCRATCH_MNT/foobar | _filter_xfs_io
> > +
> > +# Now create the base snapshot, which is going to be the parent snapshot for
> > +# a later incremental send.
> > +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
> > +     $SCRATCH_MNT/mysnap1 > /dev/null
> > +
> > +$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap \
> > +     $SCRATCH_MNT/mysnap1 2>&1 1>/dev/null | _filter_scratch
> > +
> > +# Now do a series of changes to our file such that we end up with different
> > +# parts of the extent reflinked into different file offsets and we overwrite
> > +# a large part of the extent too, so no file extent items refer to that part
> > +# that was overwritten. This used to confure the algorithm used by the kernel
>                                          ^^^^^^^
>                                          confuse
>
> otherwise you can add
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
> Thanks,
>
> Josef
