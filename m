Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2092A19E787
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Apr 2020 22:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgDDUU0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Apr 2020 16:20:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgDDUU0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 4 Apr 2020 16:20:26 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFBF8206C3
        for <linux-btrfs@vger.kernel.org>; Sat,  4 Apr 2020 20:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586031626;
        bh=ghqe8WbLkHiNHmCPDN2B2mLrBzCG3shSYsacd+svo6Y=;
        h=From:To:Subject:Date:From;
        b=Y3l0O7LdnieQs/KS8HmTRdMoXg3iiZ6dbQFgNqe+OPt6HQleBYIT4iToAvlubxQjU
         tK2WS8i1zmkiRHs1BDPxncRhVmE/U/wuQLg7HJ9ZJZMw1mnAF2UMoGjjzstpnhy151
         sPvOrJSgZKUn8HgC9rsp/jrBzUyadc0kCtCLFLm8=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix lost i_size update after cloning inline extent
Date:   Sat,  4 Apr 2020 21:20:22 +0100
Message-Id: <20200404202022.30192-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When not using the NO_HOLES feature we were not marking the destination's
file range as written after cloning an inline extent into it. This can
lead to a data loss if the current destination file size is smaller than
the source file's size.

Example:

  $ mkfs.btrfs -f -O ^no-holes /dev/sdc
  $ mount /mnt/sdc /mnt

  $ echo "hello world" > /mnt/foo
  $ cp --reflink=always /mnt/foo /mnt/bar
  $ rm -f /mnt/foo
  $ umount /mnt

  $ mount /mnt/sdc /mnt
  $ cat /mnt/bar
  $
  $ stat -c %s /mnt/bar
  0

  # -> the file is empty, since we deleted foo, the data lost is forever

Fix that by calling btrfs_inode_set_file_extent_range() after cloning an
inline extent.

A test case for fstests will follow soon.

Fixes: 9ddc959e802bf ("btrfs: use the file extent tree infrastructure")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/reflink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index d1973141d3bb..040009d1cc31 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -264,6 +264,7 @@ static int clone_copy_inline_extent(struct inode *dst,
 			    size);
 	inode_add_bytes(dst, datal);
 	set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &BTRFS_I(dst)->runtime_flags);
+	ret = btrfs_inode_set_file_extent_range(BTRFS_I(dst), 0, aligned_end);
 out:
 	if (!ret && !trans) {
 		/*
-- 
2.11.0

