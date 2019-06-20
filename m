Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 094DC4DA56
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 21:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfFTTi1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 15:38:27 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41804 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfFTTi0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 15:38:26 -0400
Received: by mail-qt1-f194.google.com with SMTP id d17so4376152qtj.8
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 12:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=keEIFgFtDYtlEmOj/tWoyGT0nE/EOHkF5XI2grMDw4o=;
        b=IdlpdNuNgl6fn+tdrXdCztE5zDDpcHpC/Z0IJeT6YPnfasaZplFT7PBKGiXuck40TK
         /gDP9RmwfUOSbmnx1CtL6Yu1b/GMf4cDyRcM7tqv6Tl1teTpPicjM3lCSBI90+r//Du9
         QXX7/j1fwmlYxcFlL9JCsjyFWhEyZs9D0jWvTYgcUdCnWlrcnfGhFdS3OU5HQYfXgOC8
         ljbQInu+n4ZE3fu/17FhowPxLYGiX5l11JawNXsBtbQQOggpaMFQSkHZnM4Zz1Uj7wno
         eq0c0tMhKAQvXCL0f/nk6xDzDO+OsyPYCItjBKMd6ypmaMtOOnseB1I5sPiBLmysmrGM
         dRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=keEIFgFtDYtlEmOj/tWoyGT0nE/EOHkF5XI2grMDw4o=;
        b=Oa114JS+fs/cdOpnuUVyGrxQbkpuy9MgebhrPV0Fqz5AUT2ycpTkXiRodzcJq9rYAt
         E1TKXVAvezrRSrYCFhOX/GHCIdtLqaqFK9HeqxDoamQf54gDSTwJpkehm727Rn4CctGv
         vpc05vcdwZCybRdbxvI+xbOfcd0V2GUJExdpJLYrUSqTxDyt5beA0PtMnRCKKicH//Ut
         YWNj3y0QCu0yb0aWddsYd/CcY/knxNtYC2VgZ6qRQgPDhbP+oEG/7hKAt2Wu/GXog72P
         ZHYPOaZTZzh4WCJkJMOPSEuEYi8quq2STWOLBZK77Yl7tUXcdb5288zX4g2DdH71g7GY
         7Yxg==
X-Gm-Message-State: APjAAAVRoKPmKP/7JHZlUaxRJZqNhxZn5IOefn5oT7gmcslKydHVZ37f
        x0cLpgQDc5C44MJ6965fmq0gXK3H4VXAbw==
X-Google-Smtp-Source: APXvYqyso+THAxh5Hc6CeQM8gsbyU7ke9XM0TdmO2dsDg1PXxku5rfwxzLJ4ZvnCucHA9zZsRFSkVw==
X-Received: by 2002:ac8:41d1:: with SMTP id o17mr39235863qtm.17.1561059505637;
        Thu, 20 Jun 2019 12:38:25 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f68sm244290qtb.83.2019.06.20.12.38.24
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:38:25 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/25] btrfs: make caching_thread use btrfs_find_next_key
Date:   Thu, 20 Jun 2019 15:37:52 -0400
Message-Id: <20190620193807.29311-11-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
References: <20190620193807.29311-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

extent-tree.c has a find_next_key that just walks up the path to find
the next key, but it is used for both the caching stuff and the snapshot
delete stuff.  The snapshot deletion stuff is special so it can't really
use btrfs_find_next_key, but the caching thread stuff can.  We just need
to fix btrfs_find_next_key to deal with ->skip_locking and then it works
exactly the same as the private find_next_key helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c       | 4 ++--
 fs/btrfs/extent-tree.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 99a585ede79d..43137258c403 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -5623,7 +5623,7 @@ int btrfs_find_next_key(struct btrfs_root *root, struct btrfs_path *path,
 	int slot;
 	struct extent_buffer *c;
 
-	WARN_ON(!path->keep_locks);
+	WARN_ON(!path->keep_locks && !path->skip_locking);
 	while (level < BTRFS_MAX_LEVEL) {
 		if (!path->nodes[level])
 			return 1;
@@ -5639,7 +5639,7 @@ int btrfs_find_next_key(struct btrfs_root *root, struct btrfs_path *path,
 			    !path->nodes[level + 1])
 				return 1;
 
-			if (path->locks[level + 1]) {
+			if (path->locks[level + 1] || path->skip_locking) {
 				level++;
 				continue;
 			}
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1513cae23106..06aab5ef68e7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -330,7 +330,8 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 		if (path->slots[0] < nritems) {
 			btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 		} else {
-			ret = find_next_key(path, 0, &key);
+			ret = btrfs_find_next_key(extent_root, path, &key, 0,
+						  0);
 			if (ret)
 				break;
 
-- 
2.14.3

