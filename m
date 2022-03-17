Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603B74DCC65
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 18:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiCQR1a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 13:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbiCQR11 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 13:27:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A0E114FC8
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:10 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so2283321pjm.0
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=khOJrdrDEWIV7HJtp0T3it85P1f2rHhG80yKCamxkTk=;
        b=ROBCBpTXXlO0lM4lyfnymfBEhTVCuXuKihXSb3ry5oV22pMzFGT26ikvhmRlwmvMhy
         trNAcsKkNF4wGyrVsQT0Vonn/MTSWIkrEpRDmaYrWcemT43ucLJ+PA9w7y/MI9iRzU5f
         iK+6LLWE/OWzdB25xfl+PaPWvug1SZKCKvn/7xw1GDH18UtKOCxX3qX8oVwbKrJpZxtm
         30ao6mCgdLKaLPh43KHbJIfZDaxyu/bn9z2PdNY4vubPTH+/4TY4iMJVKPFItMpWI8tK
         Jm8mhiP3Z72Gjsik7ESS++gVlkLoiGOu8xhbHlNYlWasv1CyjLyRlDCJtr4OBxUh+WdJ
         58Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=khOJrdrDEWIV7HJtp0T3it85P1f2rHhG80yKCamxkTk=;
        b=A1f7gVswDWNhf/1tUfdB+G1sIrn6IcJJGg4DjknFMlx0Hhw4ChFLj/b0lJ+xn0/W/j
         khAY7pzMGZWm3DAJ5LAX/VKkgZghCH3eXDNst4HfNSVCiaU7yoaoyE+8RekJq3xIEm61
         tue37ImNsKqxY4XuSZJ6ifErftT5MyavoAfJ2YLLdjYWiRn/cKQM3ep7y1XrloXJubGs
         krs5+RTyZdB0J2dHd+T8nZ3Czb2+Pe386KMS4h587JdigZqy8y8hE+3UnUmfCwf0ux0j
         askhszZbMECAGfb2VEOU72bwpRh+8j96E7igPuYYF7lvD54nfbiLPE9lKllJYK5I2/N/
         VUgw==
X-Gm-Message-State: AOAM530zp71cwgOsEkYlzX2hcVfFno3Zp0ckAN/9QK+xk6sf+HQefL4m
        udRDgcBVSwn92KRJ8LW27q9vHzFbl3/oUA==
X-Google-Smtp-Source: ABdhPJyknfhUTrVMbQkNAz0MNRtZ3y/Vpfz1KZMRb+xVNr3Q5sVco3R9GPeyhfFeXkSOS52gML3Wzg==
X-Received: by 2002:a17:902:d501:b0:153:4a6a:52de with SMTP id b1-20020a170902d50100b001534a6a52demr5939456plg.100.1647537970051;
        Thu, 17 Mar 2022 10:26:10 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:624e])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00088a00b004f7ceff389esm7815424pfj.152.2022.03.17.10.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:26:09 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v14 4/7] btrfs: send: write larger chunks when using stream v2
Date:   Thu, 17 Mar 2022 10:25:40 -0700
Message-Id: <2ac307b0d20f84a09302d9d4f7c4fa1207edccc7.1647537027.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647537027.git.osandov@fb.com>
References: <cover.1647537027.git.osandov@fb.com>
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
index 1f141de3a7d6..02053fff80ca 100644
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
@@ -4853,14 +4858,30 @@ static inline u64 max_send_read_size(const struct send_ctx *sctx)
 
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
 
@@ -7459,7 +7480,12 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 
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

