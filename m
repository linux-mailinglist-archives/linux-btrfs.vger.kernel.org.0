Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5782CDD5B
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbgLCSY3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbgLCSY3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:24:29 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508E6C061A56
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:15 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id z3so2040373qtw.9
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U/ZltL4YxiXvMtQIs4ID4XcnLkWVuTx7SSXbu0ywjvI=;
        b=kHc6k7Apvca2bugkO+JpvgxF9dYy2n8MEtUL5fzUG4PETlxV3vUSKEZ6os+pLfvl7S
         McAzCPQ+TKaMeuwNURSy1HjIjuzWRZEGKKnU1H8jsHitXzkWleQPyOXyqqFksEfoUUVW
         ptvAyyvzTN+5fiiLNuK746HPSuyuuAlYh9rrqhFhh3s9ckQEKJaBOTm4w4+/ql/VrxET
         x84wuEJSXBYmQJc21Q/RlprIOHdSW+0HE+Whrmd2Sa9kZe/WOXiTTsqxbipEjePA5bqX
         PYY2VEswaokYXhFNuuKVRN275Q1yneYD4AjyFqoqaME86XOSWE+gFYR/2JxReQsXNnGE
         ldYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U/ZltL4YxiXvMtQIs4ID4XcnLkWVuTx7SSXbu0ywjvI=;
        b=lB363ElzoyFr+CWV05WoE53avre3ks1LNqmllz7aWHtQi9VvEtTFYH3hi1lh3edLfR
         4XA4Y2gkSNHgJCPx/9Kg+PtH6XJ54bhTaNzL35DWt+2a5SDGQJZYCVkxYchWrV9QvX9R
         cklFi2zGiB1kZHla6FjPeYG9/vBvHceJ4Y5VoGTFkvzUsd6xKrXi7PA3f43j02rzyz8d
         /vjrbXiMA53CL2yJHkt2VER9eSdwM374vMBCxBV8cH02QZuqDmcpUOK9g3W2doKKmK8N
         K4RIzCf/ntFV233wKcwXEQHv8a3N9a4m4YyALVU9EwzhOgDFQ6Z9B2Uxpzd9rF9IAxSJ
         xJ/Q==
X-Gm-Message-State: AOAM533F0yKuHKz4N0db0R4h3go0M7VaBNNy97peKP9pAplvbwSY/pT+
        iSu7S1SlkA56YCDqz4vmEiS7FMriwDo/i9cW
X-Google-Smtp-Source: ABdhPJzkgQSf0gqYFDbVuME71Qr/paeYoDE5viWSHRkinCrMncRRv+wwBhwkhOQZTR3iTTFS8H9nzA==
X-Received: by 2002:aed:32c7:: with SMTP id z65mr4589728qtd.266.1607019793243;
        Thu, 03 Dec 2020 10:23:13 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z20sm2144376qtb.31.2020.12.03.10.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:12 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 07/53] btrfs: do not cleanup upper nodes in btrfs_backref_cleanup_node
Date:   Thu,  3 Dec 2020 13:22:13 -0500
Message-Id: <3196793231c00ea35b74770f034c3ee70df1973c.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Zygo reported the following panic when testing my error handling patches
for relocation

------------[ cut here ]------------
kernel BUG at fs/btrfs/backref.c:2545!
invalid opcode: 0000 [#1] SMP KASAN PTI CPU: 3 PID: 8472 Comm: btrfs Tainted: G        W 14
Hardware name: QEMU Standard PC (i440FX + PIIX,

Call Trace:
 btrfs_backref_error_cleanup+0x4df/0x530
 build_backref_tree+0x1a5/0x700
 ? _raw_spin_unlock+0x22/0x30
 ? release_extent_buffer+0x225/0x280
 ? free_extent_buffer.part.52+0xd7/0x140
 relocate_tree_blocks+0x2a6/0xb60
 ? kasan_unpoison_shadow+0x35/0x50
 ? do_relocation+0xc10/0xc10
 ? kasan_kmalloc+0x9/0x10
 ? kmem_cache_alloc_trace+0x6a3/0xcb0
 ? free_extent_buffer.part.52+0xd7/0x140
 ? rb_insert_color+0x342/0x360
 ? add_tree_block.isra.36+0x236/0x2b0
 relocate_block_group+0x2eb/0x780
 ? merge_reloc_roots+0x470/0x470
 btrfs_relocate_block_group+0x26e/0x4c0
 btrfs_relocate_chunk+0x52/0x120
 btrfs_balance+0xe2e/0x18f0
 ? pvclock_clocksource_read+0xeb/0x190
 ? btrfs_relocate_chunk+0x120/0x120
 ? lock_contended+0x620/0x6e0
 ? do_raw_spin_lock+0x1e0/0x1e0
 ? do_raw_spin_unlock+0xa8/0x140
 btrfs_ioctl_balance+0x1f9/0x460
 btrfs_ioctl+0x24c8/0x4380
 ? __kasan_check_read+0x11/0x20
 ? check_chain_key+0x1f4/0x2f0
 ? __asan_loadN+0xf/0x20
 ? btrfs_ioctl_get_supported_features+0x30/0x30
 ? kvm_sched_clock_read+0x18/0x30
 ? check_chain_key+0x1f4/0x2f0
 ? lock_downgrade+0x3f0/0x3f0
 ? handle_mm_fault+0xad6/0x2150
 ? do_vfs_ioctl+0xfc/0x9d0
 ? ioctl_file_clone+0xe0/0xe0
 ? check_flags.part.50+0x6c/0x1e0
 ? check_flags.part.50+0x6c/0x1e0
 ? check_flags+0x26/0x30
 ? lock_is_held_type+0xc3/0xf0
 ? syscall_enter_from_user_mode+0x1b/0x60
 ? do_syscall_64+0x13/0x80
 ? rcu_read_lock_sched_held+0xa1/0xd0
 ? __kasan_check_read+0x11/0x20
 ? __fget_light+0xae/0x110
 __x64_sys_ioctl+0xc3/0x100
 do_syscall_64+0x37/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

This occurs because of this check

if (RB_EMPTY_NODE(&upper->rb_node))
	BUG_ON(!list_empty(&node->upper));

As we are dropping the backref node, if we discover that our upper node
in the edge we just cleaned up isn't linked into the cache that we are
now done with this node, thus the BUG_ON().

However this is an erroneous assumption, as we will look up all the
references for a node first, and then process the pending edges.  All of
the 'upper' nodes in our pending edges won't be in the cache's rb_tree
yet, because they haven't been processed.  We could very well have many
edges still left to cleanup on this node.

The fact is we simply do not need this check, we can just process all of
the edges only for this node, because below this check we do the
following

if (list_empty(&upper->lower)) {
	list_add_tail(&upper->lower, &cache->leaves);
	upper->lowest = 1;
}

If the upper node truly isn't used yet, then we add it to the
cache->leaves list to be cleaned up later.  If it is still used then the
last child node that has it linked into its node will add it to the
leaves list and then it will be cleaned up.

Fix this problem by dropping this logic altogether.  With this fix I no
longer see the panic when testing with error injection in the backref
code.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 02d7d7b2563b..56f7c840031e 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2541,13 +2541,6 @@ void btrfs_backref_cleanup_node(struct btrfs_backref_cache *cache,
 		list_del(&edge->list[UPPER]);
 		btrfs_backref_free_edge(cache, edge);
 
-		if (RB_EMPTY_NODE(&upper->rb_node)) {
-			BUG_ON(!list_empty(&node->upper));
-			btrfs_backref_drop_node(cache, node);
-			node = upper;
-			node->lowest = 1;
-			continue;
-		}
 		/*
 		 * Add the node to leaf node list if no other child block
 		 * cached.
-- 
2.26.2

