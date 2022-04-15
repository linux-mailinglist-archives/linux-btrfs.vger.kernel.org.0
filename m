Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F61150267E
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Apr 2022 10:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351308AbiDOIGl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Apr 2022 04:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244921AbiDOIGj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Apr 2022 04:06:39 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23730A204F
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 01:04:12 -0700 (PDT)
From:   Chung-Chiang Cheng <cccheng@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1650009850; bh=QQBa8d1ySWNdzGeUund8uyWp5xzqnd6NipZxFAh2ruQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bLJ7LTwTgvO4rkHocLBNnqGj/A0j8b05dNtfTssopB6hoeO9QPny+DZSCZ/e+F9wT
         roMQmOnVO3zKymYVkSLcN/hHBI96H7Sh/TzhgEerv4Hjo4XwK+eccQtg+1+h7PlrHx
         lCdHVMdjuLFElck4D0vXO21TVc0OCd689eIRQMdc=
To:     dsterba@suse.com, fdmanana@kernel.org
Cc:     josef@toxicpanda.com, clm@fb.com, linux-btrfs@vger.kernel.org,
        shepjeng@gmail.com, kernel@cccheng.net,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Jayce Lin <jaycelin@synology.com>
Subject: [PATCH 2/2] btrfs: do not allow compression on nodatacow files
Date:   Fri, 15 Apr 2022 16:04:06 +0800
Message-Id: <20220415080406.234967-2-cccheng@synology.com>
In-Reply-To: <20220415080406.234967-1-cccheng@synology.com>
References: <20220415080406.234967-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Compression and nodatacow are mutually exclusive. A similar issue was
fixed by commit f37c563bab429 ("btrfs: add missing check for nocow and
compression inode flags"). Besides ioctl, there is another way to
enable/disable/reset compression directly via xattr. The following
steps will result in a invalid combination.

  $ touch bar
  $ chattr +C bar
  $ lsattr bar
  ---------------C-- bar
  $ setfattr -n btrfs.compression -v zstd bar
  $ lsattr bar
  --------c------C-- bar

To align with the logic in check_fsflags, nocompress will also be
unacceptable after this patch, to prevent mix any compression-related
options with nodatacow.

  $ touch bar
  $ chattr +C bar
  $ lsattr bar
  ---------------C-- bar
  $ setfattr -n btrfs.compression -v zstd bar
  setfattr: bar: Invalid argument
  $ setfattr -n btrfs.compression -v no bar
  setfattr: bar: Invalid argument

Reported-by: Jayce Lin <jaycelin@synology.com>
Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 fs/btrfs/props.c | 16 +++++++++++-----
 fs/btrfs/props.h |  3 ++-
 fs/btrfs/xattr.c |  2 +-
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index 1a6d2d5b4b33..5a6f87744c28 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -17,7 +17,8 @@ static DEFINE_HASHTABLE(prop_handlers_ht, BTRFS_PROP_HANDLERS_HT_BITS);
 struct prop_handler {
 	struct hlist_node node;
 	const char *xattr_name;
-	int (*validate)(const char *value, size_t len);
+	int (*validate)(const struct btrfs_inode *inode, const char *value,
+			size_t len);
 	int (*apply)(struct inode *inode, const char *value, size_t len);
 	const char *(*extract)(struct inode *inode);
 	int inheritable;
@@ -55,7 +56,8 @@ find_prop_handler(const char *name,
 	return NULL;
 }
 
-int btrfs_validate_prop(const char *name, const char *value, size_t value_len)
+int btrfs_validate_prop(const struct btrfs_inode *inode, const char *name,
+			const char *value, size_t value_len)
 {
 	const struct prop_handler *handler;
 
@@ -69,7 +71,7 @@ int btrfs_validate_prop(const char *name, const char *value, size_t value_len)
 	if (value_len == 0)
 		return 0;
 
-	return handler->validate(value, value_len);
+	return handler->validate(inode, value, value_len);
 }
 
 int btrfs_set_prop(struct btrfs_trans_handle *trans, struct inode *inode,
@@ -252,8 +254,12 @@ int btrfs_load_inode_props(struct inode *inode, struct btrfs_path *path)
 	return ret;
 }
 
-static int prop_compression_validate(const char *value, size_t len)
+static int prop_compression_validate(const struct btrfs_inode *inode,
+				     const char *value, size_t len)
 {
+	if (!btrfs_inode_can_compress(inode))
+		return -EINVAL;
+
 	if (!value)
 		return 0;
 
@@ -364,7 +370,7 @@ static int inherit_props(struct btrfs_trans_handle *trans,
 		 * This is not strictly necessary as the property should be
 		 * valid, but in case it isn't, don't propagate it further.
 		 */
-		ret = h->validate(value, strlen(value));
+		ret = h->validate(BTRFS_I(inode), value, strlen(value));
 		if (ret)
 			continue;
 
diff --git a/fs/btrfs/props.h b/fs/btrfs/props.h
index 40b2c65b518c..2b2ac15ab788 100644
--- a/fs/btrfs/props.h
+++ b/fs/btrfs/props.h
@@ -13,7 +13,8 @@ void __init btrfs_props_init(void);
 int btrfs_set_prop(struct btrfs_trans_handle *trans, struct inode *inode,
 		   const char *name, const char *value, size_t value_len,
 		   int flags);
-int btrfs_validate_prop(const char *name, const char *value, size_t value_len);
+int btrfs_validate_prop(const struct btrfs_inode *inode, const char *name,
+			const char *value, size_t value_len);
 
 int btrfs_load_inode_props(struct inode *inode, struct btrfs_path *path);
 
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 99abf41b89b9..9632d0ff2038 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -403,7 +403,7 @@ static int btrfs_xattr_handler_set_prop(const struct xattr_handler *handler,
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 
 	name = xattr_full_name(handler, name);
-	ret = btrfs_validate_prop(name, value, size);
+	ret = btrfs_validate_prop(BTRFS_I(inode), name, value, size);
 	if (ret)
 		return ret;
 
-- 
2.34.1

