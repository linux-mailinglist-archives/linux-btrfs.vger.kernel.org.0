Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2DF169828
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Feb 2020 15:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgBWOzX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Feb 2020 09:55:23 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33353 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBWOzX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Feb 2020 09:55:23 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so3670547pgk.0;
        Sun, 23 Feb 2020 06:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=a/h5T1BSpX/OKz/o1q7Ns8K/fW398JD+6VlLoeZI7Lk=;
        b=VFf5FE4eKSI6WiUT75kFdqWn7nbazo0Ebazp28caNZZeCF6wc4UecSciblUIRYETUa
         LtBGo844gcpzJuKQhDviHWDyMFBHRLNSXGFna7W+xNa3ueINAeOc1Pqbj2a3erzUdboA
         qfVNc1D/mCuJxpf1qpE58YiR08uouuEzaGHjVSk08tpdmeeWHW9Opzcfyd/u1rV6ARI4
         aKW6ZgyDOTbZWxc+96sLsEg/OWUNrOMQZsa9vUv1qSlrcaMdFKm8KCyT2lSWM+ogrMZo
         3dkZGp7BUl+FT3DciJcfPdov+EigzTPM4gWSz93pP1hwO9f9I+m9o+w/rkQz3IPftftr
         sPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=a/h5T1BSpX/OKz/o1q7Ns8K/fW398JD+6VlLoeZI7Lk=;
        b=UQV1q8wQRYM8ZThWIeXjdQ43P1ytI1jh+wy0sBVoyJfnqtNOMHHsh0VJTtOgLKbjzT
         hXqqjM/jFvwrBd5flnKuFxPMdzXIdZufSIf5V9o0V2SAk9uTY6F/FzY5Lu0xWHsAbxza
         cWQstkd5kcQwJh1h4A66Bj7KJCgQW2Et0QRbfmm9e65aHNOhLWDxs+tqI0DX1n8mQ0lG
         LCrasd70SEfifW796tUUAILmFTACVx7ZP4mwW0QXqGHliYYB2vlyNTITRqVKvNnSCIHX
         VE36yaLrcXAeir2T8SbS43tUlGGwqw7xfBMUyHGomaMGitBYCr1CgEp2ny/QOmYsFHIE
         qdmw==
X-Gm-Message-State: APjAAAW9TpF37r+Dk3OmZ0mqsmKS9f9l5Y5JY+innYHvojvBosVs8rC9
        sTfTuQPIiGCZfTNfw4m5Ltg=
X-Google-Smtp-Source: APXvYqwWJxe3JEb8fQuXbASQi7lRyIu12YPsWXzBUxuGVSJutlsafznqDeMYVIPUMFfsBMo8GqEYEQ==
X-Received: by 2002:aa7:9f47:: with SMTP id h7mr45279150pfr.13.1582469722420;
        Sun, 23 Feb 2020 06:55:22 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id a17sm9339733pfo.146.2020.02.23.06.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 06:55:21 -0800 (PST)
Date:   Sun, 23 Feb 2020 22:54:35 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com,
        fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] fstests: add a another gap extent testcase for btrfs
Message-ID: <20200223145332.GF3840@desktop>
References: <20200220143855.3883650-1-josef@toxicpanda.com>
 <CAL3q7H7UaJ-_aT4-Ab1eheVJUDwyuc6UQ6-Q9cQZCU1GqjuSGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7UaJ-_aT4-Ab1eheVJUDwyuc6UQ6-Q9cQZCU1GqjuSGQ@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 20, 2020 at 04:24:37PM +0000, Filipe Manana wrote:
> On Thu, Feb 20, 2020 at 2:39 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > This is a testcase for a corner that I missed when trying to fix gap
> > extents for btrfs.  We would end up with gaps if we hole punched past
> > isize and then extended past the gap in a specific way.  This is a
> > simple reproducer to show the problem, and has been properly fixed by my
> > patches now.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  tests/btrfs/204     | 85 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/204.out |  5 +++
> >  tests/btrfs/group   |  1 +
> >  3 files changed, 91 insertions(+)
> >  create mode 100755 tests/btrfs/204
> >  create mode 100644 tests/btrfs/204.out
> >
> > diff --git a/tests/btrfs/204 b/tests/btrfs/204
> > new file mode 100755
> > index 00000000..0d5c4bed
> > --- /dev/null
> > +++ b/tests/btrfs/204
> > @@ -0,0 +1,85 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2020 Facebook.  All Rights Reserved.
> > +#
> > +# FS QA Test 204
> > +#
> > +# Validate that without no-holes we do not get a i_size that is after a gap in
> > +# the file extents on disk when punching a hole past i_size.  This is fixed by
> > +# the following patches
> > +#
> > +#      btrfs: use the file extent tree infrastructure
> > +#      btrfs: replace all uses of btrfs_ordered_update_i_size
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1       # failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +       cd /
> > +       rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +. ./common/dmlogwrites
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs generic

I also changed 'generic' to 'btrfs'

> > +_supported_os Linux
> > +_require_test
> > +_require_scratch
> > +_require_log_writes
> 
> _require_xfs_io_command "falloc" "-k"
> _require_xfs_io_command "fpunch"

Added.

> 
> > +
> > +_log_writes_init $SCRATCH_DEV
> > +_log_writes_mkfs "-O ^no-holes" >> $seqres.full 2>&1
> > +
> > +# There's not a straightforward way to commit the transaction without also
> > +# flushing dirty pages, so shorten the commit interval to 1 so we're sure to get
> > +# a commit with our broken file
> > +_log_writes_mount -o commit=1
> > +
> > +# This creates a gap extent because fpunch doesn't insert hole extents past
> > +# i_size
> > +xfs_io -f -c "falloc -k 4k 8k" $SCRATCH_MNT/file
> > +xfs_io -f -c "fpunch 4k 4k" $SCRATCH_MNT/file
> > +
> > +# The pwrite extends the i_size to cover the gap extent, and then the truncate
> > +# sets the disk_i_size to 12k because it assumes everything was a-ok.
> > +xfs_io -f -c "pwrite 0 4k" $SCRATCH_MNT/file | _filter_xfs_io
> > +xfs_io -f -c "pwrite 0 8k" $SCRATCH_MNT/file | _filter_xfs_io
> > +xfs_io -f -c "truncate 12k" $SCRATCH_MNT/file

Changed all 'xfs_io' to '$XFS_IO_PROG'.

> > +
> > +# Wait for a transaction commit
> > +sleep 2
> > +
> > +_log_writes_unmount
> > +_log_writes_remove
> > +
> > +cur=$(_log_writes_find_next_fua 0)
> > +echo "cur=$cur" >> $seqres.full
> > +while [ ! -z "$cur" ]; do
> > +       _log_writes_replay_log_range $cur $SCRATCH_DEV >> $seqres.full
> > +
> > +       # We only care about the fs consistency, so just run fsck, we don't have
> > +       # to mount the fs to validate it
> > +       _check_scratch_fs
> > +
> > +       cur=$(_log_writes_find_next_fua $(($cur + 1)))
> > +done
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/204.out b/tests/btrfs/204.out
> > new file mode 100644
> > index 00000000..44c7c8ae
> > --- /dev/null
> > +++ b/tests/btrfs/204.out
> > @@ -0,0 +1,5 @@
> > +QA output created by 204
> > +wrote 4096/4096 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +wrote 8192/8192 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > diff --git a/tests/btrfs/group b/tests/btrfs/group
> > index 6acc6426..7a840177 100644
> > --- a/tests/btrfs/group
> > +++ b/tests/btrfs/group
> > @@ -206,3 +206,4 @@
> >  201 auto quick punch log
> >  202 auto quick subvol snapshot
> >  203 auto quick send clone
> > +204 auto quick log replay
> 
> "prealloc" and "punch" groups as well.

Added.

> 
> Since this just tests another variant of the same problem, maybe it
> could be added to btrfs/172, since that test is very recent and you
> authored it as well.
> Anyway, I don't have a strong preference.
> 
> The test itself looks good to me, and with the _require_xfs_io_command
> thing added and the groups (maybe Eryu can add these at commit time):
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks for the review!

Eryu

> 
> 
> > --
> > 2.24.1
> >
> 
> 
> -- 
> Filipe David Manana,
> 
> “Whether you think you can, or you think you can't — you're right.”
