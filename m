Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A654F1C9F
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 23:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382192AbiDDV0b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 17:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379559AbiDDRbR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 13:31:17 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152CD615E
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 10:29:21 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n18so8719855plg.5
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Apr 2022 10:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=imA3D9aZ3TlOp5Y7NLFzluU60FOr+h5IquO3F0hH3G4=;
        b=zTYoVEMnGbZXr1/aHXuNlic0EYknVj46xXaEvdChMrFC1JzYFafv10EqPEtMqwjgWS
         2e7Qvovb+yhlogwvzN6CnEGKyDZfr+2khyzQ59ad86EGaZwZ5qJaFMobAJ0VmJjRKqDa
         tLSNUor3RKstAsGTnLNlilvW3CDTqZPLlEsEYu2774dxqqsCLQkZ+E4fyZb0+fSK3aO7
         dyJMgdepq+Bez8zk2hXjd8ocozXyBYJcYyW6Vv1L++LYbmE+wtNcOEIf40Y+L6Ch1kWN
         ZijPMmNyNstVYsyZj4b/HhFjpv6JZdNCHM3MHhx7r9hTfPMQcgL7nmiPu/Fy8yijYr3g
         01LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=imA3D9aZ3TlOp5Y7NLFzluU60FOr+h5IquO3F0hH3G4=;
        b=pW/yYMtb0H2cUALUROJeaDUF+p2vn2I92gyBlrLLVo8Pd0NJPKk8zyu/NpLmx/JJvr
         NUEmETK6fvLtMigJP0Lg5dIvbdCb4CMcO0fORGxJjdn1ytjE/O2Dpn0Ssd3tBeuZIiMo
         szG6QLpiAs6DXce5ReaYmpdw+pCfsQSfx7oUEaXMlcpomCrUxTbiRMn07EIm9SMamZn/
         qSr5JeuDUJN21V8IIb2B8Gyuspd3gjz+XB1JSFnzHoKbILicw11D+Jgg+Zjcei0h0AGV
         u1VyorSDJEd/GtYlJXTgeAkjZ0ym0A+trKHIH75mrORxgd0HseSUbdSOF9nSj/3Ijim/
         hIXg==
X-Gm-Message-State: AOAM530KY17g3DBrvkBqBx6Ir45I80uqGoTHBq1I+IT19S2yZzvUACh2
        XiKCETnJeRSSVxj7qjzSrDrbCDP+qjzkrQ==
X-Google-Smtp-Source: ABdhPJwk1hE3bBHm10WPsBBoD8UixjtYq6+QSa2hGpePowtxNRcYf8On4MUXVpgjeguk+y4dlNPTTQ==
X-Received: by 2002:a17:90b:3b89:b0:1c6:56a2:1397 with SMTP id pc9-20020a17090b3b8900b001c656a21397mr220430pjb.239.1649093360183;
        Mon, 04 Apr 2022 10:29:20 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:eb9])
        by smtp.gmail.com with ESMTPSA id g6-20020a056a001a0600b004f7bd56cc08sm12880787pfv.123.2022.04.04.10.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:29:19 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v15 1/7] btrfs: send: remove unused send_ctx::{total,cmd}_send_size
Date:   Mon,  4 Apr 2022 10:29:03 -0700
Message-Id: <caf380eeecdf41dfd5dde3eeb5df61cd3be5ad24.1649092662.git.osandov@fb.com>
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

We collect these statistics but have never exposed them in any way. I
also didn't find any patches that ever attempted to make use of them.

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
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

