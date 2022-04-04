Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41E44F1C5E
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 23:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382304AbiDDV0l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 17:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379565AbiDDRb2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 13:31:28 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20726248
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 10:29:31 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id bx5so9366603pjb.3
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Apr 2022 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+bcVRbvd3UtT7tmbXMYnvHtj/DyDr9gEuWNPzuVz+28=;
        b=huVYwsT5Mqq2oJJYwM4eeFv78o5fsk96H8aelxt4GL2fHBa2bV7MTEa6VZ2bggRsfh
         9xZIWFZ09EtRmP9SzwxO+ZRgjfm668kWASXNkg22fH4e7Pvpn0FYhivlZFCG64yQFhyZ
         CCE90FXLcxr3UdToMwiNo5Nzg660KSqxAoIshroiDUuimw91CSDVYzbZe/Ys/zVNjKuN
         3JH1rQeJMIiMwzpe26IZdUuC+7w7IpklGZLJEodGd8YKjlZcvgSaRujVmJkvpD8egAm7
         fxLO9HOdFmFZG8KtgnbUMyJ+lMn6Ba+vDqvsxWzaioALHd09mvrWWgzyZreZOl2TKwop
         r0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+bcVRbvd3UtT7tmbXMYnvHtj/DyDr9gEuWNPzuVz+28=;
        b=BLWY/5j67PCzWeBQHXpvz+ztqZRlMEUs+EL9zuyiGrwHTUVnd9Bj9pv27rBQfLVRM7
         Med+JQ6h4mf0XTDwHg1BUg6EGit38wf8lK6/hwMloEajP3/KSjVaMmV3Z65ePYQkIAHd
         l43/ztKBFxxkNtNTuFTpT6S6dDmAY7Cq7Ee3ooVB7w5sXqS1/eSnhN1oN1T4/XhCnJYA
         MGDj6QkrDpM2bFPFMAEpiWlx6kisbzIF6/+rlgsGRyFifJ+e2X+oBCtZi2mb64OBv/Br
         Je2A8NpeLu9Z2KvH0kdVa9k0uvbOeat+Uza69dgLrorIUgXyr7dEe1oWtpgKoe4X7k3s
         CwGw==
X-Gm-Message-State: AOAM532lfBJ2hbDXEPxnQQ8jUGa9AiIxQFj/SBO0Z5dq4D/Ani7TwtfB
        s9g7FuXNErADhGSaQH1AbxWip697hHuV0w==
X-Google-Smtp-Source: ABdhPJzLY5vHDtF8UBEuPbcL7Tjqy0yt0K4QDHBIKBOVhtX+J/bVIn0dZybN9OkEuaLiLOw51ugeQA==
X-Received: by 2002:a17:903:124a:b0:154:c7a4:9374 with SMTP id u10-20020a170903124a00b00154c7a49374mr740976plh.68.1649093371058;
        Mon, 04 Apr 2022 10:29:31 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:eb9])
        by smtp.gmail.com with ESMTPSA id g6-20020a056a001a0600b004f7bd56cc08sm12880787pfv.123.2022.04.04.10.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:29:30 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v15 7/7] btrfs: send: enable support for stream v2 and compressed writes
Date:   Mon,  4 Apr 2022 10:29:09 -0700
Message-Id: <0ee5b87f9ee41b8061a07bc5b2a433123ddf2c0c.1649092662.git.osandov@fb.com>
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

Now that the new support is implemented, allow the ioctl to accept v2
and the compressed flag, and update the version in sysfs.

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c            | 7 +++++--
 fs/btrfs/send.h            | 2 +-
 include/uapi/linux/btrfs.h | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 675f46d96539..1447b01c0bda 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -694,8 +694,7 @@ static int send_header(struct send_ctx *sctx)
 	struct btrfs_stream_header hdr;
 
 	strcpy(hdr.magic, BTRFS_SEND_STREAM_MAGIC);
-	hdr.version = cpu_to_le32(BTRFS_SEND_STREAM_VERSION);
-
+	hdr.version = cpu_to_le32(sctx->proto);
 	return write_buf(sctx->send_filp, &hdr, sizeof(hdr),
 					&sctx->send_off);
 }
@@ -7667,6 +7666,10 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	} else {
 		sctx->proto = 1;
 	}
+	if ((arg->flags & BTRFS_SEND_FLAG_COMPRESSED) && sctx->proto < 2) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	sctx->send_filp = fget(arg->send_fd);
 	if (!sctx->send_filp) {
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index 805d8095209a..50a2aceae929 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -10,7 +10,7 @@
 #include "ctree.h"
 
 #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
-#define BTRFS_SEND_STREAM_VERSION 1
+#define BTRFS_SEND_STREAM_VERSION 2
 
 /*
  * In send stream v1, no command is larger than 64k. In send stream v2, no limit
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index b6f26a434b10..f54dc91e4025 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -788,7 +788,8 @@ struct btrfs_ioctl_received_subvol_args {
 	(BTRFS_SEND_FLAG_NO_FILE_DATA | \
 	 BTRFS_SEND_FLAG_OMIT_STREAM_HEADER | \
 	 BTRFS_SEND_FLAG_OMIT_END_CMD | \
-	 BTRFS_SEND_FLAG_VERSION)
+	 BTRFS_SEND_FLAG_VERSION | \
+	 BTRFS_SEND_FLAG_COMPRESSED)
 
 struct btrfs_ioctl_send_args {
 	__s64 send_fd;			/* in */
-- 
2.35.1

