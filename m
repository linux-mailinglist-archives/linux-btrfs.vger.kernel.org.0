Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBA82DC409
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgLPQXq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgLPQXq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:23:46 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3E2C0611CB
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:41 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 22so12805442qkf.9
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dj2XGPqha3YFHwfk/e4bil+ZSy4l99NNg5b6QwzhcHg=;
        b=bpSbR3vsAGQZydNcGi3ufySPy5Ndw1qqoazpsvuGSowwSzuw5WBb02mvJqi2iSzCE+
         6Jd62rlZn7l+gh4T0HM6hCkXJ/DLxtF5btqlDvk1Sxi2GaBThSrchxmF1kFugmTeFPWB
         8PvJ6ngmR1qXbjG3t/Xlbe2Gz07hZdb/vT+/nkM3Q7EQAxVRXXcPHXn2uhzJkqsyaLx7
         NlE22WLwDOuPNLM+kCyQwvFvBijtXhW+2nIr1IIdalv5BvWJuAiD3pIIXZKpdTkRifL4
         IkOl41moHxQg78HhIfZTQ2UgyrmUQQhFpOSHe7bCTfj0gi9hBNLsYXq4hs/tILCi/DH6
         UpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dj2XGPqha3YFHwfk/e4bil+ZSy4l99NNg5b6QwzhcHg=;
        b=DS4HxhNcSH1IoCoJAildqMCw5mGe8wLP2bqLdo3sIL6+vrvsjanvqr8pQOREFpnixe
         TjbHPSOBjdyVQ5sZ8pLV6UdPhPF1Gd45diQCV23z/sqfJQllZnJXDRcvhcIwqkTSmGcU
         rrc8AJZ9zRHnXA9y7paBbeB+SUw9ErGhAm6SiKNL8JoBXs+7XAqAqRDM0gN1tyH0Vmh3
         n38Af36Lf3Ev9L9SOmXSgzaFEPRLphH0VFKmRLnC4S9qwThmsaYa9slrflIG1CA0fYiO
         EXb2Wne8dBbjh1wgF54ojwnq6pxOGgJ2/DJqoh0IiSZreAPOOXHCCAuT0n14C00kdssH
         t/Zg==
X-Gm-Message-State: AOAM532a+bMBQZ/xRpzK32seaQBohNlo4cqQkzZxzAGUEO2tM7MKf4De
        4kVy7aodhYyOiOUIYE3Xzwyw+gKZ3io67skV
X-Google-Smtp-Source: ABdhPJy7BcOXldXrZajMmWaIhqn2nIL3CJY6bKwT3cebe7xctxK7rKz/7piYboyD8wm9KZDzC85LqA==
X-Received: by 2002:ae9:dc45:: with SMTP id q66mr44933238qkf.407.1608135760147;
        Wed, 16 Dec 2020 08:22:40 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e66sm1403760qkf.31.2020.12.16.08.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:22:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/13] btrfs: keep track of the root owner for relocation reads
Date:   Wed, 16 Dec 2020 11:22:15 -0500
Message-Id: <1daf94fcbd66162c6b227404e2e0db257ca1c91c.1608135557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135557.git.josef@toxicpanda.com>
References: <cover.1608135557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While testing the error paths in relocation, I hit the following lockdep
splat

======================================================
WARNING: possible circular locking dependency detected
5.10.0-rc3+ #206 Not tainted
------------------------------------------------------
btrfs-balance/1571 is trying to acquire lock:
ffff8cdbcc8f77d0 (&head_ref->mutex){+.+.}-{3:3}, at: btrfs_lookup_extent_info+0x156/0x3b0

but task is already holding lock:
ffff8cdbc54adbf8 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_lock+0x27/0x100

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (btrfs-tree-00){++++}-{3:3}:
       down_write_nested+0x43/0x80
       __btrfs_tree_lock+0x27/0x100
       btrfs_search_slot+0x248/0x890
       relocate_tree_blocks+0x490/0x650
       relocate_block_group+0x1ba/0x5d0
       kretprobe_trampoline+0x0/0x50

-> #1 (btrfs-csum-01){++++}-{3:3}:
       down_read_nested+0x43/0x130
       __btrfs_tree_read_lock+0x27/0x100
       btrfs_read_lock_root_node+0x31/0x40
       btrfs_search_slot+0x5ab/0x890
       btrfs_del_csums+0x10b/0x3c0
       __btrfs_free_extent+0x49d/0x8e0
       __btrfs_run_delayed_refs+0x283/0x11f0
       btrfs_run_delayed_refs+0x86/0x220
       btrfs_start_dirty_block_groups+0x2ba/0x520
       kretprobe_trampoline+0x0/0x50

-> #0 (&head_ref->mutex){+.+.}-{3:3}:
       __lock_acquire+0x1167/0x2150
       lock_acquire+0x116/0x3e0
       __mutex_lock+0x7e/0x7b0
       btrfs_lookup_extent_info+0x156/0x3b0
       walk_down_proc+0x1c3/0x280
       walk_down_tree+0x64/0xe0
       btrfs_drop_subtree+0x182/0x260
       do_relocation+0x52e/0x660
       relocate_tree_blocks+0x2ae/0x650
       relocate_block_group+0x1ba/0x5d0
       kretprobe_trampoline+0x0/0x50

other info that might help us debug this:

Chain exists of:
  &head_ref->mutex --> btrfs-csum-01 --> btrfs-tree-00

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-tree-00);
                               lock(btrfs-csum-01);
                               lock(btrfs-tree-00);
  lock(&head_ref->mutex);

 *** DEADLOCK ***

5 locks held by btrfs-balance/1571:
 #0: ffff8cdb89749ff8 (&fs_info->delete_unused_bgs_mutex){+.+.}-{3:3}, at: btrfs_balance+0x563/0xf40
 #1: ffff8cdb89748838 (&fs_info->cleaner_mutex){+.+.}-{3:3}, at: btrfs_relocate_block_group+0x156/0x300
 #2: ffff8cdbc2c16650 (sb_internal#2){.+.+}-{0:0}, at: start_transaction+0x413/0x5c0
 #3: ffff8cdbc135f538 (btrfs-treloc-01){+.+.}-{3:3}, at: __btrfs_tree_lock+0x27/0x100
 #4: ffff8cdbc54adbf8 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_lock+0x27/0x100

stack backtrace:
CPU: 1 PID: 1571 Comm: btrfs-balance Not tainted 5.10.0-rc3+ #206
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
Call Trace:
 dump_stack+0x8b/0xb0
 check_noncircular+0xcf/0xf0
 ? trace_call_bpf+0x139/0x260
 __lock_acquire+0x1167/0x2150
 lock_acquire+0x116/0x3e0
 ? btrfs_lookup_extent_info+0x156/0x3b0
 __mutex_lock+0x7e/0x7b0
 ? btrfs_lookup_extent_info+0x156/0x3b0
 ? btrfs_lookup_extent_info+0x156/0x3b0
 ? release_extent_buffer+0x124/0x170
 ? _raw_spin_unlock+0x1f/0x30
 ? release_extent_buffer+0x124/0x170
 btrfs_lookup_extent_info+0x156/0x3b0
 walk_down_proc+0x1c3/0x280
 walk_down_tree+0x64/0xe0
 btrfs_drop_subtree+0x182/0x260
 do_relocation+0x52e/0x660
 relocate_tree_blocks+0x2ae/0x650
 ? add_tree_block+0x149/0x1b0
 relocate_block_group+0x1ba/0x5d0
 elfcorehdr_read+0x40/0x40
 ? elfcorehdr_read+0x40/0x40
 ? btrfs_balance+0x796/0xf40
 ? __kthread_parkme+0x66/0x90
 ? btrfs_balance+0xf40/0xf40
 ? balance_kthread+0x37/0x50
 ? kthread+0x137/0x150
 ? __kthread_bind_mask+0x60/0x60
 ? ret_from_fork+0x1f/0x30

As you can see this is bogus, we never take another tree's lock under
the csum lock.  This happens because sometimes we have to read tree
blocks from disk without knowing which root they belong to during
relocation.  We defaulted to an owner of 0, which translates to an fs
tree.  This is fine as all fs trees have the same class, but obviously
isn't fine if the block belongs to a cow only tree.

Thankfully cow only trees only have their owners root as a reference to
them, and since we already look up the extent information during
relocation, go ahead and check and see if this block might belong to a
cow only tree, and if so save the owner in the struct tree_block.  This
allows us to read_tree_block with the proper owner, which gets rid of
this lockdep splat.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 47 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 073666fb7b57..4dd9f220904a 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -98,6 +98,7 @@ struct tree_block {
 		u64 bytenr;
 	}; /* Use rb_simple_node for search/insert */
 	struct btrfs_key key;
+	u64 owner;
 	unsigned int level:8;
 	unsigned int key_ready:1;
 };
@@ -2391,8 +2392,8 @@ static int get_tree_block_key(struct btrfs_fs_info *fs_info,
 {
 	struct extent_buffer *eb;
 
-	eb = read_tree_block(fs_info, block->bytenr, 0, block->key.offset,
-			     block->level, NULL);
+	eb = read_tree_block(fs_info, block->bytenr, block->owner,
+			     block->key.offset, block->level, NULL);
 	if (IS_ERR(eb)) {
 		return PTR_ERR(eb);
 	} else if (!extent_buffer_uptodate(eb)) {
@@ -2491,7 +2492,8 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 	/* Kick in readahead for tree blocks with missing keys */
 	rbtree_postorder_for_each_entry_safe(block, next, blocks, rb_node) {
 		if (!block->key_ready)
-			btrfs_readahead_tree_block(fs_info, block->bytenr, 0, 0,
+			btrfs_readahead_tree_block(fs_info, block->bytenr,
+						   block->owner, 0,
 						   block->level);
 	}
 
@@ -2799,21 +2801,59 @@ static int add_tree_block(struct reloc_control *rc,
 	u32 item_size;
 	int level = -1;
 	u64 generation;
+	u64 owner = 0;
 
 	eb =  path->nodes[0];
 	item_size = btrfs_item_size_nr(eb, path->slots[0]);
 
 	if (extent_key->type == BTRFS_METADATA_ITEM_KEY ||
 	    item_size >= sizeof(*ei) + sizeof(*bi)) {
+		unsigned long ptr = 0, end;
+
 		ei = btrfs_item_ptr(eb, path->slots[0],
 				struct btrfs_extent_item);
+		end = (unsigned long)ei + item_size;
 		if (extent_key->type == BTRFS_EXTENT_ITEM_KEY) {
 			bi = (struct btrfs_tree_block_info *)(ei + 1);
 			level = btrfs_tree_block_level(eb, bi);
+			ptr = (unsigned long)(bi + 1);
 		} else {
 			level = (int)extent_key->offset;
+			ptr = (unsigned long)(ei + 1);
 		}
 		generation = btrfs_extent_generation(eb, ei);
+
+		/*
+		 * We're reading random blocks without knowing their owner ahead
+		 * of time.  This is ok most of the time, as all reloc roots and
+		 * fs roots have the same lock type.  However normal trees do
+		 * not, and the only way to know ahead of time is to read the
+		 * inline ref offset.  We know it's an fs root if
+		 *
+		 * 1. There's more than one ref.
+		 * 2. There's a SHARED_DATA_REF_KEY set.
+		 * 3. FULL_BACKREF is set on the flags.
+		 *
+		 * Otherwise it's safe to assume that the ref offset == the
+		 * owner of this block, so we can use that when calling
+		 * read_tree_block.
+		 */
+		if (btrfs_extent_refs(eb, ei) == 1 &&
+		    !(btrfs_extent_flags(eb, ei) &
+		      BTRFS_BLOCK_FLAG_FULL_BACKREF) &&
+		    ptr < end) {
+			struct btrfs_extent_inline_ref *iref;
+			int type;
+
+			iref = (struct btrfs_extent_inline_ref *)ptr;
+			type = btrfs_get_extent_inline_ref_type(eb, iref,
+							BTRFS_REF_TYPE_BLOCK);
+			if (type == BTRFS_REF_TYPE_INVALID)
+				return -EINVAL;
+			if (type == BTRFS_TREE_BLOCK_REF_KEY)
+				owner = btrfs_extent_inline_ref_offset(eb,
+								       iref);
+		}
 	} else if (unlikely(item_size == sizeof(struct btrfs_extent_item_v0))) {
 		btrfs_print_v0_err(eb->fs_info);
 		btrfs_handle_fs_error(eb->fs_info, -EINVAL, NULL);
@@ -2835,6 +2875,7 @@ static int add_tree_block(struct reloc_control *rc,
 	block->key.offset = generation;
 	block->level = level;
 	block->key_ready = 0;
+	block->owner = owner;
 
 	rb_node = rb_simple_insert(blocks, block->bytenr, &block->rb_node);
 	if (rb_node)
-- 
2.26.2

