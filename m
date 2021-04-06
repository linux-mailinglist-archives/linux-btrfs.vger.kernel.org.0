Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E0335591D
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 18:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243933AbhDFQYZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 12:24:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:49952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234971AbhDFQYY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Apr 2021 12:24:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D87D6AD7C;
        Tue,  6 Apr 2021 16:24:15 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 2/2] btrfs: Use reada_control pointer instead of void pointer
Date:   Tue,  6 Apr 2021 11:24:04 -0500
Message-Id: <20210406162404.11746-2-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406162404.11746-1-rgoldwyn@suse.de>
References: <20210406162404.11746-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Since struct reada_control is defined in ctree.h,
Use struct reada_control pointer as a function argument for
btrfs_reada_wait() instead of a void pointer in order
to avoid type-casting within the function.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h | 2 +-
 fs/btrfs/reada.c | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2acbd8919611..8bf434a4f014 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3699,7 +3699,7 @@ struct reada_control {
 };
 struct reada_control *btrfs_reada_add(struct btrfs_root *root,
 			      struct btrfs_key *start, struct btrfs_key *end);
-int btrfs_reada_wait(void *handle);
+int btrfs_reada_wait(struct reada_control *rc);
 int btree_readahead_hook(struct extent_buffer *eb, int err);
 void btrfs_reada_remove_dev(struct btrfs_device *dev);
 void btrfs_reada_undo_remove_dev(struct btrfs_device *dev);
diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
index 0d357f8b65bc..9bfa47cd3920 100644
--- a/fs/btrfs/reada.c
+++ b/fs/btrfs/reada.c
@@ -998,9 +998,8 @@ struct reada_control *btrfs_reada_add(struct btrfs_root *root,
 }
 
 #ifdef DEBUG
-int btrfs_reada_wait(void *handle)
+int btrfs_reada_wait(struct reada_control *rc)
 {
-	struct reada_control *rc = handle;
 	struct btrfs_fs_info *fs_info = rc->fs_info;
 
 	while (atomic_read(&rc->elems)) {
@@ -1018,9 +1017,8 @@ int btrfs_reada_wait(void *handle)
 	return 0;
 }
 #else
-int btrfs_reada_wait(void *handle)
+int btrfs_reada_wait(struct reada_control *rc)
 {
-	struct reada_control *rc = handle;
 	struct btrfs_fs_info *fs_info = rc->fs_info;
 
 	while (atomic_read(&rc->elems)) {
-- 
2.30.2

