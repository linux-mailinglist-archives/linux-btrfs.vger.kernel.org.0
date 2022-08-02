Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913DC587C79
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 14:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbiHBMd2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 08:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiHBMd0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 08:33:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C246133A32
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 05:33:25 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 795EE35194;
        Tue,  2 Aug 2022 12:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659443604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w7qMRTqhmtGgViGXoFDOE73QKzRmKB6F3dVT9qS9Sb0=;
        b=hWVQY3LPbyQAen4i69HGvaHVuZoEXyw82126E17t3VoV/flnteu6oZAdZi+XBFVAvrpP38
        5d7GPoZZnD6vb5yt2/MatrzMAJcyVXAYbhXRZQxr6PvNgPSapMyt+wXUPFbnb+ZuWhxRJU
        Ncxc4mSGzxbV9UpS58q1tzY8zCL44PM=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 717282C141;
        Tue,  2 Aug 2022 12:33:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 27B61DA85A; Tue,  2 Aug 2022 14:28:24 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 2/4] btrfs: assign checksum shash slots on init
Date:   Tue,  2 Aug 2022 14:28:24 +0200
Message-Id: <c637b01a1742d0841b71d67a91aab50ac22539f7.1659443199.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1659443199.git.dsterba@suse.com>
References: <cover.1659443199.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 fs/btrfs/disk-io.c | 11 +++++++++++
 fs/btrfs/super.c   |  2 --
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3c2251199f0c..5ca32bbdad53 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2430,7 +2430,18 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
 		return PTR_ERR(csum_shash);
 	}
 
+	/*
+	 * Find the fastest implementation available, but keep the slots
+	 * matching the type.
+	 */
 	fs_info->csum_shash[CSUM_DEFAULT] = csum_shash;
+	if (strstr(crypto_shash_driver_name(csum_shash)), "generic") != NULL) {
+		fs_info->csum_shash[CSUM_GENERIC] = csum_shash;
+		clear_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
+	} else {
+		fs_info->csum_shash[CSUM_ACCEL] = csum_shash;
+		set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
+	}
 
 	btrfs_info(fs_info, "using %s (%s) checksum algorithm",
 			btrfs_super_csum_name(csum_type),
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 1032aaa2c2f4..595b8d92ef86 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1819,8 +1819,6 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
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

