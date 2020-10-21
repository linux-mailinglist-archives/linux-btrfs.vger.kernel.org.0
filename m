Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2482950FC
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 18:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503116AbgJUQj7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 12:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503114AbgJUQj7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 12:39:59 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B7DE22248;
        Wed, 21 Oct 2020 16:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603298398;
        bh=XguH+Tw+JKewpyJcWf3ihG+3GbwwNDI5J/qLKyqaDSE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zlAUn7hqgK8e62aL3BJxllL10X/v6R9z3CLMvicn2aWvFOUS/V4r1Mq4pSxtoq7vY
         jAVKtwf0uhiai/nEawiyLSHfIpAl0NrCu8Rv+wmRkbiIwV9kzqzstwJnBeLWwlc7dd
         jmZ2y9RdG7QXyR9+ilmMmOi7KlOd761mD9MbG9Do=
Received: by mail-qk1-f173.google.com with SMTP id a23so3043380qkg.13;
        Wed, 21 Oct 2020 09:39:58 -0700 (PDT)
X-Gm-Message-State: AOAM533Qe9uCjPAhCAbxKgx3uOssZns0weDA8i3CQGftQN/6riFDSqPY
        RKbRcn66lCN2iZ5dyUh3eV1OH4SariVm5XwdNH8=
X-Google-Smtp-Source: ABdhPJySHC7gHhTzdUyeuJ8ufY3dDhqQ1/wcoymbZnLVUOTBBuaP/grvbJJIbV6zCiMJtj84v/ZZOCQpOsHn7cgTeO4=
X-Received: by 2002:ae9:eb58:: with SMTP id b85mr3750160qkg.383.1603298396722;
 Wed, 21 Oct 2020 09:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <5cfe8cb86da5593dda6c03b4ac404fa3b4c8b0d8.1603204654.git.fdmanana@suse.com>
 <1aa6d939-6818-f8f3-d857-642237e56cf8@toxicpanda.com>
In-Reply-To: <1aa6d939-6818-f8f3-d857-642237e56cf8@toxicpanda.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 21 Oct 2020 17:39:45 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7RsANt+xYjuVrasz8xONm5qLyEHQbzDP_MONP_9_=wQA@mail.gmail.com>
Message-ID: <CAL3q7H7RsANt+xYjuVrasz8xONm5qLyEHQbzDP_MONP_9_=wQA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add test case for rwf_nowait writes
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 21, 2020 at 3:39 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 10/20/20 10:43 AM, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test several scenarios for RWF_NOWAIT writes, to verify we don't regress
> > on btrfs specific behaviour (snapshots, cow files, reflinks, holes,
> > prealloc extent beyond eof).
> >
> > We had some bugs in the past related to RWF_NOWAIT writes not failing on
> > btrfs when they should or failing when they shouldn't, these were fixed by
> > the following kernel commits:
> >
> >    4b1946284dd6 ("btrfs: fix failure of RWF_NOWAIT write into prealloc extent beyond eof")
> >    260a63395f90 ("btrfs: fix RWF_NOWAIT write not failling when we need to cow")
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   tests/btrfs/225     | 140 ++++++++++++++++++++++++++++++++++++++++++++
> >   tests/btrfs/225.out |  70 ++++++++++++++++++++++
> >   tests/btrfs/group   |   1 +
> >   3 files changed, 211 insertions(+)
> >   create mode 100755 tests/btrfs/225
> >   create mode 100644 tests/btrfs/225.out
> >
> > diff --git a/tests/btrfs/225 b/tests/btrfs/225
> > new file mode 100755
> > index 00000000..f55e8c80
> > --- /dev/null
> > +++ b/tests/btrfs/225
> > @@ -0,0 +1,140 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test No. btrfs/225
> > +#
> > +# Test several (btrfs specific) scenarios with RWF_NOWAIT writes, cases where
> > +# they should fail and cases where they should succeed.
> > +#
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
> > +_require_scratch_reflink
> > +_require_chattr C
> > +_require_odirect
> > +_require_xfs_io_command pwrite -N
> > +_require_xfs_io_command falloc -k
> > +_require_xfs_io_command fpunch
> > +
> > +rm -f $seqres.full
> > +
> > +_scratch_mkfs >>$seqres.full 2>&1
> > +_scratch_mount
> > +
> > +# Test a write against COW file/extent - should fail with -EAGAIN. Disable the
> > +# NOCOW attribute of the file just in case MOUNT_OPTIONS has "-o nodatacow".
> > +echo "Testing write against COW file"
> > +touch $SCRATCH_MNT/f1
> > +$CHATTR_PROG -C $SCRATCH_MNT/f1
> > +$XFS_IO_PROG -s -c "pwrite -S 0xab 0 128K" $SCRATCH_MNT/f1 | _filter_xfs_io
> > +$XFS_IO_PROG -d -c "pwrite -N -V 1 -S 0xff 32K 64K" $SCRATCH_MNT/f1
>
> Should we do something like
>
> expected_to_fail_command > /dev/null 2>&1 || echo "FAILED!"
>
> so we don't get screwed by error strings changing in the future or some such
> other nonsense?  Thanks,

1) That's generally considered an anti-pattern in fstests.

2) More importantly, I want to make sure the failure reason is -EAGAIN
("Resource temporarily unavailable") and not something else, in which
case it means we have a regression and we want to notice it.

Thanks

>
> Josef
