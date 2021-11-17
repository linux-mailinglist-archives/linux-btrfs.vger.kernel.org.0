Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A791454E6D
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240683AbhKQUXX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240677AbhKQUXO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:14 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6DCC061570
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:15 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id v22so3861507qtx.8
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NYKW0sOXiErr7iXsY6pXtFa7lVn3lMfvSbAnD/gJyhA=;
        b=0wdJvZLGsRCD3FaUh+i7U74IuxYAm1HwakOP0YELIr+4q4o5B5aUemx9MpUqz6dzsF
         raB3DIzzeFIQ5mhQrU5CvR8JRxIBF8WAVntOgbOujApVTqkFM+NJ5E68DSsjkxOE7/s4
         /EV6MbZmB552cOyvdGxw/4ZQUVlEDwoLyGxzxIiPTKEzCCyaNDcU7UHJu4xP5YBNJFBV
         9fRj2+pw/G7jp7gDlRt8T7qZr+pg6qlJaPjtFpOJC/DDCc8BG9vGNRYhsSONCbLy2kn7
         SOglMP21SH8fOXmu1fk2hqREc5PgcVS//jjX8/HRsjqpAuVmskrxamRpYk2K3f3F9wVa
         O18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYKW0sOXiErr7iXsY6pXtFa7lVn3lMfvSbAnD/gJyhA=;
        b=0SQT4GOp1cNTP4ZiozP3cbx0APYN++t5Pq5hxfajuQDIx9iCNEvPfwJsX62f7fewe8
         Musd7pRM/n1ayNQ003dzVzGs2bqzeujUAf7N8mnmyx+jjYzFR6vc74Lm/xsda2FV7nnd
         hfNVHMw7XkhcckP3CsKNaJofmkVd3xiPfTdzERtimbTTfGcd8m3ZRAnSG4wjO3GctlXZ
         GPC+s5wgkN+MFl3jeb75ol91DKCXZzMJ8YsEilXygGkD3zEA05o/v85ssp2cuKpQcBtG
         WoCh6eAYKpQMNOIWu6QRS2SDnIRB3eA/B4ujs89kpNdZgbu1DSZCAnZa5DcaLYOWN1Rs
         5ISg==
X-Gm-Message-State: AOAM533bxTzPBmrxpmWinYJoly4XGGFG+39ECnis3Wvkj+1MBSnUkgFL
        mfmbPy52/+SUauv1l1v6uc9i/H3f/5PoRQ==
X-Google-Smtp-Source: ABdhPJzrpTdgvwhwMT4hbyvwxNooNq65EGP39fGmHB+H3y6gMMQKQ2QlxCyUcJ+sxoqlIDezj+2Y9g==
X-Received: by 2002:ac8:57ce:: with SMTP id w14mr19994518qta.252.1637180413987;
        Wed, 17 Nov 2021 12:20:13 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:13 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 14/17] btrfs: send: write larger chunks when using stream v2
Date:   Wed, 17 Nov 2021 12:19:24 -0800
Message-Id: <051232485e4ac1a1a5fd35de7328208385c59f65.1637179348.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
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

Also add a check to enforce that the DATA attribute is last. It is only
strictly necessary for v2, but we might as well make v1 consistent with
it.

For v2, let's bump up the send buffer to the maximum compressed extent
size plus 16k for the other metadata (144k total). Since this will most
likely be vmalloc'd (and always will be after the next commit), we round
it up to the next page since we might as well use the rest of the page
on systems with >16k pages.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 53b3cc2276ea..12844cb20584 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -81,6 +81,7 @@ struct send_ctx {
 	char *send_buf;
 	u32 send_size;
 	u32 send_max_size;
+	bool put_data;
 	u64 flags;	/* 'flags' member of btrfs_ioctl_send_args is u64 */
 	/* Protocol version compatibility requested */
 	u32 proto;
@@ -584,6 +585,9 @@ static int tlv_put(struct send_ctx *sctx, u16 attr, const void *data, int len)
 	int total_len = sizeof(*hdr) + len;
 	int left = sctx->send_max_size - sctx->send_size;
 
+	if (WARN_ON_ONCE(sctx->put_data))
+		return -EINVAL;
+
 	if (unlikely(left < total_len))
 		return -EOVERFLOW;
 
@@ -721,6 +725,7 @@ static int send_cmd(struct send_ctx *sctx)
 					&sctx->send_off);
 
 	sctx->send_size = 0;
+	sctx->put_data = false;
 
 	return ret;
 }
@@ -4902,14 +4907,30 @@ static inline u64 max_send_read_size(const struct send_ctx *sctx)
 
 static int put_data_header(struct send_ctx *sctx, u32 len)
 {
-	struct btrfs_tlv_header *hdr;
+	if (WARN_ON_ONCE(sctx->put_data))
+		return -EINVAL;
+	sctx->put_data = true;
+	if (sctx->proto >= 2) {
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
 
@@ -7292,7 +7313,12 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 
 	sctx->clone_roots_cnt = arg->clone_sources_count;
 
-	sctx->send_max_size = BTRFS_SEND_BUF_SIZE_V1;
+	if (sctx->proto >= 2) {
+		sctx->send_max_size = ALIGN(SZ_16K + BTRFS_MAX_COMPRESSED,
+					    PAGE_SIZE);
+	} else {
+		sctx->send_max_size = BTRFS_SEND_BUF_SIZE_V1;
+	}
 	sctx->send_buf = kvmalloc(sctx->send_max_size, GFP_KERNEL);
 	if (!sctx->send_buf) {
 		ret = -ENOMEM;
-- 
2.34.0

