Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F164F1C30
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 23:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379127AbiDDVZq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 17:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379562AbiDDRbX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 13:31:23 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798A2615E
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 10:29:26 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o10so2816041ple.7
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Apr 2022 10:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ZUvgVDxUlWZPMsIIMx1JOHKnEA7lu7ngNLk/N7GprQ=;
        b=o+21cXWUR8Jt9acLUc81B6yhgn0VC3gKgpcAxnEvFrmBuahKnCtG5Mwgn3zLzVUj9x
         tJ3h/zvSEp8r56oPtYxlxn5L0MhtMpRO/8mijdI06DsTeG091m7zDq34L+ilKcLotYS4
         tHjzrECoslaRb8BZ7xDYzai7eSX0nFGFz7HaddtbeSUTn1tqJ9lSfjuk2WgdaRfVP8LJ
         xRjUlR9gwlGxWr6c0nas686vvIRIqjNEF0gffOlaJ6jpOaiDdsDTVI73tkOF3b6o2GZd
         67rUtL2GEz5VWETyxuIDovKTUpqmT+pC/BQ56QsAC74Otj2+F/F1eXhiIEB1vzsWSz19
         Qa6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ZUvgVDxUlWZPMsIIMx1JOHKnEA7lu7ngNLk/N7GprQ=;
        b=L1h8YYhkVYu8rV+297hbzVWShijoer8o0XP2ydTmvjBqyzA47BxQNmGlMgM4AudaEr
         +ijVjyCEz/75T+dOliG1fX8jUBSeyUDZOrJ4nYlXpdBMTMBum48u/llxzNftBk+k3TFR
         d9MymralO9FNVztgk10wAyMinnuMNazKIEVy+WfcX+MaiwTw7wLT87a9PTxOaTYYyVWD
         LDZgotND8CjZIcRrBJsxWRoQJtuZ+exTWI0z/UPURcwH18AfJG5ybyaw56P1sog+L3op
         az4CDB2F1WiV2ehvFD0jX9YqdVVw0GvtMRJ6fvM2pIHyLIU1YYvopClKmpVNNZgTdTeA
         uxog==
X-Gm-Message-State: AOAM5304OWyXVZT33AwC9hhyRuGtZuR9+BbMHyy5FZFrwgZroDJnscvb
        q2FGWzhftvQKoWvFtzgci/geYMWgK3rVGw==
X-Google-Smtp-Source: ABdhPJwmauOticopQHV0gJxQ4g8Yfwl6djNHxIc7nhKH+d6lYpg3EVbS4mWdA5+UNdnUOYDg8BsIsQ==
X-Received: by 2002:a17:90b:1e43:b0:1c7:46bf:ba29 with SMTP id pi3-20020a17090b1e4300b001c746bfba29mr279480pjb.100.1649093365499;
        Mon, 04 Apr 2022 10:29:25 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:eb9])
        by smtp.gmail.com with ESMTPSA id g6-20020a056a001a0600b004f7bd56cc08sm12880787pfv.123.2022.04.04.10.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:29:24 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v15 4/7] btrfs: send: write larger chunks when using stream v2
Date:   Mon,  4 Apr 2022 10:29:06 -0700
Message-Id: <5aa3b439e5965abae9889660b58f1dc92c3a81d6.1649092662.git.osandov@fb.com>
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
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c | 47 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 1f141de3a7d6..c0ca45dae6d6 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -82,6 +82,11 @@ struct send_ctx {
 	char *send_buf;
 	u32 send_size;
 	u32 send_max_size;
+	/*
+	 * Whether BTRFS_SEND_A_DATA attribute was already added to current
+	 * command (since protocol v2, data must be the last attribute).
+	 */
+	bool put_data;
 	u64 flags;	/* 'flags' member of btrfs_ioctl_send_args is u64 */
 	/* Protocol version compatibility requested */
 	u32 proto;
@@ -589,6 +594,9 @@ static int tlv_put(struct send_ctx *sctx, u16 attr, const void *data, int len)
 	int total_len = sizeof(*hdr) + len;
 	int left = sctx->send_max_size - sctx->send_size;
 
+	if (WARN_ON_ONCE(sctx->put_data))
+		return -EINVAL;
+
 	if (unlikely(left < total_len))
 		return -EOVERFLOW;
 
@@ -726,6 +734,7 @@ static int send_cmd(struct send_ctx *sctx)
 					&sctx->send_off);
 
 	sctx->send_size = 0;
+	sctx->put_data = false;
 
 	return ret;
 }
@@ -4853,14 +4862,31 @@ static inline u64 max_send_read_size(const struct send_ctx *sctx)
 
 static int put_data_header(struct send_ctx *sctx, u32 len)
 {
-	struct btrfs_tlv_header *hdr;
+	if (WARN_ON_ONCE(sctx->put_data))
+		return -EINVAL;
+	sctx->put_data = true;
+	if (sctx->proto >= 2) {
+		/*
+		 * Since v2, the data attribute header doesn't include a length;
+		 * it is implicitly to the end of the command.
+		 */
+		if (sctx->send_max_size - sctx->send_size <
+		    sizeof(__le16) + len)
+			return -EOVERFLOW;
+		put_unaligned_le16(BTRFS_SEND_A_DATA,
+				   sctx->send_buf + sctx->send_size);
+		sctx->send_size += sizeof(__le16);
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
 
@@ -7459,7 +7485,12 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 
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

