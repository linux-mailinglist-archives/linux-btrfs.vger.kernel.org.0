Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5EC04736B3
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Dec 2021 22:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243153AbhLMVrS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 16:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhLMVrR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 16:47:17 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DCBC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 13:47:17 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id o17so16708665qtk.1
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 13:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CcAm90px8d0P0fksmrE6dkUaatA8uCDPJ4P8G8Cjj/A=;
        b=EMpH/MLr1GM8NPlSjkL0qV/ZyWES9EkFRC2qcanle1N0YB/G9f/+kGwJvQ0Mz/Ohga
         fjqQORJrVuhzl3O0D/oODXC2lIhkhJV7iWG4qLNE3zdKDac8jp2FmDHpjEx+dR6JtIgA
         R2ge5sU7U6J9Mvq+pGsE5ggHp4C6h75+z1brWjyvl6Wdu3RpVaEqR+Z4e7EUV1eKMBKb
         /Ff+/t68jHODDr8hSnAvcNkjaFbtdaeiiH0Db3i0h7F1PT0H7LArklO85ZXbyS5XdaZd
         5rUp9RZmYaoK9tk6uuZ1tS7fV3wn50FA693gQf8GL4AZcjkI4Y7sIZaH3b1+WbCkawaW
         33Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CcAm90px8d0P0fksmrE6dkUaatA8uCDPJ4P8G8Cjj/A=;
        b=jLxHX8YN+TX3H58h650BtQsz/x4I+E5jqxmz8Vuku5lTltlFL8FVhHgbrGaUlERJ1f
         /9XpIB46uzWcfZZLQzfUqVIlS+vhSOiad/9FIltAgNNGFamZrz7KoSnNShliLBnImuWq
         yHl2s7r7wlwE7SqJhCCNhr2GPvGDMw/mAyljHP1YDcd3ATF0nsTh0v5foTAYTsNvxK7Y
         5Su0faxtEHAawW7M4uHv0pIHVN1KeX3gLjfZSBjVNo23evDMuJw77i9jnR6jhhfvRh4u
         un2FjyJtdiOz1LaDk0rUdfsVB+RxqeS8dx2voXMN9He0FostFEN3m/1SUTd+HZzkGKC2
         sxKw==
X-Gm-Message-State: AOAM533t9ulSP6nUXOcD067AParSmUYY67tUJKN5JQirHekrqb3ujHyK
        DNG3g39AmRRnyMiBi+/O/a2EJ9WWI2Z9pw==
X-Google-Smtp-Source: ABdhPJw9163rgEz0Nk/9pBuuhnaBDJdz3j22QYUW2SR43H/8Fv43nukZ1fxPoO5xc6qHH32aiTrkTA==
X-Received: by 2002:ac8:7f4f:: with SMTP id g15mr1232817qtk.309.1639432036207;
        Mon, 13 Dec 2021 13:47:16 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y11sm11230218qta.6.2021.12.13.13.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 13:47:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 1/2] btrfs-progs: handle orphan directories properly
Date:   Mon, 13 Dec 2021 16:47:11 -0500
Message-Id: <08a5d84c7f4b7fccf4e9f51130867e5c7e643bfc.1639431951.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639431951.git.josef@toxicpanda.com>
References: <cover.1639431951.git.josef@toxicpanda.com>
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
index 696ad215..8aa70f9e 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -2726,6 +2726,8 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 					imode_to_type(mode), key.objectid,
 					key.offset);
 			}
+			if (is_orphan && key.type == BTRFS_DIR_INDEX_KEY)
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
+		if (isize != size && !is_orphan) {
 			if (repair)
 				ret = repair_dir_isize_lowmem(root, path,
 							      inode_id, size);
-- 
2.26.3

