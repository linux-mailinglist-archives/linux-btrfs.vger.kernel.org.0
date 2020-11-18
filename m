Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE992B84BF
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 20:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgKRTTZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 14:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgKRTTY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 14:19:24 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7177AC0613D6
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Nov 2020 11:19:23 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id bj5so717584plb.4
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Nov 2020 11:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P9Kdu1iOQxHZHPzLsKpiyc2lmM69laJRMX8/k+zeI9U=;
        b=HnwigP052OdRCU9TTvxKjsmCRiFnZCItgfljMLRQV+kUfZPqlxT76tlV5nK13Gn9ZV
         8/Ab8Hh+MwMHIMPqCSjIYF+GsIRD5icuJTkNG9qX2f52JlPZo4VjO5oA7TrbT3EhX3Zr
         ioGBhNQsCOSJ9XDIf2jbz7arirspi7eDFG+j3aZtk+ybdQQxSANNvmlCnz2LByRnpBNV
         1Z0cJPip3ujM2/hONn7eZKPW8wS8wpWkGdhDhhl8k5O0u/nMHSkVL3fKPqM+/spTJS2N
         Vek9l/Gd/s779eTHzJd01ifO7vS5nPgZOljuUb59vYd64tXsXBmsLENuFMzedrwkeIGp
         wSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P9Kdu1iOQxHZHPzLsKpiyc2lmM69laJRMX8/k+zeI9U=;
        b=UN+7uQyEOrqYRPa6RMCXFDql5amIjwl+iBQMmOU8PC8jUpC/rSk+zz+Gt+gGjOzJOG
         g/6/14H3kC4g5DA33Z6aoJfwXGBsHoEz2/AFUuJbGrakndqf+rotXJr9tOfIl1NH3AvI
         h5QMcKgFt9outK6u9eVSsmU2+yjDf9pMP9dwYTMvdJXzBuGvwHYD8cNi4Qxt8UAS/9yD
         gLtWsHY2isLqCDuQHfbRvh36QrkIoifJnz5Bz+Fl2fODU/cL1LMBLP/FujJP1BZ0d3aJ
         8i5XatmkC6hDULJOXmCFk7AdMarVQEQpjhoLzn/1NxQLj6a/VxYLdVaWw4ofShXX3smn
         nXfQ==
X-Gm-Message-State: AOAM530yF9x7hmamDwiuMGhvtcJ9Bry9sAV1UA8DsCFoMt8Iqgpc7OBG
        z0jH96B+fe+cumQndkQqMzLgM/amRwi+ew==
X-Google-Smtp-Source: ABdhPJynB/3z0rxiPUbMCU413edbSddUD8pbNkI6RYQQryN1QHsqK3UrdxKuCwPlg4Lqw15YCYw9GQ==
X-Received: by 2002:a17:902:bb94:b029:d6:edb2:4f41 with SMTP id m20-20020a170902bb94b02900d6edb24f41mr5762832pls.3.1605727162314;
        Wed, 18 Nov 2020 11:19:22 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id l9sm3197221pjy.10.2020.11.18.11.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:19:21 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 04/13] btrfs-progs: receive: support v2 send stream DATA tlv format
Date:   Wed, 18 Nov 2020 11:18:49 -0800
Message-Id: <514c65bbb59958b3e7504cadc3c708a48771d39b.1605723745.git.osandov@osandov.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605723600.git.osandov@fb.com>
References: <cover.1605723600.git.osandov@fb.com>
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

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/send-stream.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/common/send-stream.c b/common/send-stream.c
index 51a6a94a..77d5cd04 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -165,28 +165,44 @@ static int read_cmd(struct btrfs_send_stream *sctx)
 
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
2.29.2

