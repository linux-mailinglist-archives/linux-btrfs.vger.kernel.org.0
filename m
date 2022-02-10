Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C7D4B15EC
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343749AbiBJTKo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343738AbiBJTKn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:43 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065152188
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:44 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id p6so2480682plf.10
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oktzhnVhg73ak7/Gcb3l9iKfEFB0FYYIUdGjJPrwc2s=;
        b=Cs1YeznxTPN/dFj5PAIIjnjeQs30bstETfA7ZIXzgTrd265xhRF2JDNT/kMhwO7JFW
         WMOtwn89U35KPHDRPTHiJgjqAoFVjp78qcLujxoQ3c6GcoRziNkEMy/Sqmv+AmoqG5w9
         Zq4sYRoQYOpBE6vZ52h7ercBYWq/52ALbe9eOEU4AH5gRI2O9psxBz2LjzXrqo1kp5al
         kBO002zWK/NUXsBnOb2+ExOCWJAEzTUNVzSCzudX2L2W4NI+9YPYNJGWIua46nCfYy39
         ewvSlP1JO/ecx3Kg2Y7eZMju5odrSV5e0IPH8x3oreFdpvJYEtRgQUmsvvLDr97j9lBR
         Hd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oktzhnVhg73ak7/Gcb3l9iKfEFB0FYYIUdGjJPrwc2s=;
        b=sBLAIgNiv1sFUMBNPdaQJn3hlA67JriChqP+Tnqc3T7/fgqXd1dPF0Qauyio18c8Dx
         voz4pMch3i0NGWJAfXo87f54psqYpYj9RVRQ1o5+KLuSi1nq3ZYTvmU/BxjHX1g+XUMD
         qAjwac1e+TXAPoI0XEIpII/BbbcbdtdaMOzgzHqjPqGZPn4+U0aAaImcSLOFl/li5I7V
         kQxuH1Ln+CO5HkpgKodmdvlxIoNIVgTLcedZzQzkrglJgaHTXm+r2meiA681HyfVG1N8
         PTatzK6gJum3z3gZPoCapdyLBByNpNMhJGFfNb4TlacjJBRiQj6v4gb1mK1h2NYV+M2x
         D8bg==
X-Gm-Message-State: AOAM530kBfAhDRCxQC8bSzjtPfCXSSAohV3Y+B4TnyStIqxypsxMklAI
        TjlhTbAxftGKImdRC6r24nXiGdvD0Nia2w==
X-Google-Smtp-Source: ABdhPJwwDFQ94lkK6JokG7apjzMx6JnGmkqDwhzbixvcU4abAy5g1h4+ExJ54CTGpxLbl9VAJrc+zw==
X-Received: by 2002:a17:902:ab88:: with SMTP id f8mr9163764plr.27.1644520243159;
        Thu, 10 Feb 2022 11:10:43 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:42 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 14/17] btrfs: send: write larger chunks when using stream v2
Date:   Thu, 10 Feb 2022 11:10:04 -0800
Message-Id: <0235c8a8aeb00b8b0f2d784e82bb0eb470e848d8.1644519257.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644519257.git.osandov@fb.com>
References: <cover.1644519257.git.osandov@fb.com>
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
index 9c9be0983cb3..6d0686c51f80 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -82,6 +82,7 @@ struct send_ctx {
 	char *send_buf;
 	u32 send_size;
 	u32 send_max_size;
+	bool put_data;
 	u64 flags;	/* 'flags' member of btrfs_ioctl_send_args is u64 */
 	/* Protocol version compatibility requested */
 	u32 proto;
@@ -589,6 +590,9 @@ static int tlv_put(struct send_ctx *sctx, u16 attr, const void *data, int len)
 	int total_len = sizeof(*hdr) + len;
 	int left = sctx->send_max_size - sctx->send_size;
 
+	if (WARN_ON_ONCE(sctx->put_data))
+		return -EINVAL;
+
 	if (unlikely(left < total_len))
 		return -EOVERFLOW;
 
@@ -726,6 +730,7 @@ static int send_cmd(struct send_ctx *sctx)
 					&sctx->send_off);
 
 	sctx->send_size = 0;
+	sctx->put_data = false;
 
 	return ret;
 }
@@ -4927,14 +4932,30 @@ static inline u64 max_send_read_size(const struct send_ctx *sctx)
 
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
 
@@ -7564,7 +7585,12 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 
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
2.35.1

