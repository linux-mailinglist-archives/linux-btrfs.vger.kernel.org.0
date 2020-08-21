Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A862D24CFA0
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Aug 2020 09:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgHUHlA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Aug 2020 03:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgHUHkj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Aug 2020 03:40:39 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88429C06134B
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 00:40:38 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h12so612676pgm.7
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 00:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JFAMcNBeivcc4k/D1mv4WcL2veok/NfrY9vh2qEzzpM=;
        b=Cg9yXq6qiX/FikDgdxq25sWcM+c8DvlK0ZNxM6qyEIawI+uFARvEYX7D2IdHU7vljA
         1JkUbflbgtdtgMNLU7ToTvnXo82MRTRK858G0wJUwNqm4FE1D143kD88nM5uNmlGlpDH
         +yV1RvV0oaSspXorMF8WsD6RDRSENN7KtmEYkp5B3iKmUUD60aQZKMcPZHZNewk98fZR
         IRSYqAbLlwDOmyihGKQ9eszLFK2qx7EKE3JYuwv7/EAY9JujP2DYpaZyvcRGcCx/LI2C
         xtxTj65PqeWGFMY2sl1T/8ojK2E2ZuiU4meobMrTHdvoJfAmiVQvFs7SFOBpyKiotU3u
         is0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JFAMcNBeivcc4k/D1mv4WcL2veok/NfrY9vh2qEzzpM=;
        b=HYgJmIwJL3oseNiYVGX+liF9h1ocPGjivPoEna2T/8CRbj6TWNtxIlS9iXtjmVMi+x
         fnQQ6N438YM4k+QnGJXXMZ2OXcDoKYIq5FDdE9SRjQfWnPt29oOVZmh1pPFOfZGzW/pT
         Qa+gVHCfHohkPJafWpwUNXphmBg+VvmS4E/trCv9EgFefc8RQi+/fyGJJN4WYpEroPAR
         VC747nsXwWFz9gvIz0gGJIESK82Z13GEzO7tRD0ZXcj2aEQTETf/JdSUJSL3EGbGy55M
         v9NtGuOoGuC54rqn42hf1m5EG17PUqIKhpt7ubceQdoruC6H8wyWkE9ywwpW38ve297E
         ZONA==
X-Gm-Message-State: AOAM533y3yFBHOrVfTnqm5zX+BjnQdzLZjtNdBeMKJMZPnXOq1XgDndT
        A1mIyD0ob5GqH+ZI2/guMODpjB2gAJbhpw==
X-Google-Smtp-Source: ABdhPJyuvVo+kNKYPRctAwtikIcLQxvLHCN8pSLGjD6t8SlGza5ojUuWQZsRMkmQcMby/FvfpCuG7Q==
X-Received: by 2002:aa7:8f07:: with SMTP id x7mr1507100pfr.2.1597995637360;
        Fri, 21 Aug 2020 00:40:37 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id jb1sm1080875pjb.9.2020.08.21.00.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:40:36 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/11] btrfs-progs: receive: support v2 send stream larger tlv_len
Date:   Fri, 21 Aug 2020 00:40:00 -0700
Message-Id: <c8c965765a909fc89e5744e0450161a80496c16b.1597994354.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597994106.git.osandov@osandov.com>
References: <cover.1597994106.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
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
index 69d75168..3bd21d3f 100644
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
 	int fd;
 	char read_buf[BTRFS_SEND_BUF_SIZE];
 
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
2.28.0

