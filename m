Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195C7530740
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 May 2022 03:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiEWBtB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 May 2022 21:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351943AbiEWBtA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 May 2022 21:49:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02DC13FB9
        for <linux-btrfs@vger.kernel.org>; Sun, 22 May 2022 18:48:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8C1E721A3E
        for <linux-btrfs@vger.kernel.org>; Mon, 23 May 2022 01:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653270537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WHdYwmtHdlTcvAbuA9YBaWo33zRl4G/4uBylwI6PupA=;
        b=GDR8FT0PQCWE3vd+tUahfdR/n6q/1n9YQWKMlPDhMxQLAcmFfjBebak23atcXOxd/qyTq7
        eixiCMCZSGfogKrXu9yRh/iNVEoUsqA1IGASifQsHp7ukYQ5BtOVc3x+sEP4533Fyq4ERE
        5gtl2Rde6vXZD4IsiOupGEVXH3/j/sA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC62E13ADF
        for <linux-btrfs@vger.kernel.org>; Mon, 23 May 2022 01:48:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kFTyKAjoimLzOQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 23 May 2022 01:48:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/7] btrfs: add new read repair infrastructure
Date:   Mon, 23 May 2022 09:48:28 +0800
Message-Id: <c79f35aea568ff3c1aa9b68b1bd6ea923d44e72a.1653270322.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1653270322.git.wqu@suse.com>
References: <cover.1653270322.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new infrastructure only has one function,
btrfs_read_repair_sector(), which will try to get the correct content of
that sector.

The idea of the function is very straight-forward:

1) Try to read the next mirror (if possible)
2) Verify the csum (if it has)
3) Go back to 1) if csum mismatch or read failed

All the bio submission is synchronous, meaning we will wait for the
submitted bio to finish before continue.

This can be a performance bottleneck, but considering that:

- Read-repair is already a cold path
- More than one corruption in one read bio is even rarer

Thus I don't think we should spend tons of code on a very cold path, no
to mention complex code itself can be bug prone and harder to maintain.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/Makefile      |  2 +-
 fs/btrfs/read-repair.c | 74 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/read-repair.h | 13 ++++++++
 3 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 fs/btrfs/read-repair.c
 create mode 100644 fs/btrfs/read-repair.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 99f9995670ea..0b2605c750ca 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -31,7 +31,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
 	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
-	   subpage.o tree-mod-log.o
+	   subpage.o tree-mod-log.o read-repair.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/read-repair.c b/fs/btrfs/read-repair.c
new file mode 100644
index 000000000000..e3175e27bcbb
--- /dev/null
+++ b/fs/btrfs/read-repair.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bio.h>
+#include "ctree.h"
+#include "volumes.h"
+#include "read-repair.h"
+#include "btrfs_inode.h"
+
+static int get_next_mirror(int cur_mirror, int num_copies)
+{
+	/* In the context of read-repair, we never use 0 as mirror_num. */
+	ASSERT(cur_mirror);
+	return (cur_mirror + 1 > num_copies) ? (cur_mirror + 1 - num_copies) :
+		cur_mirror + 1;
+}
+
+static int get_prev_mirror(int cur_mirror, int num_copies)
+{
+	/* In the context of read-repair, we never use 0 as mirror_num. */
+	ASSERT(cur_mirror);
+	return (cur_mirror - 1 <= 0) ? (num_copies) : cur_mirror - 1;
+}
+
+int btrfs_read_repair_sector(struct inode *inode,
+			     struct page *page, unsigned int pgoff,
+			     u64 logical, u64 file_off, int failed_mirror,
+			     int num_copies, u8 *expected_csum)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	bool uptodate = false;
+	int i;
+
+	/* No more mirrors to retry. */
+	if (num_copies <= 1)
+		return -EIO;
+
+	for (i = get_next_mirror(failed_mirror, num_copies); i != failed_mirror;
+	     i = get_next_mirror(i, num_copies)) {
+		u8 csum[BTRFS_CSUM_SIZE];
+		struct bio *read_bio;
+		int ret;
+
+		read_bio = bio_alloc(NULL, 1, REQ_OP_READ | REQ_SYNC, GFP_NOFS);
+		if (!read_bio)
+			return -EIO;
+		__bio_add_page(read_bio, page, fs_info->sectorsize, pgoff);
+		read_bio->bi_iter.bi_sector = logical >> SECTOR_SHIFT;
+
+		ret = btrfs_map_bio_wait(fs_info, read_bio, i);
+		/* Submit failed, try next mirror. */
+		if (ret < 0)
+			continue;
+
+		if (expected_csum) {
+			ret = btrfs_check_sector_csum(fs_info, page, pgoff,
+						      csum, expected_csum);
+			if (!ret)
+				uptodate = true;
+		} else {
+			uptodate = true;
+		}
+
+		if (uptodate) {
+			btrfs_repair_io_failure(fs_info,
+					btrfs_ino(BTRFS_I(inode)), file_off,
+					fs_info->sectorsize, logical, page,
+					pgoff, get_prev_mirror(i, num_copies));
+			break;
+		}
+	}
+	if (!uptodate)
+		return -EIO;
+	return 0;
+}
diff --git a/fs/btrfs/read-repair.h b/fs/btrfs/read-repair.h
new file mode 100644
index 000000000000..e984ab0b5b18
--- /dev/null
+++ b/fs/btrfs/read-repair.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_READ_REPAIR_H
+#define BTRFS_READ_REPAIR_H
+
+#include <linux/blk_types.h>
+#include <linux/fs.h>
+
+int btrfs_read_repair_sector(struct inode *inode,
+			     struct page *page, unsigned int pgoff,
+			     u64 logical, u64 file_off, int failed_mirror,
+			     int num_copies, u8 *expected_csum);
+#endif
-- 
2.36.1

