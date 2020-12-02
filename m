Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADE62CC719
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389641AbgLBTxB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388416AbgLBTxA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:00 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BF5C061A53
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:51:47 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id y18so2451471qki.11
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JfTJnEMdjcm0+nanpe/tTSsXhQ2cHPMfOATZbNIIpIA=;
        b=TMzL5sMyaY9pH0PKalD8c5BdLFSJpF9IsDQVK9U+YSo4ChugoYypgc04GCh2l2AvPg
         1HMzQdKFIgngsHTCY7l/ZMH0XwucgVejxnesDRhy8pyAsSETh7GfZ4NiTWRyJ+vgsEa4
         P64XasMN+P/BX8gIbzNhPoyCDCMyDoqzv2+oAQHfXji+CQ7F/P5qGpVexC+vqYCLMDdI
         CplK+iipYWEv4frKkK3dz8TESetwEPCZRcIZGjbWOMx0ZGBqde89jkuHiMv9nU9ZF0IJ
         4A7xeId3MhpZrruxQUgTLEXnIXo40VQ0PDZ1zjnQ7ZwUNp+tHmtoMaoo+bVqI1hW6WoS
         a7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JfTJnEMdjcm0+nanpe/tTSsXhQ2cHPMfOATZbNIIpIA=;
        b=Ty8Ia2MyzS6R7479GaWJ5lhxJFcOO4pqeUJdVmWgtpiX5ubpLW8trzXvObwpAjAmWe
         /rf6Z36aGL8VgNNOWV7StRs7F7vc1nxI8M0TTxbhy7BCEHPS0N2T0wccDYwN7rlrhR9W
         lORkabdmhd+0DILcXGXWr0FQnICxm4Dl/IhtOJXQv48lltx1pHJWMzF0J4Z4s253pMCw
         bkU3pVkWucxqqDK1iLU7vsPSnCCReproLq3GIcq8ekS6dJy/BR/1UuS0PPX6MFtxvXgG
         TRtPco/QCysxbbb9cy72166c4xNtIE5a0BTq6PZ5C8s49Bark+Ib7mJ7E9w8aMw6xBGY
         010w==
X-Gm-Message-State: AOAM5319qKhC62tjo9y6SPGjHRBAyQbwSS4tsE9K3YRagWz0mslMWxnQ
        tmCYgXt1bkBhID8yz0GHUABW61bNIPTcZg==
X-Google-Smtp-Source: ABdhPJxLWNHY8wcQpEVixM0wDIfiKb6zfy8uPHkXYfc/8ldHxL7ZC/HBuH8Q86bK9EXv+Kk/aT5Eyw==
X-Received: by 2002:a37:7cb:: with SMTP id 194mr4132936qkh.289.1606938703560;
        Wed, 02 Dec 2020 11:51:43 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s134sm2993897qke.99.2020.12.02.11.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:51:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 16/54] btrfs: do proper error handling in record_reloc_root_in_trans
Date:   Wed,  2 Dec 2020 14:50:34 -0500
Message-Id: <cf1b90302fa68b6ea40aa86d37153294bd4717f9.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
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
 fs/btrfs/relocation.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d663d8fc085d..5a4b44857522 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1973,8 +1973,30 @@ static int record_reloc_root_in_trans(struct btrfs_trans_handle *trans,
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
+	 *
+	 * The ASSERT()'s are to catch this case in testing, because it could
+	 * indicate a bug, but for non-developers it indicates corruption and we
+	 * should error out.
+	 */
+	ASSERT(!IS_ERR(root));
+	ASSERT(root->reloc_root == reloc_root);
+	if (IS_ERR(root))
+		return PTR_ERR(root);
+	if (root->reloc_root != reloc_root) {
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

