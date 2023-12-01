Return-Path: <linux-btrfs+bounces-525-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22D280161B
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 23:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 511F3B2188A
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 22:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592F66670B;
	Fri,  1 Dec 2023 22:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Ga/edRcc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7EB10F3
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 14:12:51 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5c08c47c055so29084847b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Dec 2023 14:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468770; x=1702073570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/eg7ajMuqgjQeP8qD+Hv5GpTf3d4PaEZrFPInKscKQ=;
        b=Ga/edRccOIK6Zu5jOf+kr8irUYnN69sexSQrr29hjTW+Ps0PKxmkW0CeDWHqnxMO+L
         BnF7qK7n0pDFOxyDTB2e5ioOJzxMYbzZbok20ij1Ru+fDnPFy3ww+MoCK4r09vPg9UJc
         5MqmjvExHqI66XI1FkCQklqtqnZ091wWApF0Spn/1gLE29FEz2rcn24r7hCUj7X4Z4+9
         LaOtYj8cOgFdFSzMxXsccVWBokyuqxKXwSG5CZaenUDTQSyOJOiJhrE0BlsZ76gOduvO
         r400/UgncqJKrqHcfXxvzNroo1fmngVOJA1tFQdn29N92KIQC5sBuTHNu8P9Z6X9lior
         gsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468770; x=1702073570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/eg7ajMuqgjQeP8qD+Hv5GpTf3d4PaEZrFPInKscKQ=;
        b=a2RpzuK5zYq6dFldLiNTubyIb3Va7CYpM5wRAtz0v2viFUVoB5eazpGBOB3WMEWO6j
         1y3bpPeIptqZIstPoYye/vQDgatTDCVUgOMKonUt+a3+nAe+0Ii4LXn1COhfbBLADVOQ
         1fiAVfKBK1c/vNqhQAW/YbnnN2wr2b1Cp8nB4vkZacOQlgQ7WyrymkFz0+Qdt3aZ/WU4
         9Y2WlYWLvIysmPyhE0vC2HEv04CdSbCoAOE8wge98duKzM/pt34R1cvtb76wNrT7WbWM
         FIiiAsfhxnwLw/7lY6Q6jmL1zMJTF799TYtXbBWhQdhX9f8UzxFRORIG+Yx2ZTkX3yZK
         6vWQ==
X-Gm-Message-State: AOJu0Yy2MEaI7IlFts12+RpCDYAzo2b4SBg+TQ/Ps3ZktZYNKOzv6yep
	3ZFq8MJ+2MRP0hlaw65mpe7BmbykAnaPJx+XiiTDNw==
X-Google-Smtp-Source: AGHT+IETrSOuPq4vhgw8mrhZqpaEq81Wiak+hseLz8tSf2Q7lwNTWc1puQ6QUytY7XsPGv1WtuqT8Q==
X-Received: by 2002:a81:994f:0:b0:5d7:1940:53de with SMTP id q76-20020a81994f000000b005d7194053demr159596ywg.86.1701468770380;
        Fri, 01 Dec 2023 14:12:50 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q8-20020a815c08000000b005d0494763c1sm1380242ywb.140.2023.12.01.14.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:50 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 43/46] btrfs: don't search back for dir inode item in INO_LOOKUP_USER
Date: Fri,  1 Dec 2023 17:11:40 -0500
Message-ID: <9f2b9f7ac00fbd6bdd2150b7cc91d63c528f1c0a.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't need to search back to the inode item, the directory inode
number is in key.offset, so simply use that.  If we can't find the
directory we'll get an ENOENT at the iget.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 2f4f9f812616..7634ba23d046 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1890,7 +1890,7 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 	struct btrfs_root_ref *rref;
 	struct btrfs_root *root = NULL;
 	struct btrfs_path *path;
-	struct btrfs_key key, key2;
+	struct btrfs_key key;
 	struct extent_buffer *leaf;
 	struct inode *temp_inode;
 	char *ptr;
@@ -1944,24 +1944,6 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 			read_extent_buffer(leaf, ptr,
 					(unsigned long)(iref + 1), len);
 
-			/* Check the read+exec permission of this directory */
-			ret = btrfs_previous_item(root, path, dirid,
-						  BTRFS_INODE_ITEM_KEY);
-			if (ret < 0) {
-				goto out_put;
-			} else if (ret > 0) {
-				ret = -ENOENT;
-				goto out_put;
-			}
-
-			leaf = path->nodes[0];
-			slot = path->slots[0];
-			btrfs_item_key_to_cpu(leaf, &key2, slot);
-			if (key2.objectid != dirid) {
-				ret = -ENOENT;
-				goto out_put;
-			}
-
 			/*
 			 * We don't need the path anymore, so release it and
 			 * avoid deadlocks and lockdep warnings in case
@@ -1969,11 +1951,12 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 			 * btree and lock the same leaf.
 			 */
 			btrfs_release_path(path);
-			temp_inode = btrfs_iget(sb, key2.objectid, root);
+			temp_inode = btrfs_iget(sb, key.offset, root);
 			if (IS_ERR(temp_inode)) {
 				ret = PTR_ERR(temp_inode);
 				goto out_put;
 			}
+			/* Check the read+exec permission of this directory */
 			ret = inode_permission(idmap, temp_inode,
 					       MAY_READ | MAY_EXEC);
 			iput(temp_inode);
-- 
2.41.0


