Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5583124CFAA
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Aug 2020 09:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgHUHlN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Aug 2020 03:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbgHUHko (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Aug 2020 03:40:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DC9C06138B
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 00:40:44 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mt12so461899pjb.4
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 00:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HPllMP1dggYArlaBG8NbdTKVXA2/TOK/hKcMMPnu8LA=;
        b=IP6qcyz3YWCExIoUyhje7azbZk90z3J/+FZDf98t6ckQrKngJGknpqKrixQJHnL6n/
         nJo6BM45hA6TVWMpLVxhEBKr7SLPZsVQvGGtl8pwv/9tZUaozMggjPKKrSOhf39LmKEe
         kREF5Uijlym1NEz/PLMdJvy5Y/QnT9z1YczOrRmuEwhQKtxdKseemhOOhuotGdKouSNB
         7xDy2d2dLB2NLD3hUjaWuR898WiAss4ammDiyezszjDsLinXOoWPZHjw7KRR0EwD+84g
         zQwLNiYR2WMPjlG+cr212Sk1vTbNdDGyScUDD7S54qCiYBRttx5MatrFui/tNtqplOtl
         TDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HPllMP1dggYArlaBG8NbdTKVXA2/TOK/hKcMMPnu8LA=;
        b=KRJQW1smS27lxwExahT/tG7k44YfQtSxx1wopNVlfIRolSE2pel5AEOpybSJ9r1kBx
         DybTwyCZvPPnSsGu9BwWY8QOJv9qPbLjxAenE3foyBJgNVQ4TgQHJCsSugc10DHV1+ss
         PRESCudeu3V4IeZ7dCML6BWP/3zk2HwTbrW6xM77VCOiT2/TCi5KbthIDaewj+0Bfy4R
         l5QYn+ttlqk8MBfH+IJcddggQKtUUD2Q2bUy5GF9Q2Qbp3O2Vu/t3V4KxFbkKWf9NsVk
         LFgrCoX3XgS7ush6AKQE+8NK/W/DOebX8MmonBSEDvu3qRVzfQo/imG+lthFh3z+aUSq
         zU0Q==
X-Gm-Message-State: AOAM532DBRk8ZaXl2RLQzUcQOoJbCM+W5N/X4/OA2mcYAa2qpMAxYmEU
        5VFfSqbs6yHEXbmH1ZjfxU3UZ3zF8YNyww==
X-Google-Smtp-Source: ABdhPJzjSz6B/wIUhrw81Khq6id6K/AFXO+kMSQ2LmrsdpT9MO9QNi0H3um10Hmj7H+rctPHlxvQAQ==
X-Received: by 2002:a17:90a:c787:: with SMTP id gn7mr1497597pjb.90.1597995642917;
        Fri, 21 Aug 2020 00:40:42 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id jb1sm1080875pjb.9.2020.08.21.00.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:40:42 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/11] btrfs-progs: receive: add send stream v2 cmds and attrs to send.h
Date:   Fri, 21 Aug 2020 00:40:03 -0700
Message-Id: <3477da4106d103099b41705e2a84fb58c18cbd29.1597994354.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597994106.git.osandov@osandov.com>
References: <cover.1597994106.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Boris Burkov <boris@bur.io>

Send stream v2 adds three commands and several attributes associated to
those commands. Before we implement processing them, add all the
commands and attributes. This avoids leaving the enums in an
intermediate state that doesn't correspond to any version of send
stream.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 send.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/send.h b/send.h
index 228928a0..3c47e0c7 100644
--- a/send.h
+++ b/send.h
@@ -98,6 +98,11 @@ enum btrfs_send_cmd {
 
 	BTRFS_SEND_C_END,
 	BTRFS_SEND_C_UPDATE_EXTENT,
+
+	BTRFS_SEND_C_FALLOCATE,
+	BTRFS_SEND_C_SETFLAGS,
+	BTRFS_SEND_C_ENCODED_WRITE,
+
 	__BTRFS_SEND_C_MAX,
 };
 #define BTRFS_SEND_C_MAX (__BTRFS_SEND_C_MAX - 1)
@@ -136,6 +141,16 @@ enum {
 	BTRFS_SEND_A_CLONE_OFFSET,
 	BTRFS_SEND_A_CLONE_LEN,
 
+	BTRFS_SEND_A_FALLOCATE_MODE,
+
+	BTRFS_SEND_A_SETFLAGS_FLAGS,
+
+	BTRFS_SEND_A_UNENCODED_FILE_LEN,
+	BTRFS_SEND_A_UNENCODED_LEN,
+	BTRFS_SEND_A_UNENCODED_OFFSET,
+	BTRFS_SEND_A_COMPRESSION,
+	BTRFS_SEND_A_ENCRYPTION,
+
 	__BTRFS_SEND_A_MAX,
 };
 #define BTRFS_SEND_A_MAX (__BTRFS_SEND_A_MAX - 1)
-- 
2.28.0

