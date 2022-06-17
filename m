Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D87254F736
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 14:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382250AbiFQMF5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 08:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382176AbiFQMFx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 08:05:53 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547BE6B7CD;
        Fri, 17 Jun 2022 05:05:52 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id h23so8334467ejj.12;
        Fri, 17 Jun 2022 05:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N+ZalsdEns5XWVe5XTgPvObVhbj/edy5N7yIyAU1hcY=;
        b=bLCSOMhHE1gx3vXnzBZSlvOsYN71L/kr9xcKjvvZbEFkrBBSd/Q8N40o4xjX4xcMde
         TpyqV4SCShJzDQYncz7IB3ZNx4eBEk6AaWJHY/Rodk62kGUW9dADY0Em0mtqbOUa013p
         2scD0xPxS4puge1MPrD5KCb4u+NPDJAA7ovEFTy2AhXfh9jOL040OfjZ6q5jTo9odDoA
         CzOnndAwZZwN6rKv6dvg8ogOV9vpHXmXfEbag2hn8WlhcXnXANE0D2VQnwmrOMHFP9RM
         eWJM53aFamxiZo0FZL+9CX/WhUcEPHLqLKLT9NPtEVW+9Zqyc4zGbGDmwkc4p2mFVkBI
         vOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N+ZalsdEns5XWVe5XTgPvObVhbj/edy5N7yIyAU1hcY=;
        b=lFcSBNzQOBIdkk3PrmsG75CEjiPI2u1v6veRir85fDEgAy54sVkP3mu97Y3kjHxOFV
         jmqb3TMSk5gRs8oEDChg3ekkM4GcF4CT1SMLikTSFpD5UyzhCyUj6IlHVWnpsr/RkEUi
         P7jW1Ey6oCKwfO3a2FL7xoGD3mJIkr4+Yj22MvaVFSQSu1d/gurprtSdV0yi077mTYHa
         CeZ2UrK8z1GyP9+rq5L6Vke/fyYmcgMpyMmt9njnL8Dx3sVs8fWnTEDVV9ugD0uPeHH5
         8DEZK2KUWJb1UHEhLJGZlAC6Or6FrPMaXOpfX5MWr9bH3IhtiilEFzkPFZiXxaKWvR6r
         Zmiw==
X-Gm-Message-State: AJIora/l4IaRJXocs+BqgcGdBR8V9oYkHG9lFuLMHQ2oK9l5jZVJ/dFU
        TRXp+Es4x2R12cMGH6/4siU=
X-Google-Smtp-Source: AGRyM1u5DNIC4xaqXuwV9mvbfEKMka1G18Jwrkh/vP/CiojfW3FcYmmNVcehUpM14Qv/nsm54Uhuxw==
X-Received: by 2002:a17:906:77da:b0:712:2241:2c3e with SMTP id m26-20020a17090677da00b0071222412c3emr8818742ejn.405.1655467550889;
        Fri, 17 Jun 2022 05:05:50 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id kw2-20020a170907770200b007121361d54asm2135179ejc.25.2022.06.17.05.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 05:05:49 -0700 (PDT)
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
Subject: [RFC PATCH v2 2/3] btrfs: Use kmap_local_page() on "out_page" in zlib_compress_pages()
Date:   Fri, 17 Jun 2022 14:05:37 +0200
Message-Id: <20220617120538.18091-3-fmdefrancesco@gmail.com>
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

Therefore, use kmap_local_page() / kunmap_local() for "out_page" in
zlib_compress_pages() because in this function the mappings are per thread
and are not visible in other contexts.

Tested with xfstests on QEMU + KVM 32 bits VM with 4GB of RAM and
HIGHMEM64G enabled. This patch passes 26/26 tests of group "compress".

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/btrfs/zlib.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 770c4c6bbaef..c7c69ce4a1a9 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -97,8 +97,8 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	int ret;
-	char *data_in;
-	char *cpage_out;
+	char *data_in = NULL;
+	char *cpage_out = NULL;
 	int nr_pages = 0;
 	struct page *in_page = NULL;
 	struct page *out_page = NULL;
@@ -126,7 +126,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 		ret = -ENOMEM;
 		goto out;
 	}
-	cpage_out = kmap(out_page);
+	cpage_out = kmap_local_page(out_page);
 	pages[0] = out_page;
 	nr_pages = 1;
 
@@ -196,7 +196,8 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 		 * the stream end if required
 		 */
 		if (workspace->strm.avail_out == 0) {
-			kunmap(out_page);
+			kunmap_local(cpage_out);
+			cpage_out = NULL;
 			if (nr_pages == nr_dest_pages) {
 				out_page = NULL;
 				ret = -E2BIG;
@@ -207,7 +208,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				ret = -ENOMEM;
 				goto out;
 			}
-			cpage_out = kmap(out_page);
+			cpage_out = kmap_local_page(out_page);
 			pages[nr_pages] = out_page;
 			nr_pages++;
 			workspace->strm.avail_out = PAGE_SIZE;
@@ -234,7 +235,8 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 			goto out;
 		} else if (workspace->strm.avail_out == 0) {
 			/* get another page for the stream end */
-			kunmap(out_page);
+			kunmap_local(cpage_out);
+			cpage_out = NULL;
 			if (nr_pages == nr_dest_pages) {
 				out_page = NULL;
 				ret = -E2BIG;
@@ -245,7 +247,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				ret = -ENOMEM;
 				goto out;
 			}
-			cpage_out = kmap(out_page);
+			cpage_out = kmap_local_page(out_page);
 			pages[nr_pages] = out_page;
 			nr_pages++;
 			workspace->strm.avail_out = PAGE_SIZE;
@@ -264,8 +266,8 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 	*total_in = workspace->strm.total_in;
 out:
 	*out_pages = nr_pages;
-	if (out_page)
-		kunmap(out_page);
+	if (cpage_out)
+		kunmap_local(cpage_out);
 
 	if (in_page) {
 		kunmap(in_page);
-- 
2.36.1

