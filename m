Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9693FE0C0
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 19:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345687AbhIARCw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 13:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345580AbhIARCu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Sep 2021 13:02:50 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CB1C061796
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Sep 2021 10:01:52 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 17so73287pgp.4
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Sep 2021 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uln2HVGAQYqVfchTpLKMoAipwuM7tlLjazsvAWo2m9E=;
        b=Kuf6yfFRpXAnuJEQTU1+YH+WjEDHNNKPKABTHYeCW+sm8D9rCJfd4NSoFSfXOjfK0C
         vTBcAH0ty6U7uh/8t8sPH9P7xc2NJn7JZXItAiBpNzhouWU07QQHjvVvzofCnmi+JASR
         ckSYEoHXOwSM6apmW5WNzFbTC4YMVNuYITdirI/+NSgoQGUHC5NLHoHVbpdP71ijUYU8
         VMYEbx4LRx4tGiY/FSXWm5i3TIZlz7HRDhjYniSRfqCJJcJqAXw8DOigWg1hjmAfU7iP
         I2nhba7QjKIYKdNPADvYYFG7wfMppMpFStDjoA1xho/nNXl6RqYzdUpxmzzL4xfigIqt
         xoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uln2HVGAQYqVfchTpLKMoAipwuM7tlLjazsvAWo2m9E=;
        b=Y8ocrPCjWT6b2s8wfXI6+OGgTWxpaHrYtZ3yjBqx49bXHQbk+XO7blfWhOoBVNkOK0
         zInkA5d3MesYuDthsDZie74rfesqUq72llahJ8h96YWsLHQMRtKJkr6HVlb7nNKPu6XS
         0VakJ3EA1pJRQUppdzFvO274MQy831Ji5eTcjehzFs8KnxZKNrz8teR7XbbQoPW7xxq7
         WFyQ6hBvPdhXwRtdShm7MA9dol1H2TOJ1hDUsCwTgAmd/cpWSzveDBGtrbMm9zOT2SDy
         HH20zxBT8+rlj7RaTYPmDeblyGKjNqvfIF84fwm+3Gu4nFWdKG7aigPIk3t48p6xn0Or
         SCLg==
X-Gm-Message-State: AOAM532YRYCQM1mrLFlp82gOn4caTmI9pbcgX0sjIIZSiTG9TfGBLVz2
        dnoopHXj8SdsXvbnQKPcBz4OTjFvHvPldw==
X-Google-Smtp-Source: ABdhPJzFtAnewtQI57YgBYsbiYSAQLLZbLy/4YfYZ7s+jeUlku3e7gkfS9k+6pk+4+qocnbOdhusOQ==
X-Received: by 2002:a65:62c1:: with SMTP id m1mr63421pgv.339.1630515711182;
        Wed, 01 Sep 2021 10:01:51 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:a2b2])
        by smtp.gmail.com with ESMTPSA id y7sm58642pff.206.2021.09.01.10.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:01:50 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v11 01/10] btrfs-progs: receive: support v2 send stream larger tlv_len
Date:   Wed,  1 Sep 2021 10:01:10 -0700
Message-Id: <8729477d23b83c368a76c4f39b5f73a483a3ad14.1630515568.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630514529.git.osandov@fb.com>
References: <cover.1630514529.git.osandov@fb.com>
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
2.33.0

