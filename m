Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 254C212FA2A
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 17:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgACQQH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 11:16:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:59522 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbgACQQH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jan 2020 11:16:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C9EB0AEFD;
        Fri,  3 Jan 2020 16:16:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3B734DA795; Fri,  3 Jan 2020 17:15:56 +0100 (CET)
Date:   Fri, 3 Jan 2020 17:15:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: fixes for relocation to avoid KASAN reports
Message-ID: <20200103161556.GB3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191211050004.18414-1-wqu@suse.com>
 <20191211153429.GO3929@twin.jikos.cz>
 <74a07fa4-ca35-57ee-2cd9-586a8db04712@gmx.com>
 <20200103155259.GA3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103155259.GA3929@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 03, 2020 at 04:52:59PM +0100, David Sterba wrote:
> So it's one bit vs refcount and a lock. For the backports I'd go with
> the bit, but this needs the barriers as mentioned in my previous reply.
> Can you please update the patches?

The idea is in the diff below (compile tested only). I found one more
case that was not addressed by your patches, it's in
btrfs_update_reloc_root.

Given that the type of the fix is the same, I'd rather do that in one
patch. The reported stack traces are more or less the same.

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index af4dd49a71c7..aeba3a7506e1 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -517,6 +517,15 @@ static int update_backref_cache(struct btrfs_trans_handle *trans,
 	return 1;
 }
 
+static bool have_reloc_root(struct btrfs_root *root)
+{
+	smp_mb__before_atomic();
+	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
+		return false;
+	if (!root->reloc_root)
+		return false;
+	return true;
+}
 
 static int should_ignore_root(struct btrfs_root *root)
 {
@@ -525,9 +534,9 @@ static int should_ignore_root(struct btrfs_root *root)
 	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
 		return 0;
 
-	reloc_root = root->reloc_root;
-	if (!reloc_root)
+	if (!have_reloc_root(root))
 		return 0;
+	reloc_root = root->reloc_root;
 
 	if (btrfs_root_last_snapshot(&reloc_root->root_item) ==
 	    root->fs_info->running_transaction->transid - 1)
@@ -1439,6 +1448,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 	 * The subvolume has reloc tree but the swap is finished, no need to
 	 * create/update the dead reloc tree
 	 */
+	smp_mb__before_atomic();
 	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
 		return 0;
 
@@ -1478,8 +1488,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 	struct btrfs_root_item *root_item;
 	int ret;
 
-	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state) ||
-	    !root->reloc_root)
+	if (!have_reloc_root(root))
 		goto out;
 
 	reloc_root = root->reloc_root;
@@ -1489,6 +1498,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 	if (fs_info->reloc_ctl->merge_reloc_tree &&
 	    btrfs_root_refs(root_item) == 0) {
 		set_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
+		smp_mb__after_atomic();
 		__del_reloc_root(reloc_root);
 	}
 
@@ -2201,6 +2211,7 @@ static int clean_dirty_subvols(struct reloc_control *rc)
 				if (ret2 < 0 && !ret)
 					ret = ret2;
 			}
+			smp_mb__before_atomic();
 			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
 			btrfs_put_fs_root(root);
 		} else {
@@ -4730,7 +4741,7 @@ void btrfs_reloc_pre_snapshot(struct btrfs_pending_snapshot *pending,
 	struct btrfs_root *root = pending->root;
 	struct reloc_control *rc = root->fs_info->reloc_ctl;
 
-	if (!root->reloc_root || !rc)
+	if (!rc || !have_reloc_root(root))
 		return;
 
 	if (!rc->merge_reloc_tree)
@@ -4764,7 +4775,7 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 	struct reloc_control *rc = root->fs_info->reloc_ctl;
 	int ret;
 
-	if (!root->reloc_root || !rc)
+	if (!rc || !have_reloc_root(root))
 		return 0;
 
 	rc = root->fs_info->reloc_ctl;
