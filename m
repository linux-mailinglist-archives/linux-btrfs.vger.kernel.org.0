Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6263A4366
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 15:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhFKN4V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 09:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhFKN4V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:21 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DF9C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 06:54:07 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id r20so2608820qtp.3
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 06:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uogoIf0mLnC18pRJSXbrn3NvUCGRWlEyukoJAD5I02I=;
        b=K9p3jjtlSgjosz7I+uKdTryyiWlmk/69JNenjSvROmF9s2gLo67ywQ+a16vpFwBb5V
         +AbYrXOXpwgZJrjWf9TAK4MMjJhOPi0WOhggA7ZZkyCMuif3TYwpthfYaHtl0egRdw8a
         cc1kofg7YHRx3vBV81DnVPrlTSs8+pPOZf0MtZlrsLyCa8/AuwI7n6KJeE+YRJldU/jw
         ij5NzTIVKe2dcp1WpZsegVUbAP2/E0EO0giAEnyGfCZMUhvRYTdbGNDmJB2QHZnltd6w
         PxfiLbznkTLIuve8YSnpMQ59upYheFV9jQKgjJ5QsasSD6qOyk7okD93kSzxqyK+Z569
         wZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uogoIf0mLnC18pRJSXbrn3NvUCGRWlEyukoJAD5I02I=;
        b=Anj9njqzTVyGlftJOkqxdOXJHgxuIK//FAax+qVMjAJ3u947FdSPe9YNfVwb1f/oes
         yNRGZTa3RUlf3IUafL+5BR1ZqrTuTZ5qUV04V+w1SM2dMCdPazJ8liRxDnXQuVV1cWK1
         0KDmhQuPNpxEBUvGSlwNICDG8Yh/Zd4pB5bY1HUm8kM+Zso/aTMOq4g5Hu13fVQPzzDt
         vVu7XyKaTiHNT3hsNFofnU3bJyPvoWia6Dhn8wWGsM2ASimYY43vkOexakET1w10Lp9T
         zGv+cdfxyYcZRupaQZF+4HNCqILpHWYaSOYKWH+0Ej7l0Wol1nuMonEzx4rb7aQVBYG8
         O0pQ==
X-Gm-Message-State: AOAM530kk2uaUFxaWpD9ypYEzUqFWN+J3dYogmzHWTiZxLmPLoF4vsuf
        JqrvJy7bJCxHto3xaeOEJE+3tc7cCPgNKA==
X-Google-Smtp-Source: ABdhPJzl+CCFD31ilDwuj/ZAOwOWomfn1oebfYsaeIS79BSlBMQ95y3KDCrGdkGTUcm0LJfwlfJA9g==
X-Received: by 2002:a05:622a:134a:: with SMTP id w10mr4022827qtk.201.1623419646353;
        Fri, 11 Jun 2021 06:54:06 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c23sm4427304qkc.3.2021.06.11.06.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 06:54:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/4] fs: add a filemap_fdatawrite_wbc helper
Date:   Fri, 11 Jun 2021 09:53:59 -0400
Message-Id: <b7ce962335474c7b0e96849cd9fb650b1138cbb3.1623419155.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1623419155.git.josef@toxicpanda.com>
References: <cover.1623419155.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs sometimes needs to flush dirty pages on a bunch of dirty inodes in
order to reclaim metadata reservations.  Unfortunately most helpers in
this area are too smart for us

1) The normal filemap_fdata* helpers only take range and sync modes, and
   don't give any indication of how much was written, so we can only
   flush full inodes, which isn't what we want in most cases.
2) The normal writeback path requires us to have the s_umount sem held,
   but we can't unconditionally take it in this path because we could
   deadlock.
3) The normal writeback path also skips inodes with I_SYNC set if we
   write with WB_SYNC_NONE.  This isn't the behavior we want under heavy
   ENOSPC pressure, we want to actually make sure the pages are under
   writeback before returning, and if another thread is in the middle of
   writing the file we may return before they're under writeback and
   miss our ordered extents and not properly wait for completion.
4) sync_inode() uses the normal writeback path and has the same problem
   as #3.

What we really want is to call do_writepages() with our wbc.  This way
we can make sure that writeback is actually started on the pages, and we
can control how many pages are written as a whole as we write many
inodes using the same wbc.  Accomplish this with a new helper that does
just that so we can use it for our ENOSPC flushing infrastructure.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/fs.h |  2 ++
 mm/filemap.c       | 29 ++++++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c3c88fdb9b2a..aace07f88b73 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2886,6 +2886,8 @@ extern int filemap_fdatawrite_range(struct address_space *mapping,
 				loff_t start, loff_t end);
 extern int filemap_check_errors(struct address_space *mapping);
 extern void __filemap_set_wb_err(struct address_space *mapping, int err);
+extern int filemap_fdatawrite_wbc(struct address_space *mapping,
+				  struct writeback_control *wbc);
 
 static inline int filemap_write_and_wait(struct address_space *mapping)
 {
diff --git a/mm/filemap.c b/mm/filemap.c
index 66f7e9fdfbc4..0408bc247e71 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -376,6 +376,29 @@ static int filemap_check_and_keep_errors(struct address_space *mapping)
 		return -ENOSPC;
 	return 0;
 }
+/**
+ * filemap_fdatawrite_wbc - start writeback on mapping dirty pages in range
+ * @mapping:	address space structure to write
+ * @wbc:	the writeback_control controlling the writeout
+ *
+ * This behaves the same way as __filemap_fdatawrite_range, but simply takes the
+ * writeback_control as an argument to allow the caller to have more flexibility
+ * over the writeout parameters, and with no checks around whether the mapping
+ * has dirty pages or anything, it simply calls writepages.
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+int filemap_fdatawrite_wbc(struct address_space *mapping,
+			   struct writeback_control *wbc)
+{
+	int ret;
+
+	wbc_attach_fdatawrite_inode(wbc, mapping->host);
+	ret = do_writepages(mapping, wbc);
+	wbc_detach_inode(wbc);
+	return ret;
+}
+EXPORT_SYMBOL(filemap_fdatawrite_wbc);
 
 /**
  * __filemap_fdatawrite_range - start writeback on mapping dirty pages in range
@@ -397,7 +420,6 @@ static int filemap_check_and_keep_errors(struct address_space *mapping)
 int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
 				loff_t end, int sync_mode)
 {
-	int ret;
 	struct writeback_control wbc = {
 		.sync_mode = sync_mode,
 		.nr_to_write = LONG_MAX,
@@ -409,10 +431,7 @@ int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
 	    !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
 		return 0;
 
-	wbc_attach_fdatawrite_inode(&wbc, mapping->host);
-	ret = do_writepages(mapping, &wbc);
-	wbc_detach_inode(&wbc);
-	return ret;
+	return filemap_fdatawrite_wbc(mapping, &wbc);
 }
 
 static inline int __filemap_fdatawrite(struct address_space *mapping,
-- 
2.26.3

