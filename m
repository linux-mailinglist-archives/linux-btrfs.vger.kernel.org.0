Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 630A21547F8
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 16:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBFPYd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 10:24:33 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46731 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgBFPYd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 10:24:33 -0500
Received: by mail-qt1-f194.google.com with SMTP id e25so4726079qtr.13
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2020 07:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wCE1OrUi7dG/tAWTXpeobeYMsWGCcBI76eOyzL2rKGY=;
        b=I3GlkDtuURhAn9l/gc6GUiNrDblKCJTrGzpzFnGtdWKWWPqNf2L0RUPD9Pu8TwP8jb
         yHD0EgHomB9395/YsoeFBRAIvs4OPr+WedRONfpRXQM4ogKgQZNG1cnxqtYkLCDgavkV
         Au+W87+Jq/AN8vCJAFtKTuDIYOuRfECoTf4tSXuyvHcw33i+ETqYuyxzs9TCqzryc4//
         FPs7hoJoG/aZtfL8z3GJs0L+gHiTbiZclPA9+O+/Wojko2DgJyytPlxvT7j4h2LqNawy
         Js3Xgi3cUsaWZLp/p1mVUR3cVmR14sbdRabl7BA69/dQKCFarMZCnsFvAdy/GaD7vaNi
         /pnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wCE1OrUi7dG/tAWTXpeobeYMsWGCcBI76eOyzL2rKGY=;
        b=bNtCqq0oOnE03xoC4+2J2XVB5v9DYgjp1G/RGLEldun0s7ZFhO+ruJKAKrxkFaarPt
         vrlXMi0NBwFeUCLo+UlVLSbJCWXSF6YWBFmL9a+xBB01NKt8MiVRa8f/Egsq6AS8IO2+
         IutCSSg+g3iFCXdJXA/htxYyDWZsejlmcrluoPZUVJ/xMHFygyX6426faCoWcZb82Vkj
         TXl6OBR2hBjMjVJq25K9kXkRX3Qsn7FXDzZESIm1OuOIRg6TvgyuuQ95yKGUnf2zA6qm
         ynT5TL8RCpexxdPGV0ntBYgtlGZ89Iut9KYMM2VEIIOJs/zVd/SIK8p4DUmIt9b4wFRL
         OU0w==
X-Gm-Message-State: APjAAAUla8b279iPNwdmGFwBj9vU+X18WRTDfr7uIkBEznzTlPkIwSes
        lS4g21IB6IHZgmHaqkw8NAn/rEXaqxQ=
X-Google-Smtp-Source: APXvYqxexH2/JbbfX9CczM6Xnt2YTnRtQMxFuTjohg6rcYLPOxAIbWwE5W6J+RxFU6jDiEucYbVKbg==
X-Received: by 2002:ac8:584:: with SMTP id a4mr3149830qth.240.1581002671363;
        Thu, 06 Feb 2020 07:24:31 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q73sm1559258qka.56.2020.02.06.07.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 07:24:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com, dsterba@suse.cz
Subject: [PATCH][v2] btrfs: hold a ref on the root in get_subvol_name_from_objectid
Date:   Thu,  6 Feb 2020 10:24:26 -0500
Message-Id: <20200206152426.6312-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205151902.GS2654@twin.jikos.cz>
References: <20200205151902.GS2654@twin.jikos.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We lookup the name of a subvol which means we'll cross into different
roots.  Hold a ref while we're doing the look ups in the fs_root we're
searching.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- Moved the btrfs_put_fs_root() to err, but this requires making sure that
  fs_root == NULL in all the cases we won't have a valid fs_root to drop a ref
  on.

 fs/btrfs/super.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index fa74caf39165..96bc10da5ff2 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1028,7 +1028,7 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 					   u64 subvol_objectid)
 {
 	struct btrfs_root *root = fs_info->tree_root;
-	struct btrfs_root *fs_root;
+	struct btrfs_root *fs_root = NULL;
 	struct btrfs_root_ref *root_ref;
 	struct btrfs_inode_ref *inode_ref;
 	struct btrfs_key key;
@@ -1099,6 +1099,12 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 		fs_root = btrfs_get_fs_root(fs_info, &key, true);
 		if (IS_ERR(fs_root)) {
 			ret = PTR_ERR(fs_root);
+			fs_root = NULL;
+			goto err;
+		}
+		if (!btrfs_grab_fs_root(fs_root)) {
+			ret = -ENOENT;
+			fs_root = NULL;
 			goto err;
 		}
 
@@ -1143,6 +1149,8 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 			ptr[0] = '/';
 			btrfs_release_path(path);
 		}
+		btrfs_put_fs_root(fs_root);
+		fs_root = NULL;
 	}
 
 	btrfs_free_path(path);
@@ -1155,6 +1163,7 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 	return name;
 
 err:
+	btrfs_put_fs_root(fs_root);
 	btrfs_free_path(path);
 	kfree(name);
 	return ERR_PTR(ret);
-- 
2.24.1

