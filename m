Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEF4509D0A
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 12:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388017AbiDUKES (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 06:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbiDUKEQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 06:04:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5C3245AF
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 03:01:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 871D9617F5
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 10:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F489C385A5
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 10:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650535286;
        bh=OKXCUhD3tcH7rYjWg69Iv0uKhUd/Szfnf0nULEnOSlg=;
        h=From:To:Subject:Date:From;
        b=YQYdlf0qsIq4PsslltbgyL6my8TayoaV07UN7r5JCEh0IFpFJK+mpp+tbA9Ap4jxV
         0ApReghXJdTPFYvtTOWqucay1242J1gdQ4wnJhPsGJKkjN0mLeokDhxiAe0jJDC+xi
         Ww5yt7+oxT81uneOgXxIgoYvUV+2+6C1AA8H/dtH7wDy7VWMfflFfKz/8JrMMz8XaK
         brPzAMfOh6Rr496fPv/PFi2e5opvHYUpRLEp1/4O7GZiBm4DmGwK8Ui/WloldPVW3s
         J0BEdO+l2xCpQS1DFxMPZ9JKc5eM251wx99Ov2VE/8UTNhyb1sSJp4o4USpYF67GUS
         fcT5DE1iA3U8g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: skip compression property for anything other than files and dirs
Date:   Thu, 21 Apr 2022 11:01:22 +0100
Message-Id: <bbb363e71d966670d8938898803dac2b8a581c7c.1650535137.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The compression property only has effect on regular files and directories
(so that it's propagated to files and subdirectories created inside a
directory). For any other inode type (symlink, fifo, device, socket),
it's pointless to set the compression property because it does nothing
and ends up unnecessarily wasting leaf space due to the pointless xattr
(75 or 76 bytes, depending on the compression value). Symlinks in
particular are very common (for example, I have almost 10k symlinks under
/etc, /usr and /var alone) and therefore it's worth to avoid wasting
leaf space with the compression xattr.

For example, the compression property can end up on a symlink or character
device implicitly, through inheritance from a parent directory

  $ mkdir /mnt/testdir
  $ btrfs property set /mnt/testdir compression lzo

  $ ln -s yadayada /mnt/testdir/lnk
  $ mknod /mnt/testdir/dev c 0 0

Or explicitly like this:

  $ ln -s yadayda /mnt/lnk
  $ setfattr -h -n btrfs.compression -v lzo /mnt/lnk

So skip the compression property on inodes that are neither a regular
file nor a directory.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/props.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/props.h |  1 +
 fs/btrfs/xattr.c |  3 +++
 3 files changed, 47 insertions(+)

diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index f5565c296898..7a0038797015 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -20,6 +20,7 @@ struct prop_handler {
 	int (*validate)(const char *value, size_t len);
 	int (*apply)(struct inode *inode, const char *value, size_t len);
 	const char *(*extract)(struct inode *inode);
+	bool (*ignore)(const struct btrfs_inode *inode);
 	int inheritable;
 };
 
@@ -72,6 +73,28 @@ int btrfs_validate_prop(const char *name, const char *value, size_t value_len)
 	return handler->validate(value, value_len);
 }
 
+/*
+ * Check if a property should be ignored (not set) for an inode.
+ *
+ * @inode:     The target inode.
+ * @name:      The property's name.
+ *
+ * The caller must be sure the given property name is valid, for example by
+ * having previously called btrfs_validate_prop().
+ *
+ * Returns:    true if the property should be ignored for the given inode
+ *             false if the property must not be ignored for the given inode
+ */
+bool btrfs_ignore_prop(const struct btrfs_inode *inode, const char *name)
+{
+	const struct prop_handler *handler;
+
+	handler = find_prop_handler(name, NULL);
+	ASSERT(handler != NULL);
+
+	return handler->ignore(inode);
+}
+
 int btrfs_set_prop(struct btrfs_trans_handle *trans, struct inode *inode,
 		   const char *name, const char *value, size_t value_len,
 		   int flags)
@@ -310,6 +333,22 @@ static int prop_compression_apply(struct inode *inode, const char *value,
 	return 0;
 }
 
+static bool prop_compression_ignore(const struct btrfs_inode *inode)
+{
+	/*
+	 * Compression only has effect for regular files, and for directories
+	 * we set it just to propagate it to new files created inside them.
+	 * Everything else (symlinks, devices, sockets, fifos) is pointless as
+	 * it will do nothing, so don't waste metadata space on a compression
+	 * xattr for anything that is neither a file nor a directory.
+	 */
+	if (!S_ISREG(inode->vfs_inode.i_mode) &&
+	    !S_ISDIR(inode->vfs_inode.i_mode))
+		return true;
+
+	return false;
+}
+
 static const char *prop_compression_extract(struct inode *inode)
 {
 	switch (BTRFS_I(inode)->prop_compress) {
@@ -330,6 +369,7 @@ static struct prop_handler prop_handlers[] = {
 		.validate = prop_compression_validate,
 		.apply = prop_compression_apply,
 		.extract = prop_compression_extract,
+		.ignore = prop_compression_ignore,
 		.inheritable = 1
 	},
 };
@@ -355,6 +395,9 @@ int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
 		if (!h->inheritable)
 			continue;
 
+		if (h->ignore(BTRFS_I(inode)))
+			continue;
+
 		value = h->extract(parent);
 		if (!value)
 			continue;
diff --git a/fs/btrfs/props.h b/fs/btrfs/props.h
index 1dcd5daa3b22..09bf1702bb34 100644
--- a/fs/btrfs/props.h
+++ b/fs/btrfs/props.h
@@ -14,6 +14,7 @@ int btrfs_set_prop(struct btrfs_trans_handle *trans, struct inode *inode,
 		   const char *name, const char *value, size_t value_len,
 		   int flags);
 int btrfs_validate_prop(const char *name, const char *value, size_t value_len);
+bool btrfs_ignore_prop(const struct btrfs_inode *inode, const char *name);
 
 int btrfs_load_inode_props(struct inode *inode, struct btrfs_path *path);
 
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index b96ffd775b41..f9d22ff3567f 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -389,6 +389,9 @@ static int btrfs_xattr_handler_set_prop(const struct xattr_handler *handler,
 	if (ret)
 		return ret;
 
+	if (btrfs_ignore_prop(BTRFS_I(inode), name))
+		return 0;
+
 	trans = btrfs_start_transaction(root, 2);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
-- 
2.35.1

