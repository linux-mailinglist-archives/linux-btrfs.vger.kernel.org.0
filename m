Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9052768B69
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 07:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjGaFxW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 01:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjGaFxV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 01:53:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ED5130
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Jul 2023 22:53:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6EEA7223D4;
        Mon, 31 Jul 2023 05:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690782795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=vcjGzlLMXs5VZSOc4MsivWKDSPY+I8RAfxwdWd7EZk4=;
        b=KUrmcZV/hU52cORZN+q5nJfr7UNWhuehta6OAHbEOK3fbzo1v6P/JpenJKGlRnqIVXXo7K
        IFLRdXGTOlcXlpxeauRHcsgpOc52J6xal143T+bfpuViMcj0Xp7mHvP6upKJTyqjl4M1+d
        gvBTSLi1e2XwJvQA12e9q0EwxAQg3uc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 912CF13274;
        Mon, 31 Jul 2023 05:53:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P5HNFkpMx2SGVgAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 31 Jul 2023 05:53:14 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: exit gracefully if reloc roots don't match
Date:   Mon, 31 Jul 2023 13:52:57 +0800
Message-ID: <24881cc9caf738f6248232709d7357d3186773b5.1690782754.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Syzbot reported a crash that an ASSERT() got triggered inside
prepare_to_merge().

[CAUSE]
Although I failed to reproduce the bug, the ASSERT() there is not that
helpful for developers.

Normally ASSERT() should be used to do obvious sanity check so
developers can get a very quick failure if their code has some very
wrong assumption.

For this particular case, although the check itself is meaningful, it's
very hard to know why such problem happened.

Such mismatch can be caused at a very early stage (e.g. on-disk data
mismatch) thus it's very hard to debug just using that ASSERT().

[ENHANCEMENT]
Instead of using an ASSERT(), let's handle it gracefully and output
extra info about the mismatch reloc roots to help debug.

Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 9db2e6fa2cb2..f7caaa13737c 100644
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
-- 
2.41.0

