Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B2C27F2DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 22:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbgI3UB2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 16:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3UBX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 16:01:23 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728CFC061755
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 13:01:23 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id cv8so1587226qvb.12
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 13:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AH5DqfyEhc3MonPdOsb0rwI2Lsi4rhZttAOKU/gSsP4=;
        b=ZutRR2c57QDOxg9bzlTrPR5bAC8MEhuwEOtTfCrGSN1LfNclgPyOuyrzgyEi8wE6uR
         Wdf4SzwExHCLTA++wGC+2LhMBDUUrHJQKje2G7jE/mSbOyNYzQtQvtXVXwP4XJg0RZ1Z
         4DpRdEjT7eubyYHHjp92wODZ95VoOOmlhErZLd1mRIv0nTontZB6MGhskBkgCxY5J/Kw
         A/YTLcuzR3cKWiLwCV42ARVqS8VrQiK5QmOHv9Gs01vt4sx09ZFivzmCdJ5bNvbH0DB0
         gcFgQzuuxsdZtxXljrF/QT3m6BsJasS9udTg1xa+xsPHF58e83XNDBHQpy3MpEQtaBmE
         AvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AH5DqfyEhc3MonPdOsb0rwI2Lsi4rhZttAOKU/gSsP4=;
        b=rNH37j5kjlNSbEBAaOkPME96fiyawqS5YLbGh0ml3UhXtwlXuwt26npt+dEufotvUA
         HbETi36Y29A34rdz4fvguB3UA0ZuBuCiWN0I9ws6+6kGd74UKJwY0Gd15jX6SUhH1VSZ
         JmVbSaJE553fAJI81Nf3UvtdcqwIfyRrOnAoByGajk/u7QMJD58sp0g4lanixWZ9JQMX
         exnUUIN8rZfa34pj0CxRuJZg2iQPX0aQtwUIjWeQ9VHTlCqRAie2Bksrr+35CLZlvFM6
         vX2Du1nTaa09VxncygWFY4oDsRcugxw6SMofQ158f19yEWBTbdLrzOO8jPwgqHlJyglI
         zS2A==
X-Gm-Message-State: AOAM531E4Uhm0cFh0lY+F6mGu7DT+dhitH3HI/y6MHW9iDrwby0V5YZw
        jfRE3FTWAJ1ITFBJPip0QeWGgyXqFAyuRZnF
X-Google-Smtp-Source: ABdhPJxNchRFOz0HfVSQdLGny0eaIn/yNrnABoMlRN7HniDpgEjynqElCU40HvAPK7wgt3cJYkqeJw==
X-Received: by 2002:a0c:bec4:: with SMTP id f4mr4328457qvj.14.1601496082274;
        Wed, 30 Sep 2020 13:01:22 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s10sm3403637qkg.61.2020.09.30.13.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 13:01:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/9] Improve preemptive ENOSPC flushing
Date:   Wed, 30 Sep 2020 16:01:00 -0400
Message-Id: <cover.1601495426.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

A while ago Nikolay started digging into a problem where they were seeing an
around 20% regression on random writes, and he bisected it down to

  btrfs: don't end the transaction for delayed refs in throttle

However this wasn't actually the cause of the problem.

This patch removed the code that would preemptively end the transactions if we
were low on space.  Because we had just introduced the ticketing code, this was
no longer necessary and was causing a lot of transaction commits.

And in Nikolay's testing he validated this, we would see like 100x more
transaction commits without that patch than with it, but the write regression
clearly appeared when this patch was applied.

The root cause of this is that the transaction commits were essentially
happening so quickly that we didn't end up needing to wait on space in the
ENOSPC ticketing code as much, and thus were able to write pretty quickly.  With
this gone, we now were getting a sawtoothy sort of behavior where we'd run up,
stop while we flushed metadata space, run some more, stop again etc.

When I implemented the ticketing infrastructure, I was trying to get us out of
excessively flushing space because we would sometimes over create block groups,
and thus short circuited flushing if we no longer had tickets.  This had the
side effect of breaking the preemptive flushing code, where we attempted to
flush space in the background before we were forced to wait for space.

Enter this patchset.  We still have some of this preemption logic sprinkled
everywhere, so I've separated it out of the normal ticketed flushing code, and
made preemptive flushing it's own thing.

The preemptive flushing logic is more specialized than the standard flushing
logic.  It attempts to flush in whichever pool has the highest usage.  This
means that if most of our space is tied up in pinned extents, we'll commit the
transaction.  If most of the space is tied up in delalloc, we'll flush delalloc,
etc.

To test this out I used the fio job that Nikolay used, this needs to be adjusted
so the overall IO size is at least 2x the RAM size for the box you are testing

fio --direct=0 --ioengine=sync --thread --directory=/mnt/test --invalidate=1 \
        --group_reporting=1 --runtime=300 --fallocate=none --ramp_time=10 \
        --name=RandomWrites-async-64512-4k-4 --new_group --rw=randwrite \
        --size=2g --numjobs=4 --bs=4k --fsync_on_close=0 --end_fsync=0 \
        --filename_format=FioWorkloads.\$jobnum

I got the following results

misc-next:	bw=13.4MiB/s (14.0MB/s), 13.4MiB/s-13.4MiB/s (14.0MB/s-14.0MB/s), io=4015MiB (4210MB), run=300323-300323msec
pre-throttling:	bw=16.9MiB/s (17.7MB/s), 16.9MiB/s-16.9MiB/s (17.7MB/s-17.7MB/s), io=5068MiB (5314MB), run=300069-300069msec
my patches:	bw=18.0MiB/s (18.9MB/s), 18.0MiB/s-18.0MiB/s (18.9MB/s-18.9MB/s), io=5403MiB (5666MB), run=300001-300001msec

Thanks,

Josef

Josef Bacik (9):
  btrfs: add a trace point for reserve tickets
  btrfs: improve preemptive background space flushing
  btrfs: rename need_do_async_reclaim
  btrfs: check reclaim_size in need_preemptive_reclaim
  btrfs: rework btrfs_calc_reclaim_metadata_size
  btrfs: simplify the logic in need_preemptive_flushing
  btrfs: implement space clamping for preemptive flushing
  btrfs: adjust the flush trace point to include the source
  btrfs: add a trace class for dumping the current ENOSPC state

 fs/btrfs/ctree.h             |   1 +
 fs/btrfs/disk-io.c           |   1 +
 fs/btrfs/space-info.c        | 216 +++++++++++++++++++++++++++++------
 fs/btrfs/space-info.h        |   3 +
 include/trace/events/btrfs.h | 112 +++++++++++++++++-
 5 files changed, 292 insertions(+), 41 deletions(-)

-- 
2.26.2

