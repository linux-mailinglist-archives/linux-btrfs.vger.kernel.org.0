Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2D23A58D6
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhFMNnR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:43:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55474 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbhFMNnP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:43:15 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 907581FD32;
        Sun, 13 Jun 2021 13:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3HfZshoc5LhmJs51ERO/QjKdagzVSJhmIg8h3TlxejE=;
        b=awfbiFCnTmYBhYFb7SRrzPnHwop65b7T4x/4EyGlHLNBD9TJPmlz6jz668vuOHVTrB1wfz
        8l8WdFz9uGQ3B672J1TvIi5X0bY6JYtrDLDd7LUQOt2iYZYpxGbGXlodJBMIo3LAWYRR3L
        WkmGddYBOnKbGueiVCbvleFMm4JoHug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591673;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3HfZshoc5LhmJs51ERO/QjKdagzVSJhmIg8h3TlxejE=;
        b=gEtDOImmM/VEQrylLonFrunctZzzTBfEIkc5OdqMbf8PBNgdFv48sM2370GpgJpLQrMJAC
        pZs0zWjJyYPibpCA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 33DA0118DD;
        Sun, 13 Jun 2021 13:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3HfZshoc5LhmJs51ERO/QjKdagzVSJhmIg8h3TlxejE=;
        b=awfbiFCnTmYBhYFb7SRrzPnHwop65b7T4x/4EyGlHLNBD9TJPmlz6jz668vuOHVTrB1wfz
        8l8WdFz9uGQ3B672J1TvIi5X0bY6JYtrDLDd7LUQOt2iYZYpxGbGXlodJBMIo3LAWYRR3L
        WkmGddYBOnKbGueiVCbvleFMm4JoHug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591673;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3HfZshoc5LhmJs51ERO/QjKdagzVSJhmIg8h3TlxejE=;
        b=gEtDOImmM/VEQrylLonFrunctZzzTBfEIkc5OdqMbf8PBNgdFv48sM2370GpgJpLQrMJAC
        pZs0zWjJyYPibpCA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id jS1nAfkKxmCkJAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:41:13 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 27/31] btrfs: Rename end_bio_extent_readpage to btrfs_readpage_endio
Date:   Sun, 13 Jun 2021 08:39:55 -0500
Message-Id: <44c8d4d3345eeef03be7ed7c9e78e22f6c827dab.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Also, declare it in extent_io.h so it may be used by bio submission
function.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent_io.c | 12 ++++++------
 fs/btrfs/extent_io.h |  1 +
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 71a59fbeffe1..b0a01e3e4e7f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2970,7 +2970,7 @@ static void begin_page_read(struct btrfs_fs_info *fs_info, struct page *page)
 /*
  * Find extent buffer for a givne bytenr.
  *
- * This is for end_bio_extent_readpage(), thus we can't do any unsafe locking
+ * This is for btrfs_readpage_endio(), thus we can't do any unsafe locking
  * in endio context.
  */
 static struct extent_buffer *find_extent_buffer_readpage(
@@ -3007,7 +3007,7 @@ static struct extent_buffer *find_extent_buffer_readpage(
  * Scheduling is not allowed, so the extent state tree is expected
  * to have one and only one object corresponding to this IO.
  */
-static void end_bio_extent_readpage(struct bio *bio)
+void btrfs_readpage_endio(struct bio *bio)
 {
 	struct bio_vec *bvec;
 	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
@@ -3035,7 +3035,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		u32 len;
 
 		btrfs_debug(fs_info,
-			"end_bio_extent_readpage: bi_sector=%llu, err=%d, mirror=%u",
+			"btrfs_readpage_endio: bi_sector=%llu, err=%d, mirror=%u",
 			bio->bi_iter.bi_sector, bio->bi_status,
 			io_bio->mirror_num);
 		tree = &BTRFS_I(inode)->io_tree;
@@ -3687,7 +3687,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		ret = submit_extent_page(REQ_OP_READ | read_flags, NULL,
 					 bio_ctrl, page, disk_bytenr, iosize,
 					 pg_offset,
-					 end_bio_extent_readpage, 0,
+					 btrfs_readpage_endio, 0,
 					 this_bio_flag,
 					 force_bio_submit);
 		if (!ret) {
@@ -6411,7 +6411,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	ret = submit_extent_page(REQ_OP_READ | REQ_META, NULL, &bio_ctrl,
 				 page, eb->start, eb->len,
 				 eb->start - page_offset(page),
-				 end_bio_extent_readpage, mirror_num, 0,
+				 btrfs_readpage_endio, mirror_num, 0,
 				 true);
 	if (ret) {
 		/*
@@ -6513,7 +6513,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 			ClearPageError(page);
 			err = submit_extent_page(REQ_OP_READ | REQ_META, NULL,
 					 &bio_ctrl, page, page_offset(page),
-					 PAGE_SIZE, 0, end_bio_extent_readpage,
+					 PAGE_SIZE, 0, btrfs_readpage_endio,
 					 mirror_num, 0, false);
 			if (err) {
 				/*
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 62027f551b44..e3685b071eba 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -287,6 +287,7 @@ int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 		      unsigned int pg_offset, int mirror_num);
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end);
 int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num);
+void btrfs_readpage_endio(struct bio *bio);
 
 /*
  * When IO fails, either with EIO or csum verification fails, we
-- 
2.31.1

