Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA415877D7
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 09:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbiHBHbc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 03:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbiHBHb3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 03:31:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5FB140AD
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 00:31:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DF36A202F1;
        Tue,  2 Aug 2022 07:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659425484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NaxNBnH3A1gl57mCmWHpQ579SAV3I40KPSeoge40YMM=;
        b=BRo8vG5yMrQ9w7TvxV4CMd3vTaNiBX0DCkuxN8hSbzT42WW9bsWk0ItWHR69jrhPfcg8lN
        t1au4dIPLF6q2fSynFKJb9oCiIofS+jjk912UMSTXEpLLX8Wf4lylxFysrLYUlmNFVcfHk
        FjOfNB4mx7DT8gEcPlPWMpjCKrcgNr4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C10A13A8E;
        Tue,  2 Aug 2022 07:31:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lp5zMsvS6GKvMAAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 02 Aug 2022 07:31:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] btrfs-progs: avoid repeated data write for metadata
Date:   Tue,  2 Aug 2022 15:31:05 +0800
Message-Id: <cdfef9acd4b34751791cafc49612a35328847847.1659425462.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Shinichiro reported that "mkfs.btrfs -m DUP" is doing repeated write
into the device.
For non-zoned device this is not a big deal, but for zoned device this
is critical, as zoned device doesn't support overwrite at all.

[CAUSE]
The problem is related to write_and_map_eb() call, since commit
2a93728391a1 ("btrfs-progs: use write_data_to_disk() to replace
write_extent_to_disk()"), we call write_data_to_disk() for metadata
write back.

But the problem is, write_data_to_disk() will call btrfs_map_block()
with rw = WRITE.

By that btrfs_map_block() will always return all stripes, while in
write_data_to_disk() we also iterate through each mirror of the range.

This results above repeated writeback.

[FIX]
To avoid any further confusion, completely remove the @mirror arugument
of write_data_to_disk().

Furthermore, since write_data_to_disk() will properly handle RAID56 all
by itself, no need to handle RAID56 differently in write_and_map_eb(),
just call write_data_to_disk() to handle everything.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 2a93728391a1 ("btrfs-progs: use write_data_to_disk() to replace write_extent_to_disk()")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c              |  2 +-
 kernel-shared/disk-io.c   | 38 +++++++++-----------------------------
 kernel-shared/extent_io.c | 10 ++++++++--
 kernel-shared/extent_io.h |  2 +-
 4 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/image/main.c b/image/main.c
index 5bcd10f021d7..6793fe4b9076 100644
--- a/image/main.c
+++ b/image/main.c
@@ -1495,7 +1495,7 @@ static int restore_one_work(struct mdrestore_struct *mdres,
 			}
 		} else if (async->start != BTRFS_SUPER_INFO_OFFSET) {
 			ret = write_data_to_disk(mdres->info, buffer,
-						 async->start, out_len, 0);
+						 async->start, out_len);
 			if (ret) {
 				error("failed to write data");
 				exit(1);
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 26b1c9aa192a..e3908bd379f1 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -452,8 +452,6 @@ struct extent_buffer* read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 int write_and_map_eb(struct btrfs_fs_info *fs_info, struct extent_buffer *eb)
 {
 	int ret;
-	int mirror_num;
-	int max_mirror;
 	u64 length;
 	u64 *raid_map = NULL;
 	struct btrfs_multi_bio *multi = NULL;
@@ -468,33 +466,15 @@ int write_and_map_eb(struct btrfs_fs_info *fs_info, struct extent_buffer *eb)
 		goto out;
 	}
 
-	/* RAID56 write back need RMW */
-	if (raid_map) {
-		ret = write_raid56_with_parity(fs_info, eb, multi,
-					       length, raid_map);
-		if (ret < 0) {
-			errno = -ret;
-			error(
-		"failed to write raid56 stripe for bytenr %llu length %llu: %m",
-				eb->start, length);
-		} else {
-			ret = 0;
-		}
-		goto out;
-	}
-
-	/* For non-RAID56, we just writeback data to each mirror */
-	max_mirror = btrfs_num_copies(fs_info, eb->start, eb->len);
-	for (mirror_num = 1; mirror_num <= max_mirror; mirror_num++) {
-		ret = write_data_to_disk(fs_info, eb->data, eb->start, eb->len,
-				         mirror_num);
-		if (ret < 0) {
-			errno = -ret;
-			error(
-		"failed to write bytenr %llu length %u to mirror %d: %m",
-				eb->start, eb->len, mirror_num);
-			goto out;
-		}
+	/*
+	 * Just call write_data_to_disk(), which will handle all
+	 * mirrors/PQ correctly.
+	 */
+	ret = write_data_to_disk(fs_info, eb->data, eb->start, eb->len);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to write bytenr %llu length %u: %m",
+			eb->start, eb->len);
 	}
 
 out:
diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index d6326ab2dc52..a05249815bb1 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -938,8 +938,14 @@ int read_data_from_disk(struct btrfs_fs_info *info, void *buf, u64 logical,
 	return 0;
 }
 
+/*
+ * Write the data in @buf to logical bytenr @offset.
+ *
+ * Such data will be written to all mirrors and RAID56 P/Q will also be
+ * properly handled.
+ */
 int write_data_to_disk(struct btrfs_fs_info *info, void *buf, u64 offset,
-		      u64 bytes, int mirror)
+		       u64 bytes)
 {
 	struct btrfs_multi_bio *multi = NULL;
 	struct btrfs_device *device;
@@ -956,7 +962,7 @@ int write_data_to_disk(struct btrfs_fs_info *info, void *buf, u64 offset,
 		dev_nr = 0;
 
 		ret = btrfs_map_block(info, WRITE, offset, &this_len, &multi,
-				      mirror, &raid_map);
+				      0, &raid_map);
 		if (ret) {
 			fprintf(stderr, "Couldn't map the block %llu\n",
 				offset);
diff --git a/kernel-shared/extent_io.h b/kernel-shared/extent_io.h
index fc2e4cc455d6..2148a8112428 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -162,7 +162,7 @@ int clear_extent_buffer_dirty(struct extent_buffer *eb);
 int read_data_from_disk(struct btrfs_fs_info *info, void *buf, u64 logical,
 			u64 *len, int mirror);
 int write_data_to_disk(struct btrfs_fs_info *info, void *buf, u64 offset,
-		       u64 bytes, int mirror);
+		       u64 bytes);
 void extent_buffer_bitmap_clear(struct extent_buffer *eb, unsigned long start,
                                 unsigned long pos, unsigned long len);
 void extent_buffer_bitmap_set(struct extent_buffer *eb, unsigned long start,
-- 
2.37.0

