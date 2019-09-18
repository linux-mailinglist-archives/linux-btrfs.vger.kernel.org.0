Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A49CB62CD
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2019 14:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfIRMI6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Sep 2019 08:08:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727637AbfIRMI5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Sep 2019 08:08:57 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15F1521907
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Sep 2019 12:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568808536;
        bh=yd9CDRG69+XyyIrd55fLqmx2ZSVKG7rp2Ow2YcV71go=;
        h=From:To:Subject:Date:From;
        b=MG5VBHQUfHiVa4MhdCf+eqM0vCmVn6gGsN+Ky5KROydK8fvDNrk620+LUOPonpIaU
         55tT2y/E336NAMNFnuR/MFvokWPeV7ZFUlsiAXpmNy8P04hJQWlGNotJqyoeuCwnnn
         kYfYv4FS94kN5x4jdPJ4Z/5JxNvGUQXDkiDnh8CY=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix selftests failure due to uninitialized i_mode in test inodes
Date:   Wed, 18 Sep 2019 13:08:52 +0100
Message-Id: <20190918120852.764-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Some of the self tests create a test inode, setup some extents and then do
calls to btrfs_get_extent() to test that the corresponding extent maps
exist and are correct. However btrfs_get_extent(), since the 5.2 merge
window, now errors out when it finds a regular or prealloc extent for an
inode that does not correspond to a regular file (its ->i_mode is not
S_IFREG). This causes the self tests to fail sometimes, specially when
KASAN, slub_debug and page poisoning are enabled:

  $ modprobe btrfs
  modprobe: ERROR: could not insert 'btrfs': Invalid argument

  $ dmesg
  [ 9414.691648] Btrfs loaded, crc32c=crc32c-intel, debug=on, assert=on, integrity-checker=on, ref-verify=on
  [ 9414.692655] BTRFS: selftest: sectorsize: 4096  nodesize: 4096
  [ 9414.692658] BTRFS: selftest: running btrfs free space cache tests
  [ 9414.692918] BTRFS: selftest: running extent only tests
  [ 9414.693061] BTRFS: selftest: running bitmap only tests
  [ 9414.693366] BTRFS: selftest: running bitmap and extent tests
  [ 9414.696455] BTRFS: selftest: running space stealing from bitmap to extent tests
  [ 9414.697131] BTRFS: selftest: running extent buffer operation tests
  [ 9414.697133] BTRFS: selftest: running btrfs_split_item tests
  [ 9414.697564] BTRFS: selftest: running extent I/O tests
  [ 9414.697583] BTRFS: selftest: running find delalloc tests
  [ 9415.081125] BTRFS: selftest: running find_first_clear_extent_bit test
  [ 9415.081278] BTRFS: selftest: running extent buffer bitmap tests
  [ 9415.124192] BTRFS: selftest: running inode tests
  [ 9415.124195] BTRFS: selftest: running btrfs_get_extent tests
  [ 9415.127909] BTRFS: selftest: running hole first btrfs_get_extent test
  [ 9415.128343] BTRFS critical (device (efault)): regular/prealloc extent found for non-regular inode 256
  [ 9415.131428] BTRFS: selftest: fs/btrfs/tests/inode-tests.c:904 expected a real extent, got 0

This happens because the test inodes are created without ever initializing
the i_mode field of the inode, and neither VFS's new_inode() nor the btrfs
callback btrfs_alloc_inode() initialize the i_mode. Initialization of the
i_mode is done through the various callbacks used by the VFS to create
new inodes (regular files, directories, symlinks, tmpfiles, etc), which
all call btrfs_new_inode() which in turn calls inode_init_owner(), which
sets the inode's i_mode. Since the tests only uses new_inode() to create
the test inodes, the i_mode was never initialized.

This always happens on a VM I used with kasan, slub_debug and many other
debug facilities enabled. It also happened to someone who reported this
on bugzilla (on a 5.3-rc).

Fix this by setting i_mode to S_IFREG at btrfs_new_test_inode().

Fixes: 6bf9e4bd6a2778 ("btrfs: inode: Verify inode mode to avoid NULL pointer dereference")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204397
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tests/btrfs-tests.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index b5e80563efaa..99fe9bf3fdac 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -52,7 +52,13 @@ static struct file_system_type test_type = {
 
 struct inode *btrfs_new_test_inode(void)
 {
-	return new_inode(test_mnt->mnt_sb);
+	struct inode *inode;
+
+	inode = new_inode(test_mnt->mnt_sb);
+	if (inode)
+		inode_init_owner(inode, NULL, S_IFREG);
+
+	return inode;
 }
 
 static int btrfs_init_test_fs(void)
-- 
2.11.0

