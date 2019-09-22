Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A41ABA481
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Sep 2019 20:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392243AbfIVStT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Sep 2019 14:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392203AbfIVStS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Sep 2019 14:49:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 764FE21479;
        Sun, 22 Sep 2019 18:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178157;
        bh=1Rla/CRhwULzh57jcjmACw1sEEzYO9KbZYXxxksqJQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IW5SMZD9pD1OjmD78tOzMRZT96Aghc5fjnl444jH+ZuJ/cI4MQlGyFG00OY2OPp9g
         bmUIapXUxvCifFGYBcHL3nmJ0Si7LaGdJJXKIX5enASYeP0+5w0CXXTrvAqC3wORfW
         4LXgCZxbugMEczAknfTuIDE6+NHUmI4FAeRgjRxM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 202/203] btrfs: Detect unbalanced tree with empty leaf before crashing btree operations
Date:   Sun, 22 Sep 2019 14:43:48 -0400
Message-Id: <20190922184350.30563-202-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184350.30563-1-sashal@kernel.org>
References: <20190922184350.30563-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 62fdaa52a3d00a875da771719b6dc537ca79fce1 ]

[BUG]
With crafted image, btrfs will panic at btree operations:

  kernel BUG at fs/btrfs/ctree.c:3894!
  invalid opcode: 0000 [#1] SMP PTI
  CPU: 0 PID: 1138 Comm: btrfs-transacti Not tainted 5.0.0-rc8+ #9
  RIP: 0010:__push_leaf_left+0x6b6/0x6e0
  RSP: 0018:ffffc0bd4128b990 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: ffffa0a4ab8f0e38 RCX: 0000000000000000
  RDX: ffffa0a280000000 RSI: 0000000000000000 RDI: ffffa0a4b3814000
  RBP: ffffc0bd4128ba38 R08: 0000000000001000 R09: ffffc0bd4128b948
  R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000240
  R13: ffffa0a4b556fb60 R14: ffffa0a4ab8f0af0 R15: ffffa0a4ab8f0af0
  FS: 0000000000000000(0000) GS:ffffa0a4b7a00000(0000) knlGS:0000000000000000
  CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f2461c80020 CR3: 000000022b32a006 CR4: 00000000000206f0
  Call Trace:
  ? _cond_resched+0x1a/0x50
  push_leaf_left+0x179/0x190
  btrfs_del_items+0x316/0x470
  btrfs_del_csums+0x215/0x3a0
  __btrfs_free_extent.isra.72+0x5a7/0xbe0
  __btrfs_run_delayed_refs+0x539/0x1120
  btrfs_run_delayed_refs+0xdb/0x1b0
  btrfs_commit_transaction+0x52/0x950
  ? start_transaction+0x94/0x450
  transaction_kthread+0x163/0x190
  kthread+0x105/0x140
  ? btrfs_cleanup_transaction+0x560/0x560
  ? kthread_destroy_worker+0x50/0x50
  ret_from_fork+0x35/0x40
  Modules linked in:
  ---[ end trace c2425e6e89b5558f ]---

[CAUSE]
The offending csum tree looks like this:

  checksum tree key (CSUM_TREE ROOT_ITEM 0)
  node 29741056 level 1 items 14 free 107 generation 19 owner CSUM_TREE
	  ...
	  key (EXTENT_CSUM EXTENT_CSUM 85975040) block 29630464 gen 17
	  key (EXTENT_CSUM EXTENT_CSUM 89911296) block 29642752 gen 17 <<<
	  key (EXTENT_CSUM EXTENT_CSUM 92274688) block 29646848 gen 17
	  ...

  leaf 29630464 items 6 free space 1 generation 17 owner CSUM_TREE
	  item 0 key (EXTENT_CSUM EXTENT_CSUM 85975040) itemoff 3987 itemsize 8
		  range start 85975040 end 85983232 length 8192
	  ...
  leaf 29642752 items 0 free space 3995 generation 17 owner 0
		      ^ empty leaf            invalid owner ^

  leaf 29646848 items 1 free space 602 generation 17 owner CSUM_TREE
	  item 0 key (EXTENT_CSUM EXTENT_CSUM 92274688) itemoff 627 itemsize 3368
		  range start 92274688 end 95723520 length 3448832

So we have a corrupted csum tree where one tree leaf is completely
empty, causing unbalanced btree, thus leading to unexpected btree
balance error.

[FIX]
For this particular case, we handle it in two directions to catch it:
- Check if the tree block is empty through btrfs_verify_level_key()
  So that invalid tree blocks won't be read out through
  btrfs_search_slot() and its variants.

- Check 0 tree owner in tree checker
  NO tree is using 0 as its tree owner, detect it and reject at tree
  block read time.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202821
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c      | 10 ++++++++++
 fs/btrfs/tree-checker.c |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 97beb351a10cd..65af7eb3f7bd7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -416,6 +416,16 @@ int btrfs_verify_level_key(struct extent_buffer *eb, int level,
 	 */
 	if (btrfs_header_generation(eb) > fs_info->last_trans_committed)
 		return 0;
+
+	/* We have @first_key, so this @eb must have at least one item */
+	if (btrfs_header_nritems(eb) == 0) {
+		btrfs_err(fs_info,
+		"invalid tree nritems, bytenr=%llu nritems=0 expect >0",
+			  eb->start);
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		return -EUCLEAN;
+	}
+
 	if (found_level)
 		btrfs_node_key_to_cpu(eb, &found_key, 0);
 	else
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index d83adda6c090a..9634cae1e1b1d 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -991,6 +991,12 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 				    owner);
 			return -EUCLEAN;
 		}
+		/* Unknown tree */
+		if (owner == 0) {
+			generic_err(leaf, 0,
+				"invalid owner, root 0 is not defined");
+			return -EUCLEAN;
+		}
 		return 0;
 	}
 
-- 
2.20.1

