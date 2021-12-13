Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640ED473649
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Dec 2021 21:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241964AbhLMUyg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 15:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241566AbhLMUyf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 15:54:35 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BC6C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 12:54:35 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id m17so15565135qvx.8
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 12:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rt6J1jl/aBxJbZk/jSZVRC1sIFyk2NwFobsEbPmutEo=;
        b=lkZZytoeY596h+r7PK8zYq8OZyHrAlTj5G6WLsrLxU0jJxfMlXD1wpIF5kac2tkrj9
         WwKQn3sSzztsW0xCdLVRNNjwUbGtXOguu5/XPPx+lebDRBpvFDzKNNIemWgf2Rp39ExG
         5J1H010FGCksgc3zHrWbNG99LwLjG972cirYkFgAkyzKSyI5lCvWI8satjQg8TAjGEs1
         8paBNSXDEorg3xbAVpknjClkDBv84oaVbD5Rg5vOmTpgcMF6mSt9KbPtS8Dzn8ZSkhL9
         9TXXDzGFolXMzWqpiRA3CtQG96bilSjt12QAE0TVPPExErongR+cxbL87ZsfAfFp+RvK
         l7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rt6J1jl/aBxJbZk/jSZVRC1sIFyk2NwFobsEbPmutEo=;
        b=rXY1Ldtne+vFuHahhBYNQDksUZnrVkxpm+qeH2IXPxnKm9qe7WLp7NUA9nGCV8RoeB
         rN/2bSW4hFiXUKJA9kKdaR2LmJJFFXC+eLPC0TXpKMRlNiUAzjBuFrxIYJblP9c+Ofxq
         rYlzEM11VqShUVsSEvVXHm9yLLJyIhgj9TeMrsGHxNVjvABL+fiPu1aewP4XUk/yJ0ru
         Eq3Xh28PGUWZ+rhb3OVn2GQvwFOErRWfoJU1N+UwYuwmAKuN2tvA05Juiqi33vXSXhdB
         dX2DWEQBsBgbx0i3NrJKxcys/1G3HY9Tx27EcGMiNQdbBk4LoxqPpmt4CUhTlgmTDs6v
         gFog==
X-Gm-Message-State: AOAM532CXEkCkEV4BnyGUDn640PiID2UhitjMP7xM+NF3vEEzn8UcPhG
        YQYjp1h+3rf45KW1bE0DHSMpG0XlzNIs0Q==
X-Google-Smtp-Source: ABdhPJyr2CkaCjRIdKcxchaP9H3ZVvvHAcQKiMSRazgbGVGJXv1NCAef7TL0q/mCcVYSaK7qBeJqzQ==
X-Received: by 2002:a0c:edca:: with SMTP id i10mr718444qvr.62.1639428874369;
        Mon, 13 Dec 2021 12:54:34 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u10sm10452733qtx.3.2021.12.13.12.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:54:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs-progs: handle orphan directories properly
Date:   Mon, 13 Dec 2021 15:54:28 -0500
Message-Id: <9386338b4e9f7b7c3a6667150ef1dab1773f8371.1639428656.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639428656.git.josef@toxicpanda.com>
References: <cover.1639428656.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When implementing the GC tree I started getting btrfsck errors when a
test rm -rf <directory> with files inside of it and immediately unmount,
leaving behind orphaned directory items that have GC items for them.

This made me realize that we don't actually handle this case currently
for our normal orphan path.  If we fail to clean everything up and leave
behind the orphan items we'll fail fsck.

Fix this by not processing any backrefs we find if we found an inode
item and its nlink is 0.  This allows us to pass the test case I've
provided to validate this patch.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c        | 15 ++++++++++++++-
 check/mode-lowmem.c |  6 ++++--
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index e67d2f72..966a68ab 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1018,6 +1018,16 @@ static int merge_inode_recs(struct inode_record *src, struct inode_record *dst,
 	int ret = 0;
 
 	dst->merging = 1;
+
+	/*
+	 * If we wandered into a shared node while we were processing an inode
+	 * we may have added backrefs for a directory that had nlink == 0, so
+	 * skip adding these backrefs to our src inode if we have nlink == 0 and
+	 * we actually found the inode item.
+	 */
+	if (src->found_inode_item && src->nlink == 0)
+		goto skip_backrefs;
+
 	list_for_each_entry(backref, &src->backrefs, list) {
 		if (backref->found_dir_index) {
 			add_inode_backref(dst_cache, dst->ino, backref->dir,
@@ -1039,7 +1049,7 @@ static int merge_inode_recs(struct inode_record *src, struct inode_record *dst,
 					backref->ref_type, backref->errors);
 		}
 	}
-
+skip_backrefs:
 	if (src->found_dir_item)
 		dst->found_dir_item = 1;
 	if (src->found_file_extent)
@@ -1394,6 +1404,9 @@ static int process_dir_item(struct extent_buffer *eb,
 	rec = active_node->current;
 	rec->found_dir_item = 1;
 
+	if (rec->found_inode_item && rec->nlink == 0)
+		return 0;
+
 	di = btrfs_item_ptr(eb, slot, struct btrfs_dir_item);
 	total = btrfs_item_size_nr(eb, slot);
 	while (cur < total) {
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 696ad215..66e291da 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -2726,6 +2726,8 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 					imode_to_type(mode), key.objectid,
 					key.offset);
 			}
+			if (has_orphan_item && key.type == BTRFS_DIR_INDEX_KEY)
+				break;
 			ret = check_dir_item(root, &key, path, &size);
 			err |= ret;
 			break;
@@ -2768,7 +2770,7 @@ out:
 				&nlink);
 		}
 
-		if (nlink != 1) {
+		if (nlink > 1) {
 			err |= LINK_COUNT_ERROR;
 			error("root %llu DIR INODE[%llu] shouldn't have more than one link(%llu)",
 			      root->objectid, inode_id, nlink);
@@ -2784,7 +2786,7 @@ out:
 				gfs_info->nodesize);
 		}
 
-		if (isize != size) {
+		if (isize != size && !has_orphan_item) {
 			if (repair)
 				ret = repair_dir_isize_lowmem(root, path,
 							      inode_id, size);
-- 
2.26.3

