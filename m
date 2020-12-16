Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BF82DC43B
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgLPQ2n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgLPQ2n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:43 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D436C0611CF
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:21 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id 2so7751418qtt.10
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9hOXGC3DnsDO3Kd/HEm9Zs86pTFCYvHzCaxadXwdWVw=;
        b=DjhYC+2XCpoXR8NUqSNphVIeBagZnVgJ3q4SuPCcmMwBeiccQBeeQFQd5KQ5qp2cGI
         0KytnGLVkCZ6J9+FZyPQjF8qNNlbcWLl1s8MeLpvWaeb3kJbxoKbFDGOhvI10xyF/KCD
         M65sBY3vT9eMkIPMkpxAKunmWqJDx+wSUOsxhr4kWOVMmWFgEwSwrA8Wcb/7vzBNGdlV
         hjJWT8Uy+CJhYFWWJtDu5U8FE8yHRYQ8+UM/wBDDkcXRmZUR/k8lbPboxQt9byLZwj4O
         YbnCQNo3a4B/aY67VncFhoIj1YpQmweDmbsQRcKgJaAwthCc61VDd7dfA0chYlcCYP7R
         wr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9hOXGC3DnsDO3Kd/HEm9Zs86pTFCYvHzCaxadXwdWVw=;
        b=lja2xYmukfkeeY/bKtexrh4hC8R0CtwqyjTw2zVKpnxVNU/76hB8aD29godH0QyVOB
         caBbBD1asitF2+JXVCrQvHDyldc3FlF4CEB1a1W4BGV2oqg6JZblLcMJa/av4R+05dkY
         Dy357yMQP5GWQ/ct33XGkzPEGJXu/9oZyZT3fAigkPpM4vDMlgEC2BWgW3XSI6VmkPE9
         2aCFVn17TEK9r6Q2d00WW72LglSse6EUtw5IO6xOPj708MDCOtksRTyRjOoPSVbQ8UI/
         sqagpFH1oOEECUo9VrmGtq+9pLyX1eWFaKf6RzFtBr4Ve3PnwTMclezQ2Hx5UVuPhJie
         67Tw==
X-Gm-Message-State: AOAM532wjnem0jxqHyYzq64DwLJMIhQacVfI7fGs2kqdDU3d3LctOipT
        /C9gPaV1XTs7w6GeWltLt76UXdQRBP2v5krU
X-Google-Smtp-Source: ABdhPJz+Znlk5UrAi4TGbWc6U1u4I4Qljj3+PSA4NkcoqKZmYuSYubEjXCZGeneCunscmG1h/HNFOA==
X-Received: by 2002:ac8:6bcc:: with SMTP id b12mr30210928qtt.55.1608136040399;
        Wed, 16 Dec 2020 08:27:20 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m8sm1418983qkn.41.2020.12.16.08.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:19 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 14/38] btrfs: handle record_root_in_trans failure in qgroup_account_snapshot
Date:   Wed, 16 Dec 2020 11:26:30 -0500
Message-Id: <07dce3dd12b43dd0d6860c54e1eec87543cd7212.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

record_root_in_trans can fail currently, so handle this failure
properly.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 307a73abe86d..5b3008ec4e13 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1436,7 +1436,9 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 	 * recorded root will never be updated again, causing an outdated root
 	 * item.
 	 */
-	record_root_in_trans(trans, src, 1);
+	ret = record_root_in_trans(trans, src, 1);
+	if (ret)
+		return ret;
 
 	/*
 	 * We are going to commit transaction, see btrfs_commit_transaction()
@@ -1488,7 +1490,7 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 	 * insert_dir_item()
 	 */
 	if (!ret)
-		record_root_in_trans(trans, parent, 1);
+		ret = record_root_in_trans(trans, parent, 1);
 	return ret;
 }
 
-- 
2.26.2

