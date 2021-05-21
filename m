Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1467C38C63E
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 14:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbhEUMK3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 08:10:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:58114 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230414AbhEUMKZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 08:10:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621598941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j4QrsrvA8hfyD5tRHtDEusF6hN5utT4VJlZTgfH/7NQ=;
        b=npGVHin77GD6/ie4L7pJvPiX+c0HzHhMIzjb7zYMyNKskkblIanE3SbuWyGc+c3yCnA9+r
        BSOTqCN00X43uvySiX/DLA4M8qpn6EosefBZlo8t6VP7En0xCqfHxjRQIF4stcdC8bUSfA
        nOxuKaRxLFA8p6m+KNJcJdiDISKOWDI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7B446AC11;
        Fri, 21 May 2021 12:09:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 334E3DA725; Fri, 21 May 2021 14:06:27 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/6] btrfs: protect exclusive_operation by super_lock
Date:   Fri, 21 May 2021 14:06:27 +0200
Message-Id: <27c5165b8de26ab98948c0345de3f8ddd955c388.1621526221.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1621526221.git.dsterba@suse.com>
References: <cover.1621526221.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The exclusive operation is now atomically checked and set using bit
operations. Switch it to protection by spinlock. The super block lock is
not frequently used and adding a new lock seems like an overkill so it
should be safe to reuse it.

The reason to use spinlock is to enhance the locking context so more
checks can be done, eg. allowing the same exclusive operation enter
the exclop section and cancel the running one. This will be used for
resize and device delete.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h |  4 ++--
 fs/btrfs/ioctl.c | 16 +++++++++++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 938d8ebf4cf3..a142e56b6b9a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -992,8 +992,8 @@ struct btrfs_fs_info {
 	 */
 	int send_in_progress;
 
-	/* Type of exclusive operation running */
-	unsigned long exclusive_operation;
+	/* Type of exclusive operation running, protected by super_lock */
+	enum btrfs_exclusive_operation exclusive_operation;
 
 	/*
 	 * Zone size > 0 when in ZONED mode, otherwise it's used for a check
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a7739461533d..c4e710ea08ba 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -353,15 +353,29 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 	return ret;
 }
 
+/*
+ * Start exclusive operation @type, return true on success
+ */
 bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
 			enum btrfs_exclusive_operation type)
 {
-	return !cmpxchg(&fs_info->exclusive_operation, BTRFS_EXCLOP_NONE, type);
+	bool ret = false;
+
+	spin_lock(&fs_info->super_lock);
+	if (fs_info->exclusive_operation == BTRFS_EXCLOP_NONE) {
+		fs_info->exclusive_operation = type;
+		ret = true;
+	}
+	spin_unlock(&fs_info->super_lock);
+
+	return ret;
 }
 
 void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
 {
+	spin_lock(&fs_info->super_lock);
 	WRITE_ONCE(fs_info->exclusive_operation, BTRFS_EXCLOP_NONE);
+	spin_unlock(&fs_info->super_lock);
 	sysfs_notify(&fs_info->fs_devices->fsid_kobj, NULL, "exclusive_operation");
 }
 
-- 
2.29.2

