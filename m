Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A39566448
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 09:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiGEHiX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 03:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiGEHiP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 03:38:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DFC13D10
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 00:38:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 03C62224C7
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657006693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HhRGTbKvqpajSYHdCvBT3CuOqbG3Vrxup5jBxPbbLew=;
        b=nRzojfcf6o062nmyZEjgzR2U0r+Ni8XZZTnWwTrdya8Ou3CIlzWH2i2hn5S/5Ui6leqd8g
        aOKI7/dy69YngFVVqT3UDRUp2aoQU8GPgtFPiC0KzcJCsUI6fL0rnlLefVtz+wj+O3+r5R
        cYU5cuiBQxzB355QU0WQF8tYDFLP/Vs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BB5F1339A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:38:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ALM4CmTqw2JTOwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jul 2022 07:38:12 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs-progs: check: add extra warning for dev extents inside the reserved range
Date:   Tue,  5 Jul 2022 15:37:44 +0800
Message-Id: <e63888c360ea617f6fc6064ff63dc8ed489e99de.1657006141.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657006141.git.wqu@suse.com>
References: <cover.1657006141.git.wqu@suse.com>
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

Since kernel can handle it without problem, and we rely on balance to
relocate those offending dev extents, we only need to output warning
when such dev extents are detected.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c          | 17 +++++++++++++++++
 check/mode-lowmem.c   | 22 ++++++++++++++++++++++
 kernel-shared/ctree.h |  1 +
 3 files changed, 40 insertions(+)

diff --git a/check/main.c b/check/main.c
index 6b2be57a1505..6c230cf05acb 100644
--- a/check/main.c
+++ b/check/main.c
@@ -8918,6 +8918,7 @@ static int check_dev_extents(void)
 	struct btrfs_key key;
 	struct btrfs_root *dev_root = gfs_info->dev_root;
 	int ret;
+	u32 super_reserved = BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
 	u64 prev_devid = 0;
 	u64 prev_dev_ext_end = 0;
 
@@ -8927,6 +8928,10 @@ static int check_dev_extents(void)
 	key.type = BTRFS_DEV_EXTENT_KEY;
 	key.offset = 0;
 
+	if (btrfs_fs_compat_ro(gfs_info, EXTRA_SUPER_RESERVED) &&
+	    btrfs_super_reserved_bytes(gfs_info->super_copy) >= super_reserved)
+		super_reserved = btrfs_super_reserved_bytes(gfs_info->super_copy);
+
 	ret = btrfs_search_slot(NULL, dev_root, &key, &path, 0, 0);
 	if (ret < 0) {
 		errno = -ret;
@@ -8983,6 +8988,13 @@ static int check_dev_extents(void)
 			ret = -EUCLEAN;
 			goto out;
 		}
+		if (physical_offset < super_reserved) {
+			warning(
+"dev extent devid %llu physical offset %llu is inside the reserved range (%u)",
+				devid, physical_offset,
+				super_reserved);
+			gfs_info->found_dev_extents_in_reserved = 1;
+		}
 		prev_devid = devid;
 		prev_dev_ext_end = physical_offset + physical_len;
 
@@ -8998,6 +9010,11 @@ static int check_dev_extents(void)
 		}
 	}
 out:
+	if (gfs_info->found_dev_extents_in_reserved) {
+		warning("to relocate the dev extents in reserved range, mount the fs and run:");
+		warning("\tbtrfs balance start -mdrange=0..%u -ddrange=0..%u -sdrange=0..%u",
+			super_reserved, super_reserved, super_reserved);
+	}
 	btrfs_release_path(&path);
 	return ret;
 }
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index fa324506dd5d..103c27c6d0bf 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -4433,12 +4433,17 @@ static int check_dev_extent_item(struct extent_buffer *eb, int slot)
 	struct btrfs_key devext_key;
 	struct btrfs_chunk *chunk;
 	struct extent_buffer *l;
+	u32 super_reserved = BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
 	int num_stripes;
 	u64 length;
 	int i;
 	int found_chunk = 0;
 	int ret;
 
+	if (btrfs_fs_compat_ro(gfs_info, EXTRA_SUPER_RESERVED) &&
+	    btrfs_super_reserved_bytes(gfs_info->super_copy) >= super_reserved)
+		super_reserved = btrfs_super_reserved_bytes(gfs_info->super_copy);
+
 	btrfs_item_key_to_cpu(eb, &devext_key, slot);
 	ptr = btrfs_item_ptr(eb, slot, struct btrfs_dev_extent);
 	length = btrfs_dev_extent_length(eb, ptr);
@@ -4447,6 +4452,13 @@ static int check_dev_extent_item(struct extent_buffer *eb, int slot)
 	chunk_key.type = BTRFS_CHUNK_ITEM_KEY;
 	chunk_key.offset = btrfs_dev_extent_chunk_offset(eb, ptr);
 
+	if (devext_key.offset < super_reserved) {
+		warning(
+"dev extent devid %llu physical offset %llu is inside the reserved range (%u)",
+			devext_key.objectid, devext_key.offset,
+			super_reserved);
+		gfs_info->found_dev_extents_in_reserved = 1;
+	}
 	btrfs_init_path(&path);
 	ret = btrfs_search_slot(NULL, chunk_root, &chunk_key, &path, 0, 0);
 	if (ret)
@@ -5526,9 +5538,14 @@ int check_chunks_and_extents_lowmem(void)
 	struct btrfs_key key;
 	struct btrfs_root *root;
 	struct btrfs_root *cur_root;
+	u32 super_reserved = BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
 	int err = 0;
 	int ret;
 
+	if (btrfs_fs_compat_ro(gfs_info, EXTRA_SUPER_RESERVED) &&
+	    btrfs_super_reserved_bytes(gfs_info->super_copy) >= super_reserved)
+		super_reserved = btrfs_super_reserved_bytes(gfs_info->super_copy);
+
 	root = gfs_info->chunk_root;
 	ret = check_btrfs_root(root, 1);
 	err |= ret;
@@ -5590,6 +5607,11 @@ out:
 			total_used);
 		err |= SUPER_BYTES_USED_ERROR;
 	}
+	if (gfs_info->found_dev_extents_in_reserved) {
+		warning("to relocate the dev extents in reserved range, mount the fs and run:");
+		warning("\tbtrfs balance start -mdrange=0..%u -ddrange=0..%u -sdrange=0..%u",
+			super_reserved, super_reserved, super_reserved);
+	}
 
 	if (repair) {
 		ret = end_avoid_extents_overwrite();
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index eb49aa8da919..0b4a8d60ceb4 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1271,6 +1271,7 @@ struct btrfs_fs_info {
 	unsigned int finalize_on_close:1;
 	unsigned int hide_names:1;
 	unsigned int allow_transid_mismatch:1;
+	unsigned int found_dev_extents_in_reserved:1;
 
 	int transaction_aborted;
 	int force_csum_type;
-- 
2.36.1

