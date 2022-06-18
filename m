Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536B95503BF
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Jun 2022 11:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiFRJ2C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Jun 2022 05:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbiFRJ2A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Jun 2022 05:28:00 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A42F598;
        Sat, 18 Jun 2022 02:27:58 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id o10so9023754edi.1;
        Sat, 18 Jun 2022 02:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zurrbWODzCL1ddkbl6NdnzpZxtPzyETq04wfptwh7DM=;
        b=c4bHkLgZzc7iiVTDpB9d7SGvdmSsUTaqFyiLR1x9r4firz6ghgHY21dMIaDiVT+zCv
         cpmnb+O9pdmSpf37NF1LNoia/nXzdhSZUxXgdXEVGHmK7Bk9Gz8vZj7fKTkn18GhwjYL
         Ng1C1Y1pYDh2yuoENrTDHa8rX/JVEYoHznMtHqARyZU9lmZUvewuu11qCb2HelPxxKIF
         i3pOMt8FRxRLNSsOzjaynnzZBLVxRzFHr1Feqei/KdPeY1OCA9/N2bj+8qa7dFVX6IO+
         9RzvVt4oUgQFwWY6nrGgyc7tbI1lwoSmgq/mrKK+Z4SswfwotF9VhZo3KDMMFspJFve2
         Cm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zurrbWODzCL1ddkbl6NdnzpZxtPzyETq04wfptwh7DM=;
        b=7DQjwUaIy93+FjOaeLkW2YjTlwV51TU6E05uyBucBHs6BgLh29FC8E3tYmZbDitHX3
         pWthoakVr+ENZESVO8Y5yw3FBWFUWlFEJQEYH3/B0piEY7Tij1P81f3mdCdccKavFx3+
         4CVh7j/hJUGszJmeTF2rJHRlb4yHkNnvhfl9Sro74NzsebH/NJ7gyXlyk4eQ5p0pOi1v
         P9rWF7g9xqsTjUzHrE+mFQMEndBM3Desw8BKSTORjK31aayODBh6Sik/sAgMOKZ5rvYc
         YJ3LA9lkHIgYm3GNxOAHDjvmzVhAGKPSR8dlC9WTC/ZuCiwhohFerHaD5yrE3YEFjuEQ
         0NYA==
X-Gm-Message-State: AJIora/f9fY8zabSGKqucIhM/jD1UzThu4r04tOMtI9mxDGzy/6CRujJ
        mDSeqVhoHfPfiwvl/a5mxIs=
X-Google-Smtp-Source: AGRyM1vaySoCUcHfejjo919kFDCLKXY44az72Sj+FUqoueEwqjp4bX1vsk623z5KlcTRl/T6TAQWnA==
X-Received: by 2002:a05:6402:e87:b0:435:5dda:9428 with SMTP id h7-20020a0564020e8700b004355dda9428mr9285608eda.6.1655544476984;
        Sat, 18 Jun 2022 02:27:56 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906169200b00705976bcd01sm3132209ejd.206.2022.06.18.02.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 02:27:55 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] btrfs: Convert zlib_compress_pages() to use kmap_local_page()
Date:   Sat, 18 Jun 2022 11:27:52 +0200
Message-Id: <20220618092752.25153-1-fmdefrancesco@gmail.com>
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

Therefore, use kmap_local_page() / kunmap_local() in zlib_compress_pages()
because in this function the mappings are per thread and are not visible
in other contexts.

Tested with xfstests on QEMU + KVM 32-bit VM with 4GB of RAM and
HIGHMEM64G enabled. This patch passes 26/26 tests of group "compress".

Cc: Qu Wenruo <wqu@suse.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

This patch builds only on top of
"[PATCH] btrfs: zlib: refactor how we prepare the input buffer" by Qu Wenruo".
https://lore.kernel.org/linux-btrfs/d0bfc791b5509df7b9ad44e41ada197d1b3149b3.1655519730.git.wqu@suse.com/

 fs/btrfs/zlib.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 966e17cea981..4496dd30bd71 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -160,7 +160,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 		ret = -ENOMEM;
 		goto out;
 	}
-	cpage_out = kmap(out_page);
+	cpage_out = kmap_local_page(out_page);
 	pages[0] = out_page;
 	nr_pages = 1;
 
@@ -198,9 +198,9 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 		 * the stream end if required
 		 */
 		if (workspace->strm.avail_out == 0) {
-			kunmap(out_page);
+			kunmap_local(cpage_out);
 			if (nr_pages == nr_dest_pages) {
-				out_page = NULL;
+				cpage_out = NULL;
 				ret = -E2BIG;
 				goto out;
 			}
@@ -209,7 +209,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				ret = -ENOMEM;
 				goto out;
 			}
-			cpage_out = kmap(out_page);
+			cpage_out = kmap_local_page(out_page);
 			pages[nr_pages] = out_page;
 			nr_pages++;
 			workspace->strm.avail_out = PAGE_SIZE;
@@ -236,9 +236,9 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 			goto out;
 		} else if (workspace->strm.avail_out == 0) {
 			/* get another page for the stream end */
-			kunmap(out_page);
+			kunmap_local(cpage_out);
 			if (nr_pages == nr_dest_pages) {
-				out_page = NULL;
+				cpage_out = NULL;
 				ret = -E2BIG;
 				goto out;
 			}
@@ -247,7 +247,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				ret = -ENOMEM;
 				goto out;
 			}
-			cpage_out = kmap(out_page);
+			cpage_out = kmap_local_page(out_page);
 			pages[nr_pages] = out_page;
 			nr_pages++;
 			workspace->strm.avail_out = PAGE_SIZE;
@@ -266,8 +266,8 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 	*total_in = workspace->strm.total_in;
 out:
 	*out_pages = nr_pages;
-	if (out_page)
-		kunmap(out_page);
+	if (cpage_out)
+		kunmap_local(cpage_out);
 	return ret;
 }
 
-- 
2.36.1

