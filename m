Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7100468F2B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 03:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbhLFCdm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Dec 2021 21:33:42 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51888 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbhLFCdl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Dec 2021 21:33:41 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 239CE1FD5F
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 02:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638757813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5QbHCJEQ0zg9iOEkjlT8eDJEhk/3WEisOO9BqRfuoQw=;
        b=sZZvZYtDxKgzgjO0L26knakbDdiNzMEvehiUnTb2YqWZVozpgCLgKznqvj4IeOADB28zw1
        twHlRDDBPjbKVklsGJBWn3ghCIvlDINj5KXDReuyiCPuhoJa56DftiopRufHqCosA1Ctmv
        ixrDTApuEB6CqZlCxinowod8cUVBPeU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7690513451
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 02:30:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8DVMELR1rWFEMgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Dec 2021 02:30:12 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 13/17] btrfs: allow btrfs_map_bio() to split bio according to chunk stripe boundaries
Date:   Mon,  6 Dec 2021 10:29:33 +0800
Message-Id: <20211206022937.26465-14-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206022937.26465-1-wqu@suse.com>
References: <20211206022937.26465-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the new btrfs_bio_split() helper, we are able to split bio
according to chunk stripe boundaries at btrfs_map_bio() time.

Although currently due bio split at buffered/compressed/direct IO time,
this ability is not yet utilized.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 50 +++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6d962450e355..301fc34320ed 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6879,30 +6879,44 @@ static int submit_one_mapped_range(struct btrfs_fs_info *fs_info, struct bio *bi
 blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			   int mirror_num)
 {
-	u64 logical = bio->bi_iter.bi_sector << 9;
-	u64 length = 0;
-	u64 map_length;
+	const u64 orig_logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
+	const unsigned int orig_length = bio->bi_iter.bi_size;
+	const enum btrfs_map_op op = btrfs_op(bio);
+	u64 cur_logical = orig_logical;
 	int ret;
-	struct btrfs_io_context *bioc = NULL;
 
-	length = bio->bi_iter.bi_size;
-	map_length = length;
+	while (cur_logical < orig_logical + orig_length) {
+		u64 map_length = orig_logical + orig_length - cur_logical;
+		struct btrfs_io_context *bioc = NULL;
+		struct bio *cur_bio;
 
-	btrfs_bio_counter_inc_blocked(fs_info);
-	btrfs_bio_save_iter(btrfs_bio(bio));
-	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical,
-				&map_length, &bioc, mirror_num, 1);
-	if (ret) {
-		btrfs_bio_counter_dec(fs_info);
-		return errno_to_blk_status(ret);
-	}
+		btrfs_bio_save_iter(btrfs_bio(bio));
+		ret = __btrfs_map_block(fs_info, op, cur_logical, &map_length,
+					&bioc, mirror_num, 1);
+		if (ret)
+			return errno_to_blk_status(ret);
 
-	ret = submit_one_mapped_range(fs_info, bio, bioc, map_length, mirror_num);
-	if (ret < 0) {
+		if (cur_logical + map_length < orig_logical + orig_length) {
+			/*
+			 * For now zoned write should never cross stripe
+			 * boundary
+			 */
+			ASSERT(bio_op(bio) != REQ_OP_ZONE_APPEND);
+
+			/* Split the bio */
+			cur_bio = btrfs_bio_split(fs_info, bio, map_length);
+		} else {
+			/* Use the existing bio directly */
+			cur_bio = bio;
+		}
+		btrfs_bio_counter_inc_blocked(fs_info);
+		ret = submit_one_mapped_range(fs_info, cur_bio, bioc,
+					      map_length, mirror_num);
 		btrfs_bio_counter_dec(fs_info);
-		return errno_to_blk_status(ret);
+		if (ret < 0)
+			return errno_to_blk_status(ret);
+		cur_logical += map_length;
 	}
-	btrfs_bio_counter_dec(fs_info);
 	return BLK_STS_OK;
 }
 
-- 
2.34.1

