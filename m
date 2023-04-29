Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E86F6F262D
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjD2UHc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjD2UHb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:07:31 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D712E2
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:30 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-b9a805fd0dcso1549434276.1
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682798849; x=1685390849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5L59BWvJTIWSb0zCo4mUBPL4bFvgpF9DwLgA4HGxsYI=;
        b=rrxquqbtZhxsZdxInhogVesDeofzyAOiixlKnBq6I9xvtvXchiwBBb/AXqKDu7/UVv
         BQc+4d0RYPAfJDW2ZLTtwlj6dDnopMG6yZUtSBPUoCij1oAfIUaTdSIn/adZhrCC2Q+A
         zxfAKkMyLGvuavorPg/XKCD9zgIUp8hDEiUCCELgqxUWt0vdj4juuQ8Y7RyozAwlmM08
         rAeEB9MiTxnk1lXgDJpjWzB5OryZjb6h0fw2oU5pWotYki76cZIYM0S2BIkY/Tblf6Qe
         x0FeGqvWlK+zZ/pWPFbU3ZQXEi6AKeNdyexF1w60Tb1Bjr+Sf8ZW5ZyPIRZhHHL/keVv
         cUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682798849; x=1685390849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5L59BWvJTIWSb0zCo4mUBPL4bFvgpF9DwLgA4HGxsYI=;
        b=Xw4v2wPzc6bmiYtLSOD3uWjc1+RZFnYbu2PaUBNSjgKH/XV0cCoKwwB49KXmmFGUsW
         pJo98tVyTtoFidAvF/zqkkmGIZpu5lEDoR/HrsdRWmF0chbZNJDtr9ujwWuaC/Ve19On
         nASK+IStX3uXpD85cRUJMrrsQqzc38BCpk0AVxV/mfTdYoFjSwwF5zHN7TyDy+YIKBcA
         94Cvl030BpYfIBhXkHK0IK1gmMmTFmpmsY4qBuc24QN6LcD6MDs/W50sqBregCzJyxAk
         ASzolww0kXOlvcTa3ftQvMdjgWjJ9DBUL0HtAL0gn9MRfQDq7fVxnFvnuGWR2+tz5uye
         MJCQ==
X-Gm-Message-State: AC+VfDwWxsy/uV2cIY2WiB7ChU0wSO51Pu7z4J4Fmk/N0kmi8GkBEcMR
        3jsjcFPW8rOUDuYVk8Owyh9ZsnBKK7DH6b9Yjommcw==
X-Google-Smtp-Source: ACHHUZ6cj+H68bIC1JiuC7WXyMrNP3ZhfqMGXnl+2XJ0jBwfgPbxYyfGplCnGmzIo++JF/0GYg9YOA==
X-Received: by 2002:a25:760a:0:b0:b9d:8a4e:e79f with SMTP id r10-20020a25760a000000b00b9d8a4ee79fmr3430342ybc.40.1682798849037;
        Sat, 29 Apr 2023 13:07:29 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id j21-20020a25d215000000b00b9dcd17cc2dsm94055ybg.46.2023.04.29.13.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:07:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/12] btrfs: various cleanups to make ctree.c sync easier
Date:   Sat, 29 Apr 2023 16:07:09 -0400
Message-Id: <cover.1682798736.git.josef@toxicpanda.com>
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

These are various cleanups I needed to make syncing some of the kernel files
into btrfs-progs go smoothly.  They're cosmetic and organizational and shouldn't
have any functional changes.  Thanks,

Josef

Josef Bacik (12):
  btrfs: move btrfs_check_trunc_cache_free_space into block-rsv.c
  btrfs: remove level argument from btrfs_set_block_flags
  btrfs: simplify btrfs_check_leaf_* helpers into a single helper
  btrfs: add btrfs_tree_block_status definitions to tree-checker.h
  btrfs: use btrfs_tree_block_status for leaf item errors
  btrfs: extend btrfs_leaf_check to return btrfs_tree_block_status
  btrfs: add __btrfs_check_node helper
  btrfs: move btrfs_verify_level_key into tree-checker.c
  btrfs: move split_flags/combine_flags helpers to inode-item.h
  btrfs: add __KERNEL__ check for btrfs_no_printk
  btrfs: add a btrfs_csum_type_size helper
  btrfs: rename del_ptr -> btrfs_del_ptr and export it

 fs/btrfs/block-rsv.c        |  19 +++++
 fs/btrfs/block-rsv.h        |   2 +
 fs/btrfs/btrfs_inode.h      |  16 ----
 fs/btrfs/ctree.c            |  29 ++++---
 fs/btrfs/ctree.h            |   3 +
 fs/btrfs/disk-io.c          |  70 ++--------------
 fs/btrfs/disk-io.h          |   2 -
 fs/btrfs/extent-tree.c      |   7 +-
 fs/btrfs/extent-tree.h      |   2 +-
 fs/btrfs/free-space-cache.c |  19 -----
 fs/btrfs/free-space-cache.h |   2 -
 fs/btrfs/inode-item.h       |  16 ++++
 fs/btrfs/messages.h         |   7 ++
 fs/btrfs/tree-checker.c     | 157 ++++++++++++++++++++++++++----------
 fs/btrfs/tree-checker.h     |  29 ++++---
 15 files changed, 207 insertions(+), 173 deletions(-)

-- 
2.40.0

