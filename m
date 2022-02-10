Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1F84B15E4
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343761AbiBJTKt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243024AbiBJTKr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:47 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F5A1167
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:47 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id x3so2680596pll.3
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gi6+d92tgyHB+QJpDwvq5G2EHHWkzKaxOB+ZQqYyE3U=;
        b=NVJSrKXpq03WgtE0lIpnGcT3LV0PbS5wKuIwTI4Muvt5OyyebtD3uW2fhoUW8PsjBq
         uWScc7ZFwDLndEboxwwxnvQMtePHzcYt76lharzti81gnnGuPMRk+QofzbPzEMfW/8Qy
         6L8J7StCI86jm0DDEGKZTiGNPq+qslLu/5zdBLNX5xW5KnSUbdNAvqiywhRwLa7DH4mQ
         W84R+Y9YS8oGnsIAtdrGTBIJzADbO3uAZOKY4hh+LfWYldzfnti+GVQtoDk6gJKzvL5I
         /bRjFfAA8yn8U5+73pd3yPDTlfxZ4rfa0qmCOUk3QPFZyrUhmAyZiTUKQ/78S8k4At6B
         dGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gi6+d92tgyHB+QJpDwvq5G2EHHWkzKaxOB+ZQqYyE3U=;
        b=FTeItxEd7hs+rE/Mu8wB/EuCfQDJ2zwfjN1WBB6H7H935uLkczgjY404RjpjRtcLwM
         MIPi44hMEVXXU8fNp8rncYs48HNr+wvhy0UO5hQKk/0ZME+FYkBVg+JbBnC9UlswWVv/
         mzthOGLx4muKC8p7bDAPusTzBcKyxSzWnW4kBSuCt97C2axjW32XQ6D6jb/K7TVIH8rQ
         spCtjRGabbPHLQV/ado86gYfYJ4r0CPBcOt51cNUkMQortVhiPZlDKJpr9jUMP3xtUT6
         m3jkdGJ1gVdCoGuaqmrdqmizzxWwIq2XbgAot+9FY2br4cXOAo2Mxip52pcQqc9DY/HX
         aG5g==
X-Gm-Message-State: AOAM531++TDlGdE1CCKZtd0Mz+HaZaXvE4vyndmeif6zHQvb4DhBbQfO
        lWOEpf0zIF083dQNlTQYUmJTjOpMrTSZbg==
X-Google-Smtp-Source: ABdhPJzThkIEjbI/LFh931zXJCg0PEkutdbXtnptEG9XoU0LgAj3cZAw+i7KC23Rld7jgBikpC+hzw==
X-Received: by 2002:a17:903:2308:: with SMTP id d8mr9053687plh.52.1644520247040;
        Thu, 10 Feb 2022 11:10:47 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:46 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 01/10] btrfs-progs: receive: support v2 send stream larger tlv_len
Date:   Thu, 10 Feb 2022 11:10:08 -0800
Message-Id: <47c969c94528f682132cc2a4aa9f263bbf840de0.1644520114.git.osandov@fb.com>
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

