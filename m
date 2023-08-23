Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056F1785A94
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbjHWOd0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236457AbjHWOdZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:25 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ABCE74
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:09 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-56c4c4e822eso3601924eaf.3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801188; x=1693405988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rCpbD8JV08zzk6rJZdSaAIwg7uWtj92YmQZBh9FLb2M=;
        b=PcdLN1VN2OoBihDnQrJcRPFmegiAU3CbjkN4hS9QQXlleV9Tx4Ntzyzg24+gMIpvNk
         bJ7k1m8IRc8sMf07AT3RzHZz5KSzH2jt7BthdVJLSzH04iG8tl2e5TBcaJkN03sLI40X
         l5iVHXqkgYimLi457FEQBvmlvqMGnO+6eJP9QEDQIayNr5PoZkR0tbi0xbNx+JkFoQ93
         JaO298b2AeJlhMllc1DagNKzJoGW4CB3eL5LYI5nMsFk82GglQcdSo4+A5Fq9lH3XB9e
         h6Id8ZWCjFFnNYgaFHp7cq/GX3q0wGe46fowM181XubtW7Jrt9LCRR930tppjhnlXo/g
         59dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801188; x=1693405988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rCpbD8JV08zzk6rJZdSaAIwg7uWtj92YmQZBh9FLb2M=;
        b=PIGhT9nxWSOzoLYBru59SpODt1xrTco5tXutjxgfXjmpOJBDXfchH8d96mHvQwioP7
         gfBvx8nniVTsPVUGmep+KVAGQQeYiG9EWdmWng4M85M17/uH8IowQBUoULu6Qe5kP1/x
         7yszyI/jNVdw8A1Bydz9V4IYeUlvxgGzE0tj4DY4QuqMYb6oASos+7avTTi2+ABaIfxm
         snDI4e1aJiCI3FzjBOCeVqOPrUyvEVg3Mrn9BiohAYCqYK584OvfJ+G27mEmbHNnoNyK
         tC3Ge6p2vq/0gbdftp39H3l4gzdgNmWb/aZmdH3hsOmqPvsrwq0aOm0TWSVKiLvvRAu7
         Xr7A==
X-Gm-Message-State: AOJu0YwJxK0k495ERag3N5SKMktX2XPO3D6pNK4tXw5bKU+Mx45Ow3sw
        MmoCkD0dcDNXscLmD/1snhYS96jJw8t7K5+9r5U=
X-Google-Smtp-Source: AGHT+IFmNl1W0aTDT+Cu6Bgp6lBmYzzABwip0o7dj5HXYtB64V/O8kfqrpEDgOBKmAptwq+8NWQg2Q==
X-Received: by 2002:a05:6358:5913:b0:139:b4c0:93c with SMTP id g19-20020a056358591300b00139b4c0093cmr13729243rwf.5.1692801188550;
        Wed, 23 Aug 2023 07:33:08 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id e127-20020a0dc285000000b0058d1c2762c0sm3335181ywd.26.2023.08.23.07.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:08 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/38] btrfs-progs: sync ctree.c into btrfs-progs
Date:   Wed, 23 Aug 2023 10:32:26 -0400
Message-ID: <cover.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I started back up my extent tree v2 work and noticed not all my ctree.c sync
patches made it in the last submission as I missed some comments.

This patchset is much larger than what was left, as I broke up the changes more
discreetly.  In my original submission I had ignored some of the tree wide
changes in favor of expediency, and had modified ctree.c more to match what we
had in btrfs-progs.

This time I've updated everything that was different in ctree.c in the rest of
btrfs-progs to make the actual sync'ing of ctree.c more straightforward.  I had
to modify a few things in ctree.c, but they are very small and specific, no more
updates of any of the global functions we depend on.

The downside is this patchset is massive.  The upside is the patches are small
and self contained, with the obvious exception of the actual ctree.c sync.

This also will make subsequent sync'ing of other source files much easier, as
I've changed a good deal of the very common helpers to match what exists in the
kernel.

This passes all the tests.  There are a few behavior changes, but for the most
part it's just updating helpers to match kernel definitions and moving code
around.  Thanks,

Josef

Josef Bacik (38):
  btrfs-progs: stop using add_root_to_dirty_list in check
  btrfs-progs: remove useless add_root_to_dirty_list call in mkfs
  btrfs-progs: remove add_root_to_dirty_list call when creating free
    space tree
  btrfs-progs: make add_root_to_dirty_list static and unexport it
  btrfs-progs: pass btrfs_trans_handle through btrfs_clear_buffer_dirty
  btrfs-progs: update read_node_slot to match the kernel definition
  btrfs-progs: update btrfs_bin_search to match the kernel definition
  btrfs-progs: update btrfs_set_item_key_safe to match kernel definition
  btrfs-progs: update btrfs_print_leaf to match the kernel definition
  btrfs-progs: update btrfs_truncate_item to match the kernel definition
  btrfs-progs: update btrfs_extend_item to match the kernel definition
  btrfs-progs: sync memcpy_extent_buffer from the kernel
  btrfs-progs: drop btrfs_init_path
  btrfs-progs: move btrfs_set_item_key_unsafe to check/
  btrfs-progs: move btrfs_record_file_extent and code into a new file
  btrfs-progs: make a local copy of btrfs_next_sibling_block in
    print-tree.c
  btrfs-progs: don't set the ->commit_root in btrfs_create_tree
  btrfs-progs: remove btrfs_create_root
  btrfs-progs: move btrfs_uuid_tree_add into mkfs/main.c
  btrfs-progs: make btrfs_del_ptr a void
  btrfs-progs: replace blocksize with parent argument for
    btrfs_alloc_tree_block
  btrfs-progs: use path->search_for_extension
  btrfs-progs: init new tree blocks in btrfs_alloc_tree_block
  btrfs-progs: add dwarves to the package list for ci
  btrfs-progs: add kerncompat helpers for ctree.c sync
  btrfs-progs: add trans_lock to fs_info
  btrfs-progs: add commit_root_sem to btrfs_fs_info
  btrfs-progs: update btrfs_cow_block to match the in-kernel definition
  btrfs-progs: update btrfs_insert_empty_items to match the kernel
  btrfs-progs: update btrfs_insert_empty_item to match the kernel
  btrfs-progs: update btrfs_del_ptr to match the kernel
  btrfs-progs: update btrfs_insert_item to match the kernel
  btrfs-progs: update btrfs_leaf_free_space to match the kernel
  btrfs-progs: use btrfs_tree_parent_check for btrfs_read_extent_buffer
  btrfs-progs: update read_tree_block to take a btrfs_parent_tree_check
  btrfs-progs: inline btrfs_name_hash and btrfs_extref_hash
  btrfs-progs: update btrfs_split_item to match the in-kernel definition
  btrfs-progs: sync ctree.c from kernel

 Makefile                                      |    1 +
 btrfs-corrupt-block.c                         |   17 +-
 btrfs-find-root.c                             |    5 +-
 btrfs-map-logical.c                           |    1 +
 check/clear-cache.c                           |   12 +-
 check/main.c                                  |  135 +-
 check/mode-common.c                           |   42 +-
 check/mode-lowmem.c                           |  109 +-
 check/qgroup-verify.c                         |   21 +-
 check/repair.c                                |   66 +-
 check/repair.h                                |    5 +
 ci/images/ci-centos-7-x86_64/Dockerfile       |    2 +-
 ci/images/ci-centos-8-x86_64/Dockerfile       |    2 +-
 ci/images/ci-musl-x86_64/Dockerfile           |    2 +-
 .../ci-openSUSE-Leap-15.3-x86_64/Dockerfile   |    2 +-
 .../ci-openSUSE-Leap-15.4-x86_64/Dockerfile   |    2 +-
 .../ci-openSUSE-tumbleweed-x86_64/Dockerfile  |    2 +-
 cmds/inspect-dump-tree.c                      |   25 +-
 cmds/inspect-tree-stats.c                     |   14 +-
 cmds/rescue-chunk-recover.c                   |   16 +-
 cmds/rescue.c                                 |    2 +-
 cmds/restore.c                                |   39 +-
 common/extent-tree-utils.c                    |  282 +
 common/extent-tree-utils.h                    |   28 +
 convert/main.c                                |   10 +-
 convert/source-fs.c                           |    5 +-
 convert/source-reiserfs.c                     |    1 +
 image/common.c                                |    3 +-
 image/image-create.c                          |   14 +-
 image/image-restore.c                         |   12 +-
 image/main.c                                  |    1 +
 include/kerncompat.h                          |   76 +
 kernel-lib/trace.h                            |    6 +
 kernel-shared/backref.c                       |   17 +-
 kernel-shared/ctree.c                         | 4658 ++++++++++++-----
 kernel-shared/ctree.h                         |  162 +-
 kernel-shared/dir-item.c                      |    4 +-
 kernel-shared/disk-io.c                       |   41 +-
 kernel-shared/disk-io.h                       |    9 +-
 kernel-shared/extent-tree.c                   |  281 +-
 kernel-shared/extent_io.c                     |    9 +-
 kernel-shared/extent_io.h                     |    7 +-
 kernel-shared/file-item.c                     |   15 +-
 kernel-shared/file.c                          |    3 +-
 kernel-shared/free-space-cache.c              |    4 +-
 kernel-shared/free-space-tree.c               |    1 -
 kernel-shared/inode-item.c                    |    5 +-
 kernel-shared/inode.c                         |    5 +-
 kernel-shared/print-tree.c                    |   72 +-
 kernel-shared/print-tree.h                    |    7 +-
 kernel-shared/transaction.c                   |    7 +-
 kernel-shared/volumes.c                       |    6 +-
 mkfs/main.c                                   |   89 +-
 mkfs/rootdir.c                                |   11 +-
 quick-test.c                                  |    6 +-
 tune/change-csum.c                            |   13 +-
 tune/change-uuid.c                            |   10 +-
 tune/convert-bgt.c                            |   13 +-
 58 files changed, 4276 insertions(+), 2139 deletions(-)
 create mode 100644 common/extent-tree-utils.c
 create mode 100644 common/extent-tree-utils.h

-- 
2.41.0

