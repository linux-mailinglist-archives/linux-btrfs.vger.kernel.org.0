Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BF1454E73
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240702AbhKQUXg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240691AbhKQUXT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:19 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BD8C061570
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:20 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id u16so2920696qvk.4
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1IDJC+YgqcerT+HP5BtWrTTpUXBS1JgLtSndJRbJp2U=;
        b=Ct2UwYlbcsuiyhrPQVUhVQw97+SiglmyBsUHS96JKCZZXFHLEBD1usQG+0v0kjHijP
         ZheSACpO7IZNLlVrIOxRChL3UBVsZADr+zeKwZOQC7AP+NMlQg/qHZrYkbNVR2rIK2Xr
         QbQcuV8D0ANgoIGt5ml7FE8APuZnWMX/2zAY6fZVpy7aVKfJjJ0W8ibB/0aaT0y76gCi
         qycLIrr9C53bKTcoKEnsXmFjCmydULbjGVRefRAfYf4Y29axDwUhaEsrgnpVTddTvDJj
         Sol629Z9LnJGjR1EDekOKcU5gG8P/phKFfVLFqUQ1ajzkEZebwkiBlf+lQDznZ22Zs2g
         dWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1IDJC+YgqcerT+HP5BtWrTTpUXBS1JgLtSndJRbJp2U=;
        b=ayqMbGzdbnu8B0t9NVaWfjbG2b7iNHsqyNbqWKwfvYFOOSXjGFHhRdiJXhVxikC7Bp
         z3a0t98cTY3vXW99zkwbRlomUWTdn58ULfdioqr3NYeiyTkVjP3PIKHnCcqcJvenjRTd
         tw2+9k01RFfwTKA8SRImnNpbrGdyUauI7bzvDyD+vU0UQTW4Whxv8LuIf+Grrpb5N8gf
         uESWHhCfMqKTwqEBLPXANSfKLwR31+oP1nhWYdOthjrOYLZDp6ftadZ2SUuC8DpOW5fk
         gnmfGdushjs/+HZdMwWHnPr0g63j8Kdt3OlE/n7YU+IP/WTda8K28UdHH6ysI6gLOnkj
         W23g==
X-Gm-Message-State: AOAM531Q6avWwekQVkCWav5R7LAt7UZ7t2Fu+VF+FchDAzYHjrpB0o2R
        A1AwOeYll+nJheKSHqPqOEmOD1u+nAgz5Q==
X-Google-Smtp-Source: ABdhPJwplsY2uORWr2/x46RJ6IojokjTTHAi/o/SR9yTbE+NzYMx1xLiyv0VZIi6HnTwB/GMFawBaA==
X-Received: by 2002:a05:6214:500b:: with SMTP id jo11mr57902921qvb.64.1637180419773;
        Wed, 17 Nov 2021 12:20:19 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:19 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 03/10] btrfs-progs: receive: support v2 send stream DATA tlv format
Date:   Wed, 17 Nov 2021 12:19:30 -0800
Message-Id: <71e8b23a0174134ee1d6d9582bdc0eef8dd9c35e.1637180270.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Boris Burkov <borisb@fb.com>

The new format privileges the BTRFS_SEND_A_DATA attribute by
guaranteeing it will always be the last attribute in any command that
needs it, and by implicitly encoding the data length as the difference
between the total command length in the command header and the sizes of
the rest of the attributes (and of course the tlv_type identifying the
DATA attribute). To parse the new stream, we must read the tlv_type and
if it is not DATA, we proceed normally, but if it is DATA, we don't
parse a tlv_len but simply compute the length.

In addition, we add some bounds checking when parsing each chunk of
data, as well as for the tlv_len itself.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/send-stream.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/common/send-stream.c b/common/send-stream.c
index 421cd1bb..85b9998d 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -168,28 +168,44 @@ static int read_cmd(struct btrfs_send_stream *sctx)
 
 	pos = 0;
 	while (pos < cmd_len) {
-		struct btrfs_tlv_header *tlv_hdr;
 		u16 tlv_type;
-		u16 tlv_len;
 		struct btrfs_send_attribute *send_attr;
 
-		tlv_hdr = (struct btrfs_tlv_header *)data;
-		tlv_type = le16_to_cpu(tlv_hdr->tlv_type);
-		tlv_len = le16_to_cpu(tlv_hdr->tlv_len);
+		if (cmd_len - pos < sizeof(__le16)) {
+			error("send stream is truncated");
+			ret = -EINVAL;
+			goto out;
+		}
+		tlv_type = le16_to_cpu(*(__le16 *)data);
 
 		if (tlv_type == 0 || tlv_type > BTRFS_SEND_A_MAX) {
-			error("invalid tlv in cmd tlv_type = %hu, tlv_len = %hu",
-					tlv_type, tlv_len);
+			error("invalid tlv in cmd tlv_type = %hu", tlv_type);
 			ret = -EINVAL;
 			goto out;
 		}
 
 		send_attr = &sctx->cmd_attrs[tlv_type];
 		send_attr->tlv_type = tlv_type;
-		send_attr->tlv_len = tlv_len;
-		pos += sizeof(*tlv_hdr);
-		data += sizeof(*tlv_hdr);
 
+		pos += sizeof(tlv_type);
+		data += sizeof(tlv_type);
+		if (sctx->version == 2 && tlv_type == BTRFS_SEND_A_DATA) {
+			send_attr->tlv_len = cmd_len - pos;
+		} else {
+			if (cmd_len - pos < sizeof(__le16)) {
+				error("send stream is truncated");
+				ret = -EINVAL;
+				goto out;
+			}
+			send_attr->tlv_len = le16_to_cpu(*(__le16 *)data);
+			pos += sizeof(__le16);
+			data += sizeof(__le16);
+		}
+		if (cmd_len - pos < send_attr->tlv_len) {
+			error("send stream is truncated");
+			ret = -EINVAL;
+			goto out;
+		}
 		send_attr->data = data;
 		pos += send_attr->tlv_len;
 		data += send_attr->tlv_len;
-- 
2.34.0

