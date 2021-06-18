Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53ED43ACE0B
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 16:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbhFRO52 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 10:57:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48748 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbhFRO50 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 10:57:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ABCF521B0D;
        Fri, 18 Jun 2021 14:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624028116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W26TCyQz4GoyzXPr6zI9gDOs7RD3qLO2oiGxx/5s3wM=;
        b=gcOXVp/PooFxoTrPpAVonhb8AF8vu9i6IWprzW/U3Sb+HodR7LaDrZ5g8dtVrmdKYjG+x5
        61jDlEo9gdglzi3O/0s12U8ilk1W7xhGppMPwDkZi9cepmKom//IiUd4gCtqnCDFsy2KYZ
        vakKN7Wk9qa27/vBl9LCs/NYb4XhSIM=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A5263A3B9D;
        Fri, 18 Jun 2021 14:55:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 13465DA7B0; Fri, 18 Jun 2021 16:52:28 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: switch mount option bits to enums and use wider type
Date:   Fri, 18 Jun 2021 16:52:28 +0200
Message-Id: <b821156f786564e0eb16c036428cd819b1ae9bf9.1624027617.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624027617.git.dsterba@suse.com>
References: <cover.1624027617.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Switch defines of BTRFS_MOUNT_* to an enum (the symbolic names are
recorded in the debugging information for convenience).

There are two more things done but separating them would not make much
sense as it's touching the same lines:

- Renumber shifts 18..31 to 17..30 to get rid of the hole in the
  sequence.

- Use 1UL as the value that gets shifted because we're approaching the
  32bit limit and due to integer promotions the value of (1 << 31)
  becomes 0xffffffff80000000 when cast to unsigned long (eg. the option
  manipulating helpers).

  This is not causing any problems yet as the operations are in-memory
  and masking the 31st bit works, we don't have more than 31 bits so the
  ill effects of not masking higher bits don't happen. But once we have
  more, the problems will emerge.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h | 65 ++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6131b58f779f..e0f6aa6e8bd2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1384,38 +1384,39 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
  *
  * Note: don't forget to add new options to btrfs_show_options()
  */
-#define BTRFS_MOUNT_NODATASUM		(1 << 0)
-#define BTRFS_MOUNT_NODATACOW		(1 << 1)
-#define BTRFS_MOUNT_NOBARRIER		(1 << 2)
-#define BTRFS_MOUNT_SSD			(1 << 3)
-#define BTRFS_MOUNT_DEGRADED		(1 << 4)
-#define BTRFS_MOUNT_COMPRESS		(1 << 5)
-#define BTRFS_MOUNT_NOTREELOG           (1 << 6)
-#define BTRFS_MOUNT_FLUSHONCOMMIT       (1 << 7)
-#define BTRFS_MOUNT_SSD_SPREAD		(1 << 8)
-#define BTRFS_MOUNT_NOSSD		(1 << 9)
-#define BTRFS_MOUNT_DISCARD_SYNC	(1 << 10)
-#define BTRFS_MOUNT_FORCE_COMPRESS      (1 << 11)
-#define BTRFS_MOUNT_SPACE_CACHE		(1 << 12)
-#define BTRFS_MOUNT_CLEAR_CACHE		(1 << 13)
-#define BTRFS_MOUNT_USER_SUBVOL_RM_ALLOWED (1 << 14)
-#define BTRFS_MOUNT_ENOSPC_DEBUG	 (1 << 15)
-#define BTRFS_MOUNT_AUTO_DEFRAG		(1 << 16)
-/* bit 17 is free */
-#define BTRFS_MOUNT_USEBACKUPROOT	(1 << 18)
-#define BTRFS_MOUNT_SKIP_BALANCE	(1 << 19)
-#define BTRFS_MOUNT_CHECK_INTEGRITY	(1 << 20)
-#define BTRFS_MOUNT_CHECK_INTEGRITY_INCLUDING_EXTENT_DATA (1 << 21)
-#define BTRFS_MOUNT_PANIC_ON_FATAL_ERROR	(1 << 22)
-#define BTRFS_MOUNT_RESCAN_UUID_TREE	(1 << 23)
-#define BTRFS_MOUNT_FRAGMENT_DATA	(1 << 24)
-#define BTRFS_MOUNT_FRAGMENT_METADATA	(1 << 25)
-#define BTRFS_MOUNT_FREE_SPACE_TREE	(1 << 26)
-#define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
-#define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
-#define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
-#define BTRFS_MOUNT_IGNOREBADROOTS	(1 << 30)
-#define BTRFS_MOUNT_IGNOREDATACSUMS	(1 << 31)
+enum {
+	BTRFS_MOUNT_NODATASUM			= (1UL << 0),
+	BTRFS_MOUNT_NODATACOW			= (1UL << 1),
+	BTRFS_MOUNT_NOBARRIER			= (1UL << 2),
+	BTRFS_MOUNT_SSD				= (1UL << 3),
+	BTRFS_MOUNT_DEGRADED			= (1UL << 4),
+	BTRFS_MOUNT_COMPRESS			= (1UL << 5),
+	BTRFS_MOUNT_NOTREELOG   		= (1UL << 6),
+	BTRFS_MOUNT_FLUSHONCOMMIT		= (1UL << 7),
+	BTRFS_MOUNT_SSD_SPREAD			= (1UL << 8),
+	BTRFS_MOUNT_NOSSD			= (1UL << 9),
+	BTRFS_MOUNT_DISCARD_SYNC		= (1UL << 10),
+	BTRFS_MOUNT_FORCE_COMPRESS      	= (1UL << 11),
+	BTRFS_MOUNT_SPACE_CACHE			= (1UL << 12),
+	BTRFS_MOUNT_CLEAR_CACHE			= (1UL << 13),
+	BTRFS_MOUNT_USER_SUBVOL_RM_ALLOWED	= (1UL << 14),
+	BTRFS_MOUNT_ENOSPC_DEBUG		= (1UL << 15),
+	BTRFS_MOUNT_AUTO_DEFRAG			= (1UL << 16),
+	BTRFS_MOUNT_USEBACKUPROOT		= (1UL << 17),
+	BTRFS_MOUNT_SKIP_BALANCE		= (1UL << 18),
+	BTRFS_MOUNT_CHECK_INTEGRITY		= (1UL << 19),
+	BTRFS_MOUNT_CHECK_INTEGRITY_INCLUDING_EXTENT_DATA = (1UL << 20),
+	BTRFS_MOUNT_PANIC_ON_FATAL_ERROR	= (1UL << 21),
+	BTRFS_MOUNT_RESCAN_UUID_TREE		= (1UL << 22),
+	BTRFS_MOUNT_FRAGMENT_DATA		= (1UL << 23),
+	BTRFS_MOUNT_FRAGMENT_METADATA		= (1UL << 24),
+	BTRFS_MOUNT_FREE_SPACE_TREE		= (1UL << 25),
+	BTRFS_MOUNT_NOLOGREPLAY			= (1UL << 26),
+	BTRFS_MOUNT_REF_VERIFY			= (1UL << 27),
+	BTRFS_MOUNT_DISCARD_ASYNC		= (1UL << 28),
+	BTRFS_MOUNT_IGNOREBADROOTS		= (1UL << 29),
+	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 30),
+};
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
-- 
2.31.1

