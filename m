Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B637148942
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404494AbgAXOdw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:52 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43073 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391244AbgAXOdv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:51 -0500
Received: by mail-qk1-f196.google.com with SMTP id j20so2170707qka.10
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=h2PRB5MkErkwZsCJkupV2sp4chKoTyeU5t+uSqL5pyU=;
        b=sqjG/3tvbCQtHBkWuCNZsGkDFfVdBMxDxL42daoXcopvohu6/44UO0KcyP3VY6l6s5
         kQLI3jP+Z5ypuUl8iuTS1cYlPTpNsCF3KD8+FO29EPmGhsv2U1Ms7W7K2vZOqzrxeKR7
         gA3pqHaNNl5YuAdq2t9N1QYxGptCLNm9rpv4nNbsbQSRQ8qAPuCY1f1djijSzxPKRExo
         DmcihXx6oZADZ/XdzEQpABYAEpNB0W92QrMSofBjpImPvEF6HPPTr8cASQWASwD+9sr0
         iVdbKBOsHJvDf3x4yoCo089muV49ehECB9FvFC70i++pdhDGV4dE2RxeBu0eJG+c+YrN
         W/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h2PRB5MkErkwZsCJkupV2sp4chKoTyeU5t+uSqL5pyU=;
        b=kBstiz0E+M6GLaemFL2Dmfq+oxgEdO/ZsDTciTFbJwGB20YBEBYtnBscMSU4+BgB5e
         OctY3pPpDmo4u+NnxWBwriRRX7K0VWshMsMQd4dne/Ii1Sab+mYmZ2hJkgM3K9cBeU3d
         dmYUxjzKwBBxIFZOC9BWz5Ym+4I7nHrzJo3C5CxeZWKudY0Bjnxm31TovzCgL6FvRYFv
         m4bRoI/2swA+fLyoF8ouErMrM7PKBnwovfLySzJdO3eZtUVePlPHfWCzFStZntJ2ofTt
         A/Qz9IVkm+yxBDHFaz5kGtxdWhcc/zK8oT09fiHX3HDQcJ3dXsChxBMOvnxpBW1rDBj0
         +M4g==
X-Gm-Message-State: APjAAAVhKiQO2dhF5mjnQoN9gKliJht7lTKEbrsLcU1g3VhfZhAjkOPb
        X0cBfnYgfFHr0dsKqYjnZCsX5ViwgBfSuQ==
X-Google-Smtp-Source: APXvYqxHZv8VhqfXCOaCFganHAqZ4RbxtCZRisf5XtbBvrTxI1HcFhKNqlxY0l/WA3zXk8PaBiuZZw==
X-Received: by 2002:a37:6481:: with SMTP id y123mr2757431qkb.53.1579876430304;
        Fri, 24 Jan 2020 06:33:50 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c3sm3149032qkk.8.2020.01.24.06.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:49 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 27/44] btrfs: hold a ref on the root in btrfs_recover_relocation
Date:   Fri, 24 Jan 2020 09:32:44 -0500
Message-Id: <20200124143301.2186319-28-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
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
index 9531739b5a8c..81f383df8f63 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4593,6 +4593,10 @@ int btrfs_recover_relocation(struct btrfs_root *root)
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
@@ -4604,6 +4608,8 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 					err = ret;
 					goto out;
 				}
+			} else {
+				btrfs_put_fs_root(fs_root);
 			}
 		}
 
@@ -4653,10 +4659,15 @@ int btrfs_recover_relocation(struct btrfs_root *root)
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
@@ -4688,10 +4699,14 @@ int btrfs_recover_relocation(struct btrfs_root *root)
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
2.24.1

