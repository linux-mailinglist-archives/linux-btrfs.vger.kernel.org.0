Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F32294855
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440853AbgJUG2K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:28:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:44768 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440851AbgJUG2J (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:28:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uhw1e4cdmOvNkm2CkvHJAuB4TB7nxWbxVf9YWD+poho=;
        b=hEuM7hz+/UsHBva+HodhhUTPZBauBc+f9SG/6U1vJvEQ2tt/nwDL9dwFls+OlvCbiSjiA7
        fvsndQddCqPUbEDwShjbi8/GLZ4E/5ZIVW0tM2WH7fdJFtD35SDZqNUlrBxCxo3h7H9Rne
        mgMrUGO2uPLgNKta2m8+iw3g7odomq8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85848AC1D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:28:08 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 57/68] btrfs: file: make btrfs_file_write_iter() to be page aligned
Date:   Wed, 21 Oct 2020 14:25:43 +0800
Message-Id: <20201021062554.68132-58-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is mostly for subpage write support, as we don't support to submit
subpage sized write yet, so we have to submit the full page write.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 30b22303ad2c..8f44bde1d04e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1909,6 +1909,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
+	u32 blocksize = PAGE_SIZE;
 	u64 start_pos;
 	u64 end_pos;
 	ssize_t num_written = 0;
@@ -1988,18 +1989,17 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	 */
 	update_time_for_write(inode);
 
-	start_pos = round_down(pos, fs_info->sectorsize);
+	start_pos = round_down(pos, blocksize);
 	oldsize = i_size_read(inode);
 	if (start_pos > oldsize) {
 		/* Expand hole size to cover write data, preventing empty gap */
-		end_pos = round_up(pos + count,
-				   fs_info->sectorsize);
+		end_pos = round_up(pos + count, blocksize);
 		err = btrfs_cont_expand(inode, oldsize, end_pos);
 		if (err) {
 			inode_unlock(inode);
 			goto out;
 		}
-		if (start_pos > round_up(oldsize, fs_info->sectorsize))
+		if (start_pos > round_up(oldsize, blocksize))
 			clean_page = 1;
 	}
 
-- 
2.28.0

