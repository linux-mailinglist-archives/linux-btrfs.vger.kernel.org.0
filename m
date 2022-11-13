Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B81C626DE3
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Nov 2022 07:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiKMGdC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Nov 2022 01:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiKMGdA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Nov 2022 01:33:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7791DCE1A
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Nov 2022 22:32:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2585521D9A
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 06:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668321178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ReO2ofDBw7IoyIFFOFbBxOzZVkfo9fEkvR3Edw6/0/U=;
        b=IT5ka0Yog0qlpD+TKcumKVTn8miYbZfN1YXcZ7GN4R4ougInsrd59qkxgWXCUK7udyNBVp
        hLTMmWupAWEC4nJxtAUtts2/K9uivamT/LYnYZ7a1h4qY9QGIjyVrDbjlqj0MxQ51H7csM
        A1Ml5t32A+fpOVlmzI+VCF2ovi/VOYE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7EC58133A4
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 06:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iLHHEpmPcGNRUQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 06:32:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: properly handle degraded raid56 reads
Date:   Sun, 13 Nov 2022 14:32:38 +0800
Message-Id: <84e24680cebf0f9094abfc9f6e7aac4b65d61a1a.1668320935.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1668320935.git.wqu@suse.com>
References: <cover.1668320935.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
For a degraded RAID5, btrfs check will fail to even read the chunk root:

  # mkfs.btrfs -f -m raid5 -d raid5 $dev1 $dev2 $dev3
  # wipefs -fa $dev1
  # btrfs check $dev2
  Opening filesystem to check...
  warning, device 1 is missing
  bad tree block 22036480, bytenr mismatch, want=22036480, have=0
  ERROR: cannot read chunk root
  ERROR: cannot open file system

[CAUSE]
Although read_tree_block() function from btrfs-progs is properly
iterating the mirrors (mirror 1 is reading from the disk directly,
mirror 2 will be rebuild from parity), the raid56 recovery path is not
handling the read error correctly.

The existing code will try to read the full stripe, but any read failure
(including missing device) will immedately cause an error:

	for (i = 0; i < num_stripes; i++) {
		ret = btrfs_pread(multi->stripes[i].dev->fd, pointers[i],
				  BTRFS_STRIPE_LEN, multi->stripes[i].physical,
				  fs_info->zoned);
		if (ret < BTRFS_STRIPE_LEN) {
			ret = -EIO;
			goto out;
		}
	}

[FIX]
To make failed_a/failed_b calculation much easier, and properly handle
too many missing devices, here this patch will introduce a new bitmap
based solution.

The new @failed_stripe_bitmap will represent all the failed stripes.

So the initial read will mark all the missing devices in the
@failed_stripe_bitmap, and later operations will all operate on that
bitmap.

Only before we call raid56_recov(), we convert the bitmap to the old
failed_a/failed_b interface and continue.

Now btrfs check can handle above case properly:

  # btrfs check $dev2
  Opening filesystem to check...
  warning, device 1 is missing
  Checking filesystem on /dev/test/scratch2
  UUID: 8b2e1cb4-f35b-4856-9b11-262d39d8458b
  [1/7] checking root items
  [2/7] checking extents
  [3/7] checking free space tree
  [4/7] checking fs roots
  [5/7] checking only csums items (without verifying data)
  [6/7] checking root refs
  [7/7] checking quota groups skipped (not enabled on this FS)
  found 147456 bytes used, no error found
  total csum bytes: 0
  total tree bytes: 147456
  total fs tree bytes: 32768
  total extent tree bytes: 16384
  btree space waste bytes: 139871
  file data blocks allocated: 0
   referenced 0

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-lib/bitmap.h       | 45 ++++++++++++++++++++++++++++++++
 kernel-shared/extent_io.c | 54 +++++++++++++++++++++++----------------
 2 files changed, 77 insertions(+), 22 deletions(-)
 create mode 100644 kernel-lib/bitmap.h

diff --git a/kernel-lib/bitmap.h b/kernel-lib/bitmap.h
new file mode 100644
index 000000000000..dbd046db9d94
--- /dev/null
+++ b/kernel-lib/bitmap.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * A user-space bitmap wrapper to provide a subset of kernel bitmap operations.
+ *
+ * Most functions are not a direct copy of the kernel version, but should be
+ * good enough for single thread usage.
+ */
+
+#ifndef _BTRFS_PROGS_LINUX_BITMAP_H_
+#define _BTRFS_PROGS_LINUX_BITMAP_H_
+
+#include <stdlib.h>
+#include "kerncompat.h"
+#include "kernel-lib/bitops.h"
+
+static inline unsigned long *bitmap_zalloc(unsigned int nbits)
+{
+	return calloc(BITS_TO_LONGS(nbits), BITS_PER_LONG);
+}
+
+static inline void bitmap_free(unsigned long *bitmap)
+{
+	free(bitmap);
+}
+
+#define BITMAP_LAST_WORK_MASK(nbits) (~0ULL >> (-(nbits) & (BITS_PER_LONG - 1)))
+static inline unsigned int bitmap_weight(const unsigned long *bitmap,
+					 unsigned int nbits)
+{
+	int ret = 0;
+	int i;
+
+	/* Handle the aligned part first.*/
+	for (i = 0; i < nbits / BITS_PER_LONG; i++)
+		ret += hweight_long(bitmap[i]);
+
+	/* The remaining unaligned part. */
+	if (nbits % BITS_PER_LONG)
+		ret += bitmap[i] & BITMAP_LAST_WORD_MASK(nbits);
+
+	return ret;
+}
+
+#endif
diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index f112983ae883..cf34794655da 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -27,6 +27,7 @@
 #include "kernel-shared/extent_io.h"
 #include "kernel-lib/list.h"
 #include "kernel-lib/raid56.h"
+#include "kernel-lib/bitmap.h"
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/disk-io.h"
@@ -791,9 +792,11 @@ static int read_raid56(struct btrfs_fs_info *fs_info, void *buf, u64 logical,
 		       u64 len, int mirror, struct btrfs_multi_bio *multi,
 		       u64 *raid_map)
 {
+	const int tolerance = (multi->type & BTRFS_RAID_RAID6 ? 2 : 1);
 	const int num_stripes = multi->num_stripes;
 	const u64 full_stripe_start = raid_map[0];
 	void **pointers = NULL;
+	unsigned long *failed_stripe_bitmap = NULL;
 	int failed_a = -1;
 	int failed_b = -1;
 	int i;
@@ -820,6 +823,12 @@ static int read_raid56(struct btrfs_fs_info *fs_info, void *buf, u64 logical,
 		}
 	}
 
+	failed_stripe_bitmap = bitmap_zalloc(num_stripes);
+	if (!failed_stripe_bitmap) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	/*
 	 * Read the full stripe.
 	 *
@@ -830,10 +839,8 @@ static int read_raid56(struct btrfs_fs_info *fs_info, void *buf, u64 logical,
 		ret = btrfs_pread(multi->stripes[i].dev->fd, pointers[i],
 				  BTRFS_STRIPE_LEN, multi->stripes[i].physical,
 				  fs_info->zoned);
-		if (ret < BTRFS_STRIPE_LEN) {
-			ret = -EIO;
-			goto out;
-		}
+		if (ret < BTRFS_STRIPE_LEN)
+			set_bit(i, failed_stripe_bitmap);
 	}
 
 	/*
@@ -842,29 +849,31 @@ static int read_raid56(struct btrfs_fs_info *fs_info, void *buf, u64 logical,
 	 * Since we're reading using mirror_num > 1 already, it means the data
 	 * stripe where @logical lies in is definitely corrupted.
 	 */
-	failed_a = (logical - full_stripe_start) / BTRFS_STRIPE_LEN;
+	set_bit((logical - full_stripe_start) / BTRFS_STRIPE_LEN,
+		 failed_stripe_bitmap);
 
 	/*
 	 * For RAID6, we don't have good way to exhaust all the combinations,
 	 * so here we can only go through the map to see if we have missing devices.
+	 *
+	 * If we only have one failed stripe (marked by above set_bit()), then
+	 * we have no better idea, fallback to use P corruption.
 	 */
-	if (multi->type & BTRFS_BLOCK_GROUP_RAID6) {
-		for (i = 0; i < num_stripes; i++) {
-			/* Skip failed_a, as it's already marked failed */
-			if (i == failed_a)
-				continue;
-			/* Missing dev */
-			if (multi->stripes[i].dev->fd == -1) {
-				failed_b = i;
-				break;
-			}
-		}
-		/*
-		 * No missing device, we have no better idea, default to P
-		 * corruption
-		 */
-		if (failed_b < 0)
-			failed_b = num_stripes - 2;
+	if (multi->type & BTRFS_BLOCK_GROUP_RAID6 &&
+	    bitmap_weight(failed_stripe_bitmap, num_stripes) < 2)
+		set_bit(num_stripes - 2, failed_stripe_bitmap);
+
+	/* Damaged beyond repair already. */
+	if (bitmap_weight(failed_stripe_bitmap, num_stripes) > tolerance) {
+		ret = -EIO;
+		goto out;
+	}
+
+	for_each_set_bit(i, failed_stripe_bitmap, num_stripes) {
+		if (failed_a < 0)
+			failed_a = i;
+		else if (failed_b < 0)
+			failed_b = i;
 	}
 
 	/* Rebuild the full stripe */
@@ -877,6 +886,7 @@ static int read_raid56(struct btrfs_fs_info *fs_info, void *buf, u64 logical,
 			BTRFS_STRIPE_LEN, len);
 	ret = 0;
 out:
+	free(failed_stripe_bitmap);
 	for (i = 0; i < num_stripes; i++)
 		free(pointers[i]);
 	free(pointers);
-- 
2.38.1

