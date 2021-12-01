Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9F8465515
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352215AbhLASUp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351967AbhLASUk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:20:40 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41280C061574
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:17:19 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id q14so24930920qtx.10
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XH/Wy26ppFCa/QH3KrXgRAB3dEhTeKGQy/L9b1y1B5g=;
        b=bdXeLBJmxMsRcW07Z9GCTs3gTAJ4sTEBZgBa4loAh+0GefDz0PQ989WlaYEG0l2RlP
         SOi8/QC2rMcq1WmsvE6uV7iXRGPFwmLS89k6sHZMCr1AxKzCq9ajVt0z2zqiGKH5yAvw
         2SWZKSN55Ry6GUfO7oWzc1kwQwHreGHFQ//JmOoJuLJP+aP0h1BjyCff4P3DxD8rn8y9
         pLmXirOQ5lQx8AZxF5ndeyAHNTOwx/UXrtl0NhyvW7RerN6H78K6PvGfxBNnMaXxDQdM
         CEJTNhKUBU4jbk9nkIg24nTD3cYHFvN6pIldmo5KrDGQvUWwhNk6V5Vt0P8JjVvrnXny
         4HQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XH/Wy26ppFCa/QH3KrXgRAB3dEhTeKGQy/L9b1y1B5g=;
        b=3mk2Oh/w5WfCCja3JKS+nj6F7LpfgbD5WGI0n8NgRJXpN+cLJCYSpYTmb7AYbYq8up
         nvXZzCTj1uh2f1HYe7uHjz4i9JqHWV13R/8TQejTbQopiqMIEKPJ4M7R/qMIBhkolpQ+
         xmEUd+i5bh91vXDqKFnt7AKewlLj+mjM0r+HsQ8w8UVLeWkHmuaed7tpp7BtcXNED5A5
         1oTNLFs6WtpwlLvEnLpGnNPdHAeCcYObw7lpfeqqlnvIh8SYFhmdkYFsyoNZM1ZtzP6a
         MgsAa/fpNo6cmlDogI+b6iA8LnQfj9SD1dI8qJCuNP3c0GhWexi7RhGQnALqosGgRyKX
         IcXw==
X-Gm-Message-State: AOAM531w7OSQXSR/UkcsbVVBs4a0pirdba7T8lt2vOUZ/aDhwCbv5NCL
        V0Pk8Hvqwudam9E4wADtPBveV5BO3sS2eQ==
X-Google-Smtp-Source: ABdhPJzROTP2whQ71P7d2yaORd/SRArqx7K21ZJZi+daAmg16rq2mXD5Ql9mBurH9WuAG3nF5tFfqg==
X-Received: by 2002:ac8:5952:: with SMTP id 18mr8762209qtz.612.1638382637865;
        Wed, 01 Dec 2021 10:17:17 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 2sm230683qkr.126.2021.12.01.10.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:17:17 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 00/22]  btrfs-progs: extent tree v2 support, global roots
Date:   Wed,  1 Dec 2021 13:16:54 -0500
Message-Id: <cover.1638382588.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- Rebased onto origin/devel.

--- Original email ---
Hello,

These patches are the first chunk of the extent tree v2 format changes.  This
includes the separate block group root which will hold all of the block group
items.  This also includes the global root support, which is the work to allow
us to have multiple extent, csum, and free space trees in the same file system.

The goal of these two changes are straightforward.  For the block group root, on
very large file systems the block group items are very widely separated, which
means it takes a very long time to mount the file system on large, slow disks.
Putting the block group items in their own root will allow us to densely
populate the tree and dramatically increase mount times in these cases.

The global roots change is motivated by lock contention on the root nodes of
these global roots.  I've had to make many changes to how we run delayed refs to
speed up things like the transaction commit because of all the delayed refs
going into one tree and contending on the root node of the extent tree.  In the
same token you can have heavy lock contention on the csum roots when writing to
many files.  Allowing for multiple roots will let us spread the lock contention
load around.

I have disabled a few key features, namely balance and qgroups.  There will be
more to come as I make more and more invasive changes, and then they will slowly
be re-enabled as the work is added.  These are disabled to avoid a bunch of work
that would be thrown away by future changes.

These patches have passed xfstests without panicing, but clearly failing a lot
of tests because of the disabled features.  I've also run it through fsperf to
validate that there are no major performance regressions.

WARNING: there are many more format changes planned, this is just the first
batch.  If you want to test then please feel free, but know that the format is
still in flux.  Thanks,

Josef

Josef Bacik (22):
  btrfs-progs: common: allow users to select extent-tree-v2 option
  btrfs-progs: add definitions for the block group tree
  btrfs-progs: add on disk pointers to global tree ids
  btrfs-progs: add support for loading the block group root
  btrfs-progs: add print support for the block group tree
  btrfs-progs: mkfs: use the btrfs_block_group_root helper
  btrfs-progs: check-lowmem: use the btrfs_block_group_root helper
  btrfs-progs: handle no bg item in extent tree for free space tree
  btrfs-progs: mkfs: add support for the block group tree
  btrfs-progs: check: add block group tree support
  btrfs-progs: qgroup-verify: scan extents based on block groups
  btrfs-progs: check: make free space tree validation extent tree v2
    aware
  btrfs-progs: check: add helper to reinit the root based on a key
  btrfs-progs: check: handle the block group tree properly
  btrfs-progs: load the number of global roots into the fs_info
  btrfs-progs: handle the per-block group global root id
  btrfs-progs: add a btrfs_delete_and_free_root helper
  btrfs-progs: make btrfs_clear_free_space_tree extent tree v2 aware
  btrfs-progs: make btrfs_create_tree take a key for the root key
  btrfs-progs: mkfs: set chunk_item_objectid properly for extent tree v2
  btrfs-progs: mkfs: create the global root's
  btrfs-progs: check: don't do the root item check for extent tree v2

 check/main.c                    | 233 ++++++++++++++------------
 check/mode-lowmem.c             |  12 +-
 check/qgroup-verify.c           |  32 +++-
 cmds/inspect-dump-tree.c        |  37 +++-
 common/fsfeatures.c             |  11 ++
 common/repair.c                 |   3 +
 kernel-shared/ctree.h           |  66 +++++++-
 kernel-shared/disk-io.c         | 287 ++++++++++++++++++++++++++------
 kernel-shared/disk-io.h         |  15 +-
 kernel-shared/extent-tree.c     |  32 +++-
 kernel-shared/free-space-tree.c |  72 ++++----
 kernel-shared/print-tree.c      |  26 ++-
 kernel-shared/transaction.c     |   2 +
 libbtrfsutil/btrfs_tree.h       |   3 +
 mkfs/common.c                   |  93 ++++++++---
 mkfs/common.h                   |  12 ++
 mkfs/main.c                     |  96 ++++++++++-
 17 files changed, 791 insertions(+), 241 deletions(-)

-- 
2.26.3

