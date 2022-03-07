Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121D34D0ABB
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343656AbiCGWOi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244935AbiCGWOh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:14:37 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C98D56405
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:13:42 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id v189so4298721qkd.2
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=K8N2ownkiB12e9ANcz4LtWScMLuElMiEwjtuSVZdsuk=;
        b=UEZb3rdwMNtTtMEC79iofCrFvY0pI6nF4yTjMAhQQtFW3xbfHEfxJ8qfnizWKLEuBi
         aHrboyOh8IzUtFqkoZZ/zHtPKFXniI/9Cf7L+jXn8N+1/EtOEe61YCT6o/jLIbEMXSfZ
         bImMDjVGpOy9zLsXELASa+6ymV7+8sr0kzTrbTs7ZsQMtjnXVNYSAV2q5bz91jlDwVkX
         8dXY8Rzw+Ji3NfnnIE27LVUxn/ZuMspNVSCwqZtiL4NCi/RmARHl5717uXnaDRqjAdFi
         ayj/Dyihx1fZuteHIz2C7GZXaPc/jxL4RgkU/xavcM28LMxwMUOD/WoHJa8H4m+uyteX
         X+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K8N2ownkiB12e9ANcz4LtWScMLuElMiEwjtuSVZdsuk=;
        b=QzIwMVKODlZxmFvxc18M9rLJBikkrZf35c+BhMPri0pi2OKhEQVuF3NSOhlwWTDEpo
         vvehxdS4UbN3+WEwQ2eig+IFCOzGciRKwZP5a2XzWY20XF+ax4nghWydRW6PNZ48rjJG
         mYoDJe02MkzmRaSy5QBcbIAx6WGWJetkLIxdCZ1FXbAkQw59852qcnj+zc3QJFcjnJ0h
         v11DNi4aP7IqwhRlA1QKrxbWnnzjcI+jaTRoZUBxaBl1+63FbpQk0XLBIXtmlM2CJCNO
         3b43YDdg7LmnYPau564kVNLmaQo6HM8t+tTxdR8dN36GHV028PLV4xYLsqYTZR43N5F3
         o32Q==
X-Gm-Message-State: AOAM533Ba211rd8tDtVRQ3g2OC2G60khHsVID8qangnt/ECtXM60quMP
        7EqmEJZxx7ta3+uuyBY94eyPnE6QHtELsDoP
X-Google-Smtp-Source: ABdhPJz0cCS/N1npIX6S8sJGKK6CPVMNU/SPBbQHgmGJAuuLpmaZlqNdgjZSOJazd1EBcRyERNFdCg==
X-Received: by 2002:a37:a64b:0:b0:47c:3ad5:bf8c with SMTP id p72-20020a37a64b000000b0047c3ad5bf8cmr8478316qke.13.1646691220997;
        Mon, 07 Mar 2022 14:13:40 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t18-20020ac85892000000b002de3a8bf768sm9843533qta.52.2022.03.07.14.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:13:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 13/15] btrfs-progs: add on-disk items and read support for the gc tree
Date:   Mon,  7 Mar 2022 17:13:18 -0500
Message-Id: <e8ceb59cd4f2a30a2634359bba47132ea84a26db.1646691128.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691128.git.josef@toxicpanda.com>
References: <cover.1646691128.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This add's the necessary on disk structures for the initial garbage
collection tree.  At first we're going to just add orphan item support,
and then add other items as the support lands for those new operations.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h      |  6 ++++++
 kernel-shared/disk-io.c    | 10 ++++++++++
 kernel-shared/print-tree.c |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index d79f49c9..72c87485 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -88,6 +88,9 @@ struct btrfs_free_space_ctl;
 /* hold the block group items. */
 #define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
 
+/* hold the garbage collection items. */
+#define BTRFS_GC_TREE_OBJECTID 12ULL
+
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 
@@ -1362,6 +1365,9 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_XATTR_ITEM_KEY		24
 #define BTRFS_ORPHAN_ITEM_KEY		48
 
+/* Garbage collection items. */
+#define BTRFS_GC_INODE_ITEM_KEY		49
+
 #define BTRFS_DIR_LOG_ITEM_KEY  60
 #define BTRFS_DIR_LOG_INDEX_KEY 72
 /*
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 4964cd38..35422d8c 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1222,6 +1222,16 @@ static int load_global_roots(struct btrfs_fs_info *fs_info, unsigned flags)
 	ret = load_global_roots_objectid(fs_info, path,
 					 BTRFS_FREE_SPACE_TREE_OBJECTID, flags,
 					 "free space");
+	if (ret)
+		goto out;
+	if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		goto out;
+	/* We are from mkfs, we haven't setup the GC tree yet. */
+	if (flags & OPEN_CTREE_TEMPORARY_SUPER)
+		goto out;
+	ret = load_global_roots_objectid(fs_info, path,
+					 BTRFS_GC_TREE_OBJECTID, flags,
+					 "garbage collection");
 out:
 	btrfs_free_path(path);
 	return ret;
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 978d92bc..554cc641 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -677,6 +677,7 @@ void print_key_type(FILE *stream, u64 objectid, u8 type)
 		[BTRFS_PERSISTENT_ITEM_KEY]	= "PERSISTENT_ITEM",
 		[BTRFS_UUID_KEY_SUBVOL]		= "UUID_KEY_SUBVOL",
 		[BTRFS_UUID_KEY_RECEIVED_SUBVOL] = "UUID_KEY_RECEIVED_SUBVOL",
+		[BTRFS_GC_INODE_ITEM_KEY]	= "GC_INODE_ITEM_KEY",
 	};
 
 	if (type == 0 && objectid == BTRFS_FREE_SPACE_OBJECTID) {
@@ -786,6 +787,9 @@ void print_objectid(FILE *stream, u64 objectid, u8 type)
 	case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
 		fprintf(stream, "BLOCK_GROUP_TREE");
 		break;
+	case BTRFS_GC_TREE_OBJECTID:
+		fprintf(stream, "GC_TREE");
+		break;
 	case (u64)-1:
 		fprintf(stream, "-1");
 		break;
-- 
2.26.3

