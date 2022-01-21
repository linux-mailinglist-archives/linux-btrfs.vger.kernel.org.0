Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C7B495CDD
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jan 2022 10:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379745AbiAUJdt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jan 2022 04:33:49 -0500
Received: from eu-shark1.inbox.eu ([195.216.236.81]:33562 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379712AbiAUJds (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jan 2022 04:33:48 -0500
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 6BF876C00705;
        Fri, 21 Jan 2022 11:33:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1642757627; bh=dj3wbxUEkniSDWlB95bHIChlhS8CuytXGcd48awZcYk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:X-ESPOL:
         from:date:to:cc;
        b=XRL8/5lx/mTI+FEz9umX0I/FGN/YH3OD3Ur9BftINNOkUB2lv6G5ZpovIJueWnQet
         r8/jTQDvVQJVOwinHPZtrEq4BWGQaHI8DW9JtyIJtBmSI49VBDkLkTa4EW0UUPwuMB
         96+wRzBsF+Pu9Bpn8/CCRa/XiCIkJRddwiVI6FQY=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 5C25C6C006CC;
        Fri, 21 Jan 2022 11:33:47 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id e38gZUQL4jIC; Fri, 21 Jan 2022 11:33:47 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id EAC886C006DB;
        Fri, 21 Jan 2022 11:33:46 +0200 (EET)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su, Wenqing Liu <wenqingliu0120@gmail.com>
Subject: [PATCH 1/2] btrfs: tree-checker: check item_size for inode_item
Date:   Fri, 21 Jan 2022 17:33:34 +0800
Message-Id: <20220121093335.1840306-2-l@damenly.su>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121093335.1840306-1-l@damenly.su>
References: <20220121093335.1840306-1-l@damenly.su>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: 885mlYpNBD+giECgR3rABwYzs1k6UZeF54XJ3R5F/g/3MCiEf0oFUxGzm3AFM3H44X8X
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

while mounting the crafted image, out-of-bounds access happens:
=======================================================================
[  350.429619] UBSAN: array-index-out-of-bounds in fs/btrfs/struct-funcs.c:161:1
[  350.429636] index 1048096 is out of range for type 'page *[16]'
[  350.429650] CPU: 0 PID: 9 Comm: kworker/u8:1 Not tainted 5.16.0-rc4 #1
[  350.429652] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  350.429653] Workqueue: btrfs-endio-meta btrfs_work_helper [btrfs]
[  350.429772] Call Trace:
[  350.429774]  <TASK>
[  350.429776]  dump_stack_lvl+0x47/0x5c
[  350.429780]  ubsan_epilogue+0x5/0x50
[  350.429786]  __ubsan_handle_out_of_bounds+0x66/0x70
[  350.429791]  btrfs_get_16+0xfd/0x120 [btrfs]
[  350.429832]  check_leaf+0x754/0x1a40 [btrfs]
[  350.429874]  ? filemap_read+0x34a/0x390
[  350.429878]  ? load_balance+0x175/0xfc0
[  350.429881]  validate_extent_buffer+0x244/0x310 [btrfs]
[  350.429911]  btrfs_validate_metadata_buffer+0xf8/0x100 [btrfs]
[  350.429935]  end_bio_extent_readpage+0x3af/0x850 [btrfs]
[  350.429969]  ? newidle_balance+0x259/0x480
[  350.429972]  end_workqueue_fn+0x29/0x40 [btrfs]
[  350.429995]  btrfs_work_helper+0x71/0x330 [btrfs]
[  350.430030]  ? __schedule+0x2fb/0xa40
[  350.430033]  process_one_work+0x1f6/0x400
[  350.430035]  ? process_one_work+0x400/0x400
[  350.430036]  worker_thread+0x2d/0x3d0
[  350.430037]  ? process_one_work+0x400/0x400
[  350.430038]  kthread+0x165/0x190
[  350.430041]  ? set_kthread_struct+0x40/0x40
[  350.430043]  ret_from_fork+0x1f/0x30
[  350.430047]  </TASK>
[  350.430077] BTRFS warning (device loop0): bad eb member start: ptr 0xffe20f4e start 20975616 member offset 4293005178 size 2
=======================================================================

check_leaf() is checking the leaf:
========================================================================
corrupt leaf: root=4 block=29396992 slot=1, bad key order, prev (16140901064495857664 1 0) current (1 204 12582912)
leaf 29396992 items 6 free space 3565 generation 6 owner DEV_TREE
leaf 29396992 flags 0x1(WRITTEN) backref revision 1
fs uuid a62e00e8-e94e-4200-8217-12444de93c2e
chunk uuid cecbd0f7-9ca0-441e-ae9f-f782f9732bd8
        item 0 key (16140901064495857664 INODE_ITEM 0) itemoff 3955 itemsize 40
                generation 0 transid 0 size 0 nbytes 17592186044416
                block group 0 mode 52667 links 33 uid 0 gid 2104132511 rdev 94223634821136
                sequence 100305 flags 0x2409000(none)
                atime 0.0 (1970-01-01 08:00:00)
                ctime 2973280098083405823.4294967295 (-269783007-01-01 21:37:03)
                mtime 18446744071572723616.4026825121 (1902-04-16 12:40:00)
                otime 9249929404488876031.4294967295 (622322949-04-16 04:25:58)
        item 1 key (1 DEV_EXTENT 12582912) itemoff 3907 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 12582912 length 8388608
                chunk_tree_uuid cecbd0f7-9ca0-441e-ae9f-f782f9732bd8
========================================================================
The corrupted leaf of device tree has an inode item. The leaf passed
checksum and others checks in validate_extent_buffer until check_leaf_item().
Because of the key type BTRFS_INODE_ITEM, check_inode_item() is called even we
are in the device tree. Since the
item offset + sizeof(struct btrfs_inode_item) > eb->len, out-of-bounds access
is triggered.

The item end vs leaf boundary check has been done before
check_leaf_item(), so fix it by checking item size in check_inode_item()
before access of the inode item in extent buffer.

Other check functions except check_dev_item() in check_leaf_item()
has their item size checks.
The commit for check_dev_item() is followed.

No regression observed during running xfstests.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215299
Cc: Wenqing Liu <wenqingliu0120@gmail.com>
Signed-off-by: Su Yue <l@damenly.su>
---
 fs/btrfs/tree-checker.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 72e1c942197d..2978fc89c093 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1007,6 +1007,7 @@ static int check_inode_item(struct extent_buffer *leaf,
 	struct btrfs_inode_item *iitem;
 	u64 super_gen = btrfs_super_generation(fs_info->super_copy);
 	u32 valid_mask = (S_IFMT | S_ISUID | S_ISGID | S_ISVTX | 0777);
+	u32 item_size = btrfs_item_size(leaf, slot);
 	u32 mode;
 	int ret;
 	u32 flags;
@@ -1016,6 +1017,12 @@ static int check_inode_item(struct extent_buffer *leaf,
 	if (unlikely(ret < 0))
 		return ret;
 
+	if (unlikely(item_size != sizeof(*iitem))) {
+		generic_err(leaf, slot, "invalid item size: has=%u expect=%zu",
+			    item_size, sizeof(*iitem));
+		return -EUCLEAN;
+	}
+
 	iitem = btrfs_item_ptr(leaf, slot, struct btrfs_inode_item);
 
 	/* Here we use super block generation + 1 to handle log tree */
-- 
2.34.1

