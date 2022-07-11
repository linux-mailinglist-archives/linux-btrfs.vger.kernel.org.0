Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA19B570573
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 16:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiGKOW6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 10:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiGKOW5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 10:22:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07F232EDF
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 07:22:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C0B561508
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 14:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310C5C3411C
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 14:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657549375;
        bh=re0Tl83jaIcmQguB3TQaXyXKBInBfHsnAGO4jVrTcAY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hylsFANTs7mTypYwBaUdE2uCW9HeaaC+NUa9uf6As8QR7EOJFIC/cIvnpa7bCEUN2
         Wgpn0lGxzjLF//tD8Lxqqh9RDaQEBkWeuYGr/MFVvtg8f566bTg4d/CGBr5sDE9EAh
         wPb0r7EsmvcblZ4dTaES4FZjJ0QFDKtS26e1H+2EV7SVrL9BKvlfSYVTHJJFIZ6DT/
         8W8bsQx9XEKAtQREvlq2WY5t0u4yFPNt6BpuLzU3d2EnPzZRdK4I1j/aQqFo+5flIb
         3tvCuwoXhdjpI57MMXbqwLkr0gdL/Dk+5vrRP7BdVbRClUG0BKaVmrbFQgOgOsPbeJ
         /GJvGSxzEelKw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: add optimized btrfs_ino() version for 64 bits systems
Date:   Mon, 11 Jul 2022 15:22:50 +0100
Message-Id: <838f6184cb7423b8da16659c88e8b33fa34c23d2.1657549024.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657549024.git.fdmanana@suse.com>
References: <cover.1657549024.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently btrfs_ino() tries to use first the objectid of the inode's
location key. This is to avoid truncation of the inode number on 32 bits
platforms because the i_ino field of struct inode has the unsigned long
type, while the objectid is a 64 bits unsigned type (u64) on every system.
This logic was added in commit 33345d01522f81 ("Btrfs: Always use 64bit
inode number").

However if we are running on a 64 bits system, we can always directly
return the i_ino value from struct inode, which eliminates the need for
he special if statement that tests for a location key type of
BTRFS_ROOT_ITEM_KEY - in which case i_ino may not have the same value as
the objectid in the inode's location objectid, it may have a value of
BTRFS_EMPTY_SUBVOL_DIR_OBJECTID, for the case of snapshots of trees with
subvolumes/snapshots inside them.

So add a special version for 64 bits system that directly returns i_ino
of struct inode. This eliminates one branch and reduces the overall code
size, since btrfs_ino() is an inline function that is extensively used.

Before:

$ size fs/btrfs/btrfs.ko
   text	   data	    bss	    dec	    hex	filename
1617487	 189240	  29032	1835759	 1c02ef	fs/btrfs/btrfs.ko

After:

$ size fs/btrfs/btrfs.ko
   text	   data	    bss	    dec	    hex	filename
1612028	 189180	  29032	1830240	 1bed60	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h       | 15 +++++++++++++++
 fs/btrfs/tests/btrfs-tests.c |  1 +
 2 files changed, 16 insertions(+)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index a18f90ff16f1..e38d0f09b89f 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -279,6 +279,12 @@ static inline void btrfs_insert_inode_hash(struct inode *inode)
 	__insert_inode_hash(inode, h);
 }
 
+#if BITS_PER_LONG == 32
+
+/*
+ * On 32 bits systems the i_ino of struct inode is 32 bits (unsigned long), so
+ * we use the inode's location objectid which is a u64 to avoid truncation.
+ */
 static inline u64 btrfs_ino(const struct btrfs_inode *inode)
 {
 	u64 ino = inode->location.objectid;
@@ -289,6 +295,15 @@ static inline u64 btrfs_ino(const struct btrfs_inode *inode)
 	return ino;
 }
 
+#else
+
+static inline u64 btrfs_ino(const struct btrfs_inode *inode)
+{
+	return inode->vfs_inode.i_ino;
+}
+
+#endif
+
 static inline void btrfs_i_size_write(struct btrfs_inode *inode, u64 size)
 {
 	i_size_write(&inode->vfs_inode, size);
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index 1591bfa55bcc..293e01228375 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -59,6 +59,7 @@ struct inode *btrfs_new_test_inode(void)
 		return NULL;
 
 	inode->i_mode = S_IFREG;
+	inode->i_ino = BTRFS_FIRST_FREE_OBJECTID;
 	BTRFS_I(inode)->location.type = BTRFS_INODE_ITEM_KEY;
 	BTRFS_I(inode)->location.objectid = BTRFS_FIRST_FREE_OBJECTID;
 	BTRFS_I(inode)->location.offset = 0;
-- 
2.35.1

