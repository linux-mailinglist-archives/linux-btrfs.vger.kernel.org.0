Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B69E3057E3
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 11:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S314401AbhAZXHO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 18:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbhAZVZT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 16:25:19 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5862EC06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:39 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id t17so13402461qtq.2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YCSLsrCGcLK60HYK4y/SbTRBm0O6W+vxIjKDXSSDrfk=;
        b=bWXWmLreoYVguUK8H3DW0k2cJIIISeFvlL1sFVmWG+tS+BbZ9DFXfKdqv2351Exyr3
         p/bsAGj/PpO0SAeYgWlMzmvLYLfH1ZbXF0QYnc0lIhalaqKs0jGnmfXA10xt457+QGhz
         2VaTsdvmEj0Ca1FxUHhASUjdzJDqbf37evM1gpURLfizq1LpBTnnUQthN3ro3hlsSeR1
         UyKTHPgDnAjxJr149mXEl/wpefwk/rYBrRnJ+AWaq4vHmo2VyUZsZAsFhr///S8v7fkr
         dff5K5jXghSpSqPw8Z2WboSdvPMMl00tXq20OKRVfUvsgog07QVgWidFdAWJoKX72ihK
         W/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YCSLsrCGcLK60HYK4y/SbTRBm0O6W+vxIjKDXSSDrfk=;
        b=pyECRVzb8lW67VIQAyVmnZqtf7CQEXeAfTDNXuCC6x35Jah43FttvyZcvjWdxtAGnf
         b5FgSevBt352tQjWGF4BrE46mpRT9JsjmHNr7hAgOmUcAiZsmz7CkfyJJ8sikO4U+0eg
         vxNC1MHbxDGSBWPbpdet5qf+mAqFqStfOExRQvj8DYlGz3nYApFMOs2zArHwEIylcIa+
         0UFm6jY9ZP4IOgyaqUaGul/dimXYOnj2FCyJt+UqDeiSNTTk7HZe/FcRT776IPFhhilU
         M+dqSwRrySn4CIJemBF9HM/ShMhIfPLZVki6EiQ6p1II717TSvdBTDk/NmRw62QEJaEx
         m9nw==
X-Gm-Message-State: AOAM533z2YV3qkG8scL/6gQZxoTuzKiZjd4O84HduMZ8amBNt9f0nhDW
        E/9dxoMTru++Y1cxL7JvzyHZp46tzsVWPUsn
X-Google-Smtp-Source: ABdhPJyL4MjKTyZdzGcgMY0hNIG/SxgTjJVR6xvkVj/jI33Ps0pJ9KWrZbtPBJL2hAHLELdbEFr39g==
X-Received: by 2002:ac8:6b50:: with SMTP id x16mr7221305qts.254.1611696278104;
        Tue, 26 Jan 2021 13:24:38 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o20sm14430208qki.93.2021.01.26.13.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 13:24:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 00/12] Improve preemptive ENOSPC flushing
Date:   Tue, 26 Jan 2021 16:24:24 -0500
Message-Id: <cover.1611695838.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v3->v4:
- Added some comments.
- Updated the tracepoint for the preemptive flushing to take a bool instead of
  an int.
- Removed 'inline' from need_preemptive_flushing.

v2->v3:
- Added a cleanup to make sure we pass the right enum around for flush_space().
- Fixed a problem reported by a clang build where I used the wrong enum in the
  preemptive flushing for flush_space().
- Fixed up some nits pointed out by Nikolay.

v1->v2:
- Added a FORCE_COMMIT_TRANS flush operation so we can keep the flush_space
  stuff consistent and get all the normal tracepoints.
- Renamed fs_info->dio_bytes to ->ordered_bytes and changed it to count all
  ordered extents that were pending, not just DIO ordered extents that were
  pending.
- Reworked the clamping to not apply if we're not doing a lot of delalloc
  reservations.
- Reworked the preempt flushing loop to be more straightforward.
- Fixed the need_preemptive_flushing() helper to take into account DIO heavy
  workloads.

--- Original email ---

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

misc-next: bw=13.4MiB/s (14.0MB/s), 13.4MiB/s-13.4MiB/s (14.0MB/s-14.0MB/s), io=4015MiB (4210MB), run=300323-300323msec
pre-throttling: bw=16.9MiB/s (17.7MB/s), 16.9MiB/s-16.9MiB/s (17.7MB/s-17.7MB/s), io=5068MiB (5314MB), run=300069-300069msec
my patches: bw=18.0MiB/s (18.9MB/s), 18.0MiB/s-18.0MiB/s (18.9MB/s-18.9MB/s), io=5403MiB (5666MB), run=300001-300001msec

Thanks,

Josef

Josef Bacik (12):
  btrfs: make flush_space take a enum btrfs_flush_state instead of int
  btrfs: add a trace point for reserve tickets
  btrfs: track ordered bytes instead of just dio ordered bytes
  btrfs: introduce a FORCE_COMMIT_TRANS flush operation
  btrfs: improve preemptive background space flushing
  btrfs: rename need_do_async_reclaim
  btrfs: check reclaim_size in need_preemptive_reclaim
  btrfs: rework btrfs_calc_reclaim_metadata_size
  btrfs: simplify the logic in need_preemptive_flushing
  btrfs: implement space clamping for preemptive flushing
  btrfs: adjust the flush trace point to include the source
  btrfs: add a trace class for dumping the current ENOSPC state

 fs/btrfs/ctree.h             |   4 +-
 fs/btrfs/disk-io.c           |   9 +-
 fs/btrfs/ordered-data.c      |  13 +-
 fs/btrfs/space-info.c        | 295 +++++++++++++++++++++++++++++------
 fs/btrfs/space-info.h        |   4 +
 include/trace/events/btrfs.h | 104 +++++++++++-
 6 files changed, 362 insertions(+), 67 deletions(-)

-- 
2.26.2

