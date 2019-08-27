Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF32A9DB19
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 03:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfH0BgZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 21:36:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:46412 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727646AbfH0BgZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 21:36:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BDA55ACA0
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 01:36:24 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: tree-checker: Reject unknown tree owner 0
Date:   Tue, 27 Aug 2019 09:36:19 +0800
Message-Id: <20190827013619.13803-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
With crafted image, btrfs will panic at btree operations:
  kernel BUG at fs/btrfs/ctree.c:3894!
  invalid opcode: 0000 [#1] SMP PTI
  CPU: 0 PID: 1138 Comm: btrfs-transacti Not tainted 5.0.0-rc8+ #9
  RIP: 0010:__push_leaf_left+0x6b6/0x6e0
  Code: 00 00 48 98 48 8d 04 80 48 8d 74 80 65 e8 42 5a 04 00 48 8b bd 78 ff ff ff 8b bf 90 d0 00 00 89 7d 98 83 ef 65 e9 06 ff ff ff <0f> 0b 0f 0b 48 8b 85 78 ff ff ff 8b 90 90 d0 00 00 e9 eb fe ff ff
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

[FIX]
The most obvious corruption is the owner, which is pretty easy to detect
and safe to reject.

The better solution is to reject empty leaf/node while reading from a
parent node, but that solution has been bug-prone, so at least use the
owner check to reject that fuzzed image as a workaround before root fix.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 3ce447eb591c..406ecdb38a53 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -973,6 +973,12 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 				    owner);
 			return -EUCLEAN;
 		}
+		/* Unknown tree */
+		if (owner == 0) {
+			generic_err(leaf, 0,
+			"invalid owner, root 0 is not defined");
+			return -EUCLEAN;
+		}
 		return 0;
 	}
 
-- 
2.23.0

