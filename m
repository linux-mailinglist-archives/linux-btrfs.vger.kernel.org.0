Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23282A2D51
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgKBOtT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:49:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:39900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgKBOtM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 09:49:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604328550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zT7DEhHKEBZJdaMJc5yj1BShYjB8LP/s8HIhXRXm3xY=;
        b=UQO6ZBbjFVVHwfWijxM4iKElp/pPXl2Lk2BsuQRxH8iHoNwUCZ227oJXMPa38+OOrsiLNk
        4NfM9GKwU2ve2QkTikc6J4kf5AkvIAHnUV6np2EYGUxBAfDclxg+D2ABwN8O08zWoVKKvh
        pJHad5XLAYEKRjLZ4ZTw28v6fIpePtM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87243B912;
        Mon,  2 Nov 2020 14:49:10 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 09/14] btrfs: Make find_first_non_hole take btrfs_inode
Date:   Mon,  2 Nov 2020 16:49:01 +0200
Message-Id: <20201102144906.3767963-10-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102144906.3767963-1-nborisov@suse.com>
References: <20201102144906.3767963-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/file.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 56f6548da451..1baf69f012fe 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2484,13 +2484,13 @@ static int fill_holes(struct btrfs_trans_handle *trans,
  *	   em->start + em->len > start)
  * When a hole extent is found, return 1 and modify start/len.
  */
-static int find_first_non_hole(struct inode *inode, u64 *start, u64 *len)
+static int find_first_non_hole(struct btrfs_inode *inode, u64 *start, u64 *len)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_map *em;
 	int ret = 0;
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0,
+	em = btrfs_get_extent(inode, NULL, 0,
 			      round_down(*start, fs_info->sectorsize),
 			      round_up(*len, fs_info->sectorsize));
 	if (IS_ERR(em))
@@ -2780,7 +2780,8 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 		trans->block_rsv = rsv;
 
 		if (!extent_info) {
-			ret = find_first_non_hole(inode, &cur_offset, &len);
+			ret = find_first_non_hole(BTRFS_I(inode), &cur_offset,
+						  &len);
 			if (unlikely(ret < 0))
 				break;
 			if (ret && !len) {
@@ -2890,7 +2891,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 
 	inode_lock(inode);
 	ino_size = round_up(inode->i_size, fs_info->sectorsize);
-	ret = find_first_non_hole(inode, &offset, &len);
+	ret = find_first_non_hole(BTRFS_I(inode), &offset, &len);
 	if (ret < 0)
 		goto out_only_mutex;
 	if (ret && !len) {
@@ -2940,7 +2941,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		/* after truncate page, check hole again */
 		len = offset + len - lockstart;
 		offset = lockstart;
-		ret = find_first_non_hole(inode, &offset, &len);
+		ret = find_first_non_hole(BTRFS_I(inode), &offset, &len);
 		if (ret < 0)
 			goto out_only_mutex;
 		if (ret && !len) {
@@ -2954,7 +2955,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	tail_start = lockend + 1;
 	tail_len = offset + len - tail_start;
 	if (tail_len) {
-		ret = find_first_non_hole(inode, &tail_start, &tail_len);
+		ret = find_first_non_hole(BTRFS_I(inode), &tail_start, &tail_len);
 		if (unlikely(ret < 0))
 			goto out_only_mutex;
 		if (!ret) {
-- 
2.25.1

