Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C69321D45
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 17:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhBVQm0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 11:42:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:45958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231415AbhBVQlf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 11:41:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614012049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wkAlJdVa3Xd4GKsxOgV3jt9QWT7zx5JUYCUxXBNDdSU=;
        b=ep7wyFhXViZ8ndAFIIYLQLrJRCNrACtKa3w+ULw8fZ7XnKBckpEO7TTD7xU4S5KXZZxeij
        nqv2LNNthzIb+hRFQIX8OmTN19BOvWnb3VWQ1o8v+TZLoo2ZJAkaVDpMnyot+Yr8LeAUt1
        BTRneMUZlF9T0SM+2UR1lurhFOPTC34=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92060B02D;
        Mon, 22 Feb 2021 16:40:49 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/6] btrfs: Export qgroup_reserve_meta
Date:   Mon, 22 Feb 2021 18:40:43 +0200
Message-Id: <20210222164047.978768-3-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210222164047.978768-1-nborisov@suse.com>
References: <20210222164047.978768-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/qgroup.c | 4 ++--
 fs/btrfs/qgroup.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 808370ada888..fbef95bc3557 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3841,8 +3841,8 @@ static int sub_root_meta_rsv(struct btrfs_root *root, int num_bytes,
 	return num_bytes;
 }
 
-static int qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
-				enum btrfs_qgroup_rsv_type type, bool enforce)
+int qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
+			enum btrfs_qgroup_rsv_type type, bool enforce)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret;
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 50dea9a2d8fb..c1a3cc15dede 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -354,6 +354,9 @@ int btrfs_verify_qgroup_counts(struct btrfs_fs_info *fs_info, u64 qgroupid,
 			       u64 rfer, u64 excl);
 #endif
 
+int qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
+			enum btrfs_qgroup_rsv_type type, bool enforce);
+
 /* New io_tree based accurate qgroup reserve API */
 int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
 			struct extent_changeset **reserved, u64 start, u64 len);
-- 
2.25.1

