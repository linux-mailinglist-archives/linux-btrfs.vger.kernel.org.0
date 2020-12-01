Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886FE2CA65B
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Dec 2020 15:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389787AbgLAOyN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Dec 2020 09:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389342AbgLAOyN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Dec 2020 09:54:13 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DC3C0613D4
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Dec 2020 06:53:27 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g17so1265623qts.5
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Dec 2020 06:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aF/h9mAAFbShb1sE1u+IpaXprfsD+qJCAcocfEPUo2I=;
        b=df5+QwR1x+iH8Uk7yPFgaIje81DvedkNHG2ZUt0UQ6lNsXJ9ZtCofr2mPyRKCo2nbo
         aAIisw0wBt86V/9zACPpLlVO1Og559gPD7w3mF+CyrMN84eY4/GRZCFrHUQ/BS2y4NiT
         uDW94k0PgbEoKIygNLCJyOLk8rtLagSg/UJJWVMDF7xFp1bt0EClwavOerWY0ZfpDQfW
         adXBahLoK25H/Ito7wBaPgKOpjcJ0rmlJZfHjeruW0D1RQGijpsdnTacnQAPsSYmTay5
         Cos3FNCNlTKtnwqX+bfrOZtIxDunpSRRzeX1AspkQmLMpNWTdselXe+woJ8moQJcT0fX
         C7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aF/h9mAAFbShb1sE1u+IpaXprfsD+qJCAcocfEPUo2I=;
        b=VCOlmtibwc3JrQxHhjuiI5J9cVD6QQ6ulnGsmiLkqfvYQR86uAmkYIGhtPSrdtc2gp
         6dbYlWTFRvdKIOAB6mcwZohuvV8bvGrp/8NgMTZytokUsZJndtqr8GrYJAKZ7ilxag4L
         ChBc4I3owIr7IwHt4VTQ/qj3KAk7TXUqix0f/XzszC/21emf6uo4kzYqr9nv3GMXWTIq
         mfe5AouHSMPB8hrviVV9JxQsmWWFk8expgN+hvQT8EtCmuvGHM85avCd7Bocctt7uatI
         GnZVK+1MSa4UcOlzWZydrn+1trHVs+11WM4PboUp5tDvue7U7IVj+hfTKx3Is2meeSYi
         /m2Q==
X-Gm-Message-State: AOAM530XWP4UdcsXxA0IKn8hnw4IKIWQmJi3puxtuMWLPTCUwFt+7P/W
        59LAU7lKrjG/6EmqeX+K/es04zaT06ggzA==
X-Google-Smtp-Source: ABdhPJx/mL4pwsRd7lZ2jCVmOtE3PVhKRqs+d1jigZJJUmQxGcCGO4WJuBgocBYiINuTxlpE08s3+g==
X-Received: by 2002:ac8:5450:: with SMTP id d16mr3150306qtq.33.1606834405640;
        Tue, 01 Dec 2020 06:53:25 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q20sm1734706qke.0.2020.12.01.06.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 06:53:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: fix error handling in commit_fs_roots
Date:   Tue,  1 Dec 2020 09:53:23 -0500
Message-Id: <29f468ffe7b19dbebae2201f10307ec4f34f1c88.1606834393.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While doing error injection I would sometimes get a corrupt file system.
This is because I was injecting errors at btrfs_search_slot, but would
only do it one time per stack.  This uncovered a problem in
commit_fs_roots, where if we get an error we would just break.  However
we're in a second loop, the first loop being a loop to find all the
dirty fs roots, and then subsequent root updates would succeed clearing
the error value.

This isn't likely to happen in real scenarios, however we could
potentially get a random ENOMEM once and then not again, and we'd end up
with a corrupted file system.  Fix this by moving the error checking
around a bit to the main loop, as this is the only place where something
will fail, and return the error as soon as it occurs.

With this patch my reproducer no longer corrupts the file system.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 1dac76b7ea96..b05f75654b16 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1328,7 +1328,6 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 	struct btrfs_root *gang[8];
 	int i;
 	int ret;
-	int err = 0;
 
 	spin_lock(&fs_info->fs_roots_radix_lock);
 	while (1) {
@@ -1340,6 +1339,8 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			break;
 		for (i = 0; i < ret; i++) {
 			struct btrfs_root *root = gang[i];
+			int err;
+
 			radix_tree_tag_clear(&fs_info->fs_roots_radix,
 					(unsigned long)root->root_key.objectid,
 					BTRFS_ROOT_TRANS_TAG);
@@ -1366,14 +1367,14 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			err = btrfs_update_root(trans, fs_info->tree_root,
 						&root->root_key,
 						&root->root_item);
-			spin_lock(&fs_info->fs_roots_radix_lock);
 			if (err)
-				break;
+				return err;
+			spin_lock(&fs_info->fs_roots_radix_lock);
 			btrfs_qgroup_free_meta_all_pertrans(root);
 		}
 	}
 	spin_unlock(&fs_info->fs_roots_radix_lock);
-	return err;
+	return 0;
 }
 
 /*
-- 
2.26.2

