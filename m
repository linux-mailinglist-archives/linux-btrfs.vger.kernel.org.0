Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC8E4BF3DD
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 09:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiBVImp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 03:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiBVImo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 03:42:44 -0500
Received: from eu-shark1.inbox.eu (eu-shark1.inbox.eu [195.216.236.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4D535DFA
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 00:42:17 -0800 (PST)
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 52DC76C00789;
        Tue, 22 Feb 2022 10:42:16 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1645519336; bh=huOXXasZn0YozjI7euc7nM+0Zs5byxRkHh7g8ukmuyc=;
        h=From:To:Cc:Subject:Date:Message-Id:X-ESPOL:from:date:to:cc;
        b=ACCKHHBynjLp+aR8ATVnSjPlYS0K/Xc9v6i76d24TSCsNlIZwqC5huUXLZWlwHhGn
         8/uqWK6YkfvJzOYY4H417xY+SfPBZXZlJP0eUL5aLqAqNsRoHiPV4uSPCn4HJO+Q+M
         PNF+KFQluC0J0ngVZuPG5ya0ztDv0SAcou7bKmkY=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 3F1196C007BB;
        Tue, 22 Feb 2022 10:42:16 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 7JV_8DtqxCp4; Tue, 22 Feb 2022 10:42:15 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id D66B36C00789;
        Tue, 22 Feb 2022 10:42:15 +0200 (EET)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <l@damenly.su>, Wenqing Liu <wenqingliu0120@gmail.com>
Subject: [PATCH] btrfs: tree-checker: save item data end in u64 to avoid
Date:   Tue, 22 Feb 2022 16:42:07 +0800
Message-Id: <20220222084207.1021-1-l@damenly.su>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: +dBm1NUOBkfEh1+hQGXfAQQpri5IQu/l8vvYpBBYmnv7MyaHf0wLTHLEkG9qPg+1xF8X
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

User reported there is an array-index-out-of-bounds access while
mounting the crafted image:

=======================================================================
[  350.411942 ] loop0: detected capacity change from 0 to 262144
[  350.427058 ] BTRFS: device fsid a62e00e8-e94e-4200-8217-12444de93c2e
devid 1 transid 8 /dev/loop0 scanned by systemd-udevd (1044)
[  350.428564 ] BTRFS info (device loop0): disk space caching is enabled
[  350.428568 ] BTRFS info (device loop0): has skinny extents
[  350.429589 ]
[  350.429619 ] UBSAN: array-index-out-of-bounds in
fs/btrfs/struct-funcs.c:161:1
[  350.429636 ] index 1048096 is out of range for type 'page *[16]'
[  350.429650 ] CPU: 0 PID: 9 Comm: kworker/u8:1 Not tainted 5.16.0-rc4
[  350.429652 ] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.13.0-1ubuntu1.1 04/01/2014
[  350.429653 ] Workqueue: btrfs-endio-meta btrfs_work_helper [btrfs]
[  350.429772 ] Call Trace:
[  350.429774 ]  <TASK>
[  350.429776 ]  dump_stack_lvl+0x47/0x5c
[  350.429780 ]  ubsan_epilogue+0x5/0x50
[  350.429786 ]  __ubsan_handle_out_of_bounds+0x66/0x70
[  350.429791 ]  btrfs_get_16+0xfd/0x120 [btrfs]
[  350.429832 ]  check_leaf+0x754/0x1a40 [btrfs]
[  350.429874 ]  ? filemap_read+0x34a/0x390
[  350.429878 ]  ? load_balance+0x175/0xfc0
[  350.429881 ]  validate_extent_buffer+0x244/0x310 [btrfs]
[  350.429911 ]  btrfs_validate_metadata_buffer+0xf8/0x100 [btrfs]
[  350.429935 ]  end_bio_extent_readpage+0x3af/0x850 [btrfs]
[  350.429969 ]  ? newidle_balance+0x259/0x480
[  350.429972 ]  end_workqueue_fn+0x29/0x40 [btrfs]
[  350.429995 ]  btrfs_work_helper+0x71/0x330 [btrfs]
[  350.430030 ]  ? __schedule+0x2fb/0xa40
[  350.430033 ]  process_one_work+0x1f6/0x400
[  350.430035 ]  ? process_one_work+0x400/0x400
[  350.430036 ]  worker_thread+0x2d/0x3d0
[  350.430037 ]  ? process_one_work+0x400/0x400
[  350.430038 ]  kthread+0x165/0x190
[  350.430041 ]  ? set_kthread_struct+0x40/0x40
[  350.430043 ]  ret_from_fork+0x1f/0x30
[  350.430047 ]  </TASK>
[  350.430047 ]
[  350.430077 ] BTRFS warning (device loop0): bad eb member start: ptr
0xffe20f4e start 20975616 member offset 4293005178 size 2
=======================================================================

btrfs check reports:
  corrupt leaf: root=3 block=20975616 physical=20975616 slot=1, unexpected
  item end, have 4294971193 expect 3897

The 1st slot item offset is 4293005033 and the size is 1966160.
In check_leaf, we use btrfs_item_end() to check item boundary versus
extent_buffer data size. However, return type of btrfs_item_end() is u32.
(u32)(4293005033 + 1966160) == 3897, overflow happens and the result 3897
equals to leaf data size reasonably.

Fix it by use u64 variable to store item data end in check_leaf() to
avoid u32 overflow.

This commit does solve the invalid memory access showed by the stack trace.
However, its metadata profile is DUP and another copy of the leaf is fine.
So the image can be mounted successfully. But when umount is called,
the ASSERT btrfs_mark_buffer_dirty() will be trigered becase the the only node
in extent tree has 0 item and invalid owner. It's solved by another commit
"btrfs: check extent buffer owner against the owner rootid".

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215299
Reported-by: Wenqing Liu <wenqingliu0120@gmail.com>
Signed-off-by: Su Yue <l@damenly.su>
---
 fs/btrfs/tree-checker.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 9fd145f1c4bc..aae5697dde32 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1682,6 +1682,7 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 	 */
 	for (slot = 0; slot < nritems; slot++) {
 		u32 item_end_expected;
+		u64 item_data_end;
 		int ret;
 
 		btrfs_item_key_to_cpu(leaf, &key, slot);
@@ -1696,6 +1697,8 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 			return -EUCLEAN;
 		}
 
+		item_data_end = (u64)btrfs_item_offset(leaf, slot) +
+				btrfs_item_size(leaf, slot);
 		/*
 		 * Make sure the offset and ends are right, remember that the
 		 * item data starts at the end of the leaf and grows towards the
@@ -1706,11 +1709,10 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 		else
 			item_end_expected = btrfs_item_offset(leaf,
 								 slot - 1);
-		if (unlikely(btrfs_item_data_end(leaf, slot) != item_end_expected)) {
+		if (unlikely(item_data_end != item_end_expected)) {
 			generic_err(leaf, slot,
-				"unexpected item end, have %u expect %u",
-				btrfs_item_data_end(leaf, slot),
-				item_end_expected);
+				"unexpected item end, have %llu expect %u",
+				item_data_end, item_end_expected);
 			return -EUCLEAN;
 		}
 
@@ -1719,12 +1721,10 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 		 * just in case all the items are consistent to each other, but
 		 * all point outside of the leaf.
 		 */
-		if (unlikely(btrfs_item_data_end(leaf, slot) >
-			     BTRFS_LEAF_DATA_SIZE(fs_info))) {
+		if (unlikely(item_data_end > BTRFS_LEAF_DATA_SIZE(fs_info))) {
 			generic_err(leaf, slot,
-			"slot end outside of leaf, have %u expect range [0, %u]",
-				btrfs_item_data_end(leaf, slot),
-				BTRFS_LEAF_DATA_SIZE(fs_info));
+			"slot end outside of leaf, have %llu expect range [0, %u]",
+				item_data_end, BTRFS_LEAF_DATA_SIZE(fs_info));
 			return -EUCLEAN;
 		}
 
-- 
2.34.1

