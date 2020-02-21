Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3973C16836E
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 17:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgBUQbU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 11:31:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:43670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgBUQbU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 11:31:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 180EEAFC3;
        Fri, 21 Feb 2020 16:31:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9AAA7DA70E; Fri, 21 Feb 2020 17:31:01 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 01/11] btrfs: use struct_size to calculate size of raid hash table
Date:   Fri, 21 Feb 2020 17:31:01 +0100
Message-Id: <235ac518a3bcd772e82df812a12d2283ee993087.1582302545.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1582302545.git.dsterba@suse.com>
References: <cover.1582302545.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The struct_size macro does the same calculation and is safe regarding
overflows. Though we're not expecting them to happen, use the helper for
clarity.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/raid56.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 406b1efd3ba5..c870ef70f817 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -206,7 +206,6 @@ int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info)
 	struct btrfs_stripe_hash *h;
 	int num_entries = 1 << BTRFS_STRIPE_HASH_TABLE_BITS;
 	int i;
-	int table_size;
 
 	if (info->stripe_hash_table)
 		return 0;
@@ -218,8 +217,7 @@ int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info)
 	 * Try harder to allocate and fallback to vmalloc to lower the chance
 	 * of a failing mount.
 	 */
-	table_size = sizeof(*table) + sizeof(*h) * num_entries;
-	table = kvzalloc(table_size, GFP_KERNEL);
+	table = kvzalloc(struct_size(table, table, num_entries), GFP_KERNEL);
 	if (!table)
 		return -ENOMEM;
 
-- 
2.25.0

