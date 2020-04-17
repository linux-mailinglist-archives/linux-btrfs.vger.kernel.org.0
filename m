Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D52F1AD71C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 09:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgDQHKe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 03:10:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:58012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728419AbgDQHKe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 03:10:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E110BADBE;
        Fri, 17 Apr 2020 07:10:32 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Marek Behun <marek.behun@nic.cz>
Subject: [PATCH] btrfs-progs: Remove the duplicated @level parameter for btrfs_bin_search()
Date:   Fri, 17 Apr 2020 15:10:29 +0800
Message-Id: <20200417071029.66979-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can easily get the level from @eb parameter, thus the level is not
needed.

This is inspired by the work of Marek in U-boot.

Cc: Marek Behun <marek.behun@nic.cz>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 2 +-
 ctree.c      | 6 +++---
 ctree.h      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/check/main.c b/check/main.c
index c51dad8f2c89..be980c152274 100644
--- a/check/main.c
+++ b/check/main.c
@@ -6478,7 +6478,7 @@ static int run_next_block(struct btrfs_root *root,
 		 * technically unreferenced and don't need to be worried about.
 		 */
 		if (ri != NULL && ri->drop_level && level > ri->drop_level) {
-			ret = btrfs_bin_search(buf, &ri->drop_key, level, &i);
+			ret = btrfs_bin_search(buf, &ri->drop_key, &i);
 			if (ret && i > 0)
 				i--;
 		}
diff --git a/ctree.c b/ctree.c
index 97b44d48dc85..8c4287cfc5e3 100644
--- a/ctree.c
+++ b/ctree.c
@@ -666,9 +666,9 @@ static int generic_bin_search(struct extent_buffer *eb, unsigned long p,
  * leaves vs nodes
  */
 int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
-		     int level, int *slot)
+		     int *slot)
 {
-	if (level == 0)
+	if (btrfs_header_level(eb) == 0)
 		return generic_bin_search(eb,
 					  offsetof(struct btrfs_leaf, items),
 					  sizeof(struct btrfs_item),
@@ -1199,7 +1199,7 @@ again:
 		ret = check_block(fs_info, p, level);
 		if (ret)
 			return -1;
-		ret = btrfs_bin_search(b, key, level, &slot);
+		ret = btrfs_bin_search(b, key, &slot);
 		if (level != 0) {
 			if (ret && slot > 0)
 				slot -= 1;
diff --git a/ctree.h b/ctree.h
index 1f7daefbf830..a47fbee6489f 100644
--- a/ctree.h
+++ b/ctree.h
@@ -1756,7 +1756,7 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
                                struct btrfs_path *p, int find_higher,
                                int return_any);
 int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
-		     int level, int *slot);
+		     int *slot);
 int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path *found_path,
 		u64 iobjectid, u64 ioff, u8 key_type,
 		struct btrfs_key *found_key);
-- 
2.26.0

