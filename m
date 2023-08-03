Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC5F76E43D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 11:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbjHCJVz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Aug 2023 05:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbjHCJVV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Aug 2023 05:21:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445DA3A98
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Aug 2023 02:21:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E4C171F855;
        Thu,  3 Aug 2023 09:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691054464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1lczLlsqiDo5ivIUi0C03K1t67PtetBSsRc11f+eqT8=;
        b=hEt2oj9wuNaKcAGDDNxPhWYoJ35yQK5A8Kl3+o/YsK0pg20iAg5X8ydd+N/lMviiUxywsl
        0sAw+fVi7ScerGYtmVoQUr3ui9aOajLSbirBKqhO897GAn/LAN6nykQRiecW5Mj3bZ+ajw
        PAPkiIV7svhJtUGFZ42utwq2G1l+MSY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 102A41333C;
        Thu,  3 Aug 2023 09:21:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2N8FM39xy2StbwAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 03 Aug 2023 09:21:03 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Subject: [PATCH v4 2/3] btrfs: exit gracefully if reloc roots don't match
Date:   Thu,  3 Aug 2023 17:20:42 +0800
Message-ID: <30acf23be32724aa2cae7e85a6b88e039f290773.1691054362.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691054362.git.wqu@suse.com>
References: <cover.1691054362.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Syzbot reported a crash that an ASSERT() got triggered inside
prepare_to_merge().

[CAUSE]
The root cause of the triggered ASSERT() is we can have a race between
quota tree creation and relocation.

This leads us to create a duplicated quota tree in the
btrfs_read_fs_root() path, and since it's treated as fs tree, it would
have ROOT_SHAREABLE flag, causing us to create a reloc tree for it.

The bug itself is fixed by a dedicated patch for it, but this already
taught us the ASSERT() is not something straightforward for
developers.

[ENHANCEMENT]
Instead of using an ASSERT(), let's handle it gracefully and output
extra info about the mismatch reloc roots to help debug.

Also with the above ASSERT() removed, we can trigger ASSERT(0)s inside
merge_reloc_roots() later.
Also replace those ASSERT(0)s with WARN_ON()s.

Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 44 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 9db2e6fa2cb2..2bd97d2cb52e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1916,7 +1916,38 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 				err = PTR_ERR(root);
 			break;
 		}
-		ASSERT(root->reloc_root == reloc_root);
+
+		if (unlikely(root->reloc_root != reloc_root)) {
+			if (root->reloc_root)
+				btrfs_err(fs_info,
+"reloc tree mismatch, root %lld has reloc root key (%lld %u %llu) gen %llu, expect reloc root key (%lld %u %llu) gen %llu",
+					  root->root_key.objectid,
+					  root->reloc_root->root_key.objectid,
+					  root->reloc_root->root_key.type,
+					  root->reloc_root->root_key.offset,
+					  btrfs_root_generation(
+						  &root->reloc_root->root_item),
+					  reloc_root->root_key.objectid,
+					  reloc_root->root_key.type,
+					  reloc_root->root_key.offset,
+					  btrfs_root_generation(
+						  &reloc_root->root_item));
+			else
+				btrfs_err(fs_info,
+"reloc tree mismatch, root %lld has no reloc root, expect reloc root key (%lld %u %llu) gen %llu",
+					  root->root_key.objectid,
+					  reloc_root->root_key.objectid,
+					  reloc_root->root_key.type,
+					  reloc_root->root_key.offset,
+					  btrfs_root_generation(
+						  &reloc_root->root_item));
+			list_add(&reloc_root->root_list, &reloc_roots);
+			btrfs_put_root(root);
+			btrfs_abort_transaction(trans, -EUCLEAN);
+			if (!err)
+				err = -EUCLEAN;
+			break;
+		}
 
 		/*
 		 * set reference count to 1, so btrfs_recover_relocation
@@ -1989,7 +2020,7 @@ void merge_reloc_roots(struct reloc_control *rc)
 		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
 					 false);
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
-			if (IS_ERR(root)) {
+			if (WARN_ON(IS_ERR(root))) {
 				/*
 				 * For recovery we read the fs roots on mount,
 				 * and if we didn't find the root then we marked
@@ -1998,17 +2029,14 @@ void merge_reloc_roots(struct reloc_control *rc)
 				 * memory.  However there's no reason we can't
 				 * handle the error properly here just in case.
 				 */
-				ASSERT(0);
 				ret = PTR_ERR(root);
 				goto out;
 			}
-			if (root->reloc_root != reloc_root) {
+			if (WARN_ON(root->reloc_root != reloc_root)) {
 				/*
-				 * This is actually impossible without something
-				 * going really wrong (like weird race condition
-				 * or cosmic rays).
+				 * This can happen if on-disk metadata has some
+				 * corruption, e.g. bad reloc tree key offset.
 				 */
-				ASSERT(0);
 				ret = -EINVAL;
 				goto out;
 			}
-- 
2.41.0

