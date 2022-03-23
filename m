Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F964E596B
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 20:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344405AbiCWTzL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 15:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344421AbiCWTzK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 15:55:10 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5888BF35
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 12:53:37 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 646DE80785;
        Wed, 23 Mar 2022 15:53:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1648065216; bh=iB4Yyekjc8n8yCXDYWE3KrM6+DohGrVyII4pt8wYroI=;
        h=From:To:Cc:Subject:Date:From;
        b=JIVSwxFzV4snZgwyzWHxQGLwkOafSfKHbkuRdd94GbSmySxw/7Joc/F6eqbT+WqIF
         MpZlp5IMzwLeE0NFF4WTCcgfNMdgmKpJx2j/zR8P7DZ5II0YU7NdFhl4oHF/AWAhlw
         dSrSKFxVAXbUchnpcBSYvHsOfIbo9XiC0a+TGhgDBtdNF6dkMyT2lVmfY1Md4gFkPa
         9ttn0GEAj8zuBcENPQnPYJ2U16R+HwjWRL3KeUA+eKW33js1JGl7SWqPYSazvhd6wq
         rGb09dRyS+P+0VjbhFqjEkNRrgMHeYE4dOtfHez0hWeKteesqDFJIA+cNLP98pbSwY
         5S6OwkHgC+H3Q==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     boris@bur.io, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH] btrfs-progs: add print support for verity items.
Date:   Wed, 23 Mar 2022 15:45:05 -0400
Message-Id: <20220323194504.1777182-1-sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,DOS_RCVD_IP_TWICE_B,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

'btrfs inspect-internals dump-tree' doesn't currently know about the two
types of verity items and prints them as 'UNKNOWN.36' or 'UNKNOWN.37'.
So add them to the known item types.

Suggested-by: Boris Burkov <boris@bur.io>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

---

Inspired by Boris' recent patchset noting that these items were not yet
properly printed:
https://lore.kernel.org/linux-btrfs/5579a70597cd660ffb265db9e97840a1faca8812.1647382272.git.boris@bur.io/T/#u

---

 kernel-shared/ctree.h      | 4 ++++
 kernel-shared/print-tree.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index bf71fc85..b8d7e5a8 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1350,6 +1350,10 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_INODE_REF_KEY		12
 #define BTRFS_INODE_EXTREF_KEY		13
 #define BTRFS_XATTR_ITEM_KEY		24
+
+#define BTRFS_VERITY_DESC_ITEM_KEY	36
+#define BTRFS_VERITY_MERKLE_ITEM_KEY	37
+
 #define BTRFS_ORPHAN_ITEM_KEY		48
 
 #define BTRFS_DIR_LOG_ITEM_KEY  60
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 73f969c3..ee7f679c 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -647,6 +647,8 @@ void print_key_type(FILE *stream, u64 objectid, u8 type)
 		[BTRFS_DIR_LOG_ITEM_KEY]	= "DIR_LOG_ITEM",
 		[BTRFS_DIR_LOG_INDEX_KEY]	= "DIR_LOG_INDEX",
 		[BTRFS_XATTR_ITEM_KEY]		= "XATTR_ITEM",
+		[BTRFS_VERITY_DESC_ITEM_KEY]	= "VERITY_DESC_ITEM",
+		[BTRFS_VERITY_MERKLE_ITEM_KEY	= "VERITY_MERKLE_ITEM",
 		[BTRFS_ORPHAN_ITEM_KEY]		= "ORPHAN_ITEM",
 		[BTRFS_ROOT_ITEM_KEY]		= "ROOT_ITEM",
 		[BTRFS_ROOT_REF_KEY]		= "ROOT_REF",
-- 
2.35.1

