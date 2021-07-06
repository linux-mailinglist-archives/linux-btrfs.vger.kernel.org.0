Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F196D3BDCCE
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jul 2021 20:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhGFSP7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jul 2021 14:15:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58848 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhGFSP7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jul 2021 14:15:59 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 862941FFB1;
        Tue,  6 Jul 2021 18:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625595199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=85RVnRsdKahf3YRXyEiKk9Ekx1RRvS2ns8Ls2cE1eEw=;
        b=kf552dWln+zzxynrQ6KAUVt4CE34HITj1FVmQR4amX1NLZwK7XD99eOC4boTKEUIvzYMV1
        9nzZK3qzJGTavYW9rtLkDML4n2uxYW1DRsTX4JvZYYtrUenPU8I/nHeqN2c+WPJhfRHB4/
        h0PgaGIQx7mDqQ0gwmD013YEQfZywt0=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6820313668;
        Tue,  6 Jul 2021 18:13:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id rBkIDD6d5GDGdQAAGKfGzw
        (envelope-from <mpdesouza@suse.com>); Tue, 06 Jul 2021 18:13:18 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs: ctree: Remove max argument from generic_bin_search
Date:   Tue,  6 Jul 2021 15:13:25 -0300
Message-Id: <20210706181325.6749-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Both callers use btrfs_header_nritems to feed the max argument.
Remove the argument and let generic_bin_search call it itself.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/ctree.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index c5c08c87e130..394fec1d3fd9 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -726,22 +726,22 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 
 /*
  * search for key in the extent_buffer.  The items start at offset p,
- * and they are item_size apart.  There are 'max' items in p.
+ * and they are item_size apart.
  *
  * the slot in the array is returned via slot, and it points to
  * the place where you would insert key if it is not found in
  * the array.
  *
- * slot may point to max if the key is bigger than all of the keys
+ * slot may point to total number of items if the key is bigger than
+ * all of the keys
  */
 static noinline int generic_bin_search(struct extent_buffer *eb,
 				       unsigned long p, int item_size,
-				       const struct btrfs_key *key,
-				       int max, int *slot)
+				       const struct btrfs_key *key, int *slot)
 {
-	int low = 0;
-	int high = max;
 	int ret;
+	int low = 0;
+	int high = btrfs_header_nritems(eb);
 	const int key_size = sizeof(struct btrfs_disk_key);
 
 	if (low > high) {
@@ -800,14 +800,12 @@ int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
 		return generic_bin_search(eb,
 					  offsetof(struct btrfs_leaf, items),
 					  sizeof(struct btrfs_item),
-					  key, btrfs_header_nritems(eb),
-					  slot);
+					  key, slot);
 	else
 		return generic_bin_search(eb,
 					  offsetof(struct btrfs_node, ptrs),
 					  sizeof(struct btrfs_key_ptr),
-					  key, btrfs_header_nritems(eb),
-					  slot);
+					  key, slot);
 }
 
 static void root_add_used(struct btrfs_root *root, u32 size)
-- 
2.26.2

