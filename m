Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FC15474F7
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jun 2022 15:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbiFKNwV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jun 2022 09:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbiFKNwU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jun 2022 09:52:20 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7D01A38B;
        Sat, 11 Jun 2022 06:52:10 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id q15so774954wmj.2;
        Sat, 11 Jun 2022 06:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wemWetgqZtPAak9UOZsCzxeIqqnM7f9u1LT1EZmm0AA=;
        b=IXckhRk9dBamy/3k8VsroC/1aDkvrqGzOEB5L+4viH34purDQNt3KtuN/MLyivRP1f
         MHWVgY3iWhdkKNaiVjBDHqHnQW34iSrQP+MQtuor8GVZcLfjZkT544djNfNSFrkxVQwN
         gnh2QN9AgKvuZf0FnKxwkNcln+4SfzFEyt6HqiRipJLYEj3XM/yti9Hh0K04OC0aUVD9
         APn6TlL2/QPkFT3lIs3teb+0Rk/lkr2hBL/m50uzcZM0gq+GmOPVPvmS5yVBhkR46hCf
         I/UTWFcqTGp/qv084bemDvFTtCgR8HW8njAdpUe0a2QyvYcjwv7hXycAff3C22PGn4Cp
         ZSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wemWetgqZtPAak9UOZsCzxeIqqnM7f9u1LT1EZmm0AA=;
        b=StlkKWTjppCXkfsan6pluZjl3QqXd+CfqnvV1z4OFfifUWY484BJ3Gdadiu0FhSg7U
         ovHJ+doiedZlXNuD1mSORhnC+QmqPDZKKF6xruFixcoOeTNfVDkGqZL5UBM1v2jfRfTO
         WxzE+oXBCN+a2RVg7w9+gEKY+uI4ixlHRC36WaAaeATkNhd2QPYVqxmeE8XW1L+nW6n3
         eutI5C+OpE9ft2nL+sLxfyLWh8gHlzv4xAbJviAhfoai1onK3Sx2uoAJaQLn3ySWiPEa
         kx5KlWinWn0EtXttvAX/hmqMaG0tKiRX9raYY5VjBJnXJ18cxqWOa0MUHlOERRQRbA4O
         7BvA==
X-Gm-Message-State: AOAM533+goPCmR33yJYOrw4OTfJuToFR08lEuSe2AnwapLOwNnrSxC7j
        GcfGQTi9E9PDde0rEN7pOg7aRot8mXw=
X-Google-Smtp-Source: ABdhPJycO+r/EYhtyb9IIHZ0PRPblJucaFGjJrBITVdzY3qblPPpEgZ4tyz6NnNjNzbUnBd/S95LYw==
X-Received: by 2002:a05:600c:1d1c:b0:39c:7ac8:1faa with SMTP id l28-20020a05600c1d1c00b0039c7ac81faamr5031020wms.202.1654955528462;
        Sat, 11 Jun 2022 06:52:08 -0700 (PDT)
Received: from localhost.localdomain (host-79-18-0-143.retail.telecomitalia.it. [79.18.0.143])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c35d400b0039c1396b495sm2593224wmq.9.2022.06.11.06.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 06:52:07 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Filipe Manana <fdmanana@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] btrfs: Replace kmap() with kmap_local_page() in zstd.c
Date:   Sat, 11 Jun 2022 15:52:03 +0200
Message-Id: <20220611135203.27992-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The use of kmap() is being deprecated in favor of kmap_local_page(). With
kmap_local_page(), the mapping is per thread, CPU local and not globally
visible.

Therefore, use kmap_local_page() / kunmap_local() in zstd.c because in
this file the mappings are per thread and are not visible in other
contexts; meanwhile refactor zstd_compress_pages() to comply with nested
local mapping / unmapping ordering rules.

Tested with xfstests on a QEMU + KVM 32 bits VM with 4GB of RAM and
HIGHMEM64G enabled.

Cc: Filipe Manana <fdmanana@kernel.org>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Thanks to Ira Weiny for his invaluable help and persevering support.
Thanks also to Filipe Manana for identifying a fundamental detail I had overlooked:
https://lore.kernel.org/lkml/20220611093411.GA3779054@falcondesktop/ 

tweed32:/usr/lib/xfstests # ./check -g compress
FSTYP         -- btrfs
PLATFORM      -- Linux/i686 tweed32 5.19.0-rc1-vanilla-debug+ #22 SMP PREEMPT_DYNAMIC Sat Jun 11 14:31:39 CEST 2022
MKFS_OPTIONS  -- /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

btrfs/024 1s ...  0s
btrfs/026 3s ...  3s
btrfs/037 1s ...  1s
btrfs/038 1s ...  0s
btrfs/041 0s ...  1s
btrfs/062 34s ...  35s
btrfs/063 18s ...  18s
btrfs/067 33s ...  32s
btrfs/068 10s ...  10s
btrfs/070       [not run] btrfs and this test needs 5 or more disks in SCRATCH_DEV_POOL
btrfs/071       [not run] btrfs and this test needs 5 or more disks in SCRATCH_DEV_POOL
btrfs/072 33s ...  33s
btrfs/073 17s ...  15s
btrfs/074 36s ...  32s
btrfs/076 0s ...  0s
btrfs/103 1s ...  1s
btrfs/106 1s ...  1s
btrfs/109 1s ...  0s
btrfs/113 0s ...  1s
btrfs/138 43s ...  46s
btrfs/149 1s ...  1s
btrfs/183 1s ...  1s
btrfs/205 1s ...  1s
btrfs/234 3s ...  3s
btrfs/246 0s ...  0s
btrfs/251 1s ...  1s
Ran: btrfs/024 btrfs/026 btrfs/037 btrfs/038 btrfs/041 btrfs/062 btrfs/063 btrfs/067 btrfs/068 btrfs/070 btrfs/071 btrfs/072 btrfs/073 btrfs/074 btrfs/076 btrfs/103 btrfs/106 btrfs/109 btrfs/113 btrfs/138 btrfs/149 btrfs/183 btrfs/205 btrfs/234 btrfs/246 btrfs/251
Not run: btrfs/070 btrfs/071
Passed all 26 tests

 fs/btrfs/zstd.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 0fe31a6f6e68..4d50eb3edce5 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -391,6 +391,8 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 	*out_pages = 0;
 	*total_out = 0;
 	*total_in = 0;
+	workspace->in_buf.src = NULL;
+	workspace->out_buf.dst = NULL;
 
 	/* Initialize the stream */
 	stream = zstd_init_cstream(&params, len, workspace->mem,
@@ -403,7 +405,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 
 	/* map in the first page of input data */
 	in_page = find_get_page(mapping, start >> PAGE_SHIFT);
-	workspace->in_buf.src = kmap(in_page);
+	workspace->in_buf.src = kmap_local_page(in_page);
 	workspace->in_buf.pos = 0;
 	workspace->in_buf.size = min_t(size_t, len, PAGE_SIZE);
 
@@ -415,7 +417,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 		goto out;
 	}
 	pages[nr_pages++] = out_page;
-	workspace->out_buf.dst = kmap(out_page);
+	workspace->out_buf.dst = kmap_local_page(out_page);
 	workspace->out_buf.pos = 0;
 	workspace->out_buf.size = min_t(size_t, max_out, PAGE_SIZE);
 
@@ -450,9 +452,9 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 		if (workspace->out_buf.pos == workspace->out_buf.size) {
 			tot_out += PAGE_SIZE;
 			max_out -= PAGE_SIZE;
-			kunmap(out_page);
+			kunmap_local(workspace->out_buf.dst);
 			if (nr_pages == nr_dest_pages) {
-				out_page = NULL;
+				workspace->out_buf.dst = NULL;
 				ret = -E2BIG;
 				goto out;
 			}
@@ -462,7 +464,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 				goto out;
 			}
 			pages[nr_pages++] = out_page;
-			workspace->out_buf.dst = kmap(out_page);
+			workspace->out_buf.dst = kmap_local_page(out_page);
 			workspace->out_buf.pos = 0;
 			workspace->out_buf.size = min_t(size_t, max_out,
 							PAGE_SIZE);
@@ -477,15 +479,16 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 		/* Check if we need more input */
 		if (workspace->in_buf.pos == workspace->in_buf.size) {
 			tot_in += PAGE_SIZE;
-			kunmap(in_page);
+			kunmap_local(workspace->out_buf.dst);
+			kunmap_local((void *)workspace->in_buf.src);
 			put_page(in_page);
-
 			start += PAGE_SIZE;
 			len -= PAGE_SIZE;
 			in_page = find_get_page(mapping, start >> PAGE_SHIFT);
-			workspace->in_buf.src = kmap(in_page);
+			workspace->in_buf.src = kmap_local_page(in_page);
 			workspace->in_buf.pos = 0;
 			workspace->in_buf.size = min_t(size_t, len, PAGE_SIZE);
+			workspace->out_buf.dst = kmap_local_page(out_page);
 		}
 	}
 	while (1) {
@@ -510,9 +513,9 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 
 		tot_out += PAGE_SIZE;
 		max_out -= PAGE_SIZE;
-		kunmap(out_page);
+		kunmap_local(workspace->out_buf.dst);
 		if (nr_pages == nr_dest_pages) {
-			out_page = NULL;
+			workspace->out_buf.dst = NULL;
 			ret = -E2BIG;
 			goto out;
 		}
@@ -522,7 +525,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 			goto out;
 		}
 		pages[nr_pages++] = out_page;
-		workspace->out_buf.dst = kmap(out_page);
+		workspace->out_buf.dst = kmap_local_page(out_page);
 		workspace->out_buf.pos = 0;
 		workspace->out_buf.size = min_t(size_t, max_out, PAGE_SIZE);
 	}
@@ -538,12 +541,12 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 out:
 	*out_pages = nr_pages;
 	/* Cleanup */
-	if (in_page) {
-		kunmap(in_page);
+	if (workspace->out_buf.dst)
+		kunmap_local(workspace->out_buf.dst);
+	if (workspace->in_buf.src) {
+		kunmap_local((void *)workspace->in_buf.src);
 		put_page(in_page);
 	}
-	if (out_page)
-		kunmap(out_page);
 	return ret;
 }
 
@@ -567,7 +570,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		goto done;
 	}
 
-	workspace->in_buf.src = kmap(pages_in[page_in_index]);
+	workspace->in_buf.src = kmap_local_page(pages_in[page_in_index]);
 	workspace->in_buf.pos = 0;
 	workspace->in_buf.size = min_t(size_t, srclen, PAGE_SIZE);
 
@@ -603,14 +606,15 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 			break;
 
 		if (workspace->in_buf.pos == workspace->in_buf.size) {
-			kunmap(pages_in[page_in_index++]);
+			kunmap_local((void *)workspace->in_buf.src);
+			page_in_index++;
 			if (page_in_index >= total_pages_in) {
 				workspace->in_buf.src = NULL;
 				ret = -EIO;
 				goto done;
 			}
 			srclen -= PAGE_SIZE;
-			workspace->in_buf.src = kmap(pages_in[page_in_index]);
+			workspace->in_buf.src = kmap_local_page(pages_in[page_in_index]);
 			workspace->in_buf.pos = 0;
 			workspace->in_buf.size = min_t(size_t, srclen, PAGE_SIZE);
 		}
@@ -619,7 +623,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	zero_fill_bio(cb->orig_bio);
 done:
 	if (workspace->in_buf.src)
-		kunmap(pages_in[page_in_index]);
+		kunmap_local((void *)workspace->in_buf.src);
 	return ret;
 }
 
-- 
2.36.1

