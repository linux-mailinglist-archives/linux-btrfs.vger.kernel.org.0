Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288DE379E8C
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 06:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhEKE0R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 May 2021 00:26:17 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:33978 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhEKE0R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 May 2021 00:26:17 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id D105C6C007A2;
        Tue, 11 May 2021 07:25:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1620707109; bh=Sqjw/ftEptNm7AFtiZtxgqGWKP3n12qwdZS82cjyrz4=;
        h=From:To:Cc:Subject:Date;
        b=Gw8pYZqVwHsHcvQgilZuKiDENcKYq3dHrx8F/aWXLzyL+4OTXfQPOIA78zMGISJ+J
         2+K0iMovAp5Hn967Cn1F9ZqRmrT5K2iJgcvm4D556u/qObOzYeBeNG+zQOwkhCV5T8
         M/RGAWT7IwfDXxLDCAGH/+4tXsYaf6oQzkZ7y5lQ=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id C3BEC6C0079F;
        Tue, 11 May 2021 07:25:09 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id OWZnlyFCg-ow; Tue, 11 May 2021 07:25:09 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 5E35B6C0077E;
        Tue, 11 May 2021 07:25:09 +0300 (EEST)
Received: from alarm.. (unknown [45.87.95.45])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 016471BE013A;
        Tue, 11 May 2021 07:25:07 +0300 (EEST)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su
Subject: [PATCH] btrfs-progs: do not BUG_ON if btrfs_add_to_fsid succeeded to write superblock
Date:   Tue, 11 May 2021 12:25:01 +0800
Message-Id: <20210511042501.900731-1-l@damenly.su>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: 6N1mlpY9ZDPk1R69MAjTf2YrzV5EXevl+uWy0xxdmmeDUSOAe1YFVw6+mHJySGA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 8ef9313cf298 ("btrfs-progs: zoned: implement log-structured
superblock") changed to write BTRFS_SUPER_INFO_SIZE bytes to device.
The before num of bytes to be written is sectorsize.
It causes mkfs.btrfs failed on my 16k pagesize kvm:

  $ /usr/bin/mkfs.btrfs -s 16k -f -mraid0 /dev/vdb2 /dev/vdb3
  btrfs-progs v5.12
  See http://btrfs.wiki.kernel.org for more information.

  ERROR: superblock magic doesn't match
  ERROR: superblock magic doesn't match
  common/device-scan.c:195: btrfs_add_to_fsid: BUG_ON `ret != sectorsize`
  triggered, value 1
  /usr/bin/mkfs.btrfs(btrfs_add_to_fsid+0x274)[0xaaab4fe8a5fc]
  /usr/bin/mkfs.btrfs(main+0x1188)[0xaaab4fe4dc8c]
  /usr/lib/libc.so.6(__libc_start_main+0xe8)[0xffff7223c538]
  /usr/bin/mkfs.btrfs(+0xc558)[0xaaab4fe4c558]

  [1]    225842 abort (core dumped)  /usr/bin/mkfs.btrfs -s 16k -f -mraid0
  /dev/vdb2 /dev/vdb3

btrfs_add_to_fsid() now always calls sbwrite() to write
BTRFS_SUPER_INFO_SIZE bytes to device, so change condition of
the BUG_ON().
Also add comments for sbread() and sbwrite().

Signed-off-by: Su Yue <l@damenly.su>
---
 common/device-scan.c  |  4 ++--
 kernel-shared/zoned.h | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/common/device-scan.c b/common/device-scan.c
index 07cda0c9..6a3bd098 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -192,8 +192,8 @@ int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
 	memcpy(&dev_item->uuid, device->uuid, BTRFS_UUID_SIZE);
 
 	ret = sbwrite(fd, buf, BTRFS_SUPER_INFO_OFFSET);
-	BUG_ON(ret != sectorsize);
-
+	/* ensure super block was written to the device */
+	BUG_ON(ret != BTRFS_SUPER_INFO_SIZE);
 	free(buf);
 	list_add(&device->dev_list, &fs_info->fs_devices->devices);
 	device->fs_devices = fs_info->fs_devices;
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index a246e161..47129f92 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -51,11 +51,29 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
 #ifdef BTRFS_ZONED
 size_t btrfs_sb_io(int fd, void *buf, off_t offset, int rw);
 
+/*
+ * sbread - read BTRFS_SUPER_INFO_SIZE bytes from fd to buf
+ *
+ * @fd		fd of the device to be read from
+ * @buf:	buffer contains a super block
+ * @offset:	offset of the superblock
+ *
+ * Return count of bytes successfully read.
+ */
 static inline size_t sbread(int fd, void *buf, off_t offset)
 {
 	return btrfs_sb_io(fd, buf, offset, READ);
 }
 
+/*
+ * sbwrite - write BTRFS_SUPER_INFO_SIZE bytes from buf to fd
+ *
+ * @fd		fd of the device to be written to
+ * @buf:	buffer contains a super block
+ * @offset:	offset of the superblock
+ *
+ * Return count of bytes successfully written.
+ */
 static inline size_t sbwrite(int fd, void *buf, off_t offset)
 {
 	return btrfs_sb_io(fd, buf, offset, WRITE);
-- 
2.31.1

