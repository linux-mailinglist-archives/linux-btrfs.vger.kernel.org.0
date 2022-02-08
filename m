Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2E14AD1A1
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Feb 2022 07:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347575AbiBHGgo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 01:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347556AbiBHGgk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 01:36:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01869C0401F1
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Feb 2022 22:36:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B0BA61F37C
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 06:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644302198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uhYqpjP8KOKAdfgCtWhcYQlK9X14QQ1Zca75IflfJRo=;
        b=J75pzyLneKbVb0G9wCwFH/b+utK/q08UgrGQ54TuwO3ImZGTe+EE5DDSzGq5AQc+Ec/lFl
        bTZ0vg39MOlLEhtkRo56fatZVLUYvBB6U3Zgq3XQyEZK7oNFsn03pzDrHdo7ap1QDuqMjr
        +i/SXEJeKkPQb7QdjsxsGMAsmzlDC9s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 054D713310
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 06:36:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8A3mL3UPAmIlFQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Feb 2022 06:36:37 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: defrag: don't use merged extent map for their generation check
Date:   Tue,  8 Feb 2022 14:36:31 +0800
Message-Id: <fe880742bbee1e1c219c7b468300724a3336107d.1644301903.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <cover.1644301903.git.wqu@suse.com>
References: <cover.1644301903.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For extent maps, if they are not compressed extents and are adjacent by
logical addresses and file offsets, they can be merged into one larger
extent map.

Such merged extent map will have the higher generation of all the
original ones.

This behavior won't affect fsync code, as only extents read from disks
can be merged.

But this brings a problem for autodefrag, as it relies on accurate
extent_map::generation to determine if one extent should be defragged.

For merged extent maps, their higher generation can mark some older
extents to be defragged while the original extent map doesn't meet the
minimal generation threshold.

Thus this will cause extra IO.

So solve the problem, here we introduce a new flag, EXTENT_FLAG_MERGED, to
indicate if the extent map is merged from one or more ems.

And for autodefrag, if we find a merged extent map, and its generation
meets the generation requirement, we just don't use this one, and go
back to defrag_get_extent() to read em from disk.

This could cause more read IO, but should result less defrag data write,
so in the long run it should be a win for autodefrag.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_map.c |  2 ++
 fs/btrfs/extent_map.h |  8 ++++++++
 fs/btrfs/ioctl.c      | 14 ++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 5a36add21305..c28ceddefae4 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -261,6 +261,7 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 			em->mod_len = (em->mod_len + em->mod_start) - merge->mod_start;
 			em->mod_start = merge->mod_start;
 			em->generation = max(em->generation, merge->generation);
+			set_bit(EXTENT_FLAG_MERGED, &em->flags);
 
 			rb_erase_cached(&merge->rb_node, &tree->map);
 			RB_CLEAR_NODE(&merge->rb_node);
@@ -278,6 +279,7 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 		RB_CLEAR_NODE(&merge->rb_node);
 		em->mod_len = (merge->mod_start + merge->mod_len) - em->mod_start;
 		em->generation = max(em->generation, merge->generation);
+		set_bit(EXTENT_FLAG_MERGED, &em->flags);
 		free_extent_map(merge);
 	}
 }
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 8e217337dff9..d2fa32ffe304 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -25,6 +25,8 @@ enum {
 	EXTENT_FLAG_FILLING,
 	/* filesystem extent mapping type */
 	EXTENT_FLAG_FS_MAPPING,
+	/* This em is merged from two or more physically adjacent ems */
+	EXTENT_FLAG_MERGED,
 };
 
 struct extent_map {
@@ -40,6 +42,12 @@ struct extent_map {
 	u64 ram_bytes;
 	u64 block_start;
 	u64 block_len;
+
+	/*
+	 * Generation of the extent map, for merged em it's the highest
+	 * generation of all merged ems.
+	 * For non-merged extents, it's from btrfs_file_extent_item::generation.
+	 */
 	u64 generation;
 	unsigned long flags;
 	/* Used for chunk mappings, flag EXTENT_FLAG_FS_MAPPING must be set */
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index fb4c25e5ff5f..3a5ada561298 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1169,6 +1169,20 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 	em = lookup_extent_mapping(em_tree, start, sectorsize);
 	read_unlock(&em_tree->lock);
 
+	/*
+	 * We can get a merged extent, in that case, we need to re-search
+	 * tree to get the original em for defrag.
+	 *
+	 * If @newer_than is 0 or em::geneartion < newer_than, we can trust
+	 * this em, as either we don't care about the geneartion, or the
+	 * merged extent map will be rejected anyway.
+	 */
+	if (em && test_bit(EXTENT_FLAG_MERGED, &em->flags) &&
+	    newer_than && em->generation >= newer_than) {
+		free_extent_map(em);
+		em = NULL;
+	}
+
 	if (!em) {
 		struct extent_state *cached = NULL;
 		u64 end = start + sectorsize - 1;
-- 
2.35.0

