Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9747C54DC9B
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 10:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359673AbiFPIMH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 04:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359662AbiFPIMF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 04:12:05 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2660D5D658;
        Thu, 16 Jun 2022 01:12:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so428893wms.3;
        Thu, 16 Jun 2022 01:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IpTr1iwz7d98pqMzRt5Ihqw6LdIAcQBAhe8eExhGZJg=;
        b=VQbyam1qBL5Gr5PLIlt9qmRQK2vLFBInE12SltwsOF97KzCwgsDUYYJM8Uq8FQt/Kl
         8wurLxkCIebCYaPJ4lJ82t7t68ZzdGQP6AsxjaCFykuD9J7Adl21SJMmm7/edoVwb1VP
         5sK/O3t2c2mYz44CIogf+EWvEHsc0flbYNns+r2pLLBZ9dUPLKShJIRrJr2Fh5cciVEv
         FgD3wYucQrcB5mZQUrL6wltC9tE/CbPQy7j84MQ3r83wcca1N5pZD5TNV8qQSaP1IKDr
         PQ4ul/9cnJGB8r5jjsZw/3RRMcK/W685W3W5kJ6XgDdrg5UbIhtxFJoYiqtAbKlT8zwt
         WafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IpTr1iwz7d98pqMzRt5Ihqw6LdIAcQBAhe8eExhGZJg=;
        b=yDTsqYjDlVbi1ru7aRXWVF1kOArO0Zk8Ysq+LtOquiaTczDunkUzS/dB5zu7Otg9B1
         0XbihrLauxkpSHOt1pLKhPJ8AArm2bN3gppv1MoUIP3Py3I4LAl+qklrSWS8A7EA3V8P
         pHl0KVm1pCyYzmNRYwpRTYiEcXJ1NaXIQDMBrCUzrMG7JmQigXefbiVXhIBndgKoq/nP
         ipQNMd85qZbq9hai5l1qyZFO1afrW1HwCss+o8og32gOE720901A9h9fx94TaeEdmJwR
         g2lbQIICzMcKD7HkdiFo5u1PTAwgsntlhnIN7eShsxYKf/URkkAdgJRwqOQLrD3+Dj0Q
         qyuQ==
X-Gm-Message-State: AOAM530XEIBPAGPkCSwVUIPlzUzTwo1Vpvj82JgU5SO8XWFQXnH+5u74
        giuxYoK8zvrDBwsMHreTdVU=
X-Google-Smtp-Source: ABdhPJz7VRFyc4o+WWKgdSnWgrg4N1WpI6iS23ePKwbVfoByQznstK/Rd7j1JO/KsvLQWWYm6ONqag==
X-Received: by 2002:a05:600c:2197:b0:39c:5e32:be2c with SMTP id e23-20020a05600c219700b0039c5e32be2cmr14574346wme.41.1655367122629;
        Thu, 16 Jun 2022 01:12:02 -0700 (PDT)
Received: from localhost.localdomain (host-87-16-96-199.retail.telecomitalia.it. [87.16.96.199])
        by smtp.gmail.com with ESMTPSA id o18-20020a5d6852000000b0021552eebde6sm1121807wrw.32.2022.06.16.01.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 01:12:01 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        linux-parisc@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Filipe Manana <fdmanana@kernel.org>
Subject: [PATCH v3 2/2] btrfs: Replace kmap() with kmap_local_page() in zstd.c
Date:   Thu, 16 Jun 2022 10:11:33 +0200
Message-Id: <20220616081133.14144-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616081133.14144-1-fmdefrancesco@gmail.com>
References: <20220616081133.14144-1-fmdefrancesco@gmail.com>
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

v3->v4: Cc Maintainers and lists that had been overlooked when v3 was
	sent (mostly regarding patch 1/2).

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

