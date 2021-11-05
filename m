Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD42C4469F3
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhKEUsg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbhKEUsd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:48:33 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0734C061205
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:45:53 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id h14so8341201qtb.3
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W0zwHhZn6o4U6eFoPJCa7FCACOVUoX/au+3M/6sc2rI=;
        b=aPSicLBsrGmD6HRQqsQ3xiff2CwFAC26HR1ScfV5IXX6s6BTWBy/P0yop9FLp21L3Y
         6qsLJiEalep/nsmC4RCs3qx0bE5oX3MszqNyi5O+EohZxaLPjUikNNZfZNTZH29h09Ys
         oXggHrDK6WAsnnTYPbXqHQ6+O5A1JLjfT/kpTL0jhq8w+VmKOcNjtX6J2pzKSFDSRRq7
         SwAYIyKSk8Bc52DKCVGH8UWRJwYGeq8bIPT2dZVYi1Xta9z1sOBeJkxk14+LpTlYM069
         Zki9eMyl4+l6wbKh1aZAuRuu7YyL51G+XlpxYnDIMU6SRMaKvNCUOUGmIF+zKhZhPRFd
         BBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W0zwHhZn6o4U6eFoPJCa7FCACOVUoX/au+3M/6sc2rI=;
        b=Yo3SXfpQqIZz2rUdkpHMxqqdtpAKkgF4AMr2SwoniX7O4dBEmlveQbQ0tYrZAVyf7q
         Cc36nK7n8LFV93C1GtWXSuY7/HJOd0VHUl7z6OENxmM++eK+e0rsx35Dt/XbjYcyjdqP
         SvtBqoLOYhUDnZkbMaDIuyr+QxbFa9QKXB0gP79Oh5kfea5fz57IiEM53sNXjk2t0zO2
         xJTT7pbUSOIOs4Q0LXpJnYIiwLnaIGGAO/bmjz5b6q4aL+jLc4zgoTcVUVinGwiS7m64
         aVJA5A4FmptD3VFp253ZJ2HEDia7SIjVB8QB9ystkmmDi9pNd8dNRmWSB7gEiq6Ox/6o
         eskA==
X-Gm-Message-State: AOAM5324fkjReuogLzk2I1F9GRTerd8RikpSc+m7Dpv0BC3mlj2om/X0
        kZphHak96bQlj+62KiZa/tZuFdelbqjd4w==
X-Google-Smtp-Source: ABdhPJzFpu8iVROtppWYQo6kZ53OYPbx08FR/6TQWolIs71e/DAljEsjMxn6SZUFqjBloxfQOKyMNQ==
X-Received: by 2002:a05:622a:194:: with SMTP id s20mr39921519qtw.66.1636145152930;
        Fri, 05 Nov 2021 13:45:52 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e12sm6372907qtw.40.2021.11.05.13.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:45:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/25] btrfs: extent tree v2 prep work for global roots
Date:   Fri,  5 Nov 2021 16:45:26 -0400
Message-Id: <cover.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

This is the kernel side of the prep work for the extent tree v2 global roots and
block group root.  There are a few cleanups around getting rid of trans->root to
make my life easier.  A few BUG_ON() fixes, again mostly just because I was in
the area and they were bugging me.  The main meat is similar to the work for
btrfs-progs, making all users of ->extent_root/->csum_root/->free_space_root to
use helpers, and then implementing a rb tree to track these roots and allow the
reading of multiples of them.  These can be taken without worrying about the
extent tree v2 stuff specifically, they all stand on their own.  These patches
have been through xfstests and fsperf with the rest of the patches to validate
they don't break anything.  Thanks,

Josef

Josef Bacik (25):
  btrfs: kill BTRFS_FS_BARRIER
  btrfs: rework async transaction committing
  btrfs: pass fs_info to trace_btrfs_transaction_commit
  btrfs: remove trans_handle->root
  btrfs: pass the root to add_keyed_refs
  btrfs: move comment in find_parent_nodes()
  btrfs: remove SANITY_TESTS check form find_parent_nodes
  btrfs: remove BUG_ON() in find_parent_nodes()
  btrfs: remove BUG_ON(!eie) in find_parent_nodes
  btrfs: add a btrfs_block_group_root() helper
  btrfs: make remove_extent_backref pass the root
  btrfs: use chunk_root in find_free_extent_update_loop
  btrfs: do not special case the extent root for switch commit roots
  btrfs: remove unnecessary extent root check in btrfs_defrag_leaves
  btrfs: don't use the extent root in btrfs_chunk_alloc_add_chunk_item
  btrfs: don't use extent_root in iterate_extent_inodes
  btrfs: don't use the extent_root in flush_space
  btrfs: init root block_rsv at init root time
  btrfs: stop accessing ->extent_root directly
  btrfs: fix csum assert to check objectid of the root
  btrfs: set BTRFS_FS_STATE_NO_CSUMS if we fail to load the csum root
  btrfs: stop accessing ->csum_root directly
  btrfs: stop accessing ->free_space_root directly
  btrfs: remove useless WARN_ON in record_root_in_trans
  btrfs: track the csum, extent, and free space trees in a rb tree

 fs/btrfs/backref.c                     |  61 +++--
 fs/btrfs/block-group.c                 |  22 +-
 fs/btrfs/block-rsv.c                   |  51 +++--
 fs/btrfs/block-rsv.h                   |   1 +
 fs/btrfs/compression.c                 |   3 +-
 fs/btrfs/ctree.h                       |  15 +-
 fs/btrfs/disk-io.c                     | 306 +++++++++++++++++++------
 fs/btrfs/disk-io.h                     |  13 ++
 fs/btrfs/extent-tree.c                 |  72 +++---
 fs/btrfs/file-item.c                   |   9 +-
 fs/btrfs/free-space-tree.c             |  49 ++--
 fs/btrfs/inode.c                       |  15 +-
 fs/btrfs/ioctl.c                       |   7 +-
 fs/btrfs/qgroup.c                      |   5 +-
 fs/btrfs/ref-verify.c                  |   6 +-
 fs/btrfs/relocation.c                  |   8 +-
 fs/btrfs/scrub.c                       |  13 +-
 fs/btrfs/space-info.c                  |   2 +-
 fs/btrfs/tests/btrfs-tests.c           |   1 +
 fs/btrfs/tests/free-space-tests.c      |   5 +-
 fs/btrfs/tests/free-space-tree-tests.c |   5 +-
 fs/btrfs/tests/qgroup-tests.c          |   5 +-
 fs/btrfs/transaction.c                 |  78 ++-----
 fs/btrfs/transaction.h                 |   3 +-
 fs/btrfs/tree-defrag.c                 |   8 -
 fs/btrfs/tree-log.c                    |  19 +-
 fs/btrfs/volumes.c                     |   3 +-
 fs/btrfs/zoned.c                       |   3 +-
 include/trace/events/btrfs.h           |  10 +-
 29 files changed, 513 insertions(+), 285 deletions(-)

-- 
2.26.3

