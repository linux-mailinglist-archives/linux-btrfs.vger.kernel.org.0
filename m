Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED4E13D361
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 06:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgAPFET (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 00:04:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:34730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgAPFES (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 00:04:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3459AB07D
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2020 05:04:17 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: relocation: Add an introduction for how relocation works.
Date:   Thu, 16 Jan 2020 13:04:07 +0800
Message-Id: <20200116050407.81267-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Relocation is one of the most complex part of btrfs, while it's also the
foundation stone for online resizing, profile converting.

For such a complex facility, we should at least have some introduction
to it.

This patch will add an basic introduction at pretty a high level,
explaining:
- What relocation does
- How relocation is done
  Only mentioning how data reloc tree and reloc tree are involved in the
  operation.
  No details like the backref cache, or the data reloc tree contents.
- Which function to refer.

More detailed comments will be added for reloc tree creation, data reloc
tree creation and backref cache.

For now the introduction should save reader some time before digging
into the rabbit hole.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- New line after section title to improve readability
- Don't mention "to relocate some extents" part for the objective.
  As that only happens for error case.
- Grammar fix.
---
 fs/btrfs/relocation.c | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d897a8e5e430..b1b4029a0445 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -23,6 +23,52 @@
 #include "delalloc-space.h"
 #include "block-group.h"
 
+/*
+ * Introduction for btrfs relocation.
+ *
+ * [What does relocation do]
+ *
+ * The objective of relocation is to relocate all extents of the target block
+ * group to other block groups.
+ * This is utilized by resize (shrink only), profile converting, or just
+ * balance routine to free some block groups.
+ *
+ * In short, relocation wants to do:
+ * 		Before		|		After
+ * ------------------------------------------------------------------
+ *  BG A: 10 data extents	| BG A: deleted
+ *  BG B:  2 data extents	| BG B: 10 data extents (2 old + 8 relocated)
+ *  BG C:  1 extents		| BG C:  3 data extents (1 old + 2 relocated)
+ *
+ * [How does relocation work]
+ *
+ * 1.   Mark the target bg RO
+ *      So that new extents won't be allocated from the target bg.
+ *
+ * 2.1  Record each extent in the target bg
+ *      To build a proper map of extents to be relocated.
+ *
+ * 2.2  Build data reloc tree and reloc trees
+ *      Data reloc tree will contain an inode, recording all newly relocated
+ *      data extents.
+ *      There will be only one data reloc tree for one data block group.
+ *
+ *      Reloc tree will be a special snapshot of its source tree, containing
+ *      relocated tree blocks.
+ *      Each tree referring to a tree block in target bg will get its reloc
+ *      tree built.
+ *
+ * 2.3  Swap source tree with its corresponding reloc tree
+ *      So that each involved tree only refers to new extents after swap.
+ *
+ * 3.   Cleanup reloc trees and data reloc tree.
+ *      As old extents in the target bg is still referred by reloc trees,
+ *      we need to clean them up before really freeing the target bg.
+ *
+ * The main complexity is in steps 2.2 and 2.3.
+ *
+ * The core entrance for relocation is relocate_block_group() function.
+ */
 /*
  * backref_node, mapping_node and tree_block start with this
  */
-- 
2.24.1

