Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587C324C1FE
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 17:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgHTPSt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 11:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgHTPSk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 11:18:40 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38994C061386
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:18:38 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id 6so1456341qtt.0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=e0ahyeO8/t+K8lAsPBEt5yVw2PirM+doWF6T0biVgtg=;
        b=Tx1YYR4LQM2baYc+OLhXYXXzl5BMxhp3/NdYbvR5HME3eCX/50irsttme4VHxe6HRm
         X3LzwYBn21deq5pVMANN+XrlNKNBz0C1vhvU+gXXeBnkWvz+Z8q/i++5RWnAGSsP4SAm
         mnPSzLPMQcXOWZuuWgBqPDm0xJqg78G430SjUx/bJwVZ0JEGe+zHdd+8voeBc14OHVUd
         9u5WFE9F4nKY6289gSfYIE1NODx+eM/GPhYpaBbQB8joe1he6lbjrSFwIvF5WiAfGRJU
         4ZGPQS4cJN+AMHFQyvHTePPopdYp7RxByYObnHuQbk5nJj9KoHyeccWzabjrdIoDDczM
         1WHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e0ahyeO8/t+K8lAsPBEt5yVw2PirM+doWF6T0biVgtg=;
        b=oG5zedDMG8ijlhFrXScpcvt0+VeK7YNlsBaCRUDLAzrME60G+22892XjW10OszMVvq
         vqocC7O9h8v6PQFYV119vZ4dcMiEpG2CHQsU/QXh4H7MeJQ6JNkVeZQgTE7cmyZZNNvv
         wETI4dlEwrZS6ZbnME37cj6E9nqc3V/WLQBK80hjRQ/PJPUrXvLK7vYiLRz7WtbIgSDo
         6BrbRQgqPPm9b84f7mgkeK/SrMWHxmmgxPHWN+N0ZHhIVMDs6dKS9cYfWQ/IaXsUkYKd
         ZX2DOjHpxM0mq2u815+xsuBm0gNxAINM2kbNxMn4LtsqIs92CirF9eCDzrGQQOpVUdSd
         nLUQ==
X-Gm-Message-State: AOAM532q28tcPhyyfcRa1PWVD9gNsYWWAzxvWlaFhYfWcffJH5cmK2If
        B3Y09NmYqeqMTb4pHb9bNNa3u/NeqZCj29EB
X-Google-Smtp-Source: ABdhPJyw5AG/dComAFjJD/Hnj8HUSZ0w25CfvGCjcbQbSXVePxCODM29MYD9SHCvoRFcxYjQDZ2Ftg==
X-Received: by 2002:ac8:4747:: with SMTP id k7mr3092209qtp.76.1597936715660;
        Thu, 20 Aug 2020 08:18:35 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b131sm2329934qkc.121.2020.08.20.08.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:18:35 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/8] btrfs: drop path before adding new uuid tree entry
Date:   Thu, 20 Aug 2020 11:18:24 -0400
Message-Id: <97ba15b7df110e27cc38fea4ed1a6566491e739b.1597936173.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1597936173.git.josef@toxicpanda.com>
References: <cover.1597936173.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the conversion to the rwsemaphore I got the following lockdep splat

======================================================
WARNING: possible circular locking dependency detected
5.8.0-rc7-00167-g0d7ba0c5b375-dirty #925 Not tainted
------------------------------------------------------
btrfs-uuid/7955 is trying to acquire lock:
ffff88bfbafec0f8 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x39/0x180

but task is already holding lock:
ffff88bfbafef2a8 (btrfs-uuid-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x39/0x180

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (btrfs-uuid-00){++++}-{3:3}:
       down_read_nested+0x3e/0x140
       __btrfs_tree_read_lock+0x39/0x180
       __btrfs_read_lock_root_node+0x3a/0x50
       btrfs_search_slot+0x4bd/0x990
       btrfs_uuid_tree_add+0x89/0x2d0
       btrfs_uuid_scan_kthread+0x330/0x390
       kthread+0x133/0x150
       ret_from_fork+0x1f/0x30

-> #0 (btrfs-root-00){++++}-{3:3}:
       __lock_acquire+0x1272/0x2310
       lock_acquire+0x9e/0x360
       down_read_nested+0x3e/0x140
       __btrfs_tree_read_lock+0x39/0x180
       __btrfs_read_lock_root_node+0x3a/0x50
       btrfs_search_slot+0x4bd/0x990
       btrfs_find_root+0x45/0x1b0
       btrfs_read_tree_root+0x61/0x100
       btrfs_get_root_ref.part.50+0x143/0x630
       btrfs_uuid_tree_iterate+0x207/0x314
       btrfs_uuid_rescan_kthread+0x12/0x50
       kthread+0x133/0x150
       ret_from_fork+0x1f/0x30

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-uuid-00);
                               lock(btrfs-root-00);
                               lock(btrfs-uuid-00);
  lock(btrfs-root-00);

 *** DEADLOCK ***

1 lock held by btrfs-uuid/7955:
 #0: ffff88bfbafef2a8 (btrfs-uuid-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x39/0x180

stack backtrace:
CPU: 73 PID: 7955 Comm: btrfs-uuid Kdump: loaded Not tainted 5.8.0-rc7-00167-g0d7ba0c5b375-dirty #925
Hardware name: Quanta Tioga Pass Single Side 01-0030993006/Tioga Pass Single Side, BIOS F08_3A18 12/20/2018
Call Trace:
 dump_stack+0x78/0xa0
 check_noncircular+0x165/0x180
 __lock_acquire+0x1272/0x2310
 lock_acquire+0x9e/0x360
 ? __btrfs_tree_read_lock+0x39/0x180
 ? btrfs_root_node+0x1c/0x1d0
 down_read_nested+0x3e/0x140
 ? __btrfs_tree_read_lock+0x39/0x180
 __btrfs_tree_read_lock+0x39/0x180
 __btrfs_read_lock_root_node+0x3a/0x50
 btrfs_search_slot+0x4bd/0x990
 btrfs_find_root+0x45/0x1b0
 btrfs_read_tree_root+0x61/0x100
 btrfs_get_root_ref.part.50+0x143/0x630
 btrfs_uuid_tree_iterate+0x207/0x314
 ? btree_readpage+0x20/0x20
 btrfs_uuid_rescan_kthread+0x12/0x50
 kthread+0x133/0x150
 ? kthread_create_on_node+0x60/0x60
 ret_from_fork+0x1f/0x30

This problem exists because we have two different rescan threads,
btrfs_uuid_scan_kthread which creates the uuid tree, and
btrfs_uuid_tree_iterate that goes through and updates or deletes any out
of date roots.  The problem is they both do things in different order.
btrfs_uuid_scan_kthread() reads the tree_root, and then inserts entries
into the uuid_root.  btrfs_uuid_tree_iterate() scans the uuid_root, but
then does a btrfs_get_fs_root() which can read from the tree_root.

It's actually easy enough to not be holding the path in
btrfs_uuid_scan_kthread() when we add a uuid entry, as we already drop
it further down and re-start the search when we loop.  So simply move
the path release before we add our entry to the uuid tree.

This also fixes a problem where we're holding a path open after we do
btrfs_end_transaction(), which has it's own problems.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1d5026fdfc75..756ac903a19f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4465,6 +4465,7 @@ int btrfs_uuid_scan_kthread(void *data)
 			goto skip;
 		}
 update_tree:
+		btrfs_release_path(path);
 		if (!btrfs_is_empty_uuid(root_item.uuid)) {
 			ret = btrfs_uuid_tree_add(trans, root_item.uuid,
 						  BTRFS_UUID_KEY_SUBVOL,
@@ -4489,6 +4490,7 @@ int btrfs_uuid_scan_kthread(void *data)
 		}
 
 skip:
+		btrfs_release_path(path);
 		if (trans) {
 			ret = btrfs_end_transaction(trans);
 			trans = NULL;
@@ -4496,7 +4498,6 @@ int btrfs_uuid_scan_kthread(void *data)
 				break;
 		}
 
-		btrfs_release_path(path);
 		if (key.offset < (u64)-1) {
 			key.offset++;
 		} else if (key.type < BTRFS_ROOT_ITEM_KEY) {
-- 
2.24.1

