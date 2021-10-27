Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8596E43C238
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 07:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239545AbhJ0Fbo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 01:31:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50520 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238211AbhJ0Fbo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 01:31:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7A3831FD47
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 05:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635312558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05HVRSIpMPsS9hUSFqXgEItUlRvyGBg8doPKweUJG+Y=;
        b=ROvOvkDSM7eWwnZOSgb9OUp6GQdnQPLYRKgGkWG14id4zJ4x54bueBtMh20MFqDv08ksgc
        YQQrwPOllFbzjrwero0M5WLqoD7hn077o6/IgLgNMD0w7V5c4TSYimZYJLLueyic+R0GaS
        9jCn1pfo4v2i4mvTdsP2bi0ktAotd8g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5F1013D13
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 05:29:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SGYVI63jeGH3RgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 05:29:17 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs: move definition of btrfs_raid_types to volumes.h
Date:   Wed, 27 Oct 2021 13:28:58 +0800
Message-Id: <20211027052859.44507-2-wqu@suse.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211027052859.44507-1-wqu@suse.com>
References: <20211027052859.44507-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's only internally used as another way to represent btrfs profiles,
it's not exposed through any on-disk format.

Furthermore, since it's internal structure, its definition can change in
the future.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.h              | 13 +++++++++++++
 include/uapi/linux/btrfs_tree.h | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3b8130680749..e0c374a7c30b 100644
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
index e1c4c732aaba..819dec72f232 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -875,19 +875,6 @@ struct btrfs_dev_replace_item {
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
2.33.1

