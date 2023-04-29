Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7D36F264B
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjD2UUJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjD2UUH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:07 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C331E6C
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:06 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54f945a7bddso17192637b3.0
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799605; x=1685391605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZklQn6vYQopSmgPEUZn1GekRMoWeydpZqAqszgcL7E=;
        b=kwwW9qCI4iXKe3eWWM7cJrZ1aa7vpWB5YNXipp90gUDete2TJUstE4woJTYtCDruhe
         LUUIB6Ev10xlGGt1oD6fq15ufqrAmnkgeUtOkKlMCPncD55DGfZDkIoHo5GTUDnVG/2F
         lUrAnF9fM6Wu2HNz4nZEEEbc4VwwUwgO7GXg3aX/bTszu9f4enFykuh4WoOm3bqZ5Dnj
         rg5YkLYmsWv4bmpMF6MsF10pGEn57/TdJiDqp8GCtuxV3SX4sSyJTnNz+h0g+c55VAH8
         eTx9+LFp0nP3gyd5cKGQAke5K5qnK3z2zzjQnCoa9BpreDAMeZGDp2U5SnNM93XMi4G6
         /VPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799605; x=1685391605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZklQn6vYQopSmgPEUZn1GekRMoWeydpZqAqszgcL7E=;
        b=NxVT9bleHk2DRVmIza9+Zy2xZDVV1Y5QUrGKSQiE9qq3OL+iAtbrmTaBq51RoDcG3g
         pzG/nReDXztDNVBX+58yO4O7HPoSXzW52AS2iZXCpKi+gxl6ihUOmy2xS4aaJGpviGRC
         jzudO9QvEF9a/cq7ugMCpP4I47hlyg4Wu0ab4FCXvwqTq3lhBY8G3QV6W4qm9w2sPOHv
         L+TMYkxxHDVTeppiG/p2RVpNe24l1Rkj6mpr1koHImmX1QcJYIvpGcqQlEHkSgC3Np0S
         ZmFJlWbhScrv+LxI3DzJbZiA+/af4mu/qsqVcAkJ8zx1YBkS6acs9AERsITgjOjY3Zvo
         W4EQ==
X-Gm-Message-State: AC+VfDxGaeeYIMKD5asUMl9pc8J+fm9qmImv8SmH92/iOBNJjDfNRrez
        2AgUKptUukJPfEAg3OQadAiARtXUJPmcHcYSdLbWTg==
X-Google-Smtp-Source: ACHHUZ6Pe8SM0E1zvt3gkrJpQRabggKpaaFUGvT0E4sCmhfJRjQeW4/v/Cm+ufZTX+1d9OBXTjT1ug==
X-Received: by 2002:a81:66c4:0:b0:54f:b4cc:cdb7 with SMTP id a187-20020a8166c4000000b0054fb4cccdb7mr7546904ywc.29.1682799605007;
        Sat, 29 Apr 2023 13:20:05 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id o66-20020a0dcc45000000b00559f03541cbsm386175ywd.131.2023.04.29.13.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/26] btrfs-progs: sync ctree.c into btrfs-progs
Date:   Sat, 29 Apr 2023 16:19:31 -0400
Message-Id: <cover.1682799405.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

This is a long series, and it depends on the following series

  btrfs-progs: prep work for syncing files into kernel-shared
  btrfs-progs: sync basic code from the kernel
  btrfs-progs: prep work for syncing ctree.c
  btrfs-progs: more prep work for syncing ctree.c
  
This is even more more prep work for syncing ctree.c, and the last patch is the
actual sync.  A lot of these prep patches are updating the callers to match the
current calling conventions in the kernel to make the syncing straightforward.

This entire series passes our tests.  Thanks,

Josef

Josef Bacik (26):
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
  btrfs-progs: change how we check supported csum type
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
  btrfs-progs: add write_extent_buffer_chunk_tree_uuid helper
  btrfs-progs: init new tree blocks in btrfs_alloc_tree_block
  btrfs-progs: sync ctree.c from the kernel

 Makefile                         |    1 +
 btrfs-corrupt-block.c            |    1 +
 btrfs-map-logical.c              |    1 +
 check/clear-cache.c              |   10 +-
 check/main.c                     |  114 +-
 check/mode-common.c              |   35 +-
 check/mode-lowmem.c              |   84 +-
 check/qgroup-verify.c            |   14 +-
 check/repair.c                   |   50 +-
 check/repair.h                   |    5 +
 cmds/inspect-dump-tree.c         |    5 +-
 cmds/inspect-tree-stats.c        |    3 +-
 cmds/rescue-chunk-recover.c      |   16 +-
 cmds/rescue.c                    |    2 +-
 cmds/restore.c                   |   26 +-
 common/extent-tree-utils.c       |  282 ++
 common/extent-tree-utils.h       |   28 +
 convert/main.c                   |   10 +-
 convert/source-fs.c              |    5 +-
 image/main.c                     |   13 +-
 include/kerncompat.h             |   80 +
 kernel-lib/trace.h               |    8 +
 kernel-shared/ctree.c            | 4848 ++++++++++++++++++++----------
 kernel-shared/ctree.h            |  138 +-
 kernel-shared/dir-item.c         |    4 +-
 kernel-shared/disk-io.c          |   36 +-
 kernel-shared/extent-tree.c      |  281 +-
 kernel-shared/extent_io.c        |   16 +-
 kernel-shared/extent_io.h        |    9 +-
 kernel-shared/file-item.c        |   15 +-
 kernel-shared/file.c             |    3 +-
 kernel-shared/free-space-cache.c |    4 +-
 kernel-shared/free-space-tree.c  |    1 -
 kernel-shared/inode-item.c       |    5 +-
 kernel-shared/inode.c            |    5 +-
 kernel-shared/locking.c          |    6 +-
 kernel-shared/print-tree.c       |   62 +-
 kernel-shared/print-tree.h       |    7 +-
 kernel-shared/transaction.c      |    9 +-
 kernel-shared/volumes.c          |    6 +-
 mkfs/main.c                      |   89 +-
 mkfs/rootdir.c                   |   11 +-
 quick-test.c                     |    6 +-
 tune/change-csum.c               |   23 +-
 tune/change-uuid.c               |    6 +-
 tune/convert-bgt.c               |   13 +-
 46 files changed, 4245 insertions(+), 2151 deletions(-)
 create mode 100644 common/extent-tree-utils.c
 create mode 100644 common/extent-tree-utils.h

-- 
2.40.0

