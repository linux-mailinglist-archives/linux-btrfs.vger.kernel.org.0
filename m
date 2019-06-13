Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F31D844415
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2019 18:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbfFMQeq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jun 2019 12:34:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:40108 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730753AbfFMHuF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jun 2019 03:50:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87A1AAD1E
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2019 07:50:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: delayed-ref: Fix memory leak and use-after-free caused by wrong condition to free delayed ref/head.
Date:   Thu, 13 Jun 2019 15:49:59 +0800
Message-Id: <20190613074959.20163-1-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When btrfs-progs is compiled with D=asan, it can't pass even the very
basic fsck tests due to btrfs-image has memory leak:
  === START TEST /home/adam/btrfs/btrfs-progs/tests//fsck-tests/001-bad-file-extent-bytenr
  restoring image default_case.img

  =================================================================
  ==7790==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 104 byte(s) in 1 object(s) allocated from:
      #0 0x7f1d3b738389 in __interceptor_malloc /build/gcc/src/gcc/libsanitizer/asan/asan_malloc_linux.cc:86
      #1 0x560ca6b7f4ff in btrfs_add_delayed_tree_ref /home/adam/btrfs/btrfs-progs/delayed-ref.c:569
      #2 0x560ca6af2d0b in btrfs_free_extent /home/adam/btrfs/btrfs-progs/extent-tree.c:2155
      #3 0x560ca6ac16ca in __btrfs_cow_block /home/adam/btrfs/btrfs-progs/ctree.c:319
      #4 0x560ca6ac1d8c in btrfs_cow_block /home/adam/btrfs/btrfs-progs/ctree.c:383
      #5 0x560ca6ac6c8e in btrfs_search_slot /home/adam/btrfs/btrfs-progs/ctree.c:1153
      #6 0x560ca6ab7e83 in fixup_device_size image/main.c:2113
      #7 0x560ca6ab9279 in fixup_chunks_and_devices image/main.c:2333
      #8 0x560ca6ab9ada in restore_metadump image/main.c:2455
      #9 0x560ca6abaeba in main image/main.c:2723
      #10 0x7f1d3b148ce2 in __libc_start_main (/usr/lib/libc.so.6+0x23ce2)

  ... tons of similar leakage for delayed_tree_ref ...

  Direct leak of 96 byte(s) in 1 object(s) allocated from:
      #0 0x7f1d3b738389 in __interceptor_malloc /build/gcc/src/gcc/libsanitizer/asan/asan_malloc_linux.cc:86
      #1 0x560ca6b7f5fb in btrfs_add_delayed_tree_ref /home/adam/btrfs/btrfs-progs/delayed-ref.c:583
      #2 0x560ca6af5679 in alloc_tree_block /home/adam/btrfs/btrfs-progs/extent-tree.c:2503
      #3 0x560ca6af57ac in btrfs_alloc_free_block /home/adam/btrfs/btrfs-progs/extent-tree.c:2524
      #4 0x560ca6ac115b in __btrfs_cow_block /home/adam/btrfs/btrfs-progs/ctree.c:290
      #5 0x560ca6ac1d8c in btrfs_cow_block /home/adam/btrfs/btrfs-progs/ctree.c:383
      #6 0x560ca6b7bb15 in commit_tree_roots /home/adam/btrfs/btrfs-progs/transaction.c:98
      #7 0x560ca6b7c525 in btrfs_commit_transaction /home/adam/btrfs/btrfs-progs/transaction.c:192
      #8 0x560ca6ab92be in fixup_chunks_and_devices image/main.c:2337
      #9 0x560ca6ab9ada in restore_metadump image/main.c:2455
      #10 0x560ca6abaeba in main image/main.c:2723
      #11 0x7f1d3b148ce2 in __libc_start_main (/usr/lib/libc.so.6+0x23ce2)

  ... tons of similar leakage for delayed_ref_head ...

  SUMMARY: AddressSanitizer: 1600 byte(s) leaked in 16 allocation(s).
  failed to restore image ./default_case.img

[CAUSE]
Commit c6039704c580 ("btrfs-progs: Add delayed refs infrastructure")
introduces delayed ref infrastructure for free space tree, however the
refcount_dec_and_test() from kernel code is wrongly backported.

refcount_dec_and_test() will return true if the refcount reaches 0.
So kernel code will free the allocated space as expected:
	if (refcount_dec_and_test(&ref->refs)) {
		kmem_cache_free();
	}

However btrfs-progs backport is using the opposite condition:
	if (--ref->refs) {
		kfree();
	}

This will not free the memory for the last user, but for refs >= 2.
Causing both use-after-free and memory leak for any offline write
operation.

[FIX]
Fix the (--ref->refs) condition to (--ref->refs == 0) to fix the
backport error.

Fixes: c6039704c580 ("btrfs-progs: Add delayed refs infrastructure")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 delayed-ref.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/delayed-ref.h b/delayed-ref.h
index efc855eff621..2ccfd27c2b95 100644
--- a/delayed-ref.h
+++ b/delayed-ref.h
@@ -161,7 +161,7 @@ btrfs_free_delayed_extent_op(struct btrfs_delayed_extent_op *op)
 static inline void btrfs_put_delayed_ref(struct btrfs_delayed_ref_node *ref)
 {
 	WARN_ON(ref->refs == 0);
-	if (--ref->refs) {
+	if (--ref->refs == 0) {
 		WARN_ON(ref->in_tree);
 		switch (ref->type) {
 		case BTRFS_TREE_BLOCK_REF_KEY:
@@ -180,7 +180,7 @@ static inline void btrfs_put_delayed_ref(struct btrfs_delayed_ref_node *ref)
 
 static inline void btrfs_put_delayed_ref_head(struct btrfs_delayed_ref_head *head)
 {
-	if (--head->refs)
+	if (--head->refs == 0)
 		kfree(head);
 }
 
-- 
2.22.0

