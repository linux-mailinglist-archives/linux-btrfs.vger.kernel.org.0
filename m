Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD1B2CC71F
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389676AbgLBTxG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgLBTxG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:06 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA99C08ED7E
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:18 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id f27so1980780qtv.6
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jVT9E1U8ZeeJL6ProMQL7eX7XKP2lcNPsO1kcV6xP1E=;
        b=RTN1YfQjFGt6lMLDLsE1XsjeARPos0Up2rzo4wvx5SLb+CdbeEK+DyInX6NrdzrKJB
         E5kOinKDtgAxNRZss9/ke/1Nr9HSvHApsCEoWfwfjL1eY/V6qbA9bNsLyu/lgCXY/xCr
         lTPR8x16C8KtVUZhzjaDax1ItJzf2szVnR/jYaBJxU6Qy5L1Xd5NCGAEcbMpe0zDDA3Q
         gebq2GRuNyNteVsZ615D5EKO1gBG7KQVlsbF4c+5DWcSB9tPnOoZO6W5HcxWX42JMDuv
         Cux88jdv44jbl1gY2MIP4zpV9GaoBnqEDeRwYmyVmhlfUnATamHZnXkBCHQYY2AHT8Ak
         anUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jVT9E1U8ZeeJL6ProMQL7eX7XKP2lcNPsO1kcV6xP1E=;
        b=XdfDoYxktzlWOIYoiDzgmCrc1X394dsctk5sTOlooHl7deu/gLY5cYbo6s3dO8QIqy
         btKigptQ2cJs8eGhTDPbQtI7i7TsFtyzcz7VJ6G7o1d+HEMx0wL8cKCWUH1hp3Hm+cF1
         pxaXHb2/ZN0JfS1eN/+EjiZ9qEWgpEqWOzfHfXXsDbGhBXGbq19GfSyL77htRMt94mld
         CtRH4hQfjq53bRjEKkk3aWFjwjDy7QLwZozN0PceG3ZZzZG1lukU9edKpu2XtxwKA3SL
         ik9mLy8izDpWpeyte6W0b2NIF540K/UiSXIE3LG0HGbXXByoMjFZjC3eYrvjWzzCUEw4
         PFvA==
X-Gm-Message-State: AOAM532liM+CMcjBmyKSkvekrytyCi6dlQD6GWmz3pdG/muqNJ0ko6yz
        2kmpF6ZJlL5H0QrOvoSK7CAP6gFJ9lF9Jw==
X-Google-Smtp-Source: ABdhPJyoqwxJAD4D5BDBN2r2tIZY7V1dkGgZvnMaXKOFtNpNdMPwSyOj0HpOs24Qxwrn+KZK/ex3AA==
X-Received: by 2002:ac8:7589:: with SMTP id s9mr4288324qtq.238.1606938737349;
        Wed, 02 Dec 2020 11:52:17 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b4sm2789819qtt.52.2020.12.02.11.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 35/54] btrfs: do proper error handling in btrfs_update_reloc_root
Date:   Wed,  2 Dec 2020 14:50:53 -0500
Message-Id: <dc884af858abedd5596d31fbf365a830ec6b26d2.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We call btrfs_update_root in btrfs_update_reloc_root, which can fail for
all sorts of reasons, including IO errors.  Instead of panicing the box
lets return the error, now that all callers properly handle those
errors.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index e41d14958b8b..2fcb07bc8450 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -894,7 +894,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 	int ret;
 
 	if (!have_reloc_root(root))
-		goto out;
+		return 0;
 
 	reloc_root = root->reloc_root;
 	root_item = &reloc_root->root_item;
@@ -927,10 +927,8 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_update_root(trans, fs_info->tree_root,
 				&reloc_root->root_key, root_item);
-	BUG_ON(ret);
 	btrfs_put_root(reloc_root);
-out:
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.26.2

