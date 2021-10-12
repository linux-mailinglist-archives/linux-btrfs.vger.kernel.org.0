Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EF5429FAF
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 10:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbhJLIXq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 04:23:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47294 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbhJLIXm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 04:23:42 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 49D222018D;
        Tue, 12 Oct 2021 08:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634026900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T7g0VZxszWomh4TBBnbDan5aXPvRk2PI1pMZzqMGI4s=;
        b=cI9WIuyUSsUHRShjWICXhXPPJA5TYmzuXQDkB3Qsp7CrLJafY40IhZ7MsFNGeQREoKOG2X
        smOcUHauIMkoxeGimyhkQDq5TFShLRN2UZPgH+lY2SpKtq8CARRLbk+n6wI3eX+DF6Zf0L
        kO5cYMhalXtq4aqQAW1v0isGsguGpf0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B10B13AD5;
        Tue, 12 Oct 2021 08:21:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WE0zBJRFZWGkRgAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 12 Oct 2021 08:21:40 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 5/5] btrfs: make real_root optional
Date:   Tue, 12 Oct 2021 11:21:37 +0300
Message-Id: <20211012082137.1476078-6-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012082137.1476078-1-nborisov@suse.com>
References: <20211012082137.1476078-1-nborisov@suse.com>
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
index 79ad5f11ae02..8abe8d595404 100644
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
+	generic_ref->real_root = mod_root ?: root;
+#endif
 	generic_ref->tree_ref.level = level;
 	generic_ref->tree_ref.owning_root = root;
 	generic_ref->type = BTRFS_REF_METADATA;
@@ -291,9 +285,10 @@ static inline void btrfs_init_data_ref(struct btrfs_ref *generic_ref,
 				u64 ref_root, u64 ino, u64 offset, u64 mod_root,
 				bool skip_qgroup)
 {
+#ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	/* If @real_root not set, use @root as fallback */
-	if (!generic_ref->real_root)
-		generic_ref->real_root = ref_root;
+	generic_ref->real_root = mod_root ?: ref_root;
+#endif
 	generic_ref->data_ref.owning_root = ref_root;
 	generic_ref->data_ref.ino = ino;
 	generic_ref->data_ref.offset = offset;
-- 
2.25.1

