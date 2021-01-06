Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BACC2EBC83
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 11:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbhAFKgs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jan 2021 05:36:48 -0500
Received: from eu-shark2.inbox.eu ([195.216.236.82]:47782 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbhAFKgs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jan 2021 05:36:48 -0500
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 8FFBA44B97E;
        Wed,  6 Jan 2021 12:36:01 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1609929361; bh=OsQ1tCAreWh5/2G9AW5s3h20frXya5lzpwSFQjWb6DM=;
        h=From:To:Cc:Subject:Date;
        b=DM8DER2myxXmpu2dhgz4PslFf0+set8oSH8JVCsHt7wMlMDkqtgJHYKDRiE+fs/dh
         Nh1qb19G8dNpCA0K9kMMcoQXC/elz/hqmGx3wNBjbsc+PfSOXHr6tYfZYIpmWztuUd
         ITyDd7H4XPEMqyilJFPLkw8xbtyUZBbNHOKfPTqE=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 7CABC44B8E2;
        Wed,  6 Jan 2021 12:36:01 +0200 (EET)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 2ekzGVEyrsqa; Wed,  6 Jan 2021 12:36:01 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 373F744B8D0;
        Wed,  6 Jan 2021 12:36:01 +0200 (EET)
Received: from localhost.localdomain (unknown [45.87.95.231])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id D59731BE007B;
        Wed,  6 Jan 2021 12:35:59 +0200 (EET)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su
Subject: [PATCH] btrfs-progs: print bytenr of child eb if mismatched level found in read_node_slot()
Date:   Wed,  6 Jan 2021 18:35:50 +0800
Message-Id: <20210106103550.1145-1-l@damenly.su>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: 885mkI9QEjm6g1u/QXjfGWREoihVPpno+uG60R9Rn3r+NzL3DUV3MAzE42E2Ejyk
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If btrfs check reported like "ERROR: child eb corrupted: parent bytenr
=178081 item=246 parent level=1 child level=2". It's hard to find
which eb is corrupted without bytenr in dump tree information:
===================================================================
node 178081 level 1 items 424 free 69 generation 44495 owner EXTENT_TREE
fs uuid 7d9dbe1b-dea6-4141-807b-026325123ad8
chunk uuid 97a3e3aa-7105-4101-aaf7-50204a240e69
        key (16613126144 EXTENT_ITEM 4096) block 177939087360 gen 44433
        key (16632803328 EXTENT_ITEM 4096) block 177939120128 gen 44433
        key (16654548992 EXTENT_ITEM 8192) block 177970380800 gen 44336
        key (16697884672 EXTENT_ITEM 8192) block 177970397184 gen 44336
        key (16714223616 EXTENT_ITEM 16384) block 177970413568 gen 44336
        key (16721760256 EXTENT_ITEM 16384) block 177943855104 gen 44436
        key (16857755648 EXTENT_ITEM 4096) block 177857544192 gen 44416
...

===================================================================

For easier lookup, print bytenr of child eb if its level is not equal
to parent's level - 1 in read_node_slot().

Signed-off-by: Su Yue <l@damenly.su>
---
 kernel-shared/ctree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 01bc33a43c33..4cc3aebc1412 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -809,9 +809,9 @@ struct extent_buffer *read_node_slot(struct btrfs_fs_info *fs_info,
 
 	if (btrfs_header_level(ret) != level - 1) {
 		error(
-"child eb corrupted: parent bytenr=%llu item=%d parent level=%d child level=%d",
-		      btrfs_header_bytenr(parent), slot,
-		      btrfs_header_level(parent), btrfs_header_level(ret));
+"child eb corrupted: parent bytenr=%llu item=%d parent level=%d child bytenr=%llu child level=%d",
+		      btrfs_header_bytenr(parent), slot, btrfs_header_level(parent),
+		      btrfs_header_bytenr(ret), btrfs_header_level(ret));
 		free_extent_buffer(ret);
 		return ERR_PTR(-EIO);
 	}
-- 
2.30.0

