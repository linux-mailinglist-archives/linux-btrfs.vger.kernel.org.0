Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3BC2590E0
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 16:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgIAOlH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 10:41:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:56364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbgIAOkh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Sep 2020 10:40:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87FB2B65B;
        Tue,  1 Sep 2020 14:40:04 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 5/5] btrfs: improve error message in setup_items_for_insert
Date:   Tue,  1 Sep 2020 17:40:01 +0300
Message-Id: <20200901144001.4265-6-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901144001.4265-1-nborisov@suse.com>
References: <20200901144001.4265-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While at it also print the leaf content after the error.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index bb89c0954ca1..2c3f78cc6aa2 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4799,9 +4799,9 @@ void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *path,
 		unsigned int old_data = btrfs_item_end_nr(leaf, slot);
 
 		if (old_data < data_end) {
-			btrfs_print_leaf(leaf);
-			btrfs_crit(fs_info, "slot %d old_data %d data_end %d",
+			btrfs_crit(fs_info, "item's (slot %d) data offset (%d) beyond data end of leaf (%d)",
 				   slot, old_data, data_end);
+			btrfs_print_leaf(leaf);
 			BUG();
 		}
 		/*
-- 
2.17.1

