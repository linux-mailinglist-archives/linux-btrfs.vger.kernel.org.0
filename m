Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F7E76CA4B
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 12:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjHBKER (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 06:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbjHBKD7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 06:03:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB18D44BD
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 03:02:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 767E21F894;
        Wed,  2 Aug 2023 10:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690970563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J5vvSzH17RwphIzmJbq/4qCn8GzFykbVIx0HR1VgXrw=;
        b=kkGHCiF5TiCcu6VyhW4Nqy6jv/ydEQydDjM886G0F0abeURKw3DX9KvK6M8Gpj349ofo6J
        411CLXa/6QfM6HnHgEJPcZF0MsG2ezcjeAtHVRVPFmiwYtne3PbdtMtDcf/Fk2w5+EJn2p
        /oPdVtIFsFhHKepQTbmatqsH1863lvM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E6DC13909;
        Wed,  2 Aug 2023 10:02:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qA81McEpymQDeAAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 02 Aug 2023 10:02:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Subject: [PATCH v2 2/3] btrfs: exit gracefully if reloc roots don't match
Date:   Wed,  2 Aug 2023 18:02:20 +0800
Message-ID: <33e75a646274b3c844744dfec54c46ae89aa3d33.1690970028.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690970028.git.wqu@suse.com>
References: <cover.1690970028.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 9db2e6fa2cb2..32a8bdc08488 100644
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
+"reloc tree mismatch, root %lld has reloc root key (%lld, %u, %llu) gen %llu, expect reloc root key (%lld, %u, %llu) gen %llu",
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
+"reloc tree mismatch, root %lld has no reloc root, expect reloc root key (%lld, %u, %llu) gen %llu",
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
@@ -1998,17 +2029,14 @@ void merge_reloc_roots(struct reloc_control *rc)
 				 * memory.  However there's no reason we can't
 				 * handle the error properly here just in case.
 				 */
-				ASSERT(0);
 				ret = PTR_ERR(root);
 				goto out;
 			}
 			if (root->reloc_root != reloc_root) {
 				/*
-				 * This is actually impossible without something
-				 * going really wrong (like weird race condition
-				 * or cosmic rays).
+				 * This can happen if on-disk data has some
+				 * corruption, e.g. bad reloc tree key offset.
 				 */
-				ASSERT(0);
 				ret = -EINVAL;
 				goto out;
 			}
-- 
2.41.0

