Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6CE76CA4E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 12:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbjHBKES (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 06:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbjHBKEB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 06:04:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBB244BF
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 03:02:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DA66021A68;
        Wed,  2 Aug 2023 10:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690970564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gqT2obx/FX1ParH1h9GTD0W7exb8Oner/jqPOR8djAI=;
        b=HglaKASkbP22higEp7wOQdPOlcV2dnADt4jgquKyjC265j58pG9d/Fgm2dEPxoz6goh9MG
        Q7qO34bAJ7CehGxK+r2Hqwxd1iEwuWgQmeytM9sv/O14P3vVP04l9sw/x7GKq6mqK5eUcZ
        sV5tP2xx6E6kUkLKh3cnjFtkSWcOzkQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E479713909;
        Wed,  2 Aug 2023 10:02:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MCPiKcMpymQDeAAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 02 Aug 2023 10:02:43 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Subject: [PATCH v2 3/3] btrfs: reject invalid reloc tree root keys with stack dump
Date:   Wed,  2 Aug 2023 18:02:21 +0800
Message-ID: <a15ff1e397312309c554482e55d929488e22dcca.1690970028.git.wqu@suse.com>
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

That ASSERT() makes sure the reloc tree is properly pointed back by its
subvolume tree.

[CAUSE]
After more debugging output, it turns out we had an invalid reloc tree:

 BTRFS error (device loop1): reloc tree mismatch, root 8 has no reloc root, expect reloc root key (-8, 132, 8) gen 17

Note the above root key is (TREE_RELOC_OBJECTID, ROOT_ITEM,
QUOTA_TREE_OBJECTID), meaning it's a reloc tree for quota tree.

But reloc trees can only exist for subvolumes, as for non-subvolume
trees, we just COW the involved tree block, no need to create a reloc
tree since those tree blocks won't be shared with other trees.

Only subvolumes tree can share tree blocks with other trees (thus they
have BTRFS_ROOT_SHAREABLE flag).

Thus this new debug output proves my previous assumption that corrupted
on-disk data can trigger that ASSERT().

[FIX]
Besides the dedicated fix and the graceful exit, also let tree-checker to
check such root keys, to make sure reloc trees can only exist for
subvolumes.

Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c      |  3 ++-
 fs/btrfs/tree-checker.c | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5fd336c597e9..a01eac963075 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1103,7 +1103,8 @@ static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
 	btrfs_drew_lock_init(&root->snapshot_lock);
 
 	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID &&
-	    !btrfs_is_data_reloc_root(root)) {
+	    !btrfs_is_data_reloc_root(root) &&
+	    is_fstree(root->root_key.objectid)) {
 		set_bit(BTRFS_ROOT_SHAREABLE, &root->state);
 		btrfs_check_and_init_root_item(&root->root_item);
 	}
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 038dfa8f1788..dabb86314a4c 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -446,6 +446,21 @@ static int check_root_key(struct extent_buffer *leaf, struct btrfs_key *key,
 	btrfs_item_key_to_cpu(leaf, &item_key, slot);
 	is_root_item = (item_key.type == BTRFS_ROOT_ITEM_KEY);
 
+	/*
+	 * Bad rootid for reloc trees.
+	 *
+	 * Reloc trees are only for subvolume trees, other trees only needs
+	 * a COW to be relocated.
+	 */
+	if (unlikely(is_root_item && key->objectid == BTRFS_TREE_RELOC_OBJECTID &&
+		     !is_fstree(key->offset))) {
+		generic_err(leaf, slot,
+	"invalid reloc tree for root %lld, root id is not a subvolume tree",
+			    key->offset);
+		dump_stack();
+		return -EUCLEAN;
+	}
+
 	/* No such tree id */
 	if (unlikely(key->objectid == 0)) {
 		if (is_root_item)
-- 
2.41.0

