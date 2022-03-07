Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2034D0A81
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245598AbiCGWFc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245670AbiCGWF3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:05:29 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6DA43AE7
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:04:33 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id s15so14566368qtk.10
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FFKDahwoxFbyRTXGbjnwo/JlK2TRKWmi8akyPMSsDUQ=;
        b=R+wVAHg2bGRtOuS8m5rTpXYdO6j8irMCJSoJNiBKS2Ckou50gsscXDgrgLZrazK/e3
         1RkGmguAPDJRmMS9CGUyLxxfIYc9wJ8uITA0KaXsbwl44fjCBvNaRIRFNWkDIxiL9DZe
         ewW+lgMe7USpKJ8EIemmlJE1iAV1peJVeb4vlNWJp4aEpW+IZ21S5Phy7GBPKtq/ob/w
         HFDB2pyrhj+DYOYQ4UgUGQlRyMZx7E/gfJRrY1b5dy1QBLbxLVd15mpeDPm3uZm92Fb4
         HOf0ICRUit/uH5VNgH2PEiKMpbdZGk3sPk+D//gobHnSopgyoevjI42i01035cjl2e/3
         3kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FFKDahwoxFbyRTXGbjnwo/JlK2TRKWmi8akyPMSsDUQ=;
        b=UCWAxIqU4It+r+UN+Moq1KGkxMPoZcyvSA2XzA+aIJqcz8fLiw6U2TxQhljKw2EmU6
         CemrxwIOjYiwFfE988bGcaipNBV1Vq1fUG47+msqoYH96VS2nThW4ogkC2XzQgLeheLn
         7WmUsrKwKDfAWxhaEh3fDwVETxrCJ8/NSLqU5w5X9UGE/dPrYiWqpcU6nspzHXUu76Mw
         Q77hm9pITd+S0hMAO9O5Ccz7LJGgufEpsKaj0uM+keoWbUr2X8N1jRlRGiK069nynRHw
         dMHz3RhB5uQ3OyGvm0nvget4v0H13kQo4vw8d6MGrUNHJ7wnC3Fga0uG2dsm7cNKWs10
         sGMw==
X-Gm-Message-State: AOAM530FQl4DVcQ5e0knSC0Q/SwukDQhlhljJc1+EIoFPnpjCiZ2xxuA
        UhLPzop8/6anc1/ICwn5OKRMeqS+wXF4Omer
X-Google-Smtp-Source: ABdhPJwBBNFfbJvbn4bdI/TWbQpbew4Hrgo5w87QAq2tkzdkeBR06bM3Uu7xOpn3j9aRmLIIgZCJ/A==
X-Received: by 2002:ac8:7fca:0:b0:2de:8f3d:89be with SMTP id b10-20020ac87fca000000b002de8f3d89bemr11377885qtk.34.1646690672734;
        Mon, 07 Mar 2022 14:04:32 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i11-20020a379f0b000000b0067b1399f20esm2697184qke.44.2022.03.07.14.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:04:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 3/6] btrfs: add definitions and read support for the garbage collection tree
Date:   Mon,  7 Mar 2022 17:04:24 -0500
Message-Id: <ae0d5dee7b0c7d0b41994632ebf3f146ddb8555a.1646690556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646690555.git.josef@toxicpanda.com>
References: <cover.1646690555.git.josef@toxicpanda.com>
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

This adds the on disk definitions for the garbage collection tree and
the code to load it on mount.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c              | 6 ++++++
 fs/btrfs/print-tree.c           | 4 ++++
 include/uapi/linux/btrfs_tree.h | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index aeefc4e2e71a..3546a3af9ad7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2678,6 +2678,12 @@ static int load_global_roots(struct btrfs_root *tree_root)
 	ret = load_global_roots_objectid(tree_root, path,
 					 BTRFS_FREE_SPACE_TREE_OBJECTID,
 					 "free space");
+	if (ret)
+		goto out;
+	if (!btrfs_fs_incompat(tree_root->fs_info, EXTENT_TREE_V2))
+		goto out;
+	ret = load_global_roots_objectid(tree_root, path,
+					 BTRFS_GC_TREE_OBJECTID, "gc");
 out:
 	btrfs_free_path(path);
 	return ret;
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index dd8777872143..a0b0d5d68826 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -24,6 +24,7 @@ static const struct root_name_map root_map[] = {
 	{ BTRFS_UUID_TREE_OBJECTID,		"UUID_TREE"		},
 	{ BTRFS_FREE_SPACE_TREE_OBJECTID,	"FREE_SPACE_TREE"	},
 	{ BTRFS_BLOCK_GROUP_TREE_OBJECTID,	"BLOCK_GROUP_TREE"	},
+	{ BTRFS_GC_TREE_OBJECTID,		"GC_TREE"		},
 	{ BTRFS_DATA_RELOC_TREE_OBJECTID,	"DATA_RELOC_TREE"	},
 };
 
@@ -348,6 +349,9 @@ void btrfs_print_leaf(struct extent_buffer *l)
 			print_uuid_item(l, btrfs_item_ptr_offset(l, i),
 					btrfs_item_size(l, i));
 			break;
+		case BTRFS_GC_INODE_ITEM_KEY:
+			pr_info("\t\tgc inode item\n");
+			break;
 		}
 	}
 }
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index b069752a8ecf..4a363289c90e 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -56,6 +56,9 @@
 /* Holds the block group items for extent tree v2. */
 #define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
 
+/* holds the garbage collection itesm for extent tree v2. */
+#define BTRFS_GC_TREE_OBJECTID 12ULL
+
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 
@@ -147,6 +150,9 @@
 #define BTRFS_ORPHAN_ITEM_KEY		48
 /* reserve 2-15 close to the inode for later flexibility */
 
+/* The garbage collection items. */
+#define BTRFS_GC_INODE_ITEM_KEY		49
+
 /*
  * dir items are the name -> inode pointers in a directory.  There is one
  * for every name in a directory.  BTRFS_DIR_LOG_ITEM_KEY is no longer used
-- 
2.26.3

