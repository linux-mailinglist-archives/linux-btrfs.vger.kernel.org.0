Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3604F4570
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 00:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbiDEPEJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 11:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392004AbiDENt3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 09:49:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CA79FF7
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 05:48:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 750D221112
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 12:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649162933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ix7euoUo0h+Bf2oRoT+9cHAlJHgXgxJ82HTxc0HzwHU=;
        b=iixOZ86ryyekGw9NBvDxrnlEmhf2eucWQF19S0scNwnEsnSTZO9EMbtES1P3zTjTg5x6+k
        pGO1glKfg/zpcXaKOT/GnUmuSfsEL5pRP2MbK0hPxzA3jdSEugAeO0nGKUKniOhK4buenw
        pHeQEpXYIdbVgfEtas+VGhXQdsDtKy8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5FEC13A04
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 12:48:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QOqYI7Q6TGJLGgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 12:48:52 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/8] btrfs-progs: use write_data_to_disk() to replace write_extent_to_disk()
Date:   Tue,  5 Apr 2022 20:48:26 +0800
Message-Id: <30deeb01dd14e9c0d47e865362a107b1385862fb.1649162174.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649162174.git.wqu@suse.com>
References: <cover.1649162174.git.wqu@suse.com>
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

Function write_extent_to_disk() is just writing the content of a tree
block to disk.

It can not handle RAID56, and its work is the same as
write_data_to_disk().

Thus we can replace write_extent_to_disk() with write_data_to_disk()
easily.

There is only one special call site in write_raid56_with_parity(), which
can easily be replace with btrfs_pwrite() directly.

This reduce the write entrance, and make later eb::fd removal easier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/disk-io.c   | 29 +++++++++++++++--------------
 kernel-shared/extent_io.c | 17 +----------------
 kernel-shared/extent_io.h |  1 -
 kernel-shared/volumes.c   |  4 +++-
 4 files changed, 19 insertions(+), 32 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index e6f5d554f13a..f68284264319 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -510,12 +510,12 @@ err:
 int write_and_map_eb(struct btrfs_fs_info *fs_info, struct extent_buffer *eb)
 {
 	int ret;
-	int dev_nr;
+	int mirror_num;
+	int max_mirror;
 	u64 length;
 	u64 *raid_map = NULL;
 	struct btrfs_multi_bio *multi = NULL;
 
-	dev_nr = 0;
 	length = eb->len;
 	ret = btrfs_map_block(fs_info, WRITE, eb->start, &length,
 			      &multi, 0, &raid_map);
@@ -526,6 +526,7 @@ int write_and_map_eb(struct btrfs_fs_info *fs_info, struct extent_buffer *eb)
 		goto out;
 	}
 
+	/* RAID56 write back need RMW */
 	if (raid_map) {
 		ret = write_raid56_with_parity(fs_info, eb, multi,
 					       length, raid_map);
@@ -534,28 +535,28 @@ int write_and_map_eb(struct btrfs_fs_info *fs_info, struct extent_buffer *eb)
 			error(
 		"failed to write raid56 stripe for bytenr %llu length %llu: %m",
 				eb->start, length);
-			goto out;
 		}
-	} else while (dev_nr < multi->num_stripes) {
-		eb->fd = multi->stripes[dev_nr].dev->fd;
-		eb->dev_bytenr = multi->stripes[dev_nr].physical;
-		multi->stripes[dev_nr].dev->total_ios++;
-		dev_nr++;
-		ret = write_extent_to_disk(eb);
+		goto out;
+	}
+
+	/* For non-RAID56, we just writeback data to each mirror */
+	max_mirror = btrfs_num_copies(fs_info, eb->start, eb->len);
+	for (mirror_num = 1; mirror_num <= max_mirror; mirror_num++) {
+		ret = write_data_to_disk(fs_info, eb->data, eb->start, eb->len,
+				         mirror_num);
 		if (ret < 0) {
 			errno = -ret;
 			error(
-"failed to write bytenr %llu length %u devid %llu dev_bytenr %llu: %m",
-				eb->start, eb->len,
-				multi->stripes[dev_nr].dev->devid,
-				eb->dev_bytenr);
+		"failed to write bytenr %llu length %u to mirror %d: %m",
+				eb->start, eb->len, mirror_num);
 			goto out;
 		}
 	}
+
 out:
 	kfree(raid_map);
 	kfree(multi);
-	return 0;
+	return ret;
 }
 
 int write_tree_block(struct btrfs_trans_handle *trans,
diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index fba0b050a7e1..ccc8b98107b4 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -808,22 +808,6 @@ out:
 	return ret;
 }
 
-int write_extent_to_disk(struct extent_buffer *eb)
-{
-	int ret;
-	ret = btrfs_pwrite(eb->fd, eb->data, eb->len, eb->dev_bytenr,
-			   eb->fs_info->zoned);
-	if (ret < 0)
-		goto out;
-	if (ret != eb->len) {
-		ret = -EIO;
-		goto out;
-	}
-	ret = 0;
-out:
-	return ret;
-}
-
 int read_data_from_disk(struct btrfs_fs_info *info, void *buf, u64 offset,
 			u64 bytes, int mirror)
 {
@@ -934,6 +918,7 @@ int write_data_to_disk(struct btrfs_fs_info *info, void *buf, u64 offset,
 			dev_bytenr = multi->stripes[dev_nr].physical;
 			this_len = min(this_len, bytes_left);
 			dev_nr++;
+			device->total_ios++;
 
 			ret = btrfs_pwrite(device->fd, buf + total_write,
 					   this_len, dev_bytenr, info->zoned);
diff --git a/kernel-shared/extent_io.h b/kernel-shared/extent_io.h
index a4c21360a9e8..b787c19ef049 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -152,7 +152,6 @@ void free_extent_buffer(struct extent_buffer *eb);
 void free_extent_buffer_nocache(struct extent_buffer *eb);
 int read_extent_from_disk(struct extent_buffer *eb,
 			  unsigned long offset, unsigned long len);
-int write_extent_to_disk(struct extent_buffer *eb);
 int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 			 unsigned long start, unsigned long len);
 void read_extent_buffer(const struct extent_buffer *eb, void *dst,
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 4bf63266879b..7d1e7ea00903 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -30,6 +30,7 @@
 #include "kernel-shared/volumes.h"
 #include "zoned.h"
 #include "common/utils.h"
+#include "common/device-utils.h"
 #include "kernel-lib/raid56.h"
 
 const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
@@ -2719,7 +2720,8 @@ int write_raid56_with_parity(struct btrfs_fs_info *info,
 	}
 
 	for (i = 0; i < multi->num_stripes; i++) {
-		ret = write_extent_to_disk(ebs[i]);
+		ret = btrfs_pwrite(ebs[i]->fd, ebs[i]->data, ebs[i]->len,
+				   ebs[i]->dev_bytenr, info->zoned);
 		if (ret < 0)
 			goto out_free_split;
 	}
-- 
2.35.1

