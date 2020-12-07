Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBAF2D12E1
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgLGOAA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 09:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgLGOAA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 09:00:00 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB4AC08E861
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:19 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 1so12540131qka.0
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CYBNnUQukD2ZtIFsYDYk/jkUwQ6GKfqMwWqwi5Rsq7o=;
        b=OaQIqm5dhAIXzCOkxMEpc4uHL2b2gffCK8I8UfSNvopzPEu3NE8J8O+48+2Ev5+tEb
         8pwOb8Lt0mzSeyQvh7X+cT6DKAU20n6/PI1yV2EL5OvLfS8NxoTTKeRVVGlIVGtSmaWR
         exbZ0/WmGan7kUnFlMXGa9wbmJc8mPinqQR1z00p3tYJ9DWhJyWr6Rhe+Hk/SoGlQhi9
         YaAaZm8qrK8Ug3XstYCoVXZGHMDryTpNqRGd+FZeEulrTIir6EESIRNUQpoTi+79h8Km
         f26OhVE9xSGN2ztCQ/cqNYCWkXkXPJdthCuG3DUnTuJZjiT9GXAyjTpuzxAmncn9a9Ul
         P/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CYBNnUQukD2ZtIFsYDYk/jkUwQ6GKfqMwWqwi5Rsq7o=;
        b=ZsYQFgA5/yVcGteFMULvBPFX1D9nebUTr2QFYP2QZIg1tt2wixyA2lsJ3pgeK1m7/q
         2enwajVNuci7qIZ0O3wTJvaI9Ge4hhvAtDMbZapIKIl1RKLZH4+kRRb33ZK2XmH99kjI
         apeUYkEwGRNhf3GexAz12z5HWwcqUtgJRbS7dJj3V3Ml/d+PyCfvF57kdt2p/UjdDwXi
         10r5T3KSpKrScev8Hw/mpp/ubcqIICZkTGx6UJ3KjLTalTw6bgKH8d3PPqZovSblsaUk
         HML9Dw8ZaXaNBc0K/f4Z1rNxK2G6YqRcrIvAuoITLJQycHkM4xdS/4fvmmvSCwA7ioPT
         +eSw==
X-Gm-Message-State: AOAM5321hjKFyHsIBJjl3UMs0UnGxjmHo3lnQig+cs5TrupaeZrj1M2T
        tJEYKF98HVCKYIu4KX2gJR3HDaCHOFxCs9eY
X-Google-Smtp-Source: ABdhPJy83sS7U0bvPuL7Tpd0fvnWRmXpkoZVqpA51z6fRvLScHJZPdMYlD5ei8qbJ5+AMOFR4W8I2A==
X-Received: by 2002:a37:d16:: with SMTP id 22mr24217300qkn.335.1607349498496;
        Mon, 07 Dec 2020 05:58:18 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r18sm11779565qtp.89.2020.12.07.05.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:17 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 16/52] btrfs: do proper error handling in record_reloc_root_in_trans
Date:   Mon,  7 Dec 2020 08:57:08 -0500
Message-Id: <ab2a4090fdb868b685623c601f8a5a655204a633.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Generally speaking this shouldn't ever fail, the corresponding fs root
for the reloc root will already be in memory, so we won't get -ENOMEM
here.

However if there is no corresponding root for the reloc root then we
could get -ENOMEM when we try to allocate it or we could get -ENOENT
when we look it up and see that it doesn't exist.

Convert these BUG_ON()'s into ASSERT()'s + proper error handling for the
case of corruption.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index a3ad44605695..90a0a8500a83 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1973,8 +1973,27 @@ static int record_reloc_root_in_trans(struct btrfs_trans_handle *trans,
 		return 0;
 
 	root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset, false);
-	BUG_ON(IS_ERR(root));
-	BUG_ON(root->reloc_root != reloc_root);
+
+	/*
+	 * This should succeed, since we can't have a reloc root without having
+	 * already looked up the actual root and created the reloc root for this
+	 * root.
+	 *
+	 * However if there's some sort of corruption where we have a ref to a
+	 * reloc root without a corresponding root this could return -ENOENT.
+	 */
+	if (IS_ERR(root)) {
+		ASSERT(0);
+		return PTR_ERR(root);
+	}
+	if (root->reloc_root != reloc_root) {
+		ASSERT(0);
+		btrfs_err(fs_info,
+			  "root %llu has two reloc roots associated with it",
+			  reloc_root->root_key.offset);
+		btrfs_put_root(root);
+		return -EUCLEAN;
+	}
 	ret = btrfs_record_root_in_trans(trans, root);
 	btrfs_put_root(root);
 
-- 
2.26.2

