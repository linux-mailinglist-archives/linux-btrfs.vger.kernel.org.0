Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A412C287D6C
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Oct 2020 22:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgJHUtA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Oct 2020 16:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbgJHUtA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Oct 2020 16:49:00 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8849DC0613D2
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Oct 2020 13:48:58 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id b10so1537181qvf.0
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Oct 2020 13:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CJsW2HNeFY3hLrAnLA0BSUbdf2UCbM/C1bVGrZo+xgs=;
        b=qCO/brThB7B3K0emC0fvrTvbDFv9UrOk2AFdakiWAjd0youZm5qvoLkgXbFWL0/n8R
         JG2XIXjzKsYA/ir2Q+Au5rK17feYjF6p2dP2j4tWUAdFgrIwxCrvsk1Vc2uAdp7nim5t
         IDdRBEzKYUoVITngi9Jfe6PH2duZ+i+LXkdw6GcmnI7nufvZ+fZBLN4ecXcRPZHbEpHp
         2stU54tj+lo93odpKkrF6Xwq382iyBjV2j7/+xhvr0kz/hQyqYBOzllaqks55QAVE54k
         ZG3ZtqJqPIJhq500GpcLgUneQI+wnovgwaiPOC/FNZ7but6XdzS+rthNmosIPdMv+CCj
         ARfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CJsW2HNeFY3hLrAnLA0BSUbdf2UCbM/C1bVGrZo+xgs=;
        b=NYFvubQirGlaeZJ0+0c/uxuX6vGMU147DZd7ixJXU07f5xsuSWT6MdIuAVQY+VpQ8K
         oPAIJXIoqFWp68YZVFhDEnQHc0bphCzZUW7hgLrk/YcXfMYBx8f6ANxQViS5InBwlQ2f
         jOg3+wBPF550KbO2eVSjupzzLh19XX6v8A/vnPsQ/iVzaKpMc89fSbwZI5RhzKsQ7VbK
         XKAoQBno/bZdOzfbvQw9p3ro9ENFSp5MSB0V20FZ7QLch75VobAD7vfuZElIXNEvQW24
         /WdB6fXEo7pA4aSeQyysqNMzgbx3J0zbk8806P9iwuioAAc9kRNpvynIdesskEB4pF82
         nCFQ==
X-Gm-Message-State: AOAM5310LdPblY0BZxq8jtZNIO5uUkoKJLnFA5V7Hh3QtkSV+3a+rZai
        tBIwGNgQH70MIml5e/UUyg7DXwat9r5+aVwh
X-Google-Smtp-Source: ABdhPJyA5br52T5JSbM49wLYiJ0Xr6wGAIgqs49D9yPCeQs3xgywCTS2yeEu0ayV+OnN4CohqJtqHA==
X-Received: by 2002:a0c:b657:: with SMTP id q23mr10137579qvf.47.1602190137308;
        Thu, 08 Oct 2020 13:48:57 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 7sm4673521qkc.73.2020.10.08.13.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:48:56 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 00/11] Improve preemptive ENOSPC flushing
Date:   Thu,  8 Oct 2020 16:48:44 -0400
Message-Id: <cover.1602189832.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's a lot of individual changes, but most of it revolves around fixing the
O_DIRECT regression that Nikolay noted.  With this set of patches we get
slightly better performance in the buffered case than before, and the O_DIRECT
case is slightly improved from baseline as well.

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

Josef Bacik (11):
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
 fs/btrfs/space-info.c        | 269 +++++++++++++++++++++++++++++------
 fs/btrfs/space-info.h        |   3 +
 include/trace/events/btrfs.h | 104 +++++++++++++-
 6 files changed, 341 insertions(+), 61 deletions(-)

-- 
2.26.2

