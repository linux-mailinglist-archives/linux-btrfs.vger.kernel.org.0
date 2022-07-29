Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F2F58520B
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jul 2022 17:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbiG2PEM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jul 2022 11:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbiG2PEL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jul 2022 11:04:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5622617594
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jul 2022 08:04:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 072B7344AE;
        Fri, 29 Jul 2022 15:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659107049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qwH5ZUluiwR7VvjqTY2FaxqNo9W0hVOgbNjKSSZtLN8=;
        b=mY6q/x95ACKTP7IlefMXt4c+vEzBvR6GTZlYn3we3XPyNsdYXjT+skDXsWqWr8CEy7HdyP
        nFEw7TwvLvaRQtZQ0q2CeY1r8mEP7xigQLnUvtwyzGf2PqFu2E6GsQU/o2JjWnj53HA/V6
        mI/RoHlSzhmJo1eI1ayaeGTIX/ofPlw=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F29CF2C141;
        Fri, 29 Jul 2022 15:04:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 02489DA85A; Fri, 29 Jul 2022 16:59:10 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/4] btrfs: assign checksum shash slots on init
Date:   Fri, 29 Jul 2022 16:59:10 +0200
Message-Id: <32716bb3c21666ba4019bca40675cc46130af149.1659106597.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1659106597.git.dsterba@suse.com>
References: <cover.1659106597.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When initializing checksum implementation on first mount, assign it to
the proper slot based on the driver name. If it contains "generic" it's
considered the non-accelerated one. Based on that properly set the
BTRFS_FS_CSUM_IMPL_FAST bit, previously it could be mistakenly set as
fast despite a different checksum (eg. sha256) with generic
implementation.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 13 ++++++++++++-
 fs/btrfs/super.c   |  2 --
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index dc41db822322..2f5d8d2e2c48 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2536,7 +2536,18 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
 		return PTR_ERR(csum_shash);
 	}
 
-	fs_info->csum_shash[CSUM_DEFAULT] = csum_shash;
+	/*
+	 * Find the fastest implementation available, but keep the slots
+	 * matching the type.
+	 */
+	if (strstr(crypto_shash_driver_name(fs_info->csum_shash[CSUM_DEFAULT]),
+		   "generic") != NULL) {
+		fs_info->csum_shash[CSUM_GENERIC] = csum_shash;
+		clear_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
+	} else {
+		fs_info->csum_shash[CSUM_ACCEL] = csum_shash;
+		set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
+	}
 
 	return 0;
 }
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6627dd7875ee..0d306f555e09 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1816,8 +1816,6 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	} else {
 		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
 		btrfs_sb(s)->bdev_holder = fs_type;
-		if (!strstr(crc32c_impl(), "generic"))
-			set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
 		error = btrfs_fill_super(s, fs_devices, data);
 	}
 	if (!error)
-- 
2.36.1

