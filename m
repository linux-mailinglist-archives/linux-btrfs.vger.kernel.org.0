Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DD424FF6C
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 16:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHXOAy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 10:00:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:46292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgHXOAx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 10:00:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6EB78B163;
        Mon, 24 Aug 2020 14:01:21 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs-progs: check: Fix error reporting on root inode
Date:   Mon, 24 Aug 2020 17:00:49 +0300
Message-Id: <20200824140049.28633-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If btrfs check detects an error on the root inode of a subvolume it
prints:

    Opening filesystem to check...
    Checking filesystem on /dev/vdc
    UUID: 4ac7a216-bf97-4c5f-9899-0f203c20d8af
    [1/7] checking root items
    [2/7] checking extents
    [3/7] checking free space cache
    [4/7] checking fs roots
    root 5 root dir 256 error
    ERROR: errors found in fs roots
    found 196608 bytes used, error(s) found
    total csum bytes: 0
    total tree bytes: 131072
    total fs tree bytes: 32768
    total extent tree bytes: 16384
    btree space waste bytes: 124376
    file data blocks allocated: 65536
     referenced 65536

This is not very helpful since there is no specific information about
the exact error. This is due to the fact that check_root_dir doesn't
set inode_record::errors accordingly. This patch rectifies this and now
the output would look like:

	[1/7] checking root items
	[2/7] checking extents
	[3/7] checking free space cache
	[4/7] checking fs roots
	root 5 inode 256 errors 2000, link count wrong
	ERROR: errors found in fs roots
	found 196608 bytes used, error(s) found
	total csum bytes: 0
	total tree bytes: 131072
	total fs tree bytes: 32768
	total extent tree bytes: 16384
	btree space waste bytes: 124376
	file data blocks allocated: 65536
	 referenced 65536

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 check/main.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/check/main.c b/check/main.c
index f93bd7d4ca70..c622caa8e04f 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1885,20 +1885,45 @@ static int check_root_dir(struct inode_record *rec)
 	struct inode_backref *backref;
 	int ret = -1;

-	if (!rec->found_inode_item || rec->errors)
+	if (rec->errors)
 		goto out;
-	if (rec->nlink != 1 || rec->found_link != 0)
+
+	if (!rec->found_inode_item) {
+		rec->errors |= I_ERR_NO_INODE_ITEM;
+		goto out;
+	}
+
+	if (rec->nlink != 1 || rec->found_link != 0) {
+		rec->errors |= I_ERR_LINK_COUNT_WRONG;
 		goto out;
-	if (list_empty(&rec->backrefs))
+	}
+
+	if (list_empty(&rec->backrefs)) {
+		rec->errors |= REF_ERR_NO_ROOT_BACKREF;
 		goto out;
+	}
+
 	backref = to_inode_backref(rec->backrefs.next);
-	if (!backref->found_inode_ref)
+	if (!backref->found_inode_ref) {
+		rec->errors |= REF_ERR_NO_INODE_REF;
 		goto out;
+	}
+
 	if (backref->index != 0 || backref->namelen != 2 ||
-	    memcmp(backref->name, "..", 2))
+	    memcmp(backref->name, "..", 2)) {
+		rec->errors |= I_ERR_ODD_DIR_ITEM;
+		goto out;
+	}
+
+	if (backref->found_dir_index) {
+		rec->errors |= REF_ERR_DUP_DIR_INDEX;
 		goto out;
-	if (backref->found_dir_index || backref->found_dir_item)
+	}
+
+	if (backref->found_dir_item) {
+		rec->errors |= REF_ERR_DUP_DIR_ITEM;
 		goto out;
+	}
 	ret = 0;
 out:
 	return ret;
@@ -2992,9 +3017,6 @@ static int check_inode_recs(struct btrfs_root *root,
 		}
 		ret = check_root_dir(rec);
 		if (ret) {
-			fprintf(stderr, "root %llu root dir %llu error\n",
-				(unsigned long long)root->root_key.objectid,
-				(unsigned long long)root_dirid);
 			print_inode_error(root, rec);
 			error++;
 		}
--
2.17.1

