Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1861F47191
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jun 2019 20:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfFOSZB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jun 2019 14:25:01 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33586 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfFOSZA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jun 2019 14:25:00 -0400
Received: by mail-qt1-f194.google.com with SMTP id x2so6388565qtr.0;
        Sat, 15 Jun 2019 11:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=oPwR6up+4VWQ3T9cWYQSGpPmrQDg38fErMyiBrwhRvI=;
        b=CF7AS0QLYz8GXNUSsfGV7wFlTdL/NCb7tKm9zDrdzArufdZQ7wWrTtFhAAyrXmpVpm
         P+EB83po2r7c7hJ+T6gm01QNYZP1Q2F3Bf5t8vRhx2e6sRqx9ujXJzbGkUzN23dSYzW2
         qxSnxJ+tkiXwqQ/uYPyxVbAjZg5vauVJq3a05Wb+bGa+bfFmhzGEaJQgRKp3SXnjpZhn
         yFbnnB3O5qvB9f0UpHo200UvorEv8Q6mJZtcuBnMxwN5rEbXoinhi40qUzq8V6mvGjr6
         6vjTS82YCx1oqRBw4eWuVDIktHHGGGQ7EPzCSh01BPn+xHxj4UR5iSL23GSWe5drYcJi
         R9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=oPwR6up+4VWQ3T9cWYQSGpPmrQDg38fErMyiBrwhRvI=;
        b=Hu6DbXQLsb2Jq2ys5GAhhqvgFDbjWlF5v1l0hMMAEiFPhz7DqYdfc9Mpun5oDYy1Fn
         QVPNSd0ApqwlXIjpbT6l1xmm79rsJ1+iFUkwUe88w6f3szDDn6NAVdFsXM573tmM4Khv
         5I5SjBOf2fYvRamgxPRNKUpBc4XZNIMp4er/ZK9oOZ3kVpygCnjEisdBybHKfMLjvIDh
         ll15j8x1Ywfd9+Li/GtPUBX/6GHbF3ljuhU4DKFwxB9NDlhMyUOorPnajjoqguCP2jpu
         jeUyPc9FhoZxlHbF9fmff0qVPbmkCoPqyTeZ4fkt3nWcYAXRjEBdo2PwAqlm+3cUnz08
         +40g==
X-Gm-Message-State: APjAAAVUQxhWuKZaEQP39ls8TtrKgOlyMAU9sYDgX2GwgGbNImNMCzqU
        tzUgw9lZs8OxP4xrgtTWIdg=
X-Google-Smtp-Source: APXvYqwI4HIehwRMwlm4ezs+Grdjp8PxAnEo5D0ptx3hhzj66wjWvzJYNlbUe3JQkYl3IWEbLzx6XA==
X-Received: by 2002:a0c:929b:: with SMTP id b27mr13854026qvb.193.1560623099420;
        Sat, 15 Jun 2019 11:24:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4883])
        by smtp.gmail.com with ESMTPSA id s23sm4843521qtj.56.2019.06.15.11.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 11:24:57 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: [PATCHSET v2 btrfs/for-next] blkcg, btrfs: fix cgroup writeback support
Date:   Sat, 15 Jun 2019 11:24:44 -0700
Message-Id: <20190615182453.843275-1-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Changes from v1[1]

  * 0001-cgroup-blkcg-Prepare-some-symbols-for-module-and-CON.patch
    added.  It collects and adds symbol exports and dummy function def
    to fix module and different config builds.

When writeback is executed asynchronously (e.g. for compression), bios
are bounced to and issued by worker pool shared by all cgroups.  This
leads to significant priority inversions when cgroup IO control is in
use - IOs for a low priority cgroup can tie down the workers forcing
higher priority IOs to wait behind them.

This patchset adds an bio punt mechanism to blkcg and updates btrfs to
issue async IOs through it.  A bio tagged with REQ_CGROUP_PUNT flag is
bounced to the asynchronous issue context of the associated blkcg on
bio_submit().  As the bios are issued from per-blkcg work items,
there's no concern for priority inversions and it doesn't require
invasive changes to the filesystems.  The mechanism should be
generally useful for IO control support across different filesystems.

This patchset contains the following 9 patches.  The first three are
my blkcg patches to implement the needed mechanisms.  The latter five
are Chris Mason's btrfs cleanup and update patches.  Please let me
know how the patches should be routed.  Given that there currently
aren't other users, it's likely the easiest to route all through btrfs
tree.

 0001-cgroup-blkcg-Prepare-some-symbols-for-module-and-CON.patch
 0002-blkcg-writeback-Add-wbc-no_wbc_acct.patch
 0003-blkcg-writeback-Implement-wbc_blkcg_css.patch
 0004-blkcg-implement-REQ_CGROUP_PUNT.patch
 0005-Btrfs-stop-using-btrfs_schedule_bio.patch
 0006-Btrfs-delete-the-entire-async-bio-submission-framewo.patch
 0007-Btrfs-only-associate-the-locked-page-with-one-async_.patch
 0008-Btrfs-use-REQ_CGROUP_PUNT-for-worker-thread-submitte.patch
 0009-Btrfs-extent_write_locked_range-should-attach-inode-.patch

0001-0003 implement wbc->no_wbc_acct, wbc_blkcg_css() and
REQ_CGROUP_PUNT.

0004-0007 are prep patches to simplify / improve async bio submission.

0008 makes btrfs use REQ_CGROUP_PUNT for async bios.

0009 fixes wbc writeback accounting for IOs issued through
extent_write_locked_range().

This patchset is also available in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-btrfs-cgroup-updates-v2

Thanks, diffstat follows.

 block/blk-cgroup.c          |   54 +++++++++
 block/blk-core.c            |    3 
 fs/btrfs/compression.c      |   16 +-
 fs/btrfs/compression.h      |    3 
 fs/btrfs/ctree.h            |    1 
 fs/btrfs/disk-io.c          |   25 +---
 fs/btrfs/extent_io.c        |   15 +-
 fs/btrfs/inode.c            |   61 ++++++++--
 fs/btrfs/super.c            |    1 
 fs/btrfs/volumes.c          |  264 --------------------------------------------
 fs/btrfs/volumes.h          |   10 -
 fs/fs-writeback.c           |    5 
 include/linux/backing-dev.h |    1 
 include/linux/blk-cgroup.h  |   16 ++
 include/linux/blk_types.h   |   10 +
 include/linux/cgroup.h      |    1 
 include/linux/writeback.h   |   24 +++-
 17 files changed, 198 insertions(+), 312 deletions(-)

--
tejun

[1] http://lkml.kernel.org/r/20190614003350.1178444-1-tj@kernel.org

