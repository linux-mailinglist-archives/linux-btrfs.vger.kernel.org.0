Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1589B6E83A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjDSVZW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjDSVZH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:25:07 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C230483C3
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:37 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id qf26so1047032qvb.6
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939475; x=1684531475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RcwIUXAM7suyt7Kjbk24uDH/3G+6OPD6fk/698QuRvk=;
        b=tDLy1i9tTirksm2IuPChHXM2/tpmNuzDrKMHgHMkVOHd/llBZELcYQkx9INuzOm3mL
         43OimeWL3KYcPhycyiO2LphkoxvKuRat7WlA43kBhwxjU8QgdTVHfoOv3CvcBJiyLivy
         qJ771vqDJJqRRaBR2W7tihZ93t/xaB9F+jqvASFFMB8S0nfFC9LhZFDdiIZ7tD49LsRc
         jd8TRkzW13v0qYj6T3eosNOru5bxhDe1sZxly6NcxsxvaUAIsh3xFWHG7PPB1xr2+hec
         Vew9qsqKOtFMB2+oyuEW5dl/SOD2YzJ2Gp1gD6K/KVNhs8RVPe6GOcPd6419aXHmlZ1l
         rxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939475; x=1684531475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcwIUXAM7suyt7Kjbk24uDH/3G+6OPD6fk/698QuRvk=;
        b=D4cxVPpAlg7A+vXkBL4O1q8XWYfyTJl5/IqGGE0K2dHxJC4e45A4dqqoA5CexUubLY
         9z8434w87rdj31xDDykBzWx+UQdnsISIo8DI5udzfVFCzyq33/biI1B/aC0oGcc5kLPJ
         Ic8XjRa5FDWOBjcj7RcwDvRLw/4DZP4pzQkDqZqaMHGOs9Klc1E7x5QYdRhSkp3K8axO
         iNnqCNJAxBo3bXRwT/ncheUNlfg9svlAQys1LOwLFHwyC9I6Y5gkG8SqD8mzvpJYoAwO
         Ab5v6OPzNBirJW1oL03E5nGhbo4fbLfkpuNTXyF0SnTjSUtyPVh1TA+rFZyC78fAm14H
         4bug==
X-Gm-Message-State: AAQBX9fgQuTzzNlFKotP/lxk+d7BrrF9iWnzmtYI1SjUhszWvoEKMHZH
        N4nGwFQPghEv32HRAc+FHLCzmkdXGG0TlWI87cz1+g==
X-Google-Smtp-Source: AKy350ZAPOeshyaOWro5Wl9rphaHpp2bhsrnlCKoviJpD0GojJy/Kyk4vKJW7ZkjV89IlRCsX4+IzQ==
X-Received: by 2002:a05:6214:c8a:b0:5cb:ab2e:b15c with SMTP id r10-20020a0562140c8a00b005cbab2eb15cmr21499702qvr.30.1681939475163;
        Wed, 19 Apr 2023 14:24:35 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id i10-20020a0cab4a000000b005e5afa59f3dsm6000qvb.39.2023.04.19.14.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:24:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 17/18] btrfs-progs: change btrfs_check_chunk_valid to match the kernel version
Date:   Wed, 19 Apr 2023 17:24:08 -0400
Message-Id: <48c1bbd15ec096a559a5bd52dfc2d95d816919da.1681939316.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939316.git.josef@toxicpanda.com>
References: <cover.1681939316.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs-progs we check the actual leaf pointers as well as the chunk
itself in btrfs_check_chunk_valid.  However in the kernel the leaf stuff
is handled separately as part of the read, and then we have the chunk
checker itself.  Change the btrfs-progs version to match the in-kernel
version temporarily so it makes syncing the in-kernel code easier.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c            |  3 +--
 check/mode-lowmem.c     |  6 ++----
 kernel-shared/volumes.c | 46 ++++-------------------------------------
 kernel-shared/volumes.h |  6 ++----
 4 files changed, 9 insertions(+), 52 deletions(-)

diff --git a/check/main.c b/check/main.c
index f15272bf..f9055f7a 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5329,8 +5329,7 @@ static int process_chunk_item(struct cache_tree *chunk_cache,
 	 * wrong onwer(3) out of chunk tree, to pass both chunk tree check
 	 * and owner<->key_type check.
 	 */
-	ret = btrfs_check_chunk_valid(gfs_info, eb, chunk, slot,
-				      key->offset);
+	ret = btrfs_check_chunk_valid(eb, chunk, key->offset);
 	if (ret < 0) {
 		error("chunk(%llu, %llu) is not valid, ignore it",
 		      key->offset, btrfs_chunk_length(eb, chunk));
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index fb294c90..7a57f99a 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -4470,8 +4470,7 @@ static int check_dev_extent_item(struct extent_buffer *eb, int slot)
 
 	l = path.nodes[0];
 	chunk = btrfs_item_ptr(l, path.slots[0], struct btrfs_chunk);
-	ret = btrfs_check_chunk_valid(gfs_info, l, chunk, path.slots[0],
-				      chunk_key.offset);
+	ret = btrfs_check_chunk_valid(l, chunk, chunk_key.offset);
 	if (ret < 0)
 		goto out;
 
@@ -4702,8 +4701,7 @@ static int check_chunk_item(struct extent_buffer *eb, int slot)
 	chunk = btrfs_item_ptr(eb, slot, struct btrfs_chunk);
 	length = btrfs_chunk_length(eb, chunk);
 	chunk_end = chunk_key.offset + length;
-	ret = btrfs_check_chunk_valid(gfs_info, eb, chunk, slot,
-				      chunk_key.offset);
+	ret = btrfs_check_chunk_valid(eb, chunk, chunk_key.offset);
 	if (ret < 0) {
 		error("chunk[%llu %llu) is invalid", chunk_key.offset,
 			chunk_end);
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 1e2c8895..14fcefee 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -2090,33 +2090,19 @@ static struct btrfs_device *fill_missing_device(u64 devid)
  * slot == -1: SYSTEM chunk
  * return -EIO on error, otherwise return 0
  */
-int btrfs_check_chunk_valid(struct btrfs_fs_info *fs_info,
-			    struct extent_buffer *leaf,
-			    struct btrfs_chunk *chunk,
-			    int slot, u64 logical)
+int btrfs_check_chunk_valid(struct extent_buffer *leaf,
+			    struct btrfs_chunk *chunk, u64 logical)
 {
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	u64 length;
 	u64 stripe_len;
 	u16 num_stripes;
 	u16 sub_stripes;
 	u64 type;
-	u32 chunk_ondisk_size;
 	u32 sectorsize = fs_info->sectorsize;
 	int min_devs;
 	int table_sub_stripes;
 
-	/*
-	 * Basic chunk item size check.  Note that btrfs_chunk already contains
-	 * one stripe, so no "==" check.
-	 */
-	if (slot >= 0 &&
-	    btrfs_item_size(leaf, slot) < sizeof(struct btrfs_chunk)) {
-		error("invalid chunk item size, have %u expect [%zu, %u)",
-			btrfs_item_size(leaf, slot),
-			sizeof(struct btrfs_chunk),
-			BTRFS_LEAF_DATA_SIZE(fs_info));
-		return -EUCLEAN;
-	}
 	length = btrfs_chunk_length(leaf, chunk);
 	stripe_len = btrfs_chunk_stripe_len(leaf, chunk);
 	num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
@@ -2128,13 +2114,6 @@ int btrfs_check_chunk_valid(struct btrfs_fs_info *fs_info,
 			num_stripes);
 		return -EUCLEAN;
 	}
-	if (slot >= 0 && btrfs_chunk_item_size(num_stripes) !=
-	    btrfs_item_size(leaf, slot)) {
-		error("invalid chunk item size, have %u expect %lu",
-			btrfs_item_size(leaf, slot),
-			btrfs_chunk_item_size(num_stripes));
-		return -EUCLEAN;
-	}
 
 	/*
 	 * These valid checks may be insufficient to cover every corner cases.
@@ -2156,11 +2135,6 @@ int btrfs_check_chunk_valid(struct btrfs_fs_info *fs_info,
 		error("invalid chunk stripe length: %llu", stripe_len);
 		return -EIO;
 	}
-	/* Check on chunk item type */
-	if (slot == -1 && (type & BTRFS_BLOCK_GROUP_SYSTEM) == 0) {
-		error("invalid chunk type %llu", type);
-		return -EIO;
-	}
 	if (type & ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
 		     BTRFS_BLOCK_GROUP_PROFILE_MASK)) {
 		error("unrecognized chunk type: %llu",
@@ -2183,18 +2157,6 @@ int btrfs_check_chunk_valid(struct btrfs_fs_info *fs_info,
 		return -EIO;
 	}
 
-	chunk_ondisk_size = btrfs_chunk_item_size(num_stripes);
-	/*
-	 * Btrfs_chunk contains at least one stripe, and for sys_chunk
-	 * it can't exceed the system chunk array size
-	 * For normal chunk, it should match its chunk item size.
-	 */
-	if (num_stripes < 1 ||
-	    (slot == -1 && chunk_ondisk_size > BTRFS_SYSTEM_CHUNK_ARRAY_SIZE) ||
-	    (slot >= 0 && chunk_ondisk_size > btrfs_item_size(leaf, slot))) {
-		error("invalid num_stripes: %u", num_stripes);
-		return -EIO;
-	}
 	/*
 	 * Device number check against profile
 	 */
@@ -2243,7 +2205,7 @@ static int read_one_chunk(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
 	length = btrfs_chunk_length(leaf, chunk);
 	num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
 	/* Validation check */
-	ret = btrfs_check_chunk_valid(fs_info, leaf, chunk, slot, logical);
+	ret = btrfs_check_chunk_valid(leaf, chunk, logical);
 	if (ret) {
 		error("%s checksums match, but it has an invalid chunk, %s",
 		      (slot == -1) ? "Superblock" : "Metadata",
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index 206eab77..84fd6617 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -294,10 +294,8 @@ int write_raid56_with_parity(struct btrfs_fs_info *info,
 			     struct extent_buffer *eb,
 			     struct btrfs_multi_bio *multi,
 			     u64 stripe_len, u64 *raid_map);
-int btrfs_check_chunk_valid(struct btrfs_fs_info *fs_info,
-			    struct extent_buffer *leaf,
-			    struct btrfs_chunk *chunk,
-			    int slot, u64 logical);
+int btrfs_check_chunk_valid(struct extent_buffer *leaf,
+			    struct btrfs_chunk *chunk, u64 logical);
 u64 btrfs_stripe_length(struct btrfs_fs_info *fs_info,
 			struct extent_buffer *leaf,
 			struct btrfs_chunk *chunk);
-- 
2.40.0

