Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D528943C239
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 07:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239551AbhJ0Fbs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 01:31:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58660 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239547AbhJ0Fbp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 01:31:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 97C2321963
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 05:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635312559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QOWk0EX5ItbagtlFQJhI09mCtLf9Qjuvl0mRGNaNZVA=;
        b=EVfMX6+2NShI+2CLllnVUaDKhRBvkUUGyaU2VAi5UY28KN6Kk2mQfWVLuCNQ96yfEDdf4K
        qvwqgcCdx+PTWRV4/iTBHKgYKaGOHDp9Tg6JiG2/gMPkMzCnUNOn3PjVi9Q9oOyU1xSChI
        0W4aihLknIoyJwbSwrHKZBXACjKbO0U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E263713D13
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 05:29:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8LoCKq7jeGH3RgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 05:29:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: use ilog2() to replace if () branches for btrfs_bg_flags_to_raid_index()
Date:   Wed, 27 Oct 2021 13:28:59 +0800
Message-Id: <20211027052859.44507-3-wqu@suse.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211027052859.44507-1-wqu@suse.com>
References: <20211027052859.44507-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In function btrfs_bg_flags_to_raid_index(), we use quite some if () to
convert the BTRFS_BLOCK_GROUP_* bits to a index number.

But the truth is, there is really no such need for so many branches at
all.
Since all BTRFS_BLOCK_GROUP_* flags are just one single bit set inside
BTRFS_BLOCK_GROUP_PROFILES_MASK, we can easily use ilog2() to calculate
their values.

Only one fixed offset is needed to make the index sequential (the
lowest profile bit starts at ilog2(1 << 3) while we have 0 reserved for
SINGLE).

Even with that calculation involved (one if(), one ilog2(), one minus),
it should still be way faster than the if () branches, and now it is
definitely small enough to be inlined.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/space-info.h |  2 ++
 fs/btrfs/volumes.c    | 26 --------------------------
 fs/btrfs/volumes.h    | 42 ++++++++++++++++++++++++++++++++----------
 3 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index cb5056472e79..5a0686ab9679 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -3,6 +3,8 @@
 #ifndef BTRFS_SPACE_INFO_H
 #define BTRFS_SPACE_INFO_H
 
+#include "volumes.h"
+
 struct btrfs_space_info {
 	spinlock_t lock;
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a8ea3f88c4db..94a3dfe709e8 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -154,32 +154,6 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	},
 };
 
-/*
- * Convert block group flags (BTRFS_BLOCK_GROUP_*) to btrfs_raid_types, which
- * can be used as index to access btrfs_raid_array[].
- */
-enum btrfs_raid_types __attribute_const__ btrfs_bg_flags_to_raid_index(u64 flags)
-{
-	if (flags & BTRFS_BLOCK_GROUP_RAID10)
-		return BTRFS_RAID_RAID10;
-	else if (flags & BTRFS_BLOCK_GROUP_RAID1)
-		return BTRFS_RAID_RAID1;
-	else if (flags & BTRFS_BLOCK_GROUP_RAID1C3)
-		return BTRFS_RAID_RAID1C3;
-	else if (flags & BTRFS_BLOCK_GROUP_RAID1C4)
-		return BTRFS_RAID_RAID1C4;
-	else if (flags & BTRFS_BLOCK_GROUP_DUP)
-		return BTRFS_RAID_DUP;
-	else if (flags & BTRFS_BLOCK_GROUP_RAID0)
-		return BTRFS_RAID_RAID0;
-	else if (flags & BTRFS_BLOCK_GROUP_RAID5)
-		return BTRFS_RAID_RAID5;
-	else if (flags & BTRFS_BLOCK_GROUP_RAID6)
-		return BTRFS_RAID_RAID6;
-
-	return BTRFS_RAID_SINGLE; /* BTRFS_BLOCK_GROUP_SINGLE */
-}
-
 const char *btrfs_bg_type_to_raid_name(u64 flags)
 {
 	const int index = btrfs_bg_flags_to_raid_index(flags);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index e0c374a7c30b..7038c6cee39a 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -17,19 +17,42 @@ extern struct mutex uuid_mutex;
 
 #define BTRFS_STRIPE_LEN	SZ_64K
 
+/*
+ * Here we use ilog2(BTRFS_BLOCK_GROUP_*) to convert the profile bits to
+ * an index.
+ * We reserve 0 for BTRFS_RAID_SINGLE, while the lowest profile, ilog2(RAID0),
+ * is 3, thus we need this shift to make all index numbers sequential.
+ */
+#define BTRFS_RAID_SHIFT	(ilog2(BTRFS_BLOCK_GROUP_RAID0) - 1)
+
 enum btrfs_raid_types {
-	BTRFS_RAID_RAID10,
-	BTRFS_RAID_RAID1,
-	BTRFS_RAID_DUP,
-	BTRFS_RAID_RAID0,
-	BTRFS_RAID_SINGLE,
-	BTRFS_RAID_RAID5,
-	BTRFS_RAID_RAID6,
-	BTRFS_RAID_RAID1C3,
-	BTRFS_RAID_RAID1C4,
+	BTRFS_RAID_SINGLE  = 0,
+	BTRFS_RAID_RAID0   = ilog2(BTRFS_BLOCK_GROUP_RAID0 >> BTRFS_RAID_SHIFT),
+	BTRFS_RAID_RAID1   = ilog2(BTRFS_BLOCK_GROUP_RAID1 >> BTRFS_RAID_SHIFT),
+	BTRFS_RAID_DUP     = ilog2(BTRFS_BLOCK_GROUP_DUP >> BTRFS_RAID_SHIFT),
+	BTRFS_RAID_RAID10  = ilog2(BTRFS_BLOCK_GROUP_RAID10 >> BTRFS_RAID_SHIFT),
+	BTRFS_RAID_RAID5   = ilog2(BTRFS_BLOCK_GROUP_RAID5 >> BTRFS_RAID_SHIFT),
+	BTRFS_RAID_RAID6   = ilog2(BTRFS_BLOCK_GROUP_RAID6 >> BTRFS_RAID_SHIFT),
+	BTRFS_RAID_RAID1C3 = ilog2(BTRFS_BLOCK_GROUP_RAID1C3 >> BTRFS_RAID_SHIFT),
+	BTRFS_RAID_RAID1C4 = ilog2(BTRFS_BLOCK_GROUP_RAID1C4 >> BTRFS_RAID_SHIFT),
 	BTRFS_NR_RAID_TYPES
 };
 
+/*
+ * Convert block group flags (BTRFS_BLOCK_GROUP_*) to btrfs_raid_types, which
+ * can be used as index to access btrfs_raid_array[].
+ */
+static inline enum btrfs_raid_types __attribute_const__
+btrfs_bg_flags_to_raid_index(u64 flags)
+{
+	u64 profile = flags & BTRFS_BLOCK_GROUP_PROFILE_MASK;
+
+	if (!profile)
+		return BTRFS_RAID_SINGLE;
+
+	return ilog2(profile >> BTRFS_RAID_SHIFT);
+}
+
 struct btrfs_io_geometry {
 	/* remaining bytes before crossing a stripe */
 	u64 len;
@@ -646,7 +669,6 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 			       struct block_device *bdev,
 			       const char *device_path);
 
-enum btrfs_raid_types __attribute_const__ btrfs_bg_flags_to_raid_index(u64 flags);
 int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
-- 
2.33.1

