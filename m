Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2295339832
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbhCLU0F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbhCLUZh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:25:37 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711F6C061761
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:37 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id g185so25701058qkf.6
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mNCIUetdIhwmDFpunjhFkEGTRdJ7QjL1tQLfeNxoNZY=;
        b=x70K7o0/RyPsisUsS27e/pXJBCrnrg6nimOIOYLFNkxmr5TRwsDuybNBj25V6pWtIf
         4NMYcrczjsxqW0t+SCcWeblws12iCCk6n1ybfW+q+TUIuRZxOr4U+4LjbBq2CJhftz2E
         SyeCsDND2mEl5ToQ52xBsHcd8bByj3eClRXTxSsG+kEm7gVz4kvCo81IMBxFdWVhD3Im
         +EtrLVtAOVYywBZZX0RBbnEF/dBcnJeFtxLazQON5fL8oAolYNk5IbF+jfmo3xBpjeZr
         HcVhKpsOyNbwAq9Rol6HteL5D5MxM6HX9m7MxsD1tjauCnLgr51XcFr6DXB1sw7KKtGs
         pBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mNCIUetdIhwmDFpunjhFkEGTRdJ7QjL1tQLfeNxoNZY=;
        b=rPNSyBi2NzstsdbZnlfDy/+5QA7xqA7oE6RT99kWxzEYbnOg9OwY1utEoqssxsWiZ+
         JVb4C6Kc9A2AmzR8dKhjG+uwg6Va2IHq4PXB4cMrjnmXkoJ8oShYJOXSqOi2hYJ5zHEr
         wNhp3Yh3b65k+AZ27Um52uG8odsWuVewOA7tG4ZL0z4HW9sOte9+ETHCkM8WilfB0/KM
         811H9j9fIKxlDre0rMxXFhg/VAVfs4G7n/KIL84MG+mx3VEFFbhUmD9NDEu8y6kbbyw9
         cmYxCKZfHrh68L5+fcFOI824ryRm/5zZXtZVcHRocXQnpjTV5PDV0mSvk1A1bBuGfZbj
         jQMQ==
X-Gm-Message-State: AOAM533hImFnc3KwlxJqfx/ij/lz8CX+BeDy8slsUxJpOJpV3/4EKl2M
        TlJkTiJWeBV2Omm3/OuTvb8AZHBAxXaluEij
X-Google-Smtp-Source: ABdhPJxS7k4gkQ7TaDsyej7M6n73CYirH6+GzrYmXPgkPUgX3+BRrrPrus5RIHu0w+1yh8y8dIWmIw==
X-Received: by 2002:ae9:e518:: with SMTP id w24mr2036308qkf.78.1615580736269;
        Fri, 12 Mar 2021 12:25:36 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g21sm5316443qkk.72.2021.03.12.12.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:25:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v8 00/39] Cleanup error handling in relocation
Date:   Fri, 12 Mar 2021 15:24:55 -0500
Message-Id: <cover.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v7->v8:
- Reordered some of the patches, so that the callers of functions that added new
  error cases were fixed first, and then added the new error handler.
- Moved a few of the ASSERT(0) to where they made sense.  Left the others that
  are in functions that can have multiple cases of the same error that indicates
  a logic error.

v6->v7:
- Broke up the series into 3 series, 1 for cosmetic things, 1 for all the major
  issues (including those reported on v6 of this set), and this new set which is
  solely the error handling related patches for relocation.  It's still a lot of
  patches, sorry about that.

v5->v6:
- Reworked "btrfs: handle errors from select_reloc_root()" because Zygo reported
  hitting an ASSERT(ret != -ENOENT) during his testing.  This was because I
  changed select_reloc_root() to return -ENOENT if we happened to race with
  somebody else who failed to init the reloc root, however we had an ASSERT() to
  check for this because it indicated corruption.  I modified that patch to move
  the ASSERT() to where the problem actually is, so select_reloc_root() can
  return whatever error and it'll pass it along.  I also removed Qu's
  reviewed-by for the patch because of the change.

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

Josef Bacik (39):
  btrfs: convert some BUG_ON()'s to ASSERT()'s in do_relocation
  btrfs: convert BUG_ON()'s in relocate_tree_block
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
  btrfs: return an error from btrfs_record_root_in_trans
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
  btrfs: do not panic in __add_reloc_root
  btrfs: cleanup error handling in prepare_to_merge
  btrfs: handle extent corruption with select_one_root properly
  btrfs: do proper error handling in merge_reloc_roots
  btrfs: check return value of btrfs_commit_transaction in relocation

 fs/btrfs/inode.c        |  20 +-
 fs/btrfs/ioctl.c        |   7 +-
 fs/btrfs/relocation.c   | 434 +++++++++++++++++++++++++++++++---------
 fs/btrfs/transaction.c  |  37 +++-
 fs/btrfs/tree-checker.c |   5 +
 fs/btrfs/tree-log.c     |   8 +-
 6 files changed, 399 insertions(+), 112 deletions(-)

-- 
2.26.2

