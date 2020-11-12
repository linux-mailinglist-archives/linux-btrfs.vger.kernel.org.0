Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044E02B101A
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgKLVUo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgKLVUo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:20:44 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C00C0613D1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:36 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id b16so4983540qtb.6
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=h9ygSSXq253JJGWZ3zufdDrMZ3EOpFQIRHl9XOI4a84=;
        b=t7FPY9Gugd1YfWnIoYhyBQUcl+/1VQrOquzDFVUaz0IJci6iSMB0qZY0VKGTp8BrVA
         uLZlo6ztT+O5AJX7wtB2hVX1F9UH9CxgP6oTeOxVKw3vZCSA18yeGMQM/+3PmwUpJ5hz
         pdye2VnmmIFG5bgeVYx+Dfmt1vFp3hd8VgPJn7e8MLMI7QgUjDUHla35GI7wreoYsmnP
         NoKnQaWH9/a9XR8RyP/gPqnZdjr+Drwl0WgK2uLOvu7MSGTmnIud5f0XzH3tL5d34WsG
         CMQtEGV+Ai9lnRFoKlmXPIh6FEQbXpmcE+ZUOXmVjHdGct1gco/XzfSV10d2a5XwB6tR
         2VQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h9ygSSXq253JJGWZ3zufdDrMZ3EOpFQIRHl9XOI4a84=;
        b=mqNcxHFi7h5302Y3QBSiGfKfMqAkdEe1hoTlH9LY71n7cqt2tcNjhwr3icQOJDsA9M
         sB38G/vluv5Zn6TOEjlJs++DwZNUx/CIk4Jn/xmZxItNUc7tSHebo/Z07tt4HXDnw8G6
         UkpRSuKOc0IdLoW2iWmFk1NN0sees9n0auo8J4Ea/IefAAnHdMuDl612KmkQMFaMmEjN
         LMDzS9Nd30ao7+Udh1JKXiV8nPsa/sy8UVriYoCafntbZIXHlMJZpTB4YMq+aVfsEWfd
         1WUiM2C4VG6PeYKK6KUoJjS4lh5W9fpua4rERfHl8kXzw/2Hm17X7HIsrZqgPLG5t75P
         LOtw==
X-Gm-Message-State: AOAM533TlZy8Rislb7m9W291msw2JsUp3Ts+oLF/ANYFEFPrXghWVVgI
        FBGbgvZn5/rE2Bc8nyE1GmdHdfPLrf+6jA==
X-Google-Smtp-Source: ABdhPJx8WuwGEvtD6ovciX9YbDnTroCNkexKKUjRd9t698Yw6tk2oftH43yw7GuMpMwlWzwuetPtJQ==
X-Received: by 2002:ac8:1493:: with SMTP id l19mr1180086qtj.198.1605216035631;
        Thu, 12 Nov 2020 13:20:35 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g27sm5030200qkk.135.2020.11.12.13.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:20:34 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 39/42] btrfs: cleanup error handling in prepare_to_merge
Date:   Thu, 12 Nov 2020 16:19:06 -0500
Message-Id: <76f701f2ed23f4deed675323121cb93f4e9d64d5.1605215646.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This probably can't happen even with a corrupt file system, because we
would have failed much earlier on than here.  However there's no reason
we can't just check and bail out as appropriate, so do that and convert
the correctness BUG_ON() to an ASSERT().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 651295864ec0..32e523361240 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1901,8 +1901,14 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 
 		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
 				false);
-		BUG_ON(IS_ERR(root));
-		BUG_ON(root->reloc_root != reloc_root);
+		if (IS_ERR(root)) {
+			list_add(&reloc_root->root_list, &reloc_roots);
+			btrfs_abort_transaction(trans, (int)PTR_ERR(root));
+			if (!err)
+				err = PTR_ERR(root);
+			break;
+		}
+		ASSERT(root->reloc_root == reloc_root);
 
 		/*
 		 * set reference count to 1, so btrfs_recover_relocation
-- 
2.26.2

