Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079AE38C642
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 14:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbhEUMKj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 08:10:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:58190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230383AbhEUMKe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 08:10:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621598948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6zxP6uUQwBN68hgPf9Ht9T/NtA1vibYMu2Z0tFhMuZc=;
        b=N5i5JH+RbPXVV+6bu0FCvOcucNQWDZviVfxzVEgXz/c9anJCrOfZYV3EjP1VICB00/Nh7G
        926GF3ClWSdczKagg7QsHYXplubtXQm7FQChtBtaFxBw/vPf6cBjX01fGxCAcg353YnZgV
        1EEohEu17KqPnzREXHBXvvwkL8T7xmI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6F7B2AAFD;
        Fri, 21 May 2021 12:09:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 285A6DA725; Fri, 21 May 2021 14:06:34 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/6] btrfs: add wrapper for conditional start of exclusive operation
Date:   Fri, 21 May 2021 14:06:34 +0200
Message-Id: <fe9738eb5db055e06eafb178bf6aea41c48b2890.1621526221.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1621526221.git.dsterba@suse.com>
References: <cover.1621526221.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To support optional cancelation of some operations, add helper that will
wrap all the combinations. In normal mode it's same as
btrfs_exclop_start, in cancelation mode it checks if it's already
running and request cancelation and waits until completion.

The error codes can be returned to to user space and semantics is not
changed, adding ECANCELED. This should be evaluated as an error and that
the operation has not completed and the operation should be restarted
or the filesystem status reviewed.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index cacd6ee17d8e..c75ccadf23dc 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1600,6 +1600,48 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 	return ret;
 }
 
+/*
+ * Try to start exclusive operation @type or cancel it if it's running.
+ *
+ * Return:
+ *   0        - normal mode, newly claimed op started
+ *  >0        - normal mode, something else is running,
+ *              return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS to user space
+ * ECANCELED  - cancel mode, successful cancel
+ * ENOTCONN   - cancel mode, operation not running anymore
+ */
+static int exclop_start_or_cancel_reloc(struct btrfs_fs_info *fs_info,
+			enum btrfs_exclusive_operation type, bool cancel)
+{
+	if (!cancel) {
+		/* Start normal op */
+		if (!btrfs_exclop_start(fs_info, type))
+			return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
+		/* Exclusive operation is now claimed */
+		return 0;
+	}
+
+	/* Cancel running op */
+	if (btrfs_exclop_start_try_lock(fs_info, type)) {
+		/*
+		 * This blocks any exclop finish from setting it to NONE, so we
+		 * request cancelation. Either it runs and we will wait for it,
+		 * or it has finished and no waiting will happen.
+		 */
+		atomic_inc(&fs_info->reloc_cancel_req);
+		btrfs_exclop_start_unlock(fs_info);
+
+		if (test_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags))
+			wait_on_bit(&fs_info->flags, BTRFS_FS_RELOC_RUNNING,
+				    TASK_INTERRUPTIBLE);
+
+		return -ECANCELED;
+	}
+
+	/* Something else is running or none */
+	return -ENOTCONN;
+}
+
 static noinline int btrfs_ioctl_resize(struct file *file,
 					void __user *arg)
 {
-- 
2.29.2

