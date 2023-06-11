Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA8C72AFBD
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jun 2023 02:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjFKAJf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Jun 2023 20:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFKAJe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Jun 2023 20:09:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0F12115
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Jun 2023 17:09:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 869F91F37F;
        Sun, 11 Jun 2023 00:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686442171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AaelC/FTx/tocOx1BDttpBO9gQ3uuVkxYeBai6xm2o0=;
        b=OJn9x+q4ZiZ/xEe0PEIS+TeHbi1RbsvT36HVSn1fNyLFknNeY9m6VgCP/xxydWaVdRUGus
        +cgyow3Q/os8e5qZC2CSWVE9fZwy7Wz14HTstrxYKE8iWbkuRakE8xGi7TXW9407P8Cybf
        05rytwDv/VQQFF2Q4drxFLBkfEN6koc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE13313345;
        Sun, 11 Jun 2023 00:09:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JhI1HroQhWRQVwAAMHmgww
        (envelope-from <wqu@suse.com>); Sun, 11 Jun 2023 00:09:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     syzbot+a694851c6ab28cbcfb9c@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: do not ASSERT() on duplicated global roots
Date:   Sun, 11 Jun 2023 08:09:13 +0800
Message-ID: <89dec0414ce198ef49d3014232bd1b88e3e74260.1686441969.git.wqu@suse.com>
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
Syzbot reports a reproducible ASSERT() when using rescue=usebackuproot
mount option on a corrupted fs.

The full report can be found here:
https://syzkaller.appspot.com/bug?extid=c4614eae20a166c25bf0

[CAUSE]
Since the introduction of global roots, we handle
csum/extent/free-space-tree roots as global roots, even if no
extent-tree-v2 feature is enabled.

So for regular csum/extent/fst roots, we load them into
fs_info::global_root_tree rb tree.

And we should not expect any conflicts in that rb tree, thus we have an
ASSERT() inside btrfs_global_root_insert().

But rescue=usebackuproot can break the assumption, as we will try to
load those trees again and again as long as we have bad roots and have
backup roots slot remaining.

So in that case we can have conflicting roots in the rb tree, and
triggering the ASSERT() crash.

[FIX]
We can safely remove that ASSERT(), as the caller will properly put the
offending root.

To make further debugging easier, also add two explicit error messages:

- Error message for conflicting global roots
- Error message when using backup roots slot

Reported-by: syzbot+a694851c6ab28cbcfb9c@syzkaller.appspotmail.com
Fixes: abed4aaae4f7 ("btrfs: track the csum, extent, and free space trees in a rb tree")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1168e5df8bae..7f201975a303 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -748,13 +748,18 @@ int btrfs_global_root_insert(struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct rb_node *tmp;
+	int ret = 0;
 
 	write_lock(&fs_info->global_root_lock);
 	tmp = rb_find_add(&root->rb_node, &fs_info->global_root_tree, global_root_cmp);
 	write_unlock(&fs_info->global_root_lock);
-	ASSERT(!tmp);
 
-	return tmp ? -EEXIST : 0;
+	if (tmp) {
+		ret = -EEXIST;
+		btrfs_warn(fs_info, "global root %lld %llu already exists",
+				root->root_key.objectid, root->root_key.offset);
+	}
+	return ret;
 }
 
 void btrfs_global_root_delete(struct btrfs_root *root)
@@ -2591,6 +2596,7 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 			/* We can't trust the free space cache either */
 			btrfs_set_opt(fs_info->mount_opt, CLEAR_CACHE);
 
+			btrfs_warn(fs_info, "try to load backup roots slot %u", i);
 			ret = read_backup_root(fs_info, i);
 			backup_index = ret;
 			if (ret < 0)
-- 
2.41.0

