Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AC4636D53
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 23:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiKWWiT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 17:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiKWWhy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 17:37:54 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8123FBA3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:51 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id j6so13093241qvn.12
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNSk3avLcnx+83jLUU0zUvRpy79WTW+kzQEUfBiacrs=;
        b=8EFRKsv4ucTiqgNR9PeWGS2bfLp9SeOdkKAmkXq9vr9IG3IW9/fU99zhUA+qgsNyiV
         rZkSsX8OO58Ux4zM/CIseJrmQ8XiMdM1G8kpjDohwVnM2ctU2w9x+2fQFgg2P8wjYr8n
         8c7oHz5ZmQTS8/j7dRRUmpLjsjT+v9KzRkcv39BypDmB8q0FbIeVH3QN6tYWJoleMyJD
         kEQ17hVAONBef3BJfEKR0SsBRfBEtb9+f15yem/jDYt7skU4ehDZikEFwYntdwIJDspK
         /6Fl23Xsn1WC2LQXoBclNscsV/ZlAhanVNS5fruu1MBMDd0UOT+hT9N/PTKQt3LLNwnW
         nqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNSk3avLcnx+83jLUU0zUvRpy79WTW+kzQEUfBiacrs=;
        b=vpnl0SLdN32XFrEUK5FsVmszVUDCcyU9/SpKl5aTO745LzpCUl6ixOc96iOL6rmt97
         iIJLnMXKafj/jji1m8NLuemiQ/0T+ixobxbmKscgPtfknw/8HTmtEsGDZYk5cDl72Hrp
         gkTgNRYgejRYDs2TR9LJ0HKNBGVJUF0D4UjToPmspw8ApMaRWBKYQIoQlESAnO5c4/SE
         vDpaUdfE1z9ZhZv/VH3YY23v9xZChwHF2yU/bLH1nV8bX6NDOAaYdWjE5ob2d7KLDA34
         Em6pBd/YlQ8G+IMXjZVsAPJ55AKdZfof6qCyfMnEPewoo25/8gcMT5AjUm5QX4yDN4D7
         EDcQ==
X-Gm-Message-State: ANoB5pm/siPTP/+FJzhDeoKSiEi3/vkYLUYqAFGudShGA7/i+X9Rcy/i
        uNDxXuIvN2fqa5qFynvmz7BrdBkGAUfWeA==
X-Google-Smtp-Source: AA0mqf4wwHQA/FQGDPTwr88u0J43suBPdoMnaTz3O1S1BLn7ZtzngyDHhlwntQnju6HmXi1kQvcgvA==
X-Received: by 2002:ad4:43eb:0:b0:4c6:90f0:cbe6 with SMTP id f11-20020ad443eb000000b004c690f0cbe6mr9500349qvu.116.1669243070675;
        Wed, 23 Nov 2022 14:37:50 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id w16-20020a05620a425000b006fc2f74ad12sm1666466qko.92.2022.11.23.14.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:37:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 09/29] btrfs-progs: rename BLOCK_* to IMAGE_BLOCK_* for metadump
Date:   Wed, 23 Nov 2022 17:37:17 -0500
Message-Id: <f46f685b552ab6b8c9314cab06e236d8e1eb6bef.1669242804.git.josef@toxicpanda.com>
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

