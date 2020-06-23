Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08D0205B3C
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 20:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbgFWS41 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 14:56:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:34676 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733170AbgFWS41 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 14:56:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3A9A5AD93;
        Tue, 23 Jun 2020 18:56:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A565FDA79B; Tue, 23 Jun 2020 20:56:13 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: don't use UAPI types for fiemap callback
Date:   Tue, 23 Jun 2020 20:56:12 +0200
Message-Id: <20200623185612.17112-1-dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The fiemap callback is not part of UAPI interface and the prototypes
don't have the __u64 types either.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 2 +-
 fs/btrfs/extent_io.h | 2 +-
 fs/btrfs/inode.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 06f43c9d6a84..f5430a15a22e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4668,7 +4668,7 @@ static int emit_last_fiemap_cache(struct fiemap_extent_info *fieinfo,
 }
 
 int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
-		__u64 start, __u64 len)
+		  u64 start, u64 len)
 {
 	int ret = 0;
 	u64 off = start;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 31c5a6aabd75..00a88f2eb5ab 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -204,7 +204,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 			    struct writeback_control *wbc);
 void extent_readahead(struct readahead_control *rac);
 int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
-		__u64 start, __u64 len);
+		  u64 start, u64 len);
 void set_page_extent_mapped(struct page *page);
 
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 86f7aa377da9..86daa90be515 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7953,7 +7953,7 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 }
 
 static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
-		__u64 start, __u64 len)
+			u64 start, u64 len)
 {
 	int	ret;
 
-- 
2.25.0

