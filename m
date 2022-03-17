Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6FE4DCC59
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 18:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbiCQR1Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 13:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiCQR1Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 13:27:24 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0495114FC9
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:07 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mz9-20020a17090b378900b001c657559290so5860867pjb.2
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jf1xcgurY+im0KaPf7PvoqQR+BSeNSxrsqeoOhcfrkk=;
        b=Yi+9GpIuJvJs5KlfTtLg5XhEneji0geyrYVS0PErYGrC9hW1vlWUhxnhONsGqsgXgy
         7xJ9jcy/pK/c2EZaval+ZtyJRu106QQFEEFF+iQX4RDU6ho8an6Dpqr+6GUujQpKwb7R
         UIG43O+vFTUdxhHBxnrE6WoU+x/bLfraCTIA+JngQml/yJRldLffdWNBZ6JlCvpia8mu
         zLhRuxcAmPqHqCeRAhoeCocQ4/O+UvEYrY3gx7u9N1cxrBhNR1OodfGC9RKzYLRDTIhI
         aQevED9INssIRJrDiGIsxKdkIhT1J3DcG2T7zaumEUQGXvDf+eihN3/vYYXadp8f/7Gc
         CJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jf1xcgurY+im0KaPf7PvoqQR+BSeNSxrsqeoOhcfrkk=;
        b=aQI8fMUk3f8krfUYpYdtYAFTCfgr2vUmHT2AifQxzVF/EW04jwMg6YfmugeT4lf+7e
         Y563+jxc7MV3IC1+3757z9N+FYLwLNEJ7qysrzG2Q+WGI7bZ0Xn9P5onI5yhNiU1MOdW
         X7qt86zcFvFpa377K7TACr/yOqdnyV+6E3/0m10OiO4BFHA5EKnc9J8y/aVGKkoD2lx7
         lgm8qeO/v+QFZ+xW6Wdhaq2FyPQSxrvhoITBWEqVe/wQ1ymRa7GZhRoQwDSyiD55BqMN
         6hHCOcW0+vjyggcn0RnYB6scP0gcxvrIQ8K9Ikx0Oe/K/3g5PL2KnekqqbY8zG47ma0i
         yqPw==
X-Gm-Message-State: AOAM530cTwhMSza8mfSGTlsNKi1flxhUNXOea+i8ZPf5tfep50S4Ecgf
        tDKmkf+e5gFHG+G4Uus00ZpjPaOo09BunQ==
X-Google-Smtp-Source: ABdhPJy/ntVhxtNZewL9c3b912HL6JknQ2JX0mdHVq0qC9Zo+4r5rPfbZ9xCjEnGKR3sUFqXHoVW1w==
X-Received: by 2002:a17:90b:3145:b0:1bc:5855:f94d with SMTP id ip5-20020a17090b314500b001bc5855f94dmr6617224pjb.55.1647537967081;
        Thu, 17 Mar 2022 10:26:07 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:624e])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00088a00b004f7ceff389esm7815424pfj.152.2022.03.17.10.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:26:06 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v14 1/7] btrfs: send: remove unused send_ctx::{total,cmd}_send_size
Date:   Thu, 17 Mar 2022 10:25:37 -0700
Message-Id: <a2fc85b1959d487f08337a3977fd9f75dd28a231.1647537027.git.osandov@fb.com>
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

We collect these statistics but have never exposed them in any way. I
also didn't find any patches that ever attempted to make use of them.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index cf86f1eafcb7..6d36dee1505f 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -82,8 +82,6 @@ struct send_ctx {
 	char *send_buf;
 	u32 send_size;
 	u32 send_max_size;
-	u64 total_send_size;
-	u64 cmd_send_size[BTRFS_SEND_C_MAX + 1];
 	u64 flags;	/* 'flags' member of btrfs_ioctl_send_args is u64 */
 	/* Protocol version compatibility requested */
 	u32 proto;
@@ -727,8 +725,6 @@ static int send_cmd(struct send_ctx *sctx)
 	ret = write_buf(sctx->send_filp, sctx->send_buf, sctx->send_size,
 					&sctx->send_off);
 
-	sctx->total_send_size += sctx->send_size;
-	sctx->cmd_send_size[get_unaligned_le16(&hdr->cmd)] += sctx->send_size;
 	sctx->send_size = 0;
 
 	return ret;
-- 
2.35.1

