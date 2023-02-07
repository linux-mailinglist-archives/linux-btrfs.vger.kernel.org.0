Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C6868CE25
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Feb 2023 05:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjBGE0q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 23:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjBGE0n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 23:26:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA0034C15
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Feb 2023 20:26:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EFB9D1F88B
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Feb 2023 04:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675743997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YDdrY9aLX5lsXi8JfPTOeyDxjJOZDEV/4ZVqqdOVDG0=;
        b=rHMOmcU5QG5+Zpu+qZ74t1MLPXuvqLNpu5kr+u+mnOncHdWR7IMNKdrW8mXAI7Bwqdq8nQ
        SlScxXDCVEJDNUY/g50Y/bJAkCNbySWJIftU48VmYQoCw9+Eq3s6d1z5p6FZbD9CDDLPyM
        LuoBvHh/EitMVfYZFabUL/15K+VMj64=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A2EB13A8C
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Feb 2023 04:26:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EJcsO/zS4WPeGgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Feb 2023 04:26:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/4] btrfs: small improvement for btrfs_io_context structure
Date:   Tue,  7 Feb 2023 12:26:13 +0800
Message-Id: <63c3c509ec42d83e8038b33e2f21e036c591fe0b.1675743217.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675743217.git.wqu@suse.com>
References: <cover.1675743217.git.wqu@suse.com>
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

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 16 ++++++++------
 fs/btrfs/volumes.h | 53 +++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b5a6262092d1..ebdb4261bf12 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5884,16 +5884,18 @@ static void sort_parity_stripes(struct btrfs_io_context *bioc, int num_stripes)
 }
 
 static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
-						       int total_stripes,
-						       int real_stripes)
+						       u16 total_stripes,
+						       u16 real_stripes)
 {
-	struct btrfs_io_context *bioc = kzalloc(
+	struct btrfs_io_context *bioc;
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
@@ -5907,7 +5909,7 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
 	refcount_set(&bioc->refs, 1);
 
 	bioc->fs_info = fs_info;
-	bioc->tgtdev_map = (int *)(bioc->stripes + total_stripes);
+	bioc->tgtdev_map = (u16 *)(bioc->stripes + total_stripes);
 	bioc->raid_map = (u64 *)(bioc->tgtdev_map + real_stripes);
 
 	return bioc;
@@ -6377,12 +6379,12 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	int mirror_num = (mirror_num_ret ? *mirror_num_ret : 0);
 	int num_stripes;
 	int max_errors = 0;
-	int tgtdev_indexes = 0;
 	struct btrfs_io_context *bioc = NULL;
 	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
 	int dev_replace_is_ongoing = 0;
-	int num_alloc_stripes;
 	int patch_the_first_stripe_for_dev_replace = 0;
+	u16 num_alloc_stripes;
+	u16 tgtdev_indexes = 0;
 	u64 physical_to_patch_in_first_stripe = 0;
 	u64 raid56_full_stripe_start = (u64)-1;
 	struct btrfs_io_geometry geom;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 46f33b66d85e..bf7e7c08d8f7 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -422,11 +422,54 @@ struct btrfs_io_context {
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

