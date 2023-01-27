Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6AE67DD30
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 06:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjA0Fls (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 00:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjA0Flp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 00:41:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449EB721FB
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 21:41:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 064C31FF5E
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 05:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674798102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k5U7X7WmI96snEVUO0HsUsDvrq3hPR2AJiRrcOAGhUY=;
        b=lkhEhVktCorQzh/c8txVJa4JvsZKZIM2dgkIS9BWoSlgxiWdcKsY12OfEwL9NjWyvp70Sv
        vPXQJQyJakMpC2L1nUfMyrqcouiy/yAhadwKMu+TeR1rdxSV7Fwvu3ksGzNvDj3WkdBBYw
        6Jxr7KTsXjTf9IkBUyDk5qusoMM3Ies=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B246134F5
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 05:41:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uFSjCRVk02OnLwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 05:41:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs-progs: fix set but not used variables
Date:   Fri, 27 Jan 2023 13:41:18 +0800
Message-Id: <d238d59fd6a9a1b52eafaabd2cf15f0a88a3c993.1674797823.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674797823.git.wqu@suse.com>
References: <cover.1674797823.git.wqu@suse.com>
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

[WARNING]
Clang 15.0.7 warns about several unused variables:

  kernel-shared/zoned.c:829:6: warning: variable 'num_sequential' set but not used [-Wunused-but-set-variable]
          u32 num_sequential = 0, num_conventional = 0;
              ^
  cmds/scrub.c:1174:6: warning: variable 'n_skip' set but not used [-Wunused-but-set-variable]
          int n_skip = 0;
              ^
  mkfs/main.c:493:6: warning: variable 'total_block_count' set but not used [-Wunused-but-set-variable]
          u64 total_block_count = 0;
              ^
  image/main.c:2246:6: warning: variable 'bytenr' set but not used [-Wunused-but-set-variable]
          u64 bytenr = 0;
              ^

[CAUSE]
Most of them just straightforward set but not used variables.

The only exception is total_block_count, which has commented out code
relying on it.

[FIX]
Just remove those variables, and for @total_block_count, also remove the
comments.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/scrub.c          | 2 --
 image/main.c          | 3 ---
 kernel-shared/zoned.c | 6 ++----
 mkfs/main.c           | 4 ----
 4 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index 782a1310816b..65c7c5b6fe8a 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -1171,7 +1171,6 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 	int ioprio_class = IOPRIO_CLASS_IDLE;
 	int ioprio_classdata = 0;
 	int n_start = 0;
-	int n_skip = 0;
 	int n_resume = 0;
 	struct btrfs_ioctl_fs_info_args fi_args;
 	struct btrfs_ioctl_dev_info_args *di_args = NULL;
@@ -1337,7 +1336,6 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 			sp[i].scrub_args.start = last_scrub->p.last_physical;
 			sp[i].resumed = last_scrub;
 		} else if (resume) {
-			++n_skip;
 			sp[i].skip = 1;
 			sp[i].resumed = last_scrub;
 			continue;
diff --git a/image/main.c b/image/main.c
index d4a1fe349d31..8aa4c1552807 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2243,7 +2243,6 @@ static int build_chunk_tree(struct mdrestore_struct *mdres,
 	struct meta_cluster_header *header;
 	struct meta_cluster_item *item = NULL;
 	u32 i, nritems;
-	u64 bytenr = 0;
 	u8 *buffer;
 	int ret;
 
@@ -2265,7 +2264,6 @@ static int build_chunk_tree(struct mdrestore_struct *mdres,
 		return -EIO;
 	}
 
-	bytenr += IMAGE_BLOCK_SIZE;
 	mdres->compress_method = header->compress;
 	nritems = le32_to_cpu(header->nritems);
 	for (i = 0; i < nritems; i++) {
@@ -2273,7 +2271,6 @@ static int build_chunk_tree(struct mdrestore_struct *mdres,
 
 		if (le64_to_cpu(item->bytenr) == BTRFS_SUPER_INFO_OFFSET)
 			break;
-		bytenr += le32_to_cpu(item->size);
 		if (fseek(mdres->in, le32_to_cpu(item->size), SEEK_CUR)) {
 			error("seek failed: %m");
 			return -EIO;
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index a79fc6a5dbc3..f06ee24322bf 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -826,7 +826,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 	int i;
 	u64 *alloc_offsets = NULL;
 	u64 last_alloc = 0;
-	u32 num_sequential = 0, num_conventional = 0;
+	u32 num_conventional = 0;
 
 	if (!btrfs_is_zoned(fs_info))
 		return 0;
@@ -870,9 +870,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 		}
 
 		is_sequential = btrfs_dev_is_sequential(device, physical);
-		if (is_sequential)
-			num_sequential++;
-		else
+		if (!is_sequential)
 			num_conventional++;
 
 		if (!is_sequential) {
diff --git a/mkfs/main.c b/mkfs/main.c
index 9f106e33f869..341ba4089484 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -490,7 +490,6 @@ static void list_all_devices(struct btrfs_root *root)
 	struct btrfs_fs_devices *fs_devices;
 	struct btrfs_device *device;
 	int number_of_devices = 0;
-	u64 total_block_count = 0;
 
 	fs_devices = root->fs_info->fs_devices;
 
@@ -500,8 +499,6 @@ static void list_all_devices(struct btrfs_root *root)
 	list_sort(NULL, &fs_devices->devices, _cmp_device_by_id);
 
 	printf("Number of devices:  %d\n", number_of_devices);
-	/* printf("Total devices size: %10s\n", */
-		/* pretty_size(total_block_count)); */
 	printf("Devices:\n");
 	printf("   ID        SIZE  PATH\n");
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
@@ -509,7 +506,6 @@ static void list_all_devices(struct btrfs_root *root)
 			device->devid,
 			pretty_size(device->total_bytes),
 			device->name);
-		total_block_count += device->total_bytes;
 	}
 
 	printf("\n");
-- 
2.39.1

