Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66794B18B2
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 23:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345173AbiBJWoj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 17:44:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243725AbiBJWog (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 17:44:36 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33BC5589
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 14:44:36 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id a28so6616987qvb.10
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 14:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UyDmzE1qbH53wkgAFb93nw7xSCq/fAv4A45UJXF1vSY=;
        b=oWrpZo65scaaDod6t99/Rj0lX59KbGyRteSpB5cczXSqA58/yLMCMX6k/o0fzvhzgK
         Jnzs7Pl5mKidGOORCZtdWpuIWOHdlthiTASOLMHWA2Q1Qy/x2sSsUUdrM1TLMWbI0mZp
         RdpxaewgdHXKCZfD7Yup2/6PiYdYkWCvGV4JoXpdlkka7O/MdsGTDqGvr0qsvowQOpkg
         HMirP3NzhL/xHdvt3nUEDEhSxqOvWWk4iKkpt4Jmz/aonileFZlKgYVJuMXPINR67W0P
         9tpyxOfzuJpvdX7lV7SsJgdetZ8XZFrD/MSkW+oPzlsgoeuhLeA/sgs8Wh0P/PcJNYav
         e6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UyDmzE1qbH53wkgAFb93nw7xSCq/fAv4A45UJXF1vSY=;
        b=FQqNvms6RnoVi2liWPDug0+AQJqIhhTMUMHjU9jhbAJTYH1KznlcBWrMlakLXGcMCF
         hCJukf6GCdCj57vre3r95u7YnvDjB3ZgS+bEroCYjvrKBEdkWbvOPV6aUZAe2avXXMX6
         DpYqt7LjasbMsM+gXNwiJAuiZNVHUzaGdn3ZLki7AWMvObQX0enKXW4ssTdBJ6WR3opW
         dmT1UY8RJy6N9PUczBOhdQPTxuvBYEo6dBVfoIjlbXqZ464FQ7+R9GkQJpoUzoMObTpD
         bpPsbjTfWr+VZHqeSDSbchWTT0mZlJyAIBdWH2GQfojksTUR3G1aT9W1yyFeVSJUL/r5
         Y49w==
X-Gm-Message-State: AOAM533t7C+/bh2YKod4AlPXYiQVoOGjV8FIJg/97EKP7EcqrREDi+ou
        RL2Myfjc+++eFtmoDkBi0w2tvl0pxUMzvchV
X-Google-Smtp-Source: ABdhPJxg+8ntenqxPVV3YmGI0PI/jz0IyNsvPiPjjbeI37yX/LSonO0ATZqZXk0RHzFO0Kat7BNLHg==
X-Received: by 2002:ad4:5deb:: with SMTP id jn11mr6704176qvb.120.1644533075861;
        Thu, 10 Feb 2022 14:44:35 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b16sm11007108qtk.84.2022.02.10.14.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:44:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/8] btrfs: do not double complete bio on errors during compressed reads
Date:   Thu, 10 Feb 2022 17:44:24 -0500
Message-Id: <800ebbe66b4998ec1ac7122cc201c4404d737f18.1644532798.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1644532798.git.josef@toxicpanda.com>
References: <cover.1644532798.git.josef@toxicpanda.com>
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

I hit some weird panics while fixing up the error handling from
btrfs_lookup_bio_sums().  Turns out the compression path will complete
the bio we use if we set up any of the compression bios and then return
an error, and then btrfs_submit_data_bio() will also call bio_endio() on
the bio.

Fix this by making btrfs_submit_compressed_read() responsible for
calling bio_endio() on the bio if there are any errors.  Currently it
was only doing it if we created the compression bios, otherwise it was
depending on btrfs_submit_data_bio() to do the right thing.  This
creates the above problem, so fix up btrfs_submit_compressed_read() to
always call bio_endio() in case of an error, and then simply return from
btrfs_submit_data_bio() if we had to call
btrfs_submit_compressed_read().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/compression.c | 14 +++++++++-----
 fs/btrfs/inode.c       | 12 ++++++++----
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index ee1c6f870a03..9551658ac3a1 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -808,7 +808,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	u64 em_len;
 	u64 em_start;
 	struct extent_map *em;
-	blk_status_t ret = BLK_STS_RESOURCE;
+	blk_status_t ret;
 	int faili = 0;
 	u8 *sums;
 
@@ -821,9 +821,12 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	read_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, file_offset, fs_info->sectorsize);
 	read_unlock(&em_tree->lock);
-	if (!em)
-		return BLK_STS_IOERR;
+	if (!em) {
+		ret = BLK_STS_IOERR;
+		goto out;
+	}
 
+	ret = BLK_STS_RESOURCE;
 	ASSERT(em->compress_type != BTRFS_COMPRESS_NONE);
 	compressed_len = em->block_len;
 	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
@@ -858,7 +861,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		cb->compressed_pages[pg_index] = alloc_page(GFP_NOFS);
 		if (!cb->compressed_pages[pg_index]) {
 			faili = pg_index - 1;
-			ret = BLK_STS_RESOURCE;
 			goto fail2;
 		}
 	}
@@ -938,7 +940,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			comp_bio = NULL;
 		}
 	}
-	return 0;
+	return BLK_STS_OK;
 
 fail2:
 	while (faili >= 0) {
@@ -951,6 +953,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	kfree(cb);
 out:
 	free_extent_map(em);
+	bio->bi_status = ret;
+	bio_endio(bio);
 	return ret;
 finish_cb:
 	if (comp_bio) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 24099fe9e120..69fa71186e72 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2542,10 +2542,14 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 			goto out;
 
 		if (bio_flags & EXTENT_BIO_COMPRESSED) {
-			ret = btrfs_submit_compressed_read(inode, bio,
-							   mirror_num,
-							   bio_flags);
-			goto out;
+			/*
+			 * btrfs_submit_compressed_read will handle completing
+			 * the bio if there were any errors, so just return
+			 * here.
+			 */
+			return btrfs_submit_compressed_read(inode, bio,
+							    mirror_num,
+							    bio_flags);
 		} else {
 			/*
 			 * Lookup bio sums does extra checks around whether we
-- 
2.26.3

