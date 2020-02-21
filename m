Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B171D168371
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 17:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgBUQb1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 11:31:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:43724 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgBUQb0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 11:31:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DCE97AEEC;
        Fri, 21 Feb 2020 16:31:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7D1E4DA70E; Fri, 21 Feb 2020 17:31:08 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 04/11] btrfs: open code trivial helper btrfs_header_chunk_tree_uuid
Date:   Fri, 21 Feb 2020 17:31:08 +0100
Message-Id: <67db92c27cbc6af0f5a120eff73b9efb3b281999.1582302545.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1582302545.git.dsterba@suse.com>
References: <cover.1582302545.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The helper btrfs_header_chunk_tree_uuid follows naming convention of
other struct accessors but does something compeletly different. As the
offsetof calculation is clear in the context of extent buffer operations
we can remove it.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h   | 5 -----
 fs/btrfs/disk-io.c | 3 ++-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6f4272006029..d7e54cbc8dce 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1976,11 +1976,6 @@ static inline void btrfs_set_header_backref_rev(struct extent_buffer *eb,
 	btrfs_set_header_flags(eb, flags);
 }
 
-static inline unsigned long btrfs_header_chunk_tree_uuid(const struct extent_buffer *eb)
-{
-	return offsetof(struct btrfs_header, chunk_tree_uuid);
-}
-
 static inline int btrfs_is_leaf(const struct extent_buffer *eb)
 {
 	return btrfs_header_level(eb) == 0;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 63d009816264..77e1b66ebcfb 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3093,7 +3093,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	chunk_root->commit_root = btrfs_root_node(chunk_root);
 
 	read_extent_buffer(chunk_root->node, fs_info->chunk_tree_uuid,
-	   btrfs_header_chunk_tree_uuid(chunk_root->node), BTRFS_UUID_SIZE);
+			   offsetof(struct btrfs_header, chunk_tree_uuid),
+			   BTRFS_UUID_SIZE);
 
 	ret = btrfs_read_chunk_tree(fs_info);
 	if (ret) {
-- 
2.25.0

