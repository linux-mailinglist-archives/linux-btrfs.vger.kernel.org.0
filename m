Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02910574B15
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 12:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbiGNKsS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 06:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237289AbiGNKsP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 06:48:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AB751406
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 03:48:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D51061FB47;
        Thu, 14 Jul 2022 10:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657795692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=okMIiQ99fUiYNg1Qlt9kgfWiNw6NJ5kaEJZdCpPejQ8=;
        b=o8SSt5SDVo/r64VXhLud4g+sb6zLfwKzyayZICOyUke/lfeeohN+ktWswRu0lxHC19P3mX
        arM2NmZSpOYF+6G5sJArQUxhg4qsStFpDUWdJdg46Uce5FBVJ8UnLl2OhPpTXOuKkXAyhJ
        Lw2SMd96mEInnyy9m3hM8IgKt4UTvZg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A1C0B13A61;
        Thu, 14 Jul 2022 10:48:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wQK/JGz0z2LSTQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 14 Jul 2022 10:48:12 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] btrfs: simplify error handling in btrfs_lookup_dentry
Date:   Thu, 14 Jul 2022 13:48:10 +0300
Message-Id: <20220714104810.2733591-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_lookup_dentry releasing the reference of the sub_root and the
running orphan cleanup should only happen if the dentry found actually
represents a subvolume. This can only be true in the 'else' branch as
otherwise either fixup_tree_root_location returned an ENOENT error, in
which case sub_root wouldn't have been changed or if we got a different
errno this means btrfs_get_fs_root couldn't have executed successfully
again meaning sub_root will equal to root. So simplify all the branches
by moving the code into the 'else'.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

V2:
 - Replace sub_root with root parameter when calling new_dimple_dir since in this
 particular branch sub_root is always guaranteed to be equal to root

 - Properly handle error from btrfs_iget.

 fs/btrfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0b17335555e0..ee874ca90041 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5818,14 +5818,14 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 		if (ret != -ENOENT)
 			inode = ERR_PTR(ret);
 		else
-			inode = new_simple_dir(dir->i_sb, &location, sub_root);
+			inode = new_simple_dir(dir->i_sb, &location, root);
 	} else {
 		inode = btrfs_iget(dir->i_sb, location.objectid, sub_root);
-	}
-	if (root != sub_root)
 		btrfs_put_root(sub_root);

-	if (!IS_ERR(inode) && root != sub_root) {
+		if (IS_ERR(inode))
+			return inode;
+
 		down_read(&fs_info->cleanup_work_sem);
 		if (!sb_rdonly(inode->i_sb))
 			ret = btrfs_orphan_cleanup(sub_root);
--
2.25.1

