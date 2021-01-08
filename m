Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350982EF5AE
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jan 2021 17:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbhAHQ0A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jan 2021 11:26:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:53604 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbhAHQZ7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 Jan 2021 11:25:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610123119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=isNmfgWYVhJ76cmNB2HtkGNqXo2OniOnwrY9Q/NOTY0=;
        b=XvNHZtvxL3lGCq2CLrekMc2vqSsrs4VscLlOS1KjWiEm60nbXZXRyEoZfajWrXRdpPmvuN
        JWBn3RGJU4nZg0p2whhNBeWu44ComRs6UpQXXkrJdcqu88UCbvYwNFHQUpE+Z3vuyIKbpU
        YDdEaRwumymLhpfs88JQg1WTEBhg5/k=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DE628AD57;
        Fri,  8 Jan 2021 16:25:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 60A6CDA6E9; Fri,  8 Jan 2021 17:23:28 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: no need to run delayed refs after commit_fs_roots
Date:   Fri,  8 Jan 2021 17:23:27 +0100
Message-Id: <20210108162327.15028-1-dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The inode number cache has been removed in this dev cycle, there's one
more leftover. We don't need to run the delayed refs again after
commit_fs_roots as stated in the comment, because btrfs_save_ino_cache
is no more since 5297199a8bca ("btrfs: remove inode number cache
feature").

Nothing else between commit_fs_roots and btrfs_qgroup_account_extents
could create new delayed refs so the qgroup consistency should be safe.

Signed-off-by: David Sterba <dsterba@suse.com>
---

There's the patchset
https://lore.kernel.org/linux-btrfs/cover.1608319304.git.josef@toxicpanda.com/
to remove several other run delayed ref calls. I haven't spotted any
problems so this patch can go in now as it's related to the inode cache
removal. The patchset unifies the location of delayed refs calls so this
one would be an outlier anyway.

 fs/btrfs/transaction.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 4ffe66164fa3..3bcb5444536e 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2265,14 +2265,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	 */
 	btrfs_free_log_root_tree(trans, fs_info);
 
-	/*
-	 * commit_fs_roots() can call btrfs_save_ino_cache(), which generates
-	 * new delayed refs. Must handle them or qgroup can be wrong.
-	 */
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
-	if (ret)
-		goto unlock_tree_log;
-
 	/*
 	 * Since fs roots are all committed, we can get a quite accurate
 	 * new_roots. So let's do quota accounting.
-- 
2.25.0

