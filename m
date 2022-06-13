Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB774548041
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 09:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbiFMHHV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 03:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238839AbiFMHG5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 03:06:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA1A19022
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 00:06:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4DD7E1F98F
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 07:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655104015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KAjWrd8ckaCLtxC0eNSiNN6q1Bi1IQCCF5aHKcufwVw=;
        b=MpcV1Sjb5zoHaGbB7dSxHlidvz8LJLsnAL78swtH7Sv5VNR8di8ty4bIAV/9l8T2biB2v9
        3wgafWlaRz3at2cAbPy0SyihP2U9A/5SGdLhWR7apwZ9mZzrgg8D3z0popyid9iYAqds9g
        GZPvnuGY2n+/GT/1+HyichlR6v8ZTqw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EAAD134CF
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 07:06:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mEhWFA7ipmJUCgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 07:06:54 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: introduce BTRFS_DEFAULT_RESERVED macro
Date:   Mon, 13 Jun 2022 15:06:34 +0800
Message-Id: <51b17f7480724d528e709a920acd026acff447ea.1655103954.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655103954.git.wqu@suse.com>
References: <cover.1655103954.git.wqu@suse.com>
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

Since btrfs-progs v4.1, mkfs.btrfs will reserve the first 1MiB for the
primary super block (at offset 64KiB) and other legacy bootloaders which
may want to store their data there.

Kernel is doing the same behavior around the same time.

However in kernel we just use SZ_1M to express the reserved space, normally
with extra comments when using above SZ_1M.

Here we introduce a new macro, BTRFS_DEFAULT_RESERVED to replace such
SZ_1M usage.

This will make later enlarged per-dev reservation easier to implement.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h       |  7 +++++++
 fs/btrfs/extent-tree.c |  6 +++---
 fs/btrfs/super.c       | 10 +++++-----
 fs/btrfs/volumes.c     |  7 +------
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f7afdfd0bae7..62028e7d5799 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -229,6 +229,13 @@ struct btrfs_root_backup {
 #define BTRFS_SUPER_INFO_OFFSET			SZ_64K
 #define BTRFS_SUPER_INFO_SIZE			4096
 
+/*
+ * The default reserved space for each device.
+ * This range covers the primary superblock, and some other legacy programs like
+ * older bootloader may want to store their data there.
+ */
+#define BTRFS_DEFAULT_RESERVED			(SZ_1M)
+
 /*
  * the super block basically lists the main trees of the FS
  * it currently lacks any block count etc etc
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 8e9f0a99b292..e384dd483eaa 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5976,7 +5976,7 @@ int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
  */
 static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 {
-	u64 start = SZ_1M, len = 0, end = 0;
+	u64 start = BTRFS_DEFAULT_RESERVED, len = 0, end = 0;
 	int ret;
 
 	*trimmed = 0;
@@ -6020,8 +6020,8 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 			break;
 		}
 
-		/* Ensure we skip the reserved area in the first 1M */
-		start = max_t(u64, start, SZ_1M);
+		/* Ensure we skip the reserved area of each device. */
+		start = max_t(u64, start, BTRFS_DEFAULT_RESERVED);
 
 		/*
 		 * If find_first_clear_extent_bit find a range that spans the
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 719dda57dc7a..c2d051e887be 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2273,16 +2273,16 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 
 		/*
 		 * In order to avoid overwriting the superblock on the drive,
-		 * btrfs starts at an offset of at least 1MB when doing chunk
-		 * allocation.
+		 * btrfs has some reserved space at the beginning of each
+		 * device.
 		 *
 		 * This ensures we have at least min_stripe_size free space
-		 * after excluding 1MB.
+		 * after excluding that reserved space.
 		 */
-		if (avail_space <= SZ_1M + min_stripe_size)
+		if (avail_space <= BTRFS_DEFAULT_RESERVED + min_stripe_size)
 			continue;
 
-		avail_space -= SZ_1M;
+		avail_space -= BTRFS_DEFAULT_RESERVED;
 
 		devices_info[i].dev = device;
 		devices_info[i].max_avail = avail_space;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 12a6150ee19d..051d124679d1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1396,12 +1396,7 @@ static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
 {
 	switch (device->fs_devices->chunk_alloc_policy) {
 	case BTRFS_CHUNK_ALLOC_REGULAR:
-		/*
-		 * We don't want to overwrite the superblock on the drive nor
-		 * any area used by the boot loader (grub for example), so we
-		 * make sure to start at an offset of at least 1MB.
-		 */
-		return max_t(u64, start, SZ_1M);
+		return max_t(u64, start, BTRFS_DEFAULT_RESERVED);
 	case BTRFS_CHUNK_ALLOC_ZONED:
 		/*
 		 * We don't care about the starting region like regular
-- 
2.36.1

