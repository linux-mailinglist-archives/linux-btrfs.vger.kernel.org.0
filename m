Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9780A636D61
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 23:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiKWWi3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 17:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiKWWiG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 17:38:06 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCE424BE0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:38:05 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id jr19so132267qtb.7
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uR3lErDo7/kuATg8JdB5xvhjhL6I3cwUx15NLkCw2Ko=;
        b=HpcM90PyF7F67n+pELt8MTLW+yRxSxygnzboy1kslHW2AG3hxc1SkXhknmMYPESnmQ
         DcOFb1K0LIvJOBAE3rO3hi4C7Lzam/ubUMrEfXbVpxgJwuC+NmcZnc9y8Us+Q3S5di4N
         8RJSigGTaPCeqltRjl6BVr53/7wIShVpHIHe+iFKxu5bjibHSOFqqn1upJmsscJ2tbiW
         v5YAygT+K7LegaXP3Z0e4wPLWwJHZ2I8sNFQPz6iRBCwCEbsLVBH/44PE/4EUld7a8bG
         0GDk0BE1QaPev9nIBZYDSus2DRxStMc/gQve9P4o6BX1bwFjiWxcxfSUFYKcN7/wTxyS
         B/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uR3lErDo7/kuATg8JdB5xvhjhL6I3cwUx15NLkCw2Ko=;
        b=hkuLQL3cLNNmG9s+LzaBJKRfa5bb2YCYAY2Fe/XIAlroOcz0yo+GJvc0mSge9qVjhK
         zuRdZxWIDhZvLT3yWaK8RkZ04Jl/k1Je2EH2VhKeayUPpG5FIDA8uQpR7YEMkVXHR4FX
         3YIEvU9nIPz8ep5BHEA9TOjL7d7rm1nuOo6J1+nsFvNE3Luq4KK7UOTa0mTfb98MPamb
         oXdTS/3IpjLG+ojz8Qlg74JS1Iup9AGB/Ugi6RkBFg8OSb6jCbXJwdj9TA+hdzAmAvuH
         Wyq16xiGNlT2+u4qtDYoY+KWB6pXpotGrjD2fzOdd2MQ2X+6HYoYIovM/4+twxKMNVlH
         5ZUg==
X-Gm-Message-State: ANoB5pmiqyBrpkbOSw6IBNALbprMQ+QItg3Mslq8xLXw5uiClQdKtugA
        wkjtZQuEVmHpmsXTi8S+0z19W9ztWAEeuw==
X-Google-Smtp-Source: AA0mqf4hKcb7LH/IvcyT4IaYmVVD4iGPzlhBHPApF5w0dyAOVVycEGecUm0ZDS8ScnMmWuV6fXS0ow==
X-Received: by 2002:ac8:1183:0:b0:3a5:8517:c3f3 with SMTP id d3-20020ac81183000000b003a58517c3f3mr28231551qtj.618.1669243083990;
        Wed, 23 Nov 2022 14:38:03 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id i15-20020a05620a248f00b006fa9d101775sm13071473qkn.33.2022.11.23.14.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:38:03 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 19/29] btrfs-progs: rename extent buffer flags to EXTENT_BUFFER_*
Date:   Wed, 23 Nov 2022 17:37:27 -0500
Message-Id: <aebccc7f609a3252f81afa85630433c7ed61b4c8.1669242804.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1669242804.git.josef@toxicpanda.com>
References: <cover.1669242804.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have been overloading the extent_state flags for use on the extent
buffers as well.  When we sync extent-io-tree.[ch] this will become
impossible, so rename these flags to EXTENT_BUFFER_* and use those
definitions instead of the extent_state definitions.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c              |  2 +-
 check/mode-lowmem.c       |  2 +-
 kernel-shared/ctree.c     |  2 +-
 kernel-shared/disk-io.c   |  4 ++--
 kernel-shared/extent_io.c | 10 +++++-----
 kernel-shared/extent_io.h | 13 ++++++++-----
 6 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/check/main.c b/check/main.c
index 4d8d6882..4af6cd4e 100644
--- a/check/main.c
+++ b/check/main.c
@@ -3641,7 +3641,7 @@ static int check_fs_root(struct btrfs_root *root,
 		      super_generation + 1);
 		generation_err = true;
 		if (opt_check_repair) {
-			root->node->flags |= EXTENT_BAD_TRANSID;
+			root->node->flags |= EXTENT_BUFFER_BAD_TRANSID;
 			ret = recow_extent_buffer(root, root->node);
 			if (!ret) {
 				printf("Reset generation for root %llu\n",
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index c62d8326..2cde3b63 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -5282,7 +5282,7 @@ static int check_btrfs_root(struct btrfs_root *root, int check_all)
 		      super_generation + 1);
 		err |= INVALID_GENERATION;
 		if (opt_check_repair) {
-			root->node->flags |= EXTENT_BAD_TRANSID;
+			root->node->flags |= EXTENT_BUFFER_BAD_TRANSID;
 			ret = recow_extent_buffer(root, root->node);
 			if (!ret) {
 				printf("Reset generation for root %llu\n",
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index d6ff0008..9b9fc9eb 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -473,7 +473,7 @@ int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 	write_extent_buffer(cow, root->fs_info->fs_devices->metadata_uuid,
 			    btrfs_header_fsid(), BTRFS_FSID_SIZE);
 
-	WARN_ON(!(buf->flags & EXTENT_BAD_TRANSID) &&
+	WARN_ON(!(buf->flags & EXTENT_BUFFER_BAD_TRANSID) &&
 		btrfs_header_generation(buf) > trans->transid);
 
 	update_ref_for_cow(trans, root, buf, cow);
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index c266f9c2..4050566a 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -276,7 +276,7 @@ static int verify_parent_transid(struct extent_buffer *eb, u64 parent_transid,
 	       (unsigned long long)parent_transid,
 	       (unsigned long long)btrfs_header_generation(eb));
 	if (ignore) {
-		eb->flags |= EXTENT_BAD_TRANSID;
+		eb->flags |= EXTENT_BUFFER_BAD_TRANSID;
 		printk("Ignoring transid failure\n");
 		return 0;
 	}
@@ -374,7 +374,7 @@ struct extent_buffer* read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 		if (ret == 0 && csum_tree_block(fs_info, eb, 1) == 0 &&
 		    check_tree_block(fs_info, eb) == 0 &&
 		    verify_parent_transid(eb, parent_transid, ignore) == 0) {
-			if (eb->flags & EXTENT_BAD_TRANSID &&
+			if (eb->flags & EXTENT_BUFFER_BAD_TRANSID &&
 			    list_empty(&eb->recow)) {
 				list_add_tail(&eb->recow,
 					      &fs_info->recow_ebs);
diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index baaf7234..99191fe2 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -648,7 +648,7 @@ static void free_extent_buffer_internal(struct extent_buffer *eb, bool free_now)
 	eb->refs--;
 	BUG_ON(eb->refs < 0);
 	if (eb->refs == 0) {
-		if (eb->flags & EXTENT_DIRTY) {
+		if (eb->flags & EXTENT_BUFFER_DIRTY) {
 			warning(
 			"dirty eb leak (aborted trans): start %llu len %u",
 				eb->start, eb->len);
@@ -1027,8 +1027,8 @@ out:
 int set_extent_buffer_dirty(struct extent_buffer *eb)
 {
 	struct extent_io_tree *tree = &eb->fs_info->dirty_buffers;
-	if (!(eb->flags & EXTENT_DIRTY)) {
-		eb->flags |= EXTENT_DIRTY;
+	if (!(eb->flags & EXTENT_BUFFER_DIRTY)) {
+		eb->flags |= EXTENT_BUFFER_DIRTY;
 		set_extent_dirty(tree, eb->start, eb->start + eb->len - 1);
 		extent_buffer_get(eb);
 	}
@@ -1038,8 +1038,8 @@ int set_extent_buffer_dirty(struct extent_buffer *eb)
 int clear_extent_buffer_dirty(struct extent_buffer *eb)
 {
 	struct extent_io_tree *tree = &eb->fs_info->dirty_buffers;
-	if (eb->flags & EXTENT_DIRTY) {
-		eb->flags &= ~EXTENT_DIRTY;
+	if (eb->flags & EXTENT_BUFFER_DIRTY) {
+		eb->flags &= ~EXTENT_BUFFER_DIRTY;
 		clear_extent_dirty(tree, eb->start, eb->start + eb->len - 1);
 		free_extent_buffer(eb);
 	}
diff --git a/kernel-shared/extent_io.h b/kernel-shared/extent_io.h
index 4529919a..88fb6171 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -33,10 +33,13 @@
 #define EXTENT_DEFRAG_DONE	(1U << 7)
 #define EXTENT_BUFFER_FILLED	(1U << 8)
 #define EXTENT_CSUM		(1U << 9)
-#define EXTENT_BAD_TRANSID	(1U << 10)
-#define EXTENT_BUFFER_DUMMY	(1U << 11)
 #define EXTENT_IOBITS (EXTENT_LOCKED | EXTENT_WRITEBACK)
 
+#define EXTENT_BUFFER_UPTODATE		(1U << 0)
+#define EXTENT_BUFFER_DIRTY		(1U << 1)
+#define EXTENT_BUFFER_BAD_TRANSID	(1U << 2)
+#define EXTENT_BUFFER_DUMMY		(1U << 3)
+
 #define BLOCK_GROUP_DATA	(1U << 1)
 #define BLOCK_GROUP_METADATA	(1U << 2)
 #define BLOCK_GROUP_SYSTEM	(1U << 4)
@@ -108,13 +111,13 @@ int set_extent_dirty(struct extent_io_tree *tree, u64 start, u64 end);
 int clear_extent_dirty(struct extent_io_tree *tree, u64 start, u64 end);
 static inline int set_extent_buffer_uptodate(struct extent_buffer *eb)
 {
-	eb->flags |= EXTENT_UPTODATE;
+	eb->flags |= EXTENT_BUFFER_UPTODATE;
 	return 0;
 }
 
 static inline int clear_extent_buffer_uptodate(struct extent_buffer *eb)
 {
-	eb->flags &= ~EXTENT_UPTODATE;
+	eb->flags &= ~EXTENT_BUFFER_UPTODATE;
 	return 0;
 }
 
@@ -122,7 +125,7 @@ static inline int extent_buffer_uptodate(struct extent_buffer *eb)
 {
 	if (!eb || IS_ERR(eb))
 		return 0;
-	if (eb->flags & EXTENT_UPTODATE)
+	if (eb->flags & EXTENT_BUFFER_UPTODATE)
 		return 1;
 	return 0;
 }
-- 
2.26.3

