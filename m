Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB9250832A
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 10:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376636AbiDTILi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 04:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376560AbiDTILf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 04:11:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD00C16
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 01:08:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5D7751F385
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 08:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650442129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vFlfb9VsDbk/wZFU9xeutkXCmD5+fyyS7SG7ed4Gyw8=;
        b=OGccdQOYAYO/CtKI2C8pEXVum2fkZz9C1KLOY0V0gJoLJLFZb5NsOQB1ufgvtXMAbS3SvR
        uq7uvF/WWlx7QCjLQCJmowMKADzqYjS102ARBsuvSr6m5wzrcM9ivGXhcZVYmay+FfVNIo
        rVwz159o9UrkiyIcigy3I9t6p01Ra7Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 977A113AD5
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 08:08:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AO0QFpC/X2JEbAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 08:08:48 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/2] btrfs: use ilog2() to replace if () branches for btrfs_bg_flags_to_raid_index()
Date:   Wed, 20 Apr 2022 16:08:28 +0800
Message-Id: <beb111504cb32088bcf4fc6bc1ef36004d0761cb.1650441750.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1650441750.git.wqu@suse.com>
References: <cover.1650441750.git.wqu@suse.com>
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

In function btrfs_bg_flags_to_raid_index(), we use quite some if () to
convert the BTRFS_BLOCK_GROUP_* bits to a index number.

But the truth is, there is really no such need for so many branches at
all.
Since all BTRFS_BLOCK_GROUP_* flags are just one single bit set inside
BTRFS_BLOCK_GROUP_PROFILES_MASK, we can easily use ilog2() to calculate
their values.

This calculation has an anchor point, the lowest PROFILE bit, which is
RAID0.

Even it's fixed on-disk format and should never change, here I added
extra compile time checks to make it super safe:

1. Make sure RAID0 is always the lowest bit in PROFILE_MASK
   This is done by finding the first (least significant) bit set of
   RAID0 and PROFILE_MASK & ~RAID0.

2. Make sure RAID0 bit set beyond the highest bit of TYPE_MASK

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 24 ++++++------------------
 fs/btrfs/volumes.h | 40 +++++++++++++++++++++++++++++++---------
 2 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2368a2ffbee7..4cfe6daa0fee 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -164,24 +164,12 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
  */
 enum btrfs_raid_types __attribute_const__ btrfs_bg_flags_to_raid_index(u64 flags)
 {
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
+	u64 profile = flags & BTRFS_BLOCK_GROUP_PROFILE_MASK;
+
+	if (!profile)
+		return BTRFS_RAID_SINGLE;
+
+	return BTRFS_BG_FLAG_TO_INDEX(profile);
 }
 
 const char *btrfs_bg_type_to_raid_name(u64 flags)
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index dbb15e4eaa50..627f1ae672c4 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -17,16 +17,38 @@ extern struct mutex uuid_mutex;
 
 #define BTRFS_STRIPE_LEN	SZ_64K
 
+/* Used by sanity check for btrfs_raid_types. */
+#define const_ffs(n) (__builtin_ctzll(n) + 1)
+
+/*
+ * The conversion from BTRFS_BLOCK_GROUP_* bits to btrfs_raid_type requires
+ * RAID0 always to be the lowest profile bit.
+ * Although it's part of on-disk format and should never change, just do extra
+ * compile time sanity check on it.
+ */
+static_assert(const_ffs(BTRFS_BLOCK_GROUP_RAID0) <
+	      const_ffs(BTRFS_BLOCK_GROUP_PROFILE_MASK &
+			~BTRFS_BLOCK_GROUP_RAID0));
+static_assert(const_ilog2(BTRFS_BLOCK_GROUP_RAID0) >
+	      ilog2(BTRFS_BLOCK_GROUP_TYPE_MASK));
+
+/* ilog2() can handle both constants and variables */
+#define BTRFS_BG_FLAG_TO_INDEX(profile)	\
+	ilog2((profile) >> (ilog2(BTRFS_BLOCK_GROUP_RAID0) - 1))
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
+	/* SINGLE is the special one as it doesn't have on-disk bit. */
+	BTRFS_RAID_SINGLE  = 0,
+
+	BTRFS_RAID_RAID0   = BTRFS_BG_FLAG_TO_INDEX(BTRFS_BLOCK_GROUP_RAID0),
+	BTRFS_RAID_RAID1   = BTRFS_BG_FLAG_TO_INDEX(BTRFS_BLOCK_GROUP_RAID1),
+	BTRFS_RAID_DUP	   = BTRFS_BG_FLAG_TO_INDEX(BTRFS_BLOCK_GROUP_DUP),
+	BTRFS_RAID_RAID10  = BTRFS_BG_FLAG_TO_INDEX(BTRFS_BLOCK_GROUP_RAID10),
+	BTRFS_RAID_RAID5   = BTRFS_BG_FLAG_TO_INDEX(BTRFS_BLOCK_GROUP_RAID5),
+	BTRFS_RAID_RAID6   = BTRFS_BG_FLAG_TO_INDEX(BTRFS_BLOCK_GROUP_RAID6),
+	BTRFS_RAID_RAID1C3 = BTRFS_BG_FLAG_TO_INDEX(BTRFS_BLOCK_GROUP_RAID1C3),
+	BTRFS_RAID_RAID1C4 = BTRFS_BG_FLAG_TO_INDEX(BTRFS_BLOCK_GROUP_RAID1C4),
+
 	BTRFS_NR_RAID_TYPES
 };
 
-- 
2.35.1

