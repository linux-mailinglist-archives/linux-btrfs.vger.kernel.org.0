Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C7A5659B5
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 17:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbiGDPXq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 11:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiGDPXn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 11:23:43 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD1ADEC9;
        Mon,  4 Jul 2022 08:23:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u12-20020a05600c210c00b003a02b16d2b8so5869403wml.2;
        Mon, 04 Jul 2022 08:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dqpZiR9EMoPoF97PAZqOh66fKxh4BpbCt/ICCQKrvF0=;
        b=HaytmN0zSS6r8LmkJZq70cytlyB5alsG72DRInTei3zZ6TR+IrKiZejsQ0NfuNfPcp
         PlTz8p5Q0AOlCQyK6OB+gCgXKJDF+Er6hCjuXVjgUV0iotSWmEDXiXfOTOJwXBgFHkIq
         mK7jEb7t03mgIFWp/Bbf+KFEntQ5Ll+0aT7rpPoALj5RyQ+rK2EZkm+3G91g36FUTlXR
         1dxuu9Jq66ppJZwBErOLyD2n1ffggu95zZKVO43wLDL+PjceV8MN0gUbcEULEyUyNzMf
         6Lvg9dt+YPOmD1/tzzT8HOpiTcYBFkx3IZGV/Ti3ECCqwaTFdalZbm8+8/YS3aMnsrFA
         SYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dqpZiR9EMoPoF97PAZqOh66fKxh4BpbCt/ICCQKrvF0=;
        b=CrlImFeD9WsH5A4eijXfLuTzlgXz9o/DJOp7HSObmfLzirkI7rpEH9At2Hr0dLoZlm
         WzUCMufijFXrePw30ucRxsf6UpYs6oDg0QpFW4nL2POw9sHz7sG486n5Q16AS6ULnWp4
         oALsN9gKxrNlD3hcS4Ggm80tr1+Md+N491LgsTcusRYjy1OKtNMFhjHwqd5rCjY1f/Gt
         8gvJ0eYY1icBSD4R3mfF+TtVsvgCe3cBOLlxEkIlRufSreMWNQ4h0RIELjhPZeeZ61Ij
         Two/4O24RDclLfZzzpTJSLKZkoLdlE7FYcq17q1GTFzXNtgY8eNfI0k1LPcFN+1b8sWM
         QHwA==
X-Gm-Message-State: AJIora/qNKYs5rNRRKas8glBOdVcrTuMHfsm5l1l9Qf919unEq379kL4
        GpFT1HapVVztgbGKnpxAE4Q=
X-Google-Smtp-Source: AGRyM1tQdcBc1Lj07OU8V4Z3ztHPVSogHdkYicU5Wg9dwV7uUcryGx8jYb43vi129HnZd9yAqtFIZw==
X-Received: by 2002:a05:600c:2051:b0:3a0:3c58:6ff6 with SMTP id p17-20020a05600c205100b003a03c586ff6mr32713888wmg.98.1656948221471;
        Mon, 04 Jul 2022 08:23:41 -0700 (PDT)
Received: from localhost.localdomain (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id p28-20020a1c545c000000b003a02de5de80sm16089631wmi.4.2022.07.04.08.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 08:23:39 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "James E. J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        linux-parisc@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Filipe Manana <fdmanana@kernel.org>
Subject: [PATCH v5 2/2] btrfs: Replace kmap() with kmap_local_page() in zstd.c
Date:   Mon,  4 Jul 2022 17:23:22 +0200
Message-Id: <20220704152322.20955-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704152322.20955-1-fmdefrancesco@gmail.com>
References: <20220704152322.20955-1-fmdefrancesco@gmail.com>
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

Therefore, use kmap_local_page() / kunmap_local() in zstd.c because in this
file the mappings are per thread and are not visible in other contexts. In
the meanwhile use plain page_address() on pages allocated with the GFP_NOFS
flag instead of calling kmap*() on them (since they are always allocated
from ZONE_NORMAL).

Tested with xfstests on QEMU + KVM 32 bits VM with 4GB of RAM and
booting a kernel with HIGHMEM64G enabled.

Cc: Filipe Manana <fdmanana@kernel.org>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/btrfs/zstd.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 0fe31a6f6e68..78e0272e770e 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -403,7 +403,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 
 	/* map in the first page of input data */
 	in_page = find_get_page(mapping, start >> PAGE_SHIFT);
-	workspace->in_buf.src = kmap(in_page);
+	workspace->in_buf.src = kmap_local_page(in_page);
 	workspace->in_buf.pos = 0;
 	workspace->in_buf.size = min_t(size_t, len, PAGE_SIZE);
 
@@ -415,7 +415,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 		goto out;
 	}
 	pages[nr_pages++] = out_page;
-	workspace->out_buf.dst = kmap(out_page);
+	workspace->out_buf.dst = page_address(out_page);
 	workspace->out_buf.pos = 0;
 	workspace->out_buf.size = min_t(size_t, max_out, PAGE_SIZE);
 
@@ -450,9 +450,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 		if (workspace->out_buf.pos == workspace->out_buf.size) {
 			tot_out += PAGE_SIZE;
 			max_out -= PAGE_SIZE;
-			kunmap(out_page);
 			if (nr_pages == nr_dest_pages) {
-				out_page = NULL;
 				ret = -E2BIG;
 				goto out;
 			}
@@ -462,7 +460,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 				goto out;
 			}
 			pages[nr_pages++] = out_page;
-			workspace->out_buf.dst = kmap(out_page);
+			workspace->out_buf.dst = page_address(out_page);
 			workspace->out_buf.pos = 0;
 			workspace->out_buf.size = min_t(size_t, max_out,
 							PAGE_SIZE);
@@ -477,15 +475,15 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 		/* Check if we need more input */
 		if (workspace->in_buf.pos == workspace->in_buf.size) {
 			tot_in += PAGE_SIZE;
-			kunmap(in_page);
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
+			workspace->out_buf.dst = page_address(out_page);
 		}
 	}
 	while (1) {
@@ -510,9 +508,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 
 		tot_out += PAGE_SIZE;
 		max_out -= PAGE_SIZE;
-		kunmap(out_page);
 		if (nr_pages == nr_dest_pages) {
-			out_page = NULL;
 			ret = -E2BIG;
 			goto out;
 		}
@@ -522,7 +518,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 			goto out;
 		}
 		pages[nr_pages++] = out_page;
-		workspace->out_buf.dst = kmap(out_page);
+		workspace->out_buf.dst = page_address(out_page);
 		workspace->out_buf.pos = 0;
 		workspace->out_buf.size = min_t(size_t, max_out, PAGE_SIZE);
 	}
@@ -537,13 +533,10 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 	*total_out = tot_out;
 out:
 	*out_pages = nr_pages;
-	/* Cleanup */
-	if (in_page) {
-		kunmap(in_page);
+	if (workspace->in_buf.src) {
+		kunmap_local(workspace->in_buf.src);
 		put_page(in_page);
 	}
-	if (out_page)
-		kunmap(out_page);
 	return ret;
 }
 
@@ -567,7 +560,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		goto done;
 	}
 
-	workspace->in_buf.src = kmap(pages_in[page_in_index]);
+	workspace->in_buf.src = kmap_local_page(pages_in[page_in_index]);
 	workspace->in_buf.pos = 0;
 	workspace->in_buf.size = min_t(size_t, srclen, PAGE_SIZE);
 
@@ -603,14 +596,15 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
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
@@ -619,7 +613,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	zero_fill_bio(cb->orig_bio);
 done:
 	if (workspace->in_buf.src)
-		kunmap(pages_in[page_in_index]);
+		kunmap_local(workspace->in_buf.src);
 	return ret;
 }
 
-- 
2.36.1

