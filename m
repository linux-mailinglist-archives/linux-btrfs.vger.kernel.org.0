Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B372CC72F
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389820AbgLBTx2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389811AbgLBTxX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:23 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D08C0617A6
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:02 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id 7so1995821qtp.1
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=f3UGYaPU2/HXWinMncfhe1CzI/qZ87gqyzoYiNBn4Nk=;
        b=lfyK7r8LMYxBvyv3o3w2ck8hTFC6K0IiafvgDiN/uGwKAU1R25hUMMIPwzB81wiycb
         i6bM5RtE6L9GzFkd1wvs2uqXB1Akj4RtrqN5fSwTxzX6P1aFvMbnL3OMTuzhCORU8par
         lB1OuuG6Zb33oSs5gS6I+ECSC48IJHdZuSsUVvv8CxY619tKoVf7mNLrGsNM8nR12Aie
         y6f0Qp3v62onz9GowRZ7vOhlEQrVovpl+EaKZh3ZrB3YVRlw4O6eZDEzdxOLKlY008D6
         GDtJlCUVdULfI19AImB6aYPsz7VJK00Wdz7kzP6qAEXC7jR8X5F2Wr6xkpXVCUsg9pxs
         MRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f3UGYaPU2/HXWinMncfhe1CzI/qZ87gqyzoYiNBn4Nk=;
        b=YGq9dzM1cLAxTG4CsgjrCKJ/F5UPuGKiH93EzzDazJTsEl/q4gPpHxbfi/RydBm6Sr
         CNjZ4IqZpaHrco4HT+vXrJoF9gfs7qiHiP2s2BgimHWsSLcxTvJnmU7VFd6tJNKXLtQW
         RJ/aDM050DB5SbuzkjfDp7hVO6/7PbF1PTMBzROt4PUfDHgIrxNGov9XxJs1YjBXFQJW
         SmQHjbAhD3Pf3ezSx5xV9UOsxTOukxJ3bv0PjQVpAajqaBi0jW0c7yjp3Vs5JIeEuLw9
         qqMXf1KLL5g7bBffnvPOSyJPTqsvUkA+KAVdHI3uqo/C35uzSx/xydRVw9zlXvOOuA5+
         2HHA==
X-Gm-Message-State: AOAM533ljByh1XmUwZSaz4kmnscN5aYwc37nybuuCpcClhlZXGAkJxtQ
        xTaL1zp16a8F/yOdybzQLFfSd/A4NDCOSg==
X-Google-Smtp-Source: ABdhPJz2ooWI4hm78Vk484nUi97VWsJC03JqyYTN906hCHnMBVOaBw99/TfJKcOzEy6rvDAArrSSBw==
X-Received: by 2002:aed:32c4:: with SMTP id z62mr4202152qtd.50.1606938721476;
        Wed, 02 Dec 2020 11:52:01 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k32sm2811605qte.59.2020.12.02.11.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:00 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 26/54] btrfs: handle record_root_in_trans failure in create_pending_snapshot
Date:   Wed,  2 Dec 2020 14:50:44 -0500
Message-Id: <602641114c0a6c5ba07f78371a4d94fd1c442218.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

record_root_in_trans can currently fail, so handle this failure
properly.

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

