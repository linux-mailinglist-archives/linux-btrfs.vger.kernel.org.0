Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D095629D89
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 16:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiKOPcU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 10:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiKOPbr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 10:31:47 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D422DAA6
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:46 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id d8so6468158qki.13
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNSk3avLcnx+83jLUU0zUvRpy79WTW+kzQEUfBiacrs=;
        b=fPVW53OQ9TodYiucCxNh/oF4y0EPWzpRcmK/BUsps3CjCql22ZI22qQlkztIuN+n1/
         p3KiSTsKBSCwtH96VHMm0yXFRUAPkasTLQPlt+scBdSXjf8j0ewhoD2i0v3qcq5GcvuD
         cSPG53epPZj9I2bQLzYDJXNMw5XBFcSaqtxt2WyUjNu/IBkr8etA/rZT2giaf/Y7V/wM
         PB5Nj1d2Sg8+lYRQkhc/iVZOcUokqp7A7j0Wvm0HiJrBFiQhMTVzUqhJZXVqY1AIWLts
         9sE3IQNfFQRdCNSOdwRbntnn+xSv2KJN8xmR0bQXT/bKqN8jRpr0hRrJI/MCIzXI+nSh
         hONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNSk3avLcnx+83jLUU0zUvRpy79WTW+kzQEUfBiacrs=;
        b=p5P/7WFAEsOMOnDkpcpn23ZzdGGSy59vvHX3b6EvB89vWYEZuHpHqir2lQatHrwVcJ
         JXd4eairIeqWxxEYF5efQnFA+2utmgZbKSSPiUJIO/dtqJ52gJmEsmTUOBwgheIFAB7+
         IO+YYL28gYrUtaDLR+mFbcE2ODBQc9260xc6Y5mYZaQHBZiRjwns1eG+9lrjDV+2SDJx
         xmbK2wje0p+kzDrIzuthLgNI6caKaBOSix2YWqoh7eNL7ANjfP4f/qLRau9TsGdUs9lu
         kNquoj5Uyla4oGDG3DTY2zNM1mkLH1VOWzRQX6OqXqRlpGxVMgSFQfAYjCqtTkJOkhRW
         Pjig==
X-Gm-Message-State: ANoB5pke5OreYjjOhP+N65py3i3fu8c5p3Dy8VAT58EANU+c47ArnwE4
        OECuvCbqNVRYHLad3gvaDQQjBRhA6yTuVA==
X-Google-Smtp-Source: AA0mqf46HGNq9WkJWW4OcoAoPbGzqr1yzLoPoUVZg3w0UbYf572ECVIHrXmxznEdpDufbHvrbaiezw==
X-Received: by 2002:a05:620a:a1e:b0:6f6:ff30:1ff6 with SMTP id i30-20020a05620a0a1e00b006f6ff301ff6mr15482620qka.205.1668526305183;
        Tue, 15 Nov 2022 07:31:45 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id h21-20020ac846d5000000b003a4f22c6507sm7340204qto.48.2022.11.15.07.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:31:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 08/18] btrfs-progs: rename BLOCK_* to IMAGE_BLOCK_* for metadump
Date:   Tue, 15 Nov 2022 10:31:17 -0500
Message-Id: <1b8fe0f31565b89779bca3eb1e7c87f993584dd5.1668526161.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668526161.git.josef@toxicpanda.com>
References: <cover.1668526161.git.josef@toxicpanda.com>
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

When we sync the kernel we're going to pull in the fs.h dependency,
which defines BLOCK_SIZE/BLOCK_MASK.  Avoid this conflict by renaming
the image definitions with the IMAGE_ prefix.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 image/main.c     | 42 +++++++++++++++++++++---------------------
 image/metadump.h |  6 +++---
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/image/main.c b/image/main.c
index b1a0714a..c7bbb05d 100644
--- a/image/main.c
+++ b/image/main.c
@@ -94,7 +94,7 @@ struct metadump_struct {
 
 	union {
 		struct meta_cluster cluster;
-		char meta_cluster_bytes[BLOCK_SIZE];
+		char meta_cluster_bytes[IMAGE_BLOCK_SIZE];
 	};
 
 	pthread_t threads[MAX_WORKER_THREADS];
@@ -519,7 +519,7 @@ static int metadump_init(struct metadump_struct *md, struct btrfs_root *root,
 
 static int write_zero(FILE *out, size_t size)
 {
-	static char zero[BLOCK_SIZE];
+	static char zero[IMAGE_BLOCK_SIZE];
 	return fwrite(zero, size, 1, out);
 }
 
@@ -563,14 +563,14 @@ static int write_buffers(struct metadump_struct *md, u64 *next)
 	}
 	header->nritems = cpu_to_le32(nritems);
 
-	ret = fwrite(&md->cluster, BLOCK_SIZE, 1, md->out);
+	ret = fwrite(&md->cluster, IMAGE_BLOCK_SIZE, 1, md->out);
 	if (ret != 1) {
 		error("unable to write out cluster: %m");
 		return -errno;
 	}
 
 	/* write buffers */
-	bytenr += le64_to_cpu(header->bytenr) + BLOCK_SIZE;
+	bytenr += le64_to_cpu(header->bytenr) + IMAGE_BLOCK_SIZE;
 	while (!list_empty(&md->ordered)) {
 		async = list_entry(md->ordered.next, struct async_work,
 				   ordered);
@@ -591,8 +591,8 @@ static int write_buffers(struct metadump_struct *md, u64 *next)
 	}
 
 	/* zero unused space in the last block */
-	if (!err && bytenr & BLOCK_MASK) {
-		size_t size = BLOCK_SIZE - (bytenr & BLOCK_MASK);
+	if (!err && bytenr & IMAGE_BLOCK_MASK) {
+		size_t size = IMAGE_BLOCK_SIZE - (bytenr & IMAGE_BLOCK_MASK);
 
 		bytenr += size;
 		ret = write_zero(md->out, size);
@@ -1613,7 +1613,7 @@ static void mdrestore_destroy(struct mdrestore_struct *mdres, int num_threads)
 static int detect_version(FILE *in)
 {
 	struct meta_cluster *cluster;
-	u8 buf[BLOCK_SIZE];
+	u8 buf[IMAGE_BLOCK_SIZE];
 	bool found = false;
 	int i;
 	int ret;
@@ -1622,7 +1622,7 @@ static int detect_version(FILE *in)
 		error("seek failed: %m");
 		return -errno;
 	}
-	ret = fread(buf, BLOCK_SIZE, 1, in);
+	ret = fread(buf, IMAGE_BLOCK_SIZE, 1, in);
 	if (!ret) {
 		error("failed to read header");
 		return -EIO;
@@ -1757,7 +1757,7 @@ static int add_cluster(struct meta_cluster *cluster,
 	mdres->compress_method = header->compress;
 	pthread_mutex_unlock(&mdres->mutex);
 
-	bytenr = le64_to_cpu(header->bytenr) + BLOCK_SIZE;
+	bytenr = le64_to_cpu(header->bytenr) + IMAGE_BLOCK_SIZE;
 	nritems = le32_to_cpu(header->nritems);
 	for (i = 0; i < nritems; i++) {
 		item = &cluster->items[i];
@@ -1799,9 +1799,9 @@ static int add_cluster(struct meta_cluster *cluster,
 		pthread_cond_signal(&mdres->cond);
 		pthread_mutex_unlock(&mdres->mutex);
 	}
-	if (bytenr & BLOCK_MASK) {
-		char buffer[BLOCK_MASK];
-		size_t size = BLOCK_SIZE - (bytenr & BLOCK_MASK);
+	if (bytenr & IMAGE_BLOCK_MASK) {
+		char buffer[IMAGE_BLOCK_MASK];
+		size_t size = IMAGE_BLOCK_SIZE - (bytenr & IMAGE_BLOCK_MASK);
 
 		bytenr += size;
 		ret = fread(buffer, size, 1, mdres->in);
@@ -2011,7 +2011,7 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres)
 	u8 *buffer, *tmp = NULL;
 	int ret = 0;
 
-	cluster = malloc(BLOCK_SIZE);
+	cluster = malloc(IMAGE_BLOCK_SIZE);
 	if (!cluster) {
 		error_msg(ERROR_MSG_MEMORY, NULL);
 		return -ENOMEM;
@@ -2043,7 +2043,7 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres)
 			goto out;
 		}
 
-		ret = fread(cluster, BLOCK_SIZE, 1, mdres->in);
+		ret = fread(cluster, IMAGE_BLOCK_SIZE, 1, mdres->in);
 		if (ret == 0) {
 			if (feof(mdres->in))
 				goto out;
@@ -2071,7 +2071,7 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres)
 		if (current_cluster > mdres->sys_chunk_end)
 			goto out;
 
-		bytenr += BLOCK_SIZE;
+		bytenr += IMAGE_BLOCK_SIZE;
 		nritems = le32_to_cpu(header->nritems);
 
 		/* Search items for tree blocks in sys chunks */
@@ -2139,8 +2139,8 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres)
 			}
 			bytenr += bufsize;
 		}
-		if (bytenr & BLOCK_MASK)
-			bytenr += BLOCK_SIZE - (bytenr & BLOCK_MASK);
+		if (bytenr & IMAGE_BLOCK_MASK)
+			bytenr += IMAGE_BLOCK_SIZE - (bytenr & IMAGE_BLOCK_MASK);
 		current_cluster = bytenr;
 	}
 
@@ -2251,7 +2251,7 @@ static int build_chunk_tree(struct mdrestore_struct *mdres,
 	if (mdres->in == stdin)
 		return 0;
 
-	ret = fread(cluster, BLOCK_SIZE, 1, mdres->in);
+	ret = fread(cluster, IMAGE_BLOCK_SIZE, 1, mdres->in);
 	if (ret <= 0) {
 		error("unable to read cluster: %m");
 		return -EIO;
@@ -2265,7 +2265,7 @@ static int build_chunk_tree(struct mdrestore_struct *mdres,
 		return -EIO;
 	}
 
-	bytenr += BLOCK_SIZE;
+	bytenr += IMAGE_BLOCK_SIZE;
 	mdres->compress_method = header->compress;
 	nritems = le32_to_cpu(header->nritems);
 	for (i = 0; i < nritems; i++) {
@@ -2807,7 +2807,7 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 		}
 	}
 
-	cluster = malloc(BLOCK_SIZE);
+	cluster = malloc(IMAGE_BLOCK_SIZE);
 	if (!cluster) {
 		error_msg(ERROR_MSG_MEMORY, NULL);
 		ret = -ENOMEM;
@@ -2837,7 +2837,7 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 	}
 
 	while (!mdrestore.error) {
-		ret = fread(cluster, BLOCK_SIZE, 1, in);
+		ret = fread(cluster, IMAGE_BLOCK_SIZE, 1, in);
 		if (!ret)
 			break;
 
diff --git a/image/metadump.h b/image/metadump.h
index bcffbd47..1beab658 100644
--- a/image/metadump.h
+++ b/image/metadump.h
@@ -22,10 +22,10 @@
 #include "kernel-lib/list.h"
 #include "kernel-shared/ctree.h"
 
-#define BLOCK_SIZE		SZ_1K
-#define BLOCK_MASK		(BLOCK_SIZE - 1)
+#define IMAGE_BLOCK_SIZE		SZ_1K
+#define IMAGE_BLOCK_MASK		(IMAGE_BLOCK_SIZE - 1)
 
-#define ITEMS_PER_CLUSTER ((BLOCK_SIZE - sizeof(struct meta_cluster)) / \
+#define ITEMS_PER_CLUSTER ((IMAGE_BLOCK_SIZE - sizeof(struct meta_cluster)) / \
 			   sizeof(struct meta_cluster_item))
 
 #define COMPRESS_NONE		0
-- 
2.26.3

