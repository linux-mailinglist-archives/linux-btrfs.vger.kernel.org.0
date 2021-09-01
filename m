Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FDD3FE0B5
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 19:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbhIARCp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 13:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbhIARCk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Sep 2021 13:02:40 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051E0C0617AF
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Sep 2021 10:01:43 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id n18so37959pgm.12
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Sep 2021 10:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mYxBOrA+eNNYB0JwI9mYBuy/s5j4yDG6uUHh62GOk7k=;
        b=HA6pNqv4bkaSW0OJD4nkzkGoMnL21qZWvwZGnRQG6ca5gW/RhSxkqXYqRKmCf+u/sa
         mfJtACPkIeaiWrmbcTzND6F+dkD/W7t/gdq/nS98DACW+5Gg17IZ6zlxlRljYnqeCd35
         mU1s5h2mdxod4TUZFlLy/E3Nlai5eYoQOfscNe/eJsjuhek2zBLjqjNjwcpDXD2pv6Mw
         Yu0qdjaehblP3LyAYR+0JkZMyykBzbsXNJmP51A9fyXv3cjp14L0ac9RKpvp9FvjnFcz
         NP6j23Edaj63JSungb8Xs19wcfBwpNWYw5NPi/20oKLQkCBiYMtI+bOgvFNb7dLQW6TQ
         5viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mYxBOrA+eNNYB0JwI9mYBuy/s5j4yDG6uUHh62GOk7k=;
        b=BsXNhXFwfqxjhx2NbZbiyeSLYUfQdZwvNN10rhRLfGrBYPn2Vdk9YW72jSkFBrFu1F
         jk7SycC873RXDAFSzGQCAad7M1qDmH0tEVsGKITo5WNDcTjQz33ACRBZp0TxUmVE9oRU
         Z0s9GbhCkFJxFLPkymTAr11OE7EeOou0I+7hoEQWTPYu/tDi4ZcK0cWDVT3yot6oCeum
         hTYKHqDXYWqPL5qqbp1/sU6aq5hKizpbAEqdrNYPbdXSrS8UTg189NvECTVNHTN0L+1n
         +xKAbVFKwqRA2/5F1ARpbOjv4BdFAk3b72BJCv/uyJDcieWqJ/wklXL0iAhxK1+oOqED
         /V3Q==
X-Gm-Message-State: AOAM533TExhr7/yU7RWaUuR3UvUFKowDZ6C9pw+j5/R/LCUPw9EMVfnF
        MM2vBd67TSkf9FO95+VtRKo4CSmP2kdSIA==
X-Google-Smtp-Source: ABdhPJxd8jWjFQnghqrb+5OiIzCNFgkRcYvSXSGgYslLKsqj3uTjlnoQKCim1qfUgYbXzi9Ps7GIdQ==
X-Received: by 2002:a05:6a00:16d5:b0:3e0:f6ce:f2f7 with SMTP id l21-20020a056a0016d500b003e0f6cef2f7mr364451pfc.78.1630515702079;
        Wed, 01 Sep 2021 10:01:42 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:a2b2])
        by smtp.gmail.com with ESMTPSA id y7sm58642pff.206.2021.09.01.10.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:01:41 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v11 11/14] btrfs: send: write larger chunks when using stream v2
Date:   Wed,  1 Sep 2021 10:01:06 -0700
Message-Id: <7d62209de1399ce59d84fc3b06ac37d5b336be27.1630514529.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630514529.git.osandov@fb.com>
References: <cover.1630514529.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The length field of the send stream TLV header is 16 bits. This means
that the maximum amount of data that can be sent for one write is 64k
minus one. However, encoded writes must be able to send the maximum
compressed extent (128k) in one command. To support this, send stream
version 2 encodes the DATA attribute differently: it has no length
field, and the length is implicitly up to the end of containing command
(which has a 32-bit length field). Although this is necessary for
encoded writes, normal writes can benefit from it, too.

For v2, let's bump up the send buffer to the maximum compressed extent
size plus 16k for the other metadata (144k total). Since this will most
likely be vmalloc'd (and always will be after the next commit), we round
it up to the next page since we might as well use the rest of the page
on systems with >16k pages.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 2ec07943f173..80736e2670eb 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4908,14 +4908,27 @@ static inline u64 max_send_read_size(const struct send_ctx *sctx)
 
 static int put_data_header(struct send_ctx *sctx, u32 len)
 {
-	struct btrfs_tlv_header *hdr;
+	if (sctx->flags & BTRFS_SEND_FLAG_STREAM_V2) {
+		/*
+		 * In v2, the data attribute header doesn't include a length; it
+		 * is implicitly to the end of the command.
+		 */
+		if (sctx->send_max_size - sctx->send_size < 2 + len)
+			return -EOVERFLOW;
+		put_unaligned_le16(BTRFS_SEND_A_DATA,
+				   sctx->send_buf + sctx->send_size);
+		sctx->send_size += 2;
+	} else {
+		struct btrfs_tlv_header *hdr;
 
-	if (sctx->send_max_size - sctx->send_size < sizeof(*hdr) + len)
-		return -EOVERFLOW;
-	hdr = (struct btrfs_tlv_header *)(sctx->send_buf + sctx->send_size);
-	put_unaligned_le16(BTRFS_SEND_A_DATA, &hdr->tlv_type);
-	put_unaligned_le16(len, &hdr->tlv_len);
-	sctx->send_size += sizeof(*hdr);
+		if (sctx->send_max_size - sctx->send_size < sizeof(*hdr) + len)
+			return -EOVERFLOW;
+		hdr = (struct btrfs_tlv_header *)(sctx->send_buf +
+						  sctx->send_size);
+		put_unaligned_le16(BTRFS_SEND_A_DATA, &hdr->tlv_type);
+		put_unaligned_le16(len, &hdr->tlv_len);
+		sctx->send_size += sizeof(*hdr);
+	}
 	return 0;
 }
 
@@ -7287,7 +7300,12 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 
 	sctx->clone_roots_cnt = arg->clone_sources_count;
 
-	sctx->send_max_size = BTRFS_SEND_BUF_SIZE_V1;
+	if (sctx->flags & BTRFS_SEND_FLAG_STREAM_V2) {
+		sctx->send_max_size = ALIGN(SZ_16K + BTRFS_MAX_COMPRESSED,
+					    PAGE_SIZE);
+	} else {
+		sctx->send_max_size = BTRFS_SEND_BUF_SIZE_V1;
+	}
 	sctx->send_buf = kvmalloc(sctx->send_max_size, GFP_KERNEL);
 	if (!sctx->send_buf) {
 		ret = -ENOMEM;
-- 
2.33.0

