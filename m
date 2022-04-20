Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B50508329
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 10:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376498AbiDTILh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 04:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376625AbiDTILe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 04:11:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2C1E23
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 01:08:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 214CD210F4
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 08:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650442128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ddonTg2E3UY1IVNNJBI1j0ea3xIZd7e6dauLb5TgUME=;
        b=oFKheM8hS1hkRBLFgd3zp7RYRNYHQpeme2mGX/eij2gBLfS43yHibVR6UHKg7RfI0Obe++
        Sn0GVMh5warLEg5/w2uxsNLVjLgPQQ6KYlALsiZzghTS6+AZ8s8v1pRzqbVPRLO94N4ITb
        /BGd8WOwMgJIL9tvQ+Fa9K/pPPLOlZA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5EAF613AD5
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 08:08:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yOTWCI+/X2JEbAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 08:08:47 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/2] btrfs: move definition of btrfs_raid_types to volumes.h
Date:   Wed, 20 Apr 2022 16:08:27 +0800
Message-Id: <5f91946ad971e6d9a3d10dbcb1c9899fb939df1b.1650441750.git.wqu@suse.com>
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

It's only internally used as another way to represent btrfs profiles,
it's not exposed through any on-disk format, in fact this
btrfs_raid_types is diverted from the on-disk format values.

Furthermore, since it's internal structure, its definition can change in
the future.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/space-info.h           |  2 ++
 fs/btrfs/volumes.h              | 13 +++++++++++++
 include/uapi/linux/btrfs_tree.h | 13 -------------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index a803e29bd781..c096695598c1 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -3,6 +3,8 @@
 #ifndef BTRFS_SPACE_INFO_H
 #define BTRFS_SPACE_INFO_H
 
+#include "volumes.h"
+
 struct btrfs_space_info {
 	spinlock_t lock;
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f3e28f11cfb6..dbb15e4eaa50 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -17,6 +17,19 @@ extern struct mutex uuid_mutex;
 
 #define BTRFS_STRIPE_LEN	SZ_64K
 
+enum btrfs_raid_types {
+	BTRFS_RAID_RAID10,
+	BTRFS_RAID_RAID1,
+	BTRFS_RAID_DUP,
+	BTRFS_RAID_RAID0,
+	BTRFS_RAID_SINGLE,
+	BTRFS_RAID_RAID5,
+	BTRFS_RAID_RAID6,
+	BTRFS_RAID_RAID1C3,
+	BTRFS_RAID_RAID1C4,
+	BTRFS_NR_RAID_TYPES
+};
+
 struct btrfs_io_geometry {
 	/* remaining bytes before crossing a stripe */
 	u64 len;
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index b069752a8ecf..d4117152d907 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -880,19 +880,6 @@ struct btrfs_dev_replace_item {
 #define BTRFS_BLOCK_GROUP_RESERVED	(BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
 					 BTRFS_SPACE_INFO_GLOBAL_RSV)
 
-enum btrfs_raid_types {
-	BTRFS_RAID_RAID10,
-	BTRFS_RAID_RAID1,
-	BTRFS_RAID_DUP,
-	BTRFS_RAID_RAID0,
-	BTRFS_RAID_SINGLE,
-	BTRFS_RAID_RAID5,
-	BTRFS_RAID_RAID6,
-	BTRFS_RAID_RAID1C3,
-	BTRFS_RAID_RAID1C4,
-	BTRFS_NR_RAID_TYPES
-};
-
 #define BTRFS_BLOCK_GROUP_TYPE_MASK	(BTRFS_BLOCK_GROUP_DATA |    \
 					 BTRFS_BLOCK_GROUP_SYSTEM |  \
 					 BTRFS_BLOCK_GROUP_METADATA)
-- 
2.35.1

