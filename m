Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B212CC701
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387539AbgLBTvz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgLBTvz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:51:55 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A53C0613CF
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:51:15 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id h20so2470574qkk.4
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bEkguTp6CKaBDdguGP0RS2KA34ynpGWnXHC10p+9GUQ=;
        b=vFPtfLKiANzsDqHAFUnEQsckb1pN6nqxycoEFG7yjh57NxCsj5tnciq6kzDuuAKi4z
         Q6vGOywBgJ3gKrWoV9nzMW/wOTJ09GeclVYkLqYVz29CdeUwdzi7xaS5+CADjNg2Ds9z
         tAVVC9QK+by8lc+lqlwSF1bDyCM3U9yT1ttPzajMNt+EnaFMNildVrwgxE6ho1YRv2O2
         Ihp+Oo9sXQCO+7LICefUVToMbrYi8bWv2UVv8rykTqBfyL8QLixOR4bImKifoMY2afUc
         ze3kSYbsilSMtTEUQS9bXVuegx7rxOUgiJTBIz00BQXK4u4jZgKdNuedKBuIXz1gFpkH
         WOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bEkguTp6CKaBDdguGP0RS2KA34ynpGWnXHC10p+9GUQ=;
        b=LK00nD9PkKYGO7ocnhlJWyC/6Hui6qK4u4WJ4BIZ1b+kn3rYkU2kELCd9kGaC1Gfst
         Zhy3WtU2WI31lXAygjdvCcKx3Xbjrp/27j4cC5bDx4tfYaj8EUJs1AGxGBD8sRkWingX
         KuAIYci4qRojcSeXong32CFwuXx24sPjqUXUSmOOZE5alTnxqn/UE6hU2ZBI4FZmIexA
         070n/NSNapAl96iTlJrdgff5VWJGhKUiSTU48as+o8O7ddDGQJ++qwxem++BJKuJXbum
         6JulPYG1N6RMfl+kf8dixm8IgASFv5It3mkTlz0Dl7XQ0nyu1/f6JzCmtToXD60e2Ifx
         OLLg==
X-Gm-Message-State: AOAM53128meOGKSZZNZ6NeD9dlqBkhdX72K4owYX5Q1XsotE2VMVcY20
        qx+yJjO6JCkvMqlN/9F15qXAJu8BKqJuYw==
X-Google-Smtp-Source: ABdhPJzvx+UXT6/HvBWyJyRrjIbzXMQUIr16U1qT6aj12L2byUGckvM28yrnn58FXCvRNPb9aBCKXQ==
X-Received: by 2002:a37:b0c:: with SMTP id 12mr4141511qkl.247.1606938674109;
        Wed, 02 Dec 2020 11:51:14 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 7sm2805490qkv.55.2020.12.02.11.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:51:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 00/54] Cleanup error handling in relocation
Date:   Wed,  2 Dec 2020 14:50:18 -0500
Message-Id: <cover.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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

Josef Bacik (54):
  btrfs: fix error handling in commit_fs_roots
  btrfs: allow error injection for btrfs_search_slot and btrfs_cow_block
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
  btrfs: handle initial btrfs_cow_block error in replace_path
  btrfs: handle the loop btrfs_cow_block error in replace_path
  btrfs: handle btrfs_search_slot failure in replace_path
  btrfs: handle errors in reference count manipulation in replace_path
  btrfs: handle extent reference errors in do_relocation
  btrfs: check for BTRFS_BLOCK_FLAG_FULL_BACKREF being set improperly
  btrfs: remove the extent item sanity checks in relocate_block_group
  btrfs: do proper error handling in create_reloc_inode
  btrfs: handle __add_reloc_root failure in btrfs_recover_relocation
  btrfs: handle __add_reloc_root failure in btrfs_reloc_post_snapshot
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
 fs/btrfs/ioctl.c        |   6 +-
 fs/btrfs/print-tree.c   |  10 +-
 fs/btrfs/print-tree.h   |   2 +-
 fs/btrfs/ref-verify.c   |  43 ++--
 fs/btrfs/relocation.c   | 438 +++++++++++++++++++++++++++++++---------
 fs/btrfs/transaction.c  |  46 +++--
 fs/btrfs/tree-checker.c |   5 +
 fs/btrfs/tree-log.c     |   8 +-
 fs/btrfs/volumes.c      |   2 +
 14 files changed, 440 insertions(+), 159 deletions(-)

-- 
2.26.2

