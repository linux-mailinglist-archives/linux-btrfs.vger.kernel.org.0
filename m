Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE912B2028
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgKMQXl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgKMQXk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:23:40 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B48C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:23:40 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id t5so7053497qtp.2
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6E9hn9P0vJ6JDmy9F2OTeJL/mDwIGASquliMtGXKDzY=;
        b=ba0JN+Qei+SLpPZY7JZPjwKukywrEMOr6jDA+4gFQ4DTSimZJBptQ/wSsAohxotIBe
         F88FqIY8DZQii4ibZEkNfaH0IB+tSJ48IZoLFHtrB+gUr0Mxp9UIOakRG8gYHw2f2YD2
         gxPIBvBVmpgxBomEIFoutb0TwUK6lLcTW4Xt5HE5xZZ6tIc8W25ZmovzmP41DIa3EhYK
         gUPHD+MnpC1jpVyb7hHV1ADH2WohI2ykbLxxMOeNXJcNIrlejhkxZIhfTJdgCgNXQrHx
         0YpsL9J3DKKrFV3HN10igOEmXUMPIZ2IXPpJzIgRE3SV45EFyaDk8jkVY9JRX6h1rPlV
         R4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6E9hn9P0vJ6JDmy9F2OTeJL/mDwIGASquliMtGXKDzY=;
        b=dL62tAWOC83gJaE7xVCkwGNXU5q1xJtmH1qpZWD31Sp3cl0+ISS6NLFX3FdBXj+jx/
         g8fyALK1I7JA6HvHYvdttBfFewGGJ0x79e4qZ/QfQ5Nv++EOkvS/DO8GZs8i9TjT9oRA
         onSTZCTZTSznJx0NvkC9l93qk4WYH/uddQ7AY2I+NO8aEwhpYxVqge1Y1zbfyu6YvY0C
         3joWtKyea8jUdxz5XsIKzQI0BUaL1sEa2V014Oy3pJZlyTnrAYzq8LRrw1cwuIS40PVf
         aAaZDvgKF6IIcGsySe9zaeb7qWA/sXEu4j/l43X0RwUbbKt6sBY3m5HKw47ooYb2qzwp
         bLqA==
X-Gm-Message-State: AOAM5318zO8jZwhD0KfxgFdwEWTXg98sV8NAjL8G7o67nZEJibBw7/a+
        p4hvQM+zP2UuDUIMwTiC1cYWmNX4JDQGNg==
X-Google-Smtp-Source: ABdhPJyo+U6kGTncw+vxYSmWVEONJcTDl4MnYdijhbup1Y+vhg3pElBoAtFERFWBtoOd3QAY728/rQ==
X-Received: by 2002:ac8:5b82:: with SMTP id a2mr2707620qta.178.1605284614431;
        Fri, 13 Nov 2020 08:23:34 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b4sm7074106qti.64.2020.11.13.08.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:23:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 00/42] Cleanup error handling in relocation
Date:   Fri, 13 Nov 2020 11:22:50 -0500
Message-Id: <cover.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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
 fs/btrfs/relocation.c   | 373 ++++++++++++++++++++++++++++++----------
 fs/btrfs/transaction.c  |  37 ++--
 fs/btrfs/tree-checker.c |   5 +
 fs/btrfs/tree-log.c     |   8 +-
 fs/btrfs/volumes.c      |   2 +
 8 files changed, 343 insertions(+), 111 deletions(-)

-- 
2.26.2

