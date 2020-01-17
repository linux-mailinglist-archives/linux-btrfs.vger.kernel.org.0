Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 844411412E3
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgAQV0z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:55 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:44263 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgAQV0y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:54 -0500
Received: by mail-qv1-f65.google.com with SMTP id n8so11353270qvg.11
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=h2PRB5MkErkwZsCJkupV2sp4chKoTyeU5t+uSqL5pyU=;
        b=IBQ8vwdxzaKYRMJNuhqybemGzA9NYj778CAOoPTkkDN09SpCQwsi1irpfF479WRxq0
         oi2fp2Zu5XDDvuLHIW0sVGaWpde4PQ1yaaUtvVAWlEyusdHNULUcuOP2ZRolsumM3J15
         Sp1rvzUWLS+CUp/BFij+/kt7EZlD+jjX9ZTRfi4cUVDD0oKVUEewAMRaBB+lxssdEYj2
         NY245b0F/ajzXUfcM1zDQnl8CReVBxAOiVqvNtAmjjUDoE/Admi9pIWa40PMbNhzeKTd
         PajevYHb7Zic1nRjzGd4+iEZHl6NV+dZrduciv0ggJEFiNYjm4CXehq75+Z/8FCUu3CR
         373w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h2PRB5MkErkwZsCJkupV2sp4chKoTyeU5t+uSqL5pyU=;
        b=b7BxwYLKWRS/Nu+APaedMjXHKT7O5X2ZtxLWZRwuX/zLlheT7xJ1DLBrBXcUkOuQzY
         kPa0ZHma41d9yOhqB7zu9Q2wHEhLHJ8wQu5uKBH31HYCTI+cEHVUTMhuIsNg9Da9ONNo
         Bi6FxU2TPrmpR8jZr9CYJoiq/rvn9BTqaO+tCAemYbeTd8TcU91rZknZz6OKEVqMgvi5
         cZSR6CbJU8zErsaKps+T6j+qaaC39dYrCzF+3XTaGDQKXNcqD9z5+/C606VjjcRjVRLQ
         54aNYv4G2xgVS7bSDLoFywE9DZOt9Adn7o94paAtyz5OqF2G89BY21f490N6cbOsaEm+
         tuYQ==
X-Gm-Message-State: APjAAAWS0zbnwIavPMnNP0x1raz4Ond6gYbdOidBeof+PbaekgRZPMmm
        y6cRjLLjDe12SJSEZvzmCw1/tuEK4R3HYA==
X-Google-Smtp-Source: APXvYqz7WgTvB85FmcproLcUWbpxMAxnbQRxXMgBj9JCBPbRIJ2YKaXyBCs9c0p22+03WGr6ulDvPQ==
X-Received: by 2002:ad4:59c2:: with SMTP id el2mr9375153qvb.152.1579296413375;
        Fri, 17 Jan 2020 13:26:53 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s33sm14001028qtb.52.2020.01.17.13.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 27/43] btrfs: hold a ref on the root in btrfs_recover_relocation
Date:   Fri, 17 Jan 2020 16:25:46 -0500
Message-Id: <20200117212602.6737-28-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
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

