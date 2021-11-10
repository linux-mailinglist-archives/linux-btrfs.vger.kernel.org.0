Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE2744CA4D
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhKJURe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbhKJURe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:17:34 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E24C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:14:46 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id 132so3651188qkj.11
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O2dnJOu1hN2/6TiXOdOCJOJuynCGVWx5XKobWX5e8q0=;
        b=AtCUg/YhK0RxZJaLKjRHSqoMbPiJDQmvB+tRHOruVPF7OOA9z6OHO7/sNUL94JeIao
         7efIbBh6nup1A7AbvN9ZlBnC3C8Gb1VFM7BDf8KyIuB+5fsaDDad82V5sz3uhRet4YlU
         Qi4igS0+fHO2TuFh7e5zOfdgv25iyIYsYdDbMh/xjcArmSMB4/stVwt7SLWWqzXycnis
         SOrugiEWMysz0xyk1I72JMgI9Ohjj16zk0DMBsNpG/ubfk3B5qd2NbM67+BY9pK44szk
         2zkr7gpKvQ52k0ZGw+0XC+zAopd6+XxAjF9k3BzViSJCdQZAb3e4kSkXDfYNeutFf/gr
         mjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O2dnJOu1hN2/6TiXOdOCJOJuynCGVWx5XKobWX5e8q0=;
        b=G9dK/nZaedInQrN8+egweqcpvoAbFRlxuCSVEN3s2CXPxBJUDmVl6MdL+NgAsRXgel
         oqKEDSYQaMRR2KCkiy9SmaY5zf0pbo2kegbkftjMwimu9MAcIEfEQcYgueev4/9eIsOs
         j4ZDGjincHv6lt101o7fGp6zvxwN9nx9M7kSSbM6cJNWu1naVQdaQMHYj/XdyYU0lOYz
         QqsNze/3c1zBGrpX4ESE1HF3B5iM66AZ9cs5CgUlQq5aw7PgNMXvqGnuGnqSEm6KJTw9
         aTmseFwaXRYQneM5q+Rt/vx5OvKzn8RheMuMOnfLlBmZ2eyq6iALqhBwCcVqd/7X99GC
         m43Q==
X-Gm-Message-State: AOAM531OYv5EONQ6U7jo9vTNMzh2N7VaAb9DEnzrhZFPckuyhPHQy8wN
        VwHt1uTfhxZlZ9ZWi82x4HOjYn4Tuw5niw==
X-Google-Smtp-Source: ABdhPJzWDBdVFJumn7CCZiIDhl4dcxRRRI6RG0lpSzj0h1RUoOa6jgiEgjvwtsiJEIOhjJNpxF4wYQ==
X-Received: by 2002:a37:b7c6:: with SMTP id h189mr1686637qkf.377.1636575285156;
        Wed, 10 Nov 2021 12:14:45 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 9sm350845qkm.5.2021.11.10.12.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:14:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 00/30] btrfs-progs: extent tree v2 support, global roots
Date:   Wed, 10 Nov 2021 15:14:12 -0500
Message-Id: <cover.1636575146.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- These depend on the v3 of the prep patches (it's marked as v2 because I'm
  stupid, but the second v2 posting I sent.)
- I've moved the global root rb tree patches into this series to differentiate
  them from the actual fixes in the prep series.

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

Josef Bacik (30):
  btrfs-progs: stop accessing ->extent_root directly
  btrfs-progs: stop accessing ->free_space_root directly
  btrfs-progs: track csum, extent, and free space trees in a rb tree
  btrfs-progs: check: make reinit work per found root item
  btrfs-progs: check: check the global roots for uptodate root nodes
  btrfs-progs: check: check all of the csum roots
  btrfs-progs: check: fill csum root from all extent roots
  btrfs-progs: common: search all extent roots for marking used space
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

 btrfs-corrupt-block.c           |  13 +-
 btrfs-map-logical.c             |   9 +-
 btrfstune.c                     |   2 +-
 check/main.c                    | 429 ++++++++++++++++---------
 check/mode-common.c             |   8 +-
 check/mode-lowmem.c             |  76 +++--
 check/qgroup-verify.c           |  34 +-
 cmds/inspect-dump-tree.c        |  37 ++-
 cmds/rescue-chunk-recover.c     |  18 +-
 common/fsfeatures.c             |  11 +
 common/repair.c                 | 146 ++++++---
 common/repair.h                 |   2 +
 convert/main.c                  |   4 +-
 image/main.c                    |   2 +-
 kernel-shared/backref.c         |  10 +-
 kernel-shared/ctree.h           |  70 +++-
 kernel-shared/disk-io.c         | 553 ++++++++++++++++++++++++++------
 kernel-shared/disk-io.h         |  19 +-
 kernel-shared/extent-tree.c     |  66 ++--
 kernel-shared/free-space-tree.c | 124 ++++---
 kernel-shared/print-tree.c      |  26 +-
 kernel-shared/transaction.c     |   2 +
 kernel-shared/volumes.c         |   3 +-
 kernel-shared/zoned.c           |   2 +-
 libbtrfsutil/btrfs_tree.h       |   3 +
 mkfs/common.c                   |  93 ++++--
 mkfs/common.h                   |  12 +
 mkfs/main.c                     | 122 ++++++-
 28 files changed, 1411 insertions(+), 485 deletions(-)

-- 
2.26.3

