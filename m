Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7114647BC1
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2019 09:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfFQH7r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jun 2019 03:59:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:43800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725791AbfFQH7r (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jun 2019 03:59:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3D160AE89
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2019 07:59:45 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs-progs: Fix -Waddress-of-packed-member warning in btrfs_dev_stats_values callers
Date:   Mon, 17 Jun 2019 15:59:34 +0800
Message-Id: <20190617075936.12113-3-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617075936.12113-1-wqu@suse.com>
References: <20190617075936.12113-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
GCC 9.1.0 will report the following error when compiling btrfs-progs:

  In file included from print-tree.c:24:
  ctree.h: In function 'btrfs_dev_stats_values':
  ctree.h:2408:9: warning: taking address of packed member of 'struct btrfs_dev_stats_item' may result in an unaligned pointer value [-Waddress-of-packed-member]
   2408 |  return p->values;
        |         ^

[FIX]
Follow the kernel way of accessing dev stats by using
btrfs_dev_stats_value(eb, ptr, index).
So that we don't need to bother accessing the packed member.

This also unifies the helper function in kernel and btrfs-progs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 ctree.h      | 13 +++++++++++++
 print-tree.c | 21 ++++++---------------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/ctree.h b/ctree.h
index 8d710fcb5f72..d5ef1064a45a 100644
--- a/ctree.h
+++ b/ctree.h
@@ -2395,6 +2395,19 @@ static inline struct btrfs_disk_balance_args* btrfs_balance_item_sys(
 	return &p->sys;
 }
 
+static inline u64 btrfs_dev_stats_value(const struct extent_buffer *eb,
+					const struct btrfs_dev_stats_item *ptr,
+					int index)
+{
+	u64 val;
+
+	read_extent_buffer(eb, &val,
+			   offsetof(struct btrfs_dev_stats_item, values) +
+			    ((unsigned long)ptr) + (index * sizeof(u64)),
+			   sizeof(val));
+	return val;
+}
+
 /*
  * this returns the number of bytes used by the item on disk, minus the
  * size of any extent headers.  If a file is compressed on disk, this is
diff --git a/print-tree.c b/print-tree.c
index b5e0587d0b96..1ca683a61c35 100644
--- a/print-tree.c
+++ b/print-tree.c
@@ -953,32 +953,23 @@ static void print_balance_item(struct extent_buffer *eb,
 static void print_dev_stats(struct extent_buffer *eb,
 		struct btrfs_dev_stats_item *stats, u32 size)
 {
-	struct btrfs_dev_stats_item *item;
-	const unsigned long offset = (unsigned long)stats;
 	u32 known = BTRFS_DEV_STAT_VALUES_MAX * sizeof(__le64);
 	int i;
 
-	item = (struct btrfs_dev_stats_item *)(eb->data + offset);
-
 	printf("\t\tdevice stats\n");
 	printf("\t\twrite_errs %llu read_errs %llu flush_errs %llu corruption_errs %llu generation %llu\n",
-		(unsigned long long)get_unaligned_le64(
-				&item->values[BTRFS_DEV_STAT_WRITE_ERRS]),
-		(unsigned long long)get_unaligned_le64(
-				&item->values[BTRFS_DEV_STAT_READ_ERRS]),
-		(unsigned long long)get_unaligned_le64(
-				&item->values[BTRFS_DEV_STAT_FLUSH_ERRS]),
-		(unsigned long long)get_unaligned_le64(
-				&item->values[BTRFS_DEV_STAT_CORRUPTION_ERRS]),
-		(unsigned long long)get_unaligned_le64(
-				&item->values[BTRFS_DEV_STAT_GENERATION_ERRS]));
+	      btrfs_dev_stats_value(eb, stats, BTRFS_DEV_STAT_WRITE_ERRS),
+	      btrfs_dev_stats_value(eb, stats, BTRFS_DEV_STAT_READ_ERRS),
+	      btrfs_dev_stats_value(eb, stats, BTRFS_DEV_STAT_FLUSH_ERRS),
+	      btrfs_dev_stats_value(eb, stats, BTRFS_DEV_STAT_CORRUPTION_ERRS),
+	      btrfs_dev_stats_value(eb, stats, BTRFS_DEV_STAT_GENERATION_ERRS));
 
 	if (known < size) {
 		printf("\t\tunknown stats item bytes %u", size - known);
 		for (i = BTRFS_DEV_STAT_VALUES_MAX; i * sizeof(__le64) < size; i++) {
 			printf("\t\tunknown item %u offset %zu value %llu\n",
 				i, i * sizeof(__le64),
-				(unsigned long long)le64_to_cpu(&item->values[i]));
+				btrfs_dev_stats_value(eb, stats, i));
 		}
 	}
 }
-- 
2.22.0

