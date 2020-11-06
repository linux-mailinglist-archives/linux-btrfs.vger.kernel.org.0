Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E326C2A9F0F
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 22:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbgKFV1o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 16:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbgKFV1n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 16:27:43 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B855C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 13:27:43 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id j31so1819545qtb.8
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 13:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7tazp03/FfqcIFRRwHiYXjK7TfUNuVFnuv/X9rUijik=;
        b=ZjRAI4MyaEA64j88niu4iNr4PXfjh/WxpeV1CGxzarmpJn946P8jZlN6B7n3Q3j7Fx
         PW2DW//oYNkbyCtrQ/J3LDoQRJRVmgfFyZmwUomYuGhXvr92iz2xjOUIq52PSiSGtkoY
         iqkm4/awm8cuj50lylsqjwpvjuazoxgIQU08AO2/YKFHoSQSnfpPm2yRXaYI4v84M4zP
         arD98hzxi1iBS/bhBUcH5/x05QWMwtiAZiy2FrFFD0yDtHMFPBrOHvX5MZ7UlI7g9Izh
         8JkMBpAfB9fkwJi5KzkTFm2xCnyXuHuqncb6n6snBbzEk+QIrsiok0pXT+Ej9+1iF5Jl
         JMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7tazp03/FfqcIFRRwHiYXjK7TfUNuVFnuv/X9rUijik=;
        b=a1UFtE4kOg/+bD9Ukf8iAI4hSd6IuCmsc0HzyhzbAN9uDVTo0hDe+nAhxljKG4zoSF
         EoK+H/EF8Nnk3fiK5v/j4/OJPj26aatIiLpOr1cgmmKqHwT1Nai+lmU7e1XDMpd1lgWy
         Nct4ckbaYvWSP3Yy/3pYbMtULPSq/btSKU+VXdk8DgQ/mBMrfg3FXWJCRlXlSWpBxKoT
         z+KL2rxo6eoyarsW4SNb4lp1dDBrah/ZRu/CZJmLSmJW4Lbu+PLZFRd4sCxog7re5Qmc
         30M8wejIwPAZVoJ3IoruIuFC8b+Caao0ZSd9Wp4Cto2vBuxiStjywQhNMGBiLxJYaIWS
         0oPw==
X-Gm-Message-State: AOAM5301wxNAVUyMk7416VgS/34jEPS1ui6RXvk2xRgry6Rn/nub0HwU
        VIhMuoprbA/Iwi6iLG/2Iems7qmtgr+sUoid
X-Google-Smtp-Source: ABdhPJy8dggREsh+n3rj2xIpk3Xrmve9tjsqS+czCGSas7xrtwBKAv41fVHwvZ9EioJMHCE6QniL5A==
X-Received: by 2002:ac8:41d4:: with SMTP id o20mr3361414qtm.313.1604698062313;
        Fri, 06 Nov 2020 13:27:42 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z6sm1302966qtw.36.2020.11.06.13.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:27:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/8] btrfs: unlock to current level in btrfs_next_old_leaf
Date:   Fri,  6 Nov 2020 16:27:30 -0500
Message-Id: <36b861f262858990f84eda72da6bb2e6762c41b7.1604697895.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604697895.git.josef@toxicpanda.com>
References: <cover.1604697895.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filipe reported the following lockdep splat

======================================================
WARNING: possible circular locking dependency detected
5.10.0-rc2-btrfs-next-71 #1 Not tainted
------------------------------------------------------
find/324157 is trying to acquire lock:
ffff8ebc48d293a0 (btrfs-tree-01#2/3){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]

but task is already holding lock:
ffff8eb9932c5088 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (btrfs-tree-00){++++}-{3:3}:
       lock_acquire+0xd8/0x490
       down_write_nested+0x44/0x120
       __btrfs_tree_lock+0x27/0x120 [btrfs]
       btrfs_search_slot+0x2a3/0xc50 [btrfs]
       btrfs_insert_empty_items+0x58/0xa0 [btrfs]
       insert_with_overflow+0x44/0x110 [btrfs]
       btrfs_insert_xattr_item+0xb8/0x1d0 [btrfs]
       btrfs_setxattr+0xd6/0x4c0 [btrfs]
       btrfs_setxattr_trans+0x68/0x100 [btrfs]
       __vfs_setxattr+0x66/0x80
       __vfs_setxattr_noperm+0x70/0x200
       vfs_setxattr+0x6b/0x120
       setxattr+0x125/0x240
       path_setxattr+0xba/0xd0
       __x64_sys_setxattr+0x27/0x30
       do_syscall_64+0x33/0x80
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (btrfs-tree-01#2/3){++++}-{3:3}:
       check_prev_add+0x91/0xc60
       __lock_acquire+0x1689/0x3130
       lock_acquire+0xd8/0x490
       down_read_nested+0x45/0x220
       __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
       btrfs_next_old_leaf+0x27d/0x580 [btrfs]
       btrfs_real_readdir+0x1e3/0x4b0 [btrfs]
       iterate_dir+0x170/0x1c0
       __x64_sys_getdents64+0x83/0x140
       do_syscall_64+0x33/0x80
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-tree-00);
                               lock(btrfs-tree-01#2/3);
                               lock(btrfs-tree-00);
  lock(btrfs-tree-01#2/3);

 *** DEADLOCK ***

5 locks held by find/324157:
 #0: ffff8ebc502c6e00 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x4d/0x60
 #1: ffff8eb97f689980 (&type->i_mutex_dir_key#10){++++}-{3:3}, at: iterate_dir+0x52/0x1c0
 #2: ffff8ebaec00ca58 (btrfs-tree-02#2){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
 #3: ffff8eb98f986f78 (btrfs-tree-01#2){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
 #4: ffff8eb9932c5088 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]

stack backtrace:
CPU: 2 PID: 324157 Comm: find Not tainted 5.10.0-rc2-btrfs-next-71 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Call Trace:
 dump_stack+0x8d/0xb5
 check_noncircular+0xff/0x110
 ? mark_lock.part.0+0x468/0xe90
 check_prev_add+0x91/0xc60
 __lock_acquire+0x1689/0x3130
 ? kvm_clock_read+0x14/0x30
 ? kvm_sched_clock_read+0x5/0x10
 lock_acquire+0xd8/0x490
 ? __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
 down_read_nested+0x45/0x220
 ? __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
 __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
 btrfs_next_old_leaf+0x27d/0x580 [btrfs]
 btrfs_real_readdir+0x1e3/0x4b0 [btrfs]
 iterate_dir+0x170/0x1c0
 __x64_sys_getdents64+0x83/0x140
 ? filldir+0x1d0/0x1d0
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

This happens because btrfs_next_old_leaf searches down to our current
key, and then walks up the path until we can move to the next slot, and
then reads back down the path so we get the next leaf.

However it doesn't unlock any lower levels until it replaces them with
the new extent buffer.  This is technically fine, but of course causes
lockdep to complain, because we could be holding locks on lower levels
while locking upper levels.

Fix this by dropping all nodes below the level that we use as our new
starting point before we start reading back down the path.  This also
allows us to drop the NESTED magic, because we're no longer locking two
nodes at the same level anymore.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 3a01e6e048c0..dcd17f7167d1 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -5327,6 +5327,7 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 	struct btrfs_key key;
 	u32 nritems;
 	int ret;
+	int i;
 
 	nritems = btrfs_header_nritems(path->nodes[0]);
 	if (nritems == 0)
@@ -5398,9 +5399,19 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 			continue;
 		}
 
-		if (next) {
-			btrfs_tree_read_unlock(next);
-			free_extent_buffer(next);
+
+		/*
+		 * Our current level is where we're going to start from, and to
+		 * make sure lockdep doesn't complain we need to drop our locks
+		 * and nodes from 0 to our current level.
+		 */
+		for (i = 0; i < level; i++) {
+			if (path->locks[level]) {
+				btrfs_tree_read_unlock(path->nodes[i]);
+				path->locks[i] = 0;
+			}
+			free_extent_buffer(path->nodes[i]);
+			path->nodes[i] = NULL;
 		}
 
 		next = c;
@@ -5429,22 +5440,14 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 				cond_resched();
 				goto again;
 			}
-			if (!ret) {
-				__btrfs_tree_read_lock(next,
-						       BTRFS_NESTING_RIGHT,
-						       path->recurse);
-			}
+			if (!ret)
+				btrfs_tree_read_lock(next);
 		}
 		break;
 	}
 	path->slots[level] = slot;
 	while (1) {
 		level--;
-		c = path->nodes[level];
-		if (path->locks[level])
-			btrfs_tree_read_unlock(c);
-
-		free_extent_buffer(c);
 		path->nodes[level] = next;
 		path->slots[level] = 0;
 		if (!path->skip_locking)
@@ -5463,8 +5466,7 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 		}
 
 		if (!path->skip_locking)
-			__btrfs_tree_read_lock(next, BTRFS_NESTING_RIGHT,
-					       path->recurse);
+			btrfs_tree_read_lock(next);
 	}
 	ret = 0;
 done:
-- 
2.26.2

