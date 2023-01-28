Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722B867F63E
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Jan 2023 09:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjA1IXl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Jan 2023 03:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjA1IXj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Jan 2023 03:23:39 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5F41D905
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Jan 2023 00:23:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8BCC12227F
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Jan 2023 08:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674894216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y7nFFoYO36pGs98gEB+SRdL78i5FcbLYv+sbE2UvTfM=;
        b=fbD07FA5EcymtDpPkaE3kgECzrITOt1bJB9heCdMJpM9BxyFHPfxfMZ6rwjUhbbJDyWlIi
        s3mMM+Z273BLmRv0ej/ylzXdyAXe5ffMaNfRm1y4Orep1Bnjeuuw2sBdXKAwJo3UYbfmO3
        /prQVUG3Dp4+fl0FGZUfqpwudf+UTvA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DFFBA139BD
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Jan 2023 08:23:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oBi+KYfb1GPqGwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Jan 2023 08:23:35 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: small improvement for btrfs_io_context structure
Date:   Sat, 28 Jan 2023 16:23:15 +0800
Message-Id: <a02fc8daecc6973fc928501c4bc2554062ff43e7.1674893735.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674893735.git.wqu@suse.com>
References: <cover.1674893735.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

That structure is our ultimate objective for all __btrfs_map_block()
related functions.

We have some hard to understand members, like tgtdev_map, but without
any comments.

This patch will improve the situation by:

- Add extra comments for num_stripes, mirror_num, num_tgtdevs and
  tgtdev_map[]
  Especially for the last two members, add a dedicated (thus very long)
  comments for them, with example to explain it.

- Shrink those int members to u16.
  In fact our on-disk format is only using u16 for num_stripes, thus
  no need to go int at all.

- Add extra ASSERT() for alloc_btrfs_io_context() for the stripes
  argument

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 15 ++++++++++---
 fs/btrfs/volumes.h | 53 +++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 66d44167f7b1..f00716fbb6cd 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5888,13 +5888,22 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
 						       int total_stripes,
 						       int real_stripes)
 {
-	struct btrfs_io_context *bioc = kzalloc(
+	struct btrfs_io_context *bioc;
+
+	/*
+	 * We should have valid number of stripes, larger than U16_MAX(65535)
+	 * indicates something totally wrong, as our on-disk format is only
+	 * at u16.
+	 */
+	ASSERT(total_stripes < U16_MAX && total_stripes > 0);
+
+	bioc = kzalloc(
 		 /* The size of btrfs_io_context */
 		sizeof(struct btrfs_io_context) +
 		/* Plus the variable array for the stripes */
 		sizeof(struct btrfs_io_stripe) * (total_stripes) +
 		/* Plus the variable array for the tgt dev */
-		sizeof(int) * (real_stripes) +
+		sizeof(u16) * (real_stripes) +
 		/*
 		 * Plus the raid_map, which includes both the tgt dev
 		 * and the stripes.
@@ -5908,7 +5917,7 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
 	refcount_set(&bioc->refs, 1);
 
 	bioc->fs_info = fs_info;
-	bioc->tgtdev_map = (int *)(bioc->stripes + total_stripes);
+	bioc->tgtdev_map = (u16 *)(bioc->stripes + total_stripes);
 	bioc->raid_map = (u64 *)(bioc->tgtdev_map + real_stripes);
 
 	return bioc;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 6b7a05f6cf82..fe664512191b 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -419,11 +419,54 @@ struct btrfs_io_context {
 	u64 map_type; /* get from map_lookup->type */
 	struct bio *orig_bio;
 	atomic_t error;
-	int max_errors;
-	int num_stripes;
-	int mirror_num;
-	int num_tgtdevs;
-	int *tgtdev_map;
+	u16 max_errors;
+
+	/*
+	 * The total number of stripes, including the extra duplicated
+	 * stripe for replace.
+	 */
+	u16 num_stripes;
+
+	/*
+	 * The mirror_num of this bioc.
+	 *
+	 * This is for reads which uses 0 as mirror_num, thus we should
+	 * return a valid mirror_num (>0) for the reader.
+	 */
+	u16 mirror_num;
+
+	/*
+	 * The following two members are for dev-replace case only.
+	 *
+	 * @num_tgtdevs:	Number of duplicated stripes which needs to be
+	 *			written to replace target.
+	 *			Should be <= 2 (2 for DUP, otherwise <= 1).
+	 * @tgtdev_map:		The array indicates where the duplicated stripes
+	 *			are from. The size is the number of original
+	 *			stripes (num_stripes - num_tgtdevs).
+	 *
+	 * The @tgtdev_map[] array is mostly for RAID56 cases.
+	 * As non-RAID56 stripes share the same contents for the mapped range,
+	 * thus no need to bother where the duplicated ones are from.
+	 *
+	 * But for RAID56 case, all stripes contain different contents, thus
+	 * must need a way to know the mapping.
+	 *
+	 * There is an example for the two members, using a RAID5 write:
+	 * num_stripes:		4 (3 + 1 duplicated write)
+	 * stripes[0]:		dev = devid 1, physical = X
+	 * stripes[1]:		dev = devid 2, physical = Y
+	 * stripes[2]:		dev = devid 3, physical = Z
+	 * stripes[3]:		dev = devid 0, physical = Y
+	 *
+	 * num_tgtdevs = 1
+	 * tgtdev_map[0] = 0	<- Means stripes[0] is not involved in replace.
+	 * tgtdev_map[1] = 3	<- Means stripes[1] is involved in replace,
+	 *			   and it's duplicated to stripes[3].
+	 * tgtdev_map[2] = 0	<- Means stripes[2] is not involved in replace.
+	 */
+	u16 num_tgtdevs;
+	u16 *tgtdev_map;
 	/*
 	 * logical block numbers for the start of each stripe
 	 * The last one or two are p/q.  These are sorted,
-- 
2.39.1

