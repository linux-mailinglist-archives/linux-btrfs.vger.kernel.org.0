Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1AD2889C0
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 15:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388470AbgJIN2d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 09:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbgJIN2d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 09:28:33 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC055C0613D2
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 06:28:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d1so7886389qtr.6
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 06:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OmmUJmZ43vDu0bZ5OVGmC9yaiq+Qsbq43RHjdwm0sBs=;
        b=HoHeKH4/g2R4ZP0bgx6uboB+f6cozhN0xiPR1tmpPxjlIxbWc/BiG2YLBorwLGAHk3
         o/0eGw4FYc4RXRyRkgflPXAq/DccLke26xneAQq7a501CAj1FyGsPmwiYsT4s6ppKf4p
         4IBfIGaXdo0EdlAIYIGRlsYFCJqp960fdtm/lJHlk7y7z4NuJ+l0LNrkhI04u+5SDTb9
         ZKiZbNu9t7MIsmQ8gey0vlXrImf6ucGyElnwu3SAn4i2+RCpLHLFe+e8DPorKwkhzYQu
         y/qP3toHdNL+zy25pfIT2GQMjB7141LRCE/p/Fi15qDnguiGjl6LxcqIoDxcUKtzGy6L
         rMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OmmUJmZ43vDu0bZ5OVGmC9yaiq+Qsbq43RHjdwm0sBs=;
        b=iE68IzRC0tUX/9+kTjnjgeCmVy9I/bald6kSQUnvY2gHLfngerQn/017PHF9Gg1p9P
         KQc5dVo8ej95kmGKwcW1a0Uxb/lQSpo/k1a6sjhOHUmOcCvXUdFEwVPGxqI2/kAwIDPf
         UimZYvhRkrNe1ynXMCCByIcdk5qP1ZBb6xqvNUXrXaCIX/ulKs3Jjk3JBe0NSDjGlgmD
         2GejCPnIZWN68szH5NQPDNs5SHU032JSNw4OXnnz6j78dA0C1sB+kuOZf8TGtK0GPcNA
         RDR7Wn4x+7LIehNku4WxpYewO9OMSMr4gAg4mLIs72aLAhi7Whf2xuL6q7l+YbrY7j7C
         EiWA==
X-Gm-Message-State: AOAM531y9ASjfsTLx7pvNPuh41+dbyi7XG0CbZ2iMGE0eHX1sID4vCcP
        yivYJDQpx/Es6YusE1dwQ05k5FhWTSbNj3Xq
X-Google-Smtp-Source: ABdhPJydFB2nj7Y3g0zxY2NXRuco2qI5nNRQdNxgydX8VYHVTL4Kf8W1d/4vkgbV45jCVx/aTpdf6g==
X-Received: by 2002:ac8:3165:: with SMTP id h34mr13496040qtb.87.1602250111624;
        Fri, 09 Oct 2020 06:28:31 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o4sm5967507qkj.22.2020.10.09.06.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 06:28:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 00/12] Improve preemptive ENOSPC flushing
Date:   Fri,  9 Oct 2020 09:28:17 -0400
Message-Id: <cover.1602249928.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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

misc-next:Josefbw=13.4MiB/s (14.0MB/s), 13.4MiB/s-13.4MiB/s (14.0MB/s-14.0MB/s), io=4015MiB (4210MB), run=300323-300323msec
pre-throttling:Josefbw=16.9MiB/s (17.7MB/s), 16.9MiB/s-16.9MiB/s (17.7MB/s-17.7MB/s), io=5068MiB (5314MB), run=300069-300069msec
my patches:Josefbw=18.0MiB/s (18.9MB/s), 18.0MiB/s-18.0MiB/s (18.9MB/s-18.9MB/s), io=5403MiB (5666MB), run=300001-300001msec

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
 fs/btrfs/space-info.c        | 274 ++++++++++++++++++++++++++++-------
 fs/btrfs/space-info.h        |   3 +
 include/trace/events/btrfs.h | 104 ++++++++++++-
 6 files changed, 340 insertions(+), 67 deletions(-)

-- 
2.26.2

