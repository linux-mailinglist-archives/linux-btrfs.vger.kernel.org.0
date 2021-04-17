Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E718C363014
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Apr 2021 15:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbhDQMwq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Apr 2021 08:52:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:42250 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236313AbhDQMwq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Apr 2021 08:52:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618663939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=LoPnGGDJhIUbPCGZP8qp9jNUM/LxybXNFtbfJ3/eBdI=;
        b=qCgxy7Ak8/47IJ6gN+tAnmagv7/AR2ZVEB7lkeUrIhWeY4juIO+g7o68hdvvKvXkMJYI9h
        w1iE1Vv7OlyOUXXaqo3JURDIydwCGlTjjLCuHkDjzHiCLClzDGMH2BeoGKTtatGJL4s3Zi
        cPUgXmSbWF7Oe0/TJoiySuKvohx0J1A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F2A9CB2F1;
        Sat, 17 Apr 2021 12:52:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     linux-btrfs@vger.kernel.org,
        Matwey Kornilov <matwey.kornilov@gmail.com>
Subject: [PATCH U-boot v2] fs: btrfs: fix the false alert of decompression failure
Date:   Sat, 17 Apr 2021 20:52:13 +0800
Message-Id: <20210417125213.132066-1-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are some cases where decompressed sectors can have padding zeros.

In kernel code, we have lines to address such situation:

        /*
         * btrfs_getblock is doing a zero on the tail of the page too,
         * but this will cover anything missing from the decompressed
         * data.
         */
        if (bytes < destlen)
                memset(kaddr+bytes, 0, destlen-bytes);
        kunmap_local(kaddr);

But not in U-boot code, thus we have some reports of U-boot failed to
read compressed files in btrfs.

Fix it by doing the same thing of the kernel, for both inline and
regular compressed extents.

Reported-by: Matwey Kornilov <matwey.kornilov@gmail.com>
Link: https://bugzilla.suse.com/show_bug.cgi?id=1183717
Fixes: a26a6bedafcf ("fs: btrfs: Introduce btrfs_read_extent_inline() and btrfs_read_extent_reg()")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix the bug for regular and inline compressed extents
---
 fs/btrfs/inode.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 019d532a1a4b..2c2379303d74 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -390,10 +390,16 @@ int btrfs_read_extent_inline(struct btrfs_path *path,
 			   csize);
 	ret = btrfs_decompress(btrfs_file_extent_compression(leaf, fi),
 			       cbuf, csize, dbuf, dsize);
-	if (ret < 0 || ret != dsize) {
+	if (ret == (u32)-1) {
 		ret = -EIO;
 		goto out;
 	}
+	/*
+	 * The compressed part ends before sector boundary, the remaining needs
+	 * to be zeroed out.
+	 */
+	if (ret < dsize)
+		memset(dbuf + ret, 0, dsize - ret);
 	memcpy(dest, dbuf, dsize);
 	ret = dsize;
 out:
@@ -494,10 +500,16 @@ int btrfs_read_extent_reg(struct btrfs_path *path,
 
 	ret = btrfs_decompress(btrfs_file_extent_compression(leaf, fi), cbuf,
 			       csize, dbuf, dsize);
-	if (ret != dsize) {
+	if (ret == (u32)-1) {
 		ret = -EIO;
 		goto out;
 	}
+	/*
+	 * The compressed part ends before sector boundary, the remaining needs
+	 * to be zeroed out.
+	 */
+	if (ret < dsize)
+		memset(dbuf + ret, 0, dsize - ret);
 	/* Then copy the needed part */
 	memcpy(dest, dbuf + btrfs_file_extent_offset(leaf, fi), len);
 	ret = len;
-- 
2.31.1

