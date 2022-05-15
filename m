Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3D5527726
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 May 2022 12:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbiEOKz2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 May 2022 06:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbiEOKzZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 May 2022 06:55:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3849E15812
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 03:55:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA07921DD1
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 10:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652612122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kuC44Bx3ZYTZcrYol4Vrgy7iu+I1jpnIlepHuTonpmQ=;
        b=YmFRA3rZVMtx/fmhc7+qxFyecdBg78aJrNjzM1Nj5fpiqAlDGf246C1PAcmHHlXNOaYj2w
        GyvWy46t0Qgox8QtF/Dsm6J+yezRntt7LXSkzoJPOn2NNUEtRPZ12oeKRDiuVuLVDZE4Ki
        n0S7N8DoeAAe2IkVJFkISjAWrXMG0dU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48F1C13491
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 10:55:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iKJcBRrcgGLsfQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 10:55:22 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs-progs: check: take per device reservation into consideration
Date:   Sun, 15 May 2022 18:54:58 +0800
Message-Id: <89f7d4b911dfbc2dc6cd1893c26b83846812802f.1652611957.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1652611957.git.wqu@suse.com>
References: <cover.1652611957.git.wqu@suse.com>
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

This patch will make both orginal and lowmem mode to take per device
reservation into consideration for dev extent and chunk verification.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/common.h      |  1 +
 check/main.c        | 16 +++++++++++++---
 check/mode-lowmem.c | 15 +++++++++++----
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/check/common.h b/check/common.h
index f6e6eece37aa..051ffe65cb94 100644
--- a/check/common.h
+++ b/check/common.h
@@ -75,6 +75,7 @@ struct chunk_record {
 	u16 sub_stripes;
 	u32 io_align;
 	u32 io_width;
+	u32 per_dev_reserved;
 	u32 sector_size;
 	struct stripe stripes[0];
 };
diff --git a/check/main.c b/check/main.c
index bcb016964e7a..d8834b2386d6 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5202,6 +5202,7 @@ struct chunk_record *btrfs_new_chunk_record(struct extent_buffer *leaf,
 	struct btrfs_chunk *ptr;
 	struct chunk_record *rec;
 	int num_stripes, i;
+	bool is_journal;
 
 	ptr = btrfs_item_ptr(leaf, slot, struct btrfs_chunk);
 	num_stripes = btrfs_chunk_num_stripes(leaf, ptr);
@@ -5225,12 +5226,19 @@ struct chunk_record *btrfs_new_chunk_record(struct extent_buffer *leaf,
 	rec->type = key->type;
 	rec->offset = key->offset;
 
+	is_journal = btrfs_bg_type_is_journal(btrfs_chunk_type(leaf, ptr));
 	rec->length = rec->cache.size;
 	rec->owner = btrfs_chunk_owner(leaf, ptr);
 	rec->stripe_len = btrfs_chunk_stripe_len(leaf, ptr);
 	rec->type_flags = btrfs_chunk_type(leaf, ptr);
 	rec->io_width = btrfs_chunk_io_width(leaf, ptr);
-	rec->io_align = btrfs_chunk_io_align(leaf, ptr);
+	if (is_journal) {
+		rec->io_align = rec->io_width;
+		rec->per_dev_reserved = btrfs_chunk_per_dev_reserved(leaf, ptr);
+	} else {
+		rec->io_align = btrfs_chunk_io_align(leaf, ptr);
+		rec->per_dev_reserved = 0;
+	}
 	rec->sector_size = btrfs_chunk_sector_size(leaf, ptr);
 	rec->num_stripes = num_stripes;
 	rec->sub_stripes = btrfs_chunk_sub_stripes(leaf, ptr);
@@ -8445,10 +8453,12 @@ static int check_chunk_refs(struct chunk_record *chunk_rec,
 		return ret;
 
 	length = calc_stripe_length(chunk_rec->type_flags, chunk_rec->length,
-				    chunk_rec->num_stripes);
+				    chunk_rec->num_stripes) +
+		 chunk_rec->per_dev_reserved;
 	for (i = 0; i < chunk_rec->num_stripes; ++i) {
 		devid = chunk_rec->stripes[i].devid;
-		offset = chunk_rec->stripes[i].offset;
+		offset = chunk_rec->stripes[i].offset - chunk_rec->per_dev_reserved;
+
 		dev_extent_item = lookup_cache_extent2(&dev_extent_cache->tree,
 						       devid, offset, length);
 		if (dev_extent_item) {
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 68c1adfd04a4..63f9343ba2ff 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -4435,6 +4435,7 @@ static int check_dev_extent_item(struct extent_buffer *eb, int slot)
 	struct extent_buffer *l;
 	int num_stripes;
 	u64 length;
+	u32 per_dev_reserved = 0;
 	int i;
 	int found_chunk = 0;
 	int ret;
@@ -4458,8 +4459,10 @@ static int check_dev_extent_item(struct extent_buffer *eb, int slot)
 				      chunk_key.offset);
 	if (ret < 0)
 		goto out;
+	if (btrfs_bg_type_is_journal(btrfs_chunk_type(l, chunk)))
+		per_dev_reserved = btrfs_chunk_per_dev_reserved(l, chunk);
 
-	if (btrfs_stripe_length(gfs_info, l, chunk) != length)
+	if (btrfs_stripe_length(gfs_info, l, chunk) != length - per_dev_reserved)
 		goto out;
 
 	num_stripes = btrfs_chunk_num_stripes(l, chunk);
@@ -4468,7 +4471,7 @@ static int check_dev_extent_item(struct extent_buffer *eb, int slot)
 		u64 offset = btrfs_stripe_offset_nr(l, chunk, i);
 
 		if (devid == devext_key.objectid &&
-		    offset == devext_key.offset) {
+		    offset == devext_key.offset + per_dev_reserved) {
 			found_chunk = 1;
 			break;
 		}
@@ -4648,6 +4651,7 @@ static int check_chunk_item(struct extent_buffer *eb, int slot)
 	struct btrfs_chunk *chunk;
 	struct extent_buffer *leaf;
 	struct btrfs_dev_extent *ptr;
+	u32 per_dev_reserved = 0;
 	u64 length;
 	u64 chunk_end;
 	u64 stripe_len;
@@ -4672,6 +4676,8 @@ static int check_chunk_item(struct extent_buffer *eb, int slot)
 		goto out;
 	}
 	type = btrfs_chunk_type(eb, chunk);
+	if (btrfs_bg_type_is_journal(type))
+		per_dev_reserved = btrfs_chunk_per_dev_reserved(eb, chunk);
 
 	btrfs_init_path(&path);
 	ret = find_block_group_item(&path, chunk_key.offset, length, type);
@@ -4679,13 +4685,14 @@ static int check_chunk_item(struct extent_buffer *eb, int slot)
 		err |= REFERENCER_MISSING;
 
 	num_stripes = btrfs_chunk_num_stripes(eb, chunk);
-	stripe_len = btrfs_stripe_length(gfs_info, eb, chunk);
+	stripe_len = btrfs_stripe_length(gfs_info, eb, chunk) + per_dev_reserved;
 	for (i = 0; i < num_stripes; i++) {
 		btrfs_release_path(&path);
 		btrfs_init_path(&path);
 		devext_key.objectid = btrfs_stripe_devid_nr(eb, chunk, i);
 		devext_key.type = BTRFS_DEV_EXTENT_KEY;
-		devext_key.offset = btrfs_stripe_offset_nr(eb, chunk, i);
+		devext_key.offset = btrfs_stripe_offset_nr(eb, chunk, i) -
+				    per_dev_reserved;
 
 		ret = btrfs_search_slot(NULL, dev_root, &devext_key, &path,
 					0, 0);
-- 
2.36.1

