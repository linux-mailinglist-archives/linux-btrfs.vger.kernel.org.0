Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A2D6C5CB2
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 03:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjCWCeZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 22:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjCWCeY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 22:34:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6707A2D14F
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 19:34:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4C9D75C1B4
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 02:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679538857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=EY1t008ysZ4x7ykNlm9RSNOgXbr3UxmFsLT+xFCiAoo=;
        b=tT1sTjYn/U0be5JNBJKDRZ5+uUTPCvYM78ku5wetHGvndHNHcR7GYmeLVFXMQMevcMtOw0
        rVdyAU1IngdAAINAMddPnKevvLW+ZOye/VEoky8OPk34hAAOsDX9/I1xQ5fCtQ4wWS27XX
        E/RBGQf2TlBuFCSRwHz9RgdvUoDLw1Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC96B13413
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 02:34:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VeGNHqi6G2RtCgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 02:34:16 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: convert: handle ext4 orphan file feature properly
Date:   Thu, 23 Mar 2023 10:33:59 +0800
Message-Id: <c481f192c76a98d5d750aa42f2d268a9bc20be5f.1679538836.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Since e2fsprog 1.47, even a newly created empty ext4, btrfs-convert
would result an fs that btrfs-check would complain:

 # mkfs.ext4 -F test.img
 # btrfs-convert test.img
 # btrfs-check test.img
 Opening filesystem to check...
 Checking filesystem on test.img
 UUID: e45da158-8967-4e4d-9c9f-66b0d127dbce
 [1/7] checking root items
 [2/7] checking extents
 [3/7] checking free space cache
 [4/7] checking fs roots
 root 5 inode 266 errors 2000, link count wrong
 ERROR: errors found in fs roots
 found 26333184 bytes used, error(s) found <<<
 total csum bytes: 25540
 total tree bytes: 180224
 total fs tree bytes: 49152
 total extent tree bytes: 16384
 btree space waste bytes: 145423
 file data blocks allocated: 33947648
  referenced 26284032

[CAUSE]
Ext4 has a new compat feature, COMPAT_ORPHAN_FILE, as a better way to
track all the orphan inodes.

This new feature would create a new special inode for this purpose, and
such orphan file inode would not be reachable from any other inode, but
only from super block.

Unfortunately btrfs-convert only skip ext2 known special inodes, not the
newer one.

[FIX]
According to the kernel document, we can locate the orphan file inode
using ext2 super block s_orphan_file_inum, and skip it for
btrfs-convert.

And such skip would only happen if we have the definition of
EXT4_FEATURE_COMPAT_ORPHAN_FILE, to be compatible with older e2fsprogs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/source-ext2.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index b0b865b99b7b..c8c8930a79e9 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -903,10 +903,20 @@ static int ext2_copy_single_inode(struct btrfs_trans_handle *trans,
 	return btrfs_insert_inode(trans, root, objectid, &btrfs_inode);
 }
 
-static int ext2_is_special_inode(ext2_ino_t ino)
+static bool ext2_is_special_inode(ext2_filsys ext2_fs, ext2_ino_t ino)
 {
 	if (ino < EXT2_GOOD_OLD_FIRST_INO && ino != EXT2_ROOT_INO)
 		return 1;
+#ifdef	EXT4_FEATURE_COMPAT_ORPHAN_FILE
+	/*
+	 * If we have COMPAT_ORPHAN_FILE feature, we have a special inode
+	 * recording all the orphan files.
+	 * We need to skip such special inode.
+	 */
+	if (ext2_fs->super->s_feature_compat & EXT4_FEATURE_COMPAT_ORPHAN_FILE &&
+	    ino == ext2_fs->super->s_orphan_file_inum)
+		return 1;
+#endif
 	return 0;
 }
 
@@ -940,7 +950,7 @@ static int ext2_copy_inodes(struct btrfs_convert_context *cctx,
 		/* no more inodes */
 		if (ext2_ino == 0)
 			break;
-		if (ext2_is_special_inode(ext2_ino))
+		if (ext2_is_special_inode(ext2_fs, ext2_ino))
 			continue;
 		objectid = ext2_ino + INO_OFFSET;
 		ret = ext2_copy_single_inode(trans, root,
-- 
2.39.2

