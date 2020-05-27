Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF4A1E3EF8
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 12:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387950AbgE0K2S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 06:28:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:44514 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387899AbgE0K2R (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 06:28:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A1518ABE3
        for <linux-btrfs@vger.kernel.org>; Wed, 27 May 2020 10:28:19 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/6] btrfs-progs: Allow btrfs_print_leaf() to be called on dummy eb whose fs_info is NULL
Date:   Wed, 27 May 2020 18:28:05 +0800
Message-Id: <20200527102810.147999-2-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527102810.147999-1-wqu@suse.com>
References: <20200527102810.147999-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In certain call sites, like btrfs-image, we want full extent_buffer
accessors, but don't have a btrfs_fs_info.

In that case, if an extent buffer whose fs_info is NULL, then
btrfs_print_leaf() is called on such eb, we will trigger a NULL pointer
dereference, at BTRFS_LEAF_DATA_SIZE(fs_info).

Fix this by using __BTRFS_LEAF_DATA_SIZE(), which only needs nodesize,
and nodesize can be extracted from extent_buffer::len.

This allows us to call btrfs_print_leaf() on any extent buffer, which is
super handy in gdb.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 print-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/print-tree.c b/print-tree.c
index 27acadb22205..38cf8d34ac2e 100644
--- a/print-tree.c
+++ b/print-tree.c
@@ -1201,7 +1201,7 @@ void btrfs_print_leaf(struct extent_buffer *eb)
 	struct btrfs_item *item;
 	struct btrfs_disk_key disk_key;
 	char flags_str[128];
-	u32 leaf_data_size = BTRFS_LEAF_DATA_SIZE(fs_info);
+	u32 leaf_data_size = __BTRFS_LEAF_DATA_SIZE(eb->len);
 	u32 i;
 	u32 nr;
 	u64 flags;
-- 
2.26.2

