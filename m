Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3CE2D2F95
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbgLHQ0N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbgLHQ0M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:12 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2FCC0619D8
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:08 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id b9so12314412qtr.2
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KAQN+81eOnjviSSky8UvHmPeO2GHWKjMNJPnZAMOWAA=;
        b=rMvB4g6f7xYo968A32MVLe59h4S/yD6jDkf9v/RRIs+fFX+Xm7rnciZSWly6u8QMYy
         lB+ylG4cNIC0npVURDE/BfqXelraKd9dCAoLXdqDWY2kp2Iw5HG0BOrWgjEKz8kTBs2n
         KE3CS5ITISFTbfLmQIXPig5jw4koWbwIBsLEFR5NPNe3VrTqtBk3c8l1RkKDDifYn4VT
         UQ3ywOjtolTUdR7cZxbwOsH8/6ZZ2qCUvKH3YKgLoaRBRSAaBiYeEEsQQ0dgNc4wmyCt
         sA1/6+O7SBazQE2uhqOW/lbr1Iy0Qqoy5y5VkUc0ql9rf1Jtm8ey57a7dcuq8/J2BmZ9
         Sspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KAQN+81eOnjviSSky8UvHmPeO2GHWKjMNJPnZAMOWAA=;
        b=VRcU5t4SgTc8gYNr6Y7hZuoR9y9zI2jEnOhbnOzoHDX28YD7pOTz8xSf967P5nB72S
         0tmF4VQIYhppieJio+sr9ZGwJLiKgkuV0CmYXWILWHEaCnZ9FKsSKpNKZ/J+7rwRLWjT
         nR2+/9t987U3+tjwBSL2x0oJhnaYqx16mzrK7CGClLA3i/zLNhEnyP6MP38Its0qgbve
         Ezvzn6k02LPd2QPuZYyp5+FuYsK8gYKV/21PH5xi5R7TJlfkmmaz3AKvLDy/mydI9p5f
         Xf6qwCI4d4AhWY61xyD8WR3Ut6uPp+YpLUgJL/9SIM2LCPbocglXFU5NaCp8dVyn7ec3
         3uWg==
X-Gm-Message-State: AOAM5306QlPfJ5ml8Su+I9PlOeFovH/PecE+rlYRgUx2GwixB4kxjaYj
        yUO+zGGPzGuyAug7ozwqRug1i7V54NVWN0tb
X-Google-Smtp-Source: ABdhPJxVyq057Vjl/9aOCxPSDgp1qw9WO+/6Ghkw0yORb6iSWJIWnk4yk3VsK4sfxtYBaoyd/lrDVQ==
X-Received: by 2002:ac8:7083:: with SMTP id y3mr30338184qto.267.1607444707629;
        Tue, 08 Dec 2020 08:25:07 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k128sm14811252qkd.48.2020.12.08.08.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:06 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: [PATCH v6 30/52] btrfs: validate ->reloc_root after recording root in trans
Date:   Tue,  8 Dec 2020 11:23:37 -0500
Message-Id: <35218dbcddd916f169601b25ba62ce2879956d90.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we fail to setup a ->reloc_root in a different thread that path will
error out, however it still leaves root->reloc_root NULL but would still
appear set up in the transaction.  Subsequent calls to
btrfs_record_root_in_transaction would succeed without attempting to
create the reloc root, as the transid has already been update.  Handle
this case by making sure we have a root->reloc_root set after a
btrfs_record_root_in_transaction call so we don't end up deref'ing a
NULL pointer.

Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index b7a8a5b44a16..ac5350dfb33a 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2073,6 +2073,13 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 			return ERR_PTR(ret);
 		root = root->reloc_root;
 
+		/*
+		 * We could have raced with another thread which failed, so
+		 * ->reloc_root may not be set, return -ENOENT in this case.
+		 */
+		if (!root)
+			return ERR_PTR(-ENOENT);
+
 		if (next->new_bytenr != root->node->start) {
 			/*
 			 * We just created the reloc root, so we shouldn't have
@@ -2570,6 +2577,14 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 			ret = btrfs_record_root_in_trans(trans, root);
 			if (ret)
 				goto out;
+			/*
+			 * Another thread could have failed, need to check if we
+			 * have ->reloc_root actually set.
+			 */
+			if (!root->reloc_root) {
+				ret = -ENOENT;
+				goto out;
+			}
 			root = root->reloc_root;
 			node->new_bytenr = root->node->start;
 			btrfs_put_root(node->root);
-- 
2.26.2

