Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3A8A140B7A
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgAQNss (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:48 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32792 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgAQNss (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:48 -0500
Received: by mail-qt1-f195.google.com with SMTP id d5so21795463qto.0
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HnzdjkeIJ26XuYVKdWNweNi5NZFuh7yQC+uch37bA58=;
        b=B+U0UTQt9m0yS5MeVjcKsmhDEqJPEbIrkK9BwWUDkYQku5UVJgWgB4jYoz153i351O
         OwIfY/C5UguktyxwsrImxXCqN1ctVi2jEfYfeLHgj86/aMo8nojwUMF0WlyLaxcmKbK3
         jVlJrvhiXPcQvVZwluA+nzVQJZJcXsseoqrqQqkzBzeWlL0no8ifNZvIs5kzpi1h4ccC
         aH9m+w2HA9UprR1Z6XCybLlXgpdXutd2W/nu7Z4E2zP4p/VIsrJdis8TlcUpjSNwV/Kx
         X1GeU3zDPH9GLU+OPHyLr7sebkzi/Em+PXgYbA20FvkcUAvlZvvBV01rk2WGkwzZLJBg
         2p+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HnzdjkeIJ26XuYVKdWNweNi5NZFuh7yQC+uch37bA58=;
        b=AEA85TUBFDVhXLypsfiBvTZsYTyNElfx6nViG7zTbyAOpHpvlfEewrAOudir2/95/w
         lNqH/w1gFQA97s4Eb8/Z3sEBSK2xS7hkHC25X96flFCmc3XJZ1Fkyo+kgmDsq2FQEpih
         wdDQ/LoDEj4WLUqVWIEe86lSQlNbDHO8x1BiPlxT1+oB4dvAbG38IlmYyD7UAsMHgRBo
         N7s/sTyejAskZ+s5WMDbRB6Jwzetif6xY/zB1uk3gqOBeJh50x+xBXx6IU3LUHUqo/gn
         c6UbtPt+cZoKRhMHAovCtBLEA3mgyCOV35sOEQtCQU1F17st7zx3gXJHeaD318tNthI8
         9Chg==
X-Gm-Message-State: APjAAAXPuh41PJE0HxX0oiALFCCGX424L4moVf9OzPLC4PbfsvM4U188
        O/8RddJfw2RLQaiEKYrPV11bvOMbd2hGAQ==
X-Google-Smtp-Source: APXvYqwco6Q+fOb0BZPc6IAZquSjXe38C6IOnhYCcy8st4oahp3jbMKXNSoXk9INxDyArUzlfyWAZg==
X-Received: by 2002:ac8:4616:: with SMTP id p22mr7644223qtn.368.1579268926867;
        Fri, 17 Jan 2020 05:48:46 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p19sm12779579qte.81.2020.01.17.05.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 27/43] btrfs: hold a ref on the root in btrfs_recover_relocation
Date:   Fri, 17 Jan 2020 08:47:42 -0500
Message-Id: <20200117134758.41494-28-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
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
index 8238ff6a3b58..de123894c513 100644
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

