Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4674339844
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbhCLU0U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbhCLU0C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:02 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A11C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:01 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id 130so25672317qkh.11
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4FFcEtxwSgtNWqhcRxM+yT++TU/naLF4VcA5kbiH73Y=;
        b=sN4TSMoI+B7xLo5YICtMkO3Ncj20FrZb8rxKQaoNoP7te6iOd8HOVKyIqlJzFuqLsU
         u9mC/pYaqkDWIhuWzGaIWRekPJzmCLaVBR7RsDzXy0R9xb9ZMH93N6gdJlUZbot9nJkJ
         Hos7jWSVghP3m3XuJ6ltb1gWzlwJ+L+AB0SXY2wPmWI1lusxmOYcUqPthRmwlZles+Ak
         R5nbMfq2kuYd4YkU6Iz6Cei0yR8j/8xME+BewrxiPH/Cu1KwR5X+H+76v03AX9i3aqJq
         ISkyYdOH6eFWOS1v+P+bDt98kH+DZfw8rgyPWUXt6heY1bZT+fcFQXHMYNJR15pZG0K+
         ZQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4FFcEtxwSgtNWqhcRxM+yT++TU/naLF4VcA5kbiH73Y=;
        b=ZDHFqvV6SlHj7tCwShquK4TEwHYDpAhQBStyl4wxM18h/57z3TmwhreEGT4AMvNjOT
         VD2/0WqMuwaIwgKnKIsXJq5wLacGyPWCTmlyW283TIPlkB3U/YMvikzVMSbWi4Lg9wL4
         XglIW6/+QS0QRM1vUjjbIq9WYn2VjpbUS+9hPir+4urLT5yiY7vx1d02oP+Xm8VhCdiV
         EqlntW3QM+aCAzQMJBOTxRWjZ0jjqq2HqOOukQhhU8cU+Fe8etlGE8AIHCmUBGP7KOei
         89OrTbAl572b8t3pk2ky+cqcEDdi+eHSPUo7YUd3190Bqf7MS7txtXo312FKDEAdiYSP
         OUEg==
X-Gm-Message-State: AOAM531EWSLX7ny6Isgtyxuys5lkkNZHLOo/bi7GIvyrCBDp4kBdzW+P
        SljzsRMCtxmB/CUUfeBLl16fSwT4U/ELF+Ot
X-Google-Smtp-Source: ABdhPJw/opq8sDnkCCoB97qwgKWRatoISdcHbmCV5PnlhBLBBmFTOyHcjG0fbM3xPdFEw4lJgmlOlA==
X-Received: by 2002:a05:620a:555:: with SMTP id o21mr14705192qko.207.1615580760908;
        Fri, 12 Mar 2021 12:26:00 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i93sm4690293qtd.48.2021.03.12.12.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:00 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 16/39] btrfs: handle record_root_in_trans failure in create_pending_snapshot
Date:   Fri, 12 Mar 2021 15:25:11 -0500
Message-Id: <a4ea225b5cd56d936a9655c3e5497121d8f0635f.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
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
index 7ee0199fbb95..93464b93ee9d 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1593,8 +1593,9 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
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
@@ -1630,7 +1631,11 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
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

