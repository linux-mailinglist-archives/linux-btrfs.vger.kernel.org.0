Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38790587868
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 09:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiHBHxF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 03:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiHBHxE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 03:53:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213CCC71
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 00:53:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C2C5234BA9;
        Tue,  2 Aug 2022 07:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659426781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2JzJeASOh8c84THBuwTwnuLCzB8lGjr6eBqd/OUcyRM=;
        b=NWRHpdUlTdVgdlRXTDl0k9VV3BmLcT4zl7yLRAZ9UmuL1FLddiXxktwMqnyYKtUdS9ofgS
        YxXFvYZfqjGVy2YI4jseSblK1x7kvqkwYoT8RIs/f67wy80S5vFcgW3O/j/H3M2pSFPzhd
        nr1C49rhVK2xwlGm2VRNcgVW/W6/CGw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0BC3D13A8E;
        Tue,  2 Aug 2022 07:53:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +MCpM9zX6GKlOgAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 02 Aug 2022 07:53:00 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 1/3] btrfs-progs: avoid repeated data write for metadata
Date:   Tue,  2 Aug 2022 15:52:41 +0800
Message-Id: <e314ee1a9d4866b5074bf7621c5265e16293cc3e.1659426744.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1659426744.git.wqu@suse.com>
References: <cover.1659426744.git.wqu@suse.com>
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
Fix this problem by completely remove @mirror argument
from write_data_to_disk().
With extra comments to explicitly show that function will write to
all mirrors.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 2a93728391a1 ("btrfs-progs: use write_data_to_disk() to replace write_extent_to_disk()")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c              |  2 +-
 kernel-shared/disk-io.c   | 24 ++++++++++--------------
 kernel-shared/extent_io.c | 10 ++++++++--
 kernel-shared/extent_io.h |  2 +-
 4 files changed, 20 insertions(+), 18 deletions(-)

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
index 26b1c9aa192a..a6e66aee7bf7 100644
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
@@ -483,18 +481,16 @@ int write_and_map_eb(struct btrfs_fs_info *fs_info, struct extent_buffer *eb)
 		goto out;
 	}
 
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
+	 * For non-RAID56, we just writeback data to all mirrors using
+	 * write_data_to_disk().
+	 */
+	ret = write_data_to_disk(fs_info, eb->data, eb->start, eb->len);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to write bytenr %llu length %u: %m",
+			eb->start, eb->len);
+		goto out;
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

