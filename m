Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAF41E0707
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 08:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388455AbgEYGdp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 02:33:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:60950 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388704AbgEYGdo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 02:33:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0DF60AF4C;
        Mon, 25 May 2020 06:33:45 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
Cc:     marek.behun@nic.cz
Subject: [PATCH U-BOOT v2 12/30] fs: btrfs: Cross port struct btrfs_root to ctree.h
Date:   Mon, 25 May 2020 14:32:39 +0800
Message-Id: <20200525063257.46757-13-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525063257.46757-1-wqu@suse.com>
References: <20200525063257.46757-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With write related members deleted.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index cad46b775807..ee42539a67c8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -69,6 +69,23 @@ enum btrfs_tree_block_status {
 	BTRFS_TREE_BLOCK_INVALID_OFFSETS,
 };
 
+struct btrfs_root {
+	struct extent_buffer *node;
+	struct btrfs_root_item root_item;
+	struct btrfs_key root_key;
+	struct btrfs_fs_info *fs_info;
+	u64 objectid;
+	u64 last_trans;
+
+	int ref_cows;
+	int track_dirty;
+
+	u32 type;
+	u64 last_inode_alloc;
+
+	struct rb_node rb_node;
+};
+
 struct btrfs_device;
 struct btrfs_fs_devices;
 struct btrfs_fs_info {
-- 
2.26.2

