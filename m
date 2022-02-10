Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975CB4B15F0
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343740AbiBJTKk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343738AbiBJTKk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:40 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368AE1167
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:41 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id h7-20020a17090a648700b001b927560c2bso5329561pjj.1
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gqizGt0Qx9qi5ldlK0GqPvkGDdm7qRBFk1/irnafi8A=;
        b=vj37FVMVRcDRkcJpW+G2yV9foeddiUPDRMqKTh4YZotc9kVgcjJ14OUVt3p0PmRWKi
         sM3DZ9AjOTVGeIi2CNMP0hf2y/6auJFLRJa42Rh3BCSRAwE7uuVnOwUzYhRKVUFwjEZe
         KpA9utY+ArPRAAao+5CaviMYrD0CQLd5xv08k0xOZnW9OqFYqO66xHfkNYPSmyFhymb5
         uxqf1CwF/uo7EKg6zvi7DnCZrygQGGDa98d/KNIoqO0GkBlc2PlFzHi1B9CX4a+YUAFo
         ksTxhKv6HnREgnyE07RAMR8XAvne/j/g6v12kbgWn4wRVYYRIS1cVGehe5IG6o7SL3IP
         X0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gqizGt0Qx9qi5ldlK0GqPvkGDdm7qRBFk1/irnafi8A=;
        b=xNWK3ZYNMB/JR6MUdeky9yLLBc51/MXY/0D7Pz6q5UxqtEzd11Yyd3l/hDaoh4UXYA
         02/5YsDHzpJr+iUrLzE6lzWd9lg0hrmrdmI1mMa+rjZhD3N09H21BxGr8x/wTn72R3E6
         LY/G8jWcDHCbF40qY1Bp4Fbea1UaSwbAri8GVNwfI31JEVTp+iF3pE6A3IaPKoK/h/t2
         EglnxFBUdKeEpLGZu5K0/RezDYLJDAmCUETYpmUeV4fFZ7KW6lVX8c+ml3tLlAEG4EX5
         ayUROFQuF3aYOQEwydRapjOwj894/9dKc8NLUPOhe64qM7NFVZ3X4FjRKWXsPvZ+i1lp
         /QlQ==
X-Gm-Message-State: AOAM530LaJBUdbtxWpo5F3FwMjDDgV/y+KPdULVuifhBEquuDBFgZzNy
        PhBFezUGs+TJJ/J4F0Z9XK/pd8Ro7FSvFQ==
X-Google-Smtp-Source: ABdhPJzVkuDKW7MwAtt9R/DPF5tu7/xnzvcQucYgBbIIHPbKRwIXTlso+Z8ndLl8FUGFjOGsOZ6JuQ==
X-Received: by 2002:a17:903:18a:: with SMTP id z10mr8999515plg.119.1644520240364;
        Thu, 10 Feb 2022 11:10:40 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:39 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 11/17] btrfs: send: remove unused send_ctx::{total,cmd}_send_size
Date:   Thu, 10 Feb 2022 11:10:01 -0800
Message-Id: <2e6872831ec1d89ddea0bc56f0ad4aed49cb3c51.1644519257.git.osandov@fb.com>
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

From: Omar Sandoval <osandov@fb.com>

We collect these statistics but have never used them for anything.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7d1642937274..97e97aa7f4d7 100644
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

