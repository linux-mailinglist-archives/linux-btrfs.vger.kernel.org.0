Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83BC7115385
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfLFOqd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:33 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40366 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfLFOqc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:32 -0500
Received: by mail-qt1-f196.google.com with SMTP id t17so705375qtr.7
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xnA1zMQlWeZ+uUevxR44/u/GVIZqo262LTilixqIXjA=;
        b=Z6f7nOJ+/R+diLWz4QejMMM7PVkg8iEf2OpzpMZOpL/Ey5AcA3EHDdGbwgpVFXV6xq
         Hrjsel3fyaGtiwyg6IBIYCxQh76eHYYvRwUYYkLALwzND/PUftw+sSl1PinuMSDNpjLJ
         XNnYGnOXvbCbNuuXTq5cmGPGpxIF9vfbFF/hsSkTyAwh2rV8XLwQI1CB3XFttoRwRb82
         e/Q6S7JmBOtYnJwCXHyPaTQpqyfjDDcuFisR1frAYYtkzweAaJ84nw+0qa+atb9M2k1M
         06doCMtyOFkIPOzbK5eRkOM46NKBGlDTDoqwPtrzntC0HJt05buFu+848vE1/PHVRK5m
         zfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xnA1zMQlWeZ+uUevxR44/u/GVIZqo262LTilixqIXjA=;
        b=r0LwJZIhbboVSdOE4zHZFz29tIfqQLQEVS1Ho1Em0121n4OduXRHVDdi4l5Je5r40a
         mYsMAaAldyucm/EQSleOTgkx32ccCjOpkF4tD/6Hkm1vtfKyZNdot+OPTUPVxuzU+Gq7
         FyyoY/Pwe08xevl4cn+tRXXy/a6KSAY7eC/krMwfe/8p2aXQUm0Pj+8R2XvGjC1dXc6A
         YMhQYp92IvH1DxNehrkj1GqptK6iToWBvIbuXh7Tt3D07r7qOeEjqbbQCfUXCIFtNoJC
         BFrTwFQOD+PkUtk+0i9YKDoiwvFyzVKYM0PyD91IaJTy9VdupVCxE8Ye0OAQImXaQNBj
         B+jw==
X-Gm-Message-State: APjAAAWjWvb+/Dx1/WNYBnr70Y5VbPUxLZCmVg+KM2U50j6omzd/zH5m
        OBJmCEdrDgQQvcrduBfU0S9OaKZgMW1fcw==
X-Google-Smtp-Source: APXvYqw5pctPcaB5XN5U3wnvmT5ZHcdrDfFpL5wHd6Kx6AnQ3Do5kKZU+vtM6+c3itxhEXd0NufCeA==
X-Received: by 2002:aed:3fce:: with SMTP id w14mr13638180qth.0.1575643591740;
        Fri, 06 Dec 2019 06:46:31 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m29sm6634257qtf.1.2019.12.06.06.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 29/44] btrfs: hold a ref on the root in btrfs_recover_relocation
Date:   Fri,  6 Dec 2019 09:45:23 -0500
Message-Id: <20191206144538.168112-30-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We look up the fs root in various places in here when recovering from a
crashed relcoation.  Make sure we hold a ref on the root whenever we
look them up.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4e455703439b..d40d145588f3 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4542,6 +4542,10 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
 			fs_root = read_fs_root(fs_info,
 					       reloc_root->root_key.offset);
+			if (!btrfs_grab_fs_root(fs_root)) {
+				err = -ENOENT;
+				goto out;
+			}
 			if (IS_ERR(fs_root)) {
 				ret = PTR_ERR(fs_root);
 				if (ret != -ENOENT) {
@@ -4553,6 +4557,8 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 					err = ret;
 					goto out;
 				}
+			} else {
+				btrfs_put_fs_root(fs_root);
 			}
 		}
 
@@ -4602,10 +4608,15 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			goto out_free;
 		}
+		if (!btrfs_grab_fs_root(fs_root)) {
+			err = -ENOENT;
+			goto out_free;
+		}
 
 		err = __add_reloc_root(reloc_root);
 		BUG_ON(err < 0); /* -ENOMEM or logic error */
 		fs_root->reloc_root = reloc_root;
+		btrfs_put_fs_root(fs_root);
 	}
 
 	err = btrfs_commit_transaction(trans);
@@ -4637,10 +4648,14 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 	if (err == 0) {
 		/* cleanup orphan inode in data relocation tree */
 		fs_root = read_fs_root(fs_info, BTRFS_DATA_RELOC_TREE_OBJECTID);
-		if (IS_ERR(fs_root))
+		if (IS_ERR(fs_root)) {
 			err = PTR_ERR(fs_root);
-		else
-			err = btrfs_orphan_cleanup(fs_root);
+		} else {
+			if (btrfs_grab_fs_root(fs_root)) {
+				err = btrfs_orphan_cleanup(fs_root);
+				btrfs_put_fs_root(fs_root);
+			}
+		}
 	}
 	return err;
 }
-- 
2.23.0

