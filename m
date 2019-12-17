Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3977123094
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfLQPhl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:41 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40657 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfLQPhl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:41 -0500
Received: by mail-qt1-f193.google.com with SMTP id e6so1929510qtq.7
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=etKLBG9v+n8eeFTRJEZ/+UjoGM5jhhzFStGHRUUo6WM=;
        b=coOCnWd9ZXQFwciqEVUX9ha2VZZKiHqmSlTFNbE3aXsmJqtfoGEa8+z7lOTgusV/us
         WWQRwOHpPbiQQ5qY22hzU5Jzq/gHvPogi0sCtUVJtZsUX4eq2gS9xUmsJQZ0/hIlx9Rc
         V55yEiyXqdta4aB4r/f/AbXr/7wc5kGRBrMyT9cTQAPYj25tEgXZngYMT93WNqQZo/3n
         Ia7G/tPVZz8XvEhTAUFZcnbEhkvYL8R3cEDu3hbNIwUw74pskHMMIgeEwPP29qKUEiWI
         Qx7xSzad1KlYfTV060H9/p6pvou/dtx3AQDAqsnEJvZBAvnfF77NNl0jBI89WzjIC8XD
         eZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=etKLBG9v+n8eeFTRJEZ/+UjoGM5jhhzFStGHRUUo6WM=;
        b=iyO5XkbBeC69WLBnjTHyGWGLmeFLGJzyvIFjVeK+1AWEmW3vL4xQTWxvGWMm9CcMz9
         XmAUHGGcqQjJoBtT0KkVVcw3LIGS5JugYIcqvc+zpDAA0/kaljT14Ks5uhmocEbNP8v5
         Qmxj3YTwJO3mGTCIEn7Kjde3eWp6SQwR7i53SaoQ/EVx8uvITm1/VSRnwlSc1RPnlYGE
         hb/NO+pglR8iwApBm5HePfAsS8EnKha7q7On6s2uOLk4PfbmbVAmQpHZBY8CuLJilqYC
         1PfKLdbn1LNrWxcFUviRidwn/XVDKc5OeCm9sOglFg44kxzgyS4jHo/n0drW3xSCRu1s
         KBmQ==
X-Gm-Message-State: APjAAAWTDw9dgNZ4kyCFFoIfyPsQHM+CygPA+9imxvF7x+pO74GdSqJ6
        cht9ZPfssH2chWIWHfCL9vz4qQq8BNTyRQ==
X-Google-Smtp-Source: APXvYqytYttI3Kj8muC756Jffr0xvnFoJIzaeZMyY06794JluNqD8xQRRDdSY2slk92G8ArJKH38bQ==
X-Received: by 2002:ac8:4257:: with SMTP id r23mr5007243qtm.126.1576597059713;
        Tue, 17 Dec 2019 07:37:39 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c20sm8498398qtc.13.2019.12.17.07.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 34/45] btrfs: hold a ref on the root in get_subvol_name_from_objectid
Date:   Tue, 17 Dec 2019 10:36:24 -0500
Message-Id: <20191217153635.44733-35-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
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
 fs/btrfs/super.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index e387ca1ac0e5..9c50bee71de9 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1082,6 +1082,10 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 			ret = PTR_ERR(fs_root);
 			goto err;
 		}
+		if (!btrfs_grab_fs_root(fs_root)) {
+			ret = -ENOENT;
+			goto err;
+		}
 
 		/*
 		 * Walk up the filesystem tree by inode refs until we hit the
@@ -1094,13 +1098,16 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 
 			ret = btrfs_search_slot(NULL, fs_root, &key, path, 0, 0);
 			if (ret < 0) {
+				btrfs_put_fs_root(fs_root);
 				goto err;
 			} else if (ret > 0) {
 				ret = btrfs_previous_item(fs_root, path, dirid,
 							  BTRFS_INODE_REF_KEY);
 				if (ret < 0) {
+					btrfs_put_fs_root(fs_root);
 					goto err;
 				} else if (ret > 0) {
+					btrfs_put_fs_root(fs_root);
 					ret = -ENOENT;
 					goto err;
 				}
@@ -1117,6 +1124,7 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 			ptr -= len + 1;
 			if (ptr < name) {
 				ret = -ENAMETOOLONG;
+				btrfs_put_fs_root(fs_root);
 				goto err;
 			}
 			read_extent_buffer(path->nodes[0], ptr + 1,
@@ -1124,6 +1132,7 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 			ptr[0] = '/';
 			btrfs_release_path(path);
 		}
+		btrfs_put_fs_root(fs_root);
 	}
 
 	btrfs_free_path(path);
-- 
2.23.0

