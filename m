Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987153725CC
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 May 2021 08:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhEDG03 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 May 2021 02:26:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:49958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229773AbhEDG03 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 May 2021 02:26:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620109534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KAvWGoZpjMWKnUlvBdiMuvuubFzJ1HBM4J3lo3l4BnY=;
        b=YvDnmw1LHxRxmQqfK+7oT8QUpN7GdBLZr5CpreWs4wIEnssNvKaKUmEvrFfcNn2i0M1o79
        GOH2UnNRi8knZFjGt/U487Kucc5nIfB/mNHAxdTBHDYtXXllKPf7pqPZNefWTau7ey6v29
        6UStplq1xyfYyJzjqtZ6VSaaW2jrRW4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 19057AE95
        for <linux-btrfs@vger.kernel.org>; Tue,  4 May 2021 06:25:34 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs-progs: check/original: detect and report mixed inline and regular data extents
Date:   Tue,  4 May 2021 14:25:23 +0800
Message-Id: <20210504062525.152540-3-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210504062525.152540-1-wqu@suse.com>
References: <20210504062525.152540-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When a btrfs filesystem has mixed inline and regular data extents, btrfs
check original mode won't detect it as an error.

Considering how much effort we have done just to avoid such cases, we
really want btrfs check to detect such problem.

This error detection is even more important for the incoming btrfs
subpage support, as subpage data rw support can cause such problem much
easier.

So this patch will just add such ability to original mode.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c          | 5 +++++
 check/mode-original.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/check/main.c b/check/main.c
index 1e65f8da4c6c..7837c3647f6f 100644
--- a/check/main.c
+++ b/check/main.c
@@ -621,6 +621,8 @@ static void print_inode_error(struct btrfs_root *root, struct inode_record *rec)
 			rec->imode & ~07777);
 	if (errors & I_ERR_INVALID_GEN)
 		fprintf(stderr, ", invalid inode generation or transid");
+	if (errors & I_ERR_MIXED_EXTENTS)
+		fprintf(stderr, ", mixed regular and inline extents");
 	fprintf(stderr, "\n");
 
 	/* Print the holes if needed */
@@ -1583,6 +1585,7 @@ static int process_file_extent(struct btrfs_root *root,
 	if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 		struct btrfs_item *item = btrfs_item_nr(slot);
 
+		rec->found_inline_extent = 1;
 		num_bytes = btrfs_file_extent_ram_bytes(eb, fi);
 		if (num_bytes == 0)
 			rec->errors |= I_ERR_BAD_FILE_EXTENT;
@@ -1602,6 +1605,8 @@ static int process_file_extent(struct btrfs_root *root,
 		num_bytes = (num_bytes + mask) & ~mask;
 	} else if (extent_type == BTRFS_FILE_EXTENT_REG ||
 		   extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
+		if (rec->found_inline_extent)
+			rec->errors |= I_ERR_MIXED_EXTENTS;
 		num_bytes = btrfs_file_extent_num_bytes(eb, fi);
 		disk_bytenr = btrfs_file_extent_disk_bytenr(eb, fi);
 		extent_offset = btrfs_file_extent_offset(eb, fi);
diff --git a/check/mode-original.h b/check/mode-original.h
index b075a95c9757..f7efc06ec7c7 100644
--- a/check/mode-original.h
+++ b/check/mode-original.h
@@ -186,6 +186,7 @@ struct unaligned_extent_rec_t {
 #define I_ERR_MISMATCH_DIR_HASH		(1 << 18)
 #define I_ERR_INVALID_IMODE		(1 << 19)
 #define I_ERR_INVALID_GEN		(1 << 20)
+#define I_ERR_MIXED_EXTENTS		(1 << 21)
 
 struct inode_record {
 	struct list_head backrefs;
@@ -197,6 +198,7 @@ struct inode_record {
 	unsigned int found_csum_item:1;
 	unsigned int some_csum_missing:1;
 	unsigned int nodatasum:1;
+	unsigned int found_inline_extent:1;
 	int errors;
 
 	struct list_head unaligned_extent_recs;
-- 
2.31.1

