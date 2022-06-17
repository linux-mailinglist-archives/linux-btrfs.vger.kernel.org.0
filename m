Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AAE54F733
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 14:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382188AbiFQMFy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 08:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379829AbiFQMFv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 08:05:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546F16B7CD;
        Fri, 17 Jun 2022 05:05:50 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kq6so8333448ejb.11;
        Fri, 17 Jun 2022 05:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KnN24k9bVkHEuK5wqwj88tJd2kUsuq85Wnf8cEQ0fjA=;
        b=k3jYGlLxfV7mO9FY1IxOxNtTFHO5QdM7tcjuPJjU8Y7FrlN6yDdBAngPXpORjDAfpw
         6jinETykgTOxqSLSF/bVFLQe3xnb7szXyPl0M1F1qKHXIvmQptuUt8ZaG10vtVa4aOJU
         +kMcFD7ATDd5R2uFnopGJomK8j8f0+fY+ngWo0gbTKqnHmB9+cST0yyunwfThxs+0RFD
         a+Aj65wCHFw3T4hZdHCSldfzJhnbZ8g/5F+f1IVHfwMsiWH9gjo+6gxnDl5/rTBPTbnv
         yevwX2iskpjdHBE/9hiYFw4TrTL+mJCTKCCYzXBa5BkOtV6eU3ksmYCBrYkdbbZpRLd1
         MmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KnN24k9bVkHEuK5wqwj88tJd2kUsuq85Wnf8cEQ0fjA=;
        b=zJwCaqSoDYhxUvfEByf1Y313b6EXvsNimXldC3pQNKqmgz4xUKXYtuV0FA7HvXV2Eh
         jViR6fsQTJNtJx2QG2IggNQSigoXadBJTHveRAgndy2VWU9kUzNWbMdAUZxhL4oOE6kv
         VN2U0mkTmXnw2CraK3HntufdZJGro6GGgZ/jy5RfVXvnN5BEyaohMz/XvGFq98fOJkC+
         gDxKAsM22dq3BlBbfFBXeIHS79nef2RIhH/JJcmk/C6mGPPvWkWOQm2r1GJI/jyjOOBO
         0xH3qPiloQSwEkCTcDYwAUYz2vDU86lDz8Ce8K53sx/ThHEnjqOh2sB3cmoPT7w7/gk4
         tKPQ==
X-Gm-Message-State: AJIora/eI4TSGUSCxQDsdK3uCd0QnTLQkIrAZki5wC74RXgznBLS6REi
        WnapV+02QnZDzfzByNA+l6MMiSYCP5g=
X-Google-Smtp-Source: AGRyM1tjlOy6g3acRJ2FTwt2II0C6scynPXeVvNaWAwNwMDX2pN4Xc0MrXf0U08jY/dwDDT6B9VASQ==
X-Received: by 2002:a17:907:8195:b0:710:b40:95d2 with SMTP id iy21-20020a170907819500b007100b4095d2mr9017211ejc.604.1655467548861;
        Fri, 17 Jun 2022 05:05:48 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id kw2-20020a170907770200b007121361d54asm2135179ejc.25.2022.06.17.05.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 05:05:47 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [RFC PATCH v2 1/3] btrfs: Convert zlib_decompress_bio() to use kmap_local_page()
Date:   Fri, 17 Jun 2022 14:05:36 +0200
Message-Id: <20220617120538.18091-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220617120538.18091-1-fmdefrancesco@gmail.com>
References: <20220617120538.18091-1-fmdefrancesco@gmail.com>
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

Therefore, use kmap_local_page() / kunmap_local() in zlib_decompress_bio()
because in this function the mappings are per thread and are not visible
in other contexts.

Tested with xfstests on QEMU + KVM 32 bits VM with 4GB of RAM and
HIGHMEM64G enabled. This patch passes 26/26 tests of group "compress".

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/btrfs/zlib.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 767a0c6c9694..770c4c6bbaef 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -287,7 +287,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	unsigned long buf_start;
 	struct page **pages_in = cb->compressed_pages;
 
-	data_in = kmap(pages_in[page_in_index]);
+	data_in = kmap_local_page(pages_in[page_in_index]);
 	workspace->strm.next_in = data_in;
 	workspace->strm.avail_in = min_t(size_t, srclen, PAGE_SIZE);
 	workspace->strm.total_in = 0;
@@ -309,7 +309,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
 	if (Z_OK != zlib_inflateInit2(&workspace->strm, wbits)) {
 		pr_warn("BTRFS: inflateInit failed\n");
-		kunmap(pages_in[page_in_index]);
+		kunmap_local(data_in);
 		return -EIO;
 	}
 	while (workspace->strm.total_in < srclen) {
@@ -336,13 +336,13 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
 		if (workspace->strm.avail_in == 0) {
 			unsigned long tmp;
-			kunmap(pages_in[page_in_index]);
+			kunmap_local(data_in);
 			page_in_index++;
 			if (page_in_index >= total_pages_in) {
 				data_in = NULL;
 				break;
 			}
-			data_in = kmap(pages_in[page_in_index]);
+			data_in = kmap_local_page(pages_in[page_in_index]);
 			workspace->strm.next_in = data_in;
 			tmp = srclen - workspace->strm.total_in;
 			workspace->strm.avail_in = min(tmp, PAGE_SIZE);
@@ -355,7 +355,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 done:
 	zlib_inflateEnd(&workspace->strm);
 	if (data_in)
-		kunmap(pages_in[page_in_index]);
+		kunmap_local(data_in);
 	if (!ret)
 		zero_fill_bio(cb->orig_bio);
 	return ret;
-- 
2.36.1

