Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5602187AFC
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 09:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgCQINA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 04:13:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:43088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgCQIM7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 04:12:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 03996AF83
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Mar 2020 08:12:57 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 32/39] btrfs: backref: Only ignore reloc roots for indrect backref resolve if the backref cache is for reloction purpose
Date:   Tue, 17 Mar 2020 16:11:18 +0800
Message-Id: <20200317081125.36289-33-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317081125.36289-1-wqu@suse.com>
References: <20200317081125.36289-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For relocation tree detection, relocation backref cache uses
should_ignore_reloc_root() which uses relocation specific checks like
checking the DEAD_RELOC_ROOT bit.

However for generic purposed backref cache, we can rely on that check,
as it's possible that relocation is also running.

For generic purposed backref cache, we detect reloc root by
SHARED_BLOCK_REF item.
Only reloc root node has its parent bytenr pointing back to itself.

And in that case, backref cache will mark the reloc root node useless,
dropping any child orphan nodes.

So only call should_ignore_reloc_root() if the backref cache is for
relocation.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 79ccada3fce6..86fb25aa3f0b 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2700,7 +2700,17 @@ static int handle_indirect_tree_backref(struct backref_cache *cache,
 		/* tree root */
 		ASSERT(btrfs_root_bytenr(&root->root_item) ==
 		       cur->bytenr);
-		if (should_ignore_reloc_root(root)) {
+		/*
+		 * For reloc backref cache, we may ignore reloc root.
+		 * But for generic purposed backref cache, we can't rely
+		 * on should_ignore_reloc_root() as it may conflict with
+		 * current running relocation and lead to missing root.
+		 *
+		 * For generic purposed backref cache, reloc root detection
+		 * is completely relying on direct backref (key->offset is
+		 * parent bytenr).
+		 */
+		if (should_ignore_reloc_root(root) && cache->is_reloc) {
 			btrfs_put_root(root);
 			list_add(&cur->list, &cache->useless_node);
 		} else {
@@ -2741,7 +2751,8 @@ static int handle_indirect_tree_backref(struct backref_cache *cache,
 		if (!path->nodes[level]) {
 			ASSERT(btrfs_root_bytenr(&root->root_item) ==
 			       lower->bytenr);
-			if (should_ignore_reloc_root(root)) {
+			/* Same as previous should_ignore_reloc_root() call */
+			if (should_ignore_reloc_root(root) && cache->is_reloc) {
 				btrfs_put_root(root);
 				list_add(&lower->list, &cache->useless_node);
 			} else {
-- 
2.25.1

