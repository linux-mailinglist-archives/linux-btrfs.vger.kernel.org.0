Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACF233DDEA
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 20:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbhCPTp1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 15:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240546AbhCPTo3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 15:44:29 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB40C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 12:44:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id r16so8220790pfh.10
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pgCBjItU1Bta5sWTZqTeK5Gpn8XCDGtd/okV9d9rprQ=;
        b=q8myNonQgk/lwMOmpbeD7ayFDoBQYXWeVfbd7jj2SegF4L0CKi2B+97D33lyNL0Due
         AVuB4xTxjj+Z76hQgc7OLefXB5ZgHfZriYesu+/73DWfv/+2vg02zpXn0dx9LU9L0u+Q
         jFEcdd96gKVEvnO+Ft1ucgv/3qVpurtstV3OVGT+Q0Fa/aaiHgTSZYW65mh4yReIGaRi
         tx32LibP68ZolKPFwhmTcYNZ7KxUfeBz57fvkRjTGZMIgAnRJA9BnChij70tUxdT7dzR
         oapJ9DioI+ADanLc//OJlyeF0xfaT7IkKzeFh9QjWW9C9TATsrWzsVx/5yUoSPdAJLrF
         kFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pgCBjItU1Bta5sWTZqTeK5Gpn8XCDGtd/okV9d9rprQ=;
        b=n7+AXvqqHKDFm9rlE3rVvEtZ0Ai31iGmDWQIy08iZRPWZUtvNtIhPazLuG7EU6LVJk
         nIWV2xh1PdRk38qj09hwbLWS5jQX8f+rJd6KpfIsEWwcot2YQfkoNMoFioXZ1LTiNKmu
         lWgNIL3RZck9FOWiSRR6Oshj8Z+lFG+7RFChtbCL0ppq3dlI2VrV4J2e0Du5lhkFQv7u
         MeqM/77ZAiaT8e+E5y9a3Cm6kP695tNuDkpiQRxD1HmPWo8/sCNb7WiSp49mSLHCaq/1
         yz4Knf4T9yrnyM4JWO705k1+aqYsx6JzXPP6nWtqJlXUqs3o1jaCpBXaB7KHTxeBosR7
         AJxA==
X-Gm-Message-State: AOAM530LHjK1aOmOajrMHRD/DN8+cYvnip4tkiDIY8IuUxJjAsJvMcT8
        hgkRSg4msht1FrXgcxsnarW2+1ol2wPZFg==
X-Google-Smtp-Source: ABdhPJwECwOHcP1XYFx414JGUslZxeYx+znORTdXuLzMaIayjgH8Evtlzi/IEpTYzFGICjML8dbLrQ==
X-Received: by 2002:a62:2585:0:b029:1fb:bd86:2008 with SMTP id l127-20020a6225850000b02901fbbd862008mr976731pfl.77.1615923868014;
        Tue, 16 Mar 2021 12:44:28 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:532])
        by smtp.gmail.com with ESMTPSA id w22sm16919104pfi.133.2021.03.16.12.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:44:26 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 2/5] btrfs: send: write larger chunks when using stream v2
Date:   Tue, 16 Mar 2021 12:43:53 -0700
Message-Id: <b66f99260a0562922e72dd71e7c78a2c22725beb.1615922753.git.osandov@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615922753.git.osandov@fb.com>
References: <cover.1615922753.git.osandov@fb.com>
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
index d07570588a16..98948568017c 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4915,14 +4915,27 @@ static inline u64 max_send_read_size(const struct send_ctx *sctx)
 
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
 
@@ -7267,7 +7280,12 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 
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
2.30.2

