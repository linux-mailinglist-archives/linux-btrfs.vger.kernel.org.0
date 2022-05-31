Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DFF539368
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 16:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345370AbiEaOxz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 10:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345364AbiEaOxy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 10:53:54 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5246AE0BC;
        Tue, 31 May 2022 07:53:53 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w27so11202808edl.7;
        Tue, 31 May 2022 07:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CK4EoL0eO3JAVfR/tGGITzcTWVmopSHu4SA20EXBoL4=;
        b=e9pOFT8pI0LVuJDcKzGp27du6GMOJMIT4IHspxByeu5fE8kG7sID5NFZQG6X8E201N
         fDl/yphyH4KqaG3k4lxLBWZMGy9FH9JxDQuTVOdu1Ut+S6aVFZjhQlTrFzeHxL+k0N0s
         JgvPHw6TSL/zV2CbiCM8Ur32sH+MW9tYLFjoJ8EH4/S59JOro7/V57HmhF6SefT+t5Lk
         P92netDr6ol48yiAftbWvVF/7bEgyScBpZBPIkbbQN16d9P9K/qmU0yKBnoGvgQW04yt
         N/AUGvpsQWKKstGnmvf2o8mtamzAfKgGvBrrg+wRkfdyVfXYmUDpwqJsfGkZJaLPCJCF
         zvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CK4EoL0eO3JAVfR/tGGITzcTWVmopSHu4SA20EXBoL4=;
        b=4NzxluNhHi9UqNt2OsGXEmusBP6ZrAi8cFqqXwMJ7E6ueerA7L1O1muOHO6oYJ27i3
         Mc7eUvswIhjJZOGdUsEWhXJeA+vahwO/672jn4SwFwME4aMUzTji13nMVXTopECfI5+2
         uSXrSOTHLD+vaJhgkbvpQVBE3CutpRSwkJBRcDlx4IXkxf/x0f07oj8wjB1Uc27Uyz49
         Qryu/3Tgo1IgAXDXssg8uvn+jWa3Lg6hJj9j78i6jXp8S0kK7nbfCkxbkvWvVd+zzDrE
         8z8nFH4rrmjg1MCbcfhu2ocgyJFHhkkCRskMrnB00mBVKii4Ee2LwFweTjT7DyVnJXo1
         Bm7w==
X-Gm-Message-State: AOAM5333xaOL85R00LNy88Th87/wP1YuUUhxtL2aLMJyYscsetsVNPQB
        2QI9JE3Ga1HoxdNuQz2RjEk=
X-Google-Smtp-Source: ABdhPJy7NoEBxoXFG4DAUa0ObJAScQFVwz0HGQHCjHChXKWl8RjpueAlKg1anmPhAB1zT1C6W9mlrA==
X-Received: by 2002:a05:6402:254e:b0:42b:4633:e53e with SMTP id l14-20020a056402254e00b0042b4633e53emr52402720edb.314.1654008831824;
        Tue, 31 May 2022 07:53:51 -0700 (PDT)
Received: from localhost.localdomain (host-79-55-12-155.retail.telecomitalia.it. [79.55.12.155])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090603c200b006fea59ef3a5sm5099779eja.32.2022.05.31.07.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 07:53:50 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 2/3] btrfs: Replace kmap() with kmap_local_page() in lzo.c
Date:   Tue, 31 May 2022 16:53:34 +0200
Message-Id: <20220531145335.13954-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531145335.13954-1-fmdefrancesco@gmail.com>
References: <20220531145335.13954-1-fmdefrancesco@gmail.com>
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

The use of kmap() is being deprecated in favor of kmap_local_page() where
it is feasible. With kmap_local_page(), the mapping is per thread, CPU
local and not globally visible.

Therefore, use kmap_local_page() / kunmap_local() in lzo.c wherever the
mappings are per thread and not globally visible.

Tested on QEMU + KVM 32 bits VM with 4GB of RAM and HIGHMEM64G enabled.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/btrfs/lzo.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 430ad36b8b08..89bc5f825e0a 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -155,7 +155,7 @@ static int copy_compressed_data_to_page(char *compressed_data,
 		out_pages[*cur_out / PAGE_SIZE] = cur_page;
 	}
 
-	kaddr = kmap(cur_page);
+	kaddr = kmap_local_page(cur_page);
 	write_compress_length(kaddr + offset_in_page(*cur_out),
 			      compressed_size);
 	*cur_out += LZO_LEN;
@@ -167,7 +167,7 @@ static int copy_compressed_data_to_page(char *compressed_data,
 		u32 copy_len = min_t(u32, sectorsize - *cur_out % sectorsize,
 				     orig_out + compressed_size - *cur_out);
 
-		kunmap(cur_page);
+		kunmap_local(kaddr);
 
 		if ((*cur_out / PAGE_SIZE) >= max_nr_page)
 			return -E2BIG;
@@ -180,7 +180,7 @@ static int copy_compressed_data_to_page(char *compressed_data,
 				return -ENOMEM;
 			out_pages[*cur_out / PAGE_SIZE] = cur_page;
 		}
-		kaddr = kmap(cur_page);
+		kaddr = kmap_local_page(cur_page);
 
 		memcpy(kaddr + offset_in_page(*cur_out),
 		       compressed_data + *cur_out - orig_out, copy_len);
@@ -202,7 +202,7 @@ static int copy_compressed_data_to_page(char *compressed_data,
 	*cur_out += sector_bytes_left;
 
 out:
-	kunmap(cur_page);
+	kunmap_local(kaddr);
 	return 0;
 }
 
@@ -248,12 +248,12 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 		/* Compress at most one sector of data each time */
 		in_len = min_t(u32, start + len - cur_in, sectorsize - sector_off);
 		ASSERT(in_len);
-		data_in = kmap(page_in);
+		data_in = kmap_local_page(page_in);
 		ret = lzo1x_1_compress(data_in +
 				       offset_in_page(cur_in), in_len,
 				       workspace->cbuf, &out_len,
 				       workspace->mem);
-		kunmap(page_in);
+		kunmap_local(data_in);
 		if (ret < 0) {
 			pr_debug("BTRFS: lzo in loop returned %d\n", ret);
 			ret = -EIO;
@@ -310,7 +310,6 @@ static void copy_compressed_segment(struct compressed_bio *cb,
 	u32 orig_in = *cur_in;
 
 	while (*cur_in < orig_in + len) {
-		char *kaddr;
 		struct page *cur_page;
 		u32 copy_len = min_t(u32, PAGE_SIZE - offset_in_page(*cur_in),
 					  orig_in + len - *cur_in);
@@ -318,11 +317,8 @@ static void copy_compressed_segment(struct compressed_bio *cb,
 		ASSERT(copy_len);
 		cur_page = cb->compressed_pages[*cur_in / PAGE_SIZE];
 
-		kaddr = kmap(cur_page);
-		memcpy(dest + *cur_in - orig_in,
-			kaddr + offset_in_page(*cur_in),
-			copy_len);
-		kunmap(cur_page);
+		memcpy_from_page(dest + *cur_in - orig_in, cur_page,
+				 offset_in_page(*cur_in), copy_len);
 
 		*cur_in += copy_len;
 	}
@@ -342,9 +338,9 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	/* Bytes decompressed so far */
 	u32 cur_out = 0;
 
-	kaddr = kmap(cb->compressed_pages[0]);
+	kaddr = kmap_local_page(cb->compressed_pages[0]);
 	len_in = read_compress_length(kaddr);
-	kunmap(cb->compressed_pages[0]);
+	kunmap_local(kaddr);
 	cur_in += LZO_LEN;
 
 	/*
@@ -378,9 +374,9 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		       (cur_in + LZO_LEN - 1) / sectorsize);
 		cur_page = cb->compressed_pages[cur_in / PAGE_SIZE];
 		ASSERT(cur_page);
-		kaddr = kmap(cur_page);
+		kaddr = kmap_local_page(cur_page);
 		seg_len = read_compress_length(kaddr + offset_in_page(cur_in));
-		kunmap(cur_page);
+		kunmap_local(kaddr);
 		cur_in += LZO_LEN;
 
 		if (seg_len > WORKSPACE_CBUF_LENGTH) {
-- 
2.36.1

