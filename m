Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDA44F1C5B
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 23:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382231AbiDDV0f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 17:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379563AbiDDRbZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 13:31:25 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EF9615E
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 10:29:28 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s21so1247407pgs.4
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Apr 2022 10:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S8N1govmC2Ka0cc66neVJ/2PkwoM7hPYWi3v1T/e+KI=;
        b=uc0pyi82HUMrPgDBdANcsjl3ErR1CQrq4U/BBVncw5wcL5wROg4918/ojahuJyj2f1
         DzPEMwKytMEQoTN8It+qiR+2W7rV0rNh7GMhSqF6N/0YzpnHZH2NzQj/s7oTKG8uQjEV
         yYFY3NSvLC+D3cbtkw/03Q+fyFEaZ0npKjmZeg/stU4hXLm/8CD7lr8GN5FWOHupDY3D
         dFcHpmA/hBUdWjcAiIzsdd3SmupXKFe+sNIsbtdM+2geL0encdPi8JwMQlmcJf4fg2fX
         /bF4y5KxI271SSmJXf7UI4LKdfH+Xp2AMpDzHHcv6QYTK1Pdgm7XIN+pUJgV4syLUtYa
         LAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S8N1govmC2Ka0cc66neVJ/2PkwoM7hPYWi3v1T/e+KI=;
        b=Qso/0yqZtt5qbP1MzmBt0TM1+9OwvIGu9QjFfmHrH2kMwdfN6fmTHss36hP2Z3AKYE
         uK9f//7KI5nYfAHfzOzeniP8DtXck+oq0ttqDea8NtscyDisyw+LnvS6LKSPryLAOQYb
         tfCsfMW4YLc4XA2W0yJgEZbFFCs2H/8tJJhJpJziFr2N3LmkSPbWicue91zj+tZ7sr/7
         erOVieZqKRtWAU+L6cOKwqeZB2d97g3UmQWMoM2O9CfSchYEhpyS/khdIdIU5ljWQgFR
         Ral93Yq4uX9QpuzK3I1vzBwRT5hzUnnz+KiBBYBdhskvS8HTr8NFy6I6fVhND2PQdnqX
         7kyw==
X-Gm-Message-State: AOAM532usU0FOkD1RqpcL0y56l52DdjJlsAJdCMoXtYTjGRFg5L637pq
        JMWUuUI5LLrA66mXQtm287KEp1ZUtUhIXQ==
X-Google-Smtp-Source: ABdhPJwLe++4ZlMvNciG9F2gWXhbM71bwp/IRd3HOgcgxP1VgD04aNvtZBoyqYFM0LOVgEG/TCFXdg==
X-Received: by 2002:a65:6951:0:b0:381:f10:ccaa with SMTP id w17-20020a656951000000b003810f10ccaamr742394pgq.587.1649093367565;
        Mon, 04 Apr 2022 10:29:27 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:eb9])
        by smtp.gmail.com with ESMTPSA id g6-20020a056a001a0600b004f7bd56cc08sm12880787pfv.123.2022.04.04.10.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:29:26 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v15 5/7] btrfs: send: get send buffer pages for protocol v2
Date:   Mon,  4 Apr 2022 10:29:07 -0700
Message-Id: <a3707ef4e055fb319ad7d60a5247c420f7173d07.1649092662.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649092662.git.osandov@fb.com>
References: <cover.1649092662.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

For encoded writes in send v2, we will get the encoded data with
btrfs_encoded_read_regular_fill_pages(), which expects a list of raw
pages. To avoid extra buffers and copies, we should read directly into
the send buffer. Therefore, we need the raw pages for the send buffer.

We currently allocate the send buffer with kvmalloc(), which may return
a kmalloc'd buffer or a vmalloc'd buffer. For vmalloc, we can get the
pages with vmalloc_to_page(). For kmalloc, we could use virt_to_page().
However, the buffer size we use (144k) is not a power of two, which in
theory is not guaranteed to return a page-aligned buffer, and in
practice would waste a lot of memory due to rounding up to the next
power of two. 144k is large enough that it usually gets allocated with
vmalloc(), anyways. So, for send v2, replace kvmalloc() with vmalloc()
and save the pages in an array.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index c0ca45dae6d6..e574d4f4a167 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -87,6 +87,7 @@ struct send_ctx {
 	 * command (since protocol v2, data must be the last attribute).
 	 */
 	bool put_data;
+	struct page **send_buf_pages;
 	u64 flags;	/* 'flags' member of btrfs_ioctl_send_args is u64 */
 	/* Protocol version compatibility requested */
 	u32 proto;
@@ -7486,12 +7487,32 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	sctx->clone_roots_cnt = arg->clone_sources_count;
 
 	if (sctx->proto >= 2) {
+		u32 send_buf_num_pages;
+
 		sctx->send_max_size = ALIGN(SZ_16K + BTRFS_MAX_COMPRESSED,
 					    PAGE_SIZE);
+		sctx->send_buf = vmalloc(sctx->send_max_size);
+		if (!sctx->send_buf) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		send_buf_num_pages = sctx->send_max_size >> PAGE_SHIFT;
+		sctx->send_buf_pages = kcalloc(send_buf_num_pages,
+					       sizeof(*sctx->send_buf_pages),
+					       GFP_KERNEL);
+		if (!sctx->send_buf_pages) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		for (i = 0; i < send_buf_num_pages; i++) {
+			sctx->send_buf_pages[i] =
+				vmalloc_to_page(sctx->send_buf +
+						(i << PAGE_SHIFT));
+		}
 	} else {
 		sctx->send_max_size = BTRFS_SEND_BUF_SIZE_V1;
+		sctx->send_buf = kvmalloc(sctx->send_max_size, GFP_KERNEL);
 	}
-	sctx->send_buf = kvmalloc(sctx->send_max_size, GFP_KERNEL);
 	if (!sctx->send_buf) {
 		ret = -ENOMEM;
 		goto out;
@@ -7684,6 +7705,7 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 			fput(sctx->send_filp);
 
 		kvfree(sctx->clone_roots);
+		kfree(sctx->send_buf_pages);
 		kvfree(sctx->send_buf);
 
 		name_cache_free(sctx);
-- 
2.35.1

