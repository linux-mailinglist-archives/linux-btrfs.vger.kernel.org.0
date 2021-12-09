Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D67D46E300
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 08:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhLIHQI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 02:16:08 -0500
Received: from mail-m975.mail.163.com ([123.126.97.5]:36470 "EHLO
        mail-m975.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbhLIHQI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Dec 2021 02:16:08 -0500
X-Greylist: delayed 909 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2021 02:16:07 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=a6cGZ
        uAGQNBv0FdBCwSFqBOabJW7dc4x/t81zageSok=; b=KoZehCZXueahXAGzIHbZ2
        vlnmxmkFWZkmBPLns7mCp30zuhwaTsstlNGN/xspByeZDgIZm+oTCkzMB2Sf8UoI
        V45Ub5rRz+/IJj/Y5Y0f/u4f4gcOixBJVqvQqQTF+FGL3ZWtbBTHoi9rGlyk6SCU
        Bf8BhnsFB/ocPIqK/6XRGM=
Received: from localhost.localdomain (unknown [218.106.182.227])
        by smtp5 (Coremail) with SMTP id HdxpCgCXwyGhqLFhEEo+Aw--.56043S4;
        Thu, 09 Dec 2021 14:56:52 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] btrfs: Fix memory leak in __add_inode_ref()
Date:   Thu,  9 Dec 2021 14:56:31 +0800
Message-Id: <20211209065631.124586-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgCXwyGhqLFhEEo+Aw--.56043S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW8Jw4rGr1xuF47GF4DJwb_yoW8uFWDpr
        Z7Gr15CFWaqF98KF4kJws5GryFyw4kGr4fGryavws7ur4kXr1FyFyjy3W5KF1fJrZ5Zr4U
        ZF4UJF1Y93Wqvw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jgWrXUUUUU=
X-Originating-IP: [218.106.182.227]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/xtbBORVkjF-PKR0qPQAAs3
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Line 1169 (#3) allocates a memory chunk for victim_name by kmalloc(),
but  when the function returns in line 1184 (#4) victim_name allcoated
by line 1169 (#3) is not freed, which will lead to a memory leak.
There is a similar snippet of code in this function as allocating a memory
chunk for victim_name in line 1104 (#1) as well as releasing the memory
in line 1116 (#2).

We should kfree() victim_name when the return value of backref_in_log()
is less than zero and before the function returns in line 1184 (#4).

1057 static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
1058 				  struct btrfs_root *root,
1059 				  struct btrfs_path *path,
1060 				  struct btrfs_root *log_root,
1061 				  struct btrfs_inode *dir,
1062 				  struct btrfs_inode *inode,
1063 				  u64 inode_objectid, u64 parent_objectid,
1064 				  u64 ref_index, char *name, int namelen,
1065 				  int *search_done)
1066 {

1104 	victim_name = kmalloc(victim_name_len, GFP_NOFS);
	// #1: kmalloc (victim_name-1)
1105 	if (!victim_name)
1106 		return -ENOMEM;

1112	ret = backref_in_log(log_root, &search_key,
1113			parent_objectid, victim_name,
1114			victim_name_len);
1115	if (ret < 0) {
1116		kfree(victim_name); // #2: kfree (victim_name-1)
1117		return ret;
1118	} else if (!ret) {

1169 	victim_name = kmalloc(victim_name_len, GFP_NOFS);
	// #3: kmalloc (victim_name-2)
1170 	if (!victim_name)
1171 		return -ENOMEM;

1180 	ret = backref_in_log(log_root, &search_key,
1181 			parent_objectid, victim_name,
1182 			victim_name_len);
1183 	if (ret < 0) {
1184 		return ret; // #4: missing kfree (victim_name-2)
1185 	} else if (!ret) {

1241 	return 0;
1242 }

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 fs/btrfs/tree-log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8ab33caf016f..d373fec55521 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1181,6 +1181,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 					     parent_objectid, victim_name,
 					     victim_name_len);
 			if (ret < 0) {
+				kfree(victim_name);
 				return ret;
 			} else if (!ret) {
 				ret = -ENOENT;
-- 
2.25.1

