Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F92454DB59
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 09:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359089AbiFPHQR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 03:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359075AbiFPHQJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 03:16:09 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DBC5BE66;
        Thu, 16 Jun 2022 00:16:07 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c21so642528wrb.1;
        Thu, 16 Jun 2022 00:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9CEbBJBMqTTLdgEBo+YkcFADCtrWK80+bti/fX3CZg=;
        b=V1R/wJR9YRvV+84FkNElR3q++s5xNjvbw+4nxp4TvXG/knaq5qduOEn6pxURdpT8bf
         NtsYWxT8ME60Zi3uaZdDNKrk8AZvmHURGa3oYX5pFnTAsN3gc+/QZRBNljaumpgf5052
         F/mT8XSKOyXnumqZjeSTx3RYWgRwIX+huoyUHzHbSlKcP9ij6qZniYDFL3cyNo2PqyT0
         Cu96MwCU42HmEAUPGnx16yd+AFMvaH8jMpE7+GSc3U6cv/J/hydnyBLGkVUx5Fc7XnW6
         hqCAgMFZ0T6ahfL3wVM3Ntj9gG5ZDT4qAmOnNxMB/sf3pryI3mZKlxs85yN8seLCIZlA
         nhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o9CEbBJBMqTTLdgEBo+YkcFADCtrWK80+bti/fX3CZg=;
        b=Re8N+u2cMePtnapt/Kjxgfo3RfNu9ufWRhjY+aY61y5KKYuoUFXKFI5jyVpQ64YaQ7
         bOKLwqKG127yumjgYgeLO2PGfTslXb+U7F3k+Dlr2NXScZ5vU3eupBsfAP8N2ESsFPGy
         rLCgHG1x8Wxw/T+zs5zOvyX82NUVymYGaA4gximxaaD3lLPT4oEqujuqETpRsoI2CFZx
         EOoG+VD90IYPhEpsjuaVUnL8TiniimQM0fSCxdKSxpbZNP2wQO7PZ8qJJLXCbwVhsBh9
         Y7kuhpjjWegxR/amD2qylvlzkqnBLS4CAJ59rByss13n6o3kCU6hqQWqezoGy+RqhQgd
         xdAw==
X-Gm-Message-State: AJIora9estynnkd2HBb5xL2ud/lKY+tpVNXLEsfaTe71CDfojsPF6JZA
        YnUHMtaSDlNCvyHWJgn4wm8=
X-Google-Smtp-Source: AGRyM1tW5YGEzfUQ55MrqGUZMrZZ0EHQA37C0a0j9DFbwNYNcPvR8lTQIMNUUeYfo7Dfb+tJO6o6iA==
X-Received: by 2002:a5d:68d2:0:b0:210:31cc:64a6 with SMTP id p18-20020a5d68d2000000b0021031cc64a6mr3245337wrw.679.1655363765892;
        Thu, 16 Jun 2022 00:16:05 -0700 (PDT)
Received: from localhost.localdomain (host-87-16-96-199.retail.telecomitalia.it. [87.16.96.199])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c4d0a000000b003942a244ee6sm1242770wmh.43.2022.06.16.00.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 00:16:04 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Filipe Manana <fdmanana@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v3 2/2] btrfs: Replace kmap() with kmap_local_page() in zstd.c
Date:   Thu, 16 Jun 2022 09:15:51 +0200
Message-Id: <20220616071551.12602-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616071551.12602-1-fmdefrancesco@gmail.com>
References: <20220616071551.12602-1-fmdefrancesco@gmail.com>
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

Tested with xfstests on QEMU + KVM 32 bits VM with 4GB of RAM and
HIGHMEM64G enabled. These changes passed all tests of the "compress" group.

Cc: Filipe Manana <fdmanana@kernel.org>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v2->v3: Remove unnecessary casts to arguments of kunmap_local() now that
	this API can take pointers to const void.

v1->v2: No changes.

Thanks to Ira Weiny for his invaluable help and persevering support.
Thanks also to Filipe Manana for identifying a fundamental detail I had
overlooked in RFC:
https://lore.kernel.org/lkml/20220611093411.GA3779054@falcondesktop/


 fs/btrfs/zstd.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 0fe31a6f6e68..5d2ab0bac9d2 100644
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
+			kunmap_local(workspace->in_buf.src);
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
+		kunmap_local(workspace->in_buf.src);
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
+			kunmap_local(workspace->in_buf.src);
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
+		kunmap_local(workspace->in_buf.src);
 	return ret;
 }
 
-- 
2.36.1

