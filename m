Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8996C2D12E2
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgLGOAC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 09:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgLGOAB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 09:00:01 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5570C0613D1
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:38 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id x13so6482469qvk.8
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6SwMiIl7xCj/qRuKVOl1tDZKoRT8yn5nA+uaKsjDZ0=;
        b=YlYMRk1aF/Smeet6IRQ8hVVmhdm5quuJ11W4jJfRV+c3C0ntJrYEUc+Kv1bWpl3s43
         tegUG1254K4uy/ABRs2E+9yKILi1RX0KsKsUoB+/kf7nxA4UW1y6IP/1ZIopskm+jpKI
         DL/iKXF9zCBULr6U3mJ7B0YLsVMBTUlsbicIqoPKKOTNsM6oah1JeuFsopCChdg5aX7G
         yjKM7fEO3uohqV4+hVEaS6CmMlLK/Fb5npssUPRa8E+8136S60fGk4D39o3FsNDAcit5
         BS39nS+QMWPyhkfttOGF+mQe7MqSGwXTrOpfUIG7nflo1nwp6UAk/IyIaG6w1m6B41cJ
         6uiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6SwMiIl7xCj/qRuKVOl1tDZKoRT8yn5nA+uaKsjDZ0=;
        b=mpF01Fm8k3wggrkEdTZ9hhIIbDdNWLE5vp92RgxnaxuXeWBpk1WQrRVoYhNBZi2lq6
         e0t9Yhi7evcxPhq3kGMDWYjyabQgklSDyK0tftWZ62a9aqYQ3MCf/hzLZMCJKdPOudON
         ct8FG624gs1d0iWLFr5ivq4qY+47GhFT+exd/Ok/RHmlrBONNdDwZoaM3/PByWpy/f7y
         uAkNXzX+1UuSGDQ9qj+pjbcVq79v/a9p3MncKpKsmrbUDPp8wYvx0B4EJQTQSGgeizms
         ichi3Gq70HEfeoBWCBx27HqTYprlYlOUXEvAo0SV5KHGu6maqJsd4zJNLaP4YSHewMDI
         vOZw==
X-Gm-Message-State: AOAM530Uijr7DeZt51ZQLWu/6M4Ide/bpP6XFxv8AtF1sAieHD44m/p+
        MibRwEfETx6pcsGcIzwYqSKJJBQoEA4QWGOZ
X-Google-Smtp-Source: ABdhPJxVU9c8buQabnZqu2mdX/tI8jVBZ5QHC+fDLmhuWt5CvWio5n1qOFrMao5QzOme39O0HiRXYg==
X-Received: by 2002:a0c:b5c7:: with SMTP id o7mr21100028qvf.16.1607349517131;
        Mon, 07 Dec 2020 05:58:37 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s11sm12119584qkm.124.2020.12.07.05.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 26/52] btrfs: handle record_root_in_trans failure in create_pending_snapshot
Date:   Mon,  7 Dec 2020 08:57:18 -0500
Message-Id: <98b16b50e58ba61e88d4e828cab3e0e57f1fe356.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

record_root_in_trans can currently fail, so handle this failure
properly.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 087d919de9fb..5393c0c4926c 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1568,8 +1568,9 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	dentry = pending->dentry;
 	parent_inode = pending->dir;
 	parent_root = BTRFS_I(parent_inode)->root;
-	record_root_in_trans(trans, parent_root, 0);
-
+	ret = record_root_in_trans(trans, parent_root, 0);
+	if (ret)
+		goto fail;
 	cur_time = current_time(parent_inode);
 
 	/*
@@ -1605,7 +1606,11 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		goto fail;
 	}
 
-	record_root_in_trans(trans, root, 0);
+	ret = record_root_in_trans(trans, root, 0);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 	btrfs_set_root_last_snapshot(&root->root_item, trans->transid);
 	memcpy(new_root_item, &root->root_item, sizeof(*new_root_item));
 	btrfs_check_and_init_root_item(new_root_item);
-- 
2.26.2

