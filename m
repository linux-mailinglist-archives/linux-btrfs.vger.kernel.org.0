Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7DE2D12B8
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 14:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgLGN6e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgLGN6d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:58:33 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20F0C0613D0
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:57:47 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id l7so9358401qtp.8
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MngcQ5cx8sQXdmRjuchm62fQQLZITwEnxeHStxKh9rM=;
        b=VAUD+XxanuuK6lCjR/4X+z4wmhVP+R5dgUmogfmlDixI19C84UxvJYvYzG/J1Fzt+R
         lWJXZe2DAW0Zo0NCGoCDO/pdhY7dqU2HuOAQGV/MD8cbv0qT6dBYCJOD2/Q3N/mhUFW+
         LG+7mZrzL7vIbBTSgGKlk5fWGjhpVj4Anu9opx3rL3Zv+rd9uh33JpS2gi5J40Jqr83f
         SJ8d4sqeulqzWvMUUh7tlwlIIX54fv8THRaeswrtf9rxDh+lfp1xQXljcRD8f7st5WWy
         V3J9FWDHT0woJgDBRpFhDtbCQVUDO8+bgQrgmLPmZcXhTQp6jFz42d8ZvUKgsrt3zL0a
         VAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MngcQ5cx8sQXdmRjuchm62fQQLZITwEnxeHStxKh9rM=;
        b=WMLk6CrE6BBHECS6qNRWtrSOTroHCvOPRWyW0TEK+Ff4TxbHC19xiKA5eimuc95X6e
         wzrOCBXzDNLQVHyPYEskq9sAdg+CpfyoP8x9NVNU7Nxl9Ga2IZYuNtke0DOh9R42uS5+
         muXmGQuWL/3yIwDIZ7W929nvtT6n4ZWYl8Gicz8Cr30bWwLAij3mm+J7AGKEjWL9FoKU
         npl9XQISSkthxPUJrR/IUtJNI92uMHm/GiW/hO3phe/1GKMDaKneJ4uMYSpGIiGnBw2L
         W+oGft7OnE6oRIOZB/vyPVMjawebW33+N3zyZ96Nooaze5coP9dbx01Zf/FNGd2CUR3b
         bf2A==
X-Gm-Message-State: AOAM533K5NkXVJeFFy37OB2fRdxj0nulzvFUiSi4yPyg1erjJByXAuGe
        mZw6cy2KjHkeKQHzRfsXbgmNXQTiY3If/aR6
X-Google-Smtp-Source: ABdhPJzyI/D2fwd3EhisAgnegxkME9EOsQS3PQUohiT0C4Fc9MvVFPGz4M2nrE0sFoxWBOcAM7w+4Q==
X-Received: by 2002:ac8:6f4c:: with SMTP id n12mr4953266qtv.277.1607349466656;
        Mon, 07 Dec 2020 05:57:46 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m190sm6396652qkd.54.2020.12.07.05.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:57:45 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 00/52] Cleanup error handling in relocation
Date:   Mon,  7 Dec 2020 08:56:52 -0500
Message-Id: <cover.1607349281.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v4->v5:
- Dropped "btrfs: fix error handling in commit_fs_roots" as it was merged.
- Fixed an ASSERT() that happened during relocation recovery that Zygo reported,
  I moved the error condition out of another condition which broke recovery if
  we had deleted subvols pending with relocation.

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

Josef Bacik (52):
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
 fs/btrfs/relocation.c   | 474 +++++++++++++++++++++++++++++++---------
 fs/btrfs/transaction.c  |  37 +++-
 fs/btrfs/tree-checker.c |   5 +
 fs/btrfs/tree-log.c     |   8 +-
 fs/btrfs/volumes.c      |   2 +
 14 files changed, 478 insertions(+), 159 deletions(-)

-- 
2.26.2

