Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04A0D18F2C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Mar 2020 11:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgCWK0A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Mar 2020 06:26:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:39428 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbgCWKZ7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 06:25:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C01DBAF79
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Mar 2020 10:25:58 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 33/40] btrfs: backref: Only ignore reloc roots for indrect backref resolve if the backref cache is for reloction purpose
Date:   Mon, 23 Mar 2020 18:24:09 +0800
Message-Id: <20200323102416.112862-34-wqu@suse.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200323102416.112862-1-wqu@suse.com>
References: <20200323102416.112862-1-wqu@suse.com>
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
 fs/btrfs/backref.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 474adc80783a..921f722e674a 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2701,7 +2701,17 @@ static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
 		/* tree root */
 		ASSERT(btrfs_root_bytenr(&root->root_item) ==
 		       cur->bytenr);
-		if (btrfs_should_ignore_reloc_root(root)) {
+		/*
+		 * For reloc backref cache, we may ignore reloc root.
+		 * But for generic purposed backref cache, we can't rely
+		 * on btrfs_should_ignore_reloc_root() as it may conflict with
+		 * current running relocation and lead to missing root.
+		 *
+		 * For generic purposed backref cache, reloc root detection
+		 * is completely relying on direct backref (key->offset is
+		 * parent bytenr), thus only do such check for reloc cache.
+		 */
+		if (btrfs_should_ignore_reloc_root(root) && cache->is_reloc) {
 			btrfs_put_root(root);
 			list_add(&cur->list, &cache->useless_node);
 		} else {
@@ -2742,7 +2752,9 @@ static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
 		if (!path->nodes[level]) {
 			ASSERT(btrfs_root_bytenr(&root->root_item) ==
 			       lower->bytenr);
-			if (btrfs_should_ignore_reloc_root(root)) {
+			/* Same as previous should_ignore_reloc_root() call */
+			if (btrfs_should_ignore_reloc_root(root) &&
+			    cache->is_reloc) {
 				btrfs_put_root(root);
 				list_add(&lower->list, &cache->useless_node);
 			} else {
-- 
2.25.2

