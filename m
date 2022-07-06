Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F58E56868C
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 13:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiGFLPh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 07:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiGFLPf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 07:15:35 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA3D27FC9;
        Wed,  6 Jul 2022 04:15:34 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b26so21599610wrc.2;
        Wed, 06 Jul 2022 04:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=niVwwgyPI5g9Z7n7TEokSXWWLyf66aMv7zsWLvy4BA4=;
        b=RrQp/binz0VbQrxecSi2P0fVnvwi0uACybF3/YorN1BqeSR6f0wEQq0s2Jv2Hh+jop
         3WguWhb+CcOyGnh7kMu4zCsDNIBWj9SGrSdrI7epqys4jKZre+g4gyC4oiI8gDa7cf6J
         3CetJ0cl7/L44iGBxrxYnCU39XqVYucfe5PT3UFH3B/TdLhCwi1rL+bb32vIgGbIyY1t
         JaHHLr1M+qYxwa6Mg3tnLc6JhQqb1lpT9HTA0uDymMNOcf99uhzCqlcNUsonImys16xd
         DM+6Kq49GXquSRj6gPdNNp2yjULACSCnp1lZhGFuNlxRTz21VHPI+gDBz5hgrUNMirlB
         ZEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=niVwwgyPI5g9Z7n7TEokSXWWLyf66aMv7zsWLvy4BA4=;
        b=j4TNTlajgiUEJRugwVmXvB9BC67iWuPa8fQKnGhsywfDvsC4oYJuo2fDv/z3eXyZfG
         tJumKnIPY2bjMo2enhpNysyW7Oy9cn9n+1OjNUZ9io6ovEU+3SHHxkGtlvIUlMT46moY
         R6lpB4IdRsvxTnck9GKEGPYnc92t1+I0Dj40NxP6W3t9IVEodKRH2M+80KrNPUfsAp15
         9aKYGE6FMvSS7oknt1y4fgQUKitZr/5cW7tELzDTrBQc1M40J+68H8Kf+GgS4bSHFCmf
         nwXUPPrpTV44xz6Wo405oOZ+Wui9RFvhsb6Yopwd9sccZKfQDlNaR7v9hPwRUzyEKZ+i
         LDqA==
X-Gm-Message-State: AJIora8mEQZGM3DXyvnd2/3/LSPC3xTkL1mc2wHcOTiOkvypyNb2PicV
        wboU5a1cg8Ucp3rBNXrmd28=
X-Google-Smtp-Source: AGRyM1sCRkHNU5DKUc1bbWrCxoR7ukoiDZt7Ny2+aZ/pNySHWQ1/b7JGhwQiFZcLA5cU20pOFnmy1Q==
X-Received: by 2002:adf:f1d1:0:b0:21d:7f88:d638 with SMTP id z17-20020adff1d1000000b0021d7f88d638mr1232090wro.586.1657106133302;
        Wed, 06 Jul 2022 04:15:33 -0700 (PDT)
Received: from localhost.localdomain (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id k1-20020adff5c1000000b0020d07d90b71sm34830696wrp.66.2022.07.06.04.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 04:15:31 -0700 (PDT)
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
Subject: [PATCH v6 2/2] btrfs: Replace kmap() with kmap_local_page() in zstd.c
Date:   Wed,  6 Jul 2022 13:15:20 +0200
Message-Id: <20220706111520.12858-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220706111520.12858-1-fmdefrancesco@gmail.com>
References: <20220706111520.12858-1-fmdefrancesco@gmail.com>
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

Tested with xfstests on QEMU + KVM 32 bits VM with 4GB of RAM, booting a
kernel with HIGHMEM64G enabled.

Cc: Filipe Manana <fdmanana@kernel.org>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/btrfs/zstd.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 0fe31a6f6e68..35a0224d4eb7 100644
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
@@ -477,13 +475,12 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
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
 		}
@@ -510,9 +507,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 
 		tot_out += PAGE_SIZE;
 		max_out -= PAGE_SIZE;
-		kunmap(out_page);
 		if (nr_pages == nr_dest_pages) {
-			out_page = NULL;
 			ret = -E2BIG;
 			goto out;
 		}
@@ -522,7 +517,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 			goto out;
 		}
 		pages[nr_pages++] = out_page;
-		workspace->out_buf.dst = kmap(out_page);
+		workspace->out_buf.dst = page_address(out_page);
 		workspace->out_buf.pos = 0;
 		workspace->out_buf.size = min_t(size_t, max_out, PAGE_SIZE);
 	}
@@ -537,13 +532,10 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
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
 
@@ -567,7 +559,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		goto done;
 	}
 
-	workspace->in_buf.src = kmap(pages_in[page_in_index]);
+	workspace->in_buf.src = kmap_local_page(pages_in[page_in_index]);
 	workspace->in_buf.pos = 0;
 	workspace->in_buf.size = min_t(size_t, srclen, PAGE_SIZE);
 
@@ -603,14 +595,15 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
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
@@ -619,7 +612,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	zero_fill_bio(cb->orig_bio);
 done:
 	if (workspace->in_buf.src)
-		kunmap(pages_in[page_in_index]);
+		kunmap_local(workspace->in_buf.src);
 	return ret;
 }
 
-- 
2.36.1

