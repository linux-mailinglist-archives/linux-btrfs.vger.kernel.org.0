Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34F47C8A50
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 15:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfJBN4i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 09:56:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46188 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfJBN4i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Oct 2019 09:56:38 -0400
Received: by mail-qt1-f193.google.com with SMTP id u22so26388135qtq.13
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Oct 2019 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=caTB1vW5LRmcHzONFL04Q7uf8Sb93YSgD3YPZxfz35k=;
        b=wnUT9hMBrZNOsqy8GikHNcP3Bx9f/XacI3sdFGM5o+Ev2OobT1uO1FwwIMSq0AXlYC
         BlAoM+AxDFZJ91wLx398kmrvm+GvZbiLsVZ9zfCLnz5tw6XzTgyXP/aOz9ypZQSFrjhk
         YKwo3mkmVOvbBs3CfAh6GAbi6iBvXyn1Y9+9PKVhkhSE/lXH3eOgerid2+4uEPX+oYKU
         ZqVtHKq1remeRjj6n9+/h3ncfPQU1+gxIRXPfwhxXAyf5F/EkWE1+YxVepV6UuXjQN+t
         2Z3TzfFvelohOZai2++Z30hOVW8rDgxHRKhJ5UpUC6x4ZOpzJsc00EJTzJnekPYVXCJs
         tdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=caTB1vW5LRmcHzONFL04Q7uf8Sb93YSgD3YPZxfz35k=;
        b=fDB0bS8aAqnewNHqlc7kyLeqtWz9M9ksLnZiecPsn5CZ2OsC1nYAr6smyJI/W0HUqI
         4aXzZwUKgUIwnfe4dn50eahrFlVrSmeteroDtKLHJWul6TdhMRuj81kraWeSQ9otsuxC
         FKzr/V58BKRbqhF1mUbXDv1Jd6ryQchi+YYrwsroxRWZGYJAt9AUjW3gVRhrTgJzzeLJ
         ZGIOQynJJ30CBKhk4Et60XMRZjaCQbUEkmwzYu5+wAgJhYenYr/qqFELRWGzn0sCUMIh
         UJVZU8n4z6l5T77VUJGbINVYhXMBwh0Ky0jHB8m5c/KCE3dZ5zWv8Iaz7Pod9wfcOAYn
         P6fw==
X-Gm-Message-State: APjAAAWrPpSTDeELznUIRYk0MIqFE7u5YbvYL6SXUgmnCVPOGZKFQuyJ
        NvawQ3jf9BoCXtipGe9yp7dBEJe0n4kjkg==
X-Google-Smtp-Source: APXvYqzt++XWOKmcg50h5pIywcxgP2qEJmcn+jk/CFdNMl1NjmBiFrGfC6cug4YrW+FQGyq9WZEOiw==
X-Received: by 2002:ac8:33d3:: with SMTP id d19mr4095798qtb.60.1570024596844;
        Wed, 02 Oct 2019 06:56:36 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l48sm12781869qtb.50.2019.10.02.06.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 06:56:36 -0700 (PDT)
Date:   Wed, 2 Oct 2019 09:56:34 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com,
        fstests <fstests@vger.kernel.org>, Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH] btrfs/194: add a test for multi-subvolume fsyncing
Message-ID: <20191002135633.qeurdguga57r4mza@MacBook-Pro-91.local>
References: <20191001200551.1513-1-josef@toxicpanda.com>
 <CAL3q7H4CD8A+WjQbeT=MZ_k7ibiT9fe_+NvPpQ2m2=+99Mt9FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4CD8A+WjQbeT=MZ_k7ibiT9fe_+NvPpQ2m2=+99Mt9FQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 02, 2019 at 11:22:40AM +0100, Filipe Manana wrote:
> On Wed, Oct 2, 2019 at 5:29 AM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > From: Josef Bacik <jbacik@fb.com>
> >
> > I discovered a problem in btrfs where we'd end up pointing at a block we
> > hadn't written out yet.  This is triggered by a race when two different
> > files on two different subvolumes fsync.  This test exercises this path
> > with dm-log-writes, and then replays the log at every FUA to verify the
> > file system is still mountable and the log is replayable.
> 
> Please mention in the changelog, or in the test's description, the
> subject of the patch that fixes the problem.
> Otherwise people running the test and seeing failures will have a hard
> time figuring things out (think of QA teams
> for example, or anyone some weeks or months after, where context is
> lost and mailing list search is not that great).
> 
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  tests/btrfs/194     | 102 ++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/194.out |   2 +
> >  tests/btrfs/group   |   1 +
> >  3 files changed, 105 insertions(+)
> >  create mode 100755 tests/btrfs/194
> >  create mode 100644 tests/btrfs/194.out
> >
> > diff --git a/tests/btrfs/194 b/tests/btrfs/194
> > new file mode 100755
> > index 00000000..d5edb313
> > --- /dev/null
> > +++ b/tests/btrfs/194
> > @@ -0,0 +1,102 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2019 Facebook.  All Rights Reserved.
> > +#
> > +# FS QA Test 194
> > +#
> > +# Test multi subvolume fsync to test a bug where we'd end up pointing at a block
> > +# we haven't written.
> > +#
> > +# Will do log replay and check the filesystem.
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +fio_config=$tmp.fio
> 
> This isn't used anywhere.
> 
> > +status=1       # failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +       cd /
> > +       $KILLALL_PROG -KILL -q $FSSTRESS_PROG &> /dev/null
> 
> This line can go away, the test doesn't use fsstress.
> 
> > +       _log_writes_cleanup &> /dev/null
> > +       _dmthin_cleanup
> > +       rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +. ./common/dmthin
> > +. ./common/dmlogwrites
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs generic
> > +_supported_os Linux
> > +
> > +# Use thin device as replay device, which requires $SCRATCH_DEV
> > +_require_scratch_nocheck
> > +# and we need extra device as log device
> > +_require_log_writes
> > +_require_dm_target thin-pool
> > +
> > +_require_fio
> 
> All existing tests I could see, do "_require_fio $fio_config", where
> $fio_config is not empty.
> 

Yeah you can pass in a config or not, if you don't it just checks to make sure
you have fio available.  I originally intended to do a config, but just went
with the commandline since it's easier to do the individual files and I'm not
using any esoteric fio options.

<snip>

> 
> Other than that it looks fine to me.
> 
> However, on a VM with 8Gb of ram, I can't run the test:
> 
> root 11:09:10 /home/fdmanana/git/hub/xfstests (master)> ./check btrfs/194
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 debian5 5.3.0-rc8-btrfs-next-58 #1 SMP
> Tue Sep 17 18:18:55 WEST 2019
> MKFS_OPTIONS  -- /dev/sdc
> MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
> btrfs/194 [failed, exit status 137]- output mismatch (see
> /home/fdmanana/git/hub/xfstests/results//btrfs/194.out.bad)
>     --- tests/btrfs/194.out 2019-10-02 10:51:45.485575789 +0100
>     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/194.out.bad
> 2019-10-02 11:12:11.382533722 +0100
>     @@ -1,2 +1,2 @@
>      QA output created by 194
>     -Silence is golden
>     +./check: line 513:  1324 Killed                  bash -c "test -w
> ${OOM_SCORE_ADJ} && echo 250 > ${OOM_SCORE_ADJ}; exec ./$seq"
>     ...
>     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/194.out
> /home/fdmanana/git/hub/xfstests/results//btrfs/194.out.bad'  to see
> the entire diff)
> Ran: btrfs/194
> Failures: btrfs/194
> Failed 1 of 1 tests
> 
> root 11:12:22 /home/fdmanana/git/hub/xfstests (master)> cat
> /home/fdmanana/git/hub/xfstests/results//btrfs/194.out.bad
> QA output created by 194
> ./check: line 513:  1324 Killed                  bash -c "test -w
> ${OOM_SCORE_ADJ} && echo 250 > ${OOM_SCORE_ADJ}; exec ./$seq"
> root 11:19:39 /home/fdmanana/git/hub/xfstests (master)>
> 
> 
> 8Gb is a very reasonable amount of ram. This is on a debug kernel
> (kmemleak, kasan, debug_pagealloc, etc, enabled). Not uncommon among
> developers at least (even 4Gb of ram is common).

Huh that's weird.  Do you know what step of the test OOM'ed?  Nothing we're
doing here should be using that much memory.  Thanks,

Josef
