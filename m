Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078FD2DC432
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgLPQ2g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgLPQ2g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:36 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A96BC061794
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:39 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id l7so11607008qvt.4
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=b01JWLS+ZGwWe1HCXpnCOoP6ehEw+zjYvdkDqEwbXts=;
        b=piLbORJk2hYbHdHGRAbKmKxbDcDJVKToAPo7nGpInp5xLD0CCOJZ/2tqyeTK4ejJpb
         lzWD+nlxz3qJZNh7fZDRWROwPnprSrKM+FSzY8KxmHaepmc23ghdy2GNSO5WTeTySsVA
         0o9/ZQSQzLsDeJd/jfmG4tr8gKpepedRlUP+8f6mMPGP6jxzkEwXaDILadYt5lclLamx
         V2A7RTBMlPJZBohB6DdBLnE0XX7q30Xq3dpSdCbMwy6FnaH0yTDi5TFi3PIpoJo3lHZd
         q47Nt+bkGlYAUvTmbLujPT5nVdcV1jnRQPjRYRRcBt9AX3/SzXAJscP6HsAMebG+96L1
         2V9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b01JWLS+ZGwWe1HCXpnCOoP6ehEw+zjYvdkDqEwbXts=;
        b=noeKqTEuetCCBDmP2jsp0P5n688ewow7YS8ggiy3/BAT2V276ssI8QSz0rCVQ/kZkl
         D7j5PI/uqXZYj43YJ3Cv2H6oFQ8KaeNqO1C45DepAvDhb/KrENOEaFSKO1jK7jscCWQY
         VnA2yvRpTU9rwIG7WGtNPiO/Af435xiCvol1f6GWlz0PsqA5t4+m2ruZwIPY0dNZrbVq
         V6qaAFl+GSpJqfvpyqFdhVL8ulk1ZZhtsSAVNgWOvicF6bD3dnDx0l2Qw4qlvGfEtg/Z
         F10UFG/Nv9nUrKt1MlIyE3K2cO0BArXTLqRTKiJjcnaHmm3+bQRPRys+Zs0J7l3U01Fl
         nXWA==
X-Gm-Message-State: AOAM532Peaw4ZO1hvcULYTnUmb7FKx5zS8i7gPCmCGvbOX3F8KStuInL
        1oKT2uUlDcC9xsYgNVKZcalVQ6oTWSX1RJM5
X-Google-Smtp-Source: ABdhPJxp/3+xQ/sNnS0TsH0FP0cVgSu0b7No6xBzczjb29JCJWyfSuWuhvSfQW+Oc8mzpAdr2/EqUQ==
X-Received: by 2002:a05:6214:140d:: with SMTP id n13mr40723105qvx.45.1608136058244;
        Wed, 16 Dec 2020 08:27:38 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b67sm1319245qkc.44.2020.12.16.08.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 24/38] btrfs: handle btrfs_update_reloc_root failure in prepare_to_merge
Date:   Wed, 16 Dec 2020 11:26:40 -0500
Message-Id: <41fae34742970a8373ed4e817c1833a57212a163.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_update_reloc_root will will return errors in the future, so handle
an error properly in prepare_to_merge.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index dde383477f5f..3a207548edde 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1870,10 +1870,21 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 		 */
 		if (!err)
 			btrfs_set_root_refs(&reloc_root->root_item, 1);
-		btrfs_update_reloc_root(trans, root);
+		ret = btrfs_update_reloc_root(trans, root);
 
+		/*
+		 * Even if we have an error we need this reloc root back on our
+		 * list so we can clean up properly.
+		 */
 		list_add(&reloc_root->root_list, &reloc_roots);
 		btrfs_put_root(root);
+
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			if (!err)
+				err = ret;
+			break;
+		}
 	}
 
 	list_splice(&reloc_roots, &rc->reloc_roots);
-- 
2.26.2

