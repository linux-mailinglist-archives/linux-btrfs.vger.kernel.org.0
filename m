Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831432CDD50
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbgLCSXr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731089AbgLCSXo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:23:44 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7113C061A4E
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:03 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id h20so3024725qkk.4
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DJjJj91Bv/NP6c3frjsKELVBveaX1H7xwPQghTxm1W8=;
        b=qG8aO2xyMtxZUL96E+YxwqPcYytF7MnSYQyfUx191NXdynDNGiBP6K9wFgVhch3sQz
         BLKySBYqeu6UlJEVAWq1oXZmQnQwehZhs+ANJ8MQd89e/uOYrlU7VQz7PobOchjtB8an
         0UeLbo/kn0xTDrIosqCauT7vL3E1MtZPidk8kuXED0QPAJ8JSyDdd2POlwsXekIENngK
         ZDBS5eSe8myQcyyqjOnqtsRdoWGnguli+PCD0bN7+dLEc3m3Zgq6auUlxsEu+GL7DNYA
         ooM3cPtQiDW7LFGso8vzrkxTPCF402p5BDMg1HT4hKv1YbAcrH2ueOtZ8JTeosxKmNO3
         nRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DJjJj91Bv/NP6c3frjsKELVBveaX1H7xwPQghTxm1W8=;
        b=jkYu9SmUOslpMcO5hDSRCS5+NCboxDQiYPeAn/rozuCDN84VKyGjVg5Z06Nx48Mzve
         scXhyQWLye9hfpKbQbiqYJ4WTX67sGiTNxzJBMRlJ6Z97/mEalLoIHBb2SczkLmCnc9K
         b7tqEIRHnJn9/ldtrohYm871+3EGpTZ/uDBt5LC6kBgUuXhiB7FTdpqTtSXb92vsrMl0
         gpp+ftwNCYscMfxofIPMFOL5gCfRF8MrbjQNwyqQADAZKP0VeF/45V8YxHPXwIhSb79e
         4JNHa4QcpjLCpQga/CcDxwSRB+UU/xKtM9mPwhLU6ChAba7TfkBNFYD76dwrWbR5EOxA
         YBpg==
X-Gm-Message-State: AOAM530l7Lhx1LJTJudiBo6wsfrCAFiJcCwISsmpBKwKbgPSSSx63+LP
        Y4jshrvrtz1XPI9Erfb6fR/l37eQaV6Oe+GD
X-Google-Smtp-Source: ABdhPJy0mbBTvx1IvfnIKx1liMQ1ZjwQHFLvbwo/4Z5Jg1xye/KpZeZqCcC31Sqp3/kP7g4tYEAyew==
X-Received: by 2002:a05:620a:16ab:: with SMTP id s11mr4318053qkj.356.1607019781464;
        Thu, 03 Dec 2020 10:23:01 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z133sm2315690qka.20.2020.12.03.10.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:00 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 00/53] Cleanup error handling in relocation
Date:   Thu,  3 Dec 2020 13:22:06 -0500
Message-Id: <cover.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v3->v4:
- Squashed the __add_reloc_root error handling patches in
  btrfs_recover_relocation as they were small and in the same function.
- Squashed the record_root_in_trans failure handling patches for
  select_reloc_root as they were small and in the same function.
- Added a new patch to address an existing error handling problem with subvol
  creation.
- Fixed up the various cases that Qu noticed where I got things wrong, cleaning
  up a leaked root extent ref, a leaked inode item, and where I accidentally
  stopped dealing with errors from btrfs_drop_subtree.
- Reworked a bunch of the ASSERT()'s to do ASSERT(0) in their respective if
  statements.
- Added reviewed-bys.

v2->v3:
- A lot of extra patches fixing various things that I encountered while
  debugging the corruption problem that was uncovered by these patches.
- Fixed the panic that Zygo was seeing and other issues.
- Fixed up the comments from Nikolay and Filipe.

A slight note, the first set of patches could probably be taken now, and in fact

  btrfs: fix error handling in commit_fs_roots

Was sent earlier this week and is very important and needs to be reviewed and
merged ASAP.  The following are safe and could be merged outside of the rest of
this series

  btrfs: allow error injection for btrfs_search_slot and btrfs_cow_block
  btrfs: fix lockdep splat in btrfs_recover_relocation
  btrfs: keep track of the root owner for relocation reads
  btrfs: noinline btrfs_should_cancel_balance
  btrfs: do not cleanup upper nodes in btrfs_backref_cleanup_node
  btrfs: pass down the tree block level through ref-verify
  btrfs: make sure owner is set in ref-verify
  btrfs: don't clear ret in btrfs_start_dirty_block_groups

The rest obviously are all around the actual error handling.

v1->v2:
- fixed a bug where I accidentally dropped reading flags in relocate_block_group
  when I dropped the extra checks that we handle in the tree checker.

--- Original message ---
Hello,

Relocation is the last place that is not able to handle errors at all, which
results in all sorts of lovely panics if you encounter corruptions or IO errors.
I'm going to start cleaning up relocation, but before I move code around I want
the error handling to be somewhat sane, so I'm not changing behavior and error
handling at the same time.

These patches are purely about error handling, there is no behavior changing
other than returning errors up the chain properly.  There is a lot of room for
follow up cleanups, which will happen next.  However I wanted to get this series
done today and out so we could get it merged ASAP, and then the follow up
cleanups can happen later as they are less important and less critical.

The only exception to the above is the patch to add the error injection sites
for btrfs_cow_block and btrfs_search_slot, and a lockdep fix that I discovered
while running my tests, those are the first two patches in the series.

I tested this with my error injection stress test, where I keep track of all
stack traces that have been tested and only inject errors when we have a new
stack trace, which means I should have covered all of the various error
conditions.  With this patchset I'm no longer panicing while stressing the error
conditions.  Thanks,

Josef

Josef Bacik (53):
  btrfs: fix error handling in commit_fs_roots
  btrfs: allow error injection for btrfs_search_slot and btrfs_cow_block
  btrfs: modify the new_root highest_objectid under a ref count
  btrfs: fix lockdep splat in btrfs_recover_relocation
  btrfs: keep track of the root owner for relocation reads
  btrfs: noinline btrfs_should_cancel_balance
  btrfs: do not cleanup upper nodes in btrfs_backref_cleanup_node
  btrfs: pass down the tree block level through ref-verify
  btrfs: make sure owner is set in ref-verify
  btrfs: don't clear ret in btrfs_start_dirty_block_groups
  btrfs: convert some BUG_ON()'s to ASSERT()'s in do_relocation
  btrfs: convert BUG_ON()'s in relocate_tree_block
  btrfs: return an error from btrfs_record_root_in_trans
  btrfs: handle errors from select_reloc_root()
  btrfs: convert BUG_ON()'s in select_reloc_root() to proper errors
  btrfs: check record_root_in_trans related failures in
    select_reloc_root
  btrfs: do proper error handling in record_reloc_root_in_trans
  btrfs: handle btrfs_record_root_in_trans failure in
    btrfs_rename_exchange
  btrfs: handle btrfs_record_root_in_trans failure in btrfs_rename
  btrfs: handle btrfs_record_root_in_trans failure in
    btrfs_delete_subvolume
  btrfs: handle btrfs_record_root_in_trans failure in
    btrfs_recover_log_trees
  btrfs: handle btrfs_record_root_in_trans failure in create_subvol
  btrfs: btrfs: handle btrfs_record_root_in_trans failure in
    relocate_tree_block
  btrfs: handle btrfs_record_root_in_trans failure in start_transaction
  btrfs: handle record_root_in_trans failure in qgroup_account_snapshot
  btrfs: handle record_root_in_trans failure in
    btrfs_record_root_in_trans
  btrfs: handle record_root_in_trans failure in create_pending_snapshot
  btrfs: do not panic in __add_reloc_root
  btrfs: have proper error handling in btrfs_init_reloc_root
  btrfs: do proper error handling in create_reloc_root
  btrfs: validate ->reloc_root after recording root in trans
  btrfs: handle btrfs_update_reloc_root failure in commit_fs_roots
  btrfs: change insert_dirty_subvol to return errors
  btrfs: handle btrfs_update_reloc_root failure in insert_dirty_subvol
  btrfs: handle btrfs_update_reloc_root failure in prepare_to_merge
  btrfs: do proper error handling in btrfs_update_reloc_root
  btrfs: convert logic BUG_ON()'s in replace_path to ASSERT()'s
  btrfs: handle btrfs_cow_block errors in replace_path
  btrfs: handle btrfs_search_slot failure in replace_path
  btrfs: handle errors in reference count manipulation in replace_path
  btrfs: handle extent reference errors in do_relocation
  btrfs: check for BTRFS_BLOCK_FLAG_FULL_BACKREF being set improperly
  btrfs: remove the extent item sanity checks in relocate_block_group
  btrfs: do proper error handling in create_reloc_inode
  btrfs: handle __add_reloc_root failures in btrfs_recover_relocation
  btrfs: cleanup error handling in prepare_to_merge
  btrfs: handle extent corruption with select_one_root properly
  btrfs: do proper error handling in merge_reloc_roots
  btrfs: check return value of btrfs_commit_transaction in relocation
  btrfs: do not WARN_ON() if we can't find the reloc root
  btrfs: print the actual offset in btrfs_root_name
  btrfs: fix reloc root leak with 0 ref reloc roots on recovery
  btrfs: splice remaining dirty_bg's onto the transaction dirty bg list

 fs/btrfs/backref.c      |   9 +-
 fs/btrfs/block-group.c  |   6 +-
 fs/btrfs/ctree.c        |   2 +
 fs/btrfs/disk-io.c      |   2 +-
 fs/btrfs/inode.c        |  20 +-
 fs/btrfs/ioctl.c        |  17 +-
 fs/btrfs/print-tree.c   |  10 +-
 fs/btrfs/print-tree.h   |   2 +-
 fs/btrfs/ref-verify.c   |  43 ++--
 fs/btrfs/relocation.c   | 463 +++++++++++++++++++++++++++++++---------
 fs/btrfs/transaction.c  |  46 ++--
 fs/btrfs/tree-checker.c |   5 +
 fs/btrfs/tree-log.c     |   8 +-
 fs/btrfs/volumes.c      |   2 +
 14 files changed, 472 insertions(+), 163 deletions(-)

-- 
2.26.2

