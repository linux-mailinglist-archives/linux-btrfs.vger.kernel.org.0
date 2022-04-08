Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FDD4F9B72
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 19:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbiDHRRV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 13:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbiDHRRU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 13:17:20 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E841D2E09D;
        Fri,  8 Apr 2022 10:15:13 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 81FB9802B5;
        Fri,  8 Apr 2022 13:15:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1649438113; bh=sOloqC9Hoe8taMsC7pqq6QLu8pc1+Df4rG4vqV3DLrw=;
        h=From:To:Cc:Subject:Date:From;
        b=fxrh/L3ufFOfYrGQPpb0KQstKoL//AmfeXWxAMOIl/g5DHKPldJ8JvLMuDqumYVjd
         j1/AgFnENR+NoBT2PYTSSEZyup0WwOBYNHNI9eUEqrFKwm1yWBR8nFHisQ2Loy9fWg
         WW3W92dkShwmkEeLUhthmeAykogwPhQDhnH6XlCK0ltxiEt2pgnX6oBtqi0e/nEhCj
         gCCehCQBmfnKIVgGtoQhoamxs198RApm32uZ4aQ8ZtIFgtpxFHU4/TgNFWOcT91Tx3
         HRDUK+upeqvsRrWH6b5LNbv1HcCkasQbTGzdDvUBcInkElX17ER7XIMgHH2dlOZtXG
         HPoJRJuOaiAUQ==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Omar Sandoval <osandov@osandov.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: restore inode creation before xattr setting
Date:   Fri,  8 Apr 2022 13:15:07 -0400
Message-Id: <8a60e54c02d8951cf5650cc8452ae583c130bbf7.1649437335.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,DOS_RCVD_IP_TWICE_B,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

According to the tree checker, "all xattrs with a given objectid follow
the inode with that objectid in the tree" is an invariant. This was
broken by the recent change "btrfs: move common inode creation code into
btrfs_create_new_inode()", which moved acl creation and property
inheritance (stored in xattrs) to before inode insertion into the tree.
As a result, under certain timings, the xattrs could be written to the
tree before the inode, causing the tree checker to report violation of
the invariant.

Move property inheritance and acl creation back to their old ordering
after the inode insertion.

Suggested-by: Omar Sandoval <osandov@osandov.com>
Reported-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
This should apply on top of osandov's patch at
 https://lore.kernel.org/linux-btrfs/da6cfa1b8e42db5c8954680cac1ca322d463b880.1647306546.git.osandov@fb.com/

It's survived a good dose of fstests, and several iterations of specific
tests that were failing, e.g. generic/650.

David: I don't know if you'd rather roll this into osandov's original
patch, or whether you'd like me or osandov to resend the patch linked
above with this addition rolled into it, or whether you'd like to apply
it separately. 

---
 fs/btrfs/inode.c | 74 ++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2f4935649555..213e7048d911 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6213,43 +6213,6 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	if (args->subvol) {
-		struct inode *parent;
-
-		/*
-		 * Subvolumes inherit properties from their parent subvolume,
-		 * not the directory they were created in.
-		 */
-		parent = btrfs_iget(fs_info->sb, BTRFS_FIRST_FREE_OBJECTID,
-				    BTRFS_I(dir)->root);
-		if (IS_ERR(parent)) {
-			ret = PTR_ERR(parent);
-		} else {
-			ret = btrfs_inode_inherit_props(trans, inode, parent);
-			iput(parent);
-		}
-	} else {
-		ret = btrfs_inode_inherit_props(trans, inode, dir);
-	}
-	if (ret) {
-		btrfs_err(fs_info,
-			  "error inheriting props for ino %llu (root %llu): %d",
-			  btrfs_ino(BTRFS_I(inode)), root->root_key.objectid,
-			  ret);
-	}
-
-	/*
-	 * Subvolumes don't inherit ACLs or get passed to the LSM. This is
-	 * probably a bug.
-	 */
-	if (!args->subvol) {
-		ret = btrfs_init_inode_security(trans, args);
-		if (ret) {
-			btrfs_abort_transaction(trans, ret);
-			goto discard;
-		}
-	}
-
 	/*
 	 * We could have gotten an inode number from somebody who was fsynced
 	 * and then removed in this same transaction, so let's just set full
@@ -6327,6 +6290,43 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(path->nodes[0]);
 	btrfs_release_path(path);
 
+	if (args->subvol) {
+		struct inode *parent;
+
+		/*
+		 * Subvolumes inherit properties from their parent subvolume,
+		 * not the directory they were created in.
+		 */
+		parent = btrfs_iget(fs_info->sb, BTRFS_FIRST_FREE_OBJECTID,
+				    BTRFS_I(dir)->root);
+		if (IS_ERR(parent)) {
+			ret = PTR_ERR(parent);
+		} else {
+			ret = btrfs_inode_inherit_props(trans, inode, parent);
+			iput(parent);
+		}
+	} else {
+		ret = btrfs_inode_inherit_props(trans, inode, dir);
+	}
+	if (ret) {
+		btrfs_err(fs_info,
+			  "error inheriting props for ino %llu (root %llu): %d",
+			  btrfs_ino(BTRFS_I(inode)), root->root_key.objectid,
+			  ret);
+	}
+
+	/*
+	 * Subvolumes don't inherit ACLs or get passed to the LSM. This is
+	 * probably a bug.
+	 */
+	if (!args->subvol) {
+		ret = btrfs_init_inode_security(trans, args);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto discard;
+		}
+	}
+
 	inode_tree_add(inode);
 
 	trace_btrfs_inode_new(inode);
-- 
2.35.1

