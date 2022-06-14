Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D988654BDE7
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 00:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354762AbiFNWuk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 18:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355150AbiFNWui (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 18:50:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C00E52B0B
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 15:50:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1D14421BF0
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 22:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655247036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OcAAZII09+5uxe3qWdf+P4GiRmJ6VneJCJ+DzE/ju0E=;
        b=mS9GvyQjSskrr2HrXYgtC2OQiTCPSIyYewtwgM0dFR6+pfthSwtzYVx38Zily+QCIMbtc9
        wkm0C/tbGYcDUBMuvSjFdxHvbM4sx3595VK1n7+j6BTx1YBYSi+WSpA1o5RVZVDgLbtBUm
        8Ylp5wCNyek9C4wFL3EctotgIZ72xsg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7969A139EC
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 22:50:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wD+ZEbsQqWKVbgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 22:50:35 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH DRAFT 4/4] btrfs: introduce a new experimental compat RO flag, WRITE_INTENT_BITMAP
Date:   Wed, 15 Jun 2022 06:50:14 +0800
Message-Id: <6f44e3981cc78835771b8641e0981b71d467813f.1655246405.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655246405.git.wqu@suse.com>
References: <cover.1655246405.git.wqu@suse.com>
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

The new flag is for the incoming write intent bitmap, mostly to address
the RAID56 write-hole, by doing a mandatory scrub for partial written
stripes at mount time.

Currently the feature is still under development, this patch is mostly
a placeholder for the extra reserved bytes for write intent bitmap.

We will utilize the newly introduce EXTRA_SUPER_RESERVED compat RO flags
to enlarge the reserved bytes to at least (1MiB + 64KiB), and use that
64KiB (exact value is not yet fully determined) for write-intent bitmap.

Only one extra check is introduced, to ensure we have enough space to
place the write-intent bitmap at 1MiB physical offset.

This patch is only a place holder for the incoming on-disk format
change, no real write-intent functionality is implemented yet.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h           |  9 +++++++++
 fs/btrfs/disk-io.c         | 20 ++++++++++++++++++++
 fs/btrfs/volumes.c         | 14 +++++++++++++-
 include/uapi/linux/btrfs.h |  7 +++++++
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d29d25339c3e..1fb109f9f6b6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -317,11 +317,20 @@ static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 #define BTRFS_FEATURE_COMPAT_SAFE_SET		0ULL
 #define BTRFS_FEATURE_COMPAT_SAFE_CLEAR		0ULL
 
+#ifdef CONFIG_BTRFS_DEBUG
+#define BTRFS_FEATURE_COMPAT_RO_SUPP			\
+	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
+	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID | \
+	 BTRFS_FEATURE_COMPAT_RO_VERITY |		\
+	 BTRFS_FEATURE_COMPAT_RO_EXTRA_SUPER_RESERVED |	\
+	 BTRFS_FEATURE_COMPAT_RO_WRITE_INTENT_BITMAP)
+#else
 #define BTRFS_FEATURE_COMPAT_RO_SUPP			\
 	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
 	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID | \
 	 BTRFS_FEATURE_COMPAT_RO_VERITY |		\
 	 BTRFS_FEATURE_COMPAT_RO_EXTRA_SUPER_RESERVED)
+#endif
 
 #define BTRFS_FEATURE_COMPAT_RO_SAFE_SET	0ULL
 #define BTRFS_FEATURE_COMPAT_RO_SAFE_CLEAR	0ULL
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b2184fcdfde9..7c9d193a8d02 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2825,6 +2825,26 @@ static int validate_super(struct btrfs_fs_info *fs_info,
 			    BTRFS_DEFAULT_RESERVED);
 		ret = -EINVAL;
 	}
+	if (btrfs_super_compat_ro_flags(sb) &
+	    BTRFS_FEATURE_COMPAT_RO_WRITE_INTENT_BITMAP) {
+		/* Write intent bitmap requires extra reserve. */
+		if (!(btrfs_super_compat_ro_flags(sb) &
+		      BTRFS_FEATURE_COMPAT_RO_EXTRA_SUPER_RESERVED)) {
+			btrfs_err(fs_info,
+"WRITE_INTENT_BITMAP feature enabled, but missing EXTRA_SUPER_RESERVED feature");
+			ret = -EINVAL;
+		}
+		/*
+		 * Write intent bitmap is always located at 1MiB.
+		 * Extra check like the length check against the reserved space
+		 * will happen at bitmap load time.
+		 */
+		if (btrfs_super_reserved_bytes(sb) < BTRFS_DEFAULT_RESERVED) {
+			btrfs_err(fs_info,
+			"not enough reserved space for write intent bitmap");
+			ret = -EINVAL;
+		}
+	}
 
 	/*
 	 * The generation is a global counter, we'll trust it more than the others
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5c337d7ef3c1..dd523d59fe22 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -8008,11 +8008,23 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 	 *
 	 * So here, we just give a warning and continue the mount.
 	 */
-	if (physical_offset < super_reserved)
+	if (physical_offset < super_reserved) {
 		btrfs_warn(fs_info,
 "devid %llu physical %llu len %llu is inside the reserved space, balance is needed to solve this problem.",
 			   devid, physical_offset, physical_len);
 
+		/* Disable any feature relying on the new reserved_bytes. */
+		if (btrfs_fs_compat_ro(fs_info, WRITE_INTENT_BITMAP)) {
+			struct btrfs_super_block *sb = fs_info->super_copy;
+
+			btrfs_warn(fs_info,
+	"disabling write intent bitmap due to the lack of reserved space.");
+			btrfs_set_super_compat_ro_flags(sb,
+				btrfs_super_compat_ro_flags(sb) |
+				~BTRFS_FEATURE_COMPAT_RO_WRITE_INTENT_BITMAP);
+		}
+	}
+
 	for (i = 0; i < map->num_stripes; i++) {
 		if (map->stripes[i].dev->devid == devid &&
 		    map->stripes[i].physical == physical_offset) {
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 4a0c9f4f55d1..38c74a50323e 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -300,6 +300,13 @@ struct btrfs_ioctl_fs_info_args {
  */
 #define BTRFS_FEATURE_COMPAT_RO_EXTRA_SUPER_RESERVED	(1ULL << 3)
 
+/*
+ * Allow btrfs to have per-device write-intent bitmap.
+ * Will be utilized to close the RAID56 write-hole (by forced scrub for dirty
+ * partial written stripes at mount time).
+ */
+#define BTRFS_FEATURE_COMPAT_RO_WRITE_INTENT_BITMAP	(1ULL << 4)
+
 #define BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF	(1ULL << 0)
 #define BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL	(1ULL << 1)
 #define BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS	(1ULL << 2)
-- 
2.36.1

