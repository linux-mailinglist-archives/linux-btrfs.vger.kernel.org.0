Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C331300E39
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 21:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbhAVUyB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 15:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730938AbhAVUwW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 15:52:22 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A73AC06174A
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 12:48:21 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id i5so4637994pgo.1
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 12:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pEymZbT2e7XwdrhZLYzjzmD3uYJNqriWjFNl14kDrfE=;
        b=QovdwtY9DH1sp3t9+xGragFOWmOETQFOAEumTa4hdzg5zMZ/PMClCGWkvxWjinpYJu
         5tmr1vdLH+Ao3IuONpG7qmbK86QOg2efPp2NHp20xtrsyN6uy/2mOaXUhcB0lF8RD8WA
         fSsPAYj6vQTNsPeykh55brqE2JOL6qGq+WcTTbj2yvbpKQut9CdYq/cGqLr2axEyrTBf
         R8ZujjSYVZnhsNIAQJsVBgw3SfUDRLCV0jKq8QCUCDeGYXo/HfuiRYPRUfr48k6bUgDr
         Ahpo1kquyg4BMlaptC35hrKnS3N4tGAzjzlxgoTwO5cNWh/89MbIKZZqhMBTRbnyp3SF
         P67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pEymZbT2e7XwdrhZLYzjzmD3uYJNqriWjFNl14kDrfE=;
        b=mbsnuqW/KPnOnQB2Y01jxtaJpfP9SGLWyd36QepX6SljonTGe7eHFQNhiHgpRuxaHd
         XnqEv2u4TaxzcZVP3LVI098aIf+ZarnZsi7YXdaYGjHJPLX/JrQC1T3Nza7xD9pzChpH
         KWHCxiwYTnvOeLnqNqCyy+bhPqylKW+twSMYyBd0SuXY2WIzrtnXJjo8+wD403IDxUp5
         G7+lh6fzV+3n0wG/hs8wCRoAvJkUkFSBJ+LFiEflSYvvOe6UsNjq2R1t/sx9UR/Y+10A
         yYS13QExQpZp0CG3fBO3s9bS/IvFUv7YMSkUM3LGbeUzkiq9K4dzK57nUH6OHXcks0jK
         pByg==
X-Gm-Message-State: AOAM533hM2w6/zQS7p2VMVYEc9knWe5ITbIqDa7xFAW/DJ4B6c7vfYcB
        CkWLzEM0rpIlmTJrNOKjQGc+WOLrpyBvFw==
X-Google-Smtp-Source: ABdhPJyKHxiX7QYhwimC5BveXPky/DHmXbdaeFuT0xdPTHcZ54suKNB5J5EgxU/jE7A+wm52K5c+dQ==
X-Received: by 2002:a65:5241:: with SMTP id q1mr6335206pgp.143.1611348499956;
        Fri, 22 Jan 2021 12:48:19 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:ea88])
        by smtp.gmail.com with ESMTPSA id y16sm9865617pfb.83.2021.01.22.12.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 12:48:18 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 01/11] btrfs-progs: receive: support v2 send stream larger tlv_len
Date:   Fri, 22 Jan 2021 12:47:44 -0800
Message-Id: <2792c5c7a2d5cb9cf7c7d9c8f3ef505c460c0072.1611347859.git.osandov@osandov.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611347187.git.osandov@fb.com>
References: <cover.1611347187.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Boris Burkov <borisb@fb.com>

An encoded extent can be up to 128K in length, which exceeds the largest
value expressible by the current send stream format's 16 bit tlv_len
field. Since encoded writes cannot be split into multiple writes by
btrfs send, the send stream format must change to accommodate encoded
writes.

Supporting this changed format requires retooling how we store the
commands we have processed. Since we can no longer use btrfs_tlv_header
to describe every attribute, we define a new struct btrfs_send_attribute
which has a 32 bit length field, and use that to store the attribute
information needed for receive processing. This is transparent to users
of the various TLV_GET macros.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/send-stream.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/common/send-stream.c b/common/send-stream.c
index a0c52f79..cd5aa311 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -24,13 +24,23 @@
 #include "crypto/crc32c.h"
 #include "common/utils.h"
 
+struct btrfs_send_attribute {
+	u16 tlv_type;
+	/*
+	 * Note: in btrfs_tlv_header, this is __le16, but we need 32 bits for
+	 * attributes with file data as of version 2 of the send stream format
+	 */
+	u32 tlv_len;
+	char *data;
+};
+
 struct btrfs_send_stream {
 	char read_buf[BTRFS_SEND_BUF_SIZE];
 	int fd;
 
 	int cmd;
 	struct btrfs_cmd_header *cmd_hdr;
-	struct btrfs_tlv_header *cmd_attrs[BTRFS_SEND_A_MAX + 1];
+	struct btrfs_send_attribute cmd_attrs[BTRFS_SEND_A_MAX + 1];
 	u32 version;
 
 	/*
@@ -152,6 +162,7 @@ static int read_cmd(struct btrfs_send_stream *sctx)
 		struct btrfs_tlv_header *tlv_hdr;
 		u16 tlv_type;
 		u16 tlv_len;
+		struct btrfs_send_attribute *send_attr;
 
 		tlv_hdr = (struct btrfs_tlv_header *)data;
 		tlv_type = le16_to_cpu(tlv_hdr->tlv_type);
@@ -164,10 +175,15 @@ static int read_cmd(struct btrfs_send_stream *sctx)
 			goto out;
 		}
 
-		sctx->cmd_attrs[tlv_type] = tlv_hdr;
+		send_attr = &sctx->cmd_attrs[tlv_type];
+		send_attr->tlv_type = tlv_type;
+		send_attr->tlv_len = tlv_len;
+		pos += sizeof(*tlv_hdr);
+		data += sizeof(*tlv_hdr);
 
-		data += sizeof(*tlv_hdr) + tlv_len;
-		pos += sizeof(*tlv_hdr) + tlv_len;
+		send_attr->data = data;
+		pos += send_attr->tlv_len;
+		data += send_attr->tlv_len;
 	}
 
 	sctx->cmd = cmd;
@@ -180,7 +196,7 @@ out:
 static int tlv_get(struct btrfs_send_stream *sctx, int attr, void **data, int *len)
 {
 	int ret;
-	struct btrfs_tlv_header *hdr;
+	struct btrfs_send_attribute *send_attr;
 
 	if (attr <= 0 || attr > BTRFS_SEND_A_MAX) {
 		error("invalid attribute requested, attr = %d", attr);
@@ -188,15 +204,15 @@ static int tlv_get(struct btrfs_send_stream *sctx, int attr, void **data, int *l
 		goto out;
 	}
 
-	hdr = sctx->cmd_attrs[attr];
-	if (!hdr) {
+	send_attr = &sctx->cmd_attrs[attr];
+	if (!send_attr->data) {
 		error("attribute %d requested but not present", attr);
 		ret = -ENOENT;
 		goto out;
 	}
 
-	*len = le16_to_cpu(hdr->tlv_len);
-	*data = hdr + 1;
+	*len = send_attr->tlv_len;
+	*data = send_attr->data;
 
 	ret = 0;
 
-- 
2.30.0

