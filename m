Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868F72B0FF7
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgKLVTb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgKLVTb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:31 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F337CC0613D1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:12 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id j31so5208602qtb.8
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z1JdziazMgFR3pxggL23w0rqSj0CC/UD2UiJOIt8Wg0=;
        b=eWcC5krkWKt/X/MMPbZLRLxfs+P894etYlTyYkFrcWgTeu+Cr1twqwHr9J8bJBDe6e
         lzFBHaMBdgj+xCbobSc4PvPMxR7RCiYc06B9P5h0f+yZOygCgp3o4mpDVz8h4jpmER2U
         TbXS16ecoaNTpip4bAEtNcwGet/v4W/T8hik3rq95celi4COGhHHmkqwu5349nxKsKzD
         xcaD370ZEPMoO3C+p+Dkgvb3cj6oxcJQNea+bRsK77KpJPfwi7l3HrLceXUWQzHEHUQS
         r0/o91aw1Yk0g0eIVl6PHQNfUJC0YkPtHsoKR/9oHIVIltO/APKcDPjnSp3PpUE26GpY
         W/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z1JdziazMgFR3pxggL23w0rqSj0CC/UD2UiJOIt8Wg0=;
        b=gUAheuMyLvgEQb8t9yH12JrqJwnY6xs/3yTZQbJxfZ6bUT4QHPkiEK1sCM1Y36FlU4
         iFVGbEGDQcy9hNOspltGbIjnWRzneGX4R8uMry08IkLf7EL4g+ij7amXMKj+WLynvDgb
         0y4BV/U0ZucEIUhm3wQOXxjokGOimQF7lVUg+J11Why3Y0Df0dd4BOKH4IbRjbGhgwQ2
         izrS/5KAPUhLVxS5uqQr9hjUkjKscZvZDZmT4e74AAsXrYcbBJBlwwegLgWh0UsutdT7
         /hdEGhJHfvdV1KSskQgTNrJ6H26dCQyWs2Chj7Plj3JnP8Pe9BeXETgmmCgg8/v9ZgL6
         wTsg==
X-Gm-Message-State: AOAM530iFH9hkx5dI9v+9ti+I9cMr0oCIw4Odgy9l2YvUUlTcPwCovxz
        YK9950Syo4FWOQQlrKZiuZd1FmxnCSG2vQ==
X-Google-Smtp-Source: ABdhPJzn9z/sXN56xwvakZNp9AQiScij9agpkyFcbdC3dbPk1iaPt8y8snqGJWf/JiNx/MFhjv9Geg==
X-Received: by 2002:ac8:5c50:: with SMTP id j16mr1208155qtj.306.1605215951568;
        Thu, 12 Nov 2020 13:19:11 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p6sm5400605qkh.105.2020.11.12.13.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/42] Cleanup error handling in relocation
Date:   Thu, 12 Nov 2020 16:18:27 -0500
Message-Id: <cover.1605215645.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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

Josef Bacik (42):
  btrfs: allow error injection for btrfs_search_slot and btrfs_cow_block
  btrfs: fix lockdep splat in btrfs_recover_relocation
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

 fs/btrfs/ctree.c        |   2 +
 fs/btrfs/inode.c        |  21 ++-
 fs/btrfs/ioctl.c        |   6 +-
 fs/btrfs/relocation.c   | 372 ++++++++++++++++++++++++++++++----------
 fs/btrfs/transaction.c  |  37 ++--
 fs/btrfs/tree-checker.c |   5 +
 fs/btrfs/tree-log.c     |   8 +-
 fs/btrfs/volumes.c      |   2 +
 8 files changed, 342 insertions(+), 111 deletions(-)

-- 
2.26.2

