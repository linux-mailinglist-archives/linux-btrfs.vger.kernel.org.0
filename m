Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B494D0ABD
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343672AbiCGWOl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240605AbiCGWOk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:14:40 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A2156775
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:13:45 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id w1so14599386qtj.2
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lYNifBpAPxZS9C5NpTtiIgwHFZbUwPZShkOxIAxbU8U=;
        b=jvk38P9X3rdPjW2COXcgTzzCaRukMnQ+phAtB+TRkas+evL8JbNH9917hvJ34UYLBP
         qrWAopmOc4Lf1KQPHa7lOqkDamBJsS+iqsVdT1XDQS2vsGp6gymnBGamFrbu1HFAMJcR
         YoGGWTw7Re5ezYYEVNXTx8pxxXyx/si29rEBLP9DUpDpVRKzQyXtlxaVURIL2m+nE4X3
         YAkYqn0aj7NjH3Hl9XVQ3cvfNTehgO+Oc+5qZYvBmSmPHvdaCnGffJCA3wxjg9wXPxsJ
         zGbzqWcW91RPSnLVXjyToYBHlu4wW6lJfzp4FMB5fUAXqmojSYLQSLonLANmhOfGSu04
         t7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lYNifBpAPxZS9C5NpTtiIgwHFZbUwPZShkOxIAxbU8U=;
        b=cVe5tW4fBQP4AhU4k6Vp5LN4ddoB0XzhHz4ZsYNiJ+hFjlfu7/qrwwpTsAAqWilCzM
         5MsudpuHjB9YHhfBadNgtQxJCKG8pVJmU+Ea6FP6lLXMBKCgMfJyzHW0VRZdy1JUwUMK
         vV6z7kvdkij8n9IoMDU37jsikJQ1T6w9Ca5nfH51XRlJ47kDo2prHv9zGe+gTLyvlM1F
         mW3Dp6YQWgcX/KRXP25MXsHMqp5lb9JCnSNuvK+fYSE4VDqVeqi5MWhQE2tmtwI3FRiB
         wnyGRTbn8zVWXVGlhhkH9N+zTW6PlBcDA/6RF7BMnd7nMr4vNP1KdIhDjZvrtPt+e8kA
         mgNQ==
X-Gm-Message-State: AOAM533Pd1RtZOxUgxP8DhMpt2JLZsaXEAsPE/cxvF3SEAMSpEJM5ts+
        KOlU13mz6zSJiVTN0wa43Az++YzintGvXRfD
X-Google-Smtp-Source: ABdhPJxowPmQRu1CBV4JasDQAbjfHoOhu3Bgm6u0uXrYN4fEGIBFPqnwFBgctSG6XzIQnK6P4r5LKw==
X-Received: by 2002:a05:622a:120e:b0:2e0:5657:e89a with SMTP id y14-20020a05622a120e00b002e05657e89amr11191100qtx.195.1646691223971;
        Mon, 07 Mar 2022 14:13:43 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k125-20020a378883000000b006491db6dbb1sm6967095qkd.84.2022.03.07.14.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:13:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 15/15] btrfs-progs: deal with GC items in check
Date:   Mon,  7 Mar 2022 17:13:20 -0500
Message-Id: <f94cb3cca8f6ee626babe598df682438754b1174.1646691128.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691128.git.josef@toxicpanda.com>
References: <cover.1646691128.git.josef@toxicpanda.com>
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

If we have a GC item then we can treat the inode record like it has an
ORPHAN item, simply ignore it if we have either the ORPHAN item or the
GC item.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c          | 55 ++++++++++++++++++++++++++++++++++++++++---
 check/mode-original.h |  1 +
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index aab6b3a0..c5ffd652 100644
--- a/check/main.c
+++ b/check/main.c
@@ -627,6 +627,8 @@ static void print_inode_error(struct btrfs_root *root, struct inode_record *rec)
 	if (errors & I_ERR_INVALID_NLINK)
 		fprintf(stderr, ", directory has invalid nlink %d",
 			rec->nlink);
+	if (errors & I_ERR_NO_GC_ITEM)
+		fprintf(stderr, ", no gc item");
 	fprintf(stderr, "\n");
 
 	/* Print the holes if needed */
@@ -884,6 +886,42 @@ static int check_orphan_item(struct btrfs_root *root, u64 ino)
 	return ret;
 }
 
+static void check_inode_gc_item(struct btrfs_root *root, struct inode_record *rec)
+{
+	struct btrfs_root *gc_root;
+	struct rb_node *n;
+	struct btrfs_path path;
+	struct btrfs_key key = {
+		.objectid = root->root_key.objectid,
+		.type = BTRFS_GC_INODE_ITEM_KEY,
+		.offset = rec->ino,
+	};
+	int ret;
+
+	/*
+	 * We may choose to do something fancy with the location of our
+	 * GC_INODE_ITEM entries, so just search all of the gc roots for our
+	 * inode.
+	 */
+	for (n = rb_first(&gfs_info->global_roots_tree); n; n = rb_next(n)) {
+		gc_root = rb_entry(n, struct btrfs_root, rb_node);
+		if (gc_root->root_key.objectid != BTRFS_GC_TREE_OBJECTID)
+			continue;
+		btrfs_init_path(&path);
+		ret = btrfs_search_slot(NULL, gc_root, &key, &path, 0, 0);
+		btrfs_release_path(&path);
+
+		/*
+		 * Found our GC item, that means we don't need an orphan item so
+		 * we can clear both of these errors.
+		 */
+		if (ret == 0) {
+			rec->errors &= ~(I_ERR_NO_GC_ITEM | I_ERR_NO_ORPHAN_ITEM);
+			break;
+		}
+	}
+}
+
 static int process_inode_item(struct extent_buffer *eb,
 			      int slot, struct btrfs_key *key,
 			      struct shared_node *active_node)
@@ -907,8 +945,11 @@ static int process_inode_item(struct extent_buffer *eb,
 	if (btrfs_inode_flags(eb, item) & BTRFS_INODE_NODATASUM)
 		rec->nodatasum = 1;
 	rec->found_inode_item = 1;
-	if (rec->nlink == 0)
+	if (rec->nlink == 0) {
 		rec->errors |= I_ERR_NO_ORPHAN_ITEM;
+		if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2))
+			rec->errors |= I_ERR_NO_GC_ITEM;
+	}
 	flags = btrfs_inode_flags(eb, item);
 	if (S_ISLNK(rec->imode) &&
 	    flags & (BTRFS_INODE_IMMUTABLE | BTRFS_INODE_APPEND))
@@ -2569,7 +2610,7 @@ static int repair_inode_no_item(struct btrfs_trans_handle *trans,
 	rec->found_dir_item = 1;
 	rec->imode = mode | btrfs_type_to_imode(filetype);
 	rec->nlink = 0;
-	rec->errors &= ~I_ERR_NO_INODE_ITEM;
+	rec->errors &= ~(I_ERR_NO_INODE_ITEM | I_ERR_NO_GC_ITEM);
 	/* Ensure the inode_nlinks repair function will be called */
 	rec->errors |= I_ERR_LINK_COUNT_WRONG;
 out:
@@ -3082,8 +3123,16 @@ static int check_inode_recs(struct btrfs_root *root,
 
 		if (rec->errors & I_ERR_NO_ORPHAN_ITEM) {
 			ret = check_orphan_item(root, rec->ino);
+
+			/*
+			 * If we have an orphan item we need to not have a gc
+			 * item.
+			 */
 			if (ret == 0)
-				rec->errors &= ~I_ERR_NO_ORPHAN_ITEM;
+				rec->errors &= ~(I_ERR_NO_ORPHAN_ITEM |
+						 I_ERR_NO_GC_ITEM);
+
+			check_inode_gc_item(root, rec);
 			if (can_free_inode_rec(rec)) {
 				free_inode_rec(rec);
 				continue;
diff --git a/check/mode-original.h b/check/mode-original.h
index cf06917c..b93d7cca 100644
--- a/check/mode-original.h
+++ b/check/mode-original.h
@@ -187,6 +187,7 @@ struct unaligned_extent_rec_t {
 #define I_ERR_INVALID_IMODE		(1 << 19)
 #define I_ERR_INVALID_GEN		(1 << 20)
 #define I_ERR_INVALID_NLINK		(1 << 21)
+#define I_ERR_NO_GC_ITEM		(1 << 22)
 
 struct inode_record {
 	struct list_head backrefs;
-- 
2.26.3

