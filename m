Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509434F3E27
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 22:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237782AbiDEPEa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 11:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392013AbiDENt3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 09:49:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70891B87A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 05:48:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 223BF1F745
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 12:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649162937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jNPudszLz7sv6P0JnHRf0ouTSa3trwHWMLtSfvDFjNc=;
        b=slbMQnJxWnzz67Z13qLhfAR/ZU8oCV16r4ZxOod8ROTmp9YiypId/uNYpynOKCQEcey98g
        +YyKrC254PKIz8ZcVQzbYeTO5Mmp8BgMfCzOA/Z6p1ACc2/RTijNro0lLDZuFyC2yVuuRa
        Cejxe2b8AK4+LAg35XZMbo0ME9525yU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7318C13A04
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 12:48:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wJSCD7g6TGJLGgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 12:48:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs-progs: allow read_data_from_disk() to rebuild RAID56 using P/Q
Date:   Tue,  5 Apr 2022 20:48:29 +0800
Message-Id: <f8fda291f6104ecddf3eb36e263a82b506508112.1649162174.git.wqu@suse.com>
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

This new ability is added by:

- Allow btrfs_map_block() to return the chunk type
  This makes later work much easier

- Only reset stripe offset inside btrfs_map_block() when needed
  Currently if @raid_map is not NULL, btrfs_map_block() will consider
  this call is for WRITE and will reset stripe offset.

  This is no longer the case, as for RAID56 read with mirror_num 1/0,
  we will still call btrfs_map_block() with non-NULL raid_map.

  Add a small check to make sure we won't reset stripe offset for
  mirror 1/0 read.

- Add new helper read_raid56() to handle rebuild
  We will read the full stripe (including all data and P/Q stripes)
  do the rebuild, then only copy the refered part to the caller.

  There is a catch for RAID6, we have no way to exhaust all combination,
  so the current repair will assume the mirror = 0 data is corrupted,
  then try to find a missing device.

  But if no missing device can be found, it will assume P is corrupted.
  This is just a guess, and can to totally wrong, but we have no better
  idea.

Now btrfs-progs have full read ability for RAID56.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/extent_io.c | 114 +++++++++++++++++++++++++++++++++++++-
 kernel-shared/volumes.c   |  27 +++++----
 kernel-shared/volumes.h   |   1 +
 3 files changed, 128 insertions(+), 14 deletions(-)

diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index b8ded5cf7373..ee92e0f847d6 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -26,6 +26,7 @@
 #include "kerncompat.h"
 #include "kernel-shared/extent_io.h"
 #include "kernel-lib/list.h"
+#include "kernel-lib/raid56.h"
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/disk-io.h"
@@ -788,23 +789,131 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+static int read_raid56(struct btrfs_fs_info *fs_info, void *buf, u64 logical,
+		       u64 len, int mirror, struct btrfs_multi_bio *multi,
+		       u64 *raid_map)
+{
+	const int num_stripes = multi->num_stripes;
+	const u64 full_stripe_start = raid_map[0];
+	void **pointers = NULL;
+	int failed_a = -1;
+	int failed_b = -1;
+	int i;
+	int ret;
+
+	/* Only read repair should go this path */
+	ASSERT(mirror > 1);
+	ASSERT(raid_map);
+
+	/* The read length should be inside one stripe */
+	ASSERT(len <= BTRFS_STRIPE_LEN);
+
+	pointers = calloc(num_stripes, sizeof(void *));
+	if (!pointers) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	/* Allocate memory for the full stripe */
+	for (i = 0; i < num_stripes; i++) {
+		pointers[i] = malloc(BTRFS_STRIPE_LEN);
+		if (!pointers[i]) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	/*
+	 * Read the full stripe.
+	 *
+	 * The stripes in @multi is not rotated, thus can be used to read from
+	 * disk directly.
+	 */
+	for (i = 0; i < num_stripes; i++) {
+		ret = btrfs_pread(multi->stripes[i].dev->fd, pointers[i],
+				  BTRFS_STRIPE_LEN, multi->stripes[i].physical,
+				  fs_info->zoned);
+		if (ret < BTRFS_STRIPE_LEN) {
+			ret = -EIO;
+			goto out;
+		}
+	}
+
+	/*
+	 * Get the failed index.
+	 *
+	 * Since we're reading using mirror_num > 1 already, it means the data
+	 * stripe where @logical lies in is definitely corrupted.
+	 */
+	failed_a = (logical - full_stripe_start) / BTRFS_STRIPE_LEN;
+
+	/*
+	 * For RAID6, we don't have good way to exhaust all the combinations,
+	 * so here we can only go through the map to see if we have missing devices.
+	 */
+	if (multi->type & BTRFS_BLOCK_GROUP_RAID6) {
+		for (i = 0; i < num_stripes; i++) {
+			/* Skip failed_a, as it's already marked failed */
+			if (i == failed_a)
+				continue;
+			/* Missing dev */
+			if (multi->stripes[i].dev->fd == -1) {
+				failed_b = i;
+				break;
+			}
+		}
+		/*
+		 * No missing device, we have no better idea, default to P
+		 * corruption
+		 */
+		if (failed_b < 0)
+			failed_b = num_stripes - 2;
+	}
+
+	/* Rebuild the full stripe */
+	ret = raid56_recov(num_stripes, BTRFS_STRIPE_LEN, multi->type,
+			   failed_a, failed_b, pointers);
+	ASSERT(ret == 0);
+
+	/* Now copy the data back to original buf */
+	memcpy(buf, pointers[failed_a] + (logical - full_stripe_start) %
+			BTRFS_STRIPE_LEN, len);
+	ret = 0;
+out:
+	for (i = 0; i < num_stripes; i++)
+		free(pointers[i]);
+	free(pointers);
+	return ret;
+}
+
 int read_data_from_disk(struct btrfs_fs_info *info, void *buf, u64 logical,
 			u64 *len, int mirror)
 {
 	struct btrfs_multi_bio *multi = NULL;
 	struct btrfs_device *device;
 	u64 read_len = *len;
+	u64 *raid_map = NULL;
 	int ret;
 
 	ret = btrfs_map_block(info, READ, logical, &read_len, &multi, mirror,
-			      NULL);
+			      &raid_map);
 	if (ret) {
 		fprintf(stderr, "Couldn't map the block %llu\n", logical);
 		return -EIO;
 	}
+	read_len = min(*len, read_len);
+
+	/* We need to rebuild from P/Q */
+	if (mirror > 1 && multi->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		ret = read_raid56(info, buf, logical, read_len, mirror, multi,
+				  raid_map);
+		free(multi);
+		free(raid_map);
+		*len = read_len;
+		return ret;
+	}
+	free(raid_map);
 	device = multi->stripes[0].dev;
 
-	read_len = min(*len, read_len);
 	if (device->fd <= 0) {
 		kfree(multi);
 		return -EIO;
@@ -824,6 +933,7 @@ int read_data_from_disk(struct btrfs_fs_info *info, void *buf, u64 logical,
 			logical, ret, read_len);
 		return -EIO;
 	}
+	*len = read_len;
 
 	return 0;
 }
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index cb49609cc60c..f082fa9f898e 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -1805,6 +1805,7 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, int rw,
 	int stripes_required = 1;
 	int stripe_index;
 	int i;
+	bool need_raid_map = false;
 	struct btrfs_multi_bio *multi = NULL;
 
 	if (multi_ret && rw == READ) {
@@ -1842,17 +1843,18 @@ again:
 	}
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK
 	    && multi_ret && ((rw & WRITE) || mirror_num > 1) && raid_map_ret) {
-		    /* RAID[56] write or recovery. Return all stripes */
-		    stripes_required = map->num_stripes;
-
-		    /* Only allocate the map if we've already got a large enough multi_ret */
-		    if (stripes_allocated >= stripes_required) {
-			    raid_map = kmalloc(sizeof(u64) * map->num_stripes, GFP_NOFS);
-			    if (!raid_map) {
-				    kfree(multi);
-				    return -ENOMEM;
-			    }
-		    }
+		need_raid_map = true;
+		/* RAID[56] write or recovery. Return all stripes */
+		stripes_required = map->num_stripes;
+
+		/* Only allocate the map if we've already got a large enough multi_ret */
+		if (stripes_allocated >= stripes_required) {
+			raid_map = kmalloc(sizeof(u64) * map->num_stripes, GFP_NOFS);
+			if (!raid_map) {
+				kfree(multi);
+				return -ENOMEM;
+			}
+		}
 	}
 
 	/* if our multi bio struct is too small, back off and try again */
@@ -1890,6 +1892,7 @@ again:
 		goto out;
 
 	multi->num_stripes = 1;
+	multi->type = map->type;
 	stripe_index = 0;
 	if (map->type & BTRFS_BLOCK_GROUP_RAID1_MASK) {
 		if (rw == WRITE)
@@ -1916,7 +1919,7 @@ again:
 		else if (mirror_num)
 			stripe_index = mirror_num - 1;
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		if (raid_map) {
+		if (need_raid_map && raid_map) {
 			int rot;
 			u64 tmp;
 			u64 raid56_full_stripe_start;
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index 5cfe7e39f6b8..d90065b98a3e 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -106,6 +106,7 @@ struct btrfs_bio_stripe {
 };
 
 struct btrfs_multi_bio {
+	u64 type;
 	int error;
 	int num_stripes;
 	struct btrfs_bio_stripe stripes[];
-- 
2.35.1

