Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389D748B178
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 17:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245427AbiAKQA3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 11:00:29 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56760 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243724AbiAKQA3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 11:00:29 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B8D01F3B1;
        Tue, 11 Jan 2022 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641916828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/BOa7X1buNW4GMzUcT9oEtkPN7Hf3XOwMjn1xZbpRgo=;
        b=em9SVo9vZyLAGi+hr2kKJucDWGsLLKdqPItdu7Fc3IMYZBQpYpXo1B0pxvvjXyYf5gngT4
        MEqvsHPipFrwa3vYbIgunY9+jRk3rAky2mxWgIRlj9B9S5Tv0bNo6dspGXdyI3fGApC05Z
        7n07Ki9XF3/EcZnJ4wtNrnQkWu5MntI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 013AB13AF0;
        Tue, 11 Jan 2022 16:00:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MPG7OJup3WF2IAAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 11 Jan 2022 16:00:27 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Move missing device handling in a dedicate function
Date:   Tue, 11 Jan 2022 18:00:26 +0200
Message-Id: <20220111160026.1900599-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This simplifies the code flow in read_one_chunk and makes error handling
when handling missing devices a bit simipler by reducing it to a single
check if something went wrong. No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b07d382d53a8..7518ac5c28dc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7060,6 +7060,27 @@ static void warn_32bit_meta_chunk(struct btrfs_fs_info *fs_info,
 }
 #endif
 
+static struct btrfs_device *handle_missing_device(struct btrfs_fs_info *fs_info,
+						  u64 devid, u8 *uuid)
+{
+	struct btrfs_device *dev;
+
+	if (!btrfs_test_opt(fs_info, DEGRADED)) {
+		btrfs_report_missing_device(fs_info, devid, uuid, true);
+		return ERR_PTR(-ENOENT);
+	}
+
+	dev = add_missing_dev(fs_info->fs_devices, devid, uuid);
+	if (IS_ERR(dev)) {
+		btrfs_err(fs_info, "failed to init missing dev %llu: %ld",
+			  devid, PTR_ERR(dev));
+		return dev;
+	}
+	btrfs_report_missing_device(fs_info, devid, uuid, false);
+
+	return dev;
+}
+
 static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 			  struct btrfs_chunk *chunk)
 {
@@ -7147,28 +7168,18 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 				   BTRFS_UUID_SIZE);
 		args.uuid = uuid;
 		map->stripes[i].dev = btrfs_find_device(fs_info->fs_devices, &args);
-		if (!map->stripes[i].dev &&
-		    !btrfs_test_opt(fs_info, DEGRADED)) {
-			free_extent_map(em);
-			btrfs_report_missing_device(fs_info, devid, uuid, true);
-			return -ENOENT;
-		}
 		if (!map->stripes[i].dev) {
-			map->stripes[i].dev =
-				add_missing_dev(fs_info->fs_devices, devid,
-						uuid);
+			map->stripes[i].dev = handle_missing_device(fs_info,
+								    devid, uuid);
 			if (IS_ERR(map->stripes[i].dev)) {
 				free_extent_map(em);
-				btrfs_err(fs_info,
-					"failed to init missing dev %llu: %ld",
-					devid, PTR_ERR(map->stripes[i].dev));
 				return PTR_ERR(map->stripes[i].dev);
+
 			}
-			btrfs_report_missing_device(fs_info, devid, uuid, false);
 		}
+
 		set_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
 				&(map->stripes[i].dev->dev_state));
-
 	}
 
 	write_lock(&map_tree->lock);
-- 
2.25.1

