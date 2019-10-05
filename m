Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1917CCBA8
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Oct 2019 19:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfJER0g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Oct 2019 13:26:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33037 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfJER0f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Oct 2019 13:26:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id d22so4692055pls.0;
        Sat, 05 Oct 2019 10:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZLysHjxGxhD9xYP7z7+Qtdv1Pk1hsUlcFCmBFGqaQyU=;
        b=WZvT3NoP/d88g80UAOSVGVZroU0W2l11SfuZHqZawcJoxIdNroYRMU+MIKPKiidfaV
         DFqNcZhbY72HXFp43ymyf4s8FJQ36YzRRf+Noi1CITPF5q6YKVexU3cTPAw8o18iM37s
         Hud+XKUQfWdAQX81/0pU4aeZ8MRq2o72LHQ6+BoB5IDW+ZXb4Cnht0vsmZC965xXQ0pd
         QYiW1ID89t76GKl3wpfZLT0DoyhvAGhCNW472288iFQGRxYzIZnw8q9z7UFIWq24uenr
         KH/no0MpJVy1VIFv82M1HBvAXhc2P3QyCdA6mbbxkPUyLQbhurKLNaZ02RyV0ooAQEQv
         XUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZLysHjxGxhD9xYP7z7+Qtdv1Pk1hsUlcFCmBFGqaQyU=;
        b=Z6u5tInGVOlxzyBX+Udd8HIklYA0UM4EsquL16NWPmKtcjoQgc3EYTn8LsJpBJFlYL
         gp6rOPsd+rj2TbTskvXOBE5KEFsUV0XZULakmGwvZOHvu3OyZ0RNrQj84aWZZDVh6IMn
         ratUb5P72Rsm8g9hCzQ6aM5n1oDHizjJBAKm9p3JKqOfMD5C9mXYcOm+rZsxXcwstVNQ
         r6V6QxfzO+XeHWtiQWkTMnns1kuT90XA3Ol0JAD7QFSD3reiq2e1O7r93eMh9TZTylV/
         m3lfe+SmgjrFjZuFfI8QKJvmXPBjSAqtV2vhY8tPLY//B45AeVrYRswkKholS7b3yLYr
         XqrA==
X-Gm-Message-State: APjAAAVsYvqNFSSbtJcbDq6nF9b7ZPJ75xhF4u/8q9VTzqhr1mjDwZ9W
        aBbNaxl8BrDiyaQOStpbhPNhc3sQ
X-Google-Smtp-Source: APXvYqxms30qLNGyboTFLZh1CTAOLsixAHCWmXgr6ZO7n4SS0Km3wNlBL1mWJaNsbGnUrMkarrYyeA==
X-Received: by 2002:a17:902:8d8e:: with SMTP id v14mr2139822plo.293.1570296394982;
        Sat, 05 Oct 2019 10:26:34 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id p190sm12358210pfb.160.2019.10.05.10.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 10:26:33 -0700 (PDT)
Date:   Sun, 6 Oct 2019 01:26:27 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH][v2] btrfs/194: add a test for multi-subvolume fsyncing
Message-ID: <20191005172625.GB2622@desktop>
References: <20191002184133.21099-1-josef@toxicpanda.com>
 <CAL3q7H6e2DS-zCs+0z1U4SfLhcQw3UM1tte6kgmk0uNx+hMf7g@mail.gmail.com>
 <CAL3q7H47wKpDPGDd4v5-xYsbsSVug3tEeWNxJYSUJ1Cr-8FtTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H47wKpDPGDd4v5-xYsbsSVug3tEeWNxJYSUJ1Cr-8FtTg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 03, 2019 at 12:12:36PM +0100, Filipe Manana wrote:
> On Thu, Oct 3, 2019 at 11:59 AM Filipe Manana <fdmanana@gmail.com> wrote:
> >
> > On Wed, Oct 2, 2019 at 7:44 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > >
> > > I discovered a problem in btrfs where we'd end up pointing at a block we
> > > hadn't written out yet.  This is triggered by a race when two different
> > > files on two different subvolumes fsync.  This test exercises this path
> > > with dm-log-writes, and then replays the log at every FUA to verify the
> > > file system is still mountable and the log is replayable.
> > >
> > > This test is to verify the fix
> > >
> > > btrfs: fix incorrect updating of log root tree
> > >
> > > actually fixed the problem.
> > >
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >
> > It's working now.
> > Confirmed this triggers the bug, and after about 4 hours of this
> > running with the btrfs patch, it doesn't trigger the bug anymore.
> >
> > Thanks!
> >
> > > ---
> > > v1->v2:
> > > - added the patchname related to this test in the comments and changelog.
> > > - running fio makes it use 400mib of shared memory, so running 50 of them is
> > >   impossible on boxes that don't have hundreds of gib of RAM.  Fixed this to
> > >   just generate a fio config so we can run 1 fio instance with 50 threads which
> > >   makes it not OOM boxes with tiny amounts of RAM.
> > > - fixed some formatting things that Filipe pointed out.
> > >
> > >  tests/btrfs/194     | 111 ++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/btrfs/194.out |   2 +
> > >  tests/btrfs/group   |   1 +
> > >  3 files changed, 114 insertions(+)
> > >  create mode 100755 tests/btrfs/194
> > >  create mode 100644 tests/btrfs/194.out
> > >
> > > diff --git a/tests/btrfs/194 b/tests/btrfs/194
> > > new file mode 100755
> > > index 00000000..b98064e2
> > > --- /dev/null
> > > +++ b/tests/btrfs/194
> > > @@ -0,0 +1,111 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2019 Facebook.  All Rights Reserved.
> > > +#
> > > +# FS QA Test 194
> > > +#
> > > +# Test multi subvolume fsync to test a bug where we'd end up pointing at a block
> > > +# we haven't written.  This was fixed by the patch
> > > +#
> > > +# btrfs: fix incorrect updating of log root tree
> > > +#
> > > +# Will do log replay and check the filesystem.
> > > +#
> > > +seq=`basename $0`
> > > +seqres=$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +
> > > +here=`pwd`
> > > +tmp=/tmp/$$
> > > +fio_config=$tmp.fio
> > > +status=1       # failure is the default!
> > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > +
> > > +_cleanup()
> > > +{
> > > +       cd /
> > > +       _log_writes_cleanup &> /dev/null
> > > +       _dmthin_cleanup
> > > +       rm -f $tmp.*
> > > +}
> > > +
> > > +# get standard environment, filters and checks
> > > +. ./common/rc
> > > +. ./common/filter
> > > +. ./common/dmthin
> > > +. ./common/dmlogwrites
> > > +
> > > +# remove previous $seqres.full before test
> > > +rm -f $seqres.full
> > > +
> > > +# real QA test starts here
> > > +
> > > +# Modify as appropriate.
> > > +_supported_fs generic
> 
> Btw, only forgot about this.
> Should be: _supported_fs btrfs
> 
> Eryu can probably fix that at commit time.
> Thanks.

Sure. Thanks for the review!

Eryu
