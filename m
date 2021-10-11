Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B306428A95
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 12:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbhJKKM0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 06:12:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58996 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbhJKKMW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 06:12:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1681722077;
        Mon, 11 Oct 2021 10:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633947022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b1L5C80yLs/hTP/RxXhY7+g90Tc0zZ82NE3J40/Nay0=;
        b=EfEhixcSatjYDvQyxRemSVxqAMLmvwGVwLfqqJCqT8VrHnUHcQIn6ufSDHWROQm4ojH98d
        mn7l1NXN6d9oVQaofCZcA7kAUJuFWJgPF3Uom8Wpyx+HVNOjJkLTw0rZjhxmOrfVUcjW/b
        dT/rNvXiT3zfs7L5U195h4c68rHvUcg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9DF713C4C;
        Mon, 11 Oct 2021 10:10:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KCudMo0NZGGJLwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 11 Oct 2021 10:10:21 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 5/5] btrfs: make real_root optional
Date:   Mon, 11 Oct 2021 13:10:19 +0300
Message-Id: <20211011101019.1409855-6-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011101019.1409855-1-nborisov@suse.com>
References: <20211011101019.1409855-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that real_root is only used in ref-verify core gate it behind
CONFIG_BTRFS_FS_REF_VERIFY ifdef. This shrinks the size of pending
delayed refs by 8 bytes per ref, of which we can have many at any one
time depending on intensity of the workload. Also change the comment
about the member as it no longer deals with qgroups.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/delayed-ref.h | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 6bb299c66e1e..ddc82caf7b82 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -231,17 +231,10 @@ struct btrfs_ref {
 	 */
 	bool skip_qgroup;
 
-	/*
-	 * Optional. For which root is this modification.
-	 * Mostly used for qgroup optimization.
-	 *
-	 * When unset, data/tree ref init code will populate it.
-	 * In certain cases, we're modifying reference for a different root.
-	 * E.g. COW fs tree blocks for balance.
-	 * In that case, tree_ref::root will be fs tree, but we're doing this
-	 * for reloc tree, then we should set @real_root to reloc tree.
-	 */
+#ifdef CONFIG_BTRFS_FS_REF_VERIFY
+	/* Through which root is this modification. */
 	u64 real_root;
+#endif
 	u64 bytenr;
 	u64 len;
 
@@ -273,9 +266,10 @@ static inline void btrfs_init_generic_ref(struct btrfs_ref *generic_ref,
 static inline void btrfs_init_tree_ref(struct btrfs_ref *generic_ref,
 				int level, u64 root, u64 mod_root, bool skip_qgroup)
 {
+#ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	/* If @real_root not set, use @root as fallback */
-	if (!generic_ref->real_root)
-		generic_ref->real_root = root;
+	generic_ref->real_root = mod_root ? mod_root : root;
+#endif
 	generic_ref->tree_ref.level = level;
 	generic_ref->tree_ref.owning_root = root;
 	generic_ref->type = BTRFS_REF_METADATA;
@@ -287,9 +281,10 @@ static inline void btrfs_init_data_ref(struct btrfs_ref *generic_ref,
 				u64 ref_root, u64 ino, u64 offset, u64 mod_root,
 				bool skip_qgroup)
 {
+#ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	/* If @real_root not set, use @root as fallback */
-	if (!generic_ref->real_root)
-		generic_ref->real_root = ref_root;
+	generic_ref->real_root = mod_root ? mod_root : ref_root;
+#endif
 	generic_ref->data_ref.owning_root = ref_root;
 	generic_ref->data_ref.ino = ino;
 	generic_ref->data_ref.offset = offset;
-- 
2.25.1

