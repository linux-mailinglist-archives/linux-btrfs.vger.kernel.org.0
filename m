Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC4835108C
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Apr 2021 10:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhDAIEW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 04:04:22 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:8488 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhDAIDz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Apr 2021 04:03:55 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 1193D9804D8;
        Thu,  1 Apr 2021 16:03:52 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] fs: btrfs: Remove repeated struct declaration
Date:   Thu,  1 Apr 2021 16:03:39 +0800
Message-Id: <20210401080339.999529-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTx5DSEMfSUwYGUtLVkpNSkxJTU9JSElISkpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ME06Axw6HD8UPCsrDEo3OR06
        Li5PCUpVSlVKTUpMSU1PSUhJTUlDVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJS01LNwY+
X-HM-Tid: 0a788c75c728d992kuws1193d9804d8
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

struct btrfs_inode is declared twice. One is declared at 67th line.
The blew declaration is not needed. Remove the duplicate.
struct btrfs_fs_info should be declared in the forward declarations.
Move it to the forward declarations.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 fs/btrfs/extent_io.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 824640cb0ace..227215a5722c 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -66,6 +66,7 @@ enum {
 struct btrfs_root;
 struct btrfs_inode;
 struct btrfs_io_bio;
+struct btrfs_fs_info;
 struct io_failure_record;
 struct extent_io_tree;
 
@@ -270,9 +271,6 @@ struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs);
 struct bio *btrfs_bio_clone(struct bio *bio);
 struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size);
 
-struct btrfs_fs_info;
-struct btrfs_inode;
-
 int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 		      u64 length, u64 logical, struct page *page,
 		      unsigned int pg_offset, int mirror_num);
-- 
2.25.1

