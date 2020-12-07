Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690162D12C3
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 14:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgLGN7U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgLGN7T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:19 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DB9C061A51
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:00 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id x25so12511318qkj.3
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U/ZltL4YxiXvMtQIs4ID4XcnLkWVuTx7SSXbu0ywjvI=;
        b=iWmPNvpHGoCVkS/TU3B95DJjl/Hzubnqo+IsRSMVa8EDGi1k1eQjEtp9p8GXpzQ8jE
         uCTWs8qN0jZIDzT1B11dnbPcNxDhWsNy37dss4CE3R0W7DwilIG+jlRiENTt/2q9wBf4
         OCw+DOJb9aoq8autx/TWW4Nm/uFAhxPVLqO3AI30nacPUy2LrIdklDqaJhzqyqJODsxT
         VaBEpnX/Iw6kLvMHUxOWRfmZ0MZaNE8k7hnqMSgwcXitmewDKNgltmNFFDDNL+f8+svZ
         SPW6N0WQMQkC6F1IfUqsm3VibOkpx7y324RsYnj3i8f5+gn82FRqPckgavwe8qAGzU9U
         uQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U/ZltL4YxiXvMtQIs4ID4XcnLkWVuTx7SSXbu0ywjvI=;
        b=dYXPw2TtVoUnNVMB5bQY95XADINs0c5p3c8Dd4XxCtcZh2bY0EKYe/XXj9ESQyvope
         O0J3+HDGVkZXp/S5XL0odhDXWHn18Zpbb5ATGypzbG+nfVGxLRqpj9kkDDfPxV+yH6uv
         Sc2blHrbiaF/dRMqwLWjCQAM2/8Kf1E871IU8sszwTCBF+iIS7K7SiTIgL3P6BUnY/kT
         IkDdMviIYdBdN9N1ChZ1P+zAb6MqHTJa2qow9G04hV23BnGB7o8E1zIh+qF0QIYZ9cLm
         Kv9tyQ75Y8yvCTxHpt38oXMnrV5DlGRz0zkJ9Ide8teaOIo2tbnCBXvuiDDAxrpLmtMO
         +LvA==
X-Gm-Message-State: AOAM530ccPFK7LaUnTjR/QJa/cQvAl1N7L83qzoNuFeHnOKJgPCqJWOE
        rNOXVGxdLKMc5GV1eCrrVWbP9M6ylxFLyV3H
X-Google-Smtp-Source: ABdhPJxNOeY/7w7bFXt45U+gco8CXfDFAHi1d6EaRUBLL7zvViN2GNg9H4CF3B+aoiRMV9KFOzua2g==
X-Received: by 2002:a37:4c4a:: with SMTP id z71mr24828672qka.2.1607349478866;
        Mon, 07 Dec 2020 05:57:58 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s21sm2062912qtn.13.2020.12.07.05.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:57:58 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 06/52] btrfs: do not cleanup upper nodes in btrfs_backref_cleanup_node
Date:   Mon,  7 Dec 2020 08:56:58 -0500
Message-Id: <b23674d7224aebec832d0205a6d49370412b8036.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
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

