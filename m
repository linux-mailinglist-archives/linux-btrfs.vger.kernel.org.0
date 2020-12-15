Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3089B2DB414
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Dec 2020 19:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbgLOSzO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Dec 2020 13:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731240AbgLOSzO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Dec 2020 13:55:14 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989C8C06179C
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Dec 2020 10:54:33 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id z20so15421167qtq.3
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Dec 2020 10:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r01wEU0mWNGGDEvQTJ4iY+sz3aHS/yrLZMrZ44+tCbU=;
        b=lTMJTl97KK26n1FbR0fmDFt3dZaZU+RV8xCPkdy2wqqDfikHb2IR0/8S3nzM4RkHYF
         Cc6UIhiCXywPb3lzOECpWpRd0+4m/fu26kdXUMvfrg7H4/SROdNXP1YGUitA34fz3XLo
         nttRPbr/c8ljNCGlNVExOFA9PQbDm91nxRPId427sCSZfSGPHAXEdzTa/Fk+jFz5GgWJ
         yIcpBRXJldtKXuoaHT4PEbdUvpVV/ZE1wK0ScIWsluRHC2XiT1RCLW0PaWt5h1VsjziS
         kYfZ3CtoFxD2Eg0WcureRmtuBboVFtk0iSzn3gkHV3O8zxxLEGafAFPJz0nhh1lo2Ti1
         pLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r01wEU0mWNGGDEvQTJ4iY+sz3aHS/yrLZMrZ44+tCbU=;
        b=F/fWNn76DKhROCWJhaTVfnGZoqFykOb0CwHlglaEA+AzdbEcmW9RdTsitSc5cf14uN
         +l9ULtGHMsmyWxyOGFkBKKGAy1Y/7AVNNkk5XXPc+8Ax+iyoBjDwGTswQ/TgVSqmfBL3
         A1dwbfG51RgaGhNVE2QU8b/9h3bn7W9wHjMVYQKxVuNkRAr3wHNE5ojP5t0vMp0+nglz
         5Bnh+auO19LMHiBcDWiJNiBL/0JEMzbRyBu9f3lyPqk/J+5+6r6cFzS0iBp4mkuFDbBa
         OT4aSd0XT5lL4IA+fF2dHdbQJz3HkfeaartNntWG6W0pcv8BoczhL2AqDJ9NzU17yS8a
         D14w==
X-Gm-Message-State: AOAM533z79mU1qvYpKsjwEmlKMDpII0STVBvcNww+8gJc1LBN52q/MqC
        wJty6VbmwH9u92Of6biQsG/FKP0s1C0HEdYP
X-Google-Smtp-Source: ABdhPJxF0vbY0O4ulkFLf54PSjlFFFOi6XksQUauXq3S3hkL2g+JqXakOjgK6WElxEQfrvbRb22pFw==
X-Received: by 2002:ac8:5b82:: with SMTP id a2mr39282342qta.215.1608058472138;
        Tue, 15 Dec 2020 10:54:32 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q3sm15538301qkq.118.2020.12.15.10.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 10:54:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: don't get an EINTR during drop_snapshot for reloc
Date:   Tue, 15 Dec 2020 13:54:29 -0500
Message-Id: <a72092d8058f1224efbc16be4d406dc7fcc60976.1608058461.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This was partially fixed by f3e3d9cc35252, however it missed a spot when
we restart a trans handle because we need to end the transaction.  The
fix is the same, simply use btrfs_join_transaction() instead of
btrfs_start_transaction() when deleting reloc roots.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d79b8369e6aa..08c664d04824 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5549,7 +5549,10 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 				goto out_free;
 			}
 
-			trans = btrfs_start_transaction(tree_root, 0);
+			if (for_reloc)
+				trans = btrfs_join_transaction(tree_root);
+			else
+				trans = btrfs_start_transaction(tree_root, 0);
 			if (IS_ERR(trans)) {
 				err = PTR_ERR(trans);
 				goto out_free;
-- 
2.26.2

