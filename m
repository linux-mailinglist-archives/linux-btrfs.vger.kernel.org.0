Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFCD2CC726
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389795AbgLBTxV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389787AbgLBTxT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:19 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D85C061A56
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:51:52 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id d5so1999659qtn.0
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Sg1NuD6dVVFgruSS4BU+5FD+ZRND5rY4rUtoxxk3cyQ=;
        b=ipiclPxbPor8oQbRhlDTCx66KmZ0cckJR4hYKYix35Ld8yWuQiINJgPeOX7E4Pd5dw
         ufZ1mwGccBpG47EwCjCFn9IOWJVtk/XzhKpYfSSCVXtj+OOXFZ3fjXzvErrwH1E03vL0
         7yRkDMyS/m3D0F+85wlOFEKGX+GqC/ydRmt/E873vzg9aTZGBsVnHWTak06ocT10lC3k
         Tdhuyrexw+eAaEzeHiHyRYiDRf6o62DLRSVUYWXoM8aiV1t34CymWCV3QdWfsq+aexT3
         MBMX/gAsFDplZSHjvl1l6+MQe1TOx413rBtVE+MoYWtf+LmO2ZgzcvXVWlI8ymjFHQuh
         vvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sg1NuD6dVVFgruSS4BU+5FD+ZRND5rY4rUtoxxk3cyQ=;
        b=QQy0XdDL0PrAVSrqPoGbKEywGxzBgzcyUOYK6E/sm2ri/Xoqjo9f58R17ITBesECNT
         Q6WZN5Cfcdwc8+PPWvzRvnSOFS6ecQs6GPLoioU3cGMO0p5Y58C0OSaVNVUY5NuWJeJC
         3tpzcgXZuvUGw47/vxZhpqEJoqQkRZ0D5esfyoY43zjb8ds6zzs9wrl6rPFKu4vSJ1Xj
         1oqpcVHht5lBOi8+9xBow+tbLfKT4q1NbZpnMHMjZTumXGZrn3SQTgHASrEHans8bdG2
         +uAwbjIINJVpIucHnbch+GOpMY6TFWRHWvtDdPw6ERv4DOeSqc7pJlSfhlai7tUz9OoR
         Yl6A==
X-Gm-Message-State: AOAM533bJzG37Ne+qv1w8E6P3mwLeepkmHXq4wDYnzvEkxZCGjHG1Kmd
        gTnMG6CtlsXdejstImIYjbyDJEZHtX/MWg==
X-Google-Smtp-Source: ABdhPJzNlP/IUIwhY9jT755T8pnj5Uzey6L1BoGNPcRxCBAm5+8XzY/5qcY3nK/4kNdfwScmfnQ89w==
X-Received: by 2002:ac8:6d0:: with SMTP id j16mr4329523qth.106.1606938711213;
        Wed, 02 Dec 2020 11:51:51 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v28sm2675430qkj.103.2020.12.02.11.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:51:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 20/54] btrfs: handle btrfs_record_root_in_trans failure in btrfs_recover_log_trees
Date:   Wed,  2 Dec 2020 14:50:38 -0500
Message-Id: <23564d0cd777eb33583aab981374438a47110c72.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_recover_log_trees.

This appears tricky, however we have a reference count on the
destination root, so if this fails we need to continue on in the loop to
make sure the properly cleanup is done.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 254c2ee43aae..77adeb3c988d 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6286,8 +6286,12 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		}
 
 		wc.replay_dest->log_root = log;
-		btrfs_record_root_in_trans(trans, wc.replay_dest);
-		ret = walk_log_tree(trans, log, &wc);
+		ret = btrfs_record_root_in_trans(trans, wc.replay_dest);
+		if (ret)
+			btrfs_handle_fs_error(fs_info, ret,
+				"Couldn't record the root in the transaction.");
+		else
+			ret = walk_log_tree(trans, log, &wc);
 
 		if (!ret && wc.stage == LOG_WALK_REPLAY_ALL) {
 			ret = fixup_inode_link_counts(trans, wc.replay_dest,
-- 
2.26.2

