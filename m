Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F311D4D9202
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 02:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbiCOBJX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 21:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbiCOBJW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 21:09:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E802E10FFF
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 18:08:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9DF861F37E
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 01:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647306490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=20+puWsWq5RqpJW9u5eZg2yFBeJNKkKprLOc5JnOMQM=;
        b=COe4KE1tucHX/XPKyHZHXlqTSTw1JPB27e+VsDCeTdyzwRAlZRfux4JiE5h8phJNw1kRoq
        YxzktvI9rZelwQv09Q2YJX9f/sFtuUh6qr71DzNUfd6cGfoeeKpMdPNicqKrJwMaG5vp+v
        HKPeG6Fqd8JNMMUuQ3/h5ZITwOaTVWQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0031213ADA
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 01:08:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kx0xL/nmL2JSWwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 01:08:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: avoid defragging extents whose next extents are not targets
Date:   Tue, 15 Mar 2022 09:07:52 +0800
Message-Id: <795e3dee8c4789f845e5e14bfc02c992b86fa2d9.1647306224.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
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
There is a report that autodefrag is defragging single sector, which
is completely waste of IO, and no help for defragging:

   btrfs-cleaner-808     defrag_one_locked_range: root=256 ino=651122 start=0 len=4096

[CAUSE]
In defrag_collect_targets(), we check if the current range (A) can be merged
with next one (B).

If mergeable, we will add range A into target for defrag.

However there is a catch for autodefrag, when checking mergebility against
range B, we intentionally pass 0 as @newer_than, hoping to get a
higher chance to merge with the next extent.

But in next iteartion, range B will looked up by defrag_lookup_extent(),
with non-zero @newer_than.

And if range B is not really newer, it will rejected directly, causing
only range A being defragged, while we expect to defrag both range A and
B.

[FIX]
Since the root cause is the difference in check condition of
defrag_check_next_extent() and defrag_collect_targets(), we fix it by:

1. Pass @newer_than to defrag_check_next_extent()
2. Pass @extent_thresh to defrag_check_next_extent()

This makes the check between defrag_collect_targets() and
defrag_check_next_extent() more consistent.

While there is still some minor difference, the remaining checks are
focus on runtime flags like writeback/delalloc, which are mostly
transient and safe to be checked only in defrag_collect_targets().

Issue: 423#issuecomment-1066981856
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 3d3d6e2f110a..7d7520a2e281 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1189,7 +1189,7 @@ static u32 get_extent_max_capacity(const struct extent_map *em)
 }
 
 static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
-				     bool locked)
+				     u32 extent_thresh, u64 newer_than, bool locked)
 {
 	struct extent_map *next;
 	bool ret = false;
@@ -1199,11 +1199,13 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 		return false;
 
 	/*
-	 * We want to check if the next extent can be merged with the current
-	 * one, which can be an extent created in a past generation, so we pass
-	 * a minimum generation of 0 to defrag_lookup_extent().
+	 * Here we need to pass @newer_then when checking the next extent, or
+	 * we will hit a case we mark current extent for defrag, but the next
+	 * one will not be a target.
+	 * This will just cause extra IO without really reducing the fragments.
 	 */
-	next = defrag_lookup_extent(inode, em->start + em->len, 0, locked);
+	next = defrag_lookup_extent(inode, em->start + em->len, newer_than,
+				    locked);
 	/* No more em or hole */
 	if (!next || next->block_start >= EXTENT_MAP_LAST_BYTE)
 		goto out;
@@ -1215,6 +1217,13 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 	 */
 	if (next->len >= get_extent_max_capacity(em))
 		goto out;
+	/* Skip older extent */
+	if (next->generation < newer_than)
+		goto out;
+	/* Also check extent size */
+	if (next->len >= extent_thresh)
+		goto out;
+
 	ret = true;
 out:
 	free_extent_map(next);
@@ -1420,7 +1429,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 			goto next;
 
 		next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,
-							  locked);
+						extent_thresh, newer_than, locked);
 		if (!next_mergeable) {
 			struct defrag_target_range *last;
 
-- 
2.35.1

