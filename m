Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADCE2B1002
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgKLVT4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgKLVTy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:54 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4003C0617A7
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:50 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id v11so5187002qtq.12
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ajae6LanfBsqSBaxUZeifeaVlI2Js6AWGt5e/Vm77DE=;
        b=WC6S1LTYkA1+6QXbYtgqym0pu/WN8PRImX5oLs8N+t9UTJjNJqU2AscXzm78fdYMnv
         tXgmJuRGz8jGmK3Lmn6+qcDgPSs/yIUuZTg5k2x0Mrp1aIY2cCVsr+X16ayhFutxhWE6
         mlIkR77AoQvsfnLG5x9bOqz52dyimU8CYlKqki5pMxNaUR6Ji4RH+d6GicoFK6xEcDMP
         HCBbEVlQtn963n9nCuKsYdeByGCZhNLTqXi/LWBAVi4Qucec/Zy4BB+XQuk1DU0Dq+Z7
         9X/w09XhYFKSvZj1Cn3v1lju/4dJGBbbN0G1xDWigJWx4U/Qdd+f/mdi6PXVYkbw3RAx
         XibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ajae6LanfBsqSBaxUZeifeaVlI2Js6AWGt5e/Vm77DE=;
        b=dTajWyGPk5v0fawvATISUl1STxhdaxZDCEdldzbubW5Vf83DUXJBuVqk2pCNKC1tbQ
         wNqOCNpMlDKlJrb+rC930Q+iH59OmgdX1nkinguo2CkbbRh9/yvVcV2va7+jBAIE25Kj
         pQD64jMLBx6uaqWYSXx/ul4pPRLlwY5QpQwQHE9GeCFXuTQD2oizURWWewFMHtdO4umM
         3uLK8rXHZCDnHbLgAlrWgwv3lcAx4QHfxr/ahtOiy4k5QZ+qZcTUc2/vVfI5MQ1j0HtM
         5muCmo4blopK3yvMAYm+xUvAOHti7Jrc2MsPtp0vdiyYTGUHVLHIUaX1USnk9nARiKg+
         SQgQ==
X-Gm-Message-State: AOAM531mHNH9wklDvna2UjLZF4ot1hN4CczR4nKoLTgL5v03dqOntiCQ
        sewPM3hawkZyP8cZRDT7kzrZYmbDMkLVSA==
X-Google-Smtp-Source: ABdhPJws6i6EPoBANDeIqdGyWqfDGVFNi0dTE2aTkI0CBd6HO5CaY1GFqOaIC9qfI8VQwTpdpjOhNA==
X-Received: by 2002:ac8:57d2:: with SMTP id w18mr1173525qta.356.1605215989335;
        Thu, 12 Nov 2020 13:19:49 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u24sm5448570qtv.83.2020.11.12.13.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:48 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 19/42] btrfs: handle record_root_in_trans failure in create_pending_snapshot
Date:   Thu, 12 Nov 2020 16:18:46 -0500
Message-Id: <0d9f38722e30b67d5b52eb0ade1e70d3830671be.1605215645.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
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
index f255274d4cb5..29084716b4d2 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1572,8 +1572,9 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
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
@@ -1609,7 +1610,11 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
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

