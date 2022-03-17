Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821FC4DCC5F
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 18:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbiCQR1d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 13:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236855AbiCQR1b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 13:27:31 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95531114FC7
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:14 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 6so3158125pgg.0
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gi6+d92tgyHB+QJpDwvq5G2EHHWkzKaxOB+ZQqYyE3U=;
        b=ue90bB7LH78p5BYJ3X3daYaxRHVHkkF/ixwP5CJIH97vJ648oCbnANV8HYutWyDhl0
         f9tWesIn+avnqN8dhHly1nyFdnzgeH9hKPwkAMkh5VUewOJU2OvgFvj5XSbxm+htTrw9
         BA8GwmTozhhxLBgZdV1DPqEp7DPG0JR4RPMmboT+R0jBXtUUB/DBLXj/GQ4pybRLmLqV
         tD/576I2h/ZN7DDAg2RrdkaPagluSYpDsukutPLSfVUI6UTkINMruvwUYpHNOsRdtyBn
         aaU+miTW0FSgRUtUQrBcjkO1ccVNbeLrORpA7DTsdAzybYPNlImbjnnYNyxdr08jBN27
         Fw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gi6+d92tgyHB+QJpDwvq5G2EHHWkzKaxOB+ZQqYyE3U=;
        b=y+GJbkbnzqRrBrZOgoqNkuS+kbHc0BAXa2m5vz/aW1hXQM9KiP4hg/3nN3Yy4anB7C
         b6gZeRsIhjGUPUvZlAwGLK6XaJHWzMRnI2r6hAjgrzTrD225PLEum5WTtXO+Iuu2kYHy
         csEeY859CiuoHvwSQsMH0QvXcT9YVThGaGq0uWe2I1PLoJK/txlksovxEhcYgnErbA3d
         Yx5i0dKIzBxmjA3t+LcVBz1+t/BIUeR05hICeu5oI6r7s6U6p3/+kBLV5cHNP/dgb5Og
         LfUwW2QoGw7iWPyD9sDfgL3UD5NPUH3QmImrB/WJmvGPRTCbXYHKh0qVmwIJ/vpsxUxj
         Ho6Q==
X-Gm-Message-State: AOAM533yKQkkzsNtKJSffI/QDPk/RKiWuhWHBzCc5EO6ljGzZoAB7WgJ
        /BhU0d6GjXeYOSIYB5p4CwbHusm2fkBWOw==
X-Google-Smtp-Source: ABdhPJwR+bf0DnZoX9UnoqTCO+Nqq5aT5Gp6YbB8g7loqMZfdHG7c6+XDckStF2wVUbWVPRlsa66Eg==
X-Received: by 2002:a05:6a00:18a3:b0:4f7:260b:2954 with SMTP id x35-20020a056a0018a300b004f7260b2954mr5527605pfh.33.1647537973834;
        Thu, 17 Mar 2022 10:26:13 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:624e])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00088a00b004f7ceff389esm7815424pfj.152.2022.03.17.10.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:26:13 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v14 01/10] btrfs-progs: receive: support v2 send stream larger tlv_len
Date:   Thu, 17 Mar 2022 10:25:44 -0700
Message-Id: <ee72040e17e90208140ebb762263ba7f8fba3976.1647537097.git.osandov@fb.com>
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

From: Boris Burkov <borisb@fb.com>

An encoded extent can be up to 128K in length, which exceeds the largest
value expressible by the current send stream format's 16 bit tlv_len
field. Since encoded writes cannot be split into multiple writes by
btrfs send, the send stream format must change to accommodate encoded
writes.

Supporting this changed format requires retooling how we store the
commands we have processed. We currently store pointers to the struct
btrfs_tlv_headers in the command buffer. This is not sufficient to
represent the new BTRFS_SEND_A_DATA format. Instead, parse the attribute
headers and store them in a new struct btrfs_send_attribute which has a
32-bit length field. This is transparent to users of the various TLV_GET
macros.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/send-stream.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/common/send-stream.c b/common/send-stream.c
index e9be922b..7d182238 100644
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
2.35.1

